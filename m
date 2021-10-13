Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE56C42C7F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 19:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbhJMRug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 13:50:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45472 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbhJMRuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 13:50:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D335F219E3;
        Wed, 13 Oct 2021 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634147281;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZYNocoBmvurC8mquKSx2bzwMNrE24S+yOe0f0IAJtk=;
        b=xu3K78VIyshiH4lCJdPelKPLPHPW7hsm3FOsulRwl3TT4KVIn98rnJD4SMeQ6rLxsBTmHF
        tIAJZTNPzVygIaSpaNsNBtgJIQBrlxaOkpHvoXHDnL5dGThEvdB9+tNRomXKWQ5tqcWiYE
        RuOd6seS38pgGcOw8RnwaCMULzeln7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634147281;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZYNocoBmvurC8mquKSx2bzwMNrE24S+yOe0f0IAJtk=;
        b=mUYMSQ+gOaXuDAz75PwQMpDgUBAYGCAX3s3GuoWLA+4SLi/ygswc14tMZqSml7rWgNsdzw
        2wHuam37tAbSdYBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CC873A3B81;
        Wed, 13 Oct 2021 17:48:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85921DA7A3; Wed, 13 Oct 2021 19:47:37 +0200 (CEST)
Date:   Wed, 13 Oct 2021 19:47:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v4 3/6] btrfs: do not call close_fs_devices in
 btrfs_rm_device
Message-ID: <20211013174737.GI9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
 <326bb4ecde587f0f3f4884b65d17951661a0ca77.1633464631.git.josef@toxicpanda.com>
 <c02ba409-9669-df51-b51f-20b7909b21af@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c02ba409-9669-df51-b51f-20b7909b21af@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 06, 2021 at 09:40:00AM +0300, Nikolay Borisov wrote:
> 
> 
> On 5.10.21 г. 23:12, Josef Bacik wrote:
> > There's a subtle case where if we're removing the seed device from a
> > file system we need to free its private copy of the fs_devices.  However
> > we do not need to call close_fs_devices(), because at this point there
> > are no devices left to close as we've closed the last one.  The only
> > thing that close_fs_devices() does is decrement ->opened, which should
> > be 1.  We want to avoid calling close_fs_devices() here because it has a
> > lockdep_assert_held(&uuid_mutex), and we are going to stop holding the
> > uuid_mutex in this path.
> > 
> > So simply decrement the  ->opened counter like we should, and then clean
> > up like normal.  Also add a comment explaining what we're doing here as
> > I initially removed this code erroneously.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/volumes.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 0941f61d8071..5f19d0863094 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -2211,9 +2211,16 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
> >  	synchronize_rcu();
> >  	btrfs_free_device(device);
> >  
> > +	/*
> > +	 * This can happen if cur_devices is the private seed devices list.  We
> > +	 * cannot call close_fs_devices() here because it expects the uuid_mutex
> > +	 * to be held, but in fact we don't need that for the private
> > +	 * seed_devices, we can simply decrement cur_devices->opened and then
> > +	 * remove it from our list and free the fs_devices.
> > +	 */
> >  	if (cur_devices->num_devices == 0) {
> >  		list_del_init(&cur_devices->seed_list);
> > -		close_fs_devices(cur_devices);
> > +		cur_devices->opened--;
> 
> I think an ASSERT(opened == 1) is warranted as this is a special case
> and there is very specific expectation of the state of opened.

Assert added, not tested yet.

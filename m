Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6F1455774
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 09:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbhKRI61 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 03:58:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49490 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244903AbhKRI5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 03:57:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7003121138;
        Thu, 18 Nov 2021 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637225669;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MKDGlVQAhJWNHvDONuLhn/LC+vjCV768a6iclsJ0q6g=;
        b=0yRIIC6ni42n0wj6/lUlPKoE/c7MBaQbxLCV8RbVckmqwtXhcSfiL2dwZkqK2aD6rjSxgw
        u2VcqLge9k1n1UffgER0NRr8FZrTon95M3pt7rPnUvAc7N0JddjbinXkLqu0aiYCMLyIK3
        2653Jc4i5yikebAhY2uTIgga6LCFr6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637225669;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MKDGlVQAhJWNHvDONuLhn/LC+vjCV768a6iclsJ0q6g=;
        b=plH+lUeOdnMlIh/OtKlXzyD0vEv6LfrPyP4s2FG3FiYo8ezZBTQv5Fss5nkcdP+Paw4HoB
        iicl0BOEJcmuJ7BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 521CAA3B81;
        Thu, 18 Nov 2021 08:54:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0EB3BDA799; Thu, 18 Nov 2021 09:54:24 +0100 (CET)
Date:   Thu, 18 Nov 2021 09:54:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 2/7] btrfs: check for priority ticket granting before
 flushing
Message-ID: <20211118085424.GV28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, David Sterba <dsterba@suse.com>
References: <cover.1636470628.git.josef@toxicpanda.com>
 <efd7030290cfce311cea39f381b2e5cb38761336.1636470628.git.josef@toxicpanda.com>
 <6d27ae92-b7a7-4882-e121-10e524da346a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d27ae92-b7a7-4882-e121-10e524da346a@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 17, 2021 at 07:04:25PM +0200, Nikolay Borisov wrote:
> 
> 
> On 9.11.21 г. 17:12, Josef Bacik wrote:
> > Since we're dropping locks before we enter the priority flushing loops
> > we could have had our ticket granted before we got the space_info->lock.
> > So add this check to avoid doing some extra flushing in the priority
> > flushing cases.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/space-info.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 9d6048f54097..9a362f3a6df4 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -1264,7 +1264,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
> >  
> >  	spin_lock(&space_info->lock);
> >  	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
> > -	if (!to_reclaim) {
> > +	if (!to_reclaim || ticket->bytes == 0) {
> David,
> 
> After speaking with josef it would seem the !to_reclaim condition is
> gratuitous so can be removed, care to squash this in the patch?

Sure, commit updated, thanks.

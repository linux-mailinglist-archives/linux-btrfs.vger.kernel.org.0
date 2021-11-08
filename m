Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF9449CD6
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 21:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhKHUFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 15:05:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47450 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhKHUFi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 15:05:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 02B911FD50;
        Mon,  8 Nov 2021 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636401773;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMMkeBv0FzSJxWZ1851mBGffQGUZblhE0UU2rxltRDE=;
        b=WP0OYt4YCq3k7/GSAU7QLDiaW/arjfRD++X+DMSjZ6lrOPQnns9Xux+LwucdvFhOEdmfaK
        4RHB9FZKXXGhMXT4fPUKdrQS1UjK8UWzZLP0RhURUvJgARBcIzYJzjJQh1M7Z2Ck4NUc04
        FZYaTz0jz8pYId5gQI/CAHG5EBXn6zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636401773;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMMkeBv0FzSJxWZ1851mBGffQGUZblhE0UU2rxltRDE=;
        b=c5aN+Wv+Z1kb58Rg5ug1DOFGeXNtj65AQet3xsacd8u9AAwoqaqD9p8NVMT5EZv7rmw8Lr
        n88cUcCOVi+3ipCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EF7F5A3B83;
        Mon,  8 Nov 2021 20:02:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52F41DA799; Mon,  8 Nov 2021 21:02:14 +0100 (CET)
Date:   Mon, 8 Nov 2021 21:02:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH v8] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
Message-ID: <20211108200214.GO28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <20211013080137.Bbt1omPCnM-ICZCnqrgjTq-2Rj4YbsM6OCm1MMBtG4o@z>
 <YWhNG9SowUp5nTxz@localhost.localdomain>
 <1a168ce1-20b6-aabf-76ae-ea9914264f06@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a168ce1-20b6-aabf-76ae-ea9914264f06@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 15, 2021 at 06:34:51AM +0800, Anand Jain wrote:
> On 14/10/2021 23:30, Josef Bacik wrote:
> > On Wed, Oct 13, 2021 at 04:01:37PM +0800, Anand Jain wrote:
> >>   	seed_devices = alloc_fs_devices(NULL, NULL);
> >>   	if (IS_ERR(seed_devices))
> >> -		return PTR_ERR(seed_devices);
> >> +		return seed_devices;
> >>   
> >>   	/*
> >>   	 * It's necessary to retain a copy of the original seed fs_devices in
> >> @@ -2411,9 +2404,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
> >>   	old_devices = clone_fs_devices(fs_devices);
> >>   	if (IS_ERR(old_devices)) {
> >>   		kfree(seed_devices);
> >> -		return PTR_ERR(old_devices);
> >> +		return old_devices;
> >>   	}
> >>   
> >> +	lockdep_assert_held(&uuid_mutex);
> > 
> > There's no reason to move this down here, you can leave it at the top of this
> > function.  Fix that up and you can add
> 
>   I thought placing the lockdep_assert_held()s just before the critical
>   section that wanted the lock makes it easy to reason. In this case, it
>   is the next line that is
> 
>        list_add(&old_devices->fs_list, &fs_uuids);
> 
>   No? I can move it back if it is unnecessary.

I think the most common placement is near the top of the function so
it's immediately visible that the lock is assumed to be held. If it's
too deep in the function, it could be overlooked.

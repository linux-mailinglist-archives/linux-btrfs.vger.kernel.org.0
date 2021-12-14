Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D0474330
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 14:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhLNNJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 08:09:24 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50368 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhLNNJX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 08:09:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 832621F37C;
        Tue, 14 Dec 2021 13:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639487362;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JkaUn1Oh6VCgLaCva8C+EpDGwo0cm68t3s8sIEw191M=;
        b=WLQPttYNauriYznntTiegsQAUxK6ljecORn+waMWCtMoJCNd01EBsYZlHnYWNwAiaqjjw/
        3Jss7k/AGKS+Utq9XcRENhG44JWfa5DG8Y+gJXuimwcwZJAvLI1lUAN2L5z2x2V9cj8jiS
        sUao2XieISdR7ua/iJ3I9LeLzM15JoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639487362;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JkaUn1Oh6VCgLaCva8C+EpDGwo0cm68t3s8sIEw191M=;
        b=UEok7hzsQ/NzOP9Mam3S4gox9LvopgYtUuMBsnDl5f/+1B7QX5icxoNrWHF/wnWbsaFEVM
        bGXkwXfgMsbR9KBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7CD81A3B84;
        Tue, 14 Dec 2021 13:09:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80A34DA781; Tue, 14 Dec 2021 14:09:04 +0100 (CET)
Date:   Tue, 14 Dec 2021 14:09:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix missing last dir item offset update when
 logging directory
Message-ID: <20211214130904.GS28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <024e44a8e8d1fa7e15eb91c6891bd229b2b4210d.1639481280.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024e44a8e8d1fa7e15eb91c6891bd229b2b4210d.1639481280.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 11:29:01AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When logging a directory, once we finish processing a leaf that is full
> of dir items, if we find the next leaf was not modified in the current
> transaction, we grab the first key of that next leaf and log it as to
> mark the end of a key range boundary.
> 
> However we did not update the value of ctx->last_dir_item_offset, which
> tracks the offset of the last logged key. This can result in subsequent
> logging of the same directory in the current transaction to not realize
> that key was already logged, and then add it to the middle of a batch
> that starts with a lower key, resulting later in a leaf with one key
> that is duplicated and at non-consecutive slots. When that happens we get
> an error later when writing out the leaf, reporting that there is a pair
> of keys in wrong order. The report is something like the following:
> 
> Dec 13 21:44:50 kernel: BTRFS critical (device dm-0): corrupt leaf:
> root=18446744073709551610 block=118444032 slot=21, bad key order, prev
> (704687 84 4146773349) current (704687 84 1063561078)
> Dec 13 21:44:50 kernel: BTRFS info (device dm-0): leaf 118444032 gen
> 91449 total ptrs 39 free space 546 owner 18446744073709551610
> Dec 13 21:44:50 kernel:         item 0 key (704687 1 0) itemoff 3835
> itemsize 160
> Dec 13 21:44:50 kernel:                 inode generation 35532 size
> 1026 mode 40755
> Dec 13 21:44:50 kernel:         item 1 key (704687 12 704685) itemoff
> 3822 itemsize 13
> Dec 13 21:44:50 kernel:         item 2 key (704687 24 3817753667)
> itemoff 3736 itemsize 86
> Dec 13 21:44:50 kernel:         item 3 key (704687 60 0) itemoff 3728 itemsize 8
> Dec 13 21:44:50 kernel:         item 4 key (704687 72 0) itemoff 3720 itemsize 8
> Dec 13 21:44:50 kernel:         item 5 key (704687 84 140445108)
> itemoff 3666 itemsize 54
> Dec 13 21:44:50 kernel:                 dir oid 704793 type 1
> Dec 13 21:44:50 kernel:         item 6 key (704687 84 298800632)
> itemoff 3599 itemsize 67
> Dec 13 21:44:50 kernel:                 dir oid 707849 type 2
> Dec 13 21:44:50 kernel:         item 7 key (704687 84 476147658)
> itemoff 3532 itemsize 67
> Dec 13 21:44:50 kernel:                 dir oid 707901 type 2
> Dec 13 21:44:50 kernel:         item 8 key (704687 84 633818382)
> itemoff 3471 itemsize 61
> Dec 13 21:44:50 kernel:                 dir oid 704694 type 2
> Dec 13 21:44:50 kernel:         item 9 key (704687 84 654256665)
> itemoff 3403 itemsize 68
> Dec 13 21:44:50 kernel:                 dir oid 707841 type 1
> Dec 13 21:44:50 kernel:         item 10 key (704687 84 995843418)
> itemoff 3331 itemsize 72
> Dec 13 21:44:50 kernel:                 dir oid 2167736 type 1
> Dec 13 21:44:50 kernel:         item 11 key (704687 84 1063561078)
> itemoff 3278 itemsize 53
> Dec 13 21:44:50 kernel:                 dir oid 704799 type 2
> Dec 13 21:44:50 kernel:         item 12 key (704687 84 1101156010)
> itemoff 3225 itemsize 53
> Dec 13 21:44:50 kernel:                 dir oid 704696 type 1
> Dec 13 21:44:50 kernel:         item 13 key (704687 84 2521936574)
> itemoff 3173 itemsize 52
> Dec 13 21:44:50 kernel:                 dir oid 704704 type 2
> Dec 13 21:44:50 kernel:         item 14 key (704687 84 2618368432)
> itemoff 3112 itemsize 61
> Dec 13 21:44:50 kernel:                 dir oid 704738 type 1
> Dec 13 21:44:50 kernel:         item 15 key (704687 84 2676316190)
> itemoff 3046 itemsize 66
> Dec 13 21:44:50 kernel:                 dir oid 2167729 type 1
> Dec 13 21:44:50 kernel:         item 16 key (704687 84 3319104192)
> itemoff 2986 itemsize 60
> Dec 13 21:44:50 kernel:                 dir oid 704745 type 2
> Dec 13 21:44:50 kernel:         item 17 key (704687 84 3908046265)
> itemoff 2929 itemsize 57
> Dec 13 21:44:50 kernel:                 dir oid 2167734 type 1
> Dec 13 21:44:50 kernel:         item 18 key (704687 84 3945713089)
> itemoff 2857 itemsize 72
> Dec 13 21:44:50 kernel:                 dir oid 2167730 type 1
> Dec 13 21:44:50 kernel:         item 19 key (704687 84 4077169308)
> itemoff 2795 itemsize 62
> Dec 13 21:44:50 kernel:                 dir oid 704688 type 1
> Dec 13 21:44:50 kernel:         item 20 key (704687 84 4146773349)
> itemoff 2727 itemsize 68
> Dec 13 21:44:50 kernel:                 dir oid 707892 type 1
> Dec 13 21:44:50 kernel:         item 21 key (704687 84 1063561078)
> itemoff 2674 itemsize 53
> Dec 13 21:44:50 kernel:                 dir oid 704799 type 2
> Dec 13 21:44:50 kernel:         item 22 key (704687 96 2) itemoff 2612
> itemsize 62
> Dec 13 21:44:50 kernel:         item 23 key (704687 96 6) itemoff 2551
> itemsize 61
> Dec 13 21:44:50 kernel:         item 24 key (704687 96 7) itemoff 2498
> itemsize 53
> Dec 13 21:44:50 kernel:         item 25 key (704687 96 12) itemoff
> 2446 itemsize 52
> Dec 13 21:44:50 kernel:         item 26 key (704687 96 14) itemoff
> 2385 itemsize 61
> Dec 13 21:44:50 kernel:         item 27 key (704687 96 18) itemoff
> 2325 itemsize 60
> Dec 13 21:44:50 kernel:         item 28 key (704687 96 24) itemoff
> 2271 itemsize 54
> Dec 13 21:44:50 kernel:         item 29 key (704687 96 28) itemoff
> 2218 itemsize 53
> Dec 13 21:44:50 kernel:         item 30 key (704687 96 62) itemoff
> 2150 itemsize 68
> Dec 13 21:44:50 kernel:         item 31 key (704687 96 66) itemoff
> 2083 itemsize 67
> Dec 13 21:44:50 kernel:         item 32 key (704687 96 75) itemoff
> 2015 itemsize 68
> Dec 13 21:44:50 kernel:         item 33 key (704687 96 79) itemoff
> 1948 itemsize 67
> Dec 13 21:44:50 kernel:         item 34 key (704687 96 82) itemoff
> 1882 itemsize 66
> Dec 13 21:44:50 kernel:         item 35 key (704687 96 83) itemoff
> 1810 itemsize 72
> Dec 13 21:44:50 kernel:         item 36 key (704687 96 85) itemoff
> 1753 itemsize 57
> Dec 13 21:44:50 kernel:         item 37 key (704687 96 87) itemoff
> 1681 itemsize 72
> Dec 13 21:44:50 kernel:         item 38 key (704694 1 0) itemoff 1521
> itemsize 160
> Dec 13 21:44:50 kernel:                 inode generation 35534 size 30
> mode 40755
> Dec 13 21:44:50 kernel: BTRFS error (device dm-0): block=118444032
> write time tree block corruption detected
> 
> So fix that by adding the missing update of ctx->last_dir_item_offset with
> the offset of the boundary key.
> 
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJCQCtT+RSzpUjbMq+UfzNUMe1X5+1G+DnAGbHC=OZ=iRS24jg@mail.gmail.com/
> Fixes: dc2872247ec0ca ("btrfs: keep track of the last logged keys when logging a directory")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

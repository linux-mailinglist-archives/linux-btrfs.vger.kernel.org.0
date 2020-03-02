Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF6175C9C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 15:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCBOKq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 09:10:46 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41988 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgCBOKq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 09:10:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id r6so3011009qtt.9
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 06:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OGduM07nvxDuk6ABaRKQ0NQa9kqcHRGx3QkXAcUQ2tE=;
        b=eUaGGCa8PKRxAXHxR2fj4ESXPp5X3UA9JVPdIXr6sqhynMYNeG8dDPhexWT6ZAETxx
         8nZnHkSTqtnOWZbp+/9rlKjZtxFFzS4e3W3otfx0qAH9bfFK7xEx3ivB/ymLCK3BxCGS
         hq/8BNrnJQrA0A0JDXf/TgIDQqezUwN21HoHnukoTGlsDsd37NgolvSXmviiJsDTx9KU
         kvF6EsSEpeDZ8uwgRb0Lx1JeYZFh1sIUn+ksSBjmV3HJUyxobxQPQQe2leM23mKqnWuc
         /+oOIoHFGgYL3rFH2hWnAhim9an9ytXsMFeidPx3gRiq7oicgJKMwSuV/y5GIfusJl0o
         zqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OGduM07nvxDuk6ABaRKQ0NQa9kqcHRGx3QkXAcUQ2tE=;
        b=PQZ0FwNXBydsUOdonA657L1y2h/t/GOK3OWCLqzehtWmvSAN1EOyJ93lRnOm137DW9
         xt8GM8jIgr9N0gxT76e9qEvS5bX2LNWIjd4MPKxXImXHg0MFAIOtlYldY3on/3bLiZZq
         pOyC2DnzAthdTOTLrqbrLo0Kcj8k0jbfzjFPdACcem2RfZ1SRZOxIbdet5y8eKfw3XSE
         JV/vPv81E1S0byrZFfN3lBDpAT+6EfxM4CMzJFpMS2pq+8wgENt/F/iMmTLPXepz7yc7
         NamO9RTY84eBa9wbp5WvEfQqNnU4P83PJ4WHihibKYLW3nyGCYdb991v9XPZXLO00/Jr
         2AHA==
X-Gm-Message-State: ANhLgQ3XxY159kwY/RfG1aX8dNZn8gvuseum90SfwQVyV37pfwXQr7J+
        PVFQR6h1qJBGTyY3EuNAEJJW6F233Yo=
X-Google-Smtp-Source: ADFU+vutIjOLgbUErGf1T60h0zeMqLXRAKstcC05z9RDY6PllkjIKT7eOBk7BT8aDYHkNTY27e2MiA==
X-Received: by 2002:ac8:39c2:: with SMTP id v60mr1664834qte.211.1583158244308;
        Mon, 02 Mar 2020 06:10:44 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z6sm10307345qto.86.2020.03.02.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 06:10:43 -0800 (PST)
Date:   Mon, 2 Mar 2020 09:10:42 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Holger =?utf-8?Q?Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH][RESEND] btrfs: kill update_block_group_flags
Message-ID: <20200302141042.by7jjjokwttqfyzn@jbacik-mbp>
References: <20200117140826.42616-1-josef@toxicpanda.com>
 <2e16f37e-014e-6d86-76c6-801d6cb7bc20@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e16f37e-014e-6d86-76c6-801d6cb7bc20@applied-asynchrony.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 01, 2020 at 06:58:02PM +0100, Holger Hoffstätte wrote:
> On 1/17/20 3:08 PM, Josef Bacik wrote:
> > btrfs/061 has been failing consistently for me recently with a
> > transaction abort.  We run out of space in the system chunk array, which
> > means we've allocated way too many system chunks than we need.
> > 
> > Chris added this a long time ago for balance as a poor mans restriping.
> > If you had a single disk and then added another disk and then did a
> > balance, update_block_group_flags would then figure out which RAID level
> > you needed.
> > 
> > Fast forward to today and we have restriping behavior, so we can
> > explicitly tell the fs that we're trying to change the raid level.  This
> > is accomplished through the normal get_alloc_profile path.
> > 
> > Furthermore this code actually causes btrfs/061 to fail, because we do
> > things like mkfs -m dup -d single with multiple devices.  This trips
> > this check
> > 
> > alloc_flags = update_block_group_flags(fs_info, cache->flags);
> > if (alloc_flags != cache->flags) {
> > 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
> > 
> > in btrfs_inc_block_group_ro.  Because we're balancing and scrubbing, but
> > not actually restriping, we keep forcing chunk allocation of RAID1
> > chunks.  This eventually causes us to run out of system space and the
> > file system aborts and flips read only.
> > 
> > We don't need this poor mans restriping any more, simply use the normal
> > get_alloc_profile helper, which will get the correct alloc_flags and
> > thus make the right decision for chunk allocation.  This keeps us from
> > allocating a billion system chunks and falling over.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > - Just rebased onto misc-next.
> > 
> >   fs/btrfs/block-group.c | 52 ++----------------------------------------
> >   1 file changed, 2 insertions(+), 50 deletions(-)
> > 
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 7e71ec9682d0..77ec0597bd17 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -2132,54 +2132,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
> >   	return 0;
> >   }
> > -static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
> > -{
> > -	u64 num_devices;
> > -	u64 stripped;
> > -
> > -	/*
> > -	 * if restripe for this chunk_type is on pick target profile and
> > -	 * return, otherwise do the usual balance
> > -	 */
> > -	stripped = get_restripe_target(fs_info, flags);
> > -	if (stripped)
> > -		return extended_to_chunk(stripped);
> > -
> > -	num_devices = fs_info->fs_devices->rw_devices;
> > -
> > -	stripped = BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID56_MASK |
> > -		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
> > -
> > -	if (num_devices == 1) {
> > -		stripped |= BTRFS_BLOCK_GROUP_DUP;
> > -		stripped = flags & ~stripped;
> > -
> > -		/* turn raid0 into single device chunks */
> > -		if (flags & BTRFS_BLOCK_GROUP_RAID0)
> > -			return stripped;
> > -
> > -		/* turn mirroring into duplication */
> > -		if (flags & (BTRFS_BLOCK_GROUP_RAID1_MASK |
> > -			     BTRFS_BLOCK_GROUP_RAID10))
> > -			return stripped | BTRFS_BLOCK_GROUP_DUP;
> > -	} else {
> > -		/* they already had raid on here, just return */
> > -		if (flags & stripped)
> > -			return flags;
> > -
> > -		stripped |= BTRFS_BLOCK_GROUP_DUP;
> > -		stripped = flags & ~stripped;
> > -
> > -		/* switch duplicated blocks with raid1 */
> > -		if (flags & BTRFS_BLOCK_GROUP_DUP)
> > -			return stripped | BTRFS_BLOCK_GROUP_RAID1;
> > -
> > -		/* this is drive concat, leave it alone */
> > -	}
> > -
> > -	return flags;
> > -}
> > -
> >   /*
> >    * Mark one block group RO, can be called several times for the same block
> >    * group.
> > @@ -2225,7 +2177,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
> >   		 * If we are changing raid levels, try to allocate a
> >   		 * corresponding block group with the new raid level.
> >   		 */
> > -		alloc_flags = update_block_group_flags(fs_info, cache->flags);
> > +		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
> >   		if (alloc_flags != cache->flags) {
> >   			ret = btrfs_chunk_alloc(trans, alloc_flags,
> >   						CHUNK_ALLOC_FORCE);
> > @@ -2252,7 +2204,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
> >   	ret = inc_block_group_ro(cache, 0);
> >   out:
> >   	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
> > -		alloc_flags = update_block_group_flags(fs_info, cache->flags);
> > +		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
> >   		mutex_lock(&fs_info->chunk_mutex);
> >   		check_system_chunk(trans, alloc_flags);
> >   		mutex_unlock(&fs_info->chunk_mutex);
> > 
> 
> It seems that this patch breaks forced metadata rebalance from dup to single;
> all chunks remain dup (or are rewritten as dup again). I bisected the broken
> balance behaviour to this commit which for some reason was in my tree ;-) and
> reverting it immediately fixed things.
> 
> I don't (yet) see this applied anywhere, but couldn't find any discussion or
> revocation either. Maybe the logic between update_block_group_flags() and
> btrfs_get_alloc_profile() is not completely exchangeable?
> 

Well cool, it looks like we just ignore the restriping stuff if it's not what we
already have available, which is silly considering we probably don't have any
block groups of the stripe that we had before.  The previous helpers just
unconditionally used the restripe target, so can you apply this patch ontop of
this one and see if it starts working?  I'll wire up a xfstest for this so we
don't miss it again.  Thanks,

Josef

From 01ec038b8fa64c2bbec6d117860e119a49c01f60 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 2 Mar 2020 09:08:33 -0500
Subject: [PATCH] we're restriping, use the target

---
 fs/btrfs/block-group.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 60e9bb136f34..becad9c7486b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -66,11 +66,8 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	spin_lock(&fs_info->balance_lock);
 	target = get_restripe_target(fs_info, flags);
 	if (target) {
-		/* Pick target profile only if it's already available */
-		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
-			spin_unlock(&fs_info->balance_lock);
-			return extended_to_chunk(target);
-		}
+		spin_unlock(&fs_info->balance_lock);
+		return extended_to_chunk(target);
 	}
 	spin_unlock(&fs_info->balance_lock);
 
-- 
2.24.1


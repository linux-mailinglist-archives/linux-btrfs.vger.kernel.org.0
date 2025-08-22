Return-Path: <linux-btrfs+bounces-16288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E16B318D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 15:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4205EB6726D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 13:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43882FC024;
	Fri, 22 Aug 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6lqqk3E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4392FB600
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868125; cv=none; b=QkQ7CspMqJw685HxNaIry963huM+ScLslqH80cuai9aAAITyPJdkwqi1WkUEe/qzlpG1P7bhyBEzDN0zSiL3yyIlm6EDUz9/ID6yF2VM2o8TsXOzELtcHy21qR/Y0zOpF80UIiT84Qel8gS316kXIHrKA4/K6hWtbJcoAbZCH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868125; c=relaxed/simple;
	bh=7SMwE0vM8iWXyb/Rolc0VgFWfYjb56tnLBEnAq3H7KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=JbDRionpAhEGUwNgs2pGlbEnXmxPaE20FR0dN8oYYhW5fIhSAn1V+tGiZDMpw5+48QPxqU4Yt/7oiLwnqaeY2L5Y71YqR6vjJru1RdY88YSvGM1K1ALfZWJjaT/dEbMIHnxkRThqFZjRB407ICOIqYGXmDWhC1FVrFkqCp7qbww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6lqqk3E; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2445813f6d1so3234825ad.2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755868123; x=1756472923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AeZkLEAhY3B2+Wbuoj1+xKb0/WmjVKtyjKVMdY3yumI=;
        b=K6lqqk3Ewa+FOs0ZNKRjKRMKaXTjxpyX8q6GLapIyKSeqSYIQOfuLFRsSqWdkIaHAe
         0s2gCG60moedIw/bRI0fx9GH0ns9zUBKotZEPiPM+MPRo99hhVnTLJg4w11YmqJvnsMG
         8UhtvwCHV/XvDrXJfkyfgY4hRGAmJ22lwkGNYeH1I0tZlcyBDP+nXbC6UJqL7yOECUYC
         4tWx6t+bdeL7m2FXj3MgZomfZUSnT9vm+vuc+4PeCK5BhEUPBqjjM59YyHV0J0cgbqt+
         rF63vagg1oXDBhPzFtTUiko6gtpzVsXO6jjkW7U4Z88E4OlZfkzBM4iCD8lD36NZxFrK
         qoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868123; x=1756472923;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeZkLEAhY3B2+Wbuoj1+xKb0/WmjVKtyjKVMdY3yumI=;
        b=XqDRqR+vYsStz3aexOD6rAXhUgbGs/0cUrSVpkTN6j9hB6VwbY4cGtQKTlASqP1PQk
         DENWF6B5lsYKOclY/yAEgXeqCB0YRevmldWyweb2sy9/4cATmHsYS4GQ5hWUT/3tnMdi
         3t8NLHlGCjsYNRTDJdUx6mzPicQilqYCNlQWNSwKXq/SSLG6bR0YiIvNWDbydLIjQby9
         FsW/xOwdcC4dqf+yjC8xmwBIe6SsVp3U1bOoMVF68zHaZX+bSoOXfB3WKMZClAB8UJIk
         JJ5Mlm8MV4OMVl1xrKsErqoQUS3zpitn3Iv48h+AKqDjwN414jgNz/oUFGoPtCekEhkn
         MiBQ==
X-Gm-Message-State: AOJu0YyxYRMoc+KO0VPip52VRNIiig3TcW1gRHScabx7BLcDLN0eZOQq
	RI3qo3PDZ1wy7Z2QViLCs3mN5s4cvtIJXcFFjjXiGw1EjscFvRn4s+X+
X-Gm-Gg: ASbGnctd6mKKOwfRA/zm8l6vmYPDXWAOMRG0zSLhbrjV+EhH88jUqjiqTbOQ3lkK5Qc
	+LULhX1nKEBKAoEhszC2409jJcsy/rnt99ylm9WUUwqJwYgq+WjcRWTvqZ8kIr+peSj3umP3L2Q
	QTm2aSnNV7ec1SFPlJhWRWtbyZAuhcglyQ9mDnjb17K5TJ3SHyPDOTZ7RsqHkuBgcfKloAnrc1X
	TfyhJQC8nTqDi16z8bRVoV+EbpPKwLq1IAUAzKbi46rOeQ3wY+tTnYnyzrXw3+B3SgIx0UHd77V
	zIBeHK8o5NGAM/gNTDTNZCjgzDIW27E5/69TTokYp/t9dEgl8Lix7p5Vob70YrmBXn/Y0BdibJD
	O9lf5LpBN3lP5F57t3w15Pc4Pj/iyJEqicHBN8xnp7Bkh
X-Google-Smtp-Source: AGHT+IEJN5S7JR9CwAhmUU+5SsWP4f3x+GTqKy7OaOOJXtkqsDO8oPZQwe/xX8r+zoHGFVEsHSA9cw==
X-Received: by 2002:a17:902:f54c:b0:246:5a0f:a1db with SMTP id d9443c01a7336-2465a0fa32fmr4117125ad.11.1755868122499;
        Fri, 22 Aug 2025 06:08:42 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.112.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c73e7sm83995545ad.95.2025.08.22.06.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:08:42 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, sunk67188@gmail.com
Subject: Re: [PATCH 2/2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Fri, 22 Aug 2025 21:08:37 +0800
Message-ID: <877947289.0ifERbkFSE@saltykitkat>
In-Reply-To: <20250822130123.GV22430@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> On Thu, Aug 21, 2025 at 09:12:24PM +0800, Sun YangKai wrote:
> > Trival pattern for the auto freeing with goto -> return convertions
> > if possible. No other function cleanup.
> 
> Not all the changes match the trivial pattern described in the patches.
> 
> > Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> > ---
> > 
> >  fs/btrfs/raid-stripe-tree.c |  16 +-
> >  fs/btrfs/ref-verify.c       |   3 +-
> >  fs/btrfs/reflink.c          |   3 +-
> >  fs/btrfs/relocation.c       |  66 +++-----
> >  fs/btrfs/root-tree.c        |  49 +++---
> >  fs/btrfs/scrub.c            |  11 +-
> >  fs/btrfs/send.c             | 307 +++++++++++++-----------------------
> >  fs/btrfs/super.c            |   9 +-
> >  fs/btrfs/tree-log.c         | 124 +++++----------
> >  9 files changed, 204 insertions(+), 384 deletions(-)
> > 
> > diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> > index cab0b291088c..231107cafab2 100644
> > --- a/fs/btrfs/raid-stripe-tree.c
> > +++ b/fs/btrfs/raid-stripe-tree.c
> > @@ -67,7 +67,7 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle
> > *trans, u64 start, u64 le> 
> >  {
> >  
> >  	struct btrfs_fs_info *fs_info = trans->fs_info;
> >  	struct btrfs_root *stripe_root = fs_info->stripe_root;
> > 
> > -	struct btrfs_path *path;
> > +	BTRFS_PATH_AUTO_FREE(path);
> > 
> >  	struct btrfs_key key;
> >  	struct extent_buffer *leaf;
> >  	u64 found_start;
> > 
> > @@ -260,7 +260,6 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle
> > *trans, u64 start, u64 le> 
> >  		btrfs_release_path(path);
> >  	
> >  	}
> > 
> > -	btrfs_free_path(path);
> > 
> >  	return ret;
> >  
> >  }
> 
> As an example, this is the pattern, just declare, allocate and free at
> the end.
> 
> > @@ -376,7 +374,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info
> > *fs_info,> 
> >  	struct btrfs_stripe_extent *stripe_extent;
> >  	struct btrfs_key stripe_key;
> >  	struct btrfs_key found_key;
> > 
> > -	struct btrfs_path *path;
> > +	BTRFS_PATH_AUTO_FREE(path);
> > 
> >  	struct extent_buffer *leaf;
> >  	const u64 end = logical + *length;
> >  	int num_stripes;
> > 
> > @@ -402,7 +400,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info
> > *fs_info,> 
> >  	ret = btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
> >  	if (ret < 0)
> > 
> > -		goto free_path;
> > +		return ret;
> > 
> >  	if (ret) {
> >  	
> >  		if (path->slots[0] != 0)
> >  		
> >  			path->slots[0]--;
> > 
> > @@ -459,8 +457,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info
> > *fs_info,> 
> >  		trace_btrfs_get_raid_extent_offset(fs_info, logical, *length,
> >  		
> >  						   stripe->physical, devid);
> > 
> > -		ret = 0;
> > -		goto free_path;
> > +		return 0;
> > 
> >  	}
> >  	
> >  	/* If we're here, we haven't found the requested devid in the stripe. 
*/
> > 
> > @@ -474,8 +471,5 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info
> > *fs_info,> 
> >  			  logical, logical + *length, stripe->dev->devid,
> >  			  btrfs_bg_type_to_raid_name(map_type));
> >  	
> >  	}
> > 
> > -free_path:
> > -	btrfs_free_path(path);
> > -
> > 
> >  	return ret;
> >  
> >  }
> 
> This is also still trivial with the goto/return conversion as long as
> there's not additional logic around that.
> 
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index 7256f6748c8f..8b08d6e4cb2b 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -409,7 +409,7 @@ static noinline_for_stack struct btrfs_backref_node
> > *build_backref_tree(> 
> >  	struct btrfs_backref_iter *iter;
> >  	struct btrfs_backref_cache *cache = &rc->backref_cache;
> >  	/* For searching parent of TREE_BLOCK_REF */
> > 
> > -	struct btrfs_path *path;
> > +	BTRFS_PATH_AUTO_FREE(path);
> > 
> >  	struct btrfs_backref_node *cur;
> >  	struct btrfs_backref_node *node = NULL;
> >  	struct btrfs_backref_edge *edge;
> > 
> > @@ -461,7 +461,6 @@ static noinline_for_stack struct btrfs_backref_node
> > *build_backref_tree(> 
> >  out:
> >  	btrfs_free_path(iter->path);
> >  	kfree(iter);
> > 
> > -	btrfs_free_path(path);
> 
> In this case it depends, there are a few more statements after the
> freeing which means the path is still allocated until the function ends.
> If the statements are something quick, like in this case then it's still
> OK and considered trivial.
> 
> >  	if (ret) {
> >  	
> >  		btrfs_backref_error_cleanup(cache, node);
> >  		return ERR_PTR(ret);
> > 
> > @@ -1661,8 +1651,6 @@ static noinline_for_stack int
> > merge_reloc_root(struct reloc_control *rc,> 
> >  	btrfs_tree_unlock(leaf);
> >  	free_extent_buffer(leaf);
> >  
> >  out:
> > -	btrfs_free_path(path);
> 
> Similar to the previous one but is not trivial, due to calls to
> insert_dirty_subvol(), btrfs_end_transaction_throttle(),
> btrfs_btree_balance_dirty() and invalidate_extent_cache(). Please have a
> look what the functions do.
> 
> > -
> > 
> >  	if (ret == 0) {
> >  	
> >  		ret = insert_dirty_subvol(trans, rc, root);
> >  		if (ret)
> > 
> > @@ -4080,7 +4058,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info
> > *fs_info)> 
> >  	struct btrfs_key key;
> >  	struct btrfs_root *fs_root;
> >  	struct btrfs_root *reloc_root;
> > 
> > -	struct btrfs_path *path;
> > +	BTRFS_PATH_AUTO_FREE(path);
> > 
> >  	struct extent_buffer *leaf;
> >  	struct reloc_control *rc = NULL;
> >  	struct btrfs_trans_handle *trans;
> > 
> > @@ -4229,8 +4207,6 @@ int btrfs_recover_relocation(struct btrfs_fs_info
> > *fs_info)> 
> >  out:
> >  	free_reloc_roots(&reloc_roots);
> > 
> > -	btrfs_free_path(path);
> 
> Same non-trivial case, there's btrfs_orphan_cleanup() after that.
> 
> > -
> > 
> >  	if (ret == 0) {
> >  	
> >  		/* cleanup orphan inode in data relocation tree */
> >  		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
> 
> Please split the patch to parts that have the described trivial changes,
> and then one patch per function in case it's not trivial and needs some
> adjustments.
> 
> The freeing followed by other code can be still converted to auto
> cleaning but there must be an explicit path = NULL after the free.

Got it. Thank you for your patience and kind reply. I'll go over those changes 
again.

Best regards,
Sun YangKai





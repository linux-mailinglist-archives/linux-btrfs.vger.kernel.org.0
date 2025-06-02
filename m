Return-Path: <linux-btrfs+bounces-14378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67200ACAEEE
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 15:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE4B17FDF9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 13:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D3220F50;
	Mon,  2 Jun 2025 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBUOL/He"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDFD4C92
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870755; cv=none; b=jDWB/5tjCkmPMCdBInNQKsviAF/r4mWe8QRotuhfCInoMqpW1BbjJ64NRb7sBHAi5KKKwzlGtV5JCfEkeKgUnxub4wNjujBqFE+WA938BVfTvOcWA3Aj84/OKX39yyLTFU+LQhqdxPpkpyTxNoLojIIserd6ghElzxaGv6C+J1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870755; c=relaxed/simple;
	bh=P4qXAa+nNUjFIiRyxAFD7HNf21XucS/wRS0k7yV46AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=JCOdzC53jWz2CV/8zyBG3akGCdZIdKpZk4jQ3eXesRCykv6r8sfSyXlyQJR1o+oHzgdV51tUbEMNRhWz0nQVuI3lsC34muxsEygM6S3xFWPDW6PEfdLnkztRKRTXi6QmJVU6TClpgwVrpHSYuPi9249eYvwzoDZp2LjdkFkaBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBUOL/He; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-742c1145a38so794193b3a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748870753; x=1749475553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hle7wLT5zKQc3pXuh1vkALSvaH9wQiipEHGBVxTMQQM=;
        b=nBUOL/HeXMFVDZ7VFMnegtTslYU0LgmnF0KqpXThIuMxCMmYE0zzuvnpF9+9A0W6hA
         VVbcz6AsJe/f6AOqt/+j+mX1BfHA5uEeFnUhTsOyrHQxBGHFjpYJGnmnVYtvQodq6pt7
         WKN3FcpKUs0kLTvNES1602D2mdQqPvES3LJjZ6QEzFKu+PVWDeQhEIQyG0EHvyEpfd1G
         t4cAZ/gwtlfgU/2iRuEFg6e7LJ0rx/AXC331v8pg566qYFxcodDoBLwIQTIZPeHjootT
         ZU7te2lYS1pzcJ61mbirnVNfROxpxKzSctNxUUEMdyiQ5j0FmBC3AXRJLoAU14j6nxQV
         QkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748870753; x=1749475553;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hle7wLT5zKQc3pXuh1vkALSvaH9wQiipEHGBVxTMQQM=;
        b=afvLVdFEPUUnHZSBpQ5cQprvNppTsK4V/VcYOtrNcChthvqiKJf1v0DlB8iJV+wZYW
         88uBTItUXizYVnOQxRKIL/kRHmpebAe+UB24NvYDh0ewc8KiZolNtVU62gCzupyLgUaW
         6uJas493Dty5+gMo2hwMysQzz3gNniVCskOtof460IWlhlOLBFahRIwgULjydFefNOIa
         QhnmUCWGmd8SGsmCsR9OVJ8VCEMF+xoTcc1fMzD9Yrz/oHDv0ZhC59XoP07IUQS3Raz7
         02HVgUVg4CBBQbBRu0/zs8JcAEwPQ6e1Q0LydaKFodSqJ09ybwr3h6antDQ9svIiDFVe
         GaRQ==
X-Gm-Message-State: AOJu0YxOZy8ZR1bK1sCgnXhvkY+9mLJBxyZsNkMw2+5Y+BU87fwXK/n+
	SXjalIJ12vy8lsro2shsC0S2qhGnbqcMFO1Tvvb4Oxauv4n2uXwYD+3J96szzWhTCJjqUQ==
X-Gm-Gg: ASbGncswZ9QQBvbu1wirJFbN6w/Y+phnBKrQ6nPN+pvojDeJTFfCvDpcCn1scYtt52U
	92PbbYOcrggdPS703wjO526G07I1V/SNkhB9wQPiLKsuZTY6RnltOAcsa0dNxkA2l2fUxNiNbBt
	0dd5QH4KKXDf3IdTwGKurGdZ4HxkTdTAzcHUvCEPmsrSPrlmXO8rNozXUGpGu2xTqWIVEx3NyMh
	G14CTfAplb+HE8aHKwZjctnGOvyEcUTpF8HQA5uRAXUaCsrMbv3AEdRLpxEZ0isxSn27BXr2EpO
	afH4iY/dWqjnSWOe9z+3b9mIkjXcaA2mumEDK8W5gr5VX3u0FUruip4THWY8tA==
X-Google-Smtp-Source: AGHT+IFoE2YhecCRZX5+1/ff7eFjP4K9w+o5U7YFuhI2yQUFoIRUBv/FKtS3Bl6f2QblvoB0lvSRnw==
X-Received: by 2002:a05:6a00:23ce:b0:726:380a:282f with SMTP id d2e1a72fcca58-747c0c40bf1mr6831389b3a.2.1748870753170;
        Mon, 02 Jun 2025 06:25:53 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.113.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd441asm7608308b3a.153.2025.06.02.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 06:25:52 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/14] btrfs: free path sooner at __btrfs_unlink_inode()
Date: Mon, 02 Jun 2025 21:25:48 +0800
Message-ID: <6172770.lOV4Wx5bFT@saltykitkat>
In-Reply-To:
 <14d1a4a5621f5059dae764a8bfc9b114b6df029c.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> From: Filipe Manana <fdmanana@suse.com>
> 
> After calling btrfs_delete_one_dir_name() there's no need for the path
> anymore so we can free it immediately after. After that point we do
> some btree operations that take time and in those call chains we end up
> allocating paths for these operations, so we're unnecessarily holding on
> to the path we allocated early at __btrfs_unlink_inode().
> 
> So free the path as soon as we don't need it and add a comment. This
> also allows to simplify the error path, removing two exit labels and
> returning directly when an error happens.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
>  fs/btrfs/inode.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7bad21ec41f8..a9a37553bc45 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4215,20 +4215,22 @@ static int __btrfs_unlink_inode(struct
> btrfs_trans_handle *trans,> 
>  	u64 dir_ino = btrfs_ino(dir);
>  	
>  	path = btrfs_alloc_path();
> 
> -	if (!path) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!path)
> +		return -ENOMEM;
> 
>  	di = btrfs_lookup_dir_item(trans, root, path, dir_ino, name, -1);
>  	if (IS_ERR_OR_NULL(di)) {
> 
> -		ret = di ? PTR_ERR(di) : -ENOENT;
> -		goto err;
> +		btrfs_free_path(path);
> +		return di ? PTR_ERR(di) : -ENOENT;

Maybe we could define the path using `BTRFS_PATH_AUTO_FREE(path);` so that we 
don't need to write btrfs_free_path before every return statement like this.

Forgive me if I'm mistaken, as I'm not completely familiar with this.

> 
>  	}
>  	ret = btrfs_delete_one_dir_name(trans, root, path, di);
> 
> +	/*
> +	 * Down the call chains below we'll also need to allocate a path, so no
> +	 * need to hold on to this one for longer than necessary.
> +	 */
> +	btrfs_free_path(path);
> 
>  	if (ret)
> 
> -		goto err;
> -	btrfs_release_path(path);
> +		return ret;
> 
>  	/*
>  	
>  	 * If we don't have dir index, we have to get it by looking up
> 
> @@ -4254,7 +4256,7 @@ static int __btrfs_unlink_inode(struct
> btrfs_trans_handle *trans,> 
>  	   "failed to delete reference to %.*s, root %llu inode %llu parent 
%llu",
>  	   
>  			   name->len, name->name, btrfs_root_id(root), ino, dir_ino);
>  		
>  		btrfs_abort_transaction(trans, ret);
> 
> -		goto err;
> +		return ret;
> 
>  	}
>  
>  skip_backref:
>  	if (rename_ctx)
> 
> @@ -4263,7 +4265,7 @@ static int __btrfs_unlink_inode(struct
> btrfs_trans_handle *trans,> 
>  	ret = btrfs_delete_delayed_dir_index(trans, dir, index);
>  	if (ret) {
>  	
>  		btrfs_abort_transaction(trans, ret);
> 
> -		goto err;
> +		return ret;
> 
>  	}
>  	
>  	/*
> 
> @@ -4287,19 +4289,14 @@ static int __btrfs_unlink_inode(struct
> btrfs_trans_handle *trans,> 
>  	 * holding.
>  	 */
>  	
>  	btrfs_run_delayed_iput(fs_info, inode);
> 
> -err:
> -	btrfs_free_path(path);
> -	if (ret)
> -		goto out;
> 
>  	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
>  	inode_inc_iversion(&inode->vfs_inode);
>  	inode_set_ctime_current(&inode->vfs_inode);
>  	inode_inc_iversion(&dir->vfs_inode);
>  	
>   	inode_set_mtime_to_ts(&dir->vfs_inode,
>   	inode_set_ctime_current(&dir->vfs_inode));> 
> -	ret = btrfs_update_inode(trans, dir);
> -out:
> -	return ret;
> +
> +	return btrfs_update_inode(trans, dir);
> 
>  }
>  
>  int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
> 
> --
> 2.47.2




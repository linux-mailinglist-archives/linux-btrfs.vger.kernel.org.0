Return-Path: <linux-btrfs+bounces-2303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F358504BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 15:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6855E1C20DF8
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4C5B69F;
	Sat, 10 Feb 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUGPtz3L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF335B67D;
	Sat, 10 Feb 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575658; cv=none; b=ddll+9gtknWt9o04Fn7yHDOHPVWBAdyX9wjTyvFPlc9dUV7wxPmzDGtHMoWZgYxuj+dupeH9FpT0Xg0iMSwvOUZnHmZc6SEWZcoVvv8pqPv47JfNsYmuvZmb1tgNtUcHAOmaF/zgUdr1d/baL96QUbmhoMW+Jlncm5ZllBCKBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575658; c=relaxed/simple;
	bh=97TZq1Wv8JnIaVgW7awnjfojxHCtEX1NognGm9MKYT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOdq8LZXw3jVgrOJ/MkRJy5eLbBBTNISQKy96H33Ubi2OA81RKbU6+KXkjADUvwExpuG4qjYXjU/jI8/QGDybsS4VPxXQj6/6S8lECATYbj3diTC3TUR9mkZSr/Xisj/0+bYyesoXOQ5hCV132dhYvVmX1FWGtWjs9FSwmtSbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUGPtz3L; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso531091b3a.2;
        Sat, 10 Feb 2024 06:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707575656; x=1708180456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6d/bV79/POYzqhd8zOHaA/VIYwsUTIbbyjcrdO2diY=;
        b=BUGPtz3LHDz4fuQRGGVXkoIfYlGTEs1Kofq1cDa5JrXPz7Rz5YU19kjwPaKR0M4OCU
         bkxydNAkIYLU0S00vIAdysSr+w93b1m4qE7xVmmX83E0ceD4vd+VsRXKaKY+cVid/Dmh
         iCCsNtm7vtTLdXp1eanhoboOPyXTSt/WJxmmxMFCozpZD1Z9laxG76/k/G6vRFRDuDNg
         fgu2ZvcnjWfw+jvszoty7W8densx0pjkzbV9tdXbFIfo53aQnvmtPFwoNzlPKvVRqLOQ
         /4HjKXeZ4zTsUn6k9//FZDAQwhsbINWgYOs58dGalMglSTxLC+NhH1mhDTsQAEpGpDuJ
         oarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575656; x=1708180456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6d/bV79/POYzqhd8zOHaA/VIYwsUTIbbyjcrdO2diY=;
        b=meFb39Am4sP30bvUvp4L+87MpZBbokd5FXX8uAq5VTASVUykulA1Ekis2SMRtX/mZ/
         DS8CnxyRDoPjhsntA4HQzV9FNVLL1fuYYbknVxPNp/cwCbmND1MAv+wNfbHomyL32HbM
         0OIBkALEVVaE2gIW7FBGG7ty2W5r8omTEQSO6dOwUAqd8ya+uQwL+ReKbRxpIimO8Mfy
         mNXG0dquF+2sMc3W5CMnjj+PK/cqMUPisjYqJkn6HLHh8BbFP12Uof7kkDQD9X3Mo7tO
         DRtijM3EGyMnmlJrwa8101kBB1A/OZmICclaOtm/WXjRNGaLY9BnVjid1rCYLv8KuSbV
         7Pew==
X-Forwarded-Encrypted: i=1; AJvYcCXaw1e48F6N3w6NObExE/AqYMorQGVD7nCtEq4tpBwOMU+xBJ0QPQZlHhXXpgJzsK3DuhUcKgjfp4xFnUfn8GQLXGNuZSoH
X-Gm-Message-State: AOJu0YxuXqOpzB3FqclX9/1OXmTXIlJSoP/z+iSg25A1SSiEOBy604Kz
	Dhz4+dYdseVPmJzCuY90xa1aBXoby+vp0Ezu9x5ID7iT3BIRyKqX
X-Google-Smtp-Source: AGHT+IEgucPa3udbdMqhlgISKAkkY8fjR2FEPCDXGMdw6BSewsNi3n994yzBdB2DEwI6n9BCzQAcwA==
X-Received: by 2002:aa7:8b9a:0:b0:6de:1cae:a4ed with SMTP id r26-20020aa78b9a000000b006de1caea4edmr2175369pfd.3.1707575655990;
        Sat, 10 Feb 2024 06:34:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRGO4V/0YkdZG7n/I6DLzoPKhrMLG8YLjNBPnsQ8TrSU4db80AVlVnzMnBh8TJB4UZF3O/tpigZuHWmE8ftfTaIgS2eeaBxsyLba4nWYmPRniWhFf+vCglrxcEWK3q9mJt
Received: from localhost ([212.107.28.51])
        by smtp.gmail.com with ESMTPSA id y14-20020a63ce0e000000b005dc4b562f6csm3717082pgf.3.2024.02.10.06.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 06:34:15 -0800 (PST)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH v2] btrfs: handle missing chunk mapping more gracefully
Date: Sat, 10 Feb 2024 22:34:11 +0800
Message-ID: <20240210143411.393544-1-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
References: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 3/2/23 09:54, Qu Wenruo wrote:
> [BUG]
> During my scrub rework, I did a stupid thing like this:
> 
>          bio->bi_iter.bi_sector = stripe->logical;
>          btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
> 
> Above bi_sector assignment is using logical address directly, which
> lacks ">> SECTOR_SHIFT".
> 
> This results a read on a range which has no chunk mapping.
> 
> This results the following crash:
> 
>   BTRFS critical (device dm-1): unable to find logical 11274289152 length 65536
>   assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
>   ------------[ cut here ]------------
> 
> Sure this is all my fault, but this shows a possible problem in real
> world, that some bitflip in file extents/tree block can point to
> unmapped ranges, and trigger above ASSERT(), or if CONFIG_BTRFS_ASSERT
> is not configured, cause invalid pointer.
> 
> [PROBLEMS]
> In above call chain, we just don't handle the possible error from
> btrfs_get_chunk_map() inside __btrfs_map_block().
> 
> [FIX]
> The fix is pretty straightforward, just replace the ASSERT() with proper
> error handling.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Rebased to latest misc-next
>    The error path in bio.c is already fixed, thus only need to replace
>    the ASSERT() in __btrfs_map_block().
> ---
>   fs/btrfs/volumes.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4d479ac233a4..93bc45001e68 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6242,7 +6242,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   		return -EINVAL;
>   
>   	em = btrfs_get_chunk_map(fs_info, logical, *length);
> -	ASSERT(!IS_ERR(em));
> +	if (IS_ERR(em))
> +		return PTR_ERR(em);
>   
>   	map = em->map_lookup;
>   	data_stripes = nr_data_stripes(map);

This bug affects 6.1.y LTS branch but no backport commit of this fix in
6.1.y branch. Please include it. Thanks.


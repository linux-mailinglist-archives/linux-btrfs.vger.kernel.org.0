Return-Path: <linux-btrfs+bounces-14630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25CDAD7749
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 18:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8533B1B23
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539A71A265E;
	Thu, 12 Jun 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NatzaEqO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530C298CB3
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743467; cv=none; b=o3iGgdrjlEXc0ZiO2R+m2DtO8fYN7TGUd5N145em89GtFuSi7LrvwOr6QOffPgwkC4mCx46rHhzWPgV3bjpgBXG/DHOf8yAumDkErofBJ6jmaluH8rzL1/nnsA4tsD594p/NEzZw2xYbnUe9/YARriH75Z5ciqKGyYFAY7s/oGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743467; c=relaxed/simple;
	bh=llZ4faunlT0bsAZRXk5nryDXyayq5XqzkP+6pSIm6Sg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dh48z84eO82fXaoaz4FT48I6B5X3mu9Oa3E4OCQ3BGQcRuACPMC0ty+3WQiRvM0LSiJuA4AOlXgFFn50/DNGBsut6WIs31hW+lm6ZAMoHUna75Igl1uKmdPI+g5Mo9BjcZkvi+IvE6Gi+qRgYptHBfpwLy6akLtEyo/RtiV7SFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NatzaEqO; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-234c26f8a25so1868235ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749743465; x=1750348265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXm0Mqs7w7SEiM1KZm3mOOr1/Wn9uWLh+Nb7KKQpsag=;
        b=NatzaEqOPKHAVJSPODK89+6+m4Ki1fYt7Gzb5pzDCXaL2kbV+bFYjtqG3H8ypDqTyr
         wyVz1fgspDSX84iEfhqIhl9kqffJvMmaUbRskni/RwaUGwixgrFp7x2Ngo9nkVCUMNKR
         9ffvGvZbYvV3rDsXWvR/XiheAkSW5J+MifGzg8An59stMt8iJ72gWObrFy0eLBbgQx6e
         2sIvq0fBQt/QYRoRyLxLT7AB82lz7X/yH7/ASj6IYspe0saZWJn5cOFe9hzR+LHozLqz
         QIoIoW1SYDSD7nu12uR16sV1WEFKzQs4Xi/5OUbK93a7b3xFMgo5IxBmd7Oy39rIf3GT
         iwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749743465; x=1750348265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXm0Mqs7w7SEiM1KZm3mOOr1/Wn9uWLh+Nb7KKQpsag=;
        b=gmG/BerpCrZnKi3mqQuwR/6qTb5Zb7/hcqPXcgZfeZkqSfSZw12kHUNvpc6lGzQhCo
         +BHLbDUFMywkHnuqbrlW6ekf0cd8KirVczp0iqT/yPxsbMnui9dXKLvjGgn/8ss4+4j5
         g/UDAhxQf6y5BKlwVTctfNRsoKmDQDvHSC2ovj64NaYTIRgnF8b+EuoXTuN7QZCouiUx
         ZLDP1KMniGURlgo2cZO5eaymTfEZDETMCrOOXZysOF+wbDQzEoy3SsdlgcO8eNXXHDPn
         hEgooYWujBJbiF6Yv2vsPm5qxpmJhjro+vj5F4YGgt1E+/iqeyXAAx0iUbYwtkTMlTXE
         jSaw==
X-Gm-Message-State: AOJu0YymST0hnfW7FwYVosm5GI7/Ll3fSs8uTo4J+dDi5YPe9+giI1XY
	enj701GEzQ1b6Qq45XatYJsDKEE0UOMcoXlszoJzGLCVZ/pAUCv1QYeCOTHzqrhFud/BEQ==
X-Gm-Gg: ASbGncttzlu1r3di+5kt28A484VyZZbquS4ZOroXFUwhPJE2WI6c6AVUOZjdQRqEOqb
	NV62qCXNl4SBJCeAi5OdTuYEY4iRT5lRiM+OpjUdpinvNTtmmkrCEctkir06yOoTVkn3bTAM6cq
	hkXyUp6HD22oaHQvX/Aim1qEU77krLZ0VTn8dVRnBQVLEW/MahIe+HuW7168ZNHkI1jQz7N562B
	3khLh6LcpBG+uH5e2EVyY50SHb5z4GrtIzKKJpTrQJMWjwbMRu62YMK4tvcxHSDJWWRwkljNnAT
	ZmeiesarOSq+B54UC/m2pQ8HhruWod8vIaEMV/nXq+PqSwiBV6DKDB8kEXhYdKp7tTfZknl8
X-Google-Smtp-Source: AGHT+IFtc7RgzHmHWNpKij3JEAuPZElw7dngFqEL/dsJSPehi3C+UNDXZJQ0NeTZctvTJVwovuLbew==
X-Received: by 2002:a17:902:ec89:b0:234:e170:88f3 with SMTP id d9443c01a7336-23641aceb61mr39937315ad.8.1749743465407;
        Thu, 12 Jun 2025 08:51:05 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.113.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6343a8sm15745785ad.64.2025.06.12.08.51.04
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:51:05 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Subject:
 Re: [PATCH v3] btrfs: fix nonzero lowest level handling in
 btrfs_search_forward()
Date: Thu, 12 Jun 2025 23:51:01 +0800
Message-ID: <6166825.lOV4Wx5bFT@saltykitkat>
In-Reply-To: <20250612083522.24878-1-sunk67188@gmail.com>
References: <20250612083522.24878-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> Commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only
> checksums during truncate") changed the condition from `level == 0` to
> `level == path->lowest_level`, while its origional purpose is just to do
> some leaf nodes handling (calling btrfs_item_key_to_cpu()) and skip some
> code that doesn't fit leaf nodes.
> 
> After changing the condition, the code path
> 1. also handle the non-leaf nodes when path->lowest_level is nonzero,
>    which is wrong. However, it seems that btrfs_search_forward() is never
>    called with a nonzero path->lowest_level, which makes this bug not
>    found before.
> 2. makes the later if block with the same condition, which is origionally
>    used to handle non-leaf node (calling btrfs_node_key_to_cpu()) when
>    lowest_level is not zero, dead code.
> 
> This changes the behavior when btrfs_search_forward() is called with
> nonzero path->lowest_level. But this never happens in the current code
> base, and the previous behavior is wrong. So the change of behavior will
> not be a problem.
> 
> Fix: commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only
> checksums during truncate") Signed-off-by: Sun YangKai
> <sunk67188@gmail.com>
> ---
>  fs/btrfs/ctree.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a2e7979372cc..56a49d85b2a4 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4585,16 +4585,13 @@ int btrfs_del_items(struct btrfs_trans_handle
> *trans, struct btrfs_root *root,
> 
>  /*
>   * A helper function to walk down the tree starting at min_key, and looking
> - * for nodes or leaves that are have a minimum transaction id.
> + * for leaves that are have a minimum transaction id.
>   * This is used by the btree defrag code, and tree logging
>   *
>   * This does not cow, but it does stuff the starting key it finds back
>   * into min_key, so you can call btrfs_search_slot with cow=1 on the
>   * key and get a writable path.
>   *
> - * This honors path->lowest_level to prevent descent past a given level
> - * of the tree.
> - *
>   * min_trans indicates the oldest transaction that you are interested
>   * in walking through.  Any nodes or leaves older than min_trans are
>   * skipped over (without reading them).
> @@ -4615,6 +4612,7 @@ int btrfs_search_forward(struct btrfs_root *root,
> struct btrfs_key *min_key, int keep_locks = path->keep_locks;
> 
>  	ASSERT(!path->nowait);
> +	ASSERT(path->lowest_level == 0);
>  	path->keep_locks = 1;
>  again:
>  	cur = btrfs_read_lock_root_node(root);
> @@ -4636,8 +4634,8 @@ int btrfs_search_forward(struct btrfs_root *root,
> struct btrfs_key *min_key, goto out;
>  		}
> 
> -		/* at the lowest level, we're done, setup the path and exit */
> -		if (level == path->lowest_level) {
> +		/* at the level 0, we're done, setup the path and exit */
> +		if (level == 0) {
>  			if (slot >= nritems)
>  				goto find_next_key;
>  			ret = 0;
> @@ -4678,12 +4676,6 @@ int btrfs_search_forward(struct btrfs_root *root,
> struct btrfs_key *min_key, goto out;
>  			}
>  		}
> -		if (level == path->lowest_level) {
> -			ret = 0;
> -			/* Save our key for returning back. */
> -			btrfs_node_key_to_cpu(cur, min_key, slot);
> -			goto out;
> -		}
>  		cur = btrfs_read_node_slot(cur, slot);
>  		if (IS_ERR(cur)) {
>  			ret = PTR_ERR(cur);
> @@ -4699,7 +4691,7 @@ int btrfs_search_forward(struct btrfs_root *root,
> struct btrfs_key *min_key, out:
>  	path->keep_locks = keep_locks;
>  	if (ret == 0)
> -		btrfs_unlock_up_safe(path, path->lowest_level + 1);
> +		btrfs_unlock_up_safe(path, 1);
>  	return ret;
>  }

This patch is suggest by Qu Wenruo.
Should I add a line like
Suggest-by: Qu Wenruo <wqu@suse.com>





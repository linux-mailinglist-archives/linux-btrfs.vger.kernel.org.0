Return-Path: <linux-btrfs+bounces-19641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 387A3CB4F83
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E98C300B985
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 07:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E58262FC1;
	Thu, 11 Dec 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlQ+js9n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F8946A
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437431; cv=none; b=lejMsmWLYO2C5vTqjdXTkqzIyvNMYA/wh2JVWDeGDVGKsrsUc0eo49rvEaU0A2UPSJ/MK97nfQzbdljJrIsv+4j+JmvHzx13M+eKVbNbJBJ7qLNpy8Kpe7OM5mJM7vFhJfizaoJVEvpBJsQ1hH7gfxeejZWC7a250nPyfTieVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437431; c=relaxed/simple;
	bh=RoYhH/S2ptmHsRuZcom2NQx3F0JZEY1OdTVTOZkbnSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eQ8eE4aARhVNnxKkm5ttAJh9m4ZxYVAr+mHbKwQOvl42bSZV/oMNOo4oe+VKknnrCIZ6DfK9wKRgcL2yWnTkLFrFNISpTnN0EitaGU0UrtW44/Be8kNMOAh4XJ3/9XqBKWEKG1/gLEqvAoPCle4cB6EFCImfjD4mzPfh8+foM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlQ+js9n; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-295395ceda3so1178975ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 23:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765437427; x=1766042227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yI6UdI0qnexS8Z4kYsCUrg2aCpCKnKcTaEhvfgwfpDM=;
        b=OlQ+js9nMBWuiA6GKaR83263nkSpRkU47ZgeB1BCn3SxEugezXrE+D1AeRo8I85EZj
         Mc4jKJs7u6X2h+1ZJvsYPkp8UfXUBrFdzFdrga5MIEQxdSUDK9gdtSIIWevpbLbn1ZjL
         5a/TdcQCjzHm+VWmRjv7tmsnXstyPFF3zLV5/Ht8v4MBTZQs3Ga8OgtOTtqMxgYUVhyT
         15/k2cVhY0eZzvR34l/w7Yyxu51EOiNX6OpaBcxsbpgKsgiGmKw0ohZYjRwMIqMRCkR9
         arhpWw7fAMq2oAkJWvFgwt9sknPgSa8GR2AZ6fouEY+fqEDbAUeA32axhuHAxCsz4y3Q
         l8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765437427; x=1766042227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yI6UdI0qnexS8Z4kYsCUrg2aCpCKnKcTaEhvfgwfpDM=;
        b=PxlVk4hUYz04RAMtUDIBUEf50XKezF2KrgFHOSGrMvmcsE3y4UjZP7w+N0306hedyD
         pipUKv9jSjoPi0OCmX7Pl0JwLvPfL2Q3clpa8sJ2NwRJ2RoHvdGwr1EacFuDnNqBhvTb
         yFu1285dn4SVCAaFUN9uIU+XNpXNu4AiHcS5E3ssIVFO/75XQZxN5oFLZ+84d8RlEjms
         CM7ULq99rC7lMQ2urKS5MXmjNdocFjpgUWTJQV49JwreDgYUN0yc8qbrtxJCqy6Pxty3
         VI2BtNVcXo7cPFSvSjqMsko6Q2z9gWLxlxSyIVt0QeVYDhGd1CFF96/QwS6mNwCxc8d7
         V13A==
X-Forwarded-Encrypted: i=1; AJvYcCXid4obH4uDaV2n9TJGfwnDPJeK3gPhGhwCM5PEz4lW8Oh4MBBlkH82hCSZFTucFs9mBF09Li816ilyAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRxY4ik+Gxb7jsCSn1fG7bmbNBPv3QOvp1DPhAi7YgHfyOXbje
	aXFb6FCm19zuY9hWwOzXv3AuV7kUnx2fqwUzY09+JxlEKDA/xyao/uoVPSQzzCVzbFbT9w==
X-Gm-Gg: AY/fxX6Z7TLFcXLFboSLqMppByLKteWWuDt98aPHrYQwDTuPZuPLuOp9Obzr3Qscv6X
	h+WxP4LH1LEerZmj64EXGpWYJ04ojJBUkEklY2y0GPCyjtNKAqLh26Z2x9h72Xf0ns8VhIiG0fY
	d1YBzAqOacA+aKh2+dS7nyPAoAtgQDDdDJMAikklnkBnqEXQa3VyF1Z8fduQK69bjDbig3ifg2Y
	V+yfLmKMyNtInkKGausBtaCEDYF+xal3rB2jVT5TIdZuqrVilOvlm132L/vq0JykHHdVtu7fQpM
	sx2qS3LaoRD9wZm8RNYEdz+Xlz33yBG4cw7X5gqx+7VzQoC5t5SA7orY6Hqs/md5r4wM52aIWOs
	e84E3HwHLDzGsCd2vMtuov2qRLOBw6kIBZyDqB8yTbD/Ll8nTJmauBCxh8NZcBVN3194aBPaVfj
	WdlsOc/aWuBD8Qxh64nsWuIlrm7KvR8hwnEiWGZuGjCJ36Dusk7LDacg==
X-Google-Smtp-Source: AGHT+IEjKo7oqMpStT27/QwoftSJ7EzMJesAr2utdUer9t7P6qjBKY1ubOiCJL1cLlmjgAgo2yALTA==
X-Received: by 2002:a17:903:f8e:b0:295:2cab:dbc2 with SMTP id d9443c01a7336-29eed2b6fa3mr12044255ad.6.1765437427138;
        Wed, 10 Dec 2025 23:17:07 -0800 (PST)
Received: from [192.168.1.13] (tk2-240-29809.vs.sakura.ne.jp. [160.16.197.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea01723bsm14382285ad.62.2025.12.10.23.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 23:17:06 -0800 (PST)
Message-ID: <d8037cc1-ba03-4bab-8165-0b0d2fdff58f@gmail.com>
Date: Thu, 11 Dec 2025 15:17:02 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: search for larger extent maps inside
 btrfs_do_readpage()
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <7b5888df903f412b05831ea5302e586cf38c231f.1765434313.git.wqu@suse.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <7b5888df903f412b05831ea5302e586cf38c231f.1765434313.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/12/11 14:25, Qu Wenruo 写道:
> [CORNER CASE]
> If we have the following file extents layout, btrfs_get_extent() can
> return a smaller hole during read, and cause unnecessary extra tree
> searches:
> 
> 	item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 13631488 nr 4096
> 		extent data offset 0 nr 4096 ram 4096
> 		extent compression 0 (none)
> 
> 	item 7 key (257 EXTENT_DATA 32768) itemoff 15757 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 13635584 nr 4096
> 		extent data offset 0 nr 4096 ram 4096
> 		extent compression 0 (none)
> 
> In above case, range [0, 4K) and [32K, 36K) are regular extents, and
> there is a hole in range [4K, 32K), and the fs has "no-holes" feature,
> meaning the hole will not have a file extent item.
> 
> [INEFFICIENCY]
> Assume the system has 4K page size, and we're doing readahead for range
> [4K, 32K), no large folio yet.
> 
>  btrfs_readahead() for range [4K, 32K)
>  |- btrfs_do_readpage() for folio 4K
>  |  |- get_extent_map() for range [4K, 8K)
>  |     |- btrfs_get_extent() for range [4K, 8K)
>  |        We hit item 6, then for the next item 7.
>  |        At this stage we know range [4K, 32K) is a hole.
>  |        But our search range is only [4K, 8K), not reaching 32K, thus
>  |        we go into not_found: tag, returning a hole em for [4K, 8K).
>  |
>  |- btrfs_do_readpage() for folio 8K
>  |  |- get_extent_map() for range [8K, 12K)
>  |     |- btrfs_get_extent() for range [8K, 12K)
>  |        We hit the same item 6, and then item 7.
>  |        But still we goto not_found tag, inserting a new hole em,
>  |        which will be merged with previous one.
>  |
>  | [ Repeat the same btrfs_get_extent() calls until the end ]
> 
> So we're calling btrfs_get_extent() again and again, just for a
> different part of the same hole range [4K, 32K).
> 
> [ENHANCEMENT]
> Make btrfs_do_readpage() to search for a larger extent map if readahead
> is involved.
> 
> For btrfs_readahead() we have bio_ctrl::ractl set, and lock extents for
> the whole readahead range.
> 
> If we find bio_ctrl::ractl is set, we can use that end range as extent
> map search end, this allows btrfs_get_extent() to return a much larger
> hole, thus reduce the need to call btrfs_get_extent() again and again.

I like the idea to reduce unnecessary tree searches. After reading more context
about this, I wonder why we don't set the length of the hole as it is when
searching the extent? So no matter how long the hole is, we could just return
its range in one search.

> 
>  btrfs_readahead() for range [4K, 32K)
>  |- btrfs_do_readpage() for folio 4K
>  |  |- get_extent_map() for range [4K, 32K)
>  |     |- btrfs_get_extent() for range [4K, 32K)
>  |        We hit item 6, then for the next item 7.
>  |        At this stage we know range [4K, 32K) is a hole.
>  |        So the hole em for range [4K, 32K) is returned.
>  |
>  |- btrfs_do_readpage() for folio 8K
>  |  |- get_extent_map() for range [8K, 32K)
>  |     The cached hole em range [4K, 32K) covers the range,
>  |     and reuse that em.
>  |
>  | [ Repeat the same btrfs_get_extent() calls until the end ]
> 
> Now we only call btrfs_get_extent() once for the whole range [4K, 32K),
> other than the old 8 times.
> 
> Such change will reduce the overhead of reading large holes a little.
> For current experimental build (with larger folios) on aarch64, there
> will be a tiny but consistent ~1% improvement reading a large hole file:
> 
>  Reading a 1GiB sparse file (all hole) using xfs_io, with 64K block
>  size, the result is the time needed to read the whole file, reported
>  from xfs_io.
> 
>  32 runs, experimental build (with large folios).
> 
>  64K page size, 4K fs block size.
> 
>  - Avg before: 0.20823 s
>  - Avg after:  0.20635 s
>  - Diff:   -0.9%
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add a benchmark result for the enhancement
> - Use if () to assigned @locked_end
>   This drops the const prefix thought.


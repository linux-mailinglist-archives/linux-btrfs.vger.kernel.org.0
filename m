Return-Path: <linux-btrfs+bounces-18385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D27C1745E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 00:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFC534E136A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 23:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCD034C13F;
	Tue, 28 Oct 2025 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a5/oOkzx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB519DF62
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692812; cv=none; b=aDVqMtFX9h6QVkGnFM3SWIrSMwcQvdbApMSjuOS6uoCW4qMVVF/St1YxljMy4pEOmhzPBiYcMXOHMF200Rh0957+VD0EeLgKW+flENhgHLa0inJKZ/TbmcIa3IvYLxDfk26mXP8sVIm0w5B/5xcfIl9ZQgzia9L1weHi5FwHdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692812; c=relaxed/simple;
	bh=ZRNBwd6lIw5+hYNwivnhhGAO+gO9UBp2tsvExEtQoq0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=J3FH7dsx50gXUpX6ueYGtQeZQy5NhzMROzF4ILaPClTtkPLmHS9Qm84BcW59reJ1ZOy6yCAjpmm7rgTxJHENu+V59KkAFc/sgI//rpW01FrlYOBpGtXD3dpapmnA4WsMFVFoNFoNGcwfIUyBzCbMDYCUcRONB9f2fy+GO9gN9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a5/oOkzx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47118259fd8so51086025e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 16:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761692807; x=1762297607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HO/rL2hFKNJmMDrJw/x+ZyLHYQBAx9SPf7XnO0Rq+h4=;
        b=a5/oOkzxZ1ctHDey0S16xlF3PkSaqNLMky01bTmZv0BmOxQbi/61KPnsJOqoX+7+Gi
         ra9C2hb2n+r2ndZb52ez8pl8JwUeCmmxtrfATw33XRgodti0WjwQXMZLnfTAXgrLfThz
         1lgmdRWhfNbI2Mo059whVw7bQJYTcUcj4fTJsHTG9OjZjAEC0qZ+jJ+jENq42WBKlXiK
         AXzRaVGgpNNewC0NGoNY5RBUnfoCk35/qeabnLKYl/IveOjiAJvX18YAM05Sv9PS5Yc1
         hHBqOJUvjmdAv0YWQbhdojRiPwfb1Y1GW4dJCqq4j2I0f4+xBIFPbrR18wutEyEg87NR
         VHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761692807; x=1762297607;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HO/rL2hFKNJmMDrJw/x+ZyLHYQBAx9SPf7XnO0Rq+h4=;
        b=FHcN3tcX60Vwz7psKSJ2tsaoz7YoZ/rvKLmgyh82TaRpPDsML8GYcGIaVd5dcw9gD4
         d2ioHwf8iX4x92wnMuBSROkb2PkL25NWBK1HXLD6BqI8MA6wNdJp38Jl4AZMq5GafhHx
         ZSsPaEW4291RFaSX0DrVMKxHtrCiHrPOj/nR9nih/k2SD5swVSvRkTEOjjXb+Xt/Ocdh
         KgYvMePzYO3ps4yFl2gtLIU0i7Oa30f88S5t+Gr11aLAEzlGVTGxEOseaQGmxBtbJrYl
         /FlUCL548pH2ZBj3cyOhxMF1ktQ+qNP/g9O31N8tCOBdYGJ/JyNNvQRZdunambLoNpeu
         V3iA==
X-Gm-Message-State: AOJu0YyowSbFHuT8v3heEsOEaeu9q14YPT7kRSby8Iciaz0DspZwJ8zq
	EGEQ2fWxIPOe+5Wonx19XzNQ0lw3pnZ5NAtsoO4HL8fRWxHMZwFSNa4ECG2oeSLf9LzzdX0K7E5
	vqQ9Y
X-Gm-Gg: ASbGnct26jb8bwp7fKH0DMSTye3kZvVLRwkE5qwlR7Rm4CtPbGf+VC4lI27/+3suFEW
	RFOIiHpcAy913KaaHopPBBdLB6wUvPRCrYDodWzxqqAoz8tHbGfnZLpBK8UqdpU7PIIv8cJRmGz
	FD8yRCs58hotq0ahn582c4eGt+ElbtBlQM5ohGd0N6CK8hSZZgUIRT3sxXHaEvuGGT0LMTqhEzs
	g+TRdTjzorjHvi5Ix/nk/8SEWuHHSXt4X6ViHX4q2OE+CCtW+L+ssgdeo3+GtrcbgXXZstl6Ueo
	Ab/+650MDjBMXconqjsrsGRgrF7YCNTfhB9UFCC4MmN4nVoZpq7+HEGyzQl2X0SgadR3cFDmfah
	Xi99GcNxUfZc+nG8A+MlRndnMlburFxTBtZQHQcgGrZEu7Q1BE7sJ5X8EjZMUKeY3mklVDZh3mD
	R2rsCzvO0oEl5htl9+atj9gCqQSVTx
X-Google-Smtp-Source: AGHT+IGsD/wfCtQL8Q9C38JhjVvhW0QtWLdKuDW9v8IxhxcuqBz0Y+b2q8daW3LGFqecDTnZK1UHgw==
X-Received: by 2002:a05:600c:8b76:b0:475:de14:db1f with SMTP id 5b1f17b1804b1-4772086bca9mr844005e9.30.1761692807253;
        Tue, 28 Oct 2025 16:06:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127bf47a1sm11509608a12.10.2025.10.28.16.06.44
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 16:06:46 -0700 (PDT)
Message-ID: <6fdb0436-6134-43b7-9c5d-225d2d6a7a62@suse.com>
Date: Wed, 29 Oct 2025 09:36:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: headers cleanup to remove unnecessary local
 includes
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <94729544d1f85c108b3b34609f42cd3b09cdc5da.1761617310.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <94729544d1f85c108b3b34609f42cd3b09cdc5da.1761617310.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/28 12:39, Qu Wenruo 写道:
> [BUG]
> When I tried to remove btrfs_bio::fs_info and use btrfs_bio::inode to
> grab the fs_info, the header "btrfs_inode.h" is needed to access the
> full btrfs_inode structure.
> 
> Then btrfs will fail to compile.
> 
> [CAUSE]
> There is a recursive including chain:
> 
>    "bio.h" -> "btrfs_inode.h" -> "extent_map.h" -> "compression.h" ->
>    "bio.h"
> 
> That recursive including is causing problems for btrfs.
> 
> [ENHANCEMENT]
> To reduce the risk of recursive including:
> 
> - Remove unnecessary local includes from btrfs headers
>    Either the included header is pulled in by other headers, or is
>    completely unnecessary.
> 
> - Remove btrfs local includes if the header only requires a pointer
>    In that case let the implementing C file to pull the required header.
> 
>    This is especially important for headers like "btrfs_inode.h" which
>    pulls in a lot of other btrfs headers, thus it's a mine field of
>    recursive including.
> 
> - Remove unnecessary temporary structure definition
>    Either if we have included the header defining the structure, or
>    completely unused.
> 
> Now including "btrfs_inode.h" inside "bio.h" is completely fine,
> although "btrfs_inode.h" still includes "extent_map.h", but that header
> only includes "fs.h", no more chain back to "bio.h".

This patch will be merged into the v2 version of async_csum.
As we need extra space for data writes (a new saved bvec_iter), that 
will increase btrfs_bio size by 16 bytes.

With this patch I can later remove btrfs_bio::fs_info, reducing the size 
increase by only 8 bytes.

Thanks,
Qu

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/accessors.h   | 1 +
>   fs/btrfs/btrfs_inode.h | 8 ++++----
>   fs/btrfs/compression.h | 3 ---
>   fs/btrfs/ctree.h       | 2 --
>   fs/btrfs/defrag.c      | 1 +
>   fs/btrfs/dir-item.c    | 1 +
>   fs/btrfs/direct-io.c   | 2 ++
>   fs/btrfs/disk-io.c     | 1 +
>   fs/btrfs/disk-io.h     | 3 ++-
>   fs/btrfs/extent-tree.c | 1 +
>   fs/btrfs/extent_io.h   | 1 -
>   fs/btrfs/extent_map.h  | 3 +--
>   fs/btrfs/file-item.h   | 2 +-
>   fs/btrfs/inode.c       | 1 +
>   fs/btrfs/space-info.c  | 1 +
>   fs/btrfs/subpage.h     | 1 -
>   fs/btrfs/transaction.c | 2 ++
>   fs/btrfs/transaction.h | 4 ----
>   fs/btrfs/tree-log.c    | 1 +
>   fs/btrfs/tree-log.h    | 3 +--
>   fs/btrfs/zoned.h       | 1 -
>   21 files changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index 99b3ced12805..78721412951c 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -12,6 +12,7 @@
>   #include <linux/string.h>
>   #include <linux/mm.h>
>   #include <uapi/linux/btrfs_tree.h>
> +#include "fs.h"
>   #include "extent_io.h"
>   
>   struct extent_buffer;
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index af373d50a901..a66ca5531b5c 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -18,20 +18,20 @@
>   #include <linux/lockdep.h>
>   #include <uapi/linux/btrfs_tree.h>
>   #include <trace/events/btrfs.h>
> +#include "ctree.h"
>   #include "block-rsv.h"
>   #include "extent_map.h"
> -#include "extent_io.h"
>   #include "extent-io-tree.h"
> -#include "ordered-data.h"
> -#include "delayed-inode.h"
>   
> -struct extent_state;
>   struct posix_acl;
>   struct iov_iter;
>   struct writeback_control;
>   struct btrfs_root;
>   struct btrfs_fs_info;
>   struct btrfs_trans_handle;
> +struct btrfs_bio;
> +struct btrfs_file_extent;
> +struct btrfs_delayed_node;
>   
>   /*
>    * Since we search a directory based on f_pos (struct dir_context::pos) we have
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index eba188a9e3bb..c6812d5fcab7 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -14,14 +14,11 @@
>   #include <linux/pagemap.h>
>   #include "bio.h"
>   #include "fs.h"
> -#include "messages.h"
>   
>   struct address_space;
> -struct page;
>   struct inode;
>   struct btrfs_inode;
>   struct btrfs_ordered_extent;
> -struct btrfs_bio;
>   
>   /*
>    * We want to make sure that amount of RAM required to uncompress an extent is
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index fe70b593c7cd..16dd11c48531 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -17,9 +17,7 @@
>   #include <linux/refcount.h>
>   #include <uapi/linux/btrfs_tree.h>
>   #include "locking.h"
> -#include "fs.h"
>   #include "accessors.h"
> -#include "extent-io-tree.h"
>   
>   struct extent_buffer;
>   struct btrfs_block_rsv;
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 7b277934f66f..a4cc1bc63562 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -15,6 +15,7 @@
>   #include "defrag.h"
>   #include "file-item.h"
>   #include "super.h"
> +#include "compression.h"
>   
>   static struct kmem_cache *btrfs_inode_defrag_cachep;
>   
> diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
> index 69863e398e22..77e1bcb2a74b 100644
> --- a/fs/btrfs/dir-item.c
> +++ b/fs/btrfs/dir-item.c
> @@ -9,6 +9,7 @@
>   #include "transaction.h"
>   #include "accessors.h"
>   #include "dir-item.h"
> +#include "delayed-inode.h"
>   
>   /*
>    * insert a name into a directory, doing overflow properly if there is a hash
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 802d4dbe5b38..8888ef4ae606 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -10,6 +10,8 @@
>   #include "fs.h"
>   #include "transaction.h"
>   #include "volumes.h"
> +#include "bio.h"
> +#include "ordered-data.h"
>   
>   struct btrfs_dio_data {
>   	ssize_t submitted;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0aa7e5d1b05f..46b715f3447b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -50,6 +50,7 @@
>   #include "relocation.h"
>   #include "scrub.h"
>   #include "super.h"
> +#include "delayed-inode.h"
>   
>   #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
>   				 BTRFS_HEADER_FLAG_RELOC |\
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 57920f2c6fe4..5320da83d0cf 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -9,7 +9,8 @@
>   #include <linux/sizes.h>
>   #include <linux/compiler_types.h>
>   #include "ctree.h"
> -#include "fs.h"
> +#include "bio.h"
> +#include "ordered-data.h"
>   
>   struct block_device;
>   struct super_block;
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f981ff72fb98..be8cb3bdc166 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -40,6 +40,7 @@
>   #include "orphan.h"
>   #include "tree-checker.h"
>   #include "raid-stripe-tree.h"
> +#include "delayed-inode.h"
>   
>   #undef SCRAMBLE_DELAYED_REFS
>   
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 5fcbfe44218c..02ebb2f238af 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -12,7 +12,6 @@
>   #include <linux/rwsem.h>
>   #include <linux/list.h>
>   #include <linux/slab.h>
> -#include "compression.h"
>   #include "messages.h"
>   #include "ulist.h"
>   #include "misc.h"
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index d4b81ee4d97b..6f685f3c9327 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -8,8 +8,7 @@
>   #include <linux/rbtree.h>
>   #include <linux/list.h>
>   #include <linux/refcount.h>
> -#include "misc.h"
> -#include "compression.h"
> +#include "fs.h"
>   
>   struct btrfs_inode;
>   struct btrfs_fs_info;
> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
> index 63216c43676d..0d59e830018a 100644
> --- a/fs/btrfs/file-item.h
> +++ b/fs/btrfs/file-item.h
> @@ -7,7 +7,7 @@
>   #include <linux/list.h>
>   #include <uapi/linux/btrfs_tree.h>
>   #include "ctree.h"
> -#include "accessors.h"
> +#include "ordered-data.h"
>   
>   struct extent_map;
>   struct btrfs_file_extent_item;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 03e9c3ac20ed..2ca7a34fc73b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -71,6 +71,7 @@
>   #include "backref.h"
>   #include "raid-stripe-tree.h"
>   #include "fiemap.h"
> +#include "delayed-inode.h"
>   
>   #define COW_FILE_RANGE_KEEP_LOCKED	(1UL << 0)
>   #define COW_FILE_RANGE_NO_INLINE	(1UL << 1)
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index cc8015c8b1ff..63d14b5dfc6c 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -15,6 +15,7 @@
>   #include "accessors.h"
>   #include "extent-tree.h"
>   #include "zoned.h"
> +#include "delayed-inode.h"
>   
>   /*
>    * HOW DOES SPACE RESERVATION WORK
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index ad0552db7c7d..d81a0ade559f 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -7,7 +7,6 @@
>   #include <linux/atomic.h>
>   #include <linux/sizes.h>
>   #include "btrfs_inode.h"
> -#include "fs.h"
>   
>   struct address_space;
>   struct folio;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 907f2d047b44..03c62fd1a091 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -32,6 +32,8 @@
>   #include "ioctl.h"
>   #include "relocation.h"
>   #include "scrub.h"
> +#include "ordered-data.h"
> +#include "delayed-inode.h"
>   
>   static struct kmem_cache *btrfs_trans_handle_cachep;
>   
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 9f7c777af635..18ef069197e5 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -14,10 +14,6 @@
>   #include <linux/wait.h>
>   #include "btrfs_inode.h"
>   #include "delayed-ref.h"
> -#include "extent-io-tree.h"
> -#include "block-rsv.h"
> -#include "messages.h"
> -#include "misc.h"
>   
>   struct dentry;
>   struct inode;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 8dfd504b37ae..afaf96a76e3f 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -29,6 +29,7 @@
>   #include "orphan.h"
>   #include "print-tree.h"
>   #include "tree-checker.h"
> +#include "delayed-inode.h"
>   
>   #define MAX_CONFLICT_INODES 10
>   
> diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
> index dc313e6bb2fa..4f149d7d4fde 100644
> --- a/fs/btrfs/tree-log.h
> +++ b/fs/btrfs/tree-log.h
> @@ -8,8 +8,7 @@
>   
>   #include <linux/list.h>
>   #include <linux/fs.h>
> -#include "messages.h"
> -#include "ctree.h"
> +#include <linux/fscrypt.h>
>   #include "transaction.h"
>   
>   struct inode;
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index d64f7c9255fa..5cefdeb08b7b 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -15,7 +15,6 @@
>   #include "disk-io.h"
>   #include "block-group.h"
>   #include "btrfs_inode.h"
> -#include "fs.h"
>   
>   struct block_device;
>   struct extent_buffer;



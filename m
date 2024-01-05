Return-Path: <linux-btrfs+bounces-1271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA7682588C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 17:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3049B1F2325D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E747F2E652;
	Fri,  5 Jan 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqYnDk11"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C428E15
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ccbefe570bso5295461fa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jan 2024 08:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704473117; x=1705077917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wkTZK6hwWs8KeE/0k1TH2EehanNnfqxBYs+G0+tFz0=;
        b=CqYnDk11w7kpVRbj8cAJ2Cu+lrwYN+z4Ypdv1bS51v+tgUYKO6Jte2e5EWjJQZlgGI
         riAPgmEmBIlzkvtCwExnMgV617ohD0POtVFiVaoiK1+Vj7+xBiKNiVk/gYSjQNPjDje3
         /M4OmTfD8lkTfOjWyuJ1Bu8YQOiL7XG70wjU8JJwmcDMRLP8Up8vTj0kzztYTGZFkqR1
         XagGrb7OuHnksqx4crp4lIdHJ9v7KBSJ06919gdsA9o07b5vwDPoHxOetCSLzAqblzf3
         KaOHB/VxvN+7VA51F9QHA7nkGHDN14BhE/3cMYD4ImJ0b4/Hp/Gv0sMKg6ceLrNyJ/09
         xm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704473117; x=1705077917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wkTZK6hwWs8KeE/0k1TH2EehanNnfqxBYs+G0+tFz0=;
        b=jTDr1do7N1l6B1aL/F1THDXxopTioAgPLJvGd0dKCUeM7gzVRuiRyhkXLxcSc/Y4Bw
         M/AIy3QRlNEk569QGeDv8UqhehWhcIp2iryZvGxIp+zkIjloCmU/nIkIuonzlwfQWvq1
         DLWf4poW3qY+hY0paEhzKoKjVwIWSCbyFIu+9EsYjwrszvZRZ1RsRmY1Ic0r3yFgYC6j
         1P4Xk4M9RHHVVy2LKJ9fE+4cLYYO8deF/Wh+4KLrTspu63+gpG3hSvSYBROX/t6HZiSG
         0STrPiBcZcFR/LR+cNBxhtCxJckDfEVuVJ4EKKGvExpVKerykvca60DDh7JsqszgRGZJ
         juzQ==
X-Gm-Message-State: AOJu0YwYKoAfP90eaUI5L/pBe8MKyYjf54pplHWFAV20uBYYSf3CX4JO
	Weezf0n8IHzUFiITqoNIjRALGdmH0C0=
X-Google-Smtp-Source: AGHT+IGgqOv73E5z9/DI1aqEFg8Hq2uMEs4yzONe0mc05BEOMPcFqyP1FIomGJCBHJ5+cWELhELIXQ==
X-Received: by 2002:a05:651c:1a2b:b0:2cc:f5b9:bbf7 with SMTP id by43-20020a05651c1a2b00b002ccf5b9bbf7mr2987002ljb.3.1704473117187;
        Fri, 05 Jan 2024 08:45:17 -0800 (PST)
Received: from [192.168.1.109] ([176.124.146.164])
        by smtp.gmail.com with ESMTPSA id f17-20020a2ea0d1000000b002ccf5b756adsm382772ljm.132.2024.01.05.08.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 08:45:16 -0800 (PST)
Message-ID: <dd314b94-6c45-4c3d-9c6e-4def5b67aafe@gmail.com>
Date: Fri, 5 Jan 2024 19:45:16 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
Content-Language: en-US, ru-RU
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: Christoph Anton Mitterer <calestyo@scientia.org>
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.01.2024 10:33, Qu Wenruo wrote:
> [BUG]
> The following script can lead to a very under utilized extent and we
> have no way to use defrag to properly reclaim its wasted space:
> 
>    # mkfs.btrfs -f $dev
>    # mount $dev $mnt
>    # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
>    # sync
>    # btrfs filesystem defrag $mnt/foobar
>    # sync
> 
> After the above operations, the file "foobar" is still utilizing the
> whole 128M:
> 
>          item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
>                  generation 7 transid 8 size 4096 nbytes 4096
>                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>                  sequence 32770 flags 0x0(none)
>          item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
>                  index 2 namelen 4 name: file
>          item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>                  generation 7 type 1 (regular)
>                  extent data disk byte 298844160 nr 134217728 <<<
>                  extent data offset 0 nr 4096 ram 134217728
>                  extent compression 0 (none)
> 
> Meaning the expected defrag way to reclaim the space is not working.
> 
> [CAUSE]
> The file extent has no adjacent extent at all, thus all existing defrag
> code consider it a perfectly good file extent, even if it's only
> utilizing a very tiny amount of space.
> 
> [FIX]
> Add a special handling for under utilized extents, currently the ratio
> is 6.25% (1/16).
> 
> This would allow us to add such extent to our defrag target list,
> resulting it to be properly defragged.
> 

This sounds like the very wrong thing to do unconditionally. You have no 
knowledge of application I/O pattern and do not know whether application 
is going to fill this extent or not. Instead of de-fragmenting you are 
effectively fragmenting.

This sounds more like a target for a different operation, which may be 
called "garbage collection". But it should be explicit operation not 
tied to defragmentation (or at least explicit opt-in for defragmentation).

> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/defrag.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index c276b136ab63..cc319190b6fb 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1070,6 +1070,17 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>   		if (!next_mergeable) {
>   			struct defrag_target_range *last;
>   
> +			/*
> +			 * Special entry point utilization ratio under 1/16 (only
> +			 * referring 1/16 of an on-disk extent).
> +			 * This can happen for a truncated large extent.
> +			 * If we don't add them, then for a truncated file
> +			 * (may be the last 4K of a 128M extent) it will never
> +			 * be defraged.
> +			 */
> +			if (em->ram_bytes < em->orig_block_len / 16)
> +				goto add;
> +
>   			/* Empty target list, no way to merge with last entry */
>   			if (list_empty(target_list))
>   				goto next;



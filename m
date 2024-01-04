Return-Path: <linux-btrfs+bounces-1251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6F882494E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 20:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55F7285916
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 19:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3162C681;
	Thu,  4 Jan 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="A6I7HRK9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10D2C19E
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id LTperLebOOtSyLTpfrnbjF; Thu, 04 Jan 2024 20:56:47 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1704398207; bh=axH5cjEDgaDq/JkI2JxM4wUumAMaT7ngm0+0K08pUv8=;
	h=From;
	b=A6I7HRK9tgDaFajws/m1ipTwrGWKzweQfI2f6MOXefHKs75p1t96iNIakM0aBr+M9
	 A6A7gB9Zdp7nWXOuc9QJrQQJKUAy4VH5zUB80kXsDNxBoCorcJzezTRuFPBC8/r0co
	 WWEzPQvp1aKBinlfutsb8SNyx3BSoMdnKygfKxyP/Y6YlNtAYWe0P6OTjddH0qI+Gy
	 o+aQNxAxfLgcqthI0cPLlKs8OY+Uizb4lF+mzlVjcAK1U+z+ZwrK+LJRzDO13rUONk
	 5oXEE4sVueAiKcmwqkMEfM37JuUlrkG2NUiMhPCeOi5HRA1zABt3aYpVMNNfQESXXK
	 ywL0E4oKFAxTA==
X-CNFS-Analysis: v=2.4 cv=Qf+g/OXv c=1 sm=1 tr=0 ts=65970d7f cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=jI05uU_FEUhb2i3cbLIA:9 a=QEXdDO2ut3YA:10
 a=BT_VCdbxmILfl63WySnU:22
Message-ID: <ffea1b0d-50cd-4ae4-8ced-90d6cff5f5ac@inwind.it>
Date: Thu, 4 Jan 2024 20:56:46 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: btrfs dev us: don't print uncorrect
 unallocated data
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
References: <f862a81c8ac4b63b2cca2096ffb75907ae899c95.1704398024.git.kreijack@inwind.it>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <f862a81c8ac4b63b2cca2096ffb75907ae899c95.1704398024.git.kreijack@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIl39IaPNiNDUBy77fBt0Z3G928kf7ScJlKkfFYf3qAgXF9Ch2vQZeJhWjhhn11hfds10yxScQFimlvM+TqvRB7UbFeonpW0dTKwZhEdyvJYhK49DVKN
 SaGBPcRWaXW09P3zzKmiqxbpECPtYjzN1FjsneegoRQoE5cuo2pAGB2yh924R+SFPklJTKVHJJmjxMoN4xuI8SXY7iW8LCKIO8SKNq12Z2fjx5zrKoykCfcV

This patch is equal to the previous one. I added only the SOB and Reviewed-by lines.

On 04/01/2024 20.53, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> If "btrfs dev us" is invoked by a not root user, it is imposible to
> collect the chunk info data (not enough privileges). This causes
> "btrfs dev us" to print as "Unallocated" value the size of the disk.
> 
> This patch handle the case where print_device_chunks() is invoked
> without the chunk info data, printing "Unallocated N/A":
> 
> Before the patch:
> 
> $ btrfs dev us t/
> WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
> /dev/loop0, ID: 1
>     Device size:             5.00GiB
>     Device slack:              0.00B
>     Unallocated:             5.00GiB  <-- Wrong
> 
> $ sudo btrfs dev us t/
> [sudo] password for ghigo:
> /dev/loop0, ID: 1
>     Device size:             5.00GiB
>     Device slack:              0.00B
>     Data,single:             8.00MiB
>     Metadata,DUP:          512.00MiB
>     System,DUP:             16.00MiB
>     Unallocated:             4.48GiB  <-- Correct
> 
> After the patch:
> $ ./btrfs dev us /tmp/t/
> WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
> /dev/loop0, ID: 1
>     Device size:             5.00GiB
>     Device slack:              0.00B
>     Unallocated:                 N/A
> 
> $ sudo ./btrfs dev us /tmp/t/
> [sudo] password for ghigo:
> /dev/loop0, ID: 1
>     Device size:             5.00GiB
>     Device slack:              0.00B
>     Data,single:             8.00MiB
>     Metadata,DUP:          512.00MiB
>     System,DUP:             16.00MiB
>     Unallocated:             4.48GiB
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> ---
>   cmds/filesystem-usage.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 015c401e..e88ee323 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -1302,10 +1302,20 @@ void print_device_chunks(const struct device_info *devinfo,
>   		allocated += size;
>   
>   	}
> -	pr_verbose(LOG_DEFAULT, "   Unallocated: %*s%10s\n",
> -		(int)(20 - strlen("Unallocated")), "",
> -		pretty_size_mode(devinfo->size - allocated,
> -			unit_mode | UNITS_NEGATIVE));
> +
> +	/*
> +	 * If chunkinfos is empty, we cannot compute the unallocated
> +	 * size, so don't print uncorrect data.
> +	 */
> +	if (chunkinfos->length == 0)
> +		pr_verbose(LOG_DEFAULT, "   Unallocated: %*s%10s\n",
> +			(int)(20 - strlen("Unallocated")), "",
> +			"N/A");
> +	else
> +		pr_verbose(LOG_DEFAULT, "   Unallocated: %*s%10s\n",
> +			(int)(20 - strlen("Unallocated")), "",
> +			pretty_size_mode(devinfo->size - allocated,
> +				unit_mode | UNITS_NEGATIVE));
>   }
>   
>   void print_device_sizes(const struct device_info *devinfo, unsigned unit_mode)

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5



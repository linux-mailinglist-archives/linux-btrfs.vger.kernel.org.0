Return-Path: <linux-btrfs+bounces-1168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5AA820485
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Dec 2023 12:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D6FB21453
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Dec 2023 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDD679C2;
	Sat, 30 Dec 2023 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="sQePpu8v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C67481
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Dec 2023 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id JXNUrZCqPOtSyJXNUrPljv; Sat, 30 Dec 2023 12:19:40 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1703935180; bh=M7fWbrxkiaQ7L2Vg7Bxz1jm6clKHf13DI1iVBp+xydc=;
	h=From;
	b=sQePpu8vuntRp+FsaNnaWJT7ohmgLcXmPsdbHH97hZp0cfa8hdohzCWvzeNOSGHAz
	 Qyz5LJXGadNbxuk9M+GSAF4FoHMg+DL2WHQSnEs2lbr5SaemUo5QrpuPxle241NpGk
	 koIYRwUtlP0U7VDSxkYUFU6eD4NKQkE58cXclVlAdqZGpr9L+AOlqKNE5/Sm7rQtvj
	 hgvIJwROzgpn4l4vlsHD/LCC8tKGYLzIIdpYbhPV0PztvtBFSYuaVC5pNWN12fAthR
	 xHGgaDCAqF99oEh2gjIxZqbPUdamtqZKOusgMCTolN/LLsGe9HDPJBlzVdMIP0KJ2M
	 GsaHwaL/gWRpg==
X-CNFS-Analysis: v=2.4 cv=Qf+g/OXv c=1 sm=1 tr=0 ts=658ffccc cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=ga8dwThMXQ2cuOZhVrQA:9 a=QEXdDO2ut3YA:10
Message-ID: <65b5110d-a216-4b86-8c84-d8db51bdff27@inwind.it>
Date: Sat, 30 Dec 2023 12:19:40 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] [BUG] btrfs-progs: btrfs dev us: don't print uncorrect
 unallocated data
To: linux-btrfs@vger.kernel.org
References: <3ab02bc2189617b9d60ec6de924f60ee3899babe.1702831226.git.kreijack@inwind.it>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <3ab02bc2189617b9d60ec6de924f60ee3899babe.1702831226.git.kreijack@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFY1ka6G8V2jANxmdClvqVcTbTeQABG1m+oMZLWkfOKW7B5CmQcUWlKQwWUNaZLeIEDhuYNdk0/weHaOLkzOQzJwmwn3Ct+L1gS2mNWpkhU7VXBwDndT
 atzV7o3WS+Rm6hEcOjdg5iH8jZT0DoRALPa9h5DOdTz9huZyyTimKQI8WeW+DhDqslUSCafgzoPXuNRalgjr8LU/HpZ4GCWMpcU=

On 17/12/2023 17.40, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>

Gentle reminder


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
> ---
>   cmds/filesystem-usage.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 0db91e9c..844dc085 100644
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



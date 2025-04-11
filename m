Return-Path: <linux-btrfs+bounces-12960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804BDA868C0
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 00:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C557172CE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 22:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD1C29CB3D;
	Fri, 11 Apr 2025 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zrqs5JPc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE829C320
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409432; cv=none; b=oT8tBgNIZebATrDFv9A78RQWni2RH+4EdAFJqhzwg0BTrQENRot+v0Pg5wTJu52SgOaHeKOLY2NwOwY9KbWixeqyQ68lwBL2ViKS1dpdjp7qbIR6/9TJz2MDqiSkwuWcYBMbZygAbRubQi3IFEGSKt8tK8jHawweph0rQgtFVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409432; c=relaxed/simple;
	bh=RokeaFU1S/qRv8/CsuWFS1Dlasz2/e4XZZJyfPKs0WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QTtntUwM/vOp0tEBEYohMBau+PlxwqTrMPSwoFOXtM0nbo+VRu7xHuTV06A1c7K7zg1yQ0SSfGLzBoTkQkCnvbCrZhZBRUyG+YnBJQHip6XECdFwz/cGHh2vzTX4LEV0wkacbEimvFsPmoZL7Jl/QmKXyi5YzvyvS6m0uvQVnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zrqs5JPc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-391342fc1f6so1937517f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744409427; x=1745014227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w6TvL+y0jef7EPCJHIPlPwvyZKQA+lSWwChoXwZ8dxs=;
        b=Zrqs5JPcQtnEDOXM3HdyxOZ9149vxS9qCRNxfn5mEh8q/YQ9yWM3X01ScgFKjkShfm
         jK1NueG6qoGSOFIfOC8IbFK0+sNbwxY2HvirjZ0UFTdzoG6t5WQIlY8yv5Yr+nJL+fi1
         GXuZ35fqJ2gS4ve0kKbKhl9OdjX7uIIrxnxroN7QqJBA7qVV1wY6eupG84Fw8Tm0mOzU
         seDEjazeBpQ2HFjNnss7Gee07DkU4yufLzkO/kHkQq0F+TPdy00PcxMvJLxrwOPQiFmS
         iQaV29YylVSUfRg3K5glH8GHT8wT7oI8NZDpILJgyRA3ZCsScS9BVeImZ5k8T+NHpsJN
         jmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744409427; x=1745014227;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6TvL+y0jef7EPCJHIPlPwvyZKQA+lSWwChoXwZ8dxs=;
        b=p15cXP6AVERDOYah1iNb+oI5bC/NcwQgnIu34xKxEjw7ru+OKtXDp5RwjF8Vl8mW2c
         RI+16xaH18LwCfL4l4rgkkw2QQgA049bMbw2xOItWf/GjRlrykxLekpUFkVQUbk/ISiu
         5div8J3kKQufy6MWXwTPUtM770XDwqTP9mnQBFj80PkvDgALTgbblGk8nkqFqFKxPViH
         6wT5e0HzGzuFLdH2WlmrFgoVW8ZBIevH4CrrS/AsavyWSJMouTaTU6cOSkGs7AwkGNoK
         +RvTfAHQ32yIvMCODnayJSpevMOb0XpHKHkE7wmKNF+VJdfDfzXHR+OAbf+2vk/W8+I5
         v2cA==
X-Forwarded-Encrypted: i=1; AJvYcCX1DJ6NG8bJ8k/+oLjiH629sMkWlbKLMIoHuQsFzKE42cTqEBURmpXZ/CgIjJgvYh7Bx2+hCEQSN2vcxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmKX/pW/92o3Yu6eRV4ni3s842cW7H7kkoTe7DF2dY3o+sjP0A
	gY+wCvxsVUkY8wiWxM7E80HAzY0JA5hXfQJadmipbPv778GRRn8iYR0w8x4I+OJLLMw9aQhn7vq
	f
X-Gm-Gg: ASbGncsjaXIrgeyR3SFS5mclcoeNQ6rBKWF1eczkVXt4KzY/o/RB1DU+H32lrS0DMoh
	n1hw2JSxAJKUfkgrPVN3k/7PdOlgDt99RG/TgDab8VWo6B6lkIdMj77kKtbNwh6A1bm4aOKTh/u
	M7a/XhnYQnjtsR2lMZyXUHB/njzecrmpQfOe0srgYh4Zi4fzM1W4sD74apFctjNt7vV/iIq2Ehx
	IIZPAp3+uuvWR3PX5rXkvCeHfWrn8FVdwK93gY6WxF/Ye8VzcFOC2+TSj+otmG7ZQFINTNaTUlu
	b8Q60CZhhO72TpnH7nM7FPKZsEF3+xriBYrEqa76z+J4r8W17bNVa+n/Y5fL4XcIHeIw
X-Google-Smtp-Source: AGHT+IG4/jUk2XcJUkiBUP/GuIZJl/2gFrHqOCZGkMCDSXCpmZa+Ea/wUVLN4/JpQDy0NlhvC86zQw==
X-Received: by 2002:a5d:5847:0:b0:391:1218:d5f7 with SMTP id ffacd0b85a97d-39eaaebebd2mr4081223f8f.40.1744409427096;
        Fri, 11 Apr 2025 15:10:27 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21e02fasm2182791b3a.81.2025.04.11.15.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 15:10:26 -0700 (PDT)
Message-ID: <084ef89e-7988-4d0a-9d63-cf0a5e0ef2af@suse.com>
Date: Sat, 12 Apr 2025 07:40:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to fix "BTRFS error (device dm-3): error writing primary
 super block to device 1"?
To: Kai Stian Olstad <btrfs+list@olstad.com>, linux-btrfs@vger.kernel.org
References: <n2evrtemnyldsra4jh3442h36v2tgi4pem5p7ramknkkabkooe@fre6ayihkaie>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <n2evrtemnyldsra4jh3442h36v2tgi4pem5p7ramknkkabkooe@fre6ayihkaie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/12 01:18, Kai Stian Olstad 写道:
> Kubuntu 24.04
> Kernel 6.8.0-57-generic
> 
> 2 day ago I got a sector error on one of the BTRFS disk
> 
> $ journalctl -k -S 2025-04-09 | grep -A 20 mpt3sas_cm0
> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000): 
> originator(PL), code(0x08), sub_code(0x0000)
> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000): 
> originator(PL), code(0x08), sub_code(0x0000)
> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED Result: 
> hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=6s
> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key : 
> Illegal Request [current]
> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense: 
> Logical block address out of range
> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 CDB: Write(16) 8a 
> 08 00 00 00 00 00 00 10 80 00 00 00 08 00 00
> Apr 09 03:16:26 cb kernel: critical target error, dev sdd, sector 4224 
> op 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0

This error is completely from the lower layer (the block device).

Btrfs nor the LUKS upon the disk can do anything to it.

Thanks,
Qu

> Apr 09 03:16:26 cb kernel: BTRFS warning (device dm-3): lost page write 
> due to IO error on /dev/mapper/cdisk20 (-121)
> Apr 09 03:16:26 cb kernel: BTRFS error (device dm-3): bdev /dev/mapper/ 
> cdisk20 errs: wr 2, rd 1, flush 0, corrupt 0, gen 0
> Apr 09 03:16:26 cb kernel: BTRFS error (device dm-3): error writing 
> primary super block to device 1
> Apr 09 03:17:02 cb kernel: BTRFS error (device dm-3): error writing 
> primary super block to device 1
> Apr 09 03:17:02 cb kernel: BTRFS error (device dm-3): error writing 
> primary super block to device 1
> Apr 09 03:17:02 cb kernel: BTRFS error (device dm-3): error writing 
> primary super block to device 1
> Apr 09 03:17:02 cb kernel: BTRFS error (device dm-3): error writing 
> primary super block to device 1
> Apr 09 03:17:08 cb kernel: BTRFS error (device dm-3): error writing 
> primary super block to device 1
> Apr 09 03:17:10 cb kernel: BTRFS error (device dm-3): error writing 
> primary super block to device 1
> Apr 09 03:17:10 cb kernel: BTRFS error (device dm-3): error writing 
> primary super block to device 1
> Apr 09 03:17:27 cb kernel: BTRFS error (device dm-3): error writing 
> primary super block to device 1
> Apr 09 03:17:58 cb kernel: BTRFS error (device dm-3): error writing 
> primary super block to device 1
> 
> And after that I constantly get "error writing primary super block to 
> device
> 1". Tried to run "btrfs scrub status /data" but that didn't help
> 
> $ sudo btrfs scrub status /data
> UUID:             6554e692-6c1c-4a69-8ff8-cb5615fb9200
> Scrub started:    Thu Apr 10 19:40:56 2025
> Status:           finished
> Duration:         18:54:46
> Total to scrub:   25.08TiB
> Rate:             386.23MiB/s (some device limits set)
> Error summary:    no errors found
> 
> /dev/sdd is /dev/mapper/cdisk20, it's running LUKS on top off sdd.
> 
> Does anyone know how to fix this?
> 
> 
> Some output that might be useful:
> 
> $ sudo btrfs filesystem usage /data
> Overall:
>      Device size:                  29.11TiB
>      Device allocated:             25.09TiB
>      Device unallocated:            4.01TiB
>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Used:                         25.08TiB
>      Free (estimated):              2.01TiB      (min: 2.01TiB)
>      Free (statfs, df):             2.01TiB
>      Data ratio:                       2.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                  no
> 
> Data,RAID1: Size:12.52TiB, Used:12.52TiB (99.96%)
>     /dev/mapper/cdisk20     4.45TiB
>     /dev/mapper/cdisk21     4.45TiB
>     /dev/mapper/cdisk22     8.08TiB
>     /dev/mapper/cdisk23     8.08TiB
> 
> Metadata,RAID1: Size:23.03GiB, Used:19.93GiB (86.56%)
>     /dev/mapper/cdisk20     8.03GiB
>     /dev/mapper/cdisk21     8.03GiB
>     /dev/mapper/cdisk22    15.00GiB
>     /dev/mapper/cdisk23    15.00GiB
> 
> System,RAID1: Size:64.00MiB, Used:1.80MiB (2.81%)
>     /dev/mapper/cdisk22    64.00MiB
>     /dev/mapper/cdisk23    64.00MiB
> 
> Unallocated:
>     /dev/mapper/cdisk20     1.00TiB
>     /dev/mapper/cdisk21     1.00TiB
>     /dev/mapper/cdisk22     1.00TiB
>     /dev/mapper/cdisk23     1.00TiB
> 
> 
> $ sudo btrfs device stats /data | grep -v " 0$"
> [/dev/mapper/cdisk20].write_io_errs    2
> [/dev/mapper/cdisk20].read_io_errs     1
> [/dev/mapper/cdisk21].write_io_errs    1
> [/dev/mapper/cdisk21].read_io_errs     1
> 
> 



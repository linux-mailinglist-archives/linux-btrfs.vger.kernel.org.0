Return-Path: <linux-btrfs+bounces-16632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1521B44D9F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 07:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5A47A260B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 05:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBF2641E3;
	Fri,  5 Sep 2025 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N3H+7cFM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C791EE7B7
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050884; cv=none; b=bqRePKsvCiRYbpYz0kk2i8sMU2T5ixzDrwMVyDRsglHAvPYaOuvKplw8MzeOplCmjC9R5JW2PoH33xUoWqnTi4cGynVbZlgWTmsq19kKKh+M5YRtrPSc8rLQhU4aUdbXpDTcnudZt7RDwYQ2Rp+nP6CJ2vL456l+J2EenqpXFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050884; c=relaxed/simple;
	bh=Gn6DbtgFIMhirab9NY2+OayHSUUdEhCdrPlcQ0PuHIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gC7PJ8stSOwbFzuOOZVHmXW68nwU3E+4TmHIwtW75VOphb6E0TfmoUXaAd7/XxE7zjxezNUqHoxTJvGkQYva7U47/XHLDidcgGucRD7IykK1jp2Nv58kVSPK/pDoeinTUeEbznmbsusB1itHtRZufkqnedv6sYa03vyjlXnWjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N3H+7cFM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3df3be0e098so902349f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Sep 2025 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757050881; x=1757655681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q65bQCPM5c2nClIUrQKECQ1qbAMhE770vzOHZE1W2Zs=;
        b=N3H+7cFMKEND9+abedjzgB869/zXlt8nXhOFCGziidneozNy4lQKBYEbOlARaSTLea
         oM88wxEgD7Jm12N1+uI7JfRiu7Ye6lNEG85W9FDCxCLQENoyOWakRRGl9dBk4FtnWqLh
         OmsEhDtSZITcHU1NCoajlzZ4jVzZylbRJOQ1vxeryBCdJycXtUDQAkpiP6TgiAN+F2X/
         ij6Pm1dFKSIOsh84/rHTjbJN03E5R/d85CpjS9ZIVV1lZAhuE7TFPQNCP04lUN2Pteyg
         M+wtqDIdd+Z04SKj6hgw6Pv3mo90BKUjRpH8zPl1AjOLxmY71kl/bZAMCJZegifnCP2R
         NICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757050881; x=1757655681;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q65bQCPM5c2nClIUrQKECQ1qbAMhE770vzOHZE1W2Zs=;
        b=p9ZGeIz4dTbG/6/wAiLVzu4tsaPOvNrWXGaUsv8AEqZEV1D8GfB/Ei9AUkZF0BWy5L
         Myh9PVJcUTI/Ob87nlA+iQHg4ZipfWEBl6zocIDDXu+6Re6VIwZWY8bA3LF9oktE0yS2
         IMi/zKsTBL3Tces+SP40Yz1nXAhxr+10an/a0k3+l+BpSYnX0u825+QTBUbH84/lXa7n
         my5BOSQumJi4pTy6wl/UptV6vqNW5yceB6Dt3w69WFmh3jAaO1N4D/yBcCYPJlnDJTqs
         FHBziJ9ruwaW+T2NAcpa+ZNqUqxg/kzM5kuvoCtGGhLtKrqEqvk+8a9qmeZVQTQPSigF
         qJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs3xtfC+zyfOQd6ua1T4bHa/5ze5+IdH5nfA6vQLhoXgl0kTfbw1jZdQjJk8WHq8E8CuDTgtQT3aX2Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQPf5Gs/nktkGup0sVDq4cTmK2OvNeMDS7PyuhAJxtKrxSuKa
	fdG+8o4I55LqbGgsjhY479Adonbv2+UD1mTb3ncvBODlNDOxwPTzpCH2NvhGuciWRGVjV5RZAPL
	4XDvA
X-Gm-Gg: ASbGncu+qlB/bmHec6BxieQ5wXDhTOjQvfjMO4S3URpOALrV/2dMQoVL2sKNje/m1lB
	j01REB7PX5g/Ng3S80xPND0q6MhpcBE4mk8r8eXJPzAeASdCZXVCz7hskaOQPywtu+dSaeYuURc
	UbAOJ0FkTZrG1weAhsCj9+QwKhtqbLQN1+3CotpRf0W71poBWhgdB3Wt2kOMQCtJwAfOBcYekHL
	rcPzaVDcM93zKPhMMqL1NsSwUzFaumu0Daa+2ukf4eDUhql0mmJG1dXw0mn5stWm3KYythJy7w5
	TFTdqwhbQFaTjslWRmpzTSMKmwzqYPA8txWCkMPK8AdEn0j99B9vw0J5Ad1udMWFOEPWdtm3R12
	AteSJmDPStnXh9n0TxfiKIogDLDD1IFaa0eHxCJaBtbsY2pfPj4ZSRlwkhFVzItjHTZaSj2bo
X-Google-Smtp-Source: AGHT+IE23fE+nFQrO1Xzw7HNYM47SxRpNG0S7If5QcfOvLIdnw2dVzC/2osa3ptTxiWdN32RKJXCsA==
X-Received: by 2002:a05:6000:24c7:b0:3e0:152a:87b6 with SMTP id ffacd0b85a97d-3e0152a8a00mr5444874f8f.25.1757050880853;
        Thu, 04 Sep 2025 22:41:20 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d6cde2f0fsm17672494a12.13.2025.09.04.22.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 22:41:20 -0700 (PDT)
Message-ID: <5b037515-42da-476f-bcf3-d6c50f70f07c@suse.com>
Date: Fri, 5 Sep 2025 15:11:16 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Need guidance on btrfs: uncorrectable errors from scrub
To: Charlie Kernstock <cakernstock@gmail.com>, linux-btrfs@vger.kernel.org
References: <CALRiM0xL5A70zuTgBFwCW94RQB7JV5ssaigwg7jxh6=tfEZyhg@mail.gmail.com>
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
In-Reply-To: <CALRiM0xL5A70zuTgBFwCW94RQB7JV5ssaigwg7jxh6=tfEZyhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/5 11:40, Charlie Kernstock 写道:
> When trying to run "rpm-ostree reset" or similar, dmesg shows this:
> 
> [  101.630706] BTRFS warning (device nvme0n1p8): checksum verify
> failed on logical 582454427648 mirror 1 wanted 0xf0af24c9 found
> 0xb3fe78f4 level 0
> [  101.630887] BTRFS warning (device nvme0n1p8): checksum verify
> failed on logical 582454427648 mirror 2 wanted 0xf0af24c9 found
> 0xb3fe78f4 level 0

This is not a good news, metadata checksum mismatch normally means the 
metadata is damaged.


> 
> Running a scrub, I see this in dmesg:
> 
> [24059.681116] BTRFS info (device nvme0n1p8): scrub: started on devid 1
> [24179.809250] BTRFS warning (device nvme0n1p8): tree block
> 582454427648 mirror 1 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
> [24179.810105] BTRFS warning (device nvme0n1p8): tree block
> 582454427648 mirror 1 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
> [24179.810541] BTRFS warning (device nvme0n1p8): tree block
> 582454427648 mirror 1 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
> [24179.810739] BTRFS warning (device nvme0n1p8): tree block
> 582454427648 mirror 1 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
> [24179.810744] BTRFS error (device nvme0n1p8): unable to fixup
> (regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
> 527701966848
> [24179.810749] BTRFS warning (device nvme0n1p8): header error at
> logical 582454411264 on dev /dev/nvme0n1p8, physical 527701966848:
> metadata leaf (level 0) in tree 258

And it's a subvolume tree corrupted, data loss ensured.

> [24179.810752] BTRFS error (device nvme0n1p8): unable to fixup
> (regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
> 527701966848
> [24179.810755] BTRFS warning (device nvme0n1p8): header error at
> logical 582454411264 on dev /dev/nvme0n1p8, physical 527701966848:
> metadata leaf (level 0) in tree 258
> [24179.810757] BTRFS error (device nvme0n1p8): unable to fixup
> (regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
> 527701966848
> [24179.810759] BTRFS warning (device nvme0n1p8): header error at
> logical 582454411264 on dev /dev/nvme0n1p8, physical 527701966848:
> metadata leaf (level 0) in tree 258
> [24179.810761] BTRFS error (device nvme0n1p8): unable to fixup
> (regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
> 527701966848
> [24179.810763] BTRFS warning (device nvme0n1p8): header error at
> logical 582454411264 on dev /dev/nvme0n1p8, physical 527701966848:
> metadata leaf (level 0) in tree 258
> [24180.058637] BTRFS warning (device nvme0n1p8): tree block
> 582454427648 mirror 2 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
> [24180.059654] BTRFS warning (device nvme0n1p8): tree block
> 582454427648 mirror 2 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
> [24180.059924] BTRFS warning (device nvme0n1p8): tree block
> 582454427648 mirror 2 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
> [24180.060079] BTRFS warning (device nvme0n1p8): tree block
> 582454427648 mirror 2 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
> [24180.060081] BTRFS error (device nvme0n1p8): unable to fixup
> (regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
> 528775708672
> [24180.060085] BTRFS warning (device nvme0n1p8): header error at
> logical 582454411264 on dev /dev/nvme0n1p8, physical 528775708672:
> metadata leaf (level 0) in tree 258
> [24180.060088] BTRFS error (device nvme0n1p8): unable to fixup
> (regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
> 528775708672
> [24180.060091] BTRFS warning (device nvme0n1p8): header error at
> logical 582454411264 on dev /dev/nvme0n1p8, physical 528775708672:
> metadata leaf (level 0) in tree 258
> [24180.060093] BTRFS error (device nvme0n1p8): unable to fixup
> (regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
> 528775708672
> [24180.060095] BTRFS warning (device nvme0n1p8): header error at
> logical 582454411264 on dev /dev/nvme0n1p8, physical 528775708672:
> metadata leaf (level 0) in tree 258
> [24180.060097] BTRFS error (device nvme0n1p8): unable to fixup
> (regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
> 528775708672
> [24180.060100] BTRFS warning (device nvme0n1p8): header error at
> logical 582454411264 on dev /dev/nvme0n1p8, physical 528775708672:
> metadata leaf (level 0) in tree 258
> [24272.506842] BTRFS info (device nvme0n1p8): scrub: finished on devid
> 1 with status: 0
> 
> I've tried to see what file(s) this might correspond to, but I'm
> unable to figure that out using the inspect tool?
> 
> user@ashbringer:~$ sudo btrfs inspect-internal logical-resolve -o
> 582454411264 /sysroot
> ERROR: logical ino ioctl: No such file or directory

Because it's not a data block, but a tree block of tree block.

Strongly recommended to go with a liveUSB and run "btrfs check 
--readonly" on the rootfs.

If the scrub is to be believed, there will quite some corruptions.

Thanks,
Qu
> 
> Other details: "btrfs fi usage" shows only 80% used. This NVMe drive
> is about 1 year old. If I had to guess, I may have gotten into this
> state with an unsafe shutdown or from a previous week-long period
> where I improperly overclocked my system memory. Looking for guidance
> on where to proceed from here. Here is smartctl info if that helps:
> 
> user@ashbringer:~$ sudo smartctl -a /dev/nvme0n1p8
> smartctl 7.5 2025-04-30 r5714
> [x86_64-linux-6.15.6-113.bazzite.fc42.x86_64] (local build)
> Copyright (C) 2002-25, Bruce Allen, Christian Franke, www.smartmontools.org
> 
> === START OF INFORMATION SECTION ===
> Model Number:                       WD_BLACK SN850X 2000GB
> Serial Number:                      24131M803742
> Firmware Version:                   620361WD
> PCI Vendor/Subsystem ID:            0x15b7
> IEEE OUI Identifier:                0x001b44
> Total NVM Capacity:                 2,000,398,934,016 [2.00 TB]
> Unallocated NVM Capacity:           0
> Controller ID:                      8224
> NVMe Version:                       1.4
> Number of Namespaces:               1
> Namespace 1 Size/Capacity:          2,000,398,934,016 [2.00 TB]
> Namespace 1 Formatted LBA Size:     512
> Namespace 1 IEEE EUI-64:            001b44 8b477e0c95
> Local Time is:                      Thu Sep  4 19:02:03 2025 PDT
> Firmware Updates (0x14):            2 Slots, no Reset required
> Optional Admin Commands (0x0017):   Security Format Frmw_DL Self_Test
> Optional NVM Commands (0x00df):     Comp Wr_Unc DS_Mngmt Wr_Zero
> Sav/Sel_Feat Timestmp Verify
> Log Page Attributes (0x1e):         Cmd_Eff_Lg Ext_Get_Lg Telmtry_Lg Pers_Ev_Lg
> Maximum Data Transfer Size:         128 Pages
> Warning  Comp. Temp. Threshold:     90 Celsius
> Critical Comp. Temp. Threshold:     94 Celsius
> Namespace 1 Features (0x02):        NA_Fields
> 
> Supported Power States
> St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
>   0 +     9.00W    9.00W       -    0  0  0  0        0       0
>   1 +     6.00W    6.00W       -    0  0  0  0        0       0
>   2 +     4.50W    4.50W       -    0  0  0  0        0       0
>   3 -   0.0250W       -        -    3  3  3  3     5000   10000
>   4 -   0.0050W       -        -    4  4  4  4     3900   45700
> 
> Supported LBA Sizes (NSID 0x1)
> Id Fmt  Data  Metadt  Rel_Perf
>   0 +     512       0         2
>   1 -    4096       0         1
> 
> === START OF SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
> 
> SMART/Health Information (NVMe Log 0x02, NSID 0xffffffff)
> Critical Warning:                   0x00
> Temperature:                        44 Celsius
> Available Spare:                    100%
> Available Spare Threshold:          10%
> Percentage Used:                    0%
> Data Units Read:                    26,678,672 [13.6 TB]
> Data Units Written:                 30,077,184 [15.3 TB]
> Host Read Commands:                 228,465,682
> Host Write Commands:                583,022,967
> Controller Busy Time:               382
> Power Cycles:                       301
> Power On Hours:                     6,895
> Unsafe Shutdowns:                   28
> Media and Data Integrity Errors:    0
> Error Information Log Entries:      0
> Warning  Comp. Temperature Time:    0
> Critical Comp. Temperature Time:    8
> 
> Error Information (NVMe Log 0x01, 16 of 256 entries)
> No Errors Logged
> 
> Self-test Log (NVMe Log 0x06, NSID 0xffffffff)
> Self-test status: No self-test in progress
> No Self-tests Logged
> 
> Thanks,
> - Charlie Kernstock
> 



Return-Path: <linux-btrfs+bounces-17746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C950BD6C77
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 01:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7CC3B9B9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1302DAFC9;
	Mon, 13 Oct 2025 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QTTtyR6e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DF2C0F7C
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399377; cv=none; b=TTli7GOG79YywfPZuQzJOCJbWujwgWQt6XvOK4Xu6Sdbxxr4GBYkvhSdyaKcgI3j4l//CHQvbMlZOyv5VyfnsDeCAK7zlZKJVdYEzfXEEFh9slQ0CNgwn9sNH8U+pNM5alRgVBw+T0mRuwBDtyJU4tpe3qDPqJrYF1BJH1TExwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399377; c=relaxed/simple;
	bh=4Dr8K9jnR3NIIiLlp8CfFp/o0lr0BDHEqXuWcIgEo2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fr1uDBTle3ENfxpR6S1/auOP3jTtHGwQK4oxk5TR2Z5mDXvM8caVTaX+4x0peZ4+UQgk09eIUoUelL5DMmUof5VL1zq6WlhYih9fun5ouEjejNQezqOqL2f76XdfMSmma2bZudjmbhH55Cf3hoMKyGmpaLAEjtq0dP1p7EG6T2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QTTtyR6e; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2956595f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 16:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760399371; x=1761004171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WGvEGKk/zd6Y9EF3ufgJTy9e7kJEdga6Zobv0Oc4jEU=;
        b=QTTtyR6e+a4tjjI35UwVB438o7Iw1APdHYSckhf0T0nbExgbX2lrF0awgXgu+IufM6
         IQJ9gc3tAhfF190jtrL9lCdrPAzqAjNR3YxB4ACp14xWQ88Vc9ihrB0sc5Dmznujlrff
         PMgwb1PCS5QU7X18BLCcNmuumMDleIMsfsT5T3WHC7HnGZBYQw6tF9HsK9ER1Y/Lymj8
         z348jeUyDOkzeYfHyc1jrl3dnQDL4ZYEGxkG+Iw414JHClC4dniWnVF5cvUVE8NnzIk8
         trNdkPdhqCw2+4/EkaZyh6geudY1um739pZgHtiTvbo3FZVVY5jpuas7+vmCz4fuX7AH
         YnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399371; x=1761004171;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGvEGKk/zd6Y9EF3ufgJTy9e7kJEdga6Zobv0Oc4jEU=;
        b=K+nYdiVwOCnOuxIGk2FiYrvtEeMqRWZPUm2ZCD1PvYuCD9FCKhda57NfiQNma7UWov
         OJrasFoJRtqdf1JmJkfbn0Qc9ZJrQTjKbxzCCjIZv22XskFVn1Qj9qMOcIYtxbbf0VcZ
         6mZiB3PQhCCIvUwLcKrypo0dqUpn949sgLVS2t1SzzsBgfYivqopF1x43A6Hd9j7L8X3
         Ydu6UslZDrLIr4vElERoUFSUq9ppOwFJg1iMb1GybC07zosKwexnAfBcpyUg6RJc53+r
         zaiCax5l8tVVCj+IkCZeJapCXXzm1coGCm7Y2CPL94YDE/U3rVk4tAcFrlnkSnxl4OLt
         9BcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0PizKaeghujgKoMF9r+AvfmfLhACmvEXAtDtygWAc6kZ+k1kdBgO/ELgqDm0mBkqXenJJG2yK4rEkvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+YIW85K3Umpiwyt5kATFiF8JaGcP+XXNyl7iqXHyCPrp+qST
	syiw39JnyumWMlexAR/fReSoGrGviXAGon972x+D3z7MtfRZJoels3Xz1F/dyzqj2E3AOOMyFYj
	BYPhD
X-Gm-Gg: ASbGncuDzvXNaYI3DKuNYJg7e83F4IsV/XntGZVaUc5N/vajhqHbBJXA0pXS9tVM602
	svjCDgmzMgaUXqDmNiGr++cRGWX7LllvxT++a3QhGgz8Z22cHlTL80OEEOdXYMT2XAkrouPz9F5
	So6x+Lh1/7LwAny/sZ1npwnK3ZzYtPc0ULqMEOaM7tWqNzwyyYrz8xI/fXDXkR+BZtOvhygsQbk
	Zbi+2+m0sJh8CuAEq99VhqxUMYPaDT5dOXW98BCm4lwivhrJ065R4O90kYOb9tPF5+RExi8NEO8
	gJnl73vOg4v9rLuMmZ8Q6d6DrqNhLz5PVxtkQ/odc6iEhbI0PGpHblxOOT4m2RcRI0ri/8yfv0w
	jSGCWY0Gw56w8vYSaZgP+xbw2r0hONY0ZtylJpE1M5jo5M2hE/UV41KHSR0OCztps+x2gcAykpw
	yK8qxV
X-Google-Smtp-Source: AGHT+IEKA4JJPsoo6GVBKYN//JlcgP9gTHRzaYC5sDWY6PfZpd+ofA9Lwz8BynVTFtnYqgvSsYo3cA==
X-Received: by 2002:a05:6000:4284:b0:426:d30a:88b0 with SMTP id ffacd0b85a97d-426d30a8fc8mr8073936f8f.22.1760399370937;
        Mon, 13 Oct 2025 16:49:30 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36b67sm145456785ad.90.2025.10.13.16.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 16:49:30 -0700 (PDT)
Message-ID: <afb0b3f2-3012-4f98-9956-6f4030f282dc@suse.com>
Date: Tue, 14 Oct 2025 10:19:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Discard=Async question
To: Brent Belisle <brent.belisle@verizon.net>, linux-btrfs@vger.kernel.org
References: <acb2f7d4-ace1-488c-a7f5-cd499d3f637f.ref@verizon.net>
 <acb2f7d4-ace1-488c-a7f5-cd499d3f637f@verizon.net>
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
In-Reply-To: <acb2f7d4-ace1-488c-a7f5-cd499d3f637f@verizon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/14 09:23, Brent Belisle 写道:
> I hope this is the right place to ask this question.  I noticed that 
> when using the latest Linux kernel  6.17.2 and I issue a findmnt 
> command, the discard=async mount option is not showing up in the 
> output.  However using the Linux kernel 6.16.12 and issuing the same 
> command the discard=async command shows in the output. So my question is 
> is/has btrfs discard=async been disabled in the Linux 6.17 kernel 
> series?  Or is it really enabled and it is just a findmnt command 
> display issue.  I'm including the output of both commands  so you can 
> see what I'm talking about.  Thnaks for your help.

It's a known bug and get fixed by the following patch:

https://lore.kernel.org/linux-btrfs/95f198ac033610c66c30312743fbec4869200229.1758862208.git.wqu@suse.com/

Unfortunately the fix is not yet pushed to upstream, thus no backport to 
affected kernels yet.

Thanks,
Qu

> 
> Linux Kernel 6.16.12
> LMDE 7 Debian 13 Trixie
> 
> findmnt -t btrfs
> TARGET        SOURCE                 FSTYPE OPTIONS
> /             /dev/nvme0n1p2[/@]     btrfs 
> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=33929,subvol=/@
> ├─/btrfs_pool /dev/nvme0n1p2         btrfs 
> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
> ├─/home       /dev/nvme0n1p2[/@home] btrfs 
> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=33928,subvol=/@home
> ├─/970_EVO    /dev/sdb1[/@]          btrfs 
> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/@
> ├─/EVO_POOL   /dev/sdb1              btrfs 
> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
> ├─/PRO_POOL   /dev/sda1              btrfs 
> rw,noatime,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
> └─/850_PRO    /dev/sda1[/@]          btrfs 
> rw,noatime,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/@
> 
> Linux Kernel 6.17.2
> LMDE 7 Debian 13 Trixie
> 
> findmnt -t btrfs
> TARGET        SOURCE                 FSTYPE OPTIONS
> /             /dev/nvme0n1p2[/@]     btrfs 
> rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=33929,subvol=/@
> ├─/btrfs_pool /dev/nvme0n1p2         btrfs 
> rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=5,subvol=/
> ├─/home       /dev/nvme0n1p2[/@home] btrfs 
> rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=33928,subvol=/@home
> ├─/970_EVO    /dev/sdb1[/@]          btrfs 
> rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=256,subvol=/@
> ├─/EVO_POOL   /dev/sdb1              btrfs 
> rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=5,subvol=/
> ├─/PRO_POOL   /dev/sda1              btrfs 
> rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvolid=5,subvol=/
> └─/850_PRO    /dev/sda1[/@]          btrfs 
> rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvolid=256,subvol=/@
> 
> 
> 



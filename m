Return-Path: <linux-btrfs+bounces-20375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26CD0E8E0
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 501CB30086F9
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D170331A5C;
	Sun, 11 Jan 2026 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jhu2qisO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D81D2D7DFE
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768126554; cv=none; b=luQdH5EK8A/Isit+WEDkxBj1aCEiA44nxP7/+cwLb9wWCVVq+UFWVtBCBlgG/k35PNxnyD7OL/o/PJkFHNbUEZGWPBKwWFfO6RH49iz62fKQxEl46y4+kalUBe2WpqQ8WZZRhTmQTFvuZp1Pcc317FMTOFBsDMg+XEkpz0TYit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768126554; c=relaxed/simple;
	bh=1tTqJp6L+Ndt1xsDEEwHPw/wH7LSEp5GBi/YIhe6dVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsZfWKkOlI86P38NZaUw5iYCWMvKLy73sW/3r5EcrLd2Il4ihsdWllgutfdxQClUZ5ceRPfGKNEmzGRIilJr5tRnEobt5lG/qkDqS7i84Nafo7Inj+Q6/2wSD1DyYD5vAjyjtkQ4/zRI2nchFaFVX4U0Qe5eMUf18fCeL0PlnE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jhu2qisO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so19442105e9.0
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 02:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768126549; x=1768731349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0S+MIMnV3MqLsiqHsODr2T4OiyiFPMHA2hmX0+AB3Ww=;
        b=Jhu2qisOmcEq3LJhm9XkqsvqLr2hzu3mYdwhdgMJhgn/fSxWRA/8+O32TahNPHret4
         nEIKHrZLVkehYj6mPbCLImvtN+RnATuusqYB81oYJdl6z3kIGosFd50RuiBzcQNkdots
         wcn3W79C24+ZTBTvBwNauVrpMhgnd2hyFD0WqYJvW93BAe76u7osqj3dIVGsfS26x8ug
         Dde0FQlRyeyegFCum0YBqQ0DWKlE/IIMJMO/Rlsh5sLsoZxnGeh8f16UkbWtgBsXiu2g
         04mfpA3XoUtoOtS3NJzCETVDjF197jqMX9i0zuVfry8bMeYpCyGOO2i6DZOgDJfrJNFk
         ezZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768126549; x=1768731349;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S+MIMnV3MqLsiqHsODr2T4OiyiFPMHA2hmX0+AB3Ww=;
        b=ohX1RIr9f5kxdixvgdmcvLNviSiEAXefl1gyo7Wej1K9ECnFk78EomGWZXxAUu+hKV
         RpJJ2k1msaqYShbdOdiYaj2r4m8mBt5lLCTYRqxZcY79pU+vMMHr7tt+V9/A0waIGglr
         iLcvX1TtdCHM3DU91BM1niwBWrbsGMgua1yjJoF8bCN8+yxcU0Q6O3lZWqNHqIwGKEwr
         l82EbEXsJiN6wY/oulSjtVMKTrd+NGS0KKKPAjMkY5P1BxMdSFcn3a1007TX1g4oV/4p
         uhYqBRJFjsemyj9LQ/ekB63BQoLOymWdV/RblqFT8cxkT7R5ph7tlU39NpsEWRckqXII
         s1dQ==
X-Gm-Message-State: AOJu0Ywq+zYZkSJA0RKWx+Qfb0yElFtrVM75IcK6SJoh4k1oO/1A38xy
	+E3EAIiedBP1W0hYh+uGL7V9Sp+B9yvQScyQDwzNOd8biC+3eq1ECRqTWBC81KnSBjmqWy3DEQz
	FkLUsfR0=
X-Gm-Gg: AY/fxX74X3k/7yMfhMUAo+cnUmzDXrenF5Pbr7tmYgabAXCVznJlUQDtXdUL+Ak29D7
	NdsRJVLdTj8jnjOyX4YKRpptAvoTua8I9LBqBXSnBnhOGTWmc0QxGKXpv9PY0F+HGB09V03F4jQ
	uTssxjCkS45Qjngm0nBf7PvwdDrOR2hYceKYa5aaOB5CJDVT/tGmHgj3Gy7S06FKaLrTqhhWwSl
	q+ktPaLxpzJlCz84xuKnMSCFN+3PUkevCkbf+S8qQt1OmEiqNW3Zgq3HGxe8JG7nZNYSK76cSA1
	XBPMIc7s+DUa9VDmgSLx9P4netb2d/AiZqA7gbAbChiBFXfQnnq7B0yud/vxsOS+9jmuPSBwW21
	cc6lzutqLs60xZXD2uWswJboMOes0yE1TfzUC96C15v09t9ZJOgAAl6iCXGLYEyrwBq6dlApNWd
	um0u8tPF20YaVMbXmp9SDFdeYBpTGZNEROejsFOyw=
X-Google-Smtp-Source: AGHT+IHkN7y1dxP09+Hd+n6x2PwJaIAbnFRdPDtINtufkIfkwCByqk9fSwJ7WtsItIycPBZWukaXFA==
X-Received: by 2002:a05:600c:55c6:b0:477:75b4:d2d1 with SMTP id 5b1f17b1804b1-47d7f627ca1mr156876725e9.15.1768126548921;
        Sun, 11 Jan 2026 02:15:48 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c5ce06sm144483935ad.44.2026.01.11.02.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 02:15:48 -0800 (PST)
Message-ID: <5b466d2f-80ad-4b45-a643-ab64bf2b252d@suse.com>
Date: Sun, 11 Jan 2026 20:45:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] VirtualBox VM crashes (BSOD) during Windows
 installation on btrfs with kernels 6.18+ (works on 6.12 LTS)
To: jollycar <jollycar@proton.me>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <sT06uA3Gtv1kgeL80ZRMshbw6whJNUom-UxnS06H6eVrB4AqGWuzo0P23AhwOn3WsnAq9QfhFYciSAWK3eBeGaKjNJG1oSQLyclv4d2E0L4=@proton.me>
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
In-Reply-To: <sT06uA3Gtv1kgeL80ZRMshbw6whJNUom-UxnS06H6eVrB4AqGWuzo0P23AhwOn3WsnAq9QfhFYciSAWK3eBeGaKjNJG1oSQLyclv4d2E0L4=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/11 20:33, jollycar 写道:
> #regzbot introduced: v6.12..v6.18
> 
> [1.] One line summary of the problem:
> VirtualBox VM crashes with BSOD during Windows installation on kernels 6.18+ (works fine on 6.12 LTS)
> 
> [2.] Full description of the problem:
> Windows 10 and Windows 11 installation inside VirtualBox consistently crashes with BSOD within 1-3 minutes on Linux kernels 6.18.3 and 6.19-rc3. The same VirtualBox configuration and VM image work perfectly on kernel 6.12 LTS. The BSOD errors vary each time (most recent: 0x80070470 - "file may be corrupt or missing"). The host system remains completely stable with no logged errors.
> 
> [3] Kernel & Hardware:
>     - Kernel versions tested:
>       * Working: 6.12.63-1
>       * Broken: 6.18.3-2, 6.19.0-rc3-1
>     - Distribution: Manjaro Linux
>     - Architecture: x86_64
>     - VirtualBox: 7.2.4 r170995 (vboxdrv vermagic: 6.18.3-2-MANJARO SMP preempt mod_unload)
> 
> [4.] Filesystem and storage:
>     - Root filesystem: btrfs on LUKS encryption
>     - Mount options: zstd compression level 3, SSD optimizations, async discard, free space tree
>     - VM storage: separate btrfs subvolume

What's the storage file configuration? Like what's the cache mode setting?
I don't know VBox at all, but there may be something similar to 
libvirt's cache mode (none/unsafe/writethrough etc).

More importantly, will tweaking the cache mode change fix the broken 
kernels?
If so it may point to direct IO related behavior changes.


And what's the storage file format? QCOW2? RAW? Or whatever format 
provided by Vbox?


And one final question, have you tried qemu (or libvirt + qemu) and can 
it still be reproduced with qemu?
As I'm wondering if the direct IO related change will even affects qemu

Thanks,
Qu

>     - btrfs device stats: all zeros (no errors)
> 
> [5.] Reproduction:
> - Boot kernel 6.18.3-2 or 6.19.0-rc3
> - Start VirtualBox 7.2.4 r170995
> - Create new Windows 10 or Windows 11 VM
> - Begin OS installation
> - BSOD occurs within 1-3 minutes with varying errors (latest: 0x80070470)
> - Issue is 100% reproducible on 6.18+, never occurs on 6.12
> 
> Additional context:
> - Host system remains completely stable during VM crashes
> - No btrfs errors in dmesg or device stats (all zero)
> - Issue persists across multiple 6.18/6.19 releases over one month
> - VirtualBox 7.2.4 modules load successfully on all kernel versions
> 
> Regards,
> Jollycar
> 



Return-Path: <linux-btrfs+bounces-17305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7859BAFE69
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 11:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A78B16C3E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B72D9EDF;
	Wed,  1 Oct 2025 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hzg1ZSWC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A251804A
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311710; cv=none; b=lasjYGc3nWpUQ7Nipd4JMXNZ4Li0tKjsrraKqfklRYMThEeCBhiO+T83v4mCblU38AwCdy+aHMz+LfWl6Bw9kLB0OT7RmamrTXxvzsOHvURng0tSWr+87np/OeiNbPh7zA3VfgbLWpA5rtV8A7mjiGajKA3N+KdrtP0rVrPlU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311710; c=relaxed/simple;
	bh=s4HOBwUB8vc1nz6D/OT6tp4CgXkdZg7U39Xsnyo4o9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBlnzENHoW9dqUyaHG6RTaLhEoxjxat9UBIf/7LxfWS7TKJRfjzo09NpGk9IPhVCTmoPUdOk0sWbgiMVweMQOAw50TFWU0yO8BhvhasXWXsm6meacAlqokdtFzkvuIsVm8olMbHTDVTjD7Gkyvv/1botfvv/O6nEDjnBTsNRjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hzg1ZSWC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-414f48bd5a7so4701718f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 02:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759311707; x=1759916507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OkOe64y2ONko2n5PVm4MrO+liwk6V833XiKOBBTxoT4=;
        b=Hzg1ZSWCXYSd+WWdsmKywZO4c1muZSo/eSxx7hQZ08XadtVxM6HPYvmyGg2b83cR0k
         /exdF6KpOHl6ZzJEMSSLaBtSk/P+HIpXia9rlJSAsmB2qkxHFNwhNDLIzw+tqGJum8OW
         hsTaSCjsgOgtxy8qHN0cttsArXewXgQ5TOGJZ29uhqAv8jQMaG90aE6tNj0hmFTd4hDk
         wpqFnMBOygX8kIz6hSmQy7bpcN57JiFdJSot53H7hDntz3WqVLw6p+q+gP85jY2qFX8l
         12KBL/TN4K7QLdIM8aBnMr6Dr/htFwx50YNCYni3Y1l8rixQCJ6mErSwt4y2Ka2QwDnb
         oBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311707; x=1759916507;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkOe64y2ONko2n5PVm4MrO+liwk6V833XiKOBBTxoT4=;
        b=VTdYUnxX5YnYxOh/kn6+EerxMEVxwPUbHilM1vKxeiFgvrkNZC6Uyv9UAQMi/51zOA
         LS8VKyvf2nKf3BheEn5mZdV0r8NAr5aERkc/sk+EIlTY9rWEWaw/OQ74yywba+i+dKyd
         JvITlgyaNZeUatmwy3WWtRPI6sP1/blFBUx+1AHRTGU+w82/MtofB3x+ftIR+9r3oRvK
         F+pSvJU0paEf2zORZfoU05eYB68lIuhFqlDvkH7jPj56FR2Ropygvc7ulUV/2rY6uLdI
         QybJ7euQ9g1SNm01Jjnu4kzzxymUmDOQgxgk8Ar0kJ9f+UUSoQPPMTF5v03RmSN8vsxA
         PLqg==
X-Gm-Message-State: AOJu0Yy5QvN6uctCh5mB8i+cFgF6BEmthhDXnYvLkr50P3cVEfl7CWSq
	fj5PXai+UZELvdx2hr3hqqO7XKQSapXFolbAtewxeeoPaGa+sO8MnTsEURE7kJ2YFDU=
X-Gm-Gg: ASbGncs7W7bnHksDJOwYcGchNIxQbv+PZWZ8TqcMrPAGTzsbTxCsSBs9z3xIRWQHpn+
	JIZVP5GAn3h0riMESEyg3xlVAXIhiVFvZDXz8/hWAzEmfbXyvk2LlNc3oiKTaAeEg9SEDdYUzYv
	pQXL0UnIaoUvd9IyXzeAQ1WsGEJLBkI9Jy/Tsxm8XtJG0lJ4CDN393SDYYAUhZ1/sIXVP8KnKnN
	tS1AOisl9q10wwKRwM7ex7Hd97Kf6PJ/lpha+JZm1XZJ4GOTdtxk+l/9d0h+9HuM+rk4SEZmsqP
	QlKB8tdMa10w8aWBbEOYYQAmuyeE/tcIz47n8I7x92Hg4KBs1UUPvjYJjerwJIMtEy3Z2mg3as9
	E5ejbIq30Nid8QEQkkiEfnDSFB/7ChMpy1xPMNlUAlHtLLpdxB4lac4NoRlS9ZCFS6rPOUkDYdQ
	E3zzH7IAU9LQ==
X-Google-Smtp-Source: AGHT+IEwWA/hFFEobz9azbTeaFQXQwucSA06iU5r0Dd5qQ45IS/LNNTRLTTeiBNzmInY3yd5H2QtsQ==
X-Received: by 2002:a05:6000:2211:b0:3eb:5245:7c1f with SMTP id ffacd0b85a97d-425577edc70mr1946415f8f.2.1759311706668;
        Wed, 01 Oct 2025 02:41:46 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6f2697esm1917902a91.25.2025.10.01.02.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:41:46 -0700 (PDT)
Message-ID: <7ed4dee4-629b-497f-8f9c-fd8d58ffac53@suse.com>
Date: Wed, 1 Oct 2025 19:11:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_btrfs_rescue_chunk-recover_aborts_with_=E2=80=9Csca?=
 =?UTF-8?Q?n_chunk_headers_error=E2=80=9D_on_a_healthy_single-device_FS?=
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CABXGCsPW5P16tN2jX7dkL8FiwKOfSMc6bExZZhjuUzBaBwnLNw@mail.gmail.com>
 <ce039910-3354-4054-aa3a-940bdbcf30b1@gmx.com>
 <CABXGCsPA6wmq+hE8DRj7j7J_MAYh95=hR6wqG3+FdFTd7g+b1A@mail.gmail.com>
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
In-Reply-To: <CABXGCsPA6wmq+hE8DRj7j7J_MAYh95=hR6wqG3+FdFTd7g+b1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/1 19:00, Mikhail Gavrilov 写道:
> On Wed, Oct 1, 2025 at 12:14 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> Overall you shouldn't trust chunk-recovery tool that much.
>>
>> It's a very old tool without much active maintenance/testing.
>> (The existing testing is just to make sure the tool doesn't crash on
>> various fuzzed images, no guarantee it will work correctly)
>>
>> If you found a bug, we can try to fix it, but overall it's not a high
>> priority tool.
> 
> Hello Qu,
> 
> Thanks for the clarification about the current status of chunk-recover.
> 
> I would like to be prepared for the case when a Btrfs filesystem
> becomes mountable only in read-only mode. In such a situation, which
> rescue tool is considered the most appropriate today?

Really hard to say.

If it's some weird hardware bitflip, we have to manually check what the 
corruption is, and if it's inside the ability of btrfs-check, then 
btrfs-check --repair (after consulting the mailing list).

If it's some missing writes or not properly handled flush/fua commands 
(aka, buggy drive firmware), no tool is going to save you.

In fact such situation will also affects all the other filesystems, it's 
just btrfs check --repair not going to be able to handle all situations.

(One of the biggest problem is the metadata COW itself will cascade a 
lot of changes to extent tree, and if extent tree is corrupted, tons of 
things can go wrong during repair)

Either "rescue=all,ro" mount option and hope you can still salvage your 
data, or "btrfs-restore" to salvage data again.


Chunk-recovery is only for a very niche situation where system chunks 
are fully corrupted.

The last time I see such situation, the drive's flush/fua behavior may 
be the culprit.

> 
> The reason for my concern is that a friend of mine recently faced a
> hardware failure, and he tried to use btrfs rescue chunk-recover. I
> repeated the same steps on my healthy partition just to be ready for
> the future. I know that having a backup is always the safest way, but
> with a ~30 TB filesystem it is not trivial to keep a full copy on
> another disk of the same size.
> 
>> We need a full binary dump (or at least btrfs-image dump) to verify and
>> debug.
>>
> 
> As requested, I’ve prepared a btrfs-image dump of the affected
> filesystem metadata (about 30 GB, compressed, download time ~40 min):
> 
> http://213.136.82.171/dumps/nvme0n1.btrfs-image

Sorry, btrfs-image is not enough.

The situation here is that chunk-recovery is scanning the disk for any 
chunk tree blocks, thus old stale tree blocks are also scanned.

But btrfs-image only dumps the tree blocks from the current tree roots, 
will not include any stale tree blocks.

So if you can reproduce the failure on a much smaller drive, it will be 
much better for us to debug.

Thanks,
Qu
> 
> Hopefully this will help to reproduce and analyze the issue.
> 



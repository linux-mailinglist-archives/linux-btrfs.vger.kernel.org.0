Return-Path: <linux-btrfs+bounces-10185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5C9EA8CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 07:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6B11889967
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 06:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B02A22CBC9;
	Tue, 10 Dec 2024 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="i06vhhtR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.scoopta.email (mx.scoopta.email [66.228.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8914A0AA
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733812617; cv=none; b=CzJ/C2LBdsO+Dxr9nRR4iYaUi4ee0uSJqepqo536staR13FRwT52wiyNYs6ogyHlI+0Nj4RA6Y3uS8RnRlfPQ3/6nVhMnLAdegLETylbRUStWGASJSAnoCXihPNK/PFUy2VcTmyb6jDn9VimtvbAREK42V3N0fuaBg3IydT1aQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733812617; c=relaxed/simple;
	bh=Kn/i6X/PeJNGNAd6eA2Ub38rRuu6Yqq6Y1f4/pFFXYc=;
	h=MIME-Version:Message-ID:Date:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WLcgQqQPZttSsrZcIKHAZ98p/GCAWox3/pOL80hx2YitRnMeDARWcw63lEjENA0/4FPnctb93KtqNEe0sqjmG05qWZZLLVG9qUBdxbC8Dg+hSOuBmeSNcHIcY9+o3JyUofijbC18pPo6GPjZd5lyGiT74Cw23CYDXWKm5uVCmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email; spf=pass smtp.mailfrom=scoopta.email; dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b=i06vhhtR; arc=none smtp.client-ip=66.228.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scoopta.email
DKIM-Signature: a=rsa-sha256; b=i06vhhtRhaom+SwuA2Ce+Z4d1EavZ+YF4T7IdfzWxcOFN+NTKzp39m8mr5oa4Kjm8Exmv225R9wlAWKsb/anWCzoBJ3kOZYjUMOjilByHZrDUAi8v/BSn0p1TfUR8ccJCJ2DxTXOO/VCA7mKul1bJubHYAFDjfTiFn0birXzxBDFQMMCThuEtsQ1HN6Q3tmfJkyC4xmDHtA56/3GXVFVkDrU2V3cs6GZGrB4SabqwuhYA1C8gQGrQT+ErNYhJ8w5QOvN4HhjLxkFnPFxTi2VVCuTe74fK6F/TGoNAPWkPlng0vJS+6JhQ9oiHd0OrF90BPG44jR2QeVmYe3VdumVOad+mldq6FkXb9V/ubqLJtgi8x3LXlJBASA226lOIHG4XYpDrZGmzupJFUl3hd5IcqId33G/Sb3GZ3yCwyZbheZuGoFbjKGL5epp+BOovIrxGJH9NZPRkIrUsTJAgzao5lXjt3H5IXAe3hobZIWCT2urFY+NuIwe9aoC/L59j8DYh8TtmPJ2/AD9qNWXa/2xpZ+f8waR0zozbiFPDARMeUPJrhwzsSEu0/6J4+m3TdQNSkwq1PJ6C8+VxELcIZwKdJl2+WhE4O0cfBQVdPZTkOxnW5MiF6pUX/CN6OU+vhU3gAbuHY1GBCNCTvzgCFleYDli4UFc0aC12qPz5W/O8lsefzdXz9Q8iPBQRDaLU3a1cklHSXLAmNrMJ7pv/d4aOepRY4SmsYJGe4mO1apYiS4j9AzWHlJIjhLrl6ZK40GFRy78aO00gk8y4biSZPLs27gwT2918u0Kt0917rlo+OrMaXxJ71xP0Jizxh38IMTJ/bxUo2xvGJITCsFzCh3tmfYpp5hbQ8AQD3rCh//K6Virax5MV+eewVX2lobp/zEN/1wUqSPFC5UzjWEAiTGwQVdnB1GeT52sHBLT3TI0YbxfYHQK+n/6P/unCn7x9xXmIfq2GT
 FluO7+dktZmpRdpv6iNXLMvY3MH1/oJbyt9MX9SgK5O4ayhP05Mdfp57ippJ0KBOUqhpuB1zScAAZMi6J2D9Lpz19T/Ng6cBonXdrmkp0Q0in5ChXvacSpKsxiNoLhTOTyeagKo3vX5LfV8ygxbB4ov5wH6shC6JD0LrBEPDaogG0Nr8vMfbHZ9u4aaaIVRQTSXtdYOJ7JjfnEgsgxhpGjDn5q7aUUharLt82S36YAqKoyuTTCUrExMBDrJdZ4LziC/W4cv19Oe5p1UjEs0nBWaqVav4lgIYNzXJJGheyjkHhHf54VNuRs9zH26Wao8lo5s5B2fQNUpIuLaatEPCZZZ4BGoCLa39IqPvWjnnC+7BKbklp2adTulzrjlPeosB1lVFVoZ6XC0E4TCg==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=mgrN2t48yRl9WMlktTv4pQ6NSO386WSCWpyga+2y6zk=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-UserIsAuth: true
Received: from me.scoopta.ninja (EHLO [IPV6:2602:2e1:80:111::f0c5:cafe]) ([2602:2e1:80:111:0:0:f0c5:cafe])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID -1089075053;
          Mon, 09 Dec 2024 22:36:54 -0800 (PST)
Message-ID: <67fe97da-be53-4dc3-8537-1a39ff49503c@scoopta.email>
Date: Mon, 9 Dec 2024 22:36:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Safety of raid1 vs raid10
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <a7f1781b-6ae8-4e71-ba00-6c1c11c4901d@scoopta.email>
 <74c8536a-3108-4e6c-941a-5d7b9c697862@suse.com>
Content-Language: en-US
From: Scoopta <mlist@scoopta.email>
In-Reply-To: <74c8536a-3108-4e6c-941a-5d7b9c697862@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, that makes a lot of sense. Given what I know about btrfs it seemed 
very unlikely it would pair up drives consistently. This actually gives 
me an interesting side question. With raid1, which is not striped, is 
there any guarantee that a file will be placed contiguously on a given 
drive or is the only guarantee for chunks while files over 1GiB, and 
therefore occupying more than one chunk, could be spread across multiple 
drives so long as each chunk is mirrored?

On 12/9/24 8:36 PM, Qu Wenruo wrote:
>
>
> 在 2024/12/10 12:56, Scoopta 写道:
>> I've read online that btrfs raid10 is theoretically safer than raid1 
>> because raid10 groups drives together into mirrored pairs making the 
>> filesystem more likely to successfully survive a multi-drive failure 
>> event.
>
> It's only theoretically possible, but hardly possible in the real world.
>
>
> For one single RAID10 chunk, btrfs can tolerant as many as half of the 
> devices being missing, as long as each sub stripe (the RAID1 pair) has 
> one device standing.
>
> E.g. for chunk at bytenr X, we have 4 stripes:
>
>  stripe 0 devid 1 physical X1
>  stripe 1 devid 2 physical X2
>  stripe 2 devid 3 physical X3
>  stripe 3 devid 4 physical X4
>
> We can have either devid 1+3 or devid 2+4 missing, and btrfs is 
> totally fine with that chunk.
>
> But the real problem is, one btrfs has more than 3 chunks, and 
> normally one chunk is only 1GiB in size, so for a btrfs with 1TiB used 
> space, it will have at least 1024 chunks.
>
> Good luck all the chunks have the same stripe layout.
>
> If there is another chunk at bytenr Y, also 4 stripes but a different 
> layout:
>
>  stripe 0 devid 1 physical Y1
>  stripe 1 devid 3 physical Y2
>  stripe 2 devid 2 physical Y3
>  stripe 3 devid 4 physical Y4
>
> Then the devid 1+3 missing is fine for chunk X, but not for chunk Y.
>
> In really, the chunk layout is never ensured, and I just did the same 
> RAID10 assumption in my btrfs-fuse project, until it failed selftest 
> (missing two devices for a RAID10 btrfs) on a recent kernel, exactly 
> due to the device rotation.
>
> Thanks,
> Qu
>
>> I can't find any documentation that says this to be the case. Is it 
>> true that btrfs pairs drives together for raid10 but not raid1, if 
>> this is the case what's the reasoning for it?


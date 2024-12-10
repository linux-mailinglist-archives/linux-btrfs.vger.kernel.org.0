Return-Path: <linux-btrfs+bounces-10184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E87719EA80D
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 06:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009301889C93
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 05:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B91F19F436;
	Tue, 10 Dec 2024 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="RK5RW+sY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.scoopta.email (mx.scoopta.email [66.228.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED6227566
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 05:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733809511; cv=none; b=L3axhJxr+9bD3kxm5bEix6zltCUVfro9D5cd923vWbrhPFUXTmOJFGMK77VYdXFcAQzE9k1zZ1PdB9Y8S9Pn40zEkwPNivaBKdA3u/ruUXj32cL0x+/Jtu91DBU/r3dW7IVcw9LeW3fCdVBhJiYDiWKszCzoRvt2cWmv37GIjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733809511; c=relaxed/simple;
	bh=S1sb6D2Iw+tCmWUvUx1CnVwdv2XMGK6j9qifQRoAUxI=;
	h=MIME-Version:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5fJrMJa9EKGNGy5C5VZ2gmDkCgkp1/XIahIOByeZWqAJMVngqlFQ8pxHWCtjC3p016PuoPl2v9eVsgWl2Z4suFrxwHjOOkjvhGSdtSg6s42jF+i9BPg1Gu3HFV1W3s0eWrvq+CKCIuczAVQUUF7iiH7xXLRlFDebz8kpRkNjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email; spf=pass smtp.mailfrom=scoopta.email; dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b=RK5RW+sY; arc=none smtp.client-ip=66.228.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scoopta.email
DKIM-Signature: a=rsa-sha256; b=RK5RW+sYA++4ozwSBA07Deqcj+9hIFsNlDmNp7lj/XZdEBz/rG0hR7DoqyxvAtiSgr/r5WJhZi7gqu4M73ZKRMjNkHA83kszSE1ZjK8dOKqVRilncBcFnEBptWi6SWKymdZmfD9JQ26tRCLqJit+2QkP4XCMJPtK40AOBn1sTuRTKKfETskpINyMMsKzfXVMAEwyeQA0IwUdRB5qe8n7584S8b6Sx8Yfre+ediz0KsV3X4VV8maB2mSXeNtZRf3Oc7GrvJVm410JNrqJKomfRSnU7USYzFdCjt8uXCk5Zol8u2MKFTpPfFuWCryShxU8LUzf76nTak/F0ffYAQylfWsNZEBcZ0NNlSNllDO3PInbU0UOma3dIP4RfBtLyRy2Y9TSPfevAve5x/A1Z4g9/UGajd5O3BO5c2H2tozvENGKa4UEQeMJtDELbRtvqm51gHOhSS/SmkKsUh6gmZUSFbO+bZf6YlhW7Y0+oO8bd2Z0x4OUu2mf8Ms+M5LP6fXV8/1GRzu7rauSibQo7hUfukFK2NFSeMTxfYUb5dcTh38eoajB09bNkFKNZxaDGYv2ANODigmt4xeIRnkKUGeZBW/F1Odkf6/ett1hYufSzHZFbzSieZG468kAf9+MndUVXt8LNYMdxHgP+XONZXOFDfHNgbE8OBqKt9jSf9UJDR/N/3EnzBAIkYkcEA4wX9k5NANdYp01biOAzsW/ZPLk2o0tb6/k0TovEnC4ZnUrPmkCcCj9HpsD5/oS7kJWdnSHJjeacTz4qNklOXu8KwSp3aUj+NMsA+mk1xaPA3elpuQrZP1P489zrVJkLQ5Tz86trkg4TsxbKth+gPbe4+f6/UZ0KNvD69fK8kgz8ugc5+p3H3qExwfH2mHNJfoJ198vKV6eijxzpJ4eIruoipg35/ajnJWTVf/0yB/PJzoHB4ezvOrEbNrWm/QFGCLpHeBGiJKYG7
 yRHHGzbK3hk6ZesFdmp90oe0UxdXcXeVsb8DYl78HvjwmqJqKxTSfks3fI3HYaKxpDtcavpYeqlX4UTAxI+N93GB6VIQVeQk5avnrb2ilyVbALWIM0jW7s29VEETZ2WWRe/r61hvb5gQoMAEPHiEUMgBdUoLEUx1bFgdC/ebezqwstPmpLdtDyKFbpLxuVSnhoq8ouRBkiFv58PIZgp8dPcn0ag3eVFP2IMrGSkXJiwBmDu+bqdKEvleilrpC9adHgtRMsVlYER7CxACXPy3t9634OmRr///m2SVOI5KBGeId5AeqBOdE0MiHoJ+yefC9RM196TI0/Ov55DerI1To774LDrF9nwqncQf4srCDWOuWZpdzwjBtaFPZE6EdyAMIc3qIntVwwcEXDfQ==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=YfsUT28+R5um75/qoo1HUvGWWcOYwZyVTviplLtAcZU=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-UserIsAuth: true
Received: from me.scoopta.ninja (EHLO [IPV6:2602:2e1:80:111::f0c5:cafe]) ([2602:2e1:80:111:0:0:f0c5:cafe])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID -453853169;
          Mon, 09 Dec 2024 21:45:08 -0800 (PST)
Message-ID: <dff986e4-74c2-439f-af01-2bed827b33a4@scoopta.email>
Date: Mon, 9 Dec 2024 21:45:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Safety of raid1 vs raid10
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: linux-btrfs@vger.kernel.org
References: <a7f1781b-6ae8-4e71-ba00-6c1c11c4901d@scoopta.email>
 <Z1eqhWVodaL8rnzu@hungrycats.org>
 <c86d8af9-4b26-4917-9ef3-de38003ee365@scoopta.email>
 <Z1fNpnKlKgE2gh69@hungrycats.org>
Content-Language: en-US
From: Scoopta <mlist@scoopta.email>
In-Reply-To: <Z1fNpnKlKgE2gh69@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/24 9:12 PM, Zygo Blaxell wrote:

> On Mon, Dec 09, 2024 at 06:44:14PM -0800, Scoopta wrote:
>> Ok, this is what I thought but I have seen so many articles that imply
>> raid10 groups drives and I have found no evidence for that. I was always
>> under the impression that neither raid 1 nor 10 grouped drives together
>> intentionally and any grouping was circumstantial.
> In traditional, non-btrfs raid1/raid10 setups, this can easily be the
> case, and people might be assuming this is also true on btrfs without
> checking.

Yeah I figured that's where the misconception was coming from but I 
wanted to verify that it was a misconception. It didn't make sense to me 
that btrfs would pair up raid10 drives but not raid1 drives. I figured 
they'd all behave the same way and that btrfs was free to organize data 
however it wanted provided the redundancy "on the tin", so to speak, was 
met.


> Traditional setups are much less flexible on space--you can't have
> different sizes of drives--but you can organize the drives such that
> each of them is entirely mirroring one other drive.  This can tolerate
> up to N/2 failures, as long as each failure only removes one drive from
> each pair--but it can also fail completely with only 2 drive failures,
> if they're both mirrors of the same stripe.
>
>> On 12/9/24 6:42 PM, Zygo Blaxell wrote:
>>> On Mon, Dec 09, 2024 at 06:26:24PM -0800, Scoopta wrote:
>>>> I've read online that btrfs raid10 is theoretically safer than raid1 because
>>>> raid10 groups drives together into mirrored pairs making the filesystem more
>>>> likely to successfully survive a multi-drive failure event. I can't find any
>>>> documentation that says this to be the case. Is it true that btrfs pairs
>>>> drives together for raid10 but not raid1, if this is the case what's the
>>>> reasoning for it?
>>> It is _possible_ for raid10 and raid1 to be arranged such that multiple drive
>>> losses are possible.  e.g. if all odd numbered devices are paired with all
>>> even numbered devices, then any odd numbered device can be lost and the
>>> filesystem still survives.
>>>
>>> This is not _guaranteed_, it is only _possible_.
>>>
>>> In a filesystem with an odd number of drives, or with drives of varying
>>> sizes, the block groups will only guarantee that one drive loss can be
>>> tolerated in each block group, in order to have the flexibility needed
>>> to fill all available space.  In such cases it is common that block
>>> groups are arranged in such a way that loss of any two drives will break
>>> the filesystem.


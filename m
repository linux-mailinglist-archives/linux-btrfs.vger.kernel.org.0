Return-Path: <linux-btrfs+bounces-10178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C483F9EA5EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 03:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361C2282E41
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 02:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9341D0E2B;
	Tue, 10 Dec 2024 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="bjGpvdSs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.scoopta.email (mx.scoopta.email [66.228.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4B1CEACB
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798661; cv=none; b=mY7WH9q6lDorQtcXBNT3RsmyAnCmi2LGFpyIjrvBIdpxVTHJKSo4EZ5ELs0Ma1NOddEW6JW4lfRSXulu9yMrSe3tBxb+MnP/g6fJIk6mEQ915MS1DtPrMSX29QbyuSzaVH98Y9wfztEwzy5SzhiXLegDUSZ0Ldhkirht9cUvVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798661; c=relaxed/simple;
	bh=XtiqpbceZF83WM0nku9iGikwn4VBqwBVeE9vS1ohfQ8=;
	h=MIME-Version:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2cVGGPuaC1aMcaxK3toAAz73X2Ya9GkC+rWr6/Va4c7x5LLqyCJJYmGBelNAJ8JEcPd2BDUv0dZEqrnHm12JPSFFNzktnk4gNZzEGgnyldaRYnDhDk8GPyhJbaCDt9BxnviaXcgb2iJt9HAwdancurscuQianA0drb5J+3vLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email; spf=pass smtp.mailfrom=scoopta.email; dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b=bjGpvdSs; arc=none smtp.client-ip=66.228.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scoopta.email
DKIM-Signature: a=rsa-sha256; b=bjGpvdSsZDwzziXFiWcg7D93VwNTfc5NybWDSrnLtZZrMJr27o79QLTWNSc4fGq4jre85RkJxba6Kw+9P67md2ZpsyGzdHiyHnkyLQ5KnMjaQ9Al0xY3XXFPoxxp43Kh6V6v0o53pDvu+0Czji/nM9D07VE/0O3+HRw1BNkZ3wEilg4SMa1Uc5VeeZCLcMwv4ccz9vK+VKJwdMr9tInKmZhHSsWQFoN43eA06CpvO2I4cCyhyESgsPao4hrqbsD12sNEP703vqs48B71dUAqAeYTIIJ8nZks/hXZGWIfR9si7PgRqTyg565I+Iq7gBdso6ktq3FAKhBi/iFmtneF3cywx27YRVEDItLRGgZOjbVtYUYefPUdanOlK/dApggoxLsUtwjZ49efM69ZOdIWPmHTEccyyzFpYrdgLB35CfSJtdnqqfF1V12/QDufGyFMH42YI3qdpKvypSatN5AVxfXibxO5xWSVGr26lmrNR598blGfBNWxbZTGAEdHjcLuh5McCwEkthDyUbBgtbfoyWQpTghy0GNzxtmoxdiP9tQVfTvHB9kw7dvFE3bYcW+WpH79zjYSn2Ady6rB/1+iC9cXKk0EYu5OkuDnkAF3ycDlrIJtkzr234UmZ1AoJize1P5KxdU+VCfZshCf0tuAyZYHF2oGvZI+TqLMFAIpFPzbinDFNGFxl2whXC/scvwwpkN9Ag6a8HeR2pbrttj8osyE5/QQiITvXDqTXbaRH68SsHhQCzbYjySqVvlgfzKNYD4o3NFgkqGBII8RfULDY/h9bWdY7h9p8v6eOkEm/OIkKOU16bL/5QawDSordkrvpYHZv7mc1cMLRwpA+X9bQICqJL+Ox2nER3tsDz506rpH2mXsycxyAmNKPFfAicqvbZz7JkEJ7m1hh4BywRU3NQ1DFkHCej76nEwqBl7ObrTrYzTqZzDavcBXiklUN7PXrPdtb5
 sxYUrV1PfC3boHujyOetkZsS8B0uNNNCLpWrU0vdZ1oBl75XVmIaGUQ46uMX4UMPx73RQyWK1CkwFSTqHCyRlLvEOtdQEyNDOtkEM7z5GiEYJ0UA5EiSubiKTPCBIPPcYVzvYXs0jGxTcyBzbvQzrMLNTRJLXWVjcYBUjn05vgvHPtMvghep2xf5COKREhT/GRgZyiGPXK5JlkQEI8n6uvHyLx8aEY2f32WVxFXnIy99KpSlso2Mmg8XqH1fU0eNFN99CI8HNGGFQWqECo3Ht9gV/ptgCEP3n+0WuRAwxbNKrdy6hoqSBJIZmD6h6ZZ1gO/g2hAMaOnRlU/G3mkBJsWGOgH8vlMg7neKhH+fTstZnl8UODBD5kDwQYtLnMOLJjlI3Gadxf+Ft1zg==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=+q3Hv3x5eGB+g6pTyo/qb9M5G29Ub+WMxtTZHVkK4hg=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-UserIsAuth: true
Received: from me.scoopta.ninja (EHLO [IPV6:2602:2e1:80:111::f0c5:cafe]) ([2602:2e1:80:111:0:0:f0c5:cafe])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID -110013176;
          Mon, 09 Dec 2024 18:44:16 -0800 (PST)
Message-ID: <c86d8af9-4b26-4917-9ef3-de38003ee365@scoopta.email>
Date: Mon, 9 Dec 2024 18:44:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Safety of raid1 vs raid10
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: linux-btrfs@vger.kernel.org
References: <a7f1781b-6ae8-4e71-ba00-6c1c11c4901d@scoopta.email>
 <Z1eqhWVodaL8rnzu@hungrycats.org>
Content-Language: en-US
From: Scoopta <mlist@scoopta.email>
In-Reply-To: <Z1eqhWVodaL8rnzu@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ok, this is what I thought but I have seen so many articles that imply 
raid10 groups drives and I have found no evidence for that. I was always 
under the impression that neither raid 1 nor 10 grouped drives together 
intentionally and any grouping was circumstantial.

On 12/9/24 6:42 PM, Zygo Blaxell wrote:
> On Mon, Dec 09, 2024 at 06:26:24PM -0800, Scoopta wrote:
>> I've read online that btrfs raid10 is theoretically safer than raid1 because
>> raid10 groups drives together into mirrored pairs making the filesystem more
>> likely to successfully survive a multi-drive failure event. I can't find any
>> documentation that says this to be the case. Is it true that btrfs pairs
>> drives together for raid10 but not raid1, if this is the case what's the
>> reasoning for it?
> It is _possible_ for raid10 and raid1 to be arranged such that multiple drive
> losses are possible.  e.g. if all odd numbered devices are paired with all
> even numbered devices, then any odd numbered device can be lost and the
> filesystem still survives.
>
> This is not _guaranteed_, it is only _possible_.
>
> In a filesystem with an odd number of drives, or with drives of varying
> sizes, the block groups will only guarantee that one drive loss can be
> tolerated in each block group, in order to have the flexibility needed
> to fill all available space.  In such cases it is common that block
> groups are arranged in such a way that loss of any two drives will break
> the filesystem.


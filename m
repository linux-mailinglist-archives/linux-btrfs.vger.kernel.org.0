Return-Path: <linux-btrfs+bounces-12362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB5A66CFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 08:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA12E3AC92D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 07:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6F41EF373;
	Tue, 18 Mar 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJKGrPfW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2521C3BE2;
	Tue, 18 Mar 2025 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284695; cv=none; b=Oc61iIHXA3IPDA0tzVROxqRgl8X5SMgI3Vi6dlO1FdnP21V0T1JXICft88WFRVjS/0eqJu3FVERAgCgXXHsla63qVzFi3EMT31vxqZDmyeqwlIedhg6HsW/5LIpNptIKuT0p4YEwO67UhSMBEUZl+5UWHpjRX0r7rD6tMxfbvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284695; c=relaxed/simple;
	bh=YjofbzV5kQWyOHs5wb9gCPfHPvabjzxNIU+uECnh/2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRnkdwXruX3esSCTuBi7QIV3+W/GFfmDYThp7fa6FNGYSV2YSWFrM2JkIsOOOA1Q54t0nlJbBfbC48gMWZj+dasfSmeVqnWGxYIQIpVzSi5mLdJ0tzMnyY5BV+bKgZrTwvCWqJw7lgbapkn+CYMBIZtJFYu2PoCEsBE4W5cnqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJKGrPfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CE2C4CEDD;
	Tue, 18 Mar 2025 07:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742284695;
	bh=YjofbzV5kQWyOHs5wb9gCPfHPvabjzxNIU+uECnh/2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bJKGrPfWMJBg5UFLSG1QcZqHA31Qery7kty9Iro05WyxeTIuNg+E6QyePVGGsjbhY
	 gdTC+IPNUF1MEumB4AoZq6jUHE8bdJBs/KFwQt5AmIEfYO5G4kfyWbItbMhHRK5nFm
	 wmlGEUPsy7ywn71yvi03E58vGu/ul1kwgIpVh6+AV77ItEqW99Vd1B708rWHPom2Fu
	 1oWYHlg7QHc8/YMO0+jjZNaGmtGTtUdMFrz3WS4HmIxSi1n5tETkR8uuxLhr+B5spe
	 1ffIOaksa5t13SPuFvvnldKfeodYdOjQuF9PXIhNwdBtYAquZ/XOSS2mSUywhfU3HS
	 T6UUGu3JCVxGQ==
Message-ID: <b527143b-6528-4817-9f48-9ee7ab874989@kernel.org>
Date: Tue, 18 Mar 2025 16:57:45 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: introduce zone capacity helper
To: Christoph Hellwig <hch@infradead.org>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
 axboe@kernel.dk, linux-block@vger.kernel.org
References: <cover.1742259006.git.naohiro.aota@wdc.com>
 <e0fa06613d4f39f85a64c75e5b4413ccfd725c4b.1742259006.git.naohiro.aota@wdc.com>
 <2a641d02-1d59-4e0b-9dcc-defb64548d1b@kernel.org>
 <Z9kKfpY0E-phdJ5G@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z9kKfpY0E-phdJ5G@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 2:54 PM, Christoph Hellwig wrote:
> On Tue, Mar 18, 2025 at 02:14:29PM +0900, Damien Le Moal wrote:
>> @pos is not the start of the zone, so this should be:
>>
>>  * disk_zone_capacity - returns the capacity of the zone containing @sect
>>
>> And rename pos to sect.
> 
> While we're nitpicking:  sect is a bit weird, the block layer usually
> spells it out as sectors (sect sounds too close to the german word for
> sparkling wine anyway :))

Given that this is not a number of sectors, "sector" would be the right name
then :)


-- 
Damien Le Moal
Western Digital Research


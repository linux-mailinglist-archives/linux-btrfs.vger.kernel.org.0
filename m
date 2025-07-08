Return-Path: <linux-btrfs+bounces-15309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82DEAFC1E4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 07:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8E64A4DE5
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 05:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF7213E6A;
	Tue,  8 Jul 2025 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAFxTRwq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89013B5AE
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951616; cv=none; b=Qw29L5KeRyQA5p+f9E112r++nI6UfWPaLTyvaoVRPohBA11poocrGVwmGYq+McPB+2v8TyQENqb5VWQ/DaKmEvdXdL/iqzP9K755O2nUSAaR1A1uANRWXlVMLjLI03LIHlBDaOyAUiQlH1qWmXy/ctiN61Fqh7+dBznsYpW5UXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951616; c=relaxed/simple;
	bh=Sd3ldc8rzu9F6L3Am0Cun7DM5XEGueKut+rqEfoSqX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hnb7AbaQd+W2NDEOYKBfcs6EiTYlvcKBdEfYTG1ubZM3Cl55g0XZF80sXn9zV91ryh7c3wXqcsVvE/epLWfwho8zxvC0E6esJroXZRQ4jmJZiNs54W2dBDs7S1UJ4JPR9ulRjEB9jaS2jCkv7JuyK7dVWPIEfnODxlzuVXejFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAFxTRwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0C5C4CEED;
	Tue,  8 Jul 2025 05:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751951616;
	bh=Sd3ldc8rzu9F6L3Am0Cun7DM5XEGueKut+rqEfoSqX0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=mAFxTRwqFWW00WwfL0k927EA13C7s1aqZKHAVx3/Mot51cJb+1jQ389PJJwHWlDUb
	 XGGxO64a7njvo7QTNsb95seRmJHRemaQVCZ1VNaOix1107PPOtbvyM6bZ4xl8pRu0d
	 /K83/zui3dBu0SBCkPSLHb9FA3udcWXv6KaGkdnExGxSiqb4/24cu5c7w/Qsq+j2+d
	 P2eq40a1PfUHqw3bq5ptqhvxehPiB5Bwj5vilvV/h3yFwqDkBKw5VyUaVrWb79l+63
	 /ARwjjy09/6xIpiGTI/+cFuJVMubzFSqBNQiv846WCwwQCZXfo9d4dcNl2xvAFhRgv
	 t2fEcM17AiI0w==
Message-ID: <67d78b3c-e170-4481-ac3f-78ac5a180c6e@kernel.org>
Date: Tue, 8 Jul 2025 14:11:20 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: zoned: fix write time activation failure for
 metadata block group
To: Naohiro Aota <Naohiro.Aota@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1751611657.git.naohiro.aota@wdc.com>
 <bb200206ae65453c68c2f3e316378838797e2502.1751611657.git.naohiro.aota@wdc.com>
 <980ce4d7-fa7e-4320-8816-ab22d8021415@kernel.org>
 <DB6EQDA4RP4A.2KNYOLWFW6HYR@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <DB6EQDA4RP4A.2KNYOLWFW6HYR@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 2:04 PM, Naohiro Aota wrote:
> On Mon Jul 7, 2025 at 12:33 PM JST, Damien Le Moal wrote:
>> On 7/7/25 11:44 AM, Naohiro Aota wrote:
>>> Since commit 13bb483d32ab ("btrfs: zoned: activate metadata block group on
>>> write time"), we activate a metadata block group on the write time. If the
>>
>> on the write time -> at write time
>>
>>> zone capacity is small enough, we can allocate the entire region before the
>>> first write. Then, we hit the btrfs_zoned_bg_is_full() in
>>> btrfs_zone_activate() and the activation fails.
>>>
>>> For a data block group, we already check the fullness condition in the
>>> caller side. And, the fullness check is not necessary for metadata's
>>> write-time activation. Replace it with a proper WARN.
>>
>> I am very confused by this explanation. If the BG is fully allocated before we
>> issue the first write, we still need to activate that BG, no ? So why the
>> WARN() ? That seems wrong to me. But I may not be understanding your
>> explanation, which means you need to clarify it :)
> 
> We activate a data block group before the allocation to simplify the
> write stage. So, activating a full block group should arise WARN.
> 
> OTOH, metadata block group is activated on the write stage. So, it is OK
> to have a full block group to be activated. Instead, it is WARN when we
> try to activate a partially written (meta_write_pointer != bg->start)
> block group.

OK. Please update the commit message with this to clarify.
Also, a comment in the coe would be nice to remind this to whoever read that
code :)

-- 
Damien Le Moal
Western Digital Research


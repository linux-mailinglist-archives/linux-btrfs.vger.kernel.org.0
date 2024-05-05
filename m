Return-Path: <linux-btrfs+bounces-4751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB018BC3B9
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 22:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A13B21A62
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8DC1E895;
	Sun,  5 May 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="l/AkBQpQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A576025
	for <linux-btrfs@vger.kernel.org>; Sun,  5 May 2024 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714941555; cv=none; b=qwK0OTFCMQ5Z4u9F4zluGbq3PFg5HrIQ3lrzEPghPx+1qoxw8zs9tosGql9d8QsKg52fu1U7p2Sg3wLPudNcLEq4YHXgkzg4/+PXMXiI2enMJcJuAZNqzMTwx2tELwMMia1rLelzrM0c9M5U1cfbF2BRbP2szi5RR5bt//YCsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714941555; c=relaxed/simple;
	bh=83ZyI1UQWavGsAJUzMPhIuW7RBI2gpRd9zRjsxqzuBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ad59HZgxiFXM1e1vm+UyUPslYpoTBLws7AhSpayoeINLGaVTnppBggnWEeZxImUsJ0trX3UhCx482GTaHcynnU+u8dK2h5LAVwkpjIRbiDs/hGfPVbIRreQpy1tkvMvRf1u+GRwsL16WHnHRngIaaySHKQ7Orkn6QZv+7UPjU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=l/AkBQpQ; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4VXbnf33wnzDqKb;
	Sun,  5 May 2024 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1714941158; bh=83ZyI1UQWavGsAJUzMPhIuW7RBI2gpRd9zRjsxqzuBk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=l/AkBQpQA2zKGB6DwGuBvsmG46oDHntpyZd9j9Qo1Ql7z6Ax7Bwq75hYptqJTdbsa
	 N3v1SZsm61bhrCbwhgeFHPCMcB2bhEfpV+ZtQa4rsvhcGvRx0JGYxuvdyYEudIPIc6
	 WDdYRNR1OiFWCThg5diU3iWNfXGccAIXG0OIkO8E=
X-Riseup-User-ID: 6F3485521ADF08A27BCB71C19CA75A6D4259A78F29866706EE676C8124F0EE55
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4VXbnf1c21zJvM8;
	Sun,  5 May 2024 20:32:38 +0000 (UTC)
Message-ID: <7b7cf8e4-90ff-438d-817a-445ce13f5767@riseup.net>
Date: Sun, 5 May 2024 13:32:37 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Help with ROFS on Cache Folder Deletion
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <2236adc5-3520-4ceb-ad88-5bcc6afd18d0@riseup.net>
 <3b8eed12-0fb0-4bcd-9b32-1d04d89cc780@gmx.com>
Content-Language: en-US
From: Eliza May <eliza@riseup.net>
In-Reply-To: <3b8eed12-0fb0-4bcd-9b32-1d04d89cc780@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

I have run the tests, removed the failing ram, and the results are here:

https://termbin.com/rrsn

Is this recoverable with a repair?

(My other filesystem returned no errors, and is not included in this.)

Thank you,

Eliza


On 5/2/24 12:17 AM, Qu Wenruo wrote:
>
>
> 在 2024/5/2 15:59, Eliza May 写道:
>> Hi,
>>
>>
>> I am trying to remove the paru .cache folder from my computer, but every
>> time I do my btrfs filesystem goes read-only. Here is the dmesg output:
>> https://termbin.com/f4sw
>>
>> A scrub found no errors, and I have not yet ran a check -- I will be
>> doing so and reporting back when I figure out how to do so.
>>
>>
>> My filesystem is a main partition, a separate home subvolume, a var/log
>> subvolume, and a /var/cache/pacman/pkg subfolder, but I am attempting to
>> delete the paru one; not the pacman one.
>>
>>
>> If there are any other logs or details I should include, let me know.
>
> The dump tree shows:
>
> [ 1623.783513]     item 97 key (3069062266880 169 0) itemoff 13049 
> itemsize 33
> [ 1623.783514]         extent refs 1 gen 1396868 flags 2
> [ 1623.783515]         ref#0: tree block backref root 16391
> ...
> [ 1623.783683] BTRFS critical (device nvme0n1p2: state EA): unable to
> find ref byte nr 3069062266880 parent 0 root 7 owner 0 offset 0 slot 98
>
> This means the bytenr 3069062266880 should have a tree backref for 
> root 7.
> But the dump tree shows it belongs to root 16391.
>
> Furthermore this looks like a memory biflip:
>
> hex(7)     = 0x0007
> hex(16391) = 0x4007
>
> So please unmount all your fs and run a memtest first to make sure your
> hardware memory is working correctly.
> And do necessary memory replacement (if possible).
>
> Then finally run "btrfs check --readonly" for the unmounted fs, to make
> sure that is the only error (please paste the output).
>
> Then we can determine if it's safe to run "btrfs check --repair" or
> there are too many corruption and can only do a data salvage.
> (I bet a repair can be done, but still want to be sure)
>
> Thanks,
> Qu
>>
>>
>> Thank you,
>>
>> Eliza
>>
>>


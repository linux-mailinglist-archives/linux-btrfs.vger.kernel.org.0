Return-Path: <linux-btrfs+bounces-19037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A6C61230
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Nov 2025 10:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F02584E62AE
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Nov 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A1C252904;
	Sun, 16 Nov 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="RAQ2fB+K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ab3.no (mail.ab3.no [176.58.113.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF3924A066
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Nov 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.58.113.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763286400; cv=none; b=ANjEfCyQG7ng+CgS3dECE5LZWHJzuaHuAm593MUbUzGwUs9Gw3f+mLZJFUlVn+MT6zGYYQhPXQyvbkyNTmXkSWnYKbnrOfAlN9Y2TrpyUEKxZvou9plAZlce2agOxejwPAYr/DoyuitxNtSBb85GDVePOCX6IWKGx0Mz950qsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763286400; c=relaxed/simple;
	bh=JaPPbMEk6h+fpyWVyOzdp1TSYvB+pBs9m/FKvf992Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0hqmRt4cSpiWkw+X7+AwSC48E2RXFgHHGf5fJxlmoc+BWnTqOOUp4iV9DGk+YZygaMBlC+U/IUYnzT7lr8RAWdBw6g4yJSA4kyYa7H05YDLE31zKJ1c9cz6qOY2Gy/TUkrxMsUIO1jSDxq7k1ygjrHhcC28x5SW7xyi3BUWwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ab3.no; spf=pass smtp.mailfrom=ab3.no; dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b=RAQ2fB+K; arc=none smtp.client-ip=176.58.113.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ab3.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ab3.no
X-Virus-Scanned: amavisd-new at ab3.no
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no 59AD7508CAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
	t=1763286027; bh=JaPPbMEk6h+fpyWVyOzdp1TSYvB+pBs9m/FKvf992Y8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RAQ2fB+KDmG+iszEqxbjSi3iYMoqlsvByEJGHiIrHbpZpK1kVVgDaZTVqkMn34YPF
	 nARPX01vBOWd92Jx9X3ckF3YWP5irI6cO1dyfvV3vwmuHl3ripY38E0CW7G1EZ6zoM
	 4he4k3iW3sQeobR6MA73ctsCoyWZEq6TnmZ3Jo4w=
Message-ID: <98194f37-b26e-4509-9c5d-0e60d7bfc2a9@ab3.no>
Date: Sun, 16 Nov 2025 10:40:23 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BTRFS critical (device sda): bad key order, sibling blocks, left
 last (4382045401088 230 4096) right first (4382045396992 230 4096)
Content-Language: en-US
To: Johannes Thumshirn <jth@kernel.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
References: <c00b7f69-6a21-455b-aab2-dafcd1194346@ab3.no>
 <6ced26e8-ffae-488f-b910-f332f1190430@wdc.com>
 <1686db22f997609b3cbdc3923a1e9a5b@ab3.no> <aOO9VwS8IntK4fIX@mayhem.fritz.box>
From: =?UTF-8?Q?Mads_L=C3=B8nsethagen?= <mads@ab3.no>
In-Reply-To: <aOO9VwS8IntK4fIX@mayhem.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Just to update on this, it seems like the file system has entered a
state where it struggles with new, big files. If I scp a file to it a
few GBs big, and then run e.g. sha256sum on it right afterwards, I get

sha256sum: "bigfile": Input/output error

straight away. Can't see anything in dmesg either..

It was like this on 6.14.5, and also on 6.17.8 which I just updated to
to test.

- Mads


On 10/6/25 15:00, Johannes Thumshirn wrote:
> On Sun, Oct 05, 2025 at 12:25:56PM +0200, Mads wrote:
>> On 2025-05-05 11:25, Johannes Thumshirn wrote:
>>> On 05.05.25 11:00, Mads wrote:
>>>> Hi!
>>>>
>>>> Tested out creating a raid1 with raid stripe tree enabled on 6.14.5
>>>> (aarch64):
>>>
>>> Thanks for the report.
>>>
>>> Please be aware RAID stripe tree is an experimental feature and should
>>> not be used in production yet.
>>>
>>>>> # mkfs.btrfs -d raid1 -m raid1 -O raid-stripe-tree,raid56 /dev/sda
>>>
>>> Out of pure curiosity, why raid56? It's not supported with RST yet. I do
>>> have a prototype but that's only supports full stripe size writes yet.
>>>
>>> [...]
>>>
>>>> You can find the complete dmesg here:
>>>> http://cwillu.com:8080/92.220.197.228/1
>>>
>>> Thanks a lot, I'll see if I can come up with a minimal reproducer for
>>> it.
>>>
>>>> I don't know if this is related to enabling raid stripe tree, or
>>>> something else.
>>>
>>> Yes this is a RAID stripe tree bug and I thought I had it fixed already.
>>> Apparently not.
>>
>> Just thought I should check in on this - do you remember if there's been any
>> work done on RST that might do something about this bug? I haven't updated
>> the kernel since I reported this, so I just thought I should check in and
>> hear if there's any point to testing out a new kernel or not.
> 
> Unfortunately I haven't found a fix yet, no.
> 


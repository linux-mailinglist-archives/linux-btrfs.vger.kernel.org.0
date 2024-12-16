Return-Path: <linux-btrfs+bounces-10410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F08E9F3713
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2081647B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80E204573;
	Mon, 16 Dec 2024 17:12:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E302AD2C
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369145; cv=none; b=Hv7BOqiifpD7QvzgTQIpbDzpN96eM5Jcc1ZSXjyQ1gL7aWF0AUHajlmh9lrXK3e+FC7oOEezA90CANFsBpSDQw5EaBdkeZaTVChfAD5DJbNNdohrN459xDyUavnVLV9vMyr3oXcCNbIvlI6aooe/HM2AAOdXYnb83R0/hpPSERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369145; c=relaxed/simple;
	bh=5jiO4MN6BkygwvQL///aUuwNclgrQSvaueiDivQdCwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tQXueWJ8FW+PllmgYicC5hzuZhItPAi/wQLCjtZh88b1HDU4u8ctfTmAxpKipqMr9xebGJET6T8je5B1lbniLoemJ943A9x8fUKrx6x/3TqnVOJ+HZIjln3G95lVB69WQyYFOpVtqgCWJOBqQG5IhpSydKY03grXle6s/HqHCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 8E1CDC11E67
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:12:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fnkvjdnI0_MS for <linux-btrfs@vger.kernel.org>;
	Mon, 16 Dec 2024 18:12:10 +0100 (CET)
Received: from [192.168.55.34] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id A5225C11E66
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:12:10 +0100 (CET)
Message-ID: <ea8eb95c-e64a-4589-b302-23eb1fc6bd5c@dubiel.pl>
Date: Mon, 16 Dec 2024 18:12:08 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 97% full system, dusage didn't help, musage strange
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
 <8c923965-f47c-4b4c-b096-9ddc0f047385@gmail.com>
 <4144f14a-8742-4092-b558-d1a9de4d03e5@dubiel.pl>
 <8eb9e55e-7a61-4c1a-b5ab-acf35ba4396e@gmx.com>
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <8eb9e55e-7a61-4c1a-b5ab-acf35ba4396e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>
>> It failed now — there is 258 GB free, but balancing didn't help to
>> restore unallocated space.
>
> Because there isn't that much free space to reclaim in the first place.
>
> Your data and metadata chunks are already very highly utilized, you can
> increase the dusage/musage and retry, but they will only bring marginal
> gain if any.
>
> The only way to go next is start deleting more
> snapshots/subvolumes/files/etc.
>
> With more data/metadata space released, then try musage/dusage again
> which can free up some space.

This helped.
Thank you.



My system was deleting shapshots automatically if there was less then 
250 GB free space.
This procedure worked fine — 258 GB was free.

Second procedure was balancing system if there was less then 8GB of 
Unallocated space.
This procedure couldn't reclaim free space to makie it unallocated.




How to improve?

Tell the first procedure to keep 500GB free space? 800GB?

Or change the procedure to look at percentage of free disk space?
What is optimal? 90% should be maximum of occupied?

This is system for backups, so this could be almost full.








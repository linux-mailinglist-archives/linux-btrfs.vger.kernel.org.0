Return-Path: <linux-btrfs+bounces-11265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E931A26C61
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 08:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3AAA7A42B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05365203710;
	Tue,  4 Feb 2025 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="Dqf8Dj7G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24DE4CB5B
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738652694; cv=none; b=hqAZj9XE7ASOTJ0usemPbSvYN6gl9ua4Z4jGB0bvS1Z6nFQETe6BmGS1PLp2aktUJ703p8+Je89JnrTHx0bCHGpOLwIz6w/V753Y+zO5EpT51Fw6vBuulve6Chl4mAvj5c4DRLnul+7mC1sQOZiMfDDhi5YPjpnFDsdY0qrqCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738652694; c=relaxed/simple;
	bh=GjDdQHZFLxrezM1gtvmJ4coA9Goo8i2ObY5aQlmIdls=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fEzW+r0WsdYWK5Dbcuw73tYFj3pw5ptpOwpgdkN1os8X2sH8C0q/4xfrhSp3BxUlbwSbVI2As2rOHt9eL23OA5RSLa4NHD6Mnc1kWjrTzqFvTxyM1TPCHqysRJBkf7UOWgOsJqI5xgbj9+uUngGAUrS5DnbpmnPhW8Oe/pSGfB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=Dqf8Dj7G; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cYoDFMVcnPXwdFuDtZs9iMkVTWfULRwGBytb3DMfYBU=; b=Dqf8Dj7GFccrNR9HZUWDjd+S/b
	BrOcREFAeiY/iN3iBoup1Csiiz2nzfQx0mt0OORgFn03vlqw/ftxmabS6OvUhJ7eOx+CeuV1MBPGi
	O9SlYLFix2Qv5ZxS2dibNybBcT2v/b1/TmzUhvw8Y+NgQ/31wpXgzlFNdGIvT+TovB640pF0rTk+u
	nBHQyxepflDYpIJ9v5z0EbNp550BisrFQ/al/d9uXFUVlX6QDXximkqbV1fJIhnMOiRLTfagXZZQ5
	g+0n8OnAjlgZ+US62Iqxnv8Gr34l+vcYDcwPMBpRyOG9164y1KgB1OwW8ss6Xrbxx9oV8PzoY8CDp
	4HGAlRVQ==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1tfCzF-0002PJ-NV
	for linux-btrfs@vger.kernel.org; Tue, 04 Feb 2025 07:04:46 +0000
Message-ID: <683e37e3-c90e-4865-8704-9d6905c04560@zetafleet.com>
Date: Tue, 4 Feb 2025 01:04:44 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting RAID1 to single fails if RAID1 is missing device
To: linux-btrfs@vger.kernel.org
References: <2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name>
 <d300d923-ed8c-4671-9694-6850d8c9b572@gmx.com>
 <92dbe939-46a6-4142-b6be-3ef69fffce1b@gmail.com>
 <23f97ef3-5d4e-411e-abb3-9725d7f92238@gmx.com>
 <ef9dfa64-63f8-47ad-9857-d40aecb20546@zetafleet.com>
 <48bf3e3c-52a5-4fec-b399-93ababfa025d@gmx.com>
Content-Language: en-GB
From: Colin S <linux-btrfs-ml@zetafleet.com>
In-Reply-To: <48bf3e3c-52a5-4fec-b399-93ababfa025d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.9
X-Spam-Report: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9,NO_RELAYS=-0.001 autolearn=ham autolearn_force=no version=3.4.2

On 03/02/2025 00:13, Qu Wenruo wrote:
>
>
> 在 2025/2/3 15:52, Colin S 写道:
>> On 02/02/2025 20:32, Qu Wenruo wrote:
>>>
>>> But I think the ultimate solution is to make btrfs to properly detect
>>> and support device shut down request.
>>
>> Yes. How many years and how many more users need to have this problem
>> before it’s given some priority?
>
> Complaining is so easy that some one doesn't even know what's going
> wrong can do.

Please understand that I am acting in good faith to try to make btrfs 
better. I do not want to complain, I want to solve this problem. I sent 
ideas to the list that I thought were sound several times and didn’t see 
any btrfs developer respond at all. Did I miss a reply? If so, I 
apologise for the missed connection on my end, and will look to the 
archive for such a message if you tell me so. Otherwise, I’d like it if 
you could answer my question, please, so I can understand what is 
missing to give this priority?

I don’t think this specific case where btrfs doesn’t notice the device 
has gone away because it doesn’t implement a callback can be separated 
from the larger problem because implementing that callback correctly 
(i.e. with no data loss, corruption, or risk of split-brain) depends on 
btrfs tracking writes better than it does now. If this seems confusing 
or wrong, let me know so I can try to understand and say more.

>>
>>> Although that would also introduce new complexity, e.g. what if the
>>> missing devices show up again after missing several writes?
>>
>> Since I see you wrote a patch in 2022 to add write-intent bitmap for
>> raid5/6, don’t you already understand the answer is a write-intent
>> bitmap? Further, did you not see any of the several messages I have sent
>> to the mailing list talking about exactly this in the last year? I am
>> genuinely confused.
>>
>
>
> It's completely a different bug.
>
> It doesn't even have RAID56 involved.

Are you saying this because the abandoned implementation relied on 
raid5/6 stripes? A write-intent bitmap, as a general concept, doesn’t 
require parity as far as I know, so I don’t understand this statement 
right now.

> And write-intent bitmap is not the solution at all. It doesn't support
> things like zoned device support (which is now part of the core btrfs
> functionality).

How so?

> Knowing what you don't know is important.

I agree. Knowing what I don’t know is the explicit reason I gave in the 
past about why I wouldn’t even attempt to implement and send any patch 
on my own. I don’t mind being wrong since it means I get to learn, but I 
can’t learn a thing from a browbeating.

Best,


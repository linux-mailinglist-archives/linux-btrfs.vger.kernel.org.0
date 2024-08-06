Return-Path: <linux-btrfs+bounces-7008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AEC949528
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 18:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8350C284554
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8282494;
	Tue,  6 Aug 2024 16:02:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263E80043
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960143; cv=none; b=UOp/Oph0v0Vh5/JTntxJRR/BueZabGYp90dBXnyAhHoGkUtID2x+ICWtzZF9FnhxcD9aejzt9CsFg2UWlBiu4ijDWR0s20Q0Bpt7XKKo+T4TccOExtopC/9btuMFQMW7uTheuJRYedwAm5W4niij6JVqgYH1zQZHFpgo/LCQZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960143; c=relaxed/simple;
	bh=OVfPtrnwRyQLdmw58U4V6S9ATnSChqbtZmPeVhEArME=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uXMxJknVlp0Q9DwaFwrGIHRgwJ77bsJuO6Ys/0tElGmOuMN8feXKYMndxTdLOFuS7u9ptJ53XDl1OeT/FoFFKbjastvMY8VpJosZl0izEENvcjSxUdXh7QRefnEdhTXXTqr7JHgOqKxi5Xx0qDx4fRcF+WwSvVUIQ1bajeG2uSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [10.42.0.125] (dynamic-176-003-143-190.176.3.pool.telefonica.de [176.3.143.190])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 96BA7180686;
	Tue,  6 Aug 2024 16:02:11 +0000 (UTC)
Message-ID: <ad8a9333-8732-4d78-a86b-22dea00aabbe@horse64.org>
Date: Tue, 6 Aug 2024 18:02:12 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs corruption issue on Pine64 PinePhone
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
 <b9103729-c51a-487f-8360-e49d3e9fc5e4@horse64.org>
 <e53fdb4e-bbb2-4777-b822-f1173dfed3db@gmx.com>
 <7d692229-d3d5-4b82-a70a-b7371c8724f0@horse64.org>
 <1e96ef22-b51d-488a-ab90-84fd85c981ea@gmx.com>
Content-Language: en-US
From: ellie <el@horse64.org>
In-Reply-To: <1e96ef22-b51d-488a-ab90-84fd85c981ea@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/5/24 08:34, Qu Wenruo wrote:
> 
> 
> 在 2024/8/5 15:50, ellie 写道:
>>
>>
>> On 8/5/24 08:10, Qu Wenruo wrote:
>>>
>>>
>>> 在 2024/8/5 15:25, ellie 写道:
>>>> On 8/5/24 07:39, ellie wrote:
>>>>> Dear kernel list,
>>>>>
>>>>> I'm hoping this is the right place to sent this. But there seems to be
>>>>> a btrfs corruption issue on the Pine64 PinePhone:
>>>>>
>>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/3058
>>>>>
>>>>> The kernel is 6.9.10, I wouldn't know what exact additional patches
>>>>> may be used by postmarketOS (which is based on Alpine). The device is
>>>>> the PinePhone revision 1.2a or newer https://wiki.pine64.org/wiki/
>>>>> PinePhone#Hardware_revisions sadly there doesn't seem to be a way to
>>>>> check in software if it's 1.2a or 1.2b, and I don't remember which
>>>>> it is.
>>>>>
>>>>> This is on an SD Card, so an inherently rather unreliable storage
>>>>> medium. However, I tried two cards from what I believe to be two
>>>>> different vendors, Lexar and SanDisk, and I'm seeing this with both.
>>>>>
>>>>> The PinePhone had various chipset instability issues before, like
>>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I believe
>>>>> has however been fixed since. I have no idea if that's relevant, I'm
>>>>> just pointing it out. I also don't know if other filesystems, like
>>>>> ext4 that I used before, might have also had corruption and just
>>>>> didn't detect it. Not that I ever noticed anything, but I'm not sure I
>>>>> necessarily ever would have.
>>>
>>> In the detailed report in pmOS issue, you mentioned it's a video file.
>>>
>>> I'm wondering if all the corruptions you see are from video files,
>>> especially if the video files are all recorded on the file.
>>>
>>> If that's the case, it may be related to the IO pattern, especially if
>>> the recording tool is using direct IO and didn't have proper writeback
>>> wait for those direct IO.
>>>
>>> Thanks,
>>> Qu
>>>
>>
>> Thanks so much for the quick input!
>>
>> All the files I mentioned in bug reports were written by syncthing, so
>> there wasn't any on-device video recording involved. I once saw Nheko's
>> database file corrupt however, so it's apparently not limited to
>> syncthing. I'm guessing video files are affected so often simply due to
>> their large size.
> 
> I did a quick clone and search of syncthing.
> 
> There is no usage of O_DIRECT directly, so I guess it's not the known
> csum mismatch caused by bad sync of direct IO writeback.
> 
> In that case, since the corrupted file is syncthing synchronized, can
> you do a diff of the binary data?
> 
> To avoid the EIO from btrfs, you can use "-o rescue=all,ro" to mount the
> sdcard on another system, then compare the binary.
> (e.g. "xxd file.good > good.xxd; xxd file.bad > bad.xxd; diff *.xxd")
> 
> At this stage, we need to find out what's really causing the problem,
> the btrfs itself or some thing lower level.
> (I strongly hope it's not btrfs, but either way it's not going to end up
> well)
> 
> Thanks,
> Qu
Thanks for your detailed instructions! I was about to do as you said and 
ran the sync for a few hours, stopped it, and planned to run btrfs scrub 
this evening. However, I then ran into a hard shutdown due to what might 
be an upower bug (won't lie, was very annoyed at that point):

https://gitlab.com/postmarketOS/pmaports/-/issues/3073

Should I still attach a diff for an affected file I find now? Or are the 
results going to be worthless if there was a hard shutdown in between, 
and I need to first fix the filesystem, repeat the sync test, and repeat 
finding a new corruption error to diff?

Regards,

Ellie



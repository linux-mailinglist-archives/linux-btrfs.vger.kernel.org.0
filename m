Return-Path: <linux-btrfs+bounces-7047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1558494BC4E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 13:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA87B20E49
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A742318B46D;
	Thu,  8 Aug 2024 11:32:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568618D651
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116724; cv=none; b=uqJLZvRBZUSPGNu1ZwiiKcpkL5ZX8ZJcKg9mh+dFG/0hpyY07Z3i8b8tybOX6wbJBmhEJLoRKLzxUCcxTWJ4v1OyEkeLx2FAyDFNNhXU/OK+BMsTTTiCPwbTJfC2vXscqSY80nTkUjs8JDo8vNN3QQ0M5OKTvLt4yB/twzQAXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116724; c=relaxed/simple;
	bh=e7bh/ZUTa/D2dg2xXata62WYBafHkWCL+oYmFEDyD+c=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=e1ormmPLxrtcj8wJdgX3zIh6yYiPgI1UCYXQITvbhhEeDneEVmqxhnN6cNYjrS1Fg4t2ZhhfF4AouxNSca0hjTzr0TSb9MwGN2mvsbnb0+sVCEvYEJkK/lDCAxC1r1T71+DuzrX/MORV20K5BAmpXED30c3bnn3NV0aOHk1zqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [10.42.0.125] (dynamic-176-003-138-123.176.3.pool.telefonica.de [176.3.138.123])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 2253A180686;
	Thu,  8 Aug 2024 11:31:52 +0000 (UTC)
Message-ID: <78b10401-1366-4551-9e5f-4c480baa0727@horse64.org>
Date: Thu, 8 Aug 2024 13:31:52 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
 <b9103729-c51a-487f-8360-e49d3e9fc5e4@horse64.org>
 <e53fdb4e-bbb2-4777-b822-f1173dfed3db@gmx.com>
 <7d692229-d3d5-4b82-a70a-b7371c8724f0@horse64.org>
 <1e96ef22-b51d-488a-ab90-84fd85c981ea@gmx.com>
 <ad8a9333-8732-4d78-a86b-22dea00aabbe@horse64.org>
 <716c3de3-63be-420e-b11e-cfd3eab9aea9@gmx.com>
Content-Language: en-US
From: ellie <el@horse64.org>
Autocrypt: addr=el@horse64.org; keydata=
 xjMEZov4ABYJKwYBBAHaRw8BAQdAV+B+D8EgzDouy2nDV3ZvoAlfCdXDgPc77jwQv8WFOyHN
 FkVsbGllIDxlbEBob3JzZTY0Lm9yZz7CmQQTFgoAQRYhBDNofAurx9gz4zmiYhX8ptnSOysI
 BQJms8/gAhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEBX8ptnSOysI
 b7wA+wQhy6Lj9JCexdVPLLMQv9y+vejB3OYpox6tV19rU+ffAP9taH6xTmdHdHWxrz9zeOla
 2GukGmQnoByXYegyHewZAc44BGaL+AASCisGAQQBl1UBBQEBB0Armcmr+4Ez2zZ9nMioqYvX
 RVLppRFfo8ATE0A/j7a7ZAMBCAfCfgQYFgoAJhYhBDNofAurx9gz4zmiYhX8ptnSOysIBQJm
 i/gAAhsMBQkJZgGAAAoJEBX8ptnSOysI+eEBAO1fxPkHNeZiOEBcMmtEpAXy66NYYF/eB9ed
 p2EuK4M4AP9BjkOGJH6Ujk4Q6Hb+9YGX9CH0vjxqfplc8B/WUYG8CQ==
Subject: Re: btrfs corruption issue on Pine64 PinePhone
In-Reply-To: <716c3de3-63be-420e-b11e-cfd3eab9aea9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/24 23:55, Qu Wenruo wrote:
> 
> 
> 在 2024/8/7 01:32, ellie 写道:
>>
>>
>> On 8/5/24 08:34, Qu Wenruo wrote:
>>>
>>>
>>> 在 2024/8/5 15:50, ellie 写道:
>>>>
>>>>
>>>> On 8/5/24 08:10, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> 在 2024/8/5 15:25, ellie 写道:
>>>>>> On 8/5/24 07:39, ellie wrote:
>>>>>>> Dear kernel list,
>>>>>>>
>>>>>>> I'm hoping this is the right place to sent this. But there seems
>>>>>>> to be
>>>>>>> a btrfs corruption issue on the Pine64 PinePhone:
>>>>>>>
>>>>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/3058
>>>>>>>
>>>>>>> The kernel is 6.9.10, I wouldn't know what exact additional patches
>>>>>>> may be used by postmarketOS (which is based on Alpine). The 
>>>>>>> device is
>>>>>>> the PinePhone revision 1.2a or newer https://wiki.pine64.org/wiki/
>>>>>>> PinePhone#Hardware_revisions sadly there doesn't seem to be a way to
>>>>>>> check in software if it's 1.2a or 1.2b, and I don't remember which
>>>>>>> it is.
>>>>>>>
>>>>>>> This is on an SD Card, so an inherently rather unreliable storage
>>>>>>> medium. However, I tried two cards from what I believe to be two
>>>>>>> different vendors, Lexar and SanDisk, and I'm seeing this with both.
>>>>>>>
>>>>>>> The PinePhone had various chipset instability issues before, like
>>>>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I 
>>>>>>> believe
>>>>>>> has however been fixed since. I have no idea if that's relevant, I'm
>>>>>>> just pointing it out. I also don't know if other filesystems, like
>>>>>>> ext4 that I used before, might have also had corruption and just
>>>>>>> didn't detect it. Not that I ever noticed anything, but I'm not
>>>>>>> sure I
>>>>>>> necessarily ever would have.
>>>>>
>>>>> In the detailed report in pmOS issue, you mentioned it's a video file.
>>>>>
>>>>> I'm wondering if all the corruptions you see are from video files,
>>>>> especially if the video files are all recorded on the file.
>>>>>
>>>>> If that's the case, it may be related to the IO pattern, especially if
>>>>> the recording tool is using direct IO and didn't have proper writeback
>>>>> wait for those direct IO.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>
>>>> Thanks so much for the quick input!
>>>>
>>>> All the files I mentioned in bug reports were written by syncthing, so
>>>> there wasn't any on-device video recording involved. I once saw Nheko's
>>>> database file corrupt however, so it's apparently not limited to
>>>> syncthing. I'm guessing video files are affected so often simply due to
>>>> their large size.
>>>
>>> I did a quick clone and search of syncthing.
>>>
>>> There is no usage of O_DIRECT directly, so I guess it's not the known
>>> csum mismatch caused by bad sync of direct IO writeback.
>>>
>>> In that case, since the corrupted file is syncthing synchronized, can
>>> you do a diff of the binary data?
>>>
>>> To avoid the EIO from btrfs, you can use "-o rescue=all,ro" to mount the
>>> sdcard on another system, then compare the binary.
>>> (e.g. "xxd file.good > good.xxd; xxd file.bad > bad.xxd; diff *.xxd")
>>>
>>> At this stage, we need to find out what's really causing the problem,
>>> the btrfs itself or some thing lower level.
>>> (I strongly hope it's not btrfs, but either way it's not going to end up
>>> well)
>>>
>>> Thanks,
>>> Qu
>> Thanks for your detailed instructions! I was about to do as you said and
>> ran the sync for a few hours, stopped it, and planned to run btrfs scrub
>> this evening. However, I then ran into a hard shutdown due to what might
>> be an upower bug (won't lie, was very annoyed at that point):
>>
>> https://gitlab.com/postmarketOS/pmaports/-/issues/3073
>>
>> Should I still attach a diff for an affected file I find now? Or are the
>> results going to be worthless if there was a hard shutdown in between,
>> and I need to first fix the filesystem, repeat the sync test, and repeat
>> finding a new corruption error to diff?
> 
> As long as you didn't touch those files, and scrub still reports errors
> on that file, the diff is still very helpful to provide some clue.
> 

I finally had a new corrupted file pop up, this was actually after any 
unintended sudden shutdown so there shouldn't be any interference from that:

[128958.860335] BTRFS error (device dm-0): unable to fixup (regular) 
error at logical 133906497536 on dev /dev/mapper/root physical 135089684480
[128958.862548] BTRFS warning (device dm-0): checksum error at logical 
133906497536 on dev /dev/mapper/root, physical 135089684480, root 257, 
inode 331715, offset 102400, length 4096, links 1 (path: 
ellie/Music/Baldur's Gate (2) II Shadows of Amn (2000)/06 City Gates.mp3)

However, when manually mounting the file on the computer where it 
originates from and where the undamaged original file is:

/mnt # mount -t btrfs -o rescue=all,ro,subvol=/@home,defaults 
/dev/mapper/blamap p64
/mnt # ls p64/
ellie
/mnt # cp p64/ellie/Music/Baldur\'s\ Gate\ \(2\)\ II\ Shadows\ of\ Amn\ 
\(2000\)/06\ City\ Gates.mp3 ./
/mnt # diff 06\ City\ Gates.mp3 /home/ellie/Music/Baldur\'s\ Gate\ 
\(2\)\ II\ Shadows\ of\ Amn\ \(2000\)/06\ City\ Gates.mp3
/mnt # diff 06\ City\ Gates.mp3 /home/ellie/Music/Baldur\'s\ Gate\ 
\(2\)\ II\ Shadows\ of\ Amn\ \(2000\)/06\ City\ Gates.mp3
/mnt #

It seems like file is exactly the same, which I assume isn't meant to 
happen.

I'm not sure what that implies, but I hope it's helpful info!

Regards,

Ellie



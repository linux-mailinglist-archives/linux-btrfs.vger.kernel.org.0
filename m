Return-Path: <linux-btrfs+bounces-10440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B68F9F3DC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 23:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03EB188933E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 22:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6C81D89F7;
	Mon, 16 Dec 2024 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=horse64.org header.i=@horse64.org header.b="NMASQLv0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46E1D61B7
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389591; cv=none; b=arBz9ycWJEaHVjOG3y7UvUbcDhgw1ICk08N20lprAS0/ok/0xkO62DD6Le+VJQysQTn/RgPp6C68QLAfewlCa9dbFyZNCxCy736Zh0/JxbATAnQJ5a4rWsdAbYVBhNYFZJ9zEDcvRACLXKqiYV9JZCzDq1i3Z6fgYShyEsnZDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389591; c=relaxed/simple;
	bh=zgegk6XS/04wSFs8NQaLD+0z/8/PZHenfnJeno8Iw8c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=WrJEiVqtm977TSDJTgEkAt0bqEcdDM+39s8NeRN6Bt2/rf8esvYhmgg53A7/Lj4myKUBJQ+3N+kJixc3zTk3XLol9IGaoTqrAuHQCCmT79nj0oHOnZs46MQCVMdFkWNaySxZbyUrY4RoxDzCtAzb8FBeZSsJPklEwa7ZsgbNJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; dkim=pass (4096-bit key) header.d=horse64.org header.i=@horse64.org header.b=NMASQLv0; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [10.42.0.229] (dynamic-176-003-154-216.176.3.pool.telefonica.de [176.3.154.216])
	by mail.ekdawn.com (Postfix) with ESMTPSA id C1BDA183024
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 22:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=horse64.org; s=dkim1;
	t=1734389596; bh=zgegk6XS/04wSFs8NQaLD+0z/8/PZHenfnJeno8Iw8c=;
	h=Message-ID:Date:Subject:From:To:From:Sender:To:CC:Subject:
	 Message-Id:Date;
	b=NMASQLv0sJO9IxYMyBWy6C9C7cmI3imc2KN7N0B5gvY+qe4IKgvopPoGWJiXNJBzx
	 /BybUHVf47LMxUsNyzEENE/aavl7pMSew3/LzQYds3Ym9b0o/OiTIEwngwkQpVzMkU
	 hH0qQodRJgRlrD1oL/cLP//mWcPJZeOBnSpe0NODmgjtcK2vQicpG2zJfnWNASEfQX
	 4cztmcEg75qHDK+jRoXs7Ok6J6O0mnSUck5TEg8UgcDl9F/id5EELWgWZhGIOkSIHl
	 M+WRMwrpTKb4mZrJMSJ4XShx+4ZukKdiNVxQz77SZTnkzW+roxKNJW18XbSQaewSZW
	 CPY07df1S6IqYRd6Sr91vXd/9P2iGWtAFniwRquzsKYE4XMhVME4dFa/HuC34EcQrj
	 6PQs1EY9nAMwRwu4/6LcrYNEZrxYy9tObd9goHxDbq2pKBl1flua9Vfmiba3nu0kS/
	 2sVe7nBcXTBV2WEXlf10fiwfHT6uYXBrX5Ck+IYyrqzYh+rGLs1YBWZ2m2oW1w1OhI
	 OY+uDugvPVVI4jjvrm1j28xqAYThQJ7o8Ql66AkZBZ1tXX3FRLa+2X3hBE1qRCBYDI
	 B+DZ+Xn6o+HxLfuR/G8UlgvmKpkEJLJP6Y98Ez32Rjv4tWx6HHpFUK12HP4aQNU+fo
	 2k31y3XcZiJwKn0ZH1HF8XvQ=
Message-ID: <75c3ac8e-11c0-44fb-96cc-8205532c6e9a@horse64.org>
Date: Mon, 16 Dec 2024 23:53:02 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: BTRFS hangs and causes semi-freezes on PinePhone
From: Ellie <el@horse64.org>
To: linux-btrfs@vger.kernel.org
References: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
 <48390596-364e-48a1-868a-4e77b81bdef6@horse64.org>
Content-Language: en-US
In-Reply-To: <48390596-364e-48a1-868a-4e77b81bdef6@horse64.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've had to hard reset the device a few times because it became so slow, 
I couldn't easily log in anymore. The culprit seems to be BTRFS read 
perf, because when I manage to terminate read-heavy applications it 
usually recovers, and I didn't have this problem with EXT4.

(It's not like the reads ever fully freeze, but they're so slow that 
apps including the lock screen will hang for multiple seconds up to a 
minute or so whenever they seem to try to access things on disk.)

Regards,

Ellie

On 10/2/24 9:20 AM, ellie wrote:
> An update: I've largely ignored the corruption issue for now, which is 
> somewhat feasible since outside of large write loads for a longer time 
> it doesn't seem to happen.
> 
> But there seems to be another larger issue with btrfs on this device. 
> When syncthing scans on all its threads seemingly maxing out I/O at 
> least according to iotop, all other apps including Phosh (the window 
> manager) freeze eveery 5 seconds or so for long 10+ seconds durations. 
> It seems like syncthing simply reading blocks vital reads for even just 
> basic continued operation of other processes. Something about its tuning 
> seems to fundamentally not work on this low spec hardware. With ext4, I 
> had no such issues.
> 
> Sorry if my rambling isn't useful, I'm not experienced at reporting 
> filesystem hiccups.
> 
> Regards,
> 
> Ellie
> 
> On 8/5/24 07:39, ellie wrote:
>> Dear kernel list,
>>
>> I'm hoping this is the right place to sent this. But there seems to be 
>> a btrfs corruption issue on the Pine64 PinePhone:
>>
>> https://gitlab.com/postmarketOS/pmaports/-/issues/3058
>>
>> The kernel is 6.9.10, I wouldn't know what exact additional patches 
>> may be used by postmarketOS (which is based on Alpine). The device is 
>> the PinePhone revision 1.2a or newer https://wiki.pine64.org/wiki/ 
>> PinePhone#Hardware_revisions sadly there doesn't seem to be a way to 
>> check in software if it's 1.2a or 1.2b, and I don't remember which it is.
>>
>> This is on an SD Card, so an inherently rather unreliable storage 
>> medium. However, I tried two cards from what I believe to be two 
>> different vendors, Lexar and SanDisk, and I'm seeing this with both.
>>
>> The PinePhone had various chipset instability issues before, like
>> https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I believe 
>> has however been fixed since. I have no idea if that's relevant, I'm 
>> just pointing it out. I also don't know if other filesystems, like 
>> ext4 that I used before, might have also had corruption and just 
>> didn't detect it. Not that I ever noticed anything, but I'm not sure I 
>> necessarily ever would have.
>>
>> Regards,
>>
>> Ellie
>>
> 



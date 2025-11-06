Return-Path: <linux-btrfs+bounces-18758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A05BC3969F
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 08:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82D143444BA
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 07:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32BE28DB52;
	Thu,  6 Nov 2025 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=friedels.name header.i=@friedels.name header.b="VAETHdCo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sm-r-011-dus.org-dns.com (sm-r-011-dus.org-dns.com [84.19.1.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2034D3B5
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.19.1.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414486; cv=none; b=J2oHg3MbG3WVKhtZvnp8LrnqRwbO6cXLbFUtd+RNSYdki6XTJnt7BwHzL4/VQFV6tJipFK7YhdeGtErqF2XoJCZ8ABSDM8gAjxSdZfgv3fz7/DNjkyLjk+03ghGLzD86OeXu8qEhzCmrU57rnqQ83G+V/g442lq5+ul9QW0vbO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414486; c=relaxed/simple;
	bh=EWUqdvnJ+i54kcix/MHA+/LF4F8Zs6xXz+PTzD/cbbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P6mSdColtlu39j93hRIir6y0gAMYm3Y7J8v38bxiITVnhjm0ep2SCddOY+yxxbrv+C4HVPc97Q462jB6YSPA7DMoa2Bj3taLzA78v8aUVyhgCdong4mcZOcG7g58a+4SfQsB9hRtqhBSeudfZnn5//FHwTwo/GJugULyYaza1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=friedels.name; spf=pass smtp.mailfrom=friedels.name; dkim=pass (1024-bit key) header.d=friedels.name header.i=@friedels.name header.b=VAETHdCo; arc=none smtp.client-ip=84.19.1.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=friedels.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=friedels.name
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
	by smarthost-dus.org-dns.com (Postfix) with ESMTP id 041EEA37EB
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 08:29:03 +0100 (CET)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
	id E1299A3898; Thu,  6 Nov 2025 08:29:02 +0100 (CET)
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by smarthost-dus.org-dns.com (Postfix) with ESMTPS id 72E9BA37EB;
	Thu,  6 Nov 2025 08:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=friedels.name;
	s=default; t=1762414196;
	bh=81rjDGsDmU5PNgqs4vDZ23YQxAwbM425pRiiqnpZkTM=; h=Subject:To:From;
	b=VAETHdCoL/SbjG1QsgIh9GONEx2zWpwVfsR7TL5hkK0IcYDKrM4+o2C+BLFqdyhpk
	 pHbAp2OMAVQUjS599DsHRj1IkWNLuy14K0cBQ4gMFMTuFpTQlyRBNiFj6A8BiHhClF
	 z9GrRj/4SK42lVckXiCVr8fR/ZBby9zpKXqDkNZM=
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 88.65.226.178) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.137]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
Message-ID: <02fab723-6371-4c45-94ad-fa77ceed2003@friedels.name>
Date: Thu, 6 Nov 2025 08:29:02 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Corrupt Filesystem (Mirror) despite previously successful scrub
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
 <12716866-2ffe-4cbb-8e2f-8b2e4abd0237@app.fastmail.com>
 <a37cea05-f77f-41f1-8763-a28311b72790@friedels.name>
 <f6858f97-1fe2-49d7-b1ad-dc688142fdcb@app.fastmail.com>
 <eddf3273-d7f9-4bef-865d-dfec1d7ffb66@friedels.name>
 <27964904-b200-46d1-87c6-0dc5d8174036@app.fastmail.com>
 <9efd0399-62c3-4800-81c2-761c53592540@app.fastmail.com>
From: Hendrik Friedel <hendrik@friedels.name>
In-Reply-To: <9efd0399-62c3-4800-81c2-761c53592540@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <176241419628.1888657.7388621375358260600@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK

Hello Chris,

thanks for your reply. Much appreciated.

By the way: badblocks and smart long test on sdb passed.

My main worry is still whether the copy I made two weeks ago (with no 
errors I spotted on the commandline) is good or not.

> Btrfs doesn't permit corrupt data from getting to user space.
Good news! And I was under that impression until recently
> So I'm not sure why you think corruption has replicated from this source to a new destination.

Well, we suspect a filesystem corruption. I was/am not sure of the 
consequences.

My understanding is, that a fileystem corruption means a wrong table of 
contents. The pages are still ok and protected by csum. But the 
Filesystem may point to a wrong "page". But you explained that this is 
unlikely further below.

> What could happen is corrupt files are requested for transfer, Btrfs detects corrupt blocks, returns EIO to user space for those corrupt blocks, and the user space app just inserts holes for those blocks, or truncates the file at that point. So it should be pretty easy to discover from either the destination files having issues
But that is not easy! One needs to read each file with a tool that would 
detect issues. may be possible for a video or an image, but not for a 
textfile.
>   OR the journal history will contain btrfs errors for these transfers. Anytime data corruption is detected, Btrfs reports to dmesg with the exact root (subvolume) and inode an offset and block size. There is no reference to path to file in this case.

ok, what would I have to search for?

I found

Okt 14 11:39:26 homeserver kernel: BTRFS warning (device sda1): i/o 
error at logical 24389920346112 on dev /dev/sdb1, physical 23264022528, 
root 1382, inode 5800, offset 277139456, length 4096, links 1 (path: 
Mavic/GranCanaria/DJI_0019.MOV)
but I am not sure, whether it would always be i/o error.

>>> Over 2 million dropped writes on sda1? That doesn't tell us for sure they're missing, they might have gotten fixed later. But it's so many missing writes, that if there is even 1 copy wrong, corrupt, or missing on sdb1 then Btrfs can't fix itself.
>> This is what was causing me to be worried.
>>> No the file system could be inconsistent.
>> So, the file system would point to a wrong chunk which in itself has
>> correct data and csum?
> It's not likely because the wrong chunk even with the correct checksum would have wrong generation and be rejected, even with an older kernel.
understood.
>> Why would not the metadata redundancy spot this? Would this be caused by
>> a bug that corrupts both copies (rather than some hardware error)?
> The metadata redundancy did spot this and fixed up many of the problems, but like it's millions of errors. It could be one problem with the file system detected millions of times, or millions of problems detected once - it's a very simple counter and you'd have to go through the log from the very start of the problem and look at all of these messages to find out what's going on.
>
> Also the counter doesn't reset itself. You need to use -z option to clear the statistics. It should be zero for all devices all of the time - so if it's not then you need to completely understand and resolve why this is happening.

The problem is, that these errors do not become visible to the user - 
unless he searches. And he does once there is a problem. And that is too 
late. Not a problem of btrfs, but one of linux.

Your car gives you a master-warning if something is wrong and does not 
rely on you regularly browsing logs...

>> - what could have caused it / what can I do better in future
> Manual or automatic detection of errors so you can start troubleshooting sooner. I'm vaguely familiar with nagios for this. It might be overkill for your purposes.
yes. But how to get the hints...
> There's so many errors it's really tedious for anyone to go through them to find out what happened. But for sure both drives dropping writes at the same time is fatal for any setup.

We have no evidence for simultaneous errors. On the contrary we did not 
find any.

[thanks for the other recommendations. Understood]

>> - was my data corrupted before I transferred it to the new machine
> I think the data isn't corrupt, I think the file system is inconsistent.

I still do not understand the difference. But I think it means: What can 
be read is ok.

So if I do a cp -R /old/ /new/ and do not get any errors, then I am fine.

Would these errors be in the commandline or hidden in the kernel logs?

> If the problem is reproducible, and the logs show only one drive is affected by hardware (or firmware) issues, then that suggests a software bug or missing feature. But I do not  think it's worth the time to speculate about an old and EOL kernel. Just do data recovery and move forward.

Ok.

<<A bit more on this, in addition to using more recent kernel and 
btrfs-progs, and finding problems sooner with monitoring.

When providing logs, most people on this list prefer raw, unfiltered, uncurrated logs. Seems like providing a lot of junk, but the thing is, problems with file systems tend to involve other areas of the kernel or storage stack. With snippets of logs, it's impossible to get a complete picture of what's going on. There are always questions. With complete logs, there's far less questions.

Speaking for myself, I will want to see kernel messages starting at the last clean mount with no errors which represents a state in which scrub was clean, and btrfs check was clean - and then leading up to the problem so we can see whether the kernel is in some kind of distress or there are block layer errors happening. By the time you see problems reported, it's likely the actual instigator problem happened before that.

It's kinda tedious but that's sysadmin stuff.>>

The problem is, that I do not know when the last clean mount was. I went through the logs until Oct 14th and filtered for btrfs (though I understand that most do not like filtering)

Interestingly the first btrfs error is on another device
Okt 14 11:33:52 homeserver kernel: BTRFS error (device nvme0n1p3): tree first key mismatch detected, bytenr=570949632 parent_transid=9572251 key expected=(38580,96,2) has=(38
581,96,2)

then the first on sda/sdb:
so that was during a scrub. But no scrub that I did showed errors in the scrub output.
Okt 14 11:34:24 homeserver kernel: BTRFS info (device sda1): scrub: started on devid 1
Okt 14 11:34:24 homeserver kernel: BTRFS info (device sda1): scrub: started on devid 2
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 0, rd 1, flush 0, corrupt 0, gen 0
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 2, flush 0, corrupt 0, gen 0
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 3, flush 0, corrupt 0, gen 0
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 4, flush 0, corrupt 0, gen 0
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 5, flush 0, corrupt 0, gen 0
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 6, flush 0, corrupt 0, gen 0
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 7, flush 0, corrupt 0, gen 0
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 8, flush 0, corrupt 0, gen 0
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 9, flush 0, corrupt 0, gen 0
Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740143616 (dev /dev/sda1 sector 1238556704)
Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740143616 (dev /dev/sda1 sector 1238556704)
Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740147712 (dev /dev/sda1 sector 1238556712)
Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740147712 (dev /dev/sda1 sector 1238556712)
Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740151808 (dev /dev/sda1 sector 1238556720)
Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740151808 (dev /dev/sda1 sector 1238556720)
Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740155904 (dev /dev/sda1 sector 1238556728)
Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740155904 (dev /dev/sda1 sector 1238556728)
Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 16465591336960 (dev /dev/sda1 sector 15306398848)
Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 16465591341056 (dev /dev/sda1 sector 15306398856)
Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386345566208 on dev /dev/sdb1, physical 19689242624, root 1382, inode 5846, offset 3276
800, length 4096, links 1 (path: Mavic/Jana/DJI_0003.MOV)
Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386345172992 on dev /dev/sdb1, physical 19688849408, root 1382, inode 5846, offset 2883
584, length 4096, links 1 (path: Mavic/Jana/DJI_0003.MOV)
Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386345041920 on dev /dev/sdb1, physical 19688718336, root 1382, inode 5846, offset 2752
512, length 4096, links 1 (path: Mavic/Jana/DJI_0003.MOV)
Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386329051136 on dev /dev/sdb1, physical 19672727552, root 1382, inode 5844, offset 1820
721152, length 4096, links 1 (path: Mavic/Jana/DJI_0002.MOV)
Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386345304064 on dev /dev/sdb1, physical 19688980480, root 1382, inode 5846, offset 3014
656, length 4096, links 1 (path: Mavic/Jana/DJI_0003.MOV)
Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386328920064 on dev /dev/sdb1, physical 19672596480, root 1382, inode 5844, offset 1820
590080, length 4096, links 1 (path: Mavic/Jana/DJI_0002.MOV)
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): unable to fixup (regular) error at logical 24386345041920 on dev /dev/sdb1
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): unable to fixup (regular) error at logical 24386345172992 on dev /dev/sdb1
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): unable to fixup (regular) error at logical 24386345566208 on dev /dev/sdb1
Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): unable to fixup (regular) error at logical 24386345304064 on dev /dev/sdb1


On the filtering:
That's a good information. I would have felt horrible to just dump a bunch of logs onto you.

Greetings,
Hendrik




Return-Path: <linux-btrfs+bounces-8345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4E98AF5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B29B2331D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 21:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4BB186E4B;
	Mon, 30 Sep 2024 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="HZPmL+qr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB715E97
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732797; cv=none; b=gAKzFOhFscDdrq+AfZRn9knoBg4NjdpgNdw6PSBIP53yY5E8Hf8JGBM2OOVF4gkrzm0p5suZ3lItYfhpLR5T6SxJnx7CrD8ILC460P5KqHqTcLLA5B6lEvfxW3gXOc77GXeNNdC4LKqZzAGDwdFfgrmzCGvlvImkSZX8yeM+VOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732797; c=relaxed/simple;
	bh=0BoIbut1gvwmevFRxqZeFL2Qq4oyBbJgVHW5Mk3wozA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i/GyZskMIjPqWMPfBn6d9Sj3sYE6raDkorWV3nlge0iQl2pU03KY5JJwknxuFC2jDAsDusnA6KCppCKK9QMHxQ1EzDP5gaHbOXE0TlMcF/asrNuVD4Twy4HpuKJ9/k04S9+A6ovO5Nl+UOk8OrSPRaCaLefyJtkZlRI0XRghOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=HZPmL+qr; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id vOBOspIm92bxevOBOsXCE7; Mon, 30 Sep 2024 23:43:54 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1727732635; bh=5RaxI1Ql+FebJ9M7FZKnjmfdsicFZKfPO8iioE2+3oc=;
	h=From;
	b=HZPmL+qrK235uyAL8lQ+xbnCEMOQE+a4NKBsepxXSVgBSRpPcBzWwZn3PUDSGsZP0
	 fO5Dfpl3IluCXeb/NXHOuY55XWuynzwVBZbdh0EKX7+9emtCkw+5sVDJQ16dCiSFCB
	 aNxhKCdw5zpf5Hqc8wVIs/ttHLnR2jg/WlTCmFlcg3Tk9A3rKFErzGbKeEpsStnciE
	 /2CrxXn5p6CFGFQQIlIsq0hGP2yO9CQV7byzas7rVT3qMiZmKxVot8a5NmjC9Z7LQS
	 lbpPK/YWMSXcSgqy0HTTru0xPMT/o/saoSUQRaw5tUlhNRZ8lh0++6TcZhGteAw9Pi
	 QT7HVhkVOSxiQ==
X-CNFS-Analysis: v=2.4 cv=bN/dI++Z c=1 sm=1 tr=0 ts=66fb1b9b cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=w5_F2YlBW8SFMIdiTPkA:9 a=QEXdDO2ut3YA:10
Message-ID: <4f672a82-28d8-490e-bdce-e794748d41fd@libero.it>
Date: Mon, 30 Sep 2024 23:43:41 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: BTRFS list of grievances
To: waxhead@dirtcellar.net, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfID0XZVbmLxVH4s8AaFlLhrn8DPGT+pUdwnHlf26UIodE5w+GNE+AXAMswsEKC1mslG+Wj1vh6MpPX7rftVm9THu/8rS+BdEepMi5DKM8nGQYjQsUuW6
 GrPMinBH9fur/jtWVLOAOBJAYSdRO513n3OPLBhgpEibFL6k3GntLD8j4uK0ysVHmiwK1kJModC9UKJXZl2kQEJZUQOX49/hEpZjkir47zpVPz6DrLA/EFe+

On 27/09/2024 13.20, waxhead wrote:
> First thing first: I am a long time BTRFS user and frequent reader of the mailing list. I am *NOT* a BTRFS developer, but that being said I have been known to summon a segmentation failure or two from years of programming in C.
> 
> Since I have been using BTRFS more or less problem free since 2013 or so for nearly everything, I figured that I should be entitled to simply write down a list of things that I personally think sucks (more or less) with this otherwise fine filesystem
> 
> Make of it what you will, but what I am trying to get across is what the upper class would probably call 'constructive criticism'.
> 
> So here goes:
> 
> 
> 
> 1. FS MANAGEMENT
> ================
> BTRFS is rather simple to manage. We can add/remove devices on the fly, balance the filesystem, scrub, defrag, select compression algorithms etc. Some of these things are done as mount options, some as properties and some by issuing a command that process something.
> 
> Personally, I feel this is a bit messy and in some cases quite backwards at times. I believe the original idea was that BTRFS should support pr. subvolume mount options, storage profiles, etc etc.... and subvolumes are after all a key feature of the filesystem.
> 
> Heck, we even have a root subvolume (id 256) which ideally is the parent (or root) for all other subvolumes on the filesystem. So why on earth do we have commands such as 'btrfs balance start -dusage=50 /fsmnt' when logically it could just has easily have been 'btrfs <subvolume> balance start -dusage=50' . E.g. on the root subvolume instead of the fs mount point.
> 
> Besides, if BTRFS at some point are supposed to be more "subvolume centric" then why are not things like scrub, balance, convert (data/metadata), device add/remove or even defrag handled as properties to a subvolume. E.g. why not set a flag that triggers what needs to be done, and let the filesystem process that as a background task.
> 
> That would for example allow for finer granularity for scrub for certain subvolumes, instead of having to do the entire filesystem as it currently is now.

I am not sure to agree. Some properties are per "filesystem", others are per "sub-volume"; being a "subvolume" a subset of a filesystem, it might seem that providing a setting on a per "sub-volume" basis gives to the user more flexibility.
However this is a gain only if there isn't any possible confusion about what the filesystem will do. For example, it is not clear to me, what means doing a balance (e.g. reshape the raid profile) for a subvolume when also a snapshot exists: the user want to balance only the subvolume (un-sharing the data), or the user want to balance the subvolume data and all the shared extents. I am not saying that we cannot define a semantic of a subvolume balance; I am saying that this is not so obvious and should be avoided.

I think that, depending by the user case, the expectation might be different. IMHO a filesystem should behaves following the "least surprise" principle. And if something my be misunderstood, then it is better to not have it.

This to say that form me, if something is related to shared data, it should be "per filesystem" (like the raid profile), to avoid any ambiguity. Other properties (like a inode property) should be per "sub-volume" basis.

> 
> Status for the jobs do in my opinion belong in sysfs, but there is nothing wrong with a simple command to "pretty'fy" the status either.
> 
> And yes, I even mentioned device add/remove because if it would be possible at some point to assign priority/weight to certain devices for certain subvolumes then making a subvolume prefer or avoid using a certain storage device wold be as "simple" as setting a suitable weight/priority, and it would be possible to add/remove (assign) storage devices without affecting all other subvolumes.
> 
> So for me , 'btrfs property set' (or something similar) sounds like the only sensible way of properly managing a BTRFS. And really, with the exception of the rescue and subvolume mount options most, if not all other mount options seems to better belong as a property for a subvolume (which may or may not be the id 256 / root subvolume)
> 
> 
> 
> 2. USE DEVICE ID's EVERYWHERE INSTEAD OF /dev/sdX:
> ==================================================
> Using "btrfs filesystem show" will list all BTRFS devices, and also show the assigned ID for that device / partition / whatever. Since BTRFS already have the notion of a device ID, it seems pointless to not use that ID for management / identification anywhere possible.
> (for example btrfs device stat /mnt)
> 

I suggest both the ways. If something is a device, interpret as device, otherwise a try to interpret as id; I worked in the past on something like that. But I never finalize it.

> 
> 3. SOME DEVICES MISSING SHOULD BE ID 1,2,3,4... MISSING:
> ========================================================
> If one or more devices are missing it would have been great to know WHAT devices where missing. Why not print the ID's of the missing devices instead of just let the user know that "some" of them are missing?
> 

+1

> 
> 4. THE ABILITY TO SET A LABEL FOR A DEVICE ID:
> ==============================================
> It would have been great to set a label for a BTRFS device ID. For example ID1 = "Shelf01.24", ID2 = "NAS_01", ID3 = "localdiskXYZ"
> 

Considering the ubiquitous of a GUID partition table, currently we have:
- a device name (/dev/sdx), which can be customized by udev
- a partition type GUID
- a unique partition UUID
- a partition label (yes GUID has room for 36 UTF16 code unit)
- a btrfs sub UUID
- a btrfs ID

I think that it is enough :-), and a further label would only increase the confusion

> 
> 5. DEDUPLICATION IS NOT INTEGRATED IN BTRFS:
> ============================================
> I think that some form of (simple) deduplication should be integrated in BTRFS. Using unofficial tools may be perfectly safe, but it feels "unsafe" to be honest. Besides deduplication is something that might have been interesting to turn on/on_whenidle/off as a property to a subvolume as well.
> 

It is not clear if the problem is "online vs offline" deduplication or the fact that the dedup is not integrate in the btrfs-prog command.

> 
> 6. DEVICE STATS:
> ================
> Again device ID's are not used, but also why is this info not listed in a table? Showing this in a table would make 5x lines become 1x line which would be far more readable. Finaly it is not clear to me what is fixed errors, and what are actual damage accumulated in the filesystem
> 

+1

> 
> 7. LIST OF DAMAGED FILES:
> =========================
> There is no easy way to get a list of damaged files on a BTRFS filesystem to my knowledge. It would be great to have a command for that.
> 

I am not sure if it's worth the complexity. Basically now it is enough to look in the log for a filesystem error showing the inode. Logging an inode at the filesystem level would increase the complexity.

> 
> 8. ABILITY TO RESERVE SPARE SPACE:
> ==================================
> Because of the way BTRFS works a spare device is not very useful. Rather spare space would be a good idea I think. That way if one device is missing data, it could be replicated to other drives (or even on a single device [DUP] in emergency situations)
> 

We could reserve (e.g.) 1G for each disk, that cannot be allocated until root request it. It will not prevent the exhaustion of the free space, but would prevent the situation where the user cannot free space because.. it has not space.
When the filesystem fill all the disk(s) (with the except of the above 1GB reserved space), it goes in RO; then the administrator might unlock the reserved space and start to remove the thing.


> 
> 9. ABILITY TO MERGE / CONSUME EXISTING BTRFS:
> =============================================
> It would have been great to merge existing BTRFS volumes into a larger volume e.g. assimilate it ..because we all know resistance is futile.
> Again a subvolume would be the cleanest way of importing another BTRFS I think.
> 

What about the inode collision ?

[...]

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


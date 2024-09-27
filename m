Return-Path: <linux-btrfs+bounces-8302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA53988326
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 13:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E52283FC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3A5189904;
	Fri, 27 Sep 2024 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b="PWxVZ1ts"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19974186E4C
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436018; cv=none; b=BjcuvlqAeMKkvAhK4UO7KAXggXe/TtCmkUH/W2gH+Hef1MCLEXx7trWqfgeTEiBoLcTx2rMf9rsP8ggB1g8GyKQuLiwPWCRsBmGP28Bx36AN5uTO845sOc1m9cEnNg0y8XbyxbSFVuCxl5Q8qM5YK0jfbBrFM7jq5ojzprrCYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436018; c=relaxed/simple;
	bh=OToK1beIVYdkb1/co8+mok4H0U1xCQepfKk1CF+CfIY=;
	h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type; b=hQ35whdrSs1CHhFV5NaBA7NL6pMio4ODRYTEbAhiwuGBW4J8DL/rvAqUvUuSt43pk+iym8Vm11SylZr6lNZTGV1XBr68yOE9yl26wzhQIdWLu2vA0atDRDd5s3vGF42Tntwl42mMtLzwfc9ZLGl06XyFCprruhuOhwQgVmqFQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net; spf=pass smtp.mailfrom=dirtcellar.net; dkim=pass (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b=PWxVZ1ts; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dirtcellar.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dirtcellar.net; s=ds202312; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Date:Message-ID:To:Reply-To:Subject:From:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=4PXWXZIW3LYxPEdrdlw/ivmRMdm1Dm1k/Gs4rL6igB4=; b=P
	WxVZ1tsDygblqM/j2Y1f2k0AL4obd4WWUiPf8LK+qdNnkCIa5dZOL/x9+v/u7JuZQsZbMAz0AoP+h
	X9RsZy6UveRyQeuEKe5K1DRa0ReluoMdawYjGyPZhv2SZgJBykjr+MgT2a6aL4Pr6/LI1ESe77a7J
	l7mEOCgYv3CT5xl07rLFwzZmvszkM/S4qZsSEHprFFeo71jhdQGzh2WjWhHUgRdse5v08wQ6nZUFu
	3Tu70oe3sbBOKFxs+CyV40MaqCaqqzOnToqCcJKF2sAqs4HIXJ551sfihf1rXq89hwV8f0oteV6MV
	JhhU8wxGFGKp1l0Zr2SBsE9olWKnHT2GQ==;
Received: from 173.92-220-141.customer.lyse.net ([92.220.141.173]:25357 helo=[10.0.0.100])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <waxhead@dirtcellar.net>)
	id 1su91C-000Mpz-Mj
	for linux-btrfs@vger.kernel.org;
	Fri, 27 Sep 2024 13:20:14 +0200
From: waxhead <waxhead@dirtcellar.net>
Subject: BTRFS list of grievances
Reply-To: waxhead@dirtcellar.net
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
Date: Fri, 27 Sep 2024 13:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.19
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

First thing first: I am a long time BTRFS user and frequent reader of 
the mailing list. I am *NOT* a BTRFS developer, but that being said I 
have been known to summon a segmentation failure or two from years of 
programming in C.

Since I have been using BTRFS more or less problem free since 2013 or so 
for nearly everything, I figured that I should be entitled to simply 
write down a list of things that I personally think sucks (more or less) 
with this otherwise fine filesystem

Make of it what you will, but what I am trying to get across is what the 
upper class would probably call 'constructive criticism'.

So here goes:



1. FS MANAGEMENT
================
BTRFS is rather simple to manage. We can add/remove devices on the fly, 
balance the filesystem, scrub, defrag, select compression algorithms 
etc. Some of these things are done as mount options, some as properties 
and some by issuing a command that process something.

Personally, I feel this is a bit messy and in some cases quite backwards 
at times. I believe the original idea was that BTRFS should support pr. 
subvolume mount options, storage profiles, etc etc.... and subvolumes 
are after all a key feature of the filesystem.

Heck, we even have a root subvolume (id 256) which ideally is the parent 
(or root) for all other subvolumes on the filesystem. So why on earth do 
we have commands such as 'btrfs balance start -dusage=50 /fsmnt' when 
logically it could just has easily have been 'btrfs <subvolume> balance 
start -dusage=50' . E.g. on the root subvolume instead of the fs mount 
point.

Besides, if BTRFS at some point are supposed to be more "subvolume 
centric" then why are not things like scrub, balance, convert 
(data/metadata), device add/remove or even defrag handled as properties 
to a subvolume. E.g. why not set a flag that triggers what needs to be 
done, and let the filesystem process that as a background task.

That would for example allow for finer granularity for scrub for certain 
subvolumes, instead of having to do the entire filesystem as it 
currently is now.

Status for the jobs do in my opinion belong in sysfs, but there is 
nothing wrong with a simple command to "pretty'fy" the status either.

And yes, I even mentioned device add/remove because if it would be 
possible at some point to assign priority/weight to certain devices for 
certain subvolumes then making a subvolume prefer or avoid using a 
certain storage device wold be as "simple" as setting a suitable 
weight/priority, and it would be possible to add/remove (assign) storage 
devices without affecting all other subvolumes.

So for me , 'btrfs property set' (or something similar) sounds like the 
only sensible way of properly managing a BTRFS. And really, with the 
exception of the rescue and subvolume mount options most, if not all 
other mount options seems to better belong as a property for a subvolume 
(which may or may not be the id 256 / root subvolume)



2. USE DEVICE ID's EVERYWHERE INSTEAD OF /dev/sdX:
==================================================
Using "btrfs filesystem show" will list all BTRFS devices, and also show 
the assigned ID for that device / partition / whatever. Since BTRFS 
already have the notion of a device ID, it seems pointless to not use 
that ID for management / identification anywhere possible.
(for example btrfs device stat /mnt)


3. SOME DEVICES MISSING SHOULD BE ID 1,2,3,4... MISSING:
========================================================
If one or more devices are missing it would have been great to know WHAT 
devices where missing. Why not print the ID's of the missing devices 
instead of just let the user know that "some" of them are missing?



4. THE ABILITY TO SET A LABEL FOR A DEVICE ID:
==============================================
It would have been great to set a label for a BTRFS device ID. For 
example ID1 = "Shelf01.24", ID2 = "NAS_01", ID3 = "localdiskXYZ"



5. DEDUPLICATION IS NOT INTEGRATED IN BTRFS:
============================================
I think that some form of (simple) deduplication should be integrated in 
BTRFS. Using unofficial tools may be perfectly safe, but it feels 
"unsafe" to be honest. Besides deduplication is something that might 
have been interesting to turn on/on_whenidle/off as a property to a 
subvolume as well.



6. DEVICE STATS:
================
Again device ID's are not used, but also why is this info not listed in 
a table? Showing this in a table would make 5x lines become 1x line 
which would be far more readable. Finaly it is not clear to me what is 
fixed errors, and what are actual damage accumulated in the filesystem



7. LIST OF DAMAGED FILES:
=========================
There is no easy way to get a list of damaged files on a BTRFS 
filesystem to my knowledge. It would be great to have a command for that.



8. ABILITY TO RESERVE SPARE SPACE:
==================================
Because of the way BTRFS works a spare device is not very useful. Rather 
spare space would be a good idea I think. That way if one device is 
missing data, it could be replicated to other drives (or even on a 
single device [DUP] in emergency situations)



9. ABILITY TO MERGE / CONSUME EXISTING BTRFS:
=============================================
It would have been great to merge existing BTRFS volumes into a larger 
volume e.g. assimilate it ..because we all know resistance is futile.
Again a subvolume would be the cleanest way of importing another BTRFS I 
think.


10. AUTOREJECT FAILED DEVICES:
==============================
As I have mentioned before. It it was possible to assign certain storage 
devices / storage device groups to certain subvolumes then as the 
failure count for a device increase, it may be preferable to 
automatically lower the weight/priority of that device so that things 
are stored elsewhere. If auto-migration is triggered at a low enough 
weight then devices with a high failure rate/count could be rejected.


11. That's it folks!
====================
I know it is a lot of "rant", but hope someone find it useful or 
inspiring. If for nothing more than to keep my mouth shut. ;)




Return-Path: <linux-btrfs+bounces-11910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8DDA480C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 15:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254ED3A2FD7
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7392376E4;
	Thu, 27 Feb 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="D5myGBrB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89711230D3D
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665486; cv=none; b=jRBNKAQusLlcG00qMyv/a5bHR1C6FE2ycUNbqAoVbCE6iYpwttC6bHoNR8VN6sMl5051pD9zNlXxGg+v5R05uecGc2oxafXRSIxS+7voECuTfOmgqiW/rJFrENpqXDAdFQGDLCZ8x/F6WDblXJdvzbUQFUUwT5QUd5YpwZnS1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665486; c=relaxed/simple;
	bh=NhU1waQCspgXH0HlT5YzELAt8CevZuXObeIa0SVepwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etV8tihB24H9irMBbb8oLEBrzsSYZFXapb++qqMrxVCyX7awYFIT4J8gLYRyoOk4JvEYPS1HSbbKnJalm3TtYljO2nPBZ5X5npl2Ffz6VTjaJIiubmO8J8jxJLiJiWh8J3abFc7JsZhMKMU3XkYhlQqwWeQhYWaHLG4nZGhUD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=D5myGBrB reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bH7Fbpe01Sm20AVqkuwFbScthbq+iAPBZBPyQLnZLnE=; b=D5myGBrBYpA9SEowX5v8i8/Q40
	9ZcOggfrGZx7kbTJ8SPUB/+8bqkgZ1CGD60p2fb47yR20UEgmfr/Xi7DmBuRcCHnkBwUP8C3rrtg6
	UTFmr6kdD/vYwkQfqsCF6Iy3l9Nyx3B5MQ3kRXdAhpO/YmQ4jEJc9L9f0kdlSfhn03pdLFqAhCYMW
	BEjiHEnnGGYB9LAbXY4nhgKi1TBDhmiH9bAwNk1VYuaenSaqW7X3aa/rbVt1AQTZ5JWCVMajN1gdQ
	sXgRjGrIfM/Y+TW7LUK5xAeYys/DpGyQ5cODfk4umbWaGAdvyLr7bE4W5moApH8zrUgczau4j/U8b
	4sR2nV1A==;
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
	id 1tnebc-0008Hl-OU by authid <merlin>; Thu, 27 Feb 2025 06:11:16 -0800
Date: Thu, 27 Feb 2025 06:11:16 -0800
From: Marc MERLIN <marc@merlins.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Murphy <lists@colorremedies.com>,
	Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
	Roman Mamedov <rm@romanrm.net>, Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
Message-ID: <20250227141116.GZ11500@merlins.org>
References: <Z6TsUwR7tyKJrZ7w@merlins.org>
 <Z71yICVikAzKxisq@merlins.org>
 <018d16aa-24b2-43ae-826c-7f717e0d05ee@gmx.com>
 <Z71_TednCt9KzR45@merlins.org>
 <d973b4b7-0d98-4310-bb7e-50f87c374762@suse.com>
 <Z72LAZDq8IegQoua@merlins.org>
 <d7f97a38-43eb-48ea-9a21-b6a90e8c613f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d7f97a38-43eb-48ea-9a21-b6a90e8c613f@gmx.com>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org

On Tue, Feb 25, 2025 at 07:52:11PM +1030, Qu Wenruo wrote:
>=20
>=20
> =E5=9C=A8 2025/2/25 19:48, Marc MERLIN =E5=86=99=E9=81=93:
> > On Tue, Feb 25, 2025 at 07:16:31PM +1030, Qu Wenruo wrote:
> > > Ref#13 is the root that mentioned has the existing one.
> > >=20
> > > I have no idea why it shows up like this.
> > >=20
> > > But since the fs passes btrfs check, mind to dump the following tree =
block?
> > >=20
> > > # btrfs ins dump-tree -t extent <device> | grep "(350223581184 " -A 50
> > >=20
> > > I want to make sure if the ref 398 exists on disk, or it's generated =
at
> > > runtime.
> >=20
> > sauron:~# btrfs ins dump-tree -t extent /dev/mapper/pool1 | grep "35022=
3581184 " -A 50
> > sauron:~#
> >=20
> > Mmmmh, so 350223581184 is gone now since it's been 20 days already since
> > my original post.
> > I can try to re-enable balance and see if things crash or not.

Ok, I didn't run memtest last night, but ran a new balance to get new
offsets so can you can tell me which dump tree you'd like so you
hopefully get a non 0 result this time

I'll reboot the system after that, btrfs check the FS, wait for your dumptr=
ee=20
command, nad will run memtest overnight

Note that the source code seems to have an extra newline after itemsize
that could be removed?

BTRFS info (device dm-0): balance: ended with status: 0
BTRFS info (device dm-0): balance: start -dusage=3D0
BTRFS info (device dm-0): balance: ended with status: 0
BTRFS info (device dm-0): balance: start -dusage=3D20
BTRFS info (device dm-0): balance: ended with status: 0
BTRFS info (device dm-0): scrub: started on devid 1
BTRFS info (device dm-0): scrub: finished on devid 1
[9with status: 0
BTRFS info (device dm-4): balance: resume -dusage=3D20
BTRFS info (device dm-4): relocating block group
[9722893537280 flags data
BTRFS info (device dm-4): found 2 extents, stage: move
[9data extents
BTRFS info (device dm-4): leaf 780107776 gen 4865726
[9total ptrs 169 free space 2341 owner 2
item 0 key (470809247744 169 0) itemoff 16250 itemsize
[933
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 1 key (470809264128 169 1) itemoff 15551 itemsize
[9699
extent refs 75 gen 4541732 flags 2
ref#0: tree block backref root 486052
ref#1: tree block backref root 486051
ref#2: tree block backref root 486050
ref#3: tree block backref root 486049
ref#4: tree block backref root 486048
ref#5: tree block backref root 486047
ref#6: tree block backref root 486046
ref#7: tree block backref root 486045
ref#8: tree block backref root 486044
ref#9: tree block backref root 486043
ref#10: tree block backref root 486035
ref#11: tree block backref root 486031
ref#12: tree block backref root 486018
ref#13: tree block backref root 486005
ref#14: tree block backref root 485992
ref#15: tree block backref root 485979
ref#16: tree block backref root 485966
ref#17: tree block backref root 485953
ref#18: tree block backref root 485721
ref#19: tree block backref root 485408
ref#20: tree block backref root 484779
ref#21: tree block backref root 482587
ref#22: tree block backref root 480469
ref#23: tree block backref root 478601
ref#24: tree block backref root 398
ref#25: shared block backref parent 737472331776
ref#26: shared block backref parent 737441284096
ref#27: shared block backref parent 737440071680
ref#28: shared block backref parent 737100906496
ref#29: shared block backref parent 737056882688
ref#30: shared block backref parent 736788856832
ref#31: shared block backref parent 736692797440
ref#32: shared block backref parent 736613449728
ref#33: shared block backref parent 471171776512
ref#34: shared block backref parent 470901473280
ref#35: shared block backref parent 470809182208
ref#36: shared block backref parent 470492151808
ref#37: shared block backref parent 350754684928
ref#38: shared block backref parent 350409670656
ref#39: shared block backref parent 350370103296
ref#40: shared block backref parent 349999218688
ref#41: shared block backref parent 349334798336
ref#42: shared block backref parent 349189128192
ref#43: shared block backref parent 153070862336
ref#44: shared block backref parent 153039044608
ref#45: shared block backref parent 152908038144
ref#46: shared block backref parent 152557928448
ref#47: shared block backref parent 51518570496
ref#48: shared block backref parent 51338706944
ref#49: shared block backref parent 509575168
ref#50: shared block backref parent 509460480
ref#51: shared block backref parent 509280256
ref#52: shared block backref parent 509198336
ref#53: shared block backref parent 509149184
ref#54: shared block backref parent 509034496
ref#55: shared block backref parent 508805120
ref#56: shared block backref parent 508575744
ref#57: shared block backref parent 508411904
ref#58: shared block backref parent 508297216
ref#59: shared block backref parent 507887616
ref#60: shared block backref parent 507772928
ref#61: shared block backref parent 505888768
ref#62: shared block backref parent 505446400
ref#63: shared block backref parent 505184256
ref#64: shared block backref parent 504774656
ref#65: shared block backref parent 504430592
ref#66: shared block backref parent 503742464
ref#67: shared block backref parent 502923264
ref#68: shared block backref parent 502415360
ref#69: shared block backref parent 496648192
ref#70: shared block backref parent 496418816
ref#71: shared block backref parent 495665152
ref#72: shared block backref parent 495190016
ref#73: shared block backref parent 494993408
ref#74: shared block backref parent 291684352
item 2 key (470809280512 169 0) itemoff 15500 itemsize
[951
extent refs 3 gen 3261729 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737199292416
ref#2: shared block backref parent 349886251008
item 3 key (470809296896 169 0) itemoff 15467 itemsize
[933
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 4 key (470809313280 169 0) itemoff 15434 itemsize
[933
extent refs 1 gen 3786399 flags 2
ref#0: tree block backref root 372498
item 5 key (470809329664 169 0) itemoff 15401 itemsize
[933
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 6 key (470809346048 169 0) itemoff 15161 itemsize
[9240
extent refs 24 gen 4813689 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737488977920
ref#2: shared block backref parent 737398013952
ref#3: shared block backref parent 737220558848
ref#4: shared block backref parent 736785645568
ref#5: shared block backref parent 736770834432
ref#6: shared block backref parent 736759595008
ref#7: shared block backref parent 736698220544
ref#8: shared block backref parent 471391174656
ref#9: shared block backref parent 471054860288
ref#10: shared block backref parent 470850879488
ref#11: shared block backref parent 470765010944
ref#12: shared block backref parent 470477684736
ref#13: shared block backref parent 350667014144
ref#14: shared block backref parent 350431625216
ref#15: shared block backref parent 350351753216
ref#16: shared block backref parent 349566025728
ref#17: shared block backref parent 349358342144
ref#18: shared block backref parent 153255591936
ref#19: shared block backref parent 153023758336
ref#20: shared block backref parent 153003704320
ref#21: shared block backref parent 152648957952
ref#22: shared block backref parent 51431325696
ref#23: shared block backref parent 51240222720
item 7 key (470809362432 169 1) itemoff 15128 itemsize
[933
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 8 key (470809378816 169 0) itemoff 15095 itemsize
[933
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 9 key (470809395200 169 1) itemoff 15062 itemsize
[933
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 10 key (470809411584 169 0) itemoff 15029 itemsize
[933
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 11 key (470809427968 169 1) itemoff 14996 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 12 key (470809444352 169 0) itemoff 14963 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 13 key (470809460736 169 0) itemoff 14930 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 14 key (470809477120 169 1) itemoff 14897 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 15 key (470809493504 169 0) itemoff 14864 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 16 key (470809509888 169 0) itemoff 14831 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 17 key (470809526272 169 0) itemoff 14798 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 18 key (470809542656 169 1) itemoff 14765 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 19 key (470809559040 169 0) itemoff 14732 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 20 key (470809575424 169 0) itemoff 14699 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 21 key (470809591808 169 0) itemoff 14666 itemsize
  33
extent refs 1 gen 3500792 flags 2
ref#0: tree block backref root 398
item 22 key (470809608192 169 0) itemoff 14633 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 23 key (470809624576 169 1) itemoff 14600 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 24 key (470809640960 169 0) itemoff 14567 itemsize
  33
extent refs 1 gen 4814306 flags 258
ref#0: shared block backref parent 152614600704
item 25 key (470809657344 169 0) itemoff 14534 itemsize
  33
extent refs 1 gen 2940687 flags 2
ref#0: tree block backref root 398
item 26 key (470809673728 169 0) itemoff 14501 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 27 key (470809690112 169 0) itemoff 14468 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 28 key (470809706496 169 0) itemoff 14435 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 29 key (470809722880 169 1) itemoff 14402 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 30 key (470809739264 169 0) itemoff 14369 itemsize
  33
extent refs 1 gen 4796053 flags 258
ref#0: shared block backref parent 152641617920
item 31 key (470809755648 169 0) itemoff 14336 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 32 key (470809772032 169 0) itemoff 14276 itemsize
  60
extent refs 4 gen 4471163 flags 258
ref#0: shared block backref parent 350507761664
ref#1: shared block backref parent 350441930752
ref#2: shared block backref parent 153473925120
ref#3: shared block backref parent 152892456960
item 33 key (470809788416 169 0) itemoff 14243 itemsize
  33
extent refs 1 gen 3447280 flags 2
ref#0: tree block backref root 398
item 34 key (470809804800 169 0) itemoff 14210 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 35 key (470809821184 169 1) itemoff 14177 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 36 key (470809837568 169 0) itemoff 14144 itemsize
  33
extent refs 1 gen 4865700 flags 2
ref#0: tree block backref root 486050
item 37 key (470809853952 169 1) itemoff 13895 itemsize
  249
extent refs 25 gen 4541732 flags 2
ref#0: tree block backref root 486052
ref#1: tree block backref root 486051
ref#2: tree block backref root 486050
ref#3: tree block backref root 486049
ref#4: tree block backref root 486048
ref#5: tree block backref root 486047
ref#6: tree block backref root 486046
ref#7: tree block backref root 486045
ref#8: tree block backref root 486044
ref#9: tree block backref root 486043
ref#10: tree block backref root 486035
ref#11: tree block backref root 486031
ref#12: tree block backref root 486018
ref#13: tree block backref root 486005
ref#14: tree block backref root 485992
ref#15: tree block backref root 485979
ref#16: tree block backref root 485966
ref#17: tree block backref root 485953
ref#18: tree block backref root 485721
ref#19: tree block backref root 485408
ref#20: tree block backref root 484779
ref#21: tree block backref root 482587
ref#22: tree block backref root 480469
ref#23: tree block backref root 478601
ref#24: tree block backref root 398
item 38 key (470809870336 169 0) itemoff 13862 itemsize
  33
extent refs 1 gen 4865000 flags 258
ref#0: tree block backref root 485979
item 39 key (470809903104 169 0) itemoff 13829 itemsize
  33
extent refs 1 gen 4865000 flags 258
ref#0: shared block backref parent 153004752896
item 40 key (470809985024 169 0) itemoff 13796 itemsize
  33
extent refs 1 gen 3786399 flags 2
ref#0: tree block backref root 372498
item 41 key (470810001408 169 0) itemoff 13745 itemsize
  51
extent refs 3 gen 3261729 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737199292416
ref#2: shared block backref parent 349886251008
item 42 key (470810034176 169 0) itemoff 13712 itemsize
  33
extent refs 1 gen 3529096 flags 2
ref#0: tree block backref root 398
item 43 key (470810116096 169 0) itemoff 13679 itemsize
  33
extent refs 1 gen 3529096 flags 2
ref#0: tree block backref root 398
item 44 key (470810165248 169 0) itemoff 13601 itemsize
  78
extent refs 6 gen 4838387 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 470774349824
ref#2: shared block backref parent 350775836672
ref#3: shared block backref parent 51398656000
ref#4: shared block backref parent 51369590784
ref#5: shared block backref parent 759103488
item 45 key (470810230784 169 0) itemoff 13550 itemsize
  51
extent refs 3 gen 3261729 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737199292416
ref#2: shared block backref parent 349886251008
item 46 key (470810247168 169 0) itemoff 13427 itemsize
  123
extent refs 11 gen 4378843 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 471317004288
ref#2: shared block backref parent 471307550720
ref#3: shared block backref parent 471070687232
ref#4: shared block backref parent 351045566464
ref#5: shared block backref parent 153558728704
ref#6: shared block backref parent 152896454656
ref#7: shared block backref parent 152873271296
ref#8: shared block backref parent 152580521984
ref#9: shared block backref parent 50820874240
ref#10: shared block backref parent 1095565312
item 47 key (470810263552 169 0) itemoff 13358 itemsize
  69
extent refs 5 gen 4838387 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 153317752832
ref#2: shared block backref parent 51398606848
ref#3: shared block backref parent 51369246720
ref#4: shared block backref parent 759021568
item 48 key (470810279936 169 0) itemoff 13325 itemsize
  33
extent refs 1 gen 3790158 flags 2
ref#0: tree block backref root 398
item 49 key (470810296320 169 0) itemoff 13292 itemsize
  33
extent refs 1 gen 4814184 flags 258
ref#0: shared block backref parent 737356562432
item 50 key (470810361856 169 0) itemoff 13259 itemsize
  33
extent refs 1 gen 4864449 flags 2
ref#0: tree block backref root 2
item 51 key (470810394624 169 0) itemoff 13226 itemsize
  33
extent refs 1 gen 4864449 flags 2
ref#0: tree block backref root 2
item 52 key (470810411008 169 0) itemoff 13193 itemsize
  33
extent refs 1 gen 4864449 flags 2
ref#0: tree block backref root 2
item 53 key (470810427392 169 0) itemoff 13160 itemsize
  33
extent refs 1 gen 4837772 flags 258
ref#0: shared block backref parent 737315373056
item 54 key (470810443776 169 0) itemoff 13127 itemsize
  33
extent refs 1 gen 4837772 flags 258
ref#0: shared block backref parent 737315373056
item 55 key (470810509312 169 0) itemoff 12932 itemsize
  195
extent refs 19 gen 3934086 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737641054208
ref#2: shared block backref parent 737489911808
ref#3: shared block backref parent 737216643072
ref#4: shared block backref parent 737045807104
ref#5: shared block backref parent 736820330496
ref#6: shared block backref parent 736769032192
ref#7: shared block backref parent 471276716032
ref#8: shared block backref parent 351090245632
ref#9: shared block backref parent 350562500608
ref#10: shared block backref parent 350442569728
ref#11: shared block backref parent 350177230848
ref#12: shared block backref parent 349864771584
ref#13: shared block backref parent 349796909056
ref#14: shared block backref parent 349431185408
ref#15: shared block backref parent 153273909248
ref#16: shared block backref parent 152756305920
ref#17: shared block backref parent 51273728000
ref#18: shared block backref parent 50574934016
item 56 key (470810542080 169 0) itemoff 12872 itemsize
  60
extent refs 4 gen 3723805 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737008451584
ref#2: shared block backref parent 736887128064
ref#3: shared block backref parent 50967035904
item 57 key (470810574848 169 0) itemoff 12839 itemsize
  33
extent refs 1 gen 4814304 flags 258
ref#0: shared block backref parent 152773263360
item 58 key (470810624000 169 0) itemoff 12806 itemsize
  33
extent refs 1 gen 3786399 flags 2
ref#0: tree block backref root 372498
item 59 key (470810640384 169 0) itemoff 12773 itemsize
  33
extent refs 1 gen 3786399 flags 2
ref#0: tree block backref root 372498
item 60 key (470810722304 169 0) itemoff 12740 itemsize
  33
extent refs 1 gen 4810538 flags 258
ref#0: shared block backref parent 470348480512
item 61 key (470810771456 169 0) itemoff 12707 itemsize
  33
extent refs 1 gen 4833910 flags 258
ref#0: shared block backref parent 471081353216
item 62 key (470810787840 169 0) itemoff 12674 itemsize
  33
extent refs 1 gen 4519492 flags 2
ref#0: tree block backref root 398
item 63 key (470810804224 169 0) itemoff 12641 itemsize
  33
extent refs 1 gen 4814304 flags 258
ref#0: tree block backref root 480469
item 64 key (470811000832 169 0) itemoff 12608 itemsize
  33
extent refs 1 gen 4865321 flags 258
ref#0: shared block backref parent 736748601344
item 65 key (470811049984 169 0) itemoff 12575 itemsize
  33
extent refs 1 gen 4833910 flags 258
ref#0: shared block backref parent 471055040512
item 66 key (470811181056 169 0) itemoff 12524 itemsize
  51
extent refs 3 gen 4838387 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737420591104
ref#2: shared block backref parent 350765498368
item 67 key (470811197440 169 0) itemoff 12491 itemsize
  33
extent refs 1 gen 4864783 flags 2
ref#0: tree block backref root 2
item 68 key (470811213824 169 1) itemoff 12242 itemsize
  249
extent refs 25 gen 4541732 flags 2
ref#0: tree block backref root 486052
ref#1: tree block backref root 486051
ref#2: tree block backref root 486050
ref#3: tree block backref root 486049
ref#4: tree block backref root 486048
ref#5: tree block backref root 486047
ref#6: tree block backref root 486046
ref#7: tree block backref root 486045
ref#8: tree block backref root 486044
ref#9: tree block backref root 486043
ref#10: tree block backref root 486035
ref#11: tree block backref root 486031
ref#12: tree block backref root 486018
ref#13: tree block backref root 486005
ref#14: tree block backref root 485992
ref#15: tree block backref root 485979
ref#16: tree block backref root 485966
ref#17: tree block backref root 485953
ref#18: tree block backref root 485721
ref#19: tree block backref root 485408
ref#20: tree block backref root 484779
ref#21: tree block backref root 482587
ref#22: tree block backref root 480469
ref#23: tree block backref root 478601
ref#24: tree block backref root 398
item 69 key (470811230208 169 0) itemoff 12209 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 70 key (470811262976 169 1) itemoff 11960 itemsize
  249
extent refs 25 gen 4541732 flags 2
ref#0: tree block backref root 486052
ref#1: tree block backref root 486051
ref#2: tree block backref root 486050
ref#3: tree block backref root 486049
ref#4: tree block backref root 486048
ref#5: tree block backref root 486047
ref#6: tree block backref root 486046
ref#7: tree block backref root 486045
ref#8: tree block backref root 486044
ref#9: tree block backref root 486043
ref#10: tree block backref root 486035
ref#11: tree block backref root 486031
ref#12: tree block backref root 486018
ref#13: tree block backref root 486005
ref#14: tree block backref root 485992
ref#15: tree block backref root 485979
ref#16: tree block backref root 485966
ref#17: tree block backref root 485953
ref#18: tree block backref root 485721
ref#19: tree block backref root 485408
ref#20: tree block backref root 484779
ref#21: tree block backref root 482587
ref#22: tree block backref root 480469
ref#23: tree block backref root 478601
ref#24: tree block backref root 398
item 71 key (470811279360 169 0) itemoff 11927 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 72 key (470811344896 169 0) itemoff 11894 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 73 key (470811361280 169 0) itemoff 11843 itemsize
  51
extent refs 3 gen 4840882 flags 258
ref#0: tree block backref root 485721
ref#1: tree block backref root 485408
ref#2: tree block backref root 484779
item 74 key (470811377664 169 0) itemoff 11648 itemsize
  195
extent refs 19 gen 4671752 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737641398272
ref#2: shared block backref parent 737490583552
ref#3: shared block backref parent 737216856064
ref#4: shared block backref parent 737046052864
ref#5: shared block backref parent 736820871168
ref#6: shared block backref parent 736769540096
ref#7: shared block backref parent 471276994560
ref#8: shared block backref parent 470476406784
ref#9: shared block backref parent 350562942976
ref#10: shared block backref parent 350443454464
ref#11: shared block backref parent 350179344384
ref#12: shared block backref parent 349865132032
ref#13: shared block backref parent 349797400576
ref#14: shared block backref parent 349431463936
ref#15: shared block backref parent 153274597376
ref#16: shared block backref parent 152757616640
ref#17: shared block backref parent 51273973760
ref#18: shared block backref parent 50575310848
item 75 key (470811426816 169 0) itemoff 11570 itemsize
  78
extent refs 6 gen 4838387 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 470774349824
ref#2: shared block backref parent 350775836672
ref#3: shared block backref parent 51398656000
ref#4: shared block backref parent 51369590784
ref#5: shared block backref parent 759103488
item 76 key (470811443200 169 1) itemoff 11321 itemsize
  249
extent refs 25 gen 4541732 flags 2
ref#0: tree block backref root 486052
ref#1: tree block backref root 486051
ref#2: tree block backref root 486050
ref#3: tree block backref root 486049
ref#4: tree block backref root 486048
ref#5: tree block backref root 486047
ref#6: tree block backref root 486046
ref#7: tree block backref root 486045
ref#8: tree block backref root 486044
ref#9: tree block backref root 486043
ref#10: tree block backref root 486035
ref#11: tree block backref root 486031
ref#12: tree block backref root 486018
ref#13: tree block backref root 486005
ref#14: tree block backref root 485992
ref#15: tree block backref root 485979
ref#16: tree block backref root 485966
ref#17: tree block backref root 485953
ref#18: tree block backref root 485721
ref#19: tree block backref root 485408
ref#20: tree block backref root 484779
ref#21: tree block backref root 482587
ref#22: tree block backref root 480469
ref#23: tree block backref root 478601
ref#24: tree block backref root 398
item 77 key (470811475968 169 0) itemoff 11288 itemsize
  33
extent refs 1 gen 4830831 flags 2
ref#0: tree block backref root 2
item 78 key (470811492352 169 0) itemoff 11255 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 79 key (470811508736 169 0) itemoff 11213 itemsize
  42
extent refs 2 gen 3042608 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 349646520320
item 80 key (470811525120 169 0) itemoff 11180 itemsize
  33
extent refs 1 gen 3577077 flags 2
ref#0: tree block backref root 398
item 81 key (470811541504 169 1) itemoff 10931 itemsize
  249
extent refs 25 gen 4541732 flags 2
ref#0: tree block backref root 486052
ref#1: tree block backref root 486051
ref#2: tree block backref root 486050
ref#3: tree block backref root 486049
ref#4: tree block backref root 486048
ref#5: tree block backref root 486047
ref#6: tree block backref root 486046
ref#7: tree block backref root 486045
ref#8: tree block backref root 486044
ref#9: tree block backref root 486043
ref#10: tree block backref root 486035
ref#11: tree block backref root 486031
ref#12: tree block backref root 486018
ref#13: tree block backref root 486005
ref#14: tree block backref root 485992
ref#15: tree block backref root 485979
ref#16: tree block backref root 485966
ref#17: tree block backref root 485953
ref#18: tree block backref root 485721
ref#19: tree block backref root 485408
ref#20: tree block backref root 484779
ref#21: tree block backref root 482587
ref#22: tree block backref root 480469
ref#23: tree block backref root 478601
ref#24: tree block backref root 398
item 82 key (470811557888 169 0) itemoff 10898 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 83 key (470811590656 169 0) itemoff 10865 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 84 key (470811639808 169 0) itemoff 10832 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 85 key (470811656192 169 0) itemoff 10799 itemsize
  33
extent refs 1 gen 3547360 flags 2
ref#0: tree block backref root 398
item 86 key (470811672576 169 0) itemoff 10766 itemsize
  33
extent refs 1 gen 3280274 flags 2
ref#0: tree block backref root 398
item 87 key (470811688960 169 0) itemoff 10733 itemsize
  33
extent refs 1 gen 3280274 flags 2
ref#0: tree block backref root 398
item 88 key (470811738112 169 0) itemoff 10700 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 89 key (470811770880 169 0) itemoff 10667 itemsize
  33
extent refs 1 gen 4541732 flags 2
ref#0: tree block backref root 398
item 90 key (470811803648 169 0) itemoff 10634 itemsize
  33
extent refs 1 gen 4813689 flags 258
ref#0: shared block backref parent 471114399744
item 91 key (470811836416 169 1) itemoff 10592 itemsize
  42
extent refs 2 gen 4541732 flags 258
ref#0: tree block backref root 480469
ref#1: tree block backref root 478601
item 92 key (470811869184 169 0) itemoff 10550 itemsize
  42
extent refs 2 gen 4541732 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 470811836416
item 93 key (470811901952 169 0) itemoff 10355 itemsize
  195
extent refs 19 gen 4671752 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737641398272
ref#2: shared block backref parent 737490583552
ref#3: shared block backref parent 737216856064
ref#4: shared block backref parent 737046052864
ref#5: shared block backref parent 736820871168
ref#6: shared block backref parent 736769540096
ref#7: shared block backref parent 471276994560
ref#8: shared block backref parent 470476406784
ref#9: shared block backref parent 350562942976
ref#10: shared block backref parent 350443454464
ref#11: shared block backref parent 350179344384
ref#12: shared block backref parent 349865132032
ref#13: shared block backref parent 349797400576
ref#14: shared block backref parent 349431463936
ref#15: shared block backref parent 153274597376
ref#16: shared block backref parent 152757616640
ref#17: shared block backref parent 51273973760
ref#18: shared block backref parent 50575310848
item 94 key (470811967488 169 0) itemoff 10295 itemsize
  60
extent refs 4 gen 4807178 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 736921075712
ref#2: shared block backref parent 351076073472
ref#3: shared block backref parent 51439304704
item 95 key (470811983872 169 0) itemoff 10262 itemsize
  33
extent refs 1 gen 4864449 flags 2
ref#0: tree block backref root 2
item 96 key (470812065792 169 0) itemoff 10229 itemsize
  33
extent refs 1 gen 4864449 flags 2
ref#0: tree block backref root 2
item 97 key (470812098560 169 0) itemoff 10196 itemsize
  33
extent refs 1 gen 3786399 flags 2
ref#0: tree block backref root 372498
item 98 key (470812147712 169 0) itemoff 10163 itemsize
  33
extent refs 1 gen 4813689 flags 258
ref#0: shared block backref parent 471114399744
item 99 key (470812196864 169 0) itemoff 10103 itemsize
  60
extent refs 4 gen 4807178 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 736921075712
ref#2: shared block backref parent 351076073472
ref#3: shared block backref parent 51439304704
item 100 key (470812327936 169 0) itemoff 10070 itemsize
  33
extent refs 1 gen 4813689 flags 258
ref#0: shared block backref parent 351087575040
item 101 key (470812393472 169 0) itemoff 10010 itemsize
  60
extent refs 4 gen 4807178 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 736921075712
ref#2: shared block backref parent 351076073472
ref#3: shared block backref parent 51439304704
item 102 key (470812426240 169 0) itemoff 9950 itemsize
  60
extent refs 4 gen 4813689 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 351087575040
ref#2: shared block backref parent 51350798336
ref#3: shared block backref parent 50696880128
item 103 key (470812442624 169 0) itemoff 9890 itemsize
  60
extent refs 4 gen 4807178 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 736921075712
ref#2: shared block backref parent 351076073472
ref#3: shared block backref parent 51439304704
item 104 key (470812508160 169 0) itemoff 9857 itemsize
  33
extent refs 1 gen 4795277 flags 258
ref#0: shared block backref parent 152638423040
item 105 key (470812524544 169 0) itemoff 9797 itemsize
  60
extent refs 4 gen 4807178 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 736921075712
ref#2: shared block backref parent 351076073472
ref#3: shared block backref parent 51439304704
item 106 key (470812639232 169 0) itemoff 9683 itemsize
  114
extent refs 10 gen 4808224 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737597767680
ref#2: shared block backref parent 736663928832
ref#3: shared block backref parent 736625934336
ref#4: shared block backref parent 471068426240
ref#5: shared block backref parent 470548611072
ref#6: shared block backref parent 350823383040
ref#7: shared block backref parent 349530652672
ref#8: shared block backref parent 51197263872
ref#9: shared block backref parent 50881314816
item 107 key (470812655616 169 0) itemoff 9632 itemsize
  51
extent refs 3 gen 4865700 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737392377856
ref#2: shared block backref parent 471391862784
item 108 key (470812688384 169 0) itemoff 9581 itemsize
  51
extent refs 3 gen 4865700 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737392771072
ref#2: shared block backref parent 471391895552
item 109 key (470812721152 169 0) itemoff 9548 itemsize
  33
extent refs 1 gen 4796010 flags 258
ref#0: shared block backref parent 152641617920
item 110 key (470812753920 169 0) itemoff 9515 itemsize
  33
extent refs 1 gen 4833020 flags 258
ref#0: shared block backref parent 471057973248
item 111 key (470812786688 169 0) itemoff 9482 itemsize
  33
extent refs 1 gen 4833020 flags 258
ref#0: shared block backref parent 471057973248
item 112 key (470812835840 169 0) itemoff 9449 itemsize
  33
extent refs 1 gen 4814184 flags 258
ref#0: tree block backref root 480469
item 113 key (470812868608 169 0) itemoff 9416 itemsize
  33
extent refs 1 gen 4814184 flags 258
ref#0: shared block backref parent 152649089024
item 114 key (470812901376 169 0) itemoff 9383 itemsize
  33
extent refs 1 gen 3786399 flags 2
ref#0: tree block backref root 372498
item 115 key (470812917760 169 0) itemoff 9350 itemsize
  33
extent refs 1 gen 3786399 flags 2
ref#0: tree block backref root 372498
item 116 key (470812934144 169 0) itemoff 9317 itemsize
  33
extent refs 1 gen 4814184 flags 258
ref#0: shared block backref parent 736612941824
item 117 key (470812999680 169 0) itemoff 9284 itemsize
  33
extent refs 1 gen 3192658 flags 2
ref#0: tree block backref root 398
item 118 key (470813065216 169 0) itemoff 9233 itemsize
  51
extent refs 3 gen 4865321 flags 258
ref#0: shared block backref parent 736775798784
ref#1: shared block backref parent 736755400704
ref#2: shared block backref parent 349566222336
item 119 key (470813130752 169 0) itemoff 9200 itemsize
  33
extent refs 1 gen 4813730 flags 258
ref#0: shared block backref parent 152772853760
item 120 key (470813163520 169 0) itemoff 9158 itemsize
  42
extent refs 2 gen 3753422 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 51333234688
item 121 key (470813212672 169 0) itemoff 9125 itemsize
  33
extent refs 1 gen 3582623 flags 2
ref#0: tree block backref root 398
item 122 key (470813261824 169 0) itemoff 9002 itemsize
  123
extent refs 11 gen 4838387 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737545355264
ref#2: shared block backref parent 737225555968
ref#3: shared block backref parent 470698000384
ref#4: shared block backref parent 470578429952
ref#5: shared block backref parent 350471487488
ref#6: shared block backref parent 153275826176
ref#7: shared block backref parent 152577064960
ref#8: shared block backref parent 51433160704
ref#9: shared block backref parent 51368902656
ref#10: shared block backref parent 1028685824
item 123 key (470813327360 169 0) itemoff 8969 itemsize
  33
extent refs 1 gen 4848605 flags 258
ref#0: shared block backref parent 736993067008
item 124 key (470813343744 169 0) itemoff 8936 itemsize
  33
extent refs 1 gen 3582623 flags 2
ref#0: tree block backref root 398
item 125 key (470813376512 169 0) itemoff 8903 itemsize
  33
extent refs 1 gen 4813730 flags 258
ref#0: shared block backref parent 152773083136
item 126 key (470813392896 169 0) itemoff 8825 itemsize
  78
extent refs 6 gen 4838387 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 470774349824
ref#2: shared block backref parent 350775836672
ref#3: shared block backref parent 51398656000
ref#4: shared block backref parent 51369590784
ref#5: shared block backref parent 759103488
item 127 key (470813425664 169 0) itemoff 8774 itemsize
  51
extent refs 3 gen 4838387 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737420591104
ref#2: shared block backref parent 350765498368
item 128 key (470813491200 169 0) itemoff 8732 itemsize
  42
extent refs 2 gen 4865525 flags 258
ref#0: shared block backref parent 736771162112
ref#1: shared block backref parent 349568221184
item 129 key (470813507584 169 0) itemoff 8690 itemsize
  42
extent refs 2 gen 4865525 flags 258
ref#0: shared block backref parent 736768950272
ref#1: shared block backref parent 349568073728
item 130 key (470813622272 169 0) itemoff 8639 itemsize
  51
extent refs 3 gen 4838387 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737420591104
ref#2: shared block backref parent 350765498368
item 131 key (470813655040 169 0) itemoff 8606 itemsize
  33
extent refs 1 gen 4813730 flags 258
ref#0: shared block backref parent 152773083136
item 132 key (470813671424 169 0) itemoff 8555 itemsize
  51
extent refs 3 gen 4865700 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737392771072
ref#2: shared block backref parent 471391895552
item 133 key (470813687808 169 0) itemoff 8522 itemsize
  33
extent refs 1 gen 4865525 flags 2
ref#0: tree block backref root 398
item 134 key (470813704192 169 0) itemoff 8489 itemsize
  33
extent refs 1 gen 4865525 flags 258
ref#0: shared block backref parent 470777266176
item 135 key (470813720576 169 0) itemoff 8438 itemsize
  51
extent refs 3 gen 4865700 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737392377856
ref#2: shared block backref parent 471391862784
item 136 key (470813736960 169 0) itemoff 8405 itemsize
  33
extent refs 1 gen 3275257 flags 2
ref#0: tree block backref root 398
item 137 key (470813753344 169 0) itemoff 8372 itemsize
  33
extent refs 1 gen 3717914 flags 2
ref#0: tree block backref root 398
item 138 key (470813786112 169 0) itemoff 8321 itemsize
  51
extent refs 3 gen 4865700 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737392771072
ref#2: shared block backref parent 471391895552
item 139 key (470813884416 169 0) itemoff 8288 itemsize
  33
extent refs 1 gen 4865067 flags 258
ref#0: shared block backref parent 737247936512
item 140 key (470813917184 169 0) itemoff 8237 itemsize
  51
extent refs 3 gen 4864776 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 350761287680
ref#2: shared block backref parent 51255246848
item 141 key (470813999104 169 0) itemoff 8141 itemsize
  96
extent refs 8 gen 4664339 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737305460736
ref#2: shared block backref parent 736612745216
ref#3: shared block backref parent 471363321856
ref#4: shared block backref parent 350379294720
ref#5: shared block backref parent 349652680704
ref#6: shared block backref parent 349115236352
ref#7: shared block backref parent 51438632960
item 142 key (470814015488 169 0) itemoff 8108 itemsize
  33
extent refs 1 gen 4808224 flags 258
ref#0: shared block backref parent 471068426240
item 143 key (470814031872 169 0) itemoff 8075 itemsize
  33
extent refs 1 gen 4864783 flags 2
ref#0: tree block backref root 2
item 144 key (470814048256 169 0) itemoff 8042 itemsize
  33
extent refs 1 gen 3446703 flags 2
ref#0: tree block backref root 398
item 145 key (470814064640 169 0) itemoff 8009 itemsize
  33
extent refs 1 gen 2863244 flags 2
ref#0: tree block backref root 398
item 146 key (470814081024 169 0) itemoff 7976 itemsize
  33
extent refs 1 gen 3446703 flags 2
ref#0: tree block backref root 398
item 147 key (470814212096 169 0) itemoff 7943 itemsize
  33
extent refs 1 gen 3268842 flags 2
ref#0: tree block backref root 398
item 148 key (470814277632 169 0) itemoff 7847 itemsize
  96
extent refs 8 gen 4664339 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737305460736
ref#2: shared block backref parent 736612745216
ref#3: shared block backref parent 471363321856
ref#4: shared block backref parent 350379294720
ref#5: shared block backref parent 349652680704
ref#6: shared block backref parent 349115236352
ref#7: shared block backref parent 51438632960
item 149 key (470814375936 169 0) itemoff 7751 itemsize
  96
extent refs 8 gen 4679244 flags 2
ref#0: tree block backref root 398
ref#1: shared block backref parent 737305460736
ref#2: shared block backref parent 736612745216
ref#3: shared block backref parent 471363321856
ref#4: shared block backref parent 350379294720
ref#5: shared block backref parent 349652680704
ref#6: shared block backref parent 349115236352
ref#7: shared block backref parent 51438632960
item 150 key (470814408704 169 0) itemoff 7511 itemsize
  240
		extent refs 24 gen 4803092 flags 2
		ref#0: tree block backref root 398
		ref#1: shared block backref parent 737481834496
		ref#2: shared block backref parent 737393131520
		ref#3: shared block backref parent 737301790720
		ref#4: shared block backref parent 737200062464
		ref#5: shared block backref parent 736778551296
		ref#6: shared block backref parent 736749125632
		ref#7: shared block backref parent 736747782144
		ref#8: shared block backref parent 736705806336
		ref#9: shared block backref parent 471389224960
		ref#10: shared block backref parent 471052976128
		ref#11: shared block backref parent 470802137088
		ref#12: shared block backref parent 470767534080
		ref#13: shared block backref parent 350429577216
		ref#14: shared block backref parent 350375116800
		ref#15: shared block backref parent 349566599168
		ref#16: shared block backref parent 349356081152
		ref#17: shared block backref parent 153246482432
		ref#18: shared block backref parent 153021202432
		ref#19: shared block backref parent 152997888000
		ref#20: shared block backref parent 152630607872
		ref#21: shared block backref parent 51421954048
		ref#22: shared block backref parent 51236110336
		ref#23: shared block backref parent 50828017664
	item 151 key (470814441472 169 0) itemoff 7289 itemsize 222
		extent refs 22 gen 4838387 flags 2
		ref#0: tree block backref root 486052
		ref#1: tree block backref root 486051
		ref#2: tree block backref root 486050
		ref#3: tree block backref root 486049
		ref#4: tree block backref root 486048
		ref#5: tree block backref root 486047
		ref#6: tree block backref root 486046
		ref#7: tree block backref root 486045
		ref#8: tree block backref root 486044
		ref#9: tree block backref root 486043
		ref#10: tree block backref root 486035
		ref#11: tree block backref root 486031
		ref#12: tree block backref root 486018
		ref#13: tree block backref root 486005
		ref#14: tree block backref root 485992
		ref#15: tree block backref root 485979
		ref#16: tree block backref root 485966
		ref#17: tree block backref root 485953
		ref#18: tree block backref root 485721
		ref#19: tree block backref root 485408
		ref#20: tree block backref root 484779
		ref#21: tree block backref root 398
	item 152 key (470814457856 169 0) itemoff 7256 itemsize 33
		extent refs 1 gen 4838485 flags 2
		ref#0: tree block backref root 7
	item 153 key (470814507008 169 0) itemoff 7223 itemsize 33
		extent refs 1 gen 4864783 flags 2
		ref#0: tree block backref root 2
	item 154 key (470814539776 169 0) itemoff 7190 itemsize 33
		extent refs 1 gen 4830938 flags 258
		ref#0: shared block backref parent 737199390720
	item 155 key (470814556160 169 0) itemoff 7157 itemsize 33
		extent refs 1 gen 4864783 flags 2
		ref#0: tree block backref root 2
	item 156 key (470814588928 169 0) itemoff 7124 itemsize 33
		extent refs 1 gen 3658861 flags 2
		ref#0: tree block backref root 398
	item 157 key (470814621696 169 0) itemoff 7091 itemsize 33
		extent refs 1 gen 3295735 flags 2
		ref#0: tree block backref root 398
	item 158 key (470814638080 169 0) itemoff 7058 itemsize 33
		extent refs 1 gen 4864783 flags 2
		ref#0: tree block backref root 2
	item 159 key (470814654464 169 0) itemoff 7025 itemsize 33
		extent refs 1 gen 4864783 flags 2
		ref#0: tree block backref root 2
	item 160 key (470814703616 169 0) itemoff 6992 itemsize 33
		extent refs 1 gen 3268842 flags 2
		ref#0: tree block backref root 398
	item 161 key (470814736384 169 1) itemoff 6959 itemsize 33
		extent refs 1 gen 4857403 flags 258
		ref#0: shared block backref parent 470478274560
	item 162 key (470814752768 169 0) itemoff 6926 itemsize 33
		extent refs 1 gen 3658861 flags 2
		ref#0: tree block backref root 398
	item 163 key (470814834688 169 0) itemoff 6893 itemsize 33
		extent refs 1 gen 3786399 flags 2
		ref#0: tree block backref root 372498
	item 164 key (470814916608 169 0) itemoff 6833 itemsize 60
		extent refs 4 gen 3935308 flags 2
		ref#0: tree block backref root 398
		ref#1: shared block backref parent 349894819840
		ref#2: shared block backref parent 50765283328
		ref#3: shared block backref parent 924663808
	item 165 key (470814949376 169 0) itemoff 6800 itemsize 33
		extent refs 1 gen 4830938 flags 258
		ref#0: shared block backref parent 152888557568
	item 166 key (470815031296 169 0) itemoff 6659 itemsize 141
		extent refs 13 gen 4863749 flags 2
		ref#0: tree block backref root 398
		ref#1: shared block backref parent 737641398272
		ref#2: shared block backref parent 737216856064
		ref#3: shared block backref parent 737046052864
		ref#4: shared block backref parent 736820871168
		ref#5: shared block backref parent 736769540096
		ref#6: shared block backref parent 471276994560
		ref#7: shared block backref parent 350443454464
		ref#8: shared block backref parent 350179344384
		ref#9: shared block backref parent 349797400576
		ref#10: shared block backref parent 153274597376
		ref#11: shared block backref parent 152757616640
		ref#12: shared block backref parent 50575310848
	item 167 key (470815145984 169 0) itemoff 6599 itemsize 60
		extent refs 4 gen 4807178 flags 2
		ref#0: tree block backref root 398
		ref#1: shared block backref parent 736921075712
		ref#2: shared block backref parent 351076073472
		ref#3: shared block backref parent 51439304704
	item 168 key (470815178752 169 0) itemoff 6566 itemsize 33
		extent refs 1 gen 3295735 flags 2
		ref#0: tree block backref root 398
BTRFS critical (device dm-4): adding refs to an existing tree ref, bytenr 4=
70809264128 num_bytes 16384 root_objectid 398 slot 1
BTRFS error (device dm-4): failed to run delayed ref for logical 4708092641=
28 num_bytes 16384 type 176 action 1 ref_mod 1: -117
------------[ cut here ]------------
BTRFS: Transaction aborted (error -117)
WARNING: CPU: 4 PID: 2518421 at fs/btrfs/extent-tree.c:2199 btrfs_run_delay=
ed_refs+0x107/0x140
Modules linked in: hfs cdrom msdos jfs nls_ucs2_utils cdc_acm ch341 usbseri=
al exfat sg uas usb_storage rpcsec_gss_krb5 nfsv4 dns_resolver nfs netfs nf=
_conntrack_netlink xfrm_user xfrm_algo xt_addrtype br_netfilter bridge stp =
llc xt_tcpudp xt_conntrack rfcomm snd_seq_dummy snd_hrtimer ccm overlay ipt=
_REJECT nf_reject_ipv4 xt_MASQUERADE xt_LOG nf_log_syslog nft_compat nft_ch=
ain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash n=
f_tables algif_skcipher af_alg bnep binfmt_misc btusb btrtl uvcvideo btbcm =
videobuf2_vmalloc btmtk uvc btintel videobuf2_memops videobuf2_v4l2 videode=
v bluetooth videobuf2_common mc nls_utf8 nls_cp437 vfat fat squashfs loop i=
wlmvm intel_uncore_frequency intel_uncore_frequency_common intel_tcc_coolin=
g mac80211 snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp libarc4=
 snd_hda_codec_realtek kvm_intel snd_hda_codec_generic snd_soc_dmic snd_hda=
_scodec_component iwlwifi snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_s=
of_intel_hda_generic kvm
 snd_sof_intel_hda_common snd_sof_intel_hda snd_sof_pci processor_thermal_d=
evice_pci_legacy snd_sof_xtensa_dsp processor_thermal_device snd_soc_hdac_h=
da processor_thermal_wt_hint snd_soc_acpi_intel_match processor_thermal_rfi=
m snd_soc_acpi mei_pxp mei_hdcp thinkpad_acpi tpm_crb processor_thermal_rap=
l rapl nvram cfg80211 snd_soc_avs intel_cstate platform_profile intel_rapl_=
common nvidiafb pcspkr ucsi_acpi snd_soc_hda_codec processor_thermal_wt_req=
 think_lmi iTCO_wdt vgastate processor_thermal_power_floor firmware_attribu=
tes_class typec_ucsi wmi_bmof fb_ddc ee1004 iTCO_vendor_support snd_hda_int=
el typec mei_me processor_thermal_mbox intel_soc_dts_iosf roles int3403_the=
rmal rfkill ac int340x_thermal_zone intel_pmc_core intel_vsec tpm_tis pmt_t=
elemetry int3400_thermal intel_hid tpm_tis_core pmt_class acpi_pad acpi_tad=
 acpi_thermal_rel sparse_keymap input_leds joydev evdev serio_raw vboxdrv(O=
E) soundwire_intel soundwire_cadence snd_sof_intel_hda_mlink soundwire_gene=
ric_allocation snd_sof_probes snd_sof
 snd_sof_utils snd_intel_dspcfg snd_intel_sdw_acpi snd_soc_skl_hda_dsp snd_=
soc_intel_hda_dsp_common snd_hda_codec snd_hwdep snd_soc_hdac_hdmi snd_hda_=
ext_core snd_soc_core snd_compress snd_pcm_dmaengine snd_hda_core snd_pcm_o=
ss snd_mixer_oss snd_pcm snd_seq_midi snd_seq_midi_event snd_seq snd_timer =
snd_rawmidi snd_seq_device snd_ctl_led snd soundcore ac97_bus configs coret=
emp msr fuse efi_pstore nfsd auth_rpcgss nfs_acl lockd grace sunrpc nfnetli=
nk ip_tables x_tables autofs4 essiv authenc dm_crypt trusted asn1_encoder t=
ee tpm rng_core libaescfb ecdh_generic dm_mod ecc raid456 async_raid6_recov=
 async_memcpy async_pq async_xor async_tx sata_sil24 r8169 realtek mdio_dev=
res libphy mii hid_generic usbhid hid i915 drm_buddy xhci_pci i2c_algo_bit =
ttm crct10dif_pclmul xhci_hcd crc32_pclmul drm_display_helper crc32c_intel =
rtsx_pci_sdmmc polyval_clmulni cec polyval_generic mmc_core usbcore rc_core=
 i2c_i801 video ptp i2c_mux ghash_clmulni_intel spi_intel_pci sha512_ssse3 =
sha256_ssse3 psmouse sha1_ssse3 rtsx_pci
 thunderbolt spi_intel i2c_smbus pps_core hwmon usb_common thermal battery =
wmi aesni_intel crypto_simd cryptd [last unloaded: igc]
CPU: 4 UID: 0 PID: 2518421 Comm: btrfs Tainted: G     U     OE      6.11.2-=
amd64-preempt-sysrq-20241007 #1 1a512c2db5f087f236d90ecfb30551fddcc51243
Tainted: [U]=3DUSER, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
Hardware name: LENOVO 20YU002JUS/20YU002JUS, BIOS N37ET49W (1.30 ) 11/15/20=
23
RIP: 0010:btrfs_run_delayed_refs+0x107/0x140
Code: 01 00 00 00 eb b6 e8 18 8e b7 00 31 db 89 d8 5b 5d 41 5c 41 5d 41 5e =
c3 cc cc cc cc 89 de 48 c7 c7 40 bb b7 93 e8 f9 0c 9f ff <0f> 0b eb d0 66 6=
6 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00
RSP: 0018:ffffade4eb1bb728 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 00000000ffffff8b RCX: 0000000000000027
RDX: ffff92922f421848 RSI: 0000000000000001 RDI: ffff92922f421840
RBP: ffff9273b9581930 R08: 0000000000000000 R09: 0000000000000003
R10: ffffade4eb1bb5c8 R11: ffff9292af7d5028 R12: 0000000000000000
R13: ffff9278edc36358 R14: ffff9278edc36200 R15: 0000000000000000
FS:  00007fbb83c6a380(0000) GS:ffff92922f400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005609e129c078 CR3: 000000137eeb6002 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x7c/0x140
 ? btrfs_run_delayed_refs+0x107/0x140
 ? report_bug+0x160/0x1c0
 ? handle_bug+0x41/0x80
 ? exc_invalid_op+0x15/0x100
 ? asm_exc_invalid_op+0x16/0x40
 ? btrfs_run_delayed_refs+0x107/0x140
 ? btrfs_run_delayed_refs+0x107/0x140
 btrfs_commit_transaction+0x69/0xe80
 ? btrfs_update_reloc_root+0x12d/0x240
 prepare_to_merge+0x4f0/0x600
 relocate_block_group+0x113/0x500
 btrfs_relocate_block_group+0x27a/0x440
 btrfs_relocate_chunk+0x3b/0x180
 btrfs_balance+0x8c1/0x1340
 ? btrfs_ioctl+0x18db/0x26c0
 btrfs_ioctl+0x2285/0x26c0
 ? vm_area_alloc+0x59/0xc0
 ? chacha_block_generic+0x6f/0xc0
 ? __rmqueue_pcplist+0xa9/0xd80
 ? __rmqueue_pcplist+0xa9/0xd80
 __x64_sys_ioctl+0x90/0x100
 do_syscall_64+0x69/0x140
 ? get_page_from_freelist+0x5ab/0x1900
 ? __alloc_pages_noprof+0x17f/0x380
 ? __mod_memcg_lruvec_state+0x91/0x140
 ? __lruvec_stat_mod_folio+0x7f/0x100
 ? __pte_offset_map_lock+0x92/0x140
 ? set_ptes.constprop.0+0x41/0xc0
 ? do_anonymous_page+0xfa/0x800
 ? __pte_offset_map+0x17/0x180
 ? __handle_mm_fault+0x852/0x880
 ? __count_memcg_events+0x54/0x100
 ? count_memcg_events.constprop.0+0x1a/0x40
 ? handle_mm_fault+0xaa/0x300
 ? do_user_addr_fault+0x375/0x680
 ? clear_bhb_loop+0x45/0xc0
 ? clear_bhb_loop+0x45/0xc0
 ? clear_bhb_loop+0x45/0xc0
 ? clear_bhb_loop+0x45/0xc0
 ? clear_bhb_loop+0x45/0xc0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fbb83d834bb
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 =
24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 f=
f ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffc4097f6b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbb83d834bb
RDX: 00007ffc4097f718 RSI: 00000000c4009420 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007fbb83e5eac0 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbb83e5e248
R13: 00007ffc40981e98 R14: 000055c3c393515c R15: 0000000000000001
 </TASK>
---[ end trace 0000000000000000 ]---
BTRFS: error (device dm-4 state A) in btrfs_run_delayed_refs:2199: errno=3D=
-117 Filesystem corrupted
BTRFS info (device dm-4 state EA): forced readonly
BTRFS info (device dm-4 state EA): balance: ended with status: -30

--=20
"A mouse is a device used to point at the xterm you want to type in" - A.S.=
R.
=20
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AA=
F9D08


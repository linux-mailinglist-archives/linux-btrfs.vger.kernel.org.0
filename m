Return-Path: <linux-btrfs+bounces-4956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0C8C4D08
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 09:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2A81F22781
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839BD17BA6;
	Tue, 14 May 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="Y4c6Gf4F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9117996
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671765; cv=none; b=LuD/klHSzaRgL6hGOaT5WiZQ6OO1rCjY2LDF9l+ubt3M7LElHxYRLc0/Qo1xP0JUJhRktfbhf0V/MfcAKp448TaCXLOjd3rvBg0wCRw+k/6FVgDgd628LFN5AoTRtSex5Di8AssFqiirHET+6cXlWzocyn/L0eU+7lMh6biFsZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671765; c=relaxed/simple;
	bh=GBukljfZoBn8joNDMr5KT+iLRPSg4mXJGcrs9liQe6U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U+PedM00J0fMz+onjnBhBahyXxp4W1YptnXOI2ByzE02VJdvG6KX5SjVHxIdL44g2n12nHLTZ9v+z5pWTfsQt6YMc2c/NUbjIHhH/FP1tgVU2YoD98L+zLEZeJvzLbms4Btt0Wc9pQLbbIYUpALWvHe6feSTkUxizbAiQID2k8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=Y4c6Gf4F; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id ACBBC60D77
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 09:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1715671358; x=
	1717410159; bh=GBukljfZoBn8joNDMr5KT+iLRPSg4mXJGcrs9liQe6U=; b=Y
	4c6Gf4FJV3ldUO4kfYFYFn8NkvyN30eqZmc7f2bmH0TJjuHGGjD4Cj7xakplBD6u
	ovWIIW5mHY+A+7byGO5iOzZjH7w+ic5tgqMLlux3ojPzmRnOLnSBGjBV6U84jLBQ
	RsbSCHmngGpTdqlrqPvsuaE2dZCldMyg1cFcbev/SzErOIqtYRXGQfx567JjvRbd
	O0vHjl8sg/gys6o5oCK/fbiBMTp7z7NdDdIoWghQyrlYdLX/IBI/oDA2XK6DfCjI
	nymHd/c7k+ps9ytGHnFOMDAyIWnY7sqqc7HwFNkiHHlqnj1BGbNNGynfDB7mDFDz
	KZlbeIlvytqe9CPM/XWxg==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id RDfziploWVBL for <linux-btrfs@vger.kernel.org>;
 Tue, 14 May 2024 09:22:38 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Tue, 14 May 2024 09:22:38 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: list all subvolumes below given path?
Message-ID: <20240514072238.GA110925@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20230822


I need to know all subvolumes below a given path.

An example:

/local/test is a subvolume of /local and contains some subvolumes itself:

root@fex:/local/test# mount | grep /local
/dev/sde1 on /local type btrfs (rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/)


This works but it is very slow on BIG filesystems:

root@fex:/local/test# find . -inum 256
.
./sv1
./sv1/sv1_1
./sv1/sv1_1/ss
./sv1/sv1_2
./sv2


This does not list sub-subvolumes and it contains the whole path up to the
btrfs root subvolume:

root@fex:/local/test# btrfs subvolume list -o .
ID 62531 gen 6079120 top level 62530 path test/sv1
ID 62532 gen 6079120 top level 62530 path test/sv2


This lists all subvolumes of the filesystem:

root@fex:/local/test# btrfs subvolume list .
ID 350 gen 6079851 top level 5 path home
ID 505 gen 6079123 top level 350 path home/smc/test
ID 621 gen 6079123 top level 350 path home/framstag/blubb
ID 2524 gen 3666531 top level 621 path home/framstag/blubb/.snapshot/2017-12-02_1026.test
ID 18082 gen 3666531 top level 621 path home/framstag/blubb/.snapshot/2019-07-18_0139.test
ID 18091 gen 6079833 top level 5 path tmp/test
ID 27760 gen 3666531 top level 621 path home/framstag/blubb/.snapshot/2020-07-10_1123.test
ID 36104 gen 3666531 top level 621 path home/framstag/blubb/.snapshot/2021-05-31_1052.test
ID 60430 gen 5849702 top level 621 path home/framstag/blubb/.snapshot/2024-02-16_1148.test
ID 62480 gen 6073978 top level 350 path home/.snapshot/2024-05-11_0000.daily
ID 62504 gen 6073978 top level 350 path home/.snapshot/2024-05-12_0000.weekly
ID 62530 gen 6079831 top level 5 path test
ID 62531 gen 6079120 top level 62530 path sv1
ID 62532 gen 6079120 top level 62530 path sv2
ID 62533 gen 6079120 top level 62531 path sv1/sv1_1
ID 62534 gen 6079120 top level 62531 path sv1/sv1_2
ID 62540 gen 6076249 top level 350 path home/.snapshot/2024-05-13_0000.daily
ID 62545 gen 6076377 top level 62533 path sv1/sv1_1/ss
ID 62565 gen 6078533 top level 350 path home/.snapshot/2024-05-13_2100.hourly
ID 62566 gen 6078643 top level 350 path home/.snapshot/2024-05-13_2200.hourly
ID 62567 gen 6078751 top level 350 path home/.snapshot/2024-05-13_2300.hourly
ID 62568 gen 6078859 top level 350 path home/.snapshot/2024-05-14_0000.daily
ID 62569 gen 6078967 top level 350 path home/.snapshot/2024-05-14_0100.hourly
ID 62570 gen 6079075 top level 350 path home/.snapshot/2024-05-14_0200.hourly
ID 62571 gen 6079183 top level 350 path home/.snapshot/2024-05-14_0300.hourly
ID 62572 gen 6079292 top level 350 path home/.snapshot/2024-05-14_0400.hourly
ID 62573 gen 6079401 top level 350 path home/.snapshot/2024-05-14_0500.hourly
ID 62574 gen 6079509 top level 350 path home/.snapshot/2024-05-14_0600.hourly
ID 62575 gen 6079617 top level 350 path home/.snapshot/2024-05-14_0700.hourly
ID 62576 gen 6079725 top level 350 path home/.snapshot/2024-05-14_0800.hourly
ID 62577 gen 6079833 top level 350 path home/.snapshot/2024-05-14_0900.hourly

How do I know which subvolumes are below $PWD ?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20240514072238.GA110925@tik.uni-stuttgart.de>


Return-Path: <linux-btrfs+bounces-18967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C45C5A5AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 23:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49EFA34B282
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 22:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80112E1C63;
	Thu, 13 Nov 2025 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.world@gmx.com header.b="aDcghvs2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F14502F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073644; cv=none; b=koDXTp+a60ZaJiU+85lhqQR+su8VrEKhkqJ1UmP5r5OHcDL5NbmXhRgkq4dN3F47am1he9FdkVix0FRDlxRLpPyuv4+KMZ3f5dvRxrOJy8JYlq68CPDvh7s0JY+ZmQ4ld7SMIaVSzIpHSu5AsaBoesdqgCYa8KprlymD2GTth0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073644; c=relaxed/simple;
	bh=cAlDAPQDsnaXCwEUcdE7kspludiQEflElGl0JPTNleQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=N8d89XzoVERmb4ztuIw6ynecg6gY5rB6UBBiF69+cY1aFUj7tF5stkuQB7qAi3YIaqNIeGFtMWHg8J5fEq8JpC4nSYuXTvzXaRfQK7PtaWYqWVQE76n0J2YiJjZQ1N+AJZYm2mkIs+mPU9xNBVnqK4Cvam2/WoJV1tq/KPddiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.world@gmx.com header.b=aDcghvs2; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763073640; x=1763678440; i=pj.world@gmx.com;
	bh=cAlDAPQDsnaXCwEUcdE7kspludiQEflElGl0JPTNleQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aDcghvs2oqFjxLwV/PkArmE1++hqnBHybuYTn27fiBillQKwZxyJx/8rhFZUsLvz
	 zwwGCQ63i+yLhPgYSO5wxWgv9iCPnN++tUryFCHhzaUFkSnez6MSG6LlNUUcQaKPh
	 U0zq/mhOR1fhMSaZPORbxTkHH0UUdpcNfTsNqGfLnkYWQOz5hVykD5uZdK+d8XHl0
	 NS4Nzkv8EXWgJpr/GbVCSKlfpSGlCW1xnsSmfi6t+wMrDLPVm/ndcshpJIRVsOtO0
	 8EWgxpIsGqxhIq7rdZrUbZRv/oeYs/N3AMq7duzV9GVe0pMJNRdfK2TgjfAN8ImJ1
	 Fdf6e7lK88GDrTnCwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.6] ([75.168.199.57]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU0q-1vruLk13ES-00gPsN for
 <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 23:40:40 +0100
Message-ID: <1c371732-db4f-49ad-bc00-876b3be0fe98@gmx.com>
Date: Thu, 13 Nov 2025 16:40:38 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Paul Graff <pj.world@gmx.com>
Subject: Stuck subvolume removal:
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8zUy4issBR71pH8tO/h2gYh+1fyDzFllkn22G83BxwNLtuFp9vN
 qtWCXWhqfc0pCVlRBVN+XvPNlfMe6sx8k5l22WccdW0iuuoums0nOcAYee1hWlKY5z9luOl
 tIQP5GIprtYcoOQHf7d9e24p+6kToJFypaQhhGuM3K2C7xrTmXtLC0OeqdUFtBur9TtrB4t
 p3uF1BT85uXn1SjIEWzFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D4foBu7C4xM=;HbbkyTwk6qn9MhE/rzdNIODaXZy
 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

Hi, currently there is a dropped subvolume error when running a full=20
balance on a single SSD.

|:~> sudo btrfs balance start / WARNING: Full balance without filters=20
requested. This operation is very intense and takes potentially very=20
long. It is recommended to use the balance filters to narrow down the=20
scope of balance. Use 'btrfs balance start --full-balance' option to=20
skip this warning. The operation will start in 10 seconds. Use Ctrl-C to=
=20
stop it. 10 9 8 7 6 5 4 3 2 1 Starting balance without any filters.=20
ERROR: error during balancing '/': Structure needs cleaning There may be=
=20
more info in syslog - try dmesg | tail hightower-i5-6600k:~> dmesg |=20
tail [38576.407681] [ T29728] BTRFS info (device dm-2): found 37170=20
extents, stage: update data pointers [38584.873805] [ T29728] BTRFS info=
=20
(device dm-2): relocating block group 64891125760 flags data=20
[38607.693519] [ T29728] BTRFS info (device dm-2): found 33194 extents,=20
stage: move data extents [38641.574032] [ T29728] BTRFS info (device=20
dm-2): found 33194 extents, stage: update data pointers [38649.812477] [=
=20
T29728] BTRFS info (device dm-2): relocating block group 62710087680=20
flags data [38662.710999] [ T29728] BTRFS info (device dm-2): found=20
43884 extents, stage: move data extents [38696.292982] [ T29728] BTRFS=20
info (device dm-2): found 43884 extents, stage: update data pointers=20
[38708.587669] [ T29728] BTRFS info (device dm-2): relocating block=20
group 60294168576 flags metadata|dup [38714.889735] [ T29728] BTRFS=20
error (device dm-2): cannot relocate partially dropped subvolume 490,=20
drop progress key (853588 108 0) [38723.736887] [ T29728] BTRFS info=20
(device dm-2): balance: ended with status: -117 hightower-i5-6600k:~>|

After passing,

|:~> sudo btrfs subvolume sync / [sudo] password for root:=20
hightower-i5-6600k:~> |

the command returned to prompt very, very quickly.

A second balance attempt results with the following output:

|:~> sudo btrfs balance start / WARNING: Full balance without filters=20
requested. This operation is very intense and takes potentially very=20
long. It is recommended to use the balance filters to narrow down the=20
scope of balance. Use 'btrfs balance start --full-balance' option to=20
skip this warning. The operation will start in 10 seconds. Use Ctrl-C to=
=20
stop it. 10 9 8 7 6 5 4 3 2 1 Starting balance without any filters.=20
ERROR: error during balancing '/': Structure needs cleaning There may be=
=20
more info in syslog - try dmesg | tail hightower-i5-6600k:~> |

|:~> dmesg | tail [93689.781162] [ T69656] BTRFS info (device dm-2):=20
found 16 extents, stage: update data pointers [93690.667290] [ T69656]=20
BTRFS info (device dm-2): relocating block group 1495819878400 flags=20
data [93703.323923] [ T69656] BTRFS info (device dm-2): found 33=20
extents, stage: move data extents [93705.575991] [ T69656] BTRFS info=20
(device dm-2): found 33 extents, stage: update data pointers=20
[93706.769453] [ T69656] BTRFS info (device dm-2): relocating block=20
group 1494746136576 flags data [93725.570642] [ T69656] BTRFS info=20
(device dm-2): found 39 extents, stage: move data extents [93727.449779]=
=20
[ T69656] BTRFS info (device dm-2): found 39 extents, stage: update data=
=20
pointers [93728.465650] [ T69656] BTRFS info (device dm-2): relocating=20
block group 60294168576 flags metadata|dup [93736.722689] [ T69656]=20
BTRFS error (device dm-2): cannot relocate partially dropped subvolume=20
490, drop progress key (853588 108 0) [93750.594559] [ T69656] BTRFS=20
info (device dm-2): balance: ended with status: -117 hightower-i5-6600k:~>=
 |

Please see the following referenced, prior posting for stuck subvolume=20
removal similarity.=20
https://lore.kernel.org/linux-btrfs/9f936d59-d782-1f48-bbb7-dd1c8dae2615@g=
mail.com/

Is there a patch for btrfsprogs? If so can the patch be merged?|
|

What are your thoughts on this?






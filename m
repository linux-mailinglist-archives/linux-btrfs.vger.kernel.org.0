Return-Path: <linux-btrfs+bounces-11921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D57A48D98
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 01:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F3B16E176
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 00:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F0C2F2;
	Fri, 28 Feb 2025 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JWSTwgSL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sonic322-27.consmr.mail.bf2.yahoo.com (sonic322-27.consmr.mail.bf2.yahoo.com [74.6.132.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA94C6D
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740704274; cv=none; b=kCCsd2G4cIT/AxClYFsp/YjAjEdLUvGk2W6MJkBraEAZ72Wq1FNiv+1Tuge/KQeFtA7MnbBrxsmwe2IdKA/zhsrzfJOAqN7dNHAhfpw2SGF3KD3R6LXN1JpwoVF5FvIlK//zLG/H+e15W6rfhtkARhFFO8La64uTYiKSq58ULQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740704274; c=relaxed/simple;
	bh=GGR55SA0N3m0QcHPcijYUYgCyj6ILsC00bIkAWmzuvM=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=mZ2Iv6k9ktVvALyPaPxRwusKygRyo0SYQ2kFMFcT83PnLArBLUxK13x4ACruEsMHW0Yx2JFQ/Uoup7EgJ8mkvybQGhPZzkeDFge3vL/Xhi+Yy1dql0MYPtL0KMLFs1VWHZuEFHgP1TbcbxPzEadTAtTwnEM/cR78v8MOZ/hXsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JWSTwgSL; arc=none smtp.client-ip=74.6.132.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740704271; bh=EQAtjN2RfFMkOTHh5phEb1t+KUwODgeop0purkiRFgo=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=JWSTwgSLjP26Url4da3ww5LtY2j2Fm6IiJBCSKdgqzB3evJC6GoIk406UXLwXZhXLyIS/7OkoxANYU4okGMF6kz54STQ4DSyhkSsPGtW87lC4r0i6qbNiOIFFiIcHPokqf2krytr0JNiyZyultEOD7s4HvwNz4iKZQbi+6EN3No7318zDK4xjeD9UEvvfwQ19kGSko/TgbYkL9un0peBbc6evoLKVN89eDdTwMHzxAzPH5rPVXOvX6t6CSlgXwRwFUufhHYk7UVYe7ix0u+uX0q0Qet908FMso1bVm++tk+XrhKqL+JQ+DihKhvDTPiX8qU/CryYYK5HEE2Ow8VbZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740704271; bh=J5WrVPpr1vjF7rKm2oKRdaF4XMX1vgPtGM6NmjZnJLg=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=hIAv61zDScz/MDCE02JQD3rIlt9LCdsTCkxTazPJDcuhyG7GknjfecquGsGYHjpmVfMq1B9lpdygy1SAV5Zbsp9kkkRTkKMd9Pv0jkS07mcUFAN9bLqD/2zERQ4qZeSj541rcq4pQC7hJ2cQFQdROGJsbWbPuVenPcOyv+WYneT/CTr+S+jflxKVx5N/xuuCM5iLMbk/IoECm/dUjKJ9z7DOEPJUlS/1o6SgkPQpTQ/4Cv8QEKJk9oI6pMzM/CKXy0JtqIwRM0AaEoLXpQiPq8DDPuATC0YKXYMutz0T5LGplg9aufgmcc9ojEFgEEdbnN1TExpjN3OOyeY91lV64g==
X-YMail-OSG: 6vkAMc4VM1n4Ve6WLH6ZVBQzEQ_JlG.nIYXnr6.gSUpZqow2Elxi.rRyXhw.CMa
 kECnuo0tz_wI44WGFLUT8XCckYt_8xehKST7jxB5YgFzVfGvq9B52Zxqj9sYggf0A6QnIYo14aMC
 ONpBX9VXXyHC7nIPGlbqBkGCl4bYLVVLPV2ezorJDZU_CPNOSZwQykVHI6c_RmezVpDWe372JIL.
 8.kwr_9AFXpGnzXk9GNacdakD3mI1zVFI4vC4bGUoF3qgHd4LCrBTD6lspWGxnV6AFCvNbRuPSU9
 OPg0H.9vUmhGUo.uSb2hdGEBY1QLV8Udfh6h0zYOuFrCSwtZSp0z7tN7V3Zsi3VVEQYeGhbut10m
 Mg3aXkqNve8VkucvoEmtuddKlNCHPdGQaVXDygpkUyFza5hpuwgxN25utbyPAiXjGjn9joiM1mfb
 ayiOExB1Vn8WnsuWEWRw6oH0KwtMammYlU74Y3Q63Wqg_BKq2VlPFbwDRTqDn4A7kW4mpgVez3eG
 KndnUDVmZg1MiWoj8f5OP1QuV.7Xj7k7EWy9.G7kABq9zMde9z9PyBVbLTDShbJwbhxZFMCWXvdG
 Y32Nadr1qeLoWIwa9KnTbhUEJ3zys_dV3gjUCq9xRGqpCJDzEeSK5TEgduMLIeN3GfdXvPLV6qj.
 hx4Hq3s8_nT0cY1PRAdbM7..T0QLY5eAYXcF_5crcQMQE0vquM2R8VHUs0XHBVSeajAK20Obewxb
 hQDJv_4Xj7ParsLT8xJMy3PGsF8YlrLgL8OHe6Cpfwerih9uAMQA_BeTFQ11cIRPns5kbDVTGizq
 BFOTwu.O7_zdApS6sntVCZnbyetMj_kDbzenzAfUwon.pHsBI8Ri0bBZZudiIhrPUbGdMhT8LCOG
 M2qD94u1MaCRkzipCc45hlyRwyDhx3FF0zHBKFXnBxA86wZqK_ADWMXxHlKA0o6xFZnMKIDi4Wby
 2I8TdaAfJARIx51gFzhT8BYKFtw36YNdfn.pcWoAvFvj70gtQ5jlzBWKcLbnbIz9IgVRY2jMB7Zv
 orYJu6BChlq0GRvl1aTq1_qCHqwjRuB9_wW9Jj9sFuNFy1ocBA4fkReaaCxLNoPSX0qVA8TdaeNu
 xl46xHmSSPxx7XZR3KyVWaohtCS8lt3widCAFRnyk34hexYm5US4yIg4ZZ3eUJRqTqvErIiKCXMK
 zy7ri8YsMSaRUuKd3i.lhc_aP2icTCPiBlGQKD6Jb6HZjoUkLCn7tejaItFX2zBei2ghlqd3G3Vy
 nFTJQHMspsGuCHgZWlO7ZLG8gz2An5AG.XPDnbBP7SHjoA7FODS7JaVxWnyawu_u1K9dwfNxCJiv
 Yp3gwwRXAfdeJuFf.AJVbe89Eom2akKhOd61FvwHcL4_whAHcHzReYovezHs4rWxVkA0Rjm5L2Te
 f5o4L_OTWc_uFlPpI3d_q62tnlkbBDzfhudRoTW.WyazSb1zvw2U6dagbE6LVN1cBay7D17itTsn
 Q8755sSRVBeuhH0n7plxM6P.6kx2RdOsF5iJLmAZ.emuMZL34B97euuo.3BORS5Jbhxx_0ooap_B
 DMLTCa9DRof7.pP7UDjNFh_4leR_CpZ0WU3hJZc8aq_e1jyaK2ZY96iEeREIrpLKZqhVPRjMXU68
 WylE219F60G83HPvecblAUMjxOByD2U4V5fYEoQdYOd4JFQZJqpnb6rL0aAqJWY...H1__pJFYGo
 xUzp.KEZM2036vTbXVl1BYPDzTW8xsQBJk1MlRe_Z907zj65W8o3aJ4998Dw1AMDGADEn4I29_5Y
 mapUi14lHUel5GcEq7cftt8VIpaIMBgl4hkYXb7Bt7Q9BQxD9BB8DyNbfja0zfvkL98My32NPH4H
 XvEUbpbxHnKaIK3zL05aq.zzr78cMT5.q.XG7BE0eSK_YDfsbVr9a2.fFRZmZ.YOwCzm_1onaKVV
 doaMYNQEidXr2SLqb2TP8N_eSgPrhLMrptCQbWt3O8TbNOye4mOa_DXCPDQNbuEwuBfXiuh1Koxb
 yI6.52tnTVJYgAIaeAAQvG_zLscxjiaCJR7yCihdsmKwzyqonL6x5vw5HkMzXAVjbOD9WQuHJ_Ac
 OfdvfKXs.szIlJgFb37YSkLJeQeu9owo3znH.Xuy5VeYkiv2yEnZvuVOsrFQyx0ZzfAfhX88ouRb
 tL6kdzVUUGKW7WRaZB.ds7tH_t45MM2RJV6XWTabYiftMoleI2PvEOwN_kvTjqTNgRZRC1kCtJOn
 LnHtIJbJrT3Ymuj.h086DRqdKkgDbWSHDkPJNEqIpQXmbA2I5Q04wuG8rw9xgaA--
X-Sonic-MF: <marian_popeanga@yahoo.com>
X-Sonic-ID: ef657933-ecb8-4307-8caf-83cd9c81c0cb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.bf2.yahoo.com with HTTP; Fri, 28 Feb 2025 00:57:51 +0000
Date: Fri, 28 Feb 2025 00:17:19 +0000 (UTC)
From: Marian Popeanga <marian_popeanga@yahoo.com>
To: linux-btrfs@vger.kernel.org
Message-ID: <1212378578.3019983.1740701839353@mail.yahoo.com>
Subject: BTRFS: error (device md1) in btrfs_commit_transaction:2371:
 errno=-5 IO failure
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1212378578.3019983.1740701839353.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.23369 YMailNodin

Hi All, 

I am getting this error on a nas server using 4 HDD, recently after i've had disks in a raid 5 array expanded in size and the file system expanded as well.
What to point out, that during the sync process when i replaced one of the disk, there was other disk which complained that there is 1 byte error (s.m.a.r.t reported it)on it which can not relocated or read.
Thats 1 byte error looks to have been there before, but it never caused a problem, like that i am seeing now. 

That disk itself never failed during the sync and replacement of all the other disks. It just had these IO error probably related to that 1 byte error, which cause the nas to actually flag me about this problem first time.

After  all the 4 disks were upgraded, i did a btrfs check and there wasn't any error reported. Now, this error shows up and makes the file system read only.  I've even tried a btrfs --repair but this error is still there.

I am wondering if this can be fixed without having to rebuild all this file system and what can be the steps? 

Is there a way to know on which access this error happens ? Been trying to read all th files on the file system and they read fine, but this error still showed up.

[29495.068397] BTRFS error (device md1): bdev /dev/md1 errs: wr 11, rd 5, flush 0, corrupt 0, gen 0
[29495.077392] BTRFS error (device md1): bdev /dev/md1 errs: wr 12, rd 5, flush 0, corrupt 0, gen 0
[29495.086360] BTRFS error (device md1): bdev /dev/md1 errs: wr 13, rd 5, flush 0, corrupt 0, gen 0
[29495.096714] BTRFS: error (device md1) in btrfs_commit_transaction:2371: errno=-5 IO failure (Error while writing out transaction)
[29495.108649] BTRFS info (device md1): forced readonly
[29495.113762] BTRFS warning (device md1): Skipping commit of aborted transaction.
[29495.121259] BTRFS: error (device md1) in cleanup_transaction:1975: errno=-5 IO failure

The kernel version is :  5.13.x x86_64 GNU/Linux

thanks alot


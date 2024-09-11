Return-Path: <linux-btrfs+bounces-7922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB25974BE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31B51F25DAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EC513D539;
	Wed, 11 Sep 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVxsoOks"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9D43155
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041268; cv=none; b=XaERj5lv8dPLqIAa36T4VyRh5Tof92pD6NPJ3qbytuUzhPlDdXKWBPis3c0sransMnRpNF5amrYoAFhSWw9SPFrhjm5dvDN7H6HvpZLx9JxYpMfKs7qNmelQSkrGAj7n1NMyI8/ZiNo1fHsP08AxJ+lrzWy/3UTqTqCOCXE8jCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041268; c=relaxed/simple;
	bh=Z0ixPKOh/M07rmwZ72qHrKAzMkHUjM7RVZjyKeFA1Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xsf0ir4iCd045reBVR2rcIVXjSxcvJ/eoGtq9tOAGN50d6C01qOxqooy6bXnYeIwJZRYnLfKB4jyhfDGjfJM4YQ6xm1a8WwwnyHEGcWTb9tWXMULccE57VdddsCe4zEIQ4D7DbRrEsmlo7fmCL9nHKFeZathCuuYRSdp84G0k08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVxsoOks; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99c99acf7so495485685a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 00:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726041265; x=1726646065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDxap6aDB35uBXn2UGtQAAVEE886vzbY+AKwl6E35X4=;
        b=PVxsoOksjzb4tI4p61eqq2Eiq0qw1975Ub7fmkvPevjEBbbR6O36kbZX4AQHmEdKSx
         7a4Ge+V/gj/ouaP4P+y2XdfM/mwrcNt3YRb6B+8TDRN2/3FpiCeEMQNQXj3XLjjDk59X
         3k5N3RA03TGlcdekWxdXUWs4aPruasxEqu1AktQcTk282stm21OjvEozPba0GGqDDraC
         ucifwCzDunjcp4igbsiw0uDmCQJ94ntEU7D4fti/dej0a0Lsxyix2KtF2qO0LNfusnIS
         Nb1aqGQ3aBNsVu8R6QcNQU0sRNdiEPxw5/eKvvoZTG6cME/FlFGLQuljFunSwjyw6nVI
         ou5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041265; x=1726646065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDxap6aDB35uBXn2UGtQAAVEE886vzbY+AKwl6E35X4=;
        b=MZfFfeTTaEdbcDM+A23NFMGZlCvFVGcY0ISQTH8pwicwNW3aMJFRFW32+Xhs1D3S4X
         JWzaglL70q1YpmABEpQ4/tZ3ln4G8011k61+9f3OS/2C5j4blt1oHpRZG7ScvVpSHBsU
         lD/2OlvIGnWh5HiuHUtX4HIbksKYnQ9Vsz8lsRFdLjPPA4SO0txnF0iW6lJxe1i3Ihbb
         vLm2Yatby75OvW9epi2R4MASKPj5ckWN7+64+7QDV2A8FaN1ae1KLOUCmkE0Fdh9CVWA
         lv5sz0rDOYFub5EtXoDN+tSU2yXqn0vtwOlRG8LcEgfpRRi+Twdr5u+1cdT30PdvHNjv
         0RZA==
X-Gm-Message-State: AOJu0YwIxwo95iHxRy11vhL84hJkdsZH3iwPkcWxKMNPVrqGdahRR+BH
	KW1AfCD4kdV1H02CrXjrxrSAPoHRaoXgu7UppdvjjNz7J3+aybvHF9ryKAncw6k3U+gYmq7J+zs
	t3eFUtwB0M0IiUbkXBd8RJnP6F01/nFKF
X-Google-Smtp-Source: AGHT+IET53OSf+FiO2tyX12iVLewtRwbTAN51sJjyT2ECTS72tFVH/ZRK8XaEfTUa1/BL2M++FKwQzjRFtocgSO0ufs=
X-Received: by 2002:a05:620a:2950:b0:7a9:ccb4:b737 with SMTP id
 af79cd13be357-7a9ccb4b973mr751041085a.14.1726041265039; Wed, 11 Sep 2024
 00:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com> <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
 <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com>
In-Reply-To: <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com>
From: Neil Parton <njparton@gmail.com>
Date: Wed, 11 Sep 2024 08:54:14 +0100
Message-ID: <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
Subject: Re: Tree corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

btrfs check --readonly /dev/sda gives the following, I will run a
lowmem command next and report back once finished (takes a while)

Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: 75c9efec-6867-4c02-be5c-8d106b352286
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 24251238731776 bytes used, no error found
total csum bytes: 23630850888
total tree bytes: 25387204608
total fs tree bytes: 586088448
total extent tree bytes: 446742528
btree space waste bytes: 751229234
file data blocks allocated: 132265579855872
 referenced 23958365622272

When the error first occurred I didn't manage to capture what was in
dmesg, but far more info seemed to be printed to the screen when I
check on subsequent tries, I have some photos of these messages but no
text output, but can try again with some mount commands after the
check has completed.

dump as requested:

btrfs ins dump-tree -b 333654787489792 /dev/sda
btrfs-progs v6.10.1
leaf 333654787489792 items 153 free space 6525 generation 12743226
owner EXTENT_TREE
leaf 333654787489792 flags 0x1(WRITTEN) backref revision 1
fs uuid 75c9efec-6867-4c02-be5c-8d106b352286
chunk uuid e240d981-e0b3-478e-8fc6-5bc35eb8a5ad
        item 0 key (333413933600768 EXTENT_ITEM 4096) itemoff 16246 itemsiz=
e 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcfdc8000) shared data backref parent
332807618199552 count 1
        item 1 key (333413933604864 EXTENT_ITEM 4096) itemoff 16209 itemsiz=
e 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd6f7c000) shared data backref parent
332807737425920 count 1
        item 2 key (333413933608960 EXTENT_ITEM 4096) itemoff 16172 itemsiz=
e 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc71f4000) shared data backref parent
332807471579136 count 1
        item 3 key (333413933613056 EXTENT_ITEM 73728) itemoff 16135 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafdb0cc000) shared data backref parent
332807805911040 count 1
        item 4 key (333413933686784 EXTENT_ITEM 4096) itemoff 16098 itemsiz=
e 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd7ef8000) shared data backref parent
332807753662464 count 1
        item 5 key (333413933690880 EXTENT_ITEM 4096) itemoff 16061 itemsiz=
e 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd1d0c000) shared data backref parent
332807650983936 count 1
        item 6 key (333413933707264 EXTENT_ITEM 8192) itemoff 16024 itemsiz=
e 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc7210000) shared data backref parent
332807471693824 count 1
        item 7 key (333413933715456 EXTENT_ITEM 8192) itemoff 15987 itemsiz=
e 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc748c000) shared data backref parent
332807474298880 count 1
        item 8 key (333413933723648 EXTENT_ITEM 4096) itemoff 15950 itemsiz=
e 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcc324000) shared data backref parent
332807556710400 count 1
        item 9 key (333413933727744 EXTENT_ITEM 4096) itemoff 15913 itemsiz=
e 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd016c000) shared data backref parent
332807622017024 count 1
        item 10 key (333413933731840 EXTENT_ITEM 8192) itemoff 15860 itemsi=
ze 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f697a9f3dd) extent data backref root
65241 objectid 65812982 offset 16384 count 1
        item 11 key (333413933744128 EXTENT_ITEM 32768) itemoff 15823
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x128e29807c000) shared data backref parent
326428655075328 count 1
        item 12 key (333413933776896 EXTENT_ITEM 90112) itemoff 15786
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcc070000) shared data backref parent
332807553875968 count 1
        item 13 key (333413933867008 EXTENT_ITEM 16384) itemoff 15749
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc5fb0000) shared data backref parent
332807452426240 count 1
        item 14 key (333413933883392 EXTENT_ITEM 45056) itemoff 15712
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcf044000) shared data backref parent
332807604027392 count 1
        item 15 key (333413933928448 EXTENT_ITEM 4096) itemoff 15675 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcb664000) shared data backref parent
332807543341056 count 1
        item 16 key (333413933932544 EXTENT_ITEM 4096) itemoff 15638 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca5ec000) shared data backref parent
332807526072320 count 1
        item 17 key (333413933940736 EXTENT_ITEM 53248) itemoff 15601
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcc070000) shared data backref parent
332807553875968 count 1
        item 18 key (333413933993984 EXTENT_ITEM 24576) itemoff 15548
itemsize 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f692b06d56) extent data backref root
65241 objectid 63459443 offset 0 count 1
        item 19 key (333413934018560 EXTENT_ITEM 24576) itemoff 15511
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca920000) shared data backref parent
332807529431040 count 1
        item 20 key (333413934043136 EXTENT_ITEM 24576) itemoff 15474
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd2038000) shared data backref parent
332807654309888 count 1
        item 21 key (333413934067712 EXTENT_ITEM 4096) itemoff 15437 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd77c4000) shared data backref parent
332807746109440 count 1
        item 22 key (333413934071808 EXTENT_ITEM 4096) itemoff 15384 itemsi=
ze 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f6601ad27f) extent data backref root
65241 objectid 58569560 offset 606208 count 1
        item 23 key (333413934075904 EXTENT_ITEM 4096) itemoff 15347 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd063c000) shared data backref parent
332807627063296 count 1
        item 24 key (333413934080000 EXTENT_ITEM 45056) itemoff 15310
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcc2c0000) shared data backref parent
332807556300800 count 1
        item 25 key (333413934125056 EXTENT_ITEM 65536) itemoff 15273
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca700000) shared data backref parent
332807527202816 count 1
        item 26 key (333413934190592 EXTENT_ITEM 36864) itemoff 15236
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcabe4000) shared data backref parent
332807532331008 count 1
        item 27 key (333413934227456 EXTENT_ITEM 45056) itemoff 15199
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcbfec000) shared data backref parent
332807553335296 count 1
        item 28 key (333413934272512 EXTENT_ITEM 49152) itemoff 15162
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc9734000) shared data backref parent
332807510638592 count 1
        item 29 key (333413934329856 EXTENT_ITEM 4096) itemoff 15109 itemsi=
ze 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f66299aa80) extent data backref root
65241 objectid 64335008 offset 233472 count 1
        item 30 key (333413934333952 EXTENT_ITEM 4096) itemoff 15072 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd62cc000) shared data backref parent
332807724122112 count 1
        item 31 key (333413934338048 EXTENT_ITEM 65536) itemoff 15035
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca578000) shared data backref parent
332807525597184 count 1
        item 32 key (333413934403584 EXTENT_ITEM 4096) itemoff 14998 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd7200000) shared data backref parent
332807740063744 count 1
        item 33 key (333413934407680 EXTENT_ITEM 4096) itemoff 14961 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca81c000) shared data backref parent
332807528366080 count 1
        item 34 key (333413934411776 EXTENT_ITEM 4096) itemoff 14924 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd0218000) shared data backref parent
332807622721536 count 1
        item 35 key (333413934415872 EXTENT_ITEM 4096) itemoff 14887 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd0218000) shared data backref parent
332807622721536 count 1
        item 36 key (333413934419968 EXTENT_ITEM 4096) itemoff 14850 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd0218000) shared data backref parent
332807622721536 count 1
        item 37 key (333413934424064 EXTENT_ITEM 4096) itemoff 14813 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd0218000) shared data backref parent
332807622721536 count 1
        item 38 key (333413934428160 EXTENT_ITEM 4096) itemoff 14776 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca930000) shared data backref parent
332807529496576 count 1
        item 39 key (333413934432256 EXTENT_ITEM 12288) itemoff 14739
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc98b0000) shared data backref parent
332807512195072 count 1
        item 40 key (333413934444544 EXTENT_ITEM 4096) itemoff 14702 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd2884000) shared data backref parent
332807663009792 count 1
        item 41 key (333413934448640 EXTENT_ITEM 4096) itemoff 14665 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd2884000) shared data backref parent
332807663009792 count 1
        item 42 key (333413934452736 EXTENT_ITEM 24576) itemoff 14628
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd0f10000) shared data backref parent
332807636320256 count 1
        item 43 key (333413934477312 EXTENT_ITEM 8192) itemoff 14591 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafdb400000) shared data backref parent
332807809269760 count 1
        item 44 key (333413934485504 EXTENT_ITEM 12288) itemoff 14554
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8d6c000) shared data backref parent
332807768817664 count 1
        item 45 key (333413934497792 EXTENT_ITEM 8192) itemoff 14517 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8d6c000) shared data backref parent
332807768817664 count 1
        item 46 key (333413934505984 EXTENT_ITEM 45056) itemoff 14480
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd2924000) shared data backref parent
332807663665152 count 1
        item 47 key (333413934551040 EXTENT_ITEM 4096) itemoff 14443 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd2884000) shared data backref parent
332807663009792 count 1
        item 48 key (333413934555136 EXTENT_ITEM 4096) itemoff 14406 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd2884000) shared data backref parent
332807663009792 count 1
        item 49 key (333413934559232 EXTENT_ITEM 12288) itemoff 14369
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd40e0000) shared data backref parent
332807688552448 count 1
        item 50 key (333413934571520 EXTENT_ITEM 4096) itemoff 14332 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca798000) shared data backref parent
332807527825408 count 1
        item 51 key (333413934575616 EXTENT_ITEM 8192) itemoff 14279 itemsi=
ze 53
                refs 1 gen 12742965 flags DATA
                (178 0x63dab8f6bcdd49a6) extent data backref root
65241 objectid 33331033 offset 1490944 count 1
        item 52 key (333413934583808 EXTENT_ITEM 8192) itemoff 14226 itemsi=
ze 53
                refs 1 gen 12743226 flags DATA
                (178 0x63dab8f61ddd30bd) extent data backref root
65241 objectid 33331033 offset 1503232 count 1
        item 53 key (333413934596096 EXTENT_ITEM 4096) itemoff 14189 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd2528000) shared data backref parent
332807659487232 count 1
        item 54 key (333413934600192 EXTENT_ITEM 4096) itemoff 14152 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcd878000) shared data backref parent
332807579074560 count 1
        item 55 key (333413934604288 EXTENT_ITEM 4096) itemoff 14115 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd682c000) shared data backref parent
332807729758208 count 1
        item 56 key (333413934608384 EXTENT_ITEM 4096) itemoff 14078 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc71bc000) shared data backref parent
332807471349760 count 1
        item 57 key (333413934612480 EXTENT_ITEM 4096) itemoff 14041 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc68c0000) shared data backref parent
332807461928960 count 1
        item 58 key (333413934616576 EXTENT_ITEM 4096) itemoff 13988 itemsi=
ze 53
                refs 1 gen 12567531 flags DATA
                (178 0x75c33661b6789a5b) extent data backref root
85604 objectid 4257 offset 0 count 1
        item 59 key (333413934620672 EXTENT_ITEM 4096) itemoff 13951 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc7358000) shared data backref parent
332807473037312 count 1
        item 60 key (333413934624768 EXTENT_ITEM 4096) itemoff 13898 itemsi=
ze 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f60c0842f3) extent data backref root
65241 objectid 64368522 offset 86016 count 1
        item 61 key (333413934628864 EXTENT_ITEM 4096) itemoff 13861 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcf6ec000) shared data backref parent
332807611006976 count 1
        item 62 key (333413934632960 EXTENT_ITEM 40960) itemoff 13808
itemsize 53
                refs 1 gen 12567531 flags DATA
                (178 0x674d52ffe46c9923) extent data backref root 2543
objectid 176303 offset 2359296 count 1
        item 63 key (333413934673920 EXTENT_ITEM 4096) itemoff 13771 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd08c0000) shared data backref parent
332807629701120 count 1
        item 64 key (333413934678016 EXTENT_ITEM 8192) itemoff 13734 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcd738000) shared data backref parent
332807577763840 count 1
        item 65 key (333413934686208 EXTENT_ITEM 4096) itemoff 13681 itemsi=
ze 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f6e76cdbcb) extent data backref root
65241 objectid 53825095 offset 0 count 1
        item 66 key (333413934690304 EXTENT_ITEM 12288) itemoff 13644
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8d6c000) shared data backref parent
332807768817664 count 1
        item 67 key (333413934702592 EXTENT_ITEM 8192) itemoff 13607 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafdb400000) shared data backref parent
332807809269760 count 1
        item 68 key (333413934710784 EXTENT_ITEM 12288) itemoff 13570
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd2664000) shared data backref parent
332807660781568 count 1
        item 69 key (333413934723072 EXTENT_ITEM 8192) itemoff 13533 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8d6c000) shared data backref parent
332807768817664 count 1
        item 70 key (333413934731264 EXTENT_ITEM 8192) itemoff 13496 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8d6c000) shared data backref parent
332807768817664 count 1
        item 71 key (333413934739456 EXTENT_ITEM 8192) itemoff 13459 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8d6c000) shared data backref parent
332807768817664 count 1
        item 72 key (333413934747648 EXTENT_ITEM 8192) itemoff 13422 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8d6c000) shared data backref parent
332807768817664 count 1
        item 73 key (333413934759936 EXTENT_ITEM 20480) itemoff 13385
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12ec1afe94000) shared data backref parent
332884391575552 count 1
        item 74 key (333413934780416 EXTENT_ITEM 8192) itemoff 13348 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8d6c000) shared data backref parent
332807768817664 count 1
        item 75 key (333413934788608 EXTENT_ITEM 8192) itemoff 13311 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8d6c000) shared data backref parent
332807768817664 count 1
        item 76 key (333413934796800 EXTENT_ITEM 8192) itemoff 13274 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcef04000) shared data backref parent
332807602716672 count 1
        item 77 key (333413934804992 EXTENT_ITEM 8192) itemoff 13237 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcd738000) shared data backref parent
332807577763840 count 1
        item 78 key (333413934813184 EXTENT_ITEM 4096) itemoff 13200 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcd738000) shared data backref parent
332807577763840 count 1
        item 79 key (333413934817280 EXTENT_ITEM 61440) itemoff 13163
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8394000) shared data backref parent
332807758495744 count 1
        item 80 key (333413934878720 EXTENT_ITEM 4096) itemoff 13126 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcce5c000) shared data backref parent
332807568474112 count 1
        item 81 key (333413934882816 EXTENT_ITEM 45056) itemoff 13089
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafdbbc0000) shared data backref parent
332807817396224 count 1
        item 82 key (333413934927872 EXTENT_ITEM 8192) itemoff 13036 itemsi=
ze 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f6594cbd10) extent data backref root
65241 objectid 48284802 offset 0 count 1
        item 83 key (333413934956544 EXTENT_ITEM 4096) itemoff 12999 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc9754000) shared data backref parent
332807510769664 count 1
        item 84 key (333413934964736 EXTENT_ITEM 32768) itemoff 12962
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc9d78000) shared data backref parent
332807517208576 count 1
        item 85 key (333413934997504 EXTENT_ITEM 4096) itemoff 12925 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc974c000) shared data backref parent
332807510736896 count 1
        item 86 key (333413935001600 EXTENT_ITEM 16384) itemoff 12888
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc7694000) shared data backref parent
332807476428800 count 1
        item 87 key (333413935017984 EXTENT_ITEM 4096) itemoff 12851 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd07f4000) shared data backref parent
332807628865536 count 1
        item 88 key (333413935022080 EXTENT_ITEM 16384) itemoff 12814
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc7694000) shared data backref parent
332807476428800 count 1
        item 89 key (333413935038464 EXTENT_ITEM 4096) itemoff 12777 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd0948000) shared data backref parent
332807630258176 count 1
        item 90 key (333413935042560 EXTENT_ITEM 4096) itemoff 12740 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd49ec000) shared data backref parent
332807698038784 count 1
        item 91 key (333413935046656 EXTENT_ITEM 4096) itemoff 12703 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca92c000) shared data backref parent
332807529480192 count 1
        item 92 key (333413935050752 EXTENT_ITEM 4096) itemoff 12666 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcfa48000) shared data backref parent
332807614529536 count 1
        item 93 key (333413935054848 EXTENT_ITEM 4096) itemoff 12629 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcd7b0000) shared data backref parent
332807578255360 count 1
        item 94 key (333413935058944 EXTENT_ITEM 4096) itemoff 12592 itemsi=
ze 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc756c000) shared data backref parent
332807475216384 count 1
        item 95 key (333413935067136 EXTENT_ITEM 12288) itemoff 12539
itemsize 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f6d6a2ba5f) extent data backref root
65241 objectid 64130736 offset 6422528 count 1
        item 96 key (333413935079424 EXTENT_ITEM 110592) itemoff 12502
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca350000) shared data backref parent
332807523336192 count 1
        item 97 key (333413935190016 EXTENT_ITEM 57344) itemoff 12465
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcd958000) shared data backref parent
332807579992064 count 1
        item 98 key (333413935247360 EXTENT_ITEM 16384) itemoff 12428
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca3bc000) shared data backref parent
332807523778560 count 1
        item 99 key (333413935263744 EXTENT_ITEM 36864) itemoff 12391
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd60ec000) shared data backref parent
332807722156032 count 1
        item 100 key (333413935300608 EXTENT_ITEM 4096) itemoff 12354
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd642c000) shared data backref parent
332807725563904 count 1
        item 101 key (333413935304704 EXTENT_ITEM 16384) itemoff 12317
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8dd4000) shared data backref parent
332807769243648 count 1
        item 102 key (333413935321088 EXTENT_ITEM 8192) itemoff 12280
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd0bdc000) shared data backref parent
332807632961536 count 1
        item 103 key (333413935337472 EXTENT_ITEM 4096) itemoff 12243
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd77c4000) shared data backref parent
332807746109440 count 1
        item 104 key (333413935341568 EXTENT_ITEM 4096) itemoff 12206
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafced44000) shared data backref parent
332807600881664 count 1
        item 105 key (333413935345664 EXTENT_ITEM 53248) itemoff 12169
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd41c8000) shared data backref parent
332807689502720 count 1
        item 106 key (333413935398912 EXTENT_ITEM 4096) itemoff 12132
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd07b8000) shared data backref parent
332807628619776 count 1
        item 107 key (333413935403008 EXTENT_ITEM 122880) itemoff
12095 itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd9f34000) shared data backref parent
332807787462656 count 1
        item 108 key (333413935525888 EXTENT_ITEM 28672) itemoff 12058
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafda508000) shared data backref parent
332807793573888 count 1
        item 109 key (333413935554560 EXTENT_ITEM 4096) itemoff 12021
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd6fa8000) shared data backref parent
332807737606144 count 1
        item 110 key (333413935558656 EXTENT_ITEM 65536) itemoff 11968
itemsize 53
                refs 1 gen 12567531 flags DATA
                (178 0x674d52ffce820576) extent data backref root 2543
objectid 18446744073709551604 offset 0 count 1
        item 111 key (333413935624192 EXTENT_ITEM 4096) itemoff 11931
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd07b8000) shared data backref parent
332807628619776 count 1
        item 112 key (333413935628288 EXTENT_ITEM 4096) itemoff 11894
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcc2fc000) shared data backref parent
332807556546560 count 1
        item 113 key (333413935632384 EXTENT_ITEM 4096) itemoff 11841
itemsize 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f6d8f7448b) extent data backref root
65241 objectid 57164853 offset 1245184 count 1
        item 114 key (333413935636480 EXTENT_ITEM 4096) itemoff 11804
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafda694000) shared data backref parent
332807795195904 count 1
        item 115 key (333413935640576 EXTENT_ITEM 8192) itemoff 11767
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcf1bc000) shared data backref parent
332807605567488 count 1
        item 116 key (333413935656960 EXTENT_ITEM 20480) itemoff 11730
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcf674000) shared data backref parent
332807610515456 count 1
        item 117 key (333413935677440 EXTENT_ITEM 4096) itemoff 11693
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc7408000) shared data backref parent
332807473758208 count 1
        item 118 key (333413935681536 EXTENT_ITEM 4096) itemoff 11656
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd07b8000) shared data backref parent
332807628619776 count 1
        item 119 key (333413935685632 EXTENT_ITEM 16384) itemoff 11619
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd76bc000) shared data backref parent
332807745028096 count 1
        item 120 key (333413935702016 EXTENT_ITEM 4096) itemoff 11582
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc9b7c000) shared data backref parent
332807515127808 count 1
        item 121 key (333413935706112 EXTENT_ITEM 24576) itemoff 11545
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcf7d4000) shared data backref parent
332807611957248 count 1
        item 122 key (333413935742976 EXTENT_ITEM 40960) itemoff 11508
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd8c6c000) shared data backref parent
332807767769088 count 1
        item 123 key (333413935783936 EXTENT_ITEM 4096) itemoff 11471
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd4a90000) shared data backref parent
332807698710528 count 1
        item 124 key (333413935788032 EXTENT_ITEM 81920) itemoff 11434
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12ec21caf0000) shared data backref parent
332886216474624 count 1
        item 125 key (333413935869952 EXTENT_ITEM 4096) itemoff 11397
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd07b0000) shared data backref parent
332807628587008 count 1
        item 126 key (333413935882240 EXTENT_ITEM 28672) itemoff 11360
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca78c000) shared data backref parent
332807527776256 count 1
        item 127 key (333413935910912 EXTENT_ITEM 4096) itemoff 11323
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc749c000) shared data backref parent
332807474364416 count 1
        item 128 key (333413935915008 EXTENT_ITEM 8192) itemoff 11286
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd07c0000) shared data backref parent
332807628652544 count 1
        item 129 key (333413935923200 EXTENT_ITEM 8192) itemoff 11249
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd07c0000) shared data backref parent
332807628652544 count 1
        item 130 key (333413935931392 EXTENT_ITEM 4096) itemoff 11212
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc7200000) shared data backref parent
332807471628288 count 1
        item 131 key (333413935935488 EXTENT_ITEM 4096) itemoff 11175
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd07b8000) shared data backref parent
332807628619776 count 1
        item 132 key (333413935939584 EXTENT_ITEM 4096) itemoff 11122
itemsize 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f6a6eb9342) extent data backref root
65241 objectid 59009998 offset 544768 count 1
        item 133 key (333413935943680 EXTENT_ITEM 4096) itemoff 11085
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca760000) shared data backref parent
332807527596032 count 1
        item 134 key (333413935947776 EXTENT_ITEM 4096) itemoff 11048
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcb7e0000) shared data backref parent
332807544897536 count 1
        item 135 key (333413935951872 EXTENT_ITEM 4096) itemoff 11011
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd0bf0000) shared data backref parent
332807633043456 count 1
        item 136 key (333413935955968 EXTENT_ITEM 81920) itemoff 10974
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd7a24000) shared data backref parent
332807748599808 count 1
        item 137 key (333413936037888 EXTENT_ITEM 20480) itemoff 10937
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafca400000) shared data backref parent
332807524057088 count 1
        item 138 key (333413936058368 EXTENT_ITEM 8192) itemoff 10900
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcd160000) shared data backref parent
332807571636224 count 1
        item 139 key (333413936066560 EXTENT_ITEM 4096) itemoff 10863
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd11ac000) shared data backref parent
332807639056384 count 1
        item 140 key (333413936070656 EXTENT_ITEM 4096) itemoff 10826
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcedc0000) shared data backref parent
332807601389568 count 1
        item 141 key (333413936082944 EXTENT_ITEM 4096) itemoff 10789
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd5694000) shared data backref parent
332807711309824 count 1
        item 142 key (333413936087040 EXTENT_ITEM 4096) itemoff 10752
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd1958000) shared data backref parent
332807647100928 count 1
        item 143 key (333413936091136 EXTENT_ITEM 20480) itemoff 10699
itemsize 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f6cf3b0e1a) extent data backref root
65241 objectid 60580431 offset 0 count 1
        item 144 key (333413936111616 EXTENT_ITEM 4096) itemoff 10662
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc96c0000) shared data backref parent
332807510163456 count 1
        item 145 key (333413936115712 EXTENT_ITEM 20480) itemoff 10625
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd47c0000) shared data backref parent
332807695761408 count 1
        item 146 key (333413936136192 EXTENT_ITEM 4096) itemoff 10588
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc6db8000) shared data backref parent
332807467139072 count 1
        item 147 key (333413936140288 EXTENT_ITEM 4096) itemoff 10551
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafd0800000) shared data backref parent
332807628914688 count 1
        item 148 key (333413936144384 EXTENT_ITEM 4096) itemoff 10514
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcb6b0000) shared data backref parent
332807543652352 count 1
        item 149 key (333413936148480 EXTENT_ITEM 40960) itemoff 10477
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcb668000) shared data backref parent
332807543357440 count 1
        item 150 key (333413936189440 EXTENT_ITEM 131072) itemoff
10424 itemsize 53
                refs 1 gen 12567531 flags DATA
                (178 0x63dab8f628ab5c29) extent data backref root
65241 objectid 62463844 offset 0 count 1
        item 151 key (333413936320512 EXTENT_ITEM 4096) itemoff 10387
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafcedc0000) shared data backref parent
332807601389568 count 1
        item 152 key (333413936324608 EXTENT_ITEM 4096) itemoff 10350
itemsize 37
                refs 1 gen 12567531 flags DATA
                (184 0x12eafc7350000) shared data backref parent
332807473004544 count 1

On Wed, 11 Sept 2024 at 07:51, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2024/9/11 16:10, Neil Parton =E5=86=99=E9=81=93:
> > btrfs ins dump-tree -b 333413935558656 /dev/sda
> > btrfs-progs v6.10.1
> > checksum verify failed on 333413935558656 wanted 0x00000000 found 0xbd6=
40a79
> > checksum verify failed on 333413935558656 wanted 0x00000000 found 0xbd6=
40a79
> > ERROR: failed to read tree block 333413935558656
>
> Can you provide the full dmesg of that mount failure?
>
> Furthermore please also provide the following dump:
>
> # btrfs ins dump-tree -b 333654787489792 /dev/sda
>
> And if possible, also:
>
> # btrfs check --mode=3Dlowmem /dev/sda
>
> Thanks,
> Qu
> >
> > On Tue, 10 Sept 2024 at 22:30, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/9/11 02:38, Neil Parton =E5=86=99=E9=81=93:
> >>> Arch LTS system (kernel 6.6.50)
> >>>
> >>> Cannot mount a raid1 (data) raid1c3 (metadata) array made up of 4
> >>> drives as I'm getting corrupt leaf and read time tree block corruptio=
n
> >>> errors.
> >>>
> >>> mount -o recovery /dev/sda /mountpoint   didn't help
> >>>
> >>> If I blank the log on what seems to be the affected drive I can get i=
t
> >>> to mount but it will give out the same errors after a few sec and tur=
n
> >>> the file system read only.
> >>>
> >>> If I pull the affected drive and mount degraded I get the same errors
> >>> from another drive.
> >>>
> >>> Trying to work out if I'm shafted or if there are steps I can take to=
 repair.
> >>>
> >>> Critical data is backed up off site but I also have a tonne of
> >>> non-critical data that will take me weeks to re-establish so nuking
> >>> not my preferred option.
> >>>
> >>> I've managed to ssh in and here are some lines from dmesg:
> >>>
> >>> [   14.997524] BTRFS info (device sda): using free space tree
> >>> [   22.987814] BTRFS info (device sda): checking UUID tree
> >>> [  195.130484] BTRFS error (device sda): read time tree block
> >>> corruption detected on logical 333654787489792 mirror 2
> >>> [  195.149862] BTRFS error (device sda): read time tree block
> >>> corruption detected on logical 333654787489792 mirror 1
> >>> [  195.159188] BTRFS error (device sda): read time tree block
> >>> corruption detected on logical 333654787489792 mirror 3
> >>>
> >>> [  195.128789] BTRFS critical (device sda): corrupt leaf:
> >>> block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 le=
n=3D65536
> >>> invalid data ref objectid value 2543
> >>> [  195.148076] BTRFS critical (device sda): corrupt leaf:
> >>> block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 le=
n=3D65536
> >>> invalid data ref objectid value 2543
> >>> [  195.157375] BTRFS critical (device sda): corrupt leaf:
> >>> block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 le=
n=3D65536
> >>> invalid data ref objectid value 2543
> >>
> >> `btrfs ins dump-tree -b 333413935558656 /dev/sda` output please.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> advice needed please
> >>>
> >


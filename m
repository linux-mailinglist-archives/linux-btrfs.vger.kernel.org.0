Return-Path: <linux-btrfs+bounces-10956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609A7A0C29A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 21:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5090B166DF8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FAA1CC881;
	Mon, 13 Jan 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR9KXb37"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2471347B4
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736800249; cv=none; b=mnuBvleHq3jxsbdADBG0SSTaYGG+7nuKXqlJmYTMQCpLOcYikkU3INoMmselW3oGnCa1G7bSwz1OBHyLHz+ziJoE0Bj6wJpOLHy7p5qoYSuxQ75QAJi0UpbiBCmSNS7koMOSWDLy1KCRZRqINL1tG5CWMM7GvOSB9KG5QyUkGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736800249; c=relaxed/simple;
	bh=4UUIAYp1Fs/gY+fEVY2o4CfxcyosbAVLMI68D+ZDv5w=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=EnfGOj1bxfe++5RTVlR0u2D2bOwLxmm2GtwG0o8VBKWsyBbh861W06GOSQd6Mgv+x7F1f91MkmY9DwHnDMZFCL/xqgN2y8B4F9CWXCykbpJqq/IkNXzhGm0RoeYyX0lNwlUKeEJA5uyn7vd+AdFPKPNvnqWbwpYfKlfpaitgY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR9KXb37; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so699144085a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 12:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736800245; x=1737405045; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G5WLq3DIQS8G9IMH7vG+IOFBn6FkGmcIe+gKVl7MUyA=;
        b=XR9KXb37bb9oWKJ62VEk70Ao6cE07JReDDy54UEB7A8GI68KVJlzoCrXvDitQLIkz/
         7kt15wOZKsf7ZPPE6BOuJ1oajIwfGuVAbaq871F6GX2MO6mZQSGaEHDYOa4x8VkS9bTw
         Gv9eqqQ9a0mQp8cO61BR2JUeFtPspLYJ8fPkSUjY6QOPxgprTOYz8O1rsJyyzCXowVox
         ZmgXMnhWV3zTce9g8Ldi2RFoN2gXnE+0KZ5PlRQl9lu3w/Notd6KmWgMkcUKV5bc/Q3R
         dFpZn1+rcqcB4FlbZb99+fmclSgGN820MCMJGhkZwjwWOuwSJhpPb27JGLmm8v0LWXVm
         3OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736800245; x=1737405045;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5WLq3DIQS8G9IMH7vG+IOFBn6FkGmcIe+gKVl7MUyA=;
        b=bwk/G0loxNC3GUIhWivwLJkmHUmiBrNqCEN9dUV3kkRfL8XLhqWSy8jQa3hRDF5pTs
         vBklIy2+bELFajeuMbGozHKP7A3K9DMr0woDkwx+EnJedDoKUE8pDM4ZuIRPE+hshST/
         ajOcNdzYEUuD40EQi/Zq7lps6wmGHF0ECJXad7tYbfjtrW0VPHdY3+CoWT+kWmCHffCQ
         ojQ6qhWjoTeNUIjsJWhQbBtZhmD9z+Au2/tuiexl4mvWC1tIDEwdhTSwjyabwMcVzkjK
         46HK6eT++Bi58KOPRep7jozlfJaj2cgIXyCWmN8UOD4OkNoQp+NV4XKbMlZQdSZ96dSY
         wRfw==
X-Gm-Message-State: AOJu0Yzx1KY0cpFUF8s4mFUXW+VCICZ9cgEAdM/XI39hdQjcyYxg1bdD
	4vnuEM+Bj34foxZroku49V+Soh09XWuVe+0lsgqK/Um5qM/2bnvg797giU79
X-Gm-Gg: ASbGncvqd2/0u7Du88sz9BhOiv4zIo2xu4flgKoAP6xJkrpS5ZFvcclJYGNMRSb77E8
	PyMdWJtBr4lgVEkuXHzyEKnlKwyWf4IA6G+Ab54PE8ze3N2OH2wBXOlbka3+EL2xbG5js7HvVNX
	GuXao46f0fsG48Z3hgM9Ar8lEvXpw1+0g6xshdfF6USeo6ejXOL6y6fD5iWEvkvH7IOBYb5NW8J
	9a1DwnAn52Y6tS9cb5XmQWNe3GDiB31uR6MPnj8imyJAa1zrRY++Yv98fpZy0s46Jc/agkH988W
	xh704rjutcMG7ZGZEtKc45VJpL2l5oOi
X-Google-Smtp-Source: AGHT+IFYRlsrxVsScoxxOKs9+I4tW84KUbFyHs2jsz0AYXJBsyDNBvXBXU08Zfw+z3Ng0JsGCFjVbA==
X-Received: by 2002:a05:620a:2985:b0:7b6:d5cb:43a9 with SMTP id af79cd13be357-7bcd975b149mr2966903685a.23.1736800244540;
        Mon, 13 Jan 2025 12:30:44 -0800 (PST)
Received: from ?IPv6:2600:4041:5b0d:f100:2347:4886:537d:bdd5? ([2600:4041:5b0d:f100:2347:4886:537d:bdd5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248ad6sm526469185a.44.2025.01.13.12.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 12:30:44 -0800 (PST)
Message-ID: <fcc9c66cac45aee144755ee35714d2d358199d25.camel@gmail.com>
Subject: write time tree block corruption detected, forced readonly
From: Jared Van Bortel <jared.e.vb@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: quwenruo.btrfs@gmx.com
Date: Mon, 13 Jan 2025 15:30:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

I am using Arch Linux with the latest linux-zen kernel (6.12.9-zen1-1-
zen). I saw the below error in dmesg today, and my filesystem went read-
only. I haven't rebooted the computer yet. This is my root filesystem.
What should by next steps be in order to get this computer up and
running again?

Would it be OK to just reboot and attempt to use it again? Should I run
any particular commands to further check the integrity of the fs? Or
would it be best to attempt to rebuild the whole fs from backups?

Not sure if it's relevant, but IIRC this filesystem was created by doing
a btrfs-send of each subvolume from my previous btrfs disaster (subject:
"system drive corruption, btrfs check failure") to a new set of SSDs.
Could that have caused an issue? Is it better to use rsync and lose
reflinks, birth times, etc. than to use btrfs-send to recover from a
corrupted fs?

Also, I have the usual question of whether this is most likely to be a
kernel bug, faulty hardware, or user error. And how I might be able to
identify which file(s) is/are corrupted based on the output.

Thanks,
Jared

[Jan13 11:12] amdgpu 0000:0b:00.0: [drm] REG_WAIT timeout 1us * 100 tries -=
 dcn32_program_compbuf_size line:140
[Jan13 11:28] usb 1-5: USB disconnect, device number 2
[  +0.000156] ch341-uart ttyUSB0: ch341-uart converter now disconnected fro=
m ttyUSB0
[  +0.000017] ch341 1-5:1.0: device disconnected
[  +1.054022] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[  +0.221578] usb 1-5: New USB device found, idVendor=3D152a, idProduct=3D8=
5dd, bcdDevice=3D 3.54
[  +0.000005] usb 1-5: New USB device strings: Mfr=3D1, Product=3D3, Serial=
Number=3D2
[  +0.000003] usb 1-5: Product: SMSL USB AUDIO
[  +0.000002] usb 1-5: Manufacturer: SMSL
[  +0.168994] hid-generic 0003:152A:85DD.0007: hiddev98,hidraw6: USB HID v1=
.10 Device [SMSL SMSL USB AUDIO] on usb-0000:02:00.0-5/input3
[  +1.373244] usb 1-5: USB disconnect, device number 3
[  +5.107883] usb 1-5: new high-speed USB device number 4 using xhci_hcd
[  +0.220694] usb 1-5: New USB device found, idVendor=3D152a, idProduct=3D8=
5dd, bcdDevice=3D 3.54
[  +0.000006] usb 1-5: New USB device strings: Mfr=3D1, Product=3D3, Serial=
Number=3D2
[  +0.000002] usb 1-5: Product: SMSL USB AUDIO
[  +0.000002] usb 1-5: Manufacturer: SMSL
[  +0.167869] hid-generic 0003:152A:85DD.0008: hiddev98,hidraw6: USB HID v1=
.10 Device [SMSL SMSL USB AUDIO] on usb-0000:02:00.0-5/input3
[  +0.475221] block nvme0n1: No UUID available providing old NGUID
[  +0.219354] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for =
information.
[  +0.000003] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@=
zx2c4.com>. All Rights Reserved.
[  +0.211925] userif-2: sent link up event.
[Jan13 12:40] amdgpu 0000:0b:00.0: [drm] REG_WAIT timeout 1us * 100 tries -=
 dcn32_program_compbuf_size line:140
[Jan13 12:46] page: refcount:4 mapcount:0 mapping:0000000041aad02f index:0x=
2fba1c78 pfn:0x2f1d83
[  +0.000007] memcg:ffff9c4640065800
[  +0.000002] aops:btree_aops [btrfs] ino:1
[  +0.000026] flags: 0x17ffffd600422e(referenced|uptodate|lru|workingset|pr=
ivate|writeback|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
[  +0.000004] raw: 0017ffffd600422e fffff4f70bc76088 fffff4f70bc76108 ffff9=
c464b91ab48
[  +0.000001] raw: 000000002fba1c78 ffff9c4829b7e000 00000004ffffffff ffff9=
c4640065800
[  +0.000001] page dumped because: eb page dump
[  +0.000001] BTRFS critical (device nvme0n1p2): corrupt leaf: block=3D3279=
774253056 slot=3D66 extent bytenr=3D3148007481344 len=3D8192 invalid extent=
 refs, have 1 expect >=3D inline 513
[  +0.000005] BTRFS info (device nvme0n1p2): leaf 3279774253056 gen 381142 =
total ptrs 198 free space 1189 owner 2
[  +0.000002] 	item 0 key (3148006146048 168 40960) itemoff 16246 itemsize =
37
[  +0.000003] 		extent refs 1 gen 317329 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159772692480 count 1
[  +0.000002] 	item 1 key (3148006187008 168 90112) itemoff 16209 itemsize =
37
[  +0.000001] 		extent refs 1 gen 317329 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159772692480 count 1
[  +0.000002] 	item 2 key (3148006277120 168 90112) itemoff 16172 itemsize =
37
[  +0.000001] 		extent refs 1 gen 317329 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159772692480 count 1
[  +0.000001] 	item 3 key (3148006367232 168 53248) itemoff 16135 itemsize =
37
[  +0.000002] 		extent refs 1 gen 317329 flags 1
[  +0.000000] 		ref#0: shared data backref parent 3159645454336 count 1
[  +0.000002] 	item 4 key (3148006420480 168 4096) itemoff 16098 itemsize 3=
7
[  +0.000001] 		extent refs 1 gen 350629 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3279399190528 count 1
[  +0.000001] 	item 5 key (3148006424576 168 12288) itemoff 16045 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380920 flags 1
[  +0.000001] 		ref#0: extent data backref root 1266 objectid 81837 offset =
335872 count 1
[  +0.000001] 	item 6 key (3148006436864 168 4096) itemoff 15992 itemsize 5=
3
[  +0.000002] 		extent refs 1 gen 381138 flags 1
[  +0.000000] 		ref#0: extent data backref root 1266 objectid 36334 offset =
126140416 count 1
[  +0.000002] 	item 7 key (3148006440960 168 4096) itemoff 15939 itemsize 5=
3
[  +0.000001] 		extent refs 1 gen 380868 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11361751 offse=
t 53248 count 1
[  +0.000002] 	item 8 key (3148006445056 168 4096) itemoff 15886 itemsize 5=
3
[  +0.000003] 		extent refs 1 gen 380993 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80362752 count 1
[  +0.000002] 	item 9 key (3148006449152 168 8192) itemoff 15833 itemsize 5=
3
[  +0.000001] 		extent refs 1 gen 381110 flags 1
[  +0.000001] 		ref#0: extent data backref root 1266 objectid 36334 offset =
401408 count 1
[  +0.000002] 	item 10 key (3148006457344 168 4096) itemoff 15780 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380993 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80370944 count 1
[  +0.000001] 	item 11 key (3148006461440 168 4096) itemoff 15727 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380878 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11366880 offse=
t 49152 count 1
[  +0.000001] 	item 12 key (3148006465536 168 24576) itemoff 15674 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380878 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11400680 offse=
t 0 count 1
[  +0.000002] 	item 13 key (3148006490112 168 36864) itemoff 15621 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380759 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 10310930 offse=
t 0 count 1
[  +0.000002] 	item 14 key (3148006526976 168 16384) itemoff 15568 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380883 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11463290 offse=
t 0 count 1
[  +0.000001] 	item 15 key (3148006543360 168 4096) itemoff 15515 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380868 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11361752 offse=
t 53248 count 1
[  +0.000002] 	item 16 key (3148006547456 168 4096) itemoff 15462 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380869 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11360984 offse=
t 53248 count 1
[  +0.000002] 	item 17 key (3148006551552 168 4096) itemoff 15425 itemsize =
37
[  +0.000001] 		extent refs 1 gen 358854 flags 1
[  +0.000001] 		ref#0: shared data backref parent 883015680 count 1
[  +0.000001] 	item 18 key (3148006555648 168 4096) itemoff 15362 itemsize =
63
[  +0.000001] 		extent refs 3 gen 353588 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3280193339392 count 1
[  +0.000002] 		ref#1: shared data backref parent 3279778250752 count 1
[  +0.000001] 		ref#2: shared data backref parent 3159632166912 count 1
[  +0.000003] 	item 19 key (3148006559744 168 4096) itemoff 15325 itemsize =
37
[  +0.000001] 		extent refs 1 gen 353173 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3279499395072 count 1
[  +0.000001] 	item 20 key (3148006563840 168 4096) itemoff 15288 itemsize =
37
[  +0.000002] 		extent refs 1 gen 351420 flags 1
[  +0.000000] 		ref#0: shared data backref parent 3280260612096 count 1
[  +0.000002] 	item 21 key (3148006567936 168 8192) itemoff 15235 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380876 flags 1
[  +0.000002] 		ref#0: extent data backref root 260 objectid 11390400 offse=
t 131072 count 1
[  +0.000002] 	item 22 key (3148006576128 168 4096) itemoff 15198 itemsize =
37
[  +0.000001] 		extent refs 1 gen 328893 flags 1
[  +0.000001] 		ref#0: shared data backref parent 2570143498240 count 1
[  +0.000001] 	item 23 key (3148006580224 168 4096) itemoff 15161 itemsize =
37
[  +0.000002] 		extent refs 1 gen 328863 flags 1
[  +0.000001] 		ref#0: shared data backref parent 2570143121408 count 1
[  +0.000001] 	item 24 key (3148006584320 168 32768) itemoff 15108 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380902 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11461993 offse=
t 262144 count 1
[  +0.000002] 	item 25 key (3148006617088 168 8192) itemoff 15055 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
93469952 count 1
[  +0.000001] 	item 26 key (3148006625280 168 8192) itemoff 15002 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380877 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11398168 offse=
t 20316160 count 1
[  +0.000001] 	item 27 key (3148006633472 168 20480) itemoff 14949 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380901 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11345760 offse=
t 131072 count 1
[  +0.000002] 	item 28 key (3148006653952 168 4096) itemoff 14899 itemsize =
50
[  +0.000001] 		extent refs 2 gen 359520 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159525146624 count 1
[  +0.000001] 		ref#1: shared data backref parent 438796288 count 1
[  +0.000002] 	item 29 key (3148006658048 168 4096) itemoff 14862 itemsize =
37
[  +0.000001] 		extent refs 1 gen 358988 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3280298065920 count 1
[  +0.000001] 	item 30 key (3148006662144 168 4096) itemoff 14825 itemsize =
37
[  +0.000001] 		extent refs 1 gen 359475 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3279479816192 count 1
[  +0.000002] 	item 31 key (3148006666240 168 4096) itemoff 14788 itemsize =
37
[  +0.000001] 		extent refs 1 gen 359425 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3279526313984 count 1
[  +0.000001] 	item 32 key (3148006670336 168 4096) itemoff 14751 itemsize =
37
[  +0.000001] 		extent refs 1 gen 358801 flags 1
[  +0.000001] 		ref#0: shared data backref parent 882737152 count 1
[  +0.000002] 	item 33 key (3148006674432 168 4096) itemoff 14701 itemsize =
50
[  +0.000001] 		extent refs 2 gen 359298 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3279568994304 count 1
[  +0.000001] 		ref#1: shared data backref parent 2568534867968 count 1
[  +0.000002] 	item 34 key (3148006678528 168 4096) itemoff 14651 itemsize =
50
[  +0.000001] 		extent refs 2 gen 359437 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159414439936 count 1
[  +0.000001] 		ref#1: shared data backref parent 2568534818816 count 1
[  +0.000002] 	item 35 key (3148006682624 168 16384) itemoff 14598 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380896 flags 1
[  +0.000002] 		ref#0: extent data backref root 260 objectid 11455354 offse=
t 131072 count 1
[  +0.000002] 	item 36 key (3148006699008 168 8192) itemoff 14545 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
12811264 count 1
[  +0.000002] 	item 37 key (3148006707200 168 4096) itemoff 14492 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380879 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11400680 offse=
t 57344 count 1
[  +0.000001] 	item 38 key (3148006711296 168 4096) itemoff 14455 itemsize =
37
[  +0.000001] 		extent refs 1 gen 353883 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159603347456 count 1
[  +0.000002] 	item 39 key (3148006715392 168 20480) itemoff 14402 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380903 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11339373 offse=
t 0 count 1
[  +0.000001] 	item 40 key (3148006735872 168 4096) itemoff 14349 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380879 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11400648 offse=
t 57344 count 1
[  +0.000001] 	item 41 key (3148006739968 168 4096) itemoff 14296 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380879 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11400651 offse=
t 57344 count 1
[  +0.000002] 	item 42 key (3148006744064 168 4096) itemoff 14259 itemsize =
37
[  +0.000001] 		extent refs 1 gen 328943 flags 1
[  +0.000001] 		ref#0: shared data backref parent 2570143170560 count 1
[  +0.000001] 	item 43 key (3148006748160 168 53248) itemoff 14206 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380877 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11419532 offse=
t 786432 count 1
[  +0.000001] 	item 44 key (3148006801408 168 4096) itemoff 14169 itemsize =
37
[  +0.000001] 		extent refs 1 gen 359417 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159414439936 count 1
[  +0.000002] 	item 45 key (3148006805504 168 8192) itemoff 14119 itemsize =
50
[  +0.000001] 		extent refs 2 gen 359417 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3279568994304 count 1
[  +0.000001] 		ref#1: shared data backref parent 2568534867968 count 1
[  +0.000002] 	item 46 key (3148006813696 168 4096) itemoff 14082 itemsize =
37
[  +0.000001] 		extent refs 1 gen 359642 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3279526313984 count 1
[  +0.000001] 	item 47 key (3148006817792 168 4096) itemoff 14029 itemsize =
53
[  +0.000001] 		extent refs 1 gen 378971 flags 1
[  +0.000001] 		ref#0: extent data backref root 1266 objectid 81837 offset =
3678208 count 1
[  +0.000002] 	item 48 key (3148006821888 168 77824) itemoff 13976 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380864 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11413221 offse=
t 0 count 1
[  +0.000001] 	item 49 key (3148006899712 168 24576) itemoff 13923 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380864 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11459949 offse=
t 0 count 1
[  +0.000001] 	item 50 key (3148006924288 168 45056) itemoff 13870 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380902 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11475805 offse=
t 131072 count 1
[  +0.000002] 	item 51 key (3148006969344 168 4096) itemoff 13817 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
93359360 count 1
[  +0.000002] 	item 52 key (3148006973440 168 90112) itemoff 13764 itemsize=
 53
[  +0.000001] 		extent refs 3 gen 353966 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81599744 count 3
[  +0.000001] 	item 53 key (3148007063552 168 24576) itemoff 13711 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380899 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11334204 offse=
t 131072 count 1
[  +0.000002] 	item 54 key (3148007088128 168 12288) itemoff 13658 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380899 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11341599 offse=
t 655360 count 1
[  +0.000002] 	item 55 key (3148007100416 168 4096) itemoff 13605 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
07289856 count 1
[  +0.000001] 	item 56 key (3148007104512 168 20480) itemoff 13552 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380898 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 11335137 offse=
t 131072 count 1
[  +0.000002] 	item 57 key (3148007124992 168 53248) itemoff 13499 itemsize=
 53
[  +0.000003] 		extent refs 1 gen 380901 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11334854 offse=
t 7077888 count 1
[  +0.000001] 	item 58 key (3148007178240 168 77824) itemoff 13446 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 353966 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81706240 count 1
[  +0.000002] 	item 59 key (3148007256064 168 40960) itemoff 13393 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380905 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 11388010 offse=
t 1310720 count 1
[  +0.000002] 	item 60 key (3148007297024 168 4096) itemoff 13340 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
08371200 count 1
[  +0.000002] 	item 61 key (3148007301120 168 20480) itemoff 13287 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380902 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11432694 offse=
t 131072 count 1
[  +0.000001] 	item 62 key (3148007321600 168 4096) itemoff 13234 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380990 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
09370624 count 1
[  +0.000002] 	item 63 key (3148007325696 168 61440) itemoff 13181 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380783 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 10379881 offse=
t 0 count 1
[  +0.000002] 	item 64 key (3148007387136 168 77824) itemoff 13128 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380905 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11388010 offse=
t 1179648 count 1
[  +0.000001] 	item 65 key (3148007464960 168 16384) itemoff 13075 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
92957952 count 1
[  +0.000001] 	item 66 key (3148007481344 168 8192) itemoff 13022 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
07224320 count 513
[  +0.000002] 	item 67 key (3148007489536 168 24576) itemoff 12969 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380901 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11154243 offse=
t 0 count 1
[  +0.000002] 	item 68 key (3148007514112 168 28672) itemoff 12916 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380859 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11475439 offse=
t 131072 count 1
[  +0.000001] 	item 69 key (3148007542784 168 24576) itemoff 12863 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380859 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11474325 offse=
t 131072 count 1
[  +0.000002] 	item 70 key (3148007567360 168 12288) itemoff 12810 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380869 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11395006 offse=
t 2752512 count 1
[  +0.000002] 	item 71 key (3148007587840 168 24576) itemoff 12757 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380903 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11399479 offse=
t 0 count 1
[  +0.000001] 	item 72 key (3148007612416 168 12288) itemoff 12704 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 379362 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81530112 count 1
[  +0.000002] 	item 73 key (3148007624704 168 4096) itemoff 12651 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
97885440 count 1
[  +0.000002] 	item 74 key (3148007628800 168 12288) itemoff 12598 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
93322496 count 1
[  +0.000001] 	item 75 key (3148007641088 168 4096) itemoff 12545 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
99233024 count 1
[  +0.000001] 	item 76 key (3148007645184 168 8192) itemoff 12492 itemsize =
53
[  +0.000001] 		extent refs 1 gen 378971 flags 1
[  +0.000001] 		ref#0: extent data backref root 1266 objectid 81837 offset =
516096 count 1
[  +0.000002] 	item 77 key (3148007653376 168 24576) itemoff 12439 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380906 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11435627 offse=
t 3014656 count 1
[  +0.000002] 	item 78 key (3148007677952 168 4096) itemoff 12386 itemsize =
53
[  +0.000001] 		extent refs 1 gen 381110 flags 1
[  +0.000001] 		ref#0: extent data backref root 1266 objectid 81837 offset =
3268608 count 1
[  +0.000001] 	item 79 key (3148007682048 168 4096) itemoff 12333 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
99523840 count 1
[  +0.000002] 	item 80 key (3148007686144 168 8192) itemoff 12280 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
08305664 count 1
[  +0.000002] 	item 81 key (3148007694336 168 4096) itemoff 12227 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
9106944 count 1
[  +0.000001] 	item 82 key (3148007698432 168 4096) itemoff 12174 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
98999552 count 1
[  +0.000001] 	item 83 key (3148007702528 168 12288) itemoff 12121 itemsize=
 53
[  +0.000001] 		extent refs 2 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
93355264 count 2
[  +0.000002] 	item 84 key (3148007714816 168 4096) itemoff 12068 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
09444352 count 1
[  +0.000002] 	item 85 key (3148007718912 168 8192) itemoff 12015 itemsize =
53
[  +0.000001] 		extent refs 1 gen 379362 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
85216512 count 1
[  +0.000001] 	item 86 key (3148007727104 168 8192) itemoff 11962 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
08317952 count 1
[  +0.000002] 	item 87 key (3148007735296 168 4096) itemoff 11909 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
01756160 count 1
[  +0.000002] 	item 88 key (3148007739392 168 4096) itemoff 11856 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
09452544 count 1
[  +0.000001] 	item 89 key (3148007743488 168 4096) itemoff 11803 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
02509824 count 1
[  +0.000002] 	item 90 key (3148007747584 168 24576) itemoff 11750 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380903 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11184796 offse=
t 0 count 1
[  +0.000002] 	item 91 key (3148007772160 168 4096) itemoff 11713 itemsize =
37
[  +0.000001] 		extent refs 1 gen 353256 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159314841600 count 1
[  +0.000001] 	item 92 key (3148007776256 168 4096) itemoff 11650 itemsize =
63
[  +0.000001] 		extent refs 3 gen 328943 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3280260530176 count 1
[  +0.000002] 		ref#1: shared data backref parent 3280145924096 count 1
[  +0.000001] 		ref#2: shared data backref parent 2569855811584 count 1
[  +0.000001] 	item 93 key (3148007780352 168 4096) itemoff 11597 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
12717056 count 1
[  +0.000001] 	item 94 key (3148007784448 168 4096) itemoff 11560 itemsize =
37
[  +0.000001] 		extent refs 1 gen 328943 flags 1
[  +0.000001] 		ref#0: shared data backref parent 2570143170560 count 1
[  +0.000002] 	item 95 key (3148007788544 168 4096) itemoff 11510 itemsize =
50
[  +0.000001] 		extent refs 2 gen 353611 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159628890112 count 1
[  +0.000001] 		ref#1: shared data backref parent 2044858695680 count 1
[  +0.000002] 	item 96 key (3148007792640 168 4096) itemoff 11460 itemsize =
50
[  +0.000001] 		extent refs 2 gen 353288 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159628890112 count 1
[  +0.000001] 		ref#1: shared data backref parent 2044858695680 count 1
[  +0.000001] 	item 97 key (3148007796736 168 8192) itemoff 11407 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
08559616 count 1
[  +0.000001] 	item 98 key (3148007804928 168 4096) itemoff 11370 itemsize =
37
[  +0.000001] 		extent refs 1 gen 351423 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3279304376320 count 1
[  +0.000002] 	item 99 key (3148007809024 168 4096) itemoff 11333 itemsize =
37
[  +0.000001] 		extent refs 1 gen 353157 flags 1
[  +0.000001] 		ref#0: shared data backref parent 3159633018880 count 1
[  +0.000001] 	item 100 key (3148007813120 168 28672) itemoff 11280 itemsiz=
e 53
[  +0.000001] 		extent refs 1 gen 380902 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11424870 offse=
t 131072 count 1
[  +0.000002] 	item 101 key (3148007841792 168 12288) itemoff 11227 itemsiz=
e 53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
08293376 count 1
[  +0.000001] 	item 102 key (3148007854080 168 4096) itemoff 11174 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
13700096 count 1
[  +0.000001] 	item 103 key (3148007858176 168 20480) itemoff 11121 itemsiz=
e 53
[  +0.000001] 		extent refs 1 gen 380856 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11473885 offse=
t 0 count 1
[  +0.000002] 	item 104 key (3148007878656 168 4096) itemoff 11068 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
86101248 count 1
[  +0.000002] 	item 105 key (3148007882752 168 4096) itemoff 11015 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
86240512 count 1
[  +0.000001] 	item 106 key (3148007886848 168 4096) itemoff 10962 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 379362 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
88407296 count 1
[  +0.000002] 	item 107 key (3148007890944 168 12288) itemoff 10909 itemsiz=
e 53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
07257088 count 1
[  +0.000002] 	item 108 key (3148007903232 168 4096) itemoff 10856 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
02989056 count 1
[  +0.000001] 	item 109 key (3148007907328 168 4096) itemoff 10803 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
03353600 count 1
[  +0.000002] 	item 110 key (3148007911424 168 4096) itemoff 10750 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
03505152 count 1
[  +0.000002] 	item 111 key (3148007915520 168 4096) itemoff 10697 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
04135936 count 1
[  +0.000001] 	item 112 key (3148007919616 168 36864) itemoff 10644 itemsiz=
e 53
[  +0.000002] 		extent refs 1 gen 379362 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
82771200 count 1
[  +0.000002] 	item 113 key (3148007956480 168 8192) itemoff 10591 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 379362 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
85294336 count 1
[  +0.000002] 	item 114 key (3148007964672 168 12288) itemoff 10538 itemsiz=
e 53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80841984 count 1
[  +0.000001] 	item 115 key (3148007976960 168 4096) itemoff 10485 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
04455424 count 1
[  +0.000002] 	item 116 key (3148007981056 168 4096) itemoff 10432 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
04930560 count 1
[  +0.000002] 	item 117 key (3148007985152 168 4096) itemoff 10379 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
05348352 count 1
[  +0.000001] 	item 118 key (3148007989248 168 4096) itemoff 10326 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
05516288 count 1
[  +0.000001] 	item 119 key (3148007993344 168 4096) itemoff 10273 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
06401024 count 1
[  +0.000002] 	item 120 key (3148007997440 168 20480) itemoff 10220 itemsiz=
e 53
[  +0.000001] 		extent refs 1 gen 380906 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11213427 offse=
t 0 count 1
[  +0.000001] 	item 121 key (3148008017920 168 16384) itemoff 10167 itemsiz=
e 53
[  +0.000002] 		extent refs 1 gen 380881 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11026222 offse=
t 0 count 1
[  +0.000001] 	item 122 key (3148008034304 168 4096) itemoff 10114 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80375040 count 1
[  +0.000002] 	item 123 key (3148008038400 168 94208) itemoff 10061 itemsiz=
e 53
[  +0.000001] 		extent refs 1 gen 379362 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80305408 count 1
[  +0.000002] 	item 124 key (3148008132608 168 4096) itemoff 10008 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
07212032 count 1
[  +0.000001] 	item 125 key (3148008136704 168 4096) itemoff 9955 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
07269376 count 1
[  +0.000002] 	item 126 key (3148008140800 168 4096) itemoff 9902 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
07830528 count 1
[  +0.000002] 	item 127 key (3148008144896 168 8192) itemoff 9849 itemsize =
53
[  +0.000001] 		extent refs 1 gen 379362 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
85843200 count 1
[  +0.000001] 	item 128 key (3148008153088 168 4096) itemoff 9796 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380990 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80383232 count 1
[  +0.000002] 	item 129 key (3148008157184 168 4096) itemoff 9743 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80391424 count 1
[  +0.000002] 	item 130 key (3148008161280 168 4096) itemoff 9690 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80657664 count 1
[  +0.000001] 	item 131 key (3148008165376 168 4096) itemoff 9637 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
08477696 count 1
[  +0.000002] 	item 132 key (3148008169472 168 4096) itemoff 9584 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80768256 count 1
[  +0.000002] 	item 133 key (3148008173568 168 4096) itemoff 9531 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80796928 count 1
[  +0.000001] 	item 134 key (3148008177664 168 4096) itemoff 9478 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80342272 count 1
[  +0.000003] 	item 135 key (3148008181760 168 4096) itemoff 9425 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
88329472 count 1
[  +0.000002] 	item 136 key (3148008185856 168 20480) itemoff 9372 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380903 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11470692 offse=
t 0 count 1
[  +0.000003] 	item 137 key (3148008206336 168 28672) itemoff 9319 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 379362 flags 1
[  +0.000002] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
83160320 count 1
[  +0.000002] 	item 138 key (3148008235008 168 4096) itemoff 9266 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
11779072 count 1
[  +0.000002] 	item 139 key (3148008239104 168 4096) itemoff 9213 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000002] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81706240 count 1
[  +0.000002] 	item 140 key (3148008243200 168 4096) itemoff 9160 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380994 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81562880 count 1
[  +0.000003] 	item 141 key (3148008247296 168 20480) itemoff 9107 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380904 flags 1
[  +0.000002] 		ref#0: extent data backref root 260 objectid 11372527 offse=
t 0 count 1
[  +0.000002] 	item 142 key (3148008267776 168 57344) itemoff 9054 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 379362 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81857792 count 1
[  +0.000002] 	item 143 key (3148008325120 168 32768) itemoff 9001 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
22056192 count 1
[  +0.000003] 	item 144 key (3148008357888 168 4096) itemoff 8948 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81825024 count 1
[  +0.000002] 	item 145 key (3148008361984 168 4096) itemoff 8895 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380993 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80379136 count 1
[  +0.000002] 	item 146 key (3148008366080 168 32768) itemoff 8842 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380902 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11433402 offse=
t 131072 count 1
[  +0.000002] 	item 147 key (3148008398848 168 32768) itemoff 8789 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380905 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11436127 offse=
t 131072 count 1
[  +0.000001] 	item 148 key (3148008431616 168 4096) itemoff 8736 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380990 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
93367552 count 1
[  +0.000002] 	item 149 key (3148008435712 168 4096) itemoff 8683 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
10132480 count 1
[  +0.000002] 	item 150 key (3148008439808 168 61440) itemoff 8630 itemsize=
 53
[  +0.000001] 		extent refs 5 gen 379362 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
85228800 count 5
[  +0.000001] 	item 151 key (3148008501248 168 4096) itemoff 8577 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380993 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80387328 count 1
[  +0.000002] 	item 152 key (3148008505344 168 36864) itemoff 8524 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380816 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 10686268 offse=
t 0 count 1
[  +0.000002] 	item 153 key (3148008542208 168 12288) itemoff 8471 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
08670208 count 1
[  +0.000001] 	item 154 key (3148008554496 168 8192) itemoff 8418 itemsize =
53
[  +0.000002] 		extent refs 1 gen 379362 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
91630848 count 1
[  +0.000002] 	item 155 key (3148008562688 168 24576) itemoff 8365 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380899 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11453990 offse=
t 131072 count 1
[  +0.000002] 	item 156 key (3148008587264 168 20480) itemoff 8312 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380900 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11316184 offse=
t 0 count 1
[  +0.000001] 	item 157 key (3148008607744 168 28672) itemoff 8259 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380903 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11387813 offse=
t 131072 count 1
[  +0.000001] 	item 158 key (3148008636416 168 20480) itemoff 8206 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380904 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11415453 offse=
t 0 count 1
[  +0.000002] 	item 159 key (3148008656896 168 4096) itemoff 8153 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
88087808 count 1
[  +0.000002] 	item 160 key (3148008660992 168 4096) itemoff 8100 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
88304896 count 1
[  +0.000001] 	item 161 key (3148008665088 168 8192) itemoff 8047 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
88333568 count 1
[  +0.000002] 	item 162 key (3148008673280 168 4096) itemoff 7994 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
90934528 count 1
[  +0.000002] 	item 163 key (3148008677376 168 4096) itemoff 7941 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
91671808 count 1
[  +0.000001] 	item 164 key (3148008681472 168 4096) itemoff 7888 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
92273920 count 1
[  +0.000002] 	item 165 key (3148008685568 168 4096) itemoff 7835 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
93093120 count 1
[  +0.000002] 	item 166 key (3148008689664 168 4096) itemoff 7782 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
01952768 count 1
[  +0.000001] 	item 167 key (3148008693760 168 4096) itemoff 7729 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380996 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
01997824 count 1
[  +0.000002] 	item 168 key (3148008697856 168 20480) itemoff 7676 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380856 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11473890 offse=
t 0 count 1
[  +0.000002] 	item 169 key (3148008718336 168 4096) itemoff 7623 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
93306112 count 1
[  +0.000001] 	item 170 key (3148008722432 168 4096) itemoff 7570 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380995 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
01768448 count 1
[  +0.000002] 	item 171 key (3148008726528 168 4096) itemoff 7517 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380995 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
85925120 count 1
[  +0.000002] 	item 172 key (3148008730624 168 4096) itemoff 7464 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
02063360 count 1
[  +0.000001] 	item 173 key (3148008734720 168 4096) itemoff 7411 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380993 flags 1
[  +0.000000] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81558784 count 1
[  +0.000002] 	item 174 key (3148008738816 168 28672) itemoff 7358 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380904 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11469641 offse=
t 262144 count 1
[  +0.000002] 	item 175 key (3148008767488 168 4096) itemoff 7305 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
11889664 count 1
[  +0.000001] 	item 176 key (3148008771584 168 16384) itemoff 7252 itemsize=
 53
[  +0.000002] 		extent refs 1 gen 380895 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11435071 offse=
t 0 count 1
[  +0.000001] 	item 177 key (3148008787968 168 40960) itemoff 7199 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 379362 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
88268032 count 1
[  +0.000002] 	item 178 key (3148008828928 168 4096) itemoff 7146 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
11947008 count 1
[  +0.000001] 	item 179 key (3148008833024 168 4096) itemoff 7093 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
02092032 count 1
[  +0.000001] 	item 180 key (3148008837120 168 4096) itemoff 7040 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
02100224 count 1
[  +0.000002] 	item 181 key (3148008841216 168 4096) itemoff 6987 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
02722816 count 1
[  +0.000002] 	item 182 key (3148008845312 168 4096) itemoff 6934 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
02796544 count 1
[  +0.000001] 	item 183 key (3148008849408 168 8192) itemoff 6881 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380993 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80334080 count 1
[  +0.000002] 	item 184 key (3148008857600 168 4096) itemoff 6828 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
02993152 count 1
[  +0.000002] 	item 185 key (3148008861696 168 28672) itemoff 6775 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380907 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11431743 offse=
t 131072 count 1
[  +0.000001] 	item 186 key (3148008890368 168 4096) itemoff 6722 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380994 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81587456 count 1
[  +0.000002] 	item 187 key (3148008894464 168 4096) itemoff 6669 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
03001344 count 1
[  +0.000002] 	item 188 key (3148008898560 168 4096) itemoff 6616 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380994 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81648896 count 1
[  +0.000001] 	item 189 key (3148008902656 168 4096) itemoff 6563 itemsize =
53
[  +0.000002] 		extent refs 1 gen 380996 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
03046400 count 1
[  +0.000001] 	item 190 key (3148008906752 168 20480) itemoff 6510 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380898 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11335139 offse=
t 131072 count 1
[  +0.000002] 	item 191 key (3148008927232 168 8192) itemoff 6457 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
11873280 count 1
[  +0.000002] 	item 192 key (3148008935424 168 28672) itemoff 6404 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380895 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11100775 offse=
t 0 count 1
[  +0.000001] 	item 193 key (3148008964096 168 24576) itemoff 6351 itemsize=
 53
[  +0.000001] 		extent refs 1 gen 380900 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 11338472 offse=
t 0 count 1
[  +0.000002] 	item 194 key (3148008988672 168 4096) itemoff 6298 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 4=
12004352 count 1
[  +0.000002] 	item 195 key (3148008992768 168 4096) itemoff 6245 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380993 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81755392 count 1
[  +0.000001] 	item 196 key (3148008996864 168 4096) itemoff 6192 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380990 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
80305408 count 1
[  +0.000002] 	item 197 key (3148009000960 168 4096) itemoff 6139 itemsize =
53
[  +0.000001] 		extent refs 1 gen 380994 flags 1
[  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offset 3=
81837312 count 1
[  +0.000002] BTRFS error (device nvme0n1p2): block=3D3279774253056 write t=
ime tree block corruption detected
[  +0.007065] BTRFS: error (device nvme0n1p2) in btrfs_commit_transaction:2=
523: errno=3D-5 IO failure (Error while writing out transaction)
[  +0.000004] BTRFS info (device nvme0n1p2 state E): forced readonly
[  +0.000001] BTRFS warning (device nvme0n1p2 state E): Skipping commit of =
aborted transaction.
[  +0.000002] BTRFS error (device nvme0n1p2 state EA): Transaction aborted =
(error -5)
[  +0.000001] BTRFS: error (device nvme0n1p2 state EA) in cleanup_transacti=
on:2017: errno=3D-5 IO failure
[  +0.000141] BTRFS warning (device nvme0n1p2 state EA): Skipping commit of=
 aborted transaction.
[  +0.000005] BTRFS: error (device nvme0n1p2 state EA) in cleanup_transacti=
on:2017: errno=3D-5 IO failure


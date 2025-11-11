Return-Path: <linux-btrfs+bounces-18870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B3DC4F2A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 18:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD091888F5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA84377EAC;
	Tue, 11 Nov 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Nn6CxuSn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59819377E8F
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880532; cv=none; b=eOC0OBAiuwDxJnWRRS1+Br8ZJVWwT4RDACMjDHrUlRhi4EdCLaOXn+jYWABZQCLQy7xRX+BVLhqXRoj4nZTmXgkHxrUsAcQmrtJtLsKroXKGHK1cc/oOTpkUXpFvfdBh0UjDc1L7vzLn7xRF+hrTXc836Zc3LH+2PORnFoz3jUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880532; c=relaxed/simple;
	bh=Zr6r/ftyGmWr4w5JnTzMxlHYVDhui5Zdgmro5rQ54Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8I7DU1OhmDQbfyx5r0xVZthlqU07R/rzPSsZvju4MJTzGZAb2/nLwtO1VDKGw1uVU8Q/6COghVMkiXdUb3k/MUPFM5DUy3cJtUPsXE6urHNUZyH1RpAQyz3Havz7iyUwCn976R450tU5LWo0oliftDFuOnBEYfoL89wKBL5Zbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Nn6CxuSn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso45173b3a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 09:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1762880528; x=1763485328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCzmE033nuL3iHnCWz2ye+biF00WnBmAxg8Ssm7kzfg=;
        b=Nn6CxuSn4jfwA/diDCJTx1VIFMnLzJ9XcrOoOrldG7wHgsKWgavOqQcaMvLiOYl6P9
         lBJhjV6aqswEzR7yXINn+52LQt7mqubrWQTnCv310CkE/aKdsjYvT/mL+/4aZVK3w4Oh
         jxFxFXi4AzMuGhRiYMKfFyjqsa0cChKyJwFAL1irh4zQT+JOVF35iGH5R3Wr3ta0qSHm
         WJrKQF5ja0fns5+kDfhmiVq+n3ejZbaSTUHyrLoEmULhJ4X/BNxR4bLfzEMmpI+9pFIW
         KChC3vSYw30Y338kSC63/FqzRWa9HWx5sSzH8y3Qi8ICEZPkvdvW2Wz2HB5rRey1JQLV
         CbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762880528; x=1763485328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCzmE033nuL3iHnCWz2ye+biF00WnBmAxg8Ssm7kzfg=;
        b=KlAmT0VJrzxv9c0YKxEsIBD6Lkf8oUKEjJYn7UmkG/Lmk05EYZDgn9fw1X89Kl+tPa
         8y9xb7cM+M5kyfPNakGV/fm7o6sqOYxXYfFmgNO5mwWv9g144XJp9lrmIZdQkBw40cDY
         mfAxOJfnSXrWJazTZZhiuq3qwl0ZY/1M0kZVSjDTQDC32schC87rX0YED74bxxXGUJMo
         kACtBzXNvudsDOjuXBX6J9NKgDg2yW9nCACivssO+CfMHN0AYDrGI6Bv7BulOFpAJlri
         Pr8RUwO//oaWxT3x7t1oAlhRtvT7L5UnNbTCMEIcpbNCXklKhRaeNOjSWN+WIS0sLa4p
         Yrqw==
X-Forwarded-Encrypted: i=1; AJvYcCUgq+BBQ/4cVmJoZv7L9pJT7CTFENwVOGhQifNCkweebWK/KdaGY5zNV/QZEswdXPEuSbFLhbyru+phdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL6/JHRw5ReXdm3ef3cIjvCucQ4XJZfcpkcX89R111ZBsVPNzE
	QJpVpAACR0FJzFURUV7c/nMbX1nG8j+u1cAGPDX2LKaLaLIYLXldSPE6Fjjs4HsWRCQ=
X-Gm-Gg: ASbGncvBe7vF1nN5kMjLrc0cBnV9fpS9kQMXcVtmwyMouqUsP7yXL0YstK8tLkGhBaN
	uTEqhmKet6qFxA5ZYvO8vW1rVpedsZs5T3jcWvdDYRXYhp8oALvyNSM7ZrfH9ddJfvvpaW2XXPv
	JGr0pE0fcjWXil+jAo8M63ALz495rbPcCMKnLXw7X7X6zgOx74z+0qOsnGkZ7ceqBcST2jzgS5I
	0SjGLQeWePkn1Efc7L99+PA5jyQrpl9JI4GkKIREYVrYXdI/2wIxLejULvlnlgMG/kfKzVMhQKE
	o7CIlHZ0xW19uj0LFhjjGqL8FnVrhrKz5N4GZN+E204fD62BVN94QMGsfmz7Bqc5ecSjfDgCDrJ
	Ssysd3rOL6IS1Jg2wPeZzB9zfc2cCa+eFFDMgyNXEMx2Pumb8p5m6c0K2UjmCSAEKmBzip5T851
	fkiA==
X-Google-Smtp-Source: AGHT+IFN/MBsxerXBsiVpK7PLbTdCH32DKv4/Wk7nQ7A4KND7mhyW24/tDMvOFQ+7O4h43oz2BzQNg==
X-Received: by 2002:a05:6a00:84a:b0:7a9:c21a:5599 with SMTP id d2e1a72fcca58-7b225adc008mr16198605b3a.4.1762880528061;
        Tue, 11 Nov 2025 09:02:08 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc863a09sm15671106b3a.53.2025.11.11.09.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:02:07 -0800 (PST)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-block@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [QUESTION] Debugging some file data corruption
Date: Tue, 11 Nov 2025 09:01:42 -0800
Message-ID: <20251111170142.635908-1-calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

I'm looking for help debugging some corruption I recently encountered.
It happened on 6.17.0, and I'm trying to reproduce it on 6.18-rc. This
is not really actionable yet, I'm just looking for advice.

After copying about 10TB of data to a btrfs+luks+mdraid1 across two 18TB
drives, a btrfs scrub of the filesystem on a second machine threw about
ten checksum failures. The filesystem has never experienced a powerfail
or any unclean shutdown.

I ran an MD check, which showed some differences, so I wrote a trivial
userspace tool to log the differences (appended to the end of this
mail). It found 21 locations where the drives differed (39 LBAs).

The corruptions are clearly not valid ciphertext (non-random). Here's
an example of one mismatched LBA from both mirrors:

    /dev/sdb                                                              /dev/sda

    e3 df 31 cf de 9b 5b 07  b7 c2 c2 ae 1e 3d 78 06  |..1...[......=x.|  e3 df 31 cf de 9b 5b 07  b7 c2 c2 ae 1e 3d 78 06  |..1...[......=x.|
    82 fc fe 1b 79 04 f0 89  4a 8d c3 03 ad 28 7f de  |....y...J....(..|  82 fc fe 1b 79 04 f0 89  4a 8d c3 03 ad 28 7f de  |....y...J....(..|
    59 8b b4 65 d3 1d dd a5  b7 77 58 a9 d9 a3 44 9c  |Y..e.....wX...D.|  59 8b b4 65 d3 1d dd a5  b7 77 58 a9 d9 a3 44 9c  |Y..e.....wX...D.|
    81 a8 03 1e bd e9 3f bb  98 0d ee a4 cd 4c 67 44  |......?......LgD|  81 a8 03 1e bd e9 3f bb  98 0d ee a4 cd 4c 67 44  |......?......LgD|
    5c a5 55 21 c1 ec cc 23  94 08 61 db cd b1 46 20  |\.U!...#..a...F |  5c a5 55 21 c1 ec cc 23  94 08 61 db cd b1 46 20  |\.U!...#..a...F |
    01 18 77 7e d9 c5 d7 27  b0 ef 5f b7 6f b7 d1 ab  |..w~...'.._.o...|  01 18 77 7e d9 c5 d7 27  b0 ef 5f b7 6f b7 d1 ab  |..w~...'.._.o...|
    42 e5 36 f0 d1 9a 11 2c  22 1b a7 16 34 1d 22 a1  |B.6....,"...4.".|  42 e5 36 f0 d1 9a 11 2c  22 1b a7 16 34 1d 22 a1  |B.6....,"...4.".|
    4b 26 62 c3 d0 fa 02 ef  c3 7b 59 a5 4d 29 c0 62  |K&b......{Y.M).b|  4b 26 62 c3 d0 fa 02 ef  c3 7b 59 a5 4d 29 c0 62  |K&b......{Y.M).b|
    aa 32 9e e2 0f b8 6d 2c  f2 4b 56 87 5f 70 cc 26  |.2....m,.KV._p.&|  aa 32 9e e2 0f b8 6d 2c  f2 4b 56 87 5f 70 cc 26  |.2....m,.KV._p.&|
    ae a2 18 a4 25 74 a6 88  98 07 26 75 10 a4 33 ae  |....%t....&u..3.|  ae a2 18 a4 25 74 a6 88  98 07 26 75 10 a4 33 ae  |....%t....&u..3.|
    9b 01 d9 b7 19 d7 5c b1  1d d6 a0 fe 63 0e b8 c5  |......\.....c...|  9b 01 d9 b7 19 d7 5c b1  1d d6 a0 fe 63 0e b8 c5  |......\.....c...|
    00 20 0f 78 80 0b 24 9c  09 c0 0f 2f d7 87 3a 8c  |. .x..$..../..:.|  00 20 0f 78 80 0b 24 9c  09 c0 0f 2f d7 87 3a 8c  |. .x..$..../..:.|
    2d c4 1e 21 c8 45 02 95  33 37 06 50 b0 7f 1c 36  |-..!.E..37.P...6|  2d c4 1e 21 c8 45 02 95  33 37 06 50 b0 7f 1c 36  |-..!.E..37.P...6|
    8e 65 8c a9 e1 11 2b 7b  4f 9b 8b bd c3 3b 97 d9  |.e....+{O....;..|  9f 46 1d 21 c8 45 16 2d  c9 1c 19 fc d8 b6 db ed  |.F.!.E.-........|
    69 0d 76 80 a4 60 c8 51  20 12 67 d8 b6 f5 fa 77  |i.v..`.Q .g....w|  c7 9b 18 21 c8 45 ea aa  20 3e e9 94 a0 8a e9 2c  |...!.E.. >.....,|
    09 2c 1a 16 73 a6 ea 48  c7 6e 39 5a e5 6d c4 34  |.,..s..H.n9Z.m.4|  f0 db 11 21 c8 45 41 29  a2 e2 32 4b c7 ae cb a5  |...!.EA)..2K....|
    ac 2e 12 3b d4 cc cc 7b  9d d7 6c 2c fa 19 9d b3  |...;...{..l,....|  8d 39 12 21 c8 45 78 47  4e 97 0c 46 43 ec 7a ba  |.9.!.ExGN..FC.z.|
    58 26 ab fb 01 32 d7 f8  fb ba c5 84 f4 fe 01 47  |X&...2.........G|  8a 55 16 21 c8 45 48 ad  28 32 9c 3c f3 17 eb a1  |.U.!.EH.(2.<....|
    92 b8 c9 40 d9 77 53 59  f8 3e 3f 41 49 03 4a c1  |...@.wSY.>?AI.J.|  ca cd 16 21 c8 45 ff 6b  c9 19 91 4c d4 0b 85 b2  |...!.E.k...L....|
    43 9a 7e 42 6b da a1 9e  7d de 03 f9 4c 61 ed a3  |C.~Bk...}...La..|  dd 1c 1d 21 c8 45 9d 54  f4 6c 0c cb e2 6c e5 ad  |...!.E.T.l...l..|
    7a 8f 54 f7 13 8f 7c ac  c2 db e0 ef c8 4c 80 80  |z.T...|......L..|  08 f7 19 21 c8 45 7e 49  90 47 7e 8d 1d 49 22 8c  |...!.E~I.G~..I".|
    cd f2 32 10 88 78 23 9f  d7 eb b3 da 98 77 3c 95  |..2..x#......w<.|  a5 8f 1e 21 c8 45 4c f9  b0 bc 74 6d 2e 80 7b 36  |...!.EL...tm..{6|
    fc 3b 8d 8f 46 82 cc 8c  cf f1 16 7d 01 59 d3 6e  |.;..F......}.Y.n|  18 0c 1b 21 c8 45 e3 51  09 5e a9 14 33 00 d9 30  |...!.E.Q.^..3..0|
    2d 8f 43 8a 12 e3 e7 26  8a 76 cc 28 89 4c 19 04  |-.C....&.v.(.L..|  70 51 13 21 c8 45 81 d9  54 45 89 e5 52 0d c2 ba  |pQ.!.E..TE..R...|
    d9 e1 a7 a5 a4 c9 ef 64  2b 6b 91 a3 b1 4a f8 98  |.......d+k...J..|  65 0c 18 21 c8 45 69 e0  a8 86 92 af 41 cf a0 40  |e..!.Ei.....A..@|
    69 18 c7 96 82 17 5b 57  34 75 84 c1 35 9e 38 d1  |i.....[W4u..5.8.|  7c 6d 10 21 c8 45 46 04  00 00 00 00 00 00 00 00  ||m.!.EF.........|
    93 87 c2 c7 28 3b 9d 48  f4 8d 14 17 cb b7 09 90  |....(;.H........|  19 5f 12 21 c8 45 b4 0c  27 37 cf 44 81 29 c7 8a  |._.!.E..'7.D.)..|
    c0 3c 04 ac e0 44 b2 1e  8a 77 7e 19 85 8f ff 6c  |.<...D...w~....l|  3d 17 1b 21 c8 45 50 d7  00 00 00 00 00 00 00 00  |=..!.EP.........|
    ca 7f 3a 5c d3 52 cb b3  cf a8 89 66 a0 a1 16 ef  |..:\.R.....f....|  87 e7 10 21 c8 45 eb 5c  0a 70 b0 de bf be 1d 5f  |...!.E.\.p....._|
    a4 87 d8 1d 57 c4 73 11  4d d8 0a cf a9 d2 43 08  |....W.s.M.....C.|  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    15 2d 4e c8 b2 d7 3b 55  30 59 a1 6e ff 36 83 33  |.-N...;U0Y.n.6.3|  0a f5 10 21 c8 45 d2 3e  00 00 00 00 00 00 00 00  |...!.E.>........|
    82 2b 4f 55 64 ec 5b 34  90 a6 7d 83 b1 af 44 75  |.+OUd.[4..}...Du|  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

The obvious "streak" of repeated bytes on a 16-byte stride followed by
chunks of zeros is very consistent across my 21 corrupt samples. The
streak always repeats a piece of the real data ("21 c8 45" above).

I uploaded all 21 samples here:

    https://github.com/jcalvinowens/lkml-debug-mdraid-618

Does this pattern of corruption mean anything to anybody?

Next, I "split" the mdraid1, using read-only loopback devices with an
offset so they appear as individual btrfs filesystems, and ran an
offline btrfs scrub against each individually.

The first drive:

    calvinow@hackpi1 ~ $ sudo losetup -f /dev/sda -o 135266304
    calvinow@hackpi1 ~ $ sudo cryptsetup luksOpen -r /dev/loop0 sda_only_crypt -d keyfiles/f1ce8b7f-cd32-4ccd-baee-8443f60d9d1d.key
    calvinow@hackpi1 ~ $ sudo btrfs check --check-data-csum /dev/mapper/sda_only_crypt
    [1/8] checking log skipped (none written)
    [2/8] checking root items
    [3/8] checking extents
    [4/8] checking free space tree
    [5/8] checking fs roots
    [6/8] checking csums against data
    mirror 1 bytenr 1850055942144 csum 0x7e5e39be4c95c330acb06620b4ad5647d2092d76ad217296213c835ead479608 expected csum 0xc91d405eb407360748a8a3300a098575cdfb559d169b7b0114f1901a76bc0168
    mirror 1 bytenr 2878389952512 csum 0xe8d67f41f097a790465ba475736b517ec18ebf5d4379c85e681d7ec0a2de148c expected csum 0xfa775cf8e22f6c493c9e4a4b35152146c6af6730972413f57472a0b84eaf1b48
    mirror 1 bytenr 3128346521600 csum 0x9ec824a9e4ddcffdf1062f1ba62b9451969a99be14be202f2439453d7d3004d2 expected csum 0xf671fa7c9ff422d63e33ab2308b743f2efec75bc665f4b39d2b3528ed67b8dd2
    mirror 1 bytenr 4804343029760 csum 0x120b9da3ad94bae74b87dd5348bffe2a63abae51ec1967fe4940ef4d0e04f6b2 expected csum 0xcb35ff0f65d3c83d58c973349e95ddca941db192704d90f117f5748d60847871
    mirror 1 bytenr 4864481669120 csum 0xc47f3d34ad469b42a6c4ac53082711d7a54adfc639b8cae0eca68fa85c553d9e expected csum 0x408d55c9ddb82d687d22cfd88cd97b92e9ada7eeafbf1ffe5361d6c8d668979e
    mirror 1 bytenr 5960080613376 csum 0x01b4b8ed8aeb58e10a817df137ecd7897d71c55e13a1e4b26057ad04545ec25f expected csum 0x2ab1dac1d5f588f945ef21c0e1cbaec6e80f0c1e70b7869b6d60ec10bf0904ad
    mirror 1 bytenr 5961402257408 csum 0xb0286e4ffb2dc14544aa9cbfc93b673f0bedabe2bf8897ea55ab56b360cdb2fd expected csum 0x94296eb48c729bc769b30249fd6f9a495e5bcd7ee53f5b9fa804e8e29b61a1a0
    mirror 1 bytenr 6542744866816 csum 0xa94702d753843de35c7c36aa421d577fc3ee266dcecf667ab889038e3816d9cf expected csum 0xa0f23e680a34bee49f92b93018f691a17c2a333b654969304e6f5fd7451efdf3
    mirror 1 bytenr 8062253760512 csum 0xba3a46a1c1b0305eeeea50576d45d42bc4c2df78dc4298ed8a0430f4ffe02b29 expected csum 0x7e0b0bc4e506d453b69fdd195575f5caafa33833fc690f790594eb9070737e92
    ERROR: errors found in csum tree
    [7/8] checking root refs
    [8/8] checking quota groups skipped (not enabled on this FS)
    Opening filesystem to check...
    Checking filesystem on /dev/mapper/sda_only_crypt
    UUID: 3bd1727b-c8ae-4876-96b2-9318c1f9556f
    found 8215070863360 bytes used, error(s) found
    total csum bytes: 63585280608
    total tree bytes: 76154945536
    total fs tree bytes: 379305984
    total extent tree bytes: 496074752
    btree space waste bytes: 11008701324
    file data blocks allocated: 8138915917824
     referenced 8335585824768

The second drive:

    calvinow@hackpi1 ~ $ sudo losetup -f /dev/sdb -o 135266304
    calvinow@hackpi1 ~ $ sudo cryptsetup luksOpen -r /dev/loop1 sdb_only_crypt -d keyfiles/f1ce8b7f-cd32-4ccd-baee-8443f60d9d1d.key
    calvinow@hackpi1 ~ $ sudo btrfs check --check-data-csum /dev/mapper/sdb_only_crypt
    [1/8] checking log skipped (none written)
    [2/8] checking root items
    [3/8] checking extents
    [4/8] checking free space tree
    [5/8] checking fs roots
    [6/8] checking csums against data
    mirror 1 bytenr 360507215872 csum 0xd73bd43f8bbe02623cb49d8c2d22098e9f8f7d1e168a4a3ce09afd6afb3fb7b7 expected csum 0xffd5b2ab2e2a988d1fd8161a770533e3fa12ce42a22a608b33da0e354423bcf2
    mirror 1 bytenr 948478869504 csum 0x7013cafbcede6444418ed6bc6dde69a074d95f54ada5c8f397d5a5a7c7401308 expected csum 0x9707f1e1d21f901608c7406928fb0ac4e4329ee84f0cd927711de1933088bfb9
    mirror 1 bytenr 1335329157120 csum 0x53b36149b0b1404e6033ccee7da2f78a771a216226570b153ec842f75579c01b expected csum 0x8c073e81cd73acbed85e10371bffd684b65480104c97484dd8c35dcd1d7292a4
    mirror 1 bytenr 3342155005952 csum 0xae6b7410b5b3525164b37162d62f0686ed69670dd0e636118520b750f4f90c98 expected csum 0x6813929e1c2858de05525d9a9d60b1a609a9c127ec0fbea386db872da06f911a
    mirror 1 bytenr 3394104115200 csum 0x0bbfe4d49e2831a3534ca5e2731d0913f7fb5a0742bfb584280b6e2ab140f79e expected csum 0xbb404a2115d4db21bca0376ec6a2b147438dd5dc12d2ce77657ffce3a341c791
    mirror 1 bytenr 3540474392576 csum 0xafdfb82fc21d4e9ee86f8f4eeeb80f72e821abc7efc16ec0d1543a8fe766f810 expected csum 0x6d431ad6c9a78ab9b1b4523135bf1f92d196cb3784c0012e82277fde1284f6bb
    mirror 1 bytenr 3764206202880 csum 0xd634900646ca8b656e0e461152abe4d56fcf266e66deaa7995723cdbaad1c3f6 expected csum 0x4bc0bb748c93d6764c4477e759fb0fff987398df31124e407a96ad88c1c08f12
    mirror 1 bytenr 5795747512320 csum 0x29ded608e1e53a33a018173cb1b9653ac1f5ae4c58b2728abcd4147dae1e9038 expected csum 0xdf19cadbca20a6b70673a78a18715e950ab9ff8dce9b5263b4a53106ae64c540
    mirror 1 bytenr 6096793878528 csum 0x73a9cf95307e303118f5a46c4150159b22be9300dd853987d44f162bd6ce3106 expected csum 0x1f8cb156b55dbdbf24ff126b182506f42987d59d470847cee0866a59a52d44c3
    mirror 1 bytenr 6684691709952 csum 0x809afb12bca20c21e167cb90d890144f74ac7860996348e78e8d4e8fe67a5815 expected csum 0xc67c8b6ced8d2e7ae7b3897b1ac7432bbec0c2566f759652ab0892095bca6689
    mirror 1 bytenr 7101833793536 csum 0xcaae7fa28faab629bb5826550cc94ed504bf3e8146c451d284b887405b649dde expected csum 0xa2ba3334fd5b18557139577fb0875a6ba142588654dead275407976ab8b6d80c
    mirror 1 bytenr 8067768504320 csum 0xafac926d7032c1f36efe0b0b4473e1eb1f165271a7ac913564c4b3824815f885 expected csum 0x8e2b6e08d78b7f0e60352091c7b4e329d7c1756806dcdbc7b66d3544499615dc
    ERROR: errors found in csum tree
    [7/8] checking root refs
    [8/8] checking quota groups skipped (not enabled on this FS)
    Opening filesystem to check...
    Checking filesystem on /dev/mapper/sdb_only_crypt
    UUID: 3bd1727b-c8ae-4876-96b2-9318c1f9556f
    found 8215070863360 bytes used, error(s) found
    total csum bytes: 63585280608
    total tree bytes: 76154945536
    total fs tree bytes: 379305984
    total extent tree bytes: 496074752
    btree space waste bytes: 11008701324
    file data blocks allocated: 8138915917824
     referenced 8335585824768

The full btrfs inspect-internal dump-tree output is about 160GB of text,
and was exactly identical from both mirrors.

Because the drives are encrypted, the real data are statistically
random, so I was able to use compression to test which blocks were
corrupt. I wrote all the "less" corrupt instances of each of the 21
blocks to drive B, and all the "more" corrupt instances to drive A,
using this python script:

    import bz2
    import os
    
    with open("combined-corrupt-lba-list.txt", "r") as f:
        lbas = [int(x.rstrip()) for x in f.readlines()]
    
    fd_sda = os.open("/dev/sda", os.O_RDWR | os.O_EXCL)
    fd_sdb = os.open("/dev/sdb", os.O_RDWR | os.O_EXCL)
    
    for lba in lbas:
        f1 = f"lba-{lba}.sda.bin"
        with open(f1, "rb") as f:
            d1 = f.read()
        l1 = len(bz2.compress(d1))
    
        f2 = f"lba-{lba}.sdb.bin"
        with open(f2, "rb") as f:
            d2 = f.read()
        l2 = len(bz2.compress(d2))
    
        if l1 < l2:
            print(f"sda bad, sdb good: {lba}")
            os.pwrite(fd_sda, d1, lba * 512)
            os.pwrite(fd_sdb, d2, lba * 512)
        elif l2 < l1:
            print(f"sda good, sdb bad: {lba}")
            os.pwrite(fd_sda, d2, lba * 512)
            os.pwrite(fd_sdb, d1, lba * 512)
        else:
            raise RuntimeError(f"can't tell: {lba}")

This was the output:

    sda good, sdb bad: 693943242
    sda good, sdb bad: 1850713991
    sda good, sdb bad: 2610475259
    sda bad, sdb good: 3630481074
    sda bad, sdb good: 5657885844
    sda bad, sdb good: 6146082269
    sda good, sdb bad: 6563676964
    sda good, sdb bad: 6677722982
    sda good, sdb bad: 6963602424
    sda good, sdb bad: 7400578618
    sda bad, sdb good: 9446775924
    sda bad, sdb good: 9564234206
    sda good, sdb bad: 11389404262
    sda bad, sdb good: 11712464500
    sda bad, sdb good: 11715045836
    sda good, sdb bad: 11979482596
    sda bad, sdb good: 12863063528
    sda good, sdb bad: 13140303458
    sda good, sdb bad: 13955034090
    sda bad, sdb good: 15845534402
    sda good, sdb bad: 15856305388

Then, I re-ran the offline scrubs: drive A now shows all the errors
originally seen across both drives, and drive B is now clean.

Finally, I ran userspace checksums of the full set of files on the
newly clean drive B: they perfectly match an older copy in my backups.

This proves that:

    1) RAID mismatches and btrfs checksum failures are strictly 1:1.
    2) For every RAID mismatch, strictly one mirror was corrupted.
    3) No slient corruption occurred, btrfs caught everything.

The hard drives are brand new, so that is my current suspicion. I've
used the same two-drive USB enclosure extensively with older HDDs and
never seen a problem. I'm running this FIO job to test them:

    [global]
    numjobs=1
    loops=20
    ioengine=io_uring
    rw=randrw
    percentage_random=5%
    rwmixwrite=95
    iodepth=32
    direct=1
    size=5%
    blocksize_range=1k-32m
    sync=none
    refill_buffers=1
    random_distribution=random
    random_generator=tausworthe64
    verify=xxhash
    verify_fatal=1
    verify_dump=1
    do_verify=1
    verify_async=$ncpus
    
    [hdd-sdb-test]
    filename=/dev/sdb
    
    [hdd-sdc-test]
    filename=/dev/sdc

...but no luck hitting anything after about 18 hours.

Unless anybody else has a better idea, my plan is to "work my way up"
the storage stack with FIO verify jobs like the above. Any advice would
be greatly appreciated :)

Thanks,
Calvin

--

#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <err.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <string.h>

int main(int argc, char **argv)
{
	int fd1, fd2, m_ret = EXIT_SUCCESS;
	size_t lba = 0;

	if (argc < 3)
		errx(1, "Usage: ./test <drv1> <drv2>");

	fd1 = open(argv[1], O_RDONLY);
	if (fd1 == -1)
		err(1, "Can't open %s", argv[1]);

	fd2 = open(argv[2], O_RDONLY);
	if (fd2 == -1)
		err(1, "Can't open %s", argv[2]);

	while (1) {
		int ret1, ret2;
		char buf1[512];
		char buf2[512];

		ret1 = read(fd1, buf1, 512);
		if (ret1 == -1)
			err(2, "Bad read from input #1");

		ret2 = read(fd2, buf2, 512);
		if (ret2 == -1)
			err(2, "Bad read from input #2");

		if (ret1 != ret2)
			err(3, "Files differ in length at lba %lu (%d/%d)",
			    lba, ret1, ret2);

		if (ret1 == 0)
			break;

		if (ret1 != 512)
			err(4, "Short read!?");

		if (memcmp(buf1, buf2, 512)) {
			unsigned i;
			FILE *out;

			m_ret = EXIT_FAILURE;
			printf("LBA %lu differs:\n", lba);
			for (i = 0; i < 512; i++)
				buf1[i] ^= buf2[i];

			out = popen("hexdump -C", "w");
			if (!out)
				err(5, "Unable to dump XOR of blocks");

			fflush(stdout);
			fwrite(buf1, 1, 512, out);
			pclose(out);
		}

		lba++;
	}

	close(fd2);
	close(fd1);
	return m_ret;
}


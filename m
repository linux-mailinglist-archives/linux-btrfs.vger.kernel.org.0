Return-Path: <linux-btrfs+bounces-17227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45258BA55C0
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Sep 2025 00:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2273871A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 22:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EFB288538;
	Fri, 26 Sep 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNZMIQH/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AF1D6AA
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926573; cv=none; b=MGVXvc4R3zeS2PjEf79hUF6eppBQkzZ3mPNtlEu8OTd3ssusXOKA1hff/cY8wJCMqabb5CJMSC++Qti7Xvws0lnFbSFOMlMcjfusiZOuwiwmdY7U/Pj13jzOtpd8XW+fsDQvVR4rxgMLHhuktOhWajdTcKZNWuX1n2uB/W7bvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926573; c=relaxed/simple;
	bh=GDgWbtEP+HnkVCLMVMfu1DugQuCqEz5OKf5F2r0+WbI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HRXEMCvkI+QCq0uZgsEf3FQwXLJbqL/x2laWShfg6wBk/qvvpSsEoEngcyVhcHvnPpFz4JnUzgUNDXxGN3Vi8/VeGuo48Vv49Ftu/I4ZIzL1SqT1lnyB69lhkPfpz4yEAv+6OMtMiBvsfmEzC/Ek3kF4t8XxTJo2ZZ8Geby+JGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNZMIQH/; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74526ca79c2so1301788a34.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926570; x=1759531370; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRGZJpKYG/2yYmnV1mMrnGVLa8RFa1eE7Rth7G4g8MI=;
        b=LNZMIQH/gLF5BCBTFOerAQIZgIfm8jwRl7gz8jMw5ohJOPDaAsUuvJRQ7lUmZATGxI
         fzFhbrAWXdTjz01nE7xH6zUCVy8At3E2SIfXy+s8XvZWktcvCEe6kci3pAYZqE+wZTwW
         swzcrbz0ibeH8qs3MTX8vO3leFJ3w8/odj0VT8FpSEJLOtw+ztRmqfzlj2lEHtITVDit
         XeTzTJFp/yL6nvSwX3BdA9ykGR8lD0N5DHOv/haz/DCWLNlanJS7Ruz5v6kDfxU46h8k
         d3J+5Wf+JN+Mqz5QILJHHGP41MODfLcpqPEJxp1nl9ykdZuYAV0z4w24rCUDP7Fcfqok
         uCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926570; x=1759531370;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRGZJpKYG/2yYmnV1mMrnGVLa8RFa1eE7Rth7G4g8MI=;
        b=Q/n6CHQe88w1jkaKScbR746mc02olzXfLPu2F5qzWPTCqImVonO0WUr0hYnUpKTJWX
         Z5sxp24jjC5imnjCLEG69HwYXztrm7nf+BcIZDeCo7uCQKEn18q2yH8cTamMECST/CpF
         fVZS+/JLzOSFwV43MpxOa4CzyrcrL/qqeWrX8KXvCUvLIirYdhVFk5vWfg+PMP08vURj
         2NQOGbBPSlqkgFuoqsudMzS1Z30gCoBfYtHIWrDJLSXkAM3F2bB9ZkzUIKI+702zB4qh
         r77Ra7RP/aozSjmd1EA5KlJxKYCGE2jJOoRaiX65XS6COOnxUg0yiKB88dw6Ax15fL8G
         pBNA==
X-Gm-Message-State: AOJu0YzojaBubWRryjLKhbFPSSDdSWKFbTA2Wb0eMwBYUDenkVpoUNsf
	tUS/dktvO9xbYRn5jTQLL9BhDrkOvPa6YsKoq8qvTAfyTKq9RDqcAWuvJQLa33RxsMZ6erSQUpy
	yqyHYZweclXLHOmqGmU6GLQXgWKjNm4UeGypdSozCAuUi
X-Gm-Gg: ASbGncsctgoXRJNP9OCY4ERs1F2z8GCTB4+aN2OMGbcCdQ++JlhHTq/E6tJQLJ5lJa/
	o/Yh2uiUDm9vzNtRXPMiB7FIpyUAurohTcAGLePptOcsWuMHkrGdDBq0JxJijpafHqgv4avorwj
	AtuRVz2/Rmz9QunUJZJKYIR8tgMzs6GNu33uU8KNntjDNDPHajZ3HjU9wtXPl9VcM4iudlwHhvr
	nXWnw==
X-Google-Smtp-Source: AGHT+IHgbXcN45FHypJMlnHqGt6Xmms5OndFcCtE+KPUhlhre4HSTFOkS2GzqEe+hGo5G+gm6+SyMWZRAzmY/wxOJb8=
X-Received: by 2002:a05:6830:3816:b0:782:4423:223a with SMTP id
 46e09a7af769-7a043e6552emr4824333a34.22.1758926570018; Fri, 26 Sep 2025
 15:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 27 Sep 2025 03:42:38 +0500
X-Gm-Features: AS18NWCmk9SpMfSFLbL7bs_84cmzGnBOGFDH5kaMm3zLaWSJLxUVZQXWMpjHL48
Message-ID: <CABXGCsOug_bxVZ5CN1EM0sd9U4JAz=Jf5EB2TQe8gs9=KZvWEA@mail.gmail.com>
Subject: [BUG] btrfs-progs 6.16.1: `btrfs rescue chunk-recover` fails with
 "Couldn't read tree root" on a healthy filesystem
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I accidentally ran `btrfs rescue chunk-recover` on a healthy Btrfs filesystem
and noticed that it fails in an unexpected way.

System:
- Fedora 44
- btrfs-progs-6.16.1-1.fc44.x86_64
- Linux 6.17.0-0.rc7.250924gcec1e6e5d1ab3.58.fc44.x86_64+debug
- Single-device FS on /dev/nvme1n1p1

Filesystem mounts and works normally. No issues in daily use.

However, when I run:

    # btrfs rescue chunk-recover /dev/nvme1n1p1

it ends with:

    Couldn't read tree root
    open with broken chunk error

and prints a long sequence of "corrupt leaf" / "unexpected item end" messages.

Full output is below for clarity:
# btrfs rescue chunk-recover /dev/nvme1n1p1
Scanning: DONE in dev0
corrupt leaf: root=1 block=13924671995904 slot=0, unexpected item end,
have 16283 expect 0
leaf 13924671995904 items 11 free space 12709 generation 1589644 owner ROOT_TREE
leaf 13924671995904 flags 0x1(WRITTEN) backref revision 1
fs uuid 95e074d1-833a-4d5e-bc62-66897be15556
chunk uuid deabd921-0650-4625-9707-e363129fb9c1
item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
generation 1589644 root_dirid 0 bytenr 13924660658176 byte_limit 0
bytes_used 736526336
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 2 generation_v2 1589644
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439
generation 1588108 root_dirid 0 bytenr 19868776087552 byte_limit 0
bytes_used 1474560
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 1 generation_v2 1588108
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 2 key (FS_TREE INODE_REF 6) itemoff 15388 itemsize 17
index 0 namelen 7 name: default
item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize 439
generation 1589644 root_dirid 256 bytenr 13924670046208 byte_limit 0
bytes_used 5382389760
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 3 generation_v2 1589644
uuid ed6fc36e-c846-4fa7-8985-0ad8d02b3d81
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 1589644 otransid 0 stransid 0 rtransid 0
ctime 1758883901.662733695 (2025-09-26 10:51:41)
otime 1687097304.0 (2023-06-18 14:08:24)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 4 key (ROOT_TREE_DIR INODE_ITEM 0) itemoff 14789 itemsize 160
generation 3 transid 0 size 0 nbytes 16384
block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
sequence 0 flags 0x0(none)
atime 1687097304.0 (2023-06-18 14:08:24)
ctime 1687097304.0 (2023-06-18 14:08:24)
mtime 1687097304.0 (2023-06-18 14:08:24)
otime 1687097304.0 (2023-06-18 14:08:24)
item 5 key (ROOT_TREE_DIR INODE_REF 6) itemoff 14777 itemsize 12
index 0 namelen 2 name: ..
item 6 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 14740 itemsize 37
location key (FS_TREE ROOT_ITEM 18446744073709551615) type DIR
transid 0 data_len 0 name_len 7
name: default
item 7 key (CSUM_TREE ROOT_ITEM 0) itemoff 14301 itemsize 439
generation 1589644 root_dirid 0 bytenr 13924661035008 byte_limit 0
bytes_used 18805227520
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 3 generation_v2 1589644
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 8 key (UUID_TREE ROOT_ITEM 0) itemoff 13862 itemsize 439
generation 5 root_dirid 0 bytenr 30539776 byte_limit 0 bytes_used 16384
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 0 generation_v2 5
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 9 key (FREE_SPACE_TREE ROOT_ITEM 0) itemoff 13423 itemsize 439
generation 1589644 root_dirid 0 bytenr 13924660756480 byte_limit 0
bytes_used 14368768
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 2 generation_v2 1589644
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 10 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 12984 itemsize 439
generation 5 root_dirid 256 bytenr 30523392 byte_limit 0 bytes_used 16384
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 0 generation_v2 5
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
corrupt leaf: root=1 block=13924671995904 slot=0, unexpected item end,
have 16283 expect 0
leaf 13924671995904 items 11 free space 12709 generation 1589644 owner ROOT_TREE
leaf 13924671995904 flags 0x1(WRITTEN) backref revision 1
fs uuid 95e074d1-833a-4d5e-bc62-66897be15556
chunk uuid deabd921-0650-4625-9707-e363129fb9c1
item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
generation 1589644 root_dirid 0 bytenr 13924660658176 byte_limit 0
bytes_used 736526336
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 2 generation_v2 1589644
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439
generation 1588108 root_dirid 0 bytenr 19868776087552 byte_limit 0
bytes_used 1474560
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 1 generation_v2 1588108
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 2 key (FS_TREE INODE_REF 6) itemoff 15388 itemsize 17
index 0 namelen 7 name: default
item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize 439
generation 1589644 root_dirid 256 bytenr 13924670046208 byte_limit 0
bytes_used 5382389760
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 3 generation_v2 1589644
uuid ed6fc36e-c846-4fa7-8985-0ad8d02b3d81
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 1589644 otransid 0 stransid 0 rtransid 0
ctime 1758883901.662733695 (2025-09-26 10:51:41)
otime 1687097304.0 (2023-06-18 14:08:24)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 4 key (ROOT_TREE_DIR INODE_ITEM 0) itemoff 14789 itemsize 160
generation 3 transid 0 size 0 nbytes 16384
block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
sequence 0 flags 0x0(none)
atime 1687097304.0 (2023-06-18 14:08:24)
ctime 1687097304.0 (2023-06-18 14:08:24)
mtime 1687097304.0 (2023-06-18 14:08:24)
otime 1687097304.0 (2023-06-18 14:08:24)
item 5 key (ROOT_TREE_DIR INODE_REF 6) itemoff 14777 itemsize 12
index 0 namelen 2 name: ..
item 6 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 14740 itemsize 37
location key (FS_TREE ROOT_ITEM 18446744073709551615) type DIR
transid 0 data_len 0 name_len 7
name: default
item 7 key (CSUM_TREE ROOT_ITEM 0) itemoff 14301 itemsize 439
generation 1589644 root_dirid 0 bytenr 13924661035008 byte_limit 0
bytes_used 18805227520
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 3 generation_v2 1589644
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 8 key (UUID_TREE ROOT_ITEM 0) itemoff 13862 itemsize 439
generation 5 root_dirid 0 bytenr 30539776 byte_limit 0 bytes_used 16384
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 0 generation_v2 5
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 9 key (FREE_SPACE_TREE ROOT_ITEM 0) itemoff 13423 itemsize 439
generation 1589644 root_dirid 0 bytenr 13924660756480 byte_limit 0
bytes_used 14368768
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 2 generation_v2 1589644
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
item 10 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 12984 itemsize 439
generation 5 root_dirid 256 bytenr 30523392 byte_limit 0 bytes_used 16384
last_snapshot 0 flags 0x0(none) refs 1
drop_progress key (0 UNKNOWN.0 0) drop_level 0
level 0 generation_v2 5
uuid 00000000-0000-0000-0000-000000000000
parent_uuid 00000000-0000-0000-0000-000000000000
received_uuid 00000000-0000-0000-0000-000000000000
ctransid 0 otransid 0 stransid 0 rtransid 0
ctime 0.0 (1970-01-01 00:00:00)
otime 0.0 (1970-01-01 00:00:00)
stime 0.0 (1970-01-01 00:00:00)
rtime 0.0 (1970-01-01 00:00:00)
Couldn't read tree root
open with broken chunk error

This looks misleading and confusing because:
- The FS is clean and mountable.
- User expectation: if the FS is healthy, `chunk-recover` should
either do nothing
  and exit cleanly, or print "nothing to do", not fail with scary
corruption messages.

Questions:
- Is this a known limitation of `chunk-recover`?
- Should the tool detect the healthy state and skip gracefully instead
of failing?

-- 
Best Regards,
Mike Gavrilov.


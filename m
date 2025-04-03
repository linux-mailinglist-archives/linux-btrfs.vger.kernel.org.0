Return-Path: <linux-btrfs+bounces-12782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA10A7B20B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 00:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05591894FB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 22:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD81A5B82;
	Thu,  3 Apr 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iesmariamoliner-com.20230601.gappssmtp.com header.i=@iesmariamoliner-com.20230601.gappssmtp.com header.b="Pz/K0/HC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC92E62BE
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Apr 2025 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743719457; cv=none; b=JWoWl6yrYTt5dotl+7FTwwC7h1lX1/NcNG6r6E/EmMVvzxB6sDyiFCNi7U2miBZF8ApiiOSBHTXbugQAJLhpEJ8g4bkh+YoDQ0mBTbjAVE/C+ETEKoX6pe2MsBfdUpW8UzJnAx/KF5aK6tSL8YfnbiowMDOykSJ69cpB3glTsVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743719457; c=relaxed/simple;
	bh=kMH0ngLcpTJ1LFkOjTA49kC7UZbeeKrkVNnXwktqkj0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=buW34NDV16i1MMYQZcyx+QsKS/WK0kkpcGXFV7fCV6/UyEg+a+bxUDrG6YTw5zj+er7JwqHelbFX7lnKIEWIELgCik3922AYPMFBFXDWy44MvRGjG7sAACsFP9W2KByqKvy+3oi1L7sSuFFBLCrkzRMG+cln8TKacP4w2GcTgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesmariamoliner.com; spf=none smtp.mailfrom=iesmariamoliner.com; dkim=pass (2048-bit key) header.d=iesmariamoliner-com.20230601.gappssmtp.com header.i=@iesmariamoliner-com.20230601.gappssmtp.com header.b=Pz/K0/HC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesmariamoliner.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iesmariamoliner.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a823036so13359125e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Apr 2025 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesmariamoliner-com.20230601.gappssmtp.com; s=20230601; t=1743719452; x=1744324252; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtBmsT+ITpoz2XDc0zZkTnGLpJI2/srSkJNA9pqb5Vw=;
        b=Pz/K0/HCwZKeCOhXgGk4aD+sbwKAYDsx+/m0i/U7jUvqyZCyXwGQb1HoK+xHergA1t
         +xBak1KFdviTxaBefdrmzLMZ6qF6blKJb0vdB345RBhWuTQv+ztMiDzwrKq3pM0pQzmT
         ao+td0h5luwld+AOY65UlgDjg4ETmz20H9r1QWXq0AF8JUIzVDMSFIVa4HVtOwzK5YW4
         KAqaZVDWzpmYbi3D1/YqHr0c7niLxnzqqAvncOECiVjAX83CTlvVx6PL/xF7B3c/IFuu
         yj4ftEiu6oMgKZFBZ71+KPYwhZ4L2xFTJDoGyuYTN+/5j0+Ka5VVunhHe0rrO/BVUl2I
         2h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743719452; x=1744324252;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtBmsT+ITpoz2XDc0zZkTnGLpJI2/srSkJNA9pqb5Vw=;
        b=itiXVF1K11RP4Y04l5zZHjV3euxI3P+J8RPCvT71jdZtYKFaY5qTIhvB5okONJkt0t
         pjCaWp+J+H4JDpjTYquB9WjOkCbdfuHOwEKhrCjQmGJvJ8AhALAOgE/EUTshKBcNf9u9
         S2rWC+J3xDIx0QLPctVlc4q/zfJuKWpglILciIVl8R+xRu4uils6f3DEOz/xVwkkBv+5
         ZDE9kv9mZbQknH/JO7js9qtxpjyAqkW8FFHL2edcXZecY/qk4cO040CgZF5mQWGwc7CM
         WdMnSs5TR2JLrJGl1Q35OmaDll7RC7MlIqJzTffc9cNp8XgaJg0YtEXLwGv/dW/Q/HHe
         NFZQ==
X-Gm-Message-State: AOJu0YxkG6wzIGrn2mm9l5esqo7q0sX8LLhXPLDcXPFEa1Tz9enHskH2
	NreMi0mKur+uXFWRqhKAKEavi2zL26TBW7V7beGBiectNITiIFSOtvymt0L+DDWvrrSzgZWgFB4
	4+BAAnGi145NXGW5f4d8xTJLJU9qLuR7kvbGddeDvha/BJVKJ0g4DLg==
X-Gm-Gg: ASbGncuHdARhPgaePtfqUjkUImW1kZ80DRHGt7Pl4iSDZQWCCrtSqZscmrq9myAFwCX
	q6bbJVnQ4Cfpi2BprDtsGhhI55bwoHG5pmds3grzZ3ioKLr3df0rk0JeOMgtBuHTUmAkCiZ4LCd
	bxBR7riFGQYb12K6kdCjMUEck=
X-Google-Smtp-Source: AGHT+IFGn5rtzzVkUIMucTEZMRs3C6MX3sIzf2gWvFfHuzjBmLye1PA2Fxf5EitM048XJz/cn0GY3Tf2S9cPx//1vzI=
X-Received: by 2002:a05:600c:34c3:b0:43e:b027:479a with SMTP id
 5b1f17b1804b1-43ecf8eb71emr7805215e9.16.1743719452625; Thu, 03 Apr 2025
 15:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: fperal@elemariamoliner.com
From: =?UTF-8?Q?Fernando_Peral_P=C3=A9rez?= <fperal@iesmariamoliner.com>
Date: Fri, 4 Apr 2025 00:30:40 +0200
X-Gm-Features: ATxdqUFHZOPQVQn4kv8xs3oZywWl-VkcKX2HavWggLL2tZ_GS4bpSCl3_uf15I4
Message-ID: <CA+n7ozwhzdWs=KaBQh2miNwPwYxqBi+MEb807kddGNUZAOyNEA@mail.gmail.com>
Subject: A lot of errors in btrfscheck. Can fix it?
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Opensuse leap 15.6 with btrfs in /dev/nvme0n1p1

one day fs remounts RO.  I reboot the system and all works and i
forgot about it.  Then some days after it happen again... and again,
and once each 1-2 days.

I boot with last opensuse tumbleweed rescue system and run
btrfs check /dev/nvme0n1p1  > btrfserrors.log 2>&1
file size is 7MB (72000+ lines)
This is an extract
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
parent transid verify failed on 49450893312 wanted 349472898974925 found 820429
parent transid verify failed on 49450893312 wanted 349472898974925 found 820429
Ignoring transid failure
[4/8] checking free space cache
[5/8] checking fs roots
parent transid verify failed on 49450893312 wanted 349472898974925 found 820429
Ignoring transid failure
Wrong generation of child node/leaf, wanted: 820429, have: 349472898974925
root 257 inode 1166865 errors 2000, link count wrong
    unresolved ref dir 1170056 index 2 namelen 67 name
ec7bf949b9cad15eef70da5f245585a86d2536f7a2d49d7a3ced9350602846.file
filetype 1 errors 0
    unresolved ref dir 7725226 index 1199 namelen 43 name
io.github.hermitdemschoenenleben.linien.png filetype 0 errors 3, no
dir item, no dir index
root 257 inode 1166870 errors 2000, link count wrong
    unresolved ref dir 1170058 index 2 namelen 67 name
0e92b47654522ed38b741cdcc185a0133b4d65e5faddacfb10e6f2b902207d.file
filetype 1 errors 0
    unresolved ref dir 7725225 index 250 namelen 31 name
com.github.Johnn3y.Forklift.png filetype 0 errors 3, no dir item, no
dir index
root 257 inode 1166892 errors 2000, link count wrong
.....................................
root 257 inode 7939338 errors 2001, no inode item, link count wrong
    unresolved ref dir 4041 index 394716 namelen 7 name cookies
filetype 1 errors 4, no inode ref
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p1
UUID: 5b000355-3a1a-49f5-8005-f10668008aa7
found 870830170112 bytes used, error(s) found
total csum bytes: 820812476
total tree bytes: 4743823360
total fs tree bytes: 3497558016
total extent tree bytes: 250986496
btree space waste bytes: 815189067
file data blocks allocated: 2167978672128
 referenced 927826583552



I run memtest, no errors

I make a copy of the whole disk dd if=/dev/nvme0n1p1 of=/dev/sdd  bs=4M
I mount the /dev/nvme0n1p1 in /mnt and subvolume @/home  in /mnt/home
and make a full copy of home with tar without any error
I then unmount /mnt/home and mount ALL other subvolume /mnt/var,
/mnt/root, /mnt/srv, etc.
I then copy it to a disk with rsync:

rsync -aAX /mnt/ /backup/
it reports some errors, but not a lot

[root@sysrescue ~]# rsync -aAX /mnt/ /backup/
rsync: [sender] read errors mapping
"/mnt/opt/microchip/mplabx/v5.50/packs/Microchip/PIC32MZ-EF_DFP/1.3.58/include/proc/p32mz2048efh064.h":
Input/output error (5)
rsync: [sender] read errors mapping
"/mnt/opt/microchip/mplabx/v5.50/packs/Microchip/PIC32MZ-EF_DFP/1.3.58/include/proc/p32mz2048efh064.h":
Input/output error (5)
ERROR: opt/microchip/mplabx/v5.50/packs/Microchip/PIC32MZ-EF_DFP/1.3.58/include/proc/p32mz2048efh064.h
failed verification -- update discarded.
rsync: [sender] readlink_stat("/mnt/var/lib/alternatives/mount.ntfs")
failed: Input/output error (5)
rsync: [sender]
readlink_stat("/mnt/var/lib/snapd/assertions/asserts-v0/account/dNg0tVCIPlftwxSamh1bJuJlbeF4414o")
failed: Structure needs cleaning (117)
rsync: [sender]
readlink_stat("/mnt/var/lib/snapd/assertions/asserts-v0/snap-declaration/16/Lf1MF6tizzusVuA6l13ETyH5VDXxwA0D/active")
failed: Structure needs cleaning (117)
rsync: [sender]
readlink_stat("/mnt/var/lib/snapd/assertions/asserts-v0/snap-revision/oQEyGl1uWD-Tctr0xuXX24wViUD-V_0tCFa_dACaoDuhxeAjar-l7SlwZaALO3Ld")
failed: Input/output error (5)
rsync: [sender]
readlink_stat("/mnt/var/lib/snapd/assertions/asserts-v0/snap-revision/eJvirrJxorOL8M-jSZUg3HD7KCHGtcXw3IP6AyJ_fjqQ00dcsr-GsGuhxlxXcipT")
failed: Input/output error (5)
rsync: [sender]
readlink_stat("/mnt/var/lib/snapd/assertions/asserts-v0/snap-revision/SuT7J1UFhL0alAb5kruCjalw_pvlskVQGfJ6aVT7wkOH7TGtFNfMSo3SDBL86HVl")
failed: Structure needs cleaning (117)
rsync: [sender]
readlink_stat("/mnt/var/lib/snapd/assertions/asserts-v0/snap-revision/uMr0AjQBhdqMO35XzAEYGdQ_OaR2FJfA3Vv68p3H_pEiMHQ_uBWB4K-dUBKlDy3U")
failed: Structure needs cleaning (117)
rsync: [sender] readlink_stat("/mnt/var/log/messages-20240625.xz")
failed: Input/output error (5)
rsync: [sender] readlink_stat("/mnt/var/log/messages-20240709.xz")
failed: Structure needs cleaning (117)
rsync: [sender] readlink_stat("/mnt/var/spool/cups/c00624") failed:
Input/output error (5)
rsync: [sender] readlink_stat("/mnt/var/spool/cups/c00625") failed:
Structure needs cleaning (117)
rsync: [sender] readlink_stat("/mnt/var/spool/cups/c00626") failed:
Structure needs cleaning (117)
rsync: [sender] readlink_stat("/mnt/var/spool/cups/c00627") failed:
Structure needs cleaning (117)
rsync error: some files/attrs were not transferred (see previous
errors) (code 23) at main.c(1330) [sender=v3.2.3]




My questions

Can the fs be fixed?
Can the copies I have done be reliables?

Thanks in advance.


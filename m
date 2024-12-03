Return-Path: <linux-btrfs+bounces-10022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F199E1665
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 09:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09FF0B33B6B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A601B0F14;
	Tue,  3 Dec 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvOpmRbT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24C18A921
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213497; cv=none; b=JcjKzhA9GGTRZNAhgGw81tgu+QlpKqItGz4oFScBagKqfWHLObl0b9bQLZbM9aRAHehxIAROsrvWHVZAaug1tDDmIhQBgzo8cOSFydEAkDFtqHtkeoaQYSdIWgUSZ+q/DB31w/hVii2egekYFUKUTAQFthUsx4cSdE9L1MOgC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213497; c=relaxed/simple;
	bh=Vd9AxSETAUjTwKx582/W+XiCTfJrtHEeKkWhk3nxFi4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=t2q3XsMSWG1Sbfdx788NkMjNwuM/26oyiChdeg9vlCfwa9Jqag1pZLv5c/fIbwO9j5AXi+6eDZ72CkyIz9W4ueCNBqV0r2O88VjuI38cappxgM5/OLiqDCaiU/MtyYDAhLOsEai4/AL+pz9IV2IAIeoBtZ9hVSk0nW/ZkgX2tNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvOpmRbT; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f1d2487b95so2009204eaf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2024 00:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733213495; x=1733818295; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7VwvdQcMlQVgO8rXDWqIJbkWL+K4W2vE8nWTChBsQec=;
        b=RvOpmRbTdKiMGeo/dKrTqodXYfg4gWGdTEYLA4vhIeFFBzoDvULODXrPuFGsiNVe6T
         IA92XIgfuawsHXzI0wBb8hG0dunc1TBRjpBEZMOlsceWNxYw0+eEpgWXmVb/Tuzh8G9M
         Vv98K2bC5Vj0EjLLRKbXh6Y6BYp2dkCDfx+W5a4TX54dkWKh6vdjLE7zCAD42/WaTyXl
         btEKTnP9Cf8nc8uPKtT2C9jX8ebfXpHumrdQ/HKL/ZOtcr41Ooq2Io3RHBcxSklzxp6H
         M14ePdaDv+3NccnYVMVqD5v83V647bwwlLLqDQbRNuCLeAyGTrh5VNG7Fl2k6wd6/xqo
         F+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733213495; x=1733818295;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VwvdQcMlQVgO8rXDWqIJbkWL+K4W2vE8nWTChBsQec=;
        b=vYAhnO5dx+vyR12Ev/pPYpU2A5ARbV66OoTkDdAm15jI0FGGkat60+43fyyCMYU5b1
         fNo0z9iGR2R8gNA7AtmVRdM4NE0PSj7HeZl3Wv8AoUnB8nAqOzSVlvVaj5dN1uSQgn6e
         Pen9/VIuDTe4baTNfUX1omtwkcK6Lx4cLWfvdp4oAGeSOezaweYN1RY0tN3vTS8sJLg1
         A/Zwc5RQkRsfX7GE4FYYIch3+NpL8erym78VY3gNTIsTy/s7zyIhVTTbq3TOAqjTho+K
         QOhuIgYwM3e80fuDKdbnvwSiBLHdJHlF/14ucn1lNvzU2+Geyw1hs8i3TXQaJz6vv5nL
         2A8w==
X-Gm-Message-State: AOJu0YzXQo4Hxl3OPZNEobwUI659xU66w66wdMZ/pfwV3KuUvNKHUYwX
	juk7HE725hjGRdrBEcKMuNfzq8ehKAkEKy+0x+iVMxEEGHcQjz8W/VH3fxMd5bAhT3nyw5qYbfQ
	iYT9P1oZrujnf9A87fjJAoutVP7BsBtYvzZQ=
X-Gm-Gg: ASbGncsW8rtSpBRKEryS0XJ5oA1FQOMeD96HaIEoVMFVwIQs615WmEPO9ZuO8Caz+P2
	13RxOs3iVTaSqix/9Yg/ZsthsxHw2EJ5rYm0FTfO1FSvA8fcm43oqctTiwYmkcuLQJA==
X-Google-Smtp-Source: AGHT+IFAc1PdtUXH2+0fBZaN3s7d1NirOFfYF85QnaixRjR72KTWHOmIwxhxXIbtxEtkEYfCf/K8HTZd3VwZNC/IZ0Y=
X-Received: by 2002:a05:6820:220b:b0:5e1:ba69:1646 with SMTP id
 006d021491bc7-5f25ae30d2emr1513051eaf.4.1733213494909; Tue, 03 Dec 2024
 00:11:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Neil Parton <njparton@gmail.com>
Date: Tue, 3 Dec 2024 08:11:23 +0000
Message-ID: <CAAYHqBbMeLYXdhNondp8JwQCsp-n1cCvnAubS3f2FxD6PBOEsQ@mail.gmail.com>
Subject: Balance failed with tree block error
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Arch Linux kernel 6.6.63-1-lts, btrfs-progs 6.12-1

Yesterday I added a 5th drive to an existing raid 1 array (raid1c3
metadata) and overnight it failed after a few percent complete.  btrfs
stats are all zero and there are no SMART errors on any of the 5
drives.

dmesg shows the following:

$ sudo dmesg | grep btrfs
[16181.905236] WARNING: CPU: 0 PID: 23336 at
fs/btrfs/relocation.c:3286 add_data_references+0x4f8/0x550 [btrfs]
[16181.905347]  spi_intel xhci_pci_renesas drm_display_helper video
cec wmi btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel
xor raid6_pq
[16181.905354] CPU: 0 PID: 23336 Comm: btrfs Tainted: G     U
   6.6.63-1-lts #1 1935f30fe99b63e43ea69e5a59d364f11de63a00
[16181.905358] RIP: 0010:add_data_references+0x4f8/0x550 [btrfs]
[16181.905431]  ? add_data_references+0x4f8/0x550 [btrfs
4407e530e6d61f5f220d43222ab0d6fd9f22e635]
[16181.905488]  ? add_data_references+0x4f8/0x550 [btrfs
4407e530e6d61f5f220d43222ab0d6fd9f22e635]
[16181.905551]  ? add_data_references+0x4f8/0x550 [btrfs
4407e530e6d61f5f220d43222ab0d6fd9f22e635]
[16181.905601]  ? add_data_references+0x4f8/0x550 [btrfs
4407e530e6d61f5f220d43222ab0d6fd9f22e635]
[16181.905654]  relocate_block_group+0x336/0x500 [btrfs
4407e530e6d61f5f220d43222ab0d6fd9f22e635]
[16181.905705]  btrfs_relocate_block_group+0x27c/0x440 [btrfs
4407e530e6d61f5f220d43222ab0d6fd9f22e635]
[16181.905755]  btrfs_relocate_chunk+0x3f/0x170 [btrfs
4407e530e6d61f5f220d43222ab0d6fd9f22e635]
[16181.905811]  btrfs_balance+0x942/0x1340 [btrfs
4407e530e6d61f5f220d43222ab0d6fd9f22e635]
[16181.905866]  btrfs_ioctl+0x2388/0x2640 [btrfs
4407e530e6d61f5f220d43222ab0d6fd9f22e635]

and

$ sudo dmesg | grep BTRFS
<deleted lots of repetitive lines for brevity>
[16162.080878] BTRFS info (device sdd): relocating block group
338737521229824 flags data|raid1
[16175.051355] BTRFS info (device sdd): found 5 extents, stage: move
data extents
[16180.023748] BTRFS info (device sdd): found 5 extents, stage: update
data pointers
[16181.904523] BTRFS info (device sdd): leaf 328610877177856 gen
12982316 total ptrs 206 free space 627 owner 2
[16181.905206] BTRFS error (device sdd): tree block extent item
(332886134538240) is not found in extent tree
[16183.091659] BTRFS info (device sdd): balance: ended with status: -22

What course of action should I take so that the balance completes next time?

Many thanks

Neil


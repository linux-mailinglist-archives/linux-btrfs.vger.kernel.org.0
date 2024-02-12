Return-Path: <linux-btrfs+bounces-2312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE3850D03
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 04:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DDA288284
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 03:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D68A4411;
	Mon, 12 Feb 2024 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2hxDHRf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE511841
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707707747; cv=none; b=uf3+n1dWPgLfEIht8MCWo/c68CQ9jidFblBjhIDFUTw59MqE3TvhI1BHodoG69XJcg/LEVrF0a0MRc2okpTXOswyRD1OMVk99dD6+QncIoweDS93JhjJ3rY0I+PDlyjphX47FEeasUGuCfzSkniqFKUXqEf0VjhisWd781jxKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707707747; c=relaxed/simple;
	bh=M+tnyu1vdpD+7aK407E9EJgUBRRsGqqam4ADQIGSRqE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ANxHmv0pIPNXk287QB/W7ESXcVd4cA2KN+Bp9NaUPrPzIB+hHuBzFBGIUz/3/M5cYUHrhJQEwc6E9V6+vc5f0/hzjE5mbHad2x5A37E5KqodnlbuzsrPneNXMTV1hS0vwjYhZ/NMm52S4IX+YUSle5V/8ZhwD/lATALUcrEK07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2hxDHRf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0c9967fdcso37462591fa.0
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Feb 2024 19:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707707743; x=1708312543; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kMLPqjk8rPH9j00F/U7ClhJLRjk0pmjMNXb7sB3AHy4=;
        b=P2hxDHRfjtRMVnEGMaWmavhxlK5oVGJ0l5s2kW0u59rlGdyWGggMLBSHGDmqXkhx6X
         kO6Jz/JLIMyibnDhgY7Kxd7o4ELdq8v2pvozeEG/fz8/RvCVwsBXWeFbMuh/i4uK2b65
         x5mCBZ46IyevMKiFkuOqpFLGlksTGgccQFDy1KVtZFTdWtKokJHXmGBxX0OQXrY0UiTA
         ocp7wUca7/sG+dGa3lZVUjqbJki9Qpec1TO2dDi/LxVLIc5V+6airQnGa87M0Nw1YTTv
         et+dP3MVylxIhr6GcG+6X48MfsIeJOH4dwPtVTuj1yCk9z9taQJC3igepMUKbELy1/bC
         /hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707707743; x=1708312543;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMLPqjk8rPH9j00F/U7ClhJLRjk0pmjMNXb7sB3AHy4=;
        b=uq1g7CoMh7NahDX42+6/+56FivLrdYtEHa8t+5o/JU/VY+S7b7UoZoQc44d4I/0PSb
         Gu1De4+uchKGfLzjTKMNJYgIrEWlf0N9Z9AMxiyBqL1Aq/jw366dhbSKUcvM2MzaaMth
         ETAV2RUIh7uZVgRxbbhzwngH8kao9eypKblINQIerV0IQAOoEuT/RPyXC7L2vlrj6D4Q
         m9jHwt6aoyNudyOw87VPqCXTk9gf+qoWv0Z2gAdeWHy3yt5K+DORJn6em31mFe8UrC2l
         jFRu6HwANI/snXYGyUtGW9tSUgqMgCNiz4rXX7nT3ViL451Qqv464sHLBF1S1MK0F5Bj
         zPTw==
X-Gm-Message-State: AOJu0YwM9j6DQzG7aqWXjVpHw5UATjfw7THVpOr2hp7It5mngF+WNGHA
	ZcSC7xXvJA1VcbJFMH0NVt+JY0GqJf+kbe/1D9Cp6lTkSFf3BleC2fEjaVtMbiCripKYYdcEReP
	9KvURw5Pbw9wNPhzW8L4a/qwysXPVOdljucs=
X-Google-Smtp-Source: AGHT+IEFHu+IrMdnwwsSmiDzeJ6PMiGXQpZVl14T7CRzGN1k3Hid+MO8RB/S94eHYmAg/p0tGwBNz2hY+FyRIgv5NfE=
X-Received: by 2002:a2e:b2cf:0:b0:2d0:e4ef:f1ec with SMTP id
 15-20020a2eb2cf000000b002d0e4eff1ecmr1745615ljz.18.1707707743419; Sun, 11 Feb
 2024 19:15:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patrick Plenefisch <simonpatp@gmail.com>
Date: Sun, 11 Feb 2024 22:15:33 -0500
Message-ID: <CAOCpoWd1jzP6Y=nOpz_LHHSNnqGg8O=itW-OcQb6D2x7vRUfSw@mail.gmail.com>
Subject: error while submitting device barriers: BTRFS read-only on newer kernels
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is a very weird error I'm getting. I have a system that I'm
migrating from Debian 11 (5.10 kernel) to Debian 12 (6.1 kernel). As a
part of this process, I'm dual booting both systems, with a LVM pool
that contains three relevant LV's with three BTRFS partitions. Two of
these BTRFS partitions (single) are working just fine. The other one
(also single) only works on 5.10 kernels. Whenever I boot it on 6.1
kernels, I can mount it just fine until I (presumably) read a file and
trigger an `atime` write. Then the BTRFS partition is locked ro until
a reboot with this in dmesg:

BTRFS info (device dm-75): first mount of filesystem
00d78dac-3576-435d-b575-61c3d951ff66
BTRFS info (device dm-75): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device dm-75): disk space caching is enabled
BTRFS info: devid 1 device path /dev/mapper/lvm-brokenDisk changed to
/dev/dm-75 scanned by (udev-worker) (11442)
BTRFS info: devid 1 device path /dev/dm-75 changed to
/dev/mapper/lvm-brokenDisk scanned by (udev-worker) (11442)
BTRFS error (device dm-75): bdev /dev/mapper/lvm-brokenDisk errs: wr
0, rd 0, flush 1, corrupt 0, gen 0
BTRFS warning (device dm-75): chunk 13631488 missing 1 devices, max
tolerance is 0 for writable mount
BTRFS: error (device dm-75) in write_all_supers:4379: errno=-5 IO
failure (errors while submitting device barriers.)
BTRFS info (device dm-75: state E): forced readonly
BTRFS warning (device dm-75: state E): Skipping commit of aborted transaction.
BTRFS: error (device dm-75: state EA) in cleanup_transaction:1992:
errno=-5 IO failure

My thought was that maybe I created it with a new broken format, like
space_cache_=v2, but nope, all variants work in the other working
btrfs partitions on 6.1:

/dev/mapper/lvm-newWorking on /media/Foo type btrfs
(rw,noatime,ssd,discard=async,space_cache=v2,subvolid=258,subvol=/@foo)
/dev/mapper/lvm-oldWorking on /media/Bar type btrfs
(rw,nosuid,nodev,relatime,discard=async,space_cache,subvolid=5,subvol=/,uhelper=udisks2)
/dev/mapper/lvm-brokenDisk on /media/Grr type btrfs
(rw,nosuid,nodev,relatime,discard=async,space_cache,subvolid=5,subvol=/,uhelper=udisks2)

The only thing I can seem to find online is posts warning that you
should backup your data. But that clearly isn't the case here, because
none of the devices in the lvm pool are giving smart warnings or
reallocation counts. Further, reading is fine, I can read the whole
disk. Finally, I can just reboot back to the 5.10 kernel and it just
works again. 6.5bpo kernel also exhibits 6.1 behavior

What is going on here?


% uname -a
Linux pollux 6.5.0-0.deb12.4-amd64 #1 SMP PREEMPT_DYNAMIC Debian
6.5.10-1~bpo12+1 (2023-11-23) x86_64 GNU/Linux
% btrfs --version
btrfs-progs v6.2
% btrfs fi show /media/Grr
Label: 'BrokenDisk'  uuid: 00d78dac-3576-435d-b575-61c3d951ff66
        Total devices 1 FS bytes used 1.90TiB
        devid    1 size 2.00TiB used 1.92TiB path /dev/mapper/lvm-brokenDisk

% btrfs fi df /media/Grr
Data, single: total=1.91TiB, used=1.89TiB
System, DUP: total=8.00MiB, used=240.00KiB
Metadata, DUP: total=6.00GiB, used=4.88GiB
GlobalReserve, single: total=512.00MiB, used=16.00KiB

Patrick


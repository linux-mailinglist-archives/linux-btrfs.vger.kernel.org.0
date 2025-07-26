Return-Path: <linux-btrfs+bounces-15692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CEB12D21
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 01:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1229C541568
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 23:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B002224B09;
	Sat, 26 Jul 2025 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="KarqP9Im"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474962E36E1
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753574140; cv=none; b=r3xMAJgZ2i3lXL4NJS9JJDKXHwK0rQNJ3d4aD29BnyE8XsXwfoXF52FtK4lMhIFwjNzzDrGbZPjOSNgA4RP6qtwECnUgXM/MRIaLkmNajH2cjH1+PIml5uRwZ8OnLakPsYO7JBYn4Zv/L79tSTBzP/OR44S1Mxm1GRKCIXX5gok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753574140; c=relaxed/simple;
	bh=9ZxbUXLjoNB3i0e1GRXIUtA1pHqNGAj+9869gEMoQns=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U0VJiybz2BrA4lN+nrfMBR0UrMmfTbmjTkcZooVeYmJdOR4GUrAPOtW49Z4P6XEu7KRTZ3cdsjwkCtElrktQu6lOX0vSbA0AkdkkiXbJ4+3e4brSLfQa33NoDzwESw24sypHXHNtXfo1oBfIQllW6k2vcLp9DBREmAo83wRzfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=KarqP9Im; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id B7AA360CC5
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 01:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1753573675; x=
	1755312476; bh=9ZxbUXLjoNB3i0e1GRXIUtA1pHqNGAj+9869gEMoQns=; b=K
	arqP9Im4bd90T0xrBJgmgwF4kj84BQR/QzFKslFSePwDofNk1IaNe+kWyEyIwPCY
	qHgK9aI9ZPkvNf5jjwycH4GTsjP9KmJ2CpccF4uLQVQNk952ZJXtJciFwxJz+0kD
	taLpbxoTUdikZhXoVRlYoHYNlzG0ethMed7vHyI/NloTZkUQ6a7tTAT6E1ZOY957
	4IWTTotJpg6gLjketWOz+XoUeQruUO8bboanLpuDn1FxKqD7W75JvPjmsMv8XHj2
	vQWN7n5A1WNMr84WvRO4yioEitTjaLxxaXkVOQaSQ4POBzXEMpItyY/NJMlDRZtD
	v2Lg2n/3/G/lupDWbCxBA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id 5uJ4yB65GXJ5 for <linux-btrfs@vger.kernel.org>;
 Sun, 27 Jul 2025 01:47:55 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Sun, 27 Jul 2025 01:47:55 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: balance failed with checksum error
Message-ID: <20250726234755.GA842273@tik.uni-stuttgart.de>
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
X-Mailer: smtpsend-20240729


This is just a test VM, but this error should not happen?

root@mux22:~# btrfs balance start /
WARNING:

        Full balance without filters requested. This operation is very
        intense and takes potentially very long. It is recommended to
        use the balance filters to narrow down the scope of balance.
        Use 'btrfs balance start --full-balance' option to skip this
        warning. The operation will start in 10 seconds.
        Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting balance without any filters.
ERROR: error during balancing '/': Input/output error
There may be more info in syslog - try dmesg | tail

root@mux22:~# dmesg | tail
[22612.591075] BTRFS warning (device sda3): checksum error at logical 3450908672 mirror 1 root 806 inode 1509 offset 294912 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)
[22612.591095] BTRFS warning (device sda3): checksum error at logical 3450908672 mirror 1 root 805 inode 1509 offset 294912 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)
[22612.591115] BTRFS warning (device sda3): checksum error at logical 3450908672 mirror 1 root 257 inode 1509 offset 294912 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)
[22612.591184] BTRFS warning (device sda3): checksum error at logical 3450912768 mirror 1 root 810 inode 1509 offset 299008 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)
[22612.591204] BTRFS warning (device sda3): checksum error at logical 3450912768 mirror 1 root 809 inode 1509 offset 299008 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)
[22612.591224] BTRFS warning (device sda3): checksum error at logical 3450912768 mirror 1 root 808 inode 1509 offset 299008 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)
[22612.591244] BTRFS warning (device sda3): checksum error at logical 3450912768 mirror 1 root 807 inode 1509 offset 299008 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)
[22612.591264] BTRFS warning (device sda3): checksum error at logical 3450912768 mirror 1 root 806 inode 1509 offset 299008 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)
[22612.591283] BTRFS warning (device sda3): checksum error at logical 3450912768 mirror 1 root 805 inode 1509 offset 299008 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)
[22613.689939] BTRFS info (device sda3): balance: ended with status: -5

root@mux22:~# btrfs version
btrfs-progs v6.6.3

root@quak:~# sysinfo 
System:        Linux quak 6.8.0-64-generic x86_64
Distribution:  Linux Mint 22.1

root@mux22:~# df -TH /
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/sda3      btrfs   32G   17G   16G  52% /

root@mux22:~# mount | grep sda3
/dev/sda3 on / type btrfs (rw,relatime,space_cache=v2,subvolid=256,subvol=/@)

root@mux22:~# btrfs filesystem show /
Label: none  uuid: 13168cc9-1fde-4d4a-8af1-fc91da4f12db
        Total devices 1 FS bytes used 14.15GiB
        devid    1 size 29.76GiB used 17.06GiB path /dev/sda3

root@mux22:~# btrfs filesystem df /
Data, single: total=15.00GiB, used=13.39GiB
System, DUP: total=32.00MiB, used=16.00KiB
Metadata, DUP: total=1.00GiB, used=784.42MiB

root@mux22:~# btrfs filesystem usage /
Overall:
    Device size:                  29.76GiB
    Device allocated:             17.06GiB
    Device unallocated:           12.69GiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                         14.92GiB
    Free (estimated):             14.31GiB      (min: 7.96GiB)
    Free (statfs, df):            14.31GiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:               37.58MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:15.00GiB, Used:13.39GiB (89.24%)
   /dev/sda3      15.00GiB

Metadata,DUP: Size:1.00GiB, Used:784.42MiB (76.60%)
   /dev/sda3       2.00GiB

System,DUP: Size:32.00MiB, Used:16.00KiB (0.05%)
   /dev/sda3      64.00MiB

Unallocated:
   /dev/sda3      12.69GiB

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250726234755.GA842273@tik.uni-stuttgart.de>


Return-Path: <linux-btrfs+bounces-84-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EAA7E8FD1
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Nov 2023 13:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D401F20FBA
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Nov 2023 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1A38BE5;
	Sun, 12 Nov 2023 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="W2ndjYKc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A387136C
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Nov 2023 12:53:43 +0000 (UTC)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8407C2D62
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Nov 2023 04:53:42 -0800 (PST)
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SSstq3vkJz49PwQ
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Nov 2023 14:53:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1699793619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=rO80QT8bvDR/XyyBQvhUnW+mKW8oBMHiUbUy1wVaQuA=;
	b=W2ndjYKcr0cd9K/zDRQTdfQEnACk6+kB4MWJcOqS/KV+gYnBTuJlGOWQP/LSPZsBv9vT1l
	B/uWujrklRXGvjtRQErlI+Dew9Q5fxRPvhGw8GVKhUi7RvDVVrR1bLZJkhTadttW6Q9QZh
	/ulG1KQlrZNOm7DzDUuhImUsTsKA3QPegvjidTpMJJ28P+VGWqRpMLPsK+BsmHgCAZv/bU
	TVYBoVz71J09/OkOeAsml6Uv7ZCQXK8BE1uwkUi7On89B2RuQzq2AEmsSxhod+ShvvXUb1
	RNxZak9jU2G02qeavUfd2/vMYxh4FyMAXhgR1GPJeFMGnsDqRPtWWkYNI4XsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1699793619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=rO80QT8bvDR/XyyBQvhUnW+mKW8oBMHiUbUy1wVaQuA=;
	b=e4XPAioEtJYBweonyTAdI1Rbv1F/CSPIcVGK+27MZv60pWE7IzvzKoxdGakwLDMk7v89G6
	Vmndxi0fmReZGehB0iegRBEsllCWHOb/StAoGoL9QAgO9EsR7Yks6Zh0rsv4iXopuTCaGm
	+nSn5egfMtzEqemi9r5o92RD2C5z70wHkvKOEDRg2Dj3TtXm7WmCX0xM8XPA92XiSnP7C+
	63liBpbw4e+d4SCaYBuEafk571wOXm6TCRHETIwQG5Lr8mmM3Mw1/1zAt6fo3FzMIvMj5F
	WfMb1NBiRWk/6VeW/kqpCy5qIg5D+K17uFvcHLvziBUPOKGPqImdBqj+/d77rQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699793619; a=rsa-sha256;
	cv=none;
	b=IzGaObozK5AEVDvaARgGufRgEqF4yvnAwRLxlbAGB9fOGh1A+uMb7ewihn8xp/pmN7Wz/j
	79b1JY6Ecx2drtHPArJ4PEaLAh5l3mMQSEIOUSwxOhqjDHvEdQs5WEIJSjh5/575mjYHHP
	BRlk00FBTxi1OjMMG2L8u1fQzmXqwJBGvZ6erASXh3nRRCG6fh6oNkhTPaNusCJQuo0iSx
	8kGzIZEHOPICNZIw7AyTnz1YT9hhbOFUahXAxL0o75DV/aMKX8YVD/oZrvGuHK66YKjyzc
	PuTnT9M1vJPH8lOMsAi0Yjw3cYVGcQfJ5gD9fpw9PBThM/1uGRgjWUy099C0FA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <68c34ce662340cda393a0e41d0c3042fbcaabf6c.camel@iki.fi>
Subject: Operations on one BTRFS fs slow down another fs
From: Pauli Virtanen <pav@iki.fi>
To: linux-btrfs@vger.kernel.org
Date: Sun, 12 Nov 2023 14:53:35 +0200
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I'm seeing some BTRFS operations (subvolume delete, btrfs receive) on
one BTRFS filesystem slows down operations also on a different BTRFS
filesystem. The slowdown is big, small file operations can take 10+ min
to complete.

I have:

$ uname -a
Linux host 6.5.11-300.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Nov  8 22:37:5=
7 UTC 2023 x86_64 GNU/Linux

$ mount|grep -i btrfs
/dev/mapper/luks-xxxx on / type btrfs (rw,relatime,seclabel,compress=3Dzstd=
:3,ssd,discard=3Dasync,space_cache,subvolid=3D256,subvol=3D/root)
/dev/mapper/luks-xxxx on /mnt/btrfs_root/xxxx type btrfs (rw,relatime,secla=
bel,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache,subvolid=3D5,subvol=
=3D/)
/dev/mapper/luks-xxxx on /var/swap type btrfs (rw,relatime,seclabel,compres=
s=3Dzstd:3,ssd,discard=3Dasync,space_cache,subvolid=3D1047,subvol=3D/swap)
/dev/mapper/luks-xxxx on /home type btrfs (rw,relatime,seclabel,compress=3D=
zstd:3,ssd,discard=3Dasync,space_cache,subvolid=3D257,subvol=3D/home)
/dev/mapper/luks-yyyy on /mnt/btrfs_root/yyyy type btrfs (rw,relatime,secla=
bel,compress=3Dzstd:3,space_cache=3Dv2,subvolid=3D5,subvol=3D/)

Where "xxxx" and "yyyy" are BTRFS filesystems on different disks.=C2=A0They
are separate BTRFS filesystems. The filesystem "yyyy" is on a USB drive
(rotational).

# btrfs filesys df /
Data, single: total=3D1.47TiB, used=3D1.38TiB
System, RAID1: total=3D32.00MiB, used=3D224.00KiB
Metadata, RAID1: total=3D17.00GiB, used=3D9.75GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

# btrfs filesys df /mnt/btrfs_root/yyyy
Data, single: total=3D1.00TiB, used=3D1012.03GiB
System, DUP: total=3D32.00MiB, used=3D128.00KiB
Metadata, DUP: total=3D24.00GiB, used=3D21.32GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

I am doing:

btrfs subvolume delete --commit-each /mnt/btrfs_root/yyyy/btrbk_backup/root=
.20231015T0000

This takes a very long time. That itself is OK, but while working it
slows down operations also on the other "xxxx" filesystem. For example,
running in /,

dd if=3D/dev/urandom of=3Dfoo bs=3D100M count=3D1

hung for 16 minutes before completing. During this time the dd process
is in state D and

$ grep . /proc/`pgrep dd|tail -n1`/wchan
balance_dirty_pages

The `btrfs subvol` process wchan alternates between
wait_for_commit/worker_thread.

During this time vmstat bi/bo doesn't seem to indicate it's bounded by
disk I/O.

Any ideas if something can be done to improve performance for this
workload?

--=20
Pauli Virtanen


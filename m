Return-Path: <linux-btrfs+bounces-11140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE15A21ED0
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B416A5F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D919CD1D;
	Wed, 29 Jan 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gdixv8ut"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3583DF49
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159852; cv=none; b=fyfhg5CUI+dfaBfr4UXVEVxb81mzZfBR+MHH//wl93+kJQN4U9B6FNXuKpXgzwURKrnHTbcGZWKzCZgG19DdfetyvTAkjb5F4DGDnk0TFqBdnsQXN4T92V//30kFyG888umvqvkKu0JbAyojebZgr87FxVgEeU9ntlJa1XlulCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159852; c=relaxed/simple;
	bh=nk7HlaQ39w2smmz1MUilBses7fiRw4o6XdjYI/1VFSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=KGf+5ZuTInzq0VXYbboeFwfM4RZz/mLNITunHrFCORf1E8fu5xejS5P6sNM9DYBAWPPkSKj6hZYMHbWderRqpFRfTD3No8BGQP3RrLWQZpOv0eA9NbqN3dpQ46pjMSNXZ5gpxZI1Z4MwXrKjzpvFtVrpBPq7n5Q/8LOJRmqSBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gdixv8ut; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250129141042epoutp0156c0aa4d961af970d71461bb6e3dd328~fLyraFB8s0645706457epoutp01S
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 14:10:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250129141042epoutp0156c0aa4d961af970d71461bb6e3dd328~fLyraFB8s0645706457epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738159842;
	bh=n+G4o6rVeXBcVofvBNDuQajmyl0s0yopkCGKarmoKc8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=gdixv8ut6/gbBPbkTGzci46R3DiS1UZK9U0mbi8cuer6nnvSBPO5ZH398lJW4RzAt
	 j5kBZWIEqPNnJ/y8eOBdjK66k8D92a/MA+IGLYGAQY0PL/jO5pThYTDpeXWiOFNO5s
	 T2yNRDXFmY+vinxBUkS8mI6M2/O6BXf9rzQRWKMo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250129141041epcas5p1140553f7a28f18b989c6f4d243e44409~fLyrAG5RP1215112151epcas5p1i;
	Wed, 29 Jan 2025 14:10:41 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YjkZm4WKJz4x9Pp; Wed, 29 Jan
	2025 14:10:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.F3.20052.0E63A976; Wed, 29 Jan 2025 23:10:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250129141039epcas5p11feb1be4124c0db3c5223325924183a3~fLyovrPph1215112151epcas5p1h;
	Wed, 29 Jan 2025 14:10:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250129141039epsmtrp220454c49dfda7c403ca9ce986c1a76ec~fLyou6V4C1194111941epsmtrp2h;
	Wed, 29 Jan 2025 14:10:39 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-47-679a36e07115
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FC.0C.18729.FD63A976; Wed, 29 Jan 2025 23:10:39 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250129141037epsmtip2e52337325cc88a52855a4461e513471c~fLynIrUax2391023910epsmtip2U;
	Wed, 29 Jan 2025 14:10:37 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de
Cc: linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [RFC 0/3] Btrfs checksum offload
Date: Wed, 29 Jan 2025 19:32:04 +0530
Message-Id: <20250129140207.22718-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmpu4Ds1npBq+/KFisvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWR/+/BUoeusZosfeWtsWlxyvYLeYve8ruwO0xsfkdu8fl
	s6Uem1Z1snlsXlLvsftmA5tH35ZVjB7rt1xl8ZiweSOrx+dNcgGcUdk2GamJKalFCql5yfkp
	mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCnKimUJeaUAoUCEouLlfTtbIry
	S0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM86fOslWMFG6omkNewPj
	S9EuRk4OCQETiQXHr7N1MXJxCAnsZpQ4NeUVO0hCSOATo0Tbv1qIxDdGiaY5e9hgOhZePsIE
	kdjLKLHx339GCOczo8TVCWeAHA4ONgFNiQuTS0EaRAQyJI6fnsUMUsMsMJtRYl3rf2aQhDBQ
	zbqbsxhBbBYBVYmWDafBNvAKWEicvvacCWKbvMTMS9/ZIeKCEidnPmEBsZmB4s1bZ4MNlRBo
	5ZDoPveIBWSxhICLRNddZoheYYlXx7ewQ9hSEp/f7YX6IFviwaMHLBB2jcSOzX2sELa9RMOf
	G6wgY5iBblu/Sx9iFZ9E7+8nTBDTeSU62oQgqhUl7k16CtUpLvFwxhIo20PixYRjbJBAjJU4
	dPc48wRGuVlIHpiF5IFZCMsWMDKvYpRMLSjOTU8tNi0wzEsth8dkcn7uJkZwEtXy3MF498EH
	vUOMTByMhxglOJiVRHhjz81IF+JNSaysSi3Kjy8qzUktPsRoCgzVicxSosn5wDSeVxJvaGJp
	YGJmZmZiaWxmqCTO27yzJV1IID2xJDU7NbUgtQimj4mDU6qBaePCHVMDH57oir0ee+TW2il3
	LiTftDyU4e641tN33dc6seWFe5R/p/2QTappq9oVnuezmG+he+rG/5vPCJ36Uhp72GhB+46i
	61vnTbjTl60mxWnu17zzYq3V8bvW0y7NvZ+i6a75lVdmqcx3L2O5zB0hSQ2PXnBpPXryRtVU
	76EfM+vep92+m02ivi+//+62vZt6/ltmvUcHlipdiebdU3xw20MBlyLOj93nYuTPzJj5MPTe
	u7XrP71J27vxXoLXZw+5j7f+y8YemPPCWqgpZOWxFRvv8Di+Srp4osQlL+H7rY2LRO27E5hU
	W3eIPnscYeI9W/lba9fHKQtCmN81bUypfNJ1zf/xHqF1LRLhM0SVWIozEg21mIuKEwF+xQBT
	KwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvO59s1npBmeOCFmsvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWR/+/BUoeusZosfeWtsWlxyvYLeYve8ruwO0xsfkdu8fl
	s6Uem1Z1snlsXlLvsftmA5tH35ZVjB7rt1xl8ZiweSOrx+dNcgGcUVw2Kak5mWWpRfp2CVwZ
	50+dZCuYKF3RtIa9gfGlaBcjJ4eEgInEwstHmLoYuTiEBHYzSmw60cMMkRCXaL72gx3CFpZY
	+e85mC0k8JFR4vBdhy5GDg42AU2JC5NLQcIiAgUSE/c/YQGZwywwn1Hi+IZdLCAJYaCadTdn
	MYLYLAKqEi0bTrOB2LwCFhKnrz1ngpgvLzHz0nd2iLigxMmZT8B6mYHizVtnM09g5JuFJDUL
	SWoBI9MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgUNfS3MG4fdUHvUOMTByMhxgl
	OJiVRHhjz81IF+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp
	1cAUGh+ouHV2wX2WmGc7Ht7Ojp1qV21uz7Xh4f6+4vhpW5X+nXVuSzn/OZzB11XtZ+/bC4fW
	NE9MZG1mnHI+gvs2t8tLHv2OWHGDrj1i88zv25kc+vHf8WPDi4RZzkte/f3+9/g7M+vysDVr
	5Sc2PtWXZI1pcd/of/TSiplxGW4nmF5fcZi458Bp4y1rtH7M7pRc+//Zl43Bxxv+Ozl/i9dM
	kYl4HFIzh+/NwiUx5jtf+TYmaPPuPWX/d0/HhdWXfFJMj67aqbpHaP+XoMK+j9JiDVq75ou+
	7GyTOPTabse8ZdUm7Pf+z9neySEvWHWd71vi3F7f/q7zdd8LzWts0kvvt7ntn/RlyZ5j73oT
	c29WK7EUZyQaajEXFScCAJn67YfkAgAA
X-CMS-MailID: 20250129141039epcas5p11feb1be4124c0db3c5223325924183a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141039epcas5p11feb1be4124c0db3c5223325924183a3
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>

TL;DR first: this makes Btrfs chuck its checksum tree and leverage NVMe
SSD for data checksumming.

Now, the longer version for why/how.

End-to-end data protection (E2EDP)-capable drives require the transfer
of integrity metadata (PI).
This is currently handled by the block layer, without filesystem
involvement/awareness.
The block layer attaches the metadata buffer, generates the checksum
(and reftag) for write I/O, and verifies it during read I/O.

Btrfs has its own data and metadata checksumming, which is currently
disconnected from the above.
It maintains a separate on-device 'checksum tree' for data checksums,
while the block layer will also be checksumming each Btrfs I/O.

There is value in avoiding Copy-on-write (COW) checksum tree on
a device that can anyway store checksums inline (as part of PI).
This would eliminate extra checksum writes/reads, making I/O
more CPU-efficient.
Additionally, usable space would increase, and write
amplification, both in Btrfs and eventually at the device level, would
be reduced [*].

NVMe drives can also automatically insert and strip the PI/checksum
and provide a per-I/O control knob (the PRACT bit) for this.
Block layer currently makes no attempt to know/advertise this offload.

This patch series: (a) adds checksum offload awareness to the
block layer (patch #1),
(b) enables the NVMe driver to register and support the offload
(patch #2), and
(c) introduces an opt-in (datasum_offload mount option) in Btrfs to
apply checksum offload for data (patch #3).

[*] Here are some perf/write-amplification numbers from randwrite test [1]
on 3 configs (same device):
Config 1: No meta format (4K) + Btrfs (base)
Config 2: Meta format (4K + 8b) + Btrfs (base)
Config 3: Meta format (4K + 8b) + Btrfs (datasum_offload)

In config 1 and 2, Btrfs will operate with a checksum tree.
Only in config 2, block-layer will attach integrity buffer with each I/O and
do checksum/reftag verification.
Only in config 3, offload will take place and device will generate/verify
the checksum.

AppW: writes issued by app, 120G (4 Jobs, each writing 30G)
FsW: writes issued to device (from iostat)
ExtraW: extra writes compared to AppW

Direct I/O
---------------------------------------------------------
Config		IOPS(K)		FsW(G)		ExtraW(G)
1		144		186		66
2		141		181		61
3		172		129		9

Buffered I/O
---------------------------------------------------------
Config		IOPS(K)		FsW(G)		ExtraW(G)
1		82		255		135
2		80		181		132
3		100		199		79

Write amplification is generally high (and that's understandable given
B-trees) but not sure why buffered I/O shows that much.

[1] fio --name=btrfswrite --ioengine=io_uring --directory=/mnt --blocksize=4k --readwrite=randwrite --filesize=30G --numjobs=4 --iodepth=32 --randseed=0 --direct=1 -output=out --group_reporting


Kanchan Joshi (3):
  block: add integrity offload
  nvme: support integrity offload
  btrfs: add checksum offload

 block/bio-integrity.c     | 42 ++++++++++++++++++++++++++++++++++++++-
 block/t10-pi.c            |  7 +++++++
 drivers/nvme/host/core.c  | 24 ++++++++++++++++++++++
 drivers/nvme/host/nvme.h  |  1 +
 fs/btrfs/bio.c            | 12 +++++++++++
 fs/btrfs/fs.h             |  1 +
 fs/btrfs/super.c          |  9 +++++++++
 include/linux/blk_types.h |  3 +++
 include/linux/blkdev.h    |  7 +++++++
 9 files changed, 105 insertions(+), 1 deletion(-)

-- 
2.25.1



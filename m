Return-Path: <linux-btrfs+bounces-13442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34CA9D988
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 11:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3524A0604
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 09:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9292367A1;
	Sat, 26 Apr 2025 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="KpEbTjlK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCC7A13A
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745658313; cv=none; b=pEAYL4dID4nH6kbFkenCehNHZWSuikQAPMoSKV16qWzpYgGs8IYG222zee2dwQYGmOaQsmJe6y3UVhuUQtfDZvpo7/2sUj3YmNj/7EWKUDerPZ5j66Je5YHbGi6tPAGFcHqp5ys/5sBJ6keESr70kmJnLZYM+646Ihydo7U74+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745658313; c=relaxed/simple;
	bh=P66RQZA9kMWm5tzE4nHl81bWEZm66ERDlaZ2+EwW0YA=;
	h=Message-ID:Subject:From:To:Content-Type:Date:MIME-Version; b=VObvMFVtrIGb+rly1gV4KWrlaiJbRVf4GQoWVf+vNExt7KuTJU1iFQQYHNZs5oDQK+187mFs8WysaaWrnsoWUjHbCmVOr3e5y0lKO2XccltSY3SzumvIzn3brheVhcj5xe6M5Jlt2P34eTUDnbxN3KLJAscKoeL9Isbn/8Fph2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=KpEbTjlK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745658308; x=1746263108; i=massimo.b@gmx.net;
	bh=P66RQZA9kMWm5tzE4nHl81bWEZm66ERDlaZ2+EwW0YA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KpEbTjlKZCgSPJLDRaXsNGtaKvz2yCxcP16YaujzSmiV1TJhziru1As1wiBinfIw
	 h9WAyaygqh7cUih4H4uT/eJu59QkljgX/0IoJzKTzI+gJK1Zis0TAb+TDOHvAPOxF
	 Y6lWSrhh0s5LqzYjIKIegU7dPHUrX0lBgQp6xEYycV3ATLLPmMlN2h/QTsNJce/fU
	 YUDCX8a0RObCfeJ5weNTqXP9hBSmRSCT3Qe1xAkZmgEfthU4v8uBdYrNBZyWcsg5c
	 g2XJkiGCRsSIQY9aIFn5qwEiTZLa7Njk/Epybdmxx4/RQdF9lyrDdCXcYZVBgVsEA
	 V9JUQanw8ZIf1NtOAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gentoo ([95.112.121.96]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1ujLT82sJy-00deJJ; Sat, 26
 Apr 2025 11:05:08 +0200
Message-ID: <180daac980bec43d45d0e6fa4f9e1d14fb126de1.camel@gmx.net>
Subject: bad tree block start, how to repair
From: "Massimo B." <massimo.b@gmx.net>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Apr 2025 08:27:00 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.4 
X-Provags-ID: V03:K1:8Mxlv1+Hld2MkH5W4Q89suu8oB3y8av/7f+QGA9EOpjqq4AMYS0
 mTJHIGxbdOeZnwbzbW4A6NtruLbiuVsxwNU/lyHJNF5vUx4jqv8jR+9mZ50XUz2lITRr0Sb
 GeU76eKLc5vqovswNqIE0kyMdZCMgfsztrnAx8e03JhNW1KuQ0E1XGbK7im6BvND8LZNh0f
 kMgBP6Na1c4Nzb1s+uRlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m6rTOKi+kOo=;+i7cmB3c6VqtF2eAGtqQkKWp6ya
 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
 wuPxA9BEjZztVlLiy4SZC6IZUO4iV/A=

Hi,

I have a btrfs on LUKS on a NVMe disk inside USB enclosure.
I send all different snapshots from different machines to this btrfs via bt=
rbk and I'm doing a lot of bees.

Is there any chance to repair?

From syslog:

[kernel] [10370.573757] BTRFS error (device dm-1): bad tree block start, mi=
rror 1 want 2564600332288 have 4363494421962462810
[kernel] [10370.574024] BTRFS error (device dm-1): bad tree block start, mi=
rror 2 want 2564600332288 have 12261462772841064395
[kernel] [10370.597214] BTRFS error (device dm-1): bad tree block start, mi=
rror 1 want 2564600332288 have 4363494421962462810
[kernel] [10370.597390] BTRFS error (device dm-1): bad tree block start, mi=
rror 2 want 2564600332288 have 12261462772841064395
[kernel] [10379.866453] BTRFS error (device dm-1): bad tree block start, mi=
rror 1 want 2564600332288 have 4363494421962462810
[kernel] [10379.866632] BTRFS error (device dm-1): bad tree block start, mi=
rror 2 want 2564600332288 have 12261462772841064395
[kernel] [10379.866675] BTRFS error (device dm-1 state A): Transaction abor=
ted (error -5)
[kernel] [10379.866678] BTRFS: error (device dm-1 state A) in add_to_free_s=
pace_tree:1057: errno=3D-5 IO failure
[kernel] [10379.866680] BTRFS info (device dm-1 state EA): forced readonly
[kernel] [10379.866682] BTRFS: error (device dm-1 state EA) in do_free_exte=
nt_accounting:2994: errno=3D-5 IO failure
[kernel] [10379.866683] BTRFS error (device dm-1 state EA): failed to run d=
elayed ref for logical 2564165648384 num_bytes 16384 type 176 action 2 ref_=
mod 1: -5
[kernel] [10379.866686] BTRFS: error (device dm-1 state EA) in btrfs_run_de=
layed_refs:2215: errno=3D-5 IO failure
[kernel] [10379.866851] BTRFS info (device dm-1 state EA): last unmount of =
filesystem .....

# btrfs check /dev/mapper/mobiledata_crypt=20
Opening filesystem to check...
Checking filesystem on /dev/mapper/mobiledata_crypt
UUID: 8fefabb7-11a7-4e12-8ee6-dc8f1529f8e5
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab4624d
checksum verify failed on 2564600332288 wanted 0xc04b5087 found 0xc3757de0
checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab4624d
bad tree block 2564600332288, bytenr mismatch, want=3D2564600332288, have=
=3D4363494421962462810
owner ref check failed [2564600332288 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[4/8] checking free space tree
checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab4624d
checksum verify failed on 2564600332288 wanted 0xc04b5087 found 0xc3757de0
checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab4624d
bad tree block 2564600332288, bytenr mismatch, want=3D2564600332288, have=
=3D4363494421962462810
could not load free space tree: Input/output error
checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab4624d
checksum verify failed on 2564600332288 wanted 0xc04b5087 found 0xc3757de0
checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab4624d
bad tree block 2564600332288, bytenr mismatch, want=3D2564600332288, have=
=3D4363494421962462810
could not load free space tree: Input/output error
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 1978635726935 bytes used, error(s) found
total csum bytes: 1785865480
total tree bytes: 157852188672
total fs tree bytes: 136425439232
total extent tree bytes: 19102629888
btree space waste bytes: 29931988767
file data blocks allocated: 96097451388928
 referenced 29948246061056



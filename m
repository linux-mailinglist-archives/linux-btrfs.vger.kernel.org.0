Return-Path: <linux-btrfs+bounces-11267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD17A26D92
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED5C3A2343
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF0207640;
	Tue,  4 Feb 2025 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="YroPBt9I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88613D8A4
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658871; cv=none; b=KzOqeBwQDlVmqYS04l11BfXjdJU+nYvtEgTS2zUdksavy59M7dnSZ4C09RNZ1diJzPSqxq8WvHg+L/RgORUF1GgK4AR3Hbhcx6l2uz1AceBF7g0GDN1Z2TDslxfYZ2RpSd6Z1Hjp2dojfhxdN4NDNJqiQUdGaiu2pIsYkBpQUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658871; c=relaxed/simple;
	bh=4u0PFRk89WQWPBg6JipRPlFaaO85hcMi0fs3Mfv8B3Q=;
	h=Message-ID:Subject:From:To:Content-Type:Date:MIME-Version; b=Hr6DPaXSlkq+kdX6jNGP1CNH5aLF2ahd/hdQoKIF13o15bHq+up9URW/DamDcC7coVIHqHrPVuWgyUY1mSIxbZBvVaHVNdopgWxsPQQ/J2SzOmY4+inIa6bcgmj5icrhA358ndg9hvy6+xGjPbYPMaTtyAo6Prs1HxUJGIFM1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=YroPBt9I; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738658866; x=1739263666; i=massimo.b@gmx.net;
	bh=qxaAxk9EJx16PWpk4D5Yh7cf32RaXVE9D1hzZE7l3vg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YroPBt9I5JWqfkQnhy1DknF2h/pI2pK5QSiBs92YI+xCT5jaNgatdTEpHCKoBvkq
	 7Z78CRQIAhwytZIMPJUk2vERqtANc7G21UBwQwHPFP1++w5Uiwk7U2QTjnqzOlKyR
	 d4bSTxfRfQ1MsbYv3yMLd96+AE0ahuchLSyPdfZ2ntyATqiRG0vYOQopySvFZ+c02
	 jRFDpq6i4HdybJfCUErvJm7Zw3vga3O3Uf/9AA0L6kwrM7dZ8L82oqgf5l5kWzXaz
	 FUsaSakEGnbXyYFMImVXYDCW3PmQjssU8n4a+ytTd3WYI1e6exu2D9YEb6rrzLjtf
	 kpK46/yvs85uoLis2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gmb ([176.1.11.187]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1sz4LT0YH3-00lSsY; Tue, 04
 Feb 2025 09:47:46 +0100
Message-ID: <aff8355c64d68b4995cca0a132d35af527e160b3.camel@gmx.net>
Subject: Infinite --repair super bytes used mismatches actual used
From: "Massimo B." <massimo.b@gmx.net>
To: linux-btrfs@vger.kernel.org
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Feb 2025 09:42:44 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.4 
X-Provags-ID: V03:K1:tEmX7LYhJCWYl2qoWFQauzf6grkGgPXn3GL8szZK7HZfuczcTuN
 gQ2e8zjP+DPgOCp1lUt+GUJZxqqmMPJ+H3xSUpNcfKDmrF5t8MfrppQ2iDmk2+D+sy0sRFn
 SBxAwTKdmqsDf2hlYFe9+3xQOSQBkYK18+JgHnj79o/n7WRFYIeVRV9i9ILSf87ubmihh9s
 GapoSaPl531RLYP1Ne3AQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SzOrio+FGgc=;yR7Yl0sj0wJUrR28/ZBqHBBWwak
 0om/yjZMoKf/1fOC9QJChBaoJeelDypDInk8j8Be5BaCg69fV9JEpwgZS8vfGFhbJxiA0iyX0
 0s6Zyyji24it5jPAe+DSPQ26fvlAtAZDTbNXuK+8asWkAL4pNDixS3yoKUg1qxZt4ZRo6/EEX
 60ASe0fy3gX3JhTqEBRT2kRW5iX863zsVJ4IhldW2P1mufxZ+9NKL8X2gL7ViCLNaTcNzdiAe
 eOva924GXAt/B9lb/Fo1Hsdaw9EKeTEUvpB6qOKTcIbTDoYs124IlX1sTF5xEEg0UQwxqecVX
 MZQBftBs8vWcGvAaYP4eivGYthy1U89Ui13pqDf7QE9P7Tu+eXXt8rw9jtGajhH8PrR3u1Ncx
 Eu8QcaFJFHOE5d48/v30EubrtCl3iRKkVDTaKQp1N5J4MZ+p4hAiPHxEz3fIZpGGyzTYit949
 7SQ5a4TEOlmCyyLW5+m4kEXY0jd/eCHhnq3eF1GlSMVw+ryB4lG6DngnJoSvNAwRM/ehE5M7J
 xxtUZVhxGMusteR+1oj+H0niaoOlOaZXmlvOrm+WMMYmO433wKove3oAfS2bDX13mob/v21Gl
 4YQBU/e9A2Z91IKgBgzvEdqti5xISWndCYLUpAYI1J6QwOX/hK157NmFN9DDjxQon220VJZ+V
 //YowtCMJ/GvOiUqef31rYK2ft7579qyZNypgt4Ypr1x6eYvLRd2vPq7YIUYpBZlTRzN178TZ
 IxnFy6fFxKCo7chIfksM6a4qSoKR410PD82tsZKEfiW8q15rTpERVblPyd+2GNKSoNFg9LLLg
 AdT6S05N/toCuRwspSX8M5pAkhLXLwp+rOeeJxNCpbLNjnHbb9gEpunoJJHUYFT2Sku1/A5wK
 JgsLSRzlsqFfG+fKQVCis8DHGOLLv5YD3hkdVXnGsSB193N4woPvxgAIaAEc0EBoV6cNlw5yi
 NifKtjtnX4Q93IH/U/dM01BYFi5RfObMYNam+QFDPyieW9hmogzEvOg+drdsAqDg3DWhOD7ES
 7fnZf6Q6TU5C9OX19DGOZ/7rNohBymRB/WXJXCU5xF7AexmLrU5HrjzjoJAFBBEOicE88OnnS
 ffMFkKmuKAfSkMULavy9HRNeG0VW9Q/azoHsaG99Oa6/sL19ywDDIAQSwh2p9kSV2ZoLe8p2n
 gsp+Hb3bBPcpxksCfkZaFbvv5xSTrlOVmyFG+AkC4ETbrV/pU4ceZAvtC6eHig1epc05b7Sf+
 tBPOEkREEZJ/WFXiIwlVEzJx5UhvfeJo2XwDxV68o+1mEOIfSDzRU7s0K2z+mMpPnbuj0klgt
 q5hb2YTEVZiEQDPOWZAxjgOPgv+aA981e4UK3dEN0jVmwPkTvTHwkA8ZYDRNer5sPkB8ax150
 RSP9FbOZN3rppEsw==

Hi,

coming from
https://github.com/Zygo/bees/issues/298
https://github.com/knorrie/python-btrfs/issues/51

Balancing failed like this:

# btrfs-balance-least-used -u 80 /mnt/local/data/
Loading block group objects with used_pct <=3D 80 ... found 62
Balance block group vaddr 1303708893184 used_pct 1 ... duration 17 sec tota=
l 655
Balance block group vaddr 555222040576 used_pct 32 ...Error during balancin=
g, there may be more info in dmesg: ENOENT, state none

In the syslog (grep BTRFS) I can't find much but this:

[kernel] BTRFS info (device dm-2): balance: start -dvrange=3D1303708893184.=
.1303708893185
[kernel] BTRFS info (device dm-2): relocating block group 1303708893184 fla=
gs data
[kernel] BTRFS info (device dm-2): found 1 extents, stage: move data extent=
s
[kernel] BTRFS info (device dm-2): found 1 extents, stage: update data poin=
ters
[kernel] BTRFS info (device dm-2): balance: ended with status: 0
[kernel] BTRFS info (device dm-2): balance: start -dvrange=3D555222040576..=
555222040577
[kernel] BTRFS info (device dm-2): relocating block group 555222040576 flag=
s data
[kernel] BTRFS info (device dm-2): found 6650 extents, stage: move data ext=
ents
[kernel] BTRFS info (device dm-2): balance: ended with status: -2

Trying a usual balance it also fails after a while:

# btrfs balance start -dusage=3D80 /mnt/local/data/
ERROR: error during balancing '/mnt/local/data/': No such file or directory

Kernel: 6.6.30-gentoo

Then I started a  btrfs check --repair  it was doing a lot of work but fina=
lly
did not finish after days and repeating this:

super bytes used 631386423296 mismatches actual used 631386390528

I stopped the --repair. balance and btrfs-balance-least-used are still fail=
ing.
I started bees again on the device, but after a while it failed and remount=
ed
ro:

Jan 27 14:07:41 [kernel] BTRFS info (device dm-0: state M): force zstd comp=
ression, level 3
Jan 27 14:07:41 [kernel] BTRFS info (device dm-0: state M): turning off asy=
nc discard
Jan 27 14:08:57 [kernel] BTRFS info (device dm-2): first mount of filesyste=
m 1d888e4b-11c1-4729-8887-cd88ebfda91d
Jan 27 14:08:57 [kernel] BTRFS info (device dm-2): using crc32c (crc32c-int=
el) checksum algorithm
Jan 27 14:08:57 [kernel] BTRFS info (device dm-2): force zstd compression, =
level 15
Jan 27 14:08:57 [kernel] BTRFS info (device dm-2): using free space tree
Jan 27 14:09:06 [kernel] BTRFS info (device dm-2): checking UUID tree
Jan 27 14:09:11 [kernel] BTRFS info (device dm-2): balance: start -dvrange=
=3D1304782635008..1304782635009
Jan 27 14:09:11 [kernel] BTRFS info (device dm-2): relocating block group 1=
304782635008 flags data
Jan 27 14:09:35 [kernel] BTRFS info (device dm-2): found 1 extents, stage: =
move data extents
Jan 27 14:09:36 [kernel] BTRFS info (device dm-2): found 1 extents, stage: =
update data pointers
Jan 27 14:09:37 [kernel] BTRFS info (device dm-2): balance: ended with stat=
us: 0
Jan 27 14:09:37 [kernel] BTRFS info (device dm-2): balance: start -dvrange=
=3D555222040576..555222040577
Jan 27 14:09:37 [kernel] BTRFS info (device dm-2): relocating block group 5=
55222040576 flags data
Jan 27 14:12:23 [kernel] BTRFS info (device dm-2): found 6650 extents, stag=
e: move data extents
Jan 27 14:14:50 [kernel] BTRFS error (device dm-2): incorrect extent count =
for 213705031680; counted 4327, expected 1337
Jan 27 14:14:50 [kernel] BTRFS error (device dm-2: state A): Transaction ab=
orted (error -5)
Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state A) in convert_fre=
e_space_to_extents:471: errno=3D-5 IO failure
Jan 27 14:14:50 [kernel] BTRFS info (device dm-2: state EA): forced readonl=
y
Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in add_to_fre=
e_space_tree:1057: errno=3D-5 IO failure
Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in do_free_ex=
tent_accounting:2870: errno=3D-5 IO failure
Jan 27 14:14:50 [kernel] BTRFS error (device dm-2: state EA): failed to run=
 delayed ref for logical 213930115072 num_bytes 16384 type 176 action 2 ref=
_mod 1: -5
Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in btrfs_run_=
delayed_refs:2168: errno=3D-5 IO failure
Jan 27 14:14:50 [kernel] BTRFS error (device dm-2: state EA): incorrect ext=
ent count for 213705031680; counted 4429, expected 1439
Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in convert_fr=
ee_space_to_bitmaps:338: errno=3D-5 IO failure
Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in add_to_fre=
e_space_tree:1057: errno=3D-5 IO failure
Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in do_free_ex=
tent_accounting:2870: errno=3D-5 IO failure
Jan 27 14:14:50 [kernel] BTRFS error (device dm-2: state EA): failed to run=
 delayed ref for logical 213940502528 num_bytes 16384 type 176 action 2 ref=
_mod 1: -5
Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in btrfs_run_=
delayed_refs:2168: errno=3D-5 IO failure
Jan 27 14:14:50 [kernel] BTRFS info (device dm-2: state EA): balance: ended=
 with status: -30
Jan 27 14:34:06 [kernel] BTRFS info (device dm-2: state EA): last unmount o=
f filesystem 1d577e4b-27c1-4729-8787-cd20ebfda91d
Jan 27 14:36:40 [kernel] BTRFS: device label local_data devid 1 transid 152=
823 /dev/mapper/localdata_crypt scanned by mount (23504)
Jan 27 14:36:40 [kernel] BTRFS info (device dm-2): first mount of filesyste=
m 1d577e4b-27c1-4729-8787-cd20ebfda91d
Jan 27 14:36:40 [kernel] BTRFS info (device dm-2): using crc32c (crc32c-int=
el) checksum algorithm
Jan 27 14:36:40 [kernel] BTRFS info (device dm-2): force zstd compression, =
level 15
Jan 27 14:36:40 [kernel] BTRFS info (device dm-2): using free space tree
Jan 27 14:36:49 [kernel] BTRFS error (device dm-2): incorrect extent count =
for 213705031680; counted 3633, expected 2758
Jan 27 14:36:49 [kernel] BTRFS info (device dm-2): checking UUID tree
Jan 27 14:37:11 [kernel] BTRFS info (device dm-2): balance: resume -dusage=
=3D90,vrange=3D555222040576..555222040577
Jan 27 14:37:11 [kernel] BTRFS info (device dm-2): relocating block group 5=
55222040576 flags data
Jan 27 14:43:09 [kernel] BTRFS info (device dm-2): found 6650 extents, stag=
e: move data extents
Jan 27 14:51:03 [kernel] BTRFS error (device dm-2): incorrect extent count =
for 213705031680; counted 5706, expected 1337
Jan 27 14:51:03 [kernel] BTRFS error (device dm-2: state A): Transaction ab=
orted (error -5)
Jan 27 14:51:03 [kernel] BTRFS: error (device dm-2: state A) in convert_fre=
e_space_to_extents:471: errno=3D-5 IO failure
Jan 27 14:51:03 [kernel] BTRFS info (device dm-2: state EA): forced readonl=
y
Jan 27 14:51:03 [kernel] BTRFS: error (device dm-2: state EA) in add_to_fre=
e_space_tree:1057: errno=3D-5 IO failure
Jan 27 14:51:03 [kernel] BTRFS: error (device dm-2: state EA) in do_free_ex=
tent_accounting:2870: errno=3D-5 IO failure
Jan 27 14:51:03 [kernel] BTRFS error (device dm-2: state EA): failed to run=
 delayed ref for logical 213998551040 num_bytes 16384 type 176 action 2 ref=
_mod 1: -5
Jan 27 14:51:03 [kernel] BTRFS: error (device dm-2: state EA) in btrfs_run_=
delayed_refs:2168: errno=3D-5 IO failure
Jan 27 14:51:03 [kernel] BTRFS info (device dm-2: state EA): balance: ended=
 with status: -30
Jan 27 14:51:04 [kernel] BTRFS error (device dm-2: state EA): incorrect ext=
ent count for 213705031680; counted 5808, expected 1439
Jan 27 14:51:04 [kernel] BTRFS: error (device dm-2: state EA) in convert_fr=
ee_space_to_bitmaps:338: errno=3D-5 IO failure
Jan 27 14:51:04 [kernel] BTRFS: error (device dm-2: state EA) in add_to_fre=
e_space_tree:1057: errno=3D-5 IO failure
Jan 27 14:51:04 [kernel] BTRFS: error (device dm-2: state EA) in do_free_ex=
tent_accounting:2870: errno=3D-5 IO failure
Jan 27 14:51:04 [kernel] BTRFS error (device dm-2: state EA): failed to run=
 delayed ref for logical 214012198912 num_bytes 16384 type 176 action 2 ref=
_mod 1: -5
Jan 27 14:51:04 [kernel] BTRFS: error (device dm-2: state EA) in btrfs_run_=
delayed_refs:2168: errno=3D-5 IO failure

Best regards,
Massimo


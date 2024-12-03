Return-Path: <linux-btrfs+bounces-10034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B599E1D9B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 14:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5ACB166356
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345FF1EF09C;
	Tue,  3 Dec 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=slmail.me header.i=@slmail.me header.b="a5qgYNMU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-200161.simplelogin.co (mail-200161.simplelogin.co [176.119.200.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D4B1E3DCF
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232734; cv=pass; b=a0Fhn59BlL2wivqA0vyY82KIp3fsC+niXj8/h4JNMMNfKVXyJEV/nqpL0xUUf79vY3nBXWX2M9XXIZXYYgqBckRWqkAnUx5Bl19A4CZeDaU6ydnBWwuXcCFbEP9GkS2VZsEcxpX1iH/yDPbnYA8lawLrLY02ylbwi8OYVBaiULM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232734; c=relaxed/simple;
	bh=cHJk9zKMTAwlyy7u6zi8V4gkNdz0TXjVfMlzogzwQ0Q=;
	h=Date:Subject:MIME-Version:Content-Type:From:To:Message-ID; b=FBfqaEGzycSJtxDwfffV2EPCzPssUMoq6uZpMlp53wUwQBEEBDyyB9pQFK2/D9cqVWVzA/kk+al8tH1elcXCUFzKCt8P6ral6+/qv6H2xt56/7jf3Vu4YmJpE2JdnFM9uuqXf4HF74zTzn2DeyfHhU31DGWSB3ULNABWdad/Jxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=slmail.me; spf=pass smtp.mailfrom=slmail.me; dkim=pass (1024-bit key) header.d=slmail.me header.i=@slmail.me header.b=a5qgYNMU; arc=pass smtp.client-ip=176.119.200.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=slmail.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=slmail.me
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1733232152;
	cv=none; b=EI/akxdSkKSIhuifvfg6RmUXAXMVAMIvuUEl38Qmcj5tAnB9qBojXno6N8BZGKQsKtQu/JW3XbbFiZdpXBENxD5rmAROsveKfbenb0h2wuOk1bjweHbzKk3GW/o1YFtAX3RCLswaYcvAI6vvQMM0vVDiIsn1f8Jdt0Bv9xf0h5o/9/oWbtuzEiPzihw6BhBMt1MrfcsM7by4rB2RmtsWBd43RHwcDIq79lJsTB6hl+GG5jCnnXez3W3R3u3F79Y8vMMSLpj5egb08SnP/lKNWOlO8mM54Bv3fZwKf4d5V7LiboodV+YMRf0AgRo/JbYei3Ldc4l8FjxgNjBtu0YTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1733232152; c=relaxed/simple;
	bh=cHJk9zKMTAwlyy7u6zi8V4gkNdz0TXjVfMlzogzwQ0Q=;
	h=Date:Subject:From:To; b=LoPRm1ZgCzj39bCl2eAqFk0wBawugdsoZtCuuLyZe7l6elCH7ft9KhEml/U2CK7kW6egkK1VCm3WlclPM9L/kMVTAz0RVj1fGBF9I+/4j25v40wYnBbcHauh73O9Y3hRY00ecLiu+ybu365SxBR2sP7i7A33zzVxyrWBNdAlx+OKMYerQouNqvczo48sJd9FNoLV34jvs1CzRlyTeJZ/OWKeBoExZBVshXr/EuxzAHkUP2Fs/kixnMMG9GErjPnxPbMKGzi10nzRQ23Xiusw7sDAzAm1Ce2ts0Hr29fG/jzGbTJepC1gIgcuKw6Iqj2QuxlR5sxacV8EBwtCt6kGuw==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slmail.me; s=dkim;
	t=1733232152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tJbLpl3/ygWqp4KjcRp6QhnFff7cv+F+7ShQd6GGVrE=;
	b=a5qgYNMUPowQnocOfplBhopU/51PzOZdOPAa/IlYC23RD1aYNqAiSqHex9x5ifEzM3Wdw5
	Of+yimABFipHZcfpYegTK8fC2m1DPwk5C52wr41SjX43p1mPcNror2YPHdr4SM6MTk4qp7
	JiJ8ThxpbFy+P1hHD2SCIhrrHDpjTIQ=
Date: Tue, 03 Dec 2024 13:22:27 +0000
Subject: Re: Balance failed with tree block error
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aldo Gutierrez <btrfs.spry594@slmail.me>
To: linux-btrfs@vger.kernel.org
Message-ID: <173323215268.7.6782695832944219711.518128798@slmail.me>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 518128798
X-SimpleLogin-Want-Signing: yes

I ran into this issue as well as the previous issue Neal had.=20
Had just updated to kernel 6.11.10 from .9 then did a balance.
Scrub found no issues. Did I lose data? It's a two drive raid1.

BTRFS info (device sdb4): relocating block group 12298903093248 flags data|=
raid1
BTRFS info (device sdb4): found 1417 extents, stage: move data extents
BTRFS info (device sdb4): found 1417 extents, stage: update data pointers
BTRFS info (device sdb4): relocating block group 12296755609600 flags data|=
raid1
BTRFS info (device sdb4): found 1121 extents, stage: move data extents
BTRFS info (device sdb4): found 1121 extents, stage: update data pointers
BTRFS info (device sdb4): leaf 17843600162816 gen 4919751 total ptrs 259 fr=
ee space 1261 owner 2
        item 0 key (15648438190080 169 0) itemoff 16250 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 1 key (15648438206464 169 0) itemoff 16217 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 2 key (15648438222848 169 0) itemoff 16184 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 3 key (15648438239232 169 0) itemoff 16151 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 4 key (15648438255616 169 0) itemoff 16118 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 5 key (15648438272000 169 0) itemoff 16085 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 6 key (15648438288384 169 0) itemoff 16052 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 7 key (15648438304768 169 0) itemoff 16019 itemsize 33
                extent refs 1 gen 4540004 flags 2
                ref#0: tree block backref root 7
        item 8 key (15648438321152 169 0) itemoff 15986 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 9 key (15648438337536 169 0) itemoff 15953 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 10 key (15648438353920 169 0) itemoff 15920 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 11 key (15648438370304 169 0) itemoff 15887 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 12 key (15648438386688 169 0) itemoff 15854 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 13 key (15648438419456 169 0) itemoff 15821 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 14 key (15648438435840 169 0) itemoff 15788 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 15 key (15648438452224 169 0) itemoff 15755 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 16 key (15648438468608 169 0) itemoff 15722 itemsize 33
                extent refs 1 gen 4919721 flags 2
                ref#0: tree block backref root 7
        item 17 key (15648438484992 169 0) itemoff 15689 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 18 key (15648438501376 169 0) itemoff 15656 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 19 key (15648438517760 169 0) itemoff 15623 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 20 key (15648438534144 169 0) itemoff 15590 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 21 key (15648438550528 169 0) itemoff 15557 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 22 key (15648438566912 169 0) itemoff 15524 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 23 key (15648438583296 169 0) itemoff 15491 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 24 key (15648438599680 169 0) itemoff 15458 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 25 key (15648438616064 169 0) itemoff 15425 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 26 key (15648438632448 169 0) itemoff 15392 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 27 key (15648438648832 169 0) itemoff 15359 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 28 key (15648438665216 169 0) itemoff 15326 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 29 key (15648438681600 169 0) itemoff 15293 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 30 key (15648438697984 169 0) itemoff 15260 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 31 key (15648438714368 169 0) itemoff 15227 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 32 key (15648438730752 169 0) itemoff 15194 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 33 key (15648438747136 169 0) itemoff 15161 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 34 key (15648438763520 169 0) itemoff 15128 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 35 key (15648438779904 169 0) itemoff 15095 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 36 key (15648438796288 169 0) itemoff 15062 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 37 key (15648438812672 169 0) itemoff 15029 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 38 key (15648438829056 169 0) itemoff 14996 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 39 key (15648438845440 169 0) itemoff 14963 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 40 key (15648438861824 169 0) itemoff 14930 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 41 key (15648438878208 169 0) itemoff 14897 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 42 key (15648438894592 169 0) itemoff 14864 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 43 key (15648438910976 169 0) itemoff 14831 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 44 key (15648438927360 169 0) itemoff 14798 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 45 key (15648438943744 169 0) itemoff 14765 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 46 key (15648438960128 169 0) itemoff 14732 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 47 key (15648438976512 169 0) itemoff 14699 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 48 key (15648438992896 169 0) itemoff 14666 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 49 key (15648439009280 169 0) itemoff 14633 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 50 key (15648439025664 169 0) itemoff 14600 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 51 key (15648439042048 169 0) itemoff 14567 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 52 key (15648439058432 169 0) itemoff 14534 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 53 key (15648439074816 169 0) itemoff 14501 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 54 key (15648439091200 169 0) itemoff 14468 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 55 key (15648439107584 169 0) itemoff 14435 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 56 key (15648439123968 169 0) itemoff 14402 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 57 key (15648439140352 169 0) itemoff 14369 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 58 key (15648439156736 169 0) itemoff 14336 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 59 key (15648439173120 169 0) itemoff 14303 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 60 key (15648439189504 169 0) itemoff 14270 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 61 key (15648439205888 169 0) itemoff 14237 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 62 key (15648439222272 169 0) itemoff 14204 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 63 key (15648439238656 169 0) itemoff 14171 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 64 key (15648439271424 169 0) itemoff 14138 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 65 key (15648439287808 169 0) itemoff 14105 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 66 key (15648439304192 169 0) itemoff 14072 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 67 key (15648439320576 169 0) itemoff 14039 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 68 key (15648439336960 169 0) itemoff 14006 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 69 key (15648439353344 169 0) itemoff 13973 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 70 key (15648439369728 169 0) itemoff 13940 itemsize 33
                extent refs 1 gen 4835798 flags 2
                ref#0: tree block backref root 7
        item 71 key (15648439386112 169 0) itemoff 13907 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 72 key (15648439402496 169 0) itemoff 13874 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 73 key (15648439418880 169 0) itemoff 13841 itemsize 33
                extent refs 1 gen 4725255 flags 2
                ref#0: tree block backref root 7
        item 74 key (15648439435264 169 0) itemoff 13808 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 75 key (15648439451648 169 0) itemoff 13775 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 76 key (15648439468032 169 0) itemoff 13742 itemsize 33
                extent refs 1 gen 4584750 flags 2
                ref#0: shared block backref parent 15647779209216
        item 77 key (15648439484416 169 0) itemoff 13709 itemsize 33
                extent refs 1 gen 4584750 flags 2
                ref#0: shared block backref parent 15647779209216
        item 78 key (15648439500800 169 0) itemoff 13676 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 79 key (15648439533568 169 0) itemoff 13643 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 80 key (15648439549952 169 0) itemoff 13610 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 81 key (15648439566336 169 0) itemoff 13577 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 82 key (15648439582720 169 0) itemoff 13544 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 83 key (15648439599104 169 0) itemoff 13511 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 84 key (15648439615488 169 0) itemoff 13478 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 85 key (15648439631872 169 0) itemoff 13445 itemsize 33
                extent refs 1 gen 4724691 flags 2
                ref#0: tree block backref root 7
        item 86 key (15648439648256 169 0) itemoff 13412 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 87 key (15648439664640 169 0) itemoff 13379 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 88 key (15648439681024 169 0) itemoff 13346 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 89 key (15648439697408 169 0) itemoff 13313 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 90 key (15648439713792 169 0) itemoff 13280 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 91 key (15648439730176 169 0) itemoff 13247 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 92 key (15648439746560 169 0) itemoff 13214 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 93 key (15648439762944 169 0) itemoff 13181 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 94 key (15648439779328 169 0) itemoff 13148 itemsize 33
                extent refs 1 gen 4916451 flags 2
                ref#0: tree block backref root 7
        item 95 key (15648439795712 169 0) itemoff 13115 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 96 key (15648439812096 169 0) itemoff 13082 itemsize 33
                extent refs 1 gen 4919721 flags 2
                ref#0: tree block backref root 7
        item 97 key (15648439828480 169 0) itemoff 13049 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 98 key (15648439844864 169 0) itemoff 13016 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 99 key (15648439861248 169 0) itemoff 12983 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 100 key (15648439877632 169 0) itemoff 12950 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 101 key (15648439894016 169 0) itemoff 12917 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 102 key (15648439926784 169 0) itemoff 12884 itemsize 33
                extent refs 1 gen 4919721 flags 2
                ref#0: tree block backref root 7
        item 103 key (15648439959552 169 0) itemoff 12851 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 104 key (15648439992320 169 0) itemoff 12818 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 105 key (15648440008704 169 0) itemoff 12785 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 106 key (15648440025088 169 0) itemoff 12752 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 107 key (15648440041472 169 0) itemoff 12719 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 108 key (15648440057856 169 0) itemoff 12686 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 109 key (15648440074240 169 0) itemoff 12653 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 110 key (15648440090624 169 0) itemoff 12620 itemsize 33
                extent refs 1 gen 4860419 flags 2
                ref#0: tree block backref root 7
        item 111 key (15648440107008 169 0) itemoff 12587 itemsize 33
                extent refs 1 gen 4860419 flags 2
                ref#0: tree block backref root 7
        item 112 key (15648440123392 169 0) itemoff 12554 itemsize 33
                extent refs 1 gen 4860419 flags 2
                ref#0: tree block backref root 7
        item 113 key (15648440139776 169 0) itemoff 12521 itemsize 33
                extent refs 1 gen 4860419 flags 2
                ref#0: tree block backref root 7
        item 114 key (15648440156160 169 0) itemoff 12488 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 115 key (15648440188928 169 0) itemoff 12455 itemsize 33
                extent refs 1 gen 4725185 flags 2
                ref#0: tree block backref root 7
        item 116 key (15648440205312 169 0) itemoff 12422 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 117 key (15648440221696 169 0) itemoff 12389 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 118 key (15648440238080 169 0) itemoff 12356 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 119 key (15648440254464 169 0) itemoff 12323 itemsize 33
                extent refs 1 gen 4725185 flags 2
                ref#0: tree block backref root 7
        item 120 key (15648440270848 169 0) itemoff 12290 itemsize 33
                extent refs 1 gen 4725185 flags 2
                ref#0: tree block backref root 7
        item 121 key (15648440287232 169 0) itemoff 12257 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 122 key (15648440303616 169 0) itemoff 12224 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 123 key (15648440320000 169 0) itemoff 12191 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 124 key (15648440352768 169 0) itemoff 12158 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 125 key (15648440369152 169 0) itemoff 12125 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 126 key (15648440385536 169 0) itemoff 12092 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 127 key (15648440401920 169 0) itemoff 12059 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 128 key (15648440418304 169 0) itemoff 12026 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 129 key (15648440434688 169 0) itemoff 11993 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 130 key (15648440451072 169 0) itemoff 11960 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 131 key (15648440467456 169 0) itemoff 11927 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 132 key (15648440483840 169 0) itemoff 11894 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 133 key (15648440500224 169 0) itemoff 11861 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 134 key (15648440516608 169 0) itemoff 11828 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 135 key (15648440532992 169 0) itemoff 11795 itemsize 33
                extent refs 1 gen 4905458 flags 2
                ref#0: tree block backref root 8275
        item 136 key (15648440565760 169 0) itemoff 11762 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 137 key (15648440582144 169 0) itemoff 11729 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 138 key (15648440598528 169 0) itemoff 11696 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 139 key (15648440614912 169 0) itemoff 11663 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 140 key (15648440631296 169 0) itemoff 11630 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 141 key (15648440664064 169 0) itemoff 11597 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 142 key (15648440680448 169 0) itemoff 11564 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 143 key (15648440696832 169 1) itemoff 11531 itemsize 33
                extent refs 1 gen 4916453 flags 2
                ref#0: tree block backref root 8275
        item 144 key (15648440713216 169 0) itemoff 11498 itemsize 33
                extent refs 1 gen 4905458 flags 2
                ref#0: tree block backref root 8275
        item 145 key (15648440729600 169 1) itemoff 11465 itemsize 33
                extent refs 1 gen 4916453 flags 2
                ref#0: tree block backref root 8275
        item 146 key (15648440745984 169 0) itemoff 11432 itemsize 33
                extent refs 1 gen 4905458 flags 2
                ref#0: tree block backref root 8275
        item 147 key (15648440778752 169 0) itemoff 11399 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 148 key (15648440795136 169 0) itemoff 11366 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 149 key (15648440811520 169 0) itemoff 11333 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 150 key (15648440827904 169 0) itemoff 11300 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 151 key (15648440844288 169 0) itemoff 11267 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 152 key (15648440860672 169 0) itemoff 11234 itemsize 33
                extent refs 1 gen 4725255 flags 2
                ref#0: tree block backref root 7
        item 153 key (15648440877056 169 0) itemoff 11201 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 154 key (15648440893440 169 0) itemoff 11168 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 155 key (15648440909824 169 0) itemoff 11135 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 156 key (15648440926208 169 0) itemoff 11102 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 157 key (15648440942592 169 0) itemoff 11069 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 158 key (15648440958976 169 0) itemoff 11036 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 159 key (15648440975360 169 0) itemoff 11003 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 160 key (15648440991744 169 0) itemoff 10970 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 161 key (15648441008128 169 0) itemoff 10937 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 162 key (15648441024512 169 0) itemoff 10904 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 163 key (15648441040896 169 0) itemoff 10871 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 164 key (15648441057280 169 0) itemoff 10838 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 165 key (15648441073664 169 0) itemoff 10805 itemsize 33
                extent refs 1 gen 4835798 flags 2
                ref#0: tree block backref root 7
        item 166 key (15648441090048 169 0) itemoff 10772 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 167 key (15648441106432 169 0) itemoff 10739 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 168 key (15648441122816 169 0) itemoff 10706 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 169 key (15648441139200 169 0) itemoff 10673 itemsize 33
                extent refs 1 gen 4889219 flags 2
                ref#0: tree block backref root 263
        item 170 key (15648441155584 169 0) itemoff 10640 itemsize 33
                extent refs 1 gen 4889219 flags 2
                ref#0: tree block backref root 263
        item 171 key (15648441171968 169 0) itemoff 10607 itemsize 33
                extent refs 1 gen 4724808 flags 2
                ref#0: tree block backref root 7
        item 172 key (15648441188352 169 0) itemoff 10574 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 173 key (15648441204736 169 0) itemoff 10541 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 174 key (15648441221120 169 0) itemoff 10508 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 175 key (15648441237504 169 0) itemoff 10475 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 176 key (15648441253888 169 0) itemoff 10442 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 177 key (15648441270272 169 0) itemoff 10409 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 178 key (15648441286656 169 0) itemoff 10376 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 179 key (15648441303040 169 0) itemoff 10343 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 180 key (15648441319424 169 0) itemoff 10310 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 181 key (15648441335808 169 0) itemoff 10277 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 182 key (15648441352192 169 0) itemoff 10244 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 183 key (15648441368576 169 0) itemoff 10211 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 184 key (15648441384960 169 0) itemoff 10178 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 185 key (15648441401344 169 0) itemoff 10145 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 186 key (15648441434112 169 0) itemoff 10112 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 187 key (15648441450496 169 0) itemoff 10079 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 188 key (15648441466880 169 0) itemoff 10046 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 189 key (15648441483264 169 0) itemoff 10013 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 190 key (15648441499648 169 0) itemoff 9980 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 191 key (15648441516032 169 0) itemoff 9947 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 192 key (15648441532416 169 0) itemoff 9914 itemsize 33
                extent refs 1 gen 4725255 flags 2
                ref#0: tree block backref root 7
        item 193 key (15648441548800 169 0) itemoff 9881 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 194 key (15648441565184 169 0) itemoff 9848 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 195 key (15648441581568 169 0) itemoff 9815 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 196 key (15648441597952 169 0) itemoff 9782 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 197 key (15648441614336 169 0) itemoff 9749 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 198 key (15648441630720 169 0) itemoff 9716 itemsize 33
                extent refs 1 gen 4916453 flags 2
                ref#0: tree block backref root 8275
        item 199 key (15648441647104 169 0) itemoff 9683 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 200 key (15648441663488 169 0) itemoff 9650 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 201 key (15648441679872 169 0) itemoff 9617 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 202 key (15648441696256 169 0) itemoff 9584 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 203 key (15648441712640 169 0) itemoff 9551 itemsize 33
                extent refs 1 gen 4725255 flags 2
                ref#0: tree block backref root 7
        item 204 key (15648441729024 169 0) itemoff 9518 itemsize 33
                extent refs 1 gen 4725185 flags 2
                ref#0: tree block backref root 7
        item 205 key (15648441745408 169 0) itemoff 9485 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 206 key (15648441761792 169 0) itemoff 9452 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 207 key (15648441778176 169 0) itemoff 9419 itemsize 33
                extent refs 1 gen 4889219 flags 2
                ref#0: tree block backref root 263
        item 208 key (15648441794560 169 0) itemoff 9386 itemsize 33
                extent refs 1 gen 4889219 flags 2
                ref#0: tree block backref root 263
        item 209 key (15648441810944 169 0) itemoff 9353 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 210 key (15648441827328 169 0) itemoff 9320 itemsize 33
                extent refs 1 gen 4769984 flags 2
                ref#0: tree block backref root 7
        item 211 key (15648441843712 169 0) itemoff 9287 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 212 key (15648441860096 169 0) itemoff 9254 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 213 key (15648441876480 169 0) itemoff 9221 itemsize 33
                extent refs 1 gen 4916453 flags 2
                ref#0: tree block backref root 8275
        item 214 key (15648441892864 169 0) itemoff 9188 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 215 key (15648441909248 169 0) itemoff 9155 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 216 key (15648441925632 169 0) itemoff 9122 itemsize 33
                extent refs 1 gen 4836679 flags 2
                ref#0: tree block backref root 2031
        item 217 key (15648441942016 169 0) itemoff 9089 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 218 key (15648441958400 169 0) itemoff 9056 itemsize 33
                extent refs 1 gen 4836679 flags 2
                ref#0: tree block backref root 2031
        item 219 key (15648441974784 169 0) itemoff 9023 itemsize 33
                extent refs 1 gen 4836679 flags 2
                ref#0: tree block backref root 2031
        item 220 key (15648441991168 169 0) itemoff 8990 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 221 key (15648442007552 169 0) itemoff 8957 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 222 key (15648442023936 169 0) itemoff 8924 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 223 key (15648442040320 169 0) itemoff 8891 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 224 key (15648442073088 169 0) itemoff 8858 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 225 key (15648442089472 169 0) itemoff 8825 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 226 key (15648442105856 169 0) itemoff 8792 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 227 key (15648442122240 169 0) itemoff 8759 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 228 key (15648442138624 169 0) itemoff 8726 itemsize 33
                extent refs 1 gen 4919720 flags 2
                ref#0: tree block backref root 7
        item 229 key (15648442155008 169 0) itemoff 8693 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 230 key (15648442171392 169 0) itemoff 8660 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 231 key (15648442187776 169 0) itemoff 8627 itemsize 33
                extent refs 1 gen 4916453 flags 2
                ref#0: tree block backref root 8275
        item 232 key (15648442204160 169 0) itemoff 8594 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 233 key (15648442220544 169 0) itemoff 8561 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 234 key (15648442236928 169 0) itemoff 8528 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 235 key (15648442253312 169 0) itemoff 8495 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 236 key (15648442269696 169 1) itemoff 8462 itemsize 33
                extent refs 1 gen 4919720 flags 2
                ref#0: tree block backref root 7
        item 237 key (15648442286080 169 0) itemoff 8429 itemsize 33
                extent refs 1 gen 4725255 flags 2
                ref#0: tree block backref root 7
        item 238 key (15648442302464 169 0) itemoff 8396 itemsize 33
                extent refs 1 gen 4725255 flags 2
                ref#0: tree block backref root 7
        item 239 key (15648442318848 169 0) itemoff 8363 itemsize 33
                extent refs 1 gen 4725255 flags 2
                ref#0: tree block backref root 7
        item 240 key (15648442335232 169 0) itemoff 8330 itemsize 33
                extent refs 1 gen 4919720 flags 2
                ref#0: tree block backref root 7
        item 241 key (15648442351616 169 0) itemoff 8297 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 242 key (15648442368000 169 0) itemoff 8264 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 243 key (15648442400768 169 0) itemoff 8231 itemsize 33
                extent refs 1 gen 4530853 flags 2
                ref#0: tree block backref root 7
        item 244 key (15648442417152 169 0) itemoff 8198 itemsize 33
                extent refs 1 gen 4558463 flags 2
                ref#0: tree block backref root 7
        item 245 key (15648442449920 169 0) itemoff 8165 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 246 key (15648442466304 169 0) itemoff 8132 itemsize 33
                extent refs 1 gen 4724232 flags 2
                ref#0: tree block backref root 7
        item 247 key (15648442482688 169 0) itemoff 8099 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 248 key (15648442499072 169 0) itemoff 8066 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 249 key (15648442515456 169 0) itemoff 8033 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 250 key (15648442531840 169 0) itemoff 8000 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 251 key (15648442548224 169 0) itemoff 7967 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 252 key (15648442564608 169 0) itemoff 7934 itemsize 33
                extent refs 1 gen 4836679 flags 2
                ref#0: tree block backref root 2031
        item 253 key (15648442580992 169 0) itemoff 7901 itemsize 33
                extent refs 1 gen 4836679 flags 2
                ref#0: tree block backref root 2031
        item 254 key (15648442597376 169 0) itemoff 7868 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 255 key (15648442613760 169 0) itemoff 7835 itemsize 33
                extent refs 1 gen 4836679 flags 2
                ref#0: tree block backref root 2031
        item 256 key (15648442630144 169 0) itemoff 7802 itemsize 33
                extent refs 1 gen 4530859 flags 2
                ref#0: tree block backref root 7
        item 257 key (15648442646528 169 0) itemoff 7769 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
        item 258 key (15648442662912 169 0) itemoff 7736 itemsize 33
                extent refs 1 gen 4893938 flags 2
                ref#0: shared block backref parent 17844013596672
BTRFS error (device sdb4): tree block extent item (15648439517184) is not f=
ound in extent tree
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1036 at fs/btrfs/relocation.c:3302 add_data_references=
+0x525/0x540 [btrfs]
Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device wiregua=
rd curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64 libc=
urve25519_generic libchacha ip6_udp_tunnel udp_tunnel rfkill veth bridge st=
p llc nft_masq nft_reject_ipv4 nf_reject_ipv4 nft_reject nft_log nft_ct nft=
_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables msr =
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scod=
ec_component snd_hda_intel mousedev kvm_amd snd_intel_dspcfg ext4 joydev mb=
cache jbd2 snd_intel_sdw_acpi ccp snd_hda_codec kvm usblp crct10dif_pclmul =
snd_hda_core crc32_pclmul polyval_clmulni polyval_generic snd_hwdep snd_pcm=
 ghash_clmulni_intel sha512_ssse3 sha1_ssse3 snd_timer ppdev aesni_intel sn=
d r8169 wmi_bmof soundcore acpi_cpufreq pcspkr gf128mul crypto_simd k10temp=
 cryptd fam15h_power asus_atk0110 realtek mdio_devres sp5100_tco parport_pc=
 parport libphy i2c_piix4 mac_hid i2c_smbus vboxnetflt(OE) vboxnetadp(OE) v=
boxdrv(OE) xt_LOG nf_log_syslog loop dm_mod
 nfnetlink dmi_sysfs ip_tables x_tables amdgpu crc16 amdxcp drm_exec gpu_sc=
hed drm_buddy radeon drm_ttm_helper ttm video i2c_algo_bit firewire_ohci dr=
m_suballoc_helper ata_generic drm_display_helper firewire_core uas pata_acp=
i sha256_ssse3 crc_itu_t usb_storage cec pata_atiixp xhci_pci rc_core xhci_=
pci_renesas wmi hid_generic usbhid btrfs blake2b_generic libcrc32c crc32c_g=
eneric crc32c_intel xor raid6_pq
CPU: 1 UID: 0 PID: 1036 Comm: btrfs Tainted: G           OE   T  6.11.10-ha=
rdened1-1-hardened #1 413e8b79d1d15c0610f0d5fd694c52987129d224
Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [T]=3DRANDSTRUCT
Hardware name: System manufacturer System Product Name/M5A88-M EVO, BIOS 17=
01    11/14/2012
RIP: 0010:add_data_references+0x525/0x540 [btrfs]
Code: 48 8b 6c 24 10 45 89 f5 e9 0e ff ff ff 4c 87 fd 49 8b 3f e8 1d c3 f8 =
ff 4c 89 ea 48 c7 c6 28 3f 4f c0 48 89 ef e8 db b3 06 00 <0f> 0b 4c 89 ff 4=
1 bd ea ff ff ff e8 bb 85 f7 ff 48 8b 6c 24 10 e9
RSP: 0018:ffffbbb4408e7890 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffbbb4408e78c7 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000ffffffff
RBP: ffff900f56216000 R08: 0000000000000000 R09: ffffbbb4408e7670
R10: ffffffffa9ab48e8 R11: 0000000000000003 R12: ffff900f0158d000
R13: 00000e3b6fadc000 R14: 0000000000000001 R15: ffff900f50265348
FS:  00006ace0f50a900(0000) GS:ffff900f5ae80000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000013f5a1727c8 CR3: 00000000218c4000 CR4: 00000000000406f0
Call Trace:
 <TASK>
 ? add_data_references+0x525/0x540 [btrfs d7696681b398eab3dc952fe351aa93bdc=
22b6151]
 ? __warn.cold+0x8e/0xe8
 ? add_data_references+0x525/0x540 [btrfs d7696681b398eab3dc952fe351aa93bdc=
22b6151]
 ? report_bug+0xea/0x170
 ? handle_bug+0x58/0x90
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? add_data_references+0x525/0x540 [btrfs d7696681b398eab3dc952fe351aa93bdc=
22b6151]
 relocate_block_group+0x348/0x540 [btrfs d7696681b398eab3dc952fe351aa93bdc2=
2b6151]
 btrfs_relocate_block_group+0x242/0x410 [btrfs d7696681b398eab3dc952fe351aa=
93bdc22b6151]
 btrfs_relocate_chunk+0x3f/0x130 [btrfs d7696681b398eab3dc952fe351aa93bdc22=
b6151]
 btrfs_balance+0x7fe/0x1020 [btrfs d7696681b398eab3dc952fe351aa93bdc22b6151=
]
 btrfs_ioctl+0x23b9/0x2670 [btrfs d7696681b398eab3dc952fe351aa93bdc22b6151]
 __x64_sys_ioctl+0x94/0xd0
 do_syscall_64+0x84/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x6ace0f0d1ced
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 =
48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 f=
f ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
RSP: 002b:00007c642c934470 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00006ace0f0d1ced
RDX: 00007c642c934570 RSI: 00000000c4009420 RDI: 0000000000000003
RBP: 00007c642c9344c0 R08: 0000000000000000 R09: 0000000000000000
RBP: 00007c642c9344c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007c642c9363ca R14: 00007c642c934570 R15: 0000000000000001
 </TASK>
---[ end trace 0000000000000000 ]---
BTRFS info (device sdb4): balance: ended with status: -22
BTRFS info (device sdb4): scrub: finished on devid 2 with status: 0
BTRFS info (device sdb4): scrub: finished on devid 1 with status: 0




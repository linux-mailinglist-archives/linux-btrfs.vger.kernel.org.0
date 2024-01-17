Return-Path: <linux-btrfs+bounces-1506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A380830000
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 07:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807231F23B3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 06:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE1F8C09;
	Wed, 17 Jan 2024 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="M+f6ESbq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790B8BEB
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705471453; cv=none; b=n6scP67Y8UVXvXwmKjKoRfpFzucZ/+ItW3E4xivvztchlR5Z0N81LcOB9S8tREW4fzCmZF8unQ10nrcFdhVA03Gxe1OVEMRC2s5/+L7UB8ohywrQ6B8UYDMXbqDDMD3OMnjQrXnImZnSJZF/a5ifKANxOsWvl1p8pBV64HUzTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705471453; c=relaxed/simple;
	bh=cMpvbFqsUWaICJdkIPeLbXg0vAZ65IZdeW0TKJVPkJs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Subject:From:To:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=TpTL1IW4eKH+F2clUIWRcOZrtqz0oOLDx3CHdomNKtYXD6sL/7/OJVIvPNtHtTualMnA/RMAylDqhNOBAgHxHQQeqFFD2EdGop+MKiY9snzf6KoHCbwvr1ZX43ITo1OJ/r6njOnjj+2LZIIS/QQPmNJZUjV/PerjJZ7l7ONkVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=M+f6ESbq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e857ce784so12009625e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 22:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1705471449; x=1706076249; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/xauQY0jzhX7XzV9BOzWbwMa903sEcoVFurjCHstj1c=;
        b=M+f6ESbqS6CoL7STYVByL3f0hpVPqYkGL9fYj+CB1YIqfKgoa0pTcaNQKrlIMupdwy
         ntAuRPFjVSwCnylSRD0IrHck6U+fhDiplLmEPO0xQ4BXGG6VcKgO0du3Uxw+8QBdsTM1
         75V96wJeiIgslcqLyqb3qyVyI05a0jkpD8TRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705471449; x=1706076249;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xauQY0jzhX7XzV9BOzWbwMa903sEcoVFurjCHstj1c=;
        b=QTknR4Jy1TzVide+el7CN+8zOykgyFDK/FpdxLwynz54Sp2OICgORwKPsYEbDnB/dB
         rWEPw+hWDq+pU9sdrHHcZmg2TyIXVtPZV8RScqmnDt60ZsuNx+hQmCASb6Pfw6iTglcQ
         6bC6YiUMxffQXDxex4Ig6pISI9A5zgdRReZwtMnUzsBzZWcKljo0bQlWaANzJVYxaUAB
         Mp3ntSKLOFLG7/tcsiKO5evd/yJe4UiaHITWMGv83ADBM3AIoJcPdL7MxgdL1nQ/J7/x
         YLier13HAVTvaq4ATji2lfSDeXvfo6VtMbMsROSDSDRVfyPOeMT9Fi579QakGqTMLuAz
         bNOA==
X-Gm-Message-State: AOJu0YyV7bRsQ2z4BSZXEg27GnsBLBfKHGxxctTE7CdVq65+1aER+nNj
	AgXq75oj99OPNaFRbfQqDQmbLeoUbhe/nC8ovISv9zbiGHAwvg==
X-Google-Smtp-Source: AGHT+IGWjYY4IslxEcX+MS736jmsaWpSuuZAmPnVWRLAdjcGYb68Nyk2+RsxPjMFE95+IjAptO4HwQ==
X-Received: by 2002:a05:600c:4892:b0:40e:42ce:f28b with SMTP id j18-20020a05600c489200b0040e42cef28bmr4502239wmp.52.1705471448558;
        Tue, 16 Jan 2024 22:04:08 -0800 (PST)
Received: from able.exile.i.intelfx.name ([178.134.111.230])
        by smtp.gmail.com with ESMTPSA id q17-20020adfab11000000b0033672971fabsm780948wrc.115.2024.01.16.22.04.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 22:04:07 -0800 (PST)
Message-ID: <9cdbf0ca9cdda1b4c84e15e548af7d7f9f926382.camel@intelfx.name>
Subject: [6.7 regression] [BISECTED] 28270e25c69a causes overallocation of
 metadata space
From: Ivan Shapovalov <intelfx@intelfx.name>
To: linux-btrfs@vger.kernel.org
Date: Wed, 17 Jan 2024 07:04:06 +0100
Autocrypt: addr=intelfx@intelfx.name; prefer-encrypt=mutual; keydata=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
 NzAT4cw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

Starting from v6.7 I've noticed severe overallocation of metadata space
on both of my btrfs root filesystems (both NVMe SSDs, both use
snapshots):

```
# mount | grep -w /
rw,noatime,compress=3Dzstd:1,ssd,discard=3Dasync,space_cache=3Dv2,subvolid=
=3D<...>

# btrfs fi usage /
<...>

Data,single: Size:550.00GiB, Used:497.12GiB (90.39%)
   /dev/mapper/root      550.00GiB

Metadata,DUP: Size:72.00GiB, Used:8.38GiB (11.64%)
   /dev/mapper/root      144.00GiB

<...>
```

Running a full metadata balance (`btrfs balance start -m /`) or a
"staged" balance
(e. g. `for u in {0..90..5}; do btrfs balance start -musage=3D$u /`)
does not help / makes the overallocation worse.

Bisect log:
```
# bad: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
# good: [ffc253263a1375a65fa6c9f62a893e9767fbebfa] Linux 6.6
git bisect start 'v6.7' 'v6.6'
# bad: [deefd5024f0772cf56052ace9a8c347dc70bcaf3] Merge tag 'vfio-v6.7-rc1'=
 of https://github.com/awilliam/linux-vfio
git bisect bad deefd5024f0772cf56052ace9a8c347dc70bcaf3
# bad: [5a6a09e97199d6600d31383055f9d43fbbcbe86f] Merge tag 'cgroup-for-6.7=
' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
git bisect bad 5a6a09e97199d6600d31383055f9d43fbbcbe86f
# good: [17047fbced563cf5abe5aa546f6a92af48900b69] bcachefs: Fix incorrectl=
y freeing btree_path in alloc path
git bisect good 17047fbced563cf5abe5aa546f6a92af48900b69
# good: [b827ac419721a106ae2fccaa40576b0594edad92] exportfs: Change bcachef=
s fid_type enum to avoid conflicts
git bisect good b827ac419721a106ae2fccaa40576b0594edad92
# bad: [9ab021a1b57007a22761f6f41d91eb4aae10d145] Merge tag 'x86_cache_for_=
6.7_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 9ab021a1b57007a22761f6f41d91eb4aae10d145
# good: [8b16da681eb0c9b9cb2f9abd0dade67559cfb48d] Merge tag 'nfsd-6.7' of =
git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good 8b16da681eb0c9b9cb2f9abd0dade67559cfb48d
# bad: [07a274a8862dba86a270ced2a4c5ff3f7a01b66a] btrfs: remove redundant r=
oot argument from btrfs_update_inode_item()
git bisect bad 07a274a8862dba86a270ced2a4c5ff3f7a01b66a
# good: [3ee56a58ad8921cb43c49d56347a8e270871844c] btrfs: reserve space for=
 delayed refs on a per ref basis
git bisect good 3ee56a58ad8921cb43c49d56347a8e270871844c
# bad: [9f9918a8017b7925da2fad16b4ccf6a14630f03e] btrfs: sysfs: announce pr=
esence of raid-stripe-tree
git bisect bad 9f9918a8017b7925da2fad16b4ccf6a14630f03e
# bad: [87463f7e0250d471fac41e7c9c45ae21d83b5f85] btrfs: zoned: factor out =
DUP bg handling from btrfs_load_block_group_zone_info
git bisect bad 87463f7e0250d471fac41e7c9c45ae21d83b5f85
# bad: [50564b651d01c19ce732819c5b3c3fd60707188e] btrfs: abort transaction =
on generation mismatch when marking eb as dirty
git bisect bad 50564b651d01c19ce732819c5b3c3fd60707188e
# bad: [28270e25c69a2c76ea1ed0922095bffb9b9a4f98] btrfs: always reserve spa=
ce for delayed refs when starting transaction
git bisect bad 28270e25c69a2c76ea1ed0922095bffb9b9a4f98
# good: [adb86dbe426f9a54843d70092819deca220a224d] btrfs: stop doing excess=
ive space reservation for csum deletion
git bisect good adb86dbe426f9a54843d70092819deca220a224d
# first bad commit: [28270e25c69a2c76ea1ed0922095bffb9b9a4f98] btrfs: alway=
s reserve space for delayed refs when starting transaction
```

Thanks,
--=20
Ivan Shapovalov / intelfx /


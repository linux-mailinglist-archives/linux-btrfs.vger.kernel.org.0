Return-Path: <linux-btrfs+bounces-6509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1427932F61
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB82B2350D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0571A00E7;
	Tue, 16 Jul 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandnabba.se header.i=@sandnabba.se header.b="GTNhBYeE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from r07.out0.gmailify.com (r07.out0.gmailify.com [159.255.151.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA119DF8D
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.255.151.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152224; cv=none; b=XGhkhA9w/ahQB5WamXs975T6eKgP3hb2t4ttmNVDOiC26FzcE2iXrcWKKNnDNSmB+KT4YiMu1myzdy8azipygNsNH7aevyLQlsF0aQXvOTvZGtSKOu4yB91cVafEqtOfAOy7evReNICmdykHjxDYD0CvnK9VDmcjmBwMWJIH2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152224; c=relaxed/simple;
	bh=gy5Whe7XfeIzJCclAXl1F/89J1hEGv0JxHEHT58NRGw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XTyNPtt+FDNf14F/4/9HpiKZraJbA7IHxUB9l/+9+vxUwpBRUwA7I7XLP+hZtq1N8QZ10pmZUbnSIwLzf+nBCYTbDVviX/xrSisZWGYrHLOWdDGaa63RSELyXxgk/s63UZP707AUeuKNgaT4fn4/r2l1okArwXTWNI9UiYDcTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandnabba.se; spf=pass smtp.mailfrom=sandnabba.se; dkim=pass (2048-bit key) header.d=sandnabba.se header.i=@sandnabba.se header.b=GTNhBYeE; arc=none smtp.client-ip=159.255.151.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandnabba.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandnabba.se
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.gmailify.com (Postfix) with ESMTPSA id 0BCD011C119F
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandnabba.se;
	s=gm0; t=1721149974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=gy5Whe7XfeIzJCclAXl1F/89J1hEGv0JxHEHT58NRGw=;
	b=GTNhBYeEWZGl5WTygfVaVq7Wmqpge/+w6rgssuh7sY07t63vjlYpmVv2NdNj0hjJyLIXO1
	sK2gGTEt2wGSHXvinnQyon4gLKnTL4tdvy69tte/fPNk4JdbdtjmMFJN/kh68REEnFKGEY
	JMWt+jmaHydacbPJ3YuYtg6FLP6chPuLlVtZ4saIyKRsRZYvw88t9XUnswJSkyi09vTsu5
	Y62EfoIb/v/MQBixdkx7F+0zBJfhinFHzYk2ZwgUC7473Xrnh0uqUQ/Jm3v4Tqkh3D40l9
	YHHNpz/aY7HKmUjZ6iDK0rZ6VcGXRbcKox9DTbcoD3KOV/XSFX6IGmY9vRtiAA==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b5daf5ea91so32852816d6.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 10:12:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy6adUJUQgiCjmlybOK/JVFPUL7qqrB6aTUVDCvR6mTdOSYmS66
	gCk+Ttee5sEy/glNLPE5hxZa1V1CSlzzUCviaNZE2QrXMn2+ig1r/o4MafHei1sGm66SWX4iv7w
	yp8zV0b75heduzBy421vLM3VCk00=
X-Google-Smtp-Source: AGHT+IFhOw4+La3GnIe/QyFBtAZSMNB02dPQ2DSHfOk/qO2Jsi4euhCDiB6k2eUTd981/jYpLzhuYMVOf/50s7FYtAU=
X-Received: by 2002:a05:6214:246c:b0:6b0:9347:e414 with SMTP id
 6a1803df08f44-6b77f4c898dmr30126556d6.36.1721149971812; Tue, 16 Jul 2024
 10:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@gmailify.com and include these headers.
From: "Emil.s" <emil@sandnabba.se>
Date: Tue, 16 Jul 2024 19:12:40 +0200
X-Gmail-Original-Message-ID: <CAEA9r7CotKGMkNh3-hgTbUL4A_pbOD39ZmdZO_ntSAVNwkOE=w@mail.gmail.com>
Message-ID: <CAEA9r7CotKGMkNh3-hgTbUL4A_pbOD39ZmdZO_ntSAVNwkOE=w@mail.gmail.com>
Subject: btrfsck repair on backpointer mismatch fails and get stuck in loop
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Gmailify-Queue-Id: 0BCD011C119F
X-Gmailify-Score: -0.10

Hello!

I got a somewhat corrupt btrfs filesystem, most likely caused by bad
RAM on old hardware.
I've moved the drives to a new system running Linux 6.9.9 and
btrfs-progs 6.9.2 and I'm now attempting to repair the filesystem.

Output of btrfsck:
```
root@ThinkStation: /home/emil #> btrfsck /dev/md127
Opening filesystem to check...
Checking filesystem on /dev/md127
UUID: 9b00b378-d0f7-42a3-82c5-f70143e99184
[1/7] checking root items
[2/7] checking extents
data extent[780333588480, 942080] size mimsmatch, extent item size
925696 file item size 942080
backpointer mismatch on [780333588480 925696]
data extent[856274145280, 913408] size mimsmatch, extent item size
897024 file item size 913408
backpointer mismatch on [856274145280 897024]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
there are no extents for csum range 780334514176-780334530560
csum exists for 780130058240-780381552640 but there is no extent record
there are no extents for csum range 856275042304-856275058688
csum exists for 856273186816-856277803008 but there is no extent record
ERROR: errors found in csum tree
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 3453332246528 bytes used, error(s) found
total csum bytes: 3367901428
total tree bytes: 4600954880
total fs tree bytes: 877445120
total extent tree bytes: 118177792
btree space waste bytes: 377391721
file data blocks allocated: 11156902174720
referenced 8518851969024
```

But when trying to repair using just the `--repair` option, it seems
to get stuck attempting to repair the same extent over and over again:
```
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/md127
UUID: 9b00b378-d0f7-42a3-82c5-f70143e99184
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
data extent[780333588480, 942080] size mimsmatch, extent item size
925696 file item size 942080
backpointer mismatch on [780333588480 925696]
attempting to repair backref discrepancy for bytenr 780333588480
data extent[780333588480, 942080] size mimsmatch, extent item size
925696 file item size 942080
backpointer mismatch on [780333588480 925696]
attempting to repair backref discrepancy for bytenr 780333588480
data extent[780333588480, 942080] size mimsmatch, extent item size
925696 file item size 942080
backpointer mismatch on [780333588480 925696]
attempting to repair backref discrepancy for bytenr 780333588480
....
```

One suggestion from the #btrfs Libera.Chat channel was that "maybe it
can't match a backref with the wrong size"?

Is it possible to repair this filesystem in any way? Can I just delete
these two broken extents in some way?

Best regards

Emil Sandnabba


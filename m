Return-Path: <linux-btrfs+bounces-16641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31FB45853
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 14:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D1A3AE28B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AE1350D77;
	Fri,  5 Sep 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ws25oJ9S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA7350D51
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077098; cv=none; b=HZ/AECXZKA0fQ7kz+mCD3c019GHalFvEINnTDUrJBKUtfjGYoljJagArxYMW5U9X0pCSW3z08lNqjpbiVq3dmsqptDUqyozvABvrxhvl0K4QBcBk+WQKpTWZ1hHau8043STLRpeL4Jjc1NQkoMWI8XLu/00bek12Wn5djEnlrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077098; c=relaxed/simple;
	bh=B4t5lfIeAigVVk9t8Ob6HbXErWQiFE5Us9s4emvtCSk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VDJGqNPVdQSUYv9UKWMhg/N3K5ryGx1uAg5d5E4JDyQPP4NENbiBDV0FB4wDf2w/sa/Gd8hg3A39vSAPPgtfMmC0AyivaB5ZiZc48MQm4FuwAfMViPkMfLUmsWMDkQb0M887gQAswT652ZUvwIInkeYluJG5bPCxsOPQ21zmg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ws25oJ9S; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47175d02dcso1647627a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Sep 2025 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757077093; x=1757681893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JX+UloOjfH7D+sxycIEOtQIvDvV/64rp/Z1H0sQ8SEs=;
        b=ws25oJ9SDRNIKIZ9CkwvB7buUc27BSPN2v4eDfZ/2puZc4b5hjjC5QL9Cpwx5yy/gd
         6pAmiXT8kGQco123HEK1hPL2fWA9sZQc4hRuIFn+d6r/OHbKAySxTD3uUQc8Xto2y9qo
         DH9NTwd+5LhVl7c7k7PDyTHzx1RZFlBpzslwJ+IwwT6XI7bldQ8H8VrosL81yJwHSa76
         EZM3UkMQNWclaqi9tL/ezTt+ColV5BjmOwYFcuu+AP+hXVqKx5J0jRKdPJZcXim40oaS
         pcNPvsbQrsCzzXI/GF3mMR5l2Hse5WKr6GeKDMaZuNnyPMwUQBi4uH+z+GsizShnQrQq
         Igtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757077093; x=1757681893;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JX+UloOjfH7D+sxycIEOtQIvDvV/64rp/Z1H0sQ8SEs=;
        b=diMNXDqSR2XpxBJN8Tqj+agXGEWx1BqRKO4IqWICw3Nwl030h6r3+fdqIFqSKGedBz
         XZ6f2PUqUjdN3yoroNWxwJoYbQywJgzVnUj+7y4EwoadQ3KN7XViQIyGcgjPKFXMtqcq
         5GdON0VJhZAburHxBh8erIMbg/pMUAf5f9NXY5PQw9h58SHNy8pCmN5QoAqAobyb5lEx
         qW/wj6tgKQbe1kFwZiTLRGI3g64JapQUDpvG6eM3deJwk35Jxrh37KjyxlZhd8ocp1oB
         xVu4zkGMGvW9fJ78vlxkZo9LQAypFG0qUOR4A6lRb+PYqd+nHfGlUi7XTpTkSEIlSquO
         yKsA==
X-Gm-Message-State: AOJu0Yz/XqNIShhNAg7ARMnTFX5XIftNCW+tJKPH9MqP3vq3m81rnHuD
	mg9ItIDEc8LiW7HxP3BuRteViAT8cdIXD9/dKWM09S9VbAzUtBFGfod+EZtt1mtuFJcOZVTXHo3
	H13sg+yvaJ5V7UouStlEua7zmFbNB2t9sjm45h5T9s+YS5o/giaJjkB0=
X-Gm-Gg: ASbGncvDzlCSs7gdYW5gK+Ya5NCLrzw0wFHUd6Ouipqu0P5TFqTna9Wbomk1dk1RvQ8
	33QNIe82+JR04xAljYUBdfDy0gZowsuJ8+E6mLWMRsVmU9q19g5Uye4t/0jImO9mkA/eS5JV6g+
	qrOVmgTC0OB70sj3hCWpwwIXhWLYKV43E3YJB13odTVgsIgPPwSjCRn3RLDpf+cttduXevwCUJw
	xjMhDzlyQbW0qT32Uag/BBzALRT35L6cHjbWbCAXfSpVmFSM2A=
X-Google-Smtp-Source: AGHT+IHFc84uQD7HnKhbvnMlVkJWu/UesQwpj5m5QbYQvo39J9ytF/CDHAmibmoLeZCOjeCF7ZgfEj4bm8un2AUlLVk=
X-Received: by 2002:a17:903:3ba4:b0:24a:ceea:b96f with SMTP id
 d9443c01a7336-24aceeabf79mr205950155ad.24.1757077093464; Fri, 05 Sep 2025
 05:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 5 Sep 2025 18:28:01 +0530
X-Gm-Features: Ac12FXw1zyoAY5th54tVc4lJ5HX0a8azkxHLTgbPsqhejM_y90ZgToo_FYVmtlE
Message-ID: <CA+G9fYtsamwXQzuQm4dYNC8kbSJzGAQvZ5mr4BA8X9WE29+yyg@mail.gmail.com>
Subject: qemu-arm64: xfstests crash in bio_iov_iter_get_pages on next-20250904
To: Linux btrfs <linux-btrfs@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following regressions were detected on qemu-arm64 while running
xfstests with the Linux next-20250904 tag. The system crashed with an
internal error in bio_iov_iter_get_pages(), resulting in an Oops during
direct I/O write operations.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

First seen on next-20250904
Bad: next-20250904 and next-20250905
Good: next-20250822

Test regression: next-20250904 qemu-arm64 xfstests Internal error Oops
bio_iov_iter_get_pages

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

qemu-arm64:
Test:
* xfstests

Test crash:

[ 2074.633472] Internal error: Oops: 0000000096000004 [#1]  SMP
[ 2074.639619] Modules linked in: sm3_ce sha3_ce fuse drm backlight dm_mod
[ 2074.651698] CPU: 0 UID: 0 PID: 154238 Comm: xfs_io Not tainted
6.17.0-rc4-next-20250904 #1 PREEMPT
[ 2074.652132] Hardware name: linux,dummy-virt (DT)
[ 2074.652429] pstate: 22402009 (nzCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
[ 2074.652716] pc : bio_iov_iter_get_pages (block/bio.c:1074
block/bio.c:1272 block/bio.c:1336)
[ 2074.701159] lr : bio_iov_iter_get_pages (block/bio.c:1072
block/bio.c:1272 block/bio.c:1336)
[ 2074.701366] sp : ffff800080f83950
[ 2074.701506] x29: ffff800080f83980 x28: 000000000006f000 x27: fff00000c03b9408
[ 2074.701853] x26: 0000000000001000 x25: 0000000000000091 x24: ffffc1ffc153b480
[ 2074.702133] x23: 0000000000000002 x22: 00000000ffffffff x21: 0000000000000100
[ 2074.702421] x20: 0000000000000001 x19: 0000000000001000 x18: 0000000000001000
[ 2074.702710] x17: 0000000000000000 x16: 0000000000000000 x15: fff00000ff6e9a80
[ 2074.702987] x14: fff0000007413500 x13: ffffa44770f6e000 x12: ffffc1ffc0000000
[ 2074.703264] x11: 0000000000001000 x10: fff00000cf850800 x9 : fff00000cf850b78
[ 2074.703510] x8 : ffffc1ffc153ac08 x7 : 0000ffff9626f000 x6 : 0000000000000fff
[ 2074.703794] x5 : 0000000000021000 x4 : ffffc1ffbf000000 x3 : 7878782f78787878
[ 2074.704079] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000001000
[ 2074.704436] Call trace:
[ 2074.704685] bio_iov_iter_get_pages (block/bio.c:1074
block/bio.c:1272 block/bio.c:1336) (P)
[ 2074.704971] iomap_dio_bio_iter (fs/iomap/direct-io.c:437)
[ 2074.705167] __iomap_dio_rw (include/linux/uio.h:228
fs/iomap/direct-io.c:530 fs/iomap/direct-io.c:559
fs/iomap/direct-io.c:729)
[ 2074.705331] btrfs_direct_write+0x1f4/0x3bc
[ 2074.713828] btrfs_do_write_iter+0x18c/0x1ec
[ 2074.725568] btrfs_file_write_iter+0x14/0x20
[ 2074.725936] vfs_write (fs/read_write.c:593 fs/read_write.c:686)
[ 2074.731508] __arm64_sys_pwrite64 (fs/read_write.c:793
fs/read_write.c:801 fs/read_write.c:798 fs/read_write.c:798)
[ 2074.731822] invoke_syscall (arch/arm64/kernel/syscall.c:35
arch/arm64/kernel/syscall.c:49)
[ 2074.737438] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:132)
[ 2074.737885] do_el0_svc (arch/arm64/kernel/syscall.c:151)
[ 2074.738235] el0_svc (arch/arm64/kernel/entry-common.c:879)
[ 2074.785073] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:899)
[ 2074.785245] el0t_64_sync (arch/arm64/kernel/entry.S:596)
[ 2074.785643] Code: f9400fea d2820000 7940c377 f8795943 (f9400462)
All code
========
   0: f9400fea ldr x10, [sp, #24]
   4: d2820000 mov x0, #0x1000                // #4096
   8: 7940c377 ldrh w23, [x27, #96]
   c: f8795943 ldr x3, [x10, w25, uxtw #3]
  10:* f9400462 ldr x2, [x3, #8] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: f9400462 ldr x2, [x3, #8]
[ 2074.786668] ---[ end trace 0000000000000000 ]---


## Source
* Kernel version: 6.17.0-rc4-next-20250904
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250904
* Git commit: 4ac65880ebca1b68495bd8704263b26c050ac010
* Architectures / Devices: qemu-arm64
* Toolchains: gcc-13
* Kconfigs: defconfig+xfstests
* xfstests: v2024.12.01

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/29762004/log_file/
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250904/log-parser-test/internal-error-oops-oops-smp/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/32E6ypoTqaDjAEJISuUAAgkPUva
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32E6us2qcXmnop3jTYQMOB9eVPt/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32E6us2qcXmnop3jTYQMOB9eVPt/config
* xfstests: https://storage.tuxboot.com/overlays/debian/trixie/arm64/xfstests/v2024.12.01/xfstests.tar.xz

--
Linaro LKFT
https://lkft.linaro.org


Return-Path: <linux-btrfs+bounces-1296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C139382678B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 05:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B943C1C20B9F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 04:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61510849C;
	Mon,  8 Jan 2024 04:14:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9797F;
	Mon,  8 Jan 2024 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxvruKdptlWgcDAA--.1620S3;
	Mon, 08 Jan 2024 12:14:02 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxK9yJdptlT_QGAA--.18279S2;
	Mon, 08 Jan 2024 12:14:02 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Denis Efremov <efremov@linux.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: send: Silence build warning about kvcalloc()
Date: Mon,  8 Jan 2024 12:13:51 +0800
Message-ID: <20240108041351.9847-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxK9yJdptlT_QGAA--.18279S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1xtFy7Jw1fJrWkCFWrCrX_yoW8Ar1fpF
	4fGF15tr4rZa4kX34xKw4S9r1Sq3s7K3y7t397Zr4aqr1xuFWkGFs0y3y0qr1qyF97ZFWU
	ZwsFg3WUC3WqvabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=

There exist the following warning when building kernel v6.7:

  CC      fs/btrfs/send.o
fs/btrfs/send.c: In function ‘btrfs_ioctl_send’:
fs/btrfs/send.c:8208:44: warning: ‘kvcalloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
 8208 |         sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
      |                                            ^
fs/btrfs/send.c:8208:44: note: earlier argument should specify number of elements, later size of each element

tested with the latest upstream toolchains (20240105):

  [fedora@linux 6.7.test]$ gcc --version
  gcc (GCC) 14.0.0 20240105 (experimental)
  [fedora@linux 6.7.test]$ as --version
  GNU assembler (GNU Binutils) 2.41.50.20240105
  [fedora@linux 6.7.test]$ ld --version
  GNU ld (GNU Binutils) 2.41.50.20240105

just switch the first and second arguments of kvcalloc() to silence
the build warning, compile tested only.

Fixes: bae12df966f0 ("btrfs: use kvcalloc for allocation in btrfs_ioctl_send()")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 fs/btrfs/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4e36550618e5..2d7519a6ce72 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8205,8 +8205,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 		goto out;
 	}
 
-	sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
-				     arg->clone_sources_count + 1,
+	sctx->clone_roots = kvcalloc(arg->clone_sources_count + 1,
+				     sizeof(*sctx->clone_roots),
 				     GFP_KERNEL);
 	if (!sctx->clone_roots) {
 		ret = -ENOMEM;
-- 
2.42.0



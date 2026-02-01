Return-Path: <linux-btrfs+bounces-21269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TaJiBRv9fml9hwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21269-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 08:13:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F7C5189
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 08:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60AB73015D10
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Feb 2026 07:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3942E339B;
	Sun,  1 Feb 2026 07:13:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692A21DF987
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Feb 2026 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769930002; cv=none; b=cjhW5mloKLSumCXbRzl7dAGEvS06Cm4uSCkMXOkR2B1+LBejDceNeMaMwl9daaLIzyJlWjQ6ELaFgCXfNLu6UIZ/O/lSDvGFZ5YjAo/tZPsy9FQ5JKMiLApl/RFSslwwQyXJk80Vx3NR8K3RnFFQjVuBARetpnY0i0oSkhthb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769930002; c=relaxed/simple;
	bh=BkzrcFCFhmpVXH0wF/TJCLA3t6L+J18m3pfmUDygols=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WT/R6bHpfDjh07NZNw7P6PnLq/lUL77C7bRag1eGORUChIiyDD1DZ2LaEpph3TRIE8fCz0sJlrad3y/oRzY8JkU69S0ik2fsMk24rMK5QQl16TYq/JfWieZHNTwXdrwQsrQbhpH+/HsVp94IJFZO5Atp6PMu9kr1Qd9y/6r87Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from [192.168.1.29] (unknown [112.45.178.9])
	by APP-03 (Coremail) with SMTP id rQCowAAnSeAJ_X5pSJ5rBw--.18706S2;
	Sun, 01 Feb 2026 15:13:14 +0800 (CST)
Message-ID: <914f64a8-d51c-4424-97dd-f8b917e72acf@mails.ucas.ac.cn>
Date: Sun, 1 Feb 2026 15:13:13 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Qiyu Yan <yanqiyu17@mails.ucas.ac.cn>
Subject: [BUG] ZONED: Transaction aborted (ENOSPC) during auto-reclaim/balance
 on 6.18.7-200.fc43
Autocrypt: addr=yanqiyu17@mails.ucas.ac.cn; keydata=
 xsFNBF6yAhQBEADsMD+lk6hzk5Cr47oC/LdvnMrX5YULzcBcSBj+MJ+mWxQajQRIripNMU0Z
 08SvopYr/WNhqFRy+f+DdBVuUGKqzmXJ2Hy3FI2raaXueJllxCuxjyUT6D/EWDaC26NOVfbF
 bJ2qZkksSJniHmwjYVq160o9bTNSNMsm6ZkKcZfbI/K+qUgF7R1GalxYSHZzDNomN5AExJ85
 2Aou8tfPW36brFR5P2s98NZ2mZP4A8uXPcZEXyTXNudwqxF+bh1/awnx5rBZr7iylLcjgxgF
 29GNG4TvuX9EdXWEoemn5TLix94AJBtQyczPZ/aCDjyN2fCl6u2/SveBP1wDztmYnKqsyq+N
 PhuC5DtqfSRhc+9+Xq215WCKPjdSYIAXaqbjcDILbNb/MDsH29E9M4AyUydLtrQ65+hhnTXb
 mFFTHJln/MO7bnixaPrkIe1eTzXFub08nhcKQKZMLZa9Q3wh+rc8cIM4RqOnvEC0WHTz6M75
 ZskKq4kyVw2MgkHfRTCQyKQeSSqfF4Pbvnn5eCIWFBC0iCUHtz40zcmEu7XfVTGsPtSw+COw
 ZE2//mtqQk0myvGOXpzDbuVWdqPDCTF7X4v6QAiT5szp+W21Gk3FqVXumOqn/ot9qsvJfF5V
 lNXl3ZLG2Iygu9mtKtMw//SYVkarq0by/FhNpoOImD6ohPIFLQARAQABzSVRaXl1IFlhbiA8
 eWFucWl5dTE3QG1haWxzLnVjYXMuYWMuY24+wsGOBBMBCAA4FiEEqTvseg9oLPtAXDDoT8kU
 8GXy3xIFAmBt0m0CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQT8kU8GXy3xLg6g/7
 B2TADItiQn0WA/OuhJRt2p3xBz/FMZlpq6yuF5tPLbQ6PHS/D+fZd9shVHb1mjnL3/FdtVdo
 Y3aYVymbVR0vQoeleCQzT/EORVdikjq6aXBHOGqWVmttP5FfjyEF18nTgVoGBJUgTMwPUwWY
 gyQKsYUa8LOOg9THpWFCLado7qCdOT8NHKAViNe6EZMoYprJJK0Hrt8xGXgdCB4G8r+N0dFn
 dm3ymTpFmYyC7hwgPfR80mVXP6PVpmBlWrpG1DQN4b2J+KlvyQFxkYeW4+qCItmfWNI7BS4B
 OpkDUmN4hEpAwkTJnfs/uOhkAdC0tf0rH9lHJgGWvmsqjN9KItauKuHOMuSFmOaZxirsH4++
 gtE1qFoYorvr2xv/zP/MPtg8LrqRJdLRHGfhnIGcrOG0yobXF4kuIhcb0UZ5ikdgly/lwf4+
 Po6BxoM2i4DjX+ntp05ZYxf+3cWai0r/IPQ+qT8TJwg5Zudkw0l05uVlz+jbyPuVourKXlmg
 vEEcKy0ERO6X3qqJnAP6m6hp3ocE98eKrCEA7/b9FTC1MJ/9z6PKCRokdazvr+NGg/IgGqsf
 pxtK5sCxeff9MD4nksawrTBm/sl8UA+NKmzjbufSW31P9EUlQWk/ESxhGKtx/RZTuvzsOmIW
 o9GmW43W0B7+D4OgnscOGdmWW92ajwhuQrHOw00EaKbUDxAQALWqC0Y1CAtBN+IBWhd4ZuzA
 5tCoFYASM21kBgcn5SnnVgAUFGDoNDFpMJX7PVVkHyDWnmggo0sbMrnUv3IFKbn3A8uGCoit
 8UtpVWQEerFk4oT3TwBXiLUuUI83eBwZHY+dfTP/0J3nmd//IuJYoCnczSIXhAl3s62KAL5H
 vsIhqJyxPubi7EdrJmlO3IEUyUq0AONNvxQqeKNgZ6siWvec4Dp5VcVDGHXD4KziCliRtqyl
 z986GqvTQSnUX9rc+HXlPnA2T9mO0KEupeLnfB+4l77QeXi+dtC8+Y7gvJcWmTmQyco+Ubwk
 47TW7mvIFm5J2hUzJMWvduiRquQSvoDVGIXYXv7rSdf8rCVUQcB+vREBCoEGi7gmZSB8moVh
 NJdopMosy4LsusdW5I8guN7eTeJ1UQ/PWT4KpLjCPAO36yaFdgZIWvlJH3Acg9zaAhaJa82w
 W9itjFBRmeIKONw9kgcE8LUQIgrCIqnPxPU1JOLZxwL8Sc320BrgDmkX0bVjZn2R/v6AFhzV
 0LxujJhjD2c+maHDen6o43308fz9mq4dKsf7NNPYDFYPjh2MAH6CoOddE2ZRXxRY1Hr2Fqab
 4p1ClU2x9WObiPLLc/efvmQqq7y3iIDGXdwrmLT8N6YJ5fSgcWOBMgI1kf/csQVkO6ZANNEL
 nNADKDWtnnX3AAMFD/0TqhE51rmEcMyluHQGevXBLOKzmadMe2AQWFSAN8fosILPzjTNWPZw
 F/DEh1m7iF1GNjPyQwd0l8Hw54wBcNz2VtUXRglusxk/uLxVFHYGJkO+Y6yI26AXkKxV1cc9
 5uwBIn7w8h2CF90tAfR3B1Lj/HZbksqjiOMA7VRo5p9i3XXmyZvRYuJnGKM7fCjR2mySPKwY
 Cw+zuqR6ysVy9xzdVpi14Z4iTxyLR1FzrIJrhkezxHeCvjkJa4mGWsED59Jlo0EI/Xn/p5ts
 TvR9A6mM6zzMOexWfS1tc4wTnQHp8ERrpoDUOPWq2KEDI2hhoV4iXpx/zvd9IAx3v7n5Db6n
 WVhLrNjDao2GaNJyMMFF2YBAbdI+Z2eQ9ekirG8+deV3nFr+pjTmZB6MjcvNDN8tsWWwwt+Y
 L6Ynt3Au8V0tFkW+d64aR/qiuSvgrck9ecsRnWGXd0f8FduyXEGvBffjJ4TDkax6rTFMTwN6
 qmMtEAuZp5RdXx0DF/evYJRCfQBHna5PWKK0Bq1iT7GlxrtOGRJDsKhZ4Q1AWW0J3nPf+6ih
 /5Od/ktijtLdpehOwgWltAUHqqsIj4m5Gjpp9o8h81DlhSJXnj40OKHoIwXnfXrlyuC1gr65
 SZY96PgeDXSDjJAcEeMGYY0yOeEuKMCCNZnNkGOmV+BDQOf7MSzHWsLBdgQYAQoAIBYhBKk7
 7HoPaCz7QFww6E/JFPBl8t8SBQJoptQPAhsMAAoJEE/JFPBl8t8Sh0YP/0YBzPfHRI4QnrhS
 Ybt4gg51OuHoMtQyLP8NRNGwxv01MOc9dvhVMOZZAg8seGkYLvix4wXkEyHrea1Up7SgDvkn
 sbPCIWJlMQ71yXMS5gcD+l7S91TgKkh6TZbc8jd5l32cGj8bFaXqOcp/YPZAFdFDxCm5wV5S
 tyu8hR72NkY2tXAcvll7moqbPxoYWksKU9kh+RyPGAgNKFj7G5mtr8PNXMyAYalNoXvxczc/
 xH2xB7g/g+JdtAe9L7FoWpiCjPfbMwBjemqoKP8qZpyV37l9Pt4hCx3fVjJ+3OPigK6AEETG
 /Zzo29/0wI812uCAv2hZAwIQ2g4sygg9ix8pHlKnE8MWQV4Ki5b+iUy5hw0bhgPuWey0VQ0U
 9z+DhOzlh1Xc5ovTV0euTzjKewQqvx9OdrdjQQGaqAPQZQdWo7abz09DOKi34v8FqOtg9HXu
 f7IdcAUtjdToLGl/DfzmP+IanGlIeuEWQq1hScY1FJDYY9V9LrXk0q01Bd9t3BLecN6yHoL1
 hXnjz4z6GS3txAYPrQNCfrYqpTmUG5h6AH3lXXW5mSZkVtf0MyptIc10E6m6K3/XhVxLgjRO
 3Q49gUhfmmPRFHu5YX8SyBxVj39EC1468s8N3cHzmhorYPHTz+QOKa8fEdPxql2Lbc/7K1de
 Ywog7hj32UG3g6tAUN7D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnSeAJ_X5pSJ5rBw--.18706S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1xZryxuw48ArW3KFW7Jwb_yoWrKr4Upr
	yfAF1akryUCwn7CFs3Xw4DW34kGw4kXw45Wr9akFnrJ3W3Ar4YqFZ8ZryF93yDtrWrA3W7
	Ar1Dt3W8Zr43C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67x2
	8xkI4xCE0xIEc2x0rwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0pRvD7-UUUUU=
X-CM-SenderInfo: 51dq1xl1xrlqxpdlz24oxft2wodfhubq/1tbiBgoFB2l++I0FYAAAsJ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[ucas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanqiyu17@mails.ucas.ac.cn,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21269-lists,linux-btrfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mails.ucas.ac.cn:mid]
X-Rspamd-Queue-Id: 904F7C5189
X-Rspamd-Action: no action

Hi all,

I am reporting an issue where a Btrfs filesystem on a zoned device 
forced itself into a read-only state due to an ENOSPC error (-28) during 
a background block group reclaim/relocation process. The related logs 
can be found at: 
https://gist.github.com/karuboniru/4eb8835507f97a6d57f4addf25fab7f7

The environment I am on is Fedora 43 with kernel 6.18.7-200.fc43.x86_64, 
the drive is WD HC650. The issue happened soon after after upgrading to 
6.18 series from 6.17.

The system automatically started relocating block groups (via 
btrfs_reclaim_bgs_work). During this process, a transaction was aborted 
with errno -28 (No space left), despite btrfs filesystem usage 
indicating significant unallocated space and free capacity.

Best,
Qiyu

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
BTRFS: error (device sda state A) in __btrfs_free_extent:3237: errno=-28 
No space left
WARNING: CPU: 16 PID: 472499 at fs/btrfs/extent-tree.c:3237 
__btrfs_free_extent.isra.0+0x49d/0xc80
BTRFS info (device sda state EA): forced readonly
BTRFS error (device sda state EA): failed to run delayed ref for logical 
46726206365696 num_bytes 4096 type 184 action 2 ref_mod 1: -28
...
  ? srso_return_thunk+0x5/0x5f
  btrfs_run_delayed_refs_for_head+0x2b0/0x380
  ? srso_return_thunk+0x5/0x5f
  ? btrfs_select_ref_head+0xda/0x140
  __btrfs_run_delayed_refs+0xb8/0x140
  btrfs_run_delayed_refs+0x3b/0x120
  btrfs_start_dirty_block_groups+0x30a/0x5b0
  ? kmem_cache_alloc_noprof+0x14b/0x5a0
  btrfs_commit_transaction+0xb1/0xd20
  ? srso_return_thunk+0x5/0x5f
  ? start_transaction+0x228/0x840
  prepare_to_relocate+0x135/0x1d0
  relocate_block_group+0x6b/0x530
  ? srso_return_thunk+0x5/0x5f
  ? do_zone_finish+0x372/0x400
  btrfs_relocate_block_group+0x256/0x450
  btrfs_relocate_chunk+0x44/0x170
  btrfs_reclaim_bgs_work+0x428/0x570
...

BTRFS info (device sda state EA): dumping space info:
BTRFS info (device sda state EA): space_info DATA (sub-group id 0) has 
216444928 free, is not full
BTRFS info (device sda state EA): space_info total=12228040327168, 
used=10905359462400, pinned=0, reserved=0, may_use=0, readonly=0 
zone_unusable=1322464419840
BTRFS info (device sda state EA): space_info METADATA (sub-group id 0) 
has -34808119296 free, is full
BTRFS info (device sda state EA): space_info total=918049259520, 
used=64758857728, pinned=147456, reserved=1421541376, 
may_use=34808119296, readonly=239616000 zone_unusable=851629096960
BTRFS info (device sda state EA): space_info SYSTEM (sub-group id 0) has 
196608 free, is not full
BTRFS info (device sda state EA): space_info total=268435456, 
used=6455296, pinned=114688, reserved=49152, may_use=0, readonly=0 
zone_unusable=261619712
BTRFS info (device sda state EA): global_block_rsv: size 536870912 
reserved 536870912
BTRFS info (device sda state EA): trans_block_rsv: size 0 reserved 0
BTRFS info (device sda state EA): chunk_block_rsv: size 0 reserved 0
BTRFS info (device sda state EA): delayed_block_rsv: size 0 reserved 0
BTRFS info (device sda state EA): delayed_refs_rsv: size 4676581195776 
reserved 34267054080
BTRFS: error (device sda state EA) in __btrfs_free_extent:3237: 
errno=-28 No space left
BTRFS error (device sda state EA): failed to run delayed ref for logical 
46726206337024 num_bytes 4096 type 184 action 2 ref_mod 1: -28
BTRFS: error (device sda state EA) in btrfs_run_delayed_refs:2161: 
errno=-28 No space left
BTRFS error (device sda state EA): error relocating chunk 48256373489664

$ sudo btrfs fi us /run/media/cold
Overall:
     Device size:          18.19TiB
     Device allocated:          12.79TiB
     Device unallocated:           5.40TiB
     Device missing:             0.00B
     Device slack:             0.00B
     Device zone unusable:       1.98TiB
     Device zone size:         256.00MiB
     Used:              10.04TiB
     Free (estimated):           6.60TiB    (min: 3.90TiB)
     Free (statfs, df):           6.60TiB
     Data ratio:                  1.00
     Metadata ratio:              2.00
     Global reserve:         512.00MiB    (used: 0.00B)
     Multiple profiles:                no

Data,single: Size:11.12TiB, Used:9.92TiB (89.18%)
    /dev/sda      11.12TiB

Metadata,DUP: Size:855.00GiB, Used:60.31GiB (7.05%)
    /dev/sda       1.67TiB

System,DUP: Size:256.00MiB, Used:6.16MiB (2.40%)
    /dev/sda     512.00MiB

Unallocated:
    /dev/sda       5.39TiB




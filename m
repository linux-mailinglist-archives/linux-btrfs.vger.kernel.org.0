Return-Path: <linux-btrfs+bounces-11989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86B8A4CCC5
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 21:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACE1161753
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 20:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E4B2356BD;
	Mon,  3 Mar 2025 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MfyNYO5R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72E1EE7D6;
	Mon,  3 Mar 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033915; cv=none; b=YidRT7Xc6aqdEwELvn2oEtQASwHZGu1tQ2bcoVWmPo0ZvM8aowH4OohcY1MPa2eSxyRA2YkVFkiVNGZsoYzprS1wLVbzw/dHeJcjqUBSDh6I850R07vkffXMqzMtKyqeyVDRxKrGS9gsILMRQnB0D81v3b/tFuyq0IP5zF2iH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033915; c=relaxed/simple;
	bh=tJzwP9V4sBzOTaR6IgBXslaBwnRtpEy2L/p+HucBL0M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qb3b4Pzrf3pxS7WrjxorqKAuHLGkXCfw2X2DW+zHBXGYWzvvNnEuTMJfEsN4Y1EihENLtcoDXwdwVOnsTbx5kKjaIZZOAAVKvEu2w1JhAAfBkPfimnSn32iobyDRmVRX1IFGj/Q94eQU8ndhwif8gO+wVg81/7TTxcOEW+sDQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MfyNYO5R; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741033907; x=1741638707; i=markus.elfring@web.de;
	bh=D7+bOdSKzrxQTuFq1CY/qx2E6hue+i+kR6PvAKN6CDQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MfyNYO5Rf1IJaR1bl+5D5IsmJseNDY+YIie8758fLsUuri15hqT7OmtuxDBDLEkr
	 +b2BCWTckRH7iqlAQsSswvQPN3R7GzupXlX+wUGPpM0ZB9UGMBQNVqFZcgJVsj5Mm
	 KQpBNZjng1tLYogquBk5m1qen5lw6p+qtHxYR0vhEGaMPMvG3z08f3UvjxbxmxtT2
	 Nf5PRQUo/JgcvqQv9n+tEvS6guLUTKrVj9gytk75E/w7Bd5LxIAQqtflav8oL4CnK
	 Sd342HevHymEA2CHayV1yciCAlvHtqGvs7TXLCJNoVAPP3hMNGCO5LNK7CxPAO1m0
	 MBC0/Q1C8TIvuRnShw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi537-1tKnNS2NY9-00ZvTN; Mon, 03
 Mar 2025 21:31:47 +0100
Message-ID: <09fe60d4-8eda-42bf-b2d4-ada265a09ce5@web.de>
Date: Mon, 3 Mar 2025 21:31:46 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] btrfs: Fix exception handling in
 relocating_repair_kthread()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Naohiro Aota <naohiro.aota@wdc.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <cebfc94f-8fdb-4d5c-56ee-4d37df3430a1@web.de>
Content-Language: en-GB
In-Reply-To: <cebfc94f-8fdb-4d5c-56ee-4d37df3430a1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:csYVwvzlghPepZ2AyyY46eRwA8AS8BMfd7Ao//GWrCPl1A/GPLx
 yj8777LveO9YiAnzu+Isjxx46A/wzaMMh4+Mei0pWllSt1K7tKExTVXsM1jRO4mBZ/AFap4
 ZGQs5wk/ZupNx4PS4mkNzeZlE2UBN+JxipFft3d7SY6vJRyW8vLluaQ1AImETEakmh45VRP
 Qh6fvi0Yl43mkeYhbF9vA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TMOfPqAf9qA=;q6Vge51zuOVBjj6nlCJUUhQUdU5
 fGQgPLo6XTWTDAkVhVwF65N5FuyhGq2NGBUKuAKpsL5xruexqlo9wDpJLIkd0Er+Gj0Oj36TQ
 qtNlBd65iIADb1O0lrufmP8uug54EEa04vRvN+xQWhqV8UQCnsdiU814FHCz6DsJ0UtYyzJbF
 BmZs6xXs+MYDbxFBA9IaB5F0+MLFu/w1FSxqWhHAg3XXUyAshRr8qUe7HSiCIOucpc+c9eQml
 GLDInfjUYHTdf41sUjyIy6FFAiCPmntplZxo9IiZld5sNhtqxZvsu3yE19eZWgup9QqlmYwzY
 amHpLBDE7qUw7VmqVG4VZCoBrmuDZRzNYBj+4OzXYXDdicXl1PUNgLx8M5F4SR4cTg9QH5vgu
 MXvgbZVNtLAg9vVqpkfsQnfr3yw+FTmWpA2I0acyw5oIPf7a6eMEUy2c3jiih9FrBW7oSsK0G
 v6gtT22jHTg/PZfwVya/yY/rT0UDVB0H6UlUUQTPrmbahyshOiC8rKFDkSWW4c+GLY1MgVKli
 6jOYCXqlB5AQt4+PLrqPUj0/Ucvma26rreL+Cti1W5jbAK7C2Fenx3hOIZH4dnNxL/3Ye8zww
 w6ZM4WZJV/YZN2ZQ0mrt8Ap1BSeIhMal2YKFr+3UUDlnPa8D/d8HO9TYQ9xr7Bom6MXyIzrfp
 2fT4SwGNWHYEMrxM/rvxBdm1Yid1g/qMseGcvRhxrFIN/vbEDH4sB7FRm+gteBwzvZtwAkaPI
 2e1ZIBt+DjE0LmcdJX4ai8WwlMmB+Pju42Vyb3rNDILrFIhgIPg6Xu9V9OP4qOgkidl0v7KjI
 1z2DjNe38lZYZUBbDLgAZaAuLXwNkPt7WqqaX4OC1bVsJhBCjbCyOrmIpqW7wVaEB0Z8SVrNH
 A4vYDcUtAOsHsaPTOMwcX9jHjIkEsqgyElixVLifECkKlq7xD5k7msNrJtuGSEH1czrK7gx4A
 0nIlsiRqJclYGptiA9q0zgkVGNOmttbzjPju2W6QZ+EKG+8hmnOUH0TS3nd1RoclnNmN3VAxC
 AfiugjotANNOOlu3IVDcVFTIoN88hr6CIN3lL/oahQybP9DnBHn36V2oA3DVC7JhLyok0aqhG
 vOkmyoDCUTkXwLKwFoeiG+WAU77hoZ2TYajr9DzzJk4ex//bD1H9mM6NkfRSMXvhJJzVBQuQj
 yZ4HEaT5uWlBNkW8qstMSP0eJLWVnyIJKzwTdCZaXTyCd0Swy1Zz84t23pIqBvhhKiK7+qjyi
 oYvNUgWfDCEgnFLLMrVQBTafJnzQcWA26U7x8nAvgbgnh1LWJjz1efS0OkvZGsy0ZpmW4xNpD
 bM/AQFk+Bj2wu1CMvfQmwFVz9hIg0fbKB8IrguRNvpX7CWOohqK4k1OaXX/+tNwhhVqyPxxKt
 s0EoBnfB4elxaDNOEGmszmfuifIALAgtqdyyHDY8zZXVvk3QpybaW9NEE04LuBuqORZBy23he
 XMXkYjdnk2mY8Xg2G65K84lm6f0g=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Mar 2023 20:10:09 +0100

The label =E2=80=9Cout=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function
=E2=80=9Crelocating_repair_kthread=E2=80=9D that it was determined already=
 that
a corresponding variable contained a null pointer because of
a failed call of the function =E2=80=9Cbtrfs_lookup_block_group=E2=80=9D.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: f7ef5287a63d ("btrfs: zoned: relocate block group to repair IO fail=
ure in zoned filesystems")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/btrfs/volumes.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6d0124b6e79e..de11ad6c8740 100644
=2D-- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8096,23 +8096,22 @@ static int relocating_repair_kthread(void *data)
 	/* Ensure block group still exists */
 	cache =3D btrfs_lookup_block_group(fs_info, target);
 	if (!cache)
-		goto out;
+		goto unlock;

 	if (!test_bit(BLOCK_GROUP_FLAG_RELOCATING_REPAIR, &cache->runtime_flags)=
)
-		goto out;
+		goto put_block_group;

 	ret =3D btrfs_may_alloc_data_chunk(fs_info, target);
 	if (ret < 0)
-		goto out;
+		goto put_block_group;

 	btrfs_info(fs_info,
 		   "zoned: relocating block group %llu to repair IO failure",
 		   target);
 	ret =3D btrfs_relocate_chunk(fs_info, target);
-
-out:
-	if (cache)
-		btrfs_put_block_group(cache);
+put_block_group:
+	btrfs_put_block_group(cache);
+unlock:
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_exclop_finish(fs_info);
 	sb_end_write(fs_info->sb);
=2D-
2.40.0



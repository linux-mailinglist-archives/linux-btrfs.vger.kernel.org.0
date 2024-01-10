Return-Path: <linux-btrfs+bounces-1358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3CF8295F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 10:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C631F25E4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4B3C470;
	Wed, 10 Jan 2024 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="2oSpQ4Iw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD711113
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1704877943; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R2ho+FIwoT3B6tM6rKdIWqKvm4DW07Hgu51SFAIqtQjgm3kbdHKfzmnRKvEaT1DTdYN/ZKyfV9IU2ztseYqrKp3qLeLDcFS06N8i+MxmHIc51xsXv5dZnwVOi5WlTf1VGoa++ohtEJYgf7tjHa13Wn+ALY/IfPE532ZiZT+wyOs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1704877943; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=oex1cbe/0sQ7hCsFMsDoOEF+3GdrsRXQQNsdXD6z4Bc=; 
	b=HM/Cut+tQwS8FBgvQOZAox0upqsUlBMBDVHiCpPcTvWW1lhW1iZukOnbksuF5+QE3U2GO427+smAU5GBj4CAe1CJvGBUoVn8gKBQ9nxI5iHOoR9yrkB4uH4AjyoL+d4x3E34LZu4Y2jqeAj1a04uD5Ne5jR+9LKeBSSnvuq7qiU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1704877943;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
	bh=oex1cbe/0sQ7hCsFMsDoOEF+3GdrsRXQQNsdXD6z4Bc=;
	b=2oSpQ4IwCxHpWYzm0V/MwPIwfTZx8rB9JDfr7UI86cDltrJ5xFYFH5TinE0BYi3l
	7wZ45kzYjVXnMASb8eb3aFh99cy0axXbBUzB4wiwC3lHDUu9qAZXYlC8Ox7lQoDMG6t
	7s2/k4+GrdnjN09hsFvirGcV/FnhIJxcI1iS5Q+c=
Received: from [192.168.8.156] (149.248.38.156 [149.248.38.156]) by mx.zohomail.com
	with SMTPS id 1704877941943916.154720506389; Wed, 10 Jan 2024 01:12:21 -0800 (PST)
Message-ID: <b10d90cc5eb4f49eabfe3cc0df92ef40b64428b0.camel@rong.moe>
Subject: Re: Scrub reports uncorrectable errors with correctable errors
 unrepaired, but all files are fine
From: Rongrong <i@rong.moe>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Wed, 10 Jan 2024 17:12:18 +0800
In-Reply-To: <27fb4ed5-c3ce-4ab7-a3fd-d77dc8dd4fb2@gmx.com>
References: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
	 <27fb4ed5-c3ce-4ab7-a3fd-d77dc8dd4fb2@gmx.com>
Autocrypt: addr=i@rong.moe; prefer-encrypt=mutual;
 keydata=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
	cMTsfqztU+orM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Wed, 2024-01-10 at 07:49 +1030, Qu Wenruo wrote:
>=20
>=20
> On 2024/1/10 04:36, Rongrong wrote:
> > I guess the root cause of the issue is that one of the DUP metadata
> > copies was somehow corrupted. Am I right?
>=20
> I don't think so, I think there may be some false alerts, either from
> kernel scrub interface, or btrfs-progs.

OK then. But I just wonder, if this is the case:
Why `btrfs inspect-internal logical-resolve [LoC]` returned a file
instead of ENOENT?
Why `btrfs inspect-internal dump-tree -b [LoC]` returned checksum
mismatch instead of invalid mapping?

> > I am to confirm:
> > 1. is this behavior (false "fixed up") of scrub intended?
>=20
> Nope. Considering "btrfs check" and "btrfs check --check-data-csum"
> is
> totally fine, this should be a bug related to scrub.
>=20
> > 2. why btrfs check finished without error under such a
> > circumstance?
>=20
> Because that is probably the real case.
>=20
> > 3. since all files were fine and btrfs check finished without
> > error,
> > should these "uncorrectable" errors be actually correctable?
>=20
> I believe it's some bugs, either from scrub functionality of btrfs
> kernel module, or btrfs-progs reporting.
>=20
> Would you please try the following?
>=20
> - A different btrfs-progs to do the same scrub
> =C2=A0=C2=A0 To rule out some btrfs-progs regression.

`btrfs scrub start -RBd` with btrfs-progs v6.6.3 and v6.3.3, no
difference.

> - "btrfs scrub start -RD"
> =C2=A0=C2=A0 This shows the raw data reported, including where the corrup=
tions
> are
> =C2=A0=C2=A0 (data/metadata, and scrubbed bytes etc).

Did you mean `btrfs scrub start -RBd`? If so:

Starting scrub on devid 1

Scrub device /dev/vdb (id 1) done
Scrub started:    Wed Jan 10 14:00:57 2024
Status:           finished
Duration:         0:35:50
        data_extents_scrubbed: 21561913
        tree_extents_scrubbed: 313438
        data_bytes_scrubbed: 1128612171776
        tree_bytes_scrubbed: 5135368192
        read_errors: 416
        csum_errors: 0
        verify_errors: 0
        no_csum: 0
        csum_discards: 0
        super_errors: 0
        malloc_errors: 0
        uncorrectable_errors: 248
        unverified_errors: 0
        corrected_errors: 168
        last_physical: 1994106359808
ERROR: there are uncorrectable errors

> - Do a readonly scrub on a readonly mounted btrfs
> =C2=A0=C2=A0 Just to rule out any write-time races, which can help us to =
pin
> down
> =C2=A0=C2=A0 the possible cause.

`btrfs scrub start -rRBd` on an ro mount with btrfs-progs v6.6.3, still
no difference.
In particular, I still saw "fixed up error" in dmesg.

> Thanks,
> Qu

I have more to say. There is actually another bug that can lead to
kernel oops. Due to the bug, these requested tests were done on a
patched kernel.
I considered it should be a different bug so I decided to firstly
discuss the case that scrub can successfully finish without oops in
this thread, and planned to write another detailed bug report in the
following days. Since I used a patched kernel to finish requested
tests, let me make a brief description in advance:

Oops usually occurred when the scrub progress is 1~30%.
Bisect shows the buggy commit is
ae76d8e3e1351aa1ba09cc68dab6866d356f2e17. Any version comes with the
commit or have the commit backported should be affected (in my tests,
6.5.4, 6.6.10, 6.7). 6.4.15 and 6.5.3 was fine in my tests.
The version of btrfs-progs was irrelevant.
Oops can be either (quite random):
- unable to handle page fault (not-present page)
- general protection fault, probably for non-canonical address
- Kernel BUG at __blk_rq_map_sg (block/blk-merge.c:584)
- (RK3399) Unable to handle kernel paging request at virtual address
It was reproducible on:
- Intel CPU (i7-7567U), host, intel_iommu=3Doff, SATA HDD
- Intel CPU (i7-7567U), host, intel_iommu=3Don/off, loop (disk dump)
- Intel CPU (i7-13700H), host, intel_iommu=3Doff, USB-SATA HDD
- Intel CPU (i7-7567U), KVM, virtio-scsi (disk dump)
- Intel CPU (i7-13700H), KVM, virtio-scsi (USB-SATA HDD)
- AMD Ryzen CPU (PRO 4750U), KVM, virtio-scsi (USB-SATA HDD)
- RK3399, host, USB-SATA HDD
It was not reproducible on:
- Intel CPU (i7-7567U/i7-13700H), intel_iommu=3Don, (USB-)SATA HDD
- AMD Ryzen CPU (PRO 4750U), host, amd_iommu=3Don/off, USB-SATA HDD

Removing the usage of blk_plug in submit_initial_group_read
dramatically made the oops disappear.

Again, I aims to discuss the case that scrub can successfully finish
without oops in this thread. But due to the above oops, to make it
easier (scrubbing on HDD is painfully slow), all the above tests was
done on "Intel CPU (i7-7567U), KVM, virtio-scsi (disk dump)", and Linux
v6.7 **with the below patch**. If you consider I'd better do the tests
without the patch, would you please tell your preferred test
environment?

(PS: if the above information is enough for you to fix the oops, please
tell me so that I don't need to make another bug report)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f62a408671cb..62695b9aee07 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1768,14 +1768,11 @@ static void submit_initial_group_read(struct scrub_=
ctx *sctx,
 				      unsigned int first_slot,
 				      unsigned int nr_stripes)
 {
-	struct blk_plug plug;
-
 	ASSERT(first_slot < SCRUB_TOTAL_STRIPES);
 	ASSERT(first_slot + nr_stripes <=3D SCRUB_TOTAL_STRIPES);
=20
 	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
 			      btrfs_stripe_nr_to_offset(nr_stripes));
-	blk_start_plug(&plug);
 	for (int i =3D 0; i < nr_stripes; i++) {
 		struct scrub_stripe *stripe =3D &sctx->stripes[first_slot + i];
=20
@@ -1783,7 +1780,6 @@ static void submit_initial_group_read(struct scrub_ct=
x *sctx,
 		ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
 		scrub_submit_initial_read(sctx, stripe);
 	}
-	blk_finish_plug(&plug);
 }
=20
 static int flush_scrub_stripes(struct scrub_ctx *sctx)




Return-Path: <linux-btrfs+bounces-1328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EB1828BEA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 19:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECBF1C20918
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3833BB3E;
	Tue,  9 Jan 2024 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="VG75ZcxY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1DB3A1CE
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1704823623; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U4ysdJipLFLEejnS4dsbb6kQomzXnAMnQj90NGtkqKJLiv2ZQqQXuWWQ0CGB43M89fbYD0T60VVJ/680jChkBQjaXq9MY82kN5Bk3iMNYiO5FpSLiovU5dr0KXdO13A5CjhS2PYXL8VnbJe1xaa82P51SP7DTZ3JujXJYblC5oA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1704823623; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=kNULqFGy/FP3LyNg1qy3P6LiXmisW/zQc7v9H6L2gR4=; 
	b=Xwh6SfXlsvYPy2TFF1/+NlLKYCfPVsjw740HfoKb/EHN0Dlvfw9PVXKoNRlWZspPykalq5hmJ1RHmtui/3HuubH3g0h4aaimV7/NEi9LzwbuQEffdKNjrkCAiCqUYqlqmMJTy1sPP3emxss0UTxrnn6I6R1S4/+g+zFbAWKueyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1704823623;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
	bh=kNULqFGy/FP3LyNg1qy3P6LiXmisW/zQc7v9H6L2gR4=;
	b=VG75ZcxYReYhNU9Eytss1ndAKY6JZKalDp5d6cLdkA2A6RIqKZ9wm6BTbOzhJGpx
	VfjLhhIBuWdHxSV658SIewFbHtK3k9ebgOzmNuS7uYoSFMTvNAiPXtSaI5qGJhYjLFb
	gApoxl8EMO/HvL8C4FW+ZcAv4VBo73msPFFNSba0=
Received: from tb.lan (182.118.232.82 [182.118.232.82]) by mx.zohomail.com
	with SMTPS id 1704823621859567.5164518581006; Tue, 9 Jan 2024 10:07:01 -0800 (PST)
Message-ID: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
Subject: Scrub reports uncorrectable errors with correctable errors
 unrepaired, but all files are fine
From: Rongrong <i@rong.moe>
To: linux-btrfs@vger.kernel.org
Date: Wed, 10 Jan 2024 02:06:57 +0800
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

Hi all,

I recently scrubbed my fs and saw multiple correctable and
uncorrectable errors. Weirdly, the correctable errors did not really
get repaired ("fixed up") after the scrub was finished. It just
persisted and reappeared in the next scrub. But surprisingly, when I
tried to archive all files using `rsync -aAHUXxvP /path/to/mountpoint
/path/to/archive` (the fs has no subvolume other than <FS_TREE>), no
error was raised (both rsync and dmesg) and all files were fine. Both
`btrfs check` and `btrfs check --check-data-csum` also finished without
error.

I tried many kernel versions, including 6.5.13, 6.6.10 and 6.7-rc8.
btrfs-progs is 6.6.3. The fs is mounted with the below parameters:
autodefrag,compress-force=3Dzstd,relatime

Each time a scrub gets finished, the error summary is the same:

Error summary: read=3D416
Corrected: 168
Uncorrectable: 248
Unverified: 0

Only two types of errors were shown in dmesg:

BTRFS critical (device [D]): unable to find chunk map for logical
[LoUc] length [LeUc]
BTRFS error (device [D]): fixed up error at logical [LoC] on dev
/dev/[D] physical [PhC]
(all [PhC] just equaled to the corresponding [LoC])

I randomly picked some addresses and did some research:

# btrfs inspect-internal inode-resolve [LoUc] /path/to/mountpoint
ERROR: ino paths ioctl: No such file or directory
# btrfs inspect-internal logical-resolve [LoUc] /path/to/mountpoint
ERROR: ino paths ioctl: No such file or directory
# btrfs inspect-internal dump-tree -b [LoUc] /dev/[D]
btrfs-progs v6.6.3
Invalid mapping for [LoUc]-[LoUc+16384], got [Lo1]-[Lo2]
Couldn't map the block [LoUc]
ERROR: failed to read tree block [LoUc]
# btrfs inspect-internal inode-resolve [LoC] /path/to/mountpoint
ERROR: ino paths ioctl: No such file or directory
# btrfs inspect-internal logical-resolve [LoC] /path/to/mountpoint
/path/to/file
# btrfs inspect-internal dump-tree -b [LoC] /dev/[D]
btrfs-progs v6.6.3
checksum verify failed on [LoC] wanted [csum1] found [csum2]
ERROR: failed to read tree block [LoC]

I checked the commit log of fs/btrfs/scrub.c, and tried scrub on
6.3.12. The scrub finished without error. I assume this is intended as
0096580713ffc061a579bd8be0661120079e3beb was simply not back-ported.

I guess the root cause of the issue is that one of the DUP metadata
copies was somehow corrupted. Am I right?
I am to confirm:
1. is this behavior (false "fixed up") of scrub intended?
2. why btrfs check finished without error under such a circumstance?
3. since all files were fine and btrfs check finished without error,
should these "uncorrectable" errors be actually correctable?

I have a full dump of the disk. As long as needed, I can provide
further debug assistance and more information about the fs.

Thanks,
Rongrong


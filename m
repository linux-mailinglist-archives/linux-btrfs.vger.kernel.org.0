Return-Path: <linux-btrfs+bounces-3903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310DA89810D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 07:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B6C289355
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 05:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434EA3FB1B;
	Thu,  4 Apr 2024 05:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOZYwwFX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28571AAC4
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209320; cv=none; b=hXRimRFgk5Q+oTQW3B49LoasIkrsLrZmoVAr162l9hxtGQsfDVgfNm/2vlhatzDwMR3YVYogla+EgYH2JJ9+EZTbWdN+B52E3Gdp3jljGcbgNWpdTrUP8sbpBNSprNMU9WtScgxjeHq/BkZ4aeIUGIr6P72axHX+9+damhwEZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209320; c=relaxed/simple;
	bh=3ZGBrYyAOHO4g3ptnXqb20xisEjfq2qQrvxvvx1/+KA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PpPMqyUbiW+uqZO33Vu0LancbUoGD50IeRmPBrUBtIunzWg1+eDS8sTVLbtDXctPvaiRk5QjpJAZkpwKtHx3kyjOTtApi8RMbQp5a09g6hIiIzCsDMZcvunuZBM+bX41ygCtgMA4zqgC5tjISwZbMBhfSyOSrjbal11p9OYUFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOZYwwFX; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-432d5b5f00bso4707991cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Apr 2024 22:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712209317; x=1712814117; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cW9Kwg/sYk8O+RKWUc2U0pju6rrQ4F2Bsz4KQlly4CI=;
        b=cOZYwwFXlGuy4ZilwtajVgqHl5+KKyjEOvdArRRCBnTu5AxEUKjJW6M4gfx1lxUZmH
         9voY/GAwQ33OdpCu/ldkYBg4VSKEEdTkIL49wKciXaRH/eydWYG3ILIR9A/gffAw/ZnI
         QOah4C+R4WOj9PVAfNA8FtBjLBIxgJgcP22yM1+ZYPVlM6FMkvm78gr5G1NWitTsn5jm
         j0N9K2MtNvdaYTlfINB9tXuSyj8+qmSSQqsvPAkcOmHFQyeP4V4httssLciE+H1q398F
         83EqZ+no0qCG08Xz1kIHLx0OLDJ/O3cJjX2XX4OB+1mufwJ879LkhgLuG4lzm7e6ZplX
         wZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712209317; x=1712814117;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cW9Kwg/sYk8O+RKWUc2U0pju6rrQ4F2Bsz4KQlly4CI=;
        b=XzqdPm62AemwmqKOv2hD2LOyt0G2qDbVGkmrTFl2d5UbznqT/l4hlnAl5VXM0ukPNq
         vylpELoAObBA49Ypp8pSy+7VHSyY0dm0C+svOiplJrYOc5nzVbGFjh+SjHYWNPkw/98o
         6iarZgLS/q2d6ni4kbjTZg97ukBg6chvPad+qTeeYJJWnwMrCuZLWk16+/jjU80FV3iv
         JD5ECApOzsjuMCTSXqRc6ASw8s9mXkWiHAI8Vj5ZpuGPOe8u14ubKQA1u+EYGJWeIaz2
         27ZYDHF7Rs+isiw4EqB3PbkukOVilRlxhrSjEreimJiRfICtM914Whf1vjii2Q6FiQGT
         mvig==
X-Gm-Message-State: AOJu0YxZSXSsPSwyHllBwoSfcDatb6rMMv/qS9Xbu1i6KxqwwUOj1tbI
	m4m2cJze0ifHIF8Ir9H6+pqQaveKkhvfu3FkQb4i3Y9TbnpyhIkw6oAmz7Lndtyzk+E8C86fd8E
	YNDUfLjT9I5gHzQEJc75KisPj2C77NlQPasQ=
X-Google-Smtp-Source: AGHT+IGm40twiEDG294in+HwSejFTpMnLV4IxObeUjyEZw2Hrqd7Xbz+cUvm1/GjcQ2dhhSnxO2rc/XshxgLnaH/Z5I=
X-Received: by 2002:a05:622a:547:b0:432:de8a:3a8 with SMTP id
 m7-20020a05622a054700b00432de8a03a8mr7681194qtx.18.1712209317481; Wed, 03 Apr
 2024 22:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "David F." <df7729@gmail.com>
Date: Wed, 3 Apr 2024 22:41:46 -0700
Message-ID: <CAGRSmLv2TB5YT5_11zqVd6qfBgJ6wgzPCpmd6s4-gvSCnnnXWg@mail.gmail.com>
Subject: Understanding BTRFS Extent Tree?
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a need to find all the used areas on the btrfs (in this case
just a single disk, no RAID, etc..).  I read that the extent tree
should have all the information necessary but the values don't add up.

Looking at items in the Extent Tree for BTRFS_EXTENT_ITEM_KEY and
BTRFS_METADATA_ITEM_KEY I find a total of  196,608 bytes.

Using "btrfs inspect-internal dump-tree --extents" and add that up you
get exactly 1/2 of that 98,304 (presume because DUP).

Yet the file system says 3.6M is used.   How do I get all the used
areas for a simple single drive or partition on a PC using btrfs?  I
will probably need to manually handle the superblock area?

Anyway, here is the output for the extent tree:

linux-jn17:/home/suse # df -h /mnt
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb        8.0G  3.6M  7.2G   1% /mnt
linux-jn17:/home/suse # btrfs inspect-internal dump-tree --extents /dev/sdb
btrfs-progs v4.19.1
extent tree key (EXTENT_TREE ROOT_ITEM 0)
leaf 30523392 items 12 free space 15594 generation 14 owner EXTENT_TREE
leaf 30523392 flags 0x1(WRITTEN) backref revision 1
fs uuid 7fe21481-9083-4f7b-a00c-e651fd16bfac
chunk uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
    item 0 key (13631488 EXTENT_ITEM 65536) itemoff 16230 itemsize 53
        refs 1 gen 14 flags DATA
        extent data backref root ROOT_TREE objectid 256 offset 0 count 1
    item 1 key (13631488 BLOCK_GROUP_ITEM 8388608) itemoff 16206 itemsize 24
        block group used 65536 chunk_objectid 256 flags DATA
    item 2 key (22020096 BLOCK_GROUP_ITEM 8388608) itemoff 16182 itemsize 24
        block group used 16384 chunk_objectid 256 flags SYSTEM|DUP
    item 3 key (22036480 METADATA_ITEM 0) itemoff 16149 itemsize 33
        refs 1 gen 5 flags TREE_BLOCK
        tree block skinny level 0
        tree block backref root CHUNK_TREE
    item 4 key (30408704 BLOCK_GROUP_ITEM 429457408) itemoff 16125 itemsize 24
        block group used 114688 chunk_objectid 256 flags METADATA|DUP
    item 5 key (30425088 METADATA_ITEM 0) itemoff 16092 itemsize 33
        refs 1 gen 6 flags TREE_BLOCK
        tree block skinny level 0
        tree block backref root UUID_TREE
    item 6 key (30490624 METADATA_ITEM 0) itemoff 16059 itemsize 33
        refs 1 gen 4 flags TREE_BLOCK
        tree block skinny level 0
        tree block backref root DATA_RELOC_TREE
    item 7 key (30507008 METADATA_ITEM 0) itemoff 16026 itemsize 33
        refs 1 gen 14 flags TREE_BLOCK
        tree block skinny level 0
        tree block backref root ROOT_TREE
    item 8 key (30523392 METADATA_ITEM 0) itemoff 15993 itemsize 33
        refs 1 gen 14 flags TREE_BLOCK
        tree block skinny level 0
        tree block backref root EXTENT_TREE
    item 9 key (30539776 METADATA_ITEM 0) itemoff 15960 itemsize 33
        refs 1 gen 14 flags TREE_BLOCK
        tree block skinny level 0
        tree block backref root DEV_TREE
    item 10 key (30556160 METADATA_ITEM 0) itemoff 15927 itemsize 33
        refs 1 gen 14 flags TREE_BLOCK
        tree block skinny level 0
        tree block backref root CSUM_TREE
    item 11 key (30670848 METADATA_ITEM 0) itemoff 15894 itemsize 33
        refs 1 gen 7 flags TREE_BLOCK
        tree block skinny level 0
        tree block backref root FS_TREE
device tree key (DEV_TREE ROOT_ITEM 0)
leaf 30539776 items 6 free space 15853 generation 14 owner DEV_TREE
leaf 30539776 flags 0x1(WRITTEN) backref revision 1
fs uuid 7fe21481-9083-4f7b-a00c-e651fd16bfac
chunk uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
    item 0 key (0 PERSISTENT_ITEM 1) itemoff 16243 itemsize 40
        persistent item objectid 0 offset 1
        device stats
        write_errs 0 read_errs 0 flush_errs 0 corruption_errs 0 generation 0
    item 1 key (1 DEV_EXTENT 13631488) itemoff 16195 itemsize 48
        dev extent chunk_tree 3
        chunk_objectid 256 chunk_offset 13631488 length 8388608
        chunk_tree_uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
    item 2 key (1 DEV_EXTENT 22020096) itemoff 16147 itemsize 48
        dev extent chunk_tree 3
        chunk_objectid 256 chunk_offset 22020096 length 8388608
        chunk_tree_uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
    item 3 key (1 DEV_EXTENT 30408704) itemoff 16099 itemsize 48
        dev extent chunk_tree 3
        chunk_objectid 256 chunk_offset 22020096 length 8388608
        chunk_tree_uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
    item 4 key (1 DEV_EXTENT 38797312) itemoff 16051 itemsize 48
        dev extent chunk_tree 3
        chunk_objectid 256 chunk_offset 30408704 length 429457408
        chunk_tree_uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
    item 5 key (1 DEV_EXTENT 468254720) itemoff 16003 itemsize 48
        dev extent chunk_tree 3
        chunk_objectid 256 chunk_offset 30408704 length 429457408
        chunk_tree_uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a

Thanks!!


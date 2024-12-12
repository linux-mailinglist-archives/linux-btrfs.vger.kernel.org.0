Return-Path: <linux-btrfs+bounces-10292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06329EE0A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB74281A33
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5C120B7F3;
	Thu, 12 Dec 2024 07:55:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55AB20B20B
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990158; cv=none; b=HmFYBa+nvXNbLet7i8kPTOxLttiAKsB3RrQz4IDUeHWfuVXGHPYbgapIPYC0K64RbDimpC1iFMN6KSxU7kHq3kVKuFIbcE0IVdbM5QDOGZiTkYBKm406uGoldrMrdqA9XbMl03CwoLGmmbhmNnfCFfWMeMR0nVdEZyTqiPIDeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990158; c=relaxed/simple;
	bh=+NJrJfrdZicsxaXHyjqiApjDIa0Z/OMNUXYJsBeXc18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEQLPCvNTJxXWkpIdiSsa7Zwu37cb3XComD1e+2V/S/9/upem6dtyz9G3OwGYVZK66F1m12Ny9WtB8Nso7jNVndgstNbEwgHUfh4JUThE0bzli5mn5p1qCu3gL2+GvxMNADxgM46LjD/dRtjIPc7slNm/nGsO9Tw8y55dbpoxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so2855304a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990155; x=1734594955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uTlkP3OZhcfCNA3ZzjeQf+0MZaelC6Z8HWLOlV91Nk=;
        b=WZdD3JZCenVuXEjQEg2KW7wLajEsJbuEPn4Tm35h9ksKV6YweJlgU8uvF2ndsp8j5U
         S+1mzO750fLv246aU+GeorZdskpeR2DoC7KbyZ8eEWyQsKhSkCvqkyNSvNCs3mFq5+H5
         HyOPxuQlpndvE4YEu5ITbP5Mv1pOdQtZfTGq2HEkS6QyhT0GRd2MoSZJZdM0TR5BygMC
         vpR/YbASj5M1AF7Oz5HCn6AmZ0WHi2qxGp+i1HWimgjXXjhK0HvB2PG8eUtxvSmulHF2
         bbCYtVnHcdMtiUVEl9EoJI/ctjXjXYR4K/AYsmvj1Su2uj8LAuTxwxgtp1HpbVcA46kj
         5VwQ==
X-Gm-Message-State: AOJu0YwwEhUO3Si/b6qfzCsptc7T3qvvFL5agAn0CKF9jvPaKUAeA6QJ
	owfTQ9o+m23wYd87Eg2DHxdj4lFUZjt/DfEiw4sCpvUVkh3rMk/6d14XAD7A
X-Gm-Gg: ASbGncululLuN3vS6p9N4iFcZMPjiMQJN25DWWF2zCkbR8a+fhLDCfNy1dvdw+xfGXt
	E09E3T43Q3dZXx6tnoDGAmKvcpQ6H7Tvh2fmgTJFUes3L8Q41ogl4+vjo+PgGaPuyAUNehNi8eN
	tlqGfBsBsnz5RCQlymDlNCeTfGi3RZx2bmlvCooYc7uPtvvoAVhtogARp5Y6nlwgBOaTrF8JB7K
	bMG4lMKOak+TiFr4Rf/qRYDvWcJ59FJBBeC15ByYRK67gBeN+8V3VHQ9Tq4/6ALMRwUDVJm0gLa
	6A6TTzct6Duvb3/YCmN3flBW8s6GVIaiHBJ2NDM=
X-Google-Smtp-Source: AGHT+IHFn4dlo39PRzWXrbEzUYdQEqIInEy/fT7kHYEu7W+p6s3hxUysdgrEneBLJvCZuy56r+qPvg==
X-Received: by 2002:a17:907:7810:b0:aa6:841e:ec40 with SMTP id a640c23a62f3a-aa6c418f3e1mr190564666b.26.1733990154882;
        Wed, 11 Dec 2024 23:55:54 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:55:54 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 00/14] btrfs: more RST delete fixes
Date: Thu, 12 Dec 2024 08:55:19 +0100
Message-ID: <cover.1733989299.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here's another set of fixes for the delete path on RAID stripe-tree backed
filesystems.

Josef's CI system started tripping over a bad key order due to the usage
of btrfs_set_item_key_safe() in btrfs_partially_delete_raid_extent() and
while investigating what is happening there I found more bugs and not
handled corner cases, which resulted in more fixes and test-cases.

Unfortunately I couldn't fix the bad key order problem and had to resort
to re-creating the item in btrfs_partially_delete_raid_extent() and insert
the new one after deleting the old.

Fstests btrfs/06* are extremely good in exhibiting these failures and
btrfs/060 has been extensively run while developing this series.

A full CI run is undergoing at the moment:
https://github.com/btrfs/linux/actions/runs/12291668397

Johannes Thumshirn (14):
  btrfs: don't try to delete RAID stripe-extents if we don't need to
  btrfs: assert RAID stripe-extent length is always greater than 0
  btrfs: fix search when deleting a RAID stripe-extent
  btrfs: fix front delete range calculation for RAID stripe extents
  btrfs: fix tail delete of RAID stripe-extents
  btrfs: fix deletion of a range spanning parts two RAID stripe extents
  btrfs: implement hole punching for RAID stripe extents
  btrfs: don't use btrfs_set_item_key_safe on RAID stripe-extents
  btrfs: selftests: check for correct return value of failed lookup
  btrfs: selftests: don't split RAID extents in half
  btrfs: selftests: test RAID stripe-tree deletion spanning two items
  btrfs: selftests: add selftest for punching holes into the RAID stripe
    extents
  btrfs: selftests: add test for punching a hole into 3 RAID
    stripe-extents
  btrfs: selftests: add a selftest for deleting two out of three extents

 fs/btrfs/ctree.c                        |   1 +
 fs/btrfs/raid-stripe-tree.c             | 154 +++++-
 fs/btrfs/tests/raid-stripe-tree-tests.c | 653 +++++++++++++++++++++++-
 3 files changed, 776 insertions(+), 32 deletions(-)

-- 
2.43.0



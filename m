Return-Path: <linux-btrfs+bounces-7449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C43395D361
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 18:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE044B26654
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D218CC15;
	Fri, 23 Aug 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IXSz6d5T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C218CBE4
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430505; cv=none; b=oWstEFY6VXNF0Jm8lKDuuAv7odvgbCDtG6XJvyNgLZc6Bo/uyBcIUoJLDucczFs6MT8MzP0nLW43qGy2HwWa+F0z9DKqtz7wL7Jl+/GfUHANq6Vzsaa7oAhJQHJZwTO9uHXPYi7cdyTSPePTsZyTT7/tssZdhICuful7HjuHQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430505; c=relaxed/simple;
	bh=IhRlCHVoviiUKuHJg/Di2yAYuiLFicM78Y1I/8tC+dk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VM1RZ+seQxOJQyCKowCDQl+QLUcyQNBip40L/Bp7KnIy8Rs5nZAE2WFszR1wpG2LgEox7FOeBwg7X7BsMfYAprjVfL/NrbshkA9LxRY9vjz4bFNT2C8F6/LBlaza/udAOj5T9xLKaYjOttL/PR3XUH24rIcrAyp5UeDknACi+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=IXSz6d5T; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NAA3Pj028815
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 09:28:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=e93kBa7v
	9ZsVtcFWC82zRWXhaV4Qzv6E6bprJLTBfnU=; b=IXSz6d5TfoTEBEZD9NRWMeMZ
	mC/9J4XRV6YzpvFynijd2cmxOTttxvPjMUxG1ESu1PEI7ML5t9OqbDqBUwGkaQvr
	JwY+MVBHon3HiXSFb2luINP17qgJFGGdF2+L1cH6mMAT4Wy9zbFN2ZuFXSr15uaT
	GP7DIhUf6eKw067p5wY=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 416reaa285-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 09:28:23 -0700 (PDT)
Received: from twshared12613.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 23 Aug 2024 16:28:21 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 356A45CB7F75; Fri, 23 Aug 2024 17:28:13 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <io-uring@vger.kernel.org>, <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 0/6] btrfs: add io_uring for encoded reads
Date: Fri, 23 Aug 2024 17:27:42 +0100
Message-ID: <20240823162810.1668399-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BtcM7Sf8CLYbZ2zRFFvoGv4HJaiU3iT1
X-Proofpoint-GUID: BtcM7Sf8CLYbZ2zRFFvoGv4HJaiU3iT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_13,2024-08-22_01,2024-05-17_01

This patch series adds io_uring support for btrfs encoded reads,
complementing the ioctl we already have. The first few patches refactor
the ioctl code so that the bio wait is moved to the outer function, and
so that we can share as much code as possible between the two
interfaces.

Mark Harmstone (6):
  btrfs: remove iocb from btrfs_encoded_read
  btrfs: store encoded read state in struct btrfs_encoded_read_private
  btrfs: add btrfs_encoded_read_finish
  btrfs: add btrfs_prepare_encoded_read
  btrfs: move wait out of btrfs_encoded_read
  btrfs: add io_uring interface for encoded reads

 fs/btrfs/btrfs_inode.h |  23 +++-
 fs/btrfs/file.c        |   1 +
 fs/btrfs/inode.c       | 292 ++++++++++++++++++++++++-----------------
 fs/btrfs/ioctl.c       | 194 +++++++++++++++++++--------
 fs/btrfs/ioctl.h       |   3 +
 5 files changed, 337 insertions(+), 176 deletions(-)

--=20
2.44.2



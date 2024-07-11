Return-Path: <linux-btrfs+bounces-6366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CCA92E12E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 09:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B541F22F3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF5D14B955;
	Thu, 11 Jul 2024 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vSphCIq/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5CC29CEF
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684154; cv=none; b=kXN/OkR2DuZNyu12YN1HEQFF9ZfBMJUaEyeGAOuIQkjCpkvYOt8XjeCAXVmLBlr1+MmJ02QR8g2tLxP7D81h0BHcyKw6M5Fc51T8brJ1B52k9z23nHqgLGluZoSRxMsjwGs1TR/INlTcx+aOeZe39XCX0mFROtvmNnRyoXYQEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684154; c=relaxed/simple;
	bh=i3OvvcoQfCXZeAS6mCZesuzZdOM67uhMGi7v4mm4HfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ptuGy89nRip+m5sXzsQ3miPBYiQRf8cTk9Hos9ERgpsptDKDfvapE0JTkJFZG5h/fCgXKcJ1wCSWvLuEx9bwM3iE/KcGrhm6KcpjHphYm6U16PdXG3d5LsnrSPmsIL9m8p5AFcjrTcgFf5CQNIG3X2qd0ik2TI4H/wgUC2w/9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vSphCIq/; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720684151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oGIWSDUMzn+gpjSzQ+REy8Wj9tSDNlALob7dYQowUWA=;
	b=vSphCIq/5+7V++7Ee47RhuofdTFRsIbDZDd2em7d5TRe2CvFZJWqrhgPIJnhINB0iwm7MY
	hbL1EbMfHMZD6z7I8T9/QqGUubBWBkRgUrmMyNGshTiYsu4Sc6cjSheMAIS8MFs/yrZBwf
	j66VOCYvq3rC6bSOzbng20tB6Gb7fa0=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: clm@fb.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger.kernel@dilger.ca
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: youling.tang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev
Subject: [PATCH 0/3] Add {init, exit}_sequence_fs() helper function
Date: Thu, 11 Jul 2024 15:48:56 +0800
Message-Id: <20240711074859.366088-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series provides the {init, exit}_sequence_fs() helper functions and
applies to f2fs and ext4, similar to btrfs.

Youling Tang (3):
  f2fs: make module init/exit match their sequence
  ext4: make module init/exit match their sequence
  fs: Add {init, exit}_sequence_fs() helper function

 fs/btrfs/super.c   |  36 +--------
 fs/ext4/super.c    | 142 +++++++++++++++---------------------
 fs/f2fs/debug.c    |   3 +-
 fs/f2fs/f2fs.h     |   4 +-
 fs/f2fs/super.c    | 178 ++++++++++++++++++---------------------------
 include/linux/fs.h |  38 ++++++++++
 6 files changed, 173 insertions(+), 228 deletions(-)

-- 
2.34.1



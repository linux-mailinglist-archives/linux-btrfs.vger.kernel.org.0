Return-Path: <linux-btrfs+bounces-8240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2380798704E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE151F28189
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838E1AC89E;
	Thu, 26 Sep 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa0l+JrR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ABF1AAE15
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343205; cv=none; b=NanuiLPkFMW+H7pn925nKGZRkUBrLbsVIKNF6hR7UFD+sEH+RT/gapABNGAyBxP+wLIg1g331exfCdbE3oMEfVnihCWui4CEqSPyuK+qa29xuAKoxyiRJcs7RgfyBCxwlI0f/HybjDQhCZkZujO48joc8by+Mqfn+rnxberGbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343205; c=relaxed/simple;
	bh=1ChocamqElTodOO40quKC2wYVsxTXJfqtmyTePoYimo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szHbpdf3ntLzJcf+eb/R8ST+7C1t2CJaRatKlFJcFGt2werRr1MXq+5+2FRrchHS35tbKhTGSvObgwngIFi7fi9g2yk3o2evPVV4PAQ5is/GqVqDCQpThDw89l5vXQqVmm+ZyFZ/bNyBERYNIJleP6dZ8sVBISPivLXWmbYF6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa0l+JrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF06C4CEC5
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727343205;
	bh=1ChocamqElTodOO40quKC2wYVsxTXJfqtmyTePoYimo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wa0l+JrRzbjg1lNdD/WOejk2kSaV5AojhpoqliYydpHqr+PL4Gci7/Qk9PHF22hL0
	 sqURewP5o6HfB2BnkyNrTcjAfg8fpuLMI/mXAj9uzrWc6RKmaQq/XZ3c5WqwcwY1lK
	 v4RREjlp1bOd+lrvf6J10UkF1qjHZOpP2WCbNqrY35Kp0PeDlcC5gF32YlRYZyiy6Y
	 Zk+qocDlxNDiGpGUK7HRTrQIgYoBxWCPlhm+8v3QEZOhvqhL3+miFLEW8IWCbxD8D7
	 3FJMMxe8AUoXvwvKYcmQkkn+QUEGexRlX4Rvrz8lzFH/CktjdgCafyho8I1F00QQ7i
	 8if41tzvqle7A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/8] btrfs: delayed refs and qgroups, fixes, cleanups, improvements
Date: Thu, 26 Sep 2024 10:33:14 +0100
Message-Id: <cover.1727342969.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727261112.git.fdmanana@suse.com>
References: <cover.1727261112.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some fixes around delayed refs and qgroups after the conversion of a
red black tree to xarray in this merge window, and some improvements
and cleanups. Details in the changelogs.

V2: Updated patch 2/8 to check for MAX_LFS_FILESIZE and error out.

Filipe Manana (8):
  btrfs: fix missing error handling when adding delayed ref with qgroups enabled
  btrfs: use sector numbers as keys for the dirty extents xarray
  btrfs: end assignment with semicolon at btrfs_qgroup_extent event class
  btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_record
  btrfs: store fs_info in a local variable at btrfs_qgroup_trace_extent_post()
  btrfs: remove unnecessary delayed refs locking at btrfs_qgroup_trace_extent()
  btrfs: always use delayed_refs local variable at btrfs_qgroup_trace_extent()
  btrfs: remove pointless initialization at btrfs_qgroup_trace_extent()

 fs/btrfs/delayed-ref.c       | 59 ++++++++++++++++++++++---------
 fs/btrfs/delayed-ref.h       | 10 +++++-
 fs/btrfs/qgroup.c            | 68 +++++++++++++++++++++---------------
 fs/btrfs/qgroup.h            | 13 +++++--
 include/trace/events/btrfs.h | 17 +++++----
 5 files changed, 111 insertions(+), 56 deletions(-)

-- 
2.43.0



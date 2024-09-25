Return-Path: <linux-btrfs+bounces-8215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56798575B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 12:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3C1F21B7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A815DBAE;
	Wed, 25 Sep 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZaNi/e7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A377107
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261434; cv=none; b=j7U3f7RzB5hrUs5ShIxJEJH9A8rwb0HoxxFz6ZzzrFFhDqUPmCq18lr4v99scSxZmvalK82iF8vExeHkwQ5ngFFFK6jTZWF+7d7QAXNPHaWmQQ8CsNGJHAYf4uiARQXeUerCzjKe1ug6hdovNIAQT7wF8Rmp1zxaxPckzs6ObWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261434; c=relaxed/simple;
	bh=NmGrAW6KpXG06vV0c+y2xFxNHj19qvCMy7PEOWGrFGM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TisDFWqmcEqTqeLACIp49B1JqSRSFOypn+U6zjt5qPtH8wlR0mYI7sqrSk9aK5y76VIDCVZRteOhHePtDxQylhwzeo6/XMGct5WidEGO4yiBwo9rZLc6y9ewxz/R+l7kQFugGNNRj2KVCfOHnU/mhO6NUX+qSY6JEmORdizyToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZaNi/e7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C41C4CEC3
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727261433;
	bh=NmGrAW6KpXG06vV0c+y2xFxNHj19qvCMy7PEOWGrFGM=;
	h=From:To:Subject:Date:From;
	b=cZaNi/e7r3bAHzbjOjTQy7iUJUeMY+AOdPgedEBgpjdq57VrbcdYHpnVheLi/4ZVI
	 DIeu0zH0Cn65v4eTaCJLALv1JIBFep0RFEagFpYyay7geO7oI4ctvegke6mN2Gayfq
	 bqBR59Vh0f/uj9pjFjcrPwr2M5BElWgS01j+mPBwAjjHuk1VG55GDwJ0GbNiedBlV4
	 UvImqoAFLUuNAzHr40yHcXP9nVY+XR+qSkWNJiq4kwKJSOjDkn6ElKntWJfGLdOGbW
	 S97LPmskFbMHVcxDaIP+5gtwS2afgRjrFn02jmTDhLWXwa9VFY2kMJOmxQ0Icl8Enu
	 xTChtEvWERqpA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: delayed refs and qgroups, fixes, cleanups, improvements
Date: Wed, 25 Sep 2024 11:50:22 +0100
Message-Id: <cover.1727261112.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

Filipe Manana (8):
  btrfs: fix missing error handling when adding delayed ref with qgroups enabled
  btrfs: use sector numbers as keys for the dirty extents xarray
  btrfs: end assignment with semicolon at btrfs_qgroup_extent event class
  btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_record
  btrfs: store fs_info in a local variable at btrfs_qgroup_trace_extent_post()
  btrfs: remove unnecessary delayed refs locking at btrfs_qgroup_trace_extent()
  btrfs: always use delayed_refs local variable at btrfs_qgroup_trace_extent()
  btrfs: remove pointless initialization at btrfs_qgroup_trace_extent()

 fs/btrfs/delayed-ref.c       | 59 ++++++++++++++++++++++++++----------
 fs/btrfs/delayed-ref.h       | 10 +++++-
 fs/btrfs/qgroup.c            | 58 +++++++++++++++++------------------
 fs/btrfs/qgroup.h            | 13 ++++++--
 include/trace/events/btrfs.h | 17 ++++++-----
 5 files changed, 101 insertions(+), 56 deletions(-)

-- 
2.43.0



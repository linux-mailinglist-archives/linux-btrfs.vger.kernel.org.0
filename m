Return-Path: <linux-btrfs+bounces-18950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1913FC5925A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 18:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADB9426C1F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046C935A954;
	Thu, 13 Nov 2025 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGIVQY8h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B834DCFE
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053004; cv=none; b=Tb/9dDvlRYH9Gkmr/qPGlqiea2+DzQakkD/8GwA5fRHbSzRc/CoLB1d5Kbre/cHHG/05MSAXVVvH0q14l6dDcy9mCZylrcYExhHdxuae4yS0mX1kfP4O+KI5r2xUpsXwbX1LIWcI0Xaagwufm28zjcYMpOy+AvAG2ktrjrdxjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053004; c=relaxed/simple;
	bh=estGtmeG7Tu9qKsvODPsBiC4pL5xoo7743t5tGQ0lVc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K+VJNaC4nsTvY/Htuu6Fw7u3Kv1JUct0mAkR8L1w5NAvpK0+5gtdcwrZq69RjxxduB0QpHFHEACPMZMdsuDtXMcR63K0UNWLk4WxYpBEYAaIe/R1/WqkVgQm+eP1IDi815GwNlBpFjM89kwdaylUQDomEz8jHOE8zS4QLZdCeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGIVQY8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2047CC4CEF5
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053003;
	bh=estGtmeG7Tu9qKsvODPsBiC4pL5xoo7743t5tGQ0lVc=;
	h=From:To:Subject:Date:From;
	b=iGIVQY8hA829ujlkmKEREX9RpRhW+RKAN+6arFPTqnwF6rhsrpmLTGw5IzPcycPpR
	 GiSFBPkDu9xdwXq0sOXuWuPP5S5nuB/1VQgPQX6K0DpOdk/VOSeozRmJ6qIiXsmsb6
	 /1EKM0SeVFXmfBX1ng5+vqJxnworDAqYQ+NVOpUk+TBUJkB6FjgrsFdUAC4l+xqoXo
	 YuubTZ9XcnNE2O4GSyhdv1VgbvnrClTmjPcoc/Rahq/WPWOeepGaTu8chsCVUcDkSR
	 /Ev25hgyNsr5RDwEt0hAQ+dJKa9c25Cf5BgWShk5iq/s0agpaR6o5YYQ+AJScAWP93
	 XwgrZjyrfCt8A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: a bug fix and some cleanups in ctree.c
Date: Thu, 13 Nov 2025 16:56:31 +0000
Message-ID: <cover.1763052647.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Trivial changes, details in the change logs.

Filipe Manana (8):
  btrfs: fix leaf leak in an error path in btrfs_del_items()
  btrfs: remove pointless return value update in btrfs_del_items()
  btrfs: add unlikely to critical error in btrfs_extend_item()
  btrfs: always use left leaf variable in __push_leaf_right()
  btrfs: remove duplicated leaf dirty status clearing in __push_leaf_right()
  btrfs: always use right leaf variable in __push_leaf_left()
  btrfs: abort transaction on item count overflow in __push_leaf_left()
  btrfs: update check_skip variable after unlocking current node

 fs/btrfs/ctree.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
2.47.2



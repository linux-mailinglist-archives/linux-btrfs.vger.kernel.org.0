Return-Path: <linux-btrfs+bounces-15097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB40AEDD39
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 14:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B87D189C8A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5859228B412;
	Mon, 30 Jun 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3mJ/t+5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB68285419
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287151; cv=none; b=es2TaqruKu162QgaOAfVBHeC2hjboQz6ZQ2Gkol3QaKhGGUOR9UlSLuiBJ6dfjVpEvmhijHrc/uFBcXF+4GFCezb81fBrRnexUyFk9/pjkcr7Qz0WsbcNOXdnwrRNc8fOPhAZcZHiH1CsFeyq6DnhFuVvedqSwhl2j9A6hLnGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287151; c=relaxed/simple;
	bh=wCa2OKvLSPErKfRMKkf1rj6bk5M74e2QPfYhvpC+gic=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uPtQvhjhWNvrg17n6Ono9ysOl2FlI5MVM83A25+nHcVjZJ0S6FENvQo9Z8cvL+IbfrOiOSnhxIaSVGJuIASP6dF8e4biL3K8c0iqKzgnFZfCYWvFmUe2GDWmAmekiFiZcyVs7XGyqzU1IEbS1gXFInuu4+iOZhK5GE4JKtVAUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3mJ/t+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE2DC4CEE3
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751287151;
	bh=wCa2OKvLSPErKfRMKkf1rj6bk5M74e2QPfYhvpC+gic=;
	h=From:To:Subject:Date:From;
	b=A3mJ/t+58aXACfhqrbMhTPFPnQPT83j/vtyO397elf/Eyh+dkRMSV3a3DBeXf+ISI
	 b41upGamZIVjKyyOl9XDZB5fzPJSOkqzKv4PlC/dXmV9YJbkPW0MLVeFYtvjO1VI05
	 wLXHvN1DgSCiFU3w7Rg6b5iVEUwEKton4qwMS7YkBB43pXEwKYVnW/4V0U2sb3WJN6
	 0wk8sD8LOxepZnl7uYIybUEDm3FrMpHzxRSVCOwl6ORW7LQy/QJcHMybLuHV/XzIO9
	 bWS+Ao1m1fJQNJKiecB0pXuDBoJqGXzn5PasQPk89kBXK/aW/NItiWoEaK9R4cr/A3
	 QyaZos//Mjn+Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: qgroup race fix and cleanup
Date: Mon, 30 Jun 2025 13:39:06 +0100
Message-ID: <cover.1751286816.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a race that leads to a use-after-free plus cleanup no longer used
qgroup_ulist.

Filipe Manana (2):
  btrfs: qgroup: fix race between quota disable and quota rescan ioctl
  btrfs: qgroup: remove no longer used fs_info->qgroup_ulist

 fs/btrfs/disk-io.c |  1 -
 fs/btrfs/fs.h      |  6 ------
 fs/btrfs/qgroup.c  | 53 +++++++++++++++-------------------------------
 3 files changed, 17 insertions(+), 43 deletions(-)

-- 
2.47.2



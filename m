Return-Path: <linux-btrfs+bounces-20866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM6oHKxHcWn2fgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20866-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:39:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C315E27B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA21B54D4A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB308421A05;
	Wed, 21 Jan 2026 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAvyImjL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACD83346B5
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028762; cv=none; b=UKgclNMOyrmD7aOXHFNYgRhaP88GcCqDc2ley0RVCsguq3a2fxTAAGZ2zSDwn0cO2hdTzC2ZrXnKEfKCcklcer1e/YdwS1u5un4Qfj35g5jypwEiWf4heEgt8K8LXY2w99cY7MvHfH3ekN2Zcbymvgj/q3jOstuVYq4a87RLThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028762; c=relaxed/simple;
	bh=6p9IzUrhyOH1iUJl/KW/Og/uV1RXIBFvAXeSwjNESBU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ror8WwfzmSmNpJULUp+KhY6/NA4+zzde8Z2A6xuYSoyu+aI91KsVDQT8Y3jfr3MpSjEXemIQ7/tDWk0Pqszml87eMa2gEoGNV+vvyw8yHDW3d9mC/eagO3TaiKHa74oaQA/JuWiNh+ihAlEUxYxrli9DSVb9XV9rjE8m2FWAjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAvyImjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889F5C4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 20:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769028762;
	bh=6p9IzUrhyOH1iUJl/KW/Og/uV1RXIBFvAXeSwjNESBU=;
	h=From:To:Subject:Date:From;
	b=mAvyImjL7JyBn5AJhDGnvS4+fI4qLKJKmXtv9dWJhBm7V6Gc0ZmZeSi62XCx+7RPb
	 nJcDTs3n8Lc/7MqVn+w0nriGbQ28DGOGjLxrW6WKeqq8l921nAeQYKx+hXjhsA7SVm
	 cyiB69WcjDGO9KFk4VZaQrXi160CfdDlfmQNuPpa3kiwouYLmpK1EOVtC2agC0xo/F
	 esPDq4ntjM1pE+WwRJGVRpeNQ1VtRtljAMEIzrZ9gUvLc/HaJBstNJpquMPOzAlcSl
	 el+t70PrgOY1rcILLZSGXG7gE2rE2eesiGXrhRQfqzc00Txcb+6JatD2walzBnQ6kG
	 TWj8Co9QVrXww==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: cleanup and fix sample_block_group_extent_item()
Date: Wed, 21 Jan 2026 20:52:36 +0000
Message-ID: <cover.1769028677.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20866-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 49C315E27B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Trivial changes, details in the change logs.

Filipe Manana (2):
  btrfs: remove bogus root search condition in sample_block_group_extent_item()
  btrfs: deal with missing root in sample_block_group_extent_item()

 fs/btrfs/block-group.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.47.2



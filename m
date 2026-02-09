Return-Path: <linux-btrfs+bounces-21557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIoVFDgVimlrGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21557-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:11:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B80112E6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F2FC301DD9F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B83859D6;
	Mon,  9 Feb 2026 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6uVV/bi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC41FE44B
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657072; cv=none; b=l8JH09cUooIOv+v3Ha+wI3lnC+0rhBekPOF13BE1BJ7CE5hB3pxrK52GJGIFzx0V5b+leacInnwHag1nW2g6tsHhAYD8hlMoCD+p2Lm1NjneMNeNhOKUbQRbK6IvKUxIgaFmsVUYu8SKHd9uLpFGWiLBvRhsNnubwG1p23LF9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657072; c=relaxed/simple;
	bh=Jsso6fMafQpP1os0qJUYOFYtenbr1QC7iixPxrKOt5U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tcFEoe0I5kgEbqorbKGboXZFHnvhNhHU6sHTzUSS3CrG8hs2SC5vOjGuw9pXLEy5jGsEyInwnuAGPZxJPWwj+VMOXm5HFKDJcGv4qj4EeexE2C1QNKPTAOZB3dm90pjW4g1VJXu3QjUvVvFKWARV+CCk2DFFf3DrZ9fMSo6oYBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6uVV/bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88115C116C6
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770657072;
	bh=Jsso6fMafQpP1os0qJUYOFYtenbr1QC7iixPxrKOt5U=;
	h=From:To:Subject:Date:From;
	b=t6uVV/bitxH0zW7WvBQ3Az3IPuj1EAcvHe7tnSXpQr41Y07qhHA0BobDkpY2VyBnm
	 D5bacr0mXVCBr7+DE+64CZaZCxBGbSG43dpgfBD+84dZC4OShT6EuOtf6ZCjo7tGSn
	 NuoRL/3Y8w24k77rNaOE8Sk18tSDxwJYpclEiOX1jP86Slsnj9cyJA5Zqt9Nz25d7l
	 B0t2NnYa2JSB+b5kj5MKPDa6L4f03CKX4cZPNhmhMRtdllRCJP6eVifZDtauMljMVl
	 gjsYEqxq0pvNzTay0sOrW0a/0qPVYWwZM0du9EppaqLNkNlDZkHqsdoBC1VXbbGUhh
	 yh/NOhn3uYEIw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: cleanup messages and error handling during mount
Date: Mon,  9 Feb 2026 17:11:04 +0000
Message-ID: <cover.1770656691.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21557-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: D5B80112E6C
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Short and trivial patches, details in the change logs.

Filipe Manana (3):
  btrfs: change warning messages to error level in open_ctree()
  btrfs: remove redundant warning message in btrfs_check_uuid_tree()
  btrfs: remove btrfs_handle_fs_error() after failure to recover log trees

 fs/btrfs/disk-io.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

-- 
2.47.2



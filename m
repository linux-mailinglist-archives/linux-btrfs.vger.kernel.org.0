Return-Path: <linux-btrfs+bounces-12059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99387A553B1
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 18:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F37178C0E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB2C25D53F;
	Thu,  6 Mar 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMpwlgbl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B250269D01
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283762; cv=none; b=gzmCbZDiypL9CYWcAqchLf3WygEXfGg8fLYm/su8c6MPtC2LYI+m02UsYqrRhKwAAU08+VzAK7Fcr1zDP4TMKNqu8XL3Tqc05sBnlew6Fej/E+tdLmsRbXanIugpp62ro11bO0sgOVC0+mOuuEjgxi69tTLCKMQC3u1x4fxCGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283762; c=relaxed/simple;
	bh=pWpcGJuzvCmROMuFMOWJvjM4He1LwWq1jJR1zhVHL7g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=fyYptMg/LfVNVP5g3mFIAOA8Vh6Jlw5PjIJ/QpVNbzhnr6DZZR8vOXkuHeiiWu8kB7tfk8e2+jppQfvinu/QGWZorOsy+Xswn7QDepY3sgn/JTOCEG+UiB9qSCSxDZlG4oKqidywHY7V7rgvMQd4QtgiGZP8nuokLqhsErEfyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMpwlgbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EAEC4CEE0
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283761;
	bh=pWpcGJuzvCmROMuFMOWJvjM4He1LwWq1jJR1zhVHL7g=;
	h=From:To:Subject:Date:From;
	b=sMpwlgblU2/tTErR4FHmiNiIxF3tokkHbpSJahcO7spQarhloTRD39yKKG8VI6Imz
	 B4vPuI9FO8nlRjZDB+QeKDxEHD66cUhQnIhwnSyca0tmpRJSIrgUQ3Plg2H9n5kbMS
	 8cO/ftm40m1oKZfUFOTbEAahHhINQnp9jVvNsELxVfF7fsBE9a22GeF7AaG20g/abh
	 1T4Rl9mwsFwm1sxkF4NIdP6eElbUSGU9cDY4UEo80TUxzS/1PJowEhMOObPkvpjE7U
	 KFp5WbdiKFXrJru245nioo7Pwc8C2IhpYRkPuQP3SL/zDUxYPIwbC+S94UAtf5UCbr
	 na62dV7nv9vKA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: send: a couple trivial cleanups
Date: Thu,  6 Mar 2025 17:55:52 +0000
Message-Id: <cover.1741283556.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Simple cleanups, reduce code, details in the change logs.

Filipe Manana (2):
  btrfs: send: remove unnecessary inode lookup at send_encoded_inline_extent()
  btrfs: send: simplify return logic from send_encoded_extent()

 fs/btrfs/send.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

-- 
2.45.2



Return-Path: <linux-btrfs+bounces-2166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D634984BDF5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 20:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6642BB21978
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 19:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD4C1400B;
	Tue,  6 Feb 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="S2DLHAr3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB513FF2
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246756; cv=none; b=YR7pHYlnxbTd3Tmas3RBjBOFk9CkTCFzpyT40FLg5xm4qMQsdf02+++6hok4WjOlVh1Je4FRji7QfCJvBip6zW10tSzyg2199WP9+Xnt8MxpdadU4oFybjQmTefaVVkZBIi5mMmhsXTg3zXM3YsuqMT1mnIhwWtUZdXOE8B6lLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246756; c=relaxed/simple;
	bh=NwgP7uEi6//K+h/JF5g+xNb1OLdhIOnW/U7LB+yarEA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uSXWgX+lfyk2zu6VjWUioQTIqO+XZ6Y9a/Ai1hbB8MRFixsKcYvijwq7HaQqniIsIT1o46okZMVO4fTAmJZ0gUW6xKDGD1R2iactukgs7ywXp0QO/po7jdNYkfY1fmhhhiFkOkLCYwODT1sQRYScyWc0ONnGVCYDJjFz7frX2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=S2DLHAr3 reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=95gImdf62C0+SpaDYJoRg4SuLen7L/d3ED9MAXxuptw=; b=S2DLHAr3BXgqDcNzFxBel7YKjs
	wCe5mHmoTRMeJF8HKEb4NKxdPRthD5lsAjBBC3Ac0nHWDkhncYJ1WRtpmXa9rCJnImX6BfDdYWngD
	bmbIzsOu9xcwMKmArPrf1BkWZJldsVvI4rkjLzEzKgRmbZd+T3c4wsAm8uiKFq+ZC1jRSRzK5PeUl
	o039Y3XzvTsSAHmZyZCH8bwXNIBJI/bl7Fb3VxmcDaav8t1T7FIU3N0YZeQC56N1kA/VvWO1JvE/V
	7njaF6E2mCP0XCk6RU/vmnV1F1MR6b3sZ99gfJGQ9Qd9YIZ2IV+HhZC8fvzV5AaBYR3mAD506ehLa
	AXW2Ammg==;
Received: from c-76-132-34-178.hsd1.ca.comcast.net ([76.132.34.178]:34882 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rXQrs-0002HF-Uj by authid <merlins.org> with srv_auth_plain; Tue, 06 Feb 2024 11:12:28 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1rXQrx-0010eI-0J;
	Tue, 06 Feb 2024 11:12:33 -0800
Date: Tue, 6 Feb 2024 11:12:33 -0800
From: Marc MERLIN <marc@merlins.org>
To: linux-btrfs@vger.kernel.org
Subject: How to delete/rewrite a corrupted file in a read only snapshot?
Message-ID: <ZcKEoftmxxp3SOiB@merlins.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org

howdy,

I'm seeing this during a background check:
[374402.156920] BTRFS warning (device dm-18): checksum error at logical 4401320624128 on dev /dev/dm-18, physical 2939697954816, root 63534, inode 595460, offset 1506283520, length 4096, links 1 (path: nobck/file2)

this is in a read only btrfs send snapshot, so I can't just delete the
file or the snspshot (I have 20 historical ones all with the same broken
fine).

can I either
1) force delete it with some admin tool
2) even better force/overwrite it with the correct file from source?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08


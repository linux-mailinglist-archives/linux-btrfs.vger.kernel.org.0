Return-Path: <linux-btrfs+bounces-3262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3183A87B007
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 19:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0C81C26381
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 18:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57376129A95;
	Wed, 13 Mar 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="BGN5SjcA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87532129A74
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351167; cv=none; b=LaFjzAka9VpBqxSadSpBP8crn6OJvJZrOB9DqDScBjK3UtIadqFIx2jvUkPm0sNvvmdqrwORkc31nsmo5kSwACE0wRh66uXt5mc+qRbCnIHNUmBgHeOZI/AgQ68U32dY3ig5o1rquVuyfFAOwTyPGhYoku/qdPYBzOPJi2gy1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351167; c=relaxed/simple;
	bh=O8EZsPxJjxRq3BVcydxzyK/ee+0QgH4NAPAv9/pXmO8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bwgWFVb47kE7aGUMw9A8CT+RxWYI4nkV33sXJatiMWHidI4OUeVn8ynyKVbkygqk7lyzoxfTmyO8/GK66qRNi2XJbwiZh4ROZG/qwZ8MXwGUATvugZh59HgCRonUNTv58Neq+ZqwhfDxkMif6rCWIHbMPO6vk6T5Ti6+WH/Fi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=BGN5SjcA reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=622ROBwYYRhuURsjg0aBQ40AWKzVDfX9hlQAKKJDhLw=; b=BGN5SjcAQ+MOz/CjAGmhWT4id5
	ynWLkvwoe9ObgcLH6mSZLgyqGmwrYyg0TOPuVeoL020p/GoazmNvJGyO4fnNS+CuUFuknkKxNID/d
	oAQ4CmY5vxqjjChmhXLs1oX5BtGziEa2DGpZcmdItbPWWanB/pVYwqn1TLXjqbIUgk5NVs1xyP/Dv
	YCP5nv503U/zIyZhtak3Iwg0NpxiP7AcmgCKeAFOov0wgL9VEx/KXsYG+mU9s4gjtYZ0+0pR9/pcv
	vxU+/EV2FxMCaHRWwNLCRJCamxcRRX20w2gBSxd1CLGbaEXxTBf1Xtkr5WydWQCBPz7qwCkkUn/F2
	xCn9N0QA==;
Received: from c-67-174-202-117.hsd1.ca.comcast.net ([67.174.202.117]:35924 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rkST6-00028m-HV by authid <merlins.org> with srv_auth_plain; Wed, 13 Mar 2024 10:32:44 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1rkSUE-006NyL-15;
	Wed, 13 Mar 2024 10:33:54 -0700
Date: Wed, 13 Mar 2024 10:33:54 -0700
From: Marc MERLIN <marc@merlins.org>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Runing bees for block de-duping and avoiding btrfs read only
 snapshots
Message-ID: <ZfHjgmvza67g2pbC@merlins.org>
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
X-SA-Exim-Connect-IP: 67.174.202.117
X-SA-Exim-Mail-From: marc@merlins.org

I have a backup server that gets btrfs sends from multiple machines.
I've been trying to use bees to dedupe blocks from multiple backup
sources.
Looks something like this:
/usr/local/lib/bees/bees -t -p --timestamps --absolute-paths /run/bees/mnt/a97dec85-a0d5-42ab-a0ef-e9b7479fbe43

The problem is a lot of my filesystem looks like this:
gargamel:~# l -d /mnt/btrfs_bigbackup/DS1/Soft_*
lrwxrwxrwx 1 root root  25 Mar  7 21:57 /mnt/btrfs_bigbackup/DS1/Soft_last_ro -> Soft_ro.20240307_21:56:57/
drwxr-xr-x 1 root root 196 Jan 23  2022 /mnt/btrfs_bigbackup/DS1/Soft_ro.20240101_03:13:05/
drwxr-xr-x 1 root root 196 Jan 23  2022 /mnt/btrfs_bigbackup/DS1/Soft_ro.20240107_23:25:43/
drwxr-xr-x 1 root root 196 Jan 23  2022 /mnt/btrfs_bigbackup/DS1/Soft_ro.20240212_13:26:05/
drwxr-xr-x 1 root root 196 Jan 23  2022 /mnt/btrfs_bigbackup/DS1/Soft_ro.20240307_21:35:59/
drwxr-xr-x 1 root root 196 Jan 23  2022 /mnt/btrfs_bigbackup/DS1/Soft_ro.20240307_21:56:57/

I don't want bees to look in every single RO copy to try do dedupe things since
they are already unique thanks to btrfs send/receive (that's how they were created)

bees does not seem to have a way to exclude some paths, although I could
give it --workaround-btrfs-send and then make a single rw snapshot for each
of my btrfs send targets, so that bees tries to dedupe those blocks once against
other snapshots from other targets.

Is it the least bad way to do things, or is there another way?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08


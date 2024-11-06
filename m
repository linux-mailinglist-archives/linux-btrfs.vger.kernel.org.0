Return-Path: <linux-btrfs+bounces-9362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6681C9BE63F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 12:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6AAB25054
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784731DED46;
	Wed,  6 Nov 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQugLM3E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2E1DF75B
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893850; cv=none; b=S+oW0M8Wf2B5Ls771Wh8gGSyosr1bdg440iYuaH7pbMSX4dkg1SZZv1lp9ps7L5BDCJRTeP18LPymb8zz+ByHZPD1W3WVIdIqWfSc0EPc36O59/EfK99fckn7OSLh9W4e8LJToxsMcSSWq03zJobYgnZU47ZdqZA6ZLSGDF+xk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893850; c=relaxed/simple;
	bh=iLM3E+km3rGhHGFJ2Eo/mPGafobaiVifENVaVk47zUk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YVEdq+Li0Xm27iaXVGE/ZeDII0i+gphWMVxb357s5FeR0l3fpNF716xxdh/mikfFufj9CC4G2B09hhaMQSGApXU+wU31h96s26saN+TE/0VEKGYnd9nX26Y7ns0lMB0r+RQebi9s3zQsZIacqGmfXpg8/4Ks0jhO2lhGTCmDnM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQugLM3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DDFC4CED3
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730893850;
	bh=iLM3E+km3rGhHGFJ2Eo/mPGafobaiVifENVaVk47zUk=;
	h=From:To:Subject:Date:From;
	b=EQugLM3EARgkYIEE5ngiZAYgMZYrThW4ZKsMSKnMK+TB1f96b2Em3gRQRW2/sLkXy
	 BDO0ysa0T1jsjaEUvBVN2ceUoMz6ZNUdJ3R5tPhL+TTP44vYW0SF4BW2u6kZK+4B/D
	 b54Q/Rb3xwu5CoFzn6kVv/BUSMLT9/sBz4onaKgqoXcS0KeQrEGSRtSZ/k3PvGoZQN
	 jff/8J1CLjoExYRU3TU0OdCORYJYFBV/oPhhTnUdnOXwlF8xITStc4nZrR/cSWkLpn
	 8YnTgISqF4AaAHkREAUvurFwhfYdQbKvF6s0wmj2ThmeGW4c64/p83K+rfAnW4lIdT
	 W1cXHIH7fjcLQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: some fixes around check send root flags
Date: Wed,  6 Nov 2024 11:50:44 +0000
Message-Id: <cover.1730892925.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Do proper checks for dead and read-only send roots while under the
protection of the necessary lock. More details in the change logs.

Filipe Manana (2):
  btrfs: send: check for dead send root under critical section
  btrfs: send: check for read-only send root under critical section

 fs/btrfs/send.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

-- 
2.45.2



Return-Path: <linux-btrfs+bounces-5792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EC590D703
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 17:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D7B2846E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27320200DE;
	Tue, 18 Jun 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiYzWjD1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C431E4A4
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723682; cv=none; b=bv1oxt10BiM9vxKKveZ8tVTjHb0DX+H66Yx7ffbkhbsFJ0olTqzEkf0oCcNwtIiDhZrg4ZnFj0FjHZToge8AJ5AxYoUffJ+PHRXLJ+MiQGKkKtGEa1u5XIuCdSeuKsn5bk4OagjMZPUBhBeD9LWp99bcEwFvTF67lb6RjgPam8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723682; c=relaxed/simple;
	bh=LIQIOtHpmV8uYdOMzp5SycXRP6Wpi4b4NH29qHSenZo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=t+tSm2D29B12sr0E72zwsW1bSWWekFrKfElGdV/oiYlrljfb5i3wjAc/wIVJm/bRYIIw9vGMviC84Wkin8ghNkAl0ZLEfN/u6AWrJWinZ39xx7KHEn8LbXL2M70X1LuzZSYsRqOOHPnYPO1RwCckBOL18MXq3HehaFctgHeRx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiYzWjD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B65C3277B
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718723681;
	bh=LIQIOtHpmV8uYdOMzp5SycXRP6Wpi4b4NH29qHSenZo=;
	h=From:To:Subject:Date:From;
	b=WiYzWjD132ZYzhlUIlZB0z5CDq75YMZemBOF4DJE+yd3ipoCbF+E2F3cq4/uwDoUI
	 wr+eWheygpf2DvcNHKBjiD5pLN2PPFAOvhRg9xaI9uXjxzssl+nMQpdF0Ne7Tl5qgF
	 G+kp8v/AeuniFi6OphG7nXyDxLkeMrpZAk1LDjnbn0h7F4pGBmOKStAAtnRV4NsXYr
	 X90AlbIEKN/UI9SmBSU/rvvbuWEYINRxjXDzXU+ovvlXAR01QRt14xYIfkf25sEV2r
	 hG94c1Bg4FRMiclJ1ltHfTdVXIF9T4NfduO8z/+DE+rjrgz5wVwYsL7Q02+ZT+JshJ
	 aaMPUMneoUnFw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: a few cleanups for update_ref_for_cow()
Date: Tue, 18 Jun 2024 16:14:36 +0100
Message-Id: <cover.1718723053.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Detais in the change logs, trivial changes.

Filipe Manana (2):
  btrfs: simplify setting the full backref flag at update_ref_for_cow()
  btrfs: replace BUG_ON() with error handling at update_ref_for_cow()

 fs/btrfs/ctree.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.43.0



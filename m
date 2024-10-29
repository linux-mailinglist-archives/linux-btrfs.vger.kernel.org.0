Return-Path: <linux-btrfs+bounces-9205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF589B504B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B4F2852E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB5E1D9A40;
	Tue, 29 Oct 2024 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2jsf2En"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341572107
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222575; cv=none; b=MeyTvNnvhSkNn5i/B3M4l9qtRsjl5LqqE5ji8V/kB1zNlYHpZXi5hHN1Vwy7PheILZ4mPQBfN7/R7WeA47CWHwUVHid61EnR1Kzbb0Dtfdno/VNkDdrDKgOtgwQkXpAdsqbBAKwU+39vPf1BOZ4DUeC0GOQcaMt1gXc26Zi6MWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222575; c=relaxed/simple;
	bh=bo1WRf+0gmpDfLxniHsXii5Rpzb39SSyYnuBwNzVRHM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QWrY7RJazvsY0+cMtHqUIFvTNY4Yf2a+923IYtDkq0XdG1whHcB2aYs7lAkn+TttL5VcS1z6U+ibd8cLTOjTwZU615sBKIUtdpZ4h4gQ13A6u3VpgJ2uGiWgNWHH3D2s8t+CJ05tnfDLZSHOHnLvkdXmzpe0r0ZKhnCmFFumiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2jsf2En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E8CC4CECD
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730222574;
	bh=bo1WRf+0gmpDfLxniHsXii5Rpzb39SSyYnuBwNzVRHM=;
	h=From:To:Subject:Date:From;
	b=a2jsf2EnAdMKM0c6xU6A0/EI3lE8Gem4JUQbrl1sUyl8/zCmmmpUA2bbAmsRSkWE2
	 gXUwUYFOdSs//BCzdf37ESZIyPgnP6DKE94H+LlIKyBoKXigZbkqh7acjBdWiqCKVl
	 ipeH27ordGns7wOG4VXxcHZ3jeE7IbXk2frD+0k9c6A5Qv2Uo1WshhSh31ZSGzC/nX
	 PYOmIlA74ZYyq+8ZE3u5hMPqXfAw+2mzfu1Prom/CXEjpK20AD2KL2LMVboJfcdTd+
	 PNiiQAct2rMKAyMOc0DHk5elbeoEYXmuEPQX0+q8dGUb2Z2GngIwFF9s0CDx7C4r0u
	 PLlXeo5e8ipxQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: a couple fixes for extent map merging and defrag
Date: Tue, 29 Oct 2024 17:22:42 +0000
Message-Id: <cover.1730220532.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some fixes for extent map merging not happened when it should (which avoids
saving some memory) and defrag not merging contiguous extents when it should
due to merged extent maps. Details in the change logs.

Filipe Manana (2):
  btrfs: fix extent map merging not happening for adjacent extents
  btrfs: fix defrag not merging contiguous extents due to merged extent maps

 fs/btrfs/defrag.c     | 10 +++++-----
 fs/btrfs/extent_map.c |  7 ++++++-
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.45.2



Return-Path: <linux-btrfs+bounces-10078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E820B9E4EF0
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35FA283B18
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0BE1CB518;
	Thu,  5 Dec 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jnj3Ar8+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E451C07C0
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385030; cv=none; b=llDg6EdY06PJwbAx6Q0/7CnfGcmnBIxsWw9DXUD4HUcTuedDAyOFSYNH+RS6+vOlSpHG2xFhcxjcZo0srerEyT53vxcP6qDNZ6n11i/d7YgwTYADo/3JR0cM93C/k4Fg8VyBmoEIZcyT4aPfTU0uT4iDZFOsRFCmlJwJ1y8PPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385030; c=relaxed/simple;
	bh=O24tceXdPH9SXIYhNagjzLySpjXnqbkC2A8hCZkz0PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg0A/7lsLYjxrbAGo1qYUN+bI2FyzxlBqDxNTAZIRxmJ9QFWasaSEU7PlPhFXE6+DCMbWvhRz2Cq7YRj0hgX2Z97Fwc39NHnMDzoTNTv45B64X4t00dIQaYzlQ75Cm/GUvRpk/bhLLvyIYTIu4K7B0zntl9eQVDJkoBMcg7Ftt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Jnj3Ar8+; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733385028; x=1764921028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O24tceXdPH9SXIYhNagjzLySpjXnqbkC2A8hCZkz0PA=;
  b=Jnj3Ar8+r4VoLZirrM7Vqn2Kged86mZjUEMAH0WFwk0qrzdUXV5lRj5p
   4Kb/s9mtoR1kL1aSFpMAx4JYQcFuIU/JTGlINGTvm22poYukQFfxbr5Mw
   u+7d40ZdQR7KcOT4CVIPeZXprEzPBWLNFlZH7f4YsFvrRTKXAmebHN/T8
   HNAYDCHRQ+00iNG/efgXD6xVzXkhAfIGxTsI74bXmda6qrSjlgvTq+rZr
   chOz8sB9bZC9L1UkX94kSjlbPsg5zhuRkJ6ItJU6qt+Vwm/Iqilwoq1cU
   d/vsbK0sCRXiwb2MIe3st5fd397tz7oCrU8qx6w7s2EkjBQz1r/n5BFUw
   w==;
X-CSE-ConnectionGUID: DBkW6k2dS+KsDAc6SMq0fw==
X-CSE-MsgGUID: 3jE7qvjZSaGLzF13y6eUgA==
X-Ironport-Invalid-End-Of-Message: True
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626110"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:19 +0800
IronPort-SDR: 67514c59_hylhd4/iaGsQFhUo2o+iBt5k9CdSZcLWSMe9ZVWt2dHcxEt
 /stZMsoiqToRCBsFJ6lQUkQiWFiitBOeYUhayrw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:49 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:19 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 04/11] btrfs: spin out do_async_reclaim_data_space()
Date: Thu,  5 Dec 2024 16:48:20 +0900
Message-ID: <6d7d620adf02ddf7245c991cd74696633cc279d3.1733384171.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733384171.git.naohiro.aota@wdc.com>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the main part of btrfs_async_reclaim_data_space() to
do_async_reclaim_data_space(), so it can take data space_info parameter it is
working on. There is no functional change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 782807c926e1..1fb55655f49d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1323,16 +1323,12 @@ static const enum btrfs_flush_state data_flush_states[] = {
 	ALLOC_CHUNK_FORCE,
 };
 
-static void btrfs_async_reclaim_data_space(struct work_struct *work)
+static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 {
-	struct btrfs_fs_info *fs_info;
-	struct btrfs_space_info *space_info;
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	u64 last_tickets_id;
 	enum btrfs_flush_state flush_state = 0;
 
-	fs_info = container_of(work, struct btrfs_fs_info, async_data_reclaim_work);
-	space_info = fs_info->data_sinfo;
-
 	spin_lock(&space_info->lock);
 	if (list_empty(&space_info->tickets)) {
 		space_info->flush = 0;
@@ -1400,6 +1396,16 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 	spin_unlock(&space_info->lock);
 }
 
+static void btrfs_async_reclaim_data_space(struct work_struct *work)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_space_info *space_info;
+
+	fs_info = container_of(work, struct btrfs_fs_info, async_data_reclaim_work);
+	space_info = fs_info->data_sinfo;
+	do_async_reclaim_data_space(space_info);
+}
+
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
 {
 	INIT_WORK(&fs_info->async_reclaim_work, btrfs_async_reclaim_metadata_space);
-- 
2.47.1



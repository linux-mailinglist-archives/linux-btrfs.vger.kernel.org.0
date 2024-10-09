Return-Path: <linux-btrfs+bounces-8699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D59996DD3
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577D5282037
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6978191F99;
	Wed,  9 Oct 2024 14:31:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F81DA3D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484265; cv=none; b=At3PWIDd5q7TJHKZx3VQLsR6Xg7lSmqFrKxtJ1BX2i/S2kEOtFJpAQAWc0ASjCzapfxFMsqAEU7BUFI/z9AlYJbnlwRi0wuLuSuZ/CiDnudkzLi97B0zqdazjV3XEw7VdCLCPwt7sE7tfxsb2XkvUK6hA6cc1G+2BKuRf9Ax0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484265; c=relaxed/simple;
	bh=idjp3Ks7GAlxvLaHd5XNmwwj+vf70EWmMuYYnwoISXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y477THgeqFO6GC2B1IzbA1kE6TB3v/vpJU9B/QR/Zt/1YLhET+FLYmonbKsv9Jaybkt5GyKlALecFPy3lduseVMfC7GWoCUy/K8Xp5ZML7rdrFhASUkVIbuu5/Z3VgOejyto8eIKgi0a1qON5SZkGBrmXJEfEQyjzwAlSe9NurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55E6321EB2;
	Wed,  9 Oct 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FE0F136BA;
	Wed,  9 Oct 2024 14:31:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RQ59E6aTBmcBRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:02 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/25] btrfs: drop unused parameter fs_info from wait_reserve_ticket()
Date: Wed,  9 Oct 2024 16:31:02 +0200
Message-ID: <7ecd1876d9aea569188c78d242abca0650ab75e0.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 55E6321EB2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The parameter is not used, we can also reach it from the space info if
needed in the future.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/space-info.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ee23fae73f47..3c7ccb3935cf 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1488,8 +1488,7 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 	spin_unlock(&space_info->lock);
 }
 
-static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info,
+static void wait_reserve_ticket(struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket)
 
 {
@@ -1547,7 +1546,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	case BTRFS_RESERVE_FLUSH_DATA:
 	case BTRFS_RESERVE_FLUSH_ALL:
 	case BTRFS_RESERVE_FLUSH_ALL_STEAL:
-		wait_reserve_ticket(fs_info, space_info, ticket);
+		wait_reserve_ticket(space_info, ticket);
 		break;
 	case BTRFS_RESERVE_FLUSH_LIMIT:
 		priority_reclaim_metadata_space(fs_info, space_info, ticket,
-- 
2.45.0



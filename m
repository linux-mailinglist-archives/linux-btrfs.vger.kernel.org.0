Return-Path: <linux-btrfs+bounces-19900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A4ECD1198
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 18:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DABE1307E886
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E582133BBD2;
	Fri, 19 Dec 2025 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB2BQVew"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E316922D781
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164489; cv=none; b=nuKz2oMJl1+KSY09gOY55FsKUG+bsXhuc11rRngbPY4O9FMOGdrvfD8O7xBtVmXhJUoiN8aRp3MdsH75gej1MrBb66jp3U9EWMWp5o4x1RkMLJKCtXm1PRONgHRjjLoKmlPowu5Vysqee7wp9nJpHsmMnIFzd0sZqIUdJy/T3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164489; c=relaxed/simple;
	bh=dOfzmdQ6XtteHHqpWuXYEoXSYwJ5ISZ1weqIeOWwefQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lEW8XW2n4B+XDbKQK7RyERIh75mCeV59hhX+/QZxnXtZjQAI3hlB4I6mbbPXk8MaRcZhlMdLGC8DKBJCum4Z9g4+fQFwhotLZqv9Fs2s6EO3ubzfLuTfjDOxPGIzEg4E+oiqmf2gThT9QEUSmRQ2zWhx38jrZpEH9pSe81wmMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB2BQVew; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so2393822b3a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 09:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766164487; x=1766769287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FI43llsANdqGe6jTH+zTysLdat4X1xckyHWuski/dgo=;
        b=FB2BQVew76rhabnSRjX0NWFbmefiYUGYy65lQiArx1QoaU4GqDENq895Ty9LvFMosS
         m7hwLADIga5Xa6w78XywvniLTntt7S8B/qao/WJqYRunwHGgdhTkYqCEWxvK71qU8J/Z
         MXazKNJ3WUvsz9GGkbQVrbKdNl5clqOBTiU06LPc73/NkGeD+fX4oPVXgKAOOWVg78iB
         +qCGMKiVYbK3BC7KKh9iuU7Gx2o363n/9aHbfNyGn3tqSm2CNfZAu8wfip54bpJAt+ir
         6UaU7v/HY/Quukj1KgpXssBHoEHJfvum45Qb2ONhzV2WcqtKL2UIbvTkBgyh5mUYSmBh
         BY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766164487; x=1766769287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI43llsANdqGe6jTH+zTysLdat4X1xckyHWuski/dgo=;
        b=uWKU172M7uVFnWMpI9n5xCMxL11Z1BQlt4VbWMBeVfx9om/Ucnht2mRk1EVbZVKpwl
         h4yiLokppORFbs3AU0UPJNRXG+8bCgArSXOeQS0gz5TAI5+ughZYP0Nj0lPUqkTdkr1K
         DmPowNf2/vXMh3XX2cxykDH/9u7nMO7oaCLWQnrKbygl+kMPiZERI/Z3kv7HWnQ9EnRm
         ZbZzvpGhklFYBFjvGYaHTOW2k7oVNEGdyD1O3+KPTxhJjJrergwesmmvh6p50TazCftO
         tGfO23hZg6UcBys9UAGgSvjG08OImMBc+aknY2BEKdcsZy94GwFmWy/cHzVDcQ6FMD1b
         rI2w==
X-Forwarded-Encrypted: i=1; AJvYcCUsKag6+LevayQn27DJZ7Lw+5A9PNjIMYgg3ZxzUiNH4vsn7DTE7LbRCmxRUcX7DFXEPe9v2X2GvZCF7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vY2bEeN9hypbcFOBhC3hRuj6agowxanDHjLmR+8Ifh4g0+tt
	VGMEZF+0P7mslWLmTVelb4an/c1buiWEhceaTZnvt5uQaz1YMcA7CzCTUmxkcLHa
X-Gm-Gg: AY/fxX7zurRT+e+tJzFfTaKiYNeX20xMiOZv8zrSxNQ73NWpN2x+w6e1zmZsrrJfKmV
	5RpJlkwH0ZhjyjMjsPwm80mH5ekZY6BLqSraIHUdK1j8firN9cC3EEaVec/NA18jxcHWZwjy1mh
	ZnwtkOWGM8PJfhrxS1NsZaGj0kqo0yYyXygn0X05oDPIeJIqYi2UUm+WTiu+TNdMdulzZG9SSpz
	HrE3EtIRznXcmrG0VCtQNZVSg/5IJeDcbBE1ZHMg4TP87dc+nqzYyAA2busCkD8sHeqEXIP1e9O
	wZUBNsyvVX/MxWMLxdbFNFQ2Ug3LwinHyWMlAySxXe6LxOKmfe1ruEkYH8uLq1VQvbTMeI5z0zS
	uZMAgpKZI1a5wsO8yhNtEhu+VoVMHrbqYPBCe5jC4wOK78ZEGq6kM1g8M/3CSu4uSC7zTiNvP0t
	q+mlgKO3jtuMCKvdo7jCzg
X-Google-Smtp-Source: AGHT+IEi32XXAS6VGNRuRqya6xBow9Yt0eEjyaeRRuCEQInqjEE+xMj/FCOW8zT0x16srCdXUcDczg==
X-Received: by 2002:a05:6a20:244f:b0:36a:d3c9:efa5 with SMTP id adf61e73a8af0-376aa2f47demr3429123637.52.1766164487023;
        Fri, 19 Dec 2025 09:14:47 -0800 (PST)
Received: from archlinux ([205.254.163.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1basm2219024a91.10.2025.12.19.09.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:14:46 -0800 (PST)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: clm@fb.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] btrfs: fix NULL pointer dereference in do_abort_log_replay
Date: Fri, 19 Dec 2025 22:44:34 +0530
Message-ID: <20251219171434.46411-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity reported a NULL pointer dereference issue (CID 1666756) in
do_abort_log_replay(). When btrfs_alloc_path() fails in
replay_one_buffer(), wc->subvol_path is NULL, but btrfs_abort_log_replay()
calls do_abort_log_replay() which unconditionally dereferences
wc->subvol_path when attempting to print debug information. Fix this by
adding a NULL check before dereferencing wc->subvol_path in
do_abort_log_replay().

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5831754bb01c..2d9d38b82daa 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -190,7 +190,7 @@ static void do_abort_log_replay(struct walk_control *wc, const char *function,
 
 	btrfs_abort_transaction(wc->trans, error);
 
-	if (wc->subvol_path->nodes[0]) {
+	if (wc->subvol_path && wc->subvol_path->nodes[0]) {
 		btrfs_crit(fs_info,
 			   "subvolume (root %llu) leaf currently being processed:",
 			   btrfs_root_id(wc->root));
-- 
2.52.0



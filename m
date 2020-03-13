Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5E01850F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCMVXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35784 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMVXi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id d8so15180184qka.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MjpBDu3DvLHdLQlEJsG9wOFmdfa5YlOMrWBrCYztOUY=;
        b=eirBYdHvQn20irLlyOmc/DvfGSxKLpkJRXuPwxZuZQX7zphL+vHjBUQkKqK7a4g2qP
         vaAITl94eLqCc9pMYeZggZWexWln427EMfJs8YOzA9wxQmrbLzUCjpcSrkgu56pPGBez
         Sirzb/3dM4Z1u5C1iiBlEblCZskpSn7Ai2GfUhD0ONSR3GIRSZDvjeyHuhVu1v4qu9JD
         aPkU9haXH9UrXW0q3WhBEa+MthQn1OLnPF4WghzHKF7Cpa9yNOv1oNHUemE4ttJdFQnL
         X8ayTF6/8TABQqVsbnh+5cgAGIKd55PRIvxvtprOMk6YfxEtzGVLr86NyTAjCVLso4Ug
         m1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MjpBDu3DvLHdLQlEJsG9wOFmdfa5YlOMrWBrCYztOUY=;
        b=bh9I9JE9Euu9i6tqrDorAKA4LpN4Evrn/gohTqUNzT0kJsHMHFy3V8y4yPicjBM+87
         2senZENB9CoufEsOcyyk7/fFwGoVzO3h5uZDQhqua7Yjgi5QvCC7TsTtKqE82zIgYAKp
         TgwW1ynRoJjuB8TDnxvEaCMgnWexX6RfZZOoIjTf7OVxuYhyxqjoQwvyN820aCPNLWwf
         vdYCmYaVgGDubTl+Jq8gWtM4xmsMmm0MgaZIDFV0JJwBynl7sMVLBxFGUvt1wuFNFL/G
         dk81Wf6DJU59aQrLU38ADD/GRV7UfRpmohr6z4cm7XdAZ0vXvIDUrLrELjbjoK3hhKSG
         b93A==
X-Gm-Message-State: ANhLgQ1473Yj3OBngg6dHGNaQ8B2ThHwCUrrru1Z+JrXJ0NwjqwZdnFF
        3gX4cMRzzXIWcqxV+cZdznXbUfzxqB3JLg==
X-Google-Smtp-Source: ADFU+vuL9ZwrKqTtoaBwTIhT6ah+X8W2KCrgEbZ+wQOROBwVhk2nPMgderIfyqJANursj7OouGzeBw==
X-Received: by 2002:a37:393:: with SMTP id 141mr15033819qkd.393.1584134616192;
        Fri, 13 Mar 2020 14:23:36 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w134sm30254314qka.127.2020.03.13.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/13] btrfs: change btrfs_should_throttle_delayed_refs to a bool
Date:   Fri, 13 Mar 2020 17:23:19 -0400
Message-Id: <20200313212330.149024-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't actually check the specific value from
btrfs_should_throttle_delayed_refs anywhere, just return a bool.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 6 +++---
 fs/btrfs/delayed-ref.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index dfdb7d4f8406..acad9978b927 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -50,7 +50,7 @@ bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
+bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
 {
 	u64 num_entries =
 		atomic_read(&trans->transaction->delayed_refs.num_entries);
@@ -61,9 +61,9 @@ int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
 	avg_runtime = trans->fs_info->avg_delayed_ref_runtime;
 	val = num_entries * avg_runtime;
 	if (val >= NSEC_PER_SEC)
-		return 1;
+		return true;
 	if (val >= NSEC_PER_SEC / 2)
-		return 2;
+		return true;
 
 	return btrfs_check_space_for_delayed_refs(trans->fs_info);
 }
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 1c977e6d45dc..9a07480b497b 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -371,7 +371,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *src,
 				       u64 num_bytes);
-int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans);
+bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 
 /*
-- 
2.24.1


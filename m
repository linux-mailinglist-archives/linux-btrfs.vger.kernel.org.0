Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B429C1850FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCMVXz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44736 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbgCMVXz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id h16so8869875qtr.11
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K+OcyLSfcOjmpvj97pGWI9kgRgheJmWWNju1jww1gxo=;
        b=Sjm9uvNO+dUg1S7BY9HBeepjlpd2aQIpmHw4wCY5SFSsALr7xp/lam1ppeGMunjEC4
         Nzb1nhUzfDoOsWGWvLnskAvndLVlu5FoFAlEL8gebAYHYxBQMOSkqRTwYspD8GA9k/og
         YJlnJw87nb4dex0r7IcMg6twU0YhuVqw4+JQh7oQ14Zo5Eh00pvwAnrNMUZN29hKsYm+
         VryEYj/dn/qKKze/9fqfqQ6LZa3Bt36PJzZQb/q06dYBvwPofM7sLjECqzOqeC/2NRSV
         yFcF2P3RIS6udKUYSSo9Edu5s4wSs2lx6EAshQCNeSI3AGpHWNh4W7NG3qu8IUDpUmVY
         AeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+OcyLSfcOjmpvj97pGWI9kgRgheJmWWNju1jww1gxo=;
        b=GN2wUQ/yWYjJubym7Xb3ngy9B54SWPfn4dGiAY9o2kqYsx/ecBA9f+aE6vGSLEZYI9
         a19VUW5ugbuVB9zxDP93Iz1mnMKbok0ztdQsFiIr/Zp2TgK18rBGmGJFpqIHauJJdeN3
         /twGh1yNUar10hrrpiPHY/eRhr4FcAiInYZ/FL9ZNtdoWhihYTvzZA9wA8JFKgV20D5r
         P6neOMBkqNldwU9iXrMUnX1p0QI0j0F/2sg8sLC+u44d2SnyKENCrnXuIv1ZwrLn+Df+
         I2qOkEwBoKfQ8Zx15ZnPNT+9kTPg2bYTVTSTYzlFMKOaZd0AF3E+0BWI7kgxBemr7Shh
         f9UA==
X-Gm-Message-State: ANhLgQ11TN1eoXc/30WyaYC7BIgJ919Qflsl7/2Qxjd+AWBD7foAYjxG
        GY4l8tuMkc54uEQPnWsMAv+kH82cZqkkCA==
X-Google-Smtp-Source: ADFU+vt4eBDO14OwtD9f6K/c3yX/4G9jXG9J1IT4g868cziMWbPQDzUuiLo5OwVYelDeTLVRPayALA==
X-Received: by 2002:ac8:8e7:: with SMTP id y36mr7153077qth.26.1584134633782;
        Fri, 13 Mar 2020 14:23:53 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g62sm29733131qkd.25.2020.03.13.14.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/13] btrfs: throttle truncate for delayed ref generation
Date:   Fri, 13 Mar 2020 17:23:29 -0400
Message-Id: <20200313212330.149024-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Truncates can generate a lot of delayed refs, and if we're over our time
limit or we're already flushing we should just bail so the appropriate
action can be taken.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c9815ed03d21..c39794a95acb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4386,6 +4386,21 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			 * let the normal reservation dance happen higher up.
 			 */
 			if (should_throttle) {
+				struct btrfs_transaction *cur_trans =
+					trans->transaction;
+
+				/*
+				 * If we're over time, or we're flushing, go
+				 * ahead and break out so that we can let
+				 * everybody catch up.
+				 */
+				if (btrfs_should_throttle_delayed_refs(fs_info,
+					&cur_trans->delayed_refs, true) ||
+				    cur_trans->delayed_refs.flushing) {
+					ret = -EAGAIN;
+					break;
+				}
+
 				ret = btrfs_delayed_refs_rsv_refill(fs_info,
 							BTRFS_RESERVE_NO_FLUSH);
 				if (ret) {
-- 
2.24.1


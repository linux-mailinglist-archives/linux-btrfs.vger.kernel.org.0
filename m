Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF16140B68
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAQNsR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:17 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46193 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgAQNsR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:17 -0500
Received: by mail-qv1-f68.google.com with SMTP id u1so10692421qvk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yVe7M85mDPSaRnTaTez6+sgZrvbrxmWfQjAWN+qlcaE=;
        b=eLsneslr1raSf5EbHkn7lAiqRqSlUzY8mvFQUZsEA6ZZoKSrchCeEx+DGdvfmUPFJv
         CBOFADDYVNFktpHBlCffjGbTPl5IzcuKrD9NeycYhjPGHMjyTAkJW5JhLHheSbNt7KIt
         TjVGP/tAz6tP8I3i7GB35glSGekTVqVhKPuOGf9di+TkwNkjocGiQ3BMivj6SpZEyWCV
         znFOLMelZfRtcUfTJ4/crUrEd3WBcAnTjp2taNhJWk7EnSJSz1Mhq7pl1SMmhfAhyeu7
         A+Hpd6KjIbcz1Q6Vgh83SqwFMLT5+FjjETNaHcuJah/67RlIx2Z8eRCQ1LYzzpZTFZtD
         w+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVe7M85mDPSaRnTaTez6+sgZrvbrxmWfQjAWN+qlcaE=;
        b=d0K6Kk+AtumzKQ4M19UgMXO206Ir1Oxx5wmpiyTihQP/7x4y/DsVeXKp0rqwTzURW2
         pJVfbXNYLH3wtdQj5BdP9Z5NsBmd1UXXfgUfLxHJwY4zWR0XfllJXs94Kgw1RlaQVGYF
         T8GGYMshW3qPkMEubRBzcE0VGZWUuYRQg9o/vovkUe9rvP4t8QeIgwSzuAnXEUFJEy02
         k2VtUmYZnggy/P2486xmTUFgwqnTMvC/3vUkKlcFAbtViXyypPYr62JErUW5puPOFb1e
         89aX2w8BwXKg5aGn1f/RC/0osHlAIm8l9tkHeGMSLonG7rQrzlU7ywlRuyV+m9RmDV4u
         HarA==
X-Gm-Message-State: APjAAAUpazUEi//x7JO6i2455aztGnmAgHsRGXMauteD4StBDJnssfpy
        XvFvJHBTFXQo+8IAaqg/ZR/ZgN/TSLmPAA==
X-Google-Smtp-Source: APXvYqyK4RxVbbggg9Ssl7wLH8JD13spxOm+epDLaB0qQ4OVP69v4G3TajhGNsyx7ZXX9Hu3ZtJwnw==
X-Received: by 2002:a0c:c389:: with SMTP id o9mr7940603qvi.232.1579268896129;
        Fri, 17 Jan 2020 05:48:16 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 24sm11912196qka.32.2020.01.17.05.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/43] btrfs: handle NULL roots in btrfs_put/btrfs_grab_fs_root
Date:   Fri, 17 Jan 2020 08:47:24 -0500
Message-Id: <20200117134758.41494-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to use this for dropping all roots, and in some error cases we
may not have a root, so handle this to make the cleanup code easier.
Make btrfs_grab_fs_root the same so we can use it in cases where the
root may not exist (like the quota root).

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 7aa1c7a3a115..8add2e14aab1 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -88,6 +88,8 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
  */
 static inline struct btrfs_root *btrfs_grab_fs_root(struct btrfs_root *root)
 {
+	if (!root)
+		return NULL;
 	if (refcount_inc_not_zero(&root->refs))
 		return root;
 	return NULL;
@@ -95,6 +97,8 @@ static inline struct btrfs_root *btrfs_grab_fs_root(struct btrfs_root *root)
 
 static inline void btrfs_put_fs_root(struct btrfs_root *root)
 {
+	if (!root)
+		return;
 	if (refcount_dec_and_test(&root->refs))
 		kfree(root);
 }
-- 
2.24.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08277AB54A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 12:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbfIFKEK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 06:04:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53103 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbfIFKEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Sep 2019 06:04:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id t17so5855659wmi.2
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Sep 2019 03:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mVb62Vguj9zE4LtxWZIBWFQF5Gp4AyZfvi/jCxubWQ=;
        b=b697VWhwqC0S8sl4G/WpkPD8CrNhEUw2OVm5weWznoorsOur6f9pZQJOWzG7TRPh3w
         r2lhOKuDkMTfTcC43BS/VQolGVStBHAY+fW4gsh/UhA/uyaVZvegqdvG06JBj9SUs0mM
         3JTnFX8R8c3TWfJqaamnDNHPoeNP70QNHFgA9B0QoDRdAo8+PIy+jqpJnB9xcDIAebmT
         odOSYs9/Xpu1A5/douJcA5xAqfVdXDRTG/RBC6ZmdHEB1yuNJfMFFgPGe6TnumbYSjBg
         qFTPlropCK3aPXlcQ/tg5rof758ogOVKMOcZ+gBM6ATPfw+qDuPVaxZhUZFEkWM3RRCO
         VFKg==
X-Gm-Message-State: APjAAAWzv90ZjuYk97atQw6wVq9smBE6D/KDHXpXo+7HrBGee/+7aTeC
        4jjG81Pp6loW/+YcfI6lkAv7YvVOoEg=
X-Google-Smtp-Source: APXvYqysmxUwuzaUb0VfAUnJpdV/McnAOxPKtlt5JIrjl6QmLWYx42HaykTRz8DkhijeNjnKViV2dQ==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr2883357wmi.167.1567764247833;
        Fri, 06 Sep 2019 03:04:07 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id f75sm5000750wmf.2.2019.09.06.03.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 03:04:07 -0700 (PDT)
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
To:     linux-btrfs@vger.kernel.org
Cc:     Vladimir Panteleev <git@vladimir.panteleev.md>
Subject: [PATCH] btrfs-progs: mkfs: fix xattr enumeration
Date:   Fri,  6 Sep 2019 09:58:46 +0000
Message-Id: <20190906095846.30592-1-git@vladimir.panteleev.md>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the return value of listxattr instead of tokenizing.

The end of the extended attribute list is indicated by the return
value, not an empty list item (two consecutive NULs). Using strtok
in this way thus sometimes caused add_xattr_item to reuse stack data
in xattr_list from the previous invocation, thus querying attributes
that are not actually in the file's xattr list.

Issue: #194
Signed-off-by: Vladimir Panteleev <git@vladimir.panteleev.md>
---
 mkfs/rootdir.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 51411e02..c86159e7 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -228,10 +228,9 @@ static int add_xattr_item(struct btrfs_trans_handle *trans,
 	int ret;
 	int cur_name_len;
 	char xattr_list[XATTR_LIST_MAX];
+	char *xattr_list_end;
 	char *cur_name;
 	char cur_value[XATTR_SIZE_MAX];
-	char delimiter = '\0';
-	char *next_location = xattr_list;
 
 	ret = llistxattr(file_name, xattr_list, XATTR_LIST_MAX);
 	if (ret < 0) {
@@ -243,10 +242,10 @@ static int add_xattr_item(struct btrfs_trans_handle *trans,
 	if (ret == 0)
 		return ret;
 
-	cur_name = strtok(xattr_list, &delimiter);
-	while (cur_name != NULL) {
+	xattr_list_end = xattr_list + ret;
+	cur_name = xattr_list;
+	while (cur_name < xattr_list_end) {
 		cur_name_len = strlen(cur_name);
-		next_location += cur_name_len + 1;
 
 		ret = lgetxattr(file_name, cur_name, cur_value, XATTR_SIZE_MAX);
 		if (ret < 0) {
@@ -266,7 +265,7 @@ static int add_xattr_item(struct btrfs_trans_handle *trans,
 					file_name);
 		}
 
-		cur_name = strtok(next_location, &delimiter);
+		cur_name += cur_name_len + 1;
 	}
 
 	return ret;
-- 
2.23.0


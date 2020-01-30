Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E88E14E43E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 21:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgA3Urm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 15:47:42 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36442 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgA3Urm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 15:47:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id w25so4392427qki.3
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 12:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O7hULuIQ49SxsfVgabwL6rVar8cqTwExzAiHvdYhV1Q=;
        b=AM55yAasB9eG2Bwa6S/O+2WpaaUW1qjldGBjDmCl28e2NE3qG7BNPIG3mSD0W6f9T7
         ScVCCkKxno3RWGVsgj8y0MIrkwhT48eGsQQwDEwHVMm1+uE9o2RL06+lTTFx0Etq5vAZ
         D2j5JQrsKAy6dqMzyJJuI80Stpsu/Bxzm1ZM8LtO6HyxbenPL5JEdHJfUnu6bv9O7/Pu
         iobXS9TA70zaeL0UT1MZXiyZyPPKf2dsj5v53NLV7MLpmrDnrHsh7/ARXPc9oSUjhHZR
         GSnSxovroIfV7omH+A11E0j+YZlEdF9t3Snr1+Ca0XIa2hflOOpJ5dl9KFmPElkmxPsQ
         MHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7hULuIQ49SxsfVgabwL6rVar8cqTwExzAiHvdYhV1Q=;
        b=fUh0PtSsLTJ2D8Xh2qv1KnW6GkVvUG8ZoMPOn74Rs2WWNjDsByC3N4kmxY4qkBNuTj
         /TIBMxTuX9ErXuEkjj4E+LFjBoO+Sun8iRtvFUWmbtfK2mDMqIl0yoQoyQ5ACNAk7hW5
         rJ1NZOyAUKSbHZ+ay51mPzsvmtEOViHlSsgH4afRY7dIu1XL3WJ3JdNhN0q1lsvKZ2fp
         XIqmb0TiOjJY8kVXCnEnV5BiiD5AbP3KYvsN0XJd2VQDxIzBzsFNSCESH1s13fZ0e/oM
         IEUx7LkSaFnYuy4JnPz363jHbK2c6faJ6d1bVdHx3Buj3KXba1wTIbY3GrOa8suPXHf5
         MoDg==
X-Gm-Message-State: APjAAAUvmG6bRNCLKJcfzuB5Vze/+XPdhtKc9nifpAn5t/6AADLY/C3Z
        V5TVGJcNYNopzscc7jL1M5tmoCfWkz8bgQ==
X-Google-Smtp-Source: APXvYqx3c8dsiWxOWgDqRcX5RpgIBHU7o6VC7esJ68HcRvx6dpX45cp1fGMHC6jK4V1vvNq8CzqeyA==
X-Received: by 2002:a37:9b17:: with SMTP id d23mr7429935qke.140.1580417260640;
        Thu, 30 Jan 2020 12:47:40 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w41sm3758441qtj.49.2020.01.30.12.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:47:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs-progs: fix check to catch gaps at the start of the file
Date:   Thu, 30 Jan 2020 15:47:35 -0500
Message-Id: <20200130204736.49224-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130204736.49224-1-josef@toxicpanda.com>
References: <20200130204736.49224-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When writing my test for the i_size patches, I noticed that I was not
actually failing without my patches as I should have been.  This is
because we assume the first extent we find is the first valid spot, so
we don't actually add a hole entry if there is no extent at offset 0.
Fix this by setting our extent_start and extent_end to 0 so we can
properly catch the corruption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index 4115049a..4ce5a63c 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1553,8 +1553,8 @@ static int process_file_extent(struct btrfs_root *root,
 	rec->found_file_extent = 1;
 
 	if (rec->extent_start == (u64)-1) {
-		rec->extent_start = key->offset;
-		rec->extent_end = key->offset;
+		rec->extent_start = 0;
+		rec->extent_end = 0;
 	}
 
 	if (rec->extent_end > key->offset)
-- 
2.24.1


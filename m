Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB114A7945
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 21:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346955AbiBBUQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 15:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiBBUQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 15:16:08 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D145FC061714;
        Wed,  2 Feb 2022 12:16:07 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x23so1502711lfc.0;
        Wed, 02 Feb 2022 12:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KTX53QeVe+qn2iYkSMS0ikshGW629AcyossUuSgcsZ4=;
        b=FR4jJm0oZx61CfNy4NJy36m7wug55yUBi1esqOskfLVVeK33ZR+d+mjIXyxiBGDKEC
         JNloMIVag9ULVA8QBI9ImYSl3IKTifwa7eVEXmRS/MPArjgure1GraW3jFxesLYtKZPr
         4vg9mkKu/6mcHknp8ScupF0z28gFxi0LaktSRqwZwN8LMvs6gKrF3KS7zdVr/um8nB5U
         s/k/reNsRC0UdaZSkVXHozHr7Gpg/tWygQiZJFzOiKvh+HoQAQFt4Qb+bJOBXGXiYHke
         ECWMIYbebzRtzUQgM+ZHJf+f/Udshp8fLp9L9cqN8/sMQivOnJ+JzyNa+awvhAEt834U
         2Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KTX53QeVe+qn2iYkSMS0ikshGW629AcyossUuSgcsZ4=;
        b=lofI8ZbF58Bqf1oNy9iCEPYXdxrwkFIv/GR9EPXsx5tvLKxFbtp3i3pNwvT9fMN+NJ
         Gkp/kIcfyEDnu8OdkC8se9QGS/uVHQWiO1ZA+CY40NAi1J8N9A7a6qlp5XqIo7Fq2q0a
         2AsqtYzulz9ANSI3xnGYt8cznHbpAFuhMSEkNgzvSESONEe5kl7Xp65ZmO759aKtEaC+
         bIHdk8LE70kiUFeIppGPNrqxvgtfqyjXYyZBJT4qdZ73KsMruWHc+U3UbfqIzayU7HCK
         O0eRdlm2kUOiPgKClF/h9UuPfaWIiXfwcwJe5eWHO1iNWsuchf6dVLMum1LCs7g1l47V
         7Xsw==
X-Gm-Message-State: AOAM530mJyYwosfqERoPGC133yxabRAuQN6aAffjOPYwGszScDGMYSUw
        ImxEAl3DbunHIai8XxVVqxNRzUyaDntMJdNnZks=
X-Google-Smtp-Source: ABdhPJwaYLTjvnpTCV21OEUZzW8DVellheawnAYH8nNZkkhZMJzTxXNlZONPnqE5ae6P6j0rAQlbyw==
X-Received: by 2002:ac2:4e92:: with SMTP id o18mr24966864lfr.98.1643832965845;
        Wed, 02 Feb 2022 12:16:05 -0800 (PST)
Received: from ArchRescue.. ([81.198.232.185])
        by smtp.gmail.com with ESMTPSA id 8sm2957931lfr.178.2022.02.02.12.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:16:05 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] btrfs: send: in case of IO error log inode
Date:   Wed,  2 Feb 2022 22:14:37 +0200
Message-Id: <20220202201437.7718-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if we get IO error while doing send then we abort without
logging information about which file caused issue.
So log inode to help with debugging.
---
 fs/btrfs/send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d8ccb62aa7d2..945d9c01d902 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5000,6 +5000,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 			if (!PageUptodate(page)) {
 				unlock_page(page);
 				put_page(page);
+				btrfs_err(fs_info, "received IO error for inode=%llu", sctx->cur_ino);
 				ret = -EIO;
 				break;
 			}
-- 
2.35.1


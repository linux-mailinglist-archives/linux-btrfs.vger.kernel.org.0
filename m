Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C882322E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 18:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2QrA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2QrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 12:47:00 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C0C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 09:47:00 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s16so18118819qtn.7
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/zkKm0xYD8tNLPflotOAmmV9Tj7kNeE7o4QzlC8m03w=;
        b=CfsF9Qzh6vnv/EyjckH6siaSO6/IJdWbHNk+SuqBYxmKuT8SeAu2V4DzUrQisEPDYD
         co2cn2Sud67vhqDlHTtk5nYwgn+PMdzQt8U14s/h8Mih0loF+9CBFGvywi1mjbP4DTdj
         pBS21ZlER6nMrjRYKl9vBjqNbqLkR8nZLCliOw3fht4bV0abzQL/2E7pfHWBrTVwI8MQ
         3yoaPADjXUBBW8m5uA/iLMz75x81I178HO8weI/pRZqZpnIYuMCvg5+4/xtmDAgzb4V8
         8rb33cV2YwgjYtD0mx6Q0MgtViHyNT0V4p+Ty/HtGyqUP6+9jaLJml8E4gry7NEkd7Xm
         Hcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/zkKm0xYD8tNLPflotOAmmV9Tj7kNeE7o4QzlC8m03w=;
        b=JrV7Anb+lyWmc7a3JOenDQSOwPgpyaIegQVDpwgx/afAjwdA/GIf5Sm00aVVaT7kJ4
         UDnOXEgEu5LOWDcwR2fHNZs+vriT/7C7wqbUHc78DGdthsEx6eHzxln9ENSh6AVwThlP
         Iqswl7aLDmLftYxJmDEcrl72EtHgFDPvCrQEIM9bw8f11kMmBJJZj60nl+f8yyc2a0H3
         X/eO9O5AIbi/hmyJyz4adnhLmmqbyVDQudDSLRDiCBuMZihatGNAF9csMjaE464Qc8KD
         xCmHjw8c1ct7QnPOP+Tlmb06Khf2bc2HU9tD8nj+QU0322u37MFKVng/j4g3dq395ny1
         WEiQ==
X-Gm-Message-State: AOAM533+gNreMqSZn4KZVzSu9bn0OYWn1mxOp250pHAzuLArONtWyySD
        X9r+05rvzIJeV4G667wBy08M1QeJcWHLGA==
X-Google-Smtp-Source: ABdhPJyEtCiYtYkk1jH3ZYi4w2DuD6X9Z1ta3QZ6VSkgnVCFSZOOJoeDv5ZLK4rQyjymxawPhsLdVw==
X-Received: by 2002:aed:33e7:: with SMTP id v94mr30028020qtd.18.1596041218783;
        Wed, 29 Jul 2020 09:46:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m63sm2123559qte.32.2020.07.29.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 09:46:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] btrfs: indicate iversion option in show_options
Date:   Wed, 29 Jul 2020 12:46:56 -0400
Message-Id: <20200729164656.7153-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Eric reported a problem where if you did

mount -o remount /some/btrfs/fs

you would lose SB_I_VERSION on the mountpoint.  After a very convoluted
search I discovered this is because the remount infrastructure doesn't
just say "change these things specifically", but it actually depends on
userspace to tell it fucking everything that needs to be set on the
mountpoint.  This led to the fucking horrifying discovery that
util-linux actually has to parse /proc/mounts to figure out what the
fuck is set on the mount point in order to preserve any of the options
it's not actually fucking with, so in this case iversion.  If we don't
indicate iversion is set, then we get iversion cleared on the mount,
because util-linux doesn't pass in MS_I_VERSION as it's mount flags.

So work around this fucking insanity by spitting out iversion in
/proc/mounts so we get the correct flags passed to us in remount.

Reported-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index aa73422b0678..fe64aa2f5c7a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1427,6 +1427,10 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",discard=async");
 	if (!(info->sb->s_flags & SB_POSIXACL))
 		seq_puts(seq, ",noacl");
+	if (info->sb->s_flags & SB_I_VERSION)
+		seq_puts(seq, ",iversion");
+	else
+		seq_puts(seq, ",noiversion");
 	if (btrfs_test_opt(info, SPACE_CACHE))
 		seq_puts(seq, ",space_cache");
 	else if (btrfs_test_opt(info, FREE_SPACE_TREE))
-- 
2.24.1


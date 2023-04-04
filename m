Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2786D6658
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjDDO5F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjDDO4h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 10:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145224C00
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFUi+70wiITyeuozy7B4Yd/jMxRAxWPn5c55TeHG694=;
        b=RwOIctQSCaPzB1+f5us5d5L8ttDbAuhtgXdxree2G21bo286m2mpzij37jfihoJXMgCp7s
        a89ZkwytlyQiwkvbE7XZkypPtvcA4gArylj61MBAALkr6tV4WW7pMgQWc9Cqjkd7na8rUT
        Ddif/fLDj2r0c9Ig3QFGSyXBAB1rlNc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-gg8iaHoUMuuteba3tynbUQ-1; Tue, 04 Apr 2023 10:55:42 -0400
X-MC-Unique: gg8iaHoUMuuteba3tynbUQ-1
Received: by mail-qt1-f198.google.com with SMTP id f2-20020ac87f02000000b003e6372b917dso10374531qtk.3
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 07:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFUi+70wiITyeuozy7B4Yd/jMxRAxWPn5c55TeHG694=;
        b=02Z4rlh2FhV9k6Na1s0GAWGh/uEJuWUiBr/s+xIlkdvWD1DgthlxWmSKJC77xZhNRa
         4+7LbWEPxZqvZV3HZcsJjwcZdrsYKyWXp7URUzlTTd5ugk0hEMEz2AeTnKlMphgtrguA
         qfiX9nWW6OuyYb9hixWz0C6pLlX1MK5N3dp3mTmh/tlPQt4EtIeP6RNfFxTo+U6zu7CY
         s6K0v8llTfHJ2H1uVEj83UtgYyr9VoJtQyD1Ccci13jJjk22UPuTB/IINmzji5XTb0zn
         Ozl8FDc9LW2B6pSOUItpIXBVWcVzSLAZ3bU4q7UHXPDA/wdDhEakXx3FXMg0z5dX8dkH
         Qelw==
X-Gm-Message-State: AAQBX9dKpmh2nm1gFzL2LotvBQosLBsErbKVnlWJhVaSZ8C4325QJ9yf
        J5ya9xxoHZklEcDetBAyPCRy2ihg7lmlMn7frGtAjNPHYGHMs7hh2r6P69sIcbhskPHpwkogWAv
        mAM+722Ux75zNWTs0CZbHQg==
X-Received: by 2002:a05:622a:199f:b0:3e3:913c:1ca8 with SMTP id u31-20020a05622a199f00b003e3913c1ca8mr4130752qtc.22.1680620140355;
        Tue, 04 Apr 2023 07:55:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zzc10/1v2LcCE0zfPnbg3x+8dh54gKx1zJb5SpW17zpBOCvtCa2VKQbBuo0E40V5nvMeZ6aQ==
X-Received: by 2002:a05:622a:199f:b0:3e3:913c:1ca8 with SMTP id u31-20020a05622a199f00b003e3913c1ca8mr4130703qtc.22.1680620139945;
        Tue, 04 Apr 2023 07:55:39 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:39 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 18/23] xfs: don't allow to enable DAX on fs-verity sealsed inode
Date:   Tue,  4 Apr 2023 16:53:14 +0200
Message-Id: <20230404145319.2057051-19-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
inodes which already have fs-verity enabled. The opposite is checked
when fs-verity is enabled, it won't be enabled if DAX is.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_iops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 5398be75a76a..e0d7107a9ba1 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1204,6 +1204,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)
-- 
2.38.4


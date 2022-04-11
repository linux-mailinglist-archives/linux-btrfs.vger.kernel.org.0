Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8374FBA7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 13:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbiDKLIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 07:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbiDKLGu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 07:06:50 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EAC13D18;
        Mon, 11 Apr 2022 04:04:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j21so16027900qta.0;
        Mon, 11 Apr 2022 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vB5rzbkUXQOgEVOAQ+oj0ZM8y30roPESpDd5/oevwT4=;
        b=dq2RZU8F9nASFtU6zsvVxtuqChAwSl9U0XGqSO2w8YLwBgwFnR718DdsGFlqRdjIx5
         OdMVR4X+mOHY4U9b+QsCuXBNrqRPvmJqYB1knORI/H6LCrGFKkFZ/LV+r110UEansjxA
         ayEN2BgYZRYo8ife16WPQNYnMvYEEM69DJqdHeXXM9CyUSi3o1TZ0Ks73XQmunaqJkrs
         eXXTcy7p4fUyRdScmlt8tXAnfTHIHUjf3sS+Yvwj2XfWLtGB1XAYzGRUSkH5hAk8tMRF
         2WSf+p7CHJkEwTroLFa4cRhbHfhXpRWjlGpgsQjmfd1KetWMVyyRi+awE7pHIA0CpyyV
         TaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vB5rzbkUXQOgEVOAQ+oj0ZM8y30roPESpDd5/oevwT4=;
        b=T7ZhoSMus8o3g0+IT3iEzKzHQAqelCcSsDh6ud2hP/z38WnUNI+torvIpLNSB1LJTo
         qtmtd/fbK7WoC//iTpXkhOJl7sjTe3BcqS7PtN9kN9Nr/Hhc+mHWw7tBM4fBdh34MUgz
         L57PZn1Ryeq7OcYFS3vkIzetwyq5VwU2MshvZDTSZ7wlIuDzWAhKpRxqJvmWqCLAmOHE
         MHC5WAe4+TIMZks9ntu4pHM1RSLMG072kqrj0RzpAu+WeOJ0zbcnN8Y6djbDvOJF2sSs
         4d7oUAnM1A27pgKKhfTnZXzixcRrtNA7Oc2jJtKkgqCrhfsh3OCiw/lNnrKjcnfYP+xP
         gqCQ==
X-Gm-Message-State: AOAM532Dnt6T5JB3p26Tm/Xs0KYpiFOlz14YlY/LZI6tUipfJnexQ9nO
        Gfz7hoMyFJS3AGIe1PzfBK8=
X-Google-Smtp-Source: ABdhPJxJP+E6DLnG6gqXLhNmiNDBEfJrnnebGQIoZFEahUYEkQ3U3LsvhFfvRMQP4/HrYf5MIBv35A==
X-Received: by 2002:ac8:5442:0:b0:2ed:7e3a:17f7 with SMTP id d2-20020ac85442000000b002ed7e3a17f7mr4573276qtq.48.1649675072970;
        Mon, 11 Apr 2022 04:04:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l18-20020a05622a051200b002e1e5e57e0csm25140194qtx.11.2022.04.11.04.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:04:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     joe@perches.com
Cc:     cgel.zte@gmail.com, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, lv.ruyi@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] btrfs: remove unnecessary conditional
Date:   Mon, 11 Apr 2022 11:04:26 +0000
Message-Id: <20220411110426.2521783-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c855ba7ca204b948c59c9fd966c154e5505b3d77.camel@perches.com>
References: <c855ba7ca204b948c59c9fd966c154e5505b3d77.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

iput() has already handled null and non-null parameter, so it is no
need to use if().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
v2: return error value directly 
---
 fs/btrfs/relocation.c | 5 ++---
 fs/btrfs/tree-log.c   | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 50bdd82682fa..75051963ffc7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3846,9 +3846,8 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 	if (err) {
-		if (inode)
-			iput(inode);
-		inode = ERR_PTR(err);
+		iput(inode);
+		return ERR_PTR(err);
 	}
 	return inode;
 }
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 273998153fcc..c46696896f03 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -894,8 +894,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_update_inode_bytes(BTRFS_I(inode), nbytes, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 out:
-	if (inode)
-		iput(inode);
+	iput(inode);
 	return ret;
 }
 
-- 
2.25.1


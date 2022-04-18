Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C750570F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiDRNtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 09:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243542AbiDRNqq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 09:46:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3860C27146;
        Mon, 18 Apr 2022 06:00:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so483842pjf.0;
        Mon, 18 Apr 2022 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7uOPH5NWelWL8HivChTPlWB5fjkQJwWePsqDxPJujA=;
        b=iYNt+RhJf64VlmKk1kS1E3FQhju8m4EfHObEyFN10k8hwHKjsVoL8UPtGAiLQk6TIi
         3+YEchqNyHKjxdLZInL7E1yu12/LfeiBqHeBlZ95IQUxAxbSkOenNQ5YTUcbdV4hD+eE
         K4ZF+ySut4N4X2gEsLss1Z9nRTmMC7UHLMV+vr/LC5OsFRvm68qYkly+NSIREc7Z6HLi
         g5KJIjTn3bNX8xV5A+q6zf2daHWg8pqlrACWqXhsZQW/PfIXXG+lSRgQ2oxat7KIYEjX
         HhKXumqZ4hajGugdY0ES4MTXV8zVQho9Nmttj9fjm3RQZfH/RChkrGEWMgQAelqkYW14
         vQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7uOPH5NWelWL8HivChTPlWB5fjkQJwWePsqDxPJujA=;
        b=4pQiVbFNF505mzzFrf6keaLIvp45wjhREGMRyQM8LkllOfG9IGKZddVnuZD1NuBMuq
         IlN6GnZZtBkEK0EAtDAFt/ry3v+Ughp+/t36MXLGl3qWvJ6dZ9Tu8/mmmP7qUZHQqD4C
         WkWSUefHdweBQjc7vJv69ToA4kgX0cW0/5SQMgo6iDxyw8DKRSabQ6Ok2tNuJ0cgkcS+
         23mFwUpYhPgUoQrA+shKZVgSdGGXLbzsWQM7860BhBs//ijMOqbMdrSkOI8u7EYmpMre
         96y+KZlEyzrRimBl06bSzPaGnYa69mnIT/fucu4o7rVuiDkGiTo/s1k+EwtJ+4HMU5hP
         p4LA==
X-Gm-Message-State: AOAM532oKeHp3X0GAGz6FUVFx/UXalbMJmGgwpPfWejQoooYUTAfM3Mf
        o1fwY43ZzwwIOytzPCVhJCs1H4D5lE5Sqg==
X-Google-Smtp-Source: ABdhPJzkCrOsulp3VGPnBk7XuVigmMGyHzgaOKGrMRh4qwUugY8V5t4/UxxTAbFzcFljiWRZ8pbpeA==
X-Received: by 2002:a17:902:c613:b0:159:9f9:85ec with SMTP id r19-20020a170902c61300b0015909f985ecmr1613966plr.67.1650286846979;
        Mon, 18 Apr 2022 06:00:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-27.three.co.id. [180.214.232.27])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a00198900b00508379f2121sm12820853pfl.52.2022.04.18.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 06:00:46 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, Schspa Shi <schspa@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: zstd: remove extraneous asterix at the head of zstd_reclaim_timer_fn() comment
Date:   Mon, 18 Apr 2022 19:59:35 +0700
Message-Id: <20220418125934.566647-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel test robot reports kernel-doc warning:

>> fs/btrfs/zstd.c:98: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

The comment is for zstd_reclaim_timer_fn(). Since the function is
static, the comment isn't meant for kernel-doc consumption.

Remove the extraneous (second) asterix at the head of function comment.

Link: https://lore.kernel.org/linux-doc/202204151934.CkKcnvuJ-lkp@intel.com/
Fixes: b672526e2ee935 ("btrfs: use non-bh spin_lock in zstd timer callback")
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Schspa Shi <schspa@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 In the previous fix attempt [1], Matthew Wilcox suggested to remove the
 second asterix instead since the function is static and it shouldn't
 have kernel-doc comments.

 [1]: https://lore.kernel.org/linux-doc/YluGmERvtQY9ju7Y@casper.infradead.org/

 This patch is based on btrfs-devel/misc-next tree [2].

 [2]: https://github.com/kdave/btrfs-devel.git

 fs/btrfs/zstd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0fe31a6f6e68f0..ca2102a46faefd 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -94,7 +94,7 @@ static inline struct workspace *list_to_workspace(struct list_head *list)
 void zstd_free_workspace(struct list_head *ws);
 struct list_head *zstd_alloc_workspace(unsigned int level);
 
-/**
+/*
  * Timer callback to free unused workspaces.
  *
  * @t: timer

base-commit: 550a34e972578538fd0826916ae4fc407b62bb68
-- 
An old man doll... just what I always wanted! - Clara


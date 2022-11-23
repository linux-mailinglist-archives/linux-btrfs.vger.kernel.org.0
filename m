Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AFC636D58
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiKWWiZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKWWh7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:59 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A31EFCFD
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:57 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id k2so13471779qkk.7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGTLGPNKt9rHwMmVBTUJWDbcQrsnFY5gBQrILtbVypo=;
        b=Y/6V3zB/iBve35MCQo0YbbSAlW0xn3JNqlAjqyjzxF7iYTFI9UhRsWwpcKABBWRQDY
         iuJ+vQyT5TWDkkF0dZcTSwvQQAhIWkgWZhNBPEfnu5bI6PIZ8XBs4/EmrkmYsvdUpJNK
         KIV9wLjTff1mpDWHkeZIMNYoSOy252P7zKeF5F74jrek7jqdLefiflh3OESLBfMw6GoS
         uF69KgDRbhYVtGDx4daAckQUNTNcynXLgRJFzYbT2Ygt38cwrt74gWjp/nBX4qo8abf+
         PsfpHE2GaSC/8urVWdZYB3C2NYkXcjVGO1MvtUw6bNwD+dtQo0wHOBYmHOMMrh5hPlN/
         0lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGTLGPNKt9rHwMmVBTUJWDbcQrsnFY5gBQrILtbVypo=;
        b=QGzuA66jC09vMPod1l+vOYZS6DrfIq8qhgSk8OJuEiTMV1+kkTzcoH57acsXNLbfrM
         wAnKdPuwSPEWsdokI8KtjYCaXRs4HRtlNxqHYnX2V+8V53YCU1NOYwm9YYnpR0L1R6kF
         d+T5MfufFBlASqMRN+0Y0xaUxx3GwLFWCDekefrBLD79mJlj7Z+uRpm2N/EUuNIV6+tq
         9e6DjEiM0Ev9TaB2izK89JyD5HMtwvE4FRHhWtU7lQGiJvKlfYcuJ4lznPT6B1/SNRuM
         hlPLiEZ6tIq6UW+CWtPrQgukcvqf7jegT7jSNhsVy6JqR5DwIouSB/xMOro+IFsIgf9v
         X9Ng==
X-Gm-Message-State: ANoB5pkT+rhP4ZliWM3vS613Lbg+7ErFnkCnCi//IkdQ1sN+Vc8nZrNL
        G9vXX3NruSmwO25+cyLgdlX1GL4GGMAGKQ==
X-Google-Smtp-Source: AA0mqf6TInCOPG7xHxUv3izbMMjXCBpxJo1vLt8u+DtqwUP30ZTL2yzMoz6vpRfQ+HaUQRAn+ymH1Q==
X-Received: by 2002:a37:af05:0:b0:6fa:da64:4879 with SMTP id y5-20020a37af05000000b006fada644879mr14119882qke.312.1669243076432;
        Wed, 23 Nov 2022 14:37:56 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a084c00b006ee949b8051sm12390637qku.51.2022.11.23.14.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 13/29] btrfs-progs: stop using btrfs_root_item_v0
Date:   Wed, 23 Nov 2022 17:37:21 -0500
Message-Id: <9c33821261448abb06676c0cca57ebab56498807.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This isn't defined in the kernel, we simply check if the root item size
is less than btrfs_root_item, so adjust the user of btrfs_root_item_v0
to make a similar check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/subvolume-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 6997d877..1c734f50 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -870,8 +870,8 @@ static int list_subvol_search(int fd, struct rb_root *root_lookup)
 				ri = (struct btrfs_root_item *)(args.buf + off);
 				gen = btrfs_root_generation(ri);
 				flags = btrfs_root_flags(ri);
-				if(sh.len >
-				   sizeof(struct btrfs_root_item_v0)) {
+				if(sh.len <
+				   sizeof(struct btrfs_root_item)) {
 					otime = btrfs_stack_timespec_sec(&ri->otime);
 					ogen = btrfs_root_otransid(ri);
 					memcpy(uuid, ri->uuid, BTRFS_UUID_SIZE);
-- 
2.26.3


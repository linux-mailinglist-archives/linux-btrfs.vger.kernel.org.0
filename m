Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D7F6F4660
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjEBOwg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 10:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjEBOwe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 10:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02469211B
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683039094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rlI4i5NkJUU4v3/TaCr79bgC9FfiCXPR9/G1iFN8MDM=;
        b=hB+shG8BrxkDzC/AbSekjd1FkOpJk4t2uK0fpKGtawVX9NDRTDSriAiJSZRcHX9AKb9oGk
        3MfvYGR2F/iiLKefQrwQX8I4TtiVpI+iASRueb8giksPFjat2wq9Cyazu2DR/ZT4qgQOjl
        8cfHq5apCumrqr4ccpLcOBVtPhLnP80=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-ybC3aLHXNXOYjlXh05vkLA-1; Tue, 02 May 2023 10:51:32 -0400
X-MC-Unique: ybC3aLHXNXOYjlXh05vkLA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-61b591eb0cfso11714356d6.2
        for <linux-btrfs@vger.kernel.org>; Tue, 02 May 2023 07:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683039092; x=1685631092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlI4i5NkJUU4v3/TaCr79bgC9FfiCXPR9/G1iFN8MDM=;
        b=FZPrHE61pHr/XX/cti5YIy5gbQ2nPndpLj1r3isntHeYbjSKps4V8eMoUDNXuCu9ib
         DU+JQAj7X9hIH3twdUK+FUvFq/owuNa+T+sVxuCwmeU6q01xEW6qGCT9BMUR485dIOtr
         A7xBHGo9L1aw7OFVmRjVpj6pp+ONZZdcDEv8xiWWXuDMreIkOpLBiswRUFazZFuUrzUM
         N27Z38P1PYXaNBLCryViaU4ri3ASYcjitSp5hM0CKsVYgFaG7wX2V0FR1EdRvZMITO+o
         aOTx4Gq4r8zSe9PLOvQJMlHsbhlWx2CbYfwYXfKBIiRRhvH97uZsanqlJxtyTXOtRnv1
         021Q==
X-Gm-Message-State: AC+VfDzENc/zX/FnEE9t3OVxyo8S5OWgNbZ03eQ6H0CDVKiiHUvwcOII
        OpByjf6YJFv/bcg1m8Q5EXVez3Wc4FWedMcpaYNEM/oIbPxC+GWG6XbXdMnLbM1izPaTeHgXdEn
        qdfekqzJIdK0tmGnB9x7FO8o=
X-Received: by 2002:a05:6214:1305:b0:5ab:28aa:2429 with SMTP id pn5-20020a056214130500b005ab28aa2429mr6745867qvb.30.1683039092281;
        Tue, 02 May 2023 07:51:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dDegzBLcQBdCcxYpqd+dYi2UlOninPF6u15FNk6D4g/uiioJP24FRBYakE8yyzmhtVJMY5w==
X-Received: by 2002:a05:6214:1305:b0:5ab:28aa:2429 with SMTP id pn5-20020a056214130500b005ab28aa2429mr6745835qvb.30.1683039092025;
        Tue, 02 May 2023 07:51:32 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j13-20020a0cf50d000000b005dd8b9345besm9613655qvm.86.2023.05.02.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 07:51:31 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs: replace else-statement with initialization
Date:   Tue,  2 May 2023 10:51:29 -0400
Message-Id: <20230502145129.2927253-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A small optimization
Move the default value of transid to its initialization
and remove the else-statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 25833b4eeaf5..4694301aa91e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3132,14 +3132,13 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 static noinline long btrfs_ioctl_wait_sync(struct btrfs_fs_info *fs_info,
 					   void __user *argp)
 {
-	u64 transid;
+	u64 transid = 0;  /* current trans */
 
 	if (argp) {
 		if (copy_from_user(&transid, argp, sizeof(transid)))
 			return -EFAULT;
-	} else {
-		transid = 0;  /* current trans */
 	}
+
 	return btrfs_wait_for_commit(fs_info, transid);
 }
 
-- 
2.27.0


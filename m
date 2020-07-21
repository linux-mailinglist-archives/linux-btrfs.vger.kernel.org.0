Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBA12283AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgGUPYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGUPYd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 11:24:33 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAC8C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 08:24:33 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z15so12911251qki.10
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZTm8Mzss8ow3QPIAmd46nneSN+UHFHRrFFkZStM3pQs=;
        b=Rm4K9LbPM6aTjDQ8qLXmc1E39qrfxAuZRIIyKNr3YgC6ndZFPyccfhBL+FnFO2WdW4
         65/eNp7T4i3Y9pl59PJsoEgZLPDN9QYVSSTHJyiQdtZlCDP+yTJOWPGUhNqX84YuITG3
         MhXQO5lkl3p8/MbYigGQeqakBMbofhS0eWjgccgi1yTa6+esFF2CoO1cXmxq/gskfYfW
         pvnXcJ7aKlcuonPVbfwn+2S4nN0VxP373riGG5PoFkZ7DMuZi8aNr2VX/1FD7sQM+30l
         IY78FTBc1jwahg1kwF5R3g+CaUJhWvSaddJq/i8J7nasONJWeor1SpTi8sF3UFheUss4
         zt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTm8Mzss8ow3QPIAmd46nneSN+UHFHRrFFkZStM3pQs=;
        b=TCml322y8z7jRQfU0aFS/1ENwZWZeDe5kYqAskHLTLM9TbFQd8qzUZxmsDPbnZCS4f
         hNIIzFnvp/KOJDRA1Dm5eb4rJDCFF+Ros35/AxvGKWvynkYKjlDCb0VPkUTRAXWZ4Di7
         pgN3C0+zJgdqihuNZ3LrYnsArVXtPTvdbPS/Tbrl2rGboq841Qkiop565twpOoKpQ/Hy
         J0gkbxhu4DY5N8sSn+5q+KHoqqYDKIzWDPu1N+NHDgdx8i/h6MmAh34xRzvjV1P0y8Xa
         AeQ0w//E6ihTsh9ZAz9oQVIrKlmSrCCeVlKYHy6yU1ZKXRL+IDmOzqdYBnVAv9vu7aZr
         tFgw==
X-Gm-Message-State: AOAM533aBzCknDLaSMxLAeCGUTv2BoHRuFdNEosBsWaPmSZz3+DhjzSU
        T/JzyyPIqDCz0G8Z6X1Zpwv+DzG00rrxGQ==
X-Google-Smtp-Source: ABdhPJx40/cq43xs9JiyFjaJQdpGnmG2wC2EsCSe5L7fSn6TGCX8OBeaSKXIA8CtXVEVzx+yjlVIRw==
X-Received: by 2002:a37:b342:: with SMTP id c63mr28083801qkf.436.1595345072641;
        Tue, 21 Jul 2020 08:24:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y143sm2657587qka.22.2020.07.21.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:24:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: document special case error codes for fs errors
Date:   Tue, 21 Jul 2020 11:24:28 -0400
Message-Id: <20200721152428.9934-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721152428.9934-1-josef@toxicpanda.com>
References: <20200721152428.9934-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We've had some discussions about what to do in certain scenarios for
error codes, specifically -EUCLEAN and -EROFS.  Document these near the
error handling code so its clear what their intentions are.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 58f890f73650..688d1ab95b2b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -67,6 +67,21 @@ static struct file_system_type btrfs_root_fs_type;
 
 static int btrfs_remount(struct super_block *sb, int *flags, char *data);
 
+/*
+ * Generally the error codes correspond to their respective errors, but there's
+ * a few special cases.
+ *
+ * -EUCLEAN: Any sort of corruption that we encounter.  The tree-checker for
+ *  instance will return -EUCLEAN if any of the blocks are corrupted in a way
+ *  that is problematic.  We want to reserve -EUCLEAN for these sort of
+ *  corruptions.
+ *
+ * -EROFS: If we check BTRFS_FS_STATE_ERROR and fail out with a return error, we
+ *  need to use -EROFS for this case.  We will have no idea of the original
+ *  failure, that will have been reported at the time we tripped over the error.
+ *  Each subsequent error that doesn't have any context of the original error
+ *  should use -EROFS when handling BTRFS_FS_STATE_ERROR.
+ */
 const char * __attribute_const__ btrfs_decode_error(int errno)
 {
 	char *errstr = "unknown";
-- 
2.24.1


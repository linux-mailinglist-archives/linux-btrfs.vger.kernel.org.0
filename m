Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4823E28F87A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 20:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbgJOS0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 14:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733118AbgJOS0P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 14:26:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DA1C061755
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:14 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q63so3126957qkf.3
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4RuWmofsqeSBJPxj7bx7NCcuXz6DYtU4jjBZKHHcZ74=;
        b=GcTuedtnz1RRZfpN0lee8RDt5d6yUvilMERreIJdMV2/r3zH2XITLSvTPMtEa+wucu
         YRoaVcCrFwCDXUms71dZt9gKTtsUazb80xa5PkTvdE2sXDvsz/V9V8aab1HRm4BI5mTX
         EnUXMFS0YUjUGr6aLBbi8TUh21t3ca6Qjh9fXeQXwAD/9RAbN/n2cmuc6o7h8RoyUAPa
         vwaKjlNoTC2kkTZ5ICh3sbNrmHTum19S+l3+Dy6p1masbs1pJ5LOcqPWSDQ9DX+xExF5
         OrjikD86o9dKMlKL1VTeq6MF0QssrXIw/UanwYiBH+kVNlSjo7GbVji5fPT/dgA7gywc
         iBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RuWmofsqeSBJPxj7bx7NCcuXz6DYtU4jjBZKHHcZ74=;
        b=ahVWFSnutWz/iPeRd4x4x5R/jwe4dOfOqGG7tP/lX9cglMD5a01uoT8Q89+ayNKMA/
         vzAB5Jv0FKmOMhLSjSIzGE2vIq055u+2oIP0sZN+bo8dJukjYDCnppm8KxV92tOSshVb
         LShcPR6pk4kIpqiG330RBSF+woq0pwCLPEuJTJfGdLm3QdxP3oU42hnf2IiA5SPYwiQM
         QNmdx5R8xbVbdVXozUBPaNXKLM9gtfTBLDvUQmmXig0hMcA0jYTbwzbeTqiAO4StOaTs
         7lWrPhnwjMDTZ3Hitukhl3jMNGLAb8+0PFYiu8KbXHbMeEsPkp9EZIDzZHEL/Vml3kSr
         9afA==
X-Gm-Message-State: AOAM533XAr4uHZOrLf2jU/s0ikCKEFC3pl+9098ZpLG3tetTnpdjPvYP
        ukoeej7S2uaX7LUJEUcvoFp4HkjT+k+cYT2U
X-Google-Smtp-Source: ABdhPJwG+FQ1qGeCCXDNdrxvt584MV4iZPS6YtUQyC4z09L6NkBKKPwEotaOX1LO0G4j8kB3jttlwQ==
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr102306qkg.326.1602786373451;
        Thu, 15 Oct 2020 11:26:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h8sm36164qto.46.2020.10.15.11.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:26:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/6] btrfs: run delayed refs less often in commit_cowonly_roots
Date:   Thu, 15 Oct 2020 14:26:01 -0400
Message-Id: <5acecc97a54db388043887540238c87101b03885.1602786206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602786206.git.josef@toxicpanda.com>
References: <cover.1602786206.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We love running delayed refs in commit_cowonly_roots, but it is a bit
excessive.  I was seeing cases of running 3 or 4 refs a few times in a
row during this time.  Instead simply update all of the roots first,
then run delayed refs, then handle the empty block groups case, and then
if we have any more dirty roots do the whole thing again.  This allows
us to be much more efficient with our delayed ref running, as we can
batch a few more operations at once.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e4c7fa5076a7..f4d55ac7f8f2 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1651,12 +1651,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
 	/*
 	 * Do special qgroup accounting for snapshot, as we do some qgroup
 	 * snapshot hack to do fast snapshot.
@@ -1704,12 +1698,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
 fail:
 	pending->error = ret;
 dir_item_existed:
-- 
2.24.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64253FBE90
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 23:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbhH3VxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 17:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhH3VxB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 17:53:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB6FC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 14:52:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s10so9340469lfr.11
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwyRJVaL8nJlmwf/1hHAs4/TikRunQFuPDh10MZISEo=;
        b=HDzWxSseqcRCNXbT2vI+Qik+MCyVadS0qJnk71JhP6MnqTFt935qGZmiNPINtxSKTP
         Mw0Fb04FxjNY+GsbRc4O1ZboDWI3b8cD18BhRuv08cibRmrQsw48IE0E3NFq/UIShcr/
         h6ImTSRGmS8KvCAfGvYc/nG3QAiTZw8giXi1q7bl9VjiZ4XUyeQJRNXXh7+GT8XR6n3z
         9OM+/ODGIIC/bfCyUrHpB6jlZGtMTaB0Co6aDf+is/SUa8qMpKi2lOptSYwrtOE+RKXB
         ASThGT2RozZVbRAzkP7nrvl8fIAg1gzznOD6dPNI5WlcRt4Msifu6CRpqws4NHHLvZfq
         utXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwyRJVaL8nJlmwf/1hHAs4/TikRunQFuPDh10MZISEo=;
        b=X3MPisMvwhcejdIa8wFKnEi6r14XXgMRwM2ocwYn62Vf8rjFpNx+fS3gZJZNRDD7nz
         rWXn02tK53OqlTZw9XAN0ULq9QnBzYAitUp0n2HBTf+o0Zu4uV5MfY4aPw0Fl0yRtPZT
         zBhRrWmZhoEbqzO043lzmvCd50pRyHIILmyAW37ihVCPKG0r2eyRY9w47O5XCWvYjNUq
         ao6XSIUIO18bIi0SiLSAXWqdAqVdrZ2Bpk/d7FefRqD43IA3J0u7d7wvOuYYK/GC4IHF
         vzK57FKwBOFw3ej/UFp+aeqRGjLLafLl7C7IZ3ceXPYLWqeMDE8FWHupVouQ/P/Gb2m6
         botg==
X-Gm-Message-State: AOAM5303LAi4G20lqMCM6PWqnDRPt07cmoZhNDxP/iUjVpozY1YUd03O
        i5J1Uq1Cn1fYBgFbN/KDj8JlAa7oaj74Ug==
X-Google-Smtp-Source: ABdhPJzP7iYb/Y3h8rYRo0s//d14VTV2lDNGwsZz88lm2nswat9beGifxX108wfuhdYGvaCTXjjDWQ==
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr6627430lfr.88.1630360323707;
        Mon, 30 Aug 2021 14:52:03 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id w3sm1981481ljm.13.2021.08.30.14.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:52:03 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Kari Argillander <kari.argillander@gmail.com>
Subject: [PATCH] btrfs: change wrong header in misc.h
Date:   Tue, 31 Aug 2021 00:51:52 +0300
Message-Id: <20210830215152.269516-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

asm/do_div.h is probably for div_u64, but it is found in math64.h. This
change will make compiler job easier and prevent compiler errors in
situation where compiler will not find math64.h from another paths.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/btrfs/misc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 6461ebc3a1c1..340f995652f2 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -5,7 +5,7 @@
 
 #include <linux/sched.h>
 #include <linux/wait.h>
-#include <asm/div64.h>
+#include <linux/math64.h>
 #include <linux/rbtree.h>
 
 #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
-- 
2.30.2


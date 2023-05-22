Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1470BDF1
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjEVM0B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjEVMZj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:25:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ABC171D
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4b256a0c9so883911e87.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684758187; x=1687350187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5kWyxReGc6+NbR/divUaYbGoYpsEUJapS8Ahu/mXns=;
        b=eDgGrNvX7xOGsi5V8joS0Ax4Tu8K6WkqrHWKIHxlYSGufqnGTRR1mp3qEqS8UZ10+Y
         criMHN1Kp+8D7G/EWKfIi3mpVr/HRZykPSmxLawPWBSat0P+VxCKzl50nsQI8gaSJj++
         FklfaiuXTgTxEb2ol3xeJcfjriptj5u9jZNTTUxFmAhTTuPAVyg/VPqz4Ob243BKynAG
         GS/UXYSefSbzLT0S1lFd5eZ0U0w84chyC08H8R9s9RakjPCf6ckeWYJclvyUH/OgcV4y
         eUE3hI66fzOcq2eeEjqA1uMJo58WGo0umXLCYrg5MnNQWH1YAHI5ioEiuC3F3ygeKtYr
         gJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758187; x=1687350187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5kWyxReGc6+NbR/divUaYbGoYpsEUJapS8Ahu/mXns=;
        b=Eh/DSN0N12OcH1D+o3iy93h4VNzgCJK5yYSpyJmnrx1VRPsp/L8cKYhWCVserrzq17
         AJOqtKXJ/ctK9CAALm4slupxitubLYfoYrn+H/DWxSIZcaNGOMphcLJ7jurCn9S9ab/G
         7XGamfiIPM5VqE57+QIkQWA6wEBQSEqfl9JWTKJBFBmDI7Za4Xdx0zgavmt8r4ipt8W7
         881ckbj2dqGDqpFWGi2t68Xh+4dXvI6lQiZVwCAqvwS68tLqKrx3p9VvjzH7T61a3ZtW
         cie7r/SBhhbEOyz9T3MGmNjbL22SAkC4KMFBugpmNw/XBgPBVApJwosbOqZqpmOgA4hJ
         79Pg==
X-Gm-Message-State: AC+VfDywQTMaeffJAtxTHJgvIjDWsEagjO+HBeJlmRAlBQHhwqb3Q0HT
        YdAWFnQB4lpXAyWRXHpsrx3Gag==
X-Google-Smtp-Source: ACHHUZ6U8fx1A1LU2xz/aiiAniQ6LFqBJfwqQyMXfEOLYWNp+S2ZJjRRQdIl0Zwl1rOCy4TGkTLVBA==
X-Received: by 2002:ac2:5991:0:b0:4f3:aa1e:8fd with SMTP id w17-20020ac25991000000b004f3aa1e08fdmr3342132lfn.68.1684758187582;
        Mon, 22 May 2023 05:23:07 -0700 (PDT)
Received: from rayden.urgonet (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24469000000b004efe8174586sm974633lfl.126.2023.05.22.05.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:23:07 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Huan Wang <alison.wang@nxp.com>,
        Angelo Dureghello <angelo@kernel-space.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Wolfgang Denk <wd@denx.de>, Marek Vasut <marex@denx.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Marek Behun <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
        Tom Rini <trini@konsulko.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 7/8] linux/unaligned: remove unused access_ok.h
Date:   Mon, 22 May 2023 14:22:37 +0200
Message-Id: <20230522122238.4191762-8-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522122238.4191762-1-jens.wiklander@linaro.org>
References: <20230522122238.4191762-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

linux/unaligned/access_ok.h is unused, so remove it.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 include/linux/unaligned/access_ok.h | 66 -----------------------------
 1 file changed, 66 deletions(-)
 delete mode 100644 include/linux/unaligned/access_ok.h

diff --git a/include/linux/unaligned/access_ok.h b/include/linux/unaligned/access_ok.h
deleted file mode 100644
index 5f46eee23c38..000000000000
--- a/include/linux/unaligned/access_ok.h
+++ /dev/null
@@ -1,66 +0,0 @@
-#ifndef _LINUX_UNALIGNED_ACCESS_OK_H
-#define _LINUX_UNALIGNED_ACCESS_OK_H
-
-#include <asm/byteorder.h>
-
-static inline u16 get_unaligned_le16(const void *p)
-{
-	return le16_to_cpup((__le16 *)p);
-}
-
-static inline u32 get_unaligned_le32(const void *p)
-{
-	return le32_to_cpup((__le32 *)p);
-}
-
-static inline u64 get_unaligned_le64(const void *p)
-{
-	return le64_to_cpup((__le64 *)p);
-}
-
-static inline u16 get_unaligned_be16(const void *p)
-{
-	return be16_to_cpup((__be16 *)p);
-}
-
-static inline u32 get_unaligned_be32(const void *p)
-{
-	return be32_to_cpup((__be32 *)p);
-}
-
-static inline u64 get_unaligned_be64(const void *p)
-{
-	return be64_to_cpup((__be64 *)p);
-}
-
-static inline void put_unaligned_le16(u16 val, void *p)
-{
-	*((__le16 *)p) = cpu_to_le16(val);
-}
-
-static inline void put_unaligned_le32(u32 val, void *p)
-{
-	*((__le32 *)p) = cpu_to_le32(val);
-}
-
-static inline void put_unaligned_le64(u64 val, void *p)
-{
-	*((__le64 *)p) = cpu_to_le64(val);
-}
-
-static inline void put_unaligned_be16(u16 val, void *p)
-{
-	*((__be16 *)p) = cpu_to_be16(val);
-}
-
-static inline void put_unaligned_be32(u32 val, void *p)
-{
-	*((__be32 *)p) = cpu_to_be32(val);
-}
-
-static inline void put_unaligned_be64(u64 val, void *p)
-{
-	*((__be64 *)p) = cpu_to_be64(val);
-}
-
-#endif /* _LINUX_UNALIGNED_ACCESS_OK_H */
-- 
2.34.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86D3DADB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 22:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhG2UgA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 16:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhG2Uf7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 16:35:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ECDC061765
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 13:35:55 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id m11so4875525qtx.7
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oob2WOCi4H1WuxZs/osv6sou92YJN1qr7ACpeG7n1uY=;
        b=YxmheqJK75c/ngXFeVzFVQARtpUvP/VezLAKuees2RiBRxR1N5lcrDW7zFDvwBXIUz
         Oj86HtR5KaJ7x5QhC2RnczzJFsUorQeHqg1ALYF7+L3dVVihTjVinbLrBMcYtIjBJKoJ
         RhziwUisIO/yuLX0rUdUhXBnHGMkY784b1Y4b9urD7p0cPz9B4euUM8c6pfIvAR6PkqT
         +0haSoQT2Wiubsl2G/jGOPeAG2GpI6YnVInuhKxLmz3AqvrHEgmVwCjCzGsDyfAHxNsm
         cNq2bbwKy1eOAGppNpgayiTd8t3DT6Fbh50ZCK9TPfJAziU42EmpO2CvhQFd3/SDJ+d1
         XZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oob2WOCi4H1WuxZs/osv6sou92YJN1qr7ACpeG7n1uY=;
        b=X+gIOl/7FvA5p+bFAf5iu85qpjgeXrvdWXkqKJFpkBZrcqHrp/s7pQYr08c3zjxf1L
         XLOA9KPPk7PgKHTaUCESxx2Am1qsTV/b/FqiPymCcVRty2pTFhz1TylUNP8448z0CsVe
         fnyAjW0X8bEHlzhNFvb5y+Ci9CR1lYTzph9f5lnkPXb4Qw4cofAvxqBmBfadId4PCgki
         jW2tG8WQugg33TcicNMycSVCGW0XWrx8I3QolN+yJXJEk2vjXWV/WMyT9MvoYCTn2UHo
         Z85rvjCDgJ20P+/3l1QPxLO9+459XHMXM3MpQ0SvZXgl+SADVE2JlD7m2bX5l8X1E4Cu
         Sjlg==
X-Gm-Message-State: AOAM533y++l95mmiJTGgmgaU7Vta+Ry4xonD9ZXsDDyHPtQw+u913Gk1
        2etnNE/nfjx+C08pWfkV6Py6mw==
X-Google-Smtp-Source: ABdhPJz0cl3S9KQ0ZxUxDHATFJxWAnmptvw9mG/nUHCYaWUMR2QnCpFB88CGuOOAMNK7X4832TL5bA==
X-Received: by 2002:a05:622a:134f:: with SMTP id w15mr5932476qtk.24.1627590954856;
        Thu, 29 Jul 2021 13:35:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f24sm1666817qtq.82.2021.07.29.13.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:35:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: generic/204: fail if the mkfs fails
Date:   Thu, 29 Jul 2021 16:35:53 -0400
Message-Id: <fe1cd52ce8954e5aee1fc0a4baf5c75ef7d2635a.1627590942.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My nightly fstests runs on my Raspberry Pi got stuck trying to run
generic/204.  This boiled down to mkfs failing to make the scratch
device that small with the subpage blocksize support, and thus trying to
fill a 1tib drive with tiny files.  On one hand I'd like to make
_scratch_mkfs failures automatically fail the test, but I worry about
cases where a test may be checking for an option and need to do
something different with failures, so for now simply fail if we can't
make our tiny-fs in generic/204.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/204 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/204 b/tests/generic/204
index a3dabb71..b5deb443 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -35,7 +35,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
 [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
 
 SIZE=`expr 115 \* 1024 \* 1024`
-_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
+_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
+	|| _fail "mkfs failed"
 cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
 _scratch_mount
 
-- 
2.26.3


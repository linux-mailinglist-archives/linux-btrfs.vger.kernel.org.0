Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046812CDD71
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502007AbgLCSY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502001AbgLCSY6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:58 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162DFC094250
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:58 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id p12so1414593qvj.13
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/v7OXjRav6KqGI7SIs6G5lf5b7HJWr83Ws2znh3xAg=;
        b=M3CRL2IdF5KKyYda1Foi8Gpr1wojFLF08nFEl1UDJppiMEfpiXPwKSQFZ2oGWmrf17
         LYLE5cRq7oHqakvHVPZU/PN/L0bvUzY8pvxRgQbYgtIf5QiRkh143YZ+39cVDN6k9qZu
         y2BXVCj1gPF5lryw7QBNlFVItl1DqbtX4gR5xD1wPSD3tePw0jCvw8CMOYEPLcSdGzQK
         iB5T/ekXlzmU4c8SXxEjMFFhNnIBbuY5pGsB0J4D+obpx7itmTXMh/h92dzh9CmbeeLe
         t32/CrAjDDJEwNY2oBSJolRmFIYZWgbfGneajBn3GefYapkhG82vGQfFckg32/Mx4A+q
         CQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/v7OXjRav6KqGI7SIs6G5lf5b7HJWr83Ws2znh3xAg=;
        b=A046aI552+eYuz8vUhZEl4rPfVW2za5yARyjKvTak8heST2OmSemC12Vs55ikQzy7N
         5xmjxWkvacQamEaMJq0hLpCM+ejPk91IZIGmTac3nQmTEF3hVyWL4EAZFubwmm4nMtuK
         oTXJ5NmO/Jy64mQXcqcsH8jOBue+qvFX/JxPDXwpnyZP490uRB6uXGweLIGrnPapFUAF
         bkxX0wgZg98eu4dq7lhgZBzQT7sa1NtGDUxicaoDhewmxLtIxiVSWZjDFOkNPtIQc6+q
         sPJBvze100LEMdZ+r3NiSu0oyKnB8VXR0GKoSZnGipxNIiF7Gai+BJXvMXRs7KKs9PDi
         VpZA==
X-Gm-Message-State: AOAM531anmvR2IPqggxsxj2m+ebgzNJ2Ji6NHncJfNUSIVuyr99psED4
        IRs1zsupt0khTC792aKPxZuFAkjoncc0i4bv
X-Google-Smtp-Source: ABdhPJxvWgU6wZzZK0+oNqMSeiF3CyqyjftKb3K36JgGpf8F5rl6nmlKODXyKMJ1bMNHVdLqs8wkkg==
X-Received: by 2002:ad4:4743:: with SMTP id c3mr155373qvx.31.1607019837052;
        Thu, 03 Dec 2020 10:23:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 17sm2048809qtb.17.2020.12.03.10.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 32/53] btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
Date:   Thu,  3 Dec 2020 13:22:38 -0500
Message-Id: <039f3fa8a8b32ddcec6b8332d542d63b43e7e102.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in commit_fs_roots.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5393c0c4926c..5064beff3f9f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1344,7 +1344,9 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
-			btrfs_update_reloc_root(trans, root);
+			err = btrfs_update_reloc_root(trans, root);
+			if (err)
+				return err;
 
 			/* see comments in should_cow_block() */
 			clear_bit(BTRFS_ROOT_FORCE_COW, &root->state);
-- 
2.26.2


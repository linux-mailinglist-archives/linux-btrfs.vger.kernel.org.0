Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B967C4B18BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 23:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243422AbiBJWog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 17:44:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345176AbiBJWoe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:34 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92065589
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:28 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id k25so7126402qtp.4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIUBiFJKZzZSqShgE6KZhPyylgU2ZHlMeO3bjMOYRqo=;
        b=ZtuderD9PjV0RnLP3zvv9KYuxKY4Ci4PVEO/J4qBZyjVumFL+PA7qcbzllVxqCSPhj
         iMkKjZZQlbvwiaWqdaAtfTmjcezY0lbFsUNPRm/CHa8feJUeBT/JK6BXMia0fi8CAqXh
         ho9H+3G/c7kVzYlH6Qv3QrfywDUxNDisdlWr+cWhYoZrwXu0XRLqybd/SLF932Rp/5PS
         atxmiFGJxWtbfBPn5aHmFBRyTntyn3hSTr41jYv9jyyFc57Lw0gKQ1Bhw6gCQ5WCRDAj
         vGxB9qAxvugS/+X2UoPs/kKzRu+m6cnI16COrQmNqtc5szg+RzQsTF/EbbE1JdhnOPam
         FImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIUBiFJKZzZSqShgE6KZhPyylgU2ZHlMeO3bjMOYRqo=;
        b=FShqAaEc5gIdi6h2g/2cJusC0wZlbQwjJuUzEjhRcThTJKu9r4LNNi//L7LP+VDABI
         YhTJPDctlrmezpCuFm4ffnuu08+ZCa0QL8gL6UVgldGhsnUAGXxGeRJ+3JqINQJF5qHq
         cT4la4CadEB5XLR2cS9jYP/QjWdfZeb4b9/EsoyMGbBK6zP7DNPnPXi5LcnuFlcXYK5j
         pDSwJ0vwg/wVW6pUjPzYND6wUIuWB+uKIGComXdAxKdmfysBhxA5Lkev2vVYUDGCCEzd
         CBvJi94R7CD8VxgqHAAIeQNTXlmhI1E4jBidfmO+6dxnkKGYdph8tFsInJHo8Il1kYR1
         5RGg==
X-Gm-Message-State: AOAM532eOVNZUsigPgxdDIKiEKMd7kbyuBDtFqLnUAoyTYj2U+8F+vKP
        ZDZo2/0MaiogyoqdD4TDNJTTy5n8EB8uPywT
X-Google-Smtp-Source: ABdhPJz+Yb0Hs2+Zm7Ti2tfP4IrRIF5rDDDUQWGKiNR/4zt54Uohehaik506FwOklalmauBv6k1vNQ==
X-Received: by 2002:a05:622a:5c6:: with SMTP id d6mr6490086qtb.102.1644533067644;
        Thu, 10 Feb 2022 14:44:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d6sm11676809qtb.55.2022.02.10.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:44:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8] Fix error handling on data bio submission
Date:   Thu, 10 Feb 2022 17:44:18 -0500
Message-Id: <cover.1644532798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Internally we tried to enable a remediation to automatically re-provision
machines that had checksum errors.  This was based on dmesg scanning, however we
discovered that we were getting transienty csum error messages.  This came down
to getting a transient ENOMEM while trying to lookup checksums while doing a
data read (this was on memory constrained containers).

What we were doing was simply acting like there wasn't a checksum there, which
would print a scary message about missing checksums.  And then we'd do the read,
but because we didn't have a checksum we'd complain about a checksum mismatch.
Neither of these things were actually what was happening, we simply got an EIO
while looking up the checksums.

Fix this by properly returning an error and erroring out the BIO with the
correct error.  This is actually correct, it allows us to skip the IO and also
not erroneously tell the user that their checksums are invalid.

While testing this fix however I uncovered a variety of problems with our error
handling when we submit.  So the first two patches are to fix the main problem I
wanted to fix, and the next 6 are to fix problems that happen when injecting
errors into the checksum lookup path.

With these patches I'm no longer getting csum mismatch errors when I fail to
lookup csums, and I'm also able to survive a xfstests run while randomly
injecting errors into this path.  Thanks,

Josef

Josef Bacik (8):
  btrfs: make search_csum_tree return 0 if we get -EFBIG
  btrfs: handle csum lookup errors properly on reads
  btrfs: check correct bio in finish_compressed_bio_read
  btrfs: remove the bio argument from finish_compressed_bio_read
  btrfs: track compressed bio errors as blk_status_t
  btrfs: do not double complete bio on errors during compressed reads
  btrfs: do not try to repair bio that has no mirror set
  btrfs: do not clean up repair bio if submit fails

 fs/btrfs/compression.c | 50 +++++++++++++++++++++++-------------------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/extent_io.c   | 25 ++++++++++++++-------
 fs/btrfs/file-item.c   | 15 ++++++++++---
 fs/btrfs/inode.c       | 12 ++++++----
 5 files changed, 65 insertions(+), 39 deletions(-)

-- 
2.26.3


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260914BBBC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiBRPDt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:03:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiBRPDs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:03:48 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E1123C848
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:31 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h9so15265457qvm.0
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gCUyyl+05DrnntKHtCqplAdzCGcdyau4Q1TqtueG2/I=;
        b=jMAfmeiqk2Vbql/3/RBx5gWW+GMXuvrAPAMKp+QW4KYuTAYxok2aVg8e0Vm7j38QoW
         IuKB2EA1eT1cL3924GVKWpCHT84WJl6fRs/A5zSTcyvKGEh5QWGexOuuHJSiDn/HlJFY
         keKzbiBmJefbzG8eN+rRg9yHrTqROcKYfmJkumOqhpzHr7rNa4zXbRQCsZsiKX80RSoo
         cNYfkdUm8taRcX4JdFQ4xUyUoYk79CMmwGpn5OUSDpjkQCkKz9NXB+rk3YZ7anCOPpfs
         Xqa0CSZHvOoHiPCkkhFhEicw2o8FqhECU8m8WfO3LZ44mumWK6eE3HzJFhITPPB3toFd
         NzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gCUyyl+05DrnntKHtCqplAdzCGcdyau4Q1TqtueG2/I=;
        b=f7IQIt7TRoKQqrr+NybBHVxp5yvOsbkwDFSeDAtLkdfuk0OZkKOQv4j4QKXZGnGEm1
         jui4tGclU6pVkIvpU3LKsCezeafJOhSOd/cDHgq0WBqzP7sc8GSbbCaLvfTNfrck/FbO
         Jqzdc4szawGn3Pe2GoTtGE7MV0151o2SnxPJX9Lm9JbjKOOsGfAIXyHr6XqxItek+uXJ
         uBx0t4wNO+IJtIhuvu35NtPM+If8Fz3Z3TKbUOPgtLlsrcQ/4GLtqND2m/XFUond54yj
         ss9BUMAnGRIBavmjgl85hq/u5CAKpqATNGxtANXsDxNTCAkl3g5wtmlvymi1z3GLn4TB
         6zBQ==
X-Gm-Message-State: AOAM531BDnpcdCROTkZM0AhHi3xDEQKL2WaKaM2iEm5yIyLNbK9yOTMV
        jpqws/+1/VlCcpKg563DDKwGn5fafM2zq3NP
X-Google-Smtp-Source: ABdhPJyslUY4fk9wgzke1V02vp5hC7cPJ+XU4ysXHrFMFs1Hq8ecdKOlvmFQO+yCBTTWzduRc9W+3A==
X-Received: by 2002:a05:6214:20ec:b0:42c:326d:771b with SMTP id 12-20020a05621420ec00b0042c326d771bmr6177545qvk.0.1645196610446;
        Fri, 18 Feb 2022 07:03:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y5sm21560156qkj.28.2022.02.18.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:03:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/8] Fix error handling on data bio submission
Date:   Fri, 18 Feb 2022 10:03:21 -0500
Message-Id: <cover.1645196493.git.josef@toxicpanda.com>
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

v1->v2:
- addressed the various comments, expanded on the comment about NODATASUM and
  the DATA_RELOC inode since I had to look up why we even had that there.
- Added the various reviewed-by's on the patches I didn't touch.

--- Original email ---

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

 fs/btrfs/compression.c | 58 ++++++++++++++++++++++++------------------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/extent_io.c   | 25 ++++++++++++------
 fs/btrfs/file-item.c   | 43 ++++++++++++++++++++-----------
 fs/btrfs/inode.c       | 12 ++++++---
 5 files changed, 87 insertions(+), 53 deletions(-)

-- 
2.26.3


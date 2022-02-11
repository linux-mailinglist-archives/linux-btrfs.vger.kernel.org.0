Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B884B2A36
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 17:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbiBKQYo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 11:24:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351470AbiBKQYn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 11:24:43 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7A03B9
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 08:24:42 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id p14so9530396qtx.0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 08:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UM7vnTScxCF714/XhlXbhQa7h5H99Izud/9wtVMouU=;
        b=sbdTDbaF/Tw2oaXtT/2K5kEunY2Kbq5iVkOvlpW1Du4JDzlPdJbgLRxO29ng2VNco+
         VIfZQhDXjbw0pMVTIdAM7zpGOvcJW2v77acDMhMLcKRCLx1oYwmBcWDmTFxJo8p00cp4
         q3OB1uDDlvTZeV602iJsded0wzbTsDT6wwrPl93B370KukPpIirF/VpoPHhLNJlA39Id
         y50W7e3UTvOzUc4h+vXd/RH40AMcW5ZwO9YEEb2dD1q6ZS+B/yltgVqgMGOrDnCObaGM
         Hkjk+LtEaUPG4TBIgfcMngIfzr21CB3wONTk6xhqV95G+22+HzR7hY00TWPLldhE2nOU
         pUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UM7vnTScxCF714/XhlXbhQa7h5H99Izud/9wtVMouU=;
        b=HGFKjbBj07mmnj5myiesxuGkw8K/zkF0baBv1qNDVZ64P/cZFy7rP0M1Xlf9jrmAW3
         rm3owzuLA9iGi0uxe1G50TVJK2IPEFJe0X+E/ojubs6l58lkmQFrWBuDQqobjp59FPzJ
         Z94UIvJR0OTOgpQZmLuZT7pr0CN83kVB/PTMsxgQN7vxELQkCWriyUdJKVW1KFzyCFDJ
         JsD2fr8CSdUpUw8Ly1quNmWUqvhLn8FvB+EmsNTKkVJrGHp0yQXlT+sww8FLI3R2biFY
         r68hBzKEMTcARq+HBS/yqjUCm4/55IpN4fKhrqYoHqLjHDKlobPHCebzcg7I/btLI/R3
         b0+A==
X-Gm-Message-State: AOAM530zPj3IPkj+a2oo7J1q5xErc/C0s0pDCotTV1Gsq3Ihs1Y0swd8
        MZNpxkpdTzPYBMckJ0lNj2+h/uoa58K1rguT
X-Google-Smtp-Source: ABdhPJyrHhFBsM1N+gtFBBBGWUw38mpdy2wLPAQG37jdA5Q0fGNSNXSzzKo26wBRLyqCJdYqUtFG+w==
X-Received: by 2002:ac8:57cc:: with SMTP id w12mr1700794qta.155.1644596681124;
        Fri, 11 Feb 2022 08:24:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i4sm12461768qkn.13.2022.02.11.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:24:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] Fix another !PageUptodate related warning
Date:   Fri, 11 Feb 2022 11:24:37 -0500
Message-Id: <cover.1644596294.git.josef@toxicpanda.com>
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

We hit a warning in generic/281 in our overnight testing.  This is the same
error that I thought I fixed with c2e39305299f01 ("btrfs: clear extent buffer
uptodate when we fail to write it"), however all I did was make the race window
much smaller.

The race is relatively simple

Task 1					Task 2
switch_commit_roots()
					btrfs_search_slot(path->search_commit_root)
btrfs_write_and_wait_transaction()
					start processing path->nodes[0]
write failure
end_bio_extent_buffer_writepage
	ClearPageUptodate()
					try to read from the extent buffer
						trigger warning

There's no real way to stop this without adding some heavy handed locking in
here to make sure we don't invalidate an extent buffer while we're reading it.
And we can't really add more locking because this particular path uses
->skip_locking, so we'd have to be very intentional about what we're wanting to
do.

To fix this we need two things.  First is to be consistent with how we use
PageError.  Everybody uses it for writes, and in fact that's how we use it with
the exception of one error path on the extent buffer read.  So first fix that so
we don't ever have PageError without a write error.

Secondly change assert_eb_page_uptodate() to only WARN_ON if !Uptodate &&
!Error, so we get a warning if we didn't properly read an extent buffer, but not
if we failed to write the buffer out.  With this I'm now able to run 100 runs of
generic/281 without warnings, whereas before it reproduced in around 10 runs.
Thanks,

Josef


Josef Bacik (2):
  btrfs: do not SetPageError on a read error for extent buffers
  btrfs: do not WARN_ON() if we have PageError set

 fs/btrfs/extent_io.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.26.3


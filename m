Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D971389204
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 16:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348687AbhESOyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354875AbhESOyJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 10:54:09 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81E7C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 07:52:49 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i67so12956001qkc.4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4bD87Yf106hlcWc1kf5qZ5vmpAB29HPMzqXNZ9kuV4=;
        b=N/V6GqnR3Esn/FE52ugOlb/qoxl4pnZWtOf4H9ytvHTl5JIJ7qLEMDwoGud7RJhOuf
         UWxVmTJBsvRz9FuFTpdn3NqziyqX2d1OAP6XSVncPbkdoLC/nmoyDuyAV45gEp7PkugZ
         9cAY/DYrYzPOxZKYSbloLnzq0IoArfh0MGhTWQG5t/n1crY1KJsTIBWxafo0v6ZJYDoH
         FFJXZ1zfeRvSHuAJbHeQjasZqStsgoL0tv41Igr3J4TipiP6TmVeMqamF12IiPFLM5lZ
         PEBxcHs+IX9CxsSrqdaFDzzf/zL3QJN/wP7JnsKLumZT/h8jKp9CKPQhTUQlH8VC5iv2
         NJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4bD87Yf106hlcWc1kf5qZ5vmpAB29HPMzqXNZ9kuV4=;
        b=SGevQhZxPysWLreITVh10PZW681vaHpI98wl6+T4jH7XI6hRaNr+h3EFxg3U6qcAiP
         iFk/5hjp8z3QKfJQO18bsbQ1ZsuH5enNizOn09SIUSt0/+wapglMutzviiGuCmceSvtz
         WFTIGZg4kac2CFeJz5m0OFL95PZcUJ+lIBtNdd7Tk53BzRjlJxKl84nz1FfPi3c94XZM
         MUjxPShK/URAB5BaZCpjP5STzn2UpIxUXMapr2Lp3RYmyQzPknrcEcCGFsdeD5RjbRMS
         xfKQqe0uBV5rCsX63mg/x19TLIAIW830rQCX22aUcTCU8r9lciaxGJUmfVk4f6aXenCi
         TAfA==
X-Gm-Message-State: AOAM5305culcdHKxa+NYJ34wU7nHaBOs16aSHVLHlfpjilNrOXWcQZNC
        paC2bN/RLO/3ZzD8qzny6eQ7rwb0C4M03Q==
X-Google-Smtp-Source: ABdhPJyi8/LhF65MLKXc79ieerq3TuFQYcvfH0lSxELda0GqXvItZB7uLZq6MKYk05Hb5EGlsBAgdw==
X-Received: by 2002:a05:620a:2215:: with SMTP id m21mr12600539qkh.61.1621435968523;
        Wed, 19 May 2021 07:52:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t6sm3412995qkh.117.2021.05.19.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:52:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] btrfs_del_csums error handling fixes
Date:   Wed, 19 May 2021 10:52:44 -0400
Message-Id: <cover.1621435862.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Here are two fixes related to deleting csums.  Doing error injection stress
testing I was consistently seeing cases where we had a corrupt file system with
csums that existed without the corresponding extents being written.  This was
occuring because we were losing the return value in two cases, both of which
would result in this style of corruption.  With these two patches I'm no longer
seeing these errors.  Thanks,

Josef

Josef Bacik (2):
  btrfs: fix error handling in btrfs_del_csums
  btrfs: return errors from btrfs_del_csums in cleanup_ref_head

 fs/btrfs/extent-tree.c |  4 ++--
 fs/btrfs/file-item.c   | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.26.3


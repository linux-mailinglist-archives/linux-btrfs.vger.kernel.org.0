Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE08436AF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 20:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJUTA7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUTA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 15:00:56 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4058CC061764
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:40 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id d6so1046703qvb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HN65hCLTvkrVL+9hRavYa7pmGxitjpZbs094B+wnqJI=;
        b=AGKc6vvs17JzPIeIe9IkHu74oVidaDYAa48f9ald13TcJ8JmLg1xJwZznj6tzOjEwu
         rvMnoAEstmyIpZ/tiYBoaECRXhvvPqlyIE2a7RyHKPgIccgNv5SuVMYCK5V288bhO5Bj
         P3zyJrqxFNzFW9q0i3bgQh6aAjfeoZLpZI/aC/hutCp8Z/Ak4l3z18+paJ3zlYNpKXKI
         77nGfWaSwNcCUrbJMOvzfgwg9Adn+EqMsDu0Nyb2nDXJB0BuPvXZ6WJw3WoZV2MCQdXM
         K4FXo2TlOGECdjXI/XVKCHuQRGDw8nDj1APfb5/K9M3OIz30pjJpFYmrQ/EMrJ8Rk1EC
         t9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HN65hCLTvkrVL+9hRavYa7pmGxitjpZbs094B+wnqJI=;
        b=mFxLuqdXjhc9xgXBI4XDVorSAHqVYosawlTZC/936PMsvJqbuHZOLQEf1OjPgdtZmM
         25xwYjbCbtH0+Kvier6ibJXJp1ErVtXstXuuK0W0UfW1qT2SdaZIA5eaB59wfTsg3Z/g
         AsUUtvw+UbJ0ydYtt/67nckKZ1cpx2dUf+zmF3RrycL3VJHvhABNd1bSdfJD6I3hJiO6
         YdjmX+GGdyXX4grOr2gESjQ/j2iJ0mZ/tP8DMwLdRsnd2ZYVuxGcYuH52uULqKG0DCk9
         1NYPBMU0jAwWpgrghXWh/9qJUddFZOWCoLAF8Xf75lbSee1xJF7eUE29fUvG/tyj9Wak
         JIFA==
X-Gm-Message-State: AOAM530ksbi3zQqpfLfe+8552fvkzC29AOS1/eVe/FSMcokYMJY9p6SM
        V8r5fu9w7hFensw07IqZq3AfSBOQuLh0lA==
X-Google-Smtp-Source: ABdhPJz1j0+1xy+bwf3c1xE2WKP0VqoE7z7J8X8nIAomRLRbOeZqV9hsCl3r0ZoiGtccn7xqxIcbpA==
X-Received: by 2002:a05:6214:194b:: with SMTP id q11mr6704028qvk.38.1634842718948;
        Thu, 21 Oct 2021 11:58:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s15sm3132059qtk.34.2021.10.21.11.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:58:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/7] Cleanup btrfs_item_* related helpers
Date:   Thu, 21 Oct 2021 14:58:30 -0400
Message-Id: <cover.1634842475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

We've got a lot of odd patterns with our btrfs_item* helpers.  In a lot of
places we use teh btrfs_item_*_nr() helpers, in some places we get the
btrfs_item and then use the direct helpers on that.  Our btrfs_item_key()
helpers only take the slot.

Fix this up by using a leaf+slot combination everywhere, and only use the offset
calculations in the helpers.

This gives us a net deletion of about 40 lines, and also allows me to more
easily change the btrfs_item math when I change the size of btrfs_header in the
future without needing to update all the callsites to pass in an extent buffer.

Thanks,

Josef Bacik (7):
  btrfs: use btrfs_item_size_nr/btrfs_item_offset_nr everywhere
  btrfs: add btrfs_set_item_*_nr() helpers
  btrfs: make btrfs_file_extent_inline_item_len take a slot
  btrfs: introduce item_nr token variant helpers
  btrfs: drop the _nr from the item helpers
  btrfs: remove the btrfs_item_end() helper
  btrfs: rename btrfs_item_end_nr to btrfs_item_data_end

 fs/btrfs/backref.c                   |  16 ++-
 fs/btrfs/ctree.c                     | 148 +++++++++++----------------
 fs/btrfs/ctree.h                     |  55 ++++++----
 fs/btrfs/dev-replace.c               |   4 +-
 fs/btrfs/dir-item.c                  |  12 +--
 fs/btrfs/extent-tree.c               |  14 +--
 fs/btrfs/file-item.c                 |  24 ++---
 fs/btrfs/inode-item.c                |  14 ++-
 fs/btrfs/inode.c                     |   3 +-
 fs/btrfs/ioctl.c                     |   6 +-
 fs/btrfs/print-tree.c                |   8 +-
 fs/btrfs/props.c                     |   2 +-
 fs/btrfs/ref-verify.c                |   2 +-
 fs/btrfs/reflink.c                   |   2 +-
 fs/btrfs/relocation.c                |   2 +-
 fs/btrfs/root-tree.c                 |   4 +-
 fs/btrfs/scrub.c                     |   2 +-
 fs/btrfs/send.c                      |  18 ++--
 fs/btrfs/tests/extent-buffer-tests.c |  17 +--
 fs/btrfs/tree-checker.c              |  56 +++++-----
 fs/btrfs/tree-log.c                  |  34 +++---
 fs/btrfs/uuid-tree.c                 |  10 +-
 fs/btrfs/verity.c                    |   2 +-
 fs/btrfs/volumes.c                   |   6 +-
 fs/btrfs/xattr.c                     |   8 +-
 25 files changed, 215 insertions(+), 254 deletions(-)

-- 
2.26.3


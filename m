Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB2029951C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 19:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784002AbgJZSSL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 14:18:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33363 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783842AbgJZSSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 14:18:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id t128so4234791qke.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OI2m/g/c+XuiWHYN/0R5Pjng9uIV6DiSTVnQ8cvXz+0=;
        b=JQEEgt4GXQKy3aU5Klxryjl04pW8cqXldephG/xqGfzufHOrjkNxtd4x1XzHyyGIMl
         DESPiqkS5LSpHalnZFMnkSUS/V7+CpvBJt6uA/sa4ssKwm8YN+X0Cp8JdlRXja9upZ+n
         FstttgyZJMbNI3CKYhcdbhKCZUP79eQWiWy7uLNcSVU+hvgd9o+w484hZ/p/p2QDhld7
         nd2pIHF5NkEyAzuEcqbzU8vHHKAmm5NFgW7DlMwXzfp22MsmQQ6CzcAyVP0nHWHYYSbC
         I1Y/POtI1x1tBDSYJjSN36tNJTqK6k0+jOwjM0I1AO0Ju0Llr7Qlg5oEjf9iq0yMYpAW
         x1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OI2m/g/c+XuiWHYN/0R5Pjng9uIV6DiSTVnQ8cvXz+0=;
        b=trlFhfmeJ8YawmEa6FdkoHypOv5EcqGqBP8UX+x0di6Bw75VuofgvCn21aRIlqMYOC
         AwTtVRFV8oNdE8WQndblE1fl3SbauPBwnb3agmA7dBUWDhsk8hcI5Zw70T7UtOTHXhsI
         xIFe7/r4DJEGduBm89/kcjyQkgxl/gr9dqGqgPBomZ6zAXyYWxxqxA5y6+CYnwMhZNcs
         r5pLqF7aYfJqWR6E5VPxfJSDLN1kKE4BuYtWmjaFoSG5lU5Gu+S844Bz2juNP/7XdJfa
         g4KMGcePhnrcXxPfYMXFPyXomkfMkEqodxZ3IdOw0+mfLo+VY8JKP7VYayFVKpOL7xaC
         0zEw==
X-Gm-Message-State: AOAM533/z65eQI5M6AyAR8NegsEVG27OMcChYucegrM08OA43gie498W
        l5vMdi61WG+sT9vGQLcX5N4+LeeRi1J6Phf/
X-Google-Smtp-Source: ABdhPJym/+lN7dOMwXYR9b8zE1MoIS/ZFFmeVHFVwgBxVrA9xv0U6+OEu82zRQvODk0/VWjap8RnrQ==
X-Received: by 2002:ae9:e314:: with SMTP id v20mr19054235qkf.93.1603736288700;
        Mon, 26 Oct 2020 11:18:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i20sm5181202qtw.66.2020.10.26.11.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:18:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] Some block rsv fixes
Date:   Mon, 26 Oct 2020 14:18:04 -0400
Message-Id: <cover.1603736169.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Nikolay has noticed that -o enospc_debug was getting some warnings in
btrfs_use_block_rsv() on some tests.  I dug into them and one class is easy to
fix as it's a straight regression.  The other one is going to require some more
debugging, so in the meantime here's the two patches I have so far that can be
merged.  The first is just to make my life easier when debugging these problems,
and the second is the actual regression fix.  It should probably be tagged for
stable as well since the regression was backported to stable.  Thanks,

Josef

Josef Bacik (2):
  btrfs: print the block rsv type when we fail our reservation
  btrfs: fix min reserved size calculation in merge_reloc_root

 fs/btrfs/block-rsv.c  | 3 ++-
 fs/btrfs/relocation.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.26.2


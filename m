Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBD22112CBB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 14:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfLDNhM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 08:37:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55233 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfLDNhM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 08:37:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so6994523wmj.4
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 05:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jk/jHF8DRsJObYpqJd0JbPAcZq0OWRhiSUFhVWjoH8=;
        b=XdGZyNPF+L41VIg36d9sArb+ACJZCoSTIhZMTAcBA7o40HKtfJQSMIXr6EsMomb11G
         h+/8VSzNTJkNrXtHrJgV5OHN/yjNoN/62XwnXAE4CYslRo6EjhPIeXZmTJOvXV/pKPUs
         uFA++nSyUyPRGeBdf2Tnz8wNhj+lh9nOUhjEE92zfJcPzZD2oWAdUkAJJS7kK/SHnrKN
         TkZqm67qiA1LwDwBwvwjhloyOeZDeQB+jxPtHbbDxVjRLrOuQdfaPZW1D7tm0hFViWsk
         vO4Z+TQMpR/E+70me2fWdvghe2RyHOuJetK3Xxyf3UID1DASRqAuh1Ocu+oyd6RVEyN0
         qYkA==
X-Gm-Message-State: APjAAAXPdin1IV9+LkEkim2DOailPpGJghOPRApmSHxcp0I25aFc5A/s
        k2uhVRy3ZaJIXPsoF9HRZ+/KT+eHR0k=
X-Google-Smtp-Source: APXvYqz+lTEnAYZmH8eVsjcWy78wETXfAOii1tdaWRnO7N0E1ctfnUQ5+JcRYAb5ovyertvcUnJcIw==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr23541661wmj.117.1575466630319;
        Wed, 04 Dec 2019 05:37:10 -0800 (PST)
Received: from localhost.localdomain (ppp-46-244-211-33.dynamic.mnet-online.de. [46.244.211.33])
        by smtp.gmail.com with ESMTPSA id q3sm8291948wrn.33.2019.12.04.05.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 05:37:08 -0800 (PST)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v5 0/2] remove BUG_ON()s in btrfs_close_one_device()
Date:   Wed,  4 Dec 2019 14:36:37 +0100
Message-Id: <20191204133639.2382-1-jth@kernel.org>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series attempts to remove the BUG_ON()s in btrfs_close_one_device().
Therefore some reorganization of btrfs_close_one_device() was needed, to
avoid the memory allocation.

This series has passed fstests without any deviation from the baseline.

Changes to v4:
- Clear dev_stat_ccnt on removal (Dave)
- Don't clear BTRFS_DEV_STATE_MISSING and BTRFS_DEV_STATE_FS_METADATA as
  they'll be handled elsewhere
- Release extent_io_tree (fstests)

Changes to v3:
- Clear BTRFS_DEV_STATE_WRITEABLE after calling btrfs_close_bdev() so
  btrfs_close_bdev() can call sync_blockdev() and invalidate_bdev() (Nikolay)

Changes to v2:
- Completly different approach to the origianl patchset, instead of handling
  eventual allocation failures.
- Dropped already merged patches for ' btrfs_fs_devices::rotating' and
  'btrfs_fs_devices::seeding'
- Kept the 1st patch of the old series, as it's a nice cleanup

Changes to v1:
- Fixed the decremt of btrfs_fs_devices::seeding.
- In addition to this, I've added two patches changing btrfs_fs_devices::seeding
  and btrfs_fs_devices::rotating to bool, as they are in fact used as booleans.



Johannes Thumshirn (2):
  btrfs: decrement number of open devices after closing the device not
    before
  btrfs: reset device back to allocation state when removing

 fs/btrfs/volumes.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

-- 
2.20.1 (Apple Git-117)


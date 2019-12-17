Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21FFE123752
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 21:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfLQUaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 15:30:07 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37518 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfLQUaH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 15:30:07 -0500
Received: by mail-wm1-f42.google.com with SMTP id f129so4640894wmf.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 12:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OS4Bnx3kWPzhl1EaFFqoekT/BzMzV0Tn4ovqTEWSjFA=;
        b=l4iUDqPkb2rKDlCtZbOnrWFlm9y+r+CB/ZQ18cmJ6Bv5N6HRhu/OY9/pFnLrtqDmrD
         I6P8OwEtvVBFpCElUiR3OrhbRDi8mqkF5JSEZdXz+hwKTdAdc5n1c7YOyqE5K57rvAGw
         /jQK5FgXtzASAP1TGUpIaCdxb2cRw7WtzJx0+jrAqBCbFCGn0ju2nn3WGPs5zL1aw9eM
         VXGTv5+5qLZTptvTVtpfIqPn7nD0MnQQ/Crd7xx/HpYWUkaZCUbomSZeHu0QSbkBUE8h
         rLmJWHT/39RteCeioXbItrgCyluaqITK0UOA9e4NmhayiE2N0c0weFNkWrVoJccynTsy
         6IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OS4Bnx3kWPzhl1EaFFqoekT/BzMzV0Tn4ovqTEWSjFA=;
        b=QYhFD4+vyaus6UFd6G9X32opqC7O1/WE1xn8wZ64v+1zsDMZnpWuKNAtgDzZ0MgFNN
         9/Dz4eDnOU57HoPlBB1MY+2P8qQet2cIKouap3TzD+8MuNNOzYdN3usD3z/KjIT9OXVO
         Mf10tMyfolydup2snd657trdmfzmfAS0phSOcCSFO8+GqP4Mh8FfjKKaQYCOHvruMMZu
         oOzxt7Piwn0gEBEdysO/mKSKbtjPFQr+ibLpkEbWLrYBiDXNN4UDEyTs5NQKhDQU7bFc
         W7X+z2uMIGT17D0x4V82OnQU7yNNoa1xF5jfzY+DEKpTX/l7jW77WFtBMSl9G8E6t6E9
         21bw==
X-Gm-Message-State: APjAAAW1olFmA1y9RqQqbP0bxlQgMtttueBkYwGzYsshSyYkpgv2fuLd
        qTUWGXPvRx+YhtcdAVCmE+yLIKDO
X-Google-Smtp-Source: APXvYqx/wMZfKskwtYyoS1aSIv1EWhpJIX8tmuSFvAL4thtQeYt1SacchR4J9IZ9hofVfLc4Y+imVQ==
X-Received: by 2002:a1c:498a:: with SMTP id w132mr7118078wma.10.1576614605382;
        Tue, 17 Dec 2019 12:30:05 -0800 (PST)
Received: from hephaestus.suse.de ([179.185.209.78])
        by smtp.gmail.com with ESMTPSA id h17sm27910619wrs.18.2019.12.17.12.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 12:30:04 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCH 0/4] tests: do not fail if dm-thin is missing
Date:   Tue, 17 Dec 2019 17:31:51 -0300
Message-Id: <20191217203155.24206-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Hi there,

these patchset is trying to fix the issue 192[1] by checking if dm-thin exists,
and if it's not available, skip the test. In the last patch, the same is done
for dmsetup. Feel free to ignore the last patch if you think we should stop the
tests if dmsetup isn't available.

Thanks!

[1]: https://github.com/kdave/btrfs-progs/issues/192

Marcos Paulo de Souza (4):
  tests: common: Add check_dm_target_support helper
  tests: mkfs: 017: Use check_dm_target_support helper
  tests: mkfs: 005: Use check_dm_target_support helper
  tests: Do not fail is dmsetup is missing

 tests/common                                   | 18 ++++++++++++++++++
 .../005-long-device-name-for-ssd/test.sh       |  2 +-
 .../test.sh                                    |  2 +-
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.23.0


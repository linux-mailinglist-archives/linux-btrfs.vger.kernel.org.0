Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3567818A3A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCRUSr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:18:47 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.46]:13866 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbgCRUSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:18:47 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 583FF18FE90
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:18:46 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9KjUufr1s2xEf9KjDU1Q; Wed, 18 Mar 2020 15:18:46 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pL3Pa5aQJHGCSYjXxm3lDB0CU/nUA8AzxML0FGHZOW4=; b=sqNpMbLE7nKOb+Cz20reW/8KIF
        iTfjfj9O8Hi5tnFdCXDRIG1Yn3RqBMXExCBCmvpZ/98ZhxMJAx6Tx00oZ1bjU25a5X7lkSOASE/2w
        dDaRakPQiI/h37/wDKKx5lGrLK/195J07X3ElQsJTwEs7jLJI0SQSdjO5KQFcpkf/+QTXb/XqsJTn
        G5Gn3mfS51blOqwbOeXW8Mtia2Irv31wfNpAyHIfx2EYXbd1InLVqATbLGNDogqq9y2HzGrcoZSOs
        nSlLRo4nlDFuxl/ooyCg7YVEH02jyPlX6M0iw2FeGU6bZ1DRaYT+H2gJ+0r+frWufqpG/Wi68m5gr
        ZOwRZKpg==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9J-000yAj-Lv; Wed, 18 Mar 2020 17:18:46 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4 00/11] btrfs-progs: mkfs: Quota support through -Q|--quota
Date:   Wed, 18 Mar 2020 17:21:37 -0300
Message-Id: <20200318202148.14828-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.66.103
X-Source-L: No
X-Exim-ID: 1jEf9J-000yAj-Lv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Hi guys,

This if the forth version of this patchset. The last submission of these patches
was in 2018[1]. This version is based on top on the current devel branch, with
minor cleanups, minor conflicts and only a real fix in patch 0008. I would like
to ask you guys to review these patches, since v3 didn't receive any feedback at
the time.

I only added my SoB in three patches, which were those were I needed a manual
intervention, or a specific fix as I mentioned.

Thanks for your review,
  Marcos

Original cover letter for Wenruo:
This patchset adds quota support, which means the result fs will have
quota enabled by default, and its accounting is already consistent, no
manually rescan or quota enable is needed.

The overall design of such support is:
1) Create needed tree
   Both btrfs_root and real root item and tree root leaf.
   For this, a new infrastructure, btrfs_create_tree(), is added for
   this.

2) Fill quota root with basic skeleton
   Only 3 items are really needed
   a) global quota status item
   b) quota info for specified qgroup
   c) quota limit for specified qgroup

   Currently we insert all qgroup items for all existing file trees.
   If we're going to support extra subvolume at mkfs time, just pass the
   subvolume id into insert_qgroup_items().

   The content doesn't matter at all.

3) Repair qgroups using infrastructure from qgroup-verify
   In fact, qgroup repair is just offline rescan.
   Although the original qgroup-verify infrastructure is mostly noisy,
   modify it a little to make it silent to function as offline quota
   rescan.

And such support is mainly designed for developers and QA guys.

As to enable quota, before we must normally mount the fs, enable quota
(and rescan if needed).
This ioctl based procedure is not common, and fstests doesn't provide
such support.
(Not to mention sometimes rescan itself can be buggy)

There are several attempts to make fstests to support it, but due to
different reasons, all these attempts failed.

To make it easier to test all existing test cases with btrfs quota
enabled, the current best method is to support quota at mkfs time, and
here comes the patchset.

[1]: https://lore.kernel.org/linux-btrfs/20180807081938.21348-1-wqu@suse.com/T/#m107735cecbf4729b599e6e4eee0a54802909b30d

Qu Wenruo (11):
  btrfs-progs: qgroup-verify: Avoid NULL pointer dereference for later
    silent qgroup repair
  btrfs-progs: qgroup-verify: Also repair qgroup status version
  btrfs-progs: qgroup-verify: Use fs_info->readonly to check if we
    should repair qgroups
  btrfs-progs: qgroup-verify: Move qgroup classification out of
    report_qgroups
  btrfs-progs: qgroup-verify: Allow repair_qgroups function to do silent
    repair
  btrfs-progs: ctree: Introduce function to create an empty tree
  btrfs-progs: mkfs: Introduce function to insert qgroup info and limit
    items
  btrfs-progs: mkfs: Introduce function to setup quota root and rescan
  btrfs-progs: mkfs: Introduce mkfs time quota support
  btrfs-progs: test/mkfs: Add test case for -Q|--quota option
  btrfs-progs: test/mkfs: Add test case for --rootdir and --quota

 Documentation/mkfs.btrfs.asciidoc             |   5 +
 check/main.c                                  |  20 +--
 check/qgroup-verify.c                         |  93 ++++++++----
 check/qgroup-verify.h                         |   4 +-
 ctree.c                                       | 109 +++++++++++++-
 ctree.h                                       |   3 +
 mkfs/main.c                                   | 136 +++++++++++++++++-
 tests/mkfs-tests/001-basic-profiles/test.sh   |  10 ++
 .../mkfs-tests/018-rootdir-with-quota/test.sh |  51 +++++++
 9 files changed, 389 insertions(+), 42 deletions(-)
 create mode 100755 tests/mkfs-tests/018-rootdir-with-quota/test.sh

-- 
2.25.0


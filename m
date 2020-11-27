Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7442C6E9F
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Nov 2020 04:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgK1DXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Nov 2020 22:23:25 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.251]:37661 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730843AbgK0Tyo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Nov 2020 14:54:44 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id CCB644B1E3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Nov 2020 13:31:26 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id ijSok6RAGsvw9ijSokjNGK; Fri, 27 Nov 2020 13:31:26 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Paorq0g9qVN94FUAwATH78SgFl16vqVFwm8dqp77TDg=; b=f3cZQR2XogJyxqMLyjHabG2qe+
        lUMrRApjJ7b85Tfo1BR6ebzKPH+vx6XREC1CtGnR8/kDbVmF9jMsX6U6qbTWYJOVoO07ISM11YkBs
        Ld2zr8K7AmaYQzSpU4s5YDQE/wXvWNT1RgCncClt4EbYALv/sr2mICzcYhiSH0+BcjO6APAmFiGzf
        BwXroX9GWV7VQSytSHgZjOX1wV9UcZbbcH3+AwJtksG8Hfv0+XF3XLOdT4sUPq1D5k+9S1s+zyCq/
        JDXI4JeyDsNiksTz6PRZQ5NAK35zfk0Rj4Hh+Vx9Who6TwfwSr2g6LChxo19s5ofqKocqJhRjyIso
        OYBD0qeg==;
Received: from 200.146.52.186.dynamic.dialup.gvt.net.br ([200.146.52.186]:60574 helo=localhost.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kijSn-003Dm3-AK; Fri, 27 Nov 2020 16:31:26 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
Subject: [PATCH v4 0/3] btrfs-progs: Fix logical-resolve
Date:   Fri, 27 Nov 2020 16:30:32 -0300
Message-Id: <20201127193035.19171-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 200.146.52.186
X-Source-L: No
X-Exim-ID: 1kijSn-003Dm3-AK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 200.146.52.186.dynamic.dialup.gvt.net.br (localhost.suse.de) [200.146.52.186]:60574
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

In this forth iteration, only patch 0002 was changed. Previously the variable
full_path, which is passed by the user, was being overwritten in the inode loop.
Now we create a temp var to store the mount_point when the lookup is needed.

Please review.

Changes from v3:
* In patch 0002, do not overwrite full_path variable

Changes from v2:
* Make mnt_opts check more strict to avoid bind mounts (Qu)
* Print only inode/subvolume when the subvolume itself is not mounted
* Enhance the test by adding a snapshot (unmounted) to exercise the check above
* Enhance the test by adding a bind mount that would trick logical-resolve

Changes from v1:
* Patches 2 and 3 added
* Test created (David)
* Discard changed on btrfs_list_path_for_root and changing find_mount_root
  instead

Marcos Paulo de Souza (3):
  btrfs-progs: Adapt find_mount_root to verify other fields of mntent
    struct
  btrfs-progs: inspect: Fix logical-resolve file path lookup
  btrfs-progs: tests: Add new logical-resolve test

 cmds/inspect.c                                | 44 +++++++---
 cmds/receive.c                                |  3 +-
 cmds/send.c                                   |  6 +-
 common/utils.c                                | 32 +++++++-
 common/utils.h                                | 11 ++-
 .../test.sh                                   | 81 +++++++++++++++++++
 6 files changed, 160 insertions(+), 17 deletions(-)
 create mode 100755 tests/misc-tests/042-inspect-internal-logical-resolve/test.sh

-- 
2.26.2


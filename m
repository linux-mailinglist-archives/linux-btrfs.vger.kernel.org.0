Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC0F2BFF04
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 05:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgKWEh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Nov 2020 23:37:59 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.175]:28934 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726989AbgKWEh7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Nov 2020 23:37:59 -0500
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Nov 2020 23:37:58 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 7EE83400C68A5
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Nov 2020 21:50:55 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id h2sRk3ePxAAk4h2sRkXDSV; Sun, 22 Nov 2020 21:50:55 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ESPiqBm7GDl5p8mSXvp0JFFrU1aFZDG+C1I2Ng+nd20=; b=sTTrPU3Y8cD6aV/LEQ+9ap1I12
        mhqjQFoVIWo4y3Oo8gH8d556p2FFPgCJpgP+JVlCH0NjJz4JVjchG71azCLvjM6oiJRrRMuEvUSMf
        nQu9LoGNMRDUQiTDlvgRSJRaR8nQn+HjD4b4Ufglfhsc9M2LROF3y7TNWk0oV+MvfFmQpWLR1zynG
        FHYL/NijID06hNYnaWfnF9fVCwzbEq/Vih0fSsHcWcdMi5ofNMFhcfv6QGFDNaF2xDLGyOXzUbc+S
        mrC2KsAAHGCThxBDk4/XkQuYQgXAiv0pYxDB84vVAwyJo/4YGyZGnUiGrN2uWJgnEg420XH6ejL7E
        dGy69aYg==;
Received: from [191.249.68.105] (port=43094 helo=localhost.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kh2sQ-0007ir-Vj; Mon, 23 Nov 2020 00:50:55 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
Subject: [PATCH v3 0/3] btrfs-progs: Fix logical-resolve
Date:   Mon, 23 Nov 2020 00:50:23 -0300
Message-Id: <20201123035026.7282-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.68.105
X-Source-L: No
X-Exim-ID: 1kh2sQ-0007ir-Vj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.suse.de) [191.249.68.105]:43094
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

In this third iteration of the patches some issues were fixed. Special thanks to
Qu that raised some questions about bind mounts and subvolumes not mounted. The
first test didn't change.

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

 cmds/inspect.c                                | 37 +++++++--
 cmds/receive.c                                |  3 +-
 cmds/send.c                                   |  6 +-
 common/utils.c                                | 32 +++++++-
 common/utils.h                                | 11 ++-
 .../test.sh                                   | 81 +++++++++++++++++++
 6 files changed, 155 insertions(+), 15 deletions(-)
 create mode 100755 tests/misc-tests/042-inspect-internal-logical-resolve/test.sh

-- 
2.26.2


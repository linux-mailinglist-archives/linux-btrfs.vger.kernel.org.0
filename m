Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67C6169CD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 04:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBXD7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 22:59:38 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.47]:31020 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbgBXD7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 22:59:38 -0500
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 22:59:38 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 2C4963AC9
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2020 21:10:55 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 6491jJAE9RP4z6491jiSvY; Sun, 23 Feb 2020 21:10:55 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0ero3NyMggozYrVIkVkRv1FRU//V7ZobE8nQa+kvk2M=; b=pS3wFvk3XL7ipp5yOjsQPorFgz
        PYPZPk+4SczyvjfxJ0OKCJN105GuKXs/2vCeZdhEUW/EEArSzG/ytJfMWpmp7cpp8X1+1FfjLoN0C
        S8Ybr1dAia9Su1AZQQ1nFVGQE3+gC1I+u4oWz/GW0qDAPt1pX1GE9+G6q2knnCVg9zYdA8ZFPcCzK
        SA1Gz6ZWL9tFkRJeoLb9lS2BJpwhEH3n6C9VYTZChU/6uBXsbVgGbKR4HgCeXuHx3mYJtyi/2zwM9
        khtqpZPBWGkNg88IQZolm6ytF1PBLyC/Evz46PaXlCQbB4wFCHA1G/jDk0xcV4MXzy9jwus8EjPx9
        fu7pfEMQ==;
Received: from [179.185.222.161] (port=40232 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j6490-0034Sn-H6; Mon, 24 Feb 2020 00:10:54 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, guaneryu@gmail.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [ fstests PATCHv3 0/2] btrfs: Test subvolume delete by id feature
Date:   Mon, 24 Feb 2020 00:13:39 -0300
Message-Id: <20200224031341.27740-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.222.161
X-Source-L: No
X-Exim-ID: 1j6490-0034Sn-H6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.222.161]:40232
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Changes from v2:
* Added Reviewed-by from Nikolay to patch 0001
* Changed awk to $AWK_PROG, suggested by Eryu
* Changed _run_btrfs_util_prog to $BTRFS_UTIL_PROG, suggested by Eryu
* Use _scratch_unmount instead of executing umount by hand, sugested by Eryu
* Created a local function to delete and list subvolumes, suggested by Eryu

Changes from v1:
* Added some prints printing what is being tested
* The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
  plain integers
* New patch expanding the funtionality of _require_btrfs_command, which now
  check for argument of subcommands

Marcos Paulo de Souza (2):
  common: btrfs: Improve _require_btrfs_command
  btrfs: Test subvolume delete --subvolid feature

 common/btrfs        | 13 ++++++--
 tests/btrfs/203     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/203.out | 14 +++++++++
 tests/btrfs/group   |  1 +
 4 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100755 tests/btrfs/203
 create mode 100644 tests/btrfs/203.out

-- 
2.25.0


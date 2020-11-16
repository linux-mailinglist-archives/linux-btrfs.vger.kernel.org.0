Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BF92B4EB3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbgKPR6t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 12:58:49 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.178]:15711 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731494AbgKPR6t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 12:58:49 -0500
X-Greylist: delayed 1523 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 12:58:49 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 2032A1430F
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Nov 2020 11:33:20 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id eiNUkjNgCmi4BeiNUkjehQ; Mon, 16 Nov 2020 11:33:20 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/t83n7vGmTwly7pgl8uXCjkyfA+O3xFxydwVD0muCT4=; b=PUzSyI9o8CXXKNC6XI3XVa0RKC
        MsWMsPmjEDzlq0wpZMcyliUcYAYQhsWN+g0dZqwBXTNgV797ENp2eL8c5J0EMpBeiWtqwiK5efthl
        FUb535ygJWNlf3iuPTdxCwgiKficJS/rgcEjfJNrbDn1JolXwbmCEflS/5ZFJb7BH8CcYOE2AtGZC
        Z/WjT4tt89u7tdLFfHCRIaIBfOnibcZC3ULwqlN78AOd+bOH1t6LY5ZsjgWZ3jPd9T1iyqJPYMla+
        lmgGbD8dBwCqxt0OmQm2ie5BKMbl/emAqtVS1MLw/pKhFjv3g6c059G96MLQLUN86KLv80EAkfPaq
        8JvKp2PA==;
Received: from [191.249.68.105] (port=38938 helo=localhost.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1keiNT-000wCw-UQ; Mon, 16 Nov 2020 14:33:20 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
Subject: [PATCH v2 0/3] btrfs-progs: Fix logical-resolve
Date:   Mon, 16 Nov 2020 14:32:46 -0300
Message-Id: <20201116173249.11847-1-marcos@mpdesouza.com>
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
X-Exim-ID: 1keiNT-000wCw-UQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.suse.de) [191.249.68.105]:38938
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

New issues were found while testing the v1, and new problems with the current
implementation too. Now focusing on a generic way of detecting where to do the
file lookup based in the logical offset of the file.

Now there is a test to avoid this problem from appearing again in the future.

Please let me know if this can be improved even further.

Changes from v1:
* Patches 2 and 3 added
* Test created (David)
* Discard changed on btrfs_list_path_for_root and changing find_mount_root
  instead

First version:
https://lore.kernel.org/linux-btrfs/20201112011400.6866-1-marcos@mpdesouza.com/

Marcos Paulo de Souza (3):
  btrfs-progs: Adapt find_mount_root to verify other fields of mntent
    struct
  btrfs-progs: inspect: Fix logical-resolve file path lookup
  btrfs-progs: tests: Add new logical-resolve test

 cmds/inspect.c                                | 30 +++++++---
 cmds/receive.c                                |  3 +-
 cmds/send.c                                   |  6 +-
 common/utils.c                                | 19 +++++-
 common/utils.h                                | 11 +++-
 .../test.sh                                   | 60 +++++++++++++++++++
 6 files changed, 114 insertions(+), 15 deletions(-)
 create mode 100755 tests/misc-tests/042-inspect-internal-logical-resolve/test.sh

-- 
2.26.2


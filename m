Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B574F174AE7
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 04:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgCADaw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Feb 2020 22:30:52 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.38]:29539 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727242AbgCADaw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Feb 2020 22:30:52 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 24A9A401844A3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Feb 2020 21:30:50 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 8FJajee4mXVkQ8FJajzFhi; Sat, 29 Feb 2020 21:30:50 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a4xNQ5lMQ1ll6gifozE4KyLNknnoXkN78iAtpwqSoig=; b=XrnGbtOAMzshkWNnj0JIJnkM6r
        sr5JETU/XH6GWuac60vKtCPF0UvYUvQYtQCLG8r3UXyltYnK1ifCTieCtUS5y//dJXw1E/SaO+4wA
        jjBZTlPkwz6x6CQzaA9zRYL+Qj66KMruG+VjFeCoUx86uTOxDAqyI4EP8fG5mCcF6Xz+Pi/NlHKLc
        /3mrBnuzcV8J4EBSyeA+KanCy5cDwTenPwXgLnGpz6tZaUyLG+I/mokdsr/pZMp55OfxSXOaEykli
        lrxFJliEdrFXU+YdY6YdpCbWBQb7ikMZiqIz/micG+mlyFqN0F7qdQJxtqGWz/xoAVA9BoPJF5wX4
        LHCZ4pzQ==;
Received: from 179.187.200.220.dynamic.adsl.gvt.net.br ([179.187.200.220]:36120 helo=hephaestus.suse.cz)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j8FJZ-0003yt-N8; Sun, 01 Mar 2020 00:30:49 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] progs: fix testsuite
Date:   Sun,  1 Mar 2020 00:33:41 -0300
Message-Id: <20200301033344.808-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.187.200.220
X-Source-L: No
X-Exim-ID: 1j8FJZ-0003yt-N8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179.187.200.220.dynamic.adsl.gvt.net.br (hephaestus.suse.cz) [179.187.200.220]:36120
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 1
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

While checking issue 198[1], I tested current testsuite and it didn't work. So,
these three patches aim to solve this issue.

Patch 1 isn't related to the fix, but it's related, since we remove the manpages
from btrfs-find-root and btrfs-select-super because these binaries are not
installed anymore.

Patches 2 and 3 adjust the testsuite to include btrfs-find-root and
btrfs-select-super in the final tarball, and adjust the tests to find these
binaries in INTERNAL_BIN.

Please review,
  Marcos

[1]: https://github.com/kdave/btrfs-progs/issues/198

Marcos Paulo de Souza (3):
  progs: Remove manpages of not packaged binaries
  progs: Include btrfs-find-root and btrfs-select-super in testsuite
  progs: tests: misc: btrfs-{find-root,select-super} are internal
    commands

 .gitignore                                    |  2 -
 Documentation/Makefile.in                     |  2 -
 Documentation/btrfs-find-root.asciidoc        | 35 --------------
 Documentation/btrfs-select-super.asciidoc     | 46 -------------------
 Documentation/btrfs.asciidoc                  |  2 -
 Makefile                                      |  2 +-
 tests/common                                  | 13 ++++--
 .../012-find-root-no-result/test.sh           |  2 +-
 .../020-fix-superblock-corruption/test.sh     |  2 +-
 tests/testsuite-files                         |  2 +
 10 files changed, 14 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/btrfs-find-root.asciidoc
 delete mode 100644 Documentation/btrfs-select-super.asciidoc

-- 
2.25.0


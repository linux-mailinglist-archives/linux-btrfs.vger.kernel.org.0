Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A7239E73
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 06:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHCExF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 00:53:05 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.218]:38400 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbgHCExE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 00:53:04 -0400
X-Greylist: delayed 1284 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2020 00:53:04 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 91FD14F64
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Aug 2020 23:31:37 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 2S8Pk27R7BD8b2S8PkgT3I; Sun, 02 Aug 2020 23:31:37 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QnM7w0u5pXm2AiJHwxLWYzTI4516cnzgsru1HitDOY4=; b=EyQPGZ8VZ11safK92LWZCdmYhB
        Y8awBy0phkaEWpnbw46MEUNZR/GT482nSgnpmnKbXgvXoUpC4WM0Imj7AEDKbCTMpEbqmQK/cbFRw
        h8t879ZFO7RPvYzzCDx/ypPSuRfa7OmcvUit+MKPg/PNerVK6HB/kYri8KyJlZfYInkmAG2gM2bsm
        H2BNkGFtCRBIxfyzbMZKMEVDw7z50jO9FLKmRjqhlDeqB4uSmHO3e/a+iKTK2QzEw3Hp1kfjRpdj6
        WjChlVHxZMRf5yxHy728rm3KCGcLTeC9eZJ3lQNyd5GCHCoZMdaZA3gXoktLvRVtNtCR5BRcAWUoE
        VUb1ZELg==;
Received: from [179.185.209.90] (port=35170 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k2S8P-0046q1-3q; Mon, 03 Aug 2020 01:31:37 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH btrfs-progs] Documentation: btrfs-man5: Remove nonexistent nousebackuproot option
Date:   Mon,  3 Aug 2020 01:29:44 -0300
Message-Id: <20200803042944.26465-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.209.90
X-Source-L: No
X-Exim-ID: 1k2S8P-0046q1-3q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.209.90]:35170
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Since it's inclusion in b3751c131 ("btrfs-progs: docs: update
btrfs-man5"), this option was never available in kernel, we can only
enable this option using usebackuproot.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/btrfs-man5.asciidoc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index 064312ed..2edf721c 100644
--- a/Documentation/btrfs-man5.asciidoc
+++ b/Documentation/btrfs-man5.asciidoc
@@ -471,7 +471,6 @@ The tree log could contain new files/directories, these would not exist on
 a mounted filesystem if the log is not replayed.
 
 *usebackuproot*::
-*nousebackuproot*::
 (since: 4.6, default: off)
 +
 Enable autorecovery attempts if a bad tree root is found at mount time.
-- 
2.27.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36884228094
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 15:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGUNIS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 09:08:18 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.80]:40348 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbgGUNIR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 09:08:17 -0400
X-Greylist: delayed 1282 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2020 09:08:17 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id E5EE18A67ED
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:46:53 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id xrfZjjz3bSxZVxrfZjR2yi; Tue, 21 Jul 2020 07:46:53 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N9551mAZDZ2SF5hMfSI/uv76zeIDuAUo4b0eRZyYXN8=; b=vw/M/XlB1zi/q0IaNId2biEd2Q
        qAz4gj30CL+DYp38pFAIju5ailPjNrInIJsZSOHvNq+X3oEtpvVuCHFgGMYcxbex/V+64f3q63pQv
        5s2r+hc72fBqGfwQ4VX8rQL8SR013Ls8dbz39Me4YwYPvOrurmIHZsxmAlJban6F0ZK4djvE97KNd
        nHSHtWhLXMNVEvLd7ICmhJRDxSqEMo5mjlp3a9r/95lDlmuPI30vC6+9vt5ca8itZmPoTnVcGGivI
        HiNOIikkjmFVQRzkfTcG6rsieOAa+NbNVMYMr/8MOIi4XXsdvkfYvRax1JI2I1jOkAVsJOmYIcUWP
        a8ocKEhQ==;
Received: from [186.212.89.200] (port=48508 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jxrfZ-001iDm-7r; Tue, 21 Jul 2020 09:46:53 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2] btrfs: 210: Ignore output from "quota rescan" after "quota enable"
Date:   Tue, 21 Jul 2020 09:46:30 -0300
Message-Id: <20200721124630.3112-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 186.212.89.200
X-Source-L: No
X-Exim-ID: 1jxrfZ-001iDm-7r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [186.212.89.200]:48508
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Command "quota enable" triggers a quota rescan, but it can finish quick
in some machines leading to the next command "quota rescan" to be able
to start scanning again, and then printing "quota rescan started" making
the test fail.

In some machines this don't happen because the first rescan initiated by
"quota enable" is still running when "quota rescan" is executed, returning
-EINPROGRESS from ioctl BTRFS_IOC_QUOTA_RESCAN_STATUS and not printing the
message.

Ignoring any output from "quota rescan" solves the issue in both cases, and
this is already being done by others tests as well.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Patch v1 can be found here:
 https://www.spinics.net/lists/linux-btrfs/msg103177.html

 tests/btrfs/210 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/210 b/tests/btrfs/210
index daa76a87..13d1a87b 100755
--- a/tests/btrfs/210
+++ b/tests/btrfs/210
@@ -46,7 +46,7 @@ _pwrite_byte 0xcd 0 16M "$SCRATCH_MNT/src/file" > /dev/null
 # by qgroup
 sync
 $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT"
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
 $BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
 
 # Create a snapshot with qgroup inherit
-- 
2.27.0


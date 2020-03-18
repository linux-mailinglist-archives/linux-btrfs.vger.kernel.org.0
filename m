Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A7318A3DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCRUkY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:40:24 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.196]:47027 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCRUkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:40:24 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id CA4B12E5C6
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:19:00 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9YjFOhpAGTXEf9YjfWvx; Wed, 18 Mar 2020 15:19:00 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZaxzvBDJkfibJLdkSzcz8GDD/BiBpFGh8TbALYTtL00=; b=t+TwnLtl5PfHCA/yV2DCewK9Lj
        WSFfvv5sr6PF9/OwR31+4G3PUzaqyGl2ItDsJEKB3abSXpqwt2voy8dbvR4xPICmeGxKrdNZdiKrE
        fo5ps/B+KKRD3UO+wbQKZbT/AbAAYgKbYCswiN32Jgs/8Pd14GN5dnRt1gsGL+vETDwxVaSMTdBcy
        sRaFeRR/t/HhY/Tf8OqucDYtSN4OVeO2d9HE0UHKPyl2bUBUvdmhZDwG3HJ4YQAGxR+MITM0d1MKU
        i8wzoQdnNivSSJOYE9A7W0Wv6pyqXguUKoNa28xcLBY2ATtqxRJEY6cYkaEBteUVuj98kByTqlyWO
        UgFfigDg==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9Y-000yAj-6S; Wed, 18 Mar 2020 17:19:00 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH v4 10/11] btrfs-progs: test/mkfs: Add test case for -Q|--quota option
Date:   Wed, 18 Mar 2020 17:21:47 -0300
Message-Id: <20200318202148.14828-11-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200318202148.14828-1-marcos@mpdesouza.com>
References: <20200318202148.14828-1-marcos@mpdesouza.com>
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
X-Exim-ID: 1jEf9Y-000yAj-6S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 35
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Only test if btrfs check (which will check qgroup by default) and kernel
mount success.

Comprehensive qgroup test cases still belongs to fstests.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/001-basic-profiles/test.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/mkfs-tests/001-basic-profiles/test.sh b/tests/mkfs-tests/001-basic-profiles/test.sh
index 4b6c2f42..c273f1df 100755
--- a/tests/mkfs-tests/001-basic-profiles/test.sh
+++ b/tests/mkfs-tests/001-basic-profiles/test.sh
@@ -47,6 +47,16 @@ test_mkfs_single  -d  dup     -m  single
 test_mkfs_single  -d  dup     -m  dup
 test_mkfs_single  -d  dup     -m  dup     --mixed
 
+test_mkfs_single -Q
+test_mkfs_single -Q -d  single  -m  single
+test_mkfs_single -Q -d  single  -m  single  --mixed
+test_mkfs_single -Q -d  single  -m  dup
+test_mkfs_single -Q -d  dup     -m  single
+test_mkfs_single -Q -d  dup     -m  dup
+test_mkfs_single -Q -d  dup     -m  dup     --mixed
+
+# Profile doesn't really affect quota, skip them to save some time
+
 test_mkfs_multi
 test_mkfs_multi   -d  single  -m  single
 test_mkfs_multi   -d  single  -m  single  --mixed
-- 
2.25.0


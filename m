Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3192B79DD01
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjIMAMv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjIMAMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:12:49 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7864F1706
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:12:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BF612320094A;
        Tue, 12 Sep 2023 20:12:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Sep 2023 20:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563964; x=
        1694650364; bh=IhZ+SP48gWe0D/xTDFXqJUAqlzAsp1JVpYkoerbXuIE=; b=S
        lG5JL1u1SCsxDK0qF2elDnZLFHQ+yoHeyJYgac8EwGgNTsk9xbdRUkaDv5hleVt3
        XtCPNJvsNGW4Wrd0mZyQckUvck5PrnJ552BWgHM2NmMcENhhdM844hMBjkFlWrmC
        c9cBxwiP7Hnj6BcJfDMlJvP/lZK5Xq9prslZr8sAcEe7MG4rcA6zFEFOehYzfQDD
        Oj4NKFxxUBz2lphzCUyKSr4MaLYwcD9diTcDWgOKPOl8uFzhGC6RduzHB6EOhIPY
        nBj+OT5QJFGw3IhpF89b7Up6q+PzF/PFW+VIpW1wgiwQb4EASMrby9fGncmZCfdC
        thLC0w0hinkop+hIEYPmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563964; x=1694650364; bh=I
        hZ+SP48gWe0D/xTDFXqJUAqlzAsp1JVpYkoerbXuIE=; b=LyFPw5v8Kg6F1U5BO
        ox4W+LK+gaOTTUc+5VKqAFcpfmmwxW1HLFqonomXvhNTtrU8vN/a0IDqlowqBqb9
        9V3nSpo2q2/h/e3dWOx6frgn9GssBoyhioXtwX7koLBZ2OtcsoaQy1tuxaQ7Zozv
        B5mbMRUA/C3CRJJVRlVeRx23TZ9xBdKXvQJEbrburWbfnKdciQbFI6OzTCvANhjV
        DNwOLcvh4e6BYxZJL9PMoy+ZSrH2+VSS1SrrtZJviBfMTMA+GLvv6MYeLuFUrGO2
        rQtggNF0zwvLM0k9bG1bc8+j5S5xrPAPdXuJezjrGBD1j3ZDgqiN2X4LZZULwpN4
        XKyXw==
X-ME-Sender: <xms:fP4AZcNTx4Ii5G5qM9wMbPkpiLMSgeJir5yE3KzoLniifEiTmKWFTg>
    <xme:fP4AZS_42V2iUAz8zoSeUFZfoVrY8UWIKrZCCRLlXZ9f97e2W0kXvi6CoSCMaY7Dj
    Iep2st_nbx2A2-0bgA>
X-ME-Received: <xmr:fP4AZTQ-fU9hFcqu6IMtd2jxfnqRtSeSXQnr5WeETy2PP9_Asn6z1BOXFZGmxA9xqx7UMmZfyuKIS-eXGNfqSlikgZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:fP4AZUugCRNjXBg0RIyefgX3WYa7SQ2yYagRpVmS6s7R1K2sSMhn4Q>
    <xmx:fP4AZUdmhMxneqE_GgaZcQzik4bsPPFgqZvc9lMRljJ-vHFBTl6hdw>
    <xmx:fP4AZY3ynWS941pCd6lsQkhNm-ZEMwfTeBQ1-KwBmcSKlWkTUVxrOg>
    <xmx:fP4AZcltmHq_txjhyjhFxwkK1fpSbnUkPWIMXc9DJpHFCD5dFYUalg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:12:43 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 01/18] btrfs: introduce quota mode
Date:   Tue, 12 Sep 2023 17:13:12 -0700
Message-ID: <e33cebde9cd60f95237e6e0805bc465ff16bce32.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation for introducing simple quotas, change from a binary
setting for quotas to an enum based mode. Initially, the possible modes
are disabled/full. Full quotas is normal btrfs qgroups.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 7 +++++++
 fs/btrfs/qgroup.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a51f1ceb867a..8f8318e0509b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -30,6 +30,13 @@
 #include "root-tree.h"
 #include "tree-checker.h"
 
+enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
+{
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+		return BTRFS_QGROUP_MODE_DISABLED;
+	return BTRFS_QGROUP_MODE_FULL;
+}
+
 /*
  * Helpers to access qgroup reservation
  *
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 12614bc1e70b..aed611774047 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -277,6 +277,12 @@ enum {
 };
 
 int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
+enum btrfs_qgroup_mode {
+	BTRFS_QGROUP_MODE_DISABLED,
+	BTRFS_QGROUP_MODE_FULL,
+};
+
+enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
-- 
2.41.0


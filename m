Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D67495CDC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 10:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379703AbiAUJdr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 04:33:47 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:52710 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379712AbiAUJdr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 04:33:47 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 27B0B1E0007D;
        Fri, 21 Jan 2022 11:33:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1642757625; bh=nUpQXG3cvROLjtWsMyLMGPz+QL0GPkpmzYny+OoRR9g=;
        h=From:To:Cc:Subject:Date:Message-Id:X-ESPOL:from:date:to:cc;
        b=WFcp7NbPYfS7TMI4PPQZvR4Hh4AiW01G+lzUCGx9Zk366MQ7sNRx/L44xu6XdcLyw
         I0q8BEY9AOrC1roKlBsUo0YnnWKo1S/BlXyF9UUYsXSJpK/Nst2zKeFuMgtsHO3u8h
         28R1TzZzExC5SgQOjsESLhVrI9x3+JBieZ/dYUso=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 1F2631E00076;
        Fri, 21 Jan 2022 11:33:45 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id gKVyUMJ2SQO9; Fri, 21 Jan 2022 11:33:45 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id D063B1E00051;
        Fri, 21 Jan 2022 11:33:44 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH 0/2] Simple two patches for tree checker
Date:   Fri, 21 Jan 2022 17:33:33 +0800
Message-Id: <20220121093335.1840306-1-l@damenly.su>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBlzQh1+nQ3rcDQU2qyxVL57ogYemsm5UnmeDUSOFfksTURS1g21yTGK6vjsX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Two commits for enhancing tree checker to reject the img from
https://bugzilla.kernel.org/show_bug.cgi?id=215299.

Su Yue (2):
  btrfs: tree-checker: check item_size for inode_item
  btrfs: tree-checker: check item_size for dev_item

 fs/btrfs/tree-checker.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.34.1


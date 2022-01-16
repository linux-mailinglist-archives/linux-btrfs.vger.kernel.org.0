Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5FC48FA5E
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 03:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiAPCtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 21:49:04 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:2543 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232795AbiAPCtD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 21:49:03 -0500
X-Sender-Id: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5D065621687
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 02:49:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a296.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 09DCA621BCB
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 02:49:02 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
Received: from pdx1-sub0-mail-a296.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.158.96 (trex/6.4.3);
        Sun, 16 Jan 2022 02:49:02 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
X-MailChannels-Auth-Id: dreamhost
X-Exultant-Exultant: 2a296ed56f816f97_1642301342250_4185047329
X-MC-Loop-Signature: 1642301342250:1160221939
X-MC-Ingress-Time: 1642301342250
Received: from meinmachine.hsd1.ca.comcast.net (c-73-92-232-183.hsd1.ca.comcast.net [73.92.232.183])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sahil.kang@asilaycomputing.com)
        by pdx1-sub0-mail-a296.dreamhost.com (Postfix) with ESMTPSA id 4Jbzy55VGnz1Pt
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 18:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=asilaycomputing.com;
        s=asilaycomputing.com; t=1642301341;
        bh=RFwTFGFcC6NtDk5fzdtWMnXsqZY=;
        h=From:To:Subject:Date:Content-Transfer-Encoding;
        b=N3K6WRbCvvoL4kVaP3w00tlgSpLklAibhq7cv/fJB/YbNtwjHlRu84o2t09Sb4TKD
         uA6wCKC4uDlNNSnJnJDRjUx3gQKAA8hIS0hKXAdX1XjD7mSVNAo80U0Su/ofKW6VQH
         rkdTjsBGjVFYAFVy4RxssMStaSu1IWkJ8w9XxsaA=
From:   Sahil Kang <sahil.kang@asilaycomputing.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/1] btrfs: reuse existing inode from btrfs_ioctl
Date:   Sat, 15 Jan 2022 18:48:46 -0800
Message-Id: <20220116024847.29047-1-sahil.kang@asilaycomputing.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220106150334.GD14046@twin.jikos.cz>
References: <20220106150334.GD14046@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a follow up to misc-next/152adfc to incorporate Qu's review.

Sahil Kang (1):
  btrfs: reuse existing inode from btrfs_ioctl

 fs/btrfs/ioctl.c | 43 ++++++++++++++++++-------------------------
 fs/btrfs/send.c  |  4 ++--
 fs/btrfs/send.h  |  2 +-
 3 files changed, 21 insertions(+), 28 deletions(-)

-- 
Sahil


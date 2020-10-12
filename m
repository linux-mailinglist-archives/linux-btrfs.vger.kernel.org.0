Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D71328C0D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 21:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391160AbgJLTGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 15:06:53 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.219]:31918 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390989AbgJLTEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 15:04:05 -0400
X-Greylist: delayed 1491 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 15:04:05 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 83AFD5581ED
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 13:39:10 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id S2j0kvxy4BD8bS2j0kwKu9; Mon, 12 Oct 2020 13:39:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AyOQCiEK6JvLpTjMnuQQuorSuP+b+4HAHFHt4S9ALRY=; b=IAf6Xvmkp11uKd1z8coqYj8dtw
        x4v7gfzy160MSIjLlmYTlUBzRH+MQOhGfSJBdU2dnZgqar51RGYVlc+LeNqC52BOsjKlZiKHksGuV
        +YneWOJACAGxBHd6ofOie4US5z3NDJd/4gWNYw1H2mZrUYbku0jyLd+TMc04YexZoV2RxvluN7CEA
        mwzTTJ9GYDgQ4jQiLN9Mmhj9uvp/kvSj9Z/ALh/wDKRsbmBlghLIlXcfXPZoZhKaQI9dKxq5hBgOO
        Ura5m1lkt5gJYpVjhJa6hHJbJSavsXrtOQDkBWT5KXjxPvwXvM3xsws6ZJ5QxL+EDgCFhNWsfZYwz
        RAIZPN6Q==;
Received: from [179.185.211.118] (port=60218 helo=localhost.localdomain)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kS2iz-000ePt-VY; Mon, 12 Oct 2020 15:39:10 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: docs: Clarify maximum block group size at mkfs time
Date:   Mon, 12 Oct 2020 15:38:44 -0300
Message-Id: <20201012183844.20593-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.211.118
X-Source-L: No
X-Exim-ID: 1kS2iz-000ePt-VY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [179.185.211.118]:60218
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

A block group size cannot be larger than 10% of the total filesystem
size.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/mkfs.btrfs.asciidoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mkfs.btrfs.asciidoc b/Documentation/mkfs.btrfs.asciidoc
index 630f575c..f2866523 100644
--- a/Documentation/mkfs.btrfs.asciidoc
+++ b/Documentation/mkfs.btrfs.asciidoc
@@ -284,6 +284,8 @@ sometimes the terms are used interchangeably
 A typical size of metadata block group is 256MiB (filesystem smaller than
 50GiB) and 1GiB (larger than 50GiB), for data it's 1GiB. The system block group
 size is a few megabytes.
++
+For smaller filesystems, the block group size is limited to 10% of the filesystem size.
 
 *RAID*::
 a block group profile type that utilizes RAID-like features on multiple
-- 
2.28.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB6A115F52
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 23:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLGW3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 17:29:47 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:48017 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbfLGW3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Dec 2019 17:29:47 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 47VkX86rGXz20Sn;
        Sat,  7 Dec 2019 23:24:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1575757464; bh=jjv5PWMEMhzehN6tk91BT8BdiXjv1QcYvcv4a7tLMFA=;
        h=From:To:Cc:Subject:Date:From:To:CC:Subject;
        b=JL+ddXq8isH0UD6LvRcPXZUccrF2Ho5ZAql8Np7gCiEmxmk3TiR7dJem8WvYMpj6r
         zBXz0k8XJh/BSs3VpSAEEHYffjWXjj1jt72/UYIrTGvGkdCEH+eZb2DyuqzuJ+Ab82
         bYAOxzup4b7cTgaUXlIxNvQRQHSJxZ8ms2x0yB1fAniLYRHUbSGQBMrChD5lE/OI8p
         FILCaW6UFJknzwgpVCKZu+O7EvL1Kff03Wi/R/R1Ki99QUDxbt29jvjN+kfa8rG5HG
         MjtlI+lsyo4e4yg0YezB5AND55ojUvMX1tBDTLfuZOHDkv8b2X9Zm8ciZhjEkacdOr
         3R1cdkzVuIYug==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.22.146
Received: from localhost.localdomain (firewall.henke.stw.uni-erlangen.de [131.188.22.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18TP1STQvZYNDvw/VaITTwdR2mXGI0dnpc=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 47VkX64K4Mz20L3;
        Sat,  7 Dec 2019 23:24:22 +0100 (CET)
From:   Sebastian <sebastian.scherbel@fau.de>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Sebastian Scherbel <sebastian.scherbel@fau.de>
Subject: [PATCH 0/2] btrfs: Move dereference behind null checks
Date:   Sat,  7 Dec 2019 23:18:16 +0100
Message-Id: <20191207221818.3641-1-sebastian.scherbel@fau.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sebastian Scherbel <sebastian.scherbel@fau.de>

Regarding Bug 205003, points 1 and 2
This patch series moves two dereferences after the null check to avoid
a possible null pointer dereference.

Sebastian Scherbel (2):
  btrfs: Move dereference behind null check in check integrity
  btrfs: Move dereference behind null check in check volumes

 fs/btrfs/check-integrity.c | 4 +++-
 fs/btrfs/volumes.c         | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.20.1


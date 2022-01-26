Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DCC49D37A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 21:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiAZUca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 15:32:30 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:59394 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230423AbiAZUca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 15:32:30 -0500
Received: from venice.bhome ([78.14.151.50])
        by michael.mail.tiscali.it with 
        id nYYU2600t15VSme01YYURk; Wed, 26 Jan 2022 20:32:29 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 0/2][V11] btrfs-progs: allocation_hint disk property
Date:   Wed, 26 Jan 2022 21:32:25 +0100
Message-Id: <cover.1643228730.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643229149; bh=H5Q5Bnry5Lln6e4Svc5VVovWpeC5FHB+D/sRnRvzVwM=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=yHZM0MT4eDOpDU2N5ILjI80Tw+AmOVdhLGC7UIcpDERITQnNFjLFr5GRjfc0kkwj5
         4JbT+TFxwSo3urQ7NPkKHTuAljn1Px8UHLEAH3tLJ5QjJuRCdl7Bm+gs7P0njgHDDO
         WCw2X9PyKDdh5BlfTpH0Ta2ALhDy9oSXaqfS9XvM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This patches set is the userspace portion of the serie
"[PATCH V11] btrfs: allocation_hint".

Look this patches set for further information.

Changelog
V11: 
- find the correct /sys/fs/btrfs/<UUID> directory using the
devinfo/major_minor sysfs file.
- update the man page to the .rst file format

G.Baroncelli

Goffredo Baroncelli (2):
  btrfs-progs: new "allocation_hint" property.
  Update man page for allocator_hint property.

 Documentation/btrfs-property.rst |  21 +++
 cmds/property.c                  | 253 +++++++++++++++++++++++++++++++
 kernel-shared/ctree.h            |  13 ++
 3 files changed, 287 insertions(+)

-- 
2.34.1


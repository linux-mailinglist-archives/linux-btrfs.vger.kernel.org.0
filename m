Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9C41F140
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhJAPbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 11:31:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36798 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355069AbhJAPa5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Oct 2021 11:30:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B2C5920063;
        Fri,  1 Oct 2021 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633102152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YUTOTNkkZ2Z6BABOfeBUFbGvzp5882kOJ8z1YeUupto=;
        b=unbWk3jcupzd6fU0jTrInhciN2udMD9Q88S0J6UzQtwo81kDu3hC8H6j4QHtApnY4BWZbE
        LPkDtXYrl4tKHEWbw9pQtUVG4uin0Aply2OLV3RHQJqvJ00b2BLgAJ/6LUdHwVRb7ZycUO
        UFf0cu9vingoPjloeoY5tHPttUn6U9E=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AC088A3B8A;
        Fri,  1 Oct 2021 15:29:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 321B9DA7F3; Fri,  1 Oct 2021 17:28:54 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Subvolume ro/rw and received_uuid
Date:   Fri,  1 Oct 2021 17:28:54 +0200
Message-Id: <cover.1633101904.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's implemented the userspace prevention of accidental ro->rw switch
of sent subvolumes. It's not finialized but the main idea is there so
here we go argue, as we haven't reached a consensus with Nikolay what is
the right usability approach.

There are two patches extending the printed information about root items
and subvolumes but they're only for convenience, that I also used for
debugging.

David Sterba (5):
  btrfs-progs: subvol show: print send and receive generation and
    timestamp
  btrfs-progs: dump-tree: print complete root_item
  btrfs-progs: props: add force parameter to set
  btrfs-progs: property: ro->rw and received_uuid
  btrfs-progs: tests: subvolume ro->rw switch and received_uuid

 cmds/property.c                               | 99 ++++++++++++++++---
 cmds/props.h                                  |  3 +-
 cmds/subvolume.c                              | 21 ++++
 kernel-shared/print-tree.c                    | 53 +++++-----
 .../050-receive-prop-ro-to-rw/test.sh         | 42 ++++++++
 5 files changed, 172 insertions(+), 46 deletions(-)
 create mode 100755 tests/misc-tests/050-receive-prop-ro-to-rw/test.sh

-- 
2.33.0


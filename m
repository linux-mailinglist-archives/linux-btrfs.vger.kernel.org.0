Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB04119B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhITQYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 12:24:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhITQYE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 12:24:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BD0D222028
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632154956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UCaiRYYxnfX4VotPrkbAXCujkx6FxUvZw+byoO73pH0=;
        b=WFQAig2T5zCNdR2AGFGMdSG7tN3M4D1OieEW7w/1kuHfQonVLQGqM6hEv1wsEcV1FQTCUx
        UjepooYvHO+6bSdr46DdyQlA4y2UIs/+hIdPtFUHtCgUZBc+6MQ/AS0YHzWax4nzu3Dy0A
        qmfXl/L7EeU+pW+4WDt4wCKYOpkw3ZU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B76CDA3B96
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 16:22:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E86ADA7FB; Mon, 20 Sep 2021 18:22:25 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.14.1
Date:   Mon, 20 Sep 2021 18:22:24 +0200
Message-Id: <20210920162224.27927-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.14.1 have been released. This is a bugfix release.

Changelog:

* fixes:
  * defrag: fix parsing of compression (option -c)
  * add workaround for old kernels when reading zone sizes
  * let only check and restore open the fs with transid failures, namely
    preventing btrfstune to do so
  * convert: --uuid copy does not fail on duplicate uuids

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (6):
      btrfs-progs: fix defrag -c option parsing
      btrfs-progs: handle EINVAL when reading zone size on older kernels
      btrfs-progs: tests: test options for defrag -c
      btrfs-progs: convert: allow to set a duplicate uuid
      btrfs-progs: update CHANGES for 5.14.1
      Btrfs progs v5.14.1

Qu Wenruo (2):
      btrfs-progs: introduce OPEN_CTREE_ALLOW_TRANSID_MISMATCH flag
      btrfs-progs: tests: test case to make sure btrfstune rejects corrupted fs

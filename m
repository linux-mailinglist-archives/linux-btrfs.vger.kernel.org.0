Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427DC79F0D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 20:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjIMSE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSEz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 14:04:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1B019AE
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 11:04:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4F7251F383
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694628290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vklxo71o5FhKnvJOs7l0Qv/W8zUrbEnbrJk74CgEuJo=;
        b=Onodq2dxfn531xPo7WWr/SE5LNikQlF04cl77DCivZs/zquC7qTz5+1NwnPPzEM6zaJpHQ
        ZQk7y7WDtXP1hmmrtim+qBFPBaQiURHcfpxLBfVqXLSK0Xa2ah0+n4isU0s6xIIQ8uc1Nr
        hp9UUq753JK2ZjkXyI4CR0Ed8p3QxSs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3CF542C142
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 18:04:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C6A2DA8A7; Wed, 13 Sep 2023 20:04:48 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.5.1
Date:   Wed, 13 Sep 2023 20:04:47 +0200
Message-ID: <20230913180448.9431-1-dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.5.1 have been released. This is a bugfix release.

The accelerated crc32c implementation in 6.5 did not work on older compilers
or 32bit CPUs without PCLMUL supoort, now fixed.

Changelog:
   * build fixes:
      * crc32c if PIE or relro is enabled
      * detect if PCLMUL feature is recognized by compiler and also detect that
        at runtime
   * check: verify metadata item level when skinny-metadata is enabled
   * other: minor build and docs updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.3.3

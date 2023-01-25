Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7763C67BA05
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjAYS7g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 13:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjAYS7f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 13:59:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3DF3F2BB
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 10:59:30 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4C2861FF1D
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674673169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/khBjUIYoiPTb8fLBcalX/ogXM+DBJwqbskUbN26DCQ=;
        b=WQ+QlY7HPSZcFa3r3G53dBbV507C+KIo5jr7+NG6Y3QvdDE5Iq83mvkDQvgL+JYXyGH/U0
        eX3qpuHEnIWY1g57b15d6+OiF35G0FXxeYtWchjqbuLVA8vJU5ZAyO8CG27kXv+NFsG+rQ
        moFB65mmGS7ELgRT4CdLcR1c7YyP8ys=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 44D042C141
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 18:59:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 390BFDA7CF; Wed, 25 Jan 2023 19:53:48 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.1.3
Date:   Wed, 25 Jan 2023 19:53:47 +0100
Message-Id: <20230125185348.32583-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.1.3 have been released. This is a bugfix release.

Changelog:

   * fi mkswapfile: fix setting size
   * mkfs: check zoned support of libblkid
   * check: improve error messages for mismatched references
   * other:
      * pass CFLAGS to static build
      * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Alexey (1):
      btrfs-progs: build: static should pick up EXTRA_LDFLAGS and SUBST_LDFLAGS

Christopher Head (4):
      btrfs-progs: docs: add up-to-date definition of btrfs_ioctl_vol_args_v2
      btrfs-progs: docs: add struct btrfs_ioctl_get_subvol_info_args
      btrfs-progs: docs: add missing ioctl names to the list
      btrfs-progs: docs: document some subvolume related ioctls

Christopher Yeleighton (1):
      btrfs-progs: docs: describe formatting of sizes

David Sterba (4):
      btrfs-progs: fi mkswapfile: fix page count in header
      btrfs-progs: docs: drop copyright year from manual pages
      btrfs-progs: update CHANGES for 6.1.3
      Btrfs progs v6.1.3

Naohiro Aota (4):
      btrfs-progs: mkfs: check blkid version on zoned filesystems
      btrfs-progs: docs: add sysfs per-space_info bg_reclaim_threshold entry
      btrfs-progs: docs: fix sysfs nodesize typo
      btrfs-progs: docs: add sysfs chunk_size description

Qu Wenruo (2):
      btrfs-progs: docs: add sysfs doc
      btrfs-progs: check: enhance the error output for backref mismatch

pinysuse (1):
      btrfs-progs: docs: add heading to ch-mount-options.rst

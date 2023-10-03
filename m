Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976007B706B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 19:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbjJCR6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 13:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjJCR6A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 13:58:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22113AC
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 10:57:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0ADAF1F8A4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696355873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WIqZ4p/M0iu5F3W4XLH+4AIIA7uPK6KP2bI+TxH3g0M=;
        b=PdsRI33cMsBwcivSDfna7i0Tjv0I0Ql2qAdQtk99m0JLY6bt62TSM5sc6W/6IVi4iq5evQ
        dzK29c/IyuQpTDtRyJChmoPvNWq/YKT08r1tbfaUfLWoDf1gvyHURK/ueVz1172AISOMCx
        fZb3lrvAPqGF/nq4c051WzvzHUJgFzs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DBB972C142
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 17:57:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4428CDA893; Tue,  3 Oct 2023 19:51:12 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.5.2
Date:   Tue,  3 Oct 2023 19:51:10 +0200
Message-ID: <20231003175112.9571-1-dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.5.2 have been released. This is a sync release for
upcoming kernel features for 6.7, no important fixes are present and update is
not required.

Changelog:

* new feature support:
  * raid-stripe-tree, new tree to track extent mapping for raid profiles,
    allows raid1*, raid0 and raid10 on zoned devices (kernel 6.7)
  * simple quotas, simplified accounting that does not track exclusive and
    shared extents (kernel 6.7)
  * mkfs with duplicate UUID on a single device, temp-fsid (kernel 6.7)
* metadata_uuid: enhanced capabilities to repair partially updated fsid on
  multiple devices
* other:
   * updated tests and CI
   * sync sources with kernel

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.5.2

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24797E1756
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Nov 2023 23:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjKEW1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Nov 2023 17:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEW1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Nov 2023 17:27:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C69CF
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Nov 2023 14:27:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 75B0C2183F
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Nov 2023 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699223266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cOo7O8epHrHW2d4aYt/oYb+GQjfJD3gIwks6Byb9jVs=;
        b=VUar59u3bqdk6IbwWAOkoOwq+cb8rLoRCaSmD6FOCcrGiohG2BULJu4aotUTWhJc28kSmQ
        yc6dqEeC+eN2egj2vGA+ykNO0u1wzAn47jvtMyN1mgIpJrP5H1wRpfmKk89dkjcGGaufXg
        tpbYaMCRJpRnQttsGerJ2Qp1UJcOpM0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 382D02D35C
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Nov 2023 22:27:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BD67BDA85D; Sun,  5 Nov 2023 23:20:46 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.6.1
Date:   Sun,  5 Nov 2023 23:20:44 +0100
Message-ID: <20231105222046.19483-1-dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.6.1 have been released. This is an important bugfix release,
v6.6 is broken and should not be used.

Due to an accidental change in definition of the scanning ioctl in a
"documentation only" patch the mkfs or 'device scan' command were not able to
register all devices and mounting multi-device filesystems failed.
I misdiagnosed that as a change in the CI environment, thanks all early
packagers and testers for reports and the fix.

Changelog:

* fix device scanning ioctl definition, accidental change to the 'forget' ioctl
  that breaks mounting multi-device filesystems

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.6.1

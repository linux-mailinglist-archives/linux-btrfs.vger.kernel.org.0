Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE74CED28
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiCFSRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 13:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiCFSRI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 13:17:08 -0500
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45E4765D36
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 10:16:16 -0800 (PST)
Received: from venice.bhome ([78.12.27.75])
        by michael.mail.tiscali.it with 
        id 36FE270011dDdji016FEbN; Sun, 06 Mar 2022 18:15:14 +0000
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
Subject: [PATCH 0/2][V12] btrfs-progs: allocation_hint disk property
Date:   Sun,  6 Mar 2022 19:15:10 +0100
Message-Id: <cover.1646590206.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.35.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1646590514; bh=NbmQd56zjKG9v6nocAr0lPRlfzrUFmOYvH+DaiEL2u4=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=PTQHluA8a/Cd2WzNjB4Qd51wmzeDotgztag9rENjf1tAhueadW9v29gc0SVgLyW4j
         WfJIeK+fuBKS/4Ib7xLkWEvkHi8D6JZOdE3VVqLGJfNgeuG5NqxUwpE7tw7HlM7JVC
         xeNR3jzugAhXRDIAwx653KyWotW20rJUuWb9+4q0=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This patches set is the userspace portion of the serie
"[PATCH V12] btrfs: allocation_hint".

Look this patches set for further information.

Changelog:
V12:
- removed support for major_minor: now even to query the allocation_hint
property requires root privileges.
V11:
- find the correct /sys/fs/btrfs/<UUID> directory using the
devinfo/major_minor sysfs file.
- update the man page to the .rst file format

G.Baroncelli

Goffredo Baroncelli (2):
  btrfs-progs: new "allocation_hint" property.
  Update man page for allocator_hint property.

 Documentation/btrfs-property.rst |  21 ++++
 cmds/property.c                  | 162 +++++++++++++++++++++++++++++++
 kernel-shared/ctree.h            |  13 +++
 3 files changed, 196 insertions(+)

-- 
2.35.1


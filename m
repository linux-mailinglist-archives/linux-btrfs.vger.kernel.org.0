Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240DA47946D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbhLQSzf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:55:35 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:54236 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234215AbhLQSze (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:55:34 -0500
Received: from venice.bhome ([78.12.25.242])
        by santino.mail.tiscali.it with 
        id XWnC2600L5DQHji01WnCbj; Fri, 17 Dec 2021 18:47:13 +0000
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
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 0/2][V9] btrfs-progs: allocation_hint disk property
Date:   Fri, 17 Dec 2021 19:47:03 +0100
Message-Id: <cover.1639766708.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1639766833; bh=VNbkY51kyJK7xuoMWHEOnUeeFJrtFvcHbZkRvH1X3qE=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=QMhmQtkX/SQRWLmeH/gkyjc/a393sFoCyT+x33QlSi1GIEsowa5JXO9uiYVsetjys
         LQiSzAm0HmlzA9t4bU5WGWio/PK7CBrd7/AG8XyhoiPsHqCtJMqWO4B3UxhsdYzOcH
         vJIqIuoaEq0NKCIUP9aWQ40G2ayqyM5deEk3aEbQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This patches set is the userspace portion of the serie
"[PATCH V9] btrfs: allocation_hint mode".

Look this patches set for further information.

G.Baroncelli

Goffredo Baroncelli (2):
  btrfs-progs: new "allocation_hint" property.
  Update man page for allocator_hint property.

 Documentation/btrfs-property.asciidoc |  17 +++
 cmds/property.c                       | 204 ++++++++++++++++++++++++++
 kernel-shared/ctree.h                 |  13 ++
 3 files changed, 234 insertions(+)

-- 
2.34.1


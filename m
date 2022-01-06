Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1324748691F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbiAFRtW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 12:49:22 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:56242 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242387AbiAFRtR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 12:49:17 -0500
Received: from venice.bhome ([84.220.25.125])
        by santino.mail.tiscali.it with 
        id fVpB260072hwt0401VpBGo; Thu, 06 Jan 2022 17:49:13 +0000
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
Subject: [PATCH 0/2][V10] btrfs-progs: allocation_hint disk property
Date:   Thu,  6 Jan 2022 18:49:01 +0100
Message-Id: <cover.1641491043.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1641491353; bh=tDbjk1izZD4y9ZJf52L5xrb/wkV1zz3RYZPaDIQf2PI=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=gFPBO1n/FO4iccbgYqXT8eW1tfr0bX8kTC3mC2243SsFWs2v41Th2h5hKd4ReAepk
         DREy3TIDg7hNOWNkG3J5UdLJNsK52xDfla4BmYteKIsWOZmfWiCHLF6qOA37IpnqjO
         70RZc2v783RM9yMxiEpT7PSApabACsDmgk9l+/w4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This patches set is the userspace portion of the serie
"[PATCH V10] btrfs: allocation_hint mode".

Look this patches set for further information.

G.Baroncelli

Goffredo Baroncelli (2):
  btrfs-progs: new "allocation_hint" property.
  Update man page for allocator_hint property.

 Documentation/btrfs-property.asciidoc |  17 +++
 cmds/property.c                       | 202 ++++++++++++++++++++++++++
 kernel-shared/ctree.h                 |  13 ++
 3 files changed, 232 insertions(+)

-- 
2.34.1


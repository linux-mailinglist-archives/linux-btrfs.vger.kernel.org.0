Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BDE441AE6
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Nov 2021 12:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhKAL4B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 07:56:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50938 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhKAL4A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Nov 2021 07:56:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA844212C6;
        Mon,  1 Nov 2021 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635767606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tohKn+HM7s9OTIeo5JAYulLUMe3XT2kKtNAsq+dyyAo=;
        b=AEXEriGkxSWTmsJhyLcwggXGbjQUQW/pF1OvjM/Fag/KyXNUIFtha0hLhR64HdDigSbtY4
        ocbM04Dm3cUWYithAaeOdmVywaFWS49fqLA1pRvIT0mxQUCfIZ25GCVc5pNYPDqXocrdWD
        PSoD+RPK7/QN4BB7bvVG0Z+PrHvw9Tg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93C23133FE;
        Mon,  1 Nov 2021 11:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id icYBITbVf2HabQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 01 Nov 2021 11:53:26 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Balance vs device add fixes
Date:   Mon,  1 Nov 2021 13:53:21 +0200
Message-Id: <20211101115324.374076-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series enables adding of a device when balance is paused (i.e an fs is mounted
with skip_balance options). This is needed to give users a chance to gracefully
handle an ENOSPC situation in the face of running balance. To achieve this introduce
a new exclop - BALANCE_PAUSED which is made compatible with device add. More
details in each patche.

I've tested this with an fstests which I will be posting in a bit.

Nikolay Borisov (3):
  btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED exclusive state
  btrfs: make device add compatible with paused balance in
    btrfs_exclop_start_try_lock
  btrfs: allow device add if balance is paused

 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/ioctl.c   | 49 +++++++++++++++++++++++++++++++++++++++-------
 fs/btrfs/volumes.c | 23 ++++++++++++++++++----
 fs/btrfs/volumes.h |  2 +-
 4 files changed, 63 insertions(+), 12 deletions(-)

--
2.25.1


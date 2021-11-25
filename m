Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD7345D6F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 10:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351380AbhKYJTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 04:19:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42460 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345335AbhKYJR6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 04:17:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C02792113D;
        Thu, 25 Nov 2021 09:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637831686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IAaWzIihF8NDSE5aAWUGDJWKK89IWJhNrEyseuZUXvk=;
        b=W5D7fCMS4xld/R4Gcl1Gjf1CeZElaUwcuXdsgQrLqGzoYJjbjFqjLAHp5ilkygu/+zkiPR
        l5Ie3yXFFMzbKmMd+CVSrNbfq2/JcWoRH1S3+wSuD9AGQXfzRWVSL/zbovmFhUKwnqeqj9
        TLSv2Z3wyqtOmS/bxVfuhWPO1Dd3S/Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86A0713F62;
        Thu, 25 Nov 2021 09:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MblGHgZUn2EOHAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 09:14:46 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 0/3] Support adding a device during paused balance
Date:   Thu, 25 Nov 2021 11:14:40 +0200
Message-Id: <20211125091443.762092-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


So here's v3 which takes care of the feedback received in the last round, namely:

 - Introduced btrfs_exclop_balance which is used to switch the balance state,
 alongside ASSERTS
 - Removed unused variable in balance_kthread

Nikolay Borisov (3):
  btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED exclusive state
  btrfs: make device add compatible with paused balance in
    btrfs_exclop_start_try_lock
  btrfs: allow device add if balance is paused

 fs/btrfs/ctree.h   |  4 ++++
 fs/btrfs/ioctl.c   | 49 ++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.c | 10 ++++++++--
 3 files changed, 57 insertions(+), 6 deletions(-)

--
2.25.1


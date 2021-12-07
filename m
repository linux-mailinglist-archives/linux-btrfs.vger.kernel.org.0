Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8484246B43B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 08:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhLGHru (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 02:47:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55460 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhLGHrt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 02:47:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05C1A21B3E
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638863059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vKGT/JTMR9nfANgC3RhHAHumOudxLtUcEAIaItDDZM8=;
        b=as8vDFmgI9H7Qx0+ZXVxL1Drb9zbTu0ZH4Hwo3V+LRdrLpSLosxSxjG8NXRTipVu/knPj0
        Zf82vdsrMDyGS0KWiyPnA87i19tHNSn51gYIuGQHd+N5MfWvtaEECsv2lZI+jtbMXRi7BP
        7bZyQKr6rAFVosCNpDZoS2a/ndZ8cJU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EDA81332F
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 07:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xMoNBdIQr2FRHwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Dec 2021 07:44:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
Date:   Tue,  7 Dec 2021 15:43:58 +0800
Message-Id: <20211207074400.63352-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is originally just my preparation for scrub refactors, but when the
readahead is involved, it won't just be a small cleanup.

The metadata readahead code is introduced in 2011 (surprisingly, the
commit message even contains changelog), but now only one user for it,
and even for the only one user, the readahead mechanism can't provide
much help in fact.

Scrub needs readahead for commit root, but the existing one can only do
current root readahead.

And the code is at a very bad layer inside btrfs, all metadata are at
btrfs logical address space, but the readahead is kinda working at
device layer (to manage the in-flight readahead).

Personally speaking, I don't think such "optimization" is really even
needed, since we have better way like setting IO priority.

I really prefer to let the professional block layer guys do whatever
they are good at (and in fact, those block layer guys rock!).
Immature optimization is the cause of bugs, and it has already caused
several bugs recently.

Nowadays we have btrfs_path::reada to do the readahead, I doubt if we
really need such facility.

So here I purpose to completely remove the old and under utilized
metadata readahead system.

Qu Wenruo (2):
  btrfs: remove the unnecessary path parameter for scrub_raid56_parity()
  btrfs: remove reada mechanism

 fs/btrfs/Makefile      |    2 +-
 fs/btrfs/ctree.h       |   25 -
 fs/btrfs/dev-replace.c |    5 -
 fs/btrfs/disk-io.c     |   20 +-
 fs/btrfs/extent_io.c   |    3 -
 fs/btrfs/reada.c       | 1086 ----------------------------------------
 fs/btrfs/scrub.c       |   64 +--
 fs/btrfs/super.c       |    1 -
 fs/btrfs/volumes.c     |    7 -
 fs/btrfs/volumes.h     |    7 -
 10 files changed, 17 insertions(+), 1203 deletions(-)
 delete mode 100644 fs/btrfs/reada.c

-- 
2.34.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01741D05D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 02:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347499AbhI3ACp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 20:02:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55204 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346417AbhI3ACn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 20:02:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BD69203A1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 00:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632960061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5KTNGDzKxJ6bmHWrBKKuvxXWvIc9vwqHBnu3b1unv1g=;
        b=ZaY1jk3QRGzeK7kL/U4w08KiOLA/9xt8nFsujgpFFTb1gXVJFicg2Zkq4zqbL17caBB0SU
        FIhJkPlno/MipXBAiBqIvGBZJk1g8rniDRvCDM7K/YdI9WG2uRFM0iHXnf32+4lToldmNn
        xghAuXIve37DATJ8LVguu+mS6LTxlFU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B8E9140AF
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 00:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GIo0DDz+VGESaQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 00:01:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: receive: introduce new --clone-fallback option
Date:   Thu, 30 Sep 2021 08:00:40 +0800
Message-Id: <20210930000042.10147-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When parent stream and incremental stream are received with different
nodatasum mount options, any clone opeartion in the incremental stream
will be rejected by kernel.

There are more situations to cause clone failure, like receiving a stream
on a fs with different sectorsize.

Thus this patchset will introduce a new option, --clone-fallback, for
btrfs receive to fall back to buffered write when clone failed.

This fall back behavior will only happen if the new option is explicitly
specified, as such behavior can hide some send bugs, and under most sane
cases users don't need such option.

Also add a test case for the new option.

Changelog:
RFC->v1:
- Introduce a new option for the fallback behavior
  To avoid hide send bugs.

- Hide the warning message behind -v option
  Since we have a special option for it thus users are aware of what
  they are doing, there is no need to output such warning by default.

- Add a new test case for it

Qu Wenruo (2):
  btrfs-progs: receive: fallback to buffered copy if clone failed
  btrfs-progs: misc-tests: add test case for receive --clone-fallback

 Documentation/btrfs-receive.asciidoc          | 13 ++++
 cmds/receive.c                                | 60 ++++++++++++++++++-
 .../049-receive-clone-fallback/test.sh        | 60 +++++++++++++++++++
 3 files changed, 130 insertions(+), 3 deletions(-)
 create mode 100755 tests/misc-tests/049-receive-clone-fallback/test.sh

-- 
2.33.0


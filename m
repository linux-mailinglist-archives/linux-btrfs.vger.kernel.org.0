Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9DF49F447
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 08:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbiA1HVl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 02:21:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60564 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiA1HVl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 02:21:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 41E2721709
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643354500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rrbZaUHMz4UxEiM3xD1i+EY382xmMuYePPznBPnFOmY=;
        b=sW5WMBtC14+E3sWnFNz6FWtj8dWZ9KVqolDw/LojBP7ekg1vbXkL9+VTAExEM7G1eoICVC
        2s/qUuSpm5jakxQdgGjiLgw8vFqJEaRHtIXYPXtc1FgFvgFS4HW0nKBY06yB9bnIijJHJe
        p/yusS/wnFIS8/79sm17WC/VOww1OuA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71568139C4
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 07:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bv6QEIOZ82HHQQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 07:21:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/3] btrfs: fixes for defrag_check_next_extent()
Date:   Fri, 28 Jan 2022 15:21:19 +0800
Message-Id: <cover.1643354254.git.wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

That function is reused between older kernels (v5.15) and the refactored
defrag code (v5.16+).

However that function has one long existing bugs affecting defrag to
handle preallocated range.

And it can not handle compressed extent well neither.

Finally there is an ambiguous check which doesn't make much sense by
itself, and can be related by enhanced extent capacity check.

This series will fix all the 3 problem mentioned above.

Changelog:
v2:
- Use @extent_thresh from caller to replace the harded coded threshold
  Now caller has full control over the extent threshold value.

- Remove the old ambiguous check based on physical address
  The original check is too specific, only reject extents which are
  physically adjacent, AND too large.
  Since we have correct size check now, and the physically adjacent check
  is not always a win.
  So remove the old check completely.

v3:
- Split the @extent_thresh and physicall adjacent check into other
  patches

- Simplify the comment 

v4:
- Fix the @em usage which should be @next.
  As it will fail the submitted test case.

Qu Wenruo (3):
  btrfs: defrag: don't try to merge regular extents with preallocated
    extents
  btrfs: defrag: don't defrag extents which is already at its max
    capacity
  btrfs: defrag: remove an ambiguous condition for rejection

 fs/btrfs/ioctl.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

-- 
2.34.1


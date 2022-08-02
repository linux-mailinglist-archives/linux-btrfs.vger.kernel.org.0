Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C53A58786B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiHBHxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiHBHxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 03:53:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C012C71
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 00:53:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ADF66203E4
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659426780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=d5hGwGdv6EQVlmKvyrWyqMWEmPPglKhB/QTrCE9UyR8=;
        b=W0QLnwOUaikIhwl0XA3OdOH1x7VDWF3fE1j/BvFUFzlf0blD6eG99xV3G5OcDzCM0WPfGa
        F27v+9VIFr4pr5lh1xEhMsAl9goAUdslzm0zjVxxKOPPOPIX25ctDVzF5tU2CEesDLgUxs
        VqbBPz575Kx0jFkVQ5DU8ivxo1D7s6c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21CB313A8E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 07:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vhT2ONvX6GKlOgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Aug 2022 07:52:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs-progs: avoid repeated data write for metadata and a small cleanup
Date:   Tue,  2 Aug 2022 15:52:40 +0800
Message-Id: <cover.1659426744.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
v2:
- Separate the fixes from the initial patch
- Fix a bug in BUG_ON() condition which causes mkfs test failure

There is a bug report from Shinichiro that for zoned device mkfs -m DUP
(using RST) doesn't work.

It turns out to be a bug in commit 2a93728391a1 ("btrfs-progs: use
write_data_to_disk() to replace write_extent_to_disk()"), which I
wrongly assumed that write_data_to_disk() will only write the data to
one mirror.

In fact, write_data_to_disk() writes data to all mirrors, thus the
@mirror argument is completely unnecessary.

The first patch will fix the problem and cleanup the unnecessary
argument to avoid confusion.

Then the 2nd patch will fix a BUG_ON() condition.

Finally the last patch will cleanup write_and_map_eb() to completely
rely on write_data_to_disk(), without manually handling RAID56. 


Qu Wenruo (3):
  btrfs-progs: avoid repeated data write for metadata
  btrfs-progs: fix a BUG_ON() condition for write_data_to_disk()
  btrfs-progs: use write_data_to_disk() to handle RAID56 in
    write_and_map_eb()

 image/main.c              |  2 +-
 kernel-shared/disk-io.c   | 39 +++------------------------------------
 kernel-shared/extent_io.c | 12 +++++++++---
 kernel-shared/extent_io.h |  2 +-
 4 files changed, 14 insertions(+), 41 deletions(-)

-- 
2.37.0


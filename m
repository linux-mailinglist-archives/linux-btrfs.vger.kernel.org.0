Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8F67F63C
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jan 2023 09:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjA1IXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Jan 2023 03:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjA1IXh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Jan 2023 03:23:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CD21D905
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 00:23:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EBDA1FEF8
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674894214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6sTIz7PhnPnGoyJAThxnULmV/eNrgxxMoUwMR0bwnbY=;
        b=pCi5GGUfsEaf7aN4721ncK6WexAXZeTNyhdTIea4Qd6czIE4MqQ4NwumlNg4Si3kEQbpvz
        kwDWgFBk4WcJeYLRDwXBdna5apCdRK0+8wTOXsGBCZ6v+8FWyjBxNapuWykV8/1TyxIlSw
        RpXK6hH4q5MNR2U/5NAHGJrDI46r1pE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0865139BD
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HR19IoXb1GPqGwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: reduce the memory usage for replace in btrfs_io_context.
Date:   Sat, 28 Jan 2023 16:23:13 +0800
Message-Id: <cover.1674893735.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_io_context, we have two members dedicated for dev-replace:

- num_tgtdevs
  This is straight-forward, just the number of extra stripes for replace
  usage.

- tgtdev_map[]
  This is a little complex, it represents the mapping between the
  original stripes and dev-replace stripes.

  This is mostly for RAID56, as only in RAID56 the stripes contain
  different contents, thus it's important to know the mapping.

  It goes like this:

    num_stripes = 4 (3 + 1 for replace)
    stripes[0]:		dev = devid 1, physical = X
    stripes[1]:		dev = devid 2, physical = Y
    stripes[2]:		dev = devid 3, physical = Z
    stripes[3]:		dev = devid 0, physical = Y

    num_tgtdevs = 1
    tgtdev_map[0] = 0	<- Means stripes[0] is not involved in replace.
    tgtdev_map[1] = 3	<- Means stripes[1] is involved in replace,
			   and it's duplicated to stripes[3].
    tgtdev_map[2] = 0	<- Means stripes[2] is not involved in replace.

  Thus most space is wasted, and the more devices in the array, the more
  space wasted.


For the current tgtdev_map[] design, it's wasting quite some space.
E.g. in the above case, we only need on slot to record the source stripe
number, and the other two slots are just a waste of space.

The existing tgtdev_map[] will make more sense if we support multiple
running dev-replaces, but that's not the case.

So this patch would mostly change it to a new, and more space efficient
way, by going something like this for the same example:

  replace_nr_stripes = 1
  tgtdev_map[0] = 1	<- Means stripes[1] is involved in replace.
  tgtdev_map[1] = -1	<- Means the second slot is not used.
		 	   (Only DUP can use this slot, but they
			    don't really care)

Furthermore we reduce the width of nr_stripes related member to u16, the
same as on-disk format width.

This not only saved some space for btrfs_io_context structure, but also
allows the following cleanups:

- Streamline handle_ops_on_dev_replace()
  We go a common path for both WRITE and GET_READ_MIRRORS, and only
  for DUP and GET_READ_MIRRORS, we shrink the bioc to keep the same
  old behavior.

- Remove some unnecessary variables

Although the series still increases the number of lines, the net
increase mostly comes from comments, in fact around 70 lines of comments
are added around the replace related members.


Qu Wenruo (3):
  btrfs: simplify the @bioc argument for handle_ops_on_dev_replace()
  btrfs: small improvement for btrfs_io_context structure
  btrfs: use a more space efficient way to represent the source of
    duplicated stripes

 fs/btrfs/raid56.c  |  44 +++++++++--
 fs/btrfs/scrub.c   |   4 +-
 fs/btrfs/volumes.c | 187 +++++++++++++++++++++------------------------
 fs/btrfs/volumes.h |  52 +++++++++++--
 4 files changed, 174 insertions(+), 113 deletions(-)

-- 
2.39.1


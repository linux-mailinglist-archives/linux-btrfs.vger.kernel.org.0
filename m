Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4AB4AD1A0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 07:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbiBHGgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 01:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiBHGgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 01:36:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CA5C0401EF
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 22:36:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DB221F37C
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 06:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644302196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=SsYRbs8SvnN6+JsQbd2Etk7if8Z0ujsYBAajCzyZh2I=;
        b=YrumIE/MrPOVsp/QUx+vynw/9LeldfCLqi4nEoBThHYC+0kfSrTmYV8wmAj3Wtq06dRQeR
        rUvLk23i4s7xNaHoKbyknVih1LMSh1NEghlg08+o31OG+2N8PwrGaa/5BmedkPS2lnfgmz
        dcOh8e+G8dR/VMZMs2XaqK0kvbewqwU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86B7C13310
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 06:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HB75E3MPAmIlFQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Feb 2022 06:36:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: defrag: bring back the old file extent search behavior and address merged extent map generation problem
Date:   Tue,  8 Feb 2022 14:36:29 +0800
Message-Id: <cover.1644301903.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe reported that the old defrag code using btrfs_search_forward() to
do the following optimization:

- Don't cache extent maps
  To save memory in the long run

- Skip entire file ranges which doesn't meet generation requirement

- Don't use merged extent maps which will have unreliable geneartion

The first patch will bring back the old behavior, along with the old
optimizations.

However the 3rd problem is not that easy to solve, as data
read/readahead can also load extent maps into the cache, and causing
extent maps being merged.

Such already cached and merged extent maps will still confuse autodefrag,
as if we found cached extent maps, we will not try to read them from
disk again.

So to completely prevent merged extent maps tricking autodefrag, here
comes the 2nd patch, to mark merged extent maps for defrag.

If we hit an merged extent, and its generation meets our requirement, we
will not trust it but read from disk to get a reliable generation.

This should reduce defrag IO caused by the hidden extent map merging
behavior.

Changelog:
v2:
- Make defrag_get_em() to be more flexiable to handle file extent
  iteartion
  Now it will not reject item key which is smaller than our target but
  doesn't have the wanted type/objectid.
  It will continue go next next instead, to prevent skipping an extent.

- Properly reduce path.slots[0]
  There is a bug where I want to put "if (path.slots[0] == 0)" but I put
  "if (btrfs_header_nritems(path.slots[0]))".
  This is fixed with reworked file extent iteration code.

- Address merged extent maps properly
  With fixed defrag_get_extent(), we can rely on it to get original em
  from disk.
  So what we need to do is just to ignore merged extents which meets
  our generation requirement.

Qu Wenruo (2):
  btrfs: defrag: bring back the old file extent search behavior
  btrfs: defrag: don't use merged extent map for their generation check

 fs/btrfs/extent_map.c |   2 +
 fs/btrfs/extent_map.h |   8 +++
 fs/btrfs/ioctl.c      | 164 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 170 insertions(+), 4 deletions(-)

-- 
2.35.0


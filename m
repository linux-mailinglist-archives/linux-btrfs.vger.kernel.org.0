Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9EB49D9FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 06:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiA0FZC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 00:25:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48122 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiA0FZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 00:25:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 425371F37C
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 05:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643261101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ocEO/xPQKu/uLK7JU3Q26MJ2NtFDU9DGaljJF54nu9A=;
        b=VQ+J/Nt4z4IkftWQe9okYicbz3WKuCX8SyTC6R4sIJ0W/aTqjNGA4MhN4VUWjY3KQwkfMo
        i6ayUkPnb9PtUFitQEEkwoU0geikjxG4EZJJE1Q5eHX/Jwfw8SqeiYbcyomjpSGPLk63Gk
        7Vi0kRJEONxMuIAsDo5IdrXwpgEDcj8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 990FC13F58
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 05:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gx3nGKws8mFOXgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 05:25:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: defrag: don't defrag extents already at their max capacity, then remove an ambiguous check
Date:   Thu, 27 Jan 2022 13:24:41 +0800
Message-Id: <cover.1643260816.git.wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks to the report from Filipe where he found a new bug in compressed
defrag, that we will try to defrag all compressed extents even it's
already at its max compacity.

This behavior is from the beginning of btrfs defrag.

The first patch is to fix the behavior, by just rejecting extents
which are already at their max capacity, nor allowing extents to be
merged with extents at their max capacity.

The second patch is to remove an ambiguous rejection condition.
The condition is believed to reject compressed extent, but it never
really works due to the check is > 128K, not >= 128K.

And the physically adajcent check may prevent users to reduce the number
of extents.

Qu Wenruo (2):
  btrfs: defrag: don't defrag extents which is already at its max
    capacity
  btrfs: defrag: remove an ambiguous condition for rejection

 fs/btrfs/ioctl.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

-- 
2.34.1


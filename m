Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94D3E9DF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 07:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhHLFfh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 01:35:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhHLFfh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 01:35:37 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4B1D2221F
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628746511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FfMV9rBVzGI4WIVG6fo4+4mjozcAm1VbD6HuWlRJhYU=;
        b=tzl+ZvBZJVNMZOe+Rt4j7wkZR2Wzxpclot8dSkxErGUQE32oBRuwNa3iocUdHyvfaMIKqS
        nAQNvcltLAyggFPsvdgqOTysg+uNgZLwnPb1noLj6eJVY/4qtuEZt8wsJszHaXKQBHgVAC
        zj9n4mIdURkTG4g1mAnptre4W7vnO10=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DBF4713838
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id o8TlJg6zFGFeZQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: map-logical: remove the extent check
Date:   Thu, 12 Aug 2021 13:35:04 +0800
Message-Id: <20210812053508.175737-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit eb81f8d263ce ("btrfs-progs: map-logical: Rework map-logical
logics") introduced a strict extent item check for btrfs-map-logical.

It not only makes it harder to use btrfs-map-logical, but also prevents
btrfs-map-logical to handle fs with corrupted extent tree.

This patchset will address the behavior by completely removing the
extent item check, and allow btrfs-map-logical to work on fs with
corrupted extent tree.

Since we're here, also change the default mapping length to sectorsize,
and reject any unaligned logical/bytes pair.

Qu Wenruo (4):
  btrfs-progs: map-logical: use sectorsize as default size
  btrfs-progs: map-logical: reject unaligned logical/bytes pair
  btrfs-progs: map-logical: loosen the required trees to open the
    filesystem
  btrfs-progs: map-logical: remove the extent item check

 btrfs-map-logical.c | 158 +++++---------------------------------------
 1 file changed, 17 insertions(+), 141 deletions(-)

-- 
2.32.0


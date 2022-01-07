Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4B487352
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 08:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiAGHKM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 02:10:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52438 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiAGHKK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 02:10:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C837F212B8
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 07:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641539409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lazLa6f96UOR/XpKBFFDOyD1NhnVo2b2FV77S3R2URM=;
        b=cal+k8bzpi3zy85GJ0lO7Qn5yz+8Ju8XobsWQ/Azs7LuISxYhcBoyazvvvUD+P57zYiU7H
        9AZDg3ANLL+TSRnncdft4o2WCVLWHXwWODPle3qjOadEcy0VKSHkwvzBzD2ze9xzjFjF+o
        H7hKx3TCeo1RfrVzNqkte71nB3O69JU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22DDE13CA1
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 07:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3CoTN1Dn12EnHQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jan 2022 07:10:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: scrub: cleanup scrub_raid56_parity() using find_first_extent_item() helper
Date:   Fri,  7 Jan 2022 15:09:49 +0800
Message-Id: <20220107070951.48246-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset is depedent on previous patchset titled "btrfs: refactor
scrub entrances for each profile", and can be fetched from github:

https://github.com/adam900710/linux/tree/refactor_scrub

This patchset is doing the remaining cleanup for extent item iteration
of scrub_raid56_parity().

As that function is mostly a variant of scrub_simple_mirror() with
different target operations.

This patchset will refactor a double while loops into a single while
loop with a helper, then cleanup the open-coded extent item lookup code.

With this patchset, all extent item iteration code will share the new
find_first_extent_item() based solution.

Qu Wenruo (2):
  btrfs: refactor scrub_raid56_parity()
  btrfs: use find_first_extent_item() to replace the open-coded extent
    item search

 fs/btrfs/scrub.c | 299 +++++++++++++++++++----------------------------
 1 file changed, 118 insertions(+), 181 deletions(-)

-- 
2.34.1


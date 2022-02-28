Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487CB4C6040
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 01:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiB1AvJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 19:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiB1AvI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 19:51:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8493A40A1D
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 16:50:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4248D1F892
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646009429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jg7C+TnPqCSQI45Du40pWldaGcYFUQkqmMHepyGSqNo=;
        b=sB9zSJA+nHOwlqn2mt48dVCRsrPfVE0VawYoDRdtg8/JUpveg/dMUZLANeMNtW2HpZOF/R
        vaXDVRXUe2cWLoFfNWynVlRThUC+INnLGo9h7D3IlUk5luuIvVpoyBY0y/r3XTklQ1F+dx
        osXLkNoCPBdRntrO3ikyByN5NQ8704g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97579139BD
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 00:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KFW1GFQcHGJ3OwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 00:50:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: tests/fsck: add test case for super num devs mismatch
Date:   Mon, 28 Feb 2022 08:50:08 +0800
Message-Id: <f8838c77cbee4174643035fb63b8dd58a262b0b5.1646009185.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646009185.git.wqu@suse.com>
References: <cover.1646009185.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new image will has incorrect super num devices (have 8 expect 1).

The image has to be raw format, as btrfs-image restore will reset super
num devices to correct value.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../054-super-num-devs-mismatch/default.raw.xz  | Bin 0 -> 22028 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/054-super-num-devs-mismatch/default.raw.xz

diff --git a/tests/fsck-tests/054-super-num-devs-mismatch/default.raw.xz b/tests/fsck-tests/054-super-num-devs-mismatch/default.raw.xz
new file mode 100644
index 0000000000000000000000000000000000000000..af0306bedbd0bd45dfd2d65a0f0a9f6bf662dfa8
GIT binary patch
literal 22028
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

literal 0
HcmV?d00001

-- 
2.35.1


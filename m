Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218737CC7A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 17:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjJQPlv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbjJQPlu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 11:41:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1239F;
        Tue, 17 Oct 2023 08:41:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 64E0F21D02;
        Tue, 17 Oct 2023 15:41:47 +0000 (UTC)
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 217FA2CD7D;
        Tue, 17 Oct 2023 15:41:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E0C0DA8C1; Tue, 17 Oct 2023 17:34:58 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.6-rc7
Date:   Tue, 17 Oct 2023 17:34:56 +0200
Message-ID: <cover.1697555249.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         R_SPF_SOFTFAIL(0.60)[~all];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
         RCVD_NO_TLS_LAST(0.10)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
         BAYES_HAM(-0.43)[78.52%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 64E0F21D02
X-Spam: Yes
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull a "one-liner and thousand words", fixing a bug in chunk
size decision that could lead to suboptimal placement and filling
patterns. Thanks.

----------------------------------------------------------------
The following changes since commit 75f5f60bf7ee075ed4a29637ce390898b4c36811:

  btrfs: add __counted_by for struct btrfs_delayed_item and use struct_size() (2023-10-11 11:37:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc6-tag

for you to fetch changes up to 8a540e990d7da36813cb71a4a422712bfba448a4:

  btrfs: fix stripe length calculation for non-zoned data chunk allocation (2023-10-15 19:00:59 +0200)

----------------------------------------------------------------
Zygo Blaxell (1):
      btrfs: fix stripe length calculation for non-zoned data chunk allocation

 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

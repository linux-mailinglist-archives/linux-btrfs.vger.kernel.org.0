Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F76162F6
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 13:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKBMqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 08:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiKBMqo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 08:46:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FB629809
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 05:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE2BCCE1F57
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 12:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B088BC433D6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667393200;
        bh=tfxXWMyqKBVOPc/Zyc5on98Uxl8YejDY1jYDqaLRfdA=;
        h=From:To:Subject:Date:From;
        b=RgL+kSC4BIs7Du/fC8yjmE64yyC4usWg45+tWpLwkoWqgP6+mT0XIVaNRbqRk9V6x
         ekACJO55yisDWgAfdMJIrNaSkcedM3VdyjiAEQvSMhiYpLjMY5G7D217z3w2SNbxiY
         779EvirPb6TyVZsG3OGTSLe6USlyMegRBgsvxLeEBFspV1xl47fbBF5bdDvJCEfmc6
         OdPMIvPZ1RQv/WmH9FY470UrJdpzH3+P/6e39dxVQ25Rq0i5tujMF9xI9BKhzSI7a6
         5AvVgoUhOhAK7GxlLJDziGKULl1WcQyRfON/S+2f0Wk1B7kNBcmArQq+MhIBoxuzWB
         bkLx5GwdaxaLQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fixes for nowait buffered writes
Date:   Wed,  2 Nov 2022 12:46:34 +0000
Message-Id: <cover.1667392727.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A couple fixes for the recently added support for nowait buffered writes.
Trivial stuff, one of the bugs was reported sometime ago by the lkp test
robot.

Filipe Manana (2):
  btrfs: fix nowait buffered write returning -ENOSPC
  btrfs: fix inode reserve space leak due to nowait buffered write

 fs/btrfs/file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.35.1


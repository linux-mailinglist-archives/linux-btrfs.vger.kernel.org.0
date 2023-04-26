Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA996EF2D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 12:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbjDZKxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 06:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbjDZKxD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 06:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC18355A3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 03:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29AAC63536
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C9AC4339B
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682506300;
        bh=zUioMPoM+71SACqhcR200IzbiuhNcXpi5McrsK1H0aA=;
        h=From:To:Subject:Date:From;
        b=KbJjY4eYInzR/Lahh+JBLzc2YCSQHN+PXisOthOmWlocLwA6Lc9MqsTguV3sO2fH+
         /h6iq/V6b4hxM7Y2bd0oxrzH8fBlBsdKVmYEVO9ySPm4ji/0qeCQBC/3chPT5Pxe7I
         rYzBulihDWCcawIQ35pd+EYmwKIQPtZKEQ406VVL70CkEIYMJ/TepZohlOe+HyWzGI
         EKPgihYmzuTrPYOyRDvnS3otN3GaF/lvOC36P2lPHcmI84gX/DUoZy6+qQCMjwTvB3
         JFsH23V1MEZWUwEC8ktttZPVS3d/Vrt1uUkJ1ZUb5zxa0p5z148nIaP7QuBxHVELNr
         W57cgFFuq/hFQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: improve sibling keys check failure report
Date:   Wed, 26 Apr 2023 11:51:34 +0100
Message-Id: <cover.1682505780.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This makes reporting of sibling key check failures more useful, by
printing more exact stack traces in case the extent buffers are leaves
and dumping the extent buffers. This is motivated by a recent report [1].
More details on the changelogs of each patch.

[1] https://lore.kernel.org/linux-btrfs/20230423222213.5391.409509F4@e16-tech.com/

Filipe Manana (3):
  btrfs: abort transaction when sibling keys check fails for leaves
  btrfs: print extent buffers when sibling keys check fails
  btrfs: tag as unlikely the key comparison when checking sibling keys

 fs/btrfs/ctree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.34.1


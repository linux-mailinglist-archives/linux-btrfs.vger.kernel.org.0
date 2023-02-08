Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB568F608
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 18:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjBHRs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 12:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjBHRsJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 12:48:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B2638B51
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 09:47:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E42B61779
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 17:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B0BC433D2
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 17:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675878412;
        bh=sFOV+Mbr7t6t+7gozVRMJE9sa+FyUIL+5QBluA17ra8=;
        h=From:To:Subject:Date:From;
        b=stTJigxBFIcR5Kd878tNKZCLDTyRwwESWctjaoLt3Yz20wi1fh4To+FL6Qga6YvmK
         gXHZ4Iv3knvw9a9ZHHMG73KseicDvvLzH8ieeE6duH92AaZ+hWzUQW+QFyPEmNwTFB
         hiCIStb+iJuFjRvn1mwBwPndUugzDUrYvtArTvaw6PZuNx7Fd749V9VFYidcG8trFT
         OfoXQmi/cXzLcvx2mUbp4+MawU+4AzuxIVSGHL2KZrYTpdTVZjzhTR9DCAfB/KDJxr
         Yy0BDiHkMhIimMj0M4woFFbVG82XFqQJOHZNcvbZDkgCP/sPhJj/JhPo2RltxjR17/
         KI4cho4LHObng==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: some minor tweaks to the extent buffer binary search
Date:   Wed,  8 Feb 2023 17:46:47 +0000
Message-Id: <cover.1675877903.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Add a couple minor tweaks to the binary search function. These were
originally part of a larger patchset I'm working on, but since these
are trivial and independent from the test, I'm sending them out
separately. More details on the change logs.

Filipe Manana (2):
  btrfs: eliminate extra call when doing binary search on extent buffer
  btrfs: do unsigned integer division in the extent buffer binary search loop

 fs/btrfs/ctree.c | 31 +++++++++++++------------------
 fs/btrfs/ctree.h | 15 +++++++++++++++
 2 files changed, 28 insertions(+), 18 deletions(-)

-- 
2.35.1


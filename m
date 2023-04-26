Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF76EF90E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjDZRNH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 13:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjDZRNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 13:13:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AB6194
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:13:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F7960E05
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 17:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A41C433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682529184;
        bh=tLKHfob+K6WX1jgDzHATSh5P3i/EWWRJ/P1zxZ9pGiM=;
        h=From:To:Subject:Date:From;
        b=OX+hSD7adJ+Tbq9rlHrNna/CQsAo+K5ZFi5aVpL9qSBuRlsuI9GuQyowCQbxRd72P
         Tb/o5ktc9z8xrX19Upr6s9qoKSrQ2DUapZt70UGcHSMAzIDRrSjIhZsMEkpISUMF8w
         VQTBwvYoHNz05+s7ylP2S2iCNZLWAoitcjuJBJr1mXiLitKiFxesmMAV5DshyrbKxK
         RtiHNxSGlFtgzG0rJC+AzR69KrxQ9ToHRIfdikH7Tzt3OyysXeBEySUi2FWvxvbMzb
         OPuUoOQsAN9Rzakg2bC7OTH093SxI19u4byDMNfdjE8tSYPEsYuNTOlVo1adELnCeD
         eLIr645iCNYCA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix extent state leaks after device replace
Date:   Wed, 26 Apr 2023 18:12:59 +0100
Message-Id: <cover.1682528751.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This fixes a recent regression (on its way to Linus' tree) that results in
leaking extent state records in the allocation io tree of a device used as
a source device for a device replace. Also unexport btrfs_free_device().

Filipe Manana (2):
  btrfs: fix leak of source device allocation state after device replace
  btrfs: make btrfs_free_device() static

 fs/btrfs/volumes.c | 3 ++-
 fs/btrfs/volumes.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.35.1


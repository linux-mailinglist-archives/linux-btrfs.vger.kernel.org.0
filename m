Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E933F66DC3D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jan 2023 12:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbjAQLWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 06:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbjAQLWG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 06:22:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487CE13502
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 03:21:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D938C61297
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 11:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC93C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673954503;
        bh=Lgtdy5STgiSZpZpDliODAcc4qtSGG6cMhcJfWaGt3oc=;
        h=From:To:Subject:Date:From;
        b=hxDESEFtjNJpQgd/RePe80VjAfMhDZZToI9BKBqMQehGhMZLOfYGfLOuOIfwevBMC
         P7lKqGswSpKV6q1qFHJi+CIojvfHJgdCuCzmwaAnn3u9/WnhA85PSz/WAlKKmi/b9J
         xPONdCvGDTdtZzAs7Tt9AyUKpJzrUXhZ1wJcQQy8uXl4MzrTa/TMtRoJPwYqX/SzIP
         7/O3+yPw9wR4iiobR7xqlvcodUbucA8xVz+ba69IzJKcUzbNBqbfyYY13pHSOqcn/D
         qeZYdakozv24Kyr8R7Ppi5gqi3dR+QZyvMG3OclpN4y7vOtr9JIInfIKQ1WA4ssJgX
         rTY5HOMi4vpYA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: some speedup with fiemap when leaves are shared
Date:   Tue, 17 Jan 2023 11:21:37 +0000
Message-Id: <cover.1673954069.git.fdmanana@suse.com>
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

Add a couple assertions for the fiemap code that checks if extents are
shared and speedup the extent sharedness check when we already know the
current leaf is shared. More details on the changelogs.

Filipe Manana (2):
  btrfs: assert commit root semaphore is held when accessing backref cache
  btrfs: skip backref walking during fiemap if we know the leaf is shared

 fs/btrfs/backref.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

-- 
2.35.1


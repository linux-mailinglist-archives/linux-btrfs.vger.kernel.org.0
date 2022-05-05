Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97151C5E6
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 19:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382095AbiEERUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 13:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiEERUA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 13:20:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB865C34A
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 10:16:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD73161E9A
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 17:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E7BC385A8
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651770979;
        bh=+ZxJUXeVsf/MoMPeVdFG0qYI8F7a/U1GsyqQoxxfI9Y=;
        h=From:To:Subject:Date:From;
        b=toCtyOSJBad9uFeXmNJleLEwzp8ipb9YKIj6bAvNZQ3Ce/ReCxhGx2Yemo6U19jrQ
         42tA7K/xPcYbe2vE+oH2Fn400ZoUHnFPpYFmnU4QnMOkfraB/oj1Ot9PriJ6Sw3Zo1
         J9LEe+fyAFwWqUP0RTP2uf5kv6ILEmkAm4LTv0yGk5bFL6nwZdvVnknfzHbP0iKshn
         J8vIYn4zHuxNytxWwS4rSZJQyShiedcHdf3xe6aQ9HJmh6vKiHndPwW2b3G3SClGeg
         +t2bEciivdQhkq34ORnfa9hnHUaJZGEVxMPycUsijOtsTsg4LbNv3VWhwThUEXUPOs
         41StuzWUgjwPA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: teach send to avoid trashing the page cache with data
Date:   Thu,  5 May 2022 18:16:13 +0100
Message-Id: <cover.1651770555.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a send operation, we read the data of all extents we need to
send into the page cache, which almost always is wasteful as it can lead
to eviction of other things from the page cache that are more useful for
applications (and maybe other kernel subsystems). This patchset makes send
evict the data from the page cache once it has sent it. The actual work
is in the second patch, while the first one is just preparatory work.
More details in the changelogs.

Filipe Manana (2):
  btrfs: send: keep the current inode open while processing it
  btrfs: send: avoid trashing the page cache

 fs/btrfs/send.c | 128 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 109 insertions(+), 19 deletions(-)

-- 
2.35.1


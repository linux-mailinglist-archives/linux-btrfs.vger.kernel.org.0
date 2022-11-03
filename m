Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42629618559
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 17:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKCQxh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 12:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKCQxe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 12:53:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4D51144
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 09:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 526E5B82924
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 16:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C403C433D6
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667494410;
        bh=GjmDC+hg+6lwBOxBli3wksUgKEvdSH16cUlFBc5wlJE=;
        h=From:To:Subject:Date:From;
        b=XFIFbWR9yhmSbDYlUX+SCAo/wU58+exEUScYL0ya46ScRu9NirtRl2YAxfEj2IQ6H
         9jwenJBIAwGWVGaXSLiOkRu99n59loQf+wlVXsO/6FnMDxWeMQ/2Aat3aDTttqCYn3
         ewJSBne6dxsWCsXimtB6GG2AhMx7eURb+VSwR+NVMvPsrtP5aDbpBFxAiNtcBop+dQ
         LDWlf9jZwBjOL0SAhIWSf5yxymsR+hLRWl0kzqjbmc7hiF9Uqrfoy584mT9pANoD7I
         hUCihNnx8BDsUK+MTTL/AkWSW1K7VG5EhIHUtmEwBG3ngxPcBUxLQTexAmd/Zz5XQL
         sgL/cofVExO6w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: receive: address setattr failures
Date:   Thu,  3 Nov 2022 16:53:25 +0000
Message-Id: <cover.1667494221.git.fdmanana@suse.com>
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

I was writing a test case for fstests with fsstress and send v2 streams
and it turns out that receive will always fail if we have a fileattr
command in the stream. It fails for two different reasons, described in
the changelog.

We actually had a report today of a receiver failing on a send stream v2
because of the reason addressed in the first patch. However fixing that
alone, will still cause the receiver to fail, just for a different reason
(patch 2).

For now I'll hold the test case for fstests since it fails very frequently
(almost always actually).

Filipe Manana (2):
  btrfs-progs: receive: fix parsing of attributes field from the fileattr command
  btrfs-progs: receive: work around failure of fileattr commands

 cmds/receive.c       | 44 ++++++++++++++++++++++++++------------------
 common/send-stream.c |  2 +-
 2 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.35.1


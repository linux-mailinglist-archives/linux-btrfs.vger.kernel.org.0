Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D077A5E2
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjHMJvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjHMJvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 05:51:16 -0400
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Aug 2023 02:51:16 PDT
Received: from mail-108-mta247.mxroute.com (mail-108-mta247.mxroute.com [136.175.108.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48E710CE
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 02:51:16 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta247.mxroute.com (ZoneMTA) with ESMTPSA id 189ee49dde700023b6.001
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 13 Aug 2023 09:46:05 +0000
X-Zone-Loop: 8a6ed084fbe461891bb4d07b5da51cdac34ed64662b6
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c8h4.io;
        s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From
        :Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=xEsQqoz89NK6qa15YW7tsYd40jto9WY8e2oyvUUOnOk=; b=Z
        0KyEvhYpBTARwkRQ0rl7QQ2WjrvqfNNBn0Vdh4zxur+uVfdMgFwkCsy5+axjJpXg368cTAO2X6hPD
        8khMiyLjrcIGPDiR4mI9tU+aogyL2EFZuwPu9Z7lf4JMvpSVIqDmZUxzr4v7ol2EBVZxtNJIgFhTG
        DwTJA23LKTYc8yDAuX+uMKFft2wlX3fpBR7BCXQ9J81117VtF+WkFjvspNkkJBmSk+IGYb1snpE3z
        emL7npa73XcSGXwwX7h67H3PiIUhjH7hpFrqYnYGzwx0PNFvKpNtJlQBh165tmU7F3AnvigByqm9T
        /HehFewveW9NBYe1aHgw6tYDjEUU4ouYw==;
From:   Christoph Heiss <christoph@c8h4.io>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs-progs: implement json output for subvolume subcommands
Date:   Sun, 13 Aug 2023 11:44:55 +0200
Message-ID: <20230813094555.106052-1-christoph@c8h4.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: christoph@c8h4.io
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

JSON as output format is already implement for some of the commands in
btrfs-progs, which is a very useful feature to have for e.g. scripting.

This series adds the same for `btrfs subvolume list`, `btrfs subvolume
get-default` and `btrfs subvolume show`.

#1-#3 are some small preparatory fixes & refactors, #4 introduces the
`struct rowspec` containing all fields needed by the series.

The actual implementation of the JSON output is mostly pretty
straight-forward, only cmd_subvolume_show() needed some refactoring
first.

I probably will go about implementing the same for more commands, but
wanted to get this out now to get some feedback.

Christoph Heiss (7):
  btrfs-progs: common: document `time-long` output format
  btrfs-progs: subvol show: remove duplicated quotas error check
  btrfs-progs: subvol show: factor out text printing to own function
  btrfs-progs: subvol: introduce rowspec definition for json output
  btrfs-progs: subvol list: implement json format output
  btrfs-progs: subvol get-default: implement json format output
  btrfs-progs: subvol show: implement json format output

 cmds/subvolume-list.c  |  91 ++++++++++-
 cmds/subvolume.c       | 345 +++++++++++++++++++++++++++++------------
 cmds/subvolume.h       |  19 +++
 common/format-output.h |   2 +
 4 files changed, 357 insertions(+), 100 deletions(-)
 create mode 100644 cmds/subvolume.h

--
2.41.0


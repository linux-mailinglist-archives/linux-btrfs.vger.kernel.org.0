Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1957B28AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 01:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjI1XQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 19:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI1XQE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 19:16:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E631119E;
        Thu, 28 Sep 2023 16:15:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BCE5D5C013C;
        Thu, 28 Sep 2023 19:15:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 28 Sep 2023 19:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1695942955; x=1696029355; bh=e4TSlngHqD
        IzA0uXNgZq4+QsoKGTqKSc0THA0V2yhIQ=; b=F2NdO/qX8Br3BXquFoUHcPl4j9
        bgggl6iv6rgutqUWYw92gNoowd2byelwQqQUt3dBjfHvjEX/mZ/XZey9/+zIobR3
        h86/xNJP/FXQQOa9Y216X+68Up4vxiZbuxnlfc6P5sJRIPvMLHSzkTyyeNJX+qGp
        S27I7X9IL+56Zhf0n5yGHWDFcoTZlSDnTeC0j2GOn5d7Xi2IsrRK72x50RIrwWMw
        CUePKokFnR1x2L602ltyvuUFWGytwkvS83BX0GxkiPl/OD1frAsyTcZyoqytYUZR
        C3a1MD2p+sVdM7HxNIWTd2oDH7zQw7z93OH7IVKZsyxC90jjKcqTGoF2EQMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1695942955; x=1696029355; bh=e4TSlngHqDIzA0uXNgZq4+QsoKGT
        qKSc0THA0V2yhIQ=; b=IEfnCAfz0UYzbVYWyNB+RptedUl7sM+lKzYPC9CYcTcV
        2pN0HGWKXE02AcLEA2uJwx6GuVTTEVRL/uuk6sMsg49oP3r9LFCqT2Qf3bqWGKmd
        Dv5YmlQvWJZCE5w3Vw9w2dbEVJKB7F86sPJ3uQ+AZuUhpfP4RazyWqElkorcbQsA
        co5dBhHGajk3Bs7Ihpz7mn0f/0jT/qxUlqb6Fc0Jcn5nLyjJAHr+LeDBfb1IBbiK
        UhB2KR61hauksjPo+XEV+QuQ7sTSNcDS7rra3S/8cMNrZSToQOz28eSqbj4V71/i
        NNTGx/7aa/4eRdkR28GnM/7qbsWOvKs2P1Lgd8SesQ==
X-ME-Sender: <xms:KwkWZcBUHeVBvJ0dUmOaMrd_BNYxlzhfC_wextfOz8qdKnBrh5lKEA>
    <xme:KwkWZeixl9BiDTx0ydtOBF3uTb_iqTQU9nsPLg-wdoxuz9lGCXCj9hoYcsT7_joVF
    btzftrLZRguG_oz9rs>
X-ME-Received: <xmr:KwkWZfmHrUMkcr6P-DDRx1lnsWB41bk3q_PIp-o0oxtZwb5_1-uc8E21Jv6quUXbNfJd_LfMo7Q_njB1Ftzg2WpRk_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddugddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepieeltdffhffhvddtfeegvdeiteelieejjeeitdfhfeegke
    ehveehkeejleekgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:KwkWZSwHfEWsRjslDhdpX8-a3QuvYfsDeQz4t2R7OvzkRZeBBga3zw>
    <xmx:KwkWZRRaFAXHYEJvvZxNMBOf43kPsZzx5cxKznhrEtr6W_Ndt_ELoQ>
    <xmx:KwkWZdbu7lXECuMW6hO_rarkhQiQKTgxhfXLWL2f7594Tt01qWfeXw>
    <xmx:KwkWZQJMJHa7as0IvKYb-COtz4BJY4q5xnGLZj2Qcc8MsQrcp1dZNA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 19:15:54 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v4 0/6] btrfs: simple quotas fstests
Date:   Thu, 28 Sep 2023 16:16:42 -0700
Message-ID: <cover.1695942727.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new test for specific squota scenarios (btrfs/301)

Also made modifications for passing existing qgroups tests when possible
and for passing all tests with simple quota enabled via mkfs and with
squota-aware `btrfs check`. Since this required reading sysfs files of
scratch fses, did a bit of refactoring to make those checks target a
device rather than assuming TEST_DEV.

btrfs/301 depends on the kernel patchset:
https://lore.kernel.org/linux-btrfs/cover.1694563454.git.boris@bur.io/
and the btrfs-progs patchset:
https://lore.kernel.org/linux-btrfs/cover.1695836680.git.boris@bur.io/
(and config appropriate binaries to use squota-aware versions)
---
Changelog:
v4:
- fix rescan helper bug
- fix broken tab/spaces in squota helper
- cleanup comments
- improve test names, add some comments
- switch to remount commit=1 for forcing cleaner
- fix group list for 301
- use reflink helpers
- output errors to 301.out (and have expected ones there waiting)
- cleanup "/dev/ksmg" writes I missed when grepping for /dev/kmsg 
- cleanup variable names
- proper fio/btrfs/xfs_io requires
- read nodesize from dump_super
- sync before dump_tree
- documented all calls to sync
v3:
- change btrfs/400 to btrfs/301
v2:
- new sysfs helpers in common
- better gating for the new squota test
- fix various formatting issues
- get rid of noisy dmesg logging


Boris Burkov (6):
  common: refactor sysfs_attr functions
  btrfs: quota mode helpers
  btrfs/301: new test for simple quotas
  btrfs: quota rescan helpers
  btrfs: use new rescan wrapper
  btrfs: skip squota incompatible tests

 common/btrfs        |  56 ++++++
 common/rc           | 127 ++++++++-----
 tests/btrfs/017     |   1 +
 tests/btrfs/022     |   1 +
 tests/btrfs/028     |   2 +-
 tests/btrfs/057     |   1 +
 tests/btrfs/091     |   3 +-
 tests/btrfs/104     |   2 +-
 tests/btrfs/123     |   2 +-
 tests/btrfs/126     |   2 +-
 tests/btrfs/139     |   2 +-
 tests/btrfs/153     |   2 +-
 tests/btrfs/171     |   6 +-
 tests/btrfs/179     |   2 +-
 tests/btrfs/180     |   2 +-
 tests/btrfs/190     |   2 +-
 tests/btrfs/193     |   2 +-
 tests/btrfs/210     |   2 +-
 tests/btrfs/224     |   6 +-
 tests/btrfs/230     |   2 +-
 tests/btrfs/232     |   2 +-
 tests/btrfs/301     | 435 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/301.out |  18 ++
 23 files changed, 615 insertions(+), 65 deletions(-)
 create mode 100755 tests/btrfs/301
 create mode 100644 tests/btrfs/301.out

-- 
2.42.0


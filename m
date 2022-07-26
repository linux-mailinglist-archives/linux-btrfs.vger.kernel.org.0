Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2BA581B3D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiGZUmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbiGZUmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:42:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3F337FA8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:42:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D04C5C00E5;
        Tue, 26 Jul 2022 16:42:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 26 Jul 2022 16:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1658868158; x=1658954558; bh=atJMWS92D9luGp4l56Dtgppsj
        4tGVy898vdAgv+8hBk=; b=gdcKdsBv852n6AbRK56a7bPp6qcC61Ic/knl6G0Ir
        8nnmI5JrD3buFFfI/dyeZZzB8k8TWDGfF6HdMNkbcybubO+aiK+gIMddWRbQ5qNp
        Ta0E0k8qrtVu1rs8r8m7X3nQKXj26Y84eDEpB006tz57scL0vHlVIXEtqK1wcToD
        7k4t9zAtvlGjjNY1dBraQg6qb4D3IXEqfu7K6uX5rezy5qBNvvi2pGT027vvR0ig
        OeOxXnt7AgZ6yxLFIc5UG7u00pq51+5EGJNvP56fzYDL9O51ukR9IfjtkOgpBPG5
        ayNt1qmcaACsBUu15yyP0eeM/gF/ryjclwhfBmU0CKK0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1658868158; x=1658954558; bh=atJMWS92D9luGp4l56Dtgppsj4tGVy898vd
        Agv+8hBk=; b=egrftT8DtfpJOlb2/5dE5mV/piPODVp87LHf5NsExcNNnbWsiXm
        eAZW7LOT+roGo99ija6YwhYR7FKidWJ73XQPDjcTCzeUxOAYNlhdeA/ux5BR9NoF
        QgsTO1Bm0bUYyOax+2utTYp7g5PpTZ5kzlt21NVlSoQ0IdU27UZZaX3uTu99UZrk
        IL1syNDz9CNQ5YuUcdslqe+TiifA7cyoHMuvBSVNmIpXJ34loK6W6jZp/NvE+tXu
        5a0QUJ6Ira5q2vVaBAYKJhgUCIpjlSLxKM4tvwZgey3fGn+s3v9DLlVoqiqTxH5M
        wQBm03Nd0WQZKb/FTvi1BYU4wJcs/FmlZSw==
X-ME-Sender: <xms:vlHgYvmjsnG_XJDhHG1Ql70U_QSkh3orj_3PSrAxdPMi6OwZsOV-cg>
    <xme:vlHgYi2j40cWLwhI3kKymu2eUDg6pAG1uc9cQ_rV_Lp4QD6PWCnuX_7VL-kH4A5Y9
    OQCQ6ZWI0UJnIUrs1M>
X-ME-Received: <xmr:vlHgYlpAY4u9zFXVDohc8hzaQPCJZq1W7xY5hJ6WsZb25adaEVP03sFbsqnww_5UxpkhauIE6nQ1jVAHyF3De9Lm5j3kMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:vlHgYnmu7igBTgxpCyUR2faeivnxbxJgdsT5oX-uXjXRK7PHjGcCBA>
    <xmx:vlHgYt3DMOCeWnirb-vt6GK7-mNONLDDa6A1tQ-cpGGkiu8Y9UnfRg>
    <xmx:vlHgYmuPXvtwwuWYKGHrWEeZZPkBsCt37IrLVljEjZWdXaJgJf2mRg>
    <xmx:vlHgYq9OEvjJ_MXz9itc-TOEelwb17vI8UTzG7-9-5VPpEQqu0YrOw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 16:42:38 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 0/4] btrfs-progs: support for fs-verity fstests
Date:   Tue, 26 Jul 2022 13:43:21 -0700
Message-Id: <cover.1658867979.git.boris@bur.io>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adding fstests for fs-verity on btrfs needs some light support from
btrfs-progs. Specifically, it needs additional device corruption
features to test corruption detection, and it needs the RO COMPAT flag.

The first patch defines (u64)-1 as "UNSET_U64"
The second patch adds corrupting arbitrary regions of item data with -I.
The third patch adds corrupting holes and prealloc in extent data.
The fourth patch includes BTRFS_FEATURE_RO_COMPAT_VERITY to ctree.h

--
v4: use ternary and get rid of "bogus_type" to cleanup input handling of
    'corrupt_file_extent'
v3: add patch #defining (u64)-1 in btrfs-corrupt-block
    check item bounds in corruption function
    improve usage message for new corruption use case
    add patch with verity ro compat flag
v2: minor cleanups from rebasing after a year  


Boris Burkov (4):
  btrfs-corrupt-block: define (u64)-1 as UNSET_U64
  btrfs-progs: corrupt generic item data with btrfs-corrupt-block
  btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block
  btrfs-progs: add VERITY ro compat flag

 btrfs-corrupt-block.c | 126 ++++++++++++++++++++++++++++++++++--------
 kernel-shared/ctree.h |   4 +-
 2 files changed, 107 insertions(+), 23 deletions(-)

-- 
2.37.1


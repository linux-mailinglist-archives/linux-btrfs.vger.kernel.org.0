Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C2C75BAE8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjGTW64 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTW6z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:58:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6442D92
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:58:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D3B7A5C00E6;
        Thu, 20 Jul 2023 18:58:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 20 Jul 2023 18:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1689893933; x=1689980333; bh=nCBTmNRwC3
        kNyZSWKb5+q2GPPEqSa5m6665J95X3JkU=; b=ZhcJ7QsQnxh+0P1kOjWZXn3aXh
        qL9PAtgP9SwVD/9bOpIlgUM500ZOokAhrEJEh3u3lxs+5SwCYbIZ0twnIOU09ub+
        CmFM6r7ObrsCtAIrT8yUaEm+ZmzK49SDPsIkab7o+RwXmE8l0gehROv8sGL17C7y
        MFB96iM2Qe4WmRRCsbB0rGnk3SqkKzf4r9y9HXY6boP1MDVQrkPKqXR68P+ySLL9
        c4JZH6nXkPcot7rNdZQ0qvH6Eb0MXeFd3O+qMb2aiQfixxiX9HGYf2oi1pjsdZcr
        1gkc7p2r8QD0RcXsTgqGzawPR5TwCl7Lw/hEbdZSaIn1EIYTtgMfyVK36A8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1689893933; x=1689980333; bh=nCBTmNRwC3kNyZSWKb5+q2GPPEqS
        a5m6665J95X3JkU=; b=vQXBJROfyJM8D8vdMV5RcnPEFjYVIHBgjUDoJJDUuJfJ
        X0VpI4OgeeN45wq9Mh1MfU4y5BogIltNy/UYkJvi02kBDAGY1ZubCHH5ujPUp9Yv
        CXwqE3V0kxbp5YAdmyrxfM1nTQVIWP9j0IIQu8k6zkTRI9q2Y1XVmVRE+w2z2qDq
        ndn+JhXkoAQuHY/wpuAnu1giNRYML6tD80W6DYqHwBEAy/2rxxXiSY63p6nfWJaV
        a1Z8AXS34Ij65Z1x1fS+qiRqt83/RvwSf2zKNRPC+YkM1RUsvC9WPztgdJppx9Lc
        uLrMFHYw0C65lEAGCAzKfo22tNuRsCkRlheOWz8FWQ==
X-ME-Sender: <xms:Lby5ZDQ5HvzaATVnwLgAOjT_mVU4hUZFbVAZC9ED_dBBWKP9BiZirg>
    <xme:Lby5ZEwvKZxTHYxVAvfTlYRlZ-Ehu4YKPXN0hZe_de0zq2sq0zWLcmUfTLLEvd_VR
    6IFlGzg3K03Irg7a68>
X-ME-Received: <xmr:Lby5ZI3Dd_eW2xIC_pwRCQX1hRWzlyp9UOKkqCaEFfZ1gNhtwZRR2R2VZE-6Y_QfqS4QwtTNb-hLs4jCppgjRFbQLDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Lby5ZDBdjsjsc3fTi_KXBg0g12JLn_IfXGmRQWnid2nU0OluQCZw_g>
    <xmx:Lby5ZMiR2hCHVG1hGW7gsLFmfUEBJMcBHpLF-X-Kv9rQUXt3GpU3Nw>
    <xmx:Lby5ZHpeUOHJdrpbSyY9WZhTbELdGVltngF7MRRd8U2_SMO_LKDmng>
    <xmx:Lby5ZELlkkc2AKZAp5FQm5_2TmscmrEUOsvfMWDCXqu40tvyuXEPNg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:58:53 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/8] btrfs-progs: simple quotas
Date:   Thu, 20 Jul 2023 15:57:16 -0700
Message-ID: <cover.1689893698.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs changes for supporting simple quotas. Notably:
btrfs quota can enable squota via ioctl
mkfs can create an fs with squota enabled
btrfstune can enable squota
btrfs inspect commands dump squota fields
btrfs check validates and repairs squota invariants

---
Changelog:
v2:
* fixed messed up list numbering in doc
* fixed broken formatting
* used new command in enable ioctl instead of status value
* introduced new qgroup status flag to mkfs/tune

Boris Burkov (8):
  btrfs-progs: document squotas
  btrfs-progs: simple quotas kernel definitions
  btrfs-progs: simple quotas dump commands
  btrfs-progs: simple quotas fsck
  btrfs-progs: simple quotas mkfs
  btrfs-progs: simple quotas btrfstune
  btrfs-progs: simple quotas enable cmd
  btrfs-progs: tree-checker: handle owner ref items

 Documentation/btrfs-quota.rst    |   7 +-
 Documentation/ch-quota-intro.rst |  59 +++++++++++
 Documentation/mkfs.btrfs.rst     |   6 ++
 Makefile                         |   2 +-
 check/main.c                     |   2 +
 check/qgroup-verify.c            |  86 +++++++++++++++-
 cmds/quota.c                     |  39 +++++--
 common/fsfeatures.c              |   9 ++
 kernel-shared/accessors.h        |   9 ++
 kernel-shared/ctree.h            |   6 +-
 kernel-shared/print-tree.c       |  27 ++++-
 kernel-shared/tree-checker.c     |   2 +
 kernel-shared/uapi/btrfs.h       |   3 +
 kernel-shared/uapi/btrfs_tree.h  |  17 ++-
 mkfs/main.c                      |  64 ++++++++++--
 tune/main.c                      |  13 ++-
 tune/quota.c                     | 172 +++++++++++++++++++++++++++++++
 tune/tune.h                      |   3 +
 18 files changed, 499 insertions(+), 27 deletions(-)
 create mode 100644 tune/quota.c

-- 
2.41.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82895FE595
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 00:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJMWwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 18:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJMWwS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 18:52:18 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3042157F65
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 15:52:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 78491320083A;
        Thu, 13 Oct 2022 18:52:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 13 Oct 2022 18:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1665701532; x=1665787932; bh=uPWafh4XkUDe2OVOAlFyg0JsZ
        IVhDlCpaD5BiX+I4+M=; b=KNtyouGgQ+x8GZ5nL+dlpu1uAKCw6xAwJop+J4Bl5
        WRAPAVyxYi9MNy+WkVj5xOoJY9SMbuu0Zj6aS9OZHlPg6oVxaw/sBv5tA6BT6iw2
        3ztfRhgrjkNLRgwNXYjuixVflqbHifc/+QobV3B342l1JO/ogpuAWDx1eNOdYBDL
        WTKjSOx0gQo+zZcYgG1pT5br5JYHFooG9WgoR64c2uCMiB6HQ7Cn75N1opEkZYq5
        WjKrgY2PCusXCYOhd8CJA2dgrzmo4mMZE4Wu+RmeHzHzFmVm8mgYCpYlGv11X250
        wuIoNSP2gzQjD5BearCbCi8MVbwrvNtnja2i8JEsfYtXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1665701532; x=1665787932; bh=uPWafh4XkUDe2OVOAlFyg0JsZIVhDlCpaD5
        BiX+I4+M=; b=sivzVzUA4tx9ud9gHE5ed4aRQVegKnPj+zKzeXn4VY2AGLyl+DT
        IzsOk2EJ/BfMsbeL6u54sjBBs7P9FN8FrhwhL4ZSLsJV5Drei+yIMXYxIG8803zW
        mOrNeO5wayPAqqEKb9F6FrDJMAN6O0ecIBvbpiOsp8tM/XzzdIzcjfkF9SZSK9UO
        Sl4H2KrMvqkA7Hvv0TqZWPlIZ4SwhHFOT3Wr6aHIo7s5MqnAdmp3hPQCb1JmxhQp
        OzdgyUT6nPUNozoNFYkWTR4QUckX9Ga/cs5e1K3px3eNac3bJapeXFJmn1MuaB21
        KoTlMAUQxjO6+SfJzqsRUy6C9IPQev4ETUA==
X-ME-Sender: <xms:m5ZIY7X2ijP-OUGiumJOTfABpgCmgNENXuNgRrlwj1UtaZOo36Hweg>
    <xme:m5ZIYznFo3h-tTqdGffX33OEyrvvqZGZuYQfhbaemOywOdJ6DDgZNlvTgO9bZtEQJ
    N0dRqiuYPzbAPzRG8E>
X-ME-Received: <xmr:m5ZIY3aH2LY-I8P4dh-popf6JJ3gu_r_MoomsNGCDxhGBBefwC7VOROB5CQDvtPqZ5vQtj_MWm4eyzVKetsp2RQiozDbVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudeitd
    elueeijeefleffveelieefgfejjeeigeekudduteefkefffeethfdvjeevnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:m5ZIY2Udkd3B7khDjpO0vFcAs41_QxIf1zvziHSgSyONck-Ha8Toqg>
    <xmx:m5ZIY1kGkqJabq3I1weKmjKijpHFN5T7gS7HeW2Gu1mfmv05Lvd6Zg>
    <xmx:m5ZIYzdG0_JbEyVhciX6re_9FcM2RMojhLqMOyTAgUucgpYJQvPoZg>
    <xmx:nJZIY1uQ5sbmEwc7VI8jaeeXzLAFPWaLo7Fd98P_FvCM-HsXVpUemg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 18:52:11 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        'Filipe Manana ' <fdmanana@kernel.org>
Subject: [PATCH v2 0/2] btrfs: minor reclaim tuning
Date:   Thu, 13 Oct 2022 15:52:08 -0700
Message-Id: <cover.1665701210.git.boris@bur.io>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Two minor reclaim fixes that reduce relocations when they aren't quite
necessary. These are a basic first step in a broader effort to reduce
the alarmingly high rate of relocation we have observed in production
at Meta.

The first patch skips empty relocation.

The second patch skips relocation that no longer passes the reclaim
threshold check at reclaim time.

Changes in v2:
- added the re-check patch
- improved commit message and comment in the skip-empty patch.

Boris Burkov (2):
  btrfs: skip reclaim if block_group is empty
  btrfs: re-check reclaim condition in reclaim worker

 fs/btrfs/block-group.c | 83 +++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 25 deletions(-)

-- 
2.38.0


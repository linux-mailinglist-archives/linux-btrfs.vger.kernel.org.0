Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2F67BD59
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 21:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjAYUuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 15:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjAYUuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 15:50:39 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EE744A3
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 12:50:37 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D3ED95C02D8;
        Wed, 25 Jan 2023 15:50:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 25 Jan 2023 15:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1674679834; x=1674766234; bh=SvWYhtCQltmDjJ/7989Cs1uNT
        C2MUiKF9diYS8nxcNI=; b=i7PzPuJa5OLsWW0F9xSWDiwyD9Ld1W8EUozHK/WQH
        LN68JNxy3nhTqsTwdG80amtUdTb+Bx6ZK0VnGz4K2ihfMaokr4BsQM58gxFqtOJ+
        NJ0Mi5RNvREjGs+G1GvX4o4JLkjGbMqlnis7yiRPsayH4O9BTQj/8lu4SJ8l7DzQ
        CMlZVQmV4xgbYbjkqyJcgPM+1+GlU+SLJhl0cXFPAOt7NBXGswkFOS7Hl04GvB+5
        t4aa21NQX9ky4tgVopJJkfHelXumAsqLtPh9t2jAO7RAHvXxDqv5Cq9tCxXZ4CMn
        OK9dcMuR0isBh2x5pq/hns/FLyUcaxO+XY1tBz3o2CRBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1674679834; x=1674766234; bh=SvWYhtCQltmDjJ/7989Cs1uNTC2MUiKF9di
        YS8nxcNI=; b=QDb05kPLLe6DrtjPV7Q5hdjEGPRkB3MdMMcXEMTqr9gZhdr3Nx8
        dWwTE48qLrkk7WKat3RwmQnsdOT6Lq18kPKsxAe1xZS9qirB8jG7TvRFsA++WRwl
        WganhgWmPd1teXLCSFoLgTTLTP9P95GdFfIn1BUqHrPn7Z0u2zjqryNJaosBmXb8
        ZfuQnG2lR31r5w8keYTkDeu+NRyTPDUMfB5JYPVIct+kGWWoBCxnlkT8cfDBl4vw
        6Nj4xxb31Qb6x7FT4S9darx7oPGkxWEyBhodbxDm8W/IFQBNZb8DJN0rtVto+ne0
        m8yB6XxzAsAvVQ5g/dHo6ro+f1qNgASqQEg==
X-ME-Sender: <xms:GpbRY4p2hp3ScjR5tseMv5zAJLpABhMBDYgL0SgpLOOpd7G9BTNZ4w>
    <xme:GpbRY-qQ7hv2Q8TjYViWMSTQ8FW9mr5s91TgtsFnFcrMNDJSglJb9A5jQ22XA63v2
    RTRV8ot9boB83rHpC4>
X-ME-Received: <xmr:GpbRY9NH3rV9iXckoagEqerLMqKYBLE8jMa2U8_ScmttYxy0tckesc3J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:GpbRY_6Sk5kdhhPtQxBic8NZBG0UrQc8FpbxApXBa6NF0zrcjru7YQ>
    <xmx:GpbRY36OUfy2NvIIhWbcNn8Q5OfbxR7OpCO387hwMjwBfsZRmZNXUA>
    <xmx:GpbRY_h7zdUaWvtrPgVZeHAclImUSqBV8cKJrwC7p1mE6pR4wNyENQ>
    <xmx:GpbRY0hsDxf98LvYV8InwU0O5U9NK6R6jW4lRnngFfd2rWArlbHTVQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 15:50:34 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: block group size class load fixes
Date:   Wed, 25 Jan 2023 12:50:31 -0800
Message-Id: <cover.1674679476.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
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

The original size class loading logic was totally broken.

Patch 1 fixes it.
Patch 2 adds sysfs visibility to size classes so that we don't mess up
this badly in the future (and can test it in xfstests now).

Boris Burkov (2):
  btrfs: fix size class loading logic
  btrfs: add size class stats to sysfs

 fs/btrfs/block-group.c | 56 ++++++++++++++++++++++++++++--------------
 fs/btrfs/sysfs.c       | 39 +++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 19 deletions(-)

-- 
2.38.1


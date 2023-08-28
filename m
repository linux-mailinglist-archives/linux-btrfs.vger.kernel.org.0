Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98678A72C
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 10:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjH1IHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 04:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjH1IHR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 04:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9753DE58
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 01:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C2896332B
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39EAC433C7
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693210007;
        bh=WueG/Zd4SviETaiVGHMT5oraAxKonCbS/ijxKt784E0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MyuKyD1NI2rqB813rlxjOr0lvB8uTlRgxMBnkyittHgyvlzEnr6IDe29fmagK13oK
         77mm/fcZLqrG3SaBCMeo35DisKhyN/NfNKv121DZrcKZGC5Yu2Rf1FyWqRyh5s+dHZ
         Z+gkmjDzp5JsK0aUOlyUNcJ5UK4TGjeovMZGy0oqlmxApWJ/1lrDrAvVoO5ksXAXrn
         IjM20dqod2aW5akviuPL2IgN6FV6nX+3E8u7h5jemXhJ0rokvkOmJ4SPgHYbV0Dag+
         mK3vpf2xlH99n7OLU0/D1ogBAgpDKKLUofwZgrhmigNj7DkKiQab9t/vlcQYh731Di
         6KomVaFxFgP9g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: updates to error path for delayed dir index insertion failure
Date:   Mon, 28 Aug 2023 09:06:41 +0100
Message-Id: <cover.1693209858.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693207973.git.fdmanana@suse.com>
References: <cover.1693207973.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Some updates to the error path for delayed dir index insertion failure,
motivated by a recent syzbot report:

  https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0@google.com/

Details in the changelogs.

v2: Fixed error path in patch 2 to release delayed item before unlocking
    the delayed node. Added patch 3 to prevent such mistakes in the future.

Filipe Manana (3):
  btrfs: improve error message after failure to add delayed dir index item
  btrfs: remove BUG() after failure to insert delayed dir index item
  btrfs: assert delayed node locked when removing delayed item

 fs/btrfs/delayed-inode.c | 85 ++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 30 deletions(-)

-- 
2.40.1


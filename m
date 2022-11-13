Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D2627061
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 17:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiKMQJO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 11:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiKMQJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 11:09:12 -0500
X-Greylist: delayed 541 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Nov 2022 08:08:58 PST
Received: from mail.cardoe.co.uk (cardoe.plus.com [81.174.243.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAB5FACF
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 08:08:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.cardoe.co.uk (Postfix) with ESMTP id A1EE7560A00
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 15:59:55 +0000 (GMT)
Received: from mail.cardoe.co.uk ([127.0.0.1])
        by localhost (mail.cardoe.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YBuFBeilA-rh for <linux-btrfs@vger.kernel.org>;
        Sun, 13 Nov 2022 15:59:54 +0000 (GMT)
Received: from mail.cardoe.co.uk (localhost [IPv6:::1])
        by mail.cardoe.co.uk (Postfix) with ESMTPA id 466FB5602A5
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 15:59:54 +0000 (GMT)
Received: from 81.174.243.101
        (SquirrelMail authenticated user peter)
        by mail.cardoe.co.uk with HTTP;
        Sun, 13 Nov 2022 15:59:54 -0000
Message-ID: <bed2e743ab8c10619a81b42d54eb9e42.squirrel@mail.cardoe.co.uk>
Date:   Sun, 13 Nov 2022 15:59:54 -0000
Subject:  root item with a more recent gen
From:   "Peter Cardoe" <peter@cardoe.co.uk>
To:     linux-btrfs@vger.kernel.org
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



How can I fix the following error please:

btrfs check -b --repair /dev/sdb2

enabling repair mode

WARNING:

Do not use --repair unless you are advised to do so by a developer

or an experienced user, and then only after having accepted that no

fsck can successfully repair all types of filesystem corruption. Eg.

some software or hardware bugs can fatally damage a volume.

The operation will start in 10 seconds.

Use Ctrl-C to stop it.

10 9 8 7 6 5 4 3 2 1

Starting repair.

Opening filesystem to check...

Checking filesystem on /dev/sdb2

UUID: b5e07514-ad87-47ac-b4f7-3d797cb689bd

[1/7] checking root items

root 258 has a root item with a more recent gen (118911) compared to the
found root node (118707)

ERROR: failed to repair root items: Invalid argument



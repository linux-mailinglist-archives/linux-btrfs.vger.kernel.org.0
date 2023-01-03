Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D926C65CA87
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jan 2023 00:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjACXs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 18:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjACXsZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 18:48:25 -0500
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 15:48:23 PST
Received: from kyoto-arc.or.jp (ns.kyoto-arc.or.jp [202.252.247.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F531263E
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 15:48:23 -0800 (PST)
Received: from [192.168.2.58] ([202.252.247.10]:28013)
        by kyoto-arc.or.jp with [XMail 1.27 ESMTP Server]
        id <S16E905> for <linux-btrfs@vger.kernel.org> from <kengo@kyoto-arc.or.jp>;
        Wed, 4 Jan 2023 08:40:13 +0900
Mime-Version: 1.0
X-Sender: kengo@ms.kyoto-arc.or.jp
X-Mailer: QUALCOMM MacOS Classic Eudora Version 6J Jr6
Message-Id: <p0600100fdfda6d2d6124@kyoto-arc.or.jp>
Date:   Wed, 4 Jan 2023 08:40:10 +0900
To:     linux-btrfs@vger.kernel.org
From:   "Kengo.M" <kengo@kyoto-arc.or.jp>
Subject: Number of parity disks
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Folks

I use btrfs conveniently.

Let me ask a very very basic question.

One parity disk can be used in RAID 5 and 2 parity disks can be used in RAID 6.
ZFS RAIDZ-3 (raidz3) can use 3 parity disks.

Is it difficult to increase the number of parity disks to 4, 5 or more.
If so, is the reason for this because of the time it takes to 
generate the parity bits?

BRD

Kengo Miyahara




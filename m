Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E83B9A8E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 03:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhGBBc3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 21:32:29 -0400
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:51102 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234476AbhGBBc1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 21:32:27 -0400
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C18FE1E1C6C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jul 2021 01:29:55 +0000 (UTC)
Received: from mailgw-02.dd24.net (100-96-13-105.trex-nlb.outbound.svc.cluster.local [100.96.13.105])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id EE37C1E1AB8
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jul 2021 01:29:54 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from mailgw-02.dd24.net (mailgw-02.dd24.net [193.46.215.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.13.105 (trex/6.3.3);
        Fri, 02 Jul 2021 01:29:55 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authsender|calestyo@scientia.net
X-MailChannels-Auth-Id: instrampxe0y3a
X-Bubble-Trade: 600569481171997a_1625189395508_3239045516
X-MC-Loop-Signature: 1625189395508:3283094367
X-MC-Ingress-Time: 1625189395508
Received: from heisenberg.fritz.box (ppp-88-217-47-84.dynamic.mnet-online.de [88.217.47.84])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: calestyo@scientia.net)
        by smtp.dd24.net (Postfix) with ESMTPSA id 262C25FC25
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jul 2021 01:29:53 +0000 (UTC)
Message-ID: <d29726ca253ba1b8ff43ff00852347bd2c876b4d.camel@scientia.net>
Subject: auto-detect and set -o discard?
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 02 Jul 2021 03:29:52 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

Right now it seems, btrfs doesn't automatically set -o discard,
depending on whether or no a SSD is detected.

The FAQ entry https://btrfs.wiki.kernel.org/index.php/FAQ#Does_Btrfs_support_TRIM.2Fdiscard.3F
seems to imply that this was done because of several reasons:


- dm-crypt security issues
  => that should be a non-issue, because AFAIU, dm-crypt itself simply
     blocks any TRIM/discard, unless cryptsetup’s --allow-discards is
     specifically set when opening the device

- disputed performance benefits
  => Is this still questioned?
     I don't have any concrete benchmarks, but I mean using TRIM is
     what probably every SSD manufacturer suggests?


Another disadvantage of not auto-detecting this is that - with default
mount options (i.e. no discard) - VMs and the like, wont give back any
space in their storage images.


Cheers,
Chris


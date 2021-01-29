Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3344308D2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jan 2021 20:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhA2TLR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 14:11:17 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:26654 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232901AbhA2TKj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 14:10:39 -0500
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B59521842E7
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 19:09:52 +0000 (UTC)
Received: from mailgw-01.dd24.net (100-96-15-8.trex.outbound.svc.cluster.local [100.96.15.8])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9242D183BBE
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 19:09:51 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from mailgw-01.dd24.net (mailgw-01.dd24.net [193.46.215.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.15.8 (trex/6.0.2);
        Fri, 29 Jan 2021 19:09:52 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authsender|calestyo@scientia.net
X-MailChannels-Auth-Id: instrampxe0y3a
X-Blushing-Irritate: 005e438b3e7cc9e7_1611947392145_1860623970
X-MC-Loop-Signature: 1611947392145:662959848
X-MC-Ingress-Time: 1611947392144
Received: from heisenberg.scientia.net (p3e9c28cd.dip0.t-ipconnect.de [62.156.40.205])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: calestyo@scientia.net)
        by smtp.dd24.net (Postfix) with ESMTPSA id B1E635FC35
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 19:09:49 +0000 (UTC)
Message-ID: <157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net>
Subject: is back and forth incremental send/receive supported/stable?
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 29 Jan 2021 20:09:49 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

I regularly do the following with btrfs, which seems to work pretty
stable since years:
- having n+1 filesystems MASTER and COPY_n
- creating snapshots on MASTER, e.g. one each month
- incremental send/receive the new snapshot from MASTER to each of
  COPY_n (which already have the previous snapshot)


so for example:
- MASTER has
  - snapshot-2020-11/
  - snapshot-2020-12/
  and newly get's
  - snapshot-2021-01/
- each of COPY_n has only
  - snapshot-2020-11/
  - snapshot-2020-12(
- with:
  # btrfs send -p MASTER/snapshot-2020-12 MASTER/snapshot-2021-01  |  btrfs receive COPY_n/
  I incrementally send the new snapshot from MASTER to each of COPY_n
  using the already available previous snapshot as parent.

Works(TM)



Now I basically want to swap a MASTER with a COPY_n (e.g. because
MASTER's HDD has started to age).

So the plan is e.g.:
- COPY_1 becomes NEW_MASTER
- MASTER becomes OLD_MASTER later known NEW_COPY_1

a) Can I then start e.g. in February to incrementally send/receive from
NEW_MASTER back(!!) to OLD_MASTER?
Like:
# btrfs send -p NEW_MASTER/snapshot-2021-01 NEW_MASTER/snapshot-2021-02  |  btrfs receive OLD_MASTER/

b) And the same from NEW_MSTER to all the other COPY_n?
Like:
# btrfs send -p NEW_MASTER/snapshot-2021-01 NEW_MASTER/snapshot-2021-02  |  btrfs receive COPY_n


So in other words, does btrfs get, that the new parent (which is no
longer on the OLD_MASTER but the previous COPY_1, now NEW_MASTER) is
already present (and identical and usable) on the OLD_MASTER, now
NEW_COPY_1, and also on the other COPY_n ?


By the way, I'm talking about *precious* data, so I'd like to be really
sure that this works... and whether it's intended to work and ideally
have been tested.


Thanks,
Chris.


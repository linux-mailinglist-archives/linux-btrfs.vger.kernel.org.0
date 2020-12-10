Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCBF2D5092
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 03:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgLJB6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Dec 2020 20:58:22 -0500
Received: from mx.ewheeler.net ([173.205.220.69]:47437 "EHLO mail.ewheeler.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727423AbgLJB6U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Dec 2020 20:58:20 -0500
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 20:58:20 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.ewheeler.net (Postfix) with ESMTP id C4A8846
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 01:52:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mail.ewheeler.net ([127.0.0.1])
        by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id AXu8sw2E63Xh for <linux-btrfs@vger.kernel.org>;
        Thu, 10 Dec 2020 01:52:22 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ewheeler.net (Postfix) with ESMTPSA id F24083E
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 01:52:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ewheeler.net F24083E
Date:   Thu, 10 Dec 2020 01:52:19 +0000 (UTC)
From:   Eric Wheeler <btrfs@lists.ewheeler.net>
X-X-Sender: lists@pop.dreamhost.com
To:     linux-btrfs@vger.kernel.org
Subject: Global reserve ran out of space at 512MB, fails to rebalance
Message-ID: <alpine.LRH.2.21.2012100149160.15698@pop.dreamhost.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

We have a 30TB volume with lots of snapshots that is low on space and we 
are trying to rebalance.  Even if we don't rebalance, the space cleaner 
still fills up the Global reserve:

    Device size:                  30.00TiB
    Device allocated:             30.00TiB
    Device unallocated:            1.00GiB
    Device missing:                  0.00B
    Used:                         29.27TiB
    Free (estimated):            705.21GiB	(min: 704.71GiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
>>> Global reserve:              512.00MiB	(used: 512.00MiB) <<<<<<<

This was on a Linux 5.6 kernel.  I'm trying a Linux 5.9.13 kernel with a 
hacked in SZ_4G in place of the SZ_512MB and will report back when I learn 
more.

In the meantime, do you have any suggestions to work through the issue?

Thank you for your help!


--
Eric Wheeler

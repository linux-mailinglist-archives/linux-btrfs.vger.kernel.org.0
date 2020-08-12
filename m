Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29309242AB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 15:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHLN4v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 09:56:51 -0400
Received: from avasout02.plus.net ([212.159.14.17]:42937 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHLN4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 09:56:49 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 09:56:49 EDT
Received: from selket.lasermount.plus.com ([212.159.61.82])
        by smtp with ESMTP
        id 5r7zk6OaFU8Ck5r80kV3k3; Wed, 12 Aug 2020 14:49:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1597240157; bh=SIzspNJVM/JUydHQGMvTAIz661N5v/x1j+GK/bSlpCU=;
        h=Date:From:To:Subject;
        b=N7HC2ouZsVZZCgBp3Zx+xsEEE8OFcy/Xeo9l/mWD0ujXdVhJfEClmw819KVPXxHyC
         OvHk2S9ot0rs+RIKUrAx1LhAkGknDGrIDkSS0ZibUsi4ieV4vTMxDjnBOoJCqQaPFd
         peWgWDH4QMWqu2GbsXPR/iq1ksaQNqsdfj9ffphTYZMxQEEzjPmSKAgGKTTUS697g0
         ehUESxkoI0b5IAkdBIsf89BRcS1ueUH/RcfaXH/HbdMH0mmDOy6eyk9xVSrmPvtnK3
         t+h+bDltLdC2f7S6uNzG4lHVM0KaJSaNjik+DCG0Y8qe6xcVON6r4dbRuC4RBekQEw
         S+isLnXTBcVsg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=G/eH7+s5 c=1 sm=1 tr=0
 a=cA/d63+uTmAYrZgeUCdC6Q==:117 a=cA/d63+uTmAYrZgeUCdC6Q==:17
 a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=VwQbUJbxAAAA:8 a=IjB82fey2-iWFNeZbKUA:9
 a=CjuIK1q_8ugA:10 a=RMblk7DMegEA:10 a=AjGcO6oz07-iQ99wixmX:22
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by selket.lasermount.plus.com (Postfix) with ESMTP id A97778006C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 14:49:15 +0100 (BST)
Date:   Wed, 12 Aug 2020 14:49:15 +0100
From:   Spencer Collyer <spencer@lasermount.plus.com>
To:     linux-btrfs@vger.kernel.org
Subject: Write time tree block corruption detected
Message-ID: <20200812144915.488db4c7@lasermount.plus.com>
Organization: Lasermount Limited
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfESY83XTjMQTZMQ07gFx+DgSRGAQX8a9xOhpL84KCTYTy3ltGWCeA2M92AqTVeF8XrqPLyMQCXySk7EIr3M2c1HECHphrvQD/MrCrqrYiDliSYOH4hnD
 cnRnAVue4aA/zETjM41g8m5Hn8PP9tQOdfTqVlmoWjfunZV75yDVD5Ei1Lux2ar6lme2tT8Jnc1yy0PR1jXPRRefpEJSZilJp5g=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have just received a 'write time tree block corruption detected' message on a BTRFS fs I use. As per
https://btrfs.wiki.kernel.org/index.php/Tree-checker it mentions sending a mail to this mailing list for this case.

The dmesg output from the error onwards is as follows:

[17434.620469] BTRFS error (device dm-1): block=13642806624256 write time tree block corruption detected
[17435.048842] BTRFS: error (device dm-1) in btrfs_commit_transaction:2323: errno=-5 IO failure (Error while writing out transaction)
[17435.048848] BTRFS info (device dm-1): forced readonly
[17435.048851] BTRFS warning (device dm-1): Skipping commit of aborted transaction.
[17435.048853] BTRFS: error (device dm-1) in cleanup_transaction:1894: errno=-5 IO failure

As can be seen, the fs was forced into readonly mode. I restarted the box that the fs was mounted on and am able to write to the fs again (tried 'touch'ing a non-existent file and that worked), but I'm reluctant to do any more with it until I know it is safe to do so.

Is there anything I should do to ensure the fs is OK? The page I quoted earlier said not to run 'btrfs check --repair' unless told to by a developer.

Thanks for your attention.

Spencer

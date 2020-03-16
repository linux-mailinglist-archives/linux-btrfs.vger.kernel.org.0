Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82FF1863AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 04:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgCPDdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 23:33:16 -0400
Received: from mail.virtall.com ([46.4.129.203]:60804 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729383AbgCPDdQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 23:33:16 -0400
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 3E6F84090EEC
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Mar 2020 03:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1584329593; bh=nAhJfD9ooDPpETLkGY2643KtnhF42mUhpEIvicsq1Rc=;
        h=Date:From:To:Subject:In-Reply-To:References;
        b=pWPbyLi8iJyTX9kBzpA/3Bh6Zv3/du2ir1nOwma2Gaq9mu7M6KGB2jvAPko0g79Gr
         qk0NHeBmTsPYA0MjGxhhdoEDZeuinHrrQjWF6TMxksTnDerxA8rMdciWgNDRBUbeK1
         d+uX8NPs7RWBsPuK97Hi5iYU3iQSrRnmyrX9yEIQCdLTUnOfDceSv2iNK0za7fl/D1
         W0pairx4Y2NXqa/fEQ6IDOej7fDHsqzVmdtN7O6X6+E70sSR/TN+3YmkoK++LUg7FI
         hRMnRZYbHGbz7FVmKkgrqcW5BgVLeXx74b2ckFhg+R4fbyemkg9q5Ap+OTL/yBQKYS
         1s1W6bPDIbP+Q==
X-Fuglu-Suspect: 4c3ed368d5244df0baf90c574157af70
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Mar 2020 03:33:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Mar 2020 12:33:04 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: kernel panic after upgrading to Linux 5.5
In-Reply-To: <8374ca28bc970a51b3378a5a92939c01@wpkg.org>
References: <8374ca28bc970a51b3378a5a92939c01@wpkg.org>
Message-ID: <bf7cfe71f5217f39458540061ec86589@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-03-16 12:13, Tomasz Chmielewski wrote:
> After upgrading to Linux 5.5 (tried 5.5.6, 5.5.9, also 5.6.0-rc5), the
> system panics shortly after mounting and starting to use a btrfs
> filesystem. Here is a dmesg - please advise how to deal with it.
> It has since crashed several times, because of panic=10 parameter
> (system boots, runs for a while, crashes, boots again, and so on).

Additionally, I also see that btrfs quota was enabled:

> [  129.044896] CPU: 4 PID: 4476 Comm: btrfs-transacti Kdump: loaded
> Not tainted 5.6.0-050600rc5-generic #202003082130
> [  129.044897] Hardware name: GIGABYTE MZ31-AR0-00/MZ31-AR0-00, BIOS
> F03e 09/13/2017
> [  129.044941] RIP: 0010:btrfs_qgroup_account_extents+0x211/0x250 
> [btrfs]

How is that possible? I always make sure to disable btrfs quotas after 
creating a filesystem, and it was also the case here:

# history|grep quota
  4894  btrfs quota disable /data/lxd   # <------ long time ago, history 
at 4894, now history at >11207
11207  history|grep quota


The server does not seem to crash with quotas disabled (at least it's up 
for 30 mins now).


Now I've checked a couple of other servers, and on some of them, quota 
is also enabled (as verified with "btrfs quota rescan /data/lxd", which 
in not exiting with an error if the quotas are on - is there a better 
check to see if the quota is on or off?). That's not very encouraging 
that quota somehow enables itself.



Tomasz Chmielewski
https://lxadm.com

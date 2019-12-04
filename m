Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641F3112EF1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 16:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfLDPue convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 4 Dec 2019 10:50:34 -0500
Received: from [185.35.77.55] ([185.35.77.55]:34771 "EHLO mail.megacandy.net"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbfLDPue (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Dec 2019 10:50:34 -0500
Received: from [192.168.10.160] (26.51-174-238.customer.lyse.net [51.174.238.26])
        (Authenticated sender: gardv@megacandy.net)
        by mail.megacandy.net (Postfix) with ESMTPSA id B58C142BD04
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2019 15:50:32 +0000 (GMT)
From:   Gard Vaaler <gardv@megacandy.net>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Unrecoverable corruption after loss of cache
Date:   Wed, 4 Dec 2019 16:50:31 +0100
References: <7D7AA867-8B53-4CD5-83EF-95EABAD2A77C@megacandy.net>
To:     linux-btrfs@vger.kernel.org
In-Reply-To: <7D7AA867-8B53-4CD5-83EF-95EABAD2A77C@megacandy.net>
Message-Id: <F7C74BD8-4505-4E74-81F2-EB0D603ABCEC@megacandy.net>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> 1. des. 2019 kl. 18:27 skrev Gard Vaaler <gardv@megacandy.net>:
> 
> Trying to recover a filesystem that was corrupted by losing writes due to a failing caching device, I get the following error:
>> ERROR: child eb corrupted: parent bytenr=2529690976256 item=0 parent level=2 child level=0
> 
> Trying to zero the journal or reinitialising the extent tree yields the same error. Is there any way to recover the filesystem?

Update: using 5.4, btrfs claims to have zeroed the journal:

> [liveuser@localhost-live btrfs-progs-5.4]$ sudo ./btrfs rescue zero-log /dev/bcache0
> Clearing log on /dev/bcache0, previous log_root 2529694416896, level 0

... but still complains about the journal on mount:

> [  703.964344] BTRFS info (device bcache1): disk space caching is enabled
> [  703.964347] BTRFS info (device bcache1): has skinny extents
> [  704.215748] BTRFS error (device bcache1): parent transid verify failed on 2529691090944 wanted 319147 found 310171
> [  704.216131] BTRFS error (device bcache1): parent transid verify failed on 2529691090944 wanted 319147 found 314912
> [  704.216137] BTRFS error (device bcache1): failed to read block groups: -5
> [  704.227110] BTRFS error (device bcache1): open_ctree failed

-- 
Gard


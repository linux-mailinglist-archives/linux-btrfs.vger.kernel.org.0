Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A671BD03D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 00:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgD1W5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 18:57:18 -0400
Received: from relay-1.mailobj.net ([213.182.54.6]:36588 "EHLO
        relay-1.mailobj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgD1W5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 18:57:18 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2020 18:57:17 EDT
Received: from v-2c.localdomain (unknown [192.168.90.162])
        by relay-1.mailobj.net (Postfix) with SMTP id 315D012FA
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 00:49:40 +0200 (CEST)
Received: by mail-2.net-c.com [213.182.54.29] with ESMTP
        Wed, 29 Apr 2020 00:49:40 +0200 (CEST)
X-EA-Auth: /QXHFcSPzHTTYNAcRj/5Yk3srOlDbDG2PQhWa5Pa0W97jf+Obo9m8+keQ7KNvY3L/mgwz+FnPk4qoKQqoYbBNVOaVd1OqxPDZSVBdzxevLM=
To:     linux-btrfs@vger.kernel.org
From:   =?UTF-8?Q?Timoth=c3=a9e_Jourde?= <timjrd@netc.fr>
Subject: RAID1C3 across 3 devices but with only 2 online simultaneously
Message-ID: <d54b6655-db2d-ff35-8c73-92f282dc252e@netc.fr>
Date:   Wed, 29 Apr 2020 00:49:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everyone! I would like to use Btrfs' RAID in a somewhat unorthodox 
way, but if it's possible then it would be perfect for my use case.

Suppose I have a RAID1C3 filesystem spanning 3 hard drives A, B and C, 
each of the same size. A and B are at different physical locations after 
the initial mkfs.

When I want to make a backup, I would plug in drives C and A, and send 
them a snapshot. Once in a while, I would go to drive B's location 
carrying drive C with me, then I would plug in drives C and B, waiting 
for Btrfs to replicate the missing data on drive B.

It would be easier than sending the snapshots across 3 different 
filesystems, and most importantly, I could run a scrub with auto-repair 
on C+A or C+B.

I did some quick tests with 3 USB keys, and it *seems* to work. But I 
don't know how to be notified when the replication is done (which seems 
to run automatically/silently in the background). I also don't know 
whether it's a reliable method or not.

Any thoughts about this?

Thanks!
Timothée


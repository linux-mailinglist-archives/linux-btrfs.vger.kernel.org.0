Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD441F53D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgFJLwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 07:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgFJLwU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 07:52:20 -0400
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99193C03E96B
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jun 2020 04:52:19 -0700 (PDT)
Received: from smtp.soverin.net (unknown [10.10.3.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 4213C600F5
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jun 2020 11:52:18 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [159.69.232.138]) by soverin.net
MIME-Version: 1.0
Date:   Wed, 10 Jun 2020 13:52:17 +0200
From:   Jos van Roosmalen <btrfs@josr.eu>
To:     Linux btrfs <linux-btrfs@vger.kernel.org>
Subject: How to fix BTRFS transaction blocks while mounting BTRFS HDD
Message-ID: <ae1d96a0c94c7b149865afc0af8be52a@josr.eu>
X-Sender: btrfs@josr.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-Virus-Scanned: clamav-milter 0.102.3 at c03mi01
X-Virus-Status: Clean
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Since I upgraded to Ubuntu 20.04 LTS (Linux 5.4.0-37-generic) the 
mounting of a BTRFS HDD drive is hanging (never ends). In the syslog I 
get the following message.The mount keeps consuming CPU (few percent) 
and also a few "kworker/u8:<id>-btrfs-endio-meta" pop up.

My /etc/fstab contains:

UUID=262a8d86-279a-4f6b-8968-32e200c32255 /mnt/hdd btrfs 
autodefrag,space_cache=v2,compress=zlib 0 1

I ran already a btrfs check on /dev/sda but that reported no problems.

How can I fix this issue?

Syslog:

[ 1571.929999] INFO: task btrfs-transacti:1919 blocked for more than 
1087 seconds.
[ 1571.930013] Not tainted 5.4.0-37-generic #41-Ubuntu
[ 1571.930018] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1571.930025] btrfs-transacti D 0 1919 2 0x80004000
[ 1571.930031] Call Trace:
[ 1571.930043] __schedule+0x2e3/0x740
[ 1571.930048] schedule+0x42/0xb0
[ 1571.930103] btrfs_commit_transaction+0x879/0x960 [btrfs]
[ 1571.930110] ? wait_woken+0x80/0x80
[ 1571.930153] transaction_kthread+0x146/0x190 [btrfs]
[ 1571.930158] kthread+0x104/0x140
[ 1571.930195] ? btrfs_cleanup_transaction+0x530/0x530 [btrfs]
[ 1571.930199] ? kthread_park+0x90/0x90
[ 1571.930205] ret_from_fork+0x35/0x40




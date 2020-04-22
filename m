Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901C71B4ABB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDVQmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 12:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgDVQmj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 12:42:39 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31644C03C1A9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 09:42:39 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jRISK-0004b3-EB; Wed, 22 Apr 2020 18:42:36 +0200
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Subject: Recommended Partitioning & Subvolume Layout | Newbie Question
To:     linux-btrfs@vger.kernel.org
Message-ID: <03fdc397-4fca-335f-03d8-f93a96d92105@peter-speer.de>
Date:   Wed, 22 Apr 2020 18:42:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1587573759;ee95c399;
X-HE-SMSGID: 1jRISK-0004b3-EB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.
I wonder how to partition my Disks when I want to use btrfs in a RAID 1 
configuration.
I have /dev/sda1 and /dev/sdb1 for UEFI/ESP (no btrfs) and think about 
using just 1 more GPT-Partition on each disk /dev/sd[a|b]2 for btrfs. I 
am planing to create a btrfs-RAID 1 on those two partitions.


This is what the wiki says about partitioning:
> Do it the old fashioned way, and create a number of partitions according to your needs? Or create one big btrfs partition and use subvolumes where you would normally create different partitions?
> 
> What are the considerations for doing it either way?

My use case is a KVM Host running Arch Linux with 3-4 Virtual Machines. 
I want to have the ability to take snapshots when my system will be 
updated to restore a running system if something is broken by the 
update. I read about the mount option which disables CoW for database 
and VM images.

About the subvolume layout and partitioning I am unsure even I read the 
wiki. What do people familar with btrfs recommend for such setup?

Thanks,
Steffi

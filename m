Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278B21ABEC
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2019 13:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfELL1Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 12 May 2019 07:27:16 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.106]:29161 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfELL1Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 May 2019 07:27:16 -0400
Received: from [94.217.151.102] (helo=[192.168.177.20])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hPmdM-0005oZ-P3
        for linux-btrfs@vger.kernel.org; Sun, 12 May 2019 13:27:12 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Btrfs Samba and Quotas
Date:   Sun, 12 May 2019 11:27:00 +0000
Message-Id: <em396f5ac4-821b-44a0-883b-2755971d90c3@ryzen>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.34062.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: aGVuZHJpa0BmcmllZGVscy5uYW1l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I was wondering, whether anyone of you has experience with this samba in 
conjunction with BTRFS and quotas.

I am using Openmediavault (debian based NAS distribution), which is not 
actively supporting btrfs. It uses quotas by default, and I think, that 
me using btrfs is causing troubles...

In the logs I find:
May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for 
path [.]!
May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879166,  0] 
../source3/lib/sysquotas.c:461(sys_get_quota)
May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for 
path [.]!
May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879356,  0] 
../source3/lib/sysquotas.c:461(sys_get_quota)
May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for 
path [.]!
May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879688,  0] 
../source3/lib/sysquotas.c:461(sys_get_quota)
May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for 
path [Hendrik]!
May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879888,  0] 
../source3/lib/sysquotas.c:461(sys_get_quota)
May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for 
path [Hendrik]!
May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.880093,  0] 
../source3/lib/sysquotas.c:461(sys_get_quota)
May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for 
path [Hendrik]!
May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.880287,  0] 
../source3/lib/sysquotas.c:461(sys_get_quota)
May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for 
path [Hendrik]!

As you can see, this is quite frequent.

Searching for this, I find some bug-reports:
https://bugs.launchpad.net/ubuntu/+source/samba/+bug/1735953
https://bugzilla.samba.org/show_bug.cgi?id=10541

Now, I am sure that I am not the first to use Samba with btrfs. What's 
special about me? How's your experience?

Greetings,
Hendrik


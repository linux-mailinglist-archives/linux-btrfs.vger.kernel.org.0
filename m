Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 596DAAC064
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 21:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfIFTVf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 15:21:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbfIFTVe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Sep 2019 15:21:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99886307D923;
        Fri,  6 Sep 2019 19:21:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-49.rdu2.redhat.com [10.10.121.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C7525D712;
        Fri,  6 Sep 2019 19:21:34 +0000 (UTC)
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Jan Stancek <jstancek@redhat.com>
From:   Rachel Sibley <rasibley@redhat.com>
Subject: LTP fs_fill test results in BTRFS warning (device loop0): could not
 allocate space for a delete; will truncate on mount warnings
Message-ID: <4d97a9bb-864a-edd1-1aff-bdc9c8204100@redhat.com>
Date:   Fri, 6 Sep 2019 15:21:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 06 Sep 2019 19:21:34 +0000 (UTC)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

While running LTP [1] as part of CKI [2] testing, we noticed the fs_fill 
test fails pretty
consistently with BTRFS warnings seen below, this is seen with recent 
kernel (5.2.12).
I have included the logs below for reference.

Thank you,
Rachel

* 
https://artifacts.cki-project.org/pipelines/147783/logs/aarch64_host_1_console.log
8747.237733] LTP: starting fs_fill
[ 8748.085884] EXT4-fs (loop0): mounting ext2 file system using the ext4 
subsystem
[ 8748.103546] EXT4-fs (loop0): mounted filesystem without journal. 
Opts: (null)
[ 8751.856179] EXT4-fs (loop0): mounting ext3 file system using the ext4 
subsystem
[ 8751.882784] EXT4-fs (loop0): mounted filesystem with ordered data 
mode. Opts: (null)
[ 8759.496036] EXT4-fs (loop0): mounted filesystem with ordered data 
mode. Opts: (null)
[ 8768.360525] XFS (loop0): Mounting V5 Filesystem
[ 8768.368464] XFS (loop0): Ending clean mount
[ 8775.694012] XFS (loop0): Unmounting Filesystem
[ 8776.179816] BTRFS: device fsid 3f8f3f1f-6293-40c4-91f4-bfe1d5c4451d 
devid 1 transid 5 /dev/loop0
[ 8776.190118] BTRFS info (device loop0): disk space caching is enabled
[ 8776.195513] BTRFS info (device loop0): has skinny extents
[ 8776.200927] BTRFS info (device loop0): flagging fs with big metadata 
feature
[ 8776.212841] BTRFS info (device loop0): checking UUID tree
[ 9062.793701] BTRFS warning (device loop0): could not allocate space 
for a delete; will truncate on mount
[ 9062.794100] BTRFS warning (device loop0): could not allocate space 
for a delete; will truncate on mount
<snip>
[ 9062.794172] BTRFS warning (device loop0): could not allocate space 
for a delete; will truncate on mount

fs_fill log: https://paste.fedoraproject.org/paste/368EirX-AHSsZhG4Zutm2w

[1] https://github.com/linux-test-project/ltp
[2] https://cki-project.org/

<https://projects.engineering.redhat.com/secure/ViewProfile.jspa?name=jstancek>

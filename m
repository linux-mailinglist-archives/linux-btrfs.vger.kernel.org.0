Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08512CEF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 20:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfE1SsM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 14:48:12 -0400
Received: from patury.gsr.inpe.br ([150.163.73.148]:35768 "EHLO
        patury.gsr.inpe.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE1SsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 14:48:12 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2019 14:48:11 EDT
Received: from localhost (unknown [127.0.0.1])
        by patury.gsr.inpe.br (Postfix) with ESMTP id A581112051A
        for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2019 18:39:37 +0000 (UTC)
Received: from mail1.inpe.br ([127.0.0.1])
 by localhost (mail1.inpe.br [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 15162-09 for <linux-btrfs@vger.kernel.org>;
 Tue, 28 May 2019 15:39:36 -0300 (-03)
Received: from [150.163.28.183] (unknown [150.163.28.183])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by patury.gsr.inpe.br (Postfix) with ESMTPSA id 7C95B12051F
        for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2019 15:39:36 -0300 (-03)
From:   Cesar Strauss <cesar.strauss@inpe.br>
Subject: Unable to mount, corrupt leaf
To:     linux-btrfs@vger.kernel.org
Message-ID: <23b224cf-1e0f-267f-8fbb-74eaf2b6937a@inpe.br>
Date:   Tue, 28 May 2019 15:39:36 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Maia Mailguard 1.0.2c
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

After a BTRFS partition becoming read-only under use, it cannot be 
mounted anymore.

The output is:

# mount /dev/sdb5 /mnt/disk1
mount: /mnt/disk1: wrong fs type, bad option, bad superblock on 
/dev/sdb5, missing codepage or helper program, or other error.

Kernel output:
[ 2042.106654] BTRFS info (device sdb5): disk space caching is enabled
[ 2042.799537] BTRFS critical (device sdb5): corrupt leaf: root=2 
block=199940210688 slot=31, unexpected item end, have 268450090 expect 14634
[ 2042.807879] BTRFS critical (device sdb5): corrupt leaf: root=2 
block=199940210688 slot=31, unexpected item end, have 268450090 expect 14634
[ 2042.807947] BTRFS error (device sdb5): failed to read block groups: -5
[ 2042.832362] BTRFS error (device sdb5): open_ctree failed

# btrfs check /dev/sdb5
Opening filesystem to check...
incorrect offsets 14634 268450090
incorrect offsets 14634 268450090
incorrect offsets 14634 268450090
incorrect offsets 14634 268450090
ERROR: cannot open file system

Giving -s and -b options to "btrfs check" made no difference.

The usebackuproot mount option made no difference.

"btrfs restore" was successful in recovering most of the files, except 
for a couple instances of "Error copying data".

System information:

OS: Arch Linux

$ uname -a
Linux rescue 5.1.4-arch1-1-ARCH #1 SMP PREEMPT Wed May 22 08:06:56 UTC 
2019 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.1

I have since updated the kernel, with no difference:

$ uname -a
Linux rescue 5.1.5-arch1-2-ARCH #1 SMP PREEMPT Mon May 27 03:37:39 UTC 
2019 x86_64 GNU/Linux

Before making any recovery attempts, or even restoring from backup, I 
would like to ask for the best option to proceed.

Thanks,

Cesar

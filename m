Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F06444561E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 16:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhKDPRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 11:17:17 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:8098 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhKDPRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 11:17:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 7110C3FA5B;
        Thu,  4 Nov 2021 16:14:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -4.325
X-Spam-Level: 
X-Spam-Status: No, score=-4.325 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-2.426, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0j9bc1_CcL9p; Thu,  4 Nov 2021 16:14:33 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 393C43FA55;
        Thu,  4 Nov 2021 16:14:33 +0100 (CET)
Received: from [192.168.0.10] (port=61467)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mieRj-000Ff6-J1; Thu, 04 Nov 2021 16:14:32 +0100
Message-ID: <8479126f-c24d-4f2a-2ceb-2d71f063a294@tnonline.net>
Date:   Thu, 4 Nov 2021 16:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: Settings compression for a filesystem
Content-Language: en-GB
To:     linux-btrfs@vger.kernel.org
References: <11237766.pNdQY1Vl8f@ananda>
Cc:     Martin Steigerwald <martin@lichtvoll.de>
From:   Forza <forza@tnonline.net>
In-Reply-To: <11237766.pNdQY1Vl8f@ananda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




On 2021-11-04 15:56, Martin Steigerwald wrote:
> Hi!
> 
> I do have a bunch of BTRFS on LUKS backup disks. Plasma desktop mounts
> them unter /media… however, it does not mount with compression enabled.
> I do have some older backup disks which are in /etc/fstab including
> mount option "compress=zstd".
> 
> Is there any way to tell BTRFS to always use a certain compression
> algorithm for all newly written files (and of course existing files which
> use compression) without adding an entry in fstab for each disk?
> 
> I thought about
> 
> btrfs property set MOUNTPOINT compression zstd
> 
> but that sets the property just on the root inode of the mounted
> filesystem. Does it propagate? The manpage does not seem to have any
> information on that.
> 
> If not, well then I add the entries to fstab.
> 
> Thanks,
> 

You can use `btrfs property set <file> compression zstd`[1] on 
directories and files. This enables compression for any new writes to 
those directories and files. If you set compression on a directory, any 
new files and directories will inherit the property, while existing 
files and directories won't.

After mounting your disks you can use find to set compression recursively:

# find /media/btrfs/ -exec btrfs prop set {} compression zstd \;

This will enable the compresison flag, but not re-compress existing 
data. In order to recompress any existing data you have to rewrite it or 
use `btrfs filesystem defragment`[2] with the '-c' flag to compress the 
files, however this does not guarantee that all of the data will be 
recompressed.

In addition to btrfs propterty set, it is possible to use setfattr, 
chattr or mount options to set compression [3]

[1] https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-property
[2] 
https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-filesystem#SUBCOMMAND
[3] https://wiki.tnonline.net/w/Btrfs/Compression

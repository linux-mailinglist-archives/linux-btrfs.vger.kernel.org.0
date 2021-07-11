Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E613C3BED
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jul 2021 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhGKLjy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jul 2021 07:39:54 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:47212 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKLjy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jul 2021 07:39:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 20E763F401;
        Sun, 11 Jul 2021 13:37:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dLmbhJoTFouB; Sun, 11 Jul 2021 13:37:05 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 055C63F375;
        Sun, 11 Jul 2021 13:37:04 +0200 (CEST)
Received: from [192.168.0.10] (port=64411)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1m2Xlf-0002ao-MM; Sun, 11 Jul 2021 13:37:03 +0200
Subject: Re: btrfs cannot be mounted or checked
To:     Zhenyu Wu <wuzy001@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
From:   Forza <forza@tnonline.net>
Message-ID: <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net>
Date:   Sun, 11 Jul 2021 13:37:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-07-11 10:59, Zhenyu Wu wrote:
> Sorry for my disturbance.
> After a dirty reboot because of a computer crash, my btrfs partition
> cannot be mounted. The same thing happened before, but now `btrfs
> rescue zero-log` cannot work.
> ```
> $ uname -r
> 5.10.27-gentoo-x86_64
> $ btrfs rescue zero-log /dev/sda2
> Clearing log on /dev/sda2, previous log_root 0, level 0
> $ mount /dev/sda2 /mnt/gentoo
> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
> /dev/sda2, missing codepage or helper program, or other error.
> $ btrfs check /dev/sda2
> parent transid verify failed on 34308096 wanted 962175 found 961764
> parent transid verify failed on 34308096 wanted 962175 found 961764
> parent transid verify failed on 34308096 wanted 962175 found 961764
> Ignoring transid failure
> leaf parent key incorrect 34308096
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> $ dmesg 2>&1|tee dmesg.txt
> # see attachment
> ```
> Like `mount -o ro,usebackuproot` cannot work, too.
> 
> Thanks for any help!
> 


Hi!

Parent transid failed is hard to recover from, as mentioned on 
https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_a_.22parent_transid_verify_failed.22_error.3F

I see you have "corrupt 5" sectors in dmesg. Is your disk healthy? You 
can check with "smartctl -x /dev/sda" to determine the health.

One way of avoiding this error is to disable write-cache. Parent transid 
failed can happen when the disk re-orders writes in its write cache 
before flushing to disk. This violates barriers, but it is unfortately 
common. If you have a crash, SATA bus reset or other issues, unwritten 
content is lost. The problem here is the re-ordering. The superblock is 
written out before other metadata (which is now lost due to the crash).

You disable write cache with "hdparm -W0 /dev/sda". It might be worth 
adding this to a cron-job every 5 minutes or so, as the setting is not 
persistent and can get reset if the disk looses power, goes to sleep, etc.

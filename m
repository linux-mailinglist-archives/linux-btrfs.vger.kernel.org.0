Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF973CD453
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 14:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhGSLZm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 07:25:42 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:38742 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbhGSLZl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 07:25:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 9BEC03F707
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jul 2021 14:06:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9kLW4Uxvn8eQ for <linux-btrfs@vger.kernel.org>;
        Mon, 19 Jul 2021 14:06:18 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 8358E3F515
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jul 2021 14:06:18 +0200 (CEST)
Received: from [192.168.0.10] (port=62827)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1m5S23-000KbL-RJ
        for linux-btrfs@vger.kernel.org; Mon, 19 Jul 2021 14:06:14 +0200
Subject: Re: cannot use btrfs for nfs server
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
 <20210710065612.GF1548@tik.uni-stuttgart.de>
 <CAJCQCtQn0=8KiB=2garN8k2NRd1PO3HBnrMNvmqssSfKT2-UXQ@mail.gmail.com>
 <20210712072525.GI1548@tik.uni-stuttgart.de>
 <294e8449-383f-1c90-62be-fb618332862e@cobb.uk.net>
 <20210712161618.GA913@tik.uni-stuttgart.de>
 <8506b846-4c4d-6e8f-09ee-e0f2736aac4e@cobb.uk.net>
 <20210713073721.GA5047@tik.uni-stuttgart.de>
From:   Forza <forza@tnonline.net>
Message-ID: <2b53b9dd-4353-a73e-59b3-c87b6419ebf4@tnonline.net>
Date:   Mon, 19 Jul 2021 14:06:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210713073721.GA5047@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-07-13 09:37, Ulli Horlacher wrote:
> On Mon 2021-07-12 (23:56), g.btrfs@cobb.uk.net wrote:
> 
>>> root@tsmsrvj:/etc# du -Hs /nfs/localhost/snapshots
>>> du: WARNING: Circular directory structure.
>>> This almost certainly means that you have a corrupted file system.
>>> NOTIFY YOUR SYSTEM MANAGER.
>>> The following directory is part of the cycle:
>>>    /nfs/localhost/snapshots/spool
>>
>> Sure. But it makes the useful operations work. du, find, ls -R, etc all
>> work properly on /nfs/localhost/fex.
> 
> Properly on /nfs/localhost/fex : yes
> Properly on /nfs/localhost/snapshots : NO
> 
> And the error messages are annoying!
> 
> root@tsmsrvj:/etc# exportfs -v
> /data/fex       localhost.localdomain(rw,async,wdelay,crossmnt,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)
> /data/snapshots localhost.localdomain(rw,async,wdelay,crossmnt,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)
> 
> root@tsmsrvj:/etc# mount -o vers=3 localhost:/data/fex /nfs/localhost/fex
> root@tsmsrvj:/etc# mount -o vers=3 localhost:/data/snapshots /nfs/localhost/snapshots
> root@tsmsrvj:/etc# mount | grep localhost
> localhost:/data/fex on /nfs/localhost/fex type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1)
> localhost:/data/snapshots on /nfs/localhost/snapshots type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1)
> 

What kind of NFS server is this? Isn't UDP mounts legacy and not 
normally used by default?

Can you switch to an nfs4 server and try again? I also still think you 
should use fsid export option.



> root@tsmsrvj:/etc# ls -la /data/snapshots /nfs/localhost/snapshots
> /data/snapshots:
> total 16
> drwxr-xr-x 1 root root     20 Jul 13 09:19 .
> drwxr-xr-x 1 root root     24 Jul 12 17:42 ..
> drwxr-xr-x 1 fex  fex  261964 Mar  7 14:53 fex_1
> drwxr-xr-x 1 fex  fex  261964 Mar  7 14:53 fex_2
> 
> /nfs/localhost/snapshots:
> total 4
> drwxr-xr-x 1 root root     20 Jul 13 09:19 .
> drwxr-xr-x 4 root root   4096 Jul 12 17:49 ..
> drwxr-xr-x 1 fex  fex  261964 Mar  7 14:53 fex_1
> drwxr-xr-x 1 fex  fex  261964 Mar  7 14:53 fex_2
> 
> root@tsmsrvj:/etc# du -Hs /nfs/localhost/snapshots
> du: WARNING: Circular directory structure.
> This almost certainly means that you have a corrupted file system.
> NOTIFY YOUR SYSTEM MANAGER.
> The following directory is part of the cycle:
>    /nfs/localhost/snapshots/fex_1/XXXXXXXXXX@gmail.com
> 
> du: WARNING: Circular directory structure.
> This almost certainly means that you have a corrupted file system.
> NOTIFY YOUR SYSTEM MANAGER.
> The following directory is part of the cycle:
>    /nfs/localhost/snapshots/fex_2/XXXXXXXXXX@gmail.com
> 
> 25708064        /nfs/localhost/snapshots
> 
> root@tsmsrvj:/etc# du -Hs /data/snapshots
> 25712896        /data/snapshots
> 
> root@tsmsrvj:/etc# ls -R /nfs/localhost/snapshots | wc -l
> ls: /nfs/localhost/snapshots/fex_1/XXXXXXXXXX@gmail.com: not listing already-listed directory
> ls: /nfs/localhost/snapshots/fex_2/XXXXXXXXXX@gmail.com: not listing already-listed directory
> 128977
> 
> root@tsmsrvj:/etc# ls -R /data/snapshots | wc -l
> 129021
> 
> root@tsmsrvj:/etc# ls -aR /nfs/localhost/snapshots | wc -l
> ls: /nfs/localhost/snapshots/fex_1/XXXXXXXXXX@gmail.com: not listing already-listed directory
> ls: /nfs/localhost/snapshots/fex_2/XXXXXXXXXX@gmail.com: not listing already-listed directory
> 281357
> 
> root@tsmsrvj:/etc# ls -aR /data/snapshots | wc -l
> 281427
> 
> 
> 
> More debug info:
> 
> root@tsmsrvj:/data/snapshots# find . >/tmp/local.list
> 
> root@tsmsrvj:/nfs/localhost/snapshots# find . >/tmp/nfs.list
> find: File system loop detected; './fex_1/XXXXXXXXXX@gmail.com' is part of the same file system loop as '.'.
> find: File system loop detected; './fex_2/XXXXXXXXXX@gmail.com' is part of the same file system loop as '.'.
> 
> root@tsmsrvj:/nfs/localhost/snapshots# diff -u /tmp/local.list /tmp/nfs.list
> 
> --- /tmp/local.list	2021-07-13 09:25:36.388084331 +0200
> +++ /tmp/nfs.list	2021-07-13 09:26:02.120793230 +0200
> @@ -1,25 +1,5 @@
>   .
>   ./fex_1
> -./fex_1/XXXXXXXXXX@gmail.com
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/alist
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/filename
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/size
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/autodelete
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/keep
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/ip
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/uurl
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/useragent
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/header
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/dkey
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/speed
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/md5sum
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/download
> -./fex_1/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/error
> -./fex_1/XXXXXXXXXX@gmail.com/.log
> -./fex_1/XXXXXXXXXX@gmail.com/.log/fup
> -./fex_1/XXXXXXXXXX@gmail.com/.log/fop
>   ./fex_1/XXXXXXXXXX@web.de
>   ./fex_1/XXXXXXXXXX@web.de/@LOCALE
>   ./fex_1/XXXXXXXXXX@web.de/.log
> @@ -97976,26 +97956,6 @@
>   ./fex_1/.xkeys
>   ./fex_1/.snapshot
>   ./fex_2
> -./fex_2/XXXXXXXXXX@gmail.com
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/alist
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/filename
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/size
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/autodelete
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/keep
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/ip
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/uurl
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/useragent
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/header
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/dkey
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/speed
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/md5sum
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/download
> -./fex_2/XXXXXXXXXX@gmail.com/XXXXXXXXXX@pi2.uni-stuttgart.de/origin-8.5.1-SR2.zip/error
> -./fex_2/XXXXXXXXXX@gmail.com/.log
> -./fex_2/XXXXXXXXXX@gmail.com/.log/fup
> -./fex_2/XXXXXXXXXX@gmail.com/.log/fop
>   ./fex_2/XXXXXXXXXX@web.de
>   ./fex_2/XXXXXXXXXX@web.de/@LOCALE
>   ./fex_2/XXXXXXXXXX@web.de/.log
> 

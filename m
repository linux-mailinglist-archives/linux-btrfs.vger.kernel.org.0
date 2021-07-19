Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63373CD5C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbhGSMzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 08:55:11 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:45624 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbhGSMzL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 08:55:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 7FB763F6FA
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jul 2021 15:35:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TDT2-um4WekB for <linux-btrfs@vger.kernel.org>;
        Mon, 19 Jul 2021 15:35:48 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 43FC73F663
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jul 2021 15:35:48 +0200 (CEST)
Received: from [192.168.0.10] (port=61628)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1m5TQj-000NGn-9Y
        for linux-btrfs@vger.kernel.org; Mon, 19 Jul 2021 15:35:47 +0200
Subject: Re: cannot use btrfs for nfs server
From:   Forza <forza@tnonline.net>
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
 <2b53b9dd-4353-a73e-59b3-c87b6419ebf4@tnonline.net>
 <e3a24fc4-0aef-6977-248a-e967dad9954d@tnonline.net>
Message-ID: <de366aec-51bb-7c1e-1497-5afb332fdda2@tnonline.net>
Date:   Mon, 19 Jul 2021 15:35:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e3a24fc4-0aef-6977-248a-e967dad9954d@tnonline.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-07-19 15:07, Forza wrote:
> 
> 
> On 2021-07-19 14:06, Forza wrote:
>>
>>
>> On 2021-07-13 09:37, Ulli Horlacher wrote:
>>> On Mon 2021-07-12 (23:56), g.btrfs@cobb.uk.net wrote:
>>>
>>>>> root@tsmsrvj:/etc# du -Hs /nfs/localhost/snapshots
>>>>> du: WARNING: Circular directory structure.
>>>>> This almost certainly means that you have a corrupted file system.
>>>>> NOTIFY YOUR SYSTEM MANAGER.
>>>>> The following directory is part of the cycle:
>>>>>    /nfs/localhost/snapshots/spool
>>>>
>>>> Sure. But it makes the useful operations work. du, find, ls -R, etc all
>>>> work properly on /nfs/localhost/fex.
>>>
>>> Properly on /nfs/localhost/fex : yes
>>> Properly on /nfs/localhost/snapshots : NO
>>>
>>> And the error messages are annoying!
>>>
>>> root@tsmsrvj:/etc# exportfs -v
>>> /data/fex 
>>> localhost.localdomain(rw,async,wdelay,crossmnt,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash) 
>>>
>>> /data/snapshots 
>>> localhost.localdomain(rw,async,wdelay,crossmnt,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash) 
>>>
>>>
>>> root@tsmsrvj:/etc# mount -o vers=3 localhost:/data/fex 
>>> /nfs/localhost/fex
>>> root@tsmsrvj:/etc# mount -o vers=3 localhost:/data/snapshots 
>>> /nfs/localhost/snapshots
>>> root@tsmsrvj:/etc# mount | grep localhost
>>> localhost:/data/fex on /nfs/localhost/fex type nfs 
>>> (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1) 
>>>
>>> localhost:/data/snapshots on /nfs/localhost/snapshots type nfs 
>>> (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1) 
>>>
>>>
>>
>> What kind of NFS server is this? Isn't UDP mounts legacy and not 
>> normally used by default?
>>
>> Can you switch to an nfs4 server and try again? I also still think you 
>> should use fsid export option.
>>
>>
>>
> I'm replying to myself here because I booted up a VM with Fedora 34 and 
> tested a similar setup as Mr Horlacher's and can reproduce the errors.
> 
> Setup:
> 1) create a subvolume /mnt/rootvol/nfs
> 2) create some snapshots:
> btrfs sub snap /mnt/rootvol/nfs /mnt/rootvol/nfs/.snapshots/nfs-1
> btrfs sub snap /mnt/rootvol/nfs /mnt/rootvol/nfs/.snapshots/nfs-2
> 
> 3) export as:
> /mnt/rootvol/nfs/ *(fsid=1234,no_root_squash)
> 
> 4) mount -o vers=4 localhost:/mnt/rootvol/nfs /media/nfs-mnt/
> 5) "du -sh /media/nfs-mnt" fails with
> "WARNING: Circular directory structure."
> 
> 6) "ls -alR /mnt/nfs-mnt" fails with
> "not listing already-listed directory"
> 
> In addition I have tried with various export options such as crossmnt, 
> nohide and subtree_check. They do not improve the situation.
> 
> Also the behaviour is the same with nfs3 as with nfs4.
> 
> Full outputs are available at https://paste.ee/p/pkHLh

Perhaps the problem is that inode numbers are re-used inside snapshots 
and that nfsd doesn't understand how to handle this properly?

# ls -ila /media/nfs-mnt/
total 0
256 drwxr-xr-x. 1 root root 80 Jul 19 14:17 .
270 drwxr-xr-x. 1 root root 14 Jul 19 14:21 ..
259 -rw-r--r--. 1 root root  0 Jul 19 14:17 bar
261 -rw-r--r--. 1 root root  0 Jul 19 14:17 file1
262 -rw-r--r--. 1 root root  0 Jul 19 14:17 file2
263 -rw-r--r--. 1 root root  0 Jul 19 14:17 file3
258 -rw-r--r--. 1 root root  0 Jul 19 14:17 foo
257 drwxr-xr-x. 1 root root 30 Jul 19 15:02 .snapshots
260 -rw-r--r--. 1 root root  0 Jul 19 14:17 somefiles

# ls -ila /media/nfs-mnt/.snapshots/nfs-2/
total 0
256 drwxr-xr-x. 1 root root 80 Jul 19 14:17 .
257 drwxr-xr-x. 1 root root 30 Jul 19 15:02 ..
259 -rw-r--r--. 1 root root  0 Jul 19 14:17 bar
261 -rw-r--r--. 1 root root  0 Jul 19 14:17 file1
262 -rw-r--r--. 1 root root  0 Jul 19 14:17 file2
263 -rw-r--r--. 1 root root  0 Jul 19 14:17 file3
258 -rw-r--r--. 1 root root  0 Jul 19 14:17 foo
257 drwxr-xr-x. 1 root root 10 Jul 19 14:17 .snapshots
260 -rw-r--r--. 1 root root  0 Jul 19 14:17 somefiles


Using nfs4 exports and specifying each snapshot as its own fsid does not 
work either.

### /etc/exports
/mnt/rootvol/nfs/ *(fsid=root,no_root_squash,no_subtree_check)
/mnt/rootvol/nfs/.snapshots/nfs-1 
*(fsid=1000,no_root_squash,no_subtree_check)
/mnt/rootvol/nfs/.snapshots/nfs-2 
*(fsid=2000,no_root_squash,no_subtree_check)
/mnt/rootvol/nfs/.snapshots/nfs-3 
*(fsid=3000,no_root_squash,no_subtree_check)

# ls -laRi nfs-mnt/
nfs-mnt/:
total 0
256 drwxr-xr-x. 1 root root 80 Jul 19 14:17 .
270 drwxr-xr-x. 1 root root 14 Jul 19 14:21 ..
259 -rw-r--r--. 1 root root  0 Jul 19 14:17 bar
261 -rw-r--r--. 1 root root  0 Jul 19 14:17 file1
262 -rw-r--r--. 1 root root  0 Jul 19 14:17 file2
263 -rw-r--r--. 1 root root  0 Jul 19 14:17 file3
258 -rw-r--r--. 1 root root  0 Jul 19 14:17 foo
257 drwxr-xr-x. 1 root root 30 Jul 19 15:02 .snapshots
260 -rw-r--r--. 1 root root  0 Jul 19 14:17 somefiles

nfs-mnt/.snapshots:
total 0
257 drwxr-xr-x. 1 root root 30 Jul 19 15:02 .
256 drwxr-xr-x. 1 root root 80 Jul 19 14:17 ..
256 drwxr-xr-x. 1 root root 56 Jul 19 15:02 nfs-1
256 drwxr-xr-x. 1 root root 80 Jul 19 14:17 nfs-2
256 drwxr-xr-x. 1 root root 86 Jul 19 15:03 nfs-3
ls: nfs-mnt/.snapshots/nfs-1: not listing already-listed directory
ls: nfs-mnt/.snapshots/nfs-2: not listing already-listed directory
ls: nfs-mnt/.snapshots/nfs-3: not listing already-listed directory

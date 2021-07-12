Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE683C6690
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 00:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhGLW7v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 18:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGLW7u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 18:59:50 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D6C0613DD
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 15:56:58 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 5CA4F9C395; Mon, 12 Jul 2021 23:56:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1626130616;
        bh=kH3WqxHphIY/zPK/kWPZdzrPY51oxvf4RQQ08SIClyY=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=GfFRT/qgzcQil0m01G11TVU3VB+5I3LbySOw2OiMZ5Y/U4D11JKpYGjsf3Rxo/fd7
         0Y1T5Fr3E/nRDgq2bAO4l0Mi2O1dCtoL+MMg3BgsNp00zyP7XpyPJUxcdy26viyLC1
         2L1+4PxaAUJexPDg3Wzb9tPjlhZm09nT3wooNgntYlIFS8qtlMf3EduP+kSbGaGxKs
         xCrQgvuzeRhBgJCCHX+bJSZdTpwiMvmSxzw8Nz0EBdFTRf0V67hEuCJ8pQvRch0Mxh
         Y09kuy0cPoSLv/67u9Nn73B1GBvbQVCLrNF3Qk1379WkByrkyAGYCUH7kGaMs/cP0k
         Zws8yE9OptpZA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-4.5 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id AEB1F9BBB0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 23:56:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1626130615;
        bh=kH3WqxHphIY/zPK/kWPZdzrPY51oxvf4RQQ08SIClyY=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=SuBkaLK63LoZhIascILBFUFYnFXMxoYulfsdJBGYwSNCkC4C4rTB8rl2eLi1ZWQh/
         9E0Ey0al5/SeNTtkjROvd6ME4i5oClIM8bLTD3sbO4vgHXA32OAdeJyCduyNe/hIaa
         TSQnQGje2LUXsd3vixREodrBJClR898POmfplxkq+amP1KdZyqSNNK6+9LAZWPct1d
         699cu1O1lFaCcGTYvoZnslMzZCXou4v1+f4CjG+KXvLI86BIDWSQzN0PJTBxR2HUwV
         QcP9/kFp3D2T2+5Pj0Mmq7nQExMPF0v/kNG/zDhP+bkjfJVgd8JqI8ONg5w3xwEiP8
         C13UvcOWqsR3w==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 5BBDE26EE89
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 23:56:55 +0100 (BST)
From:   g.btrfs@cobb.uk.net
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
 <20210710065612.GF1548@tik.uni-stuttgart.de>
 <CAJCQCtQn0=8KiB=2garN8k2NRd1PO3HBnrMNvmqssSfKT2-UXQ@mail.gmail.com>
 <20210712072525.GI1548@tik.uni-stuttgart.de>
 <294e8449-383f-1c90-62be-fb618332862e@cobb.uk.net>
 <20210712161618.GA913@tik.uni-stuttgart.de>
Subject: Re: cannot use btrfs for nfs server
Message-ID: <8506b846-4c4d-6e8f-09ee-e0f2736aac4e@cobb.uk.net>
Date:   Mon, 12 Jul 2021 23:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712161618.GA913@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 12/07/2021 17:16, Ulli Horlacher wrote:
> On Mon 2021-07-12 (14:06), Graham Cobb wrote:
> 
>>>>> root@tsmsrvj:# snaprotate -v test 5 /data/fex/spool
>>>>> $ btrfs subvolume snapshot -r /data/fex/spool /data/fex/spool/.snapshot/2021-07-10_0849.test
>>>>> Create a readonly snapshot of '/data/fex/spool' in '/data/fex/spool/.snapshot/2021-07-10_0849.test'
>>>>
>>>> I think this might be the source of the problem. Nested snapshots are
>>>> not a good idea, it causes various kinds of confusion.
>>>
>>> I do not have nested snapshots anywhere.
>>> /data/fex/spool is not a snapshot.
>>
>> But it is the subvolume which is being snapshotted. What happens if you
>> put the snapshots somewhere that is not part of that subvolume? For
>> example, create /data/fex/snapshots, snapshot /data/fex/spool into a
>> snapshot in /data/fex/snapshots/spool/2021-07-10_0849.test, export
>> /data/fex/snapshots using NFS and mount /data/fex/snapshots on the client?
> 
> Same problem:
> 
> root@tsmsrvj:/etc# mount | grep data
> /dev/sdb1 on /data type btrfs (rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/)
> 
> root@tsmsrvj:/etc# mkdir /data/snapshots /nfs/localhost/snapshots
> 
> root@tsmsrvj:/etc# btrfs subvolume snapshot -r /data/fex/spool /data/snapshots/fex_1
> Create a readonly snapshot of '/data/fex/spool' in '/data/snapshots/fex_1'
> 
> root@tsmsrvj:/etc# btrfs subvolume snapshot -r /data/fex/spool /data/snapshots/fex_2
> Create a readonly snapshot of '/data/fex/spool' in '/data/snapshots/fex_2'
> 
> root@tsmsrvj:/etc# btrfs subvolume list /data
> ID 257 gen 1558 top level 5 path fex
> ID 270 gen 1557 top level 257 path fex/spool
> ID 272 gen 23 top level 270 path fex/spool/.snapshot/2021-03-07_1531.test
> ID 273 gen 25 top level 270 path fex/spool/.snapshot/2021-03-07_1532.test
> ID 274 gen 27 top level 270 path fex/spool/.snapshot/2021-03-07_1718.test
> ID 394 gen 1470 top level 270 path fex/spool/.snapshot/2021-07-10_0849.test
> ID 399 gen 1554 top level 270 path fex/spool/.snapshot/2021-07-12_1747.test
> ID 400 gen 1556 top level 5 path snapshots/fex_1
> ID 401 gen 1557 top level 5 path snapshots/fex_2
> 
> root@tsmsrvj:/etc# grep localhost /etc/exports 
> /data/fex       localhost(rw,async,no_subtree_check,no_root_squash,crossmnt)
> /data/snapshots localhost(rw,async,no_subtree_check,no_root_squash,crossmnt)
> 
> ## ==> no nested subvolumes! different nfs exports
> 
> root@tsmsrvj:/etc# mount -o vers=3 localhost:/data/fex /nfs/localhost/fex
> root@tsmsrvj:/etc# mount | grep localhost
> localhost:/data/fex on /nfs/localhost/fex type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1)
> 
> root@tsmsrvj:/etc# mount -o vers=3 localhost:/data/snapshots /nfs/localhost/snapshots
> root@tsmsrvj:/etc# mount | grep localhost
> localhost:/data/fex on /nfs/localhost/fex type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1)
> localhost:/data/fex on /nfs/localhost/snapshots type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1)
> 
> ## why localhost:/data/fex twice??
> 
> root@tsmsrvj:/etc# du -Hs /nfs/localhost/snapshots
> du: WARNING: Circular directory structure.
> This almost certainly means that you have a corrupted file system.
> NOTIFY YOUR SYSTEM MANAGER.
> The following directory is part of the cycle:
>   /nfs/localhost/snapshots/spool

Sure. But it makes the useful operations work. du, find, ls -R, etc all
work properly on /nfs/localhost/fex.

When I go looking in the snapshots I am generally looking for which
version of a particular file I need to restore. For example, maybe I
want to find an old version of /nfs/localhost/fex/spool/some/file. I
would then find the best snapshot to use with:

ls -l /nfs/localhost/fex_snapshots/spool_*/some/file

which might show something like:

-rw-r--r-- 1 cobb me 2.8K 2018-04-03
/nfs/localhost/fex_snapshots/spool_20210703/some/file
-rw-r--r-- 1 cobb me 7 2021-07-06
/nfs/localhost/fex_snapshots/spool_20210706/some/file
-rw-r--r-- 1 cobb me 25 2021-07-12
/nfs/localhost/fex_snapshots/spool_20210712/some/file

So I could tell I need to restore the version from spool_20210703 if I
need the one with the old data in it, which got lost a few days ago.

This is exactly how I use NFS to access my btrbk snapshots stored on the
backup server. Of course, if you need to restore a whole subvolume you
are better of using btrfs send/receive to bring the snapshot back,
instead of using NFS - that preserves the btrfs features like reflinks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA883FE655
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 02:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhIAXn0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 19:43:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:37057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232322AbhIAXnZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 19:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630539740;
        bh=96vOlkCW9QNgDMqC2Dc5+oiELutoTopvJA4CO4sU+Y8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VNJU4gnSQA6eFyrCQT046/16k/17VOFCdHg7OwBjxKi0mhe+Z8KQyp8qGHsNA8EcB
         Jm8/KpTlaSXVMX4SFk2nkj53MKUlBN5Ew4yBh9kgpH6waB5Hi9JaMtJ/d+n0IZTzkN
         r/oSPJRmacwIfwrdJQC+AZHM1uhmO3CTj1ScED38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1HZo-1mOJgv2LBS-002ltm; Thu, 02
 Sep 2021 01:42:20 +0200
Subject: Re: btrfs mount takes too long time
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        Anand Jain <anand.jain@oracle.com>
Cc:     Jingyun He <jingyun.ho@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
 <CAOE4rSx5+9jXEE2ra5qYOiZWpVU=EcB1MadEf_35fa0M3MZyiw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <620763f1-2ff5-6421-47cc-96d7cc94fb96@gmx.com>
Date:   Thu, 2 Sep 2021 07:42:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAOE4rSx5+9jXEE2ra5qYOiZWpVU=EcB1MadEf_35fa0M3MZyiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7PVTA20o8twjaK/iU5ly6sF73pjWsFDzGVQHBwnCUI9icZ2SlXQ
 6JSdxoB+F0lJRbV/kTACFrc0m+JAbGskxzHVMkEtNw6t8IrK84ooRvLnvQFgdClACo3ZtvT
 Vsiyjb/Ofo4Zs4nuBxwlSdEmxx+DW9DdkjvRukyQNcDIOOB7saRofjOes1kfxPDZomjNGbE
 ydtjYtTAZagjtZ/I+QbOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VmQGx90+mmY=:4TD9BbpzCPvEGt2DIKEVLM
 br06w/YaT1LgVLtAdAqAEpViHxqs3habOITGC/y3Ijm/z3KgdyTXZakSQG/cE7mJZ9f8dBwnE
 /2p8Dy585C3Es4GEg0Z/WX36xG64Ij/94cviZ7RXTYPADoqfinYfXxm0GCAxOJdOfr+y7Bw3x
 Z+DBZqQDWwoqtMDTp2lFLXgGqRb72vl9JxnTcN/TWTmHsm2tqvxHmW9gchBRY8CEGF1ZQ0E7K
 EkOx3vy2eLy1J8K4W3oKVVx27QZf6JMW7L9RQBWRYUk9G1YdZI2GasoMJJDt0xxn9zvfeW/zK
 89jJqNK9MtE9jJWk8qiURHersUPH6/1ZK2anAa9IiP5je39bhDtnCSnEvwGbECjyMCI7Vg1WU
 LhHn9H3AsCcMXnc4yQGFP5+D1wl4HJ1RDThB7eFw16raHbcUHXe0TxnrEFgWUi6XfGNUntL4Z
 uLZes1HNPKSGR4v/WXwOh9a6JHqV1K+zoKoII1Jidf+lh4egYFOSFPxp3hSJOyIvt5bOsJPvc
 RjGt4GwodsOmXqqLOZaALX4EufCFEcynb31Z/QU76pImF9HkjxwvLdx9BOpiOGDqXZ3gTbHlJ
 THddr9ag6oB0WfYpekdRPLKQq4IgEFFxhQmH7xztAErqljyb2yco4BobEjbP7NWwA6GCPEjG5
 GAHTGKFF0ZDq/kdw+9D9NjiKDt5XTdYLvmDQgnD8E9fbJM0Pk6cjfQrnLDooeZB5HiDI5UU9I
 qvAc16D2LoXChEQBCbScGqS8QgUhv+fDG3D/8rWBAZprMBxWbDxZEV19jqMyIyfe7Q9nnTcvy
 QMKo8WpgAqCC3Tkyi7J8qSvZuwzru+bZwSFc3IWKq2pTsBg0bqu7KEtmyXAodU4qz+F2lIkfW
 /aBqUw6BmDT6rQ3BnhBwZWn1Cx5L6MRVDoy8O9OMQDRtT1/z+FoEyAeYIGE3seSel9UDj4bUa
 3cUBncPByIdAWMP8i7z8E0wM5xFfBreyV/C/nkyyO/rk6287/MyjPq8buc3nYCFa8bErLMZxW
 EZuq8FJMPWH7oCSG9mErqdDShHPTTwzUHRjHlnQyP7E/junPWdrrIRtxmLKZBj/8bQbwCGFXH
 Cx9gOylnt4XgNoPJIvBCUgfssupDkEb2I/pNdQ/nA6IzITZYtmCMPnk7A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/2 =E4=B8=8A=E5=8D=8812:11, D=C4=81vis Mos=C4=81ns wrote:
> pirmd., 2021. g. 30. aug., plkst. 16:08 =E2=80=94 lietot=C4=81js Anand J=
ain
> (<anand.jain@oracle.com>) rakst=C4=ABja:
>>
>> open_ctree() took 228254398 us. And 98% of it that is 225418272 us
>> was taken by btrfs_read_block_groups().
>>
>> -------------------
>>    1) $ 225418272 us | } /* btrfs_read_block_groups [btrfs] */

As long as it's not zoned device, this is a known problem.

Block group items by its original design is scattered across the huge
extent tree.

Grabbing them all needs quite a lot of random IO, for large fs it's very
time consuming.

I have purposed a skinny bg tree design to put all block group items
into one tree, so that would greatly speed up the whole mount process.
And with user-space tool to do the convert.

But recently Josef is developing a completely new extent tree design,
which will include a similar design for it.

For know I'm not sure what's the way to go, either we can wait for
extent-tree-v2, or should we push for the middle ground skinny bg tree?

David, Any idea on this?

Thanks,
Qu
>>    1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
>>    0) 0.967 us | btrfs_apply_pending_changes [btrfs]();
>>    0) 0.239 us | btrfs_read_qgroup_config [btrfs]();
>>    0) * 21017.34 us | btrfs_get_root_ref [btrfs]();
>>    0) + 15.717 us | btrfs_start_pre_rw_mount [btrfs]();
>>    0) 0.865 us | btrfs_discard_resume [btrfs]();
>>    0) $ 228254398 us | } /* open_ctree [btrfs] */
>> -------------------
>>
>> Now we need to run the same thing on btrfs_read_block_groups(),
>> could you please run.. [1] (no need of the time).
>>
>> [1]
>>     $ umount /btrfs;
>>     $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount
>> /dev/vg/scratch0 /btrfs"
>>
>> Thanks, Anand
>>
>>
>
> Hi,
>
> I also have a btrfs filesystem that takes a while to mount.
> So I'm interested if this could be improved.
>
> $ ./ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/md127 -o
> space_cache=3Dv2,compress=3Dzstd,acl,subvol=3DData /mnt/Data/"
> kernel.ftrace_enabled =3D 1
>
> real    1m33,638s
> user    0m0,000s
> sys     0m1,130s
>
> Here's the trace output https://d=C4=81vis.lv/files/ftracegraph.out.gz
>
> The filesystem is on top of RAID6 mdadm array which is from 9x 3TB HDDs.
>
> Best regards,
> D=C4=81vis
>

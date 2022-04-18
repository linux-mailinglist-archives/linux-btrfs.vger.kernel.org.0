Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5DE504CD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 08:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiDRGrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 02:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiDRGrJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 02:47:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1807719005
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 23:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650264268;
        bh=HOFhnJG4UUxBvMzvjj5aQsv3WQYwIX3t3VYGEqjkoJE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=AAFJj937HiRKro8Yhjp10LraWPWIY9Im0qRjL/SlxmzaOqzP8WESZ0apdkmeK8hE4
         nWXX0hOcqk+67tI55dMPJPvubtKJqSjiWt/VAUWJ7urYmzGJZyzmIwarjuV/SKZ7nb
         kOZXQhO8bGRINIK5sbt4ECnLa+IzTF8KCawJfTbA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mz9Yv-1nu2WW39md-00wHIf; Mon, 18
 Apr 2022 08:44:28 +0200
Message-ID: <b8438797-164e-989a-6fad-5dc15568ecb8@gmx.com>
Date:   Mon, 18 Apr 2022 14:44:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] btrfs-progs: do not allow setting seed flag on fs with
 dirty log
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
 <988fb59d-da07-1419-cfe3-85a5ad0efbca@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <988fb59d-da07-1419-cfe3-85a5ad0efbca@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C8x9Vd0t3Qj0wOvrWE4AVTKo3B8EMMMc0h5JexK1ystHsyOvnpU
 1Y4zanihMVdChaFLCzH3xuqki9rPKUWPZ/JdRqwsP8qnIY4FWljRN5sblyKiGsI0Rr324pJ
 lEaA6e7Ij8X4Bl9jUWXePmrigPp3Z8d7dXlVWwK3rC6iLM3drA5tHROJqM/htD39QipnQze
 LsJJi5XCQD3Pp8GFYdk8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ytRrS2sOUe0=:JNOwC/xoy/t1CXbRl0QugT
 n4CoDWFizTtoRMPx1HxLxhO5chf6mrnwxLdT+zOPVBcvudckLmcRKKEt1mssJs7mx2utFjtP3
 bjC9W2JAXNN3KAbqnj/pcgYUAOslupOMDQgofhuOsVhgwL5UuWIksJt54WD/eE4P4QSDbX7RW
 5NkR3gwVM48DI6XDp556az+ndGDKt1zEWJKKgxM4GKny61AM1sdxi+WZNtdBVmVzPddDtyq+v
 sRYGUooonIh5p6noobf0IbgMN7QFDfhI019/hJiuaByTEta28MM0VCYIiXr2I31KsgMgAWd9U
 Pt29HVt5d6fwJvkD6Op+z0/Lg474S8C+/0O9XO+IiJIQD5GKQBWyAx8qAtmXDV/AuBCn01J/3
 6u4nlDtWIPMY7M9R0OZMAV2ccr5NpV7TykOrRZNEsv71xGWhxhp1b5kTIo9TUMcj0D76p7P+1
 vZZgJqcAxSPxJJq4RvRWCPN6mJxM1K4TRzTcYA1fFa3Ap5hkmyVVaDyyf5qBSdO7cDQyHuOgX
 BA5MhHT5EqdNF332GKNhZXbsMXCcYQjSC2PqtnYWpwl6yweKlUXUKOLI8CR4X7MzdzQXIKU0e
 wma7Sb/V+pYTeFQo33vAuQ3JgxFdz/6II3KWrt8PCkDOmKx7Po9zcuQvskYAYUtQJ0+igvCES
 45OoOkAsXlew1HWFe9Nw3FPeGNayj1pCfI56XTZUW5LB9vFFAVFwUgn+LbIKBdMqf/Hk3oWd7
 Tjbeep7IFDowge38kYXMli+erPqjUU6PgnSBNbkE5rUPbFGloB9uNj3tuAGxagC3r2p3Dh7zw
 vvqSuodyQdI6KzhthzHd5up3TYzh2ybvVTBNpLizoRrmyrjoSAPB8GTEJEqOyUttMY86mDfHS
 diKL8cXtPs7HFEbHuC6hdvTmu/l5fc2M+Q1xZJ6MsXUt33IXBhMGr0CbMt6v6zntnaL6Q7o/o
 11nBAvDB3QnUtPBKo8IMdC/cNorMc67w1samLamMKDPXA6yvhPQ+oAsj/1IQCySZntYCqjYCY
 bsCQjwq7jC37CceAdonAiDqwxcfcTv+5vzKStlqh4bpbjz0WGEJ3k6delZkDwQGL73VaPl3Bs
 j3qeThx+eY9M3k=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/18 14:41, Nikolay Borisov wrote:
>
>
> On 15.04.22 =D0=B3. 14:37 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> The following sequence operation can lead to a seed fs rejected by
>> kernel:
>>
>> =C2=A0 # Generate a fs with dirty log
>> =C2=A0 mkfs.btrfs -f $file
>> =C2=A0 mount $dev $mnt
>> =C2=A0 xfs_io -f -c "pwrite 0 16k" -c fsync $mnt/file
>> =C2=A0 cp $file $file.backup
>> =C2=A0 umount $mnt
>> =C2=A0 mv $file.backup $file
>>
>> =C2=A0 # now $file has dirty log, set seed flag on it
>> =C2=A0 btrfstune -S1 $file
>>
>> =C2=A0 # mount will fail
>> =C2=A0 mount $file $mnt
>>
>> The mount failure with the following dmesg:
>>
>> [=C2=A0 980.363667] loop0: detected capacity change from 0 to 262144
>> [=C2=A0 980.371177] BTRFS info (device loop0): flagging fs with big
>> metadata feature
>> [=C2=A0 980.372229] BTRFS info (device loop0): using free space tree
>> [=C2=A0 980.372639] BTRFS info (device loop0): has skinny extents
>> [=C2=A0 980.375075] BTRFS info (device loop0): start tree-log replay
>> [=C2=A0 980.375513] BTRFS warning (device loop0): log replay required o=
n RO
>> media
>> [=C2=A0 980.381652] BTRFS error (device loop0): open_ctree failed
>>
>> [CAUSE]
>> Although btrfs will replay its dirty log even with RO mount, but kernel
>> will treat seed device as RO device, and dirty log can not be replayed
>> on RO device.
>>
>> This rejection is already the better end, just imagine if we don't trea=
t
>> seed device as RO, and replayed the dirty log.
>> The filesystem relying on the seed device will be completely screwed up=
.
>>
>> [FIX]
>> Just add extra check on log tree in btrfstune to reject setting seed
>> flag on filesystems with dirty log.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> LGTM:
>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>
> One minor nit below but it can be rectified by David at merge time. Why
> don't you also add a btrfs-progs test for this functionality.

The major concern is, I'm using a very ugly way to create a dirty journal.

But I'm not sure if btrfs-progs really wants a complicated dm based
solution to do the same thing.

Or maybe I can just use an raw image for that?

Thanks,
Qu

>
>> ---
>> =C2=A0 btrfstune.c | 4 ++++
>> =C2=A0 1 file changed, 4 insertions(+)
>>
>> diff --git a/btrfstune.c b/btrfstune.c
>> index 33c83bf16291..7e4ad30a1cbd 100644
>> --- a/btrfstune.c
>> +++ b/btrfstune.c
>> @@ -59,6 +59,10 @@ static int update_seeding_flag(struct btrfs_root
>> *root, int set_flag)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 device);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_super_log_root(di=
sk_super)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or("this filesystem has dirty log, can not set seed
>> flag");
>
>
> nit: I'd probably put something less colloquial such as:
>
> "Filesystem with dirty log detected, not setting seed flag" >
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super_flags |=3D=
 BTRFS_SUPER_FLAG_SEEDING;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(super_flag=
s & BTRFS_SUPER_FLAG_SEEDING)) {

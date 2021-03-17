Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF57533EE4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 11:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCQK3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 06:29:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:58209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhCQK3F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 06:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615976936;
        bh=ESw9LlR3qSYW6UltSNCieXZtuzO579BktbQf27g6RKQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cCqz6x4kMBz2/T0jFhtpzs4cByOxv46zo0nO6lU/5uGinyJ00EXV5tdXJp2liZ2Lx
         de3GhzuqNLM1r25D3E+DzOWH0TEHOPHI/2jD0KtytfiRWcPfr3bjxltjmW8BPE57Pj
         Mjuaipadk7n7qQUcwFy4m7UnM0i+rdkPgsAJKj1o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQkK-1lZRrz1fHM-00vPas; Wed, 17
 Mar 2021 11:28:56 +0100
Subject: Re: [RFC] btrfs: Allow read-only mount with corrupted extent tree
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210317012054.238334-1-davispuh@gmail.com>
 <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <20a5d997-740a-ca57-8cbc-b88c1e34c8fc@gmx.com>
Date:   Wed, 17 Mar 2021 18:28:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LCN+xGUWfoSOSEjoWNcx10tO+H4nL47zMgiZSPoxNcJ5b7ORYK6
 dczjrAJ7X9JlKEhDaS7UxKnpHOp8O+NXKnFnNx6C6YeH58tZYPEHtjTM4UGFU40qgaM3wEC
 52q6HNGazecr1a5bD1xRKrIDpG5HCzHmGUB9eQkCAEbaC23OTtZco4YzdWfer3I+sstyFkD
 YWn77l1R4zgqMxiS/FQ3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fl4wdWFfAjI=:YJ1sCgTXEsnBHER4hT1EsM
 /HZHdUtm0SdqJ6dMRqv1ESYbXswN6DgFbFJbBGFRR6DYvu1EoCTm/VX/1a0MPrDrUwdzqNaww
 M+/qFwL5HLogq2cHWaEjDQOyVVAyKEnkk4oPDK87LCLy29P4WiUIWsAE6OflTIshOd1feFpWZ
 EPlaavCvQB2apzLhjb01Uh1UfRWAw0mdRLlGQJ1rNyK2g1q+EcPmdBLHJJIY0n3ynboeLVehX
 AXxAaDjniPGhUTEPcwdhMSuxeilBOLWwATjKhPqVJ/uxjroxIw4L9xczyfCuvinLw+zlGLGg8
 dQVeCvaJr3qnbYgnWXYLkk9TwRO1ftxYgb8HO7n602aSZztZA3Gckrg2n9neNar3Pud+PavfX
 qImvq1Gg73DCEIPiwnd/lgpTFj+arnyUL9Dm0SsMN8wS6UBXQjBn5pd6kbYbJrz20T7QDJjZP
 hYlbN0T2OvUQiTBRSMqtawVhOmg1knF7R7c7dO0/L+L9AWLprzMkH8qWxv1yxxNhS7Y3/k4ve
 9kvu5CY4hYLKvUDopqxKOcDEnBkPQyPKaOFVdkiWOiQR/JTOydT6LYsi1EG1Ck9e3uYrBi374
 z1XYcBD5Nzyp7Z3HdaLb8tL0oUV8/1IBiIjt0FOCTf896ebPDVK01wFcqlZjAtcXHKoezYCpr
 tQOSxpNCNS6RXLSiRRdnCFmRvozDlUwfdyJ05bJBJ0uRcCmiTpRBVoGfHn6lga+W9bl/iQuc9
 KrD24SmFzfnGDhQnM2vHsABd/MpI87VKJXtM32yL6VK8dVZsOKJ9WiWtDjL06yNOE1+N1l8gJ
 WMT9kfPK/QuQb0wuf1/M+TW9ejwLEleQG6HHZF0AJQ+mv7/Pcmiy962dPIHytwG7vlNUkQ3yw
 VbJ08QLTh/8Cq9JlkWuQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/17 =E4=B8=8A=E5=8D=889:29, D=C4=81vis Mos=C4=81ns wrote:
> tre=C5=A1d., 2021. g. 17. marts, plkst. 03:18 =E2=80=94 lietot=C4=81js D=
=C4=81vis Mos=C4=81ns
> (<davispuh@gmail.com>) rakst=C4=ABja:
>>
>> Currently if there's any corruption at all in extent tree
>> (eg. even single bit) then mounting will fail with:
>> "failed to read block groups: -5" (-EIO)
>> It happens because we immediately abort on first error when
>> searching in extent tree for block groups.
>>
>> Now with this patch if `ignorebadroots` option is specified
>> then we handle such case and continue by removing already
>> created block groups and creating dummy block groups.
>>
>> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
>> ---
>>   fs/btrfs/block-group.c | 14 ++++++++++++++
>>   fs/btrfs/disk-io.c     |  4 ++--
>>   fs/btrfs/disk-io.h     |  2 ++
>>   3 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 48ebc106a606..827a977614b3 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct btrfs_fs_info=
 *info)
>>          ret =3D check_chunk_block_group_mappings(info);
>>   error:
>>          btrfs_free_path(path);
>> +
>> +       if (ret =3D=3D -EIO && btrfs_test_opt(info, IGNOREBADROOTS)) {
>> +               btrfs_put_block_group_cache(info);
>> +               btrfs_stop_all_workers(info);
>> +               btrfs_free_block_groups(info);
>> +               ret =3D btrfs_init_workqueues(info, NULL);
>> +               if (ret)
>> +                       return ret;
>> +               ret =3D btrfs_init_space_info(info);
>> +               if (ret)
>> +                       return ret;
>> +               return fill_dummy_bgs(info);

When we hit bad things in extent tree, we should ensure we're mounting
the fs RO, or we can't continue.

And we should also refuse to mount back to RW if we hit such case, so
that we don't need anything complex, just ignore the whole extent tree
and create the dummy block groups.

>
> This isn't that nice, but I don't really know how to properly clean up
> everything related to already created block groups so this was easiest
> way. It seems to work fine.
> But looks like need to do something about replay log aswell because if
> it's not disabled then it fails with:
>
> [ 1397.246869] BTRFS info (device sde): start tree-log replay
> [ 1398.218685] BTRFS warning (device sde): sde checksum verify failed
> on 21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
> [ 1398.218803] BTRFS warning (device sde): sde checksum verify failed
> on 21057127661568 wanted 0xd1506ed9 found 0x7dd54bb9 level 0
> [ 1398.218813] BTRFS: error (device sde) in __btrfs_free_extent:3054:
> errno=3D-5 IO failure
> [ 1398.218828] BTRFS: error (device sde) in
> btrfs_run_delayed_refs:2124: errno=3D-5 IO failure
> [ 1398.219002] BTRFS: error (device sde) in btrfs_replay_log:2254:
> errno=3D-5 IO failure (Failed to recover log tree)
> [ 1398.229048] BTRFS error (device sde): open_ctree failed

This is because we shouldn't allow to do anything write to the fs if we
have anything wrong in extent tree.

Thanks,
Qu
>
> Ideally it should replay everything except extent refs. >
>
> I also noticed that after unmount there is:
>
> [11000.562504] BTRFS warning (device sde): page private not zero on
> page 21057098481664
> [11000.562510] BTRFS warning (device sde): page private not zero on
> page 21057098485760
>
> not sure what it means.
>
>
> Best regards,
> D=C4=81vis
>

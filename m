Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE065F7367
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 05:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJGDkj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 23:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJGDkh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 23:40:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBCEA2213
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 20:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665114019;
        bh=zRSKYX54bGq/ZHfG6UUlZYo0vp0bfrFlbPnFIA5qTTw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=LCW6NkVb0n7sTYIoURpM80cKquqpChw8fSR33++jJHlsRhG/CiFEZWzqQujYscU2M
         F4dRJcq9Q57PpoXqy6wSK0eSi24wE1S/6q0s/DOEFSwoWyZr1H8NQomO0EQCPwppG/
         fAo3gCZyr6w/zW+a9rZ9ddhsha7xyRWAhcFHFVrI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEUz4-1oQhmS3eyg-00Fx03; Fri, 07
 Oct 2022 05:40:19 +0200
Message-ID: <90343ff8-6545-4573-e563-9737c640fdfc@gmx.com>
Date:   Fri, 7 Oct 2022 11:40:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] btrfs: 1G falloc extents
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Wang Yugui <wangyugui@e16-tech.com>, Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@kernel.org>
References: <cover.1664999303.git.boris@bur.io>
 <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
 <20221007112306.F62D.409509F4@e16-tech.com>
 <d52b0916-66a9-e0a7-a299-93df7c90cc4b@gmx.com>
In-Reply-To: <d52b0916-66a9-e0a7-a299-93df7c90cc4b@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lc5s9IJReG65jtD+Uyn33FLNUD7vIAnVAOs5JcpxuVMr03VPwtM
 mD8axixHQ/a8Ic1BG1gArmex1/c+WRTVcST8+hnL+8d2Ft2UzjL1zJpCrU2sur387c+RxbQ
 PgFHP2Y6i8V2ZwWKWhe2aepm/t2pSbbYrGyw36rEQGq/TdS5VQuP3AXiiOGEdvC1zoL4PrM
 ce9+9UT7CX3SCff0Dcg5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WG//ojSC/MM=:k5jI7yqR4rZ4cWts3auSwP
 KFfGMTvsWLWpJBWrEiZGncesI3BAZSihf6Q1Cq5lqp4eWhjUrY2gX5dbHbZstSUlvwxaIItSg
 feayScxLtB1VnBnzWINJdO8oh0x4AA5vCJoJiPszdMDqRvFGC92YnJsq1QOFVFxQlYNPeoPLC
 bFN8FImjqxn/zj/M/4XqPxvWvkvZ9jDFSbjMSD5R2IcGjdLkn8qZkgM515D0GE0HQG0GH0gXy
 Fd3ixlhYqFu/YBGn1EbL5/19bihmggqSJ0PtPKNdykJ8PEGQVR42fS9jIrEKChdv7XcUO+dPf
 xwhrv/kTCvoRkxfxrXsFUvd1qkeqDfZQN7Xk0e8lRhMJhNniEtdRbBwj7GGm2zHUlx2PsiZyb
 4LxlGxwzGCRlcn45yZpozqMO9zQHeavEX38S0P3Q6tP2bgIfjxpWGJ33o/44QJXWQ74Eo15sY
 B2dYk3xPnrrMat2YTZMY5dx6xOwqeiyHT7XRVnfJrGguvYzkws3JYrT6V6ZhMWlvvsqRzHyiQ
 Ktu7nwoagSkBj/eT9nnyP3qdeHqgOVXBxto2XxKVZ/oGUZN2C2QCtUtfRkNGB6AWlPDY4Am7S
 VayIP9TWdC/cLlzfpyyiH+q/pOv/YA1Y8TZ9r35YsyO+Gr8imgR/0Fp5H5PLOD1AV793lQ4+f
 wpqSHI6maUATVqWqd7xzgbCmL9kyw0nX+6YfYjfq5YM3uYXdU1lcmaTJ7J7RycQkeGfRvFbBs
 S3lg0eFFNuH98wT6uedP18BDZU8dkp5Joj2IkZJ7Zmyg5n5BrwzkayGrZ5DsZ4Gp2otgCCexO
 rLO7OSkTOlShpzDshhm9uk49DPGI8LAjDcZhlY77ktyOt4i8AIhXCPAUgqdeXeiYnPzfFFArM
 SHWLVatz7ujBOm5AVFViBTyKh3E7URUQ8l6vBCDtV+GiN+gC5DtB+RI6B4MfWmm9S7tQ8T1Gi
 HT5NJRpAGJPK1qQoY0dSwEIIiEoY/995eR5BIhC9hZAm1ayADPbX5imSa3uH2YXppsfE9Wpji
 rDgFK2E4e9ije+5m1qerj1ZGg02rxs8M4TY/FJrV46/pfslJXJS3u/NjVvE5ywt5tocOI24Xy
 +8Igv+DjzUBOrU6Fbq6D573KP9zpY+gewN0Y9tbcUtTBuTOPPEYoj1jFDOuaXjDfhVcMX1c5a
 Sjb93riKroilLslcEywXBPYE7/NNnkqKWOmztItR3cJAjeIcnzIlZclog6HLl0p+zph1V7bhn
 fnsHsMzHeIkkFjgVZ0eYvH0Nxu2iLUgU4RvCSi1RoNtUgZQauV92NO5XFCEGd1iXQnVcZNCpF
 nP7GCHhBpvy7v1Zn/Z78kNK/OtX2qgEZZLpNnscYKpmgQYikJXP9WQ3Z2DMvlETlX8cn4n96i
 w/K8T5PRE324qsbtECwE/LBcIfURXmTgdw24h0oZlKPxzOpZCcdqCHbestWXktObBmUl5aoVh
 QrIyQX956RCRiUCs1ZrMxkn3NQH3vuSB0s4wVSlr52kkAto9f6D9N+WRazpcy06y18DFZnT4k
 MR9zJ+/9HfwtyweqrEnZRaY1OYFEQTvq9BBXXMksRbdsk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/7 11:29, Qu Wenruo wrote:
>
>
> On 2022/10/7 11:23, Wang Yugui wrote:
>> Hi,
>>
>>> When doing a large fallocate, btrfs will break it up into 256MiB
>>> extents. Our data block groups are 1GiB, so a more natural maximum siz=
e
>>> is 1GiB, so that we tend to allocate and fully use block groups rather
>>> than fragmenting the file around.
>>>
>>> This is especially useful if large fallocates tend to be for "round"
>>> amounts, which strikes me as a reasonable assumption.
>>>
>>> While moving to size classes reduces the value of this change, it is
>>> also good to compare potential allocator algorithms against just 1G
>>> extents.
>>
>>
>> I wrote a 32G file, and the compare the result of 'xfs_io -c fiemap'.
>>
>> dd conv=3Dfsync bs=3D1024K count=3D32K if=3D/dev/zero of=3D/mnt/test/dd=
.txt
>>
>> When write to a btrfs filesystem
>> + xfs_io -c fiemap /mnt/test/dd.txt
>> /mnt/test/dd.txt:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0: [0..262143]: 688358=
4..7145727
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: [262144..524287]: 6=
367232..6629375
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2: [524288..8126463]: =
7145728..14747903
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3: [8126464..8388607]:=
 15272064..15534207
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4: [8388608..8650751]:=
 14755840..15017983
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5: [8650752..16252927]=
: 15534208..23136383
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6: [16252928..67108863=
]: 23144448..74000383
>>
>> When write to a xfs filesystem
>> + xfs_io -c fiemap /mnt/test/dd.txt
>> /mnt/test/dd.txt:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0: [0..16465919]: 256.=
.16466175
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: [16465920..31821623=
]: 16466176..31821879
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2: [31821624..41942903=
]: 31821880..41943159
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3: [41942904..58720111=
]: 47183872..63961079
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4: [58720112..67108863=
]: 63961080..72349831
>
> Don't waste your time on fiemap output. Btrfs can do merge fie result at
> write time.

s/write/fiemap emit/

>
> # dd if=3D/dev/zero=C2=A0 bs=3D4k count=3D1024 oflag=3Dsync of=3D/mnt/bt=
rfs/file
>
> Above command should result all file extents to be 4K, and can be easily
> verified through dump tree.
>
>  =C2=A0=C2=A0=C2=A0=C2=A0item 197 key (258 EXTENT_DATA 4186112) itemoff =
5789 itemsize 53
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 8 type 1 (regular=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data disk byte 220119=
04 nr 4096
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data offset 0 nr 4096=
 ram 4096
>
> But fiemap will only report one single extent:
>
> # xfs_io -c "fiemap -v" /mnt/btrfs/file
> /mnt/btrfs/file:
>  =C2=A0EXT: FILE-OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK-RANGE=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 TOTAL FLAGS
>  =C2=A0=C2=A0 0: [0..8191]:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 34816..4=
3007=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8192=C2=A0=C2=A0 0x1
>
>>
>> the max of xfs is about 8G, but the max of btrfs is
>> about 25G('6: [16252928..67108863]'?
>>
>> Best Regards
>> Wang Yugui (wangyugui@e16-tech.com)
>> 2022/10/07
>>
>>
>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>> =C2=A0 fs/btrfs/inode.c | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 45ebef8d3ea8..fd66586ae2fc 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct
>>> inode *inode, int mode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (trans)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 own_trans =3D f=
alse;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (num_bytes > 0) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_bytes =3D min_t(u64, n=
um_bytes, SZ_256M);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_bytes =3D min_t(u64, n=
um_bytes, SZ_1G);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_bytes =3D m=
ax(cur_bytes, min_size);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we a=
re severely fragmented we could end up with really
>>> --
>>> 2.37.2
>>
>>

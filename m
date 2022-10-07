Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF35F7362
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 05:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJGDaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 23:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJGDaN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 23:30:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C683E27B0B
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 20:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665113392;
        bh=4AcHgSqNw+Z6l69iz8MctrBbd/h3XY8GRanhiuHQCv0=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=RYgUiRko6GPG5bjXNZvnH0DyufXzLFWBvEGIPibpciFCcDyF7mhLtb+vW/OLWeBtn
         R52tfL5gj+1eyAtPaYmpD48Z06MYkzCdG33AQGWHvM4iUcnDyM8zh5rnG7fZyrdSnR
         /nmDEkFt1NT4YDXfQqKl+VQDhFLozjhzuQlq6UBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiacH-1p9MRE0xNP-00flDh; Fri, 07
 Oct 2022 05:29:51 +0200
Message-ID: <d52b0916-66a9-e0a7-a299-93df7c90cc4b@gmx.com>
Date:   Fri, 7 Oct 2022 11:29:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@kernel.org>
References: <cover.1664999303.git.boris@bur.io>
 <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
 <20221007112306.F62D.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/5] btrfs: 1G falloc extents
In-Reply-To: <20221007112306.F62D.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L3jJcwrTACs7REP3UDnzhx6QxMGrgvCU76fChYUunA4AQemRRat
 f0lYSyfZyPs/h8NamhqPofLK0bZsRDRvkxLcKOJ2iRpVK8rlxvejHVS/3Sx9mGrDK2tmjAc
 am6s7slAA57KMWhqUPldoaDzY0ufb9Eu8dWyRaQn9fabE2Cap4fgcfihu94iZPi/ISfMivZ
 dvFTiMSWZ2ik1Mx+RAARw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QGn54i0r8xo=:YoJHHhzYipk4niIZcy34Nr
 CLpKj5pvAeYDhHsS4EC1ocFoxTcocSr9x3r3q38UZqNiEbipHxm1XOZZ8wacvnFUWhGSnejJa
 qYPWxcdbS8HSqzblD4OZWO477jlmCmxmwLgcRdt8VYzWJJCkR0CMF+zhZpcb+O6PZycDPvLMB
 PdhBWAgKJuxgIrtGXS0MKcsmlEXTyMMGYIkB3xcVIlmogq3T9d9bmFk1hTVSmMe1jEfSw74NO
 5FTMbfRDAGAcAf+6tS8g9DVNmUYSZnWcYBlt/8zcwIEju4nZqA40/HG0VBn34PK0FH1A2n/rf
 0YNLWFE15NVeJDqdn4U5T9ET5fYLSkV01ZRmt4//k5AsFW8dwZjmLckgHM7yz1byrjEx5cnS/
 5/+wKjSpCC9brmAc2HtczxuHajyEy3kvukir5yUlkgYEUxXQEtex6NvNcsj2IWynj3tEjv6WG
 h7oWWCvtRzF3+DRh35HyBx61cIOEiJV6+lJ8st0GVXS86jw9q36r+RBp5PCE8r5T00MIlvF+M
 60jGB92ohgDa/AGT+cqv94COx7sEn3QPGjk5pQCBVCIe+1vFlJHoeJtOQm1Vi7o813M/X4U+i
 COY8pZZCluamExmTDhq4mOulUZopx2s1o6FT/Mnn+72x6KcSmgITIAVrAJ018g1KpxINaQgWR
 JBwPz9qVv93oOGrTV5RhPwmWtPj2ChuQrAU5pGVz8/Cr2ychvzMwinLvgbEodAsnotWEBM4D6
 aLMueLx98oMGbUmZ1/NAlJeoHyAn9gWdcZds/O2wv1E9K5BKGXyzEmonHtP8rIM9JABc62DMX
 vD4bxGIgOTxVpl06hLBbxZhvX+tp4SmD5dCyuChPzroMkQZDTdWrSsRksOSXYZ7vMJNSvskW8
 Xl98WptTpd4S7e8bWkKhZJyrB1rWiBOHbaoPVQbOFnS7Hu6Zp3SMg9a048ZdOq221CsgseEO9
 Gq/cUchFSsQ23OpWC6qpk90mQhfiFURel8qD5uTNY2WtMSKYVdSXba8OpM8UyumEAdyNaNG+O
 UYXZlK7AUE34R3BHPuHgyJ7ucrIFDEskGY//iUx9N6SPJKADgXxLkNuEQQ0TBd/CVnJT6Z0Qj
 n/Rg4HCn938SWucyxrrk5TCaKfomBqLKRFE8qTginXxHjZz/PV3Bto66Wu9nKm23jiE4t0RsF
 7nuvYP7I3hcHCEk4y5yD7J2J+ZDRjH97Wc42LWwxlR1M3QdpagbhiqAAMTf47xIilMruzvg7/
 K3u+f0wA4kdm5Br2g42qZweahITQDj0tU3+tiXAKXgETD6cCo926OamV7fAriPnTTgQdGrfrA
 Lrz8SqTwknf1xdf7ABoueVBCbZ4qAUiFGlh+Yf5uH0e/xVTr8jAgw4TL4mRjz+ckmNAY0IrXd
 mjL/KQwPktfApZg1AKq0IBAuSGUYzsqSBj3OM08XPdeC3xMAywKFIqKp3UXN48/pVTgmelsJn
 UHtn+m51xsq5iNl2yupQH5n90uvQVI7Z+MCprbJL/Efy0iWAaS69C9X9MOUTuqYfi5er3HV6S
 HRfuN72ppsqFJd4KnWSBTyc8bRW+owFa6BuNdej0UiwgT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/7 11:23, Wang Yugui wrote:
> Hi,
>
>> When doing a large fallocate, btrfs will break it up into 256MiB
>> extents. Our data block groups are 1GiB, so a more natural maximum size
>> is 1GiB, so that we tend to allocate and fully use block groups rather
>> than fragmenting the file around.
>>
>> This is especially useful if large fallocates tend to be for "round"
>> amounts, which strikes me as a reasonable assumption.
>>
>> While moving to size classes reduces the value of this change, it is
>> also good to compare potential allocator algorithms against just 1G
>> extents.
>
>
> I wrote a 32G file, and the compare the result of 'xfs_io -c fiemap'.
>
> dd conv=3Dfsync bs=3D1024K count=3D32K if=3D/dev/zero of=3D/mnt/test/dd.=
txt
>
> When write to a btrfs filesystem
> + xfs_io -c fiemap /mnt/test/dd.txt
> /mnt/test/dd.txt:
>          0: [0..262143]: 6883584..7145727
>          1: [262144..524287]: 6367232..6629375
>          2: [524288..8126463]: 7145728..14747903
>          3: [8126464..8388607]: 15272064..15534207
>          4: [8388608..8650751]: 14755840..15017983
>          5: [8650752..16252927]: 15534208..23136383
>          6: [16252928..67108863]: 23144448..74000383
>
> When write to a xfs filesystem
> + xfs_io -c fiemap /mnt/test/dd.txt
> /mnt/test/dd.txt:
>          0: [0..16465919]: 256..16466175
>          1: [16465920..31821623]: 16466176..31821879
>          2: [31821624..41942903]: 31821880..41943159
>          3: [41942904..58720111]: 47183872..63961079
>          4: [58720112..67108863]: 63961080..72349831

Don't waste your time on fiemap output. Btrfs can do merge fie result at
write time.

# dd if=3D/dev/zero  bs=3D4k count=3D1024 oflag=3Dsync of=3D/mnt/btrfs/fil=
e

Above command should result all file extents to be 4K, and can be easily
verified through dump tree.

	item 197 key (258 EXTENT_DATA 4186112) itemoff 5789 itemsize 53
		generation 8 type 1 (regular)
		extent data disk byte 22011904 nr 4096
		extent data offset 0 nr 4096 ram 4096

But fiemap will only report one single extent:

# xfs_io -c "fiemap -v" /mnt/btrfs/file
/mnt/btrfs/file:
  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
    0: [0..8191]:       34816..43007      8192   0x1

>
> the max of xfs is about 8G, but the max of btrfs is
> about 25G('6: [16252928..67108863]'?
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/10/07
>
>
>
>> Signed-off-by: Boris Burkov <boris@bur.io>
>> ---
>>   fs/btrfs/inode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 45ebef8d3ea8..fd66586ae2fc 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct ino=
de *inode, int mode,
>>   	if (trans)
>>   		own_trans =3D false;
>>   	while (num_bytes > 0) {
>> -		cur_bytes =3D min_t(u64, num_bytes, SZ_256M);
>> +		cur_bytes =3D min_t(u64, num_bytes, SZ_1G);
>>   		cur_bytes =3D max(cur_bytes, min_size);
>>   		/*
>>   		 * If we are severely fragmented we could end up with really
>> --
>> 2.37.2
>
>

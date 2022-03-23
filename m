Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181EC4E5BF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 00:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiCWXkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 19:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346969AbiCWXkP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 19:40:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957D99154F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648078690;
        bh=hOVPLxKIeYTocwFOja+lpHxkG0gMBOqIdo74gUC4h1o=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=WLzQBidpk+myr5NBmJFnlaG/rQZqnAbYwzvtETp++qiG+SCebBvidB35dHh1W1e+a
         JpFLqbbIqtimcJK0RtGihOZXVEH+Uie9ll0S1MNNArsxs+Xohyoyw+xJDAmH8FPplI
         DezDCvesMm+P0A4WhxJmhvoUIs37Cs5iiId9jtFA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsYv3-1oKrQg1CuJ-00u5GO; Thu, 24
 Mar 2022 00:38:09 +0100
Message-ID: <5aa9f195-9152-72fb-e053-a67b734dcb34@gmx.com>
Date:   Thu, 24 Mar 2022 07:38:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] btrfs-progs: check: add check and repair ability for
 super num devs mismatch
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
References: <cover.1646009185.git.wqu@suse.com>
 <029df99dabfee5b8fc602bf284bb3ea364176418.1646009185.git.wqu@suse.com>
 <20220323174315.GC2237@twin.jikos.cz>
 <f52f4d7e-1d9e-9680-3aa5-ef954f0135b2@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f52f4d7e-1d9e-9680-3aa5-ef954f0135b2@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4I8cnmmXQLh43Zl+gB+suBZVMo5KuO4Qluux5B/CawcwnftPX2L
 D1qSaxStCuqQNoi9acrV0PAJLK5UHgWdlpZeSvO8sDaCSd8Fz+AS5NOl7YFyIqn2/dQz1+c
 QUaUH3S216BoEbu55MqdMfiPiEFUyJpmA+I1cy5mgW9Ivy+CzzH5+OW6/jvYPYTOw8O7SA7
 HY90vDSOCWS8dFYOpZvxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JJymz5LDcMs=:6weLL2BBi6ePqVilxWkSHc
 owgKm6yfcX6XqWWRV10dFSg6lXKCyUMAOR4v3xpEYrLS/aAM1OwzSqcXWIPjpmOhAPdf0JRtz
 tA4/X2kGzAPl49WG8TvWuBlVn6l0ZAMw7w+Zlli34NB+MEdTbes6Rb7fivkfH/h6FXJZzyPYx
 k0Ct6KDTEB29i+gcuTmX2M0tXZvIyQ2Npvqpuvzg7KFzULK0f6C86DGRNsqQiYe6h0P1PA68P
 EnaEAgv1yTus2XUCy91qxa+yxHKRzKOdLwN73ZPxf6IIFloNqhkkYSLe/n9Jqhrsz8rOv4epO
 ro7PSokgNCNkWRgmtFlBnF40Qq6E17+WiNQTj+LAbmS1wxIL1MD9iC8PCpUcvB2oOYYJMm98f
 3KJKupRwQ8gua4FSDrbdGnG4esG6XeCDTNuyq270qxnV4F2HVGDckOvTTrF5KiD4AtIaHvh+R
 8IMMlFAkG6iWVTDbXxWt9YTuKlvWDK0PhEhyzmGaX0nfDKaYkq2JwS/L1vMitd2tqv9z3bC7v
 0cabZgpuc5opog2RCAfZUGEQ2W6wRg3xnvZrARIS9ReQALAMqj0wy+jDn9tAlCqayQcsY0hxw
 y0vJIG3pdSwqJgUVHcvBbB50ET5AjEfbssDY44ZjMDa42/x2BdxIHyr6AYQfKNaM4kcU5gt3t
 /hYNyKjnIh2jJSxBSp7LTPHg1fUkWgnH/ZsvGPBE/IhBi1KjBNFv/EWF4VVAldyh7RNj3yDgp
 dqtqzQnD0YbsyrDaD4p265hRFWWNqzabgcm5GBwvd1WGzI355Hwe1g1QtLhyfn6Q9XDDLbX5g
 WQGEhkNNuTQZnJauc+iNqk1moVVOEwlA4Q/IaIsYFhjJuP72jBauNDhdmTdfCEmd2+kjfjV0g
 oJJ7+1OqB1x39EJ4TVRIryfB55yF+YQX37mXN9QcRl5E/VtsFx0bevc5BjyfvXjEqQsCMKANa
 7ZRCTBSxTedyrjEWPiHRhDuYqdZl22uWaufSniAO1yJIbsBLhXh5EgaHrcnTPZF73lrNWzQIG
 F0787tZuy+ngOoqBpPggrts82ZLq4qaOQDFEOv3hMHNwxfIKC0pakYWaQQj5xGz1Nn1x6EATE
 VaNCnYPjWm3LHI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/24 07:15, Qu Wenruo wrote:
>
>
> On 2022/3/24 01:43, David Sterba wrote:
>> On Mon, Feb 28, 2022 at 08:50:07AM +0800, Qu Wenruo wrote:
>>> [BUG]
>>> There is a bug report of kernel rejecting fs which has a mismatch in
>>> super num devices and num devices found in chunk tree.
>>>
>>> But btrfs-check reports no problem about the fs.
>>>
>>> [CAUSE]
>>> We just didn't verify super num devices against the result found in
>>> chunk tree.
>>>
>>> [FIX]
>>> Add such check and repair ability for btrfs-check.
>>>
>>> The ability is mode independent.
>>>
>>> Reported-by: Luca B=C3=A9la Palkovics <luca.bela.palkovics@gmail.com>
>>> Link:
>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=3DzqDq_cWCOH=
5TiV46CKmp3igr44okQ@mail.gmail.com/
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> With this patch applied there's a new test failure:
>>
>> =3D=3D=3D START TEST .../tests/fsck-tests/014-no-extent-info
>> testing image no_extent.raw.restored
>> =3D=3D=3D=3D=3D=3D RUN MUSTFAIL .../btrfs check ./no_extent.raw.restore=
d
>> Opening filesystem to check...
>> Checking filesystem on ./no_extent.raw.restored
>> UUID: aeee7297-37a4-4547-a8a9-7b870d58d31f
>> cache and super generation don't match, space cache will be invalidated
>> found 180224 bytes used, no error found
>> total csum bytes: 0
>> total tree bytes: 180224
>> total fs tree bytes: 81920
>> total extent tree bytes: 16384
>> btree space waste bytes: 138540
>> file data blocks allocated: 0
>> =C2=A0 referenced 0
>> succeeded (unexpected!): .../btrfs check ./no_extent.raw.restored
>> unexpected success: btrfs check should have detected corruption
>
>
> Weird, the problem is, for the restored image, if I run ./btrfs check
> manually it can detects the problem, but still go "no error found" path.
>
> So it must be my patch overriding the return value.

Indeed that's the case.

Fix upon current devel branch is:
https://lore.kernel.org/linux-btrfs/f576d7a548b91d42d02b17d2dc52ee04d943a5=
7d.1648077794.git.wqu@suse.com/T/#u

Please fold the fix into the patch.

Thanks,
Qu
>
> Will fix it soon.
>
> Thanks,
> Qu

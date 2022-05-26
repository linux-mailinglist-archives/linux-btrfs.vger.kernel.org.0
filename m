Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB8534C7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiEZJ1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiEZJ1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 05:27:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F8850022
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653557217;
        bh=SM7imYvxB6mykMDCF755UtQyVvXihuqKmXnYpCBvkJc=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=b8TfwvZJYxQwQNiumOVeVpMeQNPdOm3zqX1m648Pq3uGzHcKeflgKbsnp0BUOt4EM
         KBAgevG5lBnEP5ngbM4Y1zH/TzkFhC5yyQ9xbUAfqATZ9vNrFxPh5vC8Sa15lPBEom
         ihxxN/hK716OF1zE1+gTDWtXpNBF12UOAu71YEEk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFsUv-1o3He32khj-00HPyB; Thu, 26
 May 2022 11:26:57 +0200
Message-ID: <50cb070b-2e2e-1987-3726-1e67eaf060cf@gmx.com>
Date:   Thu, 26 May 2022 17:26:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     waxhead@dirtcellar.net, Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
 <20220524170234.GW18596@twin.jikos.cz> <Yo3wRJO/h+Cx47bw@infradead.org>
 <bd6ac4d4-41bf-f662-e7c0-7841895554a6@gmx.com>
 <Yo32VXWO81PlccWH@infradead.org>
 <b8cbcac2-7e8b-e0fd-67a9-8a782e0afe23@gmx.com>
 <9d1e2fc6-9ee6-68f8-bda8-8dd7e59e74e5@dirtcellar.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
In-Reply-To: <9d1e2fc6-9ee6-68f8-bda8-8dd7e59e74e5@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:696pvdMFz6XBFRWj5K/Lf/68gWFDlODMlkbssJYQD72tg7Yyn98
 YwDN8jl/jKssSDeIuu8RjWd/iCvVYehtviNu+HjQf2dr18mQJqNp4jZhpwttxSybdjSpKAf
 yuQNOlF3h4WCZT6sBhmj2kr1qO3VG9iYFEmVcsUH3dUHo+dh+BQrHXsUL18fTRwS2JqUipG
 tJiDMbqaokGmi3yTNLt1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T9x/Fykt5Kg=:VKX288qn7ND11rwdoAJOmU
 hM3nkdqgG1J30slk8L3Ef00o5dO8H7QkHdJ1JFsHdEauXPQC1hWmSfMh1ajHV6Th3Trw0TJpR
 q24hecKra2Jen06FOX7zSAFuPZokYDDuYpEZ5mvtissokV3vAvnI2pfZmEeoxbd6HNwU9R9Pz
 KD6jUPXpPT/2Xb8+lsr+Y2v3q03bVVIGxsjP3RSuy//vlaWPfleTVdytz1Eg/VWJnMq6j7Qxa
 aLLW4CAPrpCIiKgwWrayVDtvn58Qg+hYbyzFbldFfISsjdmCpBqh6mLazMRh7g96bsluxnoDQ
 lGmlLBBs3uJ3UTxl0OxEuyil1J1+dHUNJUP6hC4wTBMNXyonipMaXLZ6eYAzxIAjhIxF8lK/y
 uFtxa25n1tvwqqIDEg48N47zd7TAHnt6+qef0zrsahv9rrDPq+DNCZRW09t2oZzx7uaM0kzcs
 dXe3JN4ntaZp0oYMoA7y6hxXfDDK4iA7M2ng0wucJmEgcdGaJAqNB/jYPb2/0RkJup0w+YA5X
 ZVAzsNWrlTepS3IEThCWXSa21KAgMjwndDEfwjXxFI1MLHiohBHT1hnEBzaj5CyUM/pSnQlzv
 jDy8yvbkYb0zswkpnaVzRAOiSGH3cc6zq/yECKCa/DzfNfa/HbI4r5gsRO3XMAWynho/4PUfm
 UiXTYqLLp/j9CbuQTEWxLsO5VkoL+BEdwAViuTR/XglJXBxY2tkAM1hl+NG9AYcU1bE7ETM+X
 bNxYDgwZNFjsTsH+IMBHq/zi6Q2MTfblY6MNprWcMP+b2V0wi17k0dxEEzPo5uIEtZytbaAZd
 i2JVxq1CjaqFA00EcuONNOBl5yzroUPeVK0j1+8nFFh2+0CKwr/6TBqgUgommi76ftUnqun4I
 hWpg71XP0MWtt+7VBX6Mtk4mAW4QEBAs4/RVLmoytpAMSyw2b+FYrGDfMBtK/m1nrsJSn/lKX
 pJxxvTQLU+wQnSIoIS2B7kU5rUr9IcFnDl5H651Ztqnl+ZyxN2zc5J+YQ97ZoDMswQrw+uOOs
 WgnyRcK7+ijjlMS4Sz28cHB/tfJ3WX7oCJeLQK0WcQkkmD/x5lItuJXLiYsgtQjuFMCE0pKMQ
 8IpR7loxrqNsnQgCFq6AXC5kCwDagPJiv/l5JIAc7kSZ3Jhe9+UDlaq1A==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/26 17:06, waxhead wrote:
> Qu Wenruo wrote:
>>
>>
>> On 2022/5/25 17:26, Christoph Hellwig wrote:
>>> On Wed, May 25, 2022 at 05:13:11PM +0800, Qu Wenruo wrote:
>>>> The problem is, we can have partial write for RAID56, no matter if we
>>>> use NODATACOW or not.
>>>>
>>>> For example, we have a very typical 3 disks RAID5:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0 32K=C2=A0=C2=A0=C2=A0 64K
>>>> Disk 1=C2=A0 |DDDDDDD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>>> Disk 2=C2=A0 |ddddddd|ddddddd|
>>>> Disk 3=C2=A0 |PPPPPPP|PPPPPPP|
>>>>
>>>>
>>>> D =3D old data, it's there for a while.
>>>> d =3D new data, we want to write.
>>>
>>> Oh.=C2=A0 I keep forgetting that the striping is entirely on the phys=
=D1=96cal
>>> block basis and not logic block basis.=C2=A0 Which makes the whole ide=
a
>>> of btrfs integrated raid5/6 not all that useful compared to just using
>>> mdraid :(
>>
>> Yep, that's why I have to go the old journal way.
>>
>> But you may want to explore the super awesome idea of raid stripe tree
>> from Johannes.
>>
>> The idea is we introduce a new layer of logical addr -> internal mappin=
g
>> -> physical addr.
>> By that, we get rid of the strict physical address requirement.
>>
>> And when we update the new stripe, we just insert two new mapping for
>> (dddd), and two new mapping for the new (PPPPP).
>>
>> If power loss happen, we still see the old internal mapping, and can ge=
t
>> the correct recovery.
>>
>> But it still seems to have a lot of things to resolve for now.
>>
>> Thanks,
>> Qu
>
> I am just a humble BTRFS user and while I think the journaled approach
> sounds superinteresting I believe that the stripe tree sounds like the
> better solution in the long run.
>
> Is it really such a good idea to add a (potentially temporary) journaled
> raid mode if the stripe tree version really is better?

Journal is simpler to implement, and has been tried and true for a long
time.
Although the on-disk format change is unavoidable.

Another problem is, for now we don't have a good idea on even if it's
possible to use stripe tree for metadata.
(And it's still under the early stage for stripe tree)

Sure forcing RAID10/RAID1C* on metadata would be acceptable for most
users, it's still something to take into consideration.

> What about Josef
> Bacik's extent tree v2 ? Would that fit better with the stripe tree /
> would it cause problems with the journaled mode?

I don't believe extent tree v2 would affect RAID56J at all.

Not 100% sure about RST (raid stripe tree), but from the initial
impression, some tricks from extent tree v2 may help RST.

>
> As a regular user I think that adding another raid56 mode may be
> confusing, especially for people that do not understand how things work
> (which absolutely sometimes includes me too), Quite some BTRFS use is
> also done outside the datacenter, and it is regular joe and co. that
> complains the most when they screw up, which to some extent prevents
> adoption on non-stellar hardware which again would/could lead to
> bugreorts and a better filesystem in the long run. So therefore:
>
> If the standard raid56 mode is unstable and discouraged to use, would it
> not be better to sneakily drop that once and for all e.g. just make it
> so that new filesystems created with raid56 automatically uses the new
> (and better) raid56j mode? Effectively preventing users from making
> filesystems with the "bad" raid56 after a certain btrfs-progs version?

Deprecation needs time, and RAID56J is not a drop-in replacement
unfortunately, it needs on-disk format change, and is new RAID profiles.

If the code is finished and properly tested (through several kernel
released), we may switch all raid56 to raid56J in mkfs.btrfs and balance
(aka, balance profile raid56j becomes the default one for raid56).

For RST, it's harder to say with confidence now, a lot of things are not
yet determined...

Thanks,
Qu

>
> This way the raid56 code would seem to be fixed albeit getting slower
> (as I understand it), but the number of configurations available is not
> overwhelming for us regular people.
>
> PS! I understand that I sound like I am not to keen on the new raid56j
> mode which is sort of true, but that does not mean that I am ungrateful
> for it :)

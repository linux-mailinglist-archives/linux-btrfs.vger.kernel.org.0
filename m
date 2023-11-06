Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D277E2E57
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 21:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjKFUln (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 15:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjKFUll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 15:41:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFDD76
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1699303295; x=1699908095; i=quwenruo.btrfs@gmx.com;
        bh=KdIgo6uSSWQvOkCzyMHuCgIkLF0d56Jqyl0YhhiZrl8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=m79nohPcAdN9jDN88/zjZb47aQvlKBszshQ0uFkyp/M7eshMllO+fblMFb1wmSnv
         A+2QzPA9m8Q2W0oDwJbk8/tquO0ZCZV+6evH003WC8wevvOdlJX1rnfK25n0EUHkQ
         Lb5y0U/UzeuuN0TZoNGCN0dLqHgNKSVVIjlhx4o66tgl36TNcMRzoR9zgBy4Xo1NV
         dV2bmt74MU497AbRUAl9go51z/NJO+nDJsIpI/Zd37YK4o6Edz0lfd5Y+kKsp7MSw
         ZaV4/NeFDzs7pZhUC4pU82hyt/oA9+PiymJnQGjjxeOpDP93l+Hc9WEtPrMP7uCFl
         hwn4c3PnY5o/UolTZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv2xU-1rHlp02Q1g-00r2xl; Mon, 06
 Nov 2023 21:41:35 +0100
Message-ID: <803b59fa-f398-4522-a3d8-69b598a209f5@gmx.com>
Date:   Tue, 7 Nov 2023 07:11:30 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can btrfs repair this ?
To:     Joe Salmeri <jmscdba@gmail.com>,
        BTRFS Mailing-List <linux-btrfs@vger.kernel.org>
References: <9de00454-0cd9-4d2d-aed4-23490f7dde83@gmail.com>
 <bbda4275-a07e-4921-a9c0-5a3d34801ef5@gmx.com>
 <de206814-ab47-40da-8e35-370ec3633bd5@gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <de206814-ab47-40da-8e35-370ec3633bd5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wn2WpnEK4YGxYpv6CRLJSGcYNNEelHtaNrem+Z/2FBF3GscQabM
 rIIj8tADhw6fLE365QDOG9rchcDLX2M865q/7NrXY5l3DRcP9b/5g5r5J0XiYrWQ1UA6m3r
 /0CZtG+M3JTEGlfxIMgErZfsV8GDgterS7dwdNdR2YewtoxyelxsyZLvlRDDK9NXkrupvxO
 hjzynjsrH0x5jt2d96W/w==
UI-OutboundReport: notjunk:1;M01:P0:JyyK1imx6dA=;Q9NN+kVnfOP3LLWCItX/c5QY+yh
 vNfdQv2up7lMDfiXYVPBBpEaaOlCwyWHeQWv76HNpSVxktOeCl0NSOBxH2EUA1ZseP2Dt8ujM
 eK7eKf/MvfBNm7y6g8+6fiOcmxACwQg/sSs9R0fnglTUhifJsh8uAt0qqgDCxRrWqjoSvmCZV
 /QHkJV1unQ7ziZlfyk+RSx5ipGBoCQoKVc2NAWVx6XCcSRaF8Z5eadbLBUbgVmLFmPxNdvCb0
 TA8KnyLylwg7IVuPRbxmJ9m8hgwos9MDEhZtQGR8iEhr9mcD5idhwSHBnKO8v8XxLgN1xx/41
 RfbigxeRwbABG8huwLJsVHwhCofqZEsfscxONFv0UZNgzDq5eA0ykrdbhHoLvUklbfFLlvMpr
 75ci3smZIbVk+tDuxHaiIZpFTEh1Td7ghu4B6op3k/luZlpWRdBdciwMIKmrvTit5xTfNqf+Q
 fA/wsbOcThKJ67jIYJc/oz/52idVmln5ekT7MHlEtATbc3e5t3XymdhLo1qhX9YdZXL9+DUzQ
 gaM3Bl3x3OrZEUDRY9k8EzVdWGnbd298GWWfoN2/Vl+J2FCiOaJtmt1BVrSJbA6qgmystDfAe
 1hQZ2HbXeXkdsdVlfmgmdt3J/vGjVW0o02sfY8yJRH9PxK/sgpn0WwUYWdAfJ07xtLVfsVa1Z
 mzgXpjg4zZ4TWMlkTu6NGtEv0ufmaoX6F4+FhYlpTdj97vjo/liIP3xE8POJyMuhJbqE1OS2Y
 ioVos4t4aGXyjEXe4QYuwchEWvoR+4GYObfJjRUmLueUPZX9K1maC9ySOeFW1vdTNlgWFmFlt
 vTH1ehmc8k5XAEBbXRmQhVhjkF25aHdq8dYYMchF0PNM0U/49MDooGNS9y/82zYzq+dQ4LUfZ
 i15mYioITcoenTkRuHkZJT5S8HV2Ka8SPFfZg01NC+k0buQvf89CYXOrz7kBck04onSZXxI/9
 6HBZRDedNRguZngPPYEI07e6WQM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/7 06:26, Joe Salmeri wrote:
>
> On 11/5/23 18:45, Qu Wenruo wrote:
>>
>>
>> On 2023/11/6 07:08, Joe Salmeri wrote:
>>> Hi,
>>>
>>> I was running openSUSE Tumbleweed build 20231001 when I first found th=
is
>>> issue but updated to TW build 20231031 the other day and it still
>>> reports the same issue.
>>>
>>> Kernel 6.5.9-1 btrfsprogs 6.5.1-1.2 Device Samsung 860 EVO 500 GB
>>> Partion #5 root btrfs filesystem, no RAID or other drives
>>>
>>> I run "btrfs device stats /" about once a week and no problems are
>>> reported.
>>>
>>> I run "btrfs scrub start /"=C2=A0=C2=A0 regularly too and no problem a=
re reported
>>>
>>> I ran "btrfs check --readonly --force /dev/sda5" the other day and got
>>> the following errors:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opening filesystem to=
 check...
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARNING: filesystem m=
ounted, continuing because of --force
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Checking filesystem o=
n /dev/sda5
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UUID: 7591d83f-f78e-4=
02b-afe5-fab23dad0ffe
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [1/7] checking root i=
tems
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [2/7] checking extent=
s
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [3/7] checking free s=
pace cache
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [4/7] checking fs roo=
ts
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root 262 inode 319967=
35 errors 1, no inode item
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 132030 index 769 namelen 36=
 name
>>> 02179466-b671-4313-8fa5-0eb87d716f92 filetype 2 errors 5, no dir item,
>>> no inode ref
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 132030 index 769 namelen 36=
 name
>>> 77ef9cd4-0efe-46af-bf7f-47f582851e16 filetype 2 errors 2, no dir index
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERROR: errors found i=
n fs roots
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found 33034690560 byt=
es used, error(s) found
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total csum bytes: 288=
19244
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total tree bytes: 986=
251264
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total fs tree bytes: =
876134400
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total extent tree byt=
es: 62521344
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btree space waste byt=
es: 277302161
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file data blocks allo=
cated: 141608800256
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 referenced 3905=
4090240
>>>
>>> Running "find -inum 31996735" identifies the item is is complaining
>>> about as
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/bin/find: File s=
ystem loop detected;
>>> =E2=80=98./.snapshots/1/snapshot=E2=80=99 is part of the same file sys=
tem loop as =E2=80=98.=E2=80=99.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/bin/find:
>>> =E2=80=98./home/denise/.config/skypeforlinux/blob_storage/02179466-b67=
1-4313-8fa5-0eb87d716f92=E2=80=99: No such file or directory
>>>
>>> Running "ls -al /home/denise/.config/skypeforlinux/blob_storage/" also
>>> shows that this is correct item
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 drwx------ 1 denise joe-denise =C2=A0=C2=A072=
 Nov =C2=A01 22:49 .
>>> =C2=A0=C2=A0=C2=A0=C2=A0 drwxr-xr-x 1 denise joe-denise 3.7K Nov =C2=
=A01 20:07 ..
>>> =C2=A0=C2=A0=C2=A0=C2=A0 d????????? ? ? =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
? =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
? =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0?
>>> 02179466-b671-4313-8fa5-0eb87d716f92
>>>
>>> When I originally ran btrfs check there were actually a bunch of other
>>> items listed, however, I have timeline snapshots turned on for the
>>> /@home subvolume and all the other items were because of that item in
>>> each of the other snapshots.
>>>
>>> I removed all the other "home" snapshots and now btrfs check only
>>> reports that one item as shown above.
>>>
>>> I have heard that btrfs check --repair is generally not recommended bu=
t
>>> I have been unable to find a way to have btrfs remove the item it is
>>> complaining about.
>>
>> --repair can fix the problem.
>>
>> But for your particular problem, please also do a memtest just in case.
>>
>> This problem looks like a bad hash, which may be caused by memory
>> bitflip.
>>
> I ran the memtests last night multiple times and no problems reported.
>
> I have heard that --repair usage is usually not recommended.
>
> I cannot afford to have this system have to be rebuilt right now.
>
> Is it definitely safe in this case ?=C2=A0=C2=A0 Otherwise, I would just=
 ignore it
> since I know why it exists and that it is not a hw problem.

At least from your output, it won't make things any worse.

Thanks,
Qu

>
> Since this is the root fs, I assume I have to boot a USB live
> environment and do the repair from there or can it be done on the
> mounted btrfs root fs with the --force option ?
>
>>
>>> I have tried rmdir, rm -rf, as well as find -inum 31996735 -delete and
>>> all report the same issue with not found.
>>>
>>> If I understand correctly, the parent directory entry ( so
>>> /home/denise/.config/skypeforlinux/blob_storage/ ) has the entry for
>>> /home/denise/.config/skypeforlinux/blob_storage/02179466-b671-4313-8fa=
5-0eb87d716f92 with inode of 31996735 but it doesn't really exist.
>>>
>>> I do not consider this a HW issue because btrfs stats, scrub, and smar=
t
>>> do not report any errors and I also track all the smart info ( health,
>>> reallocated sector, wear leveling, etc ) for SSDs and there are no
>>> errors reported and I am not having any other issues.
>>>
>>> I suspect that this occurred the other day when Skype crashed. The ite=
m
>>> is not needed, I just cannot figure out how to remove it.
>>>
>>> So, is it possible for me to remove this item and if so how do I do it=
 ?
>>>
> I find it interesting that interesting that I can remove a snapshot
> which contains the item using the normal delete snapshot functionality
> but that none of the built in tools have a way to do it.
>
>
>

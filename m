Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125487AF9DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 07:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjI0FQ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 01:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjI0FQN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 01:16:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597B94234
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 21:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695790422; x=1696395222; i=quwenruo.btrfs@gmx.com;
 bh=21qOmgf8DiJ9HyZcUmHmMG4DgkJ0Yw8htj9GgTD/sc0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BKzXp5BImH1jIH4MuFHHoZwIPEZ1vmmwBiLqOUw0fdZhIDmq54qvn78tS5V0uAX6fVz82KikdNQ
 +Ezj00s/5lWDgEHdOuYRWMnnqiuHBDMeyyfOCNgs17UnmhEjOP2so0nOVFuTy7w4YgGqf7qRB3Zuy
 F+X1dHWUWIAcGXTwSZSQUhT4R9TOVxo4ausZtKlRl7XCoxQTr9pGsSaZ2YranDxPn7b8V3L0+QCco
 ISXnBJ+kQOU0/v7SLvhWHrBdBOJT1V4CONH2gX7cODnKFPSFGXtclPFmREAu1iagDe1AW3LEOBxxC
 spEKnHUGAWhKsuh6/SwTDJahptjUqcH94IZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wuq-1qi2d72zsS-005cBY; Wed, 27
 Sep 2023 06:53:42 +0200
Message-ID: <4cb27e5b-2903-4079-8e72-d9db2f19ced7@gmx.com>
Date:   Wed, 27 Sep 2023 14:23:38 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Deleting large amounts of data causes system freeze due to OOM.
To:     fdavidl073rnovn@tutanota.com
Cc:     Qu Wenruo <wqu@suse.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>
References: <NeBMdyL--3-9@tutanota.com>
 <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com> <NeGkwyI--3-9@tutanota.com>
 <bb668050-7d43-467f-8648-8bc5f2c314f1@gmx.com> <NeKx2tK--3-9@tutanota.com>
 <NfJJCdh--3-9@tutanota.com>
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
In-Reply-To: <NfJJCdh--3-9@tutanota.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9bwhY5mFhUiHal3DVjYVWwyvM1reUeSTvWuxh8BSPawNI9XPB0v
 8s3cOvarjLgrRhQD/TXdFKs63FXRhEo017OB2CUY/A9EOPqGfjVs4mrOx0cYcPDBahOpXLk
 CQfh4zPMY+mYWsnxRB0eb0voP7hhIdtSYIAjq8hiy+0ehXJT8LbBGPbO6T+13Ypd6qMOy5p
 CnGtwNa7cnP0mW9Avp7Wg==
UI-OutboundReport: notjunk:1;M01:P0:afL+o5opzf4=;tNgwbcPqE/fHOksr4LMRsWGNqKy
 5eWDUg6LcReC5Cfn/EEdKdKgfnZRrHOZdLoLhLR+GdPxexTOWu1Bj430HdYKsY33hxriIJu7f
 1tl7V3Qu/fAR0vQg7ttCtfQLAK/ycSO+VwH436Gx2gK+27fk3C6ObKIe4I7oyN4c4hELhcPL/
 2qPpgld12np+1Ca7lsLdnotcfx84iXWtKqsAkyPsiq/tQCBr4OOLKUNME4SCQsXNQIOV8wmLH
 oCXsyh3dMCoQnURf/wJVWpUsP8VS+NpZFAunlXbGbSW+Wu8B1/f3WH5xK8dJIjuT+qtKkmlil
 xjcEf1CyHZJ4gIu0t8PC0Yi4PRocu+i9VSlZX8gAVnJa8zAig48mQntS7TIQvKoWvCLdBEfGf
 yGQsRW8oR1Ag5Qels9sRMYQYPTscLGgV7UTsq9hAtsKSesHpQ5MQa+R/b1nlOr62ZGDPkT7sk
 Ypfe4zYlkRaLUzn6cAGbcJLGa2EdBGLlRrtJEI2bqqfNHljc7gU++KlZQLiTvDLL5ENKQKy+V
 doS/pqzNuicsJSV5m0P/ag0IYAdmWAcMqithfITL3uj6DNu3/U4PDhqDnTqFIwUoo7Mr+zBx3
 +o8xNra4WHY2KU31QfaLTOJv4o0s3Y/fYDEYsypR3dISC05kJTto+Pqi2Wr0zM2QrAIXqH4cC
 ITGOOmm3fDL6kio/rJ+eEn+/sZnlnhT4IlJdQkxrxwL1i9DlJJ77Td6PtCcxwtfupWLHnGonz
 +c7Xn/gWSzGRQTRmHpJLjMeDMERL7NsQEV9ju0SFP2mrLlkpFKePkKQpU0FXYkcsvLgidLnOq
 z7FXvxW4IicCKef6YdiyceItv4wKy/LZ/rr3Il4chwHfxmZ3G9U83enllNzCFHUlgWITL2AC8
 rY156EbWQUaeKAC8wrn5i3C/DYErwc9fT1I/2K9qNIcJeR0IZjjffvl88uxhvDhrzoeTdhVPW
 dbvdqg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/27 11:16, fdavidl073rnovn@tutanota.com wrote:
>
> Sep 14, 2023, 23:08 by fdavidl073rnovn@tutanota.com:
>
>>
>> Sep 14, 2023, 05:12 by quwenruo.btrfs@gmx.com:
>>
>>>
>>>
>>> On 2023/9/14 13:08, fdavidl073rnovn@tutanota.com wrote:
>>>
>>>> Sep 13, 2023, 05:55 by wqu@suse.com:
>>>>
>>>>>
>>>>>
>>>>> On 2023/9/13 11:58, fdavidl073rnovn@tutanota.com wrote:
>>>>>
>>>>>> Dear Btrfs Mailing List,
>>>>>>
>>>>>> Full disclosure I reported this on kernel.org but am hoping to get =
more exposure on the mailing list.
>>>>>>
>>>>>> When I delete several terabytes of data memory usage increases unti=
l the system becomes entirely unresponsive. This has been an issue for sev=
eral kernel version since at least 5.19 and continues to be an issue up to=
 6.5.2-artix1-1. This is on an older computer with several hard drives, ei=
ght gigabytes of memory, and a four core x86_64 cpu. Slabtop output right =
before the system becomes unresponsive shows about four gigabytes used by =
khugepaged_mm_slot and three used by btrfs_extent_map. This happens in ove=
r the span of a couple minutes and during this time btrfs-transaction is u=
sing a moderate amount of cpu time.
>>>>>>
>>>>>
>>>>> This looks exactly like something caused by btrfs qgroup.
>>>>>
>>>>> Could you try to disable qgroup to see if it helps?
>>>>> The amount of CPU time and IO of qgroup overhead is directly related=
 to the amount of extent being updated.
>>>>>
>>>>> For normal writes the IO itself would take most of the CPU/memory th=
us qgroup is not a big deal.
>>>>> But for massive snapshots drop or file deletion qgroup can be too la=
rge to be handled in just one transaction.
>>>>>
>>>>> For now you can disable the qgroup as a workaround.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>> I've never enabled quotas and my most recent attempt using the single=
 profile for data was on kernel 6.4 so they would have been disabled by de=
fault. Running "btrfs qgroup show [path]" returns "ERROR: can't list qgrou=
ps: quotas not enabled".
>>>>
>>>
>>> OK, at least we can rule out qgroup.
>>>
>>> Mind to provide more info? Including:
>>>
>>> - How many files are involved?
>>> A large file vs a ton of small files have very different workloads.
>>> Any values on the average file size would also help.
>>>
>>> - Is the fs using v1 or v2 space cache?
>>> - Do the deleted files have any snapshot/reflink?
>>> - Is there any other processes reading the to-be-deleted files?
>>>
>>> One of my concern is the btrfs_extent_map usage, that's mostly used by
>>> regular files as an in-memory cache so that they don't need to lookup
>>> the tree on-disk.
>>>
>>> I just checked the code, evicting an inode won't trigger
>>> btrfs_extent_map usage, it's mostly read/write triggering such
>>> btrfs_extent_map usage.
>>>
>>> Thus there must be something else causing the unexpected
>>> btrfs_extent_map usage.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Sincerely,
>>>> David
>>>>
>> On my latest attempt using the single profile there is about fifteen te=
rabytes total of space used, around eight hundred and fifty thousand files=
, over 9000 directories, and there are three very large files (two two ter=
abyte and one four terabyte). There are also about two terabytes of compre=
ssed files using zstd at a fifty percent ratio.

The compression is the easily way to create tons of small file extents
(the limit of a compressed extent is only 128K).

Furthermore, each file extent would need an in-memory structure (struct
extent_map, for a debug kernel, it's 122 bytes) to cache the contents.

Thus for a 8TiB file with all compressed file extents at their max size
(pretty common if it's only for backup).
Then we still have 512M file extents.

Just multiple that by 122, you can see how this go crazy.

But still, if you're only deleting the file, the result shouldn't go
this crazy, as deleting itself won't try to read the file extents thus
no such cache.

However as long as we start doing read/write, the cache can go very
large, especially if you use compress, and only get released when the
whole inode get released from kernel.

On the other hand, if you go uncompressed data, the maximum file extent
size is enlarged to 128M (a 1024x increase), thus a huge reduce in the
number of extents.

In the long run I guess we need some way to release the extent_map when
low on memory.
But for now, I'm afraid I don't have better suggestion other than
turning off compression and defrag the compressed files using newer
kernel (v6.2 and newer).

In v6.2, there is a patch to prevent defrag from populating the extent
map cache, thus it won't take all the memory just by defrag.
And with all those files converted from compression, I believe the
situation would be greatly improved.

Thanks,
Qu


>>
>> The device is using space cache version two, there are no reflink or sn=
apshots as far as I know and nothing else is reading or happening when thi=
s occurs. The system idles at about three hundred megabytes of memory used=
 with negligible cpu activity before this happens.
>>
>> For some context the device is currently mounted with compress-force=3D=
zstd:3 and noatime. The data currently on the device was transferred via s=
end-receive version two (and was already compressed) as a snapshot but it =
is the only copy of it on the disk so I am not sure if that counts as a sn=
apshot. I do not think the snapshot is related because I have deleted a si=
ngle four terabyte file (from the snapshot) as a test and the memory usage=
 went from about three hundred megabytes to over a gigabyte before going b=
ack down. I assume that was the same thing but the system just did not run=
 out of memory.
>>
>> Sincerely,
>> David
>>
>>
> To follow up on this I've tried creating a ten terabyte file then deleti=
ng it then tried creating approximately ten terabytes of files randomly be=
tween one and thirty two megabytes then deleting that folder. I tried this=
 both at the root of the btrfs device and inside a subvolume. Each trial d=
id increase the memory usage by up to one gigabyte at points but did not c=
ause the system to run out of memory.
>
> I still believe the cause is that requests are being queued faster than =
they're completed until there is no memory left so my current thought is t=
hat this either has something to do with nested directories or my real bac=
kup is significantly more fragmented. I think either of those possibilitie=
s might cause significantly more=C2=A0 seeks for the harddrives and slow d=
own how fast operations are completed causing them to pile up.
>
> I might try to put together something to make nested directories with lo=
ts of small files and delete that but otherwise I am out of ideas (I canno=
t think how I could properly replicate fragmentation easily). If you have =
any thoughts or things you think it'd be worthwhile to test I would love t=
o hear them.
>
> Sincerely,
> David

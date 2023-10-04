Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB517B79E4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 10:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbjJDISf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjJDISe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 04:18:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EAD83
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696407508; x=1697012308; i=quwenruo.btrfs@gmx.com;
 bh=lmB8BAxVsjfYPNhwrOkahZXgZH5qcYAoqocQYjHZoHE=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=QTS3DQfG9g0+NB6vWHu9BfNPA6BfSVCV71rZr14YfMzYOlDix4zmlbU6+8mJaSRZ0a9gEY1yDub
 hzrMzsYMnqIF5LOEJOV5J55NXjIGS6zr7/QyeZ0FSj4BzJTrBwKQi0EwdaHFy+clX1cP383JHvC8I
 VoQMGN84EqdQRVuiNKE5j/0V5LXG7TjaorMefrDAXE5WPazqDponqnuvs7UpKIC9s6RWWbD0iXCvM
 6DULv5RXH59By4UQqagMoS7Yj+xD9O5MSNDg6BBBHNYK9+MYhPlSccTtPS5/V9IVPLehbRcavXN70
 k3aXCTi+xwYSYSOu7SBsSCmFqTeCikuNQEHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McYCl-1rJhL52IcX-00cywD; Wed, 04
 Oct 2023 10:18:27 +0200
Message-ID: <6c80ca77-1db7-4feb-8349-7ccd8e96819b@gmx.com>
Date:   Wed, 4 Oct 2023 18:48:23 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filesystem corruption after convert-to-block-group-tree
Content-Language: en-US
To:     Alexander Duscheleit <alexander.duscheleit@sweevo.net>,
        linux-btrfs@vger.kernel.org
References: <3b73ff33-34f9-4a98-a73b-19d91f845343@gmx.com>
 <49144585162c9dc5a403c442154ecf54f5446aca@sweevo.net>
 <418ca57f8e70d044bfc8f0822557d91f4aa7dc07@sweevo.net>
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
In-Reply-To: <418ca57f8e70d044bfc8f0822557d91f4aa7dc07@sweevo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hob3uGqepbuV/wj9cQ3hs7kLJfFIxNuQFj53B+w8dW+yXuur6+j
 NWW8wYdeVEBi+s5ISnM4xWhSG5IQili+CtUvuDmodcSjwE2Kl7YotCLLHqSRX27ybt9wmyy
 laQof0DW+5T2N305IshNS+UXXiy/iKKbtvx/LsVqkWzhw2lh04THf6iONBe6fYRmmpMoTDU
 qTbMyuTQl3Me9XrWJ2ddA==
UI-OutboundReport: notjunk:1;M01:P0:gUNHDJ0x77M=;e29MKE1//Mk4DGoP9x7vVgsX93H
 SuRm6hnYP1Xy8KVX1vc64PDl1FIhxGmk6WOvagJ9WLo0bRymQYyixFpBOHfN7pXngmlq56X2f
 +eXA0VyokY3o0RbMh1S31KiuOBBmfLTMxqlw5bD9y9z4bOwr9Hou+BhdYefiJMaYVL1mQl+x/
 Kkoy4TtWi4fUBxkmFIBXE2ny++kJCdtkPDxr0LwYGnJIuSDCe3t+psMZ4rFf1uN95v695ooJE
 xSE6QNAcRySrJ79O2Ayp7vtdv8YNWRgpEs+7yy6BRbrq3rL85yhap+JBk1cuuyq//dsMRjqMZ
 wiOz32YZMvlMsu5m68iZN7G/qrmxHAkRXtvYvW9I9YjEZQh+ATTOfkj1gsMMbTuUDadJLM+j5
 fR4v9mX41FecqRdJFzkbRkkHRXgQKBCarabU77TE2hl7qRHU+H9hWsXo/SwYmqCRBzGDPA7XV
 Ckqw/cpVSevstdPxjLqfCrfFncYaqTFoJHQJik8obNmLTpjeQVTrRn6vUw5TraHw28qNVYvRA
 S/6ZH5t2lh+l4ltiOjguDgXAu7O1OO3THqIDFSfswLeHT3/AFF4+c4AKLdegNGYNDrX28QNLX
 jDIz0VAAAj9fq7MSNBrnXFb3ZLS6MpoGKPcZ1bEaQ82tbTKBaDKVjFhwt/z8TXDEB+DlcSurb
 rHYg/UfN1Zk/uMw/o/Iknq5ndDAhE/laSEpFcdvMIN4N451w2AElRGd5eTFlikF0BV5eVFTO9
 HAP2Ex2mDPS0o4tNWUdipHjlKVDhKDHFu6IQWhJabJcQRQrViA92aeztm61LKANRPwzDzP2hk
 23
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/4 18:12, Alexander Duscheleit wrote:
> 4 October 2023 at 05:27, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:
>
>>
>> On 2023/10/4 09:47, Alexander Duscheleit wrote:
>>
>>>
>>> Hi all,
>>>   earlier today I tried to convert my BTRFS filesystem to block-group-=
tree and the operation seemed successful at first glance.
>>>   (I unmounted, converted and mounted the fs without any error.)
>>>   Some time later I tried to access a file and got an I/O error.
>>>
>>
>> The error from the dmesg shows a level mismatch in block group tree.
>>
>> However the block group tree itself is always fully read at each mount,
>> thus it means at your first mount, the block group tree is good, or you
>> can not even mount the fs (unless go with -o rescue=3Dall).
>>
>> So I'm afraid the corruption is not caused by the conversion, but
>> something else, after your initial mount.
>>
>> I'm more interested in what happened between the initial mount and "som=
e
>> time later".
>
> As far as I can tell, nothing. The array contains mostly media files, bu=
t
> also some minor backups (borg-backup). I didn't put any new media on it
> during the time in question and no backups were running.
>
> After the conversion I mounted the fs, restartet nfs, re-mounted the nfs
> share on the htpc and then left it alone. I didn't do any operations on =
it
> besides a ls to confirm it's "there".
> I noticed the error when I wanted to play some media file and the player=
 threw
> an error. >
>>
>>>
>>> after some updates, reboots and troubleshooting I ended up in the foll=
owing situation:
>>>
>>>   The fs cannot be mounted normally, but it mounts (consistently) with
>>>   -o rescue=3Dall,ro (see attached dmesg.log).
>>>
>>>   No data _appears_ to be missing or corrupt.
>>>
>>>   btrfs-find-root throws many errors concerning corrupt leaf blocks bu=
t does find the curren tree root. (Again, see attached log.)
>>>
>>>   Is there any way to bring this fs back to a useable state without st=
arting over from scratch?
>>>
>>
>> It looks like block group tree is corrupted, but without a full "btrfs
>> check --read-only" it's hard to say.
>
> # btrfs check --readonly /dev/sdb1
> Opening filesystem to check...
> parent transid verify failed on 7868411314176 wanted 41293 found 41370
> parent transid verify failed on 7868411314176 wanted 41293 found 41370
> parent transid verify failed on 7868411314176 wanted 41293 found 41370
> parent transid verify failed on 7868411314176 wanted 41293 found 41370
> parent transid verify failed on 7868411314176 wanted 41293 found 41370
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D7868939862016 item=3D336 pare=
nt level=3D1 child bytenr=3D7868411314176 child level=3D1

OK, this mean is way worse than I initially thought.

With your dump tree (the only working one), this means one extent tree
block has written into the location owned by block group tree.

This breaks the very basis of btrfs metadata COW, thus a huge break to
the fs.

Unfortunately btrfs progs is not clever enough to ignore the block
groups tree corruption and continue, thus no further corruption analyze
from btrfs check.

 From this stage, it's really hard to pin down the cause.
I can only recommend to salvage data first using "-o rescue=3Dall,ro" for =
now.

Thanks,
Qu

> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>
>>
>> Extra dump on the bg tree can also help (needs both stderr and stdout):
>>
>> # btrfs ins dump-tree -t 11 <device>
>
> yields "ERROR: cannot print block group tree, invalid pointer" for each =
of the 4 devices.
>
>>
>> # btrfs ins dump-tree -b 7868411314176 <device>
>
> Attached
>
>>
>> BTW, btrfs-find-root is not that useful, thus it should only be adviced
>> by developers, but at least it does no harm.
>>
>> Thanks,
>> Qu
>>
>>>
>>> System Data:
>>>   # uname -a
>>>   Linux hera 6.5.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 23 Sep 2023 22:=
55:13 +0000 x86_64 GNU/Linux
>>>
>>>   # btrfs --version
>>>   btrfs-progs v6.5.1
>>>
>>>   (Note: The conversion to block group tree was done with btrfs-progs =
6.3.3 and Kernel 6.4.12.arch1-1)
>>>
>>>   # btrfs fi show
>>>   Label: 'hera-storage' uuid: a71011f9-d79c-40e8-85fb-60b6f2af0637
>>>   Total devices 4 FS bytes used 8.36TiB
>>>   devid 1 size 4.55TiB used 4.19TiB path /dev/sdb1
>>>   devid 2 size 4.55TiB used 4.19TiB path /dev/sdd1
>>>   devid 3 size 4.55TiB used 4.19TiB path /dev/sdc1
>>>   devid 4 size 4.55TiB used 4.19TiB path /dev/sde1
>>>
>>>   # btrfs fi df /mnt/btrfs_storage
>>>   Data, RAID10: total=3D8.34TiB, used=3D8.34TiB
>>>   System, RAID1C4: total=3D8.00MiB, used=3D912.00KiB
>>>   Metadata, RAID1C4: total=3D24.00GiB, used=3D23.93GiB
>>>   GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>
>>
>
> Thanks,
> Alex

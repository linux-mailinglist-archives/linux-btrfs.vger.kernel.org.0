Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1930358778E
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiHBHKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 03:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiHBHKk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 03:10:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9547E24F03
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 00:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659424231;
        bh=czpzAJkvurFeI3W+eY89FRRXELdkC35BpMQMr1slufo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=c3dOENQm9jqtwd4o2F2sPVudd9nB6asdKhyvRf4y7XQ9VbRdfkgOaVbndb3Y4dytc
         Jjk0kivrYt3L7R0fJtamucHObYQVwxKabu2L4G+Y/HAaBAWoGdqA5uhnmF5VTWbint
         +vMhEneI2djs6w++3AxJ5FmSt/Ma/H9gQvSSbzpE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1nTgxd42K7-00swRo; Tue, 02
 Aug 2022 09:10:31 +0200
Message-ID: <56e54ceb-17ac-ba44-93eb-809882482310@gmx.com>
Date:   Tue, 2 Aug 2022 15:10:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: mkfs.btrfs failure on zoned block devices with DUP metadata
 profile
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20220802060323.khfjqwhwwbpjbegb@shindev>
 <75e18a61-b868-764a-50e5-c6df7ade326a@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <75e18a61-b868-764a-50e5-c6df7ade326a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+SqHT6qQbT++Qo93nL1KxZZhKhtpCj5tkFxsZDIufn8BmqCCYE/
 A7kA0lUtQj6rJW13lVI7MEXVF0PaeNJtepHizttCbJZdsvN5gebA6/yoOclzY7xWBH1lySm
 MZRTYmJ9F3vTFnEoVXDBgo5vIRo0xg/PIveC7bLNzdiGhSSpkjhTTScfcE4gMe9cikqEJ/n
 /lTZqgTg4eD6QFpvsD2lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Kpahy5sqPs=:TU1yw/FrI2XlGHWtRJGEj4
 FyNmujnAXgOzktVMOJvcCNF7qLfl31ieQzoa6/tM7mTfvEIWHhY9c7szFvTixKzRTOjOyoXYO
 hsX7yOUjueGoSjHLo+w4TXswTQ+ROoq1gkO7xBONRQ8muuLYRNrIMWlFrMbCOrY6gABlg6Avq
 E7JHj1v9ni5Dqd2/3jG68Rb8j7KiWoyjuLXL2giEm4Z5FcWdmxadsXox5VPsgHqRON6dbrlk+
 YVU4iERHIe46HeHyb/kobRjCbqfjTDOBbmj+fP6AMgwcprMJfj8GqnVmO6ZR4iq25u4BQ0COR
 dx1NH27J24boobdWGq2PhwyUlK4AIdLK2R7KqqO2APAib9XC+IeVUXxwzHx9jIVdzMN2QAk3l
 oyLO0dauKtLnPWU11wQKKB63lUXgPPGaTy571XjkGF/CRZ7YlUmEvhSRurY9Zf6E1WGJq0q93
 1+Hvm957jdiAaQasXufGhrW2o2p6bpJl6aVTEMbCoGvRIKKNTz+EIo2h7cQfo/gIzwwxMyuwC
 f+yqrzsPjV8YDQOooot/lyUY+YEbbn3T5ZQlCsCwX7y5FQrM7y9+MYCTIn5zwj8DkBKqzssH1
 pK3Ywr8iQv2wulm2ODkRGQkWz+vC9MEAKuGuSjCFz8W1lj/tnoNLLfg2t9eAoEgxbzmMeeqVG
 qjoZ05BhlwDmsFZRxP9V7hCjr+1vAHYGeR6DX39Z3ONKdDXgiuc6fUikQkwGwfxDFrvPUIRAc
 391E6o2HtMFvBcEpNQrvKVfdNa6bdTR2qTZ9ckfky3VcXNotaCrb5uRK8xdd2DvbMxmKnSY5x
 biWkS+aDUsVyEr/VoSSJYHkSjvzkpna89sienNfij98n7/+TA/2sDk4kBqsewgQWgL2zuJYqk
 htJuZiE0aHfy+KXRYVrGMiy9M+InsT2xcFlC2Skmb3n+2ARMY5Dq8K98OR99JVqN35XELgw1a
 v6EOLPSYW2UcwdvOOTGuBXoG6elomo15NDTkg8eMtGx+RZh3D3cECH3zFaf6QnxwqeHENV/c+
 aLMuuU1pBbpzl1a39zhuwuV+sQoioEbH2Sz7tfaoYw3gjcnPPwq1EC9/Cxi+xL9RQ2gCYC2t6
 kzX/AtCp4b84L+Kmxpmiv5RK0/q3sTAu16jm4LI7FSKBel1EG1cusPtmQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/2 14:17, Qu Wenruo wrote:
>
>
> On 2022/8/2 14:03, Shinichiro Kawasaki wrote:
>> Hello Qu,
>>
>> I found that the latest version of mkfs.btrfs fails on zoned block
>> device when
>> DUP profile is specified for metadata. The failure depends on btrfs-pro=
gs
>> version and the trigger commit is 2a93728391a1 ("btrfs-progs: use
>> write_data_to_disk() to replace write_extent_to_disk()"). After some
>> investigation, it looks for me that this is a common problem for zoned
>> and non-
>> zoned block devices. Here I describe findings below. Your comments
>> will be
>> appreciated.
>>
>> On the failure, mkfs.btrfs reports "Error writing" to the device [1].
>> At this
>> time, kernel reports an I/O error, which indicates "Unaligned write
>> command
>> error" to sequential write required zones. With strace, I observed
>> that the mkfs
>> writes data to same sector twice. This repeated writes were observed
>> regardless
>> whether the device is zoned or non-zoned. It does not cause an error
>> for non-
>> zoned devices, but it causes the I/O error for zoned devices.
>>
>> Using strace, I compared the write to a non-zoned disk image file
>> before and
>> after the commit 2a93728391a1. It shows that the commit introduced the
>> repeated
>> writes to same sectors [2]. Is the repeated write expected after the
>> commit?
>> If not, common fix is needed for zoned and non-zoned devices.
>
> Thanks for the detailed report.
>
> To me, the repeated write is definitely not an expected behavior.
>
> Although a quick glance doesn't show me much hint, I'll definitely look
> into the case.
>
> My initial guess is write_data_to_disk() has something wrong related to
> the mirror iteration, but no concrete conclusion yet.
>
> I'll definitely keep you updated since this incorrect behavior is now
> affecting zoned device now, and it will be treated as an emergency.

Pinned down the root cause.

It's the write_data_to_disk behavior not correct for multi-copy profiles.

I just added some extra debug output:

For SINGLE profile everything is fine:

   write_data_to_disk: logical=3D5341184 len=3D16384 mirror=3D1
   btrfs_pwrite: fd=3D5 offset=3D5341184 count=3D16384
   write_data_to_disk: logical=3D5357568 len=3D16384 mirror=3D1
   btrfs_pwrite: fd=3D5 offset=3D5357568 count=3D16384

But the problem is related to profiles with multiple copies (DUP included)=
.

 From higher layer, we will call write_data_to_disk() for EACH mirror:

write_data_to_disk: logical=3D30408704 len=3D16384 mirror=3D1
btrfs_pwrite: fd=3D5 offset=3D38797312 count=3D16384
btrfs_pwrite: fd=3D5 offset=3D307232768 count=3D16384
write_data_to_disk: logical=3D30408704 len=3D16384 mirror=3D2
btrfs_pwrite: fd=3D5 offset=3D38797312 count=3D16384
btrfs_pwrite: fd=3D5 offset=3D307232768 count=3D16384

But inside write_data_to_disk() we call btrfs_map_block() which will
always return the full mirrors for write.

The fix can go either way:

- Don't try to iterate mirrors when calling write_data_to_disk().
   Just pass mirror =3D 0 into write_data_to_disk.

- Make write_data_to_disk() to really respect the mirror number
   Thus not really passing WRITE for btrfs_map_block().

I'll evaluate above solutions then send out a proper fix.

Thanks,
Qu
>
> Thanks,
> Qu
>>
>>
>> [1]
>>
>> (/dev/nullb0 is a zoned block device with no conventional zone)
>> $ sudo ./mkfs.btrfs /dev/nullb0
>> btrfs-progs v5.18.1
>> See http://btrfs.wiki.kernel.org for more information.
>>
>> Zoned: /dev/nullb0: host-managed device detected, setting zoned feature
>> Resetting device zones /dev/nullb0 (64 zones) ...
>> NOTE: several default settings have changed in version 5.15, please
>> make sure
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this does not affect your deployme=
nts:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - DUP for metadata (-m dup)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enabled no-holes (-O no-holes)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enabled free-space-tree (-R free=
-space-tree)
>>
>> Error writing to device 5
>> kernel-shared/transaction.c:156: __commit_transaction: BUG_ON `ret`
>> triggered, value 5
>> ./mkfs.btrfs(__commit_transaction+0x197)[0x4382a6]
>> ./mkfs.btrfs(btrfs_commit_transaction+0x13b)[0x43840a]
>> ./mkfs.btrfs(main+0x171c)[0x40d64e]
>> /lib64/libc.so.6(+0x29550)[0x7f5108629550]
>> /lib64/libc.so.6(__libc_start_main+0x89)[0x7f5108629609]
>> ./mkfs.btrfs(_start+0x25)[0x40b965]
>> Aborted
>>
>>
>> [2]
>>
>> $ truncate -s 1G /tmp/btrfs.img
>> $ git reset --hard 2a937283~; make -j
>> $ sudo strace -y -s 0 -e pwrite64 ./mkfs.btrfs -f -d single -m dup
>> /tmp/btrfs.img |& grep btrfs.img > /tmp/pre.log
>> $ git reset --hard 2a937283; make -j
>> $ sudo strace -y -s 0 -e pwrite64 ./mkfs.btrfs -f -d single -m dup
>> /tmp/btrfs.img |& grep btrfs.img > /tmp/post.log
>> $ diff -u /tmp/pre.log /tmp/post.log
>> --- /tmp/pre.log=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2022-08-02 1=
4:12:19.670688371 +0900
>> +++ /tmp/post.log=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2022-08-02 14:12:=
47.019382686 +0900
>> @@ -32,36 +32,66 @@
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 5357568) =3D 16384
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38797312) =3D 16384
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92471296) =3D 16384
>> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38797312) =3D 16384
>> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92471296) =3D 16384
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 4096, 65536) =3D 4096
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 4096, 67108864) =3D 4096
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 22020096) =3D 16384
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 30408704) =3D 16384
>> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 22020096) =3D 16384
>> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 30408704) =3D 16384
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38813696) =3D 16384
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92487680) =3D 16384
>> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38813696) =3D 16384
>> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92487680) =3D 16384
>> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38830080) =3D 16384
>> +pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92504064) =3D 16384
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38830080) =3D 16384
>> =C2=A0 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92504064) =3D 16384
>> =C2=A0 ....
>>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B09542F0C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbiFHLU3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiFHLUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 07:20:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFB93D11CF
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654687199;
        bh=xrFu3xZEfkIEoOnPIExq9Y6yXnfuKzAGQWGMcSlJSMk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FdKmCVS2/ztah9rZS6lzyYm9lOTCOOlzLDuds83hjflmK5Cq6VE6k2gJogmx/H3H5
         8CZAZBwkq9Rgo2WGnyteRuwRomC0xG733YE8ilUozaxSbR5bRqmjVTM3QuSPnfePT4
         La7eGBlahI4XWAixhkpjKwyQBN+OmIiHV30xOjkw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ3t-1oDaQt1HgD-00WFHQ; Wed, 08
 Jun 2022 13:19:59 +0200
Message-ID: <d1d47581-9003-2202-55ca-279b2ca4dba6@gmx.com>
Date:   Wed, 8 Jun 2022 19:19:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: What mechanisms protect against split brain?
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20220608181502.4AB1.409509F4@e16-tech.com>
 <a97ff3a3-7b14-e6a4-32e9-b9da8cec422e@gmx.com>
 <20220608185805.41ED.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220608185805.41ED.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wfykY9+4vSO40IXgRKK3kkP4Oa0n8DJ0zMvcHi85GQvB4dymN0E
 IAN0PE69GJ9/mXJ2FgRe8rYPmjbkYWleJNEwsPp4R4n/04JOMtqCivNTFHv53lMU/ZXjHJo
 Ud/lF99/jgzrnxV6af6oq13hgcc6uRPjSJ5DgSIGAUOixZSLiT4vFeyPIctYQPw9Jf/et2j
 sMEfDffaaFhMDynda/+GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9rA5p+FO6l0=:xHrs4HGyHxR1XWU1rEkl3/
 4XmRoTZQK4SYHN7FjjI5i+UlvHzJCHg4OCz5d8hjmbj/5TEQA3UvYZ6KUTKvotM1SjFq66FiF
 gtDfcARQIv+LevISyNCvieBOKPOw5mB1qQl6j625uio45QyL+QvPQwdBzBzkYsJQVvfE3pAdt
 grPYFemocIMJgMxFIosNgbF1DjEujrWGl8L8qnF/RpMZU2Q8EZkywoyW76ao3i75zgyJNcOcn
 EApW/NcUEnSTZYIaUS2O5/vGEmFffjT/XkeCy+wyow1KbMvy8czY5VyarjZ9gTKJTb5uhpX8O
 e9VvEcfsvqW8NqPfAfKs7X55kYSIpMAeADHpc9n4LaxLIcVPScggOTlknGIPbH+st4CEhK12T
 H9H2HCoslZMSjNxP3xxg/GCJiVu08WOHbjitsz1kyA9Gpz/9Zn3k4l11Jxfcm79Gvj1WmRcOP
 7jV36xY3pMRigmP1PJSgzvAUe7kobTiXFhJ1bq5JIQstyjeMJN6nqiymIg5yPNZPpmZtPstUj
 LXl2gsFi6v+jWZvIu/vctpSSfRD/Ef6qhHXuAX4zPahWuZkhhhgu5AJD/+diUjMx0xIR18nlr
 YpdZlG2rwlBesk2o7jqdewENI7UwG923MbuI5x2bN+NXvSljCrJXpGXrPdQByjfXW+98MqWfP
 l1FE8Rolr1PIncGgxNP1V+WZCV+z2jzdIvYt3tYdZbMijh7MZENcg8PtogoWuNxfk+qB8O9DA
 ROFRGoHeYcnt19lzcGZNPBQd5ElIIITkixGUhonNMOScZByXMD399l87jJnU3D1HqV0YQQImk
 2/WCGVatXber1zQrbTGY84eU4CR6bm4usMVTmsalgVIScNpbs0dBFvsx8EDpWqkfNnW02nqBv
 JYYWScRlF77bJp7PDOYCTnj6z1BCj48wVdHa+z5vLyvHRZj7xqt4xkCUEVr3TzEZNB/Wcmtqz
 lq96ErEGyL5bEa4dcNw9OX3a2hLpMuJdH9K0Y+SAS0jbaHVSANQEz8XcSQ0aMF6e1jDDhvTwb
 9ubq8RLR7Hw0wXpGMbZ7uSYSXyUkIlmgBlOi176JPGu558tZbsZ1Ut4zGTxKG9HGfWGaTV+s5
 mSJyJF0p0kUmNYW1h/7s58Exq4xf/AIhuHDxyzd5UQn44Yw5ZifAA7C4A==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/8 18:58, Wang Yugui wrote:
> Hi,
>
>> On 2022/6/8 18:15, Wang Yugui wrote:
>>> Hi, Forza, Qu Wenruo
>>>
>>> I write a script to test RAID1 split brain base on Qu's work of raid5(=
*1)
>>> *1: https://lore.kernel.org/linux-btrfs/53f7bace2ac75d88ace42dd811d48b=
7912647301.1654672140.git.wqu@suse.com/T/#u
>>
>> No no no, that is not to address split brain, but mostly to drop cache
>> for recovery path to maximize the chance of recovery.
>>
>> It's not designed to solve split brain problem at all, it's just one
>> case of such problem.
>>
>> In fact, fully split brain (both have the same generation, but
>> experienced their own degraded mount) case can not be solved by btrfs
>> itself at all.
>>
>> Btrfs can only solve partial split brain case (one device has higher
>> generation, thus btrfs can still determine which copy is the correct on=
e).
>>
>>>
>>> #!/bin/bash
>>> set -uxe -o pipefail
>>>
>>> mnt=3D/mnt/test
>>> dev1=3D/dev/vdb1
>>> dev2=3D/dev/vdb2
>>>
>>>     dmesg -C
>>>     mkdir -p $mnt
>>>
>>>     mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
>>>     mount $dev1 $mnt
>>>     xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
>>>     sync
>>>     umount $mnt
>>>
>>>     btrfs dev scan -u $dev2
>>>     mount -o degraded $dev1 $mnt
>>>     #xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
>>>     mkdir -p $mnt/branch1; /bin/cp -R /usr/bin $mnt/branch1 #complex t=
han xfs_io
>>>     umount $mnt
>>>
>>>     btrfs dev scan
>>>     btrfs dev scan -u $dev1
>>>     mount -o degraded $dev2 $mnt
>>
>> Your case is the full split brain case.
>>
>> Not possible to solve.
>>
>> In fact, if you don't do the degraded mount on dev2, btrfs is completel=
y
>> fine to resilve the fs without any problem.
>
> step1: we mark btrfs/RAID1 with degraded write as not-clean-RAID1.

Then when to clean?
Full scrub or some timing else?

> step2: in that state, we default try to read copy 0 of RAID1
> 	current pid based i/o patch select policy
>             preferred_mirror =3D first + (current->pid % num_stripes);

That's feasible, but still need an ondisk format change.

Furthermore, this idea can also be done by a more generic way,
write-intent bitmap.

In fact, DM layer uses this to speed up resilver, and handle split brain
cases.

With write-intent bitmap, every degraded write will leave the record in
the write-intent bitmap until properly resilvered.

Thanks,
Qu

>
> this idea seem to work?
>
> degraded RAID1 write is almost the same as full split brain?
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/06/08
>
>

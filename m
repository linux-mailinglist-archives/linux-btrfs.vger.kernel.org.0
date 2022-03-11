Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC604D6B06
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 00:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiCKXka (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 18:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiCKXk3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 18:40:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494312A95
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 15:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647041962;
        bh=v4pFIAybWl3vrjOwj3UDvQQ//o+/wl1aeVxKs/h+ddA=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=jq6Je6v4uKt8zVEgAY8KSSi6vSm056L1dOIwuTF0GOxtLpt6Zr5lgl9b0Sa6PhUYS
         cnofeIS3U0GR7wurA0wZugIC1YqaXBWzrQAN96jkTr7KEcJdFjpjCQUCaxKV+KoNwP
         zaBDgJEnwbVRHrpGIRtpp9Kqn/Q6gOgloxEx+lgQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiaYJ-1o6X7u2Cd5-00ffkS; Sat, 12
 Mar 2022 00:39:22 +0100
Message-ID: <452af644-e871-20e3-60b2-f69a92dc406d@gmx.com>
Date:   Sat, 12 Mar 2022 07:39:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
 <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com>
 <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <CAODFU0q+F2Za=pUVsi1uz9CLi4gs-k1hAAndYmVopgmF9673gw@mail.gmail.com>
 <CAODFU0pxmTShj7OrgGH+-_YuObhwoLBrgwVvx-v+WbFerHM01A@mail.gmail.com>
 <e7df8c6e-5185-4bea-2863-211214968153@gmx.com>
 <CAODFU0r=9i2mOwNXVx74GcKUSt4Z6wGqshgD=5bktFhoXCWE4A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
In-Reply-To: <CAODFU0r=9i2mOwNXVx74GcKUSt4Z6wGqshgD=5bktFhoXCWE4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HICIFF0Y/bEqaTbrQ86Hr7huVo11bx3nWPpKE/PwCdNg4Tu6xtK
 fb2Fu0sEcCVAY+QItbrHzNFrLiSjkO7ePYh6Ok0dhwmPZ3f6K8YKfdJj4ZvFAwytd9OLN0f
 gWIBi37bIYMZQsmCPl5PzAxYxxGw4SlVCKMExt7HRt5JQ+G2Za4HPPbdhOVBUTNm9IbMj+U
 XWBt5NRaqPHLLkaOpSPIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pmgtCQNwUJE=:Qi6deE5o8Gde4bquVK0km1
 MUG/MGS4k2p7/CpiJtCtRQEnN7yvXeB/QBZUop5zlf8hcUOrTatKCb59NgvV8ou3SFgRUorE3
 mu5m9MZwlugZZSzABuWwn7CCc/22AV53QdUTysagho8dSzPnz2QNwLkiMMFOJ1Ovn8gRH+Dnv
 8lRbYStca8jI5gMoaiGG6/7xCnul1p15o2dZdl26FV1x/Oq0HVNkQ+knQeZFniOyZFffu5REV
 G6+x76Hdut0QMsR1KRwfclNEM8YJSc/D0lqCJnQOZQs2ZuTNy7ROaBsazhSdbZp5B/2enzAng
 ZtkzG3kUj6hN7KwtA11CgqXB/4bmNzAD1Sb8U3CRxzhkAKYuNPlp1pu5iX+SK8qzMFRFoGTvb
 rFwIjCb6u8SzkGjjIMMlUP4qGOJixU6OXnoPzZR2XmB3dJIo1fRVDUU7uyDlC94JTXf6w+uIr
 sU51bEhLXFhZpDiI7hCLi+ka5sBBzBdOcVw5bkixzyuAaMnnaZ+SxhW0CA3xRjIITeiTbExKL
 xRtlJp/+nWxj2CWbTp0ssmLNT1eBWyY7fc1vz1IhakS8rwwFdmTsz4GdJHbaXpikcJeGwRmMp
 boZZDI4ohi0Tep8AyDqJrw9RHBUl7mBYjz6Q5xroiAypxbS08uA7ozEf93DOl0wrjKFbsI51z
 7a1bVBSK3m6+yuvxy+vm4fUMM0jrW+a81QCUcBF+BTjX827Sig1LVL1xXDgYnggpdaShXrGhX
 hdi+7jBz8f95r4QFtoEus0vs3mSt+x7nAYOrZdOICqpzg94kuudG/r4KWUAmXZUpiv2h7NDBq
 4lgixnMYd+k5YvpytZu1EuBxWw71ZeXszlsI71S/ul3X1yQ62GFi6DaJX60E4ecPzygoptCvb
 7EZ6L1G7lzFaf+d6AbGSL8O8HipYjTvuS8AhUoWP6TS8rtbueQ4PXlQZNTM97OX2VmOWH67v3
 FC3/iC68wQj5hT3hEEXgZavPIXeVS/ciU39jbi7qC0LTgRhkf46DDq8rPjTrWzz+ENr6rGQGF
 CqYCwEs4ybVMqpHfJJY5Q36bVFsS+rMfgqBDDF87gP7Jn6cEVGKv0sycGWC68pZrvuUn43pep
 IP7gbqK82IKDIQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/12 07:28, Jan Ziak wrote:
> On Sat, Mar 12, 2022 at 12:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>> As stated before, autodefrag is not really that useful for database.
>
> Do you realize that you are claiming that btrfs autodefrag should not
> - by design - be effective in the case of high-fragmentation files?

Unfortunately, that's exactly what I mean.

We all know random writes would cause fragments, but autodefrag is not
like regular defrag ioctl, as it only scan newer extents.

For example:

Our autodefrag is required to defrag writes newer than gen 100, and our
inode has the following layout:

|---Ext A---|--- Ext B---|---Ext C---|---Ext D---|---Ext E---|
     Gen 50       Gen 101     Gen 49      Gen 30      Gen 30

Then autodefrag will only try to defrag extent B and extent C.

Extent B meets the generation requirement, and is mergable with the next
extent C.

But all the remaining extents A, D, E will not be defragged as their
generations don't meet the requirement.


While for regular defrag ioctl, we don't have such generation
requirement, and is able to defrag all extents from A to E.
(But cause way more IO).



Furthermore, autodefrag works by marking the target range dirty, and
wait for writeback (and hopefully get more writes near it, so it can get
even larger)

But if the application, like the database, is calling fsync()
frequently, such re-dirtied range is going to writeback almost
immediately, without any further chance to get merged larger.

Thus the autodefrag effectiveness is almost zero for random writes +
frequently fsync(), which is exactly the database workload.

> If
> it isn't supposed to be useful for high-fragmentation files then where
> is it supposed to be useful? Low-fragmentation files?

Frequently append writes, or less frequently fsync() calls.

Thanks,
Qu

>
> -Jan

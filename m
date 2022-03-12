Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1C4D6B60
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 01:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiCLAQp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 19:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiCLAQp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 19:16:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3CF11C03
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 16:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647044135;
        bh=JglsZiyGqgI8L5eqK5Pee9tS0AUW3158kevLEAZPZSo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iSQe2GIVQSIAgF42CH4seezhbtHVo6B2BYn3mu3GMcDPYdxSWptGp5891z/L6Ui4F
         V39U5BcaXvhbk2I6nSg8F0OCGeGp2iURn+jGlwAoMhDdKn6Ss3ip3qBrl9gkC8lQJl
         4iWUQ2WYbl99LNX2qIc1nXJFmwOb8dWDOf7KkGSU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLi8m-1nkMIo355E-00HgEt; Sat, 12
 Mar 2022 01:15:35 +0100
Message-ID: <71d5b72b-6a6a-8d66-f20b-6c8872545537@gmx.com>
Date:   Sat, 12 Mar 2022 08:15:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Content-Language: en-US
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
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
 <452af644-e871-20e3-60b2-f69a92dc406d@gmx.com>
 <CAODFU0oWBvRkpM3oirpfitGiTex8=EST021egQzUiBCMYrhVVg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAODFU0oWBvRkpM3oirpfitGiTex8=EST021egQzUiBCMYrhVVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pH+zlYVFXj/R0bnWGVRl8oTyaof8V8GS5NPnkJDxmBwmfK1NtVQ
 ehP87j48qqzu/NCA902PmmcqvYCGmsJZLQnkIUD1v4XhZbpvKuR9ozlvXbU7pskEflRH9Oy
 JWH4clSaGFiDaQhnmZUQy7PdjN+KTMUwNpwdpnMfJbjrwyuQWcTWmVJcywEZnuORsquixWX
 TjAL26KUd/DrAdcupyDHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/FQOIZ6m4PA=:DNj8NJgHauJanwSS/I+ixP
 ggHmLGSzc6VAgadJU+47MZsIXXuAkmCsPev4wTY8Jj5zBbr8OLMgQ42RuGzwa2sJvo12RguLl
 72aoC3aW9uH70CRCwREhpEqSVnFwkx461FiqWs8zei5gnVbQLAf9mFATjBHq5X4KQeCa2uneT
 Z1u6r/J8zOgt6iDsijcaV6rPb4hAmz6ltUsAQYHSNUGpX7YJqhIldGYaxpixFnkgkuOaUDNH2
 QmxP+3cIkQBmaSQQSW324nBkv9Wz/gSD5qyqCGO1vRoeEVW1qAtTZW3t0rcfsHrZLKzwMRq0N
 s3j7YDYpeGLtDMK/rbJgL28/T+8ZvIp22VFcT5Z0gxlUfFkawrWYCDq2pOYOxEW79Fl6QtTTC
 7AUiVdL0aWGzJOkDlyZJ/pidicmirTIIdZ+Qk1bkPbyXmztfkeZ7IvXrweRUB9Trb9zM3uXNz
 qMz/sPrVfajoUwZ2xC2/27/blUR582fBOaH84WQqmD7awepKMWxgCdZSeUn4NMnIC/eEK+n3t
 YLyXsS2xKoOXIwoMGIju0Kyk9EA4erphJOwEm4G0nhL9kmYsvTrfT1E51bXNA8Gp+B+fLIMsF
 1ara6IdOVzs6cmcJpbPhEMBpQ7RAtP+rwxyyMqW2nugm+lReLYlfkaw8zf9mH/pfx5nNxzz5W
 R6it0IY5AWEV8uskOusT51ko7utweLuizVA9A+SwgkiEt2pAm32Q9kFuhM82fzXmf2jk6ncB2
 5Zd/U1mdFeOSGDru3Fv2ZaEyAg+Yf/X/sQRSD2NvVxo/+o85r6wrhb9l0WgCsWKNzomXJ8OXx
 oC7nql5BNElaY1800X9Zub2y3muqc6vaKdFAHEAZ47fsgVG7AO1i3LQsc5hSXB++joo7W/2hR
 rmlg7V3pQX03nxe71qIRJM2rNEw18xoeLfiUWQQNEyWNB8PofQj+/6pb31C+l2pA7osH3v4kC
 Kt00YAp/sNCLZyqCz7KBtS8y8JMHY4LkNp5RTZxxBUl4rY6A+0JtCjwfU4HTuHno44TwiyDec
 m5tm/NFCkz80VD1GSYMWI30rMxzMjyZbgieH7WqIPuBBermweIfVDqC61xqCoZxUnsnL5eo/J
 Fdx3wYx7wgNXMA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/12 08:01, Jan Ziak wrote:
> On Sat, Mar 12, 2022 at 12:39 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>> On 2022/3/12 07:28, Jan Ziak wrote:
>>> On Sat, Mar 12, 2022 at 12:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>> As stated before, autodefrag is not really that useful for database.
>>>
>>> Do you realize that you are claiming that btrfs autodefrag should not
>>> - by design - be effective in the case of high-fragmentation files?
>>
>> Unfortunately, that's exactly what I mean.
>>
>> We all know random writes would cause fragments, but autodefrag is not
>> like regular defrag ioctl, as it only scan newer extents.
>>
>> For example:
>>
>> Our autodefrag is required to defrag writes newer than gen 100, and our
>> inode has the following layout:
>>
>> |---Ext A---|--- Ext B---|---Ext C---|---Ext D---|---Ext E---|
>>       Gen 50       Gen 101     Gen 49      Gen 30      Gen 30
>>
>> Then autodefrag will only try to defrag extent B and extent C.
>>
>> Extent B meets the generation requirement, and is mergable with the nex=
t
>> extent C.
>>
>> But all the remaining extents A, D, E will not be defragged as their
>> generations don't meet the requirement.
>>
>> While for regular defrag ioctl, we don't have such generation
>> requirement, and is able to defrag all extents from A to E.
>> (But cause way more IO).
>>
>> Furthermore, autodefrag works by marking the target range dirty, and
>> wait for writeback (and hopefully get more writes near it, so it can ge=
t
>> even larger)
>>
>> But if the application, like the database, is calling fsync()
>> frequently, such re-dirtied range is going to writeback almost
>> immediately, without any further chance to get merged larger.
>
> So, basically, what you are saying is that you are refusing to work
> together towards fixing/improving the auto-defragmentation algorithm.

I'm explaining how autodefrag works, and work to improve autodefrag to
handle the worst case scenario.

If it doesn't fit your workload, that's unfortunate.
There are always cases btrfs can't handle well.

>
> Based on your decision in this matter, I am now forced either to find
> a replacement filesystem with features similar to btrfs or to
> implement a filesystem (where auto-defragmentation works correctly)
> myself.
>
> Since I failed to persuade you that there are serious errors/mistakes
> in the current btrfs-autodefrag implementation, this is my last email
> in this whole forum thread.
>
> Sincerely
> Jan

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98074725BB0
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbjFGKfm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbjFGKfl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:35:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CAB106
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686134135; x=1686738935; i=quwenruo.btrfs@gmx.com;
 bh=TO/99CIGb014W5RlOtoS3il9s7Hkm3D7FIR35NrU/Qw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=GD6gPwAy2BpqxqLHW9RCpKdZuSIKWLxrWBJOHZar8FWSahm+CzioeaFnNQ1nMrpI7fbFSSF
 11RRPzMgxUtuWME2DXD64Ktw2iC9eVoSLH1rJTPakb77KLxPShmxRbD1mDVLUuosmbgMJKHDF
 in/lNK3lwbjsx2v7E3W8ctvp0wZk3qkeMWWKl7PVGz2fyrcT3jpy157gxEsw+/A3ZIhaPF4OQ
 cH4MSOIKlzx25473wrz1llQSl4Q8DIMzukPZDKVkpXSwFyt/Lq0SFuqlqpwzdPSd+JmJN4voo
 5KtbYrLbbTn75qtxFdaH7K1QjSqgjslBWGX74ugL7LCRs1a1PdyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2nK-1plYRQ3HdK-00n6SF; Wed, 07
 Jun 2023 12:35:35 +0200
Message-ID: <4714fcf0-bf21-ceba-96e0-0ed096fe91b7@gmx.com>
Date:   Wed, 7 Jun 2023 18:35:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: parent transid verify failed + Couldn't setup device tree
Content-Language: en-US
To:     Massimiliano Alberti <xanatos78@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CALgeF5=8Www=aG8=6XXTYsiD-A=dBdGUN8Drj=h4d92yoZNXHw@mail.gmail.com>
 <cf225ad6-69f4-a339-2e7b-42f094a7b5fb@gmx.com>
 <CALgeF5ksBx0+0v8yGu3XECPkDZJZB0tBAeHt+1MUAXLEa67QPw@mail.gmail.com>
 <01d99c0f-da3f-0d2a-8437-b065bc610eb3@gmx.com>
 <CALgeF5kFsrBSfUQS9p2sq0xPHJJYcykfnPAe4TP_XM=zXE65tw@mail.gmail.com>
 <383d593a-c26f-bd5e-022f-4f5bd04b4715@gmx.com>
 <CALgeF5=xkkSpoW8WqqTtfYszOe-jTiS5Ntxy==MNdm=meLjwgQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CALgeF5=xkkSpoW8WqqTtfYszOe-jTiS5Ntxy==MNdm=meLjwgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yQHI+usWJ+uQhUhizPJ8wzcebdXwUgMaxdUsj9h6YfiLooY34SQ
 XudLwWzZ/krmlkicOc4QWfyCXKm1vyvlZlG9DdI/3RgKFlYTI8VtcoZxe+iPwThFY40YEtP
 AXnIT8ybDwzHFvXFo3lp3csCxYt3WxXWu7hZFc+Me6I//TpKMQGOoau5ppRcdVT3VnQGUCl
 pGnseGLyS+6qLExulas6A==
UI-OutboundReport: notjunk:1;M01:P0:3OqE2ajdHDI=;/LOrlcQ185tUs5W1+w/Nb/4UUp2
 hMgSd7i/ef3p5tuRUKKqZIhCDgZnVlaidnkIsEwkxauvjzSjpovJt1LMqaGHVrPsykQO1rCrb
 z19GZMdi161jfiMWFuu3VBf2MHIZFoTNNs9yMgp3s39EksXkVTbhLQnBfb8nlO0hsw8gXWGfN
 GgcZeFbVE2sG9O+wblvb9y3XRJ1kDbQWs2s6GfWI9szjVMXvn0yBs4LAK1CYNMjCg0AfOcn2Z
 qhQuT/PzFMWcKJ8aJ2lVS9iuiMGSpghP4HypinYM28nsYgOO64DnPqzhoYRS1IHEZlo0S0HI6
 tEA5SenQ+0WBkGotNn5R01yQ4/MWxNQeYxn9ZbAp0hJBTu+Ns6gT2WYLu9gr+GoQgvZ/5KGmI
 Det9/cztWaA7PfE3NTYVIaPXipmWBrNv6SrdMCMtAUjGMM3bWfrVbI3UvALnRA1epQJweEw60
 J1bXPXH7RyPOLa+R6kE5iUv0NDRbjUNDj6dFbWGrNgJm8TaQyqiPGsBecQ/ypGElAEbQVPnbC
 vK69+H4lsV0nLzgTN69FNusKu0DzIhmfgu8FBe4FyO5EeEksGS4nEOu47debQBuBtHxAtgUDG
 e3za4aGOK1bEJRQ0NvQIS8iBBkwGKq4d0r0Sh9L0IQS9fw2moJ6pazh79SFIh7kYgkksjdEPq
 ic0vL0ueT3y5YsHnic41aRBj41OTeinE+NGs+gQclf03NqJged+oUkkcHEHWNHSoGZcPT5qMm
 FIlr1EvrjydL/gtKe/AkNk02RUFV4AEC9gKF39EvwM0gqFvH2w9r+MBTZYjowDealj2B44Z5o
 7TYtKPGbuwmaj+RAuCh1SoWAieEo0YMxiI6BSzUfOS9yAL9kblwxawPeudJtR4eGE+OmEwblM
 B7F78N9JygFkr0OJ25V7DuQA6uie9AUUvBdLiwvTbQglvctazDJ8ucSJ2+4tYrYrpYPCiMSb8
 aDEztR1b6BqVt8FSkQXk3PpipBY=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/7 16:42, Massimiliano Alberti wrote:
> Ah yes... It was even written.
>
> [ 1234.138677] BTRFS: device fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
> devid 1 transid 9196 /dev/sdb1 scanned by mount (6062)
> [ 1244.472400] BTRFS info (device sdb1): using crc32c (crc32c-intel)
> checksum algorithm
> [ 1244.472420] BTRFS info (device sdb1): enabling all of the rescue opti=
ons
> [ 1244.472422] BTRFS info (device sdb1): ignoring data csums
> [ 1244.472423] BTRFS info (device sdb1): ignoring bad roots
> [ 1244.472424] BTRFS info (device sdb1): disabling log replay at mount t=
ime
> [ 1244.472426] BTRFS info (device sdb1): using free space tree
> [ 1244.499999] BTRFS error (device sdb1): parent transid verify failed
> on logical 4390576160768 mirror 1 wanted 9196 found 3295
> [ 1244.500563] BTRFS error (device sdb1): parent transid verify failed
> on logical 4390576160768 mirror 2 wanted 9196 found 3295
> [ 1244.500589] BTRFS warning (device sdb1): couldn't read tree root
> [ 1244.508357] BTRFS error (device sdb1): open_ctree failed
>
> And yes, it gives error.
>
> And even the btrfs restore gives error... So there is no hope for the
> data? I have some backups, but as always they are incomplete, not
> updated...

Unfortunately the data is gone mostly.

Sorry for the loss,
Qu
>
> Il giorno mer 7 giu 2023 alle ore 10:35 Qu Wenruo
> <quwenruo.btrfs@gmx.com> ha scritto:
>>
>>
>>
>> On 2023/6/7 16:26, Massimiliano Alberti wrote:
>>> The dmesg
>>>
>>> [  288.076822] BTRFS info (device sdb1): using crc32c (crc32c-intel)
>>> checksum algorithm
>>> [  288.076844] BTRFS error (device sdb1): unrecognized mount option 'r=
escux=3Dall'
>>> [  288.076975] BTRFS error (device sdb1): open_ctree failed
>>> [  345.636207] BTRFS: device fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
>>> devid 1 transid 9196 /dev/sdb1 scanned by mount (5926)
>>> [  345.639381] BTRFS info (device sdb1): using crc32c (crc32c-intel)
>>> checksum algorithm
>>> [  345.639407] BTRFS info (device sdb1): enabling all of the rescue op=
tions
>>> [  345.639409] BTRFS info (device sdb1): ignoring data csums
>>> [  345.639411] BTRFS info (device sdb1): ignoring bad roots
>>> [  345.639413] BTRFS info (device sdb1): disabling log replay at mount=
 time
>>> [  345.639415] BTRFS error (device sdb1): nologreplay must be used
>>> with ro mount option
>>> [  345.640184] BTRFS error (device sdb1): open_ctree failed
>>
>> Forgot you need to go with RO mount option, "-o ro,resuce=3Dall".
>>
>> But considering the root tree is corrupted, it would help much.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Tried btrfs restore (no hypen):
>>>
>>> root@ebuntu:~# btrfs restore -D -i /dev/sdb1 /
>>> parent transid verify failed on 4390576160768 wanted 9196 found 3295
>>> parent transid verify failed on 4390576160768 wanted 9196 found 3295
>>> parent transid verify failed on 4390576160768 wanted 9196 found 3295
>>> Ignoring transid failure
>>> Couldn't setup device tree
>>> Could not open root, trying backup super
>>> parent transid verify failed on 4390576160768 wanted 9196 found 3295
>>> parent transid verify failed on 4390576160768 wanted 9196 found 3295
>>> parent transid verify failed on 4390576160768 wanted 9196 found 3295
>>> Ignoring transid failure
>>> Couldn't setup device tree
>>> Could not open root, trying backup super
>>> parent transid verify failed on 4390576160768 wanted 9196 found 3295
>>> parent transid verify failed on 4390576160768 wanted 9196 found 3295
>>> parent transid verify failed on 4390576160768 wanted 9196 found 3295
>>> Ignoring transid failure
>>> Couldn't setup device tree
>>> Could not open root, trying backup super

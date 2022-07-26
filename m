Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433BD581BF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 00:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiGZWJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 18:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGZWJJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 18:09:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E90357E9
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658873345;
        bh=IVzJtL8Cv8lKufLPmIZN8nWMCPYNq12ZBTm15g2aZPg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=UcubzE+4FXhz7TiikBrsNdzc/1msSncP9JMg0QjB9LDRq2shYebh1V59GyAHOPLuq
         fRSeI2Ivmmr8ciFNYfTt/DzysG15Stqx2i4JqGcMAgNRkuq7j6uQTY7zpEqKF+D8OW
         wYdUe7sxUPUAhhk9t0lr8TDGwOhyYRK8jlLhvUA0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3KPq-1nHRw21HNK-010Ox1; Wed, 27
 Jul 2022 00:09:04 +0200
Message-ID: <27f3ed12-6b94-d370-279d-aba825d5a643@gmx.com>
Date:   Wed, 27 Jul 2022 06:09:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/3] btrfs: separate BLOCK_GROUP_TREE feature from
 extent-tree-v2
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1658293417.git.wqu@suse.com>
 <20220726175922.GH13489@twin.jikos.cz>
 <56492a5b-8d98-38af-50f2-57a75a3417fc@gmx.com>
 <20220726215252.GQ13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220726215252.GQ13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3v2NIsC7hbuny6syXFEmnESduPjLr2SDgbUQP9utf4UHgcRjBDc
 3IEgk09hFjElQX7kejus7k1aLzwmNj3Ji7Fc+Dh7DsEgZDqaFZjfxmATQTi0mfURRjWtFtk
 s4XKXOl6Keb5K+UD/WjWwL5kJ+cDfckAgupMTxbtqOmxPDaz2VGHTP9mt9IlS3wTIDNh+Br
 +/mBvAUBSHwqqA5ipKQUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J0aKWXFLtTw=:h46Eq8FpSUFxFUtn1gbyKe
 14Zi+Ib+oQQ+h3diHnqAiErRWvCQq5FjiN0/js0GkizTvs2lXj4F2PK2snequ+OoWAX0pkAc2
 B77l0oY1XAd635K7+sQP3N5/XISHyjiJ/n62YKqkKc+4+83lVlV8kGpchbNDziEn1KBOjqKn1
 1Maza1xGNvaIiGwL04eR32nE+wGfdDDq3oxbdlDYT6O35yW/p0bcwtCqcw8bugv8JLan/K8iY
 Xww+RT1m0jtd4wp793QczngL4o7yFKARwT13qlMyLTDOpRoMPNZI2K2I1hY8AVmBIM8YD9Ea7
 fvO1eCC1QmTV4WtnUGSaTneG8Dt21S4hgZ4DbHHh5xSvKsPWg6O1tF6EpMm/6x/ICbahpx24z
 Us1rr53w1QiAPsc8HY97WY0rZMXQC2F7wFl0goZQ6KnBNyx9Jy8ijxnIXFVhZQnpPIt5s0C0V
 tktndlAHnseSwf4dk7mhznPsk3Hhd2aMtGFIKYWy3+q0EnJjL3rXFeo/7o9dqU3nsmDFm0Unv
 BKlaDBXp26KSLfnzmmsGvatuYfB4c2aKRExaCd1/opqWQTOS2ZSv7Gk0QiQVHzPNgPpFVi4kB
 3/Kqo2ykmr8fXEnowLDuvzZ0SjZATSNXSj3pn8TkI+H37j51WsQ2z9PtAQCiIWBeDgmAsivBG
 2zwiOprmR6COnjz+QQkOiX044CgjcRdSy6GlRkw1k5udRQqlPaydd7BuGuEf5wm5hOB+u8jF8
 8e397nOkFfBEGuuRQloix8Pip1srwBie08DCV09dwuOals38gB4RjfQmFgfmFBkcF9Ss3djH1
 3blIL7/j6AUxGckf350bEKBy22daEoYW0iu8dMj8VUongZnQi/YLOethnJ3Pngocc1ema1uAG
 PrMDXa27k+uHsIbM0CKnQBsQCm4fm1A9voknH/8EZS5tygzk7nC1F+68GXVywBntJCfujNkyD
 VbWw3zSZdSMlFWXRMrnoJZd8qLybgKL3b5p8HPFqHL9SotxJDaKHV3WMz6isda/mnXS9v+WC7
 9JekA83uZQbaD0zqgXTA+oAhZCaUc1TgQXVIePyWJ/DqTHuUPyPjTHyPn32BpaMlEiuju9T/5
 8YvYEmvNCa064gjumfLGxcCzPxsI7hJPD9AylJJ/PeYVkSVbYkzCejcTQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/27 05:52, David Sterba wrote:
> On Wed, Jul 27, 2022 at 05:47:25AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/7/27 01:59, David Sterba wrote:
>>> On Wed, Jul 20, 2022 at 01:06:58PM +0800, Qu Wenruo wrote:
>>>> Qu Wenruo (3):
>>>>     btrfs: enhance unsupported compat RO flags handling
>>>>     btrfs: don't save block group root into super block
>>>>     btrfs: separate BLOCK_GROUP_TREE compat RO flag from EXTENT_TREE_=
V2
>>>
>>> It's short series and I don't see any new code to use the separate tre=
e
>>> for bg items, so it's on top of the extent tree v2, right?
>>
>> Yes, it's based on extent tree v2 prepare code that is already in the
>> mainline code.
>>
>>>
>>>   From the last time we were experimenting with the block group tree, =
I
>>> was trying to avoid a new tree but there were problems. So, I think we
>>> can go with the separate tree that you suggest. We have reports about
>>> slow mount and people use large filesystems, so this is justified.
>>>
>>> Will it be possible to convert existing filesystem to use the bg tree?
>>
>> Yes, that's completely planned as the old bg tree code, btrfs-progs
>> convert tool will be provided (mostly in btrfstune).
>
> Ok, good. I'm thinking if we should go for an online conversion too or
> not, because on a many-TB filesystem it would possibly take a long time
> but the benefit is not to unmount and do the conversion.

For my previous tests, even TB level (used space) fs, it only takes
seconds to do the convert (although on SSD).

For HDD systems, it would be as slow as the mount time for the convert.
Most of time spent would be just searching the block group items,
writing them into bg tree would be super fast though.

Currently I'm working on a multi-transaction solution in btrfstune to be
extra safe on the convert.
(Previous code is one transaction to do the convert, which may or may
not handle thousands of bg items).

>
> We could copy what the free space conversion does on remount, for bg
> tree implemented as "set some flag via sysfs" and ten trigger remount
> that does all th work. It should be less or comparable work to free
> space tree conversion, it's basically copying the block group items to
> the new tree and deleting from extent tree.

I tend not to do any convert in kernel even it may not be that complex.

Shouldn't we keep the kernel code small and put the convert thing all
into progs?

Thanks,
Qu

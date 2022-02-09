Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C61E4AE5CF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 01:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbiBIARf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 19:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiBIARe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 19:17:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D558C061576
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 16:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644365850;
        bh=bClZc0dg5wng+fsB6TdWiik2pGDzF+W0/LVpHLnhX2k=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KibSDF052J61pftvjYO4mNh++OH3J+AIoeydSic+CrAoHxzSvakK1IBV3zJe1mCpG
         AxHu4KewUxn8L9OasHenO1qc2ppPVwKblK/tddOe8gxAswkgC8Oj0dUTRHlgucogTy
         I2P1VzV1eCiIunPINvnq0pJ7MunTMkPp629EA25I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvLB-1nivGe3lun-00Rtaw; Wed, 09
 Feb 2022 01:17:30 +0100
Message-ID: <b50e1856-f03e-8570-6283-54e5f673a040@gmx.com>
Date:   Wed, 9 Feb 2022 08:17:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 0/5] btrfs: defrag: don't waste CPU time on non-target
 extent
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644039494.git.wqu@suse.com>
 <20220208220923.GH12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220208220923.GH12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vm1vJWcS08WmKORNw6AQOxCgqimcs+JAahLJjHT3MqDb6mM0C7t
 BC1D2TMPBsOPToHBPaSTjc8FFQwAXvxzM3gVj9JKmKo+EOqDZpC+L7ieim74Wx4KrH+iAql
 zmOg3GfPU54tta4VibR6xfxqJoeho2rLlW14wF0TBotNUqGQyePERvyclcN5N1gCiXX92Dt
 Zv9G33zMamLMfRJ9APCzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CQ51NNDF4rs=:CC/O15haaTM1/2HwkkjDL6
 1P3NUfH0DaW7Ic1N88X6W/tAO8Q6MYS5l+acDk7nwQ2Y3OJ7p4VPsNvr84OOP+R8oI8Zpjb0S
 6ataWOrb7ViHaZn3kTb98WUtt6cXJiEkcjuaguFADKF7oyb7CgHiR4t3BIG351ySm6SSjMQK8
 ERZ0Rq4H/6nqPC3Plhibn7Y3WA5yHhYZTriSM8bnH/9fGiig4UM9qgIcO3mPn5Y3083INt0lv
 VJCr7cyyH3GJZ/4RzuqmOWCx8dKB7djC0MDEXD2ugsJp/xZgq48aTiIXnu3r9hOVHpqY/D7Pa
 d1SwSPfDeDd01sDG/PVnX2KpMwCyRCmPJpzMYIchT/JUxNI6qMs6iJf0fjuu4y4avQDTI/Yde
 I0ow7m01ontMJm0IUs3P9L2fXr7OHDjEKsl28DlOEYm5TnmKntqiA/PFNUfHLoz8MyUApqVWM
 25qzLNrNl5rVqEXxRiw0eMIx72GQTFetbO01gV6TxCRyC5ynfB9cUDjtro1G+yejszFZLXrjd
 LIxybj3FeKsf1uiwQmqVq7L04CLgKpJfU9Mj1cxlZGg8JGIu5kK5K9n/UBB0f2DKyTooroBvQ
 cNAU5ZQHOaV36BV3dMbqPQBOg58RLEoCiDmm1eKaUhWtHm+E56VfhIRznu5kv25wDD14U5CVC
 lDA21x0ZW2CGaPlRU7Bk9BfLaqowoV7BGOL4PbRYkGv8mIj3gK+baR7z0cs7IF56IUu6uE+fX
 ABFedbB0JaPArtmKZlq2lD55g5b6qV58csx8vQ618mBLUgdJxDC03dmcbWqX5dHGBlkeIUIdP
 2xec/hOQtjgCX7dgVB9OmuQywiK1rqsgKNHGNHSMHs29bZ5QfYq6Izg8L/ILuEHeeHr697or+
 JUk+kIlpUvoII9/bpsKXLeL6sWc8is7OfwSoN0+00DEZtlupevUKhhiUlK2WvKvP/anWDYlLY
 7hOzhB2pU1rSkpGwfu8cEYGVb320BKixyq0BhSh4AxQ1d1uMRwCoPLNYNp0ZwamtUfd6SBpA1
 FU/CqSHj67YGZT5Ows1LXTIXrL4BEG/ifUTqJBaVevUp5JUDNADTNcMWrTwkoEnTUcpT/I0iC
 GbgTE0x0ZrRBoY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/9 06:09, David Sterba wrote:
> On Sat, Feb 05, 2022 at 01:41:01PM +0800, Qu Wenruo wrote:
>> In the rework of btrfs_defrag_file() one core idea is to defrag cluster
>> by cluster, thus we can have a better layered code structure, just like
>> what we have now:
>>
>> btrfs_defrag_file()
>> |- defrag_one_cluster()
>>     |- defrag_one_range()
>>        |- defrag_one_locked_range()
>>
>> But there is a catch, btrfs_defrag_file() just moves the cluster to the
>> next cluster, never considering cases like the current extent is alread=
y
>> too large, we can skip to its end directly.
>>
>> This increases CPU usage on very large but not fragmented files.
>>
>> Fix the behavior in defrag_one_cluster() that, defrag_collect_targets()
>> will reports where next search should start from.
>>
>> If the current extent is not a target at all, then we can jump to the
>> end of that non-target extent to save time.
>>
>> To get the missing optimization, also introduce a new structure,
>> btrfs_defrag_ctrl, so we don't need to pass things like @newer_than and
>> @max_to_defrag around.
>
> Is this patchset supposed to be in 5.16 as fix for some defrag problem?
> If yes, the patch switching to the control structure should be avoided
> and done as a post cleanup as some other patches depend on it.

I can backport it manually to v5.16 without the ctrl refactor.

The problem of the current situation is not really ideal, thus I put the
refactor first.

Thanks,
Qu

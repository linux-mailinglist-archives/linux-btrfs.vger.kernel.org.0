Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5BD583BAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiG1KC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 06:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbiG1KCy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 06:02:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BAA62A52
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659002568;
        bh=my1JbZyzke8wBm1bUsMNCA90RdABGuPNbx54gz9/G6k=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Sahilyp+C8Th9dLLIXuP/AwoZ1c/QTG1zCkeAPnqdA6kON/B/sbjzma9gaE8VYDOl
         AyEFMsYDZxWHvsJWgwRo9WBtumtrH13nhkSXeLCe4L5/Kny4Xaiy29bAjzoyNNGau3
         r6xteVEtB2bxVO6AYyvuayANR+3z4kILDFcO89iI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oG5-1nW1wI3ThF-00wnSv; Thu, 28
 Jul 2022 12:02:48 +0200
Message-ID: <46235fd6-8b31-9291-5025-b4305be1c678@gmx.com>
Date:   Thu, 28 Jul 2022 18:02:44 +0800
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
 <27f3ed12-6b94-d370-279d-aba825d5a643@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <27f3ed12-6b94-d370-279d-aba825d5a643@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KchXthrIQZ7JWlRD4/QGe5Cmrvgk5ZcP2cCtZY9I2cJiLp9O265
 EzIu4Mkec/fusevZcyYbdHhJD2R8WdMLpRt+Uq3ZA+dC5zkGEyS+3h/E9DfmCSCGka8EkU7
 LYACbO38xcUGipmhn0gyMzPbS8PXi3MKrGhJTaU35EFnMQQLTfJgTgXVv/mlQCmBfz+jQmM
 5Uvuzi+wESYX31zB2N8aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X83M0Fid8Q4=:fTK382mWE5YcRvCuJGtJJD
 6eRM9TR9xsB4lqbZyxHvtkvl8AJjyjPsg8ZimWiv/l/cDmVz2YyWkB4M4DBuI7QLKvvX5sZi2
 fMhcKa+/f1HYQiBuHZlbgqMT54C3ghXNzGiZHaImxi0yZPgnpt/4MyNgzBJ6Y0PdMxcxiXIL7
 Z7nuIxBjRawqGRPSVqi7PapC4TSpkoi2jaWp95Ee7PIcMAHhAQgAny2bEGxsa+t1M/1DKN0bB
 1W/rft051vA3WLF5P+xZCO3jUqqTZ44iRkjJV/ziZEORXkHrq4xbhSEEpp5UjCbpfM0WVO/6g
 RRGkqOfeCOXlppJGE1YHexp4lxbhXdtc+bLumqRFEPo8fjpvf/Kf9mqjpeNmxSFwIltkLDeFz
 lO+PoCVC/K6xBgMAmU3sXkefLp0Bxz+3JwEJ/gmm+O9S72S/uETTEdbWKL32/VVlu2wBokyXX
 KtHPFLTbyjQT0BzUsw6/j52EilBQZd+kMzwvRR5aPeyEisYAjLnlWdVwVdWdmhNHdX3axyYxt
 n+p3j76GfRnOmdx4O81YbJSarc65zCP+AAwP0/9p4VecYczxvAtoS+EDH8VksBw/krH22UOS2
 l23yOUk7EOxW7niApCyCbJ0D34SsPd6GRhqaFllJoEVPIxp3Vjs+4VSNnV3LzSKv5o5EarcmF
 OQyhUpONTgCBEEs03vmMBM9HvyggRqZ9BYILDpYrL8sXH90ISgu5OvFON02k9fGP1kDbS7HsG
 348XI4pcWgHvdfE2Pg/sSjftS34LsgyEkVCP8bFp6CqHWHFrz8NjikAjVsxvSKDhR/O9KXEH+
 H+7ako1y1YxA38bTcPDF2g5w13m+xOKHDzDw84FEJp++zcsU3UJuHA9/LaPnokN6qc9bF4L7N
 UruMPdNY5rBea6MDiRlVBTNZWx+GdeXAJBbKS9279gc56Fk+yE/SRu2G+xiQ0jUew+kB9SjXC
 Ig//aGgI9uNbw9VmMZ0aSr/phfUq4yH5p6bNC8CTnuwxQPDLETXi+KuPYZQIYVU3GMceuc7yx
 JBV1YhrxDvhDfa8wsrgIjBfi5eAT54q7hDsPI6bsDK5A4kbP4bOiNqc/iWI1ZqML2wuJFzhw+
 9Sz0tYZbCgyJxiPveuV2BgskpuQQg0EJ/ryxUASnqfs32UmgW52jwhIMg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/27 06:09, Qu Wenruo wrote:
>
>
> On 2022/7/27 05:52, David Sterba wrote:
>> On Wed, Jul 27, 2022 at 05:47:25AM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/7/27 01:59, David Sterba wrote:
>>>> On Wed, Jul 20, 2022 at 01:06:58PM +0800, Qu Wenruo wrote:
>>>>> Qu Wenruo (3):
>>>>> =C2=A0=C2=A0=C2=A0 btrfs: enhance unsupported compat RO flags handli=
ng
>>>>> =C2=A0=C2=A0=C2=A0 btrfs: don't save block group root into super blo=
ck
>>>>> =C2=A0=C2=A0=C2=A0 btrfs: separate BLOCK_GROUP_TREE compat RO flag f=
rom
>>>>> EXTENT_TREE_V2
>>>>
>>>> It's short series and I don't see any new code to use the separate tr=
ee
>>>> for bg items, so it's on top of the extent tree v2, right?
>>>
>>> Yes, it's based on extent tree v2 prepare code that is already in the
>>> mainline code.
>>>
>>>>
>>>> =C2=A0 From the last time we were experimenting with the block group =
tree, I
>>>> was trying to avoid a new tree but there were problems. So, I think w=
e
>>>> can go with the separate tree that you suggest. We have reports about
>>>> slow mount and people use large filesystems, so this is justified.
>>>>
>>>> Will it be possible to convert existing filesystem to use the bg tree=
?
>>>
>>> Yes, that's completely planned as the old bg tree code, btrfs-progs
>>> convert tool will be provided (mostly in btrfstune).
>>
>> Ok, good. I'm thinking if we should go for an online conversion too or
>> not, because on a many-TB filesystem it would possibly take a long time
>> but the benefit is not to unmount and do the conversion.
>
> For my previous tests, even TB level (used space) fs, it only takes
> seconds to do the convert (although on SSD).
>
> For HDD systems, it would be as slow as the mount time for the convert.
> Most of time spent would be just searching the block group items,
> writing them into bg tree would be super fast though.

Despite the incoming multi-transaction bg tree convert tool
(bidirectional), mind me to update the kernel series to address one of
the concern from Josef?

To reduce the test matrix, I'd like to make bg tree to rely on free
space tree and no holes features.

Although those features have no linkage to each other, such artificial
requirement should greatly reduce our test combinations.

Thanks,
Qu
>
> Currently I'm working on a multi-transaction solution in btrfstune to be
> extra safe on the convert.
> (Previous code is one transaction to do the convert, which may or may
> not handle thousands of bg items).
>
>>
>> We could copy what the free space conversion does on remount, for bg
>> tree implemented as "set some flag via sysfs" and ten trigger remount
>> that does all th work. It should be less or comparable work to free
>> space tree conversion, it's basically copying the block group items to
>> the new tree and deleting from extent tree.
>
> I tend not to do any convert in kernel even it may not be that complex.
>
> Shouldn't we keep the kernel code small and put the convert thing all
> into progs?
>
> Thanks,
> Qu

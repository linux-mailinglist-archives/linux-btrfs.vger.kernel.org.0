Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4073E31F35B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 01:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBSAcq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 19:32:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:55417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhBSAcp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 19:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613694672;
        bh=8fn+gJnU3oezTgwDA0tRGsL3OAfzVaSOXDCuY2nXRzw=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=dHM+Hfez5nax9045GwC927iL2yhHPmnVgzWA3N1XusjVrAkcRLaNuxVKc+mYM/MZR
         qMY/yL2bI5UQjwotHHyndiKIHg1DD2ql1i0JhpAsBbg+XvTT2K8yhzcKQFCMkVm5Xy
         pNL7bekHHD50Hu+yS7ypiv3MbGoE/Pl/f6uMfG50=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mg6Zw-1lmnkP2VoM-00hgUS; Fri, 19
 Feb 2021 01:31:12 +0100
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210108053659.87728-1-wqu@suse.com>
 <6bc8bef5-43a0-f6c6-9b43-2f62a3e4e051@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: make btrfs_dirty_inode() to always reserve
 metadata space
Message-ID: <0cf1604e-f54e-69ce-23e6-b043e975cbf4@gmx.com>
Date:   Fri, 19 Feb 2021 08:31:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6bc8bef5-43a0-f6c6-9b43-2f62a3e4e051@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UY16ryqVAbvBHS3zoXSoUG/yLpwN19jgxEqlyipyM4D+64jAg3a
 a+uwXMcLdsGXCiN0Vyxz74zJhDhvO2Azh3MoxIs1otqR5j73IAwlJpFOyfWEMf4AhO9rUJm
 eJyHqfRNPc1w20M09y0hIodiEvl/RQ1Q8sIWgeOiv7h2xuyelm9xQJfsLssDsKb0mzERcTX
 sRYOULehcVpNl/Zyern0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ip/PpKRTVhI=:2OdEr0yGsjTtlcQMCWefJt
 k684YpHvEyPHF2+6GpjjW1MlE/i/r1JKJm5XmY3tfPZ1AmX+wdw2wSASQ2dYSC1LL8AQ6h7oT
 iLMEiqcO1jBrUmEsEiyLGMEBS9qQ8lFs3v5FKOlz4pgqwkolKzLZb7JunNtcJsxdVP93pV0tV
 +UiO+jdAg9+HdMFwfWZGUAC8H305HoEXcLGBDgZTYFBpmO9g15bvAXEEiMTxNxdEbbpvuTufB
 8geaptglpHTuGAsyqw1280SfC2iZ4gHOo8m7t4J0OOmU91wmPEmNNhyAAoJO60HvkJtTEFUFc
 HEwylf3/soO34vdZCXp7Wi27Km8Ms5ntVPuFC6AIXf1oq7v06NRnfmwsiocuZweZTwAO6qdTe
 VpFYJrNyOtvl5MxP8QnW8w+hcbFiNGtPobIxEM+nqnkUkqt3HH2yo0zrksmde3ItqQiz4OHq5
 ufUhUiYbNhwkdfKovPrZgtI3J1EdrIEPFJ5q6aXBG4gg2jZRp9JAlGStFOC6jEKjnhf3mjgrH
 nOsOTUJYInut5Ofi8KPunB17BOhEji/zHSCyPkUvc06sejZ3ESWZune6j3/LT5r5DQ6o/opFQ
 nkbsanzwu2ISKoea85RXBnnjzaWHWsy5KBddWVehJQzEl74SNfNA6gHXiw9NsS9M8wU0PNosK
 EGEikS/ENXYWyAAvaiKLKCD6wK/ZgUtjdTJgx6t7svYy5orrcstYRZTmHHFaMnHCU0djjHXFk
 ElPSgoOWgTQLSx0ZM2+0sVFt/R3iqllCfBVonefj6EBdElccTq1y6S/OIzmkT/yxWzELMuNmd
 GOYRLRrVmGDV3k+rGDSkNqY9Byc3rGCkc6xgDUTZjgIFMqWr5Eoqpx5fHhwFasUoph0FI62x4
 Ej7H4uPJUTds6VBsk/cA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/19 =E4=B8=8A=E5=8D=8812:14, Josef Bacik wrote:
> On 1/8/21 12:36 AM, Qu Wenruo wrote:
>> There are several qgroup flush related bugs fixed recently, all of them
>> are caused by the fact that we can trigger qgroup metadata space
>> reservation holding a transaction handle.
>>
>> Thankfully the only situation to trigger above reservation is
>> btrfs_dirty_inode().
>>
>> Currently btrfs_dirty_inode() will try join transactio first, then
>> update the inode.
>> If btrfs_update_inode() fails with -ENOSPC, then it retry to start
>> transaction to reserve metadata space.
>>
>> This not only forces us to reserve metadata space with a transaction
>> handle hold, but can't handle other errors like -EDQUOT.
>>
>> This patch will make btrfs_dirty_inode() to call
>> btrfs_start_transaction() directly without first try joining then
>> starting, so that in try_flush_qgroup() we won't hold a trans handle.
>>
>> This will slow down btrfs_dirty_inode() but my fstests doesn't show too
>> much different for most test cases, thus it may be worthy to skip such
>> performance "optimization".
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I'm not interested in slowing down the !qgroups case just for qgroups.
> We want to short circuit the start here because it has the potential to
> be _very_ expensive, when we may very well have space already allocated
> for the inode.
>
> The best solution I can think of for this is to add a bool to indicate
> that we don't want to attempt to make reservations.

The root problem here is, btrfs_dirty_inode() itself is an odd ball by
itself.

All other call sites are either reserving its metadata space by
btrfs_start_transaction(), or reserve metadata manually like delalloc.

Only btrfs_dirty_inode() is using join transaction and put all the
reserve logical into btrfs_delayed_inode_reserve_metadata().

>=C2=A0 The only problem
> here is if the inode doesn't have space allocated for it, if it doesn't
> we need to fall back anyway.=C2=A0 The speed up comes from inodes that
> already have the delayed inode setup.=C2=A0 So simply tell it to error o=
ut if
> we're not already set up, and then we can fail back to
> btrfs_start_transaction().=C2=A0 That'll keep us in line with our perfor=
mance
> for !qgroups and solve your qgroup related deadlock problems.=C2=A0 Than=
ks,

Can't we do the check earlier? Like before we start or join transaction?

I really hate to do all the error out check deep in
btrfs_delayed_inode_reserve_metadata().

Thanks,
Qu

>
> Josef

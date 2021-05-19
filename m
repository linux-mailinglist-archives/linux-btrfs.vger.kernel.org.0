Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D714F388396
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 02:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhESALL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 20:11:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:39893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234197AbhESALL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 20:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621382989;
        bh=iwC9Z2OzsrATg29T2tLy+2h6/EH4U/8QTrWDBRF/Z1g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ddC8BpYy7H4ePaoX8hXwLq4IeMXFZTny+aU4TAdzBVpUbw0X2ZW7gi8DhhzqpQu5D
         BfwuI7d7q7LkHhFpT5ZmqPhxaeuo+m5sDCNqD528YCHF1LKkxv/l1ujlhKkdhycdUh
         uglRWlKKQTPRRCmz80Px3jO1MgbPfDP5sA8Gi2mc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC34h-1lblnV3vgr-00CVLP; Wed, 19
 May 2021 02:09:49 +0200
Subject: Re: [PATCH] btrfs-progs: subvolume: destroy associated qgroup when
 delete subvolume
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210515023624.8065-1-realwakka@gmail.com>
 <7702abe4-f150-44c0-8328-f62d68f5a56c@gmx.com>
 <20210515133523.GC7604@twin.jikos.cz>
 <f52f74ad-d0e9-babe-b555-455fc185dbd7@gmx.com>
 <20210518160623.GA38825@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a907270f-26c4-be08-e149-b0e0f8f56152@gmx.com>
Date:   Wed, 19 May 2021 08:09:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518160623.GA38825@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MLrM+QWYCHEPyqr+wIhFgzClI4I1u+EyWXegU9LE9yiQUxPf+rb
 P9H7yELpGqysEVXB1hOcwCG14b3yGUm1Y7c3ZRzK1Lwx4McEnmyPxJXSTk0bh+s9VdKH40G
 NkI1PHmsYJDUYhWTfG1bWIsncv/JyeQs3ld4mkTa4WsC8+pz2hCrn4GcJlUMICLLI0QyxX0
 GohWhyiReH0rSsWHDQneg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rPdK8/uYOZs=:srBagYymCune1SJiArxuYO
 iGt+MNUVuFHmE5JSmyHjAfHHp+6AGUFRgfKbAm6zaapxlEEINHZbR0uaL1tyjaW7dbr/KSZD0
 9RvEkkQwJ+zlLpvaBirOoNtzClij8V/ja6t7MlmxZzw1sW5bEZ+VOaBj1XslwcM1COBuiz9by
 dIcLCMAWKAN3U4WqIy2xxEiYE9t6TzU23AIzB7GIYcUk2jfFSSJDBfcd79BzfDKhHxJDPB9or
 ZkSJIXTArKKlD9a6R4+8iDOwYAZE5LFhtQvZFi+F6AXYZMjUryCdSI8ztOtZTlig6sWcB1+2y
 B79UY/ElWfoopRb1IlV+hQOMVqd3f2EY4XcyX6jZh8gZWrben2HlFBOaW56HyoKG1J1Qm76/n
 cImU/yzsQgO8gXsEcSW5bxnXj0cF7ZOhhoutaXKG8DS7uvjrkXTe+kG6EhPQ0BLQwjDgFrJJk
 cbMO6zm88YnzlZY2TbcERDKN6GJfTHCIKZR9GdpTc23Z0QuCYaJkYej7ZMVDGCyghMXAqa4tM
 k5bctzTv1mQ+jTPcs2jM91whEl81alxghncd9yuBjhbnr/Oo1RXtxGIHZ+mQuW6JBH/NwWbD0
 gNr+DoAclmFEEksh2CEjPLRcqtOl/ux89R/wrPl3ACtcSfBzr5kcKyIW///jP4cgGmqYUQ6EQ
 f6GJFJ5X9RWCQIYv6C7pE8jjEFVU6AZrIQn/btzGOFnDgiihL0mRSYatYVOYjziWTLrF3wc7O
 uybUXvKgDfS1Oqu+3Dq8JaWswAkZV0UN/aWuxUq6W7xWhzqyI1961qLc1Lph3HoRAAaqk4Ngp
 C5wn3ZMkmH4Z1yenrif/JKcMjyMdrH3woDH1rs1EvqwgW540aGK2nOLzEwu7Qirt9Vx5Z0qKe
 QcaSFrIPxmOVaURMCAhttEtbRl7Baiek7+qfZ6PLcokAe0fj2hdCs7CSvgVVhI/70jeeac6rY
 Nzr0FltrPlyKKhMGnvrvFy5rlGGaGLiFrgiK6gkv6+xq/xRBQ6kDbfUibWW6bErqYm9/FMQDC
 IRZ9cAoJj2dhx6R0xqWSKpzbIYFuj5sAemlDMWvPTS1za/H84SNq0l15v63uo+OpDDBylxbq6
 rRFBUWiGj2w8wiMzM9u/klshXB2URWRyqllfdttK4hxe0qsUQUCAVf4fimTHvYw/1llpEkBy4
 qL6cmfYSOGmWOJz1hbkwoAGFSMpNvK1EHjEP2eHctupLuKBrRC5YrgFti+gwc0HYTdTMA82n4
 YQM7bkpF2I5nbRL0N
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/19 =E4=B8=8A=E5=8D=8812:06, Sidong Yang wrote:
> On Sun, May 16, 2021 at 07:55:25AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/5/15 =E4=B8=8B=E5=8D=889:35, David Sterba wrote:
>>> On Sat, May 15, 2021 at 10:42:15AM +0800, Qu Wenruo wrote:
>>>> On 2021/5/15 =E4=B8=8A=E5=8D=8810:36, Sidong Yang wrote:
>>>>> This patch adds the options --delete-qgroup and --no-delete-qgroup. =
When
>>>>> the option is enabled, delete subvolume command destroies associated
>>>>> qgroup together. This patch make it as default option. Even though q=
uota
>>>>> is disabled, it enables quota temporary and restore it after.
>>>>
>>>> No, this is not a good idea at all.
>>>>
>>>> First thing first, if quota is disabled, all qgroup info including th=
e
>>>> level 0 qgroups will also be deleted, thus no need to enable in the
>>>> first place.
>>>>
>>>> Secondly, there is already a patch in the past to delete level 0 qgro=
ups
>>>> in kernel space, which should be a much better solution.
>>>
>>> I've filed the issue to do it in the userspace because it gives user
>>> more control whether to do the deletion or not and to also cover all
>>> kernels that won't get the patch (ie. old stable kernels).
>>>
>>> Changing the default behaviour is always risky and has a potential to
>>> break user scripts. IMO adding the option to progs and changing the
>>> default there is safer in this case.
>>>
>> Then shouldn't it still go through ioctl options?
>>
>> Doing it completely in user space doesn't seem correct to me.
>
> Yes, It still use ioctl calls for destroying qgroup.

What I mean is to add new ioctl flags for the existing destory subvolume.

By that newer btrfs-progs can try to delete using the new flags,
If fails, go back to regular subovlume delete (without deleting qgroup)
and gives user a warning.

This still allows user to determine whether to delete qgroup along the
ioctl, and still keeps compatibility.

THanks,
Qu
> I think this code has pros and cons.
> IMHO, as david said, It also has some benefits when doing it in userspac=
e for
> old kernel versions. and give a chance to change softly their codes
> which use btrfs-progs with options.
>
> But when kernel supports this operation, maybe this code will always fai=
led.
> because the qgroup was already destroyed with it's subvolume in kernel.
> and the code will be meaningless.
>
> So in long run, I think it's better way to doing this in kernel.
>
>>
>> Thanks,
>> Qu

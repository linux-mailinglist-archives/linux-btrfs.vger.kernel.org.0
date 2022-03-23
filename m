Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24A54E4BF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 05:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbiCWElx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 00:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiCWElv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 00:41:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFD668FB2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 21:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648010406;
        bh=voNKk+jl/4dPcsbkCV/WuU8dMHYBpWtLAb7oHBKvtc4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=bEyz5Ig/t18LpGNFWMVu5dbIeGeHxesmHAK5QhYIfyUqN+2GFtIEEg5LndRfFLKlT
         judPRdgixEqKf1RvXMPY2+iVWr+CekK3BV88ODhU3ym8qu665aOn43Xn4rAnt5o8+C
         MNFUjF7AkWEzGw3i3DzujEANNG1Us4CG6wfujrnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6UZl-1nQaKq1lYf-006sYf; Wed, 23
 Mar 2022 05:40:06 +0100
Message-ID: <89f67d6a-2574-0ad0-625c-c921adf3a4f6@gmx.com>
Date:   Wed, 23 Mar 2022 12:40:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: prevent subvol with swapfile from being deleted
Content-Language: en-US
To:     Kaiwen Hu <kevinhu@synology.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, robbieko@synology.com,
        cccheng@synology.com, seanding@synology.com
References: <20220322102705.1252830-1-kevinhu@synology.com>
 <b1c66869-2920-9055-faa1-a84b05958289@gmx.com>
 <20220322193932.GI12643@twin.jikos.cz>
 <71bc3a52-ae07-3030-49f1-6cc176a0f16e@synology.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <71bc3a52-ae07-3030-49f1-6cc176a0f16e@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vs1Rd7C+QUpPXoWbu+Hr4pkzX9TYdWQAXXFqiUoR8ra6VC3rvD3
 5rWk1DJ+3hTGOornbMG2XGBR+gvXoGc2WkyOmf/z0pjg8KvrTGSGqk+lDEqso2GaahxVE3l
 kmOvW5QuZ4xaDrmaAdtg0Ytjclrg7EYmxWpMGFelk6X+/ara7afxsyPPalp0HfOm/8h8rk+
 RmkUM0j4avh7be3GqqwIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WZD9JLuvD8o=:QqUtHGENmVjoFn+rL1kk3t
 o6BHy4M4t1QUa+2Y4g0FDIW6v8VpNNfdScHSO6R/FiYVbAcBfYoFsHeCST2xtoNrTxpgIUxpM
 bKhG1U0c7yzzeddo+kr6pL0YrGkhh77/ehpemxicXFXXKY+11L6iOhXqGoqy3zTZHpQAZBtw5
 ViKP+aajkF0EBXD4XOJrut19SQJKR2WIHahbM8xzr2hlW3MQ7DBMjMS7GfBJKnlk0mXySj0rM
 81pM3wyM88+Z4RZpljmRWbIlq9EAm7xLnTl9EaVJ+A0hau74McFg3ROlQN5HPPi3SRoJW7PCT
 I4U1qT/IzdRM/FYLKD4XBmr8CQAw4b53oxsr30YPdpvaG2gYiS585W4bi5STdv+9xKsS5la/r
 BN9jtuTFtdgAG4QfeYjCE0e2ycQuhpRLubN4ynOc8poT2W+mjPNoq1ZReM1G1r0d79Ogx9lFe
 ZRLOMfHALYDNaNbQih+TZCWqLQrXVy+B1B9dq2opYC/xjtIInC6gd/H0BC68Zb2FW+w3MYYNk
 TvaFErG1Jp57/NiNNO1BbHqVKP83VsGtEmfZBPHEU2DZ1Jfd1lZo8fM9qbUpLeuP3iwogEqvI
 YCF/7NUhWh4wQ9KbAf0rVPmKWUhcupjcdCzIA4YWwNqHedU+EmsRp7jeX6Ul5fVl5zOt1TGfW
 R9gHozRl4c1+MuHitHvlwOH6RpxXRWqGWY4TczilKM2V7PRCMoXP48M+ESsQv4+IeCXJn28mg
 +1pMi6oC8gogtzjW0sEEcrN16Hi86QpkYY120G4qo07oBKDtI7/d4R4Kkzk8Der/llwcVt9Rr
 HuJUoDpTfMj9xjcmHL3QKOiGUEwKIGHVPf/Rtak1JJ1U103K71pYSkQC5i1wgHb2RxUBIGU8A
 joy0qgrWQtEmIeCa5b0YUj/sd+IB6arY+QWbHNC9zyBu3lEBiCpbYVTpxqjoliA1S0fj9hai+
 nL05/14+eDpRMX6jFHpYvmbxyr/20A4KLAjSQzXr9X9z0BB/2VFLRIBPe9jNAmAEN+zPYSlsx
 O+bRcvxPORq+sc2jrFqdIzDQiJbNbzhUIYrmfvvDSz0MgsWV5wMGeQY37RktLOQK3JR11KJZI
 XMawTF3xlOLMt8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/23 11:13, Kaiwen Hu wrote:
>
> On 3/23/2022 3:39 AM, David Sterba wrote:
>> On Tue, Mar 22, 2022 at 06:47:59PM +0800, Qu Wenruo wrote:
>>> This looks a little weird to me.
>>>
>>> If the root is already dead, it means we should not be able to access
>>> any file inside the subvolume.
>>>
>>> How could we go into btrfs_swap_activate() while the root is already
>>> dead?
>>>
>>> Or is there some special race I missed?
>> The deletion has a few steps, eg. the dentry is removed, root is marked
>> as dead and different thing locking protection.
>>
>> I was wondering about file descriptor access to the subvolume and
>> calling swapon on that, but swapon/swapoff is a syscall and work with a
>> path argument so that can't happen. I haven't checked in what order are
>> the dentry removal and dead flag done, it could be theoretically
>> possible that there's a short window where the dentry is accessible and
>> subvolume already marked.
>
>
> Thanks for david's help.=C2=A0 Yes, it is possible the subvolume is mark=
ed
> for deletion,=C2=A0 but still not remove yet.=C2=A0 So like
> |btrfs_ioctl_send()|doing, I check the dead-root mark before activating
> swapfile to prevent the race condition.

OK, I just went to check btrfs_delete_subvolume(), it's indeed marking
the subvolume dead first, before even starting to delete the dentry.
Not the reverse.

Then it looks fine to me, better with a short comment on it.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
>
> Thanks,
>
> Kaiwen Hu
>
>
>
>

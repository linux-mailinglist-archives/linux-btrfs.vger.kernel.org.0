Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5342BEBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhJMLP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 07:15:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:37519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhJMLPz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 07:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634123318;
        bh=DvCFP7mGlO1RR++LFi/30Dh5LlgcAdLHxDufTPhSYGY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=k22y/QpYcjQsmDrUImobjEtvx4vGbeHo8uBpLicRBvfmuDVPvbbHQRbxUOmwpERkP
         yGC10bSpckapggSPL87UaSKL3UERrW4htiCsIv2UnRs2g3hFs9NIiOgYU/AqosgR+U
         sSETtLecKsUKJx6Yk0wYouhAtFnECUt4Q7fpqtfw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VD8-1mpKgB36b4-016zQw; Wed, 13
 Oct 2021 13:08:38 +0200
Message-ID: <21e6d12b-66e7-f62a-ed5a-85545b67240e@gmx.com>
Date:   Wed, 13 Oct 2021 19:08:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] btrfs: replace snprintf in show functions with sysfs_emit
Content-Language: en-US
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Anand Jain <anand.jain@oracle.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1634095717-4480-1-git-send-email-wangqing@vivo.com>
 <6f03e790-6f21-703f-c761-a034575f465e@oracle.com>
 <20211013103642.GC9286@twin.jikos.cz>
 <ADsAzABEEmLRWHzgUOl4Sqr5.9.1634122164687.Hmail.wangqing@vivo.com>
 <SL2PR06MB3082B71AFE2C42CABDD5E6D6BDB79@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <SL2PR06MB3082B71AFE2C42CABDD5E6D6BDB79@SL2PR06MB3082.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hDBsCcL+tLSbf4UqfyT1cTsKG08lOZUe2f2oQRUUmbKisvlZogE
 agZbhl+iyHmcrpeWwDSibUdipSOjxNrXDhnXxoE5jpgPQvTiK2fo28Wk4omNr80/TNmNcVM
 ThvPyI5NpiSJ5Dbi7iFEuMNAQBA4/TICaSvoqD3Wm4NwShSH9FWioEaNvFGtKx+DHJpyDNc
 kb201wMm0wiMzVBijVpFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BX04yarxIoY=:TOl6rFpfFWbJe5PVyqFlQ9
 ZGcdMvLSHCNWArfHRzEbUnMqNmdoHQQPEkVfNKYbLND4PZaonZiZirI8QnG2awohvf0CTNAyL
 TRIOoisgPXWNzsbpHckjwVhFFGZQmAEqQA3+kjwaHYwTgm4oP4AGjvJq4vtVQyq5ALwvXkLr0
 5zFrPqXNpe6enNMv8ihewzkUs9aFG65BXUBYKst2TMFydfIl3zmrClcs/HjcvMa10jkMYn8Ld
 gzG+BLmVR919MVPB51MJZJQcqag6qgJbVYCBeLUFK8PnzEwvZNyxrdSc0cbjOYPnZ3KCAZWYo
 WVqErfo7mAZ8AckWu1PL2kiG3llvy0fDUpPyytWy+VxQnyMV7n1z95JXDi52zhPs4Ayw6h6J8
 i82M/x2paeaqYZktgNbNLALiDQ9wvKRIR3RDwIieeBstJd8bZY5DnrU+H6ywuaxWa7uw+jJXx
 +22agwzVJYgAA2Z16dEqUcg4+Qh1cIz+gsOeznyFSPbRqakt81HvcfRI1JlTLlePNuvPrH5gd
 9o/skSGGbxMssosuZrBSo4LCRSK8T/Y/xyu91dTsnOjPgJ9G+B2gcerK+YJlQFHmqENI5B0Jz
 hlnOYMdSYZcPN0xlgRE3x0JTkC1HHvFCHFP4EUfjuRnTwYMV5ZiqSx/aDQyKYTR026LtXCPup
 OiKXgoCwPIF187zklivJnOulPfB9Y3SAvKrHXWrFhMjyIm3hwxjNyoOi+3HSBhpyBLk4UN+cp
 owQeTNGE8CDhn1Myct23vzIegYyt4RVW53GEtAvdsmHS85Sn1k0PV6MgYgLfXJct3RxAYY0cw
 ANwEliza1SkA0Mgw9KDDNyFkWFAYUoGlPxWvGDW0A4sFMvprI+z3yEaP5IVCImjTR2qm+6ZVG
 0TWWAp9wfUy5e/3Nmwnx5zEPCCAlDDRLE7L5cImK3qhlewq80q2kJOk4g4vQ8CF0x+fmuz4ob
 SVv41JoGNJJc1Mcc79oO55wvV2XSJr0XqaQ2xTHB49efAj02pBbxtdrqbzY0DkVMLD/d/b05e
 /C5CEtojIliQjC4ZxEJZEWt3otS0RhJAQ+yT4/LISRXFGP7MDqeV3GXMyjppVCeIf2qOwqHah
 TfTPRTsfjaNQpc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/13 19:01, =E7=8E=8B=E6=93=8E wrote:
>
>>> On Wed, Oct 13, 2021 at 03:51:33PM +0800, Anand Jain wrote:
>>>> On 13/10/2021 11:28, Qing Wang wrote:
>>>>> coccicheck complains about the use of snprintf() in sysfs show funct=
ions.
>>>>
>>>> It looks like the reason is snprintf() unaware of the PAGE_SIZE
>>>> max_limit of the buf.
>>>>
>>>>> Fix the following coccicheck warning:
>>>>> fs/btrfs/sysfs.c:335:8-16: WARNING: use scnprintf or sprintf.
>>
>> IIRC sprintf() is less safe than snprintf().
>> Is the check really correct to mention sprintf()?
>
> device_attr_show.cocci metions show() must not use snprintf()
> when formatting the value to be returned to user space.
> If you can guarantee that an overflow will never happen you
> can use sprintf() otherwise you must use scnprintf().

I totally understand snprintf() has its problem for not returning the
real written size, thus not safe.

But sprintf() is worse, it doesn't even prevent overflow from the beginnin=
g.

In fact, for case that could overflow, snprintf() would only overflow if
we have extra bytes to output and doesn't check if the offset is beyond
PAGE_SIZE at snprintf() call.

But for sprintf(), it would cause overflow immediately.

Thus mentioning sprintf() is more problematic.
Only scnprintf() is safe.


But sure, sysfs_emit() and sysfs_emit_at() would be a better solution.

Thanks,
Qu

>
> My understanding is this is not only to solve the possible
> overflow issue, snprintf() returns the length of the string, not
> the length actually written. We can directly use sysfs_emit() here.
>
> Thanks,
>
> Qing
>
>>>>
>>>> Hm. We use snprintf() at quite a lot more places in sysfs.c and, I do=
n't
>>>> see them getting this fix. Why?
>>>
>>> I guess the patch is only addressing the warning for snprintf, reading
>>> the sources would show how many more conversions could have been done =
of
>>> scnprintf calls.
>>>
>>>>> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>>>>
>>>> Below commit has added it. Nice.
>>>>
>>>> commit 2efc459d06f1630001e3984854848a5647086232
>>>> Date:=C2=A0=C2=A0 Wed Sep 16 13:40:38 2020 -0700
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs: Add sysfs_emit and sysfs=
_emit_at to format sysfs out
>>>
>>> The conversion to the standard helper is good, but should be done
>>> in the entire file.
>>>
>>
>> Yeah, the same idea, all sysfs interface should convert to the new
>> interface, not only the snprintf().
>>
>> Thanks,
>> Qu

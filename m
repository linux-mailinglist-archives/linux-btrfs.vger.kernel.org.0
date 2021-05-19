Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3747638842B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 02:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhESA51 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 20:57:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:57925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhESA51 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 20:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621385766;
        bh=/KgpkmWwrYbc2RJiOpFPQQ7IDxlqHsH0sYB6dw4QSkc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=bmdz/FoxZk10jQCOVSwNeIgdJEOmXbPPGprQXxBGjuQAvcRwfdHf9Lwv4E6BEp0Lk
         z5/NpLzWP+EZCc4r+84VDRlhFl2FB6xO9nxE5oEWdPwOKw5UXzS+sR5/x+SeE0w1pD
         A3yrChAi6PdwL2No7g1n6vqWJNreglQrPJunF4VA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DNt-1lkYcC3G3h-003gmJ; Wed, 19
 May 2021 02:56:06 +0200
Subject: Re: [PATCH] btrfs-progs: subvolume: destroy associated qgroup when
 delete subvolume
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210515023624.8065-1-realwakka@gmail.com>
 <7702abe4-f150-44c0-8328-f62d68f5a56c@gmx.com>
 <20210515133523.GC7604@twin.jikos.cz>
 <f52f74ad-d0e9-babe-b555-455fc185dbd7@gmx.com>
 <20210518160623.GA38825@realwakka>
 <a907270f-26c4-be08-e149-b0e0f8f56152@gmx.com>
Message-ID: <295a7aaf-d747-9e8e-c293-e1af469d7745@gmx.com>
Date:   Wed, 19 May 2021 08:56:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a907270f-26c4-be08-e149-b0e0f8f56152@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G7+42P176tBR6In087tRFx/bLJcpAbaeZSRgdH0cUn7+6L0/wwh
 n8HmqQCjNe85LsmzkAmvlONXBekp9/3T7UnFprgqrM6dzYxZXMpxoSun7q7u9txPzUnlqQb
 +O0y93TSv4vQjHBNnhQTugBUMMQSmy7h4+6ybuO6O21T7jRQqARI4pjLvpgFYU3DuhDlQKP
 42zYiD6Lw/mlhs4gQmv3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i24nhaz3fCc=:dX2MZFHay3DnB9DznDnJ+6
 eoCMXCprLQf8HzzJ/a191iryWviOKPtOVCqivjp3BWTsGyXnE8SHd2V9r0KL/ghjpP+vOtkmv
 FhEQ7gkWgijyBYYjAsBA3pIYYQNv2GzncjirxMwWwjN27ZXlpEaKy9PeIcdHJs11ZThAxRrU8
 55UNMewIAAcsfXzlNFpQo/022eeV39JXvDFO+HKDWNUFGt1iT8Md1un67hYuWkQJPz174Oc/X
 BfsR+uI/tF/60NY16LthpyA5nfPBJ2bf0xQVV9MFq2h/c2ac+MWVVFDDBzBdEJzYVop3ozN15
 rTESVAFHZx3O9j2gMD7gS74vq//H2KQ77kyj2cEeFFDyTnxGNiQktCnLCx/zkrjm39taVgudR
 ++ikHq9ipc9Eicu/h+X1D7yJRORj159OZiwHGyA7rcCltz4u2+CAfmR/rsJETQJ4X7WMQxOoK
 4W/mLMRqcXyrWLv3TtmdMflDEQTQX/Fthh0WqY6PTfFtiIP9kIHB2LCHNz1BUoUCIOncrle6f
 l4o1mQmTjWYbZez0obXauAbJiJNoYxTVsuismBBdl2HsjX8bMMnmpkBL3WuOjYO4CRBlGKNy1
 huI5hWkNbbrJCE3vjBJcd2MtW4brXMpNM6rFa0wr4Id7gPMvDsFYIkVNrLXuH6Jb2Q4um6x0J
 ltJQU7EIdRKcs01zoTJjtsd9QvtCN8vbLUGvXRLTOs4sbx7l8WO+wDyeCUjJdG0rAEsbrBcpc
 Bu0Ya7yxv+OXgi0K54/AFhVux5HVlNAyuL4NrkAzJ95HDyRW0EKkJnJTkn3fhBODlDPQ/z5EA
 2sIbf9CiAq1xfjOmRpxrM5oqwpwuLiLWaGgCb1mteLtDZMWCwqxcm7P+gIfnLygWUsbe87D7t
 TUYER6+QT2vaWscxt5Pxoh6NdINTifOG3lFofq4GVXsqlswl1Vw3bWWN4/RAdPVSRAEFleKH+
 O3LM7nnb9MWLdxnhc7XuNubczYGeCoEs0+Omg9OUxfz2qJQouhnvJDj7o6n8oU5+vFpykjA41
 A3veizB8mcTXWfUaJsm6iMoHXZLL53f3eUAgRbQ+NYGd1OiSurdq87gwMek2i/jIHQ7RrhbHs
 LTNnEu3O8Kh2s4qaccp6h49sT0ION1trX7TgBIzGggcXoHhPz0XgW82G1hl/AbyQ+veRqARwO
 0OZgC0DEpFx5ikFUBKUR+Zk2QfxnhgIkj6Ky18On4N+xoRMh66EK5oCGhYgFypp86ywmnZv/k
 zi+u0kE5wKxPPJI0e
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/19 =E4=B8=8A=E5=8D=888:09, Qu Wenruo wrote:
>
>
> On 2021/5/19 =E4=B8=8A=E5=8D=8812:06, Sidong Yang wrote:
>> On Sun, May 16, 2021 at 07:55:25AM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/5/15 =E4=B8=8B=E5=8D=889:35, David Sterba wrote:
>>>> On Sat, May 15, 2021 at 10:42:15AM +0800, Qu Wenruo wrote:
>>>>> On 2021/5/15 =E4=B8=8A=E5=8D=8810:36, Sidong Yang wrote:
>>>>>> This patch adds the options --delete-qgroup and
>>>>>> --no-delete-qgroup. When
>>>>>> the option is enabled, delete subvolume command destroies associate=
d
>>>>>> qgroup together. This patch make it as default option. Even though
>>>>>> quota
>>>>>> is disabled, it enables quota temporary and restore it after.
>>>>>
>>>>> No, this is not a good idea at all.
>>>>>
>>>>> First thing first, if quota is disabled, all qgroup info including t=
he
>>>>> level 0 qgroups will also be deleted, thus no need to enable in the
>>>>> first place.
>>>>>
>>>>> Secondly, there is already a patch in the past to delete level 0
>>>>> qgroups
>>>>> in kernel space, which should be a much better solution.
>>>>
>>>> I've filed the issue to do it in the userspace because it gives user
>>>> more control whether to do the deletion or not and to also cover all
>>>> kernels that won't get the patch (ie. old stable kernels).
>>>>
>>>> Changing the default behaviour is always risky and has a potential to
>>>> break user scripts. IMO adding the option to progs and changing the
>>>> default there is safer in this case.
>>>>
>>> Then shouldn't it still go through ioctl options?
>>>
>>> Doing it completely in user space doesn't seem correct to me.
>>
>> Yes, It still use ioctl calls for destroying qgroup.
>
> What I mean is to add new ioctl flags for the existing destory subvolume=
.
>
> By that newer btrfs-progs can try to delete using the new flags,
> If fails, go back to regular subovlume delete (without deleting qgroup)
> and gives user a warning.
>
> This still allows user to determine whether to delete qgroup along the
> ioctl, and still keeps compatibility.

One more thing to add is, the qgroup delete should only happen when the
qgroup numbers get cleared to 0.

This is not completely impossible to be done in user space, but very
complex, needs extra ioctl to wait for the subvolume deletion.

Or we can hit a case where subvolume is still under deletion, but its
qgroup is already removed.
This can screw up the qgroup exclusive accounting.

Thus I still prefer to do the deletion in kernel side, where we have
pretty convenient timing to delete the qgroup, just after the subovlume
deletion is done.

Thanks,
Qu
>
> THanks,
> Qu
>> I think this code has pros and cons.
>> IMHO, as david said, It also has some benefits when doing it in
>> userspace for
>> old kernel versions. and give a chance to change softly their codes
>> which use btrfs-progs with options.
>>
>> But when kernel supports this operation, maybe this code will always
>> failed.
>> because the qgroup was already destroyed with it's subvolume in kernel.
>> and the code will be meaningless.
>>
>> So in long run, I think it's better way to doing this in kernel.
>>
>>>
>>> Thanks,
>>> Qu

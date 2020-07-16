Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551D1221C8D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 08:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGPGVl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jul 2020 02:21:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:34879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPGVk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jul 2020 02:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594880493;
        bh=bvG4L+GRdcY5Dl4MBmV11qNmb7GDZfxfN39c22H7JR0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ID6ZeBkknLEKmhg9YvqKnMZZVZJ1wUqENrhfzNNwG1arjWAaAheTuMpz/7je2hO3u
         7IeiI3BLT8mgvV8EMoiHmecTQGbD9+zM+n/JSUDaZLOsAUN0Y8N3ewAr2pvBOEmmV9
         SnOtfkYVe1qKk3vxr0KwXEr+8NMNaI3oL0nDt/8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbkp-1kEqu60XWN-00P1tB; Thu, 16
 Jul 2020 08:21:33 +0200
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
To:     Chris Down <chris@chrisdown.name>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200715134931.GA2140@chrisdown.name>
 <e973ae45-c746-95b7-d176-180d47ecb2e2@gmx.com>
 <e6cc556e-c830-fa28-486f-e23d520fe98e@gmx.com>
 <20200716004031.GC2140@chrisdown.name>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <ecb9e5b9-5026-ff4b-75e2-41b156c431b2@gmx.com>
Date:   Thu, 16 Jul 2020 14:21:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716004031.GC2140@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y4rwahg3IQnLZL/6lXvS9kFBB3x5Qe5O+Ed6LMWDbey2RQpredh
 f6rxNmUYwgQw3fiX7ZLJsfcpPwS6orLtqzF200rb2ta9I7DHTrjP8iysynjc3YZyslHEBqw
 XxMT5UqveDq+nflZfgSSnq4f3LG3kx2dQlfr08X8/723R4vGeKQWRZfucFeFJBuCjsOGXZb
 SYQrTZtE0TY+swhmXk6Eg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wII+1h+5FCI=:8F20QdUENEjPhlBohbb+R6
 EqCznEiOsXWYIgn7N/Ij78rplN1IpOvbjD7650I+7Uup4s5jbgzlY8f6QjtZzPYjLWxJmCu9l
 uBbhg4PwMkN7mnWQZJsyn5i85G2oC2k794KGeSG8ylaIRAJicfwlgLnIasJbYPhjc1BqDT4Wi
 qqFprMh5zsS3PhOHV4ZWELjgZP2BcvarDefBArcCYb38hcAa/HVTgETJnUCDX/G5MZr/YagtL
 UWIStVppRTE6jrGzPLv6B2eA/6FTG6qvjM0lKdyMrHv1DXNbyuaTccX06ZojxSq3elkiKnFb2
 lTmZuCzALoqhYL+oFLGzD5snb/N0ATiNElhQhOwFNX3G1iaF8j5UJK6E00Sf4GLM/LyDNHPxb
 mwEgP3foya+lZcfOpZgDrCaCwOCp73YEkdtB0esFW7GxcdKIKbz6PsvTGEcRGT6oiQDIk1qSj
 G8TjRrs6Dwxe69AaOUHaueVPeU5k3CO3G71VpXuy3B7I5v9nnJmTFblvscQAaM/DuIVeaMVfn
 rBPFrFoQciJCPQyn7N98xChIe2X7DdJgU2jhTP35skKGBu4X3Ov2k5stceMF7LaVg6NaDmNdH
 OX5aS1uG27/P/Aalffu89MZ1ihGPIAqUYTJuOqKyyCvsjbzFDp1X35iyINXyPVbCu3vjIfmUv
 DMgLiVyNvLzFyP7KTOgo5ZW/6iz6ifW1/GZhcgpGiloeeJdi5w4Sl6rLLviSK5+MTGeUNskK1
 1z0OjQqHlZbp20xlhm2zweEFvzIqAGnD/l7wRYXeW5zEctxI04RdmgTCa6Z1NZeYcQ12d7w6G
 UUhVQMUuBu88mlwZiTGv0mLsuejO/2oGLZ7nhECeKp6bqCK7MKSmZlu+sVknNiVHenXNFP6Ah
 7JOv+PcEpZ9wIFX5hOCthc7FYRruqbrSPT5c2FFb+2KrpaQti7umIMnhT+5zrxmilncVqB+/k
 m9RWb7HYBM3MxytBCGmbnkgNo35Ga6nsB6uteIGVFTi8qWrRCoBDy0VtAEhXh5uloS+LR9qAP
 1KM0sqTZtVSX0YdX+GBZcjauwsbzpWRzL0F9TQJsvZXGKF0KosCkZNdkq4Be1LuVg0llgNLJ7
 6Rm4MMlrklFyGfE61b30rEhugjuRb6iEpDHOTw1e47Gj3bIxbDiI8TmQ3bclU4QXIetaYu1nl
 9p71Nc1p5qH7nZxlZ9YuroV4t4anaddSeKVxy/0mrdJtUOsE+lxnOpmo1cgWX/gOIJwZ/Ed6u
 2H5r+IMg8Y/jJ61Un7hsoFYntV0hAKdu8Ht0EFQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/16 =E4=B8=8A=E5=8D=888:40, Chris Down wrote:
> Qu Wenruo writes:
>> Would you please provide the full call trace (especially the address
>> causing the NULL pointer deref) and the reproducer (if possible)?
>
> I'll try to reproduce it again when I have time. I didn't have kdump
> set, and am not currently running linux-next, so until then, you can
> have this crappy photo that I rushed to take earlier before panic=3D30
> took effect :-)

The linux-next is using an older version of that patch, which has a bad
memory allocation inside atomic critical section.

If you're unlucky enough, it could cause various weird bugs.
Thankfully, David has exposed it and the latest version in btrfs tree
should have it fixed.

If you're uncertain if that's the case, feel free to try the latest
misc-next branch to see if it's fixed.
https://github.com/kdave/btrfs-devel/tree/misc-next

Thanks for your report,
Qu

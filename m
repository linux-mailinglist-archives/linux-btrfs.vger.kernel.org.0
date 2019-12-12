Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAC11C535
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 06:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLLFQf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 00:16:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:56405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfLLFQe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 00:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576127785;
        bh=ugBY3CVTNOzXkuRcabYLjG5oBaCqa6+1QZAqa6wPW3w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D2/HUDsLYW2FkVp7RFqloBc1LlfqUHDgdIhduuK/wdRIP4YPU7sTpm9WSzBg01864
         v3VbJJXxlsDAbvndoBTIVXKeqfRk3fNe7gA9DrTpM1R2kabqqj4PzCeHODRrwb82Nc
         IPoFW+EJspdqpHCx5zTb+NWWhNnKdr9iKSByFD2k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1iMVXA3kJY-00PK6r; Thu, 12
 Dec 2019 06:16:25 +0100
Subject: Re: fstests: Don't use gawk's strtonum breaking existing fstests
To:     Nikolay Borisov <nborisov@suse.com>, slash@ac.auone-net.jp
Cc:     Eryu Guan <guaneryu@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cc85789a-6143-e4cc-aa12-6c842ef88016@suse.com>
 <c0dd0b84-776c-a089-0769-913879d9aa9c@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <162544f0-9344-9fc9-bbd9-e0ced0eed856@gmx.com>
Date:   Thu, 12 Dec 2019 13:16:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c0dd0b84-776c-a089-0769-913879d9aa9c@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5jT4+pa1kFn2TL6htbxDINqR/3Ab/dE5ERN/S/YlhBz8HvnMn7v
 BR/oddGQIf7BFuUYOj885KgcoZfzfdo+vfMxyxykjBQhO70rpFaLoNROF4gGl60siC4m1sw
 RBXbXG9yLvKOvIK8jJDWiI3GwYM5fWEFqSBUUnA2EXbTOMtNzfw9zKU+bWgGRutld0ixRnr
 hlofR/8ApCP+fWdi/kpuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qX5lPqznymk=:Cy4+9ytLHcA0M4fAEukpJH
 MtZR46xBobOGX8OuOjK3xPVrS/mee8qx1JBnWW41qvKFaiZnpG6i3JCeRyp9WGu3F8eRE92tY
 Srx7iotYVGNNUpBBPN1PJjIAV7YUBTqm9/wdhlYFBAN4FdKo50skvvHhlgRTJ1k04xh7Q3wYJ
 TKObZx41uOX+5OAbilnLhN2J003BxV0b+awf3TDgjlqa4G0DllzquQVnMOUf2DX4rQvJ0Rqn5
 JoOYiowT86m/DanZTtkjmbIYElR9iCkX8y/nuTI78ohmm4zu/i5kxWQxMbotfkpDo5vTrIIoI
 SFYF30BorHM8rgZ6oewRLJ8yXcfEy83MeelP+6QU8sEUZICE2TWLHAO/2xIIiJKwHpgZ9g1Vx
 m3uVqhij4gCPgZ0QnxYXVpE5X4rIy2eFdJjg4U8cSYGJHu0JhSVUx82OUAX+ygBu8HbrbS/WC
 79mz0ssylW/1LI4rv2HQsPSEBJ1dJR8Xs/hxUfwJSkhmfmgtzoFsiPI3z2azQPHCsHke22fxL
 1COgqgowuhzQyeZ36R1saoc2XVbUBzrKfdAgStG98e7h28gv/N/rFHPIyHNL7zVmV+pQlGH9p
 NJlKpwrDO4NPZ+l1VTc2IUNxsvsQByxCRC37Y+ZzYaUk0BlRowLepzdmtHEFuKAjZCJjxDHyn
 EAJWQZ9EFFNW+2WMjUmu96k9FS50e+trYasQoj1dwA3hYxJAFIUkXnFoZq1oJMCrFc5gvhgpW
 04uu0n6xMqSbesj626Qwk9umj12RiyilPTu+DJve7Ym+ihNBX5qliR6JigkImoTgJvPm3w+HG
 FVW2Y/CDEBtKdJkvrL4yYeQ84e3cIhlr9Z1lBG7hSixqsTWKPHgDJlXBMtS6CpJ4TTlRxwpfR
 ELwAoA1/nNCrw701h2r9JgSHaL+KlGs7CIr79kqRKrAYRBzEk0/v2jTqFt4s+HkwFulU0Ootb
 MBKCCZFMuOfjJX5M6LActAlMYukmb1zPJLaF5chadqPyKehEJU2Ih7cjigr0zySSIsIes4qdf
 ZRiVb0xaan89lUC6KcMZibAQjyi//6Yl70E5LZPM8xktUAu6yQ/ph6AzOflaWCtazW10JwHcZ
 kVr8xn1Gg4Vt5z8GLJn8tHtpfD2LX8Dei0nBH3ItZXiiUj6Fuhiw7oAPcHEG+m9MEhbJJYjRO
 Ju1FqUIqVttxUbLgUcS0UTk76NkPcwhw8lMaKWF1pPMeKrTxmnhzaAcSdNveszwnt29ie+G6j
 0iVORypq6YVv+PmiGsaesJSItp7ltfUx/6+cwWqNqzfPxroQ3vy349UpijxQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/12 =E4=B8=8A=E5=8D=8812:33, Nikolay Borisov wrote:
>
>
> On 11.12.19 =D0=B3. 17:53 =D1=87., Nikolay Borisov wrote:
>> Hello,
>>
>> Following upstream commit:
>> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3D375=
20a314bd472ed720ed0611c6b69e418be9b61
>>
>> breaks btrfs/095 and btrfs/098 tests.
>>
>
> The problem is that the old code was using gawk's strtonum and returning
> a base 10 number from an octal input. Whereas the existing code gets an
> octal number which is again parsed as an octal when using printf. So the
> path in question needs to either by reverted or extended so that the
> necessary conversion from octal to base 10 is performed _before_ calling
> printf.
>

Well, octal values really makes no sense. We should go either hex, or
human readable decimal.

Octal should only be left for certain historical use cases, like user
privileges. For content dump, octal is never a good use case to show offse=
t.

Since current filter_od can't handle -Ax yet, what about just use hash
instead of the problem prone od?
And put the od output into seqres.full for later debug?

Thanks,
Qu

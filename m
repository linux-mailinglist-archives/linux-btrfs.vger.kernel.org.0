Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40BB1788B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 03:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgCDC4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 21:56:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:59187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbgCDC4B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 21:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583290543;
        bh=R/N+4N3wkbGXvxGNJEC2kKs7RCQ7TPhnheYa5i0iWf4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=l8Wf49gzVx+DmrBydK832aaSAcXp+Dc0+gUrdBg0h32uHdS3dUJPks2GhVquLhYN+
         6Fe9MBqF+Qnz1hhKcac1aXtMQ/7DC+4rVcm0ubnfzHJw73BaP4rFK7/cNDMhNMFs/I
         De0yFLGPISOk7f0KbheJ7EmTQjeObTnDuo9vFnEQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1ijWgC2MGs-00Pr8t; Wed, 04
 Mar 2020 03:55:43 +0100
Subject: Re: [PATCH] btrfs-progs: convert, warn if converting a fs which won't
 mount
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <1582877026-5487-1-git-send-email-anand.jain@oracle.com>
 <af69d1ab-4609-d603-980c-b8a6cfb87f43@gmx.com>
 <39c3e381-b49e-a571-d058-a01734b8b4a9@oracle.com>
 <20200303174422.GM2902@twin.jikos.cz>
 <fc02b904-5af5-035f-bb62-a2982409ffbe@oracle.com>
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
Message-ID: <6f9bf93f-30bf-2a1a-b345-f42c41ac4d1a@gmx.com>
Date:   Wed, 4 Mar 2020 10:55:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fc02b904-5af5-035f-bb62-a2982409ffbe@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mEJ9/FZs+TgxJmQEutkKq0Ez+S1cbiR8aFsj8avorRDl7cLpPQE
 KBL6/gun1gHiex6Ozmp4DwW3fTR74t3+q9lL+9VnXQP+mvyyM1HGrPy90i6oTbFSdGVoYBe
 2DvicU4kzpI8ZNg2PJF/PMFmBT+09ULoOn/IVjnHPS4VMn1d8J/Yp1y7w/wppt5bYQ52rFZ
 Y2Ll38WSzLEt0dh5iMFjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JcohaskGZLc=:OpnrCI0WWXrgsrOVX9p9cB
 HrtR8ixn+KNz6VdEZl7YjYVz7F8tqGm4G2JdRqjM8KI6v2g9KhVh562zYz5socW0zLeX5xtM1
 uhMa31gt1mirkIZsArA7DNoEpoUzxIFvBf74CYFLO0xbtbUvfA2Szjj4m273E9u4//t5xh2hB
 LvqQfTyP0jKUFaov3N+etf2GJAvmFklqGJt8VrjFXM53qL5OF/Y+WroNjJ42dXNaWceKMCDg7
 PgpiwORpSsJMyiu1R9FjpJ89jmBPa/DhO5sFq0a6mcDp7ehGLrZE51aAyc363y4EqgpkpVWZx
 O8JCkEIg73+zLevHmkiFH48HYx0x4XVd7G8qCi6Y5ycVM0PfCvRlE2qY/n96Nte4H9oJ4LFk9
 OPXuJsUmm8jyCRwjEtOalEJ46yjtnybi1vLUnBjKvI0N/XCxid5sp4fKxNKj8yPX3U4HqZYtP
 6iKbMuXhkbGW+/oWc5fzKNgSlr1qg2ELoWOpInsuVl4Z9Hkdp2fd9UV72L1DlPSoNamuv1GJ3
 6hNyp/lFBA5LQ+ExZrN5GnjLTrqXmt6zPpHtyWmVnzFGCMDcwmtA/OLX0FAPEhN6SwofMtyGy
 x2WhA9yPT84AXqP4NC2s/LTpyX+xmw7XTuyDzeUsba5sEVo+z1eZjei9mde+mGZVzK5LgL7b6
 e7CgBEEcD0u01FFrEMNk0+ZPF7cV71KlZVEtljwKsBnbhpmJlGQ4GOA+ky9dCjyOsqLupD1wj
 84/NH0BO0b3TedzCRKylIYVZQuqW/hrl1n0yeG1D7fg1W/h09N+2bH6dNxlgTcWW2N+Ut5gB5
 VWsHFrW1Mhz+pn+PxNzxTjLm1sbDyv/n0NkMAXU5kKFexU0aofz7xuQqA1XgVxaUlyW8spkaJ
 9UQG7ciBoiS9qZR54ESiIXqkjJRc6QIyHd3v3sAhRdWBdrlK5AQi8XMaKn/ggObnnEYDEt8nx
 CFK1dtVSxI4tcXymUsG3lkEb/Nm1aJSwrBQYa7dsopu0+BC8dQA3JPCESwAXzIdoznvQZVzvv
 DwegfCWxnPcqAEC0NwHTaNeYky8TYblWDfUsW9mew/7K/OHLjkNFJt6cN68oSE35ZbH0rDN5e
 swztTUqcmQScOB5a6/YdKwvVhYlBgWIDA4o7w/cOiJAYlmk/tWSAfcPzjDaR78Wz1JJUPNKhg
 UoxP60pOJEdCGmWXTe1M7uSGNvgQjWheoPfLbzpsIpBhABomHWnWtGorua7Fvc6lrtlbWDwQJ
 LY/oFXtQQvIG0SGnF
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/3/4 =E4=B8=8A=E5=8D=8810:14, Anand Jain wrote:
>
>
> On 3/4/20 1:44 AM, David Sterba wrote:
>> On Fri, Feb 28, 2020 at 05:06:52PM +0800, Anand Jain wrote:
>>> On 2/28/20 4:27 PM, Qu Wenruo wrote:
>>>> On 2020/2/28 =E4=B8=8B=E5=8D=884:03, Anand Jain wrote:
>>>>> On aarch64 with pagesize 64k, btrfs-convert of ext4 is successful,
>>>>> but it won't mount because we don't yet support subpage blocksize/
>>>>> sectorsize.
>>>>>
>>>>> =C2=A0=C2=A0 BTRFS error (device vda): sectorsize 4096 not supported=
 yet,
>>>>> only support 65536
>>>>>
>>>>> So in this case during convert provide a warning and a 10s delay to
>>>>> terminate the command.
>>>>
>>>> This is no different than calling mkfs.btrfs -s 64k on x86 system.
>>>> And I see no warning from mkfs.btrfs.
>>>>
>>>> Thus I don't see the point of only introducing such warning to
>>>> btrfs-convert.
>>>>
>>>
>>> I have equal weight-age on the choices if blocksize !=3D pagesize viz.=
.
>>> =C2=A0=C2=A0=C2=A0 delay and warn (this patch)
>>> =C2=A0=C2=A0=C2=A0 quit (Nikolay).
>>> =C2=A0=C2=A0=C2=A0 keep it as it is without warning (Qu).
>>>
>>> =C2=A0=C2=A0 Here we are dealing with already user data. Should it be =
different
>>> =C2=A0=C2=A0 from mkfs?
>>> =C2=A0=C2=A0 Quit is fine, but convert tool should it be system neutra=
l?
>>
>> The delays should be used in exceptional cases, now we have it for chec=
k
>> --repair and for unfiltered balance. Both on user request because
>> expecting users to know everything in advance what the commands do has
>> shown to be too optimistic.
>>
>> Refusing to allow the conversion does not make much sense for usability=
,
>> mising the unmounted and mounted constraints.
>>
>> A warning might be in place but there's nothing wrong to let the user d=
o
>> the conversion.
>>
>> I've tried mkfs.ext4 with 64k block size and it warns and in the
>> interactive session wants to confirm that by the user:
>>
>> =C2=A0=C2=A0 $ mkfs.ext4 -b 64k img
>> =C2=A0=C2=A0 Warning: blocksize 65536 not usable on most systems.
>> =C2=A0=C2=A0 mke2fs 1.45.5 (07-Jan-2020)
>> =C2=A0=C2=A0 img contains a ext4 file system
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 created on Tue Mar=C2=A0 3 18:41:46 2020
>> =C2=A0=C2=A0 Proceed anyway? (y,N) y
>> =C2=A0=C2=A0 mkfs.ext4: 65536-byte blocks too big for system (max 4096)
>> =C2=A0=C2=A0 Proceed anyway? (y,N) y
>> =C2=A0=C2=A0 Warning: 65536-byte blocks too big for system (max 4096), =
forced to
>> continue
>> =C2=A0=C2=A0 Creating filesystem with 32768 64k blocks and 32768 inodes
>>
>> =C2=A0=C2=A0 Allocating group tables: done
>> =C2=A0=C2=A0 Writing inode tables: done
>> =C2=A0=C2=A0 Creating journal (4096 blocks): done
>> =C2=A0=C2=A0 Writing superblocks and filesystem accounting information:=
 done
>>
>
> Just warn is reasonable. But I don't think you meant to introduce
> interactive part similar to mkfs.ext4 in btrfs-convert? we don't have it
> anywhere in btrfs-progs. As the btrfs-convert is not an exceptional case
> (though it deals with the user data) removing the delay makes sense,
> mover over the conversion and the rollback does not take much time in
> general.
>
> Thanks, Anand

+1 for warning only, especially when btrfs-convert is revertable, unlike
mkfs.

Thanks,
Qu

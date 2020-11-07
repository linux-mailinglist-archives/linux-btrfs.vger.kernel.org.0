Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE06F2AA19D
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Nov 2020 01:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgKGAAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 19:00:36 -0500
Received: from mout.gmx.net ([212.227.17.21]:41113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgKGAAg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 19:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604707231;
        bh=Cq/n2O6HhYbzbLHQjpneZ35kTEtDN3KDTbuOO0mxQPA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eQWL2fknDFDq/TFqrMUYMO5iFeYJdv7dkDmwV0rWxPb4Esy/NEpM7z4THc9bKZTJe
         dYUyOdZZ0DpfYu9C1+RkFpu7agPUPEULJZ98MOiyzWOKTTiMPeI23UWLdypmENPpCc
         EIQye43q2aGVHbbzfIPxnlYxgB3c4IYO61xEmkpo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrQJ5-1jwbub1zBX-00oWVB; Sat, 07
 Nov 2020 01:00:31 +0100
Subject: Re: [PATCH 15/32] btrfs: introduce a helper to determine if the
 sectorsize is smaller than PAGE_SIZE
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-16-wqu@suse.com>
 <0eb2c642-f0df-a899-388d-2e1d9db6e5ae@suse.com>
 <5079f2e4-10b5-4024-1dd7-d2a59cc4945f@gmx.com>
 <20201106172816.GQ6756@twin.jikos.cz>
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
Message-ID: <8633b9b2-42f3-4916-b252-c9f9a23382a0@gmx.com>
Date:   Sat, 7 Nov 2020 08:00:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106172816.GQ6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UDc9Sovb2OTGqDYmfL9BBoSx/hWhw0VT5B/sZJ/w4RAZF8EZA1j
 fz+P8dHfxBJ7smh2P7zfJgXdNc4mnh/JO55D1sqGGLtu2wX0XUxRG8U/qOds7TtXy33Ifvl
 ZxkSSlVOsKcSC03ollrEEdps0CfVmuUqQ/tt/lKmDvDvrKyhyy/usgxyix7XvRnW+HwPKwI
 wTQDSWd3txZsQNdO122Cg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AO0wlR3yp9s=:nrGJFRMMW9xB82oZf6cVFz
 fyOeqVuqvv8LoxlKmhudN/vaW4y6eGwOIjhFSb7ZlBFGJyE+V77n51eJAgcaGceQLNiO2tknL
 BCuCOpZ+kElfd52n4Pzt7ri5wD95mKJklH5v72ZpWkzWCGwL8z/0FZ/7zhq+BOI5f5om1Cx6O
 QrTOveQ3iZ0IgtT89nd4ggW7hjUvVWoehtI/7+jm4ezcYVCiT+DQuoQKr9pIi9Zs3P1jlJWJ9
 A8krTz6SM3cshGC0xgGZ6tWbRUEb4y0nMxYGJocwfPFWb+qHZAnN5/BaGu2kb1GpG55izWywM
 5mHaTAYhQoJ9BurVqRtrcwLvsDs7wWE+8Jy/eeMXVlpgAvo8s4GgnzsC51RvQ0QOVnIWiagQU
 DFTS8oXxbA050/oIJdU0m5l/I4/fo75e1eF/wMWf+ImWHIRkPLojFdcPEKOy9HfruCvqEWzUE
 F5Oks0xC/ZU0Braq+WjR8Z80AhmB45rztGUN+ti6ETawo9awRs9eIkZS1NBPSrnYNq5uVQEWR
 ZVIKlEeRTliy6AWr6WzvfmiDAmOYKeJ46HeJcvkdC90qT/Pk/2yIhy/aHw/70YPV0FQEAJy8P
 1yyYOOZ0Q9G8mDR8UrScGhQHOiuqDM6MZWoWmw7yM1AqffIB9JdPFSYdvhpSQzCzCIKWh2SeN
 p2dnWvL0Oig7sRujYdDWfTQ6mzOztdHPW0JzGLWAsWmgEvhJKhK9gwr9RPph/yJmhs91/1jiI
 Q3LPbkv0ecrmuqAq14APAkmFY6WoQ0/rfIP5hnJNnkxiryYBoHg3nR71+zovnPC+/HtfTf/14
 ohHg/Hnnc4m/+lxSHdAUTrH/Rd62/5W0rbUNT0bJrdXUho1I32gctevsiLilKpsIXEGg0Mh6z
 Cv5z1HnEghGmeG0SGHsQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/7 =E4=B8=8A=E5=8D=881:28, David Sterba wrote:
> On Fri, Nov 06, 2020 at 06:52:42AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/11/5 =E4=B8=8B=E5=8D=8811:01, Nikolay Borisov wrote:
>>>
>>>
>>> On 3.11.20 =D0=B3. 15:30 =D1=87., Qu Wenruo wrote:
>>>> Just to save us several letters for the incoming patches.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  fs/btrfs/ctree.h | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>> index b46eecf882a1..a08cf6545a82 100644
>>>> --- a/fs/btrfs/ctree.h
>>>> +++ b/fs/btrfs/ctree.h
>>>> @@ -3607,6 +3607,11 @@ static inline int btrfs_defrag_cancelled(struc=
t btrfs_fs_info *fs_info)
>>>>  	return signal_pending(current);
>>>>  }
>>>>
>>>> +static inline bool btrfs_is_subpage(struct btrfs_fs_info *fs_info)
>>>> +{
>>>> +	return (fs_info->sectorsize < PAGE_SIZE);
>>>> +}
>>>
>>> This is conceptually wrong. The filesystem shouldn't care whether we a=
re
>>> diong subpage blocksize io or not. I.e it should be implemented in suc=
h
>>> a way so that everything " just works". All calculation should be
>>> performed based on the fs_info::sectorsize and we shouldn't care what
>>> the value of PAGE_SIZE is. The central piece becomes sectorsize.
>>
>> Nope, as long as we're using things like bio, we can't avoid the
>> restrictions from page.
>>
>> I can't get your point at all, I see nothing wrong here, especially whe=
n
>> we still need to handle page lock for a lot of things.
>>
>> Furthermore, this thing is only used inside btrfs, how could this be
>> *conectpionally* wrong?
>
> As Nik said, it should be built around sectorsize (even if some other
> layers work with pages or bios). Conceptually wrong is adding special
> cases instead of generalizing or abstracting the code so it also
> supports pagesize !=3D sectorsize.
>
Really? For later patches you will see some unavoidable difference anyway.

One example is page->private for metadata.
For regular case, page-private is a pointer to eb, which is never
feasible for subpage case.

It's OK to be ideal, but not OK to be too ideal.

Thanks,
Qu

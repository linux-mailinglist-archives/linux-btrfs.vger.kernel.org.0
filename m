Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED00173388
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 10:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1JLR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 04:11:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:49061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgB1JLR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 04:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582881065;
        bh=QuZnIsbZCoeYC/CBsQL4sjw+I2Z22ZcRYIxm/tkjumk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cy4q/CxXZjsmropeS9WwYwEi6CSivHN6AZWMKEAxORCtTyn9qznupBi/gPCKVaYXV
         jg5YYNXeyZ1XMU/px/aQaxwZf8AjYoMm8AZO9AJ9vzCpUIZV4vMtr3LmxFH+gLFgia
         5sa0ftOoQalwC43ryg6klipApd7NsZJdWbFqdWbU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdefD-1jgwQL0O4f-00Ziiz; Fri, 28
 Feb 2020 10:11:04 +0100
Subject: Re: [PATCH] btrfs-progs: convert, warn if converting a fs which won't
 mount
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <1582877026-5487-1-git-send-email-anand.jain@oracle.com>
 <af69d1ab-4609-d603-980c-b8a6cfb87f43@gmx.com>
 <39c3e381-b49e-a571-d058-a01734b8b4a9@oracle.com>
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
Message-ID: <0013fd01-9138-57bf-c118-0b780b4f6422@gmx.com>
Date:   Fri, 28 Feb 2020 17:11:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <39c3e381-b49e-a571-d058-a01734b8b4a9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r/zqQjyOOOCNgIyGm56irs6jGHAe1KBuSONWZ9YnRdmYu+RE0wx
 +LbYUpswqtvo0w7Pa3WfZoazhmHKcSwxduAnD++IyQG0DFYeONeUrr83Vmdxei2b+UotfEr
 Orgq1MgUwMHgpW42d9krO0gEszr6o34nySntQ06p6bQnGEqpWvvmjsH33X9hoHAeDJ6cEtt
 Jb2pfFou7lO7eXrvIKdUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/AfeTlpywJ0=:w10+bCYj0nYcEIopr6e4Dk
 xXDg6PRoNb8tCrgYxBSoh9vvA0vvBnYD/bbYaUQNVNtPmoLCd0AGMZl2ru9aNvSUnsF+QjNaS
 TjuPnsOp1z1REncd7XHtpltXtiB1YqwGCHl6sjTxZZ1qCuVe++k2fAe01/klIVEHPElAfmAfp
 EqQyjEh0WMX6y7CCbX6xaZV2z/VIwLsvnFvA/K0DQq0GxLMv8JjzNVvYxBcTT7C5s2yHSpWi/
 7DQOS7MNLCtf2xgfUFi6eLKiTDMsAnE47Z8nkAPrg15RUJD8a6E9b9PhPjAUcb6hI/ylRY8Zx
 cqNPtrh1ukeTHYzjqTRhlGR5XU8dQjJeOiqYAH5RB1bvUEOwyMHJZaiejotTC9WyD2b0/bsNa
 KQdPqNL6G5EMTWgL4WoFnFHKIokj9gRd8QeMUmRHdUUvW0eOOo+k5eY+OPmG8TVM7RFr2iDe3
 TS8KQ2gv59tcHNar9lAo0CO2bQ3YXFudoAdxM2fOeQ7ERuVXA+aQS9dklruckRUOc629YBV9u
 rGo6+jUMjQL/djwWyxnMiW1cCnWFlFVV7Yvw57Ey+FYky0q3jFbG1Ki6w4weOmv832xf5ELl1
 UFogq7/cC9WqkWPfcBJBZ15Br8PcpgBGN0nCyH+QU8yD1WZPgR21Qy9oO8QMqqSuJLeVRn+Oy
 OPlgpBKcYm5a1HTY7+UFb40+5o+kN8YJ7EUcrvLF/rWbGCTk/STwxYPeqedJDR9hWznDaHv9R
 eJ4eIklHIvbJIbsbkx2PZdmVp8sHytXebHliIRA8My8f1mHMKuldAGhdU4DnqLa4W4Is0dYsX
 f4FQybp5PzE8FMcvt5Nl836pznUnB0qv8FSCO5QzSp6kzkx+faydxxY9/RFS7+cuhYpHkWI4w
 x8BzEpL1ck//9woxUZnYhjjdvbgoFqmGAH+GaJU4w9/YqQaZrhgi1cSEBDXeTbk9gnMmjw2bT
 CnDVCF1Gg1C4oP1BWNISGXnMVn2g9BwAFcZvtlZJHo0ptnlsJV1+kP6K0i1hLwzKq5W8rumzj
 5drUHuIES/i+HqdhLCt4h+0XkuKifKzw7OxoMrQjlzMJfNaoPvim0J0jnJoRhG0JpWuUV52N4
 mskB8O6OBXmxdRGAubAPMBmQk5AGGcvHkqAuBMTRu2TsfjBLPi7ds6OS5PsVAEbhWnZY7Cg/K
 dO1022fOpBHPaxwiZ/XSPdRfbCfcquPRaPQDy3HM7JbBYM26/gNN6lnYw3ruvyXqnxJcSRKe2
 zbElyxpR/6i5Tw1+z
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/28 =E4=B8=8B=E5=8D=885:06, Anand Jain wrote:
>
>
> On 2/28/20 4:27 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/2/28 =E4=B8=8B=E5=8D=884:03, Anand Jain wrote:
>>> On aarch64 with pagesize 64k, btrfs-convert of ext4 is successful,
>>> but it won't mount because we don't yet support subpage blocksize/
>>> sectorsize.
>>>
>>> =C2=A0 BTRFS error (device vda): sectorsize 4096 not supported yet, on=
ly
>>> support 65536
>>>
>>> So in this case during convert provide a warning and a 10s delay to
>>> terminate the command.
>>
>> This is no different than calling mkfs.btrfs -s 64k on x86 system.
>> And I see no warning from mkfs.btrfs.
>>
>> Thus I don't see the point of only introducing such warning to
>> btrfs-convert.
>>
>
> I have equal weight-age on the choices if blocksize !=3D pagesize viz..
> =C2=A0 delay and warn (this patch)
> =C2=A0 quit (Nikolay).
> =C2=A0 keep it as it is without warning (Qu).
>
> =C2=A0Here we are dealing with already user data. Should it be different
> =C2=A0from mkfs?
> =C2=A0Quit is fine, but convert tool should it be system neutral?

If we can't mount, btrfs-convert can easily do a revert without anything
touched for the original fs.

And, convert tool is not that system neutral.
It needs the source fs has a sector size that matches btrfs.

E.g. ext2 with 512/1K/2K sector size can't be supported by btrfs-convert
at all.

Thanks,
Qu

>
> =C2=A0I am not sure.
>
> =C2=A0David, any idea?
>
> Thanks, Anand
>
>> Thanks,
>> Qu
>>
>>>
>>> For example:
>>>
>>> WARNING: Blocksize 4096 is not equal to the pagesize 65536,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 converted files=
ystem won't mount on this system.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The operation w=
ill start in 10 seconds. Use Ctrl-c to stop it.
>>> 10 9 8 7 6 5 4^C
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> =C2=A0 convert/main.c | 15 +++++++++++++++
>>> =C2=A0 1 file changed, 15 insertions(+)
>>>
>>> diff --git a/convert/main.c b/convert/main.c
>>> index a04ec7a36abf..f936ec37d30a 100644
>>> --- a/convert/main.c
>>> +++ b/convert/main.c
>>> @@ -1140,6 +1140,21 @@ static int do_convert(const char *devname, u32
>>> convert_flags, u32 nodesize,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("block si=
ze is too small: %u < 4096", blocksize);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (blocksize !=3D getpagesize()) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int delay =3D 10;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning("Blocksize %u is n=
ot equal to the pagesize %u,\n\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 converted filesystem=
 won't mount on this system.\n\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The operation will s=
tart in %d seconds. Use Ctrl-C to stop
>>> it.",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bl=
ocksize, getpagesize(), delay);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (delay) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
intf("%2d", delay--);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ff=
lush(stdout);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sl=
eep(1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_check_nodesize(nodesize, bloc=
ksize, features))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D open(devname, O_RDWR);
>>>
>>

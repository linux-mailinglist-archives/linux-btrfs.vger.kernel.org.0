Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503B0128D34
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 09:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfLVIMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 03:12:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:48143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLVIMI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 03:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577002325;
        bh=ui3GyL16vG2GIh8Mh1mXccdcjlrgdor6/oFkkRE40Nk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DmRCKJYlnOVhUVF90GyMYjGBlSzSFwRHwhI/G331IOrGJPLqjY6vqJun6mwW3sJ39
         VdafdwvOoxzc7Y6eqfL/XzX3v3XEBiE+DQhZS9u02Fyn2ImtA5ExlqEPBqU+zHaDbw
         0N7CjnG+JHoAZhcSojfXClwJetnNpomFBucXYZy4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1ifMuP400j-003gDI; Sun, 22
 Dec 2019 09:12:05 +0100
Subject: Re: Kernel 5.4 - BTRFS FS shows full with about 600 GB Free ?
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
References: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
 <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
 <e743df15-4830-8d83-bc36-6ddd33c1e720@petaramesh.org>
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
Message-ID: <dd37e99c-e087-2b6d-830a-96811b337ba2@gmx.com>
Date:   Sun, 22 Dec 2019 16:12:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e743df15-4830-8d83-bc36-6ddd33c1e720@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YfmQU+8V6RYSn1hKtj70gK3aCNV5/sn5NOlhpqo2pgR5GWu+WKa
 34S+925cus2yVOrSN/0Tkr3ExyGkAPersAVq4cud3Say5VZfm5Ry6C0otfyinCFkBAjMkHx
 aa6OI7msv/H5+k/s6u9z8gmj4GYxbBlaXNShOdtbialXXZdUNY4b5LnDet3m9S+IFbBQJKQ
 yt5TaXIoCfKvW25QqlMaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WrxXWVaMUss=:VXEfCdy+Ly1hamJ9ZJ2efh
 KXOYRkySNlh5YcKp+Co3KHe6kiSc2LCE9UJmvhBUXAHkGLsTGs3eH7Whuat3Zkbem/LS9Y02L
 J1JQHQ/uHNbQ1/b29B5uk/g97SzlMGooD4TZHAs9wp0EddKENfc7tEkEa9OLyJecyHgvQfoys
 4RmYIk8rKj+Y4WRFFIiv9X5MWXQriuAxfFeTSyTS8+O17Ks9zwq8IHkiyAFxppbVJ6RukWnG3
 aULyipd5+nbHHK49jm7QZvA8icgreojCsKFctt2ET2Wew6bu1l7K3OOPOXQ+t8Qbnlbq+MnYQ
 lGSrQtm46PCRC8C65jGsxddr9ohVGK7JMfjbwBDmLA3nmAZN56rQwVlZGJIu2mujwzTM0ktlA
 9YRFNLr/p5oTUQdn93j0xnomm0osCziZli+xb0ORjIBjjOaCjMqHyLgPhbLRqw+sxPch49ls5
 E1q2MZwq81ZNDV3ANyrOqb6dLdlJFI10I8s3bpJBXwA/HxcD8eVGQryuv5vGksiVgu6vR5xuY
 r6WHCZ9MKI3UjmFeR539l/olYC6HbqPUg6Rtww2jkmUV3U7Ve9bq5qNsTYV2F/zRXK33G2wfo
 AaVACzB7EXPAwlCkJ3IgTtLt8U92cIBLmOeAe5lw7dmcmPpSUlv+HhI8Dq8bJ1o/Kj61SCyvw
 Uh93u/k8/hhqAsBg1LCXhvrTNsM8kOpVP42KWQ4vvUaNnSIdtOq+tQ9CbjjkxqMRo0iJ3hATA
 7xPK/W3gjCJlFTIqHbnYklcBsyC9xcq4gZgSfQ7WZCH+OVPCXfywPBul3HmIIxNe7bpaodTFw
 1qykBhx57ZllRHuBfUZzDIQoHJpHFrcvM4QIZWy1FTqCLbnH/cBYrwbrCDUm44+nJrGqh0UKb
 b8OSoVcuRdL1iVol2O4XkQfKBT/ghZfUKdkYUMiFlntvroyZSDxxAzBiYkXKe45DLsW1+HH68
 zmhslEeSygfoI5Bb2TMNH/kGYf/rP5FW25R24j4y+EjvItUx7lclLLE2/OlzGp4x9HvvsIbUM
 PP5XFz0waA+LlNA/v6FGl5dbRVsMVeeSsbg5WlFupZLKc1aoEhzF+z2q+drOarRdajmUkQGsi
 38Z0waFroMJm7dCPoOQgANS4Lz6FyYE7GuOV61NG6n1mEtv5gVl7Cx/HQIplhblm7Df5zNg+r
 RnRYpy7dHPDCQeEBNJjS++b3bBY1eKe0LLhsMox2v0ssb7Ox+76ia9l4UdZnxb0mqx5Xnr5Te
 2xVX4f1PZwJzqlqxwMQFzaULHzlDRGdNI0A/h0vARd/XkQPO89a20ULuKD5o=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/22 =E4=B8=8B=E5=8D=883:55, Sw=C3=A2mi Petaramesh wrote:
> Hi again,
>
> Le 21/12/2019 =C3=A0 13:00, Qu Wenruo a =C3=A9crit=C2=A0:
>> A known regression introduced in v5.4.
>>
>> The new metadata over-commit behavior conflicts with an existing check
>> in btrfs_statfs().
>> It is completely a runtime false behavior, and had*no*=C2=A0 other bad =
effect.
>
> I'm painfully unable to understand how the same said =C2=AB metadata
> over-commit =C2=BB would allow, on my system, =E2=80=9Cdf=E2=80=9D to wo=
rk properly on some
> filesystems and fail miserably on others.

Here comes the full explanation if you like tech details:

For v5.4, btrfs allows reserved metadata space to go beyond current
metadata free space, as long as the fs can allocate enough metadata.

E.g you have a 1T fs, with 2G metadata (SINGLE) chunks allocated.
And among all these 2G metadata chunks, you have 1G unused space.

In v5.4, btrfs is allowed to reserve extra metadata space, near (1T -
1G). Since btrfs knows we can allocate new metadata chunks for (1T -
2G). And we also have 1G free metadata space.

However, in btrfs_statfs(), there is a check to ensure we have at least
4M free space in allocated metadata chunks.
If that condition can't be met, then btrfs_statfs() return f_bavail =3D 0,
indicating no available space.

That check is from 2015, which is kinda OK at that time, but definitely
not works with the new over-commit behavior.

So if you have enough uncommitted metadata, that check will be triggered
and suddenly returns 0 available space, even 1 sec early you still get
tons of available space.


>
> AND show =E2=80=9C100% full=E2=80=9D filesystems with still more than 60=
0 GB free...
> That would make quite much of an overcommit isn't it ?
>
> So I wonder if there isn't something else or if the =E2=80=9Covercommit=
=E2=80=9D
> calculation is not really completely broke in the first place...

It's the old check from 2015 completely broken with 2019 new behavior.

If you really want to dig into the code, please check btrfs_statfs() of
fs/btrfs/super.c.

        if (!mixed && total_free_meta - thresh < block_rsv->size)
                buf->f_bavail =3D 0;

Which is explained in my patch mentioned in previous reply.

Thanks,
Qu

>
> =E0=A5=90
>

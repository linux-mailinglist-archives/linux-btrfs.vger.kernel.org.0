Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F262622BB14
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 02:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGXAk3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 20:40:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:50575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgGXAk2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 20:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595551221;
        bh=o8h9k6kj7mXM/Uar0lk2aWnV9DFpmBrtmuBiDXBWorg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hlrQ4Xc3LypxaHUXtVSjiTZD41pxHauNDQur9KV2mt9b/jbNecb/1abUtdvNr2Z25
         nptB3Z8gm2ONsB4Pn8eStjxRQW9/sn1DyN/bfOn+FXlt9lH0htjcfjd5pPZKANTZlu
         5vuA85HF6hmuGops8V2GvUqR6bVTNBdNocIldxso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDkw-1kjBF70DVY-00xXve; Fri, 24
 Jul 2020 02:40:21 +0200
Subject: Re: [PATCH 2/2] btrfs: fix root leak printk to use %lld instead of
 %llu
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200722160722.8641-1-josef@toxicpanda.com>
 <20200722160722.8641-2-josef@toxicpanda.com>
 <20200723142041.GD3703@twin.jikos.cz>
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
Message-ID: <ce52445d-b104-252c-005f-9bc13b2141d7@gmx.com>
Date:   Fri, 24 Jul 2020 08:40:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723142041.GD3703@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3OkwhvhJv6fBzOWE8Nwo2am7tYqLg4Cn8"
X-Provags-ID: V03:K1:BpJUMem1yY3ZvZjfNlseyiJu2UVZES0DNBFcpye7K5u58Ez4z+0
 ltTcSyJvPACpgspdwGmwJTRZJKDlhL2D6Vyekdob+0nkiateihkbnpKQGCF8AYkAtC8DS1L
 xcDw5m/uS4tcz8g3zjn+DkxEh+0zjZdq593Rczw4NIRIQu5XeH7Nf7CwGhYq7+uqjpkU6FB
 4RAWcwVE8jbAJXjKbTjyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N8wOg4nLckc=:RS665Imy+bM3MHREWvCyAg
 +zho7k2H3BNqI9DrrKaPb0qBqEQib+CaAHapFjVVolc9+VfVgYR4GK1OjmzhMcSyMWApOx/Vp
 +mnP4klcSjq/9k2pRn+zPlfkmTTGM9xkcjBVUi0tSWwUCtRVoQ7X4/HNUAokpARt1l6fy5a8g
 pgkvTbXb3nDof2KMoExwWJBXacJEFAdLU6ESv96wfmw4UsO9NDrVKqptxVpXYdndy+jlGxaPB
 JkbqSZaTbo7DeGFx0JkKCe0n3Dl2pC3fWj08a6r+omSONYEPhqhNs0EYSmTs7PQGin3DPx6Fb
 4HJVzgxSlOU9prVXAWzny4veraOqJD2jhPEAEVDERI2uZWTApBN1D87REvY/akYsCtRnihpqv
 RCERzXLjyjKjnSqSwIoiUUkFbfnUG7SVZCXNdxsqT4sQkQCc/oOpK8MpYut8KgBe9ZpcmHfeY
 wHrcaOSGkaoAvSx7hT/axx2kJimIscPlCEKK3ZdoKxfeUrzMaMPxJYR25aoE202z6Fpbp5scp
 SsUNPxpvpFtO6+I2M8J9rHrIFq53+jyOEY6QCrK/jMGgsaMM1rMb95QgkQ5ysMmNOD5zFTHSb
 uOX2Sa9LVpIumX2HJCZ4QHKuCC2zt7D30Dqf05yuxU8QdkyyGTAMuHOFsXS+IXZmA459jEr16
 73BHawU+08i8FMRA1yiNqA2eNhqAHfZyXa1dTu2iZDZtnouMAGspfk3L9CsWS16fShTOGRyK1
 JOVZCbguOKer00eDRqWOdgnYYa3FbU9BGsQ/L1qS2bfdrHaJg36DHM0fiR/maJoztB7HScDtU
 sR+jFvdfWXrx24a8uT9UzM3DabiaHgyb3SwOZCM8Kee5CVQdIRjOkHM5C6QD49NItubzkqOB8
 PEdODXbKhjtrgfHlRPOEiX4UghwpVTCWDxagurifknrh5Bgm0kHPfvveo0LrY1R5U4omayL89
 i8XJxBMZO48K3mxl1u72Wht7Uzb3CHVmWrQLH2ZLwIWV8oC4xYWYRSr8ixDJXBMt6qRB4lBpi
 B1UnGrHB8zJstUrzbJeZHJkwCAbLbS3uWvuIRDpo9COIpEoM//mpTDdu2DNJ6L585cZNfGOoO
 PSVXimMn0Yg3/jaNbNuLb5Ypp6at+papvYEwTsrSVlVehz7GmqebNH4aZp9V4+hmIePvvhzch
 QJ1oFKk+18Lt00HxJk2f9OXuHg5/1N3EhgwHmCgxNMPIT+Y9UXkq1axtv8UUwtl1UyZ80td4N
 R+hULDAyVKKaGSCOEpTIWKp2n8xt2fHzbOFgBiw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3OkwhvhJv6fBzOWE8Nwo2am7tYqLg4Cn8
Content-Type: multipart/mixed; boundary="nKewHv0Ji2rcGXiKUTd51ipf46CJhkxlX"

--nKewHv0Ji2rcGXiKUTd51ipf46CJhkxlX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/23 =E4=B8=8B=E5=8D=8810:20, David Sterba wrote:
> On Wed, Jul 22, 2020 at 12:07:22PM -0400, Josef Bacik wrote:
>> I'm a actual human being so am incapable of converting u64 to s64 in m=
y
>> head, use %lld so we can see the negative number in order to identify
>> which of our special roots we leaked.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>  fs/btrfs/disk-io.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index f1fdbdd44c02..cc4081a1c7f9 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1508,7 +1508,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_in=
fo *fs_info)
>>  	while (!list_empty(&fs_info->allocated_roots)) {
>>  		root =3D list_first_entry(&fs_info->allocated_roots,
>>  					struct btrfs_root, leak_list);
>> -		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
>> +		btrfs_err(fs_info, "leaked root %lld-%llu refcount %d",
>=20
> But this is wrong in another way, roots with high numbers will appear a=
s
> negative numbers.
>=20

Nope. We won't have that many roots.

In fact, for subvolumes, the highest id is only 2 ^ 48, an special limit
introduced for qgroup.

So we won't have high enough subvolume ids to be negative, but only
special trees.

Thanks,
Qu


--nKewHv0Ji2rcGXiKUTd51ipf46CJhkxlX--

--3OkwhvhJv6fBzOWE8Nwo2am7tYqLg4Cn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8aLfEACgkQwj2R86El
/qgwNwgAgqH6I+HMwrmGg/LVt2ynYnwiYpCitV/Bv7J3w/jS3b6KzJUqiE3Fdaya
B+M3JVz9QjyHdFloM5Sb6+14qsuU54+TDR0VaMW3Zy3XkJ19PnzZXEotwRSSeBsi
rOks35O2q4FnJKsLqguFuwZHPPKhwkyWxYLoJKTaqThBvc6HnFKYPRPR06BjHRqn
R+nZ2Z470FVpHIiEDb3EXhsiMQU7dPrNmEf2ZHw/eTSXco2PQXzT0hg9jehB6+Qg
8gT9DLZsBwdHlqpk5R2if2ZOk1/v0brJM2cIAqVjqVb3dDK71IOgtJHiTCGmqFtQ
Eo81kEnIldWBBbA6YFS2EK2ot9p5qQ==
=M18b
-----END PGP SIGNATURE-----

--3OkwhvhJv6fBzOWE8Nwo2am7tYqLg4Cn8--

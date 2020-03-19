Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9D18AD1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 08:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCSHEN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 03:04:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:50899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSHEN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 03:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584601431;
        bh=LzKrPajldtRfnRNJGBgChrJ75VZQKHKj2+XFBHd9jnM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=J44NuknNjM81TZwZM3VTtXhhQWe5L8L+2fv/coDrEsKpW0ym+3ta0i2hIuhABeOlQ
         FJ61c+iX/YIDE0mnSnG5B3DpbYHBSJTpXAppqyDBnWRwyEfNxCpUpX2qpxaHDL/TjX
         gsAhKhOcROFyJA+8yYNoka5KTW1qF/01Pszy60fk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1jccea0m42-00pOB3; Thu, 19
 Mar 2020 08:03:50 +0100
Subject: Re: [PATCH 2/2] btrfs-progs: replace: New argument to resize the fs
 after replace
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200307224516.16315-1-marcos@mpdesouza.com>
 <20200307224516.16315-3-marcos@mpdesouza.com>
 <045de5ab-e46e-3108-5f28-3f0a1c4e6902@gmx.com>
 <20200318204750.GA26752@hephaestus>
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
Message-ID: <c6c4abda-6789-79dc-d6c1-00de36258557@gmx.com>
Date:   Thu, 19 Mar 2020 15:03:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318204750.GA26752@hephaestus>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WpaBZRW45ixdITFeePLx88ebrDar7K1hj"
X-Provags-ID: V03:K1:xg10ltmREleXM2JIBI+f3VMXJlGUoGf/ykA+Mhs8lhXszCuDbMX
 xtHWYMwFWVIdOvpm396bCEkKJlhgHixSdILmG7nl+oI4hvxwKdX+iHaAbZ/xQljpmYeSx7P
 d6yhLKhAfWzvp8TSVPzeYRnZqcHBt1U9QWQNQA+vE0fMCtu6/GHaBF7n1LCGDj4oP9V/DwB
 XLH+eP/hg9tj5q1G2Rm4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qhN3QWkDJ4s=:t3idn7DO/0pXc8gxaUEY6c
 WqQe2R57do9Wk/DqFHOOErTHmG7np/GOvdFj8JmPM3+zqNzEtEXI2JsOKQBUjk+iyB5ubbf4i
 0jLyNmaso+0HkudbvYJGTb5nXFVcdWhbJ2Oco6yzRzN6mfZ2HIWmZrxYbiHI3xtFB8n4FD+l3
 7Hf8DuVEUPO92ZUzCZLh4cZqjtLP6ElItNX7Q6c657kuwiBXWJGB4JbWJCWF+fZIKKdus7QKr
 64ub2tRMar3pFJHiiJxbJ+CSiTp6zK+3DZ6iZ0rDw/n83Bu6ivm1J8Bd5L6XeA3eiFs3r5Mjm
 Gx6+tbhdMH1VX8oC6U2QJOyFOf1hjR33lAk11gZTriZzMLGkcfvadWBbYuhaOTU6QIzzkcUd9
 igXYrbTSF37IEvI8f55Yv1o5zD7DCYNAuod23aVkXOEHGKU0fALI0Vg62EDr/v83ZiPtSLywO
 j2MY5tBXQunVKM/Aw634SY0gNILVO9te+O/ddwUtdvTbFyUgdx2ONJzUHh6LGB1VNqo72IbP4
 FPgmzHxUxA/ldsJEvELthOA5SJ/qRLkXJ0tPq3fmWKmQ9zv8QWzkhWFQCkK1M35Wazvw5cHX4
 upOVdpM9sMB8esibd6ZK/v102lhDEeN7e4uZzdVQSb/6rXqyZqXc6ZR+T1FHLG5xKfsODINPh
 AoRhsFaUaTsU7S4eBkqdxB/X/CY1yqN91mH6ay/JfoVaLCNYJd9J98Sdz0FolCrIOdOsSeejr
 ztRjQEQrQaBe/V5gFYHEwdElsCe5ZT/CFrq3QeBQrEXhoLrPCOf6563PGtL6UpMpYFPW/7ebL
 /HXgY3+czHAg5wwEqzNOHFg68W4ddWEeGaXiccBYAOOQUAC5bf6elxVvIZmeFdgcAGuwrHfy1
 3RwzORUnQL2xKHEg3H96Y8xlsT+VRTgMn9BnJOvLWFDrGMhMROmdl5C1z14COmBieG7ZV3aCy
 m6GS8vzzvdADH2foEIiQSjshFTQWhMmmmWnuxOqraEabPQkwFea7HLDl+U1+rkAwHYaZmO1Fk
 NVaEY6nnjeIDDq1OvlS5r/PHECIv+g8Fzgc4PgGsGpIPKahmYta3tQARhpv5oUt/VfKI4YSr9
 wj9gpDg0lvccLqj6ykrTI8z3QAez95mb78LZMkNk7CEIuZToCgaqDWwta5AvOPiNiEWUHUb5h
 GNtRktHm2t1D9lalyeyCGUR9k/vlfE7VdiO+qYYzYBFib15VJQWCdN4RF/ceAzczFd0ZM6BzO
 YZFYtlMBqtXVai90P
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WpaBZRW45ixdITFeePLx88ebrDar7K1hj
Content-Type: multipart/mixed; boundary="7tO9tRy4Y37ARpqhRNVLyfGqCx03OfrpQ"

--7tO9tRy4Y37ARpqhRNVLyfGqCx03OfrpQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/19 =E4=B8=8A=E5=8D=884:47, Marcos Paulo de Souza wrote:
> On Wed, Mar 18, 2020 at 06:56:51PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/3/8 =E4=B8=8A=E5=8D=886:45, Marcos Paulo de Souza wrote:
>>> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>>>
>>> By using the -a flag on replace makes btrfs issue a resize ioctl afte=
r
>>> the replace finishes. This argument is a shortcut for
>>>
>>> btrfs replace start -f 3 /dev/sdf BTRFS/
>>> btrfs fi resize 3:max BTRFS/
>>>
>>> The -a stands for "automatically resize"
>>>
>>> Fixes: #21
>>>
>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>> ---
>>>  Documentation/btrfs-replace.asciidoc |  4 +++-
>>>  cmds/replace.c                       | 19 +++++++++++++++++--
>>>  2 files changed, 20 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/btrfs-replace.asciidoc b/Documentation/btr=
fs-replace.asciidoc
>>> index b73bf1b3..e0b30066 100644
>>> --- a/Documentation/btrfs-replace.asciidoc
>>> +++ b/Documentation/btrfs-replace.asciidoc
>>> @@ -18,7 +18,7 @@ SUBCOMMAND
>>>  *cancel* <mount_point>::
>>>  Cancel a running device replace operation.
>>> =20
>>> -*start* [-Bfr] <srcdev>|<devid> <targetdev> <path>::
>>> +*start* [-aBfr] <srcdev>|<devid> <targetdev> <path>::
>>>  Replace device of a btrfs filesystem.
>>>  +
>>>  On a live filesystem, duplicate the data to the target device which
>>> @@ -53,6 +53,8 @@ never allowed to be used as the <targetdev>.
>>>  +
>>>  -B::::
>>>  no background replace.
>>> ++a::::
>>> +automatically resizes the filesystem if the <targetdev> is bigger th=
an <srcdev>.
>>
>> Resizes "to its max size".
>>
>>> =20
>>>  *status* [-1] <mount_point>::
>>>  Print status and progress information of a running device replace op=
eration.
>>> diff --git a/cmds/replace.c b/cmds/replace.c
>>> index 2321aa15..48f470cd 100644
>>> --- a/cmds/replace.c
>>> +++ b/cmds/replace.c
>>> @@ -91,7 +91,7 @@ static int dev_replace_handle_sigint(int fd)
>>>  }
>>> =20
>>>  static const char *const cmd_replace_start_usage[] =3D {
>>> -	"btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_poi=
nt>",
>>> +	"btrfs replace start [-aBfr] <srcdev>|<devid> <targetdev> <mount_po=
int>",
>>>  	"Replace device of a btrfs filesystem.",
>>>  	"On a live filesystem, duplicate the data to the target device whic=
h",
>>>  	"is currently stored on the source device. If the source device is =
not",
>>> @@ -104,6 +104,8 @@ static const char *const cmd_replace_start_usage[=
] =3D {
>>>  	"from the system, you have to use the <devid> parameter format.",
>>>  	"The <targetdev> needs to be same size or larger than the <srcdev>.=
",
>>>  	"",
>>> +	"-a     automatically resize the filesystem if the <targetdev> is b=
igger",
>>> +	"       than <srcdev>",
>>
>> Same here, resize to its max size.
>>
>>>  	"-r     only read from <srcdev> if no other zero-defect mirror exis=
ts",
>>>  	"       (enable this if your drive has lots of read errors, the acc=
ess",
>>>  	"       would be very slow)",
>>> @@ -129,6 +131,7 @@ static int cmd_replace_start(const struct cmd_str=
uct *cmd,
>>>  	char *path;
>>>  	char *srcdev;
>>>  	char *dstdev =3D NULL;
>>> +	bool auto_resize =3D false;
>>>  	int avoid_reading_from_srcdev =3D 0;
>>>  	int force_using_targetdev =3D 0;
>>>  	u64 dstdev_block_count;
>>> @@ -138,8 +141,11 @@ static int cmd_replace_start(const struct cmd_st=
ruct *cmd,
>>>  	u64 dstdev_size;
>>> =20
>>>  	optind =3D 0;
>>> -	while ((c =3D getopt(argc, argv, "Brf")) !=3D -1) {
>>> +	while ((c =3D getopt(argc, argv, "aBrf")) !=3D -1) {
>>>  		switch (c) {
>>> +		case 'a':
>>> +			auto_resize =3D true;
>>> +			break;
>>>  		case 'B':
>>>  			do_not_background =3D 1;
>>>  			break;
>>> @@ -309,6 +315,15 @@ static int cmd_replace_start(const struct cmd_st=
ruct *cmd,
>>>  			goto leave_with_error;
>>>  		}
>>>  	}
>>> +
>>> +	if (ret =3D=3D 0 && auto_resize && dstdev_size > srcdev_size) {
>>> +		char amount[BTRFS_PATH_NAME_MAX + 1];
>>> +		snprintf(amount, BTRFS_PATH_NAME_MAX, "%s:max", srcdev);
>>> +
>>> +		if (resize_filesystem(amount, path))
>>> +			goto leave_with_error;
>>> +	}
>>> +
>>
>> I'm pretty happy since it's all done in user space.
>>
>> But this is a different error, here we succeeded in replace, but only
>> failed in resize (which should be pretty rare to hit though).
>>
>> We should provide some better error message for it other than just err=
or
>> out.
>=20
> Function resize_filesystem already checks for errors, and it even print=
's a
> resize message before calling the resize ioctl. Or do you mean another =
message
> specifying that "replace finished, but resize failed" along the message=
s already
> being provided by resize_filesystem function?

Yes, that's what I mean.

Thanks,
Qu
>=20
> Thanks,
>   Marcos
>=20
>>
>> Thanks,
>> Qu
>>
>>>  	close_file_or_dir(fdmnt, dirstream);
>>>  	return 0;
>>> =20
>>>
>>
>=20
>=20
>=20


--7tO9tRy4Y37ARpqhRNVLyfGqCx03OfrpQ--

--WpaBZRW45ixdITFeePLx88ebrDar7K1hj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5zGU8ACgkQwj2R86El
/qh6Pgf+N9glYi5u/reNuIvui+SkHOWmKzQolaBBOwMEvF/D101ex5G1VhckwmeO
rUw5lSkQ6Lf98+nXaDYygl2WrLo4m5j+ZYcGaPEQBeLtujeLW2syCaIbvmMNye0N
3KjA4ou1BQIGalZP9nE3ZOLib+6ov5oQ63XMpRe4+StxIry7jRoG5GV2AMljXRI4
hfdJvPBB3knprMQBT8PIe0X32GS85Og8uGuvD0qelkuE52EFIvpkW2/kmMIVFhvX
LbR+3qzClXOhNjzW+xmsh3whXRXXohx+Mk45Tj+BBLvPobklYHrzn5/Id8lZf4Vt
1SL6/I+HV4FHy8QQMAgfhPl9M7U6YA==
=FwK2
-----END PGP SIGNATURE-----

--WpaBZRW45ixdITFeePLx88ebrDar7K1hj--

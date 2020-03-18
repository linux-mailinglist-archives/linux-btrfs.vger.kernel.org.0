Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E21189A08
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 11:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRK5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 06:57:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:33961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgCRK5S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 06:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584529017;
        bh=9CzifdI+emThFt6r1U0Wo4HHQp5bFa1grnlbewr7K/U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T4NK1ABee0fTHenLHlFguvH63o04an26H4M54S7LD4laatQdDoEIK9A2OkAbWTZml
         NYEtuN7vY/AJOu7IV8BfWF8yYN/UgWjaEC92i3k/B/Sxj0ICjRC9CI64xXuGZtfUug
         KWW0OPA9PPyNmsvokGSQMNJIZvSc4kHIjNG5761k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUZ4-1jdcNf3Scm-00prBX; Wed, 18
 Mar 2020 11:56:56 +0100
Subject: Re: [PATCH 2/2] btrfs-progs: replace: New argument to resize the fs
 after replace
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200307224516.16315-1-marcos@mpdesouza.com>
 <20200307224516.16315-3-marcos@mpdesouza.com>
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
Message-ID: <045de5ab-e46e-3108-5f28-3f0a1c4e6902@gmx.com>
Date:   Wed, 18 Mar 2020 18:56:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307224516.16315-3-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NSsWNxCtxbEaXLfy393FwNYTDHXIuRJZP"
X-Provags-ID: V03:K1:2SJW6BZClm9e52hBPahMeDungCunHG0jhYoWBZduLgAYtfzO6cD
 +DPVCgJIfif5abVHfCCq6BB9T0nAHlivjPT/oVhSDoRa+aYB2P2KBs68cW+D+nuiZWLdhGn
 32Z7VPFi1Jv10NY+xFQ7DPX+D1jpqHlNG1W7tmd1LANwCRx64Zl2D/Sd4u0E6aTcuYTcFYU
 yk+mK2QZm8ngZZyUo3JCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZT0DbEdfyJU=:hqajGEWbqsnWlV39H+AigI
 Z1CWAaqpLYsaqZWsuSYkItafxE53B9ZmpoXj2+E5pK/klp+SUaLb66LDsPo6zSfuYV/Ig2VMI
 xDvcWhoA4gdiu3qh+qiTgFjWRUU5kRx6+USLi0Mo+w12/9oBZbFYi9qK+X+rHgvze2t6ZWa1f
 XLWzQw/9bt2nBLj9Ft7PRFd2Y1+IOx2VWQL1Uybnsfb8V/qfzCDAklzKUbM1N9nqvLTs/NOR/
 mAZUu4UnhRD7XEWDQeSKBV7tIxMrGnIUZmkyhqmkgH4U7ccaOOQlWeH7dsiEeEWC0e/m1/37I
 qUFD2BjKGCak0A7oOy2QHpLV4ImxGk6YKy0lTZO9ctKW0CO9NUKOstEWUxLzom4m3Gn3ip/I7
 5R3JDrbjH8942ri5F1hV9BI77WHAtFU4QA7WApJqBMvIm6xHUH8ryeDf+hu31DxKSiua6ikXG
 yW1tVP0qRqTeqNnPJkBdJh+VonAIKX8HAp1c9fBW6xzUDg5GSV1HyYjKV4R2F77ZT2hMXX2xo
 0HSMo78h8hxPrN9SqKcSSJ+E9V/IHfgP48MNR6mqrcowBr7OzPsn6qH4LkxueGn7cEiQwdJ11
 vOgOp/l5/TEUxLvKqWMZO8CHcR7kkzs/L+auUVGLsM0NGGSrieEZzYhQno/d7fR/lsebMYzZ9
 bWOu9jcJSE+iB8QfP2KPU5vRX/s+a7eL5JQtogkgPuY2WKrwdHg8ByWXijezjPz2tgqEuj24v
 akUdyAN4+NBXyLKyqZlziHIR1IAyWNson9/ANkZZrj6fdWYaAna2BRNaru99vYHSGsirPFZ8T
 G1bO9OagqV2uF5MMcHjlxMZLQGgkiWdmw6hjdm2A3cY5IJgGrhhSrUi7+L4OWnGvMhmwbYHgM
 D6TzsXkx3CP9kfT0cfn3mrhGWKnUEN05HFQ1oTxHwRPEIVl2r31RpO1NPpuUgtESBVuBAQmBN
 +MSRGgpOkW7OU/CoMdtcD9T3zQRIDMpcAUN9TZRFQAbE8jZfhz7h0eseaT+IyzR0aEKYO+MwA
 FBQpd7bdW1aX/Nf4XFqWujVPyei1EXtwwM+EYV2jwF7ff6msIvIqyNmgcMN240y+9t4hpLZUx
 HrIuUehNECPI7RMn14OhJpoDCFt0xdmGCKxMw695wtGiAYl6LmFPAzc1T475L5r74w5XPCx61
 mIYXEFPsfJPrjd5qbTyPjAbQ4bcSk65xM2/GAF1ZOxo7iO9QM54Aom9iC7Y/pbaWgXLqYJJYB
 qBwIra4a2znh+OduS
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NSsWNxCtxbEaXLfy393FwNYTDHXIuRJZP
Content-Type: multipart/mixed; boundary="HC1qYIvo1xqD0izjNkpUS7zQAOMjsTdmM"

--HC1qYIvo1xqD0izjNkpUS7zQAOMjsTdmM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/8 =E4=B8=8A=E5=8D=886:45, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> By using the -a flag on replace makes btrfs issue a resize ioctl after
> the replace finishes. This argument is a shortcut for
>=20
> btrfs replace start -f 3 /dev/sdf BTRFS/
> btrfs fi resize 3:max BTRFS/
>=20
> The -a stands for "automatically resize"
>=20
> Fixes: #21
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  Documentation/btrfs-replace.asciidoc |  4 +++-
>  cmds/replace.c                       | 19 +++++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/btrfs-replace.asciidoc b/Documentation/btrfs=
-replace.asciidoc
> index b73bf1b3..e0b30066 100644
> --- a/Documentation/btrfs-replace.asciidoc
> +++ b/Documentation/btrfs-replace.asciidoc
> @@ -18,7 +18,7 @@ SUBCOMMAND
>  *cancel* <mount_point>::
>  Cancel a running device replace operation.
> =20
> -*start* [-Bfr] <srcdev>|<devid> <targetdev> <path>::
> +*start* [-aBfr] <srcdev>|<devid> <targetdev> <path>::
>  Replace device of a btrfs filesystem.
>  +
>  On a live filesystem, duplicate the data to the target device which
> @@ -53,6 +53,8 @@ never allowed to be used as the <targetdev>.
>  +
>  -B::::
>  no background replace.
> ++a::::
> +automatically resizes the filesystem if the <targetdev> is bigger than=
 <srcdev>.

Resizes "to its max size".

> =20
>  *status* [-1] <mount_point>::
>  Print status and progress information of a running device replace oper=
ation.
> diff --git a/cmds/replace.c b/cmds/replace.c
> index 2321aa15..48f470cd 100644
> --- a/cmds/replace.c
> +++ b/cmds/replace.c
> @@ -91,7 +91,7 @@ static int dev_replace_handle_sigint(int fd)
>  }
> =20
>  static const char *const cmd_replace_start_usage[] =3D {
> -	"btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_point=
>",
> +	"btrfs replace start [-aBfr] <srcdev>|<devid> <targetdev> <mount_poin=
t>",
>  	"Replace device of a btrfs filesystem.",
>  	"On a live filesystem, duplicate the data to the target device which"=
,
>  	"is currently stored on the source device. If the source device is no=
t",
> @@ -104,6 +104,8 @@ static const char *const cmd_replace_start_usage[] =
=3D {
>  	"from the system, you have to use the <devid> parameter format.",
>  	"The <targetdev> needs to be same size or larger than the <srcdev>.",=

>  	"",
> +	"-a     automatically resize the filesystem if the <targetdev> is big=
ger",
> +	"       than <srcdev>",

Same here, resize to its max size.

>  	"-r     only read from <srcdev> if no other zero-defect mirror exists=
",
>  	"       (enable this if your drive has lots of read errors, the acces=
s",
>  	"       would be very slow)",
> @@ -129,6 +131,7 @@ static int cmd_replace_start(const struct cmd_struc=
t *cmd,
>  	char *path;
>  	char *srcdev;
>  	char *dstdev =3D NULL;
> +	bool auto_resize =3D false;
>  	int avoid_reading_from_srcdev =3D 0;
>  	int force_using_targetdev =3D 0;
>  	u64 dstdev_block_count;
> @@ -138,8 +141,11 @@ static int cmd_replace_start(const struct cmd_stru=
ct *cmd,
>  	u64 dstdev_size;
> =20
>  	optind =3D 0;
> -	while ((c =3D getopt(argc, argv, "Brf")) !=3D -1) {
> +	while ((c =3D getopt(argc, argv, "aBrf")) !=3D -1) {
>  		switch (c) {
> +		case 'a':
> +			auto_resize =3D true;
> +			break;
>  		case 'B':
>  			do_not_background =3D 1;
>  			break;
> @@ -309,6 +315,15 @@ static int cmd_replace_start(const struct cmd_stru=
ct *cmd,
>  			goto leave_with_error;
>  		}
>  	}
> +
> +	if (ret =3D=3D 0 && auto_resize && dstdev_size > srcdev_size) {
> +		char amount[BTRFS_PATH_NAME_MAX + 1];
> +		snprintf(amount, BTRFS_PATH_NAME_MAX, "%s:max", srcdev);
> +
> +		if (resize_filesystem(amount, path))
> +			goto leave_with_error;
> +	}
> +

I'm pretty happy since it's all done in user space.

But this is a different error, here we succeeded in replace, but only
failed in resize (which should be pretty rare to hit though).

We should provide some better error message for it other than just error
out.

Thanks,
Qu

>  	close_file_or_dir(fdmnt, dirstream);
>  	return 0;
> =20
>=20


--HC1qYIvo1xqD0izjNkpUS7zQAOMjsTdmM--

--NSsWNxCtxbEaXLfy393FwNYTDHXIuRJZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5x/nMACgkQwj2R86El
/qgHIggAqrTpU33DK86NImG0eyvNSJcKV4A74U64ad1hZZDgmMs6Bc0C+DtIoEa3
zYqz3L9LgmOlszfSL6R/wfOYf9z8+h8k6MA6tIUy+Ol2V6FAJSAoCtevE9VkpMqL
pKFyCkoWU9WR/TmA6GxGMhXufUrpiHMYUFF4KAL8/2CQhzTeE9EVmTwG7sZuK+px
tutPU4NE9HiZ8DGeVmOBw0RDRmm6zxbWaByCuRvVfYHXCydac1T/ICwHDOPI5XKI
83gKhflmDShvrIho8FtI7EFwJKDa6bYJ4Ff0aHtSGtpVym6Rb3ytItAyKucqX2kV
mNKQ54qTZtKu2cwqGkaO9mdYf4WLDQ==
=bwWs
-----END PGP SIGNATURE-----

--NSsWNxCtxbEaXLfy393FwNYTDHXIuRJZP--

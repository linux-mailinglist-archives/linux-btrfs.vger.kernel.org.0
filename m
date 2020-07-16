Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E42218BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 02:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGPAPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 20:15:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:52087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPAPT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 20:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594858512;
        bh=S/oRe9zBudJ+a06ninXBZ8EZe9AIIxVE+8Rbt/sdpEY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AUaLWZTiu8ySY3jx0/63i55Dii5oY1l1C/wemFnvpmZ6KlWTKICpP9MabH1zIgd9h
         8OxgT/QZT3rnxuoTNykSXQBzjw1I/JVEvlezdYyX56MZ2+vkAHNJZUkND2G+cjxrAL
         284fgsSpnFcbcY4SIL5TlGgIH1jstJ/RAwna+n4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mj8mV-1kXvb83jWv-00f8sg; Thu, 16
 Jul 2020 02:15:12 +0200
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
To:     Chris Down <chris@chrisdown.name>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200715134931.GA2140@chrisdown.name>
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
Message-ID: <e973ae45-c746-95b7-d176-180d47ecb2e2@gmx.com>
Date:   Thu, 16 Jul 2020 08:15:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715134931.GA2140@chrisdown.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vkE7UOlaGx0P74iBgXS0rx8SU5D6UI2qR"
X-Provags-ID: V03:K1:BToiSrHAYhUhDxcMs0h/OzHrjiLAzpl4GvnRDm8L0qowcYJg4Ft
 Bh6vcUx9OmQGw/TX9j/yxfdTIcptfYJmR1srJ7j/UY/R4bd26xMWZoC+P9pESz1K89/gKO5
 aTTtzytqpoFp3FCJbuSJ5mGcPY54a9KL69FAvx9SCJvZj9TIPk3W9dgGkpUle5NCDt2gUe9
 B/xoAOep5OtSElrPRGgbw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:87eUFBhNzDE=:ZhCfdkzQ9/OSalJqyexAev
 oZEvIRW7aa9phCNP5X2qnffajiF57QfqqPFn6G4vPVkT+2UQsAeLoRGb4HFn7QfppdYOkDYJa
 +Ua2ThLU2pVPr2H2Unm8xQgIKF0dUuMvyZHrR+zGNznfcbq2icmQE6JAUa2AW3js+5EtP82pE
 V0asxzNRGHEgdsq/hNTMG9g1JZOTuRu1ZVPzc2ApCit2+dVYpSh1/yFPD51RBoSaEWo+vaAe9
 5wp8hRm0BT/e8PGZZlkXHm5+Uyg9TBi0JaTG+frgGLwOe775CRymzZwxBcB7rxJGYPl/As6XD
 6A8Cl9vdOKjkexMds2eJxY7WjWhetA0fPJsGr9CcRzv/K70NJJvzrq/nzf1hR120yvwdwrXEh
 yldTvyILYJkLjkBMww/Fry/0H9F2ecXjkmOvy6aVWJDfcKJGK0bArwZ0A8TuqzJfJKxaao8Yp
 zdVili7xISm7ELbcl6QNtCJ7l7Ittd56aaoLzRiKbEI6yBHIIl9/sSjigcNvpjKHhoYOYgK68
 26VPcdCw7ypZnBab4qfBfhHiMnW8ILebhYlaoNi9uHy4VAQ1ZOo67fzx/LV1MxxOfQhdBjUAq
 rxeIooKqsebgll3Vz4A9atb93zhv2IPCy3cL0nN2VdhsP+gEKkRspjfxv7aJIVVKs1U5vK20E
 n3oITGHp9itRCm7vpwVeuzD8eX6L3+PvhYmr30rfy9veovLhWEWXHgopYeRJnk2uSMOOHuChU
 ud6GDsHqEyCrDjlCVSEVUEarGwE5prMhaT78y+51a3TuiDJWMNB3BrSi21svqTHeBauzmTxHq
 RyAj8WuQM7ZHMm111MFTEZvr5nK74D2xVM/M/xq2Zy8qxcrbKEqXqzmxRCwzB8t4mzMOg6qLf
 cDCXQ2kztb7qNIUEOIUmPrZkSKaVDR72ZNM9S86LKgBexKJLVZJVQ7lM5wmSd4/g7dgpT/ndo
 mU8u1yEauKZYLu35v7Kit9HPL3EOwAspywclJqt1YJi/6v37+Pyj0HXWQxur/dG+vJTnfY9JO
 bJgkN7JyHylxM7QIEZZXvf4A02RK2a0A+3FtGI7IVQWE30IHA8EM+VleL94aGNXhY79l38Yqa
 XOhHMZrgQTaiIFsvB43KjGtnFe3NCz4xpuQ7GW8FLfvNAiIBT0W1/CZaotfHdrlxMHzVNH0LT
 dPs37hyL3duVIxTN/LWIzGo/zVbL3xoDnrvzjF+vfuoPsy01TK5o6Aj2+bRyrXfDoRyby8Ots
 vXC62LQfeIfBEVCdWmkw+npnpBx9lp0M6mCanhw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vkE7UOlaGx0P74iBgXS0rx8SU5D6UI2qR
Content-Type: multipart/mixed; boundary="jV1jsiF3t3CAM4fbGg56H118rgUfEzDkB"

--jV1jsiF3t3CAM4fbGg56H118rgUfEzDkB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/15 =E4=B8=8B=E5=8D=889:49, Chris Down wrote:
> Hi Wenruo,
>=20
> While testing my pending patches on top of linux-next, I encountered a
> bug that seems related to this patch during btrfs unmount. Specifically=
,
> a null pointer dereference in kobject_del inside btrfs_sysfs_del_qgroup=
s
> from close_ctree.
>=20
> The fix may be as simple as checking if the kobject is initialised,
> although perhaps it should always be initialised in this case, so I'll
> leave you to work out what the real issue is :-)

Thank you very much for the report.

May I ask if the qgroup is enabled? Or qgroup is not enabled at all?

Thanks,
Qu
>=20
>=20
> =C2=A0=C2=A0=C2=A0 RIP: kobject_del+0x1/0x20
>=20
> =C2=A0=C2=A0=C2=A0 [...]
>=20
> =C2=A0=C2=A0=C2=A0 Call Trace:
> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_sysfs_del_qgroups+0xa5/0xe0
> =C2=A0=C2=A0=C2=A0=C2=A0 close_ctree+0x1cd/0x2c0
> =C2=A0=C2=A0=C2=A0=C2=A0 generic_shutdown_super+0x6c/0x100
> =C2=A0=C2=A0=C2=A0=C2=A0 kill_anon_super+0x14/0x30
> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_kill_super+0x12/0x20
> =C2=A0=C2=A0=C2=A0=C2=A0 deactivate_locked_super+0x36/0x90
> =C2=A0=C2=A0=C2=A0=C2=A0 cleanup_mnt+0x12d/0x190
> =C2=A0=C2=A0=C2=A0=C2=A0 task_work_run+0x5c/0x90
> =C2=A0=C2=A0=C2=A0=C2=A0 __prepare_exit_to_usermode+0x164/0x170
> =C2=A0=C2=A0=C2=A0=C2=A0 [...]
>=20
> Thanks,
>=20
> Chris


--jV1jsiF3t3CAM4fbGg56H118rgUfEzDkB--

--vkE7UOlaGx0P74iBgXS0rx8SU5D6UI2qR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8PnAwACgkQwj2R86El
/qgFfgf/WYL25kfquKQixj8kyTMdbLBnWs1iQ+sVNJCeoctHm2DDUEFED5hxWdDO
TWtp/GLCSf5RVsXMZjr1Fc5BYBMByI6PW8+tskh4TjBbGhAEIGTNo8qyvmtEsglR
9Vsn8FOjcIODKEgmTYftBh0+lhJH4cVoT7h5KFs52SUcix7nLLZJKfXuckbDPXsH
AEsWZ2osdpxXNUzocaJPZu2zHdsIeTCmlnhndjNoK+SZrOWyPsy0cq1xePt38EN4
Y7GzW7146PB8ZVlh/L3PX3nFacLkJq3GdpigP0+g+vcti97P/juGZFzodSEZ1kLv
nyN8fvQMGLzPC93zXnxTAUlL7p0QkA==
=KbQq
-----END PGP SIGNATURE-----

--vkE7UOlaGx0P74iBgXS0rx8SU5D6UI2qR--

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213EE1FF1F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 14:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgFRMff (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 08:35:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:34261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgFRMfd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 08:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592483727;
        bh=U9S3lZ8tR44/5v+LHyhXlA+agoIG6zGsxO0XdUhp/No=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CZjVc+spsg/jQPNr60KH8K/lWTubjWdHK6MQ1JEK25FA3yZ1dSj3czwGnwvrHpWYn
         0RC8SaNl3lcHJs7rsJ06EuevkEbcC30/n/9Ttyc/PdnPABeN2p0/AUzB5NOz8c9Rte
         kevKLJPLqH9HEutJoglD23i4nZSdblohMu0KX2bA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXFx-1jhEwZ1TJh-00DYes; Thu, 18
 Jun 2020 14:35:27 +0200
Subject: Re: [PATCH v3 2/3] btrfs: refactor check_can_nocow() into two
 variants
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200618074950.136553-1-wqu@suse.com>
 <20200618074950.136553-3-wqu@suse.com>
 <SN4PR0401MB35988624F5193F3102ADB1579B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <de3bdf98-0786-7c28-9ce2-1a9df889a213@gmx.com>
 <SN4PR0401MB3598A324B910017E234C31CD9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <70cfab56-cd61-c0de-ed67-f286fca75f66@gmx.com>
Date:   Thu, 18 Jun 2020 20:35:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598A324B910017E234C31CD9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XHn1VNX5CsM8mKcuqhKtvqgvMtmZgGZsB"
X-Provags-ID: V03:K1:/see/ZsuX4atScUEsJ+9gx+Nhz3gD0DcpBSDIJtpFhu31FA6dzD
 XGjJPzpHYpFfLBsJWfi1bf49D6tKeHF4a/O2yMls+ahSiJxzqHlDzm+QHgpteFezuFVQThG
 jukDS1DbbUW92a8BKowoAiwryWxtmIvDxFN03pbTqO5zzhC1EAHgWLsNVUJn09Ij1WfLjy7
 Vdo+61ossQEDIxCztv2wg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E4w2hLf++RQ=:ULNmzOXGRx94TCBXYQVhAW
 qfIShiVc9GkiQhw/GnCun5udHNjALPKjQ/3MEAAIaEfzrtjwU3Z2otVjDI/WtFTvGZsILdPH/
 J5gYvH97Tju1SSjdmwtmo0SDb3JGL/G98iiUl4vmtqzTHdxPXA3sExZda/tKKDPG7x/6rExhf
 zt37+6pTWjiZq/w+v/5n3yUgEoBdt+ku0OPjsZY28QkAHK7RoNuTOzgx8ab1lb6KFx2wKhbAW
 vtHwYY/iqAdsKmM/zPwzvG3ffISS7yAjCuq4eV2P4p2A9pEJnSFSLlHrT7vrjuVY8Gqvt1BZx
 Snw0QwH1kR7hmNf7h6y8oC6W2uvLJVPK5Sl5i3C0Y0esaUsEpKDUc4mQL3gcBMGFS2hibncYW
 z8GV4wtZWy0n/ntSvexZE1EpYo4sTKRlB8oblRPXazG0ises2SKsSpZ3RKq2H+IGiWAd6aqWs
 8lqCixcO3Oy8wds/3woX+VIcdUPkoqTDIW7d8kjJuakHZXVxlMIwYlnVHXeuu/wpgF7ybNSrL
 L5sh49MKn4kFWku52rCxlAbQa3nw+vrRpIaZsPshQILyByLApAmBXyLSWTef3YCBBdZy7Rsuc
 XOr5YesMDlAOgE78kx0+QXiYx5/wJlqL6u3MZV38pMksbXFg5KfkPbxqWOtPCDqwKQ5ztTlmf
 rgWQaJz3p/OOlw54XY3DRnKFlzlnlOzEK7kgeQ5a3rBXt1Bb5Qf42X8QmhhhHH++avl8cofrj
 n6OIF5WZaFh+hZjoj1wMwWNef3xm+xyseLJLDCI1iihdPTDtF+DyrdUNfoVg8mKSphaTrVl7C
 QvuofO0RBbMREVGLKXkkn/z3Ch8zlECKCVfT/qO7nWQYtV60nC0cT4mOOi5TajB1x4VhNWzhr
 aMiu0eKnIWqgI+EpltQdGDF+UcfgsKHZ3spgjWYN66PQqMCA2U0++DR328x+tW5h8jeDs4QNy
 rYV8lAhs2zvmCSQK4dZ2PQVGSQSpP6QFJYE/X2a25ycFteyKVCNTzMGlAIneaLPGbZjAopIyj
 GFUMEKsBMNj7I581UnmJZF3KZgLSV21tcQenJhfNbOP9m6wby9sFhLfGruB5dvjJ8npDAbzZJ
 HNVf/fwupkeTbg86Zis3PuLWyayUXMadVE+1EllkucvpI6QT4B5+QuUX+uCAid6liscgBUYc+
 yUQtbifruz0PBqfogCtGEVguwALlFBcNcyboJXbj5Jk5RRhQ9GgtjNBvdQ7KD6EZpyyi9UP7E
 TZO14CLUGAN/hXYvK
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XHn1VNX5CsM8mKcuqhKtvqgvMtmZgGZsB
Content-Type: multipart/mixed; boundary="60rWg9EOcbWLCcigk5Z52hxBdSzkPLhHM"

--60rWg9EOcbWLCcigk5Z52hxBdSzkPLhHM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/18 =E4=B8=8B=E5=8D=888:16, Johannes Thumshirn wrote:
> On 18/06/2020 14:09, Qu Wenruo wrote:
>>> I find that try_ naming uneasy. If you take the example from locking =

>>> for instance, after a successful mutex_trylock() you still need to ca=
ll
>>> mutex_unlock().
>>
>> Yep, I have the same concern, although no good alternative naming.
>=20
> Yeah, there's only two hard things in computer science, cache coherency=
,=20
> naming things and off-by-one errors.
>=20
Best meme of the day!


--60rWg9EOcbWLCcigk5Z52hxBdSzkPLhHM--

--XHn1VNX5CsM8mKcuqhKtvqgvMtmZgGZsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7rX4sACgkQwj2R86El
/qitrQgAqEI2wDMwypbcmq5AbZhe8qojJ2hJoND4eC/y+tcIhPSClwcOr+SO2SR1
qCkHwwW7nd1xcxgeUH+GemLqVnbjgrYNYhSrjUWb3yJJZU4GHjRazmydgJGQEmQr
3UFa4zKQ0UkHxn2lZagcu9YRMWTgNvu/fZdHSdTHI4nfkF4zVUyWVCTK1htX+X7C
iXog0NaGU7zB4hoUD5DZL8PQh2Q5ztVlQJC+0E4bP9ac1c9E73ZEB3KY1cf5irDK
GCbegukisyg4UOQsCDV36v7bvv8DZJQXmZGOlpm4SYhTqbxZizj57z9c6OqQcZOH
EPlXQJT9DQUjdv9Vvk1Jyt5i26ctOw==
=Nr4r
-----END PGP SIGNATURE-----

--XHn1VNX5CsM8mKcuqhKtvqgvMtmZgGZsB--

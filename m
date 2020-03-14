Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0A718533F
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Mar 2020 01:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCNATM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 20:19:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:38227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgCNATM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 20:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584145147;
        bh=L/1w4R2Zr1oOVwmxsUpotlqxr9Vvq0PYX5GtYQ6qdHc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Y9SQN8nKVgJvBaub8lxW23foeznexrOEJDZL413+g8tXa0Qc2KUPUbOXUqeJ36oNx
         pH2cY7p0nKqKawuLDs3BfOi/k6FXgRiRvDqzVs6MsNA5XLdkgEiIohLyAoCnGu0CdG
         pOyjXPJzmH0lzyv3ZZ5awOpSova7SFxlQJNemq8k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNJg-1irVjn3GYE-00VMTa; Sat, 14
 Mar 2020 01:19:06 +0100
Subject: Re: [PATCH 2/2] btrfs: do not READA in build_backref_tree
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200313210954.148686-1-josef@toxicpanda.com>
 <20200313210954.148686-3-josef@toxicpanda.com>
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
Message-ID: <6f64924e-bd32-46b8-8922-e3a2914d7d8e@gmx.com>
Date:   Sat, 14 Mar 2020 08:19:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313210954.148686-3-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7fFVVzleNYsfsZmBUWx22hv7nsInY4xMm"
X-Provags-ID: V03:K1:042dvYT8d/iG28j2bdJzKpQzX5N0G9YpD6vHvpbk1kBWF2IcsuY
 KFsREbaACy+5WnG7rs5fdJA7cexTn2atQ2T2DqgjR0tj4uTorwoWSDicPeBZg0UKLfJo4fl
 t7ykBS1jRm/7NEou/+HN6I423HIE5goL6hqRtFvDahvT212AdbLFDaT1PU3iNCsD8cFd1oQ
 7qZPzgCA4lS61TvH6cd9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2omNH1Flgkg=:tNLEMenionAZoqDWiEzwv0
 bssM4/PfJygOYrMm++dfEGG8R1OwYQbCDAaPsAHr6+yjW6h3/OPw2cOXnSZlsapc37zbYG9Le
 R+xfreH+rsCZq1JBpNV4fDgc7S+BTxUum4SEuj5dChxZdTzDXGxcRN1Yo/I8j8n+VDKFu8SNh
 pN0xqJLCcTK45B6VlFoqQ9MlRVjp40eDXbqPHs8df2RKZGUHrPP3N7RM94L2CrbSt+eATBXBY
 VUPHUAdYePLrp9Rx/D+FSb4Bo1nr5gpveIXvHilch0oxEl1XXz6sl7d/U0zFAyFVUPFjkMV77
 P2ZBKqNC2MBYH6BiP8GY45WfwZ8zhqsbjCnVlPC+3jiCrgb6VgY8dj3NqZBh7HJtUMsNvds53
 KYmgQLP5/5kqrvd9tjGV2XnRAN0tpAqKqWX5HTG0EkcSf/hf8B0jXhHhxkzV063uvt5GO/1Ww
 TwghHspcnLKgzDMIH/kuS5R6qNbkW4JqhNPCFLdB+XR96Cu7eIcnsFjcbojfGWCv4qDquCZ6R
 33jBhqqpyx4BdWMLavrZMZsInOyoeumpjMwVGuoQC5WyBglEaT/Z/Z74uzX1DwP9eGVvy1CNq
 sfuf87yawp5WCOamwyk8VN43zuSKm/XyTHIGAngck5iP1hEgEU3GE5De/ys3hcZHi0rxrd5MB
 MOkJu689q6SDwpA9QnyuZ053sxQdz2mcba1B23lOnilz10VwGLHy2txMLLW38gl+GidJNN7Ep
 lqYMAHd0BWsxnZQXly7KEJRyOewqoA6D0EXB5ekXQSnU6AG7RZE9ZECiNsxnjtRuqoo+43pGr
 X1kMkwrky/zjSEiv9x50091ljWoQZgKd5GfxE1ybySzKG8ncevcvpxN7t029QLQfAtDBaQqC3
 RJqBi5Ram+DdCqPRupspcp6Jr6vuF+GG5LtrsNnprdX/EZoQpPxIPHBdxThJN1IHZao3hh/E9
 GogZhGrUv+cikIKJK5FYY0WS4q/wr7xGrlMcsad7QHUIMUe3LILvW4vj1q5Sqr9nxoyh51F2k
 Ue16m6JHXhL9LaH8rZ50iO8YXN49dW6CP1CEi0EVebaXRFV7aIdi7oIsXHUCzNsjWP6ou4104
 yvhKJSUT8lRe/Qi6rAbFk9Mhff3zdt5PAm6TMUs8xdAm5g+QDtiqQzNMNW7KDsdLBMjt74Byc
 WAAKtkt1fLpgUYoZgfPQKDdIDNoOuBWovpgJMib0iqPf2c8dYMa4O2/Xoy13sf0d8OXGrkFwY
 6ZzHryO5B3zJ17V22
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7fFVVzleNYsfsZmBUWx22hv7nsInY4xMm
Content-Type: multipart/mixed; boundary="JEC0RO3OhkuKzdYbvUVQzWzUbuQWnmHZE"

--JEC0RO3OhkuKzdYbvUVQzWzUbuQWnmHZE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/14 =E4=B8=8A=E5=8D=885:09, Josef Bacik wrote:
> Here we are just searching down to the bytenr we're building the backre=
f
> tree for, and all of it's paths to the roots.  These bytenrs are not
> guaranteed to be anywhere near each other, so the READA just generates
> extra latency.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 4fb7e3cc2aca..3ccc126d0df3 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -759,8 +759,6 @@ struct backref_node *build_backref_tree(struct relo=
c_control *rc,
>  		err =3D -ENOMEM;
>  		goto out;
>  	}
> -	path1->reada =3D READA_FORWARD;
> -	path2->reada =3D READA_FORWARD;
> =20
>  	node =3D alloc_backref_node(cache);
>  	if (!node) {
>=20


--JEC0RO3OhkuKzdYbvUVQzWzUbuQWnmHZE--

--7fFVVzleNYsfsZmBUWx22hv7nsInY4xMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5sIvYACgkQwj2R86El
/qgdsgf/fY5ceGd1+jVBOWi5V/0BoyYyysYqsmxgFwuTh2whL6Ewqi/zkDftR8+m
uJ5eBk1DU38XhqULb1kvbMSYu5/lwVtplouaDCjp3ZLx19bd6DAXthmo4wnLDv3h
Dvq6styYf+XFNclW+nkS9MP3pnkuWsgfzn0YUPGyS5MqQZ8l2mlpU6wANbcxKGQL
h7tjBDDGl7hXGQ0Jt3PYwR2KpGlN0DkmQz8n38yBxgAvXJYh5S0jZgj2G2bDhK+M
14gQ75QzCy2KOYZz8ox5dewgRFzX+L4E6XED5yEQRJYm34z95l8jgY1dzX9cwBSW
VxJAEqcDcZfWzYJAjzy9M5J732fGMA==
=ArCL
-----END PGP SIGNATURE-----

--7fFVVzleNYsfsZmBUWx22hv7nsInY4xMm--

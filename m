Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5AE16B5F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 00:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgBXXoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 18:44:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:55405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgBXXoX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 18:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582587857;
        bh=uLXe9+miy5P2pZ8Dykfs91dCcObCxsy7CRPIkn0ivhA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kOCIMSABE5ac2O0J5bb6kp6RZyrhgCHNbHn3dfWw0OrRSZXEWCXGaOjJNwUrRWYC2
         V9/MgT9Z3rWw5bi6xivUQBqKzd5AYFWKg3DlNdcQPYVB7vBuQquKfY+6UKNMjK2Crf
         o5ZuiFMA/h4odQz/ZvWmsv3gIE+aq0AgkDzwWOp0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvqW-1jf9eQ1o3C-00b3rX; Tue, 25
 Feb 2020 00:44:17 +0100
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: Remove the unnecesaary spin lock
 for qgroup_rescan_running|queued
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200207053821.25643-1-wqu@suse.com>
 <20200207053821.25643-3-wqu@suse.com> <20200224164541.GY2902@twin.jikos.cz>
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
Message-ID: <e797ac40-e5a2-b1a1-90f2-756c0b1fd67a@gmx.com>
Date:   Tue, 25 Feb 2020 07:44:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224164541.GY2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ROSwosdnYXooRgOKhYWBlvaZ4PdHGRB4v"
X-Provags-ID: V03:K1:V1N3VSqcX9ImAhDmueIAHuiWt5oWnYQxBsMbF3vgu1RJzmXXN6X
 Xb7hedYyIX89cM3FYAFM9p/cJB8N96lIvlaedSFfgZVb1gJuXtV76KPk43WtZjhsddLaqSt
 hyj3e0wJuzTLvOwVq2HBcjxqaLL+vAYGeTxkAIa6/CEyZqzaINnCMXZlZ+piAMY+v0EsyCK
 wXIzLNUAh4pIr0JlR3STg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7kYLE4FSEVs=:ymyK4yWB/XG38R0WKCvT9H
 MN4s6Pro+g3Lo8Cc2anNlYjpW4LaZY/9gBZjgqHgCaj5BIuYCqjYq6o3RO0jlQxWOaKZIcpRW
 mY9B9k0RFEnluVfqxNoZZARd+AnxmmulvnSolyt6cAeiRryOwgCjpY9uhsMdNEKZffPk9q0YJ
 gxxpYLzVDywVligvAFv/uPSCRhNv4c0FIaS0iqZNSJGxwSokwk/hiB3RqzweF9CLTJCjkqGi8
 suIbcpAqBm3GFNKwFv93yPXPX8/e02+OMxUZaOFkW2iDuHUwc6PICs2wJibXbCH2qdsJCwvLt
 GHWKJlIbUhs+YH97W9uZJq4Z3+DDt0qJ4GGihzFk6uKMlfaedbz/Q1zK7TZ00OYD9gc0PjPKE
 Vgd2ESaoQiUdnj3l7AVDnj639gUZDSdT7ZnZsS9WOVCWTRlh/jwnx0DUaxrrkbIG8nrv0dL9x
 WOfpJ+ollxnCQJYMuOJZRJ0MTJL9o09n8x9NX+sRAS7k/88XaWu78sX9OKzvhm9D8nOM6DZno
 VvkaPjDXb1rYH3sdRDxKBw2OUYcToZjk9PPI7UOk6UE/plrQOilLphME2Wpsp1GbCtmUyob9e
 Msi9Io0gybqpK8vhKclDqqX94cGru+aLB0jcEgx+yKdh6WreEWnTlF5/bETo8IhNxBcS/9K8+
 C7194lgrgjgCQm83O8hyTfwkvJ4vAPVk9h20rUJa1iW0jAc1ejSj5LnlwZrgxwIG1VtPXBchL
 kHkOEDO0xncvpfb098dZE9D9bzD3FV8Lxwdv6JCk/RmwgC6nTHPmDYLOLEdR8COFmg4WVi/Bf
 gm49Qxy4vzgULJlpQsoRhVSoDJnidxEFmHBxtZJ5ITTaDWCEui/WqaC2m84WHSXrZgZXdBjQ2
 QBDcA+afFxZziQm0aflf5nTrxUvZM8JeNb+9vhHfjyKUKphAh5u9eQIQjBjm5ycCy0oyu9J60
 b8tcrdByH2HrdpOaENZbO+ohxOyZq7SCnCfN1G6QVsCyK6ivngQp5b7lVy7a9I7dpoywSf/xO
 c76Fp7hpdxMYE7MqWBzFFsYy+0LTs4l/ILQzPdc6Wl4d2Nx7HvoFdF+fGJsLJDiMpM1xu3vNz
 a1AI7jM0dT99ACQ9+QZgSuDAHUhV8bY59T+KDeRxIt7VWqfE4RLsXCZhJx0nJOXtGdlBLeipK
 13vQgu5+VKvemMNvt/tOLaYe7NGYyucTEs6LIvDl6Rk34LEqN3RqSOuXv68hduX3h+z/6OUXE
 r1LqiAng+ygXsIarK
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ROSwosdnYXooRgOKhYWBlvaZ4PdHGRB4v
Content-Type: multipart/mixed; boundary="Adnk9n5Pj1XunbIh9WTjtd83RPTPIKPYj"

--Adnk9n5Pj1XunbIh9WTjtd83RPTPIKPYj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/25 =E4=B8=8A=E5=8D=8812:45, David Sterba wrote:
> On Fri, Feb 07, 2020 at 01:38:21PM +0800, Qu Wenruo wrote:
>> Those two members are all protected by
>> btrfs_fs_info::qgroup_rescan_lock, thus no need for the extra spinlock=
=2E
>=20
> Two members refers to btrfs_fs_info::qgroup_rescan_lock and what else?
> Byt the subject it's something 'queued' but I can't find what it's
> referring to.
>=20
My bad, with the latest version, there is only qgroup_rescan_running, no
qgroup_rescan_queued.

Just one member now.

Do I need to resend the patch with commit message updated?

Thanks,
Qu


--Adnk9n5Pj1XunbIh9WTjtd83RPTPIKPYj--

--ROSwosdnYXooRgOKhYWBlvaZ4PdHGRB4v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5UX8wACgkQwj2R86El
/qh9mAf/U1VUpBd8xKtGX9UZmMQ8Fh+TlVvQsg2xJdgk+YmXcFw3A/1zjb3qGzpI
FubD1Y7DI6u1ZxgkpAVmRb22m1h8M7HacYzr4SSTkUzgd6Urcc/Rjb54rJCddWuv
WNz5yhfCHhgfqBc8v04PCArXMtT29Il4q/2EpG949demnC69vkA79NQU7eydzIMI
tqhaqZTSI3zV0oUaHPAFTH1tsNk81gSkNhL5kZlo4CQ5hGojJuBH8oxTlb4wl7Q7
hiGfkQV9JGHZQyIB3e1G0FFeRE8HQQDUFAkZUwzVW6gelS9/JJ/aX1YraI1hMINU
0syKVgugtbd6sNbdtSwe/kUh6BLBmg==
=RjfZ
-----END PGP SIGNATURE-----

--ROSwosdnYXooRgOKhYWBlvaZ4PdHGRB4v--

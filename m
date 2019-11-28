Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6463B10C8C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 13:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK1Mlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 07:41:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:50005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1Mlo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 07:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574944797;
        bh=uO6/jtpMeI5jUMkD82p0OdQAGS5zJXXW8OEuZXfoiLI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=STuqT2o7yvyi7SXo/C0B8GDV0f4Ied6ZqaZKE9TnUCCmTncpmblSYQWgjuoupL3M9
         Dqu2zw8hrErvRK/0ZCHubss9/9JhWZbk1cplxAZZkS+HwgZQJqQscIHuzaf6VXHl/R
         3n8cjRNz8XB60v8rDPXDXflP5rtgj0488+yrytb8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUnK-1hikzm1HV4-00rU57; Thu, 28
 Nov 2019 13:39:57 +0100
Subject: Re: [PATCH] btrfs-progs: qgroup: Check for ENOTCONN error on
 create/assign/limit
To:     dsterba@suse.cz,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20191127034851.13482-1-marcos.souza.org@gmail.com>
 <0d82cb5f-9d01-0e3a-26bb-33019d8a9e65@gmx.com>
 <20191128110848.GD2734@twin.jikos.cz>
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
Message-ID: <aa74dd52-352a-4102-da5b-75855266a1be@gmx.com>
Date:   Thu, 28 Nov 2019 20:39:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191128110848.GD2734@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y7QXVLEePgoEgm15u3clFHcGscxBuPsp7"
X-Provags-ID: V03:K1:Pm9c3NAt12/XUosVdaWTw4rJFQ0kzDh4JZ93Q6oJmZV+mgIb+9G
 Gbrq6UrBbJZ8Boz45g2yYFclmmpOAX6/0nXI9pak/PPx6HqJvYFxBj++488PCZWd9yR/WWy
 /QgnJCl8qATtJqvAa2/mBHH4v6OfjSJ2toZLIVuQ3wkldfYkTW2zT2zHumtwzILW9AM+Iv0
 bkLHd6P+iyJxUrktqt+nA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UwXb5zm5FRk=:tJu6vyQW2wR93KfX3Jy2ac
 4K1FYOs/bv3jwg00GEpgQbohouhmGRp2kwwdssaC1/9H2NnigGwZ88HsTneno12Bw/9idDH/Z
 Oqi5cKS/WhyuzCcjGnyg0hB1rrzrQEcdOXKr0BldMnzu23XrHLtdMbCLyVq3bhFwogwLc7Uc3
 odWEK3ow8QHLMqdltJrDva5BTzs21h+EdEy9A8/NKdb82GFPMGCMefabLL4P/Ji8O1yN22cmE
 87eSjMbwAmdHI2A2L0B48YQw9q7k0dzDJWtDWIbXMoxnJ/m02ETMN0laI0nVDcU3KWicCC/sg
 F1ycQFbOffwbFJ+7Hv2M61lkYzHSTxqt2dbBTeii2lp1w0UIIShwFgK7CPGX3Kjb8WaZxScQW
 tb/hlotJEZ+XsjJQqWvr4PU6Nwr5IZ1hJN76hbMOL26mhdWOEafvxTFRIdkeFlZ0Pw04pvxvh
 60a4p1DC2Q+JjuBzzkPUC1GACUOBFMSVWQ1nxrPE/WLS4zHNYGA31LvSXphoYHMFaxiyQFHQ6
 w1j1CH+ixNYpmTmz2DHDTnVn25Z0ZEag56irs5zRrvVBoxRjPwO50D8ZJ7QFJTZ3ijf7OUTH0
 Ggt/XND+MY/QVZhp6Tk83UqZU7jFcedE6laO2QalNAXVKeBffXANhZOi4ntTPAl5KSGTinVuC
 EjqYQsD1AmE48NqiSkFMPdydg1c6WpHaLu8xiZSmTHtxSjvyyEx0cpMcR4848IsbKJHZpWZf3
 1C4xqFCtj8O+eTGNVfsAm1PNMGu2Wyjgh3uuV+z6EJkwFkWo3xGSJvgb3L7tj5fGt600En1Rt
 +610izzgqxSiEVI3sfYRfl4RBi8rR0erPH/87VN61kASWz16m4Mzkp7THHTGXy3b61rb2dosA
 oqZCzhjS2BHfEftpyOqXcmlr3YpOwoS1lMclqzNyJIaY87cCXFmeEExJzsuYuo63aSVSkfPk1
 wjXuRC5QJnTFdq9koODzwS2FoClLeKmOlGUEu7vEMgbOIdfL83EdwRMRcAofbXP6VBiIzh8rp
 +KyyzFOcqouVihEl5DORMdQWojKMLTiNGWaezetw72V2SpYv9bxeqkhUvkMMsWCErztcGShfn
 VVO64XnvhTcIVHtj4aLWP2zM8yzx7BvlJ/wnwPpfqsGpCoe7eSChEfBemmBPD1H1QBrwBLIfp
 niSgM4xraMKEsnMKpcXGXdQq1jPyd1cg5Ei/Lwqi3Wj72BTjEGj0Brusiv95ffLTgrddCzrA5
 ZdLPEK8FPBf7Vq/vliUuVRbxWwlZhq2U3rbgZrE/0IzPTOzYJIBz1BY36O3Y=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y7QXVLEePgoEgm15u3clFHcGscxBuPsp7
Content-Type: multipart/mixed; boundary="pNjSal4sY9uwQ9Yx9Afz07MAljtlBDkYx"

--pNjSal4sY9uwQ9Yx9Afz07MAljtlBDkYx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/28 =E4=B8=8B=E5=8D=887:08, David Sterba wrote:
> On Wed, Nov 27, 2019 at 12:30:38PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/11/27 =E4=B8=8A=E5=8D=8811:48, Marcos Paulo de Souza wrote:
>>> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>>>
>>> Current btrfs code returns ENOTCONN when the user tries to create a
>>> qgroup on a subvolume without quota enabled. In order to present a
>>> meaningful message to the user, we now handle ENOTCONN showing
>>> the message "quota not enabled".
>>>
>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>
>> Don't forget the original -EINVAL.
>>
>> So it needs to cover both -EINVAL (for older kernel) and -ENOTCONN (fo=
r
>> newer kernel).
>=20
> I think for now only ENOTCONN should be interpreted as 'quotas not
> enabled' as we can be sure it's just that. But EINVAL means 'invalid
> parameter' and this can be interpreted in that context as if the qgroup=

> ids are wrong etc.
>

Ah, makes sense.
So no need for a new version.
Reviewed-by: Qu Wenruo <wqu@suse.com>


--pNjSal4sY9uwQ9Yx9Afz07MAljtlBDkYx--

--Y7QXVLEePgoEgm15u3clFHcGscxBuPsp7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3fwBcACgkQwj2R86El
/qix7wf/aarKlo5ZN75h7c/K54whqV1USK8mRSjILh0qjheGt5cTwfamXIRNQK4i
yBOe20xcu5Gx9rsYlDHbP6WGgm0HAjikhRYD+BHkzsqXQ5Hvd8Ipy4essn42eleN
bb3a+9VXNSaOjFLQDN71J7azdpzCaOkTvkHOCN67hRamn5cVIAtSTMNXEsBfgeNw
eoM9XS22GpBGQe7YyILKoxl6U5hDbukpjvtzM1JyqsZJwdHI0HjuK1Upj5i7H+7N
V/tJQ0JZ92nWSxz+Q44UcgSdUTiI/IT45JvV/ds6nonrYurEMJu7yLa8PS8rSLsK
zz3b0X7W4CUCMqK1wExE5+ZuXXKYoQ==
=Yi+E
-----END PGP SIGNATURE-----

--Y7QXVLEePgoEgm15u3clFHcGscxBuPsp7--

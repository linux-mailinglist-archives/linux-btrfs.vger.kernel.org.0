Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D4515CF10
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 01:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgBNAeB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 19:34:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:37843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBNAeB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 19:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581640434;
        bh=ctXtAmjNT9IHSPWwaQ8BmvfkRRJhNshYPJQVxoMT+ns=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=A1drdmZVbHUZIcq/lQuCIeYQPSX1goPr94rDJ/P0P4VkaLx2IPkh0wEA5KVXylZHA
         wLGPJ/ITPaFcnvnoQVDhh7WoYvLRTGi0NE+u/Un+Yx7y2sClSVGIyte6LoBiJM4UPh
         XdZfTZA7L4DvjbzIvGepqDmgOH00YlEdVwyvgOPQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1ijMbn0eqD-00J3XN; Fri, 14
 Feb 2020 01:33:54 +0100
Subject: Re: [PATCH v2 4/4] btrfs: relocation: Work around dead relocation
 stage loop
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200211053729.20807-1-wqu@suse.com>
 <20200211053729.20807-5-wqu@suse.com>
 <75628279-595e-2ab7-b808-18ce0251f5b0@toxicpanda.com>
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
Message-ID: <0e5ed1d7-1ed7-3a48-6620-548bf35ff773@gmx.com>
Date:   Fri, 14 Feb 2020 08:33:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <75628279-595e-2ab7-b808-18ce0251f5b0@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZK23ltztw7lE5uwXw21g9CYREThgElUjQ"
X-Provags-ID: V03:K1:qfJhrMc2ydMtxndGRFS+HiH7lJCvP3Oe70DblJBUecuCISGhBAI
 KXCSA8Ss+L0G4QyehQVtWKhIdaKPjQFgefUm2yGmE4Z7SB2Hx9KI7TzmnIdxLYtAZJ90Xwd
 4HODBxoZD3/K6C9tTg3B5DtjsZSNN94jm8bV5zS5MHNZyl8e/6bmJcElH8WcyY3BezAR2cD
 p/UVMVBFZzapMPGX4uvpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K0+EyKUmWDc=:RRDFBs/7WFTovDCpaI8k8e
 PX6atAzSgFOAlmnjCMAO7CmpB+HWNtUwItPMIexYJi4Jx2lakKcYa3/QyePwYFE4tmYTMZnOf
 oYhgPgE35sq1YwUe9dMC0kgwwNb+AG7JKDx7X3DQAUr38bgZAU6iRQklQi67cdECyVEjfY0H1
 wwQwJHD6YUjALLNa4yeewqE9lvQ9lIvGbet0v0XhulqwIgnUn3ZLDTv7+XG6JyiD0bvSrGEPF
 nbtTeAvUIp5VtpiytcziB14qKpbbeQu4OqWsBvCjnZo2cWSdM7VxYNeQNmotOsb0Bj8dTu8pd
 Ie8SWe9WK8BGKJmhoayUMcaQwzOt7fkcMKCm2VcjgWW2pgPp8ey/f+nYAVW4BLRTYapdX029S
 kQIui1aj1y7vRbgHgc3W9Jow+GA7hnXBHmVuF/EUQRN0IlWbZhy2g4FMejcFDGiDxJIIh6ZOl
 /WGYzkGXIOGA3f3qt21oIEKQHpeotl+G5wSrCPc5ZIRs3IrMLwKno8a6s7MsPG3ZRhEp72HHD
 RCzDmpx19rV+prHkmwKaVGUC8fROEEFXVZddp8c1//eTXUKaed3/+2XYZCj1L/xf67iASE43r
 xojKx1evY282U45eUJ0MFS2w+hlKNmfXsy81vnolGe8ehLDxLbXBMJ+5usC3b3+6lLb1RoRA+
 3TPloJrpYVtT05x0QaMV9BE/v+nx90xfFiejc5PXG6mxt3SzCZn/Nt9z4DSFwOk2iNRaAFhsY
 nNok+1YAo/l8+WHc2hBxW2RVk+PjF74fkSP3c2sDmcMsEViXNYgwUs2M8VPc/3hrExSvLOz2T
 snGy+UvPFc4CJUDBRRz8CQPGoMREXpv3zkg9WGs2dAf2xeongVqFzy/F2zplhckEDwhVBEH3e
 /I2jj4f3/PbCTsCLCE+BjVPg726Fga8QSdOfnCkk6+HySQnmWRih8NWIKDOcaAjBFGL3litWk
 qRJS7bbEKF6I/2760R4l+Wo45Dh32wA7N4bvfVHJnzITV/QE11li+nW35iOoyBXokAYz87gAz
 nh8DXMjqOSwfLxcTQsJ1okZT31TnArvouyMq2hk5jnnc+iFI2UvuLSuFQeCflKVa4TGnplbIH
 bkCis0S/SOls73yf+qMnkz0qxyR+mHHYhq634g0LyzgV8Sd875G7+eUDdrWjE+08QBmis+SAz
 iuwQTgf0uaXSpZqPvv7WA7NRHxjSVcx8NgfoEeUOCoCY7va6/lKdvOFkxnq63/kmaUoS6e3oD
 Yz/le3i/tw+HN+ON0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZK23ltztw7lE5uwXw21g9CYREThgElUjQ
Content-Type: multipart/mixed; boundary="mzvB0AweGo0Ml0y2PqsWrAFy0CUT6kMkO"

--mzvB0AweGo0Ml0y2PqsWrAFy0CUT6kMkO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/14 =E4=B8=8A=E5=8D=884:08, Josef Bacik wrote:
> On 2/11/20 12:37 AM, Qu Wenruo wrote:
>> There are some reports of dead relocation stage loop, where dmesg is
>> flooded by "Found X extents".
>>
>> The root cause of it is still uncertain, but we can work around such b=
ug
>> by checking cancelling request so user can at least cancel such dead
>> loop.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>=20
> Why?=C2=A0 It'll get picked up by one of the other cancel checks right?=
=C2=A0 I'd
> rather know why things are going wrong than put something in for a just=

> in case scenario, especially since the other cancel points actually mak=
e
> sense and will accomplish the same goal.=C2=A0 Thanks,

Yes, you're right.

Please discard this one, as there aren't that many reports allowing us
to investigate it further.

Thanks,
Qu
>=20
> Josef


--mzvB0AweGo0Ml0y2PqsWrAFy0CUT6kMkO--

--ZK23ltztw7lE5uwXw21g9CYREThgElUjQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5F6u4ACgkQwj2R86El
/qgpJwgArR9zZayzxF9Bq0B/1nhx2Vb+4EkOdn61J1mGTuUC/ApY9kifa0XychvI
Y3UQEPkg8iu50+QbdR1VwJUaO2JkrOMdY/Wxopa1lm+lrkaeqaMUoVSq4+Syy/Ay
RyJtN0IaRf0OhOJhxY7IsY2ZJlxSfOz0eulGvCX6wotMRtkr2USgK7lL47tMxM5z
czmdK+UvKvs+bhsQFsx52hr0RDFIqF66YJEGmMv3lFa58NApZ4wBue2WBfxWR8aE
x9yo/+Tqq3/t0stlyPtvdcDIpzF5DaUT8ovrT3iaBwVOXfnsXwzMreDOgE+usKSr
7D3KslUCj8MnFIOC6PXsmJQ3vznFpw==
=hA9b
-----END PGP SIGNATURE-----

--ZK23ltztw7lE5uwXw21g9CYREThgElUjQ--

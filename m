Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C36D17873D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 01:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbgCDAw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 19:52:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:35035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgCDAw3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 19:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583283138;
        bh=k+yFoUI8fnaFQbEVpE4xF0LFQpAteDyP1Y68fs3J+Tc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jfoOCtOphjCF7tTTmxSZQzR3Et507GyRPxXng7NP4sQO06WdTWo/SHsYwckViOdly
         GtmjWlfo/1McEIMwQ2qg4uZka5ajpFTTrIxHH+0RynbGsNVUuGlBPenvX1VSkjU2oK
         jWoNTvIRxL9gJoc6vADDHVq2dOiAmQbf0jDQAVjw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC34h-1jF1qR09bJ-00CSif; Wed, 04
 Mar 2020 01:52:18 +0100
Subject: Re: [PATCH v2 01/10] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-2-wqu@suse.com> <20200303172523.GJ2902@twin.jikos.cz>
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
Message-ID: <06f55924-994d-a32a-c08f-319c01d4b14f@gmx.com>
Date:   Wed, 4 Mar 2020 08:52:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303172523.GJ2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E7eqnVXNAAt7aPfmUU1ZFP4g2jtsAdSLB"
X-Provags-ID: V03:K1:OcaWdAzX4SYN2vVO58VcZEbs/j1hQiRrv1tg0MHbYC1KTbzu7mX
 DszC0qVS0aRt8OlPhGg+AkY7cV/4rz2SZ5ln5JL/KiukBqMfK17BRhoOr25Dn19uJdyv8ap
 rtAho2VucXkUeGFgahHmqYvYrGP1IhRxqHCOaPXogQ3qOMNnbRd+wyE+hx0ZU7OWcrdQVao
 dYJm9qusJBr4iRdVUjo5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M4ERg1MKSZY=:N4hLm34c8IgWO/2DPPlc+n
 uoCfbAK36buvUh3bdXEInuPHl061GLC82eMvN5u4uxtp9s6lg57zQOk+qbF6qQuEEE8Ey4C2K
 duk9rkDxulTakYF3zQi8rXBwGeANfOd4AxEJXqQ+rnF/lZXI+My52OyimXwcutevme/jKLSQh
 NGQWEKXl/YnzZUcny48sTaJXOdAAta40yvPYY4kkj191T5If4z8s5vdoFpKX8RWqvivMPOxSU
 fsMxpi/wAfhIlZMtomiqVrChm97rXLzDYk2mZ/9isZAZ9XMWLU+aRPQYq04XVevOKD7Lw9Wie
 pGxYwBgnH0rrw5G3corrmfZilCXWAzGWzQzrqcQA5iSTCTSRF80a4E70p1WFwfoQR/mmi3Gie
 IJJoAKFXcYiDWC/ZtfnoFic5mx2CaiDBrsoPo3LlLMnn5pzIoNeXHpsgDqHHYE1vsY0b7yfN7
 /8cgISUf1j7jYbn4JaNq26xGa3zX5cYkYpJJvkvrMCIAOhqWSUDM3Y8W9XYD7kHnROirV+bFA
 hvk33FhqIoW8cwjtsYymAdfwy8zggmG6WElodRK8R4hk1+hdNSqnVtTzRr8LkWtAovfgccUiI
 yAPJIii8Lr7oiJCt5r5HEgfryZk41UrbOu+4ZUjSLAMPnVh6dgxc8OUbVJbfP0+Kl8wqGvEwd
 Pcvbzmjg4iDfJgO/3YasVNEsxeRtoXNlKd3jX0hvb6CqjoZ3YMmrRPjM5gNOMlUV4qesX7iEJ
 B89oyn4e3UFHWMJxqUPtx/t4q0oqXhpcoK2I28v9fqqOF4FXjzvRQR6adB3n+73dfl+ELcBSY
 nBZe/UasZ01aOuAIHqwrIOwUGOP0bOTYxkEWoQHQebW+n5x1LhXuf3cqBHSDzv7BlRYUg1CMp
 Ot7VMWQXgomfZEJ8lQS2hKdM/6dSS/51s8t7S1Ez8Veq/bU59Ou0Q4eegXrAKSpcwqerApyNH
 +ECTXvtNEO5lEylTELqCrMJh2zBxu2Ns5snVhojHSigXs0RJEC44cSQmX5SZ3R8wm3ROHw/9I
 hGm3lvAwPYK7u0zPPGZOcmPA0bZU6khpMJ3UxmbcHzuMlgkrkpp7xM9ftSWEJfhgQjbyKAFgi
 lyFZZX3YAFuqijGc1AJqMCXTXxcqOAHIbyy2+XbgA+lpyeBvrGpJLmnVD4eAFLKH1+aReGxnJ
 +lnO5QA5t2vuN3d7ew3ouUYPT22anu6KsemxE7MFT8Jl208XWqjn3lpQiV0nJe0NAQOPnzQMF
 gkllrntKXQvlT7WhH
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E7eqnVXNAAt7aPfmUU1ZFP4g2jtsAdSLB
Content-Type: multipart/mixed; boundary="LE4ujH1k9kv4hSWBBs1ymavfr04hztpox"

--LE4ujH1k9kv4hSWBBs1ymavfr04hztpox
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/4 =E4=B8=8A=E5=8D=881:25, David Sterba wrote:
> On Mon, Mar 02, 2020 at 05:45:44PM +0800, Qu Wenruo wrote:
>> +struct btrfs_backref_iter {
>> +	u64 bytenr;
>> +	struct btrfs_path *path;
>> +	struct btrfs_fs_info *fs_info;
>> +	struct btrfs_key cur_key;
>=20
>> +	unsigned long item_ptr;
>> +	unsigned long cur_ptr;
>> +	unsigned long end_ptr;
>=20
> I think these can be u32, only processing the leaf data, this would sav=
e
> some stack space consumed by the iterators.
>=20

The only reason is we need to do force type convert, as it needs to be
converted to pointer.

But since it's all used inside backref iter functions, it shouldn't
cause much trouble for callers.

So I'll update it to u32 in next version.

Thanks,
Qu


--LE4ujH1k9kv4hSWBBs1ymavfr04hztpox--

--E7eqnVXNAAt7aPfmUU1ZFP4g2jtsAdSLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5e+70ACgkQwj2R86El
/qj5eAf/WWzn94xsvK623wDRKVREI50VoqNVNZ7iaBSDlzeZKMN6zqYVNI5lVnpu
2td0o0YhDsHlMCFquiaoZOYdc6VYheDHAUdk0KRuWbVoASoXl/f8ucPFmmDzF6RJ
pWhNE6ud48X9bjCehxy/SWnEv4XfN4KofxAnbnHWSDuzIMJ6nscBzzeZUy/KSbpH
P/GAIJQRqLNTSswda7sDfkymDCEjua8fPLUN9dXv6W7Ja5hCHp9UyYlgPYDirHQY
WmeKcjeqnedVQKznlwrkR4FlDaenMOikExYSAWgfh1jzb5BwZ4iRuEktQ/69H2Iu
fsVthJLRsRnpoUaSFT37rotC6i7OzA==
=INVu
-----END PGP SIGNATURE-----

--E7eqnVXNAAt7aPfmUU1ZFP4g2jtsAdSLB--

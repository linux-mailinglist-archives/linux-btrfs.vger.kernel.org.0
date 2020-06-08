Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66721F159B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgFHJkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 05:40:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:48777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbgFHJkM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 05:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591609202;
        bh=4izXd3f13y8zmEGnnuaSTYWlmPodQjQ6paYVhGT1i1c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PzgnHGJVWqAe67ZarF/ZCpxUq+LhRDxOJzQdNxxwLNEN1SgS/PQjIjVavfn8HK9AA
         TgYUC+ukW007tJlaxIIT1BN5jpM2eq06XJURa1DsmpiCcTP9XzSBfwMLKiQC3L7lhE
         OtyhZWV+vW4SGQnMm9NmxHbNsnXbPtnjpvu+7pS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwfWa-1ikVrc0kPK-00y7Eq; Mon, 08
 Jun 2020 11:40:02 +0200
Subject: Re: [PATCH v7 1/2] btrfs: Introduce "rescue=" mount option
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200604071807.61345-1-wqu@suse.com>
 <20200604071807.61345-2-wqu@suse.com>
 <3659322f-0687-d179-ff89-f3a303fe2379@oracle.com>
 <20200605113638.GB27795@twin.jikos.cz>
 <006ff0d7-517f-e505-e8cd-529029e1e203@oracle.com>
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
Message-ID: <b6832877-a372-c307-f07f-0a205bee2dce@gmx.com>
Date:   Mon, 8 Jun 2020 17:39:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <006ff0d7-517f-e505-e8cd-529029e1e203@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NkPQtwJTcZpcBXNTxS3BCaGd1JwmiCav3"
X-Provags-ID: V03:K1:Xkvo9EdMiWiM5nDoXtmQmrNpkQU06BIaaFHETgxxw6OK7guGuSO
 byDSTpny3OsPH+kGOUXoPiKzY9LI1Q+3QLw2J3gilAjpH+l1v+4+ScYvsv9Tobi9PHvu2oD
 ZHjuzjOe4xg8m+KY0uIbzb0zMjLxKrGN07x8mftGVlf7xHtvKRxlrXszm8F04kh29S6zwDN
 8vXuqWQBoVO/+g6UfKP3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mkAVODrBYos=:3T6kVELCPXYZujH5Mbj3aw
 cBpqtZqpccBJigjZHJPXW9fLAH6QCBnNv0Sb4MeHBpXMpQQSsJR+8OihkcQx1/3nk5yS7kQby
 32mm7SdNIyXgLusfR9zXW5ErXdlSIqpCdOJ9M4jg2KCT9DUyA7xbgK9vBwR3Duw1R+NWA6+Oa
 vYWdWUMuzy82yKEpkrQVFF9e5mBnKAu4PJ95bYGFgW2oJWfKgxlmsxmVyBBDZw6eFy7rlGa3b
 3LYNQhyrcKkE/1YuFQ3IzSXIBf4BgMpsfGVPhbkEIXTZeSkTIz8E2OihiSY6M3tWCbrUq6vm0
 NVmxrAMrsUP6pVFE8wf77djavxbA6vNHyFNo8EsWb+q2gVP5NtjWGz1wfdckJFz54NHnG/ep3
 Q/qHEVzCSz7cAEpCKVXCC3t+oCGB5ypg6qLw1jsBLGz7KnwfgrO46FhRqtZ807lSNXGJCvw1j
 82q4Z8L8f4h7/27Tley5XxosTMe3ywLZvOUcdkbh/AotX4LNpJpDSnS1KuVZ02hYMUVQVmI1T
 v2UnJtd6K8s3+sTtfLHym36dxHXGJMKZ1DX61tAbUgxfH739Qvo+oTMkgGI4yzJxB3w0driEC
 tShtzDQBJQ3zsJtcy0Zd9I02/J0NcjK7OjrDZW2z2Zipgz0kKbgFONNG1L7kmeKOKXPR9azeA
 PrzKYiyMQ5FzykFUyuqWVPVgyjrjbDUp4OZ5mibLU3yEXQTeD1SdHDE//70oY6mjjntllcJpj
 DYkbksL9Dt0AW5XNvXSwli+MDvkx4RX0WXEU59Bs3mzC33Bl0tAbMhfjHgKSMHu2gtlUBSoE+
 kZ1aNrQ8N1JCqUk5W8LE0pA9sLYgTRBiekJ+BfxP1PI9VDDKxsLBBK9k2kVZ/e0Z3wk82BR5i
 Lct8wEuvgUMeadVUF33YcHzZclnW1fuKB40YJEepFURtUiNA9c0DE3jPsae69wFTapNsdpjgN
 op41BLYEW3kNVgFNzve0yRmjSF/Vkeu+yeBVx4cxxEVvuPDFj8x/trFnPqgQ9d+XEAi8FTJ4f
 7CYcr0j0ZiVkVt3HbsIb+I2CjaWoQl/o1bhEEjU7XN9h4D95/dgxajIIqFuAPg6zy6w2wravh
 20tG8KQbUq7sSQrOjCGrqAbgpJME3RgZuSbG6f1GPfTAu7LTt+J1zXp7ddbiBrCFUz7XnrizC
 VangjUrY4YMmohBx6rRXjU/c7djOVHLg17zsZGnwJTfMunG1G6GjyXromukelzOczOwVbHdC2
 puNh5nGQSD1uHXjrf
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NkPQtwJTcZpcBXNTxS3BCaGd1JwmiCav3
Content-Type: multipart/mixed; boundary="rrSXec6RYSWcXhNiaGtDF1fpDlcTLNZVq"

--rrSXec6RYSWcXhNiaGtDF1fpDlcTLNZVq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/8 =E4=B8=8B=E5=8D=884:11, Anand Jain wrote:
> On 5/6/20 7:36 pm, David Sterba wrote:
>> On Fri, Jun 05, 2020 at 06:04:01PM +0800, Anand Jain wrote:
>>> On 4/6/20 3:18 pm, Qu Wenruo wrote:
>>>> This patch introduces a new "rescue=3D" mount option group for all t=
hose
>>>> mount options for data recovery.
>>>>
>>>> Different rescue sub options are seperated by ':'. E.g
>>>> "ro,rescue=3Dnologreplay:usebackuproot".
>>>> (The original plan is to use ';', but ';' needs to be escaped/quoted=
,
>>>> or it will be interpreted by bash)
>>>
>>> =C2=A0=C2=A0 I fell ':' isn't suitable here.
>>
>> What do you suggest then?
>>
>=20
> There isn't any other choice, right? Probably that's the reason for
> -o device it is -o device=3Ddev1,device=3Ddev2 still remains separated?=

> IMO if there isn't a choice it is ok to leave them separate.
>=20
> But as I commented in the other thread instead of
> -o rescue=3Dskipbg:another1:another2 why not just -o rescue
> and mount thread shall skip the checks that fail and mount the
> fs in RO if possible.

That would make dependency complex. The skipbg already needs nologreplay
and RO, and usebackuproot sometimes doesn't work as expected (in fact,
that mount option has fewer success than we thought).

I don't want to spend too much code on a salvage mount option group.

Thanks,
Qu

> The dmesg -k must show the checks that
> were failed and had to skip to make the RO mount successful.
> So, that becomes clear about the errors which lead to the current RO
> mount, instead of going through the logs to figure out. This is a more
> user-friendly approach as there is one rescue option. But I am not
> sure if it is possible?
>=20
> Thanks, Anand
>=20
>=20
>>>> And obviously, user can specify rescue options one by one like:
>>>> "ro,rescue=3Dnologreplay,rescue=3Dusebackuproot"
>>>
>>> =C2=A0=C2=A0 This should suffice right?
>>
>> Setting the rescue=3D value separately should be supported, but requir=
ing
>> to write the option name for each value defeats the purpose to make it=

>> compact and user friendly.
>>
>=20


--rrSXec6RYSWcXhNiaGtDF1fpDlcTLNZVq--

--NkPQtwJTcZpcBXNTxS3BCaGd1JwmiCav3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7eB24ACgkQwj2R86El
/qgv4ggAhOUY4puQ2WySA8yk1UpxQna08dcfM6hjOxchMD2HihEIdZZbSSW9Vz4J
slcV1O5uLuJkq7fbjsS2B1TTZp1jXHf+7WRcPd57mT9WdzZbn1QCx7pYH/t9Mn+n
4AokGkGsSielHnF8ao9MqVkFuMElHXp7uyePKnxF/6GF//z/VNAQoDGDllj9pJvP
79CQGOSqU6w1bCvpnZBeecR2ko1CfU8WK/6qy4iLTdrT5iw//hHHSK1vWlcKJMYo
eqYDei/r+2pzDFerFECZd0IwPnK0dvhFKSYAWHHtNplokzevrQ6Ds+tDF0VNh3k3
96E7K9Q8wfzi76+UBBOZ8KrJY8tlBA==
=GZFC
-----END PGP SIGNATURE-----

--NkPQtwJTcZpcBXNTxS3BCaGd1JwmiCav3--

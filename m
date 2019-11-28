Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AFD10C8B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 13:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfK1Mco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 07:32:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:44057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1Mco (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 07:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574944163;
        bh=8oTIO1HXRvjdBEoNczZShr7X+1n3VkiuZQeiHR8pq1o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Z6Jfy8ScR3wrpgoUTLtUS5SpGbOQCoevsAzG3+s+WEf+ijOQVABI7s1hozd7nrJyf
         KJIhSVwsojtUkEGlbSt1IRllp/Q4QGsAUD/+BfYy8Au4tEkh7iL/9HdcnOW/kwg47l
         EBQYTzW+I+kTvsf7fNvpVPCsLkUx9/ti6pz4IP7w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0X8u-1hduwo3O6O-00wXKy; Thu, 28
 Nov 2019 13:29:23 +0100
Subject: Re: [PATCH 3/3] btrfs: volumes: Allocate degraded chunks if rw
 devices can't fullfil a chunk
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-4-wqu@suse.com>
 <6cc25dbd-55e4-43bb-7b95-86c62bee27c7@oracle.com>
 <f928122d-4e77-e83b-9a53-d2eea7ee16d3@gmx.com>
 <20191127192329.GA2734@twin.jikos.cz>
 <8c0a2816-1a7d-7d75-f591-c8712a85efd5@gmx.com>
 <20191128112449.GF2734@twin.jikos.cz>
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
Message-ID: <4cec03f9-513d-9b77-5967-93d7bddf55ba@gmx.com>
Date:   Thu, 28 Nov 2019 20:29:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191128112449.GF2734@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C7VZumAk9GXcinqWkktluUSdKKT9MRGSu"
X-Provags-ID: V03:K1:okKjoLHugC/1BMF/KoIwA/nmW/wqrVy5nWu91iCi3hT4qlaDV3N
 qK81mtlMBCAy6XVYRGaS8xttt00aV2OMvh8fT/eiRV24tBG4b/ygRoIbGOuo8HLnLz1IWql
 XR37uw16TEi+aaUUG/nWH7NFmxJHQx1yHxRh1r1Qe9hKMNMbfuN0dY6bFdYROEFatzM6eiL
 hwiK9MrHU8eJAiP9nxvkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rsICzGvlzI8=:JbUl6wD561UOmmMl8tqUdw
 LTFIIvTCLmv2V4sdngBo/rXm732kJpJ3HyeP29Wu9bRyFvNTGHiNWZs1BpOrR+h7KSkqin66l
 zJL9psNxW/uiVoXETVdpku4Ig5IQdMO496q/efpgyC/r/jLmbLlYHJL8ecRV57okbsEsHrY4A
 FfF4SDsJVnx3FkN5iFyJ5JdZhYpFG0pVNqQgtaTHe3HjPt4vgzpUocefH4IoFH1PNYdJklREc
 M6Pn+bVMsyx8LiGt+zAXC9NKlnv/fRKdH38c9upUHNvROQ1wboxdKKkgrmFdjp7qhEjJnOlS8
 7H88FgFi9qIv2WeAFk/wbFX4aScUBz1NwNNUEIllctHNchYPYUj/LAU0183+UOhtmK72i4wqk
 LLHRDgDNPt/ZjLMLXNHqNlRqax9OE/RvKbqS5gzNjSFRsRd8/ctO8PIIYq5St6hKhAt3TPO/n
 Mduw+D784MqOts4fd11roYqbzc/5LsDZsILl6W6yVBbyngIVlXTibYKKdxX9XcKkot+KjUMWG
 XFJ2BUuktmejC/gcgBOpPiv/op2YmpCyrZVqWxC4twnycwH863yuLqYSfZXRZTPmen5XfH+fr
 obHKlmIdBjqL4tO5IJq1d0eQSlEnbwR8CmWZtI0oMVfpRSTTE+H18OAwzhgHCFmYmB00PELjH
 rhTXRn333fKGo0PQzMD7GYrFetajXBxdIofmgJ2qeoypHe49FWEcqQAAHumOHQ9J0fG7Wxk9H
 rV1Fkip9mwd2akB3nTHACUBomqvAoRQIXHXRrEijkpOugmcVDXD/vELVWWChS8PhCuqRCRnFq
 1hDyezGxGi5MRl1NZGbnDCvSW/hk1RIbHks6Dupoz89UAeF17B1nPfibxmvDGo2EewL2lb7Ci
 iGm/FZHLfFtwM9wLHGMrxDKR/OKKlOYA+N3gi1OZRQsPpqjgAuYsOvu3NRDztRxk1z3+5kWsm
 yQnNXCnuaSnNDRfLvc1vko7Uj+8KpuZe20HTV6QRbqbAqiMrRZ4GPHItpDNTsFuWLTzNaFGO4
 CAHtxCLeIZV+xFwm3dbZW1KtsfkLphFrFd0ch1fRX8z2bxniouG+TX7Vcf2NOyZyKXD2k/vAY
 D42NbwgcMw7fES4f6ajvkQOOS6tFscsy0r4betmRirq+dGYZnlx8jHOufN38TSa01enmY0DfP
 g+QaccJGKJTe4hxYeRMCd4gec1GdRWcpQ/1bN01ub5LM7ClxhGqR54WQUmn+AgnbC1ja86Sbj
 nSKWPLU3Ys5ic0CFK2mD5ScOQ2MMSxdtEVdsLGqLWoFjXRMUWinpOtiD8SgE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C7VZumAk9GXcinqWkktluUSdKKT9MRGSu
Content-Type: multipart/mixed; boundary="B8SNqhDtMC07sihyfMXs2mVH0w2LclKpV"

--B8SNqhDtMC07sihyfMXs2mVH0w2LclKpV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/28 =E4=B8=8B=E5=8D=887:24, David Sterba wrote:
> On Thu, Nov 28, 2019 at 07:36:41AM +0800, Qu Wenruo wrote:
>> On 2019/11/28 =E4=B8=8A=E5=8D=883:23, David Sterba wrote:
>>> On Tue, Nov 19, 2019 at 06:41:49PM +0800, Qu Wenruo wrote:
>>>> On 2019/11/19 =E4=B8=8B=E5=8D=886:05, Anand Jain wrote:
>>>>> On 11/7/19 2:27 PM, Qu Wenruo wrote:
>>>>>> [PROBLEM]
>>>>>> Btrfs degraded mount will fallback to SINGLE profile if there are =
not
>>>>>> enough devices:
>>>>>
>>>>> =C2=A0Its better to keep it like this for now until there is a fix =
for the
>>>>> =C2=A0write hole. Otherwise hitting the write hole bug in case of d=
egraded
>>>>> =C2=A0raid1 will be more prevalent.
>>>>
>>>> Write hole should be a problem for RAID5/6, not the degraded chunk
>>>> feature itself.
>>>>
>>>> Furthermore, this design will try to avoid allocating chunks using
>>>> missing devices.
>>>> So even for 3 devices RAID5, new chunks will be allocated by using
>>>> existing devices (2 devices RAID5), so no new write hole is introduc=
ed.
>>>
>>> That this would allow a 2 device raid5 (from expected 3) is similar t=
o
>>> the reduced chunks, but now hidden because we don't have a detailed
>>> report for stripes on devices. And rebalance would be needed to make
>>> sure that's the filesystem is again 3 devices (and 1 device lost
>>> tolerant).
>>>
>>> This is different to the 1 device missing for raid1, where scrub can
>>> fix that (expected), but the balance is IMHO not.
>>>
>>> I'd suggest to allow allocation from missing devices only from the
>>> profiles with redundancy. For now.
>>
>> But RAID5 itself supports 2 devices, right?
>> And even 2 devices RAID5 can still tolerant 1 missing device.
>=20
>> The tolerance hasn't changed in that case, just unbalanced disk usage =
then.
>=20
> Ah right, the constraints are still fine. That the usage is unbalanced
> is something I'd still consider a problem because it's silently changin=
g
> the layout from the one that was set by user.

Then it's the trade off between:
- Completely the same layout
- Just tolerance

I'd say, even without missing device, btrfs by its nature, it can't
ensure all chunks are allocated using the same device layout.

E.g. 4 disk raid5, 1T + 2T + 2T + 2T.
There will be a point where btrfs can only go 3 disks RAID5 other than 4.=


>=20
> As there are two conflicting ways to continue from the missing device s=
tate:
>=20
> - try to use remaining devices to allow writes but change the layout
> - don't allow writes, let user/admin sort it out
>=20
> I'd rather have more time to understand the implications and try to
> experiment with that.

Sure, no problem.

Thanks,
Qu


--B8SNqhDtMC07sihyfMXs2mVH0w2LclKpV--

--C7VZumAk9GXcinqWkktluUSdKKT9MRGSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3fvZ4ACgkQwj2R86El
/qhlLwf/TEzEDZiXKNONO+LzMzXLEiQmPFzX5S52Im5PWJyQwcsom1GsL+UtiT5Y
qNa2Hlozw/duK/XC3W3S+ds61fpzaxQvg4eiKMwj7OICh7iVkuJepAF22qf3sD9M
5k14LsE903SX8o0LMDBD59Z/BCPlpkrBkHhSIr+FXj+rleTFcV4V51f9PpfUJIp6
s/vmvxdHAOL8voLNUB+az5f7qptzEisVYEDcFhy7SB59cJIo4EtlFcBqHXYjpELA
v7rMnfHpOaYhtZdUaXfxK0E1Lg8V9ojhkimIbzuJx/eSgWLM1f2DC642NH5jXQ9J
HTHHbx13mpvTgu3abntAkhrTnBKpJw==
=K4qA
-----END PGP SIGNATURE-----

--C7VZumAk9GXcinqWkktluUSdKKT9MRGSu--

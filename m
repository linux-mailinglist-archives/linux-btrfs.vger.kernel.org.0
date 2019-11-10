Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA56F67D3
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 07:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfKJGzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 01:55:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:35927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfKJGzO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 01:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573368900;
        bh=vMiKpHgcgSJXyPp0+ack1MOBp62dTrGp1goRu7q8vzM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cAcbIQBT8Ue3Q7baMeqZ49DAsPshMdR0wtDVPA1hLowJhMRsb1jTVFU+hGWGbUaAO
         YpriacNbvr6k26vtej87IUMvQ8rUOUEf7b4UGcqSGFa3T/lqSiDy8qTBeiIOPPlFlA
         Q1CWbKDcJdDGB001rFhWZAAgOZp0EM860vUD9kVw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mt79P-1helQo233J-00tQxp; Sun, 10
 Nov 2019 07:55:00 +0100
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
To:     Timothy Pearson <tpearson@raptorengineering.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com>
 <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com>
 <1848426246.125326.1573368477888.JavaMail.zimbra@raptorengineeringinc.com>
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
Message-ID: <64be1293-5845-4054-8d5f-b9ff79168a17@gmx.com>
Date:   Sun, 10 Nov 2019 14:54:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1848426246.125326.1573368477888.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xuk1AR0y1I4INGWMIYzQ3qfglFSyTPBpT"
X-Provags-ID: V03:K1:rjZDQdLNsBnPcvxN0F05kAg1LLxs+rcoMXfI68mRdI1NxaIapaW
 3U/SS/nwegr3PpgrbrA1oDmH4ms0e4VdKAVQG63JgrQ/moJRunNt+slHmvufwSOmJ1GA9gP
 iuU6lTlJVUGWyHhy0MKDie1ulPu9vu6hHjOrbYgTneJEnNb7GE7NvLwfJo0GZ4NNf7NBPOO
 k9Ebn9WQXpL58J8QQDDmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lnEAVuC2r18=:t4tGDi7Lkqvu1BSQhUVZEl
 FsrOl8aYxpUCMNCbckvF72K+F08oepKK41zaOWPX/kXUIFS00aA9PntRv/UHxilzvEJI04GBs
 YAXrel39UklrsvERmM/pekPrOjfEAk5+wW96e06bKZBkvX/AI/rC1JPuUqCmOBm6PJwy5D+eH
 y7DVBX8r+DE/LQf2zKShtzNxAg22zE4lhmaPna4Z+6GCFZHo292AKt4aB3yZUjRb3uho/k5D1
 pbTZD3xe7KAm/yAWZdhnV2R/tK3ekjuE8lWcwomuLma8pPp2H7FSVqWtB2FJHcJAHYjQMcA6K
 1P3icAaH3l6ZpVoNEFByw0nhDxLH7/VD9/Fq8V6bGqIqYaVebDMtINZr2Fz4nqhgsj9RKLhHz
 c29f7GyXFeSubGaIClGhy5qwHeOdBSRYQwZ2BP0afsR/bb8vlMI0BqlXeV873fZXIMPlboMdg
 VciLahcqsH2QCQm19Qb/2q2cpKMybOriYpifKcLWzJF6ols+ziEVWiGvCXJGKPLoJZU+XslcL
 MnZqV3G+43sI6e/e0Wmz+gcFOxCH4Ta5jKsjsZMs6srqC6JDwOGIHrt+Hn6NKLiPowtJzLVrn
 RKAGHrFNEMruS5JKPd7wOAawzQ9Pb8QL55MAgdlQOjLGl/j54he1LPI7OCepdSKpY3wFCsHmQ
 z+tXrZ+1td3oZDJt69cPpJnIu1+7aJUC3RjaBfOp+FB2+jYy+GGMROSD5gbd9AEbKe/pedZLx
 iEFiZLRZS8u0syLh1bTS4vdBst+gujOj9A8PNF6YFtE36AV86yVIuVKyujtULqd0WFutdFME0
 6qkenZe4fzmoe7uFz2y3GsiY2c/3qOo5MvamFBcBz6harqJ3stgakx4/rGpnwHKb/TuUtBBhT
 zaJcsfAjlKR40ut5U6kqSMuseHNn/BODK2jeIkbagbO6IyvfR/eMn1BsyfuiDIgx+yZvIQSBY
 JX9L+r/uxufCvqi/f/uHjHrOh5FeJvqRpJB5iH8C3JAEWLq8s6I7zAIoM7kON5TaQ+WxUrb2l
 kRNk9l/deOXCebtuoUun4MbUN1ntDkFcTe6Y5Mrminqg8fY5WudLM8tZQuQ83xzE5DOrGyoLb
 XG3MahBR2TY044gbFQ2kor+RVKH5eJOiHbSllIQEMmtGdYRk7yRW6witTWJRJ+D5txIicCsFf
 TH4VTXv31ivpr2PA9kIyNDIkDcbuTZZ7eZhwYt0O3nOZ0y9s0eXJr5YrYSkKgiF8vDFcoFnsY
 DzdGIRfM8HKea8/ZdftCiKrXljaTyyVgmLGXvLdb60PSqOlF85Q46/F4NBqo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xuk1AR0y1I4INGWMIYzQ3qfglFSyTPBpT
Content-Type: multipart/mixed; boundary="yXYENZdQFX6mnTCNIHwvgkIdSqCdlpH5A"

--yXYENZdQFX6mnTCNIHwvgkIdSqCdlpH5A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/10 =E4=B8=8B=E5=8D=882:47, Timothy Pearson wrote:
>=20
>=20
> ----- Original Message -----
>> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linux-btrfs" =
<linux-btrfs@vger.kernel.org>
>> Sent: Saturday, November 9, 2019 9:38:21 PM
>> Subject: Re: Unusual crash -- data rolled back ~2 weeks?
>=20
>> On 2019/11/10 =E4=B8=8A=E5=8D=886:33, Timothy Pearson wrote:
>>> We just experienced a very unusual crash on a Linux 5.3 file server u=
sing NFS to
>>> serve a BTRFS filesystem.  NFS went into deadlock (D wait) with no ap=
parent
>>> underlying disk subsystem problems, and when the server was hard rebo=
oted to
>>> clear the D wait the BTRFS filesystem remounted itself in the state t=
hat it was
>>> in approximately two weeks earlier (!).
>>
>> This means during two weeks, the btrfs is not committed.
>=20
> Is there any hope of getting the data from that interval back via btrfs=
-recover or a similar tool, or does the lack of commit mean the data was =
stored in RAM only and is therefore gone after the server reboot?

If it's deadlock preventing new transaction to be committed, then no
metadata is even written back to disk, so no way to recover metadata.
Maybe you can find some data written, but without metadata it makes no
sense.

>=20
> If the latter, I'm somewhat surprised given the I/O load on the disk ar=
ray in question, but it would also offer a clue as to why it hard locked =
the filesystem eventually (presumably on memory exhaustion -- the server =
has something like 128GB of RAM, so it could go quite a while before hitt=
ing the physical RAM limits).
>=20
>>
>>>  There was also significant corruption of certain files (e.g. LDAP MD=
B and MySQL
>>>  InnoDB) noted -- we restored from backup for those files, but are co=
ncerned
>>>  about the status of the entire filesystem at this point.
>>
>> Btrfs check is needed to ensure no metadata corruption.
>>
>> Also, we need sysrq+w output to determine where we are deadlocking.
>> Otherwise, it's really hard to find any clue from the report.
>=20
> It would have been gathered if we'd known the filesystem was in this ba=
d state.  At the time, the priority was on restoring service and we had a=
ssumed NFS had just wedged itself (again).  It was only after reboot and =
remount that the damage slowly came to light.
>=20
> Do the described symptoms (what little we know of them at this point) l=
ine up with the issues fixed by https://patchwork.kernel.org/patch/111415=
59/ ?  Right now we're hoping that this particular issue was fixed by tha=
t series, but if not we might consider increasing backup frequency to nig=
htly for this particular array and seeing if it happens again.

That fix is already in v5.3, thus I don't think that's the case.

Thanks,
Qu

>=20
> Thanks!
>=20


--yXYENZdQFX6mnTCNIHwvgkIdSqCdlpH5A--

--Xuk1AR0y1I4INGWMIYzQ3qfglFSyTPBpT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3HtD8ACgkQwj2R86El
/qjnPgf+NGiijFr4vtqFmJctrjMml3NQ8xgOSiCNsu1YI4XLJACaFKitOwrBOo6+
Swfylt0llOffu1PSxNhJuBUE0hFV9QfBD8tnO/OOckEU2WY8YL+4AUl72Ym1P6ee
Gxkho25DLJpo9kcNZJdwASvC1rI7JE2IU+MxKatC/sC2kSKY93HaW4FnoGJhzt2z
ZcS3iqN8Qo/VjLPno4gZ6Zscm0lVZkwC4HGGzZ6QEcEUteoJCqVQ+0j98e5KchPc
9ChwbFobsqvxM3IYsT5ze1yD7yb0XFF2GI/swhsLRjXCIVe49BnNOouZw1MxqLC4
DzmfHmIp/5RWB+/NHJPmrwHIFbePhA==
=NnOI
-----END PGP SIGNATURE-----

--Xuk1AR0y1I4INGWMIYzQ3qfglFSyTPBpT--

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9ED18C459
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 01:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTAq0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 20:46:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:37309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCTAq0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 20:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584665182;
        bh=CfPKDtd4IxjuHHF0EznrrQrWz1rWXyABevI3Sl4et8o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=E21oXLEIb70Q+m8OFcmD5WgoC1Nt7CleeLIKgAFnGigxz8677VSHTTrTRnz5s4oae
         jrRWfUTL8BocASAli/3a6BzYy4ZC2iZ/YPgcvxXguKQqR61SSkyLb2dcGvzvcqfPfT
         Ca2gY3MGgX2PZhDZ9spOufd6Tgs9jFQkoF3YWQXA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsEn-1jWct02OIR-00syYF; Fri, 20
 Mar 2020 01:46:22 +0100
Subject: Re: How do damaged root trees happen and how to protect against power
 cut?
To:     Carsten Behling <carsten.behling@googlemail.com>,
        linux-btrfs@vger.kernel.org
References: <CAPuGWB8Aqvr6po0-nJskh_5W3rUv1+y2P2U-pYMAJ_wwKnLjkA@mail.gmail.com>
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
Message-ID: <bd84944c-2851-87bb-4415-ad988b7e807f@gmx.com>
Date:   Fri, 20 Mar 2020 08:46:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPuGWB8Aqvr6po0-nJskh_5W3rUv1+y2P2U-pYMAJ_wwKnLjkA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YDBAePzq0nbl98w0hC6cfBFLaP1V1Ne04"
X-Provags-ID: V03:K1:bUuanP5b0KqGW4wvPaTfkd6qHlM2GnCHqfv1tX+HXNl8KPQFxYk
 073O+Enp6dv0Voe7PFyphgPYM4KkpH/NrlK0s3zEvJ3cshXbb1tOd5snAljGRtIHDFq9Mrn
 E8jOPWFnmBJ/knh/D033RqxUk4k4FFcHHxvaBhzrUONvlPjpwxGc1QM6t4XjaZvFtdY6yxO
 e9hfUIkpA+XLe98wDoKqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:njl/LTP1zUQ=:vhbqGZICmmq2l80emj7C7e
 Mx3VTfQrdXAsdM+FbxacMiRLmaBT1A0BV4gBdSAWNNClyIVg/vsWPW3H5CuX2QTPINiijE4wy
 4EFetIpOyyt4gWR1jHqNrA6JHUEr6cnExfl9rdAKhvbjOH5nnezTgVxjrGP5fgMi6Mfq1hDBP
 AMuZlNRvqTu8bAM5C+aZOx+lI6kHHSuhhIdxZnbphmZ6mZdPURhJTbQzM4EK9A5bys37odERp
 oXTcpoJlaZ2bpvvDdxFrD2z7BaNsvTBMiyIuEeS8OFCtMUguVUZFhBLANIwjVjaEe7ic9R6sZ
 OkLD/cuqg4vDaJ3uxqOQvb6D+fb1Qg9VNm6IRXFyPAJrFNZWU4Mvlglu5Lhcn3PFPELRD1Nc/
 PZBNOAG7IM//aPaPCPu7gM8Tl+kb6niR5V9yNvV4uwHRYpJYNnxY41r6CTI8TZSudd64zg0wP
 06K9hOWy5G2qaUDIKmUffemyzBxQoYc/hYCWDzTm2OTnUJRfdA4LSHMNZ1WtmpbUptkDqNZzV
 gPtkUIRFkuQ8pYYPUk7mZqbFOBYfDG6ttTD+LQ+ezeoceMeQTvfqmERbLwUO37EFUa3A3nu83
 lmwKmPcv9McsnNpF7SUhGmK5TUDY7zmhdRMKTsGp6s+6HL0AmOYm6WoM7C8hkSioK4npBl2/R
 GKrX/WXB/oxvotHgla7kQt3Vx7OXB1c5XHmyaGE0ECSbZeEd/S67i92mniDaY+06/TUsw/sZG
 sjpw0y+ssOpAYKm+Uedrd3TeoCsDK4v0DSY+c4jQSNRX3SMQZmJXzIG3rW4FAYW+MXTpxyESr
 MvhM6c7z3/zQkg2usBSQYLYg3Xm7CSAjfjMKL1svo3xMfdkiAzLxgLgcWLaQfXB4OJfQOPCL8
 kKNXLLaMkXTijpNcUGEXCkIXgkGxAXpsRM/m1r6CVJh1+MoSCvEUNmya8RN9jDZJX/AMGQJiu
 dkuI+culqjDDmJ9rEp7mltRv2WZvdYWCgsmjarzl/89sn2PsGa7TH1TEQmjuAH/xt7IDJ/lpT
 OfHZZ5/dSOPYJ3euL3jDsGgYQC6baqoyndiIlsqyVg1omsuk3FXRKhKvCBVNpgKyqG1HEmspT
 VehQVvZSTyOB4SexTDKTZiYNp9ag1ZLlBs0waFZ7BuJjF788tKwXoyV1CWQckvjv6KYLubdAR
 viT/J59KB14wSyGPkfFzkh7Yv7rwfcftAKv897GOeBwIVsHLhwrUVKIY0dLHbI4bEvAkfWFZc
 DLgxEKNcXUAwR1Bc9
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YDBAePzq0nbl98w0hC6cfBFLaP1V1Ne04
Content-Type: multipart/mixed; boundary="lhvyf1xgXO9WPcOi0olV4RZfL2yyPGoix"

--lhvyf1xgXO9WPcOi0olV4RZfL2yyPGoix
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/19 =E4=B8=8B=E5=8D=8811:14, Carsten Behling wrote:
> Hi,
>=20
> the investigation of damaged root trees are already discussed in the
> thread starting with
>=20
> https://www.spinics.net/lists/linux-btrfs/msg74019.html
>=20
> However, one point wasn't discussed at the end:
>=20
>> I thought so too. Is there a reason why they ended up being colocated?=

>> I'm surprised with all the redundancies btrfs is capable of, this can
>> happen. Was it because the volume was starting to become full? (This
>> whole exercise of turning on mirroring was because we're migrating to
>> bigger disks)
>=20
> Because I have the same issue on an embedded system, after a power
> cut, where none of the root tree copies are usable anymore, I'd also
> like to know :
>=20
> - How can we end up in that recoverable state?

There are two main reasons:
- Btrfs bug
  The most recent one is between v5.2.0~v5.2.14.
  There may be some more in older kernels.

- Bad storage stack below btrfs
  The critical part is the FLUSH/FUA behavior.
  The spec requires FLUSH/FUA return after all data is written to
  storage or non volatile cache.

  Btrfs heavily depends on metadata COW to keep it corruption free
  against power loss.
  If FLUSH/FUA is not working correctly, then btrfs is completely
  doomed.

> - Why can't we protect the fs against the unrecoverable state?

If it's hardware, we have no way to protect.

> - Why is that error is so hard to recover?

As the only safety net is broken, there is no way to recover from such
deadly corruption.

>=20
> Furthermore, I'd like to know what would be the best solution for an
> embedded system where power cuts are unavoidable (because of a missing
> circuit). I'm thinking of using a read-only rootfs with a separate
> data partition to ensure at least a booting system. But anyway, the
> data partition could end up in the same state.

Since if it's hardware related, I recommend to do a power loss test
using latest kernel.

If it's the sdcard's problem, under heavy btrfs write load and powerloss
it would be pretty easy to corrupt the fs.

Then you can try other sdcard until find a good one, or prove it's
kernel's fault and we can address it.

Thanks,
Qu

>=20
> I'm not sure if it would be also a good option working with snapshots.
> My space on the embedded device is limited to 8GB. The OS already
> takes about 4GB.
>=20
> Best regards
> Carsten
>=20


--lhvyf1xgXO9WPcOi0olV4RZfL2yyPGoix--

--YDBAePzq0nbl98w0hC6cfBFLaP1V1Ne04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl50ElkACgkQwj2R86El
/qgnrwgAnXT+25rE+jzAJ0vAXMXLJjyZTqbgRxEGzp/Psd4VgPcZWKAIzOPe0/YK
5PcknJTkKQwMZKN7isOt6H78lvtfNLVkA6RnoMCjVNY1todpLbmh8SiBr4Fhyshh
hj0dwZwIqDn7XCLBZMDvKaeY/EDp/CZU6ge5jxmX95/GkOi1w71yYJ090hdDTEk6
5JLimXXUtwACWwEpBbm9txOpmnRK0Pyge6GnXVlRzY/6Yxi5KRtZhIqr8UN6iHsd
AjBk8RvIOfeK85HENUoIDKgtnkZz9rwOAc8wg0nBNu1qWjdPlcVaMhOlqeMTxDvd
IuQvryvnmAeWH0r8SPluXTkci27crw==
=SnBi
-----END PGP SIGNATURE-----

--YDBAePzq0nbl98w0hC6cfBFLaP1V1Ne04--

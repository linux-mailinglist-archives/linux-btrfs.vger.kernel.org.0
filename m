Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A456A2B555F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 00:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgKPXu5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 18:50:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:58221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgKPXu5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 18:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605570652;
        bh=Yi8NoBGEOT9Uao1gEf3iHsTQgmcilBS342kVdNVMtyw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ebNQKybnIoqy3kci+l0nUjy+27GVMdjkG1cFl3EFKVGrUIK1BUw/KnT1BsZ4Z49o+
         RPNUS8SLSnUCtM3n9oflbSnC9DrtTAolHVhwN2XZ8Q5jFd4t2mvSfmQOPEPaaVGMiE
         tH02Uiy0IMgUKN812WIXq/LGNdOcLq4ahtsaeFQg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuDc7-1kQSLW1ZHh-00uaGQ; Tue, 17
 Nov 2020 00:50:52 +0100
Subject: Re: [PATCH v2 10/24] btrfs: introduce a helper to determine if the
 sectorsize is smaller than PAGE_SIZE
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-11-wqu@suse.com> <20201116225129.GU6756@twin.jikos.cz>
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
Message-ID: <4094ac4c-1755-8ba1-81be-6bfa5e3b24fd@gmx.com>
Date:   Tue, 17 Nov 2020 07:50:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201116225129.GU6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MbXZYEyeTvtEAPMvLM6ycDEakjNO7cVsQ"
X-Provags-ID: V03:K1:E1tzWjOb+kM4LdCEgo16GVLJRTYsbDP39BVYv03ZsKE3JIfiu3E
 FqetDX/MY6PmhyRrMfE1xFTTBbx4IKVmtLngygdgDNP6nVSC7Ujs+Qsw4aWe4QENS/MfwVV
 wce90FCFyW12cb/2t7LoJKT1lzAkNjjE2spCSoBliWzHDTCH+y05fri/a0K4/u4vTWr3C6I
 8vzwnM3MM6sjDTbeLbTBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3a2Y2FyYX1o=:QVaWt6jKNPMBnh2PwmYk70
 RHLFSOneb7QKvRP+UiXN5jkoa6NbPC3+mZ5vWpRXyr1LPBVuAROL2r1EFAqGRh/+gVujzEWn3
 KnKASKM5YxloReLLT9zbuN10bz3bZC/1Ekmt4bKU0z7Fep165PZM441Oobq0Qx2gGazm2q8p9
 RSdDsGC9hVl/5QGwOCJOuFW/rAvJo2TYvRRb8XmUvBP8zH2iR8n3xTJwIv87al8ti/1cSPQ65
 hrnDb2wnW2Yh9KOK4pPLiu6p/98kx57Mtl1+OQVG++OLOcX+5Y8MRhQ1M96HBKDdkWzjLFF29
 Z/ZX6PSc31w9xp2Fm5M2YwBrDFTo8VyqPVRpFObs2hS0Dnu4pMvCVR16T8gKbAl8itk+nXidb
 WoxFxOkg2AZLXZuRsgd58oBn/7eOpTZdwiw1f6BqqkavNpDjMm65e7fyxJBJfPMsuuXeM58fV
 i12BC5XslzUNvyuXMa+aIDALh8KMx3vSz8P9b40V3+VFjgkqWUGqgb3NACYB6zIkzN4IaY/yX
 9j0yZjF6vRnsxD0JpABhUhtOaKJHIBOmr6daP38yRcxKQmdA/11yjVaTxvjqZf2rJv6iPkiLL
 9TckVCdwJKjUPa/GiqNvIN0vvr8I2rWDPmFpvYw3QZW8G3rn4sF8qqZuMUeu7RmISAQAI+Z3W
 ZQ+UOryYoNaL6slLAWwesIzwFuL14qd0T0SmzU6PHeoWYUvcwGjP5TG/zjygJtv5mhA3Dv+rD
 RTY8B4QvUoyKWrbnz1U5jYx5rLecW+VkisYNazsmQOb+MVyqOwTHWKLVfvNJ7+XNBI67g2zQ3
 pgaul8BQTcZvCak63nEcNceO22lW5bLlur4ZPbwwvRi+FdsOtIzPVGLeJG9c594V03WHOQcIt
 sws7doK3BIxZ6v5gnGsA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MbXZYEyeTvtEAPMvLM6ycDEakjNO7cVsQ
Content-Type: multipart/mixed; boundary="bskM8L12xWlXFSDaNiTgXqIvR6U1Ol8jY"

--bskM8L12xWlXFSDaNiTgXqIvR6U1Ol8jY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/17 =E4=B8=8A=E5=8D=886:51, David Sterba wrote:
> On Fri, Nov 13, 2020 at 08:51:35PM +0800, Qu Wenruo wrote:
>> Just to save us several letters for the incoming patches.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/ctree.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 99955b6bfc62..93de6134c65c 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -3660,6 +3660,11 @@ static inline int btrfs_defrag_cancelled(struct=
 btrfs_fs_info *fs_info)
>>  	return signal_pending(current);
>>  }
>> =20
>> +static inline bool btrfs_is_subpage(struct btrfs_fs_info *fs_info)
>> +{
>> +	return (fs_info->sectorsize < PAGE_SIZE);
>=20
> I'm not convinced we want to obscure the simple check, saving a few
> letters does not sound like a compelling argument. Nothing wrong to hav=
e
> 'sectorsize < PAGE_SIZE' in conditions.
>=20
OK, I can go without the helper.

But there are more things like:

struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);

Should we use a helper or just above line?


Since we're here, allow me to ask for some advice on how to refactor
some code.

Another question is in my current RW branch.
We will have quite some calls like:

spin_lock(&subpage->lock);
bitmap_set(subpage->uptodate_bitmap, bit_start, nbits);
if (bitmap_full(subpage->uptodate_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE))
	SetPageUptodate(page);
spin_unlock(&subpage->lock);

The call sites are not that many, <=3D5, but there are several different
combinations, e.g. for endio we want to use irqsave version of spinlock.

For data write, we want to convert bits in dirty_bitmap to
writeback_bitmap, and re-check page status.

Should I introduce some helpers for that too?

Thanks,
Qu


--bskM8L12xWlXFSDaNiTgXqIvR6U1Ol8jY--

--MbXZYEyeTvtEAPMvLM6ycDEakjNO7cVsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+zEFgACgkQwj2R86El
/qjH0wf8D9gry+JrnjKw824fRzMSnvsukKDDtrMJjM3qh5wLmnJsgXUfnnIsZWax
LtqeqlJdgCFD+I2iL3TJ/cJYYZy6bbhKDcWBNYGahnqP1bmSEll8gnEROOISpsYF
w7cNNsE8K3qPLhPH1ZUm/E7d/Pmopzjc23D0UxfFCaEwkfGAooEbskvxO9vfvLXm
Rzb2/AFKhTr1KFospw/CpqH94YU2zGXEtqsQLa6ElHI5dQwxK2A3o4KHSqPpE2Io
YG/pL7rLRbzcwUu/dp2fbCFZVfikkeZ3LAPcSQts75NDrOx8SVS4Y5LtxTkOGaao
hjddyZP5G5PaPLthWJxv6abRfzG3vw==
=VLWb
-----END PGP SIGNATURE-----

--MbXZYEyeTvtEAPMvLM6ycDEakjNO7cVsQ--

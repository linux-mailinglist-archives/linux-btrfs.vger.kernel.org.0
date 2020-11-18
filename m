Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E79B2B889C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgKRXoR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:44:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:50039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbgKRXoQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605743040;
        bh=PFlUvdoRCuG4hLHqrDTZtxGUNaasXcloDMf/5+mxi9w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=S6Tuz/TU0tMNRFU40tLP+sOjew1nDYjiHL/Uf4ChETYR9DaaJ3r4tlSUcGuo/3siL
         3+cZ6hV7HXZKfeOxjm5xnTodjSUcmf5vyLYHKFnfP7uyojW23/S29/+ZqHx0kmxDdQ
         GiMJunucgsCvSuDQ5MtNO4jJkH+DONlQZugtuaPI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel7v-1k4pFi2RXh-00aks8; Thu, 19
 Nov 2020 00:44:00 +0100
Subject: Re: [PATCH v2 04/24] btrfs: extent_io: introduce helper to handle
 page status update in end_bio_extent_readpage()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-5-wqu@suse.com> <20201118202745.GG20563@twin.jikos.cz>
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
Message-ID: <0d9e346a-6ea7-893c-ce64-8f8d9a5f2785@gmx.com>
Date:   Thu, 19 Nov 2020 07:43:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118202745.GG20563@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gFga59oG9Xg1dmAAF0pzRpXaNnCtfPkoM"
X-Provags-ID: V03:K1:MX+DnsUIltfmBK7bvlmjZ9F6GkdgkkQi9xp5u/iYeLDGxhbjy0z
 u/1xxnM3Gn/6eCmE0bfFf9YmcBV+tb6/AIUe58vJZj0gM4JcTW62lJD4PWolFeATnzXqNYf
 RCyFTnMFTdTAe6eFV0+WDVXosAKLc5sdkcaaOeTC4ua0vGF0TGy4B3dmMXeIIQ1X/VtXWDZ
 qA6IG4Z9doFcg1BcceBEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L4YhaUMNSJE=:k/z+Sndzz/Kp5+ulFL8Mkq
 JwhqdmBzOU2I3ghd0hnt+WsqaDctkNuYZWT3b3kfcoQSbkaO2ViKnLkGuji9q3Mje1i97YBCB
 muy+hVliDGwb1YLZ43mcCFyryhOu5Mgr1o/VwWFepl9qOEu7cto2/snqgm2hMpFykTVLEW764
 gyICE9djSeNNN9TObysTRavI4ZT7br1X7GPPQhLVSxs4AqpeHONwUkB2M2l/BTRXL9/R8IYEZ
 SmfIqhuyiDWMR6XCB6JHAkko34oU8JllUsaRj8r3oWm7htuwT89/B9lu0EFReueq5VqiyQVDk
 mbEHGvdKTcnoPsD2ORLfr7GEQmqV6SEgdE+rPCDTGez9WfmUcRz4swqmpqF55EWWmlg66XOTa
 trDmJ3CSXY3Ku/EF8nv31IjwHW3zQ0eEZZps2AsQTMqlBtwihkKeekPFr6jGjjlK4Xv+bH93Q
 YD4UTUrVYl4ioze3YzRhpOHkLSA5xNA7qG73we6BtNAX/sjludwL314KLWUp5eBEPRD3nVFWa
 PFXno/Eh+4i0dYjnOsfEh0Dc40psS7h3utJQxvBlQEHHyyxyeJ50Cq3AzwIFKY4i+VgynCYfL
 bFHpRcPYvJj/yG0G1Lc/EjKzSJEWCISyPFYupFrCv/JJ0LGeOwfj+NjJ3PTOLrBExy42ZAsEU
 LdDVXrwfEoDsxqAJjQ8TFg4djVvFqvUuFCzGcS8njrVJ5Gp4RDkjJJo8lz5ssVeAPQvWer/It
 QuBQGa9GsEEcABz8RRnRfc7sxEpPbWlNgUJVLUoH8B0f0OAKI5o6v0ECEKDcwoHa7J4avdOvC
 f2yGUVEqJX34dhlCaLiHAXidgTipYkdnZ37SmK95u2KKxO04/SQplN07gd03+es782gFjKGt5
 7fC1mPXsiR+InRNwuk8w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gFga59oG9Xg1dmAAF0pzRpXaNnCtfPkoM
Content-Type: multipart/mixed; boundary="gjGX6K0md98yCJJ0iENtSfZD817SprbCg"

--gjGX6K0md98yCJJ0iENtSfZD817SprbCg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/19 =E4=B8=8A=E5=8D=884:27, David Sterba wrote:
> On Fri, Nov 13, 2020 at 08:51:29PM +0800, Qu Wenruo wrote:
>> Introduce a new helper, endio_readpage_release_extent(), to handle
>> update status update in end_bio_extent_readpage().
>>
>> The refactor itself is not really nothing interesting, the point here =
is
>> to provide the basis for later subpage support, where the page status
>> update can be more complex than current code.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index b5b3700943e0..caafe44542e8 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2849,6 +2849,17 @@ endio_readpage_release_extent(struct processed_=
extent *processed,
>>  	processed->uptodate =3D uptodate;
>>  }
>> =20
>> +static void endio_readpage_update_page_status(struct page *page, bool=
 uptodate)
>> +{
>> +	if (uptodate) {
>> +		SetPageUptodate(page);
>> +	} else {
>> +		ClearPageUptodate(page);
>> +		SetPageError(page);
>> +	}
>> +	unlock_page(page);
>=20
> That would be better left in the caller as it's quite important
> information but the helper name does not say anything about it.
>=20

It may be the case for now, but for incoming subpage, check the patch
"btrfs: integrate page status update for read path into
begin/end_page_read()" to see why we want page unlocking to be done here.=


Thanks,
Qu


--gjGX6K0md98yCJJ0iENtSfZD817SprbCg--

--gFga59oG9Xg1dmAAF0pzRpXaNnCtfPkoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+1sbwACgkQwj2R86El
/qi+gAf/eLl5LeV13AY4wQ5GGhHzCqGO4RG0l+2qdxgS2bKcba2VTfxfOAnPbmM4
hdZseUgPJdXBrsV08dfq3JisTTUs3mmR8emhmb15iGx6xv73IrZisoTKcNAj4Ujv
3oPPT2oPRHsqneOJTRgBFe/iU1Uko4ZyLxGgWCNs6iFQ4cYyah22V0L1y2CgDur+
3ByGz3Mq/3QDlbimzb12wiruA4tXiELqwiIv3B8L4yGwg//FXGmw0I3YXXkYt46A
iJnZOV1dOHc3ZWfyYgPlepw1a3nqYadYS5tD1fy1Y4bSCFAWEuhx+ip1qWALKE+b
5RQ0uiDii+xajusoQjhgvZYAUA0lVA==
=f9om
-----END PGP SIGNATURE-----

--gFga59oG9Xg1dmAAF0pzRpXaNnCtfPkoM--

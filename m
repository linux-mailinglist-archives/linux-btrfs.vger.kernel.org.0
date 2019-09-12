Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DFCB0A61
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 10:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfILIcq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 04:32:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:42469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730126AbfILIcp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 04:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568277158;
        bh=ERoFHcsDmkxYkdv7iK7RBqOu7iRQj3yI6ISXCBwQWYk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bPHBGBtx3SCisBFM1SsVYj/B0Z1xRhGozNwMLJiKtJqRaGxmXsj8ShxlhXWwQ/1hJ
         Ne19ygW3bpqnR7nKBTei6KQv1bF/7rVVYJQUMG9WkLEXH9eqyTPXdo5GI2/MqAvBse
         52h9qwc9oLGuIy8jWseWT5A8PcPNE36F0iT5Gj9g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wLT-1i1TqQ39bP-007WLM; Thu, 12
 Sep 2019 10:32:38 +0200
Subject: Re: [PATCH] btrfs: qgroup: Fix the wrong io_tree when freeing
 reserved data space
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <20190912011306.14858-1-wqu@suse.com>
 <CAL3q7H7aycs+JooiFhGec38UK4coVbpjB491vdEGqwHhP_n5bg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <86d4a5fd-9790-4ebf-a899-2b2ad5a24694@gmx.com>
Date:   Thu, 12 Sep 2019 16:32:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7aycs+JooiFhGec38UK4coVbpjB491vdEGqwHhP_n5bg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hhy1MTMZaS8sXQiiBnkTSQn3naBksP2ig"
X-Provags-ID: V03:K1:cMrJ2gpSpraD/q20XQlpAi5yoVh7vZmVmExMlG1zkEThevEs1QW
 pYQMwkOeKUXl8IGShl3xXkYqq7XmmXuBxKNJd25ePNEYIDYfyPSVsZKzQAn9Ucc9YNrJEn3
 aajxgoPUAUfZlVr7e7CY0I+/wNEzRXFbn0iTCW8wPEaKIhAfJNfDAAae2A9mf2718ogvN5W
 OYmP98/XLAcBJlvIzhJlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kTBGBYL/hxw=:nU3a3d9n6iOzOZVDFLIQP1
 zf+tGvZDGioNBBrx68xec/i1orJ7dfAwBCOAaOJNjlQXNgYnS2cJAHkisCRUTTw4fTuCAeDpx
 m9BT0+OARasutp3bMl58t5AOM4LLZW4dbLMOvVNnv8t9OWEpKZF5IkN9k6ksEBIceQsND2RfO
 k75FOUXg8m4N6s3Vi0iGYWphJI+AedMqbXu3g0D1KVsMZeViwo4XVvf1S9NnuMc2t56izBlRF
 tTn+Gv/uS7chFWBDHvfF2PbEqEecsZycq5DXGQ4YjdgthnQ7Q+0Hkfj594F7dq85acb8JNnb4
 rnwRjpGNoZPOUUnjDAoOcrO7GrAto2MKillTn4AXLJVsz5w+5Jg4nz3GvtDrW0uUXeB8yQl+u
 4ByLqfjojRrKqFrRKm3HKXSNJftCittIY5gVPDLxhGEohjBvMqXTRXMAsjLYU/JyMD3og4DZa
 SVwygaxpJ3cfLN81ralM3hhdhIefnvzXR+40kPQEs0lOpddBck4E6ljHEX/APiS9+cOX/azWt
 YaSgljDP6KAzxHrzxv9PEm86LggEv3SAJ5WzZh9K0hZaFdepQYOaQybaU/MF0uRupHiq+STpw
 nADZP+x5Xc3CUVREvE0TJriLS6aOaEhAmsfHvCA8TFZFyhVQybD0wvxZGDRevAcwXQtX2MAwU
 t/jMfBF7fAOH2/8ozjQQ9mab1YPMJEAEtvzF0eCzyTU2KAXsw9wNXYXArpYb6WauKyKMO9XsJ
 j76dFr03JarHw9k+rv7HNeF3Fqx1VNOUgMjQfnOmIfTNnVzChdAFC1HIZMypqVNbi/NQXSufl
 +y0SwGrLOu4sNz7+lKDUkqe/ppPL7/olYtiIRwmWOMmiP/MpYB+DV/ZIpmSAZG3lHSrVpI2kY
 bVCgdbQP+IG5u33pRn0vrCxJz8lCOgt0MTFgtOtLraXLDreHjIcAAssXWBKkeu3DiE70Sr219
 yx8LKEJgp+bZc32eLNY7nHeGVcXlCQqdnI1gFK2jd2ggWPPMXtKS6hmlUN4+aRMZA9g8l5wvD
 fVdqv+izTKKWFE+gG0yhSDTR8Nt80PVkulrKDlpUiJBmjkWt/xvLOtTJtbNEx2EBGh0bApku/
 htgLnbT8NLgwAOIp4laRKwvDnSZ8Cfar+6Bbgz9qp2hYRtCyYH/2cI3mIzGKz+O0gSUUI5C+g
 tYaOkFbKrcFhhgR6MSwHq+B+EsZMaOUiWFm8a2o8l7XRp4CJA9CFY9EHKDNJm4jPytG/8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hhy1MTMZaS8sXQiiBnkTSQn3naBksP2ig
Content-Type: multipart/mixed; boundary="YA3L91Wq2apeZCyokk96PbkIcdGglmxQS"

--YA3L91Wq2apeZCyokk96PbkIcdGglmxQS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/12 =E4=B8=8B=E5=8D=883:53, Filipe Manana wrote:
> On Thu, Sep 12, 2019 at 2:31 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Commit bc42bda22345 ("btrfs: qgroup: Fix qgroup reserved space underfl=
ow by
>> only freeing reserved ranges") is freeing wrong range in
>> BTRFS_I()->io_failure_tree, which should be BTRFS_I()->io_tree.
>=20
> I think you meant wrong tree and not wrong range, since the code
> doesn't change the range, only the target tree.

Right, wrong tree.

>=20
> Also, for the sake of completeness, and no matter how obvious you
> think it is, can you explicitly mention what's the consequence? I
> presume it's a qgroup reserved space leak or underflow.

Yes, qgroup reserved space leak for some error path.

I'll enhance the comment, and also craft a test case for it.

Thanks,
Qu

>=20
> Thanks.
>=20
>>
>> Just fix it.
>>
>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>> Fixes: bc42bda22345 ("btrfs: qgroup: Fix qgroup reserved space underfl=
ow by only freeing reserved ranges")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/qgroup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 2891b57b9e1e..64bdc3e3652d 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -3492,7 +3492,7 @@ static int qgroup_free_reserved_data(struct inod=
e *inode,
>>                  * EXTENT_QGROUP_RESERVED, we won't double free.
>>                  * So not need to rush.
>>                  */
>> -               ret =3D clear_record_extent_bits(&BTRFS_I(inode)->io_f=
ailure_tree,
>> +               ret =3D clear_record_extent_bits(&BTRFS_I(inode)->io_t=
ree,
>>                                 free_start, free_start + free_len - 1,=

>>                                 EXTENT_QGROUP_RESERVED, &changeset);
>>                 if (ret < 0)
>> --
>> 2.23.0
>>
>=20
>=20


--YA3L91Wq2apeZCyokk96PbkIcdGglmxQS--

--hhy1MTMZaS8sXQiiBnkTSQn3naBksP2ig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl16Ap4ACgkQwj2R86El
/qjB6Qf+Ill2RMe0aLm2NBhUO2kMtwAGRnxMRc75LrPDaknsJ2eMja6afIE4usxA
yH1sd+FhtJoGvf3LQepleKDL+XZYMRypw9IPNhDDfibvnYuK/okHAjVBW7ndusnI
darTd/UQkaJOXlvqFGyaHoVTDnyz1wvs5e4JrdVgkC3wkpVC19fsmuOFQuskA8e6
Aw7hE0mKzadi+1JfBymrTpsOsi4142Vzy8d7VjRq+iEceben8IsEK8rdTw+gSdcy
6xfF4wA73Z0uqzf9uRuu06rNUPEYVoodoJkH1AgmTMGX5wOw4558QjjPPe6QXeck
04mgGGamDFNNqoqhzH/tfsANDCqj0g==
=I0Oj
-----END PGP SIGNATURE-----

--hhy1MTMZaS8sXQiiBnkTSQn3naBksP2ig--

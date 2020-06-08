Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C8E1F138A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgFHHYV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 03:24:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:35291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgFHHYU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 03:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591601055;
        bh=bxQ4+S9/6j7Zb8/88IoFsrvuBs56bBKkpECeNE5CHcI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GdruskfFqFq/kYVmNKeDV9LXBLrnXG0Bu1XuipuDvZwVWQcr3fEvrKNSm0zvbz8O6
         lbraS0+Bo7Uu1fNL+Wf04dbkczq0b9H53/871kC7Thkszy0IuCbhARWFg6Ugj1bNxK
         jjRixYAmq1pf/xV88KsxADgXEE2GpeL/HE9k6tpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VD8-1itvls1gxG-016vUS; Mon, 08
 Jun 2020 09:24:15 +0200
Subject: Re: [PATCH 2/2] btrfs: qgroup: catch reserved space leakage at
 unmount time
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20200607072512.31721-1-wqu@suse.com>
 <20200607072512.31721-3-wqu@suse.com> <20200608072000.GA6516@qmqm.qmqm.pl>
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
Message-ID: <4e6fd959-f04c-6c0d-9e13-86942ef47f12@gmx.com>
Date:   Mon, 8 Jun 2020 15:24:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200608072000.GA6516@qmqm.qmqm.pl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sdjfwdfLmrFCW0B4trriZFPEpzdNmopCT"
X-Provags-ID: V03:K1:bM/8G8H1dugWBW9N+dtQ5lw+7Aw9DP2wN6GtVRuRAyVoMH6Enwq
 VH4f1cc8g011u4bT0ftzmqLKr3p3sBjMER8hYX4vXDU9J3v8IP0qCkUmLuIx5twMvx2KWVm
 I4kzKO3QqM+5357kU+HAtbZn7rVKANJjWYyaPJDbMiEtO8DHo2RvOIfNeJp055qk+XoNxeM
 bIeTp3bfOH3M6Va2rhtcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MmKZwoqOeh0=:qi/4oEDc9rpQRKYC8DPY1L
 VHr1SRzwE/vO1Jo/8PPiFY5eFc2fgMeUT+xETdU6EFqWev2A4FvHIOK3+hEG/LqXzamNTSOwO
 iUvbfS5H6rOvtnZ26zhpzCU3sGGyWlLCjg0IrJ1s8+0H9aBaMBlHAyHuNvDWYwNltt5qPHHgw
 ZbPULAmQy6vetne8MMH5lRVkorRPzhnj/knAws0yXeRPah0gHY6uQigNfhGOEBxRUp/3xOAzJ
 PPcoTLco6H0a8/CjbZXatkeJ5GkSarxsS/bJdAf/3uCcKI5+kTth5BgZpX9Po2ueORAIrXEB2
 5lYQ8XQqFQ5/jVUXzJXjeJDptCuWbCQZ5uO0ghhvtqw588cp/f9ZSbD9UZtXj2Wf3Omcu9HW6
 fBTjeJaaH3y8JQZbKEVhkqEztpM1+LXF5gU7S6jO9OHsX9BedPnIaoeepm+eYANkJtTbsleJM
 D7b/nJ6iZwKpEfkRjR4Lu2i9TXQzEGSzvTQQiHv//1u93ypITCH9nasBgtI+R06ewIoTTfj+I
 lTTKzjb9ixLfLcsgFetBh8+RrNcQsiFrcKYBw9e1rHvGNLKApaRh4kruRUpn0Wci7Ltpw5axw
 ckGUEU4qHNgF85i/OjevBOLDzkWHO/AMLgSbT6UhVZnVAfFtbJS/EqsCQUB4VOb4HwXNhNYle
 oFlAYs/qi5uYN2VaJLZ5ghUV6JtjSqOKI1wB1zg+nGYeDUBWLjN+dZAmA6rT69oSfGGPwdGlO
 3ACzuXbp55YfwAa1h0un8GirMASNFANFexUicjcT+tkrncYf6EDN9KE0qzUBSeKDOrNCSW1K8
 k127aKr12+6C1j/VV4KYOzBv44BtxqWhnZZ4JNUKXkjZ2Nv3rXDc7stvx9Mv4Nvhv3qB/vlNa
 e6MF0J7RUVAN0/IKC0K74QBoupoC/M+xIreuB/zRsQ436okpejQ7kgAAyr5jEuvtzthJl8M0r
 D6UEWT6DSdNaNPAi6WYoGPotm9Rb4wR82I4j3mpKFfthGz4GFGphAZbPlUBGWRThRrPBjJAoi
 iXQs8l3ctXLlSThGm72fQme+hBd6fXw8K2mEhKviS5Z2TYq/wZbEd8D02CWoAbt9MBpuK9vqv
 GcZDuea8shu6/0qjnDHWr+jfMqIZjav8cnwh0APfiDWrjE0CueoUCaaQXZXh0wUlXKuhoTqrr
 4ja13x2yA3ZoUBBLSJHOsS4K+SRqzpHwzx7nb4+MhXuq7BVk17Ub/P881feEfpUza0EctvIbP
 1MS+oIHtv4GAzcfry
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sdjfwdfLmrFCW0B4trriZFPEpzdNmopCT
Content-Type: multipart/mixed; boundary="oVC35Z7gzl84vm0HHWreK4HvcxCgYlrXF"

--oVC35Z7gzl84vm0HHWreK4HvcxCgYlrXF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/8 =E4=B8=8B=E5=8D=883:20, Micha=C5=82 Miros=C5=82aw wrote:
> On Sun, Jun 07, 2020 at 03:25:12PM +0800, Qu Wenruo wrote:
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/disk-io.c |  6 ++++++
>>  fs/btrfs/qgroup.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/qgroup.h  |  2 +-
>>  3 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index f8ec2d8606fd..48d047e64461 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -4058,6 +4058,12 @@ void __cold close_ctree(struct btrfs_fs_info *f=
s_info)
>>  	ASSERT(list_empty(&fs_info->delayed_iputs));
>>  	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
>> =20
>> +	if (btrfs_qgroup_has_leak(fs_info)) {
>> +		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
>> +		     KERN_ERR "BTRFS: qgroup reserved space leaked\n");
>> +		btrfs_err(fs_info, "qgroup reserved space leaked\n");
>> +	}
>=20
> This looks like debugging aid, so:
>=20
> if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
> 	btrfs_check_qgroup_leak(fs_info);
>=20
> would be more readable (WARN() pushed to the function).

We want to check to be executed even on production system, but just less
noisy (no kernel backtrace dump).
Just like tree-checker and EXTENT_QUOTA_RESERVED check.

Thanks,
Qu

>=20
> Best Regards,
> Micha=C5=82 Miros=C5=82aw
>=20


--oVC35Z7gzl84vm0HHWreK4HvcxCgYlrXF--

--sdjfwdfLmrFCW0B4trriZFPEpzdNmopCT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7d55oACgkQwj2R86El
/qhrZAf9EZlyzYTWKGNuryxKEpZ4npwEEdS1Owksen/VUzhnWFHRRxoei2aFHFbY
zxpqIJ2iBkPAaIfdXmyJHyk7cUuhlCjHghKSMJzT2lcm0Tp8b+FLUHWOr9xqSvT0
gKjw+vEJHw9qGJ5BtKa97OEsZCMfE2ZlQir4cP9ZQFmbFfBDzdbHTTT88IBPfZvh
cl17BUcm/oKMSStIoaSxBW7BONTO8l+NOMvKirP+kSYjnm1uBTApfkPfqaPqw6qS
mXr9li7hGgXquc3rBPBHzXY+9UmPnVxZA1HXwatVdoYNcYdSPHbVIpY33WBT30Cf
2lx+9olkZ8xg1yQZDQj5x+7Tm96cWw==
=kWsJ
-----END PGP SIGNATURE-----

--sdjfwdfLmrFCW0B4trriZFPEpzdNmopCT--

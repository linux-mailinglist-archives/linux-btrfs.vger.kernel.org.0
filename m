Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C267219E20
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 12:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgGIKqw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 06:46:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:41359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgGIKqw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 06:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594291607;
        bh=MeEB7kTZ890sEcXOYhoEh67aEsM42Bo4SCLt40m43k8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WiwT5NiGz57abwRFAzttuM7CwzGhVE/gKvtyAJVv9Efkq/s0TEyz9zT3ph2IEW0zQ
         uJd4iC0zQR1A8aXnt4GLPsO9wGUCPsCUYBN2SitIk2agvH5xvwK0e/xHA9E+krBH2U
         JX6f1NV5whufcB6EIUs0OB+ul7Vn+GtvNe1+tC4U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McY8d-1kTvDv2DID-00curX; Thu, 09
 Jul 2020 12:46:47 +0200
Subject: Re: [PATCH v2 2/2] btrfs: relocation: review the call sites which can
 be interruped by signal
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200709083333.137927-1-wqu@suse.com>
 <20200709083333.137927-2-wqu@suse.com> <20200709095413.GF28832@twin.jikos.cz>
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
Message-ID: <93ef60a9-1365-28f7-629d-1f59e89925d6@gmx.com>
Date:   Thu, 9 Jul 2020 18:46:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709095413.GF28832@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pgPT0Mg101M40cPI3y7QDRcPxWobiqCmi"
X-Provags-ID: V03:K1:5UOsQkErjSMalON7wozz2J1gpT58+FyI+TrN3sAIAAl/DqQttKy
 idtJPE4NMqGbR1zotyotoF6XxTo7VULx/WjvO+V4m1Ngyhhr712ODoxcGlCwgEg+MooNTnh
 2pS49YAb56/EScjzHZpX5icgyP+01IgcchzdX14OfG5PwtxRCrHhSRvAINQpjQjLbQQVB53
 T1JgV8ZjWB/YoOEI/Ov8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ba8QZN7vAoM=:2aw7IK55s1XPWx+KSrOC8S
 qenCe+wtty4d3wBnGohoHHy/1OdcruaFSKjd7xPJzgCnBcf+GcpjMn0rvrNTR6Umds4tgGwvl
 jppNDa3+0ctpF8vgi2zROsVtotBmRhtbFMsardyZQcHUQ2CVtmClonRJYPvIHyfzSw9VXI6Xl
 w2OO/GoiQROiZbtlAu9P4LD43eE9potnUioO3whbeqNcgOwt2Td/H/nUD7YpKHbKXamrBJSvU
 URizX/x/pwV+jsWp3xhkATkhnEJl11KX9eTPkgyu/OVOQ1URG33BTp+/tHOv+dccsMkiN73Bk
 4JGJNvBf0WMUEJr3su590I9tZowRCPVh2eDGEsT4smtxDb2NtHnkgurDfXQhsXE/mM4SvFgP/
 xgUY9ki7AsgefPkMce5GeAUTc8iek3qKJWwaY/icnHIuncVwBfAyPRXOO1kwmz+ZCN3qsk7fB
 UxUgfN6BjTbN6G0nKfihnB6tiAmzdprsP4wfNYZkcCJ+Puuk8Wi0/kcqz8ZEd6ID1EnrJxJZx
 7tAxiKHZMRqkIZOebZR5ctrnDBTHjMqsWILxmPywAA9e7HQE2HjmDCkovoJoug+RhXpM8606a
 7Gb1g0FAPCOV/WDVWiNl2vuEAfdf+ONowWYUxuyTKClycG2vqkh7rAJ3Q5VgZR+fQ//jtjUPh
 KOlztR9cc83M9hrlZZ+OU0rdFqbDduZgFMV2Cd0/ys5bY9KFeg0/0wM2qAXfkCXIpb+c5HT1r
 CFkStBgyKZq6Ug5HoUZv9BUU4tarHbN0lZIKRbNGb0aXrE8uAhpsS7NleR4ccf+c0VrEdCGK5
 l0DxSWowG0SI1csMZHkjRXlAPXwBjg1n+jUMrOTPlCFmStxbyqYyiwA1LzygYAZhcYACHg3BE
 oUM0WSgLeYc1U28uiNybk0l/HkJnhUwwL0ulNqbXnMBhY1v8f9ONL7kvbDF1+VmVmxai68AR5
 XuxOZlT1g5t7O4+6aEGtKgtpOrvsb+2nhtxUdNnyDIz+TrRYPU3UfZlus6QNxCrS/h5FVJojw
 SdgPxkO4J+sJSYNg/5HtbNGZevgx0EK0fxb+W3ajAMRd7x7iWH3vPiV0oPl5Y+XOay3Fej0RI
 xdTlZqMP/ab8hPm2h2FjdOGqF4QiXQT0LqHgQlcTpA4CXG/WJX1kgpItvaOOEdP869mAczhwI
 7Z2XU0L++FwoigqWkIEadQpZatriIWHqeJzZhkmV4ZwKgSxCpCKugEliMb5LJ/N/LqkF9b9iH
 X7WBqQuFuAA+5D3zO4TcBfEi+xI1L+R0b23mKBA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pgPT0Mg101M40cPI3y7QDRcPxWobiqCmi
Content-Type: multipart/mixed; boundary="3V3Qyx969TxDiafa3HNQXI3VQVCTsDpTi"

--3V3Qyx969TxDiafa3HNQXI3VQVCTsDpTi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/9 =E4=B8=8B=E5=8D=885:54, David Sterba wrote:
> On Thu, Jul 09, 2020 at 04:33:33PM +0800, Qu Wenruo wrote:
>> Since most metadata reservation calls can return -EINTR when get
>> interruped by fatal signal, we need to review the all the metadata
>> reservation call sites.
>>
>> In relocation code, the metadata reservation happens in the following
>> sites:
>> - btrfs_block_rsv_refill() in merge_reloc_root()
>>   merge_reloc_root() is a pretty critial section, we don't want get
>>   interrupted by signal, so change the flush status to
>>   BTRFS_RESERVE_FLUSH_LIMIT, so it won't get interrupted by signal.
>>   Since such change can be ENPSPC-prone, also shrink the amount of
>>   metadata to reserve a little to avoid deadly ENOSPC there.
>>
>> - btrfs_block_rsv_refill() in reserve_metadata_space()
>>   It calls with BTRFS_RESERVE_FLUSH_LIMIT, which won't get interrupred=

>>   by signal.
>=20
> This semantics of BTRFS_RESERVE_FLUSH_LIMIT regarding signals should be=

> documented, right now there's a comment but says something about avoidi=
g
> deadlocks.

For this, I tend to add one or more patches to add some comment for all
FLUSH enums, and all their callers.

I hate when some infrastructure hit me by surprise, and since ticketing
system is hidden from a lot of functions, we also need to mention that
-EINTR case.

Thanks,
Qu

>=20
>> - btrfs_block_rsv_refill() in prepare_to_relocate()
>> - btrfs_block_rsv_add() in prepare_to_relocate()
>> - btrfs_block_rsv_refill() in relocate_block_group()
>> - btrfs_delalloc_reserve_metadata() in relocate_file_extent_cluster()
>> - btrfs_start_transaction() in relocate_block_group()
>> - btrfs_start_transaction() in create_reloc_inode()
>>   Can be interruped by fatal signal and we can handle it easily.
>>   For these call sites, just catch the -EINTR value in btrfs_balance()=

>>   and count them as canceled.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/relocation.c | 13 +++++++++++--
>>  fs/btrfs/volumes.c    |  2 +-
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 2b869fb2e62c..23914edd4710 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -1686,12 +1686,21 @@ static noinline_for_stack int merge_reloc_root=
(struct reloc_control *rc,
>>  		btrfs_unlock_up_safe(path, 0);
>>  	}
>> =20
>> -	min_reserved =3D fs_info->nodesize * (BTRFS_MAX_LEVEL - 1) * 2;
>> +	/*
>> +	 * In merge_reloc_root(), we modify the upper level pointer to swap
>> +	 * the tree blocks between reloc tree and subvolume tree.
>> +	 * Thus for tree block COW, we COW at most from level 1 to root leve=
l
>> +	 * for each tree.
>> +	 *
>> +	 * Thus the needed metadata space is at most root_level * nodesize,
>> +	 * and * 2 since we have two trees to COW.
>> +	 */
>> +	min_reserved =3D fs_info->nodesize * btrfs_root_level(root_item) * 2=
;
>>  	memset(&next_key, 0, sizeof(next_key));
>> =20
>>  	while (1) {
>>  		ret =3D btrfs_block_rsv_refill(root, rc->block_rsv, min_reserved,
>> -					     BTRFS_RESERVE_FLUSH_ALL);
>> +					     BTRFS_RESERVE_FLUSH_LIMIT);
>>  		if (ret) {
>>  			err =3D ret;
>>  			goto out;
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index aabc6c922e04..d60df30bdc47 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4135,7 +4135,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,=

>>  	mutex_lock(&fs_info->balance_mutex);
>>  	if (ret =3D=3D -ECANCELED && atomic_read(&fs_info->balance_pause_req=
))
>>  		btrfs_info(fs_info, "balance: paused");
>> -	else if (ret =3D=3D -ECANCELED && atomic_read(&fs_info->balance_canc=
el_req))
>> +	else if (ret =3D=3D -ECANCELED  || ret =3D=3D -EINTR)
>=20
> Why do you remove atomic_read(&fs_info->balance_cancel_req) ?
>=20
>>  		btrfs_info(fs_info, "balance: canceled");
>=20
> I'm not sure if it would be useful to print the reason, like
>=20
> - 'canceled: user request'
> - 'canceled: interrupted'
>=20
>>  	else
>>  		btrfs_info(fs_info, "balance: ended with status: %d", ret);
>> --=20
>> 2.27.0


--3V3Qyx969TxDiafa3HNQXI3VQVCTsDpTi--

--pgPT0Mg101M40cPI3y7QDRcPxWobiqCmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8G9ZMACgkQwj2R86El
/qjhPgf9Hp+qw58b22qqAV4lkTXTN1+oxjrApSYVMXGwpPiORzOc2td1BE84L1fk
DWSx9cUkIK8GHM7KaUd82/BtY9+birl4SPJbXj5wY944LaEwdJFqzJuh+ny3Rxj5
aHV6kWUwDqpIjlhk5hOI5NHITjFWlWrbsk0HoH4KNaBa0ZRR4w/Wn43XQ8Th9HyR
vN01LwQtIBcfjkUipfYu/IsfTlAgG1YOfP3NSqSR/VU8AHlnfuJfoaCw8rI2IyJS
xTbkt+EtipWlEJzO3gm+O955a5ArsDYUjsW6wRRxPvPYD3PIgrAxwp8NXiX+Mru9
QC0PBQI+urRzEdMRPRZgf8SAhgrSHw==
=hb8c
-----END PGP SIGNATURE-----

--pgPT0Mg101M40cPI3y7QDRcPxWobiqCmi--

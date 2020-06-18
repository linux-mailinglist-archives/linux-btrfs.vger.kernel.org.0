Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DEF1FF117
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 14:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgFRMAh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 08:00:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:37857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgFRMAf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 08:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592481626;
        bh=U5v9fPRV+n8wI7NB31R8sYVblzrc67jzxqSPJ6wBXFA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Qe1R/xsAYPLxDq3SshToMQcmDbekwzY22p6Bb4NZO7VeGpwC+BEgeJOYdB3yReiNc
         PLdOqoTxdIZu6/oc9Y4unLEQXN1i6/zU78ycpr3DPTWhlKk2EMLAP7/26qL7rcMY2J
         0vPmY+VmSATZovrVGurANO9zPZj1VRL6ethVQtz0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zBb-1ipx2w48KR-0150Az; Thu, 18
 Jun 2020 14:00:26 +0200
Subject: Re: [PATCH v3 1/3] btrfs: add comments for check_can_nocow() and
 can_nocow_extent()
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200618074950.136553-1-wqu@suse.com>
 <20200618074950.136553-2-wqu@suse.com>
 <SN4PR0401MB3598829DD37CA07C8B130F9B9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <d3bf5a2e-7216-eaa6-e253-0004353b9e86@gmx.com>
Date:   Thu, 18 Jun 2020 20:00:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598829DD37CA07C8B130F9B9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FZzGN4dq0CguPJqQd3RNzM5rC9j7Pvzfn"
X-Provags-ID: V03:K1:XTc9jTKpqAuW/sWdUTmtcqmcQ/ORPsVwy0Lfx9RKi6XEeiyZcv+
 LVTNanItTQyzuBuMhcKQROIv6X1P+VJIeSFQftsjhTDXo9k22ChEIAnF7v8yB5U3wJMfXJU
 WR8VI8Frjbs+TXm7OA8P687UaWybyAoBqLQT2NgRWDga6p5uBFxXQgVk9HctQ+zSVX7Ngj4
 MxiclBmNFluKNZ2SGkxKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vOsk7xdVLn0=:i6SQuwsr51BQnbK9RGkDCa
 IOBFKbkLuINT0gwXFDHn14B6MYcMA2GCwODlBGu4EtfT2yezYwgYDKfJW8VdmpGXEqw1wEiTZ
 1ZRYk1JyVdpYL1S4F9tamWAbd8ujUYavAP+mrCrv0RxCOre+gyu1zFEKH4lcLquTHkBnom5TP
 Eh0dU9XIvkt85aNTD/vuokS/FPmvTUboCguxlLMzc25SKiARNmVxQeFqZU/a+/tGL9PBqjumZ
 2RmSt+q7rBmvIkzOTPcuk/+E/EL07Owlrs91QoR3WuD9G4Ad/u2d9/nvGoYnbDwMEBbGGv6yu
 CGZyIzVt4Ndj6JJ0IgS2ibii7qSLJBizMREXLdBYxaplK94J/siq8eWX/IK1b6/c0guUr9Otj
 s08QWk3By56tZ1aiQetdHkM+yPjVwreH7m5ryTgUtzWh7fktYtAo8SNBS1qm/N57xutSmzLBv
 a7CIFgFVUD13CaYYSNANsdrTi7SmryjFiAR/1Nnc1U2M5jK96KhJa1bMFJ2ZZpN24rNKFWnT7
 Yv6yqqyMRfmfWCHtvmhqmTprlVBcD9qRWdRdZ3VX3m9fk8yn7bD33mH522eu47Pkjwq4Wl1+N
 bAXq5a71IW7FOwFtzo6YeVE9Kf/LMpk2RLTYuZQ7/GxNk1gjUi5vqNkIyJdVevS59fmPwYfYs
 rQreZwWAPHQANVria8F309XlSDXOB5KBHH17OOzD22W2L8rARZ2o1gBICY8Z+/kCNLzKyCE1k
 BiaGfL58DaNPWFnsK73PuLV33Nk8EXdfyV816g5iT1PtjaL6wB4hu9EcwuSCbr3/8bJPscx6W
 AmvlTANN6eYgUGY97cnKKqUAnuiRzs6F3fGNwQLfYBwrUiBg98jFW3d4seF7qE2ngcLmqgwic
 8ednFNPFww7HcgOhU4kb3Ot1dQ4np+ZsJ7Wf9BxrPcepydWYhnYBRH+WQPmHzF3k6wy09wBgl
 c2Fu/GbeutZBbrJjAS6MCTHh1kfglShZ+lhSkA/0hum0p6bUTJ3w/fyUt9gY2jD1voUrN+dqa
 NZszICl3ZL9kAATZYtTYyzk/JCA0oj5a1lis8ITy+h7+I3KYxz23BgeJ4H6PWk0u/y6FjH6Gb
 k3v0njml/69s6wnz0m07O7rPq+uQv5gWessqQLueoGOjL9vEfe6JsG1Q/ZwFQUM3x8Y5lnBOv
 4eZn3B6YJR8WvoYzAL6WHO1iO4VRf3a3METE6SFIrd+Q7FlQxRDIPBo/mFcP29ji01OUVyqHV
 1Mg2POTD3DlaLQ6aX
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FZzGN4dq0CguPJqQd3RNzM5rC9j7Pvzfn
Content-Type: multipart/mixed; boundary="FdjruJuEVTaVjQKVdM3evktHpnsyDGxCE"

--FdjruJuEVTaVjQKVdM3evktHpnsyDGxCE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/18 =E4=B8=8B=E5=8D=887:57, Johannes Thumshirn wrote:
> On 18/06/2020 09:50, Qu Wenruo wrote:
>> These two functions have extra conditions that their callers need to
>> meet, and some not-that-common parameters used for return value.
>>
>> So adding some comments may save reviewers some time.
>=20
> These comments have a style/formatting similar to kerneldoc, can you ma=
ke
> them real kerneldoc?

Mind to give an example? It must be a coincident to match some existing
format.

Thanks,
Qu

>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/file.c  | 19 +++++++++++++++++++
>>  fs/btrfs/inode.c | 19 +++++++++++++++++--
>>  2 files changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index fccf5862cd3e..0e4f57fb2737 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -1533,6 +1533,25 @@ lock_and_cleanup_extent_if_need(struct btrfs_in=
ode *inode, struct page **pages,
>>  	return ret;
>>  }
>> =20
>> +/*
>> + * Check if we can do nocow write into the range [@pos, @pos + @write=
_bytes)
>> + *
>> + * This function will flush ordered extents in the range to ensure pr=
oper
>> + * nocow checks for (nowait =3D=3D false) case.
>> + *
>> + * Return >0 and update @write_bytes if we can do nocow write into th=
e range.
>> + * Return 0 if we can't do nocow write.
>> + * Return -EAGAIN if we can't get the needed lock, or for (nowait =3D=
=3D true) case,
>> + * there are ordered extents need to be flushed.
>> + * Return <0 for if other error happened.
>> + *
>> + * NOTE: For wait (nowait=3D=3Dfalse) calls, callers need to release =
the drew write
>> + * 	 lock of inode->root->snapshot_lock if return value > 0.
>> + *
>> + * @pos:	 File offset of the range
>> + * @write_bytes: The length of the range to check, also contains the =
nocow
>> + * 		 writable length if we can do nocow write
>> + */
>>  static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t=
 pos,
>>  				    size_t *write_bytes, bool nowait)
>>  {
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 86f7aa377da9..48e16eae7278 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -6922,8 +6922,23 @@ static struct extent_map *btrfs_new_extent_dire=
ct(struct inode *inode,
>>  }
>> =20
>>  /*
>> - * returns 1 when the nocow is safe, < 1 on error, 0 if the
>> - * block must be cow'd
>> + * Check if we can write into [@offset, @offset + @len) of @inode.
>> + *
>> + * Return >0 and update @len if we can do nocow write into [@offset, =
@offset +
>> + * @len).
>> + * Return 0 if we can't do nocow write.
>> + * Return <0 if error happened.
>> + *
>> + * NOTE: This only checks the file extents, caller is responsible to =
wait for
>> + *	 any ordered extents.
>> + *
>> + * @offset:	File offset
>> + * @len:	The length to write, will be updated to the nocow writable
>> + * 		range
>> + *
>> + * @orig_start:	(Optional) Return the original file offset of the fil=
e extent
>> + * @orig_len:	(Optional) Return the original on-disk length of the fi=
le extent
>> + * @ram_bytes:	(Optional) Return the ram_bytes of the file extent
>>   */
>>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *l=
en,
>>  			      u64 *orig_start, u64 *orig_block_len,
>>
>=20


--FdjruJuEVTaVjQKVdM3evktHpnsyDGxCE--

--FZzGN4dq0CguPJqQd3RNzM5rC9j7Pvzfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7rV1YACgkQwj2R86El
/qh8egf+LTypcTFImqqK+sAeYZy0X/DIpGaBvmOcFYwyqnhNmCTKrE+l8Qq7vzcO
eyIRxsxW+CPeD1BsVEH8IfNo4VdH8RmQ096Q1aaTagnS56SUdENYCdDlywj494+c
iUbXJE1KUIVKyOT6DGXUEc5ymoAxcWM8mddnJloSh5KvtimIGj86T8kJH/5xINr6
uWzvhP6J4PV5AjlEaFWBmnxrCyM6toEY67eq1FzJwXhaLYGhGJooZvCvfrRbfS1Y
hCYEmPRyB1+cS6b0n7nv0CqdY/Ngz3Rq5sKsCybqyGTTQ/vQV2xk30yAa0jTvpJV
27Q0izsgQhfBlFLwnPXNKtu/tLUjBw==
=aoKx
-----END PGP SIGNATURE-----

--FZzGN4dq0CguPJqQd3RNzM5rC9j7Pvzfn--

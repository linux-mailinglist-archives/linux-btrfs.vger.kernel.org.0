Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3451FF147
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 14:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgFRMJa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 08:09:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:44993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgFRMJY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 08:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592482157;
        bh=ujomrHPxJfTRMsQSnXw6FF36AcSjOF0fkKmYNI3RJ3I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fSamdbHkTNwQxzM7B9I3dOs6p3MPXxnDQU8DdHi5O0TEW/URq7wfLUIfnPo1EFTLT
         Mk9jhHDmx+8bk5j/9kvwO7FkZppAWaodI/KsDDz6f3PEPpiNbXH0b8eLpAs2lvwDyz
         uTvxQf3qb4w6vn6fM3jdfzcHAILKdcnvHAJu2+rE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiPl-1jK4vJ0zpV-00U1cy; Thu, 18
 Jun 2020 14:09:16 +0200
Subject: Re: [PATCH v3 2/3] btrfs: refactor check_can_nocow() into two
 variants
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200618074950.136553-1-wqu@suse.com>
 <20200618074950.136553-3-wqu@suse.com>
 <SN4PR0401MB35988624F5193F3102ADB1579B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <de3bdf98-0786-7c28-9ce2-1a9df889a213@gmx.com>
Date:   Thu, 18 Jun 2020 20:09:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35988624F5193F3102ADB1579B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ntq8vxrkLH0unP0X4Kay6iJOtNIaKta19"
X-Provags-ID: V03:K1:DnB5PRJh0OZtXyUKBb/xZw8tvyeByyEg1cnVOr1wvmV76eQwxFC
 vY+Pwko6GBCuIIlllgj1jFa7l27tmBm+OVWSyr0M/eLkYWb2upze3v4ZkdpvxVHfEEKm2RC
 3Ip7zFEM0q3QHR+X/S1G4UWgpEfNnd5KQ/QYe6AQ1p4Sc7Ip0iuDVZb7jCsNFYn6kzz9vUi
 KbpEi79q6EwUIXgdSANfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ZoEQSgGkhA=:zREF1HOk/kGMlP5MzRWGHs
 Re9UKNzvxJ1imccFyoC28KFMkeg4lkAdoBIrOk/Cb1DJbWoWN6aO59dzhiJt2yM4N3pWNfmfS
 kUsl5ADLM/sp9UAtFYf0eT6Am7Tb+xWuBqpxrLURdgb6mIjRDJqMr6fmY1r1AiGOzo3YAmoF8
 VqP6XQxblgjIOWPXyWUciY8HEPISA3cyZ9ewuFyaP3BzT3PMAoj7PXkf57Oht73V9hhsZTF1W
 x7Tt7CMwcruQUIWGrwP5Jx8C54R3L/Snhem1IJUBuTmPwFqt63+Z8h6gfSE2EfAbXPy1BeCsz
 Zhki4uSO1Mlc+0Sj4ww96fS01DnQdtS6B5VzWYa6/8FbGfEdSGny2OGw1oR1CFhryRxP+xEoJ
 lYcd0QQwB02D6NFZ9IQ5eGWfRbUL7HzqOUTCUgfBeU/JQdShj+o6epp9vskQfJznTYF9Yf7fz
 Pvi/g9dBhgri9HUisT6K0gWVJMo9dncBndrZ3ab/cHSdoczaN9cPCVoc0jKCZSmKPAUSMQoNK
 0/Qc9Oz5fRHeMx3kKIHf0uTOlFk2ypJXkb2UsVv+7PMcMYj8vbjM1eFO5+iAfcJXG8ZgJ9PSG
 ppoTOPRS+XLRUc6tnH3TORejplDpxjW5OtaGSVTkOG6qd1mclbkB8kIi1/g/LWpURGjPTJl70
 jF8EUxUC68gT4d3nukwxXp0aiC8udx8qxio5bkeFYoChAPxL31mO+Lrw5L11xaS9nS6WQ6kMk
 Q93ejXXpEOi5Ck9dELQAQ6IJtIVvLg4Hz6eJqKgDthKf1qy+Kux2p0vDiq7WUN+ghFgKLrvQX
 LP/4YQ4yAc8dhtmdgtyBSjTDt1zjfoUWQGfpjoXIvkAdZPi/j4S03om7+dw2SKeTLwgIDuO0N
 ImzJLctR9Vxw8sgK1Z3DrmFcX3ZDY75oxEH/dBZNrL7ikFDwtUviUQ2y6G4MoBueYeVOxOsMs
 FbotuGrAHQStRL4J5UFvFlww0AbY1HChcXDIIaOcpjEWJ9MxXmbgRScUhieQTbu5mtWtgA5Ni
 3bt0GxXFCqenoEoQ4XwnUiI2wT9uetPZYHYf1w4JUoa3kFSjdCIFCqeiOD9yepMp3h3Y8OoJN
 oT+nswGzv3WApU9XBccPw9LGJ7Yy/4XFOzS+u5/v6ipgRuntbmJJLhf6Aj1G9Vgtn1VNR6T5p
 Atdeq76mWK6Theqf5TAv7UY0P4CSYkzLdZw9AmyuGhm0I7NMaIVB+o1RKVgIId4hz3FEH3HPO
 Wu38FFfbcKCa8EkMD
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ntq8vxrkLH0unP0X4Kay6iJOtNIaKta19
Content-Type: multipart/mixed; boundary="WoEud6HUE0CzozomdARiCtQgoFb7o6SLP"

--WoEud6HUE0CzozomdARiCtQgoFb7o6SLP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/18 =E4=B8=8B=E5=8D=888:05, Johannes Thumshirn wrote:
> On 18/06/2020 09:50, Qu Wenruo wrote:
>> The function check_can_nocow() now has two completely different call
>> patterns.
>> For nowait variant, callers don't need to do any cleanup.
>> While for wait variant, callers need to release the lock if they can d=
o
>> nocow write.
>>
>> This is somehow confusing, and will be a problem if check_can_nocow()
>> get exported.
>>
>> So this patch will separate the different patterns into different
>> functions.
>> For nowait variant, the function will be called try_nocow_check().
>> For wait variant, the function pair will be start_nocow_check() and
>> end_nocow_check().
>=20
> I find that try_ naming uneasy. If you take the example from locking=20
> for instance, after a successful mutex_trylock() you still need to call=

> mutex_unlock().

Yep, I have the same concern, although no good alternative naming.
>=20
> Maybe star_nowcow_check_unlocked() or start_nowcow_check_nowait() [thou=
gh
> the latter could imply it's putting things on a waitqueue]=20

unlocked() looks better.

Will wait for some other suggestions.

Thanks,
Qu

>=20
>>
>> Also, adds btrfs_assert_drew_write_locked() for end_nocow_check() to
>> detected unpaired calls.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/file.c    | 71 ++++++++++++++++++++++++++++-----------------=
-
>>  fs/btrfs/locking.h | 13 +++++++++
>>  2 files changed, 57 insertions(+), 27 deletions(-)
>>
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index 0e4f57fb2737..7c904e41c5b6 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -1533,27 +1533,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_in=
ode *inode, struct page **pages,
>>  	return ret;
>>  }
>> =20
>> -/*
>> - * Check if we can do nocow write into the range [@pos, @pos + @write=
_bytes)
>> - *
>> - * This function will flush ordered extents in the range to ensure pr=
oper
>> - * nocow checks for (nowait =3D=3D false) case.
>> - *
>> - * Return >0 and update @write_bytes if we can do nocow write into th=
e range.
>> - * Return 0 if we can't do nocow write.
>> - * Return -EAGAIN if we can't get the needed lock, or for (nowait =3D=
=3D true) case,
>> - * there are ordered extents need to be flushed.
>> - * Return <0 for if other error happened.
>> - *
>> - * NOTE: For wait (nowait=3D=3Dfalse) calls, callers need to release =
the drew write
>> - * 	 lock of inode->root->snapshot_lock if return value > 0.
>> - *
>> - * @pos:	 File offset of the range
>> - * @write_bytes: The length of the range to check, also contains the =
nocow
>> - * 		 writable length if we can do nocow write
>> - */
>> -static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t=
 pos,
>> -				    size_t *write_bytes, bool nowait)
>> +static noinline int __check_can_nocow(struct btrfs_inode *inode, loff=
_t pos,
>> +				      size_t *write_bytes, bool nowait)
>>  {
>>  	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>  	struct btrfs_root *root =3D inode->root;
>> @@ -1603,6 +1584,43 @@ static noinline int check_can_nocow(struct btrf=
s_inode *inode, loff_t pos,
>>  	return ret;
>>  }
>> =20
>> +/*
>> + * Check if we can do nocow write into the range [@pos, @pos + @write=
_bytes)
>> + *
>> + * The start_nocow_check() version will flush ordered extents before =
checking,
>> + * and needs end_nocow_check() calls if we can do nocow writes.
>> + *
>> + * While try_nocow_check() version won't do any sleep or hold any loc=
k, thus
>> + * no need to call end_nocow_check().
>> + *
>> + * Return >0 and update @write_bytes if we can do nocow write into th=
e range.
>> + * Return 0 if we can't do nocow write.
>> + * Return -EAGAIN if we can't get the needed lock, or there are order=
ed extents
>> + * needs to be flushed.
>> + * Return <0 for if other error happened.
>> + *
>> + * @pos:	 File offset of the range
>> + * @write_bytes: The length of the range to check, also contains the =
nocow
>> + * 		 writable length if we can do nocow write
>> + */
>> +static int start_nocow_check(struct btrfs_inode *inode, loff_t pos,
>> +			     size_t *write_bytes)
>> +{
>> +	return __check_can_nocow(inode, pos, write_bytes, false);
>> +}
>> +
>> +static int try_nocow_check(struct btrfs_inode *inode, loff_t pos,
>> +			   size_t *write_bytes)
>> +{
>> +	return __check_can_nocow(inode, pos, write_bytes, true);
>> +}
>> +
>> +static void end_nocow_check(struct btrfs_inode *inode)
>> +{
>> +	btrfs_assert_drew_write_locked(&inode->root->snapshot_lock);
>> +	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
>> +}
>> +
>>  static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>>  					       struct iov_iter *i)
>>  {
>> @@ -1668,8 +1686,8 @@ static noinline ssize_t btrfs_buffered_write(str=
uct kiocb *iocb,
>>  		if (ret < 0) {
>>  			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>>  						      BTRFS_INODE_PREALLOC)) &&
>> -			    check_can_nocow(BTRFS_I(inode), pos,
>> -					    &write_bytes, false) > 0) {
>> +			    start_nocow_check(BTRFS_I(inode), pos,
>> +				    	      &write_bytes) > 0) {
>>  				/*
>>  				 * For nodata cow case, no need to reserve
>>  				 * data space.
>> @@ -1802,7 +1820,7 @@ static noinline ssize_t btrfs_buffered_write(str=
uct kiocb *iocb,
>> =20
>>  		release_bytes =3D 0;
>>  		if (only_release_metadata)
>> -			btrfs_drew_write_unlock(&root->snapshot_lock);
>> +			end_nocow_check(BTRFS_I(inode));
>> =20
>>  		if (only_release_metadata && copied > 0) {
>>  			lockstart =3D round_down(pos,
>> @@ -1829,7 +1847,7 @@ static noinline ssize_t btrfs_buffered_write(str=
uct kiocb *iocb,
>> =20
>>  	if (release_bytes) {
>>  		if (only_release_metadata) {
>> -			btrfs_drew_write_unlock(&root->snapshot_lock);
>> +			end_nocow_check(BTRFS_I(inode));
>>  			btrfs_delalloc_release_metadata(BTRFS_I(inode),
>>  					release_bytes, true);
>>  		} else {
>> @@ -1946,8 +1964,7 @@ static ssize_t btrfs_file_write_iter(struct kioc=
b *iocb,
>>  		 */
>>  		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>>  					      BTRFS_INODE_PREALLOC)) ||
>> -		    check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes,
>> -				    true) <=3D 0) {
>> +		    try_nocow_check(BTRFS_I(inode), pos, &nocow_bytes) <=3D 0) {
>>  			inode_unlock(inode);
>>  			return -EAGAIN;
>>  		}
>> diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
>> index d715846c10b8..28995fccafde 100644
>> --- a/fs/btrfs/locking.h
>> +++ b/fs/btrfs/locking.h
>> @@ -68,4 +68,17 @@ void btrfs_drew_write_unlock(struct btrfs_drew_lock=
 *lock);
>>  void btrfs_drew_read_lock(struct btrfs_drew_lock *lock);
>>  void btrfs_drew_read_unlock(struct btrfs_drew_lock *lock);
>> =20
>> +#ifdef CONFIG_BTRFS_DEBUG
>> +static inline void btrfs_assert_drew_write_locked(struct btrfs_drew_l=
ock *lock)
>> +{
>> +	/* If there are readers, we're definitely not write locked */
>> +	BUG_ON(atomic_read(&lock->readers));
>> +	/* We should hold one percpu count, thus the value shouldn't be zero=
 */
>> +	BUG_ON(percpu_counter_sum(&lock->writers) <=3D 0);
>> +}
>> +#else
>> +static inline void btrfs_assert_drew_write_locked(struct btrfs_drew_l=
ock *lock)
>> +{
>> +}
>> +#endif
>>  #endif
>>
>=20


--WoEud6HUE0CzozomdARiCtQgoFb7o6SLP--

--Ntq8vxrkLH0unP0X4Kay6iJOtNIaKta19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7rWWgACgkQwj2R86El
/qgomwf+Osqzx2rMWkqTfeqF4cbQdfsM40XsSlc4fuqUgARu4XZzjoZGE0ZhAqkw
ECcTVEdsBzvzLALIBNSCItXHHaeuNirc/U71BqiySpubqm0JYor3GAdQ7Wc8Wb3e
hSiu9xflUlS3Igbi82BkNGIeZ4Gx30N9sEL89AsWAUZIEtpgdhrH6ThyURcsi24u
C07LQ02LDMlQseZTOC6XCWmL6YtjQ6GERT4cxrwXRML6564u4k1SDcET4hIXrUXH
J/VI3WvV6rdDkI4M2V5kbCLSuy9xEtjK2yM+jHgHPt16PGvzpAz43N/Lj8c46OLh
dtHNbdNsxsrxYxTDDfr4SMmZghcrrg==
=U6Bw
-----END PGP SIGNATURE-----

--Ntq8vxrkLH0unP0X4Kay6iJOtNIaKta19--

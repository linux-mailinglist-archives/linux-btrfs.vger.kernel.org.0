Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9BF26E971
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 01:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIQX0T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 19:26:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:33511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgIQX0T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 19:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600385173;
        bh=Nhqp7ERtN5nlI0uYDFWahM1BP2jMWzGw+jdeLGOgTSg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OrKAMJqENx1sjbS6DjE7wCqrk/Zdzx6gzqhXEcxizM3dnIv7o4e+NX+fDgKu+2pYU
         OnJz81lnZIF6dpV8sQ67MgsdEgIqvfkWHdqseZqcXqIoI/mw4ugwtMSk1530E+p7UF
         LHVh0PMlwi/mQI1z6mYyORDbCrNTIRRse87dyrLI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSc1B-1juUAf3QGv-00Sykd; Fri, 18
 Sep 2020 01:26:13 +0200
Subject: Re: [PATCH v2 04/19] btrfs: remove the open-code to read disk-key
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-5-wqu@suse.com> <20200916160115.GN1791@twin.jikos.cz>
 <e5a6d6a4-93b7-9845-5448-ac56ecf97075@gmx.com>
 <20200917123738.GR1791@twin.jikos.cz>
 <b6f59a13-0572-01dc-656f-09f1b5eb7935@gmx.com>
 <20200917224151.GB6756@twin.jikos.cz>
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
Message-ID: <8fd473a5-beed-ae2c-37a3-19a4bbc91ac0@gmx.com>
Date:   Fri, 18 Sep 2020 07:26:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917224151.GB6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0VnVglTLBfANeu8PFkejQ4GRXTgjUDm2b"
X-Provags-ID: V03:K1:9vGl/0SWrd7M5DHVbWZ6gdUnKk7Gu4lfCFfBmY7nAh97s2mFvBd
 t5AziahEDVqsIUSz739O9Yr0+AiMLF77Z3qoZJ5XZI6tFgqdIe1CGIJnxFpK0XZ7pgYbhCl
 qf8rJXueaRImkpmJFRZ21+GvrF5+fno7qSX4OOauisocJhcZkTGQhvVGPVLKpOyYazW/Uwp
 ZvdAy2c1dhpxXoWLBRP1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K69ZZOWsMrs=:t384DMn+oaoL3k645sO68Z
 X/ytsipoNE2KExXF93TSltPIBC2uTdxPgjTNuaCVl6XtKHXXoFIxCFlc+1iOXaqzHXzBVOR6J
 hYAAyS7BNiZjWUEi8yUHKrqg1Jq7kbQJsz/df9fTOuOe2wKcEwArIsJy69c6m5uriA6ERMX68
 nGkacCWSiIelMQpc1FDxyYsy/zUbvj4kVDDFsbIJSUx0L74Tuxp+Jho86GloZphq35T6kmGgV
 BWSsYUGh7e3tSGc6JcoUUKe4K0lYPRlSyXS1ODy/BiG178VmT7NeCkDhbF1o+LpmsCxYp/Su8
 X/t9MfuReBDGe3n/jlJKH+axzcJH3NFOPqmkJ4O+M0z5WlKXMb+j2NESXvyZkrSHe6OaasrXb
 kFSi6rdXwmp7Qkyk8z0AuT9ZEE8YSjyn73gkAbMNS2Yb+ZrltufBu5iycDQA4sDKpKrBn3Ssu
 zNA5jOLLNFtFNt+ROfIqM5LKWKnR3CrAjV4TaYpWE9NePNYXqwCrah+r6xrWqqBev6u3E1f75
 QRqYb/B2nKlAQ0JCC5l2tDL/b9tqeZgXeBjxf6Wd5R7EnMsItBYvWCb5HSbluR+yxpSwlqyfW
 qSX3533OlQ/5VivaDp2nLulGaTRcmKyDCm2RQVnoIUH9lALBoNxDqgd63XvjBGT3o/HE0KIZj
 U4NxpV33jWO3FVz/U9VyTZlorKK/cCFk1/LdLeeytFILuy0H2O6fz2Y1yWUsytx0pkkaOo109
 xzRlmiUPTc2dFybhJSlyAeprSsLqitEiaiGPVm3M2tSYBlpgBiEE2GnasoRW8SbuJqigFj4UZ
 Zwe2T6gijZa16e03w4VDVabx9983ZjvgTEXTgI9Mo+S0x6myLPr817p1JRNRD2hPPe1LcJug9
 zkwxN1O8hBBtEDLWOaJaV1rpCrwUrDqDLuKNegFWSYQcL6kPa+TkgV63VIj68XSkkBZBlIOLz
 61/E6TstdDczYL59VWG7ywFdjcJ7SIwb3JU1bUJSmNTHBdGVMOKDTt0lsm1NZaaPFZDO+PvKu
 ZhtnBe1u64OivbOgeLYsmRlzTOLrZ4B2DY7c5AD2CmGI4CA93ueqxYaEn2GPn7EOtIJgyhDtR
 XT/L5UmsKiPCeL8iZtIs2z7XX96eiAxu4NTU+sFzUUqPQE4HqWF1Dy1MMvYX4bIjNXz6ouOQ7
 8lLFSWlpOCEBXBES7CVdvOSoJNz6G4JZw4UEY5QzPiOSRS9aQ5VoAom67x5PUlq21K5jKqbo8
 e45R3cJ0F8FQnaEVK7kFXflTnUGQtj5Cm/aHfiA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0VnVglTLBfANeu8PFkejQ4GRXTgjUDm2b
Content-Type: multipart/mixed; boundary="5INJKKzMaExjHaOZPdMJKEuPSB90rhyaF"

--5INJKKzMaExjHaOZPdMJKEuPSB90rhyaF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/18 =E4=B8=8A=E5=8D=886:41, David Sterba wrote:
> On Thu, Sep 17, 2020 at 09:15:31PM +0800, Qu Wenruo wrote:
>> Then to me, the better solution is to make read_extent_buffer() to be
>> split into two part.
>>
>> Part 1 to handle the same page read, which should be made inline.
>> The part 1 should be small enough, as it only involves the in-page
>> offset calculation, which is also already done in current
>> generic_bin_search.
>=20
> Sounds easy, the result is awful. The inlined part 1 is not that small
> and explodes for each call of read_extent_buffer. Explodes in code size=
,
> increases stack consumption of all callers.
>=20
>> Then part 2 to handle the cross page case, and that part can be a
>> function call.
>>
>> Personally speaking, even generic_bin_search() is a hot-path, I still
>> don't believe it's worthy, as read_extent_buffer() itself is also
>> frequently called in other locations, and I never see a special handli=
ng
>> for it in any other location.
>=20
> The usage pattern is different, many other location calls
> read_extent_buffer just once to read some data and process. There are
> very few functions that call it in a loop.
>=20
> OTOH, bin_search jumps over the sorted array of node keys, it does not
> even have to read the actual key for comparison because it understands
> the on-disk key and just sets the pointer. Calling read_extent_buffer
> for each of them will just waste cycles copying it to the tmp variable.=

>=20
>> Anyway, I will use the get_eb_page_offset()/get_eb_page_index() macros=

>> here first, or subpage will be completely screwed.
>>
>> And then try to use that two-part solution for read_extent_buffer().
>=20
> Some numbers from a release build, patch below:
>=20
> object size:
>=20
>    text    data     bss     dec     hex filename
> 1099317   17972   14912 1132201  1146a9 pre/btrfs.ko
> 1165930   17972   14912 1198814  124ade post/btrfs.ko
>=20
> DELTA: +66613
>=20
> Stack usage meter:
>=20
> send_clone                                                        +16 (=
128 -> 144)
> btree_readpage_end_io_hook                                        +40 (=
168 -> 208)
> btrfs_lookup_csum                                                  +8 (=
104 -> 112)
> find_free_dev_extent_start                                         +8 (=
144 -> 152)
> __btrfs_commit_inode_delayed_items                                 +8 (=
168 -> 176)
> btrfs_exclude_logged_extents                                       +8 (=
72 -> 80)
> btrfs_set_inode_index                                             +16 (=
88 -> 104)
> btrfs_shrink_device                                                +8 (=
160 -> 168)
> find_parent_nodes                                                  -8 (=
312 -> 304)
> __add_to_free_space_tree                                          +16 (=
112 -> 128)
> btrfs_truncate_inode_items                                         -8 (=
360 -> 352)
> ref_get_fields                                                    +16 (=
48 -> 64)
> btrfs_qgroup_trace_leaf_items                                      +8 (=
80 -> 88)
> did_create_dir                                                     +8 (=
112 -> 120)
> free_space_next_bitmap                                            +32 (=
56 -> 88)
> btrfs_lookup_bio_sums                                             +24 (=
216 -> 240)
> btrfs_read_qgroup_config                                           +8 (=
120 -> 128)
> btrfs_check_ref_name_override                                     +16 (=
152 -> 168)
> btrfs_uuid_tree_iterate                                            +8 (=
128 -> 136)
> log_dir_items                                                     +16 (=
160 -> 176)
> btrfs_ioctl_send                                                  +16 (=
216 -> 232)
> btrfs_get_parent                                                  +16 (=
80 -> 96)
> __btrfs_inc_extent_ref                                             +8 (=
128 -> 136)
> btrfs_unlink_subvol                                               +16 (=
144 -> 160)
> btrfs_del_csums                                                    +8 (=
184 -> 192)
> btrfs_mount                                                       -16 (=
184 -> 168)
> generic_bin_search                                                 +8 (=
104 -> 112)
> btrfs_uuid_tree_add                                               +16 (=
128 -> 144)
> free_space_test_bit                                                +8 (=
72 -> 80)
> btrfs_init_dev_stats                                              +16 (=
160 -> 176)
> btrfs_read_chunk_tree                                             +48 (=
208 -> 256)
> process_all_refs                                                  +16 (=
104 -> 120)
> ... and this goes on
>=20
> LOST (80):
>         btrfs_ioctl_setflags                                       80
>=20
> NEW (208):
>         __read_extent_buffer                                       24
>         get_order                                                   8
>         btrfs_search_path_in_tree_user                            176
> LOST/NEW DELTA:     +128
> PRE/POST DELTA:    +1944
>=20
> ---
>=20
> Here's the patch. I'm now quite sure we don't want to split
> read_extent_buffer and keep the bin_search optimization as is.

Fine, I'll change the patch to use get_eb_page_offset/index() in
generic_bin_search().

>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index afac70ef0cc5..77c1df5771bf 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5584,7 +5584,7 @@ int read_extent_buffer_pages(struct extent_buffer=
 *eb, int wait, int mirror_num)
>  	return ret;
>  }
> =20
> -static bool report_eb_range(const struct extent_buffer *eb, unsigned l=
ong start,
> +bool report_eb_range(const struct extent_buffer *eb, unsigned long sta=
rt,
>  			    unsigned long len)
>  {
>  	btrfs_warn(eb->fs_info,
> @@ -5595,45 +5595,17 @@ static bool report_eb_range(const struct extent=
_buffer *eb, unsigned long start,
>  	return true;
>  }
> =20
> -/*
> - * Check if the [start, start + len) range is valid before reading/wri=
ting
> - * the eb.
> - * NOTE: @start and @len are offset inside the eb, not logical address=
=2E
> - *
> - * Caller should not touch the dst/src memory if this function returns=
 error.
> - */
> -static inline int check_eb_range(const struct extent_buffer *eb,
> -				 unsigned long start, unsigned long len)
> -{
> -	unsigned long offset;
> -
> -	/* start, start + len should not go beyond eb->len nor overflow */
> -	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->=
len))
> -		return report_eb_range(eb, start, len);
> -
> -	return false;
> -}
> -
> -void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
> +void __read_extent_buffer(const struct extent_buffer *eb, void *dstv,
>  			unsigned long start, unsigned long len)
>  {
> -	size_t cur;
> -	size_t offset;
> -	struct page *page;
> -	char *kaddr;
> +	unsigned long offset =3D offset_in_page(start);
>  	char *dst =3D (char *)dstv;
>  	unsigned long i =3D start >> PAGE_SHIFT;
> =20
> -	if (check_eb_range(eb, start, len))
> -		return;
> -
> -	offset =3D offset_in_page(start);
> -
>  	while (len > 0) {
> -		page =3D eb->pages[i];
> +		const char *kaddr =3D page_address(eb->pages[i]);
> +		size_t cur =3D min(len, (PAGE_SIZE - offset));
> =20
> -		cur =3D min(len, (PAGE_SIZE - offset));
> -		kaddr =3D page_address(page);
>  		memcpy(dst, kaddr + offset, cur);
> =20
>  		dst +=3D cur;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 3bbc25b816ea..7ea53794f927 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -241,9 +241,57 @@ static inline int extent_buffer_uptodate(const str=
uct extent_buffer *eb)
> =20
>  int memcmp_extent_buffer(const struct extent_buffer *eb, const void *p=
trv,
>  			 unsigned long start, unsigned long len);
> +/* NEW */
> +
> +bool report_eb_range(const struct extent_buffer *eb, unsigned long sta=
rt,
> +			    unsigned long len);
> +void __read_extent_buffer(const struct extent_buffer *eb, void *dst,
> +			unsigned long start,
> +			unsigned long len);
> +/*
> + * Check if the [start, start + len) range is valid before reading/wri=
ting
> + * the eb.
> + * NOTE: @start and @len are offset inside the eb, not logical address=
=2E
> + *
> + * Caller should not touch the dst/src memory if this function returns=
 error.
> + */
> +static inline int check_eb_range(const struct extent_buffer *eb,
> +				 unsigned long start, unsigned long len)
> +{
> +	unsigned long offset;
> +
> +	/* start, start + len should not go beyond eb->len nor overflow */
> +	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->=
len))
> +		return report_eb_range(eb, start, len);
> +
> +	return false;
> +}
> +
> +static inline void read_extent_buffer(const struct extent_buffer *eb, =
void *dstv,
> +				      unsigned long start, unsigned long len)
> +{
> +	const unsigned long oip =3D offset_in_page(start);
> +
> +	if (check_eb_range(eb, start, len))
> +		return;
> +
> +	if (likely(oip + len <=3D PAGE_SIZE)) {
> +		const unsigned long idx =3D start >> PAGE_SHIFT;
> +		const char *kaddr =3D page_address(eb->pages[idx]);
> +
> +		memcpy(dstv, kaddr + oip, len);
> +		return;
> +	}
> +
> +	__read_extent_buffer(eb, dstv, start, len);
> +}
> +
> +/* END */
> +/*
>  void read_extent_buffer(const struct extent_buffer *eb, void *dst,
>  			unsigned long start,
>  			unsigned long len);
> +*/
>  int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,=

>  				       void __user *dst, unsigned long start,
>  				       unsigned long len);
>=20


--5INJKKzMaExjHaOZPdMJKEuPSB90rhyaF--

--0VnVglTLBfANeu8PFkejQ4GRXTgjUDm2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9j8JEACgkQwj2R86El
/qiJewf+O+MbvOBUeCwGZqx6M6fnBLk6UKXW2KYLZVNP64eWodq4S7zNEDguIBM6
199fwj19kmqaO0Gk2xujtwQQFXihr/rkP6xSTw/QSfcHvgGyoEcm75gScWP0uPVD
iHL2d1tAIRddsNKZ6UmlB5LPZXvsHrBXO6deNcDDSlBChYrtnhM+J45RCQyztuKG
GTz2WV5LlG435UFuWPlm0vc5Ccqsq5BHvBuJWynGa9TSUX0DrPT8kRYUQ6jWFDsC
PQuNONEoqAdhjoxV+ydLPvf9e2D7RMhEJ0z5lNFcsks/tOiX3x/9JKWEXHRuFUY7
juLjD8RsjUUywb5c8DZZa/S/VVPYXg==
=7asB
-----END PGP SIGNATURE-----

--0VnVglTLBfANeu8PFkejQ4GRXTgjUDm2b--

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEDC178759
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 02:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbgCDBCO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 20:02:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:55061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgCDBCO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 20:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583283726;
        bh=F3IX/ogGjG1gjW3hGFUjUOsfXJ6T7GEvyojOxiTfDfs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VJ+Zk9eIspBCkASE53pqXVZgVBLvFrjyquhaZzc3mk8MyJUU9+CIvjlxVO26VasIS
         evTPxDS/rppcxNEyQEGUss7oCg7LuYtI06c5VwWxUanzGoCGlQRsQxhnOvsk0auz6M
         hhH6DaEZKyZ1lpP60cgrW2iJd/Qib39ybLOxAjvM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUosN-1j0fbb16cT-00Qi86; Wed, 04
 Mar 2020 02:02:06 +0100
Subject: Re: [PATCH v2 06/10] btrfs: relocation: Use wrapper to replace
 open-coded edge linking
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-7-wqu@suse.com> <20200303173015.GL2902@twin.jikos.cz>
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
Message-ID: <014a0721-4aa6-9062-19c8-0ec1c35b0aec@gmx.com>
Date:   Wed, 4 Mar 2020 09:02:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303173015.GL2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K7nmyHRErrF23rlmP468ZLw8X6cezxQgk"
X-Provags-ID: V03:K1:YtEbhbDfAtJBURkh/1PZxqGxEWKwoPgMDnQ7CfmZUaY8OkefX8z
 4fWDHHVtQgxIXKUYW6vU1+c6KD+XL/mNEINuwAlVWPk2ZiKH6r2LLST/Sh6ZLkjXSynpmGP
 mzam0aurbtuTMFL7g/zAe6kTN0HfLInxoU0XpYej9KKmQB0LZDNxuQN27/7jeh5l2CR/iDm
 ddy7PUPgJxH9dvZokUlAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yNJHRsJP0G8=:pM5fkzKOdHcEJT7vbWMbwi
 YVmABW4SKhkMzeMkl4SG4lPPzIuiZ9IEN2bxWAV6amw51Py45i3GyZ7YgrDSeKoqmgshx5/o+
 zXu+UHxO/tONbafWiTNQB05XjZcBOBLbqiZHDrE69bHnp3WTBrME63pTCAHSqc7r5QJeTtKqg
 PxAGugN122Yv2PEJwoVKm0Ztv7L/K9dq30Cdny4HjLXc4L18Z3PdKN+Agqq81a1yLGU7sr4bj
 8cCct8lFJF6r59TWW3btiNwuLilsEEg9G2n8tyPrrZUlNo0f9hL/gt06+pJNAecZR7roFfB+4
 LZAqnM1EPcTzmTRFaU6omH0wK8QqgNJSIbZZCvWGy9oQT9R0TWsMbkQtK7cpmOE6/EMa9RVeh
 64dc/k1QAavxXWxgjzVaLg7vqUOeOGxIjZsWwmJO7Z1iuoUKL0xGBst7gVTOpU9XcZ9Fg5bJG
 eGFm+7e83qyNaGCLfFhP4R6SaeyW86T3+MSv6/79h5eG8gmCJ4p281z68o1ujEObqd73eIckB
 Ns5QR1z6FICDuAMCUfB/+ulWYrPCfp27PaCNIqMG4ZhnXjgv4jdlFwBn3WvvSg4/NvNw0sasK
 awcevX4wZpCSsE7GKHf2HgRJXhLAG1MBBZ7zCFxNabyUKJG55nJwbz9mlF2mDcSw0kxr17rLT
 kqHevFxPDOkdLd8BelZZfWzT1QiSZJ6cTI51HIQnBgDhQSj3EmXXERnuiS8v2ekjAaqUYFLVk
 xyEcWAN+dEhNFEt+cOT7EL8kVRvcHztpv9bT4Ci4OmXAMRKBMWy22Fgw832ssrAzxVWHuUewt
 L8WiFxTzdqLdyvL8Zn792JRhu8+HmT0mvtZS3LNL8a/DzAO2GvaIwv/2bnDZaOeklxuGaOYok
 BI8PGkhJv1JG4lWrCyXUtYPYlUhSAkxD1dN2CJfckp/PTQeWHtFXkwAzPTnPVSB0HfosGkuHz
 8SJhsrtmhaV7w98T3gEW+AVZ6nmKFMQKOqrzaMjc01CwmsjObvHBhYKXQeWu1GNj4z/uWNwiE
 Cpsa8TuwhCK31M+c1TBYVN/npCrLpqG6ANaRjqspMmg9CejbwPSP2pUImO3gbE0Byav95LVic
 dKodmTBEu5iLNHxGur4uLa44h+mpQo49kmXhzYW2FWiAZfsqeLpHqHqqre9+rBN/Poi+WslI9
 BhHJR17pZJTwGRA9dqeig9dyhF+81SfrYy4/8g3UI4oQ1XF1ECbx79a/hfd9DjQ/r8/JZgoSN
 fKOleLhaIWmTiFE1X
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K7nmyHRErrF23rlmP468ZLw8X6cezxQgk
Content-Type: multipart/mixed; boundary="GLHdrxjw4ePDzUHsz0g45r5vgVTFbxIFw"

--GLHdrxjw4ePDzUHsz0g45r5vgVTFbxIFw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/4 =E4=B8=8A=E5=8D=881:30, David Sterba wrote:
> On Mon, Mar 02, 2020 at 05:45:49PM +0800, Qu Wenruo wrote:
>> Since backref_edge is used to connect upper and lower backref nodes, a=
nd
>> need to access both nodes, some code can look pretty nasty:
>>
>> 		list_add_tail(&edge->list[LOWER], &cur->upper);
>>
>> The above code will link @cur to the LOWER side of the edge, while bot=
h
>> "LOWER" and "upper" words show up.
>> This can sometimes be very confusing for reader to grasp.
>>
>> This patch introduce a new wrapper, link_backref_edge(), to handle the=

>> linking behavior.
>> Which also has extra ASSERT() to ensure caller won't pass wrong nodes
>> in.
>>
>> Also, this updates the comment of related lists of backref_node and
>> backref_edge, to make it more clear that each list points to what.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/relocation.c | 53 ++++++++++++++++++++++++++++++------------=
-
>>  1 file changed, 37 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 04416489d87a..c76849409c81 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -91,10 +91,12 @@ struct backref_node {
>>  	u64 owner;
>>  	/* link to pending, changed or detached list */
>>  	struct list_head list;
>> -	/* list of upper level blocks reference this block */
>> +
>> +	/* List of upper level edges, which links this node to its parent(s)=
 */
>>  	struct list_head upper;
>> -	/* list of child blocks in the cache */
>> +	/* List of lower level edges, which links this node to its child(ren=
) */
>>  	struct list_head lower;
>> +
>>  	/* NULL if this node is not tree root */
>>  	struct btrfs_root *root;
>>  	/* extent buffer got by COW the block */
>> @@ -123,17 +125,26 @@ struct backref_node {
>>  	unsigned int detached:1;
>>  };
>> =20
>> +#define LOWER	0
>> +#define UPPER	1
>> +#define RELOCATION_RESERVED_NODES	256
>>  /*
>> - * present a block pointer in the backref cache
>> + * present an edge connecting upper and lower backref nodes.
>>   */
>>  struct backref_edge {
>> +	/*
>> +	 * list[LOWER] is linked to backref_node::upper of lower level node,=

>> +	 * and list[UPPER] is linked to backref_node::lower of upper level n=
ode.
>> +	 *
>> +	 * Also, build_backref_tree() uses list[UPPER] for pending edges, be=
fore
>> +	 * linking list[UPPER] to its upper level nodes.
>> +	 */
>>  	struct list_head list[2];
>> +
>> +	/* Two related nodes */
>>  	struct backref_node *node[2];
>>  };
>> =20
>> -#define LOWER	0
>> -#define UPPER	1
>> -#define RELOCATION_RESERVED_NODES	256
>> =20
>>  struct backref_cache {
>>  	/* red black tree of all backref nodes in the cache */
>> @@ -332,6 +343,22 @@ static struct backref_edge *alloc_backref_edge(st=
ruct backref_cache *cache)
>>  	return edge;
>>  }
>> =20
>> +#define		LINK_LOWER	(1 << 0)
>> +#define		LINK_UPPER	(1 << 1)
>> +static inline void link_backref_edge(struct backref_edge *edge,
>> +				     struct backref_node *lower,
>> +				     struct backref_node *upper,
>> +				     int link_which)
>=20
> Again not a static inline, but plain static function.

Oh, I mixed my further plan with my current code...

It would be moved to backref.h, which have to be static inline.

Will remove the inline prefix in next version.

Thanks,
Qu
>=20
>> +{
>> +	ASSERT(upper && lower && upper->level =3D=3D lower->level + 1);
>> +	edge->node[LOWER] =3D lower;
>> +	edge->node[UPPER] =3D upper;
>> +	if (link_which & LINK_LOWER)
>> +		list_add_tail(&edge->list[LOWER], &lower->upper);
>> +	if (link_which & LINK_UPPER)
>> +		list_add_tail(&edge->list[UPPER], &upper->lower);
>> +}


--GLHdrxjw4ePDzUHsz0g45r5vgVTFbxIFw--

--K7nmyHRErrF23rlmP468ZLw8X6cezxQgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5e/goACgkQwj2R86El
/qhlAQf/Vc88CTsfWTUFf4sak4Rp8HNCzyqiQxw9fs8qrbvFG4g94TlxBOIFNOsg
t4L2JsVJrxuq7szbcDnZWIKb9Sq7NLrxY0nLsQ0scl23+BaeyBEQmmbwQLWA3dhe
bY+FIrZgHRTt/0HBV2ty13Hh6qRZPwjJaxqiDio23Zrys1Gg2L5vVB8G5JK9Lr0s
L3it6DfdUDbBiKI3da3GqK8pkqDAOBuIBMSicWu9nIamkvsPsdswzSW0xWuehDyP
kXJiqFHvBGssKoLY71rBkjLhYWOG3rpavUTTY3r3IioPuNSm7i85xEzm1+Lzjtmc
OpvSVWG3iwA0AskNd8Jmqwy2p8/Dbw==
=GukJ
-----END PGP SIGNATURE-----

--K7nmyHRErrF23rlmP468ZLw8X6cezxQgk--

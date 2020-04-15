Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A601A93B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 08:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393643AbgDOGxs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 02:53:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:59665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbgDOGxp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 02:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586933604;
        bh=eEP9G/pM1LGsDYltFWggATh33E4kG9DTG8C6MJ95TnE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ANGRBGP65T593hDASyrVwqSF5rBdWCsyuKxh+7X0W4g370IE4h7w7Jse3JRjvDf/R
         Jo2VVHzmpxJ1qU+Wv0OdQ2W8fsYXQflWtMuYkYZAQnY1TfW6LX3qLX5R7lNLKdj3Mq
         yUP3F/LW/8WtThfvILIp7rX376E5YhuQn9YvISNE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M89Kr-1jJwxc3KSJ-005Lj5; Wed, 15
 Apr 2020 08:53:24 +0200
Subject: Re: [PATCH v3] btrfs: Move on-disk structure definition to
 btrfs_tree.h
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200408070608.41099-1-wqu@suse.com>
 <20200414214300.GW5920@twin.jikos.cz>
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
Message-ID: <b1c240c3-8ab2-cf23-71f4-17ebe2421bb9@gmx.com>
Date:   Wed, 15 Apr 2020 14:53:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414214300.GW5920@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="P7zmd1IOjUdfXx6UDyurOSYsg2rG0tSr5"
X-Provags-ID: V03:K1:Jv7IHCZkDxiOCR1xk8Y7iARaijjwMZFQVX7HEoRENPES99nZLLq
 jYGSeNPbEjLAykVFgux8cOPqD2eu7X/ww/FiC6XKhIfwAMzfzRWuOU/dJvNfLUAyCQ4u1EU
 0jTewd+eHfcqeUcg/1aMGT3ZmCtIDDCXuDQG1Ozh4Qhvhs+7S/95+AY1qUk0z6+nmGOFJbb
 Wys6iGz6VH93bhZnkUDFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DjWf1KR4lJI=:Q86WU2ot3OW7Hxpqddbe/W
 Llel3pXL+jVgE/7vMt7omLjmUdPkDC6Fl18BBZ2oMSQaR2Drvzp8j4vwuarkI8Ox9EkileaA+
 xewZcGZghEj3+SJBo8/+O6UmQ4FDIPWyEBYAhPxGBf5cxtzAljnJjVjGkAoOImqrEOycYvxUK
 FCQTsZP112IObn9aRWYIQxvg8IBcShJWKk4T3Y486REE+ppC6kuXNyd0ydnAWJtwJXztBwD21
 q4uZyDcE3BZAjvnpV+J+OENS7kp67C5tr+KAy58oBHNJSirXUH6EQLWqHVPEjDexTMPGxYXlM
 8X6PkUF+ybuN6oEtxO4zF31yWjiVjs+2JTwAACOmlGrQdXP68bCTB8P1PQvtZUPw0kSCRhPUA
 t+dXkHiidlRbtS1Utun6zgBk1EWN5eM6Nb5FIuBDh7k3I3+iDmfvPmldBnlow3Bvp+hvk9IqD
 BK3x/d6qSfgYWclk4WIsB3O+vFmd58TWZlviRMlMmA0yftCH1clvINQZSgVphWR/ABolSnjXS
 W0wiz85AvWbgmf488rMVMESUg5Bzj4VxivYk8bPrCy8cqjNmgLgqFaa8K6bfpoQwmes0fRYHY
 S43dlLDgAl4IcW07PYrpkdoQTsjL/4gFe+IM6kLmmmTxdtDZ3NGL6ovsgjoS41Gko6wBlYT6M
 24UgchUydspStomfuZDHFA1WEw8fifrk1CsuaKn7LiS7RofTxm+BA3luv2vriaE3ydDlYzSlX
 bITpxCMF6FUdZNHDi3s+l7fpEgKonu0xqY2clkbCZ6NPuxVtN2yNDEoyNqA4ZCBu9Xp9a0FNT
 x30KWKgwYD8/z7R6IhdoMbAaIJE3NGSKn5vNOA41aCPT86NEmQBSL76C4dOEC8QCWS6tkRA4A
 75ZIhYIJk8HZOrKqraJvtpbK1G0TTedJufe0TVl3/iXzlgJ3GQ/2MPP7kSAHHN6SI/YL085bG
 LA25WDiSZEeApcujyY52tc2/jk79G1z3komziidRE+O/7caq9OWwK3r1MYGZG6+wRiOJ2pCpW
 oSZuYUqR5MrbUdqu5anMOM7C2XhaXIaqTqEIbuFoBcDKpHU+Wg0aNBHvrgfbwwFb09hn6xVSb
 ttitTj0VsEAeRGzRitkF+LkdJ850VymR0lW6T/2XX7+9PwQWs44z5u5zSEvGHGCGH3EWT2YJx
 W4zSVDTEc09i69LnI/x1/U2oSMZqYIQDGQf22uhZW9aVBh5k1KFNnA7ZvV52D5YfMb+ctZ3Fp
 csUaOPq75NZx3fSAd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P7zmd1IOjUdfXx6UDyurOSYsg2rG0tSr5
Content-Type: multipart/mixed; boundary="aStBsuOmhTcdM0gSg6QqldnUnI6XfuB0M"

--aStBsuOmhTcdM0gSg6QqldnUnI6XfuB0M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/15 =E4=B8=8A=E5=8D=885:43, David Sterba wrote:
> On Wed, Apr 08, 2020 at 03:06:08PM +0800, Qu Wenruo wrote:
>> These structures all are on-disk format. Move them to btrfs_tree.h
>>
>> This allows us to sync the header to different projects, who need to
>> read btrfs filesystem, like U-boot, grub.
>>
>> With this modification, all on-disk format is definite in btrfs_tree.h=
,
>> and can be easily synced to other projects.
>>
>> This move includes:
>> - btrfs magic
>>   It's a surprise that it's not even definied in btrfs_tree.h
>=20
> There was no need for it so far, blkid has its own definition and f_typ=
e
> in stat provides the raw bytes. I don't find it surprising :)

Since magic number is part of the super block definition, IMHO it should
be included for btrfs on-disk format.

BTW, for btrfs_tree.h, it should contain:
- All on-disk structures (Check)
- All special flags used in on-disk structures
  Like the magic in this patch, and compression algo flags are still
  missing.

>=20
>> - tree block max level
>>   Move it before btrfs_header definition.
>>
>> - tree block backref revision
>> - btrfs_header structure
>> - btrfs_root_backup structure
>> - btrfs_super_block structure
>> - BTRFS_FEATURE_* flags
>> - BTRFS_(FSID|UUID|LABEL)_SIZE macros
>> - BTRFS_MAX_METADATA_BLOCKSIZE macro
>> - BTRFS_NAME_LEN macro
>>
>> - btrfs_item structure
>> - btrfs_leaf structure
>> - btrfs_key_ptr structure
>> - btrfs_node structure
>>
>> - btrfs_dev_stat_values
>>   Since on-disk format btrfs_dev_stats_item needs it.
>>
>> - BTRFS_INODE_* flags
>> - BTRFS_QGROUP_LIMIT_* flags
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add the reason why we move the code
>>
>> v3:
>> - Move more flags/enum shared with ioctl to btrfs_btree.h
>>   This makes ioctl header to rely on btree_btree.h.
>>   But this makes btrfs_tree.h completely self-consistent.
>>   This problem is mostly exposed when syncing the header to btrfs-prog=
s.
>> ---
>>  fs/btrfs/ctree.h                | 246 ------------------------
>>  include/uapi/linux/btrfs.h      |  74 +------
>>  include/uapi/linux/btrfs_tree.h | 329 +++++++++++++++++++++++++++++++=
-
>>  3 files changed, 327 insertions(+), 322 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 8aa7b9dac405..4d787d749315 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -49,8 +49,6 @@ extern struct kmem_cache *btrfs_free_space_bitmap_ca=
chep;
>>  struct btrfs_ordered_sum;
>>  struct btrfs_ref;
>> =20
>> -#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null =
*/
>> -
>>  /*
>>   * Maximum number of mirrors that can be available for all profiles c=
ounting
>>   * the target device of dev-replace as one. During an active device r=
eplace
>> @@ -62,22 +60,8 @@ struct btrfs_ref;
>>   */
>>  #define BTRFS_MAX_MIRRORS (4 + 1)
>> =20
>> -#define BTRFS_MAX_LEVEL 8
>> -
>>  #define BTRFS_OLDEST_GENERATION	0ULL
>> =20
>> -/*
>> - * the max metadata block size.  This limit is somewhat artificial,
>> - * but the memmove costs go through the roof for larger blocks.
>> - */
>> -#define BTRFS_MAX_METADATA_BLOCKSIZE 65536
>=20
> So lots of comments and defines get moved, please take the opportunity
> to actually unify the formatting to the current preferred style.
>=20
Sure, and I'll also update all the existing comments to the current
style in next version.

Thanks,
Qu


--aStBsuOmhTcdM0gSg6QqldnUnI6XfuB0M--

--P7zmd1IOjUdfXx6UDyurOSYsg2rG0tSr5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6Wr18ACgkQwj2R86El
/qgZzwgAmwL1+ODcJlVJ8PLEMhtQDF+E0gaTN1wJHbV0UOru9mM2wv53LZEm4CML
wFDWFwuuJFIvBOfD8f8bsfwnwSzqTmbU0a9C2OhJMzq9piH82Xnt9C+YPLmeg5s+
WitM3B3qS08MPxeC1mjtwQARW7eGamIkchrVk8FfFWgUOjhmpBajrX+EJrme1X7x
tOrwomIAKfi1farGgPZxgLEYul4Pchbbsu9VF2HgwarH87wPoU+6rVcqDRIu0JXE
jgFyrafRiCoXtboIzaiHwDXz8ZtuXSbwhRxzapZMrlG8l0eh+xxf9qGu7RcdLqWv
RoT5lh/lIiiwpYwICzC882B7iOo5hA==
=AdhP
-----END PGP SIGNATURE-----

--P7zmd1IOjUdfXx6UDyurOSYsg2rG0tSr5--

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A8DA4BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 06:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407763AbfJQE2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 00:28:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:33727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407761AbfJQE2v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 00:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571286519;
        bh=iryGB8RP+6JXVAQA+u6Dmlg4eEyLHxWEukn6T+QRGOE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FxISG7ai5F6m4toiG2naZqOnlPFsfp/GxqpdpMcXLwng29KMGre2nUSASnjHqEFEa
         WyeEBpXPZk0Du92Uq/lgYUgAl+9vefT/W8mwwHX2DZ3gdETxPDSOVZouh7xakdppsd
         NfJxbQMIj+WIePlK7r3lHO3kp93uqUbxKuM0pPkE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnakX-1hbPIh0Z4X-00jWEl; Thu, 17
 Oct 2019 06:28:38 +0200
Subject: Re: [PATCH v2 7/7] btrfs-progs: btrfstune: Allow to enable bg-tree
 feature offline
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191008044936.157873-1-wqu@suse.com>
 <20191008044936.157873-8-wqu@suse.com>
 <92f936ed-74eb-5c6e-2bf7-6226cdef14fd@oracle.com>
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
Message-ID: <777f249e-7198-8ec3-875d-244253d2ae3d@gmx.com>
Date:   Thu, 17 Oct 2019 12:28:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <92f936ed-74eb-5c6e-2bf7-6226cdef14fd@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8SPW7u60NS0g0yK1MIxrGI85lbKqHIlWQ"
X-Provags-ID: V03:K1:j8emVOljDeObfspE25rDXAzV5sEImX0YS1xwRXOTNGxpS5qatVL
 PRn3X9LHu7yNoGlb62nEvqlOOLjeHZinENiQaUtMKBUWA5Mskb6LDR6xwn5BMEDU4ZwkPhj
 EWW9Oa5EHVuqxDRQrcasO6KPvETMsRoH80pSFoA2vlx0xxu1PLD8mID2K/luLVd22j5zmxp
 ewC0qgQ9O7zjyGzdMs1hQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wM+NrgS1kOU=:XtRJlURAjrVAnu0XwxNOYn
 2kRxTJXarslkBE1BWs3p2PdeXQjJmQ+kcs+MmQdWqsBMoEpmbPARUHpXIqoXVMBQySrhhAGkI
 TQ/0KdpX0Gw/CyDdavJX3gLQswkXtEbnE6GdtTzt7vz4kqbaWgzL8XVCeunSbQ5XVPbHK97Lp
 r0UX35wX3qvlo66t/6Hhj1TItwsBm+eAgaJT6GWxY+4O7TENbVp0l4LLWWcRy0C9I83mkoIoW
 IY7bJB+QYKRW4RJaiMewKM9xofoZOcwdiemGov1BVA+0avE2zW+nhnjcwqo6iqk0GxB99/o8G
 E07WaVH5MU3iH7+VwgiQ1UFJHULHDmvKMyk41SUiCm0ihAcpxGXMrHQyV0v2sEHAGQqvQ4oR3
 Ep3upcxTgh4KjSIHftsmpeZfuIkYSL6oVGgU1+UisULF7MR7DnhhvCmxSBJzYnhZJG2Nu73GH
 hjCHx/9YztmLsLxmKNAe56wTDfEUSVzBwrTOE1AkgNMbKS53hp9vzW4t25ynJJ2JyLAAmVUNa
 9xFmFU2KY06eDpEvufivgdcLy8t0MJATDMMQJTXzYX6t742ZPS6ZDwIcvJyMry5GG0l4Sp2ZQ
 dKn6zWsoZjVBclUaFc3fBNYsmvYSPFKO55XJATsAw3uyl/FgmWinlxnOaMhJ4rOZwkFubBO2z
 6d5y3YS3qLpBrcDGO9icsMKGxt1h9BFFtl7+AB36o55vfr42pxZZdfVkzFnW9s+7bt+GLmygj
 nWPj4CLNVxYcFz4NFfiZrxwqsplhVOXjj858TLj6C7kA1qWpLAakVhEiKj+/fphjQEfhJMlul
 T0mqrkoxwI4U8UimWacjYMZW0Ii0JqBSg0arKWtX1Lu9bbVpMEWE5MfYo+2qQpxzaQSTEv2k/
 vhp9wsV3Hg/h43i0kLWFjPWvhyGgzakEouUhF2EHY0vDWRkJljhh//nKJC9s4fDSkaFxtZ4f6
 1Tz0uiu/V13zhkjI63hPFElYcDzVgEHjYUR1ELVwFh7W13CFvS1aMjH/fV81LYKTOSQWkxi8h
 dbcvCHZ2rgsssi3ipKasMo0BXUsdjAAFeXGFy35wBksMCdgiuumBXy5un8arbXD8y2xQSiaeE
 sz9gdaw9Bk9i5RNBL8YM6O4Hxk3H++KhdH8cFHJs81oaRl5sI6a/QjuLxASbONtGj+KGpmhER
 zxFtFiUUBCnntOv+7AGE+FrVsDx1tCmI+zqpllgOiGZzlN6XhxAL5hXqk6m/coIoveReYVMmg
 p3RPt8LaZAMdfnKjT+nvWJbbspShepJPVf/EgH6y9OEHekLIqDwGfQYE6Ejc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8SPW7u60NS0g0yK1MIxrGI85lbKqHIlWQ
Content-Type: multipart/mixed; boundary="TXLHXV0YZFSziYBkYKawWg6qF2vFZPCD9"

--TXLHXV0YZFSziYBkYKawWg6qF2vFZPCD9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/17 =E4=B8=8B=E5=8D=8812:17, Anand Jain wrote:
>=20
> =C2=A0Depending on the size of the FS the convert may take longer, furt=
her
> =C2=A0fatal error (power loss; pid kill) may leave the FS in a state wh=
ere
> =C2=A0the bg items are in both extent-tree and bg-tree.

That's why I'm using one transaction to convert them all.

So if the convert get interrutped, we're still safe.

Thanks,
Qu
>=20
> =C2=A0The lessons which lead to the implementation of metadata_uuid fsi=
d
> =C2=A0suggests, for conversions its better to use the btrfstune to only=

> =C2=A0flag the bg convert requirement and let the kernel handle of migr=
ation
> =C2=A0of the bg items from the extent-tree to the bg-tree as and when t=
he
> =C2=A0bg-items are written.
>=20
> Thanks, Anand
>=20
>=20
> On 10/8/19 12:49 PM, Qu Wenruo wrote:
>> Add a new option '-b' for btrfstune, to enable bg-tree feature for a
>> unmounted fs.
>>
>> This feature will convert all BLOCK_GROUP_ITEMs in extent tree to bg
>> tree, by reusing the existing btrfs_convert_to_bg_tree() function.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 Documentation/btrfstune.asciidoc |=C2=A0 6 +++++
>> =C2=A0 btrfstune.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 44 ++++++++++++++++++++++++++++++--
>> =C2=A0 2 files changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/btrfstune.asciidoc
>> b/Documentation/btrfstune.asciidoc
>> index 1d6bc98deed8..ed54c2e1597f 100644
>> --- a/Documentation/btrfstune.asciidoc
>> +++ b/Documentation/btrfstune.asciidoc
>> @@ -26,6 +26,12 @@ means.=C2=A0 Please refer to the 'FILESYSTEM FEATUR=
ES'
>> in `btrfs`(5).
>> =C2=A0 OPTIONS
>> =C2=A0 -------
>> =C2=A0 +-b::
>> +(since kernel: 5.x)
>> ++
>> +enable bg-tree feature (faster mount time for large fs), enabled by m=
kfs
>> +feature 'bg-tree'.
>> +
>> =C2=A0 -f::
>> =C2=A0 Allow dangerous changes, e.g. clear the seeding flag or change =
fsid.
>> Make sure
>> =C2=A0 that you are aware of the dangers.
>> diff --git a/btrfstune.c b/btrfstune.c
>> index afa3aae35412..aa1ac568aef0 100644
>> --- a/btrfstune.c
>> +++ b/btrfstune.c
>> @@ -476,11 +476,39 @@ static void print_usage(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\t-m=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 change fsid in metadata_uuid to a random
>> UUID\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (incompat change, more lightweight t=
han
>> -u|-U)\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\t-M UUID=C2=A0=C2=A0=C2=A0=C2=A0=
 change fsid in metadata_uuid to UUID\n");
>> +=C2=A0=C2=A0=C2=A0 printf("\t-b=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 enable bg-tree feature (mkfs: bg-tree, for
>> faster mount time)\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("=C2=A0 general:\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\t-f=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 allow dangerous operations, make sure that
>> you are aware of the dangers\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\t--help=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 print this help\n");
>> =C2=A0 }
>> =C2=A0 +static int convert_to_bg_tree(struct btrfs_fs_info *fs_info)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_trans_handle *trans;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 trans =3D btrfs_start_transaction(fs_info->tree_ro=
ot, 1);
>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(trans)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(trans);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D -ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to start tra=
nsaction: %m");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_convert_to_bg_tree(trans);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D -ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to convert: =
%m");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_abort_transaction(tr=
ans, ret);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_commit_transaction(trans, fs_info->t=
ree_root);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D -ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to commit tr=
ansaction: %m");
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> =C2=A0 int BOX_MAIN(btrfstune)(int argc, char *argv[])
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *root;
>> @@ -491,6 +519,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 seeding_value =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int random_fsid =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int change_metadata_uuid =3D 0;
>> +=C2=A0=C2=A0=C2=A0 bool to_bg_tree =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *new_fsid_str =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 super_flags =3D 0;
>> @@ -501,7 +530,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 { "help", no_argument, NULL, GETOPT_VAL_HELP},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 { NULL, 0, NULL, 0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int c =3D getopt_long(argc=
, argv, "S:rxfuU:nmM:", long_options,
>> NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int c =3D getopt_long(argc=
, argv, "S:rxfuU:nmM:b",
>> long_options, NULL);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c < =
0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> @@ -539,6 +568,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ctree_flags |=3D OPEN_CTREE_IGNORE_FSID_MISMATCH;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 change_metadata_uuid =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'b':
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to=
_bg_tree =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case GETOPT_VAL=
_HELP:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 print_usage();
>> @@ -556,7 +588,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!super_flags && !seeding_flag && !(=
random_fsid ||
>> new_fsid_str) &&
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !change_metadata_uuid) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !change_metadata_uuid && !=
to_bg_tree) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("at least=
 one option should be specified");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_usage();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> @@ -602,6 +634,14 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (to_bg_tree) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D convert_to_bg_tree=
(root->fs_info);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
rno =3D -ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror("failed to convert to bg-tree feature: %m");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (seeding_flag) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_fs_in=
compat(root->fs_info, METADATA_UUID)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fprintf(stderr, "SEED flag cannot be changed on a
>> metadata-uuid changed fs\n");
>>
>=20


--TXLHXV0YZFSziYBkYKawWg6qF2vFZPCD9--

--8SPW7u60NS0g0yK1MIxrGI85lbKqHIlWQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2n7fIACgkQwj2R86El
/qisKAf+N30yXvNjdm1lO564AXDhtx/jcUeocMzwgZkJnMVY3rryRe3Yqee56nK7
B11UrUt2vgrFGKrHjc+8oIOArAJBBlpsRdqQqSfNd+yKh8ENE/SDP03Odz+/Vn4C
mDrU/HDjhDzoyeEvGCRdhskxC1+ubXx89NjmpZLPcM4hiiwCCwPhcuaJbm4UzVpm
+AMF2om2YKJ7YLEqfdKHde9Oz2mu1EpUoFpm+2+QCrbPojBv/Z24Kh6MQdVjntRj
oGl9ZGelpwEtkMG32ZUGeEz8PNx04cLZGm4V7klaeJVPMvk4BjzF3u02LOlxPggA
vgkO7HAqwEHeJoLwL+ZxFul91uE+/w==
=BC34
-----END PGP SIGNATURE-----

--8SPW7u60NS0g0yK1MIxrGI85lbKqHIlWQ--

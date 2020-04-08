Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4268A1A2241
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 14:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgDHMpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 08:45:05 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:55276 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728003AbgDHMpF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 08:45:05 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.146) BY m4a0073g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Wed,  8 Apr 2020 12:42:55 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 8 Apr 2020 12:36:33 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 8 Apr 2020 12:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu2F44zoRpZPnhfxtackdIzmUp15Vl9Eko7bvyMqBDaW5Vl6ps/IMgdTZSjN5Mf03BQZpE+8hI3bis+X+sQtln2whTq/ZpX/6Hcw9VlsqXSgYF/08dOb8nv/ZlMEAADRWAtMYuIpHik2mk6RlxPTqvTkxDL0Af7dgC/aHlBM2x0dxpeNHn1J0ELvQzbObW4A9ZkkQBqvzULBSaXLmb6euqfNm/gArVPAoiIKSUTMi0gu3bVXGMbVZEqJgIhJBPZqdH4T0OA3WusRiID/fhk0APdYJo++7pc63l0ZRzWwkoZzjLNiha3QScfoz9QTgU7DmTixm/sF4TzUyscgbe14pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYWW7dJUX5h2pF0cJncPC1GJKDwXbA2E9VhE/5yxfTk=;
 b=OgwwKF0T5mLNEVoKYPm6zYwwipIle2WnLIk07x4xDlv/iN5IuhnoxQyeZpfN+heQMRCt2YhKuXguEAzex8lz9JcXEhcRScYocAsCvNBPfnqFWsyCiTFCDU4sQN4XYkkzQR4jVHWtKi47UovK8zCooaqYUjVMzmproolGzbhUO0+U3u6foCuUi7j5J6Mm6BPmafYZ69takhrwWRQufm7QGnzAk/PkxOxWuCFDJduCQjVe6xAHmh51NH18A/wVmwyxV/C1a/UQ939jKc6vBvuR9tmlS2zwP/7/YRVFj9pMe28bYwWjO2V6EkT5wTbety1MTYEy3w/hCeMmlXXlZ6o0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3427.namprd18.prod.outlook.com (2603:10b6:a03:195::32)
 by BY5PR18MB3299.namprd18.prod.outlook.com (2603:10b6:a03:1ac::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 8 Apr
 2020 12:36:32 +0000
Received: from BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9]) by BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9%4]) with mapi id 15.20.2878.022; Wed, 8 Apr 2020
 12:36:32 +0000
Subject: Re: [PATCH] btrfs: qgroup: Mark qgroup inconsistent if we're
 inherting snapshot to a new qgroup
From:   Qu Wenruo <wqu@suse.com>
To:     <linux-btrfs@vger.kernel.org>
References: <20200402063735.32808-1-wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <288d0020-380f-717e-ab05-3fe6dbc64cd5@suse.com>
Date:   Wed, 8 Apr 2020 20:36:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200402063735.32808-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="OliwSLZGnqb34Z7uNcoiA81sRZPPDfjSs"
X-ClientProxiedBy: BY5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:180::25) To BY5PR18MB3427.namprd18.prod.outlook.com
 (2603:10b6:a03:195::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:180::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.6 via Frontend Transport; Wed, 8 Apr 2020 12:36:31 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eaf224e-617d-4b02-4091-08d7dbb977ad
X-MS-TrafficTypeDiagnostic: BY5PR18MB3299:
X-Microsoft-Antispam-PRVS: <BY5PR18MB32999FA04AD3BBDB3AC79C20D6C00@BY5PR18MB3299.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR18MB3427.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(5660300002)(478600001)(6486002)(66476007)(66556008)(21480400003)(235185007)(16526019)(956004)(16576012)(81166007)(316002)(6666004)(26005)(186003)(66946007)(8936002)(8676002)(86362001)(31696002)(33964004)(81156014)(36756003)(31686004)(2616005)(6916009)(6706004)(2906002)(52116002)(78286006);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpzfiQRIxHjbEQBuHTDo6IMzyiTDViyqhUZy9ArZ+D1iP4kNtuqjSPa/0218++YIWTII4Lbrjxe9ae+op83jWRehoX3uJ3c0ept+ip+mCKvgAYjk3ckAgDZd3yr4YjUr3LwL7M00+/fxCmjJDXrva16G7FnkZnopEy+/c+L2gg6Db/UaWhG9zRNrVMQlaL0hdJB3uI0B2KWwDROxn/uELYGB/FJFuFx0SaFEzcgcY+7vVX2tBCBUsnn0/878lnfOnbkmU9dtgKptjBQUM1MDxLNt9P0/VRoW4brsBbl6yKCwJlqCAy9MHCISqPSeyv0EZZxqpEk8GoqAp3lLLgISdnICMBTPsKpvOc5Rrx5TaVylc3xweuo/mxixkWnWNQuUPIWV+ERrsezgku7uGsi5vdVVplbFjWiBbrj+D0+Bvq2ix5yqE91m+CQEf64j/H5GXIzd6MsILu6oOFadWb9RdX1xqm78ZhRsRRxIFtvQ3uqFYdDkkDHHgQTQZc91WAc1NG7g4BuqMCg6X26vlvG/VOy496F/cmrm1sTdWYGLX/I=
X-MS-Exchange-AntiSpam-MessageData: S1QskiRedqCv1OHVrjzr1n1lKkPyT/WoH/ZDuefvWR67zO7F64kA8ZrCwg+5KBntmG3/CdmpgUyYHaWnZvn+LRtr8yzSKV/Il2q7WchBiKgId1P5Tc2rGrOP+ef0IwITfYBiAJSr0/yUfNYvZLHZWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaf224e-617d-4b02-4091-08d7dbb977ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 12:36:32.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q835zYJCdkdoCyRkmWTI0/a4ZVbnjSVUJE/wu7+u8UQy6TKz8wSLiJtMbuMPZU2H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3299
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--OliwSLZGnqb34Z7uNcoiA81sRZPPDfjSs
Content-Type: multipart/mixed; boundary="q3vkiNmHnkLMNfFmb82sQteCDG6X7A4mE"

--q3vkiNmHnkLMNfFmb82sQteCDG6X7A4mE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Forgot to mention, although this doesn't cause any data corruption, it
breaks snapper, which has some kind of "space aware cleaner algorithm",
which put all newly created snapshots into 1/0, but not the current root
subvolume.

And since snapper uses snapshot ioctl to assign qgroup relationship
directly, without using qgrou assign ioctl, it has no way to detect such
problem.

Hopes we can get this patch into current release cycle.

Thanks,
Qu

On 2020/4/2 =E4=B8=8B=E5=8D=882:37, Qu Wenruo wrote:
> [BUG]
> For the following operation, qgroup is guaranteed to be screwed up due
> to snapshot adding to a new qgroup:
>=20
>   # mkfs.btrfs -f $dev
>   # mount $dev $mnt
>   # btrfs qgroup en $mnt
>   # btrfs subv create $mnt/src
>   # xfs_io -f -c "pwrite 0 1m" $mnt/src/file
>   # sync
>   # btrfs qgroup create 1/0 $mnt/src
>   # btrfs subv snapshot -i 1/0 $mnt/src $mnt/snapshot
>   # btrfs qgroup show -prce $mnt/src
>   qgroupid         rfer         excl     max_rfer     max_excl parent  =
child
>   --------         ----         ----     --------     -------- ------  =
-----
>   0/5          16.00KiB     16.00KiB         none         none ---     =
---
>   0/257         1.02MiB     16.00KiB         none         none ---     =
---
>   0/258         1.02MiB     16.00KiB         none         none 1/0     =
---
>   1/0             0.00B        0.00B         none         none ---     =
0/258
> 	        ^^^^^^^^^^^^^^^^^^^^
>=20
> [CAUSE]
> The problem is in btrfs_qgroup_inherit(), we don't have good enough
> check to determine if the new relation ship would break the existing
> accounting.
>=20
> Unlike btrfs_add_qgroup_relation(), which has proper check to determine=

> if we can do quick update without a rescan, in btrfs_qgroup_inherit() w=
e
> can even assign a snapshot to multiple qgroups.
>=20
> [FIX]
> Fix the problem by manually marking qgroup inconsistent for snapshot
> inheritance.
>=20
> For subvolume creation, since all its extents are exclusively owned by
> itself, we don't need to rescan.
>=20
> In theory, we should call relationship check like quick_update_accounti=
ng()
> when doing qgroup inheritance and inform user about qgroup inconsistent=
=2E
>=20
> But we don't have good enough mechanism to inform user in the snapshot
> creation context, thus we can only silently mark the qgroup
> inconsistent.
>=20
> Anyway, user shouldn't use qgroup inheritance during snapshot creation,=

> and should add qgroup relationship after snapshot creation by 'btrfs
> qgroup assign', which has a much better UI to inform user about qgroup
> inconsistent and kick in rescan automatically.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index c3888fb367e7..81b2efca48b4 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2622,6 +2622,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handl=
e *trans, u64 srcid,
>  	struct btrfs_root *quota_root;
>  	struct btrfs_qgroup *srcgroup;
>  	struct btrfs_qgroup *dstgroup;
> +	bool need_rescan =3D false;
>  	u32 level_size =3D 0;
>  	u64 nums;
> =20
> @@ -2765,6 +2766,13 @@ int btrfs_qgroup_inherit(struct btrfs_trans_hand=
le *trans, u64 srcid,
>  				goto unlock;
>  		}
>  		++i_qgroups;
> +
> +		/*
> +		 * If we're doing a snapshot, and adding the snapshot to a new
> +		 * qgroup, the numbers are guaranteed to be incorrect.
> +		 */
> +		if (srcid)
> +			need_rescan =3D true;
>  	}
> =20
>  	for (i =3D 0; i <  inherit->num_ref_copies; ++i, i_qgroups +=3D 2) {
> @@ -2784,6 +2792,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handl=
e *trans, u64 srcid,
> =20
>  		dst->rfer =3D src->rfer - level_size;
>  		dst->rfer_cmpr =3D src->rfer_cmpr - level_size;
> +
> +		/* Manually tweaking numbers? No way to keep qgroup sane */
> +		need_rescan =3D true;
>  	}
>  	for (i =3D 0; i <  inherit->num_excl_copies; ++i, i_qgroups +=3D 2) {=

>  		struct btrfs_qgroup *src;
> @@ -2802,6 +2813,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handl=
e *trans, u64 srcid,
> =20
>  		dst->excl =3D src->excl + level_size;
>  		dst->excl_cmpr =3D src->excl_cmpr + level_size;
> +		need_rescan =3D true;
>  	}
> =20
>  unlock:
> @@ -2809,6 +2821,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handl=
e *trans, u64 srcid,
>  out:
>  	if (!committing)
>  		mutex_unlock(&fs_info->qgroup_ioctl_lock);
> +	if (need_rescan)
> +		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
>  	return ret;
>  }
> =20
>=20


--q3vkiNmHnkLMNfFmb82sQteCDG6X7A4mE--

--OliwSLZGnqb34Z7uNcoiA81sRZPPDfjSs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6NxUsACgkQwj2R86El
/qhj5gf/VO5CO103ux4eqZO+mqmONfkUTww95G7u3jMGsD1kqS+1amW8MtqV9qJl
1nPWLO4WD3z+zCLtEqnUHqCV/ywvQaF8wi3GIT2ymVWn7sp0fcWTef8JXdUbsnRF
ax0U5cuqG4ABJ5otsIaGp7bogwwa+nqs+DUFuPix7BO80YhjXEl8XDiBCCsIiCIi
wtqOr07tgg28vOsylSUvfTzk5oUe5cA9oP2Gq7CS72og36vZc88pcTxkSPVXeXwD
WwM8YPVf62tKofb8eYO0pRtKZvvj6GEzDO5DGstgjtSVsT1f+d+eh0fCdTYVSAKn
DY2SA9rKE0/eK9NitNXqmKvDV/sbmw==
=AA2S
-----END PGP SIGNATURE-----

--OliwSLZGnqb34Z7uNcoiA81sRZPPDfjSs--

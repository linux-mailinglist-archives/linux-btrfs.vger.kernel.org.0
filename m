Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5FC27CED9
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgI2NQx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 09:16:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4469 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgI2NQw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 09:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601386280; x=1632922280;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aWqVc8ytEkFSCIC361zymHHppQTxBpn2emlR3NHltew=;
  b=r1YRpe+hQhwh7RcJcmomHpuOy3Tm7FsSdcO7OgJ2sJzshXfZPZpJXl3Y
   AtiJ/U5jBC/B/5EAgN2vZslTeEnNmHl9ypkEIIUJ+knLaRfoYtf9cIYBl
   NJIDWS/6DcuIA+iZH9xN+nsHyXuOnE0UMYSabwpo5uXHrHZw3ROA92Qwn
   q6MwfqxXR/jIx97K6br9W1Ah6k8kiTud5p+Dpbk9JmzhiLmnW5IKP8Xgd
   jJ7x/M4hLqNOdjqh8WRS6nfOOu1Cm28c3iIm/6k84mX4NIoBSQjF15QOV
   auvyIbT7qLrQUUySXE24SValQcJDXgQr7u+Go82Tv/dJGzo/qBtVQ6R50
   g==;
IronPort-SDR: kgZZKDHKFkzNZkbDWDkbjGHF3h8LJC2o6QIcFGDE2tCGv0AOQKO/OB3rPNndYZ7v3ga1N0onn4
 qYkhH8jv7SSsB2wP0b2SV5uRPRJ/qE18W9J2SeEftpP6KD5H+3iDqx9Oyju5OGJJGDAKRnDyij
 T+GoValFin9sxusr62NFj+5XyQYFe1pJwnTnIcSqAgMIsK92gYISx5aJ2uCenP0da+kEaAlj+Q
 ljqWpuFZCw+CiUSbYB84ECFMj7uxkGbBdfmjSqaTyv+XyY4+I1Q5CiJkEovV1CdkIzW9EtuXmM
 dcs=
X-IronPort-AV: E=Sophos;i="5.77,318,1596470400"; 
   d="scan'208";a="251956600"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2020 21:31:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDrHyNK0IJWvUT03cFxYJEhgmtnks/HiLGKv8iaRcgjl3xy3CzNzsv3A7jHZsFi0SVLwLAYkXkq3nbTvSiEPShSusx0+VEyr37VyMs3v1is66eg03rb0wJZGx3BFtzgEXTWLOdACHSLVBg64Eq51wllU8z92fI+PLgpAaVDgNRcyY22XYz1WKuX1ObzLQYkNZRvL+MhpiE1m7cq69LKwFMV3YdBVZuI8xPpNNtvE85RD+PVutpiMR1JQocLgmeZWYjOVxwZRZ3EZGEvDu4lrZI0lXExL+uX1IBIV8RSvIUG10HtOZ+7337dYzgSDYSw6fdcH6dPnUJ8EgTXEhT1Nww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx0+sklloFOAendTKFVibOSX011DOPi0sBC4vkr8Cdc=;
 b=ihEaAXV2zAlrUu8o9yIGq2oJAlCc/aldokgpz3tyMv/NDazscqFLFD21eqb9FP85h/U4U/iJ+CjG5MFgv8cLs5nUYtpcR3G8+EyBqhVf2lc6w6pHNZWOnQ5HRy/2TymDMU7nGpGDgp+cNO5n1JtOJfkddDL5ZizNi4qS8HsuD+YicLxyaHfoI1SCzbQn7GVboFJU3yT3pyRo2Iv19YPgKUT3ooyfPTC0TbYGXktkGM+nYK0wVmdq2jN5rJP6xljkrhCcAiNQVzgz2x1zRftNdo6tTl6UO3uqaQGjIuvHZ6qIkZlbCFw3LjInBYVR55D1wsboIsw8P9qErlvDle8kMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx0+sklloFOAendTKFVibOSX011DOPi0sBC4vkr8Cdc=;
 b=CeDywh5KMNaiR4KHqd1JzRumMMxevMieMbc6Vg317JVEUys2nZcPnArqYlcK+TY5XhwB1lRuSud9AZn+q+jD4k1nIFYZYNBnIiQzXsPxueqU1nFBB9TzjTGE00q5+FuBqW+gncOLVTALjDRax6f6EC+nPwfLX3RqVrCc/k0JqMs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7162.namprd04.prod.outlook.com
 (2603:10b6:806:ea::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 13:16:50 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 13:16:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: cleanup cow block on error
Thread-Topic: [PATCH v2] btrfs: cleanup cow block on error
Thread-Index: AQHWll+fiDf3UbfKw0KpZdrUmVZmGQ==
Date:   Tue, 29 Sep 2020 13:16:50 +0000
Message-ID: <SN4PR0401MB35983F92A10521F7CE5F891D9B320@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <1f84722853326611d5d0d6c74e7af75be7b5928d.1601384009.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:18a9:9f8d:df16:87f1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 358d4b72-b997-4d18-2a78-08d86479ed34
x-ms-traffictypediagnostic: SA0PR04MB7162:
x-microsoft-antispam-prvs: <SA0PR04MB7162045BD6559835E80297109B320@SA0PR04MB7162.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cYer5cWOkKy09aLGtRKsEBge8nGnawJNSwO2leadtnvx+izg/wHTQZNCYsiwrJTgQYbREYXZzJ8gY6JwG49a6pXWBhS9kmWONR/hG+2/j590DZEToVaoTBzU7vr9+EndsnkG7KuitZFkeImfwsSSoWcm3L2hNBV0ppxgw87Le5mdf0iFdJQO9rCzYls7vAOkFgQFV3MUd2vSR+HmG6FheYgTxvt/cIFwk9lsz7KWIB8+3tOwmGWgeuAHmxb4snUJt1Qpguz+YkS/TjR/iOgPq0KR7RUsdQaoBccP4dBhiY2Wdcf4UyiP+GCzgqT9BeyBdDaQF7KaKEbM/nTrIQZ42bqwCvgNL/+cHmfIRy2JDS4apjUlzpAw+rdMmOs43NAK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(2906002)(4326008)(55016002)(9686003)(66476007)(64756008)(66556008)(83380400001)(71200400001)(86362001)(66446008)(8936002)(33656002)(186003)(110136005)(66946007)(76116006)(91956017)(5660300002)(498600001)(6506007)(52536014)(53546011)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: iA5yxUaJ0L4OkoBpU5EReLPlXNaWb+hce88rSbXblP6R2SAWLdDOYHvcoj7MmF9LkfvBPmFfbWFTjTI+epipeI7Gc2AhL42t2NjUMdIBQopx6f51SQch9vXWN+31F1+O94L+Kl0J4P4Gm+Q/X4r8sagjpyhLF3sJE+X9ILY5zo5wNQQF+49fNdO3UBzO7a3DNG+ZCsCQmWdnJ1CL32/iIfSzAMSy5L0pM4b5l19+Mq8eg5kYtklLbKfTXnRjnLyAZAfsWki/H4wuZq439Fm94hC6sgM1g0hYOP2kadkciyBAei7OFaXOCglmHK9t1PxpSLZbocdkWbMw6ozpcjJClMVTaRzKNDBIxE+3daJeyLOEq/TJlNFJEE+axzPjfwgD/jky+IIYnLxmtQS5bEgzRJWRQGocSvq5wJ2PtCrm7okbVPeP1Ew8eP0MEvwzNRvjunzkTSesPQzpXRRPrd8FqvOPtlOkxbrz5UqmoBU3wOROofClqwGx1xYUZWh98LOrlQxFDsD++YaBZCkRnxelo2SVwn7QcedN1XGPzGup1dsNw7XYKGOLWOzo7dv4RhOt2ja4inlLHi//s9b+S3oNOYjoaOtxYoi/zTbmE8PmnonfuzZvU7wH7v7ubWsVbsaYPd3xfhyAeS9blZjm142xJilduPNEUhVKr6I0lwTDzP8WdAfLnbD+Q02n6JzKUKlcvYru3yI2HE4bT0bVVXR9LA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358d4b72-b997-4d18-2a78-08d86479ed34
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 13:16:50.4755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUMCfwR7KbdqGubmPweGP9KUib8RLVfadZCgAu6U4d2s6RhTGsVjoAVrDewcZSjpOMRMOrezou0F41zr4LCfbocJ34UFoDcjHnG/ulW5ZrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7162
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/09/2020 14:54, Josef Bacik wrote:=0A=
> With my automated fstest runs I noticed one of my workers didn't report=
=0A=
> results.  Turns out it was hung trying to write back inodes, and the=0A=
> write back thread was stuck trying to lock an extent buffer=0A=
> =0A=
> [root@xfstests2 xfstests-dev]# cat /proc/2143497/stack=0A=
> [<0>] __btrfs_tree_lock+0x108/0x250=0A=
> [<0>] lock_extent_buffer_for_io+0x35e/0x3a0=0A=
> [<0>] btree_write_cache_pages+0x15a/0x3b0=0A=
> [<0>] do_writepages+0x28/0xb0=0A=
> [<0>] __writeback_single_inode+0x54/0x5c0=0A=
> [<0>] writeback_sb_inodes+0x1e8/0x510=0A=
> [<0>] wb_writeback+0xcc/0x440=0A=
> [<0>] wb_workfn+0xd7/0x650=0A=
> [<0>] process_one_work+0x236/0x560=0A=
> [<0>] worker_thread+0x55/0x3c0=0A=
> [<0>] kthread+0x13a/0x150=0A=
> [<0>] ret_from_fork+0x1f/0x30=0A=
> =0A=
> This is because we got an error while cow'ing a block, specifically here=
=0A=
> =0A=
>         if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {=0A=
>                 ret =3D btrfs_reloc_cow_block(trans, root, buf, cow);=0A=
>                 if (ret) {=0A=
>                         btrfs_abort_transaction(trans, ret);=0A=
>                         return ret;=0A=
>                 }=0A=
>         }=0A=
> =0A=
> The problem here is that as soon as we allocate the new block it is=0A=
> locked and marked dirty in the btree inode.  This means that we could=0A=
> attempt to writeback this block and need to lock the extent buffer.=0A=
> However we're not unlocking it here and thus we deadlock.=0A=
> =0A=
> Fix this by unlocking the cow block if we have any errors inside of=0A=
> __btrfs_cow_block, and also free it so we do not leak it.=0A=
> =0A=
> Fixes: 65b51a009e29 ("btrfs_search_slot: reduce lock contention by cowing=
 in two stages")=0A=
> Reviewed-by: Filipe Manana <fdmanana@suse.com>=0A=
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>=0A=
> ---=0A=
>  fs/btrfs/ctree.c | 6 ++++++=0A=
>  1 file changed, 6 insertions(+)=0A=
> =0A=
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c=0A=
> index a165093739c4..113da62dc17f 100644=0A=
> --- a/fs/btrfs/ctree.c=0A=
> +++ b/fs/btrfs/ctree.c=0A=
> @@ -1064,6 +1064,8 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,=0A=
>  =0A=
>  	ret =3D update_ref_for_cow(trans, root, buf, cow, &last_ref);=0A=
>  	if (ret) {=0A=
> +		btrfs_tree_unlock(cow);=0A=
> +		free_extent_buffer(cow);=0A=
>  		btrfs_abort_transaction(trans, ret);=0A=
>  		return ret;=0A=
>  	}=0A=
> @@ -1071,6 +1073,8 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,=0A=
>  	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {=0A=
>  		ret =3D btrfs_reloc_cow_block(trans, root, buf, cow);=0A=
>  		if (ret) {=0A=
> +			btrfs_tree_unlock(cow);=0A=
> +			free_extent_buffer(cow);=0A=
>  			btrfs_abort_transaction(trans, ret);=0A=
>  			return ret;=0A=
>  		}=0A=
> @@ -1103,6 +1107,8 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,=0A=
>  		if (last_ref) {=0A=
>  			ret =3D tree_mod_log_free_eb(buf);=0A=
>  			if (ret) {=0A=
> +				btrfs_tree_unlock(cow);=0A=
> +				free_extent_buffer(cow);=0A=
>  				btrfs_abort_transaction(trans, ret);=0A=
>  				return ret;=0A=
>  			}=0A=
> =0A=
=0A=
=0A=
I don't want to be a party pooper here but, now you have this pattern:=0A=
=0A=
if (ret) {=0A=
	btrfs_tree_unlock(cow);=0A=
	free_extent_buffer(cow);=0A=
	btrfs_abort_transaction(trans, ret);=0A=
	return ret;=0A=
}=0A=
=0A=
repeated three times. I think this should be consolidated in a 'goto err' o=
r something.=0A=

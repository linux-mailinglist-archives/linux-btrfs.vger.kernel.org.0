Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDEF231C82
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 12:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgG2KJj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 06:09:39 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23199 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgG2KJi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 06:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596017378; x=1627553378;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=g+QTIxALlmng3IpBUoEEGywYkGBPxxD4EQgQLZdF6eE=;
  b=lgY+oWZ0cGTbRipGZ7Ky8bWNbKbRMwUB3WJPU1KH3QEByUmJqNRwwscn
   hWd5gor5temRAT1zuLh7Oh7ZFp+njmyc4Uq58PL5C+pVWzLp3pzJ7BbWS
   G0xkmaVQZyw53liiISDieroZourmVGXX5cNF/AxRJ5nzTaISgP8iH/Maw
   Ty4gRCZ2Xn2E1Yh5ZZFJ6UdvYjzZDZbgwYHTQHjT7eNKDXmw45LMkqMdO
   NZGUZ9zVDaDZjgScxEybO3r2mWpevXXhLUxFymqYj9iiytIrMYCJ4kp1C
   DRQFbe9zgppsc/mEUBFvO8eS5LPvMoy9Kj0k5AEXJb/oYhp+UslSShuqf
   Q==;
IronPort-SDR: Bxyie0kz2hAhXWBh5+8zttzx1optLflfIU/9j3Wgpg/5UTLT9iFYOV5Qhqi+Ir2Ov2NFsA6o9Q
 G0bDSrBjhguH0kFhIBERx3fcCtQq5W8GwndVAQZ1tBo841QRedZzY5Z71Xxzbua3rzM23+Ef21
 DizfeOQ3YFfPbGHsDCsL1Dm+SMppGheIRRqwnHGJjdGGI5XnnzP1LxvOx9xQovPx356ifBXZFl
 3dCJ+7xsMjfCwFs1lWyhOu4B9fEUanURAaUCPVf8AIxfXsIQXIkWRaUQgw8CyCafHTTSZeXqD7
 GFU=
X-IronPort-AV: E=Sophos;i="5.75,410,1589212800"; 
   d="scan'208";a="144895933"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2020 18:09:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKFzW/VG4oTXGQT1TjkyVxwSUmEMcR2Xt6nTOBQkOsJDGKnppvnNDs4WV4MucLph5qsFPkGqQenuevR70C0IZi3JJDyH8UUvmtflke4g0uC1xoYSqEUhjv7r67HEyXsgW6pRquJu8cRyfZ6lqJVIkbmgDUpp1tdQrKmDBN+7pkkfs71i7SEtyxkDWRGO03Lukk+N75dtZZqcIItuNZpiJ7PAZwJpy7bRRea2a+5+awwqXBd85uHtR6ukQLVrBUOdFrIIGukm9kYLrSbPpNTbV+zSPzpInIDBhesNe+5MAXS46RKteJ/9vraGtmLtMqbOfv1bu07BlHAmLoh1DAVMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MznYGeewh9MUwsp8hBXrBkcp/dddbwoG4gXiICo1HUA=;
 b=IlJpSENS/RmVcf5LyIZOaT/zvpKNXJ7bI5ZikNrb4T6AAgKa3hZSrWk4+XJwQkIKJu0AejkjRPMIl8Io4hcmh9HJ3v3+X0VVIOrNdue+/o+mLpIwnQSJQbWc6ESXyZu6bYMUvxGHHzbHE9tI+p+cz6QKrmI51449EkCyFL0AYzwpU8ig/12IxRY/+3Qe1TO0ptLJ8JXMI0q8FOJLJiGsUvbNzsAbWnQAiba8bEYXGNIQM/jZxxIgPpt18+8tSEHLYeRrEMhaiSHHHPyE7XqIKMlHiTuveEPm8J/1ksoscLUVjd0HI2znMG3QuC3zfzRjlePoWEw/3WlRQCWQ6Bs3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MznYGeewh9MUwsp8hBXrBkcp/dddbwoG4gXiICo1HUA=;
 b=eJk/gznsYjAt1bFSNYd64vZu8TVFHcp8qYLCjnwyBE0G8PgSr0SNgIJwH2lR6NjFzk8L5z2T9cfANXDWtoO8vNA042ICURyquMHV8wjTqEGMHxbhXerr/A2Rlm7Fkiy0qe6CY8SCAYOplpDgj8r4ijJiVcbcTA48DSxasg6iwPk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 10:09:35 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3239.016; Wed, 29 Jul 2020
 10:09:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix memory leaks after failure to lookup checksums
 during inode logging
Thread-Topic: [PATCH] btrfs: fix memory leaks after failure to lookup
 checksums during inode logging
Thread-Index: AQHWZYkn2Srt3Q5IeEqi75SR8/DNZQ==
Date:   Wed, 29 Jul 2020 10:09:35 +0000
Message-ID: <SN4PR0401MB359867EB5CFA751D2643A6319B700@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200729091750.2538306-1-fdmanana@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f9a3105-8e3f-4464-fb35-08d833a77ef4
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-microsoft-antispam-prvs: <SN4PR0401MB3679319BEBD2042439FD90B79B700@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8O0J5hmrQIWspu7VMDZbxjhCNAEMCNeV8QfiyPktPBrv+JOzLqnne9IPdtYApvOvjxfZ0dxnim/CmXph9VGSdWR4bIct1nRpQQ1CqQcu3b+d0NufjpjXwbKCyHbpF5+TNk3Y/vCW7oLK+ugeunZ7LrArF7wS15u6HexmIeNmhcImgh2dfNi/EaCN8W8v8qKmEOV0/na1UkfKPTMOYcKCocY2yO3HCXw5rDvWIT1VQPqs/f/0IpWmWJR++HxI7Ae56EEDoM6B7uJBo4UZ0q0OLlASjWEizowqorCsCwtZeXblALsrd+MITmPTOC7Y7CuL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(83380400001)(478600001)(26005)(33656002)(316002)(55016002)(53546011)(6506007)(9686003)(186003)(7696005)(52536014)(2906002)(86362001)(5660300002)(8676002)(66556008)(71200400001)(8936002)(110136005)(64756008)(66946007)(76116006)(66446008)(91956017)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9uGC47xeNJmYvTY5luHGZ5DPjxvp7hK23+rWGGsR7016lhUkcwG4q8axl2jLtjrr4qmct/iEq6iEIQRdqoM/W9+6XNxGFiAKoTFB3dHw+YgHmX0YpuGHAEyr6rKh84P7qjQMeD8zynBxTC1SspTDrZidXiuMyrB5GdOTsyO5fhjnE/FTVxbOj56DBOvH7VyCSUtTn8lbBhUg/RatB6BdvVGObyUMtkOHNiHqm2zniKDelA2Nu0ytgD5A2+pfh5N3ABzZOjQ5C6DRnl/WeRvs9+QPoNV5gLr212QHnWqK8omXd7xGJ+V5VmVmkpIL1ttomNfeh3EqqjnM+EFb8fYI7cV3O2YMaqM+SOrkXawKqwequCiIRSrU/OedNbs6HzEGDNSTQy5vaSUgXxNg1i2X3CkNVjvNfjqJJTN+blGscLu0v0op5/8aWASetYSA+skOBqH1woe+NeqtiKKYTd+ALZ2DZsWFQvVveIcTtSk5Hd/PaOct5C06rcI/ckYDd3ih
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9a3105-8e3f-4464-fb35-08d833a77ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 10:09:35.3955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6HNAjrob1jCwOKEE6Z0U5p1EiLyjmoXTGUyw7/R3jnI3/oGK6Zk1/NKxOUWZYnkfg2swC01dmPw+GQg8wzsWBoHDr3PoZoDZF+36in6KWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/07/2020 11:18, fdmanana@kernel.org wrote:=0A=
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c=0A=
> index 20334bebcaf2..f1812f5baec4 100644=0A=
> --- a/fs/btrfs/tree-log.c=0A=
> +++ b/fs/btrfs/tree-log.c=0A=
> @@ -4035,11 +4035,8 @@ static noinline int copy_items(struct btrfs_trans_=
handle *trans,=0A=
>  						fs_info->csum_root,=0A=
>  						ds + cs, ds + cs + cl - 1,=0A=
>  						&ordered_sums, 0);=0A=
> -				if (ret) {=0A=
> -					btrfs_release_path(dst_path);=0A=
> -					kfree(ins_data);=0A=
> -					return ret;=0A=
> -				}=0A=
> +				if (ret)=0A=
> +					break;=0A=
>  			}=0A=
>  		}=0A=
>  	}=0A=
> @@ -4052,7 +4049,6 @@ static noinline int copy_items(struct btrfs_trans_h=
andle *trans,=0A=
>  	 * we have to do this after the loop above to avoid changing the=0A=
>  	 * log tree while trying to change the log tree.=0A=
>  	 */=0A=
> -	ret =3D 0;=0A=
>  	while (!list_empty(&ordered_sums)) {=0A=
>  		struct btrfs_ordered_sum *sums =3D list_entry(ordered_sums.next,=0A=
=0A=
Isn't there a potential that ret get overridden by this hunk:=0A=
=0A=
       while (!list_empty(&ordered_sums)) {=0A=
                struct btrfs_ordered_sum *sums =3D list_entry(ordered_sums.=
next,=0A=
                                                   struct btrfs_ordered_sum=
,=0A=
                                                   list);=0A=
                if (!ret)=0A=
                        ret =3D log_csums(trans, inode, log, sums);=0A=
                list_del(&sums->list);=0A=
                kfree(sums);=0A=
        }=0A=
=0A=
        return ret;=0A=
=0A=
and we're potentially returning 0 instead of the -ENOMEM from 'btrfs_lookup=
_csums_range'?=0A=
=0A=
Maybe we should do something like this:=0A=
=0A=
       while (!list_empty(&ordered_sums)) {=0A=
                struct btrfs_ordered_sum *sums =3D list_entry(ordered_sums.=
next,=0A=
                                                   struct btrfs_ordered_sum=
,=0A=
                                                   list);=0A=
                if (!ret)=0A=
                        ret2 =3D log_csums(trans, inode, log, sums);=0A=
                list_del(&sums->list);=0A=
                kfree(sums);=0A=
        }=0A=
=0A=
        return ret2 ? ret2 : ret;=0A=
=0A=
Thanks,=0A=
	Johannes=0A=

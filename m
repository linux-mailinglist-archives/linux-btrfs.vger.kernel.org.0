Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4AA7CBE3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 10:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjJQI5R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 04:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQI5Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 04:57:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C2793
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697533031; x=1729069031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GrWzCEP7nuw9L5J1Fhts5zIndvDa3GdG9Cz6h+Rkz1Y=;
  b=ZnYC9rcxK6J9XF9YhDW8cBhvlud9cpbttd/DHFtsM3jg0sKz+hzo39yu
   dZIE5XAjjKaM+W5THtVY+k13b0lxr/L9SEDAa09mXDlaLxRWk3QTeuMb1
   0+Nb/FRFBG3UNszYO30BRosyajqWGOWH4f5vaqndq8Wm3yg8RYb7OPs3d
   mChLSxxXw7NdFNZNCPJsnNgsgPCq7fx6Jdmkz92QHV1Yo8Wo7w4MB5jii
   /DXGJYApmdLeUhx3tKYnpu31h1UGFnnl6287ViEAo/mZVsf4Alh4/C54A
   H9fBPuBJdyiZUlN8Mf9XmDILyDkSyVn9cPiO/mh6Kl7bygSBjDLbdGrCv
   A==;
X-CSE-ConnectionGUID: yJzJWO2vTlmVsP45lrpfOQ==
X-CSE-MsgGUID: 3fxYawmcQpKhep6JM9N+PQ==
X-IronPort-AV: E=Sophos;i="6.03,231,1694707200"; 
   d="scan'208";a="244815960"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2023 16:57:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYz8NSK6C9mZ1bOkAdiuAjhrpwb7uIlI5H13weHGslLlFA85HO1hqW+wNlsyfqjphcV968CjIaTnYRNByoT7WoScwYw8veA+YgVDTdaFv0rMk0E4is+wZxxqIa73MQn7NDbshG1qxGxVBgwwlrJypMZw/0cGCZfm54AxlHIQ6pkhXh0LB5JGlQEDKenP+EAWLRXbmXv/hHJlNbGvAoK8EWfKCV8bX5HmSPlnRU8W6OI5/9N3CbJ/N+bMZY0HwVrgREn+TbTCnmD3roAgo0mTiQcLVajVi6BQpqr8JwDQUvOSHh4bXqSHIpHox7vLZKqJxEdX3V9oI+Hg0J5/8sVurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSyhoq6X70MU26BHhBw3mgD8jCsLdb6UZB7qSZwFW88=;
 b=VrWjhnJbhBx+qDAbERmtfejhwBQ11qOuxZeqU/rJzHJ42x3H0wwGB5v+DU7biCTZLMqzBoEqh3WIGnX73rxnnNawnMt4HmkwudC17mRNVgL0Kq5u5UVFQwrmSoSEXppzIXcxeS8nXipeG7+2WAenM1QHKQaMGICAlxN3y7CLsdvzPwry3cILiG9lkl56LM37VQOqGw82NryVQFGW96PlHpVRqKIwwK07p1U1mieHiPiF8a0+ukEppt0xARxS/Ws0wGANE/bWx+gsLrIL0nuzfr8JE83nhH7qcWp9n/LwqqlDhyj8HM0OzWDu39TwUye6hjOHijy4/K8lPrXv+MO4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSyhoq6X70MU26BHhBw3mgD8jCsLdb6UZB7qSZwFW88=;
 b=aKjtpJ7QU1GJryPIH4urr3DhNys5F4D1U1Qv+7kXdNlZNAdv/L1MIrDN2kptoOWnZ4Kd6ieB2ctXe7aNzaFqXyBCEaETlQG7obUPKCHWjSrgz1+nsOArxtkRt74VGGy6speF/jp63QAP0hNnkASXoQWZ9OCDg7dKg0+xn5p1NEc=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by SN7PR04MB8499.namprd04.prod.outlook.com (2603:10b6:806:354::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16; Tue, 17 Oct
 2023 08:57:08 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::8da2:bd08:c49a:dc71]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::8da2:bd08:c49a:dc71%5]) with mapi id 15.20.6907.018; Tue, 17 Oct 2023
 08:57:08 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: wait for data BG to be finished on direct
 IO allocation
Thread-Topic: [PATCH] btrfs: zoned: wait for data BG to be finished on direct
 IO allocation
Thread-Index: AQHaANAiAinl+fILo0SPXVtwdN3HMLBNri4A
Date:   Tue, 17 Oct 2023 08:57:08 +0000
Message-ID: <aiyljhwste67y2i6rohh5itxx6lximh5nbhkkv4363aivpc7lm@ziif7fjs3l2n>
References: <36d4b7502a8654882718421a18472d41dbc1c83c.1697529529.git.naohiro.aota@wdc.com>
In-Reply-To: <36d4b7502a8654882718421a18472d41dbc1c83c.1697529529.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|SN7PR04MB8499:EE_
x-ms-office365-filtering-correlation-id: 24654cd4-8d66-423a-a76d-08dbceef0b16
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udwAwva2B7z2RioT0GcURjhH37YdDDbd3XxOLKW3/LynRH6yedHXwOpM4XsEPSoEFi4MQoU0sqLHmMoO2F5goNVN1BXLudKQpeo8F7MNL7pWyBQJ1/fpHHGsrowFSETtTQR4X09sZG6BF98L+tXHntlrDB18M3xPSibbioqIRaqkfTluJKXklcWTR/2ebKRlqnOBLh7y3CwxtVIeB3KMC+BZAP3IgLPsaLRAyfvxzaoaN4av6bMQAYPcG7la2IPaxR3nNv4Ssi0Byd023y+NOj+ccROQ7KaALYJ2rUE/gyw8rbznJyY2Ms6p1dUGy3IV/9MR8A0SFD/BJKaDunoLA8COTy4+yGXfpAfV0aZnYZRTPNfbAt5lB4Zp3xb+m3PhPdob8mF2IOCVvPmEuEHpjOyxAWVBh583Eunnb8hRay6aYWM8UJ0vCfTMWiztWsyrBokoCwZwX04DDAUuW1s8p16clfT03TFaOzkJSFesHqWpP2HAX0l07UH1FH4YpU5d5R/I5SdAnTVS0aktwVzuvsRbQI1yOOi8EXB3umuiVwhJQa1hCKUMJDcfWkc2oVD8J8ZZfmOvei1kbF1L7AclN2ZMjpeCIN3C4V/z8aZVc2A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(396003)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(9686003)(26005)(6506007)(478600001)(6512007)(5660300002)(66556008)(41300700001)(6862004)(4326008)(8936002)(66476007)(44832011)(76116006)(66446008)(66946007)(64756008)(91956017)(6636002)(2906002)(316002)(8676002)(122000001)(38100700002)(71200400001)(6486002)(38070700005)(82960400001)(86362001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kSH09aQlNFElDR86rJt3pEvoSJ1iZ0v6n03J0Hx5+JT0i/3txslP4fmyd/y5?=
 =?us-ascii?Q?BjEgPAL4AqlSWf+2ispS7hwSKbud3wUSnegPRzTGEk6R6D6z3GcBHjOsCsCb?=
 =?us-ascii?Q?r7CzsaxlzvsCc7XLTP+sbzXA6n0r7QQhFeyv3VdMlFTa+q1x+r1nSSfxxItE?=
 =?us-ascii?Q?GrJDlPeqZdZGvvMDgvLbasdspV7YkmSCu9RxqMCAVMuKqLgO2dXci9FWZnoH?=
 =?us-ascii?Q?dudlkyNYfxy5jljdVAje8KOuJKfdVJ0bAzylWhG3txN5ZO04NjZNaXxH4RpP?=
 =?us-ascii?Q?21hoYeEvJqHIdbi5qDKN8MzLXunfz73nO5Z+RAcq/5lW2E5aXUvgSuSKvPJB?=
 =?us-ascii?Q?LP1B2UqSc8P/vD/CjAXVKSNikv9VNNLKdM6zyhnX4bfxHwyChHu71bwamgeK?=
 =?us-ascii?Q?7EGMBAiDNiyzTBqajoF28QNTHwgp/wkRcA7dN6JZNiQEak2S74NXpQAGPqJA?=
 =?us-ascii?Q?a9Oq08x2pYutwx+S8vDECsvZXwdIiZXUsbjuuDe4Itsjw774cmg3PvXgpYKR?=
 =?us-ascii?Q?VP9EmfwLiQ2U78EEYwLaxOtOwL1EFEw1s7MNl1XaTdGyFMy/HWyJMlt6kQS4?=
 =?us-ascii?Q?dPRvQd2vtjx7Umis/+DGsZ0OlQ9ednkToSxb2tklVfHKKuUToHtjR7GnkKbL?=
 =?us-ascii?Q?4jzLK8Uf5X1+2SIwZJBG2OCJ0ZjC5cAhIpr0OQc5EXSJvX3dnK7P8ste9EYO?=
 =?us-ascii?Q?1eJ+cDc4RcuSLSMrB0dD+sx21CVAaEKWnIvqONA+a7UkMipMorsvDNjERRmx?=
 =?us-ascii?Q?1j4QHROXye7y1hhlPhI02r0sfcCQKbbo3jTp3DHS8N1DsKclCOFVijBintj+?=
 =?us-ascii?Q?2kk/Pymn0QvMQfisX7zLltAANtYM0ih++S4avMQBHHZmQtKcQWZavURfH+cG?=
 =?us-ascii?Q?2Q4UpG3FsQtcIbYwgGTsp97YbGwp4dXRfmpYuAUIvk4zUgMNoaqVfMPsRNv4?=
 =?us-ascii?Q?d2ygp5KP3RhF8nEf94jZNrUhkKRjDOUs5YA0qlfztqvQR6GTIPWgGSjlfOM3?=
 =?us-ascii?Q?v0ybwUcU9B2Yh9gZHIoNdznkF27XJLyQY0B7T1a0tUcLpgb/OX8okqmDHd1L?=
 =?us-ascii?Q?hj6r2ismeoWf5h7fdgKiUMvCWEHuQuCdyqIrgNmXTYCxTjM0zRxU89V0ZyAA?=
 =?us-ascii?Q?Bqxij3UJ4CffgU/0nCtwulNx7uw/5Q+EhyoySGecjvR+KkYdkTbnvcgmGT20?=
 =?us-ascii?Q?j4gFvDIYN0Z3ZfNWe7hc7NPic5aklu+XyD19bUxppSqu/7XQaO4vkRSiTkD1?=
 =?us-ascii?Q?E7G2qcG/lQsgRzZwjaiD8uZ+hmzRgGj+ug0ikIAsKKz1AyXkPxi4cuUpJdSp?=
 =?us-ascii?Q?T+vffmxsm5NB6HSv/2Z3ams4qee7jscV1IYqpxDq+bfGCoGPKOLRbjmKanfr?=
 =?us-ascii?Q?MomrJhQvwjX2so8LuBkKu9hg+9bUetWDzsH41NthZQwrYeSFg28eCp7j4hIC?=
 =?us-ascii?Q?zS+SSJgn9pj3G63uVC3Orid0opoezU4QEaJQpHMPSgCPsgazXZzb/SRCHTVJ?=
 =?us-ascii?Q?1442LPhIidk1Ndj2K0FA84ApI+cjKCSE4UMBPNiv72PS64yS60fHK5LMMjuY?=
 =?us-ascii?Q?+ae1RfziL65u7fV9tn5eUfQJxK1HgxVTLzFRyfC6eASCkb6Kud3Ef70A8uDZ?=
 =?us-ascii?Q?6a0tP+HSYJRU3Kb6JFMJR58=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBE67DF12A49B4429E37D6EBF96964A8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oandkTPUFHzq9VyIl8wsCkL9Ezmto1pAd6oSsnqsspMYClUv8ZK8UNwHfFFgSxr0aCgR8URXpt2hZ88GyOby1sB3xwnbeofpedJ2ZfLN/fANEdVEGMWQyMs83H1Sp3u/vWlcJtyAc5QJcWaCrmelSU7LDjURlnLxs+l+7KrkvakWXBDEDGJKVt6hwLzO0T9dlsiP26gHsc2kwTqo8zLvEjIvninnTRHQytGVfPA5O17obvf7ZVUW48PseB56NAHYE/4v9SADQSkkM6bUPu8RTPq3k5aQmdFSZw0XR+NWV6+pTBWuMJjiiZIzQjcThFX0AHsR0xoQbN9FRs5AOOoSa+OjiPmMoWGowzhYqh7M5Taf17kSniprT1oq7wRsJxUz1hL91WkyVyRfLr3fX4175Ge4L93zxvqaUI5CkwUAR/MgqIHLjojfiQw0b9hxO9kk7Bi6uRAFrL+sv+IDH1HLYY4lJUfzf97hALhU9TwQV8xrmT74R+KmiFZQLi8MurDX5z689M/kHwjeh8mEtZZhHSBCGUVb5mO/6r+CCEY+DvFIbXzR9KdiRnlrRErUUZN6SHbeyKIrRuUftzAf05jFDzFi2YaFAuqY6GEDr263M6yGJJewTX+fHG3vujZ72GxQldrtpw7eE4fbBzxpFo6HhyNxIfve04BS99EKK9hOuQGQkoZBDYIQzGT3JA4SAE1ftQeoPdMIFqbarYOjdY+Q7u9axgxi49QRTDQLb4ONBnIAjYUgNUn+aaZswqlU7W9+K9vB+XPdu21wrc2pgwB7LYcPT/+hDkY8/zgU17UaIf8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24654cd4-8d66-423a-a76d-08dbceef0b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 08:57:08.1446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgzVF2iurKbOtjH2IYfaSY0AZOu3x88iXRl4k7HXQfyi+ehLxIdHJPdSFFDRSWqcfaSbJiLW+PhFlHGYTgzbHSnNCDrHZpIDJoPyAhdqips=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8499
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Oct 17, 2023 / 17:00, Naohiro Aota wrote:
> Running the fio command below on a ZNS device results in "Resource
> temporarily unavailable" error.

Thanks for the fix. The fio command is missing here. It should be like,

$ sudo fio --name=3Dw --directory=3D/mnt --filesize=3D1GB --bs=3D16MB --num=
jobs=3D16 \
        --rw=3Dwrite --ioengine=3Dlibaio --iodepth=3D128 --direct=3D1

>=20
> fio: io_u error on file /mnt/w.2.0: Resource temporarily unavailable: wri=
te offset=3D117440512, buflen=3D16777216
> fio: io_u error on file /mnt/w.2.0: Resource temporarily unavailable: wri=
te offset=3D134217728, buflen=3D16777216
> ...
>=20
> This happens because -EAGAIN error returned from btrfs_reserve_extent()
> called from btrfs_new_extent_direct() is splling over to the userland.
>=20
> btrfs_reserve_extent() returns -EAGAIN when there is no active zone
> available. Then, the caller should wait for some other on-going IO to
> finish a zone and retry the allocation.
>=20
> This logic is already implemented for buffered write in cow_file_range(),
> but it is missing for the direct IO counterpart. Implement the same logic
> for it.
>=20
> Fixes: 2ce543f47843 ("btrfs: zoned: wait until zone is finished when allo=
cation didn't progress")
> CC: stable@vger.kernel.org # 6.1+
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b388505c91cc..a979e964375d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6979,8 +6979,16 @@ static struct extent_map *btrfs_new_extent_direct(=
struct btrfs_inode *inode,
>  	int ret;
> =20
>  	alloc_hint =3D get_extent_allocation_hint(inode, start, len);
> +again:
>  	ret =3D btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
>  				   0, alloc_hint, &ins, 1, 1);
> +	if (ret =3D=3D -EAGAIN) {
> +		ASSERT(btrfs_is_zoned(fs_info));
> +		wait_on_bit_io(&inode->root->fs_info->flags,
> +			       BTRFS_FS_NEED_ZONE_FINISH,
> +			       TASK_UNINTERRUPTIBLE);
> +		goto again;
> +	}
>  	if (ret)
>  		return ERR_PTR(ret);
> =20
> --=20
> 2.42.0
> =

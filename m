Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5438FAF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 08:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhEYGcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 02:32:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhEYGcf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 02:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621924264; x=1653460264;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UJpAgBoUGXHzEqbQUYtd6AAg1RdS/Pi3iW0aC0v3MwY=;
  b=VBqg/ik0cUUEtb0ur+mZAKU/tCvbZcVctqYTMDHEeLWYD2CULEFJ5pHa
   wHyVwd6THEccIV7A0E5iNCW7aNaJuMdKkSQ5PtOKqB/+869QPWjq/R8TH
   MUgk3fX2Z3lGJfye3YJt0XVrDWtbWTQ1upCtGCCuwaLVnuIuUGmh5mGTA
   AJoLb8VPd4RbdLD+agFS+4ifWR8Oz+MKH/KzRRaeOpZIGOxMTVQxEc9Hf
   3sfGTFXCedQuppONsHfov0i9rBPxpc6gP/Lq0+ASzjbmK2xcfhXTvnyVH
   LeIboYu3OLzLiu2ufIKWx3hikO1pV35ufbJe3F4i/QHukTSeDUN1hXQ8E
   A==;
IronPort-SDR: stq3tOTOcHHAQEIKYXpD75evbTjcxZHEKW0Eqlwc6J0d0ZXjbr4SM3L065Ka8cY3YBbGZaHMzf
 6W4kKiDyxBlD4IU5Yt/bhOVTaIOPQo+jSd7jCBKak57CC9x+Qkt1mVdorgC/B3YkPuXb4qv4o1
 piGCfckUrF7Ek94lvG9BTwydLsYFJrPAX65MyXaEbyKSLOzkZv0cPlbEf1IK2T37pdtbq0xRZB
 s0GmuMhj8GrnTbho+iUvusCEDCMpAxTGBRG+UufKgT84febbo3lLKfMwhrzQKcl17VXBldFKRN
 j80=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="169326609"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 14:31:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP0MOPbBfCxvfj0fW0Fkw2wk8nbXTtR4WPnvoppSvZn/VU5gbigTYcw0JfbzKHiN1DjsHPdsQqgcplNM48bvxtXZlMVH65U8EEBYrRUH0VMT1IquaWdL7Lmtk2NGjgx0Hrm3P/8tsvMCjV7CPCFyi3e1zWhBw87XRkYDAXVIJiqumzvnrc+vK2NLtd6WB/Qk9puPB1Oa7Nxspq1VTLWQ4I9OsAOuXzBRVC106YjHPd5THBAAXbiyXrts81ETeC/uwM0ZHn0PbmoYnYL3ug4fFFkgVzf1gG4IX9zDrJeCr+jjmfJwYfcpwIxfc26kz31xHrhmLKx7uiVvTvyOjx5BTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khvelEdw2z12CC/1K/zsmqt8dF+lTX9U+2awG291yrM=;
 b=Tj68DdMqzsn7Mb8jlAWMpYnyunvqB/CIiLGvnbQXf+ntp81PDcVUiIhnUTUiXl895J82fz2jmYeqZ/UhP8KdAMCXrpuwMldbfaWHN3/Hb0I9c5RYLcz/zP5MV3Ca3/rHtVhp6hznnbwb1D9UxTB8/az++t7Nbb7h5Wc344TQBtkDWfFesFDGaZ0q73RvSGVo27iEEsWbCr58i+W+0zwHj8QvnDppLlfGTAudAWtMmBas23wq7ckJMid1XUhnHCUTAbOdT74QZcmbyN73uamk1qQ2NXPcBfnWwA+IPYoDF5m5cDzHYvTlLS6Y2g4R0CZ09fblkfGTYqTWb2aNKf7KtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khvelEdw2z12CC/1K/zsmqt8dF+lTX9U+2awG291yrM=;
 b=mJtYrHpklc+eWIAeoWLpNHVHL9w8s8pl+BetzGKwyBHhCfPdfc+myUaK1t2+9eMygwupmQngPsEyR4khzj0ATjX9Z9SwaqINOvpeGhrHJSBIt+whvSqLkPXdkBHMXEKAfTuaDBMBNIPNKMle290bGMo9Ili8lzGpLoiqqAIDG0o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7160.namprd04.prod.outlook.com (2603:10b6:510:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 06:31:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 06:31:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Thread-Topic: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Thread-Index: AQHXS/wyoE+7u2fw/k+3p3TOtvxw4g==
Date:   Tue, 25 May 2021 06:31:04 +0000
Message-ID: <PH0PR04MB74162360D247C1E4F0DC6EA69B259@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
 <563c1ac3-abf3-3f60-dbdf-362ebc69eb28@toxicpanda.com>
 <92273193-366c-8121-c2f6-26c885d77ead@gmx.com>
 <3cba8426-5574-0da7-28bd-aa90eb9f18b8@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db7d3c28-f7d1-4f2b-2119-08d91f46ac68
x-ms-traffictypediagnostic: PH0PR04MB7160:
x-microsoft-antispam-prvs: <PH0PR04MB71601BDABEE3B5FB83FDA74A9B259@PH0PR04MB7160.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52oMwzwa0DSp6FYQEqCY8VyzXDg/5CjCp3XQev/CDDfEw2HV5cX8ZHBJ8zQzdDCSLuYbOLdaLwqXCNWrG6rKfTnnqA4ubxJQ/u+AyTYugbXd8lpcTQsc8BajHhi/bpoIKi4iy3ag2sRctQVBTz4/HU4xlwAX6DkZIZdKaLXtIsgkXNMvSj57W11p/ams2/ha9vsuLAfas5DAHygsPglkmixgGhruVrDKoqLOsz+ChLNc5UF0d9xnZFfsqhYFQ0lsLlCVsZaxYMVNkciSZWlHmbAxSzNyVHKNevWy/ii4olwNLSt56TVGwKMevQGbmDz0ejVoi7wVXlDKwc7Zs95m+3Uthg1n0Z+poQ+oZT0XwuTroHx9ZtmC5xQV1BLDyXYF+zH0hZiC78iVW4S9dHlj8D+vZLrGPEnljEqXWOdNiWngIefxnQDz3ol/W/qjaJivef4d2/Fjiv2BnDlW259h5jQa9ZnxCdGo/O/5Qxp27tPv+SZOOSTR2T9fZzzqb5F+44MZX6oF4eRmhOuPM2mCoGuKGe0tw4qW+jjYcwzodDJrq9xF8YxasH/ZVBD74jwqTajlGCkfjPV8MM8SbSja/Sd0p4jow4fb0A7obG/sA3Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(66446008)(55016002)(66476007)(66946007)(91956017)(8676002)(9686003)(86362001)(64756008)(66556008)(76116006)(7696005)(478600001)(38100700002)(33656002)(52536014)(110136005)(71200400001)(316002)(186003)(2906002)(6506007)(5660300002)(26005)(122000001)(8936002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Jkk9HmtP5Rkn+PVRK4FvC0SoqA3W/m/Oncyg8osI6/vzUwYQm66nuaBvu66S?=
 =?us-ascii?Q?P4FEtUPTjZWBEDexXvL431VwhiiZTv6XmcWcKvjNwnaPog2lW18RZ8hPwQiy?=
 =?us-ascii?Q?t7SlI4BXKmjnRCLf+9PnBjF2To5qJ857GCTlKW8SLBxpCsXgiZ6NrgS1nroW?=
 =?us-ascii?Q?PQZHQ7sXfyyHOcQIsYT7aJG3NSo/8ht48VvnOscrM44br4eQ6UnYPK8BMnWu?=
 =?us-ascii?Q?D3kPy0uegzRVNGZOF5uJioz0rtm7m1TgcFXiuF5ABzPTiwRS65X4dMiucwwF?=
 =?us-ascii?Q?n9+jxB8FB/VVf/j+vQYokaFcCkUGwQK/uxd6onFAL/0ogMG19ewCuSevUvRx?=
 =?us-ascii?Q?ahDgJjT7XEGjNQ6n7Ml3zZSbimPboeQkOarV5jvNmQWRCd69sM7EmlXOoZ9S?=
 =?us-ascii?Q?7njCZ2KUzzJvdqJ1LJ39HhKqhZB0/WIaxyjU/PvPY28OgbwPzhaMR/A6WxDF?=
 =?us-ascii?Q?iyFEHWSsdtzx1MOGStIO6Awr/yrNepKYs9FQwWQiiLCmRD1U815NMvVVy6qE?=
 =?us-ascii?Q?yAZRnolT+WkFtwIGlHf9V5vg1l3/0hN1gFfHTxnhVBEdFfH8Hm2N9ysGC7yc?=
 =?us-ascii?Q?HP4UyXyrNZA3z1f1AZ5jJab2UlagdiKB6k2fYzen96o8DGnqDWqNxqVsBiEo?=
 =?us-ascii?Q?aNTuO1ochTbNGH6E4zTRocqQnTcJJrVpvObAN6AMk0HGAgOPoVpagbpUD3FF?=
 =?us-ascii?Q?SisOgkf6SMk7PTZogyYkAQbT5CxhFUdt9BFX0TThKJgDPE7/0br9Q9K0QrQd?=
 =?us-ascii?Q?pGOuXgYhlCQuk8wM0WWPUn8JfyLgTeO1hvN0z5bqprfBVJwsol7NTu0dTz3+?=
 =?us-ascii?Q?OhJL14gIZg0fM6py2qvfTFbdxxhbZ6EHlu3I1lcrU/tJ/klGfcljo+ccNBOP?=
 =?us-ascii?Q?axDkzYSgP6GcMQZuG5w5Avgajryzh5ozxeicZ+8bQBWrHsmcUVybOvI1Ujfv?=
 =?us-ascii?Q?uoU1MgNsuyadOnOQ8sdNdfjvnv9VfGpOslFCYi6s2FWBnrVKX9g8MLn6fuvV?=
 =?us-ascii?Q?Mbx88uf3hQBVVvQ9W4ODfzNceB8ckv0pFGg0mLAnbkbvJfSfNvXL5/Ghejrs?=
 =?us-ascii?Q?lRUgtah+JXHkmyaLjUQECdKPLf8vxgLXFvnupDS4d6UgKJBIBQRpzgCno/vS?=
 =?us-ascii?Q?0PxBlqeTcOn4XputbVnF5gFK6rmos+VCr9/VzroPYmqFkrUwbifp+nGEVO+l?=
 =?us-ascii?Q?j5vA1pP8g3fu//8L9VgVLlpDUrOkqHhelIJni+mVFygOCIKItm1qlxRPbjL3?=
 =?us-ascii?Q?kX6mulkLBwDcn3cA+zqOWPvxCoixiHEiFZxSw1sSCbuTu4cTGupx/ZDWHawX?=
 =?us-ascii?Q?jU1t31iawAuESgE8cMmt03gWx2alcPnmCGNnSVWp3IliQg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7d3c28-f7d1-4f2b-2119-08d91f46ac68
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 06:31:04.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N53bOd5pLGR+rgMGMUuB29aHFme65cdOOWVL/seWF5t6hVbeRciHl0ZYuma9NRyYfCeLYhRvqZzE6cpU5VRxLTIHX7iGPINLOcVaTU8LQDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7160
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/05/2021 15:05, Qu Wenruo wrote:=0A=
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c=0A=
> index 831e6ae92940..26e2dceda1fc 100644=0A=
> --- a/fs/btrfs/compression.c=0A=
> +++ b/fs/btrfs/compression.c=0A=
> @@ -455,10 +455,13 @@ blk_status_t btrfs_submit_compressed_write(struct=
=0A=
> btrfs_inode *inode, u64 start,=0A=
>                          submit =3D btrfs_bio_fits_in_stripe(page,=0A=
> PAGE_SIZE, bio,=0A=
>                                                            0);=0A=
> =0A=
> -               if (pg_index =3D=3D 0 && use_append)=0A=
> -                       len =3D bio_add_zone_append_page(bio, page,=0A=
> PAGE_SIZE, 0);=0A=
> -               else=0A=
> -                       len =3D bio_add_page(bio, page, PAGE_SIZE, 0);=0A=
> +               if (!submit) {=0A=
> +                       if (pg_index =3D=3D 0 && use_append)=0A=
> +                               len =3D bio_add_zone_append_page(bio, pag=
e,=0A=
> +=0A=
> PAGE_SIZE, 0);=0A=
> +                       else=0A=
> +                               len =3D bio_add_page(bio, page, PAGE_SIZE=
, 0);=0A=
> +               }=0A=
> =0A=
>                  page->mapping =3D NULL;=0A=
>                  if (submit || len < PAGE_SIZE) {=0A=
=0A=
This looks good, thanks for fixing it. I indeed messed up the bio_add_page(=
) =0A=
call in the new version when untangling that if (submit || bio_add_page())=
=0A=
construct. =0A=
=0A=
Can you send an official patch?=0A=
=0A=
Thanks a lot,=0A=
	Johannes=0A=

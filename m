Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25ED3B72FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhF2NNY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 09:13:24 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64625 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhF2NNU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 09:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624972255; x=1656508255;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mnvq1DqURc1jO9sn/xDnb+gx7ljtEaEaTFbKIfOOJZI=;
  b=ejeG6g4M0ynBWnbESFlYikOnFlK+VIsaH/ZIsGKwlBaYMv2O/Bpy5F9Y
   Nvo0gWuiu9radsritkmdlExSsR0jjmkOu3xr8+xpWK0KZbY3F9oiL/2rw
   dM6ghVpE1QlhSXFojsuojxOLeTmveE2tMsTYeraqz8In4X15EBbUhSHPM
   p/p/g+iIiLcXWyeqwlifJDXS41vasDdaqffxS6Z32KhK/Uqlhyd/jtrnR
   umQsEsi8fau7mAdzFOxC8eZDLFSNgFjVeetJwXYuVfdiO9UePPAf3YJGd
   J2CiTToUBd1FTUSOXUCDYTk3evRHmcgWCkiwkO61q99/yqdwJiELT5JNK
   g==;
IronPort-SDR: JBvzAZahAOEvsh6mmVA2ZRbv/tCcu4/E5KNWwpoEZn8d/Iq4ZpOCS7dOhuGTiF+N+0Dj5RyLPH
 aMu89OkwOD5CZGXe4BdMS/Rrn+g+vPa8k1AHziSsDc1SgKuSuyHznhFVOsot5F5TbEeca9bvvJ
 pkjBRYF4PfDHeiz/QQABkmk5y4pSXSh2o9aRbBzthDXqUnWqTkL1TubNLBZx5rlEi4TNrx2lrn
 rz4xTxCUVmGDySxUs0VTCM8ZEJkyVOAnaRrRbCnAZLfbdbToCue8vXTFtOZ+O2UdkZhMhSzH6Y
 Fn0=
X-IronPort-AV: E=Sophos;i="5.83,308,1616428800"; 
   d="scan'208";a="276990061"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2021 21:10:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrmjola51eee9D6lGpbk9iEDQ6H0Ir4xhFOIjWBJfwJo6xBEd8mjXkkAtmiNCKTW6aq2v3xcMQHdCwW3SNyveZqzzyICyKn5t2MVPioF4IL/M5DkXKmp1TgcdAIKs1mmKgzCzg9x+ozTRYqgjjFhuCSEMuIX8eBF8vPc5Zd9hcjaITK/I6wFUOywXUOIp+S9WvtZ4oIlRGPULj1c6BANQWYhRLONTF9d2aU3dXBbUQ81VlLs4XiPbDlNIzbF27jAYOYlHeEaVGdIZH6iQOLHUvmEFR9RnLmdSudcc8Xn5Fp5eVXD7ClM+3x+0oPrca4cV585+jMrp7lLg9IdlKgWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azGUvcjuTQXutgygWmONmY04fzPzEkHOoeDYPcOjVvw=;
 b=FRbKFyyu64a2VUReitMspP9gokvd3L+iCUChUr5R/4xFj3TvUCvJ8Lh2zC3bny4XH7RnISRZJPKosLX7P4++yfBNF+ApKU5piGeScDb6EbHzmmGviUEaYtY0/hPvFsGcwVrP9mtR71nku1iLGUbSXnquv//+W3YbnPcv/neCoHHsKCyu0K9ZwEQyQF30MXPKtcboscLJkLJpkBnDUfrDtyTaVezWcLDomXTdQ5vz1EfDvGXCU+Br5nG+GeAP1fr2rS+Q/wrCcANxdLyvknDYP4FotKMVQEqA0h33NJtB/lsvcbWYzBOcSiBSZzWlyTZwHY9BCefpnVJ7inPPaieQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azGUvcjuTQXutgygWmONmY04fzPzEkHOoeDYPcOjVvw=;
 b=MKkkj18ZDWGroY/CEU/jacQ9naaIxWQunmSBh3o/PInh6Nw4QJaukLr4o0KXZYImZgIsAeYAPk+5WXRaG6N2fRBIn3c8z62DaKF96J1gOTX+JEbKCdxmbC1dZ+gsBRnuoQ1QTs2HjNhcXu1urytL4vLs6S+zBrMdwm00aPmxprE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7144.namprd04.prod.outlook.com (2603:10b6:510:1e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 13:10:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 13:10:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "lijian_8010a29@163.com" <lijian_8010a29@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lijian <lijian@yulong.com>
Subject: Re: [PATCH] fs: ntfs: super: added return error value while map
 failed
Thread-Topic: [PATCH] fs: ntfs: super: added return error value while map
 failed
Thread-Index: AQHXbNNBVURHEYpyLkufB3xqYcL04A==
Date:   Tue, 29 Jun 2021 13:10:50 +0000
Message-ID: <PH0PR04MB7416746F354376654DD601869B029@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210629095333.115111-1-lijian_8010a29@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2a00:20:c003:b7d7:94e4:dd6c:b171:5823]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30ba985c-a53c-431c-db71-08d93aff5179
x-ms-traffictypediagnostic: PH0PR04MB7144:
x-microsoft-antispam-prvs: <PH0PR04MB714485089EB10145921C31489B029@PH0PR04MB7144.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p3AQmXdnk7oG3KHpIUu1kqv6IGj+hMG0Kwlm0lOuXXskGOYMsjTsuz2mqli8CkZcs0W1QRwTGgijIcGoKrzwW68zgGNE313ljhFOdzG/8Z/fLDJ+vhM9E4iExSLWN45C5MnjFTgsJ7FNHWnARxlXDACq6hq7SNpEXnGdplFveNSpZFXF8DC1M8SMrDPxM31VQYYTHJWTxqEjFC3TcB5UhHrOvAzEt0MdmKLsAA/q60Rk4HZR+arjUuv2abn/yx/YUH/9URbKjtNDFK+Oz9e0JXP/b/fWnZGf5qSqalUXJqTSD10A6BFr5FOlip59y+yGHj+GR7a+L6J68Yqfn37YApocgUoel9sP6gG1DcrdepjbwMVi+7gVGZQDL+VASPiyKMgh4/0nmvpT1d5ZZfvSilYkyMOUAnQ5/z7YL6+4ToIlGjBdwiRtqw0W5PLQTMN18bY5bDHMp3zjc6lmXSW3THfFXbsusRa6TPGZuUfwWtqM2rSBAx5pvd02NXyuLT5rQMdY50YQ9vU2eMp4fH+71CczKmqiaDJdxTp+/GgVROQmnpNqTjrebN1AWl1S+USWYVGyHj3Fc1EbtvtTjp1fFg3x/BW5QADRmfjpEKGIbRgHxCThYkWVlt49ApnUHygPLmqzUfRYnoaDAZonMWyxnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(83380400001)(8936002)(55016002)(9686003)(86362001)(33656002)(8676002)(66946007)(122000001)(66476007)(5660300002)(54906003)(71200400001)(316002)(52536014)(186003)(4744005)(7696005)(4326008)(53546011)(64756008)(66446008)(66556008)(38100700002)(91956017)(110136005)(478600001)(76116006)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AYXkTXjfL9mLwgyoy5BM4mnNZAK+gaGTkKq5GE7I+eQGFZzYWQGhorKRMdX+?=
 =?us-ascii?Q?T0ch4lZszsAgYSPXVZX8MQ9R+kTEtqegSTC4yPYj8r2dHe3/GiwyzS5xfcoC?=
 =?us-ascii?Q?Io+cNj8LzDCnstIuk7XOOB4OTmpfIGN56b3yvOjtP+LTMizCNXgHJv3LBAhL?=
 =?us-ascii?Q?NqJ/Rkwv5hjJHcOayQpl5hdVG5aWOn8AUzFv6vI8LeNsaX7mV+QQYLPanJz2?=
 =?us-ascii?Q?9xGxFGIKDmQIGdvBYnj3xzSpcACMCB0l+aY2WO3RfQCsYVvTCtXAvZvXLxMT?=
 =?us-ascii?Q?pGrnrLLkPaCjGobf3eKW1UJPvWy3ecNmQ+AFPhbu4KJpu0dsaL0u7J0UGeuI?=
 =?us-ascii?Q?Iq90rx0WOKRxog7ra+vGGFjkVLxHViPiut9YLf0EK2+7MZvVV8pm+5AH0QY+?=
 =?us-ascii?Q?GIOfGbx9oeyiWHELGUVdCdii4N9OJ8SOfEVnNjSR8WIBUeM1oFmVP512hdVZ?=
 =?us-ascii?Q?+CxD228PZ9vkjP4id1DcEJve5eItzK4L4o+dR1JRZC8cEBIwQ16m+fYt25ZK?=
 =?us-ascii?Q?6dzVM4pwfpX/wakj5r/jSb36tr++PRDM3auOD0Aai2JDbdeZfnQszdXH3QWK?=
 =?us-ascii?Q?ZVxrzwvPI6Tr25pWzy9+DG8KBv9sV0MtlpGeYmpzbYJebL6uXCBFOSgsycXz?=
 =?us-ascii?Q?Mr62kwDcjWZsPRrABJuOfDcBdO6XGgDCZaKBdDU+bzhYQ0OMO1I/zftFQIGM?=
 =?us-ascii?Q?qSCwTJg37fNFgW6Ryw2Ck5J3pP3HSX6pPTdKxqR8xfF+ZaZYnox4VCwkaG8A?=
 =?us-ascii?Q?m3w+V7ff5cixkjBRr41lwW0wIHN1/I7wjxfXOVNlb1N1fquysN1QWRVfrNOb?=
 =?us-ascii?Q?14T5QQ2/lVmlIkjJKjg65MuAQO8HL/rv3Z0BF8PHCpJ82WpcurltwBzkCLdT?=
 =?us-ascii?Q?08i6Y0Fr929z1NXcbzkvaZWTjCpHqmZQHuGAGEf3CsFcBaUIu2eg4gdUvRWQ?=
 =?us-ascii?Q?pqn20QQ9kRhY+jfGufR4xXKFggl3zA8cpJ0iLstdwMwilrHJekj7t6lNQe6y?=
 =?us-ascii?Q?3tP7R2X1LmGFpVy3ZsZ/hxD0eLhSACmpiCnwHJ1a7544rRCBkHHoRhwOtBmb?=
 =?us-ascii?Q?hArsa3b4Vfi1dgYSvEIlHmIhYlCDuTCuClSvtdVVOTxOw4KveyVfe856PHdK?=
 =?us-ascii?Q?PuFhUVgZo1XCuXpKhfhSXSYG4M0ItenmBlJzyRntBA8kTxyabc6cdNhi92lA?=
 =?us-ascii?Q?BRMXOul+ypbY3H+XDLz9Vxb7KWgjNYzBdlO/Ev5FVh5e3f18PQTSRxsOZUpi?=
 =?us-ascii?Q?Vv9ZTJmZuc9Zw+SPgXqLb0TaJygKeYSRQIWf6oX4bfjIMwBNp2BqfJOGOVm2?=
 =?us-ascii?Q?gdBFEws2xqWKTEh9toeROwhIKsCgU+in8v1ZssQ+kFf4fA53KIKeanfaeJZA?=
 =?us-ascii?Q?jg8B8CJnA87WrpF8bSscOQhK8CFz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ba985c-a53c-431c-db71-08d93aff5179
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 13:10:50.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKTSShakP6PWpcsIsuR30p5ThumuK1DVqh2HfwrxqoLs956ICeeSGCAbsFk/aeRbiZGCoiD5O7f8FUYSj9cKZ0d2narMGX3RbdhimSr9BMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7144
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/06/2021 12:41, lijian_8010a29@163.com wrote:=0A=
> From: lijian <lijian@yulong.com>=0A=
> =0A=
> When lookup_extent_mapping failed, should return '-ENOENT'.=0A=
> =0A=
> Signed-off-by: lijian <lijian@yulong.com>=0A=
> ---=0A=
>  fs/btrfs/extent_map.c | 4 +++-=0A=
>  1 file changed, 3 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c=0A=
> index 4a8e02f7b6c7..e9d9f2bfc11d 100644=0A=
> --- a/fs/btrfs/extent_map.c=0A=
> +++ b/fs/btrfs/extent_map.c=0A=
> @@ -305,8 +305,10 @@ int unpin_extent_cache(struct extent_map_tree *tree,=
 u64 start, u64 len,=0A=
>  =0A=
>  	WARN_ON(!em || em->start !=3D start);=0A=
>  =0A=
> -	if (!em)=0A=
> +	if (!em) {=0A=
> +		ret =3D -ENOENT;=0A=
>  		goto out;=0A=
> +	}=0A=
>  =0A=
>  	em->generation =3D gen;=0A=
>  	clear_bit(EXTENT_FLAG_PINNED, &em->flags);=0A=
> =0A=
=0A=
You'll still need to properly handle the returned error in the caller,=0A=
otherwise this patch makes no sense at all.=0A=
=0A=
Also the subject should be something like "btrfs: handle failures from unpi=
n_extent_cache" or=0A=
sth. like this.=0A=

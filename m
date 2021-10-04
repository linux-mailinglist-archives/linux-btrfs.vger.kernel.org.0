Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E9C42073A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 10:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJDIWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 04:22:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58975 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhJDIWx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 04:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633335664; x=1664871664;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=XmKzVWvh0ghat6wUFWTOVbnn5irCItiiDOUV60+xqfgi7TSJslqxMTNx
   cqdjJtZjN5h9FYBlFI4iuMEmAoGbXk4gIBqO/FxihklX7s3Kxbr/LGW+e
   eQQyxIemjmMjutCe/SZfLyKEXYzmQjP0Q3ZNgtXv2wEXuBxEcAQw9hzbB
   ZwyetVNGJB6afHEMXtiTUbqjIdfXFi+kx5PNVL9hhEbuyYX7FfT4Au50E
   sQQK8RP/1WyNX8J2z7WG3Ush6JiEm9B5HtOKLlOkFPEWGIjGnP8GyThTE
   CjBPc3G5/ozD6ZGRBPbUlMsLIUWPb9Ft2W2rrH7L+aZSVzRjUAwMMjGBa
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,345,1624291200"; 
   d="scan'208";a="181769638"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2021 16:21:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aScrRv54/BLHJhija6Sqv4DbPPex1zDGmyz6dJibFtUrOh4D+TWN+1fNb5Fr5L3LKRJVphnPva+p6lA/pJkt6mdvk0au2vKnvscXYsD9c/OV+xQHd7S7h2aoU7Nf44U+R49EAK+3RPoFc9pH6CMFMpDvxmgOCXbKbQTqFDnQtZ1AEx3rFkTDDR7SJL3k2dwlffe+DIJVh5ila0fnwnoHtudU3d2PikM1JedKTjKOFlFiVKsfE0/W6L7OiXsCH9LWY8zZ8bSx2m9+IrtRiMtPIQD/iqT84F7DMSYFgQ+MvWTDXACiowqy1re7M6cK4GCs48JcIfuVQhbzI64Mbbyjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WVHzWgqbhg88JKJVhblyxQJOzdUwR0Ywb3+9C3pYUFDiaUm9OoB4b0AY50Ju+4DnvL3hvJjYv/nM9udGkY8AUPAkGu4Jpk0WsLW6vcYTQCfMui5bqC2CVKDVKww1Gks3kv65NRitKyhYS9vpSk8mEvw+y7Hthb9hqYw6pmEsGYpZtH+OR+5KaN5ZI8n0PTsy6T+m/wQoSYkFTDW05dOew5GDFL1H7jIlggZAU7wESH8ot1B4vAH1Em1c9rJw4m4uE8OcYx+QqME7vLIDQfzn7Q5FErcmtL358oY5ESX+42LwnahU6HyRFYROVBQPP+gdjLf3gtHbkT+O021PODDa2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=c7D2w98/RNhSmccWN1gEz6es4QGarW9WacdgYAGeZ+uLJ2ZXwHCSiYOgiXY8FkYMgjHaM1p6Jd84roaUjTvMx9YLdkeIGVgSsMTxq2lsZ5JFuX0MwzTCMPZH8t+1cd9GgUulkUEj7oVChKWazt8RrqoAddzG2Gp41wFNwzAK7Ak=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7717.namprd04.prod.outlook.com (2603:10b6:510:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 08:21:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%4]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 08:21:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Kai Song <songkai01@inspur.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: Use kmemdup() to replace kmalloc + memcpy
Thread-Topic: [PATCH] btrfs: zoned: Use kmemdup() to replace kmalloc + memcpy
Thread-Index: AQHXuC2wxUmuzryjrk+2hZq/XlSYiw==
Date:   Mon, 4 Oct 2021 08:21:00 +0000
Message-ID: <PH0PR04MB7416A09EAE9BF1C2A0F90C579BAE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211003080656.217151-1-songkai01@inspur.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: inspur.com; dkim=none (message not signed)
 header.d=none;inspur.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 198e9a5e-8cf9-4f40-cf8f-08d9870fe685
x-ms-traffictypediagnostic: PH0PR04MB7717:
x-microsoft-antispam-prvs: <PH0PR04MB7717A7CDFCD7DE1EFC117C699BAE9@PH0PR04MB7717.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: agkGzHWjcYZx+YRWlisQX5ROrd/jNxi+UB6ezZv5oSt/kvTZ+jAxG5o1lbBiomXutP14BkaKcA+1tQRuQkLt+OWqNAQJKicjbKrT2ZL3uO/6lRW3aIxHPuz4RtBQ6Lf0ddY5h9nadeEvM/u8YYDC8Nj9LW78/jq5G8HzVqpu5xldc9fHB+nRF2Hdewjgn1tdkY/3CueAi77/97D6HXjM3AxkDlbho88GaeXplEN0xOoPHOirbIbgFGvHwGkw0B7WGxcrHGiTHD3SWmd11abWXGhIZ9Uih2P29/Q+5hgzapOLmmeq8Tz/seUSeGPGrr2agGCNiZam8BwvCLPqacTRBXnn1p7h515wmhh5M1RyXhC5EDxGvlX+f9xKPMrypyc6llyv9zM28+ttJZowCYv5PtV+bP+fNXSKTmjP4q0WpEHZLCuBvVqlDc07mtZfgoZINpBwlvDEkRqpqvr1kNZpX/QfKXStN+2xM+LtIo2IOzB/SV588WuCIHK5bm5M86jUeFS9tDcNpzLFb1yt9x4+f4/a2Awv9JsTPXaPtAKoOhOiz7QMY4pRCxzJxh1ARPYuRtMtBBFZKdfTmfEfu01PLqGkvSkuoWtdy/Pg5KsSg71fXv5GGxBo2++l3LpLxWwHSY28OFyJl0fR2tOz9bxlEnU9aj1HZshC9FTQHXzpIqpzMsHgruUiG39WZyurnU531DSooFgUN+dyUuZJd7uKwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(508600001)(122000001)(55016002)(33656002)(110136005)(9686003)(38100700002)(5660300002)(19618925003)(38070700005)(52536014)(4326008)(76116006)(8676002)(558084003)(91956017)(86362001)(54906003)(316002)(6506007)(71200400001)(8936002)(4270600006)(66476007)(66946007)(186003)(66556008)(64756008)(66446008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XwD3aqfwgLIO8+G5lcd8nh6pcgQR6eKk6Jh7wMvhnEimjmJOp5VpK79QqE7L?=
 =?us-ascii?Q?Y8JBGTv5s37gQxFQuj0DWlHAYnpPtHQLCodRls9FoL9xmtSwS9YGINL7eS/6?=
 =?us-ascii?Q?E/5unQrdkey3RX3MI11y5C8OI64QGLPmsCK9Y17G7YtrIhxKhqh5aHO1aj3l?=
 =?us-ascii?Q?pPSfkS81gJZAJAB1efMPCxhWq6Lxg9xaBnuxFDCSPKS5DsRKdZjgdP6nNiOo?=
 =?us-ascii?Q?2IMp/fukyRo0YcvbnAzI690kjkEjvYy4QNpqKy4+dUK0I1CwGOPGymJOacJ5?=
 =?us-ascii?Q?WnJA6yhI4gfJAMHH43dYYoqxspKiT2O1tQ+VdeOfvgTrxygqKhSbV4RSLXCm?=
 =?us-ascii?Q?cCCPdJi+Houfv+C9PsRRChvDYiUR4djZicq3mYp0pPeNlMcGM239sY6nDYZ7?=
 =?us-ascii?Q?PcclkCZLZZ8DBAhhIB6W3dbgYD0OPHIBkh7nvxNNGFUiY1eL7y7CVeXZ1COT?=
 =?us-ascii?Q?S5oIjAdUDYv87wsdZ4CRF7It1eW5K45wL09haO1cPm00vwV7eOyQ/mwZSJhh?=
 =?us-ascii?Q?eV9s7WRjVWOcO+1leqwXySY4uSdoJTlbM1hT+WBofTkyP44ojsmH77INzLmQ?=
 =?us-ascii?Q?15EY/m9j+zR/QBIwPZeHyIcb/lfnrQMkWYWYTP+kEPeoE1cPKtVPOS7q9y0s?=
 =?us-ascii?Q?a/FXA2DR+slUe8reqD+R/y9O2DUI7iTvFQ6bq9Z6UeaGDyrimqOmL2WYFnUe?=
 =?us-ascii?Q?puwaAGzU6t/aiGLRlZtI474YWUC7WWdGNQ4sHIl4pn+Hmc0ZU3wkSc1f5KvV?=
 =?us-ascii?Q?M+tPQthuuSEgyMOygTLUyDeJvw2zZHLr2TTxaudR4kpYSoXJsp4ejzoZkoeU?=
 =?us-ascii?Q?RYN2Ai//9hwAWOzaZp78nObVcqKIQ6ejFB/XxtyviRo9Q/gFuDO87fBWwcK7?=
 =?us-ascii?Q?0ceIeAI5+VmLrMoIQL24YhwqNlV5UNalLpdIkJpB+g3ucGCoQS5feleCMxtY?=
 =?us-ascii?Q?wwA9tV9TkBKIKpnK4hJjEK8Z1wcdV3Pp+y+luc47Y4oVW7zyWtbknHL0cMka?=
 =?us-ascii?Q?ZikiFkKFbUNaUupdppkVDbeydeQ43+mOhHt/dlxQiP/Mz81K8PLaY48c3XmQ?=
 =?us-ascii?Q?VGNaHS/QXq5aoZpAjIG4KzVCfO6ZmoaWrzAG4DkfWSQHriNKbkOvBjv34nna?=
 =?us-ascii?Q?2PkXSeOOvevoxComje8MCh+Cswj8DoVdCVWkQKjipDMevSMmXtX1SPgaNhQO?=
 =?us-ascii?Q?2Ifxp9628yxnXYwwQ7KgjO/IkamYimOsndikdyG5egh9lBU9Goa+dykJgFqe?=
 =?us-ascii?Q?t71dsv+p1oDglIQW3vyFxbrzAr4QYrQsDN2CIb3oXRfFuQVAB8jkJEKEMbTb?=
 =?us-ascii?Q?Wtau4h8XBR+cvX70atuwyIiadhi6ycjg8IXdMXfc6znZ3WIILPYQUsVpZ8vi?=
 =?us-ascii?Q?5ysCXJcD7HafAOBdS8sFDQcwS54O/pdz2yd9VjA2f3jh399gYQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198e9a5e-8cf9-4f40-cf8f-08d9870fe685
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 08:21:00.9572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDcv10c4fIhrLIAPNirh/uWm8KVN17tr3H4NC2hwD1UCS9b/4LSHehVRVsg7wQw8lKhoT/XNLVrWtf/gNFH0+I8Z0TGmA6dCt/mKLUD+eXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7717
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

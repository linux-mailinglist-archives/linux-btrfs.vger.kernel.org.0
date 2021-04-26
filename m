Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F036B435
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhDZNo3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 09:44:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20526 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZNo2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 09:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619444626; x=1650980626;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Vu3SsX0jX5tM4F1wTiweyAJxVnYjJYr+zwpK7OMGGXU=;
  b=etUSS15Qkr8xpWpuFpqgGWu8+pY64rFul324dyWudDlQLVf9OPbYxy3P
   taCUgG1s2YzCJUxrcK3EEU2u2hOItPmi23ueQvSSk/KJX9q6wKJPwYC6a
   Bg7whflzzJ4UkqJZ4x1NmrgJskFe7MEUCdbm0ygB6EGmKv1UeQRwyRRbi
   zL6rewJLRHG4PRj3Dc2MmDz97p5liqUa4Q+H9+kLyhiDlxfjO113Y8hqu
   WIeSqFmfBwbA9WO/rXRmyiOTye3yffzQCo5RWE6jplW3g4P/cmLLkE8DF
   SXCS9OtVixJDaC7PJuI5y//iuUJkEOht73yh1M5ga9dLDyvdM8M/m2k7O
   g==;
IronPort-SDR: kbtKo9wmnMAFzg603OgNmFnNKcOCCbPETYAUdMJYh8rL1vL95GL+mICvsoAp31f72Lixu4KGXu
 wCQsPkAtnnQeoxzznnjWLA0UZXTi9+F2LqXVCB6ompX70ww7I+NbOdw7a+yNZI+eMOKk2UgwnT
 vY60EhsXiG2EFKlTswc31gWWQ1gsBD+KtCgllUaqjwCtv9UCrr1Il2bhXUeQ81ysLnOHlqqr3O
 eMNmrrxPD7phRFBIgIkNrIuskzmSr1FXEtx/k0twfhD5FvFiHg3JR5w32WNu5esP4PCXiRN0KR
 YFQ=
X-IronPort-AV: E=Sophos;i="5.82,252,1613404800"; 
   d="scan'208";a="277273677"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 21:43:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKj2LBateI57TKw/18IFqtEk9aKEV6n5aicmX9KHeszr+4vHNUVYl9IOvqO0VQgQl0+1FSJ0lpKKYeSmH6WayzFNDEwkZpVaiBA+IEke2x0D9wDB2upn5H/Bt5x3X7QjPRymjm+O7kr7WBt702G+oDp+i57QxcRMxhAYKC/U7HxjHKdFRmYZinLasbq/0N2Mb6MkI9wfzx4dWu4IfefOarjkIRU4ozAT8w+xNOeCeMhQ4Ixn8PabrmpA0MGMNFN3lkaFDnMbo1mJ4dpRidq3GHYODcEAZI//1MnMbqxJF1SXkfEEhY9fljzRvRH0KvXkm1KIUuOQLkpyER10PChxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0Bx3l4pxTIyAgh4g27bsHFkdhOPqjbFslbadyDy5N8=;
 b=X+E34wjXNSxQU2xOBM6/QU7l5pkWHUfMGPffvf4eaMneJHlLAXpZC8dhO21V4VRsp+C7nIwL99xI2Hvgw5a3BfVtFCzHwoVWuc/WLXqm1xQE2ShbuQ5FYvCNqPQWX0+T0Ppyr2cm+Rrx2aI4zQZGokpfMnjvG5v/oRGNx8FgdS+XXs6uf5k0dIdceWWisld3X7cs36zqU63SB7aA4EDR6WZBXN66st+/xOWAEGfgHMzaJwKqxvFjgFLiXFT57qhZVdA3mQHmeu7IY21a//90aoZ2oMUVH25KjP71QBAmzrF2HHg/vwrpaCvoVEuElS0C3TNYLK8H70vqxmkkD63yhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0Bx3l4pxTIyAgh4g27bsHFkdhOPqjbFslbadyDy5N8=;
 b=U4fpCesI3I37NwNZU1X7AYBQ21CmL4WiPij+8+lDHtSHJygiX7RSRJREzEW08AEsx0USvXgB8DZEFFXkf0QkgTRlUr+sYujiNf4pXqB2Y8HVxQc3PMR+7zJgHB1i+b0Q60UOdyvhWo+oq2HrN6JBuIbqusOvmAemlDsGH7InxeI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7477.namprd04.prod.outlook.com (2603:10b6:510:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 13:43:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 13:43:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 09/26] btrfs-progs: zoned: allow zoned filesystems on
 non-zoned block devices
Thread-Topic: [PATCH 09/26] btrfs-progs: zoned: allow zoned filesystems on
 non-zoned block devices
Thread-Index: AQHXOmVq4B11nvzs3Eq9X4fqL8ljvw==
Date:   Mon, 26 Apr 2021 13:43:44 +0000
Message-ID: <PH0PR04MB741601ED0EF2B369D5E744039B429@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <3ecdd9e85e977d87443a503a41fc349944687d6c.1619416549.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:8801:a931:3ebd:289a:9adf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27ea069a-d0bf-4e92-c37d-08d908b94f77
x-ms-traffictypediagnostic: PH0PR04MB7477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB74778E7F321F9FC2BCA7892C9B429@PH0PR04MB7477.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQ6GGUIm3CeFXjzciaLoEGIURoPCxiKcA+d0unxumNq6P02P8PCQrCykaUcTfABZzoXj9f5NnQSAZvb+PRRJtwoGQFz5d66cBdgudYHRxDyuZJaf2VZJm3eM+huKaLDN3z9Ua1NI0nt/4iwac175E1dywDO6+Pl/sL+0Jr5nkAtCLEKCa4add1j93j3m/lxpRMbrQlGuy1zgnsjwUQcSb/naH8cSz2SInpEE7b7cqxnqi5zohkLcGuDKEjgemrgEGZmZ7pI/MUy/FPdAlqgeG7IK8T0gqtn9YUiiWYIo+bxkDbPRDPFe4hbeK3GQx4sYz4CQRT7wpR1Jqwmoqcw1dUDYF0p+XC7p9KnEsQyXfwOQ9cfbRkwnFuERSrT9lzYPdON8MUcGOw5gMOGVFH+bBLOe5ll9kRCkrWO0Letjcl1ran+bB3qW6My982LsQBl9VZfQgE4Vm2S7UqRcydnGrbmPi4VAcB7yvtN6GLB1hLR7BNYMkG0Tn9hoi/RO1kAH2yEHJ41VwDolPZ1SWodwtx03eQH4qEqJyAMUeK6Rm60q+GeP7yibyQqw1SfyqahJ9qqPte+yB8LGFkyfaCVBVIJT4C49LBqEIRwLw1XWnz4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(53546011)(6506007)(122000001)(2906002)(4326008)(86362001)(110136005)(9686003)(55016002)(478600001)(8936002)(38100700002)(52536014)(54906003)(7696005)(33656002)(71200400001)(186003)(316002)(8676002)(91956017)(76116006)(66556008)(66946007)(5660300002)(66476007)(66446008)(64756008)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xvgu88RnzKljZJ6k72SC3PsPGzJQwM7Xkq6kS7w0/a0h6hOupH+YayurIFDP?=
 =?us-ascii?Q?KSkIpM0vlbOQOzoC9h0jcSK4o42wbboe3UCMBX2B3lECL30/RwAyNXKBVaah?=
 =?us-ascii?Q?losK4bXdNLQdnfX2Kls/gK8RLz4FWT7qGCwzm7lgn6skQaH5MkzIFzLmGGGS?=
 =?us-ascii?Q?pvldCfWg/rjZYL8WnLosBtI17wbTWmM07yvp+6JcrDZKU0ZvI7Nx269CXEqk?=
 =?us-ascii?Q?PF6CC+1phQAdF9zpQ4pjNqSQYCRxAblSD1/VSbGgbo/VPwQbVlleJmFx9h1B?=
 =?us-ascii?Q?XqO/ZuDUGDqkwaClY8quQn7h4lkP79PoucGQCdsYBNLDWaziGlZvkM2HhS/4?=
 =?us-ascii?Q?9FAmR9YNXrcWkEfHuNfiIJj7J/9UpqQlN3sYbnUW4stQf/8NnHm+Oy4vrmrU?=
 =?us-ascii?Q?bPFxfO2RILZYj4QX7YodpWXxUlJZ5sDczSPLDExDxGyMzBgCSK2RK82jfGGB?=
 =?us-ascii?Q?Mprbr85R45gAAp3Q5t5kXB2dluODSGfT70yyCap2q54NBK9GZfeLYfOI2KXk?=
 =?us-ascii?Q?2sX24fEPRlx+5nErrdtM4lAqvI5PjJ+pCsQos+rHFdCyrYcEKw2lVBnIwXcE?=
 =?us-ascii?Q?pROSXonXMOGC5mmTcXvHeA6rZO8XSmHhV4tUed9GrYhS/T4Cat3q7ugKxn19?=
 =?us-ascii?Q?otu6p4xKv9OQVIj6cJxsaevzOahF6jy3OOeiqXJ+qOE++r8aKWGR2ZY4wE7q?=
 =?us-ascii?Q?HOETITbiZR6GPRuquwArOALuiMzk/GCkHcf8EnP8dmj3cKbLCBKcKo3PXLU+?=
 =?us-ascii?Q?TzylKJwBpJo3LnCIAngFL2tuPqrpvlla9f6ngwsuYSyhtVyEcdOaer3ggHVF?=
 =?us-ascii?Q?LeGlf8AGV0YVGN/H+zZvs0FwhLD8xwAWYWSZrExXfqTaXAy6qW30ZdoFCsNp?=
 =?us-ascii?Q?KYL/7qkwW44Oek/WkUuUW2VGxcOELIRhA3eRKw32PSIBuAC/5Sv77kq34SSK?=
 =?us-ascii?Q?65pj6CO6S7y9YAS8ydzyJwkU9mG+2PXNachT5mbzhhzFzzLF53fqLSS1KKb4?=
 =?us-ascii?Q?ILQGhVl6tjY3Y1ZsZabg3jCKF2MFn8GJeCfgcq077XOomxzt0wv+7MvU9NvO?=
 =?us-ascii?Q?iJw3Gswz1fnop99Kg7gD8rs9ggH6wZAX1jQiLswTLC0WkNG7ecQ/xEjFwcdi?=
 =?us-ascii?Q?LzJLAWKNsrjKb8Pj9joa1gVdqtvxATHVwLtIxBEzacipV3l/ZRpl+lzopvNC?=
 =?us-ascii?Q?R1Mca92nvqxRRgcXENcmtll9gOGWcKmITpF60cnXdTbZ/Io4RR32Z794s1TY?=
 =?us-ascii?Q?wmAa7qHK6B2ty8T2N7oiOZjcIXXh+drNzh9wRQW7tKhM0whd1z0qu5Hr378e?=
 =?us-ascii?Q?sgDRcRn2y9mBvd1qqY3FlJDzfGr5+qAbcYdHRkBgEzTXKtzQ1+AZoh8vy/eM?=
 =?us-ascii?Q?B27HcCtyAqC9McEm5tauVZE7+riY54x5Ni7IilkyOcgJ/sZIAQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ea069a-d0bf-4e92-c37d-08d908b94f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 13:43:44.3970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHK/pCkxs4N3/asmUPHSTcjjcZtwI+d7ZSn27ST6OYpabKX46vkgx8mz1UuPh5Vd+3xILm/7PfI+9sg4H+aBwcpfrFBYDLGBWdRmDNzISXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7477
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/04/2021 08:28, Naohiro Aota wrote:=0A=
> +			}=0A=
>  		}=0A=
>  =0A=
> +=0A=
>  		if (!rep->nr_zones)=0A=
>  			break;=0A=
=0A=
Nit: double newline=0A=
=0A=
Otherwise=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

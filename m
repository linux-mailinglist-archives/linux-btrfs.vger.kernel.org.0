Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE75A3959CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 13:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhEaLiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 07:38:09 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31018 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhEaLiG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 07:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622460986; x=1653996986;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7xaLn9tmA7MNlUyPWkZFD8cfTaYJaQQuf6+1Gn+xBAE=;
  b=gniN+wlppORHy10TB8n6HAk5PzimlPpKEz5ZFx6EkXautUBV/Ix+3Mfg
   NQMaP84yae9KVuHt+1+EE72VYQeve46yKCLzT9vpoV87JtgOR1JWNjWA3
   CYZJVACWYwTQroAKy47DT6+2hT0s2Xjr3aaGjuDYq2t9jcH1wl559BgTb
   6ikwxes1uhR4J4JG1VgZOEkomuDYmuousRFf02awGRjbx5l+ybX9+iQ2S
   VZaouvRtoH3Vu6Hq9I3hwjwK49shGpgfV+h+YS796B3Wqrl6NcL1vGLte
   vHbYYbhOrm5jrhYr36XAziP3RgDIUJ5r5BNVk6BjTK+C5jNEGSn9SR+9B
   g==;
IronPort-SDR: +Q8T2vqFHJ80k5lpcntvUE/CBgHvul1/6/49zCmJ/JU9iYuRhi2qoQ8lgk1VllF3jOSKIvpYhr
 sbQEKw1/gbA/kMqM2jUH3K8B+P1UkccxuMhlIEnKy/rfq5PhhF6iAKpff8x/Lyawc9VwEx2ur6
 4GXD1tDX7SCkPPRW6tpEupn0csSk3aDPW25PDj0ERP7Hu4F0PPS9s5y+gDcbWerbk4IYGaJG7L
 NqervfgnOobo6FbZxHiNP3K59jDVdR6qUzmBL25tvRzFbgbULTm6ERo3Q5QhGaA0IykdoYgBSa
 bng=
X-IronPort-AV: E=Sophos;i="5.83,237,1616428800"; 
   d="scan'208";a="281517363"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2021 19:36:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjsR/7UFYOeNRLqB/RRNISoG4dlQlAsv/9mrvE78t3b3UCQ9484l4VcPh/VUw06JUh1lkykflgezchzmf6Alw8ZYsBmvIwg5n1wwtyPBTK/wl4Pe6EHsOwqJQjp8MLkjiDH0a9wTIhVTd6CWlhpvyt6G12wheWo8NfZ+7kbAAItLXdH5G6GS/hio5zRqpHn+DdAy1tP7oN2AZwXd6+FLio+q7p59xyLJ8FwLp5sKnATmELJTCtqIby1wNs/LcDUeFX+1koxuaTpSR0JerzDB8crGWS8xUxYs61pxg0pviZ46+jYZ1EZFBEquFVdUczs/WPWIbL5CrHzl1bggmk9I/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xaLn9tmA7MNlUyPWkZFD8cfTaYJaQQuf6+1Gn+xBAE=;
 b=l2RbQDFhgZTI9gw44tEXdhhgzm8Q5OtxRhITDdKHACiHwsT5p7ef00XsSSc58r11jeiIW+98Eh4lmLoL2jwaEcSatm1O240o1J4Kw8xeR8sC8NHJjOWiK9/G0M1UD/2Ysvg4mfKPkp0rVOlJU8GO5jywcign2yhd4gV1TUBopCSwxVPhtbCN18FWveEE/HxDVhBCTfUkMO6dELvzLZf0Kz/0Ah6W86Zqy5Yy18MsL/swm/YlvlLR+X0k6VMMNV0snGA0B2yIfOhheJkeKk24WMOseMTElsIscjDhxBlBMHZI4L1fIy+YR36oq742HwWw+h5kdLJlQAwoig+6HN9idw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xaLn9tmA7MNlUyPWkZFD8cfTaYJaQQuf6+1Gn+xBAE=;
 b=Lk5RYgTosLOMjNUXJ5vnkAR50holroHpMB6sso7ZfrZARIxVPJuJhAdxd0jPJ9ftTxCp5PxfkybCOitjIpO9ipcM6QNe06Pjc0NFqjX3BJH2wm+8q1Qq8eOe9yIF4G3gH2qy78AgQJV1McnQcUGcr48wSDnV7eUO4Gp+IuDnHwg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7141.namprd04.prod.outlook.com (2603:10b6:510:17::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 11:36:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 11:36:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com" 
        <syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com>
Subject: Re: [PATCH] btrfs: Promote debugging asserts to full-flegded checks
 in validate_super
Thread-Topic: [PATCH] btrfs: Promote debugging asserts to full-flegded checks
 in validate_super
Thread-Index: AQHXVf8AV2Tc+tiUaUqnbEkZTl7v4g==
Date:   Mon, 31 May 2021 11:36:24 +0000
Message-ID: <PH0PR04MB7416A269CDA4992B520F82679B3F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210531092601.107452-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5554b2f3-15ec-4a68-a053-08d92428526a
x-ms-traffictypediagnostic: PH0PR04MB7141:
x-microsoft-antispam-prvs: <PH0PR04MB714194377A27C4FFBB9253AD9B3F9@PH0PR04MB7141.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+auFYqG1f/ENkmEy9ghbzjgnq8g88Q/eQ8JRP85NVDVuWj60haYao8fSntSqlrpuJZiGpt3nMscLzO3OyKOqQgEbZF4QjpaFGw/u63phqOPE9elmYNqRt3nAwMZKnleKOJeoBn4CFwaTedm/p7o7sZCb5HPlmJckX6Sy0VGHgEeE0FS5SL7jyBvrDtfzijnwCgTPcg22fKyFPaL0K+NLrxqKMYdBpal64IpZT9ncd5CxiRc9OiyOXn9hGQDpIyKaum/ZUc7/izOThurgQZotsqF3vNMSw1TM58oIzjzfyOkcN3MBxJDyXihE1T1nR+/B16cGvN1XDj1Y7ngCorelKFZnZ3/lwV3Xr7a6NSBuNDZaR+yEQuRqQUr4V6lPaiPhTfNws1WllWJb0Ee+bhluYVv1mDNLKQhSZg5jgznz7nDDjzoz66HUMOWlY1M2Ofe4pGS9QiJldptbqjWguX3dDJCLiWa7V/JlIG2jIf6Slt8SKyWTfWkdBDphF+ttDVlG3LVH1glJb++/6imKol6fCx348PDGTrk7ZSl4S6IArkwY0psgKHMq7wV7DC8UF20oT3+mcQZUC1Y+n0bzP5AOtJNyukNv0c7CRnOA6XrsCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39850400004)(136003)(26005)(86362001)(5660300002)(478600001)(53546011)(6506007)(55016002)(7696005)(2906002)(316002)(9686003)(8676002)(4744005)(8936002)(52536014)(83380400001)(66946007)(66446008)(64756008)(66556008)(66476007)(33656002)(110136005)(4326008)(122000001)(186003)(71200400001)(38100700002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5yMtahwfMRkQZaDzGuK4+MIceHrbWY+Q6GnzaCM+BpozGWOrDEnPgXQcJy6t?=
 =?us-ascii?Q?fU1d9AVtyWnWl1cHBLLzNBX9Tlq9gIE5PPsk5Vyj4+FbZkFBNNRDiuByakLO?=
 =?us-ascii?Q?+QPj9wlIN43I3RoYDFpCh9z7L1Z31s9Ex0h20uYa92vt83TQTXDF17ffBMIO?=
 =?us-ascii?Q?NnoaF6azUUTmfdSYrlW0VrtTmIm4lcWhHVeqkb+Tc5bz99v2A3o2fPSNipWh?=
 =?us-ascii?Q?TuNhRqTYH2p2THuM+ReOlU2ZFleKmCMbAs7nPO7+5+mskaeearAf2MvfNrdb?=
 =?us-ascii?Q?cw/m/Bhu2VRw3cEjLvwrPIusDL0ng76uJHjfgVeEDh4jSrX8/PDgnuIHSjmF?=
 =?us-ascii?Q?NNBa7s+EMBDCZUupCoEOMVqrTejqDxNLKteTV5rUOwgOhAFpGh/t68jSzexB?=
 =?us-ascii?Q?fBzjrdwIOxIbW1y9fiCo2SFRca1SgUIZcMmSD/rJmVfwatOf4g5/XJDGJQEz?=
 =?us-ascii?Q?+RY7DUWRM1F/zKSRlMC7NgbX3ymfxpMu34VKb/WAj+iLxbUboPX8lJNNgA0j?=
 =?us-ascii?Q?vvwoHytKWmFPxG9PWo+r3m7dGOdz/y11vvoJ6OYOVPu1cD0N4ZrcdGVGLSsN?=
 =?us-ascii?Q?gjxFPrHdqqxq/2HDAqaBiMvZENV/72WxHy72D2IQhajxXken8DrwIpnFrgsI?=
 =?us-ascii?Q?uta9p9dVMVWUgMyLWnmQn1wIilwvOmGDzJhLnWmiTt5zeDoqJo+QV8676qFi?=
 =?us-ascii?Q?MzY99VqOpQevVi22tZG6w6cLaxKxUI1F0T6veHSvyMAxlJ76wbPAFQPJfK9+?=
 =?us-ascii?Q?rOIRUpiCUSDtwVQvJBpjVTdm/ey0HpWe5XWfbLfqQwsIXSU5SZwkCcrXqltd?=
 =?us-ascii?Q?UMoiNippR3H0AOJg2DrD+h25Mphrtm//J0vUKWPczbxBSplqkTmtk/WzvYTb?=
 =?us-ascii?Q?jCeHsFRgLp3kZpjGSWhUmgRt2NQqpvvyRru2XWv4wPzYLzGrcDqgEp0AsgVu?=
 =?us-ascii?Q?zqk+tXk2xr7Of5AiOdEG4ZP10b0DgyNpwcYdfnMBXzdGv+Y/x4ARAfFa066S?=
 =?us-ascii?Q?MBlgmTKGyEI68hehYTUZp6JUVtYlmSORPtGtrqTxFDcjiSOPlVOlYaOB5xr1?=
 =?us-ascii?Q?CtUkvOPDL4wEM+Q9D71PrGK2GodX5hwL8d+2SZ/8DKDezV4VHwQH3WTpxEtw?=
 =?us-ascii?Q?qgT+nvmhzcPldRW6ghATdzCGLAVp+Ok3AMXNYhvFKIpMlAoYZMC9zQLe1cRz?=
 =?us-ascii?Q?QYr7+Eqqo8BFm1aVch2L/Be/jqmkS6o4HjFdIwPKLui6MvBNoUWXVBFt+OFc?=
 =?us-ascii?Q?dY2zBM9IOl8Jc88OX6BRMtKyneSyXdkWAfOVHmB4fCDQSrGD9WFRlYAcyhiB?=
 =?us-ascii?Q?p5DkmcT3EsqUBbkc2vbLjkPth5EspD3/qXz2dvLQ7X9gqg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5554b2f3-15ec-4a68-a053-08d92428526a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 11:36:24.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlXvm8CLxHwwCfbBe40PMt0cwhtGeNdnOqjgC1MhIkKo28YgKWFngx5ookZoz6Fyw/1fgl3KWDiqVlEoD3rj2ItwC7d3IQ9SvyTKn5mo13k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7141
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/05/2021 11:26, Nikolay Borisov wrote:=0A=
> Syzbot managed to trigger this assert while performing its fuzzing.=0A=
> Turns out it's better to have those asserts turned into full-fledged=0A=
> checks so that in case buggy btrfs images are mounted the users gets=0A=
> an error and mounting is stopped. Alternatively with CONFIG_BTRFS_ASSERT=
=0A=
> disabled such image would have been erroneously allowed to be mounted.=0A=
=0A=
Agreed,=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A701A462A00
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 02:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhK3BzR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 20:55:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49740 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhK3BzQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 20:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638237118; x=1669773118;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=UJS49RcDySi5765WzEIdtwKfg0J8gynnfSy2g7fKg+w=;
  b=XBVvsAOaJ/ndcB7g9mIPwMXAZYGSbGwHxv7OV/CPKQc+ODuIadK/ho9F
   EYMnvVceEIBkwZxgewF49YWvRwzk/l5zqJHN/3vZgFVTyTYeOwpjXy67w
   YppgSAAYU+6p6ygVuq1iJyZEkNLx9r/rnypUF7cODKjoy/kYd9pYPbso1
   sbDhrH1rb/qvjV4Q4xlHsWEsoh/AbPv3n8wXZdzjH+/lXrlkU5u96WnGQ
   q5THrV8gotCh5keY6saXMv4OZRx6XNc9EfolEwRmpkdywHAd0uHb9QPXH
   epUYhwk3MOPcymyey3wgkDk7HY/AaX84tie+UUJx/AAsSvgQKDy32eihv
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; 
   d="scan'208";a="290964785"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2021 09:51:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd5bXxMbzjvZqdTzZzCrnOmgGmrylPf7BGdRsgerl92tJUvSMzGWyYkpmgdLvWTuj0M9e5hlDALvF/2lg0xXxDB1hzlTzcmun9KbpJrBjYdSMciYqGs0Xnvg9WWvHWJqdXNlf51f/+Un432y5kJZU+xp7JiTvhZV/gRSwFJ4AiF2thuwsVGMgbkmsAKJpjo2T2UkgGjtxwu6brIku+PXtljbKPcVfgg+S3DCBF8y3fKSNI/gJCbNx+v75FIf8EDoTVNuUgsW7vk/Of8rCgjdB9vaqD8NhdtQzB8BXxNYDd6YADdRpZwwJD3d7TjxdpIm00EdIWKnThqXic0fgT/8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJS49RcDySi5765WzEIdtwKfg0J8gynnfSy2g7fKg+w=;
 b=Qvx+hDCera1rgQMkiD9JYyqJoNs0uQFtkruEh1zyZeiwN2zBgRiGCLSRWBZg37dFjcohQ74dY8nH4KPat6OZUDyZjVD+cZ4ntPV6aLQz2WtU5aecEIz1BwMloKUJdlz2UcCddVNGs0j9X7lOa4uyEAdN4RkTwPu8gSrDtf1nAv99wxoq7u58QBgMkNKKXp/aOpidGRhojsrUnTmaDRSzW7/2gI3hHZnwhQduxJhiXguJfirwngAEe4IMdoMCJc9bcRTibanHYHK73/zFnJBXwT527k3kxeZ/hKoBlH3pBVzE9BFaHO4CiA5tzFPCxDutEJK/8Ph4Wif6rQut83FgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJS49RcDySi5765WzEIdtwKfg0J8gynnfSy2g7fKg+w=;
 b=OSaLhNIR+oYUO51HXZRFl2ESp4Q8pg52Ncf9JdGDcLl3sJSEn4YViKl3k7Gdw2DtQbCKSdgcIAEi2DsRs0aWgX5flx0E12jsXuzs4Eo/r12EENg3fsX2hRAhTXDpuHS5Z4KOvFX/kMBW21+e4UuiJQmBaIJF325Jp2XJGxiIl/c=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8341.namprd04.prod.outlook.com (2603:10b6:a03:3d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 01:51:56 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca%8]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 01:51:56 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: fix re-dirty process of tree-log nodes
Thread-Topic: [PATCH] btrfs: fix re-dirty process of tree-log nodes
Thread-Index: AQHX5MvA/+z/V3kvnUyJVmnnWwCHmqwabSuAgADi8wA=
Date:   Tue, 30 Nov 2021 01:51:56 +0000
Message-ID: <20211130015156.zq4wszqpddg3jbr6@naota-xeon>
References: <20211129024930.1574325-1-naohiro.aota@wdc.com>
 <20211129121939.GD28560@twin.jikos.cz>
In-Reply-To: <20211129121939.GD28560@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85369283-5b02-45b1-5a2b-08d9b3a3fda9
x-ms-traffictypediagnostic: SJ0PR04MB8341:
x-microsoft-antispam-prvs: <SJ0PR04MB8341216EE57B7B88A11C02798C679@SJ0PR04MB8341.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+ky3PdnlsbLlA5mRcKDhjgyH2W7s/YdNWwEVS6b6uWZupdqKa8d1Gxd5cgncbpqwHD+IFmIWlNuUUbhBRHoopdQ/ORl80dH2E3OtNlLGxNpi+1+CG82Ejd1JQYkgKQ/HGShkdhW9yulSxm/SG1ZcjS//2VXULYSp+JKmUWYeSGeBi8zERqCbR6iZeaSAy4B2ZXSzSPcAaMCbM22BpmIcKvtNDi91B6ttGd65xLYfRmfWPQDtRgDQcw70gqt1+S2E4cMpDWSEyVFxCIxdw8esJTzKZ67Wm1Tn0HHf23eNFTT33vTXA447umSVgV/tBTg+CKvm9pwAHswMCXryFrhqFmgPC5o/Fvn47qOIZMDw4WSXtCRki0Z1NgtYmTgsUc5xaZYZeDvuVOIC/iNvEa+9f5aJ6Npg+z1jxnyp869vpO96jk/jXG7+kwrsVJrXngNaTXqkSQZSBmzVvYOxvt87y7PXdyvJKo6kBjIBa/QLw5QmyJa3uJh0l/rxEIRRi69LebqAspoBIX3EY+rpcGqV1/sNciiYEkvKso7ohh9tyj+rXchmLTCsSSnHqgWDb/botNfvss0foI0rBQbswwaksI8yz0ow9bQBVh7SKiijxbQzESs4BpBp9Tm5qZdFglKRSvgPb/Rut5+jDuF/jzAf/AwtT7lBLtIhSfZwrO+EiNiRDsfF9AMGNDiRrD1OccUyyFLJ6xO2j6LHQiH67dqWVdPSYOAru29ZEh/dXHJrIMRrtMM28sL/FcH0U71tffkA3xnrt9gcwr3BH2lVmzuHKz6b1a9UCcrc2Wx7P8Z0wbiIJN7zpZYcAfagcVDED4h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(6486002)(26005)(64756008)(66946007)(66556008)(66476007)(66446008)(33716001)(6506007)(38100700002)(76116006)(2906002)(6512007)(8936002)(71200400001)(91956017)(38070700005)(4744005)(5660300002)(1076003)(8676002)(86362001)(9686003)(186003)(316002)(508600001)(122000001)(110136005)(82960400001)(966005)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LrC35d4/SaGk7j5aXAt1nXV7xaaH69tgubpg2sgH0tcPCMTrlcFO0VkMOI1f?=
 =?us-ascii?Q?KxGA5QZisEc8X2HIRZ2/UDaOA0g2W/Wkv+CK65zQneqihbx9hVMiEFBJBK9v?=
 =?us-ascii?Q?xVgqJxccIkejUIcXUVi/s/enlV2DxzWssMDcH+2Mv+vlBnWGUrz2RPgu6n0t?=
 =?us-ascii?Q?xzfE1aHxlt3BeEAsjPglY58JWoVKZe1llSlVr9VKvSup8TIQZiiyrl6zxp/T?=
 =?us-ascii?Q?onkiLERs/gafqvqhI73OHGQNcPR1hhAie8N1ShCfq6qGMN4sXKfjuZcAz6aG?=
 =?us-ascii?Q?H1aCrgMY8Zkql+9Aql5Mph+tA+rACoCxRb1qQLgh9ZR8EbgbnraTxab0kQBw?=
 =?us-ascii?Q?Azo0B7AHB6SuwKykOACKLfL2YL1thEpsbsHPa+EUkvcCoEamsblKep5EniAP?=
 =?us-ascii?Q?3Mn5EyhMRSAckImQ6V7gd48KZfwNBRSztvqx5ESKxAR/+/hxgV6bew8zJRB2?=
 =?us-ascii?Q?YkYZt7ceopbVJscGKUIAGadEGlrD4Noe/fzstvXRa2RdI46PXPI64MS0vjZh?=
 =?us-ascii?Q?0qNe9Kw16x+o28GZG2XI1MIjcPgEZRA28dTMWRH0UbpXN8dLtNLSeLv8kKpS?=
 =?us-ascii?Q?HCm2+ztjt1b3B826zB3J3+Hrc6DmOTO3WYCrAyL16EAOnOkYaoEcs4Bs/olf?=
 =?us-ascii?Q?3pRcsndXBhqhgYT/uYyMHjBiNtXzFhezu5M+xG8NAQXUAcvyL71Jly0JOhL3?=
 =?us-ascii?Q?NfAm3VjJ1lXZazNO/h5l8ER5SUPGLXHSlQvDsDPWWTmdEAeWamIUsX8/zoXX?=
 =?us-ascii?Q?K+rzkiFeypiWCplgrEfMoXy+/9LZLRXkqyZWMwLqJEdrBeis5xA3zB7pAXp1?=
 =?us-ascii?Q?pQWyYp9bGTFhRqq6Za5dfAyNhMOOfPxlOemh8t4VWVk+m+Fnc7G3XUin2LQu?=
 =?us-ascii?Q?6spIOT7Ka2f5TjG7Ehw9SMGynfHUKHvlUIGNQhoZ+bXRJ74luH06y8SvXu1S?=
 =?us-ascii?Q?Cl6gYym6WYz6eG2Kb79IzC9G191MaKz/UpqHWRjkKYuRcNOZmBfl8DIQhWZb?=
 =?us-ascii?Q?ZtoABAPAUI+qtbSFTTfp8SN07Wli2lirvj7DOoBLGHyZkD8J4zkc72msoOdn?=
 =?us-ascii?Q?3F/UDnfTUJFc9mTRiAx58pcr8+vNyX2c3/mPzP0BNkkKoIqHR2wS3OrWpQW6?=
 =?us-ascii?Q?t/Cakeczo0uUJJaBQSmeimbgFbR52pxPbk+lcaGW2r7ElvWca4M+Ac/zfw8Y?=
 =?us-ascii?Q?oRmyPt7mVwGR5W07UEs+cy8WkuicwLKZPdzYbI+zJGUdxXNu+AyFoQiHIKp6?=
 =?us-ascii?Q?safiunqcfkvUt9OCrq7bUB9VM7fwizIxa1wDmRLgkUzUrN1ky06kQvHNP4ZA?=
 =?us-ascii?Q?uvVue7G3vNVJzKOaC2mZq+/Eqo6ZbPL9bcZYQy33HVg6el4+RPZHQMfjeHs4?=
 =?us-ascii?Q?Cn465JbBJtHtPcM+6AKHYNQj2C9Z2NYYJsWvjAr1R5NKAE2kS89zH6EjBv2w?=
 =?us-ascii?Q?iAtgVvP+o3bKDL1ZBsSW9dr+TBOc30tLhFC5WD/WitJIRVe/ixenIMzCLiWP?=
 =?us-ascii?Q?q0iDrCNFAKk1at7VebktTS6FbWKfuuK+OeufRDN/fHB0QT8ihvWtI7lVUV94?=
 =?us-ascii?Q?1qSbV67BcK4Wz26Yh32dtF22S7Rex2Nwiq59JKwA2EJJYheCMISMLTkOpRk1?=
 =?us-ascii?Q?hIhy9ySfcH/WnzMMwpshOEc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CAFE95ED21FD94AA09D5046EA9CDA97@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85369283-5b02-45b1-5a2b-08d9b3a3fda9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 01:51:56.5087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BICM1TgWXBLDpicAZVsSpQ9ZES4CqHQYRI17nyxj/tLskHCXXwoTneheI7dmJs+x0cousonbj/f+WI5zTY+5Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8341
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 01:19:39PM +0100, David Sterba wrote:
> On Mon, Nov 29, 2021 at 11:49:30AM +0900, Naohiro Aota wrote:
> > For zoned btrfs, we re-dirty a freeing tree node to ensure btrfs write
> > the region and not to leave a write hole on a zoned device. Current
> > code failed to re-dirty a node when the tree-log tree's depth >=3D
> > 2. This leads to a transaction abort with -EAGAIN.
> >=20
> > Fix the issue by properly re-dirty a node on walking up the tree.
> >=20
> > Link: https://github.com/kdave/btrfs-progs/issues/415
>=20
> Can you please add more information from the issue that's relevant to
> the problem? Eg. the stacktraces, reproducer etc.

Sure. I'll revise the patch with the fixes tags.

Thanks,=

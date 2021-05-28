Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFDE394043
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 11:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhE1JsM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 05:48:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33621 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhE1JsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 05:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622195198; x=1653731198;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=mM36KAlyDBwST/Jo6o2ZZGCDvi/+Tpe1370x4Wan1oO/OopVoQiYcyb+
   /cuzx2XVCKgdTYsVNEyzEr459Rc5PJCUU2WfF7vCpObEb5cQFb8HB92rN
   WuAqZ+uuOIYt7HJUadiP7X9uNiz+QUqRemvQ0aeYXkUNOXszeRm28vNaL
   rc3lbyhSskVoBVAnhOUnXQQ16VjHQYqWfgnSNB0Fbw1HZgvFWjAR4+7hN
   U4tOeRo7YoRlXxJhtyIUVoWPYx1ISULQ9SGz/4IiVsz31m9FlVd84o7WS
   Hs++jo9UVpXmUECuCEcfsSD9Dy/iyR3IBoKcvppKycuhT2XapfZJJbQ3h
   w==;
IronPort-SDR: Te2060oLGRg/+ip+rRRSd9m44P4k03z9TL0ZDgqmmLcXdNjPkZyOj8OLo/UtXcF85OmMH9zTiO
 M7WzO26JF0ATyh8ICrOvkEwaOuqrYmX0mTopkMcGWwQjPYjZ5IEPBXkFKgFpUkpx4hHFUqhUEp
 9Gcr6angyD2uT3JDRDcyBa/2YkxI/RDqlEvke1lBjBImorSSaE1ANIUQ3CXhh8ARNjwQTZZFes
 M6emw/pFK8G3P4M5EF6ayWtAf5PyzjhFOQIizY+Gg5Ahe4Weec9qR0MyJIbJxl8xGAaPSgGuPW
 Xgo=
X-IronPort-AV: E=Sophos;i="5.83,229,1616428800"; 
   d="scan'208";a="170327764"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2021 17:46:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHH5nXlJSRTf03hgXig389dJVTDYCBfcqn2Y/bY1+ZmJjOcUlJPmQ4+4EN9f2usGLAZrEf7r665cjPIwXpMapiYBpNKPT11a4K/Qt962O1oV4eSR2VtD6Hna3+cRDU+5VYZWG8RSj8RyJlUw/Z42CpXqJ8Wo04MS3wt4QjMvHOQvo7Xzqxku76s3xCHnxTu4X+UmYOLvUeWAsEPx5zNwH/kW/4PjMn/ticwL29tiDVZaenlk1xknGRht1jA0N9sQklZZS3txg0s4G0Rx2mqfFy4OGALLpJwejx516BsCTwxZftWJZGjKJRi8JXK9Ad1jOReAVXpoCvwYiy/DKvwtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=g6iS5sZ3WuNZZnYWPHKZudns++epRuYtl4/AEuF4kF2SL6bZDDhWiYH+9sMgq7OugHODQt5nByrb2zVj+kP58+pbQdxkRhdBXz1yX3GvuFfh+Sq07tALIXIDao/7Hh2o++aBLZwW2TQ9sNyzWjKR40FTWqA7sSjYbemMr2Bbr7eoLr+GyIf0hSYkA0wAUwdEFYxCoorPX81wgqgkMAz+A0zxqeTMUJ+Yc3Z6eG78ioi/6xGh3Zatu9x4IzFvv/oxtWNEy+I/JTZQ7AiFOx8tp3zJu45OxEVLEhJJaui35L2AOzSRCM/NTx9znlGKoWOizDCGTZGH5lj9GwxBooDxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NPWNU8wXS3XWwGS61lctDMCh/rVTD22FpY+oOhCAeU8ojpzt7ey7h6EBFOjQfJ7OB+zYO7eoaIMVymnZqccwNSnGDkphKVjaX1I2mbM6nzeR2XuJyReiW2r1EMk8Pt32ajLssH/aKgL9kvZ+JzEt8kg6EZzXS8kioXEcFmVNJrQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7590.namprd04.prod.outlook.com (2603:10b6:510:52::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 09:46:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 09:46:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/7] btrfs: defrag: pass file_ra_state instead of file for
 btrfs_defrag_file()
Thread-Topic: [PATCH 1/7] btrfs: defrag: pass file_ra_state instead of file
 for btrfs_defrag_file()
Thread-Index: AQHXU2kq+q2bDl4Fwk2HQN9CHnldTw==
Date:   Fri, 28 May 2021 09:46:35 +0000
Message-ID: <PH0PR04MB74166C924004713C7018F5889B229@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210528022821.81386-1-wqu@suse.com>
 <20210528022821.81386-2-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:15a4:7fd8:aff0:9452]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21b6b88f-f3e5-4250-f53d-08d921bd7b88
x-ms-traffictypediagnostic: PH0PR04MB7590:
x-microsoft-antispam-prvs: <PH0PR04MB7590F28C4F5FF669669F23A19B229@PH0PR04MB7590.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuEtybY6BIaic3KInODmbU57jaq44jmpez08mtIUSxrCKw4J48nWpRzYw5szj2CazEIvL5AAlgjbJqtto4ClXJnGIIUtVEAnuNJ578o5OfL007f36LR3cAei/gYfsac+d8eF8Jc+Mu3v+XGfxa0BwvPkQ1tygHauNG5HwksMHUkoFbWwsQ3FqKHv6DFrjPts9f/KR4cXF1y6t8/BGYvwZ1vcE+SX+XAG82LDi7jEqGGhsbILWUQVyLd+GauYf+SwERx5l8sglP1dFtV32QVyJOdHHsAsaukWc5luRSAB1p2O1TJN5/cGrLpXCCb9Ub+iz5UDnNN3wx0lgmnZqvbfYAOrouENcI5rynUQGQFd5ndLRTrKo4dJeDGKEg1LFwr7cbdkPF0BsluJedMjjnvBc42LzUhvGwyeiJtNxGQY21IHmswkbjUvJRxcnnOQPkaHUEDH2n0VZpLZKNsWIryRkQiWHFD0o0rUkgvJIh3HJqjXDnUDGlZFX+GS31fsJMVnmfw/88kv3JvhV5bW2B9cP/JoVJm3mCiQt8dGUB+e8xJSPInKpTNGf2HvXV5KFPwDxguJVgn2J7qllrTRNdzB1Gnz/1+4lgYsOr14qG32qo4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(55016002)(4270600006)(33656002)(71200400001)(2906002)(52536014)(8936002)(64756008)(7696005)(19618925003)(186003)(66556008)(38100700002)(122000001)(66946007)(5660300002)(8676002)(66476007)(91956017)(76116006)(316002)(110136005)(9686003)(6506007)(558084003)(86362001)(66446008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?w6nLeFyRz7FsovCIxE4a+GRDVB8T8IKBBY84KVmXsNNrvL4uYmw+QvrIJoKG?=
 =?us-ascii?Q?UjFRQdBWwM/NmEFLfDdiBWrY6DhHK3j7yKc4T21p3pS3RR1dATnGT2WZrqp2?=
 =?us-ascii?Q?g/UKnJkHK2IwX6Jd9LRsGzzzezq4syBqTGRXeH9X2RvVU0ug0Jd9CsfUuU2z?=
 =?us-ascii?Q?ht0epBYq53YG+bZozBdFL1XXchSSw45J+n9Q5SZAiquuO53mPZJmYiVLkkE+?=
 =?us-ascii?Q?fRC5lFnuTB9LgS7EiqGOqJ2hOPo/PAt4Uo81Ti84nPILmvPI0JVWIsykQeOu?=
 =?us-ascii?Q?Hco3nLuRyfdvA7niJqmcGkDJvYNxOORb7/NnNiwOdJlDK0Jtgbd+z9LXgkLY?=
 =?us-ascii?Q?DTbAGzynqceJ+mXj4A0NhDbAefd/jHFkwz1v1qC681KgslhGvOPy2GXEiD5F?=
 =?us-ascii?Q?eMLMk2Yw1nbArBBDzuMc34Rld3EGgHRr3SkJHXF+4oS/Odw39GWbIDe6EQj2?=
 =?us-ascii?Q?fxOE5dR286bxoo/PoraCqxKL+i6Bf7Q1aGqYGjfa33WzZN3TGcelqxsof298?=
 =?us-ascii?Q?ea1BU/6aeDhyViSUycVNmJJ+shozD9FFtspQapExNf0i8vwQvwRGcGJxDZwF?=
 =?us-ascii?Q?6EWNOaowi6iqoNTZYU6jSrMcteD1tAaMjXaN7dielzORqMxgloQZl/6tfxQ2?=
 =?us-ascii?Q?rf7Pf9EvjFNzQ0uulvbAw0+VCforoI6IwyA31G8Y9msZ8eE/MNKK6EHzTqeC?=
 =?us-ascii?Q?EGGzjRhg9UIvd5oKgh0WvlK+woI7g15KhcgBcvqrXox+7DB55pOaPRA2HEWN?=
 =?us-ascii?Q?v2MKLqE77pXStdew599RYGY2321GrCQ91EQHx6TZdJN759WUpS3K3KOD/09Q?=
 =?us-ascii?Q?+lubBlFZk/2FeOPekpyNwWDA04pczQx5OSZY1yjfY/e2tYQTrZF4w+ik4rcD?=
 =?us-ascii?Q?m0tRo6zi1w+jARk+ch0SjiqpUm71DROHxF/jvVSMYLtABCCZyZz/sN/m4W5M?=
 =?us-ascii?Q?PxT17eLAcKtER/22STSS67eJsISb+OZ2JQnCd4Q2ibXHzV7VS1MNUWBrPz+o?=
 =?us-ascii?Q?R/jcbxp0Hl5K+GPc+0oECzbOJwsbau8IGTFpC/4Z+/W7C1MNauaccFfihQB2?=
 =?us-ascii?Q?50wco/QxzP9FJ8mgLOsBL4irtRwpx1h6IvsYLtBxRKc0NrnoswMuWob6wZxO?=
 =?us-ascii?Q?NEA3p1B8fCIx8Wx9IoIHD7kfedrdaekfrb4fwwCg8m2oEbQFPRyPRR1HAvcM?=
 =?us-ascii?Q?GY0GDv5Ikhuxckn8/ANbpc4zzr69N81QdHeRR2L6KB/WWZbnCldH7RaUdYc0?=
 =?us-ascii?Q?LBUgZkFGzF5MtBErtY0cY3ntsVmzKE1w5fTb4F/2QA+tzYsZA0eBe/1Qoxne?=
 =?us-ascii?Q?M99K9bXjjOOEil7ellp8q9nLwdvQZoSwBIHscfxyO/v9eg1pi0pIYb9mgWDh?=
 =?us-ascii?Q?TsyTao/6w+aUiI6IXC9jtwATtYWvgEyfy86rZPE6t4Dco5UTGw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b6b88f-f3e5-4250-f53d-08d921bd7b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 09:46:35.2703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KApJ4RM1XmVFsGn1jdN2wRzz+IYGETIO9AQDXFtB4lVj2UXUjCIOIr39Ro4hfM4JRMMXRt1GJ5lL8HS/M5GgyjyUZzxYXNwIvvMTUZNfFZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7590
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

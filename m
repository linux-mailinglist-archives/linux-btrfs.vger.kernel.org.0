Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E214A9510
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 09:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiBDIZG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 03:25:06 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47307 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiBDIZE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 03:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643963104; x=1675499104;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eYcvgETMJMRB+bO2UJ6YgH4+wyQoTcCfXoMfi9UF4pg=;
  b=iKiyFhnemVG4caMrfsLzQQ8o2U3tqE+UJJ+vsjFaHOT8b0zXIpIE17uO
   c+XzsBUO9U8q36t4cwX7a7wLTkGzaTL+QIq/WSrSpHf3xKX2KEM/QtmjY
   rwiPAVPbISLN6kSwo3KU9bs/3Jq/kTKZ58144f3985bD9kzaFlcppK4KS
   uA8myKXgaNlHhNJRgAxjj7gq5afPf1N5iPKW3SNQnx//jFlwcIghBYDWS
   IG0dE7mLSLOrYMQl9a1GI3GLaqtbE2qmL8CzVFYjesbuYCgsyxVnDMMhC
   TM3B+MgKS1zHpthuGI7PpfOF08r1jVvvjhlVCq7pBmLvRJ71AHFPsglPX
   w==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635177600"; 
   d="scan'208";a="191088201"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 16:25:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1tpVCo/HHQWbvZwN3WUAFcnMq1ERejmtHUeHAkg5XEFk3Wx3aBP7b13H+KPxG4gIkWatwMu6aqVdDhhFenVlPeSvLnzTG+gsXvvy5tnyP8I7bwt0jaceDrO4yD2HXaCsbckYYOpZOieyqfu+9DWo4RxGxW0cOQSP10BPPh9lAMxNec2nUA1Z+bQdbHJHEsyTYeMGUSeOCV1uZtAPskUrEiT1gJs+9jgzPbfnMgrGhFurjIQmFeveynPxzI2lWcog5PcnUds/+fuuMTCl6MuCZ3w2ep7s5mWYfTkF2qM1e6lyIAk3uYNbcpvlsZ54V+iQNfdJhWEWA/3Wxy4WFC7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t00awD4Fp2NrXZniVDpOmTNcafwKDQlrUU3VLYfRySw=;
 b=kUlYwg9kaB9RvvyoQtIrpOVTXB60LmR61nhv0Lx6w4aYD4ShwxIep3kMyN3yWwklJ6TI/mfHduh81yW8Ur9I48kG4IIBDNxMDtiKJC34p1BpiZ3r44HiL8aftB41QnC+OX+QnIOCDN1K9Kgln8MMgik8CizyLJYLDqxDwy20BITH2jTEXJjGlNWjk2qHFNR9jGoVuA4mrZ4+q7dyumOlyIvCGskFK7a4j0jPXt5HtLyLfVyFZCtkQR+KUpGOMuyPp/y7yQhyb84lPnSLWE04VtL/QASfZa0SZWhw1k59riPxSmvsEZkN3B2gp/q1lEYyriWRncjGdg8EjMRIPJ+7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t00awD4Fp2NrXZniVDpOmTNcafwKDQlrUU3VLYfRySw=;
 b=tHVuflxF6GBKS/BUfZcm9PSn5iJXkPDTP+Ke5iKFVmUXHDjhpjOTpPYA/SASlm6JreT0sEj69RZxPIAW824fXjiWa+0oBxYPe5whsjm4TVQOijuovcfxiNcmfD/1N0UTMaRoQkHfQo3p46HglHhqiiEicxNOwaJhCyoLYxQ1YLI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6170.namprd04.prod.outlook.com (2603:10b6:5:12b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 08:25:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 08:25:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs: some misc cleanups and a fix around page
 reading
Thread-Topic: [PATCH 0/4] btrfs: some misc cleanups and a fix around page
 reading
Thread-Index: AQHYGRPgxWsXTiSguUOgmTiwlOcRyw==
Date:   Fri, 4 Feb 2022 08:25:01 +0000
Message-ID: <PH0PR04MB74168C960BC51613DDF7F8439B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1643902108.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74339276-610a-443c-53b1-08d9e7b7d6b7
x-ms-traffictypediagnostic: DM6PR04MB6170:EE_
x-microsoft-antispam-prvs: <DM6PR04MB6170B89999BA859D401400229B299@DM6PR04MB6170.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NmI1nVvoPEeX9/6Eq+jLC53ZhFIeiawe6d51C+Gd4hWXwPSu9xdnhFXWcZnNLcwsdl0vtvWUeobh8wf31gFI9gJwfayYGYvYrO3ny8SvExgFs1rcXsgiO2dOpPVdJ7bTDUm6mDg6SCnKRhCQdtk+Ig9zFX9t+c09viCjosojVx/htPO4nDfJAJDab++CK9FasApQykbHnBYg5b4WgRf2GOfoDpeHuUALQeYmWxORkPNfODiaOV6bjsQr6dGqeoAR1X8DRweysz1JL6eRdXUye+0DmVQxeFLeKdtzg7cBoRdjnKee+9RgdM9CFny88QKiqose7rbgGmYnDwIIjjk4G/f/7BGeXALTrUoZX6U+vxA2jwnjx3MEdBgZ0N6jVJ0zuVR2A2wCQPK6bX12W2biR2+TkxU5ibyGlvqjG2pxW9zqnw6ogdXXMZrgu3Ih1OnYnQCp6KipjAl1LU3m9OruawCMsLWP1b+X4Tf3aH7q4dgypXp+x1JHUZKVyIx3rupTfnrq2m1UMNfKAx4BNO737MzeZh5zZcvZc2+cGXVvPRRqgAQlU3ppp8ZcdzjyjPDXz3/M0vklTJ+M0bvxYj8D98ERzARBkHKxnnuaoYi6u4bo3ouRuSmHRTlGFngMgtXG6+NUm52R5xutKWRI6NJWpTuvqv1oBRJd1PGWSNw+G5m+AfhOtMBCnKwqIwUJUYzCplxChIkfYzyeToNMEPW/uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(8936002)(91956017)(64756008)(66946007)(4744005)(8676002)(83380400001)(66446008)(66476007)(66556008)(122000001)(55016003)(52536014)(2906002)(5660300002)(38100700002)(86362001)(82960400001)(38070700005)(316002)(9686003)(186003)(6506007)(71200400001)(53546011)(508600001)(110136005)(7696005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tZbj1NBvfXJIxHxUJcU06Do8MbObByt1mCsUf7RZW/6SueQewXL5ctTE/1vg?=
 =?us-ascii?Q?XT70rdWYdD3mUVEeemX3RBmZb3aWmFljJBIYLhQNmPQOp+VTdZxZFS76qhzg?=
 =?us-ascii?Q?Pd6S5MiNV1qhpMN1cogNVdtwClGhoQvVC/AUhbLdisfbfRBKJfG9hkl3Ft0+?=
 =?us-ascii?Q?RMfBbjWhFJL9vF4SDimcF2/ix4JQfj96Dm9Ex+Qr4PFhBozzzzk4qkEpP46H?=
 =?us-ascii?Q?v0b5Vucwsam2xiD/PubmxzJ9G/vHXMmpGdvS8kiLjYF6Wdy/iwEdPIfrAHLi?=
 =?us-ascii?Q?pCZ8iJhbBzl4k9sc7Nz64Qxqjba/3cCntMzDQ/dwNj70uO/WcjxcXPXxDKUk?=
 =?us-ascii?Q?EFDq7Z7HZYg/DjXeR5Shiw/URTl82AsJLxit9mGVL/FvxPswFAdM7w/Q34yG?=
 =?us-ascii?Q?E9jUcjuPymKzhf4U0F3xPLkGbIQh8VCEjVfP98uvHY7vG4kqeKWFYLZ9GYsO?=
 =?us-ascii?Q?A2GYENRidJnzi8o3LbweS4TcsGxTDMnxuhqRthNKig9L7E8xB4rJGR4lPjkd?=
 =?us-ascii?Q?DzcYKFUNkh3l8fOrKRpAqgAsf7ut2YZUN4ACo2DTTEjQpRxPBl04fV8JciBz?=
 =?us-ascii?Q?f93uDZ+5pSmoAcPNdQugBu1zLcOA+03hvIWlMEaudVYfvuijeo8n5jlti03v?=
 =?us-ascii?Q?58HTA3+LRUzSb6utITPQId1Z2xaAV6EFpCL07MPMfi3BX/xWzwwHF3r7+9Du?=
 =?us-ascii?Q?LnthVWCL1VNVbljOYRv1GAe6Pd0p/FNEkOzmyysK6ok8p+lsY3W54cG2wjKE?=
 =?us-ascii?Q?2z8p/fumWNCxaM9Miwfu3Bt9ZN9mF3VxPRDBDfIBV+1/uvsQ0dqJMjfPq+Qn?=
 =?us-ascii?Q?UVL67fz2J9+PMZseNfML+Mg6/9TLi5U0gAvKbGdiIY/gTBJNwU+Pa15+aXho?=
 =?us-ascii?Q?p+hC8i8qMk3GLC0GBpgah8UYF0PsQ8/+bRZzxQqYJl0w7+aUdXRfboKcTMjz?=
 =?us-ascii?Q?COtRN5nHU0zapxdMohcMzS1Ib5yrRN7XKh/vPT0EXU6ld7VXj5KI8VaO3A2W?=
 =?us-ascii?Q?Wjq8MHK0UQRrzwmaUx56F0aGqUhcDu+QBVpDofLj3XCbGCxEgROcr3/65J5a?=
 =?us-ascii?Q?R1YUK/DyBkvHkiTkld0bnb0D+3aqPF2pwFy01jq5UaVMIDOdOIvt6cQu8NXb?=
 =?us-ascii?Q?AwdS8HsA46h1WthUuHkHOVpbwnp7AE8HRtsiTV8Vm0fpLWOenqBHJD07g8zn?=
 =?us-ascii?Q?pP4HIJR4Qp2rZ0uYoYXw9zU7FOwQ9j6Byxx0m6XFASvQIGNb+W0tbjb7SbGI?=
 =?us-ascii?Q?ZDOlWRpHei+/ZCZwozVZBOwnXr8ALVLIsVZAqIdrPZ4SiQslIxzvjuidF7IV?=
 =?us-ascii?Q?BBaD79g+a3QVumk2odKf7V4Fz5MKxGKdN8cqYXZ7PabJAk1WUBvSogguQ/EC?=
 =?us-ascii?Q?leHMvVvU8tU73mSOF/s+zbbAmrnwVGgWNPCxoHWQpZQthHw1TZVjE8gJbKyk?=
 =?us-ascii?Q?lPEwORGclYDVcLs+uWrHbK8fgsdP6K1TLCYV7W50EBKj/zJuc0mnmPb4uFsm?=
 =?us-ascii?Q?JIslTQ+3k+jFEkROUYs7SJhcXFYDywGQpMJK5PhJsR7dfYiyTis3fR8wiNJM?=
 =?us-ascii?Q?z2nZuKe+rh/qFy2u8yoOccxNnJN4fcTbfakIu8pMiIh/YOxXCOPF3jlPAaUd?=
 =?us-ascii?Q?ydC1Q+sGUyGNAHJBCTZEFY5Lflp4JtvEJimT/6n9m6J520jPiSrXlM6coayN?=
 =?us-ascii?Q?fkGzMQtYYB8mh6pmWbfjUOigTR6+qFMT1qBvbH9I/jJ4DRR+H+BwQBs9DSe4?=
 =?us-ascii?Q?V3EofVg7YlhP/h2kFSoRlqeyW4wEaLM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74339276-610a-443c-53b1-08d9e7b7d6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 08:25:01.5755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cxzPDx6letZddNYshtt6Inkhr1tsBvdz/XUf9g3yQZ739tZXb6dMsaaK2TvA/JayjMb+hLddF0WtUiSPQaQWQTHp1lXB3EBZjTTYuuXo6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6170
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/02/2022 16:36, fdmanana@kernel.org wrote:=0A=
> From: Filipe Manana <fdmanana@suse.com>=0A=
> =0A=
> A small set of changes, mostly cleanups, a fix for an error that is not=
=0A=
> being returned, and adding a couple lockdep assertions.=0A=
> =0A=
> Filipe Manana (4):=0A=
>   btrfs: stop checking for NULL return from btrfs_get_extent()=0A=
>   btrfs: fix lost error return value when reading a data page=0A=
>   btrfs: remove no longer used counter when reading data page=0A=
>   btrfs: assert we have a write lock when removing and replacing extent=
=0A=
>     maps=0A=
> =0A=
>  fs/btrfs/extent_io.c              | 12 +++++-------=0A=
>  fs/btrfs/extent_map.c             |  4 ++++=0A=
>  fs/btrfs/inode.c                  |  9 +++++++--=0A=
>  fs/btrfs/tests/extent-map-tests.c |  2 ++=0A=
>  4 files changed, 18 insertions(+), 9 deletions(-)=0A=
> =0A=
=0A=
For the whole series=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

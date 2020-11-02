Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34D52A2E9A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 16:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgKBPs5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 10:48:57 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63849 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgKBPs4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Nov 2020 10:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604332135; x=1635868135;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Xg31VC0vWdXCKWoenqAbvhVq/j/2KukgAuERhkTdwtk=;
  b=R65RhN2nTqggso/xtc2rfPeLrXR99kO2Sy6NUJwiUKN2wARPe/sIbxpm
   uISpnPuhHZzMon38BU9g7L3aCyPVta6j5ofGqT7QW1PHZOfCT61rA+9W+
   P053ZCBATSEIEj6BY2jgO16iaXzJQILsnjXibWW2MZYU7lZRpy8uNU1N5
   GN+YpBhjjEQV1UbefadadVx7rzxzPLatpf+huELNLbOGhFrlbntwJvCj5
   A/vOsuWKw0bXrN5LTJnCh4la4Q9mVrFBGO1WbhRcBbJ030woknTvFKoBv
   FVyNN2rELzBGf94HXLkJTALHQS/A864naGbGwbY4K/B+FOaOQothYx+Qk
   w==;
IronPort-SDR: 9YfnS1d1IhYDSjdk29fU/s90b64Wivn65ArhihmXa4g2Fd/EQVRpQAlFjyB5np2e968Rojx6xE
 fRHe3erSY4fQiEpDLVIOdfD+3FP0h2QBa3nrSAGzQ/5BTSqtzan9/yqRggTwRRylWitSk/ozXU
 EPI8spBBCW8vY4Ox2k0WUQnCpvEFD7LkOuEZPJbcPrJj304BOEhXlGk/pPuRrfImARoscbftxJ
 a5lKBlua0iaiviYid2Yw8umdsV4tK9yd8Mv/WCy/Oo0sz7t2oAroRk1qU4Ont7PouSVa7DFcQ3
 4RQ=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="151628219"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2020 23:48:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiz3lGqRgqCazaMsVYvWYREKSrvz16uH2LL6fPX5+CjedbTZx7MKDEr2V+ktrVBkrARzxu0EZgXKL13hOc6X3ZapB33crxCk70wSWM1AltakCeTTe3L/4BLP54ge3jQ3RFxfEF1Ppk+vYLdzsOkqOFPIA/pnR8x12cGwAeh5NiOuy1qznoJqiP/42GMIKu0pdMV/cW416ApQEJ3jjcZNlleBWr49WV2FC8gdbKSEyOBaResmLXcqAo8AHe5yUE2r2Pv706pp2SZJPm97QxPOMWY61dNurI3CMRAKoBW7PgHKE06TQi6Byi7RYlvEvFdngkowNCqp5dFs7XvLdUidTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PeDL7X5y0t9VhM3leslIiBQKS982CGpsegLgl0viEM=;
 b=FIH6J1CBlAbM75bj4yDhq3jMiyHesBrnTVZdD8fjUcnLscUNzBHYfy77xLXfdAzdIRiMdr1mmhDKvbwZ2jhoPRUPVSMcog/JXle3lprHtbKuNxcGie0DWWP/+jeFdBLHINTm7n2voQfJDjginMtsWC4eRSLpj5tyFKtqhErSrG+k6FKGt8RNStmVWf3R/rE09sSmUmCcv3HdWgwnEQPaSCW+DxbB/EO4m6QLtKz32gjM1H3HuUg7D3VVdnMoe34nS/CeKBu0IqPOVHkbC7a+mH5pFiUlcbiG3KKxeKRxAW0TooV3VfaeVVHfPgImHkstR0F8VDcIbKmUxKwRBNWRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PeDL7X5y0t9VhM3leslIiBQKS982CGpsegLgl0viEM=;
 b=IO/3XxjwnC09qE5eAhW97A3+cSBRedK3RJFushfaMLZGbyjOGfODBqjy9yAr2tNDVaaxbvKi1eVnwwR1pKObs+ct8IaJXifhL+llKG6Eo37KhLv/q/WgHr6w9ftGK6ZJ1vVIOJCSx7rjhRaBvmLY6pxAECqKRzBOclzdmZIibUk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7436.namprd04.prod.outlook.com
 (2603:10b6:806:e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 15:48:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 15:48:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/14] Another batch of inode vs btrfs_inode cleanups
Thread-Topic: [PATCH 00/14] Another batch of inode vs btrfs_inode cleanups
Thread-Index: AQHWsSdWQbFcoF77nkenULWNz1I6BA==
Date:   Mon, 2 Nov 2020 15:48:52 +0000
Message-ID: <SN4PR0401MB359899B411E936800C19F9419B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201102144906.3767963-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a86cad9-3c63-48c5-b47f-08d87f46cc9a
x-ms-traffictypediagnostic: SA0PR04MB7436:
x-microsoft-antispam-prvs: <SA0PR04MB74368E75A5F0ECF434A030BC9B100@SA0PR04MB7436.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: urHTk4pAogAtMlYCuyDXePksQo6Vj0QrbjprkJ3WtGGW8+8z4ajdhQdIlnHrxJxm1X+xVESYD4oKk2wELjD+ibE5m1c5xKJbNtop6UqZdPfwMfmt6yr179BY5R1LUcpWDlGi9tiIcyCTi4IriCO+xUw7JLyJ22rLHcQ36JgrU+EL2VJVt4xi1JnMIr1U6+A1Aa4WDny3wSOf0iJU6zmEIaBiYzEh6PFnCwZzgz8fsfumILpRnJMeiOvzssU90Z/OBg8EUHXiuPB2Tm3OosW7aJ3KD4dXV+JROEIJYzq7sK0JB14171rsGu6z1d2XTwRKsQOcd92pYSMyhu5SOV64lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(316002)(71200400001)(83380400001)(186003)(55016002)(66446008)(8676002)(9686003)(86362001)(66556008)(110136005)(7696005)(53546011)(6506007)(26005)(478600001)(8936002)(2906002)(33656002)(91956017)(66476007)(66946007)(52536014)(76116006)(5660300002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CxQia+8Q0BSYYjlcxmmwHOAFOZ2Uvpu8Mbwd4iwb11fxEXBAv5D+5fcaieGMn7oaW1BvfdkeNIEDUW89FftqluzFErnkEF2UpdHAP+pTWhjAjVI8IMK3qWjehGe0wJsRPVNDSAE3L6crcIMLkk4qT8TGUuOVJ/AgYH2rawtYNB1Kbv3gWxewG466RUrs1Q+sLz+5Ded16N0jfwaeJgnoi1Dq6l//rY/LFe/tpMOFGfOBf3xoLKI5zDjZl2ZsoTRkN37KB8J0xRDmT0PD+Tqxd3KKwvBjZcjVfmM6zshkDudL0k8Wdp2X9VfLzQPZkuNPvlH2sQu4l1gO4EOExGdzYxcJbKlUwooHzTcjGoqXCJu0+v7NrqanRmu9qDgsBEmW6oQuw54aYg/SukKxVg7WikNEP+f3+u53iCbiuv/vDpqmMZQSCE7BhwSWuk5fSq8lRiVI1tYphynE9kF162Qe5z+rDoY36PHeY3ZDDV66/A5fM9BzGazc+R7OfL9mozIhu1bc1h2WuImtVTyMEiPyJNCe9BY/95qRWSrkNUXEP/FGOE+bKbiVyvrABLjjtt0yUOc8Xrz479g8CUAr007DEoSrDUUONwl4gu4xPdQHQk5z4r25DheYWsmCNX0Rso9xTt4YouAId4UkKk1qRRliUg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a86cad9-3c63-48c5-b47f-08d87f46cc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 15:48:52.8686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+Rm10I3dVfxypSFy+VpBBZlUUsvjnE9kVS7DbTVk6aSU2h5lkaIxCFtt2ZIadWQz1xz/QprpTkNjeYXg8M7vfx983ERh15PDVBbpIzMUew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7436
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/11/2020 15:49, Nikolay Borisov wrote:=0A=
> Here is another batch which  gets use closer to unified btrfs_inode vs in=
ode=0A=
> usage in functions.=0A=
> =0A=
> Nikolay Borisov (14):=0A=
>   btrfs: Make btrfs_inode_safe_disk_i_size_write take btrfs_inode=0A=
>   btrfs: Make insert_prealloc_file_extent take btrfs_inode=0A=
>   btrfs: Make btrfs_truncate_inode_items take btrfs_inode=0A=
>   btrfs: Make btrfs_finish_ordered_io btrfs_inode-centric=0A=
>   btrfs: Make btrfs_delayed_update_inode take btrfs_inode=0A=
>   btrfs: Make btrfs_update_inode_item take btrfs_inode=0A=
>   btrfs: Make btrfs_update_inode take btrfs_inode=0A=
>   btrfs: Make maybe_insert_hole take btrfs_inode=0A=
>   btrfs: Make find_first_non_hole take btrfs_inode=0A=
>   btrfs: Make btrfs_insert_replace_extent take btrfs_inode=0A=
>   btrfs: Make btrfs_truncate_block take btrfs_inode=0A=
>   btrfs: Make btrfs_cont_expand take btrfs_inode=0A=
>   btrfs: Make btrfs_drop_extents take btrfs_inode=0A=
>   btrfs: Make btrfs_update_inode_fallback take btrfs_inode=0A=
> =0A=
>  fs/btrfs/block-group.c      |   2 +-=0A=
>  fs/btrfs/ctree.h            |  21 +--=0A=
>  fs/btrfs/delayed-inode.c    |  13 +-=0A=
>  fs/btrfs/delayed-inode.h    |   3 +-=0A=
>  fs/btrfs/file-item.c        |  18 +--=0A=
>  fs/btrfs/file.c             |  88 +++++++------=0A=
>  fs/btrfs/free-space-cache.c |   8 +-=0A=
>  fs/btrfs/inode-map.c        |   2 +-=0A=
>  fs/btrfs/inode.c            | 249 ++++++++++++++++++------------------=
=0A=
>  fs/btrfs/ioctl.c            |   6 +-=0A=
>  fs/btrfs/reflink.c          |   9 +-=0A=
>  fs/btrfs/transaction.c      |   3 +-=0A=
>  fs/btrfs/tree-log.c         |  24 ++--=0A=
>  fs/btrfs/xattr.c            |   4 +-=0A=
>  14 files changed, 233 insertions(+), 217 deletions(-)=0A=
> =0A=
> --=0A=
> 2.25.1=0A=
> =0A=
> =0A=
=0A=
=0A=
Code wise this looks good to me. FYI patches 11/14 and 12/14 don't =0A=
apply cleanly on today's misc-next (at least for me).=0A=
=0A=
For the whole series:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

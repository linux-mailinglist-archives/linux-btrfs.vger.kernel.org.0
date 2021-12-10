Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149ED4701B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 14:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbhLJNhw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 08:37:52 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35634 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbhLJNhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 08:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639143253; x=1670679253;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8tXmsw2cEMqIaAj39LVLFGGZy/FjNNmkVewjkxQHE3c=;
  b=RoNm+n6m+FJbUh9Dh4VdB0rqylmdEPMTcUqo6P3ZOpYcAQJzaFcZlY1L
   06PBKR4nlSxdSSh2RLoEZJRLeEpVvramFI3h1K4XGkzmQA+d1M72R2SxK
   W/enJNI5mQF2+GWjcPC9DbM6tbDX+odcmyAweeLL1XbfQOFjuE0PZVXgN
   OXRXF5gAge6SDEfRqRMRze0Xw54eypQJ18yw6IZKujdbPfq3UiP95E8Mf
   rppveUqYU/MaoEJqlMl2jRjFRSc734PoZ0qqO2ThNqG565BdVnDFceRoq
   JoFztUJOiq9VGfEYJW2cqzbB+ihoYjp9PWh5b2B5MN7dRdY5nu6w8uukR
   A==;
X-IronPort-AV: E=Sophos;i="5.88,195,1635177600"; 
   d="scan'208";a="299784963"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 21:34:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5ycupu5bQoUtQFxIc2TcRXLEXR9DRoeRIXEaoQTc1GbCP6ezYH5QOL5dAwTpQ48BKlSBCjwN8zZ49/23ERBNBhwXkc3EREd+zFbor1XsyeShaY5qKPti8jqzgY3VyXHMPmgmddSYi1dltg0WY4xWuJy7GrFrz3vQNscKnsLUKk88Cc59M+garVT2TmSKg9Kmmj7HeM6YvhE4H7Y9seL+Z0jlcDOXD8t8ujj17HpAGJbFPWuhNIfHuWu7SMJuNQyrXmGBvEKNhy5JSqzBmnmzQzXGr7XLet7kCxib/PS4+GQAaMPGzg/V4VyRfXt1neKsolzbHTY/a6y4gQ9ZjM9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjcZsDvnUlheN1YGL/zHO7HfjbDeJioetR7QaqYp4h8=;
 b=gQwEWb0t9Bj7zRhKBEM+7VZtPeMpo6uRT43imjTvZKLovrfGMFnqSTy4FlcAG6eNS0Gme7VHNRldR70Ha/heXeYSzIY9CZpU3Lu4tg0ebN0ZjK2AzEU3BT4F2ocdQqgD8jaQY/YZa5fYq6JpaUXIUxZv3yw37Go2ZZ1XjpYj+AAi04urXNRREZ9Uyg6ILCw07QEhsbnZ/ADhmo0sX+jHU7Df2DLWhXHaxgbmsmTTqWf3QkF3Ryk2nBSV/clacvZlMBJARtGJerU6/v4rW7eOF/ii9JW810aKR2tvK5wFdF2ZIMKWMkXHPfiNUFLQn4Tn1TU6oGcebhULXMDSJXd6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjcZsDvnUlheN1YGL/zHO7HfjbDeJioetR7QaqYp4h8=;
 b=F4ihtnRel0/7vPlsVn/iGfghkR/Xah8+P+tq0ZZ03zcR+crupHD7Fmq67Q/mihbTBenueqMkiPqToEiWHkCz8x411J4NG2shLaSd4F/wGm6Icn4J+mJ1zcyy229eO2Sbl55y/Jcjvzq5HscxXkien5dI8Bs+NOwhbfeuAjaUsCQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7366.namprd04.prod.outlook.com (2603:10b6:510:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 10 Dec
 2021 13:34:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4778.016; Fri, 10 Dec 2021
 13:34:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] btrfs: zoned: fix leak of zone_info in
 btrfs_get_dev_zone_info
Thread-Topic: [PATCH] btrfs: zoned: fix leak of zone_info in
 btrfs_get_dev_zone_info
Thread-Index: AQHX7bmUp2qZrK3qxkmeFm8oGgyX7g==
Date:   Fri, 10 Dec 2021 13:34:10 +0000
Message-ID: <PH0PR04MB74165B94DDB22C86EA4069569B719@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <8a54e85cf93d2042f1a2e29517f8f91fce56f6ab.1639135880.git.johannes.thumshirn@wdc.com>
 <20211210114432.GO28560@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c3c4586-79db-4375-28ff-08d9bbe1bfe3
x-ms-traffictypediagnostic: PH0PR04MB7366:EE_
x-microsoft-antispam-prvs: <PH0PR04MB736615463825CF1E96C197FE9B719@PH0PR04MB7366.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kJ5eQVW0Orkj6IKI+zK9saSuuFVSHesVMbQJoHyIliUv96SYZKLMT0QN5Xs4ZVWXN9MONBnWqMbEwOKI5UZppmmgHXXH5Bio1oEldfyDRSmijnLPm+AkCN28/LAXH+P1f93phzB6EYSjN8ppqXwRctbA7oBPdD+waxcseT8lVNuML4l4/DlLK2h0WtD++0MwO+P/TFKnHzp1x+bNswjItisdsmqHjlg6HRlbYNbZDMF/1fX56Hqp5l4nt02O6iMdtRn9C9GI6fFqPKkTQq4O5mBuATBNjON/Yivcg7cAKXF9LwVamQbkE8y5uVkjIuDjAWTwyDQu9vVL4X9hRxN6vB5xenHaIYjJHO4HrBInR4JNKksaYExJxlA2Q4q4y/ncnCzobOHuC/jurouBjPrss/DpApoFQYvxA9uL78Nj5XoOtzNqFszVvCdhpmsAqqfmx42Ef9wLgLjDaaBTuIjKPCGR1frPPBfsQtdCzcmRs3e3WELPIUj/bPwTICeHizR04/yRQNQXbPt5t0UtFs0KPJrY0ytk2/JteXEXNsxQsur92TZraYIOvm4r51hsJilFm+s9NKZ+sFW9QnT82Pk2b8SgyOXm8J89+pNESItMH6izbEGUE/RnNtcxQo00fTFEleD/2Y90Rb9Hhegicdqf8z6G9Lzc2+yOWDJKd2BQ3C5MdgNnPFaqe4pn994JjHwlVwYILyMEHpQZHAvzFQ69pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(86362001)(4326008)(33656002)(91956017)(52536014)(316002)(2906002)(82960400001)(38070700005)(66476007)(9686003)(6916009)(5660300002)(66446008)(71200400001)(64756008)(508600001)(55016003)(8676002)(66946007)(7696005)(53546011)(66556008)(76116006)(83380400001)(38100700002)(122000001)(6506007)(8936002)(186003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9w2m6DcPAFSsoEL5A2FpVPz21W75C2JbQoMBLyklygv0fOj2rRHGBMM5watJ?=
 =?us-ascii?Q?kn3Sai/diz5a6+6eQywilCzmKJPCJ16OS7WA/dA3R7/ODUo+9AvGqQ4ehR13?=
 =?us-ascii?Q?jHi+JbxdoPG/sLB3qfChzo1SIBimP1bEKVUkK9UTM/mqUrle/TTYCtwXKzZ0?=
 =?us-ascii?Q?1bdD+dPv1kGs6XQd2vONPtjQ35vK4LGOozOZ+FXTsrGSl7KZyzLXo8ydVU+0?=
 =?us-ascii?Q?QlF63a3gHkOf4Thv1NcWZNkQTVfZHC6OwMiwc5hm40pwOBTPIj4RHtUN4Md+?=
 =?us-ascii?Q?DxLU47JyJo1Ay0e8AyN/1RtNbGvdUQdgE62SnTf1y+z6necYi8Xa65P7X9MT?=
 =?us-ascii?Q?CNBHanIM4QHVM2oUzyK7vwgCR6XDRG4vUakt4ej2OWuu1Ux7eVmltccavblj?=
 =?us-ascii?Q?jG2IPRumg0IMKtaNg+SDDXqRRDoXtMdjLzbCEbrCg9lCrPv+zlplF+aECqCa?=
 =?us-ascii?Q?FJdLHfLrEDtpmT8cs7fz+rAEJtLOME99O7Er7l2p8T0o/jUEu1z6ACwpBiFU?=
 =?us-ascii?Q?cDgBlxFAvRTfA/MYmskrzTk7UmSngmdbNK7vwg+ypU40Ng/rGqtnifd/gkck?=
 =?us-ascii?Q?QogzgpONEGMr2XCvl6/rSL+qLyjxGGSzojx5mfFDjV54WFAfv1ulG7X+od/6?=
 =?us-ascii?Q?hY/6yVnooge8RWZppPs8zcD4iX9R6Me0PhTYKH/wYDhrinTNa9qlbuC/h7Aw?=
 =?us-ascii?Q?dD0WzYx4rA9yFxeUqe1sUQO5edIEAFdqmK5ErW3/X+5VQXnMhknLx3sp4zzO?=
 =?us-ascii?Q?yFV5fkMLYpOPlHzgBeK+RwiFsvZ3+8Y4Fxhgq0lpsWxOzalOZovqfMkFpqTk?=
 =?us-ascii?Q?HFia4pTKfBvf+NezmDHVUkU+gIuLCiJ2tBDqthsrcL8fWaOI+oOgFR+yPFYc?=
 =?us-ascii?Q?iAVCfatyWTucb0/3tZkqk+XUknalH2GbaK3It4+O+oCyLh2EuIQ09tG34F7D?=
 =?us-ascii?Q?fHOpuRGX/i4ohH61B5ksC0LPja8+pq5ns5SZwaIaZxTcMxRuDjDZVc8bo90r?=
 =?us-ascii?Q?8P5XNEnwqHkcklrfXI84f/gbfhZht38d36O+34tbixWtEoxKQsIVEgFXRGnS?=
 =?us-ascii?Q?WsTjYeEwGFZ1KfafV8n/FonlsqE59+npxZU48G7cEUApfr1XYb4d0hFaZSyC?=
 =?us-ascii?Q?MUJFT9ilbSUZ25IY2XgerF8ggSVx3C9SadWNLrj6tq42BTEityt6MTrrI3E/?=
 =?us-ascii?Q?YVZ+D66zd+5eBwMkaqflAhMwDm0hr5agUUTDOj8iTt8RZMljzXB0T7J86lOW?=
 =?us-ascii?Q?bBZNFwmrOZAfILD4RQGn0pOgabyxuFWwANwv30Mhz0P+0oz1hwPCIrXRF7Ws?=
 =?us-ascii?Q?Jccrsqp334h1scjR31rD3ojpXSO7vC1jkvmdXEiQa3r00uTwhvLSA9JMSsAI?=
 =?us-ascii?Q?qEu5juFSU009YjRkalW8ETHH91Y/22vBbVCe6TK7GnR+GaWA7Jd97cWLdILg?=
 =?us-ascii?Q?pKzlcRgcHcAR1q0CkoZgUouE1mWLJPdJLUDKFPme3IvRTIWQa51uZgS+yvCI?=
 =?us-ascii?Q?SKCUnTSahrZnU20G4SAZDl4aPxlxhkAK/C1OKGVAGt5rSAL+PxK4YIpAZARb?=
 =?us-ascii?Q?+C8yVsCbeK6TmEuG9mTNCgp1cGkLHTGY+nDa/oWpgvUO7Q8dBiM1S6XlYTUQ?=
 =?us-ascii?Q?aATCdd/sZswK1z37fAEikM/yVXc8suP6e8LsoV2KdKAbjTKvlWfZvnHlPBc4?=
 =?us-ascii?Q?KP+3STcDGbvp1tbukIjFX80yo6j+mXGduL/Ug85Yl615BsbZr7xHsl6lj96J?=
 =?us-ascii?Q?qVTu8kmAWuPyRwnx6EM718SSgtS3NIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3c4586-79db-4375-28ff-08d9bbe1bfe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 13:34:10.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZlEbdoigJKTtx5cvIsBvgbzhAJvHs9bqmM7ITCeCD/+3JOuk86CkVN/uV+HAOHnBUJ6HOo8/S+JJmRB7i2FS8dQypmlCcX7aJMBDYL0g3BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7366
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/12/2021 12:50, David Sterba wrote:=0A=
> On Fri, Dec 10, 2021 at 03:32:00AM -0800, Johannes Thumshirn wrote:=0A=
>> Some error paths of  btrfs_get_dev_zone_info do not free zone_info,=0A=
>> so assign zone_info to device->zone_info as soon as we've successfully=
=0A=
>> allocated it, so it wiill get freed by the error handling.=0A=
>>=0A=
>> a411e32badc4 ("btrfs: zoned: cache reported zone during mount")=0A=
> =0A=
> As this patch is still in misc-next I'll fold the fixup, thanks.=0A=
> =0A=
=0A=
Thanks=0A=

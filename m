Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98336AF56
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhDZH5t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 03:57:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40986 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhDZH46 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 03:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619423776; x=1650959776;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=HwRIlwnMxTql6+V4qPggOc0o/FwCATY5DVu10agpIEm4CSBhaxVq4AcL
   1mxdlywoH1Ej2Ms4F51jumUPRHK5ogjbfBhPktIVmWXUNpzKPvOzyEchr
   6WrYcsqX3Gpj/weqq/qFDMnA0HwUWfTqIFgdzoSNmM+sMV1TegHp7/H0Y
   hprkeCLwUgqEmuNhE73jILvPTNH/OJ+Gng3srphBBOqRnLBfe8l9auzf8
   sPQRhX8voCprPz57bL5g1R4To9UumhcKlqykChunYDa/pZqP3CUDL0/pv
   sw6HZ1JMyj+Gndh7fjBMt4Gs/2XfTioFpSHEH+cWk3e+1DLhttDZzy/WS
   Q==;
IronPort-SDR: +2lrnSUmmZEBV1tWyFBWv3dXa16ZmJb0/VZaQ+vlALTKUejG8u9tY0J0rY9N4lPiLaA8/Dpz9W
 JC9Oc4g1x2mpP1pXHmPVFiF3dTm1hOWqQy2zJkD/xB7juiMhjaJGMSqpo4OYyuYF1ZmdWfPaOM
 x1bfPMxtSdgP2SQY9mR6XpFvo0xeWdKPFcL5MBJbmQaJthlQbEWblHOZfXHBA11A/J0HCOGS+Q
 Ton40XVYX/c52mHAjy4uDRRvGgcA3IUxbT8k0pVJMt+Ojc0WpKFUSzn9Snf/qbEI6p1VjsB5OO
 II0=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="166253950"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 15:56:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeOvWd+hUgDvzI3J7bxEPxOwy8CYZVk/9s6KbZkgmskk8N9N9r26yFozkBb+djNO4ffeKj/P1R6yIdzn5ML8GAwbTSPM9/1MvkmGKUC+iKh3R35VuRUlD7kZFyXGSW+JR8CkuG0X0jh7fhxAK5YwJB5iuiS+fsX/bBBKE+tFiMs1YlVnnLIt5eCa5+6ZDHub8+j4tU3o7AI1P9WROeUP9QSUIfr13luTBbSYBmUbmbnE8JJrDkZpZPdyFVynZhcLmtBzcCbVrE/w/cumHT6Kjy2aNr9XAL3JF5SJB9iiXXpQroyl2FBV1a7weZxJOKvNFduXG9FOyhDWvPfhFh3qhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=SLSqDDyPPuX9/sE47ZTzBnVv9n3uQJtfr5lQWDLcPO81hgtloPGpUZ77XpxVvxddej52hn7Z0nL1l3Lz3VwJD4qFoejtG6nyT3p2hlNJR0wj/rbIb7NOJNpb41JHwuWSsOtjPLcBl9mjF8YI3D80e74YfQf6UijY9YDqIkhpNgZaVLCsmPGt2DbxhrEDDhjOPKA7VeCK9NPy6dOip3gsRBP5mkXNqHW5BMYUtYTmPOpzvBecy9oeqGhPq8e48vD8qUH1H6ZFqYGhZF9MPSoqgp6WtnR924VjmBg/uGoGwWdSTAAZOYuYvnEOB+W/qTmwbhR81nymIpCMY/U++jQ1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XNsriX38xLcwhmOEcuAse9yaG7MAejZ/wXTyZum1cRBoQOjzuhSByF7OPOAeN1qkoHla2x4qmgSOGfjdiPy2+1T+9G4E4OGFgtpX6Csf5HLPJykA8OIhK5jKIFvcPaWWauaxWLyJjxXopu0Pz0eNz4RrItUJtR9xYDAOlE3diP4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7400.namprd04.prod.outlook.com (2603:10b6:510:13::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 07:56:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 07:56:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 08/26] btrfs-progs: zoned: disallow mixed-bg in ZONED mode
Thread-Topic: [PATCH 08/26] btrfs-progs: zoned: disallow mixed-bg in ZONED
 mode
Thread-Index: AQHXOmVq9R7AYCKFCE+cg0pF+h+xJg==
Date:   Mon, 26 Apr 2021 07:56:15 +0000
Message-ID: <PH0PR04MB74164B142693333A74BEABFE9B429@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <5fcf22f807b9de547010cee4b211348f9fe014bf.1619416549.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30c8847a-f393-4ee2-1432-08d90888c45d
x-ms-traffictypediagnostic: PH0PR04MB7400:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB74005EB59292EEEE2E0BB9559B429@PH0PR04MB7400.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: paUwsZ4v1jOYpxyCC/d+sLMHlER4a+aKA1xahXjQwXJkVrfiaX0vHQW5be9MrOsvNbrLS2IE6RKeLjBbpXP3rLazqdDsksYqZzK0UX6MkU9b71pNaloDH0r5OPrjUjxws+/wBG5HFcSw1VJPCsdCcL0wUcSeU0Cc9//i9FPBKUkOc5KCZOWpZGZ67b3LjzmwYkVaUwBY7xbu5RedLgjSU7wPZX98PUsKoipeB4BWxQ2qmVQ31iCVkxYYNAXUos3fkwSq0KP2mfKIujlkLZJmP4U/M/rJ5VVzIzkgUDxuZoRAL8UMFSseerblzcbMw8UVv8/CSxDwoOnuOiVdctvbfwYU0RFydhTJCNdfYbFi0amiCT8oCYRxru0/VixcdwABDzJEIXAUwYcy19iCNB9MtS8R/FvLhLqUegXfBdtKgOsgevPnwrfQlC+bsmEo/52q0yggAQy8LXZE/L7+iIpRxtAIk4nUjM6/zYnSDnRPRDY2ZY0FBZ0Hq3i+3uTI2HevT4+yvpciIBgSyzGJEps/ZmnF0rf9YGUy7LVTXK1OHj68Zaj+8P0sTQaijkgLMK7J1WEhuVxdpMX7YztgtmySEBU/+qZ7Shqe3J6sqIDFWM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(71200400001)(66446008)(186003)(66946007)(316002)(38100700002)(26005)(66556008)(4270600006)(122000001)(5660300002)(64756008)(6506007)(66476007)(76116006)(558084003)(86362001)(7696005)(478600001)(55016002)(9686003)(54906003)(8936002)(8676002)(4326008)(2906002)(33656002)(52536014)(19618925003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U8J1QG9rld6JOjdtvkB5ZxpB/v2ptouLgE8qFLTawgOpKJkxmzPB15rashwl?=
 =?us-ascii?Q?KOQI6XgQWymTNHJ6MiSanRYlT7TIlYzPt7IPqc4YtYG5Ekyrcz1ESmUb/vBo?=
 =?us-ascii?Q?sJsahawuG8eV8rJ+gcRz3ZkM/gpVqmQGshnVY7zXjt+5NeAlMAUSQdR01Nsf?=
 =?us-ascii?Q?sDH+1eEPEIGCzf8wZNexzzqp73HWoSObyK531n9PvfInOK10h5gLlub5E46f?=
 =?us-ascii?Q?Wq360jj/Fnvjov8Bk9deZFoUIX8YcFpfSLB9r5bHdcdnaikXBz/Y7bmjrs+u?=
 =?us-ascii?Q?BC/EGBpVQ/4knrfAA0ThjpBFd3KvMhnqwwf4fJXAX+U4WYsiiF1r8sn0Lg9r?=
 =?us-ascii?Q?yds7GZlx4kkU7MVvjVv6tYu3+bxTpQDqicti48n3kribP08UlsLZTeDXNFVW?=
 =?us-ascii?Q?q6at/LvdX0hLDTNQD/plARpXj71AaHGXmsAq/MAexrW7y5UoaeFzwbYY6L9g?=
 =?us-ascii?Q?WKG/Gbr2PWmdtg+o1rYZS7Zu9S1M421/MYGmcXx8eTfGvmj2URAETX97QaEt?=
 =?us-ascii?Q?1NmfXW0otATxxi0s4FlBOG9D49LHueJLvBtmkN78m1DQhEvW8apNzrgxsGyX?=
 =?us-ascii?Q?qWTsRSioUxtWNDHSwWy+Le3dZQghsFQabr9leZp0i4eugYD4lmiuRP8BoQDC?=
 =?us-ascii?Q?4aRxFZzgUUarvUjVR9aZ6t9+4tQ2RASiOD328aJY/F5lef0RAp8mIHE/uGTA?=
 =?us-ascii?Q?Wo0U+6y4UaWyATKWLIqtmKj5ft3fTHya8V87y3q+sTNPfrO/qTg+FQq3d+yK?=
 =?us-ascii?Q?DyFi/uw+LtyderTaWwpBNkge9fPwWQv9JYfwDYX1IrHPWN8TvA1bhoejGVZX?=
 =?us-ascii?Q?8cgN3W/z8dPL0mri+GHFDJGTToulHFCoSLcea+76qWedNf4cpqdS1IHmjOKI?=
 =?us-ascii?Q?iIIDjfKSQ+4LmRo0DwlcSMQQk62Sq3NMxLqWePoS9xmhRC6kWe1GYTMWJsjI?=
 =?us-ascii?Q?yFWaYGrVO6ElO9MwnZ41SnJxIneoLDDw+EM27uXTG8WQ9ACEiUaOOSAZGPlO?=
 =?us-ascii?Q?iDdYO95VDorgU2662CHGxTAg+QcIv9TwR0txBZeZUZD9/VAr1KcaMmU8U/iU?=
 =?us-ascii?Q?+DX1YB0WuVcemdtk/7+O3LMuaw3nD/IR9pX+E6GoQQttXe+qogWrswjn12Jn?=
 =?us-ascii?Q?ccEBMf39hN5i0r5SzFGCpWVmcKCxrl4mC+k/mBqTf/RUODa2Zs0sA9fPzcYI?=
 =?us-ascii?Q?5o1T5xhIJqznEay+38W5jJXaTCiER8s6Wmj6Q0aDi9PWXW6107QdL9X/O3Ue?=
 =?us-ascii?Q?7cPFwFpMRJp8iOvn9V1rvSoRbMpQptpC2IZYQNRLE5gE0nhyxdIWB5UzjYUB?=
 =?us-ascii?Q?LwyxDuCJUQpZgDwta25nlspo1miys7d8cXKfxfJFXMlu6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c8847a-f393-4ee2-1432-08d90888c45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 07:56:15.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpYoK0P90ee10Sqanco0BQWho139NjtuW0F7NmncUCbXxpmlsm5iGz24gORd2o+vmGuH/HwgWqGI++qcbQIPeopw/kXE7O+LAeH1c06bcrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7400
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB415A26D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBLHvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:51:33 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61669 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgBLHvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581493892; x=1613029892;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=c0q62eXAGAC8qaJ3d7eZf5DhlCom3wyHQ7f87HAtIvE=;
  b=my5wn1ZIpYumNIo9+dOjNRXk33hYgwWkZomKUVyVPjIbAIrwlVep7tQW
   dhoGfZp3DF8metNCuf5IKatLTPAmMANwx63k0bhUD7zMTfvcGWK5I3OBD
   KCfRZlRbBAYMeRS+HBT8KXkHGPyRE3ZE98wol7sw/SAkBVaaz5WmcEcpK
   nPyGnbZe606xrAt7vDdH5wBqcZambltrpqmwn+5QQHg1MCAVScP51kX7E
   Moqa6WivsIghtstbqZzIFGpwF6Yb8Ul7yhcrR4vzU9JMUCIUMPD+4XjyW
   51lT0ozKp9etZH/JJ0nGsjWVdKdetD19iXucwaPPQY2d32+dfZCYZE4PD
   w==;
IronPort-SDR: llK/QtkxnSs0rLcCbj2rTfmDtutTCmmXAKxajJNP1Z5qJH/oN5a29UtTSDwkdb+d1+0/z4tMtY
 t/fdfYUwJQsQh7+HXwrG5Xb3F8Gx/UHLDwVZjCHYen0lXbfRhgMPspeX/AZDxp8/416c+cPYRh
 8kYPvyR57n4i/joKpNzAV1yAlA1/WRJfS5FqHhVdc1iKsV6hvVN6hnTHmS6OTjlxVBW2DOTk4O
 cU6mwaBkH+jWQUOsktk8E7By7j1Y4NPjPMPronWLhCOLcACpWquZE9I63ahiSIkmTEbluZ3X2w
 T1E=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="237670254"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:51:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgZic+FPgglYZpPL+N8FPIvZsbi92YyDXZLAq3dyc88vYwMGiYH1U8OzhHqwDaei5vsvSJPu2YEmGjKpcBawIGWquNO6fXmAE/alDFdWl11QttG4R35PFqpWPSGwsFYTHgVYrnOhy6IuQVDbe9Rv1jRQI7a6gjQ91DewU0VQuxQzMGW9NPRJIB4nSB3ZpS8+gBZU/eByfXymv9XzyNsjx2Ie0sY375MJLYeKp0Bi/MXbL7ueLTGGyPshGjJ49a/MSFK/lpL+Ks0myxrCy2L0rwLHjNgT/w6ZzAGnVuQcDnk4UfpX4gZzQUf8voVIZl6pWxK8ejK4r9xMsVWSNc4iyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0q62eXAGAC8qaJ3d7eZf5DhlCom3wyHQ7f87HAtIvE=;
 b=a19/F8eAv9b0qvgsURxN4x/mGVrULhZaJQLCefjq3rVrts+tD9YfwO6diuPLs3k2Qq1lBXfi+oTwJMOR0Qc3BR4KG1lvtelV3qkZiXXDBNrab3c1F65rLzYFFo88PCj56BM/UvgEN4843PHp+Md5k+vZ3CxRuldMefyGNMuSmVl5qsrMhmFXNjgs/DPJFMW/vibdPQ0roCCCOkP0sxY8cADyo5kJP2DYM45QG/yo9+wmxAr9X4QUR66fHgFcDxlX786p4q1LbDPsAUjNJQ389kGDMyz/BuY4jTqqyxtE8qd4fgd1N8DiooTj57NnLQJMj9spAMiSZuiRP44IH97sRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0q62eXAGAC8qaJ3d7eZf5DhlCom3wyHQ7f87HAtIvE=;
 b=IYEuREP0r/GphuCBH1u4wNyHXOGE5hY4mzSRf4UXXZsZL25u0lbTppukJrbtFGNQfL8wq8+++5cMbkGGLRPAJicfE1UgbO37LjClWJxuWwv72OjkSLKuOr0ZPzO4VAWncqXYV/v+Kr4eaMeWN5yh5f26ySe5t85EtDZiflnaCyg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3518.namprd04.prod.outlook.com (10.167.150.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Wed, 12 Feb 2020 07:51:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 07:51:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v7 3/8] btrfs: unexport btrfs_scratch_superblocks
Thread-Topic: [PATCH v7 3/8] btrfs: unexport btrfs_scratch_superblocks
Thread-Index: AQHV4XR3LaeMxZBurkiT01VyVz5GvQ==
Date:   Wed, 12 Feb 2020 07:51:30 +0000
Message-ID: <SN4PR0401MB35980EE776252C65653AE6B79B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
 <20200212071704.17505-4-johannes.thumshirn@wdc.com>
 <20200212072751.GB30977@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f4db41a-ce01-47fb-2b25-08d7af905f5b
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB351825E75DCFEEA105D6CD169B1B0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(199004)(189003)(52536014)(316002)(54906003)(81166006)(71200400001)(186003)(5660300002)(7696005)(8676002)(81156014)(9686003)(55016002)(4326008)(66446008)(53546011)(4744005)(6506007)(26005)(478600001)(6916009)(2906002)(76116006)(64756008)(66556008)(66476007)(8936002)(66946007)(91956017)(33656002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3518;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bs4Tp4kTuYryhmmz+xhBQ1EAlu8kgEIkyMkP9uakCdv3QWcnlSpa98yQcbwtyk8rO9/HJBtJdzNj0rMmLIvv7/QIYf25jypV1T6dXPnXkM7liwUQvvjeRNDuwYtIE0jhYxSWoHzNcs9yuZ6b3JmlPiUNEulwi99825Ch2mUCubqtBAYQCoCRO+WF6yKMUxs9IGfTLPFDgd2F4+jy0O63rBdfoMsFew8ZjRzjDc9Hpe8jb+fFtxsyl0KZwHF7EkTfTUfILZAUudPxc2wNKp0U9PEzMnMg7t4FBApyKefU4Wecn1YI9DvZjeTMlQLLs5sxE6/AQ4xhecSHVC0qDXeQHf5InMx1MvKOJLp16atzkyeIC6ZzvHWemCvjdl3yfhh/iJ1izaF2kGnrs8HDUQrQUJH9s+5nq7VxtFRqTBknbYikRd8QTjdJwNj2Z4QoJmdg
x-ms-exchange-antispam-messagedata: zkOhEi4MQnGCCVYRi3JUHK7BkpjsadDMn9iiWhhtBxJ0CSJA+xJcxjHBgjV+xZr2vE9xopnj0SMabdLNaMnYmUCHjyIgBB/dgmNbrqikMI6bdtIhUffPFXx61/Q1UtgLXUazpGsoZzsU5m9EW0VNAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4db41a-ce01-47fb-2b25-08d7af905f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 07:51:30.5296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDqiuhaC/nqKMYSbRAEg1XPp7MaoxG0tpRLu8TB/HqyQp2hYDYOlWFOLPAiOu5oDtar/VRLwCLQl8s71Xt2cnipq/GDGYcTePmnp+uc3U8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/02/2020 08:27, Christoph Hellwig wrote:=0A=
> On Wed, Feb 12, 2020 at 04:16:59PM +0900, Johannes Thumshirn wrote:=0A=
>> btrfs_scratch_superblocks() isn't used anywhere outside volumes.c so=0A=
>> remove it from the header file and mark it as static.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> It wasn't exported to start with, just global scope while you=0A=
> mark it static now.=0A=
> =0A=
=0A=
I think David can tweak the commit message when applying.=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9A02A2D06
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgKBObk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:31:40 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50245 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgKBObj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Nov 2020 09:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604328393; x=1635864393;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8Gg9uAcAiiHAxNzFzOhGhOJmT0WAFF6tOW3OaPBPo84=;
  b=NuiFlPvv7tVWhF5LXsFze2unDC8d920NQTJw6LTfLWdCJ3B/oXppzDpT
   wBgM2isP6Mo1XUZ+7ihYlQS6yhTQkGSZeD7EN8IkCWehpLPAZHWQ61MCm
   VhVN0ak5GbOD+lahZ/uKGSK0ZWBA9tRf8SPJSHjRSYAaLHUrVpFOP8EfF
   l++E6MuXjQupRKyYR+e1O2jbrezz3qQatIbIz1O0IJFqTtXOSBv0JGxfh
   IDZ5whrB3HqLjYskqtzzuccezo3I/s+h1z8BLNB13+HMDQwz3f5nf4nyo
   hL9iilWBwSXWHa0TRH43ZwEegF9H8pAK4HkQ6M5lLp+HbykYQF4D95qAD
   w==;
IronPort-SDR: 5kYy6VbkyfCqKBEmr/2IWShr3q0VnFW8wwcJitPkuNQRk6dmXD2alknMoDRPxjjCrBGJ2Migwg
 +aJiAb29+56cOY4UYlELat+HGP4pasReCa5bxEPdkFheMSF8mBCA5gEmPhDEQ9VvrNbFIVzAuk
 tpz6+rj89Wh3t/4RtiHvDoVF7x30+b67iXAlGr+1W+gTBT6xY1w8uUXWmFLekSB/q/2cVTq8Eu
 lC2mK6Sv0gZTp5sIgXsIF2NQ+tOMY+NMBgHYd1908tW01Y3OQnRPQYxpL8r/qAsCIbd1fj44wW
 reo=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="255097040"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2020 22:46:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxBzF9Sp/szvx/hGnpUej1KOC3IDQhTTLuaMwYsoY8FaEKmWwo928chDUbmnfD6SCEVeGh3HJU3RvhK/iVsYIXQvGN+MOxr6Xcfkti8Y/N3qoK7wDZSLfE/11Hy4KjGbhYsuQ/vGrC93JS43NA7wYWAFpz5YDrXkFgC2E7GAYsEF4xFJoZnn6xvI0eXU0kqAp7e/+dK+d923yD5fUKkUarPP3Rljap5TyyqDDfumU+CTM56tWNSFjvJiT6ozVabIC0WFfrGorNN6f4iPlpd8SVZJzg/EHUke9gT89fqyYbrRWg1V+neqSMn0jT0TAXwdN0gpotJ4DSpsVBfhW4NtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gg9uAcAiiHAxNzFzOhGhOJmT0WAFF6tOW3OaPBPo84=;
 b=hJ6xPwWFFK4kDzfellvpb2zct8SLxNRNhw0AYUAbXlkkOQ8xD/SWaVDTTOeQNiScWuD0xaBlPOWDuSga2vEeEbaVwmaaE5he42X5/emKtzQffU+BQvL7h9rvfCW7cO2Kmnqf+su8ZQjLwEOL8w40IGVdWcJGmJiMmarY41i+HhedC8vHbDgzrhKz54mnUgCxgIYFLv7Oj+8I1laADgvdG2ascM2TWCNvWm76xLHnnGgcstK4Ol42XmaYyA7OyGqTPP4xXX2/+98yMacQQDnYZXK8taqzWTxMPIK0vEndlDeRqzxg/R62FxC4y/4X8VtmY6epgvjVaq7neUFTTKAupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gg9uAcAiiHAxNzFzOhGhOJmT0WAFF6tOW3OaPBPo84=;
 b=rThRdeqMKQm3TBic++uzEfXrDBxV10n6ghz+FAKxR201bkOrHCkB6SO4/S/yLqb04ctXxB1wfbsuuWcYNjHA8eD1oefgioMPf6BUw1Jy8agjI2b0/QhQO1I9iFN67zz71iJNQMvtHCApiwH8dB7biTeKWcSDuO+srfBTI/ddXIc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5245.namprd04.prod.outlook.com
 (2603:10b6:805:103::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 14:31:36 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 14:31:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/10] btrfs: use precalculated sectorsize_bits from
 fs_info
Thread-Topic: [PATCH 01/10] btrfs: use precalculated sectorsize_bits from
 fs_info
Thread-Index: AQHWrf/ka6/Wfff0gEGO3vs5flmt6w==
Date:   Mon, 2 Nov 2020 14:31:35 +0000
Message-ID: <SN4PR0401MB3598B9DAD09F08946CBF6C3E9B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1603981452.git.dsterba@suse.com>
 <b38721840b8d703a29807b71460464134b9ca7e1.1603981453.git.dsterba@suse.com>
 <5d586f76-7cad-b7be-60d3-44c8d3b67623@gmx.com>
 <c798fbcc-c7e9-fca6-992b-bd006d6a61b4@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cb193b3-698a-444f-38ce-08d87f3c00c6
x-ms-traffictypediagnostic: SN6PR04MB5245:
x-microsoft-antispam-prvs: <SN6PR04MB52451FAFA227E7473078137D9B100@SN6PR04MB5245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QRACURXjkPBNiwjvelzhzFeNVEwciYE2aDN6mde0gov4P3GK6YbuiZzE0eG+bg8EHipv2+4kVJagKbVc/xh5YuQbkxSYjA0SJnWQtk5NXHYeNkcMrs5SKZIOD2PoMv7M9Gy/q3QSK3KYIUpQd2mQqUZFdDx17p34XUIHbt3BtmmCwpECb6C3ARI0BG0kYyIrVDkKAJjiMZjRH7PadbvoVFEQg2iQQvgUN6tbIza2jFoY1Od8TSXfeQGtvmjOjY/2T8rY+++gHFbot+m49Xoxb6SG0zNfu1WRvpeaBbsFXGxIhQlg0Ch3AvuExMHFGct
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(91956017)(76116006)(4744005)(110136005)(2906002)(5660300002)(55016002)(186003)(9686003)(26005)(86362001)(8936002)(71200400001)(64756008)(316002)(66556008)(66446008)(66946007)(66476007)(8676002)(478600001)(52536014)(6506007)(7696005)(33656002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /Fr97f4filrbSDLjl9adUkAjZwiEeag0nyNxW9dobfRmgB/myZ+I3jRav+NKFYbkG4RYn8+fmRQGQ2mCW1Pixan5FQnrAI2KIPr5B9XJ5nBYUssroF4K84sffYzgcVwwL5i4Zan4ROmPNn7sp5ChHWtTTD8jtwnWFx0nAgYCMNhz4Epur4nKH0E1D03YWigWbSoCm0DihM5p4g03TN7ZC7UGeQ/de0sd6Ym1JTToHS1tF3Oa3LtUdof2I2HqD0flGhuuHerBby+pZuHCgiquEA5wzOCGeIMjjBn9bXjmhiO9R9S7xfnPu5S2aujlLz2ikI6nOQKSNjkN2K02Fr4lXTSwi4JydvfLrfHasmqgkeKMFEyrQwvAPI3hTesia4paDI0b54PgveScHVBuBoN7fZ4IBZM3yDQ5ZysrOSS//4vqPlSHda3UMXemcDYxUOwfhb2GTOvZ8UEdqB9Pt1IPwkzKVlS/mLKy0ziV5rUL5v6zow9uCFUeTnRZUT09zIBCECU1c9uSGQD8eyv4SSB8ahiio8utMyxrN+vH+S528pOoFlj6Ymnm2Tz2UrohMiTAhteSZ0Azpjvrx4J/+wHl8IF1bEdtcZgeP8qbivWjua1niymRY2l5poOC9ySmdKf3GsxdqFyC9skV/iIxvrpv5g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb193b3-698a-444f-38ce-08d87f3c00c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 14:31:36.0042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SgAYKWJHGIqpVkee3f+erWIdQ3ymiwvW4WSRLLnsWWdVatGe3vZU1dLJDp3CIupYGXtvSRUolNsH/th8wnDeoR2uTPen40pVRbJ7EYiQXPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5245
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/11/2020 15:20, Qu Wenruo wrote:=0A=
> This may sounds like a nitpicking, but what about "ffs(4096) - 1"?=0A=
> IMHO it should be a little more faster than ilog2, especially when we=0A=
> have ensure all sector size is power of 2 already.=0A=
=0A=
Looking at the actual ilog2() implementation (and considering you're =0A=
passing 4096, a constant) you'll end up in const_ilog() which will =0A=
evaluate to 9.=0A=
=0A=
ffs() on the other hand on x86_64 will evaluate to a bfsl. So ffs() will=0A=
evaluated at runtime, while ilog2() at compile time.=0A=

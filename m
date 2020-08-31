Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126B8257A3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHaNSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 09:18:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41858 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgHaNSW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 09:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598879928; x=1630415928;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ZUQizIRiUb9gibqmwnT7WUAhrpk1XixVfqYG4hG0a8RH55m3HXrIZCiS
   R6GfS+6vsmQWwlAoeczy6kGWnYf7gdBnGq+JGUt8t85WXtI5bu0TGnOQT
   e5Z9+3yfbEslvFtlBtF77I01uKN7a8O4T+dNFEiJ7aNpRXt57MGcXqwvV
   c8xpfnvMKt+NP6qAahZswS2+Ov2lVMVvVkEZZV9e1MP7ChIR3IZUEV2ef
   qr6w+YotqKAJLpNH++i/Awjz7Q5PZkJy5/e+yietwyRtIE6l86EXF3bgx
   kKYR2yUIHuIEVdqBHZhzTyqLdK106DdRpil2SA+lRRhcvVy1TRa3KszH8
   g==;
IronPort-SDR: JTJefahaP4cRhyj+y2KOut+SyyL24y2Bx3XTlHKp4Ek/DVis010oS44MinTCrcFE5Vzpsbhgxo
 zW9whmNQyUVdwaT7npFqwBO7BsNELbHix7Lf135cCuFi+cNWlGKUIZ6pUCtZtZjycqRrQ5W31w
 sXFidqO47czvXYrqcJ6DgjBmALfgf6VuQnGicafMxq1pSa9u09Jl996cNGDhmtB7zeGTwC3vKl
 3Mb3rKn68PhkQuWWHOJ3Dw9PZLSCJt7Pt4MFJnINCVVeHLaMS8dnIkaeyiVOmggZKg/tv1vBBu
 EZ4=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="249476636"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 21:18:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh+IMLjewmisrgJLZwYnJ8HO1MM72q2Kb2nDwZnIyASQF+GPCzM02z7GLwcSTg33hiJ1wtJiGKRsE6A9gxO29RLOmmuH5RdPkd/KoJvyhqqiYnpWCRHmowfGA/3t5C4PgC5xxXeqlWgSyf+OuEgYUP6wBFrrR/RgvpfAkba7LBQODcVQfE3DOkzcYha2XnKLWcFki6OjToGrT5n+ckDRSiayKxexv/UV6o5d1js3YtMbCaUlA+JFL+mO8OZmkprlOFj5dZV5hi2DOKU/0IzoP8bCO+FGGa0O8ezXMWA6bT/ncfkN9fHkoCVbRt1XxcU1Jh74o3QkF9n6xzyNyKUqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LJoXmTcFc0Sb8sn9/JhkQ7ZxNx7MDWZvSFZKnaCtSslUQFGC/4upg63cEg8xWSQD5M5NaPpPAMYjE/xOCMgc8xseWdr1xe9T7jOnJZWFnOVwwA1TXjW5kUXSr+fWO3hD/7Qf9jXYGAn40POLmKIJn0MlJVcWd9h0seC3/VcIAQtgKwwSqz3wbwccP7aNHzzOVhMXkwsGms6q3dvxydE1ynSJQ4feYSqDLjf5AZkFbj8xoSVJsMAHxsI5SQLfSTbei5c66CuXzw6GmKKQEgP1r0BLOCMCJxVVabTTWpp45rNvftEG0S7cHwGy1hhMAjAb/poO6eNwn1tCGKHRKoFnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XKdTArs3mrTLwxiO5gBKEbTB6Sy4yAsSeMKqzkioxRrty6rkbSwGQYLA5i1Mytx4sKLrmzhsL1ycg2mumyVYaaEgZWFv3qEbzBOTS1OooLzfZw7KzMJ8U4vzceN6lqgJfQvfqpw3TK+YV4Ftab5dA/4yEcY+8zAxy3eqoRdueNU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3599.namprd04.prod.outlook.com
 (2603:10b6:803:4e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 31 Aug
 2020 13:18:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 13:18:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/12] btrfs: Make copy_inline_to_page take btrfs_inode
Thread-Topic: [PATCH 10/12] btrfs: Make copy_inline_to_page take btrfs_inode
Thread-Index: AQHWf41vtLr1BN28zEOu053qVeIyUA==
Date:   Mon, 31 Aug 2020 13:18:17 +0000
Message-ID: <SN4PR0401MB3598CEEF5191EE515CF8A22E9B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-11-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c51:a08a:7ebe:d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4108cb94-0ccb-4b8d-0e98-08d84db05342
x-ms-traffictypediagnostic: SN4PR0401MB3599:
x-microsoft-antispam-prvs: <SN4PR0401MB3599D5AB8F29A18CBF818D339B510@SN4PR0401MB3599.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdSB+4crwthqQ2ilUaKK6z9m5c4WvUjsPGtax7Tq1XWh1aaKiSIOYH31WZV4EPvcfRStmyTrQs88t+2vDQfmmqw57xcWvQEtsARA+heCBGTu98MZGED59WFhrRA6+onK+4rMUp2KOeZu9swv4OqfR05gH+C9k+1LCHeXJc6CEtm5DWOa0ndDiQ+aYI0alx2+Qi/PV0Zl/4/X7bu6Yy0CYm55Z7Reffn/pRGyo8WOJj+i/S1jOB4kCqTEY5NwOxyHlrTojQeN4jR4k4hTWSDPKiCuGQESCNMnl4+r+KyQm4CbgPR2cSc4R9/FLJvQVqv7+8kTygTYula3tqu+mQQ0jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(76116006)(316002)(66556008)(66476007)(5660300002)(66446008)(558084003)(66946007)(478600001)(8676002)(86362001)(33656002)(52536014)(4270600006)(91956017)(110136005)(8936002)(64756008)(9686003)(7696005)(2906002)(71200400001)(186003)(55016002)(6506007)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lBy9jlqEGyKEJphHXroXitV+85ZPCLKemVnYmcMF74z/r3QsK9UmAripifhIT7CH94M/hYLzp3cdSaQFE/N/rNe0zPGq63dqSkkEgLdLoK0FBqEHdT1F+HRNvRctxRNT4KJ0gfnO/ijEZUuoFAVPGHTlZ2mchEy6cV/Z24qyx4pHTgM/AtZDCzXnocf7NgCSt3jGhc2jS0x9qwANk2QkUdaoPZhuwxBdmWIXNS+/7hAyPdWy7STId//wiYkTa0dI7Ke3P+66A1423XzE2+FKnpBDLoUnySYKuu/ag/P3F0CZ3DHvbb5fNhwhVU1BOaOtsBSOOgfEfw6fWs53u6Hke7v+HcSful6/GCmr0UntxAOE+uEc5+eUn97mOxSTgGqL84JbP0L2fE/jzmJlifdKEhAP0kBc9FGqosaJiqz/SqXyLQt4ADNS8hbATkDEjK9Td1uUWOPvKA01pfVFVMF1cGyjEDaqswE4uEHu3jO6qXYq6329w/EmiI3x/oRGRiYdYjRWbT/F1B51VG9rsL28o2Z2dmJn1GtSWE42T5xTUc3D0s5YTR0jKSgxeUh0LjZ6qESgJuLHN2/tG/wT0kzhN4NISd4asm974arACWj2nwGrqWXT9275fcJW4mt3W2et7SKTCKAr/q2smKDzedmzsbyFInPktIANtWk8w3LkyQsagz2PIracOkLEpgFV+Uvc2+GXAqzeeWM2a1EZUrUJCg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4108cb94-0ccb-4b8d-0e98-08d84db05342
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 13:18:17.8296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pgs6VnMWJJGlWVQ2jzzJLhbLBr9J0s5oDkjQTkC/oPbRfzWqmcHN4u0yJuAdevbZzVUN6XSzGB1HDSikCHgk8+ntR0jOfXYS2g19q0Pb1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3599
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

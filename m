Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BD1389378
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346699AbhESQSX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 12:18:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24224 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbhESQSW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 12:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621441022; x=1652977022;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=VlZf6LRnOWX5Rno/1BB28PmMsS2QLQe0QTCOW6FLK1ZdkSS5L+G4W/TK
   xy9gNxGt8qy0MCzDxkD5NFqJf9k8r8mb0MS9UYtzrTvVJFZN+hBO52Rjo
   muzpF3hgv7GZZpzbEqJ5On3QyNQkCLnCp6mzneRgrl7IePDiGMOm3qvxb
   OImiNX+XBfKJeAZNGcEQo6P1ZB5i274vSBbT0Kl1IyGgql9WD2TL7OD4H
   SK60d1R3se3Db9iIRnt1Il7tQxsFBkNYxOGQLr+dBhR9kKqBvCD65GZu5
   pVyY7VesYb+gyzXB0y5j0Ihb6zucYAaILcWF+FjQHV52uNE/UDdSBTumP
   g==;
IronPort-SDR: 2/goNVWpaEBfGzl3voko/3PwqxXkkbI43AsTLozLCIJ97Mw4PdqYBn0FY2ED0xh2Ph+BP06n/W
 orIBf2t9A7owHxqZuDKOQEpCFnti21PslWmD8bAJ4Bn0I0te74SXROIETkR5xhI66UQanSV4k6
 T+X6V7vHEWyTlsNoPfxf+7Fny/oEYJy49aN1rdb10yn8cQCOkYL6v79ldbdGYuL9hZ27ZYcxH4
 Ig5x4Ho913uoA2NejqnBtZuuSCQgIpsiZ+ep/nY4AWojqvy0CjA35J/GZ7vKDgvqFU5RoDIH0D
 vVE=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168722804"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 00:17:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABIvMT3e3iHH1s7e6nr/YocxAUGIyiUSXGeUfGVgIHcosFGcxpbZHQ2lIVt2WZJAhV2/3Ch3HQ8XTYWQ3/JL/1lqO4Da6fvNuZZ2EFYPArX0o3BvAKggUaJP7PZdRrCCgAuVVV9IG8mYqrWu163KvralSjoVBuxMSSBaCXyAGduvYR48Xt59hwE7UIseGLcWY+pmiKqbCJErtykIn2mB+lSJIF3El+ye9aiEgv2tfurpT29whoyPxyLfwNTk1zxChGNGUNw/pA+ZmukZI0oylLX4zKrGBmbkRm398uUNx3bllJ5kYhvtHVXNADQ0Y6dPeHASjxpTsT3LxQpRuIEPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=i/B8x94/SlzEJ/KbUU6l+B5F+YnrHN5KF7MZlcG/ay6Ysni7jFstAGNFF/605kPtFzVBrxnY1IoNTJWEO1iuGjgH2EQXkY7yJDatYSa0TBCUKHQpC+bjOvKg9/JZXig/4hXsaYV0aQohOK7e8lm7VAbttkZXJeH02aVnpRNI5vRxr/hahHFyCWv2UKGO4G8dT0yd/g55YKA70h4N2ACPwJRQa0HFU12aPvlsNbIIuiMNNr2WtvJfUppVcRIcH5uisQZYYVZilZ8la2vLqM4sDvWCFDVyqmCQZp5ClAR4MFOu6V0r92hIEPXTj4E5uBN+GCht4nRVABpy1wLJYvcGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=SQHB65uhbadlQB5Ln3iFG0ahFj/YNM9egso1R2m26FExv9lHXW3EjFBwhApAnWjxcizMHivi03VpQctapdN7fDSvD7U3Dh5YvM70+Xxw/RlQwCJJfiQzGA1LLZ1ClkIjglGKYAfJlRj5QT5AZ4I1+YMEZx2tlgV3RI8lJSa7VH0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7735.namprd04.prod.outlook.com (2603:10b6:510:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 16:17:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 16:17:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: check error value from btrfs_update_inode in tree
 log
Thread-Topic: [PATCH] btrfs: check error value from btrfs_update_inode in tree
 log
Thread-Index: AQHXTMNZQATBkrx5b0Kn93Xh13V2dA==
Date:   Wed, 19 May 2021 16:17:00 +0000
Message-ID: <PH0PR04MB74167DEF392D63EFA56AC86F9B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <2661a4cc24936c9cc24836999c479e39f0db2402.1621437971.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:95b:718f:422f:1ec2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6e88f22-f973-4d82-45da-08d91ae18870
x-ms-traffictypediagnostic: PH0PR04MB7735:
x-microsoft-antispam-prvs: <PH0PR04MB77359FE7CDBD450371EB403B9B2B9@PH0PR04MB7735.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dN2Uj1k8zc7W+wl1KCh881BkzOo7jMw44fVAz/L2xQ4Bb2lHOD+Iah/KutqFbQlIMMaz3ejWtprwkngYCFKVuN9brpNwblrhw57UEM4SREO1dJpfsi4EDvXTDpdNm12NGAKBswRpGBxHWFmHbN1OEuDv8b6/Oaj+7Ye+k3TqqwKTzD5abM0aFYdsMgnVAJmthA4UfVFiyZAAlJ5GurALvqDsqhoUQUzPgNy2XpNtJXgy4EdQIP32PSHDwebNVO7ZgEli8n3n1iNtYrmNawirCDfjcoPItsuCOTTtN2SJyqzl++NTAfjArxsk5kVlxiT+tVarKXmVtxVs6EwiV6JN4NRIv9AdzwVeqlsLGxMj51K9ot8IiYF1vcA9nk7AXOcq87m7QCzrpUypq0XAtYNf0rPBX6dijXu0u+qQ0BEPEwGUnsARrGakOBjbI4ujSbGV1q0LYxrPM1376cf9mo6ij+BgNLa5cPEJpDdI1I1CmhsADaJTDegLyy8/qJmMyVSZ0GSCXU9NdyHlCcWEfaGl5sIH8AdbTfU6trcm7vyuSzHFALzRAVo+n4gGK4go/O8NrW0eGQkKQNnli92Fh5UPh9pdUizys44uD8x2WGJQPgI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(8936002)(86362001)(7696005)(5660300002)(2906002)(19618925003)(55016002)(9686003)(8676002)(186003)(558084003)(91956017)(478600001)(33656002)(66946007)(66446008)(66556008)(66476007)(64756008)(6506007)(38100700002)(76116006)(110136005)(122000001)(52536014)(316002)(71200400001)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?l1GDNuiigs+aZ8zFU1OBOgJqwIxro7nhVV17DNnOsQKLwHZPyVnng4ZuX9Cf?=
 =?us-ascii?Q?AYjQORamWzM9bbLnBwcarFzUiRsMncSBh6TH4MRiKMFGE44V8cnqnoqVpXuO?=
 =?us-ascii?Q?Op7weFZZjRBkDax7+WUHlTCu77OrrvKImly3fIpaUPEkfumnypMQaejF1Rk7?=
 =?us-ascii?Q?xdZc5MOSWB5JalBH5J9XCq0rHkCbBKc12YGo3+GqRrEECpDZDN/7KlSal12T?=
 =?us-ascii?Q?oxWqRdIkQVXLECgNsN6hWuWL1m3CQC1OobM1644L6NVajsxSwVmLpWM98ZPM?=
 =?us-ascii?Q?aB7nfEvDV6oMAF+517W2+cb1IkzmHkirtp6DFj0AH8iVGAaLn1NaDXiz6Zem?=
 =?us-ascii?Q?TTdopc1TxUGrQQyQOsOoXQHAwlZ5w2tOuqIV7G1OGLd+sxp7Gbr6H1vs9oQ+?=
 =?us-ascii?Q?psaUKIUV3WEUVvsxlGAKCuG8miv6uanNxm7/HPLQh/38PeZY47CbSPI03x9W?=
 =?us-ascii?Q?zYbSXhl8nI7/A5caEW7wMVttFEQQsbMibiuumzzPbOPy6JRSsOHU2e5+AoVT?=
 =?us-ascii?Q?xtmjmqDAeL1SQhnEBaf9oKxu1kBmQLvQXL/xt5MKyNPmPFAJXkvy9UAgwNJq?=
 =?us-ascii?Q?zP+OCrjceGEkrO0md30UuR3F2z5DbikTZlxgmXK1FL3bmOytVT/R+FUZjjJr?=
 =?us-ascii?Q?f4S7CqFQGQgrR8PLf954vDJk4p/Jh6LA5Pa7d9PhDV/Ge2h9eURKyWFv5NUT?=
 =?us-ascii?Q?1ieaVjaWqtQF2O9IBxfA3qd53dh9dPQ2CdFm6ri7QH5jt0q9HHUwbyNS9ayw?=
 =?us-ascii?Q?6zzRNV8IRreWZ4wLM2NjYpEDRlFPjnUbnSH3Z93rfNZ7wkkqC5bFelTVf/UU?=
 =?us-ascii?Q?xCpSqZDMDcZMGq21PiWpZl1cf1wqYY13hNK7BuGRhRHQEpZOCO8eHWEcdNEB?=
 =?us-ascii?Q?YF8liyKY6IbHsX2m/DEozHaWbHSI3t3oS+gEooTf3jd7XaN1yBB1vDWfqQ6Z?=
 =?us-ascii?Q?6GmM3ZN3DV1YwgANna/esP5wuE0cnGVFrEvnvUAw2GEMx6qn6lDPSl8JIns6?=
 =?us-ascii?Q?+Z4mpH0IOHWWb1PFuw7irihp5XoNFejgqmUT2eBwZaeLJ1FZ9E7hPn9Xf6PJ?=
 =?us-ascii?Q?fQi1GQ+CcsyLMJ/9umurk/UxnrCevQdKBYRgfACW85BcEZEXIkA1EUFfDGzF?=
 =?us-ascii?Q?E1xGiWWJQ9eDT0UaXvbhg/bmGIbyWHeqALStyWHDKtHAmu58mAyuhpDNh4o7?=
 =?us-ascii?Q?F/qrQmm9pEQXq2qoZO/ovmM7cS8740rQnIkJ352+nu7z32i03bJhHdi+1b4n?=
 =?us-ascii?Q?9jmN5Z94Ie0TJja2nTE8/fshoop4Oiq1CCHI+lhcKOAjyFJITIsrWvvB4IOk?=
 =?us-ascii?Q?eo8xH+LZ3JFiRHf+a2+GR2X9pPK3Oo1SRVmd3gxCHkNM4UXiNYKWg5cG7j/j?=
 =?us-ascii?Q?ejrLT3aVc1H4GHvp5rXjqDgCzmTYe+6+5KeAw4SuR6bMgeOI2Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e88f22-f973-4d82-45da-08d91ae18870
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 16:17:00.7464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERm5Xq5SvnU6d0CHUcMQaiw5QX6ZfJa1z1OivmqC3N+/4ptachVjGs/tL7mKLx8KJ+Qy3lUkWPSfcH8kGZWZoA/YpgNBHyihzHyhWceK0JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7735
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

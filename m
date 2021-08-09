Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191803E4358
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 11:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhHIJyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 05:54:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7774 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhHIJy3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 05:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628502849; x=1660038849;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=C+pVjDaVmQdcCOTZZ6vT20TSbfWgKBVQUA/ARg6V6m0=;
  b=oWqOty+ZuJ1J+n3QCaaX7Uij6P/m1HqqnH4gtFFgkYcloiQM80pTjvoA
   4d/4lc5KBRK/vDdwxREpeHROlrCzLGAs34cJzJfNfZcCGo52ZFi0CRCZR
   fjA6YsgdKzuVczl8iHAdrTUakcfmzCtEwwHRcWCsCjkwDcb3f+PxZLKVv
   WfGPqQnRLpsNpkPpcppJyqExsTezG0IGhXEk/GCnN8JcmmsCgEUKX+LwP
   F/smKvPwp8PQs+6y1rrGvb2DTAmciaTr5kEJtlYshN+gmtwRhWrorX4Rh
   n/PBRgk490at+C911kX2t/aij9ahfGZZNeZra0ytegQSt1rtHh5WJ13yv
   w==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="175880820"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 17:54:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/Pu+jf55QF68qT+/fMD39Wa5Sjvwd8G1tZDJj5XyLXOPhArFmquERIHHpSlOl3UHcCiZFqqGRmHlpqIz/2eQAlxYXRiGpVTAx3BiRSNzpU3QjPsE39vqh32TNtcDDDpnF/3CYKiPIgwxDMmJk8kf/K7EfFpXLMJZaxUW3oVTYg38q8wsZapwCPVO7N0DcbHrOmjkEXNilwbLnj55dR80EahWoFMR4+IuW0rsyooD2wIwJNoTBI7cVzNqYDcKgQOi4wKcuQmrUWNZPqiqjOESBqAjH2Kmnh9wk791yjAa2u7Apy8usJNsr32KYh6uRmJPvArbCIsdygnzqxv3U/bOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+pVjDaVmQdcCOTZZ6vT20TSbfWgKBVQUA/ARg6V6m0=;
 b=IE8GP3XXlc4WbOd1P4GSLBiPPyTqZ5Ql+uPduPzbHBhUlyxSo7W/7nKlb+KAlTtTWwGpiKWRp/s3fOEyYNTcmJ2XBAf/hvYCKFflZoUpx1JUokj7ezykE+9y+Po7LqsEYmVWUEg0J0XOQB83OO9Qswuv/B9O+oz5U0xIo8i0IuAHNCZ3TNK2jI5hAbxkgi5CDBvIb+Lx2ugVeMlHPQGK4eNBaXADfWJ9jKf01hi5hB76BRthSOphuo6aXbCmVyYjetiakm2J7DCMUTv5jXyRwb2QpSxhdthPWl0R44WUcinAcgkJWas9fguJFQuUR5j93naPGOiQ4GqfoOQxH/QkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+pVjDaVmQdcCOTZZ6vT20TSbfWgKBVQUA/ARg6V6m0=;
 b=DHRTELYxysTSTBYI8YqQhDDnKnJxtqtg9O45ZzwN41AUsrtoOQ+ssY54YHpzZAPrBcuJPfNyYrmom+urVWGno/sLot4mg82wTklSa4/5syaX53pUCnjIfN6bg/FLOfXsWz+Gd3v802/FBarSjiytFqix24eHaFC3bC7TigMF7XA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7431.namprd04.prod.outlook.com (2603:10b6:510:16::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Mon, 9 Aug
 2021 09:54:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 09:54:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Aleksey Utkin <aleksey.utkin@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Cannot mount hm-smr drive with btrfs
Thread-Topic: Cannot mount hm-smr drive with btrfs
Thread-Index: AQHXhUcnTttSSfFdWE6HUooC4VDmgw==
Date:   Mon, 9 Aug 2021 09:54:06 +0000
Message-ID: <PH0PR04MB741676CA4948E4BC897371769BF69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <66714993-3927-8fc7-585b-398b8e4dc655@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3e89930-70f5-4f36-0cc2-08d95b1ba0c4
x-ms-traffictypediagnostic: PH0PR04MB7431:
x-microsoft-antispam-prvs: <PH0PR04MB7431B34688DBDD5D9137A8519BF69@PH0PR04MB7431.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dm+tUCiF63GCodIAtUQ6zD6oEgiy/80fdxhcriqomp0ZfavysGoDMggsKHL7iBXtaJel2CxILNTVt1tu+arwKtyPko5a12oQv9wUita5tDMZSmo/JpzXpohsIyF2eGvE359iArsngPUDYIG/XRSsvoVuYokDZwiJRbXrTNibrRtoUMDwtweTV1JcnQJS0vy/2Hkzs/XG1P6XMfh6vSvGYZLqHeLiDyoiLWD0CaLqo1OGvEonShLTvTm5xB7QW/8jRWn56RCPfvkG1caqbZQPjRF0j2QUpLhrqvFK0c2Fk8SkaxLx7AcsVzDP5caw9gXRQgWAKdaGaHWQTxqMr1XkajkZ2QEVVno8YYgh49k1sOu2qS8yx2dtWtbK3rhBBHm1SGvD3gcxrcu5xNlv1WmmFXQGfPcBNmtrOVhQ6p1XN1e/fqEMLbw9by9L0ft8ejkxjlCAL3iSVbPXOZO7zjH+sHFHVchQrYPbBmVRt9ANcvXPXEVVigNdABWvkvXopaR6aogsdsqjpP3EhGg5NtOqsMAd90b+za9r9bkgP+uIE6u6RzsiAZ68vGD78z+0sCZB95a05aq6t5dfJwQfSFNqAo4gJ8iIewgFsrZb4P95urCG5siCooVToW0ih28jnEtgenaMCkCuIyWM4BgHaXiFUeZjsm1/H81Sg/NPiGQ7znlEYR5HC/HjjGkyqrezFNerLoy3BvzEZ/RjSnojD2pvCucTE1T8BdDiiUYMvjVvG/XAW09ZtpUPZLvGgCiHUBP3dY+xAlqfJnO9V2PmCforPWl+UHafQKo1Ikfqrvr9aw1JwcCQzSN/tqnGqQoJeM4l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(2906002)(53546011)(86362001)(7696005)(38070700005)(6506007)(38100700002)(122000001)(33656002)(83380400001)(52536014)(316002)(76116006)(8936002)(186003)(478600001)(5660300002)(9686003)(55016002)(110136005)(66446008)(64756008)(966005)(66476007)(71200400001)(66556008)(8676002)(66946007)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XD4LJPQQ4SQZlRrVFP5asD9czZYLyNdvPtnr+yNUazgFoAvuVzYIOKn/9C6m?=
 =?us-ascii?Q?afcGhGVSso78cIbCxt42OafA4I64vCnRut/TTgtYZFz4S5sgbthvZbn0l/9v?=
 =?us-ascii?Q?5rLzbGhJD1ou0NEbnSPtRrIV5drYK9OCh1SmrgmzV1KPNSAiv8ucHne0FIYd?=
 =?us-ascii?Q?TVL793aeLxDeODNPT13HJlA5V6RP1Su+tM7DdBn5PwuMSGe5BmgoZKgr0SaT?=
 =?us-ascii?Q?qFRluBnRi1wV8U0PHg/xSKUXJHCEkaw9aqljtfQcS0xSOjozm0URmRmSO2yL?=
 =?us-ascii?Q?H/+GMm6b5xYHVplXvGyJBFKEhOWQ/qE5YTIRkxntLXGSQtk1PM8Kin/H0Q0L?=
 =?us-ascii?Q?1rGe4IxGZNLAApLvL6k1SXUGWWO2EZtyAxD3R08z/A/4gXNvhV09bt+VWVop?=
 =?us-ascii?Q?tGYNoHdjr2DWnW3sifjEiXQV19V3UcO97RVwzff/FuZ+X7+zhBqlSWc/48Qz?=
 =?us-ascii?Q?qCkxD8kYqMepGFvSdFjdB8wnAbfnaFscDGR4zqrWK5JzqlVPHyI+a4Esdgnm?=
 =?us-ascii?Q?OruJWDAxtRbLXNCN0icxK2ti2vP3+D13cUYvRXSNPGWkkAqFh5zcmLfOu622?=
 =?us-ascii?Q?b8oW+LIegK2HIwk3tEBVe468u/jFKIpzBecU5adO92IZjEnosMfZrV8AecyR?=
 =?us-ascii?Q?vzWISLeQC4xTu1RBqGGB5fT4Y4CeFfdAAIGlOH4WsB1VZFEJejuh7ubSPkFe?=
 =?us-ascii?Q?euCh1MRj22cxlE4PQbMZymSC02qGRPEDzrSRghKB/UqzCwqRAojF5rr1KLz2?=
 =?us-ascii?Q?hMPfw3JrFzmyPPKzp8qS+SZAfAggkEhV4q/ozympTl1jnFwIqUQPYHsb7Z2+?=
 =?us-ascii?Q?5SG/zYj7bf25SzX93PB5G3dlYNQZNT9P4sI0kjU18lPaiUkQJUp55iDbjQGM?=
 =?us-ascii?Q?sktE5yBH3zERh2+cc09BPhgunabBsaKHseowUkFnESjtMRCmzV6pUoK3CvDO?=
 =?us-ascii?Q?aLkfTt64u8hr0jBDH8AyYMrvPnA9OmfApTseJWRdm2tv8BqwkZVTLY5ZGFEb?=
 =?us-ascii?Q?LZkj52L0leoBRqg5dhBlPlrkGShusIKtU0xgakg24GF3SN83tJJmEEKX1cXT?=
 =?us-ascii?Q?cevRGVN4GTCh9/J7ay/s0kf3pZFxUZ8spxq0s9032KFyAf3U7KQfsJMuuCit?=
 =?us-ascii?Q?Zx8+kjwTBJCgUxdqr6ZlSz8LTzRdLNEs0c0x4m+bAwI1MsNBMKP7Qn2R6XFF?=
 =?us-ascii?Q?r/STkAyO0Y3nLyaXvInC4L+2Y0sMtVJ2s/KwTa1SHPuanaXeBGUM9RUTRQd5?=
 =?us-ascii?Q?6KwxWHe/DOtOE+4zWcCrP8tiOW+K0z6APdDcSkzDrqvdH34j6o8EvvfNCE31?=
 =?us-ascii?Q?E/q1h/D+GgM2KuzTO5ORGxJ8RG54fAyoisO693K6begmZHz4Vjk+vkkAHCPS?=
 =?us-ascii?Q?mgZFC8d5Bnp+EJKLu0+dtyiK5+irQdaGI70GunwkvlnfHOq5ag=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e89930-70f5-4f36-0cc2-08d95b1ba0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 09:54:06.8127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsSqjPEpb56nutToBuM3qPDhRhvuoQR+Odi0vqkZHycUPbNYbd4s8HPv2Arlx569NMAgnTWfCq2m3ZkBE2qllBxi/9yHQOVQ4AQhcBFl8M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7431
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry for replying so late, the mail must have slipped through the cracks w=
hile I was on vacation.=0A=
=0A=
On 30/07/2021 15:31, Aleksey Utkin wrote:=0A=
> 8. Operation: Attempt to mount 1: sudo mount /dev/sdb /mnt/sdb=0A=
> Result: Mounted unsuccessful,=0A=
> Console output: mount: /mnt/sdb: wrong fs type, bad option, bad =0A=
> superblock on /dev/sdb, missing codepage or helper program, or other erro=
r.=0A=
=0A=
This sounds like an old libblkid.=0A=
=0A=
> 9. Operation: Attempt to mount 2: sudo mount -t btrfs /dev/sdb /mnt/sdb=
=0A=
> Result: unsuccessful, no messages, the HDD activity LED is glow, the =0A=
> console frozen, ^C does not interrupt the mount operation, the sudo =0A=
> reboot is not performed, the restart of Alt+PRTSCR+B is performed.=0A=
=0A=
This OTOH should have worked. But looking at the dmesg output from [1]=0A=
it looks like it did work:=0A=
[ 1054.626456] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dyes=0A=
[ 1054.705975] BTRFS: device fsid 4312bf2a-376d-4a44-a69a-6bb112b124f6 devi=
d 1 transid 4672 /dev/sdb scanned by mount (1926)=0A=
[ 1054.855944] BTRFS info (device sdb): has skinny extents=0A=
[ 1055.315175] BTRFS info (device sdb): host-managed zoned block device /de=
v/sdb, 67056 zones of 268435456 bytes=0A=
[ 1057.219336] BTRFS info (device sdb): zoned mode enabled with zone size 2=
68435456=0A=
=0A=
So I'm not really sure what happened here.=0A=
=0A=
[1] https://termbin.com/6g54=0A=
=0A=

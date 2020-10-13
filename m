Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF828CAC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 11:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbgJMJH7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 05:07:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17318 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404121AbgJMJH6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 05:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602580078; x=1634116078;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UW6KQGVO6/w5YWe3gEPMdWVGNEPMAZH6jmdcaM46gu4=;
  b=plNc7UzJJ8RO9yKLeNoEPxkkZYO93caif8GYkdajj6urMG5Htjz/QHq5
   AHkJh6mrdrZNoKDFNIAgIxFK4E1lkqrJd9uzaL+1C4MSHXzCeyjRwtp3d
   IepeJsn4FgpcY+P4XYx9NeUK6J6v6rGRG6RzI4zTQWFFaT1BgnOgDRh6z
   vD6Ygy0zOuDB+1SN+EPhfRN7o8SotdiwWrqEkzkm+JP6dB2nOrfMZ6vhZ
   ILCmOHvPe4Wt+QLD6/wTRCkaPknA98avovycAChBV3nRzxMMFFhFRKJjd
   Yhnm9gwDSCV1EUuJ08effEm04inAFZzJkrIxw1U6h+Gv5izbOzZrEiVdI
   A==;
IronPort-SDR: za+gDPIAmPaM9PszIz80bKDfafXigb/Hxngslb/PPiKucfcKXF1hGJmxulTzZzMXQ7YFjBWJAf
 9IbOzvNHx8iwLwmMyy+S1LeY3zzWYbZQjSCVWW28JNnwwpgWibv9cUBsdoT9mEOnPcSOdzWNIC
 U2s40J/2fbcxDj98fgjkhe7FDd0ZCC2orFgOc84vdYzwVD4loPjRDNyXNjx+LqzJ4Spt92JF7b
 oIUPK4uYt9L5n10RcG0aZVDM7yeLS2IphHHhbSi382ZvLDnXhBRBOt92hkldtSnmv9M+dAFltD
 JLI=
X-IronPort-AV: E=Sophos;i="5.77,369,1596470400"; 
   d="scan'208";a="259544248"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2020 17:07:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrbEuhYVBPhEcC0ClpJNwHP4SDQFYWeo7ls70VC5vNHizyL9qmqCn8vouzGH6KOQuFifro+3cKnYM26FWE/drZ85ycu+KYeeUPz7EWFw1iukiLp0JWjBDbB4u6YQRKanJOzCtXdvz+bya5xPFSZ49tWxms9gll8usT/IlYC6g/kpsxPZcZkaI3KHhLYXoFaiYT/XCBID/gpyXWlRs/Ji4OXqF8L/FS42mYmF0H0/t/7pdlilgjEDGniwmOrGLtEUhyqwI5Sy5ThedEppDrxYgHvhm2Y5FHwc7fv+HMHIVSI59JgRSyTn/TMM+12YY5nfdHmj1wtuT/Pei8rG2ghTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW6KQGVO6/w5YWe3gEPMdWVGNEPMAZH6jmdcaM46gu4=;
 b=NtvfF/AGV159XL4J/IiGxT15TFxfs+ajsGy2EHChaX9fhM62f1td6yqNuvo0y6zTdIR9BIl0Jsz4IVP/4VX2JsQ5NfgjgJPgcOBphv5ahZIcT4SRdPBwD3fbesY5c9k4fc6HVj7/eYPQcsTTdvaNRIBabQS9kIfRfIy5ULyzvo3VbmD5UYTF++3KLWpFSF10/UMHznG+HbGZADaG7IZxd7RulSFuDj/g6+iOBWFuMl553j+DKQ7gWJhjL5bmuAxp8U8Ox7H0Lyb/lvj2fnGPU1SjZ/7IDdLpyjpIoFnSlQJ3P/YNvrv4niCMgceD92loOpL5ZNT6+xn+5wxLxfRXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW6KQGVO6/w5YWe3gEPMdWVGNEPMAZH6jmdcaM46gu4=;
 b=bMeg/oRDF0zVhR09MI+JwhmdbqzYa2QXhaZXkeJNKaP9lj5+T5GjTCcDcORCozoKGe5Aq7+b2d7vwz4n64RNzFsCpu0+jHuQ7Md0kw+4Zs6kNRrgt/C8U4D2+dz9geHYY/FGTphkeXpVXAFQxei4H96Vd69PkWldEyiHtqfEEjo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4927.namprd04.prod.outlook.com
 (2603:10b6:805:93::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 13 Oct
 2020 09:07:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 09:07:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: assert we are holding the reada_lock when
 releasing a readahead zone
Thread-Topic: [PATCH 3/4] btrfs: assert we are holding the reada_lock when
 releasing a readahead zone
Thread-Index: AQHWoIY3ciNzxOWRGECrI9HL++8YqQ==
Date:   Tue, 13 Oct 2020 09:07:56 +0000
Message-ID: <SN4PR0401MB3598176352537EB6551AC3CF9B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602499587.git.fdmanana@suse.com>
 <6c59a12446b7583172c886bee886d5229f7dccd5.1602499588.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac27a4a1-4901-44ff-efba-08d86f577981
x-ms-traffictypediagnostic: SN6PR04MB4927:
x-microsoft-antispam-prvs: <SN6PR04MB4927FD4C86BD814A574075059B040@SN6PR04MB4927.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JoTjD49j6LfJ9/yjfkixtM6CxnuAvraG5jLINSZFacLJ079vVsHpnABQazEK2tJqGdO7xRVVyh0B1BxAO8FrePhCuEzsvdPlsy5StsmXIr96xiJlbZx1asdf3Swm88B/RbVY5yinzAq0X1Z6RG1gOYYjvYjGbbmjOTpJ/VxnGHYfQk7KLDGUcLTPZwUwxpaDKdVCyAgIReVIx58f5JjMLWlcWGO9HEpQb+ieVjRWV0ZBImMNNkC50IYWWR80wPtx7omCssElsIq4aqdM2WVzL0JvTn27IYxUsSFznqOgzW0oEdPu9THdlSAm3wt1/K5HNnG5FEJrvFxnbemOgVYkBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(55016002)(26005)(71200400001)(186003)(8936002)(316002)(110136005)(9686003)(53546011)(6506007)(7696005)(8676002)(86362001)(83380400001)(52536014)(64756008)(66556008)(66446008)(66476007)(33656002)(91956017)(76116006)(66946007)(5660300002)(4744005)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 01yHi5bZdAIXHRLWjbRvchMrHIo/UScpgopG3RhimE0rO7qdIZ9dilBYygYJJuSHMI6t4kypv51E+ZR9CvfUtNA1vcjn6gCcsmnHXcpDpbD2fVUAONmJRSkj0bTyZlk8/NQpuxRYDj9fhOFsydxScNr0vbll8kyVlNROgod8Ig44+v9HWLNEI5XFqON0YKb7Y4omKiOZeHWmppQ7uZz2tXds+1XDkyytr1vDNAiN2/NO2DLeuUNgds9O7uyhUYLLRLv3F0KCBFCya26NnshmQhWKr8RYnAa1TmhJUpOkajTjHeuJtmhk1EPOCuqTrKU1YApqYdicnxOeTo1YE60FbZtbEC/Oc2CPK+Bsxf75m135eMq9oo/c+6aH58hkbfwcgH7H6oGHWRIJt5XumUB0fLHn2Xj5RHZPBoA94qWqYOoU3tqhX7aDUwSKreJooz1y16pvKfzEPC3Y1CIF1E2NEfF3i26GuIhkQkzvfbXGEbN07ipMpcU3RgDBH6xw21xo6H7LiTjJSO0wbsb8rOCKA7zsTHykCR+tJm1jJO4ECcTr3ujMSIahlbSxOI8ncDlgZR7l5rUmrEUE+B1QWZm3THiHUEFEAG9v25cq6OQrYe4mx4oDL5ax92gC3xFM6AeYLdDqfCu09detEHNDG7wkfw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac27a4a1-4901-44ff-efba-08d86f577981
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 09:07:56.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzNL3upQ/nDG8tUmg6jHaFuYw17/N58EdIHkwmJiRkeMAIzVCShiXeqYczFwj7lSzqqDjHBTlyi+4cSecG7ITDDJSrjRFPEHfVwKHWSl/qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4927
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/10/2020 12:55, fdmanana@kernel.org wrote:=0A=
> critical section delimited by this lock, while all other places that are=
=0A=
> sure they are not dropping the last reference, do not bother calling=0A=
> kref_put() while holding that lock.=0A=
=0A=
Quick question for me to understand this change, is 'reada_pick_zone' the p=
lace=0A=
that's certain it doesn't put the last reference?=0A=
=0A=
If yes we should maybe add a comment in there.=0A=
=0A=

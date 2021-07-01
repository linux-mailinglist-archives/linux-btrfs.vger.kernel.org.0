Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27913B8CC0
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 05:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhGAECM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 00:02:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4644 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhGAECM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 00:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625112005; x=1656648005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EhFTULe+vBkLBjygAQvEsJqE+WpC1hTRFAsE1pZlc4U=;
  b=DgAcrtMsMIHwlg+r/kzgXGoXoQd52MPtsQ4Nvy4eNnBu2dYrY+y52P1M
   cAoEw27skqKiM2uRTGfOMfAip4hjMAG77xeDS2eibaezX6ojNYO7x4tz/
   7cmmLG6F7/QQbyZDGTVlWbupl6QXBfuBCcDDX3RUMjgWk1DKsz7z9HCfb
   0DPNNjpN2YEXkZky+o0i5KDl8ODMsn89C+urumLHV9TRyMMzemJjrI/e3
   wYNJgV/JT55QAVfiE1DWaMyDbWurE4gxF5YW+r8ubY1k9m8rV5yWf9rgk
   JWsIV7VNqbZoIwxBNmH2b5UYzL44600XUJ4c8LZn3vYe9i2NnoTWOm0ga
   Q==;
IronPort-SDR: PGl+LtP4OJkjjWl76fh/dekekd+W8QpKZUhB2n70Gg27R8bpGtJV+SN3toxLfue4UCE5z8jRCv
 bsydC5hfLnKusktRkr7Sn28CI+jpTorHy9mq+b740iD0Gp+G+CM6y0bfFRNxxGGHgWC8mEiwCa
 tebifEdB7F0lgY1Eax7NZznA7kKZuKMQ4+IJH5/njVQHZHs3WoWL4ZmeYiBpFwH8Ju44SHtYkV
 /U9S0OfLNJOizxqEljDAgGYiv3I+LJoC2iFlOpSjwDz8f5WVA85ZkqF2hTGfnJgPr9Ef0hrDS5
 sLY=
X-IronPort-AV: E=Sophos;i="5.83,313,1616428800"; 
   d="scan'208";a="277199116"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2021 12:00:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N36kPeGzslYQO2gNnBjTqqXN2qhKX/ACoDK7xSMz0zyxi95fx/KJlAC9i/7RAzFNqqUSm9SPVqmvS3g1EDDykkfoLytWDU8/yUj5GBpaaB2vEn9ECKcGbzZ5i2SF7RAcKcZZ5BPJlskau8PkalIo2s8gPxh8f1yHtrtDR6W4Qq/2CYiHzdiQG1rXVqvF8/C3esREkwlACmrPT4YyWXN0bo9uwzE2itW27sykbbcFNb3f73TNUJpPmoNUM59sC6NIkwk5vn3QOabibq3B8hRDnCDWvnM323zS1SlU868FGr3g/KjP19KWgWrqYsbRohvJez/80L0YDUG1YUYHAZEhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhFTULe+vBkLBjygAQvEsJqE+WpC1hTRFAsE1pZlc4U=;
 b=HNkdFyCHsEL9hD3NLwLTtra/J/whuB23BDr1VreCndZlrg1K0GZJiHOLIg2JOZx2lqQtOtX5x99T8hyFVcTL3X+ic+FougySb9j4/VjlHh3L7KdaZwwxxf8EaX994ufaLeIIv5L7Y9gtAz8odWWQ3L5cESnIWPJZmUfmtewYaC8+SOotD5q/ywbKd6s3gqnCyDhf0nFr7nTm/L4BVBfWuLMO+haGCi4R9VcddB5hX9YUyP0S5SukYzc4P7trGE7KhXqXIncki++CO39nPF/Cq3bysEFbvr6n0la0uY/LPvwVyI34dADUD2MGkcRMuVULlCKyJ802UiPN+tXUThgE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhFTULe+vBkLBjygAQvEsJqE+WpC1hTRFAsE1pZlc4U=;
 b=c11gNOQD8j5fv54EzVHfxrQhVVGf125Ft403qqxnpKT+I6BI8RZixsMC14U0K4i2tXPnCDh4O5joyya+grQ8aMRKIZ4288ptiKfZGsW1Z5OPTZjVciahmsIW79IMJtk4NFI1pj3COzWo9KmYlpFJiuhRTqbglk6TT9XlJ7c0I3Q=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB4392.namprd04.prod.outlook.com (2603:10b6:a02:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Thu, 1 Jul
 2021 03:59:40 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::801f:2817:2957:5625]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::801f:2817:2957:5625%3]) with mapi id 15.20.4287.022; Thu, 1 Jul 2021
 03:59:40 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/2] btrfs: eliminate a deadlock when allocating system
 chunks and rework chunk allocation
Thread-Topic: [PATCH 0/2] btrfs: eliminate a deadlock when allocating system
 chunks and rework chunk allocation
Thread-Index: AQHXbi2DbNJFhY2ix0Wefxf6czxttA==
Date:   Thu, 1 Jul 2021 03:59:40 +0000
Message-ID: <20210701035939.qpuiebd7ieoi7yh2@shindev>
References: <cover.1624973480.git.fdmanana@suse.com>
In-Reply-To: <cover.1624973480.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7839217b-5e4c-4b3f-486c-08d93c44a6fe
x-ms-traffictypediagnostic: BYAPR04MB4392:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4392F90A86D2F15D5E9235E2ED009@BYAPR04MB4392.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkzT2OZmf8S3qUhQEmTVALerK0QpnxfJiT0uNltbJk96PFtzVUrdG1jmjmB/WxEmN4Uv/Np8RVR5hf6FHYxNrM2pbW4NmOLqhK6DDlI+x2NQ2e4ZrdSlVbgayohQnJNDb2Vf1N2sF7WOxpLslp5cBnq/wbbMi3K+I5CbiAHFE0g/UWnmNKQuUvxbwaF94Dv38q62sSU6I/SikCPseygSfFw/U6k8T1gI+eAY/iS3sCHs5suER8ry2Rv8auni0MdpolNxFZTBe/D0vQNxql/hLw/8rqrKzlHfoKPCulYHQhMEdV3l0CkaJrVgssDK5tFkl/b5UN8QwAaycdlEhuvq0pISL4XiPeFGCWSx+ZeHXrrcQ7ND3B9PT4jHG0Dj+AIBZg2gyKRotNfE2iqhHF/99D9qCOPgp4FZnHG/HX1G5oJSgDiYF7s4rbDvF/ILz8oM55ACYZYBMuCKPa0kBPw7hsGiP8vlNBkGAs/k7/gx7oQqZeHWJQ4QZWAn74qQAD/k8+H9beiYhPg/X6dyZ0w4vlF67AwjU8iyghr5cHFHTGD3nWcMbkwlHehc0fGoMdc2lixevuEvrDIOndY/Y0PKnd5a/w4nu/Z8+U68HSSQ1xQ1FARhWRtnKBLHnDL47Dp10D6nXItP6u7U+YlDdfg/Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(8676002)(6486002)(91956017)(83380400001)(54906003)(26005)(2906002)(76116006)(86362001)(64756008)(8936002)(122000001)(1076003)(66946007)(66476007)(9686003)(33716001)(6916009)(316002)(71200400001)(66556008)(4326008)(66446008)(44832011)(186003)(478600001)(5660300002)(38100700002)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lXE5Y0jSPYqWFB/Irahbg6gAkqZ+E3oRkUi5vQiNBzNqRdnPnMbfcgi41lVa?=
 =?us-ascii?Q?dOHwCCVNgHOehKj8Rv5DABm1ejUcM/rHq3gwJN5nnTB2u0p7M32rcD3MIcVh?=
 =?us-ascii?Q?9hHguiGsmo3aFIyH7HrZO7x8gLbFNDe40AS6wmp4++2ACCwCX28pfmiPyL+/?=
 =?us-ascii?Q?Q2r4/ihAqXZK97f5j2jrrdXy5ob77spkaCSaOBxclV4GbcsOMbNm0Wvu3hWa?=
 =?us-ascii?Q?47VXlbtZ2p2U/huQPgfy/qGuS8D6jIzDrb3RBxSrVMnu7TqUCpbxd7NAQBlK?=
 =?us-ascii?Q?GWqK6HE/ZAjysGYHm7/G96teOCVV/gTvgJb/fBGnyMqLXGImaGIKyKbxETQm?=
 =?us-ascii?Q?OnEcCln6CNH1l6CGYY+w17dqhAqBKKR32kZBEo19TFH2qpmIn8aeDFIMShQy?=
 =?us-ascii?Q?yn/1/jPJtqXhbd+a1q3iSwV0gy1yxohfmpknsKUfudqImU2yd3tb+7varQe1?=
 =?us-ascii?Q?JvjiMwoAu90HrTstBnrGKDDKu2RF8snG/vk+n/gERBCtobIWT8/TjYOZqL+F?=
 =?us-ascii?Q?CiovbKHvuK4gD7+aYuUBPuTxRyR8uMW6btN8Jr1xReT+6t0Q7Ibko00QHcGN?=
 =?us-ascii?Q?viekt3pNH5lHVoqhAr0vEe87St4O2BeChlxR2cmrC410KKZ6ZM21sJNuO1eA?=
 =?us-ascii?Q?qlGY56VPlBPFGa+R3/XzFrLoK+O3szr2yZNzpEX2IpnibQj9Ehv3BLSzahWP?=
 =?us-ascii?Q?gOUC95Z7I7DDEWz3WvYzJj0d+zdVCa/SE4aVrC1AEgRGMDdsLNQIdv8OLWkH?=
 =?us-ascii?Q?QW5z8Ga525fqROJfDVXV1j9tlb180jkUOIJgdU0LB0tChzEkAGSbHSbTgrf+?=
 =?us-ascii?Q?n8MabxcSDZquthtXV1R4fH26Yn648JK0hwzncNEvbtYjxTu1vHJI4UuEsdTh?=
 =?us-ascii?Q?93r8Mce2SJCi0nNDdVUKmQYw1MOhklhPx0is8U+s2PJi0MT9YJDRAhmznNLT?=
 =?us-ascii?Q?7itFgT8Y/RNOSjkoDP2Amb/SGLPZvB//twB77wBaSvaHhFCozxuyitFMW/xQ?=
 =?us-ascii?Q?DARlKZL0EhG58hQe3jMwEiSLGuboBxW0729AW1JOgD9wMYzNNfwZpddwUsp9?=
 =?us-ascii?Q?g8zQozWJcs3iHoT+f6AAVocjlPJVSa90yVXSnkNdSBnq9o9sMdLg13PjJ74W?=
 =?us-ascii?Q?xmKhZMlru48KOuZYI5ZedpWXJZArSdHCtDBo3oryGMUKPaXO2aduTD7MLtla?=
 =?us-ascii?Q?jYkLt0fsAjQfWHLralXxGI/v1geAzIqz27oqdoog9SIqLqSalhz5+79yo9o9?=
 =?us-ascii?Q?LFH0s5BjGqFz9H1yWUhyWooGNfJRUyidCzsT83ScRz1JOIDQDc7SJmsHJhYL?=
 =?us-ascii?Q?BIS+cBaLs5KQl++tIBdH17FJrWemyF3zWiCvwqoTGXYJdg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E0A4DF86E575E42BF12FB7F231D3F0F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7839217b-5e4c-4b3f-486c-08d93c44a6fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 03:59:40.5118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9uhGRyCJDpDMDB67q6zY/RxQjMT1nBn+1aeuSablXCe4KZNNaFenwWuSewBaAKuRb0tECa/mG55drUpKxQeQD2n2GZl2nlcqW4dfaz0Bj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4392
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Jun 29, 2021 / 14:43, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> The first patch eliminates a deadlock when multiple tasks need to allocat=
e
> a system chunk. It reverts a previous fix for a problem that resulted in
> exhausting the system chunk array and result in a transaction abort when
> there are many tasks allocating chunks in parallel. Since there is not a
> simple and short fix for the deadlock that does not bring back the system
> array exhaustion problem, and the deadlock is relatively easy to trigger
> on zoned filesystem while the exhaustion problem is not so common, this
> first patch just revets that previous fix.
>=20
> The second patch reworks a bit of the chunk allocation code so that we
> don't hold onto reserved system space from phase 1 to phase 2 of chunk
> allocation, which is what leads to system chunk array exhaustion when
> there's a bunch of tasks doing chunks allocations in parallel (initially
> observed on PowerPC, with a 64K node size, when running the fallocate
> tests from stress-ng). The diff of this patch is quite big, but about
> half of it are just comments.

Thank you for the fix. Before applying this series, I had observed btrfs ha=
ngs
during xfstests on btrfs zoned. The hangs happened at 4 test cases: generic=
/013,
generic/113, generic/127 and generic/241. After applying the series, I repe=
ated
each of the 4 tests cases for 30 minutes, and did not observed the hang. Al=
so I
ran through my test set with the series, and no failure was observed. Looks=
 good
from testing point of view, then for the series,

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=

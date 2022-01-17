Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C29490348
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 08:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiAQH6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 02:58:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23046 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiAQH6u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 02:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642406330; x=1673942330;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=Ph0inKjLnDnKb/5TRnuns7RzwojeBNqDtp8lEeE8lnj506V3CBxUptSS
   /qPaoEbsmGbF+P2KiTLfYA00KBOiU6NB5TwQMfP4hWzjN9oZ37l2NNiMw
   DYLn6umO/Ow1/fRAUs8SoY9Q935SIqyR8Cw+0151sIJx9dLHCcSc7b7oW
   dCZ/XFXXfmriFcGmX7DNr35+b//xy/XFu8VLFmBpqTf6+cT+sHxYCjyDe
   1mtr2iZ9r9Vum0m14BGl/j2XaBP5JX3Ro6L2zIsRpkn++JzejBfdwO8m3
   w+j9DzH+oCFaWBS9X09pM6ZVb0raqrcHCiubbsTjkrY7UCSOBNh3xSj49
   g==;
X-IronPort-AV: E=Sophos;i="5.88,295,1635177600"; 
   d="scan'208";a="302498994"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2022 15:58:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i65Wyy8h8bBO5zv14xZ4qrX9pcdzZFacL8iED5HZR5CvhVFewugjIPLcjBgtwno2wjMIfNCfhcQ1bltCX7sGe+F4bIJSdWuTYJ7qw+k37z3st5Qub1+tQ8PAZxeuseogmZkGW3NeDc6YzUXbySZRDHKLkKAoTyCzjWrLDl3ICYMM7wnJmrMtrgTOLpGNRjDtRilAhu6BOgZPz7K/KyFHcKNqJQGndDEqbfXUcHLNyEHwFBl39KzF//NULwTUX35I8HwNKJWNRvfrOFwH/5CJsKCHaJwZXVYzE03LPmlWxk81ZKOAelNkcLeWu+t0HTw7cmdHzxueioZzw7kLv/gKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=GClK9wpGlzRSDm8EUe2bRSFpEpPo4KS+WJ0gX+btr/xzwz6fZvpjtg9UNfpBphc+Wf76oJULsMDuRDrCgcDPD3x2dHvfhZI6Zoh7srJFTLMpj3OE7Yh5eMzZn25vwzbAL07Z//3Ak71BPUuvH5KL0dk3Uaj+Y4u6EJ0Da2Liem4vt/uiYLk0T3W5IoZnbVt1W5FPKlE6FKw1bqQxyzXPzXCno+4DDbi4/anMrczPNFSINsysH8/WziJfjgRDl2teajlANq0xsmOrdeS6KLIBRyFAFuFMbvfMQtyaynFdwzmi0dKBi8nrXxIK7u+lpd73XVY9BWcbwxn1WL+ureXzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=G9/tdaPpQOL93LEGE0dpPPjUehl5eDnw1kMTbsIOgc7fmyI9j4cXnzOQ/6EGVFotUjV5beAEdXxSkJ5yJ9s90QG1o+LWwLL3LIejBIeOs9mS8XXHDvozSa2s7V8m0GIFMDm9Sp3TwGAN8PneXdRapy4Iaz2M/KZNWpBCW4FW2Oc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5805.namprd04.prod.outlook.com (2603:10b6:208:39::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 07:58:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 07:58:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: mark relocation as writing
Thread-Topic: [PATCH] btrfs: zoned: mark relocation as writing
Thread-Index: AQHYC3FUBtSrnJilLUGeirFvXsqm0Q==
Date:   Mon, 17 Jan 2022 07:58:47 +0000
Message-ID: <PH0PR04MB74163F0D8DA120DCFAF5A1E69B579@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <e935669f435882ba179812a955bcbb89d964db26.1642401849.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8360d624-5a4e-4471-5495-08d9d98f3147
x-ms-traffictypediagnostic: MN2PR04MB5805:EE_
x-microsoft-antispam-prvs: <MN2PR04MB58054A3096F7B5E0B7A020B99B579@MN2PR04MB5805.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWarNpTt1nag+/mTolvjZye4F3B5JKWNE1pNRX51mVGLMFXx2N3kv4Q+GvB4AHqBt6B1kOFPTxyRzm18+uU2kT5aYeFCadSpBUECsJ2A5j6YWv2XE1A2V+J18ZlBqBE5ngO/H4/3m4QcYFJ8wN/9E1AH+l8/8jCyL3i+eBxAcFYItK6tIqfshx0itlWGQdw4d1cO96rCQe40PKNnQN8huBqD2mkP4Yo9SE8cbh+Mrn3YV7wLyFaHA3YKI/rq6xZi4nEv52NkpPbrhVsWkuWzmGGRjQIM0oH/w2snjkmh5Z55O6EXfxB2U0zgvrHUXEwv+/WSH98/6OtT9q/vFTzz8UxyvGryRdoBMkMAn5GibyWsyKr6tvblRcyz8ISfx5aBFBfdZx1MU+jL0F0ibcY45OfyFslPK2mBEB45cnGrKAobep3leHbzrKCyQSk3BJXUdyOqyx2XFkCuKbMFO9PQpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(4270600006)(508600001)(91956017)(52536014)(76116006)(4326008)(38070700005)(82960400001)(66446008)(621065003)(2906002)(73894004)(9686003)(66946007)(86362001)(110136005)(316002)(55016003)(64756008)(66476007)(8676002)(66556008)(71200400001)(8936002)(38100700002)(33656002)(7696005)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ldVghHy39RrzJT/N+PRDoub/ls9hezLvEOzr14wvpbtKQykHbFSrS1f/6NOi?=
 =?us-ascii?Q?sq9lZV0WX4/j83+lMEMaRufJPeXBhY+OiRiCkcYjYxk9QwHrrq9Ej0HwW7tw?=
 =?us-ascii?Q?1pelkgrZ7FAF4Cr/d/5x+xVHSfAaN69YQ8zIo94/a/0rdeS3QkwaPv6D5ID+?=
 =?us-ascii?Q?XGaZHOx14ncoZns0x4dwcAuRR7A6seSDOeHPzzPrOEaeWtdHE6TcGP5qKOil?=
 =?us-ascii?Q?cy5nJiPospgmXPSNEXOil3Z68UMEHBevrax+Xv/1NLSvFNA3GVth7EbiAvUa?=
 =?us-ascii?Q?94ge6KgfPeLsAX9sibblep7Jxx5LZRqg0FN7CdwgYH2bPkjIS4xMUbuCBK86?=
 =?us-ascii?Q?plI7SB+3RK/x6qI1k00jyQL/AX/u3Z0QzQ3T5MCuC9BA3+kWnc9x97KGFDaG?=
 =?us-ascii?Q?8BD/m+9JeED1FB/t8dKhI0qEvlRj6ycHC3/QvtI3cluKFvOun1OXLDvn7h2p?=
 =?us-ascii?Q?pJ4MdlEN0UWFcbcMmII3A9mn4EWbp27/g9axC+Ow9YOIYV124bWg99V9wL/+?=
 =?us-ascii?Q?I0/sh5V7JVEb2J4lQzFsWKgqnzyLwnp2kyqBzmAJMRz/2T0u8x98qOaCNIwu?=
 =?us-ascii?Q?5+7hp3gnGy2Xsjeb9C8/PAJv9r2Hw0lFqiM4n1nIr9e5kl5scmj264wHnUvn?=
 =?us-ascii?Q?k9IosOQVDuANITtPpvVqxPtJamCH8xsxHq/UdUTqQWz1DvuNm7Ox/dicV1lm?=
 =?us-ascii?Q?+RVqxXlL69rRSjJkhAgdeto+4DCVQjEwpf8+M9nTH7MeVqvt0sKGAkKRO0JH?=
 =?us-ascii?Q?PJXSR9V6Wql+0tAPDngkVADGzOVeLhX/CR6vLmCPy9QSJxGetDRPDOJ5jxDy?=
 =?us-ascii?Q?fwX+bbCCb4uXyDaFNlMVPiVUuVjtk8sg2Wj1DB+33pucxnjPeAlKizNYf75d?=
 =?us-ascii?Q?mRH53S04Vk1fKd1MMJjAzCJ4wzv/Pv2iUVkiRYp74jw+SeJPo1U7HIcMtCrI?=
 =?us-ascii?Q?yQhWaIA+YBU2Qcpfsa/fgZwp4Sp0sGRWUrYUn1RsrtPtIMNK5MSyT6XQmri7?=
 =?us-ascii?Q?QsamAeR8hjI+eI/GJHLCQHeKOhaXzJTebczurO1XPmDOZMtx7S9y2RSPOkFl?=
 =?us-ascii?Q?Z5s2KxQz0tt9UVrJplHL8VTNWhkMr9FmiqxOPTKnHlqNNSlo5h96wBH+Tqcf?=
 =?us-ascii?Q?vm3796EGisziV82/mD4vgSHyB5/fLuEGsdgxAM+cXq9RHfjKM3j0SgJl4xoa?=
 =?us-ascii?Q?EaISlrHaEjdek4PGN806y4LZFFVY0r3oagDGU8VpG85mz2kyrrfnrRqpdJWD?=
 =?us-ascii?Q?XlYqPssAFyC4UcvqMOHSJWhlxj26TWuKxLdBYORXfYrNZObT6uG5Hb654RBU?=
 =?us-ascii?Q?+AidRe/x3foZ4LaK3HXDu9MJ5MCBROrN6Sy3ldx528fxWketPFeSJmbvnhkw?=
 =?us-ascii?Q?yY0caeRUlMswdLVRUCLW2hI+8LF29auUVDsoat7BxJRjbT1DreRfss1PAjs8?=
 =?us-ascii?Q?mwYjmC6kowW3D7fBb6g9kJxL6JLu7NEeP+c9F4x4GwqZCGbBPoQ+DYzL3JLX?=
 =?us-ascii?Q?OoquF8IVRDEXT/ff6wXeORiaDd+ZGMPB9eNUIMnIcfn1NTV0OIL1KODt84D2?=
 =?us-ascii?Q?JBcNuaFKllXhEN0kVtewa7Lw63X1Nh5/cFcsj240B03QBTgsjHH/zCPRSQdy?=
 =?us-ascii?Q?zY0f28nhO/DDmJYEHVwovr7VTzo+0e3mgTVtXhXzL0sfxBohb4l2Xo2Fa5Db?=
 =?us-ascii?Q?bquNxCStAuwxabjrAuIlQZveMbiJ0uRe6DKZBaKcQarUcSAadFs78qQW7J5o?=
 =?us-ascii?Q?XWLwGHb0liuFSU7DFR0Yw93aOvnonrA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8360d624-5a4e-4471-5495-08d9d98f3147
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 07:58:47.3527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fRst4CbLIysEs2YSEzsKEIJ4A4IJlv1nqsiCJWhhhRmJFIUli93ikNfQfpgItNQX94dN4WmB9bCE2lKEVZ20fZhiU2Vm6heR8Jj/7x4JjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5805
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



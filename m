Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37333F59E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 10:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhHXIiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 04:38:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6125 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbhHXIiV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 04:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629794257; x=1661330257;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=jl4Yqu+F0xwbsUq0NIp+o4b6zBd2JNnjRjqv7gU20s+Orv5ImSCIpLyD
   Om5vuQk8wVj2M14XXdCtdscrsgnwTaBDjyLo5HO4KcwNvZTopV0hal2g0
   KTCysYz2BgW275C+T0V63goApAfcrN3xDtX5KOqmPM5rQ8ZdCBBzw1/KC
   ezB0dmkMzoL6RI/3G5Kmc/muWDYUZE5BoU3kGOQsWSGzF+Pvyy/71z9YH
   Yj8Er03eiNPstibpwUuLxJWm/M+TRO4S0OX5GN6eAAqj5fFhFhs4zef98
   oUuQ4filUVyeTXZKlmlgngvxfXgVXo4wX+9SgilA7VnVkBjSeL8dLPtkE
   g==;
X-IronPort-AV: E=Sophos;i="5.84,346,1620662400"; 
   d="scan'208";a="282001878"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2021 16:37:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDBpZVrinLjlkG2SpOF2J/pFIeDjrkiQ/ozpCR9htfamiCwKbeUGmlb/eDxpjWA3fFAO4bq2RfETw+eyMD8IW5hZMDOEtOduTgvYP3DsyicvXj4o4RQ+3blIbP+GXHhEjYFDOHOJu0XAm+ycSvXNi3LTAFDxsJENMFgPKBQHlI/dw7cqZ+MzcaEZ2iyFsAdNt4WvSpCn80tgGTzQvM/K3zOeukU+4a6Bpwoo/VbvnURSon5kHxF6PIps+uzIouegQuupHreASlGzeaK/Yu87P9hx7zJpn9rCUlfXQEXvpg+M3+mhqYC9DTriBBpBLBA9zhatErgDUZSEoaBfIvP3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LKt9s5/ZaIceIWWYPiJ1BsxineJz9A4V5tL5ttRHFJfkLkIVN4nrxZ+ldbrTMRhAinC5JY5zBUJox+RkTAY+ssy77dffMCGRJE6uTxFMwYPj44Ye6aJLR/a28mYJirnWsTr0dSSyllUEq70A39KV3tYix3Js08JoTP7MMiWMCvHDEz1eRXzSsM+2a9PXyUISrSTBrO+OHWSOXoVSdxryhfr5PY6L+idYwLE4wekfxEwmSfVdI/cKm563MPv+oNhoW8qfRYDYVSEeC4U6ZDoW6wd8sPdFfivVHUP9GKc4J4vI6RxLI6tVtkhq8f8OtkcDHDqeFvInajssx4j01zkX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lPc5MDdPXtVR0iYoR5LrOHCkpnyd/MFOxJbSFauy/p6vUqIv8ce6B7yPGRQqy9U0K+D8m8f8GIEom6x4jZm52tYoq970PDKdIg/EklmoCaBh4UrbhVmiq4PchqQtk9myg5oMv0yKY1h0vqnrCQqLxTl0cmVUj1T20t22YU/jxDk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7544.namprd04.prod.outlook.com (2603:10b6:510:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 08:37:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%6]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 08:37:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 05/17] btrfs: zoned: consider zone as full when no more
 SB can be written
Thread-Topic: [PATCH v2 05/17] btrfs: zoned: consider zone as full when no
 more SB can be written
Thread-Index: AQHXlPWPvfhNUGHCQESUdPADGX2axA==
Date:   Tue, 24 Aug 2021 08:37:34 +0000
Message-ID: <PH0PR04MB74166E1291959B467EA163E49BC59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
 <7b3768a49229cf41cd86c654d58863cbdaec783e.1629349224.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04d76863-a743-46ec-de13-08d966da6ba6
x-ms-traffictypediagnostic: PH0PR04MB7544:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7544E10B5EE0094F9C6C2A6C9BC59@PH0PR04MB7544.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /DwjNsPrZBjbydcc73mo8q4Poa31IHgCjUy+v37HrSkA2DpPNZ+WsVKjE2fPYv5ByLYVkDfx+R3QULP3Yn14RKEd/RioyYBlZ3HNekIcGiywBMNS9EkisiTa16cQINCWv7vJqndp2ATTKlahJPhZar44iLputcVXnBkge3vqPDQ6kgRnQic4wXzYj4oHAisSYmBJTEWm/+ucM6ui4T3odFFruAbA0hL28WoigU54Ju1MipftE7C8x7jKbRAKN8LfPNvhayJRUR5PYi/0K0NClhERc7MevGMgmjw/9zPokoBeClW07d59rHjavuDzISx8/t44+DQ33FcRsKxgkooIMySCl4048GVShvETteIS/5X1ao5UfQsyIZIw7s4st1IMFfH2CG6k6GwFzOT2zlPNlwtlBD4Fnc25E0/S7I4z2qdg5KhTcXGERANI9MQ4LRNTBPGtNXFCQF9C9OiDW8UWhBrenG8e3Sxb2Sapm0RFgtmwQl4pUGSKmcLPiJD4QLljZdu7lSjq/Hm44KbRRJSnlCkRlRy/4fHEVtMWqBzBH9UkewACNQQcRUmlqVnscJIYPx9hSt0GLsQaQiyy6en0ngxiba+Z/MiVdJ5/RsezWg9c7qJR4vO+0Ton9yCpA2ecc/MyexZMDN/26avwLVbpMllZ9mHGyAwnGJQuUxKCSYgU3oZG9U84RLCVTkV2l7mYm3weyHMbqLvnmTg2cpuOfblPMiH3Jz+8fQpe+xfnAe4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(4326008)(2906002)(558084003)(8676002)(52536014)(66476007)(38070700005)(5660300002)(55016002)(4270600006)(110136005)(19618925003)(8936002)(6506007)(122000001)(9686003)(7696005)(38100700002)(66556008)(86362001)(76116006)(186003)(478600001)(71200400001)(33656002)(66446008)(64756008)(66946007)(316002)(29513003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zuQ4Fgf6a0nmPWqZK518QeeMJJ6fwMJDeqztnV0thocHxiZkNL2o6soIVQGD?=
 =?us-ascii?Q?hglBWM4GRRa3LaR0x3GuXdEXQHI7TrYT1TR9d7DcRJi0BuBQgLXY23dhLJpF?=
 =?us-ascii?Q?t7Wimk1awGSeJD3b/SX4MgwFgKzfGgyqDqzLCVezs46B3b/A9/JX7hGjIEQl?=
 =?us-ascii?Q?nA+hU8gPc6MlcJj+lUN5g6XQL5mNLzwoFLMZvcNTKeTjwtUQ3qI+bWCpEkeQ?=
 =?us-ascii?Q?xP+f+3uNaQeQzqpLUqxWr5FOzsBoHmNy3exVxJrYHWgfo02TgGRPZXloAqdo?=
 =?us-ascii?Q?ZwYwY29IuphAeg4vL1NLKvu0qAL1QEBWUvxCZeOSv/FAtfPqWsqY15Qm77o1?=
 =?us-ascii?Q?wqkH4K7loyWEs290iLhPzd9EWufLCXPr+hWPzT5rhbNvlxrZXpcI8Q5PV9NB?=
 =?us-ascii?Q?cWaHLRu1EZq/og5IHekVJsQwPPkbUqZgIAkpIQqwtrgJ/u2elN9utX6BJP18?=
 =?us-ascii?Q?SXii+joF+l8Kw0Qjalbwx+wBTLBMkD37jRvzvkkEwEjtUieGOWIPGk2xjg6J?=
 =?us-ascii?Q?j0ng6yK4eX4edtVEyLc+Psrs8FY4URCc39nODEeiv7DsmipR7wa27/0kLGCF?=
 =?us-ascii?Q?bcwDSs8q+NBojiM3q0WG3xgBBQ7JR/+szvD1PZhEm1wkC7pqxvnKew1XA/3o?=
 =?us-ascii?Q?ZZDXCy0ygPwFAeJ75cBgcSHBcCNbEuqHKGihr4150avx353n5bvUnXZC4UJg?=
 =?us-ascii?Q?wcN8/lqliq03KPpkJlp59LuXy7q5E5C3/NHeBHtXAxvnbZOfUuFAAVmFcqcM?=
 =?us-ascii?Q?bCKCc6ArevdHoYECZNwn9aazTIw/kx6oobcUTWF6Hs6yiEx3eacJunB1QzJH?=
 =?us-ascii?Q?GoIbNp9ePJUjl5ccdpPt1757DC+3VMK/+sbpr7nKBFMKspYA3FAvqftIdPCs?=
 =?us-ascii?Q?obnkDe5M/EiOsVZLQENNXfsDYzGYYSxJ3BbF7JLlhFGw0rFicwtq/ByUsy8D?=
 =?us-ascii?Q?wBwb+QysAkkyZJ87to8CIMuROt0+4nbrfEDdaNzhITqg4RksbX6RJPh9MuNB?=
 =?us-ascii?Q?zMYbJQhqLtj3Qyo/AUvwZIr2fGIwDni8mqwBEFmI2pghIZwZ8r2AedLK1XU1?=
 =?us-ascii?Q?7GT+yMB1ze+nnXsLEdzaNHoli8eY6SuAeDZ6ZiLKB4X8hPcnrMJpMWgXFjeV?=
 =?us-ascii?Q?OXJNfWN/Rm+PRUSNfB5KIrpGQTnixguccUn31NBzCe+aOBM+LTU9V6rF6WFC?=
 =?us-ascii?Q?EVCNWRfWQALrdIwIGu04QPzYg+XK2de7zsJlH5TmKpV+iIRviZddlg5i4lKb?=
 =?us-ascii?Q?6OyoY2pLFNC5j32mzmUerK5LND3dBhGlxtaQH42TF8WbrwyMAIXydOScoa4S?=
 =?us-ascii?Q?70+jxMdHIHLE5f+if7JlTkjHur+kcRxHMwBrq0rFZxpnmUBAV6p09MbU+ErE?=
 =?us-ascii?Q?RgLKvgjJZnMhnfqVlJ6L6ljhq8bkA72duEtgod4IeJKaPVy7KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d76863-a743-46ec-de13-08d966da6ba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 08:37:34.3203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdymflxZ3m+jRO+4YjROy7Y3NHDO5qtda3A1+zL1zuBZ5GBblz0+E5PkRdrIOiavgvmvW4m+ShZy+6bEvTmAximDqTkhabIi2UDPnFkuqQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7544
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

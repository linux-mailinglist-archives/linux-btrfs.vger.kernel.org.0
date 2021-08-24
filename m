Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693893F5969
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhHXHwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 03:52:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64999 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhHXHww (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 03:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629791528; x=1661327528;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RTmbCYRSMmmU4dnRAb7l59s7fjZNzc1tYTFtWNz2+AM=;
  b=BpGJ+YK/ALOwSFxmNvn7opDu7M3Tzaqfnz/72M47YvUPMQmIhV8BKnY3
   9MEbXpJ+khvf0N0WQfw/3O+wFgjplXxIVKJx6Xwr3AIpJ/pPXOtQpPz8v
   FjIERiQhStqEmb/gT+nTzb7Fig6zoC6JE4/sGvl9DWE1REvQxzXHBx/Fh
   m3I6oH+YAaxXuzZpVillWX75q04AYiBho0lC2Ml2BXjydCN6OfN4qLQ0E
   1sdhD70mO59j51c+o0wg75o++6Y8yoar1xpCZXV5hAmLE0EG6XpNxnj/L
   Kkoccbcvut6DfIsW7vnqtsBZwFcZN0mf47fOzw90FzghnIkBT1NnCdYkz
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,346,1620662400"; 
   d="scan'208";a="182983317"
Received: from mail-dm3nam07lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2021 15:52:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PinwriIO1YHixwpvTjliz3Cs90QPtyPxiHGeXm3TzyP8nN0SJT/5pz0kJQWGRPWhfWyJrszghHr3BJi2X/vQCSCFCRLWZCqXIBUJKc48iV+LgSRZRyisxVdWDa782UlQfo33ca5Cwp5HkUiXH6pkBhfCpTomwrLFcJCL5i7xx9opJpA0JLYTd0elK9RHJjWXXfGxqkzCDZpIW25fgBVSJtvJAaxL054sPsSfCdYA1pmBFzy3sncfv+poEj7E59OUFT4ZjBQ4MGYv7b4UT8dutaSnrvgPPG5vOYPv6ZVmkaHNbsEpXdntN66Y1vn81zlnHZQRkv0HMEcSCob0/CBk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bjaXLPr1ooo8xHiOejrV73EgUAF6EUmUHnvXkarTA4=;
 b=NPkvBcWRLytmcJv+Xeo8xJmgAvISIOOO0YfiEPvHsS4FlY4A2BYdGZDHY0N41Adn9GqJgOEEtFK5Q5BHk/eigcRq9f2txxUU0S1PTWzpr+ohdipScJKMdeBcBsfXRvGdruqfuow+kOP3LhbE5B1i5Zd60Qs8fk7fzVzZOo3cLRFG+fZANi9v7Vb9UvqCR/5ahWW/Y7XW2eAClIXrQiqdl2OgbdwJKaIr8PYSV063ydBeJdaq7q134tlZ4ni/5f0M4jjH+3o95b4EAsjqk2kZPM8jqXJkju7kOlyZ6pMf7ZLWKlxbJ92UYjSp3f/of0gZOn6JHtVCz4RVCDySq17ImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bjaXLPr1ooo8xHiOejrV73EgUAF6EUmUHnvXkarTA4=;
 b=oxQU2mqBWU///oE5xBERIU+NITR1CUH+dBkebcxjN8JkntA1uG6XmJfgGBv4P6sefc7d65lPkP61r74CHYxI4CswdGfSpytFYzsEYmYOzoVy+cUQfiL76JvmOApYyiv63+CflTsNMwueg8h0UCvgVMBM1KsGgOo0C3gvK4hUSzE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7255.namprd04.prod.outlook.com (2603:10b6:510:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 07:52:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%6]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 07:52:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 01/17] btrfs: zoned: load zone capacity information
 from devices
Thread-Topic: [PATCH v2 01/17] btrfs: zoned: load zone capacity information
 from devices
Thread-Index: AQHXlPWL22aAwNIKp0+mxHQmhu13LA==
Date:   Tue, 24 Aug 2021 07:52:07 +0000
Message-ID: <PH0PR04MB7416F32152931E2E2ECE52BA9BC59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
 <e9838065577ce7c6f030ec3254bd001355ae0bb1.1629349224.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f18370-6d64-4308-66a0-08d966d41240
x-ms-traffictypediagnostic: PH0PR04MB7255:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB725573413366AE22412203FD9BC59@PH0PR04MB7255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKMv0fhfiwFEP5dfzwJkUryyWHeklkh/z9pKmg0wi3v0vFvn/fatUsOzsNZzhQ0EhfTRwoJVvpgmcdXzgLb0irNqE5zjuUtQjYy1kkPlm7FBXV5bjZLvT4NkjXbHuFSQxWflAs2HvQY5CwTucFPg9WPTCroZ1m0sBjzErfe/n+HWboxKB3bqAsDr3WSDDTlTW7Njj3H9iiSkmyhP8qKJIoI0I6tGSH7n77/q3zcsjB5dPvhKGHi7YsfFZsLsfH2wTV1aFiostM1O+H/XkBTPyj28t1NV0IwtHdi80hLDcbD3faKx4saAkQPH2STGKjzwEXJFgEAmmyBeMH7Wq57Y1J/tFIUHgxukFJnsAQY6l6j6ngDkMrad9nrrvXD39FB6/4G1NCFgkstfOb5hqsdxytCYxoII/SuLGbMF8lB3hm14LPedsqiJmhytubCrmZonPBAtQFTkXn0ODVcQ3QmXQE2ELHHaElEixTrjCh3cymgtdnjXXBjfhIDIHc7+2hxXHpxGH4LYCmSmlZUmoeffy/ave0jh/zSoJFpvE9x3YaUAMFAtHIQHE2ClP3bQgzPyey+Txw3755rD0WYXeh50KlLPJLOB8EqkvvNtp38BW5E/MA1sUcNC82p0d09n+7Hi1BzKVxrfTdLoF0ZRguFEFC8FX+7IlxIdj3simrINovEP8bAtk5GWoZmxkQ4lU8J5G4M+xSm3Oh6IJ9L4H+Z0WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(53546011)(6506007)(7696005)(4326008)(8936002)(4744005)(8676002)(316002)(86362001)(71200400001)(2906002)(33656002)(55016002)(122000001)(186003)(76116006)(38070700005)(83380400001)(9686003)(52536014)(5660300002)(66556008)(64756008)(66446008)(66946007)(38100700002)(66476007)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XJt7+BIIyP7giFJc/rBwa3WPenSGXiixhUHFHVi3uenFKWGFRf03Lq6D9OMG?=
 =?us-ascii?Q?bbucL+z2tWYlZl4jkEdqStHRVpNpVj1RDnu9GRYcqHihrduVPvhz1dnSuosd?=
 =?us-ascii?Q?M0y+a30RNpI2E1882Lc4SY2FFwZ2bjb+jRt6ixuwDzjlYjupKjBd2PATi0Vr?=
 =?us-ascii?Q?gI5j5Gvl12l6/fJ+DE4GsVDkVZTVmvkCfTzkuqO2dl0DmkjZ7DWWdKwh0izM?=
 =?us-ascii?Q?f5ALPbhHpR3JrxyzRCtz5SlU0zyFX+TsuU5AfmN/qePxbDeZYkwxh5CsyXB5?=
 =?us-ascii?Q?GnEciuAF9IP/vwcW4hz8yNsT60PKnAPuD+vFVmsyDx7vKatatKZ/pE8GneNf?=
 =?us-ascii?Q?CEhcl+/u8yXkMYDwEdLOk4f8fHjO4WXir60m6U5zNg8OImAJ/xnjcSeFVtPq?=
 =?us-ascii?Q?JNusTC8K+pI9LFgDh2ue+FgOXOP6GWgMb/yNf2OsKvF8yqnMHNCDSLwNg6ry?=
 =?us-ascii?Q?bm4pG/ZgTx+51/t8xrurFjsKtCD+oQJg5qs967xPqKccopetG8a1Py76XbBh?=
 =?us-ascii?Q?V2U3nUt/t5A9fd/jzNBg/wn07GlA/NxdOvysct7O72OsEUs0V0GbvMXCN8bj?=
 =?us-ascii?Q?fH74QI747Zqdp6Paee8knf9H7luYM0+RwdD0fBProPj7Fd0yG16ir16SiBmB?=
 =?us-ascii?Q?QPy51r8lRIs6C9g8V3ClsRrFJLBOnxww0mQ96u6MhfbA7SRxGaW0tdKbKqsj?=
 =?us-ascii?Q?4RgaJGW1erThoGLF44El1Nk7XZHd0cxesbaGevtcX5wjEfcQxaaVYBWP1YDT?=
 =?us-ascii?Q?98z87rzeXH73SDGqubhrKSfAqwTd2FaoIIj4UmG+OfphvEZ39649b182jG4p?=
 =?us-ascii?Q?rMqvdi4mBQm72zGtZkQpTWnRZWtIwRCnF2keWOFXkLHMF+ThRYc/5Kxz1HAG?=
 =?us-ascii?Q?jO7UUbmeKZVj7AR66ZZwnh87gSYG6Oepi4m48iamWu0z/5wKzijgEc1grE3I?=
 =?us-ascii?Q?dlInGbyDRAdiBWNNefKxnIBHCjxoEmPiWL6t5c1DXvgOBxd7k0Q3Q3dCax8z?=
 =?us-ascii?Q?fNf8ti9JxF2kchi1nzFDNlyUqsaoMYXqiCjzbQsI6wNzL5mRtSRIH1UjvZXA?=
 =?us-ascii?Q?237QmvU/tPwP9BNj8VsT4R4zfa62VTy+z8YMt0W1y+LjWOLGCDPfgLVgM6fm?=
 =?us-ascii?Q?sOkHKut+VXLCVunmw7/XqNCedsi8+t3YC6vvR5GCQKbhIaToM8I0CTPK0oG5?=
 =?us-ascii?Q?3andyG3sGBAlPCnBUvQeRw9FCExAa2mE3HA151qvn9LA0R+i9TqDi8NZ1wBv?=
 =?us-ascii?Q?fU0YoRzv1g+Q13pgo4w/d+uPEgUjw0qZbfRv31SUuPiawrJH4uxJ/E1CtDY5?=
 =?us-ascii?Q?wty6OtzgjCfg9POhX7oIWMb4MJww8WoFynQhwaVy9JdGkIB7rWhtaE5raOth?=
 =?us-ascii?Q?RLHpUqhhbs77C1ecwH/MqHDmNHKGYSdZaLS3/mYdMLI/GgddrQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f18370-6d64-4308-66a0-08d966d41240
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 07:52:07.3402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evK2qFv5vopzhNAP4/4ykw7P4aV7FERL9eLFB+oNOTQSfNG6XaC4BFuYI/CI6gaHqnhun6lir7wUi5wYACXcAvdaHHGXiAq8pxCES4b04AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7255
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/08/2021 14:27, Naohiro Aota wrote:=0A=
> The ZNS specification introduces the concept of a Zone Capacity.  A zone=
=0A=
> capacity is an additional per-zone attribute that indicates the number of=
=0A=
> usable logical blocks within each zone, starting from the first logical=
=0A=
> block of each zone. It is always smaller or equal to the zone size.=0A=
> =0A=
> With the SINGLE profile, we can set a block group's "capacity" as the sam=
e=0A=
> as the underlying zone's Zone Capacity. We will limit the allocation not=
=0A=
> to exceed in a following commit.=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

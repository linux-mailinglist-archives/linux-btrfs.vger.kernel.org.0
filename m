Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4A3F7122
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 10:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhHYIdP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 04:33:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12228 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhHYIdO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 04:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629880349; x=1661416349;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=crqPboxoFJ3obZJccWOhKYwFUIWZfOcN6DzKLbyJlV/g35pM1GRvmH+V
   tNBAh2uTMNXkjfgvDbkqKg3fxwXBtgHdf8/5mq2zVlq4weUegZxq+LlFJ
   a6v12jpc7gRAI72NIHByiSXdrL348cGy9FKrdfp4VgDSZNtN9ZW0Kskj2
   d5rA3BtuYrwReAM53ZulEdq+yiRXtCgueapYBqOadJFpe1vAIgXRucVrV
   CW3+sVfYnihV93GbxyjsGB/pCxnh156m/D0uMWTVtz2npud6RbSXDp4eW
   baPgniSJpQNhviINL7/VfSZp/eee8Le/a2NdlGdKk4xaypYSxlN8DYjSL
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,350,1620662400"; 
   d="scan'208";a="178888683"
Received: from mail-mw2nam08lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2021 16:32:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVQGkBV2r+0+QxdYBC8Xbq0lbifVxSQ5Kd7zWTnojjmcg8r+0XZrVj8n7WsNT6yBRASqdh2xe3BJivLjmLXBWszAuyYhdGUaB2X1Jd/Baako/2k/B5yjkskjZ/e3j53OSrm/SUQO+2EIKtC0d0Qg6PEVuNf2FUskLvrXi19yP8dCDXW3AQdxj456lpCP7C+0LvGIvZaXDHHsInRYKNeaa/bHVYya9h8CvY5CqUEinVimmRDFbB4e9So+u3Zx3CdQZroUtwOhCRDaq06KPhJMRYTqIjZB+o+Dm1QLjj4cjqQCd8PMen6ShsQt7I9MmNF0ZXvdgRJ0y7GqKi852WKM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NCgc2t40p2YlfpRK2N4xNsDUZBcqySOQRJM5jhhKPA9Hxdhfk/8qE09z6c5T7yl5DrpAYYnJ0eyFW3lE9kK9dL3TDKkqOCl+IA1xIImDoHQwLSOSHZzNeZHXotV60FF7RnJpvDLNm2P5kj3OSdmLgqisjRWjmZrnFfKBb782hSXNZAaHMkhkrvpArrGG4x4Rmv5ZpyIVEMpLelu+SLIczU4h/7k9Ld+Ke+t0GK/Ijd/BGD0dKBxkEy0F3JjkJt16jDLCyIktVJq9BBQHsXqvPQ4nKYChPpAxvmFANNSZEAUuJnF0Z7mP3jx7ZOoWW3rzYAHcyQivs/C1ipBFKioz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QRsVQl90+mPAfNzzh4HMJOz6jarR4uBGSWwyhQH1CJmOVPi4SLdRaP6GfqHiF2LHxoNPS/1JA4/5MsjmV5pLKjaarqBMbbZCrqJWgewnxrQGYI2QwvFfdoukDZd7ELKg9wIrKDfdR+VVTO4ucGcoFPIDwNlVdYhe78UmYKCkJV0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7319.namprd04.prod.outlook.com (2603:10b6:510:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 08:32:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%6]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 08:32:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 06/17] btrfs: zoned: locate superblock position using
 zone capacity
Thread-Topic: [PATCH v2 06/17] btrfs: zoned: locate superblock position using
 zone capacity
Thread-Index: AQHXlPWOOi2/ajnzcECT+Ti8y4+LhA==
Date:   Wed, 25 Aug 2021 08:32:26 +0000
Message-ID: <PH0PR04MB74169273E819F225FCE789499BC69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
 <98720a3c02feebaaa8810ad3dbfde1717bd1acfa.1629349224.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae9c41dd-5052-4e99-3749-08d967a2dea5
x-ms-traffictypediagnostic: PH0PR04MB7319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB731902FF848B350A7EE083D99BC69@PH0PR04MB7319.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqgtbMD9D51cs0m3HKYC2wIYqve8m3YA0IrBXadDJb7xehSKUxdw4Z1oneFVmYWEfrZjsW5v5F1NVSGWcn3tWG4wd/DXk2BqXmIIkuOURrZPEzy3JBeayCY6IKqLI8La7c0hz9GrAEXojssyI0Rx2DnC3JT0soyeoUR5l1xaugBIOULMFMEYgPVrQ7UJppioOhg+37P6twcH5aRHhWls1domOk9ZWSw/65pUCNrwBTGUeljQFwPc4/acESnW+wr4tuL+jvU3hfPGW0FDtmDLDD1pF8pgCJTaf/CCwvkLz0lVy2EEiLkWpH4uqPwuKY2m9Rr4WgxQAy9YOCSKhf3b71Q27JuwdLszsxcHgsl2oJ4dzLjeMMEkwp8g7yuPy7LvSZs5XMzdXNkExQfCwC3mbtzZ7cKtmCAHLzYw3wVIKYUfCVWMwAe4Lr/VHMz9qBy5jRd1ErlqpUxmA3tEgIRMaqlSJe6INf7feXQdZW7lDlsrW+pLW29BgHYJC88Ntm5RG/SnU79Do+CXZvOyVCMWEcuA7e4ftzEbwqMKhF0v63niy5GtmOaIZ9jNjknDiR6/QrtwrohJneKh1s9v4fAcFexz4KCJPsh2AhkEbUBmOuX2Q+yAn6wFYOGh4GahTB1i9zZQ9/RnT+r7d+Q2Fm1dZesARz227rUg8ze9TABHIdfi2EmWeL1mrWpxZIUw0D6LqU0vn04/BK7sti3eXgZrwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(6506007)(66556008)(86362001)(66476007)(66446008)(76116006)(4270600006)(8676002)(66946007)(64756008)(5660300002)(19618925003)(7696005)(122000001)(4326008)(52536014)(2906002)(316002)(55016002)(9686003)(38100700002)(38070700005)(8936002)(33656002)(186003)(71200400001)(110136005)(558084003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S/EXK8dcg8pLXqIfAjAwPErU/hHmvpGZnxLLzkf1EUyUckksPlb52u0w1RZc?=
 =?us-ascii?Q?QHhOQS+sm3unjLylMzyujhfeGcoZoM73gXlkGlsB615P6QwsGtYGzde2IyTn?=
 =?us-ascii?Q?dmdrCWCPUsgZD+9PWiLRBCgyMJxKXsdL+qt19HbrMNvC5Nh9tvF0K7tWr0sZ?=
 =?us-ascii?Q?oOGGm52QhQ4RMCkBph/GwPncWaY65vKsB63qgDBuuHoaUJ4lrGQS8HFWF9Tr?=
 =?us-ascii?Q?pX0NA9xXkC8iftDL783NSVQ2/FTanrz93Y+6VBWbhQj0CKVyN9x+2VsZB76Z?=
 =?us-ascii?Q?1yv2smxdSJmJAlgb9i/ZtCqBBYf647cHGQc9hNxktI+O1BUO0ROnjjlDMD6I?=
 =?us-ascii?Q?GRgJnUG2ZrNvml4xTKTkanuH1fbpeFvMpdc3MaXM7lDERrvfVz5Wxs0VkNBR?=
 =?us-ascii?Q?d57HG5EiKBURMsfe5+NRucUtZ2NgIaMWdYXZhcBjUGvWDacZFcvjpxZMuvv0?=
 =?us-ascii?Q?anwIyEVfhzJoqacZyqhklLyEpRCwMID+yeSFnPAhNONyHsZpRZIqtGT2EONw?=
 =?us-ascii?Q?8bjyT+nfaFaRP+FVO5D1A0fFNM5Y4ibvZ43K6brIgUSQGsiIc8HzceqwQBdM?=
 =?us-ascii?Q?tq9PJ12QpxBHN5byhnkVDn7B2qD0ZBAj+PiGXiGM0V6G34sLqCuiwhUB2aTE?=
 =?us-ascii?Q?g7/5ydHEQspz8FIuO6ZgVoDqtgnujEX9XGCd9s/TXyn46ZND/l7rl8boNiYS?=
 =?us-ascii?Q?DuiU67rACtQLI6IxqQt6z6UEm+pOABYAy240RlDaXvBeZEY5cCAWFhNF36rK?=
 =?us-ascii?Q?GF0UICs+qID3pli7pw8XcpMyOKjRytzab7UnO/RnhS6NpIHKoA2GuQ/KcEwS?=
 =?us-ascii?Q?KK1SfLKJgi/ZJVMKuvteZ0orV6wX1HyMK52Xf0sSP8rPzK9cNioBEJZ8+sVU?=
 =?us-ascii?Q?XKK1mE4bjqSsQnYRzPcNFrsbiErWFbOonG0Py994qO8c5Hi5vfXrnC1ToVj0?=
 =?us-ascii?Q?I7X13JreKyb3tZSCwaWDcDmDDMemkEQ08+82UiKbeo/QNctUQCm3uWB6AFYc?=
 =?us-ascii?Q?4iP94WMe/ZaYWoi2yo26xD6yEr/1JcVqKJysPlI2wFbFEw5bOTWJGJ4F2Flg?=
 =?us-ascii?Q?uWsun3xjX9WIZM3UCBXWXyxjlqMlGouHLoPjjCNoqdmBhjWAmkSmoM1Mluph?=
 =?us-ascii?Q?UMNkSWaaGmpDYc/8Hd193xIWCu+JrYpFNRPcIcHhXhRRbelMK/Jb1a6HLgDp?=
 =?us-ascii?Q?ZZxjtGNZsRdnrU+YeZfzl7jwhVfUA5WRqbSBVDeT+hYsHgl4/8vRmnTkLQFA?=
 =?us-ascii?Q?h9diCjeaBPmDEUyoNr5NEUmTQqivnf1n+NQ1lh00sJTW78xWmbUNT3HNK2Ii?=
 =?us-ascii?Q?bolaXB2vHZNi1CGKug0eyscq7EDAAqI4irZwf9X2atZQgYyutwFS9xI+lixO?=
 =?us-ascii?Q?/llVkwjrkiicLUvQbzSuEQi/h9FFkoFyt9iazq5R0y3kKP1CLA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9c41dd-5052-4e99-3749-08d967a2dea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 08:32:26.5596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpnhk0LTNEJlFAfSNKLHf8njrC80iAsibSBKgJtE+eoj6OTydFBvlbJo0q4/NjDyv1Y5Tqz61ZtRJag/KqUKzrRjKSmuP41ExB9IulrvuLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7319
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

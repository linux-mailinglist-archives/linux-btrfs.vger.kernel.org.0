Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3749060C
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 11:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiAQKgM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 05:36:12 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41140 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiAQKgK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 05:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642415769; x=1673951769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TRCdbkftK440JDtQUWWOUz/fwUqbHBJFJOHbgRf3WE4=;
  b=Tqdk0jX/o58B7/OW2ZpVe5uPRABsixhANFk5l5xET6/K+VezSM2XUN25
   laj8bQ1UZwutfhCxPAu4+Arnd2O7JQdY1aPtWy9IjRAKtLuGIdaHXeL7l
   loOgHUFKnRlQcvbEtyO2kSI2KvgxOHV5ohWJcizNvhETozaBd//6fRKPT
   DRt9wyV9coTGlo0CI7LkCkB8u3wLiQpkBGmdZ7wavH4VClZblvnWaE/gh
   6WVwxr9aI4tx8TKA4aGx11/ltX+0Oc1UY5hwRkdLa4iuJtNyaWG9lijac
   VIA1sVkEi7GNMJskK2twWhjXvJ8ZuJmc4ehdSnmrPqcLNbjKFN7l86nll
   g==;
X-IronPort-AV: E=Sophos;i="5.88,295,1635177600"; 
   d="scan'208";a="302509877"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2022 18:36:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLHK75r5b2NV7K3uLAndOTdXgGrI+cmcBXWZpVJKdjVo8oJdSECYAoztdHk9QuaT2MzhkV1yO11fxVLYWalB+nbeYcOc9CxOoBrqc4B1FS3MbGpUl4brqd+inm9bs/Fl20mIVDLEwMGC+oFqf1HAwqIUJHXrGlVjUhSnih6y+1GNMlAP/SRm0AY4lx5KESDm731AWY1qFNVeQm5X5Rp1Zq+8XIEcISbGjGKnVipbf0LBxzBrlyLPp4hrosbrxIulZs4DO2jKO7oJgicY4doIdQwdl3X1RdDt51N77viEHZvVaeo9GuishA9qjc66QDwt0cP5yLySVssBWJkwT3DJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRCdbkftK440JDtQUWWOUz/fwUqbHBJFJOHbgRf3WE4=;
 b=nxRVeMllrfGv/Pi2WhWQtBLperp5CsrF0cflKGC2PsWCa8Tq7HTcKrYW4X4PXxq5POxAEgOhAfQDSD0knhrN3U+DgWSy158Dw2uVJ/cZ/U404f1bFWco2XLatD9mBXz8E5d9tbOZV4HOeArQ02nK5RiFWo8rcT7AIWAubsXzapLfnYojy4GIz5AcbKSNVbcs7nkQjJuwqjJQXdi247ZKSAgQbM7QfjK/4yPGAjZWoDUBJM409MZMvNtA/PzoO/tzRyiQwv+O/nDOs1K9rigwEBQP4dGJ29+pqoYJsGKkWCMdjnzIGiQW2PsTN+YaZ2KBXkHZI3tk3TOBtr8TECFrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRCdbkftK440JDtQUWWOUz/fwUqbHBJFJOHbgRf3WE4=;
 b=btp57lXgtcVHCKmNRX8TuWIqslYBp4BAPef1WCGnMxZ6aH+6b2zmdYKgwv/vPyVLXamsnHJy0d04cZmcCCbz9VZXE7MatgFPBjC74DKnVFpA5W188Z3eds0w9O2esh1YuigFxGBNqDN279LuaGtb2N0Eb3h9t/Ep2twrTwc92/c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6742.namprd04.prod.outlook.com (2603:10b6:610:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 10:36:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 10:36:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: mark relocation as writing
Thread-Topic: [PATCH] btrfs: zoned: mark relocation as writing
Thread-Index: AQHYC3FUBtSrnJilLUGeirFvXsqm0axnFfEA
Date:   Mon, 17 Jan 2022 10:36:07 +0000
Message-ID: <AF6662FF-5DBE-473E-8B07-FB81CB59CE52@wdc.com>
References: <e935669f435882ba179812a955bcbb89d964db26.1642401849.git.naohiro.aota@wdc.com>
In-Reply-To: <e935669f435882ba179812a955bcbb89d964db26.1642401849.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.1b.201012
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb9b4a9b-5a47-4ee0-8d7e-08d9d9a52b70
x-ms-traffictypediagnostic: CH2PR04MB6742:EE_
x-microsoft-antispam-prvs: <CH2PR04MB674245F39B36AFEA2BDB12CB9B579@CH2PR04MB6742.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0iv9KzZM6CGOgIiiMnTQ5ZbqEZlDHZyONa9nrpdLLL0Lt7l9BFJass0LaE8PEb/n7PI5JfUI+KXAlzPw7ecS1/qBaSef8YodSNLvD7sTxkSRusQo4Q+UYetpCUIB86qWnFg1oTi3yxHgoQviPv5e/lf28p58gAvJa6L3yHBYLX6IYK09URpbXMvhDpEHZzs6nivzIua3sxMg0ZVlPRpsqxq8uf5+jhxsBVH6evEB1BB5RUj9z/a7SP8T331TyaW9FPHg4ij63ICR2+di6gUJU+sorFlo9A+9ZT8uorwFvPGSQ3AMgvecgm0UhM5KzHsblQkpvCBXzj8f6rGhvrWJkIlEzEGIzd+mybrPhSksQHRv7ObFyJIkMZQJOzzTAHHJAhsz10IW9qCidFkO8u9EKAMQ8AWJjEhHFmZkKbXEtKtx1ElAPELJg4f9DjHuFP6nixIcMIdM1IWxtH+q5lrwvebbyWtT1cB6VW3e5ygIijP7aju7i+Znm3K6vhtyVHBuP3Y3eupg3bRZ2PxyAQXv4G1HwbhGCOhdzcaHY0J098bCrPNE2VU4OsbSOgATSHg4Eplg7gkjzqWk3deecefAfzUYeO6l2Lo8OSmUJRQwCllqdzyWKjlThFsujLCpoOMRf+YVy1TnZ1ChzYL6dhH5Zdkw2u0Kgmx05uKD1BZrnpQgcR7mSkuzk5hSNQ064vVEkuERkp0102lA+WPjvXpTGwz/PYtmUbPVEC2NFlG3cBYVGHf0MJZerP+jPeThRDvO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(558084003)(36756003)(6506007)(45080400002)(508600001)(38100700002)(122000001)(86362001)(38070700005)(82960400001)(76116006)(91956017)(6486002)(33656002)(66946007)(6512007)(66556008)(66476007)(66446008)(2906002)(64756008)(8676002)(8936002)(4326008)(2616005)(316002)(186003)(71200400001)(5660300002)(110136005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3p5OGhWVm03Rk13bE5LTXVaUEg3MHFJKzk2MFVRL3ZENlFCT0VzTTdtY2c1?=
 =?utf-8?B?czBvSTVjc3h2SlZxcDByRnd2S2FTMWdmcmlxVDFaVmcvNk9UeUwzdHpONUsy?=
 =?utf-8?B?SXh3SDNqSjV4U2JoZUdsTUxwdEgzNmFDcHVmb28rNFZXa0lzeDYyckxoYVJj?=
 =?utf-8?B?Z1gvQjdSdkpNRlFabWN0UnlOdWlUS09GRVJZSGh2Z2JaaU05NGloL2hHNVFh?=
 =?utf-8?B?WnZHcXpweklnR0JTdUxYVDUxZGJGT3NkTEFDclU2alFsVWNVa3pXRDAxYk5U?=
 =?utf-8?B?R3Fsb0FtT293MXdMSWh2VnBaaEx4Q3R3UTVDOTJyZmlIYzJnNE9VZnNwdUJp?=
 =?utf-8?B?eXRMT002dEUvcWt2VGNNZ29oY05OOE9sRDFBNXRPcHlwaFRwZEFWUU1Ta1du?=
 =?utf-8?B?dk9WWnpqaWdCelBkT0MwSGhHem9LUzhaeDVBYzRJdkNjMUE5L09qamhYY0ln?=
 =?utf-8?B?RXlFNlgvWUpPRHlOeDFudlJ1RFdlZUlBQWUxZUo4OFYrUXBwSVhnTTFOeVdL?=
 =?utf-8?B?Zk53RVQzUGZIT0ZTYTZHcGI2QzI0Mi9xQjJzMGgvQWszeDNKSUpsQlRMRk50?=
 =?utf-8?B?dHd5MmFjcVgwbnZhdjNPSk8zYjVwbkRsU3ZoNHNUYW1US0UzNmppQk9TaTM0?=
 =?utf-8?B?Mlh0MnVOR1VqYXlZWGVJWFZsb1ZTSjVxNkVyTFpvQXoveXdRN0hnbUpGRTk3?=
 =?utf-8?B?RDdaWUtqNDZhWTBleHh6TkNsY0RGR09uWiswOGdlTlhjOGdzcDRkT2RrMVpY?=
 =?utf-8?B?SHpkVzhOczBPMjJOYWJoTmRtelZhTTJuRFQvekhEVXlGYUxOZURvUDJkek92?=
 =?utf-8?B?Y1Q1cmhyUVpBczBvdzc1RG9lWlp1ZUYvb3VsSWhOSTUwSnhsYlc0VHJHa3VQ?=
 =?utf-8?B?QjhheFU3Z29rT2l3ZnFwMWF0V2VjM0d1YVpPeFpRNGNOQjlEWm5SRnJsT2c0?=
 =?utf-8?B?eE8yMVJvS1dQdGxQTGxjSElxd3FDMnRzaTlXZm1HZFF6SWJ5NFVwNzRmZllu?=
 =?utf-8?B?elNDYUNxM3g5UWdxdm1VUFJjeXdLYTh1Y01KYTlDVkFMaytaeEFhKzJTZnZI?=
 =?utf-8?B?Z0ZEYW04TUc4WVp2YlJZUWtvY2ptUjlhVGhTSm5lVnBVU3VZUjZudDlwSzBy?=
 =?utf-8?B?Q0xPejdkVUJVL1N3YWU4ZXBmbmp2Z1hqWFhUSTBDWFora1Q4NFVrYnVZMEpX?=
 =?utf-8?B?WVJmQ1pxYjExU3JIUzZQZ1AzNzJORFhTODRndlVHUEloN2NYVU9GejlpeHlN?=
 =?utf-8?B?L1NGelBBMitaZEZzN3hxTXlKdUg5c3QwQk5XbmhxMlZCOG5RRHMrUURpK1F0?=
 =?utf-8?B?dFYvb0gxWDFvTHAyelZFTU1aanZUQ25pS1FaU1Vtd1Vxbm5GTmJqZXhrZDcx?=
 =?utf-8?B?TjlXb1FQb3g4TW1sYzY4cXBiVU16TkM3K0RYMjNta3BFQU1RS0xrdmRrOUJ0?=
 =?utf-8?B?MFIyVjFxSUZpOVFyTTBFaHFwekh0VVlkejNWSmlWMHhiQ2hxajRLYllwL3dY?=
 =?utf-8?B?N3dxQ2QvbVRmS1RLUVM2dDJiSlVrQ21WRGlMVDRDcFljTlBKcTR1U21adDlD?=
 =?utf-8?B?WEpyaFVjbmkrWEcxbGZBMlpzdlh1cjhFck9LS1NzQjhaTVp6UHZzYlhQY216?=
 =?utf-8?B?eWRXZXJxWVo5clJtUHUxOHloZG9qQ1lRalFObFE0ZThxSTAvOUhodHdVazJl?=
 =?utf-8?B?VHl1bCs1TU5CZ25ZTDl5dnArRzcxWWp6bHl3SEJUTW9kVmVYdElQS2RZd1d2?=
 =?utf-8?B?ZUNkUTYrakdOMnZLSDI1ZWJSSXIyb0YySlJlU0llTlN3VjYwRDRuVjVKeGFz?=
 =?utf-8?B?TDBMeEdEZGNidHdZcXM0d2lROXFjV3dYTTU2NFRvWlVuMElyeFF1T25FanEv?=
 =?utf-8?B?eEZ5cjdicDI0eVRhTWR4eHhORTFqVUMzVGM4c1ViVk54NWpHQW9wMnRRL3N3?=
 =?utf-8?B?MXU0eFRkenh1djd2aFdLTkdraFdYVFZmWGN5NitTZGt6UXVKcTFqbFZ3UWla?=
 =?utf-8?B?VlgreTYxQngvRENNcVFUYTVmY3VuL0JJN1I4b0U2TUtNQjlTbTQ1R2Y1VzhY?=
 =?utf-8?B?amx6RnVWZXlnQVJnUXJCK2I2OHArdktZZkdkYTZyeUx6endDTzFVc1U4cFZD?=
 =?utf-8?B?MndaVnV5dTFieDlQV2dEclRZTUZKeVFVclJhV3dPcmh1Zjh6ZDZORjc2eVZO?=
 =?utf-8?B?MEh5T2VhcExsR1R1QW0rTy90Q1FEYktuMk0rMzI1cjlaSGxFdUZiVWlHZFZl?=
 =?utf-8?B?bGR5MXFpcEVnVHYwbFVSVHQ3RUYrSUJXbnFZdjVUSWhyLzdZSHJOYmxMaW9l?=
 =?utf-8?B?My9xSnNxSkVzN3MxSmtzcDhxVnV6RFNFU1RMOUp2VFBNcXZSam1DNXZTeFJm?=
 =?utf-8?Q?9/VYS98meYSRe/6k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F198FC2A99AC9B4F8C1E68E635705EB1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9b4a9b-5a47-4ee0-8d7e-08d9d9a52b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 10:36:07.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37MZXGI44vxjxWVUNNTPo2ykmZB4uPB46mR3GI5DAn4eGVQvjUnR9jH/lPhQZe6NvDeoq6ITfz+ipMQxh/PSqDfgEgBpsi7TcFOofweO9yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6742
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T0sgYXMgc29tZWhvdyBUaHVuZGVyYmlyZCBpcyBicm9rZW4gZm9yIG1lLCBsZXTigJlzIHNlZSBp
ZiBPdXRsb29rIHdvcmtzOiANCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9o
YW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

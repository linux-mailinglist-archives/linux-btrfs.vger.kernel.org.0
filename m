Return-Path: <linux-btrfs+bounces-636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FD1805523
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 13:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729511C20DF1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F341747;
	Tue,  5 Dec 2023 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HxR6pd3o";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AVc7Hj5p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B7D7
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 04:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701780492; x=1733316492;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=HxR6pd3oinWTCjNqU7BE/DuqNKWFnxcAo6Hwq4h05rd86RtLxbIt1OnP
   iDVQAfoqKSqpRoG13Zzbxb03wg3ocmoYPksJ3abxk54StocsZncOfXU3P
   F/IetNK39QvuOnYsAjQRFLE/y7gsDd/Jgr9EQmdKWg68Rf6eagemAvO7d
   kBZ6lOsBidAv80S+33wOv4gtMB0Omo9aN3KUYivna1g0ZQeCkjtQ7I8HE
   FaeL35klxs3X03td4dmCX35iJdPGZaf9Ph6B8qBW/6W10sTg83UdSbFgR
   uE1vtu6hrQJ8C4alUT7QMhhnHc1dPAl7L7UXtxnyfvMPMAD0u+wUYM+23
   w==;
X-CSE-ConnectionGUID: ZxyhZmaJSwa1DVsKjcCn5Q==
X-CSE-MsgGUID: mqJ9vHNMR2GmUbHuhGpv8g==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="3914509"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2023 20:48:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLBZmemasCbecQUgh5XZxV+ZuD8HXAYf5Na071HyzJURN01Ty22Z3HuCGGm59Gex9hF2342HbBEK870+G9AohPrMQKT6WVC/mmK36SNLlq4gKXMDR3IR2BhqlJe+0NmuPzYkL5rlWHn41JqNX4B6Cv8CUSve3szR9CoRRR7zb7MR+/eKTzcRs95plFmUdo6KY6F88l0UOHz6+MNnBe+hJ/acWpqRRoIQoyGlkH0LHmpZgkDoQ53mLmUNpLa4n4cYwqA1Xc94yk4155DhsTeQhNnQLjTaLOoI7gWzMNoA+1IMskUZYrjnJavZziTOLu36+peNC2bXw6MTMun38L58+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MD/qNwZs0VtvV1kqa27988Uc5K7q99LPjkl4KLtFxFPlW1p7sBYyFuv8JR4KG+Gd5dbnn89lgxkbIjfPsO58dWUCjgZLZLsVBpEB35pPdvdzt5N5Q/hUiRDDkjRQIQmJpE9fgLVmjsE8wEPTOTI30Or1RQNW74DV7Cfa8l/u6hcTQJX+ioi7Gup2UyY6IUHQUgddD2ABCR30QQneeUiBqqsXKseo2eVfXKUbJnPMMaNO3Knkk1o+jIChUe+YI/UJo7om3btKFZDzxdxvQlIYvMjWZy9eixvnd1nlsJdNpjYdqKTY5A9KqRnTLsmKeUB+SrdjGtwIozT2Ny2Bo9o+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=AVc7Hj5pj2TiIPSux1NADVltUolTcbRd0RfijlQhK3+g9p7LnTjFTmC/GT8dDlZzOL482S+oOmKycieTf8klXu2PV57lRbKish44O8S3QyKfWLmkzP6QUsRJvp7UQ5VqwkmQFj8Uni+AvrNayqYuC7bFKopfto99O14PTrHun/M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7487.namprd04.prod.outlook.com (2603:10b6:a03:321::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 12:48:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 12:48:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Disseldorp <ddiss@suse.de>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
Thread-Topic: [PATCH] btrfs: drop unused memparse() parameter
Thread-Index: AQHaJ2wlmZpImcthA0mPUt81Xg9OT7Cao7oA
Date: Tue, 5 Dec 2023 12:48:05 +0000
Message-ID: <4d405fda-a86f-4adb-9012-6c7d0d7d4ef6@wdc.com>
References: <20231205111329.6652-1-ddiss@suse.de>
In-Reply-To: <20231205111329.6652-1-ddiss@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7487:EE_
x-ms-office365-filtering-correlation-id: de22df8e-c3ba-4883-5326-08dbf5906cc5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hGznVzYiz97C8ZfdBQrFrTMmz1q/s7mivxaLfIvJgag8NeRYPjzsLEP3ecBY+VoyBvypz8ftgnRnuYC+qBKU4EEj220/ErHQ/F9WIPKIn8NQbSEt8o2uJsR+SPgrDsKXXUVlPOKbYSMvvAntJOaj/cz1mX1v5JvXDG+AqQGW927OZydIgCeHLSatEPn0dj3CWJ9WK+EARkDry4Rzvqs46F5rba/3J3q1XtifZns4dgZqhCooSrF6+RiF+CQXt+132KenF3v1pHxbIGgyNMcxuP99CMTc1rmU2D51AiUyIa/xT6KF+4xwCbFAl78kC22ggIT4Y5QmHVV15sHXPYzjY84NnakWSUjCTV40d/Czel5jCA62D6vekVdG+eUDtvFxCKi9gSA6g5xqle6q8pIlUApQG9xbQ2DNSfvIpoGEBCk/abZO4cttUYx4hsrXtm7h05RMqBmHBKA57ep65QcVWPsKEXusDytUUXXuVCTBDeEH/Jq9GORXcdEkW+/9nMgcLLUEOd3nM5C4QbQY5NhMclEwcgoPBwW3ou2CyG4Kj/4YaX1pjr0asoFr1Mq2o5ejVjMfQYULVusTpf5BJX0lFzVHjwwYAzs6ikRn1iEbhHZ0nyP1NQnpUXxOzt9VG+epsB+yx7ursS6lzs6GUUvHnI0HYStxWV7ycH0BN1CvBhtEGN5Eqb9ZAQWNjwqr1516
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(122000001)(6512007)(6506007)(6486002)(478600001)(71200400001)(110136005)(91956017)(64756008)(76116006)(66946007)(66476007)(66446008)(66556008)(316002)(26005)(2616005)(8676002)(8936002)(31686004)(4270600006)(82960400001)(5660300002)(2906002)(19618925003)(31696002)(558084003)(38070700009)(41300700001)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUNQMVVQOEczd2hsdGtudGNtTzZaYk51UnRIQWE0NDl6YVNXM00wbHpMWFJH?=
 =?utf-8?B?V00rYXkwMXJuOU9pYVduR3MzeU0reFR0WVRUSytZZWpFZXBhYmg5QmFNaS82?=
 =?utf-8?B?SVMxNXlRbHVQeVVHTGJsU0JWVHMvbE5ka2lJUXRFMTRhNHB5aVZYeExaLzZy?=
 =?utf-8?B?VE5hSXFrVDd2R2tkODZmeXFXTXNvbkY0RWNjb1dZd1lzWDMvRG1XanNuUEdF?=
 =?utf-8?B?YldPNHVLQ2FHb1pqUlA5YUROTXJZa3NxYjMvNmZ6RGU0SDczLzBkUkEvdmkr?=
 =?utf-8?B?VU5NSTBVQUxub3hUSlNSWlZSdkc4VWE1ME55UXl4YVB0S2hBcnlGWkFtVXcr?=
 =?utf-8?B?Y3RSNjh3WDlMcXArMHJiSTFmZnlEcndXMXNMMStuYVpMNW0rK29PS2RJM2Vq?=
 =?utf-8?B?RlJPVnZ3aitMb0VXaG4zRTNqTFFBeWs5eHVLSHFiMXVUN3VrbWZlaGtOL3V2?=
 =?utf-8?B?QlhZNTMwRlNaQUhvMEJEaVltUmN6b244Ri9LV2hiNTIrUVJWWTdGQlZ6OVNz?=
 =?utf-8?B?TnRNeWhpdkw2cWpKRStDL1Q3MVp3dVh3amlwZno3Ynh6UU8yWnp3NWNhTE42?=
 =?utf-8?B?L2dzUi9VU2h4M3ByaHBvUXJmN1FmRW9ud2tzVmVSTWZBeEprTjZmOHNETXZC?=
 =?utf-8?B?d0c1SHRDTE4vaVA3SUxDdnFWNVhPWTI0cmt6eGVyc0lZUkQyNWlSVlFhd3Rm?=
 =?utf-8?B?WE5JaXJ3UE4xRVRlUjZ5YVdqYkJUN0JPZGNBUmMvZHhQWEQxNnFPUFV0WWtR?=
 =?utf-8?B?azQ2bFArSkl0dTdhWW5kUHMvR20rbDIwOWNxNkNTZWxWaC9KVGo2N0g4MlBI?=
 =?utf-8?B?NFJPSnV6RUNzQnkzRVk2RkVCYmtvSFFzMVJuTkxmcDhJdjBRL0lrcTZYU3Q4?=
 =?utf-8?B?aVdyQ1RQSDEvMVA2a0ttWW1uR3JMVWJEUU5WTmJGZXkzdDFoZkt4Z1VweHRj?=
 =?utf-8?B?R1o1WEdPcC9XclMrUnRJVExxd3laS01HemY5bDlIQlFvL1hqR2tldVBTZUFY?=
 =?utf-8?B?aXVESmV5Q2hTYWcrejZnM0JoTXZiM2tpVklEQS83dHFiOWYwM3I5OFV5OFhN?=
 =?utf-8?B?MlcvZ2duaGk0VGw2ZVNlYWxsZDNTNGlCdDdLSkJhQjBJSTJuUUN5Ym1qRXVz?=
 =?utf-8?B?dTV3bklDd0x0a3BYTnBCNUpmR1lJOVF4VGlRRnpVTjJMRFBVTEc5bnIyYk0y?=
 =?utf-8?B?VFo1ODJNRy92NDVkc2hPeHdMVloxdDh2dDFNWVZvY0tTbHp5NHU5KytHeUxt?=
 =?utf-8?B?T2w3MXVucm5TRzkrN2RpeVk2YmlhTXBrQUU0c3IzRzVjSXV2SW1iZTV2aEV2?=
 =?utf-8?B?c3FPRjBDV0VwMWJpTy9rZUhLd0N1TzlnVXpNMXNzeTRWRHFGdm44RnZrR0dw?=
 =?utf-8?B?enB4MjdyUStmVDVnbXVkdjFkQ3RDOUpFSnJBTG5ET01QeE1SZzZ6N3ZYeDk2?=
 =?utf-8?B?WHRoUkxKQW5ta2kxWEtkbnFEdk1TZ2dKdVVOL0t1YVJwQko3RS9Bd2RyWTFG?=
 =?utf-8?B?NXBLQ0VzMW9BN0F0NlJVWUM0S0hiWmxXT2daaTRWTWZvbjlmWU9meEZoc1kr?=
 =?utf-8?B?UWFSQlBuemVDcHcvOUNqSUN2aldoUnVRT1FUS1JCd0ZnYTFqQkJYMHBVRXJH?=
 =?utf-8?B?bTl5QkN4Tnc1a2lDeVZTTENHa2JlNVFIN0hSUFBVSFVvVFN3UHNGa2p4WGJH?=
 =?utf-8?B?L25VZnpMQXRxWXU4aFNvUWZEbEtnT2RHRktlOCtxVTdKaFV5cHRCVXl3d1FZ?=
 =?utf-8?B?NGNuMS9uZ0lUMGVoTUtOZEVoalhkMlBiMXFoNExWK2o5UzlyU3Joa3pLeUN2?=
 =?utf-8?B?NEdsTmJQUGc4T1JwcG8waFJsdXVrMkNISGVJWlNMVnN6UmJZQ0EwM1Q5bVFK?=
 =?utf-8?B?QzBlcWNFQjl6eVlzdlVTZGZEMmVsWkx2VEMzRzdXN1JDVEVMWDFBamFnWjFX?=
 =?utf-8?B?K0FaQ2VrQS80R0VkSXZaMDl5S1pNc29HUEpmMS9Ycm94TVFSdkJxVnhBM2l4?=
 =?utf-8?B?MmRZYnJrTG1Ea200WUVETGVOTjVudVVFWXRCSjJscm1WSlFabmVJZWhwUHZV?=
 =?utf-8?B?bmNIWWFDTCtkOXYxVEkrZWU4SXJXRVhTUTl6aWxWWkg4SnlvY0ZQTVNNa05U?=
 =?utf-8?B?L3JOVmhQMUNoZVh4NFE3ay9vZG1scGNJNUx0Q0w1cmxTWmI3RW5vZDFuR1Fr?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E45A9F46D33CA346B431023373372281@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GHyuk9VXurfHjOaXz6vAa3ZgXTIDeS4LxirQB4C8XahfAnAmYjWL/6IQ5tcu0GJJeAO7A+W68MNroiLChPiIDSzxMV6gXNS9cZQie0u8c/7FeyyhIKcRAMn7sNzHh2dgIJLxlwJh0NqLtzvTZGzNCEZP2xk56vvtUj9HnO/nLYGnGoywYWCRjLyBMf3RcQzoVuNfCiUN0plk4XWjMPdBIMki6jMEH23WM8nbXU9X4TiFccF2NXlXP2vRIVt0jVsTMzJq0J7R10N4N60inHiq+epSn1smQuEhQfF1HR4Ar5fNeIBTImxkiaRzU1Yhq9OSq9LGmJCZHRyryHYybLSAWC7ttzXNtmtRjnv+OJ/ILSMSURCMgOZc7DEXM0jlQLhM+h6RQHULemW2nVqf5YVEC21Dsphcui98hpZ8G8GerUnNMNqf7kkBKkDHdxuTqLNxcUNyxRLLWmIZILtTbYi9vq3WiveIR15/+gW/yiF0P8yMz30i94AIRb7LIEEL8BE9P9EklOYCYLZbyA6bn7k9Xrr7EEKA6hB/ezNKqWG9QYquStXG7BDWGtFmOGP9iUFwT6YgbDcBV9hxy+XGTzkCO63yhGiQsgU1gDUQ9WPfGRVyW23QqzgrG47JozcIhAaytzwI6eSUSBGPt2UQxTkAcGaHwrf6KjoWldNaWG0LK7FuxPvWin7PGEeOdN0GGzD2EqsuN0C4Z/yhVSOnlalKvl+FRHc474SigHdqwCjGcbPZU/QnLQLJEXmpcW/gmJQyDQGqCHvx0CSgnnaQeoM7DxhE3gQIA4l5/xD2pRzWElvqEfKvz2UeW7n4dQ1cgJvO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de22df8e-c3ba-4883-5326-08dbf5906cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 12:48:05.1787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tj0l0UpRuKPzGB6YmsTI6bLnkPLwgmPfRCYJt0x5dwpNpqHAjAuQwoxb8izbywbPcq38R8Mn8E5DMxFTJsoq/mkvR7DgRsPfMM1ldRBT8tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7487

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


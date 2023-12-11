Return-Path: <linux-btrfs+bounces-792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E63980C398
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 09:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A9D280D58
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F324210E6;
	Mon, 11 Dec 2023 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UK/JAn6S";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Oh6CFwzC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FA2A0;
	Mon, 11 Dec 2023 00:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702284598; x=1733820598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gEEy64cPaadiDJW46PCy1X5OzzgpxQCkNwRm4JFlN0A=;
  b=UK/JAn6SMJ/MbL5q4EUZwIU2teWQWGo68+QwiQFF5Wf8kJQYWRee8V03
   RwMBlye9hR8mfNh5zym5yKGCP2HESsRcbg9CPkDzoTg+1jveUI3/g+g2W
   kP4rcP7Ez/GB/AXXX6/jqPvYDIl5co9+9xqEH5Nb7jP96VaTETSfsNJ6j
   bnUO5qWHNoqF+ephL5bglxegjggHmsib3m1o/LD93d3KfUl18yOj2KtaK
   bSHwIpfEGm8PtokPDC5ybkgjW/Dc4EzXeKbhSRAnDKxWr7eDTl1+YTxsy
   omJW0KOC2LR9GxToZStCFUQKr4J4VpafwnHBpgGn+SHFQf5fDgEi3lDYs
   Q==;
X-CSE-ConnectionGUID: bNMoyuX8R8SuWEhcZV7OXA==
X-CSE-MsgGUID: oaILRQOeQqCvqrPiy8qPLQ==
X-IronPort-AV: E=Sophos;i="6.04,267,1695657600"; 
   d="scan'208";a="4673359"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2023 16:49:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKceD0pz7IR5aGt6wdnxo/MpAFBtoCpOv7551MvYQp5EWCJMbSlLL+qcafbWRMoGqitW3/tg4IFAk0l7ieJ0pRXC2F8wGnKTvVln72HLvgbmWL78mFItINqp7NUQ72oXFVAUOYAHSVwtzAg2RcEWFlErbtkpIo7RxM18yYlBrytJfjsKQ/e+nWtjr1iDvIF42ODd24WaEY4Cpb14cKcCmB7hAH/WuVp2rxAwwjHMpAY3Uq1pWs18/BaTX3PttdUo7UVoCoE7IbI5NBBp8feh7YWh4YeOqaERnQ05+gu/92RRmwL6r2sU4iO/G89gf5dv0QSdlK1g/+dbRkqxQJ8+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEEy64cPaadiDJW46PCy1X5OzzgpxQCkNwRm4JFlN0A=;
 b=HjOVVUwVukb1r5a4OcBjJxI8Y4tZe+8nqBZXHLfLByHmU3jGKdFTkMfWN0bWsrXv7HlCUGI1MOnsBsVWndUqgD8cBQWwbG8vmHcVVlMFIzDSOuZAmy+yin/Qx2etsV41xNE189ZbPlppxjP5Wi0kMGKNg7rLFSh57l2SxHL+WjsIz8b9XCMcGiEiR6sn4glj1/KWWnAQfFXP+9uv0SmakpU1uKqys2zHQCAY29xhhRNJG4tP/zGPkzRs5UjNFn8WVHuSjfs5d/FZXryzm+OdNyEx3MHLgOroTGXcoOBJuWi2ZyR3ggGKX+ilEMl3QHgz/Ym3Y8+CEuPGnatg1MyDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEEy64cPaadiDJW46PCy1X5OzzgpxQCkNwRm4JFlN0A=;
 b=Oh6CFwzCKgUo5633EkhEp9Rpyxr9gAJcN2TnLd9oFAJBA/Nso/mNIycZHt9JIRWthv92EbHhPtzf9/Ee75i0wYIr3nfXGC5+a3M0wmbmE+UMyiDAS/ur5NzDkzr13AIG0jBFx1RVUcz6xIIcCW+AjAbW4z17pvJjZZRZKBKKUPo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7441.namprd04.prod.outlook.com (2603:10b6:303:78::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 08:49:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 08:49:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Neal Gompa <neal@gompa.dev>
CC: Anand Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@kernel.org>,
	Zorro Lang <zlang@redhat.com>, Filipe Manana <fdmanana@suse.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 0/9] fstests: add tests for btrfs' raid-stripe-tree
 feature
Thread-Topic: [PATCH v5 0/9] fstests: add tests for btrfs' raid-stripe-tree
 feature
Thread-Index: AQHaKOxF3S6DLq0c+02PlL9c17xrX7Cduy8AgADcKgCAAIYfAIACOPEAgAJ1wwA=
Date: Mon, 11 Dec 2023 08:49:54 +0000
Message-ID: <eb1ad1d3-a387-4f25-9bcb-80fc6c1123cd@wdc.com>
References: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
 <CAL3q7H7pMjbc1-xZ1xDSMRBM2C-FiTi=sx=mQNBqH4MbXQ_WLA@mail.gmail.com>
 <0e13042e-1322-4baf-8ffd-4cd9415acac0@oracle.com>
 <ea5e3a98-b5ec-46c8-bf0d-e8fbd88cf4eb@wdc.com>
 <CAEg-Je_B87HAvFVhm-_1Q4NDuhyELVrDxvebzrDfNzUL4yi+ww@mail.gmail.com>
In-Reply-To:
 <CAEg-Je_B87HAvFVhm-_1Q4NDuhyELVrDxvebzrDfNzUL4yi+ww@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7441:EE_
x-ms-office365-filtering-correlation-id: 10b1d339-ce13-42dd-9c6a-08dbfa2625a0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fcGVT6dDfv6aqIOk8ys9q7vBABTYIb9hrX+wuPuDbscDYB+1d3SAL+hm+Cr+QidDaOhO35EH/ui8UeslV0q/cPPcIUCErjrLkoURKPJZ8JYz5ZHqC2tngGfHtxMYJSGCaThChYAy2vS2klYmRJzIPXHxCZyEsIlacHhRw/lRg/nVJSgH9a541JtdWBALBWd03EC8magH94qGsdpOiHEzwTFiBObjQWhth/oWUxhDsC3zk8l2XbMXzy10NZ/PticcmM+eTXZJ3YNFMU3LyKwgwu+WnAFlcdnE/bwgAN0lyS9s3OZIgEewEQ0B1hOG2aG202JgJ8lyhDmypHWpa8uxoQaFjjy7eOlWMga2RoN9h6hCs0slQfer10V2bcuOhM5utJZRz/2PYPmUsV3hiZeoTHqLUAR8B7bwxUfSi1vTLmCIMWi/O09mBdGfgsdlo7VODBfEgThoUceS1LopcnvlBB1o0MBpkX1nUgQlsT8yHD6yUTcFQZ9pw4YxEkS59K9fB9pPAgkMx48nI6KmErw7uJ+M+6yBVQdbTUES4CxaqjNQNSlK7F64rYPXMnMIG9CUXIMlYYdhZnk7kx/n29Z1DXPx5GA44LUAVXLxvDkHz3fKzWAoBENnEMNkQ89DBIe8n6IQM/inEaIccc9HGLDYHSYmZ+BmdrtYLKlI6WKQELM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2616005)(82960400001)(122000001)(36756003)(38100700002)(86362001)(31696002)(38070700009)(5660300002)(6512007)(53546011)(6506007)(71200400001)(8936002)(8676002)(4326008)(91956017)(66476007)(76116006)(66946007)(66556008)(6486002)(966005)(66446008)(6916009)(316002)(64756008)(54906003)(4744005)(2906002)(41300700001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGMzd3kzOFlqUEpRSkxzeUlYMEU2K2VvcDg5c3ZBR1VacDVJRlltL1JqVlFk?=
 =?utf-8?B?cWxsZjZBM0RmTURWWk1zMUF1ODJTbG95aFBuVU1ieFdhUWZIU0lJWnBqOVFv?=
 =?utf-8?B?RXE1WkNQUmNsODlQaStBVUUxV3RHZjhQaFVFR1dCUm5aMFNGMk13aFFCVlcx?=
 =?utf-8?B?Y3E0LzVMZzRqbHQ2K2MxYWR5RVk3T1c2Z2RWa2E2M2ptV2lXQ25HM3V4NDFn?=
 =?utf-8?B?b29YYXF1dU44UzFQNFAraW81T2Z1L0R4SmltRjZwRGd4UVkxaG5OM0xTUk4w?=
 =?utf-8?B?eFJQL0lOUGdzK0lqRWk0ZWQ2RlkwYWJ3U0duY05BWE9wdVdEWVBhTVh6YitX?=
 =?utf-8?B?UTVLZ0dsdDlVY3NQNktiM2ZNazZaaVY0TTU1MUgycU41TGxlaHRzQVVnV2Fy?=
 =?utf-8?B?U25rTHVVRGtiSDN5S3M0dnpGVkZLK01QY2QzVDVhYm1qZmJrby9rKzBvckNr?=
 =?utf-8?B?Y0dCN3d5ZWFnSFF2Y0FRU0hEc3BCYkhUZy9kRmF1TFpUbVd0VW1aNjJKaWdD?=
 =?utf-8?B?ZnExYVZ6L1dJYWFVaTU2alhwbnZqcWFxcXJGWUlKY0JzRWY1Wlp0MTBqcSto?=
 =?utf-8?B?ZkNENUh3ZnJWUDdZQ2srSkZ2SS9yeHNRdGUrQ1JOblZlQ2tKY3drZ05rNUJy?=
 =?utf-8?B?K0ptUWdyVUM3SDBpU1h2bzNHK2daV2RzTDZtbklzSi9EeDEzSHcwRFVqYk9H?=
 =?utf-8?B?eTBubUoycDY3bUdVb0ZzRDRxQW4yWndQYVNUdWVUNnYwT2lDdU9RV2E3bVJH?=
 =?utf-8?B?VVRpbStvVTF2UTU4TER6aXhUVndpUkVVazVRU25PQ29HdVBSSXdSN3hjZ0VL?=
 =?utf-8?B?aWd6aVpqOGxsSmlueTNodGM3WHRIcU1TV2ZtMmtQM1h5d2xTY25aeEJ5TS9U?=
 =?utf-8?B?Ym1QSGpkQVQ1KzYwTkhXU2JOS1N3YzZHbEU0QmVjaFUzZFR0M3NDeE9FVlRM?=
 =?utf-8?B?bDBJa0E5cVdiYUVsRUF3M21YU0J3MnRSS1REZWp5QWpIVHI3MXJuWWNnemUz?=
 =?utf-8?B?L0dLYklGUGZiTlZlODlleEhZT2grMEduSHkvc3pQMkxEbzROUEtjanF6K3hO?=
 =?utf-8?B?eXBZQVg4eFh0OE5vcGRNYmVER1cxaEw1bEN3R0RZU0xrZWpoOTUzUXlsNnlo?=
 =?utf-8?B?anNQZWd3RGgrUFF6RFBVK3ZnaE4wbnBjY3JHbGRTc0lXUUI0K1JCL29FdWlt?=
 =?utf-8?B?anRYMVhGeXM2MmZVZDk5Z2FaMmR2cWtYL0N5TUVIb0Q4ZzU5QXhwdEZLY0ZM?=
 =?utf-8?B?ZmdGQlB5dmMvaWNJWnJBQTVsQzE0UnVNNi83SDlhbzZQS3g0T2pWbWtLRHMy?=
 =?utf-8?B?bC9helJqOEhWSWU0cDhRZFBDVWwzUEhVeGJSM0hjRmV2bTVSQSsyUTRHaGY1?=
 =?utf-8?B?cHd3L3ZmOVA2U2REV2tkMm15c1VldVFoRXRnQmdSL0FyOTd2b2dabHhGb2k4?=
 =?utf-8?B?OEY0eHYvZy9WQ0Y2MlNBNHR0U3U1WTJWNldmQXB2bkI3Y0hMZVRmNnJKa1kw?=
 =?utf-8?B?a2RoNDg1V1F1R3kzc3NSTDZiRWtTV0MrS3RqcjhVYmVVelAxcWNvcjhDRXZJ?=
 =?utf-8?B?b0hZUU5ENzBCbGt3S0FiS0Z0d2wyUjFDQTZUb0w1TDgrajFlVVFza0xqT0NR?=
 =?utf-8?B?UWF5SUF5SGFmZ2xBL2JLNThiQjMwWGM0ODMvbjlsUHdhN0lUMFY4M21lZ29U?=
 =?utf-8?B?cG1DL0txYUZ3T3p5VE1pMzFUbkFDeUdtMVlzeDVvSlc2WFlRY21Qb040d1R5?=
 =?utf-8?B?OUYzTnZJcnJtMWZBb1hVVmhsQkFRL0dDcGpHem92UWg0dmNEbWpYa3VGeUZv?=
 =?utf-8?B?Z2RSWStIUHJtT1JpM2tYR0wxN1lyQ3M2ckhmeHZiTzRhb0ZRQVUwKzR3bUZM?=
 =?utf-8?B?UlY3TE9VVisvS0djK241Z3VSckwwMXRxVllKTG9BeVlzWEh5amNWS2VyQjAz?=
 =?utf-8?B?RnQra0t4VlY3Mlc2MU9aQU1sMTBRZjRCbmdCN3g4SnE0RmdZYVgzNkRsekNU?=
 =?utf-8?B?Mkp0OFprRVN0S2ZIZFNNakZuRnhWTWRRVzRtT3lEWW0vOUdjK2hiZ3hQZHRS?=
 =?utf-8?B?UENLU1JVejQ1OE5JbEhJSUlGVi9iVHp6T3Q4SzMvbHZRTDB1RkNaU0hRYmVM?=
 =?utf-8?B?OTZaT1grd2VuWjg5NHBOb3dlZ0Z2OTNacnpQeTBCZnNEL1pMODVLSnYvWDQy?=
 =?utf-8?B?RHNDMDBPSDFQS1BWL2hjYkhGWVFTSUEzUHU5OUJzWFNwcjJjNjBqUEN5Rmxj?=
 =?utf-8?B?aUtwcW1XcWJaKzVvNjZ6UktGS2RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBE2653B4194494E94F31D46F20C1D7A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+sm3TMzDreEum7UmvrFnKyGjUlybEe9rd+1AWAWD96TcTCu4DoGOqnuDsmAr7CvmyR96DihpqDbNJVPWkftFgSikgrmtVM0uc5vp4SMYkxi2f0mAZ5ARNttzHzC4hNk8eVzmR+rNX4+5HvP+LTjOPpyVldabLopm6cu4ZFWNwGeTz8kSkM/XSdq+qQVw/DAX1HH8h4ysTDeUjCrjB6OOyMb+aDFnxHrBcOT1ygVWUm9cgYu5KxKWp8M5+7tF2AYq+hr3KL5qwcI7DI3KJbLrki8NNPr1BcnnqvuZ4YS3FgpZgZEP8ovhzbr1YXIiGZVfVMdRwN7u76/Y3SOd8hXMcpGUHVMzSJ0XLPZZndh5lpmX0/ZtKFlVXT7T0bPte/osqYqoluz/g+AlRSAkxx344L3uUcovSwUsKzgo7CTa35vA3c0fMoFwyonqxZLaw2Drnp6bi0DGJjYCTjirAn6njgO9qNlwQ+JKmC8YeXb95iKDGAuG8+gQdKxuZZmZYFKgreKYysOVYt+N9xgaS/DikE3Mk/4sRuQIQWm/Kyxj0Zlhm/G4Dv1HuQrJTAsr7czeqnMnH+oGyJeMoWF+UaUQ5rdYTpBZRnltJrq8MvSws3kRCBYF5NTxnEgEvVb1DvrBNlrYylHo6YvdJlyg8qKshzauRzICmAo0IOuLDkKCdSS5AEzjUfA/4ed1Y3MqEp24dkYKiC2Ygh4SsjVL0R4T7sCrtEYyqmC1EIE3RCF402W5yK2kGg9oXqyg9+HJzeFT5XFm2A8naypNs86/x92YGbV4vzJRi7oLsTTAcNSkUakddwOtNg74BTBULs+OenV6yGozidhc5uhLTG6vBTndvjaMKtRj3ZWFUF+5Yp8oklzC9rPD2RKOzzEsIj6z5ROgRbl9tmr+2xa4hltC6eq+zIgg96jXvyu/nObv6qMGAzg=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b1d339-ce13-42dd-9c6a-08dbfa2625a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 08:49:54.9435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oe+LdsMr3XGT2OqUHXp1KWPmVMwi4rSB1/LdMndDN1uPzBlTvDQUyJ4fDfw2/DBo7+8q2kG0+rPphFU8QzCaedMp4pjXncxqj/sdl28oa88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7441

T24gMDkuMTIuMjMgMjA6MTYsIE5lYWwgR29tcGEgd3JvdGU6DQo+IA0KPiBPbmNlIHdlIGxhbmQg
dGhlIHBhdGNoIHRvIGRlZmF1bHQgdG8gNGsgc2VjdG9yIHNpemVbMV0gcmVnYXJkbGVzcyBvZg0K
PiBwYWdlIHNpemUsIHRoaXMgc2hvdWxkIGFsbCB3b3JrIGFjcm9zcyBhbGwgYXJjaGl0ZWN0dXJl
cywgbm8/DQo+IA0KPiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLzIw
MjMxMTE2MTYwMjM1LjI3MDgxMzEtMi1uZWFsQGdvbXBhLmRldi8NCj4gDQoNClBlciBkZWZhdWx0
LCB5ZXMuIEJ1dCB3ZSBjYW4gc3RpbGwgc2V0IDY0ayBzZWN0b3Igc2l6ZSBtYW51YWxseS4NCg0K


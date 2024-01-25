Return-Path: <linux-btrfs+bounces-1794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B157383C661
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 16:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4033F1F2450D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE08373167;
	Thu, 25 Jan 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J86dmehN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V7ujY6WY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91C6EB43
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195828; cv=fail; b=ozs1ZrvYUtgQG2Vxg6sKoFcwKUYSWmD8WIlOJScA4pg3/MHZlYyLcYxEzKrH7GAVxggNp8Wv1mxShNMdBaLHVnrjN4INKoLGofKLbpVRJZZeMQIb72yY+uY5ym/KG5PJcVpDtzu1PX67OVTONQ3PKjZOVRNNw6XySZ3bKtuEaPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195828; c=relaxed/simple;
	bh=FNS+ulYXuc4StuZOGcxE5B6YENXBHx5JknfnV8CsHnA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DhBqCDZvUuweXF0ZXJv5rL2DT8TMtWzwPWm1U9vtm75LSeEyMCc4DNpXMr9TdCZKB5zP0ythPwv7j7BpXduP+4I6cQ8GJySu369bJsqytPiT0SJ8sV2jUXt/pC6GI3U5UwgJ0IWoBIM8YxqFNY1s4FDCHZLl5nIai6dZjZaZFmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=J86dmehN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=V7ujY6WY; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706195826; x=1737731826;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=FNS+ulYXuc4StuZOGcxE5B6YENXBHx5JknfnV8CsHnA=;
  b=J86dmehNmmwcG1iaRPWPfl1Vz5aiTznSE9UTpobEFXLFyKfrrj8gQXoX
   K4I7LIlipth2DCAlq2ue9v/Lb3KlWGu+3Cpz3WmczUsQBHI4hcf6T0u8i
   UTbT4+3EstgrSd0dmVC75Zt+5jQYbzTwNXuLMx/PmZXv1z5mYi0UaEFhd
   wG4tb2Jt0X1muWXRtPB8TCHt3upXYjn+xHnBRwJ8QYMnxXf0hyQWbE+Un
   App/W4yJ0pZL3yvY1kev+fOBTok0BZUWmqbGxNwZCQ1YK+Jbz+xJY/zJg
   sDu7eOMRuCKGlabtlUQi8hf6qtwfDK8xCdzh8tFRIhzbLo4b9UAxopKc7
   g==;
X-CSE-ConnectionGUID: Fqetz7MARWqrAcFp7/M1zw==
X-CSE-MsgGUID: n6cLz2zyTXCPi/R4pOtlOQ==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7957755"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2024 23:17:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLzHG6NCPrWTsLTIfW8vF3WPxSZc5BC2UxfNwddPlHahT7dFd+ZEqVKMyG0gHqkVz1sNFY/HWggmLWJ1s0OarOqH10mzP+Jk8fK1DIfdF8EzkBns0L467TOILa7HaCgixiv1zgCsf5XuMF7hw5Q+wnHpNOnupXcU/aCswEEqgvDhRLOf6xIn5Md/tsim70+meyeDO9lKReUc6reFg7xjJHyqclfpZ2bbXLRKFHL4D67aRslfzArehNxDpnc3tcSROoU7cuOchlYmG4Jbkgj7r3KYoetL9wnYaWfR9kwkgShwo+V2Cw22KAgRepBaNcaZcZ5I/4CU0L6zOMWz3h4lGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNS+ulYXuc4StuZOGcxE5B6YENXBHx5JknfnV8CsHnA=;
 b=htAqDxfa9ZoZHZ7yITx0NgBGqwZEnq1VsMAJUQHi/Z+i/LO2vzcTB2e/Md3b7fEBa6gxwkqKIyluCA7veprXPNSVy4n5AuJtlPv6TH76eBI73kqI8RHVJmjLnjAbAN9YcMYJAn4K2/IjMNk/NMsKPTEzHlth0qQy+nB98yP5fFjg1tJWR18if/rzjKkd6i+bIDuFndp8sC0ucVUGZ3Z7rqK0OghW4ZfUML0wNcimik6bWaQJA0ciibHeuVk0OH4vXSKktSwqFrVXNyWOjjnHUu1z2XCmLpzxsFCSPLRfXVWv32joqzK/V7/8M985ZoEpneGkZs0nVyUZnWreQEqDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNS+ulYXuc4StuZOGcxE5B6YENXBHx5JknfnV8CsHnA=;
 b=V7ujY6WYDiE5H+Znkt1vWdYI80kBS+85PUFlHIuwGwUV8Gva1hSfNLRUhY1MiQw2mbb3f2ERJ+KPAJfvRRlAmiQMBCFVGlPMyPVa1RMT6iF6ui2hV9wEBCbJzJejmC8moI0jVh6a3Szd8yRs7uc2+dQC9scJIpKmzxMeswglKVs=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7759.namprd04.prod.outlook.com (2603:10b6:a03:3aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 15:17:00 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f%5]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 15:17:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] btrfs: some fixes around unused block deletion
Thread-Topic: [PATCH 0/5] btrfs: some fixes around unused block deletion
Thread-Index: AQHaT3k9S9C4cYmlj0enhZBT0EeIvrDqpCKA
Date: Thu, 25 Jan 2024 15:16:59 +0000
Message-ID: <7dd2a553-46fd-4217-98e8-70a81b69af11@wdc.com>
References: <cover.1706177914.git.fdmanana@suse.com>
In-Reply-To: <cover.1706177914.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7759:EE_
x-ms-office365-filtering-correlation-id: 68792d70-c632-4220-45f8-08dc1db8ad77
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5qNQkIPrx/ayDUKnM6/bKnMmPzCGh3ZcYAdqT84vFdk6+jXPWSWk1mO/2WNQAk831z4AwYG9LPkYhQ64sNbXu4ouVucaZ5o0pEGwDVvkn9RwqhvjQC/OKmW80srUKuvVQ/7T0K1JReBxkrs1M2hxqz2hzZ9IcUzY7wYxRt+xoM6ZfGvqizsyaGDBm4Ts9Su5GZvrEHMrrjpndjt9ny5xviJLCMsjIoTjIXtiQDc7V9DfSvhTIl615Kwd6sanxFUGYTTECmy3o19VRbXCWbRl4Esa1PM7Ancf/R7JWosucwL9p5J68ZLcod5Po1sa2HPkUaJeTild7n1YJqRZgJyHfedd1zPxpNOxkECXV75eWo3o46PDNcVPTie/XPenZMiBKXld/nuzy/ik/tEU2Zxu0dUAFshAWMdD+DKCMqZPunaXFQlxyjAZXoeHJ5eO1m/Q23aUprtt4fP6S5V2Ms6MK/YqidTcxzpdxSD/uk8xU98PtWMXF9hXhtP10SA3sk2i3D//25bFgPyV8SPL6Ic1yO0ff4eB9Cisjv6gSN+ryCAwTk0D3WJytYi2NgqmsV2bsw0h9CQdjaIlEdtdopg+5FV7YAk/B1uUqCBs4boqcJm+niOBGSA2bWji2GNMSFjpjua+xRMyO10LX7lXVn1cSPoV5R1B5xJsgwyUmFfWK7tQk6v7dpP7BIgWTjuCt/YR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(71200400001)(83380400001)(6486002)(6512007)(86362001)(31696002)(31686004)(8676002)(8936002)(478600001)(66476007)(64756008)(66446008)(66556008)(66946007)(76116006)(2616005)(110136005)(91956017)(53546011)(6506007)(316002)(5660300002)(2906002)(82960400001)(122000001)(38100700002)(41300700001)(36756003)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHQwekY3YVR0RCt1bTZhS0ZFZ3VyYnFUcWd1K0VhVjQ5NzZxdnR1N01wTzVs?=
 =?utf-8?B?eGxvL3gyejAxR05NNmdyWEJxZlIzSVFqL1FXZnJLSm1uQkc5MGY1NDhDMFpx?=
 =?utf-8?B?V1l5UmhaUzJOdVpoOUo1bWpmSW52NllZNmMrV3VnYmpMcXMyODhHSDQ0RGRJ?=
 =?utf-8?B?Z21UWlljZ1NOUTM4WjZYaXNTSHRybHltVDNwVmwyVHpuZ1diTGNPMVNTOEVP?=
 =?utf-8?B?NTNndnR6YTAzcFIvSVJOdkR4VHdNVUhleTk4MmxPdWpNSlcwTmhSR0NCa1N3?=
 =?utf-8?B?ZkFlQy9kWlR4aDRFL0loalJLaEcvVDV1S0FvQU5TanV0aUlOMjAyT05kdVhp?=
 =?utf-8?B?clJxUFJSYyttNGZLSHd1a3hXZW9VUXovS2pqYyt2OE5lOGtuZ3hjUDlIYkc3?=
 =?utf-8?B?d2VLNVdaeG5MUStwbGI0cmpCUXRjUkY3YmZRODl3ZzNsTi9Pem15VmsxSkxH?=
 =?utf-8?B?ZmQ4UzFWazBITC81MFYxTFZNbVNQRm1BT1BjUFhSd2g4MG5Ndi9FV2hlNVN3?=
 =?utf-8?B?NXJTYXZjZHlvVzlkVWlGZ2E0djQ0Q3JMZXVhaVBCY0t0cVJjQWJ6UDR2QVFX?=
 =?utf-8?B?N2x5bDk0ZzB0THBOYUowUC80Z1lGbUVzdDVWMTduZkM4ZW5SNnBod29LWnhj?=
 =?utf-8?B?bmNuVDhOeUZsaFAyKzIvdktob2hVVU9UTEwwMzJMOXgwSUtWRUJHNlZ2QlJz?=
 =?utf-8?B?aSt1SWF2em1iWHMraGR2eElmZFNKYmVvdXEyMkJNMTRiMTYzQnVRMldFU1ls?=
 =?utf-8?B?QlVENDJGMmVPSm50NVlheEZ2M3VOaVRYMXpxQ1hVSURIVWFQdHdkU2dJQzRE?=
 =?utf-8?B?UFVxV0Q0Wnp0MHlBdjhIbFNpMTlUbWorZS9uL1N5dUJ6KzBTazBHVVY4OUlN?=
 =?utf-8?B?Vk5uSDl0SThCaWYzemZXQWJsa01iaW0reUJ2VjRMS2tlQkJRdm9US1dwVWZu?=
 =?utf-8?B?Q25relhhRlh3VmFSUGlKZWxJV1hXQ2tWejlISTRwZk1FcEUvcUtLZWNPa1ZL?=
 =?utf-8?B?WXlIdkV5bGJUWXdLT3lHZjBNbW80Z2w3d0phMzc2NzhKVGxKakdVVnl5QkxT?=
 =?utf-8?B?QXdRMWFPVktJZ3ptcjkwU0RlZDd5SUhxanJ6UXZJZ0xCYzdRMGVlQUFTdnNl?=
 =?utf-8?B?UlBrb2NjL240Z3ErTXk5enNPdXNUZjZZYW1lMkxVdk1FNTlpQmtPUXVpY21F?=
 =?utf-8?B?RHBiaFp0bXFvSFF6cm9FZ0EvUWRudmtzYUpWQVh0ZHZ0SmUwNHVlMDBSY1dE?=
 =?utf-8?B?U1ZXWmdZRnlGQzNpSlA3d2dLTE90cUdGWFRTOFlGc1NTeWdTYm8zYWN5OFJT?=
 =?utf-8?B?MWY5SWJpc1NaQld2OWp0ZVZHdHY2RGdPVjVNYW5NU1pUKzJsc2tnbEl1THQr?=
 =?utf-8?B?bDl5QXpkTkMyTEYvZzI3YTMzYkFJbmVwa0RkUGZpRlBlVzYrMFJmWEt0QjhD?=
 =?utf-8?B?ZUQ4bTdxWnFoc1QyaEVJNmlBcERGa0xJTzlHdkxIQkw0TG53ZDZ5bkVMK2FW?=
 =?utf-8?B?RnE1OFRTaVcxUzJEVU1yeWZYVWl2MERvbmdkK3RmVVBiQU9PSWFOb2hhNXBa?=
 =?utf-8?B?eVJ3bkh0bzV2TVg5WG13cGY4UWNZODl4eENVdG9ydUg1UndkNktUMEl1UElV?=
 =?utf-8?B?ZlVMdGlIQXc5ZituV2ptVEhSS3ZlbE9TTHJqdU9oa2tvSkFrdGExZUZtTFpq?=
 =?utf-8?B?dStrZVpsd0ozVXR5UnlyaTQwLzVBbXlxZ3djUHRVNTVoMmQ4OHhDNWVKR0dn?=
 =?utf-8?B?ckpmTjVGaCswai9vZHpkRzJEVDhpU0FmTUpnYXRtMHlDZENydzVFd3lkTWFq?=
 =?utf-8?B?Y09lSi9ab0JRc0JLY1FKYXNQczYzWTRodDFhR0FkNkFzenBIZ2x0MFFrOE5a?=
 =?utf-8?B?SkRQMkRBMkFBalY3enFTaU9ENEJQa2FobjlmV0hMUlBjamU5cXJHZHFSaGFs?=
 =?utf-8?B?MG1zam9XQy9RbVVOV1duVHg5WEJlR3NWdDNEN3ZJd2pnajEwazhhOElETWJG?=
 =?utf-8?B?b3VtTXo1MzIwMGtaL0pTbTVLNllITmtQUHZmWnhFS1h5bjlwSmxWTDIzL3B4?=
 =?utf-8?B?VWJrTGhEbmgzczJZV0xNQ2pKNkdleHY5ZVM2RFV4RFZ4b1pZNTkxWVAwN3h6?=
 =?utf-8?B?ZFNHSEZvMkxWY3JuWDBsUTc2WDdrOXkwY0FsNWFGdzJFRTdOR1djNkkxNEI4?=
 =?utf-8?B?dWttYURXTG92d2UzUFZOTmZQRk1pc0tlUnRIMDVHWHFzb0ozQmJtWkhWd2oy?=
 =?utf-8?B?ejJlWTY1dWp4Ulc4bkhMN2xOcU93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88406C6C8047B04EA7DF2C4D7F7821A4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J91r5YFMnry5RQB1qJrAuKqC6nAvbciT34cVdtEu0Oxh2tk9mtohW5NDYYrejt0B4LbX4m9OdNGmqbLYXMFLvnfonXSH/dgX+a96LhuSOMXxzYp18oEfInKdS25ADgxX2SAoZS7kaj6pxwLslrel+6ClRZba8pQvl1XNXbjgcZdSL1Pg81KfsLablfsJvM/lbFnIX5MUBWXUDuCPj7OmGU9x63iTskkbVn0mCJTpgXknW9qfhrJyzp7+jqti7/hDu5nRIegT9Hb8DolqHJQv5BZPwhJhYzSdMiV6yGbs18DAHsDpEHhRaFDQup4c1rgfaloVnvCQw+aA0iTVf9+1myTUnkh2bYQi9SmPAF+NXM+glDS3c7gcjA8y25JCijdb3NzVizwN4O2Ibkw4g86F0Okj8dtwfNPnr0sDGSvoNnlUdDIL1qyi5kA1lvLgSShDmejIKR/58PL5RiVhsnMIAmqQ6XdnMmLY78BZvKOBGt5tztGNuyh+HnkpWqt7+TBw/y9OCnu9Ya/tke4BMJHgUZPiNHA0NJg4m+gyVFzPzg4UirSPI91PFYlxeLvgz73tR6HZ9iEUI0JbY9Vn4pIUfO7mH1WP/GqY+T4O+HQ41A/tz+KkkKsV6Ai/mA3ce4US
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68792d70-c632-4220-45f8-08dc1db8ad77
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 15:17:00.0764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwuWzYjbVbqGVylFR6g2EFsPan0LkpI/diMRTzK5/Lyg0MZK7HXPnLrIM/m/4gcbxY3xcWFwnBtpWq0EbLDw3KP2nwwk+bKJEV2EZ/EJ3d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7759

T24gMjUuMDEuMjQgMTE6MjgsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gVGhlc2UgZml4IGEgY291cGxl
IGlzc3VlcyByZWdhcmRpbmcgYmxvY2sgZ3JvdXAgZGVsZXRpb24sIGVpdGhlciBkZWxldGluZw0K
PiBhbiB1bnVzZWQgYmxvY2sgZ3JvdXAgd2hlbiBpdCBzaG91bGRuJ3QgYmUgZGVsZXRlZCBkdWUg
dG8gb3V0c3RhbmRpbmcNCj4gcmVzZXJ2YXRpb25zIHJlbHlpbmcgb24gdGhlIGJsb2NrIGdyb3Vw
LCBvciB1bnVzZWQgYmxvY2sgZ3JvdXBzIG5ldmVyDQo+IGdldHRpbmcgZGVsZXRlZCBzaW5jZSB0
aGV5IHdlcmUgY3JlYXRlZCBkdWUgdG8gcGVzc2ltaXN0aWMgc3BhY2UNCj4gcmVzZXJ2YXRpb24g
YW5kIGVuZGVkIHVwIG5ldmVyIGJlaW5nIHVzZWQuIE1vcmUgZGV0YWlscyBvbiB0aGUgY2hhbmdl
DQo+IGxvZ3Mgb2YgZWFjaCBwYXRjaC4NCj4gDQo+IEZpbGlwZSBNYW5hbmEgKDUpOg0KPiAgICBi
dHJmczogYWRkIGFuZCB1c2UgaGVscGVyIHRvIGNoZWNrIGlmIGJsb2NrIGdyb3VwIGlzIHVzZWQN
Cj4gICAgYnRyZnM6IGRvIG5vdCBkZWxldGUgdW51c2VkIGJsb2NrIGdyb3VwIGlmIGl0IG1heSBi
ZSB1c2VkIHNvb24NCj4gICAgYnRyZnM6IGFkZCBuZXcgdW51c2VkIGJsb2NrIGdyb3VwcyB0byB0
aGUgbGlzdCBvZiB1bnVzZWQgYmxvY2sgZ3JvdXBzDQo+ICAgIGJ0cmZzOiBkb2N1bWVudCB3aGF0
IHRoZSBzcGlubG9jayB1bnVzZWRfYmdzX2xvY2sgcHJvdGVjdHMNCj4gICAgYnRyZnM6IGFkZCBj
b21tZW50IGFib3V0IGxpc3RfaXNfc2luZ3VsYXIoKSB1c2UgYXQgYnRyZnNfZGVsZXRlX3VudXNl
ZF9iZ3MoKQ0KPiANCj4gICBmcy9idHJmcy9ibG9jay1ncm91cC5jIHwgODcgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAgZnMvYnRyZnMvYmxvY2stZ3JvdXAu
aCB8ICA3ICsrKysNCj4gICBmcy9idHJmcy9mcy5oICAgICAgICAgIHwgIDMgKysNCj4gICAzIGZp
bGVzIGNoYW5nZWQsIDk1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KDQpMb29r
cyBnb29kIHRvIG1lLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQo=


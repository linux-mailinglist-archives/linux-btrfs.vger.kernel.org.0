Return-Path: <linux-btrfs+bounces-12146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F06A59B2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 17:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033A316CDE4
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA731230BC0;
	Mon, 10 Mar 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qwwCwyq+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z05znMOo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1A22DFAE
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624710; cv=fail; b=nRPQAEenpFjVsOmLoM39JbzvEAWu9jjap2bU9XyypTjUW/FPgJjM9hvq/TGY1V4Tl2rlrx70SRGbJ9cPjUa488rYFtlPnm/PNlvhcmhWMmjhRjgVi64QlXXYHmCA8CF24GCBNPiPwjrMNR8Wv8gm8besidd3AkhFlXQEzZ27AGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624710; c=relaxed/simple;
	bh=LmxWj9Ax5pbxZz5KbITyiPuz1mDga5gcAJ2hDfJKTao=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YHh2IHm74xpy5ZVxnOmEtyuZEIb29BtFOZnjQhutH9jMtJOenRu9agevW2HJKIF7zD7AcbP6ZRtuNFnwjsQ7t7ionerE3+0Uc65zvMPtf1TzIdEj6GftQewvanGKybnoMcPWJUs3C23ntcoS1+zdRaVR1w5JXqZ9vl7hpYp5W2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qwwCwyq+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=z05znMOo; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741624708; x=1773160708;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=LmxWj9Ax5pbxZz5KbITyiPuz1mDga5gcAJ2hDfJKTao=;
  b=qwwCwyq+oxZe5cDbIaxKYiLY0rc5fdmKw52q9TKvd3gcWXoV0BO66pJK
   qOweHWL8FWWWfUaYuJJGOfvi2E7Qv6dayzc4ApGDPo9WyPfvVH5iQ+4R1
   9+dNTMK2tcoXYf+5R2u6MDoXLSw9AoEmKb12H6VhiNAf0cgES20VqccVL
   UnPN6uHraJpJ3sEjy5BLEdb9y/j5+7mSti83T4fFDMInDln4fxloCoRjM
   3dMGmz2omu9XGS9x7VLwn1rfeawpf21LffLPruh3gTx3S7Wg/Dozd9R7S
   xI1ZET6tJfGtAIr0D8MdcBFumA8aViL3MISVTo8uwsEQrUcfdULMyhZxe
   w==;
X-CSE-ConnectionGUID: 59KkVeGqTHiB4CCvOSEx2Q==
X-CSE-MsgGUID: 0RfMvxyaRYKesoH7i8pk/A==
X-IronPort-AV: E=Sophos;i="6.14,236,1736784000"; 
   d="scan'208";a="47025785"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.9])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 00:38:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrFjnrO2PqyvnYjx8j2jgW6sm+thLy5qb+R2+mgJ9cUYvAcUj1V4ltc8lOpnr6nHJzpd9UiXn7rF+ecyPcCJHVLxsTpKPPrxq0cghmcWI+M3B/UGuDVdGHlUYTFNKoJwmwurnnb+O96bAnkWpiDglj8ivIN6Yco5Lg0rKUR3q8Ycd74QR+XN7ReKJmMOaSWMlihpbtBKO9E7aqMEQvQFfnBtE2lZvQDYC/Ft0LgkzGdB7Y6ISUOOPS/7E6x2gUxH01l1EYKXd3mwKDUeUiU9qG9IgOKLr5wIS6ocWXsa+SWNNhklTG9szvWYBQ4Hvo2VkHrooJDW4Mx/k+aTgoWvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmxWj9Ax5pbxZz5KbITyiPuz1mDga5gcAJ2hDfJKTao=;
 b=QsWKLM8PlATUB6QWj5RX86bhZ1/cbq2nVwxIeofhyczy48iYFhfvIdkhHg0TC7gSkcqQ2Or6JxvVLDNJ/2bb80BvhqmenCbkpaR7QH2RomZOS2bTOqyN/ZpVuPnYsl0BYUWGQreuw2xYAdJIL13zBXpzaGDWq5M1Cv4FuEN1gpWE6R91exp4rn3P9ya5ryhFyKof1pfadLNRK3cku2U+i1PTO7+pLq5xbBZdgHvNhxY7mCFa5wF9TakyEaKs7J5biELGmgSXOi1PlD8wmjMcWgzZFaoRTTqMbaCVNda8kFXrlTfgsY7/ZUIA2mIAHmK0XC46sCmKkByYTkfkx+girA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmxWj9Ax5pbxZz5KbITyiPuz1mDga5gcAJ2hDfJKTao=;
 b=z05znMOo37ExCy/hjDSYRPAeYt8BcJiR6XxoOsBiBFGoO24TelMq7VEujl34Pppqw9pI9VTlqq7qmRKm818PIpowevvMb47r2vBVxMaX3kLcGs2ySZzd3mcKT2TxEWT85bIakZJdteSd0uBY9NXG2u6qaK0sFKCVJ3QCrh12mm0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH7PR04MB9643.namprd04.prod.outlook.com (2603:10b6:610:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:38:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 16:38:25 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 2/5] btrfs: add new ioctl CLEAR_FREE
Thread-Topic: [PATCH 2/5] btrfs: add new ioctl CLEAR_FREE
Thread-Index: AQHbifAHCHzTK5C5HUi1T6V31LgHSbNsoc+A
Date: Mon, 10 Mar 2025 16:38:25 +0000
Message-ID: <0cb33e7e-4390-4647-a277-221f9ddf3640@wdc.com>
References: <cover.1740753608.git.dsterba@suse.com>
 <ecc43a72997ae7836c2d227b69924d364698e665.1740753608.git.dsterba@suse.com>
In-Reply-To:
 <ecc43a72997ae7836c2d227b69924d364698e665.1740753608.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH7PR04MB9643:EE_
x-ms-office365-filtering-correlation-id: eb04ffbf-88b1-4c5a-da14-08dd5ff1facb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QU5Qci9uZWVxQ0J5WndMaE52ZkFTOC9RM0IyTGNwSE11NG5yN0t5SEx0QzlP?=
 =?utf-8?B?d0dWc3kyZ1VINHNMQVhKTDcwdWxmTGpuR3NZcUI3TmFGTXl2U1ozS01adFhu?=
 =?utf-8?B?NFZ2eDZFNER2c0F1eW53MTZ0YmxGQ3BOdEU5VTZDV3RsZktuRG1GaG42WVdw?=
 =?utf-8?B?NXQ5eWJQelJFU1U1Y0d5TDBEWFhhSzJrSW9SakE2UnRlUUVxcTdxSjBnVnk2?=
 =?utf-8?B?NkxMai9jU1BhVHcwaEZGZ2hoK2hQd0crSERrYTZEK2ZtYVJKa2FZVjFXamZJ?=
 =?utf-8?B?bWxuemtFQTRyU2ptVkw1Mlk4cmh4OWxPUFJtMExzNlRZMVd0dFgwMFZubm5r?=
 =?utf-8?B?aWtKcWI4VFQzVGxyMGZ4VklTczBCeWhZbE5EdCtNM1BxblpnWkNlbVVrQ2FN?=
 =?utf-8?B?dFlRZ3U4TTdrV25jUjFxSkh2WlVKNlNZTFVub25qSnFub3JTZVhxa0NReko2?=
 =?utf-8?B?Q21rUjMyQytTZ05hT0EwMCtMbWcyblhPYlZJdGp6VzFMVkIyRDhsS2ppWWpE?=
 =?utf-8?B?amxick1DQlhZdzAxTURPYTZlamdPemkrRit5TlQxbGZaZlVMRDRSR2V6ekky?=
 =?utf-8?B?U01yL3duUjJ2bEhXcVZ2MXF2TjllWThnMUNtWlNmSWhDVzZJWElnZkt2L1pi?=
 =?utf-8?B?T3BiRVdzRi9OQkNwcWVCQ2s0cEM2UGM0KytVK3N5THhlTHVUbGJaK2NjMUZZ?=
 =?utf-8?B?RmMwUkN5MVBzcW91Z1VadDZjbE5tRmRCb2hwRk11Y1JUalZIekNnY3B1NzRK?=
 =?utf-8?B?Y1BobnkrZ1c3NlFkVEwxS0N2Mm9lUG5XUXRGUW91cmgyenlvQ0JmVUFseXJM?=
 =?utf-8?B?R2Jrb2puOWFTQ09lNUdNd2Q3ZlFkQ2RHSG5jQU94UXJvYklHeFhwLzZZTEVo?=
 =?utf-8?B?OXJncWZWemNYWkJTK25hRm42QUJiN0dINDlmbmhOSXZ5WDBqOGxOcGlNcXdn?=
 =?utf-8?B?aUg0bzBaRStEUis4V2dtdlpPaTdEcW9ocERmZWNRWFhmcitrK3ZsNHZZMEdh?=
 =?utf-8?B?UUgxeWxzZWcrSndPTFlRNG5rMWh2QkQ2Z2VLUlNTUTYwcGJNdDJmYTRJbldm?=
 =?utf-8?B?U05iTHFjLzNnWk0wU2dFWU5iODZxckRlek9ZS1M5REtjRnRWazU5c2ZTMjNS?=
 =?utf-8?B?RnNuUlIrdDBFNW5pZGZFRkhpVFlDZWJkM1ZWVFpCOWpHdkpSTFpjY29qVzVy?=
 =?utf-8?B?bUk0VEMyU2FFbW9sSkpPUWE0SG1idWYxQUJQWCs5ZVlqK2RBVVZiNkEyRVpQ?=
 =?utf-8?B?Q3FTSFBjdWhueUJhNC90WXpXU0pvalZBTElpWForKzJsYnd1MThkU3E3ZkE5?=
 =?utf-8?B?QnpCTUo3NEt1UmVDdmF3YnIzUm9iaHRLSEZEYnAwdDlhY2VUZG95NGFEbmY2?=
 =?utf-8?B?T0tqZkg0MXV5cm91NG1VTnlkZ1IzZEZUZlFvb0pIeDVUajBmSzBob2Zjc0k1?=
 =?utf-8?B?RXBWVEhZay8vVlJDd2ZxcDRpSW9RREk4VXdlbWxQdXM5QVRsVFNBaWJIVldQ?=
 =?utf-8?B?MXhTcGIrWW9JMExHQWc1aE1URlZXbkRWYjFQWXhpTjJpM21ENHlBdG1vK0Vv?=
 =?utf-8?B?VGk0T1E0WCtHOFFHQUVmMS9TVi9sb2hrTENlVWkzOXp6Q0NheHJBUHlsaDRu?=
 =?utf-8?B?bjUyVlNvekp5ZHdyYnJocjJ0Z2kxK1JldDB1bjhXbjFqV0VDOUxjRnBHTElj?=
 =?utf-8?B?MTd6Sm0vMC9CS1JwVHRVeWRpdi9nd1M0amZrWmltcWxOcjVlVTZlTDJxbXRO?=
 =?utf-8?B?V1pZTGZkcGhmdG5YUmFlbThjbWF1UkZmL0l1U05ZY3FDeUtZT29vL1RVMXY0?=
 =?utf-8?B?ZHhTMmNiUU5ZeEsvUmdHYSsyck9yWklJeFA4bWltS041MWhXcUhqTzlPZzFn?=
 =?utf-8?B?bGs2N01Na25Fc2NHVWhidFNXc3IzWnFWMXQ4OEE1eUsrazVrOHdJTWhYNG9H?=
 =?utf-8?Q?D8jCJp0nhcPQqrirsPhcx8hxBxbwrHvS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejA0Y2dmQUFGV1pXdFhCM054UXhnSVc1MzZBRnRkeDV4TzIxTEVKalRGOHdQ?=
 =?utf-8?B?Tms1OU15YndRaGtpUHFYRVpMZHIzNTdjVUNQSGdZTENtNzlUVHhOU1oyZ2xG?=
 =?utf-8?B?Tm5POGR5bFlYWDRPSm5RajQzaDRQRmxBWHp2R0MrOVI2ZCttUzcwWTZudkZm?=
 =?utf-8?B?d2lEUE9hdE9yRjZqRUdYaEdyQ3JLVjg1WFFZdm5xOXpvTGpyNml3OVJBdVN4?=
 =?utf-8?B?WjNKQWRJZUhrQTBHUTJ5RzhlSitqOEJvQ0VJUThGVUNIU04xZVdob3RLdlU2?=
 =?utf-8?B?WHZUY1JwY0ZFc1plNUcvMzZsZ2NHbFI1aWFlUE9GVDkycWRTNVNnTVVGY2U4?=
 =?utf-8?B?S0xId3o4OS9KSERHMklYalpac2wwRWtUdXVVQ2lXdndpVUMxd0F1SGprM2lV?=
 =?utf-8?B?NmR4eng3Yk9ZeDU2NkRjelZmY0liUHZ0c1IvMVM1alBxRDJNZjBQN0UyMVdQ?=
 =?utf-8?B?MEV5by8yYzFPYmxoNjA1N3BleTRXUTFwZ09DNTdZZEhOTTkzcUR3OXlLS0ZI?=
 =?utf-8?B?SnlDOFIzL2tMRWFPUTdYVkF6dnlBemw2SHlUeWo4Vmo4Z2d5dkZ4cjVkOU5P?=
 =?utf-8?B?SmJ4NGZNcmxDdmUwSzdFajdHT0s1N2tGRlJxSEtsTlVGdXdEY0I4ekw2RkJB?=
 =?utf-8?B?a2haa0RBMzMxbDlzenhyd1FrYzZuU0toajR0RUdOMksrUUNqVzNTNHhaelh2?=
 =?utf-8?B?QlhVaU13bkV6bVRTMTVMNWJpSEdlZEQzZVc4eUhEQ2w3b092M0FUVGpwYk1L?=
 =?utf-8?B?LzZiUUxwZ3htcGhSWS8wY1Y5bXJHRkRrcDYvdk95MEVKUytvcHdBczhPK2Nl?=
 =?utf-8?B?bHdxN1Z3SkRrdXEvd0I5WDc0UENlRE5xTU5tMDB1UjQrbklMSmJkZ21nd0JW?=
 =?utf-8?B?K0UzRWRnWEVib3BmTHRISktqWXc4VGF0TERUbWFLQWJzeXhDb2NldHRlY2dS?=
 =?utf-8?B?OTFwUld3NmVJeEVCb0s2YXlmZkdLS1BZRVJkemlTbjhmbHVGbVVMWGhmcC9p?=
 =?utf-8?B?SzRRRm15YmNzNFpmNjhZYTc4d2ErN0h1eE1JaXFnNlNtQ1hydEV0dzNXSFk4?=
 =?utf-8?B?aWVJeGFiR2RzODZXVzhacjhGSWN0Y2RETjBQNGk0elkyb3l1c0dGQjA1VGlN?=
 =?utf-8?B?bmxUTHFNTkZ0clJuQkRFN3c0MlJaeUR0TlcyanBNQzVnVmx0RVgwbGQ5RkE4?=
 =?utf-8?B?aUdxY1I1NEVrZUdPNzlubUZlbUdVRFVXaHFYRS96elNVaWVMcWlOd3ZzOUN3?=
 =?utf-8?B?dVMxNS9jNjl1NVMwS3FqVjRXZC9vbVdoRFVvMXp0emtCU1FENmFCUnBPSUpX?=
 =?utf-8?B?MkNlbGFxdllxMG9jeVFlaTcraEJsaGVLL0M4RE91ZG9kSkxabGlQQklzM2Fw?=
 =?utf-8?B?emcrcTlFQnMyT2Z2ZFJ1SkdKdERIeXdVa0Rpd1d0V25HUDhzbjZmbFVrMGhO?=
 =?utf-8?B?ODc2TVhVVnJWTERKTWg3K25jYjV2aWZMOXEyWUdGc1k5UVdtQlRJRFlick1t?=
 =?utf-8?B?a25DS0oyMENlYVl4NzZYbnhLK3JjUlNrRWhYdWhCMDNrREE0SnJreUNYMCt1?=
 =?utf-8?B?Mi9tbFhRYmdZWVNscXZBcTZJYVVGNWpQSVhUczdHOUNCT25EOVE1Q1RBOHlF?=
 =?utf-8?B?SXlwejhBME1HWXhZSXhTK1VBbVk3KzZiakxjNVZyd0RJbU5zcTdodmcwUXBt?=
 =?utf-8?B?N1ljYVRVbUhlVmg0QUtQTjZBUlBDVndidXpWdDNMWEhKSU12VGIyb1l1dXBB?=
 =?utf-8?B?R3htdXFiWUdqbFk1bE5GRUxuR21NT0Z1WW1tK09IbjRsc1laUmpwenBHZ0t1?=
 =?utf-8?B?SUp2TiswOFRSVDFWWWQ5Q1FUQ1hJOWNsV21reHp4WnJtdGJWanl5NGlMcy81?=
 =?utf-8?B?THNBZDJJSWl1RjhzSGU2b3ZycVRUbmdLRE1VZHZBQ3BwRWlrNGx5SENjU3lU?=
 =?utf-8?B?WXZXMmZtV0xPaUJPc0MwMHFTNmxyUUlscjlhVTZQdXRBOFNVd2NsWTIzdm40?=
 =?utf-8?B?TlZrS3NpL2dQYVAzcU52bTQ0MXdvQWdMTDBwNnFaQkZGc3U3U1cvUFRNcDhV?=
 =?utf-8?B?RTlBaDlqcEtQb1hNUmpPZWVpZUFSOFdVcUVWcTVncXB6cjFxQkM4bDVHSGdZ?=
 =?utf-8?B?MUZTUDVaOUh3RjdLSWJlTE5zazJDdlorcFVZaGwzVnJMdDZkR3dKdTZTMnVs?=
 =?utf-8?B?V2ZwZ3diMVIxQVB2WTFzRXhpekQ2dkYwNUhqcVlMQ0d4bFd5SWdUMWZQVkox?=
 =?utf-8?B?cUxkUDRpTWpWSzZnT25UTzZGRDVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4F7EB16A2716C448ACB3EA5386A4B45@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PmB4Ufv9KxM29xLOm6f2k9NjQPA4haVRKQTkvHuQaDh4R+SjXt/3vx4eSXH40PLz6mlxhnKBBCEqTOUy8+tzOGl+G0dGprzQwy26RKuy/rOIXoBMvPFP7j/IWkyUebOCr/Bpnf4iacsO7b6qHPyake+BW8fLUoDTVBckHZuK129A9zpFi0hkFd4ulcR4xfaVqSD0dZCF9InIuc92oL/L6aaN5UJ4fLl2jI/bWS2Qb3BtVQDqga51KQsYiyKxaw9eAFcue4/esEa0TOlYiQKCNWiMKpYVnPxL3bDalIgm6SqDCBnzXjjysCv8kpJHTZmgO9+29uP67NqcZITpH8xkpQSFi41+xIxTw4wumwvTpnjOS6auMdUu5lpJuCZNDSHnNm2FPvXYNQAfbXKMD/nojvB9a9tB46NREzo4/GjOZEAsj0Dwl6WE2p/4wobA9Te0Z7ienq9iQVonRjq/4KtUH20+YxmRHTV+QG8zzcnwAk4NRM8DmVxWUqMVpOtrti+cpjhBNN3icgM2nA1JPQgmh9ahwI3tCt+vf68ztd/9NYrCox0anPwdZhKqoiDo1KIAleZzoMoS3SypMFQAoNQ9ZhTwY+FtuThtXSIFekAXfMWnm3q1NYxtkTmywguFQ6vg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb04ffbf-88b1-4c5a-da14-08dd5ff1facb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 16:38:25.5353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iebvus3NWRR7NLos/WMuzR5guzglexKKVYr3bZe/fyprHMRDZaTskv92Pq358B2sg+wJYdOYiOOJbuWW0b8+T/XHa3wS1g70Vi4SWCmuTd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9643

T24gMjguMDIuMjUgMTU6NDksIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gQWRkIGEgbmV3IGlvY3Rs
IHRoYXQgaXMgYW4gZXh0ZW5zaWJsZSB2ZXJzaW9uIG9mIEZJVFJJTS4gSXQgY3VycmVudGx5DQo+
IGRvZXMgb25seSB0aGUgdHJpbS9kaXNjYXJkIGFuZCB3aWxsIGJlIGV4dGVuZGVkIGJ5IG90aGVy
IG1vZGVzIGxpa2UNCj4gemVyb2luZyBvciBibG9jayB1bm1hcHBpbmcuDQo+IA0KPiBXZSBuZWVk
IGEgbmV3IGlvY3RsIGZvciB0aGF0IGJlY2F1c2Ugc3RydWN0IGZzdHJpbV9yYW5nZSBkb2VzIG5v
dA0KPiBwcm92aWRlIGFueSBleGlzdGluZyBvciByZXNlcnZlZCBtZW1iZXIgZm9yIGV4dGVuc2lv
bnMuIFRoZSBuZXcgaW9jdGwNCj4gYWxzbyBzdXBwb3J0cyBUUklNIGFzIHRoZSBvcGVyYXRpb24g
dHlwZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFN0ZXJiYSA8ZHN0ZXJiYUBzdXNlLmNv
bT4NCg0KWy4uLl0NCg0KSSAvdGhpbmsvIHdlIG5lZWQgc29tZSBleHRyYSBjaGVja3MgZm9yIHpv
bmVkIGhlcmUuIGJsa2Rldl9pc3N1ZV96ZXJvb3V0IA0Kd29uJ3Qgd29yayBvbiB6b25lZCBkZXZp
Y2VzIElGRiB0aGUgJ3N0YXJ0JyByYW5nZSBpcyBub3QgYWxpZ25lZCB0byB0aGUgDQp3cml0ZSBw
b2ludGVyLiBBbHNvIGJsa2Rldl9pc3N1ZV9kaXNjYXJkKCkgb24gJ3VudXNlZCBzcGFjZScgb2Yg
YSB6b25lZCANCmZpbGVzeXN0ZW0gd29uJ3QgZG8gd2hhdCBhIHVzZXIgaXMgZXhwZWN0aW5nLg0K
DQpJIHRoaW5rIHRoaXMgbmVlZHM6DQoNCj4gK3N0YXRpYyBpbnQgYnRyZnNfaW9jdGxfY2xlYXJf
ZnJlZShzdHJ1Y3QgZmlsZSAqZmlsZSwgdm9pZCBfX3VzZXIgKmFyZykNCj4gK3sNCj4gKwlzdHJ1
Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbzsNCj4gKwlzdHJ1Y3QgYnRyZnNfaW9jdGxfY2xlYXJf
ZnJlZV9hcmdzIGFyZ3M7DQo+ICsJdTY0IHRvdGFsX2J5dGVzOw0KPiArCWludCByZXQ7DQo+ICsN
Cj4gKwlpZiAoIWNhcGFibGUoQ0FQX1NZU19BRE1JTikpDQo+ICsJCXJldHVybiAtRVBFUk07DQoN
CglpZiAoYnRyZnNfaXNfem9uZWQoZnNfaW5mbykpDQoJCXJldHVybiAtRU9QTk9UU1VQUDsNCg0K
PiArDQo+ICsJaWYgKGNvcHlfZnJvbV91c2VyKCZhcmdzLCBhcmcsIHNpemVvZihhcmdzKSkpDQo+
ICsJCXJldHVybiAtRUZBVUxUOw0KPiArDQo+ICsJaWYgKGFyZ3MudHlwZSA+PSBCVFJGU19OUl9D
TEVBUl9PUF9UWVBFUykNCj4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiArDQo+ICsJcmV0ID0g
bW50X3dhbnRfd3JpdGVfZmlsZShmaWxlKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0
Ow0KPiArDQo+ICsJZnNfaW5mbyA9IGlub2RlX3RvX2ZzX2luZm8oZmlsZV9pbm9kZShmaWxlKSk7
DQo+ICsJdG90YWxfYnl0ZXMgPSBidHJmc19zdXBlcl90b3RhbF9ieXRlcyhmc19pbmZvLT5zdXBl
cl9jb3B5KTsNCj4gKwlpZiAoYXJncy5zdGFydCA+IHRvdGFsX2J5dGVzKSB7DQo+ICsJCXJldCA9
IC1FSU5WQUw7DQo+ICsJCWdvdG8gb3V0X2Ryb3Bfd3JpdGU7DQo+ICsJfQ0KPiArDQo+ICsJcmV0
ID0gYnRyZnNfY2xlYXJfZnJlZV9zcGFjZShmc19pbmZvLCAmYXJncyk7DQo+ICsJaWYgKHJldCA8
IDApDQo+ICsJCWdvdG8gb3V0X2Ryb3Bfd3JpdGU7DQo+ICsNCj4gKwlpZiAoY29weV90b191c2Vy
KGFyZywgJmFyZ3MsIHNpemVvZihhcmdzKSkpDQo+ICsJCXJldCA9IC1FRkFVTFQ7DQo+ICsNCj4g
K291dF9kcm9wX3dyaXRlOg0KPiArCW1udF9kcm9wX3dyaXRlX2ZpbGUoZmlsZSk7DQo+ICsNCj4g
KwlyZXR1cm4gMDsNCj4gK30NCj4gKw0K


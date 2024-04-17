Return-Path: <linux-btrfs+bounces-4345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9E8A8213
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985471C21F1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83BA13C9AD;
	Wed, 17 Apr 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AUsTpGPV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cjVxRy9/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA713342F
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353276; cv=fail; b=gq87JZslEMHk+bL2Hllfo9WkN7wKSsDSg5u0zBV8Ni7kkD2WhUtKW/raB1QC4rJ/PWiCTsuFrKsp1X5mPFurprFCg2+/dQLaNMewwaAxPuDNeDQmt8ea1yLB9dO5Pp/jfLn2W/8d7tV5txP7fiwuLtZzWpXu87ViHBUQwj/S68I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353276; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fgvBZMd00M8Ujq5mZC49lPOD1cH+2/GrjRnlrZVUMRuFWptlhYdClPdE43wp4Rp0ztR4HEmIVYELtxRzp9DDbaVtaRTSxWOSJnMEjnIAZHicPSjTK/jeaJ7/+p9Py63z4GoVOBBT9vNlZ1a6c1btm5fwgsuzXxR0UUBRzLQOul4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AUsTpGPV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cjVxRy9/; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713353275; x=1744889275;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=AUsTpGPVUUt9F6UrtZonbApW1wq95r9N3rbTv6ufbO/pQ2kVq8vaNJ1D
   mpcJ43EHbtwDJLtHK4rFT7IzVt91PlPiL4LXS35eVLe1X3vV5dzq77asU
   OtLA1xRDnLSenNhGOnhVBy47XOMA8pRcet80hwrJU1NYKs3sw9kg0CMni
   jyhZ/AloKsg1EaaBAZ6VE/XHywzNLhX6ZOcAWa7xsOpGNaXhpaI9KB2l5
   j3itBaxQIeyWsMM8va+mjr/WwTuAqbr0/Rg0ballhOklS7DrhVCitB4sW
   FVVaF4/qbRXtbjUlrSO56oridnV9hKddh/5BGOxfw+zSbUh9d+jE8q+b2
   g==;
X-CSE-ConnectionGUID: 46bWf+ovQPq4XrxX6ytAOw==
X-CSE-MsgGUID: rW8d2olPQpuTvDmDXR1CTA==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14216403"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:27:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6ZcrL40IJSwHXWnydIJTp3Y1GXrmMEQ7OY2zBYAbmHqeHOfYiN3jlm6bosrJ/tGWC3UCSUNdVE8a6w+j+EMaLWFI5BFF88+9qKrPKPOpvceHS9POjeioDdNFk0wf/jkZL2vE8LKNqvHI0tUAiWX9VEvs0jjT4Ric/PJY4sj6kpbDvj5rWSrv9ur5C607FEjO5UVbT6FeqEMUB3c6sy2a638hazOVkXKAsJKT6J4Y9MNNqX3ZXwTpHC9RR5xY3aumADtmej0rdtJK2kUSC2r/+EL6A4hVU75xcCbU/9bHIJWinCseMxGiLIdlbhJuV+uqH8JgJD+ImPXDoXrQql45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=DN/ONbV4GsHd3W4UFDOkAlCukmZoXmgICpGjKlQS/CdJvCqyeBX8DEZjYZRkw+zT3nfzRe1dtNrs7vSOR8kNp/FAx3rabAwxt+PhudOwbFEjlv6WE/eua+a99w28WHd5VToQmvyYGQXpj6tmYXzRVr0G7a9//OKx19FG4NKlogFgBgQ+X9mCIlHSiaRReRwVYA/1b2kP6i6ivTC0xZGUjzoUnUVFsFCKEDBTA6r7GZYtrTgFAThSK/cgcQoctmRz9yahYr3i1PcTP9bEldIGiC9cYIa4/58Il/yiqr+DMMgJz3O0N4eHA2tFYpV8ngKlv3OIhZ584r0GNWO30ZuhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=cjVxRy9/QDodaD7ZpbB7Ej9hOUgcqLN8JFamTJfy5Lx/PZdtEtywwv3xBrslPDXjiqyXb7E5gl++YQ9x7wa8EDkhK7YxsVW8Auv/p9krQnkhQPvSEDgP27S8oP5ENS5KzwsXalGsB6mIhPUuTopBWVSm60CBb5T7viRiUdGqs9g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6797.namprd04.prod.outlook.com (2603:10b6:208:1e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:27:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:27:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/5] btrfs: make try_release_extent_mapping() return a
 bool
Thread-Topic: [PATCH 5/5] btrfs: make try_release_extent_mapping() return a
 bool
Thread-Index: AQHakLc88/eNrfsZ9kytsxoq1NT7hbFsUyGA
Date: Wed, 17 Apr 2024 11:27:51 +0000
Message-ID: <512b9190-3d08-4606-b6fd-ae3a55162085@wdc.com>
References: <cover.1713302470.git.fdmanana@suse.com>
 <49e09cbdb4c54f8b383bf7f21a1678cfbdc12e86.1713302470.git.fdmanana@suse.com>
In-Reply-To:
 <49e09cbdb4c54f8b383bf7f21a1678cfbdc12e86.1713302470.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6797:EE_
x-ms-office365-filtering-correlation-id: 5a3580fc-b93a-49c7-75ee-08dc5ed16b26
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ojBJ94ic/DJLv1wbaa1EvhzyqxwNXQeJHgDgM3mNSxB3ImYmOSPVTtG/PoipthyxniDEbSg4xK6mJD07YALQ0c1FW7/DSPwg538honMlwjy1n8hh5dyz7I9mUGHMHfJN3GKmPcqdXkGc5VB29SJpO6ozuO4yybT3gf8HRRkS6wJ9ii9uaOs5XikeyVTWvawEuzp5bB5oV1FVPcoIaPLBfUWyBFAfhlhiGJSV+oZHYfVXGJWpWHQSvEAaggI3hdgo/gifkmUlDfHMCIjZqQzdOSL0XsHQjZZB56b1tQ/SHOvDDzXbATaNvMendHUIjgxcO7vTjf/tvJN/3WhnOCHA9SfsT2YpYeEyC5PGkw7CZ1gSc6Wb6wad57xe0uCZKRmUuQQ88EUZFg89T0ukC4lmMOFk6tTbbTEdyQCxLYu8aPZIpN2xljqBfeLcWv0H9bNn3fchSvRbsxcnWEFvq7320wSpXe+t/GVfbAzNwzeRCeS66T4/IKGr8lmZeLwPgEjzWY/bs4BvYK6FWPklZDFupIUcG5DWMZ+eSz5m7HRwcEprppYPs2eYbqO7Tbr0r2VPinQz48SvoC/d9Bg+0DIDCu6UJtOc5Q/J5qwZOm2P1CuwWpy5jujJDyjtgS9WsX4yePIIgeV3H71Hv9fy3MrEd28zt4td2tPKYiya/JH8LGBukGq5q+rhj51YxT/vvBJIx6hVza88+q0adRKV69D3eMofbVBMMiPPY+c7xyjaNOo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEFnNnBBdFJnM2FyVTB2bis3UHZ1Y2Iya3g0QUtkQ0dXdTBmWm1iYy82cUMv?=
 =?utf-8?B?Y3ZINm1LR3l6TVV1bFYzSTJLcVBQMnlzWlZad2dYZFFEVmswUTlCYXlCLzNF?=
 =?utf-8?B?K0w2NW1uYnoxcXdFeXlyT0lSQVJuaXVpblBRZy8zZVNINFQ0RGZ3SW9GbGVi?=
 =?utf-8?B?bGhKQjhucVlTQjNlemhTZkxHcWl2Mk1BVVp1OGY1bTF4cEVxM3VMY2lsd3dQ?=
 =?utf-8?B?dmV1YjFiamhmOTJsSlJoUHVDdVRsQ1dOdHQ0eFZMdDZ4bjFVYW5OQUZZQ1FV?=
 =?utf-8?B?bm1SdjdycjRnaEE3TEJoT3dFWURoa3B6YWw3L1poNlpjVmNMRytrM25hSkZh?=
 =?utf-8?B?RmRKWUs4RkRLcG9yVVRWWVNpaStTcUdlaW90V3c5UHhSK25SRFZYVWJHTFlD?=
 =?utf-8?B?Z2s4Q0dpZks0VWJMOFEvY2F2a3ZSQ0hXU3h1dExsVzNBalo4SzlUKzVBTHgy?=
 =?utf-8?B?MGE4Q1FkbWxHRFNRWDREeiswVEFMTndwMlh6SGlmSzdTZ3BleWRSYko2UEpi?=
 =?utf-8?B?RENUUElEck0ydUtndmpFZFRoOGJ1MS9kUXlSeGREdUFDUEM2NlkwakhiTmhN?=
 =?utf-8?B?Um5HV2xodFBLQ2hXdmdOL3JyRjFLbndoVFRjT1BTYk1oVmxrTlVpSWJrSFdr?=
 =?utf-8?B?TjNYcGN3ZEdFcDZ3M1lKRjhQZm9iVlRKeGxrRG5zN1h2UEMzZkY0Z0JCTHN2?=
 =?utf-8?B?NmlvUUhzWld0amw3SCs0VWVCS0tkTk50N0NNUDJsT0k0VnVkWFBNc2hHSlFT?=
 =?utf-8?B?a25Hb29qVG5LMHB4UUhyZVlHTEJ6amdZYmJmeThaWVIvMFQ2TXZHTFQvZ2c4?=
 =?utf-8?B?ZjlIVFNtRlppZDJNTDJmbTlEU3JxQ082d1NPcU1wOFJ0bVdDaUFxaXJiSzlD?=
 =?utf-8?B?eVQ0d0ZZdUgzeXIwS2tGNE5vNWkxVjJQejN0cU9GUUIxVlB1eWlUQW9zSmdh?=
 =?utf-8?B?WDgwZ01CUkloMXpaUW1LMnJSSWgyN0RQaERPZHlUdllWc1B1aEpZUUkrZFdL?=
 =?utf-8?B?UGhUTTI3SFIyVm1ZRzJKNW44MDZhdTFzZEFNV0tmMkpZQ3ZJSEtSM0VBOVhH?=
 =?utf-8?B?WTluUEk2Q1ZQS0pmZ1A2VWVWVjh6ZWhmZWx1SUtzZG5IYzJoV2JRV014dm1C?=
 =?utf-8?B?RVdDRlJrMVN5VldCTWxNeDc4SHNGNkxkZTJWWHJFOXZBRFlidlI3YXBBQ0d4?=
 =?utf-8?B?Vm9ldUFqclhPVng4MmtQdWxWNGsxWDR3a3loeFNLVzFpZ01Ka0pmT1pqb1FE?=
 =?utf-8?B?SUZTRWlra3I3ZGNoS3JNcUR2cytCMnRNM1NDQy82ZFFmWkp5allMcWhhcU0x?=
 =?utf-8?B?MFJNVWVTVTBVTnI4cHl6UllGQjBoem1NS3hyOElNVDVKOXBLNnhTWkRDT25l?=
 =?utf-8?B?cC84ZmJJMnBLR050VWhRYWJOSHR4Q3l4VWtONXY0MVNmVytaU0dtcDNGSzVE?=
 =?utf-8?B?ZlR1cTJNSXBpcDV6SENFclVGQ0xseTFibWlRRUpyekpYNnBvWWJVTDAya0k2?=
 =?utf-8?B?aFdwclFqam9zS0M0MDBZT3RITUJ4YVN6MVR0RjJnL3VPRmJ1czdObGF5QUtI?=
 =?utf-8?B?L0s5c1lJdEVlOXpIRkNtam4ydlluaHVpNUNVWm9wZGo1bVJHRU1oNjRTM2cz?=
 =?utf-8?B?YzBVTGJWVUdNSFlEcmk4VmZpc2ZMUGhVcmlOTWtxTjBWWEFERnB3TXJGTmY2?=
 =?utf-8?B?MlI3MnY1bTRqZHQwVnlpUWRVZlhmbVlhSWg3U3kvZXZ0eFRmbUF6Q1ByV3F5?=
 =?utf-8?B?MG5hNEJuM0xaUWlVM3pLL2J2aDI0R0x4L25VUGNPT3RVZDNMcGhITmV6TkMy?=
 =?utf-8?B?MFZpaHZnTElBYmVnSDdhVmJDRXluTWcwS3JrankraUZ2RXY0NDRFUXNLMVZD?=
 =?utf-8?B?dXN3M2FYQU1TbmhHWi90U2lJN1Bnd1djWjR6emMxQzZ2MmE2ZTRNQ1BXeHQ0?=
 =?utf-8?B?bGwxVFpSOWhmM3pBSlRSbEI5UjUxQ00rcHJ5UTl5MmhoYTZRcUZHcEtEbU9E?=
 =?utf-8?B?RE0ybGdOTmhHZTlYRzM0L05DV3VWalEyc2dhNWRmWjFSdmtMSVJaVTR6RzZw?=
 =?utf-8?B?TEVoc0oxUGg2STN0a2dYOGtCZmhDNDJzV3FnQW54MW13Q1kzR3hsTzZxd0hh?=
 =?utf-8?B?Z1hoY2VDUW1sU25YYjlWTXlaN1ByWUtUdllPWGFGZHpqd1BTSnBvM2NDU0pE?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BE42D9E50C59448AE5B4CE61AD2939B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EYMqQ7Cc3jb5ijYfkP/Oh/NWGkuBU09ihz1yWtCDhjZqpjSU0HXh1b1/mnF9femxGu7LnQwmOWq3kqo6B7TkbHxS9hAoZ5ZjBh91WjU7q1AlmfjVmL0AFroS6JBce3Z0saZj/8i9+0WelvROMkaaOkUqei3zq608TG6eoRDtFMOLMXWMRI6Qxe/qhVp9ylI0wkCvbNTl8IvpdIpRA4iCJFUczkrExV1GeSI69aNDICate0lkkP57L5ahaoBB5o4Xt+JWFWi8Z6GuomT97o6NLt8VWrFx0FRVj1zdSVEgs1LuP+mtUtMsKMZOxpdcbCHoL56ZYg/fjdKISs5u03F08Ns60kteGhlY5w7pc87BSQ14OmqReXHQWaaJTwAMR3gTVZTybIAh913++ouekYMxKswUdMDo2dTonUWKJBHOhNoZDzuiKgZwMjofBsyqObcs/7TElpokpyVOA/P7lDVJuB6qQQzvKO/jA8PiLfe7UpSCvHG0ZMz4HjdmDfHiEqwrSmfGMS5G+MVceLs9Wi5X4HmX00S4O0DUOOd1Y1G48jQClWMPjfMAtD5iKVcSDPawKVl1aQcfyND2X3+++xPEbEZ/G5/SYY2mJtWY9k63keigVB5VxbDiwGY/F1T4/1Q5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3580fc-b93a-49c7-75ee-08dc5ed16b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:27:51.8170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9dIy0nuScCdaOe6uUncZ+cwQycdxrOK0Jds+zcx1MHDthXQuMm2oehWAYkicuY1aeGFcFYVUO0OCiAXQsrYuipC3E9483UCrMz8trxELWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6797

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=


Return-Path: <linux-btrfs+bounces-13643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3B8AA8C10
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 08:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9387E188802A
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 06:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7416A956;
	Mon,  5 May 2025 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GGBRcAs1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gaNvYeeN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97903EEBA
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425197; cv=fail; b=n0nGO6jk0cdIsSVPnsoJuQOiy0p8nBPA1rl7BR2UadV4m4EM3H0TT2kTFRGzpwYfovPlh3YIEYeyAFR9UTJAA71Jhp+2+pNb5dSA1A5Ltb0H7Lp/b6KnYvNR+ZAZ6JOxh5o+1WA6S0THXzV8NtAk7trLBy2FeSoVP6aJ3A6GEXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425197; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mn4BfWxGYs9nd4NOx5u5AUwGRpllVMG7y5t0/w/9N0MnC9PO9W2ahwQvUJLZJMAkmh6845jAI5fyC5xFSF8MG4BLltKKNa8XEMhNnYW66AEaSewp/UBWBchsiviHBzBnuU7a0Ftg7MnhgSC3kwnVvHQVr6ILfdX1Eca7HmAY6U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GGBRcAs1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gaNvYeeN; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746425196; x=1777961196;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=GGBRcAs1K4rv5pir+0qg4+8EOMljW30kul3YT8elg9cjcv0qdTifuNnZ
   yzAQzJmqdI6bR1FU3s5tHHGs7ZQhqA4NIG6iU0bQQV8AAKG+0riTBptEK
   tHy6mMAvOf3/el/A15uMSWFVqCDpHcUekm51bDrNR40aa3ZsnK2JAdpM9
   vbsHSqEX+DLM1SZwQgkS0Dq84KzF+kcHQ5vJKwW5fD8UgS0D2cRP0uQXu
   iAnISdK7bq8EGV32YYoaf2YYFwhftf0twxP2ONQ8woqzrb5Gb3rjzsSfv
   hRvsIFgtoWRYBfudkfpLgCKRkWoGR2D1e9QhAajyU4OWr2xa3slc8PrI+
   A==;
X-CSE-ConnectionGUID: 8Uny7OSKTESOizsVJIFvHQ==
X-CSE-MsgGUID: RnKnE3zYTjGZB2TZVxaI6w==
X-IronPort-AV: E=Sophos;i="6.15,262,1739808000"; 
   d="scan'208";a="79937186"
Received: from mail-northcentralusazlp17012053.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.53])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2025 14:06:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDHMk0IICnhEy3TnvOYxAUSX4eSRaht1L3pjXEA6R1wRLD6AACVuvWhRbf35zojzWNW5t8exYZEEp27TU1JYni/j1o8uT4Ve1QhT2ewWlk7gtxYJ24xF3QrWFMJuXcFGcCiuA7dHEYmqb0S7OcBhxmDYgwWN8GqAIzwC/Ly+NORp4mo/YO0QQaw6KDsjnsLQQuSnYZIrzYLJ+XK6N8bP/pQoP54Gz02YujiIGdIOXkDjLp0xSrBXWHa/3s6LiaiIRRG8qjJXmFupCw3FbOkycSJt7aDbvRSzHxPrFFlujycp73Mx7QLKRIW7X77VyvAgQW9weumgP6Fulnvnbjzlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=UB2s0PNeO+OYy9Em6ekViGs0YcOmt8BdlK0z5N0XJtdaI3LWa7kqSBU0QBH+F8FoIqejkq+Kx9HEspwHloWYgF6LfB5JCJGDWYy7qVZ3kigtvAL7KZeUb9ZDsuK2PdC7b5tserKYpxIoJhFD/WA28zDRSxIkyFFuExFfue2PspRxsiEdueXBCfVxeFMyqhnRCh+at4SJx5zTgX3oThfFqZfgPRwxuZ5YKv1fGfj9k3Em0wBFHS8HdGuXZd+0QJyTJY8Ot0OCI+8TtErWc9IxlOySvg8bprByZP5Y+V2UOQWodGS2Awi6soZKpmWlCv/IViETOuLEWZdEdGFm2v5nWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=gaNvYeeN53D0twhP5x5bSkJyPvTasjq2peCJLLzYhIGE5P/WBDzqlMcxXmX+69yFZ+5oMwQR/IF1HXG91z4+5CKT8VzzapWMtbMI23OX0EwP6ylv5gJ6zVtdXfdzsFOdT9G8xoWTdmaJt7kRBxrMPSl9yQuYk66H3WXu74LBRI8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8020.namprd04.prod.outlook.com (2603:10b6:610:f4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 5 May
 2025 06:06:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Mon, 5 May 2025
 06:06:25 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] btrfs: some list extraction and disposal cleanups
Thread-Topic: [PATCH 0/8] btrfs: some list extraction and disposal cleanups
Thread-Index: AQHbu01LTatn5gUwSkGkMMpqU3tSubPDkQ4A
Date: Mon, 5 May 2025 06:06:25 +0000
Message-ID: <0c3131d8-9f41-4891-b9c1-17f4c310028f@wdc.com>
References: <cover.1746181528.git.fdmanana@suse.com>
In-Reply-To: <cover.1746181528.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8020:EE_
x-ms-office365-filtering-correlation-id: 8ce51bd9-78c7-4a06-27ed-08dd8b9af7c5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vy9tcFlmejdqOGZRUkpuWFRIN1pGa2lrdnpwUG9tWTd4ajJCYWk0Q3d0UWNm?=
 =?utf-8?B?OGhpNEhVWjM1eC9qSzVHWkJrMG1ZZUFKRUx6UVBROFB3MTArdkhMR0ZUVytP?=
 =?utf-8?B?SUM1QlFMZGJCMzlhOWhwZVlDc2FoSW5JQzExTnlaM2JmQklaYUxWUHZFT21E?=
 =?utf-8?B?Z0FWdDA5YWhXR1pvdG5aK2RCa2lZc1BmSzMvN2MrdFRUZVRQb0ViYmFORFVz?=
 =?utf-8?B?V2phRFZKUHFpZDVLOENhZjliYlk2VVJiZkMzRFVib2ZvMTJmbU9Bb0hiRVV6?=
 =?utf-8?B?SVk1ZUZiaDRCNWdHT3VZZmJSMVptd2pjNWFNU1FCYjdWQ1RTMDhCajV6a1Jw?=
 =?utf-8?B?VXdwNlhjYmRLalZ6RWJSUERTeDdMODhtMHZiRFhpUXp1QXlsRC9wd0R0SCtF?=
 =?utf-8?B?NlQ1RXZzbjEybnN6cWlVd3Z0MUV4VlEra3QwbDBFZkhmdTM1bDZReDZ6aGpm?=
 =?utf-8?B?a0h4UlZFeG9mQWs2bzdndUZkdzZKblVJY3ZwdTUxRmdpNUtXUE5jODBkVnh4?=
 =?utf-8?B?cFRTdGl3RW0wMWdPWmhlaTdmWnNtOTdBR1B2RVpJV0o3blFDUEg3Z3JDUFFS?=
 =?utf-8?B?ODEvTHhHNTBTN3BtdUJoMGhRQm9pdXJ1TnZldHNuQ2xKMkJFbXN6TnlmVWpj?=
 =?utf-8?B?WU92UXBSc1JvT3pOQjB0Ukk1WVFxTmV1aHo3Vk96NEQ0aGFYckJ1Qm44YWxO?=
 =?utf-8?B?YjRQSUxxOGlpOW9PV1MvOHpraUtwQzhmWTB3NXdoVzdhUytYWHUyVXlZWjgv?=
 =?utf-8?B?WEJJcVNjY2ZKQ3pycTJFOTYreGxrSTRsNE5WZURkV2FGL29SOHlDN29jZjhS?=
 =?utf-8?B?czB6MU5DRmoyU3JDd29nb0Z6Z2tzTWpUNzcvaGZmU3hDQU53c0IrMzZ3Vyt6?=
 =?utf-8?B?M1ZwUmpEVG0vaE0vc3hhSURIMjJpQmNYNUFVV1BZQ29hV0dDaGpKYzZXMXU2?=
 =?utf-8?B?WVJRenFOWk1WcWhpYW1IQzlIekNGaWJpQy9TWjNGRVZ6TkpaWGRCV2hKTWZs?=
 =?utf-8?B?M25odDN4cXUzWGFoTU9IN1FlaGQ5ZlVPY3c0SzBXTWs4RVJRZnllZ3VHVGZs?=
 =?utf-8?B?aHRjRGVDQ3dUUXhYUWkyNVc5SkVhSGJKMnRGL2ZXcVlsL0U2OU1TZnhKSHZ4?=
 =?utf-8?B?bXo2Sm9TTWNIUFRORWRpc3FwejhTTHovdVlWZ2pVd3locDdFcGo2N21ETjE4?=
 =?utf-8?B?VWlicVBBRFhkVlJoYVpLSGNqRVAwL21OY2FnRzFpcjBDNkc2Qm1DOGc0WWtC?=
 =?utf-8?B?MkNHK0VURTVyQm1SUmxseVJzM1dCL08wMTBSV2o2b09pd01qZ0FORzFRaUJ5?=
 =?utf-8?B?UVF4RFlqTU5pSFRmcXJKbTlTRnh6RXVtMzI5MVlxMjNEVzZsWFFjdUJFWHlE?=
 =?utf-8?B?SmxwZlRaeGN0bGhkaVlFdWVzTUpzYktqTDlqRDQ1d0xPdXdYaFcvM3hFc29M?=
 =?utf-8?B?a2s5c2pLNDdmQ1BKRDU0Mm5vSHhPZXZ0akg5MHFEV3lvQXlFZnI2RXZ1U1h1?=
 =?utf-8?B?QytwcE1TREZLZUdmSTNBSEkxWGwzdUs2R1dLWVMvdklTYjB4cG1WbWQwbkx3?=
 =?utf-8?B?d1lhZDI4ZEk4c3drbXV2ZytrakNJekppdllTU1BneUFuNnBMV0pQNUovekE0?=
 =?utf-8?B?SUZqamhNRWVGNzFOMnVZMkdkV2ZVR0xDYmZtblcveGlTYkd2WDBtdFVjRkov?=
 =?utf-8?B?anA5VGFmL0licnYzT1U5djJ1VWl2bEZOZFZKSnN5S2d5UkcraFdPMFZ0WWhL?=
 =?utf-8?B?NUNGMjRId3Bmd0lDMGE5M0dPeDlHQkI4U3V0Y3ZxRkNNTk5qQ3I4RjVuRE9Q?=
 =?utf-8?B?eUV6SXM1U2RZMmZTMndhdmk2K2FueTBjd1IwUmlKVjVyMC84VXU1Zm5ZT2Vq?=
 =?utf-8?B?d1hIMG54Zkw5NGRNUUd3ZmNyTEJwUlY0VVo4aEw2QVlPRW9LWDBzelRoK0Ey?=
 =?utf-8?B?Z3BEemZwUnJ3RnlzeVF2NlAzK1Rad3FKdVEzYkEycjMzQUJ0NUFXa0x0dDVo?=
 =?utf-8?B?M24vVG1MWHpRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXJJS091MTNyajI1dXhBektzQ2IrWDZ5bC91YnRjUGhMMVhYbThzVDZ6ZFJx?=
 =?utf-8?B?YVlITXFWYS9zK1ZPaDIwMlJXOHVtT1hpVXhjczhRbDJDZ2IvTEJVYkJ2ZXpP?=
 =?utf-8?B?RENWNG95aGF1d0pLMUtEZEE5aVNGTWZ4NDhMMmtEWEhJRERDTE5WU1BPaStM?=
 =?utf-8?B?Nk1sREVOcVZ0bEZYMFBPb29VK0djQU8zZnJKYjhzRUMyNm5nM0QrNmxkejMz?=
 =?utf-8?B?YWtUK0xYL0piaXFHODUvZnhENzZCTWJGRVdDdnFvTzhpTXhOZllHY3VNcFBY?=
 =?utf-8?B?dGdrTEZLYVVJaUViQ1NRQUtISWZBLzFPbXFueW4zdGNpWnllQW4xZVMxR1BG?=
 =?utf-8?B?eHdGVHIzcEcxVzZuV2tvLzN5dk1EeDZRc2o2MFBMZzZzTUZDTzBDMW5DQkpj?=
 =?utf-8?B?M1RzcGFIZjVMMHBsalA2NFdPS1NIOGxIY3ludkd2bzJzZm5QZVZkRy8yNGpm?=
 =?utf-8?B?N21YdUZ1TUdKendRcXFhc3NQVmU1RUxuN3FuUWdyZGw2U05oeDdQWjB6K1NG?=
 =?utf-8?B?bEMvQW5nYkp6Y3V6SmhyZm5VUlM2Qjg1RjFuSHJEY21nMWQwUlVSZUg5RnFy?=
 =?utf-8?B?U3R6TGNnMDBxTFhma0ZEWkpGOUsxSHNOdkwxR1FBdDVRbHI0a3BIV0hMdWVt?=
 =?utf-8?B?UzNEaktOSTRKcGRMb3NMSHQ2dWhZSWlWOGx4anVZYlZLY1VoTHlqSXByQjk4?=
 =?utf-8?B?cDhKdXdmQXd4Y1FLU2srcFB4aFd3KzV1U1hPRytlZDJ4MCszWEM1UmxpT01K?=
 =?utf-8?B?M09RTHhwbStuVzhuZkdad2lsK2V4ZGZMdklEZitCRU5RNVVJZTA1dWUzNThW?=
 =?utf-8?B?QTJjMDJiMnlIbnUyV09ray9iL0Y0ZUdteGN0NFF2SnMzaFVvamYrQVd6Vnhx?=
 =?utf-8?B?TnlOb1FwZGk4SmpzMFppM0kxMW15WWxqMzRnUmlhSW05R0JkVS9waVBwWG5z?=
 =?utf-8?B?U3hkUE1VWSt0UmJoYWQ1aXkxN3BURlRqaktueGRTZlBxbjZWZHVXT25TUDRP?=
 =?utf-8?B?aXZwc21SbjVzKzF3emcwUmg1SWFJeFNSc2pVMWR2MVJWYTVxQ0k2NE5BYW1L?=
 =?utf-8?B?NzBvck14Ujd4aGJlZHFCRTBjSjZSeTEvb0NTL2FoSmgzcld0WXJITjdoMk9r?=
 =?utf-8?B?aDRGM1NnNXdmdTY0R2E1ZDIwRlpkbFhyRmpvZWpzM094QUN0OEw4eXJPRFQw?=
 =?utf-8?B?aXVvRmVsdnZzNnNUSERsSndEU1M4MDYzRVBjazNsdXZ1UitObk01QXRHUFNj?=
 =?utf-8?B?T1Z1a3FtcVBIMHc2aFVxVDlRekllWmdaMFBKZnpXaC9ScTd3OGpkcDJoSjZU?=
 =?utf-8?B?ZkszY1lHc01mcFRGbUhQZFVXV2FTSm9ySWJuRFJ2aXl0TFp2dUhERTRiRGVs?=
 =?utf-8?B?clJoR2J1ZEFDS1ZEVjRoQVNETVI1aDRXbk9ocHVWYlJrSEVFendPYnBsOFIv?=
 =?utf-8?B?eVNsRkE4VmtpRjloaWdvTlJlbjdOR05GMHQyaTFRa1pZMFpKaHQwUnZYcHhw?=
 =?utf-8?B?N1dQMHBDejRKb2ZtcDU0QXFXWXFFUHJmSUpEZm16ejd4aXRwSlowRkFMQ1Zm?=
 =?utf-8?B?SlZGL0xLanlCSldZN1FoTS9NT25uTENJUEpGNnBBMTEydmtMMDBBZDI4ckhv?=
 =?utf-8?B?Z3IyM1JXWkwvYVN5NVVVY0d0MU1nVUI5TlRTVEZnbW44K3k3U3QwV211OHQ2?=
 =?utf-8?B?dzZYT0FiaitIem9iRkJoUUZKQno1Q0VHYUNaeUM1bVdqM3paM2tLckR5RHha?=
 =?utf-8?B?NXlqYXp3VU9FL0ZaMkZ3VzZndnhCNllyWDYrTVR3eDNOb21SdTBRSzFTSVlE?=
 =?utf-8?B?TDRzc2hvY1V6YUV1alNiOVUzeXdtekFuOVJrL3RySEpkb2dpWEU5SEJmMUY2?=
 =?utf-8?B?aXNPQjRRLzlzbVVQRllWY1EzaXVTRkcxRDZhWGt5OUpaTEU1MWpuaHAyQVZS?=
 =?utf-8?B?Uit4L0NLUlF4TE5ZZlFSaUQvd3Y5TnFLMFFLRHdydG9IY3pxRmJQTW9scEFt?=
 =?utf-8?B?bDdTVHFTVFVNeWRGNktrRmUyUEtQL1UxRVpKQ09mRXhaMVVSWCt2dU54Nmhn?=
 =?utf-8?B?R1VFcG5ES2hLK2plV3ZUcEhlWnVUbDY2ZkVSc0lHdFNleU9Oc2ZXQUlJSGZH?=
 =?utf-8?B?ZWt4RXR2cWRjS1NtTkU1WE9hOEgvaXRoaUhDcGFEQTNtL0U0L2pueGR5bmov?=
 =?utf-8?B?dTFKR3M3N3M2QUE3dkRJQmJueXBMdnlhZ1NEOXBwdGJOUW9JOVN5d3o2YkJU?=
 =?utf-8?B?U1BiaFlZdzhLMlkreHoyOXNrNEtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53F556BC281C5641BAAE9120227D5151@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/qzeDfxqDSPx4V72m4rYB6RyxB+ANoUBc0Ds9v1GGnwv/CNF0YBbcMGAKuy8GsMOhfCHNNr0yRfIFTFNGotyoT/EA2PpQBcz/sV/L2BL6SvOhqT+u7eoLws5ug3blMc5wKpRgdI7nNIAMF4mc9qfN5LV5/8PlrWRrAXWw1X7QY+2jJm928Y5iwH9G9Rba323BSM9oAJ2K7Z/c7rI4IzrR+wiBbc05x3f1cgjmQKP0WvaVdiGJ9ypkPtr05fpWshHRxPGS0M+T8BbRJKXQxYqkmMj9dqUvFU0o0d0SQAytLv6rWRPSOKTNGGACuP/2gI5EEZ5qomZ17+qjHucufwkIFdwAOhVz0z3vHIDJObRgWtzFNVzX5XaRmUQcK8/0w572NtRUKbA4+qWsT2BoCO7ta93Hc/zud5FEl8FZea4bBIFU5Cq9tvQUJArV0Z1eTg7BMoqdVxJs3UMBRV6sv928pXeW3uzDXkjDUVThTHDM64pfU/R7zz5yHTUC0nXt8kO03EL69nBuQYZFEYa8hf7xb+I+SPVtbW6lmcCfzsdtnK60qb6ku9zHes7hwikcVsavNWVxQPSv9R3SNtQ2gfV4M02tAOqoVgsyqsNam2zwMJPTuD1+QtInh/m96rXVRik
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce51bd9-78c7-4a06-27ed-08dd8b9af7c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 06:06:25.4375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGIDst1PKbVQtGrssTCIBqS6RssmDE9ppcY86FnzJdpUAkeM1R849wgIwDGJbzy6dWlmQhgAg3bUvdLbJE5atFLVVJsSNpcz8rnQBf21/xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8020

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


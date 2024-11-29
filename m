Return-Path: <linux-btrfs+bounces-9970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CBA9DE821
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 14:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F5B1641C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F81A073A;
	Fri, 29 Nov 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ynjgz6O2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nJr8Bne/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CEC19F133
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732888456; cv=fail; b=j3e5gewBDrFtTidh/gWQl5ZirlHpXILWOCoTgU05IsVw8lCaCjwHPpwOvu38Y36unyMyE9HeyBUgmTYWwaiMm7r1aIuAVWpgS05RS5yiDK2OiX4krgUzqSi+oRPq/f3LTL9nuBpJlsp6COIgSgzFlUaUvPuMeaR4m3W3NSnlVPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732888456; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SsV9MBhrnrepEut0FTCOqZH1kiITgfTm7XnWN2p1ai98NQFn+h37TqxKnKFpGagSSa2r8GAKSmkSEK8RYpTwjqNihVMM4hYAkc5h+6H40N2cpLcg7PPzkuzJfEpCEJEgv7AqfdZmvuk0l93xbUuaiWYbscSdA5cGGkf3dNI/Bc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ynjgz6O2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nJr8Bne/; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732888454; x=1764424454;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Ynjgz6O2wJ7BLshkT9DauS0DgaYkYynutMJ4tCUYy+OatAqP/m6Kv3aR
   +bJAConBzrnUV/zhn8Gvbr89gLPun3Z3PpYLG1VhpK9IUlHJiad3Z80H5
   DPz/7grWIN8E1vlUHlXBhl4gvpQvrFAqfXFf7oBzocbewzqorlqsh1B83
   aU7VBAonfgUjdGOgysXGEnd2aliw9Wj7/r2BLaVl3ljLuCDu7936YfiUQ
   JKGj6veU2IRKABiJjYUi1Q1lF5xUAIUyDY4R6IgwE4k048JT7zwZs5YMV
   MKcbXGEBNQhzYpx2r2JGALaB0DIYOA9k1P+ed+rmWl1Fz/uw2qOvn7i3P
   g==;
X-CSE-ConnectionGUID: aIeO35hbSM+bX8+k6Crf+g==
X-CSE-MsgGUID: DnnzAlKmSWe6m8fp1sCeMA==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="33724136"
Received: from mail-westusazlp17012039.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.39])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 21:54:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRdeK47Gtsd3r6HdT7X2UUbPSJEcELxdX1OEYVSAKSR9khpWa3y/Nvmyxh/VgwWy4Lz6ZoFTQXa3Wz4Np8LIeOr3OXcb+S8BAYkJE2bRLL7vQWQYVZZY117aV3S2T1yRh4STR1zYtwhPr5SNOLbXHYPSsgoTSkX6r2AXrQZ6o0QmrShZLWN8hoq0suDp5N/4h7hY+2/Fbw78uummi/pZAbmqC8xYcF1SEJbzDQUMINl3CFWT/iz9V87WWzukpau2/Dtxkav8po2Xb+j8G8bDwqhZXyys3D+tkpv9ECO+K23if+HZ6SIN2rUhi2PIYBdJttRo0qm8FcIQJ/zHdozM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=rDOA5BzDuSqDz2yCVSvuvTW+FdNMHXzcOv+Elt6uDa+BDknoxUNVHgaspE5oAggwGSWR/QDkm92s1FKWCmjB/NyvY5RUoGdlglA2xnGWvamHh90O7zTFZYpiG7zPNE+3Xmy1/DXTBVJG1z74l79n+WQ3HRANW6vm0WBgkXDgFhTdki4ITrU2LZrMaVGj8wzTcD2xPo0j+HD7Ykc6VKAacu7BbyQUVzyQ8+Nl1ZBy/uG9pucEGQ528kbPKI3DgHlgSL1Ij46MpS919YYurXA/ieh+9ps8OXqhne7ZIIKusBBBEyyKfPzOtDQfz7BJ+8I0SNdvtjYxUf/Kl/HKMGu1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nJr8Bne/F22HwzZep9FIz/utZiHKLhhmDVmwPaY1iteCO3sHjTuqUkbrA2vjtYnjCQbk6C4uWCTNzfK6vhuxxWvARI1S0jUxwFjapuSuY79rTMtHtw6MKQ2WYNRb1vKhneB/xHT6lcqVt9tn5EKOOMH+SgTCo8OdxUCZ2pEDc/Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8821.namprd04.prod.outlook.com (2603:10b6:806:38a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 13:54:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 13:54:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix missing snapshot drew unlock when root is dead
 during swap activation
Thread-Topic: [PATCH] btrfs: fix missing snapshot drew unlock when root is
 dead during swap activation
Thread-Index: AQHbQmRwrznnXfap7kmturTx/s5lorLOR4QA
Date: Fri, 29 Nov 2024 13:54:05 +0000
Message-ID: <75b0b8ce-057d-4fd1-a3f9-4fed3da733a7@wdc.com>
References:
 <76ef43063706a4ef1a4313ba03ca6225e7d7dbac.1732887615.git.fdmanana@suse.com>
In-Reply-To:
 <76ef43063706a4ef1a4313ba03ca6225e7d7dbac.1732887615.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8821:EE_
x-ms-office365-filtering-correlation-id: a27c443c-c953-42be-97a8-08dd107d49f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V29rVjY5Qy9Pc2N1cFptRmRXZW4vNjdBU1pRZzRtOUdiQUx6WHN6OUpJQm1U?=
 =?utf-8?B?dmNkbWdiTUhZQ2tsT1owVTNRQk5kMlZzeHJoMHJDdGlVY3ZsTzdZeWZaelhC?=
 =?utf-8?B?N1FNR3dPWE9oc0RrdUhjb3RTOGVyMFVNMFp4MitOTGd6NFhpWURHTUp1Y0t3?=
 =?utf-8?B?S2NJYWt2TDZOQ3ZkaXV6M1h1WU8yWGFLL29lbnBrNnJ1TkFaVU95OGtmd3VI?=
 =?utf-8?B?Y3Rmbm1LaDlONnQ5TVhEVHh1aGsxWFJNdUd3ZkZ1RkQzN0tFNkxOZVdhSVd2?=
 =?utf-8?B?RC9LU3JqaDRZY3gxWlhNTThBZHRCZEkxZGFHRGc2VHFKN05LaU42YXZMU1lr?=
 =?utf-8?B?V1ZMcWtBOXpnclBUc0hxMmtQT2FrRG95T2NXS2ovRkd5QmJQQzdrYnFUZTht?=
 =?utf-8?B?SnloeEtnS2pWMUMvd2JPZ1p4eTgzTklwTXpkVkIwNkxQL0ZWbHQ3M2ZsNzc0?=
 =?utf-8?B?WDNRdTlnalArNlRETEc3cWg4TVZRN2JaRlpIMlZ6d0poVFZSbVFtTXZGWEs0?=
 =?utf-8?B?MzFDaHVOMjlxTEx0c2hqTkc4YnFCNW9JNzJkdzdZVkcyUTJ2elVSbys2Y0hW?=
 =?utf-8?B?RmJqcTRTZFQ2N2tLMzJFTUdTU0dOUUdXeFRKYXgxMUM2NUY4VTdoWmhVdnRC?=
 =?utf-8?B?MFVKZ21qQW9YRVllcG91SVNVRjQvb29BS0twUXRNZGxJV3ppS1NLQVFHUjZ3?=
 =?utf-8?B?R2lqTkRFQ3BxWmRmdldtUlRuaXRqZ0pOTmR0TGRMVU9YNGhjbm5VbDMzSTZS?=
 =?utf-8?B?WFdMK3ViL2NDZ2xQeUhhVWFOOU1nb0luTkx4SmM1TngzWlh3NldVYjY3YnZL?=
 =?utf-8?B?UXp6LytlaldMVEFGQXE5V243T0tjRmxTNS9iSmRKOU1pK251UnN2bjBJUmV4?=
 =?utf-8?B?c0R5MFNGU0FVajBrRzA3dUMrSHE5R3k2cGxhTTZSVXVUb3g1VEIxNDUycUxC?=
 =?utf-8?B?T1paeWh6SG45UENaTTN5RStiRmlRZDdvUlBPWSsyTHoyT0RHVW5LTnc2ZzhG?=
 =?utf-8?B?eDRJdGdrMVUzMVZLQmtHNFMwSGNGd091K0t2OGw2V3d1WGRVVFZHTVNleWpy?=
 =?utf-8?B?eXo5Y2Q0Um1wNXZrLzhMRjN3YTlRaEdxaksxQkI1MDdDcmNMQ2lWSlErL0FR?=
 =?utf-8?B?bHE1amp2SmJYazk0dmg0b0JWSFMrV1VrZjlCVmYzb0VYOWdUbU1iNllXWXYx?=
 =?utf-8?B?RjdkNWJtU1FxcElrR3FuVTZLcVlkemNodnFIaVErK2kyTkNaZDZueTFORm8v?=
 =?utf-8?B?bVdPeEFzV3hIN1Z0czhXYnRWNlZJNnlsOXo4QnZGQzA1bDRHNGdrTVN4RS9X?=
 =?utf-8?B?azNqSTIrT2F0ZnJvejU1Vk5MN0pMcXJLTGsyTGZ5TUVLbDd6d0tZNnJMVUYz?=
 =?utf-8?B?c1lzdXBQNXJnUFRVN1pzQktIWFlHV1lLQjAvaVVvZ1czSHl2L0tqOTBJUlQx?=
 =?utf-8?B?bExhVWZVZkxwdGlKdEgrbUsraUcrTXM1eEZ3YXd2OHAyUFArVDUwdHdFdHlE?=
 =?utf-8?B?bURkS0Q4R29wWnM4NlVQVWw4VzhpUWZTTHNUNlN6cXhsWlR6UTNzYTZpcThL?=
 =?utf-8?B?ZVdEUDQ5VjBQbXpxdHlrSmV4Q3BwdHBHc3BIdGtOVlNmZUZ2dlIxVDE0ZXU2?=
 =?utf-8?B?VlptT0E3dGZnTTlsZVdCZXhQWHpEK3NTWjNscnRmcklZTlV2dExhK3ltOXRn?=
 =?utf-8?B?U1RmV3B3emo1V0lxWW9SaTlXcUpPelpCcXlMT1JDZEx5ZU9ZMkVFNmxoR3By?=
 =?utf-8?B?MjNFV2kydVIvVlh1UlBTUzlYS0lUV2hWc3lzV1dLZFh0SEFVSm9CalFaa3Zm?=
 =?utf-8?B?cytuOENLTlF4K09iYm1nS3pBUnc1emNqenBDbXFLalQ4WnRiZzVLVUxFTEdl?=
 =?utf-8?B?MldIUGdKR1BVdDVlWkFDV0ZFKzFFK01lQjI2dVpEeE9IUmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXBYWjZiemVlVDBla1dEU1VBMzhiVzBzUk5SdGlLL1BEenlKNWthSkhadTRn?=
 =?utf-8?B?QTB5WldJTjhRQmI2cGZGYkpkbStaZDJjOWlrMFZyYTFCcFZzd0RmU3NGRTZj?=
 =?utf-8?B?aVc1QjY2UzBLM2xIa3JYSmR4VHM4Z0VqRjB2YlVxcXE1TTZCQWd3QmtWTzBP?=
 =?utf-8?B?UlJLek9UR3Bid3hzK24xcnBHRVpnVkVzd1A2aHlEWXZNU3dVaGVDcVZ3dldD?=
 =?utf-8?B?akFXbHpSUWpOdnlGWG42UWZReUZYYTVWV096cm9pK3ovVlozYUhhbGI2Y0Fi?=
 =?utf-8?B?ZFFIKzBhd0xqYmczVDFNRXJUVVZwRUtvNEZVUkZyLzM5QUxmcCtQb1BRWXVY?=
 =?utf-8?B?MlQ5UUd0cXdZbFBQdGFZNEtZQ01PbnlKcWM0WnhKdk1FMmdOSFJIZmNweWJw?=
 =?utf-8?B?S2pPNVhSSkUvbk5qbHpJQVhCN09BYkNZUWc5d25Zb3FBQlhyeTc5VTQ3Zmx6?=
 =?utf-8?B?YXRvdEhIU1NpVTlDOVUrOWJKMkFESXFMT3Baa212dkFhNS9YdGtBY0VENTJK?=
 =?utf-8?B?TzZYVG91aTFLaS9FR3BZR1pTZHFRSWFFU2VzVTZNM0hjUFN2aXo5WTBLMkM4?=
 =?utf-8?B?UVlkSmtHbGd5VGZqeGhrRWVWR0V1Nm80Y3g3WkRDM2NqUkVYSjlmZkxaWFFq?=
 =?utf-8?B?L0pzRjZHZnZPeFc0VDZET3ozWFRNQVZkWWdDeXVDTnJ3RElvKzB4VGVOWE5P?=
 =?utf-8?B?MWlWYndkWmpRdUJTS3pWODYvK2NVUGRzRW9Ldk5DU0RhblpydTZ3WXdQY3Vh?=
 =?utf-8?B?YXR3ZDl3ajY4TEJoYytSaWw5RzlmWTdma040cEQ4NURrYXowUUpUakVKRlZ6?=
 =?utf-8?B?UFRVbEVsckw2M3lqbUxoK1RMK25NVnc0ZVdwNHczMnNYcFZ2TTZXVWY3bS9K?=
 =?utf-8?B?TmVVdVl3bWY0RHBIS0ZlaGIwN016SnNiVnU1anpsaEROSDRMcEE2MHAzNmdt?=
 =?utf-8?B?cWJlTUMvL05Va2pQbmVSVnNmZitzR2pheGZrL1dtV3FkWTlvRHdXaWVhR0I5?=
 =?utf-8?B?UjM0Y1pSTjJHejMzRE9UUmdTYTdYVlVyazBRcStHTHo3T0ZNakxHNU9qUFhK?=
 =?utf-8?B?RmcwWmVLWjdWUWlPQjF0dFJubkZUZk5rTGhsNmxVeDRtN3BibmlwQzRDR0ts?=
 =?utf-8?B?ay9HQXgvK3lMcmlFTVJob3JoZkNmazFPV2pydzJZbFpsaHJPaVdXenJoOEFx?=
 =?utf-8?B?QUsxVjFxZzVHQ3M2dXV3aEh5U2s5ektxclJyVEtnR1lPYTQ5MlJIaWxheEZz?=
 =?utf-8?B?emh1VDl4MzkxTzFBWWtTY2ZHMitDYmk4ODNhRnNXdDQ4Nkh1YUI3MWo2Tmwx?=
 =?utf-8?B?TVlzamxkVkprTTBlQ1d3a1RqZXdRcStVVUl2R3FRR0FYb3FpbFppM1Ezemtu?=
 =?utf-8?B?cTFHQ2c3SXlNN3ZoTWhKY1JiUlV5NC9IdlM4cHBvUUZrVmEzTmh5ZmxocFZn?=
 =?utf-8?B?clFRYU91NjZ0Zk1UcENPdkdRSGNQRm50RTdXaHJhKzA1am82bTBVbFBZTm1M?=
 =?utf-8?B?MVJKMjZDaS9zc1lRMGRQT2ZiVmFpaWF0YmRDWlIrTVh1dVg4d01Ccy85Z2U3?=
 =?utf-8?B?ZVFhalJsL0VITlJXLzZTaGdJUWpvRFdSUHUwQXNHb3ROb0oxd1lmOGxuRWh6?=
 =?utf-8?B?N3BNMVJ6Q280M0FmUkRyZTBJMEdtR2I3VlBRVTJLTW5xbEZOMGVRaG84dXYw?=
 =?utf-8?B?OUhiWlhCbzNMK1NtYWI5V3lleUhNeHkyMzgwTmRGenNzbU1yU3dwb1NQNENX?=
 =?utf-8?B?K1RlMlFYV0VGOEhkZHM0VVQ0SDM5Q2xETDdsaXo2YUtCWUxFOGl0UTRWZVRG?=
 =?utf-8?B?dTVXYk1ITGxsbEsreGRXZUNhSmRtQ2ZLMUEvNGY4VDJ5MXY4U0FnUHBBKzV2?=
 =?utf-8?B?MXpZWGNBMStWZ21hOFB2NUc3cktDZUFxRzJuNXlQN3k1UEpTblZhMWliemVI?=
 =?utf-8?B?TW5pa0xrVjZTVTN5RXg4NnBtVVpPcUJpblJkQmR3cUN4dmtuZUdYSmRKQU40?=
 =?utf-8?B?SUd1bVI2QnpKR09OdGNOb2JOOWF6TUlXTlNQek5pQ3V3a3hlMXdNZTdkMDgw?=
 =?utf-8?B?NVNFYnVJMnR3Mkc2WE9UUzBTc1RWWlNERVB3RUQyUHBhTlQwekVCQU1tbU5I?=
 =?utf-8?B?KzlxWGdzdXBhSkYwNjI2dno5T3cwUnhmSU5rKzAyYXZWZGY4ZENOZmpMZlV3?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2658F0B692BAB6489A0C719F88C62221@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lErRXmQuABnFTlixfM0kViF15hfCSVrivkKvB99PmqJZN4yRoxa7elf3RHFFpP0jiNU5ezwxlaAkl/J96dDdzVb0Q9X9hYgH1kMx8hRiYw7iVwNTIrdYpB1KlUNztFD01exUBYjgy4fDS9kRmcXW9ItUqtnk5nCsjnmHS/vXmNOGu9xx476z0ra3fJKpUMzJqZZWqoB8g8c7uXwUW+aoDqRnw3C3eJtZ8M3U1DfhP2U2f3vLq6zjJucYhjaXYaPnYSM4odcFgQJTeJ0QxE9B2B35VrGpTBWVoHLd2GwXUkbrUR4qL7tRJhSPlkKyQZ77sodNVHJBDI46E8RQGEKWsuRURl+Ry8Hu3iVzNIpxVRxvdjB76XU4iXje2u1XmBM1Jujq+vpAUX6uw5a/E1Sn+kSl8gz7UbIGpnvT+pHaj7KJ64NmsvczJBHEgGz64HjvAQ4GD13oxdZt/fRwN1aONYgyRk+2V+tq8YlytxalroDtWZlsKXbGhMYTh5R5VvAShsxrJEOKOLJ1Drl53LJeOWxHPJLQgQCQ3WhV9baij3kMtqhK2H9kizigmXa2AwEGmu0w4swcnr2bFn7vdj9vQLM9GLtJK8g7UjJudAeYvTb1tApc0SCTDAaEAClGPlMK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27c443c-c953-42be-97a8-08dd107d49f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 13:54:05.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRqt2l66KCwxFQD6BgcwhKoXSHeKcbmX7vsvPpniunm3PRdmkwxckE17EJR4StsN1V1Qz9uL1CvLpiOLqUfkqEXKMK0bqY6ovfuDAkEl9h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8821

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


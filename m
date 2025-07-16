Return-Path: <linux-btrfs+bounces-15525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E2AB07152
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 11:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851E0581E12
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD082F3C1A;
	Wed, 16 Jul 2025 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CvVWmuNF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hetD2ovg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA3E2F363E
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656977; cv=fail; b=GiSMwfmm+DGq9fcTH146hTnzDUHivAVOoZiCUMSdL6iyKxWvChNI1sIBZKPgXbdmui1Br2mQlUmT2Lfn/ltH0SUoMJJUS29b128ipPKaf8Esdsq5Swe2TxIfOz/tEsOzfrSA8DRMfq4H3SFJEbAJI7vBx5Yrta4Zn3ffKKTJkLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656977; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LG9NejU1ijoOJEfr7o3jgLaxzrEmIFjIviaXJ4QzQmZd5gOhV7b2YS7Sg0isRhdBujWvSxkrpWz0djOCbj8nobZwE26Cx4bj8SbHRY7pHse4ilR9IcTI/lOLwnqI46LlgClQ1V9TMbpaq55r23ZbW84HF0rH8n7FiENUOMiOapU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CvVWmuNF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hetD2ovg; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752656975; x=1784192975;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=CvVWmuNFZFlz2gIy9t5df8iJeOoFsRe4ogafG6CejdBQMp2br43YMYef
   WZwYnl6kM6dPj3PaYThzxLlPIJZPuy6EXz/E78ypBF2Pi8vyWEeJjF+b6
   tBTMf8UH98C38nzLn/p6pDlZuwy8GTWVv4lw0xX+zpjabDF6nz9iU2Hwy
   Sfn/GWmKUieyI1led9mgVMmAqWDkdxaDPxq2VY6H2Q1Xta+8I7ZJYC6GU
   Bd5JPvvlBVR1B7ui6M/KbDpWk5o/XH+nNqLszrMhHUJVexm4nsF3cFAi8
   ulWcR1kefBFCmiSDMcKenWZr38M+fPrHe3peawZ9A1+NSQmG7HNEVqZdg
   Q==;
X-CSE-ConnectionGUID: RLX+jfxOSRizceNk67I0Ow==
X-CSE-MsgGUID: mtTuU/BQSOGz+cferhusIg==
X-IronPort-AV: E=Sophos;i="6.16,315,1744041600"; 
   d="scan'208";a="88197309"
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.79])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 17:09:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9K9CGy1JFrye2iEb18El3YRPE1ji4/Z9m3Oy2Bey3jqrYOv6N7ofyicHGTT576k9m9tyxuNVxFOxGpD+6VEWVPNglIvcyg6vhwINYTyhgfmYypCF16wzoFF8jrwimM1jrF/vaiuQRsgv+O182ndzivkN1ncltIiZme209Z0zclwNgXXTqD9U6pDks/ZfNRNeQ00r+j6VUM3eFMLU6LggCwZUMZc74elCrnvGNukvH6akGYjrUHRsYiXQPxV58od6KUSW+ZIaIlPn8caNS5HQZT3FksmU9mDHP0h1TzZZ/VX346uN9//qBB9yhi03ShwZhVAdpJ57UaxcnkSuMn+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=F0bF8NoMxfWpWvTyQoOozuEgSPfCDQ0V/VqEmUJCU1mCm3jt6HXuPBMsNWqdlYWtA3NFtLwSZFW5NFYUX2wmuzOoZLOa6RPF9eZLEGAT1RJJwIwsHYEtk9QOZOyFBPnuv99Use/sNliVQjm1RYVzuef8CZsEHP52TXNIGHSgN5vtWeTWnwVc91uEk4dHjb+goF0IrT271G7UrsODNK0eTnQNKSU059CLt0757ZXc/1u9c9Yx/vtiLK/aYAQ7whVMyKi7RJu8bG6U4Nv5Jl8R7fRLmWInGsLYoGDDmfBgT/v2IwQlj/mg6afLCTjec8SpFdzAlN7r06yu2sPVcsN0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=hetD2ovg+fbILeBw2xGYf4XjkdajBp0HB3meG1PzOUly9DRCLsXxCZdbjzCF+kzUdXv59N7W3s19c+MzBKCAt116PjD2H6Z97ftj1F75JvHqleEQBDSH1x/+8IKG9uL987UpsN8J4whKa8ph7u7FA9Bg76T1N3nVMbW+AARfeCU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6332.namprd04.prod.outlook.com (2603:10b6:5:1e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Wed, 16 Jul
 2025 09:09:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 09:09:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: refine extent allocator hint selection
Thread-Topic: [PATCH] btrfs: zoned: refine extent allocator hint selection
Thread-Index: AQHb9ixRnMpOkr8h+UC2uk6LcjOiTrQ0dlCA
Date: Wed, 16 Jul 2025 09:09:27 +0000
Message-ID: <61901287-3dd7-43c2-981d-897c3d752264@wdc.com>
References: <20250716083300.1308261-1-naohiro.aota@wdc.com>
In-Reply-To: <20250716083300.1308261-1-naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6332:EE_
x-ms-office365-filtering-correlation-id: 1e7256db-f0db-4392-0ab5-08ddc4487787
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFQyTG5TNVBPenZ6V1Y0bzBGMXV1K3UzVXlUNUtES1lOUENwZEV6WkhSUGpl?=
 =?utf-8?B?d0tpV0pDK1hOMERqd1NlRU0rL2JSOHljb2hyek9LeXp0TXloNUhZU2w0T21s?=
 =?utf-8?B?aVdHbjJQUG9Wd2w0V1BnZnphSlRjOE04THNCVXBCbjVVVEJnU2dnNXg2MGJt?=
 =?utf-8?B?VHpRdy9HRFhFaWY1My9wcGw3RG1iQXA1ZHR1V0IvUDRPdGY3SzV5NE1hcnF0?=
 =?utf-8?B?UzhqSWdkbnZTc3hyQllBM0N3ek8xbG45VldoSDVETlY5Rk4rT2FaUnFTNnMv?=
 =?utf-8?B?YU13eUYvTkp0bis2NUV1VVlZeWYySEhlMUo1QlRMTFFzQ0NDS0hRT3FMVDZo?=
 =?utf-8?B?U1VsdUlrNlZ5VXdURU1LQzBJLzFrYUxNOHM4SkZFMVdlTzUxOWJzODhVb2dG?=
 =?utf-8?B?c3JRQVl3aWFEeHhIL1ZhSE0rL2lxbnRnVlJqU3h0ZlFBdUZPc2VTTnl3d1Ay?=
 =?utf-8?B?VDNVL0NhTm95RFVVclZMUEt6Mnp0clBOV0dCRUFYMFFkSzR2M0toWENaWmZF?=
 =?utf-8?B?MEJGQzFqdDJMd2xNSXc2cGJMUTlqSzVSSXh6ampaUFBaWjdXa3dGZFQ2RU1m?=
 =?utf-8?B?R3RjYWdjbUxxVFNtbE5ET29nMzNzbUsxaVJxYmxNMjdMQVNiTEhGSXlWdy9z?=
 =?utf-8?B?RmkvNWZQWWFnR29RMmFuSmNReXJKdXRRU3U2S2tuM2NKYUVHaXBwWjRSSXZa?=
 =?utf-8?B?NHMySFAzaW5JOUFJUHBodkNZdlRxRERaMTBmRDFaZVpQU0dtQnBHQVNXanZX?=
 =?utf-8?B?cDU4V0RqREJjd0dKSzFJVUFEbzFsdXdHcUZod3FVanpONTM2WmR4U1JCU1c2?=
 =?utf-8?B?VGtUcGRzbXRvTDFGYU1YbC8vbGFGYmQ4VlN3UEZkUURNaG1MYjZIUFRSSlZr?=
 =?utf-8?B?c0orNUlULzJteXlDSkE2WXVLVDg4N1B6RG5Na1VUQnZQUEQ1QWl6K2JoTmpF?=
 =?utf-8?B?b3I4bTlGQktmRS9mNDBBeW01RkRTZFpoWWdIN2t1TmhyQ042N05HMWRUUkN3?=
 =?utf-8?B?YUNzMXNtaDhGZ0NPUWRuR0MyRzR2ZmtUa2NHZ0Q0T0V6SlRHMUtWRkl0RGYv?=
 =?utf-8?B?bHBaL2VvM0hQMVV1cEczZHJLUG5NOHJTcDJPdWRuaTNKMmU2TVFLWmtIa1ph?=
 =?utf-8?B?a01IalA0RUExaGdtd1BQbW1lazlGZm41bTZGSkxhSVpIb3Fya2xiRUMxVXJM?=
 =?utf-8?B?eFhJZ2tuT0dXSWNtZlgxb2xPTXdsUy8zaXZCVVVIdVgycW9Fbyt0VDk3RG1P?=
 =?utf-8?B?WkFQZ3pzc1VVZE1DdVpSNnV6ZjQvNSt5d0J5U0NxRnFkdUV2ZlBqUmdMcHdO?=
 =?utf-8?B?aFZRT0lkVHUydW42UUQ5aHkrdE14bXQvUzJOazd1ZnlvNHhrSjNMMFdnNmV4?=
 =?utf-8?B?TVgxaVpRUi9RYjFHM2JWUnlYMDhuUkRabGZMcjh0WjNXN2dxeVNyRVRFdmVY?=
 =?utf-8?B?NFpPbTVubTN2R1NTMlJLbEhsNjdjS2RRQTlvRDA3UzBJbWp0Y1lRM3FyL0Jw?=
 =?utf-8?B?ZU1hNlJRME00VmtESUtWSkhLZ054aWxZM1hGZkNnaVNLbzBpcWVCcU5oL0g5?=
 =?utf-8?B?T21HQVVva2JSdG1MeUlZSHp4VFY4dEdQQ2F4OERSUmJUd2Z2VVA0OUJ3bDZl?=
 =?utf-8?B?L0hkV2lBR0RnUFVjaXRZc1NRNWliQys5Q2VhTWJpc3RHNEd2OE1Wak9MRFFW?=
 =?utf-8?B?Qm1iZU9rZUMzVzBObDU2Um9ldW84cWNyUWcxendKbmpTNDFTS3pFdXYyWEVa?=
 =?utf-8?B?NlZoZzR5cThaSWhZT3ZBRFVYQlpsVFc5NHNtUEVvaU4yd0FRbnZuMVQ5bENx?=
 =?utf-8?B?UnAwSnAyVXc1blBHU0RESFhXUEhhRXhWdi84K3VUTGlPajF2YmtkTVM5dEpr?=
 =?utf-8?B?YXNaU2tEb2hINmdFL3RvcW9lSE9ZNmdaak8xY1Z4emZPaUNKSCt4S0syMXNn?=
 =?utf-8?B?eU1Ba1pzNDBldVAwYWNvR29RbjViNjNSbEJMditwSkdoRUNaRVVYdW95MTF3?=
 =?utf-8?B?Y24rTEZ4UFpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVdLd1hTVzEvUnFwRjhXd2kxMmt5VVZKYWNqM2ZKZS9Ya3lKR2l4eTV2NzE2?=
 =?utf-8?B?TUxYM05kU2lxZW9YQ2hkUDN5U3RrdmNnZDUxMW1xZkhueXgwZy9ybjRkSDlK?=
 =?utf-8?B?TnQzNTVJRzczc0JyL01mMVlSMTNIYkhtVE0rT2RXcVNEbURVKzZWWCtBUVNJ?=
 =?utf-8?B?Qys3RVdmQ0RoMkN2UXlCbmdoS0YzdWpXSElXb21FbTdXRXBrNS9ZMmlvazNq?=
 =?utf-8?B?RndHSUU4YUtPdjBoalBYT2JkRStrcHpia25YM1h3T1IwU3BQSUJGQXMyODE1?=
 =?utf-8?B?UTFPbnllbjh2QmM0a0t3dUs3ZUpwZ3VhTkRwZlZ6VTR6aW1BL1dMcnN0WHN6?=
 =?utf-8?B?MEZSMnVqNlM2dmNTdHBEaUhuNW92cWFQMHVTbzhpZ2VKZG5EL2JYdTlkRnZQ?=
 =?utf-8?B?OVcxcXVFdlpRVHdCWG5GcllGdUxRd1FvQkdMUzhxWHc3VWN0NlQyZXBNUWxE?=
 =?utf-8?B?Z2tSL1kzdUt4QzhuSlFGclJxOHQ3RHZaSDVmbmRyV0JQbDlKSHJ3VWJqZ0ZO?=
 =?utf-8?B?TS9Kem1pY2dCT2VmYXRtUVZ2TnFMcGZ5SXUxT1RueE9JL3RIdzRXb2ptTTlX?=
 =?utf-8?B?WUVDemo0RkZheUIwL005VmRLVHAyNmRwRW5lRGtxTFk0cWFWd01GZXVIdHY3?=
 =?utf-8?B?cy9CU2tlc2xqcmN2WWYrVDFzQmRwQXlvR1NoV1pKUzdENEtYdDNwRmdLMlJT?=
 =?utf-8?B?WENIczBHMmxNTkF6RXF3VzZzMDdOVzJNZ0Zxc053TkRaWFUrTVplYUFnb3FB?=
 =?utf-8?B?RFUrZ0FGWmlIQ0QwYkgxKzVWdlNMeldjWWdmamJ5eUsyaGhmNk9WVitYT0Ft?=
 =?utf-8?B?MFQ0Q0EwWUJyVmMyNjZlTERYOEdZblpNNnBteHJjWVdJRVN5QUN2cDdpMHYy?=
 =?utf-8?B?bEpBNEk0RElFQzRHVGo2YnRTNS8zTitxNzU0cFhFaTBNRThNbWpRNkFUenIr?=
 =?utf-8?B?UW51YlQ2a2tqdGpaWjZNQ0JCTWdmbTZGZEduak9qRTBoL0U0alY0Qkpwb25T?=
 =?utf-8?B?TFBYNXA2RnRaaDVxUG1aaC8wVU9BVmx3NkEyWWkvMlpJNjFpU1ZSeTZYQ0NL?=
 =?utf-8?B?bk1HNmJXU2wxb0VRd0RBNXJtOElVSmhRS0RZWHc3WE1YYXFLSjBLMVFucFdC?=
 =?utf-8?B?WStERjBna0QwNmN0bWVvdldaUzZmUmVZT2J0YWZGZkk2VmFvZjIwaHNPSkNZ?=
 =?utf-8?B?WUNXeXhPRzVna3hWOGpBVVYrd0pYRzhlUXA0dVZETDV4TThwelZwbXRXT0NI?=
 =?utf-8?B?eWQ2OTY4d25sYlpFSmUrbndBd1hvRG05M29BaEFRT2lVTm9nMStSclo3MTM2?=
 =?utf-8?B?eG1qdFFTTzRhdkE0enU3MGZFTXN4dWE1OHh5b2tQUWdQOVJIenFyNFlEZVhu?=
 =?utf-8?B?ZnUyZzNjQWJaeWVwY09DVWUwTHdsczRhMno4WjliTG1vZWZUUmllU1BEUkZF?=
 =?utf-8?B?eWQ2bExsVlRPRDE2NEgrUlNET3YzRUhjalVqNXN1MyttYUE3VGJYVVQ4OWlS?=
 =?utf-8?B?dC8rRmZzRi9DeHpIbTdQYUlaS1c4R2Z3MXZQY04zZ0tLUy9Mazl3V0o3VUti?=
 =?utf-8?B?YUJTOTgyVHhxQWN0ZWQ3a01WM1BJdks1R25vRnk5OW9jR09nSEpuam1MdXhv?=
 =?utf-8?B?b0hrdlpwTjJCdmRJeFB5NFd0Vm92eFpIVGxoWVR2WlhuWFJFdmJ3U2RFYUJE?=
 =?utf-8?B?UHNGc1RPcm45RHF2Mmc3NEpNYlN3S3Y0ZHg0WjY4Z28yZW96S3NscmRqc1o2?=
 =?utf-8?B?TWVRb1JwclVEUHoxMHlRWE5YSHRub1JBanNBTk5pMVA1TWIzYUFHL2M1Tzlk?=
 =?utf-8?B?TndmZEdrVlM0WDQ2UTBHYTk1dkZHb1JUNXdIVkF2VjBtSG9zZmhvSFJwMzNO?=
 =?utf-8?B?SW9OdSs2RkxJUEhFQzAwY2RMMjBzTWx4TVlWVFhZdS9WUXdJS2RjNVloTkpi?=
 =?utf-8?B?QldJWHd5UTNVTFYrOU9FdHhKK2VxbGdGYTB0cVFQVkxSblZlc0Q0OVJNQjJO?=
 =?utf-8?B?M1hrVndibHhKRDhtWWdJNVR1TmVCRUdrRDM1M1lLQjEyQkNXb281OWI0UTUr?=
 =?utf-8?B?NGsrWE1EYy9QRTJGSEphWnRScnYwNisreXhTOTdHNVJFWW44UVRhbkQ4R1BY?=
 =?utf-8?B?NUlMRmFORFpIMXZuSGFtb20rRFZsWDZIMlVCTFFiNHVzekdmYmdFSUdNYWtH?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <159BF21E351BE444A07EF65391B47E44@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vmU+n6W5arEvyZ3XDF7hIaCOhUHB7d8EuBc/W9rqxBU1nDjgVNz8XVxBsIKz+unplXkx94ueu8cSwG1tqXmzmPz47IXRcDlrFkUgIKopR72RyphhBSp10wL6hPXM04rSXVCanmGKBv9MAPx1sSy3Xurs5XTKKciA6LqBkUjCBu6KKZOo6iVLNLeuH6q7xpHakeuOMZ5fh+ZOQYZZlIZ37qfsH2wHl0SCt172Hq/7zYPH4GcCpWXZKfN20oGPlhz1dHI/AoMx/vvlsMOoPBipOjTIdbmsHOJKolcGADhGacCYdMwnXAUxWMtNBUhw7wqJDsWkwqxAxOtRqvMtWBlHbavIpw1phtTMAcK6Fn2sN89sb2m0VvZVUTPQZleXK1N/U3ijo8Ni3gB0r2jK9bp/eNf/sYpsIKo5lhg3XyvzVOIELKzO1ELFuQyFpQEMajmZQLrSNqLdI3YuXEHl2uhOfPkKIce94gRx/rDEEkGDjuv5O1h9xerjrXpxFy9R+QnnytOwdzrqi2LtUTaql50YcvwvRAX6U+cLUWN6MdCh66hhFvWDmT6beJaeTlzHp70x5KFV4INX6mmoOPO4aHCFE6XxztMEy2DPOeit1uNJBxuClCKmMpmqU5wO+m+jsSy/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7256db-f0db-4392-0ab5-08ddc4487787
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 09:09:27.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: om76oZ6JOuAsT9kMmd5Yvl7QIaiTjZo2qQGZ4xy9Z9UeqKjXlGW1Ezk1JiT8m6nuALMecnnKrgfUZE2xZ1ZyGuOdiYwpyk7RrcAuTdfc3L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6332

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


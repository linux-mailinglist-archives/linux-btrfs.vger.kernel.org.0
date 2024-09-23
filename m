Return-Path: <linux-btrfs+bounces-8163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF25B97E757
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 10:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0042815D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E718B48C;
	Mon, 23 Sep 2024 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WKez8H5V";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Un6QI6cI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31518A952;
	Mon, 23 Sep 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079347; cv=fail; b=VZMCBFO5FBeqevIHrFyQASwBxQ4W3e4sTE9DjeVhutjIb3V5eKtLTEy6g9TLbjuoquSPXK7qIPg/SdZFvpNDjf9iwLGY83FeDP45bNOmvH0XG7/zxGELeRaitp6839K3+sG3yztkOmrNla8S5lFrQsPabebDx7vcazCkE61fPVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079347; c=relaxed/simple;
	bh=c8JpFxUj0DNNK9bfCLn72WG7MdXvYNOUISLEOMLzgeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aXXnLPk9DT9MEDZECiqHL3VyHd+VUMRJs5vKaT7J7MbzJJdqhV2z4GF0FN6RC9pBKfa+NL+RjU6+GgJg8VHaH2PLLkyJlE+80zyYDdLkpD+xt/cV7JOGNAYnWJ2dJr0fkCa8wruY8H9ZU4oPkAwwWV27tJ6PhZV2ZtM7FyipsOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WKez8H5V; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Un6QI6cI; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727079346; x=1758615346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c8JpFxUj0DNNK9bfCLn72WG7MdXvYNOUISLEOMLzgeA=;
  b=WKez8H5VnIMqBIPqWD+/i+JmEOklVQWAuSbpXQUCLTytB8ECwvZC90bh
   PHoNNR5kyErsVutqp/9PYzrjab/LDPti4edSOLD1I2a3i2wmo0XLtUbZ8
   Y2UCLA6J+/GZHipHG/gNAZulrtNsdYJoRWVW7XEGb5XzYFXSqIH6PPLhO
   m9PY8F5z5rCdXba+TeDaduQ33hxtULXiTl24oL/xG6e24/0W6ipYYZocn
   nAdVxjn6qFCq+7JlNQF/GayFlWptnKSagygT0uP2SQEjjbycHEgap/dTn
   UOzgZDh/+6YIt7GW7cZiwAWrWm4snIsxpkmvUU2TbNLcmU/3ISIH5XQSa
   g==;
X-CSE-ConnectionGUID: J1Aj/h5tS2OsTG/mSmMh5Q==
X-CSE-MsgGUID: ytJBfcMaSU6AUGeUF2/20w==
X-IronPort-AV: E=Sophos;i="6.10,250,1719849600"; 
   d="scan'208";a="26673036"
Received: from mail-centralusazlp17011028.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.28])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2024 16:15:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmIpP0nJsWfuu9rboj7e73506ZCqWSKshDytnWuQaspcAg5kfiOGyf+DxInDtpw7m+JVdjLJvSgGk0CB6k4h87PB8WdtrkGtW4EeRKB9SGXOLNPHX3SDEWI7aIaiypWsXfiN2YKpY9kL/TpUOqa7MVGTVgyDCele1aZ1grUStIA+9S5u1qffdJfpGzUYfDCs2B2R/jTQF9NrABNwdspSpoJOKrMFEm27f0bOxrZGppS0NFLX9aJi57mvDHE4arqySQGlqZPIIDnPNyl4pzMUblboB0vqtEvYA+AjjffX45sdV0jaq+I6fWG76Mj8r/4CjpGWPYhkJVYtlTRZ2c+uKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8JpFxUj0DNNK9bfCLn72WG7MdXvYNOUISLEOMLzgeA=;
 b=bBjFfYStWeHRJ23S043tfcZoIdkK2s/3ChmLRhbZe9j11WieQhTUU0CrZwm15/fWWuBdp+TLh7lHFJ9Lo6L1KvNez++Hy1843l6+CVjd5h0qTSA1OvY98lPfYLcm6K40oGVF3zMY5N0XJPDHh1JSAeIXi8R81DGahuFu7iV5cp7dZP1D5BKhM1P87YrbeCctLLnMxoK3I4lp0T4o/hqszcmCQk3J6RyRqcWbzL+vJ39I5isRD1HOqYz6wZasRml59nipIuFQ51PGvRDPQ2VDEnLRbD0mZZK4zvSD09+jwvggYCnr+Va+3+OOrGIk5dBlJiji1FBxe+J2qpF6HyX09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8JpFxUj0DNNK9bfCLn72WG7MdXvYNOUISLEOMLzgeA=;
 b=Un6QI6cITrpSl5OisouPJ4taxaCjvyenivPytOjTIUiy5XiOLTsj9Y9G3oMKRFU0HBdVKhOgtT1uDo08W6tmW154SJCZb0meMMDEaZnf+XZZwehYiSvUQuH2NH/7Y7s1I/TyDXz8mrVUEiZcYQOnnFzhNI9GIqiZZz6QywxsatE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8065.namprd04.prod.outlook.com (2603:10b6:610:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:15:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 08:15:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: WenRuo Qu <wqu@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
Thread-Topic: [PATCH] btrfs: also add stripe entries for NOCOW writes
Thread-Index: AQHbDYRHbR6Y52Md7kCz87BUoKnMl7Jk+VwAgAADdACAAARkgIAABUcA
Date: Mon, 23 Sep 2024 08:15:32 +0000
Message-ID: <aacb742c-2081-441e-ac52-d9e0f580ab1e@wdc.com>
References: <20240923064549.14224-1-jth@kernel.org>
 <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
 <3c0c8517-a642-4e7b-bbcd-ef0022c49c3f@wdc.com>
 <d42756f6-d5a8-4f44-a6f0-6056f5c1015b@gmx.com>
In-Reply-To: <d42756f6-d5a8-4f44-a6f0-6056f5c1015b@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8065:EE_
x-ms-office365-filtering-correlation-id: 86fafd9d-4afd-49ce-b1c8-08dcdba7e4cf
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGFkU05SMUJHVUxXeldmblI3R1hsNmpXTk1vWHJPM3RUTWROSE1jcFFWMnBD?=
 =?utf-8?B?S2VtandUSTBWU1laY0VHWEpRdW1QQ0lQMnN5ZHViQVNtYkZKcnF1d2k5NHk2?=
 =?utf-8?B?VWRzKzhCYVNzMk5vWVFZUi93SWU0ejd4K3plVk5DTVViVnJSalhiTEFkOHU2?=
 =?utf-8?B?dExMNHVmL2tCRzBrMEYyUlhiUjFoN2JWQzdqMlIreGpmYkZkZTEybG81Vnpt?=
 =?utf-8?B?aFZ1ek9OdDc1VDVJemg3TVBTM3o2bmhmNHh5d0p6RUVvWm1HUllZbjcrZFJG?=
 =?utf-8?B?MnB0bE5aanV2VUN2QzlhQ2J4TnNaZUV1YkYxWStMZ2JnOWNQQjVvY2JXeXBs?=
 =?utf-8?B?Qi82RXFpRnNxbVQ4QkFGMVlNcHlJWGJETU9BS2ZBN0xsbmU1Nnp5UmpGRllZ?=
 =?utf-8?B?aVZXOS9tbHNvZjNBTVZ0R1N0d0VDc0pLNDdQdTlGVVltcnVJVEU5VWpXcEVV?=
 =?utf-8?B?d0FiZTdzRzJ6RVMzOW1SN2dVTXpTODNkTGpIQVVYeGlmQ3JtbjVjZGFCelV4?=
 =?utf-8?B?MGZrNjE0L0RWeVdGQmhsUmJIYWZGcERwVnNPZy9EVWVwaGJ4aWJ3TEVtbENj?=
 =?utf-8?B?MHI1cG80cXkyWHR1MHVNS0p3a3V2dTVSampWZUdCbG9NYXlQcXJpOVJFNGsr?=
 =?utf-8?B?TU0vNCtCZWtwMEQ0VS9MSE1NN2VKY2s0MW9sZzZqR1NFbHZsY0Z3TWt5Qm1S?=
 =?utf-8?B?VkhMU2ZvRmZDcEpqR3ZHWDZjQzhsUmEvaFNlMmNyV0JNQ2FHeElneUNya0xr?=
 =?utf-8?B?TGp1d0Q0TllCSmFKTDRORm16Q3BTZE9xLysxckVQMkgrMmt4ekRyQVdmUitP?=
 =?utf-8?B?VTdzR3I2WGszeUJxS0xmVWpOeWdISGY4enM4L21weXlxM3RaS3cyMGs1WUFR?=
 =?utf-8?B?OEV5Z2QxQkdaaFVHYXVnRmRybkVyOGpiTGlRcy82ZUQxRTBaQjViVWpUWi9j?=
 =?utf-8?B?Q2l5ZmNVa0tsMWsrV0N1V1ArQ2VQSDY4TzlXcUpkL1hIRFI3a25kakZ6bjRj?=
 =?utf-8?B?dDlHV3FjVUhDc0xHdjZaRGc5L3lsT0ZEWmVPSjJOZU9aNjRpd2M3d2pXY0J5?=
 =?utf-8?B?SnJnUzhpY2pEUE5GY3cvZDJxU2VveXVoMmV1UGk0d05FS045RUZlcXZxdjVj?=
 =?utf-8?B?b1BHRGlHUENyOVpWYWpEQTgwR29pRktzMTJnZ0c3NHEyN28zNlU1ZkxOazJ0?=
 =?utf-8?B?bUs3YjNYc3NJa1N4WUJlQUE3VytPZlFsb2x2MHMzN1Ewbm8xZENsMDdXVlhT?=
 =?utf-8?B?T245SWJRd2drSk5rcGF0REJYSU5jTWE2bFFBUU9KbHVjLzNtRFdQZVl0UEcy?=
 =?utf-8?B?emd4R0lxclQ0Tis5SCtEbFBhWE9aRzFlYkNxWGRueDlCNVhWTW82Y2F4aDJm?=
 =?utf-8?B?WEF6Zng3dFVkSlM5ZjliSFdXdkdPMmRXNi9YU05kZU9ZQ202dUxrYmVMemRG?=
 =?utf-8?B?TGJqQ3RsV2tTdS9wNHBHSFFEU2kyb1lvRXpwekRwS3YvSERCeHcrUnFZSGlB?=
 =?utf-8?B?bnBOdG84bmJQdFFJRGlYVFJTR2x3VEY2MDVQUExQSnlKaFhFbGx2TFBUWmtC?=
 =?utf-8?B?TmhPLzZiek5TbGJqQjRSZHRaSHhocHV6WU5ma05zaGZMcGRoTmp4TEw4OG9i?=
 =?utf-8?B?RDFpTmxDUG1IcndaZ2V1MGVCL1gvU3E3RnBldnl4bXdTcElzZFAvb0NtQ2Vs?=
 =?utf-8?B?dmxHdVJ3alRMaHdYNHc5YmFYV3hpZU5iRkhNOUFuTXlRUjlyZTE3bjRsb3lQ?=
 =?utf-8?B?YmVXbFRDN1ZEZW8vN2Uyenk0RHFDREhqcC9lby83WCtpcUpiRzByUWdJYzda?=
 =?utf-8?B?cm5kb2RNYkJuWGxPZ1gxdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHRTVHlvZzhMUU56cUtPMWhTczllZSs3UG84T0xYTzk3MnNqTkpwY2ZRbWVU?=
 =?utf-8?B?WUxKSW0zWVByQkdmOFNLc1FraHk3Ry9VK2N1Y2kzWjc5TlYzMGorYVc0MWJu?=
 =?utf-8?B?dDJBUmhEOGlBdVVzT1ZrZzVRNkMvbWpURUs3RUpEalg0Q1g2dFlMMEhhT1Bo?=
 =?utf-8?B?akFoZEdzeEhDUUNhb21MYXhzQjc0VGVaSnZ1Vkx4UXVVMHY3QzFqQmlDcXVy?=
 =?utf-8?B?bFVjbUhVc0Z1dm5jK1ZNanlWQ2VDS2V5SDNIUURQOVJoVWJtR2RxOU5PRnlr?=
 =?utf-8?B?enlHTjJyRHkrclh3RmV3VXlHT29aK0dmMUZ6ZlNMaWdlMXI5VGxpS2JOUHdN?=
 =?utf-8?B?U0RTMFkzS0dTaVhtNWMrcGlMVmN3bDdxUEdqdWNsb0VqTHkvT1prbytCUSs3?=
 =?utf-8?B?SXN2ejd6WWQ5QmxqbjhCZWxEUjR6VEVST0x0akJKVnYvdWpWZDBaQ3RuK2h1?=
 =?utf-8?B?aHVnMlJQSmpGNmtZa1pwWTVqN3Z6V3ZXbGhXRlFURTcvVkluZmYyb3NrZGpr?=
 =?utf-8?B?QTN6b3JkOXQ0dkxwRWxMdXcweWZORVozTXo2TTZ5dTZETVJ6QzFXNlZGWWZT?=
 =?utf-8?B?Z204V2ZFYlNScGtyWHBtcmdQbzBFemNFRzZEY3RPRkl1VWQ5T21lcE1ESys1?=
 =?utf-8?B?Z1RZNW5UKzF3Y2RnTTNKTTVlb2RabGxWSnVVdllrUmdQNXFaRlU1N2FIQm9N?=
 =?utf-8?B?RG10c3VBZkNjVFNIWXZwMDIwMnpkdlJSTmI3WjR5L21Db2U1R3ExMk92L2Ex?=
 =?utf-8?B?eWxPL3hyL0I0OUliSVNzM0JSVnljeCtQanM3bVRjZ3ZZUFdpVHBhSXhtUkpn?=
 =?utf-8?B?TXR0T3BwV3Npc2cwVlgxOEpibCtVNEpaNmZGQ0dVNGl1aytneEp6R0ZSNnNR?=
 =?utf-8?B?MzZ6ZDhMdVV6WTY0TlI3dnBZQmt3MU9odllDdjZ6S2hlcFEwRURFUEFhUGRi?=
 =?utf-8?B?dkRwd2ZOUEFyM0FkM081Z3QxNG00VEplOHZzRVBwNlVKN1Z4ejVjcnlFMGY4?=
 =?utf-8?B?a001dk1pUDVXNGlrY2t2VncvbE4waXBvekZYb3ZYTUd5VmwzU1c3UFpVVnM3?=
 =?utf-8?B?Rkp1ZWw2Smp3cDNVNDFRZ3UvOUJCN2F5SWJoM2Z3TWFIWHpTLzlObVFPWkor?=
 =?utf-8?B?QmZoSHlyUVF5am4yZGNMbGNwR2VmaDhVV0tRWnBJK3VIeTBlY0Vpanlja0hK?=
 =?utf-8?B?aE4zTFZZSFlJYUVtdnd5Z0dqWVpnZm1lZkNKc0R6S0NLblhWb3hoU1ZKc2J3?=
 =?utf-8?B?MmNHUFJBS01RSVgzYXE1YVhnTWZxb3Q4dWpUVlBFT21nUStPOHprT0Z0RFc4?=
 =?utf-8?B?OWpjZXRsV0NrSG9tUVQ5WHU0T1NrSWNDS0hFRFdaZzBVK0Z6NGhSb3RkbWpS?=
 =?utf-8?B?RDZDUHJvZ2pXNGkrcUhBdjZDdmRzTGRudnZpYmJYU2tRTStIWHlxOGNnTmt6?=
 =?utf-8?B?MDVySXhoS1Urd1gwNXVkdGx2NklmRHc0SnJsaCt5WVNYV1ZvSkJtUWZMWGlX?=
 =?utf-8?B?Qm0wWm04UlZxaXJSUXQvV09ZeE5BYVZRc1U2aC9yMGlzbWlUc2VqS0dnMElU?=
 =?utf-8?B?cXJWNUJ5dUNLVkJXY3V2OGtUdHVyTlFmZDFSKzRvREJ2K2lkenMwT0dCNWdm?=
 =?utf-8?B?aUlMQ1dQSDFKM3YrVENuemlhb3BFditWcVhyZGNnaUxqTEZVRDdDSmNDejlw?=
 =?utf-8?B?M0U1OEFnMjFlVVpQNy83YWZGUjFwVkI5QTcxeUN2SEpScWV1SkNveUZwRDlw?=
 =?utf-8?B?c3Zja3dKUDdab3ZzS2dMbnBEdEJ1M0lCTGkwS1FnYzZ5dzNzNjA0SXhTK2FH?=
 =?utf-8?B?YXJMSlI2Q0xMVFdlSXdPTmtMaWMxSW4xWU05QldqdkJwZzI3aTB1VlROd2xu?=
 =?utf-8?B?UzRpUTVIL2J5VjZXcnU1d1Z2TzVkdmFlczMvWEwxZ1lIOUd6NHFDb1h0ZVlP?=
 =?utf-8?B?VURITDBpTlVMbkRSRDdXdUwzMFBSN25LQU1LVTlSdnp4S1dKcEVORzJkYkhv?=
 =?utf-8?B?ZWFhNnhHVHVnYmxWZ1Rwa1RGMytld2xQaWRTam5weFdubEkxRFNsOUJ1NlM0?=
 =?utf-8?B?K1hzRnJxOUdoRDI5b1FJNi8xUkx2dUlDK3A3d0NTMGJyV05vRFBOaE12MWVY?=
 =?utf-8?B?SC9OcmxHZWl5VWYzSlVsd01jM011Mkx3T3VBRmVzK1JYS0ppTmpJSG9Naktp?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91821818BFD12A4D949130903AC988AC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KGmv8bEjZPsqEinxbxJSepiCVcuMsMUxS8174dQKZh0sOYfN91calRM53qDNqxTE/Sj2mtsgK0uvz+Qm7XzBprl0RQiK03/mmFl7tCur0+F4g8TItGfns1NvzXa4AQv7WDefXuMzpzKe3JD3FftUofAUtxwpTPjmWySoAdyvFDQJdfAkd9N2oaye30g8fBk7HVlpY401ntdCHOuDEmHvr7RZ0kpWg5nq809Tpn1vNHqpPwI5AmENP8XQJLs/yG7MsFdc34beXBQ54ohCpchOabJgRLXuK6Z3DZa0Z6kFNVGlhOndVs21G111qj3nmYnFT7yG1fs+4/Iiy2FUv+HTBrBaG1N6X396WUFkyxlpmlwHRMaV0d37w86qg3Vi0lER7x4/4gxMRVXFLm85c35M5bLtkieeUk2/CYzzV2w6uNYWSRLAiW+XzJ/zYXoN2adGNfDPbMG51Hy43SmWRjgG4NS8acB2iMZfQrnemhbnzQTtTFWq/2DMTu4T/ItRj4Q9UBh1T0m4uvubmo3M44Jloq/GxXtZ57MRZmX0a4rT3mQYShWHKRLec4by5ehbuoQd706zZSKgkiqEUOVq+xfEjaopPTZOt3y9S77W+ceNhCO6pIYOcXy/EqxHfrNziNIN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fafd9d-4afd-49ce-b1c8-08dcdba7e4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 08:15:32.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvLJD1AHPHbgQvgFagnZo+ftViy++6tpMZ5vwW9w1bVdS3tDm4B7lxQ0HxUpQ2PFO6vZlaevrPyB/kyHeyELjswKsCs8pBryNEpNUuXE3Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8065

T24gMjMuMDkuMjQgMDk6NTYsIFF1IFdlbnJ1byB3cm90ZToNCj4+PiDlnKggMjAyNC85LzIzIDE2
OjE1LCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPj4+PiBGcm9tOiBKb2hhbm5lcyBUaHVt
c2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4+Pg0KPj4+PiBOT0NPVyB3cml0
ZXMgZG8gbm90IGdlbmVyYXRlIHN0cmlwZV9leHRlbnQgZW50cmllcyBpbiB0aGUgUkFJRCBzdHJp
cGUNCj4+Pj4gdHJlZSwgYXMgdGhlIFJBSUQgc3RyaXBlLXRyZWUgZmVhdHVyZSBpbml0aWFsbHkg
d2FzIGRlc2lnbmVkIHdpdGggYQ0KPj4+PiB6b25lZCBmaWxlc3lzdGVtIGluIG1pbmQgYW5kIG9u
IGEgem9uZWQgZmlsZXN5c3RlbSwgd2UgZG8gbm90IGFsbG93IE5PQ09XDQo+Pj4+IHdyaXRlcy4g
QnV0IHRoZSBSQUlEIHN0cmlwZS10cmVlIGZlYXR1cmUgaXMgaW5kZXBlbmRlbnQgZnJvbSB0aGUg
em9uZWQNCj4+Pj4gZmVhdHVyZSwgc28gd2UgbXVzdCBhbHNvIGFsbG93IE5PQ09XIHdyaXRlcyBm
b3Igem9uZWQgZmlsZXN5c3RlbXMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVz
IFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+Pj4NCj4+PiBTb3JyeSBJ
J20gZ29pbmcgdG8gcmVwZWF0IG15c2VsZiBhZ2FpbiwgSSBzdGlsbCBiZWxpZXZlIGlmIHdlIGlu
c2VydCBhbg0KPj4+IFJTVCBlbnRyeSBhdCBmYWxsb2MoKSB0aW1lLCBpdCB3aWxsIGJlIG1vcmUg
Y29uc2lzdGVudCB3aXRoIHRoZSBub24tUlNUDQo+Pj4gY29kZS4NCj4+Pg0KPj4+IFllcywgSSBr
bm93biBwcmVhbGxvY2F0ZWQgc3BhY2Ugd2lsbCBub3QgbmVlZCBhbnkgcmVhZCBub3Igc2VhcmNo
IFJTVA0KPj4+IGVudHJ5LCBhbmQgd2UganVzdCBmaWxsIHRoZSBwYWdlIGNhY2hlIHdpdGggemVy
byBhdCByZWFkIHRpbWUuDQo+Pj4NCj4+PiBCdXQgdGhlIHBvaW50IG9mIHByb3BlciAobm90IGp1
c3QgZHVtbXkpIFJTVCBlbnRyeSBmb3IgdGhlIHdob2xlDQo+Pj4gcHJlYWxsb2NhdGVkIHNwYWNl
IGlzLCB3ZSBkbyBub3QgbmVlZCB0byB0b3VjaCB0aGUgUlNUIGVudHJ5IGFueW1vcmUgZm9yDQo+
Pj4gTk9DT1cvUFJFQUxMT0NBVEVEIHdyaXRlIGF0IGFsbC4NCj4+Pg0KPj4+IFRoaXMgbWFrZXMg
dGhlIFJTVCBOT0NPVy9QUkVBTExPQyB3cml0ZXMgYmVoYXZpb3IgdG8gYWxpZ24gd2l0aCB0aGUN
Cj4+PiBub24tUlNUIGNvZGUsIHdoaWNoIGRvZXNuJ3QgdXBkYXRlIGFueSBleHRlbnQgaXRlbSwg
YnV0IG9ubHkgbW9kaWZ5IHRoZQ0KPj4+IGZpbGUgZXh0ZW50IGZvciBQUkVBTExPQyB3cml0ZXMu
DQo+Pg0KPj4gUGxlYXNlIHJlLXJlYWQgdGhlIHBhdGNoLiBUaGlzIGlzIG5vdCBhIGR1bW15IFJT
VCBlbnRyeSBidXQgYSByZWFsIFJTVA0KPj4gZW50cnkgZm9yIE5PQ09XIHdyaXRlcy4NCj4+DQo+
IEkga25vdywgYnV0IG15IHBvaW50IGlzLCBpZiB0aGUgUlNUIGVudHJ5IGZvciBwcmVhbGxvY2F0
ZWQgcmFuZ2UgaXMNCj4gYWxyZWFkeSBhIHJlZ3VsYXIgb25lLCB5b3Ugd29uJ3QgZXZlbiBuZWVk
IHRvIGluc2VydC91cGRhdGUgdGhlIFJTVCB0cmVlDQo+IGF0IGFsbC4NCj4gDQo+IEp1c3QgbGlr
ZSB3ZSBkbyBub3QgbmVlZCB0byB1cGRhdGUgdGhlIGV4dGVudCB0cmVlIGZvcg0KPiBOT0NPVy9Q
UkVBTExPQ0FURUQgd3JpdGVzLg0KDQpCdXQgYXMgbG9uZyBhcyB0aGVyZSBpcyBubyBkYXRhIG9u
IGRpc2sgdGhlcmUgaXMgbm8gcG9pbnQgb2YgaGF2aW5nIGEgDQpsb2dpY2FsIHRvIE4tZGlzayBw
aHlzaWNhbCBtYXBwaW5nLiBXZSBoYXZlbid0IGV2ZW4gY2FsbGVkIA0KYnRyZnNfbWFwX2Jsb2Nr
KCkgYmVmb3JlLCBzbyB3aGVyZSBkbyB3ZSBrbm93IHdoaWNoIGRpc2tzIHdpbGwgZ2V0IHRoZSAN
CmJsb2NrcyBhdCB3aGljaCBhZGRyZXNzPyBMb29rIGF0IHRoaXMgZXhhbXBsZToNCg0KRmFsbG9j
YXRlIFswLCAxTV0NCnZpcnRtZS1zY3NpOi9tbnQgIyB4ZnNfaW8gLWZjICJmYWxsb2MgMCAxTSIg
LWMgc3luYyB0ZXN0DQp2aXJ0bWUtc2NzaTovbW50ICMgYnRyZnMgaW5zIGR1bXAtdHJlZSAtdCBl
eHRlbnQgL2Rldi9zZGEgfCBcDQoJCQlncmVwIC1BIDEgRVhURU5UX0lURU0NCiAgICAgICAgIGl0
ZW0gMTMga2V5ICgyOTg4NDQxNjAgRVhURU5UX0lURU0gMTA0ODU3NikgaXRlbW9mZiAxNTgyOCAN
Cml0ZW1zaXplIDUzDQogICAgICAgICAgICAgICAgIHJlZnMgMSBnZW4gOCBmbGFncyBEQVRBDQp2
aXJ0bWUtc2NzaTovbW50ICMgYnRyZnMgaW5zIGR1bXAtdHJlZSAtdCBmcyAvZGV2L3NkYSAgfCBc
DQoJCWdyZXAgLUEgMyBFWFRFTlRfREFUQQ0KICAgICAgICAgaXRlbSA2IGtleSAoMjU3IEVYVEVO
VF9EQVRBIDApIGl0ZW1vZmYgMTU4MTYgaXRlbXNpemUgNTMNCiAgICAgICAgICAgICAgICAgZ2Vu
ZXJhdGlvbiA4IHR5cGUgMiAocHJlYWxsb2MpDQogICAgICAgICAgICAgICAgIHByZWFsbG9jIGRh
dGEgZGlzayBieXRlIDI5ODg0NDE2MCBuciAxMDQ4NTc2ICAgICAgICAgWzFdDQogICAgICAgICAg
ICAgICAgIHByZWFsbG9jIGRhdGEgb2Zmc2V0IDAgbnIgMTA0ODU3Ng0KDQpXcml0ZSBhdCBbNjRr
LCAxMjhrXQ0KdmlydG1lLXNjc2k6L21udCAjIHhmc19pbyAtZmMgInB3cml0ZSA2NGsgNjRrIiB0
ZXN0DQp3cm90ZSA2NTUzNi82NTUzNiBieXRlcyBhdCBvZmZzZXQgNjU1MzYNCjY0IEtpQiwgMTYg
b3BzOyAwLjAwMDMgc2VjICgxODMuMjg0IE1pQi9zZWMgYW5kIDQ2OTIwLjgyMTEgb3BzL3NlYykN
CnZpcnRtZS1zY3NpOi9tbnQgIyBidHJmcyBpbnMgZHVtcC10cmVlIC10IGZzIC9kZXYvc2RhIHwg
Z3JlcCAtQSAzIA0KRVhURU5UX0RBVEENCiAgICAgICAgIGl0ZW0gNiBrZXkgKDI1NyBFWFRFTlRf
REFUQSAwKSBpdGVtb2ZmIDE1ODE2IGl0ZW1zaXplIDUzDQogICAgICAgICAgICAgICAgIGdlbmVy
YXRpb24gOSB0eXBlIDIgKHByZWFsbG9jKQ0KICAgICAgICAgICAgICAgICBwcmVhbGxvYyBkYXRh
IGRpc2sgYnl0ZSAyOTg4NDQxNjAgbnIgMTA0ODU3Ng0KICAgICAgICAgICAgICAgICBwcmVhbGxv
YyBkYXRhIG9mZnNldCAwIG5yIDY1NTM2DQogICAgICAgICBpdGVtIDcga2V5ICgyNTcgRVhURU5U
X0RBVEEgNjU1MzYpIGl0ZW1vZmYgMTU3NjMgaXRlbXNpemUgNTMNCiAgICAgICAgICAgICAgICAg
Z2VuZXJhdGlvbiA5IHR5cGUgMSAocmVndWxhcikNCiAgICAgICAgICAgICAgICAgZXh0ZW50IGRh
dGEgZGlzayBieXRlIDI5ODg0NDE2MCBuciAxMDQ4NTc2IAkgICAgIFsyXQ0KICAgICAgICAgICAg
ICAgICBleHRlbnQgZGF0YSBvZmZzZXQgNjU1MzYgbnIgNjU1MzYgcmFtIDEwNDg1NzYNCi0tDQog
ICAgICAgICBpdGVtIDgga2V5ICgyNTcgRVhURU5UX0RBVEEgMTMxMDcyKSBpdGVtb2ZmIDE1NzEw
IGl0ZW1zaXplIDUzDQogICAgICAgICAgICAgICAgIGdlbmVyYXRpb24gOSB0eXBlIDIgKHByZWFs
bG9jKQ0KICAgICAgICAgICAgICAgICBwcmVhbGxvYyBkYXRhIGRpc2sgYnl0ZSAyOTg4NDQxNjAg
bnIgMTA0ODU3Ng0KICAgICAgICAgICAgICAgICBwcmVhbGxvYyBkYXRhIG9mZnNldCAxMzEwNzIg
bnIgOTE3NTA0DQoNCg0KdmlydG1lLXNjc2k6L21udCAjIGJ0cmZzIGlucyBkdW1wLXRyZWUgLXQg
cmFpZC1zdHJpcGUgL2Rldi9zZGENCmJ0cmZzLXByb2dzIHY2LjkNCnJhaWQgc3RyaXBlIHRyZWUg
a2V5IChSQUlEX1NUUklQRV9UUkVFIFJPT1RfSVRFTSAwKQ0KbGVhZiAzMDYzODA4MCBpdGVtcyAx
IGZyZWUgc3BhY2UgMTYyMjYgZ2VuZXJhdGlvbiA5IG93bmVyIFJBSURfU1RSSVBFX1RSRUUNCmxl
YWYgMzA2MzgwODAgZmxhZ3MgMHgxKFdSSVRURU4pIGJhY2tyZWYgcmV2aXNpb24gMQ0KY2hlY2tz
dW0gc3RvcmVkIDllZDk0YjRkDQpjaGVja3N1bSBjYWxjZWQgOWVkOTRiNGQNCmZzIHV1aWQgYmVi
ZjE3NTUtOTM3OS00YWM4LWE2MjMtYWQwZGM1MjY0MWNmDQpjaHVuayB1dWlkIDQ2M2Y3YjFkLWMw
YjgtNDM3My04MzM0LTUyZjViZjgzNDc1ZQ0KICAgICAgICAgaXRlbSAwIGtleSAoMjk4OTA5Njk2
IFJBSURfU1RSSVBFIDY1NTM2KSBpdGVtb2ZmIDE2MjUxIGl0ZW1zaXplIDMyDQogICAgICAgICAg
ICAgICAgICAgICAgICAgc3RyaXBlIDAgZGV2aWQgMSBwaHlzaWNhbCAyOTg5MDk2OTYgICAgICAg
ICAgWzNdDQogICAgICAgICAgICAgICAgICAgICAgICAgc3RyaXBlIDEgZGV2aWQgMiBwaHlzaWNh
bCAyNzc5MzgxNzYNCg0KDQoNClsxXSB3ZSBwcmVhbGxvY2F0ZSB0aGUgZGF0YSBmb3IgWzAsIDFN
XSBAIDI5ODg0NDE2MA0KWzJdIHdlIGhhdmUgdGhlIGFjdHVhbCB3cml0dGVuIGRhdGEgZm9yIFs2
NGssIDEyOGtdIEAgMjk4ODQ0MTYwDQoNCldoYXQgc2hvdWxkIEkgZG8gdG8gaW5zZXJ0IHRoZSBS
U1QgZW50cnkgdGhlcmUgYXMgd2UgZ2V0Og0KDQpbM10gdGhlIHBoeXNpY2FsIGNvcGllcyBzdGFy
dGluZyBhdCAyOTg5MDk2OTYgb24gZGV2aWQgMSBhbmQgMjc3OTM4MTc2IA0Kb24gZGV2aWQgMg0K
DQoNCg==


Return-Path: <linux-btrfs+bounces-6314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A402B92AF97
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 07:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04631C21E92
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 05:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104012F5B3;
	Tue,  9 Jul 2024 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jwUJn3xP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p6HecWb2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592A139F;
	Tue,  9 Jul 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504338; cv=fail; b=UqHAW7c3nYjf9PNyNmMjIESlyWYCPRkVyg5Azr4TM2M/4rrErEkD+sSKXW4AMKLx9ltiiYUnZu4qija8bU3ezn2rZEYxbaLJ7VZclwW/r54AnOQwpG/aGvdRUoa19HLLNveiJAPD7PcYRp8z+9YTImQQ16lKDLuVAqP4nVy6m/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504338; c=relaxed/simple;
	bh=oWhREnkmVkLCyo5aNiuNItK9wIwURqwX2icw6q7U8PE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hhC5vLF6yeD57QAMQ0mSrSOSNw67a0CG5LsAP8zwV5Q8W89orfW5RJe1QhnWLBMBsoO+MFb0RNNEq94eLTww0Yy8UP8l0lAOGWWeKP8oc/X2mXQX8rBp71JugLhjSxQ3i+GnPTJrK4RvUZ65Liia4b2JSZGEtFhAOA6U4ngm3Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jwUJn3xP; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=p6HecWb2; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720504336; x=1752040336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oWhREnkmVkLCyo5aNiuNItK9wIwURqwX2icw6q7U8PE=;
  b=jwUJn3xPXe4PVlP+BcAlpNYgdY85hUQJkZWUD6ujwmSDNQSFd5v9unIC
   BWkc+HmqB2cPu23D6J4y+ApNZjlyhSl777jDzT9r7fcLgaXR3e1rK4TZk
   v5jHde15k4KHdgLP5iNReMPj1Rh35+BTUYiItWXHIDswT6Pu8SFZByg/9
   AOUC6TWxnHHZ/LtatbkU236WFIeTpeE/MvHeQXVNSWRtRFKPMBafO90bS
   2NXDb4w4hQLfDs+KrXx5+L3VQnOfoN/n01g84Vkxp++sGNUVYp8qmDWh+
   R0LSzHZYEzepXQ8hYwUmF2XkCEIrc9xmRVm3SgO3EQ7RSPs6JtLKdMjIK
   Q==;
X-CSE-ConnectionGUID: aQwBN5SlTJ2bJLREsVmBgw==
X-CSE-MsgGUID: qyY75GZZRuqnprwYI63Ylw==
X-IronPort-AV: E=Sophos;i="6.09,194,1716220800"; 
   d="scan'208";a="21919672"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2024 13:51:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjkjlqUFwvFL3C5Szb0DwkOWZYiQ8LFW58vK023KsKgIj36SO9lT9ieFVxUGaNQfaU5GJlI8rPNCSOmouizoHNmc04CQaGIhLkzyWCb2QFdxdXXyag2AE5IxUadByWkxD2lzJF9WbRK+nkPf3Yei/NhWr1zI+4pb6FGCOzwzQmbiF52/PTLOfGYWr3XcP1HlwatR2exHjV8yufA3eHNakE5AsRdosj5lgT0zvsIvchrSy5SiBgMiVmaBKWmQOwBudmrvlbmGfDI+asMLQTQaliTYo1lWR0Z3JZMlKMFzSZWYPQc/d9cSK0cDGHXhKZklWOOZlvc86o9Y1BqdrKP23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWhREnkmVkLCyo5aNiuNItK9wIwURqwX2icw6q7U8PE=;
 b=f/JmudBFN1BLe9esHGrM4s1cOiofpzWRNtZCO0vf2e5Hak4Wet2HsEK6EGiZ+K0fMaSaTDp0/LzV/ANFQ10YqL/VShWihWRypC0JAG/kfzswc7YN7VpQJm+o9tVX36FXkUdcWShn5h3q/6xKBYj/fkN+E+s7hwgAdSVsx3y1etTtUbXavaYtjCLOCr2Vfkasn58VpkkK/vRNRjhjWJnMLm10LyOyQOGEoB/XF1k1cas6OlhyMNmJaujEE/Er4sUX5uyHnjtJPYFjUGV6i+g/PWbPwPMMXpbV9KvAB0VWnoNMHlQCS3pODEQtDVd+yg7PzHLS6AFdD1rzX9KCZGzecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWhREnkmVkLCyo5aNiuNItK9wIwURqwX2icw6q7U8PE=;
 b=p6HecWb2zQVufPttdopDy4HwYoHOhpkIfkxE6ae0SG2ZWKxV87IHOQsvU2bKvnRpVBHJma2znt+5DxV15HKAxQz/SGq8xMaw0NOH4C1ihrruEZuGSTcetHCCtW83JFkgChMpU/O+o4fZPe/6DamayguIoAVrTIqu0MbJWll/TxI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB9341.namprd04.prod.outlook.com (2603:10b6:8:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 05:51:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 05:51:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
Thread-Topic: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
Thread-Index:
 AQHazu35+gWM7QXR/kW5py9pDxK19rHox7kAgAOA7YCAAAZ7gIAAAY0AgABbQQCAAMv5gIAAcjQA
Date: Tue, 9 Jul 2024 05:51:04 +0000
Message-ID: <1b705de8-ffa6-46e3-a6ac-f7c7799558e3@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-3-f3eed3f2cfad@kernel.org>
 <e0041c2d-f888-41cb-adb8-52c82ca0d03f@gmx.com>
 <e3927e86-d85e-4003-9ce5-e9e88741afa3@wdc.com>
 <ecd368a8-2582-4d23-a89d-549abb8c4902@gmx.com>
 <d0c28a38-23d4-44f3-9438-e374be1c33d0@wdc.com>
 <50d64ebb-857b-45ad-9f98-70353dfef535@wdc.com>
 <99cc2be0-ea62-430b-8395-a915be48e9bf@gmx.com>
In-Reply-To: <99cc2be0-ea62-430b-8395-a915be48e9bf@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB9341:EE_
x-ms-office365-filtering-correlation-id: 7eb67e8c-3994-44f8-bbc6-08dc9fdb1f1f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?akxzUkhqdzdGeEh5L3BMcVZDNFRldWVjTGNvNmxnK3BXTXFjL1FhTER5dmY5?=
 =?utf-8?B?S2lCQWIxRlNUMldTc25pL095Z082NUlnODNsbHZkbzJDV2JYRVZGVWFaNG9N?=
 =?utf-8?B?S2FHbXM3Ri8ybWQ2enV6SjBwMEZ6Z3o5WUk4WjNpM3A1dVpmRE8zL243blph?=
 =?utf-8?B?RWxLZTBXZTdUK1FqdXlUMzRqU0gyYXhIZGUyYjFyeTRsd0V1d3VlV1Q3YlVi?=
 =?utf-8?B?ZUtPakZFckN6WnltalZvQk02eTNOWURSN0lYUDYyVWhSS2hma0ROM2xraVk5?=
 =?utf-8?B?VUdxWElwcDlFaEJLNm9XVXAwOXRmRCtUeERyQmxNbUR5VUxvNHh1azJrSFlk?=
 =?utf-8?B?RFJXaWUvZGV4MlJDVEJnVjlPZkVic0Y4R2FZYUxneXhnR2R1U0VGT2xFZDZo?=
 =?utf-8?B?Sm9ZYktjQVpEWFpQTVZDUElwWmJtbGZKNzFZSGtNeEYzQ0hhTUhEQXBieGRs?=
 =?utf-8?B?RWs4cnRSWmJ2TXdQSFNSSUJvSTFBZzZoNGpqbFhNVUxZWGEzQlNacTNrSnlR?=
 =?utf-8?B?MCtFQTVBU05rbkJKOUlTQjhOb1o4SHFIaXhYWnlBSitVeWJvdG9LMFBsT1Mr?=
 =?utf-8?B?R3VuTUZPWk5aK3IzVVFLaFNISVVsdk5uU2p3a1g2TzZWaEFaYzNtUzVxcHA0?=
 =?utf-8?B?WkNQT2EvYWVvaGx2am1oQXFnUDFXYWNPU3N1U1FGK1J5c2Ezakg5RUI3SGRI?=
 =?utf-8?B?TnVRVTY4VEtqUkpqclhXU0ZDNHJyRkdyWktSSXJyRWordVVmM3krSHlKN3FM?=
 =?utf-8?B?cE9VZzVrWElGYmhqcmQxcUJNUGRyNTlqdWlWR3p1dGhiNDNBZVp6aUNUZGFH?=
 =?utf-8?B?ZGErWUNuakcvNHN6SXlYTVQ3Uk1PZDA5UFNpUENudjEvU2hBbWZRVEdCblZj?=
 =?utf-8?B?UnNYN1hLbE9lbVVyV3RYdndveVVnYjR5d054SGh1Qk9OeDJna1V3b2ZYeWFD?=
 =?utf-8?B?RmRrSzFvSk1WVHNGR05ydmh6T0VGNHg1eTZiVTNwYWNNRWhmaGxKaW5mdmhz?=
 =?utf-8?B?bndOYVVSMW9xMGlrYkZKNFJLWXViRVBzSE5VL3Q4blVVbVJuVXN5ZUxmRlVq?=
 =?utf-8?B?VXBSTkV3V1Nia2Z1ZmlBQXk0UHpmWXB0QzZlWXFBS0Rvc1pmTUUzVEpFWnlJ?=
 =?utf-8?B?L0tOZTlneUZjNzBJdEFjb01Uczc3UFU4dUUwRDZIS09jMzFQcDh3bjhUL1hU?=
 =?utf-8?B?YTVQalJEM2RVMHVONU5qZ3BBSWJBN3prRGNJMDE5c21jUXRoMzBkcDcxK081?=
 =?utf-8?B?WE1EbW9LR3lVc2d6S20rU21sdFJLSUY3THhQbU1Ub2cxUnkvenpWcDhBaE93?=
 =?utf-8?B?Zlo1RkhvbzZqa0ptV21MSGlDcFpqdUJyVXl2YTF0bXlBalJKK2pQb2N4dTFw?=
 =?utf-8?B?ZTFnZzVaYVdPai8zTUpaOHVuN0h6dEkvOTNZRGVwQ2FncHJPbXRvSVpnYTk1?=
 =?utf-8?B?VVpkUUE5eXVERzVLV3JUWVhNS3hGOURKaVMrQ1kvRnJiOURHVUhySS84Y0tv?=
 =?utf-8?B?ZnVudWhiVEhPd1B3dVNLUDBTWmVySnE1aVRGeUZ6MmpnV0pkM2lKejBQcldw?=
 =?utf-8?B?cCszUTAxbWFVNjQzaUprby8xRW5kbFU0S0h0MFNGeXpzOXhhNGtZVEJ0WnFR?=
 =?utf-8?B?Zmh5dGRTS090NFkxa3BEd2VpZTBTWjlxTWhvWElEd1B3bnRqbDRZblVrVmRE?=
 =?utf-8?B?dlovQ2ZEUFhwanRKbmg4V3NqQlR1VFg0dUMzdEIwSVc5T0tqSkFoaDA4MmZn?=
 =?utf-8?B?YUlVLyt5bTRWYzIzamNPR1N4NzJpKy9TeitUbTFNYVVRaFFLMGhiaGZKY1RK?=
 =?utf-8?B?UmhqejlYME1QUTB3T2ZDRW1aNVgrUk1jWEU2SFBVMGIwK0h3NXJXY09aVHlP?=
 =?utf-8?B?Z2lrTmdaa20vS2Z6cEtELys4c1NWb0ZET0Fmc2R4alBKZlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzF4a1hRbnJleGV0NTZ0MXRGZm1ma1BWNzJVVkVqR1BrdXR5UDNjUVd5VERt?=
 =?utf-8?B?M2p2MUlpd2t1dG1XMTZ6bHlENy9jeEo2aWRteDdsSG5TZjdiUlFKMmRLaTBm?=
 =?utf-8?B?TjN1cDZ2MXZXaUpOQWRQUStpNW0yTGE5bE1YcXJMS1lLRTBOS2hjNmxHV1pz?=
 =?utf-8?B?Z0NhVWNrZG5sT2Nsa3Y2KzVoamV5Y2JuR1VvcHdoSFVuOUFObWF4dk1aTTBY?=
 =?utf-8?B?ZWk4eUVwWUJnL0IzVkgwaWNxb2NFanZ4RWZjakd0cE5qSnlURjZkLzFDR3Fw?=
 =?utf-8?B?OUlXNlVBSlVwYm5vWjEvT243b1BPMTR2Z0hUOUxIUE5FSlh4M295WnM4R0Iw?=
 =?utf-8?B?OEg4T2lSaGg4RFVvMHBCUXVkbWF3WW91M3pKeDhGa3hkUlpBNkg0ckMvNUtP?=
 =?utf-8?B?cVZlSWRkb2dlcnlFLzNLckZ4bSt2ajhRSWFqemc0MnoxVkRXTzhSSFRNY1Ny?=
 =?utf-8?B?OFdWTU5HNFNGMkp6cVg3Zm5wSUxWQzgzTnBEUElZQ2xzSmFqVk80RWdBMGhN?=
 =?utf-8?B?cTBwdThyalkxTnJweUpGN2ZqZm92M285amM4WWFpTVkyOGxjdXlKOE5WSzM5?=
 =?utf-8?B?UkpVZjVPayt6VTQ0Y0tKUFRQNDZDU1QzaU9RdkU1M3JSTTlwK2MrRVRoVWE0?=
 =?utf-8?B?Ty9lSFpMZEN1T2RZbzhSUU13OWc4VWl5MFZ1OGlsMElVWVI5SksxV1dGQVR2?=
 =?utf-8?B?c3dlMHQzUzNLeVpCYUhxT0tXVUtCa3JHWTFYK08vSjk2S3A1NWNWcXJLMWZK?=
 =?utf-8?B?RmszNDRXbHBqQWY5MER3eG8vNlpZR0lQRkxOVDNrbkxpbVoyOEhkeFk5QXlk?=
 =?utf-8?B?MHhmZkY3NVZxdThOODJBMHZWOENZRDlkZTVJWU9jYy9nTGw4VUtNNXBQQ2pw?=
 =?utf-8?B?M3VIelNIdjRhcmNKRy9OT2xHQ01lUXRRNFlCZFh4LzI3N05GWHl3WDZBbXBr?=
 =?utf-8?B?UlNPSW0wWC8waEVJelk2VmdUVkMyeFgyWUl3elh0bTlNMS9paWFJU2EwMnlk?=
 =?utf-8?B?eG5uZ1RYOHI4RDNRUi9PNEsxL3d0SDZoOUhGSWdpdDd4OENnZVY1MnF4UUYx?=
 =?utf-8?B?ZzRBOGR0NkEyelFKeGo5L29vM1kvNnVUU2FWWlVSVTJ2RHNCdDBRVkVqS1pu?=
 =?utf-8?B?NGFGTFNWZnpBTHhsWFNmNlZ2TE83S3VVMkxaUTBnVDR3OXN5T1ZIZ2dQd2Fo?=
 =?utf-8?B?Szl1YmtyL0FMaEQ5d29vY2QwVHJESk1mTlVyOUNVNmtmVHIycGsvci9jRVVu?=
 =?utf-8?B?L2g2UlcvYTlsc1RTeDJzalh0Z2tZNm9MaXA4RE1qS2pvdmpuUDI3OUtGcllT?=
 =?utf-8?B?ZnphWWd3VnpMSWZ6V3plVFlWK3NqR1JSNk9uTEZBYnpYVFZVK3NvRnZTaVJm?=
 =?utf-8?B?RXRvdDlhbFR3NW9PVXI5WUxCc0UzcWtWbGtIaGd3bXRSS0JYSHBTQmhCS3hk?=
 =?utf-8?B?R0pwRnY2SWRCVnFQWjNGWjhSM3M4OXlWaDNsTlBBV0lJK2s1S24zZmNGR25w?=
 =?utf-8?B?emdMQnVtTTFCZkpsS0ZxeUVRU2lxS3kxUnZMa2MveWhhclUvbWllalF3dXpI?=
 =?utf-8?B?c0RFNTFFN2ZOWDF1RkU5VDFOVkZocHFTeFd2M3FEZmY5WGMwajNhTVMxdjFa?=
 =?utf-8?B?Q0ZOcXEvNGFrNUV0NmZ4TlVzeUxNeGVlQXZESHdHYnJkdk5sZlV6eS9IcnVC?=
 =?utf-8?B?RlVSbTR2bGFzU0UrYzlqODYxV051cE1QTjBESHo5d3I1UDlyRFJEYW10ZjVT?=
 =?utf-8?B?WkJzQ01OS0puMUptSWJnZVc3aVV5VkNQUHBmREYrVFhvQ29SdHpDY1BQWFo2?=
 =?utf-8?B?WkpOeERmd3RINy8xTnBKRENVc0liYW9sdGpvUXNYbjdOR2JUMGNIRDZvdGVV?=
 =?utf-8?B?WWowL1Q2NzdyZEUxeGplanhra2l4ZFg2eWE5bXBHUjA1dEpyV0ZjanZYeHVn?=
 =?utf-8?B?amVZMlhSUmlvVEo4b0liUWdNWStRakt5ekR5eEZrZFp3OVY3MVFUbGtEMzNk?=
 =?utf-8?B?TTA1MTQ0Yk45NVlwZmJWRWY5Y2d3ZWxLQVpGZXprSVJmNHVUR2RnbmlBdUVi?=
 =?utf-8?B?Tm50c09qbEduQVNVcGU3TjJPUXdwUUkwUldaTVFxZFZnelFDREk4N2czQkRw?=
 =?utf-8?B?U2VkSm9pTFdtZ3F5RzB5cGJaRnBuZHQ0SGwwNm1UbjZyMUE2Z0phRm9NZFpx?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80E3C7D6946D8A4B8D0B91AED5204FEA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ABNIG5tHKgiPROwYQtFGDKmKYrMJBKAUGmdo8scA+jnd+JUvzDf0oUaerAq6K9SpZpYbOvG3n5mbzJ7JY//eIVghtNl/3Dx8gsOBaXul0f4D6TE7ILg2fvTgIM7pmvBC4Kp/tuncZlWRqmXPzbUXABbH9LxMDnArCgxPZha96qkh5E1BJP+qf1bwQPTlaIhjy6rCs7tjQRAFUyOxImQJ0ILZVa6GUho8+E3fmY8W8pc4hqgLTy+Hf1AQNNQJC7APB961wVY/d4Zve0Du+k1smdLdNXcuIwPIfQ2Wm7MMUroypzqqgsNeeRVJc0xAPQC9MGTqjjx7ia51vh8OpxJYPVsd8x8k0gr2/GidVmu903ySN3RyaFDRm8wSrpPX9U3joDUSs6ppVk2k3Y8xnxxjYf0XTZDflZln6mF8xVokGH0OM0zicFAyblNsvYp53nKhwRgs6EALWu0KxbBlM7FJOYNhGggsP1ASEeUfL0a0bgT//7QEDOKPB4b+K+cZ6u0oVF30ejgM6rngfBDCUPopCNByu6kB1Hja5VZbuS6Eek8zAoHTVBF0WFAnWVKNNZCZs3+iNbo2j1XS56ZB0eCm5xTEYKSTFBlz7q1YJt2SnT2oD8jdhbwMAtnAhldhff0W
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb67e8c-3994-44f8-bbc6-08dc9fdb1f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 05:51:04.8541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8S4tUpGvSmKK/y4KIFMEHlttUGccCsup9+RDrTh2tVE+w89iMSRkgjv8wQWkQDRlSVJOLPIRpiDMDNmblZsxdI6KLMCrZrR7ICzXE7P3Fc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9341

T24gMDkuMDcuMjQgMDE6MDIsIFF1IFdlbnJ1byB3cm90ZToNCj4gQnV0IG5vdCB0aGF0IEFTU0VS
VCgpIHlldC4NCj4gDQo+IEkgZ3Vlc3MgSSBuZWVkIHRoZSBmaXJzdCBwYXRjaCB0byBwYXNzIHRo
aXMgZmlyc3Q/DQoNClllcywgb3RoZXJ3aXNlIHRoZSBFRVhJU1QgcGF0aCB3aWxsIGJlIHRyaWdn
ZXJlZCBtb3JlIGZyZXF1ZW50bHkuDQo=


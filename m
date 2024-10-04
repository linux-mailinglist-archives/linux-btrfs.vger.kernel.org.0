Return-Path: <linux-btrfs+bounces-8557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5229999020B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 13:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC731F243B7
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D8157472;
	Fri,  4 Oct 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cMdBxgdV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TCxQttdu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B47137903
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041322; cv=fail; b=CPyYlSg/eos1Jd7b/TlxX3blh6CNWtZdEzYqdJC/avw1p8yqSrF6EuWCvqHKbtFklsnFUnBNifFkjSU2GjtwkI1q5baY95foFTqWvyO9wtRK8OpI9MH/AN/aS41FcePCbWhyBL15FWF491sXpS5A6jUeIEHP+MfymeDuUN/3kh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041322; c=relaxed/simple;
	bh=bCLKDXlP/Qh7ByhKF7j94fUEH1JSPfYJuA9nhx5U4OE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WXuNnGSOaWcqeFr3yFPbNRzkzm7TdnO6GUewlphNqVoDE/2faYzS1cEC0IdUva2E1h9lLkT9yVWCJc5bCksUUpPeyRXTeKk9Jdl+waNPM/XiAToNi1pUaazYjbJffvZM0+/Zi2nWSuACAoND4yctFt5Ly7Suu4nCs+oJeSYBqHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cMdBxgdV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TCxQttdu; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728041320; x=1759577320;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bCLKDXlP/Qh7ByhKF7j94fUEH1JSPfYJuA9nhx5U4OE=;
  b=cMdBxgdVxKX7qmLrePsPIBCSknbRsYdjzph+mWMJj9RdHOZuF5uSfXxM
   c2eEvqRV/MJn0ySSOl74vI/mHJMp5AqfkMt4CEvFLb0Gomn3bnhczNsST
   15q66sQUAdk4qYr1m2saYWBeelZIrHZLiTMpZccbVOYDtGps0KZDYpMFL
   uozke6uv3NED1vjJlvnqqEuR4mzMdweqT5GRHBxHW5XcRjZrdx+o0Dbw/
   cib4a+64YG4AYzsgAYvrObaOc8Y8OfD7ZFCDZwWmepr4W3VGlqCQTcHSK
   kaSHn3mxPePKDN5zZ4ExVSR6iCTV/Ay2lBT2Noy5cRwBla1Z0hbcWitCY
   Q==;
X-CSE-ConnectionGUID: UdFM8xvIQguJ5r99gGmuJg==
X-CSE-MsgGUID: IvUcCfzmT2mWyjFPrZYf0Q==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="29321060"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 19:28:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6Td7sjBCbbHoIPh2GYAFOlUMRLaAk4TU3gZ4NUCCH2O1n+X9KPDGxckGjY3UIJzxsrgrvsVVDky/VvhfMd1FBI5YZ5BnhbE1h2ycd4oKoavk8Zpuoyo6TjR3B41If/8reOYKN7KR9bUI/KNsuLhcM87/CGz8MAtbi2MdAT63ZAnF106toZZVXVQ73od2NZhJUEFF0nqbZIHeiVBwsQe7rfwuFAkiz/sl8mObv80Q7Dt3Ify/m5Bk7fgGjmdqAHAT6PGc0z4/TgECz7/pEiKaxgX7le38qBT5gGXz9YAEronumLtcKL9LdagiSIs5t4tpdvZbmBi2uQV9XnY9irYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCLKDXlP/Qh7ByhKF7j94fUEH1JSPfYJuA9nhx5U4OE=;
 b=tXjg+LcVG7mE0Y/3Q1nKmt3U2CVClOUEpf1x+PQvieQIa9jsAOrthgGBsWMq5If36q3EMwr+fRzMD7FnivkS0pHbSMc6tvdxY0U2S+1FX+05FOfQ/oMThS6AZRSSXbjR2/FGzHcPUKojDqRWcAE+mMbTmlGYBukY941gtggD6Dlp30dSKJdIyXlr5zhegARNfdPVXfC0We3Rpqtou/eFy/JVtN1HrLeAOD33vHl6LCBKyOYk+wAiVgwDyTg/lv96azK3RFftfUwDaf6sbRUPV8UQUW9CRsXdnEpnnskkNAstpYYDT1ybNQImiJCc5WKKV0JwMxzypTP1zaRUkvfafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCLKDXlP/Qh7ByhKF7j94fUEH1JSPfYJuA9nhx5U4OE=;
 b=TCxQttdua+taCeOoxRwp7dTcIC48QJwE/W1MzXP4TYpJoQcm9w2syUUR/x0PcsnxAgz37PACx2QDna8D7I0sZLwrhllc5CliZH/oQ1/mZGD8frCCTD9MI5HybI9aNZd9XYbSp0Lwdb/8xmhn9DtkAFTs5tIiK5WKcud+9aMaSxg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8433.namprd04.prod.outlook.com (2603:10b6:510:f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 11:28:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 11:28:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Wang Yugui <wangyugui@e16-tech.com>, WenRuo Qu <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix the sleep inside RCU lock bug of
 is_same_device()
Thread-Topic: [PATCH] btrfs: fix the sleep inside RCU lock bug of
 is_same_device()
Thread-Index: AQHbFkdQ7oyJHPHknk+jxOsKLZnmQ7J2cXOAgAADFYA=
Date: Fri, 4 Oct 2024 11:28:33 +0000
Message-ID: <c46a0533-2976-4ea5-8fb8-db1ea0e60d93@wdc.com>
References:
 <0acb0e85c483ea5ee6d761583fcaa6efa3e92f01.1728037316.git.wqu@suse.com>
 <20241004191730.C4C3.409509F4@e16-tech.com>
In-Reply-To: <20241004191730.C4C3.409509F4@e16-tech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8433:EE_
x-ms-office365-filtering-correlation-id: 16400600-0882-4bfe-95ad-08dce467ae4b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDFteEZsZzQxMFhTa3U0QW54a3ZobCs3dUpWMldYcjhtTHFYc2x0TmU1N3Vv?=
 =?utf-8?B?OUtud25USmpyb3RtV3RmNFBOWC9Oayt3V05DNVp4N1RpUlZab0g1NU5vSURa?=
 =?utf-8?B?SXdLNXVCaU9VQXRrSjVKQ2RhTFVwY2VOWjhxTlIvcXFMamQvNFM5bUthNEMy?=
 =?utf-8?B?bXJnNkNlVGFJNS95cFBuTVJlbjZ5N1M0Yk1lK2lybVcyR3BvcTljdUdYZ0g4?=
 =?utf-8?B?aWs2ZHFxOGR1bzdJRDRJUFM2V2JYbTlUTEhvQk5rN21WQVczaXJDVW81dklM?=
 =?utf-8?B?ZFE1QS9DMTc2aFQ2ODN5NXRIUisxNzhjTDA5Vm1RODg1bEdKbTNsK0R1Mytt?=
 =?utf-8?B?ZHo2akVyeHZBNHFwWW52ZnVEdndhWXRJVTgyN2RLWFZUbnZJVTdBYytpclBs?=
 =?utf-8?B?OGM4L3NIbWR6VkFXVW5pbi9zVURRMm1PR0tPS0duTDMvWlVLOUpkTURRZ2Yy?=
 =?utf-8?B?d2c4ZTlWTENxK092RDN2YWlVdFVkSk0zSVFJMkw0YTBFdHRuK2czblkzLyt2?=
 =?utf-8?B?T0lPc1pUQng5YlFZRnJXaXgzYkdYdnRqSUtiNmYyT1Z1ZnZTZ3JBSWpYYjhm?=
 =?utf-8?B?V2JvSTI1bkplcGxCenVaTlFybjg3a2ZacUgxQ2RMZ25sYStuTVF4TXBzOUFu?=
 =?utf-8?B?SGFscUpMTDhiQWg5Q29adDVrbTVOY3hTdzY0NC9hU0wrYkFiQWZSbFJ6RFNV?=
 =?utf-8?B?aHpoSWpFaFV5a2R1Kzk0UmN2S2NMWE5VellaSUtMYnFvVHZRTTQ0YVh1TjYx?=
 =?utf-8?B?TkZuZG9TODVDSmNlRnpCdkp4M1RBZTlGaFFibTcyNVpaU2lwcUs2djh4anNL?=
 =?utf-8?B?bm1tZmtKOU90eU1mbk41ckF3UG1xOWRhR3VLTVBGVG5vcTNFVXpzNkFZME10?=
 =?utf-8?B?QlZhY1U5aTN3eWdvTU81VElpajFNRk5rVXRhYkFwaEhmUTl0Rnh1VFhNNWlz?=
 =?utf-8?B?THF3SEFaRTRac1hIQithKzJ1M2U1MVBaeGNaZEhGelQ3bnF1M3Fmckttc0dG?=
 =?utf-8?B?eUZpNlZ5Y1NPczJpa09LeGVwY3E0bmVmV0ZaUC9YZHl0dUEwRkE2V0ZjM2Qy?=
 =?utf-8?B?Sk5UR0xpdmdaOEdkMTFySStqSjlKakd4YmZFTFc5VGxMRkdVZ3BpM0l5VldW?=
 =?utf-8?B?SlVCRytENjU1NFdGeS8vRHp5UkM0MDlSaG1YTXM5K2VpTEtGdFl0eHFoTWM2?=
 =?utf-8?B?RktvTmRiSjF2U0VsOXZUYVFHb1lMSzQ5VDN2YTlCb2lpVVk1YkM4UExMakht?=
 =?utf-8?B?ZXhucHJBclplQ3EyR1hBT2dxWitTUXNQOHJhYi9qWVZ2YzBJQmp0VXcrY28r?=
 =?utf-8?B?WDhNT3lPZzhrbXNzYUgyb3gxYjQ0UGV4ZTRBeXZTcmx1cVJtNzV0U21ySmd3?=
 =?utf-8?B?dmg1bEtPaFl4clozSE81OUU5amNTNzQ1cFVFakk3L1N6aG9EMkJTQ2R2aWxK?=
 =?utf-8?B?SEJGY2phYW5XdzBtWVZNOTUyM0gzVmplOGVSZmszRU5hWU1YbkkxM0M5elli?=
 =?utf-8?B?aDBoejZRaDF6bHFHYkpNRWJMQVVlRllJN3VHd0txMlAyeHJEVEJnVm45K2R4?=
 =?utf-8?B?amxGKzFoQUlYUHNmc0NIMzRhL3hwblZjY3VCQVh2YUdJOE5VQmxnZWowNHhP?=
 =?utf-8?B?aG0wbjRIbTNTZjJ0OEhZWW80VzZjMmh0YWVVb0prYWhqZHVHYU5CZlVueGFL?=
 =?utf-8?B?alE3WDM0dDFmT3pHOVRwNmRCUHd3TVVSa0FFdlYwMlZaMHJIMVJyK0VSRlV2?=
 =?utf-8?B?K0xxOGZ4cTJYa1VjR2ZOSmF4NWNKcEFJaWg4WWhKRDBsNUxBUUdhS2w4cmU1?=
 =?utf-8?B?alF3VVlJSTRPdUg4cWhudz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmMwNHBZYVJWczNBQTdPRVJOQThLWXkxZzBlNnNqZ1p5ZmpPbmFmSFY0OCtj?=
 =?utf-8?B?Y3FXekl4ZzhueTJaLzVaU2ljK2lJZy9jUTlsOUxMR3J3aCtldVRrc3BpS3ky?=
 =?utf-8?B?eXRlM0luL0Zxa2tSdFAwK3dqSlVzTDJ6b2JMMGF3akFicjJZaXByZ2xGTlhW?=
 =?utf-8?B?dzFUWTd6b3M0OHVWK3Y1NzdPdTlLVmdZVnZLL1B3WEYyUnhOYzh6dTNlU2lJ?=
 =?utf-8?B?enJFNTRuTWYvNldiV0tXelp0R0Fwc2ovZys1Z3hrM0xCV2hFRjRxOXluSG53?=
 =?utf-8?B?aUZqNUJadGhPbUtJRFVoT2FYVm1NT2tyTVdVdWgxbjBTVW4ydEFpSnJEcFgv?=
 =?utf-8?B?RVdVTDVNaVZFVmlmcllBZ05OS3hkRmx0c0JYWVZnMVR6MENUTmFrMmtYUk9T?=
 =?utf-8?B?NDdDbUVjUy9OQlJCTm9MQXI1aklkZXRadkY4d2hZM2JDM3VNcnVIcUordGtn?=
 =?utf-8?B?NHBIQTRScUVhbmxEWGdXUWxqU2dkMDhjVzV4bkhoNXRMOWUrb2hVa1lxWEND?=
 =?utf-8?B?Z1pEdEU0ZDh0SmZNK0tKTmduM1Izai8vZmdIUGFsckpnU3E4eUlyVWovcFJi?=
 =?utf-8?B?VEhLa3BVdzRFZU1raEZTZU9icmdEUjRGR3EyRUVkZjdGUkJUWUdGS3NkRUF3?=
 =?utf-8?B?eitYSXNVK1NjMkRYai90eWkzK2hSeWJwMlkzdWNoMTU5MUt3eTNSdFFXUWgy?=
 =?utf-8?B?ZnN4ZDF1d0tuaGl3NHc3ellSU09ReDZza0ZiZC9yWHgrQ2ludEEvVXYzdTl4?=
 =?utf-8?B?Nno3Y2gxeHdvcmhUaHkxek5OZFF6cWlYY213NDV1WFlMdytLWUo4Yk5VQ1Y4?=
 =?utf-8?B?Ym1EeXgwUHViMWlRZ2xHQjJBSWVKajRQU1kyamgwWE45RFBieUczMjc0bloz?=
 =?utf-8?B?YTlwbjA1dld1cjVPbTcvWXV5aVB6UHRNaS92ZWtkQ2ZuZHJVTE9Nb1djQ0tF?=
 =?utf-8?B?VnpjcElaT3dHQnU1WGlHNlhnL0Y1SlNpR2xlbFYxSlZCa1RSeTcrYm9WMmRw?=
 =?utf-8?B?aS9iVmtURERpTWgxMFFHOENqS1crV1pXRUNneElrTXBlUWlHenpLSnlkMnpS?=
 =?utf-8?B?aGRnS2Y0bDVRUE1YVjVvUXhyTEFYdERaYU5Yem5Ud2xOTzRtZ0ppV29kZkJQ?=
 =?utf-8?B?dGppRGIrbElzQVJ5VEZQcnJpVy8zZkZNWUljWUdtd3JPak5EVzR0ZGFCQmp6?=
 =?utf-8?B?dno1b0YxMGYzWThoWEI4dDB1M0xpNWQzVUIrL3RTWWJjT1FKVnBGWFZ3ZVlk?=
 =?utf-8?B?K3NhbVUxYnpVTk5LYjlzczBuVzlITU9lWnkwb0Y4WjZqN1pBSGpWV2tLUTlS?=
 =?utf-8?B?NjV6YmVuV2Z5enpvTWFPejdrVHRoRHpSSVlNekRGWGo5YU5nMUE4U1lzTHJQ?=
 =?utf-8?B?SjVuclgrNzFtQkRCVkF5a0YreEFRNVpIN3BxTWlSME1zaXd2ZHpLU2daTmlu?=
 =?utf-8?B?SHlobGM1aW5hd0gvTVh1QWxDaEE3blFIU2gzcWZMZWJHbTdUS3BDOC83Qkls?=
 =?utf-8?B?ckp6YkJndk9iUmxGNTdHSGFHYWJmem43dk9GM3hFNUhobHV0QmdGcHFrL3JV?=
 =?utf-8?B?SUhMRThQNmF4LzhYOVBzVzI5YjNKODI1ZkJBUDBpWklqZHFXdDdOY2s1K2lZ?=
 =?utf-8?B?eEV0eHdOS2dtbkcvQ3ovZVY2ZXdYQW16b0RJbTRnY2lzcEQ4VWpUaVZBRndm?=
 =?utf-8?B?R1V6Zy9OOHd0anU5SXVTNHUydzJpSzNhOUYzbWlHQVZuK3p2L2NkS0VyRVRw?=
 =?utf-8?B?am9jTjhDVHFSc1ZPdzFBc1RBMlVuaFV3aFZMd01wdTVXYXNjcmNsTzlZS09L?=
 =?utf-8?B?enRmMkpYeUdOWWZMM1RXOUIvakxzTXordFZTelRIemE1SWpmS21QVXVROFht?=
 =?utf-8?B?VjJjRHU3T0FScHNDZHg4L1l0Qmd2WWZOMlArY3MzaXBRRGI4L3BPOGFuZm9M?=
 =?utf-8?B?RElLKzVQajE4N2J4a3E1aVZYak1FYW5ubmo3WHJ6L0wxR3dKWm43b1o0eW1W?=
 =?utf-8?B?VDNNckVpQWZROEhEOEZQcVhRM2lRWGphK2krbGR6dHltVzYvUUNLbElMV3BI?=
 =?utf-8?B?Wno2VUZWWHEzZW9oUm5rQnN2S2JtZUIvNmtreThjR0ZLeS9vM2drbXBZcDVV?=
 =?utf-8?B?Q3hJNnJPcTZMaWFiOVVlcmV4Q3dHbFYxZEk5Y3ltK2Njei9jb3NuajE4OWZq?=
 =?utf-8?B?ek11ZkNIVEo1NlFpdUQ4MUNOVmxibUI1WFBsVHZkb2dkaFQ1SFNiaVRYZGJK?=
 =?utf-8?B?YlArWkg1S21lNlo3T3NMTVFDY1pRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A92FAB42D13F347AEF07412D6F830EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kQvQfCfh20VKaTzncbWuUVRBzdilY0aruvcddiCBLYyEiRONXiRHxl3WGkQbt61uXk097+ieLyFfG786BByLBq6RpGO3CFyGUgLqQd0Xj0OWvCFoYJllRab5qhh9F8IE1LATRj0iQeAEUCp9BVzXoIJeIqI0SyvvRLZtziU7gIBpycl4UFD2pc0/LZivzq5NEO839/zHBd8rSxXx0R4Qji7OXSEDowt3twhQBWu0liqerp0fhDOt4J8ucFGDkXNP/64i/6EH4gwp/aoF3/dm7z2LNEUcYnIq7mKiTTdFpCkDS+hn8otSKC0jtLPREx3UykUmhhXVMIVLpMZ+8Ry1GVDJFnejp9PeY2/cBEFl9lKWXjKtAjVbZ24FtmqmdjmtIOgHIHxpSxau0VJ7I1i5ce0wxmPrkTuXaBtDlzoUF7eFzrah3WfcVNgfLCxvtdrfvvrTtVG/ipc30KvyCRYPUbxRxzcMIX46Ak46K2Yjr2DVybTp7hcfp/aVBSLx35d640tVDDZNtbNbS2P7Bt7c/+dlyrM/xYaAALBXDs3DNZ+mW4KmDFgnibwktko7RW24KeMalm1EXVsE7xUT/PElfG+FIM+fb3ZxfnD/dJRpKSt4hBOJQk4/YAap2yrqugKu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16400600-0882-4bfe-95ad-08dce467ae4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 11:28:33.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zqi4ajOVvHIZlXQ7/VlNLfKGNP2yC8DX07d15c60yT+Wt3afKebvlNp4Kcx5nL721/ixPgxgVJ4iQCO1JKgTznD2yHFs1VvmLIW9HXedoZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8433

T24gMDQuMTAuMjQgMTM6MTcsIFdhbmcgWXVndWkgd3JvdGU6DQo+PiBkaWZmIC0tZ2l0IGEvZnMv
YnRyZnMvdm9sdW1lcy5jIGIvZnMvYnRyZnMvdm9sdW1lcy5jDQo+PiBpbmRleCA5MzcwNGUxMWU2
MTEuLjVmNTc0OGFiNmY5ZCAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0cmZzL3ZvbHVtZXMuYw0KPj4g
KysrIGIvZnMvYnRyZnMvdm9sdW1lcy5jDQo+PiBAQCAtODAwLDE3ICs4MDAsMjQgQEAgc3RhdGlj
IGJvb2wgaXNfc2FtZV9kZXZpY2Uoc3RydWN0IGJ0cmZzX2RldmljZSAqZGV2aWNlLCBjb25zdCBj
aGFyICpuZXdfcGF0aCkNCj4+ICAgew0KPj4gICAJc3RydWN0IHBhdGggb2xkID0geyAubW50ID0g
TlVMTCwgLmRlbnRyeSA9IE5VTEwgfTsNCj4+ICAgCXN0cnVjdCBwYXRoIG5ldyA9IHsgLm1udCA9
IE5VTEwsIC5kZW50cnkgPSBOVUxMIH07DQo+PiAtCWNoYXIgKm9sZF9wYXRoOw0KPj4gKwljaGFy
ICpvbGRfcGF0aCA9IE5VTEw7DQo+PiAgIAlib29sIGlzX3NhbWUgPSBmYWxzZTsNCj4+ICAgCWlu
dCByZXQ7DQo+PiAgIA0KPj4gICAJaWYgKCFkZXZpY2UtPm5hbWUpDQo+PiAgIAkJZ290byBvdXQ7
DQo+PiAgIA0KPj4gKwlvbGRfcGF0aCA9IGt6YWxsb2MoUEFUSF9NQVgsIEdGUF9OT0ZTKTsNCj4+
ICsJaWYgKCFvbGRfcGF0aCkNCj4+ICsJCWdvdG8gb3V0Ow0KPj4gKw0KPj4gICAJcmN1X3JlYWRf
bG9jaygpOw0KPj4gLQlvbGRfcGF0aCA9IHJjdV9zdHJfZGVyZWYoZGV2aWNlLT5uYW1lKTsNCj4+
IC0JcmV0ID0ga2Vybl9wYXRoKG9sZF9wYXRoLCBMT09LVVBfRk9MTE9XLCAmb2xkKTsNCj4+ICsJ
cmV0ID0gc3Ryc2NweShvbGRfcGF0aCwgcmN1X3N0cl9kZXJlZihkZXZpY2UtPm5hbWUpLCBQQVRI
X01BWCk7DQo+IA0KPiBJdCBzZWVtcyBhIGhhcmRjb2RlIG9mIHJjdV9zdHJpbmdfc3RyZHVwKCk/
DQoNCk5vdCByZWFsbHksIHJjdV9zdHJpbmdfc3RyZHVwKCkgY3JlYXRlcyBhbm90aGVyIHJjdV9z
dHJpbmcuIFRoaXMgY3JlYXRlcyANCmEgbmV3IEMgc3RyaW5nIGZyb20gYSByY3Vfc3RyaW5nLg0K
DQpJdCBjb3VsZCBiZSBzb2x2ZWQgd2l0aCByY3Vfc3RyaW5nX3N0cmR1cCgpIGJ1dCB0aGF0IHdv
dWxkIGp1c3QgDQpjb21wbGljYXRlIHRoaW5ncyBJTUhPLg0K


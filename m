Return-Path: <linux-btrfs+bounces-2321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBD48510BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 11:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693B9285E80
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2918018AE4;
	Mon, 12 Feb 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M7MXsVhT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nVBCyBD0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4571804A;
	Mon, 12 Feb 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733550; cv=fail; b=YsAmCX6DyNryxnW1Rio6/TjM2aPb6wUIiJ5X8ZaPbI1tLQkE6uaj78RFhdjqzFWKMZhrnJHXtwVcZz+1t93E6eNpHDdrvoUlfIdQPgo1NpsB+goJsxEv2LumbTWcpfKtPguURaT3p7UPIN+8b/KFTJAJZq6cpvzYTxzfi/0D630=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733550; c=relaxed/simple;
	bh=LepqENXJreE/sKiMzQGtVT9d0nEGf7gdeVSCJyRoaCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qv74y+BZD0ANdAnt+dK+tb/F9e6axT8VLm1n/xf1GST6eG4F1QDmgUL/dpD+F/LDqbDsPi0X9EL0YgXvG3aaKvBxqHLhJIABPbnrmFuLNZSZzAv9GuGjyohn1LsKFlymksj7PTYJcPxwEi0jCl3TAIX2z/daajLNXcbBcdmQcc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=M7MXsVhT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nVBCyBD0; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707733548; x=1739269548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LepqENXJreE/sKiMzQGtVT9d0nEGf7gdeVSCJyRoaCw=;
  b=M7MXsVhTx5VKJPrw1cF5cN7e9CqsBg6SkiEb7chA8V3H8qrnthUF9pqv
   fsvUYELZo2QWbpZglW0EbrPSqR7PtrAqdcZ3PSsNGvPbIFwltYEPpzEHQ
   sS1UZccnwvcRkLkjztMV7YctvFeh0DDxcxxdj02/i46EuE0TyBt6TlJnm
   d0Nb5jkClxum9RBN3pyYZjB6z1Mjjk1Ui8+FjO2HYXrpp0YSkyTjwWR9v
   46SDTjr0VaOFRtBRG5z5GKEDRBSBzowbED1bNWLdhDtN6JH8szHc5HEbv
   Omy17nLmnwx/a50rZOjAgaNK+J5VL4q64Il8I7HRpuRjTyEgzYYDZIGMH
   g==;
X-CSE-ConnectionGUID: vYusY2HIQGCcwHac6GWobw==
X-CSE-MsgGUID: H9bZz4DMSuS91bjB8zYjcQ==
X-IronPort-AV: E=Sophos;i="6.05,262,1701100800"; 
   d="scan'208";a="8693746"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2024 18:25:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvZKEnTzIy4grFigyDDX0ZdoRzSlYTPTgYp8e3y04xY1vtd13UCpiSCNwzdwTLBM2unxrPAT485PBF0nmiUiCj6KH3SRPOqWV3fk7YLsXhi0gUtD4xSb5V2JdEGT7s3Wi4E2UsAcqu84Mv0goup5NVWQDYHNG/xZU66Z09/yGyRWEgDJne7NZ/v2QmSKeF/seGiKlAeh5ozm4A+j3+5A9Nrz6rpBOTr7uhjGLvvgR3m9TJNUKkERaw31+JsbP8vz0uUtVZ1F9oqBvuoI+PrGa7AzKWazYckUUC4zEX7ZSttmtkbKeBxDlwzHKsuDKHyGl/q6ikOfio+VmYlkWTdJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LepqENXJreE/sKiMzQGtVT9d0nEGf7gdeVSCJyRoaCw=;
 b=K5bokx9a3tucxdgcPwIdyhjd3rExuVKCHeSgC2xOirNck26UsFuO2zmyjvwgWqFfo4PX53nRhGRRae0TO2OEqhvWwwnzazj7kT87wZd7u+y0XakQAwu4JN36VsQlQk4rsOg/vgNI+68+2oZNvGRcoCOPgbffAWOetFQZt0VI8QSdHLeaquefWdqUeXpGL61t4mWC//4r6jih+xyj9D10MIkESLS6kKsSzUxtHnWezGOThSOh956RkzdjuKLHsqcKOr5w/tPJlRDUdBFbSQky3WHUU/1yKcidf6kwL7ZmHkWFSkgqYiGFurLySpJiU1oGME1zCEbZY/WBbuL5lEX8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LepqENXJreE/sKiMzQGtVT9d0nEGf7gdeVSCJyRoaCw=;
 b=nVBCyBD0qqG9kRJcJ9krS0b3kvt7ZDQXglC+4YdDFjQUMIdCLhz5SrxuRtNE/f3TvlyBHgpZXcrbhbYnjnXg21Drdl8UUHtfMADJIMfMraO6QQ7zgayxJtDcr+qBKSWetFOIOSy3Jqj7BfWUo4koS/AjNXPkMJsS35z497ox7BI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7670.namprd04.prod.outlook.com (2603:10b6:510:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 10:25:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 10:25:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: HAN Yuwei <hrx@bupt.moe>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reject zoned RW mount if sectorsize is smaller
 than page size
Thread-Topic: [PATCH] btrfs: reject zoned RW mount if sectorsize is smaller
 than page size
Thread-Index: AQHaXXKqf8otZhTTV0aW5Mr38f8CiLEGdX2AgAABZoCAAAnbgA==
Date: Mon, 12 Feb 2024 10:25:37 +0000
Message-ID: <3cb26289-f3ce-434f-8de9-28d1b250aeff@wdc.com>
References:
 <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
 <11533563-8e88-4b4f-acc3-0846ec3e8d1f@wdc.com>
 <1150c409-f2ed-4e5a-a2b6-9f410fb7aff5@gmx.com>
In-Reply-To: <1150c409-f2ed-4e5a-a2b6-9f410fb7aff5@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7670:EE_
x-ms-office365-filtering-correlation-id: 28f11c1c-3bc7-479e-1f78-08dc2bb4f49c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LjnMrLJCmEaA7g08vfgI9JJZPEHAKNLGSQLoHwMzhOPJ4yPvzfacJOyQFtsWt6BWNOuEoaci9iZh4RctL97Dookf+3OTDQR2CO/OC/Z/ewSeN2zQYFXDqOaHQ5u9z2qAUvOmAnwX2Zhxp1FlFMyn47IBE/HbgrbXCz+6qrwMZWwifT1BJT9KVPkMKcSZt9lH4CQ/PbPopVXu2pBk2Fwq7cVz/ca9j36C+HDA7R9E7XEhlcbhO2/ch8QuEU20W8sshmFehGUyEx4+euzQKz6TD9NjqVCt6lHfeCGZbgyZOfjelPOleo5AP5uPvyuMRDKotRYuHgVo1rm6A62P/JlamPuDWT0ZvVVTsJBiZQfUcLoOZ5w25t0IxkMM1DnpO/49jVKbqlr+igk00/pzp2rEHTsb/hoYrT9EZSAV/QkEcuoAD1Z23nUVGB2A+zO/FxbF5QJURXyEBxWNuFV44tAiNb57pb8Z7Bec2QtPI1e+fZtpGr3dz0oOLbH9uq3XoW/gRGrY1qaivUlhbawtE34kX2hsQJRffYY8wSLkPzT6E7ZuvaYnhzqrYu4tu9ZDUXsG8wxuEJC4utdstT+pbu75S1C3Uaj8g7pEjlzOf75S18k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(71200400001)(122000001)(38100700002)(2616005)(76116006)(110136005)(38070700009)(4326008)(8676002)(8936002)(2906002)(66446008)(54906003)(316002)(64756008)(5660300002)(66556008)(66476007)(66946007)(36756003)(31696002)(86362001)(478600001)(6512007)(53546011)(26005)(83380400001)(6506007)(6486002)(966005)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akh3Q08ydTQxeldzMEpYeVpZUHJjaG5hRUJXT2Z0QnRXcW1NVzJFOU41akpD?=
 =?utf-8?B?RlBwa0d0ekdYVW1IOU8zcDJYTktmeW5mNkFCalZQZWoxeEtibDdTVXRaNFZx?=
 =?utf-8?B?UmxWQTRVRFlBM1crNFdFdk1QUzQ1T1BYNW04RjRXMWhaTmNzSzFjS3VmT0Zx?=
 =?utf-8?B?UUQ0eXB2bitJZ0NRRXZHbG81ZHRwa1FKNmpVNGlOUkFMZWpJYnRYUmJHendv?=
 =?utf-8?B?aHVoN29iUk9Gcm04T1JxcVNpUU1QQjExQm14TXkybjhKNmgzZUdGVXBHNDBY?=
 =?utf-8?B?QzNVVEszTlEydEdZRnUvWXVDZ3ZVcmduVkxMRnNnN04zanlrQzk3OCtmcTBP?=
 =?utf-8?B?bXBuV2FrNHQrSVc4NE1ZS1JGWm5IYi84eUY1K0pIdjlYazFGem5lRW5HSDVo?=
 =?utf-8?B?bTFvL2EyRXJ1dDVUZk9Mb3c5elF1cFdDUnJ1NUc2UnJ1Rk9SSUQzelNQOVk2?=
 =?utf-8?B?TFhMZXFCOFlvVkRVYWY4bms3ZHRnNTlpMEJIeUtMZjJDc1lXZHI3WDl1YlpD?=
 =?utf-8?B?cnFONm9GSExDQlZFTitjWWxsaHJVSzZtWHlyNzViOGRaWnpFTXA3Y2wzWEMv?=
 =?utf-8?B?MTg2WnhyOEVmZENDYlpBWTRZeFdJNEpxMk1PdjZ1akkxVitZNUIrV3p0bVFF?=
 =?utf-8?B?cDV2SWphd2szcVpTNXE1dGNBMm9xU3A2WW83RURqS1MrN0pNdHJqaFNUSE9N?=
 =?utf-8?B?alJMWEYrRTY5RWNjUmo3QkkrUzlDcmg2cGI3a1dPVTlHdnFvbXVDRFZudlcy?=
 =?utf-8?B?M3o5N0VvU3VKOC9QUmZkSjV0OFBpL1pHNndnZDdJcGJwTTdXSHlMQjU3OTF0?=
 =?utf-8?B?UFNiSWlKYmw3RGdqY0J5NVM1a25IOGd3WTQ5YzdzSkgrY2FPYzlOTnhQRjM3?=
 =?utf-8?B?V1hCM2JXUVcrR1NnS2FXWExGVkw2QUd2VmhJT3luTnh3V0F6ODZFQzd4S2h6?=
 =?utf-8?B?NEtiSjVRRHdJUEhPRzliTzR3d1RiWURVMWUxNHFwZlJ6Sy9GZjJUNjFpOGJX?=
 =?utf-8?B?R2d1MTBkSkVMK1V2RE9LSUdBakFPMWw3RlFCWkxwTkw3TEx3M0wvWFV4b1ho?=
 =?utf-8?B?TnRTdUlVQlc5bDNaR3JUTnBLSzFhVFRWbnBZVkZNNHpvNHh0aFBLdEdicTFl?=
 =?utf-8?B?RHhtd2RVallaQ3dTWVR6WExzNDhMQ3RydVR5S0N1cHBvcnkrSVdmeURJdkhJ?=
 =?utf-8?B?U2ZMbWNWWmVmbE5vVjB6ZmMyNTY2U3AxQ0NSMW1VeWJad0RMQlAzZHk3RDBz?=
 =?utf-8?B?eXhTSkZHYWVadkF6aDNRVVh5R1laQzJsdllsRWlkeHQwM2h6WE0rUEdNc0VW?=
 =?utf-8?B?OFpsV1BlM2hsdEJpMkVCREJOVVZQd0kzaVdYQzRFbWIzWWdnUlRsZzg4UFdZ?=
 =?utf-8?B?OEZmRFBldUdhU0VQMTJoanB5L1E0RWhOMGtNSTcweXFEVjBKdjllMWIwR2JJ?=
 =?utf-8?B?NDliTXY5M2R2NERBRjJHMVNFT3U4dFVYZ0JsYVoza0hMQ2RWSnRQK1lONDIy?=
 =?utf-8?B?ZWdsL2VQQjRPZFdnOVZzTTkvVjluai9DSmRQMWN0Zk9KVkdmaDYweFFFWHR2?=
 =?utf-8?B?MVY4RlJmOWlOcERxaUh3TlNxL1J0UFdrbm1xMWtYdGVqenczcFc1LzFHbi9n?=
 =?utf-8?B?NHhjOFIvd3NXbGF3TGhZaXdUSlZvOFEzYU4wTXZXS1gwdG5ka1lHd0lESmpq?=
 =?utf-8?B?b0RqMnRkWVdpd1IwdG1tYU02WnduQ0lTbmovYjlpL2JjZEljVDBlR3gxUjdR?=
 =?utf-8?B?TmFoOWtmUUdON3hmZXREWG5KdFVPa2hWMkJWOUwzK3BBNnJsNlhoTzBpa1Rp?=
 =?utf-8?B?cU5XcG9uTEhSeUtObmc1TzA5RHBneVA2Y3ZtL1JxODhMOTE2K2NiWml1SG1T?=
 =?utf-8?B?cTlZNHRpaVVFaW9kd3A3N3YwaG9wZklOYlBPUjRoaUtqK0d3ZGh5VXRTcll5?=
 =?utf-8?B?aEYya3h4L3ZtT01zMFp2UkNUY1pQaUd3R2tjRWkvbXJuaVNBQVppMFZRbDFN?=
 =?utf-8?B?bURobnVxQlN3OVFwUlNrKzZhSzBjcytjU1U3YkgvOXhwKzN0aUVBVi9CWk03?=
 =?utf-8?B?V2FJMzZ5N3czdUN4YWJNZ2c4Tnl4NWlFZi9LMElnVXlraVY3Mnh6QXBOZE14?=
 =?utf-8?B?b2VseHlkeHEyZWtic0NCc1RhQWRoMzFEZkYzYXkxd1RIa2ZuWGVjLzVWUFlz?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B0CE33E71077F48884BD04D7105B9FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R7bhTlJfO37V7CALeDWlUrS79HEgv7BVrEa7PZz3UbrJ4rse8TDKXqr3f6W/iPG6mlUKJftCcKcnvuZGs3SIcVd7nYxB5XmVdaq5DX83AxbnglQv+dRO7eY7CLQm6HtorzAkW1mld7IVvnGUkstfFLqYd5tKES0qleVYLX4kcR/QLPFA5COdflCzqzsnfzYpWfNPyGNx+wGpkqKGwNP37vjzWkD2X49yQPz7ysWoJ8DvQLX9+alya0ZxhVNs1M586m8xe92eya+9tSYnhNCgHExTn91EIeiPeVWfKfPPLc3YNW7MV8uQZIeETEqpehEMEaWAE62Rsg5R3pg3X4B/62iyf0LL0uPT8N62dRT9ZOGA/Xm7H3rkaRLWYBteLGQqnRGGDP09H/UHqXXeoJ5qJcHqRnlYWb+j8b7sWmuLtr7yMIM7NYPMNTD+dcuHajTCPkhGnh/tMzCVkdOFQDs8odAjGzPq3U5MxZXXnoVg6YiSXy6CKNPqlMXzZRAhD/7X4WYZZ2/+eGt7+VUDnX8AJZXjF9UhmAB2IaPIKYG38h48mjWqctKlckSqPGhjAMGSe4k8MQKBePXLlr4CK1wQ4uUKGC1aiQPiO6kUfsz8WwVxwiYduJw/6rqHiyusgFXD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f11c1c-3bc7-479e-1f78-08dc2bb4f49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 10:25:37.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKxvCx3YMqFks/R4Z1R2sGxm+BeqjPS1JKpJs5i8cxiJv8rFEvzgtdIEsH8f6clkkw9Pq9I8TOMhZEXc6m3i3Zeasf+z3w26BQ5U8sCTQF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7670

T24gMTIuMDIuMjQgMTA6NTAsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDI0LzIv
MTIgMjA6MTUsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IE9uIDEyLjAyLjI0IDA2OjE2
LCBRdSBXZW5ydW8gd3JvdGU6DQo+Pj4gUmVwb3J0ZWQtYnk6IEhBTiBZdXdlaSA8aHJ4QGJ1cHQu
bW9lPg0KPj4+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xQUNEMkUzNjQzMDA4
QTE3K2RhMjYwNTg0LTJjN2YtNDMyYS05ZTIyLTlkMzkwYWFlODRjY0BidXB0Lm1vZS8NCj4+PiBD
Qzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDUuMTArDQo+Pj4gU2lnbmVkLW9mZi1ieTogUXUg
V2VucnVvIDx3cXVAc3VzZS5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgIGZzL2J0cmZzL2Rpc2staW8u
YyB8IDMgKystDQo+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9kaXNrLWlvLmMgYi9mcy9i
dHJmcy9kaXNrLWlvLmMNCj4+PiBpbmRleCBjM2FiMjY4NTMzY2EuLjg1Y2QyM2FlYmRkNiAxMDA2
NDQNCj4+PiAtLS0gYS9mcy9idHJmcy9kaXNrLWlvLmMNCj4+PiArKysgYi9mcy9idHJmcy9kaXNr
LWlvLmMNCj4+PiBAQCAtMzE5Myw3ICszMTkzLDggQEAgaW50IGJ0cmZzX2NoZWNrX2ZlYXR1cmVz
KHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLCBib29sIGlzX3J3X21vdW50KQ0KPj4+ICAg
ICAJICogcGFydCBvZiBAbG9ja2VkX3BhZ2UuDQo+Pj4gICAgIAkgKiBUaGF0J3MgYWxzbyB3aHkg
Y29tcHJlc3Npb24gZm9yIHN1YnBhZ2Ugb25seSB3b3JrIGZvciBwYWdlIGFsaWduZWQgcmFuZ2Vz
Lg0KPj4+ICAgICAJICovDQo+Pj4gLQlpZiAoZnNfaW5mby0+c2VjdG9yc2l6ZSA8IFBBR0VfU0la
RSAmJiBidHJmc19pc196b25lZChmc19pbmZvKSAmJiBpc19yd19tb3VudCkgew0KPj4+ICsJaWYg
KGZzX2luZm8tPnNlY3RvcnNpemUgPCBQQUdFX1NJWkUgJiYNCj4+PiArCSAgICBidHJmc19mc19p
bmNvbXBhdChmc19pbmZvLCBaT05FRCkgJiYgaXNfcndfbW91bnQpIHsNCj4+PiAgICAgCQlidHJm
c193YXJuKGZzX2luZm8sDQo+Pj4gICAgIAkibm8gem9uZWQgcmVhZC13cml0ZSBzdXBwb3J0IGZv
ciBwYWdlIHNpemUgJWx1IHdpdGggc2VjdG9yc2l6ZSAldSIsDQo+Pj4gICAgIAkJCSAgIFBBR0Vf
U0laRSwgZnNfaW5mby0+c2VjdG9yc2l6ZSk7DQo+Pg0KPj4gUGxlYXNlIGtlZXAgYnRyZnNfaXNf
em9uZWQoZnNfaW5mbykgaW5zdGVhZCBvZiB1c2luZw0KPj4gYnRyZnNfZnNfaW5jb21wYXQoZnNf
aW5mbywgWk9ORUQpLg0KPiANCj4gQXQgdGhlIHRpbWUgb2YgY2FsbGluZywgd2UgaGF2ZW4ndCB5
ZXQgcG9wdWxhdGUgZnNfaW5mby0+em9uZV9zaXplLCB0aHVzDQo+IHdlIGhhdmUgdG8gdXNlIHN1
cGVyIGZsYWdzIHRvIHZlcmlmeSBpZiBpdCdzIHpvbmVkLg0KPiANCj4gSWYgbmVlZGVkLCBJIGNh
biBhZGQgYSBjb21tZW50IGZvciBpdC4NCg0KQWxsIGdvb2QsIEkgZGlkbid0IGhhdmUgZW5vdWdo
IGNvZmZlZS4NCg0K


Return-Path: <linux-btrfs+bounces-15746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ECAB158FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 08:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A9E18A0108
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 06:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF111F2BAE;
	Wed, 30 Jul 2025 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qRwDDRZc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ebWfXtzE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E4199BC;
	Wed, 30 Jul 2025 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753857365; cv=fail; b=J+xerJzUBiSvhVsi5DY9PtWzQd3hSblqOvKhUufAS78OYowU7FQhgju3owRmvyvGvWzq0VXBYhvTZ6Ysi6UusA/a34GuTc16HVreRD7Dcvwk8uObF6xWovmJz6//OMoQAdY1+q4ovuVIiD2qMcVoB5gwGKrGU7FP0bKD3Fz2mcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753857365; c=relaxed/simple;
	bh=74Qo7ct/0VW6SQFwpHEDt1QATznHTnJpKI+Cmqpf3jU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HkjsRxE64Nlx7iC+Hz2/iOWwMBpHuhL+g+fD0MMT4erOvm/QZ8Gueer6iVWE6J0LfJpR+JqiTY0wUr234pVRjpnKbNWtebbeE9erpOcsSXe+KGpR5Ivu+mIm1zjlc6RfJ42MBXh2WEYM7rijB7f9l36UpkKLKTTtQTo/x/tKrfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qRwDDRZc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ebWfXtzE; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753857363; x=1785393363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=74Qo7ct/0VW6SQFwpHEDt1QATznHTnJpKI+Cmqpf3jU=;
  b=qRwDDRZc7zupDCJFK1knzy+V0ZAf6nvZhtFewWnXCSjcWW3QlzDKI+eX
   vN1eQbiI6eL58rNvlKciRq8dvBWlkbucumlRCeAHcAhTYphsDgWkc/mgZ
   xRznb7sq1pCZailG/SOSp5jV7F11bYctYiYaji3Ou56ymAEpwMPvk+gTv
   7FQNknztEZGoSE53WGpLYtUj777U9ewyyQGhPQxhQ6R2Sbj3brotlGQja
   tCJu6RbWGRn3zbj+uTg3Yea8YGBRF+s6PJdYMr0ABHyUT8fCzX/BJ85PC
   aPpfWzDPDkoYH2ezz1n2wtFSlGOltIM+GZnw1x2pOHDduatVYkcSCAOwF
   w==;
X-CSE-ConnectionGUID: 96qakdY2RxCmc/RVeIaOBA==
X-CSE-MsgGUID: lN4c1qvGTaCu68Z1FMj5og==
X-IronPort-AV: E=Sophos;i="6.16,350,1744041600"; 
   d="scan'208";a="105360246"
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.83])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2025 14:35:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E16saURcrWMJSF0e9OrS0Sru7AYFy8g0EzqDv4Oya0Zv/uK70YNVNT+DsT6+PPVfR+v80/ukDJE9zs3Vm7WrwUPUof2B4SOYIYVPLSAu9KUk1hmxYs0kCuc+RLO51Zpom3MusInnuF0v1ahdgcuTNEnAuA4nEEU7S43wjRN0jWBIBqL2dPlF6AvBz92hDzJ4DNlfkbez2NdHPaXwfzYrxTucdFU6CBzUwpDv0diYtmOuAuzn2LI6g3R0witDqDPBNTGGIaD94pNlQsYOy5oi1gbYNzpSu20+D3U12X4xs4MZhL19mQ+7WezA6ocM9JqbtZWqKNMY0ONx9ivbh1oesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74Qo7ct/0VW6SQFwpHEDt1QATznHTnJpKI+Cmqpf3jU=;
 b=m7sBn0WAEPnM+ktZ4SC/Jst7C5aMGrSWljQUbWjHlmgLUvo5ey0CRc4juq+nF3v2R5yUC4LgCuvZmm/Z2nvG2F+w4vHDId69yuxeakn7sWccz0ERpaSSEhcSnDd94Aj3psqFowdy/Bycuos9ikYe03h2+4s5YUBsEdjEdHLAY/UsxymB9nTYJZ4W/TYS+kogIo2PCTNDBKedgj5SevqUZKcQyRsFEocszTbd7gMK2+xuSGyUZNWo/LXaPJnx731liOmeEQalIuMpxZpnxWGBjhbl241Q2VmAgOeLUijJlXIFK2igZzbytS2YXpQrRt8V8levkLb9XT03XKNLtR4oww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74Qo7ct/0VW6SQFwpHEDt1QATznHTnJpKI+Cmqpf3jU=;
 b=ebWfXtzEbYUX2USd6U/IzpQTZ0DXlb1Er2wqdgyuglB6eIzndig2seAr3Hw8McrTxMmPRzZsRu9M2KRkgQOBLxulNIkLCaIBEYOQweSRFJiOlVzbLfCufpiV+RW/awMirvE3tkKey+aqlDSllr+Jycrc+g/PvWKiuB0VCwUikdA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7593.namprd04.prod.outlook.com (2603:10b6:806:14b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 06:35:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 06:35:54 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "kmpfqgdwxucqz9@gmail.com" <kmpfqgdwxucqz9@gmail.com>, David Sterba
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KernelKraze
	<admin@mail.free-proletariat.dpdns.org>
Subject: Re: [PATCH 1/1] btrfs: add integer overflow protection to
 flush_dir_items_batch allocation
Thread-Topic: [PATCH 1/1] btrfs: add integer overflow protection to
 flush_dir_items_batch allocation
Thread-Index: AQHcAQybmxkmmOEbO0+iodF2HkfrMrRKNkuA
Date: Wed, 30 Jul 2025 06:35:54 +0000
Message-ID: <53686e91-5822-4137-9f79-e4f4d98ff6fb@wdc.com>
References: <20250730044348.133387-1-admin@mail.free-proletariat.dpdns.org>
 <20250730044348.133387-2-admin@mail.free-proletariat.dpdns.org>
In-Reply-To: <20250730044348.133387-2-admin@mail.free-proletariat.dpdns.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7593:EE_
x-ms-office365-filtering-correlation-id: 74dcab1d-0d76-4141-f9f0-08ddcf33558a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjcwTXN5ajFZSVVJQW9iRXhhdStjamhuZDd3dzRZK0UxdXBndU9lWGRHY011?=
 =?utf-8?B?bTJERFJzd3JaeVE0TXZDRFhPSDNva0dGVk1kNThrMDcvUWhGWHFzbzk0TVlI?=
 =?utf-8?B?ZU1DUmszUW1iTjJtQnBlUmJ0OTN4b2tQa2dmRlU5SEhTVXRXRlZ3Q1dsMHdx?=
 =?utf-8?B?ZlY2bjhUOVkySjF4aUliRHBPUG82L01PWE1UTnVBSHdOemdIUlorOGtxTXZl?=
 =?utf-8?B?WUo0V0wzWXVtUmFlRGkrR00vQmdpQkp6czVmai8vbitoUGJYOWZjd005THll?=
 =?utf-8?B?ZXNTZDlZQjYrazVCb012bnBMRjRicGRRT0l6MUdlNFZoTlF6ODluTFowWGhG?=
 =?utf-8?B?bjVacGRPWjErTXg1b2JNOHBkOFFxeXc5VVZFU25vaExvR2ZzQnFya0lvbXNy?=
 =?utf-8?B?KzFTWHRZanU1RUQ5L2xsSTlVQmxCQmJnRER3a2E2aVdnR210bDJLWmdEc25v?=
 =?utf-8?B?YzRzcEwxVVZOeGxjTTlncGlYVDIzeE02cEt6bUlLQk9EdElyRlMwMWdxMFkz?=
 =?utf-8?B?QkpObHZLQUhISm94ajhoUm5pVFo4cjl1V2xGNWlSMnNjWVAySnR5dFBlekwv?=
 =?utf-8?B?VS9PK3ZIMmExSjJqT2NsZjNVOVBFT3lzN3FDZHBwdkJGSWl2ZmxNVVhrSXFN?=
 =?utf-8?B?NUdEVTd4eU95RFdPTG1ENDVkaEE4aGoyNE9yTm5DVXFvTWVBSTJnSHBnN0t3?=
 =?utf-8?B?WDV3T09PY3VESkU4OGRTRk9ucVl1R2MybDVWem5NdFcyZ1cyRkpqcndTYlFq?=
 =?utf-8?B?VURvTWg3K0U4Zmk0MnpBNVpXeVNmV3FCSDk5dVVJdzI0OXVhMnQ0UXhRT3RF?=
 =?utf-8?B?UHFQdmpOMFlFWlpnVXJ1elhLcng4MjdRQk51Y1h3Qnd2M2dRRlg3QkltazFq?=
 =?utf-8?B?UHk0V28yVG5TNnF6U1VUM2lXbDgvZ3B4RUdGcXZINWE4UjlkV1NzS3lHQUlN?=
 =?utf-8?B?RHErbW1JWWRYWVhyNEJxYmlmT3JON3llZWZPblZBaWl2d0hMQ3FFVS9JSW4w?=
 =?utf-8?B?REprUGJYeGRwQklLOE9CbnBRSEl2UzZNQjZyd0hzQzdXeS9JZXFzaXIvdWhV?=
 =?utf-8?B?bmtGUDJ0a3oxbjFGL3BnbXJlOVBSYVVjQUF0Q1VnR0JBaXVIaTBpNFVwOVZD?=
 =?utf-8?B?VnRVU0VaWTV5cW9qY29WOU52d1RPRHE5OVhJUERnSDNPQkRSNlVCekdQeGVh?=
 =?utf-8?B?T0IyU1FBUE0rNkJnYldObmx2Qm5VclBsejJqTGd1VU96a0Mwb3l6RGdNbWpo?=
 =?utf-8?B?STMrSkZUZWdqZVhxQ1A4RGxxcE9YMmJRWVYxMjFDbDdtbXpxckFTbS9TSjVL?=
 =?utf-8?B?eFNDRGUzVFd5UVhBeDc0Ymw4VVZKSG1BbTBWaFEzdCt2VE52ODhRcC9OMTVN?=
 =?utf-8?B?NFlsbndGMi83UDZKam04K0VYYlhpVjJQQjBvVXpkT21JV0ZQTnFWNlIwUW9m?=
 =?utf-8?B?ZlBldnlWR3lkZnhKN3Jxb3k0YzVVZzJ1T21DV3pnYm8vbGdZUjgvOFJ5VzVC?=
 =?utf-8?B?VVhZRVFobkZVQktvUTRtbEc0T3dSakJ4aVhLY0JWUHpZUWhmNlc1ZTVBcE94?=
 =?utf-8?B?L1BIbnVOazJESzYvRklwU2dIV3pUUEluTjQ5ZGRmUVVnajN2aTdaSjMwZk5O?=
 =?utf-8?B?OCt1eTN3cy9XelZWaWFXSVpBbG5seW16ZVpjZ05kTGFOVzJsT3hab3JVUTlj?=
 =?utf-8?B?dFFBRmEzTkloNzBOdm04VHNpODg0bzVuRTArbWlNM1dXU2poZ2I4bDJUcVlV?=
 =?utf-8?B?bkRUYlhqRnhNMS9Hd2Y3SklmSXdOdW16RGZnbjF4VTdadzNrejNPWURIMzly?=
 =?utf-8?B?T0xWaklPcjZKZ294NHVvOFc3YW5rNTlTdHdNMnR6Z3Y0Sy84VklMWkQ3QXpz?=
 =?utf-8?B?Z1lOTXZwL1dERUl5bnlJZDhzaHlDUU1WM3U1TVZ6TGN0TDNCaDZSWWtWemhx?=
 =?utf-8?B?bDhjdXJNV05ZT3B2NzlLSFhCaFBvZ3JoUloranVqTVM1TG5TTXNRVkpQS2hh?=
 =?utf-8?B?eGdudmdldlV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NU5BSll4WnlLNG1TMDl4RzhiS1dRUWsvU3YrNmtrQ05DMWNoYjZiM3NUakZD?=
 =?utf-8?B?Z2dPQ2psSC9Jd0lXdndITllCKzM0Z1p4KzIxV1NYQXJFWCs2ZG96WXhXcXdy?=
 =?utf-8?B?TE5sdE1NK01XZklQbVpkVWhteFpGVUpoc2VYNytRT1dlWkExeUk3Z1VGQlow?=
 =?utf-8?B?NFYrUHdIOENWL1dZS1JSbnV3b2VzTzBqREY2czkza3pJNTk5K0grZ05SNFdo?=
 =?utf-8?B?d0JDanRBK1BMdm16bk1vVDlKRURBT29kZGs1Y1kwb3BXMHZ4dllpOHJ1YVVn?=
 =?utf-8?B?dWc2ZVFyaG9GUStGSGFtM3l0SE12Y2c1Um11NFAzT1lwbzZnS2F5WERKTnlO?=
 =?utf-8?B?dzhrNXVzd05EcStRcUFuVFNxVkxqZ1IxSmgrT2I4bE5FdVNqRUJKZnYwYzlZ?=
 =?utf-8?B?dmIwVU5GNUFOTEY2T1Z1VHcrTnV5bUVCb3RaRW0wUXAvakY3cG9JM2ZPSDR2?=
 =?utf-8?B?dHdrcTh5NHhnSDNmdnd1QmtQQXp3aHI0K3RXNHVZVm5GVTJPTkxZdXdUdmc5?=
 =?utf-8?B?RzFoY09MSEhkVzh3d2FRZkZ3SUN0Qkp4cWY2UkZ6R0FaSmJaZ1JSa3NzVGZw?=
 =?utf-8?B?cTZWUmk0R1FTNm5KOFlsZmk4M0dPNGJNS1VMNHpBUjQxZTNsQ1dTbDd3Z2J6?=
 =?utf-8?B?ZmtzQTVCMCtMdUpib251L3lpMUduV2l5ODFEOGMwZ0NzVEJWdkhqWE9ZUkhW?=
 =?utf-8?B?YzlrZkhHRUxVSUllVFMrZEhpVTByZ1ordGExYXc0ZHFmUkdyMkdVVEJwaE8v?=
 =?utf-8?B?L2RVTnFEQk9UVDFOUVJFaXFGMENIeVJXTlBkaWVMSU5jSDBwNWpNajlLdFdX?=
 =?utf-8?B?OXQ5cUtiT2ExWDA3c2ZkVWkybWlGZ0t3ZmZkeTE4NWFpbkE4R0RGU3UzTjdw?=
 =?utf-8?B?dnptMjkyMThFNkY2ejJwS0ZTdXVhZTUzdytMMUZxSzIyVVZBTExDenZIY0h4?=
 =?utf-8?B?eXpWWHhWTW9UOFR2UGE2TS9Da3JWenlpZnFUK3BMME92QnVQMklUa3BUT0Zj?=
 =?utf-8?B?aXNLbnNGZytyV1ZoaHMzUXd5eXUwditaQ3czVjRDaUkvcHg0aytBbEpDazh5?=
 =?utf-8?B?bHliTitCb1VROXlzMDhlQ1Y5NDJUQithdDlKQXR5SnVRTmlpMnZyK2V1UkVT?=
 =?utf-8?B?MEh4aUsrNHphREtSeWRJSzhGWWFBZUx5eHVackIzSGVrQm9FQk1xSmJQMTl3?=
 =?utf-8?B?KzMxejJxOTNsc3Z4U2c3eDIxNkxydTd6L2hLRGh6WTYwc3VQUlg5a3FPVnl0?=
 =?utf-8?B?S0FkVWZiRVFWOEJ0c0xodEJ0aWZpZnVGZlhQUVBJWHRxZEU3dFoybGtaNWpq?=
 =?utf-8?B?bWZpV3FHNzd3YVlvZi9ZakFadDJiZVA0SmY2YVh5S3U2d2RLYzNJNUsrcG1L?=
 =?utf-8?B?Vnp6R0FOZVNodjFueVh5MUJHeUtzSWowR3gyc3VDMEtuNmtITDhHRFllZWJ1?=
 =?utf-8?B?VllOUmloVkxzTGhERUNLMElCdGJoUlRnK3Y0aTM5QWw5anRIVmhrbEE4c1pj?=
 =?utf-8?B?YzhkNGdDRnZ5eTl1bnltSGFqNW1qODRteWRHL3A3OFAwUFRrYmlQTERCdXBi?=
 =?utf-8?B?a2RiOTlDYlFsdXdvaWVkL2NEalYwSzIwWVNWU1FYa1BzODMxVVRCZ2JwT1ZR?=
 =?utf-8?B?VFMxUThvWUo3aHk4UVhIMGprY3ZvN3ZKKzNUdmNyOEhFWUdNUFdzUlEyRGZR?=
 =?utf-8?B?U2l2ck16eUxTS2NuTG94cm1NVkJQWjNRL3J4TVBlMHNPQThabWNncGtuWitO?=
 =?utf-8?B?RUFyMW9JZDlQMFVqT3d5blFmM2w4Q1gyVitCUTFrbEpxem1xYTRMWlVXbnFt?=
 =?utf-8?B?VHZIdUYyaUpsT0lhRTQ0T0JKdnluZUROOUliQlVlM1pkTGo0RGh5c0ZjZTd4?=
 =?utf-8?B?aFhrejlPSVMwd0dmend0M2hJTWRrR3lYbVRRWHMzK3JFNEpjMHZYR3FjQ3NK?=
 =?utf-8?B?UTV3ajRnbjM3N0trV1lKdEZHc3owRUN2RGZLN1A2Rm5pZHZwSzRyM2RjQlk4?=
 =?utf-8?B?RCtXb2RxRlhiMUhXZXhBaDV6V0NsZXlqU21PWjNXVVZHZWNHUEdWNXlLb3hD?=
 =?utf-8?B?QTluWjF3SjM0UTBUUUg4RVRNTWx4R2xqVEVWc29KK1A5OGozQTdHeGpNSVd3?=
 =?utf-8?B?MHpLQnhoM2R5MzFMV2t6QzVRZ2NXRzRITUYwSUUvdDlLNld6bU5LTXBxUC94?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61F0700DA4A5944FAF4A6E1DE56EC943@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2K+lnlZvGOIdT7/iOoNG82KORA1mYJgvuhPleM4rp2/FT3xt6Lklr2tmr/TZUUUPaYosAK8Lr5Mnzyle2eLdt+znT6dZB4oTdgMIC2s7gaYjEbgedhoM1iLrlKDzRkQQL2meiDiOq4J2I9wYCqhX6C8O8bnibUEuCSfzJvr5kec0x6/QMlztS7Mf94jmojStyxEINZzopTeMpglocvz0zYmJjHJWKhr4HmNGzQXsc7cNXs0cLsDjuYPBa0+qgSim7ZTojMg+y332X6LvkmJmBgFzd1b9nEKVrk7y1ZeVVFcFEdHGpul7/y6UQ8nTXM79wcB80voMkgmfh2jFDY1UP7P7EQPodSZ+OAJT1brKNIrNLgsmdZZGSs0se1+cx6k4TCLTiuDxIMfj/iAZcgJZrHhI+c1d1NjEn/7Rkc4q5turvG4RDdYrzMNEn3BrLnATlJKwuJl9NahFUyz5WvvGcUqKj3nS2Nf7e4OAoVdLpzxcuRNPHttsE/+qvnXKp+v+Q0t8fqaWSrW//+sv1jwkFGIy95H5jAGipv1tTlW/kuIRkt2l6ualctv+yYDnwa8r1YYIK2XbinlYcV16K6SFruSwuqgi7lLqW35zuRzJU5w9sP5NV6nWzBQx1afhR+Px
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dcab1d-0d76-4141-f9f0-08ddcf33558a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 06:35:54.1768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7piC6y9pdt05weuRxZV5TwZWmjhGOf/EG9MrzkykzyWUQcnm8peKMCaHGUAj5m9NNHCqjmKqWiygxh/jmy3MufGeZYNlkgg8+JrStSDZ60A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7593

T24gNy8zMC8yNSA2OjQ0IEFNLCBrbXBmcWdkd3h1Y3F6OUBnbWFpbC5jb20gd3JvdGU6DQo+IGlm
ZiAtLWdpdCBhL2ZzL2J0cmZzL3RyZWUtbG9nLmMgYi9mcy9idHJmcy90cmVlLWxvZy5jDQo+IGlu
ZGV4IDlmMDVkNDU0YjlkZi4uMTliNDQzMzE0ZGIwIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy90
cmVlLWxvZy5jDQo+ICsrKyBiL2ZzL2J0cmZzL3RyZWUtbG9nLmMNCj4gQEAgLTM2NTUsMTQgKzM2
NTUsMzUgQEAgc3RhdGljIGludCBmbHVzaF9kaXJfaXRlbXNfYmF0Y2goc3RydWN0IGJ0cmZzX3Ry
YW5zX2hhbmRsZSAqdHJhbnMsDQo+ICAgCX0gZWxzZSB7DQo+ICAgCQlzdHJ1Y3QgYnRyZnNfa2V5
ICppbnNfa2V5czsNCj4gICAJCXUzMiAqaW5zX3NpemVzOw0KPiArCQlzaXplX3Qga2V5c19zaXpl
LCBzaXplc19zaXplLCB0b3RhbF9zaXplOw0KPiAgIA0KPiAtCQlpbnNfZGF0YSA9IGttYWxsb2Mo
Y291bnQgKiBzaXplb2YodTMyKSArDQo+IC0JCQkJICAgY291bnQgKiBzaXplb2Yoc3RydWN0IGJ0
cmZzX2tleSksIEdGUF9OT0ZTKTsNCj4gKwkJLyoNCj4gKwkJICogUHJldmVudCBpbnRlZ2VyIG92
ZXJmbG93IHdoZW4gY2FsY3VsYXRpbmcgYWxsb2NhdGlvbiBzaXplLg0KPiArCQkgKiBXZSB1c2Ug
dGhlIHNhbWUgcmVhc29uYWJsZSBsaW1pdCBhcyBsb2dfZGVsYXllZF9pbnNlcnRpb25faXRlbXMo
KQ0KPiArCQkgKiB0byBwcmV2ZW50IGV4Y2Vzc2l2ZSBtZW1vcnkgYWxsb2NhdGlvbiBhbmQgcG90
ZW50aWFsIERvUy4NCj4gKwkJICovDQo+ICsJCWlmIChjb3VudCA+IDE5NSkgew0KPiArCQkJYnRy
ZnNfd2Fybihpbm9kZS0+cm9vdC0+ZnNfaW5mbywNCj4gKwkJCQkgICAiZGlyIGl0ZW1zIGJhdGNo
IHNpemUgJWQgZXhjZWVkcyBzYWZlIGxpbWl0LCB0cnVuY2F0aW5nIiwNCj4gKwkJCQkgICBjb3Vu
dCk7DQo+ICsJCQljb3VudCA9IDE5NTsNCj4gKwkJfQ0KDQpXaGVyZSBkb2VzIHRoaXMgbnVtYmVy
IGNvbWUgZnJvbT8NCg0KDQo+ICsJCS8qIENoZWNrIGZvciBvdmVyZmxvdyBpbiBzaXplIGNhbGN1
bGF0aW9ucyAqLw0KPiArCQlpZiAoY2hlY2tfbXVsX292ZXJmbG93KGNvdW50LCBzaXplb2YodTMy
KSwgJnNpemVzX3NpemUpIHx8DQo+ICsJCSAgICBjaGVja19tdWxfb3ZlcmZsb3coY291bnQsIHNp
emVvZihzdHJ1Y3QgYnRyZnNfa2V5KSwgJmtleXNfc2l6ZSkgfHwNCj4gKwkJICAgIGNoZWNrX2Fk
ZF9vdmVyZmxvdyhzaXplc19zaXplLCBrZXlzX3NpemUsICZ0b3RhbF9zaXplKSkgew0KPiArCQkJ
YnRyZnNfZXJyKGlub2RlLT5yb290LT5mc19pbmZvLA0KPiArCQkJCSAgImludGVnZXIgb3ZlcmZs
b3cgaW4gYmF0Y2ggYWxsb2NhdGlvbiBzaXplIGNhbGN1bGF0aW9uIik7DQo+ICsJCQlyZXR1cm4g
LUVPVkVSRkxPVzsNCj4gKwkJfQ0KPiArDQo+ICsJCWluc19kYXRhID0ga21hbGxvYyh0b3RhbF9z
aXplLCBHRlBfTk9GUyk7DQoNCldvdWxkbid0IGtjYWxsb2MoKcKgIG9yIGttYWxsb2NfYXJyYXko
KSBiZSB0aGUgYmV0dGVyIGNob2ljZSBoZXJlPyANCmtjYWxsb2MoKSBjYWxsc8KgIGttYWxsb2Nf
YXJyYXkoKSB3aGljaCBpbiB0ZXJtIGRvZXMgb3ZlcmZsb3cgY2hlY2tpbmcuDQoNCg==


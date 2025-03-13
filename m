Return-Path: <linux-btrfs+bounces-12255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841AA5EBB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 07:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5286D1896FC0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25191FAC49;
	Thu, 13 Mar 2025 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UfYGCk5S";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t1OSU9JW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5527645
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847369; cv=fail; b=F4LAmgVybk9myNh/kFCnuIBbKRkGVk/zQS79QUQMufmBPZpxvE6ugcrHLya9oj8/BBwOKNQbYL6L1d7EGG0wzuDmSrEFSgLU4umLK4obsHujxpXL7s0vFJ0GvYnqXfeQjYeY+9mx1RTIFyC0D4a/ePi2owCsatBEmjZ/aQchwO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847369; c=relaxed/simple;
	bh=UzdfZzVWsDuACu9ZyXnYK1vvF2M8fA/Me59/vsI0kvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X1a8Rnm+YRoSmDTPN5Fs/1hmHKnWOPQXR9V8jrdowr0dpSagUb0W9AppJGxNaiAUZZ6v9jXz8LjCTjYVl8BQOSRNTyHplPoyrzUiyjulxPGc32SItVy50L8KnAYtxzkt6zcULycxnYiP3YSiOrY/gghPjuY5/hyE1tW4ykeMP7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UfYGCk5S; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=t1OSU9JW; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741847367; x=1773383367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UzdfZzVWsDuACu9ZyXnYK1vvF2M8fA/Me59/vsI0kvQ=;
  b=UfYGCk5SjZu5Mq2s4ckOpKyzlAPUYec2XmkyKsZBztOhrp2b5yqb3RqL
   HX0g/DIq4XWfE9o/zWVm5ElZJzNHmxP4Jaz26ulzbcqr3jefpBQAvyWha
   QNkR6Q5ogcgF4NJeRJid7vgCnnayvKAh0Sayd903Q/mxjSGQ8apYtkKyV
   TRmd6V1BleOjclETIaJvyhst2Z+ghUBHrS4F3EEWuydEORuM/rL4y6u8t
   6OkDiAGjMSwITqokxkEKw+7XjshVRgzYwvgqjkwSaHL04kjQh+87ghdfL
   M4K73k7IZiIxXxJB531lEaqGh1bovf7/0IGMd6bTcgar5ddJt6zbNlOHf
   Q==;
X-CSE-ConnectionGUID: C+IsOBpSSIuVYzNX/G0ImQ==
X-CSE-MsgGUID: wWAdeKvLRfm87nYMmHgkcA==
X-IronPort-AV: E=Sophos;i="6.14,243,1736784000"; 
   d="scan'208";a="49467646"
Received: from mail-westus2azlp17010004.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.4])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2025 14:29:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQXwwur6vDt+uXRym3+tZw2vv0HzY9h24TivfhmPuIqs+C/hlxac4gk4z+xQfoW67agrnjkijul7rvFElmh7HWWbpHfQhOvGgk9orlJsqFMwjwtZTUDrkKgYbFlKbBTccPYMl3ZF+K3inbMHJpaPOPqOZeB7Ezz3coVWKr36Ic7HPzP2uIyt2trNGQhBclPRiJx/u9IV/aPUSki1bSPQJ480gntCK7TDJO7ShAA1TcqCKutLAiZbBHPdAUgSaJV6McPdGO0E6a50RxBjdt5JLorukg8wEJ6gtwQW9eyvRWRhir/imX+18kF5i++OS7b/z93XBjcOX1742cMhlTO0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzdfZzVWsDuACu9ZyXnYK1vvF2M8fA/Me59/vsI0kvQ=;
 b=X9/72fCFLvJav+IOJWHpXs7dV2fxEMYwXAcEeRXtfGCsb1yXpYkN3AFlv80NKsiBBP2J4Kzu5MChrpOjhP6JsI+VTmil7fPHbGmNSqwfpylOpSpTCOldNG6Ij93m44o+zakP92BaTQxJPtVt76TDZuHc8Jz6LvLIZHeSqCYi+jW8cmO05COn0sot/CImqQw5Dj/hNO710jGEY1zr2YXlijfq2XAT47HNrx48yLQ4uqOtl4Usda9G53cY/DESQ/VDjIKRvsVuHFfmQErFnayORW20FxupoPyPYwGi6MmYtJFoMJm1ZeiOr6TawmOgU1pqwiiqQHusy9yQH134oSPOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzdfZzVWsDuACu9ZyXnYK1vvF2M8fA/Me59/vsI0kvQ=;
 b=t1OSU9JWVvifoa1aHcP+nKQ/db0YmB/FBGjrRG7hKX74GYy9ZNy3vQcltGVXOkiRYW4+xrmuZ2/xyhL+bFI+T57HPwsnhUGc8YShPkIfahaEHRQcmCx5me/NMpaUcNzp0ZcOm2oBZKDid7G3GkFasUornU6+udEWM38SEgCWpaI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY1PR04MB9564.namprd04.prod.outlook.com (2603:10b6:a03:5b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 06:29:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 06:29:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Topic: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Index:
 AQHbkWcHHm5kGZj2pUWXjQyYDI5QKLNshJIAgACkFoCAABbtAIAAl5aAgAArbgCAAUPEAIABWVEA
Date: Thu, 13 Mar 2025 06:29:17 +0000
Message-ID: <76e81f2c-17fb-4c11-b1c4-0b4c18b080b5@wdc.com>
References:
 <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com>
 <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
 <CAB_b4sCNenuqK79ce7ijSDQzXgLAq8jEe98z4P6_UqAz-OvhEQ@mail.gmail.com>
 <88371447-4d78-491c-9d86-ee2ad444c50d@wdc.com>
 <CAB_b4sAgb370vOS3OVp2Vx6W+9iLUrCUvfRwVx9WtWbFOXPQsg@mail.gmail.com>
 <6ab5accb-de28-4d79-92c4-1d3b085fbb08@wdc.com>
In-Reply-To: <6ab5accb-de28-4d79-92c4-1d3b085fbb08@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY1PR04MB9564:EE_
x-ms-office365-filtering-correlation-id: 804e7784-07d5-43d3-9514-08dd61f8619c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?emR2TUV4VUMvZ2NlVjZTUG52VkdUTGZtZUcyS0wvaWljL0hwRnRZN1krOTJK?=
 =?utf-8?B?NGZvTG1MRUNORVlhUjlYc3lNQW5ucHA3Yk1JT1R2MXRRZGVCYml1Mkg3bElx?=
 =?utf-8?B?Yndub2Y0azdMNTd5cWQ4d21XY1d5MTlHWGUwbE5OblF3VFdQUml6YXVEbE53?=
 =?utf-8?B?UGgvWHUzTGkwZXhhclc0Ny9uM1VJWEd2eGNOQm5TY2tiVzdGWHZXYlF4dW1W?=
 =?utf-8?B?S2VZQXlWeFdXYTVHTTJacElaeGNsMnMxOUtWeWRWalV1Vnh2ekFXTEtvNFNI?=
 =?utf-8?B?M1JHT0d6dGtTbW8xNVM5UkdwUUthUEJlR2lNc1hPM25nOEVEZ09iSlVtQUJh?=
 =?utf-8?B?ZHM2Ri9WVVJPcHRXMVc5Rko5VDhaZXhCUDRTaTljZVVDNUxRL2RIcmZWaHFC?=
 =?utf-8?B?MGVkMUY4b1hDbmJCelU1VWQwS3VrYVdvTkFEaFBEVk52UURYZjBXdGRBNnI2?=
 =?utf-8?B?WXhYeXVLTzJQdk1rMUJBamsvOE5KMUIwanZIbEc0dDBCaHBqZVZ1WDlhSkpv?=
 =?utf-8?B?Ui9OVUVrbWorRThXMnNxckFYbHpFNEhUR2Q2dXhsdklraWxMNjRmdFFCUi92?=
 =?utf-8?B?V0g5OGJTRDFLRVViRWY2aEdab0Zhc3dGMitiY2lJeTJqZ3F4WVd5cEhhYjRt?=
 =?utf-8?B?cm5mOGYrRXRrSDVTaWV4M3ZQT292ZnVNWXJXNDRlQ01IN0cxaEdMUWtOS1ZG?=
 =?utf-8?B?c0RidHNLN1ZnZEpjelZWSGhhc3oyaWV2ZnBSbHc5WS8vZ1F1dEtsRHAvVDJT?=
 =?utf-8?B?Tk0zQVgwd0pvOVdiem0vQ0RrVENUQTFHVVFuOHlmQ25GUllKT1N3NTNURjVG?=
 =?utf-8?B?TFFDcEhDeThXSi9PazRYK2RjamdnaFpvUEszMHFWWGRSU3lINnlhUlNkNVls?=
 =?utf-8?B?UEVrUmJzTWwxa3RXWFFlTFF6STU4M292emxTcDFSRWVTRHZGRzZ5RGR4ak1w?=
 =?utf-8?B?b3p3ZmNhK0Z6NExLQUNNTXJrYWpsTnJZMzBVTjJPL2tSV0tTQXFML1JBdTBz?=
 =?utf-8?B?Wit5RzVOWllqN3l3dUpxRWxVdDVCYW5tZzhaMVFad2RaVlBlUHRtYjZEbWtv?=
 =?utf-8?B?MnNJcFMyS1ljQjk4aFA5UVNGOVZ1RTRrQUZ6VnJucjRBdHZ3QnR4UWUvMUgv?=
 =?utf-8?B?bkx6R2srTXlGdWYwRDJkV3duZGJEYTJ3WW4xNnZVYUxjWVQ2bVhkSk05bGZ1?=
 =?utf-8?B?VGJwTEdHS3ppcC9SRU5GUUhpcWlxTm45NlZIMHNYZGp1QlBaRXJlWko2NDFO?=
 =?utf-8?B?dGZmQTkrOWhTTDVHa21yaWpXR3FhZTNiUGhjTEI1SGhvcU5MZCtjZjdURjIx?=
 =?utf-8?B?RkdlK2l0eVZacE03MmpTNTBaQWZacUxSL2lKTTV4b1Axai9aV1RaSWdKVGNt?=
 =?utf-8?B?SWF1aElsL3RLaTJsa2lOdXRNRGt4TCtLKzZ2S0xubVpCQ2QxWGxOdVhNNHh2?=
 =?utf-8?B?MnUxejRnTFdoQWI0eTZrWUlLaklOQUVrRHp5OGpvT0ZEdUNCQXNoUHV6bHJ5?=
 =?utf-8?B?TXlLWHd2K3VVU1krRkJXcnNTMXFtcUoyMHREN1ExejJPTGQxRk9EQXo5OTVI?=
 =?utf-8?B?QWRkSzIvZkhHc09mc2tnejZsb0NwV3U5T3V3YVdJQUg3TVJ1UndXQ1pNR1Js?=
 =?utf-8?B?OHduYU50R3dHSU9UZVJ2ays3djVDYVc5TTFGc3ZSbm9lVGV5UW9ieHVNL1pL?=
 =?utf-8?B?eVh0aWRDeVlkMTZ2akNKU0l1akdPK3lVYzMrR096aUJ2bC9qWjV4VDRYMnNU?=
 =?utf-8?B?dEF2d0IwRzYvVk9xVVJ6enhsYkxjWGJiVmF0S3Eya0sraDJWV2ZFTENiWXVh?=
 =?utf-8?B?QmFxK2VMZ0FBZU1oOVNsMFc1TmNHcTJ2NDNHSVdMVEtUWnlQUkIycGpvaW1F?=
 =?utf-8?B?b0ZveUwrTEFtcUxad3VJVkxNdUJMajJuNk9aSDloQUhQNHdMajQwMk5USG5X?=
 =?utf-8?Q?D4MmO8OoTzsId1FM78I6JcFTL0yvvhxN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c20zOVZSejZHRXp0YllhOUtNbTA3cDk2bmN4aUhoZzVtbDJEdGY3bllDTkYr?=
 =?utf-8?B?VytMbm5rNmxhdFRjV1dJeXlvUUVNTjhIZGFRRXJuSkkvclVhakVHckhtb2NE?=
 =?utf-8?B?SmgyWGdxMS8vTTJlNWtmbkI0YUt1ZFFaK0hJRzNvZktMZyt6SE91L1VtdnNL?=
 =?utf-8?B?Yy9HR0dyeVRwalJGY2JzZjAzQm9McE1TVjVNaG5aekxDbVFaL0M4eWhVZkRG?=
 =?utf-8?B?SjNzdnc4dlBsa0RIOTVoWm5jTE9MVUJkNFhpeG0yRTFIQ2xhTWxvVnBQVExJ?=
 =?utf-8?B?TVNyNWpkN3JTZXI2Y2ZqUHFtdHpFZGd3eHN5azUxT1VySy94NzVVQ2pPUXlT?=
 =?utf-8?B?ZW1rbXBxUFFUclBZS1FUdU53TEtuY0FvMlZPOGczVEhXNWgrREVmVCt2Qi9W?=
 =?utf-8?B?MEpCckFMUVQwSlZUd3BKWGNxcHRCbHY4cFJRSVo3b1Q5eHk2RjI0NGpMY3Ey?=
 =?utf-8?B?elVpWUZtMzN6QnE5cmxSM2JpV3pjTDFhL1Y3NmM3V2ZwUjdqMUJMS1dZOTl0?=
 =?utf-8?B?Q1ZwbTh5MTFHaEhTZ21yazZKMFBXVmIrOUl3dnhYaVhwc2xuYmFoRy81VE9h?=
 =?utf-8?B?WTNMdkt3NktqZHRsdlV3ODFURjN4dXVWL3h0V2VaRGxCUk1aa2ROSTlwL1d0?=
 =?utf-8?B?dzI3d2x1SXpYTXNsRXRtTGowUitiaFJqM0VoVHNSTER3Sm8rTzNaK1dibUNz?=
 =?utf-8?B?WlJLMnAzVHUyMzRNNTJtWUZWRXowVm9aL3kwMnRWdnJLRlhJVmhnK0hMS3V2?=
 =?utf-8?B?YVcwTG5KTWx6WlVzejBVWkZ5UlpyZFBHV2VUZkNiYXA3R2I2U01oS29hL0dF?=
 =?utf-8?B?QVkxZ0orQjgrS0R4N29VTFh3U3BZdUw1SERJRkg3WnJZK0UzTlhBL0xJTGJm?=
 =?utf-8?B?ejRPQUhSSFFYcHlYcTZaQVJKdnNZR2pZNk5DRm10T3pxZjNLQVAwajhOQkww?=
 =?utf-8?B?ZWkyeEQvUVEwWm9ubDRvOTVGZjVNcnVZdXBFZVg4VmliUkhKY2dLMCtVN1lm?=
 =?utf-8?B?ejBYMjhuK0F1TWs4Qm1YVDR0NEp2a0RSY2NnSE9Fc0E1a2t4VDNZaUF5WVYw?=
 =?utf-8?B?UThvbTh4aURZekdpMGk5WWFTVmtnc2JSR2xaVDNJZVdSMTRCQTNnZHQrNTB1?=
 =?utf-8?B?cWFzbWdpQkFTVGI4Snl0UGxtM1l3V01rbmFWQjVvL25JcmRWaGw2RkdVcGNy?=
 =?utf-8?B?VDNBT3U3WHBHRlljMjN5Z2FLZGNzUng4RzhGYURXdEpRYzEyeTc2Vm9rdXFY?=
 =?utf-8?B?RkE0VFQwdUNkOXcvK0k2amxkL3VKaEEwRVhpUmdKVzZnTXEybG80MVdSd2dN?=
 =?utf-8?B?ZVlUd29rUHl4YUZGT045TnRmRU40N3BUYmw5VVFRNmc2MitWT0VMc2oxMG9G?=
 =?utf-8?B?bVJPdUpoejE5eTFLUnBhcUMrdFB4VDV6RU5vdkNsekZya1pYVVUvcnR2S3hD?=
 =?utf-8?B?VWRSb3JmWU5mYUNTZWJROUJCbC90ZlFTWVRqZlVyTDMyRENHRnI0Y3ZtZ3Vp?=
 =?utf-8?B?WjRGeGVweEJ1cWNpTERHendUNDg1RFpOWXZBd1N5NEY5aDdoUUYrbjMwNHJR?=
 =?utf-8?B?WjJETlgvMHpodlJRTUYxaEZVanM1SGYvOGlSWHVCRjFMYlhnMzNCY0ZodTdH?=
 =?utf-8?B?RVFyNCtWcXRKcGhzbTE5QWMreDdXMGNCVnY5UEpNSEMzY3ZMSU45eUtRZzNE?=
 =?utf-8?B?ZnZUNGFIOG1YUjBNaTNydjBrekRtQVlDMjE1M2QrTDh3OUpENms5WElYV1NN?=
 =?utf-8?B?aXVQRWFPcXRXanVsT1FjNWdhd3BuZys4c1FMeVdRTXVqejVqQjNCK2FpMDVn?=
 =?utf-8?B?WmNIYUlhR2dsK1U3WXlSdVhtSi9JaSsvUCtWSkdoY2tiaCt0aGlvWWhFTVZQ?=
 =?utf-8?B?VnViQlQ3Qm5RaW94UmZ2bGozSW5XRHowdEluc2cwaXVXV2NWWW1nSmVVcmV2?=
 =?utf-8?B?R0ozT0lybTdoaFVTc2RTVGxwc2YyL2U5YStZZEY5S084Y2w5Q2d5UkZ5NEdS?=
 =?utf-8?B?ZHFRNGV4RW1pMUI0ZXc2WXNkZVZSM1c4K1lJSi9Oa0h6cERkS3ZqU2lGRTRO?=
 =?utf-8?B?UmpDYjVPV01OK1k2TC9UVTBVTmpIdVZrRElLMjdvREZ6SEFRQnR5dE1qZGpD?=
 =?utf-8?B?VEJxQ0ZpVWhBbFNsTFJXcFJoa1g3NnlDL0VlY21Da2ZQME5EbG9KSWNlK3Ey?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F09D1A446B5234CA97031896D208564@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IAY0Ts4BeZwBKyK/OmZHJybkbTTHq/8/jyg+81oIkghITInOgCPgKV56Omr2agc/IHoUUmXvlguVy8HZW3U2YNjHgn0i+MYcAlgyrV5bOpuWScT1fNHeIjbBp/ySuJk1FQKXqgSlTMDIvQxQa7S/xed5QHnYKGEs7kyvJJF9y10qcau13RHFYOW6paiH2EU4QIac0APdXX6oIv9H2UGbnoWQFdlXrg6/dwW4KS8RzHZ8Umb7jfGlf6y7SYdaBTZ5AlP6wyeKAwBuCg21ZGt2Ap2P8njFKcsPNu/fGag1BPC1j0803YpUqVDJhB3VqRpYJZXWIZ3M6v7FI1vgN8BtnpDg2ijAu5OJUwzBgdl5VW/48w5N6RUZwZm32gVawFyM3wOvw4mQPThkNila6wDl+KS2AOn9WHmIf8dLnE/t1ALJHPnkUrfDKuOr1mCzzX6KoWHC3tvB6vSKOEn59iytoaUwNa72n1SVGyaSfRLO1qKu2MJpXVz7csDJJVuavmi8JKc+Yadf4sWyo8Ow1405A+LJaIPM9rTrK/mRZZ5ZA8sfFUGDyAb7piy+Wg2fWiwGo16T5DlSLH8JKhUwBF9NQNbNZVFEHqsiV2Jc+PPmpE3DiV2hWCPHHcTZiD4bW9Iz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804e7784-07d5-43d3-9514-08dd61f8619c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 06:29:17.3543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRbYZbgROyCrT+VnuTilkP9ukHjicj/6ZZ0OGByajthAotI2fE4pItdIDa7f8HuI4beNx4Yb/Y/YmB4ibcbupoqtigrCdRmnTnZguQAlQnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9564

T24gMTIuMDMuMjUgMTA6NTMsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMTEuMDMu
MjUgMTU6MzQsIOilv+acqOmHjue+sOWfuiB3cm90ZToNCj4+IEpvaGFubmVzIFRodW1zaGlybiA8
Sm9oYW5uZXMuVGh1bXNoaXJuQHdkYy5jb20+IOS6jjIwMjXlubQz5pyIMTHml6XlkajkuowgMTk6
NTnlhpnpgZPvvJoNCj4+PiBOb3QgZmluZGluZyBhIG1ldGFkYXRhIHNwYWNlX2luZm8gaXMganVz
dCBicm9rZW4uIEV2ZW4gbm90IGhhdmluZyB0aGUNCj4+PiAtPnNwYWNlX2luZm8gcG9pbnRlciBu
b3Qgc2V0IGluIGEgYmxvY2tfZ3JvdXAgaXMgYSBiaWcgcmVkIHdhcm5pbmcgc2lnbg0KPj4+IHRo
YXQgY2Fubm90IGhhcHBlbi4NCj4+Pg0KPj4+IEFzIHBlciB0aGUgY29kZSB5b3UgcXVvdGVkIGFi
b3ZlLCB0aGVyZSdzIGV2ZW4gYW4gQVNTRVJUKCkgY2F0Y2hpbmcgaWYNCj4+PiB0aGUgc3BhY2Vf
aW5mbyBpcyBOVUxMIChidXQgQ09ORklHX0JUUkZTX0FTU0VSVCB1c3VhbGx5IGlzIG5vdCBlbmFi
bGVkDQo+Pj4gaW4gcmVsZWFzZSBjb25maWd1cmF0aW9ucykuDQo+Pg0KPj4gTm8sIEkgbWVhbiB0
aGF0IGJ0cmZzX2FkZF9uZXdfZnJlZV9zcGFjZSBpcyBjYWxsZWQgYmVmb3JlOg0KPj4gY2FjaGUt
PnNwYWNlX2luZm8gPSBidHJmc19maW5kX3NwYWNlX2luZm8oZnNfaW5mbywgY2FjaGUtPmZsYWdz
KTsNCj4+IGluIGJ0cmZzX21ha2VfYmxvY2tfZ3JvdXAoKQ0KPj4NCj4+IEFuZCB0aGUgc3RhY2sg
dHJhY2UgZm9yIHRoZSBudWxsIGRlcmVmIGNvbnRhaW5zDQo+Pg0KPj4gPyBfX2J0cmZzX2FkZF9m
cmVlX3NwYWNlX3pvbmVkLmlzcmEuMCsweDYxLzB4MWEwDQo+PiBidHJmc19hZGRfZnJlZV9zcGFj
ZV9hc3luY190cmltbWVkKzB4MzQvMHg0MA0KPj4gYnRyZnNfYWRkX25ld19mcmVlX3NwYWNlKzB4
MTA3LzB4MTIwIDwtIE5vdGljZSB0aGlzIGNhbGwNCj4+IGJ0cmZzX21ha2VfYmxvY2tfZ3JvdXAr
MHgxMDQvMHgyYjANCj4+DQo+PiBJbiBfX2J0cmZzX2FkZF9mcmVlX3NwYWNlX3pvbmVkLCBjYWNo
ZS0+c3BhY2VfaW5mbyBpcyBhY2Nlc3NlZCwgd2hpY2gNCj4+IGFwcGVhcnMgdG8gaGFwcGVuIGJl
Zm9yZSBpdCBpcyBpbml0aWFsaXplZCBieSBidHJmc19maW5kX3NwYWNlX2luZm8oKS4NCj4+IFVu
bGVzcyB0aGVyZSBpcyBhbm90aGVyIGNvZGUgcGF0aCB0aGF0IGFsbG9jYXRlcyBhbmQgdGhlbiBk
ZWFsbG9jYXRlcw0KPj4gY2FjaGUtPnNwYWNlX2luZm8sIHRoaXMgc2VlbXMgdG8gYmUgdGhlIGRp
cmVjdCBjYXVzZSBvZiB0aGUgbnVsbA0KPj4gcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4+DQo+PiBU
aGUgb3BlbiBxdWVzdGlvbiBpcyB3aHkgdGhpcyBpc3N1ZSBkb2VzbuKAmXQgb2NjdXIgb24gb3Ro
ZXIgc3lzdGVtcy4NCj4+IFBvc3NpYmxlIHJlYXNvbnMgY291bGQgYmU6DQo+PiAgICAtIEkgaGF2
ZSBtaXNzZWQgb3RoZXIgcGxhY2VzIHdoZXJlIGNhY2hlLT5zcGFjZV9pbmZvIGlzIHNldC4NCj4+
ICAgIC0gVGhlIGNvbmRpdGlvbiBpZiAoIWluaXRpYWwpIGluIF9fYnRyZnNfYWRkX2ZyZWVfc3Bh
Y2Vfem9uZWQgbWlnaHQNCj4+IGJlIGRpZmZpY3VsdCB0byBzYXRpc2Z5Lg0KPj4NCj4gDQo+IEJl
Y2F1c2UgdGhpcyBzaG91bGQgZW5kIHVwIGluIGluaXRpYWw9dHJ1ZSBhbmQgbm90IGhpdCB0aGUg
aWYgKCFpbml0aWFsKQ0KPiBjb25kaXRpb24uDQo+IA0KPiBUaGUgcXVlc3Rpb24gbm93IGlzLCB3
aHkgaXQgZG9lc24ndC4NCj4gDQoNCklzIHRoZXJlIGEgY2hhbmNlIHlvdSBjYW4gdHJ5IHRvIHJl
Y3JlYXRlIHRoZSBidWcgd2l0aCB0aGUgZm9sbG93aW5nDQprcHJvYmUgYXBwbGllZD8NCg0KZWNo
byAncDpteXByb2JlIF9fYnRyZnNfYWRkX2ZyZWVfc3BhY2Vfem9uZWQgYmxvY2tfZ3JvdXA9JWRp
IGxlbmd0aD0rMzIoJWRpKTp1NjQgYWxsb2Nfb2Zmc2V0PSs1MjAoJWRpKTp1NjQgYnl0ZW5yPSVz
aTp1NjQgc2l6ZT0lZHg6dTY0IHVzZWQ9JWN4OnU4JyA+PiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFj
aW5nL2twcm9iZV9ldmVudHMNCg0KYWZ0ZXJ3YXJkcyB5b3UgbmVlZCB0byBlbmFibGUgdHJhY2lu
ZzoNCmVjaG8gMSA+IC9zeXMva2VybmVsL2RlYnVnL3RyYWNlL2V2ZW50cy9rcHJvYmUvbXlwcm9i
ZS9lbmFibGUNCmVjaG8gMSA+IC9zeXMva2VybmVsL2RlYnVnL3RyYWNlL3RyYWNpbmdfb24NCmJ0
cmZzIGJhbGFuY2Ugc3RhcnQgLW1jb252ZXJ0PXJhaWQxICRNT1VOVF9QT0lOVA0KZWNobyAwID4g
L3N5cy9rZXJuZWwvZGVidWcvdHJhY2UvdHJhY2luZ19vbg0KY2F0IC9zeXMva2VybmVsL2RlYnVn
L3RyYWNlL3RyYWNlIC90bXAvdHJhY2UudHh0DQoNCmFuZCB1cGxvYWQgdGhlIHRyYWNlLnR4dCBz
b21ld2hlcmU/IEFuZCB0aGUgZG1lc2cgYXMgd2VsbCBwbGVhc2UuDQoNCllvdSBtaWdodCBuZWVk
IHRvIGFjdGl2YXRlIGZ0cmFjZV9kdW1wX29uX29vcHMgdmlhOg0KZWNobyAxID4gL3Byb2Mvc3lz
L2tlcm5lbC9mdHJhY2VfZHVtcF9vbl9vb3BzDQoNClRoYW5rcywNCglKb2hhbm5lcw0K


Return-Path: <linux-btrfs+bounces-7115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA594EB7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 12:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC76282689
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F1A170A34;
	Mon, 12 Aug 2024 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iu39bjDY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VhOGVz4w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D69166F29;
	Mon, 12 Aug 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460098; cv=fail; b=tQ9bGWXCNwQ1GrHt8PeZdolu2vNTS4xzEzropSxqF4U/cumZmMwpO1xj6QkGK7+sKK8mmZ0DtvsdNDPeoWqNq7ozejCsfgFW+20wNggoJ0G1bu+fXFUWVtqHPyCflEN47F2cVYG5k51SxShvn/bRmFZGaqsiyhHtgSR1tG2lH9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460098; c=relaxed/simple;
	bh=ltaX9Lrlg6N+wMatji8cU5P4fgTAaNzZcB0gxHnKSbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XzsCihdZ8PSNoAcAI+o4jvd5JT+Lzgt1s5hJW4B/7TlSaA1J0wT2AFBfvwDiWlHgGKgsIX48mSBeSKSegzItXz2O1Nw+6oscwpdJsEbp6fNmydgiK8gZHPx1ktOiGrZIZ7NVbyRMHqA6uC223xH5+8eQjvwpp5kgiLL/wFDb76w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iu39bjDY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VhOGVz4w; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723460097; x=1754996097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ltaX9Lrlg6N+wMatji8cU5P4fgTAaNzZcB0gxHnKSbc=;
  b=iu39bjDYq/CR+8i6LoXUaiHQn5vscOOR53s4sx5jMMpqcm3RX/m2LvMG
   iXb55MnugvW8aNxSuH3GU8rhXlm2wVlnmFZXxDpVeXF68d5gotkWScbI6
   wnH3mem/pL8lzvIOKkToLF4ZQ9XrlQKGTEnUJklXYJaVLwK5lZxq8UD2k
   0xXEN9amyuh6ZfWegZUGG2Ct5HRYm6bkK46h316ZKDJgCxZxa74avyf39
   sIQkMRra1jKPEghvc7ro3xcp/NyG9roO+raZoAM5UMkQlPETQ31vK7Qta
   q0ag650QSA0i2q52PgEoriXaeVFwLYqRuTMjZMrzj1GUQtU6oZudJvMbM
   w==;
X-CSE-ConnectionGUID: JuN65qw8TXeGeRmJLtgd4A==
X-CSE-MsgGUID: woJv+e8rSnWDWkNg1BJ7AA==
X-IronPort-AV: E=Sophos;i="6.09,282,1716220800"; 
   d="scan'208";a="24057319"
Received: from mail-westusazlp17010002.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.2])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2024 18:54:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/61NXdAkYScVcFhLjPvdeBnt/jPWfe7srWMPwPnTUjTjaSAhPz4CToDdBqHkx5Mb6YAn38Gd2t9MBa5HJTJes3XnszG+EzY8g+Hy3VHIn2JiESmmEPLzGFDRtfdkrC/bIPcDaq2cZCMOkfXkQCah03W2Ns83iUhkyFvgLaGNRb+qmB+xUB2lOhWjsDqdgvEvI4MHp/eNDxdc2qX3EoNA7PfEnp1vgx4qjGPCZ2bq0rwPbTISZSj7taT83+DMKftCscZjg29ay1fs6WvfzQHcLo7fnHMrWoq+bLB+ciTk7yAuWHATnnNNJyA3EO4w96HxJZ+Q5HUr6lzJ2ONrAUcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltaX9Lrlg6N+wMatji8cU5P4fgTAaNzZcB0gxHnKSbc=;
 b=umHnL1pbxqHtuNq8tnawn9YtO/L7eQdxjv46/kCpQ17XIXhg1BCSdgBqw3ZK+o6GipU43u14uEE+VIngge1vYCPI5ZmJCSoDFaQGlppZheM2rKdM8Vrm11I4+BW0PkneUeHhLuDgybH9pbaRCVmCH2Ov6/0Az+6POUXKXomq8rylhjq1AtcnhRLTSww4kaOmUknnc713k3E9rz6Up9lkqI0dAycU0VxJZnjT7doW8rN1wm5ctCPuyqmd3Kd2+Iu1WWPl961EuiRxGmyeMEU2jJlZr9li0JhxAMgHG2Hx6E/CcThaH3Q6z6JQ6GSj9WZ5b+W/Pb0K7g1XVWiMYyOvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltaX9Lrlg6N+wMatji8cU5P4fgTAaNzZcB0gxHnKSbc=;
 b=VhOGVz4wbPvH9Efeq+95R9KX2sveFMru9e9wDElbGy6vANmX1LQlifPMonVbrPhO0PTusnL10W/vJJAvPkuq/q46HDlZ8Wk+XscxeBgIlobpGoF/1c30PGnazBK/EWMBPTvX9J/UG2ghBg4Hdc0IBjl/FwU1eql01YrODaWD64E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8242.namprd04.prod.outlook.com (2603:10b6:510:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 10:54:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 10:54:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>, "kees@kernel.org" <kees@kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Annotate structs with __counted_by()
Thread-Topic: [PATCH] btrfs: Annotate structs with __counted_by()
Thread-Index: AQHa7KOdpamJPHuI3kOW73ghyeClcLIjctEA
Date: Mon, 12 Aug 2024 10:54:49 +0000
Message-ID: <e7cbec5f-269a-410c-bb5a-e00de15078f6@wdc.com>
References: <20240812103619.2720-2-thorsten.blum@toblux.com>
In-Reply-To: <20240812103619.2720-2-thorsten.blum@toblux.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8242:EE_
x-ms-office365-filtering-correlation-id: 83eee009-47ea-4c27-5902-08dcbabd2fa5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0NVWWNtdXFxSkVsdVIweHl3blk4b0lydEFyUzIrNjkwUDI2T1Q0blBIcEc5?=
 =?utf-8?B?YmgyelFtQlBoZ054SmNmTk0xTWVJaEFMVUt2TWozOXdyWnVDak5SdkdQRTEw?=
 =?utf-8?B?bkdFRHU0V3FzTDhMUUd5WGJ0U2FranBLTjAya1cxSGhWZWFsUkVMczM3R0F4?=
 =?utf-8?B?YW5QLzd2eXZ6NndpQkhYM3d0RVordUZlNmQyUm9pNzhkQWdHSldtZk14VjZ4?=
 =?utf-8?B?RXkvZnVYZlB5VUVIOTZvOG5LYVNES2xnek84QW5rSnVjbGdsV1YxdWk5TXZW?=
 =?utf-8?B?UUVxWWt3UVJrRkg3Nk1xZ1ZzeHg2ZXcrQTNoUUxTRU1lb2w0YWl6T004aVFl?=
 =?utf-8?B?U3d6S3ZHQ25NcDUvTE1jb0ZYdG9DQ3JWRlNvSnk4Z0dTT1A0TW1KY2JrMnIr?=
 =?utf-8?B?VU9IQ1dpUFRaRzJaYURvRUd0VXpsTWhycEJkSGp2QVk0UlVRWHZvazMvc244?=
 =?utf-8?B?Y2ZuR0VQOXRCMXlSWTNGa2tmVkdPU1lQNXJ6UU5DU08wMTdOTDFGNXRtdTEw?=
 =?utf-8?B?MDVIcEF3Uy93cnVxME14MEd6Y1FKTm5MU212RmdLKzY0N3JIZ2xESUl1SjBG?=
 =?utf-8?B?eEdLcndzTjczS0k1NFBKNlR2U0pNTUFhRE1MZGJxMHlRYkVGT2J1Nlp6SVdx?=
 =?utf-8?B?WEhEMld3Z0JTcVhza0FZMk9XSnY4M29GTG50T1hrOHFJcitSV1B0eXRxdjFo?=
 =?utf-8?B?elBVbUloRTJFT0UzdGhuN1g0UEpvS1RieFNpblRqbFJoMWRoU2VTTjZTY0ZZ?=
 =?utf-8?B?WUZzbUxkNW5DRG1tZjJ2MUI1MXd5QTY0M0ZsUzBtc1Z1eDVGMHFpODJhVnhR?=
 =?utf-8?B?NW1xNkpTMDJ4aDhFV3ZGU2R0bTNTdkdXL3FrLzVVdEtPenZVM3JkZzNIYmto?=
 =?utf-8?B?dmJIMWUvaTFsYW93MThUcmdLdll1RzhPVVV6bUlBRGhYTDhXT1JhMHlZZnI3?=
 =?utf-8?B?T1dwVkdZL0ZKYVJ6a0Yydk0xbDV0ZnRDK25hWFM3ZU0rT0x0MG9mMXg4ci9y?=
 =?utf-8?B?Y0NMeTVxRmtrZHl2aHZNVDN6NEZNa1VDNHBzUzZvcnplTFhxMDkzV2YxelVE?=
 =?utf-8?B?cWtrNDRRMlJWb3JNWHZRcytGSHlIdVMxNHpXN2hCcUpBd3Y4UlJSWmR5YkR6?=
 =?utf-8?B?QmJ1ZytxZ00veTJBYlBkYS9xRDRCNFNpQ3htdUIrSDNTb054OGdHNjhwR0Q2?=
 =?utf-8?B?K1JzUU9HbFlPZmsxV1dQa0xSNGFOc21qUXk0aVpvbW44VzY0eHlyUjVlSGYw?=
 =?utf-8?B?TS9jcnFZMXBNeks2alpEV3Q2UXl5eXVicEhSTzRxbythTzhGVm1ZOVpoSmZW?=
 =?utf-8?B?MGJpY1RkbXBsckxKdklnalF2ME9WQ0FBTy8wYlRJWjFjRXVLRjcvcmtwbXho?=
 =?utf-8?B?TDF5SWU5NVBxK2RMeE44ekZYSFpnd0RaQ1N2aDRFTjFtVURLM2xIeGUzbHpi?=
 =?utf-8?B?d3NtdmdoN2Q2MS9HNy9hMHJRUnV4V0JReit6cDJ3UktzRkUyN3lTRllaeTRu?=
 =?utf-8?B?NG1JU0hCN0MzR012aUVKc1U3ZkFwQStFa3V3Vmkwdzcrdnd4dXNLc3pZcG94?=
 =?utf-8?B?M0g3WkhVa3kxVnVWVHJ2UXhocWREZzNjTDlSSERsS3BGZ0F3Mm9Zc2Q2elc4?=
 =?utf-8?B?M2FFTytqUjhaaVhtcithZkhhR0pvMlEwL1Rwbmo0RTlDdkloczFVbVFzVFVo?=
 =?utf-8?B?akhWblpRaEZYNUY3a3R3SXFMQXFXeGxKSEw0M3RDY2E2UTcyd1ZXRDlEa1VB?=
 =?utf-8?B?djJVWFBXZWQzdkM4VjFCUU93cExpc2NoYnVmS1ZZTDV2ZnMzY09Ja1BoQytx?=
 =?utf-8?B?T09NanJKbXplRUtYdTR1djcrRWsxNG01NFFwUnRoaVVjYUVKa1dLNDNmcmM4?=
 =?utf-8?B?bldxeko0bTV3Z0x5blRSdTk4Mjl0VktZaWpJQmxsUTgrdnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkNLMHVWT1F5RUIza3FoUVlyeFJuTlA4MzIyZ0hBdmZiMGhEcGR3VjNCeEtQ?=
 =?utf-8?B?VFVxQlZpWXpSRGtGY3hSdEdTa3ZrclNDamN6SlhiWnUzUFBYUFhmb0JFMUZy?=
 =?utf-8?B?dGxSTks1dkdLVGZIR2VMbk02cXJyNkh5ZUdoL1ZKMUptWmtwcGZ1MUhmQ1Jv?=
 =?utf-8?B?VXpNZm1tYkgwNXZxOEYrdWY2TDM3TXYxaHdNNHFYam51RVo2WldaWjdFNjhB?=
 =?utf-8?B?eXNYaS9CL0xUdUxIVGZOOUs2d1dnS2JFY1JuK3JsMStjaWdWd1l3WHRLTWJ6?=
 =?utf-8?B?ZHFQVGpFRytsY1cvcTExSERJWUcvYU9CeGFiVzVuNURxcTFDdnEzUWNSejM0?=
 =?utf-8?B?NlYvVHY3Sjl1NTJpcnRGUjdNRjk2dzM3RnZhUDJyallkbzlZMFVkd0RuZTJr?=
 =?utf-8?B?UlFtVFJiRVBJWTR5ZDRpc2xZMUZXS3FwRWRzSk90VWFrQWVtZFhVNGQvNnFS?=
 =?utf-8?B?NU5RTVBlZVNBc2RDenN4YWtRNDU5VmllSEpPdzJ0dXBIM2ZrZHhiODZDMWRL?=
 =?utf-8?B?WWFxUCtpVHFHTjBWT2JZWEJkNlZuZGo2QzFSVEZwbGhWWG03M3k2T1ZuSytj?=
 =?utf-8?B?ZU5BQ2k0UDY3TTNGMUFjR3VURmdvaEhKTXQwOStEclBweHRlMW1CeHZUSnFO?=
 =?utf-8?B?RFA4eVJDTjV2aVRWUHE5SmVhaUJTVXRoWWh6YVRRVkZsekxIRWhkYWR0MHND?=
 =?utf-8?B?RkRGejZMcElMeGZ0WGlzSEhQYjZpcEhtOCs1T1ZCa1pTZEpVckJKRzBGcTZ5?=
 =?utf-8?B?NmI2TUtjd3RaZmt5d3NoUlpBWi9QTmRVN3hram0vV2JNRlpSK0M1ZnhDdnlH?=
 =?utf-8?B?K3JIK2JCT0xkL0JaYjZXMXJKRklDcTI2LzVReFFNVmc4OEMrRyt1Y2dQSGxH?=
 =?utf-8?B?Q0RVMDBWTUVleWFFK2pxbWtJbEwwZjRaWG1kOUh1T1B2WjZqQ2dhakVuV3NG?=
 =?utf-8?B?Z0xZam5uNG1GSHdhNFk1N0I1RG95S2pJYkpwVzlCQXh6cTdKWDhUQk9CSVpE?=
 =?utf-8?B?U2hFbUt5ejhUcUZlTjRGM1cvcW16Nk1LbkQzbkdRcnVxeTJ4WVJiTEd0eHJz?=
 =?utf-8?B?SG11Q20zdDhSMGVOTnY5VXh0UEU1L010aERXTTMwMi95Mi9kSWZDckpLMWFt?=
 =?utf-8?B?eTdiUkZtSHVheUdFQ2owcU5JZTVrbHBzNEcwWjRoNDBISWJMNzlTOVJ3QmxU?=
 =?utf-8?B?UzJjZ0svZUxpRFZhQkFaWWVPaUZuMmZWMHhNTnZtSDd1UVk4enAvNkU5R0lT?=
 =?utf-8?B?QThXaUtOS0ppUkY5TmlWdUgvVVh2ZGxtcnA2U0pROFZ3UjNlUjN0YTFsa1NV?=
 =?utf-8?B?bWxvcmphZFB6QloxUUYyVlpFbkdERTdubVhOejRaUHdrY1hPV1IwbmQ5aUQ2?=
 =?utf-8?B?ZFFFeE5vUTlJWHFkTHVDM3NZOG5POGlCWDBWbk85ZXNqV2IzUzloMGRodXgy?=
 =?utf-8?B?VDQ0NzJrcE8xcDVBeGpqLy9WajlLVytwZERMenFaSmpHd3hrMTV2VlZiMU5k?=
 =?utf-8?B?RUw4UU1PVTdhSUlIaFdTY0V0enpCTncwa0Zsa3ZTRWpOd0h3azRVNHV6NWhS?=
 =?utf-8?B?VzFGZkovZlBrR3IzOFM1UWY1WUR6VzR1VmZZckxTckRSUEM2djJBRnZ3cHBm?=
 =?utf-8?B?SkdnL2ZpWTVzTXFNOU55T25BVFppck0rOERSbzZvcStsSkR2MnZMeWxLUlNv?=
 =?utf-8?B?MGFMUDhHanJUQWViU2VUM0xZYjFobzJQR0RoS2RjUDVrSUZvc2cvWnRlUDBv?=
 =?utf-8?B?MlZ6M2kvTllBcVNZQnNzMXFTZTB0SlEzaVRGRjg5dnlhNlQ4cnZHNUpLK1Q0?=
 =?utf-8?B?dlhjU3N1WTFueUJVeUhJL2xaU1NVN1FMcW1yUGlkNXovYUl4UTFjMG5UVHJh?=
 =?utf-8?B?ajBSb2lyODNqeGkzN3Y3Qy9XbUhZejlqT1BqV2xBNVhXTG9rRVl6dDlndkZn?=
 =?utf-8?B?eDlkWEJKVHZmUGRmclR3djFvcWJuZGRWWkMxenptdnBpUDRjTmdLMkwyL1Zk?=
 =?utf-8?B?ZEpSTmRrRU9hQ2MyL3pIcHNBMzVrR1kvQmFic2t2UGRxTWJ6MTdxeFlLSk4v?=
 =?utf-8?B?bEZxdEU5VmV5NHdQbkkramJZeXJRZ1ZuZjJlZG4zbmJCUkJlcG1ObzdpMVhD?=
 =?utf-8?B?bXpLWXpxSzdsbm5OM3lINDBPV0IzRUdnVjMzbWdDcUZhd2JOTHM4VXRLOTQy?=
 =?utf-8?B?MEhzckFwaUxLeS94OGR5ZGt5MHRLNHpOdjZGSldRQk5FamRMdGtTbkhMYXpL?=
 =?utf-8?B?QlpDL3I2Y1Byd1lkWWYzN2E5VnFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <222BA411504AAC4683DF73CFAF6E8C73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pyqycPUWsGvmF/13bHL/oS+QyMy1RvHJ2kB7vPTZGDbw1XtQMMhT6yTIdn0s7n3pNJxM/0QAsiHyiCDzN1tjnTkKURcm4NXFsVJfKIP0WH0zOr9/ORiju3cIKVbxqSqtXHWSjjbiHYID/tskhvOVp8hQK1g9mWMUm4H025jZ/nN+eu6C8U+8RK8totV/mvSjmmqrFMpMij00tqETKoqmBkac5JbNVVXEkdRnGDdVYW1ZTMIuVQRyPaZDH1NamZPvJZbpHidxHFhcqZxxB5rPKB+u3n37CjKYwK9poIK3KfmGHprUbwR6uEy6mGrt0GOZaPbAZHf8/ptAEa5Lauk9v6bwJs5uddPirhZeMUmXSMVOaHeZ+kQifU+mAvpPyeI9ozifLxt219/n0kNUqwasr90hhbqATa72N9QPLd3G2L8+4hhgQcJzyKvtxtbsvYJCgH4PfTnTPnaGflAvBO6MhXqNbSFmIYRUn2cuXCBkYOk85bSEKsC/hGz+e9p7fOojlU9BvN9XjfvF8eYuYn9hd4QCWiJvbiA3hFWs7tSJrJt+W98X5liVRrYm+eQ2+Veh4XCX3pDSVKQxguLB6rh8PiyMdIKiLhi38pkNNOCZvKOF2wDBatXdEBx5WcK5YXkV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eee009-47ea-4c27-5902-08dcbabd2fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 10:54:49.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3K2D6g91aCHFwbw0zuxPF0yvJ6lUDTW+/+W/VmbPiJ26b3oU7cIa5uHgKs+65sWWOGAqQytkQnxL5H2YNHk3mjpnWKeJ5g+p6Y8X/bro344=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8242

T24gMTIuMDguMjQgMTI6MzcsIFRob3JzdGVuIEJsdW0gd3JvdGU6DQo+IEFkZCB0aGUgX19jb3Vu
dGVkX2J5IGNvbXBpbGVyIGF0dHJpYnV0ZSB0byB0aGUgZmxleGlibGUgYXJyYXkgbWVtYmVyDQo+
IHN0cmlwZXMgdG8gaW1wcm92ZSBhY2Nlc3MgYm91bmRzLWNoZWNraW5nIHZpYSBDT05GSUdfVUJT
QU5fQk9VTkRTIGFuZA0KPiBDT05GSUdfRk9SVElGWV9TT1VSQ0UuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBUaG9yc3RlbiBCbHVtIDx0aG9yc3Rlbi5ibHVtQHRvYmx1eC5jb20+DQo+IC0tLQ0KPiAg
IGZzL2J0cmZzL3ZvbHVtZXMuaCB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvdm9s
dW1lcy5oIGIvZnMvYnRyZnMvdm9sdW1lcy5oDQo+IGluZGV4IDM3YTA5ZWJiMzRkZC4uZjI4ZmEz
MTgwMzZiIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy92b2x1bWVzLmgNCj4gKysrIGIvZnMvYnRy
ZnMvdm9sdW1lcy5oDQo+IEBAIC01NTEsNyArNTUxLDcgQEAgc3RydWN0IGJ0cmZzX2lvX2NvbnRl
eHQgew0KPiAgIAkgKiBzdHJpcGVzW2RhdGFfc3RyaXBlcyArIDFdOglUaGUgUSBzdHJpcGUgKG9u
bHkgZm9yIFJBSUQ2KS4NCj4gICAJICovDQo+ICAgCXU2NCBmdWxsX3N0cmlwZV9sb2dpY2FsOw0K
PiAtCXN0cnVjdCBidHJmc19pb19zdHJpcGUgc3RyaXBlc1tdOw0KPiArCXN0cnVjdCBidHJmc19p
b19zdHJpcGUgc3RyaXBlc1tdIF9fY291bnRlZF9ieShudW1fc3RyaXBlcyk7DQo+ICAgfTsNCj4g
ICANCj4gICBzdHJ1Y3QgYnRyZnNfZGV2aWNlX2luZm8gew0KPiBAQCAtNTkxLDcgKzU5MSw3IEBA
IHN0cnVjdCBidHJmc19jaHVua19tYXAgew0KPiAgIAlpbnQgaW9fd2lkdGg7DQo+ICAgCWludCBu
dW1fc3RyaXBlczsNCj4gICAJaW50IHN1Yl9zdHJpcGVzOw0KPiAtCXN0cnVjdCBidHJmc19pb19z
dHJpcGUgc3RyaXBlc1tdOw0KPiArCXN0cnVjdCBidHJmc19pb19zdHJpcGUgc3RyaXBlc1tdIF9f
Y291bnRlZF9ieShudW1fc3RyaXBlcyk7DQo+ICAgfTsNCj4gICANCj4gICAjZGVmaW5lIGJ0cmZz
X2NodW5rX21hcF9zaXplKG4pIChzaXplb2Yoc3RydWN0IGJ0cmZzX2NodW5rX21hcCkgKyBcDQoN
Ckxvb2tzIGdvb2QgdG8gbWUsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hh
bm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KT3V0IG9mIGN1cmlvc2l0eSwgaGF2ZSB5b3UgZW5j
b3VudGVyZWQgYW55IGlzc3VlcyB3aXRoIHRoaXMgcGF0Y2ggYXBwbGllZD8NCg==


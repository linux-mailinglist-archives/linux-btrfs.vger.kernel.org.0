Return-Path: <linux-btrfs+bounces-16870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CD9B5A0B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 20:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49582163C13
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8C02DC335;
	Tue, 16 Sep 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YGE6kTHH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mS0NZfoS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEF24EAB2
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048088; cv=fail; b=WyDBIpKEfQV2guwRB9XcbhB5LSA3ACadha9wqfJvysWiK6CNTuXPig3Qbrw+6R/OUt/jsFNPYqOsukdVvQi4sgmDzx4IT0BBdu/gWqhM7EGJCXYrwQU2ilHepDOcqv5hmmdBoZ0ADvdjn0fEbwIcuR+Xklg7nuim+9ZmVsv2PX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048088; c=relaxed/simple;
	bh=mmZi7mEg8NZKL5K4gMJOZWiDtdmhMy0TjtJRhobu/gw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OKT+aUwI8f1Dk59KPxtvwTmpg7P5gDG5eTcebnVWrZC1d38AII3QsI15pDGh2y+FCCb7KI0DzMg1JCH3n3/69veJ6urDgMTSJi1oNe49AykuZJnIoQE9s4h0i8KUFp1WddUEUX4jWVgPtxhTAR+OLDf7g4dS5NZU+/TvfOsk8rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YGE6kTHH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mS0NZfoS; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758048085; x=1789584085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=mmZi7mEg8NZKL5K4gMJOZWiDtdmhMy0TjtJRhobu/gw=;
  b=YGE6kTHHtUOF4UQyUm/cXSVGJGLzXPE4z1AHVD1C7JRcHr7wALtiECqF
   BAgJuUa0EFNMpAUvAaJIVN7ndWNzDQCpaRkJ/5rE2uSmvF35Kn06H8aEV
   R3gYDvTZ2Mxmm5gxlDDFdZVn/NOtCE2FkP/oeL/bf6kBsBZefkSgJIm6o
   AsM/IwdPBtW4uQvMVJJXf/W/p3UZdGnm0eAh1uksqGQFIs9tuhEK/5DGq
   OXyvoopTeWB52AHMbqsQd7iVxoOTUuShFMoyr0nETN4OgX3oERCARxZmC
   9FW/Hc7CeIslvMBiYvkygJHMqhcVEvpTHgb0e+0Q+Tmd6EwWNIi1kjpOK
   Q==;
X-CSE-ConnectionGUID: NeeWWvz+SCmLXHmQDbXoIQ==
X-CSE-MsgGUID: aF6Q8HDuS5iIU4v97IjHUQ==
X-IronPort-AV: E=Sophos;i="6.18,269,1751212800"; 
   d="scan'208,223";a="123487291"
Received: from mail-northcentralusazon11012004.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.4])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 02:41:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtslT7lr1AGcZXXEpu09SHMZcwKFBHMQ8Zbb7SZIwJy7tA4reD1HkVj8nafQea6HBJzLT3FQyW19RD/afas2qDkVARQ3Q5yApQq/ICw2bNumK6XKjy1ZZFkogz25x+dt4Zg6GiYV7vvvyXFeo6TIINQOZFf27Zm5tcDbW8w+cMFh79AjszJLHx5el9wAgs5ZQQPeZZ4ayoCKsW2xSKNu/X+XdD3cKLOtjdDSr68C0No7aQ5Vjs0gUxrseHm4jVGlLm+Da6TZ3PLHwxajTlYNuE7oRjHgPpzNXgUVkonoZ0VCqpBdbHBnAdfcAv3NPNGdgK11EhloB4nBw+UwneEdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krR2LGZtQbaitl9MiYGYEDY0NgINFhqmW9zT2pKYC+I=;
 b=cWQVwa/1BsE8hl4puE+a85yCzsZ6/1YyV/rFQGvRkIWsh1b+ffGnlWn7Jj/PwLu2PBNx89YYb+WptdXugT+hniNfVtN7nhy2KX6sM4CWwVfP6LgbaTNbVOxlO8BN6Po3uUt3/mLlA+CKBWyHKamVDSjKs6KsD8vfHR6A5tfh00ffrXI0TKAyqHlFrTwxWovdGZ9OwiFVVAM5z7bfE66Tx4FsJXM+VxYAoG7bXH2dTn41ToG0FYAc3lrfQYNBkAwXaopLHWyq3SamiYnRV2SCjCDu5ombD+G+vzkRT57hsIONvtUeiU9XFguJEO6EZpMB/PcfNaplkL+Tg8wxBPhRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krR2LGZtQbaitl9MiYGYEDY0NgINFhqmW9zT2pKYC+I=;
 b=mS0NZfoShQJqNKA1camaWj4sd7QAZRMxkVil3hKqUKy989B2UvYZVnStK57bXJMCWMa5uvE9kDrKp+afVYVF1Jd+re19YqahBcWDfzqY/rcaXtENKe9UDj9MtqL9ijopqJBoAcT55OF6j3jhEclzovAVTtYt3XPzYqVhuCrMWPM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6283.namprd04.prod.outlook.com (2603:10b6:5:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 18:41:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 18:41:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Yuwei Han <hrx@bupt.moe>
CC: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs
	<linux-btrfs@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro
 Aota <Naohiro.Aota@wdc.com>
Subject: Re: performance issue when using zoned.
Thread-Topic: performance issue when using zoned.
Thread-Index:
 AQHcJWG554cLgRNI6kq+V/MRpm0fY7SSfW+AgAGm74CAAA0WgIAB6tOAgAAB6ACAAAoMAA==
Date: Tue, 16 Sep 2025 18:41:23 +0000
Message-ID: <43f21464-c084-42e0-bb5a-0572e3385b02@wdc.com>
References: <tencent_694B88D85481319043E0CE14@qq.com>
 <873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
 <BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
 <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
 <2F48A90AF7DDF380+1790bcfd-cb6f-456b-870d-7982f21b5eae@bupt.moe>
 <1c5e2ef7-f2e5-401d-8acd-0605b117dfcb@wdc.com>
In-Reply-To: <1c5e2ef7-f2e5-401d-8acd-0605b117dfcb@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6283:EE_
x-ms-office365-filtering-correlation-id: 3a62567e-cccf-4c8a-ab5e-08ddf550a2ac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTRDbGVTNTNhaDd1OTFmMWtjNjFScDZ5b3hyeHNtVU94ZTJTSjBVQ29qYUo2?=
 =?utf-8?B?bEY4VmEyTVFaV0hQOGEyb2tXdmd0K1dwVHJ2MklVWE9uM01uWW9XRXhYV2xu?=
 =?utf-8?B?aUdTVzBOenZhb2NlWmdZWVhsakJqRG1sZHN4WEM0WmRPVUlQa2JaL0lDLzg4?=
 =?utf-8?B?Z3hIa2dUb0NmU2dzMjFXajRBSUJrckVZRE9uQ2d3ckZxaDM3Y0pFRXZNd2hL?=
 =?utf-8?B?TTdVSjdDS1hqdHlJT21USGVrQ3B6U3NGbzlMMmVmYnBDaEUwUkdYQ1Z1M3dw?=
 =?utf-8?B?TkNYMmM2LzVEajJBMFNXakUvOTdXdExPdDBqOGpqNjFrMFhKWGQ1bFEvRzlJ?=
 =?utf-8?B?cy9mbC92VE5qS3luaGNLbmxlSjFoelRJbWJJcThTL3dsemJXNDhrZGJ6a3Bo?=
 =?utf-8?B?WkZxaUhVc3h0aU85TWpISGtkdURjS1pxT3Q2ZXUxc1ZBaGpKTVhHbm81MHVD?=
 =?utf-8?B?cUluaFR5MkY2Z2hiZXFCa2tlV3I5dlNzeDl1RkZnTEN6UHNLZlhzUGpKYTg2?=
 =?utf-8?B?WEVacDllbW5lME9XUTl3WWdlendOcVhSeHNiQ09oNG5peUtucUVVbGJBQnJE?=
 =?utf-8?B?azhvRnNjejlSOEVCMzdwMUpQLzQ1OG9TN0dvRnRPSkluYTJZOFhteHhnM0ho?=
 =?utf-8?B?NVIzZDQ4TWphK2FxQlFYcVF2Nk5VU0p4TFd6YlRsLzBtVW9jdWpUdW1PK0w0?=
 =?utf-8?B?cktWM2pLZFM2M3hIZE5WcXNWbmR6Y1NnelAwVVV5VDdJbXpBMzREY1RqRGRv?=
 =?utf-8?B?bEkvWkRMdHZMM3ZBNmZwYlJBS0hmeFNxOVh2Q2lBUC9Bc0JkTUkyTlVQSE5X?=
 =?utf-8?B?SjAyTHkyUVVQczFkaGlFTW16VXk0U2owNkJKeHZQd3RsaithTGRGeTkyKzJ3?=
 =?utf-8?B?WEl5TEkxb2FIM0dPeWFoak41QTgybG5LeWxIakpKd0RXeW1USW9yUmRmNEIy?=
 =?utf-8?B?QjZ5cFI1RTMrVlV5OTJhb3ZiNTdOZXBRUE92U3VGUklYcFh0aDZVVkM4R25x?=
 =?utf-8?B?cXpCL0V5OHNLcW5XbjNZRmU2d0ZOL3d0SFRnNzlmcmpLcFlHVTRIR2YvRFVj?=
 =?utf-8?B?SEFUOXFqYnUwRFhweEhZc2g0cFFDVmlWeEJHaXEyY2FmWWhtYlcyeDFhckpE?=
 =?utf-8?B?N2lyNE56aGdJd1VNb0cvdzdkRHRSL2w0bGhEMUJRdXF3ZkFnelNqS1UrYVYr?=
 =?utf-8?B?WEtac2dFbmdWVW15Wlc3SWROTFFYNk1pTDlHdDE5aE1DQm96eS9jK01obEM2?=
 =?utf-8?B?RElIVkpoeVkxRUYySStQaE1yaTRkcFVxWDl5SUFRaDFxTTAxdG1ZT3U5V0Fi?=
 =?utf-8?B?WU5TakVpV0IrS28vckRIc2lWVTNQMkZpWjNHUnE4ZWdiaEl0bXFISnBPQzVE?=
 =?utf-8?B?dHJvTDZ1ZjVXbzZkU0dmWHhPb1I3eE44dzlXNnVDVDd2Y3Nqa1FuMFZFc056?=
 =?utf-8?B?SXdIcFIzelpOaDg0QWRMV3EvM2t2TmtvSW5xL09KeDUzczUwcHd3djBydFI5?=
 =?utf-8?B?YWdtbTB2bWdrYi8zak9UZWZIMlhLRjJVb21JWmVwSEFJSzd1ZFNVZXY3aWdu?=
 =?utf-8?B?MEtGeXY4S3FvVHdjVmUrYUcrSCsvKysxWi9xdkdHMVZuN2RpZW1zVkkyTnYx?=
 =?utf-8?B?MkRBQW8zVHBYc0orTVZEY3RCREJkaFBHd3J0S043NDFacDdra2oyYjVwNHA5?=
 =?utf-8?B?WXRTUlZZSDRaWkk4bFBTY2YweDBrNkxQeHVVSHlLNmp5K0tBckk3T1FvbDlu?=
 =?utf-8?B?RDFPbWsvZlFFTjlyZmZwclFHMzBadW4rUWFJcWF6WXhOanluY0piakpsOHdz?=
 =?utf-8?B?aFlqTS9HVWhOaUFUT2FVR2ZyYzNDTEpFUC9DbWM2V25uS0Y4aUp4NStDMjR6?=
 =?utf-8?B?TzFQbi93RXg4WnhBR0dWS2hiWk1vSytqMU9tKzExWmlJZHI5UHdrYmQxMkRh?=
 =?utf-8?B?VkNZbUNsd0dIN3YxS0VoekJhUWRaa3ExdXlsL1ZGQURLYnFJcUVBYzVPMThV?=
 =?utf-8?Q?L6aP9x5zM0bUaCuwrUGrBM4qjERcYo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VE1heERwcU10UGhUZHZBTXczZDNEeHdWRHo3cEh1ZWtqREpRTTZuS25sRnFl?=
 =?utf-8?B?WnJKbzRsb05nZ2t3TEVmQXcvc05ValdiV1BXMmVQOWd5a2JVeWZPZG9pcGVJ?=
 =?utf-8?B?SlBoQ0tSdnZ6NjN6YVN5bkJhN2RVZDFSMVliSDRMcWJGWm9FMm9EMW1mQm8v?=
 =?utf-8?B?d2t4MWM2MldxcjFJa24zT0ZnV3k4SnAyNmxJUzRFZ3hOR0NSdldOdEFQOEZr?=
 =?utf-8?B?L2xHZW1laG5qWXc5L3pFZkw0aWZtOE9ybThKMHlJeTNQU0pMRGhxa1FnSGg1?=
 =?utf-8?B?Q3dUbTBnZFo1eEFsRGJWY0M5RmFma1ZBd3o4RzJzMjZnOEtwQnBIeTlpU2gx?=
 =?utf-8?B?RXRzSHpqem5JNVBjN3BIMTBpL0g5aFdNYllyMGlwOGVEUmxrZjd6RHRPWDZE?=
 =?utf-8?B?WWVGWGNnRkF0dGV4VFBsd1F2Ykljd2xSb0grV0g4SjFSNXJEVnJ2TVQyRmpO?=
 =?utf-8?B?YlhJZ2htMm5nWFN5SVhIQU1HbUJrQnlNbG9aQTBRVUEvRldhVzV5MGcvMEU1?=
 =?utf-8?B?N2x2M2NqamdyOGlUTHNubmxRN3RDd29UZVFpMVFUSXJ6RHM1UExtaThXYzAz?=
 =?utf-8?B?L1N3MGhLbEdjdlBLSzdkU09KTzR5c29tZ0o2THV2OWZrcFkvSDQ3Z3NCWjJV?=
 =?utf-8?B?YkcxcEVtZExjblRZbUtVSzdEZTJzNWZBMHAyUnArWUYvamhYQWdRckRlQjFO?=
 =?utf-8?B?YjQwcHc5Y0QrVUIwNmFQZjgxRk5hNzZETWUyWjRHV2J0dkQxYXVzaExrbVBV?=
 =?utf-8?B?SjZXd1hBbTRxK2ZvRldjQmlNVytoNzdtYm9QUkYvenhUdExtVjZnbzFNOXM5?=
 =?utf-8?B?THVYN2Z5WXJzS1V5cGI0Tys2SlB4amtGS3VoTzN3b1hnbTd3aGVYaXhIZDUx?=
 =?utf-8?B?WmNvT3Y2dmRCajY2NXFncDZ4ZkkwSnBOU2JDVkZVMWJoQ25HcStUdGdQZVlL?=
 =?utf-8?B?b0R5ZkpPWktYeTBDdDA3SDNDdHFxK29ocURQVlo0VDYyTDUrcUhRWC9TMVl3?=
 =?utf-8?B?NG1yL3dxRWM0b3RpNE9TY3dLNm0xZXdjaW8yVnlRQ012RVEvalkyQUhPdkNG?=
 =?utf-8?B?c01wMXpXUzAyZ2RxWEFIWHU5Qlh6RVdMdmtXcFE4MDFob3VZb0NpNExXcDZV?=
 =?utf-8?B?Lzd5ZVZtakFsLzlMNXNiM0g1L21KcXhGUUovTjFPeEs1NzVaZGJEYUE4eE1w?=
 =?utf-8?B?cGZ1YjVGTis5QU9WM0NJTVZ6WFVKaVRoK2VBVjMxem1HS2ZHMDNIaVg1SFlP?=
 =?utf-8?B?WW02NjVQby9tVCt1eGQ0Sng0WWFmWGJmQklFMVorSWt1T0pqalpZQU9XVit5?=
 =?utf-8?B?eDBuZGtsT3Jnd3doZUFuZ1JFdGJwSm5FUU1TTWFCNjFldHdKSHMzTmRhS2Nn?=
 =?utf-8?B?WWp5UmZsdGtGNHg0SFhBdldZWDk2dEQvNkRDUXpZdUhpcU1HN2hPUU1QL2tS?=
 =?utf-8?B?dWJ6Q3VqNnpYZTBFNk5rcE1EMktHOGJONFUvU1M1Y2RlczQyQlJNY2s3eEhI?=
 =?utf-8?B?ZGRoMHNRc3JTZ2FrUWF1SHZ1QjVpdlhsM3o2MmRmTExUaTlZZklpR1V6MG91?=
 =?utf-8?B?bC9HUUhYd2hBeFo3ZXhnRlhkeFUrU1pyZERLYnM5dERTWENXaTRWNlh6T1hJ?=
 =?utf-8?B?b1VaSEhlQlVxRmt4ZlZETEgwMjZHOS9EdVlmQ2EyOFV3Um01YTlsczFLMXB4?=
 =?utf-8?B?ZXQweGl3S01GQTNmMzB1V3o2dnh5K0g2V281em1VUzkxSmFHNysyMDdvUDFY?=
 =?utf-8?B?WXgzMUlhb1FVbktOQ1FvTDNkd0hFaGRFK3p4RENVYncwVVBEMUFjYWxhSHpw?=
 =?utf-8?B?OVZWN3RybVptS1lNbERWNnZQVGhkZlJhT0Q0NitXTVo0SDhtRzRUVzQ1WVc2?=
 =?utf-8?B?YWx2d2EyYmNIRjJxSEE3RCtBUnYzbVBJVHhtQTl5bkh3WG9CcDJlMjNmSnF4?=
 =?utf-8?B?b29XYXk2K3ZwSDBLQ2tJcWhkZDlZRENrQ3R6Q01YNklKQkxzUHRUY0luWThV?=
 =?utf-8?B?dzRLbDA4eHpINkl5bmxlL2U0bUpoUmJLSkxxa2kzaFNXWGZvYVgvOHRvdk5M?=
 =?utf-8?B?eFQwU045QndCNEU2SzRiRHE0WG84QnpESGcvOWVCRTAzL2MvTmN3cVY0TXZq?=
 =?utf-8?B?TExKbkdsQm04Vi96Y3BYRTIzMnV2RGhJT1dORTd5dDBuWEpSU3hveStkUEJv?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: multipart/mixed;
	boundary="_002_43f21464c08442e0bb5a0572e3385b02wdccom_"
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v4hxxzbjDXzCRLoELF9Hd7pdy86Q6aTSDFYv686Wyjqe8FVNelcm8OdiG3OfycO2c4lSGOBR45OcyVI613yv1rXUuDIzzTmB4xV4ZQX1/z834CRIElH7NC3Epep/Lq3NW689/xuY5R8EKpIO0e/vAg0DCcvbD0k70WlLTMH1PBrc80iaSj+Q9wolkW4fImSjMaOdcHahYFLVL57QJvfiJEwB02e13ZshGexvbkMkX+8ALcogWMo0Uj36BoxSEyA7j/3SUdUalwHAHQHKrovkjJyVEhvKWRyfeASvGmmwRYFPlWN6FHHyDDGJlHNOkrqWiOUiqTQ8gRH2RCJ1aQKj1Jj58IEt/D/x0P1wz6lKhPxiyEDEajkiaPBBU3oINPhhTgiXRrV+erFBgzutIULOVeZB4POKQ31D9aMRr5OVbBhlO2eikN3foO/v70QAJfv5F3NvfSDk8WUg+Wr/HzjYf6TMyrYOhVVUrGlNGYwdx/AGRH3de0217BPyyfOQoevPoZTpCU1Q/KfEv6jFxL3w+f2m+jfPVdSIGkSGYe4t0ysaWFlC6htQpLpgOW92a0nxrFpym/tZ9cM9XFar+36sTSNwd8vgdXsxysLCQ3Zf/ukJuNXO29UbQvpqZ5FleTAx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a62567e-cccf-4c8a-ab5e-08ddf550a2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 18:41:23.1698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmDHCHk/P7Zsw87yDbdlx3oZsyfAVYXyDEk/ZfnrbcnapaRkLSZCPoZEcFBxnrGt2WXvSrlJU2mKzHNJvI5DsqY/l3ZXgCFxP8cNKdAvO0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6283

--_002_43f21464c08442e0bb5a0572e3385b02wdccom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <684DF5D867DCB04F850D58B144DF4841@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gOS8xNi8yNSA4OjA1IFBNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+IE9uIDkvMTYv
MjUgNzo1OSBQTSwgWXV3ZWkgSGFuIHdyb3RlOg0KPj4+IFRoaXMgaW4gb3VyIHRlc3RpbmcgaGFz
IGJvb3N0ZWQgcGVyZm9ybWFuY2UgcXVpdGUgYSBiaXQuDQo+PiBzYWRseSB0aGlzIGxpbWl0IGNh
dXNlZCBrZXJuZWwgdG8gcmVqZWN0IG15IG1vdW50LiBBbnkgZml4IGF2YWlsYWJsZT8NCj4+IFvC
oMKgIDE4LjE4NTA2MV0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGQpOiB6b25lZDogMzE0MTkgYWN0
aXZlIHpvbmVzIG9uDQo+PiAvZGV2L3NkZCBleGNlZWRzIG1heF9hY3RpdmVfem9uZXMgMTI4DQo+
PiBbwqDCoCAxOC4xODU4NDhdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RkKTogem9uZWQ6IGZhaWxl
ZCB0byByZWFkIGRldmljZQ0KPj4gem9uZSBpbmZvOiAtNQ0KPj4gW8KgwqAgMTguMjE3NDA1XSBC
VFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IG9wZW5fY3RyZWUgZmFpbGVkOiAtNQ0KPj4gW8KgwqAg
MTguNDQ5MzYyXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYyk6IHpvbmVkOiAzOTAyMCBhY3RpdmUg
em9uZXMgb24NCj4+IC9kZXYvc2RjIGV4Y2VlZHMgbWF4X2FjdGl2ZV96b25lcyAxMjgNCj4+IFvC
oMKgIDE4LjQ1MDA4M10gQlRSRlMgZXJyb3IgKGRldmljZSBzZGMpOiB6b25lZDogZmFpbGVkIHRv
IHJlYWQgZGV2aWNlDQo+PiB6b25lIGluZm86IC01DQo+PiBbwqDCoCAxOC40NjY0MDVdIEJUUkZT
IGVycm9yIChkZXZpY2Ugc2RjKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+IE5vLCBJJ20gd29y
a2luZyBvbiBpdCENCj4NCkNhbiB5b3UgdHJ5IGF0dGFjaGVkICh1bnRlc3RlZCkgcGF0Y2g/

--_002_43f21464c08442e0bb5a0572e3385b02wdccom_
Content-Type: text/x-patch;
	name="0001-btrfs-zoned-don-t-fail-mount-needlessly-due-to-too-m.patch"
Content-Description:
 0001-btrfs-zoned-don-t-fail-mount-needlessly-due-to-too-m.patch
Content-Disposition: attachment;
	filename="0001-btrfs-zoned-don-t-fail-mount-needlessly-due-to-too-m.patch";
	size=1413; creation-date="Tue, 16 Sep 2025 18:41:23 GMT";
	modification-date="Tue, 16 Sep 2025 18:41:23 GMT"
Content-ID: <B33A235B54613B478233FCF32C2A1796@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAxYjhmMTlkOGU1ZTUzZTU1ZDFjMWJiMWVjN2Y2ZjAxMWVkNmY3NjY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPgpEYXRlOiBUdWUsIDE2IFNlcCAyMDI1IDIwOjMxOjMzICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gYnRyZnM6IHpvbmVkOiBkb24ndCBmYWlsIG1vdW50IG5lZWRsZXNzbHkgZHVlIHRv
IHRvbyBtYW55CiBhY3RpdmUgem9uZXMKCklmIGEgem9uZWQgYmxvY2sgZGV2aWNlIGRvZXMgbm90
IHJlcG9ydCBhbnkgbnVtYmVyIG9mIG1heCBhY3RpdmUgem9uZXMgbm9yCm1heCBvcGVuIHpvbmVz
IHpvbmVkIGJ0cmZzIGxpbWl0cyB0aGUgbnVtYmVyIG9mIG1heCBhY3RpdmUgem9uZXMgdG8gMTI4
IGluCm9yZGVyIHRvIG5vdCBvdmVybG9hZCB0aGUgZGV2aWNlIHdpdGggSU9zLgoKQnV0IHRoaXMg
cmVzdWx0cyBpbiBtb3VudCBlcnJvcnMgb24gYSBkZXZpY2Ugd2l0aCBtb3JlIHRoYW4gMTI4IHpv
bmVzIGluIGEKc3RhdGUgdGhhdCBhY3RpdmUgem9uZSB0cmFja2luZyByZWNvZ25pemVzIGFzIGFj
dGl2ZS4KCk9uIGEgZGV2aWNlIHRoYXQgZG9lcyBub3QgcmVwb3J0IGFueSBsaW1pdGF0aW9ucywg
cHJvY2VlZCBtb3VudGluZwpyZWdhcmRsZXNzIG9mIHRoZSBudW1iZXIgb2YgYWN0aXZlIHpvbmVz
LgoKU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5A
d2RjLmNvbT4KLS0tCiBmcy9idHJmcy96b25lZC5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvem9u
ZWQuYyBiL2ZzL2J0cmZzL3pvbmVkLmMKaW5kZXggYmE0NDRlNDEyNjEzLi4wMzU1MmYyZWRiNzQg
MTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL3pvbmVkLmMKKysrIGIvZnMvYnRyZnMvem9uZWQuYwpAQCAt
NTEzLDcgKzUxMyw5IEBAIGludCBidHJmc19nZXRfZGV2X3pvbmVfaW5mbyhzdHJ1Y3QgYnRyZnNf
ZGV2aWNlICpkZXZpY2UsIGJvb2wgcG9wdWxhdGVfY2FjaGUpCiAJfQogCiAJaWYgKG1heF9hY3Rp
dmVfem9uZXMpIHsKLQkJaWYgKG5hY3RpdmUgPiBtYXhfYWN0aXZlX3pvbmVzKSB7CisJCWlmIChu
YWN0aXZlID4gbWF4X2FjdGl2ZV96b25lcyAmJgorCQkgICAgbWluX25vdF96ZXJvKGJkZXZfbWF4
X2FjdGl2ZV96b25lcyhiZGV2KSwKKwkJCQkgYmRldl9tYXhfb3Blbl96b25lcyhiZGV2KSkgIT0g
MCkgewogCQkJYnRyZnNfZXJyKGRldmljZS0+ZnNfaW5mbywKIAkJCSJ6b25lZDogJXUgYWN0aXZl
IHpvbmVzIG9uICVzIGV4Y2VlZHMgbWF4X2FjdGl2ZV96b25lcyAldSIsCiAJCQkJCSBuYWN0aXZl
LCByY3VfZGVyZWZlcmVuY2UoZGV2aWNlLT5uYW1lKSwKLS0gCjIuNTEuMAoK

--_002_43f21464c08442e0bb5a0572e3385b02wdccom_--


Return-Path: <linux-btrfs+bounces-11689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26F2A3F310
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 12:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86147A3FD2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA14209678;
	Fri, 21 Feb 2025 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ifN1Q2pj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eVtJI5L3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA320897B
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137850; cv=fail; b=csgtIsjnd4jNpgTIHfr8S+xNO/fQ+6lLcns50Hf+gF7ytIARtcZihCWYfhbseMnPSG8UPwcHZ8Y1Br+VTQD7BYipzxsQoCoEladrrjIXlPc4RM7jLLTtZ2ziPBwF/ey76dz44zQcj4EK32YsMwUOtSXVnSYhHgFLBfmYFvA79xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137850; c=relaxed/simple;
	bh=2C4O+sftVxJIOBWXSYncHDlJp5P+xrc2i++pve+yXAY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ERl2Y7sZEusXcdY1KknVih0Q9B6STir0ElxChVON5FDESXFWKk9MtUA6cmeIIXrQhB2eCw/xJVzc3B2aVAwjXB/Y7hXl/JY9mbWBAV1Rql6hjaaLxunsvIB4npJBNfROC9haFl4HY6BIyJ9wV6EEhjLz/ECY4rwYiQfXLnR4Plk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ifN1Q2pj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eVtJI5L3; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740137849; x=1771673849;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=2C4O+sftVxJIOBWXSYncHDlJp5P+xrc2i++pve+yXAY=;
  b=ifN1Q2pjlzmfuj8Frckw5R7C20JpA/uOI7QWT/Gv8fQX6vWuUDiwdAuO
   wKNt6W1oSvH9zKnYkDHUAZ/JheW+QFWxrWv92MLR593CmqERK3fClOlES
   yE8anFjh8zgDTyLseQmmMCHSmh1FzZsGcak2rgl54DpZdR626+JwIasr5
   LA6syG1P87c2hb9fMYdZ7Zp9fW+o5L6etwMu0vAdmXlvuq5GOwotFY0OZ
   3d8/AuVf0OKO177nVWLVbjRnbdOi2fSdAtW4zMZg8+3vLm8F7OEJsUA/l
   /Cn5ey+LLwv2sxtMzGCKFCxp22grGskVtp8zyrLVCc7bQGkc0kAmeAKn2
   Q==;
X-CSE-ConnectionGUID: QA/JF316QxO1Z1w55VB9qA==
X-CSE-MsgGUID: tkYnP8F7SKK/eHTJ+ww6LQ==
X-IronPort-AV: E=Sophos;i="6.13,304,1732550400"; 
   d="scan'208";a="39082153"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2025 19:37:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5Zo/5tzsaGC9GXYlK5zWWUKCuUBrIR2Ynwf+9IypalcgDJlX2Uy2BudpGmv2VbIctVN3ALII/VIlC8Y/uQ42XSEetL6LHbkboGDaACIM1vUGil9xxB2JDyMyb1NeXy175o7AFRqjtxqfnJ1o3Xc1r31T7thSVOtOJmYRhMrPxunZ5OOqXrCS7EeIU0FG+RyIMaRpiP6OmGeDq/NomQyy1OtaBY8EYOuwtAU8uq5ideI9IELlXbYPLFgAqYdRnb6PolyWpAu+EZM7+8IAB9RSwiUgDAcGhKoGIJouSv4y1zvuI8MY/F+QIdxC2QCKn0wsb3fMYJwBCGgJg2LdVW7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C4O+sftVxJIOBWXSYncHDlJp5P+xrc2i++pve+yXAY=;
 b=D00c73riXgmgHoGTWj22RqAOXFA7/Jew7Bg3OitbLnlQaNpRvean3+8S7qKv37btpYdUyA4hSSm9hDx5LLS4bfcaDM0nEGlllDMZU9jCyibtYCgwxO9hyJvhzhAmixq30836v66k0MZKgr/UOfDQY5YO/0PLXR+wgnAM4AoUzQJaJSEWbHKTQhPM2sRPCPEmWqJTt4soEoeH9WlOCmtsPGHpyTsQ6PyXpE47GJ4e2FNH1a42K42mFkRtECGGaMhtXqJctAIwsbTQSQysJcHdGhMh2syR7wogOq+M43awxCm5dqg/KTsIoPI/oCzvUlsjo8nSHYSYTy/6wTOEWSiiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C4O+sftVxJIOBWXSYncHDlJp5P+xrc2i++pve+yXAY=;
 b=eVtJI5L3RgeUnQVf/nI5KDl8fOMFm6MQ2TdFwLMn5jsPL1oaUCafUDGUo40mxN0ksTnZQykfphahZaLVNAgSWbA2IOtlwjgidjEYyV5SfkE1/t1QiV1t4sw5JRP7Fs3/e00mjllkFlhilnM9wEsN7OQiSR3WRuMVwujRktt1IRg=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CH4PR04MB9261.namprd04.prod.outlook.com (2603:10b6:610:232::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 11:37:20 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 11:37:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] btrfs: remove the PAGE_SIZE usage inside inline
 extent reads
Thread-Topic: [PATCH 2/5] btrfs: remove the PAGE_SIZE usage inside inline
 extent reads
Thread-Index: AQHbg3lY8ZUTVpXPm0eS5/FfTHe7XrNRovqA
Date: Fri, 21 Feb 2025 11:37:19 +0000
Message-ID: <66539ad5-c5af-459b-834c-ff0d80a463ee@wdc.com>
References: <cover.1740043233.git.wqu@suse.com>
 <2e9629067938c31bb59c34655456909c4d00e183.1740043233.git.wqu@suse.com>
In-Reply-To:
 <2e9629067938c31bb59c34655456909c4d00e183.1740043233.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CH4PR04MB9261:EE_
x-ms-office365-filtering-correlation-id: 01a80bda-5c8d-43f1-a017-08dd526c19cb
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0t5Q1Vsb0Y3VDZNaFJsdlM4ZjA2L2xvZlZIRWF4QUcvcmxzU2dWNVcwc0FI?=
 =?utf-8?B?YWRURWFZa2tiQ2pMeG9XVVM0L2VNNHBvY05hejFZQWdxTG1ZTUdvc2hBWW9U?=
 =?utf-8?B?NjVzMDhHR1VueXo3RVJ6VGpWSnhiQk5zYUxSREFZZEpFYkZobTBuQW9uMHo3?=
 =?utf-8?B?VnA0R0szUFdnOXBkaXY2Ulh1elNnbk82L2lRTERuelF3MU4xWXJIY1U5U2Vk?=
 =?utf-8?B?c0tMRTBGMmkrbVdJYUlGSVptelMwbWxSWnl5TUtUSVRoWlRWOHVzbE9YU2NP?=
 =?utf-8?B?dTgwdXhqTS9KUWd0NWFydmhyUzdFVjFqcEZuL0FZZEdZaDJOSUhRWVN1b0Rx?=
 =?utf-8?B?Z3NHK0xKcmQ4Q3FSNURZMEZXQ0RYbURqc1pCdWNKanNKZ0dRekZhcjhKeW1Z?=
 =?utf-8?B?bmJHdEpWOWpUR0JkRGxrUXFkNzdxN0FZcFh5U2RMZEVoMU5pQnJZOXFhb0Vz?=
 =?utf-8?B?N245b2hXN1FLWHprTUtHRWhMc0YzT21hQVhacUF6VDBMZXhwTWhkZEI1RExD?=
 =?utf-8?B?cjZLWmdvS2E2QjdGVXF3ZXM4cXVMSUVhTzA4YjBidHd5V213czNvbTlIdVI5?=
 =?utf-8?B?NktUcWdtd3ZOU1NPeitBYndQZUZkUkpuTEhIMUJ3d0x0Smp1WHhScVhYUzRy?=
 =?utf-8?B?YnlZcEZyTi9oSkx5TXZQM3JXbTliMnc0TG0vai9DTHA5dGYrUnYvUFNHcTJP?=
 =?utf-8?B?R1g0YXA1all5VW1SRHNIVzBkcUxra1hKbjV4bVFtTm1HY2NEZ0ZYTW1YOHBR?=
 =?utf-8?B?Z1ZNaVJrd2orcGJvZUEyaGFNOTE3RVZwT3psc1B1dkZseFJaK3NYRUhVaFUw?=
 =?utf-8?B?MEkwai9HalU3S3lESDFpdUFEN0RRV2ZqODdZZnVyUkpLK1Iyc1Y4RlI1andM?=
 =?utf-8?B?N05HUzJCMVBRdm4vN2owblcreEZMU2RqdGZzbDdRWXVWSWU1SjNUN01VaVo2?=
 =?utf-8?B?VzlUalBDelV4U1FDQzJXT29jOCtZcmpQZnBUMnhoTCt4UTN3TDBrb3Z5amdC?=
 =?utf-8?B?VEpxQ1pMYzRLeXVBblZRVGJrTm0yblF2NHRMWXhLTGtNbUVsU2lGbEh3bXpo?=
 =?utf-8?B?RzdOMmdTN0NlemRrS0sxUVhBMzlvRWtwQTJEd3BVTVJwV3Bkd3A2d09xM1FV?=
 =?utf-8?B?aWc2bFVqcVJuT0J0TTgxU0VCSDhIZXl1TzQ0UkhZZGZZL091d0NtbTBrTlho?=
 =?utf-8?B?bU50anlyODQ5ZFo0NXlKZFFIWXlxQXJFV3lidk5yM3FkT1JqU2IrTm4vQ3ZO?=
 =?utf-8?B?Mlg1S3ZpQjBCN1lRTDBjdnY2M3JMZGJsQWUwUERYTU02aXpkYyt1aFIvVEpw?=
 =?utf-8?B?bGhLSnR3SHhXeEIvSDM0Nm5QK0YyMUtydjZ5UXU5a3Q1VEZSQmFGcGlJOEZh?=
 =?utf-8?B?T3FaQU5YS052VmVVWXNsdXlUamVtRnB2cFlwTkcvT1dXZ1pha3QvZVkrblNm?=
 =?utf-8?B?aWh1d2w5bzgyWnllMnExSEpZVFp5di9JNFRGckhuTjlBZFUvYWU3clhBcktO?=
 =?utf-8?B?dVhVUUU2MTBsTjIzQi9ZQ0dteWtQVzMyNmt5NjZzbjVSRGl5M2xGYmpFVkx2?=
 =?utf-8?B?dVJMSjVES3RjaG4xSjFFYkM3RXA3ZjRBZ1U3dVdhdnBQUkVEWi9NTnpWcGdm?=
 =?utf-8?B?V0o3ZE9rQ3lnU2RMNkwxRjgrVmsxMGRTcFVEbCtkdUtOR2hvMTUrUm1WeUo4?=
 =?utf-8?B?T0lDdHhpVW1uMXg0cW9TVEZNRThOMVFQK2xudS9BYkhYRU1DcnQzUHVla3NX?=
 =?utf-8?B?V201VlluVmIrTWxQUjJTL080MzhIOHBLdWN1L2I1L09UUklmSXNjaHJLY0hh?=
 =?utf-8?B?N094dlhjcVUyWEFyeGYrWGQwckRjZGI5ZndxdTE1SlJFaVlKYTdQYVd3SE1a?=
 =?utf-8?B?bWNkTlpRWFdSeG1NODV1d1RxdGtNV1ByOWZjQlVkcmhYaW12eFRMTXprMkgw?=
 =?utf-8?Q?iNAwmtDuioxkGjuK7YxDMdXuWXK746ND?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZllDbzRjN0M0NDJyTEE5Ym5XZjk5dmxJNzhrOW15ZDMwRkloa0UreW1DOGZv?=
 =?utf-8?B?NnJLNUVUT01naWttL0U2Qk9VclBibTFMbVpsTDZWMTVIeXA1WEpXdFMxUlh1?=
 =?utf-8?B?VjZIMitDNVhmd3ZKTVRKN2RqUzJHclA2L1Y0Ym5OK1duaU9aNzg3cklKS1JY?=
 =?utf-8?B?azlDeEZwenFqZTVtcjJxdDR4SjhQRHczSWlzUVRMd1BCSHM2QlMvV290c2tP?=
 =?utf-8?B?RXliREFDVUhqNXF0NFFONkV3Sm5yOHdDbnFkRlE2c0RUQmJDZ2dGNVlOYmZw?=
 =?utf-8?B?UUZDNXA2czNHUEY0WnNyZWt3VTZjbmpNQk90bFZKY3JCVFI0NWhWdzNlVGZO?=
 =?utf-8?B?SHVTckZWRkpxRmN6LzZ6dXNtNkdaL0FPK3pUS2g3cjZmN1NkYWtDemFXWHMv?=
 =?utf-8?B?UmREMG1MUGRqb2xrZC9aV3JRWjBaSTdEN1Q5RTF0SjhHb1JZOTlaN2llT29a?=
 =?utf-8?B?cHZ4S2ZZTWFNRTk0cC8wNzZGdFBSYVJpUUJkb3daMVZpQ0xXWlNDWE51QVRL?=
 =?utf-8?B?YXJKbHlyL29jb1RVYjM0VDVmTzZGS25SQzZYa3ZaL0gxcFplTlFCNlZrMWx5?=
 =?utf-8?B?VWk4T1NBOFlSayt6TXozeXMxZk5meHNRUjNXNVhQZ2FNR2R3WURua3lyTGts?=
 =?utf-8?B?aVd6WlhIdzZ4N09IcDBVUkdYWm9EdUhrZ3NxSXR3Z0tjaWNUZVgwWWF1blFO?=
 =?utf-8?B?ZnlTSzBNbnZOdVBpendoMVFRaHZPbVZhTHpXVzd3cXpSNktYNG5pcnFlY2gw?=
 =?utf-8?B?dmZlTzhpZFlzZzVBQXRreFhJaVFXYng5dXdXbHIyWW93NUZwQVZURXZBOUx2?=
 =?utf-8?B?R0ZDcHJMKzFJRTNCTWVVRUZtcGx1VTBKZWFpa1lzU2dwak1ocVJPOEtHenNF?=
 =?utf-8?B?ZWpCQ1ZDRFJzZUxOTGNyU2ViZ0Q3bExJNkgvWjRjcTRHS3o5eVliRVgzZDBr?=
 =?utf-8?B?R3dJL2pyR2cwcmhnRUNsbXVMYmQwVG9Xb3RiUkdBRDE1andmMkdpYzM3ZUF3?=
 =?utf-8?B?b0FBMHVLYzhVY2dyS0t1c2xWd05ZY29ldTM3N0UwL2VKdmNKVlA4Nm85UXRJ?=
 =?utf-8?B?T011cnFsbE9lUUpsVEtXOHhEcmV1c0FnRmM2eUJuS0YxQ1U3dzJjMFk0YmVG?=
 =?utf-8?B?d3F3b29ielFtNktKMzRUYUIrQXROd0RSZ3JYMk94YVl5UHBXTHVOdnY5TkNF?=
 =?utf-8?B?MnFTbk1GbjUzWUl1eXhaTDgrd1N0YXdpcmp1bjRzVEdKcVdWVlUxUmNJdDg1?=
 =?utf-8?B?SEx5UmdVcCtTQ2xuK2ZDeGhadDJlblN6Mm1UMlNZQVM3RnZUUWdKNGczd2t4?=
 =?utf-8?B?cVJOT2xyMDN5WHgwL2pRbzhRQjU4R3pKdjlTNjhha0dVTzJQNTJIM00yV3No?=
 =?utf-8?B?UEZLRGlDZXJDa1VVTXRTZlQyVndIRS81OVFZMmFDUHVZcnNEeTNISGtiVXQ4?=
 =?utf-8?B?YXBiOGdTT0ZNRGg5Y3pPTVUzZFpaMWMwd3dQNkF2cFBHUHZpOEdvL056VDcv?=
 =?utf-8?B?bHUxUy9FWXJpbnRuUW05NEhWa0RSckc2NkdiQi9BdDVCSkNrSk1LczdkTmo3?=
 =?utf-8?B?eXlQajlnSGQzTzVsVks1Q3JaY1dQeW1UOTMyREg4T3J4RjFzZzBFWTZjNS92?=
 =?utf-8?B?dlA2bVQ2cmZWTnhNaU9zK0V6dGl6VWxjNGVuZFhGSERmU3NncW1idXR0RFJF?=
 =?utf-8?B?NTgxYmNkaVRIOEU3NVNkU004T25odkNPRHFDQXJTeFFFMTBZamFoUjBlYW1x?=
 =?utf-8?B?THZuNlF2VHVYWEZtNDRRYkNKb2pTTW82dmVDOVh2OGRGaFBHckJNN01tdG1W?=
 =?utf-8?B?QkJjSHRVeTJJbTUyTWZXNFE4NlZGc3Q5RmVEVDhCWW5QbEp4VlNCZnJXY0pW?=
 =?utf-8?B?eFdZRmVEbVN1bzVIN2ZBOUpXNmIxR1pYaXVLYkIyUXR5dXMvRGs1Sm9wdzZY?=
 =?utf-8?B?RDVLSzEzY1FuNkpRNThac3EremhPendXbGhzVDIzcEVWdUNvTzc2MEJTY3l5?=
 =?utf-8?B?eDE2WmdqL1g2ei9qcURyTGNLMk1kK29uKzVyRkthTFRHWnMwd3draVZ4TkI2?=
 =?utf-8?B?WnVHdEJxZmhEeFhFNDFWQS9YMWljSWZQdW5URkxxUnNyelhYMUx6R29ZVytq?=
 =?utf-8?B?QXJWTmtFdWovbDV4WEtrVUorOWsxUTBEbTVIMVFRa0c5OWJ1TElIT1FLSGZL?=
 =?utf-8?B?elQ3eHlaRStCZkRraC9WTGMxYWJvSlJKVEFQd0ZyZjNYTTFyWWF5VHpUcEpI?=
 =?utf-8?B?dlA5aDNsYjNlNk4wSUR4eVY0MHZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DB200B6FCF4574191F6DCEC0517C75D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hn+nJ8u1zgcwyjNS++3XJEfikAeQ91B5Gwr4y0aXnWY9dc1KIxW+9CarK++N6s27e2tcj+iNuZEg7mPP44iFY2F9xwqMS3GcgGEfcb6EYY1hHWlI7MosC3tU5KdaCNtueBGvWrgA/Bxzj10h6FzKGHr8vft+7KdBAqhpX2nyXFj4ipMohIAz38KPBlvdXZbF3eiPcQXkXsudtv8pJRBdYv0S3VxLQwWzuBCnC4KhcuQ11U77gtkxav+l3Yj5hp+4KEYUoKbw3V5jJ5y7cH4LLoH9qlwkmirFich7vKmiudldWwYAwsqtl932GIAIZXHR+mL8O9xf9g1BGCmlHsTtsJ3iwKy8tykCGJbw0r5rxM/PPSiQk7rBwFuh6I7vhEO7L0ICEGzzxg5uty0BPPPze63EmQgix24bmF1Idb4QcvxMLEygavXYhvx3670TwZUASps3lcphPBezh0lGza8R11Se9gFOijo3j/isjbcmA4kwA+JqiC5q0UuDwo7GT+xRM3YOuBusQdzp6NiZnHjIhq4y1CEfsIvLInxkQc/Rjp8VdN1mnej2MdSWr+3UEUsun5GuS1yvBtKaQhsHlNyjqssiNDR9HodfGsra6dpmpjDVty6VsFBdxltmCjutwwDv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a80bda-5c8d-43f1-a017-08dd526c19cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 11:37:19.9155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5niLEKAyohQfKHbmAe2xiMR/b/P2hcXi4T21WvmqRMV/ZHJiARuU7DnHtZUnbYwuOGHk7H1OKoT/jXU1kXDJEoVBvieO2eVp1VphMVTr7A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9261

T24gMjAuMDIuMjUgMTA6MjUsIFF1IFdlbnJ1byB3cm90ZToNCj4gVGhlIGlubGluZSBleHRlbnQg
cmFtIHNpemUgc2hvdWxkIG5ldmVyIGV4Y2VlZCBidHJmcyBibG9jayBzaXplLCB0aGVyZQ0KPiBp
cyBubyBuZWVkIHRvIGNsYW1wIHRoZSBzaXplIGFnYWluc3QgUEFHRV9TSVpFLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+IC0tLQ0KPiAgIGZzL2J0cmZz
L2lub2RlLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2lub2RlLmMgYi9mcy9i
dHJmcy9pbm9kZS5jDQo+IGluZGV4IDNhZjc0ZjNjNWQ3NS4uZDljYTkyZDFiOTI3IDEwMDY0NA0K
PiAtLS0gYS9mcy9idHJmcy9pbm9kZS5jDQo+ICsrKyBiL2ZzL2J0cmZzL2lub2RlLmMNCj4gQEAg
LTY3ODQsNyArNjc4NCw3IEBAIHN0YXRpYyBub2lubGluZSBpbnQgdW5jb21wcmVzc19pbmxpbmUo
c3RydWN0IGJ0cmZzX3BhdGggKnBhdGgsDQo+ICAgDQo+ICAgCXJlYWRfZXh0ZW50X2J1ZmZlcihs
ZWFmLCB0bXAsIHB0ciwgaW5saW5lX3NpemUpOw0KPiAgIA0KPiAtCW1heF9zaXplID0gbWluX3Qo
dW5zaWduZWQgbG9uZywgUEFHRV9TSVpFLCBtYXhfc2l6ZSk7DQo+ICsJbWF4X3NpemUgPSBtaW5f
dCh1bnNpZ25lZCBsb25nLCBzZWN0b3JzaXplLCBtYXhfc2l6ZSk7DQo+ICAgCXJldCA9IGJ0cmZz
X2RlY29tcHJlc3MoY29tcHJlc3NfdHlwZSwgdG1wLCBmb2xpbywgMCwgaW5saW5lX3NpemUsDQo+
ICAgCQkJICAgICAgIG1heF9zaXplKTsNCj4gICANCj4gQEAgLTY4MjAsNyArNjgyMCw3IEBAIHN0
YXRpYyBpbnQgcmVhZF9pbmxpbmVfZXh0ZW50KHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZv
LA0KPiAgIAlpZiAoYnRyZnNfZmlsZV9leHRlbnRfY29tcHJlc3Npb24ocGF0aC0+bm9kZXNbMF0s
IGZpKSAhPSBCVFJGU19DT01QUkVTU19OT05FKQ0KPiAgIAkJcmV0dXJuIHVuY29tcHJlc3NfaW5s
aW5lKHBhdGgsIGZvbGlvLCBmaSk7DQo+ICAgDQo+IC0JY29weV9zaXplID0gbWluX3QodTY0LCBQ
QUdFX1NJWkUsDQo+ICsJY29weV9zaXplID0gbWluX3QodTY0LCBzZWN0b3JzaXplLA0KPiAgIAkJ
CSAgYnRyZnNfZmlsZV9leHRlbnRfcmFtX2J5dGVzKHBhdGgtPm5vZGVzWzBdLCBmaSkpOw0KPiAg
IAlrYWRkciA9IGttYXBfbG9jYWxfZm9saW8oZm9saW8sIDApOw0KPiAgIAlyZWFkX2V4dGVudF9i
dWZmZXIocGF0aC0+bm9kZXNbMF0sIGthZGRyLA0KDQoNClRoYXQnbGwgbWFrZSBpdCBjb21waWxl
Og0KDQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvaW5vZGUuYyBiL2ZzL2J0cmZzL2lub2RlLmMNCmlu
ZGV4IGY5NGI4MGQ0NDMzZC4uZjY0ODY5ZmFkNDY2IDEwMDY0NA0KLS0tIGEvZnMvYnRyZnMvaW5v
ZGUuYw0KKysrIGIvZnMvYnRyZnMvaW5vZGUuYw0KQEAgLTY3ODgsNiArNjc4OCw3IEBAIHN0YXRp
YyBub2lubGluZSBpbnQgdW5jb21wcmVzc19pbmxpbmUoc3RydWN0IGJ0cmZzX3BhdGggKnBhdGgs
DQogIHsNCiAgICAgICAgIGludCByZXQ7DQogICAgICAgICBzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAq
bGVhZiA9IHBhdGgtPm5vZGVzWzBdOw0KKyAgICAgICB1MzIgc2VjdG9yc2l6ZSA9IGxlYWYtPmZz
X2luZm8tPnNlY3RvcnNpemU7DQogICAgICAgICBjaGFyICp0bXA7DQogICAgICAgICBzaXplX3Qg
bWF4X3NpemU7DQogICAgICAgICB1bnNpZ25lZCBsb25nIGlubGluZV9zaXplOw0KQEAgLTY4MjUs
NiArNjgyNiw3IEBAIHN0YXRpYyBub2lubGluZSBpbnQgdW5jb21wcmVzc19pbmxpbmUoc3RydWN0
IGJ0cmZzX3BhdGggKnBhdGgsDQogIHN0YXRpYyBpbnQgcmVhZF9pbmxpbmVfZXh0ZW50KHN0cnVj
dCBidHJmc19wYXRoICpwYXRoLCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KICB7DQogICAgICAgICBz
dHJ1Y3QgYnRyZnNfZmlsZV9leHRlbnRfaXRlbSAqZmk7DQorICAgICAgIHUzMiBzZWN0b3JzaXpl
Ow0KICAgICAgICAgdm9pZCAqa2FkZHI7DQogICAgICAgICBzaXplX3QgY29weV9zaXplOw0KDQpA
QCAtNjgzMiw2ICs2ODM0LDcgQEAgc3RhdGljIGludCByZWFkX2lubGluZV9leHRlbnQoc3RydWN0
IGJ0cmZzX3BhdGggKnBhdGgsIHN0cnVjdCBmb2xpbyAqZm9saW8pDQogICAgICAgICAgICAgICAg
IHJldHVybiAwOw0KDQogICAgICAgICBBU1NFUlQoZm9saW9fcG9zKGZvbGlvKSA9PSAwKTsNCisg
ICAgICAgc2VjdG9yc2l6ZSA9IGZvbGlvX3RvX2ZzX2luZm8oZm9saW8pLT5zZWN0b3JzaXplOw0K
DQogICAgICAgICBmaSA9IGJ0cmZzX2l0ZW1fcHRyKHBhdGgtPm5vZGVzWzBdLCBwYXRoLT5zbG90
c1swXSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGJ0cmZzX2ZpbGVfZXh0
ZW50X2l0ZW0pOw0K


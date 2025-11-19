Return-Path: <linux-btrfs+bounces-19136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D0DC6DEA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 11:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 195834E3883
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A941347BC6;
	Wed, 19 Nov 2025 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pRdVWexm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BwunQz8x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4F346FA1;
	Wed, 19 Nov 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546872; cv=fail; b=A3Rl1HbzTq2D6hfYHPJpjTZG12GZKGE1RZs+f6/zry6bY+SuYSfYtIOhD143wKAL1Xv1WgYK+hqBp5iTz/qvTKbR2ccaV9+JDMA3KKU/1MJNs/5nLkLYEmFiZyMjy0z4Zex9xhZNsBxUSRa0uPu8s8SxWrvVWk8kcIm6uhA3fsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546872; c=relaxed/simple;
	bh=UFRLk9RvhA411SswLtBQzFvvXI1epH8AKJqlOLYyxJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uUpbVDqfBaEmTlGBIJwPJyBNoWi60sF3l1EBkQAaHy+YFmcrKD9oSIw7GNhYVShP17qGLj8pII4E3RdbYw9moWM7UC+b59vII3sltW7qIufCR/qvFB1eNyZJ0udl/jKdtRhWgBF7TJ7aquyW9ADiOWFdA/F2eFTx7dyD6wUjo00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pRdVWexm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BwunQz8x; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763546870; x=1795082870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UFRLk9RvhA411SswLtBQzFvvXI1epH8AKJqlOLYyxJg=;
  b=pRdVWexmgQP99fpvpdKfsSmT4o7N2vF50hyh/bJ44zK3VW2WxYo0jI0B
   2aVTkwTZo2JFE1mbOk6l+PQ54YrY1ym7fJIc/AtlH35aS/jZ5MhPVujFi
   f8AImNdWzyxnQiib9e+3kKKKg66XaJMEdnJNWUa8v+OKAz4qgqgKbSKJz
   64Ap5AZLa2FDTcFcq/bezrdRsAc+Pu2NqVFHrdU9NbjnL500r4PujToBd
   WHb6lyUJAHF6p8Q8MZQC1Bk4mbAX/ZubQqEm1XZKLF5f7zBzAJhwKOeCy
   g0Eq8YbkvhkuDeAJ7BnxXkw7nldNILLxrTSHnojI/+a/pu/i6MnEP2CLY
   g==;
X-CSE-ConnectionGUID: yB38zYKzSjy5yE9KYdrX4A==
X-CSE-MsgGUID: qSoU4K8AQ96AYeZ5crlFEg==
X-IronPort-AV: E=Sophos;i="6.19,315,1754928000"; 
   d="scan'208";a="135384091"
Received: from mail-eastusazon11011059.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.59])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2025 18:07:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kp5MXTZl7i2MITa2YJrCkaInIAwGzLZkhmXdoTnRPuxHtpwoqMoQ34rm0Ds2nmpvnrH1ZF3spT9QM3PjR35e5lOwM0zEeYtgrWG3oYKUZ364XVoYQP7/qEXXzIWuHIhkZZltoe1bydb4RCgTaQ/GjUopoim5AQe6UoUQ+evqs/9ETMBeGWME0mBRKDaXi0ERpP/Kg8uDZytVG/rfYLZtx4GyKFFghhViYWTKeIGcKvCKuqI9d/ChDV71ECOdwVgEJ09slsAfA2XeKeuMyp2EX0nLdoWN4+0CSpYLIBjPgKR1zMEtgAKBpY6mcrlBXIEIptFa/ssd26023o8v8jOxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFRLk9RvhA411SswLtBQzFvvXI1epH8AKJqlOLYyxJg=;
 b=WMT8U1NVJEarYyiFOnFmjhpaaZ2YPsB4q/XPjoG/yarhQO15pvYlbDjxG1wlyu2E3XG71wC0iez2mCR2RPc53S0VeDqA0jxTHscy5s7NQAcQJeslB/7OVxWKMaial7L+NMCD+iyhNv/C6KV6iIGHN+3D4CjBng+JJcceKZMkq3BCLvK6O4IjzPvqTghZeEU3576Rj+QjIzqpZxSPy22PpVe+3k4FdvmMqSq0JVI+XHHpRpQPlMzvgSEmEXcAATWa1F+kZXoxLye4QTnv4t+QXdxElOxOKY4z5I+lV8jsSLNPbn1kr6bdWPh5nzTU8n74M3iOS1fVG+VqLULw5NvVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFRLk9RvhA411SswLtBQzFvvXI1epH8AKJqlOLYyxJg=;
 b=BwunQz8xn/QpazRGEbDxYyCXDZjRWzQEByAIvogqjs9iEWOWUFULfaxH7h2gR/GPFFiY5v18ylAtSNjQ6gIVn5ttmtJelM7eGKVYv7xZR1va2myooJhs8dhoanGc+0iwc4zJUMSd9Evh77rFfSm25RgbbrUTudMGCZhNjNwlYco=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BY5PR04MB6643.namprd04.prod.outlook.com (2603:10b6:a03:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:07:46 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 10:07:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/6] btrfs: don't rewrite ret from inode_permission
Thread-Topic: [PATCH v7 4/6] btrfs: don't rewrite ret from inode_permission
Thread-Index: AQHcWKXl/q7eMjema0iC9q3cHje4wLT5x2eA
Date: Wed, 19 Nov 2025 10:07:45 +0000
Message-ID: <55cdc311-7b12-4dfc-ae79-9c4aab9153e0@wdc.com>
References: <20251118160845.3006733-1-neelx@suse.com>
 <20251118160845.3006733-5-neelx@suse.com>
In-Reply-To: <20251118160845.3006733-5-neelx@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BY5PR04MB6643:EE_
x-ms-office365-filtering-correlation-id: a2694344-7bc8-48b2-cb27-08de27537c86
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|10070799003|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHNwTnJDTWxaQzJhUm9GNTdvQ0RVS0RvdU50WmN5dFYxT3FaaWl1TDNqcW55?=
 =?utf-8?B?KzRSSmRyVHFKT3J3OUJGR1A1RmVEZWo1dkxzcTBBc1FBSE9naVJ4UWJYUUI1?=
 =?utf-8?B?T2YrWkZoYnhlMWVBZU1OT21RNFh2b0R4NFp0RERFRmhHbm5EMWRZUkdFNHF2?=
 =?utf-8?B?WHhscEFMVFB0U0lkWFVjK09BRk4wc3pzeHVNOGE4T3MzN2NnT0VUbUlWaFY1?=
 =?utf-8?B?Rm1BcllNOExCSkR5ZmJ2UDRLY1hBaEJGeWx2VVFGOGw2SmhOYjNIVWhuZnR1?=
 =?utf-8?B?OHN6UzRydW9aYnZJUlRZaW9NVmhwQ0JzckFHNW85emdCOWxtVGx6aTMwK1Iw?=
 =?utf-8?B?TkNtNGU4cUxVUzQrQ0czSks0K2VsbUZJTGlkRTE1Q0E5ZWRtTUZlRGdqam9t?=
 =?utf-8?B?dU93Q09GcDNnbnNYd0FraVdHekVCOHRRSTFNWnJuTU1sSWkzYkl2bzZYWDVF?=
 =?utf-8?B?cUVYQlA3MkpuSGx5d1R0MFV0VkwwTElIakVFVG9QeFZ3cWVlR0ZKd2NvMjJp?=
 =?utf-8?B?ckxIK1BHZ1VjV1ZmMWZ5Rng5ZkxzUkd4SC9sK0VFSmY4SVdQOXQ3VnVCZDZm?=
 =?utf-8?B?TzlRS3lJMHB1WS9XWFAzWEZWV0dpNHVDN0pkYkZ0dDh2VnYrOFhDVkJ0dlJO?=
 =?utf-8?B?cWoxa011RTl3ck5sL01GMjZqVkY0dzZ1S1dzeHRNTGdKdldzN1l3RWFLWUlv?=
 =?utf-8?B?dnJzanZVZlZ6eWZ4NmdyeWo3WkpEK2tObVBiekNobkwrdGo1T0hFenorR29Y?=
 =?utf-8?B?OGU3N0MwWjJzb280NHF5UVlIZDlPVTNiZy84NEhyV1R6NWRueUVKTVRrdzFa?=
 =?utf-8?B?MGZIeEZtQ0lOWlFlai9PQ005WUdSZVJPa1M4VUR3RVZVM05GaUFoaDUxZ0tU?=
 =?utf-8?B?NHJ3SXd4VHJQR1hXeExvazZlSFpYWWtsL3FEMXF5WHJvb0x2UW5YeEJpeTdk?=
 =?utf-8?B?T0NsYXUrMVgyMFBZTE10ZkxHblc4Y3VMTGxDK3BHdjRzSTF2c05VR0ZBaG1U?=
 =?utf-8?B?eU5HSlJiQ3NHdEhrdkhQTVozTVFSc3BiRitMa1FBZ2Q5M0JpdTkxaXZxOTVi?=
 =?utf-8?B?U202ajdtOTFZTWJpK2lRR3VRb2ZqQ3ZsZWx6SC84Yk83cGFmYUhCbUlYMHJP?=
 =?utf-8?B?SU5OTmF5cHdvZUtaV1BFU2NnWTl5VkFIWE9WUm4vSldKQk12TXJ5VWhVb0hV?=
 =?utf-8?B?SSsvVXlQUUp4OU05bFNFY2RRRkN1TzZBVjdHbTV3RFVuR1FaR3puQTdRZkI4?=
 =?utf-8?B?dmpPVk84NUhZcXh4TzZFVWVlUlhzTEdsSmJlTnRzV25QQ2svczhDS0VOcVVB?=
 =?utf-8?B?dmtWcG8zTWM2ODBuQjZMVHZvUzAvRGQvTk84MDJGTGJ5cDlESUNEODZDS1Zp?=
 =?utf-8?B?aFIrQW8xQW1FL3d6UFlrbXBXTG0yTnUyZllpRWdDelgzM3JQN0IyYzFSbDN2?=
 =?utf-8?B?WWwxZ1E3WjdhcFp2OUZaWVlhT2xMR2pxcmFhZnBsdkhSZWpCYnNrVFkrSC9v?=
 =?utf-8?B?WDk2akxYeGpnRWUxWDJ0bEtvcWt6R3BHeDhsUVk3NXcrVTV1aG42R2lOQ1ky?=
 =?utf-8?B?V0M2THBjcGhkSWNpQldiZkZsNnQzWXRLREJDQmdYSWFmMnFUR2w3RTd0ZU9p?=
 =?utf-8?B?UCs4Tm5pRU1TWjhTMkladzE0NXk3QVNHRUtCL3NKWi9WNWtGWkFpTkw3Ymo3?=
 =?utf-8?B?OWlqakc2SWhOampKR0Z0ckJISHliMGRWRWVhRWdNVmVnRFpRc1EwR2k2S2Ir?=
 =?utf-8?B?TTVKZVU0aG1ET1NGSUdDSjZFQVdZS2pqQUtxN21WQnE1TndXR0Z1cExJS0Jv?=
 =?utf-8?B?M3lLck9MVno3TU1wSVluVVhXOEw0eGhNS2pPZS9RYnlFb2JkZUhTZkorT3Zx?=
 =?utf-8?B?WEthcTUrK3BMc1lhRG1MM3RreDBHU3NmaDhyNVoxWEhaamYxSW15TlNzejEx?=
 =?utf-8?B?bDlsWmVNQ1RuNG1ZVnZoWE4vYU1qS2pDdGt3Y01HSUd0RWVRaTBLOVQ3bGtR?=
 =?utf-8?B?M3ptWVdyRnR0ZWc4d1Roc3grYkV0VDBkR1Fpbm45MGRmOW9zNUpsa3B4V0hw?=
 =?utf-8?Q?Dthwp6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(10070799003)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTRZTWZLdVBHVURKU0NsQ1R2VW55djk1NDRhdmZNRi8yYXRBTE0yRkR0Y29K?=
 =?utf-8?B?YVdUdmI2UzBKbUJBaDZYL3F5TU9uUFhOZ3RramNQcjdYTXhsd1JVbVRVckZ1?=
 =?utf-8?B?cjJOdnR6WHpQU0xmYlFDY0ozWndsU09XUEZuUjYvbVNTdHlGYWxQeXd2WGhv?=
 =?utf-8?B?RUlHVytTYjRqcHdvVXp0SzZldDFZc3hocU16MnBMVi94aXlOejVGQndhUFZn?=
 =?utf-8?B?T0R5Z0lrazZVblUwVC9VSlE3cktuRlpaY0dHeGJCYXpWWm0yZGFGMytOemJs?=
 =?utf-8?B?dWsxTTVzRmdHejhrWjJQTDNSZ2dNd3lRaDdyL0txSXI4aHBXdThtbmk3Rmkv?=
 =?utf-8?B?NURUbVpiY2VDak93b2NLWkIyQkpTSHNIY3JnRGpzeUFCQXhnV3gvUmg5VDdO?=
 =?utf-8?B?MzhWWUpDUUczTVBJUWQvdEVJcjVjQ01UUUgzbytqa21MbThGTXk3SllOK3ZO?=
 =?utf-8?B?OHQ0YXBQWVdZZThRa3l4UW4wZ1UxMjdTVWRHbkIyb0pQbTJSbUltR0g0NlMy?=
 =?utf-8?B?cnRsdmdFdFVsMHpkRE55SStCWklFYXpoTk1iOU14UGxuYkw2amRqd2hpWmxj?=
 =?utf-8?B?cURmZDhENVhVcStkQjR4T0FzeStwVld1YTI1RVhJREVRWU00R2Vod2lyc2cy?=
 =?utf-8?B?Nndkbi9NckFzbVE0RklTYmtyVFE2YldBY0kwNVArYWdkTm9sTWFjVE5MclJk?=
 =?utf-8?B?bitzNTNqcmgxRFNlK2ZzN2ozY2dreFQzVFQrV29nQzBkblhpSXpVSFpIaHhq?=
 =?utf-8?B?SXFKQzc2dW40Z3g0TmJxZEhpbU4zUVIxSkRFQ04vQ0c5R2pTemJKbUZFNGFM?=
 =?utf-8?B?a3RnMjlJMWVOOWprYXdZVWdCd0lOOFFyUEY2VWl3K2RJS0tuZmRPUFh4OUxF?=
 =?utf-8?B?MkdPYjRDM1MrU1dIWDVLVHFGVmlLcktXK3lXbGx5WWVxaW44dG5KUWxTRGly?=
 =?utf-8?B?N1V1SUZ5RkUyR0p2cHp0NTMydlZLQXdKUlVISEFod0hZby9xZXlsWi9GV2V1?=
 =?utf-8?B?V2lFSUo3bDhvL3ozWXJoSk9ta3pQS3hLOVFOcUVlb3liSTRaUlAzVkd2SnA1?=
 =?utf-8?B?YVFHZ2NzOHdoRDNmdVA4dlZGZjRtYXFleVVnN1JzdkppQVFiTzNpVzNWYnkw?=
 =?utf-8?B?S0NjNk5NK3pickpKSm01TXc1Mm5pUzVDK0dzdUpxNTNZckF3U0JjVnRTVFJs?=
 =?utf-8?B?NlJDY21kNCt2dVQ5ZFpMQWwyUTdRa0ZBSXA5RWlWcmtBQVp6U21VcDMvQkZT?=
 =?utf-8?B?VitUT1FraldvSUJvbHlUVG9tNDEweEY5Rm5SSC9HUUI5b2hKWStYRFVUZkpW?=
 =?utf-8?B?Y0JBSlo5R0FES0UrcmUrTGFKV21DTnJxZGo3TTM4R0VVSWcyNTFRV2xhRTZL?=
 =?utf-8?B?WGJ3dTZ3T08vUi8wVkFERDdHUVR5azlnOTNIbThVdFA0b2FzUnBBa1MyazVQ?=
 =?utf-8?B?RW9EcE5vcWQ5VHZmY3VpZUI0SE8reFAxOUVmK05uRHdudkRVdEErWVpUanRC?=
 =?utf-8?B?VHN6ZmZCOVBJU1NyOHRNZ3EzU2tFTFJCSlUzWDN5c2Y4Wm5TYXlxU29SVkJX?=
 =?utf-8?B?ZUpiTE1yRjJNV2pyck9LLzBxV0drWVJhb2dOKzE0Q1VGQytyOC9veWhDd0Zt?=
 =?utf-8?B?SXZSNjJUeVp5T0luTXJkcmdlOWVnM21oUmtJNXBMZEZWVW1NVFRxU3owWkJx?=
 =?utf-8?B?Sk9OTlJuQlNoa2l4ZEU4RWU0ZEVVbkZqTFBaWURicmxHeExKYXF2LzFHdFY2?=
 =?utf-8?B?OVZGYzVqYXcrVlk2QlhWZ05mdnRCdE5DbTVJK0lUZHhScGVRUVk2V3lxY0ty?=
 =?utf-8?B?NFRJWDVNNDRBOFc0TlFuRzE5Ym45WlBXSS9tWTRTYUVMZmNtNy9ndXFqV2hC?=
 =?utf-8?B?OXVxUVlUaFBZaGFTenJVL1JuR1MwbkxtMllSYTNqZWlsN2szTmMwSjUwVWNB?=
 =?utf-8?B?bkJtck9wVkZSbThnSGJ1MGtQcUVWeWIrOVFuSGxnMmRiSi95djBWam1KYkha?=
 =?utf-8?B?ZmtPSWVWU0pVYjgrR1FqMU91cHdLenY3Ly9aM1MzbUJzNDhUNFAyV0JJMFQv?=
 =?utf-8?B?UUVTUEJSN0tVNXphSXEvTlFJVzFPVFdROG9ZZFowR2ZpRDJGMVo3MStCblVh?=
 =?utf-8?B?WjNCS0p3cmczZEFiNk90MEFGNlMvb3lGRzNDeHVubG9EZkd1UDB6Q1k2ZURm?=
 =?utf-8?B?U0VxbW1XMml4TW94TkNscTE2Wm95bWhoTVl6alZWWXByUTZGdURUYzFOb2k1?=
 =?utf-8?B?enJQaG9HTHRjSkRNN2VoMGhmZ1JRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D2E73E204702D48BF951B35B25460E6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u0g8kcw0gPwSuAuoCKuVyP1WbXPZuDjH1MKcCOmb9Qm5nXo1a2pN/ffnS1C0pPhayg6BDxbbhNEAufQ8PmsCC1F16qww9mlRavgp6J4jrLvd6xKNRKwCEhesfspYsnTCEBVDpm3Z9FNYyi5+yiHBdcF9hF9JkuSX2ElIUZgh02BPM1yaffgJZtKRwO6jV8PNfhL0SpE7qK25lKtVeRMg8pPfmfRZQ54b2wOTB7r2wQiBYC4ydJ5zusiezKT5hqNJUf7yA8VetbSSAz6P9gpxGCMRuIymJEvY+T01Ap8n43P/uSjUhrYMAqENOuc62Ds4Q3wZEyrW0z/g0tf7pRuWifXpzq3t1hpi+MAhg5xMomYhfs5XkU/VOq8a1+jPeskQTVnlIc0wr9rV/xDaLUM5Obb82h/jXGHxYHgAeaqqKveXRwpeCAqgQM7Un1wKa97jDmzWyFbzsPUu0e5K8Tp4x7d8Ya4eXP3KzVzdsizWUmbpfGb8l1mgkSyeqnTlrLbwOqddzBn2brJZ/bvTwowVHGhN601xvX57vdim7g/BQ+3z45fWVtlQVZ+2AfooA714TwLRBgVRkW3oTP0MPkmVCi33ZYoj7E7cbl7WRbGMQBxJ1j9MpyHjXNyjaZqZSPSC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2694344-7bc8-48b2-cb27-08de27537c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 10:07:45.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElWN0Ke2cTizbrD8nXHcyjlF2MBlsGp2LfHd7wgmPsqmn9s7ncpy94n91jJ3RhH5X+XgWvbbf4meIQLHSdnOUPz41cRvH1msHHFZZaAPirA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6643

VGhpcyBwYXRjaCBvbiBpdCdzIG93biBsb29rcyByZWFzb25hYmxlIGFuZCBJTUhPIHNob3VsZCBi
ZSBtZXJnZWQgQVNBUCANCnRvIG5vdCBvdmVyd3JpdGUgdGhlIGlub2RlX3Blcm1pc2lzb24oKSBy
ZXR1cm4gdmFsdWUuDQoNCkkgdGhpbmsgYWxzbyBhDQoNCkZpeGVzOiAyM2QwYjc5ZGZhZWQgKCJi
dHJmczogQWRkIHVucHJpdmlsZWdlZCB2ZXJzaW9uIG9mIGlub19sb29rdXAgaW9jdGwiKQ0KDQp3
b3VsZCBiZSBhcHByb3ByaWF0ZQ0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxq
b2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0K


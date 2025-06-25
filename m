Return-Path: <linux-btrfs+bounces-14942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A9AE804D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976E74A403E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34B42D1F4A;
	Wed, 25 Jun 2025 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dPUpaX5T";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DmpQZ0ah"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71852222CC
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848753; cv=fail; b=Sx2mKLZxPqLMj0qD2W6Pv+ckC0tClGxw6DtWEw2ZaAUthmX8O00+Y/TETpagK++CwO5v5G5hSy7bzjT81IyN/9CNdF6aMA1kLJ/Th7QxnZmU4w+/5EjbzB4YxM5jAvdyRir1pwEmPu6/xeMvrKanja6YNrGeTOpjnNiNYg+KIMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848753; c=relaxed/simple;
	bh=pEarh/xtml+/ivyuCI2jYTdpV4Vdb6/T185/IevB/R8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O12D7l+/X+Xs1TDoy7oZ78Jlj7AERUAQRWDym5rzd4OxzcJE9iTSoU0MUYsOBubvbOOP1udfdL7TwOMGTNQggx8KB9eFkijMQ/hygTYhA4So4BvJ0neTbV0yCwsuaNw0Qh8Gp0MYJNG+eT0qVoBKypOEgK1SQU9pweZYfBOJpIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dPUpaX5T; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DmpQZ0ah; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750848751; x=1782384751;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=pEarh/xtml+/ivyuCI2jYTdpV4Vdb6/T185/IevB/R8=;
  b=dPUpaX5TbaHdpsH+M8rG46nzqwOxs1aDkYZfl6L7XmEYf7ApUAG4f4Yq
   6qr6V7jOlPin/nmI35MFxpCi/dGF7tNxiGx1mZHIbyMCfUqtsuypOjOj9
   1C/CqgzvWgDJBXe3J1jMcRAOeVwap60bDqqjGiS4pw+taQ1YsbMB+zbKL
   1KRppR9T5EeYn8u4/JwPv2SpneJUpwkWGjJimzEqpOwprYpELlexap5yH
   MQKJxKxfS+jJ2LuFPg39hHzY6XDvNv/XsiY+6/lczCdUDF/4I70yXswV/
   fuPRwxARq8hFSE40xntlQsGzic0LD4BbSrO34vYMY1wCJxjfUzQX0To+A
   Q==;
X-CSE-ConnectionGUID: +eQyrKjzSdCDRIZqdol9CA==
X-CSE-MsgGUID: 8KA+hkjMTPanwIKbWGQXzQ==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="84693055"
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.89])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 18:52:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=turXFbiiews5OcznilFjQ0HMQkPi4vXLcSkXYwX2MRg1VUjKt4nP3L627Ars1p1KRODSEUR77nXahKp7zyXcLXEOnNg/MTNxaVYa+Hh4/hWFreXAX+0G4XHMhIzAyASNC4RgubKOc3jgwtwIN7BFic31r9zf5JIA9TqZeC5q9U0Z97AxdqfxsJyEzWUdsKybxDw2aOZeOSJ8efAulXZr4JwQBLZZr6fJBjM0OOI+E9lRy98sqgvHkrualfZtTxHbY41WmvTYDBRvPiEsZaJdNdXNUNFmoVTNDIhJjl1oHBRdHwoiE07Omg1B2SlWG5rFSAgtLHILXYvbi/xeYo1IaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEarh/xtml+/ivyuCI2jYTdpV4Vdb6/T185/IevB/R8=;
 b=cZqSCXfaa3wxEg2X7h1nERUEgxDYJo+8Ns3+TxnApO+Ez0kcbR6+kFSalW3Kzt0l3YVENX0pUnQQ6czc7yzGesKN9+iRiGd0bBILNHAV5t21S5SiQsWKHEujCw40+AIA9QgiQU8CAeCmd8Cjd9KH09zpjG2wXJaVSu03P0NFUvwhGzep74qpf/ANjkoUc33hdZ2pdvai0449hZ8GcEnp/x3CyTKdXkgff86T56+ZZakj8UIO9pTv+tzabIp/y4MsJ7txJGrmo2FJcSjk3C7YvtYp77sLntznMu9zQcEtc1yD/rZ0Iwex7iMuwNcHqqeHHjPHfo5btK7S+MK+sJzurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEarh/xtml+/ivyuCI2jYTdpV4Vdb6/T185/IevB/R8=;
 b=DmpQZ0ahpVWJsghsDfmbozKUL8sUzplRmbcrwlPqD4WX+MwGaVWTKWTPhfMm/DtnXKU3BuEyqZlXfxdbRBoW5VixNqM2MzKgN8PEpqg2HY5PFpRGClF/7pWkf/rcARw3/EqNOHiR8G5jiNztbE2Fq61BKacl5+3Cpamia4HV+5w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6806.namprd04.prod.outlook.com (2603:10b6:610:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.31; Wed, 25 Jun
 2025 10:52:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:52:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/12] btrfs: use inode already stored in local variable
 at btrfs_rmdir()
Thread-Topic: [PATCH 07/12] btrfs: use inode already stored in local variable
 at btrfs_rmdir()
Thread-Index: AQHb5RgGZ2D0VjNCj0WSVdpA2vnJebQTtEwA
Date: Wed, 25 Jun 2025 10:52:29 +0000
Message-ID: <788c44b8-2299-4ef5-871c-ab28eac99c80@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <e1789e1dbfdb73b930d74d6eae8b728d8241cabd.1750709411.git.fdmanana@suse.com>
In-Reply-To:
 <e1789e1dbfdb73b930d74d6eae8b728d8241cabd.1750709411.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6806:EE_
x-ms-office365-filtering-correlation-id: e1b4265a-db87-4375-d1ff-08ddb3d66133
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SDBuQnNxWVZJeUVkNlNCbmR0ZVZEWlVHbkJjMUYvVXpaK2d2eFFqNHM2VFlh?=
 =?utf-8?B?MWRyWHZxb1cyQzRjZDJtWTRzc2U3V3BWYmVQM1A4MlY0ZlZrc3psa1ZGdGRq?=
 =?utf-8?B?QWxLKzdkOEhyL2hJaTJYck9nRFFJaExuT284NXlFRlk5QTZCR1BMYndBUGox?=
 =?utf-8?B?a0J1ejVOOEhRdDdzby9OdkhmN200OUVWeitrdUtoTGFEYmgzZ0w0WUlkelpy?=
 =?utf-8?B?cGV4b0F0Q1V3WHREbGtFMTRYVU91dStHTHJZeERXYmdkOVlwa0xHTkw3M0Qy?=
 =?utf-8?B?Mzd3K2Z5bkdCR1dlMHU5ZzBlU0FydWMyVzlFWTB2NGtzbjh5dXg1dVlHOVV4?=
 =?utf-8?B?cDhCMVBUS0Fkc3hWcGFMSGhGdkM3bTRnTXpUVkdqYnd3d3ZhZThZampHMmh6?=
 =?utf-8?B?UGxHVEJrTkZVWGloQkJRcy9RUk1LMXE3QWY5eE1DQisrTU84bGlGN2J2c3VX?=
 =?utf-8?B?dW5vQXVlaEZjaHFzQlJYeE5PelFuQWgycmNJLytKS3NmUUJuOFV2dCswWHhG?=
 =?utf-8?B?SzZZQTJodWdUNUpid25DUlJUZzRvOVdLYVFGbjZ0TFZDbnh2OTR1RytDblpE?=
 =?utf-8?B?dDBNSC9GRGFSMHNFdTdYZElSNEM1M3NqQnN1TjJrQ21QVHJHTWI5MklaQVBu?=
 =?utf-8?B?SW9DcmVpZkwwS2xQK01UN2NmV0hGWjAva3VXQlRWQVJmOGtFcFBUSi9waHIv?=
 =?utf-8?B?bVNGL1JzeGdiaERld2o5alpYK3JDNGZzVU15ZkVpRi9YbEpLSlVaZTl4VjYx?=
 =?utf-8?B?NzI4bHFPS2dqZHVnd1h0dm9XVnNkZmxYaHNFLytYbEJpNDdjWUxoK0JvLzZG?=
 =?utf-8?B?RGRTN3V5NlVpMGhzZGsxaVJuUmNRYXhKc0NtVkNlNndYOVp5OEVVTnZWSjZ4?=
 =?utf-8?B?VUJQTTlZK1hyMytES085cFVTc1hJcFNQR3RueXVmdUVrdnQxbnJTaS9BL3c4?=
 =?utf-8?B?bkhUK2lQTjQ2dlBKVjNsT1M3dExFVTdFVDVnS29BS0JKcnd2MkFSTDZ3TGJ3?=
 =?utf-8?B?aER3NFBzMGtvd0FuSllvNld0ZzRVdC9JMzVrSHJyMm1rb24yRXdmbnpqWldI?=
 =?utf-8?B?M095dlE1OFU3d0FXb2FZcGVXUFE2ZXFoTXFTbWdRb1Q3SFdYSVNvU2ZwWWJ1?=
 =?utf-8?B?cHJuWmlLUThiRENFdHRXZGhqRjZpQWhtQStBd21Rc05lMGs3Y0hYOEhmMGJl?=
 =?utf-8?B?TURxd0ZlWFppRVpGWFY0NHdzV1huRkd5QmY0RnNCcFdyTC9JNEk0N09EZ2Qy?=
 =?utf-8?B?aFRSZDljc1h5dzEwSE9kTm9NWDlFRXBXa2JaY2RpQVRHU1VQazUwVWkwRDQx?=
 =?utf-8?B?NEQ0V2YyN3RJcSs3UkMraVQ0ZVpESTNGZEhRcUlsSVkwWGIzMWhnZDlpeHVr?=
 =?utf-8?B?MDBkUDI0Qi9OWkVSdnpYSFB3b1kyRnBPRUV2Tjl4M0tTU1h4SnRLWFNHRFUw?=
 =?utf-8?B?Rm4vYXFjVzZEemJrNEpUMlZwRm9nRmd5L0tSOXlLTFZjNDkzaWVSVlVQYkJ3?=
 =?utf-8?B?cEZtNGcxdGtEN0dUWWtmZjNuM0krU2xjaEFaQkJub2J2Zk9oWERKYytHeFhI?=
 =?utf-8?B?WXN5MEsxYUtGYmNuK2V2RXJkVTNJTW5FaUtGNDRUaWVzTUo3ZWs1ZVRQb2J6?=
 =?utf-8?B?S0ZFQ0NGbDNOQ1lHVGk5Z1NILy9LYTliZjNIaHBzL3FwVDh3L0piVUowQzgr?=
 =?utf-8?B?U2FYWUdDWWJ6alhibFFsTnpsTSsvMllzTGVuZURSaXJESy9SQ1lnYWM1eldp?=
 =?utf-8?B?WkRPQW1VNWNkTUZib1FBWmlEbnYyUEpPMTYzQnoyRmNwTnZ0a2gwT1lXS2Jy?=
 =?utf-8?B?SmF1TWlMSTlRNW9TYmxOMnBBRSttVi9SOFlwSms2MEd3NlY4ZXoxNDdnL2pT?=
 =?utf-8?B?N010MTQ5U2x6M2FSK3VUVlIxZzBwTFVzR1p3dGt6NjRnbXBLL0NyV2dZZzhZ?=
 =?utf-8?B?aWFXaHUyaGVCdWpIRkJvRGVFaEsyRUxNQjhQNHJ6QW5SN1cwL2xBci90KzZl?=
 =?utf-8?Q?jTvTR18HJJTi4iUpupILEmNtY4V5Ws=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFJGN0tCdHBpVXovazhPOVU2YVNoOXRTMXR6S0grdjl3WksyTk5ndmlTelJD?=
 =?utf-8?B?S2RsNnB1RGJxY2o4UFVaR0t5OGNoY3pBZkl0eG9QdGtrMGJJV0dCL3Y1YzBw?=
 =?utf-8?B?Nkt2WWV0QUVvSWlTeFQ4cm5mZ3JxbHVDTUxoaHZ1VEVyZHpGRUZhWUlNWFl1?=
 =?utf-8?B?VXlJMitZSkpOeHVSRzNzTk9NajlXTU4wSXY5cHQ4dzdBc2IzYzBhTm5TbEEw?=
 =?utf-8?B?SmJROEp0anQydzV2R3RCSkN5SmpXU0JyUUlrTWFFci9wdnpxY1d2U0tUTjh0?=
 =?utf-8?B?aDk1YXJQVUU3dGdNT0RJOWV6c1FQNzdWbzhTY1U4bFFPSmFLNkgwaVRRcHRJ?=
 =?utf-8?B?SGVkcmtnb0dFY1NlU0hYQ2E5TTlFSXZxSEdRemJiUGJvQjBuL084dkJUTTdX?=
 =?utf-8?B?MlVWSWQ2L1pmSVUxV2NpaU1NR2JiSE5QUFRLYjhFVzJoT3FuVEhLc3luNE9T?=
 =?utf-8?B?RTdNWnMwdEtBL0hTWHl1NG1vNVQySHl5YXM3WjJyak5CaE1tU01vN05qOXdQ?=
 =?utf-8?B?VlBZY09ROW9QRjhnMEFDUzZwMnBzSTE4TTVYc2xqaCtFeHJyaFozYUsrWmsv?=
 =?utf-8?B?ZTNmcGF1UzZ3RkNKU3ZvbHBZaUxtT3RjUHF3YWJ1YlVBazdhRlZBbHNweVg1?=
 =?utf-8?B?b2poZTRNTHh4TWxyWXNXWE93dE1rRFJ1RWlUbmhBdnNDVHdwWTVSckFaTHpL?=
 =?utf-8?B?VEdyUExmUHRqejBCb3VDY1E1clJIYlN6Nm1qbkc0MkNBOEc5RURVSklZTzVO?=
 =?utf-8?B?WjJUMUNIditJMUtIcUp1MmV5UlF4bkZENG1naTErQ29CYlY1Tkw1bmliRWo0?=
 =?utf-8?B?WXBEdFZHOFhqMXJOcHZtZUFWWUZqZlNFWlJjZ1BxQWZwc2JZNFp3TXRGL0VU?=
 =?utf-8?B?cjJtZXlvZG1lSkJYQlM0ZktoRUF0NHZiTjRIVG92Q3UzUlVUSFlQODdzYVBx?=
 =?utf-8?B?NlJiVUdvQ2M4VWI2L3BlZFNxUmE5ZFJxQjlMSThQL1hnYTJVUnFxRHZmMEcr?=
 =?utf-8?B?N3hMZG45UVhtS0tUSUdvakpNL1pCc0N3V2w2TWRCTG9SNDE1ZGRzTEl3TDZs?=
 =?utf-8?B?SFhDNjhSWXdIZnFJWWE5VWFwVHExMm9KWWhGMWxEaDlKMkxucUh6ajcrLzRn?=
 =?utf-8?B?U2xYcU16SVQ2VG1CaWRpZlVyOU03S1ZSVUpSMTFKcU95TVc5KzNMMityY1B3?=
 =?utf-8?B?aWxZa3NzSndXWVNMU1RuOC9qZWVhL0ZQczlmdzN0QlhTc0Yza1NUUEkvVWRq?=
 =?utf-8?B?ZTFyc0s3RWt0bHc2WXdUdkhITUYyL1R5dDZkSHVMMjB3ZUFRVXZ3UUNvZUNl?=
 =?utf-8?B?Z05BK0pFaDBZeTdCR1dVS0dZNWNZNFJOTGZzQ2MrWmhZUVU0OUluUmxTVWVD?=
 =?utf-8?B?RURGdU9GYWhKK2wzS0Z4TUx2MmFzb0tQdzZWaW9OUE9SVkhEbTRGOWthZ1VK?=
 =?utf-8?B?TnZCM2FyQ2xTenM1cDc0ck5OWit6cDBnQjc1QkRlYTdrQ3F6bllHUDZ1czY3?=
 =?utf-8?B?RDI4NUR2MU1XK2IxVDFxWVoxVjNNNWlRMEdjL203V2pkMlpqWTJ5ZkpzNm9p?=
 =?utf-8?B?M3FwSjN2VmtJM0xoMGVwZkpISG9aNENzem0ySitKYjQvOU9UMllrbGg4TUxM?=
 =?utf-8?B?WEJId2lodnprYVh2MVFxR1BxT1c5clNrMlloNWJLUnc3ckVPd05ncXpYVU1F?=
 =?utf-8?B?dzg4eXBkU2g5NXFmZnBqaXpWc3dqSzFIQ3o0aVluOWp4bWdJUFhoaGpmRGNZ?=
 =?utf-8?B?OTVTak1DeU05T0hWS0hMQ21qZW44d1o5YW4wL3V4bGtsTy9nZ1FRQm5LQWlM?=
 =?utf-8?B?TW13ZWl2b1gxWUpIMnI3eWFBY2FkMS94aWFEcGM4MHRyeldSTnZTQWw4SjVW?=
 =?utf-8?B?N1U4NHRoL0k2bEVxRkVwdzU3YWFPTUVTTVJFTVRIelRDN3Rndm00NG1tQUts?=
 =?utf-8?B?Q3UzM0NqWTlLV05hOTdocG9tMnlsdEgydVJOUGg3R1pFZkZuTFVRQmFFMUVs?=
 =?utf-8?B?SmI4eW9pVFFIamwrUStlcnlLWnBsY2FRYmIrbkd6TEtMVFYydzJFclZYMThh?=
 =?utf-8?B?UzVnVEhZRUkxdXNVZU5PSG03NkdoR1NGMFZXZ3hZRFZRaXpKTU1GQWd2Vmk5?=
 =?utf-8?B?Qm1sWm9INEVlQndZN25nelV5RFhRc09MUFV0dGhsVmIySmdpdHA2THFnYW0z?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <679AD1F3A13D1247893BFFD1B721826D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PtPREbXJqJMvdhSqUeUEVMipsow15GLw/nE/Fbvsx2//G3g6naZ49UD9b0SfOlcDYosc468jiE3vqGMJI7vfeubVdCfcmZFPH7a/VmwJR0PiWZtyknibrmhY2PorNt1Dvc5O+F+yfUMazmJ65YTM3fxkpCL8HtmVb9YImvTeF+4JH57gDrXWdpd9vFEuSwZ11wnfsTAs3Y1KKG+6hrKeJFrO45uWvTKjghGxmPhswqv1zwF9eaIEYH0TVNso6m6WvVRWDknHZHRgC7593AwBc5weWBak1qbnhP1BFT2kSgwliq1Gy4a2NuNvu7ARLwfDFHHqoevcjVjZewcJ/XofOHn1Ht1BAqHIs8gaFCBE2ldjVEjhrOtJk1aus/G2+RjzP+LwRnhm5fQXDpoOslETI2IzDdV7Q8HQM1aSuImPuV4JtSUbxq8bNUmryWIwoIlGQgHffiy3lvnJ3poi/ACHIKIr/PApXfUjghRw4hx/arpImMXrTxqKh7LfxKQQZ0w8dPEpGA7oy+FFCibzQjNIztSCJeoHCJB7T8cE+XCaKL5IcgZ2kqbsE9HCGhWhBUodDCNbBL7WTRdorgVL41by50e4ZfMzo0FrbofVXXwsz9bLnHkRGnJvC8DaHVhlrTCo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b4265a-db87-4375-d1ff-08ddb3d66133
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 10:52:29.1414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eM/UCDu6wjLz2/wk84jmP62PIDWpwmzZFOpshsb7OmlTQ9mwz3jKE1n0C0OBLHOx4ltuREqpaHIArkZkHs2coSK65Ru38iIjrqzILJv54bE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6806

T24gMjQuMDYuMjUgMTY6NTUsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gVGhlcmUncyBubyBuZWVkIHRv
IGNhbGwgZF9pbm9kZShkZW50cnkpIHdoZW4gY2FsbGluZyBidHJmc191bmxpbmtfaW5vZGUoKQ0K
PiBzaW5jZSB3ZSBoYXZlIGFscmVhZHkgc3RvcmVkIHRoYXQgaW4gYSBsb2NhbCBpbm9kZSB2YXJp
YWJsZS4gU28ganVzdCB1c2UNCj4gdGhlIGxvY2FsIHZhcmlhYmxlIHRvIG1ha2UgdGhlIGNvZGUg
bGVzcyB2ZXJib3NlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRmlsaXBlIE1hbmFuYSA8ZmRtYW5h
bmFAc3VzZS5jb20+DQo+IC0tLQ0KPiAgIGZzL2J0cmZzL2lub2RlLmMgfCAzICstLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9mcy9idHJmcy9pbm9kZS5jIGIvZnMvYnRyZnMvaW5vZGUuYw0KPiBpbmRleCAxMjE0
MTM0ODIzNmQuLmY4ZTQ2NTFmZTYwYiAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvaW5vZGUuYw0K
PiArKysgYi9mcy9idHJmcy9pbm9kZS5jDQo+IEBAIC00NzU5LDggKzQ3NTksNyBAQCBzdGF0aWMg
aW50IGJ0cmZzX3JtZGlyKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkp
DQo+ICAgCQlnb3RvIG91dDsNCj4gICANCj4gICAJLyogbm93IHRoZSBkaXJlY3RvcnkgaXMgZW1w
dHkgKi8NCj4gLQlyZXQgPSBidHJmc191bmxpbmtfaW5vZGUodHJhbnMsIEJUUkZTX0koZGlyKSwg
QlRSRlNfSShkX2lub2RlKGRlbnRyeSkpLA0KPiAtCQkJCSAmZm5hbWUuZGlza19uYW1lKTsNCj4g
KwlyZXQgPSBidHJmc191bmxpbmtfaW5vZGUodHJhbnMsIEJUUkZTX0koZGlyKSwgQlRSRlNfSShp
bm9kZSksICZmbmFtZS5kaXNrX25hbWUpOw0KPiAgIAlpZiAoIXJldCkNCj4gICAJCWJ0cmZzX2lf
c2l6ZV93cml0ZShCVFJGU19JKGlub2RlKSwgMCk7DQo+ICAgb3V0Og0KDQoNCkknZCBwZXJzb25h
bGx5IGFkZCBhIGxvY2FsDQonc3RydWN0IGJ0cmZzX2lub2RlICpiaW5vZGUgPSBCVFJGU19JKGlu
b2RlKTsnDQp0byB0aGUgZnVuY3Rpb24gYXMgaXQgY2FuIGJlIHVzZWQgbXVsdGlwbGUgdGltZSwg
dGhpcyBzcGFyaW5nIHVzIA0KbXVsdGlwbGUgY2FsbHMgdG8gQlRSRlNfSSgpICh3aGljaCBpcyBj
aGVhcCBJIGtub3cpIGFuZCBpbXByb3ZlcyBjb2RlIA0KcmVhZGFiaWxpdHkuDQo=


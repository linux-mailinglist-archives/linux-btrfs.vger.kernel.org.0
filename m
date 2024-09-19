Return-Path: <linux-btrfs+bounces-8126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB62D97CBB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 17:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CA0285FC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2444D19FA90;
	Thu, 19 Sep 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p2Qa6b/d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kpFZPhxl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05E1EF1D
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760583; cv=fail; b=lxsgIkhjXflnw6N1XvulflcyyAddvQ8eRVUFmqYBrgwuJCdM8SaBVkYZ9vuJUSBgb19U42H0wkxTKgMjDCqNknK1aOViNfMpdp7mfHjtL50rfPOdbrQd78JJjjr1yL7uFeh0soFCOzis2h23mYDxdvpuF5TyFNpfXvv5x4E13l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760583; c=relaxed/simple;
	bh=FNRjWB/5h6sl17clOrpHyFU4v97xpYGMWvMdhuhexIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p/xpp6JZxQaJPqF8lubEEDUoH3zv+Oejw2W7QSTZl5IGs5sU9egfOuOYOzfIzfYmJkL63EwdigIEVik3oDb4r7yxM7uksclK77PXiYrszAPgnQ0LvtiLZ5YapwrM7R2L/jMTLaePTuJCES2AdtONfxo4witX+PQTNnEL0IVZBUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p2Qa6b/d; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kpFZPhxl; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726760581; x=1758296581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FNRjWB/5h6sl17clOrpHyFU4v97xpYGMWvMdhuhexIw=;
  b=p2Qa6b/dkPe/Ts30LrwifYaia9K0VoAuIlDXYMz/GPQcXUAJjXFsCkB9
   6mW35a97oVY5b1pJlnf3PGCDCgldiDkDeXJdtv4zkJWLcLiX2qHpURxrx
   EItw+0T1LmZ4EBCLGRT26Vn5SsSiP0ITQ+9T3cfJ4j2s/+Pb/FNDShn2g
   xBBGIhBFryf+RTuIZXMKgMDgd9LUHj6ukHnTCcLll7PvcQRsIWgB8cMCL
   N3ABDvgBHfkGlyJfTov6VwDYb/+HJFdpsIB2rDdWkaevONv0BqFd8SxBk
   X2d+T6GwG/OZmCIxeMjxfZLWrGz+A1k1XmZzeCmLdYSnwLdGNOb8d7ouZ
   A==;
X-CSE-ConnectionGUID: 3kn7EG8FRXG5Nj8OUO/0mg==
X-CSE-MsgGUID: bqEGzbSDTuiHppn38PthHw==
X-IronPort-AV: E=Sophos;i="6.10,242,1719849600"; 
   d="scan'208";a="28085580"
Received: from mail-centralusazlp17010002.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.2])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2024 23:42:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnD4CykCMjL9deviej8oRn7Nr6VtatAS9xN/3FKvaKdPIMzGXt4n52jyEND3OT7l6sfoqIG6FmTN9F5RlEQ0k94fHO9v6g0R4iPn4U3Djxy5VGookiQuBSOMyJnW+WI3gV7X+nZvclhLz2gVg5U77bp2fwoJ3dT2QvMVz+Se7xeQ5Lj0xwPQsJs/jQk3Mei5YWd4tQYZiGR1fVRP5bFNr1CQI76+xcBo1QZqj3H2wSRW488eGfup+37lUGxK0xw7a+mhHfkku21sghkTLRYplp8AJuu3+7uuDPdPDNq+H1804iR2iHqa0hi2k1vfDo43287Zt38oLnuohctS76r3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNRjWB/5h6sl17clOrpHyFU4v97xpYGMWvMdhuhexIw=;
 b=fdzKQ9q3tcHSloaBXs88r5usMxm1bNv9/vucQWg4mq0C58TYlkMd+5NEKiXTH5OmaPt6iWDVUbkph7MtTL8intkIvU3n42jvdu4Gp2MQmMzg0r8kDkkARbounitVGQaQkeWPfSfoRGlFsya0mRCEl52f4/mnBpR80OAusdknS1Q74Rzh+bwdK084qCKVJqu/idjbcQ1kDVpSWfgAS4tPVtrKlg4FWlorjezpJncl/+ZhosccWuQm2fn+ZSiN/m6jyqE8fYupGBkrWfzjkBmyBrGj/D/vneNwl7jMqRPwmYBg6d51G/0qxICdre7UxWQdcxWM8/hRCInVSWYwbnYWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNRjWB/5h6sl17clOrpHyFU4v97xpYGMWvMdhuhexIw=;
 b=kpFZPhxln3u7ENmrv8sfOaaTogsnYUvjHuvStCYvtaiLZf9/vvzLyjd2XJSU1oNe9q3LTAulJNriZB6y6RpcDr4FbwNW6AV5iyOyZQQ32NQ0lNckOxX513olQ2Zfb2L4dCP2or2kUSwzfmM63830t9Ux2czE3AnShY4Nls/WfmU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8004.namprd04.prod.outlook.com (2603:10b6:610:f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 15:42:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 15:42:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	WenRuo Qu <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC 0/2] Add dummy RAID stripe tree entries for PREALLOC data
Thread-Topic: [RFC 0/2] Add dummy RAID stripe tree entries for PREALLOC data
Thread-Index: AQHbCdT4jVtO6XSQ6U6iM3wx68oLnbJeNhWAgAELcYA=
Date: Thu, 19 Sep 2024 15:42:56 +0000
Message-ID: <bb072733-3f77-4b9f-80ef-4043f1ce8112@wdc.com>
References: <85888aaa-c8f5-453b-8344-6cabc82f537e@gmx.com>
 <20240918140850.27261-1-jth@kernel.org>
 <168e23bd-ab59-45d6-8f46-e01353d03084@gmx.com>
In-Reply-To: <168e23bd-ab59-45d6-8f46-e01353d03084@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8004:EE_
x-ms-office365-filtering-correlation-id: 78a2eef6-fc95-4276-d1d5-08dcd8c1bb7e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2xTUklmcEdKR0crZ3FRK216YklDTTFaU3pTTkduWDBRSXpCRlZUK2dJcm54?=
 =?utf-8?B?eEZxcndOOEtyMHhQYWhERXUxVjMxSWw0QytJWGRHMDBUVFFOSTRkcGpvaFN0?=
 =?utf-8?B?NWM5WThDN2NvNzFFS2xwcmpnYThDZWMyUGthamVwNkZVai9kSHIwNjJTTlJq?=
 =?utf-8?B?MXlGODBMaitNNCtmdVBnVXVqbUtyemZmSGhYdS94NHFKYkdoaitmcm8zN29K?=
 =?utf-8?B?WlFmV0lkUGpzODlDTG9EaWhvOUQ2VWE1MnE2SXhyU0N5YS80anNmaFNaYnRr?=
 =?utf-8?B?OU44YWtDVXZ5RGhkNXV6MG9KZ1RxRVQ5TTRUMlB4cnQxZFZiODFqK0ZIK0JG?=
 =?utf-8?B?enc5a0dWb0U3dnNRUTJBMjV6dFpmdXdYTVhXSkVlUW9VYlNrdlRrb04rdVcz?=
 =?utf-8?B?ekdWRzBEbGJETWtvbkNCNmNhbzA1djVhYnlQWWNVUTJyL0Nmb2d4VllIS0Zj?=
 =?utf-8?B?Tm04bEJ5YUFLa29WRUF6S1JWVUJXVlFQTjZBTXY3eXBIZFpzZ0JsUFpRZG5h?=
 =?utf-8?B?VmJvQ1FFbUFMZ1cwMmFqQUplOXZuVVZRS0RFb0hwaS9wcDJJS3ZzRDlBQVpJ?=
 =?utf-8?B?MHM3NFZBMFdpVG9NQ1dBdlIyQmd4YjI2NHhLY2YxUHNTdnU4RklVSkpkSThT?=
 =?utf-8?B?R1E1SFdIenJpQ2RkdVo1d1ZpNG9uNkhOei9vOVZWbFBGQ2RkemhIdDc2VDNn?=
 =?utf-8?B?R2dvSTJ0SCsvOFBvMFFzRFozNW5WeGZrVnFyRll3cS9ocklXanoyVndjY1lV?=
 =?utf-8?B?dThXa0NNSlUrU0FaWk40SVJVWmczSTdaMUhaR3N5cHUwdlNzbUdrZTdaeHdT?=
 =?utf-8?B?VDBKYkJXVFdWU3EzVUZNaTlGSk11R3QzVlNLTHVOUjJXd2lDR2puNURweEtU?=
 =?utf-8?B?S1ExWHV5VUxhK0lhdjlMRnVNdDRYc1NBaVZLSFduQXVoTFhubFdlSDBzaWMv?=
 =?utf-8?B?K0R6bm9QNUFZYlBNT21zcjBPck0yMnFXTE5nUHEvV04rcjUraFNqaVRVZkdt?=
 =?utf-8?B?enJZTm91RnRQK0Q2RWtBMGpUKzhKQnZlYWswSzA1NlhReDFsLzJ5ZXRIemxr?=
 =?utf-8?B?VFVOdDcweUxUblVjQmVwclY2V2hrM28wQlA1MVY5SzU2M3FiRVc4RnFHOVEv?=
 =?utf-8?B?UU8raWQwVThMWmcwMkVjWldMNTdocUhUVlJqSXRHZktaMitHOTJtQ2VCeFQx?=
 =?utf-8?B?bHdEUS9leGNJcXplWGs2TkhLNUpNUFBxQkpYdVpxQ0g3eDkvTWdEWUhia1VJ?=
 =?utf-8?B?d3Zqd2loZEZPUzlmR2RsNzBNaHhua2JRZ1lYa0xrazZDUTcvYjdCUWVyVjNS?=
 =?utf-8?B?YjJZQmJUc2lkNWRwTXlQRkpsMXd1WDlic2RaeHZUY3YwNG1UVG9ZZnQvYjFZ?=
 =?utf-8?B?TUduRURBRnFaTmNSaTlDN1RiejgwQ2VEZFdFa2I2UndJQkZOajB0TFdveTFR?=
 =?utf-8?B?TXVyN0FiVjcwdTdiUDRXOWYwZlQ0NHdZcmJsNHYvMFVmYUlaLzQ5c3RPRnpt?=
 =?utf-8?B?UXFkV2t6eitLMG52aVBaVkMxOWxnY2EzbUdVM1g3dnFwMlV5Y3pWVlI0WEtB?=
 =?utf-8?B?a0tjT0xVVlZzMWx4N1ZlWnFIWEgyU1RGUElaeHZjREdGMTR3Nk01KysrUHo4?=
 =?utf-8?B?bm9aaWpaRjgwNDJtaHh3b1JIYTJVYjVYdHZxSFlUR0VEQWtacFpDa2k1RmRp?=
 =?utf-8?B?ZlFpYm1vd1ljaEovVnhLb3VHbS9ZOGIwUFBUWXR2cG43VWcxenBESE1wcmhQ?=
 =?utf-8?B?Y2tEL2xwTWxDZEo1RC9takU4d2ZxNDhqU0xTRUROMjBiNHVIUHZBWTRTQTJP?=
 =?utf-8?B?Z29rdUJIYngzTkkrNEloMm9sSlc1Y2RZbngvWHVQa0U3RVdZc0xyZ2hRdTBq?=
 =?utf-8?B?MFdlREpUWFNUa0ZnYU5pdHVjRWhiY2F4aEhBczJ0ejB0c0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXZPTmRpQ3RrMStlbGM4ZTVwUDhvME9kVzZzSGtwNk5HS3U3QXRLN3l1ck9R?=
 =?utf-8?B?TzB3RVdpQ1o5elBJMWppcmRIRkpnbGxSdkdCancyUlBRVDB2TU4ydUovSjdU?=
 =?utf-8?B?WFE5Zjl4T21KZ0xwRmxka1hWRTEzbGVFQkVacFpzZlBzWW5FM1M1aTRlSGZa?=
 =?utf-8?B?OHhJRHBScVVvdWI4OEt2NkpGKzdZTDZzc3cxR01URm9OYi9BTXIwelkzNVBC?=
 =?utf-8?B?M3dxdDlvU09meUF5NHpRbkhEQWlydW1KODVocnUyS0QwZXFKNG0zUk9UU1N3?=
 =?utf-8?B?K05rWnJJTHQ0emJkVXJ3akNON0tTZjlVWlRjNzdqM1RHaFVjV3ZMdTZ6NkxO?=
 =?utf-8?B?NlhCWXlTZ3B3N0FtUHZlcGhnMmlzb1NuaThXNmkzdFV1SHZXYXVsdWZ3NTRS?=
 =?utf-8?B?eFo1cHczK1o1MGovQkRQR1dscW9qUkxBS2s1UjNOVW1QMEdCNEttd1B2cWFL?=
 =?utf-8?B?MHZ4alB3L1p0L0Jnb1lzcUhxS1ZhT25maDVjVWx0R0tqdCtkZkFVUkdFbnBG?=
 =?utf-8?B?RHJyUE5pZlg2bi9NQTVoWkl1a0V4N2dwNUVBY09iTFJXUm9lR3U1NVQ0ZG1R?=
 =?utf-8?B?QUtsb2ZSU3QxQW1HSUoxZmJrU2Z5VVBsd1dSeWtwVHpmYVhQNnRHK2N2OElD?=
 =?utf-8?B?dkV1QjdOKzYzUUpaRTZIOVYwSE1MZHF1bFlWZ1pYRGo5VFUrSHYzS0NhMHJS?=
 =?utf-8?B?djlrektabW1JbVlyci9RazNhYTJscjlTUUJiRGxqQ3dUYzVUMFhPNE5ONS9F?=
 =?utf-8?B?RlFuT0tlNkRsaVlmMURTeEFuN2x2aUV1ajBDRXVzSU9QSXZCQ3ZYRTkvNlJl?=
 =?utf-8?B?RlZ6RmJ3b2d1VnNtTHlXQ2R4dFhJNTc4cU5Ed1lER0JZd09kZEpFbnVNVkR5?=
 =?utf-8?B?STJXWUsyOXU5SmhPTHNaSXJUdWY3WklWLzJxb1Q4NVQ1QTNxdUlWOU9KZHFG?=
 =?utf-8?B?Zk1LQW5kdzAxNXFjWGlFZWJSSjlsdTdxMVhTYzMrZTcxUTB5TnZSZm4rZWx0?=
 =?utf-8?B?RFdJUjFvd1Y4a1lhbXRCdkJCZXNmSGNpV2QxZ05LU2EvZ2cxTVJOZ1pHcnI1?=
 =?utf-8?B?NkdaMmMraGFVVjU3VldaWVIrdW9ramVNeGpKNFB2SXhhSUpBTEZDNTlFUFJ4?=
 =?utf-8?B?OGRaWTQ3c3ZjekZJRkVRaXhSV1N0aWgvKy9pc2huZVBUWFdvQSt2VkRGOFpm?=
 =?utf-8?B?TUxvaHozZExoS0x0NUVtQWlIRi92Q3RTajIzblFqWjFHSlh5b1duWWVZT0Iw?=
 =?utf-8?B?L2taMS82dEQ1TFdUdUFhVWs3MEUzSnRvVkUxekhHdmRKdWdvNVM2K3lHWHFw?=
 =?utf-8?B?US9pWDljalBGS01LUmllbWJNMzR0TW5MS0JIOTlkYWw4azVmdXNNVjE0SXZx?=
 =?utf-8?B?Zm9NbXc3Q2JYMERwRmphWUVxSTFXUUFLRDVWU1ZMZUNTWFN2L0ttUWxWN2pY?=
 =?utf-8?B?b1JqaWloVHhTUDN1ZnNqMDdyb3dIUm1jT0d0cFQ4Zm1NRmhrWnIrSXJVMUtU?=
 =?utf-8?B?WHlsQldpQ3N6bmNnRWhGUlhMTjkvOEM5M2NGUkJhMlRyM0U3S1BobDFCZVRq?=
 =?utf-8?B?OWNtMk92MTlMVHdqVUxlbDhCL2ZGOUxUVkoyeDlUZ1VlK0hjRnh3S05SNkFr?=
 =?utf-8?B?RjBxRHFVTE04RVNtcFYzcVNSSlN5Z0JUbUhUMUR4czVBTXBxdGt4ZVhicXlx?=
 =?utf-8?B?MVlRbFVDZDRJWEI5VWUvZHE5bkt5UnN3NEhBZ2ZQYUp1empKdlo4YmpCWWlu?=
 =?utf-8?B?M1FTRnBtTXlITnNrc3FwR3VhMW0wWlZtaU5pck4zNVZoYUJLTXBSWml6eDJn?=
 =?utf-8?B?bjBHOEZqbmRYd1FPYTlCdVYrbmFUQTVILzc0QXoxTHVQNW1xVExqY1RDbkRm?=
 =?utf-8?B?WXprS1VPcUs1dk5hUUZLUm5LbGlwa3gyMi9KUnc1Q2dnTEdiZkt3MXJtdkwv?=
 =?utf-8?B?ZE4vQXY2SHdvZUE4MWVhek9vbmI4dW9NZHdtVmJEb0lsaEUzd1h5ZXc2bDlT?=
 =?utf-8?B?Y0dKSnpCWTIxdFlmWWRpdzRBTUkxTDV0Vm5jYmV6MDh6OHBuQU5za2J5UEdz?=
 =?utf-8?B?U3ZvN2t6Sm1ERHJEMmQ3MFBQR1B4NWJzUlVIVGhaM1ZBTVBhNFIyVVBKUU8x?=
 =?utf-8?B?ZGxkUEZRWVBNeGVlSjVvSmN2UWg4bEtqcFFwSlJwd2pNdnFxazMvWUg0Rkxn?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCD9E721E816CB41A612700EB0A393D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y91w39xct2irfMfNcpd13D6gGLK2OR4riqc8jwenfgtYiiYbgBUZpZ+yR3WqKaWZhnfppuhYtJ7W8eoIC1C/qorn3zc/OsSwqWVWJFSCqRssAMZI2oOA01y+DVfVWcMQsBRRoiFJsZU00ismp64cwjQ1nKwFtdrwqQruwPoUn9suMzuLGGbrAPTBBbZ1SEK40oRhOUJXAQfhVHTHuJi75PxpkKt4icR9c5UklL1YM9yyqCimWIqmvIUGwMKFCTFn+DV3WbWkmb5u9T63V4LI1nMRHR8b4FV6aOPpERDdLTYMQ504VnWDBNWyTuMixXiWNBLIAQJHCg/ADkZSwPUzEykqv3pfq3yjPW/0oHbFkGD+n150QYDuZ2x7E0FDvtASV9/36oGaBKf7//u4Et85qTs06BHfnYxgrBqIVAk+W86iR5UPsNTc+TGEvbvL+N4GIXqQm4yjjHgnyz883+Y1W2zEnNXhg2SeGxWG9qxE4bn9QZlRT9bRBkFC6FtlKFSCtCneXJ+uH2RMLOjQ9uvT9T+9EeW/EFxX8dsC+CFLUjGkXXzQdkyI2L1lIRDi/m7QPuFflv+lkjczcfONkfTebEKrBPI2d45TtwucQMcfiMIAHgr2nx4M4V9vdS09scAK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a2eef6-fc95-4276-d1d5-08dcd8c1bb7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 15:42:56.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ku3Vnd2QlWGsQYW+smtkVlENSC50LNz1Bf7zxmNYomkZc/iQtI9VseBHgsijUaBEbuFC1sT/smloSaaIEM3btdpBEBmw1Baz4b8E5DairA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8004

T24gMTkuMDkuMjQgMDE6NDYsIFF1IFdlbnJ1byB3cm90ZToNCj4g5ZyoIDIwMjQvOS8xOCAyMzoz
OCwgSm9oYW5uZXMgVGh1bXNoaXJuIOWGmemBkzoNCj4+IFRoaXMgaXMgYW4gUkZDIGltcGxlbWVu
dGF0aW9uIG9mIFF1J3MgcmVxdWVzdCB0byBiZSBhYmxlIHRvDQo+PiBkaXN0aW5ndWlzaCBwcmVh
bGxvY2F0ZWQgZXh0ZW50cyBpbiB0aGUgc3RyaXBlIHRyZWUgZm9yIHNjcnViLg0KPj4NCj4+IEl0
J3Mgbm90IDEwMCUgd29ya2luZyB5ZXQgYnV0IG9ubHkgc2hvd2luZyB0aGUgYmFzaWMgImhvdyBp
dCdzIGdvaW5nIHRvDQo+PiBsb29rIGxpa2UiLg0KPj4NCj4+IEknbSBub3QgcmVhbGx5IHN1cmUg
dGhpcyBpcyBhIGJldHRlciBzb2x1dGlvbiB0aGFuIHJldHVybmluZyBFTk9FTlQNCj4+IGFuZCBp
Z25vcmluZyBpdCBpbiBzY3J1Yi4NCj4gDQo+IElmIFJTVCB3aXRob3V0IHpvbmVkIHN1cHBvcnRz
IHByZWFsbG9jYXRpb24gYW5kIE5PQ09XLCB0aGVuIEkgdGhpbmsgd2UNCj4gc2hvdWxkIG5vdCBq
dXN0IGluc2VydCBhIGR1bW15LCBidXQgYSByZWFsIFJTVCBlbnRyaWVzLg0KPiANCj4gU28gdGhh
dCBOT0NPVy9wcmVhbGxvY2F0ZWQgd3JpdGVzIGNhbiBqdXN0IHJlLXVzZSB0aGUgZXhpc3Rpbmcg
UlNUDQo+IGVudHJ5LCB3aXRob3V0IGFueSBuZXcgUlNUIHVwZGF0ZXMuDQo+IA0KPiBBdCBsZWFz
dCBsb2dpY2FsbHkgaXQgbWFrZXMgbW9yZSBzZW5zZS4NCj4gDQo+IEF0IGxlYXN0IGEgcXVpY2sg
Z2xhbmNlIGludG8gdGhlIGhhbmRsaW5nIHNob3dzLCBOT0NPVyB3cml0ZXMgZG9lc24ndA0KPiB0
cmlnZ2VyIGFueSBSU1QgdXBkYXRlcywgc28gSSBndWVzcyBpdCBzaG91bGQgYWxzbyBhcHBseSB0
byBQUkVBTExPQ0FURUQNCj4gd3JpdGVzIHRvby4NCg0KWXVwLCBnb3QgYSBmaXggZm9yIE5PQ09X
LiBUaGF0IGFnYWluIHdhcyBhIHN0dXBpZCBtaXN0YWtlIGJlY2F1c2UgSSBvbmx5IA0KaGFkIHpv
bmVkIGluIG1pbmQuDQoNCkZvciBwcmVhbGxvYyBJIGRvbid0IHRoaXMgSSBzaG91bGQgYWRkIFJT
VCBlbnRyaWVzLCBiZWNhdXNlIHRoZXJlJ3MgDQpub3RoaW5nIG9uIGRpc2sgZm9yIHRoZXNlIHJh
bmdlcy4gSXQncyBwcmUtYWxsb2NhdGVkIGFmdGVyIGFsbC4NCg0KT25jZSB3ZSB3cml0ZSBpbnRv
IHRoZSByYW5nZSwgUlNUIGVudHJpZXMgd2lsbCBiZSBjcmVhdGVkOg0KDQp2aXJ0bWUtc2NzaTov
bW50ICMgeGZzX2lvIC1mYyAiZmFsbG9jIDAgMU0iIHRlc3QNCnZpcnRtZS1zY3NpOi9tbnQgIyBi
dHJmcyBpbnMgZHVtcC10cmVlIC10IGV4dGVudCAvZGV2L3NkYSB8IGdyZXAgLUEgMSANCkVYVEVO
VF9JVEVNDQogICAgICAgICBpdGVtIDEzIGtleSAoMjk4ODQ0MTYwIEVYVEVOVF9JVEVNIDEwNDg1
NzYpIGl0ZW1vZmYgMTU4MjggDQppdGVtc2l6ZSA1Mw0KICAgICAgICAgICAgICAgICByZWZzIDEg
Z2VuIDggZmxhZ3MgREFUQQ0KdmlydG1lLXNjc2k6L21udCAjIGJ0cmZzIGlucyBkdW1wLXRyZWUg
LXQgZnMgL2Rldi9zZGEgIHwgZ3JlcCAtQSAzIA0KRVhURU5UX0RBVEENCiAgICAgICAgIGl0ZW0g
NiBrZXkgKDI1NyBFWFRFTlRfREFUQSAwKSBpdGVtb2ZmIDE1ODE2IGl0ZW1zaXplIDUzDQogICAg
ICAgICAgICAgICAgIGdlbmVyYXRpb24gOCB0eXBlIDIgKHByZWFsbG9jKQ0KICAgICAgICAgICAg
ICAgICBwcmVhbGxvYyBkYXRhIGRpc2sgYnl0ZSAyOTg4NDQxNjAgbnIgMTA0ODU3Ng0KICAgICAg
ICAgICAgICAgICBwcmVhbGxvYyBkYXRhIG9mZnNldCAwIG5yIDEwNDg1NzYNCnZpcnRtZS1zY3Np
Oi9tbnQgIyBidHJmcyBpbnMgZHVtcC10cmVlIC10IHJhaWQtc3RyaXBlIC9kZXYvc2RhDQpidHJm
cy1wcm9ncyB2Ni45DQpyYWlkIHN0cmlwZSB0cmVlIGtleSAoUkFJRF9TVFJJUEVfVFJFRSBST09U
X0lURU0gMCkNCmxlYWYgNTI1OTI2NCBpdGVtcyAwIGZyZWUgc3BhY2UgMTYyODMgZ2VuZXJhdGlv
biAzIG93bmVyIFJBSURfU1RSSVBFX1RSRUUNCmxlYWYgNTI1OTI2NCBmbGFncyAweDEoV1JJVFRF
TikgYmFja3JlZiByZXZpc2lvbiAxDQpjaGVja3N1bSBzdG9yZWQgZjU0YWRlOTQNCmNoZWNrc3Vt
IGNhbGNlZCBmNTRhZGU5NA0KZnMgdXVpZCBiZWJmMTc1NS05Mzc5LTRhYzgtYTYyMy1hZDBkYzUy
NjQxY2YNCmNodW5rIHV1aWQgNDYzZjdiMWQtYzBiOC00MzczLTgzMzQtNTJmNWJmODM0NzVlDQp0
b3RhbCBieXRlcyAyMTQ3NDgzNjQ4MA0KYnl0ZXMgdXNlZCAxMjEyNDE2DQp1dWlkIGJlYmYxNzU1
LTkzNzktNGFjOC1hNjIzLWFkMGRjNTI2NDFjZg0KdmlydG1lLXNjc2k6L21udCAjIHhmc19pbyAt
ZmMgInB3cml0ZSA2NGsgNjRrIiB0ZXN0DQp3cm90ZSA2NTUzNi82NTUzNiBieXRlcyBhdCBvZmZz
ZXQgNjU1MzYNCjY0IEtpQiwgMTYgb3BzOyAwLjAwMDMgc2VjICgxODMuMjg0IE1pQi9zZWMgYW5k
IDQ2OTIwLjgyMTEgb3BzL3NlYykNCnZpcnRtZS1zY3NpOi9tbnQgIyBidHJmcyBpbnMgZHVtcC10
cmVlIC10IGV4dGVudCAvZGV2L3NkYSB8IGdyZXAgLUEgMSANCkVYVEVOVF9JVEVNDQogICAgICAg
ICBpdGVtIDEzIGtleSAoMjk4ODQ0MTYwIEVYVEVOVF9JVEVNIDEwNDg1NzYpIGl0ZW1vZmYgMTU4
MjggDQppdGVtc2l6ZSA1Mw0KICAgICAgICAgICAgICAgICByZWZzIDMgZ2VuIDggZmxhZ3MgREFU
QQ0KdmlydG1lLXNjc2k6L21udCAjIGJ0cmZzIGlucyBkdW1wLXRyZWUgLXQgZnMgL2Rldi9zZGEg
fCBncmVwIC1BIDMgDQpFWFRFTlRfREFUQQ0KICAgICAgICAgaXRlbSA2IGtleSAoMjU3IEVYVEVO
VF9EQVRBIDApIGl0ZW1vZmYgMTU4MTYgaXRlbXNpemUgNTMNCiAgICAgICAgICAgICAgICAgZ2Vu
ZXJhdGlvbiA5IHR5cGUgMiAocHJlYWxsb2MpDQogICAgICAgICAgICAgICAgIHByZWFsbG9jIGRh
dGEgZGlzayBieXRlIDI5ODg0NDE2MCBuciAxMDQ4NTc2DQogICAgICAgICAgICAgICAgIHByZWFs
bG9jIGRhdGEgb2Zmc2V0IDAgbnIgNjU1MzYNCiAgICAgICAgIGl0ZW0gNyBrZXkgKDI1NyBFWFRF
TlRfREFUQSA2NTUzNikgaXRlbW9mZiAxNTc2MyBpdGVtc2l6ZSA1Mw0KICAgICAgICAgICAgICAg
ICBnZW5lcmF0aW9uIDkgdHlwZSAxIChyZWd1bGFyKQ0KICAgICAgICAgICAgICAgICBleHRlbnQg
ZGF0YSBkaXNrIGJ5dGUgMjk4ODQ0MTYwIG5yIDEwNDg1NzYNCiAgICAgICAgICAgICAgICAgZXh0
ZW50IGRhdGEgb2Zmc2V0IDY1NTM2IG5yIDY1NTM2IHJhbSAxMDQ4NTc2DQotLQ0KICAgICAgICAg
aXRlbSA4IGtleSAoMjU3IEVYVEVOVF9EQVRBIDEzMTA3MikgaXRlbW9mZiAxNTcxMCBpdGVtc2l6
ZSA1Mw0KICAgICAgICAgICAgICAgICBnZW5lcmF0aW9uIDkgdHlwZSAyIChwcmVhbGxvYykNCiAg
ICAgICAgICAgICAgICAgcHJlYWxsb2MgZGF0YSBkaXNrIGJ5dGUgMjk4ODQ0MTYwIG5yIDEwNDg1
NzYNCiAgICAgICAgICAgICAgICAgcHJlYWxsb2MgZGF0YSBvZmZzZXQgMTMxMDcyIG5yIDkxNzUw
NA0KdmlydG1lLXNjc2k6L21udCAjIGJ0cmZzIGlucyBkdW1wLXRyZWUgLXQgcmFpZC1zdHJpcGUg
L2Rldi9zZGENCmJ0cmZzLXByb2dzIHY2LjkNCnJhaWQgc3RyaXBlIHRyZWUga2V5IChSQUlEX1NU
UklQRV9UUkVFIFJPT1RfSVRFTSAwKQ0KbGVhZiAzMDYzODA4MCBpdGVtcyAxIGZyZWUgc3BhY2Ug
MTYyMjYgZ2VuZXJhdGlvbiA5IG93bmVyIFJBSURfU1RSSVBFX1RSRUUNCmxlYWYgMzA2MzgwODAg
ZmxhZ3MgMHgxKFdSSVRURU4pIGJhY2tyZWYgcmV2aXNpb24gMQ0KY2hlY2tzdW0gc3RvcmVkIDll
ZDk0YjRkDQpjaGVja3N1bSBjYWxjZWQgOWVkOTRiNGQNCmZzIHV1aWQgYmViZjE3NTUtOTM3OS00
YWM4LWE2MjMtYWQwZGM1MjY0MWNmDQpjaHVuayB1dWlkIDQ2M2Y3YjFkLWMwYjgtNDM3My04MzM0
LTUyZjViZjgzNDc1ZQ0KICAgICAgICAgaXRlbSAwIGtleSAoMjk4OTA5Njk2IFJBSURfU1RSSVBF
IDY1NTM2KSBpdGVtb2ZmIDE2MjUxIGl0ZW1zaXplIDMyDQogICAgICAgICAgICAgICAgICAgICAg
ICAgc3RyaXBlIDAgZGV2aWQgMSBwaHlzaWNhbCAyOTg5MDk2OTYNCiAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJpcGUgMSBkZXZpZCAyIHBoeXNpY2FsIDI3NzkzODE3Ng0KdG90YWwgYnl0ZXMg
MjE0NzQ4MzY0ODANCmJ5dGVzIHVzZWQgMTIxMjQxNg0KdXVpZCBiZWJmMTc1NS05Mzc5LTRhYzgt
YTYyMy1hZDBkYzUyNjQxY2YNCg0K


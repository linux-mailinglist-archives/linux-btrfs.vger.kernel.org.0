Return-Path: <linux-btrfs+bounces-15468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56D9B01A2B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 12:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22201CA6397
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B957288C24;
	Fri, 11 Jul 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AIgHaXYj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YvpZPlag"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB41F12F4
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231279; cv=fail; b=QS/TMFI+kPULAvqZcuMBM3ayrIYQxE1Xy6db0h2XlEY7/H2P/H2hFe2fLFHJewmmatv9IpOv5TkRgj29O48MRMT1Oh0wmawoA0/Bs4RIMuQRbHSx6YOYLYkTx5B4GF1FV2EoImQtpoJYWw6Ix9NKOg9zid9VmWv0nFopzCmiq2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231279; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W/nLiP7U8sySEzcRXh69DP3jOHXX/E3DvGjMhmiNBhFTstPBKOtARZjEu6umrh47AQytWWQFdZThlbkaxIbicbIrgG8TqfWocEGALugsITJKc8TC4W41qQsPOSpVWL4AC57pdniK5a/L63xyK0OTK0uHuHixpxsagnAtn+TQedo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AIgHaXYj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YvpZPlag; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752231278; x=1783767278;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=AIgHaXYjfiu0B/X1/qO+i007fY6kqGlPcVk82GNPgszbVpjuTSUPnpTF
   /cehbIMyM1pHg5AoHaySJ3VCrmIOKMqrxItCnoRo3nDV4f6FLhwfM/m8E
   kLNTnM2TgFIwmjrxT79Gq/zkmJUsZQKPTtfESpN895HZM7D3ItCHvzRb9
   kctIa18PJMazbVRZ9Era0oUUbxWiIotnFjNs7GqYaZEVZEhgt57Hm2cNk
   n0M5xH0pa0BHWySLUCWIKAwY64fKn39QNpN786BAJpjigh2S4CsgNY1M9
   7ZLm3jvJgArI3vhk3hHmxP+AF9UiMkeH8YEoxecm5btD3A3Jp+KgxlHXi
   w==;
X-CSE-ConnectionGUID: csK7q76dQMaE5Y053rs+7Q==
X-CSE-MsgGUID: ML/nc2qxRqS6iB/9eeEtFA==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="88688322"
Received: from mail-northcentralusazon11013014.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 18:54:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxHOlkvtO0WYGCHh14HvAzliQ3o09W2g72PYIt06CCaPXAEB3liuQfEcZKqHDGDbfobIjUowDavEx0d6cAyIphDO5E0d/v1w/fKoxLyUWOmnQzQynVBZ0EHS4YGk0wiyGh4aWm1Hn7OqJDtzJ4BxM0HgzCVcZ69kOnCRYfx2GKldCPzKL9TDqKDE4FyjT9kl15q7KHAFGj8IX1LhvdvteaowT3Kf0cvbWAQx0H52Phk7dZ4E/4JwSe3q5ZOsiAGkjXYRDEQBwNxNFmgPYv3cwY+CWtqa//rQIR1hAV3MtLdth/4Cx9N3ZB/x/RcHdj41sPmJATm13USREb/4jPE6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bElPHeR3yeTUHV9QrxjBaG/cBvAARJ5uanNYGbVMzA8YDGCuVDqcRaLY6bvh9N34LwyNkvxrhJpb0hJNwGKj/bIq4ndyRz6u1TEfMA5V59xZH83R1NATipmSrEZnSZhp0VoszIIh+un0Y3lMMoBX6uPwugTNYycBx3gejVyT8bo/TnCrbmYvKjoM3T9XJcZXYNBb7PrDq/ZrnISMGljgTvjlQfpIjQ+VZcq9LkxtvlswZ0C9HENEgDHfpMWAG2s+qef8/8RytG+hxdboivuqfgrJBvctxgsezsJFt2YHO+YonY4s1zodvIrfsPPFJu4gkEjGt6nFXadtAFnXsKLINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=YvpZPlagLK8b1BQBOaPd1DTFDOffESOHZqVYealWJiCqrnbxE139dlHsvXHn05B70eqfA9fSOh+x1QfMbqaz11TBGfesP3+1WomNi7dt++zGlwGzbkvq8Ev+2QVWXPDynCEcK4M7fBsXoKWXXdQDmrpOjg2zT0Uzw+rm2vcfw9A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8897.namprd04.prod.outlook.com (2603:10b6:a03:547::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 10:54:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 10:54:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove btrfs_clear_extent_bits()
Thread-Topic: [PATCH] btrfs: remove btrfs_clear_extent_bits()
Thread-Index: AQHb8kF595yyJkZ9pk29tz9e/N1jobQsv9aA
Date: Fri, 11 Jul 2025 10:54:29 +0000
Message-ID: <efabe8ba-5826-4d83-bb16-e4c59c7ae35f@wdc.com>
References:
 <89e52089f6d6cb7b4dad233f30bf8d8ee8ea857c.1752224006.git.fdmanana@suse.com>
In-Reply-To:
 <89e52089f6d6cb7b4dad233f30bf8d8ee8ea857c.1752224006.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8897:EE_
x-ms-office365-filtering-correlation-id: 979af8e0-8320-4159-a45a-08ddc0694f9f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUY2S2V3QmJFQk1vd3V3Q3piZEdHRmNFOVR2Z1FlNzcvekdtZDB6WWIzMU9a?=
 =?utf-8?B?UlJsYUxPTTBzYktOMTEvL2dzWElRTUl0SXM0ajJ2K1M5Ynh3K2xTWTRsVURy?=
 =?utf-8?B?L3JqQnYwRjk4S2dPK21pc2lqUW9mdkRTZUEzWlBzWmoyM08rdzVOR25PRXk2?=
 =?utf-8?B?QWdtbFl1bnF3RE1sQWJNZEg3UWxRc3JON3JJVnFoeUZzYkUzU1lpcnR3T2RW?=
 =?utf-8?B?dkxaNkdWZHoyeVZIVnBaYlhBZ3lrOU5mVzlFTTFZdkxDTXFMUml1VnhLVElO?=
 =?utf-8?B?RjA0dDRhU0VUYXFWYmVXaWNBV2xIckZxWWxycDVTSXo4MFhBNlBHTXNHcHdU?=
 =?utf-8?B?Zm9ZY3ZOemlYeUYycUhlYitRU2d4SWt4YitvYjBuclJwb0I0NFQ5cFpSYzFK?=
 =?utf-8?B?TFZBdUpaMVFwbnB6aGh0NFZ3VzlqYWZWNm10T3J3VjdDRVdNOVB0ZmxPQUkw?=
 =?utf-8?B?ZVhsTm13MjNKaDh4K3lLTXN3WlNhbDR6RHpuaEtacDlPcDE1Y28xS3ZqYmkr?=
 =?utf-8?B?aC9hOE9uLzBqSitmaGhQelZRdFh4Z1dZdERTNGcrUGtYYnhXcWszN0I4bFVP?=
 =?utf-8?B?Tyt0cUppeHNxYjRmQlI2d01saFhNZFJJY3oyNHIyQ2RCcE1wSHhpaHh2UEhr?=
 =?utf-8?B?SzM4akdoa2hPby9RQ0JLN1cvVzMrSFZJUjVpTis5TTBYVUdLUmRGZlgxenVv?=
 =?utf-8?B?ZVEwTmE4ZEtLeHRFUEpTR0diRUhJd281SCt4OUltUCsySVcvRzFtTnM3U2RT?=
 =?utf-8?B?c1NrODJlVWRXNk9kL0hEck9sb0dGcjU2UTdMUUF4Vlp2Q0ZZSjhMZ0xrVTdY?=
 =?utf-8?B?ZEZSQ2FOd2hFdzlHcWlzYkoyZGNxU2VyK0NUcno5RjJoUmc5eS9xRlpoSXI3?=
 =?utf-8?B?VEs3WjQwM1hUc2tRQzBWSE9YaFVaN3VHNG5tWkNJY0pxcW1yNWZBVFROMVJ5?=
 =?utf-8?B?L3lOV3VPU3hmR3cvcFRCVWRxRGVCQVNwMUZFUUFZNmNZYi94MS9veXNGTjNx?=
 =?utf-8?B?MGYyb3VsMEFHQ0dSZzEvSHEzKzliNWpkbThqWUpJM1V3TWxjbnBZbW1nWXV6?=
 =?utf-8?B?TVNLencrN0l2TzlBWmVscUJMMXUraWNOZjRFLzFieitHOGNKZlY2WHZRRzBm?=
 =?utf-8?B?c3lCM3gwR3FVOVdSOWtUTUJJU1gzL3ZNMWdvRExjUVg2ZS9OUzFFWGxQd2c4?=
 =?utf-8?B?Q3B1NmNSQVV6dFdQVGl4RGdCV3NLWWdyNm9LVWlrMUVuUWF5RGIwelhRT2hK?=
 =?utf-8?B?dkRsRHFrVTEyVUJMMnRjSlhWWTdMdm52dWZrck42eXZBamFVUkd1bHhPQ1dB?=
 =?utf-8?B?ZW9QOWtSM1FmNmxiMWRRWWd5V3Z2RzZTMkcrZWRwb29VeFN3UHZqMngzanlT?=
 =?utf-8?B?UEx5SVhSeXZmeVVZRHJRZzlsRnNBMjlITnV5MUZVNHU2T2J0eStkTXVoMFdy?=
 =?utf-8?B?aWIvUDRsY3ZDVURRZlR1M2FHWElFajFIejBSQ010MEJtTUkxWnZnMG9jODdX?=
 =?utf-8?B?dzYySUxlYUpaTENBcUg1QXMvVWkrckdVK1dnek55U1h3WHdIQm04a2M4WUNF?=
 =?utf-8?B?NDdoRktiYXRYT0t6YlNFN2VoSC9vRXVSZThNNUJoeTAybGdhMncyem1kQm1V?=
 =?utf-8?B?ZnI0UjNFQ1VBQllzVnJ4bG42RU1NYm41NHhvK0ZOM25IL0NRb1pJUVNVdkpH?=
 =?utf-8?B?VjJTL1pSVGhUbTM0SkxFOUpPZ0tyeU5CUFcrbGNlbE5kWnl0eElRdGZGQ3Fh?=
 =?utf-8?B?ckFHVVhMNHQxTXh0M0hvcFRKSStoNXR3TzhwYjA1ejl2M2YvUnhQditzc054?=
 =?utf-8?B?M2Q4QmNzTmlIUkd2QXAwNFlVYm1vYWk1YWFlUzBuL1F5aDNMclhIT3lUa1hR?=
 =?utf-8?B?ZVVsMEJyeFBBWG93bUhJV1cyOW1mTUUxeU5Sd0lxOWRDK25CSXArUGI1YnNQ?=
 =?utf-8?B?cE9FYmtjWjQ5SzhWRGZub29kejk4c296bU5BRlBVb21rU2x3Rnc2d2lOTHdW?=
 =?utf-8?Q?juFOrnUDGH+o+HLYcpJ2yFJPEGV/aI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UllNMUk1cjBsZ01IcmNETlM0cnNYY1RjNDVza05PS01vcU9LZXdJZjZuK1Qy?=
 =?utf-8?B?bXJRVXlIR2MxTzdkSnF2TXRVTTB1QnVsRzhnSVBJaHJJSHcyNUwrK1A4d1dP?=
 =?utf-8?B?UFhUUE05UTZOVHIvY2ZSSEFxTWh1cTFHSFF6NnhKS3YzUXF6Vm42bFd6OWRi?=
 =?utf-8?B?VHZnaDRraWdHSkIzUWxnUXRSdWRGQmI3SWlBbzFuQXREQ05sZzRBTDVBNEhp?=
 =?utf-8?B?MCtzd2RUTkQzQjBPUEYwNkEwclh0UFJUQ0dwYVh3UndYVFdtYndMUExyNDls?=
 =?utf-8?B?T3U3Zjc0S3lSZ1hjbGhSR2hHdE9vU1BobVM0bFR2bHdQaVNENXBTZXl2UUgv?=
 =?utf-8?B?RHo1bEVJMWF3VW5LYk9YUXUyQnpMaWcrcWFHWFEwck5mS1RVYjdZTWhoUVV5?=
 =?utf-8?B?S2lPTWJXdGdTeHZyR3IyZGlHSUhYMVZidnVySklKRzNteE1RWW1CQzkxYUEw?=
 =?utf-8?B?UTZodllFRno3bHpPdG5QQ1A5OXNBQk5mM3JkZWRXTFN0dDdPNnFFUmEycVU2?=
 =?utf-8?B?SnRUNk5VV2ZBQXdEbjE5QzJLc2NlNktJdHhPd093MXBMd0ZKR05nbWVxVnJJ?=
 =?utf-8?B?b2ZRaGtOcGI1TXVxZzlQZmZ4RFUvMmx1djByaWU4NWk4dyt0MWNwZ0NNblVy?=
 =?utf-8?B?SkFNQkhkQ2FNL2Fabk9mdlVHOWZ4U2lJdnZDY0JSbjFCNTJtNTBKQ3lRZEMx?=
 =?utf-8?B?dkswWGR6SlhKcHlhYitPTVJvVXhOekhDd2JIMTdoUHBhMTJCeTVmMHRLbFJO?=
 =?utf-8?B?b1IySW9vR0xiODROYmt6Tm14a1JpZkQybEtKY0hZYnlPVGoxcWNYZFBaRU1R?=
 =?utf-8?B?eG9JcHp0MXZ2aFNRa2ZHTzQ0cWxKUWtBZUludjVCRGNDZmFiVEZBZUd2OHZO?=
 =?utf-8?B?QnZKYUNIcHdqYStFOW1rdm90SUFtNVUwYkI3ZWdBTENqSGtzUndSTCs2Y0Fr?=
 =?utf-8?B?Z3hYQ0hDVHRmaXVqdzl6NnY3T0R3V0x1QkR5d25SU09nZnJzTDVSTEVmdU5p?=
 =?utf-8?B?SExMeUJhN2NwUkpUenpuSzBYZGpiVENXejUyaVlnU29mNGNVQlBjNE03VDVk?=
 =?utf-8?B?dGNhZlVQUmd6dXpkUDAxaVNtSERXVFZpUGhFV2g5Q2o1RHljSmNNYmNIRElj?=
 =?utf-8?B?dDZwRTZuVjI1bnF4N3EyZEw2MWY2UWhwdURXZ0Y1bWlZaUhsbzVKeUdrYzRB?=
 =?utf-8?B?VW9GVkZJcENyekVCVnBZZ0g4Rmhsd05FTmhYb2grcmlnWlEvRWhML2ZJYnBa?=
 =?utf-8?B?eTBKcG5CNmNoRkxNbnZLWitGWVJDeFhMVU54L0dvQW9XQ2FLbXU0MjZrem5B?=
 =?utf-8?B?V2Y2N0psTXBtMXIreXYyVStIL0hib2RNSExDcmVWL25QcEx3R3ZsWGxUMWk4?=
 =?utf-8?B?NE9KWFJjSXBTSHdDVDltcE9yK3plRks4UnBHeWg4anlGMHVHVFJtTVZlazNZ?=
 =?utf-8?B?VVRkdzRrUWhKQm53bEtMSmNxWlpEKzh2THdmakxaVlRVREZPTjYvdEVtd215?=
 =?utf-8?B?ZkhDNlNQUmcrNnRYWVdFKzNIdDNPd3pwREg2S0Z4SU53by83VXJSbE1OTHJ1?=
 =?utf-8?B?b3BvMC9oQ1NiRkJKRzhmYVFCcG0wSFpQTUJndTBzYU5vTkw1bUE4dzAzR3By?=
 =?utf-8?B?akxqdlYvaGJzQ1FLU1Z1Z0lCSkVjNkFsQVZBU2kxQVZ0Q215dEN2UnRacE11?=
 =?utf-8?B?NCtwZmMydVYwM0Z1TC9Cam1Pb3dwV0d0MWZnbndoUWYrdE1kVXdHOWQvK3U1?=
 =?utf-8?B?dHpEZHByWHd2TDVQSzUvL2pkYjNvUE1nK05ycC90WFFVWXRxVlNudEsvcm8z?=
 =?utf-8?B?YUZzOXpJMkVZUWlhblpWeUZwMllJYjNRTzNzL1d0VFlXYW5jb01hMTFrV3Rh?=
 =?utf-8?B?MDlzUFFmby9MT1orbnpsN2ZxL1RZYTJQZDBaLy8zUjVIR1h2SnhJRjBndlZp?=
 =?utf-8?B?dDExaS9zVEdqZk1WOEc5QTdtcjRGRzdUeXhuRlJLVElseTBBU1NtK0hNUFFG?=
 =?utf-8?B?di9SRE9VQXFuUzdnUHRHbDdpOVhnTEMvVVk1K2JqWGxwaE1jdEFiYWdxRnM1?=
 =?utf-8?B?SHc4RHJHTWM1UU5qaGF3SU0vSVRBTUVsbDA4Wnh6T0YwMnJ6aXRXbWVBUktY?=
 =?utf-8?B?NVFtYmFST0YwcUVra3BkVkJaZVF2SFMrS09pMHIxMGpzaFYySk5wR3lwQ0to?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <618F13ED2FB59540B1198AF6541A2BB3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vS2LJt/AoKjGMZIMWYL09/O1IWybtgbkyFpjPTi/NGxTRza/GyveQ9Pa2E63//a6Vsfgd1S7ASeqEcrDR9UcaNQIkyOJKFHA+XKhYOX2bD7w2lYOdYlZ0cCS3g3HKlEifpVWd263OWRse4eb17dH+KX5P1gcASmo3Pc9OZoTDq6l51BhLI63NjDjpxwzlnvHpogAXYY8V8qlk5U977q0grdEPigASVfbikeUzS7xAU8nCpNVWMrTyh4ILR+ITlNik31brcowZbulZuFNJ3jhK8ZJNSQaVyzHsHUOIHq9BwbOMa1ou3+udzMrYx4CKH/SOTpZhbSNMOfwHh11ZwYC3ilY0LWXMANlnSQhUIgg4Vwcw6svbCAXc/8hdBoRfdNw6BYIYM4Ec8gKSxwN991dcKRlx7sfXRgBGL9FVEZJS6IuCKBIPaO8/4F+6ebLfxBSsFR+j4iC7qyjYx7XQXK23Y8pwnumeJwNEGTMDBskmaliUyo6Qv73ItHUTj4agepJUeoEKgA0Fppc4sb9zPq7jV6M2ddcPMolExLCuju9p8X22yHTF0J4MsOqarbGGgggtYftY303fLb1bigViZ/OKo02CwoyN1dqdZVy3KkQ/Yv1fuUp9JPMVFLBRabzJHnD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979af8e0-8320-4159-a45a-08ddc0694f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 10:54:29.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDV4dCAwK2/YDl3qNa3OPP6bIWDMCUvG915tWGfKXZzA5U1bFdXuPTxgGntXCAe970OXrj36Z7ZthtSgGUWp6Ex0+s0AXGJvOkuotOVe7bQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8897

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


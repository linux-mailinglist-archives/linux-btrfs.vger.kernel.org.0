Return-Path: <linux-btrfs+bounces-19539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E805CA65B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 08:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 856D5308BFF4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 07:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5242F619A;
	Fri,  5 Dec 2025 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pFiF133X";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G2Lj/TH5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE92F5A2E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764918529; cv=fail; b=Jjg0wChhKltOzw7CBlZNsiPZ21pq/1VRzSHQYOmoPOXr0FsAibKwd9cCfy0tNrRshSEkChdjQFRT8kk2cIu3JGq0LduNoFx1SRhYfBHNw2h6cfsoelUOLVrkx/ghOksUbP5Ldgk0SYqCZ852XdHpkSIsMp67yA2H8jAURpGVXDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764918529; c=relaxed/simple;
	bh=SohJ1deW3LWMKmE+q7x4JM+29x+pgSiEHDObNrCFl4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CnEx+q8Dp+n5Gg0yMryWPkw/2dPirfvi0HzBJBrgl7TrppwnnSFbLaRpA5jJU04pNNUs6eYKvWsYNAVW7k1fwgH8z299s3XVEqE4BNCzm/Amy4xaWw0tx8ChRmaGkBfSRoErlgI5Lyx++xkddoj6/ASsM+w3e26AN9aIa8mjA6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pFiF133X; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=G2Lj/TH5; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764918527; x=1796454527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SohJ1deW3LWMKmE+q7x4JM+29x+pgSiEHDObNrCFl4w=;
  b=pFiF133XHRir6Hmrs+xNrrCqjRP6Lpo6fRgZ4F1pPuQrWWEQ+aS2A5cu
   raeBu7V1imgrD7pX2v28dFNm9WcKm+L4Bphvwf0s0g1+zUIPoUhRollNW
   IXlQMjiUvYNGgpOqcR87IAUUVyEPrWulsJZCRohptvjj4slDpWplOTklA
   F5gGjZYvPwFMSfvJ/MhoRZwos1ypW6HK8bS90TvJHlM0dilReLSCcjW1A
   e3rkFMXS+Q1DAaMoaw+jeZMGHZx7XCgk3lth2xfYyBMVs+0eavi4TOdaC
   TjRrVd6TUi2vh3FoJRONh/kiANy6mYS8RnucBIsSh14vI+7veYJVKcn0H
   w==;
X-CSE-ConnectionGUID: aKDtXM94S5KTn0RZtF6ACw==
X-CSE-MsgGUID: tkXjJ0RbSrWsMGhUJXAdMQ==
X-IronPort-AV: E=Sophos;i="6.20,251,1758556800"; 
   d="scan'208";a="137319660"
Received: from mail-westcentralusazon11013057.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.57])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2025 15:08:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAGREUU5+cms94XAb6T992cwYFDg8cF4hY0fXanVYEQ+vpp+j2IGZVM0fDLEPwlWe1EvKEu+ZDDswPMbmKggIwm1xtHjNpFLHn8MYqQ+fcB+BIgoRmFcqcYzUM+SghrauWfJ52KIx587NNZ129KWHSp4GGwRRs1OSvuDeIoNBm7j6CuEu/zLgvWT5YsDI8gDoiMGuONvy+78pmO3QkYpWA/RnWuhnXQq8CWZJlikcrjRaqq3e5aOdVv77ndrzf4OJHS0WjLZNmS+qnYHSL6jQSu21H5Yphk+NgzUtEHZfzD4zABDEobECPbRX2q51IyIN0dsdCSDI7wBJP79lVa+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SohJ1deW3LWMKmE+q7x4JM+29x+pgSiEHDObNrCFl4w=;
 b=HQ4JZLz5ILjVtGQk0PJuP/mNoxav/weG0i2r/Z1M8Ul47/oWnXACAZSNJEihIPgJzv9jGO0JF324OI9Ohjo1HxJbsNiunW9ofgMx4JG9xXThVM2nDVDL/2pzhbmThutC2SjOUKvwm1JlZHl/T4px1nartwGVrRtAGpN8xT11rsAO74y6ozWNsWYDBmJO3Gw7VKLjhF6M4ZGuJoPdP6luNpe9eMfitYHGY6/PdCvuniqPUH1oYdcOCLHw9K4LN6Ii5s7WSsWxUpkjVxzGjy37yrKgtmI7/6oXfigzhtrIy8t9zw1B1FsIDnw3/7W0RHpha2XvWMlXxszaPf/xtVT3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SohJ1deW3LWMKmE+q7x4JM+29x+pgSiEHDObNrCFl4w=;
 b=G2Lj/TH5vQdcVmqjMCtTFHcpqZawX3KUxEKP8e/MDGRTttHOHLKVdYUEJg4RQoVC5gdncZfVIce+IFolUEJCNEvqckaaeE54Kn7Qo97P+5fbzvxyfXsuXziz3EPVvsCrEc1FyWyWNLMPyAta3tivoMBImIIJ5duK+lSJD9NaYfw=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CYYPR04MB9031.namprd04.prod.outlook.com (2603:10b6:930:bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 07:08:41 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 07:08:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v3 2/5] btrfs: move btrfs_bio::csum_search_commit_root
 into flags
Thread-Topic: [PATCH v3 2/5] btrfs: move btrfs_bio::csum_search_commit_root
 into flags
Thread-Index: AQHcZRt6NJ0sNq33702Fpi2BYGH0b7USC7+AgACN3QCAAAfngIAAAD0A
Date: Fri, 5 Dec 2025 07:08:41 +0000
Message-ID: <7d3f18d5-f630-4056-971e-64e221bf6d7f@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
 <20251204124227.431678-3-johannes.thumshirn@wdc.com>
 <35a62029-142b-4882-a238-81baf00f5f1f@suse.com>
 <02f6380c-39d1-4634-b21c-78b81aaacc52@wdc.com>
 <30c4fdb9-2611-4029-b93f-923cfd86155d@suse.com>
In-Reply-To: <30c4fdb9-2611-4029-b93f-923cfd86155d@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CYYPR04MB9031:EE_
x-ms-office365-filtering-correlation-id: ab90ee92-7ef6-4f6a-195e-08de33cd1f2f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWpFSENiOGRPN21GcnNNSWJsQ0NZZERhYWlwV24vSVY4RGFmQ2h4SkhmeDVB?=
 =?utf-8?B?bnczWlhUMnd3bndjbUsrdGRCRXhwckVTVnRmOVVvUmE3akVHODRjRzZZRjJv?=
 =?utf-8?B?cDdROFpLR1B3emYycFE3WTM5d2pLWVdUbU53ZzZZRE9icHZnS0JaeWFwU2dt?=
 =?utf-8?B?Um5lc0w4aTlkWkRkdk9GVDl2WDBUOUI0ZkFqSnFwa25obTcvUW1SOUNkcCtU?=
 =?utf-8?B?UGk0UEFzYmpVQXpHaEkzYTdncWdzUU9PU1p2SDNqa082U3ZHTUhoME5jK1Rt?=
 =?utf-8?B?Zk82eTVSUFhPM3UvbnRzMVZ5dTNZVVlsL1hSSk15blpWbDZnajlraHFQK0d1?=
 =?utf-8?B?bWdZNGlzOEd6K0dNMXJIbm05Y2pHWUkvQ2RJajEyRkxyVjhUMkxua1MwQTZP?=
 =?utf-8?B?aWIyZUlvTnI4K09HMjNIVnJXZ0dtUFBGaXJxQXFNamFSenRCNjBmenk1c29S?=
 =?utf-8?B?SGpFTXR4R1phMmNJSzl4TXRWaVI1VzhSYlU3ZVlZQ1FFMW1DcVdGTVFCVWFB?=
 =?utf-8?B?c3V1VUlMcWc1MzFvRHYyV0VncHJBNGxacnRpY1pQdjZVdjR4VGU2ZEJWaUpo?=
 =?utf-8?B?RW9rVVVvQWxmMk1kdFR1c1pJdWEvb3RPMmdvU0pGZmpRMVVkcTBiUlFwRkxG?=
 =?utf-8?B?UysvSGgvUHF1UURKVjhlU29SSmFMY2hRMDJQTDZkY1d3TmtsMnJ6NU11NU0z?=
 =?utf-8?B?VTUxc3dwenhhZTMyYy9pOXZ2Mjl0V29JdUdmU2ttVEFWUDFWbWt2WmQ2SXF0?=
 =?utf-8?B?ZStoM2wrVWdBaVc3ZS9tS3FHempza2l3K1pGNHZWUDVWUjZpdkNoaU5xNnV1?=
 =?utf-8?B?ZmZVMFo3SW9yajcwU3d1dk0zWVdIRXdxZmJjMU05bGNMdEpIdHNsazZxYmU4?=
 =?utf-8?B?eHZvY3I4a3ZFMG1pbjdyb2REdVgrTmIrVW5nYUl4WEs5MEJnU1F1VDhEYjNi?=
 =?utf-8?B?SnZnaU5SSW5UcTFhcWNYUUdXY2I4TEJBWmc0U0JMMndKSEdadWgvSlM0WWpT?=
 =?utf-8?B?aXZnMU50MHNJRE9DU0s1TE95dmdDaHBPaVhYaWdPRHJRMGpWUW1OQ0lYR2FB?=
 =?utf-8?B?d1Z0Ky91Ry9nTFN3bklvSnhGS2RzY2NENzdWNk0xL2txYlIwQXNRTUE3T3I2?=
 =?utf-8?B?SGFiSWdiaXYrTW1EL3UxSTV0SGUxOEJtZVVJanRLaFVpdTBIcUhNcTJUZGhk?=
 =?utf-8?B?Tnc0RzlBVU5GcS9LLzFXajc3YTBLKzBDenR6Z21RelV1d0pMZTdpR25DT1kx?=
 =?utf-8?B?U2lJNDdhc2JmcmRha3I0aU1xcVlndlpKd2EwTzBSa2RLU1NoR3JWUXhXbzFU?=
 =?utf-8?B?bEtoeUNzZ21RSDl5eC8vS3NORWFxUklGd1NJcDV5YzY3akg4NGowZGpCUThi?=
 =?utf-8?B?K0RqMjZmMERpN3REL0kxUGxuRzZ5eWZybVpUWUZ2UVRVR2pYNWo3SEQyZWpR?=
 =?utf-8?B?b3M0M1I0Q3RraGIwYnVPUEF1Y3V1ZzBHNTBzc3N2dXR0bTVFY2FqVUxCL2hq?=
 =?utf-8?B?TkNTRXZCeHRXdEptaUpmaEFBdk5WbWtVeU95NE0wWFdPUHVReVd1Szh5eXBm?=
 =?utf-8?B?N3R5bXd2VmRjZ0JQdDlSTHZjZDU0TVU1V1BGejhCdGpVdkxxSnhnTmhBZURr?=
 =?utf-8?B?TU5WcVRzd3dmK25FSEprK3J1aWdtc2NMVEVBQVZwYmwzWDZtaHZUNFh6ZkN3?=
 =?utf-8?B?c1BLMHFVeVBlOVVUTVJlc1BJQldyZ2FKaVlJNko1b3ppRnFaeW93S3VPY0or?=
 =?utf-8?B?YW1JMDNvZE9vWVkxdWc0ZWtPaE11SnJtTWV3c1NQQS9ubUhvV2FGWlB1S3Zm?=
 =?utf-8?B?NWJCQnlQNXlWY2pKYVVRaEpOTHJmcitMaXBoVHNVUXRQR2Z4VGozQTVxVTJR?=
 =?utf-8?B?Z2l0ZTBYWjRsQ0ZBSEJvdlZNOFArRW1GVEVoSzY2V3l3T00rT2Jrd3ltUFNG?=
 =?utf-8?B?UmxJemVhOS9FcWNkdUZJc25uL29XQzVMbUF5YXFXdEYxSGhrZ1hlUEgrSm0v?=
 =?utf-8?B?bC9aRVg1Z3djMi9rcVpwU0c4UHhJNzN1bnFRK29NaEgrTDFHa1pwQk51YTBH?=
 =?utf-8?Q?eJOPvA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGZYREE3c1VjbDA3UC96NUg1WTlLN3NWRkpPSGEzU1NrOWttdkZmWFJWV0Fw?=
 =?utf-8?B?L2txZ3FRQUY5a0NuL1lpcHFjTkxZbDRXc2Z2VGpWL1poMGo3TkJTbnp2YWFu?=
 =?utf-8?B?d2g2OHRDdFRCNUxlVXBtdFEzSmxXSWVLbnNIandwUXBVVFdBUi8zR2VacGlL?=
 =?utf-8?B?SFR1VXlGS2x2QllQZmx6Sk1VblYrZXhKeGg3N1JnQ0RrTGxUdVNrZWVFZHVL?=
 =?utf-8?B?U2docWlWcmFCbnZUSjUrdHZDdklGaFk3bDFVajJONXQ5dG5TcnR2MzZ6V0RI?=
 =?utf-8?B?UEt1WUxIQ2lNYW9pOWlaemdQRlY0V0JkMTJHY0RZaDhKSndIV200RGd6aWwr?=
 =?utf-8?B?bUVVc2l5azJpYjhXUjc2NTdjNVkyVXdZRmxmQUJmdXBWcHRIQ3UxSFd1Slly?=
 =?utf-8?B?OW0ybm1qZzBZZHJ0djQzMlBrMmVVZ05iZStGd0lzVlM4MFdiajMrZkIxczYy?=
 =?utf-8?B?QzgzSTV1OWN2cmcwYkpiMG5YY2ZzMytvb1dhSlR3Z2wyNm5hR0VkZGtYNTg1?=
 =?utf-8?B?aXluQ2xUZjZ3Uk1VVk5KcVNtQU9Xd3c4ZndodHJCRDZnbDRYNEtsbmNSQTJ3?=
 =?utf-8?B?YUxWOFVGOWFOc1VCY0pHOUxuQWpSNDcvL1RYTVV5ZEFNLzVlMTJqNnlXazR2?=
 =?utf-8?B?dSszejJORjlnWEN6WVZRNlVtdjE0WmI3VStGSUFGR2NxRzFqQ0ZsWjBGWGJO?=
 =?utf-8?B?SGlrWEF1TXRFaUFpMVhJbExrZkwyL1RRdVVyNDlRQnBtdkNDdFY4OXhjWG9S?=
 =?utf-8?B?VXV1dGdwL2I1TCswMmc5b2hyNGpsMkgvY1c4WVdjT29CVVhRc2V4VTZBa0VZ?=
 =?utf-8?B?WFVkcEl6UEIwRVhYT3FGZ0lHWWxKV0VKVnVhbWxJSFBmUlEydFBjdjFhcXgw?=
 =?utf-8?B?N0tiR2FqaXovQ242a1YveDRIZW9sVnNocnNjemQra2d1Y1ZuUE1Ia21YODNE?=
 =?utf-8?B?Q1hrK2tac0JYQnExemZnRW5nZzJVUkJiOTBoTjd5c0hXUHhQNm1FOHI1ZWNs?=
 =?utf-8?B?WE9HTjRsdGIvRE14RGpyZlpkTmEwQ2ZzUmtvWDFXQ1lPdys4dWhuSWl5cjAv?=
 =?utf-8?B?OVg2bUk4UC9OSnpKN3NoTUJEVGxZSjRzd2ZNdGNtWDhBQVZ0WE90QThnYjRt?=
 =?utf-8?B?VlNZUklvZUNHZ2RhZCthZlJWNHk3OGhDRnlheUpSaVJ2THpWc2ZRaFJvaC8r?=
 =?utf-8?B?N3dHZWxIMHBKdWk1aHVZaFNsanVUd1NGNStHdWpCUTgwNm55aUF6WEJhVTZ0?=
 =?utf-8?B?dUpSRVRvdFl2UTBOMERlVkY3MTJyd2NKbjVZdjAwVDEwUHE4cUphdEUxemFo?=
 =?utf-8?B?L3FzYWhERFo2ZkZBbmZ3K293cVJMandORFJRMDRvclhqWlIyVXFFVzRtbnEw?=
 =?utf-8?B?aXBNdEZSTlpYTU1sdmJYOFE4RndIdXhKOElIa2Y4cnV6ZGo2VWZPSlpQR1hn?=
 =?utf-8?B?cHNSYkIvUTdjeEVocXdIRHZRL1lHd0dzNGJlM0tFVHhNbm81ZmF3L0g2M0l6?=
 =?utf-8?B?Wi9DV3oxM0Q0UkZUdDZ6UUJMY1J1NnJEM0EzT2NqSk9Ma0d3YXVrdXZKUlFk?=
 =?utf-8?B?U0h3NzZyUlFCMi9VK2VpVnk0MmRGNXBvbmhnbFFOYnJYUTREYjBLZHBNeUpG?=
 =?utf-8?B?Vy9RbWpVNnBGcEVWUEZ4T3JpMFJBaGgxcDc2Y3RadElPbHpDMG5MSi9ycjY1?=
 =?utf-8?B?NFlaQU00Q2w4THVTdEhTb3JESEtZRmp1WEtiUzgxVFNWYTdJU3p0YzhYdVcv?=
 =?utf-8?B?M2hQaGgzQzQ1V253MmcxSDB5ODNaNjZqQjQ0REs3bmFFOGFjSU1RR0RPLzlh?=
 =?utf-8?B?cmlpc3RicWNmaHBqWk9qVUJCYU5mTyt6d3VGOUJRYzlaSjIxLzMwenF5dHNB?=
 =?utf-8?B?T1dQT0VadUo0SkRibGRyTlJQRUhxKzMrbnZ5ODlsVEFtRnlzWCt2YW1jSHE2?=
 =?utf-8?B?VGg1bVllTnJJZ1ZiZWt6eHkzVzJLckJtZlNJdUlnTy9TL0tsbFJpK0h0OW5L?=
 =?utf-8?B?QXpDVmNRRERkeDduTzI4ei9PZkJmTjEvb0RUdHlmSXpGbmVVbmJmSXNlYUdG?=
 =?utf-8?B?L1FBZTRiL0wrUDE3NUEyLzRDd2Q4T0ZXS0U3aENwcEkxYW4ybkVpZDg3YXZ6?=
 =?utf-8?B?Y3ZBV016YW9oYXJYTmhVNHFtbDRaU1F1V09Ba1RjZllCbWEzVXpyaTJ5TUdT?=
 =?utf-8?B?cTBsVGRadzcyWUtjekFodDcwOE1FSElVYWc3R1VaRDRUUFFmQmNBVDgrc0Qx?=
 =?utf-8?B?ZFlPcnlJdUcydXgrVE5kOWowb01RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25CD6D55F683EC4A99E5BE63A96AE905@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z1IMnd9ce1jAC/380NY9yIehlPpIYg6DT6x5OBZnt09uJMez9SlrnCLGSNSo1g/Bdi0S0pkzlvtB/pYXopVJiBasn2QkWVBCnEfuKXwQLYnoYrpvrYhyWm7gjfL63M9w1sf+bojv+DSwCn9mYeoJ4/W6W40VGGdC5BOhVpvniRcqmVNyl7hVjg8JV8UCvPMDqDvHQS1ruiECIA02AIIvft/vlTIzb8sn5+oOim7ZtCmN8KwWzhci6vRHHYy+yKS+qZ6oGLrF1vqj6QW5Qo3kbjUsVTuKRm7UKGbBS/7EAO/jVuhub7FjOZ8U3g/STYKroYqNTpiyylavakhRd2pNyD7+P5K2hxw8K8gBH141pciQ34+08CVIP3S52zUsZ3CrhEOaacevTPGQ+hS2t57CZajTlr25BDis/dSb20Fbes80poCJRa/rrcDANqrn6nWnNBIB32/rRhnStiZLfTOPNmJsdqBjkLsgyqhpe/073qHPATAuIXtvWR5PgzevPeat/OGonXh0MXGzMWeL/uIEA31PUXDhq4OyQXthKEIpfVVC0Za9rCFNwntdaCFCONXmP18HfYQGkZjz8g+PqnK23oXxByNt1b6MiyKkwq2y9lwoqW1pmjQV/bmxP8PFzy7c
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab90ee92-7ef6-4f6a-195e-08de33cd1f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 07:08:41.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elWqHci/KCLsYig6fEuZOk1Cb8o+JSZeu4xvdACb3m36H2v2oK0zRpp/h7LaoAbABZc9dC4SUegjscwRHmtqJhO6gxHkZ9vFKEDmAbHnvuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB9031

T24gMTIvNS8yNSA4OjA4IEFNLCBRdSBXZW5ydW8gd3JvdGU6DQo+DQo+IOWcqCAyMDI1LzEyLzUg
MTc6MDksIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBPbiAxMi80LzI1IDExOjEyIFBN
LCBRdSBXZW5ydW8gd3JvdGU6DQo+Pj4gVW5zaWduZWQgaW50IGlzIGEgbGl0dGxlIG92ZXJraWxs
ZWQgaW4gdGhpcyBjYXNlLg0KPj4+IFdlIGhhdmUgYXQgbW9zdCA0IGJpdHMgc28gZmFyLCBidXQg
dW5zaWduZWQgaW50IGlzIHUzMi4NCj4+Pg0KPj4+IEkgdGhpbmsgdXNpbmcgYm9vbCBiaXRmaWVs
ZHMgaXMgbW9yZSBzcGFjZSBlZmZpY2llbnQsIGFuZCB0aGUgYml0ZmllbGRzDQo+Pj4gbWVtYmVy
cyBhcmUgYWxsIHNldCB3aXRob3V0IHJhY2UsIGl0IHNob3VsZCBiZSBzYWZlLg0KPj4+DQo+Pj4g
RnVydGhlcm1vcmUgSSBhbHNvIHRyaWVkIHRvIHJlZHVjZSB0aGUgd2lkdGggb2YgbWlycm9yX251
bSwgd2l0aCBhbGwNCj4+PiB0aG9zZSB3b3JrIGFuZCBwcm9wZXJseSByZS1vcmRlciB0aGUgbWVt
YmVycywgSSBjYW4gcmVkdWNlIDggYnl0ZXMgZnJvbQ0KPj4+IGJ0cmZzX2JpbzoNCj4+Pg0KPj4+
ICAgICAgICAgICAgIH0gX19hdHRyaWJ1dGVfXygoX19hbGlnbmVkX18oOCkpKTsgICAgICAgICAg
ICAgICAvKiAgICAxNiAgIDEyMCAqLw0KPj4+ICAgICAgICAgICAgIC8qIC0tLSBjYWNoZWxpbmUg
MiBib3VuZGFyeSAoMTI4IGJ5dGVzKSB3YXMgOCBieXRlcyBhZ28gLS0tICovDQo+Pj4gICAgICAg
ICAgICAgYnRyZnNfYmlvX2VuZF9pb190ICAgICAgICAgZW5kX2lvOyAgICAgICAgICAgICAgIC8q
ICAgMTM2ICAgICA4ICovDQo+Pj4gICAgICAgICAgICAgdm9pZCAqICAgICAgICAgICAgICAgICAg
ICAgcHJpdmF0ZTsgICAgICAgICAgICAgIC8qICAgMTQ0ICAgICA4ICovDQo+Pj4gICAgICAgICAg
ICAgYXRvbWljX3QgICAgICAgICAgICAgICAgICAgcGVuZGluZ19pb3M7ICAgICAgICAgIC8qICAg
MTUyICAgICA0ICovDQo+Pj4gICAgICAgICAgICAgdTggICAgICAgICAgICAgICAgICAgICAgICAg
bWlycm9yX251bTsgICAgICAgICAgIC8qICAgMTU2ICAgICAxICovDQo+Pj4gICAgICAgICAgICAg
YmxrX3N0YXR1c190ICAgICAgICAgICAgICAgc3RhdHVzOyAgICAgICAgICAgICAgIC8qICAgMTU3
ICAgICAxICovDQo+Pj4gICAgICAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgY3N1
bV9zZWFyY2hfY29tbWl0X3Jvb3Q6MTsgLyogICAxNTg6DQo+Pj4gMCAgMSAqLw0KPj4+ICAgICAg
ICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgICAgIGlzX3NjcnViOjE7ICAgICAgICAgICAv
KiAgIDE1ODogMSAgMSAqLw0KPj4+ICAgICAgICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAg
ICAgIGFzeW5jX2NzdW06MTsgICAgICAgICAvKiAgIDE1ODogMiAgMSAqLw0KPj4+DQo+Pj4gICAg
ICAgICAgICAgLyogWFhYIDUgYml0cyBob2xlLCB0cnkgdG8gcGFjayAqLw0KPj4+ICAgICAgICAg
ICAgIC8qIFhYWCAxIGJ5dGUgaG9sZSwgdHJ5IHRvIHBhY2sgKi8NCj4+Pg0KPj4+ICAgICAgICAg
ICAgIHN0cnVjdCB3b3JrX3N0cnVjdCAgICAgICAgIGVuZF9pb193b3JrOyAgICAgICAgICAvKiAg
IDE2MCAgICAzMiAqLw0KPj4+ICAgICAgICAgICAgIC8qIC0tLSBjYWNoZWxpbmUgMyBib3VuZGFy
eSAoMTkyIGJ5dGVzKSAtLS0gKi8NCj4+PiAgICAgICAgICAgICBzdHJ1Y3QgYmlvICAgICAgICAg
ICAgICAgICBiaW8gX19hdHRyaWJ1dGVfXygoX19hbGlnbmVkX18oOCkpKTsNCj4+PiAvKiAgIDE5
MiAgIDExMiAqLw0KPj4+DQo+Pj4gICAgICAgICAgICAgLyogWFhYIGxhc3Qgc3RydWN0IGhhcyAx
IGhvbGUgKi8NCj4+Pg0KPj4+ICAgICAgICAgICAgIC8qIHNpemU6IDMwNCwgY2FjaGVsaW5lczog
NSwgbWVtYmVyczogMTMgKi8NCj4+Pg0KPj4+IFRoZSBvbGQgc2l6ZSBpcyAzMTIsIHNvIGEgOCBi
eXRlcyBpbXByb3ZlbWVudCBvbiB0aGUgc2l6ZSBvZiBidHJmc19iaW8uDQo+PiBUaGF0J3MgZGVm
aW5pdGVseSBtb3JlIHRoZSBraW5kIG9mIGltcHJvdmVtZW50IGV4cGVjdGVkLCBjYW4geW91IHNl
bmQgYQ0KPj4gcGF0Y2ggZm9yIGl0PyBNZWFud2hpbGUgSSd2ZSBwdXNoZWQgMS81IHRvIGZvci1u
ZXh0Lg0KPj4NCj4gU3VyZSwgYWZ0ZXIgeW91Lg0KQWxyZWFkeSBwdXNoZWQuDQo=


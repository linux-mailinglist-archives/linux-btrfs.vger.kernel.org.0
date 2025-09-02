Return-Path: <linux-btrfs+bounces-16585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AC9B3FB96
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 12:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6EB3B5BAB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C02ED84F;
	Tue,  2 Sep 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lMXenn5L";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MMQGOg44"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6C8F49
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807165; cv=fail; b=XdAIpj1owTrg3cXYEjoglTH6S2z4SpwVh5D75ASt1b+wycAvXGkxSEGbSV4GmeENRkoSVKXpvMsrKQlXdUR9J7cWqWvlZexrqG8p1a/YgWu1+2/HJnnpiHVSNKxiYbuM+w37AJqy8A1btZbu9JzUjuigPKnqGi5Z7bEh2Sh2g9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807165; c=relaxed/simple;
	bh=VtzvwsGbZO6w25uWEuKFnyngElfEACAj/LrIS2C0SnY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b5mqv8Y2DeYYTR/1en8mu2xB/d8nYilfmpDrBpYC1UxmMIcOzLP5Vlrfx99ScQwqJOGmehYPEgUDr/4TtSIgpKOLeUHfM9ViqiEQVbz14AQK3eA1PmHzqsJCBxuxEw1OF5+vYO+i+j2N73YwQOsEdXZdC8J69247GkXfzJUKXeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lMXenn5L; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MMQGOg44; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756807163; x=1788343163;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=VtzvwsGbZO6w25uWEuKFnyngElfEACAj/LrIS2C0SnY=;
  b=lMXenn5LbADgzLfLWTkVNCqqRUPkfbTaGH5rsFqbuXMYNF5aSBKIwAl4
   oVCvmzao0ldjD4zN2+yylo1AWk3SErZj6xq8jx4rJZPv2/SohdFDiZRoB
   WoVCnnyEvR3QzOqwKX1Qc+NuseM3Gp+blT1hrsOaf4coS6K+p7U01o6Gj
   /Bm/jC4TazOhta1qTrXlp9gZyxRiMi0zA7/47KHcrPdrAaPnV+f/S0b4f
   7Oaiuk35+71UwBWLqrt737fgzkaUEy20+q+4FVgfs/ShhO92HuryQPrLV
   OH6Tbcm/ny+s8bf0JHkxigtzxylEBAhgG24q36mZ9FsyC0UILCoQAJX9+
   Q==;
X-CSE-ConnectionGUID: Av3v+LzgR8aVjR4hDmjWTQ==
X-CSE-MsgGUID: buvi3AtHTLmTMMAMRCkGWA==
X-IronPort-AV: E=Sophos;i="6.18,230,1751212800"; 
   d="scan'208";a="106442107"
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.63])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2025 17:59:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTFaHHCdS4+He2gW7Qe0e/8X4KXgqWB8cBPtAUbwS95zX4uKBSMggCNt1NdZM/gtJOJn539BKPtcORp+XbFxuzMpImnOIx+uYaUAM3ki6JK8+03ViI8ZjhfToBZ+48hC0Y8zXbXtHSMI2PZgc/oxMOaKK9eK4t1Wy5p9vSufaH5zlpdUvnQbc0dCn1V6HyVTyVXzU39La9gyaoo9fPgV01q+p6MZZVsXfijGL7565b2Fo8LmeJyX593CzQhRQAwfx4E2I8WXgfUW+i3kijE4QxIaS3FdpZPzGI0+rUoC9/7kBjBtOQ1Q0hJlxdFibO9jRQsZaZ4xoMCXRdPwYBSNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtzvwsGbZO6w25uWEuKFnyngElfEACAj/LrIS2C0SnY=;
 b=XqSlt9CV6a/zS7i+m+a5tPiW187qiJRd0zAwNepXbBwZ6+H/E3xNGPAsNyO4aAlHQ/UKFRv4aHNuv5YRjKMyG2viIzrsGHTLkW8dQ2xip7O7YCY9pbT+rms2CbK2VZ2YrcVg7sWnbywCKpl0A3XdvUMLFuK2GyJdTeCWSvvlvlD0mLotXH8JIkXtiwU4kr5YDEjogHSMIhQm7nvkD87jsbm3b1BKxhsWw6OGTeCHut9rUxHTHgJJqjaHhuWTLzOT0pJ/Yn6f/9iHnyQxZilNBNxupsA2+CyjFejaIxxWT1n2qp88pibzG71rQ7kpvFRHr7xPJ4jfPrMT/ejJBCVOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtzvwsGbZO6w25uWEuKFnyngElfEACAj/LrIS2C0SnY=;
 b=MMQGOg44AOZGq2k3d/z7KZkxLGdyTEZWs4XtiMQOlp0ku9oOO2IzK6/BDwRIINwxXT6Yw9u93IJy5IeY9W/LTtbucU8p4xbituYJQZ7MBidl5EEEArN2Fi5CQZVWkQSr2RGrxAqttb33TWE2xYfkGNVQsob+3FK2VNsvZ0B6pb8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7901.namprd04.prod.outlook.com (2603:10b6:a03:305::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 09:59:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 09:59:20 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs-progs: tests: add new mkfs test for zoned
 device
Thread-Topic: [PATCH 3/3] btrfs-progs: tests: add new mkfs test for zoned
 device
Thread-Index: AQHcG8JSOgDtZ2a8yEKUq1CjnqrIpbR/qPwA
Date: Tue, 2 Sep 2025 09:59:20 +0000
Message-ID: <381793b8-e35a-4b4d-965f-8f78cdcde8a3@wdc.com>
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
 <20250902042920.4039355-4-naohiro.aota@wdc.com>
In-Reply-To: <20250902042920.4039355-4-naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7901:EE_
x-ms-office365-filtering-correlation-id: 6b0868d9-0f14-48c7-9b44-08ddea07631a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2dwSXY1RnI2Qkxkb3BxVDBieXcwbEZoVWgwZlhaek5Lek4wSUVodFRBQ1pE?=
 =?utf-8?B?ak4zTktiMVRNNlg0ZmlxNVdWSFVmcEYyaHYxcC9FWU1BS1pVQjM4dlZVdHNR?=
 =?utf-8?B?K3F1Y3pKUlJDTWpZZEsyMHlacm9XVVRnU08xTTlYaHBUb28ySWJONTFVaXRr?=
 =?utf-8?B?MDd5bWRIdXNMZkNyYjVlT0lPTGV0TkpqUk9yZGVuYzhpUFkwdHZodFlseXlN?=
 =?utf-8?B?VFhWTWk3OFA3bHVwODY2T3VDZG9FcDdMTXVscGpXdEVPR29zSXdJcnZxNzZY?=
 =?utf-8?B?RzVkQVYvR0N5aFhiVXVUanZBLzg5OGV0MEJpSGtoOU10UWczVkc2Z0VmZjVK?=
 =?utf-8?B?M2VQNUpBY3dHVlFjaWFpYzR1VkQ4Y0pQN1d5TjB6b1dleFV1MmFEWWIyK2FD?=
 =?utf-8?B?RnRyUWplN216YlBycGdDK2FsK2R6S3dBU3Mzb010WWZWYWhZR0NtTUhidDNL?=
 =?utf-8?B?bnV6ZEE1cXBKS0RYeXh5RU1vK1lZQXlidFJKYnJ2RTZqMzFEeENYdWdMa0tl?=
 =?utf-8?B?MlE3R1o1TTJxS25IVUlUNjhRVkU5RUVMK2JGWW5kY0J3a1c1VExRK3Nsc3g0?=
 =?utf-8?B?RkFYNkFwMkZ5Y29FYzMySHNrZ2hRRDRyQmtXSXl3SENuQUZtRHgydGllOVlX?=
 =?utf-8?B?THZEaURKR2x0Z3Q1cHc2QnJOcWtkZmFpNHkvTWVnU2g1WHpXYnB2WHZ0a2Ey?=
 =?utf-8?B?VjNWWTRFMTJMQ05wRFlraGNhdGphYVQ2Ymh4Q01ncEppWWliQjJIN29BWkpk?=
 =?utf-8?B?ZXZPQk5zWWwxVzVXRnRoZnpqTFFoZEhGenNJVGZPTExDTVRCeGtPSXlac1pj?=
 =?utf-8?B?WDJTRHNHS3VHOUc0VG9HdWxGRzQraklsWEFOSjFDd0Fmbk53Wk9tV1hKOHpx?=
 =?utf-8?B?dEhjR0VOR204cTdQQ1RKaXpMZG1nWEN0RTdPMTVSWGo5aXhrdktveU1hbmYx?=
 =?utf-8?B?Vi9Cdm8yeENkdlhCdlo0UzNFMDM4STNvTHBXT2RDKzJzN1BaT1hDeFBtZnhM?=
 =?utf-8?B?YzJON0RhVDBZNmVYNjNqU1F2bHY2dmNLaWgrYTl3WEh0OFdLbWpFVGo5WlA3?=
 =?utf-8?B?SmpWaGZsMjRreHg5YTUzWHhlWHoxMUs5R0wxZll1QTdkempMTUhBMFFCWTJh?=
 =?utf-8?B?VXZvU0dOUDBjamorSExCZFhpamYzV2ZhWWJwaGRqTC9rQjVCNEpCU2owUG9p?=
 =?utf-8?B?MGRLVzI2bXA0b0lBSXpTMmxtWEJISy92V1VBelFKdE9DODA5UVhsWllObGpR?=
 =?utf-8?B?UjhKdWdsT0hRVDdhSDJUZXF3Vjh4SVNpanRJdkFyc1ZNUUxNcG5YMm5LZmpC?=
 =?utf-8?B?b3UxRFJCUFpNa2tueDMvaHp4UUZMa2RJVldxWGd2MmFUNGk0Q2M0eFpQZHhh?=
 =?utf-8?B?TkJST1BGcnRwUlBPbmJxWEEwY3BtOTJYNlJVSzJRQ0NjVTl4M29IUXY2ejk0?=
 =?utf-8?B?ZmduWmR3V1FZVWdxYWtPc0tYemltc1BmTmRCQVU4Qld6dENDRS9NdS92VlR0?=
 =?utf-8?B?cGVuVE9BYXR0dXlNTlVYRnIwSUxpL29Vc2toMmt3V0RSQjMxdWJIbmRFQjJz?=
 =?utf-8?B?WlgyVXdJQzZjWERhUnpEbTlrMkl3QWo0WGowSWVZWEVZOUZoOE0zd2JhQ0k1?=
 =?utf-8?B?SHRVV3ovQ1lwcnoxd2lXbFk5WU9aRGVmUVJmRFN5aWRWdmxkeGFmWTVKRzF5?=
 =?utf-8?B?c2VWWTZwaFZ6WDhiRmgxTlcrTFFLdC92UHVRZmd5TFlpek9ybVIzOXM2eXlL?=
 =?utf-8?B?UTU3RVY0MjRmNnROY0xkRENrT2VSWWo1bkFGSUJEdS9KbCtGNGk0TDh5WUdP?=
 =?utf-8?B?MjlDQWR6SlpIV3FaVFkrb0x1OWF4YVVDMFpsSWthdUt4dTJkc01mbDZFc2Uy?=
 =?utf-8?B?VjZad2hkNXU3SGpxRllsRE5aQWdkemJiQTVwT01QeXMxdEpVc3JRWGZOdUxo?=
 =?utf-8?B?UTQ5a0tqZHhsdHJYTFZpZ1hFNWc2YlRocjRGdGlCVGxaQ2hLSzBKZGg0N05M?=
 =?utf-8?B?b1EvblhFNld3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU1JT0pzSXZsaHcvWWVIOEZrZk1lZnZ4cjhhdnJtdjMvT3UvV2kyT0pTYStO?=
 =?utf-8?B?WlpneHloZTVBbmxIY1hyelorZGxxbHdVOUF2WFduME5GZExkWkY0Y0JqaVRp?=
 =?utf-8?B?d2JhOE1sb3BZcEdRWWVjaWVwVUgwWW02c3ZXY1g2Yjh4L0hpRjM1RnhyeDBN?=
 =?utf-8?B?OHhKU2tJajcyYm9aNEZML2dDcFQrVzAzaWlPZXhqd3R5NVhIZTV4V2NvMHBx?=
 =?utf-8?B?NzFRVkQzbllvS1NmYUhwaUxTZ1J0dUxzTVB2Yy92eUNqdnNoTS90U2pRSDhw?=
 =?utf-8?B?R1lMQ1V4cGJPU0NTbTJwRXRudHo3L0JHWWt2V2gwOThWcGV4VE94d3lzY2ZR?=
 =?utf-8?B?akI0SlVBOTlwYVpqeUxJOGYrOC9rZ3dsQ3RvMGxMNzVkV1NJNGI1K0hxb2tR?=
 =?utf-8?B?V0crSnFLUU5MdWtOQ2R3dHBZYUxvSWMrV1l0TlA2VC9VZTRWVXNsVjJMcUJW?=
 =?utf-8?B?Ti9BaitLVlZaUU5pcnRkQnVmeHl1RHlCTFpWS1pHR3liZUs3eTlKd1BTSmxy?=
 =?utf-8?B?VzRnUUZDUzdQc2hyZG1vQUtzeS9RMk1ac2ZEYUxVWG9rYm1xNFJBajZVQ3Ux?=
 =?utf-8?B?THMrNDVjR2pjUlc5WmJlY2taamRLUTNNTmJ4WlpnQ1VWQ3NZRVQxVEVtVS9J?=
 =?utf-8?B?K01GKzYzU21lRHJPYXBiVnhkQWdLVS8xazFhRDJpdk9QekwycEhSOFZ4MW5L?=
 =?utf-8?B?VVI1cDNPam5UNDZ6K2tudGpJMlBkZzF5QnNmM3pESWhFNFJhK1hMRGhScG01?=
 =?utf-8?B?T3NaekJuN3Q1Z2pXTE1WalJTU1Z1eFRVcVlnNUwwS0FqaEQreWhaaklBb2Nz?=
 =?utf-8?B?VWdPM2ZUbFFWcHNjeEt4bUdEZ3A4VllXaW9kS2x2QVpRUVNwWnpSekRvY0N3?=
 =?utf-8?B?azZ0dG1ZY0VNcFpIWXBGcTAwZHRsb0Q4NWRsZ3VMendqTjZtOGVqdmV5dGtS?=
 =?utf-8?B?RjI2WU84dFdBTEx1RGNjSmNQT1lQN2pScGtQY2VhSkpZWU1pTGE3bk0zREcx?=
 =?utf-8?B?TVhDTThtaU03bFZDcGszTEJZTUFoRFBJSXNqd0MrU1dBVHhsQnBwSGdtYzBy?=
 =?utf-8?B?WEVTNmx0a0o3NUFnR0dVTlk4MUNkYWZNRCt3ZnlLeGpadWtqY3pjZkx0VjFn?=
 =?utf-8?B?S2RZaW5jVmR2c0owdnQyVjZSb2ZWeDZDbU50dmdCRVE1NUtKNWlHSUk2U3Jo?=
 =?utf-8?B?YWxQZWtVUDd4dFAycHR4TzFtaUlNRjdMTVFzY2l1dXhOcnI1U0N0MzhzRzZm?=
 =?utf-8?B?bDhuYWxuRGdqc2xIWC9MMTU4TVhGSjErM3NvdnBnM3p0UUppNjZpdy9OOFVO?=
 =?utf-8?B?Sjd2bE1rNXNyMVpMenZhdG5HZ20xdDZEeVhucnZ1czBMcTUwdjIwQmovc0VO?=
 =?utf-8?B?NVhZS3ZDWVR6YVpCcnQ4ZDUxbE5lYitUVkJWakRkMXRoYzkyTGl2M3doUVpv?=
 =?utf-8?B?U0E3VTV0ZFZ1Y2o0V2t0NVp1QnF6bHUwaDdFbUcyM2xzSGcxRDQrVHFXOVJC?=
 =?utf-8?B?UHRmWVJiQy8wdW04UUxTVTVjN1FQNVZhUWNhemRHMHlEWFBZYlYxaXVnT0Nl?=
 =?utf-8?B?TzVQUVdOYUYxcHYxOGEvTkMwcWlSRG5GdkdwdFlSTzhwdnNLaC9mK25RdWNn?=
 =?utf-8?B?MnF1ck9CQmFxRDM1SnFpajg0c3AwUjFzTTBUMlZRTXFlM2FPb2doTDVzbGZK?=
 =?utf-8?B?RHJjOVkzYTlIL20rSGJFRlBTZ3VaSE8rRHV5UjVEMktLaSs1NjlWOXIvTEVZ?=
 =?utf-8?B?UXBlQlY5anY0b1JUSS8wTFJOQjNTU2RaZ3cyUHZhSGRvdzVVYnZtdjQyU3RQ?=
 =?utf-8?B?VDBkNjkzUWZpbHZPNHNFYXB0Q2JnYjUxazVLdUZmcE1FeWZNNlYreGJVSWdS?=
 =?utf-8?B?cFViWjR0SktvMHJPZXJRaGpmR2lCZ3cyWUdWQk1JSzFuQXE2R3hBZEcyMjdY?=
 =?utf-8?B?ZmVtRWxEdlY4eXp0WVkxNVlqbW1IYVArbjRoOThTOGE4cGYwWXEwQk9VSUc3?=
 =?utf-8?B?NU01THQ5U0M1YVhxREVIdFFYdDVSRlZoNWpyVXgzOXpSVGRWK3oxYi9ia1cz?=
 =?utf-8?B?NHBsVVZuazVtVGdQT2xTOG5LeUJ3SkJ6STgvUTBLcjErWlFCUmM5NFJOWHFW?=
 =?utf-8?B?Wm43NERXM09zZWtJWjc0eS9YVzVneEtnRFdGb1F2Q21qeFZvK3djcWdzMG81?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96CD3625F0909E478775BB4D85EABC42@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3BcHlDufNU9/WgpySv5oh0JWyNFKYjBQs6G9bW/DDcwYFUzkm3slSQnGbmBVdz3Q6gDHvGeVY7sSKBcTp0WizXqAEKKKCtpVfPPUrjmXo7kzIPRCCQpKQwRWS6AP8J//sWNjR5+BdtncQ3e3OJKdmAK78dfGLzdqLFMWbyVqRk0mGjqxFv1enLaMWQeEDrOvwDlNLFyXzPI6CjMN8OdCUShE+qj3oTT5WPUWX3/H/d8fF/uFaKtjhMrUngagtVoljyotKPZKejyjzn9YZUinr4V2QT4tHkYyVPRZobK/Ot3QYDOIimWwZap/UT0b35LRueIWzO+q0rMXiAapdCVgHi1RaxdypFVuu/zJ9RygNlsrnQ/Ec5m0eg+YWUu0zQskQ2HF6by27VDvfl7s/L9anGWZY6xQ+t/oJAaFpmltrSbNgZcl2JOT3KeHBvdgCyjatTERW4zXW/NMpJX8WXwxL5n2Qj5v84tDraVvFi93WMgBrNFisx60XBGrFRyTTf1aeV3z4OU8NkB3hp6C3NYTAPz6r1XWSa1QfQVz6L40IwruATK+E7Xxhkk70IClLEWXoB7O2Et4wsKbr6CGAnzwGwfCz0J6TJGaDGH0Dw2NYWvdoyC73IRJ6sBVDkQXocaY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0868d9-0f14-48c7-9b44-08ddea07631a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 09:59:20.4679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmipLKj8aZFwONyw8UaoIzFwKVzBD+zB01APsl0nPF5uVNr+CSVkhmVB6Z3NjmZRGZYPVT45gbhPsLElwQqKfIcwdZLmRWA9Y/gEvTAeWVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7901

T24gOS8yLzI1IDY6MzAgQU0sIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gK2lmIFsgLWYgIi9zeXMv
ZnMvYnRyZnMvZmVhdHVyZXMvcmFpZF9zdHJpcGVfdHJlZSIgXTsgdGhlbg0KPiArCXRlc3RfbWtm
c19zaW5nbGUgIC1kICBkdXAgICAgIC1tICBzaW5nbGUNCj4gKwl0ZXN0X21rZnNfc2luZ2xlICAt
ZCAgZHVwICAgICAtbSAgZHVwDQo+ICsNCj4gKwl0ZXN0X21rZnNfbXVsdGkgICAtZCAgcmFpZDAg
ICAtbSAgcmFpZDANCj4gKwl0ZXN0X21rZnNfbXVsdGkgICAtZCAgcmFpZDEgICAtbSAgcmFpZDEN
Cj4gKwl0ZXN0X21rZnNfbXVsdGkgICAtZCAgcmFpZDEwICAtbSAgcmFpZDEwDQo+ICsJIyBSQUlE
NS82IGFyZSBub3QgeWV0IHN1cHBvcnRlZC4NCj4gKwkjIHRlc3RfbWtmc19tdWx0aSAgIC1kICBy
YWlkNSAgIC1tICByYWlkNQ0KPiArCSMgdGVzdF9ta2ZzX211bHRpICAgLWQgIHJhaWQ2ICAgLW0g
IHJhaWQ2DQo+ICsJdGVzdF9ta2ZzX211bHRpICAgLWQgIGR1cCAgICAgLW0gIGR1cA0KPiArDQo+
ICsJaWYgWyAtZiAiL3N5cy9mcy9idHJmcy9mZWF0dXJlcy9yYWlkMWMzNCIgXTsgdGhlbg0KPiAr
CQl0ZXN0X21rZnNfbXVsdGkgICAtZCAgcmFpZDFjMyAtbSAgcmFpZDFjMw0KPiArCQl0ZXN0X21r
ZnNfbXVsdGkgICAtZCAgcmFpZDFjNCAtbSAgcmFpZDFjNA0KPiArCWVsc2UNCj4gKwkJX2xvZyAi
c2tpcCBtb3VudCB0ZXN0LCBtaXNzaW5nIHN1cHBvcnQgZm9yIHJhaWQxYzM0Ig0KPiArCQl0ZXN0
X2RvX21rZnMgLWQgcmFpZDFjMyAtbSByYWlkMWMzICR7bnVsbGJfZGV2c1tAXX0NCj4gKwkJdGVz
dF9kb19ta2ZzIC1kIHJhaWQxYzQgLW0gcmFpZDFjNCAke251bGxiX2RldnNbQF19DQo+ICsJZmkN
Cj4gKw0KPiArCSMgTm9uLXN0YW5kYXJkIHByb2ZpbGUvZGV2aWNlIGNvbWJpbmF0aW9ucw0KPiAr
DQo+ICsJIyBTaW5nbGUgZGV2aWNlIHJhaWQwLCB0d28gZGV2aWNlIHJhaWQxMCAoc2ltcGxlIG1v
dW50IHdvcmtzIG9uIG9sZGVyIGtlcm5lbHMgdG9vKQ0KPiArCXRlc3RfZG9fbWtmcyAtZCByYWlk
MCAtbSByYWlkMCAiJGRldjEiDQo+ICsJdGVzdF9nZXRfaW5mbw0KPiArCXRlc3RfZG9fbWtmcyAt
ZCByYWlkMTAgLW0gcmFpZDEwICIke251bGxiX2RldnNbMV19IiAiJHtudWxsYl9kZXZzWzJdfSIN
Cj4gKwl0ZXN0X2dldF9pbmZvDQo+ICtmaQ0KV291bGRuJ3QgdGhpcyBuZWVkIHRvIGNoZWNrIGlm
IG1rZnMuYnRyZnMgc3VwcG9ydHMgIi1PIHJhaWQtc3RyaXBlLXRyZWUiIA0KYXMgd2VsbD8NCg==


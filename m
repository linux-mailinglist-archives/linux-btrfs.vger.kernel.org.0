Return-Path: <linux-btrfs+bounces-19819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B79DFCC6496
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 07:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C70CF304A8C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 06:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5522821FF2A;
	Wed, 17 Dec 2025 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dlki9Cn9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ir6yzcLw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3527E077
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765954021; cv=fail; b=UiVhe7Fi0lyisPIZ+Dg/3BWtnILlU61J+b+7yMGU/zC6SmCA9BIbT0tnEgef1Uc05RYev6lXOU4zbIH6P/OoWIgzHG7daiN+PmaHIfjiz3ngc85Ty9+pPebmNrQ/4z2mpVDvI972hlrwIBA1mmcZhc9RPQF1lrBSF6R9W6FtJIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765954021; c=relaxed/simple;
	bh=8SXlY4QMX5Px/eorcFy0HTVMN0I9bMhqGaeLdkPNIQY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u0aOE+kCs5tcQ3zzsnpyr8zt6kXQqQ5RcmPCb/8cgy8ofNPvPPgIJ/d+vNaEe5Rk8Wx+9YJbqvacgaIzmQ71f8n5IOnHBAzvF7pEMs5I511lftDdYMlXv/UBigG9K9wRkRQlcsu5KGaYLu4fCAMaVaBhtolybAtNouwD/eAgYUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dlki9Cn9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ir6yzcLw; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765954016; x=1797490016;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=8SXlY4QMX5Px/eorcFy0HTVMN0I9bMhqGaeLdkPNIQY=;
  b=dlki9Cn9siAKgfTl8RTZqu6jkEbbK43Z0tAAJ8HbIby7SA+A+WyZHcaE
   hxGv+pHpmHXKqM6/t9sgfHVbFmsfcXloCkmqBmdlHjKePFA6BPgXP5cFf
   8ARadRA2L94sxQtELBrckw8Uuj3leP5z/VKpP/CNybyDQkyyOvn8LcuCp
   FnB9GdfHezZRKqIbDeZ6oEU91Y3nUTKHPKeTKskHbBqpV4tlXZDLLluW4
   txeQxBq+uIv9dvLhA1Cufx7Boem23ngZo8l3woIg35uqk/2g2zHurfHLD
   CDRzkEDSOZ4TtrjwLuNiATvrI8hadsGdQJQMsR8P1RHsKpa9YMOI7g9Hi
   w==;
X-CSE-ConnectionGUID: 1laMpyRIQweFR6fujEtgqw==
X-CSE-MsgGUID: ZF+hVSCBQrKRugkzkZkJUg==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="136671823"
Received: from mail-westus2azon11010037.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.37])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 14:46:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZvmZ9QE+KcLpxtqLoX7+QDhf4lYM6OIueUQsw8XwfGV8Ob0V6WTa6eeGOxQSFjaOmv0XYdDCm4hSCada7E8T04KIH4TUPzpgMuU6UCo0r9mkxaVibjRROSj8uCqRhEzdpacuekhs3vEu6fS65Wo+PuSqCIkv8ua3YWS8AFHOYV8kJPr/0Y3dHLUDoBM8jkcANHbhOVdC6Z2DdL1x1w8VafWcFuNI5UUxFMN4RHU1k8XRFRuTz7qn34irmA+Ha5EU9RhEeYLUT9/z9UOEFHIjSxViS3KqeC1Y2dKuNiWR1M3NCqyYyLtWhSDF5a/nXG7dLQjcEXtt1ZNi9Uc/9IuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SXlY4QMX5Px/eorcFy0HTVMN0I9bMhqGaeLdkPNIQY=;
 b=SImHRJCYqmyr4YFsaSzVzJusISx8A6rZZLbb/en0GxwCDBQylZu3HeKF4XAAyeqE7sHve5i6I/6t9gxoWRQZyS+3liaK4zT04Sm6tyx8mTs+X4DnyNNJNGM+vEQKGggnbIAPXiX4VB6Olly+YB1MuMokvG/cxazM10gKGLnqFuDZl92c2PBh/Z53XH8dXw09qoY/+pWD7pPyD/ZMPmh1Tk4dcL0RWlMa3WXqP3JWyd+jpgT0rL3oxm9X8qYC6im94O4w6RIbUjvbq8Mmw/egMZKqqSticBbU0LSl9ZJgSoST4jNvrMvPS+emEhgTuhCteyE8ALv9Jhcg5GqOpf1/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SXlY4QMX5Px/eorcFy0HTVMN0I9bMhqGaeLdkPNIQY=;
 b=ir6yzcLwzm9ryL43Q1NZ/V6VII43fjHXDBMH5BvNnQ95ZBOAVGcaLo+V+LWPm/HeyAAtAEOi2gAWaDV5rHvB9HQ2SqwziMUyTUzMHorbGMsOZdkhnz8YXJMWTDY6Fp79UiRAbymkwIh5gka3re1NId+51FgHYcQi5UhmKEZuwlo=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH3PR04MB8971.namprd04.prod.outlook.com (2603:10b6:610:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 06:46:45 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 06:46:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: don't call btrfs_handle_fs_error() in
 qgroup_account_snapshot()
Thread-Topic: [PATCH] btrfs: don't call btrfs_handle_fs_error() in
 qgroup_account_snapshot()
Thread-Index: AQHcbqoLFO0ey/MJykWKUW6YgYs2FrUlZHwA
Date: Wed, 17 Dec 2025 06:46:45 +0000
Message-ID: <820cbef5-5da7-4890-aaa5-c7038e742f36@wdc.com>
References:
 <3f4e9ac4d131ffec15e9fadfd97365569aad8a42.1765902874.git.fdmanana@suse.com>
In-Reply-To:
 <3f4e9ac4d131ffec15e9fadfd97365569aad8a42.1765902874.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH3PR04MB8971:EE_
x-ms-office365-filtering-correlation-id: 6fdfa003-cd41-4ee5-fca6-08de3d380b57
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|10070799003|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEgvVFo1U0thTUl4SEpPRlpNMjVDNndSaE5EQ1o3ZGR4eEVUTTFtSjY0REdn?=
 =?utf-8?B?MUlwVlBCM1VGalcrRFBZZWpHOThnU0Y0cDNhdk9tQTZmTExmSDBtOHRLSmpT?=
 =?utf-8?B?YmNiSWtPbDQvN2FIU2dDMk9ZNDNTZWlDL1BrdS80U2FiQVdRZHRSb1VRTmFJ?=
 =?utf-8?B?LzhXdklQOE5uSXRVK3VvalhrYmN0QUs1VkNoL2lkSHBEY2JQMkluRVlOM3cz?=
 =?utf-8?B?M1hJZzRjZk4rby9nTVNaeVMyTXVGYTc4QXZuaXVkUEdnMGFkQWIzbVZqVnF3?=
 =?utf-8?B?UG4rSDZlaHQ0OVdXSnk5bEdJUXFWcE92cVBvZHBEbTRaL1ZaRktSMlRrQlhv?=
 =?utf-8?B?bDBoQUFLbFNCMjlLd0pXSkVCTTYzRHZ6SlZjd2xVSitxQ2VRbmJNZFg3ak9j?=
 =?utf-8?B?d3hQTnJuMDlGc3l6cFBHeUJsaXJBaWdrMHVjbkdOcnNQcnlLc0xGQTFzaFBH?=
 =?utf-8?B?OENUN1VxSE1sdzY5RlF6eGgvVVhka3NIY29jMklVZGZRdGwzSXNRS3Q3NkpP?=
 =?utf-8?B?ekV6NHZPdnY4WkV1REZCT01tKzVlTWY2U0ZjMDVBK2kvR3NHVnJ5cWNLTHc3?=
 =?utf-8?B?R1dzQm01c0dSRThrWE5SWW5hM1hkdXorVHByQm5JTWxYNDBkUWtLYlNRZi9X?=
 =?utf-8?B?MGZwbEJiSmUrRVJwWmVkV1VDdDZIbitJR1lscy9VSytWYjJSTmZGTkdya3I2?=
 =?utf-8?B?c3JQQXYxRmEwaGNoMlRmZVBxWng3RFdjMWtYSDdzWFpqT0xvaHJYNXNzVTcx?=
 =?utf-8?B?UkUvUHdwSS9WTm9iMXZ3VFRhdVJ3aUgzNFAyZ3gvMHkrVGYrN0YvYVcySGJT?=
 =?utf-8?B?Y043MnZBSllmWWpKOGIrQWo4dnRWUTFDV1RGWVIwd3JIWGdlV2ZCaVU5a2JT?=
 =?utf-8?B?WWNNTDRHdE5JOWxTRFQ3d0VXS0VCS2hkK2NxRVNOYjhTMFJubU02MklBT2lp?=
 =?utf-8?B?V0l1VVVtNEg1OFpZVksrbldnQUxabmVUNWExbmFtUE56WUlPY0xINy9TT2lu?=
 =?utf-8?B?VWR6RmVxMUpDQTVYZzVKQnlSQ3k3SHplRWY1MUkzQ09zaVgrY0c1WHRUemhE?=
 =?utf-8?B?VVhxbGI0dEZhNkVPNzdqTlpvUmJ2ZExnb2xBU1l3NFhxSFhIS0dsS2xCdDZo?=
 =?utf-8?B?cW5TektFWHJaQ3JkaUFUSHRBZkhhZ2xrQVVWQncwYWRtd1FXL3FWbFpKUjVG?=
 =?utf-8?B?R0lyWk14SUxwVHNkT3pzZTVUNVNZRWtETlo3bE8rb3hoa0NZZnJPSWNnMUp6?=
 =?utf-8?B?OE1uU3RqTktuZ1lJQ3JaZGo5MWFla1k5V0E3b3FiS0crQnZhZHVyZmpYVlFi?=
 =?utf-8?B?N0tzZkFpR081cExaWXJNdDk1T0VFZUNMYW9Nc2JDZW1TL1BGRzZtREEyc3BO?=
 =?utf-8?B?MEFyZnBzLzhGSnVobkZiZzNtK21sTENtK1ZrdVdZRjRXL2xaNTBZbDlsOHhC?=
 =?utf-8?B?QjhmTWdneGpybHJsRnMrV0NsUDBGampZcFQ5WWN0UFlsc1duV3UrNjEwdVNo?=
 =?utf-8?B?MnlzZ21SZmpoSG01L0NDLzUwbzFJVWVSUFFCUzFDb1UwdklremJ1aXZ4YmJO?=
 =?utf-8?B?bEpGWVo5U2p5TjZzYzZ6VWQ4MWVxZk5qYWllMkh2YTFWZW1NU1o3bWlCaDFo?=
 =?utf-8?B?dFFiaGNFUWE5Yi9LMDM3c2trRzZUWnI3T1ZveDNGYk1ZaE5nZm51OUcrTTV5?=
 =?utf-8?B?dWp4V0huS01BUEI4NUl5Yzg1UHIxNzluQTNkNHBCNlllL2xNWkN4bWE0dUF4?=
 =?utf-8?B?NUVIeFR2MlNkQXdxR0JzaHFpbFpqOHRkMXRFbXZNaUU5WE9LT05pNlZpcFZE?=
 =?utf-8?B?b1VQM0tTRmVIS0NRa25GUDNKUlNIUlMycWVFdm9oVXh2clhoU09Zb3Fwbldx?=
 =?utf-8?B?cWVrZ1RKa3grdXkrbE9MOFNkc1d4aXNGeFJyZTlVSGk5QXhOY0Y3K3NDNkF5?=
 =?utf-8?B?N0lSZWo0SnZtNUhWdS9BVjNCelE4L2taRWlucVAwaGJ3V1RFM3g4U0tTZHps?=
 =?utf-8?B?MDFoU3JiVVZ3YXlscDkzaGkwZlNyeGNTN3lMZXMxVGl4Q2dHRXhSemdaZFNx?=
 =?utf-8?Q?1Jx6E+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(10070799003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qzh1RlRuWWJhdUpLTVlIdEhWbVBMVW1VSm9FNUdtZEJwUFNubnJsY1hXZVI3?=
 =?utf-8?B?bVNhV05qZ05ZQklPSHZQUWJTeVpNc2c2RHk3THhPMmgzQndlQ1lzWTduemNw?=
 =?utf-8?B?QnJrYjFOVUtldzJpQ1JFaDhuazdiQzFhUVd0K2svMnh3YURGZlI0b0I2dlFO?=
 =?utf-8?B?QldnRitFMk9HREJ1TXVESUd2RmdBcXAzaHZTdTZTcHlyNlcxVGFHSjcxL1Vk?=
 =?utf-8?B?bXc1SFV0ZUhqOXNsbEJTeTZ6eDBraUtFczFMZXpHSjlOa2pjMlRPSExRMzcz?=
 =?utf-8?B?bW9lWHdTb0ZOcUV4SWZNaXFKSkgvZDc3YU9rbmxVWCtkd091emozZ1ozVlF3?=
 =?utf-8?B?YndJRUxnM3JxQXdmNEliYkhaUFJtdFRsRTRHVEwrcWp1UnYrQUx3SHBMdllT?=
 =?utf-8?B?S3ZXczFMNGhQVmlQT0FKelpic2pVVFJVcVNCMjljSEpHUWlsODAwSFhRenRP?=
 =?utf-8?B?VDl0SFNsd2hISGFYN2V0d21CcmhzVTVNZkFEU3lOSXhhOERtUkt4b29lbDMv?=
 =?utf-8?B?RktOZXphWitQQVhoVnE4Rk9UZjlkQTN4ZWxxVi9Eb0F2bjNkN3dUN1E2UVNF?=
 =?utf-8?B?N291ZCtvVFlOYStSOVIzRGtxd3FWTlByMkhpd1I0WkJoMDRXemVQdmovT0N3?=
 =?utf-8?B?Q0o3MjdmWjRVRmRRYVNaOGdQVHhGUHhlNzNUUDVpTDlIMEltTjRNQWZaRHds?=
 =?utf-8?B?ZWFxM3pEVnJ5L3hxb0xnRXdzMWxLZGhUMHNyUVZrTGZyRjRVT1dNRXNlVVhB?=
 =?utf-8?B?UkhYeUwyd2ZzVi8yVFByQnAyaDhueXNvbWZBdmZQbVBWaEljUEROUXhXVEkz?=
 =?utf-8?B?R1RmR1JIbGl1UVJBYk5NQyt3R3Z4azczRiszeWVIdmluS1A3VEkzTDFLdWI1?=
 =?utf-8?B?UHRKM21oaXdCOTF4UHlJVzl4bldWNmdYeWUvR001SGM0L29HOGl5d2o2d0NC?=
 =?utf-8?B?TjU5WUp1Sm1HMVZvejhtZXViK2cvQVlNaUgzWmUrRmh5QVRHZkRHREpXVHBl?=
 =?utf-8?B?U0JKY0FYWE1KbjlpNmN0cktTQzNhbFpjRDNKS0grYm0vT1gyM3FKblYya2Vz?=
 =?utf-8?B?S21OK1JmNytHZ0Y1MXhEbFdhSkJQLy9vL0RRRFJzVXRaKzF2WnpVcmZUZzBq?=
 =?utf-8?B?Y2E3VWRnaVRxNmk4bWpKUjFoMXBRb3pZdExCTk5xUUtsYk1COUk0d211L3hq?=
 =?utf-8?B?ZFhuem5CR2x5L2RpRE5EQlNkVmNZWUdXUE1tQ2paZGtJS0VrZXFrL3AvWldM?=
 =?utf-8?B?a1hDR2JzVkRqc0w0VEJROXI3N2RUZWo5M2ZHNGhFLzdxdDh3SlI2Ty9zOUwz?=
 =?utf-8?B?YURMVCs4aWZLekZtMm9sc0FRb2x2ZjVxYk0xc3BCTDd5N2lPaytOek9sd3pP?=
 =?utf-8?B?MjFuMjVXSlBlOWtLanVCMjd0MDVjSnlPa3N5VUdtVllnbEczb1Vzc1pjY2Ri?=
 =?utf-8?B?blRQb2QwbEh1cy93NFQ0RlhBYWQ0VWcvUUJ3K0dBRXJHVmJPc1BNZCtzY1p5?=
 =?utf-8?B?QU5oNXM4d3ZGZkdLZjRmUXc1dld2SWtzQ285NFlVdTZDcXAvZ1h2RDEycWVn?=
 =?utf-8?B?clBSbUZCK1U5QzhVUUwrUG13ZmFITGJFS01mZHFqWTRxb28rVUprejY5MDRl?=
 =?utf-8?B?VWdZOCt4U1NUaklaL0dYQVFoSndIZmk4aGFiaGl2MU56L0p5SFZQdU16SmNl?=
 =?utf-8?B?ZGFVd1lCT2xnZERUK0lLU2R5bDVKcCtMSllhVzFxRjZOUlliWDE5c09wOEYw?=
 =?utf-8?B?bGVwazYvYnNrR1FPM2lPL1lhdDIwcU1PSXVsakExMDVJblNwcHpCT0g2Tmg0?=
 =?utf-8?B?MnpBTVY3ZVhUQnJRVDkzdmRHNWVLeWZYZ3dvTmZwTlB3SnNtbVlIWVo3c0dM?=
 =?utf-8?B?Z29aT0xtVVRxV0dNNjZITzhZY3RHQ015c2JBbXQxaDlJNk5kMXJiaGZ3K3RQ?=
 =?utf-8?B?U0RWWUhVNUlqV3ZYZ1F2SVBZTnR5dGlsdi9rbHhWVVdNcjRZbUVFWllFMmJj?=
 =?utf-8?B?VlRkM3BjNHBGbGJjaExvWG8wTHZBUlRwcDY5bTFWcEhtQ2FRQmlHM2Q3MmQ2?=
 =?utf-8?B?VjZhekc3bGxud2dPZmkzcmFyREhMQnBvRVo2dWhSdlVzTzY2M09uWkdQUi94?=
 =?utf-8?B?bmk2Sm5STFJOQnVJSURNS1BsNy9sRGJmZGZURzdKejJ3Y20yQXB6OUNtdXpE?=
 =?utf-8?B?U2F4NzNIWWxaM3YvVCtXT2xwT3RsZHpRQW00U1FuNC9GN0hnWnQ0L1dqTk9x?=
 =?utf-8?B?TUlUZk5DT0xzdG04US96aDFiYmJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD54514EB8FF444A908F96C5C05EE29D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/eP6YYyduIukMadIs5HG2K7UFBoE3fD92KgYwoirN3bbOe7GmSAvOhHQI2PNCn/KHoO0gSJwSJgLq3K/RfGiP7k2/XmAC1OqFv9+KqaqOtySMC1cM6qzAOSI/G/xD7hq/BVYBkiZ03uzawAkzRL8Bf0PaRKh86/pRNrHW+6xTiarKqhC9vEt8iMmxbmZOWfYjzh4gzhvKC8Z0Vi8xbjLzRqhWqwisMZX2KHDjbLqKbyuaiUYTLAfQL8yhY+HbHTUPJrEMA2B/zOOI6uBRg2CaxBAS8h3hh5TCWnJOFZAUsh/qqPYluIhWeo24gOzxxZsTX72BihITiYqKMiy8qvRZ9hVlhEvApy58z7CyB6ZGf6vl5KZLmwtwo9J7cV0x3e51kNrhUHh2+uh+ud8PVHh+eYwf+OW/I+8O2dTpvx+ByKLgjA/hU+Foe2CKa0FqqpTDyt4LoFMIpOn2Mi7PY/XQXEiWD5yu1Vyuc5Vigw6kf6dQ+b775yMiHlH0T2xwp2sUpM9gJ19dGOtPKiUe59EvxxbaDjUId9jj3OFCH6/r/y2O1CZkkfhL2yGiZ/PF1TaHVHAAdB/TfJ9Jv1ShyNJiY/TtWT8xc+atA8Z4Sm878fBpu8IFs3aLJoTA/bH91wM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdfa003-cd41-4ee5-fca6-08de3d380b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 06:46:45.0564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJm1ZlfczILz4Ogkg5ow5yQ/V0NsBfi34HqePqOv19Eppgrfrpv9IQ8Ytn2jJR3KcnBtdO7MWSM1oYJZUBY6cy24llDGiY98HbWzHxF5vwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8971

T24gMTIvMTYvMjUgNTozNSBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gb25lIHVz
ZXIgdGhhdCBkb2VzIG5vdCBldmVuIG5lZWRzIGl0Lg0KDQpOaXQgcy9uZWVkcy9uZWVkLw0KDQpS
ZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNv
bT4NCg0K


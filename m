Return-Path: <linux-btrfs+bounces-11413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E6EA32D41
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBE93A5B4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550DD255E42;
	Wed, 12 Feb 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KrC7uT3X";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vpg6F/H0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBB1DC075;
	Wed, 12 Feb 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380842; cv=fail; b=aam42hf45t81i4PStcqxFc/wD3GOcE9wPlsvu5ce6UUROj9MHIeRqr/0O9u6JOWneiSUaqCSeWZvEhS8CEZum5/Z9RvJVVScynBoSZazd8Wpz25tUPfh1UruV915Sm/sHFHrO6DaIlCsa+zoK0jXcQpv0xjjRBqh6WZuLYPmbco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380842; c=relaxed/simple;
	bh=ImwkdVAna5IDQj7A5h46E3OHdOVuAY88f7Q0j97Ydx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YeNJDIzBFaJLVYS8bfTdPcJBDV0a6owqSBOIH5NZbKoYD5L45OQ4S6gQvmYnVbxviH8WZujRjCo9dscyIPvwo/Z9d9SX+D8CBd47ZT6fb3yZGZFh3mT/IxfpPucZNpvTyMjCoE4cPHkjypAWLLi0okkEI94GRmZrhl0VixR5d+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KrC7uT3X; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vpg6F/H0; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739380840; x=1770916840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ImwkdVAna5IDQj7A5h46E3OHdOVuAY88f7Q0j97Ydx4=;
  b=KrC7uT3X5HCcgRcizCtdmgBeheG7VbD1oQ0ojZnxQWGaaLKt7KwY/qDC
   lsJRTo7P76jHcXxRknjKpEeVz28fok7/0ReZo7n++WpxuVdRvexCvtefY
   HeyjbfXvBNuTndZxSHjFRUVM/Ca4Xj2GT3qZp/ymruK6IpTWn6gLCyGfE
   K67MLaY0a2hWhML2R4hNyJVG3qam6jfajcA+JXzodrZ6gd7dsHCNN0kQO
   j7Zgzse/hlB0OjvfquPuf8qUqcQAxa8uvfDd9z52NkVGTs3su5RnS+/jK
   hAvQYxAkmfgBz68wixuk3M3OQoNAz2kxLVbeqThN9WdelpCEvr8s6g3By
   w==;
X-CSE-ConnectionGUID: 9LLupqpxSCyYd5qHBk5j/A==
X-CSE-MsgGUID: 5I1lecMGQxyy7QHulE1ygA==
X-IronPort-AV: E=Sophos;i="6.13,280,1732550400"; 
   d="scan'208";a="39289706"
Received: from mail-westcentralusazlp17010007.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.7])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2025 01:20:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/L+5JJA6nzVvCV7r/78MCmVdu5uDXkZMTNzpVhojcPJPXl7YQwx7GFkxda+OH6vR/4UM634OPZlVVHhrzTwLSAsbOGL1Lp8FeoHBJCSVuEQD5fW+cSIvJrUy7Zyr3NwzrXvLfuD11FO9TT1HwhYHmzRqCE/VgoMLq1DNtWNf8vQ8Ig3oRV+1tKkY8qbeK4TMluDnSG74/qqdzJW2KWBAcRVVQH8mubreyNLNMUl117juz7Bb18JCS09e1KTjgMcvMCl1txraroc/auGVnDBW6ANITyXtzB94TsnMa4z3MES6REYwhAzPusiE3QnGgSgLcnSqjvEFGFQzVFjEtGUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImwkdVAna5IDQj7A5h46E3OHdOVuAY88f7Q0j97Ydx4=;
 b=mp03MJq5jFWaxzyuq62So/7Y6skYljcBQvCOCeEb+oJ3QgcfgQZkuT/tUDsQ6jAkr5jv+0GUjeyfqJZF9dQ9q5b0K+v+0pDcrmL0xXZZUxkaLFLTTZgehpfY2eaNxWz2ZehYqt6keFltHIXT6eafmCvEPuXfLBVcV6GdG5Iv0z6mnZSGcDtzWpnXrZybc0rIqGFucNrSp/P/7kJKId2yFWV/NQSARnXwOp4TYpUqtLgtOlr50tlSX9FIbbqWYZ4v1HmDG6TmlYArE/h7Q9uLB09WLY955jyhqCJB8X37FJawVsZ5ke2Rj+QNgsJiyAgxc2bZGXog7wrZMoJeujTlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImwkdVAna5IDQj7A5h46E3OHdOVuAY88f7Q0j97Ydx4=;
 b=vpg6F/H01T7pses7lC3BwoUR5FWrLbgGDKKhaqOGIV19ugqjWab8qqeXDYsBr34UPY9gO6Sgxshli+gDztOTxNUPX3mtoxjZuOR7oG89daGsufIMrMsW6EJf82cpRwX5GJD9AgvVNLTDWgBLVQKktuIJ6M7SPEkPbVfGmjjccTU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7580.namprd04.prod.outlook.com (2603:10b6:806:14c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 17:20:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8422.021; Wed, 12 Feb 2025
 17:20:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH 3/8] common/btrfs: add a _require_btrfs_no_nodatasum
 helper
Thread-Topic: [PATCH 3/8] common/btrfs: add a _require_btrfs_no_nodatasum
 helper
Thread-Index: AQHbfXABeXA9RigtkU6kUZ2EP88iKbND6fWA
Date: Wed, 12 Feb 2025 17:20:31 +0000
Message-ID: <763d2b37-507a-46ed-9803-0a408b8909ce@wdc.com>
References: <cover.1739379182.git.fdmanana@suse.com>
 <09d16bf76cfe7317f584c2bbaeacb2ee810dcd99.1739379184.git.fdmanana@suse.com>
In-Reply-To:
 <09d16bf76cfe7317f584c2bbaeacb2ee810dcd99.1739379184.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7580:EE_
x-ms-office365-filtering-correlation-id: a68f622c-c7c8-4b9a-2ef9-08dd4b898dbd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1Jock9QczdyWU1ONHgzQlRZdGtGSVo5Z01yQ3JrQzkyUW5vRTh6ZGpDYWll?=
 =?utf-8?B?MGUyZzJUV0t2THRqdFJSUFhwYU1rTzJGYTZOQm82YTcyQ0NONFcrZkl2Sk9X?=
 =?utf-8?B?MmVSU2h2OHJkdkZpSjAvZlV2Nk85SW1iSUZQdFd4YURGOFlwYU82Q3k5SGcw?=
 =?utf-8?B?dlpWa3lVd21udWRDNTE4VXo4MDBBU2FwR0xTS3MzRzN0KzYvYktPeWFLbUI3?=
 =?utf-8?B?YWxGTUZKamtzTDlPajBSTFpjU0FMZnE1YXlland6M0o0MHJmQS9YQ1ZZU3Ni?=
 =?utf-8?B?K1F2SVJwYTl0UkE3aEdWSzdDZGZRWDcyak5TcWNoNlc1TStwbmc5QkxiT3or?=
 =?utf-8?B?WDJYY1kyMlpnNGdvWVl5SFk2anoyT0kyTHBjTHdKWFoyNmJuZ29mQkN2QWpo?=
 =?utf-8?B?cWwrSFFxTkgyYURDSUpvOVh4L1pYSk1GT0hTUTZ2dmphOXQxUVBOd1Y3UnFy?=
 =?utf-8?B?RXFaRnVzMU9rb2hGNVM2V1VqS3FIMkk1Qjh6UEx1L3ZuT2YvZXpwaUpZbm5D?=
 =?utf-8?B?cDBRMHlGRG9PYXlPWDlXei9TMTZORHRjSVVkYmNuWmhIMFo2UHhkRGhNb1lk?=
 =?utf-8?B?NVVnaDc1ak1vZ256TGhRbTljdDZXV3J1dXlZZ09rVjMvbWNiUStCYkpndkRE?=
 =?utf-8?B?ZEJzcGIyQ1pYZllYdUZTSmgwd2N4emJETkpQelJxaCs0dU1yUjJTYjBGa2ZY?=
 =?utf-8?B?dzJJRktnVkpTUkladFNSdTg1ZThXbklBbzhqL0tRMk1NMWkrK1cyVHdETHM0?=
 =?utf-8?B?aTl6S2l4aG1RVXVPUUhlanIreHNJK3dDRXZGSkVTRDYzSzFZT2hXeEZhNzZE?=
 =?utf-8?B?RmRCMzVZMXhZVjZta3k1L3ZnUnhaRkVzY0dNV2I1NEQ4M015UGNiSjVJM2JU?=
 =?utf-8?B?eGEyb0RSaml6b1ZJWkUxakhBZHlxdUlwdlNPUzVIVnBUYXpJRktjZTVKcmpH?=
 =?utf-8?B?L2s1YTNJWHd5azdROTZtc2RCWVF5ZlVjTDA1aC8xaENSRkY1eUFXRFh0ZlhZ?=
 =?utf-8?B?U0hXUS95ZUVPTzZ4dkpZT2RYaWluWGdVV1YxS3VaZjcwK2Q3Y1pUaHdoSHMv?=
 =?utf-8?B?SHhHcEV4d1Zmc2VXNE92Y2MrQVdiOVArWmlIQUVpYjhldFY4aU9uRUhQbTFZ?=
 =?utf-8?B?SmdUN1FRZ3ZCUk9xVURWdVFtNjBGbzllZXlHQ1M4cDhscEgwR3dZclN3QlRQ?=
 =?utf-8?B?bXVFRnM2OU1PMHc4c0NiMG5Pd3FFeVZWcjA5bTREaXNFOExraVc3UXpBeWNm?=
 =?utf-8?B?NjIxU2hnSEVWdE9NWlBETDRuQStkN3J2VlVpMTdSbEdQTVJqb3FKMEhJTklD?=
 =?utf-8?B?SWxIcVh2T2J2QkJFNkZTNTVqYzBBSSswRERQYjJhWnNvYlk2bFRueFkyODNh?=
 =?utf-8?B?eU1WQUhxV2EwZXJWRFVvam8rdDYzZDVHcWJqQjVTR291Mk1MOWtuT2trb0p0?=
 =?utf-8?B?V0NzVVk4MllYdlp1cHZWcHdYeUQ4cEF0ZUlZZW1NZmlTMEh4ZmhCZW5Na1Fm?=
 =?utf-8?B?Si8wYnczSHluVGt6MmpKMEp6RXh5NWJ3djBpb2RoWGZ5QUVzNUlaSGRYK0dG?=
 =?utf-8?B?WjFyTUNPUGd5azkwTk43bmVDL1h3ZVFVUXBpNU1HOHU4clJMbmpVbmlrQWFX?=
 =?utf-8?B?bE9jVis4TjZSUXdySW9zVDZMK1BBM0l1RmFBZEdjUExsVDFhMVVycW1lVk5m?=
 =?utf-8?B?U2ZWZmgvcS9aamtEc0FkZnpOTGJvdml1d1NUZENSeVdvb3FCK0w2S1NoL25S?=
 =?utf-8?B?WVVhZVFuc0Z0TGpZZVZlK0JzNFNQNU5zMTVoa0VSVGE3aE9BaTdFUHVhNjdz?=
 =?utf-8?B?L1NQYnk1bVZJa255QkU2RDc1TVh1V1ZhdUNTVGRmWW9uYlp5RnlOd2ZYVEhI?=
 =?utf-8?B?NXVVSXUrV0dmVXA0NlV6dnZYNThXQmM0S00yZGsrSFk4L2NVelVXMzNpWXhQ?=
 =?utf-8?Q?hLdEDVnrgpbV6I95LgLLGw8coZ5VRE9y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEMxVTBCNi96MU9WQkRYbFZhcEFUMEx3UnI4L3BjdjJ2YU9wb0x5SVNnOENZ?=
 =?utf-8?B?MzFLNzVyeWdyYmg4cjVOa1dRYWlEcWRzLzkxSnRsNmVObXhRR1VoYWh1cHBU?=
 =?utf-8?B?WlpqWnNPSkh6RTFwUFJIRUJUYWliVktTMmk5cTNjbFBtVmhjdEZkVUtnRjdZ?=
 =?utf-8?B?WXpGWjdhZ29YZHpjVGRHN1Q2V0RYUWpoT3oyTEYrQ29qVEREVDh5NStIVFlC?=
 =?utf-8?B?blRMeVY2WWJRQ1hCYVB0c2c4Q3V1SmlwcEZKVEtZaDNSOVJWNk15amc1bTkv?=
 =?utf-8?B?RWhsMEdiU1pPZHhGdGRtNmJMUGpFdFFjVGhFdGJJOUZNTHlrWWhXRzE2TzVl?=
 =?utf-8?B?a3lpWmJJdmZHRFh2STVnMUJlcVNIWEIzSUtKRFlEM3IwWFM0MmZxNzRkcFZH?=
 =?utf-8?B?aHIzaEM3WmY2YVVHOEV1b1ZaNU10b1hTR01WdDlKQkpVZXdxdndaeHF1ck1M?=
 =?utf-8?B?WGF1S2NUWDAzQjIvUTZhMlJSMFN6S2F6UG04Z3JFdWZmQmNWQy82Rk94VXlu?=
 =?utf-8?B?bzU4REpUNExlbzNXTHBrTkdjK01uemFHZ0ZlVW5CWE1oZXZ6dTI0TXl4R2lt?=
 =?utf-8?B?ckNJc3AvY1JYQ2tEMnAwd1ZBSjZQQjlpZGlaWSs4cHUvUEMyVkNzNDZVbFRF?=
 =?utf-8?B?bVlleXhENkNRQzFLZjNzbkZEeWVRb3habU8zR0FvVDVKNCsyYUpTWVo4ZGZn?=
 =?utf-8?B?K2ZJNWI3SUJlNHJ1a25STmNlRTlYVmVZcFBVYi9CdE5kR2VNL2VKRXNMQVha?=
 =?utf-8?B?Vjlpc1pjaFcwa3NoMVJqTElKbVZxQWVxNk95RWZuZzdVbDU2UW9jOVFza1E1?=
 =?utf-8?B?NHR2TWJ0ZFgyYnBJR3pFUzhiNlUvQ3JOSzZiaTFuaW02Z1ZSRTRPYlZYRmJF?=
 =?utf-8?B?cE9sOWxwYitFMExnYkFoQkZSTisxQ05OQ24xOVloalh4V0JDc0dpMGJ0dnlo?=
 =?utf-8?B?SERSU21GMHdtOTY5Szl5QTVpVHhNKzc4VjlYZmhsaHFVZW5ndWxwdWhPWVNr?=
 =?utf-8?B?SGdKRVMrQzhrcmlCU1RobHpvWndqUU9OQjFwRkY4aFczZEdBL1ZnQjFPSFVk?=
 =?utf-8?B?QlVXdFVxWWNldHkwZ2lDY3JNZHIzb1FySEZPb3FnU3hlLzhWajZMNm9YR2wy?=
 =?utf-8?B?dlNaZzlreUZXb0QvdDZqd3Q0WEtsL1grK085UlpRd3IxUEpLQmZrMWlIOUpW?=
 =?utf-8?B?REZlbEU1eExQWXA0QXdqOSs4bEo1RFRicHUrMkx4QWlaejZhbmc0YWRlV0c3?=
 =?utf-8?B?ejJFVXpkQVdsNXIwemRoZThKNEVGdTV1VHFnalVaYUd0dktCbnFLem9GenEw?=
 =?utf-8?B?SWdCeWN5VUs2S2J1Y3kvTGkyRFduYTAyd084QlBWUDNYQ1FFTGhaWC9vOUJ2?=
 =?utf-8?B?MFBlTEdYVWhmaUFHRTVRQ1ZHckJodHNaemlkZ01LU1pGS2hBbXhVd0ZoU1d0?=
 =?utf-8?B?ZzBucFJsYURHb1ZwYTdBZXR0cTN0SmZSUk9maTkxR1FGRDZ6Vkd5Q2k0dUts?=
 =?utf-8?B?eUdmZy8rNjZnd2ZkMklvaGxXNUpGQWNHVmRBTlg0WGgxY3hIWjNIa3VqNjBW?=
 =?utf-8?B?Yk00WDlRMVcwalpBa2lEZmtuQjZvaHFxQXFqam0rUnVDK2swYUxDSzNCRFFF?=
 =?utf-8?B?RFFEaTh6QTFLQUh2WTcvSW9wekZFSjZOZHE0aFRSLzJFclhpSG1aekJOaW9L?=
 =?utf-8?B?cjhveGtaUXdpeDRzMFl6TzU2cllrZFNQWk1seThrS1lseHpGVFRBbDJRcjdY?=
 =?utf-8?B?UDdpTThvZCswM2ovNWp6NVJYV0ZHemFFeDdiMWNUM2FGOVNxdUhFN3ZtTVdW?=
 =?utf-8?B?V3Vza0czaWZWOGpjUUcyeDRTWHpQeXhCVnEyMmthVkNLeWVTTU9HY0VsZkdK?=
 =?utf-8?B?eUhmUzBSbFYxMFgrbzJhMGtwcmJlM01EM1dNcFlUN2lkTXVEU1dOSzA3emlE?=
 =?utf-8?B?UUphaFpvb244NjlVSHc1UnlKVHpuNEYxVU5DVUJsdDc2d2tDUDhqRlhzeGti?=
 =?utf-8?B?NVRCY0NadGJTYlpoRnZvZVpmbXIxQVRxWDhXQ1BQVWN6QTFGZXZqSW5MSDg4?=
 =?utf-8?B?VHFpVmNBRTZYUnlRanhkQithajJUUHEwNjlxSVZaejMyRDVyOGl6SGlncjBE?=
 =?utf-8?B?dUxnaDdUOTh3MERSTUtlZjRhdm1ZWUEyS2VwQ1JnVHZURzNEYXc3ejVaWnND?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A575FDF252EFA14B9A1C35AA8558D65B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B9Rkoe02sUGfGmiTyV4RSxSZwRZ0KKGPmob48ffU6tz1B2bL7rV6TRkwUrLNS4Ysu5EJjrZ+1qo6uFGqnEKIFfR5OKIyQYClR76oruNCtMT42gkc/arunKw6nuYFtCf0ZNFYueGMjdyyTPh21NcOqvEzics5TyzZL1MC2spgWvLKxK7X5xleNkW6s/k7RimHN1bKyIbGFo/N7KCxD2xLoMGrkPWAZxKbSEw70J0e6NNHRd+KJdlByQyi15CYnJv0Y5f2AT6pu4xkqO096zmIy4JdQW9SNpgnActf/01DieH2OD/hn1mEjPQPi5HZv9BFtsde3WLn6Z5RWyqjfwaqfmHa9FptEjEpAMDrzwzhdAAe+myx67Lt+F7M8rybVsId7EbszlU1O+ExUtUQilMQTZz1TU4zxS4iGKzlNdz/2BiREmw3STsWC61CQZqOPy7IDpF2JHpqpYyLaXpozCG09xflIYP1XWj5Y32LHr0LcaXU3bGaM4l3mkvZqvKQcX2xstHznqE2bDwr7bWd7YvsUDsnZWXC8utiKBTbbGOyX4tfnK2gip+UTh81j2itgi7XtFpVK5Y763901f08dvLrGcbZbjHyyF//a04QYNNtj3x7CMkxN9oFT5cF1ZX7oXa5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68f622c-c7c8-4b9a-2ef9-08dd4b898dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 17:20:31.6892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzaHP3fgc0vvZpxkfJXtN1NG1lbH/CjstcVO/b8OzCfv1wJPgxVvJi+KuNpO7d6G5EqGbfZW8u7i1uAhAKZq1vb08KN1lrulwT2SuB1TfZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7580

QWxsIHRob3NlIGRvdWJsZSBuZWdhdGlvbnMgWEQNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


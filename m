Return-Path: <linux-btrfs+bounces-19820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC012CC64A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 07:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 333EF3091CCC
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 06:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C5299A90;
	Wed, 17 Dec 2025 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SM5JarO1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dWgP7J1Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA631987E
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765954075; cv=fail; b=mvBVZDNVNBLLpRoyVBnDdy3srrb4xNk8ESmur/sJeR02fxh2GyDpEJj3kgyYzNkdgD8jTz2J9F/vjzfAIhA37aqAhaDGF20WQPMjmF0RuOXyBR/M2bFrXCwZnwYEgyq0fyvgjjqz0SFOEEHp/LNHTFox/I/zWCsYHxOsFvtmjtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765954075; c=relaxed/simple;
	bh=jCLNXa17Ns7XqBVN9+NMgH2tncKg+nf4HXhAtQuAICM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OHiECN+CCix0BG6fOszOOJvvjp6wgjwX8a+sHw+7RizsLr0DZwH99F+2/OaKTJH2oo9lg+uw8uqgBbwLuZBFjFaE5FdukNJwYZJqlXgShhaOdTehf53bcWE0AArvvtnfmAmW10d9UW13/sYwa4U5qJa2QVL390GYSZheWIfIn2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SM5JarO1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dWgP7J1Z; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765954068; x=1797490068;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jCLNXa17Ns7XqBVN9+NMgH2tncKg+nf4HXhAtQuAICM=;
  b=SM5JarO1MBm7emly41oXyrNaf5YXvTRH+qa+aocNqejEjaPKtAfS7YTC
   Im9QKNyJDGwTKUQOldOscKoPyB55N7xsXmBQt9GpLgWx2FcXXUZMAvo3z
   NT2H3o6rI2bUtxL5F41704y5r9RA5fSOww7yOM0Oavswq4NYzXMsnERsO
   Ub9hnbsXhMPLG09J625N0fHONWzRw5D+jAl57hwwZnZT9RmM3qp+e9LkX
   PWkI4BgHbL+0zEDOU27IzuY4dBIEDS5AKUCXaWScaYVn8chcVAQQPHzPd
   9c+onMBWRz7YVSdGecjYDQGwIIjnnIZbu6aOz+QhQCwYAfHbYQ52O9bj0
   A==;
X-CSE-ConnectionGUID: L8/uwpC7QYKZj2rZr6qvqQ==
X-CSE-MsgGUID: B+70k6kvTeGtkMJk/P5W2A==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="136671884"
Received: from mail-southcentralusazon11011003.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.3])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 14:47:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqZffIQI/xEcLzMY+5nSQtTuYGm2h0ViRgCUcpNG9D1k9kdpDJ9hZMf7V93kVjHPO+SmybpmfI4tqdoEwvk56q0M9cHodwZV+MjAid+RVqOYmxqn7wEGQo0/nI196RqK+PgcWiOJFiVlW+qq9cAeqdtR4SLN9ZZzuByeY8G5ONdZO6Iz0KFnjB3F7fPB/GF6MJy7XOKtOahygmKDBx1uJcdtyb48yPLduCUSOxYWbiHCOOigevvY0T88bQiEacOMm5laU/HRnLKSQlhIkONhhZMg8SrYoNuogkS76OLChm79AzNxvlGUqLmm+cgET2Ieag2balNXPdzrUHvwLpW28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCLNXa17Ns7XqBVN9+NMgH2tncKg+nf4HXhAtQuAICM=;
 b=bjun9cJi8jyDt3lp45jtTloFh3aUvo6KIK3VXoEbfKgJge92khpoYPI4XM94EcYoIogVR6VsqCadl6FrCplS5PMdH3JWu3NI3aiI5qI7Oot1a7vAuE65l498xFPWA23hCBvzJB51mMXdKoXfQ0WsmE1VtmNwbuXdqLEaCXEQNDno87huButIcDJ/5wYIbhEGSL6aNK4s7sCJAE27iZOc/VSWs3EBD7VXaKILb7Mi2sTQab3SBGSEqE57ob43DgU5jlbeuUs+U89X1fgg/idXCJ2+shfBWESVXCPGbgMoqDcUv3YOpgln7QnFdT3HWT3kGZVwBj2/KEPEk/PgRP+Smg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCLNXa17Ns7XqBVN9+NMgH2tncKg+nf4HXhAtQuAICM=;
 b=dWgP7J1ZBATZqsji9JZurEPL7d/+G53OMQd8dmZ5+HAM9JEXv0dPw60IPv4yWpkSCAQg4/4agHRgBNz3ZRlV34IEUGjsZXP5m3GbscbQriOYJrQZh0uKdBcIRojbjn9OYlsGihMLtNJEHN5TKmNM+MhTxOLkKT/0aYeYLRYZp5k=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH3PR04MB8971.namprd04.prod.outlook.com (2603:10b6:610:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 06:47:42 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 06:47:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: don't call btrfs_handle_fs_error() in
 btrfs_commit_transaction()
Thread-Topic: [PATCH] btrfs: don't call btrfs_handle_fs_error() in
 btrfs_commit_transaction()
Thread-Index: AQHcbqruoH8mT49N2k63XK9B1kLRJLUlZL6A
Date: Wed, 17 Dec 2025 06:47:41 +0000
Message-ID: <55dbe2b9-3afc-499a-aa36-cb217389321d@wdc.com>
References:
 <9f7dcc2908682e4f888affa60d0b13db92e2970e.1765902946.git.fdmanana@suse.com>
In-Reply-To:
 <9f7dcc2908682e4f888affa60d0b13db92e2970e.1765902946.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH3PR04MB8971:EE_
x-ms-office365-filtering-correlation-id: 32b917f6-d603-4347-fcc7-08de3d382d47
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|10070799003|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NGR4STB1eXVQYnRGMWt1SlhHUkxSK3ZUaWNoS2RJTmJqLzUxSWdydXBJL0I4?=
 =?utf-8?B?WkJraUZLQW1OaHZyaENMeHo4b0RrVVZDUnB0aDh2QzBEbmNpeUZoanlEV0VP?=
 =?utf-8?B?c0c0SGV2Yi9YREp1ZjhGcmQxY1JYTmZmQ0RZdVUxU3NxT2RVbkl5UjViYmhi?=
 =?utf-8?B?MVZ0Z0FCYVdwY2c3bHltTFVnL0gveXZ6MmxaYTY2OVA5RUkxdWowanlYQ1R2?=
 =?utf-8?B?SWxKSnR3akVFRU1kSk1YblZRZkJFdTN4dXk2VklHRlRadVZyeHFQUndBYzFP?=
 =?utf-8?B?Q3UyWUg1bWNZWWExUzhlRnZ6SklNNjNlYWwyVWhBNVJMNHFac3diR3pwN21F?=
 =?utf-8?B?NXh1bXdHS1JJaTR3MDFMNUZSYXBOZnY1dm5Kb0l4OFpxK3RIRWZwbUYwNW9K?=
 =?utf-8?B?UTJVd2E2MXUrMG15QlA0Nnh5dURPeHdOclRwWmRmNTh1ZEFzY3REeXFzM0RI?=
 =?utf-8?B?UVVNcWtCcmNDRkYvRitCU21oanE2dnlnMXFmWEdkNk8xSDlWM2hlSWk1Mk9y?=
 =?utf-8?B?Vy9oMEMxVno3ZTVyMS9Da1d1NXRkNDRoQk80REtMOUJVNzRESXY4aE5yS1gv?=
 =?utf-8?B?WGRSZTlwMjRUcDFwNkV4ZTZOcEd5Z1NxeUFLQ1JoNDdMR1ZzNHVjejkwN3pZ?=
 =?utf-8?B?WWpJazNiSkQzeXc1ZEpmTzZEUW5SV1hCS3I0WnY0a2IzY3dVQ1J5MXEya21V?=
 =?utf-8?B?OHVGSjdXeWJsMTNyMnlESE94MjJ3dFVueFB0TjhGVkU3bUFUK1dQVFkxQmJt?=
 =?utf-8?B?WC9Ja1RRSFBmRzZtZ3RSNVRhbUFqYy9IMjl1VjhVeTRBL2d1WXhiRnFTTTha?=
 =?utf-8?B?VmEySHdldUk1cGNLN05MTnpxZ05pQ2hsdFFrNTFIOW8vekZCMVFwbU1PeVpT?=
 =?utf-8?B?U1hNR1c3eExiOVYwRnhWUDBmUlgrdEZqTHZjcGNmdWg2KzQwZENoSmk5OFBH?=
 =?utf-8?B?Tyt5NGowQzkwM2h4TzJIN2xoNUkvS3dlMEVKZ0RzNFh2VVJrODA3Zmg2M21W?=
 =?utf-8?B?TkFnM3k3K2VZeitXV3JBRGcyRlM2TUl0Y1EvYlJKT3BWbUo0TnFOVU1KUzQ4?=
 =?utf-8?B?QlFpT28ycEl4WVZtelJYR3M3dHZCMHE1QzNXNWY1OExRM3Zjc3hDblI3NTds?=
 =?utf-8?B?aFVTNDJzWHNqLzA0WGJtcHBwOVhSbDVWZ0tJVEVMc0RKcDZxT0ZPQzM5eEVu?=
 =?utf-8?B?aGcyYUxjdHJVZWY2WU4ySlpWaU93NHUycWYyVXBvWTZuSU1jbHNNMTJLdlhi?=
 =?utf-8?B?Z3ErSElqRVJjOEpzbmtZd0lpdzRrUXNINUwwYnNCRDlmWUNhajkxbFRWRDFt?=
 =?utf-8?B?dkM5b0dGTzVsSGZCQjhWU1FhOGNnaUk0ZzJ1VjFNeU9RelZFYUtiUnYwakFh?=
 =?utf-8?B?WHVTMnhwcUtZUjhaTEJmamp6cVdXNGl4TU9KTmdLQ1duWXhMUjFxUGFuOVZC?=
 =?utf-8?B?TTRpV0pCQjB4YVRCSWN6Vm5ITnBrak1VK0hXZXpYSjJKVVpCQllvclVPYStr?=
 =?utf-8?B?U2lscElRUjg0K0w0OHZnSE43R21CdUlla214bHpOdVNMcnhWd3l4d2tLODhy?=
 =?utf-8?B?RDJ5ajd4TzZQMlNVZWxLbWR5cEF3alhNU3hRMktJc05VMk1wdWtkWnZpUDFa?=
 =?utf-8?B?dVNMV0dHRTFuMnZwaWkyczdyQkZwUi9yUC9jQkNQVHFzQ1RCM3V5dGc2ZUt5?=
 =?utf-8?B?Z3NORzlncE5HUEswb2h0V0VTS0RVbDdXdm01bzNJV3FZS2dnSlVEaGNNK0tY?=
 =?utf-8?B?eXlPdUx2czg3aFFVRUlPWkdLY3NPZXNKU1BxNm1HT2dja0dxV1grK2JveHNB?=
 =?utf-8?B?Tm1HU05PMFNJOTRmUk5vZjVWWnRFbjRVTkd0UTQzcVhNSStWNFd6WFlxbUNi?=
 =?utf-8?B?Y0JubHUzTVRyKzhtNTdOemd1RmsyVEpzajNjSGZzWTRLcTBCYml2bGsyZDNO?=
 =?utf-8?B?dkpWS3VRTCszdUZ5Z0F1RkFlV3lYYWVxbzlnZ1JHTnlleU50aGJiL2t3U3hp?=
 =?utf-8?B?c0NkdWtOVjZCekc1MDAzd0pNTi9Ta014QkQzNGRFY2FFSVlsYklORmpLMElX?=
 =?utf-8?Q?HxybET?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(10070799003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1RRQlVPNWZhc3VjTVo0SUppVDFFaW5DMFNWWmk3NlVsWE92ZkdUMW5rcDRv?=
 =?utf-8?B?YmFva2pPeGJMWXQyS1A1c3lhTWhuclY0ODhrRGJpMHE2NU1PeVpBamZyNDdH?=
 =?utf-8?B?VGJHa0VJUmZEaHVJcFIzUmRjMmJUY3ZCUGN3d0pUazg4dEttL2Z3Ky9JVW5K?=
 =?utf-8?B?aDNIeUZINHhxdGEyOUhLOTljQ2srb0gySUtId1JSR1VGMmNWUGRKeWpQZWN0?=
 =?utf-8?B?b1VmVmkzRG0rSnRPMFdDdS93V1grcDJLMTZxZnVUMWFQREFOemt5dVdIeDEy?=
 =?utf-8?B?bGloUmNUdzZNblYrWklGdnpsVnhreGt0alZ2OVNEbEtPRFZnenE0TWZyNUwx?=
 =?utf-8?B?MzhKSmhoaUpaMFNQUTlIM2E1ZEF1cFFLaHJ4T0dOUXR6bGpkUjhVRVp4MFpk?=
 =?utf-8?B?T21TL2R6bFIzTTYxWmRPK01wMXNTamlCZTFiQ0pUTFBZR0JDMDhKVnhoVnFy?=
 =?utf-8?B?eWt0dzkvcFFGQjAydFJ0SmFGM2pRT3FDZmJuUS9hY1UrVk14THNZWnhSbWpD?=
 =?utf-8?B?d2VQWWc3TUxJTHh2V0ZWQUNSa1F2UkhtUWRjanAraEFsRHh5bHAyL0gwQnFV?=
 =?utf-8?B?Q1FJOE91b3JtVHZWTy9ISWVWejZSMEZvRHJWeTZvSEg4WmJNcXIyaUVJeldR?=
 =?utf-8?B?SXAzRnVzdzBvVElKaTdYQXN6NHMxR3poM2d2UE85eE5kWFF2TDlVcVkvTWNs?=
 =?utf-8?B?aVNZTU01ZzAvaFZ1cStlK2xvRURuRmZESzNlZWhlV0ZaaGM4VlJ4bjNjRXp1?=
 =?utf-8?B?L2tnYktvM0c3ZE1Na0lxQjE0VzN1UWV5czlvVitIeGF2QzFTVnhNeXBTNTFE?=
 =?utf-8?B?aUdNZXhSeVRubS84RFdyOXQ5bjJ5Tm9GWnFaZ3RNSHMxTFN4YURLc2d3bVJ4?=
 =?utf-8?B?T28vZU91aloxZDZxaGRIUzNWUkVHaS9aMDQ2NXZDSndPS29yZ2xLMWhEeDVq?=
 =?utf-8?B?ZlFWVkIzajIya21xQlVCV2lVTXZtN0ZmWlZTcko0Q3oyM3k4Q2JQL2p6VjF2?=
 =?utf-8?B?ck9ia1lKcHpzZ3ZxU0dQVXpxY091UDk1aHBXVmlDUjFZdHI0UkdMMU5Oc0xi?=
 =?utf-8?B?QUs0MkxCWG9TcS9mZmxlVFpuSVNjZEFmbFlzQVB2d3BmZGU2b2I4T2dmRExO?=
 =?utf-8?B?UWZ5Z3kvWmZ4azJWWHdvc05pNFc1aDRBSUUvY2tTSHVyS0tGZGdyeUM4T05Z?=
 =?utf-8?B?TVZ5L1JvRG9aTlFONlZMazI3dmRkejN4b1Q3eE5GUmk0NGFGYXBKanJCOXVo?=
 =?utf-8?B?ZTBmMW9rUWV2SitXeCtwbWU4eUFDMlh1MDFYbFdXcldiWGJ5VkJFMGNsVnBF?=
 =?utf-8?B?SktVSmU2RWJnaW95bnBvZ3FXNWowREVnb01GSVdXM2FWWlNCR28xUkVIMmpk?=
 =?utf-8?B?SGF1UkdMckdSVDVIT1FIK0lxclRpVjJnbW9LZFNPdkhYd2lsVzZ6aXdWZUtG?=
 =?utf-8?B?M0FrOFJnS2h4TU5qMTNTaXJpdEpaRldrUG9aaUVsNGtDS0liT3huSlhScjZK?=
 =?utf-8?B?N25idlg3aHkrQm1IM0tUZ2pCWVFralFQYTZNdjNwTXI4ZUtYYkpPVWt3bFJu?=
 =?utf-8?B?UEtNaG9ocmJSQnhrYUxTQzlsMGY3Z3dzM0IzaHBtUHVhK1FJNCtCUHBEMkNZ?=
 =?utf-8?B?UkhYZTdOeTV3VzZUZXc0OTlHMCttbE5tOEFFWTE1UnN0ais5L0Y4UjN5SlNq?=
 =?utf-8?B?OFN0ZDFqaGZVL1RrZ0FiOW9yTFI3aXd0LzBjME56UTZJeitESXJlUnFQblVB?=
 =?utf-8?B?S1FBSHZ1SnNQQ1RDcFVOWTZIaFM2eTdvQUNMaTFMaDdNRXJCSGpMb3NsSWxr?=
 =?utf-8?B?TE9WbkhNNjlkVlBiUXBLU1pDSkJiNmRUVnRRNXNqRlgxNUdKZnpNT1FCVDVa?=
 =?utf-8?B?RkNLTVp3L2g5ZFdST0NtT0xxdFFRT1d3UVhCYmkwNE93K1NQV200OTZRclhL?=
 =?utf-8?B?OFN0Wlh4cXg5RElyaEsvTlBSUXlUVGt0VERuLzBjcHZGY1pqcm1kUWlvM1JP?=
 =?utf-8?B?aTExaTBKZHV4M2Y1ekJHSUZHc1labTlwNExtSjVFL3Z4T3BOMjcvSTdSUHAz?=
 =?utf-8?B?QUFYK3kwY3B2VTRQV1VHeFkzMmpIb2JkZ3FQN1NhRWxFZ0tpOGJ1MFNGVUNp?=
 =?utf-8?B?VkhEaUM5ckNPeExtVGdBdUdZYW9DNFh1RWIzK1hBS1FrNThFNllVSlh6dEJ0?=
 =?utf-8?B?ZUE0ak9lM0dwQUVaNHNVY0M1N3JrdENKNDdUN0orSGdrTXFGeCtQMWtFV2pS?=
 =?utf-8?B?YVp4VWFpTzRJVEluMGVCcjltMDhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8C2744877616A4981355C52E501AEB5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z6XKrQfHiXEpPKzmXHo/xyvH04/xSRRC/okwLSLpA37S+Vy84cGXrXDV6Z62QRi6V7kBxqGfcjvoUmwchGrXG+09ZnptsbMOkHCuy9k740B7zhiNBVCuT91tcVRbQ7E08grkg78IXyg6QWN7Lg1BhG0FJYrVDKuyt4rpiZ/mT4yUShRZH1eKBwl9WiaxjgSqcbgil1UUc06kt6lifIirhxqpKqWuy5pHN/PRfqdpOxe1owHsW3xpdqwr8WGmNqjk1slA0v+WQ7xmEh42OfXaCwmsfLvXzAFIQIavAs+SLrfmQkLxxdM85ieGZRMSBAS95RfgSkkoEhftVORVILZq9Z9JnXbBmnO6wwFFI4LKI8OOZnJxXG455HlVpiPUfFRz999UPs2tafmXDTCy/hQ/e0v2JDNjC9aRxWV4++JLktWSLA5C+zeMuWLOJhoVg1W1pgWoaRRKhMceza++cWDU246kM+w5oCqA/ia3OFB3syZJ9V73nicXZhpIbsRT6tQ343xunhHcrTf9tw/k84vGWbBCAB8KaCHgag8K28HoIrlsJ7MyJOrAFEXkaNLICyTp7sFd/MUfW0R8CfnBf2WjjOi8vcQEJjCWS7hjUwagePIGnkwH10oW1zbaUIzdLrw8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b917f6-d603-4347-fcc7-08de3d382d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 06:47:41.9823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Ji3I3dVDEnriM3ORqS2ERwUOLbwKDVmXZJ+Qz7CqztB8Zy5nJS4rwTOpJzx/85Z4XxZXONqJJ2UITKwYPN5Jii/VdsUWyC278UO7St4Gwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8971

T24gMTIvMTYvMjUgNTo0MiBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gV2UndmUg
YmVlbiB3YW50aW5nIHRvIHJlbW92ZSBidHJmc19oYW5kbGVfZnNfZXJyb3IoKSwgc28gdGhpcyBy
ZW1vdmVzDQo+IG9uZSB1c2VyIHRoYXQgZG9lcyBub3QgZXZlbiBuZWVkcyBpdC4NCg0KQWdhaW4g
cy9uZWVkcy9uZWVkLw0KDQpPdGhlcndpc2UNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1z
aGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


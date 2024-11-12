Return-Path: <linux-btrfs+bounces-9495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2F49C4F2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 08:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D32E1F216E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A320A5F7;
	Tue, 12 Nov 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TQFQWE5Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gSJv7dxJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDD4C91
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395528; cv=fail; b=ue3uK/58fwSotQRVNxCEEetdbn5lDAXCZt/7mZDMWRPLr3sAQkGoQxSR4ycxHGOITC+uW/SV8CLoF0xa1Ee2f6GrlnArS55QgREw7iI5frD0JYCAVvQaaw7E/11Y546vdUWyRBzYHWNJ/CjjeKmc3CvkrXVEwRl8HNhlW+jU9rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395528; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VU1C5JhVBc75EzIXqi7lzELEKLo4D0XBzMO6nU2AZPduBUVTVBMYaxv+FKzMUAnGTJDvewuXXj6cbby2/IcMeI+rottzJuPp1NTwM+6sHB5Xfk763PYY+KAWmWzIQgpjF7lu55doI1q0lU2WrsvjbwAMj3rBv7O2ewrbSzKUIMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TQFQWE5Y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gSJv7dxJ; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731395526; x=1762931526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=TQFQWE5YVP7f0mezowIm4zLjS/pb1pGGisfG7GcMsf3D+Nv7Se6LhaSS
   7EzaqMfD/Je0MYHxRnECEXrIGN7TvLci1OX3+Nt4892z3BWunfgM777Vg
   TtHEIPlOt0Nxf1gT8oR4XdqWKjqQHxgm/OrBg5H7Xoe5rddQ0DFkJegsI
   FLl4X7uTcP9uB9Eega5u7xs0AhDvRZlXkDOL5qz2SM/yE//HnNVsl9oEU
   252C8o6Ae4Sd8RhVKfypvKABOViZ+cz7LofuL0CrA/swY2GDouQn/EMv2
   eXCqQZC8LD0tnymvXZw0ZXbE+dN3o3UatuV1Qv83T0GycwaL/mogbhj07
   w==;
X-CSE-ConnectionGUID: EcMFOc8BQAO9Fv6q3aayHw==
X-CSE-MsgGUID: ZMW5wlG0TRyGdQj4t/rUnA==
X-IronPort-AV: E=Sophos;i="6.12,147,1728921600"; 
   d="scan'208";a="31766118"
Received: from mail-centralusazlp17010006.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.6])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2024 15:12:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jszx448bXT+a3pUrI9rSLyHKoq8+e2dMPJV9qwsUuW8vgQyRf8GwVwr4Hnt6SBfcZJPkB7G47GP7aqUqA0vS7otMFyiLVjjr+nKovkohJkh8pygPnAruyR8oTAUH9bS3qfC9v/8EvR2i//3MBl1ske3vGzNte+x/j0nq7UJ3NeHEIR18v1wXfIdVbak1rVJ5XN65P3uimx83p5PTED3oyY3hptiHPwIxJjTDQG+aIEZyzJS+xRtRZ7CxUUCVCOwlhbsRswlA3sQLYc2tgIwnfirpRShk28A3DkAeaKbI2c/cC8/zGOfq430mzKobqFIqWdkqw2GHM8cf2D3D2Qwpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Ci3zUYsGjra8dcDX2KotNmN91OvJhBvgfCCMCpvQjvtJgy1nTNOtv0f4WzS6OQ1yWTa1OF24awrKfclVdIrnVBQ0F8LNNbMWC62xCpUwpa9/KeuOsMmL2fW5x3RatdNZlCETShU+t4ApmHYUN/DawErSTYizGmUdNKErQf47KZIm66tNuFfc3bqVEWXQVSGFbap/bOprVSlhLSwkjwvG6gPYUkpiVFGjeGXaGcDQoFUTH+hDrtHJUv20173utjyoFsgtfiSvHHBOW76AExsdCbrWkPZV+xZux7XNM1Her/T9WJdlKkUIOeq/rJznOol6RcDG5F9rrb3QgVTw7jVE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=gSJv7dxJIDJIzXcB6/VmQDw2b7Egtm3QP0fM3ABZQooT6Pxz91bdXAmkIATLclhFtgAkDIXpnYUYtTDtDQqVM3zHo9ujJz8JdV3y6THZueJWs3xmRplDrlb8CLoxNBhfMQK9ZHfAHP5tGlpHAJyWviHr2bmNOzOMH6vWguKWqas=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8303.namprd04.prod.outlook.com (2603:10b6:806:1e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 07:11:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 07:11:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <maharmstone@fb.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] btrfs: use kmemdup in btrfs_uring_encoded_read
Thread-Topic: [PATCH] btrfs: use kmemdup in btrfs_uring_encoded_read
Thread-Index: AQHbNGziJfOsc2u4a0Wb27Gf0n5fuLKzO3kA
Date: Tue, 12 Nov 2024 07:11:58 +0000
Message-ID: <0068a5cb-9972-440d-a555-c8cfdfdfd3ae@wdc.com>
References: <20241111190619.164853-1-maharmstone@fb.com>
In-Reply-To: <20241111190619.164853-1-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8303:EE_
x-ms-office365-filtering-correlation-id: 2685a4c7-3e95-4451-7a9e-08dd02e94c30
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dHB2T2tqVkoydGhkakRTUWZiVzQ3OS9ZbEJsMjczc3dDWmh2U2NwSVhOZnly?=
 =?utf-8?B?M3JaMHRvQjBCMWlCNklmMWpNaEJDYTVuYlQybTkzRVlwejhZZlZVOTZua3lw?=
 =?utf-8?B?UUt6QTQzS0lNekNYV3JPTmNmd1lPbWl6bmJzUm9QZFBqSWV1Tk1Mc2VsWDNt?=
 =?utf-8?B?aFlZckxxeGsrd2k4Vm9MMmRXZkpuNmN3QW03cVRIRVpPc2c0b2NIMG5uQ3or?=
 =?utf-8?B?UzMyaURUTHFGcU4vUzdHc211QnA4RVJndndwVE00aVlTcklkdm5na1ZVc3BB?=
 =?utf-8?B?MS8zMUJ3SjBFOUV5SUxBT1E0bnNjcVcrS1FUUUp0bnNORFk0Y1F6V3lsdi95?=
 =?utf-8?B?MFRmYUpoajJQVjR3dWdLa0wzMitpaU1IOTlHaWFrODQrRHhmQ1hxdFMrRGgr?=
 =?utf-8?B?V2pmU1NKRHMrQ1d5QzlGNlI0RllHUmdOWjZVVTVpNVpjakNkaXhpejcwVGN2?=
 =?utf-8?B?RHBTUXlENmg4R21WWU5nTXBUNUZQZnM1WjRKcWZGK0dlcWxqdS9nbnlPZVJs?=
 =?utf-8?B?bDRZZG00VklQMUVOWEY4YlBmbHIvRU9iYkJ5cDVWcEl2TDVQbVQxUWNPQ2RG?=
 =?utf-8?B?czd2U2FCeEpzNW93d25MSVhFS2hsQ1RqODNzOTNZQldtdHRDSGV3YnV2c2lR?=
 =?utf-8?B?TUd4REs1ckhCaXZKNnZGZkRDY2huYm1vNEN4Sk1vTzJ0Z2xUWFNDRGFBRlAr?=
 =?utf-8?B?K0h6d2psVHIxWTQ4S2dTWU5tbWpLMStFUURMZkdGa1ZpR20yNFRibkRBV1pG?=
 =?utf-8?B?ZnBIektwSnlPQlZmMElwb2ZYb21kL2YxMXJBSVAxTTBwTkV6UVprVnlXVm1j?=
 =?utf-8?B?emEzeXNrcFNhTWFmVDErNlQvaE1pSDhmbDhvVVZWYU0rS0pReHR1SmJ5QU8r?=
 =?utf-8?B?bzdsMnB1ZktPb3dhOHhmaEhoWVFDN3dSOU5Md1JZQlhkK2dLVy92Y0x6d3pv?=
 =?utf-8?B?MXlhZ2J2bUxIeXdETU9hZHB5UXRhZ2ozeWtMaGRhMUFDMFJ4N3puZjRORFkv?=
 =?utf-8?B?a1Eybk5sbS9LckxQZGxpaWlUWkZMdmNZd2tvSG50bWU0UGkvOHoybEdIWUlw?=
 =?utf-8?B?S0xqbmZGQ1RMMmlLTXpudHoxTSttYkFMWjd1d2Uyekc1SlBldUY5T1EwZnFU?=
 =?utf-8?B?YjFsVkpsOEJGR0xFdlR1a0JNOXl3bXN4a1VVYXZia1VWeUN5V2hQQnB2cTc1?=
 =?utf-8?B?SkNGbkQzL3ZUZFVVbmt3R0dRVzMrR2Fudm8rdGVISTF0MzlOZndIekFvYmdP?=
 =?utf-8?B?WFV3WmU2ZG9vMm8xMTdTV0lNaXpiZTBtSFpxUXFMa1djQkpJNEhRVW1aNVpI?=
 =?utf-8?B?aE10K0tVdmpJTm5XeU12a01jNjdEbk9PN3hpQmE3MW5ScVhPa3A0Uk9Cc3ZX?=
 =?utf-8?B?WTlHbUswSy8xRVBLM3ZjZ0JDbGl0TjVEa0o4Y2hxcWczQ2h2Y09Udzc3eS9u?=
 =?utf-8?B?aHkyRURTQ2xPWUhkZXA1bVJBRlZObU9YVndEbFRUREZ1VXhFNXpqWlhmL0ow?=
 =?utf-8?B?bE0yQ216KzM1K0lIdFlIeWxscEZzSTJLUEpOMVlDTG5WYkhmS0lTd0tsc3lK?=
 =?utf-8?B?Q1MrZlZ2MHZ2WEZCSGYvRXhYUmVaT2g4QkprNEVwcmFRYUh3WWtLTHd5RzhQ?=
 =?utf-8?B?dk42dXhJZEdISm55cjFFU2tpSFF0T3VUb0JVZVpnaENRWlhwQ083a2ZWN0RD?=
 =?utf-8?B?cEd1SEVqR08wbjQrVWw0UkFSMCtYeS9pSk4rQVdoMGpwVEhHaGpBaEtuRzYy?=
 =?utf-8?B?N01NNFpSYVVDMXZwL2hiK1Vwckc0ZmFUaUluUlJHRHdHMXVHTy9EWm45ZXhQ?=
 =?utf-8?Q?JZ4G+P3W+iTrOYWEI2J1QEqzaHna2Owz/G5kE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnVBWDFzRm1LU0IvbnVpN0xwdENFdzlnblVXcUpnWldONUhndktiS1BkZ0ZB?=
 =?utf-8?B?bEtKUHdsSEJTeUNnektoYUJhT0xsa3dMZ2JJNm1jbWE0NTV5MTR5MWU1MzR5?=
 =?utf-8?B?WVZNTFFVVmpRZkNRZG8xV2swTitQMDlYM0ZNcHhHM2JmQVphSWk0TW5nZXZy?=
 =?utf-8?B?Q3pGQUpWbTlTbS9BVVVDbUh2dTVXbWlBZXNudlhLdkZ6aVJhUnJIQnczOGcz?=
 =?utf-8?B?alMrNUlkelpIemxHOW5uNktyS3haeEhVNUVhNjIrNzE3RHR5TmorZ004cFBB?=
 =?utf-8?B?VlRXT1BJR1R1d0dFWG5wMlNjc3FPVEduMWhWVVBxanRvRmMyTnQycnM4VjdX?=
 =?utf-8?B?NXFEbUZrTWdwMlJCejVaMDFOTjU0VmtoRG1qNzhSd1lSc0s4S1h0M0lLVFJi?=
 =?utf-8?B?alI1dUxROFNQRXhKYzBIQ0IyczhHYnIrSXJGMDN3UVQxaXZwZ2tXT1lkOUxi?=
 =?utf-8?B?SGh1cGNyNTNxNGh1NDFGSTMvQXVDeFU5RWlIVkp1Yk9OcGNwR3Azdml6TGMx?=
 =?utf-8?B?dVI1RTNnYjhib0tCQkM5SnZMdVFMTnB3ZnZVdk5WTlNTbUNvbkJ4Ym95WFk0?=
 =?utf-8?B?QVZJaHZpdHZpdFYrd0JBejJaaE5VM3E3Kzd0Wkhna2w5OTcxdWthWUNCQTRT?=
 =?utf-8?B?UFlzQ0NrMFBtaFQzeVNmMFZGbWhNWjNTSTRjQjk1dzNRNUtqLzBqeXUxcmR0?=
 =?utf-8?B?OUx0WUJ5dmNod2hIU2FybE5XMm42Y2ZtQ2twMkVsZ1JYMUlmSVdvcEt5TGZ6?=
 =?utf-8?B?N243bjdmUWFSNktsbGdCYXloODJyTWJhcmRIdHJqWUpOSUlaSDRjdVM4UkVJ?=
 =?utf-8?B?MFNZbVVxT2cxRGRRQXpTZkNkd0tSdEo4SGtsTWMwdW8rcUdGS0lQWGcvSU1x?=
 =?utf-8?B?alB5dHNNSnRzNHFKekh2M0ZpYnd3cW13cVVTT1hVcEQyKzVsOUJUbzllQUJr?=
 =?utf-8?B?eTJTOE5abGZmalprYnlVaW1RN0JkY2VNS2s1UnFJRXN0YVIxS3ljU0VLTVhT?=
 =?utf-8?B?RHVoZkNmaGtkOWtDRWg1ak9kbzFvdkwrYjJqdWVGMTFaZHV0T2RCdmFBeGhY?=
 =?utf-8?B?WGdlQlpaS1FnYTJBdnIra05BN1hRNkQrSVJOQUFzK25STExDdDlNY29VUVNj?=
 =?utf-8?B?UWh6Ykg2ZjNOb0luc1Q3UGg4VzVNakxEOWxlaWJ4cHh5S1B0V3dUdU1TVnBP?=
 =?utf-8?B?VGc3VnQ2aHp1RFdIZGVqZWUzK2xrN1hKREhiWUkvcW9LVUtGbGg5Kzc5ZnpW?=
 =?utf-8?B?VEFPYTVuK0NPVnAwQ0o3ZG5JY1NXSzZuSElobmFJU2xJdGxIU3Q1MnJDcUpO?=
 =?utf-8?B?R1dyNUd4ellEd1BRaGJEQ1FVZ3QwbXY0TkUxVURRdHNMeVJUOVNhbkRsR1or?=
 =?utf-8?B?OW9NVUlvVmt4YjVEVW9JbFdORXRVTkJuR0ZVeGxRa1ltNjhBUE9IMUQ0dlhk?=
 =?utf-8?B?SlNpeE1Vcjd3VEw5OXIyN2g3SDlJK0tFajFzOHJFOG5lQThzbWhkWXpkUE5o?=
 =?utf-8?B?M1U3dXM2c2ViYWF0S21ST3Q0TVZiamNycE52WDEyTHZUQ3FBakxSSTdmMDVD?=
 =?utf-8?B?M2lmVDhvUDZzM3pucmNDZi9zaWRYWndxTlV0eGFxaWpQVjJ5eDc3KzJPMkpN?=
 =?utf-8?B?VWdzVGdlQ3VZd0JHR1cvNWZTL2RRS1dldWlPVHRieEY4SGlucVh0OEp5STdW?=
 =?utf-8?B?ajc2MmloMEV6SVI1ZTA4UFFmN3piUkw1ZmRPc2FkMzNYUmhlMnR4eHpIbkVt?=
 =?utf-8?B?WTRiRFEvOXRaZVVqZGd3ZkYxMk9tbXNVaW9EMVd5VW5rVVEvMHNyNnpoa0Za?=
 =?utf-8?B?OStoamNXWmJucEJBVnBoUk5IM2NiWG1CbUVaNFRUUXErK2l0b2M4dDYxRzAy?=
 =?utf-8?B?WG5sMDIzdStGMUJiY0NiTXJiRDQzOU84MGwyc3BBWk9JSEpyc21McVc4K3ZC?=
 =?utf-8?B?cjU2eDBCc21tSFRpOVBneHgrK1QvaDc5NDV4cXNXS043b0E2emFaVlZ1UERk?=
 =?utf-8?B?QkVGbDBiZzRIMDdKNG5JSnk2dC91NmQ0bVk3dWhNOHdUM2VxbHFIeGt2NnZz?=
 =?utf-8?B?SkNWM3NJNFRBM1c0THJXdU9ZeUhCTUJ3NEpiVlAwbGZHV1kwZ1B2bXZSMTRG?=
 =?utf-8?B?NTlCSldsQmhjRUp0TjJEWWlOUmlHRzlIWkRjZ1dvNVdkWGI3MExVK0NROHBJ?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61F7097E9E415142960B4D12640D41B8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vz/GbcxvU+seZJabnpcgoAVxwoSdI2z9xIdlyPyHOPzCOcvTW/wkxcuB5oHwEDiNXGdqcQquM79eHn7BzMAgCsDw8WzyeVSFQy9OXNSP20+FeymygzPz+XaCxtk8S+Mzok6AQfP8ScrW5qaUejtvt8TNFze/XyNkgXhr2/OAC+//GCAmY3dAOBQUPJrIg4LekpUVMHlfB96sNKVirK/Yym0troD3XR+UDwq42WlotFgesz4kbXdt+w3VHu97geLY6yvuFsf/3tRClnBGJtxIe3zlltQTPc4v6DPPjTVDKdz9KF9tDAsJbNGWrsaC1Q10UqMAtoBVz2lKyjqOdfaAl9TEUTngxV737eKO1TNRaUr2Q3N+4kZ+JXTu6qR5UhFL5IN5T6K0DA7MXDChFssGkMsiZxT2Mn0zrOLE/X9l54q2LduPbU06kYE4ocBcnKyz9KCeipAtZ/9GL7O2zbBLMBojfaxQMLt3zrFwavwEiuIi1OSa+poOyt7ur0SGs2psW/BtFl34bxmzACV5aUDZbkxbbo8WRAkbnxECfQ4ow3h95oNZtHMEFd17Uuwc1eW1j00loAGQ0AvctRvvmN2BypWH/vBVKo7Jgw/H301WTp3vtOEIWEeoF5MPnTTkkfXJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2685a4c7-3e95-4451-7a9e-08dd02e94c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 07:11:58.5146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGeA55bwOf4i04TjTcP2HpSazzVtEyrBZpMRbwxhUSTURQyFAo/pPwe8wP/iMNOlOi8dFX7TCEPnrKzdBlGY406KMNFQ1FiVvoH8ELITG3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8303

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


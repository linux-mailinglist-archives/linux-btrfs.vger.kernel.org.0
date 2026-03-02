Return-Path: <linux-btrfs+bounces-22142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O8BKhZopWmx+wUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22142-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:36:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0734D1D6A1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59D2630A6E98
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0330F3A0E98;
	Mon,  2 Mar 2026 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XiFdN5fJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T9vh5hBw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E003B3C1B
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447093; cv=fail; b=RGcXVwlVh8w/xlZUqpJl98BvYrRuaGvQCb/ctLgKBw8uaXalrPL/ceql3JKosk3JHFQ3S+zvJNJi+ftRc6/Ij82skHfRrrm1jaA/lB63+heDSrttTgRHRFwguVHyNpHpdMdawfbKnRqaCsMsB8/+ykUsDE5xKZRy6F4N3W+HWT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447093; c=relaxed/simple;
	bh=NaznHtrCHB/DMufR6ByoA+mGBPHhSFv9hwL+L2I8s90=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OBP7j61Krk+8MQn7/u7JxjhaKqz2Mnq/a/Vtt3gWJvyEwIvAW2v65wnWCKtlvqA4j1b7pbS6FJ5ggY0PZC36A+d+saLD2FzWOuiC20vasUZYi8zvf1e2cviPo4MvtBq1rkoSvjCGJUbgt5uygczJmV8RStsvlejyI2b9EnyUHYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XiFdN5fJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=T9vh5hBw; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772447090; x=1803983090;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=NaznHtrCHB/DMufR6ByoA+mGBPHhSFv9hwL+L2I8s90=;
  b=XiFdN5fJpUW9Vmu++otb+c/t+9hUQBHTtbm4GA4l/glI9wXvbi+jcfEt
   h0XjhW7jlSkbVyTu2w37JsCmMpAtzGMjZE/2jmPpRdmxzQKXED2vUgjmA
   Y8pH6eDo6dTEG5AAzAAgoWz398ODsbyoQ7UQBEr2JwpRUpa3yeuBjSJ++
   mi/43K0FGhtPkUrXp+MhVIpI4vv9xLkQ/IWPgcrKZ+JnSM1isAZL6UEyc
   fQoedENnD2wMet4YU2GotPnDEXrl5RPSMOaLUfu8MyipnxcWeyf33PQ2p
   xMUF+6nDUosnMoMxwjPvBflxPdp/AVpl2T4iC6e7HtAMr2i80nwrNvQuM
   w==;
X-CSE-ConnectionGUID: l7jkY/jfSc+kCd3/wOAWaA==
X-CSE-MsgGUID: Uz4ySvFrRZW8FSNFEqdAnA==
X-IronPort-AV: E=Sophos;i="6.21,319,1763395200"; 
   d="scan'208";a="141726698"
Received: from mail-westcentralusazon11010013.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.13])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2026 18:24:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsE9X4kK+Iay2g012nDMTlb9aZN55X0ivbPOKgMKj+PSkQbxeBRvavODXgjuNhGpzma+KWl0fBlcIUUHKuHopvlbrTwc8L7ILLuvqH/tZw4duPaIB+e88P4x7jo7BfeNETi/gENjpzUZsVFJrcttM83IWdomiwskqJ/cYUnzW/f4YXQeVxxH8hil4A785sfcw/kbY73B3VcT93/X+kHd1BjljsU2pd0lseJb1R1K8CAAdfKvnWcLcxbPn9Rq6LypzAgXy5AfZQOUmP2/XvI8TEZ7JL36PJyFPqBUOHEtCzOS/Q7F50aMN4eZMJa2SH/zpM51Oepr3etKHEWa8yoTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaznHtrCHB/DMufR6ByoA+mGBPHhSFv9hwL+L2I8s90=;
 b=OoINf4mbwf7SM6MxOE08X55vP70YFichTbCt/9GCS5zHFKztGOEB3Gm/uTdpMUfBtxxyfW9Aa31CPmOXY145E7ExuFaSwn9d3wiIbcZMOTUBSi7jjlZYMNWGdGEXZOiMiXxgVcLpHfzplEyqELTxdCrteP/DR48kEJnxqvYHWh41UZWLFTiHM+pY6mlQwVqZ+v0tKPj4XmJFaUqywLmdGnc6QfG5buHa7dGEqe7eO0M2JVhqRI9woXfw/wA8DiO4ss9Lg31uaEwNig+bIBLOtETtZcXocdSt1LPJMcKjXACStV90L75RGeaJvtJLWwtL3UoQ9yIWVSLr14afvivFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaznHtrCHB/DMufR6ByoA+mGBPHhSFv9hwL+L2I8s90=;
 b=T9vh5hBwdbwGfMWHdeygZh0pBWfa5UTwf2W+IRjO0MLiKaub6BBCPcuqKhFD0Y68sWFn0iDFwQhYn6l8YJEY4wG7SBHiyOObOv+OK98YDMA6HSuTvHlNhmRLWgwCo8jyIFkORYNaIrXZEovLCJYtwORdWV5ZLvEZq8ZsnOvW9cE=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by IA3PR04MB9332.namprd04.prod.outlook.com (2603:10b6:208:505::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.15; Mon, 2 Mar
 2026 10:24:50 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9678.014; Mon, 2 Mar 2026
 10:24:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove duplicated definition of
 btrfs_printk_in_rcu()
Thread-Topic: [PATCH] btrfs: remove duplicated definition of
 btrfs_printk_in_rcu()
Thread-Index: AQHcp+Lco6p0HSW2okudYlVtHCYc77WbDdOA
Date: Mon, 2 Mar 2026 10:24:49 +0000
Message-ID: <28c1c541-213b-498d-b07a-6d3745fec1f6@wdc.com>
References:
 <826d740b6c68bc0d503bcfdf1d45ba0f38872846.1772194240.git.fdmanana@suse.com>
In-Reply-To:
 <826d740b6c68bc0d503bcfdf1d45ba0f38872846.1772194240.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|IA3PR04MB9332:EE_
x-ms-office365-filtering-correlation-id: 694e5743-57d8-455a-ccc2-08de7845ef7a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 hVotDdcUZXq+VVK72P4TjjGJ0qhYW6Fbxk+nPkSrBJMsvJJ6AwLAh5PD/NFXaOwayepMchZ3xjeFIuiBDt/CU4TONC2Cxcki7Ygn/DBm1A0SY5LgG/0FD38W2XwUosGe4gVCM1ZvNMZ1cux3MlUbPVrSyqYv4mqs5VO8v8y6Pz9KWTmfsPTSsWH4ICYHobTT/8VZ6zXUAC1yHM7sb6ORIT9gM/SDEJimV7gDVzsrHOoiBE7nGEMqKL7Ea/NBexP04RFZsbdSg8dsWXIkDjtoFukhtiGBY8Fu4JpzT9ijn/A+DZ5POJaM7b2xr5KKT2MzGfH8pkzq2Yp9KTMwmUHMQphrngqRTkm+1MFrlxbcSoDMVeaA71UNa6+6MEpDbm7siVf02SpHj4mHbx+UCNwQt9uiESzRRcDFZv+KlSfZYrQwZ3ffFLcTLQhAAsUgVAiBk0VXR2cpPsvY0KiLcfs0XwehQ4ca/O9v+Ko+X9mizNOifeIRom08b8FX5dIjHIjwTBZnN0n7TiXmVIZ3UYR2IeLVIsEnH4hffo2AtqtfzYNJcSHpk34RGHMrdmwqVENLBuphJ++vOv8jMx5xYC6+ZmaEkxNNjgKGQXWBqxQ7NNuqqp8LUaHVlv31TJNwA39CWict+jSljoNDqw3U4K75E7O0Y4Wkuo+W97xRpUCn+wDdZNdrOJI3968MrKAhMxczWG7lp75WRv5EBmOpXiyFAt791pcGjb5tI9YWHizCL4gFpR8Lo6MQoon3ztKrsJyMfxb+fKdWdqi6X62U8upTYtinD0MXDjhzQnzt/CY/3K4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L05XdFVaQnQ1QTZjbStXc2orRlBWS1RlZ0hLdlZNc3doVGt2cDQwMHpVUE9t?=
 =?utf-8?B?V016eU9DbGErQ1ZGV0xGeUJrUjFhcER3aDJYWHFUZDN5bUlVSkFWVTQ0bUtt?=
 =?utf-8?B?UzM1ZDNwYm9BVkM4dzJyK2pTYURmVXVyY0k3dnEwMkV5ZTRmWlZrWHZxVngw?=
 =?utf-8?B?bWEzVk9vQSt1VVVycDU3WVhpbFZBOTEyOW0xZUVIUldndE9vRWJjTmxSZUJF?=
 =?utf-8?B?NXY1azNJb2UrVjJ2blp5SnNyazA2L2tVQlluWkpjODBxMGpVZVcvcXhFMkNR?=
 =?utf-8?B?bXFFbDV6VE9CK1pvMjdpQVFKNmdmVkRNZkZuOU4rSGhMY0x4OVNCV3BDdWNI?=
 =?utf-8?B?akFSZGJLUWNLZlpUT1c3Tk5KZ3VCOHlaSlU3UjB2ZHN3ck52ZUk3RzVGRkJI?=
 =?utf-8?B?WjJvUkF1MzRsVE9vYndGbUJjMG9XOHVOUVdjTFBaWHNsY1ZnekcxanhwUHJo?=
 =?utf-8?B?alJaY3FVdE1RdjNpVzFjYWFmVDdEZys4S3I0WHBrSUZRTDhacFhmandlWnl4?=
 =?utf-8?B?U0N4Ukd0MDRDZHFnd0RadnFzWGxITW1vTFRhcXo3VU4reGJCWWNLV0IyaHJO?=
 =?utf-8?B?OFJjeStUdzBUaFEvQWFVRE03OWoyNkhEM2RwRWNmVEZFVGtQM25QNE5EcnAx?=
 =?utf-8?B?eWxDRUhjV2ZvSVZqQ005MzluQWx4Ujd3MitsQ0pDdE1MTjBNbmwxSlRoTlBa?=
 =?utf-8?B?NWtJa0d5d0JtSjRKR0xuOUR3ankyVWMvYkJWb2VaUjJTSWtiUGYxU25kYlVx?=
 =?utf-8?B?YWtrS3VjK01SRXp3T3VLeUxLbWM0WGdVUUs1QmpnNVBIbmkxWU9IOXYrVm5p?=
 =?utf-8?B?TVViS09rdDlUczZUeVJsRnhIaWU4aUpCbklialhKVVQ1SUNIWFJRcWRtbTgx?=
 =?utf-8?B?QjV0Z0ZmRjZ3VVBNQkhJTzFVNzdjKzdXektlTHJpN2RwMVRxcmhXcWtaZWFn?=
 =?utf-8?B?SFNuWUFONWhKbVllOUhpTkw3ejJjNlZHa1NJcXNUcHZsUUZnb002RFQ2cHpt?=
 =?utf-8?B?OGR1Z1ZpVlhwNDdXK1JtUWVITU8wTU82Y3pkT1VpaVlQU2E1Q0xZaVBVMUFF?=
 =?utf-8?B?TCs3alAvWHgvOTJ6cUJvSzREMFVhVDRGWnBkT21RM1ZxcWdLOThKUFJNZTFU?=
 =?utf-8?B?RUYxaE9KalhZSmdtUnU1cEZsajg0MmJjV095ZTZaZWwwNVVmR3dlN2FOT1Fw?=
 =?utf-8?B?NnNkQ0JENk9GeHE3bUQ5Y05HeFJhc1dlZGZWRTk2Vm9XWENYQ0pTVGlVQTJv?=
 =?utf-8?B?bGVvRFUyVWxmMWJya0hHQ2ZaVVN4WWcraWNraW1DOXB1RkNaZmMwbm5ZeU02?=
 =?utf-8?B?ZGlPRlRybE5nNnFDdEhYdlZkUEVQN2RtWlgyWW1ZQ1hnYXNRMFpSclVjZGtx?=
 =?utf-8?B?N0g0bmVyWFNIcENkUFM0VTNadTBsRnVUbmxHMERjYWQ1S2dIMGFHci9RQ1Vr?=
 =?utf-8?B?MERYNWE2aDgyQ0paeTA0MFI0b21SemlmeE9JOTVmU3QwQmRGdEdxNnR4NStT?=
 =?utf-8?B?a2p3aTlrYnViQjZuR0ZhYk9jT0xFS3lsZTFwWFl2Ukp5Z01tdnZNeU91Wk8r?=
 =?utf-8?B?VUlNTjEybk9tTkp0VkgxUnNFSHJCeEY3clZRRlJTWnhDZkNjM3ZreCtNVzQr?=
 =?utf-8?B?RWp5S21FOCtWb2ZOVXZicmczRFd2aFhjVjBHWjdDUE5XK043Y2ZBSyszM0pj?=
 =?utf-8?B?L3VUUURqTU1jZnlHOTNxNjEwZDRaL1RGSzQwZnFKSmtXdDArcHdLcytzVWJY?=
 =?utf-8?B?WEgybVBmS0JXNzN5anAzd2lweXVRSXV2NG82WnkrSHhKT2tCTEFZZmY4OU1u?=
 =?utf-8?B?djJSZ2Y1OEZhRmNMRTJkeExkV3NpTVcwQmIrZTRaU0hCYnJwa0hFNndLUVpk?=
 =?utf-8?B?ckNtRklOaUhkVjVrcFllTEJTVGRSRzJJbkhOSUVJS1ZyMjd6NHR1UEFvalVy?=
 =?utf-8?B?Mk9KMXRsb0FuanhaVmVXVE9NUDh4dzVOQlFpVUdHL1hrKzdXNitGWHVXQ0d4?=
 =?utf-8?B?R2dFd0J1ZHp2TXhwQklueU9YOHYraTMxSnhXSmVQQ1BJdUhxdENHNk9zbWN4?=
 =?utf-8?B?aVlKNmNJMC9iTHlrb1NGM3BNTEZ3dUVpWjZ1YW03ZkloeGsvSUYyNEYwSllN?=
 =?utf-8?B?QTRIeEliY1NzbDB1eEtkWGRZcXpzd21iNjJjS0ZxWGYzdjR1Q2ovOUlUNEpo?=
 =?utf-8?B?STZ0MzF6SDJCbzd3K05ucElGVkROMms4U1F4SnByUVAwNDdGMkljKzFoeGsy?=
 =?utf-8?B?QkYwKzh3czlzYUlZQjUvVldxMGpjaUtkVmNnWWZwWElwZlJwOEZZTjFseVhM?=
 =?utf-8?B?UzhaV0Vtcms4UHoxSWVLVkw4Q3lBL2ZYSlhaeGtMMThUOXpvTmhUaXNFOElC?=
 =?utf-8?Q?z6hoDjEz54jc1QgkTCXjkhd5l71axSXKcN/dATHQEq/g4?=
x-ms-exchange-antispam-messagedata-1: C/LkimmfjBxKLNu6rhqcCS/VIgBKyeTz2vQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1EAC0F806C23C478BF3928565F8C738@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UP/dFDFLBKuOqWWe4EOULM97FL6L3NnAqiFdkUw42utFjw92TAdliOQVaEdW6Jp4m79ForrHZ/W66LJr0fl89AddIktGiMgYOyi6rA1ydhJL5m45Vu8IdN9GhuxxeReM2iDPVB+WX39+S2m49iyyRu9vbsiE9J6Y8NgGlt8wsEmxap3wp6skr9lZUuiMrZSyPxGUnGct7YdtrVpJdNbPVf472TGlTtcJ6kacoTWxXV9TOEe6Ni7C8vawsVp3BOySF/qWvkjhTw8sdFQbnXnPdQn9YSLa876U0OzMiSGKw2/hU8AuW1qFkQ7AjlkPY+81Q/5DbYReKA16KkKW0Fmqj2VGKyzqXayMR6Lo7uVZ/bqVYfJ9QLGxa1GbP8UYVus0JE1QLgYuByORd4toXM+QzK1q2NQAd247Yr308z0aQT1LfpGxNpWCo2dh/PfKSkqklUF/mMldv6SNjUyo52GwN+kAOdPuDlDy12w2d5M7I5k5j/HunlyZ/gKep+uFvaZwQ0lnIj95hAoFdujpPK+l9hjIR/6HsojSsnEoWwfmDdveOagYvOlbN9nrt4kU8crgQHTYf5hupLuCo7QOCwvrsjPw/dunvq4LteYHtSORlOawWfxDKQFemQUCbACJ3E+R
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694e5743-57d8-455a-ccc2-08de7845ef7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 10:24:49.8234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvpUKoSHQWS3z6JfhbSX16FVJKWh+v1Zh25Ss0r9wHvPqCuSCBgFd+WQkDfVKzXfZayCIgwivXfWrM+QxvblcJSre7ugT9YESrP8KjA8C+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9332
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22142-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_MIXED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid,wdc.com:email]
X-Rspamd-Queue-Id: 0734D1D6A1B
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg0K


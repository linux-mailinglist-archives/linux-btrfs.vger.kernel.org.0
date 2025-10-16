Return-Path: <linux-btrfs+bounces-17889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D123CBE42CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D512508FBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FEA345753;
	Thu, 16 Oct 2025 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K1pPmJP6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YJGek3bi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94750276
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627799; cv=fail; b=TPvs4K6HDduSdp0omQCkrnNDwNH4L2U82Wl72MNc0wJa5r+owTzoE272198mWTIuew6Pw6fJj6wMUV4eCgnv+oUXOOEPdoS2d3frcWc+WSbcNIOCgoSwLpsTFvka+PV9TiZrvvA3RUbVLPmZHU0FeLCETFnliWL2WVL4KKvTF4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627799; c=relaxed/simple;
	bh=f5iL8ib7eJ+3hGCE8jzXqiSDeRWRKYlCvTFHpYVPagI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Em0/JgG71B/sGQLbxuTY5AGBMDblbNviklxaxUbaXr4Ej6LHHZ/F/1D1V8rMFWU6kiuR+d0kQFEx07E44y7QBtzG5HGFWAps6lJj5g8PtnNF4rcPjG7hhdx0w2nu8tO4BXoNpTZ2+lXium5B2fDSVMN4gDiltsPbkKYtNr5jDSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K1pPmJP6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YJGek3bi; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760627797; x=1792163797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f5iL8ib7eJ+3hGCE8jzXqiSDeRWRKYlCvTFHpYVPagI=;
  b=K1pPmJP6Be/Cbi+Q6ITEHDESLfLEGf2d0jrt7cMTvzqQT54gzWHRh4NI
   +/I3ZcAQM19azqOj1eEeOfsRPij7ohk43egHYc1+EhSVnZWvdKkeU1KYO
   cJwZA9wcMndW5H9rlR1vKF9qwCbzLinQawRMg1YfWiCmEp9ZuMuoid9bl
   uHb9DQ/lZfIBfCdXtbjEt5OnokMA0BHRRzrApRzjVwNBU+PM1KOA3vAOR
   x0kDIPYx+awF6s6v9ixs33wsRMMkGznLGAPpLZ5+rKO9ttMmC8a6bJa+Y
   GxU6airq58s/QjZjtdWDKgbgexfQsLBc5THh6nJxNllS47VhoxuXNakxq
   g==;
X-CSE-ConnectionGUID: CthxPZ2+S2O0Ebdbq7ODBQ==
X-CSE-MsgGUID: 26qJdGI6SbGxkD80cJZTcg==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="133353866"
Received: from mail-northcentralusazon11012060.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.60])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2025 23:16:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9Z3yc+uMUBO+QTI9slb5UmYO3dl5t5GCAYP/PK2nKFPbDpiWgeShK3DBbp8x+kOeXOSMXykpeK0tdu9I2Z/MIprCFH7JzCusJEzjEJZzacgVdnn240QIEJE1adw9Tpdp4ZtVd/xq300F1SP8Uc9/p1/lxyZtMRpMDDF+Zek0LNg7BMsqxG6w6o0Nk0vAsOqYIKvwrcXKDhStczapt+mOc6+lQTSYVoXBl3BbgnxwcbsOXuVXPH/sv+O0PDNfv0lXWtLmBdVRU8x2I1OxrLKEStb0t03hpXkJ8PATcheR8jX3KUOvG53pN57eGqzeO622zycmkem3SKgyjWpxg/P8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5iL8ib7eJ+3hGCE8jzXqiSDeRWRKYlCvTFHpYVPagI=;
 b=OMk0yPmloweDt9SSV8UQXJjRmV+oxr6KVkPUVd1zaNexaVyinokR2ysrrNQCVJZBfA43XkyHI4IBQqD1XwMzttnfZbQw4yzJZr/a9v2yTc/MW1VdstzOvUUfCLehdg/g9eNGBVdlT2f310fZ5KMLdNL2aHq8vykKpkGOCcMm18BAQjE98ae8O4cEAx0ObCuKNMmOS63NhwGwBe5uwEBRm6O2HvfDxpFo503ibWsOL5/3fN0FUUmzorfXC/jdaMF6Z7qMiyZ4rIGU/jEYPIuJbAhiNrIkyu9bTp3wRsgA+0q0q/ArVxtNmMV3dkbumJFdsG2RprGabrhTT175YIV8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5iL8ib7eJ+3hGCE8jzXqiSDeRWRKYlCvTFHpYVPagI=;
 b=YJGek3bipVzP5Ycz0L7hLSterDsTqUWwDAHYu+2Kc9ILNoXRTgvVs1aUkXChUjenA+tWdt3zAhq6lA739dGf/cXenrTgIHn9yyKUzlwX9dXqJ2mNstIv92jhO81r8bvA8elqqBj8f0nNIIELPc974ntSnuqdxh9mqeBAIMdGiQo=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BY5PR04MB6293.namprd04.prod.outlook.com (2603:10b6:a03:1ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 15:16:28 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 15:16:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, Sweet Tea
 Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH 0/8] btrfs-progs: fscrypt updates
Thread-Topic: [PATCH 0/8] btrfs-progs: fscrypt updates
Thread-Index: AQHcPczzJY/X/w3KL0+m+3XOs4tX57TDtL2AgAACZACAASz0gA==
Date: Thu, 16 Oct 2025 15:16:28 +0000
Message-ID: <55e55d84-d0e1-4e5c-841c-b75a04f557a3@wdc.com>
References: <20251015121157.1348124-1-neelx@suse.com>
 <84dabbbd-1b7b-4d51-b585-d3dcad3fd88f@gmx.com>
 <CAPjX3FeuNDtzGRH8EGw3WLsTpOiszDdAVJ6Yv=rkkpjv8qSyzQ@mail.gmail.com>
In-Reply-To:
 <CAPjX3FeuNDtzGRH8EGw3WLsTpOiszDdAVJ6Yv=rkkpjv8qSyzQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BY5PR04MB6293:EE_
x-ms-office365-filtering-correlation-id: 05e922ca-3820-4320-40d5-08de0cc6fa99
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3p0Mk1QTnBBK3NsenZDVHBNejlkRkZMOGhqdjJ0TmUyTDVVTm5QOEFWeEtN?=
 =?utf-8?B?QzNKVTI3VmZzQVA1cDZlVmVSQWRMSUdsSEhqYUFUTFJ6akQwdWpqVE5mVkRz?=
 =?utf-8?B?T2RiSHVjV0dVelFWdFBKbDZpVUZicjlCTFUrbEFDZHh3Z3lPUC9IRTE0RXJa?=
 =?utf-8?B?aUxUa2hkekRIMXR5NDBQZDhjTnhQZFNFeklLWklORGdxS0MwRno1VjEzTzhK?=
 =?utf-8?B?WWVITFhWdEZhQ292VHUzWDNiNUliS3Nzay9wS0tzdCs4c0QxUkYvUUJyMmV4?=
 =?utf-8?B?QXcyejdjM1V6VjdpYVpkUE94eHUvajdPejFOam8reXFvT3BrK0YxbHRXcnF1?=
 =?utf-8?B?UXlTd2xWRlpjbUcway91QytRd2ZjVS8relhYTkYwc3A4d05ueTF6YmpaQTBt?=
 =?utf-8?B?WElab09oSHJIZ290YitrS2k4dy94NjlKM0Q1ZHczU0NiT3c1aEtQc3ZPVG1m?=
 =?utf-8?B?YituQzg5UThKUzgvZUxseFpjcys4UWlrNXpTbU0yd3hPZ1IyNTg4OXM4TmJM?=
 =?utf-8?B?T0xqMzh0LzdORHhWNnEvU1NNb3RYVy9DaEVuNnlYWW1qT2Z2ZTlLSTJ6ekF0?=
 =?utf-8?B?MUVtUnZsMHJIY1lJRzRmelJHM1FncUxJRFdHYXdqZHJXb3hJYmRtQXpkbGJX?=
 =?utf-8?B?OGVUZFQ0Q3lKdmJhRmgvd2Z3MUszYjZsQVZCVW9PTlQvSmhJYWR2RmIvNVJG?=
 =?utf-8?B?eTNOVVJDUXF3L3dtWDdlM0tpT0I3ejVteEMvbUNpR0xMa2U0azhVWWViNnVt?=
 =?utf-8?B?VU1GaXd2dXR3VXdTRUVwejdHdWZZL2RQWCtacDhsVjFWaFRxbHp4bzViYXhW?=
 =?utf-8?B?MXJtSE5lWmN3WnFzcW1zVU1kR0hGd1M5Ykw1TVlrZm5yaUxYajZqTVZoNzBx?=
 =?utf-8?B?d1Z2Nm9CY3BZelpTbnY1SWhpOXBrVjAwZ0VHTmpicnpCdmErQXk2S1BRTTRq?=
 =?utf-8?B?MlFGQzVKMU9kcUYza0dYcW4yV29SVUZsSkV6U1drK3F5azdnNldzV0hkS28r?=
 =?utf-8?B?M3JUdHByaG9kclpHd2VDbVR1OEsyY0lMN1A4aUljWEdxb2xNUDA2aXpkTlNs?=
 =?utf-8?B?M2hNTVFYSkRUMEVyb0RRSkJEdnZxdEZqbnNPOUVCcTVxdGtkYVUyaVA1MXFY?=
 =?utf-8?B?bkMweWRPTW1xd2lyWWwvOERhamhmZWhGSk9PeTJRNHR0eDNDaWJESE1jaE5a?=
 =?utf-8?B?ODlNVEZudUxRSERSQ3NqMUJxTElGclcxaS9zcURmRXg1RkM1dkt1SU91Vk1h?=
 =?utf-8?B?TGFtTlVLV3JWTnQwNWVnQ2p0cks2NzZ5ZnluREtsSzZzclFWZWR4QVJDQzY3?=
 =?utf-8?B?eGY3RlF3azBYYXh4b0JqNDJxb0krNjRmYkJER1U1OXdRQU9HclNKSytadW85?=
 =?utf-8?B?VEYyZ1E0SzZXUnMyMUpVeXg1MTFxWktDK1BKamdUTzVCMEtvRG83cnViTkpl?=
 =?utf-8?B?UEZNZHV1TnIxOWxIZjdlMGR0Y1pnY1hicmM3L3g0MXRTcENyTUk4NFlFRWdj?=
 =?utf-8?B?VjIwSUsvR2RwUi9NUGNBN3ptZEE5YnlpMnVGenIxVG1aRWUwb3lOZW1ZTHNR?=
 =?utf-8?B?WncrWlpWaWRXZzdUTG11eHcyQVhkbzZpMWMraGtDNW1EeDBLKzVhNnJsMWor?=
 =?utf-8?B?Unc4VWxyRkNycUFqcXNHR2xVcTVoSTFXMjc2WUROTnNsK0cvUXBjWStlWGE0?=
 =?utf-8?B?TDM0bC9PZHJEeWNmUzk5MThhOGlBQ0NvRGI5TE9Kd1dDL0VLU1d0STYzU0l0?=
 =?utf-8?B?TjkzbTJRc0xweFNTVU5sRFlzcFpsWEtCTS9BcllkdFQ3cEVzb0lpd2l4RjhL?=
 =?utf-8?B?bzNqczJPNkJCT2c1ZENPMGpxUlpDRmxnaWt6VHArdjk3Q05oOHc5a1VHWGk0?=
 =?utf-8?B?SW9zN0YzamQ5ZnFnOE9RZ2pFN09CSG9MaDNTOTBNN3JVdTYzY3h4clN1Sktt?=
 =?utf-8?B?K3BFU2l2ZzB2NTF5aitFUFNLRjRNcjBBNVIwOTU3d2NvOE5pVm8ycEo3V3hE?=
 =?utf-8?B?dWZRUWJOSk9GTkVScXZNZ0JCUkpETkhNZHZmODdyTXdpODJwSnFrenc3a3hr?=
 =?utf-8?Q?9zkc1V?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzVKT0duekkyM2RIdVhRTGJtOElmdmFzYzVLU3ZJaDlPNXhPdFBXVFlxWkM2?=
 =?utf-8?B?QUFKQ2cwTm1sVWVSWHAvNmMwWUdhcUlpNTB3SHpPbEJtWGt6TjBZTmJCajVs?=
 =?utf-8?B?QWpTVjdCVkdrNy91VG1XZFIvNGg3Nkg2RTBPRnN2enJWMW5qUnJPb0ttN2RQ?=
 =?utf-8?B?TkVySGdOOURpeTIxc1N6ejNSWVlGcVZkdy9uNzZaaDNxMUFDYm0zV3I4cndT?=
 =?utf-8?B?Uit5TXhOT0Z0Nkk5MkRZS3NHdmVJUjVFdUVkSXcxa1AwckxXMURDaXVvTHF0?=
 =?utf-8?B?VkloVHhPRThtT3ZNTytVbTlCSmJrTGcreHZRNWFmT2tVMnJjSFBrSEV0blZq?=
 =?utf-8?B?TVRDSVFEdXZGZHVLRjBzNXl6b2VKM2JEekc3MGNPQ3VwR1FuQUFiMktuWXky?=
 =?utf-8?B?REtIcFcyWG1seEp1QzQxbXFrRUZSN2JQNmliYTBVUTNjVVZ5TU05YWtDS2E1?=
 =?utf-8?B?Uzd4NmVYaEtRNzhuNnJMUFFqbWFESWRCYW9ISllxMEZObG5xUTJyS2NsWXdD?=
 =?utf-8?B?OVhLVHZidGVSbzllNzlVcVpsNk9vYkw5Zm53akwzQTdoQmh1ejczaGwwOGps?=
 =?utf-8?B?MHNNY2Z4V2Z1dWlrejlyZ0c1OHlqYXo3TlRUQ2prWTlZeTNOTjBRSFJPNEUy?=
 =?utf-8?B?VHR2WHJJOU5kbUJ0Rzg2bTFnLzAzNlNWeWlvTTRxWUlLMGxMQkRGeW9HdjJH?=
 =?utf-8?B?ZkU3dDBqUGRUNVkvS041ZVNyZlBHRUgxc0pDb0JaQk5QTmI2Z1FyMGFMM2sw?=
 =?utf-8?B?ODFxQWdXV2crcUVERmN6SVFSb3BmL25Lb2RmTC9QMk9JMWFLaWExdmJ4S0FJ?=
 =?utf-8?B?Um1RU2cvcGN6K1lmTFRoOVpSZHlqVnJoenYvTHlqK3ZBcDROZDBGL3F6RlpU?=
 =?utf-8?B?endGRWRKMHdJNnUwMkZsaUlrVTZYNkxJdHlub3FjZFdEMHJNZ3BYaURQWTAz?=
 =?utf-8?B?c2pwTUJoWENsTktOUXJYYmx5MCtDRjJTZUlSR09RUWw2L3M3dmJCZ0p0Zkow?=
 =?utf-8?B?RktHclJDYUlMZ21IU2JRRlFqYUlLWlN6YitkcFpnSDZjTUlabW1qaHUyZU1K?=
 =?utf-8?B?ODcxNnl1dVdFTUNtOVlGemZ3WjA5MWMxZUZYYy9LeUtvK1NhMmY5WlhuRnB6?=
 =?utf-8?B?bzBYL3Jxay8zWFUwZFJBRFRycmo5LzF1MUNJc3E0cHg4Q05Tb0g4N244MU9n?=
 =?utf-8?B?ckp2dHV0ZENqc2pIdlhEYTBqL3ZMWnRFa1RFckw1OS91UW45QnN4dWM5ZU94?=
 =?utf-8?B?RTB2amM4cWpkYjZsQmlZZGpLYzJNZmJkSElJbjQ3K3c4K3phLzQvNm9BdDFQ?=
 =?utf-8?B?SjZBaDMrLythZkdzL0tpcTZpY1RTZkVGTjNWWURrcUlzME1YamdoSVFGaGs3?=
 =?utf-8?B?R0JUYjlsMjBZSVlRQ3g5aC9rSm51ODBXZzgwUVhyWDkvblFtZGluVjNBRmJV?=
 =?utf-8?B?TzY5c2d4Nmk1cTZlVDlYSk01UXkrOXZwUTNLZTZFaXI3WWg0RDR3RjBaRnlw?=
 =?utf-8?B?S1N1RFg3ZU1VSXVkSkRFTk5pVnZsNkJJRmJ1RWRPRnoya2VheVY4MmxRUnZS?=
 =?utf-8?B?dGVGcHZKdWVmdjZZOXlRYzNNR0c5c3k4Vk40SnpUWjVUdW45Sm1aMURWTGNY?=
 =?utf-8?B?a2JNa1M3RGRMZ3I3WWhMSEVncHVBMjhDcEVMRCtrOElYblkzamFZYmJ5WHFB?=
 =?utf-8?B?WjVCVW5sODg1R2kyZ0JPYmdBUVJRdDBuY2JJNDNtYTNHZmcxeGtRdUt2eW1I?=
 =?utf-8?B?NCt5Q2lKYzcrTmdHRWliamJURnMrUVIvSUNpRTQxMUd0YnVCOHNTNUx0OHp2?=
 =?utf-8?B?S2E3NXhQZ2FCdC8zUmFTMXhlZnBzbVBtNjJLcG42cTRHK0tnQXBmdEFIWW5S?=
 =?utf-8?B?amJsYTFzbUcvazRncXpvSXhWeENZRzZRQkNjZ1NlZlZCOHVYUGtJT1JrUFFN?=
 =?utf-8?B?VncxL1lZVXB5STF3cDdOOEU3d25HWkVlSkY4MkNYcUZsSG0rRGdvTDVpUWNI?=
 =?utf-8?B?cUVwWmNzSVA4a1dGbjI1VGdqdkYzMU1JWnRtY054OGRNZDVLRUpyUVVEbTB4?=
 =?utf-8?B?VEk0aEtJbExWWXVkcUZ0WVh4K1ZKVCtCWEtYa1kzWUlVUG1iU0dnajRwR1NI?=
 =?utf-8?B?bVp0WTROTVl6azFidHZNbjlJTDZ0UlYvd1lBQy85VWw1YlQ2VmRnaDdlVzM3?=
 =?utf-8?B?ZEpIRHFsYkdRM2VoZENnZXlhbzNQYjFDLzhSYTNnbWEvRTY2c2lZTENrdWVW?=
 =?utf-8?B?MnI0WkhHbEtWalQxRWNEZC9mWWlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15EA6A679C30DD46B583E06FB8530491@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zd8uzGsZpzbzEbIbjJgSFLtGd6SCQebsjnj6nCJCcL5wEVZ2JabvXF4Qmg5Tku+dNVvOeJVGndoL1pKxRaQNlQ3nhXiWYZ17pqHL6ro9q4NIvYHw0mKTk/eS1dJM5m1YT9hitRXgZfp0Kqctx+dyP4+NHsPG7wWVDH9wK4OgPIS4W5uotogDVJ3DCXlGDQZHmNyAuHJNoZelemkXHD0unVP2qDJg7qhPwbgYAbtydaiY9z64xjR13+DRja6kQyhPH2YXaLPbReCTECviyvXeVkyHLwTGYLlgkzlQUE+Gv1IUGy2OT9w+2BAqRWQjpYiXYEOINMPu9PgMDqsh8TySiSMLsfZBb8oku085E0wbbD+Y9SUepuDReHf4YkGKKuJsO0yq5VfxmuM0AOssq5fmdvVQjEtD6vGbYuy7GnjSv9H+JgCjjUlf0jhA9fpK78Knurn7CrdI1LHWY7IvnAjg/QhvYNQfBuMwunLBE4zID0g5iQjKmQlVzWC3peK/BRPeyA0TzDeP84ObZnOux5jRwQNmp79EMg+zGJb3ImClvKMTf0F0EX6VLnNgyTQOZPQQb0+d4RQkpEG0MPOCxSHqk8XwdIB8IxpId1EIjo8QIv7qN3n8nynegvKBlEd8qead
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e922ca-3820-4320-40d5-08de0cc6fa99
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 15:16:28.0390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDEjmNcDfFrpLCeqFLLckZJ4BDKRIluU3ht64wlgYGoo0gx4bzvd7G1UIbJrhuAFR+IyTbYiElrL24V8ohyvWXOhKdzvhRXUS2sCYCHvTPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6293

T24gMTAvMTUvMjUgMTE6MTkgUE0sIERhbmllbCBWYWNlayB3cm90ZToNCj4gT24gV2VkLCAxNSBP
Y3QgMjAyNSBhdCAyMzoxMCwgUXUgV2VucnVvIDxxdXdlbnJ1by5idHJmc0BnbXguY29tPiB3cm90
ZToNCj4+DQo+Pg0KPj4g5ZyoIDIwMjUvMTAvMTUgMjI6NDEsIERhbmllbCBWYWNlayDlhpnpgZM6
DQo+Pj4gVGhpcyBzZXJpZXMgaXMgYSByZWJhc2Ugb2YgYW4gb2xkZXIgc2V0IG9mIGZzY3J5cHQg
cmVsYXRlZCBjaGFuZ2VzIGZyb20NCj4+PiBTd2VldCBUZWEgRG9ybWlueSBhbmQgSm9zZWYgQmFj
aWsgZm91bmQgaGVyZToNCj4+PiBodHRwczovL2dpdGh1Yi5jb20vam9zZWZiYWNpay9idHJmcy1w
cm9ncy90cmVlL2ZzY3J5cHQNCj4+IEknbSB3b25kZXJpbmcgaWYgZW5jcnlwdGlvbiAoZnNjcnlw
dCkgZm9yIGJ0cmZzIGlzIHN0aWxsIGJlaW5nIHB1c2hlZC4NCj4+IElJUkMgbWV0YSBoYXMgZ2l2
ZW4gdXAgdGhlIGVmZm9ydCB0byBwdXNoIGZvciB0aGlzIGZlYXR1cmUuDQo+IFllYWgsIEknbSB0
cnlpbmcgdG8gZmluaXNoIGl0LiBUaGlzIGlzIHBhcnQgb2YgdGhlIGVmZm9ydC4NCkF3ZXNvbWUh
DQo=


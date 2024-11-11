Return-Path: <linux-btrfs+bounces-9416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D79C39A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 09:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9841282606
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177016A930;
	Mon, 11 Nov 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cZ3nAiDD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Bbgu3mr5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F1F165EED
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313746; cv=fail; b=QnR1cA3NGniJNW1+JnPdIjN1L3G7Omw6uJd9gIk2RhELvg+ZRA2ZCDQIzWLQBx/YD3yYYnWZ7ZAtXZAj5OJaKSLaxd1YFdhNZvBM2cEIviEdN+jzmsiB0cZnlDSTuKFlWbj6fagXPuxfKBI50w6Nv8XMnpACNQSx6Z+ZjypP/Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313746; c=relaxed/simple;
	bh=wyX2FOHFXXO9m8600FeLLHifcky0/1WzEZ1xNx0Lv4g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkQqM2dEHsDF2ItUt1PFI+bYX0617zgAdXCkL2yij9Hs0YwAlyMzHf7jH/ve1Fh1KNSfYuMoNnE4p55qRI/FhBNq801daYuHgXJOtRI5ig/dzlnZCpOx1RvE2fTIdAS+aV6GCQhpzhU3pSP+gqeNsfLHhwv0pQ/pCt6XtT1px78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cZ3nAiDD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Bbgu3mr5; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731313744; x=1762849744;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=wyX2FOHFXXO9m8600FeLLHifcky0/1WzEZ1xNx0Lv4g=;
  b=cZ3nAiDDRh2Re+wONmbQLabVaOpQn8YZlaZdhVcb5XRZNtmMcFzs0P5b
   yzFSjvRqH5FAHkV0KtUZSm7ncqUN2EqsNKDP9lfQ3TGwKCf9w1Tc8cu6Y
   veiegeZmk7yduZMkHVNih6StRRWuqbdRVffOoe1s5O24C6WjTaeoa7rs6
   kHzKs9G8WhRD+5kV7n9USJ/xikMOqfmN0/R4AYerh5KuMmkGzHMyHHtux
   awXEoUdo0T+vwdoaCn9wGmxXGcujM23e47jDUh090RC+1heWll1gL7p75
   Vi6psGCn6xbQHCIX+AOM7juQCSHi8QlYeAF2Ob+683WkU0bzzjDxOUfo5
   w==;
X-CSE-ConnectionGUID: P94kf1l1SPaV0OAje7GSXQ==
X-CSE-MsgGUID: 7AlraMv7Q4iH7LJL0Rcb/g==
X-IronPort-AV: E=Sophos;i="6.12,144,1728921600"; 
   d="scan'208";a="32153328"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2024 16:28:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orPNXixEE1KNpFvv0Df5c07gIYjXoldyQbo+/eaYsrRFNxYnvXa2lGJhUHYWlkMLrd4FWaNTvgeMDiz69l0Rrpex2Qc7xGJADltt48S4okvj1vJSoGyPIHiQihG8NOk5AHKLmXB5Krw41R646iBoNafG5rbDod0gtHybeiqamp938heIG9ISHecS1bqUAZtcjma1OnQv/Yy3a7WVYRw98r2VlZn12sRHofcSl0gh/SOAc5pnNebxCLC4lQOEaU5TY3zFITvEByB6+vnxGd1+0p3el52fqUWG6zeavmunLzDC4CYUdibMibwdr10mQ0+JUjaoMK6kNNMxY1be1hzt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyX2FOHFXXO9m8600FeLLHifcky0/1WzEZ1xNx0Lv4g=;
 b=rVhqum6+aiQEtVLqkpOwtDjQVtniHVqcu9hrb3Yn2JeeQin8RbLwo/OeHSw+SNL1BX1nOQpFAVApJRnKFI4xFRXWA3ROGDHLVdkxYtXwnkcD7vBifTlm/D6sNN30QMyRYtk00h4WfeJ+JKMAOQLzkE+kJZKZvZ7LNakYjLCJygHPHo3zEv9Er0rABK1ryMbPCh2bk0aJT4c+M1+Mg3cGHycBwI1QyoBMLdfrLMYAaj7qupA5A5DSvQeaiEG9UY49iy1ulVZN/0F4xNzQoRDMgEa7zbJvN+ImTzW9TtPOvb5R7VYI73JUB9tDL6v0U+n0EG9/RU9Cf66q4yOIwAi+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyX2FOHFXXO9m8600FeLLHifcky0/1WzEZ1xNx0Lv4g=;
 b=Bbgu3mr5qpoo32XhuKQ3Su9pF03hy/JUjQJUBJinjxqqetMVVOd2YaYUnYF/2wIUyDKrMfrUrmcLVMYIqz2H8MR3q8HDmwjgW96Vw7xDZX+j2UlCkCFN0evlUA2TtpnsuvMw2hWFUZHMlAOoxXM2ptHe69BZ7aa0Z+Xp5BAawmA=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by DM8PR04MB7909.namprd04.prod.outlook.com (2603:10b6:8:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.29; Mon, 11 Nov 2024 08:28:54 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 08:28:54 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: introduce btrfs_return_free_space()
Thread-Topic: [PATCH 1/3] btrfs: introduce btrfs_return_free_space()
Thread-Index: AQHbNA5m8366fqaJNk6wWnwgknXFnLKxv10A
Date: Mon, 11 Nov 2024 08:28:54 +0000
Message-ID: <70ed1fc6-b3dc-4dd1-9433-085238ce91ce@wdc.com>
References: <cover.1731310741.git.naohiro.aota@wdc.com>
 <042529cc81a8704c07d006d1e03db47aa0ef88db.1731310741.git.naohiro.aota@wdc.com>
In-Reply-To:
 <042529cc81a8704c07d006d1e03db47aa0ef88db.1731310741.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|DM8PR04MB7909:EE_
x-ms-office365-filtering-correlation-id: 17d1a782-fdf0-4d57-4b46-08dd022ae0f3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?czNuZWNGTWlEcXJnN2ZRcjhERFNIbDVVVE1TekcxejZaRDdDL2x1aEJ5RFB2?=
 =?utf-8?B?Nm5NSjIrM1FhVmJZZlYvSEJQMUxTSFNMZU5TZTRkRlp0dUdmYzAwd3NhREZY?=
 =?utf-8?B?Nis3T2dQRVhCWGZIUlR0cncxd0FMb2JONUowWEJxelFXSHZEb3NMeStFby90?=
 =?utf-8?B?VWJVVXB5emlvc2pzMmJTeGJtRm1mell0eGRPMmpCZlg4dVRUdFRLNlp5cHJy?=
 =?utf-8?B?aU9LelZxS25IZ1V5MGd0N3dLOHV0ckc1NUxmZ2plbG1Oc092bW1vZTlUdFAz?=
 =?utf-8?B?NHFwWjRSeVRHUTVMZkFnWjgyZHBwQWx3UVloTFQvcWlla0FDQjFIWjIrNklN?=
 =?utf-8?B?OU1Ia1luUTc2U2ZNcmY3OXVaTlRqb3hhdGlnVDNtSy9mRmZpMHJGV0V4Z093?=
 =?utf-8?B?aXdmOVRRM1Bjcld4WlJBaXpBSWcvUjBoOTBrbWFDRXRmaWh5T0prNitEQmM4?=
 =?utf-8?B?ZnhGZnRhQkJNOHRiWVcwbDIrSGRjNCtoM2JKQW9aSldSdTdHdVRsWHpQbkJW?=
 =?utf-8?B?MHdVZFlqN3NnV3dkcTFPelRYVG1aS3pzWGVNY05ZMW9LN3kvUEZGRWtBNTNJ?=
 =?utf-8?B?Y21CZUNhU1BBbklDOTFKM1hxSDZkM0VIc2FOMk9teUVCMHpFU2VPUFQzblAx?=
 =?utf-8?B?emwwV3Vpck4za3ZSaUR2dDJteldCUlFXT3h4WG15UEYyUk5HL1U1a2FaZFo5?=
 =?utf-8?B?YjRDUUpjUTlYandYLzAxSDlPRWViUXlZYjJIa05JQmZWcmlLRlkvblNxV1Ro?=
 =?utf-8?B?WlBFQTRiOUprT3FVM01XTFRTdWlPL0J0Tk85MmVUbDltTnppWVpsUjgzS2VT?=
 =?utf-8?B?dXBUNDRNREthbGk1KzFxdzA0N1FqN29UY3ZYcTJ0QWNqeU4xSVlJUWJnVWRX?=
 =?utf-8?B?MDBFWktCS3FKenFYbkVFVlZMeHFWUElETFJ5c0ZhQktKRys2UnJOV3JudFFY?=
 =?utf-8?B?WU5WNTY0WlFqZFUvRVFxMHh5SjFMZnVDM0VLQmJnaUNzSHF6TDNocDJGbElM?=
 =?utf-8?B?aThXQjhsUmFKQUdDemt4SE03cHVDaW1TZVJFOUpLRklaU1NBWEp3NXFOUVNh?=
 =?utf-8?B?TUhuVEYwTmxMQmYvZXg0V0hvYUpLK3hoOER2RC9RRysyL2hVMW5Zd3U4cGlt?=
 =?utf-8?B?dW5jdW9Lbmd0ODVoaWVYN1dPUVNZOWhpNTZ0V2E2WUh3RWNTalhyTUhmRWRv?=
 =?utf-8?B?UXNIckZvU1ZSY2VaZm1BNXJGVzRFU0hSL0JIZjdZZjJLbzAveWcwQTJjeFJI?=
 =?utf-8?B?N1liWHpLK3NxWU56VjQ0R2MyZ3VYNk1JY1lhVDI4RXFIcFlJcnVndW1hSUt4?=
 =?utf-8?B?WWxFWWNkNVZYQ29mOTRqbjhOSkw4K2prQmlNUjBlUEcwSFd6RVFLN3pFTFpV?=
 =?utf-8?B?ZEFvcWkxVUNEZmxYbHRkbS9iTUw0ZFpiZlkzdTFqM2F0Mmh1K25SbGlQM0ZL?=
 =?utf-8?B?SDlTWHc2Q2dqT2k1OGlzNFI5L0dSMlZTZ29xSzBCWnUvblV3RjlwSjk5eUV3?=
 =?utf-8?B?WW0yRTFwVXBHNERUMFFiN1ZlNm5UbjdXOFZ1dEF0enFJemNKUmN5SWFoRmI1?=
 =?utf-8?B?VmUyTmNoekdBMUorYzMzYTVpZjFndTRpNHJ5WS8wQTJSWlFQZzM1YXRaOFhy?=
 =?utf-8?B?V3hmcjBsU1lRdEdLSHZQMjE4QjliczdtamNHQzVrNm1KNnBJbWRTN1FJRERM?=
 =?utf-8?B?d3dqU1g5NkRTbUhKUDB2THhyekFjYnpnZTlqZlRZWUVjdkNSV1dJQnhCRVNC?=
 =?utf-8?B?d0h5ZzVaNG5WWll2dExxYjdOOGErZ1QvMUQzRmlpRUlvV3FYTzlyR2tNZFp4?=
 =?utf-8?Q?bsR8sLqNddYMx0mxxk0tD0N7HsX66tk1/uSOw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czdUdFdsL2pMalZwNGhHVTFFVlVJMzNRSzZMZGpNSXcweUZjaVU4blU2RTNk?=
 =?utf-8?B?NWZOUjNCNkQvTWxOeXBSR3hzWjRUZHE4eXIveElnSWVmdFhad0R6QXc5RjdY?=
 =?utf-8?B?VDdpaEhTMTh0dW10VFdJVUl6cmY3dEkySXcrd293LytzSWtmTVpMY3padGtO?=
 =?utf-8?B?dm5xdmhVVmZoSWJWWmNjTU1RaFFpZ1dNNm9QMEMwSXc5YkplQ0N1OVlaS3Z4?=
 =?utf-8?B?TGxjRTJNVUswMVkwdmtsTDA2Zmd5b2xIakExL0tsSkI3S1ZTcjZGeTlBOWdJ?=
 =?utf-8?B?by9OeU1XYUpTNFI3QUsxcDdvRzFVOHpIZFl2Uy9MeDdScWJyWWp2anAvNmVj?=
 =?utf-8?B?d2lzbG9GZEw4K3Y5SjVzUlpwVm5SamYwVkorMDIvS2pKdmpvQXBud1NTOW5z?=
 =?utf-8?B?RTNUUGppdnkxVlNZb01jWm80ZHlTcmNhaEdHNW5YMjg2a2tDMytkV2t5eGJG?=
 =?utf-8?B?aUJVVXpmd0ZCczd0UU5YbHVISWgrN2FtYnVSMGQ1YU9RTXcxVkUvS0xyMEpL?=
 =?utf-8?B?Y2FZTmxtQ2M3Rkc3VFNLTjIzN1FKai9COWVmSDJKK1FzWk5aQ1gzU0RwODh2?=
 =?utf-8?B?VTVzWU5OSEcrbHhzWWNYSnlkNitmeVViL2pBc0haZEJNdzFKeVMva3o3cy9W?=
 =?utf-8?B?THZmZldQd2lKa096TlJUdG4yUnQ5cDdQV3RHbUJYbHVsamtzeDhIWG0wTUJR?=
 =?utf-8?B?b1JhMG1mRjVBSExETE45U1lId1NHRlFoeFAzbW1HK3I4T0JldjZhVm5sSWZ2?=
 =?utf-8?B?dUt3NHhKQzcreFJSK2JHdVZIZjJ2a0ZQM054VWFzUzZNbnBDaHgvSXhMVHE1?=
 =?utf-8?B?OVBGbHpSQ3VzM3JjUHY4ZnRBMTFoMGIwQTFXd0NrOFVUOHVhTlZxSi96U1Uv?=
 =?utf-8?B?aE1ZTzZjUVZuMERaQnVOVzRSaGwyQmxkUkptMTcxTTZOVkQ3WTY3T2toT3Yz?=
 =?utf-8?B?cU56L296OHVXR2hmYTI2N1pnTEUxa0NJYU8vaHNPVnZ0YTJOM2Y1SktnNEVz?=
 =?utf-8?B?bVB3djRCbktPNXZmM3JFcEtPVHdpOThRdzd1ejVrYXdZUFBzN2FVR1ZaR0c3?=
 =?utf-8?B?UTNFVEVSdHRkUEplVlZtNmxhWWxWNUJ4OWI0YmY2V2RQdDJiakY1NWQ1anp2?=
 =?utf-8?B?OTZRMHU1WE5sNjVaVEVVNXZBTWhkcEJ6MVV2REZDbzJOTEcxNFNhTStTbUVU?=
 =?utf-8?B?cGxveG0zWkdrUVRkZjhQVXBZNTkzYUJSdGJSN0hkQVFpQVl2aE5aZkFOS3JW?=
 =?utf-8?B?ZWp3TXN3ZHo4d25XaFVjUmtNTUZMWWpaUGRsTnB3Vk9PbWxuV28rV2F3WEFn?=
 =?utf-8?B?U0RNSXpEUnpaN1dhRExJenQrVFFlWFVmbEIyK29MQmdTU25WMm1KMkh2cFV3?=
 =?utf-8?B?MmhiYXNJVzA4TE1Wd1ZjdnVKcnBqU1BRcDQwMFE3QUx5ZXZBUVRDWjdCdWV2?=
 =?utf-8?B?b2xhaFRDWTBxQTNjWGsyVkxRVm1XeTFHQ1Y3akxJUVY0RWJvNVYxT2tiWFJ2?=
 =?utf-8?B?SlZJNHZjaGc3QWNBOHZ1d21PcUtEVzY4a3pZRGhYTk5TVys0cVJGdVRRWEVW?=
 =?utf-8?B?RDBIOVRDcCt1QjhESGtRWE5xd0NJRFJnaFlGTzRpVUtWc20vdzlXWE95SlZD?=
 =?utf-8?B?SjBUNndEZUEyMnNKeE0yUlRVN2dEOFFRamRRQ2lMMDVDTDl1VDV6VUpPS3p5?=
 =?utf-8?B?UmtLVkJ0T2x3OXg5MFdMVHp0QmorZlVhb2RUcG94dFpnQkorcVJOUE9Oblpo?=
 =?utf-8?B?dGd6RFRCK0RTT2pyUmpmcUh3MjRjdzhpSFd1anNkTGVlVXhCcC94N0lQVEht?=
 =?utf-8?B?bFF1d2ozWkYwWTE0RWt6bHNjbWVkd3lTZGFIZ3ZTVWhTUVRUSnAyVk9xKzJh?=
 =?utf-8?B?ZFhQdmhSZGdadkV0RUVtNHBkdVdoSlpXN3hoY1ZtNk50aklaandzV05DcDNB?=
 =?utf-8?B?WERqbmVaYi91Z1VDN3ZJaWlsK2gwSEM5QWI2SXc4YWlyQW8vK3lkSmdvSU0y?=
 =?utf-8?B?enZ2b0RISEVJOXZtOG44UG1qTGFVQTV0Z3doTlJsbUhjUTBVbnJzVTl1UWJK?=
 =?utf-8?B?VmF2TkxMWC94ZmlwODN5YVdnZFhjMEJkcWlYekNBdll0bGJiWSt0QVhMdjJO?=
 =?utf-8?B?cHFqWTNDc0ZiTWRicGpZQ04xa1hUcWF1QlgvSngvN3NYdzh6L2dEUFBVVjNB?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E66ADDAAF6045488463D09CF264A696@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QX+FW9/9RTbgej0PeMWRJ5lBEgJtN+ShG7BYaGHjg2kVyw/FvSJZfj6QuJr7cClTJKYvROA1So8C7sJ2EPu2uGJPzAsBZgVNJRxGfL+6yRHwYgE2eqnJwOUNxjjNMSnMiN6c+8Tr0Q5Fu8aY6DYEtgDTTqYvPdbWqmYgnB93GgFjw1SyFp7e2h3smm96uDkDrUJIOQ5MHP94qGTEFOgTvEa4mzhG303ZUqBtrazwRyDeaK6MdjuhXuWcMIsh/xFAc94Zn3/nlF923hYLxiGCeKWjV790a/MR/DVXCVlJJk+9d91TCvKRgejVFzr7MCCtyGGo4VBhZeUffMFEJYCPpbP8sxbO2KysiX2xnh0VMS5syd8yxAU7ajkmRbLPTP9K5Uty35hfbdfhlZKs510N4tUaYYaBcZ7V+3lwZ6T3hu4Y6hZwemCNvFJgXplgJ/6eOl0bl9/br/Cf5mXutwpK3usquHO21KAI8NaXskc6IVohkTV+iYx2tIJANAosFnALSCiSpa5ddaQ4oO/HJzp4lYAfPYbV/Jbf1DvdgpCjsDJQtrtnxPffnDjWf747c5nkk6Q6LHjuts1G4MVP2nspTUerpL1iAAgkWNkoWkMSp1cnqL8oJ1UWH6oSPjOnQum7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d1a782-fdf0-4d57-4b46-08dd022ae0f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 08:28:54.2124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzt2cyxr1M5CfweIBNrxV5342Ss+5LBtEv9AkZp4sLg4wWyVQYEQCMvlwYutKsaOf+sRunHemQPcDprfRJ3IpOT31sh8wDOJ6SzMxuegUhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7909

T24gMTEuMTEuMjQgMDg6NTAsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gK3ZvaWQgYnRyZnNfcmV0
dXJuX2ZyZWVfc3BhY2Uoc3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gKnNwYWNlX2luZm8sIHU2NCBs
ZW4pDQo+ICt7DQo+ICsJc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8gPSBzcGFjZV9pbmZv
LT5mc19pbmZvOw0KPiArCXN0cnVjdCBidHJmc19ibG9ja19yc3YgKmdsb2JhbF9yc3YgPSAmZnNf
aW5mby0+Z2xvYmFsX2Jsb2NrX3JzdjsNCj4gKw0KPiArCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJnNw
YWNlX2luZm8tPmxvY2spOw0KPiArDQo+ICsJaWYgKGdsb2JhbF9yc3YtPnNwYWNlX2luZm8gPT0g
c3BhY2VfaW5mbykgew0KPiArCQlndWFyZChzcGlubG9jaykoJmdsb2JhbF9yc3YtPmxvY2spOw0K
PiArCQlpZiAoIWdsb2JhbF9yc3YtPmZ1bGwpIHsNCj4gKwkJCXU2NCB0b19hZGQgPSBtaW4obGVu
LCBnbG9iYWxfcnN2LT5zaXplIC0gZ2xvYmFsX3Jzdi0+cmVzZXJ2ZWQpOw0KPiArDQo+ICsJCQln
bG9iYWxfcnN2LT5yZXNlcnZlZCArPSB0b19hZGQ7DQo+ICsJCQlidHJmc19zcGFjZV9pbmZvX3Vw
ZGF0ZV9ieXRlc19tYXlfdXNlKGZzX2luZm8sIHNwYWNlX2luZm8sIHRvX2FkZCk7DQo+ICsJCQlp
ZiAoZ2xvYmFsX3Jzdi0+cmVzZXJ2ZWQgPj0gZ2xvYmFsX3Jzdi0+c2l6ZSkNCj4gKwkJCQlnbG9i
YWxfcnN2LT5mdWxsID0gMTsNCj4gKwkJCWxlbiAtPSB0b19hZGQ7DQo+ICsJCX0NCj4gKwl9DQo+
ICsJLyogQWRkIHRvIGFueSB0aWNrZXRzIHdlIG1heSBoYXZlICovDQo+ICsJaWYgKGxlbikNCj4g
KwkJYnRyZnNfdHJ5X2dyYW50aW5nX3RpY2tldHMoZnNfaW5mbywgc3BhY2VfaW5mbyk7DQo+ICt9
DQoNClN0eWxpc3RpYyBuaXRwaWNrIGhlcmUsDQoNCklmIHlvdSByZXZlcnNlIHRoZSAxc3QgaWYg
Y29uZGl0aW9uIHdlIGNhbiBzYXZlIG9uZSBsZXZlbCBvZiBpbmRlbnRhdGlvbiANCmFuZCB0aGVy
ZWZvcmUgbm90IGdvIG92ZXIgODAgY2hhcnM6DQoNCmlmIChnbG9iYWxfcnN2LT5zcGFjZV9pbmZv
ICE9IHNwYWNlX2luZm8pDQoJZ290byBvdXQ7DQoNCmd1YXJkKHNwaW5sb2NrKSgmZ2xvYmFsX3Jz
di0+bG9jayk7DQppZiAoIWdsb2JhbF9yc3YtPmZ1bGwpIHsNCgkvKiAuLi4gKi8NCn0NCm91dDoN
CmlmIChsZW4pDQoJYnRyZnNfdHJ5X2dyYW50aW5nX3RpY2tldHMoZnNfaW5mbywgc3BhY2VfaW5m
byk7DQoNClBvc3NpYmx5IGV2ZW4gdGhlICdpZiAoIWdsb2JhbF9yc3YtPmZ1bGwpJyBjYW4gaGF2
ZSBhIHJlc2VydmVkIHBvbGFyaXR5Lg0KDQpBbm90aGVyIHRoaW5nIGlzIHRoZSB1c2Ugb2YgdGhl
IGd1YXJkKCkgbWFjcm8uIEkgZmluZCBpdCBhIGJpdCBoYXJkIHRvIA0Kc2VlLCB3aGF0IGlzIGFj
dHVhbGx5IGd1YXJkZWQgYnkgaXQgKHRoZSBibG9jayBpbnNpZGUgJ2lmIA0KKGdsb2JhbF9yc3Yt
PnNwYWNlX2luZm8gPT0gc3BhY2VfaW5mbykgeycpLCBzbyBub3Qgc3VyZSBpZiBpdCByZWFsbHkg
DQppbXByb3ZlcyBhbnl0aGluZyBoZXJlLCBidXQgSSdkIHByZWZlciB0byBsZWF2ZSB0aGF0IHVw
IHRvIERhdmlkIHRvIGRlY2lkZS4NCg0KQ29kZSB3aXNlIEkgdGhpbmsgdGhlIGNoYW5nZSBpcyBs
ZWdpdGltLCBzbw0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+DQpvbmNlIHRoZSBpbmRlbnRhdGlvbiBpcyByZWR1Y2VkLg0K


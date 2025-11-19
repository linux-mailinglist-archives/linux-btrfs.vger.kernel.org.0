Return-Path: <linux-btrfs+bounces-19151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0569C6F581
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 15:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AF2B4F5F0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2B276049;
	Wed, 19 Nov 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JgU7QMH0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XwQZtTVT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D1274B34
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562012; cv=fail; b=YnLlssaboVgs4OXIZVvJZ/b/hDnS43DOdkmYGHp+K7Qz5t2eJ9jhsdvBL4OJeUQ+/RFMldJBOXN0LSRHINZub6nD836lp8jiK8FA6mJHPx3vU+/zK5QnabrbArxfr7AOZyn+5xBsz7n78i8bC97BJO2oPBpzb9IrHCf5Je8fOUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562012; c=relaxed/simple;
	bh=mFRQoY45+yhoLlWv5ehkyG8vUwx5PewwWg+/gpshrJU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WCRc7/yKonNuHn835qkqXG7iu32715N960mNKFWfnGRIliryJdq0ToM+I+cGBBkeS0Ut7AZ1tbXczmMtxb+sDGUgOVIVqFnnLpbF4nw9TejYPIjWntuCOaNMx3QJhfl/0mFHevjzk7XUosoCVc4PwRA5I9tGzj+P2eCMlPp2Hwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JgU7QMH0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XwQZtTVT; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763562010; x=1795098010;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mFRQoY45+yhoLlWv5ehkyG8vUwx5PewwWg+/gpshrJU=;
  b=JgU7QMH0dUf9ke/TSl3vYDcJ2KfUh5u7fXwKB1zGH+tkJmmNnNtJfw7Q
   sLLh77dPd1cDsVGnyrxZvwsB79jwItXxtMyxmFcmezP9ES6gjuzNZF38W
   5iDBrC/MyblT8dUSXvLQNzlaC0YGnOdAfVqdygO9XUdSm+TUiQO4JQT1X
   Xefq8y+HSHDx58L+LIqIp/O8+9toYSVdqfnX74Y5a6v5PWTa8QJkZsfYH
   Y9kFvnpvZGsrfeT0BdyHfBHdsSuRefOV+TTSwsPVpnRTwXySOeOOvFdX4
   GFFaOJxdj00B3EUH/kFzqgnHYRqX0BBy+LLNSujsl09lY7eNy38adEi9N
   w==;
X-CSE-ConnectionGUID: 6a66WpB8Raau1GQ3kkpoSA==
X-CSE-MsgGUID: Ch3ySkPrQOONGtIocBconA==
X-IronPort-AV: E=Sophos;i="6.19,315,1754928000"; 
   d="scan'208";a="132368015"
Received: from mail-southcentralusazon11012011.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.11])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2025 22:20:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRy26QQsJ1ds5hbbpNzQfp5IHmyEay+mxZYw6SEFXnf2y05/jy25f0pwc8p/gS5TKDjQKy7byjIjRqPaYnbaq8Nrgcz4LoDZ3L7ycXUblKJbCvFt3jxX0v+NQpF9KTIIpylxv1oVrXxiufgaW2S8HpXMl0fDnRqyD3FZ2moXLi4Xb7k6mwQwIcOgVWhNUXPkLL4guc69s1a2aWyOJ+NIEB0w2sc2Ys8dcwbN++h6qqdtjR4qHzVAoZ1pY1Tdc1rh78b3G492mPBnJ/q7mquX/JHdHM5XDdgz+FBcRt7rVpYSucEMveKw+Cg5HNXD1PHUkOMCSIDwJm9rur9+jA2D+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFRQoY45+yhoLlWv5ehkyG8vUwx5PewwWg+/gpshrJU=;
 b=AlohF9mdAbbmLNaB1pk95czvMNtMXfNXgcKXcE+Ss6XyPcqsDCndwJKhe9wPEGt3mPJc4fHs6EIuw1jkyF7sdtrNBw6i4ro7iks0boVnu0+jxU/aYx6DmBhG3N9maGUwTha/7bOkpQfUszCceb2aYG2IavAcUPmMKBXSZjJFmgayyJ58BBByfpZx6801je5NehkBj+RqUXQL9jKzoTM2pg1g5A56GnGMIFDXBotr9qrkksEtQTkaXjEhyz/2I3iNh/OCkZiqNvlEE75foAnCnqFfm+VfxMKm+Hpbl4X3jHp6IoFopNSp8Fde96vEy4LPOovezkr6tfRr69WYGJON2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFRQoY45+yhoLlWv5ehkyG8vUwx5PewwWg+/gpshrJU=;
 b=XwQZtTVTwdkxmcoqth9joBOvmNxAN71RaHIzcgZJhculXZJgE/P39IrboXIWMGUfC+YlLDbA6URllV5mxZDZpaUZyTqnCEHsE8eUbBCF3BUoNxCE1x6L93EZm3TA6Y7XeDfwlFdF2CDrxN3oUAje8UTz2xtVtEUBhFKyWiOHamw=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by IA3PR04MB9182.namprd04.prod.outlook.com (2603:10b6:208:521::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Wed, 19 Nov
 2025 14:20:04 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 14:20:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use test_and_set_bit() in
 btrfs_delayed_delete_inode_ref()
Thread-Topic: [PATCH] btrfs: use test_and_set_bit() in
 btrfs_delayed_delete_inode_ref()
Thread-Index: AQHcWVQhHchYxmKJ2US+ijp5ib7skrT6DIkA
Date: Wed, 19 Nov 2025 14:20:04 +0000
Message-ID: <2c984089-f13c-4a00-98aa-39c19927dd9b@wdc.com>
References:
 <f03e80d62a824f4494335d2bb0dc217ec26a9e98.1763556089.git.fdmanana@suse.com>
In-Reply-To:
 <f03e80d62a824f4494335d2bb0dc217ec26a9e98.1763556089.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|IA3PR04MB9182:EE_
x-ms-office365-filtering-correlation-id: 8c71a1e1-2153-47aa-bd17-08de2776bbfc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?bktZL0Nvb3ZmOXhUa0ZKVjFlc0x2K0xsNk9JSCt0OE0wOVFXelZPcjFGWktT?=
 =?utf-8?B?N2c5RzNHV2VrTEhJQXZLcmtlYlBNUWtzcWg1cUlGcnIzajFOQnZmVSt6ZDVQ?=
 =?utf-8?B?QmdaSURDTi8zaWhTMGxLUGhWLzM3eVdOWTNmYnRsTXBYOUhKK01xSzQzRTA1?=
 =?utf-8?B?K09PSnFDQkJXd242aS9uYk1pS3h3L3d3Q2RrV2doY1FneUx4SUFVcEx4RlJy?=
 =?utf-8?B?TkRJRmxuZWt5enQvakVnMHRrRlloN1d3M2NjVDBpVmhWWnhjTVZTMUZhTXgz?=
 =?utf-8?B?MU9BY0tpcVhTVU1DZjJIWjZ3NTZpanRLRzRtSkpZdmJOVjJ0TDVqd3Axc3Ez?=
 =?utf-8?B?b0pYVE9jeHhKMEtwT0puYmRPV1RWbUZJOUVoL0lIeXJLdkdJYWpPV2VNVXZw?=
 =?utf-8?B?ZUYraEJQakx1R2ZISnlFRHNCZDlaRUlVc3RJcmo3RjJQTmxsQnlnQlVtS1lW?=
 =?utf-8?B?RHMxTFpZS1d4Ri9mNlN4c0hUWnpXV3ExZnQvOTk3QkJlMUhWM3c2NkZNUjR2?=
 =?utf-8?B?R0ZRcGdYSEI4SnRucHNHUGpNUEF4R3c1ZGhDS1hYRnNxTnFJUEtPSnhGLzZ3?=
 =?utf-8?B?U2hOd29mdENmeTNicDlhQXVmaFVIaDhQbUxOL05vcHJ4ZXRDVXg0MkI4c0tO?=
 =?utf-8?B?WUN2aWdzVmMxOXBiMW1BbUR6YWt2ZnJWVlBSZU43QlJUbUhIdlVpZlZJYldF?=
 =?utf-8?B?alQvS0FFcDRrK1I0cHN1TWlmc3RQOXZLS0lja3pjMTJWVTZ2MzI0M1EvSXJ3?=
 =?utf-8?B?bXdLT3FjS0lpWmZ4TG01ZDJ6RUg0SjZkVUdBZmk2TjFpTzlOdCswK2NOQWk1?=
 =?utf-8?B?UGFOalVpdEs4ejhOdzBLTW1uTEdHZXcyVGRiVWtrR29FcnpDVHhSa0lvc1Ni?=
 =?utf-8?B?bWkyZnZQR1VnemlraGxEVm5HV3RZZHl4WVZNVHRETW5xTDlSREU2NW9lU0Yv?=
 =?utf-8?B?M1dndThEVktqQUdnbE1RVFBsN3dPVmdOMlVka29iZnJ3Um5nOGlGV2g2bDh4?=
 =?utf-8?B?NkVCejJZVWludW1Edm1wLzloK0M4M3hDR2lPZ3cxS3BwVFRmeThNajFGQm1K?=
 =?utf-8?B?SUQ1TjZKcUM3a2h0MGNVTWZ2YWt4YlJ4MmNKZFZrWUYwT2lmRzZsTUJUaWJM?=
 =?utf-8?B?STVuZkFRRWduZ0R4RDVTb1pBTklIRnN1dXRuZFRONlNOUk1uRlZmNE9BNDhL?=
 =?utf-8?B?T3NyN1RPQ3BlWnBmVDAxVW9mTWtUWWdWVE4zTTcybEZTTldOTjVGWlBtR0FS?=
 =?utf-8?B?Qzc2ZWRmL2wxRllaaVVGb051WUwxY3BRdk1CTnMyQ0c5Nkt3eXZITGVUK3RQ?=
 =?utf-8?B?UFIrNkovUUJ1S3V2N3pOczZpM2ZJaXNWYUV4U0xpM2tEMW5IcVdoTlN3QzV1?=
 =?utf-8?B?Z3hoU1M1aWtJaWJUWVNmK3IwYXdyUVF0Umt4N3dJY0FFd0hVOFZ0dDc3Yldy?=
 =?utf-8?B?Zis5R3IyM05SWjU3ZjAwK0ZQMWs1TXZzRWRXVmJpWUF5Z280QzFRTWNwa0xq?=
 =?utf-8?B?T0VOSHNlekxYTGE4Q2FqUXdla1NRbFJzR3ZsMnVoaVpDcUlTeE5Nb0RGenph?=
 =?utf-8?B?RWdPRmhab3pRdFAwV3duMjJtNWZ5OGd4c2k3VW9yM3pKTld0SVc1RGhMaWta?=
 =?utf-8?B?RHdGaTBHRnFrRk94My90eVZNUnkyWHlCNmlMYld6UTBEaENOdyt0SHVLM2xE?=
 =?utf-8?B?a2FBcVowT2QxNHg4b2Fwajl2dDM5ZXZScTBQOXdxbkRmM1VTb3dXenpTQm1R?=
 =?utf-8?B?bVdZWXZkVjlGYWw4RXU4cHhFUUVpWHR5NXlsUHRiU0RXTGRQTEJuODdBYkNO?=
 =?utf-8?B?MWVxNkd2S3hSdWVmNFJ5RjFhQTFvSzZ4ckNoWmtJbzM0bFZ5eS9LaHVKL0Uy?=
 =?utf-8?B?ZWMzcUU4aTBJcnRVdXVYWEZ6NUdjMEVXMWpLb2RZRjV0RmhaYkZxQlZ1K3pO?=
 =?utf-8?B?Sm9xYkJNdGd4cWVvbWtvZXJzNmtMMEVnOStMS1hqVWlGSzQ0UXVqQTI2eUdB?=
 =?utf-8?B?Q1QzVUpJVEdQZEcvV09mbjNnL3ljYU5XdXhRRlJoRXI3SkN2eEFtV2x1K0lp?=
 =?utf-8?Q?qDbUGy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjRlV0hhclhlaU1LYzljVjlWRmFiRTZZU1dkSUpzOU1aT1A3bS9ya0hoWFR3?=
 =?utf-8?B?QnFPMjNCQnV4SVEyRzlFVEQ2VTFZcWdzMkN1ckYzOVVsVDI5S3ZJam9IbDk2?=
 =?utf-8?B?NDBOSnFaYzRlRW9ZK3FIdktha3ZWOWcxK3VWbnYvV2IvVWZscm9PaFkwWTRE?=
 =?utf-8?B?NmlkOWFwam9zajg0K1lPRXAvMGRxYjRDd2RUL0EwZmFUbS9NVFBuODY1bG82?=
 =?utf-8?B?ZUF4SzdSS3hER2k0cUFZa2VTcFlBd05Ma29FSnFMbnI4eGF2akNMWExPVWJn?=
 =?utf-8?B?cytQQk5qaTMrdVFFMVYxdTFFNmpQcDBTN1ltL05XdlJKd1lBZVRzTzUwV3VZ?=
 =?utf-8?B?Wkh1U0VQeUE5enppejJoeVVCUmVhamZOaXVLaStERlRkaElQM0lVRkJzYnBt?=
 =?utf-8?B?S2VxZm9MU0M1MUVBZWt0WVpLeTMyVDk3R1VrQUl4MENCSWI1M0JCZjZOd1Ju?=
 =?utf-8?B?NkU2azk5TU9JbEU1dGhIT0hXTlF4OHNqWFl0Y1pjOWlJSllSdVpsUDFJblNN?=
 =?utf-8?B?NXFtaDU5WUtkYXRBcDd3TkQ5QXBjK3cvS29oZTNhdW9ERDJseTREMlZyd245?=
 =?utf-8?B?MkdORm9zR0QyK2tzaWcvRm5DdjQ2ZDhLTW5FYzBXQ2pJdDhEL2Y5d2N5bEE2?=
 =?utf-8?B?OUg0Q01KNnMxTFJvMElBMnk4QUROWWVTSTArK3NaeFA0eVJxZkRIbS9kR2tL?=
 =?utf-8?B?anBmb042QjkySC9JMDVmbjhodVVicytlMWRyWVQrd01zSlVxYy94bkw0UjM1?=
 =?utf-8?B?RXoxRzBRemhnMmNqN0pEeTNqdnEyMXAzem9CZE1ZakVIMTFmMjM1eFUzWlFN?=
 =?utf-8?B?d0JXdDJXSDZoaUhrZHROOEliMHIvdDVwQ2NvYTFranhjbEZvdTY4QTVBR1dy?=
 =?utf-8?B?bE4yT1d4MFZSN21yQUJQZUQ0R3FLMTVNZlBtdlN4bUpMc2tGR1pDY2tVNXQ3?=
 =?utf-8?B?OFh6ekNla2tYWDJ3NlpwNGJoU25lUEdqTjV5TytaZmNTWG85VStydmVLenpN?=
 =?utf-8?B?Mmc5ZVlSSFpoS0JPdmtQVXREbjRRWlNIT05iWENJK0NaRlFqbXVLMDFrS3Yy?=
 =?utf-8?B?UWdtRnVMa2tORld1bTlua3B5TmUyNVZIeUg0NS9KVXhjQUZRaDE1VkppaGtI?=
 =?utf-8?B?Undsa0RhN2ZUZ0tERmY3NUc0TFN5TUxmSGk5K2ZFcG9pSEZCa3NXMjBZUGFi?=
 =?utf-8?B?dGNkRXhORHNYcGV3bDBLclNjcXB3SHBHeEFXZ0xrejNiVCs5T0xmZUFWQjI5?=
 =?utf-8?B?TTdWdklYVG9UYjg0ektHUmRSMXdhN2JPbjZuWjVqeU00Q2RRQmxYbFJiRHpV?=
 =?utf-8?B?Y3hXTi9uTFZtOTJoMjNDbzBSaitFZ1Z4TzZraGEwUUk2V2ovK2lIcjI5SGho?=
 =?utf-8?B?WndVOTFlWG1EY0pQRVRJYUNlaExzNE40S090VnRDL0NVMHpDM2ZSZ1VVcnY1?=
 =?utf-8?B?bC9oeSsvS0JTd2RXVUZLUmt5SW9HRGZRY2xnamVjazZBdzduWkdmQ2drblIy?=
 =?utf-8?B?OVZ6WFRBOWlnQXEwcEZtWmZQL05LRXhabDBSTTJvWk1BK3NKMjdJbnVYdzls?=
 =?utf-8?B?cEZXRVhzOVlBWEVVcGVSVkpaM3FJV1VKSkFGQmZwNE1qUjZlV2NqRmFXcnhq?=
 =?utf-8?B?Nk1jSTVlSU0vbm50dHhZWVR1MWFocFhSMVkxTDIrczRkbjdKTlpQTHRjdEVB?=
 =?utf-8?B?TUZtc2NneWtUSmpTelo3K09JSE85WitJWk4zNXByY29YKzgwVlFGSGZpa2ww?=
 =?utf-8?B?dnRLZDMzbmdzaFZoNlB2c1dzMlVaRHlzeXEvbVRiUWJPWGV3bDc1S1JveWdm?=
 =?utf-8?B?a3JjUlJoeWtrQmRJTVYwMkwzOUhOa1V2WSsyUXRMOEZLcWdTTlRzTC84WXgw?=
 =?utf-8?B?b3liSEMwUXMvTWpzMUZCSUFXVmRnUTMwakI4cDcyeVpXZjdNd2lvTWFEeE9K?=
 =?utf-8?B?Q1c3cnR1cFFWckplUEtadmhmWVV0MUd6SzVhdGpEaGxQTTQ4V2RPeXhrNGhr?=
 =?utf-8?B?N3RRclBFRVNKNmpxME1uN2dQTXdpMUlpWmMzVnc5SThFUlAyeE9CQS9MWmZm?=
 =?utf-8?B?eC8vcDMxY3ozZlBERWtNbmpFQ1dXcTkrK2N1YzZ1b25XSzNPZkdERG9GeHla?=
 =?utf-8?B?VTcxdC9CblZCM21rSk8xU3U3RGRSV3FPM0pHajhra0RyNGozNUZ1RlJSeUE0?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <476400012EE8854798896F0E1BA84032@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eXEb+iXbpDLoGsJj2Geb5lVl3FDr/EetOMyK7fcHUIAxFn94RdCKvoX3Kxp1nqsKL8Ieig7r1M67GblDRuu/55x1SUdKJZ18r/YeZVc9w26DKn1Ug/FAMfAYOZRZarzwvhr1TFx+ue5ab1MP2sBclDnUyJOBeUuLqf5mPiWVCKA2V3cLPvOOs7l2mIy3KzS5v5FySZNwreDTD395dsqIbyblOUyvrxozjCOQwsFa50OfJV17QtrLnRFuTRDDACH4i6u4LWha7B04UguX1dxe3SPeOe3JG1dwIWvKYVLzZcRSrpK5/J11dUk9Bl9CuYSruZhAC0Jd/sfc3Xw2/B9tfJoQ7wlFgo3W1V7TOQogz7kp/cB+EKDuEd9JAjWsqNEvLXYCSwWrgmcPVeQSEeJt9HYa6+Fbvv17FL/c+62CfT81FCdRysy+InhT2xIKcschmwCO5AkgBPdW56p690kqjBWkvG33MIPECZ1i6t2SuZuVHWA+80TMQmAG1nnNUABMTqQxnfeFf5G63rsoWoqroDxVsMwndVIPExsLF5es8dyFE1NmcW3O4ZnLEVDhiacMTFWWViKh9Thdvzi4q6GPbv135k40ieROwWytf6st7Geve6zktSYhDmw+vr0ZH37C
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c71a1e1-2153-47aa-bd17-08de2776bbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 14:20:04.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rgi80kjKo+fk8HYT63vr6PWHj/Hl8Q3SoZ5kM8/P9DZbparRvjh9IatF9qHqwcYdy3mZF2mHUTN55R/hlek5hUePN/ZPBHWFRuEffOgxJcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9182

T24gMTEvMTkvMjUgMTo1NyBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gRnJvbTog
RmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5jb20+DQo+DQo+IEluc3RlYWQgb2YgdGVzdGlu
ZyBhbmQgc2V0dGluZyB0aGUgQlRSRlNfREVMQVlFRF9OT0RFX0RFTF9JUkVGIGJpdCBpbiB0aGUN
Cj4gZGVsYXllZCBub2RlJ3MgZmxhZ3MsIHVzZSB0ZXN0X2FuZF9zZXRfYml0KCkgd2hpY2ggbWFr
ZXMgdGhlIGNvZGUgc2hvcnRlcg0KPiB3aXRob3V0IGNvbXByb21pc2luZyByZWFkYWJpbGl0eSBh
bmQgZ2V0dGluZyByaWQgb2YgdGhlIGxhYmVsIGFuZCBnb3RvLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBGaWxpcGUgTWFuYW5hIDxmZG1hbmFuYUBzdXNlLmNvbT4NCj4gLS0tDQo+ICAgZnMvYnRyZnMv
ZGVsYXllZC1pbm9kZS5jIHwgMTEgKysrKy0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMv
ZGVsYXllZC1pbm9kZS5jIGIvZnMvYnRyZnMvZGVsYXllZC1pbm9kZS5jDQo+IGluZGV4IGU3N2E1
OTc1ODBjNS4uY2U2ZTlmODgxMmUwIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9kZWxheWVkLWlu
b2RlLmMNCj4gKysrIGIvZnMvYnRyZnMvZGVsYXllZC1pbm9kZS5jDQo+IEBAIC0yMDA4LDEzICsy
MDA4LDEwIEBAIGludCBidHJmc19kZWxheWVkX2RlbGV0ZV9pbm9kZV9yZWYoc3RydWN0IGJ0cmZz
X2lub2RlICppbm9kZSkNCj4gICAJICogICBJdCBpcyB2ZXJ5IHJhcmUuDQo+ICAgCSAqLw0KPiAg
IAltdXRleF9sb2NrKCZkZWxheWVkX25vZGUtPm11dGV4KTsNCj4gLQlpZiAodGVzdF9iaXQoQlRS
RlNfREVMQVlFRF9OT0RFX0RFTF9JUkVGLCAmZGVsYXllZF9ub2RlLT5mbGFncykpDQo+IC0JCWdv
dG8gcmVsZWFzZV9ub2RlOw0KPiAtDQo+IC0Jc2V0X2JpdChCVFJGU19ERUxBWUVEX05PREVfREVM
X0lSRUYsICZkZWxheWVkX25vZGUtPmZsYWdzKTsNCj4gLQlkZWxheWVkX25vZGUtPmNvdW50Kys7
DQo+IC0JYXRvbWljX2luYygmZnNfaW5mby0+ZGVsYXllZF9yb290LT5pdGVtcyk7DQo+IC1yZWxl
YXNlX25vZGU6DQo+ICsJaWYgKCF0ZXN0X2FuZF9zZXRfYml0KEJUUkZTX0RFTEFZRURfTk9ERV9E
RUxfSVJFRiwgJmRlbGF5ZWRfbm9kZS0+ZmxhZ3MpKSB7DQo+ICsJCWRlbGF5ZWRfbm9kZS0+Y291
bnQrKzsNCj4gKwkJYXRvbWljX2luYygmZnNfaW5mby0+ZGVsYXllZF9yb290LT5pdGVtcyk7DQo+
ICsJfQ0KPiAgIAltdXRleF91bmxvY2soJmRlbGF5ZWRfbm9kZS0+bXV0ZXgpOw0KPiAgIAlidHJm
c19yZWxlYXNlX2RlbGF5ZWRfbm9kZShkZWxheWVkX25vZGUsICZkZWxheWVkX25vZGVfdHJhY2tl
cik7DQo+ICAgCXJldHVybiAwOw0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxq
b2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KDQpKdXN0IGEgc2lkZSBub3RlIGhlcmUsIGJl
Y2F1c2UgdGhlcmUncyBiZWVuIGEgZGlzY3Vzc2lvbiBvbiBsaW51eC1ibG9jayANClsxXSBhYm91
dCBpdCwNCg0KdGhpcyBub3cgdW5jb25kaXRpb25hbGx5IGRpcnRpZXMgYSBjYWNoZWxpbmUsIHdo
ZXJlYXMgdGhlIG9sZCB2ZXJzaW9uIA0KZGlkIG9ubHkgaWYgbmVlZGVkLg0KDQpbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svMjAyNTExMDYxMTAwNTguR0EzMDI3OEBsc3Qu
ZGUNCg0KDQo=


Return-Path: <linux-btrfs+bounces-15019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049EAAEAF10
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 08:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3311F3B5039
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29ED212FBE;
	Fri, 27 Jun 2025 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K6BOc8kD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wwTYJZt4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A052F3E
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751006239; cv=fail; b=Y4zS6FOhCZPB4CvPu8yIo+KifpO6mwNQmPoCYKCFiP1uUcCuKJAYjRwDC5+VRD5zYY7dSeBeDiq7TdUar+FXkFtX2sAsxdSU41SqOwEE4jskCNBs1M32Ju1HuereSNrBzk8NWPfCuqpc0BP7zWXX8cc4kVItSEirfAQOTTm2ztk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751006239; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LKAf9lRY/AcWtLyddlXeD4SZ5RFDbXOpalX7bEmaW1vqRH2jypubsg+SiGdOSemKSAMLcha9QqojlGmPbBb813b5LM+wwImGUu/Ppyr7eKf5KzGObTkDrokdKNMSlJW6fG+HxJHjIHTTIgQ6oHBH/n+nFMeNrwmBkiXjtFbvQM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K6BOc8kD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wwTYJZt4; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751006237; x=1782542237;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=K6BOc8kD3PDpiK1Cu29mZFhP9EMIxsDSIr+e4iZEb1qh1iKOOCy7LMKf
   f8ggJ2uod/Vx5kXz1MAabdAfKgc+vAVFizK44W1tH+8jRl/gHxrgOqyE1
   ly4O6Ecm0GyITNlRX2kUS78KhytUyxcA1VUEtbI8wGBoKCZfMUUlTIaXD
   q/2qsmoiT3omAOkc3+KmJzdnlw35ML1I/eFufjHNl+m2qptLNCxxAIxeK
   AW1ZepW3tnrTFCdjn3AUJty3UAu8SDtxbS/jP+4K/oM3hC5L3aJhkbB85
   qidZn2LtQPlSr0GLwDc3/pnoQ/AJR81qrs13OXMLgBckzJ4lW6SY/LEtH
   w==;
X-CSE-ConnectionGUID: Ijsg7ExJRWqO1a6vG7amGg==
X-CSE-MsgGUID: CQntSthqQumEbPZop080FA==
X-IronPort-AV: E=Sophos;i="6.16,269,1744041600"; 
   d="scan'208";a="87320497"
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.59])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2025 14:37:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krHsRYXrsUO1039XDrLRBkJzmzTY6L6hUaEGSVfe10YXMjCzyz8Np9sSg1lPc7J09Fr7zzDnxRwlnOZ7sZPNepUW7Ztg0J94vdkfidwezn6QcK4tTb7R4mMxcS9Oj4jeySRrivSt8PuYCfjFb0W1pamax1q6QPYu0ydl3rwHSABOiQ77zQe94px2/kIhJa/oAav/tYR2vmfpEGRNuED+/Qo9XKqMvue6vg8ColDY0FWDJeWyB1u9lqD7wqbpc4OkeYrWIbAFI2a11dRPJ2yfZYAq9U4CIyRpS2BLccVVvCUr2OzLhIcyNQxpzY8M08EMjv/d1IxGO3uOczWJXDm/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=V7p4Fk8YLW3OjP7KuWv+jkVYUFqXdViOForMxAqRd5Jz0IIc7GVkIlmAfK9rIuOPM+EN3obW6wABnherHXkIQAp9v1rponzJEXVOX2dthUb+UrPUf2Lk+m8wKiCH4xEUEG8cI4FTxjbaRDvZb1HsqgMwel3WAQyIoQzVseaZi8zkTVJnJppHXCpNAZedJd65fflmFzK0Jyhq3vSA3uUIhxOEK6VcT+1fhg0t1Jof6R6ZeXpGDQG+ToTyib+JIvRpK9CNkQEDCclOxA2i8Onu0tqYVUIjCfYYB4DZe7X8/PLm3V7igsR6kwgz+C/I9G33XvrN9HWqHXc9toTZ11oiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=wwTYJZt44lyYTFC/semOfoQoCh+Gu8gvMSjtCboDnSaZAOPib4pxnmDeN0Q1feECoa93zedI/9AR3OKzGM6Z83fymtIq6q7qjMv87VjsWaOMmw6Om7nrw08sCqfz47exeMzaXd6Ni8CByIZhJIHXpka9L0GwtCO/X7nISzQsLlg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO1PR04MB9535.namprd04.prod.outlook.com (2603:10b6:303:276::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 06:37:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 06:37:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: qgroup: avoid memory allocation if qgroups are
 not enabled
Thread-Topic: [PATCH v2] btrfs: qgroup: avoid memory allocation if qgroups are
 not enabled
Thread-Index: AQHb5re1HHQWVipXoUiYKbsbY85PS7QWjl6A
Date: Fri, 27 Jun 2025 06:37:07 +0000
Message-ID: <256f5bc1-2a52-4ee9-8e48-4260d00da151@wdc.com>
References:
 <b0e317f51f01fd88c32fd14f6bd8ea40b88943fb.1750954008.git.fdmanana@suse.com>
 <bd2bcda4d19bc931752ffa7b1730c5e5fa9d7b48.1750955238.git.fdmanana@suse.com>
In-Reply-To:
 <bd2bcda4d19bc931752ffa7b1730c5e5fa9d7b48.1750955238.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO1PR04MB9535:EE_
x-ms-office365-filtering-correlation-id: 6e92bd39-e52a-474f-c20f-08ddb54509ed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bDM4Sm5oQlJ0SEZyUnFVeUZVMnJNdjJNeXdPN2xLempEUGtEZmxETnlBbVFX?=
 =?utf-8?B?bDR1bW4vdlFqalpJTXg1NXlBcGxHazJsSUJpMGNDZzlPVVlQa05ac3FDaWcy?=
 =?utf-8?B?TExUdmtXemxWWWp5TjJobklqdkRCS2xiUlBMYmVxcDUxWWROS3RUYXFZWTN3?=
 =?utf-8?B?eVlRYks5bWMrd1pMZDQ0ZzRkWHlKVWtrYmVlTHFENHM1aXBCM1dTcDFQQ0tY?=
 =?utf-8?B?UXZVd084cERYNVIwNk05T2NUN2V3bnN2RzJ4M0NtcHJkcXNaZ1hYaUtkOVRH?=
 =?utf-8?B?VUdONmZYQWxsMm9RakVmTUhQV0hxbTVjUGJhMW9Ka3U1VDNsK3Mxb2p6NnM4?=
 =?utf-8?B?YXBycHZpNEZINlJ5TWhMYVE4QlZUdmdxN0Z6YWFxMCs1TFVZQ2V4Y2RnYjZW?=
 =?utf-8?B?c1hXV01TeXd3YnlYT25DT3FEU1VHQXNOU3VIazAwTzBsZy9sa0FWWDhZWUpG?=
 =?utf-8?B?ZE43VDVoVk5hVnZkaUpkbHNsMUJLaXViWXlyT2VzTjNVZWZOMnE1bzA0cXZx?=
 =?utf-8?B?RDdnQmNhYTVWSm5PRWZ4SEdMZWt6Y3lZRno5UzlwOGQwMHl3Umo1RlRRWlpO?=
 =?utf-8?B?bWZ3OVpMb04vamtSRUlIa3RRaE5VdXlTSEVXOWtJeWZ3NnZJVWdpcmJycGpI?=
 =?utf-8?B?RnBzSVRNWSsvTFQ5dmNrU2pJeUlsSGpQYmUrSWczQWREc0x0MGZGSS9nMkV6?=
 =?utf-8?B?RjlnSEV0MzhSVTRJa1FEVjFRdmEzS1JiQjQxZFpOS20zaEpNQTVtOU5RM0pt?=
 =?utf-8?B?dVdPTy8wdW82d2pRK2p6VkZDMXJWd1NJNVFjN2hSRW52bzVXMDAyV3BkZ05u?=
 =?utf-8?B?aHZOUEJZak1Ockt6WE45U0FiejJWci9PZXZiSmwvRXhXRmdCUDVDRmF6TDJO?=
 =?utf-8?B?UStUTU1jL05kbWVMT0dqd284QlgrTk5zRDJDY3BaOGdmZWM5MitMRjF4V0pP?=
 =?utf-8?B?UVpNaUhOUHoyNS9TT2RHWGhrUE1TV2tzaDhUZUhId1RqQVJTNTRmNTJ4Q1NI?=
 =?utf-8?B?WkM1ZFBucFhuV2huMG9oYUZsWk5nYVVGVEdrZVdmb1ZPMEVSQktWY3pvY3c4?=
 =?utf-8?B?SDU4bVNQalJCclh5OXpEZndpQ0I4NERSRjNVZ2NjajZ2bkVJemlTZ0pLNlJh?=
 =?utf-8?B?RTYvdjQ2V3N5UkdkSUthWU96Nmh0dHVETDVNQndOdGpudXp0dnpCUzBhalhj?=
 =?utf-8?B?TlVzZzE1Z0gyaGg1dTFrOVE2b0tXMFVHcFFLWG5GSzNYdnlDYlYzdUM1aWNR?=
 =?utf-8?B?eTZ6OGZFT1VZZUJuZm0zd3Z2OVczUDdFUWVYYnAxM2V1V3dvQlBPdG5kL3ds?=
 =?utf-8?B?RC9yMTlKZlFFY1J1Rml1UVFvK2prWjdzcFNMMkhENWNURkNDTThiY0hWMUVV?=
 =?utf-8?B?YnVTOWluNE8raDRwdDlrWDJQN0xoZUovR3VDL1ZVOStzcHdYai9pcXZZMllE?=
 =?utf-8?B?RWVxZk1ySXdwMzhYaVQyeHVUSFg4NFFrS1RDMFlJK1MwdHY4V0hmY1laSEh3?=
 =?utf-8?B?eVdlM3Fuenk4UFh2UW0vRU0yRlRnRFgvczhQYXBKMlMyTzlCWGxNckhxK0Zp?=
 =?utf-8?B?ZkcyRW5TcmZKSlVHK1Rabm9nK2RGUlE0ZUlIMFh3aWFsSHFWUWVmdVNGVlZD?=
 =?utf-8?B?Qk9lS0NEMnY0MzZZU2U5MjNyTHBSZ2tXUndzL1hoaGlkWTJVWmRPR2VGWkNR?=
 =?utf-8?B?eVJ1U0NxZ2dvWDIwZ1FxTmk2Si94SEk3UURybFo4MTJoSkczRkNtWUlMeXpW?=
 =?utf-8?B?c2FOcnVQcXo1c1QrQ25MSGlYZUp3NWs4Z0I0QlcvVU1SakdDWUNEcU9KQmtY?=
 =?utf-8?B?Qm05MzA2UGhvdUQxMWkydFJDK2hEVmVyOUVnbVR2dU1YcENWd01EWGpTVUFN?=
 =?utf-8?B?bGI1RW56VHE3ak1LYmZzWmQweUhTY2kxMlVTbDBjUHJtV3Y2ZnJkakFYVVp4?=
 =?utf-8?B?Nmo3V0V3M2ZPN1Z0d0JJUlF3MkR0ekxoZnBaam5ES0Z0NWJjeTJnL2ZYZmRS?=
 =?utf-8?B?eTJDdEg4YXRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0dtTFFsSHk5QUVsZ2g5cklFajVXenZoS1A3UkRHZ1l3TTFWbSsyM2hWTUpG?=
 =?utf-8?B?Ym96MFFzc05DY1NwMlVPY0VhUHlkSG5lcGNNWkoxZWNMc2tRYU4zTmtOQ0dI?=
 =?utf-8?B?V0Y5K2doWm83UEdUbXUrNFl2RkcxWkpOVkptQllSajZFNXdDa3JQZHJLTkVs?=
 =?utf-8?B?MisxRnpOLzNiYXVqRUpZbURObkhjTHEydzc0QjNLOUZqNEZVQmhESUYwY2s5?=
 =?utf-8?B?eGNWMk1ETjNZR0Z2cEkzKy9zZmxUREZocDg4R2VHK2VsYlp1QTVSeHZteFhS?=
 =?utf-8?B?Q2hoVjRmbDFZN3VoRDRPUXcrTkNKVTlhT0IzT1VWdnRLUXFFQTNuMnBoeEhZ?=
 =?utf-8?B?SGtSZmF2aXJWM3hHeXdCM0VoUysyYy94d0xwclhaVEg5cXdSd2p1RVFYbFhY?=
 =?utf-8?B?THQzeWxnOXVhbkRUSEFNbTdZNmtDZnFRKys1cnFpMkdqTzZzMjczQm14TmRO?=
 =?utf-8?B?NmpSTS85UURXYUpSQ2F2YlVWak4zdjFUOEd2YngveWpTZ0xKK2dmdWJTSXBs?=
 =?utf-8?B?dFFXZFF6aTlpeGt0bWxEN2l2WjhiUlMwZUV0cXRHT2J0dkZ6RzhEMkh1OWJE?=
 =?utf-8?B?UERRenJPbTgxem9Jd3ROVFEyU3VwZ1hubjNZRTBXZE1mQS8vckQyK05UdFZz?=
 =?utf-8?B?d1lXVkx6SXIwR1duektULzhSUVZhSUZIQlpUeThNWTBIckFBWHNXM1FVUDly?=
 =?utf-8?B?dWs4Smg2L1M1MWxnZjJQZUMxdnl5dis2em9pZHdteW5lUmNOUVRrTW1RNit1?=
 =?utf-8?B?Mi9MTmd5bVZxYmhFVlV4bE1YTTVSRjJjdC9wQzFNc3RYVS8vTmVVM29PN0hn?=
 =?utf-8?B?eFRrUUVsV0hhY2JQTW1GMmIvSlFuK0tHaGdBYkIwUjhKeHdpVW9HNGZpOXQv?=
 =?utf-8?B?NG53UUFnUnVNSlZ3clRuV3NnVGtXVTdFVk9zTkttaVh0UmlTRnhGVEh6T1lr?=
 =?utf-8?B?cHpZaEJMK1ZqUjkwL3VXV1BjeEtXcmNCejQvUU5qYS84RzdCV3BZSXN6RFZO?=
 =?utf-8?B?T0ZGbVppUm9zMkNQN2pmbDREdXIvRTlLQlQwc0NiWUlFWTRjcGVOQlU2b2Z6?=
 =?utf-8?B?Y2hQRlBWbGozdGVIWVAzNzhOa2Nzd2ZNZ2lnZGxVWnpmM2FIeVBUT0F1QmpL?=
 =?utf-8?B?emdvN2J0SmdOb1E3ZlEzYy9rcDJQVUJuZkRFTkdOamNITVRaWjJnZ0Fja2lL?=
 =?utf-8?B?NW5JdVNUNk1mSGRZa0F6Njk1L1BhRGkzS3hvbjNjdzBsUzE1YmY1OHJKRFpW?=
 =?utf-8?B?YmNCcmZpVUJrbTREbnV2Y1lmelRpWVNkS0F3KzlSNlFIa2Q4bjNtL3B2bTJU?=
 =?utf-8?B?ODYveTJIUVNTNW5wRGJ5TnRvSTBEdVpNa2RyNk03V3dhRU5rL2hjb2FPZ3dz?=
 =?utf-8?B?QXhSMnF1RzBUdy9OTXdNU2VsM0IrM3Q3TXh3RVcrdDR4d2I4bmZ4SVJEMno4?=
 =?utf-8?B?Nzd5akNicmgyVEt1Q2lQcnpSbmdXaStSa1ArS2kvUU5VeFI3RllCYlc5RW5Q?=
 =?utf-8?B?dzcvdGw2R0FtQUJGZUI5ODUrN3R1bmk2cHRpb280RG9hdFRqaVBaM1dSRHpj?=
 =?utf-8?B?d1pxSlkzTXo0M1VmSjgwNkJrRVFVMDJMcGFUSy9QNVIwek1DNnZvczNoemky?=
 =?utf-8?B?Ym5RVXI1Tlo4YnVRaGVxOFNJVXEvRldCMU1SaVYybHJlaHB1c0xGaXZMYVZu?=
 =?utf-8?B?ZDVXS1U1LzluaGxvYVd0eWI2Z2NsOS9YeXl1SGxCSFkzWGcxQkhSOVZ1cm15?=
 =?utf-8?B?dHF5ZUFKSGNBRkF4MDhFcXRna2VHaVZrUXV4d3RKdTNDdEZaSDRXTmlOdXQ0?=
 =?utf-8?B?RDZrakFZcWM3aTdmbFJtUlVWZTVET1oxNThKajd2V0NxTXN2ZGNwTDB0K1pl?=
 =?utf-8?B?RVBjcGptTXcvaGY0UngwcU1KZSs2eGNNSUgxUk1BVlZLYTNHWXMwMVR3aUlM?=
 =?utf-8?B?VnhOSjVnTzJ4YjdEMi95a25HUVY2bmlWaWY3OFY4T1dONTVvRUlYMXRZTTBq?=
 =?utf-8?B?QVd6WitEQ2h6RVRBSktJQk1zd1pSbnpFaVRGdDl0bXMzc1dYVDkrNDVlWVFm?=
 =?utf-8?B?V21uSnZSU2F2amUvTmI2T1pzRDJiQWl3eWwwWE5iK3NKRW82d0RQcXBvWDlq?=
 =?utf-8?B?N3c0TDBYZ2loRE9WaGxyejQyVmtHbmo3VEQ4Y1YyZDVtWElUSEFWczQwYmJt?=
 =?utf-8?B?TENsTk0yREpqNlB5V01KbzFRMFdFQkVwVFNWWExVZGlpalV6Q0Y4d1VnSVlt?=
 =?utf-8?B?VVZOQ1NJa2JzcDJLSkt5OGhXVWl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E08C6CDC8E03264DB3CE7FF9E818032F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QkJWHUaT4h3biauk8lAmzC+aWylgEXcb39gW5RZG4MB/HSIcHlcvAdoEUJ3e0aOodH0e/2xYiD42/CTrjCW7dbOPITJcxVtHOiIA6RZPxN2Ex4bwkL7w1I9Kk2z6WK29uwL70U0ULzFOFKjdhbBRXirimolTEMrMLwveljlORR/VlLUNL5TYo113dFPwXpSi7mplt9irOSFjPW4R+Ylo+a0jF2kAMmGpgPk9RsDcKO76eLkNczGHpwYa/xhp1hOznD4NwUZZV5mzjOrzsG9pbgPJFxO7ddjUwFrsc8lG1x0fh3Wjti7UFZOTIABchSe16DBTXVMgOswHamfV0jQZV25GsEfcpbxydabNHirdaaJriTgakaTNUCMDj23P8F7z2tZFt4XqcSxdSt8uWhKgzWEpo9VRjh4ngQRhBQIq/zCEyz+Sm9FiRwNgNQ+Jgqc3bLMr18QNuQB3CwRyuLFbs27IroToXZyip3Ni3QCkLAsawqkRJcU/AuMHn27Xz2A7TwVgLi+umQvpSUc8NROy/D2hl2M80eOaSh8Rbot8gjIsl7dwbvNGaRQj1cV1DNTEnL1l6MvqYosBIT4uR4hbsaxIerBLgn8TIb0pMnoRcagsBGBVV2+dXBmxguNYZCj/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e92bd39-e52a-474f-c20f-08ddb54509ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 06:37:07.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbywxQZRPCrQhpmyAYUHLvVy9hB86HBklG5YKHyyB/XY0vqcFczSzjBT1tDANX+PlzaT+BcKxp/2+v2z8DyToYrNgti2CEemGNrXhZ9iV4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9535

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


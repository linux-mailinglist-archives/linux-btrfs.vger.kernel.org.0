Return-Path: <linux-btrfs+bounces-13115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C4BA9133D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 07:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C613AE35D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 05:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744AC1DEFD4;
	Thu, 17 Apr 2025 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fT3sWrDU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kLapE473"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF91DBB0C
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868899; cv=fail; b=OOmGHPbDJLR/zUoMmTE5e4zyy9PIN4zgvR6l7KMiBe7LCWBt5nrW4CVW4m1Arf+NjVauOkXUS5HJBdGnSIKBlf8U8MmUJv1ABki57Pb1TE1TSXq8Fg949w9ehE9PtBBz/Cp4mByPqTtppDDUcswiqDRsx/kKf0oAKvx2fOcD+IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868899; c=relaxed/simple;
	bh=4TxSNuEisqEjZb2XNw7B27+JhKQr7Qs5bozRXKBWovw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ya2pSwFsSzlYFA9Obki3oQD+tyTIbSLFlDFo1BoW/srr+RuSN8oI83PX2dHfn0/rPBr0WB2pa8EVutPKc4c6janqkkuTtEdcynx4kFuLpzvZOR+1V8IweNB5wxY04tdwRFnILr1BR4j3J/JQgEB4NVetpWfi0jPn2NuCoEGoLMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fT3sWrDU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kLapE473; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744868898; x=1776404898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4TxSNuEisqEjZb2XNw7B27+JhKQr7Qs5bozRXKBWovw=;
  b=fT3sWrDUTP1+qOQXUyttI3vSsH4evbHjpwCH3jonrHIWHfpsMI83xpY+
   ceYHc8WJBm+63JAFGQmohoQ0xJLiacYGEMgihIk1McZSKB+H+OnRxjgCw
   ilJtLco3UF1MsdDr/gio8zQe33JkEKtQILDuWVA0+7dS5iJNS5EmMDUaU
   3P8A3FOGNJdUTulHvfpMss/3z3414e6F81bgDCodOGmG6yW6iAdqohUru
   26Raz1nyU2o4CkwxgUuorp8VF2uIuFK57qNHmCU+geu03CN/5PDnBtCyj
   GvUA8FHiF7f31l6GRmJEIZpvLbSRbkrwAZBl6b7g0vJ3eGsNXZgYDNSir
   A==;
X-CSE-ConnectionGUID: 0y/pc8IOSBGdxo9eaB48Aw==
X-CSE-MsgGUID: 7GnN18bpQYGZV8I97f5iwQ==
X-IronPort-AV: E=Sophos;i="6.15,218,1739808000"; 
   d="scan'208";a="77018716"
Received: from mail-northcentralusazlp17010007.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.7])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2025 13:48:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVRzGMMKrGSZAKlX1E+MR0DyyU2ucoNJah1LX4TAwKvJKEuyx+XNwCJLJwjupdu4am1q9ApAtDcXdZJjHnueozNTuggKitzkqIOzDX1xJltkOtpzrX3pdWvnNSdUTEk2VAH7axgzTB+Vtd2PUmktiSUozuiX3vuOKjtxBE5lVwol5A/Xs53ey9v9Cm7NZSN84QuWiDGN7uh+ycrFGvW5a0B6jaf6qF7yeMmD1V1ur499SSPXjcdzsQT1GzGzig4/nF49fpcSnq9L/OAYAtd2R8TSmml45uxjXyJjdmC9sZt5nGWgp87pzqfxbIy6sKEXT6pHjeBCUSbF12rsuEl+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TxSNuEisqEjZb2XNw7B27+JhKQr7Qs5bozRXKBWovw=;
 b=RFl8cYadhLdSe2EU+6r5G+smKJAzQKkzrc209XCp4L8O6yszMYLulqw1mNFKXBaZYdIcHzuYCFi0kIH32dvqTBPpsQeAB8/BqkthXLOelX2jLHwPMc9QPFysAlHuSADVzQspE0h0EDmyIjio2Yv3x6kbILpLm0jrp4qSOhoWUHgDySlC7S+BCD304grvNU1m54xn95F0AAuWeD8dpIzSXzUStshSt97DlB7kMlt/ej6eic1yBA43orHE9D2A3+ZCY3mJowXR909WNiaozNlKKHmTctNZ7KOD4nHxI4XefmsxD9BtK3EX1NGqYyQDOHQDHBOiQ3S0kJJO9ViCSocNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TxSNuEisqEjZb2XNw7B27+JhKQr7Qs5bozRXKBWovw=;
 b=kLapE473cTOX4Waq5BOi+tcAGHqi04zzT+wOU7CGQ5cYtCtwrqVqACLvtdPa8XMgfzAPwjgznW5DVoinpcW+3cTH9b7FnwSA8L1hr/T3WN6H137zhVFbq7db8S177BeEErINP8o0spxrSIBe9NHIKXs3WVFxCFMwVaAVW+/i++A=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY5PR04MB6550.namprd04.prod.outlook.com (2603:10b6:a03:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 05:48:06 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 05:48:06 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v3 10/13] btrfs: tweak extent/chunk allocation for
 space_info sub-space
Thread-Topic: [PATCH v3 10/13] btrfs: tweak extent/chunk allocation for
 space_info sub-space
Thread-Index: AQHbrtvaGYHssBDS40W37O3UjprjWLOnWtyA
Date: Thu, 17 Apr 2025 05:48:06 +0000
Message-ID: <D98OEC5YAKLG.2YIJ1CI1YKZ1E@wdc.com>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
 <520eb9731dec3ab8b6c445bd5eb2ad7d3a1be700.1744813603.git.naohiro.aota@wdc.com>
In-Reply-To:
 <520eb9731dec3ab8b6c445bd5eb2ad7d3a1be700.1744813603.git.naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-mailer: aerc 0.20.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BY5PR04MB6550:EE_
x-ms-office365-filtering-correlation-id: 17db06fb-c1df-40fa-1184-08dd7d736d67
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aURhM3AvaG84NzljUUFvRk84RFNXQ3ZQU0t2KzdTZTEwdlNtamJTS1lGYVZ0?=
 =?utf-8?B?aHJZb0dZdlppK25LRFhBSUt6VHA2ZmJsTklrM1JET0pjZ3hvcVZYeThpTEFp?=
 =?utf-8?B?Z2FPV284QTdYcE4yYmxTTDFQUXV2Q1FGUVErR2tpLzZoLytXa2F4TE5razBR?=
 =?utf-8?B?OEczMlJzeE8zNzlUVm85WXV3ZTdXakJzKzQ1Z0M5U0VKamM4Z2o3UGcyemZr?=
 =?utf-8?B?bGhONm9tamllRVAzVEpYM3c4R2hHdkhya01UbWRINmsxKytBVmZDcE92S0JV?=
 =?utf-8?B?K2FOWGJMZHQrWE8yVVN4VnM3bW5ydjN2TkxBdFhCcmJPNXlBVU1aMjdya3BG?=
 =?utf-8?B?bm03eGdFMFlURUdaamNsbDIrQlN6K05CRUU0OGtuU0RaUXZWa3cybWZLK1Jo?=
 =?utf-8?B?ZjdTVXBUQklrbnVxemRqVkNTZ2Y2cTZGRDJrd3J5emI0bW41bE9nQmRPcHFR?=
 =?utf-8?B?TDZDeXFNdzVHVGlDRzloRzV0ekNjcEJId1pOTWpDMlQxZkVEZUlpV3FIeGJp?=
 =?utf-8?B?VWRVM3BuQXlmeXVmTGZXNUJQMFZQbGFLbFBrSm5mdFdnQ05EMGQwRFdYaERV?=
 =?utf-8?B?Q0FMRmtoRjF3b0hqaXdndlZJYjVMdkhJc0J5Z1lCdG8xekZidEl4RTRUZENz?=
 =?utf-8?B?OXdkTmFIZkdpcFZLQ2Z3UER4a2tXQW0wZ1Z0ME5uZE9acnhPR1JTOUlzK3Ir?=
 =?utf-8?B?OGRWSE12R09VU3oxRWE5NUw3ZnBJZ2FwVHd0RXdWMUQ0L213RDUzMU5senlC?=
 =?utf-8?B?MmxwVGZQUFR0cnc2aUFFMXJWeG1xVDZaa2R1VVRHSW5sTjBxYzZpK2NESkV4?=
 =?utf-8?B?RVpGaDU4cjBiemdGOWp2ZlRCQnBsRE4ydzN6NGNWdHZWblppL3k0SytGUEtn?=
 =?utf-8?B?VU1DeHNxVHZIK1ZMQ0NpeVFpeGxKRDB2TUtNMnFRREpETFVOYkZBTXV4NDQr?=
 =?utf-8?B?bTFpT1VNcGhNWEo1VVg3eEhhMU01a0d2akV0TUE2Wm5JeVZEcWdReG5lZXN5?=
 =?utf-8?B?TmJuK2FBc1h6TkU5Q1l0d3ZBMzdLZTJUWUs5QTdtTmdkc2xiQ0haRk14RmZF?=
 =?utf-8?B?U3pyV1hlNE8vQnBmcVo3eGxhY3NTa0MrMVN4OFZXMUdybm5HelpIN0plN3FO?=
 =?utf-8?B?MmRFK0dpbDJJZC9TQ20vQnY3MnhlaVRrMFVqeGROb25rRkNsOThCSDVvdTU0?=
 =?utf-8?B?V0tCWjNvb05VdksyaEw0ZFkxdHp0Wm05UGpQaEUyRGZuazhsRlpBUmxpYTlq?=
 =?utf-8?B?cWxGeVZrbWdrWU1vTEh0L2ljY0hETngxRTlYajFoZkpjanpRUTl5a09WWVNv?=
 =?utf-8?B?SEdFL003QUI4R0RKUnBRRzZVTkNvcksvREZSYU53dGFCN2hnTjFwaXN5WHNQ?=
 =?utf-8?B?Q2NzR1FCdy9sRktFS0hlT1FSekJsRDh0eTRzQjgwMkQzWGUvR2loN0VSSllS?=
 =?utf-8?B?V3p6WjExZkgvUHU1TGh0TlBvQlU0K0R1QnRGYzkwSlNxZG1JcHVCVUlLMFpn?=
 =?utf-8?B?VWV2MHRLa2VYNXd0cDJ6T3lkcUZsTkpjTXk1dE5OdlFKc3dWRGZVc1A3RW5t?=
 =?utf-8?B?MWRycUducXROenF4SXcrenh6TE1qV1p1cnAzOFlpN1RMeXJNamhMTmNpRGw4?=
 =?utf-8?B?RGZyb241bHhxcHA1SXZFYWIra0tzVWhqNkhqcUh6aU9OVmJvdWlHdXRrbldR?=
 =?utf-8?B?Rm5iMFlrNkNHOG9qMzc1Q3I4d0xCaS9RUzkwSVRKK3lrQnMvUnJ1L3pmTWRR?=
 =?utf-8?B?MVMrek9ZUStQN2ZqeEdjOVdUSWdvN0VDeWFhQ3dwdi9UQzZNVXRieTR3dllw?=
 =?utf-8?B?MmJjdXJJQWRneFBjbTkzeHdFQU5GQkk2U2t5RzJYN0RQKzd6UThsVTEvclJT?=
 =?utf-8?B?N1E5MnFSZ3U3YXpqbE1XY3M0T2I1WHRXZTdTUnVEZnhsaGpSa01BR2NZZSt0?=
 =?utf-8?B?Z2VhVm5mc1Q3OTdhVXc3UTFYQmZaSjlXdzlPZ1dhdmgxdE5OTStMNEEwV3JQ?=
 =?utf-8?B?MFcrTElZRVZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vk5VOXpxVXQzZ0ppZGNZbm5jaytyYzZSWk81Z2ZxYmlGZldUei9FZUFnQTBI?=
 =?utf-8?B?Z29UNGl3UlVRaXZBN24wQmtFSnpWSVhUaFUvMmo4cE9QNGZzWFFzVGhnd1cr?=
 =?utf-8?B?aDlwNU10OC9NdnJqRTQzNHBEUWNqTWdNU2FsblZpSWtOdStzS3pNNlE1SmIw?=
 =?utf-8?B?eU9ucmJ2RDRCa05wTW9sL1ZBS1JOL3lHS3BEUVFJR293TGZ1Y1VMRjB4QnJ4?=
 =?utf-8?B?UEFTNE1tdi9uc29aM1MyeXEzN2h1Njk2WmVGbHpmQXdLSm9RT0J3OTFHSmIz?=
 =?utf-8?B?WGlwRVF4Ny9uVVBZcERPdlZCSmRhYVl0clB5cElaSE8vNEtEQkxvemRmeXd6?=
 =?utf-8?B?SHMrRkI4andXcWVvUFo2eitqZFY1Y0pQTTlTUE43U0t2R0pJRHBUVy93WjVZ?=
 =?utf-8?B?bWswU2lYYUVsSjduN0kvOG50SnJONUtpL0ZnNUtoTFZ1aFdLVno0WVhPYmdL?=
 =?utf-8?B?K0tJTVg4L0pvNWFGUjB5TEpXWDVhYVdZejdUUHZHV3VVaFFyUHlNYk1ELzhr?=
 =?utf-8?B?UzZZeEpTVGlKSmdUVitrUUp2WU4wa04wTDBlTDBoNzRnMUZhekhUY1FrNHln?=
 =?utf-8?B?SjdYcUtTVzdDZWVSOEliZ3JPLzk1VzVzdVFzTS9DcHR0NGpDRmdhZVZpWExH?=
 =?utf-8?B?Tk9mODc4OGZ0RUthWHNrWjl5aWtiOHRwZVNUZUowb2MwSmFGNmhRdmNFOE0r?=
 =?utf-8?B?NDBhSWZDamNmenFjTjBDWktNdzdNNHZSb3grZW5Heko0ZE8xRy8xNjNKWmdK?=
 =?utf-8?B?UTA0WEpvMndlK2JhS0VXdDd4SWU1WW9oRXpSSW9aYk00MEh2Y0ZPUDBpdmxU?=
 =?utf-8?B?dUJMd3RZUDdFSk1nNGtLYnJaQkN0TG80L0JZb3lrcWF6c3ZMMlZCM2ppSUZ4?=
 =?utf-8?B?K1NvMWRZS3lXaTNGZERPeWhURktqdEYraEZreWYwSWJVYW5GK0tnSERMV0tx?=
 =?utf-8?B?b2NRaDdUYlR4UXdocjc1d1daR0dlU3NEK1NieFkxdWQ2NWFCaEFEK1QyNmNp?=
 =?utf-8?B?SFRaVVdYVkV5QkVRNWVwV0tGR1k5ZDBVQnNNeFZrbHVLakU4UWtLNnN1dWM2?=
 =?utf-8?B?NzJXWDJPRnBKZ01LS3ptblVmRTNTeCtlWkF0NFNqaFRLODQ5RFRzeWxtcmhW?=
 =?utf-8?B?bEJabElzbXJOd1A5L1BveDJ4VDNCVzFxMU8vQTNRcVptckxFNGdlTkJXaG1T?=
 =?utf-8?B?Rk9yRmNLbjNIV3Vjdzg3R1dnQnRZTk1oTTFvNW1IaXd2K2dLVFE0YU9HK1pX?=
 =?utf-8?B?T2ZMWUdBbTdsOGFtSlgzcy9BcXl3K052WlNDRGtRcjZKNjR1Vm0wZFNmR2tN?=
 =?utf-8?B?Wmcxd052d3RUeHFTR3BUYmphbHNmNml6SFdxWkxJaGpoeE03cWp1TjNrUFJK?=
 =?utf-8?B?T1ZwNUNmL1Fkc2FCaEUvbXJOckVuQ3NRV2oyb1pwM3F4T2kyYmF1N3EvVnkr?=
 =?utf-8?B?dEd1THBHWTF3OW5hQmNzMGVrektFNmpIWmN5RzFtalBOaGJSYnJKM0ZaQU4w?=
 =?utf-8?B?UE45aUpRUFMySm13ZHpmZ24wcFU1dmFjb3gxY0RtYnlrL3g0a3J4TWVxZ2Ri?=
 =?utf-8?B?M0lyV3JjS1l5SWE2VjkwdFZYU05aekx4c3VQLzZ5cC92ZWRJQ29TYTZsb2dh?=
 =?utf-8?B?UTB6cmRoNWNJOUQ2TDNJZ1FCaGVDWGs3eW1PY2YyR0phVHN4bkN6a0xtbHVp?=
 =?utf-8?B?R0ZzVUhtWE13ODlBK2NmNDF3TDRjeTNTZUFNVERnWUNhWGN0dE4zamRuOFNY?=
 =?utf-8?B?N0w1Q2Vhd1gvUTd3ZGZhQXNxak5tZUNKZVM4b0x6L3I2a28zS1VidlJOU05y?=
 =?utf-8?B?bnZua1NZQ0dna3FDSUtjQmxCUjFQZWZBcStqRVBmQkVZd05nSkJVTHl4N2Nu?=
 =?utf-8?B?MzR4eHNnSUduN3NxdjFSUFg3djFLK1JsVWlXajJkYytYbUFsSkFtYldmdVdQ?=
 =?utf-8?B?YXdYQXhlbndYeW9CT3ZmSlVUeUJIMzJRZitWbmY3bTJuVXMxeXk3ckJHa3Zh?=
 =?utf-8?B?Mm1PWnF5S1BpS3FmV011WS9UWVA4UzlONzdQM1ZoY0RaRE5mbzRRRVVwb0hZ?=
 =?utf-8?B?UFRnTjN3ZDN2U2xjRVpuM201TmFYKzJtOS9NVVFST3ZpeXZJdlhpTFp5ZStk?=
 =?utf-8?B?NzdJNDg2ZWVEaGVrdHd3RWxENVBETWE2WTV6MEQ3TWNoQU5tMGhTMVEzVWN1?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71AC22DAA71C664C91B2C558B00DED22@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oFWN3H9YoPQQzAJJH2zgXBOkZkOMSVi/D2cU5TOfyVkd6+YCr2M5nIBNekfiVbxS2wM3RuKPFiP9pgGyDrIZ66HyIReGGKdf5b+9JSR4qFuOObvyyyUMd9eXCMwQ/e/6x0dpwB7z60T445IucpyCJLTuOvLV444yE5jo73wGQjErPduiRF9Tohb/+05q6Ayt8WRw4oJiEU4NT/WlVC3163qJPVbXGPXm0UUn/sk2uMm42NgbYHTZCWn14+pOq4Xa8LRPnTV0WZCaNngLE4aH7RrrhKPmqQ+z8+jZ03XbR/ifzRE4iqb1RV6G3AfHEKlLhg/uK71mjxbJKV7pTVgjyxwH3EJRwxJYnqzlfRNwpJX2qtTA9zo17JQDHXNyDEjSPK4Td5usmso/fsDHqfNXi8gsQwVAUC2IffHAxxBAWQS8vsBjsngj+qrepNbXIdC5mepNLEbiGkz2JBT1xYYauANkilkel3KVuEsj2pUP2cprKCQdP6aFv1wVVT2PHZGTQj1N4UJ1M0SrZMAVxKBNBiUBpQDm2XYfKz0xbuO2UklxwHPBzExvTQKGWTg2ToaJGBOCMRDhpM1X3pFkAIVkqT4DGl9mJFDprhWUjMam8NFkgg9dI8OPZdfLi9xJBhTo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17db06fb-c1df-40fa-1184-08dd7d736d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 05:48:06.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8ay3HO3/2/k+eQTUTOMufAsfj24NH0uyBfNqbXUupeuZeEYlpykD+E3/9nbzxkrL+Zn09vlEscjKVSJGCBvBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6550

T24gV2VkIEFwciAxNiwgMjAyNSBhdCAxMToyOCBQTSBKU1QsIE5hb2hpcm8gQW90YSB3cm90ZToN
Cj4gTWFrZSB0aGUgZXh0ZW50IGFsbG9jYXRvciBhbmQgdGhlIGNodW5rIGFsbG9jYXRvciBhd2Fy
ZSBvZiB0aGUgc3ViLXNwYWNlLg0KPiBJdCBub3cgdXNlcyBTVUJfR1JPVVBfREFUQV9SRUxPQyBz
dWItc3BhY2UgZm9yIGRhdGEgcmVsb2NhdGlvbiBibG9jayBncm91cCwNCj4gYW5kIHVzZXMgU1VC
X0dST1VQX01FVEFEQVRBX1RSRUVMT0cgZm9yIG1ldGFkYXRhIHRyZWUtbG9nIGJsb2NrIGdyb3Vw
Lg0KPg0KPiBBbmQsIGl0IG5lZWRzIHRvIGNoZWNrIHRoZSBzcGFjZV9pbmZvIGlzIHRoZSByaWdo
dCBvbmUgd2hlbiBhIGJsb2NrIGdyb3VwDQo+IGNhbmRpZGF0ZSBpcyBnaXZlbi4gQWxzbywgbmV3
IGJsb2NrIGdyb3VwIHNob3VsZCBub3cgYmVsb25nIHRvIHRoZQ0KPiBzcGVjaWZpZWQgb25lLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0K
PiBSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2Rj
LmNvbT4NCj4gLS0tDQo+ICBmcy9idHJmcy9leHRlbnQtdHJlZS5jIHwgMTggKysrKysrKysrKysr
KystLS0tDQo+ICBmcy9idHJmcy9zcGFjZS1pbmZvLmMgIHwgIDQgKysrLQ0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZnMvYnRyZnMvZXh0ZW50LXRyZWUuYyBiL2ZzL2J0cmZzL2V4dGVudC10cmVlLmMNCj4gaW5k
ZXggMWRhZDFhNDJjOWMxLi4wNzQ0MTM0YTAwMDAgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2V4
dGVudC10cmVlLmMNCj4gKysrIGIvZnMvYnRyZnMvZXh0ZW50LXRyZWUuYw0KPiBAQCAtNDM0Nyw3
ICs0MzQ3LDcgQEAgc3RhdGljIG5vaW5saW5lIGludCBmaW5kX2ZyZWVfZXh0ZW50KHN0cnVjdCBi
dHJmc19yb290ICpyb290LA0KPiAgCWludCByZXQgPSAwOw0KPiAgCWludCBjYWNoZV9ibG9ja19n
cm91cF9lcnJvciA9IDA7DQo+ICAJc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpibG9ja19ncm91
cCA9IE5VTEw7DQo+IC0Jc3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gKnNwYWNlX2luZm87DQo+ICsJ
c3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gKnNwYWNlX2luZm8gPSBOVUxMOw0KPiAgCWJvb2wgZnVs
bF9zZWFyY2ggPSBmYWxzZTsNCj4gIA0KPiAgCVdBUk5fT04oZmZlX2N0bC0+bnVtX2J5dGVzIDwg
ZnNfaW5mby0+c2VjdG9yc2l6ZSk7DQo+IEBAIC00Mzc4LDEwICs0Mzc4LDE5IEBAIHN0YXRpYyBu
b2lubGluZSBpbnQgZmluZF9mcmVlX2V4dGVudChzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCwNCj4g
IA0KPiAgCXRyYWNlX2J0cmZzX2ZpbmRfZnJlZV9leHRlbnQocm9vdCwgZmZlX2N0bCk7DQo+ICAN
Cj4gLQlzcGFjZV9pbmZvID0gYnRyZnNfZmluZF9zcGFjZV9pbmZvKGZzX2luZm8sIGZmZV9jdGwt
PmZsYWdzKTsNCj4gKwlpZiAoYnRyZnNfaXNfem9uZWQoZnNfaW5mbykpIHsNCj4gKwkJLyogVXNl
IGRlZGljYXRlZCBzdWItc3BhY2VfaW5mbyBmb3IgZGVkaWNhdGVkIGJsb2NrIGdyb3VwIHVzZXJz
LiAqLw0KPiArCQlpZiAoZmZlX2N0bC0+Zm9yX2RhdGFfcmVsb2MpDQo+ICsJCQlzcGFjZV9pbmZv
ID0gc3BhY2VfaW5mby0+c3ViX2dyb3VwW1NVQl9HUk9VUF9EQVRBX1JFTE9DXTsNCj4gKwkJZWxz
ZSBpZiAoZmZlX2N0bC0+Zm9yX3RyZWVsb2cpDQo+ICsJCQlzcGFjZV9pbmZvID0gc3BhY2VfaW5m
by0+c3ViX2dyb3VwW1NVQl9HUk9VUF9NRVRBREFUQV9UUkVFTE9HXTsNCj4gKwl9DQoNCkkgbm90
aWNlZCB0aGlzIHBhcnQgYWx3YXlzIGZhaWxzIHdpdGggTlVMTCBwb2l0bmVyIGRlcmVmZXJlbmNl
IGJlY2F1c2UNCnNwYWNlX2luZm8gaXMgTlVMTCBoZXJlLiBJJ2xsIHVwZGF0ZSB0aGlzIG9uZS4N
Cg0KPiAgCWlmICghc3BhY2VfaW5mbykgew0KPiAtCQlidHJmc19lcnIoZnNfaW5mbywgIk5vIHNw
YWNlIGluZm8gZm9yICVsbHUiLCBmZmVfY3RsLT5mbGFncyk7DQo+IC0JCXJldHVybiAtRU5PU1BD
Ow0KPiArCQlzcGFjZV9pbmZvID0gYnRyZnNfZmluZF9zcGFjZV9pbmZvKGZzX2luZm8sIGZmZV9j
dGwtPmZsYWdzKTsNCj4gKwkJaWYgKCFzcGFjZV9pbmZvKSB7DQo+ICsJCQlidHJmc19lcnIoZnNf
aW5mbywgIk5vIHNwYWNlIGluZm8gZm9yICVsbHUiLCBmZmVfY3RsLT5mbGFncyk7DQo+ICsJCQly
ZXR1cm4gLUVOT1NQQzsNCj4gKwkJfQ0KPiAgCX0NCj4gIA0KPiAgCXJldCA9IHByZXBhcmVfYWxs
b2NhdGlvbihmc19pbmZvLCBmZmVfY3RsLCBzcGFjZV9pbmZvLCBpbnMpOw0KPiBAQCAtNDQwMiw2
ICs0NDExLDcgQEAgc3RhdGljIG5vaW5saW5lIGludCBmaW5kX2ZyZWVfZXh0ZW50KHN0cnVjdCBi
dHJmc19yb290ICpyb290LA==


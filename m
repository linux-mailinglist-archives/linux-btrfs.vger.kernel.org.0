Return-Path: <linux-btrfs+bounces-21318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDN0LUkGgmn3OAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21318-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 15:29:29 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C5DA98A
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 15:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D283053BBF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCCE3A901D;
	Tue,  3 Feb 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ECgeBRoz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FF+FQ9yY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640438E5CB
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128610; cv=fail; b=WWA8WA+DEkg4xZJ6WWNvcu+GZjBF+mAZH8C16FdtFfzO4xo4lRXvPwc9HLv//OIbN3N+wYs4aVocaEff/CvKLcafpKuLbXb1y+SGuFtOefFwDIlqPDf9Qhy8MQVKiO5BAyxhLe4atG1NB1sXTlt00JDYL/9pbvuSu0OyIZSHfeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128610; c=relaxed/simple;
	bh=C8RVRADJNef59zL0HVDZx2ewxJeXIFYTcRmvxsAzaBo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R9JkvniEf4CUPSfIKTsft+6jIKz/daxu1IlMcVworVSGpcSU9r1Ryd75Ct4M2Xclrrizpir4Bf/zMkAUYitl78+pPyKr4t4jvU4qMZwCBSeCKyHHVBSeKsqGXja4qrC21jKqcK3flV3M/z527L1ea5cY1M/8VvUYaLqYnSlYgyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ECgeBRoz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FF+FQ9yY; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770128607; x=1801664607;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=C8RVRADJNef59zL0HVDZx2ewxJeXIFYTcRmvxsAzaBo=;
  b=ECgeBRozfEvK6g4BuNYmiBdbLlj/V711DGJ3PNAMZ7JMwXPLgYxdWjyV
   Fvpo+qO8rmDJJMQWu2itdyUdJgpMgXCHZ27VfC2Z5hgIXb6ebR344JK0G
   KDW4/sAt4vkBjB8fFd3lHMAYOc4xIJR+AN60D5fOTS/GNBO49XZ8QUZDe
   g2qbaSXSQDWPEq6apPXuSvZu8LLylFeclFJvBZB/wppWdfizeT+eccn5S
   WMJUlWiB7Hj0yfP3hT+vqOEzfG3h0w9j16gf4vYPMhL8cNOgrzbOLZI5L
   P8sIlawvRMm4H3TiMSNhb4Qf1KWv71+k3SyJS8w6baLPx+EYAExq6w2H2
   w==;
X-CSE-ConnectionGUID: Lol2xhf5QSabLoAV2TZrXw==
X-CSE-MsgGUID: SfmW1dvsTP2I//PP3nSoXg==
X-IronPort-AV: E=Sophos;i="6.21,270,1763395200"; 
   d="scan'208";a="139197161"
Received: from mail-westusazon11010053.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.53])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Feb 2026 22:23:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLS2idER7Ub9wio/VMs/2FIxMoz252F/LHT+dhyDM0Jzk2T4b47vJriRjPEr98A0bawrrwizW7I6397xhhSUKUKX287PX1R20c2f4RdbvrX0bcbbL365gQrISeLb4E+cbvoM/pON8kjLUoalKSEX3Cjjq4BowCSi5WEK/kFgD0MnsqPAnaLv73KnAgYsuCXxVYnQ/gVHUoT8/btSD0ahB8Bf9cjMWG+KCQyUNv4atTuIj54Su9deq0cQ0TzUsvxX6aU2l7Z3M3y8KnU8WAJZr6USF3mReDiWmmu4AmYX8cKBcVD6ttSJi+seHMsWe3/4IaJgIqboOkYSreVzLL67lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8RVRADJNef59zL0HVDZx2ewxJeXIFYTcRmvxsAzaBo=;
 b=jL9qXFdoeuO3+vZ0sKRFDd2+/I3eG4I/IpeVfMpZnm+3904tZlajyTWDEUINPXKTFBl4y8093sCSZpoeyAyBFXk1vYYOBCDAuxNtQeWjU3NwFAAg8y43Z+tf8WK3vF90UK36xif8uNmluH2O7bQEY2+hot8Zh8wV1rqvzAmktBHySod2O7RK3X1aPV6HYlz3LlJbz3WnvmC1N1flrZu/byWtC9aNeJur6xxwPXqQwPYhgiOsndYVFARenZjVqSZ8erEku46RbTAcXXExPzC0R3y159o/bIRketv1rKfxkslRXCEsq23Qd4RwpOW1RmRaEp8jJE/NAVKB9S0VLZcuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8RVRADJNef59zL0HVDZx2ewxJeXIFYTcRmvxsAzaBo=;
 b=FF+FQ9yYWk61ED8E+TjdoB5IwvLs4Zz+llmkixoYi7ZYDUbIqhWijN/HUOvNiHgZB8Sdl3h4b/kIISPitVtq9RgoIR5xCdKpgWHCMBlkDHOyuDbUjuKHrYRqpp7305BXHJ8w+Zyk31TOrfZfpTKUgD2iK1BsosHI3SrDu2xXZ+I=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SN7PR04MB8673.namprd04.prod.outlook.com (2603:10b6:806:2ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 14:23:26 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 14:23:25 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: pass boolean literals as the last argument to
 inc_block_group_ro()
Thread-Topic: [PATCH] btrfs: pass boolean literals as the last argument to
 inc_block_group_ro()
Thread-Index: AQHclQ33m2FUFgniC066CkT78IYHZ7VxBzSA
Date: Tue, 3 Feb 2026 14:23:25 +0000
Message-ID: <38bfdfa6-5a1e-4edb-90b1-a179727ffa96@wdc.com>
References:
 <9d3d4dbe2624d72d34e3a7012caab2a26a3a6521.1770123608.git.fdmanana@suse.com>
In-Reply-To:
 <9d3d4dbe2624d72d34e3a7012caab2a26a3a6521.1770123608.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SN7PR04MB8673:EE_
x-ms-office365-filtering-correlation-id: 3acadfb2-f79f-4b45-03a8-08de632fcb39
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkxpOHIzaEdnSHpuQy9PeDZLU0piT2FLSjhVZzFDR2UzWDIvRTM5WXBuWURt?=
 =?utf-8?B?SUdtMERNbkdOWEFvdjhzZFdzdUY3R2JCb2pmNno4WEdscEpWSHg0U2NrUVJY?=
 =?utf-8?B?UThRam5nNjNod28zaDl2clAvTGRKZHFKZmUxQ1QzU054NExIcFg1OC9aRW83?=
 =?utf-8?B?NmVUVnI5b1VGY1NiZEFGY0ZpaW50SU9iM0NGZ20yN2ptR0crRHdJWE5PZHc0?=
 =?utf-8?B?QkkrS25ldmloRmMybUYzbWl0QjFuZExPSndQSWtxVjBZaGw4WHJpcUZUK2w3?=
 =?utf-8?B?cWN0L3dDVmxuUFNvR2YyYUtkNW45SkE0N0xUSGQxVUhlT0plQ2ZhREQ4V24y?=
 =?utf-8?B?aTNaeCtCT3A3R2tMT1VtVERXWUxQNjI0dnFiVkxxQ0ZEWFpyTWpaaDB2dno1?=
 =?utf-8?B?R1poa2JHRUdlYUZNSml0THVYVCtvbVBiUlp5RGJMT1NraGVVczFuK0NiMENU?=
 =?utf-8?B?K2JydzlOZmI0dHcveHlrYVgvWm1JMlRxbmZSUmd2elRhUU1GSzc5Yzg1NHBo?=
 =?utf-8?B?dmZYTGxndDFGY0F5Y2YxZlJpWDgyYk1yUmJlKzJIbGNEOXFtdW5sV2ZKUFNs?=
 =?utf-8?B?L3lWWDhwbi94dnJ6NVlPcDBYMGZaUXk5ZWlTZ1d5cW1oeXpnblcvRFZyTUd3?=
 =?utf-8?B?RW8yMkNOcVlGbWtpUlVERXRwVG9oeThTMStBZFZvN2lxc29pSFJCZG1ZVkpz?=
 =?utf-8?B?NWFRdmZZWjlGSXJwOWpLT0FRc20wZEdoS0pZclI4R3UzdGZKbXl3YXRaclRi?=
 =?utf-8?B?VE1pRDVpYkJJbHhDK2tJMVEwRFc4UTdsNmtBV1VaWkg1dUJ0NXRFaU9aOU9l?=
 =?utf-8?B?d09XWEZXb3BQMno1WThVeWlZdmtLUUFQQzk2WXlqZEpTZlVwQTlFb2dpY0Fw?=
 =?utf-8?B?cDZKanMyTldlQkRZYWx4WUk5U3VIbHNNS0Z2Q25heHB0dGxGYXlaaG1DZlFO?=
 =?utf-8?B?VEQyVUp2QzVyc2JpcXU2ZElJVXpySXZST0oxQ2VENVNCZkZUUlJGVnhhN0Uz?=
 =?utf-8?B?NG5FU2lhYWJvNEpuNExJNG00cTlWbzZFTWZvTnR6UjlVVVpkbDhydThyTU5G?=
 =?utf-8?B?TTVudm9qUTZrQ0pjL3c5VUdXT0JzVGV4TE5WTDk1WjdjNnBSWDhiM3BRcnVn?=
 =?utf-8?B?MGhubVEyRytPSVVCSkg4aWpnNnNEMmdTUGpWc29GN1JDT0pFNGYvSlc2ZHhB?=
 =?utf-8?B?dzhYdzBaTVhDR3M1RlQ3NXo3dHFoMlZwS093WnExbVdWTytUS2xMT1c1a2lW?=
 =?utf-8?B?VmY1MFJLeER0OTYxZUVhMzU4ZytRb3VPVjUwQnZkU2hIcWlVTHRlVGptbTJm?=
 =?utf-8?B?MVl1T1hNbUhlckgwdlg0NWI1eEZvYkU3RktJbytGdTYybk12QWRiZ3p5TVZa?=
 =?utf-8?B?Vjl4R0hoUkFoSFdzdEloVG84RlFwcnlBV3Fma1g1aVUwVzA3c0tOVkNQa1RI?=
 =?utf-8?B?VWlibm5TTEd5aUJzSzE5elBuWnBMQWR1NWdRM3ZDR1k2TEVkalpNYi9xdXk0?=
 =?utf-8?B?TytVWXJ0RlhONjk0RXFCb0JRVGsrN3BjalczSzdOcTdoWG1JQjlQVHNkOFlj?=
 =?utf-8?B?YjRnK05LYXhlNHhiQW1mOVJ2WGFrN3RlcDBtTkplZEJQV1hlSm92dms5M2V6?=
 =?utf-8?B?TmgrN3F1Zml4RTBwZnhFNjJWUi9BZ1Y2bjRkcmFnQjNnVWtUMTBKc0JaY3F3?=
 =?utf-8?B?QkxibzRTVEZtSkNOaTF0eFFWdUNYbEN0ZjZ4Z0hQVzNXMUFqbGI2a3NaWWxL?=
 =?utf-8?B?L2FJTzZIQldTMlJwbk0vNmFINDRnVnp3anR1T1dGYjdXdzBQREREZTNXZ21R?=
 =?utf-8?B?VDFUdUhleXJSMEpsTVNYTFI2Y0piR0NOSHFHUWJVNVJ1Y2dhS0VKczBPWTF5?=
 =?utf-8?B?TlVENUN6TVNScFo1aHJodUlrVnRWam00UFNNdUFzb3lzWnJjb2NVMTFPYm9U?=
 =?utf-8?B?cmNBcnA4WStuZVZFWlZtem84MUJXbGdpZ2NaTW8ySmY0MldGbnM0cnRoNDVU?=
 =?utf-8?B?b1R2TW1wY0k2em1vV3VhY0UvMklrT1EwMGV1R0IweS8rT3BWYjBTTGlvWnVu?=
 =?utf-8?B?b0VFc0E5OWErV0lBaHBUU0Y4WWgxMmlmcEhPUExaeWIwUmF5clZxQ25Vb29z?=
 =?utf-8?B?dDFzcjlUalpzTnFramJXMUxwSVBGdHhkYldvNWlqUkV6OEZVa292aHdPUVdE?=
 =?utf-8?Q?HUZrA1+uCeslXXP+7NYPSJg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFc3T0VEQzVFRFUrZk8zb2YwYUY0Mmp0V1dCVXI4aTE4dUhvYmU0RXRWSHVu?=
 =?utf-8?B?Z2t0alB5SXVIVzdtRFZWekcyMHRLR3ltZ1RvYlRnVDNOUGdrL2NueUYyeDE0?=
 =?utf-8?B?Qm1TektLaElQRjRabWdMR2ZML0lOdTZVMTF1YlJKZm9uR1o3M2ZKcVlURUtT?=
 =?utf-8?B?bEVaNGcxUkRFc21SVkozUTJRNzIyanVFM0UvT0p4QVRDWVViMHJwdllYbkIx?=
 =?utf-8?B?WFRnZUZUSmVPNFNoTi9SaVg2YjZZOUlJMUlZWWZWZjBudkgvTS9KVGFHdStp?=
 =?utf-8?B?VmdaQS9ZYWtCcjc4eFVrK0xTdW5SdUNyRmZTRjZwMk4zSU1NVm1Db1BBZTNF?=
 =?utf-8?B?UWR5UkZGaDl4Rk1VSFJiek9RUWJwaVV3RkFVMVdOOVo1OE84SGc5T2ZQOWlC?=
 =?utf-8?B?RkE4WWwxdVhzU1lIOXJ6RTh5NnI2Qm1xbDY2c1RWK09JTkVLbmwvNzdBcU90?=
 =?utf-8?B?ODBhTGhxK0x6SjVEWlR1VE5FS2ZYVitlOUpyUUhUS3pDQ1BlcVYvdWlNM1Jr?=
 =?utf-8?B?Q1pjL3F5bGhxK0pXUC85UVR5TVlWSGJUb0wwRThkalVGcGgrNEhXcEIxcWVn?=
 =?utf-8?B?bDY3cWxnajBJMXFIVHV1S1BMdHkvUGtiZlRrWnFxamRZak43bmZQZlhUQ0d3?=
 =?utf-8?B?M1VPR1JTbVpLZ0NEOE5sZ2x1ZFg5aVh1TjlQZUFNbG5IN1MwZTZFNk9MZW96?=
 =?utf-8?B?Mjd1UXFsekxvY2YvbElDck9zZC84bjNQVWdDT3FkbDY2NXNuY0s3ZVN2MkVE?=
 =?utf-8?B?dDRzejk5QVdyUlFHdEJxQ2lkcVc5bHBYVUhYRklsMVR6c0tCNWl6L0lkZmU5?=
 =?utf-8?B?aEhZdUNOVitUK1hCYWxidGZyWUpleVJrckp2SndzSVV1YnJZUWFlMFkyWkxW?=
 =?utf-8?B?V3Q0QklDaDVyT0VPR2RQSnFrYTVwY1hMUFJJS3ROYlpDQVRmVisrbXFhU3lC?=
 =?utf-8?B?TWNPbFA5ejZGbVlYV2RaWnI0dG5OakZjUzF2UWlON3VoOEFUMmVHaEZnR1hu?=
 =?utf-8?B?TTZNeThmUks4YzRnYXE3ZDROSUh1M2FoZUhVNWU4THIyT012QktJblpLNUNT?=
 =?utf-8?B?M3hEYnhLd1J5UjVJZVJGVkRFbTRvT2dpRGYvWXpoQW1CVENxZEd5QkdzSVpy?=
 =?utf-8?B?Rm1XT24zUnpleUpTL1RLajFETzhGS1VsUjJXQitUdXRRdUZUSWdpdmwyd3pX?=
 =?utf-8?B?OVpDdGNySUF0ZjgvRytIMktnRGxKWWRpZFU1U29sblEzK01ubytranhVdW1Y?=
 =?utf-8?B?ZCt0Z3dvL09vb1VKdUFZUVZDT3FDN2MzSnhsc1F4eDVVdDIraFAzTmZpMzdr?=
 =?utf-8?B?NlM0YkZ0TG1pZHdhRkR0RzZtVzhxQkp6aElWUWpqQkRwa2ppN3BaVjc4cW1I?=
 =?utf-8?B?UzY3cWVnNnFzS21LNWgwV1pRaHhiQ2pWcE4waWJydU9ITXlVajBuWmg5aGNn?=
 =?utf-8?B?enAwcXM3cDhWczcwU0E5dmxCeVkzVkVRUExUMFhCSUdnMzVFdHA4NDBrYXFk?=
 =?utf-8?B?WUVtTjNqVEtCZlJ0VFZxOWZ6YjRwZEROcUZFSnVHR2tDVStEdCtsTlUvRmxs?=
 =?utf-8?B?OGMrZ1hwQmIrZDJWTTBza28vUXdBQVFacXNIcXFaSUtGRUJqRGJreU9oWmx3?=
 =?utf-8?B?Tko2SUpPWUFNSklQZit3Q25BTit3djdtQjBWMzNjZlg2cUhTS2xhRHAyUktL?=
 =?utf-8?B?TjA0QWl1OXRYZExBcC8zeDU4UENOZVNQMnVyWHRHVzh4R0NFN2l2L3laMCs3?=
 =?utf-8?B?L1dHL0tOenBibmJMekJzdDREaXpxb2taVGZVa1ZnSkh1WnoxbElaMUk4OHFB?=
 =?utf-8?B?UmNMWUxTTkV4ZHp3bEdxUVVYemxLaEszUUNvMXJVTmxGQ3lRQm4vMFpNR1lG?=
 =?utf-8?B?MktNREdBaUk5aitFbXA2V3IrRk52aTZhTE4zN3lGc2UzOU1lV0s0UnVJWWZX?=
 =?utf-8?B?VVZSOU5XVUdTaXhFRnZmQkR5TCtzRFZqbVQreHFJd3lzV3FNeDJTcUVZam1s?=
 =?utf-8?B?UzljQS9SdXJJeVNrVmk3ZHA0a25oMG00NE0yUHR6cHJlSzV6NTMzSmNxRWxu?=
 =?utf-8?B?VkRxYW5CK1BkUWVKL2lOVDBLaGxMSTluV0RLYkM4aGhtUjJkcFplUUZYV3Zh?=
 =?utf-8?B?VzFnSEVIRGZlSi9hMHVFUmdQdmUyK29oS3dUVSt3MHExVHRqTXBYNmpMa29k?=
 =?utf-8?B?dzRYMVhSZ055TUFxZDk2WmZPWnRxYXI2WnprNlNwRi91cWd3VTMvZmYrempw?=
 =?utf-8?B?S1N4TEdaRzc4NWlhOFhZRjQ2d2NJMXRoUFRkSWFSRzZtdmNHYjlLK0lmcHZi?=
 =?utf-8?B?dXlYRUVxaDlVbDVXMGNRYUZGbTI3NExvR1VaTVMxc1QvSVJUb1ptYVMxL09P?=
 =?utf-8?Q?V8c/AytRJ9QUEH8QyZUeuZp4P8nvGYg9dG29HFcichRyj?=
x-ms-exchange-antispam-messagedata-1: HqzsaKp1s58tpyKKQislSqkwSfBAgqvf0GE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92AA9CBE10FC404FBCC3525C3962B9B8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h8xQZGYy9xhYd3AePwRLnUQS658z1JSQcv8VVG22D4kOfbDNG7IeGIqingR+yLQrFf8N+VXuIeYWJp80yvnVQROJu9VCF/oKRAnUvXaKg4Uz6TxK0XOb7oiBrV6Ip1uwBoriHf2mnYIMJLp8yZOsJkxAKuZlrIr1uG+iKfrmMhOYRaRcbBC++jg2MZJNkzUKXIAfRhUg61dffr16d3xbDIs+DiYczgEzp6t5w0qKHbRQS/J7hiOlQnNiabY0RMBsYGxc1bMvz+33YPStAOm+8EFhjUw7Qzu3vosM1YTW8U1/Xr/8ld0arrkjdRE/P/emHR32YnG1is4fAOlQL93aox06Sr5t0L7OH9hqX1fQ++j82IjqU3whmg9BI0Wj9ojjihayNw0PQWtASTI2bZul0uPFpMwt5M7HI6ty4l5p11o6sFlDfp9E77+BzyVkstsTb3ruxS3ILoawl8UEB/xAGC+mFgmOMXA8nEpgbLzXN61J2iKtrFrKdwMW7GEvSMp7K0vWZb7/TJ5I/VLd0yy1jfqdSG2hKU9X4IL0r+foVVxEwe3jhdixfB2vRpoOVAF5KXoWwQ+4dIf8mMYaXH24iISa2wQA82aE4p5Vu7qysLX2V6C+IJGGyPZps4Gyt4yV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acadfb2-f79f-4b45-03a8-08de632fcb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 14:23:25.6781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYBZxf5Ip4VAgi3k00aU0+ceaJJ/9R9f1yStcHqdd9/B38/6Iwg/fUyueF9QOUg6/bF8Un7ISXySXTdyuHg0yT9sApaDYEhX7REaX8AQEN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8673
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21318-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_MIXED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 624C5DA98A
X-Rspamd-Action: no action

U2ltcGxlIGVub3VnaA0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0K


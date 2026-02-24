Return-Path: <linux-btrfs+bounces-21863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N/dNPVMnWmhOQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21863-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 08:02:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E861182B0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 08:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9F0C3010628
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9B53093D8;
	Tue, 24 Feb 2026 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jvdb9Q3g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ue9G5Dig"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC4127BF93
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916529; cv=fail; b=AKnbLnzQWok2nIbbzszSmBei1O4sR3w4k9wzR79S1MktlJhseGH9DTOZSQvtH5BMFg5pnX7aAkYciP+oa/ypYv6YEa71mukx9ERLs4pRzDJt6U3IWrazqranyMXj6hQfTTWDE3p3tTYac3LawUTs53GqrQ54A/lPBU53F1/ZINM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916529; c=relaxed/simple;
	bh=C2ZuZEPvay/V6sCbbkEO/UPVfGgmVeL+xPKFqgJuI5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lSIDJESTuDnvidQwj15kIqTV3SUM5H1rkus/TzWMfyUrt/7KJylbPyC1Q46eiF29lqE5yaxZWJIUXKlLz5CqGaTPeSEHLM5F5qAiZxB/8U+JmETH2xgKCQWA1cLFPq5YkOHuSOttHsarnyuJQVQfbJ+WKHJOVJ1AkgGSyX61UJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jvdb9Q3g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ue9G5Dig; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771916527; x=1803452527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C2ZuZEPvay/V6sCbbkEO/UPVfGgmVeL+xPKFqgJuI5U=;
  b=jvdb9Q3g1eJPk2HCUJocfNClOP1XBdtFYULXEJSwhudxwZPKQyD/DAOu
   0wrVNhVqeE9QHE/zGI+LJjw0E2cn2AYXHZVRF1NpoSWIlvu6z93vdfQ1C
   z50JxBphJ1RDkXQljOHZSVR83VXl9lEyohpgQngPeXuNMgu7TjDNJvLDL
   jWGKlzYu74LPl0YZfXZa41B7pkJdRIJGF1Z824Oet+mrx8wQjuakVdWw6
   VmhyYAHCixsR3EZrLyx/9rmpJUuNhTpn3l4Se2wa3BLVFWQfcpLOjozuP
   JMmR7wwNx/TNDDXYkP1qZ59tbOoHM8G58HThajLaTwnvsTpPkgnyM8ZLE
   g==;
X-CSE-ConnectionGUID: 70yR9izWTWeYV81z4uaESQ==
X-CSE-MsgGUID: 2ubdlpo5SsOyZ7XyPOIfyQ==
X-IronPort-AV: E=Sophos;i="6.21,308,1763395200"; 
   d="scan'208";a="141855131"
Received: from mail-westus2azon11012021.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.21])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2026 15:02:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0aSNXplzFCNJvt++4Cfw7v+zI7BS074sdbd84g4pmQfFL/i0PnW1dySIz4B9bRzavAr4PO1+D615YRSll2F89eU385rijpFl8Gv0dweDQkbL5bliFb2qOFmguvP1u6zE5rxINA6D0cGO5kXEC1Qvf+XD/ZWzuFejDb4ZK4mXLQb0pz1i8+KYBq552RO8KGt8Bj1OV8kQ+4UGPIOwtnmXYIyMs5lxBPkHPdfQFOk6BgHeKaXcgSoRg4MA5uy34iEroxPhjvqpxCSkyMFucp1jBb3bhGSzXMt5WiSGo02W/zEnPKuhtd/rrUcATWunHL4oGjoNRx4XRlHNB2pJ46yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2ZuZEPvay/V6sCbbkEO/UPVfGgmVeL+xPKFqgJuI5U=;
 b=qlRAVDq5I0gJCz7OtASO6nVjCqp1B9doohquV2xLk0vuK7qw9doPB9dNTunkt3thSGwrfxb1q9bc2jbBl8yzxZ9qFBnCjw4g9lB4CEy6ba3N9RxvrVPQ0WHPX8Mb25m4lHYC7PA3+Ju0HrNxbuucFEW6ItK3VbfdV5L4cZDQrL4X5GTVa8uGNkB6+n2rn8cdU7a8rpW8gZXr862BYjV6Oh06Ldvq10aOXTZ11G7QFA3FCuuC0nwOO+N5P8P64eVN81CCv8hoeGzlxGqjstL+95Z/TRuwBXcG5fnd1Uejkk2F2jR85Pke/WmXEtHp1kO+8H2N0zBPunlRwboVurAuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2ZuZEPvay/V6sCbbkEO/UPVfGgmVeL+xPKFqgJuI5U=;
 b=Ue9G5Dig8q/pGZJpIdSm5U2oVxMVuirHdvgv4rSzHcWGNHx/px6xzKmhCyPfsu10duAAL0PmcLvn+a8FJfDYTEdFElWak/DiB+H4IumTwvCsMNcofisrsZ10wIsgOIOcCCEeashW6wCyF1q9zJsx+RffLCBOSTBva0hyFDoHR3E=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by PH0PR04MB7786.namprd04.prod.outlook.com (2603:10b6:510:ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Tue, 24 Feb
 2026 07:01:59 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a%5]) with mapi id 15.20.9654.007; Tue, 24 Feb 2026
 07:01:59 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Jorge Bastos <jorge.mrbastos@gmail.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>
CC: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs with zoned devices
Thread-Topic: Btrfs with zoned devices
Thread-Index: AQHcpNT4Ep2H6rXPnU2eCVJ0EiHTsrWQZNOAgAANZ4CAAPrQgA==
Date: Tue, 24 Feb 2026 07:01:59 +0000
Message-ID: <DGMZYSH7JG2W.1DBICE2W4XI3X@wdc.com>
References:
 <CAHzMYBSfK7Ms9W9rc1mzsyP0aRkXg=3G6VXuur15jm7OE2JoCA@mail.gmail.com>
 <6e46e258-4589-4cb8-8548-036ad36884b5@wdc.com>
 <CAHzMYBSCtpHamhBCCgPf4WNDmY5-DOdnXJ8NMLf4C-CLL09oiA@mail.gmail.com>
In-Reply-To:
 <CAHzMYBSCtpHamhBCCgPf4WNDmY5-DOdnXJ8NMLf4C-CLL09oiA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|PH0PR04MB7786:EE_
x-ms-office365-filtering-correlation-id: 15a2d263-202e-4593-3f05-08de73729a9d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0YyeFlEZW03VzBsSFh0alNKMHFXdUxxRlZiVms5VUh0RUY2eUFEZTI3ZGM4?=
 =?utf-8?B?WHExUmRXNG5VMFFzQXVTN0dLek5vN2tEeTBLRFhZb2QzVTladkxURjgwcmxK?=
 =?utf-8?B?aFdxWWxLUmlXVy96cFI4MGZjZndacktEekY5R0llMy81ZGRxWTZRV0doYUQ0?=
 =?utf-8?B?eFhqVk9SaGtVdkRTdkxvNGRITVB3VHVBUjlLRW5MN3VQd3A4UTV0OWEzQU5j?=
 =?utf-8?B?OUVybmw1RXc1NkpvVGs0VkVpa3ByZG9hbThvMUZxd0h2cmZHVVNrbU0wYXJ6?=
 =?utf-8?B?OWdXUXBuYnVFYjVUNmZ4OXFGcXNrZGZ4UHhSbjdxbVowU3gxQk16eFBMSjRX?=
 =?utf-8?B?VG1EU0l4Q1VKNGZwM1RJczdreE4zajFWWk9pbHh3MlhYRnoxL2tEUjhpSE8r?=
 =?utf-8?B?ZEk2S2l6emZnZW1xSmRsbEhqb2lTdUxEM25Ud2xTeFJhM3Y2ek81VUJTY0x1?=
 =?utf-8?B?R0JkeEN5SEQwR2ZhNlFka2ZhN2p2VGNNcXBiK2ZYakUzcFljM3dwQ1ZMQmxv?=
 =?utf-8?B?KzI3Q2sxckJnT2Vpd21WOUlGOFgyT3lIcjBHRmdaZ2RZQ0p4eVdSV0lNSEdF?=
 =?utf-8?B?dkozNXFGOVlPRXRPOUhOdXFvMlovaHczUzNPZnU1cHZVNDd4UXBLa0NLSVY0?=
 =?utf-8?B?ZldWRW5pOEtLYUF6WGFzdDJGQzRhc0xqZ0Qyb2IxVW9XNWZhc0dacDRQVGZj?=
 =?utf-8?B?NUQ5dXNCbUpWcjI0NlRVeHNiUXQvcFdpN3krV0hSYS9XV1NYN3V5b3NMbWto?=
 =?utf-8?B?Z3d0UTZjTUkwWHVDWFlWVUIzNnc4TEk3NlVkR05IQzdWK0t1V1h0dGQvZDdQ?=
 =?utf-8?B?U2puaktvS25xSWgvNFBuc0pSWUYrODE5U2lJQXVvMm5NQktnL1FQbGhYZnJq?=
 =?utf-8?B?QWprTmlpRXJYSlo3S2tPYW5ZQVZFQWlROFA5Zzg4bC9IOVlaWmtnTmk4T3ZR?=
 =?utf-8?B?V0VvTHorUmd2SjBPYUpPWGJUaVhxTThzMGJSRWpaRmxuem1lVFNVbVFrZGVX?=
 =?utf-8?B?WXdUbm8rbzNPdE9VL0l6ekhpMVpKdDhpYTRnK0t5WFAxRUtMUy9LcmZTVWNJ?=
 =?utf-8?B?MDNIOUtSRVRCVDBqSmlaZkRBbUhlSHRNQzN6dzllRGppTjVpUWg2ZW8xTS9s?=
 =?utf-8?B?TWM4cCtkZDNjallicDdwZG91cnNNWWtDWVl5cWU0L0ZVR0lUWHp5Wkx0RC84?=
 =?utf-8?B?cU14NC9mRHJ6eTJWNTRCUHBqWmhUaWhuZkxtcENrVEpnQTNoamhSbzhoYkpO?=
 =?utf-8?B?ZzZOR2FSVVhSaFpTdW9rbURIUTBqOWp5WVVRN01CRmU1N0xDSkxRb1cxTHdI?=
 =?utf-8?B?ZXAyR252SzlTRlZFSm9walJsM1pmKzhWSko2RkZvSXF4OFBzR3dIQnZxSWEw?=
 =?utf-8?B?Y0JOblBmS0NNV1dFRmFvT2ppKy9UMGhIL0ZuTWxBQU9hT1pXYnZGYjRPMndP?=
 =?utf-8?B?SURzOGtyTXJLRG1ETWNaQWVJc05qOHc0aTZZVEFnRHJIWDZJbE43cE1tUFVs?=
 =?utf-8?B?bXFqblNmYUVQdE9ybWlUSlNWdGREOTZRMEN1dmh2T1EyQVJmY003NUR3Mksv?=
 =?utf-8?B?Z2hJMmttUnNEZk5aRTBaZ1ZJbFBVYzkya2ZJYjFsVUIxVDN5aVRFNzUwZ2p5?=
 =?utf-8?B?ZVBnU2p6NjdmZ3E4WTVJL1NzVDZoSWY3QUxUVU9qaVZwY1BVcWZleUdMczBY?=
 =?utf-8?B?bWRvWUxvbWZOdmVNcFNYUGYyRmhMcVBQK0FDSzlkRlhrZTlraVErNlVGWTl3?=
 =?utf-8?B?N2F5RVd6bG91eTVWcFBUYzIxaGxrMW82NTVKekZJSlZzeTNBaUpMR1p3b1FI?=
 =?utf-8?B?ZHFuTEZVWm13aUdZOFpTSXRKL05Na0xEUTY0MlZVZWVPVy90UG1HZ1BQKzR2?=
 =?utf-8?B?WHpMcDhsUlF6OVpQRTJwanorSzl0a0xWdGZYVVp4eHJyOWp5UVp6eG9Icnl4?=
 =?utf-8?B?aDE4WHpiaGZsdDdnT0VVMnJES1VOOFlSYzBqU0hXY2VUVW1wcnIzRmxxa0Vn?=
 =?utf-8?B?bGdKWEsraENWNnBpK3FNV2Y0ajB4SlRSMTc0bDRRT3ZidFdEL2t6cFVUMFNl?=
 =?utf-8?B?MkhSZTMrMGdwZzB5R2h2OXkyZGlDRHUwdHdML29LUU40N3p6N0NBYkd1TGlZ?=
 =?utf-8?B?MytpTDE0aDlIenN6WnZvNFN4QjhFSTVCT2J1TVcxZUg2RGlwMnBoR0duZkpQ?=
 =?utf-8?Q?kuCTaLSn1hUpE3qjkK6JXus=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REdlK2NwL1JybGwxSnNKejJoNnVCYXROVlNMMDF2SDV1M3djdXlOUmRkVDdD?=
 =?utf-8?B?MG96WWo3S2cwSU52OUc4TjBoa1ZibGtXM2RJYjJwR05VbS9rbkc3Vlg3LzNH?=
 =?utf-8?B?a3lEem8xZDZBeEJ5b0NUaTkzUDFCWjFuVjdYVlhLVlcvVy9aRmY5UkY3VjVH?=
 =?utf-8?B?SE1Hd2FiSHMxQW9QMVczMkUycWZIQU12MUh4MnRRbGJnZFVRcTgrR0FsZm5U?=
 =?utf-8?B?TVFhRjdJSWJJYWxMaG5kUEJWYU1LKzcxVklCNEpJWWNUcG42dGdSaVFqdDZ5?=
 =?utf-8?B?cWhrQmcxVzZtbmxGVWM5aHVtNUVoOG4rcC8vbW5LV1JxN1hPN1RWKzFaTVhv?=
 =?utf-8?B?S1dYelo5TmVzdlJQd1FwaFg1UndJOFF4L1EyZXhsdnFsbXZIYnF1SXBxbml6?=
 =?utf-8?B?eFFzTHNMTG1SUEw5R1hIc29OZm41UUw2TzRFdUUybkJLTE9kUFg1Q1g5WjZ1?=
 =?utf-8?B?dFBMMFNxQjVzcDlZWkpNaW1wLzR4bW0zNHBtRklwQU5tYWtwRUhZeFRRSStJ?=
 =?utf-8?B?ZmhjbkkreEtZemk4WWRpdmRIUEw0RUI0TWloaVplNWkwdkVvNmFHYWZrdTA1?=
 =?utf-8?B?czA0UU5uRkJpakkzVUJDdkpHZjVIY2V3dnRCTmR6aHJvZXJLUVNzNTFGU1lt?=
 =?utf-8?B?bHN3aE1xdlU1bEVlL25ubXEwdFVqOGtrMG9BSFpkeFZ4MkFaa2tMYmlVTGNR?=
 =?utf-8?B?Rm9EdlBmTFZoN2QyeFhXcVBzRS82Sy9oQWtkYTdUeU1sb3g5emdDb0xqKzJv?=
 =?utf-8?B?MXl3Tzc4N3NJWXR0bm9US1NIdnZsV0w0V1R1U0hydFZMQmcrN3BJMDFyT1hY?=
 =?utf-8?B?cWR2S2FudUNoV0d2MzVqWU44N2dFNUdvbXR2dnBOMFBCcmFvSFgzN1lPZ3pI?=
 =?utf-8?B?akRFRFMzTXlpb2NlOTdteTNiZTI5c1poU1FIemZPTkFoaXllMk5lYWREa0Jw?=
 =?utf-8?B?YUdrbm9sM3JUbGYrQTJmRDZsei80WmdkeXRDYkVFaysxN1hwUEM1NDFCQmJx?=
 =?utf-8?B?YzgzV21nVlZlWTlDSVhzbHMvQ01hNEtwem53a3pDT04vU0NjMys1LzhVelBx?=
 =?utf-8?B?Sk5DVXVpaWpjZU9Lc256UFpTTTFITTJZSkpzVDFKZ3ljenUxNGlPRTBaVXVJ?=
 =?utf-8?B?ejhpdytXNmJCdHNXSlNTanJ5MGFZSThCaVRFSHJCWjROaEVkb0ZRY2F3ZU8y?=
 =?utf-8?B?NW9obmxzeHY4L2phemJnSUQ1VkdZY004eHMzaWZ2V2dPbXRPT0VIYkdNcGU0?=
 =?utf-8?B?TlMwTTZ1T3hNNmYxZEovb2MwMytSL3VyTllPSFZTK0NtNTZYU1FwNmhIVktq?=
 =?utf-8?B?OGpQaEcyam43WER2aERPZ28xd0hUQjhRd2xaSTdQTlFDNU9pdDZJR2VvajFj?=
 =?utf-8?B?QUFuNENLR1VlWnB1QVdEZUxnSzNUSGFTTlVGT2lYUzByZ1lLRU9XQkhsSGRq?=
 =?utf-8?B?cHNvbkRneXBXMTBkUnpVek0wd2RMMmoxa0d5RVNPNGkxZFN2MDVZWFYzeUhT?=
 =?utf-8?B?dkcrRCtuZk8rYktkaFQ1WjNKWXBZSnRWTWhNTGRJVmxEeFVCa1FsNjhPaWdS?=
 =?utf-8?B?dlFGeEJDWEtZUk9WSEloTzlrMW9XN1dES0lEYVptcTVJeS9DdTNYRnZ2Q1FY?=
 =?utf-8?B?S2NyTU9jaTNWMkxMWmxDYnd6SWorWVVaWmp1UUhoa3hFZ05aRW9HbkhHd0FF?=
 =?utf-8?B?TW9VYThtRmY5Si9jME43QWZOTkMvQVpMY05ndmQwZzNXNEVUWHNjdndPNWpv?=
 =?utf-8?B?WGVIQm5RcFpRWURKQmpyRG03V21pMEptTDNLbkw4Y21mYnJWa08rWFRNMVE2?=
 =?utf-8?B?dlJXWUZHK0dIeXdVTHhEaG12Yi9CTC80NXlCOThHTit5QXhnOXU2WEdQYVRR?=
 =?utf-8?B?QlRncmw1MXltdmdFNTNWdjVOMFZpRUZzdEVJNzdqczh3dGV1OFN2M2RWNkZO?=
 =?utf-8?B?WnhyVWtqcy9pN1ZEVURMenBlVUYxZUd2bUpobytJUHRMS2dDbVE5WW1WUFh6?=
 =?utf-8?B?ZkRpZkJSbGlYRW8rcDAyeVY4ZzlVRnZibXdtTUFWR3o3OHVGbmZPUkxVamhK?=
 =?utf-8?B?S2FJODVEbWdMQjVDY0I3ZHNRYVdJQTAyUVZOWm1ZV0JLVG1GT3RUNGZzRVl3?=
 =?utf-8?B?eWJQc2pRNW8remdnUnA3a1NFdGJMYU5Pd2c0Y1NtdlcrZFVxZkFXWVdpaG80?=
 =?utf-8?B?Ykl5aGE5T2lVSHpzcTNiK0VDZjA5Z2hHSUF2bWRJME9oV2ZyYkZHY1JJWUhx?=
 =?utf-8?B?WnhEQmtLbjVHazNJakFNL3h5NzFiWW5xbktXMkI1Y3Z0QnZLL2F0MkpabWZQ?=
 =?utf-8?B?OCtSSGVTTFFodFJIYWgzKzFlQkFNL1BZeVVBNkJ3TUI2a3lDS3VBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B02755342C39F45B6F273CDF17469A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1D6MLFfHkH6gue1KOfWm41QTPUw6zqg1j97js3MBYWAWwQ8f9qNAzHF0TRWNYxn8M1/UDAfE2juZ4BSfN5pbFLPckmdZcHZnvqiNrcR7FXOnbYia8nuLJ4biUmb8NapV9oCD/+1N2O5HfUXI/bYw0aw6/GkKp87k6Pje2/XxZMAPuL58ETJYf9ErsXkCw4VzV+C0VSX/z6E/ZHQtGntg0pghC6TyFamwaLD8zDb7XpuQZbeJMihXgpYSKt33RlLcZsAAPCSIsYAWqodNtoJ5u34lU0HsBl8yZbHrGkUh/kA3z4CswqwktypQlOGiG2bZcSGu63w74KIHmL9W1DCTbqYwHPPKGIvbPdqUES40n5VMbnOCe7RV9fpPSg0a0cqUx9OKxijJGtezNo+HC+LqisfaJmz6eh7ablaRRtFmYvYaD+JECJogQ5O9UH4S1n07Uvb8RIZWwBcv+JkN39zKo6WMgzw70LpDBCJaii+MN+IQksXvXDbsZFH7Vk6YTdFdWtvRYbRbK5Znwstx1fJA2rYhUJ1hFZA27ZKm44Q2sF3X7Ko+75VAwnBThG1ceWPcs91LCFqEa5s2+eVAQYosXckSBFKCA4Q+JSPCrSCWRp2yDzcUDmA7stLQGYoKrvlX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a2d263-202e-4593-3f05-08de73729a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 07:01:59.0428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spd8QaHBokSS+7VnepS89YYQDjQpC4/ocgD4BWbEGMBZxP0se/wT9ZX7lARyTpckYxREG8+/UEe3DEt4nM0+rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7786
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21863-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_MIXED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,wdc.com];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Naohiro.Aota@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:mid,wdc.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 7E861182B0D
X-Rspamd-Action: no action

T24gVHVlIEZlYiAyNCwgMjAyNiBhdCAxOjAzIEFNIEpTVCwgSm9yZ2UgQmFzdG9zIHdyb3RlOg0K
PiBUaGFua3MgZm9yIHRoZSByZXBseSwgSSdtIGFmcmFpZCBJJ20gdXNpbmcgYSBidWlsdCBrZXJu
ZWwsIGFuZA0KPiBidWlsZGluZyBteSBvd24gd2l0aCBkZWJ1ZyBpbmZvIGlzIGJleW9uZCBteSBr
bm93bGVkZ2UuDQo+DQo+IEdlbWluaSBiZWxpZXZlcyB0aGUgaXNzdWUgbWF5IGJlIGNhdXNlZCBi
eSB0b28gbWFueSBvcGVuIHpvbmVzLiBJJ3ZlDQo+IG1vbml0b3JlZCBibGt6b25lIHJlcG9ydCBv
dXRwdXQsIGFuZCB0aGVyZSBhcmUgdHlwaWNhbGx5ID4xMDAgem9uZXMgaW4NCj4gdGhlICdJbXBs
aWNpdGx5IE9wZW4nIG9yICdFeHBsaWNpdGx5IE9wZW4nIHN0YXRlLCBhbmQgSSd2ZSBzZWVuIGl0
IGdvDQo+IG92ZXIgMTIwIGJlZm9yZS4NCj4NCj4gSSBjaGVja2VkIHRoZSBxdWV1ZSBsaW1pdHMg
Zm9yIHRoZSBkZXZpY2UgYW5kDQo+IC9zeXMvYmxvY2svc2RiL3F1ZXVlL21heF9hY3RpdmVfem9u
ZXMgcmVwb3J0cyAwDQo+IGJ1dA0KPiAvc3lzL2Jsb2NrL3NkYi9xdWV1ZS9tYXhfb3Blbl96b25l
cyByZXBvcnRzIDEyOA0KPg0KPiBDb3VsZCBpdCBiZSB0aGF0IGJ0cmZzIGlzIGhpdHRpbmcgdGhl
IG1heF9vcGVuX3pvbmVzIGxpbWl0IGFuZA0KPiByZWNlaXZpbmcgRUFHQUlOICgtMTEpIGR1cmlu
ZyBidHJmc19jb21taXRfdHJhbnNhY3Rpb24sIHBvc3NpYmx5DQo+IGJlY2F1c2UgaXQgaXNuJ3Qg
c2VsZi1saW1pdGluZyBiYXNlZCBvbiB0aGUgbWF4X29wZW5fem9uZXMgdmFsdWUgd2hlbg0KPiBt
YXhfYWN0aXZlX3pvbmVzIGlzIDAuIg0KDQpOb3QgcmVhbGx5LiBCdHJmcyBub3cgbGltaXRzIGJ5
IG1heF9vcGVuX3pvbmVzIGFzIGJlbG93IGluIHpvbmVkLmMNCg0KCW1heF9hY3RpdmVfem9uZXMg
PSBtaW5fbm90X3plcm8oYmRldl9tYXhfYWN0aXZlX3pvbmVzKGJkZXYpLA0KCQkJCQliZGV2X21h
eF9vcGVuX3pvbmVzKGJkZXYpKTsNCg0KQW5kLCBFQUdBSU4gYmFzaWNhbGx5IHNob3VsZCBiZSBj
b21pbmcgZnJvbQ0KYnRyZnNfY2hlY2tfbWV0YV93cml0ZV9wb2ludGVyKCkgd2hlbiB0aGVyZSBp
cyBhIGhvbGUgaW4gYSB3cml0aW5nDQpyZWdpb24uIFVzdWFsbHkgYXQgdGhlIHRyYW5zYWN0aW9u
IGNvbW1pdCBwaGFzZSwgYWxsIG1ldGFkYXRhIGluIHRoZQ0Kd3JpdGluZyByZWdpb24gc2hvdWxk
IGJlIGFsbG9jYXRlZCBhbmQgcmVhZHkgZm9yIHNlcXVlbnRpYWwgd3JpdGluZy4gU28sDQpzb21l
dGhpbmcgd3JvbmcgaGFwcGVucyBoZXJlIGVpdGhlciBtaXMtb3JkZXJpbmcgb3IgbWlzLXNraXBw
aW5nIGENCmJsb2NrLg0KDQo+DQo+IFRoYW5rcywNCj4gSm9yZ2UNCj4NCj4gT24gTW9uLCBGZWIg
MjMsIDIwMjYgYXQgMzoxNeKAr1BNIEpvaGFubmVzIFRodW1zaGlybg0KPiA8Sm9oYW5uZXMuVGh1
bXNoaXJuQHdkYy5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIDIvMjMvMjYgMzo1OSBQTSwgSm9yZ2Ug
QmFzdG9zIHdyb3RlOg0KPj4gPiBIaSwNCj4+ID4NCj4+ID4gSSdtIHVzaW5nIGEgem9uZWQgZGV2
aWNlIGZvciB0aGUgZmlyc3QgdGltZTsgaXQncyBhIDI3VEIgV0QgVWx0cmFzdGFyDQo+PiA+IEhD
NjgwLCBmb3JtYXR0ZWQgd2l0aCBzaW5nbGUgZGF0YSBhbmQgRFVQIG1ldGFkYXRhLg0KPj4gPg0K
Pj4gPiBUaGlzIHdpbGwgYmUgdXNlZCBmb3Igbm9uLWNyaXRpY2FsIFdPUk0gbWVkaWEgZGF0YSwg
YnV0IGR1cmluZyB0aGUNCj4+ID4gaW5pdGlhbCBkYXRhIGxvYWQsIHVzaW5nIGEgc2luZ2xlIHJz
eW5jIHRocmVhZCwgdGhlIGZpbGVzeXN0ZW0gY3Jhc2hlZA0KPj4gPiB0d2ljZSwgMXN0IHRpbWUg
YWZ0ZXIgY29weWluZyBhcm91bmQgMS4yNVQsIDJuZCB0aW1lIGFyb3VuZCAyLjVUDQo+PiA+IHRv
dGFsLg0KPj4gPg0KPj4gPiBJJ20gbm93IHVzaW5nIHNvbWUgbW91bnQgb3B0aW9ucyBzdWdnZXN0
ZWQgYnkgTExNcywgYW5kIGl0IGhhc24ndA0KPj4gPiBjcmFzaGVkIHNvIGZhciwgYnV0IGl0J3Mg
bm90IGJlZW4gbG9uZzsgY3VycmVudGx5IGF0IDMuNThUIHVzZWQuDQo+PiA+DQo+PiA+IG1vdW50
IC1vIHJ3LG5vYXRpbWUsY29tbWl0PTYwLGZsdXNob25jb21taXQsZGlzY2FyZD1hc3luYw0KPj4N
Cj4+IGRpc2NhcmQ9YXN5bmMgZG9lc24ndCBtYWtlIGEgbG90IG9mIHNlbnNlIG9uIHpvbmVkIGFu
ZCBpdCB3aWxsIGJlIGlnbm9yZWQuDQo+Pg0KPj4NCj4+ID4gTXkgcXVlc3Rpb24gaXMsIGFyZSB0
aGVzZSBtb3VudCBvcHRpb25zIGdvb2QgZm9yIEhNLVNNUiBvciBkbyB5b3UNCj4+ID4gcmVjb21t
ZW5kIGRpZmZlcmVudCBvbmVzLCBhbmQgY291bGQgdGhleSBoZWxwIHdpdGggdGhlIGNyYXNoaW5n
Pw0KPj4gPg0KPj4gPg0KPj4gPiBUaGVzZSB3ZXJlIHRoZSBjcmFzaGVzIEkgc2F3LCB0aGV5IGxv
b2sgc2ltaWxhciB0byBtZSwgYW5kIGFmdGVyDQo+PiA+IHVubW91bnRpbmcgYW5kIHJlbW91bnRp
bmcsIGl0IHdvcmtlZCBhZ2FpbjoNCj4+DQo+Pg0KPj4gWWVzIHRoZXNlIGVycm9ycyBhcmUgdHJh
bnNpZW50IChsdWNraWx5KS4NCj4+DQo+Pg0KPj4gPiBLZXJuZWwgNi4xOC45DQo+PiA+IGJ0cmZz
LXByb2dzIHY2LjE3LjENCj4+ID4NCj4+ID4gMXN0IG9uZToNCj4+ID4NCj4+ID4gRmViIDIyIDIx
OjM1OjU2IFRvd2VyNyBrZXJuZWw6IEJUUkZTOiBlcnJvciAoZGV2aWNlIHNkYikgaW4NCj4+ID4g
YnRyZnNfY29tbWl0X3RyYW5zYWN0aW9uOjI1MzY6IGVycm5vPS0xMSB1bmtub3duIChFcnJvciB3
aGlsZSB3cml0aW5nDQo+PiA+IG91dCB0cmFuc2FjdGlvbikNCj4+ID4gRmViIDIyIDIxOjM1OjU2
IFRvd2VyNyBrZXJuZWw6IEJUUkZTIGluZm8gKGRldmljZSBzZGIgc3RhdGUgRSk6IGZvcmNlZCBy
ZWFkb25seQ0KPj4gPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogQlRSRlMgd2Fybmlu
ZyAoZGV2aWNlIHNkYiBzdGF0ZSBFKToNCj4+ID4gU2tpcHBpbmcgY29tbWl0IG9mIGFib3J0ZWQg
dHJhbnNhY3Rpb24uDQo+PiA+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiAtLS0tLS0t
LS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4+ID4gRmViIDIyIDIxOjM1OjU2IFRvd2Vy
NyBrZXJuZWw6IEJUUkZTOiBUcmFuc2FjdGlvbiBhYm9ydGVkIChlcnJvciAtMTEpDQo+PiA+IEZl
YiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBXQVJOSU5HOiBDUFU6IDggUElEOiAxMDk5NDYg
YXQNCj4+ID4gZnMvYnRyZnMvdHJhbnNhY3Rpb24uYzoyMDIxIGJ0cmZzX2NvbW1pdF90cmFuc2Fj
dGlvbisweDk5NC8weGIyMA0KPj4gPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogTW9k
dWxlcyBsaW5rZWQgaW46IG1kX21vZCBicl9uZXRmaWx0ZXINCj4+ID4gbmZ0X2NvbXBhdCBhZl9w
YWNrZXQgdmV0aCBuZl9jb25udHJhY2tfbmV0bGluayB4dF9uYXQgaXB0YWJsZV9yYXcNCj4+ID4g
eHRfY29ubnRyYWNrIGJyaWRnZSBzdHAgbGxjIHhmcm1fdXNlciB4ZnJtX2FsZ28geHRfc2V0IGlw
X3NldA0KPj4gPiB4dF9hZGRydHlwZSB4dF9NQVNRVUVSQURFIHh0X3RjcHVkcCB4dF9tYXJrIHR1
biBuZl90YWJsZXMgbmZuZXRsaW5rDQo+PiA+IGlwNnRhYmxlX25hdCBpcHRhYmxlX25hdCBuZl9u
YXQgbmZfY29ubnRyYWNrIG5mX2RlZnJhZ19pcHY2DQo+PiA+IG5mX2RlZnJhZ19pcHY0IGlwbWlf
ZGV2aW50ZiBpcDZ0YWJsZV9maWx0ZXIgaXA2X3RhYmxlcyBpcHRhYmxlX2ZpbHRlcg0KPj4gPiBp
cF90YWJsZXMgeF90YWJsZXMgbWFjdnRhcCBtYWN2bGFuIHRhcCBtbHg1X2NvcmUgbWx4ZncgdGxz
IGlnYg0KPj4gPiBpbnRlbF9yYXBsX21zciBhbWQ2NF9lZGFjIGVkYWNfbWNlX2FtZCBlZGFjX2Nv
cmUgaW50ZWxfcmFwbF9jb21tb24NCj4+ID4ga3ZtX2FtZCBhc3Qga3ZtIGRybV9zaG1lbV9oZWxw
ZXIgZHJtX2NsaWVudF9saWIgZHJtX2ttc19oZWxwZXINCj4+ID4gaXBtaV9zc2lmIGdoYXNoX2Ns
bXVsbmlfaW50ZWwgYWVzbmlfaW50ZWwgZHJtIHJhcGwgYWNwaV9jcHVmcmVxDQo+PiA+IGJhY2ts
aWdodCBpMmNfYWxnb19iaXQgaW5wdXRfbGVkcyBqb3lkZXYgbGVkX2NsYXNzIGNjcCBpMmNfcGlp
eDQNCj4+ID4gaTJjX3NtYnVzIGFjcGlfaXBtaSBzZXMgZW5jbG9zdXJlIGkyY19jb3JlIGsxMHRl
bXAgaXBtaV9zaSBidXR0b24NCj4+ID4gemZzKFBPKSBzcGwoTykgW2xhc3QgdW5sb2FkZWQ6IG1k
X21vZF0NCj4+ID4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IENQVTogOCBVSUQ6IDAg
UElEOiAxMDk5NDYgQ29tbToNCj4+ID4gYnRyZnMtdHJhbnNhY3RpIFRhaW50ZWQ6IFAgICAgICAg
IFcgIE8gICAgICAgIDYuMTguOS1VbnJhaWQgIzQNCj4+ID4gUFJFRU1QVCh2b2x1bnRhcnkpDQo+
PiA+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBUYWludGVkOiBbUF09UFJPUFJJRVRB
UllfTU9EVUxFLA0KPj4gPiBbV109V0FSTiwgW09dPU9PVF9NT0RVTEUNCj4+ID4gRmViIDIyIDIx
OjM1OjU2IFRvd2VyNyBrZXJuZWw6IEhhcmR3YXJlIG5hbWU6IFN1cGVybWljcm8gU3VwZXINCj4+
ID4gU2VydmVyL0gxMVNTTC1pLCBCSU9TIDIuNCAxMi8yNy8yMDIxDQo+PiA+IEZlYiAyMiAyMToz
NTo1NiBUb3dlcjcga2VybmVsOiBSSVA6IDAwMTA6YnRyZnNfY29tbWl0X3RyYW5zYWN0aW9uKzB4
OTk0LzB4YjIwDQo+PiA+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBDb2RlOiBiYSBm
ZiA0OSA4YiA3YyAyNCA2MCA4OSBkYSA0OCBjNw0KPj4gPiBjNiAyYSA4MSA1NyA4MiBlOCA4MSAx
NCBhOSBmZiBlOCAyYyBlZiBiYSBmZiBlYiAxMCA4OSBkZSA0OCBjNyBjNyA0Yg0KPj4gPiA4MSA1
NyA4MiBlOCA2YyBkNSBiMSBmZiA8MGY+IDBiIDQxIGIwIDAxIDQxIDgzIGUwIDAxIDg5IGQ5IGJh
IGU1IDA3IDAwDQo+PiA+IDAwIDRjIDg5IGU3IDQ4IGM3IGM2DQo+PiA+IEZlYiAyMiAyMTozNTo1
NiBUb3dlcjcga2VybmVsOiBSU1A6IDAwMTg6ZmZmZmM5MDAzY2FjN2RlMCBFRkxBR1M6IDAwMDEw
MjgyDQo+PiA+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBSQVg6IDAwMDAwMDAwMDAw
MDAwMDAgUkJYOg0KPj4gPiAwMDAwMDAwMGZmZmZmZmY1IFJDWDogMDAwMDAwMDAwMDAwMDAwMg0K
Pj4gPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogUkRYOiAwMDAwMDAwMDAwMDAwMDI3
IFJTSToNCj4+ID4gZmZmZmZmZmY4MjVmOWU3MCBSREk6IDAwMDAwMDAwZmZmZmZmZmYNCj4+ID4g
RmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IFJCUDogZmZmZjg4ODI2YTI3ZDAwMCBSMDg6
DQo+PiA+IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwDQo+PiA+IEZlYiAy
MiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOg0KPj4g
PiAwMDAwMDAwMDMxMmQyMDcyIFIxMjogZmZmZjg4ODI5MGExYjdlMA0KPj4gPiBGZWIgMjIgMjE6
MzU6NTYgVG93ZXI3IGtlcm5lbDogUjEzOiBmZmZmODg4MjQ5MzA0YzAwIFIxNDoNCj4+ID4gZmZm
Zjg4ODI2YTI3ZDAwMCBSMTU6IGZmZmY4ODgxMDBlYzYzMDANCj4+ID4gRmViIDIyIDIxOjM1OjU2
IFRvd2VyNyBrZXJuZWw6IEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKQ0KPj4gPiBHUzpmZmZm
ODhhMDQ5OTdjMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4+ID4gRmViIDIyIDIx
OjM1OjU2IFRvd2VyNyBrZXJuZWw6IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAw
MDAwMDAwODAwNTAwMzMNCj4+ID4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IENSMjog
MDAwMDdmZmNhZDYyMGFmOCBDUjM6DQo+PiA+IDAwMDAwMDAxZjU5MTUwMDAgQ1I0OiAwMDAwMDAw
MDAwMzUwZWYwDQo+PiA+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBDYWxsIFRyYWNl
Og0KPj4gPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogPFRBU0s+DQo+PiA+IEZlYiAy
MiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiA/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmDQo+
PiA+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiA/IHN0YXJ0X3RyYW5zYWN0aW9uKzB4
NDZlLzB4NWUwDQo+PiA+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiA/IGhydGltZXJf
bmFub3NsZWVwX3Jlc3RhcnQrMHg1MC8weDYwDQo+PiA+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcg
a2VybmVsOiB0cmFuc2FjdGlvbl9rdGhyZWFkKzB4ZjAvMHgxNzANCj4+ID4gRmViIDIyIDIxOjM1
OjU2IFRvd2VyNyBrZXJuZWw6ID8gX19wZnhfdHJhbnNhY3Rpb25fa3RocmVhZCsweDEwLzB4MTAN
Cj4+ID4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IGt0aHJlYWQrMHgxY2UvMHgxZTAN
Cj4+ID4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6ID8gc3Jzb19yZXR1cm5fdGh1bmsr
MHg1LzB4NWYNCj4+ID4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6ID8gc3Jzb19yZXR1
cm5fdGh1bmsrMHg1LzB4NWYNCj4+ID4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6ID8g
ZmluaXNoX3Rhc2tfc3dpdGNoLmlzcmEuMCsweDEzOS8weDIxMA0KPj4gPiBGZWIgMjIgMjE6MzU6
NTYgVG93ZXI3IGtlcm5lbDogPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPj4gPiBGZWIgMjIg
MjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPj4gPiBG
ZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogcmV0X2Zyb21fZm9yaysweDI0LzB4MTMwDQo+
PiA+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8w
eDEwDQo+PiA+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiByZXRfZnJvbV9mb3JrX2Fz
bSsweDFhLzB4MzANCj4+ID4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IDwvVEFTSz4N
Cj4+ID4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IC0tLVsgZW5kIHRyYWNlIDAwMDAw
MDAwMDAwMDAwMDAgXS0tLQ0KPj4gPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogQlRS
RlM6IGVycm9yIChkZXZpY2Ugc2RiIHN0YXRlIEVBKSBpbg0KPj4gPiBjbGVhbnVwX3RyYW5zYWN0
aW9uOjIwMjE6IGVycm5vPS0xMSB1bmtub3duDQo+Pg0KPj4gVGhlIEZTIGlzIHRyeWluZyB0byBj
b21taXQgYSB0cmFuc2FjdGlvbiBhbmQgc29tZXRoaW5nIGRvd24gdGhlIHBhdGggaXMNCj4+IHJl
dHVybmluZyBFQUdBSU4uIFdvdWxkIGJlIGludGVyZXN0aW5nIHdobyBkaWQgaXQuDQo+Pg0KPj4g
RG8geW91IGhhdmUgdGhlIGRlYnVnIGluZm8gZm9yIHRoaXMga2VybmVsLCBzbyB3ZSBjYW4gZmlu
ZCBvdXQgd2hlcmUgaXQNCj4+IGJyZWFrcz8NCj4+DQo=


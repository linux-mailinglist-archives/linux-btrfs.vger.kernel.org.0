Return-Path: <linux-btrfs+bounces-16988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8659DB891DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 12:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365511CC1047
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ED0305E28;
	Fri, 19 Sep 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N+0ESsJW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0BoS3k9v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE96244668
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278578; cv=fail; b=GEY1Mwgvp1bik6nRn+0+TJEaSizBNhpeaxec9zNYTFdzllP0giBker6j1qF+eXMzlsFuktDhoj+uyQEuT9+Z85XLiCAyse3OMreVD07/P28Ub9XHwKCtw6N2nwkWoLc9A+Y1aNSn4T1ICXKPc7rmDWOBkLjTx4C26LrEwEt8Q6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278578; c=relaxed/simple;
	bh=DRSxPo/k8LujBPOfwNwvn/wKeLHfpIw/olSeBkMy42k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pF9ZduQ/0ndymPJE8CTyTAIs7mxsyAlcLDUCif0K6L66MU/+NXvbvhXJ6jXg7Ff9et7ph9TKYlLzOgGySz9Bc6zGyh71E4AXsfi16Z6T5bkmF0EwzFT2q0OEHpIb8/z9skJYHrA0S5IlSDHS60BNDbjD6b1giYdznBeqa3ICw4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=N+0ESsJW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0BoS3k9v; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758278577; x=1789814577;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=DRSxPo/k8LujBPOfwNwvn/wKeLHfpIw/olSeBkMy42k=;
  b=N+0ESsJWSJl/eZDe8WlL0Xo+XeMQ0N7yOuxU5DaEGmcBuain4Q5FkXUb
   8PJzzb0DdQlYA7bB8xPsA3fxdaT8lCq72232fP2ncrCYvdSUgLfV08dsP
   nF7uSWhFXYx9d9VX6Qpv34vMVw1dQnLmq7c12huZRZkBHCzRU1J8Ug/QL
   /qI65z2A00+7H6kSqL3+eBVs8MMsGlnspWxjU7Q5hBqL/YQb5d0jB20he
   H3QDQw3fyvhhuuGz9t/F1ZXH6fYJPi3K0FlhEgoUzFYNuML8A0LK30sVQ
   GoNbVcKQxLg7caPwQqqeUXwexXMBbep/4uZdofAz9VXcypaHzJHGqzcf7
   w==;
X-CSE-ConnectionGUID: W9lhwRdEShGoUrSEcAUV7g==
X-CSE-MsgGUID: EVNHk44ZTiKm+DIUslVbPA==
X-IronPort-AV: E=Sophos;i="6.18,277,1751212800"; 
   d="scan'208";a="121471548"
Received: from mail-westus2azon11012003.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.3])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2025 18:42:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWtKqpyThV/VI5+lYHmxXIGDJpBOlfenJlHmMinCIVDqtc5gwqTmQuMmirMbGt9y8tG3gv4WFzLcOGeoMYLMNaNZIqW2zGsBcNZ8Q7/y+Eu0tDa8oTZK/vX4airMgMUpgF6oT+yyKEARyT8UpjEqa+SwsbsMOvFvP8g4hQwe4OrKgLJcggRbvj+BsoeHXETgXQ702M9ofDVPDExSfGUUm/JDTt7mYQeauIiE+Es0MyOi5JJes9O5PuUHXtbPusWL3mhnwwxvL1vAU1Rcas5CgQC7WPdwFoSQkPpLZ8eMtKIMxmd+tFp/lk/jH2jTRTQXTFbN1ekUlsMKTWz6BQ3vwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRSxPo/k8LujBPOfwNwvn/wKeLHfpIw/olSeBkMy42k=;
 b=e6VFRw/9bxTM3banaQ6DFj2M8wP7Jo8uCyuV7oJARHRPmWTYIxWPFMWt4ReyT5zOC8+k6/BFQZuItZz9XdUMZpDJesdjC6ZQbeKYmuslBjLzOaHRkfHPB4nzMrbvaof/Ixx114JCmHm0n9gFWZGcgJDycUcV+CJ1xcIfHVZfdlqXNuaA3wAWT9t1rFTGdJErDK7f2G+ScSx5kSNJA2yOcKjpiL3/lNo6KOmqz7xIQMvFh+/3eGXvK/iYWXoWjbXVqHGrjjN/qOjqbeE6GOr/577oS/9YXFG96enPx8dIuLBePpYv7GBdzb69bQjI9hl7IlsSekH1UPG53w809uQCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRSxPo/k8LujBPOfwNwvn/wKeLHfpIw/olSeBkMy42k=;
 b=0BoS3k9vPNSLeD/GfmnpzNmSUifoAlrTd50/duTltPRcqRf0nwAqE65LC/c6Gxv/kdStdEOiYMA7EcdCHLwW/NAPocD8tNMSJKf5qPa42AIuG3GNeJpFYvXy+Rhlg0MOZbqUI1rDM1NSgC+GMshqecwoNVBPwcIjvU+vewMnACs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA3PR04MB9279.namprd04.prod.outlook.com (2603:10b6:208:516::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 10:42:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 10:42:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: make the rule checking more readable for
 should_cow_block()
Thread-Topic: [PATCH] btrfs: make the rule checking more readable for
 should_cow_block()
Thread-Index: AQHcKU3Uk5ITjbGuxUuWTT/yYCYZ/7SaUbKA
Date: Fri, 19 Sep 2025 10:42:53 +0000
Message-ID: <a1e8739e-08c2-4806-aceb-12d31d40ef5c@wdc.com>
References:
 <430201af947578096cabe79fc4a1eaea731e8ef4.1758272660.git.fdmanana@suse.com>
In-Reply-To:
 <430201af947578096cabe79fc4a1eaea731e8ef4.1758272660.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA3PR04MB9279:EE_
x-ms-office365-filtering-correlation-id: 0ae8d9de-cb60-4526-d426-08ddf76949d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2dSSXRycURScGFOV0dKUTF6cXppNnBVaXQ5L1JjWUIzU2g1MnFYbEZiOE03?=
 =?utf-8?B?MldWVjhUTzVEZVBKZXBNSlVmQlNzOER6UEJHZHR4TzBPaklrL01SOTFOcmM0?=
 =?utf-8?B?WlRzUnpGR1BOeG1QTXhvS2hLdW44VHRYZXpBeUJSQmVvbWhEY0xNWWNxWitL?=
 =?utf-8?B?d1FES1djSXBVd3FhNFZmTU4xaFpZU3VaM3BBWDduREVUNGRPLy9ZMGZYem80?=
 =?utf-8?B?SHE3WlZ2enRYdUcyZTFKMTlRbWNYMzRoa21hOFRya1BLdytER0J3MzNZNHdX?=
 =?utf-8?B?Q0RVMU9adTlPMU1DVzA4OXV6cnNEaThNYmFIVy9pZzdvZWg5c0ROdXdMdzVF?=
 =?utf-8?B?NDJPbzA3cWVLL0o2USthMDJDY3hUSm1GS2RXQm5MdnpXeXN0cURRazFJN3FQ?=
 =?utf-8?B?amJyMis3b0NIenJFL3hXTHQzbUNhUHNjdXJpRGxScTNVVXdkdXVMZzVsbk1j?=
 =?utf-8?B?L2UyWkxYS1h1MjBDNFhVZTRDZTg2dS9iVnpkVllIdGNGKzJvZDVKQjlPRU9z?=
 =?utf-8?B?Ynl0eGJ3U2JWSXdraTJmcVN2MTMxTmpDVlU1d3dBbmMwdm9JOXhRNEVkcXEv?=
 =?utf-8?B?RXNMbFR2NVN1Mk5DYWY3TXIybGh1RG1WZWV6V3hybFR0V0FPclNsM2dibWMy?=
 =?utf-8?B?dnlmMUJ5NjUyYzhMbGRkYndpQ0FPYUZydTg4Qkk4WWwrTGpiSDdNbXpDNE95?=
 =?utf-8?B?NGxyelVzdkRrQ28yNVgzQlQ3Vjg4WWFkcWNzQmVZZzUyYTFTdC9YeU9GQ29q?=
 =?utf-8?B?UUkvLzBlU20zam16U3d0RndtYlhmZ3l4SWs1NFJFZzBDR3N1enJhSWlJVFB1?=
 =?utf-8?B?eDRLbkpGS2I5K1F4MWZtZWl6SzcwYTVRMk5MZlJQYnJzV2x1ZWgwMnhCMU9k?=
 =?utf-8?B?aHJXWFp3elBGWWRlRmZhVXBjZVlUVVc1a1RSbk5jSlpwWFpWTVlYd3FIN0Jo?=
 =?utf-8?B?RHVNeW1XU3BTN2RPZUFzVWo1WXpIazQwd2VPWi8vTXJHNkdCM1NyRVMyNEpV?=
 =?utf-8?B?WjRaOEFkaDBWMVMrV3Q4V2hueENLWHoybFdwcWJoc2lYWXVwWDlWenhOTEdG?=
 =?utf-8?B?dUxjaW8zU1hKMkRxQVdIQUpjQXZsTWw2VTlNUFV5UDVvRUpoRUlCYmhmeDE2?=
 =?utf-8?B?YkV4dm1sT0grVWxKUVpXN24zSmJ0R0JvUmRVNHhYeTQ3RVpFNHl4SW1MOGZp?=
 =?utf-8?B?ejZtc2tnaG8xU0JUMzRPVy82VUJsNTZOWVBhZ2VxWEsrNVo4MXExT3B0dllD?=
 =?utf-8?B?MlY3c202MTlWSjk5SGtQY0lJTmFzbEJJWEdwQXovZEhJaTFmNnNQYk9vVk9I?=
 =?utf-8?B?L0dYRDVWOVpqZTE4OVFSNXI1TUZITUZxUHkzWmZ4VXYwaFZUcmZvQS8waG1a?=
 =?utf-8?B?VDZLbm1wNDc5SU1ndVdDcGpJRDBZVVFqRG5KM3RSc1RkNDNCYVppdHd3MEtq?=
 =?utf-8?B?SlN2N0czS1hUZFc4Wm1uVWdhaGU3Y2l6Wm9kZGdmbitmMWU5N2hQcnhsa0RF?=
 =?utf-8?B?WlpOTTFWcWszVDlsd2lTa0VkR2pMS3lkMHIzWlNlL1BpY01HV1d0eFR1dTdx?=
 =?utf-8?B?d0gvcVA0aW42ZVZqSzVBcjU1OWwxWVRpL08wbk9LRUIyRWo2Y051Si9DUWVT?=
 =?utf-8?B?NkdFT2ZzNFRjNVNwdUtWOXdzMFJ0TFBwWkVvMklNKytMcElmc2ViQUwrL1JZ?=
 =?utf-8?B?T1EyVllQS21hZk44dGs4VlpidG5Da0l1cElnTjVnNXZ0VVU5K3JKVDhOckFF?=
 =?utf-8?B?QjBHbXFPZjFRUnFTbmVIbktTTmhNN1RIcEZmd2NSVitzR2tmdHpqZExpQ2Ny?=
 =?utf-8?B?dldBOVpJQTlib0RXKzB1MnVVMGVHblBJeFBvV0tGZS9DbkFGQzQ1QmNLcVZz?=
 =?utf-8?B?dkhSbEtYbWVKc0t0VFZ3bmJpcHRMdC8xeU5PN1pxVWVyYm85VzlBNW9lRFhW?=
 =?utf-8?B?UitXeC9DUmo3SE03cDh6ZHJQTC9iWFY5VkpZc2xMYlFacXV1alZDRlhrUzYv?=
 =?utf-8?B?UWVhaGlHVVh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0VNT0ZYc1psR1JwbUYwV3NUZDh4SGpZVWcwQ0R4ckNMWks5dllRNHNkc0J6?=
 =?utf-8?B?RUM0SUFDYjZLTy85ajdJSGc2THNsd3czR3ErU2U1UXdXVUoyZGdyaEZ3WVZo?=
 =?utf-8?B?UHprS0x4ckJYVVhCSTdJR1Y1UTNlSTkyOU1abUMzeTZ5Uyt4UURIaFhpS1Aw?=
 =?utf-8?B?S3ByRlN2enREKzNYN252Z0R1SnVva3EydHBFK3ZuZ0dxMmJDemRyVmRkRXpG?=
 =?utf-8?B?bW9QNmdKWXJ4azhKRHV1clVlalNZMkgxMXFoRlVIODF1OHZyeVlzUDQ3TzAr?=
 =?utf-8?B?NkF4b0ZiSEt2Q1EvTnFaTXVWcGVqMXQyU3pxQ2twZWp3OWhqRWZpSXNzNERB?=
 =?utf-8?B?TzFEa1o3NEJlS0t5RGFVZlJ5U05DaENMSTNnQXY3cElZZTZha3p4YVMvMWRy?=
 =?utf-8?B?N2Q0U1ZRWDMrNnRVenNkTjFRWitlSlZtdno2K0FnMjRPaysyMHhtbnl3eVNz?=
 =?utf-8?B?YWJtTnEyWXJocGhYQUpoRlhJRTR6cVZCNGFNT1hUNStJbmliTDJueEtEa3Yx?=
 =?utf-8?B?RklCbFJ6VXBXZ0xpOEc0ZmtoQnFoVUUwRmd5OUw5YkpiblhwTHlPaW52T0d6?=
 =?utf-8?B?MVUvajliSGYyMjRmdmowdFZzZWxrVnc5K1pyVmdGUHgyc2hvTWsvT3VlbkVM?=
 =?utf-8?B?S0NFVDgzcnVsWlhYOEJuZncvU0hHMW5MSTFFb0lxMWxwTTVGQSsvcXExQUNh?=
 =?utf-8?B?ZWZOMDhVenBkZ3YxbEVtVStPUzkwQWF4YnFpU0gvWW1PY1Brd3VSdzNpdHMw?=
 =?utf-8?B?VElaY2pmQzZLSzdnNmJkemdxK1AvQmFXTFVlckp6RXhSYVk4TDhKb2VZSEpW?=
 =?utf-8?B?VW0wTm51b3M4dStQSEJmNFQrRXpuL252Q3hiSUNUYjZJTngrR2VBVVpwZDVC?=
 =?utf-8?B?ZTFYVEZrYjZIZ3ZaMTA0Wk94cCtzcjBjdHUvT3FUZVFaVXlodUJFSGJ5eXgz?=
 =?utf-8?B?cmlYMnZDMndrM3lWRU9xUkw5ZEZuZkVmaGU1aE9UMVQ3WHpyQ0xBcXJ0NkV1?=
 =?utf-8?B?ejZreXh1Q1JkK0tRdTNRTnA4WHlXM2RnZzJKTkE2dzgrUTBaOFd2Q29lcFlR?=
 =?utf-8?B?ZjQ1RkFUQWFGSWY1RHA3S1VEb1k1Q2hkRmR2dmpTcmdmR050WlMrSUw4emJm?=
 =?utf-8?B?bFNsejVycUh3VlNKMStIbjJyLytaaWk1cEdPa2RPcWJjODZkNGNBQWdHZTI1?=
 =?utf-8?B?ZElkSW1USkVnbGJXQ3dqNFZ0dkZycklzUlJmRXZiQkUvcUZVMTBCaGpUT2ZU?=
 =?utf-8?B?Wk1YalFhZTgwQnlqZjROL3cydC9NelJKd3JobDJmZ2h6MTFsQUFVME0xZGIv?=
 =?utf-8?B?QVJZTnZVSXF2enZ5ZlJRRmg0QnlITkp3eTNQNEtCQStvKy9KZXplRzBpeGNZ?=
 =?utf-8?B?VVNoR2V6SXVkYTdzWXNzdlZYSEZOVVkvNHVHbjUzNFgvUTNzVE9jZFJPVU1p?=
 =?utf-8?B?YndNZW9MNEFtNHh3NktnRjUrSjJTTlpBd2hWRTNSWS9mVWFia3hSMWk1NnE4?=
 =?utf-8?B?dHBYU2gwS2w3cVo4R3Y5ais2S3BoOVp3b0JORUFZLzR5N1BSQzdrR2FZL0hL?=
 =?utf-8?B?ck11SVV3elFrenQyelhxOFJwMUl4T2VVZUpkQTZXSXdXM2N6YkplTE9Pc3J0?=
 =?utf-8?B?OVJjbmROOGx2ZEpMY01EWGt1VG5RNmJVaWh6OW5WdWNJK0FGM0VoZWRUUDZr?=
 =?utf-8?B?bGt6NE1hOHVGZjFySHVOeFVCSUdmbGFva2dxREVXeTRhRllKOXdRTzJlSFJY?=
 =?utf-8?B?Vy8rbWdaWHVQeXJGVStNQzV0ZVp6Z3NBdkN6Uk54RUdwb0U5cm93NkZVM0dR?=
 =?utf-8?B?RnlvQ2tKZUNjRlZxOUxXVi9Sek5PZ3dPZkZiUmNsVWEzcmlCNFBKMStNdUw0?=
 =?utf-8?B?WEkvTFFUaGpYa1JoRm1POVY3WXFYU0NjaXFTclBTYTJ2K3NuTEhKMHNEdW0w?=
 =?utf-8?B?M003M0Uyc3h1VWl1LzNZL3dzNDZFdjdUZzlRaGxScWo3Uy9CVDRFWElFT1lh?=
 =?utf-8?B?OWhsbjBWeXBNTjNLSnYrNWlHaUh6S291TTZnRUxqY3I0aFdEZ0NjVlpyalhw?=
 =?utf-8?B?ZTk1eTZuQnY0TVNnV3hvWVAwdjRxdmRUd2ZpTVYxM0g0dG13ZWZueXFtd3pt?=
 =?utf-8?B?UW9rbmlOa2Jabm9jQzNBYjhBK0o5RWZuZGhoR094UVBxbjFrSXFXK0xjTGFp?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBCBDCFB716B5849A1B03F8419BD1DF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nma8pmGdYXmYP3LeVAQOV3TPT3JzzSMlQYU0ea/vTgqxCVRU7yJ/ooEoaFWNX5J8D8D+Q08bvK0C4aKAwU9N4/Rjhav1Q/JFbGX3E2JFVZZuz987532JIGadK2dErFI1u9jjAqwksmjiJe0kCcGp+fg2lIA6d41yLGtBeYWU/9S39TKS7y0k0kQEYLkdD2r3b8AmnWeyZcl5Mv8tF5Ytu/EX8YafHzGd2JXkf3tcX7xp+/G6xbLgRaU8V7bqJfGET/QjHObkONcdN+HZcsGaH9+jyDH8rA4/txg9cvgLCk13WrnB3SZkirAdCpqpEXX1stgVs6BJVKq9b/5HZe5bXpgd1VSViwKl9Q7jRPDc4y2zIip1bc8STFRP+9o3PAk5nl2tD0TrC20ZFlkTMTJH5eo4RVmSTTCaUfUw3QdY/L1ZC9hG8mytSGzEuFYaDzWG5J0HXt/1DqGKxc/dYUD0GqH2FYBQfJ9+gCMI4lSoFMTjejnqqwZscnV/dLHHdSBt12KO3sLXoJjyvJL0RwKwSzjzTniA1Ex/Xio4EObfXcENEYWHlNGffifX40kFpFW618gVKfxRWW7y5yUVoi98K31hPXCPkq8IyiNW2JXcjUxw2X7Is6CYIePmfWUEHm3V
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae8d9de-cb60-4526-d426-08ddf76949d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 10:42:53.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSX8rLqT37TYaJxzcvV5OMebQ+yOAbXc7t/0e85K1Gr7vgoYHDQx4jFVtSnLv5mQ+33SuvhlXL1OGbPBmc8bTnBis6gb/MSH829DRRQiXEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9279

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQoNCk5pdDogdGhlIGRvdWJsZSBuZWdhdGlvbiBpbiB0aGUgY29tbWVudCBpcyBhd2Z1bCEg
SSBuZWVkZWQgdG8gcmVhZCBpdCAxMCANCnRpbWVzIHRvIGNoZWNrIGlmIHRoZSBjb2RlIGFjdHVh
bGx5IGNvcnJlc3BvbmRzIHRvIHRoZSBjb21tZW50Lg0KDQoNCg==


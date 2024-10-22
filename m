Return-Path: <linux-btrfs+bounces-9058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF69A9AB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 09:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6652831E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 07:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC014D71A;
	Tue, 22 Oct 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OBrguR9h";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X2mnyAEf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD8149C41;
	Tue, 22 Oct 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581382; cv=fail; b=cNmjV/KaC083o0cbyuyVkDtnhuHgFcCWB/znXMQ0upTrHHNEZx3kF8kSfS0qIe5qXreJzkjL1qLMQlQyl7+1xzWMHY5UfJzUsw8n52M2u5suB/6PklbDykEo4k0ye5GFj6AnU2J2Nvmhm882dN3Z5dUmb0QC8z43p6/Z+bbwoH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581382; c=relaxed/simple;
	bh=BXl1lBUFU4SGiDANy7H6/8HrsSpQwk4ALSTDrGKaNOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JvK0OV2PdGfnKRVvOM1NKJfipqi7ZlexPQGeJ1w2QFdrFq0fum7OGjY6L5K44dOP/CCWmDHSaOy2c9GPcFIIhAw2wPD8l7SEu0+ASeM8OIdRpY0AHvpF7TC9Ex6LTT2B6QRAwBDQbZPSm1QdtFGm+YpCk7wz+m7UQpOZP6CuFRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OBrguR9h; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=X2mnyAEf; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729581381; x=1761117381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BXl1lBUFU4SGiDANy7H6/8HrsSpQwk4ALSTDrGKaNOg=;
  b=OBrguR9htcKkrx+Gyiudmhyq6vP2UrapQYjkrk8FnkJHK15SADvzpnj5
   dN+ocQteOO4oW7oHesMnlYvKKY0wFt4SeJIqk8Uei4I0seoj9OcRlp+Dm
   58+TpwUQ25oF3xpmrSs7irWuKWBdp3//PmEUJVCBu/uvwxl2iJ/A+CH2F
   Frdv9jXfYQxCFTiwQYvIjW7D9MaQOuALydHetuC6pqgWkFmPPieiHJjcT
   KL5DCM+q8Qo/HcwDYSBxsMSrZYvO9QjQE6gQXQ9n7JI72q+fjQOnS+vmn
   6wvmEF5dWhF92YUSb1D0UhDjstwcWSwLpMGJw+7ImAjjHjWLdZ8KvNq04
   w==;
X-CSE-ConnectionGUID: 6jWsAbl3RfudMKQTYpLLVg==
X-CSE-MsgGUID: qQxothRMRx2Ql2n36YsibQ==
X-IronPort-AV: E=Sophos;i="6.11,222,1725292800"; 
   d="scan'208";a="29562467"
Received: from mail-northcentralusazlp17012055.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.55])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2024 15:16:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieKuxO/AYBhImsyeicGH75fCMHGoR/VsM1DRumH+ITZxaqPtkR+JrpGb2io3JyeCD4L2+K/WSlyiTbA+ZxmOz4KqAnx37lo/WmSRHkmGb4hq8uqTMyeZ0DjJK/ki/47+PqXRitevyr8o+waWwlAvOtSsjHBY1GyI+q1mGOs++FYZ5kSKmbyVP047YaKbphABQRlL0+i6XECkfM3v0wRRUFOFHM8r96w3YwNZvFcpk3cOBveBTUU2+MDzfS7DhZeOR04A2ccmCHwbvctxNURohIrhEAWeS6QeCdDtMHraQVpQVJy1lP1bVKzxT6Tp1Kpbt0PlsoOukPdud7OzGoiMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXl1lBUFU4SGiDANy7H6/8HrsSpQwk4ALSTDrGKaNOg=;
 b=TNVuHepx3x1QrDW9L2/01FxsXlhQLLkrsL9xfPIjlzz3bpYZ1oV6Gt4h8KYew14ZEiEz553RGXeE5X7dH9Um7jWFSJNFdvkJ8rVrVKlY48gwzhFcgNz4t1Sc9OkKWisOKaYc0SpFusS3fHRSX1Jh+MXuHe0LQHV4i2pG33WKyMfH+fObtj+RCrseVIaBTgZD7EzsjKo4Wp7H7f57ntQeGmypsyVpfxOoe8Y/A8yD2KFAbbwxW4j5IElMgEuevKg49Gro75YOftZ0XgMRQGMjzVhYjQeVmVaxDglJJumZhauKL4ds23B/RCm35/5lMCIEHzZVvxPRGmYVD4tUo016nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXl1lBUFU4SGiDANy7H6/8HrsSpQwk4ALSTDrGKaNOg=;
 b=X2mnyAEf0+PdujNT7MjImXv7x7UUfED2xH5ManDcY+NQTr3MZ76hU6EporarXZhReJxomITb2nqbSmwiR07NIXRlAmf5JpU0CUnuNBdlRM+MiGS442RQDrcB9FtAW6UjG/56h4452tKFyIH/itiWLp3OLGWGOBjH0qUNt+42zJw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7844.namprd04.prod.outlook.com (2603:10b6:303:13d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 07:16:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:16:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Yue Haibing <yuehaibing@huawei.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>, "mpdesouza@suse.com" <mpdesouza@suse.com>,
	"gniebler@suse.com" <gniebler@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Fix passing 0 to ERR_PTR in
 btrfs_search_dir_index_item()
Thread-Topic: [PATCH] btrfs: Fix passing 0 to ERR_PTR in
 btrfs_search_dir_index_item()
Thread-Index: AQHbIgZDQrfHY2OhyUuOS1VyUQ58brKQ4ZeAgAE9qQCAADZggIAABHcAgAAGbQA=
Date: Tue, 22 Oct 2024 07:16:17 +0000
Message-ID: <afa71ba0-8029-44b1-90fe-c8e45bb02657@wdc.com>
References: <20241019092357.212439-1-yuehaibing@huawei.com>
 <7daf798c-64e1-4d22-9840-8954db354c9a@wdc.com>
 <01b2539f-6560-baa2-d968-5675f0ff2815@huawei.com>
 <89f8474b-c7da-470f-b145-a73088ee381c@wdc.com>
 <4cefb5b1-648b-58f6-abd7-d3cabfe507ec@huawei.com>
In-Reply-To: <4cefb5b1-648b-58f6-abd7-d3cabfe507ec@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7844:EE_
x-ms-office365-filtering-correlation-id: c9b93279-8e6c-4ad6-06a6-08dcf2696bcf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eE01SWgxaVRtYm9DZGVUK044QWVOZ2NIUGRYT2MrTWpVZjAvT1k5VlpJR2hG?=
 =?utf-8?B?WnZJamN2L050cUFjVDN5V3pselhlVldsUXNXSndJZldUUWpxdmNvemwrTG9D?=
 =?utf-8?B?c01kdmRlSURUOHh4NDA5T3NsajN4Ukpac3JUMXh5ZExHdG5nMWc2WGx0alBl?=
 =?utf-8?B?c3d1elJPaWxSQ1U1OEI0ZzBhTDFsS2RpMW9kR1lBSThRMXU3V2tiZUNxOVdL?=
 =?utf-8?B?d0lKcHMxQjZhZUhLTVJsQ3kzMTRXeUErck1OTGtOYS9FWEsxcGZFNnJsUmM1?=
 =?utf-8?B?eU9XRkNVQWVUSjdBM1VJZndJTDlVSE1lUEZ3bzBPWlpIcUY0eGNyb1dTaEY5?=
 =?utf-8?B?ZWUwOFhUTHF0bVptcit0c3NSQW9GbUEreVpiSW53K1NYZzBybXBIZDE0V3hM?=
 =?utf-8?B?SUQrVnJTVG5mM1QvSEU3U20vRFFtVWFMNmFsMXpFc2Z5MzQ1S2xSdlM2blZS?=
 =?utf-8?B?M0s5QW14dDhsUHBVWjhjeEpEL3NSTHBOK1RYa2JkVWlkV2lZOWZjVG9remxx?=
 =?utf-8?B?RUxjVTAvekl0T2NaNXRsWnJMSW9IdTF6MC92d3Y0OUVNczQvZFcvbWswVG5v?=
 =?utf-8?B?dnU5N1dnTm9zdlhsczdzVFFBSHc3NndxYnREVUM1ZmVMSzRCSlZnYk9zTmhk?=
 =?utf-8?B?bDRha1MyMGRCT2Z4Rkg3TDNhMkFnZzlRT3BTSzdMaGxnazZ1N2VvbXVIQkVO?=
 =?utf-8?B?SkJNdlFYaWdtNGN3WlZQZGJvL0Ura3ZwdDROYm5oRjJUZDByc3hkRDI1c3l4?=
 =?utf-8?B?a29aWEJnaTdrakRwZU5pVG5kSG40ZGNFZXpiZ1RORmtYSjVYMk5kNFdHMW9X?=
 =?utf-8?B?T1RPNW9TZDVSazd1WEFMbWFmOG0weEFidHJXSGNsQzBTOFU2endGaHNYbmFD?=
 =?utf-8?B?Skk2djZnbFhJeWZ6akZWMVpydldvUGRGbVhmNEt2c2UvRktIYWMya0tyWU5P?=
 =?utf-8?B?WDY4cWdDZkpJSytMckZSdTN5QlZ6cmNrbGFaZ2N4Zm5jWWFjTEFDQ1ZBaDdt?=
 =?utf-8?B?TkN6YXF6NDlrWXJ4bmZnOUJTVDFEK1hFZENYTFNiNU54c25WczhEOSt6Y1BN?=
 =?utf-8?B?dHZ2SXRWZkh4QmwvTWU3L2ZpNkdLWWtmaHRMMThHUHNma3o1akFlRm5HUS9X?=
 =?utf-8?B?Wnd0QzVsUWlCNUFVYitGQ29ES3hoTjUvYjZjTXREcCtRTUIvMXNUVTZiYXZN?=
 =?utf-8?B?bE9NUTFGOUJZNU4rMzgreTljZDErM0hFQ1liZXdaUTMvOHdWZ3ZEd3dtK0FU?=
 =?utf-8?B?YlF0VXY2blh1dVlXVkRVellTbjhVRjVxVThNM2tvWHhnUXBFZ3JCZE9XYmZC?=
 =?utf-8?B?YWxrRUJFM2hZMlRwR1NMQi9xeWpMRVFWZVNaNlZ3VDF6cVo3TTdVSWJpMVR4?=
 =?utf-8?B?T210R1BERUlBNmVNUHR6ek5PTVcra0hZSUhVZmpETm1heitWRE5pTk1qU1Yv?=
 =?utf-8?B?UXN0NzllQVcwWElMWUx4bnJtRnVTdE1PM2Vrc2Fvb200SEJtUmttakFKdlA2?=
 =?utf-8?B?TXZ5SUVLcFpPam1PQ1JLb2dqRE1pSlBWTkNNRzVVVklJZG5hVXI3Z1YzRDBn?=
 =?utf-8?B?aVFjVDdZZlNhZ0hGSHpBT0pNRjZKRi9paWxwNFQ2RnAwdmdPTU4yend4NG0v?=
 =?utf-8?B?TEJ0RWpuYkFvbFc2bGdNeGVkR25SVklLdUFEaG10KzYyNWpoWEJWWS9qRUtt?=
 =?utf-8?B?R3p6SnRWWnFuYmY5UXBHOVV0cFE3VVAybm1HalhNMWFLTFJ5YnVkSEdCZy9n?=
 =?utf-8?B?UDI3Y0E5MG91RW8xQ25pVDZZRHBqWkd4bFUyYXBrZm01b0drcCsyZVUxYnUx?=
 =?utf-8?Q?CAxGN4RunNkq6QKaxJLqol2VSXfIPU13m3Pz8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1gxL0J3WDRDVDlzNzg1aUl6QzFrVkVoY0VmRW4zZlZ2NnVhZGkwc08vOFpY?=
 =?utf-8?B?QWtQOEdSYmtLZ0lnSlorcS9LR2xMMExFVkhlbTRsZzBGa01RaVlJOWV3YWx5?=
 =?utf-8?B?bWN2WWNkWVhSY3hEczB5bDhMTXNpQXIrSDBjZUdzaStINGdSbW5jZlJXcXlz?=
 =?utf-8?B?bDNTSDI1VlY1eDAyTlg1WWpwSkVhL2tvK0Z5N1ZEVjZ6YXJoUFRhZG1FUDB2?=
 =?utf-8?B?c2wyOHgydXF1SkZiVGZKcWliaWtTTUs2TUpjNThZaTl1TGFrWTNpc0Izc0pW?=
 =?utf-8?B?VUo2bmVxT2hxR0NjdHNXL01pS2F5MjRIZEJEeVFrSlF4S3c1Ym10cm5nZVZm?=
 =?utf-8?B?NjhVNUlJNGtWWEtqem1ReDdUK1dTRGp0QTRBT21yR3l2ZEIzSGJMbXIrTWpq?=
 =?utf-8?B?dVUzdW5XYkp3emFaV2I5Q0lCNWtNaXpyQ002MFB4TnFWUXVVZHdGRU5LRFNn?=
 =?utf-8?B?OGp2Z2ExSzJ5RGhMZ0s2VEI4aXhNTFJJZHFkMFdkdWtNdGxFbkpVWkxXOFNU?=
 =?utf-8?B?ZHRFOE9kdk5TSFlJTkh1WnJrZ1Q4OTVIand0UUk4ZG9GbUxUMHVWQmtDNG9S?=
 =?utf-8?B?ZzY5S2Nna0NHaVhqQ3N4aTQ0Q3NlNGZtVlE3Zkc1VkRGMkx1blFmQ1hTR2lI?=
 =?utf-8?B?ejZwTVJLTUptMmdMQWZWdUpPUTlJdHZhRXNKMGZ1LzhJWFFKYVk5WWVkeVhC?=
 =?utf-8?B?WW1FWExWOU5NLzV5Nmt4VmRGU2hvRXJJcmhSNEwvWmgzU3gxNUs5QmpXcGNk?=
 =?utf-8?B?bFhSNXdUQXhkTGd5NUhqeWlrUXNRV0lEMGxYSlZHZW1BYWN0ODdFQkZrcVZl?=
 =?utf-8?B?RHBlanJUS2hDQVZrbTZhQmdweGZYSnhTMGNicDZkdlI0d1M4SkNwUW50dCtw?=
 =?utf-8?B?QmpPMUx5RDc0bkhVSkU3c2lrbnFyek9qdmZzK21KWG0rVGdwQlBhUkM3VG9j?=
 =?utf-8?B?ZkQyYkVjODNVQ3Q1VmlCRGsrblR5elBXSEZZaWhPbWszaHM0TnI5dnRzbm05?=
 =?utf-8?B?dS81bjBCYm83Z2dDSURHTkU2dlM1WWFXdmFaSWxDcmRGeWFNaDhrQUNUUnF0?=
 =?utf-8?B?aW9tTjQvQ3pJTm8zN2QwSDFaYndkQmlaaXg2VGM5VXR1SE5vb3kwczV5THhN?=
 =?utf-8?B?MEFhTVJST2NrdGZweklwQzRzcEhlUlJWM0o1OCswam15c0lUeFpKODFUdnYw?=
 =?utf-8?B?OHJNY3VheHJZTXVNSUM5aWtCNFZjWHpCWm1SSUhpaGdIVGY2QnJYdlhvajdK?=
 =?utf-8?B?WUYxM1hpc1pXLzlhWEg5MjdPMXFKYkRKNk1HS1pLQWJXamoycUsvQU1OUGFz?=
 =?utf-8?B?VXNmT1NEU05WYnFYeVRCQlpwZUFWbWY4NGcyUkZ0SjMySTNBTWZweVpFQ2hs?=
 =?utf-8?B?YUtPNlhkekVobFMxZGlTLzN2Q2swMTBkeXQ2QkRvV0ROQmNxSENVVkFIcXZr?=
 =?utf-8?B?dkVxVkZPeHlCT3lzZEt5SWtqRWVlcndRbkUyeHRyMGVjSGJ5UFNvcjRIUVV4?=
 =?utf-8?B?UWhiN2xVM1VjMENsSlpzQUprcmpicGdOV0M4V3cyTXhMT2VkR1pONHkxamxV?=
 =?utf-8?B?a3VoUVp2d0NhQzNKdWtxLzRza3pYREcxSWtiYzJmYi8xVjFhV2Q5QlA1TXJC?=
 =?utf-8?B?RkNQaDJ1Z0tvODZadUVoYmJQdFQwdUR3UWZ2Y0loSld0MTVaV29kcDNxSDIv?=
 =?utf-8?B?OXNVaEw3MGRDUlBLY3hhVXNWRVB2cEZ4SGtuTWlFRUJNdE1rbE04SjBydlhE?=
 =?utf-8?B?NUhQWEdXVG5ZZGcyNmp5VUNkMmxUVUg0YzBxclRUQVY2QjlXeTZpdWoza0FJ?=
 =?utf-8?B?THJoT3JzNzNpYjNmMEl5aTRnWlBCY09Pc05qckRHS0U4eU9yazFaQXVFbjVx?=
 =?utf-8?B?bEwvQkFraGRPcXdQQTZGVzZmTHh5VDFyUXdRb2ZVSUJYaGFtVTk3d3E3enhm?=
 =?utf-8?B?WmYvaWxrbmNwVld4SmkxUnNTMkpsam9yZzllbWdVaGVROGFhbmFnYzVWWmJq?=
 =?utf-8?B?c1RlNGwxVDd1cTVwOEdqTGlJZHk1NWg0UlI1MWhQNC9GQnJlazNXZEZISlRx?=
 =?utf-8?B?MTJzcHRVMnVBM1d2d09WT21MSWVENkhKU0RmM01tc2ZFcU40bFFXcEtPbkh1?=
 =?utf-8?B?SjZHaEZ6L044cEVONTVxV3l3TENKS0JiaEowd1E0NnJJQjJmVXlUL2pqelp0?=
 =?utf-8?B?ckFUMVhUTUpqT3NXWUFtOStuVEV4S2wxb2twWitUZHlaazQ3NUlPRTJWVGJt?=
 =?utf-8?B?MkZ6S0lLWjN4RUxnN3paS2w3RG5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <836DF3AD80BBFD4DBE208B15BE53159D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	He8U2+bhGCy4axHrELJJSr3hKnNdsxnaUAToO77FB9eu6Pypx4/OGXbIgmROWQ27DW43KrzuDldhocv5f1vSRr61X7Vh6Es+0FllAvuyhnhfKJRxhCbQgJhW/RmI0fpZvFB2DYqvVaYCvBGHxvSUKINGEe6zGznenBm8ToqDlAPkU4vuGDbRBpOSodTiPPNfPzjnThG9p+NKVlvbzVVPmrFq6CJK9M+2d2yW+ZgssD7GOD3j/HMUWmBN6LZFneeeLVLJ7JFmltcjUFSQ23rGSLdYoJ6pRkGocxgkxHNUxrb3TsoVkpB57O7AiLXooMR4F139txHSktYgsmicXB5+HN/j2J4jZd//wROkYSGOmn4Ud3O6fpNhRjn442kVTs9TlAp1whgXoEQbBEDd9Bp2GVhJo5hwjBE7SHicKCzNoUROQDNBaUMu2TDxZLXSbEw+86+gCBQNUg++frFrKHpbO5gq4c2LZEVMafXvTkaZjUP+QXNQ0TS0OeK+ihgzOF66c8dJvkhHIAQPvoJqm1xZ1WOJB3DrHs4/M8NP+Pcw7YBYT9XfObYFquhRgnFz42SWeKW9+qtyIjolcVKToDfsPOZ+c0h9lCEDrT6NzvgBYeQDgdt0lbxBO5aV54sFkj1S
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b93279-8e6c-4ad6-06a6-08dcf2696bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 07:16:17.3863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXCYrCp1s5VbREZ30xRdi3pLAUS5vtqYlSmGShXRmjEm+7xJ73t9TdAIW3YZ7nsyzQq8w5tVRf4XE+fjbGqi/2Al0BUHLos25HplchHTOsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7844

T24gMjIuMTAuMjQgMDg6NTMsIFl1ZSBIYWliaW5nIHdyb3RlOg0KPj4gYW5kIHRoZW4gc2V0IGl0
IHRvIEVOT0VOVCBpZiBpdCBpcyBOVUxMLiBTbyBpdCBzaG91bGQgYmUNCj4+DQo+PiBpZiAocmV0
ID49IDApDQo+PiAJcmV0ID0gLUVOT0VOVDsNCj4+IHJldHVybiBFUlJfUFRSKC1FTk9FTlQpOw0K
PiANCj4gSGVyZSBzaG91bGQgYmUNCj4gcmV0dXJuIEVSUl9QVFIocmV0KTsNCg0KWWVwIG9mIGNh
dXNlLg0K


Return-Path: <linux-btrfs+bounces-16615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F84B41C0F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 12:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B1A1B26C3C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4A2F28E0;
	Wed,  3 Sep 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pzip6hBK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JiIBSnmO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332E2F1FD1;
	Wed,  3 Sep 2025 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896118; cv=fail; b=bWjs8DfnDkjcEQQsq6THy3LX6FvHEj5K1k6UBLMlTqzYC2P8sCIYA2erKq0rSuT51qzEqJ4vQl77LVoU7eTf71Yo/JaDzmFARIySbYuSHQbKVfDBCDTk3EeKf3xxMI3tXRKL3+LdWtzaEmsZAf6UJokKHgIdTI0eLnOnqAFxs8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896118; c=relaxed/simple;
	bh=4Cyja+OcO9pLTqRD1PO7eQseD4Ovf+233DhTU+zdxbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNoaDMKtu3YfWCXqwEanOiwhcQKJlQtJVzdEiA6bW9lu541EOzDxvSIvmpN5Xyq5DOsx2N6w1qED0dfdlLie6tyqvCz2LnV4bECS0D7Mv3SH7Kj8kXa8bo2wf9EWXrKmgV3xYkB1H67VdErbBw34vY9a+RDKrXk54XfsLSV7/gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pzip6hBK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JiIBSnmO; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756896116; x=1788432116;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4Cyja+OcO9pLTqRD1PO7eQseD4Ovf+233DhTU+zdxbk=;
  b=pzip6hBKQGZMNjiGhE9A8QvMA3ouVtptpkZk/D1pbRRtfAjnHfl708Pu
   EwwYxB5leo6Lf1J3sZx2rgRxpBhS/ztYOOhWtbRVL3uRIgTZNsupxK9Ht
   6u0hffLuUJZezmDeFuA0zRRhIPndrDQk9iUpkNSp90P41zuVDPb5OowC5
   CEG+fYAyxPx4o8Nz/4YHDoNC4Pnf+rDY39YWX8aVPsoQN+q9aVT4G1zA4
   tD6t/4pNAR0lvTHLkS6F6XFCclV62srHIEvEYMdd9F7aKl5fmxS4ekhc9
   myQMhRUoHqHTQa1yDlhPhnFgV1/1KoSIMh4njGyxaVw8/FihmmbtEaXdd
   Q==;
X-CSE-ConnectionGUID: jnupn4d0TrChJZT6BPZQxg==
X-CSE-MsgGUID: toRCsz79RDmKEAMKqe2hyA==
X-IronPort-AV: E=Sophos;i="6.18,233,1751212800"; 
   d="scan'208";a="111717967"
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.66])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2025 18:40:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMYlcOmM8lv19zTTH/crb/JwnoyZY7fcel0sCBpsvUofmPOjS2iDozl6CGIC/44izLe6Fz/F2oaMrezHZNr4EP2M3XeyNWQbmMRjLtMXOsTe25vDdNQhVVzyGiCXU+4onisIKrBahLiStP2DOh9k3wLnuVK0W54FeAvz4vbwUrZk8fx06H3OzTekyfaUem5MTV910zitAfF4k250dNgYVHt2DkpGWwtTmqwupgkT6VUWE0mryp5tQ7ARtzcOWXASDfTf6qr6WGwp0WzpElk3ZTjdcN/1qpkS09IODl1XpTvZ8cQff5cjEEMucBQtlVAgdrxpOzptDEyBvFr4yr5Hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Cyja+OcO9pLTqRD1PO7eQseD4Ovf+233DhTU+zdxbk=;
 b=kg/sMBBJmYRTMeJKNQJHV33byII0z3c80LNSx8634WUCLW1ZZ1MNIphML1pEPlaHmvD9FxYrx0frhZvweyUe6DOt1fq2vM6FD5+26gAVWSWQZXjiGZ11Aa4/ZLbk+bx5Az7gzkgzeZ2OT3dVHNV8LMCvt92wShqtv5sphVZ5dcDvxBQMqLH18BuYCFjSboOKIkrk+XUFfFA7QYcW4XeV10c3W5yrby6YSYVWpNsqY2yguxPl6zmosltN7TOjJvxU/XxEAaBPRNyOWpelPDePg92bCunlxYWfgB7rfq7GNg0EAetj3YuqCumEpEyFiS5tLfbJHvg3bHMeXzNLD1737Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cyja+OcO9pLTqRD1PO7eQseD4Ovf+233DhTU+zdxbk=;
 b=JiIBSnmOVixpu8a0m9KMX85M0yzvejB7EVomBSZvC7SWQOUugxggCGeNd2Yr1of24J9KJLW8ahhIHLsBf9lQJezzGEr/XTNt4rl1QY9/7y67rIG9DF3UmPnF7nZcRZhP8ngF8HVdoPyuqVFXHoOZaeWb2b0nyYsKQoXe6VDal+o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7582.namprd04.prod.outlook.com (2603:10b6:a03:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 10:40:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 10:40:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [bug report]kernel BUG at fs/btrfs/zoned.c:2587! triggered by
 blktests zbd/009
Thread-Topic: [bug report]kernel BUG at fs/btrfs/zoned.c:2587! triggered by
 blktests zbd/009
Thread-Index: AQHcHK3gZWTSYLE8sECaqNpoDaltkrSBRQyA
Date: Wed, 3 Sep 2025 10:40:46 +0000
Message-ID: <44be7089-cd6c-40db-95c7-b31497afd5a0@wdc.com>
References:
 <CAHj4cs8-cS2E+-xQ-d2Bj6vMJZ+CwT_cbdWBTju4BV35LsvEYw@mail.gmail.com>
In-Reply-To:
 <CAHj4cs8-cS2E+-xQ-d2Bj6vMJZ+CwT_cbdWBTju4BV35LsvEYw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7582:EE_
x-ms-office365-filtering-correlation-id: fc39e1b4-2de7-4c93-6174-08ddead65721
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2NRRkFDZ1ZFbHlHam5DcW92WmtEK1lXSURKMEd1L09hN2hvRTVZaUsxMWRz?=
 =?utf-8?B?djV3ODRsOWROaHhzNW5rTnJKbGtlTVJDcHkxSldTWTgwSTRGVU42QndhcTh6?=
 =?utf-8?B?YXJrUWg1SlBKZlE2ZGJzQjNxS1hoTlR0V2NwbjR5TVlKZlQrN2xmZ1FXUFpN?=
 =?utf-8?B?VDVidmhmMWxBK1UxdXlOeHVyOURPbGRicUVpT2NZZXhuUlRNay9yWms3QTBR?=
 =?utf-8?B?N1FBVHpURk9EWURrbmtYaFhhdkNBSFVWNWc1dVJ3TzRNUmtkbExSOUtZY1Av?=
 =?utf-8?B?RVJ0SE02UHo2WDQ3eCtjOWg5Mnk5REttMTdWRzRFMy9PZVVUV3VMalp2Qkgr?=
 =?utf-8?B?TDNTK1lGT0lSSHZ3VDJUUkl1Q21RZDVuOVYxTXVMVlNNWEVXRmcydjJ3ZFVt?=
 =?utf-8?B?MnYvMUNoUkFOcmNHS0ljRmw3OVVsL2FWSGJzeldhejVqenArOWVlQm9ISWxq?=
 =?utf-8?B?WnFGdDNJdnMxSmw5VTBHRmQrU0Q2dWU4WmswUkUzemR4YTQvM01vblVzY1Z0?=
 =?utf-8?B?S2R2WklIcnhYUmNNT2d6c21CYm0rbTJETGNrcXg4eXE2ZlFXOVFiOG5MOS85?=
 =?utf-8?B?Y2xEaUZmSXhBUzlCcmNhODlKYmFScHBDbFNSZDdraVVkSFRicjNpckF1MnNU?=
 =?utf-8?B?Z2NSMDNiV0tXNmk1VHRvZVpaa0prYzh3OE9BZ2wvNWtSK1EyTERlTWprTzdt?=
 =?utf-8?B?OGtwTnJhZDR1cThjZFl4MXdLNVkrWkxPTFp2SERjY2xKUEs2M21qbndJemRj?=
 =?utf-8?B?Vk9pQUlpeG5ibmhSa3pqSmdWRk5KTjF5Q3YrUWRoR0VoNzFiOW9JQ2ZnWWlr?=
 =?utf-8?B?VUR3cWRIV2h5alVKMnQxeUVPckkzNlRQb3Z3YjRiMVVoeUlaSk1yOUdvWDNP?=
 =?utf-8?B?b2E5VmwwYmlJdnZPaUdWNFVBY0hkbnU0OEpBNkpkRk10cWVLdUFubVBSZ210?=
 =?utf-8?B?U0xTUGlvWktHaGNjNmxTK1J1Z1gzMzlxNnJtN2JPdGR0MmwrNjMwVno3dTN2?=
 =?utf-8?B?T05rRXZ3bTVpNGR4OGI0U0lERTBDUHJzajMwbDNhTmdDQ2tqM1V6Zit2dG9K?=
 =?utf-8?B?VzVmYmNFZDJKcXBrSnpIN001UnQrbThvWTZaZEovbkd2Q3FaOTU5RzQwMkR4?=
 =?utf-8?B?MHdQN2JtM3FoNDlmZllvYlpCNTRVZlpIclhFK2QvZGZtVzZaTHh2UGNHZlky?=
 =?utf-8?B?TlRNaEZrTDQrcEVPQnRDVWhUVlhiRTNyS1ZSbzN1WXBxanBRbk5jTXZuZHNZ?=
 =?utf-8?B?NFpmYm1qOTlZZjk1US8yaHJoRVRleVdkMDA1N1F5ZGcyZWltditZSXhmK01Z?=
 =?utf-8?B?T0JEcXVkNGkxK25pck1XUFR5dTNCM0tnRWVSbTBBWFBWN3p1aUV1cnZ6OHdI?=
 =?utf-8?B?Q2xqc3VQWk5jWFJoNFZQSWUzUXNlaWxoYW4xYlpIa01GdHF2dW5zQ05lS3M4?=
 =?utf-8?B?RDhBbml6aVVFd2d2YVR5djI5b1FOQzE4NXJ1RDVXNDlDNG9kWDBjbFJmT0h2?=
 =?utf-8?B?R2lGby9uUW0vYmk0ZFRvR2Vibi94Sno5NHE5Y2VZd2t0dkN5MG1MdXlhRE9q?=
 =?utf-8?B?OVMydEtTc0hnVlQrd0FsNzBlMGV2bVlMOHNkQmc5WWlmVnlVYzFXZTB1bnk0?=
 =?utf-8?B?THdaS01GTkFJT1BhN0hyckZ6YmFwMnZzV2pxcm5yL1BSQU5JMmdWeGJacEtj?=
 =?utf-8?B?TERhZVpWbFlFazgxQzkrMXhNcG1mdWhDZElIWXNhLzBEM0Q3clZRYVZSaytH?=
 =?utf-8?B?ZG1DbldLVWh0aU1kajN5dXdHbklkSWJXZkJwUFhPYUd3dFJuSTAyM2hSM0xW?=
 =?utf-8?B?Vit3dXNqNjBFQXZSTzVUVlNnc0dXaEs3dlNNa3I3MVRvTHFTVXNidjNLNWhP?=
 =?utf-8?B?TXJETGlsTnd6OWhDVCsxZG00bjV6Z0JYYStnU3Q0MW1idTlTVEpKYm05VzJs?=
 =?utf-8?B?UUpUME9MRG42OVkrdHJ3SU1ISENMSGNZUTA3NFJCRjV4SlhvZG1rY0JXWTVw?=
 =?utf-8?B?bDNqbDJHOXlBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE83eW1rY3NHNHcyRTZXbnJabENWQjdEY29mSDd1bmJDaURIRGt2bmFPMFN4?=
 =?utf-8?B?cWh4S0R0QkQxZmVWbElqc2NjMlFQd0Vxak8vODJHU1Z6dVRKejJzN0hZZmov?=
 =?utf-8?B?MzBYamhCN3NtcUVKNEJnNEcwYTMyNmRSaHRCSWRSakRSZFczNms3ZEpXeWpj?=
 =?utf-8?B?OVYzbTVFMTV1bndZdlNYUGtUQXNHWXRjcGtmMFpaNmJJcC9zckVXN1BLamJE?=
 =?utf-8?B?UXBpeFpmdkM0dXkyTklrTnNoK3doMWxWc25DVXlCbUlQMUxkMGlzbDV1SWxp?=
 =?utf-8?B?WkZJeTRCdmNET3VFQXRYY3ZYMzB4Qis1QWdUY2hUcGhiUW1UZ3R2TE02S1da?=
 =?utf-8?B?L2xVZTBLL2xoY2N2dEwrbEtCRllsZ1FoclVEbTVCOW9jS1RLR1FZL0lJb1Ji?=
 =?utf-8?B?ZHVHSW1WR0ZwWnZSeFVQc3NUWWx2Ty9IaHVvaGttZ0gwN3g1UTh5TVVJWHBM?=
 =?utf-8?B?c1FEY1NnZndVay96dktxdGdIUjlSZjBSdklFSER4UDFRMUFpeVVwV2ZZNU0w?=
 =?utf-8?B?V1kxM3d6UjNOVGNFYlVoRHo1QW5SN00rYWNKSWpkWXdqSDFrT1ovc0pGajlj?=
 =?utf-8?B?ajd2cWdIUUFtVGpuS3Z4Qm5qaXJUS1RnL0RuS0RaT21NekJFMWVLWkRjVU9V?=
 =?utf-8?B?VWFWVE4vZmJML1N1bzlVaE14QUladk1YUmRYbDFhR1lJb01FbzFwQWpVWk5h?=
 =?utf-8?B?VE5aUVhFZE42L2FIZm9YNXRsU1JISVlXaHZaYitNTEtuU1RMd0o1WXJZMDB1?=
 =?utf-8?B?OWVwMWw1S2dia01Oa1VpZUoxVUREMU5WY0FqUkwrZ3pEZzQ1NkFGZG1zTXFv?=
 =?utf-8?B?dFRjbnN4NStjR01CcGJlUlZvaFE0bjgzRnh4U0F3cUZKZzhEK0tWQ0t6bUtM?=
 =?utf-8?B?NGdYUm84WDJsSzcrM3BSamxQVFQ1OW9JN3JiWENjdENoMFJieHVYUjlUdTdW?=
 =?utf-8?B?RFQxT0J6Y3VEU2Mxc2FLcVJNZjQ1L05ka3Zwd2hHVVZVQ092Tkt3ZHp5ZFlX?=
 =?utf-8?B?TXNWQlcySzhKWWxTM2QydEp3QlliSUhMb2l4aGpLUmNVbXZMY0NjTk1HeTQ5?=
 =?utf-8?B?YWZHRnlMYzhlL29VdVFkNjVaQWZFRUg1RG1XSDE5Q0tGZGIyalRRM1U4NjBV?=
 =?utf-8?B?MXEwc0hYTXNOUzVHOFoyNGdNWmpwa2RoUnZLb05zamFLTFh2WDV4NnNHMGdF?=
 =?utf-8?B?Q1g4SGttUmVYamF5RzBSS3RPQVMyY2NDR3k4ZFFaalNpZlhUWHlrSkdsaFhR?=
 =?utf-8?B?VjJpOXN6dE1aa3lSZUZhbUxtT0ZQSHlFbzlMZ0tMdys3MDNXM1E3a3RGQk90?=
 =?utf-8?B?V3JOeWxEMUtlVlJISzRaWmVUdUdLaDBZL05UaFlmN1A2QlExTTU4aUZDTit2?=
 =?utf-8?B?UHBzaytlYlJhaEwwSnF5bytaQ29zbWhteEo4NGlxSnhkR3pXTEpBcmhhTkQz?=
 =?utf-8?B?dHdWNkphWThuK0tKWmZhOVhXb1lJT0JsR0xTcE9McEN2U3JvWXlrU1VJMUFE?=
 =?utf-8?B?THBYZzh0cGZiZDJOYnlWMmNuSU9hVVFnZzlPaGM4dXVvVVpvUWEvZDB0bXln?=
 =?utf-8?B?ZWRGRUlPa3FReDFEaFJZdm9idVR6eVh3M3d0RE9GZFBGaXg1cDJYbXZDbHFO?=
 =?utf-8?B?c285amMvZ0txa0c2ZUtTSVJXa0RvaGZDb2M3U3FlT0g0ZGNKd0x2Kyt2THBz?=
 =?utf-8?B?YjNwQlNhOEs3RXVlYVhHS1RYYS8zbk1YN2xSOVlFTFhOajQ2dDRhRWh1eTFI?=
 =?utf-8?B?bWZwZXk0Q3lMK3ljd1ordFc1RSsydElMR2Q5T0tMZldPRXh3RDQ5NTY3bStL?=
 =?utf-8?B?ck95Z2hyU1hMMFVYUEJ1ZHBONmlTNFhQVTNtdFNBVlJCK3BIMGdmMkFXQ2hE?=
 =?utf-8?B?UnhsVnZIeWIrSXh3QzFkb1czVDRHZS8vN3ZSaFgxbWp5WmdlMUF5bDcwV0Iw?=
 =?utf-8?B?dFBhL1JhYnZORzJSWm43bklPRGlBRUdZNWJXTTR1TVY0V3JDenVWQWozM015?=
 =?utf-8?B?eUJoN21vWTFwNmpOdFBKNTFyMUJrODl5Y2FnUHFQenEvR3lZZ0VKUmJ2UEhn?=
 =?utf-8?B?TGU5UTh3c0VVR3YyaHNwa0F1ZEhCbzRUZzVIZ0pFZWx1ZjFvUnYxbko3TGl5?=
 =?utf-8?B?ZlJ0c0tlak1DUXArb29lem9jTkNRNXp4dURpY3R1WDFCOVNXVDJ0ck9RdHlt?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27AC7C8C199C124C8F31ABD39A87F8F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JHm+JdGekFqas8judXPCyp6VDtmZjKHe8Xyh02t9ufAk+ouQPBQSbVE2RLv1vL4NXo6p+IBUjJ6kq7N9oYqpIhj15KNbcUFNBh/KlRfCGrRm5pk2oMWI5+kzhVCuZe+nZ77+vE5NhRM/a7jBPg0WvVq0Gmhkgj3TcjfjgsNpIEu+yMv6WC1nJC7s4yITQUqwPr8ytsXEmY9D9s4nFVbP0/YhgFFMoVjydFcFGozzWfKScS6oXkZ4x1aSzhX6Es/JpDVcvtFGqu4Ya63IE2oy2oEM7VZ0mswtTRYk2dJAEj2o8Y011NODz6W0x5i5VGYfg3RlxNek5/slsR1zfmLPhCkgELP2u4EDkH49KiMC9hakzgHSlACz0tE/9W+PydlhVvVnHQqH5p71TGINpaljnxwkwOxGIDN8s3Ba6WnlPa3+Ut4rYgJ8k/JfJhkhEznL/gdOxr7jUHOADQpVuttWvkLuue6b6UfPECgscewOequZxxxFAi+EkiOI4HpSmrtmDZiPOzmMhQdI1JUuYtXRnWJSR7Hnsh9gu4a2a27pDkYQMjP2rMJhcVA1Nfp+KnTZapLEQO5INiufGiquu7TpXP35qLNmEraTsnRToD0AbvpUlefoBfeEv9fkFJx/aUSs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc39e1b4-2de7-4c93-6174-08ddead65721
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 10:40:46.1831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtoF7eHdvdmmGODbBA1ldWXe9QBNZYydIGdt6YcMuuBD9ZJKOFUOKLWukRmoVz6JMD+MNYEWq1edS/mzDIKCyqN5JdhnutzkpbEZqp1lW8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7582

T24gOS8zLzI1IDEwOjM2IEFNLCBZaSBaaGFuZyB3cm90ZToNCj4gVGhlIGtlcm5lbCBCVUcgd2Fz
IHRyaWdnZXJlZCBieSBibGt0ZXN0cyB6YmQvMDA5IG9uIHY2LjE3LXJjMywgcGxlYXNlDQo+IGhl
bHAgY2hlY2sgaXQgYW5kIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBpbmZvci90ZXN0IGZv
ciBpdCwNCj4gdGhhbmtzLg0KWy4uLl0NCj4gWyAgMzE5LjgxOTgyMV0gYXNzZXJ0aW9uIGZhaWxl
ZDogYmctPnpvbmVfdW51c2FibGUgPT0gMCA6OiAwLCBpbg0KPiBmcy9idHJmcy96b25lZC5jOjI1
ODcNCj4gWyAgMzE5LjgyODQ0OV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0t
DQo+IFsgIDMxOS44MzM2MThdIGtlcm5lbCBCVUcgYXQgZnMvYnRyZnMvem9uZWQuYzoyNTg3IQ0K
PiBbICAzMTkuODM4NzkzXSBPb3BzOiBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFNNUCBLQVNB
TiBQVEkNCj4gWyAgMzE5Ljg0NDgyOV0gQ1BVOiAzIFVJRDogMCBQSUQ6IDEzNzAgQ29tbTogbW91
bnQgVGFpbnRlZDogRyAgICAgICAgVw0KPiAgICAgICAgICAgLS0tLS0tICAtLS0NCj4gNi4xNy4w
LTAucmMzLjI1MDgyNmdmYWIxYmVkYTc1OTcuMzIuZmM0NC54ODZfNjQrZGVidWcgIzEgUFJFRU1Q
VChsYXp5KQ0KPiBbICAzMTkuODYwOTQ4XSBUYWludGVkOiBbV109V0FSTg0KPiBbICAzMTkuODY0
MjU5XSBIYXJkd2FyZSBuYW1lOiBEZWxsIEluYy4gUG93ZXJFZGdlIFI3MzAvMFdDSk5ULCBCSU9T
DQo+IDIuMTkuMCAxMi8xMi8yMDIzDQo+IFsgIDMxOS44NzI3MDRdIFJJUDogMDAxMDpidHJmc196
b25lZF9yZXNlcnZlX2RhdGFfcmVsb2NfYmcuY29sZCsweGIyLzB4YjQNCj4gWyAgMzE5Ljg4MDAx
NF0gQ29kZTogYWIgZTggN2UgYWIgZjcgZmYgMGYgMGIgNDEgYjggMWIgMGEgMDAgMDAgNDggYzcN
Cj4gYzEgODAgOWYgNTkgYWIgMzEgZDIgNDggYzcgYzYgMjAgYjggNTkgYWIgNDggYzcgYzcgMjAg
YTAgNTkgYWIgZTggNWENCj4gYWIgZjcgZmYgPDBmPiAwYiA0MSBiOCA1ZiAwYSAwMCAwMCA0OCBj
NyBjMSA4MCA5ZiA1OSBhYiAzMSBkMiA0OCBjNyBjNg0KPiAwMCBiOQ0KPiBbICAzMTkuOTAwOTc3
XSBSU1A6IDAwMTg6ZmZmZmM5MDAwYzIxZjkzMCBFRkxBR1M6IDAwMDEwMjgyDQo+IFsgIDMxOS45
MDY4MTZdIFJBWDogMDAwMDAwMDAwMDAwMDA0NyBSQlg6IGZmZmY4ODg4ZDFhNTQwMDAgUkNYOiAw
MDAwMDAwMDAwMDAwMDAwDQo+IFsgIDMxOS45MTQ3ODNdIFJEWDogMDAwMDAwMDAwMDAwMDA0NyBS
U0k6IDFmZmZmZmZmZjYyOWNjODQgUkRJOiBmZmZmZjUyMDAxODQzZjE4DQo+IFsgIDMxOS45MjI3
NDJdIFJCUDogZmZmZjg4ODEyMWI3YzAwMCBSMDg6IGZmZmZmZmZmYTgwMmNiYjUgUjA5OiBmZmZm
ZjUyMDAxODQzZWRjDQo+IFsgIDMxOS45MzA3MDldIFIxMDogMDAwMDAwMDAwMDAwMDAwMyBSMTE6
IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgIDMxOS45Mzg2NjZd
IFIxMzogMDAwMDAwMDAwMDAwMDAwMSBSMTQ6IGZmZmY4ODgxMjFiN2MxMjggUjE1OiBmZmZmODg4
MTBmMzc5ODAwDQo+IFsgIDMxOS45NDY2MjVdIEZTOiAgMDAwMDdmYmQ4OWU5ODg0MCgwMDAwKSBH
UzpmZmZmODg5MGFmOGU4MDAwKDAwMDApDQo+IGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gWyAg
MzE5Ljk1NTY2MV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1
MDAzMw0KPiBbICAzMTkuOTYyMDc3XSBDUjI6IDAwMDA1NTllMGFkNGI1NDAgQ1IzOiAwMDAwMDAw
OGUxNGNlMDAzIENSNDogMDAwMDAwMDAwMDM3MjZmMA0KPiBbICAzMTkuOTcwMDQ2XSBDYWxsIFRy
YWNlOg0KPiBbICAzMTkuOTcyNzY3XSAgPFRBU0s+DQo+IFsgIDMxOS45NzUxMDJdICA/IGNyZWF0
ZV9zcGFjZV9pbmZvKzB4MTU1LzB4MzkwDQo+IFsgIDMxOS45Nzk4ODBdICBvcGVuX2N0cmVlKzB4
MTg3NC8weDIyMDMNCj4gWyAgMzE5Ljk4Mzk3N10gIGJ0cmZzX2ZpbGxfc3VwZXIuY29sZCsweDJj
LzB4MTZkDQo+IFsgIDMxOS45ODg4NTBdICBidHJmc19nZXRfdHJlZV9zdXBlcisweDkzNi8weGQ2
MA0KPiBbICAzMTkuOTkzNzI1XSAgYnRyZnNfZ2V0X3RyZWVfc3Vidm9sKzB4MjMwLzB4NWYwDQo+
DQoNCk9LIHRoZSBwcm9ibGVtIGlzLCB3ZSdyZSBBU1NFUlRpbmcgaWYgem9uZV91bnVzYWJsZSBp
cyAwIGFuZCB0aGF0IA0Kb2J2aW91c2x5IGZhaWxzLCBiZWNhdXNlIHpiZC8wMDkgY29uZmlndXJl
cyBzY3NpX2RlYnVnIHdpdGggYSB6b25lX3NpemUgDQpvZiA0TUIgYW5kIGEgem9uZV9jYXBhY2l0
eSBvZiAzTUIuIFRoaXMgYXV0b21hdGljYWxseSBsZWFkcyB0byBhbiANCmFzc2VydGlvbiBmYWls
dXJlIGFzIGJnLT56b25lX3VudXNhYmxlIGlzIDFNQi4NCg0KVGhlIHRlc3QgaW4gdGhlcmUgaXMg
dG8gY2hlY2sgaWYgd2UgaGF2ZSBhbiBlbXB0eSBibG9jay1ncm91cC4NCkBOYW9oaXJvIHdoYXQg
ZG8geW91IHRoaW5rIG9mIHRoZSBmb2xsb3dpbmc6DQoNCmRpZmYgLS1naXQgYS9mcy9idHJmcy96
b25lZC5jIGIvZnMvYnRyZnMvem9uZWQuYw0KaW5kZXggNmU2NmVjNDkxMTgxLi5mODk3ZjkxNGI3
OGUgMTAwNjQ0DQotLS0gYS9mcy9idHJmcy96b25lZC5jDQorKysgYi9mcy9idHJmcy96b25lZC5j
DQpAQCAtMjU5MCw3ICsyNTkwLDggQEAgdm9pZCBidHJmc196b25lZF9yZXNlcnZlX2RhdGFfcmVs
b2NfYmcoc3RydWN0IA0KYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykNCiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwYWNlX2luZm8tPmRpc2tfdG90YWwgLT0g
YmctPmxlbmd0aCAqIGZhY3RvcjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC8qIFRoZXJlIGlzIG5vIGFsbG9jYXRpb24gZXZlciBoYXBwZW5lZC4gKi8N
CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFTU0VSVChi
Zy0+dXNlZCA9PSAwKTsNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBBU1NFUlQoYmctPnpvbmVfdW51c2FibGUgPT0gMCk7DQorwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVNTRVJUKGJnLT56b25lX3VudXNhYmxlID09IDAg
fHwNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJnLT5sZW5ndGggLSBiZy0+em9uZV91bnVzYWJsZSA9PSANCmJnLT56b25lX2NhcGFj
aXR5KTsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IE5vIHN1cGVyIGJsb2NrIGluIGEgYmxvY2sgZ3JvdXAgb24gdGhlIHpvbmVkIA0Kc2V0dXAuICov
DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBU1NFUlQo
YmctPmJ5dGVzX3N1cGVyID09IDApOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJnNwYWNlX2luZm8tPmxvY2spOw0KDQo=


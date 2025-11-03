Return-Path: <linux-btrfs+bounces-18579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0336C2CF06
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 16:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5391C62072F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90C31A7FD;
	Mon,  3 Nov 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TQROD4U+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FazWLYQn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795F31A54C;
	Mon,  3 Nov 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183089; cv=fail; b=DQyfjxBIdevLtUp47fZLxTlT+puBbf3rvz7abxBsmWmVX3fri5+2v+PKitbCHx9OoJ4GOPo/uDMfCV5W922ZufHWVs83rWNqax8PRstqm1Mn2FeZga9lrt83Fi3ibH4AeGeFrd9/1nmhPFGBQfKTIbBtXFUQ/ETfB/iRKwCBFb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183089; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EXMJaCXo5nNtMvjtC6WL805mpEZ94S16bfiARZEB/bMas/ontV/CnImjKOYcicsmYdTstiWQjr2TcGX51kd090LhPcl0WE0cA7DGQwwFdQkpYtdZ5aJGgkwnVcMfZR/2hTI4VDK0KSW36O1mWNWCXXkekTug+dUdjfvmAyQTENA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TQROD4U+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FazWLYQn; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762183088; x=1793719088;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=TQROD4U+u9kLZrOe3nlVnKAtVjkRJ4WMhcPGdtvN8MmTbRRBD9yPHLmh
   au7GpKXrrFZ8hoMk01cBaey3gYQzYweiJwj+gcTbs+BN/SKZ0QDfq1GGo
   KRGOpR7Jp4BIRwmQRiAqzVR75ol8dSlMyXRec5f97r2/ZH6cSnsuH5oMP
   vZuYfJfRukn2Jh+kBVkzxTf1zYg0dDpkq2nG9tiRoKC8xPmWgdQECObis
   qtzbggNZZ/JDFlQwcej0wY8y5VUED6K+2jazy5e/vLCB15q5ExLpktnWg
   Pu4xvfQYhvrKnBKW+H3SNaqEdQ7GvWOS8y/VZhY1MAYfTQU/5h/JmoZAp
   A==;
X-CSE-ConnectionGUID: yy4jLDgXTBSxWEuKjF60pw==
X-CSE-MsgGUID: JNRJND09R0+F+VYVmJvXzA==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="134413861"
Received: from mail-westus2azon11012041.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.41])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 23:18:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/cxzth8VjsZzmg5wC5RIH3lnzLb3lJudhAxY29aUO165IZG22EcCsOHwovVdFP/vbZ8eE6CHaGnfD/S1iQMKqoTDSZ/uYxYxSE4H0n5JwXTZeCopuoHXIl+YGP3Rq7LCSOs9nR2kiNNMipyFPa1XttLla+LqSvgXvKKUZJuRI8QwtcGkzQcGSIMqwqMFgOg7aKqdJ144kBS0buP0FD8pJtht0HvYxnlK+g45VyApoCJXhSiHKYTyfsUYyzQz8lxpwzTolo5H0L4P75YYI20ftfVTepay6BusOOtxftuc3l60rMrTrVKW6ZR3Tdl6A3JqSCBxwAINQy0/MtgYsSy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=M1LR8ClrRq/FdSMjZgeVMReIvYfvnAF009dCjdc7kUGzpD6CCIH+mBGsZLUFsCmIIwGXbhmCUgHWnQIlDTLdK28Bhr9z6ODyKqbAxqKMrsHw3u0WWk47k3kIZdONBGlrvK55/5DLVugTEDuKLKTDrccidtUXgwt6ZR4DaXMxqR/OVBynu0FNBIOS54JUYLDG4EmO4UKpR7Gp0V6Ii7gT+h/WOdqD7zrpkx0CbAL8nlknLsBGh3W+cF6MSjJxGdPK/G8z7Sf3Hrx/nRiFCNB5VO2MgAnB2xqMGfLXfrFPcbhtoS9KhAsTluRzgyREqEDrFAYHzg9Nt/6Id/yyHk9+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=FazWLYQnIqKFpV0tnd/CSxBvFJplqd7ZEG3kvlkcBmycYThe0p3LmDshtgTjRts9TECKoXPdnulKkajaQsE9nvNCvlggmeFbg1sLhiYFFlQ3etFdZW/0GG5J9q6PZYz9LKg+ErgRDzO9J8jZUM6wIN+oA3j0bRVDEY54aZC8HVg=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BY1PR04MB9636.namprd04.prod.outlook.com (2603:10b6:a03:5b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 3 Nov
 2025 15:18:02 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:18:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, hch <hch@lst.de>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, Mike Snitzer <snitzer@kernel.org>, Mikulas
 Patocka <mpatocka@redhat.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v2 12/15] block: improve zone_wplugs debugfs attribute
 output
Thread-Topic: [PATCH v2 12/15] block: improve zone_wplugs debugfs attribute
 output
Thread-Index: AQHcTMftulHzaaWYrkGVolq8vB1xWLThEIaA
Date: Mon, 3 Nov 2025 15:18:02 +0000
Message-ID: <2cedabc2-c982-4779-b9ca-619dd5a04acd@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-13-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-13-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BY1PR04MB9636:EE_
x-ms-office365-filtering-correlation-id: 2e5bd352-1d6c-4579-9c95-08de1aec2e35
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|19092799006|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkJOM3FlODJDTTB2eUpCY3U0UjFsR0txcnZVL3h4alNoUUZxQXYzK29lMDBv?=
 =?utf-8?B?Ny9heGlrblBRT1FYQzBPdlE2WGxEKy9RVkdRTU1kL2swWlVhbGltTENoQlZw?=
 =?utf-8?B?OWhBNzNWK3FHb3VBMnpKaWloTEs5QWRLUFpEL3pyVlZQNnNYM1p5OW4wbUxB?=
 =?utf-8?B?N015L1I1MTJBZkRSQkVEUVNDSVhTSmN6eDZmdjU0SW0xa0c0emJySEdKRXdF?=
 =?utf-8?B?clMxMEV3OGZGYjNoZWdOZTJubE1ZV0JmdG9rR3VjTThhS1FGM1p3NVlITUp2?=
 =?utf-8?B?c1VxUGF5eUYyWHNiWTVqZ2diSDAyTE5TWmdnbXRuUWZ6dWJaRE5FeWFTQUsr?=
 =?utf-8?B?QjhxazVuaEhwaW55K1M0clk1WG5veTZVK0JhVHZlbitON1hFdFczUEYxVHNG?=
 =?utf-8?B?TlpITmcvcVBkcVUvNjFuYkUvSHRra1UzK25lOFFhc2FoMEFmeUQva3VoODcz?=
 =?utf-8?B?UXBveGY3YUpsN2Z2UUNHcGhQamNFZ0RVTzVMc0cvaWlkUjh3UXd6WHMvQ0Ra?=
 =?utf-8?B?ZlV4SXFDUTBPUmpSZ2tIc2xEQ3lFNHczeVZyWERieDRyZzlXZmorTmE5aEk0?=
 =?utf-8?B?ZmovSUh5eC9xU3JFa3dqai9lZlJ2am1sTWhSSmZtcWMwZGxrNnVpL1MvVWtz?=
 =?utf-8?B?RzVkK1FsVHV4V0Y5ZEFJb1RsRi9xODExNmFXcXE1NHJIdEFEV0lTU3lGT1Zv?=
 =?utf-8?B?d1R4bU9uNWhldkFaTUZ5dERqb1NMc056cXdNMmlRNWx1TEw1NUpQQUt2UmJv?=
 =?utf-8?B?R0N3SG5lcTNFdjdad1BZR1EyZU5QR1NyUlR5c3prbzdOcGpZK09sMTQrNC9P?=
 =?utf-8?B?blQwUGFzVkNHTThSeDFpUnZIdlNXaFNWcGxBZFFUQmFpY3R3Q2xwckEyWWtQ?=
 =?utf-8?B?OTRlOU5pdHh2a1ZjZFppV2hWVWJpVGRDd1ROcXdzZmFrQ2ZGSUk3bVJQd1Fq?=
 =?utf-8?B?Mndtek9XQzVjN3NUQnpmMTRPZXdGZEdhTUN3MFpkUmU2YnhmL3dwd1hmU2sz?=
 =?utf-8?B?b1lHQk93UDhVVG9GVlN4YXZlTUlhajRYajB2bEtKU2hSckVTS1pmeWgrWUFS?=
 =?utf-8?B?aVpRMnJQMnc4RFcyeVFrRlhMelVEb1VMcktDcHZHaFBhNE5rdlA0N05jVDFU?=
 =?utf-8?B?WWQ3aVFyU05EcEdKMlR3QXU1WEZnRU16ejVuQy9jOTJIM24xT25zM0NFK3V1?=
 =?utf-8?B?d214ZFFiOUR0OVh4aVY5dTY2eWErT2RIb3BpRHV1QnhtVkVtL1ZhUXVJcGJL?=
 =?utf-8?B?ajNkUzNrU25xd1NpS2tQR2VoWFRlNDZ0bVZNM2dPMTkraHVaeW1YMDRjRWNJ?=
 =?utf-8?B?ZDhmeWxSZ0Y5Zlp5bjlOWEdqdy9XUGJsanM2ZXBFSVRrRGxxSFVlSWxTOGtF?=
 =?utf-8?B?Mk1DVVdNQko5Q09JcC9PakV4NWtNWmV5OUR5SmdxZUc5ZUQxNjRqOU41c3No?=
 =?utf-8?B?UHBKdjBIaU1pWFhYdUpCNmN6ejIycHFtKzJzVE1TUzU1OFN5UDR5aDlQR09X?=
 =?utf-8?B?aXV5K3BrcVZ3TlNqZCtWS1A1SVU0aVc4aWd0MDliT2ZySHZCTEp5VzVucTBs?=
 =?utf-8?B?K2U1aGhWNTR2U1pGRU9ETUxzd3BCWnVkMHVGNzl4cTJ3bUNqYkJyZG5MY1Qz?=
 =?utf-8?B?TGh1L2FOczdNbEhTV011QUdwakRVWXYrUWwweS9QQzlSbFdSQmZ6dEtVNjQ1?=
 =?utf-8?B?aHE3Wk1XeFZ2NUFub2lOVlN3YW1SVEJQMTRTWDBGTWxHN2QyMUNFRnJhRXJi?=
 =?utf-8?B?NTZuK2hhb3grUUpMVHQzbnhJR2doQVVGbFN4aHlvaWo5RFJLVjdYdVM0Tk82?=
 =?utf-8?B?V1kzQnJGK2p5ajNPVWt4L29YdDRzUnphRHR4VmFFdFNqWm1pSCtCUVAvSU43?=
 =?utf-8?B?ck9sOXRYWDRydnhBM0s2V0ZTclNyOUR3N0VOaUltVnNTdEJ4czVwVUU2WmRF?=
 =?utf-8?B?RURuYUN0aUtsNnlCTXBVazRBZHFad3MvMGFETHVxVlA1UzBRZUczeHNnV1JM?=
 =?utf-8?B?RnN1SG1DMklQbkwxRkRaZ3FvVmNTMXJHeVV1QW1LQ2JOa3EvRzZPNFdMMDZa?=
 =?utf-8?B?MEQzUnZRK3ZXU1hPZFdacVhvUUg5d3B5cm5ZZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(19092799006)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkdGQXpXOGZ5Wm9hOFBDUlNnSmFzUHpGdWdRMGd1MWFnWnppUGpDRTdZR1ZQ?=
 =?utf-8?B?T2hhNm9KVlBJVzZqR2cyR3A1VmNra2hKUi9JZHc2Y3hKYU13UDV0VEczeW1x?=
 =?utf-8?B?bGZNT1NMRzFUNE5LYkthUHZaWDJ4ejlnbmpXZFc3ckRZNWdoZ0ovaENkQTNv?=
 =?utf-8?B?clJ1QkZEbmhYMHRsSGFpNEhtVzdPTlJod2Zuai8ySTIyb2RRRjNJNVJJZ1NP?=
 =?utf-8?B?eUxwL0RJSjN6OWFFWWpkUytWSC9SSGg4NzhIOTB0MFJqWFdmdjF0VHdCbDJI?=
 =?utf-8?B?dU9sY2pReTlJZytlUHBMWmNnK3JYejJLZTd2VGVRUnl2ekI2UHYydHJvYUtk?=
 =?utf-8?B?YXFKbk0vVGp4bTlMV0dvU0ZUaHBld2V1TXNoczVyY0FsZlVOeUxzS2d2QkNk?=
 =?utf-8?B?RndybEZHU01XekJ1TUh0cmZEMFY5WVBjQmozdWdXV29yOXNkMFQ5K09YUkY4?=
 =?utf-8?B?S0RwL0VwalkxWCtEbG1qbnR6RmNsZmc1LzVRNTJoaFBGWVJ6bDJlNXBkbjlJ?=
 =?utf-8?B?RFY2ajlHQnROeHhFemsrdjBwdUc4RWNUQVFOMnBmQkNpbWRZNlpvaEJ0aG5Q?=
 =?utf-8?B?SnFYdmIxYW5xQ1VtTUNneFlJZkF0Q1p3dUI0bFFjc2x0dzZ6VDhqTnBNUnVQ?=
 =?utf-8?B?eDVPSVdxK3QvOE5nRzFvR3NsZ2J6ZmloU0VMelRMaDRTekxIeFQ4emZXSzVk?=
 =?utf-8?B?VHlXZ2ppaElwei9veWtvamVrY1crZXRBYkFyTjl5Mm9XWXZwbDdaUlZLcWYv?=
 =?utf-8?B?OFlrV3hVU3Z3R096Z3hyZ3c4SC9vUHhESFhKWEdxbm4rQmlxTm81dkp5bFgz?=
 =?utf-8?B?bmRjaW1PVVZEV1dETFJwZ21GUnRTTnY3YTNDb0JzYzZ5eEV3dThSVTY2VGFl?=
 =?utf-8?B?eENjdWQ5UWVlWHNxVVpPZkRRZHhzcHIvalJINGZaRGx2RThSQk9JNkVPcEZ5?=
 =?utf-8?B?VnErMkFyWDJsSnBSWkltSW5CZWJJZmRtdWxteHBJZGU5d3Q1VERxR1E5TzJW?=
 =?utf-8?B?K2xOV25xWFV6QmVGQkczQlg4eTlpYzhvOTRUbW1IeXNjN243MmQ0VVlDODBk?=
 =?utf-8?B?eHBYSnpWSXZ3MllmT0lRYldKOTNhaDRRU2UxbjgvTWdjYnVCcjNML0VydVJP?=
 =?utf-8?B?RmVGNkMwYUJOMVN0UnRNd0paeG9KQUtheFNQM0g2YVRocDhXRmVVTFkxenZa?=
 =?utf-8?B?TFhsNTkrN2tNdUV2VkRkdTlCVzkzNWJILy9GeUljaHN5TXMySHg0M1locUdG?=
 =?utf-8?B?c0FLVkczTXlJWUVWbCtBeU15cWRBZGp5NmI4bkdtQUxkSGJlQ01rd0NKQ25P?=
 =?utf-8?B?VDlZL05USmQ1dEthR05RMUp5Rk5vaEhFTld5NFRFRlZFdCtJVnMyVnVETGhX?=
 =?utf-8?B?akRBbHd5OG5yN0NpVVNSVHI3elJFem9DckU2VjZKSFY1L2tDdFIxSnpDZDBm?=
 =?utf-8?B?TDRNaGlabmxVeUwvckNaK3d3OVpCNTFxVXAveUlrZDlaMU9HUWMwQ2FmSGxk?=
 =?utf-8?B?M2Y3Z2VaeWhGZ1pYb3BYdWxTSWkrSzhjMU1ra1JQb1lrSTBYOC9Ibk9lSTJi?=
 =?utf-8?B?YllDbG1KQkVNb012TVVYU0Q2dkxkNnc2WlVHc0Y3S1lXL2psWnVXWGJxRWxJ?=
 =?utf-8?B?K3NpYytWcU8wd3N4NS83amdVdXJidUVpSkpMc25TaFdFSUt2SjBaL1FuWnEw?=
 =?utf-8?B?bHBvSFp6M3dEeVcwVVdDQXY4YWFFQ2ZlRWVwV1ZhYkFsRHkvN29UanB0V29l?=
 =?utf-8?B?S1dWRVhxdjFkVExEKzNuTmRNYTNScmdxT1dFSmNyb0FMV2VHV3NBVEJ3TFRm?=
 =?utf-8?B?NG53U0JrbGFqZ3pGL2NidzV6M2g4dHFXRDM1U2dSbzdOaElrbkV2aVBuSmpi?=
 =?utf-8?B?UjErRVBKSFFVcG5QMVZzOHNla3NteEdWNzhqem9VWGdJVUwzZ0tQUDJUOGJv?=
 =?utf-8?B?Y3pJUjlPaGJoV0tTOVdadmY0N25pZ1djR2I4emJzQnRxOFFmaUhOMGg3Y3Nh?=
 =?utf-8?B?MnI3WTltZ2JVMy9QR2w2U21TaDVVTWRVM1pQS1ovbHV6eFZjT01VMU9RYmJB?=
 =?utf-8?B?ampTNENJdnVkTURBS0ZzS2Y2K0JmYVVoZnRDdmRrbzJZd2dSMVVkY1VxUUxy?=
 =?utf-8?B?cThvSk5qcjhKTVlYUkFvMGF6UGl0R0c3U0NFUUVQcitHR0VjVjVQdVdYS3ZX?=
 =?utf-8?B?bXpLS291d3paWVY5VEVUMElSSzR1N1BjQ1dHNG9ZQnNDVUxVc2Q1TGFvbkpJ?=
 =?utf-8?B?OTVGTU5DMEpmd2dNMkEzSFl3MXJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <168D4B470DB3FC42A5208AC478E8D7DF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xZlc25yy2UcczppAk8Gv0qe235BMJberCS4xmbvQgpi7VTuTMSl1AIaTVr+9aH27XQO4fFDsqFQpVTXb+DAFLhxX0lo5RE3XnZP0dYdgXLeJSz8n4NYFQxrHJ0jycRxLL84D+0oohxd1DXpsDLClLaIjj4kIrQxf6HOTyd9Ij/uDHSRKDVBo6Pe6c8Qy/6le+Uwd0mdAxXZcpUtarViMykOUgV5po2ExF5CCoFwcBbaMet49UdQ8lfMoAzVi4IhwqBHF9kidbg6SmeYjhoHBghlLes22/aSTrgyHIyo9mOXCzwL5g0oC5HFbfFUWoLdroJVG3lki8YhCa9s85WPO2+GP/zPDzTx0Vy9Ggz6mZguNxUR89UKBchsopY1NUUSXeILqRpIe96v0odheh/41cntx2PPP7S0SHgzDtb9T4u8fTq36qCwlomvRX/s1d+waz/PdEYrskmZAsSorEwr+73hdO7h8cqcogQ+OV9O325OJKTjqAH3iIrkrlj1tZgC79HoT7sQp3MCTS8ULeMFeghWP7jNXdrkcvMHufr9u+qEFS1BWiDJK77oc+ekYAAkrdLS1nDf7yDvqWQIYyMoYybHV0ZFXFCmJrWtVbT5D0w0lb8yxsHqYsvG1dNkr4B9i
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5bd352-1d6c-4579-9c95-08de1aec2e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:18:02.2650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlR36cI+r6ZqfpgiawFHjum5KIn5sGsPJ0BH9Pvy2dICunS7zO0bsUkrO0sbNBHffZ6Zx5E8g4CHNePn012nI2guE0w9mRJGYeW5GBbi57w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9636

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


Return-Path: <linux-btrfs+bounces-18572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A47C2C57C
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 15:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F064247E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B6030E0FF;
	Mon,  3 Nov 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="heO1Sr0f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rD7yAElr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9D2FF64C;
	Mon,  3 Nov 2025 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178506; cv=fail; b=F16YQCEc2pwzEvMCIp+12QpYVDUQrzt0HHwIIUBk4jbzF6rZP/7NGhjKOFw9lPfabkHNfRDtWgK7L/rXODO5i6IFEVn4Zy79qu3j80XpOrPR1AxI1ZWr3q2njrhpzu9/nlIOVREJNnOSksaTLfqphQy6sIznp5z17AKGAxDuy8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178506; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HGE+pBrkBCK/unvC+ulnooSeHqh6B3mLGE8YiJFGKm+zw23vNUGhsg7TCogOB4lZsnUSIDe/ECi0tf9gvK/JNkVQkL61ALV0XHoa/h1JjxkgDwgt9xG2a818OPFNmsIL10fTO0FbSXbmevajhTeLlt6FInjb6Jwiy/NHGQKuLrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=heO1Sr0f; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rD7yAElr; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762178505; x=1793714505;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=heO1Sr0fkrYw8fDP66lxGLKw1PT3p7zXouMJHblPnqEHeVWcceAl8zk0
   y0ltHPkmtPBCsHqsxw3g2XA1v/CqqFjoWHw7ify+Z0AOqfWMmY+Wj1pbx
   hOgnsRqOibMymV40PjQe/beDl0yxsbhmDwi2fw/nliknO1KyLpOhE+nOw
   uRVdl+g+8U/hqCQloEagXaQnHBht64J22+RU1958sW+1fWaKChwFpcHaR
   gy2cYMRpM8OJEahmzh3mP1/ZrJPG6a7LIA5uJ/NZDDgM5JYCqk8bLbGJW
   dF+Tlmxoh6A/wcLQKyqSNgwI7fE93Km8OG6Ewe/z38buvH2olm9hDejnF
   Q==;
X-CSE-ConnectionGUID: h449ZviVRoGidDg5JaP2Iw==
X-CSE-MsgGUID: pshXafFAT6m1uElmFb7yig==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="131392444"
Received: from mail-northcentralusazon11010012.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.12])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 22:01:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VB1lNN7p7nf5TJ2+cqsstfTcmHn/gCew5bJlFn6qCNnj+8/R8bAM1rfQJli3uxX8HeslYubnrLr1FKD3jtXccwOHVP6lrUneaINdjQ3pH0ceuKRQPsW1fWyeaNte0gHnBck4Iq11RVBiuNKoMH5CjubmRhyon31RHtWeEfnR/ynIZP82oEPrtCY9hHm8bEMIfbVz3minJ86a6WS5A7Rp5UkcxgYieqoRrdWsD10ME7gBc+6Dvo6xNdcaKtDUZ/PCV2ihZkkyGQaYq/f7B7yt/JpY+LC0AClamGNQGvgTfcRV0/f831YbC/PDbZ64ZXZgGKLRuDxi5xtg09JoVTTp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=M0NNrZOHkYQsjrOcQxEN6UmTqky0qEeQC7nVtOWuO853OWS8ZTW0aDr6EhzNY5YVF8QMeJvnc9wOxaoQGL5E4UBSMFPVJVlwEzD4Q/z0wRBfl0utR1PkU/4z4b4ayTEzV6J+KhmesjpfYCxYoul4V87uuKVmxEuusj5cM2USiLL3cXMlnxllAuwDqhVpyuRkMPqTcvdJIbx6w3BxZSNsbIsfUwbJ1PtcEcH0e/hODO8EVpOzDikWG0urV2i+38VoUx+aJ9aXYVhHHc5nxlFRNbAV/uLspK3SIT9+B/biext6quavBCzoXnJhqA06VrH3wy0SazMwiMQArO1oG4HquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=rD7yAElrehT44ywXpXQq55dHgq3tFGC6AoPkhwaDoqIqJ3MztxrlQuHnBxU9tX4+wpNbUC1Or8tjJmA8elW6tRQBv2tAf0y4CQqGZxDyO9GBNx1E+KUZzLzcE+OJms+nswF94yYzWScV5RYvrYKzKs7yAwIdFV9oIZx38K1UyZM=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by IA0PR04MB8909.namprd04.prod.outlook.com (2603:10b6:208:484::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:01:42 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 14:01:41 +0000
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
Subject: Re: [PATCH v2 05/15] block: reorganize struct blk_zone_wplug
Thread-Topic: [PATCH v2 05/15] block: reorganize struct blk_zone_wplug
Thread-Index: AQHcTMbk/Jd0xX9icEG1tdL5Iwuj6bTg+zSA
Date: Mon, 3 Nov 2025 14:01:41 +0000
Message-ID: <847269c0-1de9-49fc-b545-e2f14f996bb4@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-6-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-6-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|IA0PR04MB8909:EE_
x-ms-office365-filtering-correlation-id: 816405cd-fffe-4614-b649-08de1ae18412
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|10070799003|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eE13RWFjbmorRDFMZzJwTUEySlJLWXZ2RHFVTzE2UWlkVU53dmc4YWlZZHYv?=
 =?utf-8?B?dW0wSy9iQzV1cHNHSEZlbFpRYXhXUWcyQlpuMk8zdGFFY1VCY2tJb1ZiQXFs?=
 =?utf-8?B?ZnFDUHhRcFhCRUNLZjdaRG9UbUwwNU44bHEzWXNJM2cxNWNpbWE3WnUxSUZT?=
 =?utf-8?B?WmtHRlhha3Y0dWZiRUVoRmw4QW52MS9KWFNLYVBtejBQU292dnZIa0JHam9P?=
 =?utf-8?B?QXZFbFFWaVVxeWFwKzV1dTVmQXlneHdRcVVlZEZqQVBUSldkK3lwMFE4SDIy?=
 =?utf-8?B?eEw0RXkzeWZZaU1HSE1za0wvaUVJQzlFNDFCWjEzUjNHM00rcllwejc2TThD?=
 =?utf-8?B?NjRJVmhXdU9mVHJza2FnbVJxNHMybzBRdFA5ZlNWOFFxZ3FoNnZNOGxzcjA2?=
 =?utf-8?B?Uk1QQmpzZG1Makh2cENYMzVLazN6bEpaZHE5d0grYWZ3TVFaSS8ybFFMSEJp?=
 =?utf-8?B?aEhzUXNsQ2l3MG5sWWZmYU13QWM0WVhEOTBsTkx6RnlJaVB2Y09ndTFoRmIy?=
 =?utf-8?B?VXA5V1V6TWNJVWl2eGJWSElFSW0wcHlBVDd5Y0ErNDh3eEFxTkk1NmxZd0Zj?=
 =?utf-8?B?ZnZ0c2tXYWZuY3BUcTErTGZ1NHpUS0J1V2duQTRDOVUvRFpBTjVKQ1ZnUlBy?=
 =?utf-8?B?L0NGRk1qMTVrcnBkaFlSN1p0eUcva1pPU29zOWxmd0Q5N1VyNkQ5amp3cm9u?=
 =?utf-8?B?VGJNREw2K1hmV2MyYVB4ekhRRUF4U0VBWmZqODVibTRSODhVUUtJdGhZV3BD?=
 =?utf-8?B?USsvUFBhS2J6REdxUXpCSlhKeWZnc0w1bVd3Q1BteG02NkFBdGQzNzhzc21P?=
 =?utf-8?B?VU8rV0ltMnY1eWhnZW9icys4ZkNTMVJzVzZ4ejhmZXZ0SGF2S09CUFQ5VmpJ?=
 =?utf-8?B?V1B3YnZhNUMrMHdleFZndGdOU0R3RzR0VWR5UkxCRldpTkw3cWVoY04wcW0x?=
 =?utf-8?B?WEhDR2RxQ0p2TzlLbHRnQzhjbGZMalV3TnRlaytMTERHZWR0TVZtcGU0NXRn?=
 =?utf-8?B?V0E0ODVvcGtLcHFiUjZvTWdxc0JsdjZneUhlNURtNTcrTW1iY0tGUjQ2SWpE?=
 =?utf-8?B?T1FkUnMxRzBSdlp1K1hTT0lQcUNZZ0dtcGRWNlBadU1EZTRCM3JnQUdaaW9G?=
 =?utf-8?B?a0ZmeHdtMjRhOWZ5eXFyUVVhVUQ2MERoWUwvc3ZwbmtXeGRCQ0ZPTEl4N21z?=
 =?utf-8?B?NmFSR1N3bC9DWDJ6YytLc0poTjlWalhRWER2WTRubUdmUXJWOXlldHBZS3Zw?=
 =?utf-8?B?c3h4V1lRL0NWUTJHVDJnMno3VmlJaWhVNllrMGF5aGJTMFdHTGxkSDFxbTY3?=
 =?utf-8?B?eXpza0hPaWFYbXY2aDhMbGhXNWw2eU5RNXllSlNaL3JhQnB1V05hZkE0K3l2?=
 =?utf-8?B?cGhHcDNhZ1Bqa1NSUzBxa2ZPSThlNGNVNURZRGQ2aURHc3dSanZyZmJQanlH?=
 =?utf-8?B?cWM4S1p6MVNjQkpobVM0aEFNUEhvNUJsamhiTVJrbWlIVUdDQjdiVzZtV2xl?=
 =?utf-8?B?aUNQZkhTRHl0RkZJNm1XY2Npa1VTenYvQ0MwYnpWQ21ZZFJYbmN4eTV6Ylla?=
 =?utf-8?B?dzcvTnRtdzZvYkMxRW5XdlJDSU9SNFN6THVwc0VBOFZoZnpuOExhSXd4djkx?=
 =?utf-8?B?b3cyL3NpakF3ZGF0ZWt0QWtNMzVzcFhVZUd4cVZ5b1BSTm5FbW4yN1NGeW01?=
 =?utf-8?B?UkRlbnY2aDV0c1FKV2JCZm1HSHZjK2xqN0tYbTlrTEtmcEF6RDRvUUx3OC9y?=
 =?utf-8?B?enZLVTNHS213a2ZZaVB3dDFkeXpydWlyRlpMWnNRcFNaczVXcDhpT0lWanla?=
 =?utf-8?B?NjdkWTM1eC9Ub0tJUlBva0ZPN2dFemZpMVlaRzFSNk0rN1BOYXdOVExuM01Z?=
 =?utf-8?B?d0hEZVFteWU5YjR5NG81NzhkRS9sY2xBcUFHcjRKdC9Sc0R2aGFxYzJJbTFF?=
 =?utf-8?B?ejJvU1JEcUpjZVNteER6TFAzTXUyTHNQUi9oWFVJaEpxV3JmRDV1N2JJekxM?=
 =?utf-8?B?ZzFvdldqZDErVVZ5SDRKSjFvNmRFOEF0ZHRGRE9PM2FTUzdwUFc4Y1lNQjlG?=
 =?utf-8?B?R2VNSGhMc3VVRG5pYWVLeE9hdlZKYmZVMHNHdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(10070799003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czFxbmp1bTk5SDVyLy9OeFBrRlc1SVFxd0NqbXEzTmRBcnZhV3NvbGkvdnFL?=
 =?utf-8?B?Y0lhUm9tQzdNcWFnZ0lnVlkzMGRKM21EUStWbmlTTnRXelFBa3dzWlRHQ0dI?=
 =?utf-8?B?dTBTd1ZkcFNjNTRoVHdOWXhrak9GeFEzYTkwWmppeWJkTENIRDE3Y2s5ek8v?=
 =?utf-8?B?ZCtNQTZXaklhUHVCdXlDNUVkVG1oWE84aUxPb3U1OHJkZWdzSDB3UEJMOVdN?=
 =?utf-8?B?UFhpN3B6clc3NmxCOU8rc2JqZXFiekM3M0pFZG9IVnUyMkMwakhUNWx6THJx?=
 =?utf-8?B?RDVlYzlteWVOZ0lESG5oMGx5VCtLT0d5R2EyVWowUC8zWUE0RDhOdUtNMURK?=
 =?utf-8?B?SFZ5Z2ZZM3FBdFJweUdUL2NrVTNLN0NEeTRIVmNYN0E2VGNYeEJ2Mk1ZQjB4?=
 =?utf-8?B?Y2hrUWdLcE14WUVTSGp2UGFVLzlEVVFicm9vU1RmNWZCclR4S0xraVhEOTZN?=
 =?utf-8?B?ZGcrdjdJNnRXNzI3SWRzUzR5ZnlTc3QybUwvcXZLUUkzZXlnUnlKWHVlNHFE?=
 =?utf-8?B?ZGx1TFoxMUVxcUl1cC82Uzc1a00rSWFCVk9QZ0xqYVBxYlRyNTRjTWVLZkoy?=
 =?utf-8?B?QkJ3SW1uc3pzTUFQT0g4SGx6TmFyNHlNR3BUUEpDZFM5U29UVDQ1ZXN5MzVy?=
 =?utf-8?B?RGxITkxmTmFSVStxVStGTGNiVGNWdTRJblpzVzA2dUdMOFY0VE0zd1Z5SzlI?=
 =?utf-8?B?ZndQdzQzRzlKYzRTMm1wc05XcFcwOHBSb09tazJIZm05K3JiMzVneTBvbFJW?=
 =?utf-8?B?aFRVazRGTnJ0dGUrU3ljaWR3R0paM2o1RExveGN5STZKVUtVdE8rK2N5RGJ6?=
 =?utf-8?B?YVBrUU5HUTNwazRUOUY3ZXhsSHloNFJNY01PYUNEbDVINmgvNlphV1U3UFBS?=
 =?utf-8?B?UFI1QisvTGwrc1M2OVlOdzdzV05EYTB6dGNRN3pKU0ZLb3d4SVpHWkJlSE13?=
 =?utf-8?B?bWJvUlB1UFBhK21iUVpXS2piQm9ETGMzdGp1UnVGRG1MVTl4ODhIenlCcW9U?=
 =?utf-8?B?Q2E1d2Z2TDFRTVpxK1BnMUpLMFIzUnpOWU5IYXhqckRFUHV4WVhnYVljTnMx?=
 =?utf-8?B?MWk4WDRDN2NIUHRDYWowN0tiNWNwVVBVN2pNUGszOXRackd5ckZEcXV5YWhv?=
 =?utf-8?B?Qkdrd0NoZUNtajFkUC84aDB5SnA0SGtNcXJqVW1JemtwRzQ4Rk44NC9oOS8w?=
 =?utf-8?B?WXJEWGV2Q2FVL2NLZ3JJeGdBU2VaNFE5OFg5Q1daWmJkNS92Rjg2RlFYTjVB?=
 =?utf-8?B?SU42cWJOdDZtdXBZQU5JbXlEa1dZVkhvZmZNZkQ0M3ZrRWo5NXBGUTVycTRN?=
 =?utf-8?B?TnQrNkFxMHpmaVB5NUMrUzJ1cXZjS2VTVW1lZDNNRW9FcU9oZTRBSjJ0TG5j?=
 =?utf-8?B?b0lVRzZpekJqalZzbnRQcmVCbWVTN3JBWE5aY05ZZVpqNU8vcGZNQ1NpWVp4?=
 =?utf-8?B?dFg5dzcycTgreitaQk0xWXhYek1iUFB5Znoxdk9zZU1tS2dpOWVENTNuaTBq?=
 =?utf-8?B?Ny8rVTkrMXNPSmJDKzV3b3FnOGdPVE9Jc1NhdENRV2dlMGUwSEZxc0N3NTkz?=
 =?utf-8?B?VWR0ajZpY2pPcDJmWUhnZlQ1NzdUTFRyY1VJWVgzWkFSSThmWmQ0aE5KZTdk?=
 =?utf-8?B?aTYyZisza3hZYmU1WEV0VkYvUE9QQWpJaEhqTDF1ZHpGdE5FOG91cEZrREVt?=
 =?utf-8?B?Umk1a2Q5b2NwM1JDd0JiditNWDVsUWVMemRaNFFrSWVIWUVJbG1WUVB4bmMr?=
 =?utf-8?B?czMvWVNyb0dWbHdkNW9hc1NEUkhrSXNlRUlQV2pjUVhWdkVERWVPTW03Umxk?=
 =?utf-8?B?ZUtRVnovWFpVcTFCZjZoOVlWdTI1SVVDcHFpVEZJNWw4Zk9KbFR0RnRON3Zj?=
 =?utf-8?B?bU5mQzc2Y2g1OTFUNlk4SGwrZkVTUHN2eWhFTUNuNjZTNHRnUGZJT0hlKzhU?=
 =?utf-8?B?YWlXU3hXREY2Z2U2OVdXSmw3bjRKRWsyUnFKSVhYelhnOTliOXc0NHl4cVF6?=
 =?utf-8?B?SmxPdStBL2piWHBaK2ZvRndpVnhiRlpnWEVEQWFYcVpvdDVta3E1ZzlWallz?=
 =?utf-8?B?N1JUN25CZXEyLzg5Q1hkUnl4UGJ5YVo2Wi9nNm9FM2xtZnJubnNxV3MvdkZK?=
 =?utf-8?B?WUhYN2p3azIySXJCeTBFWW9RL0tBSm1NelBPUWcyTVhjeUhMbVd2bUpaQ0Jx?=
 =?utf-8?B?cWcydjZSRmxHamVoL1ZRZE96c1hBMFVtb1Z5Nmwxd0RSQXdyRDQrbm1sbTVN?=
 =?utf-8?B?RW51dnBVTFJjTmRkSThkNWc0SCtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32542424BA424E44ABCCFBCE16235C64@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gGe1kfxA/Mm8OQiMydEC03+gC2yzsm3w8dHe7c9YE3ZtRWV/2YOkiIBCaE5XNd4vB0ElP+koq8yhUvhJa/HtMVb402pYhj4VQSOvQttXPiqB5gRvbP2Pe2//LKId3sLBDR/uX0HPHk4Gr9DEuiezQayEKylfptaNskcwPEC15LUzkOVNVuIIRmHMQSQA8bv1ZKM/McpvjjjlEwiHHOa47G7IZgq877Ke0Ro1MC9B57+TIo4KXP4QFaE+0p1ZrFMM7I3HhkAjrzgT0DEwhX5L6xDfKbafdI/qveaDXl7uz2MjAn3T45cxUvbRyvureyZkDKf9PnV5kcIJLwH1eXvGwyJZoBgdP+0DUGw0T3828vGXg7SA98KPI9sWMXGkf3xmVOQXUX4cWXpeOl+QVE83fGZNUbG+SRksIUogOeZ0DHFEiGk3UcZP6b9lMHdzQ0j2yQg90IvepDlCmx5R0jur7GFoIgAVNurzDGGB/HVJ6vyd7gS2SaylJd00YhpSTaRurdXti+eRPuzB5w7M7CaRNv1CMWsF9fchtlsNdt/mIUQuAFYCwJ4p8NYftY5bUAtdCnHd6DPLHCsrtzwxlJzLaSzzeGfuKiCdhoGqHmGlx+46zmRPKDi4cP/5DkuDD2Xx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816405cd-fffe-4614-b649-08de1ae18412
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 14:01:41.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvRgDik3zVxy8saluOXFj3pEElMGZM0ycIHlhEUpX4WiSjm0givtWahJfnqa7bhPueuA96i2D81f4ySLuTnxa5OPgAcjjFiZSaOSg/jGoqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8909

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


Return-Path: <linux-btrfs+bounces-18570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13982C2C4DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 15:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7CA3A0495
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC59E30C633;
	Mon,  3 Nov 2025 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jkwRWM96";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XkkAQZBe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1EC274B23;
	Mon,  3 Nov 2025 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178161; cv=fail; b=M0Ogl61//+MROKV61rTxwrA2TK505i6Qx9LrjRGZQekSjlu56ILo0ZsA1ttmad3J6L/okSUNQKFZCaYRYx3FVAc8qK7XB1bLvjKZxdr0KY+10+Xm98CBWySIdcVx7diTQRQZH/Zh8CRLFlRSTCh/E4exWVapsi052G+BThY2pSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178161; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ev2wulY/cvzUmKwsPS+p1F/L6XmBwvrS7Lw+/M7kQcCulaM/9cyPKj0eeC5drd19Rqmh5+KUCTd4ZflJ58C0Ew3mZNS1cDFy37VE8ObLEAOwgR0Z3Z2qnK9RuMeb9yJp9pUBVhvc/jJI6G8PieOlnXSujsEUIfbABpih8oO1ivk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jkwRWM96; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XkkAQZBe; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762178159; x=1793714159;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=jkwRWM96oka20fFNa19VorGIAno6Ip/2NVNyLut24b4vSuhqeNo0Cnr6
   CiF1fUk9bshAXoKV7I5UhtIJMDiS1BQ4W6vUa9g38slznoK45w7HebbcZ
   HC5GlRqNaM3lJuhHS6lcnGhaIc1caHBOZ2oADaR05kxKPS/fxXfk27ahq
   HG4p03KDfNmVFFgU2RNZs3UP7agqVT/JJUNLUkrtDC1DNsz29S/rHV7dG
   2ZG0AEN+8UP1/oU9YVfItNTh4ZcGvmdyeEYNdICGa0PM+BnSQrXG4UaqU
   ABXashj8zHVQGILOHPBPipBo1ce/LBCWbwA+wakIeLsoV1MIKjS58pS+q
   Q==;
X-CSE-ConnectionGUID: vVq5fqecTva/6Re87o7sRQ==
X-CSE-MsgGUID: zzNAcrYXRcaAVeLH/2ic1g==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="135673428"
Received: from mail-eastusazon11012023.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.23])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 21:55:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjKXj5FzZYv2fl2ZN4s4jV2lBxTVGJiUVUrDAW9dpHcBgZQaJCl5P54AzmgCotUvDzdztymL2OQGRSTwgWPdfju7kgrDJB41qxNL+z5eEuEpG8RC+3lfghhZzB6S2KSN0m9d59ntHoDBjpBoH0Q1V41eJwHhWtYB0T3mh+bekPdGKIfNZFo+oRveTd5oFON10Ih8LyIf5Ur51mpfN/D1VBWvqD8s0gVhQmXV9mQb5FEXKN+l1Lo197CoXPRltab3gfGwRiC0+I/iovSxnldGecQa5ZRijr5+SKKUvCAr9E03WT7IjOLC/pl9sgQWZUJ1liQC5k4c3qHaCO9V2AKD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=UTw6f2GJh+kRRT/lD7RilGgNcSbffk+S31SajqPoWh+//JLMb7hrUaugaFxPFMtLCcXbiCWEdcwU8PzqiW87vfvFiKoXz2IXRGrDphKEs4vMOUjTK0/DPzTvADlglzuvp4qoBtVg/m3yvPLNieDQ14r0RCFBYu2XbENCAAdCZq9viM5+efNnPsEgK5gIUgEi+cAnRmsxaF4TzdnZB4NqYY1iU3su34xglDXHCy2fCEaDd4lcdZn+a5wNKemglXILSwSaXA41w47WtNpdYD8mjjufFsgS5bgqztWXRnQYtk98ZFmKaRm7bP/yYxuKoxn66pmVdzTRaOiMLLmnmWLAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=XkkAQZBeLKlUrj9EUuIv9coxirlbIyMruK84BVCepl6ibzj/VihoN7Xu22iUc8CjvPLesVj5y+pyvduCGeLZUJtxqVpGEluypXQfnUdGCMJv0fH1MMz7GudlTt8770a2nJZkrp6SRuIC5I2hCFJBuYPknHJHu930JcQv6tWwvfU=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BY5PR04MB6772.namprd04.prod.outlook.com (2603:10b6:a03:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:55:51 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 13:55:51 +0000
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
Subject: Re: [PATCH v2 02/15] block: freeze queue when updating zone resources
Thread-Topic: [PATCH v2 02/15] block: freeze queue when updating zone
 resources
Thread-Index: AQHcTMbJwKXpHebNmU2JYZ2PIK/G3rTg+ZIA
Date: Mon, 3 Nov 2025 13:55:51 +0000
Message-ID: <f8b93b81-e813-4f36-bb06-f5cd503295a8@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-3-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-3-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BY5PR04MB6772:EE_
x-ms-office365-filtering-correlation-id: 79d89601-ede7-4bc8-e6ca-08de1ae0b308
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|10070799003|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHZhaFNjZDl0TWIzVVlUa0RnbDJEUXpqZmxuek5wem9QUUVFOUdyM2h1U0pP?=
 =?utf-8?B?MnhOWWlaTERwekcyRzl0ck5IemFmMlZpVmd0LzB6UjdId0dLZEhqZ0JjRjVO?=
 =?utf-8?B?bkZHYUlIaUFvMW1ZT09odm9qWm5UV2syNEI2d1NGOHBGblFuSVBKbjBsdXAy?=
 =?utf-8?B?SDZkN0VNWTR2U08xVzZlbXRGMlVKT3lhalJSQWVkOHNydjYyb29vaWhNdkRE?=
 =?utf-8?B?WGJ3T0hHUE5IeHEzenVkRlVBc2dCM281L0JqNWx6TFl6R1FwSk03VU5YSmpZ?=
 =?utf-8?B?ZXRsdlowM2VOaHZIVVd2WWJ3Y0swdS9jZ3prYStBamM0R3pUN3I3dG03YU5t?=
 =?utf-8?B?VG9kSnBaOXc2eGorWFZEcGMvVkZjcTl6S2tVZ0ZtSm1XUFJxZFNSVFpGZ1Y4?=
 =?utf-8?B?QXRjVVBxODNYNTV2Z3dKQnNsWVZ4cnc1ZzNZdDdJSEkvT2hncWJaeE1yUzdJ?=
 =?utf-8?B?dTdMV3VyRFVUZlp0eHA0SldwcFhycDdwK2t2RGVRT3djeXJjVWJueWhnVVhJ?=
 =?utf-8?B?c0F6RWppRDFObkgrdjlUR25RcmRRZGFDTDNsbDdndmtjSU1qUllLdnRPWlRn?=
 =?utf-8?B?dGg4NkpWVjdNQkpIZHNBSU1NNHFxM0hlWG9zbEV0T0ZOL0I4UlQxVkVIdHRs?=
 =?utf-8?B?elYvellKcjJlemVTRWc5czhHZ0pxeVZBTndvODBQOTgzTUpIUTdEUlB2U1BM?=
 =?utf-8?B?WVBLVXJlUlJJNXU3NTNkVXlxK1MzRGxOcVpra2Zsd204MERoUEhHL1JxSkM2?=
 =?utf-8?B?d0l0NFlqR1A2Zk9IenJHQllWSWVoTzJibHphb0o0TGVCZDBvdEtsZHRkdVY5?=
 =?utf-8?B?NWVNREpGeUxIZVpVWDhKZDNiaTNHZGZmT3JHc01IaGZzVnNFQnJkQUxpZXhh?=
 =?utf-8?B?ZEFvcjR5Z1BCUE8vU2hpd1c4RHZ4RGxSeFVoTWRrTHR6U0hQdEpPSlhxZkRG?=
 =?utf-8?B?M0JXRXBNRGRKcFQvNXNhMU0zSlZreXFUSTZZOWUxWHV5TTBnWjdIUnNJeVdn?=
 =?utf-8?B?SjhnaDZiZEhjcEg1c0JZSUJWcjBEazdrWGRBNytBZUMxTll1OGZGNndFZTJI?=
 =?utf-8?B?SGh0VG1TL0VjMk5abnhPUVRyNVRQMVBYcmhiVnUyMEx4My9NYWphTjJvdmZk?=
 =?utf-8?B?UlZyOGFmUndORktpdVJudFE0UnJtNHVpakc1QnR2d0VNTlM1V1JqV3FvclNO?=
 =?utf-8?B?NnZ1VDdmR01pZ29RZlNZRGVDRTU4RHFNTjlUVk1GNGJSVGp0eEpBS2pRL0o3?=
 =?utf-8?B?TUVDQ2RNNi9NdFZFWW9rVDRBOStFM01yRHFpTXMwR0VYd3U5bVRlZ21OdlJs?=
 =?utf-8?B?cmNWZXlCVjFLUnUvZHNvYTNhVk1rK254RktCOHRudEhZRFBoQ0w5bWlFazIz?=
 =?utf-8?B?c2hCdzZCSFZIbWNNUUhUQVBvUElBaWlHSUNuZUUyYjhzM1Exb3JVZi9ibk1n?=
 =?utf-8?B?R1hnTlRMdDhBNGRIbGNZbDNFZ3ZibkdPSGhuSDh2aFk1TUViOURNcGx0T0gv?=
 =?utf-8?B?bHNBSHl5WlRsNVBNSXU3WGtEU3lmZFo0Qzh6bzlHak1vbXlVZEQ3NkJJMTVx?=
 =?utf-8?B?ZlM2UUpqcHpEWDdwcnFjQzNGT2lDYjAxRm4rSjVlVlk3OHNZYW56OXZYUWxO?=
 =?utf-8?B?Vkt1dHlEckZjSWplL082OENuUlh3MHNuM3pvejQvemR0YUdtYTVyY3FsQWFL?=
 =?utf-8?B?TnpadWgrRWszTU9aay9VSi9GVVdmVEJjZ3pOWitNdXhuMVRaaFhpQ2xJNXlx?=
 =?utf-8?B?cHN4b29icEtPR3lNTjNMRHVhU01DNVVTUUFVRDFlOVdZSk5wM00ycXJCSnFh?=
 =?utf-8?B?Ym9KQmRGMVpqYWdYakpwODkyZkhzK2JnVXNNL0QyazMzU0FJYUUxQVgramFz?=
 =?utf-8?B?UFo0NEc2Z1NtWVhUbjJQcm9GNjFNTWRwVkFHSi8yU3p6eTFBaTVlT05McnJ5?=
 =?utf-8?B?NUpnbU5SeUxvQ3NnZzR1TUcycWZrM1BBSDlobEszSnpOc29mSW5TOW1Nb3ZV?=
 =?utf-8?B?VENuK1ZJazIxajhTMlNWOURnQ1NDb1JnVGF4VGZuN0dPRFBQbnk1blY4RWp6?=
 =?utf-8?B?VUxpUUZwNGxBMWJwVnB5cDd6bHBGSW1hbjBzQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(10070799003)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWV5S2hWTTk5QWI5RlpxcnloM3VrcU1DbmYrbVhGWUF1Tm5iZUhSbW0zOUxr?=
 =?utf-8?B?OXEzd1o0ZUgxdzFyTkhvMjJKdXp6S1FmNzdMdHYxTWFSZU41bUFZd0oxdHhR?=
 =?utf-8?B?WlVjNmw0WG1VdDBKN0kyRUxScjBUSEpBNFRsNDFRcHpkUk05UDRLVWVCbjk5?=
 =?utf-8?B?UjhBT0lmOTM3RUZscGF2b3VXa2tSZkF6MUd2Slo1cDlOVWRiaHQ3ZDg3bkM0?=
 =?utf-8?B?c2Q0MlB3eVZLVXZ6WDZwR2VINnZnb1RkaWFUUDBSL3FReE9CWXdpZlJUMGlv?=
 =?utf-8?B?SWNURG5jbjZOVnNlMmZmSlpsOUZ1dlV5K0xTaDlHakFTb0h1eVI4ZFNMV2Nn?=
 =?utf-8?B?eFBhSHlRZjBDcnZKTFRXZFdGc29LV09KQlJEdXMwL0huYmxtSVNwMzdKSFVY?=
 =?utf-8?B?SThuN0xDeVFjOXdHVVlqSjM3aXJVMnNlWmFQN24xU0ZWUkJCamtxd3lNM0hW?=
 =?utf-8?B?ZDFGT1pNU3hjTXcwb0RNSjliODA2Rk54SjFtd1IvaVJxdHA4ejBJVUkxQVdY?=
 =?utf-8?B?NFhVR3ljT2txaTAzYzVteUVJSEEyUHhxWVRPeFo4L1IrejRQay8vZTZPak9K?=
 =?utf-8?B?MDdWQkdNRm1sOEE0M29hMVhub1JmU3preElvTDBBUHkwa1k0dkxrd0Y2K2Jl?=
 =?utf-8?B?QjJlVGNqdm4zRWJGVENHZXZleFVvS0tQamI3amdjSWtRdVorTHA3Ykk5clhv?=
 =?utf-8?B?NFZYTjBTOGpMZW1OU3VwL3M3d01UdnNOV29PUlVDNnd3NWNYaUk0bHpFbU5K?=
 =?utf-8?B?QVRLZDJZUGViMHpyVGtiUkRkeEE1b08xQlorME5Qd083dkc1Lys0ZnBrUEpZ?=
 =?utf-8?B?dXBQSWs0d0s3UWQ4dStWSmQ4d056Tk95akJaQ1V2YkVzdER6emFEMlFFOGh4?=
 =?utf-8?B?cTcvTXNWSDNXbDF2QVpleldkR2U5bXdNUGFYVnRIM0pGRUxHQ2U1bmQvQTVX?=
 =?utf-8?B?SVM3SU0rbnhTQ3lnZ2c0NDEwY09DcUlJb21PczRhQVl4eVhIR0RHV1hZdVdk?=
 =?utf-8?B?Y3htM2JsQ2NkbGpoSjM3NzFPRVczcWNXYzEybzBjZFdYaTJrVG9xdWJ6VmRO?=
 =?utf-8?B?MVpJdERIdEtBRU9mZVVDNGJ4K3JsTm1vWThZVFE1UVhtVnI5M3owZzhFY2pt?=
 =?utf-8?B?YVp2OUlYVlJxTXhDc3YxVzdHSjNtTlJXYkI1L25kMXVLNnkzdlFDa3JRUWx1?=
 =?utf-8?B?K0d2RUZ3Z2xmZTRiZDBPbFFqYmplK3dCdS9HN28zbWlyOGR1NHIyTWsrd2VY?=
 =?utf-8?B?RlhSZWtOWG9INmZrWW9tWDloMlFCdnVhMlVuNGJwMEg2b1hsaFRLR2lkUkVN?=
 =?utf-8?B?SmRjanBwN0dYS1ZBNkIvaUFLcXFqeS9xUmZ3dEgzUWczT1RvYmI5bDQxNHZ0?=
 =?utf-8?B?dE5FSjRtcnJ2MUVsYnpGdjE1aXVQS0I3Z04xSEFKQ3ViVFlObVlaN0FLL1RZ?=
 =?utf-8?B?MFVFZ2s2RzdoSzhHSm1ZOThOQUNrTVc0YlZSZitYZUc5RmhybXBxTHBtSzhZ?=
 =?utf-8?B?Yy9QS0Zkd1cwUldkTXJMWnNrLzJvYUFXYk9STjlBWXg2Tm0zV3Y4dzY5K3Mw?=
 =?utf-8?B?ajAxTHhib0Iyc1Z4bWtqTG9EUG5ib3hvM01vNnBNa0dpMmtnY1ZRSU1WdW5l?=
 =?utf-8?B?dVVWMTkyV1VOdmZUeTRGNExHV2pWRGVzUlNiR0M5bGJPY051WHkwV015WDQ0?=
 =?utf-8?B?UFd2UEJFZ0NZRlVtSDlhaDg1SGVVN0hTbWNHWW1ZZmtSQnVyQWk0emtCS2NM?=
 =?utf-8?B?UmM2TXcwb2lYVkhPN1pQTC9IU2IxbXNBNEdSdnVDUE1JeC90cHl3WnRzU0Jk?=
 =?utf-8?B?emFmQXNMOGwydlJmRTJsdTFIdzNNdkQ0bEd5ZUVqVFdGelN4S0pnZW9ZMU9X?=
 =?utf-8?B?dnlGL1JsblRkOG8rckhZNHVTclkxVzU2MDFkMHhOUjVVN0dRa21yc0tNQ1lL?=
 =?utf-8?B?SzJqb2tXWmFvUzhBanBFUG1ZVnd0NVpsRnhJRzVtS0l2UkZpMGg4R1BWQ2Vq?=
 =?utf-8?B?S2V4Z3A5eUI3T21kcmpiWnJjdXZET1pYUnB3Q3Z0S0lOMVFDRHhHd1lVZUlC?=
 =?utf-8?B?VGh6MDFLU051bkwwOTZVTDdGQXU1N2U2aHFtU3ozb1BWUDVlbXJMNm1NL0FQ?=
 =?utf-8?B?U29DTUhpVi8zOW1sWXBzd2xVRDRtMkxKM1M2bnVPU1pmc3haOTFpUnVxNVZi?=
 =?utf-8?B?aXBSNTFQcXVHblQ2ODZ4OGZWK1lXVWdJbXF5OXY3YjNEMnlnUU1kbjE1SFVM?=
 =?utf-8?B?MjEyaWVFTnZ2UmIzMmpKdExNdUlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <310E1A2E956D2442904C5AB16FD288FF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bAt8cOyZqSXFLJUyM8Lc1FvSEynTPeP17GoTmSyVFUetb0J7XJnenDcK8pW+QoXyggrWCWf/VVlTtrAVr/CulDmOdmmbv+Kzw8omWGcgSLSpisnBkx7iiiDHY+IBkPM9VTZ03xVhJTsjgWsly/DnQ3opi0tnqUla3RdGOPmGYdiB3mc8tQ/XiNgtwfcGDNpKVV3ASWObOk+h1d+by3zQ4dgdl5FitHm0NHUlWIj7rmRGfVkPlvCTPoWiy8ZAA8Q2dRvG8AbzuUII4T9Wa81ohPL3zowxJBzCYPh3NytwLJGGoevZtFLnzUH17mLLWhFfnXtjpOrSkYyTWxtMqARjQSSoqfnTQlvYmWgfOyA7XfO+u0Q52My4Wb/xcCgN7piCPfuptnoUZmC51mtLwCwlzy4ARPbHlrgzEkhO2Uvld2X8/Y/e+s1f05GbFuTDLhWVyZjqOM9NWIbpy4jNJ3SFeMBlWRD92b+VP2iexcaqtAEPDq5cLVt1aVKlQXUsNHtqGraY2kbYdUaUOzcYn8ZDFDTrfXz6AQXAGrH/RcGj7jIIoPKGz67W6tzR9HqhUzU/YzUj6c6jKXcwoB21xWflQCsFlTRJjVqEBWABebOpqdWKfhdn36a+evE45weem7pt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d89601-ede7-4bc8-e6ca-08de1ae0b308
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 13:55:51.1754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yhAERD7wuPQcn/gnl7HbKCR/gLlZoVTFfhSZohFzoz60xohZbZKZIV3jWHEQgzh4TCdNTMJixKa5dci71nzVLn0b+Fmq1srQla8GEMdFRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6772

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


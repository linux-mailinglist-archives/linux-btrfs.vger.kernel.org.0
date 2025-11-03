Return-Path: <linux-btrfs+bounces-18580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E14C2CD8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 16:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD21188C254
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CB8317708;
	Mon,  3 Nov 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CEX0zdEO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H1j/WeU0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC714316185;
	Mon,  3 Nov 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183411; cv=fail; b=qCQPr0WtjS4kZX/eB1d4nF1IN7ywJqxqsVrIFZ5bmotklS0+ycO3Yq9MK+NPJGtrNlygIoprRlvxxN/CK/nodJcwHOHscAIdoPd1nFNUYH4laloCA8fccBV/AMinT20Y/PYeyRYTdYeoBd50Z9Xy1SOV0Dv5NeMy2TKRsFCFSzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183411; c=relaxed/simple;
	bh=FG25ZBsnBrcEgxRuE3i86w0WOlgYAdXHmOXBc+maHXA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wc6m6pYiO7bjp7g42Kx/YDrV6dv4ufz2yaN+DZoDYXd2rAIdtUuOdOUjM+F8+UKp/a7hOS3rAcZa4bHp9AQtYK69vygW78IbfYCnKX+Tdw58mCShrSkTkEMZURaA9yEC3uGPAH/jmQOOCW7f9f8BRnkRwL+iFM13uGz3fttnTsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CEX0zdEO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=H1j/WeU0; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762183408; x=1793719408;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=FG25ZBsnBrcEgxRuE3i86w0WOlgYAdXHmOXBc+maHXA=;
  b=CEX0zdEOm/RGFC35ydM3hxw+RJV6Wd5Uw7pZYIdlSVQHYsGCL8EOE4WH
   yu1nV0yNlLBlc6Y+1sarTztsDXAISqtq5+Pu5wmRpv+zrGw19uxBkccuL
   xWNGPsmOOop3f71WznKhOiTPNVCElwi1oZ+14ZU7BindXBzx3nfjV+/ke
   VpeiwgGvB/3xZjhDbjXSsHCH0v8Urj2SkKO56yQ425TgksGGceT+I0SgV
   8LvwDqZqXqjyvhiwRhX6cdIlLF8J6yP53sAfHY8RFF3NQasXZKMHwY0wa
   Cfg9QWodIdOgPLE8FRSf6/CK8YI0lmqcL/emGORCTwH3m/JEbRCqdTSvw
   Q==;
X-CSE-ConnectionGUID: nJMfO0/ASh6+6PW5Rn9dTw==
X-CSE-MsgGUID: e0L3X97iRumMbUfqtg9vPw==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="134048614"
Received: from mail-southcentralusazon11013037.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.37])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 23:23:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG5lA/7GjO6HmYsn4iy8NT461S4sRKqfQyL7e1dHk71+awWjbbOWx+p8JYkHf7Vh+tkUS4cEOQMoxYnnLtGA6rTisMH2pbP6PNfM53bvRdPulDjIHBsBaYxT9OxBXJ9JwQ5Gyj+JsOMSxNq9b0ngP21qfpwFfQunaJ+Jd/ISmu16H6GDiIizgyDwQZtKvkUEt0NC7WwFpmZ+tPkWtc/QNX4wFPocBKPLov3DgP9v5Fwmo410Qra98DskmkiRhB2XoGRIuOeloXGYk2rbIrBms67zr86hUoIFGW/zbYfmo4s7cBjsR8VbDXmCwAxutVecvhCL2/3vahT8cVJpQlmwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG25ZBsnBrcEgxRuE3i86w0WOlgYAdXHmOXBc+maHXA=;
 b=rvbzsGsLsBhqga3d9ghNCx1ubEBNuPnPr98Rj1Yxh1LDYqg4ZelZtaNDjJn5RnAAQjIHcYzH2JYnGsdqEUgbJRMKR+iUGOoXYUYifOIAMfza9FFQgl+sx5AhsGqd7ntRO4cDy/IsrAZKmQMiefh04QivvpEjYbOqrrJ0xTcDK9S0Y0wi6cblSylJQBf07souLWcUjJJ9cbcg2kjkOhZ0UypCUBALHM2V6ah274jOOBB3avMnuN23zHMg12FFmDw6e8bk1Cq2EoNwdC9aYwOYr9bybLZchqwRSC1VD7SAajGIPgPj5eXksriuZJrltrSqaEmJ5/o6oKuJ+9KbzLVnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG25ZBsnBrcEgxRuE3i86w0WOlgYAdXHmOXBc+maHXA=;
 b=H1j/WeU0MuwOQSl/TX3RPRZ+P0RnVIreNMgkAHOyUMRmPyWqgnpgyryCRKxoYhZpgpYsoO643exZvymXerttS9wF1qITx2ibgEsqSRdh7aS7kG8IHwIopxZ4ws4K6WNd5pYHAYnw5NfUyweaGG5kX+Pm9fuFr3rgCN74LC5mvQY=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA3PR04MB8980.namprd04.prod.outlook.com (2603:10b6:806:37d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:23:24 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:23:24 +0000
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
Subject: Re: [PATCH v2 13/15] block: add zone write plug condition to debugfs
 zone_wplugs
Thread-Topic: [PATCH v2 13/15] block: add zone write plug condition to debugfs
 zone_wplugs
Thread-Index: AQHcTMdFcxKPFUM8bU2orWeXEJtZqLThEgeA
Date: Mon, 3 Nov 2025 15:23:24 +0000
Message-ID: <6e749ba9-e6b9-49d3-934f-40c74f5b9eb4@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-14-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-14-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SA3PR04MB8980:EE_
x-ms-office365-filtering-correlation-id: 4811b93c-849d-4c5b-620c-08de1aecee09
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|10070799003|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2VrQThwR2RDeG91R0RrN1VMT2pOUlBaTDNPenJ6Y0IrRWVHamx0aEZJaTV0?=
 =?utf-8?B?NUJDdGtjNjg4dGxyV253NWNQRG91NkNlWDMxaHNwM1pBd3FDNHUvSXlpL2RR?=
 =?utf-8?B?VkdtQjdocmRpUm1qNURPdXhtTGRBOWttZXp6VVc1Y0VsWDBBYU5NYWVRR21U?=
 =?utf-8?B?eGtVL1VZM3RjMFRyODF4azhNT1dhZDRrOXdSZE1MY3pubjhrWG80K0xXRG5S?=
 =?utf-8?B?T3hzZjJKSkZUTjc3S3dudlI2YWtQZXN4M09IRGdNdHh4eXZiTDcvQlNhMjVh?=
 =?utf-8?B?NW1qS1hqbjBjWGQzOTJNSUgrOWtQUnVVVG4wM3FOREM4TDBnb285a1hKTk9U?=
 =?utf-8?B?N2wwWGNhbjZPYjI3a0RHUUlkR3pvRkN4S0toYVVXaFVZc3VDS1BjMFRzVk9Z?=
 =?utf-8?B?SUZFOXc2cmVnUnlodnczL1BRZ1ZrdXk0K0QrRlhWQ04vTlB2ZldiTXFaSXhZ?=
 =?utf-8?B?c1diUnpZSXkxNXNMdWQraTFXRVFNekpNdjN5ZzczbXZGVkpxdEdJQllvb3JN?=
 =?utf-8?B?NUFpRlFFa1lmNlJLdHpIQVkrUURXN3ZEMVU2eWxrUStDYXE3SzZHSks2dnFS?=
 =?utf-8?B?ZjNiR1VlUEUvaTZKbFdPZjVoVnFkUENrZndwU0d1Y2RlWG5IZWNxSEEycWVi?=
 =?utf-8?B?YVBBTzFlbXUwR3ZKWE5YK1pLcE1PTWNWSmt3ZXlKeE5sK0ZnM2t6TlFIVjNu?=
 =?utf-8?B?WXBaT0RaakJPS2FXQ01mV0ozNTZZYkZWYVEvNVFid3NyZEN5dHdITlFkenVo?=
 =?utf-8?B?VUVtejRvR3V4aTJ5NHRkZXB1SndXK2tYSFFVVWhwa29wUllRTGdyc3JUQWFB?=
 =?utf-8?B?S3RCVmlhWDEzMFp2SEVwZ3R5WUVvVlJpRmZuaHRBQmh6T3BtYjZvQ3ViOHJO?=
 =?utf-8?B?ZFlsa1VYMU1oVWZqVjJHWC9Ya1l5eFhpTTlMdEtULzM2dll1aHNyK1ljbk01?=
 =?utf-8?B?YlpyREhHUXgzRTF2TVB5UE5zQnpvKzZkT0J2QmtwKzFpMGhhZ3RMRzRzeVYr?=
 =?utf-8?B?NmxnbHJaQlltYXJsOXhpSUxzM0Z3bzk0WlBUZHN6VzM1Tk96dFMwUnhtUXNK?=
 =?utf-8?B?ZmsrZThmRnpoekVQMi83Z0lDWWNpT3N0Y0lOaC9Hbm1OdFV2aTFtTGlPSmh5?=
 =?utf-8?B?ZEFjWGt5N2hmSVA1bktJZ3FOdnVRalBGVTlFOEVrOVVpTTByNlgybFZVeUFF?=
 =?utf-8?B?amlFSlNyRGg0d0ltdUp6c00ydktidDZpc3lMbk9wcmpCTlgxRXFmajgraUk5?=
 =?utf-8?B?SS9qNjBoMUlCMHNPZktCcHpyNElhRkd1Qm45SHVwOFBGbDYzTXBIWGt3VjBY?=
 =?utf-8?B?WWlEQUlFQjQxQnhSYjQrdU9UK3kvVnEweXU0OW1meW56NVA1U1hQektFQlJK?=
 =?utf-8?B?Qm16VjQzOXF1Q25UQmlBNjJsYVZ4SnVWTEZLMmVYdDRCeXdZeitmbVJkM2M3?=
 =?utf-8?B?eUc0aHFuR29qbWg3cFZCaXUwcnBaUjBvU2ZzdXhVYVg0TmpQWnBwSmREVmI2?=
 =?utf-8?B?TG1Pd0d5Q3ZBWlBQcE53Z2xlaWU4U3NVcUw5dFVlVjhyaVJ2c0oySFVEdkJu?=
 =?utf-8?B?bWJxOVdsbUVLODNidy9tZ0s0cW1lUGMybnh0R0ZCY3hGYVhjcHdIOThoL2dL?=
 =?utf-8?B?REZkMm5FcWlNakNoNHFYUmhnV1dNeUV5STd6c2VzakNQbkEvVG94bzJSQ0tH?=
 =?utf-8?B?SWU5akU0WW14VWs0L2VqOWtWVW0vZ21XUGw4RklqZlRJeE1FdkFHcFg4TTVG?=
 =?utf-8?B?SCsxT2kvK1NZR3JPZ0Q0MVFRbVFvb09rMUt3R2RGd0lFTW8vUkUxWkZLeFR5?=
 =?utf-8?B?UFIwS1U5VHdIUVpERStlaEhMZ2w0ZGJwU0ZadmF2TmdrTDljWGdsRXY5bSt1?=
 =?utf-8?B?eDY5V2Z0M1NFT2F4ODdpakFoQVRFMXdVYklPaTZMNkJsL1BESTNPZmJoZTM4?=
 =?utf-8?B?Z05ZcFdnVHJSYXZvb0RZRHdTZVFsaEdkaGhPTFIxaXo1WThCb3ZBWkZXdkNU?=
 =?utf-8?B?VklWOS91RUJIR0FOSmQ3anFJcmxSL0dHUGRKU2liNG1tN2o0ZEErTEF2Nkdo?=
 =?utf-8?B?eUtRZVV5V1pGeHo3Q2FtMXROUVh2OENRUmhKUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(10070799003)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHEwWXQ2TTBmM1RORXF5S3NLVS9YZURERmhrb1lLcS9zKytsUzc2SzhoVVBl?=
 =?utf-8?B?WG00S1dRUUxqM1VDWkplVENZdDFWU3YycmZBUGRvRzJPYWhpSllkY3pPbENx?=
 =?utf-8?B?NEttbTVOdHNyWkh0QlFwQitUUXQxZXYwSWhrRUk2c2YrcHkwVFJFSTczZW1v?=
 =?utf-8?B?ZFd3bUx5NU1EUkNaVUVqeXVZUjlMTFFQdmxMRU83NXdkOUNSNDFFak9XMWRE?=
 =?utf-8?B?SjNabnltUWpiWC83S0FtWWE4WFdhK1dhUFU1RHNYclc4b1hwalp6TTBiSVN5?=
 =?utf-8?B?TjBjU3RJMFI1a3U5Mm9BbWhSalo0akVaOWdFR28vMGlpSkhNUFJEUFVSZVF6?=
 =?utf-8?B?bkM3ZmhkclUxZWlFTytSMmprSE1IYjBNZU1XVEd2eHljRXdWMytIOW1MWHh1?=
 =?utf-8?B?b3FzWjlHelVaWExpa0dKWWpveDlzendmazJCNmZnb2tMaXI3R0hGYTBBZytG?=
 =?utf-8?B?UkI2bnhPRUp6STlNaDZWRVhwMGJqeHgxSXRyQ0t4Zm54aGx6L0lFRlh3SUNr?=
 =?utf-8?B?L3JFMW9OZTlOQlFPWmcrb0FBNHZUYk9YNVlwblFmSEw0QVRCTk4wcFBYOCts?=
 =?utf-8?B?QzZhcHFPQUZNT0V0R21rZ0FYcUJIWXpYZElKSG5iWWM0ZU1GUVg3Q29pdkdh?=
 =?utf-8?B?SW02NGtRK0cvODlBUk1uQ3QzQnNFeSswdkRSRjdoU1d6am53WG9mSVRhR1M0?=
 =?utf-8?B?Y2RVcmdxakNIUVRzTDhZckg3Nlg3eXpzWlhaakxjVW56czBqUWgxV3cxaXBI?=
 =?utf-8?B?VmZuTCt6ZnI5RnptcnQxTUhVcTQxRFpPMDI3dkY2U24zTnF1eEJqK3hwSTBq?=
 =?utf-8?B?ZUxaV1ExUDBEOFRoWDRad0U4MFpZZTNsMzNXZU5pTHlxSElXVUJ1bkZaSE8x?=
 =?utf-8?B?dDNDZ0s3SFlPWitzSGZxNkw3K1M0NW5JbGlkck8vNFpWS0xiQWhDS0t1YzIz?=
 =?utf-8?B?Q2dBbjNOelgrWFBVVWM4ZnpvUXZ0UEVrQWtpNE1OZm1QajJJK1BBNmZHNThm?=
 =?utf-8?B?MGhqRmxwV3hTQ3BBL0c0REFHaHNOdStTYW52ODBBdVlVUE5nN0xJQms5K3E0?=
 =?utf-8?B?K1YwUzFIU0g3enRqbXFoRXRVdDZibVhvT0g1cnA1Sy80Z1NKeVNoUGZqVy96?=
 =?utf-8?B?czB2MEFkeHlib1VQSy90Qy80cjRsbk1wdkJIOXYveDMwZFZ0ZUZmWk1vSnhn?=
 =?utf-8?B?YkFpRUQzMHFhSWlSWWdKdXZ6MmxEU3NDeGM2UGo3R1BEK1czaHRKNEFPVDFn?=
 =?utf-8?B?S0pXU2FtOTVOTkt6Y0xQd2dCUGFkdFFDUU9LUi9FejUyVnpJajZ3d2pjMmFS?=
 =?utf-8?B?MUloSUdVNklsQ0IvRk5EUUJzcHNteGlvWVcyZlBDSVZYblVsZjRiSXVXMmI5?=
 =?utf-8?B?SUwrOXVQaUZUczM3bWZCUzgzTXJ4SUlPWExYVGlpb0FHQXlkb08vbVFaOHli?=
 =?utf-8?B?dTl2Ynk5c2VZY1d5YVhqYi9ZSmpBYWV6elNPbUVnTEtSY05XYnhySUVvVmpa?=
 =?utf-8?B?Nmd2bERFazZGQ2ZZZlpSSGIrYzl2U3krNkhJRTJTUVFlQUkyZ2hYODl0dklT?=
 =?utf-8?B?V3F6cVhuTFMvWnZZUlBFTnVlSWlpV3FQemFDUEdCSjFUTldUYThkWTFib2pE?=
 =?utf-8?B?dXd4NTlTUUJ5bUx2K2xONjh3NldibjVBSittMUtJNkNPSVN4MDJRZkNQNy9V?=
 =?utf-8?B?czNGMHlKQURxZERLcENaazZjbWlpWjc1Sjg0MGhIdGxockxaTnBBTm4zekJ5?=
 =?utf-8?B?UVpyWEJRc0VzV1dJQ1ovajEvL2p6RkF2UGRJMUNxdGlmUVFSNSs5Mit2dSt2?=
 =?utf-8?B?eTBqcWZnVEJuRVk0enZ4S3duMTgycmQyMVBUQ2FpRHlzY3JqNEZBT3pnb2VP?=
 =?utf-8?B?REhhS29YclgwMmg3NExuOGxYY3M4dFVza3U1Mkw3ZDQ4VTBhZlZiWnhlNUJk?=
 =?utf-8?B?Tjl3bS9UbHlxRDhmQVNoQUtIQzErVnlpUS9RalYySVhqSzR1ZjFxakVkQ3cw?=
 =?utf-8?B?OXFGVGZ1blVMNGY2RGZ6My9naENJQ1U0cUNmVk1nTzV2cmJZV05HRFNwWUN0?=
 =?utf-8?B?ZjVHMjByRjlGLzVkK2NnbzdsaFBzQmE5V3MxYXl6VWQ1Tk8rOHJLQW9sTnk4?=
 =?utf-8?B?bDFzUWg5QWhpWmFtN1NGWXY5RUVKaEx0ZXVzK3VjSVhQM3N5YklyZ1htUTg0?=
 =?utf-8?B?ay9oU0xIbEhDWE90cEt1ODBOUExIQ0VwdGFrVEhUQ09MK0NGcUd1MVY4dUhF?=
 =?utf-8?B?N3F0M1RXT05iR1RTZjkraWJYK1p3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C3E53F354351E42BB9A618384CB560D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r9mhNINbQOJlEC1FTPBeRScqz0bEtG+JXwtjd8W6Gx+Ky0hnOE5vTO4gFfB8yBpeWUlsn6FdGR7aEGPEjvptvnmoNvr0Ef4sl0dfLRbNN3/yB7Tp7mWqw4ex3eOc3DnCdSrQd8+R3sX699AHRRxotTlqf+SbXCNzLmFwvRS2DVNXR+5KEa9sgN7QE6lRS1CdzxBm+MClu/DiIWo+vmZ4SJPiPyE4gXCOTLTX8bnQhchfXZ+gKUIO/Fz46qWcmPOHS3JogWE7MHZpPFeM9Fa7CMPXRnVgTew+IF+eQYu9sGgUCdO07e1ew+fhFsE2UPeoQeHyDTvup0qJLKpvpNEcPBG6zjW42vv7fUcJRdu8+IjyR1KqgxheVMf+zcYvxY8pmbC61WZos2ySTaE/1B7wIL29jF4AIUmrwPpGNcLCUNL6h8q1f6i2+2rVlv9NHXV4Z76FdYZcnn6kT8krTysKY6uomvn7uWYizYBta0U48S97cDIJwagoCC9gKKeU6VWPWl93kIB40ziTGcvLwvkbK8UJKwvWEId7Ju8IeDa7l/Q+n/Mk9JhSNNvCqmPAKUoP+1qNbRaojBqg+wP9bpqWmFDcRdOMp8EDDZI+OEG1dxAw6KyGSV4CHVjcIHa/hNfe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4811b93c-849d-4c5b-620c-08de1aecee09
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:23:24.0876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEEhUYvthkK5yPT4ZuYQtsXjIas7wvMRM7ljPNbYl1PTWfAcC5vrGDLxniCpzUuJk1aXlP+ULo2CqM8Bb05j2TVcE+dFYWHjXxG6AXFHP4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8980

T24gMTEvMy8yNSAyOjM5IFBNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gTW9kaWZ5IHF1ZXVl
X3pvbmVfd3BsdWdfc2hvdygpIHRvIGluY2x1ZGUgdGhlIGNvbmRpdGlvbiBvZiBhIHpvbmUgd3Jp
dGUNCj4gcGx1ZyB0byB0aGUgem9uZV93cGx1Z3MgZGVidWdmcyBhdHRyaWJ1dGUgb2YgYSB6b25l
ZCBibG9jayBkZXZpY2UuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkbGVt
b2FsQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4NCj4gLS0tDQo+ICAgYmxvY2svYmxrLXpvbmVkLmMgfCA2ICsrKystLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9ibG9jay9ibGstem9uZWQuYyBiL2Jsb2NrL2Jsay16b25lZC5jDQo+IGluZGV4IDg3NzNh
Zjg5OTgwZC4uMDc1NTNiZGU3YjMzIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstem9uZWQuYw0K
PiArKysgYi9ibG9jay9ibGstem9uZWQuYw0KPiBAQCAtMjI5MywxOSArMjI5MywyMSBAQCBzdGF0
aWMgdm9pZCBxdWV1ZV96b25lX3dwbHVnX3Nob3coc3RydWN0IGJsa196b25lX3dwbHVnICp6d3Bs
dWcsDQo+ICAgCXVuc2lnbmVkIGludCB6d3Bfd3Bfb2Zmc2V0LCB6d3BfZmxhZ3M7DQo+ICAgCXVu
c2lnbmVkIGludCB6d3Bfem9uZV9ubywgendwX3JlZjsNCj4gICAJdW5zaWduZWQgaW50IHp3cF9i
aW9fbGlzdF9zaXplOw0KPiArCXVuc2lnbmVkIGludCB6d3BfY29uZDsNCj4gICAJdW5zaWduZWQg
bG9uZyBmbGFnczsNCj4gICANCj4gICAJc3Bpbl9sb2NrX2lycXNhdmUoJnp3cGx1Zy0+bG9jaywg
ZmxhZ3MpOw0KPiAgIAl6d3Bfem9uZV9ubyA9IHp3cGx1Zy0+em9uZV9ubzsNCj4gICAJendwX2Zs
YWdzID0gendwbHVnLT5mbGFnczsNCj4gICAJendwX3JlZiA9IHJlZmNvdW50X3JlYWQoJnp3cGx1
Zy0+cmVmKTsNCj4gKwl6d3BfY29uZCA9IHp3cGx1Zy0+Y29uZDsNCj4gICAJendwX3dwX29mZnNl
dCA9IHp3cGx1Zy0+d3Bfb2Zmc2V0Ow0KPiAgIAl6d3BfYmlvX2xpc3Rfc2l6ZSA9IGJpb19saXN0
X3NpemUoJnp3cGx1Zy0+YmlvX2xpc3QpOw0KPiAgIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ6
d3BsdWctPmxvY2ssIGZsYWdzKTsNCj4gICANCj4gICAJc2VxX3ByaW50ZihtLA0KPiAtCQkiWm9u
ZSBubzogJXUsIGZsYWdzOiAweCV4LCByZWY6ICV1LCB3cCBvZnN0OiAldSwgcGVuZGluZyBCSU86
ICV1XG4iLA0KPiAtCQl6d3Bfem9uZV9ubywgendwX2ZsYWdzLCB6d3BfcmVmLA0KPiArCQkiWm9u
ZSBubzogJXUsIGZsYWdzOiAweCV4LCByZWY6ICV1LCBjb25kOiAweCV4LCB3cCBvZnN0OiAldSwg
cGVuZGluZyBCSU86ICV1XG4iLA0KPiArCQl6d3Bfem9uZV9ubywgendwX2ZsYWdzLCB6d3BfcmVm
LCB6d3BfY29uZCwNCj4gICAJCXp3cF93cF9vZmZzZXQsIHp3cF9iaW9fbGlzdF9zaXplKTsNCj4g
ICB9DQo+ICAgDQoNCkknZCBwZXJzb25hbGx5IHByZWZlciBhIG5vbi1udW1lcmljYWwgcmVwcmVz
ZW50YXRpb24gb2YgdGhlIHpvbmUgDQpjb25kaXRpb24uIFRoaXMgbWFrZXMgcXVpY2sgZGVidWdn
aW5nIG11Y2ggZWFzaWVyIHRoYW4gaGF2aW5nIHRvIGxvb2sgdXAgDQp0aGUgbnVtYmVycyBpbiBi
bGtkZXYuaC4NCg0K


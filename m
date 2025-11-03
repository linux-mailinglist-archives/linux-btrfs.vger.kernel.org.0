Return-Path: <linux-btrfs+bounces-18582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D04C2CD05
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 16:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52E144F3D4C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C583E3254B9;
	Mon,  3 Nov 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rxfb1qIc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vWibOW3o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47F2F99A5;
	Mon,  3 Nov 2025 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183665; cv=fail; b=eBmOEIUVLjZxbTN2JlqLzYCJ+UaOZEVs1VQxxxUy09FVScR+r89ITfgMc5WrZWWPobQ+Mg+yBr34zJnBwgOvibmPsGZBFvQeIRTjmTa2zTLzvPBZ3rtgCeb935X8iAPbYszWRUhwgnUYMlgVFG6h6SuIvXap/BW8Yu1SGR1ctq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183665; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ozDRHjwWpHvmcrLFYT839TY70G0iKgPtzZZkQMMG7fxpGrTGxpUyQWoBflQywoluuY3Z7YAWekT8/rl1KW8tEIWCnM8f/wy5fWIy/wOO3VIdnweVN3ucKPT1rhKkM2/siVWxaK84bTJwjhwrz2NhywoUgKwD6nhXW0KOR8Q/E1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Rxfb1qIc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vWibOW3o; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762183663; x=1793719663;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=Rxfb1qIctjcu6wryHkWJXKMrChyJGmotupZKcOPRBfXtESKvaxDhHIzc
   lHy55N5F3RJxTBzuzu9RT6e0bFZuvHOahfS39/pIyIfFr3RmnAzEApgGW
   Olo7Jaf/ANI1BlyUaG5cAgoWRHtwPz8utHTS3Ewpm51+hoPuywZStThkz
   vgdkKBM15oCU1n4MI/3tdxVFlM9+nZWzCDvnO+W+fyAK/oj2nvswJKytw
   KgHb70DfxbiTi7yGrOAuuDS24TSceNeS9TPvBXDxE+3JISOUXr2TFstAw
   HReww/Qgn5u52uBV7Exqpogu79FVKgRcls6p6DonLyt+NvZ8wXjArbeza
   w==;
X-CSE-ConnectionGUID: 3kB9d8IFSXKhDMeHL4+AwQ==
X-CSE-MsgGUID: qxCKMapmT0CJmvmoIkRO1Q==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="134048807"
Received: from mail-westus3azon11012069.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.69])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 23:27:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kd/NKa+U+jiNwdculx+7yg5zZrhEgqL6P8MdzVXJM29T0u5OvNVevD52jGFI8JpHQrLr/D2WexPqkQ5Q2jqSzySXuJfIQky49XHpUoAQFf7u80eWnXy5LHDYFs3E9NBDQ/VuhZqNsMDi23BIQG+dj5nqR/l6+6dx/is4pNVI1yoSXIlafPI+vhmtW/1q8hZeOebggEy3mIvywYo6hGc2MMm52gWxDDvihDxJSGcJpcT6g529HjQGvjt7ceI2NwGEActrZDmIqf7zwg3lwcPt7hygCh9bOSYWHyt8PRtA99gwyHGo7E4+Aefn+vH4Zd84KdQt6ag/D9U0SVnEB81zRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=n8nPHg9AF1qUYbbF5TbFFFK5DRJR1WuyXYhkxoRgDkzaKVmHNr6Vq4/2pzEQcQOWi5eQOE08iCaXRO2+liCE/K/g1aaeHNrD1yztb8PukDmsAEbRHFH5avS18uRlirfeOfmkuZy4ul7tsFzmTMcgay2u++aba+6pX/hwWKD4yxHq29N3N5M4ZYSk/pEFEh7LdAUkaXtLl+Ilr4N8bqwHsCszQ1Jf668Mab1PpNbHC67ER/z+yso4gbYSNTFNu5KYCG92q8JSJPUpxa5vEQ3pRxR78qgwQBmivIKSVAPy8GEVU1XIYhACnNtjz68VawHNa41eUx81XXiGZjO74PJraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=vWibOW3oCbNxuo62M5/tz9eEJsG3VleCCbj6+xm6EvvY2XI1Ao2QfO6qXF5RHk0PCW4som/ny402C9jqB2d7eZXNGAKQR8D8bA+owLRvzEOuA377Y+O4RlbJ31qjOd0NzGZxdW5QxQCodhPoVzk3ap8l+qLIKdkQBBgLcEb+O7I=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CO6PR04MB8428.namprd04.prod.outlook.com (2603:10b6:303:147::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 15:27:38 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:27:38 +0000
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
Subject: Re: [PATCH v2 15/15] xfs: use blkdev_report_zones_cached()
Thread-Topic: [PATCH v2 15/15] xfs: use blkdev_report_zones_cached()
Thread-Index: AQHcTMdNJKX/O9LJ6U6h/N20bbly1bThEzWA
Date: Mon, 3 Nov 2025 15:27:38 +0000
Message-ID: <1a9c705e-a4bc-4ad0-9755-094f3ffa9fb2@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-16-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-16-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CO6PR04MB8428:EE_
x-ms-office365-filtering-correlation-id: 31ebb575-5d44-4182-853b-08de1aed8589
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|19092799006|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTBOZ0J2NG5reFlnbzhuU1RjUUVKay9iVlE3bDZLa2RjU3lrcUNzUGMxWFJP?=
 =?utf-8?B?YzNEOWJ0TGkva0U4ZDhVMVQzNWNGM1l2V0t3b0k2ZHZHWGh0S3dXLzVSWkVD?=
 =?utf-8?B?bk1Objk0ZXdIWndaanVQS1RyRG9DZWE2cDFaV1B3S0JlYklDUGwydHRRMFdw?=
 =?utf-8?B?bHhEdTN4RE91VUhqbFRKcHhkRXF1clEyVVd4VE15OUpGVlZhVjJ2NGtsdkFE?=
 =?utf-8?B?bzMzV0dmSCtNZnNCTjBkZU8zbHdJZ2NNTHRhd3o4cFpDL09qTXhza1VuZVBl?=
 =?utf-8?B?OVVscmZ1KzZtZ0xDUGRRUnRaMXdobFZyaXhIaGRpNnlSVndEZTRURG9HVmpQ?=
 =?utf-8?B?cG5yckhMUGFEL0tzbEVPbHk5S2liZXZWZDZEMjZqVUhqVFVXbTRjUjMyNHBZ?=
 =?utf-8?B?QktOQXo5MEhreUs5RWFuUXBSYXk5bjlBK0l1cHZvT29qbW1yNGRqTllHSDNr?=
 =?utf-8?B?a2k4YUE3YkZGc25TekpRWituVTQyL0V3Q2NUSkJkeXNWbkdiai82OE4wOGVw?=
 =?utf-8?B?UmF3anF0dituVVlNOGR4a0R1bGdXMXF2cDltekNMSm1kYTV1Q1RkQ3NKNGZS?=
 =?utf-8?B?ak1NK0pINCsxOXVsbFlTS3BuQWRtYTRYODczenpCTmdlZUZLR29LWFpOSUdH?=
 =?utf-8?B?N3ZaWENuYUVMdmdXUFM3WUlhdStUd1c4ZUVpd0Z4K1l3Q3pINjZSU0d6Z0Zr?=
 =?utf-8?B?UW55TnBuZm5ENlBEZzBOY25JM25yY2VHVFJEVlVwV2dyR2VtQUVhVDVkNzFk?=
 =?utf-8?B?dlFZanVoTDFmWlBYWjlYVktoMUJ4Zk9wb05icVBaMUxPdEw0YWdiSVBKRnlM?=
 =?utf-8?B?bXEyeWk4SG82N1IzMUNzRWFOcXNWZ2F0ZWh5VGxQMTJYbFczS1RzZEFZL1Vv?=
 =?utf-8?B?UXcvNU9rT0JyN2VBenZ0ZHpOMld6Tm54b25TcUZ4cGUyNEtVMjJ6VEhnM1Ji?=
 =?utf-8?B?bVlqSCtzZktFQThFMGlEZklPaGszRFE1ak92dS8zVlhFZlpFc3hjeDNYNGFZ?=
 =?utf-8?B?dXJNR1ViWFk5VGNaZUNLa2pYcWE5ZzgvNUxxN1AvMjIzK1ZYWFlIaUtLamUy?=
 =?utf-8?B?L2k2djR5VldqbzhJWkFUTzFOVEUvS2hoNkdhc3l5Sm5PMXRZMkhsUmVzM2M3?=
 =?utf-8?B?U2hmMmdoOC9QVXRXVGF5Y0tSbE9lSTBkS3ZHdElvZTh4Z29TcWR5dldWelBT?=
 =?utf-8?B?dUxheU9vbUZqcTEwSExvcEVJaXlmeU5vRnhWOGxlTG9QYWtBaEpWUFR5MTdF?=
 =?utf-8?B?cHNhK1NsZ0xqTndRY2lKbXQ2dlplK2RVVTFLZ2hQb2RyVWhEVHlXWkdWVkpU?=
 =?utf-8?B?REYvS2tsQ29pQ2pvbEJtK0NTUFVmaHR4SUN5NW5kTjJreWRhS2V2NGViQnFE?=
 =?utf-8?B?YnZvR3dqQWI2eHdwMGNWSGU0OWVVS1BGS2gyMS8zMDZLNXZuamJ4WEVkWXBO?=
 =?utf-8?B?Y0Jqd0VCczBZWVAzeHMwbFJNelM1Vnk5cEZJb3dTR3JISVpWdzBSV3hCNEFX?=
 =?utf-8?B?M2I0Yml2SVNTMTd6VzZHdGx3U0Z5c1FPNVpsVWFxQVMzR1l3UXhXNXlQeTU5?=
 =?utf-8?B?VUZhOVFHQlZJTzdmTVBVUVo4RG5oUUM1TFVXalRwYjNTa2JRdzdqK3J6aWFX?=
 =?utf-8?B?Q1kvK3FVQzh2NHFCVjlLdmthOVgwellrL2Q3d3BLNm5qckcyQmx1WmlORjlo?=
 =?utf-8?B?RVh5bzMwREpadElaT0FqRDlRZUdOT1JxL0xEOFlDTkd3bVk4NEFmS3FEYzZp?=
 =?utf-8?B?R1V4RW5uV1FDbTBNWjhNUkVnRFBWRjZUdU8rTGRYSUlWa2pvVmVmWVNObVZI?=
 =?utf-8?B?d1gyZFFkYk1wSkZJdUJPV1o1emNENFdrWEF5T0pxREZOZDRjdVpSMzA2ODRq?=
 =?utf-8?B?OEtRMzFZdThLMGNrNGVBNnRJQU4xcXd4RzNyelNycDJqU2FWT3Vwc1J1bHo5?=
 =?utf-8?B?dDNMUjByM2huYUtJWmtnRW43V09BU08wc05FY0dhUzdsd1VSNHd2Y1ZEeW5T?=
 =?utf-8?B?U1BSTXE3T3FXSklNWmxULzNSRmswNWNuTHpPSUViWUdTMDk2b0JSS3g4WWsv?=
 =?utf-8?B?K29WYm1iT3pBYU5FMCtVR0hqbWVqclc4NnB1Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTNkbXVwdk55Y291alk0K0xIZDY2UW1pNGsyUWhHajV4Qmt3dEZuZHFOeWpy?=
 =?utf-8?B?TDdFbU52M3JSWmdCb2RHaFFKU3hKbk9RWXdFT1FTMDBUMGdIQmhhQWMzWVZk?=
 =?utf-8?B?d0l1d3JRcHpEVlE4NWlBRDRUd2dzOWdKaEtoMzE3d2xZZmhLSStNYnZiUGEy?=
 =?utf-8?B?RTBmWHNsdHdqeDdOMXJxb2ZFaVZub3VBZEFidFdMRDNFL2pXVUpOMXdOSi9P?=
 =?utf-8?B?NitVSCsvUnBhSFplNncxQUNHZEFRYllKTER4K1RoRXZiNkRKajRkSkY0T3Fx?=
 =?utf-8?B?S0NCK0ZmOXFWZzhoeDBDaTFzL3FHSmtaVzFMT0ZlVVg1WEF6MXU2L3QzM3NN?=
 =?utf-8?B?YlAvVktIaFhmTkttaUVIODhkOWt2MGdKR0g2Q2tjNkV2UGdPbVBtQ0ZONDB2?=
 =?utf-8?B?dDV3RXNQeU9PYmxCQzlCNFFqdnZiOGgxVmQ5aWdzaVJ0SlZrTkM2YlA1T1lh?=
 =?utf-8?B?aCt0UU9PR3NENURQWHlXUkJEYmIrSEluYlBDcS9kNUhGMUhYK3oxNk5QdTd1?=
 =?utf-8?B?NXRKM2UvTnNKU0gxRmFpNW5UTUt4UVBPamo4K0JRdHlyL1Q2Q2FKUWVOU0s4?=
 =?utf-8?B?STRBbmg0OVY0UG9sSGhyTjZHU2EvRk9iUzNQWTFROHpoVWtwZGhPY3d0QkM5?=
 =?utf-8?B?UGJ6K01ITjg5T1kwK2VxYWpnU2hqSzZFL0tVcEhsanRuR1hjZ2J4TjQxWmw2?=
 =?utf-8?B?YnhpREE4WkZ6Y2pnY1hTWHY3YnhrbGZkemFQQ0tNYm05enNsaEZ6Q0xyMGpT?=
 =?utf-8?B?RmlmQ3pFRTlmS1NvbXRGVlFFYU0yaE1aRWU4WUplQU4zWjBLQjFTcVJHaHFw?=
 =?utf-8?B?SFpESFQvV1k3bWVMMHFhRnhpUnFzaFgxbmI1ZjFKN3E1UjF1RVR4UGpZNDkx?=
 =?utf-8?B?Z0JMcXMvSVM3czYydDdrVWVaNExHclRNZCtxcU9sT2FyZ3c0U0ZJN2poRk1F?=
 =?utf-8?B?dnlhTG9uUWVDTExreTArYmhNc2xsUVhlSHJjbllPUTdEK3pzS1l5MW41VzJn?=
 =?utf-8?B?dDBoZEFxRThZVXEyMHVtM3p4bTdlNm9ISUZpUkRKaERYZ29VV0J4cEdzQThD?=
 =?utf-8?B?TWY5TEg1SDF3eXVuRHJlOU90UGRoSUhvZUJwYzJoTFRmOGdDc1V5d0hUemY4?=
 =?utf-8?B?RnY4Tng4Wi9RcG5JTVRoUXBmYVRTMC9VWU5jR0RhSE8wSnJrczJVdkRSTllp?=
 =?utf-8?B?NDRnNEl1eUhEOVdDc1FLZzNHeXNyUU5ySEYzZG9rQmZ2bml4dUp1bmVPTWR2?=
 =?utf-8?B?T3d5WUZNbTNxdlUvWnlqMXpHbXNrM0g1QXk0Z09oZW94Yy9rd2kxSkxVQXVJ?=
 =?utf-8?B?ZHYxRG5KU0NpU0hwSngxTTN4VllZRk90TVFpY2RtSzhrRXpibXlWNGtwcFRp?=
 =?utf-8?B?YUNlTDRzM2hJRktYNFFubjRCN2dhT3hYOU1mSHZmSi81TEtYempqNjRGYTU0?=
 =?utf-8?B?eEF4MjZraHhwRXhYNVE3VjN4WEVwWEd3L2Qzdll0WTJUaWNjYWRKbUNONFJN?=
 =?utf-8?B?eHl5UFdxcWZOTHZIOFhldnkzbWppbWY3TUR0NHZCUCt4MnNncHBXeWJUbXFK?=
 =?utf-8?B?bEpuZzZCbXpWRHl6QTJPeEZYOUFac3V4VUhNNVVMZ2czekhpcG1Td2l0d2JZ?=
 =?utf-8?B?cUQ1ZUF3RWk1QmxjbmNvNThYZ3N1K0FoWk5DZ2xzMlNTcitTMnpJdWZRS2pL?=
 =?utf-8?B?KzNDQnhaSjJQL3g5Y25UTXhrQnkvaWdIMFpMV1o4b3IrQWY3ek95U2NmcVA5?=
 =?utf-8?B?OTQwaWJtNExOVVRtSDZ1Qk1QY3NTUDRjemhYaThacUg0dkliWHA5UTB5T0NW?=
 =?utf-8?B?UStqb1Vjemx5V1pkVHBTL1ZnL0Y4WDdDUjRQMTAzNFNiTTY5ZjJpZklhblJL?=
 =?utf-8?B?bFJleUJNb2dpRHU2VFpTMzhDU1J3N3VtSXNLUHBWNlozZ21RbUxrYXJhWCtH?=
 =?utf-8?B?MnBCQ0R0TXdVVnM0NGhGd1hFNXdaRGE5UTFGVUVEckF0UHUzUkdHelhRa3FH?=
 =?utf-8?B?aDFHaytSL1hpci8wd29NSnU3RHdtbmRxeUlZYWZiOWtORWJNRkYxZjIrNDNH?=
 =?utf-8?B?TGxiUG9LYllLQUZQYXM5MFVBNmFRbFpORkNLa1g4dmZ5L1F0dlVPRWZ6TlRX?=
 =?utf-8?B?TCtHMHBFU01sTTFkYjUxNUptZFRqNDlVSHMxZmJBRFdEKzM4c25Nc1NvZ3pR?=
 =?utf-8?B?R0huRWNTUklCcjZFakFmUzdndlVxczhZZENuUXd2am9BTHJ6cW9hVmxLWjVQ?=
 =?utf-8?B?Z3UyeVRmOEJ6dFZDcllJVmN5NUN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F46F45FE72B5294F8E42D5CA3E1C2832@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	erlObrN7L+mKGF/RKhFJPocc96aEr/C5NXyambMvAoE61pcK8qq9W0g3ID2KpGo5NBkXZBZ8CaNnXsDn4d7APkYTJQDwdMVG3fuFOmjOKnpkivMHmK7M1aXttNXI9zZc3FMDLZCiC3/eiyLFzR5CADJBmXTKqNTATsc19ik7Wr1EKbsNmE59oIg6HwlLIUQKhXSwMYcZHjzehRsyXyIYaIbze7XZ5JufQBkEqzzld0agVDzW7URCQqz8ccIVJwID3QxZXLpy0J1if4TGQnFS9V+LtxAOMOkaiIRJk+1u5PC+wcPNTzfdk9UEHOA/qoUQ9A0eYLqPK5D/EaySTADR4sKcfYE7Mio3f8twJtSZCXkv0Y929QuQx/GarS0Gi7ssjVNKM2FmfNiXeHFA1rhNiF30cDbXHZr1xSElJcZjrpKv+tmTy77OItNprdw33X6HhRCei0vnI0IMWBxlGIS1YveaKEchrnmSQ47KNnAesYZZvVpIlPxKFVMR9m4geS/GYJqZfp1wvJh7u+LejJvboqfjtJ+7uGEzW5XgsRg882FlP2Dqkd53hjnRGgl9aE57Nu4GwTRC3E971RFjOKezh5GioNwj22sQ1RRB8kFrlkmdIV3gOiyHhcZ4sqQEyMn4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ebb575-5d44-4182-853b-08de1aed8589
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:27:38.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVQv4/+7AWUppH+ZAyufUQtktGaJGHY8kJP+CzkZlZ0OYnOhmXcZHOhVwxNbZXInvGHUzz7KJui19g2Zv2P0oio/3wRcBSjerJMWPGCgjBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8428

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


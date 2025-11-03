Return-Path: <linux-btrfs+bounces-18576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D76DCC2C9E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 16:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58FA2349E3B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E76E3191D7;
	Mon,  3 Nov 2025 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PbycTglv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GiM/5PGd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A6314A6A;
	Mon,  3 Nov 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182119; cv=fail; b=rnxYwqYXeeABoXruJOMrgdXIduhqF1zgLJ3+nduCb3A1VNvxbaTNhlSJFp9tJKeZ0UQZz3Op1HJNrmBHNVABFqtlHQP1SfK1jfbagQL2j2yvh8q8yLGruyxfGR5PQKZHrmwiAk8oJCxv/2J04Op3U5EFGKi05qbxoPGDsLvnMMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182119; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IzzHZp8NxiegN1cRSkAzfxzU0NP8P2ZyxYkvDtfo+SZbhuZozgR0uqCwwVpg35/X2VHPo6GX8lzk9UO6i0BGTzrpOvFB4JYiyNCXL02QTjFlpBJ2mF8pnKivVPWIWacxHXZWZgfwRT+UN/xBncYJzRLe4RUqcj9yLv/Shasrc3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PbycTglv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GiM/5PGd; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762182117; x=1793718117;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=PbycTglv7K2Z4rEuQDktTB3jaKhgKSZsn7tb2PweQfReF6Zgld/Yw2e/
   GYYCyfp4Pv3xkGGX+lIpUuJHIA6+StMk6CBGuVX4BxpY3v8TSgASokms/
   DSwe+1bAVxvvfEFd2nEz8zkSk6OxRe/2XE/SBK/0Ov2kBxvNkXAGMUtLc
   jYUKEuwROmQFHVUpJuTqaFqiOhoXfTNqVQyA8ewZoY78XjPU4xJQt7zbZ
   w5bp7sqqcyqWFcac6IOa/wjB6wvFejEdcr8Y8yUPrW6e5l13L/pzXY3Cd
   zMpASrxAx5uO5J6krYjDuM2lz1Ngu7S04aiv7WgUQOjVf3AmuaYJr9EGN
   Q==;
X-CSE-ConnectionGUID: Vx5La2wORZ+obleDFnYv1Q==
X-CSE-MsgGUID: 1aVIyNdQREu5xJFK+imh9A==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="134047535"
Received: from mail-westusazon11010050.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.50])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 23:01:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnEg0GBKOlnl/P4qE/31brrMFu4f6nLgNqfPM9yCwLUV/G5TkEV80xNZPmrVjbjXOwfqZMTNeeKe61jgLSlEQSPrzA/aulsfrEIAK4MTBISkAUJq8ntsO+FZEOOEmDWlHgI32sLg6UgKQ6kq/aItnu9XbCLKpFwrTpZeau9nwtT95N81G8u8ozagD+V9po11vMWYuZ6vDQDFLAtXxFXiXxgEGR3vGQ0aaV5oGiWNya5VJd9KqUMJ+uT4GGYHQRWNNrhV1BlhxUvINP6UXX3T8pUFw48XGrqxrd+MbNH7ZJuE13ivEdyKNzDe/w7zrKtpHH+hgFmcEqG9GadKMPHvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=RVHkopopYQpvc8MAJQ8OYk55J0MJU4R9M+khV4hyKnnNCuYe2y+Crs8IimmJ2qcmgAWn58Sqp8qmwVsMqs6b8QazadO4ykwTWzkqCwMpjqAuMrWtr9Fy8sQMfIH/Lw1LgH8NpvTz+axKj9z+ovcTmUJrYAQEvqBOfcLAUEn2+ZCq+9UX/8sZgKbHTX0Bn1x6XCdL6sCWBfQsGn2qX99W9vD5HtDqBTngpCl95MqQHe5v4rwzWQ9NCcFr7pXg4nXOFv5LuIwc9t+84K1+Vvp5YbmfHlEa0PMaTIRkv1FAdVUTi8uNy9RV84IBGUBM4YsvjO9KtMhmSP+Ewp6p8lXy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=GiM/5PGdyR6735Ub5crH4cXqIMkml7Q3dJ2ldfET1i72hLtBrWwLZq/kU5Wkna4PzpHoekAxsKQXNAgVqwXI6EPbKVEKbOdgy0437IeSCE+s4HJy8hfhEOuNUSYvc99tw+KDqJcfLOqis0t4DYVQdxGnRJE1U6D5BASQcuF2GsY=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by DS0PR04MB9687.namprd04.prod.outlook.com (2603:10b6:8:1fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:01:46 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:01:46 +0000
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
Subject: Re: [PATCH v2 08/15] block: refactor blkdev_report_zones() code
Thread-Topic: [PATCH v2 08/15] block: refactor blkdev_report_zones() code
Thread-Index: AQHcTMcXXa/tYsxeq0ycwxNM1jYObLThC/yA
Date: Mon, 3 Nov 2025 15:01:46 +0000
Message-ID: <a77f1838-b48a-44d0-9354-1ec62e28975b@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-9-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-9-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|DS0PR04MB9687:EE_
x-ms-office365-filtering-correlation-id: 9b6d2f06-0d37-4208-9b9c-08de1ae9e881
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|19092799006|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFNZY1NKU3dGK1ByVFJZZkV5OVVsZyttaGxkODAyUXYvNWt4cHF2Y284aEt5?=
 =?utf-8?B?MmVNUHZLZ1ZtbG0rbEhiL3MxYTFQaENQbkJNRHk4dlhYM2QxNEhnYzIwOU9T?=
 =?utf-8?B?Mk9UMDBaUkFXM20ybDdZYUlvanEvb1l5WTQzbFZuOGVvQW1sZ3RZVXpncWVT?=
 =?utf-8?B?aUoyeGNjSWVpNzd2MEV5OE12a0hwMGxad2hvSmU4Z2gweVVNVlJGUGZDa0Z4?=
 =?utf-8?B?VittRk9lVUg5T0pFQVRTcXdpQ25BUmtaM24zMnlnOGtMTEc4cEF2ak9YcUZO?=
 =?utf-8?B?ZGs5MGJoRWFoTFMzdG9iZW9WTjZZaXJCVnpxYU50SnZRWHJTL3RjK1RhTDlv?=
 =?utf-8?B?UjBLVk5oT0grbmIwTkFFMFNWSFZpeU5xNm5tSmpQbG55c0didkliWXpSd2tS?=
 =?utf-8?B?N1gxWU1sbnFyMUNQMTh3MUk4dk50dExhbnpJUTBtR2VBTG5iRnNxQTdPU1lD?=
 =?utf-8?B?N1lLVXNWVDJnNkxVUzNaM2VjWCtiRi82WFA1dmtuWGZOaTB1dVdPVGVNcThu?=
 =?utf-8?B?UWFXL3Q5aGZwQzNNditKVDlZZGNmNTR3T2RuQklmc3BLM1JGTmw0czhNb0RC?=
 =?utf-8?B?aWw0Z3V0bzJISnJEMU05Umllckprd0JHTzExRUtES0xSMVhUMUIxWU8zRkhK?=
 =?utf-8?B?Q0ZlbUZKNzBqUWRDRy8ybUlBanUzcWlRL0g4QVRnV3p5bHBQdmZzcnZMZmpx?=
 =?utf-8?B?dUh6WlFGdExjNEZnT2JCUHF4dUxDLzJmbi9OR3VVVWZHSUpLcjdzVTUrbEQx?=
 =?utf-8?B?anNJc3JXbDY5a2xrYys1Y0dXUWFqZE9NbzIvTU5VdUZTampndk5ZM2pQdDV5?=
 =?utf-8?B?KzhYNmp0bjE3WkpYVkhpSGlPM3FYQS9QLzlxRHBGTnNJM1RFRHpRWUtZNmd1?=
 =?utf-8?B?cm53M0RXRVJ6Zk5YU2Z2NG5ORkRValBDazE1VGhRaWdXenlwSzNpbnJ0N2Jn?=
 =?utf-8?B?bzF1MGNrcG9nTDVRRHY1TnRJL2MwcThlOG9sYVNSckl6K2dMaWZGMUdCOVlI?=
 =?utf-8?B?MnFVZCs0S250aXNvbWREeXhUQzByc2g0NWhhM3o1a3ZvdVM4ZG4rdFNqeTlR?=
 =?utf-8?B?YUdtRGV3TXh1NG5lREZmT2FSdjVvNmFqelFzS2c0OFBCa2xMUmJORVcwdmFw?=
 =?utf-8?B?REF3SmFTQmdqSXYreFVhU0d1N1NaTytNU0hDREQwMnl2NWRVRGR2M25PTnB5?=
 =?utf-8?B?V0lQdzNXYWh4bk9SN0l4eUFKWXJ4VjZIRCsvT0VuT083RTJXa25nMkZNbWl5?=
 =?utf-8?B?VmUwV1ErenV5SGtQVzhPWFNSSWd5c3FkWVRqUS91RjIybDU4ZEp4NlBBUTQx?=
 =?utf-8?B?bzJJK1h0dmtiMFE0SzNXQnJiSkxPSnV6MjJQZm1pTC9MLzlSbERPZW9Zblph?=
 =?utf-8?B?Y1E5VXVIS3c2M1BlV2pjaG8wNHVPOXM2Vk5FaWdMQ25MODM3enovM3lLRjg3?=
 =?utf-8?B?dUExZUtkcVpzQnZZUHp3azdyMGs4cUFmSnB4eEgxK2k2SzEzdVZRdzdoYWpQ?=
 =?utf-8?B?RVNjYkpMdTV1OVlwZlB0VzArbEpNMjZPQ2txem53UWViUGY3ZlF1dW9TOGk3?=
 =?utf-8?B?a2grUjdVMS9mK2ppVURCRjJ0Vmt1aDk2SzlrNVYxOFc3OUE4QjhmZEtvalND?=
 =?utf-8?B?OC9YdlRkRmhRRnNtTXNUQTIrUk9pV1FPZGk3NThtLytkbGpIVUdMYmhXcGxa?=
 =?utf-8?B?VmNvazNGLzcwaW8yUjVRK2prblA5aGtMNFF3d3VuOWVWcGw0TnFZQXJaZ2Y2?=
 =?utf-8?B?NmpMR2FScW9FdDdiemZlWGdackQzOWFGKzdoNDAvY1dmQUVSNTllVkNQYjM3?=
 =?utf-8?B?TEJvakQ3WjE3eFUwMDd6YXBXL0d3eHZuOFVoVUdEaWMrd0phU1JRcGNocWNk?=
 =?utf-8?B?VnFIS3kzQks2d1h0SEdpTlhwYll5SCs2ZjFKMmpXSWg2SFhrOTJtM1QrdktG?=
 =?utf-8?B?VUJnWmwvYXp5LzlDYzJnWkc4QjMramREZW5IVHNnTDdPUTl1UGdyVlN4WTFk?=
 =?utf-8?B?NTFXRnV4cWNaMEFXbGFGWG9adE0yckk0aG5PQlUwd1ZmTWRDcUNsWHFCaC8z?=
 =?utf-8?B?RjhhU1dtZnlENFNFWVFHTUsvaURUNDlpVHNUQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(19092799006)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wmx6akhhbFFnTW1VNUNUaU83MnduWm9wRjN1UUphT0ZCSWdRUWpyVEhNdEE3?=
 =?utf-8?B?NUplcFA2R1ZEWDc1cVY3RUxkNWhOS1BtaEpQczFUay9vOHhwMzV3L2gzRnR3?=
 =?utf-8?B?Sk1TQ2xNT1R5UGU1cnllKzJlSVpVMjJDL2pxekZFOUlXL0pqSm9yMU0walVw?=
 =?utf-8?B?NFBrRDVxZmNubjhjeUdkZWxnOXQzOVRMdTZkR0VCNGd6Y3Y5TlhzTFJneWdU?=
 =?utf-8?B?UlQwN3NZZkcwbFFZd25xcGFYaW1FUVdGMlkvOW9Rb3Z0L3Z2OXplTGxwUk90?=
 =?utf-8?B?NEpibEVFL2pxTFBaK2hUeHN3WFh3Ry9sNmYxYUczNS9qNEVHMUNSb2plSW16?=
 =?utf-8?B?K0VKeDJEazBEMDNmbXNNdTFhR3N6bHFzZE1pbDNBSk1Eclc2ZURlaVZib0NI?=
 =?utf-8?B?WkVqdE5zNnM1MktGY1Z6dlF6Y2o2R2U0N0h2VGFjOVJ4S0FVMG5tbk80T1c5?=
 =?utf-8?B?bHIzODI4SW5vZkZ6ODRiRkNoR3d4Zmc4UWVKTXE1T2JQWHNaNUM1RExQMXQw?=
 =?utf-8?B?alpWSGY5Tnc5MzVXSEhmaTNPaVUvK3VsMjlxTjdUcnpvdXNFS3Ntcm1nQW8y?=
 =?utf-8?B?TXlPdGtTRHVmN29TY2doRnV3RXd4SWE5bXQzTnFEVkN4bFcrT2IyZWRsU2E1?=
 =?utf-8?B?VTlQNUJ5bENTSVU3c3llOVJleXhPTVRneWd0NWRRYSs4T2xwVWkyMm5OK0xW?=
 =?utf-8?B?YnNlUFZGb3VBWFdQdXF0L0duZTVzZEloZCtUcGEyemhmODZKUG9qdVQycTIr?=
 =?utf-8?B?cW9pb3pEZWMxWWJYS0tzUlVjVmtzS0ZpbHJLd2RHdG83UjNzMm1lelRkWlp1?=
 =?utf-8?B?c1YwRXJTVzI2dlhYYUxuM29rOWNBbTk1cXlXZUx3dEZrOEwwRW0xMEdmZ0hT?=
 =?utf-8?B?cndIcERmUVd6U0RNN2tySVRDeFVmaS81bGMrTnpMaFJqMkJwc1JDaFFhb0NL?=
 =?utf-8?B?dlVJTkhSSjlFcWk5em5GRnVUWUlhV3lxNUlQeFU0Q3ArTEN1Szl3OWNUTXgv?=
 =?utf-8?B?Zk1aS0xoSXdvVmFzQS9JVEgvRlZiNkdXSWNwcDduUFZLVWEyZ0NNY0tjRDFp?=
 =?utf-8?B?dHJnRnhndUNpMDI5VC9tUFFOUi94aTE5RkhGaFVyUmNldGFwaUs3WS9sZk9p?=
 =?utf-8?B?dG1GM2pmOWF4UWRUWktudXV0T1ZWNXJVT202T01kdDQ2WEtxS1RtOGRiR1Rx?=
 =?utf-8?B?V05ZM1RxS1IwREJtMVdMSmd4ODZBWE5NWFppT2dSRVRobk5IMGQ3OThvaTJJ?=
 =?utf-8?B?VkRlMEpGT3FySHhkZmpJVmxQUjVoZnc2MnA5SitjZEVFQ3VvbG41bk9JN1FT?=
 =?utf-8?B?dW5TQWxBZ0gvZGNBOTE2SmFXZmpDVUtDaytIeDdXRFVhNVVtRlpqRDF6aVM3?=
 =?utf-8?B?VEdUa0xrdzkxbkdQMzFVWk04Z3NlVE1pVFFQaHFCL3J1ZUR4UHphQ3czNlhl?=
 =?utf-8?B?VTVpd09xYlZ3R1lQYUFjTVVVTHdMdlZoUTd5UjQrVjhJV25hbDB3N0RFTUcx?=
 =?utf-8?B?R2VXUk16MGt4SmJkc0EyaFUrU3kwSStIcGp5ckdBOUs5SUUyd2RzcmZNb29r?=
 =?utf-8?B?akdlRkxYcmlTeDBZN2JTcVJGNVVnZlVndkVicjJPNmRSd1UxeXpaVVE1bE5y?=
 =?utf-8?B?YU12bzFzUDBTV2w3NG5nTmFrUENjSTNVRys0VlpaaTFnNEpIS1ZxWkkzRnYv?=
 =?utf-8?B?NnY4Vjk3Z1k4LzBxb0l1VEdETlM5VTNyTm92R3B5ampvdDM4WksyeVZMemc2?=
 =?utf-8?B?YlN5V3BVOURtWUx5eEROUFpxTzk0SVFiUXpWL2FRbXp1dXhSSUxoS0RIajFy?=
 =?utf-8?B?NEZjRzdMajRQNStlMm5pV1pxTitTYWN6KzV0SUMrSjNQRmhybi9Fd1o3U2Ju?=
 =?utf-8?B?dll3YnJvelkyajFaSDAzT2JKK2NNSzFZaXZCV3lUbnFZUk5oczA1TUZFTlBl?=
 =?utf-8?B?cEQvUDlzaEs0THgvTzFoVkIwRE50M2Nsb2ZzSlVHd3N3TXJwSUY3b3JrZGtv?=
 =?utf-8?B?b1dYd0VPNjdYV2ZrUHdTNzdrUnA2YVgxcWJxcUIrbEVYend1bElFZEhDcWlE?=
 =?utf-8?B?TmRKS0tuSlNJZ1VEKzduWXVmVlNRN2dtN1AvaUo1ejBSSjdIUUxwWTZka3Zx?=
 =?utf-8?B?ckZFWG96NjNnamRha3BKYzkzMzkvWitMSXNQcTZlV3JIM081WFV2cWk4Y2ZG?=
 =?utf-8?B?NTdpZnJBcUxRUUx4TkFZSExyOWtVUWxLdVMrUjhub3l2U2pBNDlxOEZjVnMw?=
 =?utf-8?B?Z2xCNzE2em5sKzdIMThvWFNkcjVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBB67EA8DC49A84AB1E801EF6CD62EA8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DlaQsfMu6husWPrDxQHoz2KWhdTJuniRETDXp7AvUJNXTE/FEh9t7kzzzJo491RXtAfwPukdnS0N/FYIaqBo8vO+uagTJwzFLfFGQae0p0YX0T/boo0qx3JE37LWe7wjtKA6lQK70fuT2j1hMolHoJXu+NrBgjv94crhRh+k6VfYTj/HN1kYHQN0wr2WDzV6yD279fLii+DMyMxMdesdexV75eO02uNjPnqNb8r/FjNXf+8RIxWXXXfUuc9/HF0P6MtOBeCqgO0UvB2LGdApfsy/Th4OF6Um3pOw+2ymqhyF/2M5jVCj59zGJpu0nHSXF/YS2FuiCJjw/XnsjStiaiuV8068JuWs+q+1b1xrJ+JAx27G/1srbVaUeJb8JvKIU8ic23TAk3FW74J+KOL/32xBFq6ykQjEruq/E71tX6QDKiKSd2Y4LaHeUQiNe6MCbOHEXEDohrEOOlRFtNRgTwpSNfubY/HZ1q9HPwQs8wTVfpXLhpS4z5qhWlRDvkb/QpttuTHnTLwAPUWkw8CwQoky0GeuBw/VhwsOtxcgcwl3BJzy1AtsRSGaZRQzPgkurupJy3gf1cw6Rk0vQD0wJBrhq6EN0fwv5lu6M3WgD6e27KNQL+MhFtTw0oSh2T91
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6d2f06-0d37-4208-9b9c-08de1ae9e881
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:01:46.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElJ3yT4ufsH/uHuYzOQUzZFDxvdjgk1Z4++uhD/Gq5adJz58IALY6KJ3yYnL23txzliIMTOol0wfnGkvNH7PWzYZZ5hoq/iL05DeWPFx4SQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9687

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


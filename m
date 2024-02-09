Return-Path: <linux-btrfs+bounces-2270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0889184F140
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 09:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2843287CA7
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 08:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2211165BB5;
	Fri,  9 Feb 2024 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IgEAb2oc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ml3coDaU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34857303
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466478; cv=fail; b=bl38gSkZ3DRFh+Vrtr3CWQUCeHjJhMDX3LRJmC1JkN4vSp7YY4cQRev2ysr4ut+WKBnC9tBt6B6jdFcmbF50cb9IpdhKjkAtNgHDewSsyVcJIbdqiWvhrkNnMayNp/kz72TtSN9P6VWysdJigN8Ns2fowU2pdju9aI6PWRAcnCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466478; c=relaxed/simple;
	bh=9t1XTd5F3t3bhUVOkzdjZKQwyuPr8IOYTJ8tCD14uJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ubCab8rW65HMudhaQ/FG2lBHEfJRuvxLKZkzcNusIb0qGIAtJ6te8X3l1xJthzGe8JByazOWL96Ktu6hMozb90YXnZZv70ehBTA/pT7HgXVzPF3aZCD/n0Ujec+Cia2UAXyF6W7cPfFc/fLZ9rnIoWlQ4Z+095uDc6DVw/NTbnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IgEAb2oc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ml3coDaU; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707466475; x=1739002475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9t1XTd5F3t3bhUVOkzdjZKQwyuPr8IOYTJ8tCD14uJ8=;
  b=IgEAb2ocQHeshJoxz6i7vm+pro0fOgVfdhaOR7TP5AMxwHt2uM2infUH
   AB1M1fNz2vOrSh7krhxW6q9XP7X9oPdq+C4ViLYeqvhV/UlHFkbX+jZ1r
   Cvbf2UDIZi6Z0VACrMVtMCNQOq4FhDXdOmjYGLfZGPGRcexh2sph/o7CF
   o2j6S8emPk5dPdKkSZQlsRkddcBk6/8zAqlX+sjzFn5NL57JH8/uz3ZGX
   yy80ZR/16CfvEBYx69nKgkRhPvafV7/vKHffnlkNEpm6ldizlA3pkKF8o
   FvVQ8lhOCPile+Wyjs5EIOUM9XxUydEtHvX+uglnOUkZG5CLwToB9FDCg
   A==;
X-CSE-ConnectionGUID: knv1m4Q7RuW7JlWlGs7Q7w==
X-CSE-MsgGUID: GEvKfyi0S/ugBi/FVGpnqg==
X-IronPort-AV: E=Sophos;i="6.05,256,1701100800"; 
   d="scan'208";a="9127798"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2024 16:14:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8ON/EqpbtggV/aGt+THBHlESM8iFnwyTuSXjQFTVpxTI1zhuet5tbsdhpi/GHy0ifmY38TKBN3kdrbg87ja862FLYZRhCSW5LS2Oq6uKDSQ6ya05QzY7cLQw+sj0KXAwhPZOvKGUFrw4caUmstiZPHpGjGkMPS6V/aML2Dcs57DcweQJUsi1yaJz2i6IPDf7S3X6FptMQ4iwUktWCNPnWSK31FiUkayvqdRdioDrFe1xE9hDfCHBMmfNUktcisaJr1+z9D/DtODCap3tj9biWXIP8HjCC8PZr7eMsdYBdb7VDHkqcWpLhWIfZJpLNKBzsPc4ShGjRJULxyV/Rf86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t1XTd5F3t3bhUVOkzdjZKQwyuPr8IOYTJ8tCD14uJ8=;
 b=E5xlEc/zeUBUJcmw+QAkeGSDBh+aNHyJwRZp6Pd+SfUWRDZwdADTccrJCjSeb5GjbHV3wf9eCfMmuv7mykW37XyYU4TWfzTjDdI1fvMySYI7H+1tEGEraLx8W6z4rZesB1BFaqq7em/UtdI0773bcLSgSCEwG8G/ID4qrhdMTahKQb4epn9BSt6QmAErZgKm7IiVf3xVGQRQ2FZcvQEA8SfwJTpO3c92al+FnLFDok5zAzEMpsjRFlwqteXUhyyzNkgbshCJ2DOjcCw9ZbMcpNR8lCzMnMTrKgb75fyeImMTTqun1sgoYZwnq0Twm8reYOHa9ZMkM3ZyEcaP8qbC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t1XTd5F3t3bhUVOkzdjZKQwyuPr8IOYTJ8tCD14uJ8=;
 b=ml3coDaUcOte9Qparrd+AD5mqQDyaHGirayoRWcW18Z0L0EAqAjF6V5d8u9hplsAx5/sYVklvIGpDO4inrOEANiaIDI5B9JhoiPFPzWGppM1yQHSX7S9Di0GFwKkkPRPPgVYFucjnkLXdgjtWDc4hgKfMNG38HulMsZvctldHXM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB8700.namprd04.prod.outlook.com (2603:10b6:8:12c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Fri, 9 Feb
 2024 08:14:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 08:14:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>
CC: Qu Wenruo <quwenruo.btrfs@gmx.com>, =?utf-8?B?6Z+p5LqO5oOf?=
	<hrx@bupt.moe>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Thread-Topic: [btrfs] RAID1 volume on zoned device oops when sync.
Thread-Index:
 AQHaVbCKj/f1FqvKZ0SR7X1wPPWj1bD2+NkAgAFwV4CAAMh/gIAAvbwAgAFL4wCAABdUAIAAE6IAgAUG+gCAAH5oAIAAUoIAgAB2dAA=
Date: Fri, 9 Feb 2024 08:14:27 +0000
Message-ID: <2be3a123-e22e-45b1-99cb-3d0e10864b1a@wdc.com>
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
 <cf12dca9-e38e-4ec7-b4f2-70e8a9879f53@wdc.com>
 <7ff2a6f5-9881-4224-a49e-cbba816a60a8@suse.com>
 <20240209011028.GX355@twin.jikos.cz>
In-Reply-To: <20240209011028.GX355@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB8700:EE_
x-ms-office365-filtering-correlation-id: b9d39ac0-a6e9-4f77-7e55-08dc29472229
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7V+KSVPjuhCiBhwYWCd8t+GrJ5CCdBL7ac8hOSmE/Fw4PxzqFDm6+kEyfA/GpycV9CzVzRUg62X3dB0H3Pa2As1XwvL0GH6UZaGYxIJlE3ZndzUTHmulWKK0ruuksQQ7WDu57tvUXc/tnhQiT4p3WOyqLmeh6cFb0i08BsfVQp0hL8kynsg++JZrKUuLBHw76EH+hKgwv5bi9mJi/rREGrMYItv9O0In5+FLHi1PqpoGDOAHfbNkTBEDa0blo7EXgHsDzxojjsuW4xJW7W90+JQQCPewEmD2U6iOJHm8p7fsksEPAv32MMIU33P5lVvNVeLDpbwL/x9yfQUkjzo2ztbDtXpBOeI/49B/mvjHGybnVo3LdtLl/XV9ma+SXlbV1B6YzzyFDA9Axs4QrDH1LTF3US6wgTcob9joVuB9EUl0qBtstJb2iZXxQJjaBvs8QRWiVlI6xEBwuSezrc3tEUlJD4NsdC0BhBXhTBEUnoulwqgjUhPz2bpS97sQTBlpaQPuBm/9MlH/5gSu6K/pMgvlmWyPVkK6DJPdQcke/bdMxYxgPVOT1fMatYWs7z7ltCm65r9ct83g6AoWcrbCm+ANV0gSA3UwGhLBdkj3feg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(38100700002)(122000001)(82960400001)(83380400001)(71200400001)(6486002)(31696002)(2616005)(478600001)(6506007)(86362001)(53546011)(966005)(6512007)(76116006)(66946007)(4326008)(316002)(66446008)(38070700009)(41300700001)(110136005)(54906003)(66476007)(66556008)(64756008)(8676002)(2906002)(36756003)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym5URGhOc2k3UlFvZnZPbDNSeWdyU3Q4ZCsvMzVDVy9KZldPUmFEVzVUK2VS?=
 =?utf-8?B?alYvLzF3WVpxaDBCdlhLK2tJZjE5ZUNuc2hweit2d3U3MWFxZ1I0cFZIZndO?=
 =?utf-8?B?cTZGbnI2M1lJU1NuNzZQWjFzcjk4NHdwTGNqSGk4Q1V5VDQ1TE8vY1ducGpZ?=
 =?utf-8?B?K0xrVmNmY2cvMzRDM2QwTHgzbWtUZjJPNWhHSU1UU0tlRDIrdCtDQm1ycXNh?=
 =?utf-8?B?bFI2MHNBNVBwTUR3ckNJMThUdHFLREVGclc1bnZySUtPVE5oemJMWEdIaUpW?=
 =?utf-8?B?OWVEQTJNTmxSVEJjOWFrSGZsUWdVNGZteTNmajl2RkhuTGdFZ3ZDWGtIMXVo?=
 =?utf-8?B?Z21CVEhtbSttUDI5bFFVUHdZTDhCZjFqdjY2cjVyWWpRRnh2Qk8rVVdUaCt4?=
 =?utf-8?B?dkpKMDNBc0I3MytxeEVqM0FqQUJYTHRQNWNURGp5c1crbHZ1WDhoLzAyQm9U?=
 =?utf-8?B?ZStwbzlYSS8xdEs3RVgzeU1vaGJOUzNEVGNnT1VxZk9pbW9uUnZQUUJXbSt4?=
 =?utf-8?B?ZVYzVVU0R0gwcE91eFhMTURNclJHaS9GNEVsSkdiMlBnMG9XbGxRTVY3YXg2?=
 =?utf-8?B?cEM4UFhvZ21KYXBVUE81cWNGcWdjR2ZvOWR3Wis4RCs2VU94SkwrcVoxTVBx?=
 =?utf-8?B?VzdwektKRjdSOERqOE1ndk5VNHRTVS9HaVlESDRNYW81NTNMQVZRbXZRV0Vm?=
 =?utf-8?B?TGlzRXJRWCtZUy95R0N4Zjc5cnpGMDlySlJtVTlWWXBDL2p6SS9LelkrL0VS?=
 =?utf-8?B?Z2xxR2xkK1IzL2NzNXBGenZBbzFhcVBnOXV5RFdnYzlhMDFVVlc1UGFaWk5s?=
 =?utf-8?B?eUVwMVp3UHl6cVVEUFRGa2g4YjRHZVBPNGZ4bHUyZ1FDTysvNllET1EzNkM0?=
 =?utf-8?B?YzdiY2FPdUtxbkhydzgwR3ZSSlBkdTFUT3d1NGx4bjM0MWtSRkRqMXQ4SmpR?=
 =?utf-8?B?ek5tb3hUZHkxWGNOUHd4cnNFaWxqRFN3Y09ic29CNWRGZElYT3gzZzNxci8z?=
 =?utf-8?B?MEV5OUxmZFNCaThvaC9TY1JzaFE5Z0FFYndYaEVpRmhjK051elpGNnZvNjJi?=
 =?utf-8?B?VFBGOWNPdUYrci82a0xLQVJCbUw2ZTJPdGx1WFU5MWNVSnUvYmZ2bGNtUEdC?=
 =?utf-8?B?aTNGRHkzSUppV1BON3IxRGM5U0J1aU1TYlpDVGx5dHFBbVVIdjNwalNsQWdr?=
 =?utf-8?B?bjlYcllrdWtjb3k5VHhmTlRhZjBieU95RWR0VWFpMWlqWmsrOGNRcTcxRmwx?=
 =?utf-8?B?aGNnUlZWekxKZ3pMNTJrU2VQQmpKZHdSdTZxUlpCck1LbzNTNWJkRHlFRUto?=
 =?utf-8?B?TXFyRDdGLzN1dFlmbDJCeUhaTFhaWGdONDZIRlNrUHdhTENVRFUzbGhJaW1Y?=
 =?utf-8?B?ZGJ4Z0cvcG1PM002MjRtaStadkpVZGJoUUphblA2WE5GUmVBN2tSYktGVjVV?=
 =?utf-8?B?R0Fid0s3R1g3TlJqM3Z4eC9EUjQvMlluOHM4azJscVB2VTdNMUNXbkVmSUk4?=
 =?utf-8?B?L2lWM1BiaEJ2dXpyTGVhQ1JDUUJwZndUMGwwcUV0K2l3YVZIclYrS09oMGIr?=
 =?utf-8?B?WURWZXFhbml2KzRTUGwzMlpYRGhCU21HRjBEenFpaElxcFNGOWYyZjN2b1BI?=
 =?utf-8?B?TmVOVlhPcEdjalpDelMrOHpzRVBiOEJrRDhObEh3dWFuVnFGaURsbU5WK2pz?=
 =?utf-8?B?N09MMy92bTFuRXBjSVlZOE0rc3B4K0dBWmZKdUhIdDZFSloyWDQ5RkpFL0hQ?=
 =?utf-8?B?SnV4VjVnTTVkaDViRTFXUWtIOGxGQ2YyVEtlK0pad1VUSWh0TmdZQXJvQzlt?=
 =?utf-8?B?clA1SlYxQTlzRG4xcTh4R1YxaVVrNEVPbTNmajhyY294SXd1WTBWbE5tZEZ4?=
 =?utf-8?B?M1UrMUZ2SDhGeVpza0VwVG04bGtlc1JqM0RTbDZBbGlTWDZtMWdwam84YnpJ?=
 =?utf-8?B?dWNTdmhjb1ZSaVFmOGlUTmwwMTA0T2tYUkEyRFhaSjJYQVg2elJDVXN6eG1D?=
 =?utf-8?B?UlNscmFYRHAwOHpZc3FBbU1rT21YUXRDd3RCL2xXOTUybkVvamtkdHFKRWdn?=
 =?utf-8?B?a3piVDZjWTZtUmFPNFF3YUV3TEMveHNDNUhOVHZXTVpCVk4rNEZySGo5SWtV?=
 =?utf-8?B?S29sMEgrcUVMTzdUbVN6SjZsa2t3ZzU5S1JHbVEvZjFxNkFwODREbGtJZEFV?=
 =?utf-8?B?dFl4T2EvNHQzbzRJcnFhekw1bm8wenNCREk2VDkrUEVwS3JDZjhoVm55NFNq?=
 =?utf-8?B?RDFVTzZ6ZlM5THZyZUE2ZDB5aDhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1FD5C0C9D170D46B2C7CDBA46F07D68@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rK0mfIlDlPAsVDv/U7KbsibCZvgT+wrfQaD/QB74N0+2VVI/1G4Aw2QX5Zxe182w5Oz/FgNVe1/Njv6ay4ECRQ+Vuy6ztpZCrleoJhWhNlp3ByLEonxL4ijmq0KNeGUE+Ss5iThBZFJPFwV2s2+hoYsHaAkznZrynjhu/NwqQWhWG4PQlFwv+eMMam0ioHZOYXM4tLea2yOBc9rtjKFKzpFR+d5w9YWpvvmZ2ksF5oN+Fi9VLFj8GqzmS/R/smMNswalSrSAXHikGxy/uGlpiiu8fchIKmm40BkhGILyE5iIsDIK6yh89LWcWdyjI3NKdFKUuAoN2ceNvp+zXS/VC+nzr76GPDwnZZse+24x8qwQsAjq9hPMG8LbhpIPcTQ4hWemusOFeev1Yr/449HE8mKKHv+00yobDkkWD94y8e40PoA9DNfPYQ63NRK6LqLavx0nj53H5fE84E66xCh7wMxQ32kXY7C7qRTG4peTkPbYSwb3HJZDHf0Z5Dft0nO963QJ1GIAtoh4N4d9rpw/04h3WhJjcRmh2dVlV6Rt6Aeglu7J3o6SQOfUcLlAmlNk/dwL/67d4e475pO6lHlDIy96olLA4MeoiXlnuG7JRgaJMvM2R7908+hXQ7lXo0oO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d39ac0-a6e9-4f77-7e55-08dc29472229
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 08:14:27.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cc+BSnDcjawojVUiOZKS+4ZnDII8NsaB3DpT6/Sqkg8YvMkBnapCn1w/d5CtSQXxdjGyvO7mScAmbS2/bYlHDM5ZvfIORrlO4Kgj/i7zSEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8700

T24gMDkuMDIuMjQgMDI6MTEsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gRnJpLCBGZWIgMDks
IDIwMjQgYXQgMDY6NDU6MTBBTSArMTAzMCwgUXUgV2VucnVvIHdyb3RlOg0KPj4NCj4+DQo+PiBP
biAyMDI0LzIvOCAyMzoxMiwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4+IE9uIDA1LjAy
LjI0IDA4OjU2LCBRdSBXZW5ydW8gd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4gICAgID4gLi9udWxsYiBz
ZXR1cA0KPj4+Pj4gICAgID4gLi9udWxsYiBjcmVhdGUgLXMgNDA5NiAteiAyNTYNCj4+Pj4+ICAg
ICA+IC4vbnVsbGIgY3JlYXRlIC1zIDQwOTYgLXogMjU2DQo+Pj4+PiAgICAgPiAuL251bGxiIGxz
DQo+Pj4+PiAgICAgPiBta2ZzLmJ0cmZzIC1zIDE2ayAvZGV2L251bGxiMA0KPj4+Pj4gICAgID4g
bW91bnQgL2Rldi9udWxsYjAgL21udC90bXANCj4+Pj4+ICAgICA+IGJ0cmZzIGRldmljZSBhZGQg
L2Rldi9udWxsYjEgL21udC90bXANCj4+Pj4+ICAgICA+IGJ0cmZzIGJhbGFuY2Ugc3RhcnQgLWRj
b252ZXJ0PXJhaWQxIC1tY29udmVydD1yYWlkMSAvbW50L3RtcA0KPj4+Pg0KPj4+PiBKdXN0IHdh
bnQgdG8gYmUgc3VyZSwgZm9yIHlvdXIgY2FzZSwgeW91J3JlIGRvaW5nIHRoZSBzYW1lIG1rZnMg
KDRLDQo+Pj4+IHNlY3RvcnNpemUpIG9uIHRoZSBwaHlzaWNhbCBkaXNrLCB0aGVuIGFkZCBhIG5l
dyBkaXNrLCBhbmQgZmluYWxseQ0KPj4+PiBiYWxhbmNlZCB0aGUgZnM/DQo+Pj4+DQo+Pj4+IElJ
UkMgdGhlIGJhbGFuY2UgaXRzZWxmIHNob3VsZCBub3Qgc3VjY2VlZCwgbm8gbWF0dGVyIGlmIGl0
J3MgZW11bGF0ZWQNCj4+Pj4gb3IgcmVhbCBkaXNrcywgYXMgZGF0YSBSQUlEMSByZXF1aXJlcyB6
b25lZCBSU1Qgc3VwcG9ydC4NCj4+Pg0KPj4+IEZvciBtZSwgYmFsYW5jZSBkb2Vzbid0IGFjY2Vw
dCBSQUlEIG9uIHpvbmVkIGRldmljZXMsIGFzIGl0J3Mgc3VwcG9zZWQNCj4+PiB0byBkbzoNCj4+
Pg0KPj4+IFsgIDIxMi43MjE4NzJdIEJUUkZTIGluZm8gKGRldmljZSBudm1lMW4xKTogaG9zdC1t
YW5hZ2VkIHpvbmVkIGJsb2NrDQo+Pj4gZGV2aWNlIC9kZXYvbnZtZTJuMSwgMTYwIHpvbmVzIG9m
IDEzNDIxNzcyOCBieXRlcw0KPj4+IFsgIDIxMi43MjU2OTRdIEJUUkZTIGluZm8gKGRldmljZSBu
dm1lMW4xKTogZGlzayBhZGRlZCAvZGV2L252bWUybjENCj4+PiBbICAyMTIuNzQ0ODA3XSBCVFJG
UyB3YXJuaW5nIChkZXZpY2UgbnZtZTFuMSk6IGJhbGFuY2U6IG1ldGFkYXRhIHByb2ZpbGUNCj4+
PiBkdXAgaGFzIGxvd2VyIHJlZHVuZGFuY3kgdGhhbiBkYXRhIHByb2ZpbGUgcmFpZDENCj4+PiBb
ICAyMTIuNzQ4NzA2XSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTFuMSk6IGJhbGFuY2U6IHN0YXJ0
IC1kY29udmVydD1yYWlkMQ0KPj4+IFsgIDIxMi43NTAwMDZdIEJUUkZTIGVycm9yIChkZXZpY2Ug
bnZtZTFuMSk6IHpvbmVkOiBkYXRhIHJhaWQxIG5lZWRzDQo+Pj4gcmFpZC1zdHJpcGUtdHJlZQ0K
Pj4+IFsgIDIxMi43NTEyNjddIEJUUkZTIGluZm8gKGRldmljZSBudm1lMW4xKTogYmFsYW5jZTog
ZW5kZWQgd2l0aCBzdGF0dXM6IC0yMg0KPj4+DQo+Pj4gU28gSSdtIG5vdCBleGFjdGx5IHN1cmUg
d2hhdCdzIGhhcHBlbmluZyBoZXJlLg0KPj4NCj4+IEkgaGF2ZSB0aGUgYWNjZXNzIHRvIHRoYXQg
bWFjaGluZSwgYW5kIGl0IGRvZXNuJ3QgcmVqZWN0IHRoZSBjb252ZXJ0IGFzDQo+PiBleHBlY3Rl
ZDoNCj4+DQo+PiAkIHN1ZG8gbWtmcy5idHJmcyAtZiAvZGV2L3NkYg0KPj4gYnRyZnMtcHJvZ3Mg
djYuNi4yDQo+PiBTZWUgaHR0cHM6Ly9idHJmcy5yZWFkdGhlZG9jcy5pbyBmb3IgbW9yZSBpbmZv
cm1hdGlvbi4NCj4+DQo+PiBab25lZDogL2Rldi9zZGI6IGhvc3QtbWFuYWdlZCBkZXZpY2UgZGV0
ZWN0ZWQsIHNldHRpbmcgem9uZWQgZmVhdHVyZQ0KPj4gV0FSTklORzogbGliYmxraWQgPCAyLjM4
IGRvZXMgbm90IHN1cHBvcnQgem9uZWQgbW9kZSdzIHN1cGVyYmxvY2sNCj4+IGxvY2F0aW9uLCB1
cGRhdGUgcmVjb21tZW5kZWQNCj4+IFJlc2V0dGluZyBkZXZpY2Ugem9uZXMgL2Rldi9zZGIgKDUy
MTU2IHpvbmVzKSAuLi4NCj4+IE5PVEU6IHNldmVyYWwgZGVmYXVsdCBzZXR0aW5ncyBoYXZlIGNo
YW5nZWQgaW4gdmVyc2lvbiA1LjE1LCBwbGVhc2UgbWFrZQ0KPj4gc3VyZQ0KPj4gICAgICAgICB0
aGlzIGRvZXMgbm90IGFmZmVjdCB5b3VyIGRlcGxveW1lbnRzOg0KPj4gICAgICAgICAtIERVUCBm
b3IgbWV0YWRhdGEgKC1tIGR1cCkNCj4+ICAgICAgICAgLSBlbmFibGVkIG5vLWhvbGVzICgtTyBu
by1ob2xlcykNCj4+ICAgICAgICAgLSBlbmFibGVkIGZyZWUtc3BhY2UtdHJlZSAoLVIgZnJlZS1z
cGFjZS10cmVlKQ0KPj4NCj4+IExhYmVsOiAgICAgICAgICAgICAgKG51bGwpDQo+PiBVVUlEOiAg
ICAgICAgICAgICAgIGU0OWM1ZjczLTM1ZGQtNGZhYS04NjYwLWRkMGIzZDAyZTk3OA0KPj4gTm9k
ZSBzaXplOiAgICAgICAgICAxNjM4NA0KPj4gU2VjdG9yIHNpemU6ICAgICAgICAxNjM4NAk8PDwg
Tm90IHlldCBzdWJwYWdlLg0KPj4gRmlsZXN5c3RlbSBzaXplOiAgICAxMi43M1RpQg0KPj4gQmxv
Y2sgZ3JvdXAgcHJvZmlsZXM6DQo+PiAgICAgRGF0YTogICAgICAgICAgICAgc2luZ2xlICAgICAg
ICAgIDI1Ni4wME1pQg0KPj4gICAgIE1ldGFkYXRhOiAgICAgICAgIERVUCAgICAgICAgICAgICAy
NTYuMDBNaUINCj4+ICAgICBTeXN0ZW06ICAgICAgICAgICBEVVAgICAgICAgICAgICAgMjU2LjAw
TWlCDQo+PiBTU0QgZGV0ZWN0ZWQ6ICAgICAgIG5vDQo+PiBab25lZCBkZXZpY2U6ICAgICAgIHll
cw0KPj4gICAgIFpvbmUgc2l6ZTogICAgICAgIDI1Ni4wME1pQg0KPj4gSW5jb21wYXQgZmVhdHVy
ZXM6ICBleHRyZWYsIHNraW5ueS1tZXRhZGF0YSwgbm8taG9sZXMsIGZyZWUtc3BhY2UtdHJlZSwN
Cj4+IHpvbmVkDQo+PiBSdW50aW1lIGZlYXR1cmVzOiAgIGZyZWUtc3BhY2UtdHJlZQ0KPj4gQ2hl
Y2tzdW06ICAgICAgICAgICBjcmMzMmMNCj4+IE51bWJlciBvZiBkZXZpY2VzOiAgMQ0KPj4gRGV2
aWNlczoNCj4+ICAgICAgSUQgICAgICAgIFNJWkUgIFpPTkVTICBQQVRIDQo+PiAgICAgICAxICAg
IDEyLjczVGlCICA1MjE1NiAgL2Rldi9zZGINCj4+DQo+PiAkIHN1ZG8gbW91bnQgL2Rldi9zZGIg
L21udC9idHJmcw0KPj4gJCBzdWRvIGJ0cmZzIGRldiBhZGQgL2Rldi9zZGMgLWYgL21udC9idHJm
cy8NCj4+IFJlc2V0dGluZyBkZXZpY2Ugem9uZXMgL2Rldi9zZGMgKDUyMTU2IHpvbmVzKSAuLi4N
Cj4+DQo+PiAkIGRtZXNnDQo+PiBbMTQ2NDIyLjcyMjcwN10gQlRSRlM6IGRldmljZSBmc2lkIGU0
OWM1ZjczLTM1ZGQtNGZhYS04NjYwLWRkMGIzZDAyZTk3OA0KPj4gZGV2aWQgMSB0cmFuc2lkIDYg
L2Rldi9zZGIgc2Nhbm5lZCBieSBtb3VudCAoNDE3MikNCj4+IFsxNDY0MjIuNzM2NDE1XSBCVFJG
UyBpbmZvIChkZXZpY2Ugc2RiKTogZmlyc3QgbW91bnQgb2YgZmlsZXN5c3RlbQ0KPj4gZTQ5YzVm
NzMtMzVkZC00ZmFhLTg2NjAtZGQwYjNkMDJlOTc4DQo+PiBbMTQ2NDIyLjc0NTUwOF0gQlRSRlMg
aW5mbyAoZGV2aWNlIHNkYik6IHVzaW5nIGNyYzMyYyAoY3JjMzJjLWdlbmVyaWMpDQo+PiBjaGVj
a3N1bSBhbGdvcml0aG0NCj4+IFsxNDY0MjIuNzUzMzg4XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2Ri
KTogdXNpbmcgZnJlZS1zcGFjZS10cmVlDQo+PiBbMTQ2NDIzLjMxMzAwMF0gQlRSRlMgaW5mbyAo
ZGV2aWNlIHNkYik6IGhvc3QtbWFuYWdlZCB6b25lZCBibG9jayBkZXZpY2UNCj4+IC9kZXYvc2Ri
LCA1MjE1NiB6b25lcyBvZiAyNjg0MzU0NTYgYnl0ZXMNCj4+IFsxNDY0MjMuMzIyOTU0XSBCVFJG
UyBpbmZvIChkZXZpY2Ugc2RiKTogem9uZWQgbW9kZSBlbmFibGVkIHdpdGggem9uZQ0KPj4gc2l6
ZSAyNjg0MzU0NTYNCj4+IFsxNDY0MjMuMzMwODA4XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTog
Y2hlY2tpbmcgVVVJRCB0cmVlDQo+PiBbMTQ2NDQ2LjMxMzA1NV0gQlRSRlMgaW5mbyAoZGV2aWNl
IHNkYik6IGhvc3QtbWFuYWdlZCB6b25lZCBibG9jayBkZXZpY2UNCj4+IC9kZXYvc2RjLCA1MjE1
NiB6b25lcyBvZiAyNjg0MzU0NTYgYnl0ZXMNCj4+IFsxNDY0NDYuMzQ1NzM1XSBCVFJGUyBpbmZv
IChkZXZpY2Ugc2RiKTogZGlzayBhZGRlZCAvZGV2L3NkYw0KPj4NCj4+ICQgc3VkbyBkbWVzZyAt
Qw0KPj4gJCBzdWRvIGJ0cmZzIGJhbGFuY2Ugc3RhcnQgLW1jb252ZXJ0PXJhaWQxIC1kY29udmVy
dD1yYWlkMSAvbW50L2J0cmZzLw0KPj4gRG9uZSwgaGFkIHRvIHJlbG9jYXRlIDMgb3V0IG9mIDMg
Y2h1bmtzDQo+Pg0KPj4gJCBzdWRvIGRtZXNnDQo+PiBbMTQ2NTMzLjg5MDQyM10gQlRSRlMgaW5m
byAoZGV2aWNlIHNkYik6IGJhbGFuY2U6IHN0YXJ0IC1kY29udmVydD1yYWlkMQ0KPj4gLW1jb252
ZXJ0PXJhaWQxIC1zY29udmVydD1yYWlkMQ0KPiANCj4gSGVyZSBJJ2QgZXhwZWN0IGEgbWVzc2Fn
ZSBsaWtlICJjYW5ub3QgY29udmVydCB0byByYWlkMSBiZWNhdXNlIGZvcg0KPiB6b25lZCBSU1Qg
aXMgbmVlZGVkIg0KDQpZZXAgdGhpcyBpcyB3aGF0IEknbSBzZWVpbmcgb24gZm9yLW5leHQuDQoN
Cg==


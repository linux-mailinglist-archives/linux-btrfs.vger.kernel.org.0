Return-Path: <linux-btrfs+bounces-9388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC589C16C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 08:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE381C20FC3
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0621D0E35;
	Fri,  8 Nov 2024 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YHBKlm9M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j+016uyJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B93DDA8;
	Fri,  8 Nov 2024 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049694; cv=fail; b=lgA/ZhIlpv1iBSrNhqUm4M1RUlHYuvX1FsWGBs2/xS8k+8F8+y9dNUUou5dD5xir5Biho8vweR5YFO+prLhaolzjvoapSbe9e25Df0ddJIKVsYsoBVfs1JllAD5Or6JIHg7bGNZpNJukQ1Apmn5po+e0qUpTwXuiuuFOTKV/V1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049694; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FATHFIqNBkfSejF4/4Muuckpv9Ij6MDRwUQUZ6hyWan+GX02aw9x5U4Ewccx33qAJcUGUIlKIWMIenHSI4HCQ9HjcGNNy+msbrPMsTd5HprNFLcNtyUGUqq5arEoGYwIBYzrHm/03+9TknvNL/hyBksEnkJ/uFHVpSYYs7zRExo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YHBKlm9M; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=j+016uyJ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731049691; x=1762585691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=YHBKlm9MBkglL8cnNTl84DG2sO8ZZWwbSxwqjv9smV5avg1BYuz5/Rej
   1Et+nhgLecIP6LV6J2xwbl17PT3Rfoy+WE72Bib0hUathRG8S7FhSzc0Z
   OwDwcal98tPLLWaNBjoKzj8u2cnEtxerfQaIf7jGBpNZsSm1KlTcJDGGy
   ujd4EiTbxhxkh+x/jxVcIJIxyzYq5EkwCqJhsRxJuzqE8e8dXOJbLGkcY
   JhSG/RFPUxt7fHkpHEPk2lRfPWNIgL3R/3Y0Xzj8Ok/y+Qz11RqQ5a12A
   8vpBQQVsLhpjGz+XQ2LhZogeK79DU3vZ3amDD8wt6e7x8ydTHvUUao1RO
   A==;
X-CSE-ConnectionGUID: hH+At0eXRSyPsp1EWFJFqg==
X-CSE-MsgGUID: 3tPl2wPpQOOh7HMqL/DBGA==
X-IronPort-AV: E=Sophos;i="6.12,137,1728921600"; 
   d="scan'208";a="31961879"
Received: from mail-eastus2azlp17010020.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.20])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2024 15:08:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhkgPWY/GgziuGNKEkvbLTcy5fOtPEIHjxJUknzv7q+PPoqHb0tOqReajnf1+pWLmxI0qfImHSOaxY6AMUON1zz37BG9fqlmXISVdxKWT4gLliUQvoIRDs+YazpdVz27TYqCcyxehuWqGGnxJh+sDLOwv8e6NyYiaYL3c9VFPTKv7be3kQSh5cZ+Ok9UXuWm+h8VYJHJyy2N76DC/q7WeZS24m4ypZz8CV7y+J8LYYgGS8gWF8fBVNaibAVWdnhjsQgl111JxH9TDyRLHBzCZY2+rsB27kt5hORdoPSvkUfQkZArHzokebkPKzrgF1mjIDmk0e46ma7OnSLKgtzrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=CXNAFCzVI1cUEZtKmhXrV9vPawIThCZI8FQONlG2L9HSB3h1jsJuPPNOYOFcGAXREaZIuhPMtX1Gwa7RzPtgAB9JR83CkGcluLnBkheBdeuoPLDsXFeVG6EiCQtTKKhwM8z4VRnXcDHxt25kxXspwOdzh9lWJuOw+yqL9IJbflfd6iM0hs6g4ahJOIQFLaBjgDZeaGLdG7cQHvU98n80myesicOZSiC6lsGH9TSjEIkwZwl23Et/OEnyvK8El2u0T13ftcq1dmt5Bw06FLdoDv6D6R+Q0t0w+Dgszf1S5mpuWOh2iuCrObPx0DftTGP6CnQ0Pg+cit6tZz4/BkolCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=j+016uyJ6d906cYHk1WHXwWDyg7rq7xQGyO8iwcvCHM8b7TuMuZ/JEVU/bQ2CMJ6SPq8THuS5c8H0MtpQeu6P0XnKUTWW26xIaiBuIt14r7Thu9KWe4spp7xbcm+XNdXLramaMFGdwhBNhf14RM2w8aFcz/6AeKCmA2iZx7OytY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7400.namprd04.prod.outlook.com (2603:10b6:510:13::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 07:08:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 07:08:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH 3/5] block: lift bio_is_zone_append to bio.h
Thread-Topic: [PATCH 3/5] block: lift bio_is_zone_append to bio.h
Thread-Index: AQHbLoKc3xFoIYPi7UKgo+zsZlykWrKs/OUA
Date: Fri, 8 Nov 2024 07:08:06 +0000
Message-ID: <d3ced819-81a7-444b-b6ca-e5f1904674e2@wdc.com>
References: <20241104062647.91160-1-hch@lst.de>
 <20241104062647.91160-4-hch@lst.de>
In-Reply-To: <20241104062647.91160-4-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7400:EE_
x-ms-office365-filtering-correlation-id: 6cc5b637-790c-4733-9ab6-08dcffc41872
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2orclhpc2M2d01qYkNHaTVuWEphZlVnR0NOU21SdE0rK2tKK3JSQ2orY0s1?=
 =?utf-8?B?Tks1QU82N2YxcUFHbFBHUkM2dEF2U3lLbjNiODB1a2hxbmpwaUg4U1BWczE2?=
 =?utf-8?B?dWZCZWRXTmpxOWl4N2xPRU5pS2tsazc4UGZsYS9vTFhZU3VicWVUZFlhdkhy?=
 =?utf-8?B?QUZ4ZjR4ZUh5dTgyYnNoYjFNdG9PclBIQTFtVEZrTkJLakpPWlBvdzFxVGNI?=
 =?utf-8?B?MkpIa1BDSmlycWsrbmhUdEhPbUZHOHVBMElTVER1ZkR4SmVBaE5pZU1EU2hL?=
 =?utf-8?B?bzdWN0pYU1dxN3lEdkU4VHBZWEd5OWtKSEJ5eDB5VDBzdmNIWXVXblRWekNJ?=
 =?utf-8?B?V1pJb2N2MlB2M25QbjhhYXo2eU84MXVoSjA0WTBCVi8yNG1FWkNIYkp4Qktz?=
 =?utf-8?B?TGxBczVIN3dKaGNnV3J2UjdENHgxL2ZCbHpaQ003OU1rcE40eXMxckNUbDkr?=
 =?utf-8?B?QVRnSTBrZDFIWVljcVVTS3YvdjhkMlZCTVZINHlZM3ZEWGVFL01oTUp5SFhm?=
 =?utf-8?B?Tk9FbFgzdTBsZ09JSVVvWVlNbVF5bEUrMnhXOE1KMWE2N0JBR0wxVENYcFZl?=
 =?utf-8?B?QWV3R3FUdG1FdWVsQWVqM2kzeXl3bzZOblM5KzhKMUI4OWlnVG56OFpFMnM3?=
 =?utf-8?B?b2Rra3dWNE9WQnR3VGNuUzk5aU9vbllWZnRwV1gwUjlCTEVoNDhlRllVOEd0?=
 =?utf-8?B?alpBWS9NQnllVHNFR1VJSW9LeFhKZVlYUDN0TzNkZ3VqL0tGUlRiSkduUEJX?=
 =?utf-8?B?bStFQXhKaURJM0R3aHhuVTBUSjhsNWpFODZhZEY1N3ZCRVFtVmpkOVRqR3JU?=
 =?utf-8?B?dkdCOEVWQVQ3eklhZWNRTWVOSnF4cjQyUjlPbU1kY1pUWUFOd2RuaUZHM2hB?=
 =?utf-8?B?eHVxVjZ4UTVqSEM5endyZnB5QjBNcC93TEJpUnpjOFlVQ1k3ejZDbFJ3SXA1?=
 =?utf-8?B?ZEdXdzNJa3p5NTVBSGZIL0N3UU95VDF3SWNqRHZkem1CMVB4ajI0SnYvZWR4?=
 =?utf-8?B?MFRQSWVLRFlWbi9RNUJZTmtCNjFOck5iZURXZnVmVTNYTmNCbFIzdXI1NFRU?=
 =?utf-8?B?M2tTdG92WEw2WjFxZ1JHR3ZtZEEyS1JOMy9kem5KemtiaGhqNXR2Z1YyQU5G?=
 =?utf-8?B?L1hidGRtcFJqeFRmTTB4VUxOYTZTK05wS3Z5N2h6bjBCbHVuMmRxQU5DZFIz?=
 =?utf-8?B?dHNpK3dMeDYvMFJIbTRMdkY3aDFvMkIyK2NhQ3ZhMW5XSjN2TUFtUzNSdFF3?=
 =?utf-8?B?TXl1Z3R5SWhZTkhlbGVlWCtjYmo1bkF2Qm5rQ1dvU05hdC9kSDcvMTg2dTht?=
 =?utf-8?B?bDRqaWFIN0RIbVB0QkhuM3FaaU5IeDJrMGUyNTV4dUhKYk5NVFFMaDVBUXU2?=
 =?utf-8?B?TFN5SGNuTzdyYzA5MzVieFNqU1FjVmloa1RBMCtqVGU0bytEekpiRXREK1lD?=
 =?utf-8?B?NWhqN0pVWXJUZXlseUxJR0w1NzVXQ20zVTFvaGh6SVNPc1JybDlHUDQvUUsy?=
 =?utf-8?B?L1luUFd2NTczR2Fsd3VsanJ1dDQ0ekcwYWFCRWZVOWh6SFkzNVI3K2ZhRTIw?=
 =?utf-8?B?bDNDaFVMb3RleDBtblZvRlVHNFZLbnMyejh0RXl1ZUFEUHFCQWU0M0hBb0tQ?=
 =?utf-8?B?Kzl2RjlBZmlIT3JLeU5ZT3hzNkdNWUxiUVpXRkxQY3ZUenNISWlQM2lqWktQ?=
 =?utf-8?B?ekQyYWxrRXJZNDN5V1ozczJKQjJFZFdTUXkzUUhnaUZ5a255cUVpelZLRzhX?=
 =?utf-8?B?M3hKUVdWUklXR0I0dFhpZUQyckl2cG9NT3lFS25FaHFJSTl6ajZPcFdmOFNj?=
 =?utf-8?Q?p8zAdxNxz8QkjLyWdgavx2kboSFuH+/Hh8SVA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGcrLzZOL2FtZ0FEYlIwc1lqTWtUaUtFNUVmUmNqUHVmVEFPcHk3Q2JCeVlL?=
 =?utf-8?B?QzFLdERsdmhUMWVUM1FLUlNEUDQxQzFDMFFOTU1udGRBcFkyQkxaREFoOXJp?=
 =?utf-8?B?cGdyN2xvUDRod0ZxWnlBd1NIMktBdUFMTldBMnhPanVGVWkrUUN1Tk9VNU9H?=
 =?utf-8?B?RlF5T0NWc3NwdkpBVUZCOWVZUEl4RFEvUk1rTDk1aGlKMG0vSHBzSFdldE44?=
 =?utf-8?B?R3lpYU5ieXNMb0JxVyt5dks0aWRVL0JGdCttT0lDZUJLOXhxVkUxazkrOW9z?=
 =?utf-8?B?eDgxRmdjQXJGK2RnT29BYk1CUWpJcERIWno5T1lFWDBnTWxyc1hMMHIvd1l3?=
 =?utf-8?B?SU81QW1zZVFqSjA5R1BsbEh4OStVOStKcmtVbElLSHRTZnRWQ1lyRnc1dDRZ?=
 =?utf-8?B?L3NoNURSOTN5b2k4MnBMSkg5azh6TlNQb2dreC9KanVDQVRDRXBXL0hHYlZW?=
 =?utf-8?B?Vko2aGN0bm9paFBud1ZaYlJvRFpmVGtGd1M2VkZQZ0xSVmNKRDJ3Q0JUdjZt?=
 =?utf-8?B?ZUwrV25laHhlalo0eXNZT1NMR1FLeWNxbGt2aVdmMDN1ZU90cU04TnNHTDNM?=
 =?utf-8?B?QzdDQ3ZiZk9GYVYyWDFRSThySUlZS3lleGFMbjdtRGVKSWhNMXEya3RyVXdC?=
 =?utf-8?B?bllxN1pHTVQwck16TG1ycW5pVHhoQlJJVWxmQWFhQ1pGNjQxUWRTak40V1pq?=
 =?utf-8?B?dGJnMlVnNlhJQzZVWHJZUGtVTXI3dDFyTTU3KzYwcTJXWjdvQXlvSG1IdkVn?=
 =?utf-8?B?NnlCbUdSQkhaUHRmNGM2K2dncEJSRHVHamhMc1piaWM1RWRCK3BjeFllWTlT?=
 =?utf-8?B?aVZFWmZmSFNSMTVVWHY2MDAvYldTU3IvcUgrYk1rTTE5bjNXcUJleVdDc0tV?=
 =?utf-8?B?TFZINTBoQ3FqcDFteXJ2UlZSYkZacW5IMkNlTU9Da0JTVlkvV25tSUZ0cUFO?=
 =?utf-8?B?NG4yV24rclF3S3RiZUVnMU41TWQ2M1h5ZFo2VC92RFdaWCthYkx3bnJaaE53?=
 =?utf-8?B?dDJEUmRTdEVIV2dwTGtxc1JjSkxSUVBXWmxHSFN2ajhxNHJMb0QrUWVMenYv?=
 =?utf-8?B?T3lxampmOGVweERmbTMwR0tOMVdsYS9ONlcySjA2WFBHRnhxa1pyVjgzcGV6?=
 =?utf-8?B?QjRrNVpLYm9UaW5EaUdpSjlWTGtVNWVSNXpGaVVXSVBuOTQvY1poN2xKd0pS?=
 =?utf-8?B?eG9mUHAvd3hMNFhPRldkYWs0WXhzdWVYK3MrTGxvby8wS0hVelc1UGtGQ2Qv?=
 =?utf-8?B?NTZQcERCakxHbDVXQ1ZROFV6dlFuUUlqejlSelFqTFJlQXRpOFVmWlZNcWts?=
 =?utf-8?B?S1RlZHlIQTBIS3ZhcTUwVWwveXVqcWsxUC9ZV2lPWDFheVVLRnVxSHVBcFVO?=
 =?utf-8?B?U3NFWTUyVUpWMjNOOFhORDZ5MnlRYWFZZnJSd3BOVk5oZU84cDRqT2dzZy9H?=
 =?utf-8?B?U0pnbGVsY2dPUm1HNG1JVVFGbm9idkRmc1lTelJUN0pZdWJqaTJteklreGw0?=
 =?utf-8?B?U0ZDMnhwS1N3YzI5STU3cXV6VDRPMHNLdThLeG84emNqeFU3WndGYVkyb25y?=
 =?utf-8?B?elhzdkUyalA0NS9UclVlcHhmNTlFcm5IU1BXbUJxS0cwT0kyQU9pZ214cnli?=
 =?utf-8?B?VUJ6TzNZaU1XNjdEaEQrMDhNVitLQTBuSE10WjZrUzA2ank2WVVnSzlvWkw2?=
 =?utf-8?B?MVgxQjNlZTBQSzhSalNDMkQ3dElwbm1SV0xHUXh1aUxPTGhaTnFheWNTRVF4?=
 =?utf-8?B?STBpRHZ5U2IrenhLK2tLVTZmNXZkYkNMU1l3ejU4Q1hsWHRHMENKMDhSYkdy?=
 =?utf-8?B?dXNGWlRBYk1yRXZBWDZCSFZNQ2RaN09IcmR4RWdsOGErSno3N1cyc0lYakx3?=
 =?utf-8?B?aXh2NUV1OUJYbW5sMkJSV3c2cFMxaWYyTmg1akU3M1hFY1FnbmhGYWM4MWM4?=
 =?utf-8?B?M2xlbVhBL3NrYnNQNDlYaHd2VSt3OXE4NmdOb3hkNmIzL1ZFSFUvM1VaNDBF?=
 =?utf-8?B?cjU3d2JLQXBDL2VVMEg3aTliVm5oRnhDRjJ5ODNMNXZZek0wWm5kS3FUL1Zk?=
 =?utf-8?B?K3BTeXN3U3I1cFFiQVZxb3EwTXRCOHpRUmhiZmZEUGFUTyttdUozL0FBTzlQ?=
 =?utf-8?B?aWpaNDRYRXpGQjhOWURDa2VJY0JpcnB4RGpkUGh3c2p2MTllQmtDTFcxdTlR?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E8D884541B276488441C1C06AD05D1C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LTvJl1sQ1pxy5g2jlGKPp5dJ8/70QpjnOaxPyc058kq4t5L6cdM3sbNZAfgSr16XOFYBXRGT66LCldbLtiu3eWsHAkByRs6luDps7w0tWlFLpnVgihqPG3nsff4L8SL4TJdNK08qXgaIXPRbQVLXthjIZ4AFDJ0W0L7y4tsFuex/Nz71XRKG9n8CZcSLTqJ9ZDRag5ygmsolRWSMpZH1jHFf9Q1etEqUGifLI8zI4rwHI5HkMPnel8WosOEdErTHPcSh9UyGEXJCdKW5Y+FAGgGZp/OplUpftfcZND+6D/g5xgBQ3DiLlLw+uSYYV1tITsQFqemQqxPHcI2DtuGzj/10x2/bh/hdZ6X1v50zR1YaXPt050+shp5cnrtmxnyYNRefAZ6V0vTnjaDXzOqZ1WaH3VT+i1q4id0gYqn6W6JPaKENvZ34ymizm3Bg0EBHt1MpqKJZ6Q4jPJ9wX5Sgz8qE9S1L7zOPSIjga7qXFuah0o9SZTJq3iZjXbNl3h9wFQZ1ShGvIQMq7BreORWWPVEhGx7EA+mLjZFnoeSHwt1UfhMGQuRYC/Y6MIMN/MiLBPF4E/7q3eYAv2L03bIYjDLOSK7V6ZMmKjiC0nSuh0QV3cwXtUaq2QctQt5Av265
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc5b637-790c-4733-9ab6-08dcffc41872
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 07:08:06.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/f9CDzracfVgjjyV8yfMVmoxUoAWPEhGVe6jRQlbPojx4sPK81v/g4y545HO58CVqTAuopcZWibVMr5GHpwZDyN/2Bt4onLopmex1sHh74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7400

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=


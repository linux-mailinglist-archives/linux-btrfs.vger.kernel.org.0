Return-Path: <linux-btrfs+bounces-16877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B8AB7E0B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6523B485F7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 06:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E618529898B;
	Wed, 17 Sep 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E2iZlZhb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="r9u3TfWI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAD2798E8
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091461; cv=fail; b=eNePS8Q45qg2G3PyRX058tBbfOPhDW7DR3UB8BUo1+3i3eWpT8tQKbZ/mMd6H2ICKsnjkT3R7K+JDRB/sFwt/fAKzA9RJrj4i1+Mu4Xlun7BARopTqIqQT/RxKFrdJxkCtfmyZdunMJFiAG0bA/l0RXhGhTv3MMrDAMdbFYXQUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091461; c=relaxed/simple;
	bh=c6tfWfhOjj2WngD4pOcRTeT9aZNoFQWQRIF5/Tz70HQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h6KX3et1fVHQOm8T0RI8gL7zWJZaXkMWRn86S8KW5t6SRL9WqYkRsWj7fFb3E6N5CG+jgtz/E7ZbIAfCCdOLNlPSaCQbNjmWx/IJfpFnvVgsxw0+4NcfvEyLaqpRbUP4vMbsBCYDLPrQnCd/WLsKTBxDUKM7XrE6GWiGh6TmVcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=E2iZlZhb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=r9u3TfWI; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758091459; x=1789627459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=c6tfWfhOjj2WngD4pOcRTeT9aZNoFQWQRIF5/Tz70HQ=;
  b=E2iZlZhbAa9xn9NfPVx7Q6baslLmBGNxr3qh1DOXaxbhptJ5C6vao9NW
   uM79irA6fd/epnTyGdbvDULFhuj1cTSwdeoKaGCHyTKx0PCXpt3JGm/6V
   preolTRKjQPxRKKY0j6uz4BQ65t4IODkcAlJ3voU7na/hpeTyKDE85yYq
   eY5HkXw7cGV1UoNqCoTM7fIi2gbdYqY3CQJDjLys437uFiqX1HbzMVZXU
   GM+xbzdMkrOLZwRriek8emGoPSn05YKavZpJkfErWHHpU7JHY3hq1gvTD
   XAArbrl9BSVAJzUp2C61yRhy3cl5Ee7kL/bYiUlwDjCLK0j1FnWvr8iFY
   Q==;
X-CSE-ConnectionGUID: O3/PQtP6SueGObGmLbFUNA==
X-CSE-MsgGUID: 2IhdiLvwT/24A7K4humk5Q==
X-IronPort-AV: E=Sophos;i="6.18,271,1751212800"; 
   d="scan'208,223";a="123914201"
Received: from mail-eastusazon11012013.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.13])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 14:44:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aG+hStDKp9+jfE67kYoe+6+jGOxIG/FIXZghu/CZoB+zYUG6tL/5tbmnh2HN5g16lh2XdKiVenCLRTFC2boH5ncqnSTwL8eE+b0ZqqlHmF0+FD2uWDCauMRh4ZxYDiouOufGQZvn6SzGXZuBYMu/dlwcI/l6LjIciOEb3TIWtPdN2o98VHzrxP1opnz2DmJksrL8zvcnAC4lSiR0svX3WAy5qnxWlWprV4iep0uvJkmJE9+oFLF5RcOtPkcLDyohGcCcZgVeHeKbovz02GoYEpeNq6Py8ZZj/7y5K1BmPMIo3l7jhkqDpGli1ejoRUm7YCRmz5d9cO4M+VXyCzz0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RchBkewalT5hBUnGOUfnkx1HkFKm/HZuUMAf+gh1xJ8=;
 b=zLjJGotdqkWIoxQ07In/NMCbTCIIk2n6cmNedWAQOH/Xwf3Tzp/bgKrCd5MqB49n+I6aUCV9pds6H1R0G1G7dqKFNAvVUbE+b/5fTP+X2iTnUBOMqVrfyvvIAmOl6J+7XlGGy+NtSV/RoSL1VH6YYIvn62SFrUkU4r5uO5QgUp/NyC5Y+DShYMJJeKfSYBf4XjyOtGqOGIC36zesUkFhdCCyjT3T/BouvXH/7qDTOP+jvlfRBiO34ezvGFb54mcg/2leCd9nP6rI5gB4aS+PaJTjAoyGtyi0mJiPnpMpR4FsZwlkUmphI0T9yenlVcpO0cEFb7ePoXKPSdCP9VHolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RchBkewalT5hBUnGOUfnkx1HkFKm/HZuUMAf+gh1xJ8=;
 b=r9u3TfWIQFlAVwy/MwPxsO9MIjwOpDXWd5z5dagzgQxe9pr7M6YuZHLaELEYrySknYzOll+4WJYwtg7c3EgkIN6dZBGnSh2BSLZSEoJkjccDjJvkgA3sobDVd1JbfIBe1bJ9zI5M61xLdqfPxwbyIBRwxA0o05l3y3GzJfV56G8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9671.namprd04.prod.outlook.com (2603:10b6:806:43a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 06:44:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 06:44:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>
CC: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs
	<linux-btrfs@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro
 Aota <Naohiro.Aota@wdc.com>
Subject: Re: performance issue when using zoned.
Thread-Topic: performance issue when using zoned.
Thread-Index:
 AQHcJWG554cLgRNI6kq+V/MRpm0fY7SSfW+AgAGm74CAAA0WgIAB6tOAgAAB6ACAAAoMAIAAoakAgAAoUIA=
Date: Wed, 17 Sep 2025 06:44:15 +0000
Message-ID: <b86ab184-7028-4d58-8acf-1f995348a6f6@wdc.com>
References: <tencent_694B88D85481319043E0CE14@qq.com>
 <873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
 <BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
 <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
 <2F48A90AF7DDF380+1790bcfd-cb6f-456b-870d-7982f21b5eae@bupt.moe>
 <1c5e2ef7-f2e5-401d-8acd-0605b117dfcb@wdc.com>
 <43f21464-c084-42e0-bb5a-0572e3385b02@wdc.com>
 <tencent_6AE63A4E1F1CC94E1625B595@qq.com>
In-Reply-To: <tencent_6AE63A4E1F1CC94E1625B595@qq.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9671:EE_
x-ms-office365-filtering-correlation-id: 0afc195a-ff21-4eaf-9624-08ddf5b59e9d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjZFeHpOSkJEQzlYNFBWUFZYcWt6L0J4ZlNlanRZMVgvRXcwRGlyVFgyVFZk?=
 =?utf-8?B?RzZOSVY2aUcvWEk0c2svRDIya21IWFQ3UVZYUGFwVzBvOXdxalBwTVhRcHdT?=
 =?utf-8?B?cE9RUjhJY0FsQVp5eXMzUWc5OEh3enE1N1QyL0d4TndXcm1kWGdJRU5hV09l?=
 =?utf-8?B?dU01NG41WWx1OXNZTTRtOEtUYjNDTlVMQ2NjUDQ4V1Z3RGFyVGxjNVlxOXc2?=
 =?utf-8?B?a1VrbVRmVVB1d0h1U2R4N1pvOFRhVisyTkdVYVlQYTlLcVZCek5DVzVZU3lv?=
 =?utf-8?B?eXQ0bHNOT3RvanBRcW9QT2VRNHh2QkFSaEpheElJblFEVkhFcnlyNE1jR2J6?=
 =?utf-8?B?NTY3Y29yOWRtbGxiL1NtT0pXQXUzZVhVTVdncElrV3JpU1k5OG5BakVpYVBw?=
 =?utf-8?B?aXBkUGpGRStnTG9aK0g5c29lWFRoaXl1VTFFcVNVeklTeWVwenl3OGlQL3RF?=
 =?utf-8?B?K0pJRnJSMnpwTjRiSXJncDIzRHB3SlExQVRlS2cwZHh6bXgwQWRreDdsTzk2?=
 =?utf-8?B?N3RJNjV0aXd4Z3RCeEk3MWZaQ0xXWThQZkk4Y3gzNkZJNXpBVXo1NEI1NVhi?=
 =?utf-8?B?b0FtZ3k3MGJYcU0zWlJlMWFsY0d6SXRFbVVtV3l5SXNFRXlVTm1JdVlLQXlK?=
 =?utf-8?B?VXk0Z2l2aE12b0ErWHIySVVLQXpCSjJ4ckN4b1BITGhpVGhWajNsOXBXdmdU?=
 =?utf-8?B?TWd5U1FQbUdpTG1uMFZoelhqeXhYR0hVSlN1SnlDMnJmYlBNN1ozKzdKNmpS?=
 =?utf-8?B?anAwWWxQZXg2b3lleWI2ZnhLOE5vUG1aZEQ1d0ZRU0dwWTgyeGtUakF6M0cv?=
 =?utf-8?B?TmJqZ1FBSFFPRlltcThxUlQzWDV3TW8rUHJZTXpiTzJnYmVUWkM5MzRZakQ5?=
 =?utf-8?B?T0lrUVM0bnNzdkt5anF6ZUUvdnF4OXY1Z1RGUnU2eklaWHlyL3ZMbFJMdlE1?=
 =?utf-8?B?a1R4dlJDdTVtZXFpcnh4MDRPSHBiWmRJTjNDMHVNTnJ6V1p1bE1hOEJ5N2lx?=
 =?utf-8?B?V0NpT0V2TE43MkhkRTA1SlZrNGtpZ2o0clB3eFc3VHJvS0RoMGV6dkZBSysr?=
 =?utf-8?B?b0hYT1FGT0EvOXZMcHc3VXg3cy9MWTg5S3VUd2RLZWRZWU5ObDFwaE1renVC?=
 =?utf-8?B?S1ZKazJTRmt0ZnhqQStieE9hWjFXbDJuc1FCdHIyeVJjTW41d0VjOFJHcXFy?=
 =?utf-8?B?dmdTeXorWmFIVXNsTjJlQzZaRVVrRUVaOVJ2LzRKTTRRZlZRNkNLdDB1eXR1?=
 =?utf-8?B?RUJqME9UQ3JtTDM0VVFCRUx2TDFvKzBZazVnUW1jcHNNMEVxNG04SmRwalB0?=
 =?utf-8?B?OHZMK1FZaFFwcm96Q0o3aUl0UytKc0pHSHBDaGo1YmhHZHpjNnJWUUdNNFZv?=
 =?utf-8?B?WmRrZWh5blVUY3BYcDM0Uk9mUzdTQk1FRmthM2RYQ3kyVVBQMEV2VmNaWEdF?=
 =?utf-8?B?VjFYektZWGtiNU9XNjBFRXh3bm1saGJlM0ppblZFVG5lY1JFQmgzK3JtbGFN?=
 =?utf-8?B?RFVSem5wT01ydnozOVl4aGp1VnpxUVJURk5GeWRqQklHdFdNM0ZZbnlhRmtw?=
 =?utf-8?B?VUp4OVYxMmRKem11dU5ZdTNWaS84NUVPc1lMcW54N1o1T0IzaXV5RHBEVGQw?=
 =?utf-8?B?UHZVSlhRckZyRFZDeDgvY0c0MWNFUUtHaXYyaWNmQWVadStqK3hNV1R6d0ZM?=
 =?utf-8?B?blRyN2l5WE51L0FZS1RTK09seEl3d1NuQmlRRk5VMElXQnNqRlZ5VmtvdHdV?=
 =?utf-8?B?VFVubk5zQ0RVMlBsSkFjRDlqYW5IZEpBdk9IQUphbzlxZ1BXZ0hqcWxuMXFT?=
 =?utf-8?B?Y0k0SHFTZzJTb3ZvbisrM0tOWU95OVNDVVU2Q1BQOWo5QnN0NVE2aE84SHZR?=
 =?utf-8?B?UXBURHZIQjQ4RTdiemxLSTBsNEJiZ2RlTXUvSUcyd3QydjhUcnRleUFXRUgv?=
 =?utf-8?B?SmxocGZTMG5kS0hBZVQ2YjlrUm1zUDh2bys1WWM5eDU5c0tQVFQxb2EwZU9V?=
 =?utf-8?Q?Ca9FS+ozpk4EjVOrdsGDqGES8DqS6I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzJVSStlRDBYQ09vaVRielhQMzVUY2FKcTJreDlKLzl2clI0b21HRFM3WGc4?=
 =?utf-8?B?UE9SWitZVGo2NDZITThRT2RGSHpZUnJtbWttTHpocnZiWHJ1aVpBQXVqQ1JG?=
 =?utf-8?B?bXk5Vnp1TzdBM1VGUVdyUjhJUHVwaXBlWXltTmZiRHE1RjZueUVyYy9UUG4z?=
 =?utf-8?B?bjRIaGRkaEgwZTVPSlZCYW44WlpabHVmdjc1SmZCVjJlUHpQS0s2SWR4cWx4?=
 =?utf-8?B?empKRG5qVzRDc2FQVk1XMlFBcUJpcHJoTmVtMFVxR0FHektFZXdsQmp0VXJJ?=
 =?utf-8?B?eHpzTFBNQytsSXQ4QWlKRDhzdGhEbmh1aVcrcGxPcmNtNlBZMlpuRDdFSDRy?=
 =?utf-8?B?UWU2amhDbzdsSThnTHF3RTdvSlEvbkVsUXVINWducWgwWUNWSy9pNXpZTzJh?=
 =?utf-8?B?cC91bExOcXZCUk5NS2dVRVhKeFI1dkxISFpFWmVFNVl1MWtqY0tNWmIyRURy?=
 =?utf-8?B?YTVvWVphRTgwOVV6bDgvSVBBOTJBS3FyS1VyNHZRR0dhTGdoc05BSTFUUGFU?=
 =?utf-8?B?VWMrOFozeDBTMER3U2dmbE9YUXIvd0IwZGxvb2RBVG83VmdEZXcwQ3orNmw1?=
 =?utf-8?B?ZnI0elozWVZENWc4ZXZzSEtLV3NFRFI1TjlRM0RKa2VEMFRROXlqUmpHMEkv?=
 =?utf-8?B?N3R1U2IvbWFVSytHQSswdHdnMEg3OElvallHMjdjb2R5S3RUaFdKVGl1MkU1?=
 =?utf-8?B?R2NDM09JNWJ0ZmZrdjVjdTVqL1ZKSEhSbXFkMk9qNUR0NHZ0cVlxU1p2ZStz?=
 =?utf-8?B?dHZEcmQxMnNCOVZtZ25EVExXZmUzVHh3cVQ3TjZVYjNXQTBncmpTNFA1cTQ5?=
 =?utf-8?B?ajMzYXdqS0d4SnFwTjlUTUhKU1hSUndRNFkxT1RuZmNCSkg3VE9HUDZUWU9k?=
 =?utf-8?B?b1FESmp5aGJMVGdlazlFam03UVJOT2pwaHhyMkF0TUlOUmI3V2QvQXkycm1B?=
 =?utf-8?B?UDBWNDM5aTBicHFxb0JwVFdjTUdIZ2FUcDQveTRRUTNmL2hjaFFhNXdsRE1q?=
 =?utf-8?B?b25pd2o1VXVJRUdQRlBnRW40L1RDRlZ4STdQRmE5ck0wdEIwT0FETkdmR0JL?=
 =?utf-8?B?UHhIdUw2S0VuYkFBeFl4V1g2bXlxSlpKTGZ3MTRvSXFBc2VBb0J0VW9aQXQ0?=
 =?utf-8?B?bWJtMWZNR1p3WjExK1VOR0ovTHhlMGxLMFoxUTY4TTVyZFFTekRLclZoK2xy?=
 =?utf-8?B?RVJHRm5Eb1p6eUhvVXM3VVpYbkJoc2VPeURnZCttTCthOXg0azdhRHNsZXFE?=
 =?utf-8?B?aDFhVkR6anBmcFh6NE50OUV0WnlnLytWaHMwNEhKQUp2cytiZWxLd0YrMWly?=
 =?utf-8?B?ZXcyWGpJUTVNSWgrc2dTRHZhaVdSUjdlb1U2WTRuM0E1VkFrcGlJNlhjZGg2?=
 =?utf-8?B?Vk5yWHQvWmV1aUZPU0pEMndOWi80bE5Wd0VqTHFoZXJmOGI4T3RMdDhuZ054?=
 =?utf-8?B?MzZSV042TU95eUxjUGNNRmJlSS9MRTFnUCtwcEpxUXJWSFUyRHBPTHgzK0cr?=
 =?utf-8?B?b0lVSW9NQVpEUEtiU0xBRkFoRldwK0JUd041UU4xNm1ieDZpMTNRZHNIQzBL?=
 =?utf-8?B?T21ETEVlSW55aS84UEJjUG0weTlUeGd6blROWDd3Y2hWZmtLZDRWTU9xczRH?=
 =?utf-8?B?Y3AwLzQ1eXFUWW4vUVRFUFd4T3hMNDdBVE1ORlhaalJ5VE41N2RvTGdrMmk3?=
 =?utf-8?B?WDkxaE8wblJaalR4TXJrM0M4ajhacDRGcEdNeko4aU0zWlRmUTZ1Mk9JVFc1?=
 =?utf-8?B?NlZVbWlMcTlmQ24vT2FheGhWbWRSNnpJbC9qRGNjRGJCQXlWMlpaeE9aWWZn?=
 =?utf-8?B?TUpySUlqRndBNEcwYjlsT1B1OW1LcmhEZXF0eTNnNmk1ZkhUWURFZjNqbVpJ?=
 =?utf-8?B?Q3hPNUMxTWlzYUxYU1QzVkRXRmlMRnhYZDJnWDhDaVl3aUtzS1ZRRy82ZXJ2?=
 =?utf-8?B?VmNKak1mWjA4ckN3K3FTbnNoaGUxbS9mVVF0Tm8wc0dVZXRXRGI4dWdMVlR4?=
 =?utf-8?B?UjdsUHNCZ2JmejFyanl0QXZEWjhUd0R5aTZDbFZmdlF1VldPd1BRSkQ0amd0?=
 =?utf-8?B?WU1MQ01mR29VVllIZVhMTVcvdzZDYlIzNXRDM2FySnJBS1RxcUdMMnBjYWZ3?=
 =?utf-8?B?L3pSR1phanR4MXkxK20zZ1Z0WDV5MHczN3BzK3c1ZURFWVFyUm1VVjlxb2Vj?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: multipart/mixed;
	boundary="_002_b86ab18470284d588acf1f995348a6f6wdccom_"
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qOCIGTeQlXa04bD06YFOq01UH2bYhsUlXq33G9bPbL3BAiX4fH/M8x4C9zqs8BUHnQIN8oTHQ+DTAlpfLr1JcuOqIYiE021gqYGfy8zf99TNBo9f1iEnjd7YXd0MMmZWbmj6orYWMFi0rU5ZO7+rEgMKhBvt9wrW+r1wJCaJ+oIJUpsTDPE11KrWCWsykhWTMf8L2+nlA/6g6T7x4LfNZvztY1fpJM9O4X0IFLb2uHsLzT2nFVJ85njBou8FSZABg3vfhwMb+4njZgYQzoZ1EzmyAn7r6IwDSkEFHhnGb6q7SEHOGjAzj8qiuu++S7Zbtdm0kcjrGl2nj+1xoNgPXCsTS7BOtV/3hOxLkC40w3rLXh0a5mZ1IwdVOJkkvMFeB/K52a/HX5HlVIjB6lqKSToxxtWiFdI2/MIq9UpkRZ4GHwtCnlCGKzX9BpD7C1CkwfnwudYM88AQ27NWK/Te4vrjIcjU3JUvLdgOfN9Cmgm8Rucgu7kKLgoGt9N57xq8kdk0b48+603rSj8xHCmoz1ZMALpehkM2A6T08jUG2bW9EY7ANHfEx4BgWABILHcxfeUutLNXXNeeRrf/KtEARPJohxPy2kX04MbtGsLs0ltSTaGNLNXPyDWSN1spRcR+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afc195a-ff21-4eaf-9624-08ddf5b59e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 06:44:15.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LJ53+VCK1omr6xdlKT2+do/J5UjlgdhNGrxqSd4wsmhhJfPEffJTAeOhnnE3NBw5mApBxAuNfjpUD7T2Zp06LT/6yq1Qy21NrW0QDdmfbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9671

--_002_b86ab18470284d588acf1f995348a6f6wdccom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B553EAAA85C8049AF78DA74DCC618AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gOS8xNy8yNSA2OjIwIEFNLCBIQU4gWXV3ZWkgd3JvdGU6DQo+PiBDYW4geW91IHRyeSBhdHRh
Y2hlZCAodW50ZXN0ZWQpIHBhdGNoPw0KPiBbICAgMTguOTM1NjQwXSBCVFJGUyBlcnJvciAoZGV2
aWNlIHNkYyk6IHpvbmVkOiAzOTAyMCBhY3RpdmUgem9uZXMgb24gL2Rldi9zZGMgZXhjZWVkcyBt
YXhfYWN0aXZlX3pvbmVzIDEyOA0KPiBbICAgMTguOTM3MzM1XSBCVFJGUyBlcnJvciAoZGV2aWNl
IHNkYyk6IHpvbmVkOiBmYWlsZWQgdG8gcmVhZCBkZXZpY2Ugem9uZSBpbmZvOiAtNQ0KPiBbICAg
MTguOTU3MDQyXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYyk6IG9wZW5fY3RyZWUgZmFpbGVkOiAt
NQ0KPiBbICAgMTkuMDM3OTAyXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IHpvbmVkOiAzMTQx
OSBhY3RpdmUgem9uZXMgb24gL2Rldi9zZGQgZXhjZWVkcyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0K
PiBbICAgMTkuMDQwNjUwXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IHpvbmVkOiBmYWlsZWQg
dG8gcmVhZCBkZXZpY2Ugem9uZSBpbmZvOiAtNQ0KPiBbICAgMTkuMDYwMzQ5XSBCVFJGUyBlcnJv
ciAoZGV2aWNlIHNkZCk6IG9wZW5fY3RyZWUgZmFpbGVkOiAtNQ0KPiBTZWVtcyBzdGlsbCByZWpl
Y3RpbmcgbW91bnQgZXhpc3Rpbmcgdm9sdW1lLg0KDQpPayBuZXh0IHRyeSBhdHRhY2hlZC4NCg==

--_002_b86ab18470284d588acf1f995348a6f6wdccom_
Content-Type: text/x-patch;
	name="0001-btrfs-zoned-don-t-fail-mount-needlessly-due-to-too-m.patch"
Content-Description:
 0001-btrfs-zoned-don-t-fail-mount-needlessly-due-to-too-m.patch
Content-Disposition: attachment;
	filename="0001-btrfs-zoned-don-t-fail-mount-needlessly-due-to-too-m.patch";
	size=1600; creation-date="Wed, 17 Sep 2025 06:44:15 GMT";
	modification-date="Wed, 17 Sep 2025 06:44:15 GMT"
Content-ID: <57A5646DC9955E49A805D0F31C6DF55E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAwMjliYzEwNjU4MTVmMTExMzM4YWU2YzgyODE3N2IzZjU3N2MyNGRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPgpEYXRlOiBXZWQsIDE3IFNlcCAyMDI1IDA4OjQyOjU0ICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gYnRyZnM6IHpvbmVkOiBkb24ndCBmYWlsIG1vdW50IG5lZWRsZXNzbHkgZHVlIHRv
IHRvbyBtYW55CiBhY3RpdmUgem9uZXMKCklmIGEgem9uZWQgYmxvY2sgZGV2aWNlIGRvZXMgbm90
IHJlcG9ydCBhbnkgbnVtYmVyIG9mIG1heCBhY3RpdmUgem9uZXMgbm9yCm1heCBvcGVuIHpvbmVz
IHpvbmVkIGJ0cmZzIGxpbWl0cyB0aGUgbnVtYmVyIG9mIG1heCBhY3RpdmUgem9uZXMgdG8gMTI4
IGluCm9yZGVyIHRvIG5vdCBvdmVybG9hZCB0aGUgZGV2aWNlIHdpdGggSU9zLgoKQnV0IHRoaXMg
cmVzdWx0cyBpbiBtb3VudCBlcnJvcnMgb24gYSBkZXZpY2Ugd2l0aCBtb3JlIHRoYW4gMTI4IHpv
bmVzIGluIGEKc3RhdGUgdGhhdCBhY3RpdmUgem9uZSB0cmFja2luZyByZWNvZ25pemVzIGFzIGFj
dGl2ZS4KCk9uIGEgZGV2aWNlIHRoYXQgZG9lcyBub3QgcmVwb3J0IGFueSBsaW1pdGF0aW9ucywg
c2tpcCBsaW1pdGluZyB0aGUgbnVtYmVyCm9mIGFjdGl2ZS9vcGVuIHpvbmVzIHRvIG5vdCBoYXJt
IGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5LgoKUmVwb3J0ZWQtYnk6IFl1d2VpIEhhbiA8aHJ4QGJ1
cHQubW9lPgpGaXhlczogMDQxNDdkODM5NGU4ICgiYnRyZnM6IHpvbmVkOiBsaW1pdCBhY3RpdmUg
em9uZXMgdG8gbWF4X29wZW5fem9uZXMiKQpTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hp
cm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPgotLS0KIGZzL2J0cmZzL3pvbmVkLmMgfCAy
IC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9idHJm
cy96b25lZC5jIGIvZnMvYnRyZnMvem9uZWQuYwppbmRleCBiYTQ0NGU0MTI2MTMuLjE4ZGE2MDdm
OGI4NCAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvem9uZWQuYworKysgYi9mcy9idHJmcy96b25lZC5j
CkBAIC00MjIsOCArNDIyLDYgQEAgaW50IGJ0cmZzX2dldF9kZXZfem9uZV9pbmZvKHN0cnVjdCBi
dHJmc19kZXZpY2UgKmRldmljZSwgYm9vbCBwb3B1bGF0ZV9jYWNoZSkKIAogCW1heF9hY3RpdmVf
em9uZXMgPSBtaW5fbm90X3plcm8oYmRldl9tYXhfYWN0aXZlX3pvbmVzKGJkZXYpLAogCQkJCQli
ZGV2X21heF9vcGVuX3pvbmVzKGJkZXYpKTsKLQlpZiAoIW1heF9hY3RpdmVfem9uZXMgJiYgem9u
ZV9pbmZvLT5ucl96b25lcyA+IEJUUkZTX0RFRkFVTFRfTUFYX0FDVElWRV9aT05FUykKLQkJbWF4
X2FjdGl2ZV96b25lcyA9IEJUUkZTX0RFRkFVTFRfTUFYX0FDVElWRV9aT05FUzsKIAlpZiAobWF4
X2FjdGl2ZV96b25lcyAmJiBtYXhfYWN0aXZlX3pvbmVzIDwgQlRSRlNfTUlOX0FDVElWRV9aT05F
UykgewogCQlidHJmc19lcnIoZnNfaW5mbywKICJ6b25lZDogJXM6IG1heCBhY3RpdmUgem9uZXMg
JXUgaXMgdG9vIHNtYWxsLCBuZWVkIGF0IGxlYXN0ICV1IGFjdGl2ZSB6b25lcyIsCi0tIAoyLjUx
LjAKCg==

--_002_b86ab18470284d588acf1f995348a6f6wdccom_--


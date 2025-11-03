Return-Path: <linux-btrfs+bounces-18575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D30C2CAFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 16:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D57561F76
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF6284B29;
	Mon,  3 Nov 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B5sA9tdi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a+HDQNQz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79497261B96;
	Mon,  3 Nov 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182035; cv=fail; b=C3I2v/0Zm+ohC9Ejh1lX9v2nC7eiicPC1BbpPzqCJtvff797f1pFTHE8cx/uTLUxPFMn1GqDiwzrDj+2K8IUgESij17CblyfHDWkaLgWLcawE8/KTFwrZxPrk0dUitJhE+u6PqNgJdrwDDGsUDFJjXfbxs5Z8HYzqDjl7MDWEe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182035; c=relaxed/simple;
	bh=r3Rk6j/s0AuRWkBOJj9jI0iU/OYgtZOL/RMVlNnkyGU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LgEYK7CX2m7iAvypOr0WhdVd+yFaFYoBqklAJxKPZyxa25RltFK/t535pPGxUl/TFYS3ggS6rg+jUC9tl/UEeumryIVNFRe6O1fiZr5+8gtp/ARiEiv+M1tIaAAc0NUHkpxL4zG+FJUCRqWGykiB4Z8pdvzIKXYan8ZBVMYm29Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=B5sA9tdi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a+HDQNQz; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762182034; x=1793718034;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=r3Rk6j/s0AuRWkBOJj9jI0iU/OYgtZOL/RMVlNnkyGU=;
  b=B5sA9tdiOwEztppBbb9ysSpxNN9Ei7boB48oYagtGokajSwlUqnAk3/8
   W1BK8i3inhPqLNsdrJy271WN587/nrjNGl/JEfJIOv7AdagHKrA9jWmeE
   fVl37pRYov1vqA0WHBRhVKWuwlUAwjwJLwHmHL1rn8nO+5jQQlksIdMVa
   +fDYTFlbGJuSYOGfdk7MG6scX9pv7HOnSma0bIZ64ut/jpAB9ThHS3ono
   7P+vgWkF2ja7FLmZAJAMwOMIKVx8dTeA8L7IH6gg7A0mpkxSSMxadMM8Q
   B7TnkMmVnBnm6GeFrpt6L+hjN2joljJlOdoIYyqBsjrNaTsq9MBWv46wN
   A==;
X-CSE-ConnectionGUID: dhfFH/TVRJ+uESMfEl4qqg==
X-CSE-MsgGUID: lBnpYLMPSAquU4kkJTtIrw==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="131394730"
Received: from mail-centralusazon11010069.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.69])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 23:00:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mW7gop+l9qKOCkPillpx1YSA51uHfLq6my+RQmzjHv2XChWssQvMhcIPr2tsARLdLs/3QMBfayNVwGopdsBM5z2MKWQqLrVDF8bu3WaZG5OxyXnB3LWDiA1ao9LiF3zI/9kzArOcqTU9/GCAMBkJlKcUA7TFtPOyQTeu/uafkTKQIXQ0m70fT6oYyKwCpzqKH5jX4YYJAwwOdElY9o9Te08UHty72nTHI04uWRAXSf8MfGElxQF+zOUwcTFrki6oXQfosayk74Qa5+0XUBzMiiTFtq00JY4Rlnq/USSmshR5vOFjFwj9mTwpi7wSCGzp8mTQBiD6r48CbYfhwsZYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3Rk6j/s0AuRWkBOJj9jI0iU/OYgtZOL/RMVlNnkyGU=;
 b=vkHp/e40NCNrSil89Ex5vhrDIyWIBwp95OIaCylg62rE8sG/RLyvA5F1ek7mnPCexfXQjh09cbOzgkyHNK3C1y5Th5pfWixWq2gSZmSCbMf98Dbj0OUs7uELxYT6Cp8vI3pBB2SzCdIrIoBbsinItqIYdQ8Y2d8Mpwcq647xNy8KLwxOTfiSAsXLFkzhkMC8BndtlansXGx/BxiK7SVfGC00LcA8hBYdg1/XWFyn5IlXAFif2Djwr6nrjtVxrFSTNkUvukhDd+3ulyP4kn/6rxFsKjhDG5+s9oTHh6SBQZxEs1fkNETDNhrMpuql1l7lgTF+QPZQikGXPBXC0gRYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3Rk6j/s0AuRWkBOJj9jI0iU/OYgtZOL/RMVlNnkyGU=;
 b=a+HDQNQzmb8SANvazDFnaRBX5F2K+7IsctxAgu4KO1QopTh7wwGraEz0RAbOc6z16P8OYvIL3JTACn6NqTO51Jo7b5CKfvwlu+k6/IgGdrN2asQ982syI8Jvo0f4WXZt+oMvNurS7StYTiQhVcTpr24KP3WkaLiVEKBTENJ95NU=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CO6PR04MB7747.namprd04.prod.outlook.com (2603:10b6:5:35b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:00:28 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:00:28 +0000
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
Subject: Re: [PATCH v2 07/15] block: track zone conditions
Thread-Topic: [PATCH v2 07/15] block: track zone conditions
Thread-Index: AQHcTMej7vbbnoqsDUaGZl5AbifKobThC58A
Date: Mon, 3 Nov 2025 15:00:28 +0000
Message-ID: <3b853f58-a0c6-4155-aa5d-4a8e4a1175ff@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-8-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-8-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CO6PR04MB7747:EE_
x-ms-office365-filtering-correlation-id: 49eae046-50fb-4799-4c14-08de1ae9ba33
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006|10070799003|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ymhpc2Fxa2ZKRkZIaEJ6aWthZEtJQW9ob0lnbmROWXdTNzRLNXlHSEwraDJS?=
 =?utf-8?B?cHBlRFBlZU93WFA4cnRNVUVwVmVEY0JYUSszOWswemNrT000SnZha1JMeVYy?=
 =?utf-8?B?d2plejBBRGg5eU9SV2doN1ZKMjFCSTZBR0dZdDcxNll1UjIrYzNiNmowbWd0?=
 =?utf-8?B?SjhBdE9zYTBGalloMzFuSUlGMmo1VW5Pa2tBRFp0aCtCQWhHRXFVSGpZZjds?=
 =?utf-8?B?UjIwdkZUb0wwdHZPa0l0UEN2dHhuQjgyV3pjTTB5NFQwZ1JFOXpiZklaVkVh?=
 =?utf-8?B?RldRSm5yVEF6dk5NZkdrc1d0V1J4Q0FGL1pVYVg5RFEzdmlFYnVKRnlxNEZ3?=
 =?utf-8?B?WnlSNzBwQklzRkhKckpVaXBvdGdYUFFTQ1VuNjZ3bzFYUUdjMHJFTGVhZjRn?=
 =?utf-8?B?dmRhbkxGSytkZk8yQlNGWUIwaUxWVmdVRzVNbXVLUmYrWkhVemFsdldpR29V?=
 =?utf-8?B?dzdTNHJtZW9JSTY4RUZvd3NiUGNDUkxQZVY5Vlk1VTFUc3BHR2JBV3FZRDZR?=
 =?utf-8?B?WDhHQ0diblN0SjRuTEFPeXlLYW11VWdLMnlVSHVrL0VjMlhCMURvejJsL2tD?=
 =?utf-8?B?Uk5WMFpLTjNuVlJuMFJ3dHJRY1J1SHpaQzlRVTFKNkdoaUgxTmV2VHB4bGF4?=
 =?utf-8?B?bjBpcHBXTmFZS3QzRG1XSDN4MVVDYjFaNUlwUDhtS281SWkxZDYzV3BzRWVr?=
 =?utf-8?B?cVByU1dmczVvck41WjZ4bCs0YXlOSlBpbmlFbmhQTU44akpqTkV3MUNsbFRo?=
 =?utf-8?B?Lzl0K1NxcTRKYlplYnY1eFo5OGVjeTBoN2dBVmVSa1RQRThuRDRzZFNaeC9l?=
 =?utf-8?B?Q2FRUm51c3Y4THNHU3ZoWmN0aXcrYXptL1VrMHFKODArN1N3N05qRmhZWlVZ?=
 =?utf-8?B?QURKb0tFUXI3SUl3TTZXVmdWVUdVbWVFSzdtYms0VVJrV0hhWklmOEJYQnUx?=
 =?utf-8?B?WHpiUmlZelhwQktqZzZmNFVVSkZ5YkVQMG9VY0J4S0pwTHM5UVRmTlNTclM1?=
 =?utf-8?B?cHAxcE1CRG9XVmUyQUVKMGVXdjBPYTFiT09JY0hxTWpUaFd3QmY4MTFSZ0ht?=
 =?utf-8?B?Q1hZdWRPYmdIMU93YUhoY0NGSU9wTytDdkk4OUNJMHJzR0RHeXBzcXEySEdt?=
 =?utf-8?B?SXVoaVRjV3BKMU9vUFlEeTUxRmtRcUQ4MTJqaEtoZWY3L0U3ZlpsUEhoOFpw?=
 =?utf-8?B?UkI4dm5PQW1BMzA2UUl6alNHcjBWMFhIUGFGaWdVNHFkd1JvQUpEcm9tMS9U?=
 =?utf-8?B?UlZMdjFNOEZuWGtPTzRaQXU2VktuS1Jlcm0wajJOSmZxdUl2MitIUW05a1FZ?=
 =?utf-8?B?VWh1a01DU2dTeEtNaEZUSzM3T2RGV3EzQWRFNlFMb1lQaEpqNlhEWHFwMUFM?=
 =?utf-8?B?ZG5jblBpeGFhUUljMm5vcCtnOGoxQUpMQXcyRHJoUXpYdWd5TUZCMUg5S2sy?=
 =?utf-8?B?eGwxd1F3ODhYWmxSVWlVcTI2ODFTeEowamNJYnhubzkrQzNzOHNSRzhrV085?=
 =?utf-8?B?V25kczRsaE5EQm9HdGhxMlFHTHJPdlNXa0dwUUFSazU3WUlrVjJLQ3FScUp5?=
 =?utf-8?B?TG9MbDA2VERPaVg2Zk4ydy84UHg0OUg2WVB6bTAvTHVicjNDVHA5L2QvRmYv?=
 =?utf-8?B?MzJ3M2tveFFUbXY4dnk4Tjc1dHRMTHlFYTNlWTFqcjdXMWp3cjZpWlZIektY?=
 =?utf-8?B?RCtxUmRSYUJJNXdlODdRTmxVWEFlbGY2TEhQQzZ5UjIvTkx4NExCM09oSVJR?=
 =?utf-8?B?U2lWdE5pRXk2U0ZTU3VadXJEcVR3WHUyVzVuMUIrWUNXdzluMW1EOTVEZFlj?=
 =?utf-8?B?bDVlOE0vdGkvWjhlTWpHTURQZndPUXNqdVgwVXliMzF6cXNjeEtKYzh6bXdL?=
 =?utf-8?B?WU9BNmtiWXJqSnlCaTFjQ0xEVkw2T0RwcVRhOS9rWHBEcUYyUVp6SVM5QnhZ?=
 =?utf-8?B?SzRDdnI4WGpjM3FIR0pESjBLMitreWU0K2dlYXF1SExGa291VFFYUWFacGFz?=
 =?utf-8?B?SDEvdndtMlVIZDJSajQvTU5tRmFmQlo2V0M5SkkzbDc0VytxT0ZJamwwSjc5?=
 =?utf-8?B?QXhEdUhWOGRUbE1ZR1RzK2U4UnE4V1FZbVk5QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(10070799003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anNsOGxWelVrUkV6NFJTZmJ0eTMyYTdHYjgzWlRDd25jcHI4dC9UT1BwY0xu?=
 =?utf-8?B?cFdOaHhXV2wwNzNMbStxbzd1QXNKdjlvUEExTkdlZ1h2QXQ5Zk0zTFU3MXE0?=
 =?utf-8?B?UXhabFd1WHdCUm1IUjI5ZjlQVFhlcHEyZ3hlWGdSTUJUSVpaOFpQVFc1Sm1U?=
 =?utf-8?B?TmZMaVFUUklKR3o0TVBtL2N3YmlmaGhHRFFxelVBbVZSZ3JTcXc1cVEwM1Q3?=
 =?utf-8?B?UjNhRVRuT3dYSjB1QXhyK282LzNaNW1VZzhSWXRHS3ROTzlwZS9RclgvL2dW?=
 =?utf-8?B?eVZHYVdDQmI0N0VYako1YmVsRndCOWRUYnY0b1pXNWwyY0NYdGtCTHBrS2Qz?=
 =?utf-8?B?LzJKWWRDS2g3bUhFOU1UVlJyV3hmbzFSdnRGdm9TN1VFUG1pMWIvRkFPVnpw?=
 =?utf-8?B?Y1ZzVkN6NzMwVjZlcEdBcVJORGRyZ1F5QThveW1VdzUyM2oyRTJBM3NRNDFP?=
 =?utf-8?B?T3FqajR4NHZvaUg4NlJoa2dOcXNoTnRwZkJpNGt4Z1RGcWdDMFFFR3JjZ2Yz?=
 =?utf-8?B?M0QvVGkrSjJWWVd0TjVDMU1pSCtWYm9RbGczQjhQaU9iV2NlL2dUdXJOTlg5?=
 =?utf-8?B?aWUwL1N3RGVLS0FIQnZLVFU3WVpEM016Wlp4aDIrdGI0SDk2eHVrKzBDZk9q?=
 =?utf-8?B?WXVPWlNrNlcvaFJXVStIczYrK3hBcjhDVkx1VmNZMnlPcjgraDFFSjVFM2lD?=
 =?utf-8?B?N0UyeVJDOGU5V2l0ZDhlWjVYVDJKM1JJMnVmNjRFN0xNK3NFLzkvTW1FRXUv?=
 =?utf-8?B?YUUzL0pKeFd6ZjVrWVU1Z0M5bmNTTTJIZGlMNW9WZktYd2pVKzNKRUNrb1JY?=
 =?utf-8?B?SWxaVXJ6WXh3SlZzSjljWXRNZjEwU2tsSmtBS1g4ZG9POGZMNG51M2l3ZThI?=
 =?utf-8?B?eXdORDlVaVVuc0UrbFJTOWcxNm9RZ0JZKzMvTFo5L09ZdkdzQUNMbm9vdkJ4?=
 =?utf-8?B?L2JUUlh6c0hpb0U2UE11SUdRVmdpYjBCWi9Oam9Sb2RHRUxRSURQWEJiUTUy?=
 =?utf-8?B?dzk1TjBKNENFb1dWOHZsd2hveUNyTFZ0cEZlSENNVGRsRzF4MGQ4emJ1ZWcr?=
 =?utf-8?B?UGFab054YVBma2Y0alZWRUFPVURSTmMyOVB6Z3FVNkQ5RVFmL1RmRnE2bWJS?=
 =?utf-8?B?VUNOdFRFTVVHSUNMMVJWUVU3RjA1aFNscjB0emJXYncxUytuZ3JFRlI0QmQv?=
 =?utf-8?B?Y0g2OHhnYlcxbUhYeUJRSVNvNFdhYlY1Y29mbDU0WDlkVllpY2lGWXNBeTAx?=
 =?utf-8?B?aDNKWU9vdXlGUkw1TVdHQkJscyszTVQwRjl2eDdNNlduMDBRWHd2ekQ4MVgv?=
 =?utf-8?B?S283Ti9ZRDdXcExRSEV3NFZmK3pyTW13a01saTNGSzZ4NFFNUWtJQTc1V3d3?=
 =?utf-8?B?Vmh2aWltVEplUlJQVkJwVGlxY1k2YmxJN1pnYldya0dJRmVLL2xrTEZ6cGJ4?=
 =?utf-8?B?T1kvazZ4dGR2TjdLRmlpYktlNVU5WWc3V1p6ZVc3YnJZMGppWTNHeW9oTm5H?=
 =?utf-8?B?R1lTZHo3d29oWVRLY1FrRkVwMTh5NnRIdCtDY2Q1dlprYjFSZXBzZ2NrcU1E?=
 =?utf-8?B?STVYbERYZ0ZsdE1Ebm4vTURIbkJ6ZzViR0ErOEt4SGU2ZnRHbGxPMHRBSWZU?=
 =?utf-8?B?MExPTDRpS0MwSmdyNzhDMG9UV0lZdGh2UFoybkMzb1ZtNlRpcjRSRno1RFE5?=
 =?utf-8?B?VE9VY1l2UnFIbXRNYW1adjdOaGxVby9aMTQxSW80eVllVmlmOUpYK2Exa0xI?=
 =?utf-8?B?cU1jbHJad2l2ZUZpTmtsbUFrZ3AxaWEvcmVieHBYZmVnemlEZG44T21mRFds?=
 =?utf-8?B?bnZKVHIyZXdDdkdZTTgzVEpoVlFpRmUxZlZKSnNDZkY1YUt6dzRDQmVuMnhE?=
 =?utf-8?B?MUpxMTk1eEliMlAzK0NCRTB0Vy9OMm5raTBRUWRZalJ5T0JuQzdJeW9ncWNQ?=
 =?utf-8?B?ZzNuTHhaTCtJNThabS9tUzFXcVh6R1FuSzhOQnRzU2lWajNZN25uckxoWmIy?=
 =?utf-8?B?Vzd0MVIxWTRtbzdCUy9GeHVESGdnVzFrZVM3bndaL3BhTDBDazdjMHZwL0FE?=
 =?utf-8?B?TGVIY1huRi8zZnBmMk01RitRTmdmRVFvL2F2VWpxbHFYZzFjU3d2RTF0bUhm?=
 =?utf-8?B?bnBTOHlEOVJnWGhRZlJqalBOdGwwU3FBR1R1bkFtOUROMTJXTUt6RjM1bllk?=
 =?utf-8?B?emEvN2dSRmNVVUFvTXVkWmZySGdtMStvTzlCeHZSMUNqVXkrSndBQ3NYZlo2?=
 =?utf-8?B?ME9IMHJRT2hFOWNtRzAyME51K3F3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ECB7D964D4CF342A0CEF1D0ABD317BC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EljpHkWcOLOHQC6WkJSEoukxWQ0B3/CUxtcH5sQ2V9l1+NppOzMxlwarkbkjZZysmDJvaH9wXu1uBVDhfk5W/MjWIvrFJTf6qyyCFx2tvDXjrqbG1TVd/A4qRpVmH7G49oYgz4nc94x0vrp9fXEwDULcsbIQkE2R+XWXlp9RPnWGesW73SknbtfqoWeDfya3AXNOuo/a4+CjMSJvDD0Jk1SVylfhvXod4SSzI4WKwM44619oK+G1lI0wTxswEDjEZlrp7WHVlU28m3t9RS6JV0217rjKhrhhx/EDOyRs0zLL0N5tKHLAIKfdwopstjE3r5cntdu6lcWLcp393vmrKsQzCUpJL6+DjG9rlO4HpidiC9icNJwLS/BEKMADcn33Fo6JhQ5nnMDhSlksMvzWf697WswIIcwxluq7krTtjPpU3VL2SOoOGWVKINYlYS2/A6tQmAwNaV/uWHb9L0qlbrqjxLjcmIaGebNuvrbUVZlucA6pSAmdrqrp1tIfqt6BRgdw+2cAOJdt5SXaHsrGxZGP+PV192j1Y0ZDZdQXqBfLe8qbRp9Qqfi4+5zkv8+e6lKVBQCYLVZJ5qBYWb0+ajjeELuoY4mkW2DI9ZFM4kmINqM1WYuDl3q2IGmRgrez
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49eae046-50fb-4799-4c14-08de1ae9ba33
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:00:28.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrVmUxJJbzKeOWmCbrzsMiaKULGjk8W/guY7K0caEwny+7K7qlByhu394+q6NZ08kORUKe20dqZrkKZ4T5REQbuIare4i4rcGd+l6htyhpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7747

T24gMTEvMy8yNSAyOjQyIFBNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gQEAgLTc3MCwxMiAr
ODU3LDE4IEBAIHN0YXRpYyB2b2lkIGJsa196b25lX3Jlc2V0X2FsbF9iaW9fZW5kaW8oc3RydWN0
IGJpbyAqYmlvKQ0KPiAgIAkJfQ0KPiAgIAl9DQo+ICAgCXJjdV9yZWFkX3VubG9jaygpOw0KPiAr
DQo+ICsJLyogVXBkYXRlIHRoZSBjYWNoZWQgem9uZSBjb25kaXRpb25zLiAqLw0KPiArCWZvciAo
c2VjdG9yID0gMDsgc2VjdG9yIDwgZ2V0X2NhcGFjaXR5KGRpc2spOw0KPiArCSAgICAgc2VjdG9y
ICs9IGJkZXZfem9uZV9zZWN0b3JzKGJpby0+YmlfYmRldikpDQo+ICsJCWRpc2tfem9uZV9zZXRf
Y29uZChkaXNrLCBzZWN0b3IsIEJMS19aT05FX0NPTkRfRU1QVFkpOw0KPiAgIH0NCj4gICANCg0K
UmVzZXQgYWxsIGVuZGlvIG1pZ2h0IG5vdCBiZSB0aGUgZmFzdHBhdGggYnV0IHRoZSByZXBlYXRl
ZCBjYWxscyB0byANCmdldF9jYXBhY2l0eSgpIHNlZW1zIHN1cGVyZmx1b3VzLg0KDQpPdGhlciB0
aGFuIHRoYXQsDQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=


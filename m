Return-Path: <linux-btrfs+bounces-18589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F30C2D2B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 17:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714A2188ED4C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA03195E3;
	Mon,  3 Nov 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L63NlkXT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E924C669;
	Mon,  3 Nov 2025 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187669; cv=fail; b=TUnCvBL7rrQ+bUcwzw9ACSM5pj4af94pQwb8Tgk9lWpMJqluCtj7PpoERCVS2cbMRHvYpBQYbhGAclPQWXnVQv8GH/FXBWWR3MWjPBx0PZYCx6iXNoU5oa8Q0dlqdkDVhtyGwiL2caSEsM1IvstFv413VuLAbK1H7h71QV6HkeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187669; c=relaxed/simple;
	bh=DnL+clR8rywabnbbSztR7fUmrKR0zIODgp2egP15S7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bxbbg8F6KqimvQ4UY1bX/QN5K3BfJozjkCqhq8/lj+zB1jceEHg659s2UtasOAmC6rH6G6xxxNW++XeHNFzKiah1e3key+tL6kck7XFfkMhr83NLQeP2IqLsUwwfQWEpfgxV/kSysc/cWQ0g8PWseHeGjEiWlP5nciSZlbm3S4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L63NlkXT; arc=fail smtp.client-ip=52.101.61.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxId8sIb+zx3OTsIM9StvEBSKc1awhb3fFs5nkjG0LeVvzhX5kQnZwe5SUTIUof7Lfc3dV8X9cTWdszW5E15m92vpggZQEzwKxJbEUlESMGBtfss2O2ThYnL6DDVUcRb9mculR5KltvngW/9yWOngzs0s3WBqO5mje2txhe6B58KgGQe+gs0d97G8RiM8aFEXlmxE3J+KUivbsVgISyhnkfFz3ffgVs91xFDTGjcLKS//9ifwIiIiGsAquacEZcYwO4vyW5ACOBWNvV9J+U5qt+LIe3fJfUUEoB6Lvfe7RWfiE/lI5r8gRegJtDEJKkLCiffAi0Q63aG0oDpJdFdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnL+clR8rywabnbbSztR7fUmrKR0zIODgp2egP15S7k=;
 b=d8fGDZ9jdRuLEuhfJ2Ro6hfuqvdWgzf8oi1jl4IBLNUP9vOOsJay7xHyfr9m3i2DGaYCarBZs0rA0cvUp7GQckfiStToPhCYlUorsgrY7lHSzuiJ88Pu7w2fQLmwN/uJrX44rwW+F8zsE/ojHYucepockFNshVJAp8erS/H1hbe2fMnb/VavU7Fs34TvszE9doqnHs34JKbI8KWi4InsUvWl7PKpoTWisFr8mlD+voOxYc9taKoRo/Q8LtsM/jHyauYb9KycY6C66mWaTp7Dpa8DJGfUqBMAtv5EaxHhzoWsKEy6d+iGCNH9jcBIy3+T1w7dH3kC0iAQ6NwvvRGFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnL+clR8rywabnbbSztR7fUmrKR0zIODgp2egP15S7k=;
 b=L63NlkXTBEPOuqXQ1AQPsrCPm2I8x8SKpigwyUntFjad0VU9Mktl0rW1NbxDKWXhizrnIIhA+UlO4xzkEiOBafgDR6FbKfu7b+Ce82AWLI1fAr9orhsqGhrWu9sBVAKmjbkDVvkmmuQ6nGV/cPeCMb0yzCQfZOSffKODxKZRGlfqGsX+5zDTs2B1KmOm9p3jXwOBQGMH0IKcg+a3W2wanqlBRHK1cd9HTiRDDDaDEYWE32uUe+MwajTdZOYnPx943RKNsDZuINdfG+thWPymBMZZN/a6DThQy63KvJgNlZoTMcmuw+q9OQQpYzdnm9ONTQorfGqi/2YmoauDRKOhUg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 16:34:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 16:34:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	Mike Snitzer <snitzer@kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Mikulas Patocka <mpatocka@redhat.com>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH 07/13] block: track zone conditions
Thread-Topic: [PATCH 07/13] block: track zone conditions
Thread-Index: AQHcSi4P6ZCq99a0mk+Dc9in8KjesrTcw0mAgAO4CACAAKMJAIAADLcA
Date: Mon, 3 Nov 2025 16:34:24 +0000
Message-ID: <6008fbc8-b556-46d9-98a5-a4622731d206@nvidia.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-8-dlemoal@kernel.org>
 <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
 <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
 <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
In-Reply-To: <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA3PR12MB8762:EE_
x-ms-office365-filtering-correlation-id: b7781294-4494-4587-0d64-08de1af6d983
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFpORDVzQUQyaXJYaWdXbjl5WUdoeG1tS3NMb2lONkxINktTbGNRS296aG1k?=
 =?utf-8?B?TU9FWitCakp5cmJzUVVEQ1hINkhKUjFZQm1aREpyMmhLUmh0K2llZ3Q5N1h3?=
 =?utf-8?B?Q3Z1MStXV1BqQ1dzV3U2YTBvbHAzdWVXSVNGUWEyVE5FNUoxanhtazhETTZi?=
 =?utf-8?B?RC9rV1VLWjU2aGJKNTNFdEZXN2J5Y0ZJS0RsdnlGWFBLTEVmWUNqWFVNeDQx?=
 =?utf-8?B?SWdJUk9DelFKa0lFNVZaMWp3Uk4wVkhmYzB0T1RNb0dPdFdyN1kwZmtBRmZX?=
 =?utf-8?B?ZjRXMXRTWjdVSVI5VUdSV1pzTlFyUU11bXBtcWU3MnNURGVHUzJwaGRYSlEr?=
 =?utf-8?B?dDVMcjVvWnpmempURE9uVVdCVkdNOGxOcUVsVG9ZSjN4dEI3b0VEdHI4Wncv?=
 =?utf-8?B?c0NhMjFBNGNkdzhSYmF2WmxROVNFaE9zdldCUmRES0RFcjV1RkVjL3Vrc0hx?=
 =?utf-8?B?bUhxckRUcGpnSUVFRmIwRXN3OS9ncmFTczFQSDc5dkJwbVNlVW1GUllHbHIz?=
 =?utf-8?B?am1lTnZZa0hZWEFqYzJEZThNRmtKZkJUWC8wcytjZTNtMGVhZktJT0pxTUFP?=
 =?utf-8?B?WG8xa1NVaC84OXk0N2lZMDg4TWtxSzlueGJZbzJjMzVlOVpkQ2hvS2NlR0pW?=
 =?utf-8?B?MFN3OWFubmJLb0R6QU0vRzBOMm9mSjV3ZGpCMXBVdnFRZTVOdzJPU2ZUWkdH?=
 =?utf-8?B?cWkyTlhVdUlBcGZKSG13cDlMNVpsNDA3WjFVVm9uaWNKRzFZeXYzdHY1VDJN?=
 =?utf-8?B?Mm01bEMwTWp0UlBNZ3RRTnMxWmZOK0x6Rkw4eDcycGRMbExuSk0wdzBxdUc0?=
 =?utf-8?B?M1d4eW9nazd0QlMwRWtJbXYya2RaMzhXRTJXQUkvb1JkMzdQYlh3MlprZ0dO?=
 =?utf-8?B?VjlJNWMxZmRpeEQ2dWh1S2xzcGlidW1RYTB5cWptTDNaMUFad0RRbVlqOThR?=
 =?utf-8?B?bVhzQVNESzlGZkJtVXpJckNHdGxMZ0Z4b3RqUWxPTHFFLzhNWDNQL0VlZ2dW?=
 =?utf-8?B?Z3p5QTJxcjNqS0xhSXZuRXpON0x3YjhrVGdNNkVtU3NodzNqNVkxbXEycUgr?=
 =?utf-8?B?aWI3NlNmT21jbkhJakV5dXdEeGhDZUNQWEpObVRjUHRvakVQZHJ2b0JPZVh1?=
 =?utf-8?B?VG5nV0taWlRBMHVOWHREcUVqZnBPVzUwbmpvdU1sYk9KWDFBZzkxQTRSVXp0?=
 =?utf-8?B?SUNueUVqUlNKVU1GenU4NDVOSkx0dURWbjRKQThwWFd3bmRQYlNqZlIyT1R0?=
 =?utf-8?B?Vm52V0d1VUVzMkxHZ0pTcTFZYkJZQ05CUlB2aHd3eklaTEt2SWxKWEZESkl2?=
 =?utf-8?B?TlkyNmdlTzBJRndWVm5RdjBmaTEzZFAwWmVwWUdaeG9McTJmczRrd0NVeVQy?=
 =?utf-8?B?Y0plS3ZVMFhVMC80SnhXR3poQVZaRHc0OE02MThEZm9sY1FzU0pqVDQrSCtl?=
 =?utf-8?B?WTl2bU40YmFRUVJCZTlGcTYrT3A2WHJXVnljS0RFY3o0RmptTVE0Rk9aKzBJ?=
 =?utf-8?B?VElXd1NzWWVadStyYno5TytMVnBuMGZaSTU0WFhPRzB5ajJSeDNDUWZlL1Yr?=
 =?utf-8?B?ZW81S2FXVWZyTVFndkFWV2FVWGVwbkJWNnlQNC9BYlVTVmxpNmo2NUZFUGww?=
 =?utf-8?B?NHJzSnpMNGd5UVV6VE5tQXlybndBdG85S2FBQnRzUEJETjVDQzV3TXcrbWpL?=
 =?utf-8?B?a0dHVkhPOHNrWWNhb2JGdEFFV09ZNmVuWGxRU0RVWnphWE5nRWZ2cm5UQ2RI?=
 =?utf-8?B?SlF2czBMQVp5WmJIS2I2Skw1TG9kNWZqTTVuakJObUx0TjBYaFNwYng0Nzlt?=
 =?utf-8?B?SHBpM1pyaTRHK0ZmdVBuZnVLSmVBTGpkTlJEOFNOVGRxSE1pT05qQ2ptZzY4?=
 =?utf-8?B?ejVKQWplOCt6aFRWVXoreElRaUNqRlpYT0RnMzc2Z1E1ZzZ4akRnQVNwaHY2?=
 =?utf-8?B?OUltdm9tL244YkZnTXJ2NTBEZWoyR3BWS1N5djI1SnNhQ1hZeW5zelludDFJ?=
 =?utf-8?B?clYwWGxoKzBDelc0UnFrbk9pWnpGcG1HRWpBSXpBenp0VHBmN09KVTVKMWlp?=
 =?utf-8?Q?V5GL6Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0UvQ2x6enNGdld6S1Jnc05xcjhlL1RJMkRHMm9MRW5CUVZsSWRoSnRMTTFB?=
 =?utf-8?B?cnIwekJXd0pEbTVlOTEzS1JBM1hiMTJYaVBpN3h3aGw4SXB4VW5yOS96NTRX?=
 =?utf-8?B?cGZFditBWEh0eUVEcDdiS05Od0R5MG8vcWc4alRJNDBQMUEvYndOdXlIc0l3?=
 =?utf-8?B?c2YwUWhkeC9tWTZMWFZCQjhFODJ1OGttNHBLNnlNTHBEeEUyd2E4OFNhWTN6?=
 =?utf-8?B?UWtYbTdTcStBOVdYelZ4bWdjMUtQY0NkQVhZRVc1UytzV3pwT0ozL01VSCtY?=
 =?utf-8?B?Mi9pbDlDMTBZbXV3ZGpZd3J5ZWR1T2N0dmJuTUxCUDBrYkNjd3pOVFVtS3VT?=
 =?utf-8?B?M3NxdEJieXJmeldFWS8wa1pYYWxKMW1YKzRMWTk2cVdXMDVnWlNKVmVoTjV3?=
 =?utf-8?B?NTdvT1RqNUV6QkNvZTJna0VOd2haenoyNnN1ckRPdkMwa1hIWHBnZzRucDBn?=
 =?utf-8?B?dWtkSVgvWWt5aFlta25XQk5yc3l0cVJ0amN4bGtpejhycDQvWnZjWEgrMUFX?=
 =?utf-8?B?dEo5ZTdmdkltaFZtb2lmM1hBVW83cmV6MWs4a1oraG5tcFRJSG9OM0hTNWtV?=
 =?utf-8?B?SW9oMWlqZUJTaGdzQzFqNERibitHVVZMZGFsZGt5MVo3dUdPMUcvZExNWW93?=
 =?utf-8?B?Q1pTbi9TajZYeDg4cTlyYkpmVnRia2ozSXQ3M0VxOE9yN2t3TVA4RFM0Nkhv?=
 =?utf-8?B?cUFrL2lvZGdYcWllQVpFbEtMSzdJNnhKY0Nka1NabG5wS0ZPOFdVTUhvb2M1?=
 =?utf-8?B?V1lsZm0xZm5PYzA0SUwrSWhvVTFHVG41NTBlREo3cUJLMDZZaXNzLzl1dUY3?=
 =?utf-8?B?cTZYcjZVYitzUWg2VVRlQ3J0b1B3Qno3Z290T2k4alNYbkZsbEZZZVNEa2Yr?=
 =?utf-8?B?b2EwWElOeXlIUlpWTWo5RGpBY3RwMURkd1JUcGlVdHNSVXdtNUtZZTc5TXlp?=
 =?utf-8?B?ZHp4Uk1CWDd4aFBUYlZ0RFlaeFg5WjlPTjNkbGdYNFNZNFgzQi9jZ0VtTjYx?=
 =?utf-8?B?eS9ESC9uNEZWMnRvMlhEV21vdDJhZW5UNEN6clBIaFBRRi95MThUK0dOUVJn?=
 =?utf-8?B?N1IxdjZFajlEd2xXdHl0aVJ0WFYwV1RiaC80MXFBZ3hUMHhKU3RabVh4d2tO?=
 =?utf-8?B?RDRJYkcyVCtVaWdMTm1Pdzd3WWUyVHJreW0zZjN6bkJManUzVGx5dHR1bC9x?=
 =?utf-8?B?QkJUd2k1eDlpY1poNmp1UlFUQ1ZUaHZwaTVWNndQNlRDTTU4RkJBL3JodjhP?=
 =?utf-8?B?RXdOd0ZHbGRtek01NSszM21XbUtTQUtEazNqZ1h3aTdTMHQ4UjAyVFIyaU9z?=
 =?utf-8?B?eDdRVlhOSmJDaDVKeHBPWlBnSVFldWZleDQydXltT0dQUjlQNi82clczamU0?=
 =?utf-8?B?WXB0VnB3ejREaVZPbUxIcm5GVCtvVWNSWjVXMTRXdm5yaHBwZGwvZGtjQThP?=
 =?utf-8?B?MnQ5ZDZYalAvMVUrN3lQcitOc28rbGJYMzJqN3hUeTBYSVVXbzY2R2JpMUJh?=
 =?utf-8?B?TGFEY1FtellLR0FUek5NYnFWajFpUXdKbFVFU1RzNWxaK1FaTmNmTHZUWWRn?=
 =?utf-8?B?L0RoMVBZcG10TThaNU9KaXd3Z1JyU3Y4SEZRWUhMZG5MdkRsSTlnWlMwZVZ1?=
 =?utf-8?B?cFdiekxHenRaUmx6Rm9wQW5TUEhHbzUxTzA3WElLVHRoNFBHTFcrUU1lYW4z?=
 =?utf-8?B?RlNNUjZMT2l6QzdiZFZ6MWpLak44blpJSXVmNngzZG4xalJ2R2o4aDBWSjNH?=
 =?utf-8?B?Z2g2OTVYS042VEdoRnc0a1ZRbFhST3RjZDJLUkpZK2Y2K2N2U2FweHNRZk5s?=
 =?utf-8?B?bkdENExrZFhyLzdaM1VNL0I3NGM0SEtQcVRuMzVlWVdVT1lYS3crZ3RmNWVV?=
 =?utf-8?B?c0hEa1NMREVaZGxhdHVTYTQzNjNETEc4M2tiZndHa3RhTFFFTnVnZEdGY2N1?=
 =?utf-8?B?ZHpuU0tWN1VqT2M0ckMxUVl1UEVDdlIwQ01DY2EzTUE5NmZnNWtmV2NncE9Q?=
 =?utf-8?B?RTk4YVpoWGp6MWs1dlZnUHl5eWNpckg2REFVWU80NG4yQXN6eDM5OWp3YWh0?=
 =?utf-8?B?RVRKNTYrSk5rVE54cVI0eDFuMXQwTGdFRHVCV2J2MzlxZk8vdzYwVnpYZFE0?=
 =?utf-8?B?T09hTnFHYW9wQVREbTcrTnRuSUgxNnFaYVJ4QnpYK2F6cnQwK3ZadThrQXNP?=
 =?utf-8?Q?IiAb9RLKOMXEuJfvGX0Er/SqPgkESkYpobzZbAGtAGrW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B1E3249AE657543803A764090488EAD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7781294-4494-4587-0d64-08de1af6d983
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 16:34:24.6511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKr442R7JRthKzyz5ndIdECq3I3dMP9kVfY9VVy7iBmBXGS+UroWThBFQEinPbg1qO2W6vzLgMe+SGx11/yKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762

QWRkaW5nIEtlaXRoJ3MgY3VycmVudCBlbWFpbCBhZGRyZXNzIDoNCidzL0tlaXRoIEJ1c2NoIDxr
ZWl0aC5idXNjaEB3ZGMuY29tPi9rYnVzY2hAa2VybmVsLm9yZy9nJw0KDQpPbiAxMS8zLzI1IDc6
NDggQU0sIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gMTEvMi8yNSAxMDowNSBQTSwgRGFt
aWVuIExlIE1vYWwgd3JvdGU6DQo+PiBPbiAxMS8xLzI1IDA2OjE3LCBCYXJ0IFZhbiBBc3NjaGUg
d3JvdGU6DQo+Pj4gT24gMTAvMzAvMjUgMTE6MTMgUE0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0K
Pj4+PiBJbXBsZW1lbnQgdHJhY2tpbmcgb2YgdGhlIHJ1bnRpbWUgY2hhbmdlcyB0byB6b25lIGNv
bmRpdGlvbnMgdXNpbmcNCj4+Pj4gdGhlIG5ldyBjb25kIGZpZWxkIGluIHN0cnVjdCBibGtfem9u
ZV93cGx1Zy4gVGhlIHNpemUgb2YgdGhpcyANCj4+Pj4gc3RydWN0dXJlDQo+Pj4+IHJlbWFpbnMg
MTEyIEJ5dGVzIGFzIHRoZSBuZXcgZmllbGQgcmVwbGFjZXMgdGhlIDQgQnl0ZXMgcGFkZGluZyBh
dCB0aGUNCj4+Pj4gZW5kIG9mIHRoZSBzdHJ1Y3R1cmUuIEZvciB6b25lcyB0aGF0IGRvIG5vdCBo
YXZlIGEgem9uZSB3cml0ZSBwbHVnLCANCj4+Pj4gdGhlDQo+Pj4+IHpvbmVzX2NvbmQgYXJyYXkg
b2YgYSBkaXNrIGlzIHVzZWQgdG8gdHJhY2sgY2hhbmdlcyB0byB6b25lIA0KPj4+PiBjb25kaXRp
b25zLA0KPj4+PiBlLmcuIHdoZW4gYSB6b25lIHJlc2V0LCByZXNldCBhbGwgb3IgZmluaXNoIG9w
ZXJhdGlvbiBpcyBleGVjdXRlZC4NCj4+Pg0KPj4+IFdoeSBpcyBpdCBuZWNlc3NhcnkgdG8gdHJh
Y2sgdGhlIGNvbmRpdGlvbiBvZiBzZXF1ZW50aWFsIHpvbmVzIHRoYXQgZG8NCj4+PiBub3QgaGF2
ZSBhIHpvbmUgd3JpdGUgcGx1Zz8gUGxlYXNlIGV4cGxhaW4gd2hhdCB0aGUgdXNlIGNhc2VzIGFy
ZS4NCj4+DQo+PiBCZWNhdXNlIHpvbmVzIHRoYXQgZG8gbm90IGhhdmUgYSB6b25lIHdyaXRlIHBs
dWcgY2FuIGJlIGVtcHR5IE9SIGZ1bGwuDQo+DQo+IFdoeSBkb2VzIHRoZSBibG9jayBsYXllciBo
YXZlIHRvIHRyYWNrIHRoaXMgaW5mb3JtYXRpb24/IEZpbGVzeXN0ZW1zIGNhbg0KPiBlYXNpbHkg
ZGVyaXZlIHRoaXMgaW5mb3JtYXRpb24gZnJvbSB0aGUgZmlsZXN5c3RlbSBtZXRhZGF0YSBpbmZv
cm1hdGlvbiwNCj4gaXNuJ3QgaXQ/DQo+DQo+IFRoYW5rcywNCj4NCj4gQmFydC4NCj4NCg0KSW4g
Y2FzZSBjdXJyZW50IGZpbGUgc3lzdGVtcyBzdG9yZSB0aGlzLCBpc24ndCB0aGF0IGEgY29kZSBk
dXBsaWNhdGlvbiBmb3IgZWFjaA0KZnMgPyBwZXJoYXBzIGhhdmluZyBhIGNlbnRyYWwgaW50ZXJm
YWNlIGF0IGJsb2NrIGxheWVyIHNob3VsZCBoZWxwIHJlbW92ZSB0aGUNCmNvZGUgZHVwbGljYXRp
b24gPw0KDQotY2sNCg0KDQo=


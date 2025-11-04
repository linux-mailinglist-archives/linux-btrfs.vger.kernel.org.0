Return-Path: <linux-btrfs+bounces-18634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B1C2F47C
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87183B7231
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF51299AA3;
	Tue,  4 Nov 2025 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sJgEyYJa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0DC26CE3B;
	Tue,  4 Nov 2025 04:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229621; cv=fail; b=tG0TIGq/kgbMjsIx6zPHHOizFWbfpuF68IuYtn2IucuRltafZtc03/qvKNYRwAEAyd9k3JLopfuPRXnxO1M32yWmy2hEVXeEdRdQduLqNDdFdymHpSl+1XIDInAh1IRwB9Jkar032CfNf98SPFnxF/vdMpZ+3KvpKrKXxQGziio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229621; c=relaxed/simple;
	bh=fcNz6F6ckuOapv+G5+hMpkHOV/MCo6ZILaQsrBPCrR0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gK+ur3OYtfu71zoJUzix64YE9M63sqg7rjYdHRz3q5tH0DXyaISbv494ruCJw9+x0aggYysgxOlxQT0YQSYk6CssSFFkveuv1tx1sQD1OjZHF1Ni3sLf7F6yRfG6VLyrx+wtP3/mJ6dQVGhkwhyNREXXwF1GJsxBziTJdQIeYcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sJgEyYJa; arc=fail smtp.client-ip=40.93.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKEu9I3PYDaZnN4YsDqiH/7jb21qjvz6L9bwtlALwy+rVTTZ84S8WPQ8mH5PbyoFnBnmsHvxuGyUO14J2hsB2GC/ju/kn/afbPNLe+VL/Kq4r1DGnbYDMC8gAbiv4FahCpSj8v0t8OFImXBscXXN/+INd7OfNNblA76MrvK1hGNjMWYXlod3Ntnt/gYbWA6FRW3hFJUSt6XLNEZCeuS9w7UZKLSemG9d1YGmI/jbZD0kUdBkLHoH/EVxFZfYfm7S6JQsd5sMVIboa/KmueMEfQPkhyRk1+3I2/ThN7bL6pJQV/QxK5iewgBEOeHXygM2Y3TV/aFvf3pwiAmHc9tGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcNz6F6ckuOapv+G5+hMpkHOV/MCo6ZILaQsrBPCrR0=;
 b=B5cfalSUnCx8dzkzn47uQISDM1YDXcxvuWeyiukBGc6E/GG+7OBNxQOL2K9WZ1fy9T24Uk3gRd7+b3vnTL+DWjLivAruNgErng8uzy/wy18PBBkU/79uRwHF0GHmfvK3PGgHpuU8ta7JTM6h+x9noo51zuagLYlvaAf37svjupG2njJinHpmL2ZZqC9cTGtBdnCUQMNau0M7KROp9KygMLU38R15LSN7wbrBprqo7YuvCyeqlEQoM8daTe2gNzyuk9JNgYyYUL4pApFr99S9v1YQc7qNbA2iMG8B+GzLRde7nQkDI/P/WumuUJRFTu+Do1BSYfrnpRdvm26JaITlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcNz6F6ckuOapv+G5+hMpkHOV/MCo6ZILaQsrBPCrR0=;
 b=sJgEyYJaAXWTLBFeRAgTb6tR9SvLdKUKP5q5TvmOaB+zv9pdX+iGv1Bg8q0PGELOXbqFoGyi8+iBUIiq63RlXWe1FuGLiQ/1fOW2Allh/F80tqp2QTOwo+oOHo/5JIFMFxMTT8hTMUilAlPdacUSOjX8dCBGMWww9LHMfRZYWADBiFN4a0pocU91nlqo8qkq3Y7/DwEGM71WrB4R0tvOaIpinEpW7RIG/OI+grr9mv7IoL7XyMDf6QhByOteTmMh8zjCA+TJ1BvGnonRepSQx/Sud1F+t1Ml6dzOj+//PALypCZWnquDniu/LKJNpwiOr5O+giAjVxInLr31AxhLLQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:13:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:13:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v3 12/15] block: improve zone_wplugs debugfs attribute
 output
Thread-Topic: [PATCH v3 12/15] block: improve zone_wplugs debugfs attribute
 output
Thread-Index: AQHcTStwnJfr+nWAcEWZFO3K3INUN7Th6HKA
Date: Tue, 4 Nov 2025 04:13:37 +0000
Message-ID: <ee3819e7-454c-4aca-8334-2a39ddaa3c83@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-13-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-13-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7632:EE_
x-ms-office365-filtering-correlation-id: 48cde750-9554-456c-1b1e-08de1b588766
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlpwK21yblN2Rit2ajFWOE5MTDh0U3pyaXhoc0x2bXowbG9CM2poazhvL3Bw?=
 =?utf-8?B?cXQ5RHQ3WmJhMnNxOG5odFVzTXR4M0FteDc0dVZLSzE5ZC9PMEtwTDZscFYv?=
 =?utf-8?B?OHBmK2VOWGZmcmZoNkpxTzVuUnFTeCt0N1Y0NE9SRzZJQkVVaE9FTWdFMDhr?=
 =?utf-8?B?bUtKZVkxZEE2M2ZLSzMyTEtPZ2ZEL1ZXY3YrVHQza25YNURURjd5S293cFBo?=
 =?utf-8?B?Um9pRSs1VTA4Y0gxSHFhVHRWWUEzYVU2NUE2Q1YrakFYbXgrd3B4a0E2K3N1?=
 =?utf-8?B?V2lUeDlzeEFmcGg3QzRQVmtvcG5zc3JUY3doZkRUa0tCNGFHMDdBaGRBUStn?=
 =?utf-8?B?UVJuS3dMVFdTK1pQaG5lU2FOTnpYcC9rdk0xcGVjcG1QUVE2NU1sZEtObXVz?=
 =?utf-8?B?cFhxa3lGWURVYmpEbGtuSUFKbmtVeTMxbHlTdW5OMUJaMThCNm9oamM3OHli?=
 =?utf-8?B?bDdFT2FjUDVrd1B6OWczQi95eFFaR1IzQjVuclNRWTZLT081VzBleDNGM1Er?=
 =?utf-8?B?K0pFK2lFc0tQbnZVeFV2b3dEYzNOYW1KNzdTS1NrbVk5dkpVekJPTXZWVlJZ?=
 =?utf-8?B?UVl2dXJ5NnY0UUIzdWRRSkk3bTZBOWZtdGl1WVRMMmR3SXpJVE0wSFJJMmtV?=
 =?utf-8?B?REduTFNTRElZWjJWVGVzVWRBZnZJY3d5SGZOSThOY3cyMFZlRGU1aWkzOEJz?=
 =?utf-8?B?VFRiVWI3Slcxcjd0d2ZvZ3B6SERPbUQ4WVl2Qzg2OVh2TjN0U0dqUG5ESEIz?=
 =?utf-8?B?blpwb1hvWlJ3N1hyQUhOMjNuUW5MTm1MdDJ4aldZc1haWXZLNE1MTnptQ3hk?=
 =?utf-8?B?UHRnV0haVUhTcXVyMk82VVNsUGQrTWFuTWFGMU1HZjUwY200OUhyZVZ3STNG?=
 =?utf-8?B?STQ3QVVSNFg1NHpnV1lZSk9NUjUrbFpBNWk0ZVVxVkI4anR5MGUzbUJGSzVi?=
 =?utf-8?B?SjgrbWFQN21BUE80WDVNWVRJM0xVQms1MWhTRXk5ZDF5TVU0M0JDM1g0Q2VF?=
 =?utf-8?B?S2d2Nm00TFlYeEZyZ0ZreHV6eW02dG4yQTVJUEU2bVUyVmRUNDF1Z1hCTEI3?=
 =?utf-8?B?cGlqdHhjaU5WRk1RNzBCeitRdUdiOTIwSUloSUxMc29WalplNUF1TFkzK3pm?=
 =?utf-8?B?TDdzb1FOT29IOXE0THEzVDJZNVVrSU9nR0IxUjJsRnZqalhjNk14UnhWN0Rj?=
 =?utf-8?B?SzljemxyTUJqRmtRQmh2OUVqN3A2MmxVU3N6bEptSW1uOVVqM2hvMmlXZEJD?=
 =?utf-8?B?UlVqb1kzZzVubXlEekRzekgyMzc5MmVrYjJyRHJMZWFOU2pHVnc1czlrUFR2?=
 =?utf-8?B?c0FlbEhZZk85ZXZVeTZobE5iYjh5SUIyMVJTc0pvRVdSaDRjNStrRE5GQk5s?=
 =?utf-8?B?WVcrc0hrTVE3Tmd0dHV3MGNTTjVJaTZhRTNGRnhHcG1KUDBDbG1hekorYnRo?=
 =?utf-8?B?K0pweFVQa09kUlNpSElXdVlsbUptTnVuYkZ4a1l0MHM4cUFXdU83elJTQ2hT?=
 =?utf-8?B?NWtqVDNFeUhzOW95RDloNno4MnRUWmlRS1RFQ3U1bzJCSDhOUXl0SkFLM1By?=
 =?utf-8?B?Q0loVUUvRFFodkd2eFpKeTdRa3hxYklvNWsvaXJKWXVNdm5WMFIyY1hwYXZt?=
 =?utf-8?B?cTNjN0NmSmJudnNTSDI0L1dyemFzQU5xK1JWSndrRjdOUHMvTGEyR3hsUmp6?=
 =?utf-8?B?aGpCRkcrUXBBQ0IvZTZEWkRuM3VCNHc1K3JILzZCZktUdGZsQ3AydVZiNjN6?=
 =?utf-8?B?MDBBazFzYUltdi85Vm92Q3g4bWd3Nkw4WTQvakx2TFVkbVI5dzF0NjFNbGJ4?=
 =?utf-8?B?ZDhEYzRRM3NwUkFERXFjb01ON1FKNzBud3JJWEI4eCs1RE5lUExibk81VEQv?=
 =?utf-8?B?bEkxR0dkdHBQYUIranNoTUVUSFJWQndXOEcwUlpmSXZnQ0JnRkRKT1pma1hT?=
 =?utf-8?B?L0dCOFg1UFQxUSt2Z2pYSVFWSEJXa3dtcWNwOXpLOTF1MXo4d1ZEaDczSTc1?=
 =?utf-8?B?alFCakNZWVRhWEVJZ2xtaVJXQWl5aDd4VC9yZnNxY2Vjc2dLWXNabTVtVk1m?=
 =?utf-8?B?Y0VZNWdMc0dSRm5iN2lYWjJ4bnN5R3VFSUF3QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUVVWUU0UDc0TDNDVEIyZWY3T2RrNVhTbjVvVU5zcllXdWEvWmJaR3FZeWs5?=
 =?utf-8?B?cGRwamRaTTdTTm42TzFvc1YwQis4ZituOG1WVVRpR0htNUREMXFIRkF0Zkd5?=
 =?utf-8?B?TUdXUW85OEU1L1ZPVk1DOXBZdDQ5SGtMaGpVQ2FibENOVjBGS2IzSjNTTUhU?=
 =?utf-8?B?VnBaNHFDa0tDb2NyczhFWUdSMUtDbWFSS0dRUHN6SE01LzBoT0xFSGs4VkxR?=
 =?utf-8?B?YjBlOFRqemF6Y0IzUGk4aklrdFlxRElJY1NGWEZxNHFrZncwM0hxbmx1MDlB?=
 =?utf-8?B?dUtUNXVsaDhqWlJyLzBKYk9ma0RlL3FDZUUzZGZ0enJCUzJ4Vmd2TFVSSFlR?=
 =?utf-8?B?QkgzakVqVGk1dW9qV2d6R3V2M1M5dFNibXo0UjFadFNNWXRjQ3VlNUxZQVkw?=
 =?utf-8?B?b2haZFRlTndLU0dEcTRFTWtta2JjYmI5c1RibGFBS1NOUU50MEpOdHFuUUk5?=
 =?utf-8?B?UStLOG5qWkVwdTdRemRMVEpUaFo2ekRLd2RRNFM2U01qak9pUTlEaTUrWGNK?=
 =?utf-8?B?UFc0QzV0c3ZpbDNMcmYzWFNReUtaWVJVYnZMNlM5L09SbENQRGFYbGpUZUNE?=
 =?utf-8?B?bmcreGFheVVISWZ6WmtDVWNlNjBpa1ByRGdFbXZVV3E2OS8xMVIwelIwTlFh?=
 =?utf-8?B?d25GREFLMkUwNlkvZHY1TjdLZ2Vyc0JLNkNxNzUzUVdkalROR3lZNDFXanV0?=
 =?utf-8?B?T2hEbTVpSkNKNFRsUnlpU08xY3NBeDRXd3pmbWMxRmI3OEFXOThyRm9aZDlQ?=
 =?utf-8?B?Zm50RDc5MHRGL1FiRVdFODVGUmJsUDJiQjNkcy81bklXa1V1ZTVxaHhabkk3?=
 =?utf-8?B?RHZzb1JHbWMwSGVkVWdtQnUwalVaWXNkRTlYYzZlYTJldVNlRm1yWlE0NWJP?=
 =?utf-8?B?WGx5bzBUWmVHOE4vZFNzeUZVWlJEM0thcFgzWGMrUTk2RlQxd2JlYUEzMjVr?=
 =?utf-8?B?S2ErVnZ6ZGRIZVNXQi9vR0gweGNqT0M1TkYrd1l6N2JMY1g0TDhFcEJDOUI2?=
 =?utf-8?B?R1YvRFNha0RHRnFEQXc0UnMzMmR2ZFZnaUVxdmM3a3AwczVCbzZzRlVEeXhz?=
 =?utf-8?B?Vk9PaWJXdjkwMllsYlBQRm1CbEJuTXpzL0I5OThLTEVDMjJJbzM3c0cxNVdO?=
 =?utf-8?B?bk9WSEZ6V05JL1YraUswUXoxb1haMDZwWDZGWUVsSEZ5NitzM2g2eWhlYVYw?=
 =?utf-8?B?SkUreWZQNm1VM0xrRHFGVjB4YSs4M2Yva2VabVJLRzc2Wm16Skc3WEtrTnlC?=
 =?utf-8?B?RUZEQkM1OEV4cjdSQUZnMGxPU3VDMFRrVVpyNlZFT09QWE5Sb3l2WTBEQWJt?=
 =?utf-8?B?NTZwcmhiVDQvNFd5d0d5cnRLRll5QjkveVVkSmFJTTBEb1gvYW1qMjFrYlpS?=
 =?utf-8?B?emRKWFFKU29WVTdSSkNCVXRaaGc1QzVKaVo3Ymhqd05mZDk4RkRvV0RSaGZm?=
 =?utf-8?B?QUovMkM4TXBxZVF3VEowaElCTHQ4bFM2WFFlK2JmUUZwZUNyak1abElKOXA3?=
 =?utf-8?B?N0kvTG5Oc1VKT0tKajVpTXBCYXI1bHA2MURDMVlWc2JFWFNodzN5WHk4WkF3?=
 =?utf-8?B?OXFBWE4wcmZWd1Jxd3RlMk5qYnEvZjk3cFR4a21JL09IMnQ4UDFhWUtUbjFS?=
 =?utf-8?B?SUc4MnlvSFRIWDQvb3Axd1R0V1N1cXQ0RDZJa05yRnFINEdLQVRvTHJRc0FV?=
 =?utf-8?B?QVZQdUE5dDk5N1NRZ2ZSSGtjRjFOMlpUVG9xMVJKMHVTN21vSWU0Z1JxdTZ0?=
 =?utf-8?B?WEwrM0IwWkZCUndudGVJaTVXMER3WEtXODJ6c0kwOExjZlpxdXZWMmRTS2or?=
 =?utf-8?B?UUtLdHYrY3Q4ZXdkeVFobzRwajBKWU9GcVRDVlFIRUhrYkFoVHhqTkJ2Vi91?=
 =?utf-8?B?dlFFZ3padzY4cWl4bGtGV2hBdUFOSDE4dW1qVVN3ck9lNjFoRjU0cVhaQTky?=
 =?utf-8?B?aHpqTzBtaHk5SFVCbjV2RVB4bzhnTk1XaThIQkVZSVRvcHJSdFNpb3JQV2FC?=
 =?utf-8?B?eEFuTS9OdHY5WXhhUTV2TiswaUpiMjZRMmo1cTN1UlBGcFBoLzRaTW9Od0w4?=
 =?utf-8?B?eHFTWUhZTWg3eGZ1VFpZSWh2bmIva1gzZnppaDQzVmpTVjJEV1RRY1NRS3ZB?=
 =?utf-8?B?cElEL2xwcXVkUXFFWmExcVVBNGhZTFdvZTNqc1NzNVc2V1lIRzNxZS83Vmc3?=
 =?utf-8?Q?HRPwUg41O/fg+FsAh0H0gUPovylrxITjYiUj8YVbU/i4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0241A81182B43D408D1B38CB67947477@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cde750-9554-456c-1b1e-08de1b588766
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:13:37.5585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOBj1y8qda8cjtmRzIQ8tAvnYRNfDDKCg+TxFgkWIawFAdagmaKpdLpI1MH7Z+Nxvqxn+N663J8SsOjpSuLDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE1ha2UgdGhlIG91dHB1
dCBvZiB0aGUgem9uZV93cGx1Z3MgZGVidWdmcyBhdHRyaWJ1dGUgZmlsZSBtb3JlIGVhc2lseQ0K
PiByZWFkYWJsZSBieSBhZGRpbmcgdGhlIG5hbWUgb2YgdGhlIHpvbmUgd3JpdGUgcGx1Z3MgZmll
bGRzIGluIHRoZQ0KPiBvdXRwdXQuDQo+DQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4NCj4g
U3VnZ2VzdGVkLWJ5OiBCYXJ0IFZhbiBBc3NjaGU8YnZhbmFzc2NoZUBhY20ub3JnPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IFJldmlld2Vk
LWJ5OiBDaHJpc3RvcGggSGVsbHdpZzxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogSm9oYW5u
ZXMgVGh1bXNoaXJuPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQo=


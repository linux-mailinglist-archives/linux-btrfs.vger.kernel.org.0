Return-Path: <linux-btrfs+bounces-7157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5790950290
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 12:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501E91F21B22
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5F1922C0;
	Tue, 13 Aug 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cguzW/DN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996F208AD
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545515; cv=fail; b=PUm6ygXp0VOwn80YiGmuwiuK/InQ2Ytif1cnXA7nfK/4RDPwck9RPrkYIqxpieIC7TzldOZ0t/bdz2hrBXna0CPAr2VtKG6WCxIINSU0cahD0EYUrdgRm0pUymjxFqfZV3hAtU3osGHG9dskESnme2BtIQqQm022MIa9/mJ/gH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545515; c=relaxed/simple;
	bh=bszEKbNHt1grQYemiw8989q+Ec93zZhNrVepKR5jKy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sKvuXaxE9RegoWIzj1avyBRa30Y6LMmmYKlRGmOdkEvrvfXoS9e2GyD9WJBOoSw2QLu+vf+cwT7uikZpvZNoISY94U/x2rmsNIlr5bhFlAtGb1MnACB6OgDqquwv0LDqfgkjepzqMmFA90Y1Z4+UbNCBEdgoM2yM4v/n4ClcZW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cguzW/DN; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D81dZN005869
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 03:38:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding:content-id;
	 s=s2048-2021-q4; bh=bszEKbNHt1grQYemiw8989q+Ec93zZhNrVepKR5jKy0
	=; b=cguzW/DNe050RZS+1IQG8rs0mqBckY4ylvpY7Z34WvwUmbbqA0mQavmy9kf
	/R0MHMq7pEvc0DjTuotqP6sXtJoSfOU6l5qlqDWpodbNgqJJmJTWIsdIgtKH3sVH
	8I8y9lWJEZS6mD42rKuwasQ47y2mkpuuwg3B9Kb//FGhAVi8+35APq9OWN5aUlOL
	8tfwWj34RrISzSAvsuXlcjEICU6nx+IYxs7LWeEgw8tXCVZIRKFBeRUB2UKf9bEM
	6gyOialsRlUr8EdiP0Dup1ds5XzQnnqRuCdamGKbHMxvaLbzBfRWLyVEwh804kxZ
	5wX+zEckBS6aXe8pHXBkmu6mCsQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4103ktgmbq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 03:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7hYauG7mU0+7CBaizygIy3UB6wIM7L8ZfSMlh873SQyLXfrvaeECIu2cBtkbNLwAzV1UAs1earGxVlE772Gnib+zevTqBkISXPx62mNQ9md3TZhdhVppEv2oWp6LwN0wcnd6A8HOs1SL9fyTYm2YBhx/VDwYT17ui7QxLu8BigarRfQ5hdnknvxtN497x9IGhvKgbPcvrXsYG+TnxKiRweP+ewl5gr0ItwDXQVV8SUwH0QkCXyBErptXzRuXAPWuaFHz7OlCLH0Y3tZPT+OQR9ubNnFRR/YldXF5QifIDsSsiryaIKDHNu0Kwu4tT6DHj2Pr2IIGox57GpACu17cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlqt5a/Hl7xVf5GcvRsNDi4y297BdupFFQ1Nfu5KhyY=;
 b=W41nlQdrkv0rQADxssKmTqMFZjcBapM1HWATNXkwwqQDZlQPpgMTuoV48JfBcXcCGNnJHNl/xgxzObg2uPUOjfQHzCS8N9XM/R6Xajg9kObCo7U9eXfKUBLAgPHOJt+znI+MRSGNkyjlKmaJgsK+Day5kIgqNOvpVusH1pfckHIeYrPAEmbVbnYnIoPaG5rqZfkBzOE8dPoblASfH8Ik6jjScMwRFr26+6iZbaj5WB+DC5PrykG1qTyH6ywz6GFTHrgrBjKHjXzDd+8fbRlSKnEyGex+hDybsQDteKtBuaA/xKOqcGXG5WziGBZlLOcr6bmbWahrxxUwxnXTA8D23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5659.namprd15.prod.outlook.com (2603:10b6:510:282::21)
 by PH0PR15MB4479.namprd15.prod.outlook.com (2603:10b6:510:85::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 10:38:30 +0000
Received: from PH0PR15MB5659.namprd15.prod.outlook.com
 ([fe80::dffe:b107:49d:a49d]) by PH0PR15MB5659.namprd15.prod.outlook.com
 ([fe80::dffe:b107:49d:a49d%5]) with mapi id 15.20.7849.023; Tue, 13 Aug 2024
 10:38:29 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Anand Jain <anand.jain@oracle.com>, "dsterba@suse.cz" <dsterba@suse.cz>,
        Mark Harmstone <maharmstone@meta.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Topic: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Index: AQHa6bbd868+Clc3dEqLqcexqyie8rIfUfQAgAUQpQCAAKPYgA==
Date: Tue, 13 Aug 2024 10:38:29 +0000
Message-ID: <2ca070ef-4c6b-454f-9eef-1703ecc2872f@meta.com>
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
 <83f9b6b1-9027-41e5-b0ee-c667dd181fa4@oracle.com>
In-Reply-To: <83f9b6b1-9027-41e5-b0ee-c667dd181fa4@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5659:EE_|PH0PR15MB4479:EE_
x-ms-office365-filtering-correlation-id: 1034cf05-73cc-493f-90de-08dcbb841256
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFluYkdpallMKzUrUVk3YUVlcHlYU0tCbnVnbVBEd3ZndEtyMXUyRlNIRm5y?=
 =?utf-8?B?YUhTSCt2d0JPNHBrR0ptWHV3M1VRZjNjMWRPamc4WXJkbXhWaDNTSWtkZVBW?=
 =?utf-8?B?RytLcHFzV1lrazI3dDFYMVdoQkNaZExBM2w3UnVJbDNYNEUxR1dLOG1TOXhB?=
 =?utf-8?B?TEpZelgzZzZBeWhpVDFrb1o0RWpNRnF0SEJYUXp5UzdmSlhSZThKekp0TUFX?=
 =?utf-8?B?Q2lTTElucUx3VHBtWU5jVDNNREs4M2xuclZrZTdPWmJvNmVQdFZrMzQzZ1or?=
 =?utf-8?B?SmxldXdjR0x4c2ZOdnkwY2xweEhWNUpwYUgxTWRNY3ZMeExhdEMwQTZRZ1hG?=
 =?utf-8?B?cy9STVpwc2U5WFhqTUJyOEFxOHp6TkFick0rTE9tUXJLc0lVSEdtTXE3ZXhB?=
 =?utf-8?B?UG5mZTlxenBKRlVuVEFESHBlWnVGVVJEM2dZeTVjRUVFNmpqb1kxbEVrWXcx?=
 =?utf-8?B?YjVxT3Z6YW9DQ2EvS3ZsTktqbEw3blB2bDBWUG92ZEpGZTlpa1c5WUhsbStm?=
 =?utf-8?B?cS8zTDNPUlp5MHBTc3hlbkExWVlUOTRTaDUwREUwaXlPWGFiQy9SZytxU0hG?=
 =?utf-8?B?RENkYlY5bTFUNFByY2JWbFhtQ3F6aGkybWVkZHplalVZajNrUmlUSlMzRDlN?=
 =?utf-8?B?WllLS1lDTnZ2OGtxWVZ1ekp5TDNQUUNEYUFpSmRpMVBzNjlUc3E5SGUwQk5T?=
 =?utf-8?B?OEZIUmp5WVJPZHVROGtmN3VJMU00NjhlbXdFMk1qUk80RXMzYTkzMWFuYXp4?=
 =?utf-8?B?RnJUMkhnWTVRL2h6amQwK0ExUUZibzdOdGZEdWlOUHhvQk5CUWd5MWpPaHhP?=
 =?utf-8?B?dWY0R0k2V3NaaEtTUTZaOU9WNFBKdmJmT0o4d2FnbCtoeGlnQTZZQlVKVDly?=
 =?utf-8?B?c3BGOVNWUjFMcmpubXNReVRhbW9QMWFIMXpnczBoSllGSHg2WEs0VnA2SXlm?=
 =?utf-8?B?SSs3TllCa2w0a1poWlFCTWxpc2hDNktuSlRMWWI1L0VMejNFMjFlUDYvaVMw?=
 =?utf-8?B?U2VQeGZSbGdSeFAySjlJS1lrbmNyZkMrMkRkbVlrTTVPUTMzbGlmaEJ2cGpY?=
 =?utf-8?B?Um1OUEIwNTA3VHhZcEtqdjdocWVaSFE4S1F0ekw3S0ZaK1c1S0ZpbTBEcWdN?=
 =?utf-8?B?R2xYM05uWFNBVERzbUlSdUJyTU1CYlExWHk1dWQxQzBFc2s3Q2ZDbzVrQ2JB?=
 =?utf-8?B?SE9KZXNRU2RHdUJSOGVCdDg2bi91ZmxTZUVTZURkZmVESzR6eW1zTUpSb25l?=
 =?utf-8?B?VWd1RVR0WFNBdFRnOXQvYlBrQ2pnL0ZlVXhkcU9wMFRQNmhyelFBL2RTdXkv?=
 =?utf-8?B?Zmc4dVI3MlVRUE0yRGFMM0JMT0lMNEx5OC9IdkcxR1VWSkVSMnhqR0xlM3Nz?=
 =?utf-8?B?S2dLUjdhN0htckRrMElVc1N5ZXFWdGxoMVNEdUd0eDIyY1BkSkVpb0h0dDB3?=
 =?utf-8?B?Q01sNGVyeXFVTWQ2ZG1lMWR3Szc2dnRJd2drVHNKL3d1UmcyZDJ0VDlSY24w?=
 =?utf-8?B?QWhmT2lzVkpMNEUyUlVHWEhyUkdFZzdORFBGeUM1K2FKNDNJT25iN0srTHRD?=
 =?utf-8?B?aEF0SlZFdVA5S2FKVHovRVRMZWR2VG1hVGRSaWVWdDdLLzEvVjdrcm1taklk?=
 =?utf-8?B?cjBBdzZDbTRrM1pEaVV6RU5veitUTTJNSEw5MndQeG1wekxMSXdKdnBmZEh1?=
 =?utf-8?B?WUtYU0dkSnpPdkNLMytxMmlCc3IwOWxyQjFQWVdnT09wSFFxbzYxZ2wxdEM3?=
 =?utf-8?B?Y2JJVjlXcTRuZVJtWmN0U0V5dVVSSFNpVGQxajJER1psTWdTN0lLVDdFSU5t?=
 =?utf-8?B?SU9pRUt3L3hSS3FsVDBacUFVZno3ajdwYnRhT3dDTG1wNnFkT05DK1EyNHNv?=
 =?utf-8?B?Y3k4eTdHOU5oNTZ4Y2pRYlYzRXBvdzMyU1YzcHhqaUczaHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5659.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1NuYXA5TTA4NWtXOTZwQVZPTVFyeDhBTC9SSjluU3N3Mmg2ZjM0b1ZuQk1y?=
 =?utf-8?B?eWsxNUpQQmlSZm9OdFNRRUp2alhZQ3ZHN0VWT3R4RTl6d1F3RTBZci9uaE9O?=
 =?utf-8?B?c2p0VUhoYVF6Q1FUaW1mRmM1a0lwN1VuVGs3SmpqbjVCcmpsMTVyNmF1b3ls?=
 =?utf-8?B?bDF0eDR5VVBXVDhEYTRvWmFnV2xzUnN6RStYL0MzUDdsZnlyUUtQcDlYTytX?=
 =?utf-8?B?WHc0Z3FRQ2J3cmZkcEl4UVM0dFdiOEJySDY2R1h2S1B6b1RvUlo0d2VDNjAz?=
 =?utf-8?B?UUVuN0FpSGlyUUJMditOWUdLalh1UmkwK1FRRUhsUS91ckw4U0NuWXZzMC8r?=
 =?utf-8?B?d3lYWThkL2c4NVdFTm50YTBaMFlFVDBPQTQyTWJYUmZleTE4dk5ITVdnN1Jz?=
 =?utf-8?B?azJkWkhVMkJ6dlc4NFRTNnlSZThESFJEMTJJMWtURUMwSUxvU2ZlZ3VvM1lU?=
 =?utf-8?B?Sll1Vk0yS2V0YVVXempaUmxSbGRETnN1MmdIVG9nM1pmeDhWS0pnZEdqdi9Y?=
 =?utf-8?B?WU9HSHR3SGxSc3FkZE11czg5cTV2WGhMNG9Xc2srL01qTGFpeTFKV0djQ0tL?=
 =?utf-8?B?WkFYTFVsckJrRkxTV2prOWFFbWp6NmVMMFFHalI3NDhaSUMrcFJPQnRUVnlh?=
 =?utf-8?B?QWxadXZMcm5OZ3dGem9DUVlFdnBtRFZidzhucFY4OTZGNi9rbGVYdE56Uk9U?=
 =?utf-8?B?d3NnSmpuaTllSUVSU1V0V1hCMWVDNzArYTRMVVJYbFAwOURtaThRdnNrNUR1?=
 =?utf-8?B?azAwL3U1SW4wdEowaVFJS0lxVStaWVhMcEJVL0dMT2U3OVFrTjZhSjlETkkx?=
 =?utf-8?B?dG9pVEtiV1hoMk1YZGwzL3NJeGRheGFOR0s2QlhQOW5odHJQMDNyTzlQRDNB?=
 =?utf-8?B?Tnp3R3ltNmVmcVlNOXgwaXYvc0tVOFhNY3U0S3FRYWpFUDNKanpFVXBXMDNx?=
 =?utf-8?B?cW44bEZ5ZlFqWEh1Z2RpN01Xd2dOMVhGSmxzVDM0VG41M1BvUk5NaS9TRWwz?=
 =?utf-8?B?UVdmb1p3VE5SVHY2cW8zandVcFhPdVBIN0hQRWpHVzJoeGpOK3Z2d2g0M3pm?=
 =?utf-8?B?TFlxb2NCaEFQcUZqT1o0d0ZFaEppZnNLS3dpa3hxUVNlKytsYVpQQjNKYzJR?=
 =?utf-8?B?QVl4NkZTdUwvZTNmZDRJeXRoT3pEK3BFUGdtME1udm5PN2pJNWx6QWpoUzM2?=
 =?utf-8?B?WWlhODZNWWlNRzl3bWRzMEhyWis0N25WQUZvcVZZUHlRRmllaVlFbGE4TlZm?=
 =?utf-8?B?RWNTMnN5bTYwcTYxVmVDQTIxdDVFS2pVTVdNU2pIb1hCbU8vNXMxamxiUzdI?=
 =?utf-8?B?NHFaMmpkMHZJTWtqcGxORzRQT25nN1JjRVcrUWJTVnZ2YnlFS2Rud1V3WjBr?=
 =?utf-8?B?OUc3cGFqZllqODRFWEkwMEQ4TElHNm1vb090Q0VXRlFoaXlHbEVRRTJFeTU0?=
 =?utf-8?B?MG1vNUhnZ0JUMXoxb0Vxc2dETGphWU42TzRCNkZhaENqejhHSHB0RURUQjd1?=
 =?utf-8?B?YjA3dTcwRFo1MHprUmlhZ2wxai8rcnluM05HWDdma0tZRUgzVDBic3htZHBs?=
 =?utf-8?B?VFpLTklpL0RkRUo0WmtpSWNvcUtQaVFsT0QzZ3N1b2poYnU3S3J6a2F5alBU?=
 =?utf-8?B?QWVrS2xPOUQ1blZac3k5U1VBTmdmZnl5UnQvcnpkWi8zWWhJbUErSVRlM3Nt?=
 =?utf-8?B?SVBXSUxKYjNaWFlWMUdjZVBVME1GMW4xeUx2ajJJMlVCN2FLdnMxZnJKUFRx?=
 =?utf-8?B?dG1zZGdJL0twSktUcVpXbGFIeFBQOUd5TElybllkaDRoektiQ29adlo5RUlM?=
 =?utf-8?B?eGQzUHJhSFczZ1JKMFZYSFlqL1FaWkM1QWorNS8zaitNeUFWYWZzelVYQzIr?=
 =?utf-8?B?ZEhPQnZNcTkxdElGcWdCeW0zdkEyMjVGSFBjdTU0U1NWdHlDS2dFT0NmaWVK?=
 =?utf-8?B?Z1VjbG9zWVB5Q3dJWkR1Y1laWE9kQmF5UVhkVmdmaG5nZUYxVEd0ekd0aHdE?=
 =?utf-8?B?bkNQV0tkOWt2eHVWQ2wyVGZXUUc1RFY3WFFsQkw3YnBrOVA2NjV2d09BMFBP?=
 =?utf-8?B?WldtbzdOQmtZdXB6Qkk1Y0w2SWFOV1l5MElLVUlMRUphanJ0QStHTUxxQnFM?=
 =?utf-8?Q?r2lRsZhW9kgZFnTQOqocIPl+W?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5659.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1034cf05-73cc-493f-90de-08dcbb841256
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 10:38:29.7025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: if0ealVVbPNSecrI+4BC2BtrpKmOGblq+Pwm0Su6o9HBWkP7YkvT+/G6dEPRkH/bavrxnA4O84dgQLQGhj8TUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4479
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <C67C61CCE7BA924DAFB3D5F5847F92FA@namprd15.prod.outlook.com>
X-Proofpoint-GUID: fj5GW5ZBsbNgtKZTj-WU9nK5vaXAf4TL
X-Proofpoint-ORIG-GUID: fj5GW5ZBsbNgtKZTj-WU9nK5vaXAf4TL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01

On 13/8/24 01:52, Anand Jain wrote:
> >=20
>=20
> Nice feature.
>=20
>>> +=C2=A0=C2=A0=C2=A0 OPTLINE("-u|--subvol SUBDIR", "create SUBDIR as sub=
volume rather=20
>>> than normal directory"),
>>
>> Please mention that it can be specified multiple times.
>=20
> Nitpick..
>=20
> Should '--subvol' be '--subvolume' for consistency? use the full names.
>=20
> Thx.

Maybe, but we have --rootdir rather than --rootdirectory.

Mark


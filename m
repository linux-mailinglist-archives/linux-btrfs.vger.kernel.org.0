Return-Path: <linux-btrfs+bounces-11082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8486CA1DB7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 18:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938A13A8952
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563318D65C;
	Mon, 27 Jan 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UxwAjG6z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1318D621
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999754; cv=fail; b=SlebZR3gC5Z9g0/UahBTahgwBWgLQ1Au+PZo+ABG0AzpOWGMTtzF7EMrexDCzmek5eAltNHZcJ36KuXoJvQpnNSxhhK+ft7rMeOnGekvztm32IbQR1SlPXNOh3y9ANhI+enrEUkcJJFGamPKzNHjXj8+ylR2flfpl/pBhMr/flw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999754; c=relaxed/simple;
	bh=4Pd6ky2ifQLxvYqvu6w/RBIKWff+qY0IDksNnvRPTos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b0yLMdEhrDnOPp0ns1pnE41w2G96Y7DU+crle8Em/48NKnNFTH07fwyKON5/8z+1+Tb5hnm3tnCQK+6+Gw5pGsnAdhVQnd0BC3bZB7bM4eOF6JaCrSFlv+fhR/juiD8GApDI6aF5yBj7WNP53rgZZSCaJasl8Fu2rFfmFfQujTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UxwAjG6z; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RGllAJ001835
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 09:42:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=4Pd6ky2ifQLxvYqvu6w/RBIKWff+qY0IDksNnvRPTos=; b=
	UxwAjG6zp9IIOOON8dmLV/a5r1Z4aBGJ04bdW+sc0xQjQqoFAahJqAgv6pvdfa2H
	YE+ycsMJz9x25lTKPwPeWUrp/3/FjtlHX4kXO61M06PN0pvH29plyPw1ouG0M5M1
	bk/UpewYvxKaLUi7eLcVwwh1HmvMpzEhBisWDe8xZdzPueUXByKo0DaSinLUQcR3
	seVIa+DG9OfJq0VM6cqR09jj//gpVS3yPZro7jsCEF76XWbPNvr0SyW6GWJnI1lc
	1Alq1rPWdVgKWu/LwKOFQx0R2/0Wu2V6ruGsKok+99BG06OM/n+CvgjfdZzKXaRI
	jwJc/qJyvIwf6Me6ZjYx5Q==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44edyv0e03-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 09:42:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ2JPFiUI0ZZXzo4PjMVE2wiVyn3NOZSEpNqc6EpxtuLdH8qKdUNdF/W6wrFxCVBMFOtJcte3mkoZlx/eP0zXjoK3b1dz4+FUj+FrFNquCg0LB+f8+169QQMKRfwYNxkUr2U3HavH3vD+nHhN/kHa7NaZlpaKpc7JOv8+lXwR10KtA6G+w74POdOtigAbgMxUC41DRVaGTqz7AMv5rkCfrkCDkCpOcLSkzqQyfoaOx+4nqa1ijR1QYYTZrTlBxdj61bP93P27VCsLS7MaWEO0IyVMprdMjHdm7j5sOGOoNF7aWwFxI78VPZC6ciKAhDQPAn4Xf7Xgr2JLFcmoITe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pd6ky2ifQLxvYqvu6w/RBIKWff+qY0IDksNnvRPTos=;
 b=BOe3BBUvxxOjZAJix8mQi1GrY49FS738R5bGijg0hw2GjYJkPnqI3/BEVzdBPSI0nXzV+rO1ZDyQ01dLJG5Z4E68ObQ8WUwNGcEGJ971BSXXC9+2RaInOOE4SquzyRI20QNjStG7y7iEsNbkrXaARz6M4zVf1Vrk/2xLqYp3FS2BtZLe3WXxik+ng9AJOQiRf13wUfEW3RXx0Jr9uOSag7srC2uxDzstSZ2GgUsLV58R3rr3xj8pYIg2axmQFlL7ILfX8K6lbhdBtHREfVQChkSjBC7og2iLt1PD5mBQBliPczNEpqFukEL59hj8l3vFhM6Yw20aBgp25GKo1lJtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by CH3PR15MB5561.namprd15.prod.outlook.com (2603:10b6:610:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 17:42:28 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 17:42:28 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Filipe Manana <fdmanana@kernel.org>, Daniel Vacek <neelx@suse.com>
CC: "dsterba@suse.cz" <dsterba@suse.cz>,
        Mark Harmstone
	<maharmstone@meta.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Topic: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Index:
 AQHbbMivsPcQp6znhUC74MzCCLPe17Miu8CAgAAUEQCAAhrjgIAArciAgABEL4CABQ9uAA==
Date: Mon, 27 Jan 2025 17:42:28 +0000
Message-ID: <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
References: <20250122122459.1148668-1-maharmstone@fb.com>
 <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz>
 <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|CH3PR15MB5561:EE_
x-ms-office365-filtering-correlation-id: f904082c-2b4c-49ff-3761-08dd3ef9f826
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZExGTXJwVTRVL1RFblpmSnNNY2RRSWJaemZjL3FMbkFyY1g4U2xScThaYS9O?=
 =?utf-8?B?MC9PbSthZzd0ZHJmd3VBYzl6ZUNZTmNuWFQ0U3F0bEpRK3I5Ui9oN0M2VGVu?=
 =?utf-8?B?VmhUcm80MWhKb3JvV3h1aW4rOUtLb1VVRTcwbmU2VjhoRThWZjJNcEtSSXYy?=
 =?utf-8?B?Q25hTVpWcGxNam9OS1lNSkpLRG5CVlhDZzk2MmRCRjJidHhTWWY4WlRqcmx0?=
 =?utf-8?B?bVBPeGpndEdFTDNmYnV6UDhHUGxpbVg2d3lyelJDN3VjUGRyQ1FWTEZHMk9I?=
 =?utf-8?B?YjJIN3hWY1JDYVZkbGk5eUZ4ZnBIdjV4YmRBSFBoQWVPamsxaHplWUJacFBU?=
 =?utf-8?B?R2IrVVNEOFNpNWtmM1lBMzc1M2N2VFJIY3FkRm52UkRVQ1pZaTlmVituVDN4?=
 =?utf-8?B?enNlZFpQY0ZBS05OWVIrVkpaVmp2MDdkOHhJRlpCS3MxRnozdzZoaFp2ZHNG?=
 =?utf-8?B?ZklPRmlKWmJJd3k0eGRndk54bzNlRG9QYjZBeFZvdGExdzMwRWZkUXBKWURC?=
 =?utf-8?B?UWpFT0svS1RlUG96NlJDbzlIc1hCM1U0SzR0ZWtaQjExQ0h2OEZRNUhIcU9s?=
 =?utf-8?B?RzU5U2NOTEVWOE8rOEJ0aDFSUlFrWFRVcEo4TWNhcVBxSFdDZW1EUlFWU2tI?=
 =?utf-8?B?QXlqdzIxUFAwREp3SHFWS1FZdnhQWXEyZlZpZ1dvYVZ1TW1mNmlSVitmSlhB?=
 =?utf-8?B?cVo4aEg5dUtMNXhMd1VZcm4vN2JXSmxrZjhNcmtvYnRUWG9LajNOaTJaWGFG?=
 =?utf-8?B?Y3UxeFFGQW5Lc1VDODRub2FFRHd6dk5SZ3A5TkFZOEVxZWk1cWw2Y2hyTkor?=
 =?utf-8?B?cnlIUnU1NzZra0hHdEdobFRobXkva2V0RXh5Y1k4Wk5rVUYydHNPYnJhYkta?=
 =?utf-8?B?S3lRbzlPdGNodTRPL3FZWFhNSmVuWitKb2tvUWI1RnlpaUpzMXkzNWFDdWpo?=
 =?utf-8?B?N1YydE1TOUllTUVwek11YUI5TFUvZVZhTGtHZWNTa2RuTituZ25oeFZPYVkz?=
 =?utf-8?B?c0Y3OE1OREc0OEEyWUtLUjRTaEVTYS8veVJ6MkorVXN2bkR5VEFZUkwzc1gv?=
 =?utf-8?B?cUMwMUZKeXB6UE1uM0wxY0VWQlhuSjJVbUN6UGk2UkVsZU1MOUIyeCs1YnZN?=
 =?utf-8?B?YWlkUjM3UHRBYUFDWThKMExyTGREZDQ4Y1ovZUljeTVHVkp0dWd0MlpoR2NN?=
 =?utf-8?B?Vk1NWnVTb3krRWdaUHNLN2s2dDUrSEZvS3BYNy9WNEs3ZVlnWW1mWHZxcWJD?=
 =?utf-8?B?b1ljVmV2aU8zRVlHd0dPeUU4QzJXbTNWMVR1U0FxLzd4aUd2QkNqL1RkWG9n?=
 =?utf-8?B?ZEFUVzU3bFkwZGd5L21YZlNLOU9YaDFTWWdqRmxwTmQ3KzMvNkFjVHdiayt2?=
 =?utf-8?B?Q0c5L0UvVS9rd2NiWExEcVZCdUpJRGRlQlZDSGVkUHVTeGNQRktiYTZWNmVH?=
 =?utf-8?B?aFVuS2tVRDB4TDl3emFMRWEvVExVS2k3UGxlQUxBVWwrK2tjMWE1TER6bXJP?=
 =?utf-8?B?S1pLWmQzT2JrREFmeHJhNXBTYm42dm9oUm9GeHNxQkVUWU5hUzFGdzc5bmln?=
 =?utf-8?B?b3FqOXdmMDViOHN0dDN4NVI4YlZqSXR4bDhGTXBucTdXQUpvNUJEaGxiSFk0?=
 =?utf-8?B?SmluSmJwcHpTdXV1cFp1MXEweVFDR1I3c21CdnNqamozdlA5b2FmM3B2OVZD?=
 =?utf-8?B?T3M3c3BRZnNTODJUS1dxK1Y1Z1VIOFRJMi9GT1NtTjlEZnV1TnVoeWQ0dE8z?=
 =?utf-8?B?SXpPcm0zV0JHQXNYRVlROVBKTWRQdDdEOGhtSkt3R2wrV0NIay9uU3llL0lq?=
 =?utf-8?B?Y04vQVZ2d0F6OG53L3Vycm5MQnZnLzZYK2tvTWpHUkVodEJNWnJmL2k1Zi9P?=
 =?utf-8?B?dWE0dlJqbCt4UTdYTlpIMkRYM3pBT0lxQTVBUk4vL2wxUkZWVHdpa1lqSGlx?=
 =?utf-8?Q?GdyTfuwo9wrLDyrVoxhHYZVPFm0mVexx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHl1ZWRZMTdPNGluOVN1NEJFaUorck5YQXVkM3VvSkZkWjh0SzlRRUYySHEz?=
 =?utf-8?B?enFHcXVjNGgybVNHNm9ORWlwbktvMzcwdTVqeEtwZFAwaEk5dVl5a2NmQzZP?=
 =?utf-8?B?cGFNc01MUWtHUDVOQmtIb0I4Q2R6V29NczFPbGw1T1ViRENjbjRmejBYRGl4?=
 =?utf-8?B?dnREZWRxZ3VBMEtubUNZU1NiYVI5QzRHMjJKMkdoWEJyVTEzNlBKWEZ1RmdG?=
 =?utf-8?B?TTJZWUxLNWZYRkRianpOY05sUjVpUExNVG1ZZDJSUEtBWHBaQ1JyYTUzNXh2?=
 =?utf-8?B?S1NpeW4vR3g4ZmJ3NGY0dG5GdGZ0NWxhb3U5QmlkYkhQRHZOeDJDQ1NPRjQy?=
 =?utf-8?B?bWpYR2VHTE0vQ3lPTVd4Zkl6cStUbXNNQnZPbnVsQW02dGhJemNERzFtd3Y5?=
 =?utf-8?B?dzl2S2EwK2NUMWExZ05VY2toMVppYkJaUzZEQmdWaUdiOUsxL1EvNHN2N1Uv?=
 =?utf-8?B?dnNxdGEzaTBUdklVdjdpV1dzYzd0NFRXQmFHOEVDM2JVRVJKS1RzNGRoNFlT?=
 =?utf-8?B?NWlHRmd4dVdSUzVPZnVkdm1QaUd1TFNpaExzb3VPcHB4My9WZEkwdyswOFVt?=
 =?utf-8?B?UmdPVXZ6TjczWFFERVdFdzRtYjJEOGt3ZVpFNFQ5VEh3YytrZzJNeGduZHQ3?=
 =?utf-8?B?Q0VrN0todTRwZ3ZpNFVOeTU3OUhHM0ZQYnh3TUdLSURZUW93R2VwTXRPaXNY?=
 =?utf-8?B?Q1NvRnBLQUVTMXRVdTdjM3pLSDdpY25wR3pnZGFsZ0M1dmw4b2RwQ0hzWVNC?=
 =?utf-8?B?dHVyelVKZUJFQVRBRzh1eGZsL3BQZnJNWFdQUW5lMUhhYUZremZLS2pKZ1Bm?=
 =?utf-8?B?RFpKOWpSeGZ2SWpZbUJmbHhMajAxT1lrcE8yZWs0aHBoMlFJWFRpSUZFQTFN?=
 =?utf-8?B?L1Q4ZWk4T0xZSGh1QXpKZUtMMm8vQ2tIUjU4bUgxVDdBR3pUM2pRbXM0U3Za?=
 =?utf-8?B?aEc0TXd3cTFZaEF2V0lUZXM3VDhMRUh3QVV1N1pITzlyeStKYmsrbUVvNG5j?=
 =?utf-8?B?QVBzN0ttVzRSNkZMdG5ycmxSRCtGWUtOVnM2bERBd0lkcXFRc1FPZDBFaDRu?=
 =?utf-8?B?cjFnV3VJMHNPMDhsR1BYaHVCdHN3NG5uVkcxZlJYOGRzUEJ6OXRBZG4yMjJw?=
 =?utf-8?B?RUdtc3g4Ym5SWncvZ0JTQzRRdWJNSy9vVU9RcWdTVlhlaXhKOHNGQVpWdHk2?=
 =?utf-8?B?MUNIL3VVTmlneXRHYncvS1d3alBDU3YxV0pzbnlwSFRzb1BRRWpKQ3ZwZ2Uv?=
 =?utf-8?B?L2lDZGJkT2pxYkNDTHN5emFvTk9XK3pvVlFsdnFTOE9mUHU5OEdmWFBydDFh?=
 =?utf-8?B?MnBkMzIyZWpPaEEwV21mZ3h6d2tvUmxQRklzNjROSndDelFMMDY5b1Vra0ZI?=
 =?utf-8?B?aTVodDhQNjcxMXdaeVR6aXBTTU9Galh1SzM0K3Z2K1hVcGdIZW5INGxWYnhV?=
 =?utf-8?B?Y0JUMVJEblNPdmdTOUJDWHhrSWJGTWgrNFIvazdwMmtHWXBpcmtaeUdLbXAx?=
 =?utf-8?B?MnVIaExtQWxJS1hKL0RJODU5MWJGQS9qRzVhN1A3UzJXaTBXbmcxbUF5NHFT?=
 =?utf-8?B?TlJJbitEL21OdnlzWHluaElVWlJuQ21iazFleDZSazhId3BuUUVuekhuTzFX?=
 =?utf-8?B?VUVtbFQrSEQwaGhpTWpWNE5laURWaXcvZ0YwZ3ZKc2VmajVUWjZETlFRUHJ3?=
 =?utf-8?B?YmJmd1FWK2h5c3pSeGdzZXkrTzZoYUZJOTBqdUVjMVMvOFUrT3lhdXU0RTRV?=
 =?utf-8?B?Rnl5MDhid3ZSSmwzaTRva0RjVGduM28rdXVyd2JEUzVSc3BBdldxeVY0NEVV?=
 =?utf-8?B?TmVMdXlXR2hKT3JGcExhTnpVRTVyOWtNZjVIa2hNV2hYSEFwNTdoeDM3cElE?=
 =?utf-8?B?SHZxZ3JXVi9WbE5Qa1hNa2dWazdTTDAzRHBUVXRBcE81TW9tNHFXaHA2VmlJ?=
 =?utf-8?B?L3JONmpvYUZIK3ZtUFpsSVd0L0JWbHFSU0lBSzNJR1U1NW5XbEt1dVhER2Yw?=
 =?utf-8?B?VnpwZ2FvUkNoUEJlVk1ybHdWbWZIQ0xtUng0bzVwTUtWdkI4RmRGU1BLNHBU?=
 =?utf-8?B?YVZOWVdHR2ppUDNIMkZCaFA3U3hWY1BWT2RPQ0VNTGFOc0YyUWZaMGZZMTY2?=
 =?utf-8?B?Z3Q4UVNRYTRGY1o4ZWxmOHZjSk5acnhjdDd6d0huRTVWZXJDZTd0Vmh6a2pB?=
 =?utf-8?Q?ursAsL2j2j+PEF+4f81jC0Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D17F0C27E56A6447B66A7972C65577DD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f904082c-2b4c-49ff-3761-08dd3ef9f826
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 17:42:28.7114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1Q8gWzttILlZ+ILlGLN3fVRp9Rq8eS9HvB4bd9DgIgvyDIycrZ9hMxcCMlO06bOZ+DT1Z1rz5opX9UtGtxk/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5561
X-Proofpoint-ORIG-GUID: 0S8Uxt8AZcqRJ9asR1xwWVwtq-i3M-MF
X-Proofpoint-GUID: 0S8Uxt8AZcqRJ9asR1xwWVwtq-i3M-MF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01

T24gMjQvMS8yNSAxMjoyNSwgRmlsaXBlIE1hbmFuYSB3cm90ZToNCj4+DQo+PiBJdCB3aWxsIG9u
bHkgcmV0cnkgcHJlY2lzZWx5IHdoZW4gbW9yZSBjb25jdXJyZW50IHJlcXVlc3RzIHJhY2UgaGVy
ZS4NCj4+IEFuZCB0aGFua3MgdG8gY21weGNoZyBvbmx5IG9uZSBvZiB0aGVtIHdpbnMgYW5kIGlu
Y3JlbWVudHMuIFRoZSBvdGhlcnMNCj4+IHJldHJ5IGluIGFub3RoZXIgaXRlcmF0aW9uIG9mIHRo
ZSBsb29wLg0KPj4NCj4+IEkgdGhpbmsgdGhpcyB3YXkgbm8gbG9jayBpcyBuZWVkZWQgYW5kIHRo
ZSBwcmV2aW91cyBiZWhhdmlvciBpcyBwcmVzZXJ2ZWQuDQo+IA0KPiBUaGF0IGxvb2tzIGZpbmUg
dG8gbWUuIEJ1dCB1bmRlciBoZWF2eSBjb25jdXJyZW5jeSwgdGhlcmUncyB0aGUNCj4gcG90ZW50
aWFsIHRvIGxvb3AgdG9vIG11Y2gsIHNvIEkgd291bGQgYXQgbGVhc3QgYWRkIGEgY29uZF9yZXNj
aGVkKCkNCj4gY2FsbCBiZWZvcmUgZG9pbmcgdGhlIGdvdG8uDQo+IFdpdGggdGhlIG11dGV4IHRo
ZXJlJ3MgdGhlIGFkdmFudGFnZSBvZiBub3QgbG9vcGluZyBhbmQgd2FzdGluZyBDUFUgaWYNCj4g
c3VjaCBoaWdoIGNvbmN1cnJlbmN5IGhhcHBlbnMsIHRhc2tzIHdpbGwgYmUgYmxvY2tlZCBhbmQg
eWllbGQgdGhlIGNwdQ0KPiBmb3Igb3RoZXIgdGFza3MuDQoNCkFuZCB0aGVuIHdlIGhhdmUgdGhl
IHByb2JsZW0gb2YgdGhlIGZ1bmN0aW9uIHBvdGVudGlhbGx5IHNsZWVwaW5nLCB3aGljaCANCndh
cyBvbmUgb2YgdGhlIHRoaW5ncyBJJ20gdHJ5aW5nIHRvIGF2b2lkLg0KDQpJIHN0aWxsIHRoaW5r
IGFuIGF0b21pYyBpcyB0aGUgY29ycmVjdCBjaG9pY2UgaGVyZToNCg0KKiBTa2lwcGVkIGludGVn
ZXJzIGFyZW4ndCBhIHByb2JsZW0sIGFzIHRoZXJlJ3Mgbm8gcmVsaWFuY2Ugb24gdGhlIA0KbnVt
YmVycyBiZWluZyBjb250aWd1b3VzLg0KKiBUaGUgb3ZlcmZsb3cgY2hlY2sgaXMgd2FzdGVkIGN5
Y2xlcywgYW5kIHNob3VsZCBuZXZlciBoYXZlIGJlZW4gdGhlcmUgDQppbiB0aGUgZmlyc3QgcGxh
Y2UuIEV2ZW4gaWYgd2Ugd2VyZSB0byBncmFiIGEgbmV3IGludGVnZXIgYSBiaWxsaW9uIA0KdGlt
ZXMgYSBzZWNvbmQsIGl0IHdvdWxkIHRha2UgNTg0IHllYXJzIHRvIHdyYXAgYXJvdW5kLg0KDQpN
YXJrDQo=


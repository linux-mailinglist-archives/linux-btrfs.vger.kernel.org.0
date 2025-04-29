Return-Path: <linux-btrfs+bounces-13524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26439AA1ACA
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 20:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C5D983AD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 18:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587CD253B5F;
	Tue, 29 Apr 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="A87DN8gk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-007b0c01.pphosted.com (mx0b-007b0c01.pphosted.com [205.220.177.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC782C60;
	Tue, 29 Apr 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952071; cv=fail; b=q7jv+AEfH+IXkWbbYa9lbbY7NW0v4/qqQbqy5FbzW/5uPoe4XbfHwGR+OQFmUtYTh8ROGWo2KhV2p/XdUw84qh/NQnfYcadh7zAYkmN202fbLYnn5fA2sdxDwvMzrd1t5LikBDfYc1PNf+Rm753q0qBLJNpf3lYOXyt2a0haYFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952071; c=relaxed/simple;
	bh=7oMncg4gAFvTChYpoJC2F53CGspaUHR0nxlGHcSNPjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Glsh70z7yJPah5Xj/6H8n4FRetqKNqOqrUi7wywm616vRH/2M6B8M+AvY21bdUPUqI0us2xnk/obXziLIq1xTDRhuRB+dTeN8pSfXg4nvgiCw76ooILtrTkbsbBlTlf5qFzTowZVxpRUy8lGqjrwaafE2DMa8k0b1433B40jPz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=A87DN8gk; arc=fail smtp.client-ip=205.220.177.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Received: from pps.filterd (m0316047.ppops.net [127.0.0.1])
	by mx0b-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TAt3QR017740;
	Tue, 29 Apr 2025 13:28:50 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010006.outbound.protection.outlook.com [40.93.13.6])
	by mx0b-007b0c01.pphosted.com (PPS) with ESMTPS id 469favv27u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 13:28:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXzichjGuDT1DEFowsbMEo1n22P4l8x916aPPY2Ig01cE2AFLUnjOO+KDwlNNlpI6kbD2rai3NqG9nSlE6C4P07fJTi+E0YJya2vzt7NTO19ie/EooMy1gibDfDerkKOWwn8H0Slij+LjtxUNwyv9rwKaFka2kRNwRKvg/0nm2pLiQq/K0eNPBkfQHtA7Q3jgITiU3UAG3TeNzmGd0O4ecxla5Xr8rPQjtAPw+7vLNpmXCYZXZfGLZg7eoYSGk665lh/mVk96dI5M8xfMLo+l9OYhTwJcX/dTl8Cjj5a9Cwv2dHgXymVPuugPdMCgbnKlyCr4eF7Qhq8aOKeT/sfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCliekAzPXtXmqXOZ/ebhHawNsF4ANd5N9/RttemwiM=;
 b=m2TsAR14yHWi6Y/YAiu6FIXwtV/Fc3eUu6J6FGbHDBbxieVPjUEbrf6rD9U5DNmXvjH0tyFjNKsZRy7k4CABn1e9ajJZix/pU3kvWEm1L76OYT/vTR2qsKK9wNTpOnxcye1RBPuDG9prTy8UR8o+x9Y8DyyLTDGZNmd0AysQctDYRmJzrcArsKzalJ8BgZzEBjsIWJJek6iho8lItXPzifKpukoGt1ONhWoZFROdSc7f+QEpZELMelDug8ggpU0kw0+1crmIu0TSqaAu6HdohVB1ElLH3gAJ+06Knj1L72+rTF4tfBhOzLg5LVf5NJi6yGtX5pQOOJwoOPWZyxcdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCliekAzPXtXmqXOZ/ebhHawNsF4ANd5N9/RttemwiM=;
 b=A87DN8gkfppycJLJUmpzo/etVhQc0wH3MGlZLYmTI2hk2rSJmDWiCgXUkd9Ay/G4CrE9BT3tH/GqOQ3x2oVTwVbGOHBB3WRQYzsEDNTY24xIDnL1iP1d07WtUQJgBWab4CfBLX3Cv3qhXw3b+lEHjQpTnZ4bseVWO4IcM5/WGChav7q4XJQ5mcGzWAFDMkNd79/PW08sry+Z1Pmw+NmFHjtQDG2dsUe6cPmeeHPHS4N2PDaxSBkZiiN5Q/LLaa2ySkDj9qNg40QR4PcBbRjEoNH94Vkzao3GE3MSs+RnGOryhBI6eGShTSTJHYsAWMNvJ/8TkDD8f7xdidoufoFaFQ==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by BL4PR06MB9639.namprd06.prod.outlook.com (2603:10b6:208:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Tue, 29 Apr
 2025 18:28:48 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 18:28:48 +0000
Message-ID: <476f9bf7-2cd2-4c26-b55f-b42b9fe7eafc@cs.wisc.edu>
Date: Tue, 29 Apr 2025 13:28:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thread_pool_size logic out of sync with workqueue
To: Tejun Heo <tj@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5ee9b1d7-4772-4404-b972-93b01ed1e033@cs.wisc.edu>
 <aBEWmCB5Ofr5lCp7@slm.duckdns.org>
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
Autocrypt: addr=ljx@cs.wisc.edu; keydata=
 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
 1LHI6us+ZjzkMldzphVeBsBvT0hcR7u3cA==
In-Reply-To: <aBEWmCB5Ofr5lCp7@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:610:4e::21) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|BL4PR06MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e6c2e3-5d07-48e7-0ade-08dd874baed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|41320700013|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3g1dW9OOVdtVStJVlhkTVVWOFVTU2NBYVZxQnU4M0tJcCtRMmp1UFlramJL?=
 =?utf-8?B?eUZUVFlRTXMrNGR6SHdNMGtsQlJOWmlHNFZ0VjFlUjFucWxnQWd1ZzVpcU1a?=
 =?utf-8?B?SVVlYzgzYTVkdjVKV25GUWlBbUR2SVZiaWZjZ3prZG94azEwTlBBbXhWZ2RH?=
 =?utf-8?B?WnhMd29zbTdkOU1MaFNSbmYwR3dwSndhUkp5bUxYZzlqMStGYW04aWFSQW1Z?=
 =?utf-8?B?c3p4cG1KWTduS0JjM2EyQmtqU25KNnEzMTB3QnZmZmxTaVVkdVliK05YcjZ6?=
 =?utf-8?B?bzZya2NEbGhiclRXM0MrSmV4N2RTb0hHRDdSY2w0NGczK0M4OUUrdGV6ZXJU?=
 =?utf-8?B?WmZCV3lqb1NpeVo4allmdmZmdHVUTmd1SWdNSVozdU5aeHhVaC84OU9tRFpG?=
 =?utf-8?B?Q2M2b0lBVHk5bTBWUHREOWhSTmRJdDBpS2xXWm9jenl3Yy80QzNpakdTQmw4?=
 =?utf-8?B?TW1Vb3J0OVRCQ2VEUHpEOTdjQk1CTWx6dlBESFN2OTJ6Q01VSENsdFhwYzI3?=
 =?utf-8?B?YXVFSmtrUzVjbnhEYmQwaVphUzFPaFhiN0E0TzBFaWFJOTRwRlh1SVI0NmhU?=
 =?utf-8?B?Mi9USTVrNERPdXlHQlNCb3JCcWxOL3VuemdzYlp5RjVCZG5qRFBBWjdITmU3?=
 =?utf-8?B?ZEhSTE92Z1h6UG9idlVJR1p3ZlVaaVBXWlREOXdsK1hDT3FwbnZYOWI3cVJz?=
 =?utf-8?B?YmJ0K0Nrc2VocGJYMmcvMTZUZDdVOUVwc1dKMGgyTkFuM3U5ZER0YlpaSXo2?=
 =?utf-8?B?ZEx0YmlLNWgwTUNCUXU1a3ZiSVBoQkVIMnY1VmsrL3NYd1dDaTd1OSt6aVl2?=
 =?utf-8?B?T25BRG4wYjcyQ1dBanZyU0pjdFNhV01IV3BZTUh0UXBjQ0hENVhHUUhrZEw2?=
 =?utf-8?B?MmpoS05EQWJ3UkdyOUlKd3lqaHFBWFBReWUwVGwrbXY0WEFzb2VDVmxRUzFN?=
 =?utf-8?B?MFZ2c0VnUFBEeE9OSENrU245eTlOVlhhT0JGeTlmQ3RKVEZRNUxUcFVVTGhh?=
 =?utf-8?B?QmRzSWN0SzVjU0I0cmM3Wmh2MTNwUlZCMEt6eGRFdE9LY05Ybi9pV2E1N2ll?=
 =?utf-8?B?TlZqNDJrdlBqZSsvS2x5akdFbDNwb3dUbnIwenZOZG5aeEJveDIxQmltVkI0?=
 =?utf-8?B?NWlmZ3hGdER1YXlVMktiV0dLbTU5NUhNZFRGQWJ0Ti9SdmdldFdHenpsQzYz?=
 =?utf-8?B?cW05WTVJSlllUVFJU1BOTlhLdkIzL05KQVJISUZtUjZDVjZoUTA4Q0tFWXJN?=
 =?utf-8?B?TFAyUmk1VjBQR0pKYmNZZnlmTWRMVVNBKzdYQzFnY2hpVFBtQndqZUkwR1Nk?=
 =?utf-8?B?VnNDclNvNEFWd2FZMVVGZnJwTTI1WlB3WHpiSVVNN1crWWk4NUpaRVR6MUNQ?=
 =?utf-8?B?bmV4TFE3RkFhZVdMT2JtaW01TGphMy9sOFp2TEZ2d2R0M1lLdlRKZTdtSVBJ?=
 =?utf-8?B?ckR0MWp3WkJvZzUzc0gyQmJsWkdvc1V0NnRKOHJiV1g1TlFPSC9BTGFOMGd0?=
 =?utf-8?B?RGx6M21WaWZlRDloOVl5bWF2eTRmZWlYcm1HTlVURGtVd3k3ait1QjhYODNw?=
 =?utf-8?B?bXUwdCtFaTdoN05Qc3h5R3I3UVYzb3IvcWVKOXZLdkppQ1hIRVlhdWhWVkFK?=
 =?utf-8?B?RVRlQlRjY2NGcTVvT0xrZmJuUXpjWXk3NWhlZVB3YUlNblRndHg4OEFrOGdF?=
 =?utf-8?B?SjlKUklDbXlqZm9Ma2NMVEVVMTlJQVgxY2dPMURHanI4L0EvSi8wMjBJNkJB?=
 =?utf-8?B?THZKNkg0QWRoRjBpWDVIYUR6ZjQ4RElVa3d1cmJyYUFvVTk0d0NYS0lxTUVj?=
 =?utf-8?B?K0lTT1loT3BYODB6RHk4c0FkTmpZa0pwcERTUTVHZFliV1ZkY05wMFBwcXRQ?=
 =?utf-8?B?K3I1cDkyQzdTY2FCYnd6MUl5N0Vkb0I4a0VDTDZ6R09McGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(41320700013)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1hjUU5NSjUxQmtJY1kzWWwrS2hWZUxoV3g0Y2xHU1JsZExRalFaQ1hxeUFw?=
 =?utf-8?B?dkRsS2VPcHhiZXRPaFU2SVJDY1pGc1RWRWFPNjdpeis1RThmRFJ3UHFROXhm?=
 =?utf-8?B?NXhFc1JqemNxS1ZiMUJOY0U4RmNUU3hEcWZJOVAzNnB3VlJpNjZHeis0QUVn?=
 =?utf-8?B?a3JIZU5HeTZmNnF2SkRVS1V1N1RQS3MyNmlsVlpsWHdZc2xqNnY3QVRBRjFB?=
 =?utf-8?B?dkIzT3lZNlgzTkhrSjNTQ3NJditseWVicFI1K2l4eDFIZ1k4RDBYU3R2V1Ur?=
 =?utf-8?B?TFVITk8rYjByUGgwZ3V6TjJFSzlkYkJnVWVXeUJGbEVtMVV5U0NuV2VIZFFy?=
 =?utf-8?B?UEgrbnFZWWRGc0ZYVFpOMC93ak5IWFF0T0RWYmFRZUdGNGpNOVloaDM4R2tn?=
 =?utf-8?B?QmJ3V0c3MWxxaWRLYjdXTTAyaS9FZ0NQbXJlZkFDMG1iK2ZkTEVXM3Qyb1Zl?=
 =?utf-8?B?WENtYkMrRmV5ZUFDWE96TkNEclFIdzRtSmdqU3NRcTZCemV0a2xDcVRZY1Rp?=
 =?utf-8?B?endHOTBNVFJSN0dna1RUdVdSN0JFVmU2TTlyNVBrZlpxQnlRbWk3dVB0cnZq?=
 =?utf-8?B?UzlwY3Q2OVl4RDJUNU51U2YrTlZJSGV4Zi9Xc2N6aFB2ajl1Mm54TnpHZmFN?=
 =?utf-8?B?SzdscS9tVEt6L3dJNTkyck54QW5weGlNTnlldmF4My82K2tIRkdKWHBoWnNv?=
 =?utf-8?B?a1hHUFRqYWNGbHo1RUx6clJKZ0Fjd2lUSC9nd2ovNllYR0tuL1gzY3pOYXlO?=
 =?utf-8?B?OTJTWWJua0VxQWV6RGpjSmUxazJtNXZDRCt1eXhPbTRINkgwYnp3QUJPLy9l?=
 =?utf-8?B?NHFrbTdlSklCRXRnUlhZWHVRWVRybWRRaGpCRGlXRHoxVi9SbVgzakhiZkFJ?=
 =?utf-8?B?clg4bEMxTjVzMW5ibUlXaW5oVkdNR0JPZU9SQXl5d2E0dnlLTVYwRkpJZDFM?=
 =?utf-8?B?UjRVMDFhZy93dElyK1U2VnBvTnUvd3A4aCtNZ2ZrSDJmNEw1VkZ4TVNWVVE4?=
 =?utf-8?B?Y244aE1leHMzZDFzZ0xEVVYvdG40TWZmL09MTE1PUEFYRmNScE82T3M5LzM0?=
 =?utf-8?B?Zk1ySG9IQVNJemZOQkxYdjJGalFhSTNSbW9TRTE1cWJvSkFQcnkxenRrVUtW?=
 =?utf-8?B?ZlVabHdXQ2NCeGNOVWd4dUdsMXJvVmZUeGtnejlHUllvZ1BIWGtUcEt6U3lH?=
 =?utf-8?B?a09RQ0FCMnhYaGxUU0NQNDduSUIzZlNGYjFtUkZJWE8vTEE0U29HMGtCYXpm?=
 =?utf-8?B?SEJTK2lNUlYvRVA1TWNpdUVZNGxNcWdyQUhDanY4VzROaTdVRld3TDdvN3lB?=
 =?utf-8?B?bXBnOVgyZmtVcm1kWWgrRVJ5cGFRM2MzVE5icTBxUGl2UEVUU1UwS0RaQ1pE?=
 =?utf-8?B?cjBKRitKZHl5YmhmZTRBQjlDZ08yaVpLVnhpME0veFZLOTN4UVhlY0lxK3cw?=
 =?utf-8?B?VEZVclRwK1JDOG5qaFJ4MEJkeTdYUWhJSnlMYWs4ajh2TE13VXVuNjc2SjYy?=
 =?utf-8?B?dE1MYm1tQWNtZDhYZnZEd2FTa2d5dCt3YUsyS2RGWEwybVJYaVB3QU56K0to?=
 =?utf-8?B?bUw2MEFOcmY0WE81L1RxMXJVT3R2elNPQldvOXcwMUh4Y000MW43YnBIYlFB?=
 =?utf-8?B?TitPZnVtbXlidG0xYU9zRGlWejR2ekxnZzJUZC9xOUI3YXdHN0FnUURQa28r?=
 =?utf-8?B?dzgvYmx4UUhlUmVqdFVQNGUrWEYydUhhcHNSdklMcWdDYUtvdHY3Z3FsVGlR?=
 =?utf-8?B?WDdZWTQwZ0d2MmJCbXU2czRkS0lONmxHdjZRODByTWVlQ0tNQjNMbzh3Z3NU?=
 =?utf-8?B?WWtYL0MzUFRvYnhtU1ovdmkxVmV5ejBsRTh1cXcyelFFODMrZFBCamsybFQ3?=
 =?utf-8?B?blpwdWlhMEw5ZnZ2QmZoVC8vRmUvWUd5RUUrSFRyV0hOVG56Z0oxT3Byemht?=
 =?utf-8?B?WHdneVpqcjVZZzNZRDg2dU5uWE0zZHYzaFI3OWZQYnN6RktHbEFsRmdYbjdl?=
 =?utf-8?B?YkIwK2V4bDFJOGUxaWMxQ2pMKzhZR3JvOUVtYXZwUU5TV0ZmdzQwWUo3T25R?=
 =?utf-8?B?NTdaMHFWdVFSaFFta3JNM2xuSlZ4dnZ5TVo2T0FpbXA0MXR4SXNkZENhOUtn?=
 =?utf-8?B?T0JULzRUbmJ1aGNXcnBxMlhSSmlseFVjN2lTOFk1RmpZNS9sOFJ4ZVhvOVQz?=
 =?utf-8?Q?VpIRWBBEhZqEsZnRsfIsu6LjFPBa8stM07wNcN7G4zZf?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e6c2e3-5d07-48e7-0ade-08dd874baed0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 18:28:48.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AydxR9gH78rQAjbsemDm0BSJk9vTljkYUBo02oCEiSJ7veysidupYFx4v9D+BYsOXfD5B8Zwjn3prhwO/IEAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR06MB9639
X-Proofpoint-GUID: _X-ZkDN165xvQDhyR6q9C8ZgjzRsGdXS
X-Authority-Analysis: v=2.4 cv=LKBmQIW9 c=1 sm=1 tr=0 ts=68111a62 cx=c_pps a=uv9tqaYN/MHSKh89N0CxNA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=Lkyf4io54GJCi9YIokEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _X-ZkDN165xvQDhyR6q9C8ZgjzRsGdXS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEzNiBTYWx0ZWRfX0auA8e6TSsbu uRPk5X2JYaAKmMOC7YzYwzNbJrAQaCnit5C+GuakKZDzbZRnnamuStUE7kZN+xzRytkNzSdKo6I Cuy5w7RoIkmsiVWTITiMDWsqhZFadGdi/www/c+ne5HCOlgOx+DZAhrebI+3Zc5/5YQlox15RYT
 kfiYY0CV3PWRMUKxlJVtfmRywvgQclg6uLOpzolGvrz5SpnC2pYKc/c6RmhpPqeOws1b7rrOnO0 imsR/a84p1n3EfHuANbKhFFrb/Ht38tYrDchris2dDsm0DsVn/xWQws5lj/4JOqra+jMickTaGW /kJywkKiT/yIaWDv5fOUQPuATmHMChJQXgjQVOOc05NIzeRU+vINwmadWhIPeWjqb3rDwZ/qMwS
 A/UaH73ufkFQqn6dGbyGjgMroW7F7NBxjV0aM95B3TLvgO0PmSjasgWVoi6GS76gMP296q9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290136



On 4/29/25 1:12 PM, Tejun Heo wrote:
> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for
> unbound workqueues") turned max_active system-wide. The count is now split
> across nodes proportional to the number of cpus each node has. This is still
> a different behavior from before where max_active was applied per node, but
> no behavior change on single node machines and the new behavior is easier to
> work with.

Thanks! I missed that. workqueue.rst doesn't reflect the change though.

-- 
Junxuan


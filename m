Return-Path: <linux-btrfs+bounces-10908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F6A09853
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 18:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6304E3A5D38
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFD72139C8;
	Fri, 10 Jan 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cg49Wd1C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tl55p9Hn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A38567D;
	Fri, 10 Jan 2025 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529686; cv=fail; b=JXZKOxYb008gww1N1h7RLVyxUZgZ3D/G+YoHKy+cUzwMmkodqDyf5w3VyWVXK+yxAn2SVa9Qk+CgNG+okE3CHTjaQsd68H3HrIuk9B755aSfhDiaaYThPobYd5Wt2Gg839AROrSpQsIBGhBhvenQlS4ceoPL73essG0QZOzvJqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529686; c=relaxed/simple;
	bh=kizLl7SI1stnoLijsSGaIkfV85powaYEkDJ2sIM45Ns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYEBNVcze5Ejwi43QYwgKYmwKaqEkD2dIeWwxSTItNAmpvNFxUErd18yfWnN+XmwiKBjcypLW3tvMjm18U16YWs7lkSYb5hcn0Z8s4WPRbz0O3S55aFb5C3LP4lPdsCFeW8uZclICK/VykNUYLl/YI7dMIeqKJnf0XLDraVGwFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cg49Wd1C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tl55p9Hn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AENWqP029355;
	Fri, 10 Jan 2025 17:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nFutAsScCv9rQm0hHwsdFRFBM0UDgVGmKlkQerDjpQM=; b=
	cg49Wd1CVmdP3Porth4g+Uzjrd99Yr6DnX8rIabWfxN6aFavvKHHtNlBKc/x3kg+
	JgiPMaGIrkxTU8oXuThA4emT6zVG7ikrfCRy0PY0s4bjjy46BA4zMm0EzeEqM1E/
	/PINH4tHd3PO6gHTqONIq1mk6dSsCcaZ7IFqetmu2jxUuAc0IavV+3CinkhBchif
	lxglDBwFqMxFa0b6z8lhTI4GmoQHvykAXw2hGbLkGhoNuPFa1WtQNSb2+hrHHO7U
	vm+9tJseKlQWmVx+yp7MvUFdp2DLZZ+0+OyiEj4UHwuA269mLaw6mbuK39yaW6jp
	xJ2zYz3M0PPLk8fywNSMug==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk0bq4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 17:21:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50AGtHPJ005743;
	Fri, 10 Jan 2025 17:21:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuecpdkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 17:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjIrtngFTBnCDU3CHjh2UAVc6ggK8ccfw01/5qS3p8hBwTCOZxl/zd3Rs0BKcRnW3hkZqiak3iidhYJlg2U0uKcyNX+SuRN9G3Qvjz1J5bFIx7uS3eW/woyX7xFwESg/1wLErXS/+nty1JyyGPQbgUACyHLAyBFNq4X8nDSnk4gkDsRBrhOSJcW2ZnMS3haTbJL9ERXzbm9gLB14piGpFVMtJmShb43G/a70rlhHItAXcEarqTyiYLJTod0C9xygcvz/U9LDmdnb75wNmyn1XAx2wtDHhqluTFcLXkxY1hHDwaIAq9ORM4WqwdSb7hSbbn+4mMGuIhzzd017SbiroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFutAsScCv9rQm0hHwsdFRFBM0UDgVGmKlkQerDjpQM=;
 b=vofUVOZRLJWkBWkrT8T3fH6HWc3Hy2YqLP+NKxHUi2xvdeWqfD+eHl0hIqPqze7EzuygNJraVxkt1h2/F+W1lI8avxBsf15LKq4Z8QHbp+LywSOn65wP/5A2BX+AaNVMExtYoPHawTiyYH+NJ4bl/Y6XrVfSmRfvODmAwqhZg6tVJ7riLF5ospJgtbX9DQCMVZWGL570bgTdvlCkbxxAn3V0VkuvyRa7dBJD+NXSaY6QYOykySCCOSbPXlD6QJRZGD+2MrAanirQ3Go9mgtc9hnVWcwUCTLndSx0NIcYtt02ZLTbFGIallYzVzUUIdFgJGCPYkMSNMrwJzMQvWtXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFutAsScCv9rQm0hHwsdFRFBM0UDgVGmKlkQerDjpQM=;
 b=Tl55p9HnDwOJefOBe4qcjytOk7S4J9NgPbOgyf4fAiI6BoOWegbGu9eP+qm2H1Lh/q5KgQvImScntrTv5giPy2ub+9Wsnggs0UeEujKv0CyAVnMBaf6NdY7PBVHg23ObVtd+i/AbLHKjSxSISPojo516xDNE2tdCIORNvBYx+lU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6993.namprd10.prod.outlook.com (2603:10b6:8:153::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 17:21:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 17:21:15 +0000
Message-ID: <5211cb15-ffe9-49ff-bea1-30750c4bc2c9@oracle.com>
Date: Fri, 10 Jan 2025 22:51:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] btrfs: add test for encoded reads
To: Mark Harmstone <maharmstone@meta.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "zlang@kernel.org" <zlang@kernel.org>
Cc: "neelx@suse.com" <neelx@suse.com>,
        "Johannes.Thumschirn@wdc.com" <Johannes.Thumschirn@wdc.com>
References: <20250106140142.3140103-1-maharmstone@fb.com>
 <20250106140142.3140103-2-maharmstone@fb.com>
 <b085669a-3684-4031-9e0d-3275289e86b6@oracle.com>
 <92429a09-4ee9-4561-8c0b-4e8abdc78f57@meta.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <92429a09-4ee9-4561-8c0b-4e8abdc78f57@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 9538bced-499b-41c0-1a9c-08dd319b301d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2JHTW93T1JiY3RKZm1hbHAvZUNuMmNIRktZcW1VS3UwbW9HbUlhb1dNaGpR?=
 =?utf-8?B?Q0dlODh6cWRncHNKb1JPL2haeHc0eUVaaGtsL3dmS3ZCa1RUQ1VubTVXczB6?=
 =?utf-8?B?UUpMRUs2eTMxQ09iVlJMZFZDLzZYbmlJeEgwSXFJMWJueDN5aVd0MFdlSmg2?=
 =?utf-8?B?ZWhOeXhidVozaUhTSjNLdE52NldDYmxQWTFMUjBtY3RZdjJkcnZhOEVMSlNL?=
 =?utf-8?B?N3Q5SWZZNlhwZXJCS0U4cGRZOFN2VHhRVUE1bDl2MTJEZnZyaG5oVW5tWVNJ?=
 =?utf-8?B?Y1Bpc1cvTUdlakJKbzlaRXNTa3pjRkZuZTZoT1RtbUhhUGhEVE1XaGxBMzh3?=
 =?utf-8?B?MGc0eUNGNit4V1VObFlPbkgwWC9paXRWV2JwdWxCUU5oSS96bmhuN1VYY2pq?=
 =?utf-8?B?YVJFMWJveGFxWjJMRlFUWVhpM0hBb05KekFkbXdWMjRyb05CV2trVjdsdEVr?=
 =?utf-8?B?Q2I2S0I4azhRWnFEZWcwL1BjdVhGQnc5RWM4cW9OTTlLVVdoaldISUw1YmlD?=
 =?utf-8?B?ait5dmh2SWV1V25WeXNIYnlncHNvMEVUc0tZZGlZV1BzTWFzRzk3a0VQdTFp?=
 =?utf-8?B?NTVXSGdvUXFaVnczenhSZXJESDBldjdJaUVZQlRmRjM1MVFOdlJTTVBmV052?=
 =?utf-8?B?RFBpcC9lUmhvaDNmRkZTNWt3bklseFZmZWNsSGNQUWpibTRjQlhZeFpZYnBi?=
 =?utf-8?B?bjNTV1hrdEpPWkhlZEV5eFVYdmNqWWwxcWltRUFHVy9xdHVNMmtCVUZ3OG44?=
 =?utf-8?B?a3dIejJIeDVpN3hyMThrUXcvcCtGbVZ2N082ZTlHbFNuTWRGd2VpUGgwVnpT?=
 =?utf-8?B?cUNNNElrSVNNNFNrZGFBdElzVFVTbFpTdFhkZlJ5QmMrQ2VzYmhEQy9HdVhN?=
 =?utf-8?B?Nk5INHVjcmpaZnU2WXlqUlBQRUkwZlEwVXE3ems1TjdIVklSTStDMmRmVTJ4?=
 =?utf-8?B?bHhIUHdMU2NKRkNQUGFjSEZkNWpaZ1RUZDlkUUNpRzVzRzZrQ3BmUklWTm91?=
 =?utf-8?B?TEp3YWREa2hjRTNGaVhMRkUyN0EwZ3Z6UkUxQmlDWlpFeDBXaDY1S0RGeG9X?=
 =?utf-8?B?b1dQVmVSU2JQaVNwYjBDS3hhUDZ5RGE3ZXhkb2VnRHhpVlY1Wjg0czJSSHI3?=
 =?utf-8?B?UFF3M0VOWGhLL0tjUFBveG8wNkRTL09iWVRGWWFqWlNZdHY5U25lNmEwWm9u?=
 =?utf-8?B?WFVNYVk3SVdLMzZrMzQ2MDgwTTJXWDA1aDhJNWRIVWVpUWtiZHlXbWQrcEFJ?=
 =?utf-8?B?anUzblRKRVBjclRCSnp3UWdjL3NKcEU4cmRkYVhJMUtlanUzb1ZGbVg4NXhz?=
 =?utf-8?B?SUhocVB0eVIyUmZpcDJTd2VNTG1jZWhtTnRpdjRueG5FbVB2YXRYQnhWZmFG?=
 =?utf-8?B?aWhyRnZzbmdSclZPVGdHQnladVdFaDVYYktuTXdxVzJTeDZvdDE4QmZXVlYx?=
 =?utf-8?B?MGc2ZmQyZHozeXI0RmNWTlh5aWEwRFQzYzB6VnptQXdWOEZhdTRLbHlOVGE0?=
 =?utf-8?B?VmhBOXY2elBvYkJWZVpBV0ZlQm1Vb2ZOT094MjVhVGt5VEZUMUZKdFE3TXFn?=
 =?utf-8?B?UTlTK1dsU2NCRENpTUtHMHVSN21oUm00cTBwUUhjV1g5bFpnWllDdkt2V2NQ?=
 =?utf-8?B?R2E2d3BHU3NuVDN2ek1XMnFSVm95d2NNVzJHQlJ0WXhjMHhCczJhOFAzdlNn?=
 =?utf-8?B?TW8rcEFidmlnODYvMVltY25wM2EvQ2cyTnFTR0h6aW94RTc0ZnIwSTdMZnhq?=
 =?utf-8?B?MnYwaXNTZmUxMktLdHQxR2lNR1RCRC9rM3ZMTUx5WHZKKzdNQlgrdVQ3Tm5r?=
 =?utf-8?B?ZHpYOHR2NVF5eTVIZG83dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzkvTE96WUFRTVE1NFR3elJ5MXZQeElIUUZJbjNsR2NBdkYwL0V0MjhiM3hX?=
 =?utf-8?B?NVRUOFF1VjVYSCtXZmVYS0J5R2NiNHk2WnI0SkVBUmJqQzgwbk9uUmkvNHhE?=
 =?utf-8?B?S1Z4OXFtc3lrVzdFT3RvejFLM21OMXZubUpFL2Q0VEEwSlRJL0wzSFRWMTVs?=
 =?utf-8?B?dFMwRG8wUllnbWxWcE1XL3RkN3J3bDFTbjRLTmJuN3BuQVdTb2hid2FMeU5V?=
 =?utf-8?B?dUY4SXJqbWZXS1B2TFNteVBGMUhpMzNkTkdMTVZtTVNTVGJlK1N0TlhkNlZ3?=
 =?utf-8?B?UXYrT3hkd25sSTR0bnI0N3FIRklHNlZvakhiMFFFRk5aU1pvUElOMjZZVWtv?=
 =?utf-8?B?cFBBYk5pdDlPdGREdUI2SUNHVHVid2RWWjVRSmgrK2QrQ295ek9TbjVKZVVz?=
 =?utf-8?B?SEVnSUZXZkN5dmNIWWdHTzhOdHE3YkFkNzRUdHp5NWRMM0tiMzJ3U3hhSTlB?=
 =?utf-8?B?K0htZE12L21JZWlvdGdWTVlKTUF1M0syVWZmQjdyemNMZWhadEVyQm1DMEU3?=
 =?utf-8?B?MVJTTHl4ckdaRkhFQk8zYzlXbU1uZWhCR2Ywa08yUFExMEI1QXVoMFM5K2N5?=
 =?utf-8?B?Z0NjZWhqN1NRL0l5ekk5MzRvV0plM2hQa0dnakhtdUtrTlVxZFk5UEEzbkRO?=
 =?utf-8?B?OXR1bnRsSTUveEtoTzBtZ3RlRjBuWWpmTWVvT3dwRkN5WFhpRlY3RFdkNVJn?=
 =?utf-8?B?NFVXNWtLbUNVZFkvd25yS0NNd3ZKRGZJSjUwOVZ1anUrS2xHRmpDLzU0eHNk?=
 =?utf-8?B?am1PbXpJZU03Wi9MbjBIdzVvN2NRKzZ0Z3hnaVIwRk82UDhvUVh6cEdHdkY5?=
 =?utf-8?B?Q1I0SEFlQTYyVU5YbGYyNHRncmFXTXZwTlY3cjRXRGlHNldZNUdXQ05WbHgx?=
 =?utf-8?B?bW5qaGtmd1Zic3hIQkYxRFhUUGVFMXdjS2VmM1dSRVkrUytZSFlYa3AvUHhm?=
 =?utf-8?B?U3llSTRZL3B6UGZTS092TGZSZEM2Wld3bDJ0ZGhaWmN5bXJXMFdwNVFPMVVa?=
 =?utf-8?B?ODBGdStYWklsNENheVh4Z3FNT1FiR1pvNklZWUlTY25CdTdwMGEyTTIyMUV2?=
 =?utf-8?B?T1MzZzYvc0Q4RXkxYWVvME95TVJTRVVLWFZJam1nNlBlK1dwc09Hc2FkemU0?=
 =?utf-8?B?bVo0S0tNM1JkdFE0YnQ1ZEFDUzZudElWallIZE9UdnpzR1g3amlHb1BjeWF5?=
 =?utf-8?B?UVFTRWpoZ2ZSeU1UaW1ncUNKaEVaR0tpRWl0WDJHVDNNbkRCQjVRRFlhSThP?=
 =?utf-8?B?ODJpWmdobW13YzZhdU1zUXRGMlR4WnFtOUR5UStWWktZMm9QeVAwR2ZUems4?=
 =?utf-8?B?ckFJTXVLUjRENmNJOXp0U29rZ1RKQksrQkNKN1g0RjJDa09LMVQ4ZDFHbkF1?=
 =?utf-8?B?MmVDRnFqU005VlNQamVrNTl2NzBaS3hDV014WGRXNHd0SDNWYUlJT3JXTStE?=
 =?utf-8?B?NDdSd2dOc3JOaCtyUVI1NXhoQUt2VWxxNU93ZVpXMkxjTEFBMjRXZHk3WUNl?=
 =?utf-8?B?TVVIYW5IY2tIUXJ2MU1FMUhiY3VvUHVtMTBKR3NXMHNKeHpmN2w2M2dCdEEr?=
 =?utf-8?B?b2s2OHI3c2J2OEI5eUYxTksxM00vMlYrSzA0dXR3T1VBcjVtRTJnZFc3U2RG?=
 =?utf-8?B?bU1aRE5OSHRPbWhNdnY2RnpzU24yQjQ0NjVnSWg2TU4rQ1QrVXNnZWwvQ2xv?=
 =?utf-8?B?OW9wQU5hZkF3ZG9OS0RTb2Y4ZUxQMUJQUzVIU05vUmN6QndtTDUrQkw4TEhI?=
 =?utf-8?B?QmE0MklLdG1OOU9lL2s5SkZvOHd1Y3JjazZxaGJCYWRXdEowdVJYdk1BQ3Rl?=
 =?utf-8?B?UDZseXZoZ2VLbmVCY0p3aVZTeTM1aXZSWVFsNHVaMVRpVGhiQUJtRFVmb0Zo?=
 =?utf-8?B?MmNUT1MyT1ZlTU9rbE9VYk1CNzVJeGJQZFFnQ1piYzQ2bFN1MlRDRi9TSzhS?=
 =?utf-8?B?eXlTejN2aGFQYWd0YzVDY1Q1ZnlZdm9FdGhDSjY3NmFFa05BaVRoU3V5ck5N?=
 =?utf-8?B?bENMWEZPTVlaa1JtUEc3TDIycWo5SzkxeFNibjJmUUp4TElVclpXTmtZVWJq?=
 =?utf-8?B?cmNueUg3ZjZTMnAwNFRDTWNDSEYvaW55K2N3UWQxYmZydThaZnl5NllMTUt3?=
 =?utf-8?B?VFRvTlRiQmttSmVudkllU3NXWitaSUQ3Vmw3VHIrSzM4RDVuQ2hUMlRpKzVF?=
 =?utf-8?Q?ilhDTziQ0v2QhXRy8OkC7d6hh/i2FYjDAR+v/P1IscWB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uGPHaah8nfmbmweJkc/OJWytFcYEEG5ZhBsYzSObBp9Ze5H+HUKGhyL8SwvnyaAO+fhI0GuR+mwtzaL04KZ8CcJgIpxRHA35mQwZjBUu+A8ffUFqQMwdKXxPcEBcE7OBDm/PXUWeP2j6feZ9+2pRT5Iy/gfFgVFAdqGkSxXrUR84gvv8z19lN/XZd8dLaBMniE5/x29Z92JGX+LNoq9pSBmOAVi4a0c6FjdywraH2VN04usxzBfOov4Re0I99J60wv2TVjviNfFMj0fz38f5RN/uL+NR+uIND6mXScPn424onjbDerb/j+W0emY6peqQh9C4coSGZYYMEUIdHKAqUwqFw3cubpfZZmUZBJRwR9uVnNt0IPhB2ROpi/8m3Pyja5aw2tZ72VYshDKtPA3knSKmQUmK62QPNvpbrRtHJREBVhKrHTGvRG3O03KwA77OMI9x6T5G2kYOJ9XuCjBJSxngeH72MZ2x/wO3H8iFBMsp6hrPss0/L4NxCROENRJhsMKG5H93oxAuKQqMSZSWzENxy0sUuD/Nxv9nL18+McKPO7duKcIm1wKuMRcjr3dBKV6D8oAz5mbV8756RCkIKpmqULnhLqw6hbT+iWKrxcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9538bced-499b-41c0-1a9c-08dd319b301d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:21:15.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLJR2FGB3rx+jCAI1TQJZyBzab/9gewxoFXx7g2g1mORExLA1y/fi2Zy4Zfn1kOHyZvmyXVdGi6zLDyxhCLwbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_08,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100135
X-Proofpoint-ORIG-GUID: GHvIVTng-6ZF0ZSvfDsUDsfyjlyOT_8s
X-Proofpoint-GUID: GHvIVTng-6ZF0ZSvfDsUDsfyjlyOT_8s



On 10/1/25 22:09, Mark Harmstone wrote:
> On 8/1/25 06:33, Anand Jain wrote:
>>>
>> On 6/1/25 19:31, Mark Harmstone wrote:
>>> Add btrfs/333 and its helper programs btrfs_encoded_read and
>>> btrfs_encoded_write, in order to test encoded reads.
>>>
>>> We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
>>> compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
>>> that it matches what we've written. If the new io_uring interface for
>>> encoded reads is supported, we also check that that matches the ioctl.
>>>
>>> Note that what we write isn't valid compressed data, so any non-encoded
>>> reads on these files will fail.
>>>
>>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>>> ---
>>
>>
>> Looks good. Add to the group io_uring and ioctl.
>>
>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>
>> Thx.
> 
> Thanks Anand.
> 
> Zorro, can you please add io_uring and ioctl to the _begin_fstest line?
> Or do you want me to resubmit?
> 

It has already been added to the local testing fstests repo, and the PR 
has been submitted.

https://github.com/asj/fstests.git staged-20250109

Thx.

> Thanks
> 
> Mark



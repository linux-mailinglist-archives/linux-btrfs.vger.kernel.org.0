Return-Path: <linux-btrfs+bounces-11931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C139A4918A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 07:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEC13B7BF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 06:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AC61C3C1D;
	Fri, 28 Feb 2025 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W4MosywZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kxOjfRse"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382123DE;
	Fri, 28 Feb 2025 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740723926; cv=fail; b=pPqDiai4D+1Ob/b+X4IkwyTcEnyQzpNLdss8vWfRkgMRl+phSnzFvhPZRz6+/AGo2IiWUcR6XvnhCxeEtRVEKDycpy4quGOxhsHB1pd4svwPmjTf6hyDkkK53BL2lyUrD/nwh8S5AuirXozPfgyqZCsxvDksA2qyrwomV7QrBnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740723926; c=relaxed/simple;
	bh=2zLYLqTfKDPaVTTmDSk8aoICywa+p3FseFwYDB1n274=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jx7sQeMrIIRw604SotNWJXIUbN7P5tfShGhs/+bVhZsnLIY2frB8GmUPjO2y8hB2DQMxqD513ToHhoCArKvGvMT3qLOZvfXB35/kOfH6eX37eQVMhOfbRvNoMN2trPuUQnQX7x9QMAtkh+uhLWlmWd4pgEmuR1omfZxqvPj8emg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W4MosywZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kxOjfRse; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1C1N8024182;
	Fri, 28 Feb 2025 06:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wUMO0NDbLm8OCf8fSismgWKmWsBJpCR/u6zvAjdi3DY=; b=
	W4MosywZKVbY7Du5xSSSO26R68JCUEvyrtzfMxR01Cn61RMzcksquZCRvzZpXJst
	gCCYaguFc19llARat0dZrda4ONfVvibqEkfpDaf183dluftg7G21TopsCisiLmUC
	LHuKP46eA3z5YYBwYJt4cH8Z/IyDIIocK0MFtrk5TH0FI6phYeAZ5P8DMY0vb0Mq
	oj2O7S493zomRhWlkdOQDk21uglRruqZUtv0YeEx7YgjziqvUxkcva+EZmI5losn
	s4eQ1fhaWpdp5r/J9rRUqyAfC+MvkztZqMIwyOidseUZEymbOezEp3RJJ2wvNBcF
	jkee6MkEtB02pEgK0hdeqw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf4vpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 06:25:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S4xnPV002792;
	Fri, 28 Feb 2025 06:25:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dere1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 06:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqAX4dqMWVM0SVziwEkNh3FECsm77RNDVWEanm33RxzMAJSpiKWLXOLYGXA5w7BxU9K5m5+7cjNBK8e7bv7nENwiVzQBLlD/j+JmRsoq0tA+/ZMPG8glejsU1a0/JoI7skv0oklQ4Ca1287mLCUDjTgPZ1UMDRF88WrSyNIuoAZLB1ttf6Us/8E6BplvNZDERRZewu7HQK/lK7jS0FS5B/fHjtULOGPcSkmQXJAu4LqDhKbVihK6/1ETtSIqbEELonoGsMYtzlEQQ8AxRtGgfGlzOeY3WQ5XqBUG86/CNWXzmJBXE8OEGXOct+Tvbmmm/1DKCUTx9ZJDw/8CtpQ6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUMO0NDbLm8OCf8fSismgWKmWsBJpCR/u6zvAjdi3DY=;
 b=bYPNi73EfufzJQsx9LhOcbIQpWlFl0nihqrZk40+xY2YcgIwYhxQ0yATlErzJ7vgvW++G8+G/9gwDsMNJsPGR56ecTkgvXaVbfiRnBBEfN6OwvEy0s7Viar6tTf04Fg8qlJOqqkM3iqXibLEyReX670ReKSDoMvOPHMp9dGfrz3vCAy6wAzqHqcP9nI6RKJH/WqRNnWGTG60+aRs19JW5Dp8AiwD2b1aSxG3MHntaTl5vL8sCjHlBLEdzGm05eTe5x1bP8AVy5IdHT+I1llmV2XXhpMX+Xr48UOxQAYZHhpP4sBIpNnJC54JkcW/iPnWA+6X7jHrhYoytsfSEWx5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUMO0NDbLm8OCf8fSismgWKmWsBJpCR/u6zvAjdi3DY=;
 b=kxOjfRseQeI3aI6svSQf4kYd8NngOfWE4khiSy0vcRw3wqZlNPXhYd/bBrTMHlNIy8kiHSnVzq21aMB32r15f4BwCA2oPuGQB4ZiPCnClQ+NJVjkqvlWR0U7/LvHxhaBPjxRlFHDs5lhozRkybXrQKMH9UrmJ3q6OOQLC38pAlY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB8012.namprd10.prod.outlook.com (2603:10b6:408:28a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 06:25:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 06:25:08 +0000
Message-ID: <2fbb2389-c3fa-4087-9504-e5a532c63ddd@oracle.com>
Date: Fri, 28 Feb 2025 14:25:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/254: fix test failure due to already unmounted
 scratch device
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>, fdmanana@kernel.org
References: <b470cdee538aab91177f8295fb8886ae79f680db.1740662683.git.fdmanana@suse.com>
 <20250228052045.usxjsezp5jgadlxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250228052045.usxjsezp5jgadlxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9c2af4-a214-4e68-6aba-08dd57c0a59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajZVdWlCMWlQamRSZlRoZS9VdUdzNVpRcFJsYm5FRE1rb2NmdURuVE5BWncr?=
 =?utf-8?B?cXNDdTduM0FwKzRXZGtGUXZkajdIWWcyZlQrenBIMkFmdkZRS1FnMC9HS2pO?=
 =?utf-8?B?RGVEVFdybHJvanpzdlBvMEg2d3U4MHZuVHNkVkxDbDBneGZsK01xY1JBSG9R?=
 =?utf-8?B?SXBDUndpSjI0RDl4dDBSWGVOT1djOVNMRzhuY3M5Yk9LNDFzNUJCNFJLNlg2?=
 =?utf-8?B?VW5PUlpTenpDc05BWjU0cTdiSUkvclU5Yjk3aHBYLzBNQW9qaVlPY0FJSFg4?=
 =?utf-8?B?dWNkUk43SkFtUTdGelVJWWh3RWZDYzFzUVE2eHlMclY1V2IydEczUGVjaUNM?=
 =?utf-8?B?UEdPMDNIQnVqUlBvakRocFh5eTdGK3Q5YmdsbEljUC8vMkVaSGg3T3E0djJj?=
 =?utf-8?B?K3Q2eXlrQlJkclliSUNqNWFMNTFGMjRBbUFtN2FRUWIrL0tIU2dPWVZyT2tN?=
 =?utf-8?B?aFhodDNWb09FUkM2QjFrWU4rdXh6TnpnZTFIdmZMNUhGRzlMU1EzbFpkMW1G?=
 =?utf-8?B?V2dNUGdpZ3UvdWIwbUtkQ2k5ZTR6VHc1NG5mRjhoRjl1MUVoVENBcDhSQ3ZV?=
 =?utf-8?B?SEtzOGZZTmpGY0lrT3RRZVNhK0lUNEs2bWtuOG9CQW5adTR5RW4rQ3hUMEJS?=
 =?utf-8?B?TjRZV0lZNlBtNWhZU0w2MTlTbllUeFBwOG1aQi9LZ2VUTzhnUWUvN2hsSE5F?=
 =?utf-8?B?S204YnVPVkRrWlVyK3UvMXhRTFJBL0FzcUU3KzRPUEEyWU9qTjM3b1EzaGdX?=
 =?utf-8?B?QzQ0bHgxQ2VxaU9FWm5aRUs3dkR4cUgxVE9JZFdMNlRUenRTRWYvRmU3S1Uy?=
 =?utf-8?B?cVdwZnhyTmRxTWc1c3FhTU0yZVNWTFdkWkhkQnI4SVR0L21vYncrbjU0YzFr?=
 =?utf-8?B?ZytLRW5Vb1NqWVJOaXhkZ2lZTGZRaG5xdklLNUtkdXJsQ2Uzb0Z4cDJULzEx?=
 =?utf-8?B?UWxCZEZsNHo1UmY5UDRuTU9JaTlaM3E0MHFYNGNIb3lCeHVYTkpPTnNWSFJi?=
 =?utf-8?B?ZktLK0JMaHl2aHRLbWlhRXVrZEt2Q3FpVWxUbXI4d0Z6ajRuMnVQaUxmaGhw?=
 =?utf-8?B?TklCMkRuSUNPWTB6MjVHdWpTM0NNZmluQWR2TzdpOHNlcXFOcDJibVJ6THF6?=
 =?utf-8?B?ZmZZaEZENy9SVG5KU2NrVjZSbFZFd2FTTDVmbTE4RjkwWnlTcmV5MTVSaGUw?=
 =?utf-8?B?aFRjRG9KT1owSFRpOTVKallZQmlZQUZJN0VWaE5rMXhzczQ3c1h4aUM4UDJt?=
 =?utf-8?B?UkFqalRVY0xQNi9EZ1dWbTdleGRtWVk0UndRazE3ak5DWHBzT1J4dUVSRVU1?=
 =?utf-8?B?L29aSU1NV1VJd1h2TlF1RlcxM0ZwVTZxRVZFcExDZUtXN3FxalNaaGRaWVcy?=
 =?utf-8?B?N3dpQ1MzTVpnUmNMV2RPYWt4MUF3L21ndFFGeit3QXdGTkFVbEpCSTRrUk9Q?=
 =?utf-8?B?RkhWcm1iRE16UVNqb25GSE9MZzFNK0VMUzNEWTQ2emd1VkI1bHhXNktZWTJS?=
 =?utf-8?B?aVI3ZEg4WkxESmg4aTAwNXdVdmlBcWgrM29ocHFuT0NXaFgvSjZhVC8waXBw?=
 =?utf-8?B?SzVBaDlYaUsrUlBZNjREdk5EUDM2bytsajJ5ZHdDeFMyYS9ab2tadzRWRis0?=
 =?utf-8?B?L3d1Mlh0S0xtdUNUcXBwZ2tqK1dZRFJRZVllQzNVN0llS3c5ZDBlV3FLYXlh?=
 =?utf-8?B?cE9BY1Z0UlpVQ2RjQlhCNWlRV2xFc1Y0RTlKSzlhWnpmZkYrMEhUYjgxeG5v?=
 =?utf-8?B?L3B5UkdvK3VxRWJSUzR2eVlkckpOWGx3K3hQUk05VzVCSFNjUzFScXhJZ1FJ?=
 =?utf-8?B?ZU9TRnpiNEw2cnJzZGM2WWlaN0hHblppdE01clBLcDNxV0NCMWxjS1lFUGEw?=
 =?utf-8?Q?iDU/FYSXGCN13?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFRMQTIvZ0FRYkVIdnNkcGRVbjVCODlmT1BkR2lwZFZ5aGZjRU5hQ2U2V1ZU?=
 =?utf-8?B?UUlXZU5xMkg2K0xORExRa1ZTT2RtSzFDZERsZVA0S3FHQlpDU0tzS1c2UlVs?=
 =?utf-8?B?NFRJUDVVNCt2UURleUZOWFBkd050WlhOUjdseXhhNXhWT2hjUVp3Nm1PQ2lU?=
 =?utf-8?B?Y0VIRkZFcU5uNUhacWZzeUt1enlRYXFWcTFvR2JNNWQveWdVZWVmWGJBU0l3?=
 =?utf-8?B?QjY3OHNyalhuUU52R0lYNlVkSU1QVFQ3UG1QNkovNUpZbG9TcUVvMXQyZjlG?=
 =?utf-8?B?ZVVjbW5FS3NLNVh6RElTeXpHbHBDL2xRejhiK2hMREVwdTdmRUg0Njc5dFFQ?=
 =?utf-8?B?NzJjUC9sdi92QUR1Nm9Qd0VZU01LZldWYXVZallpeS9FajBCMWcvWmpJOFZQ?=
 =?utf-8?B?K09vNkJTc3dOWWUvQnlMQkJnZGNDZ1h2bHlMaTg4anVYNDVRbUkyOGtlTVRx?=
 =?utf-8?B?VXdCUnUxQUZuOVpNbmhBY3QvQzJZckp5dHlGSE1JVHpUTUFMakdRVjZCOFNs?=
 =?utf-8?B?d3BoYWFlYlZQNjM5UW1LZzFRWmRxcVV1NDlnMjkvSnJ4b041ZXlEbC8xbkZ5?=
 =?utf-8?B?YWFIVUhYSFhnK1RGNE5pblhCVjkrYmdaWmJramN3U2k1L0hWanVhdzNZdGNV?=
 =?utf-8?B?ZmxZekc1b1AxZVN4L1hNaEViZHR2dVB4RlRNbXVPNXltL2ZzZzVHS3hqdUVV?=
 =?utf-8?B?QXFCSHhBVVJtRFNPYzhwcnhSa2VvU2VPdzFkMHYxejlhWlNicDhkMTM5eWla?=
 =?utf-8?B?bWRxZkRVN2YveG1xVm5NakF6R2dNcjZXNCtoU0FUU0o0U1JmQ1l3cEFDTUpJ?=
 =?utf-8?B?NnF3eDFkcjhWUUFJemFXakk4bG9QWDU1VzVNZDBDamZtQ1JMZFlBbmlucXdp?=
 =?utf-8?B?VmxmczZtaFZwb0FBY1dmaURwckhISzNocVlqRFF2VzNySXFBc3MvWW5VOGU1?=
 =?utf-8?B?K2I3L1I3dWF4bTZ3eC9oUGhEaktkSEgzYlJwVzRxTlJOSXJUajVXRUFoSllo?=
 =?utf-8?B?SXp4SHUxUk8wRUN3VnlReTRqSFpEMnl1Q09WZzZGMVVROHRDNWdVekJ0QVg0?=
 =?utf-8?B?OXB4Q2UrRUlkMzVNT0tkNVFOUjRIRVB4djhMZ2RsTVRwRWpBcHlYQVFURm9F?=
 =?utf-8?B?K2psYWozUC9ZSWZROUxIZ3ZoSU1uUkJNbnVjRFo5YTlQRUpPN3dEU0llWXlM?=
 =?utf-8?B?c1hLQzFydThhWGRSakVaTHJTVDBqdlM2c0NlOWIzenovWlMwUzRiTTF4RzNS?=
 =?utf-8?B?b2cwUGsvWkpqK1FmYTFFaUxsZWpOM1pXL2Q3NlVnUW1oaExnNXFIdDlSKzFM?=
 =?utf-8?B?dFN2Tzh2aFh2TnlaNDFpTmttdkI2alRWd3VqY1QwNDJIRWMzWTR3bmg0NExU?=
 =?utf-8?B?dnc0Y3Z3RDVFL3FZMVY1QkwwdVR1YXFLQkc3bWcvK0s4TnpVMUxFcUxFNTBJ?=
 =?utf-8?B?c29CZ0N0bzF1ZElaZVYyN1k0b2dTckRCeEJvRlNQR0MwR0JKNHRNRmxXZTFN?=
 =?utf-8?B?dXdhdHJZTWVubytXay9BdWxnNU84akJ0SFk0THpGOXphNkxHTUdtcFM2d0gx?=
 =?utf-8?B?bFBOVWFGc3Y3dHpIcTl5SW1Ma0VhSkZCajEyeVZQNEJZMFpCNTRDZWUrTGpN?=
 =?utf-8?B?TVVOcFJaUWJsT0IzZWw5cFRTSm1OWHlCTGVHajViQ0lKR0poVU9zVXJ1ajlk?=
 =?utf-8?B?aHhmK0JWdzNlN2ZVbXdSYXhOMll2eFF4bWZ0SCtycHBsY2RUSzZLSTNwOHBZ?=
 =?utf-8?B?WlhTSVQrd2xsMXE4b1B5QjdZcjBmZDRwMDJ6dlBsRjFVUVNGTHBOaUE1aWd0?=
 =?utf-8?B?UkJGSzM0cE1memdJSmNiVnZOVWFYeXlpUHJLU21SWkRyZUhTUHVOcWRjVWg0?=
 =?utf-8?B?cHNWZVVHVjZvZnJaMkJTT2U3S0JMN2FpdFdvVFRUclNxZ0FuQm0yeFJHRmsw?=
 =?utf-8?B?QlpmTWhNaFA4KzNoaThvQkNOWDUvWlJWa3BtNmhvQVdSYkg2clJPdHd2WVZ1?=
 =?utf-8?B?UG9ocm1OZXFaVHdzeGUzcDN5eGl3THNXWUU0NCt2Z3o3ZDhPNTJOREV0MDFN?=
 =?utf-8?B?T0JQY2NuVTl0enZhUHdKcVU3eWc0cUlHOVBJVkwzZWNqdUM0NllZNjFKay91?=
 =?utf-8?Q?7LMQaEM3An3KnzBD5HI/L/Sqk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lXoA78JJR3chZ4rji1kQuh6yW2suO4OoFqcDTA4YrWGr8S4hUDMv2O39azIAS6Rlb+6+t73HBbOUUTh8HSv1E1Duhw9Hqcdpws2BWKRC8FO0A7L/EAmuHK2VRidpP8YGr0j5PnLbluMWkbLUoKbm/ffLzXSZo3rYSFenuqXU71YD0bOzd3L/l9APPWR8ZL/YH/PT7U/eOYENn2piCpmxzajn/Z0cP6T3j26+efA71jgATGHqChDwZL/vgdD4a14SrpxDYps7LeTUrAHk9S2b/7HPQnsvLa/aofqqi2cTV3tz5EkuEGFWbl2KWnmribd2mWoi/n7HoVnqVpYgigKs03pIIlsWLa1k5ywEiCYXeYbj2HQe/EwcO3Bogdn8apZrMRHf2pwEVLAGPJtUQ2onhRE47ZQgHTvx68MfBwktvuPkSGExG4B9bn5pERDGS2YnzH5Q7Kh+K4YmQFaMudEsoF5Vk2iLJAWDaF10oKfN4lppyg7+leMIdR9pgEZ00aIlIcazA8oZfNqq5K7+pXG/QcFyMExtKuCy0wb4wWDPMxG4/eUCQLlQBqwVOhhDFwPcJgvUvYsVhPezli4yyIpwrixv6cjKkRTPIJNm+3TMbt4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9c2af4-a214-4e68-6aba-08dd57c0a59f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 06:25:08.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IT03cxym2elpmz2Bm7ksi5R48MKfzIx3NxL8XaK2HrQgiBS7AwyTSWzSCUrqBlPxfOnGerLZ2+XnBHpRuLY1pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_01,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280044
X-Proofpoint-ORIG-GUID: pZjU9zIZq30TNOBbprlql-CkOFcm1Pbr
X-Proofpoint-GUID: pZjU9zIZq30TNOBbprlql-CkOFcm1Pbr

On 28/2/25 13:20, Zorro Lang wrote:
> On Thu, Feb 27, 2025 at 01:25:18PM +0000, fdmanana@kernel.org wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> If there are no failures in the middle of test while the 3rd scratch
>> device is mounted (at $seq_mnt), the unmount call in the _cleanup
>> function will result in a test failure since the unmount already
>> happened, making the test fail:
>>
>>    $ ./check btrfs/254
>>    FSTYP         -- btrfs
>>    PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1 SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
>>    MKFS_OPTIONS  -- /dev/sdc
>>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>>
>>    btrfs/254 2s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad)
>>        --- tests/btrfs/254.out	2024-10-07 12:36:15.532225987 +0100
>>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad	2025-02-27 12:53:30.848728429 +0000
>>        @@ -3,3 +3,4 @@
>>         	Total devices <NUM> FS bytes used <SIZE>
>>         	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>>         	*** Some devices missing
>>        +umount: /home/fdmanana/btrfs-tests/dev/254.mnt: not mounted.
>>        ...
>>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/254.out /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad'  to see the entire diff)
>>
>>    HINT: You _MAY_ be missing kernel fix:
>>          770c79fb6550 btrfs: harden identification of a stale device
>>
>>    Ran: btrfs/254
>>    Failures: btrfs/254
>>    Failed 1 of 1 tests
>>
>> This is a recent regression because the _unmount function used to redirect
>> stdout and stderr to $seqres.full, but not anymore since the recent commit
>> identified in the Fixes tag below. So redirect stdout and stderr of the
>> call to _unmount in the _cleanup function to /dev/null.
>>
>> Fixes: f43da58ef936 ("unmount: resume logging of stdout and stderr for filtering")
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> ---
>>   tests/btrfs/254 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/254 b/tests/btrfs/254
>> index 33fdf059..e1b4fb01 100755
>> --- a/tests/btrfs/254
>> +++ b/tests/btrfs/254
>> @@ -21,7 +21,7 @@ _cleanup()
>>   {
>>   	cd /
>>   	rm -f $tmp.*
>> -	_unmount $seq_mnt
> 
> Oh this change was merged with the _unmount update together...
> 

>> +	_unmount $seq_mnt > /dev/null 2>&1
> 
> Sure, makes sense to me.
> 

Zorro,

The redirection part is missing in your for-next and needs to be fixed.

Thx.
Anand

> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
>>   	rm -rf $seq_mnt > /dev/null 2>&1
>>   	cleanup_dmdev
>>   }
>> -- 
>> 2.45.2
>>
>>
> 



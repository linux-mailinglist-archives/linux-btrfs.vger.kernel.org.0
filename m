Return-Path: <linux-btrfs+bounces-15843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FFCB1ABC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 02:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5393BE2C6
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 00:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4213633F;
	Tue,  5 Aug 2025 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZzxxaY5j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s1tPNQBe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EDB2E36E1
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754354179; cv=fail; b=KzSrZ1Oc74InRvLAZ+yDAjyJuBe3a1IlxLZPFurrGnyG6/MLvYvrTjQNwXqMypvhuDrgBSq09FSVIs39Jxy5NZMGgLGaSZPzm2QOWSt1hrePqgctZoYMrt8MHfxeCemvbxIFtfwA19bSu1impGATSVaB6NX04WmOezOSzZBBfaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754354179; c=relaxed/simple;
	bh=xYSSRMbymV9vzIPoD/iQJyScGXfhaM46c7jH5Jxs0g0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uOliUUQ44sIe6O5HuHg81MX6IjNhJXjGOnG9URzbj7xgQMePidgTLc/CaidWWLzXdIWgpfBgjq2/QDj09NFvtW9Urg5m07p3Pnrg9lmGuzIu2I1ks8kYFWr9hOvHYiumo/JQx7x9k2kYmDzrC8+dBb4LTpR0dfAL8+YRQpO7Glc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZzxxaY5j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s1tPNQBe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574Ng89o028545;
	Tue, 5 Aug 2025 00:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GRaiZqo30EqLV+e+CL39vnUXzo8P1sk/9rLE3H8D/Ug=; b=
	ZzxxaY5jQSx+n7G0s+TEi32GAKJKA2tN8z3ZoiW4ANkzpWQdmO1GmXgwfkY07JYY
	/5Z+fe41bmUX1iwwRqPUpXnGyfPWFjizPme/9bkOnjcfjwXbCS8r2gnG14Y5pTcv
	XU4+WtGYuIYISnf/Zf1mceJE2Sq9h4pzKuFDHz+1sTIctPLuz00OMKuB88Mc0BRO
	Mrbdf2zmp3SGsXUkSTvMZ+4rAD1ZogsqSghUYf8wpaV58AiFaItaXsZQ0gAAb5VS
	Xyx7z8xb+2AxisQN4IK4X3wWRaPF5Tk1+is9frvVfW2Hxit42lyMC/RsXsLrDOUR
	T3hRrtLiWgVO5t3N9b/i6A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489aqfkqwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 00:36:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574MlTdR013600;
	Tue, 5 Aug 2025 00:36:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7ms2wau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 00:36:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsQxHndVvEKpZpLfjrqRYK9E1HQz+jKP4yqFYDJQ0crBI2LGv/kmxxbSEQmEKaiQlPPW0XX5x1uC6L/Uu7v4V+kaFHuq44zd7EUDx7ELcXzdMflbW2S4KOoftwlh7/aJQhz4pj4L7EmNcXjWZy6crX9w6f2WG56atHkcONh64Yr0nbvxGMd5iJ6JmJg99sUNtLFC7BUNuf/gc7TSDMO0PHWwnQwZW6EiFz+00eIz6i1a/YOA3vYsgsuBI5ajaGemnNkkWy5r8Q9NdrbotC8XDRqLVAiL3hst35ImbZmhAzoqtgg0iJrDSO0KOIIAD2xvDozH6zedMpjepXm9WEi7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRaiZqo30EqLV+e+CL39vnUXzo8P1sk/9rLE3H8D/Ug=;
 b=o8erowAdBDwe7lMXbJdCqTB3Gt8Sn5ylrx59CMpKmWfe2qQio+dnw56Q2WLDmb+yAaWxLE6P202KXy5AdqjONCX+vbtjo3W8l+QOTD8hqoUEymUY5TzMPOHEIIVyPiH23fqthwVs3r3Yk6vtuuUE1pITGBWB194io16OsiNrkuWV9CaZCedg6tAtzMiuQ1OIczkMn0UCZPlvoj3gx7hIEkVN0Fzy1ptrvUPfibuZwBl0x9XVoPSthdfZcCSGV0vdBnq0uS62b2zdMTYGQFP53GS+dUvGGhjJgmgjN6PI1N5Zn9fYfhDxCEyKv1aqK9B1DxYbEEG11VOYbYBSl7mRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRaiZqo30EqLV+e+CL39vnUXzo8P1sk/9rLE3H8D/Ug=;
 b=s1tPNQBefjSZjUGlj93I4711UW5ADy3nhVLZb0F5BJH7fOg2Bepm322Ea4AOEgQljoO64OzJnfxNEo97iK2+JgxX+uCjLzj8vAUetp4IYa6xcnVSx4FMoS46AHVCnBV13djV/MwxKQ1YElE8t203+TzXK/zDZFKsJ7KyjNvbV4c=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DM4PR10MB6791.namprd10.prod.outlook.com (2603:10b6:8:109::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 00:36:08 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 00:36:08 +0000
Message-ID: <a3db2131-37a8-469f-a20d-dc83b2b14475@oracle.com>
Date: Tue, 5 Aug 2025 08:36:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Should seed device be allowed to be mounted multiple times?
Content-Language: en-GB
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
 <4cdf6f5c-41e8-4943-9c8b-794e04aa47c5@suse.de>
 <8daff5f7-c8e8-4e74-a56c-3d161d3bda1f@oracle.com>
 <bddc796f-a0e0-4ab5-ab90-8cd10e20db23@suse.de>
 <184c750a-ce86-4e08-9722-7aa35163c940@oracle.com>
 <bc8ecf02-b1a1-4bc0-80e3-162e334db94a@gmx.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <bc8ecf02-b1a1-4bc0-80e3-162e334db94a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::22) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DM4PR10MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ecd9df-16f8-4de2-d4ff-08ddd3b8120e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckZPcC9vZXZRZEJaK2o0NnB1YzlCaGE2RDFzMndoRDdlR1pPY0w2bFBuaExF?=
 =?utf-8?B?NDhDZHFDek9iMk9vWThlVTFrSjFKMDJicFJoMU5zb3hTY1l4Rk1SVCt5Y0Jx?=
 =?utf-8?B?WGtBOHdaMy9vM1ZPc0ozQzd1SzlUWnpQVXYwWGpjb2pXdnN1bVZJSzdrcW1z?=
 =?utf-8?B?c01qM3ZxeG9SK0luS21XUzlVVEswYUsyWWVJTFRQWlNNUG9vVWRWQjM4MEhn?=
 =?utf-8?B?TDY0K1hSU1J2eDNKNkZBbXFTSXl4V1RFdlU2SGdKTXhzdHFyMUdqUXlrQ3Y3?=
 =?utf-8?B?RG9uRlFjWkNzUXpGblY4WTFTcVdpNi9IMkJ6dGRXdWI4b1VabWorZGl0SlNy?=
 =?utf-8?B?b21vWUowaFppU2tsbDl5MVdybVRCZXMvaUlSeU0ySDkzQktTWCtmd2l5c010?=
 =?utf-8?B?cDNUeVFPVmNBT1RiQTNmRG9LSDVrSnBaWUNzSndlYUp5NjVpMklxT1h5bnU1?=
 =?utf-8?B?dUVIb3ZKcTNVdVVVamI1Z3VuYVJOTDFTaUJpdTZkalF5MVdOMkJadHlzYjF1?=
 =?utf-8?B?K242bmhGMzF2bHlkWTVyUzNOWmFNWnVjNzVlT01tOXhxZ21nM0hSS2VWS2x1?=
 =?utf-8?B?cnR3T2RyK2hPUGdOSUtPUDhCWnJLNUgxL3hscUVWMmJIQ2NMNDc1VWhLQUMy?=
 =?utf-8?B?ZFV2NjdicjhDVGdKMmlKQ0IrdDVKWnFUelJ1aGJhMEo3Q0ZRWStPTkk3YWxr?=
 =?utf-8?B?OWdzK0pVQmpkWEhObXgvK0w2YVRORm1jaGRsMnJDTlZmTW9yVkluRkJlTVBT?=
 =?utf-8?B?dkJENGlHcEY5REdnN1M1MFZXbE5oYi9nTXhMOXJHSkpFeG9oaGYvSXJSdExF?=
 =?utf-8?B?aDdGM05GS2J4NEpjVnMwbnpQVEc4emwzSjFoWnhxQWNMdzI0MkhSWk1oVERQ?=
 =?utf-8?B?d2tBa3kwTk5RSUdkYndJYkc4bVRwOGN5YjR2aHdvRjZHZXZtN1YvUkY1d2Fl?=
 =?utf-8?B?aHFzblhwTC9sbzJCVjV3UlJzaWNmTVFrZDczRkt2WGJackpuWFc1cis0Q0Vh?=
 =?utf-8?B?M1A2SnMwS1g4R3JqZHhxaWIxbm9RR0RTcXpwM0gyTTRXamc0VUcydFdjUGtK?=
 =?utf-8?B?Y3c5L3ROUzFOMkJUOUhkOVlPZWxZWnAyRzNQOUx4ZGJhRjJpdStWWWp6TjRk?=
 =?utf-8?B?UTNTRW02V3FpdCtDUTRIVDJaaFlLRUFFNmdKNjFIR1pyZWFaY2J5UVBlNDlX?=
 =?utf-8?B?dXNwTStnZEhRQnp6Zm5pWDBWYjRISktCSTlGWFlPMjd6ZmxyNWcrVURCdHRs?=
 =?utf-8?B?ODhmSVNyWDRyT1hiTVZPL2dZUjQ5bHVMbGlXTGNCbmlTNDBkc0JCUEtGZ2tZ?=
 =?utf-8?B?ZWE2UjNWKzBhejhpM21jUDhoQm5JU1k4bXduakxNdjhjcnh4WTdEeURxaXRG?=
 =?utf-8?B?UDZVSTFrNTM3dUU5VHVINkxLUkdLdEs1NG5McHd6aU5iRFFhMDdHZmdTeFd3?=
 =?utf-8?B?anZKdlZOUGhFNENYZ2FpTFNXd0FWeWJLNk1va0xYQy9TNmIveHdyV3VhcDhU?=
 =?utf-8?B?VkZTYVlmb2Zqelh2NGhzR0N3M3hERk4zeUVQWVUzaEdGa3gzYUNEbkZienl2?=
 =?utf-8?B?NW9Da0p5Zk54MExSbHd3dmMwaWRJVlhHWWhhL3VsOUMrdE1VNElCSGpVYStD?=
 =?utf-8?B?QThFRk4yTUQvTFNkQzNQZE1ScDlqU2Q2UUlNMituWnI0WThQU2U0NkgyeGxL?=
 =?utf-8?B?TFdEMlRQVzRwNm9nN1pSejhwY0xwdVR3K3lZQjJnVkRuZG5ITXZkZUcxZ28w?=
 =?utf-8?B?b215YjQvTi9vZzl6S1QyS2JRRitkSlc5eG90MGRaMTRuREZyK2RXVTFLRVgz?=
 =?utf-8?B?QmdkOVhHenRMamxXY2E3OHlzaW5USEswd0gzME1ZWUdwUWNaYkRGaVFjT1g4?=
 =?utf-8?B?MEVTSHZWdVJGTEl2ejN0RlFsb0FmeFpUbWZVWC9GN2pJTlFsbHZDckRMc25x?=
 =?utf-8?Q?Pp5iFEcM40w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVp0dStRNHJZVEM4VFoyaHUwenhFOHJQZzZ4RENkSjFMUWRWUlI4T3Q3SHJF?=
 =?utf-8?B?RUFZWXRxM2E1L0cxWjljNmlrdXM3Wjgra3M1VFFxR1o1dml4NVlZcDQ0V0p0?=
 =?utf-8?B?M0NMV01kWTlYeTc1TEJMQWZuaUY3SSt3M1lzVldNZm41SmluQWpEYXJRYXkr?=
 =?utf-8?B?Q1ZHZEp4UnFibDFDMXh0Z0lSWUN1d2JGbEkzOEhwaEZzWGpTWEFnTDB3R2Nv?=
 =?utf-8?B?WUZlalVsTk1UemkzVHF6a3Q4azlrZmNJNU5KVmY1RytFRUVpenZMUFhmckpy?=
 =?utf-8?B?MW82dFZFc1ZXanFBaVhXRUVoc3hOQytZWGpHcGtOSWNWTlFCZ29UT2FOeEJS?=
 =?utf-8?B?UGVNaDBMSDJyMkk5alo2eFVVWkttN0ZuNW9yYXFIejFQbk45MGF1ZXpZMG1p?=
 =?utf-8?B?VlBIeHM0QkZtem9ZWi96T3E0djdLdzZpVVZ0UXhkTHg0K0piRTVCSnJGWW1H?=
 =?utf-8?B?Y3hoRWJrSVowbjUzaVlMNFhaSS9FS3pqVjFVR2pNYW5YampXdVhNRW41eWgv?=
 =?utf-8?B?UzJDL1Ivc09XTUtHOExnd1FxbkZlb3JUazlHaURvZUEwdEFmengwcVVuODc0?=
 =?utf-8?B?M2htaUMzWVA2Z3ZBUGR3YXBBRkhOU3dHelRBR0xseTdEU2pNMkVTckVTemdy?=
 =?utf-8?B?dlUxZTdKSWhEWElIWjhSbFJtRytRRTdDZ3JMVTFUU3RZWGJkTzZVSHZGM0s3?=
 =?utf-8?B?Q3phWVgxT2FwcEphVEVxSFNPVlJ4L1pKK3h0MVlYZDUwQ1N0QnJSZFdCVXF1?=
 =?utf-8?B?dnVYRWJueUhLSU5peXBJbE9jcW81bTNUWmRtUUVTcEY5UVlvOG5rVEc4cG5v?=
 =?utf-8?B?QzcwL1U1bnQ0ZzRKUUNpMkJtNlJKbGRTN3ZlVGplM2poTjhxWmhBb0RKb3FG?=
 =?utf-8?B?RWgvblhMc2w1MFRVOEdwLzZMTjJBeEhYeHl5aUlZdlpwSEUrWHcrK2JsRmlo?=
 =?utf-8?B?UmhPWDJCTEF0SjRkZ2FmVkdKZ3JxOWNIRnBUWWF1V0lWcjFSV0NwKzRzdXBm?=
 =?utf-8?B?WXo4c05kd1k1M1BrMUpYa3Zja1ZnWjJnVzBmL0t1eEg1cGV2eUtZUzcwR1N5?=
 =?utf-8?B?Um5LMm9rVlF1NmpBUUM2YWJ5aWVOb2xxL0VXNkU4SHpIeEpBUnlTWEtiUXBi?=
 =?utf-8?B?Q2wxWndvOXkvbHZPN3hIWldxS04vZms1dE1TZEZNUWhidk0vS0pNYTFnWVRq?=
 =?utf-8?B?TW1TVkg2WWFqT3ZhY3c5R3piZWNTSWZYKy9FbUxrTjF2bFBINGIvNkhlS1gx?=
 =?utf-8?B?cHRKa0RnUlQ3ZkNOZzJiV0xhWnh6TXN4MGRadkZsNTIrZVlBWDB5TjZFMUhu?=
 =?utf-8?B?SU9FcEVTWkNqaHFuWVE1ZEJKVGRNaWtMMzcxV3ErSDQ4Q2FyU1pOSld5aXBD?=
 =?utf-8?B?RkNaL3hoT3M3UDV1elg3NG1HOUtzMXQxdjZ2eHRXSmlxeEhqN250SEtENjFS?=
 =?utf-8?B?NXhhRjZ0OU1ReVIvaUMzMkdMTjlxdjhHcjc1Q0R6c2NoTk1YZDd5UTk4WjVD?=
 =?utf-8?B?MVU1VjJCK211Z0o2ODEvd2xPdmJFN2I1cVNmWDBodktkSEpXVDNEYWxMd2o3?=
 =?utf-8?B?L1VIV3BrT0d6N2JnMWxuTy8zcDBJVnFtZlhRZFFKck52N0JWNXpUK2xiaHJ3?=
 =?utf-8?B?dWI4RkNyb2cya1hkQ2dLMHFtaDF5aUJ1SlJXbytSTXNsZmRjc0pRTFViWHdy?=
 =?utf-8?B?RkN0TDlqOEwrck8wTGxDWUFNZFRrdXJsakVwS3IrUGhSemxZSUNmdFMwalVS?=
 =?utf-8?B?K1BxMmt1bVlhYksyMi9xc3p2ZHZReVdTZWpBTmZBT0J2Zk5WZmxEbzBXZXM2?=
 =?utf-8?B?YXpZZFVKMWVMUE9oNDl6WVpQMG5JRHN3VWZmdXl5TkI2Q0dSOHZQOXBLak42?=
 =?utf-8?B?d25mN1lnN3hYRm9tejdnWlg3OG5Qdm5BelRBNVVyc0FvVDdUV0lmY1FiNGZv?=
 =?utf-8?B?ZmRuOFp0WmNnaTBJaXpYZXlBM29aTjNpRE9kNTVkTWtKNk1qMVNjMDB6RjVj?=
 =?utf-8?B?K1FhcDZyTmFxaGJPd1RCakwrbzJoTGU3TGk0d1ZaZ1cxc1JGWUlsOXJ3VVcx?=
 =?utf-8?B?NVJKRUMvTWY4TzI5NGRZMHo0MVJmQTlnaFkxYjZVSHM5Uk51SmFUSXhpUWVq?=
 =?utf-8?B?cU1PbmRPbUlBMTNSbmpqQjNPNGRTTVF4T2VSK09IR0ZiTlE1dHZrNjFrU3Zu?=
 =?utf-8?Q?Bkp9x/hNWm8sPLU6AX1VjDzizjYnO4Si8KjLlD0FaOmW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0cXosYWbFbw3wMBElWveOR3y2f1MUNIlYAcu6gJ+GYVHPeIOODVM/vBLFe2bY+XHqNdQ5JqIZWhmBMrK1NLbiojkIIBIkfGRTbjI2EZ+sbBaYKbW8JaauFiaSJwK37pA9cT2NG7R1MdO7mcEaYrORmXK1rwimCpFPG380Ox6usCpnoUk6kiDZEDh3zM29u7E8HiJHLcRDEetMVRcEWUbDqjHPzZAyI6DlspZdmBBKZdKC6kQofw14kLbNWMeSDnXNEAyqE2kSIVWQ8ThyqmOvIt+LjFx2DHlqnLoFdm49firMzAaWCtg3utA+RKHYvLXyF2tpVWyp41lObIyDt5ksHWq55U+PjNW/LYu43pFvnMBvmnlgo4L7BQpJWv70oR1Yc2OALZBeIVddkDpVwPEG/L2oednOa9qrtKPsZikKXPbkEUjU8E3xmLdBy5gDFdQ7pfAimswc0qL9ndWNvnC5XmcfJ/w/hVe0a0N3LntdTaBNrIgobQ8IJ6Sx2Y+UUBs9D1kGIbgbHgKWyv4WH1P1AqXidWClXwwF7VTjMh6a5e7RmR8hiASV1wjxXml4v7K2pAeio/uY9Sfk0cpFr4Z1WYF77uQ6f1Wns6lQnUT8OA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ecd9df-16f8-4de2-d4ff-08ddd3b8120e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 00:36:08.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fy69/+CvNzfneS5VsX4x69SEf93I/kMaO+bHOt8AcxgyTMs7CzbjjDMv6tDHO6B+K9jJwRquwE6wuRAjSAJFmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_10,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050002
X-Authority-Analysis: v=2.4 cv=TrvmhCXh c=1 sm=1 tr=0 ts=689151fc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=h0s0oI24q0HVhJ_b:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=7PXYXtjb9lHATif5hyQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13596
X-Proofpoint-GUID: P6GcyEUN9K5-2kfoNkinIlfeZCCjrI-b
X-Proofpoint-ORIG-GUID: P6GcyEUN9K5-2kfoNkinIlfeZCCjrI-b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDAwMiBTYWx0ZWRfX08eRHPfjJ0Q9
 SwBwkt9qOsfwtagfzxSw3RswqVUB0yyblhFgGpn4ka4SAABwHiLu04q5WHlgofcJG1aHlJVOu9y
 qXKTTOBMF2vIgexLfWmXEpkC05Euot7d93QeINMz5AuoUCxRkvn3KQ8seeHGRVlsml+kGs4Tkxn
 kfYwS/oyFIzhLW0d3rmhn75jlVZgGlOq3cBeNxy5HIOuB7DInGlDojN6o3C3nrJ/uGwvQskash7
 HM6JjSjpJmgxkoJCp1Nhm+FfW3qcViFBFmTAlHhl6C+9xRG5bmDbHYApsjMKsFKph4V6v7TamhD
 IQaPuukFTyTBM9u3EQqCAa/9bMrjdQOM+nGqVjTuvO+9g7y0OOaSbx4v8a4k1tkJykD/7ha632U
 0nYdkKkn7gIGjg/RT70qwAwEWXGTcfvKgG+odCxNtttfeA3FqdVC9N8j6kqY9wNUN9FMuVlo



>> Thanks for the comments.
>> Our seed block device use-case doesn’t fall under the kind of risk that
>> BLK_OPEN_RESTRICT_WRITES is meant to guard against—it’s not a typical
>> multi-FS RW setup. Seed devices are readonly, so it might be reasonable
>> to handle this at the block layer—or maybe it’s not feasible.


> Read-only doesn't prevent the device from being removed suddenly.

I don't see how this is related to the BLK_OPEN_RESTRICT_WRITES flag. 
Can you clarify?

------
/* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
#define BLK_OPEN_RESTRICT_WRITES        ((__force blk_mode_t)(1 << 5))
------

> You still didn't know that the whole fs_holder_ops is based on the 
> assumption that one block device should only belong to one mounted fs.

You're missing the point: after a sprout, Btrfs internally becomes a new
filesystem with a new FSID. Some may call it insane—but it's different,
useful, and it works.

During that transition, fs_holder (or equivalent) needs to be updated to
reflect the change. If that's not currently possible, we may need to add
support for it.

The problem is that fs_holder_ops still sees it as a seed device, which
is risky—we don’t know what else could break if the FSID change isn’t
properly handled.

> And I see that assumption completely valid.
> 
> I didn't see any reason why any sane people want to mount the sported fs 
> and the seed device at the same time.

Neither of us has data on how it’s being used. And as I’ve hinted, it
does violate kABI from a technical standpoint.
> If the use case is to sprout a fs based on the seed device multiple 
> times, it's still possible, just unmount the sprout fs before mounting 
> the seed device again.

In a datacenter environment, unmounting isn’t always a viable option.

Now that there’s a regression and a feature has been broken, let’s not
shift the discussion to whether that feature was useful. I prefer to
keep things technical—not personal—and I expect respectful communication
to be mutual, not taken for granted.

Btrfs has some unique behaviors, and it’s possible we’ll need changes in
the block layer or fs_holder_ops. That still needs to be figured out.

Thanks, Anand


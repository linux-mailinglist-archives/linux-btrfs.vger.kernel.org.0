Return-Path: <linux-btrfs+bounces-14153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F544ABEB04
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 06:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344864A5968
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 04:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463E22F758;
	Wed, 21 May 2025 04:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kg2KjdgK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tdcPDlRz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887464430
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747802655; cv=fail; b=kH8IvoSu3JzxcGNPmSw4ig7VYySXqHmRg5g8NhEmAQGY3eqL3WeYJboqUMbIeW5SJWyawcRQ1Gp/E3YagKE6oDPavwvMSxvro17K2Ar5TACOLR54XVcsc7Z1tzsGv50O542Vzvho0I4uJf7bc/i/3GrrFan4git9eM6+5oaj1Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747802655; c=relaxed/simple;
	bh=sgqm1IWJ+UV1khpg0j+DFJQdPrGED0TxAB+GRfJ67UQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SeUorrQHJt/ZZkS4oI88zdf9j5jSoq3/jUXfVxC4VNrsHvhLtkQKx8yPPIx7h0tFGjMCZz7oMgwSlIfQji9JR93eqh/DPwylyzHd9ECPZQbDOXChwXmjhaCOXr1NeBC6WsYpfYLTOgvB9yleunwZRiunQlVoixT6Am/UxgtQ+Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kg2KjdgK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tdcPDlRz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L0gNN3005834;
	Wed, 21 May 2025 04:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aEjwc/HnvJWWSScsHiusETMIRKODRvB3GKLU+007k7E=; b=
	Kg2KjdgKIjFcSYqpf3NeRmuYldhb/VnesMZCadFpeDUZwhMeOcDcn/qHkvKZQxva
	8OlHGCJ1XjZL5M5wVJPAFNgeKEJvBOQWXVKAs/n6nb/yrwhm84XaZ/UI4vpzB5md
	hdT/wXBvlIwMUSeZtQiD5++28IKjosat1qIv6o9BflNfzW26l93oG3XUgmKfgj3e
	v4CLpvsjbc/hOw7TmtcCcep+8y24uLFGnC/g8k2YLyGeYZRdEUnVy5Rwhh5l2t74
	Gq16Uud0GZgqaHQ8Ho7mtDCbuZGp3ENfYJt8ULmSa0uNLPeCZAfka5BVcM4kIm8Y
	5Mfu0Q1r+ddC479jICQy9A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46s4h109st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 04:44:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L2DhhM001761;
	Wed, 21 May 2025 04:44:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rweruy7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 04:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=et6uEirhjEKYy5N2rez6I2FOdAcGxVbgR86Hli882/qudi+1WFo4MI9ubcwcUyOSaUcWdK3LR3/V/fexWNusCJ9qYsRWEcwoHTODGdfwa1guzgRnMvvbD3kT7w0tF6eRlaAY2NWE+yui8FS8r5EFrCQ+H/yRdBzM6JgRqp+xSJOObmy4u1mLtt2f8d4eMOck1tFKih6Y1098Yw7zEtQkijSIJvxRV1hJowGW5b9aQ2orWbJ4Ck1pQ7QzBPGjFHfONAwiLsQdeuPMjnEIE4jnrsJtYBcQkwPqXMBYSIj5hYUhIvAecxR2+oGqTPONxyo+Bw1zMdMGz+YnM8LS1OWDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEjwc/HnvJWWSScsHiusETMIRKODRvB3GKLU+007k7E=;
 b=JDuGAltYTtQZR+McA8XuF1pmKCJWm7B7Jzg8uyNjLWhsLSglA+WWOtzJ2/iLmM4veTfzww7c/kWGiVt8xf/M+n1whBM7itYwqBQd+6u+kMXJXUSyRcef/MBBqawcA1zaVCmKVtXR+ilymlJqcE6zKyRocPvrRjAJ7OOF1kpiYYJ7VDWTtBOUIlW7MhC4rEfCxn6F5l4gLz/0NjiWur+g1PFaKBo81LaFtdG0/y9PWJcnlSUYe3jqta8NVhN43xSPj7hcgScZ/mHc43NIOexExUwK/PnNDBhPh56Mij7pKQ1tPItkSXcDQP3u7LKbY4bOf8WyDRjxD/Zg+TEPZ/0l1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEjwc/HnvJWWSScsHiusETMIRKODRvB3GKLU+007k7E=;
 b=tdcPDlRzzdd9VAknoYj32biutRR+tA0BafQFY/jiZg/CcBYjidiLZlZNk39ypg6WPet+Re3tiK4QwT7YECgsptIQ97/mt7FjvXHFZsUBcbQSo13d1kwEobnK4N1rHsRgDKKhrJFUO9vkChGC0/fWFaBTm7WWOLBBv1Xb7IWUQpA=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by SA1PR10MB6471.namprd10.prod.outlook.com (2603:10b6:806:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 21 May
 2025 04:44:07 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 04:44:07 +0000
Message-ID: <6b27ac62-a876-43d4-8d38-c691146e8d0a@oracle.com>
Date: Wed, 21 May 2025 12:44:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: preserve mount-supplied device path
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <85256ecce9bfcf8fc7aa0939126a2c58a26d374e.1747740113.git.anand.jain@oracle.com>
 <da820980-ecc2-41d2-8406-fcde11b0bfb5@gmx.com>
 <74ee4615-09c7-41c9-9197-c83b171f1c74@oracle.com>
 <1d27523e-76ed-4a92-bd79-49643c5272bb@gmx.com>
 <fbc3c413-c4c9-47c3-9c5f-4fcd7a772e61@oracle.com>
 <bd7d0253-f3b7-4ac9-bcba-be4064246400@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <bd7d0253-f3b7-4ac9-bcba-be4064246400@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|SA1PR10MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 571321f4-b22f-42c2-5573-08dd98221e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTdraXEvRFIxZWhrcjZuaHJGc1ZheVl0VHF4eVlKNnNNcVlqSElzbDBDTlpW?=
 =?utf-8?B?enhUYWh5NVR6aUQ1VUdwK1AybHo5OHBZL29iZEpOT0NzSjNTbXFKZ1NYOTdK?=
 =?utf-8?B?d09FR3ZHR0RqVmZUdEJEL3dyUDgzbXFBZVBCVkFScGUyR0FrMHFvOCtPNlY4?=
 =?utf-8?B?UzkzWXZEWVZIa2FyVkxQTk51bzlHUmJmZ25seHhvRlFJMVVrZE1QaU1nTVdV?=
 =?utf-8?B?bURCc2EyL1h5dS8vT2J1b2ZsWmtPSEZCL29IUXJoRUIvbzFZVDhBbEJFbUtq?=
 =?utf-8?B?YXZqV0JvQ3h4U1JqeGVHU2RsY2hoMXlJcUcwNXJPN1paOEg4TG9yQSsvL0Jm?=
 =?utf-8?B?UExPRDMvQk5UajB0am5aVEFCWXpkbDMwbHhHVHZJY1ZyZ0pydCtzbE9kZ2JD?=
 =?utf-8?B?MzZkY3VXdTZ3bUZjUGtyUzRJdTVWa25IMTBVNVFMTmFKRGRxS3EvWXRnWGN5?=
 =?utf-8?B?SmpaYWVKTzQ4czdMTFp0WEpHTXBOMGw1RjhIa3hOdmhabEJHTy9rbDUrcnVB?=
 =?utf-8?B?SEVqeGRzbFYwRVp6amMzSG80aDlocHJ0bVM0ZHVkOHB6SkI4c1Z1OTFBWitz?=
 =?utf-8?B?S3h6ZFVWRWxvMEwzZ0JIVUhxczFmZW1kMG5IUEQvVkVFc21lYXlIeW15VjRh?=
 =?utf-8?B?TktxWHd2dFdMdFp4dFdQMmF5WGJHUFI4MjVreWhFK2FCZGNiRjNjOXVVZy85?=
 =?utf-8?B?ZDRpcVhZTjBWZGdyZVNUWmhMdEJhUVNJMzdHYlI1SVhiaHhab3hVNjd2TzZU?=
 =?utf-8?B?aTFpcXJNeU00MEsvODk1bThISXhqZUkvUC9sRFI1MVN0dGZLWitFOHFQQnc0?=
 =?utf-8?B?bytVS1pZUnM2VmNJeW8xNXFjTFFveTJIQnZ1amFSbEs2TzBoVXdHYTZ1K2pS?=
 =?utf-8?B?dmlKMnJ6dlRkb1U5dGlsQ2FPcnlUSzRqUmpIVkpRd24zZnNTSUkwMlM0TkxW?=
 =?utf-8?B?cWZpSFM3OUlCWjd3Ykd4b2o4dHQwMXc1anVtdXV2MDAxVkJVY0hZM0YvTUI0?=
 =?utf-8?B?R3RlNWFwQzNYN1d0RkVHRXJvUHV5WU10NXk4UTlIR2MrYzE4d0YrK2dFNUZ2?=
 =?utf-8?B?YTJLYUVwSkNiOW1EYmhma2xlNm1FTjY0UW82RFRjV2dsRzNuWmQ4SUtBYmFU?=
 =?utf-8?B?eGdFNGJEdXJOLzVXeHFNRmF2cnJsUU42SmFUV2lIU3k3bDc2NWpJbEQreEtn?=
 =?utf-8?B?RWtSTTdyTE0rS2lycSs2a212WW0ySVlJNGRzT1NRTTZMMVJSc0krR3R2ay8x?=
 =?utf-8?B?cU9QTCtoanVqdW00RFJtSlBpZmZSZklRdXpTN0YyYk1jZ3JBS2xiSC9oQkhv?=
 =?utf-8?B?WGhHZ3VaMU00VnJ5ZE5ZNzVIS1dpcGNvWVJYSEd5Q2Z5QVpWSG9TdU10ZkNE?=
 =?utf-8?B?Q0dTSDdZTDlaU2NXdjFrbE5UeUNYL1AzUFdzSXdrNm1GQkEvN3k1YXBielJq?=
 =?utf-8?B?S1RzcjNyV2dVVUZobDNHV1NLd1RWN1VlL0F1aTVqcUxBQU9QTWYwWEJLTmZ2?=
 =?utf-8?B?WlVCVHdpci9rL2tQYUlxZFNxYS9saGdJTDhyVDQvV3NJRDd6QzI5Ync3cUxZ?=
 =?utf-8?B?L2NqbmdGbjUwV21kYjdBMGxSNUhOZkFtQzVpVWxNbDRKdk1ZMUY4MUllUlZr?=
 =?utf-8?B?R2xsdjN5akxqU29rVGE5czBUMWNYZUhlY2hwL203UFg3VVZOZTlwWGUrRG1k?=
 =?utf-8?B?ZHRhL2RZVkhFL21OdXJ2Uk80QlFYa096WHlrMWpJMElRenU0ZDM2U3M1R3Bi?=
 =?utf-8?B?VEthS0w2dVM0SEQwWHBwbU5sOWhvL0QyaUg1cFdRbWhNVkZvT0xDQ085QkZP?=
 =?utf-8?B?b1B0TUh0MFBOSDdrMnZubUtTajgveGdTaUlveGduMlF3T3FhK0I5ZG5NNEM2?=
 =?utf-8?B?TjAwMGlrTnZQWU53Mm1CdFRxZWhQUXdtMG1IM1htT043ZnNTMWJzSjUxR1Zs?=
 =?utf-8?Q?edOK2hM1euA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjNCT3lTY1lxb29Ub004SGRXWWs4Z0pJL1pxVGp1VHNTV0NkVmVyb3dNQVpF?=
 =?utf-8?B?YW5LZ2czbE8vcHB0MGlDSjlnNlpoSkV3UXhEOEFUcTZDUmoxOGI1L0VNemZi?=
 =?utf-8?B?WGNtYWhKeFRPWGNpU2F3c1o4NGxpa2sxZTFDOVhld1VRd3U5TlFyaXVNZVZo?=
 =?utf-8?B?SWRWUThJRXdXVk5GOG1ueEhJWDduN2ZmMGxJZUZXdFVvYjVRU1FaNGdkT0M0?=
 =?utf-8?B?cHBZVUpvYk9iM0R1ZEYreUxWN0tkK3dTTHpSUWdrZnJIQU52RGovS0ZGUmRh?=
 =?utf-8?B?L2ZzSE42RDVJdWpndjBwaEdhelJWSDNNcTU2T3FjU3NpeXlpUU5uOWZ3eE9I?=
 =?utf-8?B?NDFuUW9qS2l6a1V0a3lDK0ZpckJTSlBYelRJditEdWVNU3lmSktBOG1IcE1N?=
 =?utf-8?B?UEl0L0dlYXpTMm5tZWZNMi9haVFSTFhhdXR5d2pnbHhQNUg4dzM1d053SU1U?=
 =?utf-8?B?MEdHTmJ3S0dUbStsbDBVVWdLWG9DMHNrN2JkYVU1ODN2bW1KWDBpRjB6L1lT?=
 =?utf-8?B?VVBlc21wbTdtTmd6cnU3RHd2dHVZOW9VOXlCWnlZRXpGZ3daUUdWVzBsK0xB?=
 =?utf-8?B?N09tVzBoVFhaTjFLSFZuWnhQVUtzU2x2cjg3S282SFk2bXVhTW5OQnRnZDlE?=
 =?utf-8?B?aEtNOWpXVkVjbnVIemVkSVJUZFJQSjNrMkVLOGZRcERXbkl3ZDN5NDBBUXZt?=
 =?utf-8?B?VTRrbmxaQUE0N2FRN2lxaURiRGdHSThGN2FTQzYyTUlHRUJKUkZKWERUcHJM?=
 =?utf-8?B?bmlDVFpCZzdncFVBakRpNTVmVnpkRmtuc2pJeVRxc2ZOUmNtbEdoN3BxZzNE?=
 =?utf-8?B?VCs3OXJFK3V3a2JVZS9vcURnKzNGellWVVBnTk8rTGhxaDZJYS9HU3c3eXVH?=
 =?utf-8?B?SnZOeExVWWlQMW12REdQaEJPdnZrRmZyd1VDcnltYzhKUU5NMGlOUGkrYSs3?=
 =?utf-8?B?Tys3aTV0dE16L2E3cjdPc2JsSXhYK2VHQVcwcFNPQ0pRcHJibXIrdzZVdENy?=
 =?utf-8?B?eWxnT3JZNWFjeVlSanBqTWRGVDNxSTZZQSt6WlI0TXh2Y1dWazFYQUl0b1ph?=
 =?utf-8?B?WFZ6R3kwQmw3Qm1GbmxqRFRVSmJHNVprYTMvOWppTFMwenU4UmVCc1ZHR2JS?=
 =?utf-8?B?N3A1NE5zd2lOUFlWR0RISTNkakxoZWNybUtjdzBHTEFCZVlCSXpJdGZJeVdV?=
 =?utf-8?B?K0JjeVF6MzhmNXFPd25FdkI1U3BpcGtPemxUZjE3dGEzNzErdnRqMllhZzI4?=
 =?utf-8?B?aWJseU83dGpkK3h2QzhKQWNkNEVVY2pJOXJrQ1BYVHJNMW1FRHRNT2VNczMw?=
 =?utf-8?B?Tzlaa2t4ZUt2NVlFMVRsaGNFWGhLRlh3UUIxUmNINjEwUEF5RHZyQUlrYVJN?=
 =?utf-8?B?QTJCS25BdDFnNkF2MHBzWDNzQit5Y1NxSnVadXNuM1E3Ymh6TWplTm9Gb3pz?=
 =?utf-8?B?ejhEV0ErVW1oVnE4YXk1YlVDdFpEWFFSc3NUdFVwaktvS0lsTnlNaDFZdzVB?=
 =?utf-8?B?R3NPLy9mT0dBZ3JiK1JjTUMyb2F4ZGpXNFU2QXpoZVNJZEhmS0ljeHgraVNX?=
 =?utf-8?B?cWtBVU40SzEwSWhodWwrcGNyWmsxbW5uRmtUa21TZEljTml0Vysra28rYW52?=
 =?utf-8?B?dHU2eHJUdDEweWRGbnZzRDFyOUhGM0xxS2hwYXpHbktHTlZmQzBJMUl3ZzVF?=
 =?utf-8?B?aXp0QzJMbFdSQnEzdGR2Ri9nVDlCQUt6c0VpQmtCZzA3THhLN3Qveldra25J?=
 =?utf-8?B?MTRjS0JDRnFadHE1YlcrV3VFOE8rY3FPVld4SnBid0docHNZa1hFSHd4QTBX?=
 =?utf-8?B?SlF2MXhOaExselFRbG9FaTc1azNrdEpQTEpVY1VJYW1Qb09RWW1jOURmZW4v?=
 =?utf-8?B?WGN3TWZUZVRmU2w5VmtUcXJsamp1cG9FVHdqaGlLUmQ3L0NvUGlDYVp4NnhW?=
 =?utf-8?B?amdoWWIzQkthZnh1bFNXM1JDZjNwYk5jbmxTbm1Nbnh4Rzg4d1FZcE9oRXI4?=
 =?utf-8?B?MHJmYWR3UFh3MlEzVkpKNHVrWFIwSWZFK1lsV3VaMmFFMzdGeFE1SzI3d3BT?=
 =?utf-8?B?a1NYYk5TODhnREN6eTRZazB4RXJwQVZEYlgvTHVEVC82Rkp5cnlueHZaR2E1?=
 =?utf-8?Q?jzqdk/WjkbY3GZKYsB/T32rk7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fk1EpjpnWbiAm2SmZKLNK5Im0TI1+9k0Bnd/OOPYQFdeoiW6GBPfGkQMOHOYykym19k4NED9YHPc6mqIcPrQagRA2U/F743le//4H7gilMKbQ8aJiPUMdcslvoo++n2p09N045JN+4BABV/zMgPiDrxVhkKZaoHoNfeUvbBBPqf39WFTGrrl6Ju4/Cp0nm1dveBNCjdCucBbqfP/6pOgvCTqUIbDYOneWXu4/qrELOWx4NkoFh83uND89iO6hwkKIGLuZjDdt0C9ZHr6X7aXm5LFxvi+MlHEPS9AtxzpEWpTTjCH3+MTsF7BFs780ct15CtKgqAtXD00oW9qJuoVybstcpnXzTMdMteXCVN5gOREKCKuEjYqozgTvdU8lW1wtz5+TONSdduo5XIhaGZ1LJfwNd0P8JGkvXAzdh1WpFSUUjmii+4aVxu3lORa1qLw65qcpB0RmCwjahnCbw01JH1lTrkomJcpQcjWipGGWZRIM1Y/SVh6KpynNLkeFok4KVlsyNWLw6fByv0QFcSwE8lu4WeFRvFR6sGjQtwGcvNBqZyDjdeyrxEakaAYt8Nq8ncW70aZVnTkYsJo3HS0hvIdWQg5YBzqton1qxs4QT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571321f4-b22f-42c2-5573-08dd98221e9e
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 04:44:06.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skEXup+Tq7Tu83PpGjkz2vESbsaxtcxvKyn6fr4wNbV556oAAzIxy/Tp+2xHVfBZJ95gff4nR9sxFDkEGZGRrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210044
X-Proofpoint-ORIG-GUID: T9xw5KATy8nyZh4OnuYh7n1iJxD9O2dp
X-Authority-Analysis: v=2.4 cv=d/b1yQjE c=1 sm=1 tr=0 ts=682d5a1a cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=W8m8L6Qrlf43_rX2UY4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: T9xw5KATy8nyZh4OnuYh7n1iJxD9O2dp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA0NCBTYWx0ZWRfX/937b0ORQf0v qRk03G6Ie4VGFZQA92jBlqfoxHQVvwiAToaQp/2A4nmeUMLNNpqPjNDC7IezUaKuVAUwuleea7l T1eZI4EN4hvVUPWs1QCVs1rMfrXIahZXPSuGhKHqU+qoKeU0hLmSaVZCFO/7dunhTAqDTMcuhHp
 h+n2V+cuRycOlJzkDmSVo9emL8MMeZGAqHr/fDc3g2/T/afmjbq4AJY26B8QcAe/dsOM3l99AyM hyu9COK1Y2A/XCq1R3J8P4+bPxJ1GpKQHwDsrXoRM5JiaxEjnJRoKwSm2EvSzaZNdA00gEh892q OgOnKNb+F7aQqTgwPuodt9l31kB7NuSUhdP1EhvNiYC9vjSiuAZivbNl1KgPz37u76/dG5ygYRE
 Mevu+zjvUNfFOfnc38nIcqGLrVf1BiFexrPdFcU7h0hulq1lxGfAPHtn3pUq9QIltrHbcNGC



On 21/5/25 12:06, Qu Wenruo wrote:
> 
> 
> 在 2025/5/21 13:22, Anand Jain 写道:
> [...]
>>> That's not the how fixes tag should be used.
>>>
>>> Let me be clear again, you're working around a bug in libblkid, which 
>>> is not the correct way to go.
>>>
>>
>>
>> No, it’s not. The point is that each individual software component has
>> to do the right thing so that it inter-operates well. Think about why
>> this problem doesn’t exist in ext4 and XFS — you’ll get the answer.
> 
> BS, firstly it's libblkid resolving the path to the mapper path, and 
> passing it to fsconfig for us to mount.
 > > But if you do not use libblkid and pass path directly to fsconfig,
> kernel will still properly mount the fs.
> 
> You ignored the fact that the device name passed in is already modified 
> by libblkid.
> If you do the same using the mount from busybox, there is no extra 
> device path modification, and your workaround makes no sense.
> 
> 
> Secondly, XFS/EXT4 doesn't bother the device name, because they are both 
> single device filesystems, they only care about the block device major/ 
> minor numbers.
> 
> The device name used is not handled by them, but VFS (struct 
> mount::mnt_devname), and it's again back to the first point, it's 
> modified by libbblkid.
> 
> And btrfs is not a single device fs, it needs to manage all the devices, 
> and that's why we implement our own show_devname() call backs.
> 
> We can choose to show whatever device name (the latest device, or the 
> olddest device or any live device in the array), just like the user 
> space which can pass whatever weird path they want.
> 
> Wake up from the mindset that there is only one "mount" program in the 
> world. Then you can see why the workaround doesn't make sense.

You're putting words in my mouth. I didn’t say what you're claiming I
did.

Let me be clear: each software unit must behave correctly and
independently. That’s the only way to avoid interoperability issues when
other components change.

If BusyBox wants to use /dev/xyz at open_ctree(), it must be allowed to
update the device path. In fact, your commit 2e8b6bc0ab41 (“btrfs: avoid
unnecessary device path update for the same device”) blocks this, and
that’s a problem.
Same with mount. If it prefers /dev/mapper/... over /dev/dm-..., it
should be free to update the path. But your commit forces the path from
the device register ioctl to be preserved no matter what. That’s not
just rigid—it’s wrong.

You're calling my method broken, but what's actually broken is the
assumption that the device path from the pre-mount context must be
preserved in the post-mount context, which your commit 2e8b6bc0ab41
wrongly enforces.




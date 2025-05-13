Return-Path: <linux-btrfs+bounces-13971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB763AB5297
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 12:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B754669B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2522550A3;
	Tue, 13 May 2025 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Op+iuN6h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E5Skl6vN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A306244691;
	Tue, 13 May 2025 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131423; cv=fail; b=gMw4RqJYOtzzKYo/+JgzAoSdZH58awN5ABXtyC6vW3x6E0AAxw362GAwVTMW8EUwF1jcE1A1f3zYXz/r4UOtwT7qQ2Yr2TOw6IAdQZh5YNDDYcSM5sVcxNZx70CNy/fYiVrr7akDEuf4nlIT3uvmUV+LU5+taspuVvm0pS9rBMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131423; c=relaxed/simple;
	bh=74E1dHMAr8HO4Evwfirc07Mm8qD0U+B6T5dWbaKjaEk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hB60maUVEDnE64BT5bOP/0jd9PncnhfIL0yDeTSgk6rkbkpJO75hYXyC51G4iKGagtx2RlSRCPPUeEZpvVN4bdvR+UGibur82Irc3TUIj7VZ8RGhbvX06Xwr8SjCMTi933LEClXFqeSZeZNEsUaVM+O25I1eghkI/IEr63jrefY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Op+iuN6h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E5Skl6vN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D1BppL027407;
	Tue, 13 May 2025 10:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pY1x2zRz7frDJyiGpxSqM6p4h0BtuNV2N3sjyDQlu/8=; b=
	Op+iuN6hNlgUIrAbGhL0QC/Udy6f5JgkPrJlpbioFUe5jY6VPKSkgRC7M656Zebv
	YtCafGOtNXBrRJNsp5iHUCpbLaAlokitOIBJ+hcXL3b5u+sDUM6txi0vl7N+koJE
	Mmk+GvGqwSQ2PDvNf2ERWKMso7YEdhQxH1Q0xlbl8ahjyVQVy42f78MqZQek7RNu
	T3QcsuPWLf8LcGVnFKonJtwtDwHgyHcjl0LrtTzqGQefwUD1p3hxsYkXhzL+rHM5
	ykb1tism4T+WYIp1VzKJiA+ip2lpTj2P3aF3cJBMpHN2BwWgklTBMwEjT8JbNJmK
	9JA4yFdZbtAY8S0l8DVNJA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1jnmeq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 10:16:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9gT90022301;
	Tue, 13 May 2025 10:16:58 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012037.outbound.protection.outlook.com [40.93.1.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw89fet7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 10:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDIBL8fgxrJAGrF9ZX5q/wGe9yWfp0DbzfCOVLOlx2GVMvar3ybMnoYRp3Vfymut72svFBY18LqQuRyWWP5dVoZIERudhn3E14jX4UXOhDrAP3lxaxm7TqmKXSjODUI9UYuyxSSXLDJNYBwH464w+2JoQiOiGR7LTs8lMfm2XrsKm8ZGPWBAzFlhqlWBA188og3z6LIAqZsWzY2U4K63aMXNkze6B2mZ1L7dIzhsq+WHXN8W2p01EvT6gEpj9DwGTgHK7U3r52urnGMY8yzj3fMmMQswRgyk+vF2RxtDWY3LrAtMkUKkrnusuGjMBXbJ0sQ2QMyAKf1kdeHTueurwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pY1x2zRz7frDJyiGpxSqM6p4h0BtuNV2N3sjyDQlu/8=;
 b=nCKa0m8GoQ54+BmWsOmmHnhUpq/QbQk+dOnuTMyWBHroWETBPBe1DvJg+YjIaGLc2vcXUo4uha0MLJSX5Z9vaiUqg9GfsU2L/MNPItOyp/qfCPTv72ywYasxn4mYWqFdL99CMVXV9nZHE0AYkLbnqESAyXLEObYOE0DfmDLGOssvRrzvToUsug943S0MwIKCxvK67YcOjJesX16K7bwygu0uMauPjSWnXyUp2V2P6Q1XiU7el3DWvZxenpPTPIprMfMKt0cuQbd7uUuT+QvnvjN2QNqXXRrg4ireDUlvqWD13YSmlNXIng4Qyk5/YDeklW24ZmZGlvAVkfidc2YBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY1x2zRz7frDJyiGpxSqM6p4h0BtuNV2N3sjyDQlu/8=;
 b=E5Skl6vNx+BINVfwLs473+9jTYkYYgcSLZod2O9T3Olud7/slMHNVKmqsyE3CXv7AKlncBRx78Kxdguh7AzEnaJuoYHU8WAxKLeWsviZWbZHSsocXuBQ3GHXA7rOw819aVn5i/qxcul7PFCeUAqtp9dcf6POM1aveDwJOjXgqDY=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by SA3PR10MB7094.namprd10.prod.outlook.com (2603:10b6:806:31b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 10:16:55 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Tue, 13 May 2025
 10:16:55 +0000
Message-ID: <760d5562-a9d2-4e64-9032-dd4008aeaf0e@oracle.com>
Date: Tue, 13 May 2025 18:16:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/220: do not use nologreplay when possible
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250513070749.265519-1-wqu@suse.com>
 <22cdcf91-92af-45f9-ab5b-dc08455f0ba9@oracle.com>
 <05ac7288-ca4a-4da4-8cb4-54389021640f@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <05ac7288-ca4a-4da4-8cb4-54389021640f@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|SA3PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d22dbdb-5436-477c-48e3-08dd920748a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkpMNkFKbis3TDZoVlo3ZFM2Ui8xRUxQcEpiaE0zaFBOeGRzeFhRR0x4TGhW?=
 =?utf-8?B?OVdPUWFPazQzMlBQYUtQU25Pdm03bExVbXBXUDhWS1lLVDM4MnVteHJRcEVv?=
 =?utf-8?B?ZGk3YzBmZ0hwZEdPeUFPNmE5b0RqU25NemZwai94cXNDMmYxUngzb09lUGVq?=
 =?utf-8?B?QStkalFUUWZkSzBEMFdYdVU3dFNOU3pUTWxiQkZ5NHMwVWFCUHcwL3ZsV0ti?=
 =?utf-8?B?MU5MTngzNmFZeEMzUWFFdUZQaWRXa0pkMWZMWjRTblROQUlIWUROdnNNYkdB?=
 =?utf-8?B?Mkg4T042N2pFb0h5enAzajVFY2NTQW5jRDd2cmZvTmV2VXZMRlVtZnZiejVJ?=
 =?utf-8?B?WmZMVjNKTWRIQzlneXg1MlF6ZlhLeDdlM1IvTXlla3VMZy9IZTVSMnRHVnph?=
 =?utf-8?B?eXlWL0NBZ3BuekpTQkw1YlQ5VTAxMDNPa3AxMWdpbW52Q3FpYU5HUlZDWjhi?=
 =?utf-8?B?a3JDdDhuTzNndWxpaTZMR011MUhFYWpYV0hUYzJtTW1TMmF6YnhFN3U1dlZW?=
 =?utf-8?B?Q1ErWktuWUpwNlgyNEdHRUs0RGlvODhXdkxXRkhlb3duazZmbDFVQkRRaThx?=
 =?utf-8?B?U0xUT2hDdmY2bzRMK3VXblcvUXFvQ0Y3QjA4disreURjdkhwckF0U2dlVldH?=
 =?utf-8?B?MVFRcWRrcE5XSUNwc2NTSnNyRFh0cmkzZllMa3hVN0FCMnpENDczenJqT05P?=
 =?utf-8?B?UDQvMjRjRDJQL0N1ZnJST3JQNW1oeVphbVhabkkybTFCbHR5aGFJSlJqVHNR?=
 =?utf-8?B?NUZyQUxicjlOd0s5WmcxSmZ2bUJmcUlUR09NVW1RS0pyNHQyNW52UmpWNE5a?=
 =?utf-8?B?bTh4QTl6cHpYaFdoR25JSHVqbjhSWHdYdFNHS0JyWjY0K29xbG81SG92dmFj?=
 =?utf-8?B?S1AwelpMYXpNQ0tpRXcreFJtVWNVVytCcklUZWFYM0Z6NDJNVnR4QWFmZkRp?=
 =?utf-8?B?anhoT3NpV2FNUEpKVmoybElqT2JGYmU4dU1YaThheXlyeTlieW45ck1rcFd5?=
 =?utf-8?B?R09UelJ3cUtqMzE5RkNXOENlNjhVZk5HcU5VbFJ5TFhyZnlRYjhrVUJZU3Rl?=
 =?utf-8?B?c2lGOHlIeHBrOG1LTlhaVW5WOEsxUlFzdUl3bEdtbVhaZHBsclczR3ZLMk5x?=
 =?utf-8?B?S1pqeEJjNXordjVyajd3dlUxOG9HaFROR0d6OGljWDNHUmtBdXF1cHNZZ3Zx?=
 =?utf-8?B?dTRaRnptWGdLNGd4d3lVMFpUUUJpVW9KTFhlb2pMcFBSYW1EY0lGNjUrZWNw?=
 =?utf-8?B?MXZiTTVRdmNVVnExQUV4SFE5MDlaRktoUzRyYWoydDh0YktzZWdEcitmNzNr?=
 =?utf-8?B?NWNyVjVSWEd0MVFwQzhHT2pnRDlpRStYZEJHVmRYVGViMm9ZREZZejJ6eTJa?=
 =?utf-8?B?cWtUYlkzQjJ2My9OU1h4MG04bFpIaTdONmIxaUVpUDFLcVMzWDEySzduRDNB?=
 =?utf-8?B?TkM1NUN0RzBpL0ZUemU5Y2VJQzFiemluMVAwU1kzSWQ1aXFNM01TOHI2RVp2?=
 =?utf-8?B?Zy9UdjJTdG9EQ1g3Z0VaQk01NUYzQVpWVi82NzJrNnBxZ2tqTXJDeHVHbHlV?=
 =?utf-8?B?d20yZjkyRkIzL0hkZ09jTzF2Vm9Dd2VWVWpLTmp4eGhmVHVVRjY5Q01UdmQv?=
 =?utf-8?B?S0xuSC9JemFsRko0WUZSMG9ob1h1aE5xQkJXaW5GQWFiaDRUWG9Ib0J1RERI?=
 =?utf-8?B?MlNPSnVsSFFXZlhmZGlSNnJkWXk3a2dOUkxoK2dsQ3Z4TTNWVmRYeTA3ekgx?=
 =?utf-8?B?MDU0bnBkRXZPQzd0MFFmZGhMaVd1d3kwRkd0dWptc2cxcVZRTFdEZVJNVWNz?=
 =?utf-8?B?NkpoMHJhV2ZTZVZVeEorWG0wdGV5enlYR2hkU2E1Z0FLcytZVVRIZTdEdDdr?=
 =?utf-8?B?OTM3Rk91Qk0yU3g1aVoxSU5IbFNNM0xTYXBSNWliQkZDcW8vNHlGRWJoMUFw?=
 =?utf-8?Q?ArojEEDpSPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjQ2TW5RcGZleXR3NDRVQWJjSzIwS0ZlalRWQ2pvSVRmajR3ak5wQXhvUFoz?=
 =?utf-8?B?MUgzdWFXd0ZESlQ4N1BWWXVYWitkM1ZBeTNyM0t5VTZjU2Rwb3hQMitjNzdR?=
 =?utf-8?B?R2hhM3ZNN2JIRVM1Tm1SUVd2M29LZ3Bac1pBaVppY1F3YzY0YlBOTlRyNmJS?=
 =?utf-8?B?OTdVR2sxUHFsMUp0bjZEN2ZSSUdrbE9pdThyNUVWblpQTkh3WFFYc21FcVJw?=
 =?utf-8?B?SDRvaTRjUUR1NmVFenVrb3l1SE1McVBqd3RGbzJWc1A5bDAxKzYwVkNOVGNa?=
 =?utf-8?B?SmhOcVZEYlZqVlBhSVh2cUxWYURacnducThFZWJWYzZEN2NndWExYWttbmI4?=
 =?utf-8?B?ZnFFSkJzMm4rRVBQT0xhOVBpWGJnNEJoUkdiVmcxZXQySDlxaGlrNmJoOXFx?=
 =?utf-8?B?OXFLd3U5Q0ZOWnYwelVXUXBEeEtsWDhYdFA4QkJXek9zaU5XWU91MHBqUjJy?=
 =?utf-8?B?Yml5MS8xRmtzMThxcUtxZU9Tcnd2NGpBR29WMTVUN2cvSUllTU5XZmdjcGJz?=
 =?utf-8?B?OUZlOTB5eXAzSUxKNEhVdmVKWHMzdk5raTdScTVSa0JtVUJFMWtDb1BTODlh?=
 =?utf-8?B?eVBoT0NmTjZLSy9oQWFtT3h3QXdXcEJMaWkxbk43WGFPb1RLZVpTQTQ2TXJD?=
 =?utf-8?B?K29JWmlhVy9CbWQzcnZ6dm9BMFJLUDZHNWlsdmJ4dXZaWkxVNHN6KzkvYm9j?=
 =?utf-8?B?Q2MrSHRMSUowaXpQeGJkVWFRaTFmLysxd0VNSkhtb1JvYzEzcGtTd1dHMUNW?=
 =?utf-8?B?T0g1RC9sZ0ZQbGRwTkFxRUNDRnp1Q3RhSVA1enpMVURGMk1vQ3NNUUdsZGdv?=
 =?utf-8?B?K3dGZFZ6M0hPbXphT1ZkU3FOMlI5NHBYUkFaYmhUd1J1Nyt3bHBuWUFOZDR1?=
 =?utf-8?B?T2E2VjFUdm5VS3ExdTdkejZtNzVuVFVpUXdybnFLMmpIVnV1R0ZaWDR6WTZt?=
 =?utf-8?B?VEttTG42bmRFWEc2UDltU2xydXh3aW1SMGkvN1RhN0djbUNxZ0JTbUxWNXVT?=
 =?utf-8?B?T2MzaS9NcGdCc0xuR3F3bk9yMFRPYU1aMEZOb1VtQnpVYUY4VTFORjRiSUsr?=
 =?utf-8?B?WHZXQXIzUXE2d09wZlEyOHo0eVlVK0MzSGZkMlpKSit6cFVZckJRMzJBV1Fa?=
 =?utf-8?B?M1hubXJJR2lkWVl2L2FsT2IyblNUTzJhblBDMEwrbG54VExmWjliL1hmZmtl?=
 =?utf-8?B?L2pTeVVXWnkyWEtUVEpmMU5WeE1LaWlPYXpKYlA5MmIxZlFwVjFIVWlYTlFT?=
 =?utf-8?B?M2lSUk1iNTUwcGhrM3QyeGhwTSsvb21rTFFOSW9mZGlIVSs3enVaOXRDVk5Y?=
 =?utf-8?B?RkZsQ2NlNzY3YjdwTGw2SmNYRXpTWmJVV1B6aUt4MzJoZkEvU2R4QWtKak8r?=
 =?utf-8?B?cTUyZGJTV1JwdG5NN1RFS1pBQ1hEb1VRUGlGS0RnMHlaTkFtMFNHSHZ6ZEsz?=
 =?utf-8?B?ZjM0a0UrbHZmZGNaOVBxZUpTRTZHTzFPamtrVUpIWlo2MzhjSUtJY0hBK2s4?=
 =?utf-8?B?YmFibHhFaWc2WVpLUSt6d3ZyZnR1NEtLWHFUazlBaWVucXJIdUZ1OG1MeXVR?=
 =?utf-8?B?SmZ5dkx4ZHA3MGVMMURMTDNzUUNBQlcxWHppdzB0WWx4d3FzV3lBazlvWDNU?=
 =?utf-8?B?Q3BVeVZmR3h6VTJoRFE0dXpaUEZRM1BxNGNkelk5Ymd3Vk94UWpSOEZyeFUr?=
 =?utf-8?B?VVZObyt1cVhvYVpLYkZiRXhSYnY3L3d3d0I3S1ovTWNQOHBtdTJwaitRUXN5?=
 =?utf-8?B?dlpuQlpJSFJlUlZSUktsK1VzcHRlTFdrRDhoUkdrUFlFSTlPckhqWTdvM3Q4?=
 =?utf-8?B?ZDErQ3RhZE45UVlLUU1XN2xUWU1aQkVTL3Z4UUJuYVZpSVQ3RkxnTFhJd2lp?=
 =?utf-8?B?VzZUbVErOCtsbmhKQm15ZkRtaVhYY1kwRG14NzRtdEdaTXhWUDEyMnltb0hl?=
 =?utf-8?B?cDdKMStkM2VvbUREdXhxTGN2QVBFMXZvUk1tTXZCT1ZRVlZVSlc1bWIxSkJC?=
 =?utf-8?B?K01mSWt1cE1zQWRSaXBhblp0MFFxdkxyaERMYkhrbitQdnJOSUtRWUNSWXFC?=
 =?utf-8?B?b2IwMlZYTlN1UUw3d2tHN1J6dFVjTUcvZ2trWFBzeklBc3RuQVZ0cUxPeEMy?=
 =?utf-8?Q?diZqDz9asWGHxawo+UltA3yN+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C56NmNjtkflRCKrDxADaqC4/XUEelAG32ixJsP0+cJGN8xK877/hxA7ARUzkFE+nxgvO7Y04nR9qLGWR268HwbqBIAY3S3Q/QhkfnK57E+Qy5IwsUx142BIQ3rw+T5nUu4adOdTOnlBKwjL9ncGRoHb2aOgEPobN1v7rejwKi5T/3tQRCkzFmQTDH1CNI5RBwPlvPzZy+E27bUn1lQZUQGbVrVlhzinAqhLzulqSmCdKF3NVVjjKa3kbi+PHNr5qbWD+ylb1GUsCWzSHCfhlgCltF4xwASfv9JxxmZTIfdzawGNZsz58qCsckM0jHyAmi+2xd9m21v73+++QSAUiSF4NpxcXfwWgnSutgbvFLWSnQmBWnS++2k4KdI5Cixw8sxXZ8sWPgxWTMHYrbAbsmy1sKti+JmdC34A2a1zKFL1MSEU2+yj7gKwE+hTCiykLuhqUN7Y+OyYUFutetCu2qDT/BesA9EpIAF51qnrN1o3GMhJtT36gHhCEDbgjie2+wz9LSouq+0byefipPE+xosE1dnFyjVZvaJwQ2nDKucmkEva9CuCf87LMKNgggeLx8/EVdSrTYPFaoKMY7FiXIpKtY7o+bPRv0/TR3tOrqxM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d22dbdb-5436-477c-48e3-08dd920748a2
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:16:54.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXjaTDS6nCrvGHWy7k9wDJR+knhwANF38UWZrv+6o7jQBYdrTNz2TS0fII2ZLNGzQPgKj48Ljsczh3j8k1x2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505130097
X-Proofpoint-GUID: RRtCzvhKq1LlcXQxvx93nMaClVKDszf5
X-Authority-Analysis: v=2.4 cv=PeH/hjhd c=1 sm=1 tr=0 ts=68231c1b cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=jxzlEsld6jKlo1_wglIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA5OCBTYWx0ZWRfX+R+HGCR6UPUb puULAM5sCIgFH4DU21WhIISgN5YGJMI58Lpe12p2Wj7kAG1CkxtF8eNIWVHdUvu6AMQQBUz7+fT zzvKPrvcTtezx204C0EZJ6eVV1pqPr0o3zFmw8kwWYVxDberkujB0u1y2OzDz+L07CWfU7Mxu2Z
 hcKl7ERVMk1SGE4BtQouHJxLrBPHGn1claEULaAz7+o01vxDJwEZBCcZQ8W+hlPwDyYOKilteKf fCKTfWnrR9Nsj2YOxOPZ6T7SyLM3fqMiL3xICu7v+vz/woq+kNpMUFVyJVWKjx8UZbbPvVNxIE4 gDTclyjdigZOp2eJhhVFlShBAHOeK94ri3eloRD74Pnh1TPPUpYIpGvr9SVCGxMBMg9YhGM0Lw1
 YB3KiwsnjwxBduGyoZqNcQTm2oVBhGx1AcXOBFIjg7u9/S7thdfMeEMgEm/DgZRizmFN4TZW
X-Proofpoint-ORIG-GUID: RRtCzvhKq1LlcXQxvx93nMaClVKDszf5

On 13/5/25 16:56, Qu Wenruo wrote:
> 
> 
> 在 2025/5/13 18:01, Anand Jain 写道:
>> On 13/5/25 15:07, Qu Wenruo wrote:
>>> [BUG]
>>> If the system is using mount from util-linux 2.41 or newer, the test
>>> case will fail with the following error:
>>>
>>>    FSTYP         -- btrfs
>>>    PLATFORM      -- Linux/x86_64 btrfs-vm 6.15.0-rc5-custom+ #238 SMP 
>>> PREEMPT_DYNAMIC Wed May  7 14:10:51 ACST 2025
>>>    MKFS_OPTIONS  -- /dev/mapper/test-scratch1
>>>    MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>>>
>>>    btrfs/220 6s ... - output mismatch (see /home/adam/xfstests/ 
>>> results//btrfs/220.out.bad)
>>>        --- tests/btrfs/220.out    2022-05-11 11:25:30.749999997 +0930
>>>        +++ /home/adam/xfstests/results//btrfs/220.out.bad 2025-05-13 
>>> 16:26:18.068521503 +0930
>>>        @@ -1,2 +1,4 @@
>>>         QA output created by 220
>>>        +mount warning:
>>>        +      * btrfs: Deprecated parameter 'nologreplay'
>>>         Silence is golden
>>>        ...
>>>        (Run 'diff -u /home/adam/xfstests/tests/btrfs/220.out /home/ 
>>> adam/xfstests/results//btrfs/220.out.bad'  to see the entire diff)
>>>    Ran: btrfs/220
>>>    Failures: btrfs/220
>>>    Failed 1 of 1 tests
>>>
>>> [CAUSE]
>>> The newer mount command provides the extra ability to show warning 
>>> during
>>> mount.
>>>
>>> Although btrfs still supports "nologreplay" mount option to keep
>>> consistency with other filesystems, we will output a warning and
>>> encourage users to use "rescue=nologreplay" instead.
>>>
>>> During "nologreplay" mount option test, normally we will mount use
>>> the newer "rescue=nologreplay" mount option if the kernel supports.
>>>
>>> But the following two call sites are still unconditionally utilizing
>>> the deprecated "nologreplay" mount option directly:
>>>
>>> - Expected failure when using nologreplay and rw mount
>>>
>>
>>
>>> - Mount option verification that "nologreplay" is converted to
>>>    "rescue=nologreplay"
>>>
>>> The second call site caused the above mount warning message and fail the
>>> test case.
>>>
>>> [FIX]
>>> If the kernel supports "rescue=nologreplay" we should not utilized
>>> "nologreplay" at all.
>>>
>>> This will avoid the mount warning on the deprecated and discouraged
>>> "nologreplay" mount option.
>>>
>>
>>      test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
>>
>> validates that the old mount option `nologreply` doesn't break
>> on newer kernels that support `rescue=nologreply` and provides
>> a Warning.
>>
>> Why not keep this test line and filter out the deprecated parameter 
>> warning?
> 

> I'd say, if some option is deprecated, we should not use it at all.
> 

It's marked as deprecated, but the code still needs testing.
Also, since fstests runs on stable LTS kernels too, it's better
not to remove it yet.

> Filtering out the warning may ignore some other problems not related to 
> the deprecated option, thus I do not think it's a good idea.

why not something like:

(untested)

_filter_deprecated_warning()
{
# mount warning:
#    * btrfs: Deprecated parameter 'nologreplay'

	grep -v "btrfs: Deprecated parameter 'nologreplay'" | grep -v "mount 
warning:"
}

test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay" 2>&1 | \
					 _filter_deprecated_warning


Thanks, Anand


> Thanks,
> Qu



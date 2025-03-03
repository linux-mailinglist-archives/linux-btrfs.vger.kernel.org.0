Return-Path: <linux-btrfs+bounces-11977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE444A4BB27
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 10:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415E03A6E31
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA55B1F150D;
	Mon,  3 Mar 2025 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dU6Hg+Bm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VzoO/tSp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178911E9B12;
	Mon,  3 Mar 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995352; cv=fail; b=q1P18EPZdRCsflsf4kGr6wauxnqmad0eCrhKXy0+b1QqrwXYqkjeL/67gRDq5zdqAphznYneEuNUfpeOiHDiBSh6ZN5lyk6ZwCxMDV5KhPXXlWVuXqODIrWoJxociNdu8zOG+6OXvjUmImEfiS8n0bN/8CXeajG2wsg2dsANiew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995352; c=relaxed/simple;
	bh=bt49g6MXiGk3UBURLvf9zviwwHhTMqEwXNchZW81l1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eBfhy1HtNZRZH55DAV3MsfcbkU75kEaqCINrNCqt/mEu1ZeTUBZ5ibHl6XptWFAZfkQvuzMPhf2gbfIbeCghAO1P20xpm8IxK3kQljs2g9rCiBoBNXmzzin9c8IiDbhQqzOsqk3IQ4XMn0gxnJMJqSzpuTaqTACMJvYUs/paXFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dU6Hg+Bm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VzoO/tSp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237u174031538;
	Mon, 3 Mar 2025 09:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hs07Gpe5mbG0GlqaqqG8nxkWEsdCFJrZi07ffcJX/CA=; b=
	dU6Hg+Bmq6aTMY0YPTPphJBWyTqgPjr2MO+c7jAhPkwnZiaWLCpKgdHY+b6pk+tW
	SejiYFM0Lz660HA10sG2t6V31Ctvrj232kdfhy0sgbGTuldw+f3P65IB37D3MEnx
	ewcWIShwyi/PbNUgaOpuHLZljMu68fhTUVQsAwTvU7vVVVARFpsHvLafmCeLNlGe
	Rd9DuDnussJNNuJT6hYXs90bTx2cUpffOe1YeoyVRxRW5+L871diKhiChhWSI+tk
	Z0YF+7Jn6g8gp7eA4mtdZIq6cHw+czHic200f3AR72IuiKt8EmHViTGfCIRZX48x
	yUBFQzQMOj4AJtT8sU+edg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81t933-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 09:49:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5238JTvE039727;
	Mon, 3 Mar 2025 09:49:06 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7yx4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 09:49:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQQT22CyEzvqcAD+YH6Qtx5cX4zoiBa+7dBNJvTcDk3/QK639yIVvjeTofch35La6as73eGT9uVNhwsD9UIAFRPSTDd8CibWDJdrpiVaTdzHPma4TiB82D1zSi2fWsR1q/0JbBfGxOL4HytdYQvrMt28KKa5ZkU9aTMHxL7cY8XHHfNASQ8FZNRH/IwzMWfCkkyR1yBLSY599Kr29aMjf9F7WzaKQW4mkBUS4YA9DVwYQDU9NiCJroywZHfAZW5M4l8hchRW3KWF1jWTHpFe519WV8UYAjWfuhziQtWZ6QOIwiAGqCgr61+wwIpaOJElWfjedYxCHwwn6cGKLPuOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs07Gpe5mbG0GlqaqqG8nxkWEsdCFJrZi07ffcJX/CA=;
 b=aBSM6nnVZDTmVqhdXhoKaAv3hgA1TPY9GTEzv67KiWdcMBPSzlNJY/hywxhr7pTrzk6hB3dgRv6qHtVQq/iILcftm8o7vWOkoJ3w/TH54eTStyKvJfWZECvrrTzCRc04SDWYpqWt14hANrupN1xiWv67BU1blGD161lqYscOVT7wwUe90p0pUs+qzlM3jM0DqLYS3AjZUIq0eoj9sl9JWVC/xTAhHM0Lrn5W5K5vpvIV/VdUsxo4r3Awyy9kt7sOZP9m5KxD+pa5jTGf2SbWOwghb1RGv2tdq0dm96xiUPM39ppExH52ruA15FRMnVzJXVw0kiggKqQMgJT1AjJA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs07Gpe5mbG0GlqaqqG8nxkWEsdCFJrZi07ffcJX/CA=;
 b=VzoO/tSpv6M+ztPppnRUrTGCfy6bpP4RinPH+tj7pUXAm6TkHSzMFCypcSgEu0s4+Qy9ZwIUMLAAUES6YThX2Rhb+uNpfkyR3WSCNLiNiedaAJ1WCsuhDUzI0InzR9Hc+wwRU5tOaZ5sWeHAXNfN0iZnUZlNFWka4Wcp/UD8CXo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5033.namprd10.prod.outlook.com (2603:10b6:610:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 09:48:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:48:59 +0000
Message-ID: <9a47b242-2013-4d39-ab95-ce8777dde995@oracle.com>
Date: Mon, 3 Mar 2025 17:48:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/080: fix sporadic failures starting with kernel
 6.13
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Glass Su <glass.su@suse.com>
References: <d48dd538e99048e73973c6b32a75a6ff340e8c47.1740759907.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <d48dd538e99048e73973c6b32a75a6ff340e8c47.1740759907.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a6ba66-a027-4f7e-57d5-08dd5a389f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S01aV0RHWFlRSEVEV3NoMmNHQVBTMU5ZZVYxbzNPRDRkbmlWd1FlcmVOdG5x?=
 =?utf-8?B?Zk5IREk4RTU0WnVEbHNxeUNQUmRyNWpQQzdSQVFqdDlXQms1MjBiaVZKQWpp?=
 =?utf-8?B?T0xFSVZNbVpNdXVhanNmMXV4Wmd6RkZIcFJpWTFBdmlwa0k0WStNNjNBZTlu?=
 =?utf-8?B?R29KcUlRbjJQL2xUL1BvbG1qVzJXNm1XcTdzcENHVGRZMCtsQlgra3ZpbWFX?=
 =?utf-8?B?dkxndEdvZ3dTT0wrT1RIbmU0dUVFODM5SnBRb2FtVzFJcnpwR2ZNU0UyWkNa?=
 =?utf-8?B?NmJLbGZPTC9icDdSdG9BUVNGdXpLdEF5end2UEhTVXBERzVhY3JFODZWeFNi?=
 =?utf-8?B?YlB0RlpGcUl6djNIUG9QZ2hyYU53Y1dqNGNJcFo5NWVZYnU0VWFZZU13ZTJZ?=
 =?utf-8?B?Zkt1cFlVaEFGeVN3cWlnQm1tOGljZlQ0b2oxTFJFMW5DQ3ovd2RoZkNSdWNK?=
 =?utf-8?B?NWdhd1BlU0hhT1V6RFhZY29zV3NIdGR3Wk5DbVNBY1VhR0l0L0kwOGZrTktp?=
 =?utf-8?B?VGZjZU9YN2cwazYyaEFQRVluSlBxMWJiR1lxUGljam9UQ28xNVlndGtLdkNL?=
 =?utf-8?B?OXFjZWdsT294bmc2cXlUYVVIZGVpTHVuNzZWSm1LSFgvSkNHb2ZHUlVaMEo5?=
 =?utf-8?B?U2MxZjlxV2JYOGt4Nk1UZzIybkVmOGhKRlUwWnphc1plSGoyUWc1cmdaTklK?=
 =?utf-8?B?Rm5GZkJQRHdKa01NVE11Z2ZFZm5oM1lCdkpiaGZqVHdWRnYrbHZyNFNpN2Rq?=
 =?utf-8?B?b0tKTzhDR1U4SEp6bDZjNGNycHhjeWpWZUZxTVozOUF5UTdrYnhHVjFRT2RU?=
 =?utf-8?B?dDBLZ20xK2M4aUVSWFo5aTNQLzhXQklMSUZhM08zWm5RQTVrcVhrSUxJdmg1?=
 =?utf-8?B?aVp5SUxrMlVqNkZTRG0yVzlaZFZEaWI0SlpoSU45aXNDYkVIU2hQajJOV3lK?=
 =?utf-8?B?VTlmck5CVjFnSlJqV1JwNWxXOTVGWGlVdHJibjJqN3ZIY256Vnd6TlFYYlRN?=
 =?utf-8?B?UW5NU3RnSTB4ajM5SGgyQlpvYnQ1REZMSkVXalprS3RmSHdpQlVDSThBbWVr?=
 =?utf-8?B?aG1wYk5uRENEZWY5QzVTWUZ4b2dzOWcrNURNWFltNldWeFhSa0FjRHRvL0JY?=
 =?utf-8?B?b1BKR2ZBU3VHWUljdHFoYi9DZGFWUlYxWVorMkdERzhidkRFN2pROXppTVY3?=
 =?utf-8?B?YlFPc0h4Tm4wQnVQdEpKUXA4VWR2bk5QSmswNC94cWozSU9jd0s1dU1WUUV2?=
 =?utf-8?B?RWIvVVBoeUl3QWNnT1NQakhuZVRsKzk0SzE5bGx6VXg1RlhJMEhadmJnK2xy?=
 =?utf-8?B?ZXV4eUdNVmlxUUxsSENEQlJ3YmY0Y1kwbGh0b1NhYzBSVXpKeGpHTjhHZE1E?=
 =?utf-8?B?S1lCU0g3Nk1EQXZubzdGVnNlRlljcS9yUXpQeERZT21oczRqaFdwelUvd3FV?=
 =?utf-8?B?TWZ1c01VUVhGWWJMRGZPamZVUXVCTHRBK3NpRGQ5RDFKS2dFTytybS91RGRq?=
 =?utf-8?B?WUVQV1k4a3JLcWFleEpkUHgyZEVUcGU4S2hCVFF5SEJqTmQ2YkNyZUthTnBt?=
 =?utf-8?B?U1lLV3NXNERHZlArTDBwcjN4Mmprb2JFM3doTGxIRnZJaWVPaTUzN0JPSDhl?=
 =?utf-8?B?TFZXNExTMTJ1VVJhUTlMUmVYcFZzQjlMWldhSmhIeDFlN3NBOHcwSzhSN2ds?=
 =?utf-8?B?ZE8ycG9qZ3Y0Yjg0cmljdnh2TkZCMkZzYkZQUENRNFNRbDBKand1bGNBWDJN?=
 =?utf-8?B?YUJQTHV0bE8xUXdLWFNVNVU2VEJHY1gwT0pOQ3YrYWxyU1VYdExFQmZqcjdN?=
 =?utf-8?B?RjZ0UmJ0N0NvbVZYNVlZQmFwY00rRkxUbUttRXIwcDNsckF0dXkyUEVJYUkw?=
 =?utf-8?Q?susxamkR2fLS4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUxpejltcVlPa1RaNEx1ZkN2aGQxRG1DUkM5Zk00SVlneTZHRmlNRjZxNG1S?=
 =?utf-8?B?TXI3dmxlRXdaYWw5TlNLZ3F2UDZVWmlnMkdoZ3JSQzljUkpIVTFBUDZBQWxm?=
 =?utf-8?B?VVJFWTdUNzF3TGE1Qmx2RTJBU0N4UTV4bWZ3VXJaTDdhSGV0RU9DUUJEN28w?=
 =?utf-8?B?SW80NWkrRUw1RnFNRFZLOFdxVmVjWVJad1cwRTVFWU5PSHg2eVFOUi9uRkEz?=
 =?utf-8?B?WGFSM21qdHhyQ1cwZHF6cnlEN3k4SkZEQng3RlBmS1hmSlRWcnRFS2hzd1RQ?=
 =?utf-8?B?NFYrRnFTdENqcWdMakJmWVArNzlRZEFBU3dpQ2gzN0szbTVGa29Uak9UWnpL?=
 =?utf-8?B?S2VkbWlFY1FvTGlQU2F2UXRXNUc5dDhLNDBMeGE2SHhHMEtlbzJ4cHF4ak5D?=
 =?utf-8?B?V0xIRXFIbWpkT2RVOWhoRTkyS2F0S2hIRFFLZjlrTGJtTzZGNXhSZGRhbVly?=
 =?utf-8?B?RXhEUVl0Ui9ZWkFBZklrVytCdktHTjhSdTNFYXRSTVoyUXVwYmdEZDQxcGls?=
 =?utf-8?B?K1dHQUFydVcyVDNkYUdqZFRiNVdwQmdlcXhBbkFGNXlmV3JueHhoYWM0U05Y?=
 =?utf-8?B?TWJNc0FPN2N3SVQ1RlJHWlZ4Mit1TjlVWHZ5Z2ljS1hicXVRUlNIMVJqMCtI?=
 =?utf-8?B?Q1dYZ1Q5TUJSZU9pSytrU2dvVC93Q0dpQzVEYVJvY3ZJZCtja1JOMzYvakRj?=
 =?utf-8?B?VHN3dWpUQnJ5ZU45NWd5Vy9qNkNJMlRsdktvN3l3ck9BSmVYc1ZPMEZ4Z1dN?=
 =?utf-8?B?UTU2bDJtMEd4TjEzMHNoVng2WjFkdjNsdGRad29MQXhXaUdoTHNNQXBWdkJO?=
 =?utf-8?B?amoyejRTTlIwcnpkZXNYbkhPUDdHZGwwMlowNkgyWDYzdlVxSmR5SUJsTlhG?=
 =?utf-8?B?SERORnNlTmM1ZVg1N3krTS96Q25IdGFVSDB3aXFWMC9KcHI4ZFk5SFFCd3g3?=
 =?utf-8?B?ekRVV0lWeWROSGRMeFZkVkl5ZFhTOURiZ0Nwc2E5dmc4b3ozb3MzSHkrRENZ?=
 =?utf-8?B?bnNhMFJiVXdtRmNtNXlDa2RPbnFpNWdVQnd3Vitxa2FJMU5XcHM3MkRjSVdH?=
 =?utf-8?B?a2xQWFdvcHJTM0NRUnNERGlxQTFham5oU0VTSGlubmd3U29iMnhBUUhyNmN1?=
 =?utf-8?B?Q0hWaUNOZVZBRkxzZ1FNNDVWSzVNZVFMS092OGExK01MMEk4KzRxQjVmM0k1?=
 =?utf-8?B?bkErVlR3UklqVEhxK3czR1RZeEZCZGwzTElrZ3NPQXIzMlhlM2k5VFBzVS80?=
 =?utf-8?B?T1BFNnZIalZIRitPMVVxVjZ1VURZTzVzNUxPa1J0ZXlMV3FFamVDUVFSdWJD?=
 =?utf-8?B?aEVFWnN2OE5BeStOLzdlR1hIRk1tRTVMbjJTejk4Q0VPUk51clh1RU4xbmM5?=
 =?utf-8?B?YjJrZGhla3Q2OFdXZW54T2pMYkx5cmJ1UjhvanIrOHd1MjNNc0dTNUlpOU9h?=
 =?utf-8?B?MWFmeEVVLzh6QVlsblpheWF5YlV0R3UwdFpFM3FqNVI2dnhHSTdhNlR3dzJQ?=
 =?utf-8?B?THc1cEFVNmM5Sm8wUlFXTThMTlZ3TFN2L3RVbnpMb2tpWWZRUEZ4elJ0a2w3?=
 =?utf-8?B?bkRGaVUyWUMvOG9JS201YlhJbkZvNjRrSFlISnAvNlJId1lhU3EyYmxxVlZh?=
 =?utf-8?B?MDJURU16bFJuZDE1NUUwbklHdzF0ZkZMblRUeGs2MW5GRWttbVZ2VDAxQm10?=
 =?utf-8?B?eHFGaUtGMUMxaHRENXFvTjdvWGFLZElCVjB2Nk1rQWh4d1A1SzdsYy9aSW9E?=
 =?utf-8?B?VTVLQzliYnVGZUt0WGJUdDBQMTBFVWh3VXBwQVJqMXhnMkxnUFYxUEtnU3R6?=
 =?utf-8?B?aU9Sc0M4N1N4cDF6TnBPeU9QS042aEJwSWsrYjI5bllQbVpZcFB2WkdqeVdH?=
 =?utf-8?B?RHRJZGN0STFIdXUzUDZ0aG8rVFFYL0pvZlNnYzRlRVZtM2F1eVhjK1NEZ2h0?=
 =?utf-8?B?UmVtYmZwZTlpa3h6cDE5TlJCYkVzLzVKRUZ0UzdKL3ZITzVSTEJhdGRUSUZH?=
 =?utf-8?B?MytrYUdDT09GeUlOdkhKbmpMNjFmTU5neU1Zb0NPQWNNakNYWXRhZ3MvZGJI?=
 =?utf-8?B?OWlVWVI4aEpvRXB5dmo0bTB5Z2xnKzdrYW9mcWFxUWV1aG9GQmRZK0lURkRj?=
 =?utf-8?Q?TVUukh7KpyyL4q7u0mIJgpr5z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ROe7/ym67RUvI3jDsiwGu7ZvdBbUTNw5NjqUnZ9wxrTLadyLTHu4yfJ1BXmeKBMOKqgQr2T0bpzirUOjw3UFO510lNCIOb0pEmIPSr2Ytff4ZN8qLNo/EZw/r72GgcPp5EuVzrBSBdAP4+P3fz+9+B86V+S9yBtf2jp5baZAz1ZIozHWlru7H6qWWeBBufYoMbBfzCCFzFHkyBlqlOBqv9qOM0vVmGmeKJxZi6P9k+VoRPEUeZhgS2tLzVaCYMvZHPa+AXeq+m06CZslQ/5qoSa2aRpK8h0SE1sqNCmSaTiMVo7VTJtA8P572EPfGoeMyyA7gP/VPY/wVCTzuzJIK4lSnmTROQeKInmP2m714I4+4PJufrcmFRvKL47o2ZXmg5zGdiPuZAxY+Ndtpg3kcQLgJ9KUpEvT0dXoo1o4M5HwTWwxvdUUlY0qK0o/mwUNIepI3TSorsjQABbUmbmUGCuY09VQFBpGF+R08SclNiJu7szT2O3uv9iO3eU3b/EXbl6sWdPqBT8m3WWkMQy94syAQIwq924Y9cljjoKhZBqAZ3g/BydJpiktlg5K6PPEZs8zWDzr2BhaLRYtwYxDlKeAtXgc6AbLjU9DPZaMb7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a6ba66-a027-4f7e-57d5-08dd5a389f51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:48:59.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6ji2Jz0Whry61+7NRr9qeudOxhDZT+knpV3CINRSG1LSDHNEFjwMSRssE7EqNS7bOwd2ToUaIoDFLAujNHvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030075
X-Proofpoint-GUID: n1lvwsNs2KY-JYZtEqIO2Ov2HPt4vEfx
X-Proofpoint-ORIG-GUID: n1lvwsNs2KY-JYZtEqIO2Ov2HPt4vEfx

On 1/3/25 00:27, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Since kernel 6.13, namely since commit c87c299776e4 ("btrfs: make buffered
> write to copy one page a time"), the test can sporadically fail with an
> unexpected digests for files in snapshots. This is because after that
> commit the pages for a buffered write are prepared and dirtied one by one,
> and no longer in batches up to 512 pages (on x86_64), so a snapshot that
> is created in the middle of a buffered write can result in a version of
> the file where only a part of a buffered write got caught, for example if
> a snapshot is created while doing the 32K write for file range [0, 32K),
> we can end up a file in the snapshot where only the first 8K (2 pages) of
> the write are visible, since the remaining 24K were not yet processed by
> the write task. Before that kernel commit, this didn't happen since we
> processed all the pages in a single batch and while holding the whole
> range locked in the inode's io tree.
> 
> This is easy to observe by adding an "od -A d -t x1" call to the test
> before the _fail statement when we get an unexpected file digest:
> 
>    $ ./check btrfs/080
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1 SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/080 32s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad)
>        --- tests/btrfs/080.out	2020-06-10 19:29:03.814519074 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad	2025-02-27 17:12:08.410696958 +0000
>        @@ -1,2 +1,6 @@
>         QA output created by 080
>        -Silence is golden
>        +0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>        +*
>        +0008192
>        +Unexpected digest for file /home/fdmanana/btrfs-tests/scratch_1/17_11_56_146646257_snap/foobar_50
>        +(see /home/fdmanana/git/hub/xfstests/results//btrfs/080.full for details)
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/080.out /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad'  to see the entire diff)
>    Ran: btrfs/080
>    Failures: btrfs/080
>    Failed 1 of 1 tests
> 
> The files are created like this while snapshots are created in parallel:
> 
>      run_check $XFS_IO_PROG -f \
>          -c "pwrite -S 0xaa -b 32K 0 32K" \
>          -c "fsync" \
>          -c "pwrite -S 0xbb -b 32770 16K 32770" \
>          -c "truncate 90123" \
>          $SCRATCH_MNT/$name
> 
> So with the kernel behaviour before 6.13 we expected the snapshot to
> contain any of the following versions of the file:
> 
> 1) Empty file;
> 
> 2) 32K file reflecting only the first buffered write;
> 
> 3) A file with a size of 49154 bytes reflecting both buffered writes;
> 
> 4) A file with a size of 90123 bytes, reflecting the truncate operation
>     and both buffered writes.
> 
> So now the test can fail since kernel 6.13 due to snapshots catching
> partial writes.
> 
> However the goal of the test when I wrote it was to verify that if the
> snapshot version of a file gets the truncated size, then the buffered
> writes are visible in the file, since they happened before the truncate
> operation - that is, we can't get a file with a size of 90123 bytes that
> doesn't have the range [0, 16K) full of bytes with a value of 0xaa and
> the range [16K, 49154) full of bytes with the 0xbb value.
> 
> So update the test to the new kernel behaviour by verifying only that if
> the file has the size we truncated to, then it has all the data we wrote
> previously with the buffered writes.
> 
> Reported-by: Glass Su <glass.su@suse.com>
> Link: https://lore.kernel.org/linux-btrfs/30FD234D-58FC-4F3C-A947-47A5B6972C01@suse.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/080 | 42 +++++++++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/btrfs/080 b/tests/btrfs/080
> index ea9d09b0..aa97d3f6 100755
> --- a/tests/btrfs/080
> +++ b/tests/btrfs/080
> @@ -32,6 +32,8 @@ _cleanup()
>   
>   _require_scratch_nocheck
>   
> +truncate_offset=90123
> +
>   create_snapshot()
>   {
>   	local ts=`date +'%H_%M_%S_%N'`
> @@ -48,7 +50,7 @@ create_file()
>   		-c "pwrite -S 0xaa -b 32K 0 32K" \
>   		-c "fsync" \
>   		-c "pwrite -S 0xbb -b 32770 16K 32770" \
> -		-c "truncate 90123" \
> +		-c "truncate $truncate_offset" \
>   		$SCRATCH_MNT/$name
>   }
>   
> @@ -81,6 +83,12 @@ _scratch_mkfs "$mkfs_options" >>$seqres.full 2>&1
>   
>   _scratch_mount
>   
> +# Create a file while no snapshotting is in progress so that we get the expected
> +# digest for every file in a snapshot that caught the truncate operation (which
> +# sets the file's size to $truncate_offset).
> +create_file "gold_file"
> +expected_digest=`_md5_checksum "$SCRATCH_MNT/gold_file"`
> +
>   # Run some background load in order to make the issue easier to trigger.
>   # Specially needed when testing with non-debug kernels and there isn't
>   # any other significant load on the test machine other than this test.
> @@ -103,24 +111,20 @@ for ((i = 0; i < $num_procs; i++)); do
>   done
>   
>   for f in $(find $SCRATCH_MNT -type f -name 'foobar_*'); do
> -	digest=`md5sum $f | cut -d ' ' -f 1`
> -	case $digest in
> -	"d41d8cd98f00b204e9800998ecf8427e")
> -		# ok, empty file
> -		;;
> -	"c28418534a020122aca59fd3ff9581b5")
> -		# ok, only first write captured
> -		;;
> -	"cd0032da89254cdc498fda396e6a9b54")
> -		# ok, only 2 first writes captured
> -		;;
> -	"a1963f914baf4d2579d643425f4e54bc")
> -		# ok, the 2 writes and the truncate were captured
> -		;;
> -	*)
> -		# not ok, truncate captured but not one or both writes
> -		_fail "Unexpected digest for file $f"
> -	esac
> +	file_size=$(stat -c%s "$f")
> +	# We want to verify that if the file has the size set by the truncate
> +	# operation, then both delalloc writes were flushed, and every version
> +	# of the file in each snapshot has its range [0, 16K) full of bytes with
> +	# a value of 0xaa and the range [16K, 49154) is full of bytes with a
> +	# value of 0xbb.
> +	if [ "$file_size" -eq "$truncate_offset" ]; then
> +		digest=`_md5_checksum "$f"`
> +		if [ "$digest" != "$expected_digest" ]; then
> +			echo -e "Unexpected content for file $f:\n"
> +			_hexdump "$f"
> +			_fail "Bad file content"
> +		fi
> +	fi

Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Applied to for-next.

Thx.


>   done
>   
>   # Check the filesystem for inconsistencies.



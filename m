Return-Path: <linux-btrfs+bounces-15788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E5B17B11
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 04:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58911C27583
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 02:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079BB78F4F;
	Fri,  1 Aug 2025 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PiIcdiAq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yT5RGjmy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40120376
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Aug 2025 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754013745; cv=fail; b=lMIvRF+wSBlgX/PgWX8hiKssf8OhMjTCBPAhNZcCto1MQYvS6PCAwk8kn8gNgDBJqw3FFwxZWQR3+OHZWm3H5NTx5Lw0T+tsB/eeyiuu2Bd7/dgUk1cctPNnihtKLEBwZXrAUIDkmiy00vi+vnVSZSdfBlADPxxHRyGbwtoQI9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754013745; c=relaxed/simple;
	bh=bW2uXDxHuJRhWSz8HLpHicE+81McpW31GtWUuh+5YdI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T5/0LeUGpIwHFvLt2pLm1h5OF4Z0GQFQxlkS9GaDt/dd/coJ9EG0saJba6Log0+ISZvW2mic9H8dQ2c8zgDydFwvW9PfSxI2zBlHtpjq8GJ6FW/5LCQ3mgB7q6npxRHiSqW6s5xFqap7d80QRBanMYdzhN/JM5nmQMtPh15tkpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PiIcdiAq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yT5RGjmy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5710TBQc002685;
	Fri, 1 Aug 2025 02:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0GvieiEfRseTZVbBhUlEWT49mZ3pjb8ZPCUViEj1Lj8=; b=
	PiIcdiAqmwdn9d5yWxfZZySwpyZyxEiHOPxNXK/f6YqsP3hTP2G8MEYFMcA1fzDC
	FD0chmK6jqldniMJ3AaNSVQnTj8A8ldjW4aoqZ9ZUgR65leFA3/VVaWsj8lz6D32
	Q6wrx59Uh6kuUMcFgbZ4p/JPpEA3ZN8fIPBxDveOAmOGmMwx8SEEX9h1/6HMu5Ln
	SHU5BoO1PhIwybtlFZCbfNwbYZxiNSEtRAphap2nTkqyBFErLb1n2y6N4+OW5j2F
	7xSq7FbCf7umxkt9qvD06vjsU3FFEcCZBSkolJBB/WoctEd8Bt7eKSTZTHDIpbrz
	tHY9EgLctR6/X4ESiJeSyw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 487y2p266d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 02:02:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VNSMli020495;
	Fri, 1 Aug 2025 02:02:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfkh7pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 02:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOsPJbJcROnCLOVlbejdwgmXbP4ysbRWJwrLoEi60QbEx57luyqpZNfuJTRDC85zGOwn+6q6bMGgg/nOGv4RLeuEJQZgwaqrgVev9W9w7evfjkpa3bIm12jV7y29YDTz/NttxEXEM7y0ACFqFSERYv9b2EVvV+Pi/GxUubjOFuBCdjtfw8fuwWRB8i8MHeZIk8ZaPW/pEp4sIMAkwejJRhGPijuaM2x18IFL+U4TpUrpFC+s9AtLa5AqClycWaAbBrrHOxWoHWHb32+idPD+OSu62bZLDQAa24AydCKiIFoh/KYUXHTMs5D8fXOdWoe6OdIpe85QwT2GxAXDrWXINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GvieiEfRseTZVbBhUlEWT49mZ3pjb8ZPCUViEj1Lj8=;
 b=ncAMumlu1FfAkWEsvZbwYTGOjfOQl1ZJcORzgCcMhFaWaGczhXePXE07DDLzysmoJTwMinFwr78HwiYN8lvj+TUs52whN6qcwYxZ/C7ucXYGiOT6Zj5Xju6ZgK/rEue8zANUK9NxuCmtUzhPCppJUnBP7NdN70sKgToedjkVXQBkSY1ioO5/JcQC7WexX4G1LODOunjUUovuUl42VwPrvsbw5cba1ZRD5eF3HpvMm2fpKGpWf/Fd1z+oyMwOxtyEmJZjIwwbbiAWsmXJuIAw3UGq5TP44OWuMWERXzy764yK0yFSXieBg8oOidGF2ZUQeqkuPUqVXB3uD6IB1hjCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GvieiEfRseTZVbBhUlEWT49mZ3pjb8ZPCUViEj1Lj8=;
 b=yT5RGjmyjiWdYaNeMTkBaKMMpxw2y8iqZdH21FcGrXsExweTJMRsnAkTFF+marLmyKcYwmdM84z47MSGnHTfsr2/KLJyL4ebO09fIpxP2JP4Ooq40yP6MILBTzZmcI3tlp5z1snw/4pMxM4/eVxUfcqrSVuPGGKkkkSc8icA8gw=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 LV3PR10MB8203.namprd10.prod.outlook.com (2603:10b6:408:284::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 02:02:18 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 02:02:17 +0000
Message-ID: <2caf7678-cc5b-4086-8ce6-25e53dc69cfd@oracle.com>
Date: Fri, 1 Aug 2025 10:02:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: use zero-range ioctl to verify discard
 support
Content-Language: en-GB
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com>
 <yq1ldo5i0jn.fsf@ca-mkp.ca.oracle.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <yq1ldo5i0jn.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::9) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|LV3PR10MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3baa93b7-ec05-474d-6f6f-08ddd09f70d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVdWMHpzK1ZPMUpWUWdZUmpvTnNxVkljanlKVFdjRHA1VnZpZ2tzdDNudWFs?=
 =?utf-8?B?WFdwazRSalNTNkFRM3d3QUVEeVhNdDUyNDFQRlhJa1Z1UWl1bDFYMXh0bjQ0?=
 =?utf-8?B?emJ2UUl1ZTYzSExOMXlab1B1cEI4MUM0Y0pZY3pLMWlNNHJlSU1Sc3M0bXIx?=
 =?utf-8?B?Zm9kenlta1htakdReHNrZ3dyVXg4c0ZjYVg1eXZWalNpUFA3ZFYvaXBUdENS?=
 =?utf-8?B?QlZ3a1dGY0krb3cyNUd1cmlQM2pVK2FZRWoyOUNFS3JNSXR5WHBLK2dQS3Rx?=
 =?utf-8?B?ekRyVmUzbDZ1dXMrSmo1c0xLZ2Nxb2ZJNFF0UDBzcWtEbnZqUG9ZTHRLYUth?=
 =?utf-8?B?MjFTbTdHdlk3SzJBc1F4ditGcmNsajJrV29YaWVHUnNRZzA1V2xrSWxPRmtY?=
 =?utf-8?B?Zmc0T2pkWFQwYU95SGRqM1lYaGVVWjNpNStDM1lpcUd3ODdJMU03YUVpVmRP?=
 =?utf-8?B?blNYOC9PblRtMUtEeTh5alkxcTNKaSt3RHlVV010RWlXdDJGM1k5ekg0MUtV?=
 =?utf-8?B?VnRhaVNud1g3dHBSaHNlZUdVOTRsMkw2NzZsazB0UmRNZmpsRlNUQW9QR0N2?=
 =?utf-8?B?emhxMC9tWThDY3o3NC9JMkxUQkV6NGlzMGVFb3JFd2x4MUdBK1phNDRKdHVN?=
 =?utf-8?B?WlIzYjV3VXVZb3BrTDlYRDBPSTJFQ1h5RTFwZlFCN0JvZ0dmM1FYS21FTWFq?=
 =?utf-8?B?WmNBRXJTMWM3R200NUdsQmJocXlEenpreDJtVHNucHRMaUpZbFRzQ0xzcFR3?=
 =?utf-8?B?N2VwL3F1Y1V4QUVqV2lrWWN0SnZlVUdFVlFmR0hpZVI1Qy9MU2JIMDZ5cUsr?=
 =?utf-8?B?VE9CU2QyNjNYcGRVcGsxdzBaYzFZUWIyTHhZUDhtMGgyd2kycTZSU3RpWG1m?=
 =?utf-8?B?NGFDaDdXb1AvRU1KSHRYZm8rZWlaL2Q0Rks1eUc3eW9oS2w3NVY5aG1Tbmdm?=
 =?utf-8?B?dG9DMU1pajhlN1N0MXhQVlNwdVBWK2k2elJPUmxFa0dLbldvQThBamlPMk1y?=
 =?utf-8?B?VEZjemE0LzNZaFp0K0RJYXB1Z0tnblloL29pTW1JUXRtQThoc2J2Q1Z3WXNE?=
 =?utf-8?B?Zm5jbXZkQXZTajJFVkhpZnZKZnk2WGdqa3JDcXczOWNiS1JFeWlTZ2FWc1Zn?=
 =?utf-8?B?N0hYSXg1b2MzaCsrdTRsaWdpTk5ueUwrNnlUTzZzU2tnemh0OU1YdGVGaWd5?=
 =?utf-8?B?N1FqcGU5VWt0RjlqWXFQZVJDN2tJdm04Sy9HMHA3N254MFRJTkxzelNjVnNa?=
 =?utf-8?B?SVJiSERHK3FpU1d1R3lXemhRYjBoUm0yaTJ4TzhDazRQVXVpbTRSUkQ0RTNq?=
 =?utf-8?B?elNuSkwreE1vWllnNFpJS25MNDZCcVpabXF5ZkxycVJ5RHZCV3AyelRORVBD?=
 =?utf-8?B?T3o2NDl5QWdDZmdsQ1k2YjAvYU94MHVwQWZsa0E3VzE5WEZIZE53bmFOVEVK?=
 =?utf-8?B?b3VxREJTNWJWRVJlbzYwdkJTK1RKZThpSFh3MDhkdlZLTTJpVFRvd0NYOGxD?=
 =?utf-8?B?dXc3WlB5bi9naEh1SHI2VG5SSDNXVHMvdG1SQWFWRVA5ZXVkSGdNTkltRG14?=
 =?utf-8?B?MTFaTDNFTFhWSEE2dEZMS01KaVpSNG5zajgrVUp3eHROWFQ0VDd2WjY5Nll4?=
 =?utf-8?B?Rzc4cTVlUk5JQ0Y1WHYyYlhyRmNXR1JSUTA1bFZlRGRpNENrZStNdGhxTDZi?=
 =?utf-8?B?aUI4eTQxMVhFZHBxQWh6NSt4ai90RDlnMlRrSU1RbzZBdmEzTi92d2Myc0RW?=
 =?utf-8?B?ZVZkaFphWnQ1akRuY2IweE4xQmxseGg3SUpmZVI3L3ZIM05ENENSTVlRaUZl?=
 =?utf-8?B?UVRRdFhlSWZmZmNaR3JORGpnOXQza1pFNnhkeW5jQUQ0dkhWOXJnZVFmdnFk?=
 =?utf-8?B?OHY2eXhwYVdCVUNTcFREMThodzhNSUt2Rm9pRWFLTGZkVmRWaktKUHhFQTVF?=
 =?utf-8?Q?VcHOFMMPIlE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OExkVVVyU1lnbDRaYUptaVZNVlFseVIyc0lBTHZrOFRhZVc5QTN4NUZ1djVY?=
 =?utf-8?B?dEdaNFR0S0VTVndiaGZBbXVDUklCeVVlbStYR1IxNWR4clN2YkFoSmo0dmc0?=
 =?utf-8?B?MmYxZGxOUHlRbFpCU0xsZXcyekxnR0FzZnBCdFk4elozLzJraFVxdkJyeFdm?=
 =?utf-8?B?c21Eb1R6YzVpeUFjZUlJRU5Yc25BdlphaGNHMkFyZ1QvaWhXRTVTOWltVmw2?=
 =?utf-8?B?OFNSZHpyYlp5bG5mSkRTSnFaTWg0ODdvdHRnS282RlYwdEd2M1hMbm5EZWIw?=
 =?utf-8?B?dEhWaVdCd0l2Y3VaNkNWWmp4eTY1cm0xc2p3bE5RcXZ3WnRRcW1obzI0dGt5?=
 =?utf-8?B?YWtZaFBWdURVcFBpMGxSK3ZqclZRbFpXODFML1p1Q2VmOVZqZTI1SzMxck40?=
 =?utf-8?B?VXlZVUtBZi9rRHFRbVhPV1JPM2I5UVh3MUZ6cWkzMG93WkxsUjR3Y3MyTWdP?=
 =?utf-8?B?eVJtSHdyL1VDY2V4UnYyZ2NkYkEveDJUS3c5NE5LamFiZjJKaVF5R1NEa1Vs?=
 =?utf-8?B?SDQ0SHU2ZmpadXNMbXdjZnJ6Zjg5a0Fxdlh1WXZsUHhCVDgvenhpZWxUZlFR?=
 =?utf-8?B?Uy9TVi9IcW8vZDBLK1NGR3lKU0k3Y1FqUTM5R3ZaNW56RGNvODl6R0ZGaGJ1?=
 =?utf-8?B?RnJtY3JRRmZCLytpOEwrVmVoY3IrSmFnL0Vyc0FUa1Q4MmF4czdJaXZiUGt4?=
 =?utf-8?B?ekcrQ1EyOXQrSzloK1BHUUdmbWFYVFRjWHlmMWVwUEFVNUc5VEhDSGlVK3Nh?=
 =?utf-8?B?Y0xvdXFNbEI2Y2tCUk41NzJkNXVXd2kwN0xGNlBIa1JoMDhpQ1VHbkFkcVo0?=
 =?utf-8?B?UUdDZUorbVl5MDJ4V0dVUDVEemdRYVZSM1ByVXlvL1ArSVlodmszYTBHeStQ?=
 =?utf-8?B?Tk8wQUkyanJjWEk3V0M3WUtyYVM1YUxyejVRcjAwQTlqUnBsT3Rlc1Z2YTNv?=
 =?utf-8?B?b2dmUktqb0VPOXg4SlBOZ01wVkRCalRMRGFYanlVbG84Y1gyZlRkSUNVdnZK?=
 =?utf-8?B?dVhuQTcwNnprT1hOQzBQaTArZnVBaUM4VngyZFA1aGU0ekw5MEhFdXpyS1FO?=
 =?utf-8?B?aE5qbXQvdU1aS3g5MGpWdEc0dEVlc1g5OFVGb3JPZS9GU3M4WEk4ZExhUjJT?=
 =?utf-8?B?NWFlSWJlekRxUnhwTWMyclNEbEhWV2hKRTJTUlE2UUtQVkJIUEpMNUxZaHFW?=
 =?utf-8?B?RXd0ZGdoeEVjbWZuSnh5RjZMU0R2cUUyVDd4YklTSlBwREE0UTB1aVlPL0ZC?=
 =?utf-8?B?WWxtK0hsN3Jld3Q1ZHNBZHRMZTNxNndOQ2w2L2ZpV1RSVXdoMDhnMFJwS0hl?=
 =?utf-8?B?S0pPVnJGYkFtNE52KzdWTXNmWWcraitkdTNYSlVrV0JHT3J1cnhSL2doQ0VX?=
 =?utf-8?B?VlB0b0hhRm1VY0Nhb0h1VHRIbDAxNmRhNTRRT3JMT253dE5rTGdidUtJOXVo?=
 =?utf-8?B?NWdOWHI4dUhNZnl3eUt0QWhBNWdBWFQvSE1HNnYyNDYveXE2WU0vc0dFWW01?=
 =?utf-8?B?bDlkdUJYK2tpMDhCVkowSytFUU9CZ0M1YUo4YVRibm5IQVZEeHVjM3FwZWw0?=
 =?utf-8?B?MEVjVVRIYmF6VUI3d21FK2JsUFJjTXRnVlFoN2pCL1djczZHK1ZxdU1ZOC9S?=
 =?utf-8?B?M01mVjNzZS93RHBTS0xwYUtlaEZPM2l5U1h6QmhlRWRsRUszV0FyOE55ZnNi?=
 =?utf-8?B?NC9MWkx3VVVoNU9nN1BIZHBudmIzYVJzdnJJQ05PanJISVhraU5VTTF2OWRE?=
 =?utf-8?B?Q0NBVytoVmtxTjV3TUt3bzJPS0hBTmNRTUc0SDRrWUxtWlNNYjRsQnYwN3E3?=
 =?utf-8?B?MjQzaVhBSi9RSDhtTmwzeTRvZE4xL3lEUnNUVFVBOW9ub3A5YjlyL2F6WDM0?=
 =?utf-8?B?Q243ZklYL25IWjQ0NUVZMDIvV3Y0LzNGQ2ZmZ0kwSTl2b2pqVS91c245bkdm?=
 =?utf-8?B?WDVCVjVIWVdOVzNNQnRDSGRhemtQVXZ6RExnK3R6RytLTnhUelFlTEJ0eUNl?=
 =?utf-8?B?R2ZKa21RTmlVL09OYVF0bk5pOGF6TU1RSDhRU3ZoQ21qYWhkd0VJWGtrQXgy?=
 =?utf-8?B?VU1WUHdKcDRtK0k2MmVGenExNlcxN1pQYzNBVG0vNGJXRjh2cDZsZGJJUlAr?=
 =?utf-8?B?WUc3UTZ3a3FzWk5QNUNuYnY5Wmx0c0JqZWFxckpEcVZqcGxKRHpzUzdYK0xj?=
 =?utf-8?Q?fSe7ygmqzwKkMCtAnuMfowO+W1HCzACDxZHJQOoMzuCj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7LiSUmdjJP6/ckJHuWaLXbU5XSgUYGut9AZvLmmtKoObyZpVfv11TbRPG6slnd/Xt2/+2GgSEjw/tUi2v39g1G+edAmmONR+0ZLHpq17dG4dHfyFGD6yBfAb32JhzRMA6esR1N2dGsLhkj9t80DEl9paHiShUPoqbyRZUIUR8dNVoX+H/4JP8LRj7kLcK94Nbv1t6gbcBj8I05rKG/hW04XPgZGTYLVjXkwhEVsw7LqP4byJGtRA3h43XzzL9zCiXWvuiuPb3HRp4BYUv4AbvYYMkSh5pGw89hkbk2gWFhKzRGVP6Mfc8u6wBsteswRscbwDUlhviURP4gNHfO528HbICuEfUi/6PwBpqFWzmClyxf00tMCmJ2CzVKJ5stw3x3xdiARUdH5j9GyISEVxhbQso72gL4B2e2nG4poBMYak7ZS345XIyB4+2Gs/ZpFeO+6438KT3DHKCDrQ0nkO1zjJMWLuz3Yiz4rICWBnbDgj6iPxmEhrCGYmhTyPvqW+agzSHCDSO5qGNt25XViPT6x53V8Y9DbKAWwkuBMnyo5xuL5u8kQ3chFIWlsc0LQIqeh+M8en45OD9d//vBFa2u5TdY14YFs21Q2P7EIKkTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3baa93b7-ec05-474d-6f6f-08ddd09f70d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 02:02:17.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/aS1ZQHmSevJAlpqPCeKwrVMrhtoI8gR+iDdKUjZEPaATicNLITJFb1IPmXjIvM0xkrkARY4mvtpx81yOu4NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508010014
X-Authority-Analysis: v=2.4 cv=COwqXQrD c=1 sm=1 tr=0 ts=688c202c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=hybpBNN_az35c-nT9nEA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 cc=ntf awl=host:12071
X-Proofpoint-ORIG-GUID: gmCDnOU9QzDh2bQ7STXAPyf6PgEnMQ03
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAxNCBTYWx0ZWRfX6bwug11YMjON
 vX3XwOAkx4OOu1s3fSA8Z8a/w+y2CEseLePnkJEdrVbnohT6Bq8M53IWkh+DXKJCp8my4v+5PZG
 Sk0+JI4eNljAUOKg346lCQaGEQebkK/ujq60KTC9TUwkZeAMLHR7S4BVVMZ8knj7Qyzg9rC23D0
 4NQi+JWWY2IujXaq0JGwWtHko9qDrAq3thpmiwibO4GiwJrhApZ/JVVcUkmQXOrAur6rbRTCQOr
 VUTSvm22D0aCXedEYmvwNJ1O3EYfLJvs3UChUxKXoFj3mok2OSY26rmKo80v1oA7bCvMMTtZNlo
 0o4qb2gi4AFyK5H8KKLvaPzLtckL+aQgYbO8KfHqcobQ2CN4KMMk0e1436JyMBdfWZHx3tPdPzv
 VBDqfVxvI97SNtBASIqoB6VdzXW7FF+noUJ28qppB/pYdxXEE/95SqLrwhFulxf9IHp/Xrju
X-Proofpoint-GUID: gmCDnOU9QzDh2bQ7STXAPyf6PgEnMQ03


Boris, Martin,

Sorry for the delayed response, I was OOO.

> So I would prefer for you to validate that both discard_granularity and
> discover_max_bytes are non-zero. 

Thanks for the feedback - understood. I'll switch to the alternative
check: whether either discard_granularity or discard_max_bytes is zero.

> Obviously we have no plans to remove
> the existing check in blk_ioctl_discard(). But if we mess something up
> by accident, data loss could result. A zero transfer length write
> operation is not inherently safe. Whereas inspecting the queue topology
> is entirely innocuous.

Got it.

Thanks, Anand



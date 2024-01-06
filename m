Return-Path: <linux-btrfs+bounces-1277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD4825D7F
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 01:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B2D2852AE
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40136139C;
	Sat,  6 Jan 2024 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oBIXtIL7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZO4aRXUb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435310E3;
	Sat,  6 Jan 2024 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4060fKne007792;
	Sat, 6 Jan 2024 00:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RxPUn7SN7yv1qw0EjhDYVPxRWB9vHM2wayyv1Yu6oyM=;
 b=oBIXtIL7lpa7PddBL+Ap5iUFQmXPoc5raEkpxRn2cY21mKAyetRMVOPovXrizYv4lKD3
 tAMgExjDUMDcWrjkk9Bvd5+SaybI42VNMC4GU2I0nEf7c5M6dAsZn7MWZ2H+zm8RICyj
 wQiBrqWDNaxgA1BrJ4gIpt/MMGzN8D6/QsyyrjMNLDZruhRThz8LSJG+UkzVwQhgctYG
 /5Mg7ncm0aUAgm+Cm1Yp1m7w3sH4vVSFCgMk9W5sZMDzzzq6J6DglxhBVj2TZ4CurQe7
 6y76ye3azSigQ8Y9oZe0LdbFmohJtd7CPGpITK8TZq3pESEuUTfxS45cmT0LU97SEgRa kA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vevgtg0c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 00:55:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4060hXWD033739;
	Sat, 6 Jan 2024 00:55:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ve1jjcpv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 00:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoQ8BdGx7jFAi3ksa18go+bVXp4M93tkQlulRq93iB8bQax3RgfkSG/kP6+cm/Hsb3lnuPcsG7UykdcaobgWw5HeQT9KTf+uq2XSoIe5YJh59kSql4m8kTV83O7qo/D09wWm5Wz1lkbSkBYon7SttJ+mCqmUDD9Zz7ca3DCt67a0yE66EEm6Y3Ik47moT4jAmiWmLo4mYhu6+whG4/ymFLPol03mCB17JUHZjSK27xg7NUlhkGeWHD6nAyzl1MwJWWzRjpHCQtuVHaU8f1FazBFOvJNPNUN9w5lzbQpMNjZjK3yE4piIaejj0f5bO96Z9B8PYMdUD3Lw/KJ5cBJMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxPUn7SN7yv1qw0EjhDYVPxRWB9vHM2wayyv1Yu6oyM=;
 b=eUmcwlsdv29jOyfwVjTQlXSOxUeb3lqGucnaMXDepxxExt8jJAPs6+AMa77XI7+fFx7TmWWl0mbpwlB7bufQnUY0RgDqVGC2SVEC13zUf/dE8LPINX9K4B33Ef+wI0L36ItNlyJiNfdc4cl2Np2U0PBaVMfbKSfqEODddziNlIIL2f43M8fsOPmibIcs8uszVPVeJiIFgI76qbFRQCMkzDYcAdTTjF5XgBM0laeZFsEdKjTggoNaZL3c/rwVLOzsYGNv2COZQu7sCOcqyl0UTd79dgArFxHm64lxxzBCUJlWKwuiGAvsLrdQ4YaxxOjiOcu3rzRhjoPTab1kwJ62/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxPUn7SN7yv1qw0EjhDYVPxRWB9vHM2wayyv1Yu6oyM=;
 b=ZO4aRXUbhot2yr04qGL4WRdDRS3TGD7tt4l682PAlnMvel/MKilJtU7790strLYqnjaCTlyVn3p3vbcTELKPzU1VHrJnwDjmxs0ZXiPUI+to7Jd31Cu0bTkVxdUrH7hKW65bzWZTyIrFHWomzPqKpIRXSwnj0QVH3W4iJdYmjtQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Sat, 6 Jan
 2024 00:55:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 00:55:49 +0000
Message-ID: <d3a50779-b10e-421a-b2fd-eb0977c9a6f0@oracle.com>
Date: Sat, 6 Jan 2024 08:55:43 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH fstests] btrfs: test snapshotting a deleted subvolume
To: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
References: <068014bd3e90668525c295660862db2932e25087.1703010314.git.osandov@fb.com>
 <62415ffc97ff2db4fa65cdd6f9db6ddead8105cd.1703010806.git.osandov@osandov.com>
Content-Language: en-US
In-Reply-To: <62415ffc97ff2db4fa65cdd6f9db6ddead8105cd.1703010806.git.osandov@osandov.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b7fdaf-0425-44a3-9b53-08dc0e52393e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mUYC4UoaK4y13Ihyy2EimiOT3256eT4Qa5oousQlnXRkqK7n9xze1onSV/ghCPNuUpcNMOpBGYPPSK0pQ/4cQ5EtnLvSyE0uO6ddI97LZbmyxnQ3XUP9XwyOWDzqDd1a3tfgFmk0RM8WUgfdP4IPVZTE5KdiuRoTojg8nuSZH7VwvSRxgt+WokXWFwLVRT/39/0mXb+Cpv9YbKuTUeudJvciOOO4/2iOTt7OzLUVXxRdY2DFMPotHRjDQN5MR4DQ4m6Tad1M33cWeXrdDhwvGi7hi32cQ7Y/peoWQ5BcA1zKbxN09CZI/34NKjBH+CFOPVI+eibBh2ji6f0+1/aImO7OqW3zgSJqLct6ITIzwhQY3CuQpc11GQI9c1AEe7vFKEA7GKLTRFIgaTBOth1ZQXb32uFgPSvVlKyu35KLNvv055kFM7zdK/LLo39yd5bvubdL6vrHNPuaulTn8B51TeBJuPgLYo/YyXTZHDH3zsKotzEKeH8gwIYZvJcsunnC0RXmG3ka3n/xVLYgljmYkDVGj5sTtxz312K43t1OeoeTgWPZoQaOO1TL3h/x7jmEEVjpBIVrpA4bpJ4+aQqOzHS3UZJOOHr8vRi3aqhPyAJSqjHco84VvDRg2bCecMDczrgN9+CJCj4Nkdm0376jt1/HMOL7rOIvO6AyMj2ebqablK2NUaLLcOQhdcluz9tL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(2616005)(53546011)(6506007)(478600001)(6666004)(6486002)(6512007)(26005)(36756003)(38100700002)(86362001)(31696002)(5660300002)(41300700001)(83380400001)(66946007)(2906002)(8936002)(66476007)(66556008)(316002)(4326008)(8676002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ek54VEJ6R3lzMHBhbm9lUWJsb0tXby9DQ1phK1hLakEzcUt2bllVNUlnN1hF?=
 =?utf-8?B?a0Jsc0d4MTFJbDNybDlIVkR6V1IvVHNXeXB2Ri95Y0N1azBNN3dsUVdXS2tS?=
 =?utf-8?B?WnJyNitzQ21xTHhUMU9pdHVrNHhZaDdrWDZpVTlHMGVLcytIa1p5UmFkd2U1?=
 =?utf-8?B?VHMwZDJIU2pjSmp3SG1kMUxVMXF2dGZpSXRZaGkrci9nR1NVbmRHOUU4eGNm?=
 =?utf-8?B?MmcrZWdqSGRvdlNFaTZ5d25qcmlWdERaMXRwaVlUd0kwNHFlZnpJSDNsMWlz?=
 =?utf-8?B?eHlLUWZyOHQ1WU1GSXBuQ3pxYy9NVXFoWUVUQk5ZYTdqZm9KRnZoRklpajRh?=
 =?utf-8?B?U2RrTktGMkw3NVAvbUsxdlR3T2ZyTlgxLzExeXI5YUJSNExnV25Fb0Znb01y?=
 =?utf-8?B?Y2p3b2hPMFBQSGZLeTJzZ0Zlak5UdTRKWGZiL0NlbXNkZVpyQVNOVUVhbUZE?=
 =?utf-8?B?VmRDTHVveGhWMEJ2VEJLc3FueGVESFZCdUU1OUFtcVUvMlgyRkV6cHpPL3NT?=
 =?utf-8?B?dzFHbG9pV3BveTdBM0o2ZGpKNVlKQVF1MnJ2ODQ2cEVUYnQ1ZXhMUkZqL25x?=
 =?utf-8?B?NU04NDVSRHlwV2l3T1JEUjVZU1c1UjlVT2hpa2p4Y1J0bmp1NzhUT2JWOFU0?=
 =?utf-8?B?NXBSbzhVZDRqRXpOcytYcHpXaEgrWUpVQzRrNVhGMndTQjJ1TkdLYUtLcDNL?=
 =?utf-8?B?VllCV2J4MURUUEIzTjZSNklTRS91VEltK2F5K1BneDhuakJWN0MzZ2cxcjBX?=
 =?utf-8?B?WlJ1VUZPSEtOaGdNbkdMZUlEbW5memdnaFptZm5GTy8wUnpvYW5xaDA5bTNY?=
 =?utf-8?B?U1NQbEdaMFpMWElMYnN3bFIxUlZkQnpYb1ZNdVNudVF5ZmZ4K0hDNnhtK21Q?=
 =?utf-8?B?cE1HYkVkQzlpeXp6KzBpOHorcjU3Zld5d1EwTUcwSlQ4R0tMY2JIbUhMNFQ5?=
 =?utf-8?B?Uy9vZ2xTandKSG01NTFKZm40Y1JQd3B0ajMvL3dpUGozMDg2QjBOdjYzcHE5?=
 =?utf-8?B?bHMvYkhpOWxmc0dGYzdYMyszZTMxUmhIdzJzZzA5VGp1UWZ0citweDYvVnM2?=
 =?utf-8?B?TlFUWjVGOXZCa3YxU21QN2ZGVmY4Y3VoUHVFZ1FzdytrSW56bElTaVliWGFJ?=
 =?utf-8?B?Rm82K2x1VDQ4cEJ1MjllZTB5T2hranFvc05xNk1ZaU9mMEFjdDNybTMyZXU0?=
 =?utf-8?B?d1RQMlVZaHZVNGRtbTk2UU91V2N6aG9DcXBuT1BqVXpmME9WMitCRWMrQ3lh?=
 =?utf-8?B?T1UrejU0dkdKekJjZlFra0RpRVg4cEFVcEhTNE9DYTMyRWFFdDgzbzA3M2xW?=
 =?utf-8?B?ZFBJMDVrRmRtSGNvcUlMb095Z3JlUmw1Qm5EU3pjOVJSTGpkbCtnQmFPb0VX?=
 =?utf-8?B?YktqSzhWdGtXUy9IYk5EMFRQa2xTK2ZXZE1aL2s3RlN3TkNDTEZEd3ZMM3FU?=
 =?utf-8?B?WEE0VDU4SGdtTVVyQ3JmcHR3aHB2UzkzUm9lemRNN21GS2RYVTdCUUp6UnVw?=
 =?utf-8?B?a28wekNIc1B2OWMvQ2VSSjlIVVdRa250ekZjR3BlS2RwblgrTUZIYkhwRm82?=
 =?utf-8?B?MGM2NnVEVUo4aFE4N3BpR3RQekg5YkVTbjhyWEZxM0VIVWp3M1dodFM4QzBH?=
 =?utf-8?B?a21vekx5RVJMVHhvRFNVam5kS0lPaXlSa3VXQjRHbWNtWHgxOUFQdGNvUVI0?=
 =?utf-8?B?RUlFNlR4QW5pK1dNakdRTXM0cDQyZTRSMk5YZkxWTUNjNFFsanl4RlJ6NjRZ?=
 =?utf-8?B?dzZCSmlLd0Q1NHc3SXZJZW1HaXdyOWRwNDNBbEhVUnZUSEk4bHprekpFVVBU?=
 =?utf-8?B?dnVNS05BMUQ5Rm9odityTGFIU2pVY1VVSlNmRnN1dTFZUzYxZ1ZnYmJzZGdz?=
 =?utf-8?B?aG1qY1dIb2g5MlNqMFVVRStqZ1dDdmlYZlI5Ni93R1ptTldRTmJGYnpJMi9I?=
 =?utf-8?B?QnJ1ek5maXhwMFlJZ2o5VnNvMDA4YjRaSGhOQUhvWTc3VzBieGxQeElWdG9U?=
 =?utf-8?B?eVBPRlg1QmJ4bDQwU2pBbzVOREJEeUt5WlkvbGdPVmZQZCtUeHMzQkdzdnNH?=
 =?utf-8?B?RjFCUjlDK2Iya0k1NmNGMlBTT0ZwTG9rWHRCMnBVWFpRa3VyMURVNDFkaGxr?=
 =?utf-8?Q?o7WoedgJlDjQIK7vPP3sOTTbI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	W1BXFGa9fEpxfcEOPqcZ0/tmfZ5rgT/2sdO+qulftdN5SPpbdrHNxWRux9lO/RlxI3XSCvApAbaQ99tVCQuPXy5bMtTg7F5tQG8S5D+sdZovcoswz5yLlWs4N6d2bxqoXUQiGfw6X1/JJt5cQBiyolUhQQEPf3PXkUy2DSllo/mRuVcsxqpqnpBpyzVOya45a9dOugV7gtXitFvOz9Tr2T+61LWyHm399a96NV2brtiEGJU2urgMf3kd44d6AcqDioxxVEBSXon+XKeWRjYqpfdPfwRbqYNVQF5q/HJXhZIC9c4qFbNGHw+SvSjoanlVKMKnAgZm4QxMgjzRvhySs4pbj8hNDJQM9VUb7vMP+YIWlpGuohN9YdcvYgBJRzbHB94hhey8mYoX7So/dCO/kmovz9MHB6vIbXrqgdJHcE1DB+dWmFgFD0cyoIindc8+PLczzwkCkk0IeY/pNQQJhDd4ksx9zRW0W0bMxuk2qImANRdNSRo51/GsUl4Qb3/GVSAAox61zSPFf1JelzYH2cdi62aDONwUtjDxa+/7G7NW7eMFqnaA+aZX1lcu4xrm0D7m3x76q74HADgupVfbhOKhB0y3TPhyTdYZv1C2UDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b7fdaf-0425-44a3-9b53-08dc0e52393e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 00:55:49.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/aY2zdzjyWqr9BRvMfXq+d/u/x84LPSkYr1SynH1piaqdmUPjbffnz5TMmz7P5bIQOxCO8Dtm2V6Z/AcKsomg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401060002
X-Proofpoint-GUID: LrZcmupH48SOeGAaBgliAQY9DnpDgNEK
X-Proofpoint-ORIG-GUID: LrZcmupH48SOeGAaBgliAQY9DnpDgNEK

On 20/12/2023 00:04, Omar Sandoval wrote:
> This is a regression test for patch "btrfs: don't abort filesystem when
> attempting to snapshot deleted subvolume". Without the fix, the
> filesystem goes read-only and prints a warning. With the fix, it should
> fail gracefully with ENOENT.
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>

looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Added to the staging branch
git@github.com:asj/fstests.git staging

Thx, Anand


> ---
> Note that the kernel fix was just sent and isn't yet merged.
> 
> Thanks!
> 
>   .gitignore                         |   1 +
>   src/Makefile                       |   2 +-
>   src/t_snapshot_deleted_subvolume.c | 102 +++++++++++++++++++++++++++++
>   tests/btrfs/304                    |  26 ++++++++
>   tests/btrfs/304.out                |   2 +
>   5 files changed, 132 insertions(+), 1 deletion(-)
>   create mode 100644 src/t_snapshot_deleted_subvolume.c
>   create mode 100755 tests/btrfs/304
>   create mode 100644 tests/btrfs/304.out
> 
> diff --git a/.gitignore b/.gitignore
> index 4c32ac42..b9bf708b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -165,6 +165,7 @@ tags
>   /src/t_readdir_2
>   /src/t_readdir_3
>   /src/t_rename_overwrite
> +/src/t_snapshot_deleted_subvolume
>   /src/t_stripealign
>   /src/t_truncate_cmtime
>   /src/t_truncate_self
> diff --git a/src/Makefile b/src/Makefile
> index 8160a0e8..53a32370 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -33,7 +33,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>   	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>   	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>   	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -	uuid_ioctl
> +	uuid_ioctl t_snapshot_deleted_subvolume
>   
>   EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>   	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/t_snapshot_deleted_subvolume.c b/src/t_snapshot_deleted_subvolume.c
> new file mode 100644
> index 00000000..c3adb1c4
> --- /dev/null
> +++ b/src/t_snapshot_deleted_subvolume.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) Meta Platforms, Inc. and affiliates.
> +
> +#include "global.h"
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include <linux/types.h>
> +#ifdef HAVE_STRUCT_BTRFS_IOCTL_VOL_ARGS_V2
> +#include <linux/btrfs.h>
> +#else
> +#ifndef BTRFS_IOCTL_MAGIC
> +#define BTRFS_IOCTL_MAGIC 0x94
> +#endif
> +
> +#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> +#define BTRFS_IOC_SNAP_DESTROY_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
> +#ifndef BTRFS_IOC_SNAP_CREATE_V2
> +#define BTRFS_IOC_SNAP_CREATE_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
> +#ifndef BTRFS_IOC_SUBVOL_CREATE_V2
> +#define BTRFS_IOC_SUBVOL_CREATE_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 24, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
> +#ifndef BTRFS_SUBVOL_NAME_MAX
> +#define BTRFS_SUBVOL_NAME_MAX 4039
> +#endif
> +
> +struct btrfs_ioctl_vol_args_v2 {
> +	__s64 fd;
> +	__u64 transid;
> +	__u64 flags;
> +	union {
> +		struct {
> +			__u64 size;
> +			struct btrfs_qgroup_inherit *qgroup_inherit;
> +		};
> +		__u64 unused[4];
> +	};
> +	union {
> +		char name[BTRFS_SUBVOL_NAME_MAX + 1];
> +		__u64 devid;
> +		__u64 subvolid;
> +	};
> +};
> +#endif
> +
> +int main(int argc, char **argv)
> +{
> +	if (argc != 2) {
> +		fprintf(stderr, "usage: %s PATH\n", argv[0]);
> +		return EXIT_FAILURE;
> +	}
> +
> +	int dirfd = open(argv[1], O_RDONLY | O_DIRECTORY);
> +	if (dirfd < 0) {
> +		perror(argv[1]);
> +		return EXIT_FAILURE;
> +	}
> +
> +	struct btrfs_ioctl_vol_args_v2 subvol_args = {};
> +	strcpy(subvol_args.name, "subvol");
> +	if (ioctl(dirfd, BTRFS_IOC_SUBVOL_CREATE_V2, &subvol_args) < 0) {
> +		perror("BTRFS_IOC_SUBVOL_CREATE_V2");
> +		return EXIT_FAILURE;
> +	}
> +
> +	int subvolfd = openat(dirfd, "subvol", O_RDONLY | O_DIRECTORY);
> +	if (subvolfd < 0) {
> +		perror("openat");
> +		return EXIT_FAILURE;
> +	}
> +
> +	if (ioctl(dirfd, BTRFS_IOC_SNAP_DESTROY_V2, &subvol_args) < 0) {
> +		perror("BTRFS_IOC_SNAP_DESTROY_V2");
> +		return EXIT_FAILURE;
> +	}
> +
> +	struct btrfs_ioctl_vol_args_v2 snap_args = { .fd = subvolfd };
> +	strcpy(snap_args.name, "snap");
> +	if (ioctl(dirfd, BTRFS_IOC_SNAP_CREATE_V2, &snap_args) < 0) {
> +		if (errno == ENOENT)
> +			return EXIT_SUCCESS;
> +		perror("BTRFS_IOC_SNAP_CREATE_V2");
> +		return EXIT_FAILURE;
> +	}
> +	fprintf(stderr, "BTRFS_IOC_SNAP_CREATE_V2 should've failed\n");
> +	return EXIT_FAILURE;
> +}
> diff --git a/tests/btrfs/304 b/tests/btrfs/304
> new file mode 100755
> index 00000000..65f54b95
> --- /dev/null
> +++ b/tests/btrfs/304
> @@ -0,0 +1,26 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Meta Platforms, Inc. and affiliates.
> +#
> +# FS QA Test 304
> +#
> +# Try to snapshot a deleted subvolume.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick snapshot subvol
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_test_program t_snapshot_deleted_subvolume

> +_fixed_Aby_kernel_commit XXXXXXXXXXXX "btrfs: don't abort filesystem when attempting to snapshot deleted subvolume"


> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +"$here/src/t_snapshot_deleted_subvolume" "$SCRATCH_MNT"
> +# Make sure the filesystem didn't go read-only.
> +touch "$SCRATCH_MNT/foo"
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
> new file mode 100644
> index 00000000..c504111c
> --- /dev/null
> +++ b/tests/btrfs/304.out
> @@ -0,0 +1,2 @@
> +QA output created by 304
> +Silence is golden



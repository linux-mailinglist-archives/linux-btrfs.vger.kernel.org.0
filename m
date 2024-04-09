Return-Path: <linux-btrfs+bounces-4040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E489CF95
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 02:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E1E1F23595
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 00:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2AD611B;
	Tue,  9 Apr 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jzC3od0x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DlKIyOyF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A794C69;
	Tue,  9 Apr 2024 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712624251; cv=fail; b=RHhCLCfET+l7cdhz6elWqmbKmrSCsAFJWaZEJTsPFBCbogludoA+COCKFNhCARtGdqh49VU9z1MAjiR9Rs5ngV0FUdU5W1WHVpL+tohy/0EdvMOI2f+bw16i3PIaT77jt3OeUVTiOGIwwJhwMoAy31yy/xx/GlZsEWgcA7oNlBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712624251; c=relaxed/simple;
	bh=1/ZtX0hl8a5d3gRIA7x1KfvupxUGoy8oFeUUhlcs0xk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=scGpfA0qdUWLGj8HOldf/6FupCWYdM1G7suGE5oc5qhEhrqaG3vXGpSGoLJvSR24MGcgNUUMLcsno4IfWPsFcGfyVZwi5d5GncnR4TeLMHOMh8+hf5Jf13rqAZcZsVFF757b3EHEKpY3YGYo3W7m7Q5NUiUPrkxbWHaJvj/afZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jzC3od0x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DlKIyOyF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LnVkr007170;
	Tue, 9 Apr 2024 00:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cqCQXzcHpVZ0/JGkLVewntQB76jvLYs6ub+ZVgDulzg=;
 b=jzC3od0xD+Y63n5l2SbbiCBhYTK0K/OlaxGYOsZdD154HIrIYfAver8276kULWQ1DLfg
 +6CCXi6LBUHYnSspBYH0Rxic7kxMFcNBErgOCyAyNY0UZNpVRPjBmKxSnXG4Hdhc5TPL
 xKfy7btyZ6g36P+8qoG8WLgp+LQl+JwOZVED7TT+8S6sVI4r9JPq8BYpAoIuivkPfHbD
 a3ntF1rDZYsuxgTjI4p2Q7PqrP4RndL0aHzzgNC01qinGt3VAE/szXRFrlkClfeDwexj
 oLY4mREIL5w7WMoCWWUBTV6u68pJA8JDIrDeq1npYENSwTzfEldazuvT1qC2XGJWgKka yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvc03s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 00:57:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438NIVXf002879;
	Tue, 9 Apr 2024 00:57:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavucf4qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 00:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/hWfZFHHAl2z3DvLtOE/qoPFM2ctWNtaMLRMt+4Yo+a6g1nNQV9RlrFJlHhMvNsGPeq+4/LOy03i3hxCGV62yLSaT/qc6oNa+KulV1FSCQXTuhqE1uLHEo0xvgcgqsVCPX/vnzvzKTuABbqOrc71tLIDRqd9ewZeVkF4bKEFElHRCwQ2TOG2fXaQNXugW/2AwUuLZKSksBTTXBHFCKj/JCAgHBb06Dj01yhAzOVWXXFd8hvQIBFbfrfya2bCsOqMjcKPmaMiTV+3kK5Jqa6fPrS2HSv4yGWg10PDX+hmu/SBNSX0AWwPBF8MF8IMW5QbO2wv7npCCUz7TrozoPWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqCQXzcHpVZ0/JGkLVewntQB76jvLYs6ub+ZVgDulzg=;
 b=Y0Xm10eBD1e5b1abwUi/vSplciTbtb/w6mwlYOtlYu+XnjwEsb0QpAN5xfewi3s47GlMynPsTF6gOgMSzO4UBrEtUy+eTU7V10HbvkEx2IcmBpHid2buriJkr6MyjoNc+se30J2a02vLiSrOnQOXhOOKgAu3br3rw2DycZLblMXIi2T/6dABcYAPQgvsjBY70JTdSsBi0l7bbAhUlJ7wgL0MLmaoH48bxjhwt0UER8dt3n2Fok2JPS7nvIlaPBPA3zx0BbqsOa/G2VzOmYww/sPuoFrlwttEhOE1PjwZ+sYawJbJ9qBpXgH6AjXFvG4Boi3SFHAXA8T1iK0Uey15og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqCQXzcHpVZ0/JGkLVewntQB76jvLYs6ub+ZVgDulzg=;
 b=DlKIyOyFUd2CeEN67iaIlxs7GClbSFX080ysfyFtmPa/bPCR75r9bQj6aS4Io3sL4pGv0B2EbHKVnPuLGAMih4VFrAy2eOcwGPI3KgJDxjq2r23/+3fXM4CqAPyxq6gj3kiFiyRwtXNnOZS/kmQulV1v60YXAh6CHEeYia1hD6E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 00:57:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 00:57:19 +0000
Message-ID: <7e4cec93-32f8-4005-b3c5-02b0325421e3@oracle.com>
Date: Tue, 9 Apr 2024 08:57:13 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] common/filter.btrfs: introduce _filter_snapshot
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712306454.git.anand.jain@oracle.com>
 <bedb9edc01e8938544fa5c73f716f823764c3fd9.1712549642.git.anand.jain@oracle.com>
 <8ed760a1-eaa7-4fc6-9599-f642b3b70b76@gmx.com>
Content-Language: en-US
In-Reply-To: <8ed760a1-eaa7-4fc6-9599-f642b3b70b76@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7762:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l0pIn0KRpwRylCzPy/GQd4N1u1PtIHm3CsBAQRX4Es7sm/EC2c8v3SSLSTgzgFfECA1Smb/+S1ciVFX209Zn2Ihsjv/z0Im2dV2N1N6ZaWbiOTi/9CwN4jUB6dqjnrwYEUZLuFaErOqF8kJV7n+yK/wahuchvh7lwF1gFoJgW9B/kYjxbnCJLBp63r2EQ/qlZPTzBWymDXNEOfxfYzK6DuePSN05XsNf0YVzvADwP4D8EsidclUsYGHgWehSpVQ0pnekKAcAP/cf+aYQ/jmuvgLZJ2AxWcdm3ExkAAXRhmGDaDC4eot+YQBsxcWAY3Oui0+G+kQgIxIpp9dAsFGI9Tl9T7osC2CYx2g1tpwKe4mFJSMEQmJ80P/Si77MfpMEZDMTn9O4iEh8ktsG1jaJ0H/HcnidPUtDVh18JUqabkm86eTlDIgisXFQ2ybzwFPp+oOM+NGRNNfgdfZtAm8PfQsAADF2cc4ww4k6O8YYMgxzcnmXpwvum5DbhzrJp7Bbesk5i1DPShh5Uez4t270njDEQ+C5IQAn1Stb+jEArrc8MwHgoWCYc7cphMMe3BJDDWX1B7xujCIw4K9CzpUX73NlTG3Kuu3Va+xIo/SVKV11LfT92LGo0DDzNpwnX0CMwsZYJ+zKlJXlODPX3JjinB+uk2sXem/F5zYpkx5Jg/k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWhYcmRVRGFJZDZMcE1PUE1oZjZ1bk5udVQ4R2I4V3EvQTNPTU42U2hDOU5j?=
 =?utf-8?B?d1BhNDIxV0RVVlppK283UERsRTFqRVRrSVEwcGJrNGpzbjJtVDlWZnFwMUpp?=
 =?utf-8?B?RG9OSUtwMWxqUGFQRzR3a1NHUnNsazRFRUR0ZWttajZKOWlnQ2J6QkhjemxD?=
 =?utf-8?B?b2hMbXVHU3NLd3hRV1RLNnF6dWxzWmR6czFoOFEvNDZhSHh4bkNxMkNHYjY0?=
 =?utf-8?B?M1VZb2ZmcEh1MFZvZEd6NVFkSno4aGxWSmZvdFFLWk52U3Q2QkZiZUMrcmRo?=
 =?utf-8?B?ZmJaZHYwL0ZSa1pWalY3Ryt1aHdYZmtUblMzQTVQa3FFUmpmVGx2ZG9kUUdM?=
 =?utf-8?B?Ym90czJERFZ5UGkvRXZZVWQvUlppVXJxMXRWY3A2N3BvVmsvN0lWSkkzK25l?=
 =?utf-8?B?RnAxUWxYWFNrakRYYmZTV3doMURMZXFHRkM2TkR4b25QWDhXeGlFTkw4R2lM?=
 =?utf-8?B?M08zUTZHK3V1dVpoRHBiQ0FKNDU2dWVXWmNTMGZ5MnpaSmxvRTVGbmFQWm1Y?=
 =?utf-8?B?NkM4a3JtVVBSWDMzTUNkWE5NZ2ZocnkxemR1T3U3SHJyL3c0clBmQUo1QjJq?=
 =?utf-8?B?RHdLb0x1R1FNSHZ2cW1VME5jZjBoakFwdlN1b1BaNlBaNUdscENHWUJmdTFW?=
 =?utf-8?B?bUtQUGY1bk1YNkNPcy9sVXpud045WTNwNkxteCthejZZbk55T3JaQno0akhj?=
 =?utf-8?B?K1pzOUx1RFgwTVBrNEMwKzBHUjlURWxSekcwTmZJcElJZitDcWtveHc4VVFH?=
 =?utf-8?B?bzFzd2x4WmpWR2t6Y1BpR1poNXo5ZGtaV1Fib1d3WWs1SWlteis1ZENNdXBM?=
 =?utf-8?B?cUVqQm9IWDhMR3JUbmdvL3ZkYnN6REZTdVFtbE1JMXhKYkQwdCtBZmE4TDRT?=
 =?utf-8?B?azJTQXJ1T3ordXVHQy9sUEcvZXlUNGo4Z1JWUGJtek1iUXlMUlpyYWhrNXRH?=
 =?utf-8?B?YkhWNlNNV3ZLZ0I1TjlqeFBzQjVZVmgxb21EcllFT0s3OXlTTXE2Z004SWJG?=
 =?utf-8?B?TzNTeEVIWW5kU2VYY3NPVXh0YVp4U3N3MU1yZW90SS9GbXVmVTVHbTBVa2p2?=
 =?utf-8?B?ak9jejZmU0h5Wk5aZnJLTFAybWE2QVVMdUVOUWlFRkxpYmptTHJwUGYraWNj?=
 =?utf-8?B?d09wTFBqTkZDSDJMRXhjL0tHRE1UV2FybFpvYmwzL1ZnejdvT1lXQW8zdnRi?=
 =?utf-8?B?Mm0zdmx6VWJ4M2lDRmdkbDNpbWZrVS9KODJHSHdvRkhLZTNUNks2Nm5PcUZz?=
 =?utf-8?B?OXNWWHFsWlRvQ3hqMFVJOHJmQU5mcFVoSktJSzc0L2JGTEhGNEFUWkJ5cU82?=
 =?utf-8?B?ZGlUbU5Cc1VydDBVQnZZbzlHdUZrQ1FoTVlrNE9pWGsxREVCYnliNTZUcUNm?=
 =?utf-8?B?S3JrVTVpV0dDZVYwNENpQlE2S2hUSzhyRkZuMkVDdi9NcWFBUWh5Njl5UmZh?=
 =?utf-8?B?emY1S095NTk4RWE2Mjh4SnJEcm02by9wcUlKdHVYS1BFR1NkaHhJOVVxTGtj?=
 =?utf-8?B?QlFaWTZQUk85U3RxaEd3NkxURDR3NVdBcTVVK2dybXBRcm5sazVuY0tjSFRU?=
 =?utf-8?B?b2JseFRNK3Q5NVJtbFNva0VFdkZsM3ZHQU45aStxVWlJZmdIRUVQeEZMbENw?=
 =?utf-8?B?M1FoNFoxeW9PM1JZMDRKejVmTUJwWURRVDA3SjgwR2JaYmlWdU1pM0xUTlY5?=
 =?utf-8?B?U0tHbjFORHZKM2l0S0R5djN5Yzd4R3pRSVpJV2hOUmVQK0NhUWI5ZnJ5SEhR?=
 =?utf-8?B?MnJkVnZZcmozRXNvdStJRi95d0svVExtTUZyZmJuZWdWcEJUdUVJaW10M1Ft?=
 =?utf-8?B?N2djQmNxclZGTDk2S29KWW9Ma2U4RDZSYUZYV2IyYzc5Q2JOK2taeXlVV0Rh?=
 =?utf-8?B?TC9qdnphUHkrVGovdnZGbWtXaHU5d0Z4amprT0IzOXhST2tTdTBkNWNNU1pM?=
 =?utf-8?B?NnNwOXFiUVR6TDRRZ0hIU1gwMm9BVyswUVVoVUVBNVQ1MzN3b0JpNVFwWVBO?=
 =?utf-8?B?cmJnUGdoQ0ZUVlVMMTJmT2dsZEpianlBODBGSkZBM0Q5dTBLblloQ2RGcGVo?=
 =?utf-8?B?T3c5aW9JSjBYY2wxdFlCQ29KLzVvcW94dWJUZE5ucUNuMi9ncTFTcXU0VGRU?=
 =?utf-8?Q?pPYd293ESEUpjIxkrWrHEdTnG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fGlimv4PeT2zTZTtWSronkQSjdnwJT8rwJdN3HWzl+0cHrqBw4+A1DuNqIwSZpQUNN4MAArFwuSSEaoq5BSlw8HPTIB4MyzlmNZ8WVl0/zCMnJbwdtV3yxfSemC6FVm8NB+nPnX0c89M6igil+ZkdvaM9RuuMIaiiTYVCLjYCfombhaTh8Who85bp/1MJXhxDCy7fllk3YYv4EZSHNx1BxT4AS8g5TJ7X3rdP/3zfX7q8lWXQzfS7yYyG7e199XleV/53EogHOkmQfozzXFsMsFAeizguCFc7JUZ/c9NdmSXYvoxOYA2/T8sXaXpIOyubtg8U4AgOnwIMKN/jjJufMVp8Phg4CZMmtCDZQ1V7oNaCZsaBHQ1/xL1Zereji/ya8rXUWVvFCDh8w2hOCRsrjaZYnigTNHsK7v9SS9V1Jist6jqSUnr/6v/p8GBOOfiaPoZjwLoZUnfgt+DRoIGpsAtLxoBVeBMcYy5SGR6MtzG1qYxiX4XYRRF5XoDXXEFrkvoyf6IVfRn7S7UguU2zjrB/h43pTpaox4M6l2nf/sMg3IMVp/dW8OFZdkRQcBluTBXAiW4nk7N84gBn7SjSsTZiOycackWh2XXvPuUksg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f96189-8f81-45d1-54dd-08dc5830018d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 00:57:19.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaSvCYU99W7ZxnQqFnbFZWtbSdAy4y7t9WLWUWuZfA44wqQnTzcvPBXdogY1pCgPwg/H/wX7vjbMhtW2Z2PY2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090000
X-Proofpoint-ORIG-GUID: bVBROadjZkqJmPja9imB00--BLlYTjI8
X-Proofpoint-GUID: bVBROadjZkqJmPja9imB00--BLlYTjI8



On 4/8/24 16:24, Qu Wenruo wrote:
> 
> 
> 在 2024/4/8 14:02, Anand Jain 写道:
>> Btrfs-progs commit 5f87b467a9e7 ("subvolume: output the prompt line only
>> when the ioctl succeeded") changed the output for snapshot command,
>> updating the golden outputs.
>>
>> Create a helper filter to ensure the test cases pass on older 
>> btrfs-progs.
>>
>> Another option is to remove the 'btrfs subvolume snapshot' command output
>> from the golden output and redirect it to /dev/null, but this strays from
>> the bug-fix objective.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2: The missed testcases included now.
>>      Merged following two patches in v1:
>>     common/filter.btrfs: add a new _filter_snapshot
>>     btrfs: create snapshot fix golden output
> 
> Still I do not think this is correct way to go.
> 
> 3 points for my objection:
> 
> - Most test cases are already doing the redirection for "btrfs
>    subvolume" command group
>    Check my patch's commit message, overall the touched ones are less
>    than 25% of all the "btrfs subvolume snapshot" calls.
> 

I observed that. However, as I mentioned in the change log, the
objective of this patch is to make test cases work with both the
older and newer versions of btrfs-progs only. So, not a good idea
to remove the golden output completely.

> - Missing handling for "btrfs subvolume delete"
>    Sure you can add new filters, but I do not think it's worthy just a >    new filter.

Sorry, but test cases using 'btrfs subvolume delete' (without 
redirection) aren't failing.
Also, there is no change in the output of 'btrfs subvolume delete'.
Or perhaps I didn't understand what you meant.

> 
> - How to enforce the filters for the future test cases?
>    Good luck if you're really pushing everyone to use the new filter.
>    On the other hand, it's pretty instintive to just redirect the output.

Unfortunately, that has been the core fundamental design in fstests,
and I don't intend to change it in a patch meant to fix a bug.

It seems that we need to maintain the golden output fundamentals until
we find a better alternative or one that is reasonable enough to not
verify the output on a per-command basis, which I believe is your point
of view. I understand that. Also, commented, we could use
'_run_btrfs_util_prog subvolume xxx'. This would mean no golden output.
But as I mentioned, let's not address that objective within this bug
fix.

Thanks, -Anand

>>   common/filter.btrfs | 9 +++++++++
>>   tests/btrfs/001     | 3 ++-
>>   tests/btrfs/001.out | 2 +-
>>   tests/btrfs/152     | 6 +++---
>>   tests/btrfs/152.out | 4 ++--
>>   tests/btrfs/168     | 6 +++---
>>   tests/btrfs/168.out | 4 ++--
>>   tests/btrfs/169     | 6 +++---
>>   tests/btrfs/169.out | 4 ++--
>>   tests/btrfs/170     | 4 ++--
>>   tests/btrfs/170.out | 2 +-
>>   tests/btrfs/187     | 6 +++---
>>   tests/btrfs/187.out | 4 ++--
>>   tests/btrfs/188     | 8 ++++----
>>   tests/btrfs/188.out | 4 ++--
>>   tests/btrfs/189     | 4 ++--
>>   tests/btrfs/189.out | 2 +-
>>   tests/btrfs/191     | 6 +++---
>>   tests/btrfs/191.out | 4 ++--
>>   tests/btrfs/200     | 6 +++---
>>   tests/btrfs/200.out | 4 ++--
>>   tests/btrfs/202     | 4 ++--
>>   tests/btrfs/202.out | 2 +-
>>   tests/btrfs/203     | 6 +++---
>>   tests/btrfs/203.out | 4 ++--
>>   tests/btrfs/226     | 4 ++--
>>   tests/btrfs/226.out | 2 +-
>>   tests/btrfs/276     | 2 +-
>>   tests/btrfs/276.out | 2 +-
>>   tests/btrfs/280     | 4 ++--
>>   tests/btrfs/280.out | 2 +-
>>   tests/btrfs/281     | 4 ++--
>>   tests/btrfs/281.out | 2 +-
>>   tests/btrfs/283     | 4 ++--
>>   tests/btrfs/283.out | 2 +-
>>   tests/btrfs/287     | 4 ++--
>>   tests/btrfs/287.out | 4 ++--
>>   tests/btrfs/293     | 4 ++--
>>   tests/btrfs/293.out | 4 ++--
>>   tests/btrfs/300     | 2 +-
>>   tests/btrfs/300.out | 2 +-
>>   tests/btrfs/302     | 4 ++--
>>   tests/btrfs/302.out | 2 +-
>>   tests/btrfs/314     | 2 +-
>>   tests/btrfs/314.out | 4 ++--
>>   45 files changed, 92 insertions(+), 82 deletions(-)
>>
>> diff --git a/common/filter.btrfs b/common/filter.btrfs
>> index 9ef9676175c9..7042edf16d2a 100644
>> --- a/common/filter.btrfs
>> +++ b/common/filter.btrfs
>> @@ -156,5 +156,14 @@ _filter_device_add()
>>
>>   }
>>
>> +_filter_snapshot()
>> +{
>> +    # btrfs-progs commit 5f87b467a9e7 ("btrfs-progs: subvolume: 
>> output the
>> +    # prompt line only when the ioctl succeeded") changed the output for
>> +    # btrfs subvolume snapshot, ensure that the latest fstests 
>> continue to
>> +    # work on older btrfs-progs without the above commit.
>> +    _filter_testdir_and_scratch | sed -e "s/Create a/Create/g"
>> +}
>> +
>>   # make sure this script returns success
>>   /bin/true
>> diff --git a/tests/btrfs/001 b/tests/btrfs/001
>> index 6c2639990373..cfcf2ade4590 100755
>> --- a/tests/btrfs/001
>> +++ b/tests/btrfs/001
>> @@ -26,7 +26,8 @@ dd if=/dev/zero of=$SCRATCH_MNT/foo bs=1M count=1 &> 
>> /dev/null
>>   echo "List root dir"
>>   ls $SCRATCH_MNT
>>   echo "Creating snapshot of root dir"
>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | 
>> _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | \
>> +                            _filter_snapshot
>>   echo "List root dir after snapshot"
>>   ls $SCRATCH_MNT
>>   echo "List snapshot dir"
>> diff --git a/tests/btrfs/001.out b/tests/btrfs/001.out
>> index c782bde96091..c9e32265da6a 100644
>> --- a/tests/btrfs/001.out
>> +++ b/tests/btrfs/001.out
>> @@ -3,7 +3,7 @@ Creating file foo in root dir
>>   List root dir
>>   foo
>>   Creating snapshot of root dir
>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>   List root dir after snapshot
>>   foo
>>   snap
>> diff --git a/tests/btrfs/152 b/tests/btrfs/152
>> index 75f576c3cfca..b89fe361e84e 100755
>> --- a/tests/btrfs/152
>> +++ b/tests/btrfs/152
>> @@ -11,7 +11,7 @@
>>   _begin_fstest auto quick metadata qgroup send
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   # real QA test starts here
>>   _supported_fs btrfs
>> @@ -32,9 +32,9 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
>>
>>   # Create base snapshots and send them
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
>> -    $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
>> +    $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_snapshot
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
>> -    $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
>> +    $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_snapshot
>>   for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
>>       $BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2> 
>> /dev/null | \
>>           $BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} | _filter_scratch
>> diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
>> index a95bb5797162..763d38cefe65 100644
>> --- a/tests/btrfs/152.out
>> +++ b/tests/btrfs/152.out
>> @@ -5,8 +5,8 @@ Create subvolume 'SCRATCH_MNT/recv1_1'
>>   Create subvolume 'SCRATCH_MNT/recv1_2'
>>   Create subvolume 'SCRATCH_MNT/recv2_1'
>>   Create subvolume 'SCRATCH_MNT/recv2_2'
>> -Create a readonly snapshot of 'SCRATCH_MNT/subvol1' in 
>> 'SCRATCH_MNT/subvol1/.snapshots/1'
>> -Create a readonly snapshot of 'SCRATCH_MNT/subvol2' in 
>> 'SCRATCH_MNT/subvol2/.snapshots/1'
>> +Create readonly snapshot of 'SCRATCH_MNT/subvol1' in 
>> 'SCRATCH_MNT/subvol1/.snapshots/1'
>> +Create readonly snapshot of 'SCRATCH_MNT/subvol2' in 
>> 'SCRATCH_MNT/subvol2/.snapshots/1'
>>   At subvol 1
>>   At subvol 1
>>   At subvol 1
>> diff --git a/tests/btrfs/168 b/tests/btrfs/168
>> index acc58b51ee39..78bc9b8f81bb 100755
>> --- a/tests/btrfs/168
>> +++ b/tests/btrfs/168
>> @@ -20,7 +20,7 @@ _cleanup()
>>   }
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   # real QA test starts here
>>   _supported_fs btrfs
>> @@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro false
>>   # Create a snapshot of the subvolume, to be used later as the parent 
>> snapshot
>>   # for an incremental send operation.
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 
>> $SCRATCH_MNT/snap1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # First do a full send of this snapshot.
>>   $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
>> @@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K" 
>> $SCRATCH_MNT/sv1/baz >>$seqres.full
>>   # Create a second snapshot of the subvolume, to be used later as the 
>> send
>>   # snapshot of an incremental send operation.
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 
>> $SCRATCH_MNT/snap2 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # Temporarily turn the second snapshot to read-write mode and then 
>> open a file
>>   # descriptor on its foo file.
>> diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
>> index 6cfce8cd666c..0eccbc3fc416 100644
>> --- a/tests/btrfs/168.out
>> +++ b/tests/btrfs/168.out
>> @@ -1,9 +1,9 @@
>>   QA output created by 168
>>   Create subvolume 'SCRATCH_MNT/sv1'
>>   At subvol SCRATCH_MNT/sv1
>> -Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
>> +Create readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
>>   At subvol SCRATCH_MNT/snap1
>> -Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
>> +Create readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
>>   At subvol SCRATCH_MNT/snap2
>>   At subvol sv1
>>   OK
>> diff --git a/tests/btrfs/169 b/tests/btrfs/169
>> index 009fdaee7c46..e507692fd0c6 100755
>> --- a/tests/btrfs/169
>> +++ b/tests/btrfs/169
>> @@ -20,7 +20,7 @@ _cleanup()
>>   }
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   # real QA test starts here
>>   _supported_fs btrfs
>> @@ -44,7 +44,7 @@ $XFS_IO_PROG -f -c "falloc -k 0 4M" \
>>            $SCRATCH_MNT/foobar | _filter_xfs_io
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/snap1 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 
>> 2>&1 \
>>       | _filter_scratch
>>
>> @@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap 
>> $SCRATCH_MNT/snap1 2>&1 \
>>   $XFS_IO_PROG -c "fpunch 1M 2M" $SCRATCH_MNT/foobar
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/snap2 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
>>            $SCRATCH_MNT/snap2 2>&1 | _filter_scratch
>>
>> diff --git a/tests/btrfs/169.out b/tests/btrfs/169.out
>> index ba77bf0adbe3..c3467d5162d9 100644
>> --- a/tests/btrfs/169.out
>> +++ b/tests/btrfs/169.out
>> @@ -1,9 +1,9 @@
>>   QA output created by 169
>>   wrote 1048576/1048576 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>   At subvol SCRATCH_MNT/snap1
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>   At subvol SCRATCH_MNT/snap2
>>   File digest in the original filesystem:
>>   d31659e82e87798acd4669a1e0a19d4f  SCRATCH_MNT/snap2/foobar
>> diff --git a/tests/btrfs/170 b/tests/btrfs/170
>> index ab105d36fb96..50b6fa8654d4 100755
>> --- a/tests/btrfs/170
>> +++ b/tests/btrfs/170
>> @@ -12,7 +12,7 @@
>>   _begin_fstest auto quick snapshot prealloc
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   # real QA test starts here
>>   _supported_fs btrfs
>> @@ -46,7 +46,7 @@ md5sum $SCRATCH_MNT/foobar | _filter_scratch
>>
>>   # Create a snapshot of the subvolume where our file is.
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/snap 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # Cleanly unmount the filesystem.
>>   _scratch_unmount
>> diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
>> index 4c5fd87a8b17..ebdf872c7eb2 100644
>> --- a/tests/btrfs/170.out
>> +++ b/tests/btrfs/170.out
>> @@ -3,6 +3,6 @@ wrote 131072/131072 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   File digest after write:
>>   85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>   File digest after mounting the filesystem again:
>>   85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
>> diff --git a/tests/btrfs/187 b/tests/btrfs/187
>> index d3cf05a1bd92..f0935c9e6516 100755
>> --- a/tests/btrfs/187
>> +++ b/tests/btrfs/187
>> @@ -17,7 +17,7 @@ _begin_fstest auto send dedupe clone balance
>>
>>   # Import common functions.
>>   . ./common/attr
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>   . ./common/reflink
>>
>>   # real QA test starts here
>> @@ -152,7 +152,7 @@ done
>>   wait ${create_pids[@]}
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/snap1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # Add some more files, so that that are substantial differences 
>> between the
>>   # two test snapshots used for an incremental send later.
>> @@ -184,7 +184,7 @@ done
>>   wait ${setxattr_pids[@]}
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/snap2 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   full_send_loop 5 &
>>   full_send_pid=$!
>> diff --git a/tests/btrfs/187.out b/tests/btrfs/187.out
>> index ab522cfe7e8c..208cfb212b8f 100644
>> --- a/tests/btrfs/187.out
>> +++ b/tests/btrfs/187.out
>> @@ -1,3 +1,3 @@
>>   QA output created by 187
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>> diff --git a/tests/btrfs/188 b/tests/btrfs/188
>> index fcaf84b15053..feeb4397c234 100755
>> --- a/tests/btrfs/188
>> +++ b/tests/btrfs/188
>> @@ -21,7 +21,7 @@ _cleanup()
>>   }
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   # real QA test starts here
>>   _supported_fs btrfs
>> @@ -45,16 +45,16 @@ $XFS_IO_PROG -f -c "pwrite -S 0xab 0 500K" 
>> $SCRATCH_MNT/foobar | _filter_xfs_io
>>   $XFS_IO_PROG -c "falloc -k 1200K 800K" $SCRATCH_MNT/foobar
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/base 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 
>> 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # Now punch a hole that drops all the extents within the file's size.
>>   $XFS_IO_PROG -c "fpunch 0 500K" $SCRATCH_MNT/foobar
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/incr 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
>>       $SCRATCH_MNT/incr 2>&1 | _filter_scratch
>> diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
>> index 260988e60084..586543cfde61 100644
>> --- a/tests/btrfs/188.out
>> +++ b/tests/btrfs/188.out
>> @@ -1,9 +1,9 @@
>>   QA output created by 188
>>   wrote 512000/512000 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>   At subvol SCRATCH_MNT/base
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>>   At subvol SCRATCH_MNT/incr
>>   File digest in the original filesystem:
>>   816df6f64deba63b029ca19d880ee10a  SCRATCH_MNT/incr/foobar
>> diff --git a/tests/btrfs/189 b/tests/btrfs/189
>> index ec6e56fa0020..244ca84299fa 100755
>> --- a/tests/btrfs/189
>> +++ b/tests/btrfs/189
>> @@ -23,7 +23,7 @@ _cleanup()
>>   }
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>   . ./common/reflink
>>
>>   # real QA test starts here
>> @@ -46,7 +46,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x4d 0 2M" 
>> $SCRATCH_MNT/baz | _filter_xfs_io
>>   $XFS_IO_PROG -f -c "pwrite -S 0xe2 0 2M" $SCRATCH_MNT/zoo | 
>> _filter_xfs_io
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/base 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 
>> 2>&1 \
>>       | _filter_scratch
>> diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
>> index 79c70b03a1ba..a516167578e4 100644
>> --- a/tests/btrfs/189.out
>> +++ b/tests/btrfs/189.out
>> @@ -7,7 +7,7 @@ wrote 2097152/2097152 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   wrote 2097152/2097152 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>   At subvol SCRATCH_MNT/base
>>   linked 131072/131072 bytes at offset 655360
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> diff --git a/tests/btrfs/191 b/tests/btrfs/191
>> index 3c565d0ad209..9c1fd80b7583 100755
>> --- a/tests/btrfs/191
>> +++ b/tests/btrfs/191
>> @@ -19,7 +19,7 @@ _cleanup()
>>   }
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>   . ./common/reflink
>>
>>   # real QA test starts here
>> @@ -44,7 +44,7 @@ $XFS_IO_PROG -c "pwrite -S 0xb8 512K 512K" 
>> $SCRATCH_MNT/foo | _filter_xfs_io
>>
>>   # Create the base snapshot and the parent send stream from it.
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/mysnap1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1 
>> 2>&1 \
>>       | _filter_scratch
>> @@ -55,7 +55,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xb8 0 1M" 
>> $SCRATCH_MNT/bar | _filter_xfs_io
>>   # Create the second snapshot, used for the incremental send, before 
>> doing the
>>   # file deduplication.
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/mysnap2 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # Now before creating the incremental send stream:
>>   #
>> diff --git a/tests/btrfs/191.out b/tests/btrfs/191.out
>> index 4269803cce1e..ad4d779814f7 100644
>> --- a/tests/btrfs/191.out
>> +++ b/tests/btrfs/191.out
>> @@ -3,11 +3,11 @@ wrote 524288/524288 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   wrote 524288/524288 bytes at offset 524288
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
>>   At subvol SCRATCH_MNT/mysnap1
>>   wrote 1048576/1048576 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
>>   deduped 524288/524288 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   deduped 524288/524288 bytes at offset 524288
>> diff --git a/tests/btrfs/200 b/tests/btrfs/200
>> index 5ce3775f2222..3d18165a630f 100755
>> --- a/tests/btrfs/200
>> +++ b/tests/btrfs/200
>> @@ -19,7 +19,7 @@ _cleanup()
>>   }
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>   . ./common/reflink
>>   . ./common/punch
>>
>> @@ -52,7 +52,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" 
>> $SCRATCH_MNT/bar \
>>       | _filter_xfs_io
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/base 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 
>> 2>&1 \
>>       | _filter_scratch
>> @@ -64,7 +64,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" 
>> $SCRATCH_MNT/bar \
>>       | _filter_xfs_io
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/incr 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
>>       $SCRATCH_MNT/incr 2>&1 | _filter_scratch
>> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
>> index 3eec567e97fe..5c1cd855fa99 100644
>> --- a/tests/btrfs/200.out
>> +++ b/tests/btrfs/200.out
>> @@ -5,11 +5,11 @@ linked 65536/65536 bytes at offset 65536
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   wrote 65536/65536 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>   At subvol SCRATCH_MNT/base
>>   linked 65536/65536 bytes at offset 65536
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>>   At subvol SCRATCH_MNT/incr
>>   At subvol base
>>   At snapshot incr
>> diff --git a/tests/btrfs/202 b/tests/btrfs/202
>> index 5f0429f18bf9..57ecbe47c0bb 100755
>> --- a/tests/btrfs/202
>> +++ b/tests/btrfs/202
>> @@ -8,7 +8,7 @@
>>   . ./common/preamble
>>   _begin_fstest auto quick subvol snapshot
>>
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   _supported_fs btrfs
>>   _require_scratch
>> @@ -28,7 +28,7 @@ _scratch_mount
>>   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
>>   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
>>   $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # Need the dummy entry created so that we get the invalid removal 
>> when we rmdir
>>   ls $SCRATCH_MNT/c/b
>> diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
>> index 7f33d49f889c..6b80810e96ed 100644
>> --- a/tests/btrfs/202.out
>> +++ b/tests/btrfs/202.out
>> @@ -1,4 +1,4 @@
>>   QA output created by 202
>>   Create subvolume 'SCRATCH_MNT/a'
>>   Create subvolume 'SCRATCH_MNT/a/b'
>> -Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
>> +Create snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
>> diff --git a/tests/btrfs/203 b/tests/btrfs/203
>> index e506118e2cd2..e62f09edb570 100755
>> --- a/tests/btrfs/203
>> +++ b/tests/btrfs/203
>> @@ -20,7 +20,7 @@ _cleanup()
>>   }
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>   . ./common/reflink
>>
>>   # real QA test starts here
>> @@ -44,7 +44,7 @@ _scratch_mount
>>   $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 64K" $SCRATCH_MNT/foobar | 
>> _filter_xfs_io
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/base 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 
>> 2>&1 \
>>       | _filter_scratch
>> @@ -70,7 +70,7 @@ $XFS_IO_PROG -c "pwrite -S 0xab 512K 64K" \
>>            $SCRATCH_MNT/foobar | _filter_xfs_io
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/incr 2>&1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
>>            $SCRATCH_MNT/incr 2>&1 | _filter_scratch
>> diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
>> index 58739a98cd1b..59c2564bc61b 100644
>> --- a/tests/btrfs/203.out
>> +++ b/tests/btrfs/203.out
>> @@ -1,7 +1,7 @@
>>   QA output created by 203
>>   wrote 65536/65536 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>   At subvol SCRATCH_MNT/base
>>   wrote 65536/65536 bytes at offset 524288
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> @@ -15,7 +15,7 @@ wrote 65536/65536 bytes at offset 786432
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   linked 196608/196608 bytes at offset 196608
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>>   At subvol SCRATCH_MNT/incr
>>   File foobar digest in the original filesystem:
>>   2b76b23b62fdbbbcae1ee37eec84fd7d
>> diff --git a/tests/btrfs/226 b/tests/btrfs/226
>> index 7034fcc7b2a5..f96a832505a4 100755
>> --- a/tests/btrfs/226
>> +++ b/tests/btrfs/226
>> @@ -11,7 +11,7 @@
>>   _begin_fstest auto quick rw snapshot clone prealloc punch
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>   . ./common/reflink
>>
>>   # real QA test starts here
>> @@ -51,7 +51,7 @@ $XFS_IO_PROG -s -c "pwrite -S 0xab 0 64K" \
>>            $SCRATCH_MNT/f2 | _filter_xfs_io
>>
>>   $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # Write into the range of the first extent so that that range no 
>> longer has a
>>   # shared extent.
>> diff --git a/tests/btrfs/226.out b/tests/btrfs/226.out
>> index c63982b0ba4a..1855e5255fce 100644
>> --- a/tests/btrfs/226.out
>> +++ b/tests/btrfs/226.out
>> @@ -13,7 +13,7 @@ wrote 65536/65536 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   wrote 65536/65536 bytes at offset 65536
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>   wrote 65536/65536 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   pwrite: Resource temporarily unavailable
>> diff --git a/tests/btrfs/276 b/tests/btrfs/276
>> index f15f20824350..30799ebe449e 100755
>> --- a/tests/btrfs/276
>> +++ b/tests/btrfs/276
>> @@ -105,7 +105,7 @@ sync
>>   echo "Number of non-shared extents in the whole file: 
>> $(count_not_shared_extents)"
>>
>>   # Creating a snapshot.
>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | 
>> _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | 
>> _filter_snapshot
>>
>>   # We have a snapshot, so now all extents should be reported as shared.
>>   echo "Number of shared extents in the whole file: 
>> $(count_shared_extents)"
>> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
>> index 352e06b4d4b2..27ea29bdf87b 100644
>> --- a/tests/btrfs/276.out
>> +++ b/tests/btrfs/276.out
>> @@ -1,6 +1,6 @@
>>   QA output created by 276
>>   Number of non-shared extents in the whole file: 2000
>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>   Number of shared extents in the whole file: 2000
>>   wrote 65536/65536 bytes at offset 524288
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> diff --git a/tests/btrfs/280 b/tests/btrfs/280
>> index fc049adb0b19..4957825b7e4b 100755
>> --- a/tests/btrfs/280
>> +++ b/tests/btrfs/280
>> @@ -15,7 +15,7 @@
>>   . ./common/preamble
>>   _begin_fstest auto quick compress snapshot fiemap
>>
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>   . ./common/punch # for _filter_fiemap_flags
>>
>>   _supported_fs btrfs
>> @@ -37,7 +37,7 @@ _scratch_mount -o compress
>>   $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | 
>> _filter_xfs_io
>>
>>   # Create a RW snapshot of the default subvolume.
>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | 
>> _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | 
>> _filter_snapshot
>>
>>   echo
>>   echo "File foo fiemap before COWing extent:"
>> diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
>> index 5371f3b01551..4f0e5d2287b6 100644
>> --- a/tests/btrfs/280.out
>> +++ b/tests/btrfs/280.out
>> @@ -1,7 +1,7 @@
>>   QA output created by 280
>>   wrote 134217728/134217728 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>
>>   File foo fiemap before COWing extent:
>>
>> diff --git a/tests/btrfs/281 b/tests/btrfs/281
>> index ddc7d9e8b06d..2943998bee20 100755
>> --- a/tests/btrfs/281
>> +++ b/tests/btrfs/281
>> @@ -15,7 +15,7 @@
>>   . ./common/preamble
>>   _begin_fstest auto quick send compress clone fiemap
>>
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>   . ./common/reflink
>>   . ./common/punch # for _filter_fiemap_flags
>>
>> @@ -53,7 +53,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 0 64K" 
>> $SCRATCH_MNT/foo \
>>
>>   echo "Creating snapshot and a send stream for it..."
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
>> -    | _filter_scratch
>> +    | _filter_snapshot
>>   $BTRFS_UTIL_PROG send --compressed-data -f $send_stream 
>> $SCRATCH_MNT/snap 2>&1 \
>>       | _filter_scratch
>>
>> diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
>> index 2585e3e567db..49c23a00baea 100644
>> --- a/tests/btrfs/281.out
>> +++ b/tests/btrfs/281.out
>> @@ -6,7 +6,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX 
>> ops/sec)
>>   linked 65536/65536 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   Creating snapshot and a send stream for it...
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>   At subvol SCRATCH_MNT/snap
>>   Creating a new filesystem to receive the send stream...
>>   At subvol snap
>> diff --git a/tests/btrfs/283 b/tests/btrfs/283
>> index 118df08b8958..d9b8c1d24b8f 100755
>> --- a/tests/btrfs/283
>> +++ b/tests/btrfs/283
>> @@ -11,7 +11,7 @@
>>   . ./common/preamble
>>   _begin_fstest auto quick send clone fiemap
>>
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>   . ./common/reflink
>>   . ./common/punch # for _filter_fiemap_flags
>>
>> @@ -58,7 +58,7 @@ $XFS_IO_PROG -c "pwrite -S 0xcd -b 64K 64K 64K" 
>> $SCRATCH_MNT/foo | _filter_xfs_i
>>
>>   echo "Creating snapshot and a send stream for it..."
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
>> -    | _filter_scratch
>> +    | _filter_snapshot
>>
>>   $BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap 2>&1 | 
>> _filter_scratch
>>
>> diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
>> index 286dae332eff..37f425bf8312 100644
>> --- a/tests/btrfs/283.out
>> +++ b/tests/btrfs/283.out
>> @@ -4,7 +4,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX 
>> ops/sec)
>>   wrote 65536/65536 bytes at offset 65536
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   Creating snapshot and a send stream for it...
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>   At subvol SCRATCH_MNT/snap
>>   Creating a new filesystem to receive the send stream...
>>   At subvol snap
>> diff --git a/tests/btrfs/287 b/tests/btrfs/287
>> index 64e6ef35250c..dec812760917 100755
>> --- a/tests/btrfs/287
>> +++ b/tests/btrfs/287
>> @@ -112,9 +112,9 @@ query_logical_ino -o $bytenr
>>
>>   # Now create two snapshots and then do some queries.
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/snap1 \
>> -    | _filter_scratch
>> +    | _filter_snapshot
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/snap2 \
>> -    | _filter_scratch
>> +    | _filter_snapshot
>>
>>   snap1_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap1)
>>   snap2_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap2)
>> diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
>> index 30eac8fa444c..5798ec5d7c55 100644
>> --- a/tests/btrfs/287.out
>> +++ b/tests/btrfs/287.out
>> @@ -41,8 +41,8 @@ resolve first extent +3M offset with ignore offset 
>> option:
>>   inode 257 offset 16777216 root 5
>>   inode 257 offset 8388608 root 5
>>   inode 257 offset 2097152 root 5
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>   resolve first extent:
>>   inode 257 offset 16777216 snap2
>>   inode 257 offset 8388608 snap2
>> diff --git a/tests/btrfs/293 b/tests/btrfs/293
>> index 06f96dc414b0..fffdcd53441a 100755
>> --- a/tests/btrfs/293
>> +++ b/tests/btrfs/293
>> @@ -32,9 +32,9 @@ swap_file="$SCRATCH_MNT/swapfile"
>>   _format_swapfile $swap_file $(($(_get_page_size) * 64)) >> $seqres.full
>>
>>   echo "Creating first snapshot..."
>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/snap1 | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT 
>> $SCRATCH_MNT/snap1 | _filter_snapshot
>>   echo "Creating second snapshot..."
>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 | 
>> _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 | 
>> _filter_snapshot
>>
>>   echo "Activating swap file... (should fail due to snapshots)"
>>   _swapon_file $swap_file 2>&1 | _filter_scratch
>> diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
>> index fd04ac9139b8..7b2947a705e7 100644
>> --- a/tests/btrfs/293.out
>> +++ b/tests/btrfs/293.out
>> @@ -1,8 +1,8 @@
>>   QA output created by 293
>>   Creating first snapshot...
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>   Creating second snapshot...
>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>   Activating swap file... (should fail due to snapshots)
>>   swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
>>   Deleting first snapshot...
>> diff --git a/tests/btrfs/300 b/tests/btrfs/300
>> index 8a0eaecf87f7..00ffcb82eae6 100755
>> --- a/tests/btrfs/300
>> +++ b/tests/btrfs/300
>> @@ -43,7 +43,7 @@ $BTRFS_UTIL_PROG subvolume create subvol;
>>   touch subvol/{1,2,3};
>>   $BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
>>   touch subvol/subsubvol/{4,5,6};
>> -$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
>> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot | sed -e 
>> 's/Create a/Create/g';
>>   "
>>
>>   find $test_dir/. -printf "%M %u %g ./%P\n"
>> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
>> index 6e94447e87ac..06a75bff5ce1 100644
>> --- a/tests/btrfs/300.out
>> +++ b/tests/btrfs/300.out
>> @@ -1,7 +1,7 @@
>>   QA output created by 300
>>   Create subvolume './subvol'
>>   Create subvolume 'subvol/subsubvol'
>> -Create a snapshot of 'subvol' in './snapshot'
>> +Create snapshot of 'subvol' in './snapshot'
>>   drwxr-xr-x fsgqa fsgqa ./
>>   drwxr-xr-x fsgqa fsgqa ./subvol
>>   -rw-r--r-- fsgqa fsgqa ./subvol/1
>> diff --git a/tests/btrfs/302 b/tests/btrfs/302
>> index f3e6044b5251..52d712ac50de 100755
>> --- a/tests/btrfs/302
>> +++ b/tests/btrfs/302
>> @@ -15,7 +15,7 @@
>>   . ./common/preamble
>>   _begin_fstest auto quick snapshot subvol
>>
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   _supported_fs btrfs
>>   _require_scratch
>> @@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
>>   # Now create a snapshot of the subvolume and make it accessible from 
>> within the
>>   # subvolume.
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
>> -         $SCRATCH_MNT/subvol/snap | _filter_scratch
>> +                 $SCRATCH_MNT/subvol/snap | _filter_snapshot
>>
>>   # Now unmount and mount again the fs. We want to verify we are able 
>> to read all
>>   # metadata for the snapshot from disk (no IO failures, etc).
>> diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
>> index 8770aefc99c8..c08f8c135538 100644
>> --- a/tests/btrfs/302.out
>> +++ b/tests/btrfs/302.out
>> @@ -1,4 +1,4 @@
>>   QA output created by 302
>>   Create subvolume 'SCRATCH_MNT/subvol'
>> -Create a readonly snapshot of 'SCRATCH_MNT/subvol' in 
>> 'SCRATCH_MNT/subvol/snap'
>> +Create readonly snapshot of 'SCRATCH_MNT/subvol' in 
>> 'SCRATCH_MNT/subvol/snap'
>>   OK
>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
>> index 887cb69eb79c..598af611d249 100755
>> --- a/tests/btrfs/314
>> +++ b/tests/btrfs/314
>> @@ -43,7 +43,7 @@ send_receive_tempfsid()
>>
>>       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | 
>> _filter_xfs_io
>>       $BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
>> -                        _filter_testdir_and_scratch
>> +                            _filter_snapshot
>>
>>       echo Send ${src} | _filter_testdir_and_scratch
>>       $BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
>> diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
>> index 21963899c2b2..d29fe51b3ff9 100644
>> --- a/tests/btrfs/314.out
>> +++ b/tests/btrfs/314.out
>> @@ -3,7 +3,7 @@ QA output created by 314
>>   From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
>>   wrote 9000/9000 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>   Send SCRATCH_MNT
>>   At subvol SCRATCH_MNT/snap1
>>   Receive TEST_DIR/314/tempfsid_mnt
>> @@ -14,7 +14,7 @@ Recv:    42d69d1a6d333a7ebdf64792a555e392  
>> TEST_DIR/314/tempfsid_mnt/snap1/foo
>>   From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
>>   wrote 9000/9000 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 
>> 'TEST_DIR/314/tempfsid_mnt/snap1'
>> +Create readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 
>> 'TEST_DIR/314/tempfsid_mnt/snap1'
>>   Send TEST_DIR/314/tempfsid_mnt
>>   At subvol TEST_DIR/314/tempfsid_mnt/snap1
>>   Receive SCRATCH_MNT


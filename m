Return-Path: <linux-btrfs+bounces-2214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877984CEFA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 17:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD784B27CD0
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F46781ACD;
	Wed,  7 Feb 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVhUp7sN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zcGIiEUu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B581AC0
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323784; cv=fail; b=BQtaWH+/nxzUou3/XLn079TXm+GqKpv4gQN0oPGIptPr/+0qbHyGJ+EznZ7gkBBIXxArukh2ZDsIhSn8VyXe7eYmIkbHn61YODnFTBk25gtQBrrWIE1AfJp/o+g9yrRstP8hhTd+CzPGoKBX5RVb0nXXXg9TWtt9JbU6cbkGCDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323784; c=relaxed/simple;
	bh=cP6cqkgGsQhjyJvu+3zBIPBribAjNgwTpyxgBrAQ54I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qQj+2bkTyqQXadZt9KH4vwfU9+Qq4TzFUYXKqL0s7rq4ckOQrzMIVafv2W4vONWkBwp1+bQre3yztnQ9pbL81f6ajj1p9XxhgK0v7mVhvyp4edrAJ6xtQqqGlNFYyA1I1yb+5WbpfG8fg+WcL2pI8M56FNrdDOGYZ4cobbiBpTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RVhUp7sN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zcGIiEUu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417Fx0gI009813;
	Wed, 7 Feb 2024 16:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hT0S0AD+go84z6wnBFD3TD4UhSspJvOIkvpIxsoyPT4=;
 b=RVhUp7sN6P2t2TqAXHOv/2c3AksPea5Dmhrj7OmMzDSifxnRVLILy05ra3SxYwRZ6j3z
 N88lEcaE8cmtvjkPYoprVSZ1z8BUNowZRpkF2LW/ojV4wU70B9dBJMwkjz42qHytDjTe
 BPvcrhtZBy+ll7KegByph6+wlQtVhTDiRmXaMaSixZosqBDqCTaiknr++Ad1Ylo6MIom
 5TOuPa1oAinxjBRFF9FSH6vRRkvwLWfcYaUzgPsVNsW69ol3URN+5OaEai5PIf5vJWAR
 oOAbe7Lf2HGNr+Odb3BLjw4ixHZOws3XC8V/nAiMKFLrwLxxdVfwCxtC3rQtSvuOpwAL uA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdjcep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 16:36:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417GVvfR038387;
	Wed, 7 Feb 2024 16:36:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx92k25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 16:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce3Pb1jENHw7N4q916SFheAMrpR0gN/CgmFD7TNMiaGSx+CejsIBwdS0Ke3FJ2LjwwHrxSFD8VI9tay06VqA0TNx4Cy11MylHEQzPxhKTOWCPou7SFiOemb3wBLzSA2Bj1ad0z8Rud4eNo3/9MXjWmOG7SKGPVa10Lcslice47v4Espjg5ro23Kn8doxv8lO1k/z9N+qqIdyPFrA8XIjGSr1hPq2fWqjJEss63OOsU7A4+qToxoEsCJcFr9nSVIhbb1H5Elz+REftt7DL6jQGuGf8lrarNF4BZl8Nofdx5EZ78UxU4l/AJxzV/IUahIgKexT9mM0x+86wfkqt1+Dxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hT0S0AD+go84z6wnBFD3TD4UhSspJvOIkvpIxsoyPT4=;
 b=Xtvwh6/IcdkIPwsSOCU1NgkjRkrI/Il2FohNOwnNu6SEfpuegu3SEmfrptth7YXE7HHXE9+bTwG6x1/KbRVBs/pxInYz1Q4sJD7PCk27Nmf3AYcMFl7VR8evCPHpSycB1kAadRm/jHeAGlb3Q3DiU0cKe1Iy1yG8/lvPjOUbuOI99McwYpgIo6E7gXIW+kcLorTKn5oliO29ODhbE5cwRDNLxQOjvGAu0Dq9sjMJior8Q5kSj3DhrljN7xCfsH3SvVrsSqvNkQe8Jfjo6kB/sVSZZXMtPars8KZvEvDGCH6+fHcwK5N9EcDCSi2QE/o1SoROe2vEmj3l4ghXqehrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT0S0AD+go84z6wnBFD3TD4UhSspJvOIkvpIxsoyPT4=;
 b=zcGIiEUuGr4x+gUJuK0l4wEQuTrSRjUkF/5coNaqVa0fc7xSYmSeXyX66VjPOwjC7hLPZgXEvRlxbaXwDLI+zC4L2R2LCHyfsBCmk810JTn7ypB80p6pgyJd+NkCuU6ZqfnEKnm/nBh5V8uGE7ok5Y33VFcFRW16qaHu42iLefc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6266.namprd10.prod.outlook.com (2603:10b6:208:3a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 16:36:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 16:36:17 +0000
Message-ID: <d8484431-72b7-4fe4-a4dc-264f82af7c22@oracle.com>
Date: Wed, 7 Feb 2024 22:06:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: fix the stray fd close in
 open_ctree_fs_info()
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706827356.git.wqu@suse.com>
 <abf545db2a21d27c02f92b8a3be0e836fbd3cdd5.1706827356.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <abf545db2a21d27c02f92b8a3be0e836fbd3cdd5.1706827356.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 198a2add-5b31-4716-b07e-08dc27fae7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UYbaz8S2hE+uZ+EZnF1mduKdN/2Dp2q4VDRTTqBvF7NDc2t/IRibE2ZQoEYpBD0CFPNd1X+ct72YP2Tjb87RThMFtNEGYQW0L65OGIr27xWkZqTBuCiiVlYMO8qEymdvQqYlh8lCcWMhaLV8UlKdmTHji8Vi6oFcQyGrdcTrWdZUdn3+lUad+qyiwpOKQKWOCkXFCw8tnnVGBPlJ4eeV9v6zPFqt4klQdpL277uN8wlaBrYOQV8aJ8LDQ2aOeL62fwySiW9zkrgl3UH0dEVTwPBr4oGAydVYweSmRHMDOin7jRNt+wa1yCKULd4aoSoPo228lz9agp68cq4AN0aIkoGn0g7ebNDEgyyMF5TF6oWAg5VG6z9imlYdp4NB7X/318EvUmNOJf8haaWgIY1nKlgjpaeOrBkk09bz+5O18rv6IoXNuIMCJ9NhPJpMOBrkAVQMchhQbV+PeNmzqT+x9S2RHOuPQ9ebhz4UwnZPhVOQ8VgMpiipRlSuhG/B/UbNIg8K3BYpVwvdf6UNh5yPdbsKQ/iddWliMZWycl1ElZpzatlPabNtVqa3tfwhWz8HD8fv7AktEG+6Eg1jPbXQcazZH5/VxmrajL8tTU5nFTAGjI6A92ShKMVUzsN32ux09rRT16qCwOFosoURo0vgwQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(31696002)(83380400001)(8936002)(66476007)(478600001)(66556008)(6486002)(36756003)(6506007)(66946007)(6512007)(6666004)(8676002)(316002)(38100700002)(26005)(2616005)(86362001)(5660300002)(44832011)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFF3Yms3Tm4yR2hVdnM1OEs2WUFXV05vbTU5c2xlVDc2alRuVloxZHNFMEpl?=
 =?utf-8?B?c1JCbnd6YWVxMkxzVUVUWStONmF5UDlkdWVsRU0zaE5nZ1hCZkhMazAxMHJG?=
 =?utf-8?B?WXNOYWVFTnJaYjFKUDJoaHZCTjFWZWNWUDd6cXVuSlpVTjd3dnNMVVJGQlRk?=
 =?utf-8?B?cWhLaWU4RWtwMVFFWGxWblJHQ3VpZU0vTnJ4aUlSc3ZoYUZRV2NCb0xIZjl5?=
 =?utf-8?B?cWFCa20rN3h3YVhWbHB1R2hzUkJ2R1Q3RkVrRGhTZWVtN1dZaTlOQ2tPc204?=
 =?utf-8?B?MzVYaXN5MTRZZDJycDJqbm4yb3IvQ1hseFo4UzhxMnZMb2cxL3c5bTZlNHFU?=
 =?utf-8?B?VG1kbGFpVkQ4ZWZUSS9sbCs5NTBZVVQ5NzRHR0ZJMVd0dzRkODRpY0pQU1hu?=
 =?utf-8?B?N09JbWdCYjFrUDZSQUxlaXdYL1JSNDNFRG5zTURIREhqdDhOV0QrK2x0N3Fq?=
 =?utf-8?B?TVFwelZTTkl3bzVoalBmblp5YWFGdVFRUHVuNmUvelRkd2RBME9aN3ZMSUIr?=
 =?utf-8?B?dllnbkZCWVJaMTVIVUdyYklnWkN0YXBQRTd3MlFHdGw4OFJobjA5ZHZtR1kr?=
 =?utf-8?B?M2pabU9wVXd3S3FjZGVtU3VVdXd3bndBVWcvU25Wa3B1V2lnTHZFWkt6bm1V?=
 =?utf-8?B?U0VDQTZRMFFGS0VqMmxRelBrNGlQUWpkN2sxT2tlU2FvSFJhUEt2L0dLYzV0?=
 =?utf-8?B?UjJ0bkowTHRKOEpoWGhmOW9EaWpISG5Vd3R3b2QxdDA1R1Zrc2VKNFdsUVkz?=
 =?utf-8?B?OC9XdXhoK21xT2o4L05TbXNacFU5WkRzUlIvZlVscGQxdUYrYTcxVHJxdUNF?=
 =?utf-8?B?NUxNU204SUFxYlIwa2ljdGhzeFcwM0FWYTZiUW5tMGU3TlN2a0pleS9hb1dq?=
 =?utf-8?B?akpjTnEwKzRqelByT01IR0MyYkFTSktqMS9lQ21tZXlxdlljaTZBTkkxaTBG?=
 =?utf-8?B?Z054Sys4T01aUFUwQWJveE5kT1FpbGtNTnpFMmRTcko0TGxBOE1uMitRMnBl?=
 =?utf-8?B?M2hmWnRqSnpBd2FtUHZTWW5KeDZwNnYva2tGUEkwWHBMS0NkYjl5VE40UXVz?=
 =?utf-8?B?YUhDQmJDTGxHalBHaVpZbjFnSUd1TW0vMUpudzRPei85elpPM3VUL01Wd0VT?=
 =?utf-8?B?Tlp3aVJ2cEFoWXpNaCtLaWJwWFgvTlRtbzlPVjE4WGxQQVF1eG9qMy9ma2NG?=
 =?utf-8?B?eEIvNGk1bkF3SmFuRHRqUnlPZ2x3QTNyQVJ3UG9mbGhMakJVc3JVR21mVDJw?=
 =?utf-8?B?VVdVMnZDZFRTRmtId1JXaWRZWDBkUDVyTlJXZWw5YW0wU095V2tZMW1hZEpH?=
 =?utf-8?B?Z0hDYmhxWk5tTDhMaCtUanl2bWcvR2pHZTluaVB5L2RPWmJGNnlRVFY5T0Fa?=
 =?utf-8?B?M3ZsOFgrd3A1V1lyUEQ0dWVhQ2w3Z0tQUHByZHlEVFpYc294OUZwSXBRRTlr?=
 =?utf-8?B?Q1NkRm12VmhXNXAvME95NFliNWFRYUxjVk1NMkdMNVVIUkJyK0ZTdHU0U3Nu?=
 =?utf-8?B?OGQrdHNac2ZkYm9ZdisyZnJyNHBaUy8wS256Y3dhWllhWUdPUTk1cjVvMGQ5?=
 =?utf-8?B?cWJvaUVaM2FHMUZobUVNbUxRVGFFdlRZWHpqZFZSNzdCdGxhSmlRZXg2KzIv?=
 =?utf-8?B?VHR5d1RMazJSeVhnK2xIU2d1VUNZcnNyekw0OU54TVZsVVlrY21McWU3d3Z3?=
 =?utf-8?B?MjNNbzVxL2laSVh3bTA3L00zUVBKZ1BCZXFXNmp3VVFEZWxpS3BnOUt4cTBx?=
 =?utf-8?B?eHZUZXIxY0YrMm1WWExuL0tVcVB4b3lSdisrbXEzclltVmtpemxETmRrcmw5?=
 =?utf-8?B?VHVMMDhRdUJEMWhGNGM5SEZBUEVvZHlnOG9uZmZGc0x5WENVcTBQcGRIaDBH?=
 =?utf-8?B?M3VubElsNDdWMktXR0hDYzkza204TG1qcjhBUWFFMjU2SnRKT1RGUTJSWlI0?=
 =?utf-8?B?ZlN2ZzZ1NnVmeUdlTjhxNWVQeEkrQ2VIUnE4MGo3eDFjdlA1TXlKZ0xvR05i?=
 =?utf-8?B?bGhRYWFSZ09BR3NiVDZaSFZNVEpmREhkZEh6MVJxNFpGWEtzcVNlRmlCa0Yv?=
 =?utf-8?B?RXhScTgvbGNiOXFTdjlsdVVmbGlDWVQzL21ZOWtnaSs4ZUsvRXNLeWN0MVky?=
 =?utf-8?Q?8ZgSyNbXBpaKKz+B8oK03D0DD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wbF/r/1eohP5pK+tX4mvCrBJxXejuv27kH/lt4lFTf+R/N02AWbZJqcWCHvqo1tQdi+5PRxbqArI9TG5L99yitoDjad06UErQ7tL8mZ4BUGaHymP/vci6+/c+y+IgNhcSyXGkdxnTFAuqgaMIVnOYd0LOJ8254FJVwqvsDjskUDCoEjs9nv3BVHuTf1G+UACbIqtnbFcetxTHVq/GvuFpRPWksye85MCbEyFqaurw82R3VVz5zZoe4jH2QGVpo26gjiYGN+6gCj6RNC8Ux3Z6O9673UhDLF4yrRlI0Q+l1hfo03WDSEi2dj39JK6HkY3yWG0JomYKo+o79vTLSDCvGvipE+X61di7/1soUdjyo9GX/UZa5OHfdmbRDlmmrxWNXJ0VlmaA5JkGUqhtE+sy7ekjxq7Owb8tpinxmM7y5HTw6c48wC53LMmn4UHWd6lyD+e2pJqGgKn353HsVqJTvRFbbENtCA3lz7zHuZvl2GBUmZUVonSXDKj/JjhbaLmPDl4OX3iZX3lg1k+SPK8l+T07v4/yI2A7cawCNJp2fIerSXh8GKama5uHIevNtMne+DKWTb32SgJLwKp2kU/gf7vJ64dysInDnVd5imgeZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198a2add-5b31-4716-b07e-08dc27fae7e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 16:36:16.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1IRh5H0mzDkEHprIvCEq8JEdqgpWp3WuElLf+zwFDs1zLe2VJwzr980R0yXxSyhKtYkp575FVr4El6/mwNveA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_07,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=895 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070122
X-Proofpoint-GUID: SP0VlUYMaFrkhdyf6icWYRCQFsppPbq7
X-Proofpoint-ORIG-GUID: SP0VlUYMaFrkhdyf6icWYRCQFsppPbq7


> index c053319200cb..05323b2cd393 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -913,6 +913,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
>   	fs_info->metadata_alloc_profile = (u64)-1;
>   	fs_info->system_alloc_profile = fs_info->metadata_alloc_profile;
>   	fs_info->nr_global_roots = 1;
> +	fs_info->initial_fd = -1;
>   
>   	return fs_info;
>   
> @@ -1690,7 +1691,10 @@ struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *oca)
>   		return NULL;
>   	}


>   	info = __open_ctree_fd(fp, oca);
> -	close(fp);
> +	if (info)


> +		info->initial_fd = fp;

Why not do this in __open_ctree_fd()?
then in the parent function, __open_ctree_fd you could:

	if (!info)
		close(fp);


> +	else
> +		close(fp);

>   	return info;
>   }
>   
> @@ -2297,6 +2301,8 @@ skip_commit:
>   
>   	btrfs_release_all_roots(fs_info);
>   	ret = btrfs_close_devices(fs_info->fs_devices);
> +	if (fs_info->initial_fd >= 0)
> +		close(fs_info->initial_fd);
>   	btrfs_cleanup_all_caches(fs_info);
>   	btrfs_free_fs_info(fs_info);
>   	if (!err)


Essentially this patch converts the following nested open close


fd1 open
fd1 write zero
fd1 write temp-sb
fd2 open
fd2 read super
fd3 open devices
fd2 close
fd1 write temp-sb-to-remaining-dev-if-any
fd3 write good-sb
fd3 close
fd1 close

to

[1]
fd1 open
fd1 write zero
fd1 write temp-sb
fd2 open
fd2 read super
fd3 open devices
fd1 write temp-sb-to-remaining-dev-if-any
fd3 write good-sb
fd3 close
fd2 close
fd1 close


However the patch
   [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in 
mkfs.btrfs


achieved: (And reduced one less fd)

fd1 open
fd1 write zero
fd1 write temp-sb
fd1 read super
fd2 open devices
fd1 write temp-sb-to-remaining-dev-if-any
fd2 write good-sb
fd2 close
fd1 close


This patch saves the temporary fd (which is a helper fd to read the sb.
fd2 in [1]) into a new member fs_info::initial_fd, does not make much
sense to me. This fix is a kind of a quick, patchy solution rather
than a ground-up clean design, imo.

Thx. Anand



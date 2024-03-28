Return-Path: <linux-btrfs+bounces-3725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64F988FF91
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 13:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B368286680
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02897E10B;
	Thu, 28 Mar 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lFyKInDf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qb22Izxv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158F93A1AB;
	Thu, 28 Mar 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630244; cv=fail; b=KB4ERhvMSMoXMyXGKbH01y8v7wBgG+vTHSwqB9qfGnt73nG+rkrcw05RIhIZVxwjMiL1bRzIbbdmLDlQj9KrkgBOjNXCUyTOtc6yh5aw46ItKInC+hoqzMzH8HRjuIjbrcnYehgMs0XPMRqG6fuZW9E3UPUsk8qGEI00EbOrZR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630244; c=relaxed/simple;
	bh=mEq3kkyQkldQvdiZdEgFm77/6PFrLulgdeWMnYROWL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dNVJK35ngTvq6tOLp/scKOKA1rHzMqZ0uHgoEPvVVsKJUtogTBXktWZwg2ZIn25y7VviZKVNYrJi9Rws5tBl7saVDIF7woIetrYK1CRct33a3KcGkON12C5HdSJBRE4K1ZVZEkR4etxQLApsdQGK3b5N0a2XLgf9YlQsV748s6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lFyKInDf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qb22Izxv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SCeoO6023840;
	Thu, 28 Mar 2024 12:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eb5/csXb35YN7eTLxWgugChQ4WR5529nqRvjXf3FJF0=;
 b=lFyKInDfZJE/zz+0RSG6Z2rDm/F0z803N6SlES2jlvTADAMlRSkW5SeN1aylcRPwrxon
 Ru/o4SlnXl9WpsmovIYaM2bY8P54FUS6/ftMtkvQWGEwGrHEq6a91osZfOAsZuM7fr6m
 P3nexhVZKjVcQH1bw0hLBSJPmolQGZXOzqfa9s5aiPdSqZkUGNATar+ri4M7WtJKkLhe
 8jHtyJtC/mk5x0D/4sZaCvULiceKUu8IyIk3MxlfbJk6sGR6MB3/HZIJzTbg64pzYln6
 aGAcu3Fcw0YoGfY/Nk5x6NRrbEGrs9sI+rspGrSad6WPp9FOT1DvbBgzLvUtXJ3u4pz0 7g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2s9h02p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 12:50:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42SB8b6H014379;
	Thu, 28 Mar 2024 12:50:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9xwhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 12:50:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoQAvdRbn+feSv/3Ya7lVBTfafnQzhe88vnjdieWkNF/utgBcO5l5TdRznR7qsO1kmTgP3ftADQuNeeTmBAw7berontlpoS0vv84emyKdwu4dkxpGTF7K2o1Qxp1wxKepiS5VtIrKbOXFVnL+UfkyslsCd7VnWTbAchGiFwIqjokn9doTgGjI4O9io6fRFp6nio+efOQmbANpoqryv8JFIO/HFn+9ivDOWV/N1JczNaYFh7uACb4nhFio9xvctZrhsYMb8CDJQrzFGrYx9UOSG17n+SIw3SeJ/Ds+rHoop5IJBCWxO0satZ0F4TDDpspVL9lxp0NGB6xb8xkMNIl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb5/csXb35YN7eTLxWgugChQ4WR5529nqRvjXf3FJF0=;
 b=mq7j8EwDOrzEWOMCkkalbU59lDOd90f9ArED6ERexpovK2s8u6LKxQCyO2J1CaeevmRYDZtfYx1y8p8dFA0xfr3rcaaTsgJbM0PtK/Hm5yYFwtM9UUlMgqk4kRwmr6YxPz5l1bNobx4SSWKK9PARMDIB98KlGSyj7MwcW291Qa9Ym2srZoFnUTc5YjGm2wLRH2YdiEwByPBOfRPZOW4CAK8MvMnIJxhx8L2nsAloOjBPKD2OEnJGomf150YUA1Hor1OVKuJSmmzZzXBr3J7/O6TotlQ2tlLPC4ZtrkIIR5l8O9KPinO1sgo7X+UeBUg8xfzxDXwEtUN9niUWqYTZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb5/csXb35YN7eTLxWgugChQ4WR5529nqRvjXf3FJF0=;
 b=qb22IzxvKTZ2mMwNJXKvtcNGUqY8kMRJLxbqU9hB+MpI/D2z7iSMON7iTQZvJiaEeUWPJnqIWRffi2Nygennogx4THBspa+iIuc25m4CTxFI7MZAuYkRmapoM01g3wO47PbzlQfbY6BBQmsizn/lfoPynV1VAvoxbNEu13aW0Bs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4600.namprd10.prod.outlook.com (2603:10b6:510:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 12:50:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 12:50:33 +0000
Message-ID: <947c24f4-5271-414b-ae1c-a359fa7139db@oracle.com>
Date: Thu, 28 Mar 2024 20:50:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] btrfs: add helper to kill background process
 running _btrfs_stress_remount_compress
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <0689a969e9834f4c2e694404f41f0bf8b7a34a2f.1711558345.git.fdmanana@suse.com>
 <9383298f-a74b-4e2e-8f62-f1359ae68bc8@oracle.com>
 <58997574-3333-4ddd-aa37-3b177f19c0e0@oracle.com>
 <CAL3q7H4GjntZwft1tixdOK-0Kj1HyFEmixMHopA+XMP6nS1aWA@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4GjntZwft1tixdOK-0Kj1HyFEmixMHopA+XMP6nS1aWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4600:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c18a43f-1563-4c56-ecd3-08dc4f25a820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	33Rd6ZKjwyCzKKX1zvnf05IpW/QFAfUEq5/SQ6VTtfs0j+y9sz29Mi2Slt/HgV1grBW5pJ5zHabCATF7Gcv4NYAOxiax5135y+RtdhEFMg4bvKCMEPYmbzz+6FfCgsvh+sjbkkZFNGHKDkqN9AjJDFbU3GmFle5sN18APioDmPGxCjnKb0nw5/mfyc9uPVV9B227Vs+5z/BW/4c+zDGP1GOie7rCNhoEY5PwAVW34Cn0jR7T1XCrsIkr5D8fXECqqbVB0vGqv1DXABuTAFfvZNGqMLsv6e1L7n76qf6xDM9JFzObnu813dTBq30jbrQW/GZ7Q2XOlPK9oew1oz8onoKUehErTtiyM3rudDTBqr3h3BmCdiUYfC8NZW2diz787t1GsxNTkLZFnX4Dgnoe5GsXz+KOgF/2JmR0oDbnU4RMFVBzj0jKvCvgZgRxyhf+NIcZXwLq3qlwqjNx33HPw3bt0qygiCDGyI0sWPUNWO/Q3Kl9U1aYcmuODJfhNlKvMko4DQKYFP7H9mRBynPNDR3sDMcZjW+MnMbrWrLyAUzliunv1C8ATOxl2kcorG/u+537Ih4y0dLio2axyi/hvtJopJha8+1p7+QRA9Y8LwCsGIY2Cp7HfJyBCuFcvkQe4CQQsrnDkNwBEYQUoCXNquB5rz35hQvB0dKqz7HLt1c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmxRSGRaUk40NWZkbmlLbE1VNVNQMmxrL0lHdnRWTEIyS001bFFlaVBMNTNH?=
 =?utf-8?B?Nk95b2N2b1c5akIrQW8vZmp6eGhCWlpCWVF2eWE2akpMdlh2ZVJZOHZUUDVM?=
 =?utf-8?B?SndTalpDRlovNklwZ28zU2tGZW5jWjc3cXMwQm1YTjJsOFZCRk0wa1JpYW94?=
 =?utf-8?B?MlM5eURlMWx2S2NmWU16Vnpuck5ZTXdaSDZVQWZ1Wm9oRUIrZTN3V0JCblJ2?=
 =?utf-8?B?WU9BbzBDMkxpVFRvUVVXWktGQ3psd1ljRVpkYmFHWnNlUnlldkQrYVBpUEZM?=
 =?utf-8?B?cVg3dlV6eVFSa0U5S0hEcXFVR2lPMzZkd3NMYVBWeXNabDh4cDQzR05BdHlT?=
 =?utf-8?B?dE9hK1g2UzBlaDBTRjhpbkM3Qy9HY1hSc2xuaVhLYWtYYnlUbnE3dTlvTDVj?=
 =?utf-8?B?TEgraGtyZUhDcWRNMklzMDM4MSt4OFlEc3dZM0V2Qm9ZK0hQRHgrWHhLRG9x?=
 =?utf-8?B?aFdVZ3habjNiajJYWVZ6U0NwQXNLVERtOUdyc0VqenNUTHlqalVWQ0d6WSt5?=
 =?utf-8?B?RlozQ250L2FNUWpXT0tYd05WNnNaWVhoUVJyNk4rVUdaZnJxVjhNMUVva3BC?=
 =?utf-8?B?QUVVNWJLLzNGdXlDQWllVit1c29ON2JHdDZkRkVtMEF3MUxwZFZGZG5XeGE1?=
 =?utf-8?B?MkQvUERuWm1aelZ6OUtpaGQyUVhLSVVmZFFkRzZ0Qi9UUk4yL2lHZFJyUGFQ?=
 =?utf-8?B?bHZTZzlEbnNRRmxpSmx3WFk5d1E5V24rdVBEamMwbk5TZnhzdFJtS1B0UEcx?=
 =?utf-8?B?aXI3dFNneERiZEw3anV1ekpucXBaT2I3TmlRQTIveUVyazBseGVHSnN3M3VJ?=
 =?utf-8?B?a055eEs2aGl3eEx0WWJtMVpWcFNpVDYySzI3Z01KcE1TTFBtNmc5R0VWOThE?=
 =?utf-8?B?bWdWZU9JaTFtdk0rbjRlZXp2Q2N1elplNTQxMENtL2dENjl6bHFTSURHUEJF?=
 =?utf-8?B?MUlHUVExTHBpY29LWGlBSHVXbE9SOVpSTVV4cGxBbGY2NEYyTE9JRGhFOXlL?=
 =?utf-8?B?QlFtdUN5clZpM3VrL2NTRGNaVldxeUJDQnVrbFowYVY3T1J4QmFqSm5nRnk3?=
 =?utf-8?B?b3AweFJzSWt1RUg3TGlYaFVHellHVC9OOXZhYU9KeFp6R0YxMVYzU3V2RkVO?=
 =?utf-8?B?azRGUlJwcndrUDAyaU80blB3dTgzOXFnNjZDWFVhaVhzakgvMXBzWVc3Tld2?=
 =?utf-8?B?N1p0Tlg5a092S0tKajl5ZWVWNFZyUDVHK2pHVG9tZ0RGTW9qRitHSHRjY0Zi?=
 =?utf-8?B?T1huSDZkMDZPZFcrYUFkNVR5Tm1iTVd3a0tBRHdteFRxdHAvaWsvem9KcExI?=
 =?utf-8?B?cU0xcyszOXM1TGdXUVBlUDcwSzVPR0h1cUd6S296VHN6UkFOdGJSYkh3T1Y5?=
 =?utf-8?B?MjZhdFlaTkFDaDRmMTJLaW9ueEdGUmtQMEVxZ3psUlBOZWh6c0w1dGtGcFMy?=
 =?utf-8?B?U0RpQi9mQWRKbU91czJEbW9sM3dLeXFqNHRpMDJkOSsxSHNYL0h5S2xBbFZz?=
 =?utf-8?B?cWVaNzRqTXVWK3ZKaWMzNjVBcFkvM2thcGl5eExFOXdyZGN1VGR0ait4WWcw?=
 =?utf-8?B?ZmxSN0FCYUlrYnpqWEJrd1oyL3hVeU1HRWNoUm43ZjVGenNLTDl3RUpTa2Iw?=
 =?utf-8?B?cUNKY1dQbDBiWFJob2w1YUR5L1NYc08rV2RnU0xPWHJmUUFTQXRtQkwrb3Vo?=
 =?utf-8?B?QWJ6MXR5YVltUS9nNjc2TlNrT25HS0RFME9MZHVhUTAwNWtMRVF5eXdhTHNT?=
 =?utf-8?B?U3liVEYvMTBLdVEvMThIb0x0QmQ4ZFA3eThVemREUmx5Vm5YR0Y1dzhNZDFK?=
 =?utf-8?B?a1g2OS9tcGQvbGdqUmc2Nno1cTMyeXVONGFwb2hjb2lvUm9ndk96SWpmZWxZ?=
 =?utf-8?B?MlhubW1YWC80SEJNeDlubUxSZTZxaWZoRUs5RXA0a3RkL0o4SlNscXRzWVgy?=
 =?utf-8?B?TTF6WDZyQmR3YU92NXk4SDlQZzZjT0xkV1VrNzZ5SVhSZWd0Slhxdkhhd1o5?=
 =?utf-8?B?bDk4NVBJWDR2R0h2RGxJU090bWREbktTb3V6QVZxazl1RGtGNXBDRnFPYjg0?=
 =?utf-8?B?NU5rMmtjNHdPSVArbmJEUFNDRTB3UE13K0JEMHpHV25vNVNqclI4RUs3Um00?=
 =?utf-8?B?N1NuUDJMVGRKa0RPdUErZjI0NGMyUWEzYzcvVzhYN0tiUjRIb3lVZHJmS1gz?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rrm9r37MehnbW/AeBM5ztEPQF4pacHRDxES1GGaEQYm2JR5qvmXsscmhb4qF3KsC8Fx3DJgzBcZCxgoygn/URH4gDlCCujVd8mxqRUiNFXplBL8D+TuBSwthSoVE4L6fbnV8F06pYaNhnDHxXBxeXg1v7cmUKKXaMYCE+bdvBQdKFlCks0qTp/zFFjwK0l+c3ut3tkToZHMNlI71l1S36u19IqAIzc4Igf0Tb1uhgxTuHuD/CdD/egnKJOHG4fD42TRtrafOxGzg1aHTKA3TCm0NprReGRYZTkMLBuIN7wIGH35QCtcgN1KyztcKpbn5ph8zIvIPK6zlFVp4senC8tWrBMaIGtUtKAlc/5VsibsXJrnZCkzV2ZQnmiOaZxPw8eeRAkfuP9w/gnWLwdPebHOQTaQSDUZj2hMPmaUZzdhLa8G1ys2q/6wfvoJWSMPNsnLKapV+pVbHp3Gr0uNAhXviYnYxyULi8zMTpXnGCEYdltaAVJKNTKVRlP5cCILlZu46iTfo/Dc4+lvmYI/C1urU0Qk8TziKe99Ke8uCXSmUOCrzFeucmV2KFJQpy9jByjwp01ED+ZgjYxkSGFAptvt3u4c+qlC1MmkwvlqJSCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c18a43f-1563-4c56-ecd3-08dc4f25a820
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 12:50:33.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxLi1O4j4nPzW/93aEI8P+x6vO6kkOXX1sKr3UmcLk7WZFQ/DGh4HCSzGCyGyThSwzVBt1+qhrms3nFrCMSgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_12,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280087
X-Proofpoint-GUID: v3DLvVorOqveo7yR_QS8Q_08atEmUYNN
X-Proofpoint-ORIG-GUID: v3DLvVorOqveo7yR_QS8Q_08atEmUYNN



On 3/28/24 20:03, Filipe Manana wrote:
> On Thu, Mar 28, 2024 at 11:46 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>>>> diff --git a/tests/btrfs/071 b/tests/btrfs/071
>>>> index 6ebbd8cc..7ba15390 100755
>>>> --- a/tests/btrfs/071
>>>> +++ b/tests/btrfs/071
>>>> @@ -58,17 +58,15 @@ run_test()
>>>>        echo "$remount_pid" >>$seqres.full
>>
>>
>>
>>>>        echo "Wait for fsstress to exit and kill all background workers"
>>>>>> $seqres.full
>>>> -    wait $fsstress_pid
>>>> -    kill $replace_pid $remount_pid
>>>> -    wait
>>>> +    kill $replace_pid
>>>> +    wait $fsstress_pid $replace_pid
>>

>> The change first kills the replace and then wait for fsstress. Was this
>> intentional?
> 

> It wasn't.

Ok. Thanks for confirming. I will fix it.

-Anand


> But after all patches applied, everything's correct, we
> wait for fsstress to finish and then kill replace.
> Do you want me to fix that?
> 
> The sequence will have to be:
> 
> wait $fsstress_pid
> kill $replace_pid
> wait $replace_pid
> 
> Thanks.
> 
>>
>> This patch is causing a regression. The replace never gets killed, as
>> the echo-comment specifically states to wait for fsstress and then kill
>> the replace. Following it fixes the issue.
>>
>> Which the patch 7/10 reversed the order to fix. But why?
>>
>> Thanks, Anand
>>
>>
>>>> -    # wait for the remount and replace operations to finish
>>>> +    # wait for the replace operationss to finish
>>
>>
>>
>>
>>>>        while ps aux | grep "replace start" | grep -qv grep; do
>>>>            sleep 1
>>>>        done
>>>> -    while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
>>>> -        sleep 1
>>>> -    done
>>>> +
>>>> +    _btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>>>>        echo "Scrub the filesystem" >>$seqres.full
>>>>        $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1


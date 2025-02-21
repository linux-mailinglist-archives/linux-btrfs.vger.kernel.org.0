Return-Path: <linux-btrfs+bounces-11677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B7A3EA52
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 02:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F0E3BCC9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 01:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFD01B2182;
	Fri, 21 Feb 2025 01:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A2QefPp0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VN+lTs4k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40F2AD0F;
	Fri, 21 Feb 2025 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102526; cv=fail; b=BP1sNn1sIZTLmwppLoRXB8FY1JWIiqJU6RwLjVUgXLC92Ieh7xbXkBUdbAU0EsIrPBm7rleCeJNNdn+jFWZ6isi21WQkTcZkm5oPSTZdgstF6JB7a0/0v5b9jqGy9FUmUGN4X1wlwlpHtFLMFBCtLhaKCJ8sNyta9floXJASfQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102526; c=relaxed/simple;
	bh=gX17t+gHsNvel1k0XB6IHYYJ792G8fDBYuofeukvYLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YtwKEe9jJCGOLy2LzE7enfQgV5TegYgYutL80ASdLkF845ghPx6gDZsLvbOCKFoJT1OTD1GH7jqiqz4B0+1XIT9s6C8QKtRk502XR6tJ1vAqaooZoNHFMWpTqUefqKbAAV389jMzarJQbTOfy9stLMmgmXSyw5zXdE977PQxpek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A2QefPp0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VN+lTs4k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KLraCw027084;
	Fri, 21 Feb 2025 01:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fIYGa4IoUstnzlDqCSZiEWy8MwdJ9YXD84QUpMWvUTM=; b=
	A2QefPp0xYMPaUyBFKkqpMWhmPnapaGK1lpwDRraExuyaODsj5+ElSuCTOMwVlUA
	9YXmakYI0H8tpNCAs+T0rNxICEqjzu/J3by0YClW+n1xAAULrhhoCc4uVunf/qnj
	GtGgVaGfTArXx3hUtuCc7UuohixgT/jYYXJM+Oia27854RCqnKH//MzL4EzistPX
	KDVOLcJ9ONcfi4ECPZqk6ydfjR9Pg7472d3rbzvz5/jnPyyLJ1NhyOxYpHE69MB0
	/gV3ComSkNAIWx5zFr3p6YaoV60wK8dC2IbJ8G0nX6rDWD4VUftB/NnNH9E+1b5Y
	tkxCToCatzBDsYgt1NCtmQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00pwcwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 01:48:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51L0BAWH025217;
	Fri, 21 Feb 2025 01:48:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w08ys4m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 01:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J08q980Ctppl8sPOY4o48JaxsXBGWoY1qw2cc48G/h1C7OVr6EUdext1GO+/Oj1Sl/TWAjyohWVxPINrTbcYJLySf8rp/gt+g7iPYe0HKkp2yj9SqTdehhegdHhA4KbBzcHHs3gzCrD6A5s9QEFcBU5qh9p0/H8fthvdJBRsNVxl7FP43nm/O1clx9GR1U55sv+Xu6Q8tO5g71rOEMk+NJyVa0jR54CFjWh1cRf3MKTUHL4lHkvM4mG1aQgtn36EHonTOG1E1zwzd3IeAxHn0GTUSNoVuQVJNlt1VVjOeYwYGGw1KQA5pmODOKtA2XgvZhLfRJEjDYFCia6HgqSUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIYGa4IoUstnzlDqCSZiEWy8MwdJ9YXD84QUpMWvUTM=;
 b=kLrGaw925AQ28NTTDkHurFMXmvmKYwSsX5Zf6RrzlxmDKDAcKjlQ4yudYYppiAOSuJXkUsnns25hllVK3ndcec3g3T3PELqKdmNfUQIoV8ppW6r54l9pLjHzSPfHgJfUk+FUGL4v7HK2IFRvHxOWJyoxifxv9r47VWHQxVJSC85zV01+aqRBXm/M9qz2TBBsf7LkyyArKfKvY+tcQCfahLtTYCO7HDPsaC04zhE2bggRR69XoG8V/hZXD5Cw0t75YSYdfk/228KH86VHG1txYDYVa4VuZmUWYP5rH76xFBWVJe6hIBh0ft4dzb6MddXa6RJ1eB3LbBYc1PTOWc1/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIYGa4IoUstnzlDqCSZiEWy8MwdJ9YXD84QUpMWvUTM=;
 b=VN+lTs4k7IdUrAasf/bfcFwx+KhihjXb11lWdO7j0PqWzoGyxuWeQj2P+iI8BQjpHMD8uMV42m8g33UIYmSY4phMlUPXYbhS84n9p30JVi7z48O9IfeNAID2+HMAtTpPqUNAaRpwXdBgSwqIynwVFhcwe0e28Ifc9s+nhf97m00=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB8201.namprd10.prod.outlook.com (2603:10b6:408:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 01:48:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8445.020; Fri, 21 Feb 2025
 01:48:15 +0000
Message-ID: <bffa58e7-e34a-40ec-b0d9-368224dd22ab@oracle.com>
Date: Fri, 21 Feb 2025 09:48:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs/254: don't leave mount on test fs in case of
 failure/interruption
To: Filipe Manana <fdmanana@kernel.org>, Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
References: <cover.1739989076.git.fdmanana@suse.com>
 <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
 <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com>
 <20250220170333.GV21799@frogsfrogsfrogs>
 <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b19162-04d6-46ff-f5b7-08dd5219ce61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTVYdk5hN0EwN05BUmg3OTZMdk8xMU5rdnRoNFQ5Q1JhSFlMajYyMllCUGZN?=
 =?utf-8?B?akJqcmtUQ2JIdEFTZS9BVHhRY2EzbERTTG9vZlMzaWlORm1TNHBpWVE5T3h5?=
 =?utf-8?B?ZXZwSGtuZElFZERjWXpta3phYTdIYlZ5dWJKUUlwcWJLaEpNeTczRmNNRzVS?=
 =?utf-8?B?cVNyc1FjM0F2Tm92SjhIb3dkMkJKVjUzTGdVYVczSEJvYXZ0ZGVMVnJobXBk?=
 =?utf-8?B?RUNOVXplWENSdnF3VitWaG9qS1B6N3ZWZVROSGRXZ2dTMkJlZmF3WjlHL0V1?=
 =?utf-8?B?Y3dOdzJpSTFJbDZYUGdnY3I5NW1Hd2o0Y3dTSkFKaUdqSUFQRjg0YUluNG9m?=
 =?utf-8?B?ZTJQWXBjVEx5aXFiYTBEeU5jWW52TlhQSXFDT3M0a0x5WlJLSmNIWTJTVURN?=
 =?utf-8?B?RUJKQWFJaXRieXRkaVRrdFJTcTljRHlURHY5Q2pFcG9QRzgyZ2toQjZ5TThO?=
 =?utf-8?B?UTJ3KzVPNXU0dThoOThjQlR0aEhBU25ST3Y2U05qK3phV00vVmU1bXg0ZTcw?=
 =?utf-8?B?V1ZRa1c5Qld3ZWhRdnVhVWR3aWVnT1pVWXRGZ0x6Z2MwV1kwSW44WnVLZko0?=
 =?utf-8?B?NmE0SlFuT1ZoeUhXYjYrUWlZR1orcnlrbjFkZGFJNkFPMzNmUU9GeEllMURO?=
 =?utf-8?B?Wm1sL040SG12UFd3TzhvandySVk3RzYva05QbzgyTWZpZ3M3c0JyMjBtdUVH?=
 =?utf-8?B?b3d2WmlKUFhjZFcrWHFzeE41UjFUWnhmdFJPZG9temVzTFlETGU2V0tweU9E?=
 =?utf-8?B?VUM4RnRGdHFucmpOdk1VVUtCQXFqTDhkQjBhcWFwRjV6ZEV3WnprMDhKNGxq?=
 =?utf-8?B?YWVxaHQrdG5CY2drS3JMajhCN0FhMGFleGgyYkk3Ym1HbkN3cmxkbVR4QTZa?=
 =?utf-8?B?YmZNK0dwZklrZzBoVXkxbTM4OUpnZTNJQVN4QWJmYm54UGxIK1RkV2F3MjVt?=
 =?utf-8?B?ejgrNWpCbXd5WWVYMklOS2xncVBUd2JBUXQvbldCMWhwWVRzVkM2dzltL0xD?=
 =?utf-8?B?dVhYRmZQczkzNlhvNXAyMnZ1VlFObzZUcGhGcDVvWlNKV1RHNHlNYkxlMmVO?=
 =?utf-8?B?U1A2cnhKZG1LTnl1Z1o2OE5oVGhGU0pLM3ovSURaZUx4bG1sTkdMRnZESnZU?=
 =?utf-8?B?UkZKamo2ckVaZjQ5R0dKY1pTYWN6eFdCd04reTNldzI3MStWaXprNTkvZC95?=
 =?utf-8?B?QjNKbVRpSDRvKzVuR1lNSkF6dmhIZkVVelg4UkRvZmVBa2M5RFNESlpRQTZV?=
 =?utf-8?B?OExOZWtjTTQrcXJseEdoNXBLMUVtWTI1eGh6OUZaczhMaHk2RkhNZTJUYk1y?=
 =?utf-8?B?aE5wUkVMN3k5dEJwaVY1MXY0RDdnenJjVGpVM3ZYdzhqWW84dFdsdmJic3ND?=
 =?utf-8?B?Y051R3ZlVllvOU1hUGtObWs1dnRJRWwrL3dBV0tjTW1jYkh4aTIwZExpckVD?=
 =?utf-8?B?TjJLem05WWorYnBwWnpIQ1lVREtjV1VkVWtuVU9NK0JsWS9KTFFOMUwxMWxQ?=
 =?utf-8?B?TlY2NzZ3eTJuZlQ3b0llMkpFWmxvN3U5NDkyLzhGNFF1THQyaE5Ja0R6SVFM?=
 =?utf-8?B?Q1dtUWROYWdlNDJMbGQyNjBGRmYyRzUyRVlySUp2L0RwWGhFS0VseHIyc0Rj?=
 =?utf-8?B?NTVIWEV5RjlNdUFOMEpxSmxlUjlSSXFaMkxOc2IvVUdYbE1oRHdIeCtab2s5?=
 =?utf-8?B?L29KZ3p2bXlGclNiN1pFUWhGL2pwSFVScStENlQwdmp0VFE1UzA3M0QyTG01?=
 =?utf-8?Q?g703ADZbbDrYRVTVW9wWJ6+H/dIxn+OJPHepsmP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RStWWk95OHl4VXJ3dnJGMHlkRTBTKzVQY29wNno3SHhnQjlIQ1AwVisxWTN2?=
 =?utf-8?B?WUY2Ry9wVDdFa3l3VlhoQmJpaFhtNnU2NFQzc1lFcHZTSE9XM3RSNUxCWTFz?=
 =?utf-8?B?UXVOaUxWdDBXV3l0a2REUXZVeDBIdUdpM3lxVlF1VzN3dlV0UUM3YUQ0Rks1?=
 =?utf-8?B?NW14VDlPTEtUenl6bmgrbzU4bVdua2U5YzdzL09UVlhSdHdUenRRbjNybmR5?=
 =?utf-8?B?aG9TUjBkOEZrNUs4N2hVK0pqYk9vZFJPRy9JYjdYNTIzRDQ3WFkvK25RZitj?=
 =?utf-8?B?NVpVQ2xtTWRVWEROazlRVnM4OXo2SXdkbG02QnFVbnY2TWlHaEVESnVMdE10?=
 =?utf-8?B?WXlEVkVmRjdwRnlLdlRFQnE1TEFIN2NsM2FvU3Z2OG5DVzlFTnMwMG4wbmwv?=
 =?utf-8?B?anpRWVF1SUROQUdVVkpMajdvMEluV2RiRUs1WnNqS09wWVFzcHo0dFZRaFhR?=
 =?utf-8?B?RVlnaGZhNHVZTll4Wm1HQStYWUw2LzVlQWVSUmZuSGE0bXpUTFlpYThWN0V0?=
 =?utf-8?B?YndxcnhBM0FQMVBabjZVSnhvOEI3Y01rbGZMUm02NUFKaW80WWZycFRJYmRw?=
 =?utf-8?B?MURrTzdTZmJsVHBnQmo0eDkzckZ0YVVLVzVEZHhuMnRrejYxcVVkdk1nQ0tQ?=
 =?utf-8?B?RmdBeW9rRXVwOFRjWjcyRUhDcGVMdkhiZnMrdUVGdUdxVmxmY1VUaUlPQlpn?=
 =?utf-8?B?TDBEaFowTXZaQnBRK1JIYWYyK0p1SUJWU3ViMEFuUnU5NmVLSVZWM01nZVJX?=
 =?utf-8?B?THF4TjNYYUtxL2taQ2xaK3Y1bG9qTXdxa2pxSXRhMzNyK3Rqa3pTYko0ekdJ?=
 =?utf-8?B?cCsyN2NEeWovZmpNVjB2VmFpTEw2WG9GOXl3Rk1FMjZDUUxxeVVSSVJyMXd0?=
 =?utf-8?B?eW1vMmwzTUFjVTlEcTV4MU5pNWRnOUs2ckZ1Q2k2RWo0NVY1L3NRZUdDOUVQ?=
 =?utf-8?B?eHYwU20wWjExc1R3NG5zd1M1ZmxydC8wWnoyTWk1R3doaVVacGtoTHhCZmxu?=
 =?utf-8?B?dmtsekpnWkUvQUMvUWsrcFQyUUF0SjBhZGllOWN4VDlkUjFlVFl6eTlFbmJ1?=
 =?utf-8?B?Mmwza2VwNWxJT3pTbFlLRnBXQm4zRlI2R0thYURENGppMTZWZmI1b1FkLyt6?=
 =?utf-8?B?Um1CTjFVa2xnWk1ScEpxcXpjeDlQZEI1THJwRDJ4ZjZqakJzZ2hIeVU5L3dO?=
 =?utf-8?B?WnBOS09xcVBqUVNVZFc2ZXNid0V4NFNLc01NQnZhRlV0Smp0enAvaG83SDFx?=
 =?utf-8?B?NmJwYlhqU3RNcTZweFRBTVdIQmhFMmYwWWh5eHJRZ2RsZjAyTGlFVlJZdERp?=
 =?utf-8?B?NjJ4M0xEa2VJT0hCQjdNQktaNjVzaTBWRWNnWTR0TW1VL2FvTXo3VHR6UER3?=
 =?utf-8?B?czZxSm5XMEF0TnZnb2dpeldmYnRjeEhZMFpwbXdvQ0pFd1FiNHVteXVBUTVB?=
 =?utf-8?B?dFlTeVJtdGE4ZTNMNFRGRDJIR1I1Mk9abm5mcnNaMDY3T0kxbUpVbEUxR1Fi?=
 =?utf-8?B?YitLdG90M2E0NUFsTGQrY2Yyc3FtcC9zVWpuR2VHaWdxdGZRWlZCN3VOOWZw?=
 =?utf-8?B?Qk9Gc2Vjcjh3Z2ZnWXpvRnEwS3ZqRnh3K0RpWVkvRW9tQ0NSZmlla3h0MWps?=
 =?utf-8?B?T0VoOEJ2YUxRYUZiemlIdXR0dmFXRmN1b0NHV0l2Mko0YnJHV0pCWXJsQ2FN?=
 =?utf-8?B?TDA3em9sUmNkZjZ2ejlUZFpXUTMyUWZzbHo3UW5QS0JGK2FLZFBMV0x1Q3lw?=
 =?utf-8?B?R01SZ05TSEVVT3NyZmR2T2hwZS9mbzlQWkk0R0JRSVhhd0lnd0VrWWFCN0s3?=
 =?utf-8?B?SFE5VG0yZFJuTk9VK1doM3NScEVORGJESW10cnFzRyt5MVNzSDhPNXliWFcy?=
 =?utf-8?B?eHNNTVZ0b09hcGt2alJCRzg5YnBrZzZqS0dxNFVBVFhIcE1OZ1MrZTI4Mk11?=
 =?utf-8?B?MW5VWVVWNE1nUDNZSGdIb3NWMkNJVW5vdGhYVld2cmZOWVNvKzVDSW5EbklM?=
 =?utf-8?B?ZE1jNThyN1dOSUE3RDRKVmNwRXd2ZVNOYk5uNFpodnFHTlVZb28wVmZuV1hC?=
 =?utf-8?B?ZlRIaDlRRG9ZL2R6TUdqUW1pYlk3dVRLMCtGd1hibDUwU1BqYjBLMWlWdTJJ?=
 =?utf-8?Q?7U7HuSWT8uMchaYQR78ttfeaN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sCMB6eRZJBMOh9/XC+mW4raUOEbYc9Fg3VxtNS8ZHlmgDzVZK07C17DCrz9pBjujeHg4357k/R8aFRcAp1ipSfMtuC+FCehknPw8nl/+wslR39Gz5kiFQ+zQDmrT8EAcBmw1IHE1IjsPbH9tBe72vnBp2dTbV4lXuoTvrtIwXYFaoiV2r4bFMsRr7f/RdZbqT8Iy2P+Cjqgpz7gTBcK0yPI1HPuYwEdigMM7cNX0xil46Q+7P3L0GcRabrpJFBqzZlQME5gVVpJ1fGMcnG7ziTIpqt8kwcOh5/Hxvfd8gWKmEGEiWmY1QGduWi/GS7VO2Q+Odco3cQnCekoPQEnjIl3Df8xvpfEmhP3FpsNBqmXL3y8I5txi8//4qFlCeIhJPBsMgNAUYcw2CnQpgnRUYdy/tT2J5118hp9KqpklAJ1M2KtGyJ0c0AhBOjJ+vDGZLbsrwxwdQEoVzsecp12i6KaZWwEmAHQxKLenMAAn9YFCTqRcgDb0mWZ3+G6iVD5rvAJk1JnSimpRf/qGFHF42e/y+75ZyAUZc/1H8MZqVBulmCcoIug2uaPJY3aArDciy8w64b0xHc5kLPDiGoH6P4x2nANu22p7dizEegcU0Pc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b19162-04d6-46ff-f5b7-08dd5219ce61
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 01:48:14.9776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40nRUFfUrG5BqLn+cX0eUOquYLW0dxVkFQ/PZBI83O3YhNcDfYaSKHAgiHWWUdb8j2Zem+8eNpWlmwAgY2nd7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210012
X-Proofpoint-ORIG-GUID: l6iGUCgiXXGUm8G0gv7K0yruo0tvpm_o
X-Proofpoint-GUID: l6iGUCgiXXGUm8G0gv7K0yruo0tvpm_o

On 21/2/25 02:22, Filipe Manana wrote:
> On Thu, Feb 20, 2025 at 5:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>
>> On Thu, Feb 20, 2025 at 01:27:32PM +0800, Anand Jain wrote:
>>> On 20/2/25 02:19, fdmanana@kernel.org wrote:
>>>> From: Filipe Manana <fdmanana@suse.com>
>>>>
>>>> If the test fails or is interrupted after mounting $scratch_dev3 inside
>>>> the test filesystem and before unmounting at test_add_device(), we leave
>>>> without being unable to unmount the test filesystem since it has a mount
>>>> inside it. This results in the need to manually unmount $scratch_dev3,
>>>> otherwise a subsequent run of fstests fails since the unmount of the
>>>> test device fails with -EBUSY.
>>>>
>>>> Fix this by unmounting $scratch_dev3 ($seq_mnt) in the _cleanup()
>>>> function.
>>>>
>>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>>> ---
>>>>    tests/btrfs/254 | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tests/btrfs/254 b/tests/btrfs/254
>>>> index d9c9eea9..6523389b 100755
>>>> --- a/tests/btrfs/254
>>>> +++ b/tests/btrfs/254
>>>> @@ -21,6 +21,7 @@ _cleanup()
>>>>    {
>>>>      cd /
>>>>      rm -f $tmp.*
>>>> +   $UMOUNT_PROG $seq_mnt > /dev/null 2>&1
>>
>> This should use the _unmount helper that's in for-next.
> 
> Sure, it does the same, except that it redirects stdout and stderr to
> $seqres.full.
> 
> Some tests are still calling  $UMOUNT_PROG directly. And that's often
> what we want, so that if umount fails we get a mismatch with the
> golden output instead of ignoring the failure.
> But in this case it's fine.
> 
> Anand, since you've already merged this patch into your repo, can you
> please replace that line with the following?
> 
> _unmount $seq_mnt
> 

Applied.
Thanks.

Zorro,

Just checked, and it looks like you haven’t pulled in patches
from my for-next yet.
I went ahead and force-updated it to keep unnecessary noise
off the ML.

If you're pulling this weekend, there are three patches in
for-next ready to merge.

( https://github.com/asj/fstests.git for-next.)


Thanks!
Anand

> Thanks.
> 
>>
>> --D
>>
>>>>      rm -rf $seq_mnt > /dev/null 2>&1
>>>>      cleanup_dmdev
>>>>    }
>>>
>>>
>>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>>
>>>
>>>



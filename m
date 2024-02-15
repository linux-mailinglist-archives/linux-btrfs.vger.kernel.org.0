Return-Path: <linux-btrfs+bounces-2421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D7856224
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230021C22997
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B01E12B159;
	Thu, 15 Feb 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YHcwAYdm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nCsz8kWi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7A127B6E;
	Thu, 15 Feb 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997823; cv=fail; b=VXIHiprHOYqiIk8rtpoHgkDGtrOHq/mdndjSTHIyn8+PdMnR9bL3/thTH3gI/NBZCAK0fwoEf6F5LaPHGqWIBWifLn2owDyOh7BkOT5KHwmWLOCQmkotsIfLZicxf74CS/6ZJU3Vssp7tfuGVcMGXaQoP1033165Aj0J0Hb5FrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997823; c=relaxed/simple;
	bh=5VyleMXt8qh0zeeo2lXkPTclADLWNjnPzLXN+CDv6Lw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bpADU+3VS+fkEnddgPgruPYfTrpXv7UNLOAHST5WHPY4TfEHSMcOAqllZUaG7A0IF1ct3Bfy9S7i+d2AC91Rply82YC8Kg5K0WEmYePvAy41PcO2VjvYb8XQz5IpVwEvqzWc+qQr2kOv+Lh7wW1g4AkswiQ7hkyEhh/neAargkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YHcwAYdm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nCsz8kWi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6iok2003572;
	Thu, 15 Feb 2024 11:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kF/h5as3X3lIanvmj0f0rraVFI+avtICKav5I8kJFgI=;
 b=YHcwAYdmiT/uYTkV4PctzI8CvzQjPV6//poM2CGslI4xf1lb7xkf8Xf1EKNOMa81l/Gy
 T0J6eWZUIjJJvUZa5vGgpdmNzbxU8KBdFn4hRFrLsJdEfqPz01/qrGvQHVi2E+YpRVM9
 yK5mYWsauVY2Q/BPvtYz7O3HbQxbqpIvFQbscGrO2tQFor6bI3W1pEg34bZk7/u0x9Ob
 JzTvSGZOtk5WurLn5FjpHw7EK/BnsrWjXVPDiLEekbQ98SNiiH4CL0db/QXWBX1ycVMw
 RNbACvJFA0hpNnxMmMXUjAPbcrlys7JgmgZDHpHygM0EOGRdUv+6bDYUUjFPlnsck5dR yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301hus3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 11:50:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FBcd0B013877;
	Thu, 15 Feb 2024 11:50:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apd8nh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 11:50:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMQ9IuQJrLam3OCwg09wrpDZ+NUs+6FjaperNEv51VH6vIb3QLcw2PUmjDXESevwep0t3BMJWAEzr+IqEguqRRzXYf7D/r6jdHjrtgkAhmH3GFqiGs9Of6IN8dly1ABbDE74kGkK+43gaNJX3LVnI2gxtaNhwO1J2frR9bVHJ1j2YslynYkBu2sF9kvPAVGTa8d6ztGbNFH+vCyomp85SpLKHWPrMrdXOD+jImsx7Fz8BNdhSockPPS9MZMf5ElN5y95E5KG6ySWdmhdrTBMot8Y4P5Yp7HG9mKQpxvXBH69xI0EzRYQZDdFgU3LpQISuf9MJYDxDQwLiQWVlocPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF/h5as3X3lIanvmj0f0rraVFI+avtICKav5I8kJFgI=;
 b=DHc1u31kWYkBDeyKtTqwEKq8saPEdvAhUrLu0DyNpGIghWmvLp7ZrzFUy0eY74qVRYd02KGW3VFVqWUu+s3+jKr60KbRRK5wRaNRb0iaSk0fdQXh8LkVKoSe1TcNeoBGrlO9X5+hYZsFZ5Is+3bXWir4pTqQpenV2TFQphIcgpotC4ZROBvww44YGtUFwSF0w/AUOMP7Gq53gx5hIlB8GMCJ1gXiy7HLdbqfSUZyUGO2X291//0hOhNVPAcTsMoO1lTva7O+yFpXHkALRJndxlXQ8IOnbniU29Q8bgm5S6n0QRvi2r6rJzM71ncac6K3nt6+kGbjZBb4kSmWgktbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF/h5as3X3lIanvmj0f0rraVFI+avtICKav5I8kJFgI=;
 b=nCsz8kWiRyht6ocU8KmHcRvzoapuNv/IPm+EVg+dBrQ74SYj1ffsw+5CowZ4dpa683idCMo1/UKABndGnkWvRiLVwkFrAMebhZTYEy3BEKsrTchjkGA2PqVzcyPmGxwVRqVFep/AJTeRb89g+KTAPaDskyPvON56o1LynisT+0E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4404.namprd10.prod.outlook.com (2603:10b6:303:90::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 11:50:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 11:50:09 +0000
Message-ID: <644f1b4e-8c3d-46d9-a7b1-1c3182ab476f@oracle.com>
Date: Thu, 15 Feb 2024 17:20:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] add t_reflink_read_race to .gitignore file
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707969354.git.anand.jain@oracle.com>
 <578579505765ce6bb5ee8b1cc0e1703221fd9acc.1707969354.git.anand.jain@oracle.com>
 <CAL3q7H7BMOc_OYW2yjjJX535QdCxxm0K9JXNtwM+Hi2Pdq-4zg@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7BMOc_OYW2yjjJX535QdCxxm0K9JXNtwM+Hi2Pdq-4zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 730b7a1b-9301-452e-c749-08dc2e1c42b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JmcrIRSFOksp880ejoyGAVQsuXrg7C9PqJJ8iyzjodlRlxc2y45ryIwZPuko0joVcfzwyon1XxVKo6Vh5hEEa8vA9feCprIKtq6LTuK4UO5N9gNgzklt3WWk/+7wxCGE21UH1ByhbKF6Uj9PZnBiRleir9IF8JzvsimMYjOgcG6knuDAjDBh6uj7REB5OTRBcsdhI0CvTApHBoN3NIzS61Aq47eJghkugcfpC6IechhreCFuImuGWGVabT4JoNrpfXrk9ZOHw5h9BTKnpplpb+L+Xp6yJOVtJmLN5TdzNSjZWcIt2jtJnGyhk4ITxXIg3n5m99dyQEhE1ixiQsi6EAPDF1CalrPrymyWfcBZ2UrWDBkdtsa83D3budX3MEhNVl7H+PFvJiyHrkjaKm00h+MltVgbLXLetDwO9fV2bequBJ5e8NwEeE+jNohQLXwYReJiv9YDikZJXUwfICNDS9P3d8EtyPj0y2gG/S8O0yqw5KAPWV/FqYE1OfulhVt0GRPLcii9NbKj7bmGTQqkZgxqmjxg0/Ltf3A8TZM57N4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(478600001)(6512007)(6506007)(6486002)(53546011)(966005)(8676002)(8936002)(66476007)(66946007)(66556008)(6916009)(41300700001)(4326008)(316002)(6666004)(38100700002)(86362001)(31696002)(83380400001)(36756003)(26005)(2616005)(31686004)(5660300002)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OXl4ZE96c091SmR3OXJ3dHd4SmlqbHp1TmVDNUVZUnZnNXdMaGh3R1J4bktQ?=
 =?utf-8?B?Ri8vejhGSG9nOGl5K2kwbHZSTDl3Q1ZZeVVBQWRRUnVmcmljYXVoeGpVVlhJ?=
 =?utf-8?B?MS81Q1huTmZ5U1dLK0lTSDFLcGJCYnZTbjdmeDF6TnZUWVdacGplSW5WT2Zs?=
 =?utf-8?B?Mjg0RW5HVmNraWVFN1ZxTzRMS2IxUTRGdHlJTW50QTlhdmlzdTRaL3RhM05u?=
 =?utf-8?B?cGdwbEJvUGROUGlRRjIveUh6ZWVNQTIvMHNud1FVUWdDRmJJdGFIa3hYeFNF?=
 =?utf-8?B?KzhJSmlhbkd3cFptSHJERlRNbG1xZWNtaG15V1lkWm5LcklaemYyd04zWUVL?=
 =?utf-8?B?WWxuVTdpNzF4Y1d2NWczc0lWWEJRMFNHRWo2MGpLbzBpeCttSlh3NVQwMW9L?=
 =?utf-8?B?bHZZYnVqQUU3NlYwYWdwMEN3bTZuOVlFZEowY0hYc3ZraklSTzZ4Mi9hWTRx?=
 =?utf-8?B?SWc2MjlRNk1nUHo5b090c21xZm8vZ24zL3pQL3pCTmYvUEFLR21uUE1CNFRx?=
 =?utf-8?B?RWZtaFRqRlY4UkcxOGx4Q2xBM0dlVW93czRFNmt5Ykh1YnRxcWxISTBwUmFm?=
 =?utf-8?B?MmkzY0JOYnNIWjk1RzZOV3JLVGlJQTBSNVBqYzNLeU1ySndSaWlpRDNCOG5C?=
 =?utf-8?B?aXRYMERlT2t6K1lCQ2tFbUFleDdxMEQ1SGY3R3FBM3UxT044RlcvSmg3a1I5?=
 =?utf-8?B?OTRoRGY2YzZSVHZxSDZTVU9FbENGT0IxbXFaWWplQmlpMUlmSkkwbmdCVklL?=
 =?utf-8?B?aTNGNnJicU9iOGloNXNKRllQaklVY3E1VVZqMXBmRFhMSzJrbkZYcmlwdWo1?=
 =?utf-8?B?bVJLeDh4bm9RVUVyVHFMRWtYbmw1c0U3ZmRhbFR2S3ZodTR1YVhwVHNrU0Zz?=
 =?utf-8?B?elFXWTlVd3BXMkdDeU1ab09USTlWc0R4QXFQUlhHSk9jeGhWMzVMNVBkVHdu?=
 =?utf-8?B?b1kxVys0L25jTzZHVStUM2ZZeXplRW41Qytyb3dBdW1WSkYzbDJyeEVrNDFQ?=
 =?utf-8?B?VXdxN2lUbmZSL0EvdG1GMjNrK0xDQ1ZGWkhQK3pxY0NPSHF3MElTNGtId3dH?=
 =?utf-8?B?RDBWZzFIUC9hSVA1ZTR3T2c1Umhpb3hvRlJwSW1nQ2dYKy9wUWhLZi9YRFpF?=
 =?utf-8?B?NEExNjUrRXAzQ1pTbFpPb2pTRjNxNzFZWk1lRWhXb1pXSnZEYmhzMkJaQXhl?=
 =?utf-8?B?WE9mOXJvL2FzQjdZWUN5dFZIOHlIZEVBU3I4SmtWdXEzbzl1ZGVzRmFZTFRi?=
 =?utf-8?B?djQ0UTZ6OFY1ZWlCbk9ENEpXNVNlSGtQK2xzbGNTc2h4aEdnaWd6N0JrTmxw?=
 =?utf-8?B?YzZ2ZmpDYkF6ckZHanUyTTdHd3B5TUcyWFZ6VTZ2U3Nwd3VsbDBhUEJuNGU1?=
 =?utf-8?B?YWR1aFlZMUtJQ1hhUEl6KzJ4Sk51Y1AzRGdaY0N6OXRaclY4UHlCSDduNno1?=
 =?utf-8?B?ZHZNL0tOV1pmQ2syTzBRbncvN213UEtJdUV5amR4SzF4Tndjc2xWYUczUVNq?=
 =?utf-8?B?bk02bmNISDR5aGdmU3A0QVhPczlnamlIa0FnTE5RbUpoeEF5ZmpUS1B6dzFB?=
 =?utf-8?B?amhBQmZVRTBiTDdrVFlpMEJYeUZpNkM0TDRjUjhKQlBrOThjQWJNejFtckxo?=
 =?utf-8?B?T282WTN4dzZ1N2d4VVRicVloVU9pMUFodllnT2ZUR0ljWFlCUXYreVNKLzFE?=
 =?utf-8?B?b1hUL1V5M01lUnh3Q0NkWkhnZyt6NTJqRUhmOWdYSjFEVnVYZlNHd2V6dDl3?=
 =?utf-8?B?enF4VHFzVWtyTGlYNDFRekhTeHlkMXFmZyt6VGZBNzBwRVJNUnprV2M2Zk9W?=
 =?utf-8?B?T2FiVnU1Wjg1WG5wdzl0R2I4RFVKQk9UeC9QZUFnbkRIUThVdWU1RHlNQTlL?=
 =?utf-8?B?SWRSb2xzZEd1SGRxSE4xeGd5UGFMaXJsTUtSaEZTWE0vc01VZFhJelpnK1Z6?=
 =?utf-8?B?MElVRDFxTjIwaDF1MmdlSnlaeWFFNXdMbG9WK0llM3Bta3MvOEQ0bGlOUmxm?=
 =?utf-8?B?NElnNURyMjZld3RlUWRsZkhYajFJdk85NVNpWkQwdFhrM2ZtaS9KdDVxSWor?=
 =?utf-8?B?T29pOWZORERaZkI3Z0RhU3c3VkY4eWt4OUxncTFkRHIxL0NaZnB5K3pnb1VF?=
 =?utf-8?Q?7b8CVkLqI2HrhlYEKTiZJ+kaU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Pfh89GT61H4hleVBu/gw9YXiCB1OuuCA4mg5YpW/GTf0H01BY44f1vreNxjzl2pbMfrTNsXdNk69i8CV/x4SpZHy/DcqpYnoRbtGDpV5tHZHNffluRebyr8l+bS2HRH7ZpeoNijkBdoLgXePM2J+HbXdi2MX2jj0W0RV+MJ0OE74usfOg/dpKcV2ruTZo7bGk6jpCrebPjYJMWQHiPf4qJNTycQnmwfLeQsz77PzVWrMQiV0BsVbrAYgQ8383YM65qVkQfjHyZ8RnBrq+PRBMq/mfjDRcb5baTUVymwaY3orAszcreudODT1F6/SU2f/g6+4p3Pyy9tL2hvEn9yy33mJmcKNvo/iLZyOCwEkQNVCbpAG6umPXSJHlIgTaUKwtBPYZ8NAxHGPmyqQWyRaAfHvi7QxqycmlBiefSJHCI+Al5qnudvS1OHR7QgbQnOZ2Aodo7teEYn9z28f6ZWkbZrNIZvj6jot1mwtXBjB5MgbCsHUV3zCF9ssIqavXwB6C+qrIGktzexEN5v7fiLr3NVts7uO5/6qZLr7RcGr59kpJsKfe2lE7lJFqwYCOU1H95gCrDq7ZOoXtRfhENNp5O2PNJtyyvCKLquUG/JBB38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730b7a1b-9301-452e-c749-08dc2e1c42b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:50:09.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYlkQeOlC1O26rdWTs18wike1MpMMjgHkVwQ/gbLlwo3dZYeGfnDdMLrnfMGjlsSHbraU5XGSEPw7S6UB4zwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150094
X-Proofpoint-GUID: 9C6hrREsXCziRAHWjrQVq68h9uGLCRkM
X-Proofpoint-ORIG-GUID: 9C6hrREsXCziRAHWjrQVq68h9uGLCRkM



On 2/15/24 17:15, Filipe Manana wrote:
> On Thu, Feb 15, 2024 at 6:34 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Please always add a changelog...
> 
> Also, you need to update your local checkout...

Oh no. I thought I did.


> This was already fixed before:
> 
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=acff198213e3d874e76f6a133a816c8dee5e128d


> 
> It's also odd to include this in a patchset for the tempfsid feature,
> as it's completely unrelated, it should go as a separate patch.
> 

I should have.

I'll drop this patch in v2 (if any).

Thanks, Anand

> Thanks.
> 
>> ---
>>   .gitignore | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 5cc3a5e4ae57..d930b9cc8404 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -204,6 +204,7 @@ tags
>>   /src/vfs/mount-idmapped
>>   /src/log-writes/replay-log
>>   /src/perf/*.pyc
>> +/src/t_reflink_read_race
>>
>>   # Symlinked files
>>   /tests/generic/035.out
>> --
>> 2.39.3
>>
>>


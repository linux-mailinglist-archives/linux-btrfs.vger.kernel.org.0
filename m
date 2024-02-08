Return-Path: <linux-btrfs+bounces-2221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D8784D7C1
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 03:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB011C22787
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 02:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C71E89E;
	Thu,  8 Feb 2024 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y6xvEDQz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HsVri61N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A51E885
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359023; cv=fail; b=fmr24xSYOFkLlOWBWNL7kdWtfRk4FdY1IL81Boxe88GYfoFzZ/MccubzNLT7E/IiUEF8eEjTknQx16PjJQFESTUmJJCL6g0eBXXHV8w+mQ1OgKvhtAgKPoC8zI8D2PwKG0vfD92ZxPEG7fees9oNrGG5UEvPi1zgiKJr2BAXf3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359023; c=relaxed/simple;
	bh=64GhQeDdC4frQ/jdpXwF/Xl9R9h7+VUP9bIFSfxysr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t53sG5eQUitsd03F9jw35bVld4Yp8Le1bcl0+YM7YKxTN3XEvfiilEDB5boTSp5v7MDXqXvv5mkH0xpD7yhwlTfc+wNc5YQAOhUM32DXuP8JHvd9Ia5cM+DxxfhGMboFgFsDe9SjEYEkJdG/8io3SNrnhEkuwYNW5vvZvhEmaU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y6xvEDQz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HsVri61N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417Mc3EC025856;
	Thu, 8 Feb 2024 02:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xpEKKnnBC0brFXWnTW+CgQhvUqiAPm8a9Cdf++maFco=;
 b=Y6xvEDQzff8l0PWafl9wty8q4dCELV4KJ0aMbEMtCoStGxWj4+dpEnqpDoAZRygYm41k
 To8JfImsnOT4JMXjH9YB/kIYqcIK537z3kuLDmoOsqzc/OlFuSQ+j3nxUiMuVyzCfXyp
 ccfkwVsK7ac7fJ/nUB6aXr5kpSuK8BlBpKZOioh4w+OU1XKSCOJLBAqg4ObpcnLM1XXR
 TXUkc08sLXZiaz4mWE63FKNqS6i7ZuMaiz2Y6qo3+pI+DqGwl19kU21iGF35Un8gNAN9
 9gJurbftt3bCmuqzkdN4uARYT173iqW/pNMDGNIjgVbyUyMDS2sP0mbKqk4ECVn0DJrY pA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c943jha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 02:23:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41815lMw019854;
	Thu, 8 Feb 2024 02:23:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxg8sed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 02:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCTqL8KAQ2ZvYj9IMPgb9q05B+X68MJL2GGCe4gjUPuzvUSsf+3veHtsJHkbdzwirI1HEdRaKl+IvyFiWt7SWDWCKFbQSGVLwRNGY8fYwaBIenEGstJfRbIO+qnVVPwTMTqeSYhdQGsrOdV/o5IjeGQPaUjA2dfZkXxmijmBhED987S0oLIt2rkAO8l8nSMJE7zXss80eygRLU2ELJb0ZlzSl+vGL+yKE9TeUIPpXGuiiV53ASVgPbiJj0kmgEY0S3iFu4+9PyaLO3TVyLK2mgGFIfH8NLPTWKsWDl7041fV5KLHO0joD5SX4gOL1ZU8ZQEzKzHdHG9MvlTPghVv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpEKKnnBC0brFXWnTW+CgQhvUqiAPm8a9Cdf++maFco=;
 b=Ktgs1qdzOLzFM86tduYyJo/Tpsp3lm6dMDLQrAUELllQVM8hQ8QORNuHi4cgL2amjiFOMhcsVT8oul0MsVPZkLtjgcV/wnKvoOul+m6UgvCuJ29Xno7AAlkpb7qzjqTcWxAlAyvKCyhYU/cnhxxcWCvNRAPPqSe2rAxySvKpaqiHh1nbeXIFnzr09y3jn3RFQvm7n56GaFjzdbIe4aVl7sWAZLVwSGcrEz82vTB5carh16K/MnuvQTfr9gsinT7llo7tYluMNPxgkJrCZA1OadA+UYpt0IRMhHv1UFdbi+KCjuTSNI2Xv3D8dChA161fTG/0LZ1ICF+VpBGx3oUeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpEKKnnBC0brFXWnTW+CgQhvUqiAPm8a9Cdf++maFco=;
 b=HsVri61NsKD8Rm+gRweX+l1vnos/6xUMraGKIc5C9BUN/p79hmbUHR4kvT4gnx2uPAC2d+zxGeKpDewYpemzxD9rj4NHtrbsYO5b55HuGxRdcKL6cATLy7IKIhhaf7c83cYIgfky/xClkUQVU/Mm/Ty2gEA4RL6kstbm3p9QCo4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6516.namprd10.prod.outlook.com (2603:10b6:930:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 02:23:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 02:23:29 +0000
Message-ID: <55c879b6-5e6b-4602-b558-e52540b67bda@oracle.com>
Date: Thu, 8 Feb 2024 07:53:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
Content-Language: en-US
To: Alex Romosan <aromosan@gmail.com>
Cc: bernd.feige@gmx.net, dsterba@suse.cz, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
 <20240205125704.GD355@twin.jikos.cz>
 <e718b759-e597-440f-9fd0-351686bd6b5e@oracle.com>
 <8c326f81-e351-4e71-b724-872701f015ff@oracle.com>
 <CAKLYge+9ngrW-1EffUhyU1y13MzgP33osNDi3D6y6UVW6poJZA@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAKLYge+9ngrW-1EffUhyU1y13MzgP33osNDi3D6y6UVW6poJZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b083af4-dbc1-47ef-970b-08dc284cf054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1gyVAlGOhfTv7sKuRFPtaqyrbs6jbYYtXIcRw7hpyMWt+6S3PM4LqCMw4Hhg1mLpov5f/gn6NI5vb2pqOa9yiJyVIKZIA4EH5nqj/HUYTLR3zXQieNEDB/YmiTW+J/hhkI4X6n6v2hTMYCM4r0u7YP6WIZfL5CPuE1E/hIy1KQ083mNvxY3n2ra8WMXkjqMv6jNi1bALhQLU8Tzr5t10lkAyK9DYmUai6HH9KDTe7giyA82g1+yku/BOcXRK2kovzhUS6713PVLS/zkn2yXSwxJrt4+/2hnUTSKwSzKE47LnHsR1XEqSF+MnR6RTp9t1mA7/EI2Jr+B9+iKTxchio6vUhxY07v4amB1QjtpcO1S6hN9LRwOV/Z4snd15WuSKLXkWwMu1CUjmI5+Fy+zAVnmcZeBbxS7o7BvG3ntAKSCQOOhbAUJ4fv9PwGiedR6ruqGjo3fKapKafVMap7mNbRvSel06j2a9hoGTfDW+Px6XybtM2NhDDHqgiHQD9Yla+7e3pkzf76sA5HZrdLrJ+e8lG3Njkd6KoAJzVyMMYmqLE/tZEInY3t/H9TBoUdsp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(36756003)(31686004)(41300700001)(66946007)(316002)(66476007)(66556008)(6916009)(5660300002)(8936002)(6486002)(478600001)(8676002)(86362001)(31696002)(38100700002)(4326008)(44832011)(2906002)(83380400001)(53546011)(6506007)(26005)(2616005)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y1hFMU15NlZzSXZSNmYyWEFWa1BPcVZoaGQ1S2Z2Sy9mWVRVcUk1a2g5T3Q1?=
 =?utf-8?B?bVlyb29McGVyRHZ0ZW5tUC8zeEFvOTkzdWV6b1VsaXpDM01IRVFubGpRS25S?=
 =?utf-8?B?SjNWZU9VNkRuM0ZTQVJGc1YwMElFTDhseHlmMWM4T1dZR0JTYjdVT1JYMjFv?=
 =?utf-8?B?SVFOa1p5NWhnZjdRTnEzbDZGUWhwUU9SWFNVTXpTNjN6VG4zaUNWWmxRWVoz?=
 =?utf-8?B?dXBHbEZUR3N6L1NURFNzMEU4Si9qeER1dUZhNTZld0hMbXh1WVZvWU1UMlBr?=
 =?utf-8?B?OWZPNHNLV3lDTS9veWFGZEVNWmVBUDRFVXNjSHJiRFZ1bG9CQXZYLzdKT2E0?=
 =?utf-8?B?eGdicGpVRFpIK3M1MkxXK1dRZmJBZmtmb2ZRckpEb05BNEljc2ZOZi9qSlQ1?=
 =?utf-8?B?Nkxzak5Qdk9Sb1lSNDNUKzMrMUdZYUd5SVhqQU1LclRkOS9KVWIxTVpOdXE1?=
 =?utf-8?B?UmFLYitqaDNvcENsSmx0RUdIeW05ZlNHMEdmODVDb1lSTytNWk9oanBqOStH?=
 =?utf-8?B?MDdnS1owalpjMUozSWdtamt1OVBTb2FlaFRjM1cwZlBFamhQbFhnZ3A0L25F?=
 =?utf-8?B?cDBqWGZhYng3bHJGYytCYXpTTk85elRBTFZyNi9nNGN2eUlKU0hDcUl1Q3Vh?=
 =?utf-8?B?TFE1d2hmdzVZdHFmNEVIakduR0ZzTEkyVkM3b1ZCSlovdGVzaEMwMTFlNWVD?=
 =?utf-8?B?STYwVWFjQXlMMWZtcHhwRGplVUZLSDVvZi8wODVLdlhvRDBGa1B6NHJBL2Q2?=
 =?utf-8?B?S2V6Nm9YWGp6ZlBCNGRwZDY0MklsYm5YVVNHSEw1SjJhbU5CUW1Ec3lETGtD?=
 =?utf-8?B?OUVDbURNRnA0TVk0ODMxMkFYSzc3RWc0QmYrNDF4Zjd3K1I1Mk1JOVpjeXdV?=
 =?utf-8?B?RFJWOTQ2UndKTFZaMDhJVDRvb0Njb1diN1RySnFkTDJtTGlPaUJySTl5bzFN?=
 =?utf-8?B?NVRQM2puUW05R0pwdFJWNE5FWStPWXZLblJqSEFKUUpPZ09EWG4xTmFEU0pZ?=
 =?utf-8?B?N1U4WTVsRWpseHc2c1ZZN29RWXZSWGZ2TTVEeXdzNXg1K2V5a0RrTzE2NXo4?=
 =?utf-8?B?dURManFOT2pISVYxR3J4ZUZ1RjN5b201NmJGeWdWcmU4ZEJhZjRyaTBicUlB?=
 =?utf-8?B?ZDM2Y2V6U1Azd3hPeGsrNEw5Vmp6RkQ4Sncyakp1Y05Fa0k2Qldnc2VSVWZH?=
 =?utf-8?B?N0RQMmZ2ejRjUTZyTG9xTC8wSlIyMUttdy9XT1JoVUVpdWF5Z3JKUVdhRStG?=
 =?utf-8?B?QzBPczVadFdZb1dsZXBIUUdLMXJVQ1pFOTdzYTBqMGtIUDM0aDUrNW5jaDRO?=
 =?utf-8?B?ckVYYStzNU9COWZLb2EvNHcvbmczNGs4SHVlcCtIWXRGQitleTFGb3RodjBa?=
 =?utf-8?B?RHNjUHl2TFRnb01WajdRNVVvYjNNc3U5Ky9aSXVYSHhZVEZJclZFWXp5OUxl?=
 =?utf-8?B?dkFXL0IydFltTmlaOHZaNW10UTVYazJSN1JyelIxUEgzdnFtdVBCOUJzRDhZ?=
 =?utf-8?B?RXVEWlBjTy9PQzQ5UUY2OHlReWIvMTFFNTdUbmYybU5HNlE4bVFvSFYzSFBW?=
 =?utf-8?B?TnZiMUNxbFF0WGhOUXhVWlVZRXhETVl5eUI5YStkUkxEdkZubDl3TFZKL2tD?=
 =?utf-8?B?THhXR1RzaTRiaVZ2Wnhhejc1QU9nSmJZWStZSkRxU2ZONGN5UWZYSno2N3Nk?=
 =?utf-8?B?Z282bUZTbHkwTEM3QkI0VzF0Q3A5R3ljNDYxWERkNUxBMkcxZVVWeEx4d0Mw?=
 =?utf-8?B?UGpYU0xaZkRkN3l6SVcyR1dYeC9qcWMwWTlHSzBnY1ArcjluOVJseUpNYnBX?=
 =?utf-8?B?S2ZTYjd1dC9oMXlFK1FTekFpWkpCeGZTaUFrNVJXdXU4NEowWGw4ZkVNVEhW?=
 =?utf-8?B?cmJVS0FyV2QwM2tialZEbEtncmZGajIzYUhaRG9WU0RoQXFsUkpTeEVoYURZ?=
 =?utf-8?B?U0JOZlBsSjZEZjNsSFNtdVcwaHN2MG9HQ2hlak1JT3NiTmwvajFZK0hDWXR1?=
 =?utf-8?B?SXdqd1NpVEV0WStueXB5TDFMa1JtOVJDTU9wV1hUY1hCcXRDa1U0Ni9FbHo1?=
 =?utf-8?B?bXo3QS93S1ZmSlUxWnFjVEVjdlNQMmFaT2d4UmZTNlRVdElsZCtHVGR3ODVj?=
 =?utf-8?Q?WoEvyC/iSEovaSf8Z6nO9BH9J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j1YzfIxO+LrbPtxnLorGld4+Zxa7qMadMaxA9H+kYvuOe7+HR4bvqYT+8LJhKlheP0sdCYavGer4JXNs7CI5lpylFtskt9l5SDKh1GBMgGE2UyvlQEwWhAflIVQmz3KjVBaucvHN8B6/J3QsWjZmtaYUAuNt+ZIiY/2wl8RqYLevnoc7Kf9wdr8F7CuPkm/QCWblD6z6eAM7dz5kMFLRtQf0YEFhILZBXVmu+FeeUjKFb7twdmBXOnO+5FsNC4CtBsl6G/zjC30cIboC4PPfqHlaUYYFteKAj1KY558GONMeBzWmrGvTe6RuqQYl70IX46F0BId3Wn3ZsQFtewFk2Z6hBMxgV1tBnXpXnEAxkcUJxw7xNdnhfiMz5hbgVxxD2k4RInhOdaenX9xYpTWMsh0A+3KM1OEASdPIy2yd45hBYhx6PE6FoUY2hPgrGm4A5CQfAKYE0GmLDUMaW8mexUqZf2iIOI1NwVhL0Iyv/FkWfuf8dX/kRzfB8aGwIK7rTPzub0I5U/T+bcd0l6RRgOBv461f8X8sCAGy8dhnrKrtriwpf3Q+mlqv3nJpF3a3u8FM2sCWj80PdLL/8AbI829P2hOiGz0yvv4ICdT3zrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b083af4-dbc1-47ef-970b-08dc284cf054
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 02:23:29.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3WjMggyFWX/GkbmcLdISgjgMz8Iu782IaMX+kAEO9JoqG1tB41l0ItfTSL2Jyzgi9NdVmEjPe1vomCPFIGHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080010
X-Proofpoint-ORIG-GUID: _h0TwIqnD_pmqt7VzuphcCmzyv1nw2i8
X-Proofpoint-GUID: _h0TwIqnD_pmqt7VzuphcCmzyv1nw2i8


Alex,

Please provide the kernel boot messages with debugging enabled but
no fixes applied. Kindly collect these messages after reproducing
the problem.

We've found issues with the previous fix. Please test this
new patch, as it may address the bug. Keep debugging enabled
during testing.


Thanks ,Anand


On 2/7/24 23:48, Alex Romosan wrote:
> Which version of the patch are we talking about? Let me know and I’ll 
> try it with debugging on. I tried David’s patch and it seemed to work (I 
> just booted into that kernel and ran update-grub) but I’ll try something 
> else…
> 
> On Wed, Feb 7, 2024 at 19:08 Anand Jain <anand.jain@oracle.com 
> <mailto:anand.jain@oracle.com>> wrote:
> 
> 
> 
>     On 2/7/24 08:08, Anand Jain wrote:
>      >
>      >
>      >
>      > On 2/5/24 18:27, David Sterba wrote:
>      >> On Mon, Feb 05, 2024 at 07:45:05PM +0800, Anand Jain wrote:
>      >>> We skip device registration for a single device. However, we do
>     not do
>      >>> that if the device is already mounted, as it might be coming in
>     again
>      >>> for scanning a different path.
>      >>>
>      >>> This patch is lightly tested; for verification if it fixes.
>      >>>
>      >>> Signed-off-by: Anand Jain <anand.jain@oracle.com
>     <mailto:anand.jain@oracle.com>>
>      >>> ---
>      >>> I still have some unknowns about the problem. Pls test if this
>     fixes
>      >>> the problem.
> 
>     Successfully tested with fstests (-g volume) and temp-fsid test cases.
> 
>     Can someone verify if this patch fixes the problem? Also, when problem
>     occurs please provide kernel messages with Btrfs debugging support
>     option compiled in.
> 
>     Thanks, Anand
> 
> 
>      >>>
>      >>>   fs/btrfs/volumes.c | 44
>     ++++++++++++++++++++++++++++++++++----------
>      >>>   fs/btrfs/volumes.h |  1 -
>      >>>   2 files changed, 34 insertions(+), 11 deletions(-)
>      >>>
>      >>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>      >>> index 474ab7ed65ea..192c540a650c 100644
>      >>> --- a/fs/btrfs/volumes.c
>      >>> +++ b/fs/btrfs/volumes.c
>      >>> @@ -1299,6 +1299,31 @@ int btrfs_forget_devices(dev_t devt)
>      >>>       return ret;
>      >>>   }
>      >>> +static bool btrfs_skip_registration(struct btrfs_super_block
>      >>> *disk_super,
>      >>> +                    dev_t devt, bool mount_arg_dev)
>      >>> +{
>      >>> +    struct btrfs_fs_devices *fs_devices;
>      >>> +
>      >>> +    list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>      >>> +        struct btrfs_device *device;
>      >>> +
>      >>> +        mutex_lock(&fs_devices->device_list_mutex);
>      >>> +        list_for_each_entry(device, &fs_devices->devices,
>     dev_list) {
>      >>> +            if (device->devt == devt) {
>      >>> +                mutex_unlock(&fs_devices->device_list_mutex);
>      >>> +                return false;
>      >>> +            }
>      >>> +        }
>      >>> +        mutex_unlock(&fs_devices->device_list_mutex);
>      >>
>      >> This is locking and unlocking again before going to
>     device_list_add, so
>      >> if something changes regarding the registered device then it's
>     not up to
>      >> date.
>      >>
>      >
> 
>     We are in the uuid_mutex, a potentially racing thread will have to
>     acquire this mutex to delete from the list. So there can't a race.
> 
> 
> 
>      > Right. A race might happen, but it is not an issue. At worst, there
>      > will be a stale device in the cache, which gets removed or re-used
>      > in the next mkfs or mount of the same device.
>      >
>      > However, this is a rough cut that we need to fix. I am reviewing
>      > your approach as well. I'm fine with any fix.
>      >
>      >
>      >>
>      >>> +    }
>      >>> +
>      >>> +    if (!mount_arg_dev && btrfs_super_num_devices(disk_super)
>     == 1 &&
>      >>> +        !(btrfs_super_flags(disk_super) &
>     BTRFS_SUPER_FLAG_SEEDING))
>      >>> +        return true;
>      >>
>      >> The way I implemented it is to check the above conditions as a
>      >> prerequisite but leave the heavy work for device_list_add that
>     does all
>      >> the uuid and device list locking and we are quite sure it
>     survives all
>      >> the races between scanning and mounts.
>      >>
>      >
>      > Hm. But isn't that the bug we need to fix? That we skipped the device
>      > scan thread that wanted to replace the device path from /dev/root to
>      > /dev/sdx?
>      >
>      > And we skipped, because it was not a mount thread
>      > (%mount_arg_dev=false), and the device is already mounted and the
>      > devt will match?
>      >
>      > So my fix also checked if devt is a match, then allow it to scan
>      > (so that the device path can be updated, such as /dev/root to
>     /dev/sdx).
>      >
>      > To confirm the bug, I asked for the debug kernel messages, I don't
>      > this we got it. Also, the existing kernel log shows no such issue.
>      >
>      >
>      >>> +
>      >>> +    return false;
>      >>> +}
>      >>> +
>      >>>   /*
>      >>>    * Look for a btrfs signature on a device. This may be called
>     out
>      >>> of the mount path
>      >>>    * and we are not allowed to call set_blocksize during the scan.
>      >>> The superblock
>      >>> @@ -1316,6 +1341,7 @@ struct btrfs_device
>      >>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>      >>>       struct btrfs_device *device = NULL;
>      >>>       struct bdev_handle *bdev_handle;
>      >>>       u64 bytenr, bytenr_orig;
>      >>> +    dev_t devt = 0;
>      >>>       int ret;
>      >>>       lockdep_assert_held(&uuid_mutex);
>      >>> @@ -1355,18 +1381,16 @@ struct btrfs_device
>      >>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>      >>>           goto error_bdev_put;
>      >>>       }
>      >>> -    if (!mount_arg_dev && btrfs_super_num_devices(disk_super)
>     == 1 &&
>      >>> -        !(btrfs_super_flags(disk_super) &
>     BTRFS_SUPER_FLAG_SEEDING)) {
>      >>> -        dev_t devt;
>      >>> +    ret = lookup_bdev(path, &devt);
>      >>> +    if (ret)
>      >>> +        btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>      >>> +               path, ret);
>      >>> -        ret = lookup_bdev(path, &devt);
>      >>
>      >> Do we actually need this check? It was added with the patch
>     skipping the
>      >> registration, so it's validating the block device but how can we
>     pass
>      >> something that is not a valid block device?
>      >>
>      >
>      > Do you mean to check if the lookup_bdev() is successful? Hm. It
>     should
>      > be okay not to check, but we do that consistently in other places.
>      >
>      >> Besides there's a call to bdev_open_by_path() that in turn does the
>      >> lookup_bdev so checking it here is redundant. It's not related
>     to the
>      >> fix itself but I deleted it in my fix.
>      >>
>      >
>      > Oh no. We need %devt to be set because:
>      >
>      > It will match if that device is already mounted/scanned.
>      > It will also free stale entries.
>      >
>      > Thx, Anand
>      >
>      >>> -        if (ret)
>      >>> -            btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>      >>> -                   path, ret);
>      >>> -        else
>      >>> +    if (btrfs_skip_registration(disk_super, devt,
>     mount_arg_dev)) {
>      >>> +        pr_debug("BTRFS: skip registering single non-seed
>     device %s\n",
>      >>> +              path);
>      >>> +        if (devt)
>      >>>               btrfs_free_stale_devices(devt, NULL);
>      >>> -
>      >>> -        pr_debug("BTRFS: skip registering single non-seed device
>      >>> %s\n", path);
>      >>>           device = NULL;
>      >>>           goto free_disk_super;
>      >>>       }
> 


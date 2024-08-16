Return-Path: <linux-btrfs+bounces-7228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CC1954753
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 13:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E541F25A33
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD545198853;
	Fri, 16 Aug 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FJ/j/8iO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dlu9JDMM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA617BEB7;
	Fri, 16 Aug 2024 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805950; cv=fail; b=AycWo8KyqTlDWe5PEAZmBv3M08l3Ay0LSsEs+qtHxC5LVtTowYnRJoQoFV+vXfXtLEHFyEzBCK3bAQEny8srrol8BD9zmQBcOKhrYbM6uOlotkd3SSndyodmBGId6hJpvJ0m6F5baeIetcWotYhpmIFPdGEXKQZBD3dlTzhHrA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805950; c=relaxed/simple;
	bh=nDq8SrTwbfOdT/Zrc/bNIXzvI4ds7MzHuuJ9HCEGGtU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLPHptp3TOwgoSBXqCyoT27u1seiLlSkpNcP5R2X1lc+6LGCROo4pXtkmX13kmaVl/bHZ/EnMYlaBYsn5oTXo7AODZJYLqVXIv+rYCiNP+O1zgQKxuSizaNDs7ucQE3buzgpdT0Rflhq1jFjJQEuQJJcTEh64PnvHF9BvNAYSA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FJ/j/8iO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dlu9JDMM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G7tVLV021822;
	Fri, 16 Aug 2024 10:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=KKQzQALZ/yUHbLNSAQON6ZEkTWmqLpGhp7mbrmUWfw0=; b=
	FJ/j/8iOHfXFiWsgvsfw7wf2c+LkRlxDLGN4Oc/rfDUtPuNvTDWN70v3RSSTtUlU
	Zt+sqbsAKiyUUi5zMO/b4yje5qAIUnGI5x7X+9XwruqO5nEy0eSD3Uj+1cvzfB2f
	wFvrOLJXWUocuHqU1xCfLosdLxYlHBQtQ+qQzNXjOkKpCKwKZdyKMwrScSlKPVEv
	h0mwULZ4TAHdY0Lms2kLYlvCRLZ+LHIBLkRp7RdC8HjMwdMhmldFktGZUeNgtWrG
	e/NDt95Q4cR2HRTpUVkEfs3VMofa5osm6PX0PepzDgbER1rkceMW3mx/Vk5LY3Yc
	A1HMlLATqS2hlF2NBfWgYA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4bmdsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 10:58:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47G9Xi9m003676;
	Fri, 16 Aug 2024 10:58:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnd8rty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 10:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4PppsjBrfD5JkHz8lw4uxyT0sC0WN9+E8TIavgEhVzK2Y8GwUFI73if0IQZlPjUFkkTRp6DZHtxkg5giB1M/FmBfbVLPfDS5EN6/LhtZCnIMfXfW21OZng935Dikev9kvcKeoaUruT7TSZV/VPzetyotvKOtJ+u5K1h+J6kdTCgZmz/LKv6j1YEmbdQWRqn4C6q1pjNoesifYAsxJInAs+LRnD1LCj1LgQZrLoTGHHNtUGTOadxeqUnxvl1Fyv+kh5mZk2hmm5eWFyaEG4zu7d3b7UXrKjKp+W4JMufshwypDdenJK4BGbSGrKuANjvO3O4i1x3cfgSsmoY99gvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKQzQALZ/yUHbLNSAQON6ZEkTWmqLpGhp7mbrmUWfw0=;
 b=uXS+DXXtNqVg2NJmqKUT9pGn9L0YggImYj84qTHgmeE7sNka5mICnmY6c0+ocLJF7l0VVZYPwbQUatEIgZI7xeFn/ggtinAuXTdVoID7i+lR8g/84bRtCvNA+yxkTC0KBO3d4tBrc94MlwhFn8WNIjikW1J447EGU9tIbhGuVoEks3LYSVdnb7CZAShOu/TJ417nuzEEjU1a8S2ceZmQYra9g23QKSxk3yaAo8jevVcFzgbkmCey2J6pib3/dHpQppGV5Auhxo/qn3UPIR5D6eMNUls1zPQwKD93Xk4S4BXXE+yhFqdEFK0VgrNrKfcNWh2kD5L54NXeMZG8fYAPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKQzQALZ/yUHbLNSAQON6ZEkTWmqLpGhp7mbrmUWfw0=;
 b=dlu9JDMMaaF/A/cD6vPnKERSct8mhRgViSYpslr4phvLYRC0KAWWR+lz/ItVAdYXGB4obdhCNNrbG/KXd7uah+7Q18CXcbieF4WBOOjtoZxtCI9dCO1hYaEBILECOoq+PYI5MJZW6ODKFHOScoOd079VvqHzu3bju9thbU6ueIA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9; Fri, 16 Aug
 2024 10:58:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 10:58:52 +0000
Message-ID: <ffe34979-75bf-4cb4-ac66-d21bdc85578c@oracle.com>
Date: Fri, 16 Aug 2024 18:58:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: test send clones extents with unaligned end offset
 ending at i_size
To: Zorro Lang <zlang@redhat.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        fstests@vger.kernel.org, fdmanana@kernel.org
References: <177f429d65afb5cc99a7f950779ba15b130cd581.1723470203.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <177f429d65afb5cc99a7f950779ba15b130cd581.1723470203.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: b27da5c4-9d6f-4ab4-6958-08dcbde269d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE81aWFqak9td2dxLzdvTS90T1JCOVZyYzkrS0JQWk43RUMvR3FqbWVLcVQx?=
 =?utf-8?B?elBJbFdLWDBpcG4yM0QxUEl6VHNRZmlRUFNoSUgyY0VzVEpIN1Z3NVZBMU1J?=
 =?utf-8?B?L1gxcVJ1a1pMTmRUZDk4RWZFYWFtTjI3MFNMZWdwdS9ZNzRWZS9zVFA4MmdQ?=
 =?utf-8?B?d0swbi9UVHQ1dGFsL0l2QUpubFp4NDRVcTlSNXZLbWkyWEtuaFZyeVFBY0xB?=
 =?utf-8?B?ME53cUVmSnpsSUhGV3RRbDN4WVRPN3B4alAzc01sZjhuWlhFSWRCQmF6a1Bu?=
 =?utf-8?B?OWk5ZGt5M2NJRzV1M0xmR2p4bkErdkxlMXplWVhlNHNVZHBaNFV1bnI4WTJC?=
 =?utf-8?B?c2ZWWlR5TDF2bDZoMFAxQ1NZeHZQbGpyNTljS3dhVTBQOXRwcGl6Z0J0bUF4?=
 =?utf-8?B?aHRpbjJBMzZoREg1cGozVlZZbXhXNFJUczFPMGdnQkVkZmVzdzNXTEptL3Bh?=
 =?utf-8?B?UjhOa3M1eHZoSVFFVEkxOC9NOWwxSUZHdy9udGUyNVRianpic2FSTEdjU0tt?=
 =?utf-8?B?V0dkNmRDSG9XblVCUGx2bXhyMmxuZG5TUFpWTUYzMTQvMlhWdnYrZUVzOXBi?=
 =?utf-8?B?YU9FY0NZOEcxOFNzbWpabmtQU3E4YXcraitVZU1kb2puRlpxTkdNNldUT3VN?=
 =?utf-8?B?enlGT0REKzVOVHBVdUlQLzQ0RG9hWDFiOWJheW1KVlM3N0lTUU5CYUpFb3Jy?=
 =?utf-8?B?YTJaNHNPdkFySnNaakVTYzFkOVRtV1hRbkwrTzA5RDNON204NmM4ODJ1Zms5?=
 =?utf-8?B?bkVnVUh4ekQ0dVFTcS9qdXlkNkdhM0oxd1ozZFdRbnNMZXdRUlcyQU1iZjcv?=
 =?utf-8?B?eEMwakJDMmZZT0VBS25ZTEVLTERjaEo5aXBLRkpqdVUyOWYyelRJakVyOGJy?=
 =?utf-8?B?WkVmSGRjYXNzczFXNnlJMk1sN0h0NHFPTnhyUUM3OGhKNTh3SWx4eFlBY1Vs?=
 =?utf-8?B?ejd3OXZWcTViT0RSUmgxVDJQVlMrTkNDeHdyWWtZZ3RCanY4WTEyQy9lMDNP?=
 =?utf-8?B?b1MwOHgxR1BHdFI4em9jeUdObWZTT05LWExwQ2RnREFDeHBMcnQxem9vdjZo?=
 =?utf-8?B?WEhSeWNZWGFUOXQ1V3liVCtPOFV6d0ZjVGxKRndGT0E0VVVKVjRIZ2hxSDgy?=
 =?utf-8?B?MzZmWUF5NDdUcnZMQUJXSFhoWkRFRzZ6YmVWc0VodXVPSDVIMU91blV5NTBz?=
 =?utf-8?B?Y21DMVRuVDRzRVhYdStwT1dtRTU5ZlByRnppSlFYR2VYZmxnb3B4NlJ0bkpH?=
 =?utf-8?B?UFlNT3BlN1FrQ051b0tlYnZwY1psZ1JCMXd6TGVBVnlzZmIzSUdvWk1hU2JR?=
 =?utf-8?B?YWRMS2xqMnUrUzNMWkk5d2cwU2NoZ1JCV1B1ZkkzMzYrL3RUb2dzL0JTemdM?=
 =?utf-8?B?ZUtzajh5NGFkTS9RWGFYLzJOMkFST2p2dzdsRGlrSTlUUXA5dGxyZCtTWGND?=
 =?utf-8?B?VzRJanN2aDBWeU4rRU5WT29UTlV2SFZyQU9NckN4MUcwRkZOa015ZDRFeFM5?=
 =?utf-8?B?cElhYWRWa0R6K2I3Z2NDRU1xK1RBSnJUY25vcXRON0JkLzZHMFd1UUZHV0tZ?=
 =?utf-8?B?bTNwaHc2NnZKcTk3T2h2VVFwdFhIS1RDTVYwSEd5ODhIc2pGVFdTVkVPV2JL?=
 =?utf-8?B?MCtnLzlCcm1kVlc5VnF5M3RyZC9od1dVSGU0RTBNMUFvS2huSkpsb0plam5t?=
 =?utf-8?B?RDRoSzF3SUplVzl5T1gzTDNPbmZyamVrOTRzcW9pLzhiVlBieFBHT1pxTHpH?=
 =?utf-8?B?UkVXTTVzcGxxNnNhSGxHcXV4aDBRdG94eGdQdXlpZFJaNW16c2hrY2NXZGNZ?=
 =?utf-8?B?NGJOditYZittOVZsOStCQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlRnQ2k2enNkU1RmeE1ublQ2SFVsRkhiVVZNMk9ZR1l4ekxRdWFNbVpUQ3Ja?=
 =?utf-8?B?VlhLaWxhc0dLMlhrSTczSlVGZUl2aVJsK0ZKWUdKdkdhd1lXWExDK3hmZlhm?=
 =?utf-8?B?MmFsQm1Vak82Sjd3TWRiNkRldjFDd0I2WURYOVl4TWVJUGdNdGRhTWozM3B5?=
 =?utf-8?B?UVl0NDVGR1RqUlFBNUVka0dyYWdQa012N2tqbmgyTzY5bHlyNmpuSjI4bkVG?=
 =?utf-8?B?anlscUZBR3Q2TDgra1hYTi9jRzRpUmY1WjZpNDYvWit3UE4wR3ozZ2lTU2FK?=
 =?utf-8?B?REZVblJhRmd4RFkxQmlOT2lrK2Znek1SMG5iMUJJZnVUYWxWd2ZRdldmVlBj?=
 =?utf-8?B?MWdRTC90TnUyVE5oVXpwellpU3lDYkZiVm8zV1YwN3VHMEFUalJ5c2JIK2RZ?=
 =?utf-8?B?MUpNQzhZM1ZSaDJiRjJCbFp6M2Z2Rm4wTVhFbjdKdlVtbjFEQmxFYTdJWXVk?=
 =?utf-8?B?cWRnK3VUd0U1eFZNblQzYWlkaWFjbHJVVTVEcDg3ejhsZ1c4dWJuRUNtbnR2?=
 =?utf-8?B?Z1JYTGc1SEMxTm43VWcxL2UvQUpKNUZCWnI5R2VFTzc1ZzhSVXFVUVpDNkZD?=
 =?utf-8?B?UTVCblg3SzdIY0o5dzMvNy9OaDl1bU9JVnRjNi9mdk1pQXJ0d1VoZHdJSExv?=
 =?utf-8?B?NHF2OWdtK3VhVDMxc3JpN2tpVVZSK2cxTVVCNG9oazgvWEFaOEFEeklUdGJE?=
 =?utf-8?B?K0MwVXdKNnNmZTNKRktGcnZHUnFzcnh3R3BRajZlOGNvZ2pBbko1ZHNqUGdG?=
 =?utf-8?B?L2pyZzNOV3pXeXlWUDV4ZCsvYlFxdVJrMWdhaS80ckgvaVRDeUtIMk56TVN6?=
 =?utf-8?B?Y0VtUGIvQWJhbEpTaWQya2dNdmpEem9MSkxiZEh2M3gzN3FhUXExUmhGa2Vo?=
 =?utf-8?B?b0ZFWmwxK3Q0eE5vUERzUGtjQ2FKRFdSNHZkVDJTMnh2c1Q2ZFFycWVjRVdI?=
 =?utf-8?B?dGRZS01MR3lWaWlBbkMzT1FJV0FDd1pTbTQ5OHBZTTIzMmRIRjdzR1JNMTlw?=
 =?utf-8?B?WU9ycUt5Y2FSZGVQaEJsamdPdkp4SFFORzVXNjFIRnVuZVRVU3pxY1MzbUtE?=
 =?utf-8?B?L1I5WFM4RnQwSkh5eTVnUDhZVFhwNHJYczBWWldoU2dBeWtuNTdjZFloMmtk?=
 =?utf-8?B?cmloWGxyVlNpYmZVQ3cvci9yeEMwb3UvOTZOYkdtaG1JKzJXRHlDZTFJbENF?=
 =?utf-8?B?YWZJT1IwY1QyZkEvKzhJMm11QlFWYzhybGd0RWxBZll1bVllcHMxakFXMVg3?=
 =?utf-8?B?bkdJanlhL25Rd1hDcHZPUFovYmI1M1FmZWIrREViK3R6TmthTUhFZk5JV0hV?=
 =?utf-8?B?QWU3YVl1RUIyN2M2b0pFRUxsclRWbTVHT21iR0NKelFXd3FPdGlVTStRZWN6?=
 =?utf-8?B?VFNqdzU2R2phY2pxdnA4N3M0MWlDc0tBTW5FQ2FNTlFSOEEyTXE2TkE3blZF?=
 =?utf-8?B?R0Z0UExnRFdPcnpvUzVXbDJtUlZUdlBpM0N1VXRxYzBhRCtxZ1VpUGJlQm54?=
 =?utf-8?B?djNMd0J3bVRUbTlVMXNaSG1Od3ZIVExyaGpaZCt4L05nTkR4UGhONUZZeGZy?=
 =?utf-8?B?MXdFTDRkUUdLOUZrcXVUN2V3dlIrQ3NKNElnS0JldW1rYUcrYzBvcjIvUWk5?=
 =?utf-8?B?OHU5QUUvTXRQaUcyNXNJWmpuQkZTbFlnTWQzMlpwK0luVkViL05PdnVzc01j?=
 =?utf-8?B?elNwYUdtaWJNUjZjRnZ1cFNDc2pIZjBlbWVoaGJ2cGY5SkZ6ZFBKRm5YKzMx?=
 =?utf-8?B?dlVZRWdqMzVrcGljeHBCVnFCN2ViWW1FcDJHK0FyZm1Lb3kxaWNwZ0RGaDFT?=
 =?utf-8?B?dy9hVURCZXBWU1c5NU5jT05rSlZpNEtYREhUcmlabFJwZWR2VzhQcXpxMzJI?=
 =?utf-8?B?cUlLc25IYjlMbWJ5VjRhdkZ1R1NpN2w0T29xalhnZENWS2lISlRhZUI3RjFL?=
 =?utf-8?B?ckpFUmFvMXJ2TmdJeUZwRmxZS2doS0s5YklXSTF4T3YyQ3NDM0NyTEU4elpr?=
 =?utf-8?B?alpEVENqT01DUHUvdXJVak5DbDYxY1lrSmQrT3h3S3JzeDZrNFN1cE1PZWRn?=
 =?utf-8?B?T2dqOEJsNVNwa0NyRUY5ZVhBTHN1NkF1ZjlWRUF4UjVRa3F6VC9ybExtcTBR?=
 =?utf-8?B?MElLUE9ib3R6STlQZWlmNVZpMVdYd0htbHdiWWNDSTFqeHFZU3pIS0l3MlZN?=
 =?utf-8?Q?v63kfJPW8HwwO0bsuWB/oLY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AQ440Xbb2VjeJkoUSCsCn2LIMgarXyMJ9FnwHorERbFnlnH43eoWCviG2ITpFsvqxC5A/hQJvDC6Ko52XZbVsU3NdL6WJyejTeVai+alT84EDSBGXbFzjx+M2AatAAHWXeTVCnPijlvoV811yMtZs7J3WmSmeKMtIJWqh+mhI2UFnBmEJ3cyk/daYTUAxvMGQD+tFpq3uFkkx47TD565PHi6iTdid4ywe2Sp+SJKFKvvLgtdIZMxWAQcGMtr+hIstgFk2aY6Yw9dK+ejkkgQr6e7vVo83dvEO+lu0jg+XiCKLEb+wMraeYx3A7G7CiFQ8E3E2AQWBVONgdrHaGkK5dEcgWL0m4K0XSfm6YmlamCB9I7bZ1q8vhPE8wXCt1VmqquuQXGNvgz/M7as8Lm8RFR5xQIR6qOTzllHAwTnY+qQnEAEvntE6apVtWjatpNySTt5HnXAbTme7lOPUZuQTc+K3orAkwqNI2d1FHSbgaIyWaejPyTbnoMgMTv9LAkJ6jM4OuQCTlESp2TwQK9/r02hkJeIM+m7oApUFeRhZKLZYJ6OOER2LaNPTCSvsGnFugDbPMwmKBKKJaM7Vnw0ilsTvNXLd+ZmGkQ2Tvca/aY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27da5c4-9d6f-4ab4-6958-08dcbde269d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 10:58:52.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoWSmCODaMkCcSbXFaSQd5UNckgzLdAw1Vf4994Rv/O+W8UF45P26MZ9ef8MGS2zdEJviIpp0Aszgpq4BJTF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_02,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160079
X-Proofpoint-GUID: iv811zjfod4_BLTC8rwXyR4nRcqH1hBE
X-Proofpoint-ORIG-GUID: iv811zjfod4_BLTC8rwXyR4nRcqH1hBE

On 12/8/24 9:51 pm, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that a send operation will issue a clone operation for a shared
> extent of a file if the extent ends at the i_size of the file and the
> i_size is not sector size aligned.
> 
> This verifies an improvement to the btrfs send feature implemented by
> the following kernel patch:
> 
>    "btrfs: send: allow cloning non-aligned extent if it ends at i_size"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Zorro,

Could you please add this to the patches in queue? Since this is the 
only patch pending, I will not be sending a PR this week

Thx, Anand


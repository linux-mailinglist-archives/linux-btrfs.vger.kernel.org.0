Return-Path: <linux-btrfs+bounces-3486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF76B881C06
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 05:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC65B2158F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 04:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33B2D630;
	Thu, 21 Mar 2024 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QdvgKm7J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ob2GIvcl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD91E4B2;
	Thu, 21 Mar 2024 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996417; cv=fail; b=jTM0w7+eogaeyyXqGBkQSeTx3GL7/Wm/5lD3AWxZ5HlkAlwV3E9imquHn/V/NlbSDMeHdvRjySjcwG73KUeWhCbjHFxYh9zJV4PX0N84rsqrxJ7p7gJ9c6BjhWvtwUees0FFkSvAgB/TZ8xz76EVyQNoUI8wIQzfAC2bpqSmN1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996417; c=relaxed/simple;
	bh=0J0DUHiks1SODIhWa0+clJlGD1xK+sPzsa/ydGJ5/B8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HAChmxi2aWg32r9fVVpSJyzv+hCP6827FYafO159YsaVsf7+LnH92X4sswgxvJsV7FcSbVe9nX9fId9eX8ydAXa2SdiHRfmT5upm5C+FVkhoNwy1W/ut2ycvnFnfFGW3tXp1TrTU7GREjJcrg5T83q4syrL349uAVhzrqam0CPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QdvgKm7J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ob2GIvcl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L24TvN027190;
	Thu, 21 Mar 2024 04:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XS7FJPvY7WCRjCTRAaPHZdFipPCJ8aC6uylFadXDiwg=;
 b=QdvgKm7Jx183sNbVT3VW8Ft8YKyCH7OnWIJ8Stf5KgyXHQhMEIWu4249EISWCdT136hL
 s53x1QeLaiYUprZQ2Y1cH3u3hK2tgwr0EJcfiNJJzN6aX2/M3HXzSlHfhJU1VF/5O3zv
 eFHZrA4jAE9sxcmURDszNLbPGhkik2qrLwHWyUybbgNmqgL416S0Y5EYeA0tqQ6QpE5w
 ixrtxADhWuPSr1A4XbZOE1E9GiucPj+F/YgixGG2yzcjdKpDMVdp7ZGFL+wTjbPa2xTr
 ivbBagpsEo7jeeGxQTXZQjkFVlKSbZlWk8vXWsDm0BmBTjvyG8w8RFYgsyUl4I2OVM+y ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu9gjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 04:46:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42L3xOnQ021902;
	Thu, 21 Mar 2024 04:46:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v8py6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 04:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGzn1A+NRusfmWjJs5ijcyBVvbyAhO5/pm3BYe4YCipglFWcWlbo3DQe/JFe9RyE6wIYh3UZuSgGHnVOJwYui/5JBtLCdzCeAkyE9DK/5YgCfYgEhZNlE9zm4AAc+ndUTx28AQno7vikGIh4AUj3Z2xRRNOeCTaq724HV31wWE+PcnXUc0BvE8ULpLsfh52UcTVvVLo/i5G3+geFGU+zsptCz4qr2fCYtdu4Eq/k37dtydKboEobCcx5/ygJY2WhPYxmrO8jBw62s5jioR5MQV+Nnkn5i/UIJeVpkwNW2SlTj68IFDJveeFtY3aLVOOFyzrfptGRpYUjmkEz6uQ5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS7FJPvY7WCRjCTRAaPHZdFipPCJ8aC6uylFadXDiwg=;
 b=LFWxnE//6mWVMY1+Ty2d71YL5lg6jk4zNx1Olkun9hrYUhk/PkcSXgKGigyjLloIUmnxKemVQ1Q1N8/2bYzB736d7k7WUWSC64sqKSo+zpeJREm04BkEjXTlskQoUBaa6tPwaY9Nm4vtPJXsjG7YvqBFNjSaGDQDGmE0q5QVo7BrXsAqfVaNhmSRS4kvAFYxeZaMkaJyKnl0eC5BWbZn4LEkok9YDH/ovNWoI/Xm+AO6RujVRuBi22p2JcwDsyhhFvk97mSsl+mbS+XtL9bjc7ZyqLafVxXJ15M4tFPKSHjPr5F8ma090+MgK9+5qKSn28Meboo4jB/XsFDbYHR1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS7FJPvY7WCRjCTRAaPHZdFipPCJ8aC6uylFadXDiwg=;
 b=ob2GIvclRs/i7XwdyCQixD9m1TTVka3abL81TMNHPcK1dE/SS7Qvd+xcPV46M2JyvHIF8xBBAXOG3/DGU1nmcHiLkl8O5HhjOQT+A/QjyP+TdVm3FbMZsqRjOglfiHiR1V+xfJMSJYA7nWyE0knWd9w6Qb1/gqz4/zgPpErXvT4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7983.namprd10.prod.outlook.com (2603:10b6:408:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Thu, 21 Mar
 2024 04:46:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 04:46:48 +0000
Message-ID: <40b5f077-5e6b-43c5-9f8b-ee1d672f5617@oracle.com>
Date: Thu, 21 Mar 2024 10:16:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] generic/808: add a regression test for fiemap into an
 mmap range
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <dc1a90179b8de25340bd45f4e54cda8c3ab66398.1710949564.git.josef@toxicpanda.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <dc1a90179b8de25340bd45f4e54cda8c3ab66398.1710949564.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2b2b5e-f6ca-4835-2819-08dc4961eae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	J9+t8xX3eUDM40zExdF9LvwBSoV2HktvOxo77p8IuIHjSuVbJ0YuCFDYBzI7Pwi7crS+33UhDcG5d0D09Qybd0owg366YJD2nv2giuu2tFQTRxZJBRr0r0+voHQmLeUKCgqhP2bQXiH5NJeqA1RHRY55djev0ocaVLkA6o87jaTcKNJoHgsmAOI16QTpV67oW9hx1Qo+v7qAsWQarASshW6G/StRFLcUc2LyewQieG34zrYi+k+OlNH0nte0Ow9GQblogZU97IMO4awiggpH9tO4Yal70t6x6MgpuW1zA5Iym7g4NAaYhysrUqO4/FR6FehlVVwzoHRO90jYIzZYnszNAWCr7zTsAF5tZdCxPLnBqiXeax6+tG04xuX0tIzZqSJ33T+8Bl+3/C0hoVGYhhPgmUR1Scxm9RYnKkx8oD5Quovwx69HHIVQ7spz8Nv4ZkCrqbW6N/5nWIHEz9FZGjpL6WxKWAMs1lwCUipstvIkud4y5uDVzaUtOGFnwtoH5LNmiU7WL+MSChs3pCNEORGkqSXs0afYv1NTkMg6ut3w8da8lmLVFboeodnYKK5Kp0VVq7WbpcKRIeyRvGcMe+BFzedPmmiGyexn8ESubXFn05hwzzyMQc1Aq6Qe30lBM1juQnc9g4sJVcv1RGSqBVh2Izh4LanMF5a7lYVdbz4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dlF3d3VpY1pmRUc2V0RuMVQwU2c1dzBySXdtMEJHNStSV0paN0xTaGV0UGh6?=
 =?utf-8?B?RmhKV3B2eTgzN2w5N3M3OGF1aG1jbzltaUIzSG5sMHlZQnE1am9kSEdNcnlp?=
 =?utf-8?B?Y01QNTBSK0NjZjhFZWw4RWVzbDJIQ1d4TVduZ2gxUklOaWNPYjc5Nmo4YWE5?=
 =?utf-8?B?WlcvMXJIQldyaG9aUkRyU2ozMzFDSEx0TENTOGIyd05xWEZCT2lZamJMU0ta?=
 =?utf-8?B?YUtlbUpqTFV4TWliL2w3bFczcUV0WHUrNEw1SDE3VzdoZTJVU1JwZ0lMcklU?=
 =?utf-8?B?VTZUcUdTQWVxQzN0Mjl3ZnRITDQxU2dCTUdNbEI4TUVlVW9jeW1Dd1RGYmVJ?=
 =?utf-8?B?RVIrRlc5SURZWElUOXNYZ0xHTXNEakFETm5oWjhtYkZXUlozS1JkU1FDRmVj?=
 =?utf-8?B?dFQwTXFlZm5BUGtQZ1hsUzMxNDU3OUFONVRlRUNyQnd0aDlkaGllN1BSUXkz?=
 =?utf-8?B?b0tyc3BhREJYTEpheDBBa0JmT0RXc3o2K1hjR3lpQTZpa0M0UVdKeVd0R0R5?=
 =?utf-8?B?dWFjV05YKzZwNjRrd1diSWxrT0JzdE53dC9lZmtmb2c4S0Z4S3VNMCtmT2Fz?=
 =?utf-8?B?WHhvZlZkZFVEQXJ3YnRJWnZFclpHSjFZNWQ1am96cmFzZnk0VVZSeVBPSWpw?=
 =?utf-8?B?RXRNTjFpdWl5Z2llc0hSWjRBT05ncXpGaTlZbTJDcjRvL25lUWc5a2dEV1Ja?=
 =?utf-8?B?UVZiaGJ6OE9nOVRTb0Z6MlR6bC9yTUNpNGpld0lZcjU1aFg0THI2ck5KUTY0?=
 =?utf-8?B?dFlNeHM2YmgwYThMUjhMdWVuOW1OY1Z4a3BzU0FSQlBKZU9hbjlqdGZKSGVH?=
 =?utf-8?B?OWhUdTdBVnNoWFJGak9Sa1czOVlZZHliTUY2eUp2S1R3SzJ4QXVDa3JsV2g1?=
 =?utf-8?B?cWs5L2FKUmFhVGczMlJjNDJrY0I2cDJEYmZwMEtqNENRcGNUTFVTd3RtYWFD?=
 =?utf-8?B?NTAwSFZwVXhtVE9ZMVg0NFdrMXpCRWJva05ZQkdMTkZhSDREVlFVREtqTHlI?=
 =?utf-8?B?RzBmOVI5VTNTZVhVNmJsaWU1TnU4SHJNdENDSGVMR1RIYXlMOWYvT3BKSGVy?=
 =?utf-8?B?clVvcElXOGpSTmZ2L3pCTHBNaWE2UkdLbFR6N1kzVElUcFBsT0VzYW9GOW5H?=
 =?utf-8?B?amZ4TmNHa0c3K0htdUFmcjdmZHc4WmVPSi96aUtiUGlMRkh2OCtVTUZSYzFO?=
 =?utf-8?B?WEc0ODV1NzRub3RuV1cxa05TYWRRb05UcU5VUnZ3dE1RMnFod01RZmR4MDBK?=
 =?utf-8?B?eVU0UjNRQU5HSzU5Ti8ya0xPM2czNEZKSUI3VHl3dnJWZDZMVlRCdmgwRW1B?=
 =?utf-8?B?b3ZvU1huS09naUZ3UTlrWUNva1JGZ3VtUjdnZDQ2RnhlZ1J6TWN4blZzSTZB?=
 =?utf-8?B?cW1VQUtJN3EyakR4dm5NNENicGx1Y1lpenFBS3VPeEYxUVRpRXRWeTliQ2Z4?=
 =?utf-8?B?T1RwalRlY21oSEZiMTdTUTlTMmdHTDNWZFA5eDhpY0xCYVRwckp3dkhhV1NO?=
 =?utf-8?B?N29Cby8zNDMrZlFJbitXVGdqeWZvV2R4UHNJSlhQSlplWTltT1NWSXdiNFZ1?=
 =?utf-8?B?SnZ2M0FWeXNKcjFtekdNcGM5bjRpeDlkNm01ckdISUgrcmY5bkJ4ZUZ3azBX?=
 =?utf-8?B?eUc1ejVSZW1aZVdzbFJ6TmQzNFBMSTNpYzA1bndlcElqeHZJUjlnODdMZUt6?=
 =?utf-8?B?bnYwR1EzNHVUUXlkbVNNODdOclNUbkZXN0tEUDhBTGlmOVUyeUdhR0tYUFdL?=
 =?utf-8?B?SW1ETzlTaG5nSmc2cFpqd3Zwam11dkVKd1ZzajVYZmVqdERZOGxBdWdRR3pN?=
 =?utf-8?B?bWd3M0VHV2pRcU1SNU1WRSt3aTY4V2tkOGVIeVhsU1pPVTYzeGNvWHNZZGlx?=
 =?utf-8?B?MGRjZEhDZFNBU1F3Vm9HRTlZNWZEa1BIbkVvTmF4RXZobW1EeEdyQjR0ZERU?=
 =?utf-8?B?TzJYdHdMVml2azJaRFhUTWltMllmaXUrQVVwUU40anpDbU0zOUdCcytxODV2?=
 =?utf-8?B?K3NZZWtMMEp3YmxmblVtVlY2WFpzb1dMdTlSNjRXb2IxSU9YNVE5YmdudEZi?=
 =?utf-8?B?bjJBdjVRSDlCVGJVMjJXSk1KdU9mdm9Ya1FpdnBZRFJvMVZNNERURlAybUY1?=
 =?utf-8?Q?hc7vLX3VcYDqiXOj2C/sRhOHK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O06+udyf8IxkX2tGwAg6dQ32Y2MFo7wwdprD+brABVpeUJcCf1AIC4zZj+566wAuTb/o8AcUvRmMUkL2ftpUgLsJItdDYE1z5TdalZi+fgwQaZOu2O2tAEYw+VQP84XdntF5iMkdt0qpWqD3zJe6HK0ebpfm4658zuXeAevpfb0P+IPoUrvV8TXBssUIwmJf7KPa72Lz9+p1KdVYd3hVblogWX9rmHlNhKxmaqbxQt1lGGDIzg8MSoFN2AFp/Vo2rMkfZOnGkJVXLSeT9DHcxHUh6xgdBgKut6NRrREkzy8uKNOUC8UjHsFQ58woIHGKEF5ZIuuiTTmJ0iuh/60NqLpK2CXxoHeAtGU/0SYhg/3CZsD1BRvYGkBpjVGJJfAqEcqvsYmcZs5Kpwx8asw1sCsMyfsJSwNtk01+KUtzSvsUJKeMyI2wwiq5m63+9y2HXpnkFXJydrzaeO66gx4yqgzaS3SHp5Rv1TTHDKVvlzXkei3pWPGVAxuHxD0ZIyTdXXJsITtGEp74Kjhp7VSt4SBO+RfiTKVUTY7QjMq7IhaClev+xzqj7TUOv0v4HLAEYVjgEYDfAnUTL0e0KrIAO5k32p7+XRt6InYnZZnX8sU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2b2b5e-f6ca-4835-2819-08dc4961eae4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 04:46:48.4435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I/Lwqa2H013ttpOUPHEOjyM3bs9G3jerUuyEDmZMDolCEeDp6d6pcC6FEKNBisjsmtI638VnkD3aW9zLjHReA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_01,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403210029
X-Proofpoint-GUID: TAty4cPQsYMBLAPOnZ9beUgntc-9nsO4
X-Proofpoint-ORIG-GUID: TAty4cPQsYMBLAPOnZ9beUgntc-9nsO4

On 3/20/24 21:16, Josef Bacik wrote:
> Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> using that as the buffer for fiemap.  This test adds a c program to do
> this, and the fstest creates a large enough file and then runs the
> reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> we pass fine.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v3->v4:
> - Rework this to use punch-alternating to generate a fragmented file.
> - Rework the _require's to reflect the new mode of fragmenting a file.
> 

> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_test_program "fiemap-fault"
> +_require_test_program "punch-alternating"
> +_require_xfs_io_command "fpunch"
> +
> +dst=$TEST_DIR/$seq/fiemap-fault
> +
> +mkdir -p $TEST_DIR/$seq
> +
> +echo "Silence is golden"
> +
> +# Generate a file with lots of extents
> +blksz=$(_get_file_block_size $TEST_DIR)
> +$XFS_IO_PROG -f -c "pwrite -q 0 $((blksz * 10000))" $dst
> +$here/src/punch-alternating $dst
> +
> +# Now run the reproducer
> +$here/src/fiemap-fault $dst
> +
> +# success, all done
> +status=$?
> +exit

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> +
A whitespace here, to be addressed during integration.

Thanks, Anand

> diff --git a/tests/generic/808.out b/tests/generic/808.out
> new file mode 100644
> index 00000000..88253428
> --- /dev/null
> +++ b/tests/generic/808.out
> @@ -0,0 +1,2 @@
> +QA output created by 808
> +Silence is golden



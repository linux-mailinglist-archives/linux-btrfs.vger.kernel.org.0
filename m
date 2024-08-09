Return-Path: <linux-btrfs+bounces-7062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED62894CB30
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 09:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D87BB24310
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C41017BA2;
	Fri,  9 Aug 2024 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D72ioGsN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TMx07OTR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B41741D5
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188159; cv=fail; b=RDx9PAAN/TZ1QCfdWyN5LG+GZVvxuJaNsDAwG11aQmIIIRF/oa4XLxOUgg2A/Txq7EQnAEYgHmJeYLHpQAAkpInmuOiKG3w5NNQSezqfHdulPcB5dngNNNQnDE6PKbIQwa6KtcnWGxR4gNrbNl84/C1AhVrjBCkOgeHS54ZXuBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188159; c=relaxed/simple;
	bh=Co4L3kJyIVL98HyFL9GOxPfol1P6E2dbDpmdmrb83co=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=nI5gqXRH0BExXvoaR7jzsbJ+UHbqUatCOVE3Wu5CfJJsc96fTGdp0WsA01q7VhmI9AsZzbYcfjxyWeUzzd8sOooMfl915qgzl3VEK+3aZx1zwRQZ4I+z6HZdbvYURseuNjgaUR+lkpQKGB02bR6IdhV4JCJzEleJMLoeEjyOEC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D72ioGsN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TMx07OTR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4796CUsx012896;
	Fri, 9 Aug 2024 07:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:cc:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=uJof4F505ByF193qGuB418jaHtNb3PWv7JLnmHfr2V4=; b=
	D72ioGsN6jFvL4VBwkDv81ldB4zEMkk7EHkMONOOU7lAy4WObyQ+v31PBUOpMVzM
	gkA4IQb0U7t0YKAZCmxpYE7f2bcPo7QOHv583RYMePPPkhlqmZxdFhQBwrz11xTn
	hBm9Oe2nupj1C/Nw6lbV7cOU7LJag/JctVjar8Ab7okKZkNIAKpX10amNVRpnFU3
	ZTTMLweoyRD4bC+7eycS4hjh2YplVvmLbqz3XRzzy7fUHwP7Rj1U4avHIZXAEiQO
	WRD+bjwdpAqKMJ9EU9KqbvhMJFCDOPoIyYEiX07AXQa+MLBBg42H3hQdu3EHb7bE
	G03TpEFh3/jrEiRfmQALZQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sc5tkakg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 07:22:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4794joTP023760;
	Fri, 9 Aug 2024 07:22:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0jc18e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 07:22:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEhZrtrs5VrdIt9Lu0jOvzpXs80ndszTFQoJtYj+At5U1FcsfPco65h8V2gfLFcz+2G80h1jMMwbt9HHmHyJd0C0nCbu+JDpyDykyFrJU9baZj4loOivlh/ujSDxYlkCvpiG88tPgZGbJH0b2Dsa5QM9PuwS2GHmJkt96P0D2H2Kl+3gIzHrhOzSqlP1Ca6/EyPTg++BbQlX7s84kT5YHY5sEKa7jlm82arl+QqV4KvFn7XtV/Bhm/AFFvs50CGh+qcyePOkGwgn/8jm5fIKY4c+tLaWIt6d7AtfcVyBMNxA1pDu+QGCL1hr9/GetR2I9Kpwmoi+I0zFToqXRr8+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJof4F505ByF193qGuB418jaHtNb3PWv7JLnmHfr2V4=;
 b=DM9Ds08Z0qeDzBdbHNQzwGPp+LBkQBwF8JXsHdU3n/RrKIO/yHoU4numF93fbE+oIolKnKYgGFnXRRJguVkZ1JAuhqeQa1XkruZPprMxuUsMXs2KuDYZxyZp/6jZdaP1H5l5uzezwlefHG6rvitXnPaSoLjEueCNtRU0P5WEFCPTWF1DqAwI6LcqcKo6T4gJiBczclUjdPN6hJOaCrj/xBJMNF4Y9ggohzgF9jcpFkkZ4k44pWBoJ2dg/1Pmb6mfP4t117EGM3Bz7+h8NGRTip0hYV2SWR1zBXy6C+0SzuUDsh/f+ZB8l7me3zsu6fYTUhIN8W2KF3XJRzDHqRPXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJof4F505ByF193qGuB418jaHtNb3PWv7JLnmHfr2V4=;
 b=TMx07OTR8bfeMQURFCZdYcuTgF+VSelsEZNJEssLQDuFQ9n/Z6EJdsBArNecncmCxOGjHR4LWHCyIUORoAQn/uzA8N8QZ+DKkd3uurDKzCLYOyR5bdMppwtE+GUtE8TZfZAoLtUVjbbLQYZb9C954ZhRVZGFM26yFTfSvoyMJxA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7647.namprd10.prod.outlook.com (2603:10b6:610:169::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Fri, 9 Aug
 2024 07:22:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 07:22:28 +0000
Message-ID: <54cf8c1c-b333-432c-bf37-0029ba0bf0e4@oracle.com>
Date: Fri, 9 Aug 2024 15:22:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Round robin read policy?
To: waxhead@dirtcellar.net
References: <87c646e8-c27e-6853-feaa-38b480892d60@dirtcellar.net>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
In-Reply-To: <87c646e8-c27e-6853-feaa-38b480892d60@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: e942d4f5-ba7f-4e58-31f7-08dcb844067e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2Z0RDRtbG9UNmptWFlvWkgxVnluQm5rQmcwdVNoTWhGTDViZ3dwNHhaQ21U?=
 =?utf-8?B?Y0VLdGJFWFBiTUN0SzlnaWFmb1B3RU5xeFNVY0tqOEtOWUExU2YvcnM5MXRV?=
 =?utf-8?B?WXlmUDNPZUw4THdRM2s0K3JXYTlvd3FnOHBGNnJGMGVDVHo5OHVvcG1BUGV5?=
 =?utf-8?B?aTRuVzhGY3E0a0p4bWpubmZHdVN1OGNWelg3eGdsZG52SFc1YUtudFhidVBp?=
 =?utf-8?B?K1VwcmtBUlJxb1c3b1pERzJOenBRZC9VMVl1THZ0R1U3SzFRNHJoNlhWRGFK?=
 =?utf-8?B?R0FFa29kSDZkTFRCOUpVSUZ3Umxxa0FZbkRDcHpPVWtwTW1IM0s3S1ZGMXV1?=
 =?utf-8?B?d0VheWIxWlpRWGxteE9wWEExQlc0eTJVQ011SkxOOG5XbytLNHR3eEx4Rk1L?=
 =?utf-8?B?Y0pOU1g0YkNxRnNQdzByNkgyMVA1TzhUd0txYnUxaG5UK1RESnMzMjE3cE9h?=
 =?utf-8?B?NTRrOWtEOFRsdU90Tm5zdkQrOEZGLzhnYy8reExFTDQrZmJwNHkvWXJSc1JJ?=
 =?utf-8?B?cjNiN0xnbGUra3NaSDJhaU40VmVucXFUOUloUjZSa2tXWlplV0g5Y1hnRWdG?=
 =?utf-8?B?aUtUTFhnR09KMUE3ay93RkczYW1FYVA3VkxnbGFiSE1YM28ycEdSTHJDeGlY?=
 =?utf-8?B?MGNtREZETXdWZDZxWFhCQXJ0eEp6ZGMrMGxNalZ1ZFdGSXJURU9YVEIvTFUw?=
 =?utf-8?B?TjFXdTFFNDlLaUF6b3BzZFlIOSttS1BNWE1EbEtMUmdCRWdxTzgvOUZEVDlh?=
 =?utf-8?B?UTRGdzNiZzQyYnoxKzFaUEc4Y01rYUw0TXczWVlJRzNQSTZwMzdYMjdXdzJj?=
 =?utf-8?B?T2VPU1FVRitKcXBHeXFBL205RW1WckVoWGIvMUMySTRFak1rY0NXcSt2czIw?=
 =?utf-8?B?SkY5VE9Oc0d5a0hGSFgzMTBoSUl2OHRpZmhPZm5pUEVVckdPZXVVZXl6UG5O?=
 =?utf-8?B?YUNnQkpvdW15TVJHVVhoTzlIR0FpOVduZGQ5KzhBMmt6c21kcmQ2dXBnRmlp?=
 =?utf-8?B?TGp6N0dWNEdYcDZMRE1jbDJ2dTZYUlJMK0tzaWFybm5lMmEyVGxQREphZEFr?=
 =?utf-8?B?V0dWa3pzM0lXSmRIdnhtQ2ZBRmdsM2VzeEhTc2dlbkl5OFBhWGwwaFFZRW16?=
 =?utf-8?B?eTdPa3g5bjlCUkp2eEY0aFJCeEEzYTVDWTdNY0x3dXVWMWtLdnMzL0laQUxU?=
 =?utf-8?B?KzdZQ3J2Z2kzSzlQcXhDK1BGUDVwOEFlcitUNDlTM2Z3a011VzBETFJQditt?=
 =?utf-8?B?YkIvbS8vdDlBb0VMSmJTa2p4TlpmaWYvUjF1MDArSFQ2cjhZcWhYOXkrZ1da?=
 =?utf-8?B?R2FGbFdQdUE5TnFwWXdoekNTNy9xNDNKdTU1RWZqZFo4RjdaekNxM21SK0VP?=
 =?utf-8?B?bVVNUXMranlJeTA0aU1VNHZzNFJqOEExcHRLdVhxdUd6dEVjUmFSaGJRMUxF?=
 =?utf-8?B?a1BFYjlodW9tOFpTTnV1MXB2M3lOVXV1T0Y1dkhsOU53TXhpclEwaTVuZ3RC?=
 =?utf-8?B?T010VWtXNEgxa3FKZ1dLVFlEMURkWk5rcmc5dkMvQzQ2dGx4UDFxWUxxUFkz?=
 =?utf-8?B?TS92L3lXT2VFNWg0TjNicUQ4TW5vVElqOVZKVWRYOXNJcDZKSUxKMGEvc2Z1?=
 =?utf-8?B?UzBtRWdVbE5veElZdEFFY1prbTNGWENUckh1R1o4a1poZjZTVVR0YzVKa0RF?=
 =?utf-8?B?TURPbVVOdGpxOFM2UStyM3YrVVFQSXA3VkZqL0VkVG13SkxDZW1ZNmtyS3Nr?=
 =?utf-8?B?YWNaM1JZR2hhTEtMdnJKa3dyM3IxMnFRTmpjWUZaVWZGZFJjN2U5WlJUMm9w?=
 =?utf-8?B?UUQvUDFpWjBicGlaWWNJUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEhsd2o2TEYxRmJ4QldHREJiQlhScW91OUszM1U4NDc2T0M2VElDNFE5ZHla?=
 =?utf-8?B?ZWVTLzRXVmQwekJRSTh3UFl1eVdBTEFuakFkUzJWanRvSERUdXBmU1NkNUQ5?=
 =?utf-8?B?M1d1UzgveUw0MStidVlVbEQ5bXpvTUhVNEYrSHErbjJhblk3SytraHVRRGNF?=
 =?utf-8?B?M1FVTFRNVzFjQ1pRa0VYaWp2TEhGOVZ5TXBwNGI2YWJSWThlbFpibHM5NnpT?=
 =?utf-8?B?Tmx1dFlWelAxTC8xTUljRWtCUEszd3orUi8zdWdyY3E0cWlBMEZHS0pQUVdi?=
 =?utf-8?B?MTJCV1NqRElIOEtKNGhUekhRdVg5VWdRYWhUYWxkVDZCck1uOWtKeTdkMFF6?=
 =?utf-8?B?WjhMNlhMaDAwTURoYXkxTVJzL2NyVVUxbXdsZzA4NDk3d1BEb1dXdnRHSjNO?=
 =?utf-8?B?ZHJrNW1oWEZjQmg1UnBSUDhjdUdyY0hPY2pFem4zTTlzelBXbnZpZGhRYmtt?=
 =?utf-8?B?NkpDRmVOT1J3WEJmcTgwb0VpeStIbDU3L1BpUXprU256K3FDQzBFck9iTDhJ?=
 =?utf-8?B?NURZOEYxMlZWR2xxU1VKS0d0bkdJbHBmNGxYdHNJd1A5YWE3UVJNT21GNlJX?=
 =?utf-8?B?T0NmaHlsb2ZXanlZTkt0eGNiZW1FdmtNbDlFN0NWaG9ydEsxZW0wc3pLN2Fi?=
 =?utf-8?B?Y2NLYnNPWHAzbzVjOGpuWmpUNk53aHN1THV4ZWltN09jTFFhWUo3TkNNMW1D?=
 =?utf-8?B?dWo5dGMyNllBZDJSbExxUTNlazFyTXdtaCtWbEwyV0ZWN2JrdTRMYU1zT1NO?=
 =?utf-8?B?ejJqNU5QZkhyNE80NFFIQWxHb3hheFQ3eDZ0L0E2dGtKZVVmOWRUWDY3ejFt?=
 =?utf-8?B?RW5JNGNWNm43SUN1TGdmU0NkeG5xblRNd2tiWG4yeDFaQWxkaGRVQ1ZvTEph?=
 =?utf-8?B?akFUdVk1NTNlUXNkSUdmT3ZjQVJEaFNGRHcza2k2OUx6emxiajRuVE9PSHRF?=
 =?utf-8?B?QzkwZzUxTWZwZ1pKTGVoWHBHLzhQNmdEbk9ZcVFCOFhUYzZLTnNTbHJIVHgx?=
 =?utf-8?B?RUZJUS9nekpZTThaa2FpWENDUkh1N1phbFJoQzdWbG9tR1FpVDVKVUpSVkh3?=
 =?utf-8?B?UGl6L2EyQ1haejRkYnhRekYyKzFkYUNpTzQyaG9NcTdHN01pWjBrd0NKQXJH?=
 =?utf-8?B?akZFWUN5VTg0b25VdUFmRGYvbFFYcE04UlpTOUpSVHZoUkZtajVzMkdDV1hs?=
 =?utf-8?B?dTZQeXlBekRGWFEzcDBmOVI4VjVMYTRhN0ZtN3lselBLM09hMnJrcHJ4WTZo?=
 =?utf-8?B?clNJTnFIWWpXblFPRytFdkp0V0RFRC94Q2NYMllDQTJ5U0xheDA2UWVUNDEv?=
 =?utf-8?B?c1VpZ21qYXNMd2lSQ2M2UEpZeUFKUkpVajRGUGpBTFdzZFljQWFJK1dpSVZr?=
 =?utf-8?B?SXZQYW9VYTNkVllMVG0xSklyQWlqcjA1TUVYRHJQMjZvV1FwSnVLdTk2c0tp?=
 =?utf-8?B?N2szVUlPcDF3bXQwNUxJNWZqTGZwQzdQK25xRTVpY3NZaWdKY1N4UmZrYW1t?=
 =?utf-8?B?bE1pUjA5dEp4azRXQUJDd2kzZlBmOHZwUWp6R1B3NTB3UGhWME1mQmozMk5N?=
 =?utf-8?B?K3RuYXNyWWU2M0J6SjRHWTR3SDZ1TGRoUlE2S1BPVmFEemdscWZpdEREVERy?=
 =?utf-8?B?YURWcytNbHdGYzJPckk0d0RCY25tY2FJem51b0lHZzRsK2ZnWUVNRGJYckVC?=
 =?utf-8?B?cE52U0JLd1VKaVJGNXdZUGIrODk0VXhhQUhHaW42N1FONFFVVnpZWjlBUEVx?=
 =?utf-8?B?SWNxWlpUdnNwUGxwWmZBaTRWeWZnMTVPUmh3ZGNJQjIzUG03WlZSVlBaek1u?=
 =?utf-8?B?dWJWeEp4MWRDWiticHdmNmxsaDFHYWd2ZVplT1dsTVR5L0tLL1c3WkNQTjN5?=
 =?utf-8?B?aDZudHpBOGQrTTYwemVZNlBvSy96a3VoakNLTzRkQUovbzNJeGwxaTgzMWNa?=
 =?utf-8?B?Q3J5OW93aCtVMW1QWHRtREx6Um1hN3J5NjNKODZQOEpILzUyMGsxS05nd2c1?=
 =?utf-8?B?M1NsekRxa1FSWTF3NGJMOHM2b1FoRzBOQ08xalpTUkF4cmFPNEFxbXRrUU5k?=
 =?utf-8?B?bnVVVWpTVi83SkFZUkpRYW9zckhXeEsyVk9NRU5zQ1ozVE9yR2U5ZUJMMHUy?=
 =?utf-8?Q?0POfGNK0HCaNnerN9H86//S+X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dB6oWM6TLNBAz6ZWyX0KK0c3IZFn48qAv9syDnmfTnI3Ldlz2jaRNMEzuvPNXt1gEHvwbSjlf/3X/lwV3LYa7GPiHUopdaxAn9mYrAH93Fg9E0Yl7kSZfWcDBtbFKXE+LrW2oJuqKK/QkE75qV1+H51Dkj4rlBUmM/ymifNFGIp+mZvrQH8Tb67GutzA/XH053tRgY0uPAbH4YfvU6B9B33OsFMfnULa8syufOaGwIGaGyMwTq4/hyZrb7TS47TrAxA1vwaYeKAG6Pt+n1Y4LESnfgHr4WaKwAfkGtgK6ZjQNzE4Lrf435VLRZVHxoaRWZZdmykhQJy0g9SOZj7Uw8qfHgumN8Vg9DuW4T3fFk++4UW1seWk4TzuYSL6eRfOBiphrscPMYAa2Fo9wXhESVlj7E4SiRD5eP/sun2ea9oVEv24m/Xhq9Y19PDFHScfuNUhhIGs6hpJLTNcSs3uu2ntgP4PYujFyKr0K4ORpsJQfM7MJq43kKCp1FSWJdfkJ8mCaJeLLa0UN7DqP6SreqWVWhO057q+8j0wmN05YdRvJkaFDtS3LP9+VN1u55aoe4bNliXGXGddxY2WWcLPyw4YOUrhnrebNUR1Tp8Cj6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e942d4f5-ba7f-4e58-31f7-08dcb844067e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 07:22:28.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SjbvOqsXAfcsc8GknU4jjdWsY23xPFRA1feGhskbQioSqDjaX9jfJwE5Dx0EHC/YA57DKGVOM/Pn0hg6dexLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_04,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090054
X-Proofpoint-ORIG-GUID: Wif9czgKswvhwlM8ezjNpTK_6dR4IDKE
X-Proofpoint-GUID: Wif9czgKswvhwlM8ezjNpTK_6dR4IDKE




There are patches for other types of read-balancing already, like
round-robin and commands-inflight, and there are also patches
based on dynamically benchmarking devices—some of which are in my
local repo.

PID or round-robin perform fairly well when devices are of the same type
and there are multiple threads generating I/O. However, this is not the
case in defrag, where there is only one thread.

Neither PID nor round-robin helps if the underlying devices have
unequal read performance. Both methods can result in lower read
performance if data is read from slower devices.

Another approach is to benchmark the devices during `mkfs`, but this
lacks accuracy and carries the risk of performing unnecessary writes.
Good read performance on some devices doesn't necessarily translate
to good performance for read-modify-write workloads.

When trying to base decisions on the dynamic performance of devices,
earlier patches became complicated because we needed to know the read
performance of devices at the block layer. Calculating these performance
numbers wasn’t readily available, and doing it in the filesystem layer
was expensive.

Finally, I tried basing it on theoretical expected read performance,
but the necessary information wasn’t available, and it seems that
those patches were rejected by disk vendors.

So, I concluded that manually telling Btrfs which disks are preferred
for reading and how to allocate metadata/data chunks is a better 
approach. And balance reads across only those devices.

Thanks, Anand


On 8/8/24 11:40 pm, waxhead wrote:
> A while ago some basic framework for the READ_POLICY was introduced. 
> (Personally I think it should have been implemented at subvolume level, 
> but that is another story.)
> 
> Anyway , the only implemented read policy so far is PID based.
> This does has it's flaws. For example a simple operation such as
> "btrfs filesystem defragment -czstd -r -v /usr" would read all of /usr 
> from only one device which can be many gigabytes of data. For peace of 
> mind a proper scrub is the only way to go if you want to make sure all 
> devices contains good data, but that can be a hassle as well.
> 
> If however a round robin read policy was implemented, the same operation 
> would exercise all devices in the filesystem and kind of work as a 
> "cheap scrub". And while this would of course not check all the data on 
> all devices, and therefore being far from a substitute for a proper 
> scrub, it would still be a reasonable good check of most of the data 
> anyway. Especially on systems with a low utilization and in any case, if 
> redundancy is your thing, it would be better than the PID approach as I 
> see and understand it.
> 
> (A round robin approach might also be nicer for spinning drives, both 
> for some wear leveling and ***maybe*** for increasing the chance that 
> the read/write head is not too far away from it's next seek target.)
> 
> So not for performance reasons, but for reliability reasons. I would 
> like to ask the btrfs devs to please consider adding a round robin (or 
> even pseudorandom) read policy option to the existing one.
> 
> As for the technical implementation I not familiar with btrfs code, but 
> maybe something as simple as adding the chunk number / unique chunk 
> identified to the mix would ensure a somewhat relaxed round robin method 
> that can be used. I would imagine something along the lines of:
> 
> preferred_mirror = first + ((current->pid + current_chunkid) % num_stripes)
> 
> instead of something that is probably more "noisy" as:
> 
> preferred_mirror = first + ((current->pid + rr++) % num_stripes)
> 
> So pretty please with sugar on top... would this be anything worth 
> considering?



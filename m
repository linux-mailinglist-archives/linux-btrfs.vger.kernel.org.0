Return-Path: <linux-btrfs+bounces-3552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDF788A364
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 14:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9CC1C398C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AB4159902;
	Mon, 25 Mar 2024 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LvmJbzJY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r6Fbv/Wx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C815920E
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359468; cv=fail; b=hVPAqSspD6H21EZE8CkLJvqL9sqzbuCZZ/GeQAnObFO1wi9nmKkZi8QU6wYrYkDRwsa4XXYps8rzEt3vJdnk5AGhZ0dhqx+E4yeriGh22equ7TlULBm3T2it3Ts3rZMByIxQDbYBxhb+fboygWHT/eDIhgGCIVquqmY3i2ftdxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359468; c=relaxed/simple;
	bh=7Mb2ObNO7HWOboNNtUw7bKP4qs9/gxq5q2QV2NM1YYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dEWSIbk9zC0BHDGwMWeLP7GfnezXAsJrmka034ZyqTqxwdUo8yPnyYvGqo1yYnMupHwa0RfsOLYgEunpL7897i61yCaEcGJTmehFVPKUuVjDCN06r3i2Wwl0r+r3ShAXF/YAmChzFXUnpmhhcz1i6VySY1sqBUImddFo1ceYAKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LvmJbzJY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r6Fbv/Wx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42P8pOgi020272;
	Mon, 25 Mar 2024 09:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IthhbbNldihGEsU7jv0Gh0YqORmg0Aam0Yysd4zXht8=;
 b=LvmJbzJYXoO18ZA0vSZ01nbtAVk/OVJsBkqbJfrWUaYKEu3DftKK1GIKz/dNFWqOkffN
 iZgULMMiVypgFM86ThBx1+yvhODMRcizpDNSIy0dVxE8ErHi5NDPzJlfC3NrxGtHVVbL
 Y4yQoWpYpaKTDaVQ+eliSQx2okwlFr6AyZZhLY2xxG03gaTTASWIYGC4ysnFn7+E9IzQ
 Gr+47cRH+Eds+tjyR+X/3uxupA3s/1Zk/iN8vbCgqVtNXRfV0XIx1vri/0gNHcAORUH4
 NxRE47nd1LnAckIKg3C1ylJQxHU2WQxw/h5OEUcFYEWVNI3AepnsgUpfsTFI6GujWS5i 2A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1np2aarm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 09:37:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42P7HaGq036823;
	Mon, 25 Mar 2024 09:37:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh58hhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 09:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AB6nNWh510pn6cSMTU4vYhEWaL0v1EfOW1i/g2jGsyVJVsyGX5poqHlRId3o2yWyufS7gsW8mGtCeg3jkubUQCTtkB7sG/+QB8j1CfmTBlMa9dpxmJJnGmG71HrQOxAxx+cpMirxhC5gNZ/Qq/6N/lnV+KieRO71uPSLIWMAZuc8GvcSu5GDdN7055ayy2NVmKnmNJKC173HLXKI3UVKFVh1LB2d/HfDpKIHBZGgk9qwJVuXsPXUk/VKXCB0nkq5ncQVRZQ1QRksxm3FxRIUmQOusJxVPQmbIa/+m2NxFsVvU0u9F5F0YAYDOyXVLS/TD85Oq2kRvRsl5iShuGXTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IthhbbNldihGEsU7jv0Gh0YqORmg0Aam0Yysd4zXht8=;
 b=fp4VV0SyHcfjjPEa/+QSVhpK9sLz8SnD5C8ZxwzTS80xAEsmMDdWcoDDbE7vERfaMtu6fYDVRCU4evKT30WnGX2EUsW2XZ7HKnznAno6tp+hGBqBot7g4xeTg8Cn27jMEcmJR+Vsvp1KZnMwuCt11+9oEsEMwvTJhMqKHYVAfhqpgz/kv+SGXaMhdPnGyq9nIIRbqKMFC4kU5L3QqOAaFXb4Z5xKCg8hK/vmjNov1CY1VIYoLkWdLgSYIn7CLzoamRDBRDHmcdrvCsnHzXgNuo2bUHxoc8QLz/6Wb8X6tk7UdrOXoJ8nQ6NdqJU7oRT7uiJJBd/btiVerOWEfaXHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IthhbbNldihGEsU7jv0Gh0YqORmg0Aam0Yysd4zXht8=;
 b=r6Fbv/Wx7OBiVXaCj8zvXFJfXvaqeQgFULqTS3MH3jef4W8ixQ1VkQAHgw8+VUuFKHZdxiT48P+pWNHJLz3gabGr60dhl+j97AlrHanURWkpC1wZSyNAN7J8flI3sdya/7IIDXtyZ8fiTHiGQAKDjhr7muxHlX4YTO8S8lt6BoM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4175.namprd10.prod.outlook.com (2603:10b6:208:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:37:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:37:30 +0000
Message-ID: <9f809cf1-1b76-4551-b096-6a0844ea8d79@oracle.com>
Date: Mon, 25 Mar 2024 15:07:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/29] trivial adjustments for return variable coding
 style
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <20240322023201.GJ14596@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240322023201.GJ14596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fda910-051e-44cb-e776-08dc4caf30f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GPnmcPxezf87PlosUDJ6MYl2alOL4kc8VF7i5q2E+lhf4jDBgEPvAhSLA1DeLDWYfANuXqa4LzWTM5UT8SvnqLo//965rm2BPVDxzb+4oWJ3HLLQiC7Vq65qLyvMv1qgUMKiCNj63H8p9NWUH1EpShCSgw5vkk4oG+VF3Q/aG+RMqVCnl90Aufe58WrYgGAIWBJv5UZT+sNQlEh65IYEy3Pn0VtjJIIMreIq3412VJNyG/xRscF33ezkZtIRNpW3Zlc1f3McaosdbE2oI0daH1KXow22sbGbJKtDq+LIJQ+dtsVsbil53KrJ6qcctSNcfU/5mzU+B/tnmQiw9HNAY6NPlja+2qHxGSIbR78HrUK9j1zyU7e+sMaH461r84Lg15dGT/+h3cKbxu7wjS5YQBWl86NU4UFxWW6DBwvvFyXt3Oq09UXP30ZdOJvB5zKLDlqG/NrjqkWtLDmtW+XdyjL2srB1ZDToo17FvrCpDknZuyflmct2tWiq4eyVO1kQK6Sbce6ShaewHKlrqwZZIR3JXJMKenWm5g1OKtfcy9LWdNgHxx78ek5+njOPrkaLnZG7nLTFiZlhAkgpc0eCU2rLPtLdWWVzqvYK6B0r3WY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SEFjSDNpTmFBMnAvai9EMlYzeWtYbld4UEtGdjlDc2c2MkFYQXllams3SDlF?=
 =?utf-8?B?YnNpc2tWRVE2Q09LUmhYWENITFdMUjQ5cXlWM1dKVHZJVk5PVTMrMG4za3cy?=
 =?utf-8?B?RGJVYmdtaTgxTEl1MXRZb2srQWRDd1dIaXJkS2pHQnJyWW8vU1ZrK1NTOGFQ?=
 =?utf-8?B?Sm0yN3JpOWxMa21DNC9XRStuQTgwZU1zTmdETlRmRE5SdHE2eFlRRWtaM2V2?=
 =?utf-8?B?OTUzYXZuYStlRExlSUUyL2R2cVoxcTRGdmlIaHNKQzJnY2NFSXBiMmYwT1NX?=
 =?utf-8?B?THYyT2o2RXhzTjZtZ2VHVG45WDZ5VUt3S1ZMVmJDTTBudko2YUhuckdxS1po?=
 =?utf-8?B?WHNSTlMvY0pkbGZ3Wm81NjFYTW0rNWczSDdyM0tmN0sveUhjb0tISWVOcVdu?=
 =?utf-8?B?amo3Qmt6bnNIVC91TzVWUXFDWE5ZWXBBZHUwdlVoL2N0VDdWMFBIZVBWS3ox?=
 =?utf-8?B?OGp1ZHk2NkZQVEoxUDZ0S0dncEdxMVFUcEhjU24wR0Nna1FQbW1LQTZMVHJZ?=
 =?utf-8?B?d3JaRFpwSEhGeWlRemVyUWlVZGtJZE9DdHpYNmNzaS9WQXNZNjRadGxzYVln?=
 =?utf-8?B?QTZtSFk2VU5rU0t4TCtVdEtVanVaejBZSWZmcVJsZXdjS0g4VHFiY0dOVW1N?=
 =?utf-8?B?OXh1OS9pODB2QmIvTlJQM2dSNTRQNTk5L21VTXFHNTc0MlN2bG9XV1pVTDM3?=
 =?utf-8?B?Ym5zUjhiMkNGTGo1Umhkb2pidk9kdU5rdHpNb0JxUmt4cFltOTlJZlR6Nk5G?=
 =?utf-8?B?NzJvSFFNYXV5enlMdW5iL1poRTJVTCs3SG1EU1dGQmxzYkhyYlFMZXJzRnBW?=
 =?utf-8?B?eFBmS3Bva2tCaTVFYUZkMWpuMWNYTDhvUXVYbEpGMFA4Zllyc3B5WDVUa2RF?=
 =?utf-8?B?SzdkOE9kcUdDSkpxTVRmRFowKzByOXQ0NWJUZmdJQkxTcmJRMzhvMXVNTzRh?=
 =?utf-8?B?TlB3RlBQdXR1MHFyUGEwd1RObDZZUHJBT3pCWTU2NUFxdG5aZGdjc0JXL01s?=
 =?utf-8?B?RUYzNDQ3bVNoL3ppakk0NHpWcHhmL1F4ems3RGxtQmFpaS9QYzFJSmR6Wmsy?=
 =?utf-8?B?elp1ZWxud0RoRkhnN3FFV3JWako5bkpOR1BpZXorZVRTU0JLV0V3NWVJL0xO?=
 =?utf-8?B?eElRbjM0cDQ2T3U2SHZad21ISmUwcE92R293UndVbVhiNkpDKzFreC9JbHp1?=
 =?utf-8?B?SmROcUloaE15b2FYQVA2TERoMkVvVkhPcUV3R2hlekx5ODJkdk1ieXV1dVVH?=
 =?utf-8?B?a1g2M0xibFp6L0I4d05ZNXliNUIzSEE4Y25jeUI1TWU4VEdYbThNRW9Gay9O?=
 =?utf-8?B?VmgwdGUzV3BwZDU5M2RoeVlvMjlhY3A3YVlNTkdySW9JazNmOFE5V2VKSEhM?=
 =?utf-8?B?WWlSelNMVHNPdHVwVGVHQ2hVUGtRc1JLZ082UHM2MnJNeGZla0N2dndlSXNO?=
 =?utf-8?B?NHhidC96NjA3dEdkeWE0NVpoNUlPS1RvM0JVNmJUZW40bkNvYWI3MFV1SENw?=
 =?utf-8?B?ZWtSQTdSdVAxdFNqQ0k2UzV5T1djWS9VVVNNNEdkY0RWWFp0dkpmSVBiVzN6?=
 =?utf-8?B?MUlVYXNKUUtJWDBvZEMrS2xVeFI1MVF2b1psaWFadTZPZURVS3pyb3dHTmJm?=
 =?utf-8?B?dkZST1RqU25PZmpidy9SSHBLbzFrQjBqenpzZDdoVm94L3laZDIwWlIva0tj?=
 =?utf-8?B?b2I3ZlJtRjA0emJBd3VzT2hab0JuWnlSbG9FUjcvcTFUR2lCWGRySmpWYk4x?=
 =?utf-8?B?VUlhZkh5di96eVpIbWZhTS9aQjRQcDlrd1dhSFB6OGFoOUZBeFZSNXliaHl2?=
 =?utf-8?B?QmJqZTk1aTRreGIvSkJrbHdhU0hxOWxKTEF2TWVKSElNcmF3RktVQTRaLzhR?=
 =?utf-8?B?TUxoRW05QUQ0T2YrUjR3ZkxtNmtqM1ZSSGFwcEJxK3RXZkZlVEtXRmhwNWxq?=
 =?utf-8?B?cWgvVnBKdVdEenJ3VUpOcTE0eWhDekNHOWEvWjFycHZaV2pCOFhsMnpBY3dY?=
 =?utf-8?B?SC9vYUhNWDR1alltN1hCajhyYkVxUE80NTR0SjF4aXB3NTArVkIxMlhkNXVo?=
 =?utf-8?B?amgxTS9OWGh5SnNQQytqYWJGbHZTNVNCdHUxdDd0VUFoTzI3TEpPcStFcGlX?=
 =?utf-8?Q?JjapMCiezJDFr0d3SjjyM2+Dw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qoFqoW+k8Dd6YbZlYdPP8UVufsVO7QbqEE3Vc4j051nr2ol0aQV84G6A4yAOmtBeJ2YrodsYRuJeLICfjvp+wJm8TriHrH5JjcLgmSOxB44cLEhABgS+5gypVtxanycs+xaxTkdjdgFPtGLLvu9h+mWwqpewBdhOocZZlkyjiYnTYF2TS7bTB77WRr2Acp/XZcdWNFRuhbYrb6deIArnkTGxZqpKhTpTxbl+sk42xpIn2PoYAVFDvWEgt4VHhYX+m8wnk7Z0YxHwSTOVNoxKa+zjT0i5ka/IALCeuak3QdBGcqVMoH35KUfY1izPhKQCs4mWu2grwotuJRgxwARj6CQr1acjTW45EZ6HuQvnhZF6sbUixfk5C1jkzcUzSe2pqL9BCIDkl5PHJpovMYbmZfOXuVKoR2PzDGW6S3Ld5iLAxqw2J7HtgiFOiXphO6ICFrIdHscsRyI4HLHwZxOJ7EMa5olqO/P4nGvLOAHDtE1YkftqjzNsSLGvcW3qyCmRGB9/L5XG1wjvPxo61YV1HWjb/F5EIFcMQtGBdpSumXdnQwWdpy0RSmsyi4HvDUMKDO6crwApAKc2f6DNsPElCKtfKCuS0g28WLaoIK1aJe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fda910-051e-44cb-e776-08dc4caf30f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 09:37:30.7564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lchOJjO7FIN1Gg8qooMc2OGlgyqtBZ7os/5+it4N+S5zYQLsf1+Zum+nwZtaVjbPr4EGFXPcR4vHXGgRSD518A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=987
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250052
X-Proofpoint-GUID: 7DYXA5yzYcEyzJyKVtghT2LHYh2igawp
X-Proofpoint-ORIG-GUID: 7DYXA5yzYcEyzJyKVtghT2LHYh2igawp

On 3/22/24 08:02, David Sterba wrote:
> On Tue, Mar 19, 2024 at 08:25:08PM +0530, Anand Jain wrote:
>> Rename variable 'err'; instead, use 'ret', and the 'ret' helper variable
>> is renamed to 'ret2'.
>>
>> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#code
>>
>> In functions where 'ret' is already used as a return helper (but not the
>> actual return), to avoid oversight, first rename the original 'ret'
>> variable to 'ret2', compile it, and then rename 'err' to 'ret'.
>>
>> Anand Jain (29):
>>    btrfs: btrfs_cleanup_fs_roots rename ret to ret2 and err to ret
>>    btrfs: btrfs_initxattrs rename err to ret
>>    btrfs: send_extent_data rename err to ret
>>    btrfs: btrfs_rmdir rename err to ret
>>    btrfs: btrfs_cont_expand rename err to ret
>>    btrfs: btrfs_setsize rename err to ret2
>>    btrfs: btrfs_find_orphan_roots rename ret to ret2 and err to ret
>>    btrfs: btrfs_ioctl_snap_destroy rename err to ret
>>    btrfs: __set_extent_bit rename err to ret
>>    btrfs: convert_extent_bit rename err to ret
>>    btrfs: __btrfs_end_transaction rename err to ret
>>    btrfs: btrfs_write_marked_extents rename werr to ret err to ret2
>>    btrfs: __btrfs_wait_marked_extents rename werr to ret err to ret2
>>    btrfs: build_backref_tree rename err to ret and ret to ret2
>>    btrfs: relocate_tree_blocks rename ret to ret2 and err to ret
>>    btrfs: relocate_block_group rename ret to ret2 and err to ret
>>    btrfs: create_reloc_inode rename err to ret
>>    btrfs: btrfs_relocate_block_group rename ret to ret2 and err ro ret
>>    btrfs: mark_garbage_root rename err to ret2
>>    btrfs: btrfs_recover_relocation rename ret to ret2 and err to ret
>>    btrfs: quick_update_accounting rename err to ret2
>>    btrfs: btrfs_qgroup_rescan_worker rename ret to ret2 and err to ret
>>    btrfs: lookup_extent_data_ref rename ret to ret2 and err to ret
>>    btrfs: btrfs_drop_snapshot rename ret to ret2 and err to ret
>>    btrfs: btrfs_drop_subtree rename retw to ret2
>>    btrfs: btrfs_dirty_pages rename variable err to ret
>>    btrfs: prepare_pages rename err to ret
>>    btrfs: btrfs_direct_write rename err to ret
>>    btrfs: fixup_tree_root_location rename ret to ret2 and err to ret
> 
> Several patches got coments that would need an update but I think for
> the simple err -> ret renames that did not involve anything else you can
> add it to for-next.

Yeah, to better manage the patches, I have just pushed the patch
which are direct err->ret renames and does not involve ret2 and
have comments/suggestions for better ideas.

I'll be sending v2 for the remaining patches.

Thanks, Anand

> If you're not sure about some case then send it in
> v2.



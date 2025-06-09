Return-Path: <linux-btrfs+bounces-14561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E76E9AD2370
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 18:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3661885A6A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 16:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27298217736;
	Mon,  9 Jun 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="madU4yl7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NN20CW6Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE31494A3
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485352; cv=fail; b=gwNLmMRwOkvU+X9ZRfO+MOxyYT6mr+23Z5HN0/zUZpT97bUS6tntYcKpWBLu1qPyCRgAFIoXcIHsA7BohY0L2WOIq9SUJEabw6X8/gVrdKXncjLm0JH+PuFbq1S9pBp1jQIc6I59Uv4CWbj53BsMZyBC+k1cWNVPbVV+4P1iZM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485352; c=relaxed/simple;
	bh=0hQMv7Cu4PX2NC6AcLOMtmfLqbDUswbqmE4SvHL0fwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nP+jx8nVzx0I//c1Z1l8fnC2bf8rjrspMWBmVQUDwZKJC9gse1NVNuUMJ1Xz5oX74Yrl7Jqu0C3mWy15AK42LzfxATB1HBtlw8fvW8gXLD2rrwpyfR9nBMFif92BsJXxfh+X1GIERIek35Zv7gv2OWkHEow3SkHUw6fOaIiwesI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=madU4yl7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NN20CW6Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FXQmp030944;
	Mon, 9 Jun 2025 16:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=v2p3cy7MICHsC3IVVK+gwh9JlVqX5wwVv2lrMc2O6kA=; b=
	madU4yl7RGTi0Rm/0nIw0X9M7PYXNiYKyqE7lSHQBhe9h1/1aa4VnU+SIIyWMrFr
	5FZNIroiLzqLRJTCfSBVaTiR4K5O3sunLtqJiq7ifnZ6E9ZQiP2DdcQX1mbEfLMU
	a5IFbbhTVGZADyYn6XY1IrCYCtBEtKnRp9c/WnjKV2OfjxuDcr/xp3SsgX3+Kq7i
	DInTlZqoTfb3mcc+RHlyVxuesSqbSH1A49OIXR/olRZGYQ73UbSta2N0HAIMTpsr
	HNkhw0KcC7VeqUp0gKMVyOxvlPT4St9SkXQlp69715/0NbMcHhZll0ds9TmwuqFo
	52yVHChPq5nEvVHrv/WmxA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v2fqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 16:05:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559FoExL007378;
	Mon, 9 Jun 2025 16:05:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7cgte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 16:05:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApxKoAKJzJg+0IYN6b0VVPKcawFoLpb1j2iQ6h/kbbmvWILGzQzdFkVkfqcqERSy9hUWhezR5E/LPHDeVt6xYIHCWJj1/Jbh5qhx5MZvua9aTIOKZE0KkRjB1CLQynhkmTwL2ewrE29UL9Y2KIOT6n3jKfbUn4QxxW9pRcOHxBZrPUJlN0SLvu3GE7Ge8XjLymg4yZ1M13XIHPxcDoh2fWAd5W97H92sMaJpqlfn3OQs+7BL739CL3arCS11XcKa0JiS9xgIbr+TYuLPCLSCiwr+7n/MTwWYr4ASUoqv39xNWDwJJLKVhd3mS3/7a3iib4kWWpOVhzidQbw9S+dDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2p3cy7MICHsC3IVVK+gwh9JlVqX5wwVv2lrMc2O6kA=;
 b=tsOxnsxcQRnlyfj4rsao3NElqnLH22EIAHfL22DszMt/i1/ewCZf1DLMo/1ngwSCD8WEsPcmycH5ADd+iWGsLO52P1N56CYzuvFDVOas2A2kpgVYhsp4Zb2DDKP2LQ64dClyXqThKpJ4lwcEjcPhwJQTFxABV3uSX+qQEvprqqvxBMCkmtWgtG1V9q5MXoy+1FX79BMdsnWvIbY9AGVThTq1e7dZ5Wa47Wlm2pkadeSyJb6Cn5kmsvX+mdtzv4312NBT+H+L1ZtDBOmydmwNETNtWaqQ1vKUBzI1yNAktF8Y2euUicT0sdDEKoBevgkUr4iHU2rcDinqzUfE7zDu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2p3cy7MICHsC3IVVK+gwh9JlVqX5wwVv2lrMc2O6kA=;
 b=NN20CW6Qqk1Zfz9R1EhVl9TULELq99eW0E31GioN80UyUHrW4FUbgoov17wHytaZ3NE0eify74j+pjOqVrdj4hRftShzJxSWcYexWW/Ghd+yYLOIDwK95oA+OlkFfH3RdmI0RsJX4k+kS1ap4bH4UysQb87BUSh4wquYlsFHBig=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Mon, 9 Jun
 2025 16:05:40 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:05:40 +0000
Message-ID: <9a1344dc-a7c1-4d1d-aa12-7559cc2bc856@oracle.com>
Date: Tue, 10 Jun 2025 00:05:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] btrfs: remap tree
Content-Language: en-GB
To: Mark Harmstone <maharmstone@meta.com>, Jonah Sabean <jonah@jse.io>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <CAFMvigdEQVj-uJqfCVqYXf8a51xY48gsYg+tvFNFrC3gPyF-gA@mail.gmail.com>
 <e35b2329-370b-4844-a464-d0a29573874a@meta.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e35b2329-370b-4844-a464-d0a29573874a@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|PH8PR10MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 3405fcf7-206f-4f2c-a018-08dda76f7ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUNDYTg2UllkUXFsL1MvU2w5ait3TXdmMXIzT2loNmtYOXhDOGZYNGszNnpR?=
 =?utf-8?B?Yk12WTRqYjUrdmgzenlmMG40ZXBLU3dUQ0hlcURxZ1YvMmJkczlDLzlteTBM?=
 =?utf-8?B?NmZYc21HWG9YKzBPQkhxSURyOFp1WEp1ZkVpZTU1WjdhdjM4anJ0bnM1NDcr?=
 =?utf-8?B?YnNyT21YRmtKN3BpbTc4RjNkaHcybE5lUnlIRnhuMkhiSXVsQ3JtK0JCckpR?=
 =?utf-8?B?Z2lrVFA5MmtaUzZnQSs5WTdZS29IKzBodjUxZTF2RFhEeld5cE9mQTBBMnU5?=
 =?utf-8?B?SEpCMnhmS05POURIajh6STQ1L3Z4ME5kR0JvQWlHUG1CSzA4Wmt1dkNlNlhV?=
 =?utf-8?B?NEJTYWxBdFF4ZkdCVGpvWGR1cFRJTEpnSE9uTldnMzBnQUREbWUzbGVSSXdX?=
 =?utf-8?B?OVczdUR1SjA3QkllZmQ3YTM1dm1JVzUyZ2RqMzhVd2w4ZURVZWVuRUFJWmcr?=
 =?utf-8?B?TmdHcWltTHMrYWNTMUZBQjRFdjkyZUxBUzNPNUQrOGphaTlBRmZLbUxUYnp5?=
 =?utf-8?B?TUZ5R1FKNU9ZdzVGNG0xbkdPM2NLeVhKVUNVVHV5cElvb1BQNGlQR1BUaWY1?=
 =?utf-8?B?KzI0Q2VHd2JHNE5mNHdoV0FtV3crREh2eWV1d1ZFclZjcTJ2b3IvQ3pLcWUy?=
 =?utf-8?B?TEoxdDJBcVZTTmVjaG5MZWxNd0treTRyZHJZMEZvZGh1dlNaMWFDeWpXMXRG?=
 =?utf-8?B?UGNGOXQ0M1B2THVkd2VVaUplNHgxcHhnNCtDVk84WlFXQlVKNUNKZ0ZyendS?=
 =?utf-8?B?RWt2cDdzYkpiM2ZoT0hxSkltdTh0NFcxdzdkeG1UVXhQN2pFaXNNNE4vWUIy?=
 =?utf-8?B?TmlNNDZ1elRLdkFoNmlxeFIwNjdzcGc3STFpY1Eyd3p5R2xtaFVjY3BpNVBn?=
 =?utf-8?B?SEpOQTQ5clBPZ0ZzWEJGdlRUNld1d0dpVGhnZ2oyTDZ5azJRM2tOajVkTjlL?=
 =?utf-8?B?VXdqcFNwbG15L1BrQWt5TlF3VGljYlRPakFvNjNZKzcxWk9qZlVKLzNzK2h3?=
 =?utf-8?B?VndVZE9KNFlCZEx6OUhQUzBQRWMwNVJjUlNneVZDNTk3U2lvVzlvOVFhQUxk?=
 =?utf-8?B?T3M0NlU3bnpCM3VMbUt3RFRvR3FXRkNqSXJOd1VWcFhxUFprVHVJU29naStV?=
 =?utf-8?B?ZlJISnA1OEJXVUxvL3pRVHBMVlZzeS9kQ3RnRHNJalR2R0pmMmhCYlVEN256?=
 =?utf-8?B?WmM0N3Z3SEZxU2F0WEdFbC9XdWw4MU5ZSXptTEZpaUcyU1ZQbHhQbE1jaE1S?=
 =?utf-8?B?KzZLeDU4QWxobDVSTVR5SUlYekFRU3FMemphUWFxdjNsejd3QW54SnpBdDhR?=
 =?utf-8?B?TXF2RTRpTDB5ZWhmVjk3cVVkWVlsV1dRSlhuaVdUMzJoNW1NRENucTlhRnNy?=
 =?utf-8?B?Z1VvK0xMZ0xYRDVJbzJ5a2tOeVVOSVVzb2h4dWsyRkFaTUNpTGFHMmJ5ZUt3?=
 =?utf-8?B?aE50aWM0ZjVwV1B2YkpoNzVHSHdyOEN3VCtQNWJZcmtETHNGdkNVUU15ekRH?=
 =?utf-8?B?TkkzQzFrWWc5eXNURmI4RUcvWDgzb2wwZElwQlNDREszNlVZZXl4Z0FEcFU1?=
 =?utf-8?B?YWo5UEJOWHVuSHMwcm9sU2UyRmNlZkJIQjlhSWRubWtSNmtucEJPU2pVTTcy?=
 =?utf-8?B?MnJiaFluTitPMWhlcFRybWVMYUJuRDB1NVdvaHNSTUFwTU1kRy9FenIyQmlH?=
 =?utf-8?B?L084cnM4eU9STFVGYzl0ZURPMVVTaVVmZmVQeGRGNi81b2x2dlppQkRkRmdq?=
 =?utf-8?B?UlI2a2IxcnN0MDMramdCTlZhMm1YL1RFRitkRTlubkcxUnI2V0JKdEw2b0hZ?=
 =?utf-8?B?M2ZISENkTGlManNCZmhpTEh2NS9XSzhsKy8rNzRIbHJUdU5lME9WSTFMMUl2?=
 =?utf-8?Q?g/26qQ2tWiU5/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0ttK1M2YWc2R0NMOTBhZUZDd0NUSTRMM1Vqcy9WcUtSb1hXdWwxRWJndlVl?=
 =?utf-8?B?c0ZVdEptZDdHb3NpVTZlalhIa29FM09hSGhaeFlWMEpBYjM5SVh6YnFIek5L?=
 =?utf-8?B?Rk9LdWNnRmZPMUtGYXo0WnFKVlR5bG1TNTU4emhOLzBZVlVDZEl5My9hTGdi?=
 =?utf-8?B?S2hEK2NoZHpqR2MxcjJxazNnVDY4VmRzdm9oTzlFTG8rUjRkUllqRU9ReGln?=
 =?utf-8?B?QTlHcXViSjZzUVR0WFljVVhkVEhYZ05Mb1JWcHBaRTk0TDFrL3BINEtoamFh?=
 =?utf-8?B?ZWRIWG50T0FFMHdtbVYyS2pOeXE1SEJZa2hDTzZLS1BQMk1vRzZBeFBQb01F?=
 =?utf-8?B?VU9XbUJOcmMvNC9rekF6aW5TUVEwZUdzLzlTcW5vKzNZODRRZFpiWFMzcGVR?=
 =?utf-8?B?RWpJZ0NvdENqdHVKc1FlNnEra0UwYi9aL1cwaVVlQjVzSElMWk9nNktZRUJi?=
 =?utf-8?B?aVJuTS9EQ2JpR3g2YnpuR1p1QTBGMWxjYi9IUENmSUdpY0tGQXNvV1dFNk0x?=
 =?utf-8?B?UjI5K3FJVFBQa0dsQVkrN2NpTjR5Y0E0eFg3OXF5b0srU1RzTmlqeUhkVVJG?=
 =?utf-8?B?U1VEQ2dkUE9MZXVEaW1hbVA3RFZUbDNua1lUZ1JrZWRMMjQ5LzdRN2I5K29F?=
 =?utf-8?B?ZFlZcE9mN2QzdXJ3UUVKYS9tcmR1N3EwQ2U0SklGenBrN3FHUG01RlFsRjJT?=
 =?utf-8?B?VWhpVHVNb0FiTloycFFpOTVyeFZHcVdROWZiZTdWdG1sSGlRanBranJNc2Na?=
 =?utf-8?B?RFh6RWprU0MwSUMwcExYMUs5UWVoQUhISWZqbUZvUjZOb2ZVSkNHRGdZSUhZ?=
 =?utf-8?B?aG9JdTZ0dE9RbndVTDc2bjIvSFd5eEl0eVlTWnFlWFM5SlFNdFoySVAvUTBs?=
 =?utf-8?B?NXJuNExzdDZJdXl0cVE2a1BsajBOR3luUUZOY25LYi9zMFEvVXkwZGtRdjJL?=
 =?utf-8?B?ekRORlBvWTRBS0ptdEF3eThvKzFrYy9iVXJ1TEo4TUlabVgwY0Z1S3Z3bEJu?=
 =?utf-8?B?SytyR1lNTENqQWxLckpYKzN6VGJxZDdjejlqeEFYTVE5Sk15T20vejBXMDZw?=
 =?utf-8?B?N1BlMHdVLytCSEZvejRuUmQxZmZKQ3QxclBMQmFEOUZNdUpBVjdaYWZBVVU2?=
 =?utf-8?B?QnBrRzhadXNLbEVLdEVHWjNidlEwK2JWSFNsOUhZNFpSTDlWR3ZZZzk5VGhG?=
 =?utf-8?B?MkVKUjBKWEpzLy9iRWJTRk55aHhMMVFveGpiNk05cWhGR3BCcVg1ekNhSVVG?=
 =?utf-8?B?WVFQVXBnaXVpdEhIN21GVzJxTUtIbVlOb1VZeG1FRkpqWDJNQmVaMFY3bjNL?=
 =?utf-8?B?TzlqVXlrdjE5NmNqQmZtaHVLQTNYSkFkZmxlbGlpWUVvYkFjQjBIczFtR3pk?=
 =?utf-8?B?RDZHOXhTNmtFSENiVnFjell3K0pybW9xb3ZUeGkwMno2RjdIc2xTRDdCSTlQ?=
 =?utf-8?B?bkpnaDYrZmJQTkRvMVNDRlN6TTFUSm9VbVNXc2duVmJiR3dBWU1CM0x5WW9n?=
 =?utf-8?B?cWJyRDkwdE5xT3R4R1IydmhXS3dpYUtwUDdWWi82dkJ0VnBpY2RMSjdUOCs4?=
 =?utf-8?B?WCtXNDdaZUlhbnYwTmtQbEtPeUJzQWU2d29UMHBUZFJ2ek03cGVxclRMbGFq?=
 =?utf-8?B?aUtQUVpEWU5za3NzTDBIZms0bUtMSm5ZbWdLbTZlMmtwQ2lHWEdSRGNZdGls?=
 =?utf-8?B?VjBON0RGaGdDWUVOTTJOYTF4MDk5WTc3YU9YRmhNckJSNTZseGQ3RWZWcE1y?=
 =?utf-8?B?UFg3M3QxZUFJU2t6dlA1Yk5FR01kcVBmYS9Vd1VKbFRWOTNPbmxscHhwWVJX?=
 =?utf-8?B?SjhzR1F2Q1BQamg2dkhNaTZyTWVoK1hDUkcvN1Vwc1IzNEN4MjM4Z1M1bWda?=
 =?utf-8?B?WEdqOExuajBnWkEzaGRyM3ByeEFiTHhpV3Y3YWE3TDBnUGRpL3F4KzRsTHhU?=
 =?utf-8?B?dU5MYnplWXpGdmt2cXJSQVQxb2NWSTNVeE1WK1doVEl2bGJEVWFGb2laNEgx?=
 =?utf-8?B?VG5uRC8zc2F3QWJ3UENmeEs1SFZpQ0RyK2RKcnh4clpuN0V3V1NRTEZsMmY2?=
 =?utf-8?B?RkZIKytBa3Vhbml1U1ZxNHMvcWEzUHdFQlJ1eFM2N0R0Z2cwT3NpV2d4WDBR?=
 =?utf-8?B?cWZ5aHdiWVlCKzB0NTZiTmdaaXplaGg0Y1ZMaldtVHUwN1owSXRQeHhtQkk1?=
 =?utf-8?B?Zm51dEtNUDlseXBBOXdSOURITXJmbVQwa3BkZmFrOEk3NnZMMXg5bTVZNXVK?=
 =?utf-8?B?dUhUOVVjbHV6Q3cxUi9CeVVJeU9RPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PRF6zGDrL2eeuJjbh2I7ZBJFZdyvz8EHgr9olimDqeDUtdp3p+HD/N/BnDrTGyTEJ2PsOVi2V64IpDdAG8chl89k0OQd5h6zN4hWwbRKjN6AgsRwJjDHwpN94Kcwqfj4KkwjJT06ce9d4jgRQCmiO0pzqHGSkcOiCpzxfPSBfy3ydiNTzWl23MEAVqbWlKMxGNtLY+7hyDT5zSxzFEwcO/xqYpBg4o5KXPOegzm0p39Wp5XETs9QySdiAAxiIERQGh2Jou5dRzApX7DQlHUlmynr06PAGw0qwQ++C+LhwyJGOJp8eKDrCUd/hBCRdGuKRjTsIkyMnEv2eCCkGAFWzrZWVr4cyQsfFKyvOmDTa5ZyiGdhUg7ert4bDB6ZNGeBwwPqH6fze1DLwFktZ32+IChlsdDb9iPwkRCSAjoQd/9dGfMdV03YQoJ1Af0JIODsVUeGb68KGPPNE36MrPQAyzUepa/z4IK+A/ggMyl9FTT0aVod1MXuWAJtQL/ThPpvTLafLhyuRe28vfMoTj6PRzg72EVdVLqwT0TUUuWp16WUwub+2+6zhKcBKM9a7RAmiBy1l2pxu6nFpw1ls2CaL0S5dlnKDifdulfWhxEl1B0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3405fcf7-206f-4f2c-a018-08dda76f7ab7
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:05:40.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Abo/nGaaXmB/VoNtebhumC47ECPT48jKN/1cyQ9sR0w0jD67ONOBlvsY/e9hLDJYMZWIl5RoC01lmpXWklpTxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506090119
X-Proofpoint-GUID: OAXPup8aCxuydj8qFls1o6kC-e7YOifj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExOSBTYWx0ZWRfX2gnegwaz9gUw e6GvsWXli7pMlGk4Etm5+QRR0PkD1Z12jYa5LSwb+bMBCCHaF1oAdQ7zdfDActCoHuzdh5GqzGC YMm70/xkCTLbs0zvp8MAUNtf7PTbEMV7KPeRxaBC9rsgQq3wscUYB0Ks6AXpbziiZ/r2YnS//RR
 YrvUUdqBfcnvoROgfVYzko4r2LSEllooc41c9UjHWZtZuX8K6sGnYeP26FNEDqmJ/049eSgawpw SjYH+peQ2Lpu7g0jkUx8hEQvHmNGLO7h5LaYQFLbrXH8al5fPYlbSqf81CX4p0gUUtt/n139L2D nmS+hMIvtwapCgNEqMcJgFfR2R/IkvRiMBzYamE7GsTP7WfDaZcfIAnrqr98VS+1ZDyJTDyvLZM
 tTQFnTyw45kDB1yaL6X2SYaqzCzDQdu3QBdEDn321Q0Z2Br3bIJoa3GRt/siBrfO8qP+Rx8n
X-Proofpoint-ORIG-GUID: OAXPup8aCxuydj8qFls1o6kC-e7YOifj
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=68470658 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=fGO4tVQLAAAA:8 a=h-CwbLocAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=07d9gI8wAAAA:8 a=NEAV23lmAAAA:8 a=FOH2dFAWAAAA:8 a=VbBzhYCXBrVgGGyW4MkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=jt8RqQJvuDcA:10 a=qB-ckWXWHtAsDaNONmv4:22 a=e2CUPOnPG4QKp8I52DXD:22

On 6/6/25 21:35, Mark Harmstone wrote:
> On 5/6/25 17:43, Jonah Sabean wrote:
>>>
>> On Thu, Jun 5, 2025 at 1:25 PM Mark Harmstone <maharmstone@fb.com> wrote:
>>>
>>> This patch series adds a disk format change gated behind
>>> CONFIG_BTRFS_EXPERIMENTAL to add a "remap tree", which acts as a layer of
>>> indirection when doing I/O. When doing relocation, rather than fixing up every
>>> tree, we instead record the old and new addresses in the remap tree. This should
>>> hopefully make things more reliable and flexible, as well as enabling some
>>> future changes we'd like to make, such as larger data extents and reducing
>>> write amplification by removing cow-only metadata items.
>>>
>>> The remap tree lives in a new REMAP chunk type. This is because bootstrapping
>>> means that it can't be remapped itself, and has to be relocated by COWing it as
>>> at present. It can't go in the SYSTEM chunk as we are then limited by the chunk
>>> item needing to fit in the superblock.
>>>
>>> For more on the design and rationale, please see my RFC sent last month[1], as
>>> well as Josef Bacik's original design document[2]. The main change from Josef's
>>> design is that I've added remap backrefs, as we need to be able to move a
>>> chunk's existing remaps before remapping it.
>>>
>>> You will also need my patches to btrfs-progs[3] to make
>>> `mkfs.btrfs -O remap-tree` work, as well as allowing `btrfs check` to recognize
>>> the new format.
>>>
>>> Changes since the RFC:
>>>
>>> * I've reduce the REMAP chunk size from the normal 1GB to 32MB, to match the
>>>     SYSTEM chunk. For a filesystem with 4KB sectors and 16KB node size, the worst
>>>     case is that one leaf covers ~1MB of data, and the best case ~250GB. For a
>>>     chunk, that implies a worst case of ~2GB and a best case of ~500TB.
>>>     This isn't a disk-format change, so we can always adjust it if it proves too
>>>     big or small in practice. mkfs creates 8MB chunks, as it does for everything.
>>
>> One thing I'd like to see fixed is the fragmentation of dev_extents on
>> stripped profiles when you have less than 1G left of space, as btrfs
>> will allocate these smaller chunks across a stripped array (ie raid0,
>> 10, 5 or 6), otherwise being able to support larger extents can be
>> made moot because you can end up with chunks being less as small as
>> 1MiB. Depending on if you add/remove devices often and balance often
>> you can end up with a lot of chunks across all disks that can be made
>> smaller, so one hacky way I've got around this is to align partitions
>> and force the system chunk to 1G with this patch:
>> https://urldefense.com/v3/__https://pastebin.com/4PWbgEXV__;!!Bt8RZUm9aw!5woVoadd383IuqBtW6VYdNfYTRc1ugI44XocnoPkA0gEjtp58o3ubI7wW3X5fzx58qYL9cxWUDY$
>>
>> Ideally, I'd like this problem solved, but it seems to me this will
>> just add yet another small chunk in the mix that makes alignment
>> harder in this case. Really makes striping a curse on btrfs.
> 
> This is a different problem to what my patches are trying to solve, but
> yes, I can understand why that would be an issue. Sometimes you'd prefer
> the FS to ENOSPC rather than fragmenting your files.
> 
> I know one of the btrfs developers has been looking into making the
> allocator more intelligent, so I'll make sure he's aware of this.
> 


We’re adding a framework [1] to support more allocation methods, so
let’s see how that evolves.

  [1]
    https://asj.github.io/chunk-alloc-enhancement.html

  
https://lore.kernel.org/linux-btrfs/cover.1747070147.git.anand.jain@oracle.com/


Dynamically calculating chunk sizes in striped RAID can improve free
space usage, especially when device sizes are uneven. The trade-off
is increased chunk fragmentation—that’s the cost of maximizing the
space. I'm unsure about the impact as of now, one option is to
enforce fixed stripe counts and sizes, then  benchmark with test
cases to assess the actual gains. Let me see if I can create a testcase.

Thanks, Anand

>>>
>>> * You can't make new allocations from remapped block groups, so I've changed
>>>     it so there's no free-space entries for these (thanks to Boris Burkov for the
>>>     suggestion).
>>>
>>> * The remap tree doesn't have metadata items in the extent tree (thanks to Josef
>>>     for the suggestion). This was to work around some corruption that delayed refs
>>>     were causing, but it also fits it with our future plans of removing all
>>>     metadata items for COW-only trees, reducing write amplification.
>>>     A knock-on effect of this is that I've had to disable balancing of the remap
>>>     chunk itself. This is because we can no longer walk the extent tree, and will
>>>     have to walk the remap tree instead. When we remove the COW-only metadata
>>>     items, we will also have to do this for the chunk and root trees, as
>>>     bootstrapping means they can't be remapped.
>>>
>>> * btrfs_translate_remap() uses search_commit_root when doing metadata lookups,
>>>     to avoid nested locking issues. This also seems to be a lot quicker (btrfs/187
>>>     went from ~20mins to ~90secs).
>>>
>>> * Unused remapped block groups should now get cleaned up more aggressively
>>>
>>> * Other miscellaneous cleanups and fixes
>>>
>>> Known issues:
>>>
>>> * Relocation still needs to be implemented for the remap tree itself (see above)
>>>
>>> * Some test failures: btrfs/156, btrfs/170, btrfs/226, btrfs/250
>>>
>>> * nodatacow extents aren't safe, as they can race with the relocation thread.
>>>     We either need to follow the btrfs_inc_nocow_writers() approach, which COWs
>>>     the extent, or change it so that it blocks here.
>>>
>>> * When initially marking a block group as remapped, we are walking the free-
>>>     space tree and creating the identity remaps all in one transaction. For the
>>>     worst-case scenario, i.e. a 1GB block group with every other sector allocated
>>>     (131,072 extents), this can result in transaction times of more than 10 mins.
>>>     This needs to be changed to allow this to happen over multiple transactions.
>>>
>>> * All this is disabled for zoned devices for the time being, as I've not been
>>>     able to test it. I'm planning to make it compatible with zoned at a later
>>>     date.
>>>
>>> Thanks
>>>
>>> [1] https://urldefense.com/v3/__https://lwn.net/Articles/1021452/__;!!Bt8RZUm9aw!5woVoadd383IuqBtW6VYdNfYTRc1ugI44XocnoPkA0gEjtp58o3ubI7wW3X5fzx58qYL4uvDpII$
>>> [2] https://github.com/btrfs/btrfs-todo/issues/54
>>> [3] https://github.com/maharmstone/btrfs-progs/tree/remap-tree
>>>
>>> Mark Harmstone (12):
>>>     btrfs: add definitions and constants for remap-tree
>>>     btrfs: add REMAP chunk type
>>>     btrfs: allow remapped chunks to have zero stripes
>>>     btrfs: remove remapped block groups from the free-space tree
>>>     btrfs: don't add metadata items for the remap tree to the extent tree
>>>     btrfs: add extended version of struct block_group_item
>>>     btrfs: allow mounting filesystems with remap-tree incompat flag
>>>     btrfs: redirect I/O for remapped block groups
>>>     btrfs: handle deletions from remapped block group
>>>     btrfs: handle setting up relocation of block group with remap-tree
>>>     btrfs: move existing remaps before relocating block group
>>>     btrfs: replace identity maps with actual remaps when doing relocations
>>>
>>>    fs/btrfs/Kconfig                |    2 +
>>>    fs/btrfs/accessors.h            |   29 +
>>>    fs/btrfs/block-group.c          |  202 +++-
>>>    fs/btrfs/block-group.h          |   15 +-
>>>    fs/btrfs/block-rsv.c            |    8 +
>>>    fs/btrfs/block-rsv.h            |    1 +
>>>    fs/btrfs/discard.c              |   11 +-
>>>    fs/btrfs/disk-io.c              |   91 +-
>>>    fs/btrfs/extent-tree.c          |  152 ++-
>>>    fs/btrfs/free-space-tree.c      |    4 +-
>>>    fs/btrfs/free-space-tree.h      |    5 +-
>>>    fs/btrfs/fs.h                   |    7 +-
>>>    fs/btrfs/relocation.c           | 1897 ++++++++++++++++++++++++++++++-
>>>    fs/btrfs/relocation.h           |    8 +-
>>>    fs/btrfs/space-info.c           |   22 +-
>>>    fs/btrfs/sysfs.c                |    4 +
>>>    fs/btrfs/transaction.c          |    7 +
>>>    fs/btrfs/tree-checker.c         |   37 +-
>>>    fs/btrfs/volumes.c              |  115 +-
>>>    fs/btrfs/volumes.h              |   17 +-
>>>    include/uapi/linux/btrfs.h      |    1 +
>>>    include/uapi/linux/btrfs_tree.h |   29 +-
>>>    22 files changed, 2444 insertions(+), 220 deletions(-)
>>>
>>> --
>>> 2.49.0
>>>
>>>
> 



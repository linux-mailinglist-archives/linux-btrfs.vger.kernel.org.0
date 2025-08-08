Return-Path: <linux-btrfs+bounces-15928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A18B1E599
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 11:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520E87ABD18
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A0026E16E;
	Fri,  8 Aug 2025 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HJZBkeCk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mX8GIgsP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B989226A0EE
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645195; cv=fail; b=Yg1K+csAUyLYWXgQXn/RDS8YjQpDWxExyw3oP2ZlymSfhYPI2PctqwuWR4arRNEBynt35Xuo5J+Tna0x/3uEPdEzOse25UNIk/YliJz3YQPgtvxmGibjkPqSHF/vcudApOyuCjB4f8Q8hxKl1LhT2XPigaVOqBoDgKTPyK/us2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645195; c=relaxed/simple;
	bh=fV4e2R4+Hslvdz7W2b7f5oeHYl6d+29wB9VbdZkCJYg=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aUG1HOLOMNPyrumJdbBPM1Fjilu8RklZSTyqWw/wpW60CsXeWl/KqSS6QlDc19cGQg+nW9+r3pS02kXtfFFKvxz6GN+SyCe1tdb482zigTpbAdcWk5VrfiSNK0pEKaCrCazT+ytjOZixEbFJhkZIVILpDND7XfBRWWZZJbZ3mqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HJZBkeCk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mX8GIgsP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786YaN4027965;
	Fri, 8 Aug 2025 09:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=abb8X5Irx755x2n677KwLphkv8U0lNtwpmc0GyaB6g0=; b=
	HJZBkeCkLLvnY0Mn/DIoiwGjy24u6ZhBV4iKE0JmqCsdiQK1Y/YC0QekCwiOKlmt
	l8xFW+WG/umw7iWywYo42P9U+paAegy3LbDntQR9AyzF34lWDWEaTN1TklxSUka6
	MsKACBfKgrgpMKoU+RTJe6GT8zAYca5HOkaa9q+ogTgfJdfwMF3/YdIEJ5pSGBSz
	Z0u2YzfFRa49WwXwkBHlZX0SOaIGr2EX0gxOga/yph0uPvBKG+VbryRjNzCVSKSN
	/UdzeQoqLYMwosWRFd/OOtBNNt1+puIwK4ds41a1VvN1lu+LlHEXjROZhJ2U1fEY
	DLO4xcWkv6/GPitEHuAv1Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd5yjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 09:26:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5789Lsl4027225;
	Fri, 8 Aug 2025 09:26:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwqgq30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 09:26:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlZw3cOkNMy+SHUJECU2INqzGBSz1Hv3700xB1n/B9ssPI6buooEp8Itfkj7otXihCkd4JDcxuLSsl0Cr0Q+GByqn/U7/ZAgODE5/GW3msvpXQsISjAStkMRDQMhhf/yo9gn5eLzs9+nAZh+40mKkTa27Yt49ac8onCfsN9TuEFk2JcOJ9XVF1RR5ROlTfuYYvaZyF1ZIXq6aiO/pKsw/c39mZpMDf7mmiXE3/cJtIxRIkYygGxoO8NemG8CoIKjYiJNek5qOT0WuxylbMNIsf8e897LIzh97kWKDJ2BtCxKr/ON24Zx/qX5XD/N1GO/tiQxGABtgOM97BB46JJ0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abb8X5Irx755x2n677KwLphkv8U0lNtwpmc0GyaB6g0=;
 b=gm26CH+CZg6Fq8grL0nHAf9SiDU7+nlN1OR/Bfy5wdOpugKcT3KOsJSxv1s/voqOgcp8/TstACu0jhKk2J7F6jGMftyifvU2P7iY4Z7PE/M6WvGCR9fmZX5MPMT+9QRBJm7UX3lxgx7/pKwobl+Trgaw3qHFZVv14H3MCDe4bqf1BjDLdME0OQMdvHuf7gcSADqucgJ9t1r8+bQBwqnRwHxf4mbf6la6NPHb3rwQeQYbgl4Op6Gv4aInuLzrpuo8kQRKGueV9VcJUuuQlo4gKW2OBSyaaP0+k8WAa4ALygw9r9B6pwg1yn9gIEUQ2lnOKXdcRtG9ZREsgOmj32PTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abb8X5Irx755x2n677KwLphkv8U0lNtwpmc0GyaB6g0=;
 b=mX8GIgsPh3BG1+t5rBe0Nh9MOkzx8eVxlWiVYMJeBaa+picEPcvac0Z2zxYlu1ZHQRbZr4gF2g8/WbRvgJ2iXoltQjWJYU05TT/jTKgZbu2U54LDKcY/nAJSQqcSB0e8ngXwEdkZ33SuNlgQBVQiCSloWipy5Q19gVX05kbiSeE=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DS7PR10MB4878.namprd10.prod.outlook.com (2603:10b6:5:3a8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.18; Fri, 8 Aug 2025 09:26:28 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 09:26:28 +0000
Message-ID: <531a7c76-0b6e-454a-bb7a-3fc3ee0d95ee@oracle.com>
Date: Fri, 8 Aug 2025 14:56:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] btrfs-progs: add error handling for
 device_get_partition_size()
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1754455239.git.wqu@suse.com>
 <aaefe04f784bc601f355d13b3b0ecbde1aa44dee.1754455239.git.wqu@suse.com>
 <4c815239-7b65-4460-a27f-4b48b7244c71@oracle.com>
In-Reply-To: <4c815239-7b65-4460-a27f-4b48b7244c71@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::7) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DS7PR10MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 4330272e-e6eb-4b68-cb23-08ddd65da717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUxpdG96K1U0WHRLVTB0U3F5dmtQd0dvZitGVjhheTgwY1dEajBobExyZFJq?=
 =?utf-8?B?WG03U2VtN21pam0yQjN3VFE5Zis4aTdxQWRnWG40WE5maW9nL3IxUENJR09W?=
 =?utf-8?B?WmlHaTQ4THVZUVppcHZscUY3NEJHeFdTcWdObTF6SWpETnlOZ3RaZXF5QnQ3?=
 =?utf-8?B?QzJzbW9udEtyemJZbzVDTjFUc1cvOEhVakc2cHcxVU1IMnBRVEJTMzdXTzZq?=
 =?utf-8?B?YVRFQ1MxZFdCczF2Nm1ZeEFOek9KWGZwc3M1Y2I3MmZuVkFOLzV2aGVYWkxX?=
 =?utf-8?B?RFB0ejl4QzNlREZxaUJpaVZLUEpIUzhBbnFJTGFBNGZYTFZ4TitpbUp3Nnoz?=
 =?utf-8?B?eWE0Zk1RVk1Oa3FVckhBVC96N1FGcG1ZTlVSK243RlZxNE5vTU5yaUJEaGRD?=
 =?utf-8?B?MTBKemt3aVZKTnBHdzV6c1ZKM3R0TVNRSk5EK3E2US9QR2RGOUF3anlpMWEx?=
 =?utf-8?B?V0NucnBGcmV1ZndyYVFrWEFnaWJLZ0RPWThvTysvUk5jaDd6MUo0T29GWDdw?=
 =?utf-8?B?cmM2RVJocWV6UHpwODBmaG5EMlh6K1NsQ2N3SFRvYjE4R3grUWhvRWZ3eFRM?=
 =?utf-8?B?RG5ra2dDQWJqTHc5bXZKbzF0K0dJVXVaMUxoYXZFdDRnMFhPSnFwSk8yL1pG?=
 =?utf-8?B?bGVFZkNLOW8rNWFWVjRCbEFsVlR0RlZ0SG94OCtKamxtL2ZSVFBVQmxNUklZ?=
 =?utf-8?B?Sld0Rnd3NjNnQ2s1aHA2Z29YaTMxK0QweU4xSkdVN1lGQzdDMSttZDJaTzJP?=
 =?utf-8?B?dlhyRDQ0RDZaN0haTnB5QnFDempLak93VUZlMXBSdGt5UnNPL0dzSzcwaXRR?=
 =?utf-8?B?dTNiZ3lWVDM3ci9oRnJpdmIxbXZZc1hNcy9aUjZ5dVB1elNGTnluSWFTZ2hN?=
 =?utf-8?B?YmxHUDU0WlI5TTZaUlhhaGszcFowOTNqdnlHcjhSTGovdGNWWGRoNVN4Y0Nh?=
 =?utf-8?B?SEhlZWNGa2t1QmtZU3RRclUwM1ZFUVpQektVWDh5bGwxWmJBYXIwTjlsYWw0?=
 =?utf-8?B?Z0lJRk5pMW1Ld21pNC9IV2gwWGNsNXZiN0JFeG01TU5qRTFpbmlSSjlYSWJK?=
 =?utf-8?B?WExlbGczSVNxRzI1U05yQnpYK3pZeDF1alRGSktHb0dhQWpDYW1YOCs2ZUhu?=
 =?utf-8?B?dWJVVGN3T0FLK1FvbWhxNUdFaW0xNkJ2THMybFhWdXNSSUpjNGxpNmVndTV5?=
 =?utf-8?B?cTJWU0hVM2thR3M0R2hOME5MTlVWRXNQYWU5bDJKa1hmVXAvV09HTkE2QVEv?=
 =?utf-8?B?eE9wb21KTzhOWmIrbXhlRm9TRkRYR1BTSDRyd2hjUkJPSnFSY283TWNrNU91?=
 =?utf-8?B?WXF0a01taFFCVUU2ZlI4WENhUUtLM3BibVhHbG1KZWczVVl4V1NoUmFjSzkv?=
 =?utf-8?B?WEdjb2NUUUpRWjBuVHNhQklvQkhUQXd1WU51N2Y0VFNsUmR5K25vMEV3TGZl?=
 =?utf-8?B?RVM0YWovRUo0clMwQ0NuaVc4d1lZNWNQMHpLTmI5MTdwa1YrQjhDMFdnR1p4?=
 =?utf-8?B?THVqUUZvK3V3Q1F3SjJaaldLQVZYZUIza05pV2ZSU0pWMlFoU24wbC9DSHpR?=
 =?utf-8?B?U2N2UWpHZjgrdXYza0ZBem5YTmdraFZSMy8xbUVrbUcvUFEyMzNyZVUrV2Jw?=
 =?utf-8?B?T0ZYc0tCaGQzZXl0SVlKaDZQZklKSkh1ZHJmd2EyY0RRdG9zdHFEaHVoRjZT?=
 =?utf-8?B?NzYvdFp0NlFyRGlQd2VmdWIwTXBBR2pROEFicklMZ2kyOW5XdU5yV05qV0xt?=
 =?utf-8?B?ZXcyajN3L1FqbTEvUVI0aXZjQ2I3MXM0STlBZTdsZ2xMZ0tDaXlBamI0UzM4?=
 =?utf-8?B?aXdXMkh1Q09RTkR2Qks4dEdXSVlpSUdzbE1ucDloNnJtNEpPaGdILys4M1Mr?=
 =?utf-8?B?STJORnU1anhVWXJPTkdtWTlMVDJYdUJWOEZyaHJFNXpTOTd6SDJpeHhkKzh1?=
 =?utf-8?Q?Yh5FMOc5MRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2E1MlJjTWNDSUJpd0tyWjlicUZheldZVGFyYUd0NDhOckdJeUp3Yk12YW9k?=
 =?utf-8?B?dlA2SGh6Vm1tSGgzZnllNWZIN1ZreS9ZdmRHaDFva3BXU0g1TlFVRkJ5L3ZU?=
 =?utf-8?B?RU9RWk9xYk1HUHJNL2ZhRnp6d0RKeERjZDh2RzlIOHpmSmFBeVdMY084S254?=
 =?utf-8?B?Ly85d2hqOVlKTnY3aFB4bUFYVUxvWFVkSC9JWHlzK1lOcUFpd0gyaDFNenpD?=
 =?utf-8?B?QVhLb015QVpreFg1MEZyVU9ibnVqckpzQjJSaFJFWDhsME1GWDRDUXppZkxV?=
 =?utf-8?B?SEpaWjZPYTVrNi9QZFR6Mml6MGE4SGo1eUQ5WmFJWDI1emUzdTRBakZYajlD?=
 =?utf-8?B?Z3FPaGQwVDgyamlUWitrZkxYSnF6QmluUnpuRk9nK3diR1cyRzM2eitRcktK?=
 =?utf-8?B?Z21rNkJDTGRDZmNCcTJ3REZGVWJSMnMwV3lDU1JPZHhsa0VDWjBjRDJXZ3VC?=
 =?utf-8?B?L3p6ZEdXVHE3WmZFTjZnSXZRMHNVOEVXZWlRUTMybUNCWnlPUk1kRndQS2Fv?=
 =?utf-8?B?dmxhSnlTQ3RDaTkrNmlKUGxaeGlPcFBlSExpa1JRS3R4bjlkUE9HMDNNdVFx?=
 =?utf-8?B?dHpvbTZ3TGwveUhnUVFmREtaV0NGcGE3ZXlINThHdFRRcCtlK2d6Mng4a0xq?=
 =?utf-8?B?UnRYU0tLQTlLSi9ORmEwSXZWZG1jYzNwNGZ6emUxR3dDckl0cTloeThod1R1?=
 =?utf-8?B?QmV2U0hrY09qTVhVQTlQbVdKdmViajFIQkY2WkY0NEZ4Wnh4UG5GaGhtUGFt?=
 =?utf-8?B?Q0JnOVhTcE8vZ0U3QmFWSnE3YzN5Y3ZwZFFrS2NSVmlvYzZvT084bVhuNVZ4?=
 =?utf-8?B?UlJOMEJ2R3dyRlVSS0FjMGd0T2UwVWdPT1FzZ2tzN3NIYkUrc1BmUTFRWTM5?=
 =?utf-8?B?NHE5VHd4a2JGWlJDK1Z3RG1hYWkyNUkwMTY4a1JZWFhEOGxqOGVadFRaNDYw?=
 =?utf-8?B?NmRGeW4rWVcxMGpweGVrVnBaQTVUeXlYdTNlaWFpNGpSWk5oRjQ4ZG5FV3Mr?=
 =?utf-8?B?ZkJoVk5LWS9LMTh1Z1ZVWWR2QkVXRGRwS084SFloRzUyTHd2UjJxcHhRV1JW?=
 =?utf-8?B?aElOQ3RwZXY1WDc3KzlNaytKUUR4WDFrODdDK2hHM3RXSXhVS1lvWHlha3BY?=
 =?utf-8?B?Q2pHM3I5MXJkOTRPY0s5ZVlEemdkd2ZCNmVvbnAvNUE3TnZWVk5KSm1TMVhm?=
 =?utf-8?B?T2J3ZkZzeEIyekNVc0JzT1BEWUVaWkNjcnBoWmpFdkszQzNFT2swTmJnZGU1?=
 =?utf-8?B?UmQxaUNRbVk4c3VTL3NrNXNYTU1zSDhRWDV0UUcrRUxxSy9obm9KSGVSaWhw?=
 =?utf-8?B?bzRkRzdEMU5BSndMdmtVNjhmOFE2REdGdEhhcTU1ZGFrcDBpM2k1S2xYOHA3?=
 =?utf-8?B?eGNUS0E2cHV5NnVsQ3lrSzg0YmFtNGJKN2N0cG1SQWdVSXJWMnRjMjlvelVn?=
 =?utf-8?B?Uy93S1lrVE9VeWR5aVJBQ2V4dWVhdklpLzBkNzlua204aUlSKzdyVmpuTlNN?=
 =?utf-8?B?Tmh6c1IyTTJQZnFYL2JkRFFDZnJTVy9oVi9KcC9ycWM5YjBzMmp6NVdwbER6?=
 =?utf-8?B?WTVzS1N3WU1xU2FQaUtnZFJjOGpsRWkvN2l6N0ZTZFRKNEt6YzVvemM3Z0li?=
 =?utf-8?B?QWozUGthaGt2R1F4YTJ2b2VId09SdGhIbFRjS2t1N0MyRmlzdVM4b1RDSC9y?=
 =?utf-8?B?Q05DYkUwemUyY3hCcmY2MWNoc2Rsc0ZFMFF1b01YZGdjSFRBd2ZBbXVPbDJa?=
 =?utf-8?B?ekZGUEc0OHo3TE9CMFhQbWJYRm5YWmJzenlDVXNLK1dXZ3BWOWQvTW9WT3VG?=
 =?utf-8?B?QzM0NjJ1WENqZUZJT0ttOWo3ZHJFQ1FjYlE4aytPanFoYUhKbWNXVW14V2lB?=
 =?utf-8?B?S0dIN3lNcGVJUk9xSHFwMm1FbGswNlBXTHhKWjFpRG9OMVBWUU5kTmdvZy9l?=
 =?utf-8?B?bUxFT0hlb1pEM05QSy9GdmdGSjhIVHNvSXp1dWxuM3VTZXlSMXNSdmpqYTd6?=
 =?utf-8?B?dXdiTzNzcE0wc0tCOGM2QmY3dWJQekMxZ3M4UXp3SldhcWtENmJtdXRoT3NC?=
 =?utf-8?B?NEwzRFdOdmxGREtzVGpyWGFpTU5rUi9lV0lIalc4WXB2S3JxQTNzK1NRd1o4?=
 =?utf-8?B?WUtEK1paSmdQRVBmNWp1Q0Qva3dlSzdMODNQZVJNOERoVmJ5R0cvamlxS1hl?=
 =?utf-8?Q?sVUA0fprhdCbFrgACw7oADKyIdvXGmFgfeG8AaI2niYl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wf27aVknexTBHIo883n4fywzWG+51V2V1MX/JZwCeNQb1zQCpRO8VfJgboGOGHRZqINW9CbYr1jDgaufLP7Vp9qmwWqhBzvW5CLmufyyj7gZFdfszkilvF+LhSRl+sZerUuc/qr3DJ2wVit8y+7Vnp8yKkZna820+3WQ4fMmIhcxX2d70+T9rd6tabkWGIwFTXoDJpF/NEn7LEbtcjO90qBK6LGpFD2eFs2ZuSHWHxWLrT5yuzLbfRZWRw+Wp2KKG96QtqaMROqct/LopA5a2iLSZqfD/AiSH4Dd5A14cTGuv0/e/bJTQ3PfQXcvnyxq78mEiBDwgHUnf9WTM1P/SCaBGfZjVQ05lhtYBmwCtP4slA3lhByvpC7TMDkx/LyzpAgF4873PNLpU+cBYwGnJIlS1+x1l42eXvMG9t+bpKctsj4irxW2YAawQDeYqHbBM8uzvAOyWZ865e9MovJ8bWaKEuJVi+cunuiK7FI74Mr0kJISgt0rHZl8QtPuYrV2EumVZWWrjLheYNiVA4/zYaaBO4LXdGTI/2XXxfOiRSKABvjrAtikSNXrwW+OeRd3mfNDHRlpVdTFNpvl7Q3epgoDr23IpptM+0Lnnaien1Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4330272e-e6eb-4b68-cb23-08ddd65da717
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:26:28.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MeVa3gaALmKbjMYqn+MSi+xlUr3HTN8tlW17d4ut3xGMdmVR1m5oGbQ3otWMxzS2rs6hfjEHhFl7jrL9D3wGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4878
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080077
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=6895c2c7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=7PIwWI1VsPrUxt9_mj0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3f1o2PW4D5mj7YszmV-COvdP-QBHapoh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA3NiBTYWx0ZWRfXyO0SK96id90S
 Cw5Iqlzpfdi4sunvUz1Mg+FpEi+uUy5pHhR2e5FAlvy/4eyR9AgtpSvMfucBFgBsQ7r5dClE7Ng
 nvgjmrOR2CVExLhI6cgnYXBXylGYYsjlqk1Y3AbXbFTnYY0TzQ+9V9cGOLynBNHRe7EyoSDwYaV
 TVrHwgpQNyCQ0uIaAB2Mihl835YI7HS28A8L05z+rmuaJAYdj+3os1ui514fy7Sud+Agz2b3YYW
 jWZrUuQmLl0MMw2v1bIm1Um90pAou/l+fc2R+VreBSjxFUbT7Ch8JZQMa/IL/7+lKr07J5pf0YZ
 OqbdVvJe5m2fzsbs67CZE4sWdwP8TNsYejo2hANAUFoauMhwR0y0KhIfiIVVkBTONieeHB1qFkE
 UW3niM6zEURjwgXCE3/tKvXGa6eBVC/73pYDbJzdJ7P9zbn4pN8O9zqIRhUttWZ80jbPrPdF
X-Proofpoint-GUID: 3f1o2PW4D5mj7YszmV-COvdP-QBHapoh

On 8/8/25 15:23, Anand Jain wrote:
> On 6/8/25 12:48, Qu Wenruo wrote:
>> The function device_get_partition_size() has all kinds of error paths,
>> but it has no way to return error other than returning 0.
>>
>> This is not helpful for end users to know what's going wrong.
>>
> 
> 
>> Change that function to return s64, as even the kernel won't return a
>> block size larger than LLONG_MAX.
>> Thus we're safe to use the minus range of s64 to indicate an error.
> 

> Returning s64 is almost unused in btrfs-progs; Either PTR_ERR() or
> int return + arg parameter * u64; Rest looks good.

correction: almost unused -> mostly avoided


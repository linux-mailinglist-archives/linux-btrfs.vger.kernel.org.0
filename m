Return-Path: <linux-btrfs+bounces-2698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6F4862161
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 01:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683861F247CC
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 00:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A971870;
	Sat, 24 Feb 2024 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iF9ip3sy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HzyaOKXZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D5138A;
	Sat, 24 Feb 2024 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736034; cv=fail; b=jug3G53Zihehh5YVs+b/0vONjFDGrDBBUxTh9yTf3fMF+vdGO9edNF9KYWRIZvPhu36NPplwS10llsGExXWf8nMCF+DucuE0rD2OE8EHK/qjup70Y+MvmhaZWD9cswX14vZ5IkVGtwaHPNvbuaBFYfgT7eNja9eDLMgrC9kWZzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736034; c=relaxed/simple;
	bh=3dJ+XCC/JVsHLk3b9SM+TOen+/7MeIm/OeUqqnpR0JI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qllma1M3KVuxAmScuaOSzTHYOiTM68OVCDTfGVuTSGDDnOKaGBLy1iBjMxtAM0gJ5ITNjWeeiPSu5bbzlmi9ix0SjU74tdF52JrOjIDaiPZT42tCcreLn83Ly3mUE6F3Zi/sF+aznbu3NK0wqtKokkBrTWAtGDi5OAvpaBdKOSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iF9ip3sy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HzyaOKXZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NLjsUk006926;
	Sat, 24 Feb 2024 00:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iMdMBlV7N+mKVRXNNCcZNAz4eGH5kI6eC2Dppu6jSPc=;
 b=iF9ip3syanUC60EP4DWF/rxKGTIeUsY1yF6t57Hlc6xiWtjjTOX3F8GdK96RTtH5a/dR
 A+nVAihJskfNQn88fu2aWdT0ryY52acUbRaiK7Sg/uPd843N/z4wPhZETq1mopWV+pWJ
 29Oztt+G/0We9fpN1H55ltiPVFz677Rbcrakc3jjMQwMbT8+C6vmTfnzP383UFsTyJr6
 /dkdUH1bj8nVhalX9trzabwpf4pmWznGf+cDf4YBtZo+6oK9ziedtG1hauKhRU+g9HLg
 MFRPCZJO4dXHGE/uFGgVtndH3C1L/tXp8idao3gCt0BpGEA10ZayDwnQiSHYVHatBRO4 sA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqch4mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 00:53:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NNhJa2016966;
	Sat, 24 Feb 2024 00:53:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8ddx2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 00:53:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apWF8+95WUpW4Gp0sko0WAHSTP1nfTVM74h/9vNp276Xyp/8mz53+hAa0khmKs1K0HsyvYLlS80KzUIjpY09f7dhrYrlWvMrjHctg2p74chxm1yfmYXyPs50OAynJwxlBaP8sNds4dYX1YniLYVaQDl0XhsyKwU+nqKnN4sFKOVeg1xp7JEiP/nVRqOBjci85wlYs4oTPDsgvS/1Dx6KoaRDPy/2a0D8y4FeLtRzmkdZEIobtwygSyJGbllrp9+iPhiMx6OavVhGHT7IOMtwMiUIUlmIIa0TdV4lYchS/qjoxgaBSp6/IGehcmWiUoMkLaxVu5165MNQOlsc7g+xTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMdMBlV7N+mKVRXNNCcZNAz4eGH5kI6eC2Dppu6jSPc=;
 b=VTBVwAmWvr4HCLjOE3udmHguOgJUaaUhpTBT1Hn34HoWRft5ByVwSDBjIw8F7g7ng40Da8nTbYdPxaBzySYEkg7vLE1A0SywpDe/40gmebkwwyi+e4rIpDjqlI70Bh0bREteCjFB3Dxz7piMeu0Lhfv9MR9DOu3ZlKEbD7tN6XJs4js9q8QeEsN40U3NUBDTaWOKURJpMBJEbZy9tghz7tLiqeqyI6nVWL3B/DG01IKduKW0mG9Q9Yfw73VpBVjQQZZYGcTpN0+jG4yaEF2QjSTptv6Qi1FtcUf+L2EWFL+gbq2VdxYgAx0baoXDxc8B4+XsuzbR7WhG2GbAoKbhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMdMBlV7N+mKVRXNNCcZNAz4eGH5kI6eC2Dppu6jSPc=;
 b=HzyaOKXZHHyAUGHSsEFYGG5k1r3Wp6IGBh7FyM6YKtuIOLAcg7jOi4SsbQi8p52appAkxiKNsIBu+y1mlDDF9K1x1l3jPu/FWLWJP9Or8jFuOymOdwuBF4hcKFmf9hgsra9mD7xzSlLtkwpb1GCE/LGqJvDRIba9rM9gBi5s+OA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6553.namprd10.prod.outlook.com (2603:10b6:510:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Sat, 24 Feb
 2024 00:53:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 00:53:41 +0000
Message-ID: <dfcf8ae7-0194-496f-9628-abfa51da72cb@oracle.com>
Date: Sat, 24 Feb 2024 06:23:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] btrfs: validate send-receive operation with
 tempfsid.
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
References: <cover.1708362842.git.anand.jain@oracle.com>
 <7d0b939fdcb0052c184e18226fcbbc4454508243.1708362842.git.anand.jain@oracle.com>
 <CAL3q7H6JwgSbcnN4fs8poyOj_z8P9HxqBEUUduiuLqUdnWK_0w@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H6JwgSbcnN4fs8poyOj_z8P9HxqBEUUduiuLqUdnWK_0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af0e118-3f02-415b-4c6c-08dc34d30b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	znpac32rdaNDPnhwoLdird2hhTtycIVEW34/MXjQseSWtpmVzvUAqwZEtLHCKE2DGtpgIwpmMOaqA4yN6u32k5+xDd+3K0+OpE549JAjAw2GT/YjHF6EIwMlvdWzNNQS5cB5QcedkXXjhyu6F438Vs7Sf5wlWB7DvZJx2f0qZ2M2qwbFKuJ47xcwa1osiwpKOPfj1ZiLBnu1I82I6m2yKxreAM6vQSJi0WPmIvqhy16oPFO95LtYjcLz1k01hsMOLalIEEbaDfg+1TwOPRMSkqH8T5s+d+Sa4d2LHURnDQWHyOr+2+icMcdBHzam/NCwPGe1G4EK9CPKxjCroPawcvol5OGGX2ItyfbpcZrzkB6n/IzSCfneydF1/8DwgiQHfsePggclhVTum8Xyow7B5t/e3md5nX5LX9UJ7NRYKHUnfCb1rh4O2hX6kkoDAliEo3PjzPA0YDZfYZtOw68p7titV5blowXU+rqGJoTOcO6sWtxPrnS7lYEUWRODKNO5GKP4yjJMG93bS9AfUBx5tuOw0+0zgKwzr6DDIVtvyng=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEM3NWlXQnlTZ2c2Q25ZcVNHc1RyaTNLbktoMy8xSnBSOHl6T0ZPVDhDK0dH?=
 =?utf-8?B?ZnIzWDVDUXJFZmg1THJpWEZTeXJNdkhYVGZ1WGVJZTNEVWhRUVU2Nkd2VFZM?=
 =?utf-8?B?M1pod3dYMU5UNjVhMldnSUdUNU1pMmJpd0VhMFJnTGpNYy83Y1pTNkZrNCtN?=
 =?utf-8?B?UHROUDlwT0NUVm9CcnJZcVdOUk8zWTB4UGVjanZtUHAwb080U0l5eEY3YlRp?=
 =?utf-8?B?bjBEb0dXMFdCNXNmM3YzZzc3NjU4UlhLMDYrNUdIT1c3ODk0VHlXUHlGSWdK?=
 =?utf-8?B?cDhvWHIxa0NRSWVIcVFEOHh3ODhERW5vQllvQTV1UGc3QU1sUFhIZHBXaENz?=
 =?utf-8?B?QllDWWRGNDFiUUNkeE53dXIrQWxxV1lBOHV2alVlUjU1dEZqK213RTNhR21a?=
 =?utf-8?B?RytCSk5PcUtwMndxNXZ3K1V4MGVya0J0VVdVVzRTelYyZjFCaHoyWDZSNUZa?=
 =?utf-8?B?YWxrYzBRdFBuTjkvbGlITlc2ZmYyM0tmL2w5VktsWlN6enVYV2FvWXQzNHcr?=
 =?utf-8?B?cUhCdk5XMTRRdXM2UCtKb1krME0zbVFlanNUWTNWaVJuR3JqY0toOGdEZUJJ?=
 =?utf-8?B?NFgxc2pTeUdVQ043ZlRrQ09nUmI2TitpZE9XejBGMnUraTkraVV5NHUzN0g4?=
 =?utf-8?B?aERNeVJjWTdxZlprcUtPY0paREJqTG5ObmxyUkxwYTdPamljRGVrZXlGcytx?=
 =?utf-8?B?Qm5vUFJqblhHUkExZ2MrWEZ4TVVQVDczdERVSE03T2l0NjF6R3cwZ3JBKzVh?=
 =?utf-8?B?STE5YVU2cUYxU2FxYitTWVYwRW1lTXRtajZEYkhuTWYvdDI1ZWR3VEo4WlpL?=
 =?utf-8?B?bDVVYXdlUUJiWkVjM285MFk3eWY0UytLWW9oVjB1ajlMR2JnNXI2QmlFc29I?=
 =?utf-8?B?QUN6Y3lzaWdHM3pFaFdCOTR4ejFFU0swczJ1MjEzMUdKV1VBOVZNcm81M21j?=
 =?utf-8?B?WExEbDZ4bUNLUHNkMWpQc0hUdmlYRTVzYzBMNmJLdFNpRmliejZac2xldEZJ?=
 =?utf-8?B?TG9yalByNGc5NTZqMFVtam9ZR0FGTmdXMW1GTlQwdlVJTTdIU1pubm5OWXFX?=
 =?utf-8?B?V3dJVU9KSDRBZnNXallFaXF2OEtHS3NUM0xpdGpBeXM4THUvVUpDOUNJUGhm?=
 =?utf-8?B?a3lkRlF3b1JCYzFSdUhOdXU0bjJmZ0h2UVptdlU4eGRyYVAxTFY4dFU1aTR1?=
 =?utf-8?B?SkVpSFpyb0VBYUpYYnoxQTVLM2YyOWV3Y2MyQzIwZS9RWTduRWpzaXlyWnNE?=
 =?utf-8?B?MVNYb0ZzcFpERzR5ajUrTjNvY210OUVrNnhUbFV6M2EyVXcvdnhDbnZ5enNP?=
 =?utf-8?B?NlNiUCtvTXlySnM5R2VqellMZGluNjFSMzF0aFFoWFFINGUyK3FEWXA1WXQ3?=
 =?utf-8?B?YlA4aUdIcisySyt0V0pTR2xxSnh1WDBrQWpiNU1ybG40REppS2hqb084RHcw?=
 =?utf-8?B?Z3dSNlBEZXRsMHdCMlAzU1VvZWlQdWNQcW4wRzB5L2VNYWZKckYyVDlwcjZY?=
 =?utf-8?B?dGNhdVIrZU5mbm81NjcwVytzM2ZkZmVUYURoOC8xeUw1a3JYR2NzTlFVK0RM?=
 =?utf-8?B?UTY3R1VZbUNsRlN5cmlQOW5jViszZUlyWC81QlN1SXVQMFlmUXVLQzJQNjhv?=
 =?utf-8?B?UHEvMjdOT1NybXVoZmlDSk5qb3RURFIwRzdxbU92SXhMZlhBbnZ0K3ovbjhQ?=
 =?utf-8?B?bHlsY05JY2crcGVCeXdzL2VEc2tvbnEzRXlGbW1vZkZuYURqVEFzbmxIb081?=
 =?utf-8?B?K2trQmF2RkR3b0c0NUpYbXppOGFjQ2VJV3FkUjFxcE1RNUtDcjNKMzZ5Q1JF?=
 =?utf-8?B?RXdRQ2s4OHNKcUlsOFEya1ZZMDZTKzVuY21CdkhKTmhRbi9VNkdsOFFDdThL?=
 =?utf-8?B?YUtMT2V6Z3VpMXVMMWJIMFlXK2FTUnY3Tld6NUgvVE9wQWhuenBhbE5VK0lj?=
 =?utf-8?B?eU5qSDlsRyswT3FRNmtDdUZYeTdsbGVzN2VZcklYRFFPQXluYVZoOUtNUWJ1?=
 =?utf-8?B?bHQyMVBKQ3VnaGZwaFpCQU03S3gwd1RQRkV2QmlwVmhTM0RNVCtEdmtReFZ3?=
 =?utf-8?B?WlJPR1k5Rld6YTdRQnpzdEhDUE1reTlWTDV1SUpQR1BGNWVScm9XakI2VzY2?=
 =?utf-8?Q?sB0gogZtaZL1zCJzub/QsM9eW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dIO549qje/pw6+38JVN3bOJ+o6JjLP6jz3I8TVua+c9CiuzWgAKt+EQVdym4PmaQsVS9ya0aJUvxdhhjUD/Octvp+7XaTfJiphEpalym1YilNuo5F6nSVlpWlCmJoRDrs/UrCJ0npDEn86a4ZMR4JNBfod/va9u+rqHXsoQLTGzWq8t4ybc9AJt8fkowmzuGt2+pSLD1/87nQ0eTRQxOm3lqtcENtymUUrwaGIktdFESbQjO57W5DSuZqB+r3JwUEEJGo7ORr3TUXQjvN/vp4HpW6BAUmKm3zP/dsb8PjEBjnrjVb5dVG3n1l3LwTzFblFqzZmBVZ6guOCLgGS/ND5nPGfhmYSkTI5GWBEUGdmPlwORvU0lC89wiv4/xUygSN5Ma2xUgdsmSBlVpx7wwl258xI7BqDLxL5guJqK7GD9Emz3spMt9jtQ+LHBi1CZxKjNZmbctBs1r0WY0w5TdEWVrdJQtGfdu4Iq4z5UhlyKENKJQuWMCNh+sABOxZumKI3S/s49BYT3zwz6ys3Pb6yjcmIGS30QUYsfBHu1ov5nE5Sqzh8KphcNri/GIyOY5oEdC8JM+qRam/j1oFYJnPMN+tCIoL+kd4tICRD7ulbw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af0e118-3f02-415b-4c6c-08dc34d30b53
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 00:53:41.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OjJtbr9+i7NP238AblXOZAXDeJo2Q167OGvA9BzERONyyzWC3FAI95C/ShT6Wi9movlBn0UWJLCegb1sCZxlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_08,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402240005
X-Proofpoint-GUID: cnD72nfNy9Onw1RrIUhzyNz4UDmWw0Ti
X-Proofpoint-ORIG-GUID: cnD72nfNy9Onw1RrIUhzyNz4UDmWw0Ti

On 2/20/24 22:27, Filipe Manana wrote:
> On Mon, Feb 19, 2024 at 7:50 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Given concurrent mounting of both the original and its clone device on
>> the same system, this test confirms the integrity of send and receive
>> operations in the presence of active tempfsid.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>>   Organize changes to its right patch.
>>   Fix _fail erorr message.
>>   Declare local variables for fsid and uuid.
>>
>>   tests/btrfs/314     | 81 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/314.out | 23 +++++++++++++
>>   2 files changed, 104 insertions(+)
>>   create mode 100755 tests/btrfs/314
>>   create mode 100644 tests/btrfs/314.out
>>
>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
>> new file mode 100755
>> index 000000000000..59c6359a2ad8
>> --- /dev/null
>> +++ b/tests/btrfs/314
>> @@ -0,0 +1,81 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
>> +#
>> +# FS QA Test 314
>> +#
>> +# Send and receive functionality test between a normal and
>> +# tempfsid filesystem.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick snapshot send tempfsid
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       $UMOUNT_PROG $tempfsid_mnt 2>/dev/null
>> +       rm -r -f $tmp.*
>> +       rm -r -f $sendfile
>> +       rm -r -f $tempfsid_mnt
>> +}
>> +
>> +. ./common/filter.btrfs
>> +
>> +_supported_fs btrfs
>> +_require_btrfs_sysfs_fsid
>> +_require_scratch_dev_pool 2
>> +_require_btrfs_fs_feature temp_fsid
>> +_require_btrfs_command inspect-internal dump-super
>> +_require_btrfs_mkfs_uuid_option
> 
> So same as before, these last 2 _require_* are because of the
> mkfs_clone() function,
> defined at common/btrfs, so they should be in the function and not
> spread over every test case that calls it.
> 

Yep. Fixed it.

Thanks, Anand

> Thanks.
> 
>> +
>> +_scratch_dev_pool_get 2
>> +
>> +# mount point for the tempfsid device
>> +tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
>> +sendfile=$TEST_DIR/$seq/replicate.send
>> +
>> +send_receive_tempfsid()
>> +{
>> +       local src=$1
>> +       local dst=$2
>> +
>> +       # Use first 2 devices from the SCRATCH_DEV_POOL
>> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>> +       _scratch_mount
>> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>> +
>> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>> +       $BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
>> +                                               _filter_testdir_and_scratch
>> +
>> +       echo Send ${src} | _filter_testdir_and_scratch
>> +       $BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
>> +                                               _filter_testdir_and_scratch
>> +       echo Receive ${dst} | _filter_testdir_and_scratch
>> +       $BTRFS_UTIL_PROG receive -f ${sendfile} ${dst} | \
>> +                                               _filter_testdir_and_scratch
>> +       echo -e -n "Send:\t"
>> +       md5sum  ${src}/foo | _filter_testdir_and_scratch
>> +       echo -e -n "Recv:\t"
>> +       md5sum ${dst}/snap1/foo | _filter_testdir_and_scratch
>> +}
>> +
>> +mkdir -p $tempfsid_mnt
>> +
>> +echo -e \\nFrom non-tempfsid ${SCRATCH_MNT} to tempfsid ${tempfsid_mnt} | \
>> +                                               _filter_testdir_and_scratch
>> +send_receive_tempfsid $SCRATCH_MNT $tempfsid_mnt
>> +
>> +_scratch_unmount
>> +_cleanup
>> +mkdir -p $tempfsid_mnt
>> +
>> +echo -e \\nFrom tempfsid ${tempfsid_mnt} to non-tempfsid ${SCRATCH_MNT} | \
>> +                                               _filter_testdir_and_scratch
>> +send_receive_tempfsid $tempfsid_mnt $SCRATCH_MNT
>> +
>> +_scratch_dev_pool_put
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
>> new file mode 100644
>> index 000000000000..21963899c2b2
>> --- /dev/null
>> +++ b/tests/btrfs/314.out
>> @@ -0,0 +1,23 @@
>> +QA output created by 314
>> +
>> +From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
>> +wrote 9000/9000 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>> +Send SCRATCH_MNT
>> +At subvol SCRATCH_MNT/snap1
>> +Receive TEST_DIR/314/tempfsid_mnt
>> +At subvol snap1
>> +Send:  42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/foo
>> +Recv:  42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/snap1/foo
>> +
>> +From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
>> +wrote 9000/9000 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/314/tempfsid_mnt/snap1'
>> +Send TEST_DIR/314/tempfsid_mnt
>> +At subvol TEST_DIR/314/tempfsid_mnt/snap1
>> +Receive SCRATCH_MNT
>> +At subvol snap1
>> +Send:  42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
>> +Recv:  42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
>> --
>> 2.39.3
>>



Return-Path: <linux-btrfs+bounces-1405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06D82B800
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 00:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DD52824EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 23:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EF35A10D;
	Thu, 11 Jan 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SCcKsKw4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KjSGrf5a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639E55A0FD;
	Thu, 11 Jan 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BMSH81005567;
	Thu, 11 Jan 2024 23:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QyvWVH+JSsRAf1z7pCwSetYtvRBTxxXYT+pdvfo/AMM=;
 b=SCcKsKw4c7a7Z7dFBCcHKl6a6ASX29XgZCRzsmgXx1J+EbiKPvHU6WrErGkoluy5kzmV
 Pm8ND2BJY1w9rLv9HX+JLMAhHxVWxeiCZZLQWZ8wEnUBiM8r8wxbvOrALm9MhuLefBMl
 HA4fpmY7b8GRM1dGhjpEA/Wkl78s2sI+UjfT6O+/MlnBht/ZTLvfOhZgjpcr68rv10mg
 Jl8ed/6y6SXh165+vWdFLPtwr8FV36u6VL8G3eAt0bklgzKPovjRJX9NRTVwLEh32rfB
 Ihx4VKOms6NCMDeKhfIq1eA7Azp9PfD19P4hHkl6CdyiAjhidHu8bnOp+g5gB0np1zZG GQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjjb6shvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 23:24:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BMQQDs012220;
	Thu, 11 Jan 2024 23:24:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwmrtr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 23:24:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6e92bnRZgXm1uaEQObSWUp+EKWUYwodDXq4oQK4BdkglYfIihWw1QHJVss5Sz+8z++gPAGBVsUFHC3gX03PZKrtSC+LHHPc6A4JD2p5uJZG+nofp7/KSYstLN/J+tq3kIJ0qfXJrztFV1MNIyNyBSiI4AIcyinMI86QlDznyt9XxCI+b5wCcY3g8qspXBzio5OnpSv5mdwrezDmZP9qiNcbTLhmfBo0PCs/QA3lzwz8abRaZtTZV4c8P5wCU9HxqHf1kN2Ismu3P1CZke5TdqSPPlXS2avx9q8namYN3cyStDX0pE8rOEDTrSRIGGlQ0Svq7X11RPqu7bGjTA5/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyvWVH+JSsRAf1z7pCwSetYtvRBTxxXYT+pdvfo/AMM=;
 b=PV2//RcHhdPH/BDrVp7nGve61w/fOgVftP58YiZZKeb1t9rKDteP+2P4eOR7P3Nke6QuIWIKrgTPuYCg96kVM4lEXSZydSaUWjER4RJB2epGb6ead7rR5TVjV7jhEylCijg3Mqg1Neoc/rHPI6rRatnju/W5rLJsA2BiJ6toRIQ/kjX37/AxnB1P4hF8NxkKt0Iebkm65Iqtqw9YRWVIepHB7ZKqMB8Qij+obChurAkBGIJFhBAupB7Q/LrMWwl38rD/A5nXISiW5CEUCj3vygWnTacMFghFjYFgc0TaoBpemF3ElB2MxYIRZBBUfGae8nlPorNF9yDybFghPcHqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyvWVH+JSsRAf1z7pCwSetYtvRBTxxXYT+pdvfo/AMM=;
 b=KjSGrf5awAAEESes/O/QnuPiqcD20+8N2QapUGg6l1Ggvzxs37cahgrTPMy35gYtif6uTlSMb1gkE8RDKR7R2dgmOkM0t5/+ZOd+QYTJEdRdzu1X5LpF4GCH4fjsk3i3krqd7JLvEsA2R9mqP3bGnNZsqLXY8YdyhM7fzHmoODI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4904.namprd10.prod.outlook.com (2603:10b6:408:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 11 Jan
 2024 23:24:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 23:24:22 +0000
Message-ID: <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
Date: Fri, 12 Jan 2024 04:54:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks
 update-grub
To: Alex Romosan <aromosan@gmail.com>, CHECK_1234543212345@protonmail.com,
        brauner@kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        dsterba@suse.cz
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info>
 <20240111155056.GG31555@twin.jikos.cz> <20240111170644.GK31555@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240111170644.GK31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ee16f7-9c8a-459b-4187-08dc12fc713d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	89p1MiSSf4x0TW0ev49d+3C7s7YI0y3XxrZCIiX/lfPOG0ZsjHwXPFmR353U4gPfVmQRsegeLkY6bJlmdClyaCF3YD5DgaFVANywiGc0SR7IIzc9Ak2xNwjjwX7Hqd9ap3N18j7UQhAxMVqKErIO5pQzdfBpxukPfabzQYOP2oU+DIrqebBEsKSg9cN0TzG157EaDNlSMGhujGOKS0ZSynz697x4bgwQwg5/uxItiu3Vmm5ElJi8mi+HhGc17Ebb4Cmdcf4U84YacLeNjOD8U6YSWozO3jH8IoZVs3Luqg/obq5IkhYgRhwPlpHWrI6o60tPMaaf7/Ct+d4OBbpFDCFctEC3orZ1tNSVpJf/u7opfqkxpM7t4R7o9cBI2Cwb73KecFjGVYZU2PMbueNUMcyh7tKDMI0kNVgUgZYMqy+2T/+IpPhTcWOLNlEGtd+nyf3kEkEWt4oQJVYsm+4QidkRC2MWOwV9mSUZPWQV/3+2IbwfUt6C9T7pN9MUIt2hwC0KM/zGm5L+f4LkODLA1iV4wYSAJtPewAIlTBREh0BrS4CzS0IqAwgll3wGo8lZAEDmt/PcJWkagxL2Z6IdI3ERt9LDVxsWBfemZQf+6ZWEiGFphJLrp04fHs0cTTh+XZEM4bnH7MSbn+g7yBT9gQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66476007)(66556008)(66946007)(36756003)(44832011)(8936002)(8676002)(316002)(54906003)(6512007)(6486002)(4326008)(38100700002)(2906002)(7416002)(15650500001)(31686004)(5660300002)(41300700001)(83380400001)(86362001)(478600001)(966005)(2616005)(26005)(31696002)(53546011)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkFiT3prV0RHVWZiRG95N3lCNHZicU8wbnNkdVZqUVZSM1Z3QkZqUXBadnhG?=
 =?utf-8?B?dy9IUXJtN3lzZ1MyRnhUQWxtbFlmeUk0dVpBdWMrUDd0VHB6ODVhWmJ2NEU1?=
 =?utf-8?B?VisySDU5akxOTER6VnZGU3Y0RW8vM1dGcVpIa2VsUjc5SkF4UERFblRWWW83?=
 =?utf-8?B?a3N5WWE0TGJ2d3R0NDN2aGE5Nko0UmtTM1Z0MGFtT1gweTN0eUVUWE1lVnBT?=
 =?utf-8?B?T3lpQ3R5amoxaUs4K0Z3Vk9SUHRJNTRCbTlqZ3VJQ2krdEZSNUI2M2Fmd1Rx?=
 =?utf-8?B?QVd5UlNOMzF3bzF4RkU0T1BvRnZaUHZEV2toOWJqblYydFQzWkxDdjA1WjNG?=
 =?utf-8?B?YURQdFBLcWRBNmpwZjNuY1IrZHorTndxdXNwY3k3WE1neW5BWFFabkZWRnpO?=
 =?utf-8?B?d0dUVGNISmxTd0NOU29oa3cwTDQvd3ozL2NVOXE0UldpZDVpM2c3aGcyQUE2?=
 =?utf-8?B?bVpzcVZYNW13YXAzc1JzTUFnZ0RMR0dLd1NYSFJIeXlQMUF6QW44UUZXMVNS?=
 =?utf-8?B?T0xvdzRtMks2Q05kVm04bmtUN08yMTRMbkZhVXJOWncvZVdIbXA0cjBseGd4?=
 =?utf-8?B?d2tHNXlIbVJEaUwwU3Z0VklJbWt4OGxCWTU3UlVPSEIwNXJWdkYwUUxkVXRy?=
 =?utf-8?B?SGM3OUd0ZGhuTmhIeUZwdUg4K3FHc3dWb2dqM0dzWEh4dWpwZ1U1bWRSVXpM?=
 =?utf-8?B?bWhDbkhHR0MwM0hESGVOZ2dtbWtTcVNEbWRHdkw1aHl2R0VPNDc3NFFBaUM1?=
 =?utf-8?B?T3pUYzdhcGRadXh4OHJ4eDdtaWt5VXMzR05qbzZneDlpTDJrYjVNTGtrNFBQ?=
 =?utf-8?B?Zld6VHdEYjFKR3cxOFhjSWxtU05RcFJsWE5KK1Y1bE41WVl6dHRyVXo2Q3FQ?=
 =?utf-8?B?MzZWY2YrSHJqWjIvZnVrU3RIZzFrT1ZKSzdXZU5rTlVQRUdSaHJYU2pUdmU0?=
 =?utf-8?B?bmlxbFlCSk9LT0I2NkxKbTdjZXF5L2wwWXBXM3F1V1V6am5JdkFkc0dJalcr?=
 =?utf-8?B?K2QxZmtJL2tVbnVPUWYrNjArL3NFdHRxZWR1aTJ5MStIcG14VmdLNVoxNks1?=
 =?utf-8?B?L3NzQTJGbWNYUXFEc0JJSDNkK1hWRzBoSFc4ZW8yclNlWTJSWEJ4SlYzRWhL?=
 =?utf-8?B?NXowdWRQREJ6YUtwajk4cDhMSHRDZENINW9PYytUci9ueGNqTkd1K294NmNV?=
 =?utf-8?B?OU1BdmQ2NS9JOURsc2dCNStKMXBsb0sxYmZYZEpVSHNicGdiczNoMnFhUk5S?=
 =?utf-8?B?TTFWajhVc1NDeTRMUHdJNUlJS0pRRjVNMmxwbFAwS01qditJeFlqRHpLOWVE?=
 =?utf-8?B?aDlRM1RIODFSME4rdmVvdkhUVE41Zmg1MC94cXdWQWx0Q29TQzF5Q3VQS2VD?=
 =?utf-8?B?U0c4RVNOMGtTOGlqOEdCS1JtVk9UQWdDTEpYRE44OWpVK3MzVGFSOEs4dFJn?=
 =?utf-8?B?c2FMVUZYbkdsNmZLZlJLWkFQRHNvdTQzSlBDRVhET01SYkVjK0MycExkdnV2?=
 =?utf-8?B?Q284VzgxNU1JU3ZDNzRVKzBURHJqME5oU0Z2Q0kwM3BkeEtJZTl5QnJmOFV6?=
 =?utf-8?B?THdkR0hKRkZURHl1aGl6d2xURnVuVEx0NlZVSmIyL2RsZ05keDdEUzcyVmgy?=
 =?utf-8?B?R3Z5SnN0b2hCQlR2QjhkazlOWDZ5aS9WSkRvVjVzN3ZReUtuanJKWlIwT092?=
 =?utf-8?B?cDJYZlpkMzVyUVNkc1kzWG5NVUNzV2RvNEJEOU9kSFd3WlZaZ0d1aWdCdXdM?=
 =?utf-8?B?OTlaQ3JpREk4YlhhclFhSjBUODhPRTJubHY3N1R0aDJwT3prekFmbXE0NmR0?=
 =?utf-8?B?cUNmVUQydHhpNFZiRkYvbUFHYzhXZm8vRnEzNkJGRDhlSE9BNDNvdW43dk1m?=
 =?utf-8?B?SWZxbzE4d3NTNzhTbmI1eWkxVk4zbmc1NURtMWp6WHhXalJlb0s5M1VGWjIr?=
 =?utf-8?B?Z1hhL2pqQkphVm1RYVVzZEp2TTJlaWN1VXNjZklodlVHWlBXdmhUR21MUXZQ?=
 =?utf-8?B?VTUrNldFNjdTdFBIU21CZy9Cc3NHalo2QlJSYnFDRi9mZzEydmJybjByZ3Uw?=
 =?utf-8?B?RDZvOUV4KzB4WmRjQnk5NDROOCsreVBtcEV4SXNJZkVnaTZWQ2E5cnJsWDJk?=
 =?utf-8?Q?NpC2N9G6qIHbRY5WMDX1n3c6m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AdQTgEdT1BDQhixH0OkHVii7m83edvHffOhKYKo5VtLZqJEfmQdtg0GTnaSY7aANiV8+YUv6jhyUoxOsYqh6raJNw1ZYKqkQCTZhusEmM/rhcNfTPEh/cjltFCPZguZBXD5rqLweztELitEdCgHcLhsPU9Wgj+m3R46iP8dJmClRWxC+yXQLWYOcWGs5syPeF84YegBBBHwnRWmFFVKfbv4bo+OKP5fb4BFmRTScWdwPrnq5A4g3/LptN3Dvrvq+22G0yqi8cuH7aeie6LyfcZAgbfKbstEC0X8yt1OYpzwW7ZpjM7G57paZTiWTY0heqYPsoYy77/mSYa/+aUrRZB5XsnIchtlngD5E+H77ywcPgQp6lA9kq/dmQqPqgppX1Ty3bvRSW7QPe1/GfR4WVyVzSL+VFtbW89bAOhpzYQGRbknwmKIeMeRTmChMPBcf8vN11FIj6n5LQHMf4ESpGvMEbVf+n5PeHyhicutdPJFlhwzw9APMqj3Ysu2oDYsIWzJFIYvq4NRJ7k3O6/iFJrHZds1AhG8XRxBBxVmr8nxBxASJNLRc1BmVfQrMgYhgxLYUI9YHTzZ5IG/FUXLMDyBrXhuXuMXN9Mk6Er94Zo0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ee16f7-9c8a-459b-4187-08dc12fc713d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 23:24:22.3784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQh+nrbYRosCdzuTxyai+3ovnzaKUlYRWK5WLzV4NGIyX3AAKMncysAuc0Ejy2mRDMRIDCprlUbn9MvCGe2CTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_13,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110180
X-Proofpoint-GUID: GJX01vQKHBiZywI9Q9g5a8gCIZfkbkN6
X-Proofpoint-ORIG-GUID: GJX01vQKHBiZywI9Q9g5a8gCIZfkbkN6



On 11/01/2024 22:36, David Sterba wrote:
> On Thu, Jan 11, 2024 at 04:50:56PM +0100, David Sterba wrote:
>> On Thu, Jan 11, 2024 at 12:45:50PM +0100, Thorsten Leemhuis wrote:
>>> [Adding Anand Jain, the author of the culprit to the list of recipients;
>>> furthermore CCing the the Btrfs maintainers and the btrfs list; also
>>> CCing regression list, as it should be in the loop for regressions:
>>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>>
>>> On 08.01.24 15:11, Alex Romosan wrote:
>>>> Please Cc me as I am not subscribed to the list.
>>>>
>>>> Running my own compiled kernel without initramfs on a lenovo thinkpad
>>>> x1 carbon gen 7.
>>>>
>>>> Since version 6.7-rc1 i haven't been able to to a grub-update,
>>>>
>>>> instead i get this error:
>>>>
>>>> grub-probe: error: cannot find a device for / (is /dev mounted?) solid
>>>> state drive
>>>>
>>>> 6.6 was the last version that worked.
>>>>
>>>> Today I did a git-bisect between these two versions which identified
>>>> commit bc27d6f0aa0e4de184b617aceeaf25818cc646de btrfs: scan but don't
>>>> register device on single device filesystem as the culprit. reverting
>>>> this commit from 6.7 final allowed me to run update-grub again.
>>>>
>>>> not sure if this is the intended behavior or if i'm missing some other
>>>> kernel options. any help/fixes would be appreciated.
>>>>
>>>> thank you.
>>>
>>> Thanks for the report. To be sure the issue doesn't fall through the
>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>>> tracking bot:
>>>
>>> #regzbot ^introduced bc27d6f0aa0e4de184b617aceeaf25818cc646de
>>> #regzbot title btrfs: update-grub broken (cannot find a device for / (is
>>> /dev mounted?))
>>> #regzbot ignore-activity
>>
>> The bug is also tracked at https://bugzilla.kernel.org/show_bug.cgi?id=218353 .
> 
> About the fix: we can't simply revert the patch because the temp_fsid
> depends on that. A workaround could be to check if the device path is
> "/dev/root" and still register the device. But I'm not sure if this does
> not break the use case that Steamdeck needs, as it's for the root
> partition.


Thank you for the report.

The issue seems more complex than a simple scenario, as the following
test-case works well:

   $ mount /dev/sdb1 /btrfs
   $ cat /proc/self/mountinfo | grep btrfs
345 63 0:34 / /btrfs rw,relatime shared:179 - btrfs /dev/sdb1 
rw,space_cache=v2,subvolid=5,subvol=/

However, the relevant part of the commit
bc27d6f0aa0e4de184b617aceeaf25818cc646de that may be failing could
be in identifying a device, whether it is the same or different
For this, we use:

      lookup_bdev(path, &path_devt);

and match with the devt(MAJ:MIN) saved in the btrfs_device;
would this work during initrd? I need to dig more. Trying
to figure out how can I reproduce this.

Thanks, Anand


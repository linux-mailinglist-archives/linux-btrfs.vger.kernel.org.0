Return-Path: <linux-btrfs+bounces-4188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7474F8A3036
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 16:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02583285D23
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2288614D;
	Fri, 12 Apr 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="B0UAcoNQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065E219FF
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931278; cv=fail; b=GNvdhVV6kbJ14SCaXoNlLCFUbqVHTAnic/JwZiRPEGieI2zXSRUt0U2mDSbY4y6FHI6YFBWyMMbBslxeEE+KeY1kf3lOLE1mP2TxPorIQE+m4juszJfISTaIdQ/kehVOyPwjZwq3C+mVyQnQChZoPEt257fUnayeCC1p8cNe6Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931278; c=relaxed/simple;
	bh=bwYcHk66PSwfdYPBFKbGoeX09xZbqcuxmcGSU4rsWjI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H5ubbmvOsUzYyhy6NZ8dprrxWh9n8/mQbFRzYOEHj5OurMBrdv5EKc+oraEto/ugyywo+W18g+K5k27vaQ2kFj37GWgrTIiNJ4i8SFgG9JH0ox5Wze+YtLZ/iD/QqaxFD7duaH/sdoqS6A5f4iT5Gg5L+LqgmuvQTg/oSwchPPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=B0UAcoNQ; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CAGLSu011297;
	Fri, 12 Apr 2024 07:14:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=jnLfKOEqY34vf2f4PGMcP1T3Kj9z4OojKesj660Vh4I=;
 b=B0UAcoNQ3gTmtl/gIZWAj5ehmz2sXG/3Ya1AmIQqnnFk6VMSUV/qpVVAevDC/g941hHF
 5zYwEc7qH+vSTHVBmok59cSFge1GctQy5J5A9HHpkNctyiwkqcPd/pPSrxnxWgmf2Uyd
 T3rrmMxe8Q0YY6+TJjNsvWB121FFtKSxAG1rntkNsSoe+OAp+Z6C2nEYslyjnnqp3Tma
 cr3GC+547UuaKdYtZVUc4ZupCZNfeZuyek68Xd4jLPQ7tbZfH61UXlIWybp2ZOj+ln2+
 OPkTck3+OZVo+Bl0DfW/cEApMdQZ93trUbHhQZhDfF1C0NlNf9EsFGQkpc8Vg/aHWqem VA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xf3250ysq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 07:14:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEGi5zotCtCNv55EyibPF6sZWB6Z/2oWtCwIiJmAbtOlCkeMni0rxFZy8/QG+6oX+2gFsjG30su1s4wjB9TQxxR0ausy5fq4OXbEvIk0idTCYeG1HE2KPXd/fpwmAA1yZWdBdGbov/z5RIx3l263rZYgL9LU6JB5BlVsXolQBv2Qej1FF//Xk6VvuWgtU6GKHfUbTzNVRYh4yPQ9lNqOvK6mBb9A77pM7ceAa1pPjJKa+BEcarBcgLNv95REknKZgyMdm/BwJ/sYqSFZPzEt3McTVfrbw4RmkIH5BXzV5zbRHkJmB81J+r2knLHKuElVrxDCA7flE9y4xa6NMGc/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnLfKOEqY34vf2f4PGMcP1T3Kj9z4OojKesj660Vh4I=;
 b=Oy6ea8FH3eJVfnbBoH3LHWqKoyfD+TAroUmBRKAdy86wgajoaV9BOXj6k+dSJs7BdBiaQX7F9so56FqsFHBE17bW6mKZaVmN0muZZRwTYGizxHRkzksk7kPQchQiBujqYV6kmWkITk5tYJspQ9EeCTBOswjtOkH+sZKQ3ZwFOd6gcSsbmomTcbMRQuBYvK4ONeoyTv99ZVef+KdJVOkqJzjPaARQ97hM1/KrarWqvhFer2pK7MiJivQSDebTzkYDjRtA2FGfcBZ8ZYXVSrWWSiyAHiQDEWCQAsTBlcVYCzH3jH2gWQDthmHua/C+KqJXkucOdekA2vDmcaFiDR1+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by BY3PR15MB5089.namprd15.prod.outlook.com (2603:10b6:a03:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 14:14:23 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::fb9a:11b5:8f10:3474]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::fb9a:11b5:8f10:3474%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 14:14:23 +0000
Message-ID: <fe4ab1da-3c72-4d98-8af8-05221ac7d65b@meta.com>
Date: Fri, 12 Apr 2024 10:14:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: check delayed refs when we're checking if a ref
 exists
To: Filipe Manana <fdmanana@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <dc43a26265d37c71a53d6415ae2d352035fa6847.1712869574.git.josef@toxicpanda.com>
 <CAL3q7H4RFSr3GEohQ=mLA2Tm0Us0spCk6je1o8iJFKEmhr4N5Q@mail.gmail.com>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <CAL3q7H4RFSr3GEohQ=mLA2Tm0Us0spCk6je1o8iJFKEmhr4N5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0031.namprd12.prod.outlook.com
 (2603:10b6:208:a8::44) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|BY3PR15MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: e67d081e-5041-4f96-276e-08dc5afada6c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aZ6qALN8qvYZFCokvTCHYkE0ZCaQixKBCFzJAwaFQR43lg4M2Ch54qaGDdc/d6LBbCAiIPtnCGQfjroPU2WQb/LpKex2X512yxlFhL/iLzxiXsrEZfhS81MYkbY2j855ZvpS6v6DaJXsR6B8Ot17Pn/ufbOMJQa28yL8k3Cmx7eqgra3iJ8A4EKvUxpbAPfsiactsDHdR4rUXs88fNroMcGIAWLra2OJ5oY9Of/XR54h9vD67rVUjUxV5jOlz7eT1IxqegF5YbAlLW8oWdnGaJq8jk+BfOPGi3memkDR8G1T0aS55jzQ8DmPqopOy3w7t+tJcgOPmfE2RHbHRAuEidUxjR6eZnuTJpaIpWtTTV6Eo2Pw0OLMWmaHmcWU6cKtlgGn7SMxtfRXYkuillqtTYw5rh4vtKH/EnsBK814DVncxXIsw24tOKvA5v0QTJbYP+c6xzA3JdqHBCWqb0cI6ednegMqEHNftNGOmHjkumFR+w59AbTMDsOslHbo1Uhmiim9Q4U7/LhFxS0omgrr2leoXAQq0mM3x6TSZ7eNbffSGRAYFMaH1vsXBLVC7vehawhJMDL7wraCN0I7hG1bdPs4XkLWpKO2gjT1onwtJ4mdRw/xpZbziHkS5PXaFOOOUtqeTkTYrgmlq+VZwLql2qMJIRz3SuLlB4W+IEZ/8Nk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZEJ3SjlvbWFILzVEa2hjMzVMekdWSHhBQlAyam9qNDRuM2NpejIzdkFCNk9r?=
 =?utf-8?B?VjY5SG1FZFNtM1dqQkoxd3plYXB0dFhpdWdwY0tSekdkL1cyUllzV1dxMUFn?=
 =?utf-8?B?cDBUWHVuM0VRVnI0Yy85K1hTb1Q1d0dVTy9oVXNQeTI2VUNkcHRuVTNBOCtP?=
 =?utf-8?B?M0hhWjRLbHdDclA1RHIzb0pHT3lYNWwvTHF6d3h2aWZCdkxETkVFaGFQS09E?=
 =?utf-8?B?VmNHU05tdHY1cEU1MUNCaXlYUzF1clJuL3Zpbmg2V2tjWDdPQmpZZWhLMHB2?=
 =?utf-8?B?eHQ3TE5hT0N1YURyVlFMNUl3b01LRjd2TjdibkwyNjRTMXk0Z0UrTW9lQmJ6?=
 =?utf-8?B?VTd0UDZVQUE2eXMyN29BRnVhQVZPYkJMVEcyb00yU2VmeGpsSExRR21zOWFs?=
 =?utf-8?B?T0xyTmdzc2tvb1Q4R1pNS3pvWSt5UTU4bTkzQm1sWXAxb0xTakFEd2kzRGIv?=
 =?utf-8?B?ZUpNSXIzMXloaHNWR28rOFF6aWthLzdudUdwdjM2UXJDR1JuT2RLTkFpSW9n?=
 =?utf-8?B?MjlXZDBGYk1XTHA4VGwvNURCT1REWnpPcFp0YVgxellJeEpiT0pWZncxTG9p?=
 =?utf-8?B?Y08yU2JDOW5SNTF3b21mVDNFMGxyMU5SRmZXQVI5YVZ0TlF1aFgxUHBRWTk0?=
 =?utf-8?B?YWRibFdZMEMvNXJpSjRHODF2K0VTWHFJT1ljUTdDaW0xcitETTdJeGVyWWRl?=
 =?utf-8?B?dDdOV1NjU1hmSVlodkYxVlFDeWRVbWNDYXFHeU9zMDNNVk5qUmhydHM0SGg1?=
 =?utf-8?B?a3B3bUV0dEd1Yi9DcnJ1dVZoV081bzFSdWRnbTBPOTBha3Bxbml0cUxpVGN3?=
 =?utf-8?B?S2NtOS9aQnRqWWlvdENxUGlISlE0WGJMYTJocUc5ZjRwWGIreHRPWk1Ya3hO?=
 =?utf-8?B?dE1ZZTAxRmt5cUtLWFE0bkZtM0xsejJJdkVXL2p1Qmt1cDRRQnBEK3gzMExa?=
 =?utf-8?B?WERnRDErdExZV2hneE5XRTZqL3ovL29nVW1wZ2k3RElNSzZpVkFBUm93aERT?=
 =?utf-8?B?aGIrN0RQUWd1aVd0aGpmTmVvRnlPa2s5aUFKLzllSkdVZ0VXdi8xSlFFVkd1?=
 =?utf-8?B?S2VKSzNHWGRyNC9jUVJla2Z0dTVvQjcxZUlVeitSZUMwVzJCOG5RL25KWTBq?=
 =?utf-8?B?K0NNOXhvYm1zdGhOMjlsdzhNSDRuczJvRWpOa2pEWTBqR2VUMWRyWDdscExF?=
 =?utf-8?B?aHJ4aEdPZ3VMb2lWeTdrOUFnUWUvbURsNnF2N2w1b3dHazdGMk8wMjJvc0tS?=
 =?utf-8?B?Ri9PWThkNDUwT3Z5WGFEczkvZTE4M0R1aVd4S2JONWZkd1kzeHpFa1lKc1VZ?=
 =?utf-8?B?TmNQemFJVVBlZ3JOZmFuNU9MTXQ2SUMvcHF0SGErK3NpdWs1aCtOV3F2dk1Q?=
 =?utf-8?B?a25ZVDBqNTdhS3l6dXBwcHM2M09BMTg3cjhWUFFwZW41enpKUk0vQkt4bVRE?=
 =?utf-8?B?L0VWRCtCeXpoV0FMNTFoWlN3THExaWJqWWUzQ1IzQVZzUDdYOEtQYUVMaDNi?=
 =?utf-8?B?bjlOTTlKQkk4UzlIMTI0SmMyNmxIY1FSSXQzMDE0T3JueE10YWtpUGVpNVBk?=
 =?utf-8?B?eDB6cXEzQ0xJQjlHS2pUbWt1RFlJcENobWU4cER0Tm5rQUl4QTkxRlZSYVF0?=
 =?utf-8?B?UnB2bU5GUVlUMjdBRElScEpueUppNk9hTVFvaWtSWVFBa1VFYXBKVGdGbG1E?=
 =?utf-8?B?YmhWZU1TbWtsZXhQa3I1OWFUeHZjMGpBeVdlbWZINlZkdXF3Y1VTRFZFbnpB?=
 =?utf-8?B?Q01YalFsZnhjeFVsNUVvRm9DUzRhVkZCK1YrNUdoRTN4N1ZXdkpiTi9LS3Fy?=
 =?utf-8?B?NS8xbDBBcWFmQUEzbDR3QktJZ1dSamt0YXNoU05MWjZPNmJDS0YzejhwdHdx?=
 =?utf-8?B?WTZUZ3BReFhKZWgvUk0vQi8zYWhGSjdJbUFSRTZJN3hHYWhvcytwaEVSU0sx?=
 =?utf-8?B?WjJzakMzUkpxclc0WmExUWtBT3I4empnUHh6cDFQSDQ1VnhRWE05bXJ5bXEw?=
 =?utf-8?B?ZUlnclJ6WlVUQkk5cHpDMzNNK3pGZzlIOEhSbDd3NEYvQitrOWh2VDhDYVJn?=
 =?utf-8?B?bDUxdHJvVzM3RGdzRjgxVFdWaitibzBQUEp5bk15U3FJQXF3VEd5a2ZOWmx0?=
 =?utf-8?Q?hpok8i6P4eRVYa7TcTj01rKBn?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67d081e-5041-4f96-276e-08dc5afada6c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 14:14:23.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6HJfg1u4eHwF2tsgQBEbvp3sUakcN0sFcjp3CEn9LtUmBvpRQOIW4YQ0WEyXU6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5089
X-Proofpoint-ORIG-GUID: HRE1xSIuAxOuDgcVDZkO3XTWe3H2kFi1
X-Proofpoint-GUID: HRE1xSIuAxOuDgcVDZkO3XTWe3H2kFi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_10,2024-04-09_01,2023-05-22_02



On 4/12/24 8:58 AM, Filipe Manana wrote:
> On Thu, Apr 11, 2024 at 10:12 PM Josef Bacik <josef@toxicpanda.com> wrote:
[ ... ]
>> Chris Mason wrote a reproducer which does the following
>>
>> mount /dev/nvme4n1 /btrfs
>> btrfs subvol create /btrfs/s1
>> simoop -E -f 4k -n 200000 -z /btrfs/s1
>> while(true) ; do
>>         btrfs subvol snap /btrfs/s1 /btrfs/s2
>>         simoop -f 4k -n 200000 -r 10 -z /btrfs/s2
>>         btrfs subvol snap /btrfs/s2 /btrfs/s3
>>         btrfs balance start -dusage=80 /btrfs
>>         btrfs subvol del /btrfs/s2 /btrfs/s3
>>         umount /btrfs
>>         btrfsck /dev/nvme4n1 || exit 1
>>         mount /dev/nvme4n1 /btrfs
>> done
>>
>> On the second loop this would fail consistently, with my patch it has
>> been running for hours and hasn't failed.
> 
> Is there a way to exercise this with fstests, using fsstress for example?
> 

Probably?  In this case, simoop is making a directory tree with 200,000
files, 4K in size, with fallocate.  The fallocate part doesn't matter,
it's just faster.

The first simoop (with -E) exits immediately after creating the files.

The simoop inside the loop:
  - reuses the directory tree.
  - runs for 10 seconds.
  - has 16 threads doing 2MB reads and writes into the subvolume.
  - basically translates to: cow some things.

I experimented a little with smaller repros, but they didn't
consistently hit the corruption.  On all the machines I've tried, the
simoop version only needs two loops to trigger.

As far as I know, fs_mark is the only other similar utility focused on
quickly creating big directory trees, but I'm sure there are others.

-chris


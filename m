Return-Path: <linux-btrfs+bounces-3519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C8E887BFC
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 08:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A371F219EB
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 07:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D214F68;
	Sun, 24 Mar 2024 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="duX99hDN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZOOipk/2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0813ADA;
	Sun, 24 Mar 2024 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711267005; cv=fail; b=sH0hctk8dNqyX7iIcKo+DBCX2zcqZmdf2DPvfdRtaaIsK1gsX969zGghEexals499FnuKdYqKJGi41uNnd3PtE3446nIkTpPb7eDkpLUV7E41WTqHwPzXhgrBzCGLHTCxYi6nSgyMYcgKOEJpqZPpW9YVx+yCsSozTrwjkDa6Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711267005; c=relaxed/simple;
	bh=YG5ABAqrKL2/4mHBy9J9Foudf5qQn+VTkXNUHPan4t4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nbqOSgfkaecHVxtqCM5e0J8TXT/3jtZEFISnRovYz1urmZOWSiIp/AcODgXlbcByBad+eNKO2yrTYKGSDzoJdjN/+HFwSKtKsUynEw8AEbQkcK1iuTQJc2N+wgkPDNSZkktraK9+1jfe/V1UC5NVNM23VRiBEX+Y58Fjj0fp6mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=duX99hDN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZOOipk/2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42O6dRhj029784;
	Sun, 24 Mar 2024 07:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=x3Ral0E0s/UxykvSqH5oOxzFqm24WhWj4oguU7aosSM=;
 b=duX99hDNL4+1fwR96xdd5MJHI8koI2tWyWiUur9idW0S19ZQQElevEmJCY/tVGH3cmFF
 xvEauc6eQSkeV72U1n/n/7SDJ3tbmd2V/Euw3RfAus7gwJk97nJvVrSuhgha44yVd9Hs
 Zp+wWp7PgcgC0StRCN3T1cen+X1zdqEHsZWd1/ARsw25Lo4WA090zttq6qkKoHIGPEYs
 6Hz52MOgULE0yZn3Bwix3ZcSlsA/Sr13gg266lWoZ+j3wA+OtglAUqIY/BmvoRpAVYOM
 MWKR9rsr8iA6qXALI6zbO/xVJZWY3IZjU+NRIp9m7hsVcvKo4jcwn3Y+ThSiIze7iT3F 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1ppuh1a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Mar 2024 07:56:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42O50SsP039775;
	Sun, 24 Mar 2024 07:56:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh4dbn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Mar 2024 07:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS5FuqdKvPrdjoqOg/cYJO8CZ/JpxdmLTsdbt6i/+ey/GQvX6QIGvCtoCcJMXhEtOYtO1wy7I0qm0IRuQNbKPhMl6UDSV+mzU9SUDbKWJk1uvz+KSOg89Uloj6DYVsJpjoezuj1u0w6GA2Pa7lflWwYh6hHf0697f+9mpjMGlhDZxGkPeVWyqMdaRy3hZXglKyXdgRKRzo9vvrqYxjrfn1gmsrUF0/ZtP62QnoVHL/hgxp5n5RgANMACK9ciaoiubkl8qnhSQp2FraVHevBi0B4L1N5Aq6STH+9NVgfO5XUzYHNJ+DPeL8FzUxB1ffB4jrxXgBiJv3hiTiwqJFj25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3Ral0E0s/UxykvSqH5oOxzFqm24WhWj4oguU7aosSM=;
 b=JI871yqedOVThxfMN7VeNI0vCwsecRWFnDb+FnyFbAS6gisOY2JWR2Q095mzoJ6yXOzAz+fKysqLwgohy3keN52dMQ4WfipDa4nj35s8v+E8+G941cdhfSGeyBbK5pyfQdXgYPcd4lugML+YafugBAxVUKcOndWa0vjQtMBQAc3G7vZyjaVeX4QigRDz8kC3vpntvVJSWqeG4yDAD6k+R0cgs4byehLSgsfXcAgDznwPjO701T6uOTh0Bo5VWLlbvtb1BGqufT0n198oApftTEOEAI/NbLRAbtruV2UV3e9iTFbSH2U6pPABOlBn9wTRSWpZ4zSiANLHQCSRYv+r1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Ral0E0s/UxykvSqH5oOxzFqm24WhWj4oguU7aosSM=;
 b=ZOOipk/2IflBdRnnBG20tvfDKtkzCJlWiBaQwbCS/X9OKdU1zmASAcQCDD/eNrP+zKzZbI8rnwmcQBvza40PQhm0Wrd2ErXwPVLv++V7Z0Z88M291hETk8ftjOZJKxPOw/WalO6tBk5RTaZXfvpTiMnTDtb+M076C0HV+UX0XBI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB7036.namprd10.prod.outlook.com (2603:10b6:510:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Sun, 24 Mar
 2024 07:56:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 07:56:29 +0000
Message-ID: <0165b967-c8bd-436d-a2e9-b859b940a7be@oracle.com>
Date: Sun, 24 Mar 2024 13:26:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] common/verity: use the correct options for
 btrfs-corrupt-block
To: dsterba@suse.cz, fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1710871719.git.dsterba@suse.com>
 <0b2ef42d6fb3e3b6ebe91c84b9a5e698af13d80b.1710871719.git.dsterba@suse.com>
 <d8e9d153-aff6-4f47-888b-b2ab91f7eb5b@oracle.com>
 <20240320152332.GB14596@suse.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240320152332.GB14596@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: e67cc8f4-c61c-441e-0f36-08dc4bd7e973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1k7D+t9jK6XifDbtOOWt3icn50Nj8/FLbSgHrB5GQCRkBTztih+wTgMdnep18gicnWXZdp/rF0T4wc2jVOZ2yyTly9ZZLmDxC+7lY+1YaWR/cWEqPXr+XqmZAsO7MR4U2eVOVD+crKdkzj1RdkGbX66ZXXMsxc9qwozWT6Dqkoa8DFwN+zigUFqbrtiguoLmYhE4D2bpvLLMCeNi7Rvv/C7jYBAf62qEwGMZn3jwqzocccZiaEjHm+YtJpo5APQsFw66ldlk2YF2Z0k+v/DxZy827rxb9+ZDu7oNCLE/AJsDDMKT4Ehaaso0vMPSGp4q1+giLiB7/Okapd3CmZJXi31z5fEB+a0yOB9Z5BXnMMH5Y42p3BEctk/KgBiQqnK/FyYPW2cvDmS2k33a1eV7tDlDLJZZSYmZtkLO5vbo7oFLryfhwtOqQPLamRSTq3IzKE4XM+zQwQM8wGpjH+bz3KatTXbdvUlXuE0YxOgXmt49M7GaK7KMwsgqbQxxI77k2GgQhg1TDIEaRBz5ZuZN7urh5Lwwj0EoUfC0xRV5Q6c36kx5fR9+ua9En6OMYi9YDsOHq4x1ZTuNeIOVUoZszjVR66NJe0J22tch8ICI6uo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RkFwL2xHQUlIeXJXNkZWUTV3bk42TC9EVmZSczRZTjJMN2hSVzg1TWdvbUxQ?=
 =?utf-8?B?QS9pekJyNy91dVpVV2lMNGRiK0VTT1p2dHl4bW8xdXhVdDRQK2NyTzJjdXFB?=
 =?utf-8?B?NGZ0VGYwb2E1RnZoSDZScCtxZ2NiK0lXWE1nMmNhaWZkUWx1SzhJejJOV1Rv?=
 =?utf-8?B?Y0puT3pYRE5JckNWR0pBMGJVK3JQZnFpeEg4WnJ2ZnYvbUxrb0RKVzBHMU1i?=
 =?utf-8?B?R3hNZUZoOHROcTl2SHlicklkMGRPM0UvTVdoY1pSU1owVDFOTHNnOFJvaTJC?=
 =?utf-8?B?Z1dWZnNGMDZzUzR3enJ1THVFNlpNWFNEZnl4MkhjL3R3bmZyMENGbEdBVzd5?=
 =?utf-8?B?V1dtL1NzbHhxRUlxalRuZmY5L3lRcFRmQVZpZm5EMThmRDB0Mm4wSXIxRXJy?=
 =?utf-8?B?MGNENGM4R1VjaEJ5cGF5dVZqbFdmZ21ETStNemRoMkljUGhKUVBXMzdxcXRB?=
 =?utf-8?B?L3oyNHRHdkhySzZMUG9FeFpJcFNRZkEzTzJQRXd0SlY1UkJMTEt6NUphNTZS?=
 =?utf-8?B?QWE2dDgvWjFlbEcxT1RVU2RiQlY5bVMrMXNzTmE0cU5rTzhBQkJ3NFNJaFQx?=
 =?utf-8?B?c0h0TVNKdjZyT3RMM0RURkoyNW5PcjNTdnJZVlMzenBoM1JWb2FkdlhvQlpB?=
 =?utf-8?B?YXh5bTF5bmFscTZpYm1iU1hkd3VLcWsvUXdnUlRRTFZpUmxBRVpzenpjZUdi?=
 =?utf-8?B?UThpYkg5MGg2N2hCd1gvUFlLM3NoQ0NldXdUcnJkSnlTUjVLZWx6N2ZETFZB?=
 =?utf-8?B?NjhzekJtYkxyOFJIK2VpNFlDWTBHbXVvdEd5N0lNYzhvZEtGVnM4SjR3bzYx?=
 =?utf-8?B?L0FYbmgzaGswaFFsU0g0UnlUbGxyekc3dkNXOEIveCtGeURHK2NmMXVaU21v?=
 =?utf-8?B?OUZDU3FUNm5FSU82OGcyTHB6VUV4RllwOHI0NWdKMEhITVkwK2lFZHhrS2hl?=
 =?utf-8?B?ZjNMME5LRVBSSW56RmpYcjdPT1grbXhWajIxYmN3bk4xWHpjdGE3UVhBd0Vl?=
 =?utf-8?B?anFaTU5aL005cTI5QUNCNnR5a3hndzZYOVFWdzQ4aytKWCthdXRJUnFBdUZl?=
 =?utf-8?B?OThBaFRCbDllN1BuT2VhdkhVbG5PVnlmYURHTXpVbmhZTlVmaVdVMVpRUHZ1?=
 =?utf-8?B?ZldPNUh0ZzAwRC9oeStCUW5BZFU5Z2R1Q0o1WGRWMWVEVktnVkFKUGxneW9q?=
 =?utf-8?B?MnNDVTJWOUhhN1dzS0J5TUk3L2RFME12eGRJRmtERWhHN0dQbTB2elN3OTAy?=
 =?utf-8?B?NU9GRERZajR3aGhSRm9LdTBIL2VyTTNkZUhDR0RLNitMRGtRMVZ3TEFUVkcz?=
 =?utf-8?B?dGVCbDFPZmZRSmk1UW9JQnlRdmVkeERlZ3JkWUFmQVVsYzNYelMyVWE5OVQ5?=
 =?utf-8?B?SGtBTzFYVXJkUXJHMm9lcytpTWJsR1cxSFJaQU54VjhoTC9JYnNKSUtPa0VB?=
 =?utf-8?B?THRkZkl3TUJoSW5VSysrd3BHS0hjVGV3M1QzVC9RUE9QeHlPN2k4NWZqRlh0?=
 =?utf-8?B?WHZ1MTJLWlVnY1pMMU1yV2pnZ1FyNjBQd0RTdGlDNUxqT0FseDNITHM0Z2M3?=
 =?utf-8?B?V2tld0psN3Rwd0thNjhRajA2bjh1OUN5VCtuVmhsZlV5LzlCM21XU2ZVQzAv?=
 =?utf-8?B?YlRpT2xDOENFb3d3bE5HRTVTQkc4clZDdGo0OHhmOEhGaGNsZDdjMnkySjRr?=
 =?utf-8?B?T1d1MWxJd3JpNURab3YrTndOVEx6UHFvREhLQm9sS2lSSDRtTTJwcSswTlRX?=
 =?utf-8?B?OHhncVYwdGp2UXpPS201WFFSc3oyU3lEcm5WL1lwQ1RsYXJ5b0ZBd2crU3Bu?=
 =?utf-8?B?YWd6NWY5dVJJb0lDbVZ1eHNKQTlMRmFwNG9VaGtBdHdnd09uVERGODF5aUdj?=
 =?utf-8?B?aEY5RWhDbys1RndkcVJvcFJUOEYwV0tWcHJVK0lWMDNNR3g3cXBZTFpES2Qx?=
 =?utf-8?B?N3VIN2lyT0s1eDY0T1R0b2FoNFBGSlJ6ckhLbTBPOXM1Mkk5TnR1RTlnTXpV?=
 =?utf-8?B?OFZjT0plQnZQelJDa1hjNzJYN3pVR09FQ1NPdFJtZWxRT1RzR1VwSE5VTXJH?=
 =?utf-8?B?UE1NMkNNMzZER0dxS01IdmE4N1hQcFZFSXlCV1NOVDRYa2xSME94LzFsSk53?=
 =?utf-8?Q?FWXpKxI8DZNdsKDycbCZrMubr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jlUe81VB4c9yZuT6K4Z/8Wbyh8gY8qGQKFRYiORDuLGoBY70m7SqExBtwwKJ/otyieKyTIljg9x2YD3ElxKgv5qJ5OfHBC8d7SkG55mFkQW6/gZMRgxBewOZaEAL25mUIcaDtdbkek5Akxdfdk090smY2kz9nBxXmOAdHY5hKksNWpfw1fRsNm2vvi4BHIDJMyt9z+ZB/BsYwnUysk6C/Os+zSfhJANMot+qTUnud9zuHCsb1d2xk2e8L89i+q5bJ5fHn+XuwLqbUf0Uuw5vANHF65ilSyt1Z1AG+K3dwyJFiCXvK365N/uSG1zcjUAkIq44/h+zRt9H6/pWJQfJdpN2B8OEnO725Qpe9RwDVjw9V2ucHeMy1GaXoHeRLwlJmJE2zobNefigbqdbzJ7BRjEbLNg5KaUDeQEUjjavbqLb6VmmhbbE2ljy/eO67zf1mdMjZtJ7AMKk8eGgIKb23p8jcbpwk0zwNg4Gzg0vUCtGI/YkiEtD6mhORe26q0KIb8qMm7Nk20qCtI2zmuy4c2dUu5ljfHhLkddcANcgmFeeVynGp8A5WWiuLg6M+PdczqkAisZloH/MNiyo7S3kftqlCqxzBkoeA+5o/mG9djs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67cc8f4-c61c-441e-0f36-08dc4bd7e973
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 07:56:28.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lC3Zl91tGPLAA5BTknIibcLaYPiQyxk1WvqPvaAG3z3Hirkul2mJacN2okE5OznK5+73pU+NjiIOtnfOIG3ThQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-24_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403240048
X-Proofpoint-ORIG-GUID: Cv9WWE-545vRbupioXDW9ZNALAtnnqqf
X-Proofpoint-GUID: Cv9WWE-545vRbupioXDW9ZNALAtnnqqf

On 3/20/24 20:53, David Sterba wrote:
> On Wed, Mar 20, 2024 at 03:28:52PM +0530, Anand Jain wrote:
>> On 3/19/24 23:42, David Sterba wrote:
>>> From: Josef Bacik <josef@toxicpanda.com>
>>>
>>> A long time ago we changed the short options to long options in
>>> btrfs-corrupt-block, so adjust the helper to use the correct options so
>>> the verity tests pass properly.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>    common/verity | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/common/verity b/common/verity
>>> index 03d175ce1b7a18..0e5f0d75e746a8 100644
>>> --- a/common/verity
>>> +++ b/common/verity
>>> @@ -402,7 +402,7 @@ _fsv_scratch_corrupt_merkle_tree()
>>>    			# in the default filesystem tree (-r 5) and corrupt one byte (-b 1) at
>>>    			# $offset (-o $offset) with the ascii representation of the byte we read
>>>    			# (-v $ascii)
>>
>>> -			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v $ascii -o $offset -b 1 $SCRATCH_DEV
>>> +			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 --value $ascii --offset $offset -b 1 $SCRATCH_DEV
>>
>>
>> Can we still make it work with the older btrfs-corrupt-block?
>>
>> How about..
>>
>> corrupt_block_value_opt()
>> {
>> 	$BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q -e "--value"
>> 	if [ $? == 0 ]; then
>> 		echo "--value"
>> 	else
>> 		echo "-v"
>> 	fi
>> }
>>
>> And to use,
>>
>> $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 $(corrupt_block_value_opt)
>> $ascii --offset $offset -b 1 $SCRATCH_DEV
>>
>>
>> I will make this change before submitting the PR if no objection.
> 
> Thanks, that would be great. The option changed in btrfs-progs 5.18
> which is still relatively recent so both options should be supported.


This patch has been replaced, [1], is for review comments.

[1] 
https://lore.kernel.org/fstests/cover.1711097698.git.anand.jain@oracle.com/

Thanks, Anand



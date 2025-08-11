Return-Path: <linux-btrfs+bounces-15978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26059B1FE6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 07:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383BA177278
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 05:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8474265CCB;
	Mon, 11 Aug 2025 05:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qXjiHWgx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nad3E4Md"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F752628D
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754888440; cv=fail; b=ukvEbrP9pR9sdvOrELcLY+qg7b1SrPnjU3cnU88rybDoUHuuBbYwJOI3GSDQPNL7hghuQQq+1hrOt9mEx+rT0HCJV9YC+Rg1ULh3XP5w+M88LJCNzK0pwDjzmVin2x1QY8yVZ/tQlehO/ze84f19+1BY+FMXAYikVGelNJhTaPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754888440; c=relaxed/simple;
	bh=0gEKftTrneSijV9nOyPdcDoAx6eAYHGp9vsBunaRUM0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k6XaI7L3YJIVIp4b5gj9hhqHV1w2NhiKAVG4uRARS/B+6u0yfVwvEFjcencHvPwCeOB5ALkBj1u5190Ug5mVvCdlK+pCXGiLGbTVdljIL0v7g3kLvNFAtOLdA35rU1ZZXvJq8ZUs0tNKEoUOwz5bAKKONwYxlO+p+k9Rk0dTO1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qXjiHWgx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nad3E4Md; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B3Nuib010225;
	Mon, 11 Aug 2025 05:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6EJM3C4qqJGCoIaF3b4uLoTW7+k3Z3tMjIknqy45RKY=; b=
	qXjiHWgxcBc4LIw3VE6bH+3SC8FsXk/0bpOA5mtn4ueuoiTS5upJEAfwwcXPpIFr
	YpE724XXn3d7odbltghFfnTehaum7s5Es9CTjPqh08cEDgFPAGMGPvGx+XcuhigW
	nQrHESoPvLW2QSfTydO2Q8TfpmK8PzKssb8fc/d5QGxu3UL6EUbxMYsNqd95oFnw
	ngQSnr7ozubyAuCdPue/oVDD1s9RYoc8Y5AeHw14xDjJvksLe7AngClPfKiHdhKa
	9q1IpCk0p3M17tP4SA5sNZkuCrAdUR5vEDPZehr9Y1YA3UL++fJCwNhYHBuKMKEj
	O45MMGciRb3XbL7u7uDOPA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx49q3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 05:00:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B2uN42038028;
	Mon, 11 Aug 2025 05:00:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvseppj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 05:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCebSuVCFmDEIFiMr+pC2UyNYnObWLqQdhoLTLHtO+fZgAZ2StnZOxOP1Zdi95XOppf6LXuA1m5uRKBy1atXK1zbh+yKOHuirHCofB4ldzM2WBnhunRCvS5rTk2VIxnn8oK+pnz99pfYU+G/y03aFBDCqLCy1wZ36xo11r77W34b0ox0lOLTuhPaKlvvCX5zoYa0CHKzjlnSxs0VqK4JgA7+65Qa2v2eDal/wKZ9/aXwVp0yLgeEZ6y0oNS/qbs5tRISQyqsXis4FFO2i/vY3Tobov5tOg3DlhgDfMP2Osj6pbX1+hppbKnsbldRCibw2lhDfZhOw6umSB9Hh1KWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EJM3C4qqJGCoIaF3b4uLoTW7+k3Z3tMjIknqy45RKY=;
 b=ZbXYKj9jUeA1pZeJaU/suLGo14Gl2SJXU3QSiXq9mDJbfoU1FIgFJ/aEoPzYgsgPZszAj/aBhT3g8eYT7ZeuAlfC0ukLjFlQLc2DDnvZI49vLryuGUK66m3m3gi9kPXFYX2A6V9vTkM8601ridT/hXuyzVwVwtDLjqD3rCW/h0nQu4hEZHqpvWrhLMGizQFq5tHN7eKTTuji1IEffJVeek512A5T49v8WTBhsO3xI3yBF8ztm6LEWtWd73QBYuKTr0j40ZKqMbgO7hhHErTWIQR7sSwozf7wtjuqTZvy3m7Aa2pWnQapK77w/5ZEX0nxM7E4DTLyAoT/5sgIxTP0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EJM3C4qqJGCoIaF3b4uLoTW7+k3Z3tMjIknqy45RKY=;
 b=nad3E4MdsTOE/3/TKWqndgwPyTyawTnWldUC9Hcnq77LHfNRJ8C+aa4xB1Uz+8UtFmW3U2wBc7tpE2dj8I9UU6v0AJyyT4ZnS/4xlOtzLsDxdJqcru8rZCMCY+PNFa+aXtLK1YR9yrDRXdXq4RDjat9lMatPcAx+N4H7iTLM3TY=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 CH4PR10MB8146.namprd10.prod.outlook.com (2603:10b6:610:245::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 05:00:26 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 05:00:26 +0000
Message-ID: <40604a45-4fe8-4b14-8510-f712e34ffb90@oracle.com>
Date: Mon, 11 Aug 2025 10:30:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: pass btrfs_inode pointer directly into
 btrfs_compress_folios()
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <fd12c8b1c7366dc82b04cc702a82703b3e7d3686.1754822695.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <fd12c8b1c7366dc82b04cc702a82703b3e7d3686.1754822695.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::18) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|CH4PR10MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f294ee-0dd8-4ccf-a630-08ddd893fc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVFlKzRUblJxaEN2S3lFaUlrUSt3RlRuZDhhVEkxNkE1TFpYSHhBZ1poeXlV?=
 =?utf-8?B?cUtpcnJ0Q1dZdFcvUDB3eExuTjkveXlETFNGSFBkdDZqT0hRL1E5SzhOeUFK?=
 =?utf-8?B?THBZU1EwSzJSSE40VGVobFlWUmxXLzdFWGJoUHk5NGZGbnNCbFdCanhrRmlD?=
 =?utf-8?B?ejNic2NTNGRKNW9HcTZmQ2NsMmJQeTJ6aXJSVTdJQkZISmFobTZwREE2eG92?=
 =?utf-8?B?Y21uWTFGVWowVW9aZHFWZGdlN3lZNzlRNTZzdVpPdW5uTFlPeHNzaHplK0Jl?=
 =?utf-8?B?TWQ5cVAxU2taY1ZwUWFjVEdGODV5T0xsMDlhOHBWWTd4dng5UnBENzRPOU5T?=
 =?utf-8?B?WU5IbkZ6UkE0NmhIMjRJemQ2VEZKcjFKQXVvZ2JUZkp1aWZGNnV6K2dOQTh2?=
 =?utf-8?B?LzhwY093WmxoSDRnQkxjSFJTaDF6Z1VxOXg1SVdpYTBKM01tTUhOdThRNHFv?=
 =?utf-8?B?RG5qV3lSUE9YOVFkTEplQSswVDFKOU1lQkdmWVZFSWJ1WTdid0JvM05yeUNs?=
 =?utf-8?B?QlVWanB0TEhBQkY0d241K1R3Y2tOYWtUMTJwd0ZmOFJHRlliWDNzQW9Udzgx?=
 =?utf-8?B?a3poRkMvSFZJaXA5SDZ5TmVCcGRuQUZISEd1bVN2Q0JTZzdCdEtoaC83MlRt?=
 =?utf-8?B?ZWxLUzYyd1R0S3dJSjMzc3B5RldSQVA4WE44d09MZHNtbVpUbUMvQXhIa1du?=
 =?utf-8?B?eTNScDhFSTJ1TXNwL3NUNkI3bWZ2cWdhc0JXZ3dOYjBDQkVySXBJR1h4VDFk?=
 =?utf-8?B?STlCUXRNMUJtSllSTmdZM25YWTFicVNzTStqREVVYnZqQ282WVNLNmw0OVQ0?=
 =?utf-8?B?MDl6ZXVTbU9TODZESWJaSzJ4cXV5dEtGb3IxNFREQnR3T29hZVJ1dk5OU1h0?=
 =?utf-8?B?SndjMUY0YllJSGVpL0hHQUgvRjJOMjl6Z3FJYWhPbk1RblMySG45MmRXVjlv?=
 =?utf-8?B?blNDTkhWY1ltZkliVU91SS9NZXpZOGg5enZzajJkT0ZDWnNnN01IUXBETSsr?=
 =?utf-8?B?WUVMWHFrK1FTblFaUkNFTSs2bCtQVDZXNDFKTExDdU8wSnpvZDFTOGFaR0Ux?=
 =?utf-8?B?dXB0NzJxNWwvV2tSZnNvMUFYaE5oaTErRFE5dHF5cm11RzlVWFU2TWJXSDBZ?=
 =?utf-8?B?Z1IrMkgrMzEyckhrZGw0MkJ6WHZuOTFhL2w2R25ZNE9PYk8wZ2UvdU9pL3lH?=
 =?utf-8?B?RHpjT0xvYXdKWlA5WFhnem1QSmt1ejEzVFR4R3psQmZpempLcERKQk1IK2FK?=
 =?utf-8?B?QXVTbGljejJPWmFhTHZ5YnZQMWlOWlljNFhXTTJweEVENUhhdnlMTTU2WGVH?=
 =?utf-8?B?SjBxMG9EbGdEUnVlVzUrdElLMDU3c1N2NlFGUWcwREw3MVN4QVhwdUJLYVow?=
 =?utf-8?B?YjRkaytmZjlwNE00Y3VTdDNZczJsQmxuQlBibHNwQWhUZWpzdXYrbVdQSEhr?=
 =?utf-8?B?RlgvYTlBN24xdzlsVjJLbjNIdU1odVlmdHRUTnl5ZDBla25ER2hVY1ptblhZ?=
 =?utf-8?B?bVQ4azVxbEhHUFdDcXdFOEVvRWZPVHY5RjBsTjI5L0JyV2FrUkVxdUlidFl0?=
 =?utf-8?B?YzNreDh6L2pQMnlQeCttVXVTcUVYK056aHBZTk12V2FTR05kMXhKaVR5OVdD?=
 =?utf-8?B?UDArUjZsSGlNSzhrWnlZTkhFeVJ2bGh1YXJnNTQ5b3Q2c0Q0VzZJQTVvWUNX?=
 =?utf-8?B?OGhPd2pMekFJM2hhUDVLaEptOEhXWUFmMVNEMFBkcHB4QUw3YjRkSkRRdmVa?=
 =?utf-8?B?OTVJcmtjSGdlWmlUbGJxL0EvM2FsOUltT2pONlVtaXpSMUFvcnlxZFg4YXBS?=
 =?utf-8?B?NHdva1IxendTNHBSY2FzWWU4bHRKUjZjbW9yTWRYTTZTUW1ULzhuWkVQS2Ra?=
 =?utf-8?B?Nm44NkV2YWMwQzBZYy8zU0hDT2h0c0c4Y0wwaFpFNnZhUjkxcmhidHJ1cGFu?=
 =?utf-8?Q?Qst/7UAD7/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkpiNHNFak1ZQzNJV09hN2V6VHNQaDMzRWVpQ0FsM1dUdUJTTHBOUFlxMkVJ?=
 =?utf-8?B?Y3JicURpdDBTZUpURkxiMXNCVm9FRTlhay9kT00xY2VreUtNZllabFdpS3pL?=
 =?utf-8?B?cnN0b2hudHNkb2xOQi9aMG9sb2NxZWliR0R2S1VlaE81bFlNbTlERU9wMTkw?=
 =?utf-8?B?bTkyWVJLNkNUMUhTRmZqWWt3czlGc21rclhDTTlsSDBOZEw4dThkcWRWRzhO?=
 =?utf-8?B?RExNZVlKNmxqK2xxcGxScjRmc0FQSitPY0hJOVFhU0NodkJqdGNFOEJmeSto?=
 =?utf-8?B?NlkwYXFqc2JqMzBIdkU0MTRnalpiMXpiSEQrK1pnSERpM0wzOG1Ka0NqZnla?=
 =?utf-8?B?YTZLbmdVNWVzQ0tDR3ZtT2hWSi83c05Kb3Y4cXFTS0dHY2pTWVV5eTd3akdu?=
 =?utf-8?B?elNRMDQ3amNVR2NudUdGWnlHWFBNV0JBQ2RmZjJDTDFJYUhyaFRXK0hkcWZL?=
 =?utf-8?B?M0x6YzhFVU5DbkIrc2RsQ0Z1aG4ybVdnYmJxdVBSbVIwdGFlOUlVQTVMTk1U?=
 =?utf-8?B?eXI5SDFaTWcwRENZSlNwcUJKWSs1U3Bucko2dlRCVUtrRCt1aEcycGNZN293?=
 =?utf-8?B?SGlsZTdpellodi9jU0dGNTFNTC9QVDVyUFB4cXNKOFlMUDNIMGsxRnMvSW9G?=
 =?utf-8?B?SnhKY3kwM2VvM05nSWFCRFdQbTZreHJhMVJtMDlkWk0ra1lJdm83SlZQRzBS?=
 =?utf-8?B?ZllSY1NtZU5yZHFsaThNU0NldjlGL3ZaZVBTU0ZHY0MwTm90cmhDQlh4dSs3?=
 =?utf-8?B?aFRwakptR2J6a0p0ZUlzaWtoclVBYTBuS0ZHeGkvZHFQNEhUMy9hRnJKYjBh?=
 =?utf-8?B?RktvVWZKSWZ5Wk5DMFZBeVA0SlRSeXJQTm5ld0xOckk4eDFWWE9JUjFqWUJC?=
 =?utf-8?B?YzNXNUxOMVR4OGI2RmlwQzhzS0tZbjFYK2tRSllhSmVLNlRhdmtudmlKME9F?=
 =?utf-8?B?QklVSVdpN0sxNmpZYVpYcGlGdUJMSndTWmk0OU9TUFlzYnNGam53d3VoeUIr?=
 =?utf-8?B?UVl5cThOaUVoVlZNNTFWMHpuVWI1eUdTM1VPeFcyeGszcU81WjFPZ21PMkZn?=
 =?utf-8?B?Rmc0Z2lJelhBYjZuZjFiVHFjRG5EdzFiaDI2Z0d3UW1TNUlPeDNWT2pncDVo?=
 =?utf-8?B?RzF4VjlKL0RLMDNTQnBRRElSYTFndDBHT1hhV3Z5dGZQMFNMNFZqQXpNaEtR?=
 =?utf-8?B?T1J5RC9GZFRzVlRUeXdMUEpRb1ptMEQzczdTeVNoN3JrSy9uZEFzQXZ1cGF4?=
 =?utf-8?B?dFVMSU4rcmszMjdaa3FJRjNiRzVqR2FqajZVTFRNY3o1SnRrQ09PZ0J3WWlw?=
 =?utf-8?B?clZFZ05hSHk1a0hqeUkyTVFNYjVHRUFxMVd5ei9XdUJ6bEVkMkJPc0kxN3R0?=
 =?utf-8?B?Z08wL3lYWlpXK1k0WFFEVEpLK1pyUndzTlpuUUQwRXlGMHhvMFpWbmxZb0J0?=
 =?utf-8?B?VHIzRDRxdkZiUndYOUFaeXdxTFVSNzJxTUJxSFlVWWVha0lEWlNqUXRhUkp1?=
 =?utf-8?B?Y2lORUR1dnRXMkFkVVdqQmZlUGRxUmk4L3hxL0Y1ZWp4UTRxTk83WHM3V01E?=
 =?utf-8?B?dk1aTHljbWZrbVd0b21OeG01ZC9uOWhwZ3VtcEJ3ZXlObXJ0REI4VDByWHR5?=
 =?utf-8?B?dWNzYU5BYTM4NXE2ZUZoMjJlN2JheWNRdWZSWFdUV3Rkazl1WU1UelA2MXAv?=
 =?utf-8?B?SGVLSkhGZENRWEJ2VUFTRzZ5L2RZRmptOUZoaWZvcFNNa1BOR0cyYVpFYkwr?=
 =?utf-8?B?dkxLNEdudDU1VFBTaFF1ZkZ0elFBNmJoMyt6eS8yVUgyQVQ4ZmNBaUhYeWxE?=
 =?utf-8?B?Tm01Z09HaTlkMS9IOGhpZ0orYVZ2V1d4a1I3a2FaWUY1TXc1ODNpVmJRL3FL?=
 =?utf-8?B?TWNjL1ZONjRnVG45Q2l1Tzg4MTV0ZmdBaFZvM3VYRWZFZzBFaTVkcWdUWXl2?=
 =?utf-8?B?eHVnQzFhL05JVHUyRFR1anFWajNmQUVaKzNMdjVVSUI4cVErUWkwS2cxUHpi?=
 =?utf-8?B?MGV0ZWpjL3RkajVWSlF1M3A4TVdNWFVXWkl3amtSYURiY3g0QUgrdTNVMytn?=
 =?utf-8?B?RzJJMk0rQUFIckJGaU9KamVCOFV0OGJyTzBabzVsR3JHNFgvSTZQdFRBempj?=
 =?utf-8?B?NXJRQ3NYY05PbGxEUjJtNHRwclY5NUo0S2xlb2RSQkhvMHM5M0dNb1BFUGFQ?=
 =?utf-8?B?dGxFUGtwTnhrWXYrSTZXb25IVWZHOGIraFg1NW5vNGJuVEpXNzl6dzhIZktG?=
 =?utf-8?B?RklDR1Rod3p5Wk1ubjc0b3UrQXNRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Z1k5UkHGJun7GBLXjiTdpY86UAjvJ8NJnHvmSSmEQBqwPTcfQhtDrc6NoUCT/MaKZIMSDKe8Hc0jwjSiCyiBT4WyLEqJPSEsexjv5m0QCoszdJqt1m8H6o0daBQx5YkV4sS+hWv7gV9UevU/4SXvt9q3bRJ9tEEjgThKkmTdRXNhzeiGZqlskPz3vsc8zsHEzJuLtY831u9D7icuHPeIEG1mXibRKPATxKMshXk6h2WL+HTcBVk+F6v6zsmW02ZPVV7SvYPcMStrozwXudKz32PAHiTXhr/7aJAkB9rj3wMp8TDnYencvCNP0Fvm8ioUsIoVq3tLGJoh/OVnTiW2G/nQi+Jsr/2DAAA6ZLtAFOGXCCfoV+6GUMc+NuwFjoDdTbhP7lWuaFIwcHTLJfMRcOMSMsgLTQjfMPWCS3S76V9c28XZ+5lZvYkSiYsaZslQwmUb+VYsvxsUX0nhmL2MRHdr4xyvbcwd9vLFweqf59QsBY2MZtEDMoySx88KDzQtkLhocXYR7HYc+2rwMdVDsEyUlsDgB1GaLuneDslHiwr7oulVxu7k/SPIMhVihkH8u1mB7IVyhSJyaxECcJ96bn7BRwz1xC+RQocVGmNHLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f294ee-0dd8-4ccf-a630-08ddd893fc24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 05:00:26.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daVaKIJvd0NjMe/RccdrQjkf267fBaF6vEjUaAwE9ilALRrFrurXg9dQflPNdrYhCxE9qODuADEu0IJ1M7SCJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110031
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAzMSBTYWx0ZWRfX5REWrx9ahoZi
 RnJc+97PEAk9tahX+mjuaizjIPA+Jb8w06/LvLRRO2WVvdqJ8QU6NAmpZ0N051uiwS05wOxV12u
 VT0FT/2aKHvM1yvvBXF2YvDQvWgmnXBSUxtCij/uxr47AjbBqpt0QYc5CjtWC+RRtvYu5ztLe1x
 7YGjn0/tTFh/MVnS+U76tDpt5+cNDcqZaC8jAagGQZr3MAIXro+kAFcJx7OLni+HESuNSdddtDk
 araUmPvlkdI2rAPm0hfq3lN0ZY0hI6yWUzOQUViEOnEqSB20e8Ax1rZX2ONoagjEpACVetA2RM6
 zZcsku0K6oTS7+8j7V60kR6jOu65wOTv1rBGZe9evWhClGWgybXORYzejMvFkVOKq9I3c5GbNj/
 GxkZrYc8d2+wSJChO91wKIlLSZjiBIgOmCU6Psxm8i5Y8FaLHq2kyWYom8/sgdpqiMlh+oW+
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689978ee b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Sl0tNDBd8dkG4Q9Ej6oA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: AA8DlnY6SBQ7CEorpKFK5DdTwVAPrQ33
X-Proofpoint-ORIG-GUID: AA8DlnY6SBQ7CEorpKFK5DdTwVAPrQ33

On 10/8/25 16:14, Qu Wenruo wrote:
> For the 3 supported compression algorithms, two of them (zstd and zlib)
> are already grabbing the btrfs inode for error messages.
> 
> It's more common to pass btrfs_inode and grab the address space from it.
> 

per Btrfs coding kind of std, it looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx;




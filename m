Return-Path: <linux-btrfs+bounces-4395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87B8A9391
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 08:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3D51F21CCA
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E49A374F2;
	Thu, 18 Apr 2024 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LseIVOqf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SK3pXYvj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF3F9E9
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423335; cv=fail; b=NmahXDrsUO+lJblGdmktSNDvcHTZqoGY8Mh6fFBORJL05EMXYARfRuDzsspJ9e6vA+gpZ0fv8ILnX39YoLo5jaqi6xTNi3syn9vdSsjZ27QOkdGHRzVojKJD5xVqGzWXX85V5MkuYdDDBUtlycI8PKcc8N+1URVHFavSrzp6bLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423335; c=relaxed/simple;
	bh=MPfTOFcwqicO/oHvvVbXhmrxAaB4UtrcWTOXf+wSiR0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oukHuWAB3NdM62rOAoICwAGvidnsevpNdtEZI/EcXKbKmhBvtD8RqniylsijdYLXsqHnfqTTs2Td2y4lgKFVPvYyqJjQmyrf4gJNSEEe0OXdWON4EYhs/jty8ssOfNnO4dgKoCZGWtygr5KwWcu4HL0eswCfZtXXqD3Df6pzgZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LseIVOqf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SK3pXYvj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3xjlM010681;
	Thu, 18 Apr 2024 06:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QPHaOTauQLpIAxohphOSlixJ8SWiDEfHPzzUYnTAHH8=;
 b=LseIVOqf7RBcbgT3AA35qY+lWLvL8So+L+gwL5y2qJzN5yqFZWf2KbdnMHkWdeoCe3OS
 2KniUxV/6I6N869qsUMQEQKrHdyNepQ84uDe6zSgyho6bg95ZyiRmg5qyVt4k6ekRwDD
 18nswnUsY079eWlumlCHLZvqU/eF5w63Nm+4mkmsdpI9llDVnNMsxB15n69UpwQ+Cdy4
 O5yh7QfZHbm1V7RvkmBSHnoUx363+o+28awrDGRIemDKNwDnBTjuU2Ov3EKhxkEfeHmL
 i/7ZqLk/Td+bS9bsk1VNo+cnYzPjkLKGJOw2anRpaxKbOey2p9ooCTGjVf9Ab56AUUSF 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv9jen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 06:55:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I5UZe9012596;
	Thu, 18 Apr 2024 06:55:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwj2bx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 06:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR233uDgW7S99gEXihE7sTHT56/hjpgdD4dPkMGpiEoaKfsMlvzAby6qL9fRzPeLrdy2trnCdADMbT93ewxW63pfwtd3XE0d1ijlU8ZtwmiupnngdJgUCOf35Kvia+tEcvqFFJZaaebsMItGPmfx+SOE1uENPgh/oTMQ9AC59uSPAzDW0JPiVGFDYEY72C2+yGYor+y1hkoIg/f7LtO892pSuFYlR6XY2jx5/PfoW8hd4X2dQq17jAdlznJZ21fv+s8kWOYsOQ4+YaC7aUqsrX5udGZVGadUsc706yxv12a2BRuVXJE3IvnjwrRGRT8PwNNb91xmN9IQhSm3284QRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPHaOTauQLpIAxohphOSlixJ8SWiDEfHPzzUYnTAHH8=;
 b=b01W8jm5wO3SRdd7e7X4FnUwCAEQXqgnvibSyw0mEy1yAQ04icfdAKWOGKA/FRrBZyobqJom5Ne3xlCUQGW+VLzfVB/tiOuKB2iNozEmBRRhzHoqSpsNZRBPAJ6SRSDY+UVXrLJEJRgYvAw2xTFORS+/3M47Irfc7Jf4UBZZ3to9WKbV7Jw7xA6NuOWFkFSzoH0A0cPZdB3bKgoXDHrsZtqjpwhdjbhUf/ECLyyCel011DF5RKY1l6h1k9bdlmyZMB2IKEXhJ8OJVDZaMYwXNGPj3glauLZFEU7N+UjFxPKZHBvHk8SiH0PDDXLCK1QlCtoJzv0ZXOBsbbafWLec+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPHaOTauQLpIAxohphOSlixJ8SWiDEfHPzzUYnTAHH8=;
 b=SK3pXYvjt/I8Eb17Vc+X98tIFiDTAa6ZSKoagBHwI3XVeJQhB7mcZGOOMpdW1HcQzvMvrqBZV8FOvQXXNIVBfdntdPHMGyr4RDmFXnMQKp2dtsZt/sEWWeAQwz1WCPgpy/uLWyLrj2Dp4DkPOkilfKbU86O8XON+M2v4d+xY8A8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4314.namprd10.prod.outlook.com (2603:10b6:5:216::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 06:55:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 06:55:28 +0000
Message-ID: <5b7b9e74-c5a3-4de3-8307-48951ac8deef@oracle.com>
Date: Thu, 18 Apr 2024 14:55:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/29] btrfs: lookup_extent_data_ref rename ret to ret2
 and err to ret
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <3dacbcffa8d7c4e70e934b8b977676a1072878f4.1710857863.git.anand.jain@oracle.com>
 <20240319181720.GJ2982591@perftesting>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <20240319181720.GJ2982591@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 983ea74c-83db-4fbb-2be1-08dc5f748836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KoRm5p95osY/mc87Zc+jYO7DfX/prIO7I2tMvrgKO9MfY+I6e773dqqjCDCavko9mQb7yfSEedjCJWuPU0ccTsPcxAETJrpVTbfP3sVsT1ZAb6IweWE++5HVhBy0VUyv8omQptGvbVnVJs8E0xx1lesIfSOniE5JTETOBjfdPTKWa8/2lHyyJQvubQ8qDyVERm+94u9WqkEgDaq6tBmH1Hw4TdQF6AIyumELlB7BtVfeoOWv/sv76+RLFIN3bxnJzykjsCwpzhMTVL+x+OlrZO0fsErcns6FFerRRsKlukrtEhSYqpnMPsCDaxko7um9SBM2kBSjpbZNb0tOruxj7TyFEC3XDp6KyRAyvIJw/nsmSZmLJ0XFeaiwldkAgP7ttaOjv1JoHJA/Lb1Kc1N5TUNvEqbdaBuucSf2bJnSvWxc1XrwoCX8CSPE1w9uYmyWaB5wq1LwzhLs8mGUviXKjHEBJzz8vFjr60AeN+kebSWOWBIvCYqEH0ateK7mBQ7qpAHBMlZ6WXTLgfP91xAz5lKnzx3KzgOdGxdEA1qpht5y1hGO0eX+ZhJggx0r9t5ZfIrhri7hTh5DtOiTh4Hk6TihgaYaQNHX5qBx47qwY2w63l1UXaHPP83FHoAw6hZQmKMYJX8t+ui7VceQ/0U++8FUbLfvDVDXoVRziP/lnm8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXFJMWFPS0xyVFNUUWJyaVlWRzhMcEl6WFF4V24waDh2blpKMktuQUtvWjRM?=
 =?utf-8?B?KzhERjMxam1xTHdVWVVIenEwdTZEMUhSSjNuckRUZHh6dHhTK1lRZHdTc0Yr?=
 =?utf-8?B?RStBWFU4TUI0Y0NPT2pjNjk2Kzl1SDlMRm9MUXZqbU5DUFJRK2IzNlZycnY4?=
 =?utf-8?B?cW8vaWwzQnBRMlJwd2VYcDlxbnczaTdtY0QrSEtkLzNCTGNYaEZ5UWZGdGJt?=
 =?utf-8?B?M001UUNadlIwUDlPVVJlUXRhQmpwSkhoQlZPK05DQzM0bXk3cjdwUFVhZjZt?=
 =?utf-8?B?cGdQOE0wdHNWZndPQ0FkbC9pOElCUG95eEl5aUpWcksvSzZyM1hpaXlyOGZt?=
 =?utf-8?B?Qk5DL1Q4MUVKTmZvNlFwWHVaOHYxbkQrVzZLTFU2VUU3a1dRTlZxdDRveGpF?=
 =?utf-8?B?VFE3dW5XWUNQSnlLcm9UQWJXb0ppK1d0Uk5TZUorR0R1L1VvWW05dGxVS1Ux?=
 =?utf-8?B?VXA1aU13MUdxbm1JRGNIRHBaT0hsaDJoNEYyV2daSjBWZm9sRW5SOXUyTmdn?=
 =?utf-8?B?VllrbkJsOUtqcEtnd2Q2U1pzSTNxMmhkSjF5MGNuV29DY2h4a0lXMllWeDQ1?=
 =?utf-8?B?eXVGZEhuSVFGVlp4RGdxSXBKUG5vWVJnQkUvVGdDZ2MxbGNRRkFYZ1hiaGFO?=
 =?utf-8?B?ZFl3Vlh2d053Z0NBdXVjSmZpbVpxbUk1RjJibDdYS0lxS1pzdTBlSTBTVWNq?=
 =?utf-8?B?WHVSY3d1YXdOc3ZJZk9ObVpOQ3VoVmFKQUNDSUVVY0xzL3lZQ3RxcDNodldj?=
 =?utf-8?B?UW1GZi83NU1WOERhb01FT0lDc20wREJqWFF3dDVRNUtVRWtHc0NiRnQ2ek5Y?=
 =?utf-8?B?OFhwS1NCeVBpYTdOcEJBZWNGYmxXbjVFREw4Y0J6NEtvbkFsNXJDem1HTXdB?=
 =?utf-8?B?WmZoSS9HTlc1cENHTWFCaVFKZ3dlYitRbDBOUE1UZ3dnVW82cFpUK1psdEdK?=
 =?utf-8?B?aklxRGRvMUlZdTBSQnNuM3cxV2dFalJIK082cEM1VDRaTUtGaVRBSktkTjRK?=
 =?utf-8?B?WFFiOW1QSWVMdDhjNmdpQ2NTTXZwWGhrcXpvZGtVUG92N0NuVFcvbmhqNjZh?=
 =?utf-8?B?NXlQMVRmMEcvRThJK1FOMW5oQ3Z5cnNMMmJwNDBadjBURm56N3pEb0s0d3ZT?=
 =?utf-8?B?VHlSUGR6cUtSZXEwYndZVWwyY09VLzROSFpDSnRnL0hBS2pEZ0N3S2w0cDZO?=
 =?utf-8?B?dEFMM1pSQ2VycEhFYVA1V2tjU1BodVhaN0VoMFBDeUJyVG1FY1ZvekVHeTdJ?=
 =?utf-8?B?dmJtaHphakcvZTVGYUJSYXFuU1hzbVVFcElFYXpyRXk2SStFRy9VdXUvbDFY?=
 =?utf-8?B?VVdWb3BRY1Rmd21iV2g0d0o2V1FKWVhiVnJaMDZiekFjK3ZuMjYwN3FOU3BT?=
 =?utf-8?B?MEo0cGRtS2pxMTZub2E4NHc3cUdtc3FpbW5BUXo1YVhIM3VHc0JKZ2VHSEI5?=
 =?utf-8?B?UCtlNkY4b2FYL2lnbmF4aks1VGdpVWZxdnlqY3E1dmRmc2VCWUNkdUo2T3lR?=
 =?utf-8?B?ZnNIQjU1azZGV2hDNnZEWUpUbWF0YWRsZWE5dlZSUHJBUStWS1lKYXAwMUhO?=
 =?utf-8?B?dk4rYWhweW4vdXN6YmhOSWIyYzdxcXRLckd5eDNEbWdUVElXWUxpWEhqWjlu?=
 =?utf-8?B?VHNGenRJMTFDcTFYeXowWFljOFVUTURkaGxFVUFCbi9oNGJQMG01elgyTE44?=
 =?utf-8?B?d1d5all2ZmdnU1ZxVjd1MjNEK2IrWWJQOG12NFJRbWF3WnFhekY4a1FYN1dY?=
 =?utf-8?B?K0pJRUI5eHQxcngwMHR5YmtkRDRWOEpabVZ1ckJ1dDVrMm5BRUdZQjk5d1Yy?=
 =?utf-8?B?eXQyQmJBOEtzVnZ5NU15NnZadkt5dFc1Qi9ZVzdOaWR2cW1lcGZHY2VXck1v?=
 =?utf-8?B?Y2w4MkhtTTZMdWVGTDhmaDcreE9EL0NMWkU4eVZqbk5GOVlUUU1NeEhiMUJ3?=
 =?utf-8?B?bk1Wc2dvanl6c3NZd2FKNWVnUjNSaXNacXRzbzhyNVJONHdUK1U3ZmRFYVlu?=
 =?utf-8?B?ZlQrQ29veE5sNUdJbU1vaS9XRm5sd1JZdXhCSENaYUgvRmxiUTFtVk5NcG80?=
 =?utf-8?B?Vk1DN1Bqdkc5d0JNbC9JTlRvOEl4YnF4S0hZekxDbUpSWHAxT0JINkJoV3py?=
 =?utf-8?Q?Pkeh2QT8HxlJuLon8qJ+sHGz/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fD+wXP6cOVaoBRql+UxoAW1PgYD4xruGThKr7NBe5tZWGx/l6t5mjvNxxBhKn64vvg8pBiACKJrTFtIgHFOJGGZmIa9UeXT95ljQ3R9Jdh+0+RXajWZk9Rv1NHS9a8rVhKdzJam2opHEyK939vu7zsE+3yrZMG/fgr5iAy9x2rwAT+wkr7dNEXjgAfF80Zstqi1YTLNQKcmeG3RDs1wtp5wQ6HSkvEHIjUACDxc9BfLle+NC8AJWKnSa1LGyk5DLsc9jQdL+1APc1fIJhOJ8v+nehrTC2cIDdtqfR2/RD5TXcJri/3+IMPljTQW5z3w8KmC7yvCAgoa+27UCPdWDJphx3X4rMXqrpYg6qqpfKgDo3JiOPNcDb9QKNdBKZq6jktPBWw2/Hkb5nQKq0FGRdNhn5QT5XUrXhErFG5pWgJwmgFoykYBLen/VjWryBQzrfhwW1oQ1iUzZSfU3Um2Czq9fGrPP1NAP4XmfPKPD1Md2IHQQzP2t5hegS0dStOy+7B57NWC524FPUmFUj9a1zGXtnaTLkOiyZNyea3o170V58Rokc4lmMx4I+omUrbHuPrVrMCj5lx0WT0Vci1Y/d11V6QYMmstS3ApPAvGOsik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983ea74c-83db-4fbb-2be1-08dc5f748836
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 06:55:28.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLymlOxbNqulqrrbV3wCAFXRoU8ExspUMAQbbyx/W9jBzXRIDmfb4i6JJVwDkNfcXmgIClM75IiFJ3IM1Ou7jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180047
X-Proofpoint-ORIG-GUID: u4KciyYjMBInMVrc9AirNDg3ye329qiK
X-Proofpoint-GUID: u4KciyYjMBInMVrc9AirNDg3ye329qiK

On 3/20/24 02:17, Josef Bacik wrote:
> On Tue, Mar 19, 2024 at 08:25:31PM +0530, Anand Jain wrote:
>> First, rename ret to ret2, compile, and then rename err to 'ret',
>> to ensure that no original ret remains as the new ret.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/extent-tree.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 1a1191efe59e..4b0a55e66a55 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -448,9 +448,9 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
>>   	struct btrfs_extent_data_ref *ref;
>>   	struct extent_buffer *leaf;
>>   	u32 nritems;
>> -	int ret;
>> +	int ret2;
>>   	int recow;
>> -	int err = -ENOENT;
>> +	int ret = -ENOENT;
>>   
>>   	key.objectid = bytenr;
>>   	if (parent) {
>> @@ -463,14 +463,14 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
>>   	}
>>   again:
>>   	recow = 0;
>> -	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
>> -	if (ret < 0) {
>> -		err = ret;
>> +	ret2 = btrfs_search_slot(trans, root, &key, path, -1, 1);
>> +	if (ret2 < 0) {
>> +		ret = ret2;
>>   		goto fail;
>>   	}
>>   
>>   	if (parent) {
>> -		if (!ret)
>> +		if (!ret2)
>>   			return 0;
> 
> You don't need ret2, you can just rework this to
> 
> if (parent) {
> 	if (ret)
> 		return -ENOENT;
> 	return 0;
> }
> 
>>   		goto fail;
>>   	}
>> @@ -479,10 +479,10 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,


This changes applied with the reinitialize of ret.

+ ret = -ENOENT;

Thanks, Anand

>>   	nritems = btrfs_header_nritems(leaf);
>>   	while (1) {
>>   		if (path->slots[0] >= nritems) {
>> -			ret = btrfs_next_leaf(root, path);
>> -			if (ret < 0)
>> -				err = ret;
>> -			if (ret)
>> +			ret2 = btrfs_next_leaf(root, path);
>> +			if (ret2 < 0)
>> +				ret = ret2;
>> +			if (ret2)
>>   				goto fail;
> 
> Just rework this to
> 
> ret = btrfs_next_leaf(root, path);
> if (ret) {
> 	if (ret > 1)
> 		return -ENOENT;
> 	return ret;
> }
> 
> Thanks,
> 
> Josef	



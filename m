Return-Path: <linux-btrfs+bounces-9800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE889D45A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2024 03:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEDF282F38
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2024 02:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A287080D;
	Thu, 21 Nov 2024 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fFKBv+hM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hlAxnOuw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89D23098E;
	Thu, 21 Nov 2024 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732154679; cv=fail; b=kKhL3fh/eRAa8WiwG/vfyE23JN1ZBrjl7Pn+In0E2Z2oAFTlMZUrQcZJg2w5gONjDrYdS0Q1+COBEc6iNYf7qUq2vmPi7ft4r1b5pxLoWYtA09ENu9eCfIAiV4rrlVH7nQgxpjc1ILVIF3lQjfXPyl7u46rRgA5AU5NdJPeYs3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732154679; c=relaxed/simple;
	bh=gleMpaGBXNjj3BYkn1rI8JWjNqkAcG7eisT7wuoDYxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tpc7fBvNSSlm6kxqFaw+xv5c7iMoBn2aXZwNwSqu6UilrobkUG/g8sZc+KeDg8WepE9AhlpcajQKUn0KE/rXFtS4OX2yRG9GncRdzWgxxt7ANjwYLzhY/lvAdvZ5v4JF2R6GqTY743pNLNUF//d092sVI2ZNwZJDlnS9qDrv+YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fFKBv+hM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hlAxnOuw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL1h7ad013798;
	Thu, 21 Nov 2024 02:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jDM0RENuJdhwNYePEPQRKYOwHSLA50whkLlLFz060Es=; b=
	fFKBv+hMCw40PAYnnML4GRNBzHMAHgwk+T16O0Sg5iAa64Sk4+fbXCrjgMyXxZnn
	4P5ONo0aF0W2TvECX3uOsi0AivoC+DpA8nFw2o4voGce6iqn3WBrTCzXzEdFCeJI
	vjX10Uwhsf4TQ2i/AoH2PveCw5XRI5rp8bP8O5VMfja1ERn8avrWtlk0e48QclCq
	DoEDGdzT+r3dSnoXTP8L+ZMAiP0Va3VV6KZN4TclwyiHy/OgVTLiS9u79OIdPC3f
	biijlFHyD69/G5E3wNGIW6UFSlrRoDzjhEPS481vIpgRP7aSaVrHFNybue64L6i4
	FtLd6L5MArpUGSABu0+zxQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98rh3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 02:04:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL0MLMi009039;
	Thu, 21 Nov 2024 02:04:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhub50e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 02:04:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERGxpsgy4T5r6EZZP/9w+ytX6MnBHW8P5n/nSipWkU2T9QFv6Zc9rJCsgEoGybtj9X0Od9gGW2F/XckNnOUnnrfHMx6PT4ZDbrMl0XHG1keekrE+MWSQU11uin3YeoHxUT/yq9J4W9Au3Ra83y6iOKny99wEVCqEdmGH9F6fmBSGDrb6I4XVMr8+L4lFCe1c3TtJSZ5F3178wzqAwegNIS1lxwNdqUj2Is2dG/aOERGboLoJLoziYOBNzFLnALEGCmcx9/AyKqdrdwqDynWAeSwQS2tHqvK1sfVyJTjeaYZCG1VEQBcJluAV0D/3OIDnrLj78K6LTqjXCxAJWJIRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDM0RENuJdhwNYePEPQRKYOwHSLA50whkLlLFz060Es=;
 b=m2zfq6CimmoDLX/oVtFTED2Q0891vEE5/fv+swtEtHx0qbimP1ZqPkbmYFJmFBs3EfRidEd1od8RdVl0dXgv5gk1k6tAIqnj7baZFPh+QTzL6Ju6s/IZqj9DWxQcg4i5VxzmWOOl3EmwieMcWiEajL1hHe00c82VMflo1lPiAKh8xDfnsqxA1M3CSLaCovTOI2xxwQZVR8CePJ+nJMaxgM9OuSjK/fo1u0OEalIRE+5J8YX2PhbrMMb5IPMpYKDIGy9rN3eOb6coRZ/ZdQQfqJUsuD3gewfGeKLLZ8ISoHxb8DVqYsh++SFyoti/JDmqIpqibMKSSomRstJeg7dPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDM0RENuJdhwNYePEPQRKYOwHSLA50whkLlLFz060Es=;
 b=hlAxnOuwLP9WRpd0QSJzdmMqTkIaPd2FqOYdsOnqAdRoYzE1nuisKE5FRbsqFWdmZjqCUfvUzDw5aneFggS8ahkhEVgqXQvv8FUvYmKCCYgS1vtphee95Z3oExWl+jr5MwKGVWXTrgh8Ibxv0PjzmOyARxmSCqzTpIB7rlRG1xo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 02:04:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 02:04:22 +0000
Message-ID: <0500bb1b-0fa7-4daa-97e2-cf09127cb9c8@oracle.com>
Date: Thu, 21 Nov 2024 10:04:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: fix blksize_t printf format warnings across
 architectures
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <c4847cd94f86bd98fc563f112e177b317dc21111.1732102551.git.anand.jain@oracle.com>
 <20241120162824.GC9438@frogsfrogsfrogs>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241120162824.GC9438@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: ebac104c-72db-43fb-158e-08dd09d0d0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTFZaXdMZUlLOVZ4UGp1MVRmZnNWRjFrR1dEWWxkRzh5OGxQbE9yeFhOR05Z?=
 =?utf-8?B?KzlQVVk4QkxKTVExUmVUZ0p0bTlnMktRSlVCTHZnZ1BLZHFmSk1wRklWc1hZ?=
 =?utf-8?B?VWcwQk1hNE41elFsZW5LU0Y4RUVudDVZZmh1RktQbE5lWFRmelA1Q0dpaVlj?=
 =?utf-8?B?dUNWOGoxY1RpTTB2ZlN2MDJMV0VOMTdITDVxWUV5cDlGWmJPRm1KSjV4L096?=
 =?utf-8?B?V0F2c3FqK25uN1pRTURsU0F1VzhnTXNqSFZRODZwWUZBZUR0Qm5KWndURzBn?=
 =?utf-8?B?T2IyQlhLSnZrQ0VwdUhsZlBuRkZXblMyYnRJNis3Q2RJMmtsUGJIYVNkdTNz?=
 =?utf-8?B?czlDd1QxOE5MSjBsQ1JGUkJIaEc3WGJoZ3VtSG9kc1Vab3cxeER1M2lOTGlK?=
 =?utf-8?B?dXFUQVJWWEdQbWpCS0k5U05qTC9yWlZwNFZqcHRUeWMybXIwUmJsL2I2WkZM?=
 =?utf-8?B?VXhLc25lYzdGNDBZTHh1UlVxa1Y0eEhueVNUU1hoVnZrMS9wY0tQQjR2MWVz?=
 =?utf-8?B?c0RmNUMzMzBXRUVKQ0ZvMUx5dFJLdHM4dTFlTWhCeXl4WERBVTNEbzV1cHhn?=
 =?utf-8?B?MEttNHYrc0lYSy84Q0xDVFJRUkt3cXAwQkpGQS9wL2xmQ1dDcjdsZmt3YnUw?=
 =?utf-8?B?ZHdvd1dDek5wRmN6VnJMSUVVNjBtY1RJaEdGUmdSbTJRTVV4RGtxb1dGUkFK?=
 =?utf-8?B?ZDBUQVhBMTNYZ1hBNGNKdkdXblMyL29UdjJwTjJJd3l0ZXVXV0FDeWJSeFFa?=
 =?utf-8?B?N3FETUpaWHUwc1dzVnBiNnM1SG0zamwrT3JCdjNrK1JLcjZ6cGw3MEdrWnJ0?=
 =?utf-8?B?SHVvYkd5aytERVNObTVTRFl3VXVPWDUzSnpHQU5VbUpGSVh5Ti9FdjlGcEQ3?=
 =?utf-8?B?U25pTC9CdjJDOVp3Rzk2WHdZSFBOU1lVekZaRTd5RC9yNVdBbW1TRjZaNm8z?=
 =?utf-8?B?VXZKOXFXZUxYT01LZ3NZWEtCYlBHV2pHRi9WRy9KSU5icSt4Qm56Y29QTG5K?=
 =?utf-8?B?a1JjWGZ5K2lkUm52RUxqTklvWVRTTFJBQ1BkRjIyWlhPazlTcnkzNXVobUFp?=
 =?utf-8?B?REUvMDdST3ltWnlXREpzWXYrZmRteXZ0dG1wTmI0Sldua3pHbnphMDE3UmhQ?=
 =?utf-8?B?c0xqaXBDVGptbTJrbXloWE5hS1hRU3NrUThmSDhjSnNrSUJMSkV6UFpvYnBR?=
 =?utf-8?B?ZkU0QkNEODJkcUxobWlMWWsyWEhEUnNyK202c0JUemFaMGNjMXRDSVhTcnhY?=
 =?utf-8?B?RE4zN0RhTVJrZWxGNGdSQWlKQVozdUV2MzI3MDJjbGJ2UXpMUUxBSStlTHdq?=
 =?utf-8?B?Zm45Wm5HOUQrS3ZTUGg0ZXY0K0syYzRoVHRWUkVZYWpJd2pmdFVKMGZYYTlL?=
 =?utf-8?B?MTFEZzZ2RTQvZ2xnU3g4b0RyT2J3V2NsTnBHS1JBQ0dJQzJoU1JEWVZHVkFz?=
 =?utf-8?B?WnMvbjZxOFhWWDZ1aVhtM0s2SGdTRjFSWmhNZHNaZzRlMU1CS0E0dDJCakV5?=
 =?utf-8?B?Sk5TWTYwUEtzaWpYQk0xSExuT3YwcWRCajcyaXFlalJ2eUNxaWo1SnhlbXkz?=
 =?utf-8?B?eFptNjBZQzZEWWFGQnNyZ3FidGpINGhpVzhUc2YwQ0tUUk56Q1FBVlpZcnZY?=
 =?utf-8?B?dHRheDJBQWRGcTRVdFlKdUFIYll4UHpXSGlCTkhZRTZvb3lyT2NEV1d5RU5O?=
 =?utf-8?B?dWlwSlFmbXFtdHJQL1JUSytyWms0NjRsSE9VandkL0JWZ09sdUV6ZXZkcWVa?=
 =?utf-8?Q?K5QQCkF2NEPRfeY4uOfA4eWkAqfp+wyuNQMRcnW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzVsakVVbVVWb1ExcjlJRTA0SWNtVi8vWEVRaUVvZHdZaUpUTWxjRk9CRU45?=
 =?utf-8?B?a2RUdHZScHV5UTNpRXFTS3BuWkF2MjVQUkZZb3oyZHN5R21NVDFWNE9ZYmxP?=
 =?utf-8?B?T1h4R2VvYnY4ajU5TjlvR2hKSmJsVjlqbFRQNWU2Z281RjFsZ3MyUWZUczRG?=
 =?utf-8?B?TXN4VkxQbFpVcFhGSXQyZ2t5UEcxWmNoM2kvQ0NCZ0J6OUFvNUMzcjN1K1Uz?=
 =?utf-8?B?V0JGMG9WQUlzUTNxQlMyUmo4THl3WjFac2F2VGpBcGVWWldwRDlzY0pYdVds?=
 =?utf-8?B?TzlVRW96bXh2U3llZmUvVUhleENWcWo1WnJCRlRja2I5eVdxQ0NTeUhkN1kr?=
 =?utf-8?B?K0NURFRWYjBtU3l4dDVydzRDRVhDSVFTcjhOcVNqU3ZSOENybEFmME1aTkxC?=
 =?utf-8?B?Uk93NVhDVVc0UVhjUDFYWlE5NjAyQytaMlc2VmVOV0haMGZsci9ackV1MEE5?=
 =?utf-8?B?OElGaFdEdXBnc1QzcmFYZlM0WEg0dFZnZkVNeEVpZnVJR2c2NDA5eDBScEVP?=
 =?utf-8?B?RzBMN0YwTGw2TUg5SFhaVGxoRk50NXlWTm1mZmJtbzZKajUyMVNabDRwQjk5?=
 =?utf-8?B?UlNQbm4yU3FzNFZ2WlNVK2tUWFNDM0JsRnIxVk1HTkRlc3JlY1MrSm03TytP?=
 =?utf-8?B?K3pianZweHF6TUlkZDRLbmhTdUMwNTdvVHNhKzBYZU90b0YxdzViM3JlQzBj?=
 =?utf-8?B?elJhMmZRU1VEWndZYUVKcXNCeHN0Nkk2K0RYTzNXcEoyU2pNMjZMTWkycFh5?=
 =?utf-8?B?aHBPcGdsdVlpQVhBWko2aDdIbERuR0FVUTcwMUduNlk2LzYrckgySVI0VUgx?=
 =?utf-8?B?dXc4Z2piTkZGNUhOakpSdG51MVNvN01IMjExblRoWVlrTXJCN1VVckpiUG5D?=
 =?utf-8?B?cU5EOW5DZzMvNjlxaWVKYWxNQzV0dUpKbmR5cVhiYXVWVmdKbTVTUnZtY2JS?=
 =?utf-8?B?V2hrbWw4alNhdG96bUsyNzgvS3ZNcTZmazF2R255bEdOOWMyZllRMEk3WHdr?=
 =?utf-8?B?TDMrQlhJbVprb2F3TUF2TGpVS1QyVWpBa3htNFFjdUFGdHptcXI4aVNmcFVo?=
 =?utf-8?B?aDVGMU1sbm9rRTR2OUZZQ1lJLzJWU0p0cEszMUpycDNaczZtVW1JNWJRZ0Vq?=
 =?utf-8?B?bFJkTHNncytWV2dMblh0NHR3aURCMlpnMTA5Sk9DditJTFpuYzhQODc0eU1O?=
 =?utf-8?B?VlZOOGJpZkhzZTV3a1JFQXVpcnBLYWFzQ3V2WFluamI0WnQvSk1IRmJMamFs?=
 =?utf-8?B?TFNqd0I4aW5udzRYTHYvbmE5bFBCM2pzWE9rK1VvTnRWdGJjNTA1RGJMSEk5?=
 =?utf-8?B?SUtWTkN6eC9DbUhBNjVTYWt4a3ZoRE1ENTlYbjhIdGh2ZUFHU0Z4MERVd0M5?=
 =?utf-8?B?clNla2VjNFpqRkU4SXA0U2VmcnFDNWYzdGR6STdkWTM3cTNsSGNmRUp4L1ZC?=
 =?utf-8?B?M3JublNvTnl0VUI4WEJ3MW02RGtLWmtWRkJobnpUNkF6WGlPTHo0Y2JqU3lj?=
 =?utf-8?B?dWsyaDluRURqRU9ZZnpyZ2pWVzdyQ3hwUlFHK1pNWThuT1pYVzlHcHZsUFNJ?=
 =?utf-8?B?Y3VFMW52SG1JNWlPN3gzU0JYcGtCODY3M0E1Q1dwMGFDTWpueDVuWUlsdmhB?=
 =?utf-8?B?RDF3Y1lBMkdEWVRyeU1KSEMxYThNMTBUa3N4NTNOZmZJemZiaXpYWkxoRUU2?=
 =?utf-8?B?aWR2Z2lST254MTdiODlidmZ0N2ZYZmhxZHVJYlFLM2RkUllneEFDT3lYdDZ1?=
 =?utf-8?B?UnJDZTQ4TVl0V1h0dEl0SlFaS1dodW8xMncxMjcxMTRxZUxLQTZkRFZvaVVI?=
 =?utf-8?B?cEhzNG4wVGlZZE9weHZkT3BFejhaaVdLcWhGemhWbGJLeE5lWjljMGZjRVo2?=
 =?utf-8?B?dWllVlZUclJjUDNkU2FJUlZKNEVhTnVYdGlMTThjeVdEeEJoQUR5MjExTGhr?=
 =?utf-8?B?OGl5SllmaSt2aWRxMGpmbkkxSEk1QlIxV2g4azZzcnhwMUJxTksvWVkyc3B1?=
 =?utf-8?B?SUZWcko1MVhKdFBHMit6cFd2TnFmSzhvRnIzbkQrQW5vMUpnWk1YblA4ZTN1?=
 =?utf-8?B?VVJSeWlPamNaNVcvYzMvalpLc1Jhek9jTFZlSnBma3R6NnJxU3hFU2FiQTc1?=
 =?utf-8?B?eTF1d29xYm5VcGdKZlFnVDlRdkZyNHZGTmxZd3lMOWFicWtNbkNHVEdEYjJZ?=
 =?utf-8?Q?tqdLBEsLozua7Nh1sTLJXQk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	juDybc5Ei+JlJubo86BGIxxqJCgYInM/TYyaHyfNSlGGPRcxzhT7ipD73ivVT/+lLIyB13gW0VOK9bY4G3V7iMVutlqiGkGtU3t+hjbsFOZtFf7pp4E/he/4Qs8+5GMftTdTK/VdQiUYiutXIFl1rgRxWohvzmAqpxnnY9KvTFpIAPc9UwOadaTdY9oPNeY0H1q0N9pGfDzGQJ731zaP1aaatE0gyC/2HJUPKS3nqnsztUFcKvPnVrXP52bvWfn8lhZDAHIqHcw3jN9rVeq6M1PLTyBIuG8JDMlLB2zKsbD5FafYphNJw61a/SHmgFwz7B1PpBK4UEMM8J9AuQVl7LLp4hT/mDRQVS6mLQOaS9amUsc7GgEGYkpBQLog++qKxv6DBwQJt99CMFJ78px1FaZoudOvOnE0Va1ZZ15a+TurYef17+hCvEX7LHnsN04Fy/ASJx4qDHyFju5NqWN6MOEC8p6aVefmL+JoQMfU1npBnXxjopC+yUHJce61mqKW7Jxrlq/qjIsKRa2hcjewYrqTzxHFj1I4TJn3g/lwWqWlsdJowusbBeJ7dADpChmu896yVRY6RggBsICsxc/22jygMOIeaT4nUFungojCFAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebac104c-72db-43fb-158e-08dd09d0d0ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 02:04:22.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQx8g6mT/9cZE8u5P7DIMtkkAJG25nM1bORIcfpaCans01rWULWXjY9NYMt18nEtaFknApRiRkl/65JHjZUK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_01,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411210015
X-Proofpoint-ORIG-GUID: jrlgujDr5DOSqhv_kxb-cHF1IvUhHXIt
X-Proofpoint-GUID: jrlgujDr5DOSqhv_kxb-cHF1IvUhHXIt



On 21/11/24 00:28, Darrick J. Wong wrote:
> On Wed, Nov 20, 2024 at 07:40:41PM +0800, Anand Jain wrote:
>> Fix format string warnings when printing blksize_t values that vary
>> across architectures. The warning occurs because blksize_t is defined
>> differently between architectures: aarch64 architectures blksize_t is
>> int, on x86-64 it's long-int.  Cast the values to long. Fixes warnings
>> as below.
>>
>>   seek_sanity_test.c:110:45: warning: format '%ld' expects argument of type
>>   'long int', but argument 3 has type 'blksize_t' {aka 'int'}
>>
>>   attr_replace_test.c:70:22: warning: format '%ld' expects argument of type
>>   'long int', but argument 3 has type '__blksize_t' {aka 'int'}
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> I waded through a whole bunch of glibc typedef and macro crud and
> discovered that on x64 it can even be long long.  I think.  There were
> so many levels of indirection that I am not certain that my analysis was
> correct. :(
> 

Per preprocessor, it verifies blksize_t is long int and int on x86-64
and aarch64, respectively.

  gcc -E -P -dD -x c - < <(echo '#include <sys/types.h>') | grep blksize_t

  x86-64
    typedef long int __blksize_t;
    typedef __blksize_t blksize_t;

  aarch64
    typedef int __blksize_t;
    typedef __blksize_t blksize_t;


Thanks, Anand

> However, I don't see any harm in explicitly casting to long.  Nobody has
> yet come up with a 8GB fsblock filesystem, so we're ok for now. :P
> 




> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
>> ---
>>   src/attr_replace_test.c | 2 +-
>>   src/seek_sanity_test.c  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
>> index 1218e7264c8f..5d560a633361 100644
>> --- a/src/attr_replace_test.c
>> +++ b/src/attr_replace_test.c
>> @@ -67,7 +67,7 @@ int main(int argc, char *argv[])
>>   	if (ret < 0) die();
>>   	size = sbuf.st_blksize * 3 / 4;
>>   	if (!size)
>> -		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
>> +		fail("Invalid st_blksize(%ld)\n", (long)sbuf.st_blksize);
>>   	size = MIN(size, maxsize);
>>   	value = malloc(size);
>>   	if (!value)
>> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
>> index a61ed3da9a8f..c5930357911f 100644
>> --- a/src/seek_sanity_test.c
>> +++ b/src/seek_sanity_test.c
>> @@ -107,7 +107,7 @@ static int get_io_sizes(int fd)
>>   		offset += pos ? 0 : 1;
>>   	alloc_size = offset;
>>   done:
>> -	fprintf(stdout, "Allocation size: %ld\n", alloc_size);
>> +	fprintf(stdout, "Allocation size: %ld\n", (long)alloc_size);
>>   	return 0;
>>   
>>   fail:
>> -- 
>> 2.47.0
>>
>>



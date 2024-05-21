Return-Path: <linux-btrfs+bounces-5133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EE98CA56A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 02:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DC81F21E77
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 00:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AEE79F3;
	Tue, 21 May 2024 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kFM8lj38";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vEd4CbFg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9D848A
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716251958; cv=fail; b=V5fyCn3Jm1dVu6Ii3pMI8KSxYc9JFKbvmbZNg/nAgj3L6DvY6PpgpKbrQShRHlG6LODBPoDetxALKHF915QE09a/pr1JPefOK5eZi78BgNNlXu9oaMAMq6dJE/QKS8rl7QPaFyY6vziamIm9cllsS1Lh+WPVAsTqSLfytQBm+p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716251958; c=relaxed/simple;
	bh=rBGCY3J8tlrCQIKnruqNAs5Rgq3Xjrk8TGYqhg5KY34=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M5ZTxh8JLuwYgTRdtY91ECCVD2o9SJ7lN80N+/gmvAMLl+5MVNCmDQIKquFL0Rsad7os2AQl+Gph9/354pMw0opAsMzbmo7ynyCLIiFM73i94ns14MMh1fAT0GpyYUW3xliS7KcTiiPgTECEAsB0rmxrplhOvoQMVXqasmnfqvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kFM8lj38; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vEd4CbFg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KNgL0L004130;
	Tue, 21 May 2024 00:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5U4lj/Cvhm2Sb5Ai1P60bLRJK3Fhu95uaJ1sSjINX5A=;
 b=kFM8lj38zkfncwENtz+CYYQ3er82Mt80MMRX0xieFR7dPFBBvYweENmGk4/ZtznLj7fR
 GSUgRvhQ38DbcFL63n5m/WML8snPDVMVkCJ1xrWcWLsEHuuWlKbGdX+lubfX3DgURro/
 FWk23BqZ19KuX/G1MhAl2wYc1ISxlasPpNkJ9NKYqv/rTezzc9438X1w8lyVQNxTddhD
 AP3tF0kaFADScLT3Ie6I5DwYXmYaceqdoTqvjpswUdPYv63zMWVsucdLz9iElBasNCld
 67Wyt63y20aNLzvMf3ekt8egqG7nHVg2XtLd25KzDMssK25Ds1Jf9mim+AP9a5iqMeX8 zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8d3w44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 00:39:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KMVFv8002688;
	Tue, 21 May 2024 00:39:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6ytqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 00:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIEhxhLc7oj18+5hRQufNwqgNgpOOUM3IqGv61WAIOlOXh96ehCWo0D9c8v4eyi4XV0EWLJmz3I2Lv+6qD3uS6YdvNbXQpOEvE8D/PG3BDMBrGJcXeLP/R1EyU19Pi0dHdfbDxjzgZqoFP2cppoNcqctX/RGLdGFKnw5fXy6dFZPU7ltpjty5rjIRYakLnFZMerwWKDiCi3AX8pqxVjD6vfcowrg4blqMNGkIpz0gzjqgQb4qfryYBVrg8PwoE1zgSbmE7pYGQRc/+Y77xZlO0Q2jYk63n4KfUHQBa+Jc6/zxnryUj+l8Xl1K9aXh1SE6LV5M3yHqHZvz03nB1dhig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5U4lj/Cvhm2Sb5Ai1P60bLRJK3Fhu95uaJ1sSjINX5A=;
 b=lseMUNWH6PmU3J68uPCtnzP0vxtPLZPLiq5Ex6oH3JxuIv+OE+25M+kYpQ+SWvCJ8Jp+aZCf2x7Jtcw4DMfRWgaF5kWto3rlND4jLJ8lDqB/9DMlch1+YjoTimvSlYVLSSEc65nBuzhfoyt//YCyAtPJsuqNvndKOGOQq8fUyBb5caPBt5u8cBTWlfEbHXh1TWzP+sWXulbakl8dCCIf4QyxVZoYsd1C1iJpJc5rCJ7xN0x3Oeu86GxIe0xp2WrBPORm6sH9OvmaplNJDJUzBcUz6soLH+MplKkPWhW5XNeG6sJT89Rg0SCH3fxyrK5E/CViZ5GF8nKlZtdABAXe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U4lj/Cvhm2Sb5Ai1P60bLRJK3Fhu95uaJ1sSjINX5A=;
 b=vEd4CbFgptWnnJSby50goREF7VxesOB3VQnE5mbHxg3nBS6gyDc8MMDriTS68Wt4fHRAUCv+kJIHt9UajegRge5xICHUeGAAtXxzwe3KiSE2DWiH8MWZ7lQr22sXLSD+kTQxul0OFkmSK985yCUQ8xOZFJgi9bl6JWsP+Qda28k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 00:39:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 00:39:02 +0000
Message-ID: <6f3ee833-e6e8-43de-822d-5d0b8cc34c46@oracle.com>
Date: Tue, 21 May 2024 08:38:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Cleanups and W=2 warning fixes
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1716234472.git.dsterba@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <cover.1716234472.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b09a3ec-7ad5-4d2c-4a11-08dc792e695c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cmRpdGsxWE1oaCtta3dMYS9VSFFueW1FTmFOTzNHRy9QVzVQaktMMU9FMGNU?=
 =?utf-8?B?d1BaUE5aQ3k1TjlFRkRuaEpPWE5Lcjl5MU1xZDNmM1BOT3BFc0d3Sm95NTl3?=
 =?utf-8?B?cGoxc0lZalRIN0lJSzNnRkJUZHMzeTBndVRsSDQwTThBYkxkQytrVUV6Ti9h?=
 =?utf-8?B?bDN1TUN3b1MweVVTTk8wd0pzWTBld3hxb1hqYVBnQ3VIWjVOOFJvUE8xeCsx?=
 =?utf-8?B?NFdaR0FaeTVtQm41cWV4a2ZoY2k4aFhIVFVrU1luM2xlRWpyNGpBVHNXNjV3?=
 =?utf-8?B?anBLWTB6dHcwSFFoUDVmaWFud2d0WUh0SVVWd1U5SVNyZ0hrRkZJM0szTjB0?=
 =?utf-8?B?Zkw0WjcxeWtFSlhHOUlyU0w0N3g3eFF4RThjRERNVDlKVkhIaDBhZS9BNEhF?=
 =?utf-8?B?YzBpbjZWYm1pOWtSUEVxSm4xeFdxenh1Qk5PVTcvTk5aTTQreWROSFFrU0FW?=
 =?utf-8?B?bmJCUm4veXBsUVRWOFI1T0xQajhhT1lIU0w1MVR1UXBCMzZlYWNWbDJuZ1ZK?=
 =?utf-8?B?djdtTngxQndGYmV6b2VkT25DRUE5RTVCa25TL1hyVGp0TlZRZ3lKU1U5TFB6?=
 =?utf-8?B?aUt0eVp2Y0Z1SXc0ajF2QkxNQjF0SHVUSXRld0dRRWF5cElkd2I4T2o0bEU3?=
 =?utf-8?B?T2FjdXNxS1IwUDlkaFpiQVZWQlYxczVTY0Q1WTF6NXNObThySTZRSm5tcFJa?=
 =?utf-8?B?REFrMW5YWUhQRWVrakNMUlgxRFE3dE50d0RuckgxRFRUa2ZuVzd2ZlREcEY0?=
 =?utf-8?B?djQ1WnpLbjVaR2dXV3UydC9jWDhEZGFYMkpuTXAzUDlDL2VGYjNhWElycVdC?=
 =?utf-8?B?R3R6YUFEa3JjNUljbEordDZTeVZuaE05MFI0YkJvK3NUUkJRdXpraGVya1Zt?=
 =?utf-8?B?TW1TWEJYQmZVcEVFN0pFbTRQVFVsallpK3MraFVOeXRONkw5NDF0TTZ4TEdY?=
 =?utf-8?B?S2Z4VzFaVDZjbnkzL2RVRWx0YzdjRStUTCs2d2hEdGdjRi90Q3RpbzZiUVVq?=
 =?utf-8?B?YWtRNHJWd0c1VU9idEhYOFdiV25QRkRWUXpDQ2N4bGRwRWt1TTlhdkM3MDVS?=
 =?utf-8?B?RUNHWmlkbHh2bW5OTEZBNGxEY0JvWVBDUXZHck1KQ3VISC9IbUF2THY0enhh?=
 =?utf-8?B?VEdEcHdMMCttRzF6dWMzWkF2aHMzc0NtNUliaWtxcVFUYnpaV1lCZ2VhOHFz?=
 =?utf-8?B?YmlLVE9Jc0NLL0FQUDN0Nm5pOXZZdlpFM2VITkYrKy9WVlNkdlJwTWpjQ2ZS?=
 =?utf-8?B?UVMyMGdCZ25jM01OUHJSS0JEQ2xOTWEwOVhxTzV2c3Fnblh5OWIxOWxvbjNF?=
 =?utf-8?B?RUoweFlhNHdyQ2Nvd3Mva3ZvSlVaREZHckRIS2tjb1hCWER4SndOSzNnVS9k?=
 =?utf-8?B?UkdRSm5UUEZMbldVWnozcjhlbHNEWUczZVUxak5RUm11cTNKLy92am0vcjhy?=
 =?utf-8?B?Y2QrMzhlbnByRVpGR2NqT2FQNURqOGVrNlVsZUFOKzNXSkdOaGdiVDI3aC8y?=
 =?utf-8?B?S2Z5b2g2K0YvVGlUVUwyeWI3alVFQTNNeFZMcXA3bUF4aWtOOU5JeUplaU13?=
 =?utf-8?B?TVhITHdsWUtUcHliNjBpYUpnWFNUa0p5YVQ3YWlMWXBidTg3ME9UR3FENEZl?=
 =?utf-8?B?Wnh3M0VGd1N3TGk4ME9iQ3JUeXl0Rk5jUHR2ektiWkc3bHNucERNOW1COFp6?=
 =?utf-8?B?dnBKTm1JaGxtOU1JQVh6WTJ4cTlGbzRBeFVTQUlWVDlVemQ3aGxBZVF3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OVJ1L09uQmdCdFNLSlZUT1pJS1BMU0RGc3J1eHN6UUVuamJ0c0I5NnJpbzdD?=
 =?utf-8?B?YU1ZcWV0SlRkSW40L01TYW81TytxYWpMRG5LaVFaSCtqRG04VHltM1hPRjRF?=
 =?utf-8?B?WkhPUjlFTUptZXRoakUyckxDdjRPM3pwM29Pam51K2l5OWZrRE1ZMUoxWVNa?=
 =?utf-8?B?Zlc4Qkw5a2JjVzhUSTJVYVBydEIzTXNkMkhpNG9rd0xzcXkrUTFHbHBqUml0?=
 =?utf-8?B?ZnNwWHcrQTF2enJxZlBTWlFBVVp4c0pKbENQQlZiODZLYTh6S3VEdFNtZVZ5?=
 =?utf-8?B?NGVXazYraWFqSlVUWEl1UUdtd003ZVluOFVheXFneGVQZVVuSGN0aXYvZnRo?=
 =?utf-8?B?VitxUjRhSW1LZFhsc3BRM0RJVjQxdm9NakNBOVdUYVV6TWhvZ1R0MWd0UVFU?=
 =?utf-8?B?cU8vRW1xcWQ3ZmkyMk9CM0g1MmxuSkplaFczNDFvUDNvdUZyNVlxWmV1YlNB?=
 =?utf-8?B?NDNOV1VDODJyQ3p1cW5lZmQvbkhDSGVTUXYxZFpCbGFFY0k0bnBzejNnYVVG?=
 =?utf-8?B?R2dDcTRHTy83bFNha3J1WVl5bzRRWkpYbkNWZUh3QjJtbFRDSUxicEljbUxK?=
 =?utf-8?B?REU2aUhHclRHaEdYaHZKd0l5QTZpV0h4b2NQbDVUcDBmTGlUUkYzdkFOUkhM?=
 =?utf-8?B?SXNFL0FoUW9HdkxkYXRNazF6dlZldjBHN0hVVVBCMjN0OEtrdG40VmJZekRn?=
 =?utf-8?B?U2N3RHExampaV3hYSlI0NTBPVUdDYml3bHRiVmF2bGhvWFpEUW5PcXlsMVRz?=
 =?utf-8?B?LzRidDFGZC9QQnIzelcya3B4Qlh2ejg1eWNrdEQzN1UvZ1RVRnh6OGFRdVFs?=
 =?utf-8?B?cTFTL0pxTTdENzhldTZqbnBCVXM5R3AzWVVjWUNWaFJCVlhqdklad2tqMVVB?=
 =?utf-8?B?TklJMXIzMWZHYWYzaWZHQ1oveUgyNGxydnI4RCtZaVRkemNhUEZ2cGJNZGd5?=
 =?utf-8?B?dEpJUTZZMmZneVArUjRNTTVlUWQwSHRtWDFRa0lDR1ZZQWdlTWdiVHdYd0l3?=
 =?utf-8?B?eW1IUW9EZFVOMGU1dkNaQWJ2U0VwcnhCS1lzMURCMzNQMUovVUhJUzZ4Z3Y5?=
 =?utf-8?B?VUlkZzhjV1U5cm9ya0x1Qm5DVzBTa1BjcmhEbVIvbUdiNEsvcmNpSGxra0x2?=
 =?utf-8?B?YU0wQUlzdXNRbUlzNm1PNUMwZkh6bzMwUE9JZW1jNURRSm1zbXlyVkVVVTky?=
 =?utf-8?B?Nk1mSkpkUEt1enBkVHhkb25HN1Y1V2pNcU9nT05BdGd4eEVoQ0pZZVFyS3Z6?=
 =?utf-8?B?aDZQYmFheGZvWGZkbktpZThmbjg1MTRmUVJZV2piSSsxNThCV0hFNjJjdWRB?=
 =?utf-8?B?RmFieTVCUFd5RGY2VW96NXI4MllkbjNwMjJ5ZjFmZXRHaWFqTGtDb0dJMkt0?=
 =?utf-8?B?d3l1VU5DV0FQQ01mM2JBWFdudTZKcGtnY0VWeFhCV09RU21VRzFEYlBZUGdu?=
 =?utf-8?B?VzUrYUZUbU94WG5FU0paazN2dWVmV21sTjQyL0U0OGNDZG8vMUxDRmxjTXR2?=
 =?utf-8?B?THQ4TlgxcU9GUTF0aU1ZeGZJYkJNOXBvdTRCOE93NUE4d2NXODlFdktIaFhM?=
 =?utf-8?B?KzNDZENPVGVvTkE0aDd2Rkw4RkRuVmNEemx3eXRkbXZ2QlNaU2VPL2UyakV1?=
 =?utf-8?B?TE1JQUREckExekV4M2ZQRzlKS1lYcFA2NUJJNUo1Mmwyc3F1M24ySC8zQVMz?=
 =?utf-8?B?RXh2aTJ2UlNtV0VFRS9SSlRZSmcrOURoaTQrTU16WlRxQWJMOE1NWnAvSUpi?=
 =?utf-8?B?UDcrTEJMMm1BcWpkLy9Dak4vTUttMnhWMnJ3OHJVRDNScG5BTlhHY0RZd3E4?=
 =?utf-8?B?YU11UmZwV0NYekl0U1FoUnFLZnMwbWNtbUtKS0NrdHgwYWl4V3JydXJ2eVkz?=
 =?utf-8?B?MGJOMFFWVmVMSDUvczZrNlQrK2IrWlFsUCtIMlp6MFordmxrS2ZORHR5SThG?=
 =?utf-8?B?Ni9GU044VTBoVTRCbStyVUJqSkIrV1FMMHV5RGt5aGozWEMrQnBLUmJEaGhy?=
 =?utf-8?B?dGVlWjFiNzFwN0xYQmE3c3RhcWF1cW1tQVg0MkZJZkprc2NFVlE1aGw1VGFp?=
 =?utf-8?B?MGZDSXduK3ZUa0JTRjRvbzAvdWloU05weXV2TmlFRmtSZmV5KzAxQmJ3VWtu?=
 =?utf-8?B?OW5IcWpyQTZVZ2NMTW1YQ2N1K0JUMGE3OVdJRHZ5dnowR0pBOWR5TmpCS2Nm?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zwVWvdUfo7PhpITnDrAOAWcGTEE8+jvnONmtmHsIQth8vVHZ0Lb8zKwDx1KdJ8ykoiQMhY+VmWyUzml47ee6+RsaQNgbbyNLEwgAE9p4XgkQLQvuRuJk0Gf/A0/cVXFRzg3yOF2NgJwAaYEc4Xmg4aHsgCf3ljp3oLqF2YquZzV7RVtcKsvV8UChNvV4Vqr+R5B7qhcdSJTuWzG+pYBhjvPpw6bwuqZWCr5+KypdYhHt8QuCWAY7PoM/UiDax+EnMTQy3F9Qg2Euu3YzU9JOCl3WhWCt8+FvCfqHi0Ga+nfTlJgqFZQN1Kw8MlcZQ7fwDn6OYEoiSoWig/8ZKwzjRRLp7TdKLQKJzJ4R5a2+boF0FIf91JbTOgfUjt7nQvtJuttfph78QsaSQftbCp6ZzVHpRD8BoD0vAUHeBUr/6RAHzpVnCQvBHLvokNFNj/DQuBrfcxMYJx/CMBZXeNw01J5SIRCNmVpeRRnDEUAk38p+9iPqSPQfaQ5w4dkzpeaAI4Ghtdwbm2kX7V+TMB7bCZyCJtwVDDBv/yKF8KQFyiD6sN5fRX6D4z3iPLTMn5lNvVwjav8SdybGVPMgl2mmYc8zMUFi2fkzTIad5bxsoLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b09a3ec-7ad5-4d2c-4a11-08dc792e695c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 00:39:02.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cZAcyXEq0ejW5NZoOr1z7BpYM1ZN7R2dB/6y7FhUtN3/DA20TXcrabYLJuXYhuvCbu0geDi/CPEMfevzjZGtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210003
X-Proofpoint-GUID: CnzxAXdDJ-puzHt7-6rvPp4ehxpSg5Gy
X-Proofpoint-ORIG-GUID: CnzxAXdDJ-puzHt7-6rvPp4ehxpSg5Gy



On 5/21/24 03:52, David Sterba wrote:
> We have a clean run of 'make W='1 with gcc 13, there are some
> interesting warnings to fix with level 2 and even 3. We can't enable the
> warning flags by defualt due to reports from generic code.
> 
> This short series removes shadowed variables, adds const and removes
> an unused macro. There are still some shadow variables to fix but the
> remaining cases are with 'ret' variables so I skipped it for now.
> 
> David Sterba (6):
>    btrfs: remove duplicate name variable declarations
>    btrfs: rename macro local variables that clash with other variables
>    btrfs: use for-local variabls that shadow function variables
>    btrfs: remove unused define EXTENT_SIZE_PER_ITEM
>    btrfs: keep const whene returnin value from get_unaligned_le8()
>    btrfs: constify parameters of write_eb_member() and its users


Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks, Anand

> 
>   fs/btrfs/accessors.h   | 12 ++++++------
>   fs/btrfs/extent_io.c   |  6 ++----
>   fs/btrfs/inode.c       |  2 --
>   fs/btrfs/qgroup.c      | 11 +++++------
>   fs/btrfs/space-info.c  |  2 --
>   fs/btrfs/subpage.c     |  8 ++++----
>   fs/btrfs/transaction.h |  6 +++---
>   fs/btrfs/volumes.c     |  9 +++------
>   fs/btrfs/zoned.c       |  8 +++-----
>   9 files changed, 26 insertions(+), 38 deletions(-)
> 



Return-Path: <linux-btrfs+bounces-15918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E45B1E1D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 07:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF784564F59
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 05:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485741C5D57;
	Fri,  8 Aug 2025 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n8abLN0j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RNzZXwAI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2631361
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632071; cv=fail; b=BsoppHQuT8NkTp1aBIW7+z66yZXRWu15ApPMHUsZd6EHMoCc+DylQ9hVpSa+7JjajusDRnYuuuHZHGKAB9BLb7ZUxiohd5dI6txLdq7nOu29fr2a6110a4TOTHStvC8bBRbQ31ZlzotBuyAwfptm2hrWzk8OfFib4kbOxCWSb5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632071; c=relaxed/simple;
	bh=KkQ2r+ZFJmZ5VNhj/0x0Pxsk/gUlOQTzhsLtw+OZimg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gp4AGmGBOI2Afwh8pJIs17yNuIOurSpU9ASZcA7VQKaAQGqVuTeN7Q3m0mdSh5LDbpUfvulHhKjWoO4akX1qjjCT7atSc04W8b91V9wEYlBsBZxOam2w+Nc/5codLBDIesEM7gkBmIKx86VXgPc1eUigNug0nNlzdOl8zd/+I6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n8abLN0j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RNzZXwAI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5783vh8E029088;
	Fri, 8 Aug 2025 05:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=b8xvG5fSGmzHuHIRF0nrkc/IVWazU/y+6+2eFZPmSow=; b=
	n8abLN0jcZ+HBraZ86Ns5UYAIbwHWZPw1+deEHbEDkg1zRAiAPf9N6qgsuxn3xaB
	nqfrZkHph9UWKBQeyMdrBxuMOEJC2Q7dInXLjT4pPTymdOHox+UKtfdk4q9G4toV
	HdLU/RIJiaZpi8uktSgxOOxWguIWi05eCM91TkDqZ3HLkJ3OIom3D/eayoZR901i
	MTxAiUjfrmNZ84YEHAy8vGQWAPSdbAM5RkLHeGp/rNFllX/8/MOtrbq9b/EolQ1j
	LKjwXoTxtcRmXRcXSwMPcHF3lcxQzhLMeTUV7rjYspUm3fB+Fp33CymWXvVPecjb
	bS0wdUtN5rO7w8CHpa8evA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjwfn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 05:47:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5785jvGi018341;
	Fri, 8 Aug 2025 05:47:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwtcf6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 05:47:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUZtrDzy2ctz0bVWfCxLo8oPaKAV2vAiqpKMzmBR6NQt6cnpydOORNkqsZNco/zMGptGxUcWKGRp8XFGhPZnRSJkAaqwLU9nv6V9GrnukkL9eaUbmt2HKWNXCkn7Vhct8n6em6maNt41bSj2ZCOkgx60HFDD3eGld4t4sP/udqEw75kQzjV0zkH5KlOUeqpFsjvCl5aCDzZ4E9wkrEa3FMNkXtKcPfxbBG7TIGn2l0VQY4jfgnNsEftwxrEKcD4eawsgWEn1FNJ/bMkdXLFZSxTHy5ICLkPwb965W3mQwvaqYhNKN7zRQYakUbGOQkQ+MxW06Un44DYqZrUi3C4z3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8xvG5fSGmzHuHIRF0nrkc/IVWazU/y+6+2eFZPmSow=;
 b=wHW+KBJs/sx1f3B64E9Q1VD80l36dB0e+C6AMqA/9bs3TEyYNatZ0nW3ntz7R3K7Bv8j4KW5o2FT5mVDYFB6+XvsKDxa9uQ8MlD8oYBHjnQqKPjTe4t/YImg+R93jIxREZXwE0NPiXItYYHszWdXnTnMqeMSqip3mGon4YFsHd/BRkBaMo0nWp35fZ2l0kV3KRJ2rdFGgh6K3opjRG6sQ/3BLWN7VxNdky9WK0BD6KnJA21hlQNM/CkGitHPwSSrxZlhJ/IZS9ZxmRVfDThRGjPt+6q7NkCAvIgWS/mpPLfaknKnHp0y+X32oax4g1lC+NgXMLV2hNI1MtuTKjuUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8xvG5fSGmzHuHIRF0nrkc/IVWazU/y+6+2eFZPmSow=;
 b=RNzZXwAITQrIUFk8uvLVHwaJUfp/fRrMhYEz8MTpU7mUcFo3VMchXztXqUASawllFvXbTJeMJ0t77FO9xg0CRtid3wueAthX1qQyNs7kfkb30HmBCjimTmT6YcxKV+fUSm+4e4i731km/yo67P2UcTIikl7rVuO+k3rPfp860u0=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 LV3PR10MB8057.namprd10.prod.outlook.com (2603:10b6:408:291::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Fri, 8 Aug 2025 05:47:43 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 05:47:42 +0000
Message-ID: <479f6581-b2de-445d-92b8-d8c3e03d5af0@oracle.com>
Date: Fri, 8 Aug 2025 11:17:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] btrfs-progs: fix the wrong size from
 device_get_partition_size_sysfs()
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: Zoltan Racz <racz.zoli@gmail.com>
References: <cover.1754455239.git.wqu@suse.com>
 <2fa034e287a0b7deb5a1b436915426a696a10e71.1754455239.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <2fa034e287a0b7deb5a1b436915426a696a10e71.1754455239.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::16) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|LV3PR10MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: b03678f0-7454-4b87-9a73-08ddd63f17b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzVlbnU3b2pURWlOa2wrU0xWWk5VTjlSbEk0dURIekJVZmNZU0lvbWwyQldl?=
 =?utf-8?B?SEZQcURnTk4rZysrY3grZm4wWDNOc3VOc21CQzRhdlBGRXVXZENSWlMyeHEz?=
 =?utf-8?B?NkErMWphdzRNSHNoWUF5a01SaklpVGsyNTU0eFBuQUdRcjh1dWxVL2kyd2pU?=
 =?utf-8?B?ZVJQQWxGOG1VSXp4Mm8rbUlzeVVJSjhYcGlQc0pYVUh4bGVKVm9scnNVY1lU?=
 =?utf-8?B?RXpvOXV6NVBrZlY3aXlIakZob3h0S3MvUjhUL1R3aVdHYkU1QWpYYVR3Q1Zl?=
 =?utf-8?B?VHNTVmpudmswRVlIc2ZZL2ZkeGQ1cVJSMS9mZXNpenh4VHdORDdveXY0Q1Mz?=
 =?utf-8?B?Z1luNHJxeGdqait1bXFZcTlpNFFGRW90WmhjaElpdlJGZlBHNUVDQVNhM3RM?=
 =?utf-8?B?ZG0xeGFGSFU2WkVucmRPY2U2TzRrcjkzSlJZMjNFcTdWOXpjN2J1bkQxcDdV?=
 =?utf-8?B?aWRuTmZlckpKZlVjNGxUV085RUdsS1IrYlVSSHFzYVdad3JGL2pkVm9KMmhz?=
 =?utf-8?B?UEttaldQT2tMQnMyczBGS2ZNQTVORGlIQjdVa3hVczlOTmZDYUtyWGw0VHps?=
 =?utf-8?B?cGl6cGM4K0RyRVdsV3I5TXJjN3h4cFdYSmxDL0Job2hJNE5US201NDlEbW5I?=
 =?utf-8?B?eEN2MUVtdjhubWpyblM2NFVnMEpTRnU5ems5NGhVbHliTEMzNUVOR1FkY3JC?=
 =?utf-8?B?eUk5L3JFcSt5cFFJbDlvUytXUnNJbXQxMEkyUHFRR2VBREtDUzdXb05tdDcy?=
 =?utf-8?B?SVBRSkRyVG5HTUpYVUtsQUN0eWk0V2M4WW5iVlVEazFHMHF1VU1BT05ZQlVW?=
 =?utf-8?B?TjdBSVplcVFYUExvb0Z1Q3Z0Q3RQclJWc3hKWUswKzlOamdyemdKVlY3Z09U?=
 =?utf-8?B?WXBmdmNiNzVZNWM3Y1UrUFRtZnpJM29WOVNxemlJbWZYZkphakVwSDVqYlNI?=
 =?utf-8?B?OFk1cUNnQlNXZnJqbFprSmJEaHBPTUNqeGhoazdnRlhqcndleStBNnhkQ2JJ?=
 =?utf-8?B?c004LzZOVXhteDVpOFRudDJYbGI3bHVJTWYxZXJaaHVhZ3QwWWg2RTBxazB2?=
 =?utf-8?B?LytibjExeDlKNnpCekhlZThyRTJiTkhlYklPNHFIVFlMY0hqemUvUU5QS2tp?=
 =?utf-8?B?OWk5SWt5RzBINlZqRFJmTDFmY0w5QmthS054Ky8xNWN4Rytsd1hOdzlPVmYx?=
 =?utf-8?B?L3ZsbmlHcnBFdkxhYVQ5K0RCM0twUGpNUmpNZ3lmQjdsVTJENXBkbnJMaFZZ?=
 =?utf-8?B?eDR6UlFBSy9HZjFaTUMyVGF2dXdackhkaUdiMXU1SVVXMVpucjZQZ09sTlg5?=
 =?utf-8?B?RkdtK0E3QW9oTmJ4ZnBmcHFtbTF3bjRyYzl0N2NmZ1hUQTZEZGRCMjBxb2wr?=
 =?utf-8?B?WXJKajBjc3pIK1dOQWVFaEhkTlBvMFlUL0x2MDhYaHRtbmFlekQrdXZReXhV?=
 =?utf-8?B?cjQrckJpTFlJVGVzeHVjRzRzeFNDcnlPQ0RJOTdLMnNmdUk5WENZWTFlVU1G?=
 =?utf-8?B?VGgxMTlPRmNkOWFsR0hJenNnRm1RTGxvOXZ5QmdIaHBLSHJiUGdjdTdxQk4r?=
 =?utf-8?B?S2lwU1RUVTBoUHhnMFBSb2J5Z0ppQmZWcGQxVEJPOW1ZOVY1S091Sy8vUE9H?=
 =?utf-8?B?a3FQN0hZZFliL3ptK0h0S1ZsdUZPNEoyNmhCdms5UHN1TEExWUhlVThzSjZC?=
 =?utf-8?B?NjN3bXdXanEwMDY2NE83L0MxNFBoZEVJUWpZcVFRSW1kMkNlMnhKdEV0ZEo5?=
 =?utf-8?B?YTcxUXhJYllmTEF6UW1ocjA0WGVsdXprVi95cTBpNE1vcVloVk4vbzFSUVVt?=
 =?utf-8?B?WHBDYTBXTzNsd241TkdUYThQV0hSc3lJK01NOGpuWXhVSS9QSlZDL0lMMUVS?=
 =?utf-8?B?dFlSaXZBZ0NKOTE1WnRpMWNNWGlUUDBsc2JzRTVkMWpUZlhEdTBRbjJGRWc0?=
 =?utf-8?Q?tQEO6GQkKAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blQ3ZWJOVThTVjIyOU9LdVhUVzhUMFZGblZvKzVYeUo1THVKV3JPYzI4ZTNj?=
 =?utf-8?B?cU03dkFyUE5iMHhUeGlXN2xlU0U2Y1BlYmJ6R3duUStvVkpFM3l2VVAwRXJ0?=
 =?utf-8?B?M3hhWUtUZ3FLelJvV0xzYTVnN01BSlUxUGJuR2ZKS2xvREJ2anM1Yzh0a3FN?=
 =?utf-8?B?WkUzRXVHdHp2b2E5U1BWVzd5M1IzY0xCSXh2cDFaWmlmU1pQeHc5OWR4SHZD?=
 =?utf-8?B?ZVBITVpIcnNEckZHaGIxendhUkllaWZyUFRaWWw3NnY0dmVsVThrQzJ3SWl5?=
 =?utf-8?B?Wm01UityOUFuY1MrZmVDNzRsbW95K2FHaXFqYXIvN1hXRUhsYTZxeWNpakRY?=
 =?utf-8?B?aHZEQXRpMDJtWWFPOGxMN25nVUE3STJ1VDFrNXpXblpDYVpqWGhPM2srd3J4?=
 =?utf-8?B?VENwcjJGV2IrUGl4M3V0SGp3SVIrMzVyMC9yeHRCUzI4Q2xOclRaY2hrOGhX?=
 =?utf-8?B?OHpoWkF4UVpRVm85OW45NXN3Y2F1UFRyWS9mN1U4QlJxL0tQOVBWYjJrc2pZ?=
 =?utf-8?B?Uk5YV1BpTEdFdFFrbzNJc3FVcDdqSW5ZUnpiaVVFQ2Ura0M2S0JDM3dwOHNL?=
 =?utf-8?B?UWtEUDNSZzZUdE9YYUQydnRwVDZxWm5tSFUyTlMwSUNvcndLWWdlZFY2UlRX?=
 =?utf-8?B?WVJFeG10RCtGQVNWTTVraFNLOVBDZkR2dE0wZ0lzMXRURTEwNm02UHdWUTZj?=
 =?utf-8?B?WmZHcE5STUc5SE11TFpWUXQ5ZGlldlJlNW9pelZrdGpiRzVaUWdiTW1rUDlG?=
 =?utf-8?B?SHVHTFhiWlhBL2F2OE9VeHFUOXZiZXhkQlIyaHBOVnJXY2pLTy9UQXJKeGEw?=
 =?utf-8?B?Qkp5aVk0U01xMHVYVjE4eWprdG9MUWZhWjl4L2l4S3pWSTQyWkg1ZFVLNGtG?=
 =?utf-8?B?S0dTc2VZRlExMjgvM2U0ZDBWV1FUZ05QMFQwamkwK2dMZkhoMTRhRHZWb1lj?=
 =?utf-8?B?MjZBeHhXYmlLWUx4dUU3Sm5oTHN0SEpyK21mMTc4cEZDcjBUeEtSMk0rb3BB?=
 =?utf-8?B?NTNrNFFST25DRDV2TDRQcVpIRTR1M2FaNURwMHRtSERmUUtuNlAzcU8wYzBa?=
 =?utf-8?B?Wis4TVpZMmxiMmQybVltVFNBclBsMnQ5S0ZQQ3p5UTVDM05CS2M2WFJjaEND?=
 =?utf-8?B?c20xMXRtdS9pYklsQVBoZVhoQWthMGozT2d6U3RNcGJQbm0ySEt2ekhnQTlq?=
 =?utf-8?B?bjBhWEZnN0VUMjl6cStmS0RSSVRYYVNzQkpWSzFTNS9mRE1kU21vS1pha0pZ?=
 =?utf-8?B?Lzk3ZjZMSTRVQnlsdTUxSC9qaklTSlBHSUFmZUQ0TncwMi9FOGpOaHc5NlBX?=
 =?utf-8?B?ZFRweHhOZnUzZVBoVTVZcFBiaW5UejNldmRHMklJRXEvaFF2ZHFlNTdpRHVL?=
 =?utf-8?B?ck9uK1VwbGZiaWNHcG1XNEp5dHFFTngyaktONVZ4RHA2ZXhHTlFTandjazky?=
 =?utf-8?B?em9zSVk4MHJiNnNhRXU5ODNzeFcvRFJWaTJxNU90cjRrbFF3Qk9XdGdld2pU?=
 =?utf-8?B?QUlDQVJQckN2dnFrS3VtVVZqUy96TTBZWkQrUHAzU1JoOTBXcHhKUTRJd0c3?=
 =?utf-8?B?TDlDOHpGVVgvRlFER0p5MERLS2ovcGR0TnR6TEs1VEpKQk8wSGV1alJqcHAy?=
 =?utf-8?B?KytyWnBObDgybWZHQ3d1M1VGbGk1K1hsSGxoN25CeklCQVdGdThWSmNwWWEy?=
 =?utf-8?B?bitTOHh6RzZyZyt2RWpwUmxTaWZRMHErZ3pCOWhDazU5R2N4SVVXQTNKMFpi?=
 =?utf-8?B?bExkWjFDbnVIQVRzU2I5dmVLRnY5b2FmemovdkV4ZzF4c1Q2OU0rbGJlWEpH?=
 =?utf-8?B?WGVacDJvTzVOTTdRalByWU1MQVRxS05jWWQvb1RwU0lzM2orVVFDZmxRVzl1?=
 =?utf-8?B?TkwvckVZL00vVXdFQTFWdDF1Z1lVUWtzQmNBVUZ3THlxVHNUVC9uRFh1T2xG?=
 =?utf-8?B?MVJMTmFTMkRaQ0tIdWxZWHpLaUVpSVE0M1FmT3J3cDZxeFJPaG1uV2k0UmJJ?=
 =?utf-8?B?ZkFPUWp5WThPQkhHLy92RHVaR0N3cTdDOVo2VmJUU0d3TVVpSklWWkJPN2Jt?=
 =?utf-8?B?T0NSMWZYVG1Ia3RUczZzbjZoQ2orcWk4b0NNb0RoSytMWjl5OHBMOFBCN2dC?=
 =?utf-8?B?NHNWb1pEMlFPZlFPenlHdG01Q2RUT0hhanVsQlN3YU5FcnBHSFZtemgrR3hU?=
 =?utf-8?Q?xp/G3ujNmKPmBMe7FXhb8zQsNUrmE0fzngmFN0ZjQ/w+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a2IGomkUHNKloWx1sbbWr/Wg/r+7fObURTHRfFdqEkdSDjJIsP+V8YGkmYoAOpxHeGcxrfUNnkdGTyMdW071zN7kKpbiWc+HNkq0lnP9orFQogVHkcGqHuU5qYzyQqFRoklJZnCiWt6T7YcZK0+gNQJ2GF446H05XrIWH5uZdQxjo1jv4+OeHYP14vO4md5R00ejFimBuC/KsZ53G4XK9HucLqqs02bx94bThpEQE85vSqbTN8cp1S0oTAITYeNI/iToPGDY9fkVjjVZm1sPZo8i3fZSO0GWW/GTamLJ0raqKuPynyZftlpOZyeQvtxva3tc1JWrYZrRjGYe7fBrIoot32Qn7rXJHK8LebNlDYAKzdc2P12/stJV1YcvoOUjkdS7Zr5lzsVlq6sXE4jjOiULUruly2AM+BYiKLt8eXxHshWh3QIFbpYKyWtHVDp2xUgAn7bc1/LyAdSykOvwdRTYiqEuyuZcF8vhu0glxPp5rV5hj9ZopJxhTl9Sdw73hFLLg2ManYvaGKFApwi7HkBciYyiDRSnyC9mHrUrC2QI1KSJEAkBWQzKwdSWSGuuuhg/lCsH3oIFu+iRYa5ysmtCJkDbcf6DyC4aygaOVQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03678f0-7454-4b87-9a73-08ddd63f17b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 05:47:42.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Puv+WH0FhQLiYkY22P6JXoLerj9Tbolq7MlKNuk3dzTlW9W5AfUtKLM1hTd13/M9LKUZsNNl+vf38Fgx54PAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080045
X-Proofpoint-ORIG-GUID: ovCfqcWSkmW0BLbEpGKZDsgMgYyn1ota
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA0NiBTYWx0ZWRfX2E1Xu7ZImNBB
 aX7VEH5SkX9bqOlKcqLjJWhJzWU0V8NfkjLQNkvUVTqB2JM0jgPhTZvnXhhapTmYOc06fka1K0o
 E0xEmro0TP5JpDleyzfJFI817nfulA6aLOMIP6SJfatykFNSltUOEC6va797MAD13yO8m0XcXe0
 +46DU1AHTH+t9kmjGaipltbcgFCbLotauatdWVBTVN/Mj5svxYo8eLsbr7lqv/4W9zn4eMM+G3x
 Ptt1O0YGAsMTaHpuxV3S1J6Z7ZqEZBz7bcr/rOW+KEJzJhWmsTZzjKBsXrhf85RIvOi/fOv+By4
 WqWXszhRU2EA/KwbYrDlkUXpeDmJQymMOwcH0McOn2UbAy70ggxcKMjohR30eHhE8lp7zi3n22Q
 EC3v3i2Bv7JaIlL4AJEOfjTdttfaMpdqgdJscY8KPMjgX4rquw+l9zlyF4210n5ZF0pXBprw
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=68958f83 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=wBuzn7iUdJm3ky1avREA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: ovCfqcWSkmW0BLbEpGKZDsgMgYyn1ota

On 6/8/25 12:48, Qu Wenruo wrote:
> From: Zoltan Racz <racz.zoli@gmail.com>
> 
> [BUG]
> When an unprivileged user, who can not access the block device, run
> "btrfs dev usage", it's very common to result the following incorrect
> output:
> 
>    $ btrfs dev usage /mnt/btrfs/
>    WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
>    /dev/mapper/test-scratch1, ID: 1
>       Device size:            20.00MiB <<<
>       Device slack:           16.00EiB <<<
>       Unallocated:                 N/A
> 
> Note if the unprivileged user has read access to the raw block file, it
> will work as expected:
> 
>    $ btrfs dev usage /mnt/btrfs/
>    WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
>    /dev/mapper/test-scratch1, ID: 1
>       Device size:            10.00GiB
>       Device slack:              0.00B
>       Unallocated:                 N/A
> 
> [CAUSE]
> When device_get_partition_size() is called, firstly the function checks
> if we can do a read-only open() on the block device.
> 
> However under most distros, block devices are only accessible by root
> and "disk" group.
> 
> If the unprivileged user is not in "disk" group, the open() will fail
> and we have to fallback to device_get_partition_size_sysfs() as the
> fallback.
> 
> The function device_get_partition_size_sysfs() will use
> "/sys/block/<device>/size" as the size of the disk.
> 
> But according to the kernel source code, the "size" attribute is
> implemented by returning bdev_nr_sectors(), and that result is always in
> sector unit (512 bytes).
> 
> So if device_get_partition_size_sysfs() returns the value directly, it's
> 512 times smaller than the original size, causing errors.
> 
> [FIX]
> Just do the proper left shift to return size in bytes.
> 
> Issue: #979
> ---

SOB is missing.

Changes looks good.

>   common/device-utils.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 783d79555446..bca392568d1b 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -375,7 +375,9 @@ static u64 device_get_partition_size_sysfs(const char *dev)
>   		return 0;
>   	}
>   	close(sysfd);
> -	return size;
> +
> +	/* <device>/size value is in sector (512B) unit. */
> +	return size << SECTOR_SHIFT;
>   }
>   
>   u64 device_get_partition_size(const char *dev)



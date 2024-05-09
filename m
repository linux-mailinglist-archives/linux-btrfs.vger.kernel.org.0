Return-Path: <linux-btrfs+bounces-4867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C584B8C0D5F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 11:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB57282AAE
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2B714A60D;
	Thu,  9 May 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CZuwqCcT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zw3FMteL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA20149C7C
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246280; cv=fail; b=g/TGqtsbftXFW2f2mvWmX+1/VhBJAsFN0rp69HCRYQ9F6XwUXhWXaNs45/HqTT/WUchvMlB17fp8wGdRm/mXqvkBJVVNWeUKqpMc73mNu50UjZlt5VjfgjBI8UcEhoqWGvtZaDBV0o8JMGBQes3VDeSqDL4sL2YT3q2ZVd0deRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246280; c=relaxed/simple;
	bh=YDbRgmynJ6M8fOmDmIKncEJ1LUMiDfcB5CEMIWeAc68=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pe4UrlO6dwf/F4pLvvqonulvO3wmCifMEaNzVZ/EN45ih5IUZSUwmbDNSTEmHJa3y7Pqhp/vOk4E8bJbk8957pHmVMZcVHYUx/vG1SbcD6wDWQa8xx23Rq/M+7V1Rgj7hNUm26IIAAA88uk/dOFs0X3P/TxDytUtMJ6lV5NR8tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CZuwqCcT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zw3FMteL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4496nXPT027635;
	Thu, 9 May 2024 09:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gdvc89ZaZ5do8nfYVBkpicediqEZJZHydi4KyAhVluM=;
 b=CZuwqCcTEASzWqamuY3G2n+yJW+3m01I80Hvs07Vj5v4A7TULvnEq23vrC9w6Q5O8BbM
 Q6VrugRODvweHMBctNG64EOZLcsjKdQ5omVxZA9hweF6vYBSzxylwiSpxyKVxbdqz/Te
 0hTI+h4V0oft9vJTrFNGzBrLmgBva5ceakdTxRFv+ClR0bq0UvAVOppV64bcvwSoMQ16
 MuDpO9cKYZz4T1YDk1UvxdZFG8SQz26T+CdC/hU6vII9wr72hQodWhzJjeKCpSZxQ+Hx
 qGz47qPBPJYrxFcYc5nv+g652V9c1lgl0RmBAx1kc9NMOpGFwWho+aedaCAS2xLDHh7r PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y0sef8a9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 09:17:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44980FB0020208;
	Thu, 9 May 2024 09:17:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfn92ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 09:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmKscXVQQWCx3gHXaAMGRNPqU0Zv+jVNlpS8Lr+BOQGVC4ryy+ctxZuaB5CdeH/uK3rELwDzxURARl8t16/LxEIVaFKc+3G0wO9u2ZLsSf4o7fWL41wFrI+PDa2SOdl55/WzyvMUuDX2SYOTIXJ4xx/SqRQ3vT7pS+xfnnXiEkKs7IqESdZRgM27t41zIQE0LNbvRdMN6RM/WlR/oQih/YBsB2F6+dnvD2F4ZtQ45MFAue2qgji3fUMDfSMnEJuGMWGPa0QUW6RwSKMPUFlHbRnDsv/cgWdWjt+Im3irgGHDyBnRz3FJevAr6K6/2HL3+6oo9KcXuj55IpMVw8Fnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdvc89ZaZ5do8nfYVBkpicediqEZJZHydi4KyAhVluM=;
 b=jeN5fXcwKmUqC8ThnMZdGhVscFuAS1FVpkgbDJotBswU1n3KxuByiFeM6A5smO9xOiLhbW5gBcAUyhIfyU/jSnMw/9We7tuKfkiBUAjLQQLBf4CoFgdEDOJwI6wQlzu9y5zkRQt6ThT6wTsYh6T50Wn0g3Gpg4Tweh7nZTzQvh727qAMYWWSqPaAm2STI/leWY3PX5nS2QyEla+c4xhj0dkUtMS5QxVaUFQYp77fIy4gM7M/O+49n1MnivTYOvsReRIWzJBCt3YI2MlazkenCjoo6+mkQKuaiUOfoIlToFnTEFpE9PvgyaXXDowfgMah2Uej2txftENMNI1vYuH/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdvc89ZaZ5do8nfYVBkpicediqEZJZHydi4KyAhVluM=;
 b=zw3FMteLc0O036UspaaH6HXfXmkONTtIftXIZ/oCM+H9axvozCI0AoexAn+rIO6g0cQ1XkNhr2e1QBqnlqupDjxZ/bvcftYUuMkazHbWjIowIL0INBJX+29qpGm8cGrjaJincHfVN5CoBORGtbH+Ce6uXJZ4RfuWEDlgnr3ewLU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6140.namprd10.prod.outlook.com (2603:10b6:208:3bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 09:17:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 09:17:53 +0000
Message-ID: <fd1e3e98-ec26-4c97-9b71-1a96f0d9cb9e@oracle.com>
Date: Thu, 9 May 2024 17:17:47 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2 4/4] btrfs-progs: convert: support ext2 unwritten file
 data extents
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, y16267966@gmail.com
References: <cover.1714963428.git.anand.jain@oracle.com>
 <91f25251b1d57ee972179d707d13b453f43b5614.1714963428.git.anand.jain@oracle.com>
 <5da145c8-802d-4fd2-a52d-9a4c6fe37ea5@gmx.com>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-GB
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <5da145c8-802d-4fd2-a52d-9a4c6fe37ea5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: b15d0851-de7a-445a-e481-08dc7008e7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WFo0TjRoQmorZGFMTkwxWlRkYVNaVTRWR3NVS0hkdzZRTzNvWkVBUW0xamVh?=
 =?utf-8?B?dGVOM21OUldnd0tSNFh3K1Y0dVJiSjA2ZHNOU3Jjb0h4VGVUQkZxWWhpQlo5?=
 =?utf-8?B?a0FZaU85Y1A0R2lYTHVxb2dSeFZkREU0WDJYMyt1TTd1VHVuUzkzT3VQdlhK?=
 =?utf-8?B?b0MrTjhDdm1YVmNxRWVpL3lDWi9GckhDKzdqYVZRQUVoaUR0cWg1NHgwK2Nj?=
 =?utf-8?B?Zm9vbXVGb0x6TzhYb2FtbVRiUkFYMXNrSm9EMi9GWVo3OW5Tc2cyTUtraDF6?=
 =?utf-8?B?RmsrOUgxSlRjdU1UYmVCazdqZXNDVE9WV1dORUxKOEZFQVZzT3F3ZkZ3U3pG?=
 =?utf-8?B?UDdQRkRzWTZ2VW1YRzFLWUxrRnJSOGJ1NTRqd25uMzhpdkM0bHBYSHVVWjhV?=
 =?utf-8?B?dlRjQlJFOEU0OWVhVkJIcWp5TUNaNllIMmQzUENpQy9jSHh5YTl1T2h4Wk80?=
 =?utf-8?B?TERsR3Q3Z0lDWUtvT0Nsb055N2VtRkNnL0ZITGFBOGhacCswMytPd1dsOEZX?=
 =?utf-8?B?WHBBaHhFQmRlTzJPMXRrNHpLL0t4eHJLeDZNVEdUc0xScy9WbGJBNG9vZTRD?=
 =?utf-8?B?TFZLOWNGUklMM0VrSWdUcWpFa21aNW1BMm03M1NORExLNVJmRkJzRUZXN2h5?=
 =?utf-8?B?VE9tK1VQWjd2dUNaTzdCelMza2Y3SmF3Sk9LRnNPdTJJbFRlMVBPblI4d0Jn?=
 =?utf-8?B?Vk1vVGVZRGNwWE9jeXBBVWVaWUtsaUg3elU3dGMvWEpzaWl0elZia3FVTFpU?=
 =?utf-8?B?ZlRzWmtoVmdscmhPQWJKVVFOMVpHQmRSQkpNbVhSQzVtYisrdTRTQTJENTY3?=
 =?utf-8?B?eUpxTHZnY1hwM3FReTZkT1pLZGdHSGlCTitIdExnRW5ocFEyVldPT3kvenpr?=
 =?utf-8?B?czJJUGd1OUVZSkhqblhCZUs1UTFzRTE1UEExUlcveWZnREpiUkNnVlVxMDNE?=
 =?utf-8?B?SWJMN1VGWGgxNDJxamZac3VQT2JwN0t0Z25LSk14ZzA3Yng2cnlyWDB1WHE2?=
 =?utf-8?B?cjlVSFZvV1VxZ2VvZTdNaFdFQ2F6SHhyNW01cUIrOUVoby8xR1p1L0hiRzlB?=
 =?utf-8?B?M1NMUTdmUjFlVUtkWitvU3RRM0ZwTE85cUJBSXlFdU5RZnBCSjNjS1RPRWJq?=
 =?utf-8?B?aUFpTUIzS2VGN2RFb05ZSUNOSFlqZXR1MkZPTEpMak5UeWpjTkFDSU8vVGlH?=
 =?utf-8?B?L0ZjUCtFV0ZsNHRzbURrVmxPelhQZmtvQitlNEZDOTJkbVRjTGNuQmtpaXpY?=
 =?utf-8?B?S3cyYlgzVVBjQm5BSlRoNjJpaWlBRHQ4RFdSNE5VRFVsek80bFAxc3I5dDI2?=
 =?utf-8?B?OUZYT0JoNlZIRGVMQWFTWGV2MllmZ2h1YjlDTlFyQ3c5MFlCOE91azdxdkly?=
 =?utf-8?B?VW1jUkRRRkh6QUJrY04xMEcyWlcyR09BaEFkVnFZSVFtWHJXTHJsMSt1aWpP?=
 =?utf-8?B?U1Raa08rSXFEUWVYb0szR1NpbVhxZW5TcEJGUjN6dWZoYmFrL1ZMbjdRc1Bo?=
 =?utf-8?B?QnRrVm5PcHRyUC9LQktjamhXMXd1eE13QWZGRlhTZGduelBLS2NrNkh5Sm1P?=
 =?utf-8?B?dGRLV3VJcmdtKzAxK1laT1Y3ckJvbHhDUXp3QnpKRXBOR3VOeHZMZHZueW1F?=
 =?utf-8?B?Y09zcDJBVjk2RHJIYzVlQWRFU1lFdFhnRE9ET1lWTTEvUVEwUnlxUXpoY2RM?=
 =?utf-8?B?VXdsMXNGb2daODVWdzUxTGtYbnk2K2xHNVNoa01vdTc4ZWFZTFV1RVpnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjVrZkRiTzZocDJQQmxoYTdUd0xRUjJrUC84UjdTRGZCc3poYWg5UDhLeXdn?=
 =?utf-8?B?OHlwMFprclFxbTJaNm1UZXFyVXpYTFpnbGVFN3N6aVVDbWptdWdXSTNNcXls?=
 =?utf-8?B?cEppd1ZQekszUWlyUUp3ZW4zK0lZbGxPeVN5eUxhYkdIVS9kcGdsOWRiT2ZI?=
 =?utf-8?B?Tm9rczNDWVAyMUhRSEFVN1MycXU4cEN5SnhvYlVEa0hHZkttQlQ5TEl5QUtY?=
 =?utf-8?B?V0t3MUM0eDV2V3E3SFVCNFZIMUd1dUs3Rjc4cTNKaE00TmR4R2wwSWJSbzRz?=
 =?utf-8?B?ZHRyeE5jSTBtbjFDYk1BTTdNYlpIN3IvZzBqbHhpdUZ1VlNPRFB0WUkvMDA3?=
 =?utf-8?B?akVUZUx4dVZQb2xtdlRsVVdXZDhFR29SWGJDOXhLWDU5WkRuLy9mMWE4aENs?=
 =?utf-8?B?OGlrRCs2SUF2S05oMzJZN3liaUFlYURSNy9SSFZxTHJZVkhoajQ1TFNrc2FW?=
 =?utf-8?B?eHBtQk43cDI5VnlUTkVvRWlNUEtaRlhaWnBJa1hnSWJobDhwN2UrQkZoakwz?=
 =?utf-8?B?TU5CYkd6bDFTZ0pOVkdqVUluVGQ4Vmh0eDlMdkxhWldHd0xHRjlnSW8wU0Fw?=
 =?utf-8?B?amZKQ1dnbkN0Zk9XVXUrT0JFRGJvUTRwR2hTd2JuRmdmeFJmZm8waWNxYkxX?=
 =?utf-8?B?VjVDbDFnaGhtbmNFa0llRCtyZnpiVHQ2bHZlV1JBTEljSVdpT0JiR3dKVjd5?=
 =?utf-8?B?VHdyK0NmaldERDgrVzdJQWFURW91LzdNZ1RPMktEcUM5K3ZGdGNPckdxYXNM?=
 =?utf-8?B?TEprdjR0TkJxUklGZ2V4eDVQNzlzM2F1QitRekpyQTNOWVZWUWxoR3d6THRE?=
 =?utf-8?B?bUNwTVRFd1dkUmxncmpsWjdMZG9FeWthQmY2aTRDdmVKRDRlcmhxbGgrcTVM?=
 =?utf-8?B?ZmhUSzArSHJIa0N3ZG93RDBmSkFBRHFkWVhkNkF0a3BkNitabzdyeU1pb0Y0?=
 =?utf-8?B?eXRBaGtZZTU2aVRMbVFDSm1rb1dydFEvTHQ2SExUbWtlc2EzODRRWHZYL2xo?=
 =?utf-8?B?S1ZDRXNEa1BBWkJuRmJ6N1FzU3N3QlNzakdUVitNVjBFS1A1ejZCT0JSQy9a?=
 =?utf-8?B?QUdTM2JWNXdMajBzYlIzbFp6YU9uMFpnK1ZYTDBVRWt1dDNVN0JpWnN4TnhH?=
 =?utf-8?B?ZUdtUEI2eVNoa2x4bkVKYnhNYzFIdmFiM1FpcWdZdFUzZmlNR2tsZ0tudFZ5?=
 =?utf-8?B?MDFhQzBnQ3hmdWp1VGhwc3VqaEt2R2tqWTJYZmdaVnhwSkQ0SVhQUk1ZKzNF?=
 =?utf-8?B?RWZ0c0hnY3NnZWtjZFZ4SWlYM3BZa2lQdEs1Uzl4Ris2SlJ6WjlTMThxRVhI?=
 =?utf-8?B?d0ZOakZtQTFRbnQxVHlpNFE4ekhoUC84SVhFNDhhUktVVXh1N3NkQ254RHo1?=
 =?utf-8?B?cVFzKy9XY01DcG5RVHJoelE2M2RvY2FXL3Z5WWE2Q1ZXRExTMkJsZXBQbEl6?=
 =?utf-8?B?ZnJzWTRadEJnY0hNYk5FemRkSnowS3lXaFk4RW1seFNHTVpCaDcwcEE1WXEx?=
 =?utf-8?B?dThYMVc4eWZCTnZ2RTZ1cVdSaUtWTkVPQWZFeStlRzVHUTBpWjZnMGRPV1ZT?=
 =?utf-8?B?S1docE9hUE5kUEpuN1BHTVFQQk50WTRnaC81NE1EN0k4VUI0RXhvUW1XWlNz?=
 =?utf-8?B?Z2FkRVBTRVJKMWhtOThjUG85TjhLOHdtcVV1cmxOWmh0RE5HbXVrN3o1bm9F?=
 =?utf-8?B?bzQycmxUVmV1TXRHUnNVUVo3V0RFRkNSYTBRRDRLNjdDOWRaNnhWYVA3WFVS?=
 =?utf-8?B?M1B3WXk0OW12UlpGZXZTZkFaUXpJdmREK3YyeTVrVEVVWDg4ZmF6WVpaU2FD?=
 =?utf-8?B?U2lNZytUSWpyWEp1UEhoSjhEelNVYlJJbEtPbUhleGdTZFZVSXQ2Z2kwMHZC?=
 =?utf-8?B?WlpTYUFOM1RRNjJ1eFlwSks4SFJDdFJpUkZVKzlVdHVRSnhuTnFWdlgzWDZa?=
 =?utf-8?B?dkR0bEdvRjdpalB3VDhZMTdyZms2WGowaVlWTjNKdG1BSnp3QVZ1VGsrZ2xE?=
 =?utf-8?B?SXV5eVRxckZocWx2UXpvaWlXVWw4b2gzUldIdStDL1hEL1plSE5vUjU4OGJZ?=
 =?utf-8?B?MG92TFRLc3BiRi9Ici9FS0RZN3BXa2F1TDBTZG90dzk2b1BSaE1wS3hjc21R?=
 =?utf-8?Q?FhhfE/GCOSG7yEm4O55BxpkIJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	P/DEjOwRfcFeyWuOev1vOXb2o+63V4fLnpo4Tzb5A6RiIF9vQfSrxPzquWJyD3uR3cr3wd5u8DIV/xw5jLDrfnylQk+VU/v9to2ySeCwf5X0tS3ut3ZUb5M3Hy776h0PHe6UlnT9cYGQiHVw5wJTJ4TvKk28igfLsnIw27swdsqpqqSq27tTh0u1+rMHa6Y6uQGjzAh3cAleZcyUz94ag/66R49sjfOj2aL23tYnFTjG9GdGkgfSRQ62roTivU4z5bJg2oe9KTDrT0DVBPAW7mQ3aKzTQmmiaoOSAu5kpWk1amrpKorzexWI+wZAGwqVmWYPRB6vdBqgA9Zl9HqmntIJoBRd3JxDGDpY3vPCYdmKT+4m3wfL7u4pVUf92hmuZI+tO9F8p78adDSCc1k+fSlHU6X3sJxIU/BFVQKvyHhApcr6c8m25Z/0uK0x8eNJOwVUzm3UO6lQ7dLRdLu4W8Js5LyNZy5gM00doqUG1Zs1Byi8sCnlUvCDo6TPArR5QzXezu36UI3lP1T3qCNo4Ez9ANfzpCSp8d07NOM+YbT2KjQuWJJcWALjTfzrLcR7fEMb2XKJffkqoUm7GhxJ8bPs9SmnBJgx2qOQShCxRvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15d0851-de7a-445a-e481-08dc7008e7b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:17:53.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSlfixvJWch+RFphRJ48a+zXa3VfeJrisVqkasiujB5azCzQKFcOw4NuXJS3r+gRIMOCNh5s80zwXEAhodB44Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_04,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090059
X-Proofpoint-GUID: 1BM9ArSo0YP-XNZ6JH7ENQVD-ZDsj75F
X-Proofpoint-ORIG-GUID: 1BM9ArSo0YP-XNZ6JH7ENQVD-ZDsj75F

On 5/7/24 09:25, Qu Wenruo wrote:
> 
> 
> 在 2024/5/6 12:34, Anand Jain 写道:
> [...]
>>       
>> 18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  
>> /mnt/test/foo
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>>
>> . Remove RFC
> 
> Nope, you didn't even test the patch using the selftests.
> (Despite the RST introduced failure, the first ext2 is enough to expose
> your bug).
> 

Realizing the existing test case missed testing unwritten extents,
I wrote my own, and they passed as expected. Later, I completely
forgot running the existing test cases, my bad.

Overall, the initial work inspired better designs. I'm glad the
issue was resolved.



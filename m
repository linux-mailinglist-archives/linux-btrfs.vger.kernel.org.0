Return-Path: <linux-btrfs+bounces-3049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09387471B
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 05:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7CC285B91
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 04:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7741168AB;
	Thu,  7 Mar 2024 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XQqNJ0g7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fafI3dN7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22BEAD4;
	Thu,  7 Mar 2024 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709784835; cv=fail; b=m3pLw1nR2aKts63B3HpQL8dULbMRCs5jr+bJmQB0Y3261LSrR0hnPyOijNRVsvC6TnGQqBOPqHTz8fqe8Yo2TX6nXWogSh7lrxtWEakWTdKmuzbvPyWc7O255cpeQ4L1LEo6GU1EsPHRLzz1F1xtG2E9879kucSfSAnZWrIfo9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709784835; c=relaxed/simple;
	bh=NfWV0oYvLorqN0AnLI8w2ruGF0VAr1fEM0UvllstzE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Siq8V03Ne+LpHMag0lGsoRRWoPEqjTm5KnB/A/QRJWvf2reYuCJzlINhQxJvZIVytAwUcZokmf2X0M+eNbLRgytMLLv7tJeZ38PxL76TxgQ2rwpO3tkVNmGxgnXDuXdnjqb7pLDzxZac489OL1uWe7ydDIBA4tus9z4N7rckHnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XQqNJ0g7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fafI3dN7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42712wXA006002;
	Thu, 7 Mar 2024 04:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=l+e9hFpDhl4GS5POZulFSNgwflxIA7YKS0j42i0Xz5A=;
 b=XQqNJ0g7wgb3DIKFZmiQ31XpbgZYIIPfcNsk6zgE+efbUAmz4GFP53fEI6RBRVRUAGf1
 uir19Uhq7NWRfnRzLLRU2PgVJiXuU9mekAat4ka99opMFWj/jfTO3pUWu7BFGrjmHkKR
 9saeea7R22yb+QjZP/2rZ/RDSSdIQImfnXNryuxF+aihGUuZSsLqvcIxKHXA/bTq/zB+
 B5fC4Uc9XxHazl+iFzHVzFZFpl6ZX7Gf5z5aYPFF8cQYWlYDGza9msBhll9vH13ov9xd
 jtwa2f37oTQX2g0es8inWrGpjwAq8BiZoYGZjFWqUKS6YANMRWMNY2KvnG66fJfQs8nL 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq2aqqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 04:13:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4272DSFt013711;
	Thu, 7 Mar 2024 04:13:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjachag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 04:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxDkFDf2sCfIAZESwTD1j8fcmbAxZfhPIbIER/Idh8UN4ad+9kxQZgDf0AUX49FY4s2Kddr0sIxJ+EhLs0DE6Ld1/4sudTCwxc/XW5VQ8Z8Lr/a8isiETNvS790qylFx/nlAJgRG9TqQMXY70am8iVMjvS+WxrL5J+vvsa9G7gWhnfROZnEc0SloX5cqs+wF5xjFpaVAF0dzI4d5wJmeH0C+2lbyw/qYalzn6VMMIcU/a2GyomK6jK0uYw9Vi/WxUNzjzNLPiqQm7niMST8Ny1Qfeqceq2sCJ08P8dCm4xzeKAPaDAdwbmcoKLAvy4CKwMHp0yUrdYhV1EFhlBR6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+e9hFpDhl4GS5POZulFSNgwflxIA7YKS0j42i0Xz5A=;
 b=nZ8DK+JFmNY04JhdWFqpeuHs0sKj3I8AfeTps/aDBQxAwJ6Mh1D9PyeUg7Cg+f4rx9VURE4Tvz+7aSzLZYGW31wsg6J6JlZZV1oPLKa5g1M7QsIgJ/UkvINHJedUTGLdwzzbwLeZ3VEYlMaTqlwCWEmzW1uPkKy1GKKL+20HWO52HnfZdeaMyEPS4p/R/MEUAEjuYBCy9XkJGAPqgxhzw8Y4JoKXoeiUeSE8pxU//fw6QmD5pkkBY3374MXQ+odmz7Jpm50ioySxMY0JeEhxpPOYBPx+/foU72mEdmncESOMrUou4ktrfoxndNUc4lKVKDjCRkPk1nd59OJ+tiiPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+e9hFpDhl4GS5POZulFSNgwflxIA7YKS0j42i0Xz5A=;
 b=fafI3dN7E0Nv56aCUwSa1XbtwkiFjugQUjlOgTUQdKdfDUxRKwdA+be3RrCd6iKm5M4VBEZ25tC4YGvQKwlAoDPWlKTSLnYtfS7/3Ix9xf02N0KYwXXR/QkvwoIDjnSs7e4L2Zni3/JcSzW2grzz3UE4cu9zOghEUAYgK0Bl38I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 04:13:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 04:13:13 +0000
Message-ID: <ee9aa0b8-bda1-4217-bb9b-fa9b886d6196@oracle.com>
Date: Thu, 7 Mar 2024 09:43:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do not skip re-registration for the mounted
 device
To: Filipe Manana <fdmanana@kernel.org>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, aromosan@gmail.com,
        bernd.feige@gmx.net, CHECK_1234543212345@protonmail.com,
        stable@vger.kernel.org
References: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
 <20240214071620.GL355@twin.jikos.cz>
 <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: fb340898-c97a-4938-0bbc-08dc3e5ce80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VkOFMiBOAVmNBMx6IyLetCdCrlNr2n+m3I0ULu3F4OUdXkK440xlYjgA7DYIfQiKSjJTx+v9ahpKjTwcBdUo9L/U/lJ4uA06YVVsb27x1MW/+RcfBQcuisnhlczKy7YcyIE3I5L01HsWbYpy0+hfMvdaOyVJ3UmEihXGelnzn5r+8ln8pexaSmbkSUbYB7WW1XNpmF4mn49UA3wDK7oE1ChSWRZIvM7ieC8N4xcxPgxm12+Xw7b0FmvDppFpYv1lK5o5u72+YV2Ag6s4pZiUneNlUeempz3vrCwVFS3ug521d1UTeRFSt9TL8Nz5eFx4MkpgAScESt7JSirSPimqSqYZ9zUjiJo2Ed5MuPTrvv5LiYyOEZTI7X5QiRLhHOsWyrsafDsVNxXaMzBD9YbAppgjSwEgTNqD9wGTlAF6O20WzRbX1xXC9YGH7T3N0ujh6E1CUv5CzzJVgR0V6hmitokvM611NVSARzfxG4ME/76h9CXVzoWd6AjCVi29kxuv4eNtcpxcxLQITwNCAG7Ef+ebnkS4cFCCWQ6PB9KahQQLHa6gRRVbOZ6veSQ0nF6nM1a5hS0uVgIEwBsbfr99gqzz+r5LiLRPrD7Q8ImakAngR1/i5V1aABez898G0xO+QrH2JAgCRR144PNVTlwJXCsSRufn9UJSr4ULa6tRZWU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjZOZzhCZ2V2K1VxcTFBYkdyeGxUTkZCbDR4NlFObHVkamZOV1pOZEhkSEhQ?=
 =?utf-8?B?enFWYU1LQkxCQzBZWDVQOTNZNkdFbEhGYzdadFRBbDNrL1Z5Nkd3d3BpdUoz?=
 =?utf-8?B?dkJrYVRjZEpMNEFJTzZJNUlRN3hQTWhaR0NxUFFmTkNoNVlNWU14ME1FS2Fl?=
 =?utf-8?B?ODZpVktBL0RwL0R6R3diL3FaVFpmRnFJNTFDYUpLcVZNcDZxQmRoS1IwcjlY?=
 =?utf-8?B?VDN5U0xYM1gxdXFxVTFoWVlWRm05SWVhTWpsQWhSYUQ5VkNJWlRlNmQxZmky?=
 =?utf-8?B?MmJrNVAxNWxPL2NBYndtY01CdUdWUE93Ti9NNU5vZXBHZk56YTF6Mk9pbEEv?=
 =?utf-8?B?Uk5ZYVF1UWwwYW5yR01rc3FHRWE2Q0Z2MTg2VjBiZGxtTldVbHdjKzhuY0ta?=
 =?utf-8?B?V3h1SVJEUkxQMnhzZWNsU05qVDJkeHZYS3dxV25qdEptY3dRVDl3TzYwNXgy?=
 =?utf-8?B?ZmdOeldkR1AveE1EREtuUEVLeFFTK1lyamw3bGp3Q0ppdjlCR3R4WEZHeWlU?=
 =?utf-8?B?YjRGV0pxQ3VVOFhwN2w4elNNbk03THVQb2NIWm5qajMvRUNaaGhscHBaQ0dF?=
 =?utf-8?B?d28rdXl0RFpJMS9ZZTc1Y25VNTRvZy9nVHY1SWdGaG41NVltSGVZMCtnNlQ5?=
 =?utf-8?B?TFRzc0hOWG9LTWgyVzJSUWR4dUFnaEVVbU5uazd3dVBvdk9meHdPbE9FK0Ir?=
 =?utf-8?B?RUpyQ2hUSnNwMG5SV3RqOEpFSW9tL2pwV2J6SlB0VEhLeDUrV2p6MTJhNDhk?=
 =?utf-8?B?OFdNaitrb3R4eTF1dGNxSlY5QW8rZmlMTHFMRGtFVml6TTljbWxqVVNteDQ0?=
 =?utf-8?B?NmVxUXRmMU5EZFd5cXphRWI5OUZLMXZkZWhHa0U3dHNyTFBDWW9PcExJN3pn?=
 =?utf-8?B?RWQ4V0VnTDdjUWtiWTdaUmNRQTNCUGU0WmFOaWpJV2pFRUFjajhHY3hyMWpr?=
 =?utf-8?B?YXhoRWRwRXhjcHhROFpJTmZ4OHpoY3JEL29QOTNhUWFqSzRXMXZGdCtoZVFy?=
 =?utf-8?B?d1Fyek55cFRMZkcvTHgvNUw5SG81NnRFNmZqQVFGZFZMZ2JyajJJdTBteGN4?=
 =?utf-8?B?RUJkcThCT1ZhV0p2SWtNSzc2ODl2UFF5UUxrWTJsTkkxNDlEOGpqdld2UCtx?=
 =?utf-8?B?OHoyYm1xSitlaWkxOUVQUFhzT01BTEJsR01vZEhrL0pjcnpyRDlxL1dRc1N6?=
 =?utf-8?B?SS9TSllJWFA5dlZ5NjFyQllxZitqbHBUZGlrK0dmeFM2Qnk3Y1BRbEdTb2Mw?=
 =?utf-8?B?RmlHZ3d5WTBZQmNqUmdGZEllZGMvbTlLWW12eHJGMi9hMDM3VGgyRnlGb1py?=
 =?utf-8?B?YmRvbzlGZExRM3Rydm8yRFlpMkZUcE4zejBJWWZ4NmJ5TEVSRExkVkpiQ0tO?=
 =?utf-8?B?cDBTU3BBMkJpMW9jVXNha0NmYkxSSGtVNStqMUhWSnMwekhiSWZwOTFDbGtr?=
 =?utf-8?B?SjQzNHhFTXV0Z2JkVmV4QStMZFJUaHpJNDBuUmIxSE9YRExJQ0ZObFhmbjU2?=
 =?utf-8?B?TklnK202a29QbmQxYlY0TmFmR1JZczl4YlNPeld2UFdpOTBrOHpzRWtYK2ZF?=
 =?utf-8?B?M2hIY29jcHJ0ZWJkVU13VmdCazRLM2pqNVlpYVVJY0VSbHZwQ3RiWk5DWVJu?=
 =?utf-8?B?Q0ZZNmsyOUF6VlhFektWNlhZK2hQQUpYN2gyNktmYnlRWmc3S3Q2NDlMNTc3?=
 =?utf-8?B?RXVPNWZzMGh1ejU5MUd2cEYyc2puUEdReDdqazdCcDIwWnFFNTZRQTFLMkVV?=
 =?utf-8?B?NUVuWk9Yamd6QXI1WHdMOVdOanI5OW9lTkw2Mkd5aWo5UTd6YnI4SmVzYlJz?=
 =?utf-8?B?dkFzUmlFdTJQTHRNUVRQbEY4RUJnZERXdTN0UUhXeUFCMVJDeGJkNmU1V1l5?=
 =?utf-8?B?cTNRZkZ0bVF1MWp6WHBaMWE0YkQ1M3FVd2U1Ulg5OWN5My90STFkU0dxaXJx?=
 =?utf-8?B?ZGk1NmRNVjFLSHlCS3VqUS9HbDIrdzVoVWxEbkF4QTVwZVNLc3J2S2hpdW9T?=
 =?utf-8?B?RVREc2pWd1RMaTJSUW9pUDc4d3RKd0wrSFQzcnhwWjhiOUZtOHN5Zi9oVjQy?=
 =?utf-8?B?M0dHOVB2RTIvaktiN1pPVEZDRjlxL0dQMm5YZklXcklub3A4T2VHdkcrMGVR?=
 =?utf-8?Q?S5iTmEJ33330gOL5Lo/B81qF3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fbt3a2fdecag1aZqu7qsAw2OzhbhyDNr224XWKnSIfsQ29EufEu47i3X/dt+MYpsNZ8uipdrkX//odvxPza1gte5+nypRor3OLmkYRFRe4PYF//HJgrDg5xAM+i+82hZvwdsO+YYjTiB+DBbCMe3O6q/wEvRJyF+sjcyr75wje7d+6Zl/yXp1FovmodtM8KSkiH+JpirOqZOvfAKSpohYzf5X/XoGghwsZBqdytdHq72jpT24NtauKbmRBh6bV2oEtWKRXmkvUMmHkeDx/JMzquT3y1Q7tCt3IgJCYKc9Ce6k6gHNuk4HG4gvGQSxcUKjmML5YE85cQL1sYnMUzl24tTShn1qWtoL/4z25Q+p5nRl1r/YSQKtNsFEJNw0tHYY6WJiJTy6v+N+eScTeamTTPyxP64jXVw2qnCeWTdl8TjYPj1mOI9yL93HLblfUqf66sRLGuU/BPy9ZJV/pngt2cy3h4oeAN33b79EKdLMd5JjrhoeAi/s6lsRZbBPW9AM4GoRPFIHEpvOZcrlaEGjz/FNBce0kw44EF/vfVBIJLhZyEEDLSuDlX7AFfvTX5pcOVYtywtaFTHNo2tBj70mb9o0I047hHWkCJdQShrwtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb340898-c97a-4938-0bbc-08dc3e5ce80b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 04:13:13.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HT9Nv4veGlvQDczAgHcgrp36c1IU91qlxa1nTUCdbvk4JS8376wbAcDpV3PF7MoUwh8ax0IrLdiHySYgyVnHaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070027
X-Proofpoint-GUID: SACGy2AXGcuWAdAV6R61g25valPBsYvO
X-Proofpoint-ORIG-GUID: SACGy2AXGcuWAdAV6R61g25valPBsYvO


The problem has been highly inconsistent to reproduce. I apologize
for the delay in sending out the fix.

<snap>

> $ ./check btrfs/14[6-9] btrfs/15[8-9]
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.8.0-rc5-btrfs-next-151+ #1 SMP
> PREEMPT_DYNAMIC Mon Feb 19 13:38:37 WET 2024
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/146 1s ...  2s
> btrfs/147 0s ...  1s
> btrfs/148 2s ...  2s
> btrfs/149 1s ...  1s
> btrfs/158 1s ...  0s
> btrfs/159 20s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/159.out.bad)
>      --- tests/btrfs/159.out 2020-10-26 15:31:57.061207266 +0000
>      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/159.out.bad
> 2024-02-20 13:51:25.707220763 +0000
>      @@ -1,8 +1,11 @@
>       QA output created by 159
>      +mount: /home/fdmanana/btrfs-tests/scratch_1: wrong fs type, bad
> option, bad superblock on /dev/mapper/flakey-test, missing codepage or
> helper program, or other error.
>      +       dmesg(1) may have more information after failed mount system call.
>       File digest before power failure:
>      -f049865ed45b1991dc9a299b47d51dbf  SCRATCH_MNT/foobar
>      +b2e8facfb4795185fadd85707fe78973  SCRATCH_MNT/foobar
>      +umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted.
>      ...
>      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/159.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/159.out.bad'  to see
> the entire diff)
> Ran: btrfs/146 btrfs/147 btrfs/148 btrfs/149 btrfs/158 btrfs/159
> 

<snap>

btrfs/159 does

         _scratch_mkfs -O no-holes -n $((64 * 1024)) >>$seqres.full 2>&1
         _require_metadata_journaling $SCRATCH_DEV
         _init_flakey
         _mount_flakey

> [79195.612719] BTRFS: device fsid 10184d7d-3ca9-43c1-a6f8-70b134cff828
> devid 1 transid 6 /dev/sdc scanned by mkfs.btrfs (3413318)
> [79195.666279] BTRFS: device fsid 10184d7d-3ca9-43c1-a6f8-70b134cff828
> devid 1 transid 6 /dev/dm-0 scanned by systemd-udevd (3410982)

Both /dev/sdc and /dev/dm-0 get scanned, and the tempfsid
gets activated wrongly.

The fix is to add another criterion to check if the device is
already mounted; then only let the thread update the device path.
However, I'm not sure if it will fix the original problem
(update-grub). I have sent an RFC patch v3 for verification.

Thanks,  Anand


> [79195.695774] BTRFS info (device dm-0): first mount of filesystem
> 10184d7d-3ca9-43c1-a6f8-70b134cff828
> [79195.695786] BTRFS info (device dm-0): using crc32c (crc32c-intel)
> checksum algorithm
> [79195.695789] BTRFS error (device dm-0): superblock fsid doesn't
> match fsid of fs_devices: 10184d7d-3ca9-43c1-a6f8-70b134cff828 !=
> 628aff33-4122-4d77-b2a9-2e9a90f27520
> [79195.696098] BTRFS error (device dm-0): superblock metadata_uuid
> doesn't match metadata uuid of fs_devices:
> 10184d7d-3ca9-43c1-a6f8-70b134cff828 !=
> 628aff33-4122-4d77-b2a9-2e9a90f27520
> [79195.696419] BTRFS error (device dm-0): dev_item UUID does not match
> metadata fsid: 628aff33-4122-4d77-b2a9-2e9a90f27520 !=
> 10184d7d-3ca9-43c1-a6f8-70b134cff828
> [79195.696765] BTRFS error (device dm-0): superblock contains fatal errors
> [79195.697447] BTRFS error (device dm-0): open_ctree failed
> 
> It always happens with this patch applied in for-next, and never
> happens with it reverted.
> 
>>


Return-Path: <linux-btrfs+bounces-3717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F0288FBC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6227E1F2539A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF403651B3;
	Thu, 28 Mar 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q4FMYmwi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wHXtiOvX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB953E3B;
	Thu, 28 Mar 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618731; cv=fail; b=Wm/m++un9tUFIYGysf4PtYcpryAZd0THn9x6Ie2poDyJENpURabf42GKotLCccx2zxmIcdGZcb46UsPX1Z5t1DsKyy9aYdfhOdjmNM5kGWgLNygJqZN4uObXiRbfUAZ6TyxWzvgyGYeyOljfjNPSbttE8yKNbIQ6xgojFIng5D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618731; c=relaxed/simple;
	bh=rcBKLkEPFlx5Glg8fT7H4XRQ7JRJNJxCYraIxeoVmxI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SkyQYFqvqry8rKcdB3v5q2Ryedr2A5xXP5i1sEwHf7GgP3PC8M2bfewxq/P9ya8I9TQtiOQ0Ul1ia0YPUvBhtQcUEkK7ImOh8vxByA96ZBHb8QRH9j2QzWt0wFQKV7wMVwoVx3eFOgNvmJpWA2WrpHzjU+o2bHF6nw5DfU6gvVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q4FMYmwi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wHXtiOvX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S911pw006799;
	Thu, 28 Mar 2024 09:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Q7uFlni4v94n3IagL9NSjK7u4prZ0vz9NJl93j1BTOM=;
 b=Q4FMYmwiLEGbEprkUXJv9l733fbDeFCl+SHZreDgEzRvU5FofEAfFqP1pEnQm/tYjR1w
 Z+4FicCb+whkkMDou1dTLl470azHN+nnkEvgZKi9DUcKLCCONyRX8Uvg+2cMK+93DjcW
 oro4wIDliDjYpg1h7HfZAswFi3LdsZcSxWjomFL3VK1CfwJCd0IYA+SiZDMFmaCMU0yu
 i34VPTJiguZfyqswCehOY1ZBMcgcqXx0XaHfKl9EY6ugkHP6j6Ss27MR6Wt8ehWTNU0z
 sH/Ap3lKAttPdojQmZXz9Qn0eFpqCqmbLR4rvtIqmwTF2NyBFkI+AHYnRoouAo+Fzh+I 4w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybs73r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:38:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S8qdSe015105;
	Thu, 28 Mar 2024 09:38:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhg0jm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl6rGEUL4iyTdOMXu9QJqlcA/RRJh9K7itiq2+XZ31tlp4F7q7dT/pQaDqk5pPM+3J4pbGEWzwHQ1gJOGDuChmJuA3ahcbYt1fiWH8H55ZFZ2bkudZqhkVnKWFltXR/s4FhwHpGIUBXFHgaZckqNlv//E3JxQfAYFTlMhmQjGAgr7ThiN3LEHc1BumRdN5t4tQcpc9Fq/FgykHbAeezN2u/+dxEwTsUzxb061OCIuxXZ0lUmzQTmP6V1/d4naT1SnUFYeBWdP6Q7Li/QVM4hiJ/86t3W7eFYwSRE4ttyVebJsOsjO4A4a6ICkj1yfs077f4m3vuh5h547R9MZ9Xiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7uFlni4v94n3IagL9NSjK7u4prZ0vz9NJl93j1BTOM=;
 b=f3wKV1URbyD8KB6pIdv5eWOciV9cBmBNcfRcEJZKdQSYIqdDBxG+VA7a8EpPKPTelkF4aXc6p3Rk7Xv+Nv3jalQeksGZo86TzKWrdmpTS27JgltLSM9Er9FIaChTT6ZKdhP20Hl6FglA19sFKNTFaEU8Og+PgK5JLnLyMOF5GdOR6QDrn0FpZCXReAK5OYZbjViiDrKq7f1tCzUlxO3KYeo4/q59xgUgM/s4ZUvkuS0q8dL/rW4QHuyNVlNvlD2vQUOAhjdTdEboDHCOWfGJ0WXjZBa7EnippcTwJo5Z9FTxzZx8rP2Z5AOKn6Hv/LiaZLunwjnCwQQFeq1w32dvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7uFlni4v94n3IagL9NSjK7u4prZ0vz9NJl93j1BTOM=;
 b=wHXtiOvXbPegJ8OteAUVZIXJAPYqTSstQP7edvyGFQ0+agvb6SvantljP92AhLUuNvaLA31m7F7WchlTlrz9ciUZsk17hzj+1Ad9so+jjliaR3RwdJoWYzTHVGoGl6mn8N867j9QbwjseN5KhiITii08z7zbInriRj0MV032zs8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7220.namprd10.prod.outlook.com (2603:10b6:930:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 09:38:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:38:41 +0000
Message-ID: <5a1674ed-466a-4152-9e40-89a06053a2d8@oracle.com>
Date: Thu, 28 Mar 2024 17:38:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] btrfs: remove stop file early at
 _btrfs_stress_subvolume
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <5b91f615f28c14274d9ad96c69cd098c1a9a6f9b.1711558345.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5b91f615f28c14274d9ad96c69cd098c1a9a6f9b.1711558345.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 052f5279-dc99-4f3c-dd0b-08dc4f0ada80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zLqRexzvAfpOHB53u5HUrRp1AVojUDQemOuGJlxxZIvs/o/qp+WyK4C4FeZLflhU8xGwS5Q6Qwft6hlQttgVd2BV91rsTTYI0fZjIGXGERzYjEnrUbW+oavm3CWS7AswJVGt07YyoM66rmkrVN6/dScNGFuoe86zp3NjhWNLKV6Raq6AZPMBYNBc/R5xR1icyQUPNohP3GYPuUFd16msOg2KphvhouU+U63C2SyPMcFV+GA1EozISY09NR5doOZLAHPhULDkRJAeFZ5pQqMO5mDQLpCi35fcAbvjZLU1Mxwc0t1xbSjO/Qie3KaH/6+MByKmzto4vBtv6+CAzU1ZC5HUFOkG82ATAbZdAfigXCnwEw2gnSWI1Z95Je4DZz7QnkYlNccRGqNf0vkf2huq3AY81jzgL2drHemeWMnUMe58//MavpmJ+r8obt64/ysZhS+5id3mHuPPne/BsF6qOSclw54CMIuk2+7T3QyE8ft2CMi+2bQ/9v2WjGFmUnP+xjtfrhOrUuHVKAZ4kxgR8d/gOFCZwH+7mqw53gzgRoT1tqVS9YeEJEOhy1AbiYsgRFhRGgS6TOIP919tuMacQ12EbqYsG+bceRi0LOYHJfKWhPYooghrU60UxT1XRz1+mGu3rCT/tQkfVY7tChJe5FCO8fS5zL6WRY3jp77Qk/A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TjFMK1E4MG5uTUx1NTAvRExyME5jNmowOG80cHFnM29KazlpbW82dWxlcDlX?=
 =?utf-8?B?YSt1NEcrbjJQRmtRa0FySTQxdmlteTVHMXh0U2VpTTBiRjEwQU91RVZMWTU0?=
 =?utf-8?B?UFBZUWRJVDhoWFk4dEVVNi84bzNhR0lWNE5YVkUrWW9EaUw1WUJlUTFvcW96?=
 =?utf-8?B?NnprSXJlR3ZpbTAvQUJGTUozRVJhayt4M2lkM0M0YUxZeHVyQlh2alFsWjh3?=
 =?utf-8?B?d2RqVmpxcVNjRkw4azgxTFY4aklvRjNCcXdXb1pLbXZZOGQyRHRPT09BenFR?=
 =?utf-8?B?VDNkTVRFZTlHZUthcHM0RTkvak1sNlVjS0wzUGRlU2tkOVlkU2drbTlxY2xB?=
 =?utf-8?B?WU1yV0d3TjVVcGkvVk9GRGkrOVFxbGNCeXEvV0wrVTBhS0d0UmIxc005Z1Zu?=
 =?utf-8?B?YlRLNjA4T29lS1FyN0FTSVozREZzQlZSejZ5WGlIbHNjU2xycHdEK0xaOWpX?=
 =?utf-8?B?TjhrUU1lS3hBN3lsbDMvQ3BQZVJ6UldoSE9tWERQS2lkRDBTdVNTNGFLSmJt?=
 =?utf-8?B?Nnc5U3lpNC9XakhQZlE2eCtIeEdCWUdiOWxielk0VDlUTGFVOFY3Sm5YdE16?=
 =?utf-8?B?V1pVWW9pV0tBZzdUYmEveTlkeEZTc2M5NjFaRUtRZ0JaOEZxb25WS085b2RY?=
 =?utf-8?B?aGJRbUszS0RROXZKQmc1SEdTVUliTmRBNFc1NkRYd1psME5ZSUtQYnIyZ0VS?=
 =?utf-8?B?TmVEQkFCSUE4V3paa3dHbEVnKzF3R29EN1VLT3AvQVJxOVAxWlFBMFdOVXVG?=
 =?utf-8?B?c2NXUU5BVkRaRWRaVmtUcHRrYmR5cWpTa3VMcGl5aUkxQWV3cTRiN1RKcGxL?=
 =?utf-8?B?NFp2b0luZnVLSFBGR1hQWUdHZXRhM01VN0dHYzErM2lmaVpEYmMrckJZMzJn?=
 =?utf-8?B?alVZMk9KcFF2aEZGN3A5VVRXZXJ5KzJvWDhOY2ZWc1BoUDBhVWFEQjllV05t?=
 =?utf-8?B?Ni80LzJsdnBnYjNUcW1HdmdOVEQzUERVbktFWTkxc3h2eWcxazVOVXlibXlp?=
 =?utf-8?B?U2xZVHBjVFhVRFZUZUJHN2pPVnQxaGxLT3RRSGI2SHZ0ODREOEEyVGtrdWxO?=
 =?utf-8?B?SWNVTitTcGYwMlJwMU5wVzlDTlpzaUpCUDJnUUoraHpsQytJZGsrUmxiM2dH?=
 =?utf-8?B?R05ITHEydXJEaHFIbmplN2dOUnB6N2gxTHhIZ0tsQ1hieDJTTVQ3M09aOU9v?=
 =?utf-8?B?VWNtK29RK25PWkx4elg3aDlRUk9vOUkyYUdHWnBmalMzcmU4UThtTXBPSDlE?=
 =?utf-8?B?Vk5qeXJlQkhDRmFQY0xLYXpHMktHdy85bjhuQ1NWYUNFREltb21XNzlNNXlT?=
 =?utf-8?B?TlNLMXZiYm5FbVFGeHMvc1BjV2VOYnVlaEN5d2Z6b050WGcwTjk3Z2pUZmtr?=
 =?utf-8?B?dmpML1NJV0U2RUpucVF3UzduUWhlekdwZ05LanV0M1A4VUVqNmFZNFdkZmlW?=
 =?utf-8?B?Q3YyQ1h2Nm5xbnp3M0tvbmhGazFPV2thVjBKOVRHZkhhWFhURkV0bjB6aUkx?=
 =?utf-8?B?V1pBSkZTbGtuUGV1WndrOGtyZFdBekFmb2EyNWh5bnhiMS83emxCZ3NvYjFY?=
 =?utf-8?B?YmZpUkY5dDBIalJRWUFNYzRWMXhBNDVBL24rbzR5MUJEMGVaeDBQdDRramlj?=
 =?utf-8?B?aW5vbDNaV3grbEZXam8wUXpDeUM5TGRKYlZuSU5DazgwcWtkRnpXcVdPcld5?=
 =?utf-8?B?SXlsOEQvQlBzU3lGZXdDVnFkYVhIV01pUWdlRForaFFzVW1SRzVzNFZGVU1K?=
 =?utf-8?B?ZVdtZWY2OHY2NDJJMkRqT21kMkxSNWZYektBd3NIZlpWR2RDSHBaQ1pPenNB?=
 =?utf-8?B?WVFvVVU3a29LZEZQOVV6bHJIQmRsTmlXbWpWNzQ0bDNUUHBNenpJZmI3Q0ov?=
 =?utf-8?B?MXJCRTltSTA1Wk5hWGVaOG0yRXl0WWc4SjRKeE1RYXkvL21oQ1N0TGcrOTZ6?=
 =?utf-8?B?cHdoUGtXRGVFOFZRU0x0TFRybVczYVZmNXlXUzVtcEpqMFJ6WXE4Z3FLYSs1?=
 =?utf-8?B?Tmt0bGRxdHYzcFUvOEdzbU1lNkJUVEFQVjBKQ1AvM3RGNlNVVmY4R3RPQzdX?=
 =?utf-8?B?OFE4WldKRHp0TWUrRmRmSjdtR3dNRlJWeEZjNFd1a3RwdUk0QTNwbkxaV0pU?=
 =?utf-8?B?MllyR0hyUUtYeXM5WWlQSlVzT0tMdGpCSGo3OXhDYzNoVmNVOXRENzB2cE1h?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wul6V22X9PX6aUubuoc9rUE9M+0s7Gu1yM6xWdwVpdfBZnCUMGeulGyaCbtjx/8M06k0qJMIrAq5gfD94nrgVIeFPrPkdPgJoQPQD5OLwtG+kRS46rCTwsGBxZJkXVisBIJwDBAX/9Isb0q2Nk9Hgk46O6LoEgu4b1soyHK+Qn2v50oB5nQZjSLElEj+JK8BK53YwEs46c09J6Oef6i/SM3+408Jmj/ryp/7ZWoJxACgDCb2fbuwAJpMDB4OpljbKoIVsN1WB+H/luE8GzBvXtzNWoPIju6bPlqIbS6SYs43+oQxEDVNq0Z3r4LvY56paYQaHL9vvGCR7nwZwEdTTmuNAbJs6sBBYVKPv5skfwAxxSguxoM6ye7kdA7QZib6sz0ek/PiODVe4ddC0JuZoDxnkTVDX5TxvJdp1SxcJh4Y5dB2FGI6NEfGOJXj9kMrnmIqTk1C4WgP1wN/6QeILdBGz7OLyMpUh2pLoyP03ivFXhvDs3gUOEh3smj/FQ/in1uBxn789s9Bxs/CO+qoANg0kkq6nlDv8nNIcQLArWFNgI/5SCT/V6E4BRFfnAkin9TQPI7JDc1/s6GI+nPl+SxRWVzVTIIKczmONpGjfoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052f5279-dc99-4f3c-dd0b-08dc4f0ada80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:38:41.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF8rFy4LUzPgi58smuHqo9QBGAloZGNmBsShq3ZAAzAFAej3ASkgqs7CH+7QDU3vU4E5cEo8+ZQKkMFrqCFSeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280064
X-Proofpoint-GUID: sI03H7tsn3yydF3QnfiWAvexmTBegtTX
X-Proofpoint-ORIG-GUID: sI03H7tsn3yydF3QnfiWAvexmTBegtTX

On 3/28/24 01:11, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of having every test case that uses _btrfs_stress_subvolume()
> removing the stop file before calling that function, do the file
> remove at _btrfs_stress_subvolume(). There's no point in doing it in
> every single test case.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks Anand

> ---
>   common/btrfs    | 1 +
>   tests/btrfs/060 | 2 --
>   tests/btrfs/065 | 2 --
>   tests/btrfs/066 | 2 --
>   tests/btrfs/067 | 2 --
>   tests/btrfs/068 | 2 --
>   6 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index e19a6ad1..29061c23 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -331,6 +331,7 @@ _btrfs_stress_subvolume()
>   	local subvol_mnt=$4
>   	local stop_file=$5
>   
> +	rm -f $stop_file
>   	mkdir -p $subvol_mnt
>   	while [ ! -e $stop_file ]; do
>   		$BTRFS_UTIL_PROG subvolume create $btrfs_mnt/$subvol_name
> diff --git a/tests/btrfs/060 b/tests/btrfs/060
> index 87823aba..53cbd3a0 100755
> --- a/tests/btrfs/060
> +++ b/tests/btrfs/060
> @@ -46,8 +46,6 @@ run_test()
>   	balance_pid=$!
>   	echo "$balance_pid" >>$seqres.full
>   
> -	# make sure the stop sign is not there
> -	rm -f $stop_file
>   	echo -n "Start subvolume worker: " >>$seqres.full
>   	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
>   	subvol_pid=$!
> diff --git a/tests/btrfs/065 b/tests/btrfs/065
> index ddc28616..f9e43cdc 100755
> --- a/tests/btrfs/065
> +++ b/tests/btrfs/065
> @@ -49,8 +49,6 @@ run_test()
>   	$FSSTRESS_PROG $args >>$seqres.full &
>   	fsstress_pid=$!
>   
> -	# make sure the stop sign is not there
> -	rm -f $stop_file
>   	echo -n "Start subvolume worker: " >>$seqres.full
>   	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
>   	subvol_pid=$!
> diff --git a/tests/btrfs/066 b/tests/btrfs/066
> index c7488602..b6f904ac 100755
> --- a/tests/btrfs/066
> +++ b/tests/btrfs/066
> @@ -41,8 +41,6 @@ run_test()
>   	$FSSTRESS_PROG $args >>$seqres.full &
>   	fsstress_pid=$!
>   
> -	# make sure the stop sign is not there
> -	rm -f $stop_file
>   	echo -n "Start subvolume worker: " >>$seqres.full
>   	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
>   	subvol_pid=$!
> diff --git a/tests/btrfs/067 b/tests/btrfs/067
> index ebbec1be..7be09d52 100755
> --- a/tests/btrfs/067
> +++ b/tests/btrfs/067
> @@ -42,8 +42,6 @@ run_test()
>   	$FSSTRESS_PROG $args >>$seqres.full &
>   	fsstress_pid=$!
>   
> -	# make sure the stop sign is not there
> -	rm -f $stop_file
>   	echo -n "Start subvolume worker: " >>$seqres.full
>   	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
>   	subvol_pid=$!
> diff --git a/tests/btrfs/068 b/tests/btrfs/068
> index 5f41fb74..19e37010 100755
> --- a/tests/btrfs/068
> +++ b/tests/btrfs/068
> @@ -42,8 +42,6 @@ run_test()
>   	$FSSTRESS_PROG $args >>$seqres.full &
>   	fsstress_pid=$!
>   
> -	# make sure the stop sign is not there
> -	rm -f $stop_file
>   	echo -n "Start subvolume worker: " >>$seqres.full
>   	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
>   	subvol_pid=$!



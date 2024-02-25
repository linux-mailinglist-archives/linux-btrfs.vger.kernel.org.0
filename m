Return-Path: <linux-btrfs+bounces-2735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF920862B44
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6150281B8F
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4AB168DE;
	Sun, 25 Feb 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R+OhpuPG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H7SrsbCq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887312B71;
	Sun, 25 Feb 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708875735; cv=fail; b=OE0Te3okQGUrNoiX//LmslE6giON+yjMEjc/1prATQbGNOFyjha/AwPCo3Z2jOeTL48qXMbVf2rSWIzgpNYrPeut8K//ChLWTJuomiCuxlk1ukrMGVHxsOlN/jlztMTLGfXcfNq2Yjs3SP/TK3mGHVsGrqU6lodnC4ye3gAtQuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708875735; c=relaxed/simple;
	bh=OsBCjbS3OjVkSj63AOd4ttgM3YLRXUI9TRi8z0OsC6k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YxnifZgo+fSPmf2rR4zgMXx3BQSBFJxzVu60NW65pb98CdXIr6uy7pD3lQPXJgkgJGuSbjjk57ahv6Wa77wYuiHnETWGX87cDX8upp/CfryiW/faxGv2eb8PvsinyL+c7O+G/p5ZY2sIvDjsznBgjROFGT7got5OKvhrmp19uns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R+OhpuPG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H7SrsbCq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41P4trXU013208;
	Sun, 25 Feb 2024 15:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vZADUx+O6/wsUVWogJ/7xnJXTZjycRkm0IB6vcr5FhI=;
 b=R+OhpuPGC3JvqBk5aP5jjgB/dGeLVbMDnNB49wIoOW0C//G0Z4zgtr/xNI7jK4V5LSvI
 b3VMdswAioFObNceL3CJUheA93oAvPMAyO3cgZJmPf8UsxC3Ukpg+sjLSSMOmsehyP1c
 wqkO5FK61hzsrsb7XMt773qLZGVsY90Q6/DDs8o8MgKhvKoVazv4YZGs5MWQUyrBSnao
 Gu5cMumFCwe7/IL5m8+br0IC10crPmmKdr95X2NxaC5Rb/cde2YW1V7zvHnZhJmirLrC
 JmTNm7B2Bu3I+GBossqlFShI8I7TVEaFLsy4XyOMtw8Yj+oB6yzNzsYJNRNPZK2wIGMl pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdayc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 15:42:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41PDjL4M040717;
	Sun, 25 Feb 2024 15:42:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w4ksx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 15:42:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx6OyMR2FmItQFb2axlBMU2aDQhprlY4hm4lfvGM2xXZvPCnWRQ33XXs8M7GfOushznSD0KHeng9N8MR5ff7vUKJEEAKQ4Ic4aiM7U4hI3xdnvEYO5MrDO1AfeiT+0LMR3/KAjuEDptjj4rw36P/qflWoER6jMT4AnAOU/zL+lkT9imIYm5Y1FIzYHjFxipIDa/dvZ5mUid2/yaobN5gK/B30SVqZtpCkoMM5v+FgdyJhRTva7SpQpYEM8XPBuPpvg+xjhEIcwU46zDfN8YUzWb6LXNkhhCi/fuseKUt/5ZvHT9InlL/v4UkWbCvfbi+p67NvqAmQ8zFjUq0VT/tvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZADUx+O6/wsUVWogJ/7xnJXTZjycRkm0IB6vcr5FhI=;
 b=gL2Ol1hAu/H7F+VyIPx1nxu+qvm5MVLsGLAI2yLdORSmaCYKd8rdV34YTX9FPGwmHvEA4ejZCWCzHEx+msc2sisyX0YSMXnoiW+PcUz4Q0JogMvLjV2Ff+CC8QWTa/gzguqTWQA7TpYxwym3SdnoM0MV1MJgtHEHyLZeXscGMBKMn32+NYp1m03YZdKx05HHzK8/ujRpZ0VwDA1GDiQBfNx4V+qPz83S8bkk0mroS2lZLxMmy8014E6BMEv4UIWP/G3g8RTj0d4qNKLZSLhOKWjixerbecP79pB63Cn5lLayYkO3FzHdK4TTCZYQsc4TgX/YTWZgBEvBPwlmO9RyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZADUx+O6/wsUVWogJ/7xnJXTZjycRkm0IB6vcr5FhI=;
 b=H7SrsbCqiP/6DqCtjqPLW6v6FwJmo3y4E5N+rDyERHd7A41SIOTDUpjSUEwkeAcu92uZ+p2qqjUiWqrxLTrQkAZ1F96rI9poyDYHhQoCdtyVQWeXgdv08k8lBZsROilhd4q7eXU7U+xcIDNqRcRo04l0zgrDjc5BXvlSZzp2y7g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Sun, 25 Feb
 2024 15:42:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Sun, 25 Feb 2024
 15:42:08 +0000
Message-ID: <31197684-04b8-41c7-9580-5f828b2aa045@oracle.com>
Date: Sun, 25 Feb 2024 21:11:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: add a test case to make sure
 inconsitent qgroup won't leak reserved data space
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
References: <20240223093547.150915-1-wqu@suse.com>
 <12c20a26-5632-4c53-a011-7e74a781724b@oracle.com>
 <ded4aab0-1bf7-43d2-8a19-12197fe19f88@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ded4aab0-1bf7-43d2-8a19-12197fe19f88@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f61665-5dd5-45ac-e1eb-08dc3618531a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hEers0xtRvVkYxgXE5snFo9zCGKmuh2eojanhkdr7RyCZUl7OdM8if3E1fUx6uyy24WcbChF0/7MK6e6/1UNUXN3+Jq4odO75h6/6QHde8o3CrGrDvTWHr8sOFKm0o3GRKDEkbMuSSv4TvP4FGxJYvQIGYVBoc64PTQQRckFU77528nVie5gLaQF+VvSHpKrPfKY4R+qzCN8xU6cPFm91uQuZfn1OH8QDjW5Dg8eRt6yx01Gj+rEKiVi8CWEbM+6lRZ2aTAPdABqBB7YoTN3+UP9qPZ5jTpNK4lJrKPUpLYlml2zalQF6Wl7LlxIBUQrp9SOgZ3RMrycnVWB9eq2x/aYCtesqr3vnqEyAjf+ofr9e9NNKQRi3jJGtb3RdBnEL3kqf99RxmkHf9AMICshiU8+xlmmuf88mrt0qQUH07QbpWCKFARi7lClCs9ZYrYD3dc6l+WSZ4o40qIjnwtnGVSx0+VAW48ZuWLrmnrtJv11dgYbNuJd8RbQOO0+QUfWr9j2C1UNuLiurcPKg24aiRk5cxc1Gwg6JoP9LK+lAvUAAkaxii/J0AP482sa0TTG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1VLaU9UWmE4QU9oMytITCtNZHJScnhrK1VzMUUwa0drMThGWkliMXlOLzFj?=
 =?utf-8?B?TVdNaWxWN29NV3pUS3U3NW5MeHZyN1BCNWp5M05OY2JUWE1lZUVqd2lXZHlD?=
 =?utf-8?B?UFBiWVdObWE5L2F5alZhWkZKMmlzSlpVNUdzb1ZvZmQ3OE5IMkY5VGZnVlNF?=
 =?utf-8?B?cE51MHRQZWMvQmIrTDZERHV1NXdZZWNPMDk5c3F1cTlOTzBILzVRUXhCRlR6?=
 =?utf-8?B?ekR6MjFUZjFhQS9UT2swb0VJUnZteVdMcFVoWHFad1gyZnVuQVRmNENRSTJn?=
 =?utf-8?B?UVpjRGFWNUQyUTVKQ3gxQ0k5dGpTTzlKaHVsbGR6VEdJdjhlbThadThwSDJ1?=
 =?utf-8?B?cXJ5WWV2WEJhdWJSZFBtQXkzWWtxS1ZyeG9NaG5JY3hLZnVTNDJKWW5sWnpk?=
 =?utf-8?B?aC8vcFdhRHNtRkpQNGF6S0IrVDV2OU5aaC9kRG95V1B0aG9JOXdhVlBadDBH?=
 =?utf-8?B?SVZNc244QUxDUnAxZndESHFUQU5EcVdVU3NHenJ6THZXMGtoSHpOaW5tb2lT?=
 =?utf-8?B?MUNNZjk5K3lZdENTVjIva2JuZlpNbGE4SzdpN0xWQm41aTl5VHRCWTlNbkQ2?=
 =?utf-8?B?amhBZUt3Z1dNN3pjazI1RGgrakhBdFJXZXBtTXE2VE1ZMVRqMVJlckh3cGI1?=
 =?utf-8?B?cFlJM0owQmsvejF2aEgvZG10WVU5WjFta3JyWk1Ubi9WSHZ4OXdxTEh5MUVs?=
 =?utf-8?B?QTR1K1dNWWVkanpGeUQ1SWdibDBNNXNXaWRpT2ZlV0w2NElMcWZrM2wwZ0g0?=
 =?utf-8?B?OEM0dW9PZzg1T1ZuOXhuZS8vMnRuaVpta2FLNmxQLy9NeVhsOE1qemRuMW9v?=
 =?utf-8?B?cHJDcFZZbTZHMWxiaWhVMmpSMXV6c2ZyNm9ra0FtVFRTWEN5NXk2TGx4UVQv?=
 =?utf-8?B?QzFUTlBQMnh1NlBTUkw4N2RpYW44d1RHKzA1SFRBbGlJQVlDTTVlcjJCbTV0?=
 =?utf-8?B?RVlFdUQ2eTVxOElURmRhK2hFMjh1bzNhTytKem1mTys4R3U3b1phbzVKcmFN?=
 =?utf-8?B?Z3RrZDRrclFMcnIzeDBlaE9YYUJtNXVsNTBNbE9zSU55OU82eEVRVUNvRkhp?=
 =?utf-8?B?em5xK2Q1VVZBazFNTHZUZm1IUkJKK3FMMmlLaTBQVG1sLzNvMENyN2tvMUdo?=
 =?utf-8?B?RlN6QzdhZ2RyRkhrUVBjbWtGdWdEbTdnY055MmkwNmlFYnp3NkZOaDhHKzRX?=
 =?utf-8?B?SmQ2TFlDSnZZY2hxYlBNdENnM1JQMkJUMWR3bWVrZnN2WVZFamFuUWZDd0RR?=
 =?utf-8?B?cXoyL3RxMXdlQjhQUkNCVERSMjBkRHJQMms1VFR1TFpvVlFvd0FNbGRNVk9L?=
 =?utf-8?B?Y1BjUlVQQ0tSdDVjcVFoWGNaNFF4T0U1REthUjF0QUpMNkdDQ2drU1EraW1i?=
 =?utf-8?B?VUNJN1ZXSE1VcnAvSlhlbXoxR2lwVFVmbSsrSTdtdjBWdlYxVFFrZDdsRFk4?=
 =?utf-8?B?bzQ4anVzR0psaktPN05YWmtGcVdSTGhOMGIzaGx1Y3g4TURHUXBUVmtQcEh5?=
 =?utf-8?B?TG04Z2ZNUkRQLzNOemRSd0ZlbE1aRGVqcWtURHdoS1dReGE1QTVONHRjSk9a?=
 =?utf-8?B?T09SVEozamZyTmpadGZBVGRObVYySTVTTVl2YXpsOE9XdTc4OWZyMDlFRGVt?=
 =?utf-8?B?TVlnMHdnOUU0MUVaYldkT2kvcm13UGRRWnBWTFh5NzNGa29QUFZiU1UxaDB5?=
 =?utf-8?B?a3NyV2V5TDBZNjNPSFpkcFh3YWxkM0gxVG1pOTFHcDFMVDZXNVpaZlY2T2Ft?=
 =?utf-8?B?bTZqc0pneEQvNXp5WlE1Y3BSUHJCU0M4dlRaTUJoRkpWQWJaWms0UzAvN1Vr?=
 =?utf-8?B?aTJIbmIzWVI2eS9VNkg3LzA5TzJrMlJWVEZ6Qmt3enVhL29GODNkVm9RQXpj?=
 =?utf-8?B?eFN6T0RqMFNuSVFWa2pmbklFYWxQYVMzR2ZSM0VxZDZESlNlZVpXa0xJUjVv?=
 =?utf-8?B?UmpTaXdxN0RiVURyUGNHai9KRG1MRXZXOXJ3N1dVVDI0QTRPWXJhTnZJWGta?=
 =?utf-8?B?WkR1bTFZUE41R1dwKzlNODMrUVZKY00wMzhWMnhjKzBhSWVTcUJPakdwb2Yx?=
 =?utf-8?B?VUlXUEZWWllRc1RHYlRVNklxTExtbW9GWEpHZTlId1lGc3U0clJZVy9uTHlk?=
 =?utf-8?B?ZWg3Zm9JR2FqWWFQL1JCT3R1cVQzS0xwaG9JSjc1K3o3NzJPRlFrOTJ4bUI3?=
 =?utf-8?B?UmFmQy9aRXcybDlpNDFETUE4ODUxMnpiRTVmMGJ0RVd6RnZ3YjVEK2Jia2ZY?=
 =?utf-8?B?Y3BhRnNLZmU0RzJoSm9iSmx1Qnl3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jxDmy5JY5GkPG/0gyQTnlq+9GxQodyNnDMhgvFvSyxVVCx5JWD4h4GhW69grxjYqoZV+sHt6BixXqOYQbhyqRybyerYghMTJXihrZDaJeFOb68B+38d/kdsCj7A9DBDiifhlGgQXQEfTHxVzctXP6O62RLGP19qW8tBy2Z8hY9Iqexo1mwlPHI9O6/qORNrnOwqX4FZ3F4f9G9Up3r7LKXd0H9305jzUuoWyMn6wKQVDqMSsgUf7QI0H1CYmfKJLOYXSAHMrGQRcjITQZp7cAUmB39EhDHXF4UB8nidQZfJGyKcV9vUT3NPEPclJz7bHKyg+kuszSi4tHq+9sQ3BaeWEF8FHrgjOsTHjuL5QvGuMCChdT3IxHBPUbppUOZoqdW+9vpXsMyphWIvRS0O5vtM3W1eUyEaSIQ2PFuNcQ6/VWQCVkU0WA63Y+dNfjReizc+vvU9D/PLnr2n2Dnu+r310Bb3CgJyxGWx0cGxAaodV6Yt968GCViL0rleOekGYBsIawsmIyEV5sAtmzC4sMWOnneMUBVw6NrHgzZUK6RXSGLhoeojBb9xFCqpG/NeB7lEzI/rm/cyCnLsRE0cQMR4hXK1sgFPELemqAnspUvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f61665-5dd5-45ac-e1eb-08dc3618531a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 15:42:08.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUkPe1zUN3LoVR6oU0QHVjl2JJxcAtkeK5pRhuvCtsZjEU7S0f7fIvryfo2rYv30UaOKJjRE8N+fc89qXKtveQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_17,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402250125
X-Proofpoint-ORIG-GUID: HgiOsXXXsaDNYIZBWf9ncfQ5cMbzX_9s
X-Proofpoint-GUID: HgiOsXXXsaDNYIZBWf9ncfQ5cMbzX_9s

On 2/24/24 01:21, Qu Wenruo wrote:
> 
> 
> 在 2024/2/24 03:37, Anand Jain 写道:
>> On 2/23/24 15:05, Qu Wenruo wrote:
>>> There is a kernel regression caused by commit e15e9f43c7ca ("btrfs:
>>> introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup
>>> accounting"), where if qgroup is inconsistent (not that hard to trigger)
>>> btrfs would leak its qgroup data reserved space, and cause a warning at
>>> unmount time.
>>>
>>> The test case would verify the behavior by:
>>>
>>> - Enable qgroup first
>>>
>>> - Intentionally mark qgroup inconsistent
>>>    This is done by taking a snapshot and assign it to a higher level
>>>    qgroup, meanwhile the source has no higher level qgroup.
>>>
>>> - Trigger a large enough write to cause qgroup data space leak
>>>
>>> - Unmount and check the dmesg for the qgroup rsv leak warning
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>
>> looks good.
>>
>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Thanks for the review.
> 
>>
>>
>> Queued for the upcoming pull request.
> 
> So for the btrfs fstests part, you'll do the pull request to upstream 
> fstests, right?
> 
> In that case, if we have some conflicting test case number, how do we 
> resolve it?
> 
> It would be resolved by you or the author would be notified and need a 
> resend?
> 
Conflicting test case numbers are resolved during integration,
as I've done for this new testcase. You can find it in the
branch mentioned below.

> And do we have a branch to base our new test cases upon? (Mostly to 
> avoid the number conflicting)
> 

Yes, you can view the upcoming test cases here:

     https://github.com/asj/fstests.git for-next

By basing the newer test cases on top of this, we can minimize
the chances of conflict.

Thanks, Anand


> Thanks,
> Qu
> 
>>
>> Thanks, Anand
>>
>>> ---
>>>   tests/btrfs/303     | 59 +++++++++++++++++++++++++++++++++++++++++++++
>>>   tests/btrfs/303.out |  2 ++
>>>   2 files changed, 61 insertions(+)
>>>   create mode 100755 tests/btrfs/303
>>>   create mode 100644 tests/btrfs/303.out
>>> ---
>>> Changelog:
>>> v2:
>>> - Fix various spelling errors
>>>
>>> - Remove a copied _fixed_by_kernel_commit line
>>>    Which was used to align the number of 'x', but forgot to remove
>>>
>>> diff --git a/tests/btrfs/303 b/tests/btrfs/303
>>> new file mode 100755
>>> index 00000000..9f7605ab
>>> --- /dev/null
>>> +++ b/tests/btrfs/303
>>> @@ -0,0 +1,59 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
>>> +#
>>> +# FS QA Test 303
>>> +#
>>> +# Make sure btrfs qgroup won't leak its reserved data space if 
>>> qgroup is
>>> +# marked inconsistent.
>>> +#
>>> +# This exercises a regression introduced in v6.1 kernel by the 
>>> following commit:
>>> +#
>>> +# e15e9f43c7ca ("btrfs: introduce 
>>> BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting")
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest auto quick qgroup
>>> +
>>> +_supported_fs btrfs
>>> +_require_scratch
>>> +
>>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>>> +    "btrfs: qgroup: always free reserved space for extent records"
>>> +
>>> +_scratch_mkfs >> $seqres.full
>>> +_scratch_mount
>>> +
>>> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
>>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>>> +
>>> +$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
>>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 >> $seqres.full
>>> +
>>> +# This would mark qgroup inconsistent, as the snapshot belongs to a 
>>> different
>>> +# higher level qgroup, we have to do full rescan on both source and 
>>> snapshot.
>>> +# This can be very slow for large subvolumes, so btrfs only marks 
>>> qgroup
>>> +# inconsistent and let users to determine when to do a full rescan
>>> +$BTRFS_UTIL_PROG subvolume snapshot -i 1/0 $SCRATCH_MNT/subv1 
>>> $SCRATCH_MNT/snap1 >> $seqres.full
>>> +
>>> +# This write would lead to a qgroup extent record holding the 
>>> reserved 128K.
>>> +# And for unpatched kernels, the reserved space would not be freed 
>>> properly
>>> +# due to qgroup is inconsistent.
>>> +_pwrite_byte 0xcd 0 128K $SCRATCH_MNT/foobar >> $seqres.full
>>> +
>>> +# The qgroup leak detection is only triggered at unmount time.
>>> +_scratch_unmount
>>> +
>>> +# Check the dmesg warning for data rsv leak.
>>> +#
>>> +# If CONFIG_BTRFS_DEBUG is enabled, we would have a kernel warning with
>>> +# backtrace, but for release builds, it's just a warning line.
>>> +# So here we manually check the warning message.
>>> +if _dmesg_since_test_start | grep -q "leak"; then
>>> +    _fail "qgroup data reserved space leaked"
>>> +fi
>>> +
>>> +echo "Silence is golden"
>>> +
>>> +# success, all done
>>> +status=0
>>> +exit
>>> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
>>> new file mode 100644
>>> index 00000000..d48808e6
>>> --- /dev/null
>>> +++ b/tests/btrfs/303.out
>>> @@ -0,0 +1,2 @@
>>> +QA output created by 303
>>> +Silence is golden
>>



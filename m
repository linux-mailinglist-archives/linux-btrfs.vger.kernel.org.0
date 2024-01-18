Return-Path: <linux-btrfs+bounces-1543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD6F8312A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 07:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBF51C221B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C86E9444;
	Thu, 18 Jan 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kXy8H/R5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XnYe4KPf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0979E4
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558583; cv=fail; b=aYN7WtLcxrk4ifj8boy8xPr4MiFPJb9Y4VnkQ5IM/S0boCyrxAuwgvgLFZoJ6ICPTol6OQNPQaDb/swXQdRCVrJfdWWb7t43QmADJpYveB9i7javUDqk90ChCQBxwCje8ZWRmo4Yi3AEPCReJc4tdsBrW3qztr7y2Mv1XjyV2HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558583; c=relaxed/simple;
	bh=TNAbX7cK53noz/6/vH1dXOxePhSjpNtBI5fKwEoiLkE=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=rUHUlo0Xm7SiOM0vgfAkUAZtWjVEB4iLI5XMgduXd4H7xFTV1zWKPFonuamXgt+H9PVZBnNF+4Ht5q4GHGXnxLRKyL2S5ZCAlwMr94rZWjF0CuuStPu6gcNitOXmicWOh3Wc2NeRE2wIVhe6a4zx9beLD0wkRx32bxfm76TJ1LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kXy8H/R5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XnYe4KPf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40I0IxNi024194;
	Thu, 18 Jan 2024 06:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=f3PQgJN+5GH3/SUN8J1x8Ln5btGLUuVudGhJm+mwhio=;
 b=kXy8H/R5kUctTWm87XDVF2Ue5U7BG+IyDWWZQzs9Nsj0tg+hMXjVZu/j4z66+23sHDNo
 bjn+vxIgedbgDiJmz8cww2UR5h0JTnOW/wsfbO9mM8gvGg7nGa7wEdIofR62gyvavCWF
 PRtDoBc6T1/FfMn77kw7XwScfvlJiOODXOrxRTQQ9f2vPaERQjuMXEjB2r1jbINxAIhV
 8c1T8H7vgTuQW47pvRL7ba9vZ1B3wXIpMcd0kt+Kb/5C0vb0u0HWhfAu/bCmT0NvWqw0
 8/HAlvgL4+Dx7eKwHXpnESlNKjw9FSr0+BV8o5kPF/h22edfbwsesZ98Do23e5NMYwul 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkqce1b45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 06:16:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40I4YDia020141;
	Thu, 18 Jan 2024 06:16:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgybwhu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 06:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZPGhaD5ccv7hW9Y0z59q5m3TpA8WXtmvGsFZJC/H/1i2wlv1JLolTuAoqKA5K4qt4N3lSZU4N+OkiPQxn712dcZQoRrKZDOVfc4eHJcHyrb/pxx8wdCuB8Bq/6exxOCmuQ3wvLeNb6q2dxHgfcUAPUmLX2h6jhDRORftCLOlKpjJy33vcK1QEmcWxKkvwVBLB4R5AlhwnAelY75cGiJVbKkcSm3ZGli0xy4e3d1Ymn/U6Bjwh/lAVO3nU4v8lg7Lun4rlXy3tFWMRtWYDdtL1+ziC44MAKD8gYfsXZw4S2fiKG23GSqBGJSFhnnDfHlchdOjmKjSxTEz0mb5IDCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3PQgJN+5GH3/SUN8J1x8Ln5btGLUuVudGhJm+mwhio=;
 b=k4sbTonsMnxm1GBXBI/LyEJ8EN9lBJB3goXVk/4GwSt5j54NBFbGSo4LAiuMMm3Q+8MF3OG1hUbsOpO1UTAxIBGFNwVh89vxK7Cv+DAvub0tigXCP5LJcpNE41YDQoQlT1eOcyhyfTxyaqCl/gGiZxrbP4odfcDEFiwmVwQNSt2RJCshYev5A0sJ9JPYC/xw18vYwpDmVDomsz9906KJ4twQ3M3qR2ouzS9UGdnXRO5K/SIG48NCXJdOQeUZssRKCcIG9N4wpDW+fsphnif82f9ZPqID9OQIG9x+Yv/rCMvCrUj7TRamvGwSS+lqgMgGlY2Yo4io/LmfyM5geHZw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3PQgJN+5GH3/SUN8J1x8Ln5btGLUuVudGhJm+mwhio=;
 b=XnYe4KPfYG+DOAf4K6MSlz7dCSl08VUbyWzDQQJGeMbLN0blaMn9f4uHUaSbIIpjxXDjdtwQWn2vpX7ImHyruzvlq897Pny+qgATEKwBvevM4efP7sTuRw3gAUh0DWohSU/L98XgbDqVNUwcMPHQ0dujSiwZp6iL79ht+W62oOk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6272.namprd10.prod.outlook.com (2603:10b6:8:d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.31; Thu, 18 Jan
 2024 06:16:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 06:16:15 +0000
Message-ID: <99eb80c4-4434-4d97-87b8-c4f4e7c3c5cd@oracle.com>
Date: Thu, 18 Jan 2024 14:16:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Block size helper cleanups
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1705511340.git.dsterba@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1705511340.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 981362e8-539d-4a72-239e-08dc17ecfa16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Cp3ZwuQAp3KhHFrKRw/N+M+WEy7ad/X3fI1P6XNu/spSqcr5bgT4waQhaxjfcZ5BO/hNMhoruYZtfLY5UtnUsUR/xWIXudcUnaFQF1ppSocUjQ0Lj5/mLh0ZU8lm65gWxLX91hcAKi/uD7IgfGnmi+oRPNe2KaKM1rMJUV9D0ppAfvSolbQZJfASgy16/bX8t7AN/Y2SS/ec0VxGv34eZ6hnYy75HvssXTgeo1asDFXDyg/Qj4dnvBpNNwOBrJmUfrmEYxAGu7IRzIukgoblZvd/k0p/v2MumkotQU9IbBADv+49F6XqtaMXEjxvnxfBSLXeSgPHRCrxU8eRELY0kXoTjSfxLGEHKv13YI+YyvVLq+svRV6A3yhglYzJjIOJJA/f2ASWqoSBGUPwwavj0jtS1vwvzq52rR/W1FBObmKKPcEJnOWXQE3RoXb5jgybM5/Kdx4Cgdx1l36VmeytYt5zT6X6RRlERB63ErrpqSoEBS0O03itbnG3q7/MdHge3qaby8Jgpy8mlubcpaNZ2VpMYmu6LtTHdsEYREMNPCuMtYJMMx1eQbgF1oIp+K+vC9CPvfQK6wuxe+umv7XQXwXZbRq6W01twcHnrV5jZvAnlRLaPN2IdA/MiIIWuEBX7JpxYShEbavHjJ+kMJV6cQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36756003)(31696002)(86362001)(38100700002)(31686004)(83380400001)(26005)(2616005)(6512007)(53546011)(6506007)(6666004)(478600001)(6486002)(316002)(66556008)(66946007)(8936002)(8676002)(5660300002)(66476007)(2906002)(44832011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?blRxVjBUZEtITlczZ0JIM25hMHRwYi9obk1OU1crRW9iZXRFcmVaMFRrKzNH?=
 =?utf-8?B?MkFaeVFQQmcySVZWdU0zU2FhWENtN3ZQTWtFSjRuR0ZOS0J4b3h3Qk9XSGNV?=
 =?utf-8?B?azUxTURKbHQyN3BRdW11dElwaTJhVENHeEZvUVlDaHRUNUNwOEg2ME5sd0No?=
 =?utf-8?B?dUp0MHUzcmVRR2VtbU5DeGllN2dxQ2hlVTdQWUc5bDI1SEhnRUVnM1pDMkdP?=
 =?utf-8?B?ZlFOUWFyTjZMODFYNlJIQ2ZmSlJId21pZDlFN1prL3N6NkIwTlhFQ1pUSHY2?=
 =?utf-8?B?bENrK3pDZ1RHK3FEbVllSjk3MFZvcnRlekF4UmZISVFjUktqUE5IVFluUnZR?=
 =?utf-8?B?eWdrNUl1ejFCUXh3TEtpS2taOFUxOWYxZWhDS1daSFpTUjljQ2NIQnFYVnh2?=
 =?utf-8?B?cmNEVElaSDdZSU9OZDAyNmRPSFhWdkczNmg2eUw2QlhoZVhHeXJ2UE14UEIv?=
 =?utf-8?B?WWNKc29Dd3ovQU10bkMwVU96QkU2Yk9rMjgwM1dKVGRYVHdzZ0NVZ3ZNSHd0?=
 =?utf-8?B?dWMzUitVV0NWVHE0bUxhaGFiaGMvYkc2NWkzY1gzMm95cis4V3FRWG9ZYnNq?=
 =?utf-8?B?Z1ZzSkJiYmdiME9naVM2NVd6Z2kzTHg2ZnIrVkFpUGd5SGRsMytxa0dxYkpS?=
 =?utf-8?B?N3Zmc1ZqNUVCSVdtWmFQY2F0dGQyRjZkbFgyc1RQMUJ6aTVPelByZ0NueXpK?=
 =?utf-8?B?L3lIc3VyL0RqelZhZ1FpQWhkSjB1Tjl1cWhuWklpWjJoTVFHNDNLeDFXbmpI?=
 =?utf-8?B?QlJrTXRyck9Dbk8yemdlMXV5dkQ1VkpYQnhpbUNQRElzSGc3dldFTzBGeXU3?=
 =?utf-8?B?YXkwVG8rN3k2Q1ZZVFlSaEQwdUtVQUVVR3FNaU5HWmVFK2JBODlRRG1odk5N?=
 =?utf-8?B?UmZYL2JyVnhqZ01ySG1qK0JXWm5yRTVqaG1wczJTVjlXVzZObFc4VTg4TUh2?=
 =?utf-8?B?eWhxa3ZzWksvWXpvd3V3dWdEd29sM0hCVWdWeXhsOXZTSjRQNkpKZjZuTklO?=
 =?utf-8?B?UzI3RjlQeENuRTFmWUFieGlvQjJadGFGWWxMSmtuWUs0VWlQbU1XaVhTUWdw?=
 =?utf-8?B?ZUtXMFlHdWFBSEVsMGhyL1p5KzI5Rk9GOWl0aHlSMk1yZnpROWh2MzZka3Zm?=
 =?utf-8?B?WWMzOUJUaW01MDFYZ1JGMVhrUUxhWTVIWmVuUWpqNjFPeXRnUjFHUnZrTzNa?=
 =?utf-8?B?YkxTak8ydWJUQWVZL1ZxL2pwUFEvUXpQOENEaUU1R2NjdGp6b3Q2c0lZdVNj?=
 =?utf-8?B?dXBIQTIwUExORXBERVEzRlVTQkczWlUrZElJOUtxRzRHYjJPMmY4MHJvOHd4?=
 =?utf-8?B?NUlMUE9yL2Yva2VycmRiZjl2eUl3SXY1bVFJWCthSis2cmc0cUZPeDJmUms3?=
 =?utf-8?B?dzlOOUI1WFhGVy9Uekk3NkdjU0grRjNwemUrYVNjMUVTMW0yRU1kR3NHbFJD?=
 =?utf-8?B?dWUwMUQ0U1JrV0tQV0QxTDZycy9NYmh0RnZVSGdVWEVTY3Z0a0d0TFdjM1py?=
 =?utf-8?B?WlgzbEU3eDNLQ2U0c25DUzZ2UDZQR2ZGK1VkT1NhRThSUmNrclY5ZSttYUpw?=
 =?utf-8?B?M283UExYcjNCeG16b2V3K2RPYnQwQkN5VVZSdjZ1eloraU5vdkhacW5Vc3hl?=
 =?utf-8?B?bnZRNGljeHdvRmtkRWY0Si9kUGZ1dzZXazUvaHAwSUhnNmkwRzduVHM2YUJl?=
 =?utf-8?B?ZE5GTER6aGRQalh2Q2tBZG9IbVk2SFFZcjhSNDczRlZEa0x0alpGVm5WY1Q0?=
 =?utf-8?B?aHdIYU1xS08yWm50SlQ1MDBXMjBtc1NXdkZsakZlNWtEN3BZTk9MTmM3YjBC?=
 =?utf-8?B?ejJHOG1FRG5EdGlhZUkxeWNPTFp1Z2NrT0ZJZ0ZEakM2OXQ4NnNzYml1Q0k1?=
 =?utf-8?B?SWpTRHY0czIrVEZyUEJpSjRSZ3A3a2orU1pzRnZxckRhQU5hTTVMOENKWWs3?=
 =?utf-8?B?SEJreUFzcUNHRU5YVWNlTnRkL3ZvWWxqUjROZzhQMk05d3lEK0NPSzRVZlV1?=
 =?utf-8?B?WU1oanNCaEh4NUpSbkgzcXc0cmhLZC9zU2h3Zk90ajZNV1JlRU5nWXlIUnNh?=
 =?utf-8?B?WHNYdU9ObXJJVFJvV0ZRbmZJeXdNZVQrZUtOT0NRRXFJM2ZVdjdsWXp3Qkl2?=
 =?utf-8?Q?UMzk4kE5MC3Kyj9IUl9CNGw7g?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0GAEFsbsX1wtw4VkektYjNqk+Pwino5mjSDbMSzT2mZkxfdHXehqiC2H+qQEx14VLucfy0HFhWWJPvb8tYJauHWnqPTEnhdn3EIQOdW1A3vzSCqX5pZYAwCDg99IvgD81LmNQeUlL+5ygnYViWPGagTYL2UtJXIz8frbwsFv+ye9zsNvLpME/K0rxy9W1CrVYuNRRbIi69T6fWYiW8Q511o1uVg7CNXGQ3M6759pERO+rgsuMWZXM+tzv1ID7/mz2FdQP9CxZlFfKxc5FX0bdgx9k6YBNUn5hXc58Rw5+TUwsqO6CT+ILlYFwwC5Iqia1mau/4GktKY8BL8cic7TTN7KH9KfgaiEwRldLC6dntqbPvpvCrJDJFeq8u9rCVn9yX2MZmmgIDu8qhPdXO8LwUC1pQ0R8NLshqBZ8dz/5RqMP4Ab4x/HLVFTXTIBk2yToUMeapTVWWoyQLZ/zg5ktzN8Dnqapvs2V8W4kA3esqj+qkpVSdsHp2+9sYDdehkIRFMuVYL6P4uRyhusDtKcWwKIQWCm7iBrfpFE8OQxLeLPdH8NnskVoyaB6kbAAa++MtPEbMgBWQNProW/+Y6liG9hdDmTor0aHU2iOpBBlvk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981362e8-539d-4a72-239e-08dc17ecfa16
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 06:16:15.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vihRk/6JFZRa3Jl5mlwmQjKBGl1xHaOTR4+odh6oP4gfGbOYLgPK6cvnZpwIgkZWaK9iJDJooQtMsYnGCRUGBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180041
X-Proofpoint-GUID: oj6oRAVXgfRVICqQpp91oN_XgzjvxPmv
X-Proofpoint-ORIG-GUID: oj6oRAVXgfRVICqQpp91oN_XgzjvxPmv




Sorry for the late comments. Looks good

  Reviewed-by: Anand Jain <anand.jain@oracle.com>



just one nit:
You may also bring the following repetitive code into a new
helper function as it is used once in init_mount_fs_info()
and again  in open_ctree():

         sb->s_blocksize = sectorsize;
         sb->s_blocksize_bits = blksize_bits(sectorsize);

For example:
   static inline void btrfs_set_blocksize(struct super_block *sb,
                                          int sectorsize)
   {
       sb->s_blocksize = sectorsize;
       sb->s_blocksize_bits = blksize_bits(sectorsize);
   }

   btrfs_set_blocksize(sb, sectorsize);




On 1/18/24 01:10, David Sterba wrote:
> Unify using fs_info::sectorsize for inode or superblock.
> 
> David Sterba (2):
>    btrfs: replace sb::s_blocksize by fs_info::sectorsize
>    btrfs: replace i_blocksize by fs_info::sectorsize
> 
>   fs/btrfs/disk-io.c   | 2 ++
>   fs/btrfs/extent_io.c | 4 ++--
>   fs/btrfs/file.c      | 4 ++--
>   fs/btrfs/inode.c     | 2 +-
>   fs/btrfs/ioctl.c     | 2 +-
>   fs/btrfs/reflink.c   | 6 +++---
>   fs/btrfs/send.c      | 2 +-
>   fs/btrfs/super.c     | 2 +-
>   8 files changed, 13 insertions(+), 11 deletions(-)


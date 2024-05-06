Return-Path: <linux-btrfs+bounces-4786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF898BD6ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 23:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE022828A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD815B97E;
	Mon,  6 May 2024 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Igxs+bJl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CTW7RGaE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A01411F6
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031487; cv=fail; b=MNk+OjciaxgSy661zLDv2vopf2y8XThmV11kLKwd9jKZ/42rc/we6h3O5I0GySctkZWxoJIGGo9GqlyCp4X5CWkCSI9xg7N7BJIAwMNp7Q7KsA4ay3yaY8C4E6bKGeWlHIg6O6cEG6j5n7ZPnXCLMLJiAGm9IqfwHZ7AfznGNP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031487; c=relaxed/simple;
	bh=TxnlpvMHCULnWnuED7FxOjj7LDWqpFc/LWPkiT+2CbM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Og1XdTOpvkcjrAJ4PCBxJwruDHm/z9hP25ACSmaPZ24W+Bfz+liPJHYRb9DqdoEQR64EAwF1RZ2wcbdd2RPrZ+58KxzZQurln4unG/uJTE148e6Kyvt8ydKBwnZww4+OSFe0o/2fvxHpeE02pQBDTNSFZdZpnLko3fVnNW5JrVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Igxs+bJl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CTW7RGaE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446IMAvs010263;
	Mon, 6 May 2024 21:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=z17lVB6/v7QMLiprj6k/HE91LBx6BZ6g6uGq06NeMgo=;
 b=Igxs+bJljnrkIfWH1Pxv3C74OmgJ7rRn1TdZM/EZGR+gWS+g5mQ7zbT3zMJpq4AOIyRI
 nuKJdQkG+hj/pnFpimjgmNt5gUwD6VSidodRyKl7jKPAjnuOKy+3w+nWcORISUBJT84M
 MJdNpVGuMHFtQhngsLu9JY8eEiGLqU5VwnV5ALVe9a//uXRaHZYpvG84m27nG6R45iIy
 jsV7a3v9M/+7GzgZRwT8VSFGHOmdMY3MnpxM2i0fgB2Lp8crh324lu/cay6xgzmO5x8e
 YHbK2xYX+n9EXJN2M583QkUoO/p69YnWNavk3/dNPhFfFd6uzOytJoLdocE3Aab3Y8yH gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbxcunf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 21:38:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446LLm2J006907;
	Mon, 6 May 2024 21:38:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf774md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 21:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/MVWRZzf98djqFCzWmzETsyqSf+DIS6QrM50ITjtjJjyt/63efSvNyIIjtCNGIdxrKWyNucammvmdZ5KL7gnslg0gC+A/ekAvwILArRmJ2ElkfQXbIjnowH+e3DV9UuRwuHNAqlt/qhdBI30hyraqDDxB/VdvsvMFcnNogUkie63AkJzFh6es74NItjlvEPO2IQDwBppQ+WmUM0rX0XMcwwUUOsFTy9srvnZkrEDw6IAF767sZ+qf89Y0e0iSKBejb5wl1NX4dVlBGMofIQgajmNptGd6CSXcMejpBAiut0jSajv4+2qXVvvzp4JLh+o65PuIDOT2FJFtYre14kRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z17lVB6/v7QMLiprj6k/HE91LBx6BZ6g6uGq06NeMgo=;
 b=Puv4EOHXUC1WntYr+x+hBrx7ZuCuI5dDOkcvTtiJF3HakN/bG39xYyPL/+AMFSHWrrzjwTBNS8Z1MNIjhqBOfiXn3SxffRvyfPEl5EjwPejS40lFdvPoIkC7k+pHfSTE3Qjot7Xv6/HTA1Qbm9MmzVMFapFZYZrI3Ss5FEVOT0sidWw5BHOp4cJx3X5i+9YXW9Zq2hGqglF9mSdm0TI+OoqkZgiTkeJoNDdT8buYsiqdjDFB2YP65QSwWj4RcdzfboOByCSxVmwoPBbAjDR9DLhzzf3OCxdeKJSSoF0rqikyxwADYzFiwHFXNnljg0izLpGQFCi2yx6ZGg6b7Dkw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z17lVB6/v7QMLiprj6k/HE91LBx6BZ6g6uGq06NeMgo=;
 b=CTW7RGaEHHAcwc0aZibiOtMpHVkalF0Obcny/Li32H/+E76tapaaQl1OXnKr9F5RUlmweILmrGpGe7tUKRaeJVDPphedc52RiV+6N0efGT6fzis9Jo7vwFWn+WQmn/g8R1D/4nutsn5xdfHNGOSOgimiTfgGZe2/MBecDsFyh2w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6705.namprd10.prod.outlook.com (2603:10b6:930:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 21:38:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 21:38:00 +0000
Message-ID: <2f59d22a-9f9e-41b2-b086-de98fa67bac5@oracle.com>
Date: Tue, 7 May 2024 05:37:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: do quick checks if quotas are enabled
 before starting ioctls
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20240502211133.20102-1-dsterba@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <20240502211133.20102-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 42dc7b03-c1b8-4842-d622-08dc6e14ccfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d2FVcFBpd1I0Wkc1UURHNWFrUm1mWHl4a2hMWEJLUGR5MWgyVEY0bEVWTmZB?=
 =?utf-8?B?Z1VVMSs2Yit4SnFYT1VRZFRQclVHZStMY29RYjZ6bDJZaUxjMU0vTWVsalV3?=
 =?utf-8?B?ci9HRzVzd0ZWdGkxZG5XMmNFY1JhaytoZjY3d3VveUxZQmNuK05GVDZQV1l0?=
 =?utf-8?B?VVZ5SHVPL1V4S080TzRIalVUS1lSeWh4NWpnYkR3dVl6czJCYW5jSTZRU0Vi?=
 =?utf-8?B?OUxFaUtpTEZHQ3BxNlM4Tjc5OFFqUGQvM1l4WWwzR0wvQnMwTnU5OWVvYk1D?=
 =?utf-8?B?OExWRk1abVl5dEltL2gvVVZjaVEvM0FZcXBSa3FDWko5c3VuS3lUbDQ1STkw?=
 =?utf-8?B?dlF2aHVCemZnYXluZmh0RXlBenJzSHVZcG54Tk8xVm1mTWhrMGFSUzhjMnZk?=
 =?utf-8?B?VXFKYTFMaldLU0Fhd05La05WQyt6Rmt0a3ZCVGJpUElocUtGVXU5NVJxeitC?=
 =?utf-8?B?Rnh2bGFVVlhyNlNIdXFFcFEyMUFqY3lSMnBCNUY1MHdPaWk0OFl4RlRseEo1?=
 =?utf-8?B?VVpQZUVhNVNkNHJKSTNmUW43VEM5Z1ZaTm9YRXNkOHJyZjd3VFZ0Q1Z1amt1?=
 =?utf-8?B?VndlV1RYSysrS09tWWwyVzdjcUg4YjNVaWhiaXJ2ZmtnSE16ZWtmb2FyUXBG?=
 =?utf-8?B?NUFSeTgrNm5ZYk0rMEZaSnlZQ241djdQVjkvYjhCQ2tWa292dlNnV29aUlhu?=
 =?utf-8?B?aWdUS29aQVNCR3NITmNYWU1oSDVRTE1vZi9QNEJTeFBUeDNPQXRLT2RYdDJp?=
 =?utf-8?B?clhDK3hndmoyRHMzajlKTEYrYUlBUHIzaXJWdUFsZDc1OXJOM2lKajdXK3kw?=
 =?utf-8?B?NWppbWl3VmNPRks2alFpVklYVC82WnM3cWZaN0VTWWFLQThZSkJYVUg5NVR1?=
 =?utf-8?B?a0NnTG9qc0VVUThRUVRLSWxmbzhoSjNHYlZLbndUMGMza1BidS9FNit0aVQy?=
 =?utf-8?B?Zk1tK2FyTk5kR1QxNTF4dzhnZURVT2hmYndISTRoZWJrYUNBVmc1VjFOMnJ5?=
 =?utf-8?B?MnduL1BkUG13ZmF6ZWhYT1lWRWlYQWNqWXhTakFMT1ZyVHB0ak0wa3dpaHl2?=
 =?utf-8?B?WFpRcmVGN0Q2eXkraFRoQVRKVkkrV1BJWUNyV1Y2Skl4SHE5WlVpbEpCQS9C?=
 =?utf-8?B?bzdlVHI5NHN4Q0dPR0hhVnZDWXNhTDhDcGxqcU9GNndrRFdhRGh4UVNTZDQw?=
 =?utf-8?B?ckZ4QndNQmd2RmxCVXRtMEJDcHB1eDdTWVlIWFNJbnpGMEJFbm5PeFRpTzFK?=
 =?utf-8?B?d202ZGFkNGJ4KzYzL2tRdHVrMURkOHZLNXZaVi93VkJlR3VYc0ZlNVdvSFAv?=
 =?utf-8?B?SGFzOWNUM1V4ZmZxRHZIbFkydXlXQ0VRbEVtV1MrVStYVEpaa3Y3dEp5U0dD?=
 =?utf-8?B?VVMyY2MrRXlBOWkwTzR1UGJ3bzMrYnNlU21xM01hYTdYcW9PNGwvbXpLeFlu?=
 =?utf-8?B?NDNnN2JxWFFMV3JIQ3QveWh3UEZxQlJzT0ZVUDhTenA4Z0RmVVQ1VkpXbTZC?=
 =?utf-8?B?V3d2cWZ2KzVSQlJGeUl6N1kxanNKdStQaStPcVlnUTFxUVNSWmF5VnFCckVG?=
 =?utf-8?B?Zm5WQ1pSM2xCQkNQMzJCMXg5alpMTngvS2VrNkh3V2hmMXU3Z0F0K1p2c28y?=
 =?utf-8?B?SXl3VzhYZEttdTk0cEdwY3Y4OElWK3FFNjJZVmtkYW5tR2FjWmdhQmxrREJk?=
 =?utf-8?B?eVZ1YlYwWldIZjVmYW9lL0t0dkk0a25pTWxndTY1cGRabDZFM0dvR0ZnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2hiVWV5RXBZeGhzTndNSnJKMUVpVk9GRmM1ZUx4YjFVL0VkRGRQbWd3a3hH?=
 =?utf-8?B?TXJOVm9JeVdqd1lDaUZHZmY4cmtrZnh2d0ZIYlNJUFpqRW1heU1EUEFNZWdp?=
 =?utf-8?B?VVVzbG90Q3FDUHhtVzZxaHZtZWtnUTNwcktFQjFzVENDSGRRTU5adVVPZjZG?=
 =?utf-8?B?Ui9Ia3RYRkRLQkhnU056ditYbHcxV01HYlNOR29acnU2WHZGQUhYUGdiYmQ4?=
 =?utf-8?B?WkJaNnVXYm80TXJOK0VHTWU2VUViQjBveXhRdkU5L1Vlc09ib3pHajArMm4x?=
 =?utf-8?B?NVA4eUNQWGRGMGZoN1NnMXFDQStETG5ONU5XWGNDUTZjRnJPdWhZbkNoWjBH?=
 =?utf-8?B?N3ZLT3RkUFoxTmtxdzhScC82NXVOQitMWVNWRS9oNXZOTXhaTFdNZ1RrVmZp?=
 =?utf-8?B?djNIWWtTcDlpb1Q5WElrUDVrZmN6bHkyUEFUSUVkbWdTSm80V3JITnlma09x?=
 =?utf-8?B?YU5xWndvUjRXNm9veFNpTkxsMmQ0cU1hdWxnWks5K3NaSHkrZGNPaUxCdDVn?=
 =?utf-8?B?YUpKVXU3eEt0U05sR1FJR21JK1BaUGJKOUtQZHNPbEhYR3hMNEJZKzFTQkt2?=
 =?utf-8?B?UjBYZ3NEYXFDN3dFSXJzYVpoK3dLV0Yvd0RuY213ZStKejBjRnU2VjlCdnV2?=
 =?utf-8?B?VGhGY3I0UnprU3AyQTMrTEV5WFFKaVBsalMvcmRZVEozWmJtdmt1UVA2SEtO?=
 =?utf-8?B?K3lBS2gwMjRHSjl5cHhRalZZRy9La1lFUURpRDlxQlBTbWxRV2VhTGJKZy82?=
 =?utf-8?B?Qjl6RG5udHNndmxBT1JvMVFUS1N6cmJ0NEtaakZNa0Q3NzJvMmp5bmcweTJn?=
 =?utf-8?B?a3M5SkFaSHRKbnR2N05iSHlDZlJGbVNLV1JES3BCTnhHZ0RZMHQrV01ScVdD?=
 =?utf-8?B?eHFjOTk4RTJwdm1PTjhoOGk2cVJhbHVmaHlWOU01TFF3NlNaQmRnVGI3dy85?=
 =?utf-8?B?aGxURWdyOWM1WlJERnRoOGJiUGx1L0RKVGJoVGJiWEt4dnVaUWdaeWNCK2M5?=
 =?utf-8?B?bVFmZDJSM3pYNHdCZjB2T1ZRWnB2NTVEZ1MyZkZWNUFPb0RUeFpidkpjcTZj?=
 =?utf-8?B?Snl4UnZ6RjJRdmJsMFFMYUxmbDZyc3ViOTh3cmFNUVpEaTFIWUhEVTRjTG1n?=
 =?utf-8?B?MFhkaEJUZTVTYjBCVGRiMkM0UnloM2tVWHF5VXUzSUw3dWVaSHFnMTdaaEtn?=
 =?utf-8?B?cS9uZ3NUQWttbEtDZC9aRHVrandTc050SFJGTHg1bE4rYjhrQnFSSmJ2R2dS?=
 =?utf-8?B?QjZhSTdmVENIRXk4bkNVREhEblI4WUtjaDBRUTJtVk4vYmUvM1B3c0RUMUVX?=
 =?utf-8?B?RlBpQ1hHQ212MVJTMkZ1K2hXVGdSRG9GTmhzTVFSeWRQZXJyU2RZWFBvcExW?=
 =?utf-8?B?d2dxbXRHUjFqQXo0TE9FQ083UFoxbUIvN21TMHZKcjVxVlpkTU9NMm1CRll2?=
 =?utf-8?B?ZUZxOXFjZVZ0YlRkY1dSbjRjam1paGo2SDZxQ0dNWHMyQ2J4U3NRb3VkVGE0?=
 =?utf-8?B?cjZ4ai9yd0ZzU3R4anEzMHhxZk9jdGJFMnV6UGlLaHpHQXdjNjVINEVlOVNo?=
 =?utf-8?B?Sy9sSnF1aDNKMzVDdDlHMWw1NGFZc2E1V1F0eC82ekR1Vm94MTVFNUZDaUgz?=
 =?utf-8?B?YnhKbVAySWNjeFpHc3BSQ1U3eEk3MHpoUmNIM0FJdUd1SGZPVzBiMks4cFJo?=
 =?utf-8?B?OUZPaHUzQytWa2ZFY0xuSWF3a1QvNVJON2RpcEVWK0hjUkVGbFJ6dWh6MWNi?=
 =?utf-8?B?NkhRUzN4RHh0bDd4Yyt5dXVRYmszVy82NkFvNk44ZVhkYUxPZ3RmR3VucmtL?=
 =?utf-8?B?ZXIvYURpWFd0RjF5S0NWcFdwVU44OVI5VHJvZUs3U0dVUHV6WTU1NElzNHA0?=
 =?utf-8?B?RnBOc3Z0VEwwWXhJTEJpTld2WVFwclR1VENYMnlKSGFHdTlmd2lBcXlRSUUw?=
 =?utf-8?B?TDcwbUlSOXZ5MStQVlhZYnJVRVJPcnNCek85Qm1LbmkvR2hkQ1ZLcy9PcVZ6?=
 =?utf-8?B?ODY5VUFoa1JLdDBMSDdNTjBrRzZjbGpzZ0NpZTQ3Vm01R1QzbmYwQXFnbldY?=
 =?utf-8?B?WDE1WUFSeUxvUDhseGJIZXJsNnFxTitPMXhIV1EzMW01VUszWlc0WGpuY0RC?=
 =?utf-8?B?akZDalgxeXJZYjh6UTFrbk5saHBhdWdGNWJUb2pxSHJveDBwVXNYTDRya0kw?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vQ9QgF4fA1gaGYmdcQiOgHcwIRee3X50ZUylybFzmNLOgjpXqCPu13CvtmB3yKkklH2N5262viwQT/FTTzXTWxGmRR8qZ9ZkeHkys0g5zkFcI/9uDiMRVhWXD99klAsbGmcYLDxq51PtslMRvLs4XF4eX4W+AFk3FHRnWGuraMZtFFu8SaM/d4BKklT3vT/E4H0++oqMrHjLIkY4gTGKFN1S1aDNrGB/+3/jtPGlPOLtGY+YCiYTjbrmqEf8XxmC7kimdVTLOuLr2icwFClfyR93vwZiidi+1KtHB7Kekle/9IceyEYPWh4Yvvr0qh3e3O+bU9zc9gfka+WfhVdIiaynDxksBMZ1ZNi50i4Xhi7aEIVL2T+yBXAqBu86WxN8XI4LiovZxQdqWw23woT+bGfq1GKA3Xia68XRkSzFqguSXLpweG+lvtE+4Gi1pX4jSambrkfx6Pg1jBcVZj1q/gZSrqqSNilqE5H8kFLR5mJGwGlLTzptsOhq0mbKp8YZBAzqrOp89n5LXMgTz9u43t12Ze56Jb7IEU/TaWeyw1tFoBLPp/hhwHz9M2wMqFgMNWgbCkx8Pj9FUSFhk9Lq6wLtiWKcW/2+rLLfygBjh5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dc7b03-c1b8-4842-d622-08dc6e14ccfd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 21:38:00.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gx2CrktHre7iqU34ttm8eicjPdRZ2zd9lZDlkG6GYmXghSJsJM+jefu4RJJVBN+Uv4F2sVCFbQomCEj3ErKkVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=923
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060156
X-Proofpoint-GUID: HSnkQp0TCzvIaPZsmtj7axB3Dq-oP5UD
X-Proofpoint-ORIG-GUID: HSnkQp0TCzvIaPZsmtj7axB3Dq-oP5UD

On 5/3/24 05:11, David Sterba wrote:
> The ioctls that add relations, create qgroups or set limits start/join
> transaction. When quotas are not enabled this is not necessary, there
> will be errors reported back anyway but this could be also misleading
> and we should really report that quotas are not enabled. For that use
> -ENOTCONN.
> 
> The helper is meant to do a quick check before any other standard ioctl
> checks are done. If quota is disabled meanwhile we still rely on proper
> locking inside any active operation changing the qgroup structures.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



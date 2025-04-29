Return-Path: <linux-btrfs+bounces-13530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781EAAA1D2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 23:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7942C9A5A31
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49BD26989D;
	Tue, 29 Apr 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="u8ybf96m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E125FA3B;
	Tue, 29 Apr 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962025; cv=fail; b=qCviGouZya+9fU/Xprg9AjLQTttV2iWzYa5j8VmhOl2ixYEA1GaPmwjyNb8xQS55Yatc22817+5vX7QU5oZiUz89UVq3oZ55qRBclfSQR/S/gXU38qTdE4pMoB9NcgbKeCX0/LP6SVd+CH2oyJLntL604PuGtSx+NSPv1edJhYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962025; c=relaxed/simple;
	bh=VwzNvMYt4hOxowze6q6SHQy61+VKAeB2xPMLd5JggdY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vFgI1+UR0oI6KrYihQvMx74msZ5QhmvVGahpZQTEGPS/3AmXYXz+m/olKE64eMjc2WX1aImteAfw34pbpXogBa+nKx4J8SUDeqRHmpcM8cYxRzT8LCmJLGcl6xdvIwXMxW/E/xQMRRHFX8eLiyzBRv+ygZA0Qb4Pv5CTP5AFGT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=u8ybf96m; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Received: from pps.filterd (m0316036.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TIcANK012820;
	Tue, 29 Apr 2025 16:26:56 -0500
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012039.outbound.protection.outlook.com [40.93.1.39])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 469h2te9e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 16:26:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oqjh3wdW93QFl5CedVFChSgTffAMPl7ElFcyDsWy9rxVfbMEpvbzX0Q0aUeetXzOVOSk68rveAlJFxcFqA5n1l2CVlEd6Q6wd1cO/e0scNoyfhliXhvMTkZ6iGNeyerPDrr5nNSrYCbH3gCfr+lXgbbcUsB/qp36G1OGFdJvp6L18VP6vzNh6eShiKt1FraMRixIIwQrgrYrZ0QShvzB8Baz8MbYH5ast6tWYWYIre1J47gh4hES0fEM+Ov0I424Nqoe3ax8IScpH4DDBIU5nPF6qsvXZ0TqTqCpZFWNIqOBG62zsMkxBLeb4CQSrMv846qwB5ebZB+zG047XeMNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fQfLUL3dPxrMMXOqZdHvrZvk2YefCKUj1JsSiDBVdI=;
 b=FKpH2aS17cbY0kkZKeAB5bUgNl2jgLdn9tT4MqFBZv6dZBeJ8AV9TAv/a3wzQB2vxejekOGkESmCiimWP837We4eRZTJZ7uEX6ogJ4MC2cT1c5UPA8ag//8qdXbMvf7THNHVLpqsP8xKy21RfMwXpNtFrteekcIbALL68F2jBatdJ5PuoR8K0jLrn05yiDEWz/iBJ3S6fSiUmTsPHWrTktDvPQ9GlBi0nXvqUOHe23hRMeCbSCfZkKzTVibUeOSeyKc9OMpRQ+7q/nhN6IKtYnxCwFDP90jAdlAp2liXCgchA6rLuS3vKLJrk+kuODe03Ayc63ObwdIQvDyBrpYFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fQfLUL3dPxrMMXOqZdHvrZvk2YefCKUj1JsSiDBVdI=;
 b=u8ybf96msJuuC75IsiMbEvOHUhy3C2C/4gINlyP7lFhxZB+UoD/zmxoEoICL9+eEP6gBeBlm0O02oApV2g6JXwMIe8ZqY9VFkiZELBxlR5zIq1D6yyxbK83O7yVUzt42uQCNw3Hu2eg86esElPqXnQhRe2P7jC6a0VLMSt7dS9ESJ/pdZgyfGuquTFpFmwBW7FdWLwRB5xlTghJFRpHgiHeBMB0Zko4yFbJmjQS1/n1WF5qLjtQDaVEBfUFHtRz+jpQ8yppXEEdDkyZXPR9y4rGYJs9CeflmXQkwh56C1AW5EBvhCuBDxgjNAE3MXUIbs0ChzZRAiim2sr6N3YuiAw==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by IA3PR06MB10720.namprd06.prod.outlook.com (2603:10b6:208:509::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 21:26:54 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 21:26:54 +0000
Message-ID: <53a8e583-f3bf-4efc-afa5-fe9d8af287a9@cs.wisc.edu>
Date: Tue, 29 Apr 2025 16:26:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thread_pool_size logic out of sync with workqueue
From: Junxuan Liao <ljx@cs.wisc.edu>
To: Tejun Heo <tj@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5ee9b1d7-4772-4404-b972-93b01ed1e033@cs.wisc.edu>
 <aBEWmCB5Ofr5lCp7@slm.duckdns.org>
 <476f9bf7-2cd2-4c26-b55f-b42b9fe7eafc@cs.wisc.edu>
 <aBEb3kjVKcqzNBov@slm.duckdns.org>
 <ea32d8f1-e96a-48ff-92b6-ffeb996b0823@cs.wisc.edu>
Content-Language: en-US
In-Reply-To: <ea32d8f1-e96a-48ff-92b6-ffeb996b0823@cs.wisc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:408:ea::11) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|IA3PR06MB10720:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e663cdd-3b3d-4380-d9cf-08dd87648fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|41320700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDdZbUt3ckRGcVZ2aktEQjVicFl2OFJ4ejFUamRkSUdQSEZIMWk4Q0dxQjh1?=
 =?utf-8?B?Rk4vYzIxaVFibStTeVVRTVM2ZnJFbWhrUXZrdFM1SWhXdkFEdGlFR1lHbHg5?=
 =?utf-8?B?UVQxK2E3Z1dCbTRnTmRwcTArQWJodWV5cm9uT2RSTFBHbDVYOHVSbkRpVncr?=
 =?utf-8?B?SW1OQkE3ZTJCZm96UDRkYXBLcFJLQlB3R2pWRFNJeTI0TGdGc2lmanJiOXVp?=
 =?utf-8?B?dzUwVjhuU3hzaThFMzZFYk9GNER2S1RpLzkycUJMRW1Gam5UUXg3M1dRci9S?=
 =?utf-8?B?K0JNZzRFUkh4SVFHRFBwMjYzUUVQWHg3SEJjWndvLzJHbUpydVRsZTBCS0Qy?=
 =?utf-8?B?ZWpKbDc5TGtIaVBsci9lMTI1azVkb3F5TFJwSStFSW11ZUNTQmt1a05oWFRL?=
 =?utf-8?B?UUY1QkM3S3IrTm9CUVNpT3lsYjVoZkFCT0hkM2Y1b1h2N3pwSE9xbWZKa2ZL?=
 =?utf-8?B?NGU4M3VPNzJ0aXo4cVV0Q2NvM3Nua3gvckRIbkg0cld2eWJuSFZYTkI1TEY5?=
 =?utf-8?B?OFR5dEdITGpQazVQT1U5Uy9UZUt5V3NRZURkSDBmU0s5TWhEOUVtNUE0Y2xh?=
 =?utf-8?B?alNLVUJESFJPZ1pSNnlwNFRzTU8zcWNzZUhVUHF5RlRYOEpRRkplV29STGFN?=
 =?utf-8?B?c0RmNzRvOU9SYXd1WGpFU1g5OGZpNWp1eTVMTFhVeVJZS000WUwxOGJlcVdh?=
 =?utf-8?B?Wm16S2Nudjl3SHFMM3N3N0NWL091YnJNRnVxZVFNeCtwbmdFK3MyaUpFZjR3?=
 =?utf-8?B?SjVjTmlwWUw4SGlSOTBJMXdldDFVbG1uL2VJMnllSEhPb1E2cTVmNmYyNGJ3?=
 =?utf-8?B?aGU2SUtxTEh5NUlJVCtQWTFvMk1NMmtrNXNKRlRSTmdHODBwNHkveGZ2VFdu?=
 =?utf-8?B?SUFrRU0xbDJIMjBJaW96M2tZR3h6TGR3anZZUy9lV2hCMFdSZzNTRWFDVlgx?=
 =?utf-8?B?QTdIUFdndkVtQm5zSVE0UG1WdTZaT00ycWlBbm9ma2oyNWlFL29KNDRCTjZJ?=
 =?utf-8?B?M1BvOGtDQVBBL3BKeG9EMnIyOW1pL3o0a0cyL1phc2c2d3A0ZmtCam5KdzF6?=
 =?utf-8?B?bWZHZkJ1OGtDZ1NUQkMxa1dsalVOeGNhcG5IQWdVSzBOc09YMWVJL3lWT000?=
 =?utf-8?B?RkNra045bVM2cTMzOVBIY0xvQVI0Q1VYTUZ0TmUzWDEvdlA2VnhvZzdGblN1?=
 =?utf-8?B?OCtkcHAySGxLU0RDaVp6Y1RkdGZKdm9qZGI3TW5Odm1KV2lVN1hCTjBuc3ZL?=
 =?utf-8?B?bENKdXVVYUdSSFplaGMwb01PWGRJWXlSTkZLaWI5T2lWdHJEQ0ExLzJkdFZs?=
 =?utf-8?B?UjF0cHVWUjJpM2FnZmIyUjg4OXdWU3ZKZ0lmeW9ENVA2eWdvWWRVcXMvZmZD?=
 =?utf-8?B?M0pJRU9NYVR5bXBSdEtMVzJNSlVxQWM2V1NqMkQrU1hxeFlSa1prVjBGaXZR?=
 =?utf-8?B?VlRTU1EyVzdJZ3NYVGZnQTVJZ2NTY2grbWRMOTJnaXZBeUw4dXRLSTIzMlJQ?=
 =?utf-8?B?RS9GKzB1Rzl2NHpqVDRwUjNXWWVSY2JCaEhhMnRJcEpVNmgveDB5TWo2M3VL?=
 =?utf-8?B?RGJnZWZFdE9BaGNpdVNya0JIRTVwSDZlRi9XVVZ4MktUZ1ZCR0RWOHBWWW9m?=
 =?utf-8?B?L1dRQzJ0RWJHN3JSdVdwVUM1L1FENkF5RndwRmlkWGg4azd3ZG1UTEc0TElt?=
 =?utf-8?B?N251NVBLVFI3R1gvMFRwU3pSTDRicWhDRnZpVy9NYU92cHVLZjEzNFdpeS9E?=
 =?utf-8?B?V0pSaDA5TVNKaDJkSkVyRCtYWUJveHRBekJHU3lwaGhrRm9RNm4vd1JkblF2?=
 =?utf-8?Q?XY2LD7aVBNgO/0qDIxZ0OBPdljdHdQt/T6d+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(41320700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHNicmNLNFpKcGplbS9PUVNFV0xjakZBb3VPSWI5YWM2ZVhXNlRYeHg4bFBq?=
 =?utf-8?B?TVM0MU1iS09LZlBWeFF6U1pFeTdkVnRtbXZwbWZ3MWFZR3dxVGNnUmM5Vis4?=
 =?utf-8?B?WUF1b1hXUFNyNEJub0t1em9ueGl6SW9hNUFJYWg0RVlGM2k5aDBpZE5EWTJX?=
 =?utf-8?B?R2VBa0lDRFh4dkl0SjZNL0QzZEdSZ1hMOFc0V3ozNmpHU21qWUhZQm5lUzZK?=
 =?utf-8?B?b0FZb0R1ZXd6RWFhU3kyUllwcUtwakc4NTMxQW8yY0Z4VFhnb3dDaHFlRmlT?=
 =?utf-8?B?N2R0d2QvL3QwRUFTUWRxd2VRNEhXTHlxMjNvblBXUjVhQXYwdG40d0piT0Yx?=
 =?utf-8?B?elBMMmRRTk93cXlZNlV5TXZKM2pVTk1sd1Q0UWUzK1kxNnVBSkgrOEZlWVEz?=
 =?utf-8?B?WUtiZEt0eFZJa3pWRWxSREhISXczTkp1aS8xOUlXRkZNellxYnU1RnVvZTVC?=
 =?utf-8?B?eWlQaEdTZWcrZjlBZkVjZ3dEVEJLMGk4TWN4NkIyaXNTTFY0VlYrU0l4TTIy?=
 =?utf-8?B?Um9DNGg4eXdVS1ZvTXB4SUxZWlZpb1BId0ZGREpKNDZNalpTR0c1d05oVlZ6?=
 =?utf-8?B?anR6SnBjQW1oQVdtdFhOVVhRWWdheVB3Zk5IeFV6cGhOdkt0dWphRk1yeE5N?=
 =?utf-8?B?S3pvMEZYYnUrQXZLUThvdlBFcExONUROeW84Rk55VmRzM1h5aTduZVNYbk5z?=
 =?utf-8?B?eEliUnBFdlZIZHBZQVBYTzRXMVZGb2kyN0d2VjM0d3c0SE5ySTZaUkRtRG5u?=
 =?utf-8?B?ZlpLZ2w1ZE8xOHc1V1NkdERmelg0WWg2UGZZelRzUmpZUHRBK2lGMGs1eTU4?=
 =?utf-8?B?Y21kRGdCcDVxbStyRzUwclVYbFcvWklxOHowUWthMnNKRkhkOGJnQ2FtQ1dF?=
 =?utf-8?B?VEV0ZXdZWnI5M1J3ZWl1dmdJRmE0U0tIQ3dYdExBNEJpRWR0dXN1SncyejFo?=
 =?utf-8?B?bXE0T0pyV0tUMVFSSTVFZG52dTFHUG1XUDBDZUIwREJnUldFcUZONHZtUnFo?=
 =?utf-8?B?NjZ3S3VDTTI2MVk2aVZreVhJMmQzNktBQ0RnSkh4N2hjZVArbVVkak5LeWlF?=
 =?utf-8?B?QlFWSFlmQlJtOTd2aUxFM3U2b3pWNzlKRGIxbkdTdzhKUU5RQzVmVUNoOHZ0?=
 =?utf-8?B?NHhuVVBTS3hETUdISTE4YTZOQjZGdFc3UkJHbGFaRjZ2cldjQWdvMEoxYTFj?=
 =?utf-8?B?WG9mTDY3MGxwS1RmQmV3RUw5QlhZWGxkUVg3YlZiOGx3YWorVmFZbVg1ZEFz?=
 =?utf-8?B?SGRyMzNBQ1RYclRxTU1INFIxcDFQTnJ4WXl3NXVNbGk1L3puYmJXNll5UUcz?=
 =?utf-8?B?UjlrTG4xNUxLSlVocVhQQWJRYlBpOVVYeFBCSW9yM0FNeDlITVBrU1FQcHp5?=
 =?utf-8?B?ZmV5QUxJQTBTKzRWcW9UeUNrZ3JXcFVMRWJjbnBQYVp6eDg1T3JlNC9DZVZr?=
 =?utf-8?B?c1dYdFFQcjhnN0ZPd1Z6ZzlzOHNkTUd2YXRoaTZSVWVZVXNHRGtZaXVVVDFG?=
 =?utf-8?B?QXdKcjNlL2IvM3Ezazl3MXMrREFNY1RMaVg2dFVtRG1GbUhCdVNNZ0ZqaHM1?=
 =?utf-8?B?bm8xd1d5MWNWNE1uWGpIRmNnZXpxV2pLQStDTFVSQ0Jnbkd2SU95c0lidEg4?=
 =?utf-8?B?cDJXVkE0UGY4M09iM2xZcG5NeGRUYnJMRm1qZ3Q0MW5TYmI2cFRHTjZtWDE0?=
 =?utf-8?B?NGljbFRzT2l2ayszL1Eyd2dxS0hLSjBMd2V3cEZuZ1VwZU40SHdQQ2h0cW03?=
 =?utf-8?B?Qytrblcvd0Z0YzhxbkR0NUhSRkZGOGRjcklZNDZ3QVAvSC9ibmw0ZTR4NDZH?=
 =?utf-8?B?WGJEQ282Qk5sb1ZQdnRvZ1dHR04reURxYnBMSTk5OEtCUmpoU1dwZExxOWNm?=
 =?utf-8?B?YVdDMGltYnRqTFA3UkswMXc3OTh0YzdONmtTaEpaMVlZMDUvbFB1V3FkVFkz?=
 =?utf-8?B?WndqYVdDWmVYTzJLVjFIcVJIdG1hRWw1NlBOV1dlRGJVK1JIbHFTVW50ZTVZ?=
 =?utf-8?B?MXBIYlpoVDBtUDJnY0NnSlo3ZnhPSDNLcEsrM3NFWlJJYmEwbm10OXY0L2l6?=
 =?utf-8?B?aW04VGt6d1Q2UWx6VFYxdVBvQnpvVitGQ05HT056YzhRUTNyTThZcDhFQmww?=
 =?utf-8?Q?vc7Y=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e663cdd-3b3d-4380-d9cf-08dd87648fe3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:26:53.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGQO2puIoyEwxRnjMaXiej9NixN2vx1F/CIOw66PF5uzAEEXJLHTNDyVY3iGqPRh1ozIVlRsf5mcLjNziz8DHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR06MB10720
X-Proofpoint-GUID: JYKwbTsjGWzpnCsvV7QC2BRd085E3O1m
X-Proofpoint-ORIG-GUID: JYKwbTsjGWzpnCsvV7QC2BRd085E3O1m
X-Authority-Analysis: v=2.4 cv=NLfV+16g c=1 sm=1 tr=0 ts=68114420 cx=c_pps a=1DU6XXJf+V2sdG0edZkYmw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=VwQbUJbxAAAA:8 a=yvhp2gljLxRq0NBUdkAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1OCBTYWx0ZWRfX43vRqsycg9tZ tzIzqgddkCEcrX5AtudwVp+0/NwiQHlwK9n4bn+/PU9Pol84jg+elt9hPB7hmvXtUe0049MWNht DitA3cCppPdPRUt1UoLycEFWxgcKye64KdfnEOqRZ0Yit5JJ6gF7TSB2g9g7REkMAHh7DVBzoky
 9JZiss8+Ny+57EKUFrxWThzUImkS0hOlyL770fWvjC60IkmwyYSf/mHPlWeD6oTvSUiACfgpAys vdIvNQUCyRZMK5t3jTkbvzeeP5tB1wZolFdLq1T37DDOPYSop87jGSUej297tyUiE7ZislTlVb8 dhlv1P0pP5KI5oSTqXSA3RAIk6yzLyz3n/8M2/O+EjAzQMsBIUurz6Ad7p/NWBYItiy6OUkLDp+
 PwtfWnAaQJzBqbxAGSyZzsX4TDbYmFu2nCiDafUGPyy+41b5blkDdIUSnNbBmKuFrZWPEW2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=692
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290158

On 4/29/25 4:15 PM, Junxuan Liao wrote:
> So versions from 6.6 to 6.8 do have the bug, right? I guess the
> performance regression isn't easy to trigger so no one noticed and
> reported it.
> 

My bad. I missed that it has already been reported in 2023.
https://lore.kernel.org/all/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3/

-- 
Junxuan


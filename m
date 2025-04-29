Return-Path: <linux-btrfs+bounces-13529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAD6AA1CBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 23:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E895A1B6082E
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 21:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1C8248866;
	Tue, 29 Apr 2025 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="hLZgNChm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82017E0;
	Tue, 29 Apr 2025 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745961342; cv=fail; b=NLVtlHAxxk2jWziLkjpid3AfSJQl6dCwO2oSbvwvkECfKpEY7H2p7xJhV19hRwdZYV4QzKoU+LikQeo5tMAPeHMPLff2OW/4Y0PT/yDKj6yliGxVthL+Yq31waHuPWFTgF8hK5USNvSnZwuLO6mcNYtJHYukf+ezifiJ3QyepEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745961342; c=relaxed/simple;
	bh=26X0Y7DBUAg39vOpveRluxAPOBNx+FKyy3xnWXRE6b0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mDMaCi2lmE3jUadeI1EuwfpJ29W62/Omr83j3wpw3PSGTvCdg52ksGee14qUkQ7/vQji539SBB/yPf1Zq5DYpYHyt9tzAWp7zxXmbTFRMs+MJ0g9icrH74EhmcZih7n4HONvUHA/y1IMt9TsOJNP5+qUvP/CZk22TI3b/SrtcMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=hLZgNChm; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Received: from pps.filterd (m0316037.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TIcHVw003578;
	Tue, 29 Apr 2025 16:15:33 -0500
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013076.outbound.protection.outlook.com [40.93.1.76])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 469hunwuc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 16:15:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2KzeVHjtDggZ17kZv8lt0eoEA1oX1hZPcMYuJhAsl78miiMWqdKL1d74insWiqPHzE4zAeLs1dv7PTzNAw1aipoQE0L7TgJWamAzYW1gPqJ7UFuRaBpIjVc1/9HoYNVWQukbJyD5D00Ho0F+sksis2jpP2o7AbtjSfZ1VoE+aPpbsQ+0c1Cf+VXVJ8mSU13Ha5v51wpfIIINUkPs801zQs8srUCel52ihkfZNPuZVwf/DX4x+JXvuNFHOr/NG6j4hD9DyL2T5d9oqkiTc6WtMuUeiRo3FdoOx47YFKF5xMVKwDF1i7+bI2E6+JypbomyePiiTxr9U8x5IH0ijXFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YZe6n0Bh+7DIrgNCbqPWeYwqTxUsNWNNC1Ck2iwKPc=;
 b=yQKZYzGXrBxRwBpGEmZh5+e5oMsp92etUDuLU8q0GKzbVIH23O3UqJI/Nhy50G4RlWMVkXpx4pQceiJTasQGoUo++LqYkweBhYpv2iBT/iwiX+QSCYFljGAOscYLH59DJ4b7imb6atHlLEivS/Y1Hmfs50YTFDIQFE/JPUjpdR25SzGYkFJOQVZhvzbW/KlDQiXJtpyAlQngJtY+HZB8/i52GsdVoBOUFaLIMcYvtLwLSk6/Sm25oog5W+ip2u9MPXC89wQvqJkrTS/SrikmNeOi1t5NncGFJV1Ev49X1gurzvt2I3adTbEj/AXxBj3fxXkLWcl5DHIkEmbAbi3/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YZe6n0Bh+7DIrgNCbqPWeYwqTxUsNWNNC1Ck2iwKPc=;
 b=hLZgNChm2H57rlAE5gPfkDPtus1fFH9T7FdPr2ktVGmmeXqXkrlgGt8MXIv250I1HGWLRAK65NkpYSFAlrEorm7BokKqIX18buUuH3r2HM81o1YJsZJUjLbk2//y8+GWkM8ONIuzwaiLhthi/FvRjJkiJ+Bpy/dlDhlF15Xx7dnYfeR94G92w4AOFPBaW0WUHrsOTsvG8rh2dBmEMVJpwXj9J5WRy31FsKMr3R0uwnV2MaGVdhp1+AgaIvcSIOWZtiZXffOFr9pJpkPXtPuhFI231go6/NnwaCpILGEEltipce/wQkMWkFbEaGQsZKTJehtoLr002OamGTJcBc1J2g==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by MW4PR06MB8897.namprd06.prod.outlook.com (2603:10b6:303:1b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 21:15:31 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 21:15:31 +0000
Message-ID: <ea32d8f1-e96a-48ff-92b6-ffeb996b0823@cs.wisc.edu>
Date: Tue, 29 Apr 2025 16:15:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thread_pool_size logic out of sync with workqueue
To: Tejun Heo <tj@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5ee9b1d7-4772-4404-b972-93b01ed1e033@cs.wisc.edu>
 <aBEWmCB5Ofr5lCp7@slm.duckdns.org>
 <476f9bf7-2cd2-4c26-b55f-b42b9fe7eafc@cs.wisc.edu>
 <aBEb3kjVKcqzNBov@slm.duckdns.org>
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
In-Reply-To: <aBEb3kjVKcqzNBov@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:208:2be::12) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|MW4PR06MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c32287-bb62-4acf-9939-08dd8762f937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|41320700013|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckV5ZDFBK3NwZ1o1U2FvV1RWYlh5T2RPSnNLOVAzNXFKVENycHY5SUtHVnM2?=
 =?utf-8?B?bWhZckMxRXFJY1hyM3JJdThaM0FUS05XTGw4L1pOc0xPOTR0TGRxSEgzWWVt?=
 =?utf-8?B?b3lndXVJeVdZckxTRFV5NEtZTDBoRUFCK2R1U0pxQU4raWU1QXppbm91V2V5?=
 =?utf-8?B?ZHlZa0VIOTdWYzNYb3AxakNwMHdDa0JJRmhjMG40YTI4Z25qNEtPdk1wR1Bp?=
 =?utf-8?B?cjR4bXEwWjZVSUxCU3k2VEhuMllwRnpQUXRvblQ1ZFFtaWtCS21nUnp6dTVO?=
 =?utf-8?B?MzNEczJaQXVPOFNsa0NmSFpCM3BiamlnTUM4azJyLy9oRjNRWkRITSt3OVds?=
 =?utf-8?B?SHdVRnBxc0xMQ0dmOUp2T2M4cXg4azRDeXFPQUZaTWJNb2ZVU2huUGFGeUVE?=
 =?utf-8?B?Ky9XN2pVZ2E3TVZ1UHFhR0oyWjd5UVlQMmE4MjREVnJCeWx6bU9KYlp0RlpP?=
 =?utf-8?B?cFQ2YzFkdlptbGdwQ2RaekZ1R1J6MjBjWUlWdGlYMUxFZ0FhSHBaT1N0RXZV?=
 =?utf-8?B?VnFQZlhpOXBHN3FLVmo5SXdzWkg2THFuVHgwSWdXMHN2MmtEVFFOQ3JqNkVx?=
 =?utf-8?B?SlBzaFVjTnFlZHFuQnJlMU5LUVpraTRwUm5PMVArZThFU05rRExtM0xmbHo3?=
 =?utf-8?B?MkZURExMZlBlVGhwQis3WTJrenl6c0lQZ0NvTndtUzRpdEFtT2w2R3BBUG15?=
 =?utf-8?B?NG53K1hpRXNZRmpQRGFLMHpqSVJTRUtmMlhhUGh0aXNVU1dvU0ZIMGYySkh0?=
 =?utf-8?B?cGY5TGpLd005aThLS0xIQVFZRC82SVhNSHVFamVCaXg5NkZ0cVBnLzVINVBY?=
 =?utf-8?B?RDhtN0tPbHJHZmJBc2JaZENjSUd3cldaWFpGWUZta1RtRXk4UllRSFZscHMy?=
 =?utf-8?B?VllwN3pGc2tBdnkxZ0c5cW9DdmNYekJIK3lOdWl5cVQyS1NuZFRRSU1ReWMw?=
 =?utf-8?B?bjhlRjJJRjRWOW9pUmtqdXE2eklJZ1l0SUFSV0NvZkZZbW1XMkJBQ0YrREJx?=
 =?utf-8?B?d1NXTTJOdnRaMHNjV3l1QW94Z2pkdWliL2F6bHcvd29ZL0Rxc2gvVGpXNW55?=
 =?utf-8?B?VmtIaUNCcm9walpDSEpyUmU4SjZwYXdPTjc5NVZpU1ZOckxjdkozV2QxQith?=
 =?utf-8?B?RU8yY3UxekNSZzdxQzhhQWlYbVVmUFFXV0ZHTG81TkJIQjhQRWNUYnVDVmRT?=
 =?utf-8?B?NE55YWd2MHc1aVlvVmhnbDk5S3NFdE1vNm43TzByRklQSjJOSk82a0JvUERy?=
 =?utf-8?B?eTYrcnJmVXRGd3Rzd1YwMmk2dkFTNG9nVkkza2pKU3d5RDE5VlNOb2RKb3VT?=
 =?utf-8?B?Z3Y0TS91NWU0NlJrR3ZJcG5mMWhWWVMzQ0ZOd2tVSnBWb3pIYUZpNENtZzRi?=
 =?utf-8?B?OEFmbTNoZUt5WE9VKzhrM1hzd2lBSzRzUXlzWjN4Tzh0OHpENUVZSlNSY1Nu?=
 =?utf-8?B?UXdrSFB6czg0TlZyUW5yaS9EQkdWZDU4eis0NlhYbWhTNDh3ZTBHZHpwN2FI?=
 =?utf-8?B?WmY5ZjJMQ3RGek1uY2lmMEZURklNVGZhMmZtMGxuMkk0UGNXaGNWeXM1Rmhs?=
 =?utf-8?B?T0FTaVlKTC9rRFYxUUtzWVB6bUtwNldWMC84M2pFSm9LS0RQMHFEUFU1clJ3?=
 =?utf-8?B?NUtSY1lqQVJhL0l0SDMwSmdCOEpnNHVqSDRNL1puZUFPTXZwUDRPdzE0Y3Zh?=
 =?utf-8?B?dVpxZW5SUmxwYVBwU1c0bmt3aXVINkY3VjdmUHFKTDlTeGZwblIxaUJRR094?=
 =?utf-8?B?NHBmeFAveUJGNWNGb0ZaRVlxbWdmUnR0eEJNc3AvNWRLNFJDVUs2TmltWkJN?=
 =?utf-8?B?emdCWkJhUldVcmRsL0xDYUxaMzdSdkduVEpBc3RRRFdkVEt0KzJNQ29pRWNs?=
 =?utf-8?B?UnY4K0krSWRFRUMyWnl2R1cyYlArclpRbzFwbzRVUHlJWGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(41320700013)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnlrdFJIV3NQTHBKS0NVQmFmWkJzV2xSSzJ6Q1d5RmIxbXNUbGd2ZXJvaklj?=
 =?utf-8?B?MysxZlRGaCtjS3BuWlJnZWxvY1hMWHgveTRMdGJlU2owd3h6aGEzZjBvejFi?=
 =?utf-8?B?U2R6cTJKd0UwOTAzajZ2SVFXMHd4SThSbU01dkc3cDljdThlemNITk9Gdldk?=
 =?utf-8?B?eC9BOHcyNW5JOWR2TUFwd3FQM2xXMGd6N0lCWU1yVTFtc21hZFdDYkRYeVBj?=
 =?utf-8?B?K1piaDFKUWh3SVVoejdNQ1F5bnBUU0lrZXNTa1JIbkhSTWMyQVVXZWJCNjdU?=
 =?utf-8?B?ZURYN2VQcEJxRkxlQkpDTFVuNEtJb2E0L2RpTjNLZE5panowTFlCL3gyWHcv?=
 =?utf-8?B?YjFsNUNFTWZTcStTa2FHSExFbkllZUYxSU1xYzZPcjNTeEQ1Q2RrSUU2a3lj?=
 =?utf-8?B?M3ZOSEJxR29KUXJqU1pjczdid1RTeWFoajBld2RNbC9QTHBpalcwWUZGMzEr?=
 =?utf-8?B?QUR3dHl2SlZQdkk3TmlIaWdHWk1lM2M1L21aR1drM0ZMbVFEYi9wZzRhc1NR?=
 =?utf-8?B?N0ZMMTgrSGFsK0ZrTDVvd3BDelU0MVg0dVV3bmtVQ0kvb3F3ZHBvT0o5UGVW?=
 =?utf-8?B?bG15QkUzSkYxbGxod2VoUmRNblRhNDVJQUk1bmtPOWNrRXZUeXB1ak9xdi85?=
 =?utf-8?B?K25hWXpJRFRsQkNsREQxY0FwbXBwQkQ2R1RxWjkzMzJ6UmIzazhHTVlMcjJH?=
 =?utf-8?B?Z2FzNFhMNmUzU0ZDRFZlM243U0I0MFJLTjgxU01rUU1VUzBhWjRiWHZzYnBB?=
 =?utf-8?B?RHByNThDZUdjd2luUVk4bVZUTFltS0FDbjMvQzIrdXcybDFqazNpZitnbFV5?=
 =?utf-8?B?Zm4xVkFEWUM3dkdoeTh2YUJVWVhsTHpWMTlCUnowWllwSnNnTU1NL1NwUnFZ?=
 =?utf-8?B?SjkxVnJEVTZoK0pwdVFsSFdKY1MySHovT2EzYS9TeCtTdjhBNWtHU2g4ZElX?=
 =?utf-8?B?dDQ4ZktSTXVwYkdhbWh3NGZUVm9iYWlhOVg3UWJjTjJMN0dKRHlxeFFSYUx0?=
 =?utf-8?B?OGZHc2hueGdIMHBVKzVFYzlZMTdLQ01lUHNOcHdsUEtoSldmUEhzVGpNcEJu?=
 =?utf-8?B?TlRvSkN5dDBTNHVTZXVubTd0aTgwSVBtYjBqL21UMFNFVld2YjhIcDNiVzU0?=
 =?utf-8?B?SmVIOG5qa1oxN1FiRnFQeDA2amhHZEpkU05lUk9iU0t4TVhxZjdzTEpNdFhI?=
 =?utf-8?B?M2cvdzVjNzVIVEVDWlYreTFUbGF5VXZ1RUJQbW0zTVQ1NWpGUGk3TUIrQUNH?=
 =?utf-8?B?RDM2S0tjWVd5M1VZN0NBcVBrMjNOL0Vrc2dtQUdRY1VsOENZclBoRXEzYkYy?=
 =?utf-8?B?YlpSa0QraStyT0NaWGJrOHRhSFVITGkxUzJrT0VJaWZMQjB3U3Nrb2Y0UkJk?=
 =?utf-8?B?MmVZVXVSR1h2OUZRYnF3SnNjQVlpSjBqNjVzR2lZb1A1SVErQ2d5cVhyOFRK?=
 =?utf-8?B?dmtDWHliS1ZaZm1RS0dkRDRJM1NRMGlUc1RrdGtEc2xPaVVOUUtsSkdRMXRR?=
 =?utf-8?B?MXhsR2YyaVUwd21XOW9UbFZaTzdmNW05TXBPZGpiRmFnclJhMjFjSk1jZ2cw?=
 =?utf-8?B?ZG1pNG9aSTZYZ1dleXYwaUNJRDJLaDM3M2l6b1paeG5nSDVFNWNIUzFBNXVH?=
 =?utf-8?B?WXFMTXlheUZQZ1F1bUo4aGkxZm5zVU9DaXdTUVFsQ1AyZ240UEk4cEp6TjVE?=
 =?utf-8?B?VGxoL2pNU2RiRis5R1FvdmtXUGZ0ZWR4K3hTYWdSREtoeXQzS1M4Y3NRSVZr?=
 =?utf-8?B?Tzl0SWdHY1RSUUFIUDNZQjJUTE5EdXNLbFd4T1VwMmVZeGF5YWJaVURUdzgx?=
 =?utf-8?B?SXJyZzhBbWpjeEFsNWVqb2l4MjJKREdFdjA5cFRUbWZHSjdmM2dJQ3JVUllZ?=
 =?utf-8?B?M3NvK203WHJFaG10V1lFR0o3b1RhdCt2S0RVdXZXUndkQlp4MmZ0UlE3QWR1?=
 =?utf-8?B?dldlYUNKNUsrbXh2L3pMVE9kRzJ4dWNKZjYzOUNNY0tPeEJQT0oxRHBwQWZ5?=
 =?utf-8?B?aWFzSktZd25KN1g1endkYmlhR2lwQ1d6SVFVVVBVcVlHR0pIVHAwSU1ROExL?=
 =?utf-8?B?aHNwS3RmaytrZUwxNTY3VzA2dWs0dW9CTHdtbGdibWlIQmhSbjRVcWx0UFZC?=
 =?utf-8?Q?TaIg=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c32287-bb62-4acf-9939-08dd8762f937
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:15:31.7682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQPR1X/UOTUzho6VhUqg13gtamPm2nfv/8Yqgfubp1AZFLRiXumESXswtjukVvYnkXjsX4aEJ7ruLzdXafP3wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB8897
X-Authority-Analysis: v=2.4 cv=BZ3Y0qt2 c=1 sm=1 tr=0 ts=68114175 cx=c_pps a=OVSnam+0waiSP26xbJD4Ig==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=Lkyf4io54GJCi9YIokEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SzWzZWXfy8au-cU8-1X9RQ3FI5HSvIMJ
X-Proofpoint-ORIG-GUID: SzWzZWXfy8au-cU8-1X9RQ3FI5HSvIMJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1NyBTYWx0ZWRfX4vrG8o4CyYLE MB0VV3EzwneZOAONXyhxoWscrSim1k+wvJTRqD/Tv1VcPiOXpmPvWJpiXoY4Y43Eqjl2sftvvM3 XeY6x0yWsH8CROYWqSOwTm9TB8Rg+DcB/59tm4BLpGqQT97URP1dx6F9xUirYhMAZ8XFtEQzl/Q
 eA/EtKhqHf7cOyBpD+U0wdFYkRo0L2+5QIrlVmzCJQgnmXMtjonXfGCtQm03S6Y2FZ37IT0Y7tG vDEOqHooMEYA5PIs0yY6secDyskBkkR/zIv78SSMD6RkqvLmuBGbIrQ6kX/ngVWmAMtqxMmZAsX g8XLQ27QpIffbsar62Ce5j4z13YRQsHXFjkeR3KZzakre2G8CL8ZmtvdPEXh5Ylnn6d++/Mr4Uj
 +nc4kUAZL6WaSdd9UTFz3564MZspDcShuMTGPQy+YMr2t4xHm6zPAa6++lKlpEnmLgb5A+IX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=817 mlxscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290157

> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for
> unbound workqueues") turned max_active system-wide. 

So versions from 6.6 to 6.8 do have the bug, right? I guess the
performance regression isn't easy to trigger so no one noticed and
reported it.

-- 
Thanks,
Junxuan



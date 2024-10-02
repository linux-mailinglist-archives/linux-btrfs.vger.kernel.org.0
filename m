Return-Path: <linux-btrfs+bounces-8430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC998D915
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 16:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E221C20B3F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441E1D0786;
	Wed,  2 Oct 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dDwJhg36"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0B1D04BE;
	Wed,  2 Oct 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877777; cv=fail; b=oC9MNnWXizJEA9Xtnt/M7RBhE8t/lmBPtI+5LUFeIWlJ8hJR1BbLAq+qxgC9vBtwna37mmzK+o9DUVuYG4sniepmm5FKzSVkXkPi2mjTt1ADoC/KrhNuCI70SQ1aeyl74kg1mpZDndj6Un9QrUrVutrBy3+J94yJK9DPJu10qec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877777; c=relaxed/simple;
	bh=0CrH0SnjkN+j2JQ5LTFnkWqb01oPC+qx8l8/edCd8zk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GDY00mR6NKhLSIa9KkkDp1WgegQjOUOHscEusb0HNM96bxFURJs2ZFUS6x54GgKKUeEW0x3h/75PePTqvhJY9dgoooXrH77PDgjG1XwjD07mZRg5vLLWTmkjZSTEzsZgXQUTo29srWSSAbolpbULyqiS1nimN24riqfJD1Dk5UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dDwJhg36; arc=fail smtp.client-ip=40.107.102.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sp0US/SyuZUt4CbaEbUpm3xglBmRGdBqKAMmCcH/cJZ2LSB7PytEFgJj3mKkPBQaBhlrc+tIy4p3G8i5c5trJS87L1U8CqEBx+RNhrLML/Cq+2i0EkuHrXtZajuz2iQL9zuRSvvkNSPplgjWEidSKWJCLv4oKt4ITgKNbJ6gqP8QZlgOPgi8l2YX/Fl4pI6Bzr3VudqOFMrY9B/rJTg5a8jlmrwur7DHtiZr/NjhL2EDeSvDvt820cmLlVuKxY6DkZZBbflCy+zT+HvUhju9bIX89nXCGmGIduzTKygvdo97sK6Tq2dq/rWqqw2/6ReZCSmxUSM77peMxkFNHG5HhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eNAlmZMzMeNnE7k70n13/qkv4K+nMjw9eR+j9Tv7SU=;
 b=umYRzYx6jxdlA1GjjxZs3J+3XVQwa57wel9gw+Y0hHeZMyptf6ArTSi6tTpFg/+bT3SEOk6S0vSmlav0HlvXDzy3yK+54elV/L3fDok5EE0c1mLAHu8but2OFRjhGh0Wm7z7tgcjOTnf2TTWqCzi3LxT0zTGmsSJii1G/GB5jTafvIL17sIXIUzJ6GKLwwrygrzXdaloW2WSTO9Fwu9Pt7az34p0WqUci+XKWRhlkgqDNxETwcP1dWrUJwo9RkFgXdZTLJZv/84LpHJKlRwjURmkWLZCdwJiIhxNc95ZzyvUqsMj+0Vsv7Q8/KImFbMCtLJ64G5IPRr601qwO2C8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eNAlmZMzMeNnE7k70n13/qkv4K+nMjw9eR+j9Tv7SU=;
 b=dDwJhg361KfY3xWHWXEn7H1mDhygYjkxR466aynFNEq/r76BIPbVkoz1y8JcBE+96L/107iXgeNj6niC1EMKT2gbGG4Uzg+dd3GYI0NX0ux7YYIs2PljnUciiJ4KQBHKrWdeyxEGhQZARGx0rw+ZnzwcUndLfW8kCNENUf0DWm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Wed, 2 Oct 2024 14:02:52 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 14:02:52 +0000
Message-ID: <929214ba-f432-542b-4867-7b8e58cf4290@amd.com>
Date: Wed, 2 Oct 2024 19:32:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [regression] AMD SFH Driver Causes Memory Errors / Page Faults /
 btrfs on-disk corruption [Was: .../ btrfs going read-only]
To: Richard Shaw <hobbes1069@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel-bugs@hixontech.com,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Jiri Kosina
 <jkosina@suse.com>, linux-input@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 akshata.mukundshetty@amd.com, LKML <linux-kernel@vger.kernel.org>,
 Skyler <skpu@pm.me>, linux-btrfs <linux-btrfs@vger.kernel.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <90f6ee64-df5e-43b2-ad04-fa3a35efc1d5@leemhuis.info>
 <3a9b2925-57fb-4139-8cf5-a761209c03cc@hixontech.com>
 <056770ff-90e6-4140-b964-862a1503fa3b@leemhuis.info>
 <CAN3TeO2zA6oLanWFXtJ_6Z1u7wWTwAZyrcP6-g81BfkE6jNXRQ@mail.gmail.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <CAN3TeO2zA6oLanWFXtJ_6Z1u7wWTwAZyrcP6-g81BfkE6jNXRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 340fadb1-45c3-4c65-a5be-08dce2eae7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emFVaCtnTU41RUY4UEJEaUtPS1hucno3UGpKRUJDN0plSGNYZ3ZVdWU2dlEw?=
 =?utf-8?B?RTVWTCtCdnVmdk8yWTQ3ZUdQRnFDa25Qckh0TE5PQUFoOVNERWkreGJjOUpo?=
 =?utf-8?B?VWZFNUxMRzFEMUZPZzdlZEFvaUF4VytlbUZoZmpCRUhtWWVwd1FqL0FnVkNC?=
 =?utf-8?B?R3ZhVE8zSVBqQ2VEbFBtaEFUNHlDM25FZzhQLzVsL1dlcGE5TXdWVkxFMU1t?=
 =?utf-8?B?dHloOGxRYnh6ZC9aRU9iQ1NGNWVXRWxOd3FSVkkyZklkWHhkbzBQcktsVFpr?=
 =?utf-8?B?MllWZzB2T3d0aEJaU1F1eEtDbjhkelNEMHAwSFBHR1dYSkJ6YXZmR1RHUTBV?=
 =?utf-8?B?MzZiS1lqUkRZWG5naktlbXV1cXhYcWhpamw5OHE5dTRqZWoxRTBTU2VLMzBi?=
 =?utf-8?B?K2hmLzZnN0JXd0NkVVdPaURSb1lyL2QxMmtta1oxK0FXZlJpb0VKZ2M3RlQv?=
 =?utf-8?B?dkpzdjRkZG9mdExDQmE1OHhvYkVsR3BRdm5WaFBQOGpDV05jVGpsYnpZS3dt?=
 =?utf-8?B?SFQxUEdid2htQlF5QlJkNVBpK1ZXSUc4a3QxeldRdUNoWUpYYWdzMFZwektx?=
 =?utf-8?B?UnpnOTlnc3F0ZzNWbjYvZG9Md00zTmE5NFpHeDJtYm51VVAvVmdYNVpXSUJ3?=
 =?utf-8?B?U2FNUEUyUjB0dDVSVW5tQnp6VVA2ZFpxSWNXVmZSblRyKzNLSldqdDY1bnhQ?=
 =?utf-8?B?RGFIME5NZnR0U2NZbFJ5Sk5tbml1TVE5OFJNMEk4UDc1ckpHMUFNdXc1YkdH?=
 =?utf-8?B?QnhNUGhhMWRPQ3JENjJOa25IRXpwN0F4dzdYY283RW1Od285QTAxUDRMOGpz?=
 =?utf-8?B?Wm93QmFvOCtqRTYwbDQ2UDhJdlBHT2x4Z094dWU0NGdaaG02SXFFeEdXazZG?=
 =?utf-8?B?V29OT3Voay81UEJhcmhSWExtUHBBRVZhSVh1MmFXcDRpT1BNNk1SU2U1eksw?=
 =?utf-8?B?cnNJZjFOQk05czBYak1YT3BOV2dyNUZXOTd4MlBnNFZMbmU5V1dLQ3lUWXNV?=
 =?utf-8?B?Q3dEdERwUldmdGQvMlhrdGQ5SXBod0ZRUkdQUU0rQTFSTUY5dU5UYmJtcjdM?=
 =?utf-8?B?emx1K1RYMkpqZEgza0pLUW94RU1Jc1E2dEY4dkNpbU1yNmxvR1RqaXBLZzFn?=
 =?utf-8?B?ckhHelAzaTFzUzRoSDVFSjRBMjVlVC9zUDdQTHBOcXljc0NsOXZxRXFyRUZl?=
 =?utf-8?B?Z09HQ1pZejlIVWI3eVhFSnZhYnZ2Y2ZVN29MUmtSQ3gvWVhHSk5Bb3pIc2Ni?=
 =?utf-8?B?bm9xSlcvcndnM3FlaVY5V2hZOHdvQTVROVEyYk1UdnNVSHhqN2piZ0l3U0V0?=
 =?utf-8?B?YUYvZDM1RmMxOFlqQzdFSEg5RWxCdGRCdm1GanJIOFdtZGJZdkxqaVJPS2Vi?=
 =?utf-8?B?NTE1N3Q0VlFBRXJnNTl2Y0JVdkYxb2UxZ1ZvU3lDaDNaVnJLeGJ5L1I4TFhH?=
 =?utf-8?B?YUtsaEtYczlnTVZYSFhLeDErRVhWZWc1SkdSVGFHVHQ3S3lQVDlmRlM1WU56?=
 =?utf-8?B?bnNrUXdOcHNjYXNORDdRTTA3Yy84MCtxeFJXS2VSSGZUUzNQWGk5cTh3amRH?=
 =?utf-8?B?RWVNeFhVVnFmaXRUSFRlc0hiNTkzUE5YcndRSGZ0dWxmNmpTY1ZpUVNTRXBD?=
 =?utf-8?Q?iExMWTG5q8E6FK6zmJmWxNoC3IAG+4p8pp/COINuOqtc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGZYaG1qRlNVUVZmbXY3V0F0U3hpckRPTnp3YS82R2VsWE1vSFc1VDViUGJv?=
 =?utf-8?B?OXJCTmN4aTFDdHNHcDN0ZkxVSXlESktpTzdoUUMvbkNWQ0phRFNLaDUvQnZR?=
 =?utf-8?B?cWY4MmhhOHYzTEpPelovOUMrL2VPMTdTbXJ0MU5NVmxpNG5FWHNVWHlreklz?=
 =?utf-8?B?RnBsQ0NvclJId1NXY1JoUHpDYkVqeEI1ZzA0M21JZ0FZUHNGTVF4OUcrR3Jk?=
 =?utf-8?B?elFYWlVnZ09XZHU2NjBHSXBaNm1sYWRJeW1LQXkvbDNSWEF5eFNmMnErbjg0?=
 =?utf-8?B?N2NvNU9QL0NiSXBPbXR6RHhOZmc5c3RmWWNmRmFtc203YjVBak9EN2FFVDBv?=
 =?utf-8?B?VENIY0c4MDdrK084RTd3RTBjdkNTUHJzY1FDR0U4aDJzS1ZOZjVBanFHaGpL?=
 =?utf-8?B?d3hRRFZxVzMwOWFlY1BlKzFnSy9lWVV5dzZDdVh6aWoyQk9VMnZHbkNVc1kr?=
 =?utf-8?B?WDRyWFpYY1g0b0J4bUlCb0NveXNkTWcyM3ZORFhEUWVFbTM3alNoOEtCcGgv?=
 =?utf-8?B?aTNOTk42dkptRlY1dVJLWGZzZGUwSWlwQURlZ01uSnZSZ0U5TlVuUkZQTEZj?=
 =?utf-8?B?dGdmVEtPMkFxSUdmRjhkRk96MU5zeWNaV2xxaEFPTkJFVitkN0h0c3hiZDNu?=
 =?utf-8?B?d0NNWVhHQ2VWeUp5NmRMVm82ZzUySFFoTjdnazZ1bXh1c1N0b0EwUFVZTDNL?=
 =?utf-8?B?WHpkMWZ5TXJ3ajFDMDZmbTBIUE4xbllvMWd5ajZ2dDRkMmZkNVU3aFFyZ3hV?=
 =?utf-8?B?eEFhVjJVSG5qejgzUmY0M3BXZG1sWU1QWVpDakxNZ0dlYzV4Z3RZVGJwcStF?=
 =?utf-8?B?bUVnUStNSWhYak0yWUl5aDgxNUw1QkhXLzNVekpVajJVUVMybWhZdEozVzk3?=
 =?utf-8?B?SzZpcmdLT00vVTJxbzhSVGJLeExkY0k4NisrbHZ4RmtmWmlvSGwxdjJqSWxU?=
 =?utf-8?B?cHhWbEd2SXZQTFlTc2Z6R1hiKzRjV2w5TE5wNmdsWkQ3aE8rTjV1TFBSOGRs?=
 =?utf-8?B?VHV4cndKWmVLeVRjcHZNc3BWaW5WNUFFYTMveXo1NjduWmFISHM4M2N2dUJt?=
 =?utf-8?B?dTdWTDgveVc3V0NmaVBLZUFhK24rM3RSYkdTSk1DVTZVMXZTcmtFSUtHdGp6?=
 =?utf-8?B?dmZCV1JuckZDcm0rZXRoUWZ3elplK01raUFsZlVlNFpNODZFR1dJSGJFSXhQ?=
 =?utf-8?B?QnlOV25DYXBXUWUxb2UwUFc0eWM1c1dzQW9Cakw4WkFqMndaM0VhdDdCVXpz?=
 =?utf-8?B?RjBwS21DN2NneG55dzIvaVA4Sjc5Y3d4dGZvMUtUVlMvSnRtU3RaVFdTU0Vn?=
 =?utf-8?B?aGJQWnErVUdneFBIenlWUk1YUTEzWmxaWngrL1JFZWtGdGNFN285YytSVWRL?=
 =?utf-8?B?N1haelllRWxReXpzVGd2VUd3SkIvMmwwWDBhcXNJMFhRQjZ4elhsV1oxRkFV?=
 =?utf-8?B?SUxhbFlicEY1VittbFpkSEJZR1FRc2ZkaXY0UlNxeHVYaXpxTXdHV3lhYWc2?=
 =?utf-8?B?RU1Pd2ZnNWRPZ2JHbTNiMmVFOHh6cElMa3M4cmFzcHJVYXByVTZQL2x3aXVK?=
 =?utf-8?B?cnpyb05aMmp0Y25YelZCOVJzNVY3SkptekJlRFhhMEFMWDdMK1dHY29PcXRS?=
 =?utf-8?B?cTlkUDRzSTlGWEQ0ZGN2dlFCdzZlVzlvVnhtTmV5SXY1NElBR2hiTHU3NTI0?=
 =?utf-8?B?L1VyNjJFd1M2eVZveEM4bnFoREM0clV1anNxQldudk5aS2cwaThvb2twTWor?=
 =?utf-8?B?M0EvaWhRSVVIcTRtTlptVzdaaHMvUUJCajVBc25JckkvNlVmWVd3Z3FRWi9u?=
 =?utf-8?B?bXBKaFQ5dXNPdFVtaXRuQW9iNWg2VVJDM1ZHdTFRWnVVeXV4VTZYcElwMEJV?=
 =?utf-8?B?dzJTM3hzRVRrQ0IxRkJWb3VNU1JDMVNlcGY2Rm9lM2VxSUNha2pVZEx4eGlX?=
 =?utf-8?B?NlVmbTUxblpsQkNMWVNudklSQkN6bmxsSjZSR0M4WHIrVm4rb1pMOTVNc1hn?=
 =?utf-8?B?MW03djdMNE4rZWZpcDNLNzZDSzNRVVh1Z05BNjZLb2pJeXRhUkk3VmJ5dEFz?=
 =?utf-8?B?OEJrRzF3RGhGWkJsS0tGelU3RlQ1UHdJdlBGdCtOYy9sMzM3TTBPZkN0aUQ1?=
 =?utf-8?Q?PzLHXkaKoGVbo2gql1opjDRcf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340fadb1-45c3-4c65-a5be-08dce2eae7fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:02:52.5123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhELhczVQbP3jXEe/t02Apm4RqxHh59xrAx9Jjd7GLIsCUvU/VqBfBmd1SvXMGRqHWsrwKhbTkCrQQZFUxxcBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820


On 10/2/2024 6:19 PM, Richard Shaw wrote:
> On Wed, Oct 2, 2024 at 7:30 AM Linux regression tracking (Thorsten 
> Leemhuis) <regressions@leemhuis.info> wrote:
>
>     >> Basavaraj Natikar, I noticed a report about a regression in
>     >> bugzilla.kernel.org <http://bugzilla.kernel.org> that appears
>     to be caused by a change of yours:
>     >>
>     >> 2105e8e00da467 ("HID: amd_sfh: Improve boot time when SFH is
>     available")
>     >> [v6.9-rc1]
>     >>
>     >> As many (most?) kernel developers don't keep an eye on the bug
>     tracker,
>     >> I decided to write this mail. To quote from
>     >> https://bugzilla.kernel.org/show_bug.cgi?id=219331 :
>     >>
>     >>> I am getting bad page map errors on kernel version 6.9 or newer.
>     >>> They always appear within a few minutes of the system being on, if
>     >>> not immediately upon booting. My system is a Dell Inspiron 7405.
>     > [...]
>     >>> [   23.234632] systemd-journald[611]: File
>     /var/log/journal/a4e3170bc5be4f52a2080fb7b9f93cf0/user-1000.journal
>     corrupted or uncleanly shut down, renaming and replacing.
>     >>> [   23.580724] rfkill: input handler enabled
>     >>> [   25.652067] rfkill: input handler disabled
>     >
>     >>> [   34.222362] pcie_mp2_amd 0000:03:00.7: Failed to discover,
>     sensors not enabled is 0
>     >>> [   34.222379] pcie_mp2_amd 0000:03:00.7:
>     amd_sfh_hid_client_init failed err -95
>     >
>     > No sensors detected - do we all have that in common?
>
As in all system there is a issue there is no sensor supported.

>
> My last log was with 6.11.0-debug[1] and found this:
>
> [   40.178603] kernel: pcie_mp2_amd 0000:04:00.7: Failed to discover, 
> sensors not enabled is 0
> [   40.178904] kernel: pcie_mp2_amd 0000:04:00.7: 
> amd_sfh_hid_client_init failed err -95
> [   43.913688] kernel: Oops: general protection fault, probably for 
> non-canonical address 0x3ffe71b40000848: 0000 [#1] PREEMPT SMP KASAN NOPTI

Since I am unable to reproduce this issue, I added a debug patch to the bug ID.
Could you please try it?

Thanks,
--
Basavaraj

>
> Interestingly the first OOPS was right after the amd_sfh tried to load 
> (if I'm interpreting the above correctly).
>
>     >> See the ticket for more details and the bisection result.
>     Skyler, the
>     >> reporter (CCed), later also added:
>     >>
>     >>> Occasionally I will not get the usual bad page map error, but
>     >>> instead some BTRFS  errors followed by the file system going
>     read-only.
>     >>
>     >> Note, we had and earlier regression caused by this change
>     reported by
>     >> Chris Hixon that maybe was not solved completely:
>     >>
>     https://lore.kernel.org/all/3b129b1f-8636-456a-80b4-0f6cce0eef63@hixontech.com/
>     >
>     > This looks like the same issue I reported.
>
>     And sounds a lot like what Richard sees, who also sees disk corruption
>     with Btrfs (see https://bugzilla.redhat.com/show_bug.cgi?id=2314331 ).
>
> <snip>
>
>     > I still encounter errors with every kernel/patch I've tested.
>     I've blacklisted
>     > the amd_sfh module as a workaround, but when the module is
>     inserted, a crash
>     > similar to those reported will happen soon after the (45 second?)
>     > detection/initialization timeout. It seems to affect whatever
>     part of the
>     > kernel next becomes active. I've had disk corruption as well,
>     when BTRFS is
>     > affected by the memory corruption,
>
>     Skyler, did you see btrfs disk corruption as well, just like Chris and
>     Richard did?
>
>
> Yes, most of the time the btrfs write checker catches the problem but 
> not always. I've had to reinstall F40 3 times while debugging this 
> issue for uncorrectable errors. When I run the debug kernel I think it 
> brings the system to a halt so fast it doesn't have time to write the 
> corruption to disk.
>
>     From what I see it seems all three of you are using Fedora. Wonder if
>     that is a coincidence.
>
>
> Possibly. Can't say there isn't some patch we're using that's helping 
> cause or expose the issue but Fedora tends to run the newest packages 
> (including the Linux kernel) so can sometimes be the early warning 
> system for other distros.
>
> Thanks,
> RIchard
>
> [1] https://bugzilla-attachments.redhat.com/attachment.cgi?id=2049688



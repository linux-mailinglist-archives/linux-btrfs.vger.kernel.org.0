Return-Path: <linux-btrfs+bounces-4755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FA18BC4DF
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 02:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4245B21610
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 00:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC314404;
	Mon,  6 May 2024 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GOSoEvRg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MQxlMY8/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B109394
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714955635; cv=fail; b=i9aZ/jbLGNk7vW3sYV0J7qMIVJoxAz1UJILXnN8kT//smLZ0O7Vu5kOAfh50AXnFSu6W9Z4hf4sP6o3c8yda7mOuiFFqFkvV58MuEduI1R4S7X47XDb1IbJ65vpG9GX7MNg8+02JgCI/OvqyJfNbLdTtc+SovWU5PhxanGJP/Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714955635; c=relaxed/simple;
	bh=E9ucznNlwwxof3hpFRYi3DcHXXVOUDExDRHzv4wOEGE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HU4hR7NZs1ysXfoLGA/Mm2EKZNcloOFVt/dOn04wWgmEfF0+arTDG12lPG87mLz5plKL36UEZl7o4Sub+iFclUjQauJzyC8UdkArNEfTd6o2W8QwayLYYiF07RvGcCpyrAkIkm+o+UtRIM0QXJKt04orhBpkYXmvUno35C5kuas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GOSoEvRg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MQxlMY8/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 445M10lv017800;
	Mon, 6 May 2024 00:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hEQc/PAOtYPM1obl9hXojfU3yBO13NOf1xcGvMsB1QE=;
 b=GOSoEvRgN1E8CXPzirR5cSjVjOGYvYwDrWvnA6azgk6dvOvjWDIP607q/4rI7BDrUegm
 OeZ4mbVGNyfTd+KiGX6wFuyz/oPRAOs4XJwh+HsQ4jv6aHSayzvU0/lqoWnuCp42DAIz
 U19f9JxJaQSfcWZ8mjMxG2lTVegyyhaWmotGkSR/3sXeg1Q0wHmBTUX1DAvaczKvkjqn
 9dX66Rz8x+kFVxfyEddW5CK1p81ls67J8XJPhpMhMupAcO9MNWrPIWDaBNWfdIU3hVRW
 r7VVIJ+8YexBmri+h9zk5fzmYh48AtexwCfWyJ4QG4lrH2d8Q9Am0IC/bEWrRLG9AmVH Zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbeesk35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 00:33:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 445LExt5027594;
	Mon, 6 May 2024 00:33:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfc6p5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 00:33:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkfTzPRQoajj2O6go2UrZZ9R4oAK4lkrkG9xtR7xfPJ/Z5Y43K8fe6ANEsYkRgDSkSrMWamoOkuAeuCvlA+iS05YN+gFamewQzM9pdkszSrPnDX6VMtEaW3kcP4qzXkQerYoP755fJf2Z+MSwipBRHO9z+PFR2ZBscZPttWND1tois3nwP7GIU6Yqmu9aGYc3ZeUocSHaoNh618NX/ejgsCyBxdmkgGsjicnTBOCb0tIsn2uExArb5IbD1tz0gbEt/XUAkaJ3ybgsiBxdHeFFt8jl33Oh1S33FkWDlsugn8JHYbCjM+hjC2dsKjY47Qn8odW9Xb6RGiblcPU/a4mOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEQc/PAOtYPM1obl9hXojfU3yBO13NOf1xcGvMsB1QE=;
 b=TMFIOKCzRIju3E36aYJrzdEbTxWzXlq7lXEmOXD9Do3ZIum1dlprYoKKFspRiGZ0kA8ekxRnShZwQULzXQW40PJr4rFy6noGZtut+js0jFOTZYajLukYP60pZ+GsSdf9aj9hxp2bPZTsOJoMPqwkcr8CL2CRxU32gv43H7+wq9DLLTaovfVyaZHlNkHSFFBu5lWH8t4/u03Vuj3VY4FqIorHLI3joAU2M8NcAMB9WpEP/BTMFMpHGFZ3B1oEZ5DMjSOvBZeGW1L8WoXWTMeSaDRdCKaTwFqmsTwTEUWh2P4Qlr2ZAAaQFkZSRKBh6DDu9sIw4oZagwEvSF85EQQddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEQc/PAOtYPM1obl9hXojfU3yBO13NOf1xcGvMsB1QE=;
 b=MQxlMY8/ocpHvFsAnoaZjAtV13Pl6IERWKP6977Nrr/lSSb1X2BxAnajncS0Ma4WZb3NzjTL/DiKHnRB+YQeYUR0QOr8zck5Nx7EdZgsZqJKM2zlEEkWJ1HzZ2FZ+v6Bz5t7Mr7gt1yJQRUJuN8jwbYtd1ni/6kFTidl6t9N9CA=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 00:33:34 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::1050:a638:7147:a0d9]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::1050:a638:7147:a0d9%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 00:33:34 +0000
Message-ID: <14d29830-d369-4112-a684-b862f7b1f139@oracle.com>
Date: Mon, 6 May 2024 08:33:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-convert on 24Gb image corrupts files.
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, jordan.j@mail.bg,
        linux-btrfs@vger.kernel.org
References: <d34c7d77a7f00c93bea6a4d6e83c7caf.mailbg@mail.bg>
 <0fbad9f2-6f26-4fcb-ac8e-a1fa4ebc80db@oracle.com>
 <f6aca430-55fe-433c-93ef-4fb2efc19ec5@gmx.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <f6aca430-55fe-433c-93ef-4fb2efc19ec5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 9059e09f-21a8-46b9-d1e0-08dc6d642251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dkFEUk9Zcm4rY2pFMlNHQUxZNG1JZXBIWXFZZ3JVTjB0REhkQ0dySUFwL09s?=
 =?utf-8?B?ajdVMUVIVDdaa2tyV0dNV0tuZ2pzMklCZlUwaVM2bmo1QUhuT3VzU1BPK1hw?=
 =?utf-8?B?eVhZdFVwVjMweUFvMHNmKytlNHRkZGJKc0VEdzV0UjRndk9Ec3FJejd2QTNV?=
 =?utf-8?B?dk9OV3ZBWTRUMVVreHBsMy83UXNFOHdLWnZOdEFOeVFXdzZzL24zR09JVnBY?=
 =?utf-8?B?ZzVKWTE5ai8yTjFrOXhMN1Bya1JSaDRRQUw0ZkM0enJ5UzJMNE9KUEd0OERk?=
 =?utf-8?B?SlgrLzYzbjlHYXhheVY1aFZDMlRWaFpicUNmSmU1Q3ROc1Ezcng1TjFKUm92?=
 =?utf-8?B?TWpDeXlpaUJmZ0cwTlY4VDVPZ3Zqc0hsY0owdUFLdDVtU3h4c2dZUjc2VVk5?=
 =?utf-8?B?NmE3NkJCYnBaK1ljdWRUaURRekRBMkdJMnVCTWlOUFc4dFM5WXFWV2k2Qksr?=
 =?utf-8?B?OG8vd2RTcHdabDFyZW1JUkY3NVExaG9OOC9meTZBaU1ZZDJBWlNiWXB0Smlu?=
 =?utf-8?B?Z2daOTNkWnFEQTUvU2EzSlRadjkxZm5WV3V6ZGQxT3JqcVNvS2dTZDlHbnJ6?=
 =?utf-8?B?b0xVcklpUXhiRTRhckVzUFFmV2gxRmJTYWt0VWFxWStiOU5URlYrKy9hR0p2?=
 =?utf-8?B?dmtHbVBPZC9OUTlDWXpKb1NFZ1lvejd6WVBlOHpKUXNRZlRkVkhBNk41Tk5z?=
 =?utf-8?B?ZUdaaVB4a0F6N3RMemhTK1JQd2xJbk9IdXh0bE9TQ09jUllaTkx5K1VxWWdJ?=
 =?utf-8?B?WFM2dE8vOTRONCs5TkowS1dVN0pTdFZTT1gxTTBhOWxYL1lub0FQbHlISW5E?=
 =?utf-8?B?b0hGWUEvaGpVMVJlTFRVQS9yZzNjUFJDMW1aM2xQVjlzUm4zczNHdnZNMm9D?=
 =?utf-8?B?bmJMeTBXZU1ZUU0yd1VqaWF6YWhOcE1mamkzemR2bDFYZUR5NjJzWWpGOEpm?=
 =?utf-8?B?RVl2cTBFM3ppdEV5TjNwRWMwL1NHQldtU0NvdFEwU2tYcGJ1aTBwdlBkVEw0?=
 =?utf-8?B?dkVlYm1vUFhxc3lieDhleW45S0FkOXp1Y3ZGU01EMERFbmVxdU9pWjJPVnBX?=
 =?utf-8?B?R1NsM2RDeVFGWWN4eDQzckRPd2lYZGd1YVJ1Skhvbzk3WlhUS09oa0Q0QlB4?=
 =?utf-8?B?VWgrTXRRNWVKaEtrZ0pPUi85eW1uNThCWUg0enJvV2w1WVBJKzFNaXhjdGV5?=
 =?utf-8?B?TGJSUktoOUlKNkRtb3NqdnZ1aXNzWmxlWGVwOEV4clZURmtKamY2Z3RDR2sz?=
 =?utf-8?B?RzlFQWtPWlJmYTlXcUJ4WUNUaUo2K0I4cTB2UzZ1NlNTZUt5TmZZWFh1dU9Q?=
 =?utf-8?B?UzFyelFJcUJNZklmc3FGVDk1L1YvclBHL2Q1d1hsc1h4K1B0VytBdllqbzRq?=
 =?utf-8?B?MlZhR0hMQ0xoMWtTcXpsNEJpUWlLa1BUdnRPOHBzeEhrYUpVQVJxMXZLRUJJ?=
 =?utf-8?B?dDNEei80NTM5YWlGS3c0Zm1wNmZJVzY3cmRIQnZ5ZGV5TGRLV0FSc0c4aUlT?=
 =?utf-8?B?UGRjb1l4MjdHamdDZ1VvbkRnQ2R6aU02OXBVV2s0SnNsM2JmNTJhNVJ6eEk5?=
 =?utf-8?B?L0t0VDk4SVQ4cTVHdHhOQ09pSlpOeDF1OWNFbG9ITUVkczBiL3lKV0VHTVh4?=
 =?utf-8?Q?wbQi500BbwvwwyidLSSaxqrQbFGu+C3mZXfpcvkpXGdc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MDNFNm5Lczl5bklUYm85Zi9PVDRiZFRWYnlhUGsyVEYxY053VzhJRzk1ZWJ5?=
 =?utf-8?B?bFhkaSs0WXhaMkpNWkkxRUROZVBpbmc4QlByS2hhOXh1WjcwZVlTRjVuTjU4?=
 =?utf-8?B?dFpob2lNc0pOV3IzNnBVdXpYYWtNVVQ5UXNCTlVnYnFXTW05dEptcDBaVWtE?=
 =?utf-8?B?Z0R2TGozNUQzRWt6Y2FuaXZXK3hzL2xmN2Q3dUFXSk52UlhsL1lqanJ6Slp0?=
 =?utf-8?B?MXBYalo4aDJZRGp2VXVxT1grN2VyTWI1dEJpYjYwUEJNeDJ2dWUxWXg0M0ll?=
 =?utf-8?B?UEdmV3VMYnh1Sk5TNnRaWEdOeXl6SlEzRWpCQW9NZjE1bERsRVZmRzFWTnhy?=
 =?utf-8?B?NlIrenBicmR4YjRZNW1ISURSMjFnUmg2OFdGUzFLSnpPRjBienV5NDhmb2dH?=
 =?utf-8?B?V05jNFZlOEVQU0pUM1REVU9PNjdlOGx1YXZ0Rk0rWFpodGFjSTI5SkR2MG5k?=
 =?utf-8?B?RE0rM2QvV1k3dmo4LzRldWJQdkk0TUtqWDlvQTNMK3BJeGl3Y3FRcW93aUtp?=
 =?utf-8?B?SGdPTktESC9tdkYrYi9IM1ZwMzdYd3pzSXE3Wmszb0F5NkhqZkg5cTFxUzBP?=
 =?utf-8?B?N085Y2prWFFOa0U3KzlVanovZ01Ya2ZRVXVrS2wwdWw5UHJwYUJhUDBnYWtT?=
 =?utf-8?B?OTNTWnVNQkZvSHZyY1FkUmlqaEk3QjYvaUtTWlJxbms2NDE0N2tXTTV5dlF1?=
 =?utf-8?B?NnRRWHpKY2dqMzRiRng5dFR6ZWhaTEpJaUxjY21YK1VQSlZjMExGRkpSbndu?=
 =?utf-8?B?WU1yckJBL0FSMWY2S3QrQXhnZm53UXZMUUpXSnZrMUtIbkxRMmNUUU53bEdF?=
 =?utf-8?B?STZFM1pZWkpISG5yYzJEZFkyUk8wc2lNQmxGUm9XVGJvNjdlcEluQjd2STVO?=
 =?utf-8?B?cGxsaWc1cExjalV3RTRuMmVDc28rRUNNUnlOazNjWTc3eGE1cjk1Rk9Sb3hs?=
 =?utf-8?B?Tnc2RU1sSW9SemxJSlRkV24wN3dta09qc2tubDRDNzhMaUVKRFZBZzl0TW00?=
 =?utf-8?B?aHdwZjRXcVp0alpORHJMeVVKajEzRnZ5R0FlNmdVMDI1RVptOUZvTkdlUWhB?=
 =?utf-8?B?L3U2emhaSUdyRHJPOFA0MXQyQkJURit4dXQySk5oOU9jeHBIYk9BTGM0OGZs?=
 =?utf-8?B?N1M0dGo2eDI1djYweEJBQnZZbkJBSDNCRW9LcmlLbHFmKzZKUE1LNWFpZ3ox?=
 =?utf-8?B?a3NOeEFUWE9tT2EyQkt3dGNtck4rM0dvYUJkQ3U4LzJ3QUxEcFhoWGtjckFD?=
 =?utf-8?B?NjBaSnNBQWFIY1hlc3RQVEJLQ2hJbmVjQ2dqeEswS3BSa0Q5cjdYWHUzTS9l?=
 =?utf-8?B?MHU4M0xSQ01KK0I4OWUwWnI5REtxamc4RHZpZ3BnWGlMSXJEdlN0ZzFOZm9M?=
 =?utf-8?B?SXFQN2hvKzBFdUxBeDFrK0pHVTBMMWhyR0k2SjJEaVhaRFdSZlo3ZGI4WVFF?=
 =?utf-8?B?bTJHYkhLQ1lLVThZZVNTUWt2ZjJqYVgvVzErUDE5NmQ4akpNY3VkaXZEVGlz?=
 =?utf-8?B?dVpKQmhpVnpXeXFsZTJIQnpzTWxoWW8xMzN0WStPTmZqQVBnS095VjU0K3hW?=
 =?utf-8?B?VzFCTzNuVU1lTlpSMGtXSk5XVXltb1FBRTVZOWZ3bkZPOStiV1hYZnFGa0NH?=
 =?utf-8?B?bHd2djMvMzBUYTA4K2NiSWFqSVhhaHhQKys4MEI2Z1lDUXcwdXhvQm04OEl3?=
 =?utf-8?B?MW94Q0lXQW5uSEZMa3Eya3JCUTF3N2N1YWNkR2tzVE9lcjRkRjEyTG1HeFJZ?=
 =?utf-8?B?TjZZbkpjQVJLSXNpUzhienNTS1RRVGtXM2s5dWFNNFJoZzlpQmExSzUrTmJR?=
 =?utf-8?B?TUc5dmhJa1pNbm5iWks1bjJpMzJRV3YyeEd3aWNHNFFGUmVVR3doaHNtZEUy?=
 =?utf-8?B?K3A3UlNLalBzVG81Tk5TSEs1SStCOTVUZlB0UTdEZFRmaVJFVUYyUEUwWFJu?=
 =?utf-8?B?UWdSZFhIc3VXd3JJRzU4Q3JQc0R3bE1FdXFTd1BlOGJGcTJqcjlORVJWMSsy?=
 =?utf-8?B?QTkySTEzVVp3d3g4SXB5UUZRZSswR01kSHJ1ZWFOSGZWK1RIVWltOHM5b082?=
 =?utf-8?B?ZkR3QWV1a3hZSEpOUWNUOUJtaHhxbzNPQWZkZUxiSC9Rd3BKL0VQNHZlVkha?=
 =?utf-8?B?VnpReWJwMEZMeGxqQ2srMy93alVhcUY0Y01FTFhWQW1iWlBvbnRPODc5NHlt?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K1ipk8NHdddu+GJRbRlafgS5DWF2P3gZ9v56sakCsyOaaUr2d5sV45eVny7pAXrf69tok5TPPaoPUvvT74wzvAvBc7YjnpTYjBSAFmXbIKmd/N23gG+BZcfKVD77MFfbpg9IOjICk0l746KxF+CK/4anuOFOOn9bpz74Jg9ff+FgXjBGocBg83SBWHh+TPio3maHn4BxJ9ubY+5+Y6T+KYa2aF4rMBBzbEdW2Sv/7ywEFI1HIG3ZXcqrmpWzlYG9t40hYH5TiBmvKswR5eQn4IbXWgRoikNCmqHgsJdsufph4OM7XpdFR6Q9X6sUTgxmtkixgLPCOl3GwvrkudsdfvQCebgX1q6zZ5dGpRINZ0Sy4AtgQeahB9O40ihSIWklL5MMZGfUg2O8SCjdSNx9trGzEdv+i2OKuA+dWsPYuEK71DkpQB6L76jki2uEoPvvE3QdTynOLpkDIIC5w9OhlEJF9FCYm5LO/78boD4PmAPjVF2zjmYLPZW534ntpU3HZF0HLz0DZ4237CSHtOgptmOLnM3IGXFt1BCsFaSGBVVvzr+CqWj/aTAnJTwQbSUYu50C7LN4t6gXrQYsJNlYK5R3wHpcXsRueQQDI2+Nntk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9059e09f-21a8-46b9-d1e0-08dc6d642251
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 00:33:34.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pRKwnpCYakjXl7oOCYe9ALqOmVLB1xYC63jtsEE95Y2kG2NElWFaLUEpJ7ixCumqNnqSQUOwsykkA8irpXEYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_16,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060001
X-Proofpoint-GUID: qxgV8ThUil70bflWMOxijYpHCqtgkDVq
X-Proofpoint-ORIG-GUID: qxgV8ThUil70bflWMOxijYpHCqtgkDVq



On 5/5/24 13:54, Qu Wenruo wrote:
> 
> 
> 在 2024/5/5 10:26, Anand Jain 写道:
>>
>>> on ext4:
>>>
>>> ilefrag -v
>>> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite
>>> Filesystem type is: ef53
>>> File size of
>>> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite is 49152 (12 blocks of 4096 bytes)
>>>   ext:     logical_offset:        physical_offset: length:   expected:
>>> flags:
>>>     0:        0..       1:    2217003..   2217004:      2:
>>>     1:        2..      10:    2217019..   2217027:      9:    2217005:
>>>     2:       11..      11:    2217028..   2217028:      1:
>>> last,unwritten,eof
>>> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite: 2 extents found
>>>
>>
>>
>> btrfs-convert doesn't support ext4's "unwritten" extents. V2 of the fix
>> is in progress.
>>
>>    [PATCH 0/4] btrfs-progs: add support ext4 unwritten file extent
> 
> But the reporter also tried your patchset already:
> 
>  > *********
>  >
>  > Tried the four patches from:
> https://lore.kernel.org/linux-btrfs/6d2a19ced4551bfcf2a5d841921af7f84c4ea950.1714722726.git.anand.jain@oracle.com/
> 
>  > on the https://github.com/kdave/btrfs-progs.git tree - no change.
>  >
>  > **********
> 
> Any clue why it doesn't work?
> 
> Anyway, for now I'd prefer to change those unwritten extents just to holes.
> 
> Remember every file extent is shared between the inode and the ext4
> image, meaning even if we created the preallocated extents correctly,
> any newer write would be COWed anyway.
> 
> Thus for now, I believe changing the unwritten extents to holes would be
> much easier.
> 

Ah. I missed that part. Thanks for highlighting.

The data size and extent size might not align. In v2, I'll detect
this and handle it. I'm still figuring out how to split merged
blocks into separate extents, so that prealloc flag/as a hole
can be set on only appropriate extent size.

Thanks, Anand

> Thanks,
> Qu
>>
>>
>> Thanks, Anand
>>


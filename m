Return-Path: <linux-btrfs+bounces-9047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF89A94FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 02:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48DD1F23190
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 00:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A82233B;
	Tue, 22 Oct 2024 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j7fdbdu8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X2KdaLi5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD54A35
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729557112; cv=fail; b=XSC8eVlNYD/VCejv/l5UtLnRXBShjSDLdkE5gngPSrSng3rKeUI9/wxnzX3UotD1UTYdEr+by2q5UnXJsuuRtH7SLKuao6/Llgkjvl76lD7SMYps7ZitxcLyi0+x7J3gN/vyGBV5AA2r4TpGJkuUrLcC9+ufQBsTFagIz5E1eDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729557112; c=relaxed/simple;
	bh=apRugrA6HgxntHgMKHynbx1RcV8/d23YsXj9uao+TPI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HFdiEBejJYKca9k6HGIkN4Ka0Dm1u4+OLIk0A91oJEsXfM8IsXOov/O3dH3OLCQ9id3Gq0mlI1ohhzi1iWmj7dlUfUfTkiceQDKlcsws3NabEA2ksgziU01ZD8oc0oAgv75zegxdyouNtxBj1j0xuzYJZ4DjHPV43TB8+uJyW9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j7fdbdu8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X2KdaLi5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKfgc8002289;
	Tue, 22 Oct 2024 00:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+KZsdKnyS4cQvFxu49R0BBJFztZhNJ442sM/iBAffWI=; b=
	j7fdbdu8fe9qSNGrAeh0SrWJPgmh7ozcpZPgWH1s/SHg/IN9DmfjMx3A53+dVDkC
	vqjgLKHKGUscfmw0mpf0mtL9PjqOXIACWGn/JgxZB6FSSyNI9UJ4QRSP2sCDFNJ/
	e/ecYw6gCYlacejh3qc48LjDe55dlEvMD1YgPb2vnVq9qT0/82yHZRYs0hIiGl6G
	JGErD/Wsm8qm+EIjwkTNTJjKyMY64zTgzgceEBn/HHvodKr5nbLBrSsOWDSv69Fm
	/AEECtLfneKar1TA3FsFvn7LjQMw+99hiuDQDGqCioVIZLue+gWTWxERf8nOwiYl
	kxCVZvev4ENZWqRb3qjwxA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqupfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 00:31:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LME1m0007729;
	Tue, 22 Oct 2024 00:31:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c37717mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 00:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh+2Tzp1svj5ZgNsDhkibnlOF/aOSjHfRFqzloOKD9Y2gQrUZ4AC6+IBFAFlkAVhan0iplNtXsOr6VNrYp2FDWi1uLhyZ8vcja6ZgNEHQAmWovrm+6oX/Wp7cVHUEATSZecwKm0bmYvGEgjq2KFRwlJ0cHpVkDWQPs5qE2WECehspXNTGU9yoTURZwLDpDfRaV3fe+dJeQUPfcyicvD38Nla22fT6MRfut6kDVPoMVZyjvFLwwcSLxioXXDe26poaUduFa0niwJuKjPNx67POo7CLPyDc35MUzP+z64UNRWNpX4ENuRwWqa5dUCf9YijmOWOoapGHlk+BkbwMynKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KZsdKnyS4cQvFxu49R0BBJFztZhNJ442sM/iBAffWI=;
 b=bNbjDCJNFBkC9YW1MBtk7ZEOwSDAONS+8KBe2OSiT2Ul9+Ap5BUF4ESlxcqurWlWN4ZfHDo1v9Sm9GZGaLzvl9Vp4oLgZAeiRTt7Cz/VJfCRTAqW/wtxAHBV/wXCQ+Q0v/LKqsjZQ0QaGNi6t1JaHZpXuklhF+CsUyAjUDITA3sK8qZcNjSsJrXfMeBSE0AoxG23A9OspLJD9E3KJodj4nPtbB/MmT+Znh37f9c4axjkDYplpQ8itqw3xlFac3mxxoWz7hFpIUtXwkZnQMOPIR3uv5HXMCmvlyUh3V2plhQHz1VoC5IqkDF2/wXH5t17BmpfjrUHuSjKV4y334P+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KZsdKnyS4cQvFxu49R0BBJFztZhNJ442sM/iBAffWI=;
 b=X2KdaLi5A2FU/Al3ecAFYfZO+5sb5jAFciVXyCKJhgib6GL778c8FZ4W/Ji79pWqvuSrWx4hB3425khvzcSCto2NQPLkDvBcVIIaEw6uIjN6KmlGSeUeRdHWO+U3cf2J+rmj50gvuumnZg5Ru9CUCAoDOd3/U2ep9UBt8UFhKd0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6654.namprd10.prod.outlook.com (2603:10b6:303:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 00:31:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 00:31:31 +0000
Message-ID: <f8301af6-f10d-431b-8522-af6dc015cb45@oracle.com>
Date: Tue, 22 Oct 2024 08:31:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] raid1 balancing methods
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
References: <cover.1728608421.git.anand.jain@oracle.com>
 <20241021140518.GD17835@twin.jikos.cz>
 <788e9d8f-df2e-4d54-b60c-dddbc47fd701@oracle.com>
 <20241021184253.GB24631@suse.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241021184253.GB24631@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2cf21b-2cdb-4dd5-9eb6-08dcf230dfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0JqQlB3dDl0THY1cUtpRkc2SDZTUFcrQXoyNDVsL3pmWHNYTnNRMDFmMlUx?=
 =?utf-8?B?Y3BaRktMWTdMRjRJTzd3cDVXMUVRQnFYaVc1Tk1MNk9DZ1pTeVFtREJSallB?=
 =?utf-8?B?bEVKblRPUnJOOVVXWUlTY3FTOTQ2dUZJZUMxREZKWVJOenRvaXVEc3ZDSDI0?=
 =?utf-8?B?NnNlakdMckJNMmFrNVF3bm1hNGJ3SzdCLzQ4bFNlRkdPREkzQ1V1ZkdnTENV?=
 =?utf-8?B?Sk45bVlubHN1bmFadnVXYjhUcEx4UlBlN3l1bSt4MGp1c2lLQlZjRm9GKzhp?=
 =?utf-8?B?d01YU1RhOXFoL3dhdHBHU1NJVDlWSkFpVWtiU3BEYzFVOE02NjVCWUEwVlFQ?=
 =?utf-8?B?MUtFRzUybEJYS25lVFkvOXZPRVVsaGxuT3BhYk56WTI3V1NSR01tNXpqcitY?=
 =?utf-8?B?TnZ1Q1kvOEFPUHhyZk1KSWJRckpqYlNWM0NjRnU5akxlZVUxQmhwZE1mdnFY?=
 =?utf-8?B?SCttWHppNWp5a1Z5anh6Z1FZVlRCd25zelFkaFIxNkJlRVNUaGdycEVySnU3?=
 =?utf-8?B?amlDZ2RNZUlMRERXTkh5R1RTT2c4d1B0TFZ2dXJHK0k0RjA4cERBN0Z2WHBQ?=
 =?utf-8?B?Z3Ntd29QUEs1MVlKZFIzSkJTVjFCa3NaaWtUTHNIZDdLWGZiNFFRTTdRN1lx?=
 =?utf-8?B?NWxUV29rWEplRkxGV0U4a2RtT1dmMmxhemVWMTB0dm9JNkg1bWhkNndjelJk?=
 =?utf-8?B?R0VMUi9NZjh4RklsSDFEaEcrSFA2TTFaQXhLOTNIZjhrZ1V1dW0wRTJJSlZk?=
 =?utf-8?B?U0Y4MzVkYkRvT0JiV0Npd3Bzd1VLSktVbUozejNtamd3YlVvc3FqVzJFTlAz?=
 =?utf-8?B?YU10UXEwUDg0Q1lqajQ5RmovbXQ5dnpNQzJKeHBkVXQ2VlN6YWZNOUlzUlZX?=
 =?utf-8?B?RUsyQzdhRElvdHNYYm5qNGkzcVpHV1FWVFRqMTNQNndYclRyMHBjY0pJbHp0?=
 =?utf-8?B?MXllZWt4clBXemJiNkFpQkQwQmxXTEdjczkwbUphY0hYbGtFL1hyTXFsZUVL?=
 =?utf-8?B?Q01SSDJGZ2ZUNkNXTW9LZjREVmxRak84b3JUMkJJSEVJaGI0bjl3QU1OYkc2?=
 =?utf-8?B?U0U5SW1JSkRnNVlNeGRkU2Q3WXp6UnBDTmtGZm52OWRKU0cvcjJlZUNYWjFK?=
 =?utf-8?B?ZTFEdTRmQ0NrM3ZWMXR3c01ZYW5HeXV0KzlNa0RadXFlRHZvZHJVaTl4OGlY?=
 =?utf-8?B?ZnlVNXZjbGpVaGhVQ2FCUG9JTzBNOVNtbnFJSHNoZGhsWHlvWXhESnhJaDVk?=
 =?utf-8?B?SkprY204aDVVRUFoemlUWHZkOHl4d1ZMNmxDd1A1Wkx6STBsWGZ4L0tGVFFL?=
 =?utf-8?B?c3BreDkyNnJzdzUrZEZqMVpWN3RTVzlTOXJtNG9zWWlHUWR4LzJiaTRZbzBh?=
 =?utf-8?B?aXdaMVFCVldpN2ZORGZyVGFQaFpkUFVKNGxKZmh3SUpuVFhkSU96SDYwd3VH?=
 =?utf-8?B?WXhuTTA4a0JWWkNrK0tuVDREd1E1WkNHa2VPcDJ0OEtxSFRvN3p4MXRNeEJ3?=
 =?utf-8?B?anAwUXZSQnMyRXk5Sjk1WTdxZG01blM5WGFEU3ZWYlFTNldlV2RtQU54ZVlv?=
 =?utf-8?B?YVduUE1tUWdkdVJmSFFiZnNpaHNQRnkzbktWYlhCQ2I4NllteEFDNmxLSjUr?=
 =?utf-8?B?MDJrdEs4alN6VjFNR2FpYXpGc1J4QlhtSm4weFVLbE5ISHFGOEhZQmQ2K0lx?=
 =?utf-8?B?L1g2SUU0YjliRnJxM05nR0FlUFkwRkpuUndUY3gyUEVIc1VSaVlhMHNwM3gx?=
 =?utf-8?Q?St3lL/F+nMimgKBB+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE9QL0JlVEo1M3luWXkvQUdmTDJTbEIrNVRHM3Y4OFpud1pDSlI0WG5LVmQz?=
 =?utf-8?B?VG5abGtKSXZndmtEa28zaUFHYWJ3Y240VkFhWjRMdTQ2dE5jQmMwSzc1V2ZF?=
 =?utf-8?B?dVRGRlBsUS92amdvZlNFK3ZxcmtCY0tDcTJTQVkvQVVpMXVTbi9YbW5Ydk1Z?=
 =?utf-8?B?MVZ5Z1NRWmFNczBPZU0zTGtOaDgxYitBNXI3Q3g2bElIYTVlanF3ZDdvNkpC?=
 =?utf-8?B?MFJJUlBybnZKZXViUENYWDNXYlhHWExSbm54RldJS3FEUmFIR2RqcFNOaW9k?=
 =?utf-8?B?cU9HbUJQTitPZ1c0UTVINmpmQm5JV1VBYTl1UlBTRjMrbmtVamZacUpmV3dW?=
 =?utf-8?B?Z2NKUTlnWm1tSllGZHJKWEdpU3FENUh3VXZUOGp5QVcrVHhlanZDQTZFaGla?=
 =?utf-8?B?OXl0d0JoKzhHSy80bktWSEVScUpsNlZFMk9JTk9EZUVvVE5qYjdRSmRGbjVz?=
 =?utf-8?B?WnBVT1dCS0twc2RZVWQ1YjhPM0pNYk1ZNUMyMHQ2OVFabXNTaGNWMlo3cFVH?=
 =?utf-8?B?TS8yRHVNUjk4V1k3UGRZOUV0YVZXN3h5MzBYRVVKWTAvS0F2SHVYMWR2L3ho?=
 =?utf-8?B?WlVhT3l5eFUxQkp5dkhmYUN4eW1ZWTFYQ3dkT1c3QU40NGNlMHdOZFhqYkJk?=
 =?utf-8?B?d1BoNjA4OHRWOWEyU1FBaW8rWHlINW5pdkJzSlRqTFJzWHRDdU9MQmVEeUZG?=
 =?utf-8?B?NGFPcm0zRUhQZkJBaHRyTkRReUNmd0puUkttaW9tM2x0Y2J6Qkp0K0d1WTAz?=
 =?utf-8?B?SlFtMStJSVR1elpHT2x5NGRycnIxSFdyYmlGMXh4VGhIb2JNclhPRFAwTjhO?=
 =?utf-8?B?aWRDNEZtaWswMzBrREZaQ3hzTVdvdDB0QVBlbFA4bmk0TmpBVy9MclRad3dZ?=
 =?utf-8?B?T2dYQnp6TThuYUdOUnlkZm9kQWlHZGpoU1FyNWF1Yys1WmsxTVN3QnUxZjM2?=
 =?utf-8?B?WGlLZnlMYzAyNjBjOUpQTjJBY09ORllCQlUwdHBhZ0pnT0oyOWZ5N2NIc3pw?=
 =?utf-8?B?NVU2Ry9laSszZ2txTTZndUtDOGJ6c1hhcG01SWhsRkdXL3BqQUFJTjk1WjNZ?=
 =?utf-8?B?L1k5VmVJbmlUN01MMjdrTTNiNFJsS2tBNTNSV0VYQmZCdVpldWN1Rk1Kbmth?=
 =?utf-8?B?bWo5b0RHRGpPQmdrNFo3Z3ltVWNoaDJjblFiQ1diYnl6NmQreVZha3cxWk9n?=
 =?utf-8?B?a2o3dFVsaGE0bjJLRjRERE1PUG9ETGg0OFlxaGpHNGRKZUMyQTRzSnBybVI3?=
 =?utf-8?B?T3NSTVp1UnowT1R2cW9FZHYvaUp4WUZXbWxkTlc5NElTNEFrdklaRFh3MFlP?=
 =?utf-8?B?eTFhQ05CMTgwZVhQRFZDTGtnQzNNNXZaSVUwQkJpU0RBem1vRlliamhFbmNX?=
 =?utf-8?B?YURwTXhSYlFSNVYxWjJHMXJrQnhOV1QzKzkzL3FJNkk5cFB1WTlJVGlCbnhV?=
 =?utf-8?B?NzhGb1JveHRLYWw0RGpKNDZRaDJYUmc0N0FOKzBvWkpOUVdYN2NNRmtnVFBO?=
 =?utf-8?B?WGxsNmRCRnJSWG5vbnpVUEp1SEhCMlpQWWs3UmxCenJOY0ZDK3llQWpBODdQ?=
 =?utf-8?B?My9QbHlyTFpPZ2VieGl1UytXK2lKdWtZOW5CL1ZYbE90RG9PSUVFTlVyTlJN?=
 =?utf-8?B?b0FmK2hycjdXRzBpemtwTGc2RzlueTF5M3NieTRPbTVHdU9IYmxVM0M1QzFt?=
 =?utf-8?B?VHNGQXdUbnVMTENiU2g5NmZkRGhGWThlak9lZC9lbG9ZODdwaUxHM1dqRGh0?=
 =?utf-8?B?MHhyeWJxZ0JzUFluaEg2ZWNDQ0VDNkJyendPblZkeTBVMXBMcjI5d01IUG9w?=
 =?utf-8?B?RzdDbkJuL1pNSWhEZ2M5TnkzdDF5VnFYNFdYYWNaeHRZMXFZWmUyVzJNdmpO?=
 =?utf-8?B?Y3pzNDdYKzltdjZwWVEvam1zY0gyMnkyTHJtUXJjNE40Unh2b3MrTEMwd083?=
 =?utf-8?B?bmRFZEpEM1dGKzBWVTZQcldxS3M4anZocE5QSkh0RzVOTTRpR1MvYkpDbXhs?=
 =?utf-8?B?YTRjTEVWcDNUZk9sUmNXbC9UMHZEdU1uNFJpQi9STlRuNlBxMmp0MCtsTkZM?=
 =?utf-8?B?dlpCdzBaN1ZEaHlidXlvazlieVh5M3FWZFlOUXdEdUF6ZC8zTWFWSGQ2VkJa?=
 =?utf-8?Q?BcGacPkBOHKw9L+vYLe+DluJ1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QvjCf0tXaz8MrPMDm7mxhz3CDvF6ae3nBhFUq6mq1BMGvVIceKUmi0rpINpN6PFZ6gAJbuvM7eJ9tVNevj5O8m/HC1YC7Lan4LQG6GOZN31qC7n2goM7wSxIIPJVhAakHka8Mk9ugcINOW+cqy6ILU4pA15TFpaXvSDFCpG9/lJso/IAQ4SfXGfTG+ZmY/rmfVmqAPzu8/Mu4JYWLma9AweKRZTK3lzVo5569fpCJ0QhqDzmTHkTQeShJoXtnpEJjMxUuZtQnsaYlScjKPWYytAVo3+TV2oVKpntl8ku6K5Feqwet6FcneQgimcnrkUqa3WmoPkuO8rvD6b/7FN4of73fu0tWMX/vdFx50ajSftl9AbS3SJrDxCXSwKvsprleCP+OhBD3iOg7xxrKZ+QByd2q239tmKUbBfZr1WKaS+4rmb2J3PHhRoMiOSubjnUPHlFgyuX7jSFcOUgFV5Y1gqKGxXS52Rz/1aSaUMiLoWIZ0q8iPGlp6fPwmYCndbWUtrCuM2Vln/6lr/SCM5g/jobzjUyDJI6ynHC2+xRuVWXhlSGgEzZdzcP9Dc9RRxNgB17vNG3KAj26UIbQtgmpFwd5qhk0r+yAw9Uqg33mUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2cf21b-2cdb-4dd5-9eb6-08dcf230dfd5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:31:31.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GD41QMYv23i84FPRql0JXUYXhqEFVOtlhcOTLeqdyZh311+wiTUagboasrDwR3PqPWUgjwp2TaKBfYouj27rfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_23,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220001
X-Proofpoint-GUID: Qis2rKAdBj64MQ_iQh07o1ZAep6dVbvt
X-Proofpoint-ORIG-GUID: Qis2rKAdBj64MQ_iQh07o1ZAep6dVbvt



On 22/10/24 02:42, David Sterba wrote:
> On Mon, Oct 21, 2024 at 11:36:10PM +0800, Anand Jain wrote:
>>> I think it's safe to start with the round-round robin policy, but the
>>> syntax is strange, why the [ ] are mandatory? Also please call it
>>> round-robin, or 'rr' for short.
>>
>> I'm fine with round-robin. The [ ] part is not mandatory; if the
>> min_contiguous_read value is not specified, it will default to a
>> predefined value.
>>
>>> The default of sector size is IMHO a wrong value, switching devices so
>>> often will drop the performance just because of the io request overhead.
>>
>>>   From what I rememer values around 200k were reasonable, so either 192k
>>> or 256k should be the default. We may also drop the configurable value
>>> at all and provide a few hard coded sizes like rr-256k, rr-512k, rr-1m,
>>> if not only to drop parsing of user strings.
>>
>> I'm okay with a default value of 256k. For the experimental feature,
>> we can keep it configurable, allowing the opportunity to experiment
>> with other values as well
> 
> Yeah, for experimenting it makes sense to make it flexible, no need to
> patch and reboot the kernel. For final we should settle on some
> reasonable values.
> 
>>>> 5. Tested FIO random read/write and defrag compression workloads with
>>>>      min_contiguous_read set to sector size, 192k, and 256k.
>>>>
>>>>      RAID1 balancing method rotation is better for multi-process workloads
>>>>      such as fio and also single-process workload such as defragmentation.
>>>>
>>>>        $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw --bs=4k \
>>>>           --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
>>>>           --time_based --group_reporting --name=iops-test-job --eta-newline=1
>>>>
>>>>
>>>> |         |            |            | Read I/O count  |
>>>> |         | Read       | Write      | devid1 | devid2 |
>>>> |---------|------------|------------|--------|--------|
>>>> | pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
>>>> | rotation|            |            |        |        |
>>>> |     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
>>>> |   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
>>>> |   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
>>>> |  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
>>>> | devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |
>>>>
>>>>      rotation RAID1 balancing technique performs more than 2x better for
>>>>      single-process defrag.
>>>>
>>>>         $ time -p btrfs filesystem defrag -r -f -c /btrfs
>>>>
>>>>
>>>> |         | Time  | Read I/O Count  |
>>>> |         | Real  | devid1 | devid2 |
>>>> |---------|-------|--------|--------|
>>>> | pid     | 18.00s| 3800   | 0      |
>>>> | rotation|       |        |        |
>>>> |     4096|  8.95s| 1900   | 1901   |
>>>> |   196608|  8.50s| 1881   | 1919   |
>>>> |   262144|  8.80s| 1881   | 1919   |
>>>> | latency | 17.18s| 3800   | 0      |
>>>> | devid:2 | 17.48s| 0      | 3800   |
>>>>
>>>> Rotation keeps all devices active, and for now, the Rotation RAID1
>>>> balancing method is preferable as default. More workload testing is
>>>> needed while the code is EXPERIMENTAL.
>>>
>>> Yeah round-robin will be a good defalt, we only need to verify the chunk
>>> size and then do the switch in the next release.
>>>
>>
>> Yes..
>>
>>>> While Latency is better during the failing/unstable block layer transport.
>>>> As of now these two techniques, are needed to be further independently
>>>> tested with different worloads, and in the long term we should be merge
>>>> these technique to a unified heuristic.
>>>
>>> This sounds like he latency is good for a specific case and maybe a
>>> fallback if the device becomes faulty, but once the layer below becomes
>>> unstable we may need to skip reading from the device. This is also a
>>> different mode of operation than balancing reads.
>>>
>>
>> If the latency on the faulty path is so high that it shouldn't pick that
>> path at all, so it works. However, the round-robin balancing is unaware
>> of dynamic faults on the device path. IMO, a round-robin method that is
>> latency aware (with ~20% variance) would be better.
> 
> We should not mix the faulty device handling mode to the read balancing,
> at least for now. A back off algorithm that checks number of failed io
> requests should precede the balancing.
> 
>>>> Rotation keeps all devices active, and for now, the Rotation RAID1
>>>> balancing method should be the default. More workload testing is needed
>>>> while the code is EXPERIMENTAL.
>>>>
>>>> Latency is smarter with unstable block layer transport.
>>>>
>>>> Both techniques need independent testing across workloads, with the goal of
>>>> eventually merging them into a unified approach? for the long term.
>>>>
>>>> Devid is a hands-on approach, provides manual or user-space script control.
>>>>
>>>> These RAID1 balancing methods are tunable via the sysfs knob.
>>>> The mount -o option and btrfs properties are under consideration.
>>>
>>> To move forward with the feature I think the round robin and preferred
>>> device id can be merged. I'm not sure about the latency but if it's
>>> under experimental we can take it as is and tune later.
>>
>> I hope the experimental feature also means we can change the name of the
>> balancing method at any time. Once we have tested a fair combination of
>> block device types, we'll definitely need a method that can
>> automatically tune based on the device type, which will require adding
>> or dropping balancing methods accordingly.
> 
> Yes we can change the names. The automatic tuning would need some
> feedback that measures the load and tries to improve the throughput,
> this is where we got stuck last time. So for now let's do some
> starightforward policy that on average works better than the current pid
> policy. I hope that tha round-robin-256k can be a good default, but of
> course we need more data for that.

Sending v3 with rotation renamed to round-robin. Code review
appreciated; I'll wait a day.

Thanks, Anand


Return-Path: <linux-btrfs+bounces-14149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591F0ABEA81
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 05:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448FF1B60BC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 03:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384F22DA17;
	Wed, 21 May 2025 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I0OaPlm8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SK5FttbW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB7125D6
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747799570; cv=fail; b=kEXAKPqxL5MwBmXvxL/ezMkIX2/fv6P7Y34Rs8EbHu1Qj38M3yNwY9eUv+1HGt4GzhptbaWX4MSLUtoTAPQElSUe3Db0b4ccNtlgGzEqJWVH1GqWRP3tSTvo/gXSqphtb1+07r8NqIa+kMDXwNhX3h2btgXNfBXq8lRQYj1fQtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747799570; c=relaxed/simple;
	bh=5bHrzNbJ2nVyV3aQ1FV3E9Wy4Tfw1Y4YdgoAobPVa00=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sh2RusJnBDiY1PTPrpAA5+ei/XDbCqVjMEdzH9E/KHKHMd0uRSBP40lwCtc/JBRplO1jhAKZFR0juGdxfgtawrDrviUQjqO4PsDau0s5p9IuaHXq5tKX6hlRS8XfhxRQBdapaL9E6TiXozuX7nlX/PMx5ToILBVhE37Be+t4YY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I0OaPlm8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SK5FttbW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L3XeWh016083;
	Wed, 21 May 2025 03:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ckas/ImvhjhpFotSW751sxk5ZJk/1Kd8SqzjuQywxFk=; b=
	I0OaPlm8g0tpZVqIJsAqXwFvWEbUtCEiP7qEqqaNONAZXOGK5FFtX/ihd/KwK0LW
	MLUMBcH1AeqSqpQc6eVIrqfCX/RLCY1ad/KrDedQZPjdL2lmiU6rv6BjJY5sL4vr
	+It0mf/6IrMvceD0dKyX5iy6L60o0gish0vRXW/+QiyLyhfWn2Dl2pKgIQoo7f3p
	MdwyIo87iMWVcjSQoO/Rj9mfxiSAR+o0oT2TPtwzUWuXioHA0pYHvtngmxTKMkaL
	pLbNqI/Ezx2JeYd4Nr34kD5C+jaS1+W7c3qYXadJcTM+BjEHGjD86NOy6QWW2Ots
	S4vcHD8TbZ5OQZYtJeRTcw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46s698r1mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 03:52:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L2DmTG020217;
	Wed, 21 May 2025 03:52:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwetaxbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 03:52:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lez4l9/VpI6s7BeFQzQfr01ybY9Wx2gBK5RU3E2jMHEBpMnaVS4n3APxn+A943I8FzgDa6fkXKTXypZl/cw9NKyuwPqMackrvUBETWLTwTENhsIvyhe5uBJpNYcYWwA3asLPA2cJVZsne98EHgQCcFZ4RxTg2UHrlwbdjWXGNkVxu+uVry17070MqoK1bhYpg4w9Wo9086YBs5DkxvsO0s/xJD8jeqxbq6M5WqxLCsOaDzJ87dcmOQX9AR2LNyTu4/vPhSLid2GL+7v6R1YcFUYpTadCE8Vb/R4cO0k/Dwzq6UXfu0gDNmRMQrkp60mwZGwR3jWBCrn+rP04I5cphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckas/ImvhjhpFotSW751sxk5ZJk/1Kd8SqzjuQywxFk=;
 b=pZk18VcydYm7hUHfIYQn2yi7P99GMHTl/bQIy2w3PJ1F3RFIaPrjY/uaITgMa+9fiXNNxm5W+2ub/YpK2VXXdkXFi3/gbkYa388dvPyAyvUXmMcVoUpjL/LpErYK1y90bK5QhgsQEqZASnXQv6P4WDEf1szEQVxuvI4dQIPmc/RDJr46zh6TcXXB0aXOO3CcRtfYBlpOW3hTHs2VMVmbeKBPJy3FrJ4MbEfG1DkjnJ6ID80dwGfVzPDpBtU3lpaIriGfedEEV/JaLL45alqlvyPXC3G+6nW9dcuadouwkPdHPvS7TjRsaRsLwcUcnFJ+afTNsU714WgoPRiHM0WXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckas/ImvhjhpFotSW751sxk5ZJk/1Kd8SqzjuQywxFk=;
 b=SK5FttbWqe257tQjRK+M1Yz3IM8S+QXBpJD1Q3qBtzR5YL8AuO1Jj7LyQUnRfLqIz+fpdvXsF/X4nHnasVr2jIRe9lsfzkcpki3FQoKNuIHnb8ugjsPEPjCnlwp31h6cOPdjUHlMkgMOjZLDGXIHpEnpT27Yx8QKD4gG1LpW+Ko=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by LV3PR10MB7819.namprd10.prod.outlook.com (2603:10b6:408:1b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 21 May
 2025 03:52:41 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 03:52:41 +0000
Message-ID: <fbc3c413-c4c9-47c3-9c5f-4fcd7a772e61@oracle.com>
Date: Wed, 21 May 2025 11:52:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: preserve mount-supplied device path
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <85256ecce9bfcf8fc7aa0939126a2c58a26d374e.1747740113.git.anand.jain@oracle.com>
 <da820980-ecc2-41d2-8406-fcde11b0bfb5@gmx.com>
 <74ee4615-09c7-41c9-9197-c83b171f1c74@oracle.com>
 <1d27523e-76ed-4a92-bd79-49643c5272bb@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <1d27523e-76ed-4a92-bd79-49643c5272bb@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|LV3PR10MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e28cff6-2113-46b0-c5ac-08dd981aef9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1VpR0czY3g2N3czUEo1WDZsSEhxeThPK2w2YkZmTGhEOVVUWVpVcjIzSTV3?=
 =?utf-8?B?RHRwVkF1SkMrTWdncU9qZk4xUDNaRTBTNzg3Y09uc0EzZzNjYzhLelpVTFNK?=
 =?utf-8?B?WUQ4dTlwbG5qQm9iL2sweFEwS0hYY1dYdmQrRlg3VmZTOS9qcHljNkpnT2h0?=
 =?utf-8?B?REw3TWgvdTFDZVl4Sy9qSGYzYTNxNnNVNzBWL2w0eUo2cFQ0c2ZVT1VFUDdj?=
 =?utf-8?B?VXV5RFM0bldsNjAxazlPYmtSTzg3emxXWmJpUWY3ZGFpWnozaFdSdXNvc1NM?=
 =?utf-8?B?bmNkZXZpZjdsOGpEK2w0bGNRQ2orNXpoNjhDSGhMYUhacWtSa3BhYUlMYlJI?=
 =?utf-8?B?eDJuQnhoU3N0b3VIdWZGdGZvYlhMdTRMdEJWNDJBL1h5bm9FNEVxYXRuQmln?=
 =?utf-8?B?aUdBTmFSbDZNbFdISkw4SndKb0ZhN2UxQ3NLSGl6OTRkNURzdC95NUdxRldC?=
 =?utf-8?B?OE9TM0R6V1o2Z0xLYktLR1pySDZudVBLME5hSmJGY2RqWlhnbFU3eVNJUFUw?=
 =?utf-8?B?UXUrNTg2YW1TeEpUS0VnMGp4UGpKNklnZmtuY2pra1hiMlBURU9VaEwwQXBT?=
 =?utf-8?B?d2NxNU0zT09aazNRQUtLdm15RVRTQ3A3VldOUWJ2eTdweWNSV0p6SGZzVlhj?=
 =?utf-8?B?T2g4SXVQN2grUjlxbjkwVENtR285VktSR1NRSWE4NjE4ZWVOWDc5VVVzNzlG?=
 =?utf-8?B?dERnWHh1cjRzZ2VhT09ReFBiTFNzbS9GMThrbmRNNDBBcllsZzlxaEswVGJD?=
 =?utf-8?B?SDZMaTg4d2I3cE5QSEloaWFFUzZETzZpbTdoSGp1TjVZWklDbXk4eFVhZUg2?=
 =?utf-8?B?VUh6N1hwMVJHOEdhTGFjTDZETllhRHVETFZFZER1SnVteFlOVlNrek9mRnhr?=
 =?utf-8?B?eEU2UkRaY2J4MDhvQ1MwQS82aHNERkVWY3pnTVVwVHBPbGNyTjREMEtLZzJl?=
 =?utf-8?B?bEwvOEpTNDFWOVl5TGk1RzVLRVBSOXNJaHdoZ1BackIxZmhiWmJJbk5EcG5t?=
 =?utf-8?B?M0FrcUwvNFkxZWV3SlJNVklieHExMWg4NjZ1TWp2VjR3QTVYMHo1c3NzN2N0?=
 =?utf-8?B?bjkvbHJ4QWE0YzI1cDRJVmovczJSeHpjU1ErMXptRDNiREJxMGJJMzlBVXJw?=
 =?utf-8?B?MFIwNVdDZ1FYTzk5cHJQMlZzQ1owb2ZIMmxJNzZkZURYTk8ycnBkKzJJejFy?=
 =?utf-8?B?ZFdlS1duaHNrc0R2cFdncHJWWXZIY0gyK0d3SnJxVGVPb3ltMUNJWndwWTBh?=
 =?utf-8?B?VHMvdUFVc05mYjRXYTA3YkhHZVlqaW4rbGdXN0ZOZTUreEJLQ0J5THUvVXlY?=
 =?utf-8?B?TkNORTA0ZlY4R3dmcHViTmlNVFZoM3ltdko2aXZEMloxV21ITWRZVS94UGQ4?=
 =?utf-8?B?OGF3STl3TXVXMkZXRWVCallmNm03dGMyc2V6TUtxYlBUSi9HRnNCbTR2NUdj?=
 =?utf-8?B?dmMvUDJGVlR2MWhTUzJqVXRHc0t0OXRyQnprQ2J1YkZOL3o1VmlGeGZhZFkr?=
 =?utf-8?B?NzZnSDhxb095M05VVW1PTW9JMVNta0VEejZlZS9MTkNwSHJxUHdiRVZlai9R?=
 =?utf-8?B?VnpmRGZ0dWpwcGp2T1NFbTVTbmFiV1c5c3pmWXkvNTdQQjJ4cmkxMjU2ZWk4?=
 =?utf-8?B?U3U1Yzd0eGI4dkhoOTlRMncyQUZwV2w1OXBYK05Ka0V2UUluSG00Y1FaR0ZO?=
 =?utf-8?B?WVhiajZ0Q28xOWw4U0JYbHZEQU45QTFlZjhZVjhaR0Q0ZUk2ZmVnc0d6aTBk?=
 =?utf-8?B?dEYrRjlSbVdmWkVLYy9BS3NLVkZVYy9sRjNRVVJ6Y1NvUGQ1Ky9JbENVMnJu?=
 =?utf-8?B?L1ZaYmFsaUQ2SXp6RTM3YmNNUnRXRzBJS3VUaytUWlJaSXc4SnFFeFRUbVh6?=
 =?utf-8?B?dm1YNUtMOWFjNjd6dWpMNmd6TzhWc1FQazBiSmpHaXIyMWpKWmVmcklhRDll?=
 =?utf-8?Q?6mNq45LRkCE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0RhVXMrOG5mUm14a1RWT3FLbTBmWVFIRTFpd0dkMFFkUjBpcjYvMGlCM2x1?=
 =?utf-8?B?Z3dhaGZ2VjdWbDNKZS8weVM5bGtid0NnUWs3MWYyTkNDTHVMdXcwd2lxazVq?=
 =?utf-8?B?bzVNUW5EaXRKYW96c0VzdmJDczYvSm9FTThab1NxR08yM29DeUFkT2xjcWM3?=
 =?utf-8?B?MEoxVWxDVGVtcXRaSGVUN21SNkk0cm84ekpKUVNqUldmUnJOODBiNTVFbjBT?=
 =?utf-8?B?bUNWMU91MHMxWFVXSW8wUDZTbGtjNFJnMDg3VlNWL2xjSTlCSDMzZlpjd1d6?=
 =?utf-8?B?Qksyc09KdnpiYWw2TnFYejlGZW9LNTBQci9USldER09TZXpOajBVVFVmQjlz?=
 =?utf-8?B?K1JCV0h2L0hZcFJlaHpySTAxUjNWSHVsZ0NxNEp3U1MyUnZtbTdDWC9LUGRl?=
 =?utf-8?B?NWNhSFVqcEN6UkVUZ1hLNXNoVnl5clB2eGJ1MGo5SGNpcVZMZmM2bllndlBR?=
 =?utf-8?B?RXh5aWJScGp5eEVBQzVyTFk5ZlBBeTBuL1NPNHNDSlNzdzRFTEpzbmVCVWtj?=
 =?utf-8?B?SFdzV3VndDZXK0g1QTVaNjU2b2hVRGZSeHRtSUNUYVVGT1NDTWwrdnNpRVZF?=
 =?utf-8?B?OEJPbVNtV2tpaDEyK1JmdTI5MVpiMnRyekJzbmlVRkc1UDdxWmtZSUdzN2g2?=
 =?utf-8?B?NUlDSXpKVlZsMHNyYjBadm41c0FZWWUzTFp0ejhmemlneTlwS2x3bWFrcWZK?=
 =?utf-8?B?d0NqWVNTOWdzZStCTmRVT3NoQTZRekNGb3d0U0RqMkxlMm9KRGtucmZKOEFP?=
 =?utf-8?B?b2FkZm93cit0emk0ZDJCNTVPOXY1QWh3S1FjcVFlMXdrR1J1VkRZbTgzcktC?=
 =?utf-8?B?Y0NOOUdVcmRaai9DRGhHYkNRT3ExcUVkVTBmbWp1dHdOejF5SkJDVmwvRk1m?=
 =?utf-8?B?dUpVemRob1JObFZvU1ErLzh3c3p4Y2pvd0MrR2svWXBsUkEwUGpkSnpmMjFu?=
 =?utf-8?B?T01jV2hUREhIeXppdHordFdtWVdTOEdGazRNV0ljcmlPRkRNVDRkckFOMXph?=
 =?utf-8?B?TkFVbC9OdEYvd2x4cmxBeU1VeTdqaWF1ZDB0UnNEdW9JSnY4L3YvK3VYR01t?=
 =?utf-8?B?QU44M1RIOVN4a2JqN2psdXc1eUFubWhlWmI3UHZFVnlkdDFMRk92Q3puUlg2?=
 =?utf-8?B?TXlTbW5jS0ZDVXdsd0RZUFFLd0c4VVFXeGRSeXZyRzZ3aTFQMll1eG85Q0g0?=
 =?utf-8?B?UGpBc1kwM1dKM3d4NUp2N1B1dE9Ick1mYjRNekphdmx1SDNlajNjV29ZKzJF?=
 =?utf-8?B?ekl1MHVNMDhqT3VSOUljci9lTDcxSDAvMHNxdzNWQ2phcWRTR21ucm1NWVpy?=
 =?utf-8?B?djM4UVJ4UlpNaUF6eE9PZTZLbnlPMFU4YTg0NCtVczJpaWdZL0JhejdOTnRu?=
 =?utf-8?B?Z3hacUlKOFRoVzJ0VlhGVFA0T080a2lXQm4wN1E3b2JqN2RRSnZxZFduUDY3?=
 =?utf-8?B?WmpHYWlVM1U1ZUQxOURzeEFidDlOUElyN0NHUFNzeGlCVWZvcEppM0RjNjIz?=
 =?utf-8?B?Z1E3U3JVVFhqcVA1cUx2NDI5eVNISHQ3WTluMDNHSW9Ua0E2WWVvOVBmcVRU?=
 =?utf-8?B?RkZiNlNibjZUc0J4VzJWQzcyRmtVaDN3cVFtQTJ3YjNtZWVyWGVPWktzRVZX?=
 =?utf-8?B?TXF4N0k4NUZHdzltUE03Q1BlQTg1bEtveGZYS2RvSWdzaUk2bnR6VU85OW01?=
 =?utf-8?B?SS8wbVhicTBySWlkdUtCK29lVkFBZWVMWHlucmd1Zm9BMTMvQmdRLy9GUGd0?=
 =?utf-8?B?VW4rcVMyamJha3kvL3N5cVI2bWwzcDVheUFkc0VhTWhYYlVXN3hhZGllOHQz?=
 =?utf-8?B?UmY3QjFNc2tqZkdreWE2RDZBdWprdFBKcnZ0UVVBaThOY3I4KzFhSVQrS2p1?=
 =?utf-8?B?NmFYdFVlczVkaVdWWDlQSTZLT3dDazhMSXcybFFMbmNzL2FTYVB4ekpxNFRo?=
 =?utf-8?B?aXNGYk4rRGxKQkQvQ2tQNTNLRDhGeFRtV3d3WlEwL3BaMC9FeHMyeWQ5aTVq?=
 =?utf-8?B?TExKUnUxbXY0bGtwVVUrSVV1SVhzK0JrVVloNExkaS9JNy9ZWXlhbGxDRUYr?=
 =?utf-8?B?aUZ3ZkJLeUE5MVpYb3lNUXRxZ3RjL3N5L1dlaWJ4eUpaNS9GcGVwRmxqRG5l?=
 =?utf-8?Q?llK/OjrTH014CMYCIb7VM1tqK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XKg+6v638f8INoZohUF8JFQkKSCZzLLK0NOpZm3gEh+A3w/c7cRwSZXa26x3HHzQoC+aD0qi0WWISwDwb6kLjvvg1DbBfmW97Ict1N1/ohbzK0u7x4r8upnvZoVshyBG91HbtxesToj5fukIt4rja3F6ARkUoAmfeqElixqcKcLLVPizfSLTUr8+qLKzZwITx8XlVqZiD+Wbzu885MeXXEEqK9SbcIDtuiyxLVTHQrxmkycWVP1zouXvGOWsxmriFTbeC2CvqBvmj9XY1yG961BUPdZx+R+XhhT/I7EtAP7IzI5CrUaw0+FSZ9QYb4vZ78s+IjSQCFm62CbrEuZSvPxeAIESqUFsNV6728k5CXR0AwaTlMLpwbi893WMM9olcUU/ypbgUiHtFkqotOSjSGbgMJsNrfjmcnJeVcyxn/GIk8sw6sDB6hoie8iGYxiP/eLmzsiFJwq9JnwDVqHEinMESsbzsEFdP6xhAnSRj3uwQsHeKfpVKkKfID5q8W1RM7S/4ytifkkcfHCZxmHiREMqVCnsjRNJYbW/ICU/F4PGu8Z8aT0BH287AfvKGtabGjFkBaTnF4C8GzVHonWZt59N4+FjPNdY91wBzSvLbFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e28cff6-2113-46b0-c5ac-08dd981aef9c
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 03:52:41.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1M3syOaEmPjoJVYKa/1Pq65zo4dDYlOERZQ54dkFWOMpWh5vt+/gIsiN9UkFjkmVqIwnNKBqSRC9GIkBxwjaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210034
X-Proofpoint-ORIG-GUID: w9pAe40njfdU3_fdAJCOz6LmE-Lijo-v
X-Authority-Analysis: v=2.4 cv=LaM86ifi c=1 sm=1 tr=0 ts=682d4e0c b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CtTMZBxKY_97-C-zRF4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAzNCBTYWx0ZWRfX2MAsXSH8Dc9T +Vik5kj+B81KCPCZCsNBKG0mgxA23xnh12uxyJOcoZRiLGz/AOJK/vE8YtqWBJkGXSRltd0cp+F BMeklgSfUDVvkUa3/jCGX5GYqiCM1pxwWwn4UC4edE7R8CAZqi2SJ6XXZvUfwn2ZHIMC+3ne+eF
 j5mbKu1zyjuea82c+TKm5uCTht+kMMqkF3kT5CYZWaCApXFB48PdJ58NipFgRC2nBnRsmef1ZFj /bsF03rpotibD+VeZilltO4T4NmkpW61V67DKATXmlYrRvm4abtyVDcPr5o+WwtkoepL5QLjtYy 6TNG9v6n+4ZAfzw8qz87jXNvL4ZQ4tiBOgtr9GE1kkR9dZQLQc8rcAGBfYaCPGIYlBhorVhUV+W
 SjvnkV4VdHGV0QZykL+PrGwf2BPDC2Bnv+MGrd6FuLNusKbZCGI52y91/7TvnUqo49E0oc6L
X-Proofpoint-GUID: w9pAe40njfdU3_fdAJCOz6LmE-Lijo-v



On 21/5/25 11:32, Qu Wenruo wrote:
> 
> 
> 在 2025/5/21 12:44, Anand Jain 写道:
>>
>>
>> On 21/5/25 06:25, Qu Wenruo wrote:
>>>
>>>
>>> 在 2025/5/20 20:53, Anand Jain 写道:
>>>> Commit 2e8b6bc0ab41 ("btrfs: avoid unnecessary device path update 
>>>> for the
>>>> same device") addresses the bug in its commit log shown below:
>>>>
>>>>    BTRFS info: devid 1 device path /dev/mapper/cr_root changed to / 
>>>> dev/dm-0 scanned by (udev-worker) (14476)
>>>>    BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/mapper/ 
>>>> cr_root scanned by (udev-worker) (14476)
>>>>    BTRFS info: devid 1 device path /dev/mapper/cr_root changed to / 
>>>> proc/self/fd/3 scanned by (true) (14475)
>>>>
>>>> Here, the device path keeps changing — from `/dev/mapper/cr_root` to
>>>> `/dev/dm-0`, back to `/dev/mapper/cr_root`, and finally to `/proc/ 
>>>> self/fd/3`.
>>>>
>>>> While the patch prevents these unnecessary device path changes, it also
>>>> blocks the mount thread from passing the correct device path. Normally,
>>>> when you pass a DM device to `mount`, it resolves to the mapper path
>>>> before being sent to the kernel.
>>>>
>>>>    For example:
>>>>      mount --verbose -o device=/dev/dm-1 /dev/dm-0 /mnt/scratch
>>>>      mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.
>>>
>>> So what is the problem here?
>>>
>>> No matter if it's dm-1/dm-0, or mapper path, btrfs shouldn't need to 
>>> bother.
>>>
>>> I guess you're again trying to address the libblkid bug in kernel.
>>>
>>>>
>>>> Although the patch in the mailing list (`btrfs-progs: mkfs: use
>>>> path_canonicalize for input device`) fixes the specific mkfs trigger,
>>>> we still need a kernel-side fix. As BTRFS_IOC_SCAN_DEV is an KAPI
>>>> other unknown tools using it may still update the device path. So the
>>>> mount-supplied path should be allowed to update the internal path,
>>>> when appropriate.
>>> This doesn't look good to me.
>>>
>>> The path resolve is util-linux specific, and remember there are other 
>>> projects implementing "mount", like busybox.
>>> Are you going to check every "mount" implementation and handle their 
>>> quirks?
>>>
>>>  From the past path canonicalization we learnt you will never win a 
>>> mouse cat game.
>>>
>>>
>>> Again, if it's a bug in libblk, try to fix it.
>>>
>>
>> ext4 and xfs don’t hit this because they use the mount thread’s device
>> path—we don’t.
>>
>> Sure, libblkid could be smarter understanding that /dev/dm-0 vs /dev/
>> mapper/test-scratch1 are same, but that’s separate.
> 
> Why separate? Without the libblkid bug I bet you won't even bother 
> submitting such a patch.
> 
>> Between mount and unmount, we should just stick to the path from mount
>> so everything stays in sync. As these tools including mount use
>> libblkid.
>>
>> Or please look at this like this-
>>
>> The Btrfs kernel needs a device path to display, which comes from
>> either:
>>
>> Threads BTRFS_IOC_SCAN_DEV (only Btrfs specific),
>>    or
>> Threads going through open_ctree() (usually mount-related, system
>> specific)
>>
>> This patch makes sure the path from the mount thread (open_ctree()),
>> are  preserved because that's system wide common to ext4 and xfs,
>> BTRFS_IOC_SCAN_DEV is specific to btrfs.
> 
> Then btrfs will never update the device path, even if got disappeared.
> 
>>
>> Why now?
>>
>> Commit 2e8b6bc0ab41 blocked the mount thread from updating the device
>> path, which it used to do. That’s now leading to incorrect paths being
>> shown—often from BTRFS_IOC_SCAN_DEV (mkfs)
> 
> Define the "incorrect" part.
> 
> There is no incorrect path here, it's all the same block device, just 
> different soft links.
> 
> Remember the device can disappear and multi-device btrfs must be able to 
> handle that.
> 
> But different soft links? No, we should not bother that.
> 
>>
>> What was that commit fixing?
>>
>> It was suppressing noisy path flips caused by Btrfs’s udev rule on a 
>> mounted btrfs filesystem.
>>
>> ENV{DM_NAME}=="?*", RUN{builtin}+="btrfs ready /dev/mapper/$env{DM_NAME}"
>>
>> That rule switches paths like this:
>>
>> /dev/mapper/test-scratch1 → /dev/dm-4 → /dev/mapper/test-scratch1
>>
>> With this patch we will still block such flips.
>>
>> So this patch restores expected behavior by preferring the mount
>> thread’s device path.
>>
>> In fact:
>>
>> Fixes:
>> 2e8b6bc0ab41 ("btrfs: avoid unnecessary device path update for the 
>> same device")
> 
> That's not the how fixes tag should be used.
> 
> Let me be clear again, you're working around a bug in libblkid, which is 
> not the correct way to go.
> 


No, it’s not. The point is that each individual software component has
to do the right thing so that it inter-operates well. Think about why
this problem doesn’t exist in ext4 and XFS — you’ll get the answer.


-Anand



>>
>> Thanks, Anand
>>
>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>>   fs/btrfs/volumes.c | 7 ++++---
>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 89835071cfea..37f7e0367977 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -778,7 +778,7 @@ static bool is_same_device(struct btrfs_device 
>>>> *device, const char *new_path)
>>>>    */
>>>>   static noinline struct btrfs_device *device_list_add(const char 
>>>> *path,
>>>>                  struct btrfs_super_block *disk_super,
>>>> -               bool *new_device_added)
>>>> +               bool *new_device_added, bool mounting)
>>>>   {
>>>>       struct btrfs_device *device;
>>>>       struct btrfs_fs_devices *fs_devices = NULL;
>>>> @@ -889,7 +889,7 @@ static noinline struct btrfs_device 
>>>> *device_list_add(const char *path,
>>>>                   MAJOR(path_devt), MINOR(path_devt),
>>>>                   current->comm, task_pid_nr(current));
>>>> -    } else if (!device->name || !is_same_device(device, path)) {
>>>> +    } else if (!device->name || mounting || !is_same_device(device, 
>>>> path)) {
>>>>           /*
>>>>            * When FS is already mounted.
>>>>            * 1. If you are here and if the device->name is NULL that
>>>> @@ -1482,7 +1482,8 @@ struct btrfs_device 
>>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>>           goto free_disk_super;
>>>>       }
>>>> -    device = device_list_add(path, disk_super, &new_device_added);
>>>> +    device = device_list_add(path, disk_super, &new_device_added,
>>>> +                 mount_arg_dev);
>>>>       if (!IS_ERR(device) && new_device_added)
>>>>           btrfs_free_stale_devices(device->devt, device);
>>>
>>
> 



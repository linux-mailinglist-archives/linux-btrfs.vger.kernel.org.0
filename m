Return-Path: <linux-btrfs+bounces-3164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE03F8779B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 03:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 638F6B21379
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 02:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67C3C0D;
	Mon, 11 Mar 2024 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jguqv3oG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l9W3fzTY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDFC2564
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710122477; cv=fail; b=adMT+TtidAVb6U0CSqp3LfTBWVOcHJvMl/otVMT2+tYyROnlL8y/PxmneyaVDms1VPwMS1Gx22UO7aXWC830HLqXFMZFo79Lk9smRPKWlYgP1Z+AKLvW/VN84Eb35GGZPq2AZ8lZDqRnQQgKpFQkjITQxLfRqFFwiHmrGoGM7t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710122477; c=relaxed/simple;
	bh=Yfz70nng4JvshBX4VLGab36PilIsCdDUSl4geozUCZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R1bHmGFmaf6ikPopgwtvKVrhxNmxT7d/IfOQ969A2gNYq4I0F/LvNAsgzMyrbsugPC6ycICYc99lI63B6WHxo1L+27wJnjQVVN2TUQMp+Fz1cARtGR4dMbOe5+gNC2stTyKTLLe909n6NqJbdkng9BSraGqk/6EvaAlY9/RXqiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jguqv3oG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l9W3fzTY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ANlZwl029678;
	Mon, 11 Mar 2024 02:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/wNnjMzDXDcgT4dEXMbk7Qse3wBX4oeKLmXswQz/oIc=;
 b=jguqv3oGuj2UC7rYDbM9A0oN1tQtNSVRpVLlBJRhu+55XRHZSepCjlMV3NmybSdx7AAU
 Wh0n69UCSSSg9nHM2jdSW4221iwI+4VlzjQlCe0W2UxVsDL4BS3LRnHXtDoQYXajmVwO
 BEFV4IUq08Zk2r5dkVXeM86vTR+pJfIAd1D9cP1UJGTm9ZGp4URXSqaJP/go12zaLfFI
 6aF9e2gvSidHyHFkDcAycKoem0a6rizlschmTouKK3r8CakdX2YMZ5pIplByzKF9E+HZ
 rhZIipBmY2X2prr6Q+ttzKGizt30DLTTxAGG/CdTac9GJpCfL/yFSfE8Q4lG/FadTP+9 vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej3t6bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 02:00:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AMm7tv006319;
	Mon, 11 Mar 2024 02:00:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75568a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 02:00:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/+T+MW5gYap51p7wRS8xDoxTiOvlFtQ1YyPp++R4ocZmzRGLYMe8OAGCOoDTcpuEAlLV4d7tkMDgWUqHUUJFfhdeBMSoSQOOt9Y89xPOyqC9BYJYGIjVcKc2Z8FolK/nb8Cbx72U4PjB+Gv/DIv2RGl5Dk5i5oS/O2Z8ue5J6L00iMmeSMwWDnYdlNR4V7NGoYvAJD2ByoA0PzaorTT4TrI2CO0aG33yL2avoBfcp++6GCdqXDoAM22qrnVnkhfbXiG3fbHBsBT+ZxULupvR+UD5fy1xSwFCH44xF2gSAakcR3SLtU1ksdz3JeuZkDzs23iI1yxY9dx/CZ2bk0MWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wNnjMzDXDcgT4dEXMbk7Qse3wBX4oeKLmXswQz/oIc=;
 b=iwkndECVKwIB+u1ZykwnzZoTeB5ztxHmwhf3XlzHjEGZc+O7Q8+xjsnxtx14fO7+W8NLHCo5z+OmFMOqWin2ZE/uGo8c2yB9BtL4ARFiVJmCDYb7pf39z38tGIsNkpfUa6y9dRwhJDjr3TU8MSEPHlZamkId8e11L2WtHlU6Hz0Enj1xCuhhggg7BXlQ0NuG5p8Yx9va25dN6kLDMeGtIt60R8rW6+kZcjn/9uHV/CPwm4UbBm3hoNBlYlQgMU4tePbr/z0g3FuPIasQm8K30mPwk8Hisju0/i/ZHxZnaQxGQj8LYStLHO8gjQaiKJoMI9DFxwS2zEkJl0jrCuoF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wNnjMzDXDcgT4dEXMbk7Qse3wBX4oeKLmXswQz/oIc=;
 b=l9W3fzTY1deFPDKeIE5NxojbWZlNWsXRLP9KGqQhK4H9M3413tVxuCFR7HgcIkVuS6UeBiZzI7Me7SbqIr66qsnUEMdOui2Z6DHA9yAGfsZTLuy6LhNGcyA/B/sFyEJ8FQ0Zi8zLBPDMbNhCkSRer4ulIlqIyX4tTSGTHZa7hTQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6152.namprd10.prod.outlook.com (2603:10b6:8:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Mon, 11 Mar
 2024 02:00:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 02:00:48 +0000
Message-ID: <f3ce3916-1e8e-485e-bae0-ff0f190da11e@oracle.com>
Date: Mon, 11 Mar 2024 07:30:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
To: David Sterba <dsterba@suse.com>
Cc: CHECK_1234543212345@protonmail.com, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@kernel.org>, aromosan@gmail.com
References: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
 <82b85e61-2f85-4d01-afa3-003f74380573@oracle.com>
 <CAL3q7H7WpEOBx_66uyzrOH_Lr+Y1j5Gg0gViqGCLQg0vmg9G0A@mail.gmail.com>
 <03bcd60e-33a7-4bc9-b048-8ae8de6ab9aa@oracle.com>
 <CAL3q7H6g_D-UJKkudx99NnCiQxj1J8KsME+smCDcQ62ddFA6Pw@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H6g_D-UJKkudx99NnCiQxj1J8KsME+smCDcQ62ddFA6Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a750250-3ccb-4347-57d9-08dc416f124b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9PG13WwYfm+kd8ceY9B9ycoIiN7kEsER57ZP6r52pLZvCRnjM91A6HgvrSGymlrSYAeXbxmOq/cxquJpZ6ZfGodOAafVhLUwXgE8FFSVzzCmzt2a0frtHgzkpzhEeSTYIu9q+foKiKfOydx3NqzulLLhBVmtYPw/ftHM7ubxQo1iRpL22rNgczqbiJgFIco/NeOwWATy/hosxxiVCuED/bPf8bwPMAoflG0k4URd+IgPdNAPKt4M9xSPLzrWP1pzAVON9GDj4oJ5sRnLGgBC5KH76dxT/lmBY/jvzyyD++MIiM5Zm9QkdVjLyAitiUUhuTPzg+bmsPCMoNEklwnxcg1mPj8HLfnDcWl52hMuyJAaeEu1lUe2gGeCY7loilRj4FMg1D4jFZE0GndykIeO6f/68kP5FFNLxg1H7klm9fYgIV8lhbqk30B/7LpzGdkbAZo9JQn1ha1fGcK2MFDD+TO7Y61D7Up4b+kTS8ywHqeROJNpJHpYA0nBDCl90zf1XgWeWnvGZRqk8GaLpposdOTwZHV+gXkxZnEuziVqvYBfVWy0fFEc7RSBXrS0HunF1tCC2hVIReB6eODCXnJPiEA4pBmDbSajbs07Chj8T3VUvjase7ArgbGX6R6PhZMIBOWgGBX2Dcf9EfGSxKjOA40oxQhUi4mu4eKFX/Xnj5A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QU1nTG9xZUlJTmJIdjhBL2phSko1OUVIODlINEliWFNoL1lVdkNZZWZxNzIz?=
 =?utf-8?B?ZTBuQzV5L3M1SXQ0VWsxdzVQNVdyOUppQVJqTFRsc1B2QUdncUIvNGl2Y25Q?=
 =?utf-8?B?MlB4QjlUNEs1ZGVHNSs5NFdLTW0rL3hsV3BaclZrUmwrNUd1b2Z0aXpVSDNP?=
 =?utf-8?B?Mzk2bUFMODZ0ancySVl4aWVTb2YvYkJ5SjlqbkEremZnbCtGZmlJRU1LU0hu?=
 =?utf-8?B?N1BFK3JkUGRpSkhaSHFRQjQ4UTlNYWpxamhUdk5WazJWQVYwMkFRV0kzRW9W?=
 =?utf-8?B?VUhNZU5vUlFmNURTcEhkSDJwbnRkZW1aNDJ3Y0ZBTnZpN24yckMyRk5RMGU0?=
 =?utf-8?B?disxWTJpaWFpeTdsK3g4VE95Nnl5bFNjUlBLc1hjUFJjNUg5a2NOalpJVkc4?=
 =?utf-8?B?TjBkQXgrTitBUEE3Rnl6dGMwcnZPV05rMS9Sd0M1L2Y2Ym14YWEzaU5QM0NV?=
 =?utf-8?B?SnlRSzhqY3hFSGErMVppYkRmd0lCMUR3bUk1cjk4Sm9PL0Rjb0t2RUJmdUZK?=
 =?utf-8?B?MEJ2aHR1YnJMeThhU0tORXdpZ1JsNjlJQVdyWE1BOXFXWU9JYXEyWWdxYTRO?=
 =?utf-8?B?YWIzRVVMWFQyc1dPcE9LSVFzUDRrakNIZ290MWsxbFR6RHAxc3N3WE1IY1Fj?=
 =?utf-8?B?SFJMYzhtd3F4OG1PMGlMZUlwVmg1aHFCSTh2L1VydmtHclZPMnFPUlFNUUxi?=
 =?utf-8?B?anNDdk9ZRnZjWGtvMVZ1a0UzOUR4c04ydDl3NXdocWJnWVZRSjhsNi9FK1ZJ?=
 =?utf-8?B?WFZ0WDdiNHhvaWR3bzJqcFFsY0RIODJ5dC9uRXhTK0E3VVhucHBEL2tPV3pM?=
 =?utf-8?B?OEZIYXhqbHB6TDFTanhzVUY3NnNxQTFQT1YvMTJJV2wvMUkzdDJTWmRKUUJ6?=
 =?utf-8?B?Nnp5ZWNhRFFDVEFYUUpoWHI1bkR3S1ZucEQraXNjNk5sdFd0Ni9QaTBZQmpm?=
 =?utf-8?B?UW44UDF6eGJrNVBjSFRJSEtJNnk0bUVuUGRTcXJJMXgrSG5iSWEyd2pnaHNK?=
 =?utf-8?B?Tzh1STZvTTFSMG91OFo4dXVCUnIwTjVaVEVKalYzN3lhZmM1OFBMSDRGOW9W?=
 =?utf-8?B?YW40SXNPbmptdFRRU3JhdG5kekpqVC9wNHNUbEFoeDJzMWZ1c2VJQWMrZGhx?=
 =?utf-8?B?WkRMcGRuaml3cFVpU0oxdGU5bzZILzVkbGVNdjdjMVZVS0JLQzF5Y1VzR1ky?=
 =?utf-8?B?bkxGRG9sOXF5RkJRd1VTMVRlOHhhSGxsTWtlVDBKL1dTYTZQUy9waW5vWDEy?=
 =?utf-8?B?aytsQWpGTnRtS3B4V0QvMWZaM1pNcHFYZmNJOXRSNWVBNXAxWDkrRGFuSGMy?=
 =?utf-8?B?Q3RSUFI1Lzd6Q1ZWNXFKNm0yaVhrdFFERER6ZVBiK0VoVXd3VkZWWHdKRFQ2?=
 =?utf-8?B?Z1ZUZWdFK2l4bHdKanYzRi9HcGFmdG9VaThjMVZBcG9GMWkybm1PSlhiaTFI?=
 =?utf-8?B?WGVvbjhhNlNXWjJ5V3M0OVp6L2QrQVdJNTRUSUZPSGhZWCs4VG8xV0FmVCtD?=
 =?utf-8?B?Y2l1YmtIOFRjZ1I0MGZ0TTRraTRVWmpKTmMzU1VGQXltY3Jra0N0Y2M1c3p0?=
 =?utf-8?B?R2NSRlBoZXBVcVJPc0k4Ni9oYXZvR1RCZWZYNGhrSFRyZkd1U2U2c0hocjJG?=
 =?utf-8?B?Z0pTaEJ3V1E3eUVmaWZYOUYxMkwrMm15dlIwUGNQWlNkR1Z4WEhTaVV2dkw2?=
 =?utf-8?B?alFYUUJDcmpVYWFOY1dmMVVZeFdQcUtlQm92ZEptRzZVMzlib3JYenQwUVk5?=
 =?utf-8?B?RHUrRXkwcldURXZrbVNzMGtPK1gwcTJwR0I4RXBDOTFhVDZ5cGU4RU1TQXlW?=
 =?utf-8?B?bFpkTHVxMXpBRzZaUlFGQUpDaXM1MllIMDBmY3kzRkRudm1LUE1jZi9kbW5j?=
 =?utf-8?B?cHJxKzhtbDUrYjhQZ215M1lRNWFWR3l4YldjeXVjcEl4QzRxWmtzS2ZPdmdI?=
 =?utf-8?B?ZFRHTCtDSHY2SlcxUjhHeVdRUzFaclJZMVVJdy9UZDhHdDRaL1RtQm9Jenhm?=
 =?utf-8?B?YzFYY1oyNGkrQU1kVHBQTEFrWWI0aGJiUFlLWFpMdXhidklpTUw1bVVBNUVV?=
 =?utf-8?B?T1drYnhSS25OdFBKcEVObDZna09kclNua1hsZjFYL3FMRnlOcFZKVDBqMU1G?=
 =?utf-8?B?NHdLVzdRUmlsd1hEckN5SzQ1aXhqY0pqOU54V1A2SnkvSWxBL1pneTZHYkUx?=
 =?utf-8?Q?4ynEa2dYHhpWeRzbNROZ9KHjcagnLLYxZwmNLiYHL/9f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oa14emQHAobOZd3edDXxxas9ROVEW5eSzqObCq3E8QL4AyXe6wbpXpUzA0sLjtBnx3fWMHNLSjOL/Tj8WcXS6x/xi9YX2C2Z+HGFT6jtdZeqvReW64L6WSBxybDjq+B9p9CsAUksAFyLOcRGTNgJ8FYw1uSxaPLZ4akDvl3WYm2HZ83pVxV/i3yq/bCcxuedwKTz3tCtD5iCKQP79DzJXTmJs+iaIbezfQsvgY54QLMN24e5oRM/SZF6ogFjVEqY0qNk9Jk/6IZz4s0OH7C3lyHzbjUElihWLpG36J3TAecsLqjQX+AEee5v4d912o69JCS+ScDdeKgXNYquHkKaxi77qxpyE2Z6HzuysH2DyTpRJLvQhwvO8uhic2FXjDGb2PPvcG/bFuXQbK6QGu4gAg9p6h43z/54VH24IIa/fjaZuFKqG/6H3wkokJ5/dIxGh24EHOkIA7QDFxH5eWiq9biz/99Sx59+fyHqEQ8VhDKd27o1u4B7ulaNxHV2o8GYE8bxuXJZENKugflLcs55PxGR/AX3sXsR2aRAgMA7wzxWchHsvcEZ26RgjZem0rrfJYXP62WaLSsTv7jnt5qErAdkesVmR9OMU2rvyeE4Awk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a750250-3ccb-4347-57d9-08dc416f124b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 02:00:48.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6t7MNf36E6O17QTwrlXUxt5Bv73HtJq1VqsQnc5joJ7DVOgJKWjYTlUYJL1KkzlNJZwEFsZefqeObenBrvgFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_16,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=834
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110014
X-Proofpoint-GUID: w_DZRZ06_R4NeL_CwMWOt_cU5i5BOYzH
X-Proofpoint-ORIG-GUID: w_DZRZ06_R4NeL_CwMWOt_cU5i5BOYzH



>> v4 is the latest version of this patch, which is based on the mainline
>> master. As you reported that you were able to make btrfs/159 fail with
>> this patch at v2, v4 of this patch theoretically fixes the bug you
>> reported. So, I wanted to know if you are still able to reproduce
>> the bug with v4?
> 
> No, running all fstests doesn't trigger the bug with v4.


Thanks for confirming.

>>

<snap>

>>>> David,
>>>>
>>>> If everything is good with v4, would you like v5 with the RFC
>>>> removed and "CC: stable@vger.kernel.org # 6.7+" added? Or if
>>>> it could be done during integration? I'm fine either way.

In your 'for-next' branch, please apply this patch before the
patch below to avoid a conflict.

   btrfs: include device major and minor numbers in the device scan notice

I didn't base this v4 patch on top of 'for-next' so that it
applies without conflict on the 6.7 stable.

To further fix the conflict in your 'for-next' with the above patch,
just remove the line changes for the function 'btrfs_scan_one_device()'
as this patch already takes care of it.

Lastly, pls add
    CC: stable@vger.kernel.org # 6.7+

I'm avoiding v5 to prevent further confusion. I hope this is better
this way.

Thanks, Anand


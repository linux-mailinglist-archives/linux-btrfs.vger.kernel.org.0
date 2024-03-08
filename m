Return-Path: <linux-btrfs+bounces-3109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0878887679D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 16:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5BF1C218D9
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536421104;
	Fri,  8 Mar 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KVGwscaq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DD3Czuht"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17FF366
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912942; cv=fail; b=DcxGvtpeBlf3/XG2CaFmV3rxQI2SlIEQYb5gxyMeycucSG/bD+kzL1o/pdNjdSUO0w5W5/aEq19T7thO9exBWDpurjGlnmwDqKwB/ZUl5ZLg/CZ/8cLWDgHB5NLS57S9CoqTNh4p27ufv6i3ZpTL4flwd3sebcMQ1ljpyb6lxu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912942; c=relaxed/simple;
	bh=FNpQqBS3cB9frn+73N7SmXZGaGzHWVTsmHX3U93h+PQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C6OQWYjBh56IWMovlooA6T8A+qt/6SvR5XKVdqtgl1jY9O2OYC7dyVXbKGEjmnplRBQtqg77jG2fDXwXfBFj+f730kq/8epHx2sq3H87tEMv5UGOFKxQmlGIDUf9ou4pj50xM+Rvt/ibK7QmRY++wUrq8Sucy0pmI5zafviA1x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KVGwscaq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DD3Czuht; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DThIi005334;
	Fri, 8 Mar 2024 15:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zaXlQPxmSvN/Lm+chK5IrOuahVSv25XcKAkjQx5vSz8=;
 b=KVGwscaqrhCwPfbL7Wk6QziCMcI9bE1iKuFFbskkQ/dubq0cFNh+c5Es5E9hrWha0C9d
 NpVY6CXTaPlMmH84PXXyBWqY00oUmkrZTKiGPl++luZDwww7jq9ssID94+KlHDdAFLMd
 8OEah+xH5F7BdHbqLOHuH7k1aqqe/SBJzGXDvong0Mz/6q5+/0evvUXxnfj3B9o+cgTb
 70Oyx5nW8bT8vuU01xjkjV1DNNEwqnkvQoCsViLmQLVZL3sbUgDPjG+whneNEHNCLONW
 MpemPX1D6M5xZiy29PmU5krrChghKXe/TT3o9Di/1rNv+PkO2yZ2dTk+NA4MTsvtj12D Jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cp9d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 15:48:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428F3dYe031824;
	Fri, 8 Mar 2024 15:48:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcxwd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 15:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIzM9eVI8FebroHkHfr4IbGFAr92edtywh4KcvfryjVDh9AO5gjfNhn0/5YYfksr3il2aDnU6eKE5phHOXyDBIM3/SfRmi2fUekue5ndPQnxqWV3K7ZXEYLR2VV0wXGMDN5/imAvyBAIL4VQdbphRMKg7rBUmSQwEHw9Hia0gIPS/a6Emd1RfLiWaE+gOd0VG2lwgVEwWMdgsOPwBTqqMZkxcKjwdb9ALlMMHTTXXV5gNbWxjOwyHeNYYJG9gRTC5nJYZG1sPPcWPbAJaOARe5487K2HoANOWFvy2AjlGkgUN1ZBlgfhWXMWkt6LDXGDQR4YPoTbzy6lvqWV3tVszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaXlQPxmSvN/Lm+chK5IrOuahVSv25XcKAkjQx5vSz8=;
 b=XrK4qJ8It0xRBiH+5HsgBw5IGwohIwQwthHBsZNlSQK0yLqWwEk4jGSZUTwwFcQX+1l9gAoOUCN/FF0BYXGSI5EXhRaLTJQdnG9qBwK8JXvM86WkZ+RATITw/Vyk9gPoGJW1/GmfsJ/3csP8iNJ6pE+hhvTUziSheWWQKDm9309eoTvySTuIk4F9MPvPYZKF9Q5H1pI9g817pJbROBfg+1yNh/058NYjboGQBmYlZYo+bCx5JX76I7WsSd5JkyXiV45gh9tp4vdmbGLk6u0lXwBeSQKqT94jhla28BzWFBvnMCCZBIlnRZVB1yj57dNtP50kGAGMkLDPrtiW2lW4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaXlQPxmSvN/Lm+chK5IrOuahVSv25XcKAkjQx5vSz8=;
 b=DD3CzuhtvNZzKmZO1tQv128EVm3xMx8kPaErkOvptOjDXXrt+KvhRXzh+2xwCImos+WZr1ekh9hcZ2o2CCxhvprvJdhnSZf1Aw7l09T41CaJoGvWgWM44cK/HCs6S9/HrnhNMKIpas7SDnmBCOyU8Q7Ghpe7rxRQH6HhVcqXvLY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7381.namprd10.prod.outlook.com (2603:10b6:208:442::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 15:48:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:48:46 +0000
Message-ID: <9a8f7496-b5ad-45f5-ba0b-5690a8a39fa6@oracle.com>
Date: Fri, 8 Mar 2024 21:18:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
To: Alex Romosan <aromosan@gmail.com>
Cc: Filipe Manana <fdmanana@kernel.org>, David Sterba <dsterba@suse.com>,
        CHECK_1234543212345@protonmail.com, linux-btrfs@vger.kernel.org
References: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
 <82b85e61-2f85-4d01-afa3-003f74380573@oracle.com>
 <CAL3q7H7WpEOBx_66uyzrOH_Lr+Y1j5Gg0gViqGCLQg0vmg9G0A@mail.gmail.com>
 <03bcd60e-33a7-4bc9-b048-8ae8de6ab9aa@oracle.com>
 <CAKLYgeJDQHTWj4U_SBLRK6ssoTJEkn9_EdZXWPgTfkK6s87H1A@mail.gmail.com>
 <5f3eec2f-d59f-4a2e-a219-770ce3bd02a6@oracle.com>
 <CAKLYgeLgp4=QxmSEZS1+eUhdfjh-S-hu+HgtFeq51-jgj2EGTQ@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAKLYgeLgp4=QxmSEZS1+eUhdfjh-S-hu+HgtFeq51-jgj2EGTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: f38568d5-45f4-4fa5-320f-08dc3f873d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H622MmeL2HpOspT++dRFhj9cBKy7BGxs+IGq9fEquN7DZv8tfh4hI2+WPn9qfzBnjjILDzgJKMdejvR2ea4uzXxxxKUbKjW9IrWyNnxKSZA/gIuQDRyma8WS3FBYTBRlGo1MnuDGPXgVswpJ9EM4bSiN/tNqKR8Y7RO5o6sIshSzpcMaMnyylx0JlAQmUXmerAmKXUskWJJlKDjbp8ORArAzC56W5tNOiRvNVXrqZGXoHgfP+zsww9/hrAIbLe4WYiuN7irRzKRTK7zBGK1ujfGFd9aBKhzOHygiC7dEdw7HN3hNymEggXmsw5ZnHb2oAbGbRlGHYO2xTrfOTXMTeNjfo6nmGifKzlVZ1Jweu/oBOQR8Z6+M/wLzjJtyly4Cxi1dq8SvEwpxgMv+4m7DMEpJ2TPOpHKmp9T/9g6x1AOhe+/zI2uNPUa914vkEmo32dH1HByh5LP6W4xNhDGoq0m3BJ0a/r2+SH5fhbRSDlmQXIwxdwSuykj3ytMypWVbNnBb3gU/tyImJ7sXxCSdo9vwmL2cgSSegnGQEPtK9z3Z25gF6v1YfZsPseGOVthOE8Y8fvJ8ZdgbQTrYdGPiKyGwkzMFR/Y6cqzmkFsMa+O58w2vRsxYjowi89B4iAgz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjJFWStUSXpqeC9ycmRlWWpZck00aFY3dlFTcTZMSGJHOWdkQ2ZtK0x1RGFN?=
 =?utf-8?B?SnlHTXFub1NVV2ZvcWFIU3l2c2tmV0ZwNEFaK3lIb0tGR1Z5R3RwMWE1VjZE?=
 =?utf-8?B?bzRBRHFseHNkKzZ1K1BnMlp0SGVJdmZTK3pDb0pKYXZmamtFa0JlU3NoNVR1?=
 =?utf-8?B?aitvSnlkZ0VsMUQ2UEg4L1o3Y0VsS21Xb0taZCtsZFpkNEMxRXdnR1dtM2ww?=
 =?utf-8?B?b3Mra284NWIza0dhdXZGaDdzOHNLeTUwdXNnZmNtRGp1WWJZREVEWlFXVW1z?=
 =?utf-8?B?Tnd3Y0EyQnNyMHdZeFh4TThYdnR0L2U5ekRscVFZVlo2UnJ0VFZsRjZKbTIw?=
 =?utf-8?B?bU9HZ3hUZm1YcUtUdGI0SjhNQnYwc1hYYkI4bW5IejEzNFBDTDZaM3J6TlRY?=
 =?utf-8?B?NTV2S2JWelVmbE94Sjhscmc3dER5eUxEQXBnbkFqbStiTHdTSTFTMlo4S2g0?=
 =?utf-8?B?TU90b2hlV1Z5NzVYeFZZOCtPMnZSUmhON1loY0lydldZL1B6MThhMkw4dTRW?=
 =?utf-8?B?WWFuRHJkNnZNTlJ5K29KV2xCaVR2eTF0Wm1pV2ZWTFpCdnNPZ1lWY2xreHAr?=
 =?utf-8?B?WGdONjhYaUxBS3hkU2FUTlZNR3ZUb25NSEF1aFlLTDVlbU0wcnVTbitYQ3JQ?=
 =?utf-8?B?TWtIZHpobTFZNFZqTExselhZdmF4VzdMc2hpaXdOK0pNWFFadERxeGwydWF4?=
 =?utf-8?B?UjNiNWorN0pKNEp5U3o3SWNrZ2I2eGhhdTV0U3dpQ2UycnlsbGt3eEVQNGtu?=
 =?utf-8?B?QVlWUld6cFVubDF1OWRhU2RDek9LZ0pialZ5ejBnamdublBjaVRId3NRSzFt?=
 =?utf-8?B?eUtleDE2dW5sVmlyMHgrODZjaVp5anNkVnBvQW1IWmh6YTV6alBSZDlwdFpI?=
 =?utf-8?B?enVVRjF2TEw1ZTh5aXRPSW5DT3I1bVBVQjBUcHVwNHhKbTV2OUljRCttWGxk?=
 =?utf-8?B?dGZiNkJpcm5zWlRkNDVHbXZ0QmlRdi9obWxJUHNLdWpIWk5EYkVYNTloVy9i?=
 =?utf-8?B?VkZWK0grOHZtQjNxU2E3aDNxWS9TVEh5Q2l6VlpSSHFMS0Iwb3dFVjgyejJn?=
 =?utf-8?B?M0lVYmNMcURES05rdnFxaVJTUEM5T1FmdU1DZ2ljMFdGTFhWa09lamhRNUpZ?=
 =?utf-8?B?QlFTUW5zWmtDczJENjdjbTFHbkQ1Qi82cE01K2wyTUQ1azZqcU1BQit1T1k5?=
 =?utf-8?B?V1kzK3dCRGY2cVVyWVpzVU5uYi9pekx3WExWaFBpSzlXaFpsaEttS1oxdDd3?=
 =?utf-8?B?Z0FRWlBLTWEwcTQxSHpKK2dqOE5IeEJZeFl3b3VWSVBZZmIyQ3pDdEhYMVp3?=
 =?utf-8?B?R2d1R0w4NXpZOW80SjBoamowdDR6R2dkKzlTTUhqNzU5YlNZd2VkOVhNTTh5?=
 =?utf-8?B?MUhrWkdIR25TK0tGRU45WmJQMDllb25Vd1ZjOFFCYk5VeENSQU1DTEFwZ1po?=
 =?utf-8?B?dWRLNVlMU3psWGFseHVjcVNNbWUyUzFxTnJKT0hZeVcwcHZBZFV0Y0pST2xw?=
 =?utf-8?B?bDMxT0RHQk5oZlNnRFlJaWlTSHZkRmdTZDhzRExBdGtZNTJTdkpCakVUZ280?=
 =?utf-8?B?dmY4a2tmakJ6TEpRU2k2VlJaeGNoZnhTRE04YnpUUkRwaHNIWHNTRTV4Vnpv?=
 =?utf-8?B?ZDd5WW1lbml0QlA5dC8rSW40ZlgxVDVIVnZyM0JaY08zN0dQcVF4VUdObHhN?=
 =?utf-8?B?R0ZkU3lpN01zMC9TMXRUb2tEc3JTcm5IejZsR1B1OUpJbjg3NTczTlNQRE1o?=
 =?utf-8?B?MUtuR2JydDhvZXpoYUtkQWtNbmJEN2IxSEpZQjE0ZURMSmVBN3lEdnJENUdw?=
 =?utf-8?B?bk1jZS90aGphM2JyMnpLcUxHL3RkL3h6SUx0T2ZMMjRUSC9ObGUyZWd0azdY?=
 =?utf-8?B?ZmVEM0l0eEJlRDhXKzJtcVkwS0twQnJRNXE1MkoyUXRBZGlJNmxaK0N5WGVP?=
 =?utf-8?B?T2IyRWxHZkIrUWwyUGYvWlVqS1lJeU9FVUw4U1RvSy8xVWtPNWRwRkpObSt4?=
 =?utf-8?B?ZlBSMDFMUzRmNkdXTmdyTWJ0N0hoY0ZlZkc5MkJMZnliaXZyeVduR2tWZ1hV?=
 =?utf-8?B?NjkzYTRoM0FZQ2M5bTByTjYwYVV0TjV5WkVCZStkQkhMMEQvZ2d0a2pHb0lt?=
 =?utf-8?Q?st0aTYaEn/UTHowA1CTkl3J5e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y1tDX8Vd4N4kt1ljUkv8VbpHi97488+veKyIxo2TMd2bXg9RgM/5M3PAJpn932LmOFd5NC5kI17AoHufs66ciswTK21yscTdb3CIbRE5RIYYvp/v3nP7gykkPwTyuA1qE8fVSCfQXIxatF8SocV1Bd6TjIXsFN7cTDcfcw7iF5ATY84Gqa+U+ZcixTulzhxtROJQOmQF8n8HNy5asbfUlZvt2z/DLbiGmUywwMF4WMJsmURwcxNc8TX9/hgCMapumVWZNl66G0Fa/p913yzrgnaewuSSlijqVVLpeBXuwhtjNhJPIbvBhPYh0RgKEa8RmKyUlnYRmzpdgkEIohUEdzHMdzglJud5dkdCYuP+hFspMOGjpwsbYQLolNHENK88AjSRPS9cPMalP9yR0AHcRqkqEL8c4bE6buMNWspF+8XlarBZhn9IM4uH0aR3N7jzDfvR5OM18l0fDlkQ9ggVAnj4Jb/hAE4vPRWNRvOI41owYrp6nfLUfFeccznzm1RAXX6UxHT97PDTySEA9eBiAyq92tywnMRkX3wpM2LmVvpJ2XmCp+XajpGT3rxAWUvONyH++qiQHlt7dN5fMROcaled1hAz6VdxwwjtBpkbJEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38568d5-45f4-4fa5-320f-08dc3f873d80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:48:46.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zpe1fG/umOPROqcmAdmYAFQ0m1d0E5m9YVEw5bPR7bHdH6R9PXDNZl7dDSM8mDTNnZbkeAtJ8pCub9RnIhEWDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080127
X-Proofpoint-ORIG-GUID: LAjIzlq_Q6yxK-SF4FGSs7ieo8sTfJ_N
X-Proofpoint-GUID: LAjIzlq_Q6yxK-SF4FGSs7ieo8sTfJ_N



On 3/8/24 21:07, Alex Romosan wrote:
> confirming that update-grub works with v4 of the patch. these are the
> relevant entries in the log:
> 
> Btrfs loaded, debug=on, zoned=no, fsverity=no
> BTRFS: device fsid 695aa7ac-862a-4de3-ae59-c96f784600a0 devid 1
> transid 2026388 /dev/root scanned by swapper/0 (1)
> BTRFS info (device nvme0n1p3): first mount of filesystem
> 695aa7ac-862a-4de3-ae59-c96f784600a0
> BTRFS info (device nvme0n1p3): using crc32c (crc32c-generic) checksum algorithm
> BTRFS info (device nvme0n1p3): using free-space-tree
> VFS: Mounted root (btrfs filesystem) readonly on device 0:19.
> BTRFS info: devid 1 device path /dev/root changed to /dev/nvme0n1p3
> scanned by (udev-worker) (279)


Thank you for reconfirming and for sharing the logs, which clearly
depict the device path updates. Additionally, there is a separate
patch to include the major and minor numbers in these messages,
enhancing clarity further.

-Anand


> On Fri, Mar 8, 2024 at 3:37 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>> Sure.
>> Here is the link to the latest version of the patch, which is v4.
>> It is based on the mainline master.
>>
>> https://patchwork.kernel.org/project/linux-btrfs/patch/65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com/
>>
>> Thanks, Anand
>>
>> On 3/8/24 20:02, Alex Romosan wrote:
>>> sorry about the previous html mail.
>>>
>>> Just to eliminate any confusion, can you please provide either a link
>>> to v4 of the patch or include it in the reply to this and explicitly
>>> labeled as such? I am beginning to have doubts as to the version I was
>>> testing. Thanks
>>>
>>> On Fri, Mar 8, 2024 at 2:52 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/8/24 17:45, Filipe Manana wrote:
>>>>> On Fri, Mar 8, 2024 at 2:28 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>>>
>>>>>> Filipe,
>>>>>>
>>>>>> We've received confirmation from the user that the original update-grub
>>>>>> issue has been fixed. Additionally, your reported issue using
>>>>>> './check btrfs/14[6-9] btrfs/15[8-9]' has been resolved.
>>>>>>
>>>>>> However, reproducing the bug has been inconsistent on my systems.
>>>>>> If you could try checking that as well, it would be appreciated.
>>>>>
>>>>> Sure, but I'm lost as to what I should test.
>>>>> There are several patches, and multiple versions, in the mailing list.
>>>>>
>>>>> What should be tested on top of the for-next branch?
>>>>
>>>> v4 is the latest version of this patch, which is based on the mainline
>>>> master. As you reported that you were able to make btrfs/159 fail with
>>>> this patch at v2, v4 of this patch theoretically fixes the bug you
>>>> reported. So, I wanted to know if you are still able to reproduce
>>>> the bug with v4?
>>>>
>>>> Test case:
>>>> ./check btrfs/14[6-9] btrfs/15[8-9]
>>>>
>>>> Thanks.
>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>>>
>>>>>> David,
>>>>>>
>>>>>> If everything is good with v4, would you like v5 with the RFC
>>>>>> removed and "CC: stable@vger.kernel.org # 6.7+" added? Or if
>>>>>> it could be done during integration? I'm fine either way.
>>>>>>
>>>>>> Thanks,
>>>>>> Anand
>>>>>>
>>>>>> On 3/7/24 16:38, Anand Jain wrote:
>>>>>>> There are reports that since version 6.7 update-grub fails to find the
>>>>>>> device of the root on systems without initrd and on a single device.
>>>>>>>
>>>>>>> This looks like the device name changed in the output of
>>>>>>> /proc/self/mountinfo:
>>>>>>>
>>>>>>> 6.5-rc5 working
>>>>>>>
>>>>>>>       18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
>>>>>>>
>>>>>>> 6.7 not working:
>>>>>>>
>>>>>>>       17 1 0:15 / / rw,noatime - btrfs /dev/root ...
>>>>>>>
>>>>>>> and "update-grub" shows this error:
>>>>>>>
>>>>>>>       /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)
>>>>>>>
>>>>>>> This looks like it's related to the device name, but grub-probe
>>>>>>> recognizes the "/dev/root" path and tries to find the underlying device.
>>>>>>> However there's a special case for some filesystems, for btrfs in
>>>>>>> particular.
>>>>>>>
>>>>>>> The generic root device detection heuristic is not done and it all
>>>>>>> relies on reading the device infos by a btrfs specific ioctl. This ioctl
>>>>>>> returns the device name as it was saved at the time of device scan (in
>>>>>>> this case it's /dev/root).
>>>>>>>
>>>>>>> The change in 6.7 for temp_fsid to allow several single device
>>>>>>> filesystem to exist with the same fsid (and transparently generate a new
>>>>>>> UUID at mount time) was to skip caching/registering such devices.
>>>>>>>
>>>>>>> This also skipped mounted device. One step of scanning is to check if
>>>>>>> the device name hasn't changed, and if yes then update the cached value.
>>>>>>>
>>>>>>> This broke the grub-probe as it always read the device /dev/root and
>>>>>>> couldn't find it in the system. A temporary workaround is to create a
>>>>>>> symlink but this does not survive reboot.
>>>>>>>
>>>>>>> The right fix is to allow updating the device path of a mounted
>>>>>>> filesystem even if this is a single device one.
>>>>>>>
>>>>>>> In the fix, check if the device's major:minor number matches with the
>>>>>>> cached device. If they do, then we can allow the scan to happen so that
>>>>>>> device_list_add() can take care of updating the device path. The file
>>>>>>> descriptor remains unchanged.
>>>>>>>
>>>>>>> This does not affect the temp_fsid feature, the UUID of the mounted
>>>>>>> filesystem remains the same and the matching is based on device major:minor
>>>>>>> which is unique per mounted filesystem.
>>>>>>>
>>>>>>> This covers the path when the device (that exists for all mounted
>>>>>>> devices) name changes, updating /dev/root to /dev/sdx. Any other single
>>>>>>> device with filesystem and is not mounted is still skipped.
>>>>>>>
>>>>>>> Note that if a system is booted and initial mount is done on the
>>>>>>> /dev/root device, this will be the cached name of the device. Only after
>>>>>>> the command "btrfs device scan" it will change as it triggers the
>>>>>>> rename.
>>>>>>>
>>>>>>> The fix was verified by users whose systems were affected.
>>>>>>>
>>>>>>> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
>>>>>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
>>>>>>> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
>>>>>>> Tested-by: Alex Romosan <aromosan@gmail.com>
>>>>>>> Tested-by: CHECK_1234543212345@protonmail.com
>>>>>>> Reviewed-by: David Sterba <dsterba@suse.com>
>>>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>>>> ---
>>>>>>> v4:
>>>>>>> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC stage.
>>>>>>> I need this patch verified by the bug filer.
>>>>>>> Use devt from bdev->bd_dev
>>>>>>> Rebased on mainline kernel.org master branch
>>>>>>>
>>>>>>> v3:
>>>>>>> https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com/T/#u
>>>>>>>
>>>>>>>      fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++--------
>>>>>>>      1 file changed, 47 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>>>> index d67785be2c77..75bfef1b973b 100644
>>>>>>> --- a/fs/btrfs/volumes.c
>>>>>>> +++ b/fs/btrfs/volumes.c
>>>>>>> @@ -1301,6 +1301,47 @@ int btrfs_forget_devices(dev_t devt)
>>>>>>>          return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> +static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
>>>>>>> +                                 const char *path, dev_t devt,
>>>>>>> +                                 bool mount_arg_dev)
>>>>>>> +{
>>>>>>> +     struct btrfs_fs_devices *fs_devices;
>>>>>>> +
>>>>>>> +     /*
>>>>>>> +      * Do not skip device registration for mounted devices with matching
>>>>>>> +      * maj:min but different paths. Booting without initrd relies on
>>>>>>> +      * /dev/root initially, later replaced with the actual root device.
>>>>>>> +      * A successful scan ensures update-grub selects the correct device.
>>>>>>> +      */
>>>>>>> +     list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>>>>>>> +             struct btrfs_device *device;
>>>>>>> +
>>>>>>> +             mutex_lock(&fs_devices->device_list_mutex);
>>>>>>> +
>>>>>>> +             if (!fs_devices->opened) {
>>>>>>> +                     mutex_unlock(&fs_devices->device_list_mutex);
>>>>>>> +                     continue;
>>>>>>> +             }
>>>>>>> +
>>>>>>> +             list_for_each_entry(device, &fs_devices->devices, dev_list) {
>>>>>>> +                     if ((device->devt == devt) &&
>>>>>>> +                         strcmp(device->name->str, path)) {
>>>>>>> +                             mutex_unlock(&fs_devices->device_list_mutex);
>>>>>>> +
>>>>>>> +                             /* Do not skip registration */
>>>>>>> +                             return false;
>>>>>>> +                     }
>>>>>>> +             }
>>>>>>> +             mutex_unlock(&fs_devices->device_list_mutex);
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>>>>>>> +         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
>>>>>>> +             return true;
>>>>>>> +
>>>>>>> +     return false;
>>>>>>> +}
>>>>>>> +
>>>>>>>      /*
>>>>>>>       * Look for a btrfs signature on a device. This may be called out of the mount path
>>>>>>>       * and we are not allowed to call set_blocksize during the scan. The superblock
>>>>>>> @@ -1357,18 +1398,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>>>>>                  goto error_bdev_put;
>>>>>>>          }
>>>>>>>
>>>>>>> -     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>>>>>>> -         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
>>>>>>> -             dev_t devt;
>>>>>>> +     if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->bd_dev,
>>>>>>> +                                 mount_arg_dev)) {
>>>>>>> +             pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
>>>>>>> +                       path, MAJOR(bdev_handle->bdev->bd_dev),
>>>>>>> +                       MINOR(bdev_handle->bdev->bd_dev));
>>>>>>>
>>>>>>> -             ret = lookup_bdev(path, &devt);
>>>>>>> -             if (ret)
>>>>>>> -                     btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>>>>>> -                                path, ret);
>>>>>>> -             else
>>>>>>> -                     btrfs_free_stale_devices(devt, NULL);
>>>>>>> +             btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL);
>>>>>>>
>>>>>>> -             pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
>>>>>>>                  device = NULL;
>>>>>>>                  goto free_disk_super;
>>>>>>>          }
>>>>>>


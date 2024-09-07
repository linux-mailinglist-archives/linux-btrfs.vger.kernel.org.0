Return-Path: <linux-btrfs+bounces-7885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF896FF28
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Sep 2024 04:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F501C225A1
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Sep 2024 02:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1C412B8B;
	Sat,  7 Sep 2024 02:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UljrbDZ9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X8fwf5dz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F781CA85;
	Sat,  7 Sep 2024 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725675255; cv=fail; b=aFhuPT00PacYkEuOvoSEPJ43p7As6zNmy0iYEs1/qmdSCGurWGzpcIScO17wg4ekP9frhMQskn3/uehm34AmdYMFkGGicM7gMY3bCQTdbvDy5oVh6qcKAWYuC6+6fqTPmRsDcmNdpxdiVFhkqItLGTx+LHNRH26mP0tK8uL5pbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725675255; c=relaxed/simple;
	bh=KlB9j4SnIO7DxKZqgebaX4d7wRi6+dBx9ucCwZOKvlU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aqrbKXRkPZCkFAaLFrDB3KH+dtUEAwE/ed70NUbjOU5hulp6aPtzg6lZh7WQP0g1PH52Pd8HQYGdbKHbVkmMb72YpP/KJho/iiwjEq4HyJvsbU4YsdgrDRZss5b8o3r7ASLMeLUQZ07dsQGFjR8F1+NPko81XrIL8NbO7YqPyVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UljrbDZ9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X8fwf5dz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486KXX6O014794;
	Sat, 7 Sep 2024 02:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=rhG6cDtPBSrorU3W1xAqOSwoZu+hyi6uGV9Qf1fxLzw=; b=
	UljrbDZ9XO/+x4lTwffg7v/8MgtMkOeJ82SF76tWBRwkUH4ws+K5woi2AuHVl3wt
	Oe8yTUa9wTDyHKIFHYwEIXetPYOY94vBs+aKawF6Fi2vBE0bFKeM/KWVJv9PMTFF
	LNTaQR7Q9ORkKfyuLpej5igKKv0f/NZbWyqNGdYWRaWNIfF0wnK51GKBEhn7t87J
	YqxB7UPYxkroEipSy5NnbmiUQNUuYEyWalsa5Hq1QNWyNIu360zveBLsLKBbliPF
	4yxrpjaigY0uH7cfa1P3DOmqz5jva8OWk/SOozcvLgXG0F/ghcD7dalzSm4Gw0x4
	9DwhhuVzHKy/bbM3mkQhsg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwkauwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 02:14:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4871XiiX000300;
	Sat, 7 Sep 2024 02:14:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd96rk98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 02:14:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGcCOawBeBUyDLJs8Ep8UMVc2KF7UfHWteCTrnoxNhJTmrM3pzJ7q22/ej62Gvr/p5kpoJdo/GyWoQB2qxuRgyaTIdWpxOppel1YnpXwVdJi9c0ep0mYCMpOM4aqKxV/6b/sDzXX4l0BdYUbdjukEkEfUir4rOGEE+ioui4vZlf5BumB43ymvA3Y6tS/2sVnPnurZV/OM1AlI/e8CSblNjzGSlGAwkeI4Qlls60Goj39SalAAWKokzDBrZhyQxew3ZEWExuoGj7XOtT02ekqwQ8M9jBq3N11Bd70G3p61e6gWxD6Jc4VdH/wI0NxdIqG8zGNdIfiHDKCjYEP94528g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhG6cDtPBSrorU3W1xAqOSwoZu+hyi6uGV9Qf1fxLzw=;
 b=SIxNlkr6ovxNdxOcGdSN/2OD5e2Dy2UBiDqMWba0gU8XkD2ZJO7V3sR522H9OuiHmxMFgz3xJKDamqKt/LNXFBmTUBi6Ik1bQTNq+5aqwT+IEqKuqEzYfAyn+qR+1EqcAsEHzghuZGLflLDm/Qu3muPdRb65ADKjQmCDA54j5saAbov+O8CX+r5u0Ewq9AqLNw7yLbvYitT3/mRKQ+WmN7OmsGyqUQUQN7577FrlKMvJTzDWMzdtVdsU6lBht8orgMPVGJeZoLe/TxLI5YzIHcZiNiktKexCkGOQDy6v/+W2t7AtaTCbr06/NL4IXhsxTl+OItRI0PvuJdpi5OP+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhG6cDtPBSrorU3W1xAqOSwoZu+hyi6uGV9Qf1fxLzw=;
 b=X8fwf5dzY33YyQJLDzDTB2mMrheRdsucYaZDZ7BM8Db6rlRrUxX/g1gZOqlohSrSeNnCQ8+tndRppbgs8JtSabBHA9M+5fyLfu8ny2WOPz1WAUNSLyFxMpA/4DFRD3Nu7bbAljzILSzMJTQzHmhhgVeZ8lKKzsub7Bux8BSzJHo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Sat, 7 Sep
 2024 02:14:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7918.024; Sat, 7 Sep 2024
 02:14:04 +0000
Message-ID: <8e77b562-26a6-4aee-bcf1-8978d5ea5333@oracle.com>
Date: Sat, 7 Sep 2024 10:13:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/319: make the test work when compression is used
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <e2aab2e4d87251546d4218e6d124a4fe657203e9.1725550652.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e2aab2e4d87251546d4218e6d124a4fe657203e9.1725550652.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd6e111-f2b7-4fb5-e0cf-08dccee2bed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2htY0VUMXEzVXd6TTJVckZER2xUNWROVjlHZW55RnR3aU5TdUkvYS90VWhp?=
 =?utf-8?B?dkNPYVk0cXh1UCtVeGlubVNGL0Iwb1k1T3ljQnZZS08yQUFlWkVYUzRrdVIw?=
 =?utf-8?B?UDhxSmV0NlBVdFN0RkVWS2QrbGx5b1dmd2h6K3VOQi9KQzNmSW9na3FqbFo4?=
 =?utf-8?B?S1Q2V25uYzhrajZZQnNmU01XQXVZM1MrZHZnc1NLOW1OWXdEeC9wNmlUbFFZ?=
 =?utf-8?B?U01rTHZBR05aNTJVUHlaRVVyY0x2Z2dndVFHeGI2a1VaL2lrMFdnUWdGaENE?=
 =?utf-8?B?Ym80YUFIaTJvY3RFcURJMlhPUStrNXIvcmh2WC9kQmh2ZWJsT3VBS2Y3Tm9j?=
 =?utf-8?B?Z2JxMUZQaWNiYlR0ZHp6WHV2SUtuZFdXVW9GMlZOb3g1OEJZWWFTbWYwZXAy?=
 =?utf-8?B?dHdqMEYrTjQ5U2c1UWt4WktyVEY0elM5OTNvWnhYb3pXdEtYL3R2blh1cVVU?=
 =?utf-8?B?UzFvMW0zd3FORFRQMHpwY1QrVkxialRFMkpiaXhDTHRvUVVkVkdoUHYyY2RX?=
 =?utf-8?B?ZGpNWDNBWlFUMkV3QjBEd3ZuaW1VRHJTZnFtMnhmRlhjQWEvRmZLUGx4czJ0?=
 =?utf-8?B?QlFRMWRZRkRQbHR0VUsydkpFbGFkVVZkOXlLL2ozSFJ0U2pKbm5kVWg5OGtR?=
 =?utf-8?B?YzljZmJHR0RKSEtseFVkOWtWK3NFb0h3WHQrR1Q0OUJaK2UybnZ1TW9zNzg4?=
 =?utf-8?B?L3JHcG8wY3FXQVZ1Smpadjl0WmI0TVQ5V21jQURNOFRYYlNOb3ErVEpGSnZp?=
 =?utf-8?B?NXJmMTdOUGYyQjBrYjl1VXlGQlBUK3ZBMlBJeTN0OEVLbEY2U2tFbjd4WG1K?=
 =?utf-8?B?TkhXcnFIQnBrY0k5eThPamJVdVFKUmRzWmttTGtrNXNLZTlydGVKRnBNckY4?=
 =?utf-8?B?cnRHWmpzU29lOTRhK2c4cldqYVgxbGtMcDJ2dWxmSjFSaVFwSFZCSEE1Wkpr?=
 =?utf-8?B?NExlWUFsTk5FcEo5MTEzK3F5d2VDdi9VTnRRZExnaElMVmxrRWt5UzdiVmtB?=
 =?utf-8?B?eVJhOEFwTjlkM0orelpPQWU5Y1ZDM1pxd2VDc3VWempHUmYxSWZXMjVnRE13?=
 =?utf-8?B?OEgyR0Y4a2tQb01NcGl2Z2F1UUs1dGRQckxOd2g4MjZMcnFzRTF0OUNiVFFx?=
 =?utf-8?B?TU1HdCtFY05NRFFuellna1J0bjNYeDc3REx1S3hDUjdKMVFvWEdEZ3RhTWE3?=
 =?utf-8?B?U014ZnhPaEdZa1d4Vzg0cG5Nb1NnNjZtRDAxUkF2N28zRmxyNDJCblZPd2ZR?=
 =?utf-8?B?d1VpTm4yQWNyL3ZpS2M5VlFQSTY4dlg0dWZUNWxYTnMzTTJmaG0wMG95SFUy?=
 =?utf-8?B?M09sZFVNaVFZWTJrWjRrMGliMUk4a2pnRFFZSDBDVUROM3VoelZ1WnYzNzlR?=
 =?utf-8?B?WGQvSkxaQVB0Q2l4amprR3BqRjNaK3FQNzd0SHRQQWlxa2R4RHNxWWJzem9W?=
 =?utf-8?B?SXVmeVBON2ZBaGNHbmUyWGhCYzBaNG5mcUkzSVRqdGQvM2tXYnZJM1BWcVo0?=
 =?utf-8?B?UngvNnVqVXQxWVEvSjRwUG9SUnNLRitXNnplUzhQK1YzdFFkOWtObVVBTmEx?=
 =?utf-8?B?c0pLNzhBeTNKU09lZjNVOVczNEFuU28yTWU0TzN5TzFjRHpKRGdlZnRsSVpm?=
 =?utf-8?B?b2U3NUJEcmRKdHFRZnUwdG84S3EzU2thWEJkc015ODFhWUJOYjQ4Qm1UWVVE?=
 =?utf-8?B?WXNSTVFHeDBZNzZJbmEvYndNbm9MWFFRTTdNT081cHJqQXNTOVVRck15ZWNQ?=
 =?utf-8?B?eTI4T09VRVp6K3FiQXFwbWFpYjhoengwREhWRnVoTUVKbW5MM2Q2cWZMZEs2?=
 =?utf-8?B?VVlHaGtQNUY1clFrdncrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V20yL1lCMDlmWDNzOXF1dDduRTdTdWc1L2NRK0g1eXZGKzBUVWRTbU5ob21P?=
 =?utf-8?B?TUcvK3B4RzdRTENRU2NwZlpDMW5aZlp6V25UNVB0QXB5N1cwc2ptNVlQdXNj?=
 =?utf-8?B?eXN3Ni9PQXNqZmxRSVA1QjRFcllaWEwvbTcrR1ByV09aQWFoOHJPYXlMQ0lz?=
 =?utf-8?B?eFBNZGFSWlY0TXIxSG1QMTQybDNNWEdVNFI5a0MyK3FsVmgzbjRodytraG92?=
 =?utf-8?B?dFIwVUV6R2t6bU1mVHRTSm8zQ3JRdHBYMEE3dU14Qkc2czBLMzh6cHNGdTdT?=
 =?utf-8?B?YkhlLzRWOW9teU1QL3RwNmRURzVkTWw2SDJ4OXZzVVVVM0FaUjJCOG1PR0h4?=
 =?utf-8?B?SmNueVFEb1N6STBENVJFc0cwblBhMThuNkxQZksxY0Q0aHJPRVRiUVJOdFd4?=
 =?utf-8?B?ZXRhaktBUXZPM0lsam4xeUt5TlpVTUpxbFJQOVVLOERUcnhxQ0wxRHVyRWxy?=
 =?utf-8?B?MjdJZEVJU3VvRnRCWFRqRk05M1N1c3lVR1pJaUI1NlZDLzNFZExQditzeWpK?=
 =?utf-8?B?MENld1JNdDhRL3hzMmdNVUFudlZaemVNYmYxUVc4VDJ5NU44ZlpqZDBKeVdL?=
 =?utf-8?B?bGFxcnorNW9YNW16YUZaWmlyZkZHWVI2NXBOMldlVnJkSWc1M0l3czIwTDVy?=
 =?utf-8?B?djRldlFKUHozdUZMZlVmME1iOGtoVUlKOHlDS1NUc1VCTDlEdkxoNVVJR2Iy?=
 =?utf-8?B?N3owbVJQRlo2UDVacFlCVlZIczNlTVFkZzd3RUg5QUEvZXZyeHRGcG8reVJS?=
 =?utf-8?B?a1RJUzdGU2RjWGI0akZueG5JNmZyaG9JVmhUbGwwRXEvemhxNDJMcTN5NEpt?=
 =?utf-8?B?NUNnM1ppUmRid0k4L2lHeXRFbmRuVGMwTkVNVVdSc0lKd2NiZkZRTmFvektl?=
 =?utf-8?B?cHdCTm52UzdlZ0N3enN2ejhsRlNhVVNIckV0cU1admc2T3QrTFVXNG1JUnhI?=
 =?utf-8?B?MGJvZkRtTm9Wd2kxVGlNZ2VYcTBPNkhMN3dIYzRWYis5ZnltcFRDQk1sL3Fq?=
 =?utf-8?B?VDgwRHVJNEtLMTZMY2VIdUs5ZmRCL3MyaCswRTIwamRWampnY1hYbm9DUmVX?=
 =?utf-8?B?R1dtYXErSUZEaEpKY0FuUFNxTzhycHF5SGNJY1JSdEpja3pybGZkSGRvckQ1?=
 =?utf-8?B?ekFNcENCNTBqS3R1M1lLWVcxUXJURTBibE1GSXJVdkI5cjErV0o1UmZId0V1?=
 =?utf-8?B?emlPK210ejZnTmlUQUx0N3NaZVBSZjFKVFk4aTMrTVFjUHpXbVpNVDZVWXVC?=
 =?utf-8?B?NkRrMUYvV1FOTlZsWUpvSW1DQUFPU2RRSjdiUW9hNFNuV2NjaFVLKzhWZ1BD?=
 =?utf-8?B?TEFENGZCakVqejYwS3d3T0ZzTnVpeENaTXJTQ3NlZFc0ZmRVdm5pbTF5d2Mr?=
 =?utf-8?B?OGw0WXo4ZlkvcUkyNTN1aklTbUZ1ZTFjWlp4L25tZW1KMTdadlV3THdCUU9I?=
 =?utf-8?B?WC9nOGhiWUk1LzVPdG82b0V4SDRaYjluR01uTzZXYng2YzRuQXVFQnBPOFZ0?=
 =?utf-8?B?WWJpbmFTQ29Ka1Q4WUdCWm5xV2puUWpyZDlaTGxmem9hYU1zUmJPMjRVbVRn?=
 =?utf-8?B?b0ZKOG45RlhPd0tUaUdTekpLUjdmS1ZCVDIvaTF0TTBXRlpQN3pOZkJEL3dR?=
 =?utf-8?B?alM3b01aUDdWaWJBZ0RYclVHOXBNeksvb29pY2Q2SU5vNFpacEJIWUNCOTM5?=
 =?utf-8?B?YVZSRldwWDJnR1pmZFpPeWp4cElBY0FMVjI4eE92QnJ0dG9kbDBYdE1rUUh2?=
 =?utf-8?B?cDJtbDB3c0ZPQWNvanlUL3RmRVVWQ1BqdUVmbGlPY29UNm1mcU5IMHUxbkRI?=
 =?utf-8?B?TGZZYlpWUkloS3FnTmxtK3Z5c3ZsWXkvOEJ3RytBcnFnRFltUEg5WVE1K1hE?=
 =?utf-8?B?a05kdGNMMEk5RWg2UEdDSDVtS0w0bVRxbVBkekVnUlI1bXNlY2Ezb2RwenhT?=
 =?utf-8?B?N2lRcXNyUW55OWk4ZGJjOERpSjdjdHc5ZEJKWUNkRmtIelJ3c1ljUERWSGU2?=
 =?utf-8?B?NE93VTFLTDJ3ZXdwT3prVEt6ZDRrL253ZTF5M29haHV5NkZJbzdLd3B2Q0xY?=
 =?utf-8?B?NWtCZEZBMmNFcDh5WVZOMTBaZUErNFdzTGttLzhsa2M5QkpXZjRmcnk0RFZ4?=
 =?utf-8?Q?ii+2S89iD35iHlkxyVuAAfA0l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9UTgplJg+Qwe0t6ANV/eKXqxUOd2YSNWgB/mUA7uET/p2pKLfnlZbwJ8DW1/xWLftc3uNT7QQYw91bQMfDuj0rD6d1oJjSI6dUUEsBoNUjwm2pSKl3EswmHIynur6rwCJMdW4yZhLbWygGchK3yEKMJg4b1OEEVm8rhbYtbcwsGEaIW7uNbmZugkcBewXLHBBChm70JM+duxDw3dpmxBKZkXgWyKpPoC5StK/wWeZMBlPrRcP3CG8HlOrZFwdKdX0KuRzlofCQXHjm1bTQksrxJERx8CcMCnsVj11H0IZktHo0GHyWhsCZjnp0YoZS5/tj1lIq4/bOBd0izW+7cN0dU+Uwg/rPPpsRub9Cfx5scUJpWwo5voCI+vXn3+5fH7aGtBSfh6pqQWvT7MXKVlgIITO1n5i5TgA8+nkx//S8w0WQsacuHE6lIP8osB+dCTplBr9q/PwS31UXRlj/a42D3U8feBH8jYzwUbvAaz23YAqwKaCTgJp1R7mpxaFDpN23Hre9NvJ8jozgK7Q46tj4bYW7ir27KieaIXnccscJsV2y7HzjEUtLm5tM9WydlewUFyZFusSvIcQqbhXcquVmgnBKtTiqWhdMs8/wfVsRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd6e111-f2b7-4fb5-e0cf-08dccee2bed8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 02:14:04.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAWRiQRulE3yHIshPaNm6DU462hPd3gWjAELBXXzAcVh6WjFUWpcWuRzK8L6NEq5n0+15SKqWS6LzDu4G5fLjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409070015
X-Proofpoint-ORIG-GUID: dEMpOHdug3aUJIqjE_KmN8Bz4esyK2ZS
X-Proofpoint-GUID: dEMpOHdug3aUJIqjE_KmN8Bz4esyK2ZS

On 5/9/24 11:38 pm, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently btrfs/319 assumes there is no compression and that the files
> get a single extent (1 fiemap line) with a size of 1048581 bytes. However
> when testing with compression, for example by passing "-o compress" to
> MOUNT_OPTIONS environment variable, we get several extents and two lines
> of fiemap output, which makes the test fail since it hardcodes the fiemap
> output:
> 
>    $ MOUNT_OPTIONS="-o compress" ./check btrfs/319
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.11.0-rc6-btrfs-next-173+ #1 SMP PREEMPT_DYNAMIC Tue Sep  3 17:40:24 WEST 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- -o compress /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/319 1s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad)
>        --- tests/btrfs/319.out	2024-08-12 14:16:55.653383284 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad	2024-09-05 15:24:53.323076548 +0100
>        @@ -6,11 +6,13 @@
>         e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
>         e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
>         File bar fiemap in the original filesystem:
>        -0: [0..2055]: shared|last
>        +0: [0..2047]: shared
>        +1: [2048..2055]: shared|last
>         Creating a new filesystem to receive the send stream...
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/319.out /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad'  to see the entire diff)
> 
>    HINT: You _MAY_ be missing kernel fix:
>          46a6e10a1ab1 btrfs: send: allow cloning non-aligned extent if it ends at i_size
> 
>    Ran: btrfs/319
>    Failures: btrfs/319
>    Failed 1 of 1 tests
> 
> So change the test to not rely on the fiemap output in its golden output
> and instead just check if all the extents reported by fiemap have the
> shared flag set (failing if there are any without the shared flag).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand


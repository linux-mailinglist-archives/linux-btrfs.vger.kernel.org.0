Return-Path: <linux-btrfs+bounces-15904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5FB1D160
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 06:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3778462107B
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 04:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DEE1B0F1E;
	Thu,  7 Aug 2025 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zh8WF7wQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="liYxDB/D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13311E3DDE
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754539212; cv=fail; b=ss5Yuhwx4f5fFU6MExqctnfifh4uKCxL+PDg/UIyiq8SB2COjGn7XnhX0a1dmmnhY9k4jxUbCsmq7Dagh7I7O6kvmyGDpGQxDHhicfH3Vrn8atF/uD2Aj2ZSaEJwkRGm32baFsr+S7fzgRFaDZSGHTR67SR10EwKdVPnmvuybUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754539212; c=relaxed/simple;
	bh=NBNQkFU2HnRFCAs8avY5NZPDtIBsxUhtyEbQcezQ5dI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KILhs/Ox7pj1w0BhVH+TC3r5Qc19PPUdhFRcAZalGfw2V1LryDR1UA17G7zeg6qH0xsSGcOHozM6gRvBe/jUzBd17W7F2zETIk++B5NWCv0HvASOUsNZ94Fp4d0pL9dbHGN5tHEa9z2Ir/rtjgDutMBuUEoKLP7DNnDn9J+6/+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zh8WF7wQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=liYxDB/D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576KRMVU014482;
	Thu, 7 Aug 2025 04:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NBNQkFU2HnRFCAs8avY5NZPDtIBsxUhtyEbQcezQ5dI=; b=
	Zh8WF7wQ/ybRj7IfONBWx8/+XfvNjIfAutSztuOkF75D3PwsE6RhljgFMujMJFLw
	FW4suDy8mJNY4TnvxM2jrTFOPFt7Cv/X5EPNY2HXfVjClYAxK0evPM3AVHghjLNA
	IymSW/J2ks4zO+mvMVt8lQFe6IhdgQQ7X71Ac0WgEPSl1BIdsAtxnATVoBZZDWhP
	L9eyKvmZ6MRVFDBRJ/4Qhf863qXRTMaodkfCZWMQ5HudnocQ4qyhYBxrQbyHw2Vs
	LcTRSKaZKquwalpqvoOPEtuT6VfE3b/xiUp6acz9EtfIizktP6DsSePUd/abtIGX
	IFXm1OjL8zcw2i7C5KJKDg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgu159-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 04:00:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57725B18018462;
	Thu, 7 Aug 2025 04:00:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwrvnv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 04:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjhSlTw5pOCdAiyyuh2/CSqekiAPJnvxmo0FCLGNSdZF5zB7BfU0FzlNAPB/cue/TZLHalI/a2sP4uLF46pKa/9A/RyEccH5iFKp0N9BuUqF2xPyCjq5LZUax9mku21K010I2zBF9LUpm9+WK41N7EMoMIEnqX5IFnE6vpqJc3/cWuiNg0C0jIE1NJt7ogqDk9Gv4EQw+9IQ9rbYnIsKlzYnaZ1UbP3FvK+um//I8/C0an0Xwuycl8zrwXnlNUdkIhvO1fGLp/QaMkez9a0iaQOGOqbxgDxqIXpfpv4m2Hhki6BwM6rmlKQKEZpd3TArGW/2mjaQCHx9s4zOvr25ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBNQkFU2HnRFCAs8avY5NZPDtIBsxUhtyEbQcezQ5dI=;
 b=jZMjSsSfftWapQnlV7guqcBm5X41+qfgzoeddm8oYT0MVfXtud8PiCrZYabJy2WP31Y3pVZXhBGoZlTt5oa/Is9cE1wIr4eQ05YLkRJi0bjO7spX04UX5HLl5/dn40aNzYJGv9oTW83ieGNQafAc2G7Y9VT45lBFLEM1RVmW6G2C2xqi+/FzAN9K5dn+Cx5apYfJFVziMN+y79DQzTemux47q8/OPIWI4+W8QOZw3JI7H7KEZ+DqCXaQ5RcB7oK6tn0EYNfUsEXmcFTVQOPritCj7ASoRw8g0Rei9rLZPPo9YgoQDXLhqZ02rbmT49Qx4s9M+mgLlArJqDbgk2dakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBNQkFU2HnRFCAs8avY5NZPDtIBsxUhtyEbQcezQ5dI=;
 b=liYxDB/DJqA8mQS/CRHE1OZIKvpbFFA44+rqjcrbfx5UI93U0u+g2WgzxoLzXsn1sdpMrmAAOOgR/YAFHqK3u+PWUaskN4vPV81sPhRhWXsWR5tlq8YU6mMA/X9snZ6PZ6dUtKUG0uNlkyDvl8x0tv+cE7zkmGAM1KjAARtEBw8=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DM3PPFDEB3189E6.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 04:00:03 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 04:00:03 +0000
Message-ID: <c04f0892-1cfd-4deb-99da-7bcff5b43dad@oracle.com>
Date: Thu, 7 Aug 2025 09:29:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: detect discard ability more correctly for
 btrfs_prepare_device()
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <fb9da17fe4943acda28cdacc690400cf5bc08e49.1754522337.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <fb9da17fe4943acda28cdacc690400cf5bc08e49.1754522337.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DM3PPFDEB3189E6:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd55980-e4d8-41d7-5020-08ddd566e2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUNPSVJ3bjFZdWhDUTBvUUZYc0Q1MWh3ZmV5VkF4SDV6V2w0OTFxRC9kQmZS?=
 =?utf-8?B?T0pwazVlN2VKbDNmKzM0NktzMkJZQUF6SEo0eldseDZDMHc0R0ZubjZWakdH?=
 =?utf-8?B?bC94ZnBjRXczNjR1M3BIQVRZTlVTVWFrYm04Unhab0R1VTI2dndmajR0SEdW?=
 =?utf-8?B?TmZudUxzMnpSRmkzZlVjYTVzT0djV2owNFJzRlR4SGRua3EyOWNmUEdxc1ZO?=
 =?utf-8?B?bGRIR3dxa3d5bHZmaFR2TlFvandSalVnY2pPT0tUQWRaVlo3YnNVM0JTNnBQ?=
 =?utf-8?B?blB2aFQvbkdTaDU0MXRVRmVVNUtjZE1xNlFYY1lYaGhhNXBPQjJaRTdvd014?=
 =?utf-8?B?b2lCbFlQeDZja1FNRkJoaW1GZ2o2OW5CUkV6OW5kamR0ZmpsQ2FUQm1CczVM?=
 =?utf-8?B?VVN6MnJuVG95cU81QVZFbElBd1ZEeFBjSkJSRUZ6UWRqdEVtM2I5ZWI1VTRp?=
 =?utf-8?B?UG55OEg4OUk0dUpqNFRRYzhyNGFiSW5jLzRYQzBlREJpTi96WmJIZmQyVFZy?=
 =?utf-8?B?eU1SaVhZVzF1dkUxMGhYY25uYmtCaWZYVW51VUpKQlZSZDJkNStwYjRqV1hX?=
 =?utf-8?B?cFlNN1djYnhSOTZqSW5IQmhRcjFJWE9aTWp4eFF2YmlZdmtsN1VvTEM3Mkpv?=
 =?utf-8?B?ODBaTWg2VGtrWnNNNUZsWE5zUXZQRzdycDcvZXkzNXRXNjQ4YmpDNGtGR3pt?=
 =?utf-8?B?c0F5RG42U0pucUJQenkySXJzOHlaV1pGZXdvZ3JUOUVuSEtvbTcrRVdZTitX?=
 =?utf-8?B?OXU3cnIxTVN3VTNMN1IzWThhcVd1WlZFS2l2K2xTTFJuZmEvbVA1cjJFcjhU?=
 =?utf-8?B?cHU1L0ZwcVVTblNYZ3dEc0twaUFxTjBHVzZoeUt4a3g3a3JOcDNJeHBlUy9q?=
 =?utf-8?B?aFdqK2NlWmVGdEhNU3NRWmtnWHBrUXRIRHVRK082b0Zpc0ZFbFZJK0Z2U1Ft?=
 =?utf-8?B?OS9BTXd6aUFZQTZCb2E5UzFsNSsxNGJiNXdsMGhLd2toUzJ6OVFmRDlSYjFa?=
 =?utf-8?B?Y3ppQ1hPakVabmxDYkllSWljL0hsUkEyRjJSTW5wT25NWEdyMGJURm52QlFa?=
 =?utf-8?B?NHFoV2ZFanBJVWIrbkYveXZ4R1F0d3F2QmZwZlkwejRIRENBZUQ0L0NsdWtK?=
 =?utf-8?B?UGp2NVU0RWxyZjRlT1F0UkdVZTR2RlR1MHRSNWpWbVQxS1FQbVI5QUhVcjFT?=
 =?utf-8?B?Z0tzK1JtVjlWN3FLVjV4cmU4U205YVVtMTJ3dHNUYmorZGFpOUlmNmsxZmI3?=
 =?utf-8?B?RHdmWi9ISk45UHJ0QjliUTJiTFRjZWVVMUJSVTRlYk90TGtRMUk3NWR0ZUtl?=
 =?utf-8?B?ZUdVaU9KdnNkcjc5S3JDQXhWbkpCcHpVUTNvdVd1Q3pvNUh1cE1tL0dETzg0?=
 =?utf-8?B?THRLenRvL2dySTJPSW1zTEJtVXhaMS91WU1RMG4xanI4YUJ6UldjNC9RbGNY?=
 =?utf-8?B?K08yOXM2VmFSOGhDQ1JyR2FFYnMwbEVUVml6SVlxQTFQWmFQdUU4Q1Y1MnBD?=
 =?utf-8?B?dkd0V0h5T0hQbHJiSWNHWVZ5NWR1RktLb0dzT2FUZFp0dTV6a1JCWlJya3pr?=
 =?utf-8?B?QUV4Y2R3blpXRGJUekZtQjhvWDJEMi9QNU5WREgwRVdSZEdKWVJ1cUJxdWdq?=
 =?utf-8?B?anZQTm1wQ3d2aXVkNUczYWV4Ynd5Y2ZuUWZWVG5Bb1B0c1poQ2tQM2Zha1R2?=
 =?utf-8?B?Z2duNURBQlc3WDVIcllEYkFQdXNwUnQ1aFJtWWNVbUxjQ0V5eHBVK1VEME5C?=
 =?utf-8?B?WEJ6dEkxNVllclF0ZkRKZzRhb3pCMWFiZGgwR1hMYTl2ZEZVcGpzU2ZUSnFi?=
 =?utf-8?B?ODg0cHIyOC9CNXkzNGFrWEUzQk1xT290N2tyUmlFcUh3ZVpKVWRYNWdxZWww?=
 =?utf-8?B?YWZ4bEdmOHFIMWMvaE9QL212ZTc5QlFQN0wvSXQ0Sm5ZMEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTBJMmxRRXdEOHFEdlo5aXRPSlB1VFNtU2puQWpjbzJGbTBmWndnckxjenp5?=
 =?utf-8?B?QUtIaGwvY1Z0QUY5RlpJakJGSEplazQ3Z2xXalhVcDMvR2IzUWVibmpQbU83?=
 =?utf-8?B?OThqS1RoWm9XRnc3VjhGbXBsaGNnVnV0WmpoTk5iYmx2Y2p3enhDRjVhaVNT?=
 =?utf-8?B?VnBMMWcvQkJjM05aV1VrczlCSEFnbWQwcXkvR21pcGR5WS8vR0REWG5uQzBu?=
 =?utf-8?B?cjlqbHcveFZSSnJrYUNySERXV3dmYkVhNDF5UEJzNURXdVNRSDJmcHZIVk1M?=
 =?utf-8?B?a1VlSHczS1dZYXZtM2c0VEtpRXRmT3Zpb1NrODR1eVZCVWFpdWdjSE9pWm1C?=
 =?utf-8?B?SlVHcURrRHRSandLRkxGM1R3OXZuRGI2TWE5TVRhK3ROTFEzSkkyV1pxWWo0?=
 =?utf-8?B?cmpwT1IrcEpkSGhFRnZVK1FNRDdiREtROHNlbnU5V09lT2Uwd3JWTFNicUJV?=
 =?utf-8?B?TzNzSjMwWXFXa0JMNlpxL2Z4KzNlRGRxMmZuYTZmVnpvRmRuUlNyd2haZm5C?=
 =?utf-8?B?c3VHeks1S0FBbmhBVzJLMnZuQlljcTdpQlBaMUpoUEdtUjl5ckRzQzRlU0dm?=
 =?utf-8?B?cURNaEhYUXZPRkFSMTVVRzUxQVBRQXpjU0JPVWJSS1ZhREFBV21mWncyV1N0?=
 =?utf-8?B?K2tJMVUyZEo1OWRsUUFPZmdvZXAzQWJUZkpuWHp5NFdIRmw0S0U4NDIxL1B2?=
 =?utf-8?B?ckk1NGhicUk3YTlXWktHeW5VRklRUldKYVUyenZsc1FDZEtpcmhIVVF3VzIw?=
 =?utf-8?B?Q3o5cEdlK01CaDRPMVdGamtDQkZiK0VIdFRVbkdzbVhaUVN4cVRvdGpVY2hK?=
 =?utf-8?B?cjVnTHRoY1lWeXdiaUxSdzExTk5ST1YvNGlvb3hUZXJnQ2VlU0RmNGZxME5r?=
 =?utf-8?B?VmdqTTNSbldUUW8vRnBJeWU0ekpEV201QW5hNXc1aS9NTnNUWFJ3WEFZYllz?=
 =?utf-8?B?STIvcjIzUHpLRm9iWmd2bGZreFlhTVg4QmhjWm5acURrUTUxRTJFUXViUEcy?=
 =?utf-8?B?aGNpMGYxMEFSeTk0VTdmQmxwTlVYU20yZ2F0K1Z5VDNuTVh4dmRBTC9sMmly?=
 =?utf-8?B?YVBiQ3IyZ1pHeUFpaW9UbGpZQXdsWkNFeENwSkpnb0s0MUVLODRRYStFd0hL?=
 =?utf-8?B?YktjOVFPK1BsQXpVTjZ2ZTZCOXNvbXQ4djRUS21HWWlMbC8rQjlHcnhDcWpZ?=
 =?utf-8?B?YXdlR2FlUjQ1eUlZUDV2Q3ZvQnBJMHpLNXpzMTRnWS9BNVNMV0xDVHBnbytQ?=
 =?utf-8?B?SDlpTFZxb3J2USs5MHU5Y2ZscGl2WmZJWEQ5TFc0a1Z3eW43L2FLRnFURFY4?=
 =?utf-8?B?VUtFWHB2ekRpQzdGNEpBNHpOK2VINUxGRmhyTHZDUTZlSXVxVGhXZ1IzaGx2?=
 =?utf-8?B?eWNqb3NNOW1jK1BDTmhzMEhBbkFDeFpzQ0t3Wm45Vk1mSCt3Z2FnT2hSTTIz?=
 =?utf-8?B?Mk1ETnJjRitvcWFOazhvd1p3dmdJUi91NXdDWmtoYXhSc0lrMGFQRk5kUjJR?=
 =?utf-8?B?M0Z5c3FMSEZpbGpWNkEzSW1ZZC9lKzZNakRqTXRrS0QwSVZGR20ySGdGN2ha?=
 =?utf-8?B?c2pTRHZqenBPTlRmUmFhQ3c0eFJSdHcxOU02UGx5WEFmamxXRG96V1AzeEds?=
 =?utf-8?B?dGR1UkY4U2djalRCSDg5UllxcGVwR1cvTU1oV0t3SEZnWGVVWno3TUp6RWdh?=
 =?utf-8?B?cmxVbUFtVk5mOVcyNTZvRlV1TUthcUd0MVN2dDQ0YjJSNFkvVjdoQnpHeFlu?=
 =?utf-8?B?RytnTk9qUGNib3ZpTmxhZ0pZaW93ajFsNUkxSHpIbkZvSy8xczdPYjVqdlZD?=
 =?utf-8?B?UDRoQ0U4eHNCS2x2cEZEL09OeTNGT1J1TWZyR3lISlhldENkVytidmx2ZHlM?=
 =?utf-8?B?bFBNTFlWcThRdEdiYk15S09kV0lVMDAwY01PYTljNFNYczIyTXRtVGd0M0pv?=
 =?utf-8?B?VEluVEc3TURrUGppMkFUSkc1QjcxUmNlUk93ZjBwL1FiQXlZYmx6WWM5Rmlq?=
 =?utf-8?B?U2hqbzNEaWExZnovaFRtajJzeTVGVDhnMFg2TW1EQjYvZm9ZSE1NU0J2NUhj?=
 =?utf-8?B?M1VEVHJaZUwxOGt6ZGVkU2UxWXREL1JCc1hFT0pNL0tLelJCN204SzFlTHFW?=
 =?utf-8?B?ZjJXYmFLdXFHQmxFSWxkRy9yWTdoSjhqV3VkQk9SM0ZvZFhEakxzYzlkKzVu?=
 =?utf-8?Q?KWBeY2K8sPGPRygJVbpixxGWsCo0paTfol/mMjXAbY7B?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	atrev2P2jJTgZx1uBeI5RAZJKGF/DwnIRJgLFxNeOzaY2cJWsLFoXsNRwhxzypDEKj3Jua+6KrgqRdaA1rJYVbbQ/zrfDOquJgNxgRJtRhXyAZzbbi9dBi5FBQFPlv/+Ar+g/JpxRavweiI7+bk4Uejs0s4ElU4gLuMUW+XGfhc7qkt9uvgdBKYbeJl1FGutE5Q7rYRuawH348cv3Ugh0hlEUFmKYzuNY8DNpazBNbQSX/xTAcxBbnzRbkR/NrU1ImLuFj8HEmi2uvw3dVh7GblAFS+2e5y5Pc4U12azv7QFb8Jy49CSNq+L9V2fFho89YP0EhKilWPLqvPtMt4duJQ00Gq+Pb4z0YnooYKQ8UACvr3tR4h5ZVl5dCEiJHuL5HPNsbHkRThAEMfHQMVqPYdkARgCsmWuco+DCMHsTU1smyTyZZF7WF3ioEnyQflxYfaPQ9Z9QONyQSqvHUqCDUz1S8/KQmo621yXIrzOgKY6567oa9pjbqJ8XddAl1oa0sQ0sjcwSo3N/a03IN5eL2mnchkfh9G8L3BC2HTOIP+s1Kfn2O/Ip3OrE3+VbM5Al8MbRiMaLQEW/D1QV/ile9QvSgt7LqNaM3UGrNPm1fA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd55980-e4d8-41d7-5020-08ddd566e2e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 04:00:03.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9wFlAcdB/67+yYiip10OQZYrSUrj0bY7/+i03r5OKYSGIpW0Dvuh08mlDZ76chP2WlufP0Qsoh+sFL42W4bow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFDEB3189E6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070026
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=689424c8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=aVbBT81k_wk0Hh_ecqAA:9
 a=QEXdDO2ut3YA:10 a=_Xro0x9tv8kA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: nmsjPVker7FJdokC12M_a9bjknDpV94A
X-Proofpoint-ORIG-GUID: nmsjPVker7FJdokC12M_a9bjknDpV94A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDAyNiBTYWx0ZWRfXwhZ8Et8U/S44
 pkRYdZUV4p+gcRzLe8v69CgP6OIQ54v/YdVJxG/XbPsgZmsC7vW3WQcszVvs33ZiSS9shP2ftQs
 JnuDf2vlHwdF62ipBANP5fyR/OXn/YZRdVZBciKdGJtuR32GCpws7kG9aveddEwHUTk3MoZyPk9
 VaSP+rpP+9me2bm3+z53hEZ8Zy6E+mFWU0I0FSiR1dFZsykycPqQlmYfEpONnPhZP6ry1oXeblK
 whO9X8uQIXUrhu7rM6mFMlcPZG0YUKc7kJfh4NlsOfWPGFfayzNIHtEXUzwP4ILlqSfP+Y6eQ5l
 aD1NE1+MCWCOfdO5Ns3gHx97ChD/3FsFV8frktbvBls+slg5q7X68z27kiQeqOq4deFQTwzvOPJ
 mJTl/0mWHd8RLQgDeuvS2ovrLhy3bcVNF7R25px2STcV467qKGc72af6ADRtgM/AUm9yVAq+



Happy sysfs discard_granularity is gone.
Testing with 1M discard ioctl() is fine.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reported-by: Anand Jain <anand.jain@oracle.com>




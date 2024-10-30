Return-Path: <linux-btrfs+bounces-9231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEADB9B59C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 03:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14649B22B6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDC4193075;
	Wed, 30 Oct 2024 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZdXKe3sO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xH87mAzd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2440450FE;
	Wed, 30 Oct 2024 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254222; cv=fail; b=cycxd2wEkzbLY1iFFu2ZQxxs0gaaF/PVfyHikmNGTNso21p8CZxQBATxGN1/5uq8OkVGBqOXGomTMvqxJisJYgvx1WjT2D7ChFj+wFKRw/L4WSOP4koX8wGan57exbJUlpVN5UTE/LrhC0Ufqm8MjV8hh/duhLE9cGA6r6LJun8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254222; c=relaxed/simple;
	bh=NlZmpAXzOuVDnJwF+TvBffc4+LsKv0kf7XTX1hku6VU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oowAHRaQ3h5kji8y6mHK9JpZsLP04N1nrr7zoce709kjUUImm+qT09oy4QB0G2DJMW1P9265OBWd0BzH8S+9dyEVWi3nMVq5z/+hpO9L38Qt0h7ksPod4YoSy+u+Fz0VtRM1mpXPAw5G/CACIiNTuf4hBfcYsOqkSIZXIHQ6e5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZdXKe3sO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xH87mAzd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U1fbMw018349;
	Wed, 30 Oct 2024 02:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pOlE9IJO2G85NbMjAdy3Vqg6nGqVKkJf0CGOVlMr89U=; b=
	ZdXKe3sOtyGt+ifNqP0OZV1Ezo52E95CcyI+Dge9FQ+/xpidoAXqZ8dL+BMwJ2X4
	ereJR+hpjqJY8MaJsnIYkztJtz/eaQ8MHXaZIatSLVr9zUZv0dXvChlogUUvS6qO
	F6s/2vmSFjK9LkXsoKZXd9NiWtNyJ62CdK9AGQSP2MuBJzQL89o/L6mctEVmhJke
	Zvd9Ei6UHpAFcHU0y1uEyGhZWHf7F9ESdrYFYNVFR75scxkNhBt0XDlm0uOitaMt
	4hAk3Wwc/erAaZhgz7GdWtl17sCmfd9lgd0Ie7Y2zVEZHTfqqYrO0FseK0rXXSic
	tznh3Tkxt/VpsY9rPpNUAw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1xvdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 02:10:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TNHdd8011821;
	Wed, 30 Oct 2024 02:10:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnaddfd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 02:10:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crgVeWizE4XgEebxCT72sOc/YVok8cJ0cxLAFIFZGLB7kFJ5yKtG743urVpYj2k9Hnfjmf93FVvhp0/EL1tBxwanJY84XcdzVk8c21SS4S3152yL6d3oFTHFkQj8eUlYW5r6Ay99mAG8fAkhn+D+7JgecIrqmdo2fCb67Oy8eZypz6qk9XkPDFU7yQChP45/XZzdxSTXcNza7lrVKDIXQK6CdhYHTmS9uFP+SB4+EqhMgwn8IvKmMjg9xoM6zWAdrWFPro8CB7YVr8VmoGGejNvuRl55enpHhh/9CF4rZYiX2zwgrhYGaWpWYToB5ZX67DLSi7pV7eNXPuVAI3fGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOlE9IJO2G85NbMjAdy3Vqg6nGqVKkJf0CGOVlMr89U=;
 b=Lqllku6OVLGKhR+Wbw2lgFWlZPUcbpGH1tz7gbJiEE0Y0BEJw3Ujct5UeTpM5nSFYm6BRWuATq6RcgOa7diRgv/A1kl6A55tW1I18fdT5v7Pf/bEheHXKDc2trdA6/czCFuGqwWSuREbO2nEVhbI0pCYSieuBKI95Z+W+CXuZTifzjluQPWNEULA3NEN5xQTxnyIrwgYMOrVb14ZEt7Tij/nDWZFgAkHrGydbQJ+Wn/BmDNSXgTA9i5fyTw0Mw/kLSF2Mj5TGgTJWA9gVc+Fs6Dqb5AOJmstHv8Gcygez83q/KkyT65doxG/wdYbdp1G+5BeQ7O0uIhxEZFZbXpA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOlE9IJO2G85NbMjAdy3Vqg6nGqVKkJf0CGOVlMr89U=;
 b=xH87mAzd0goHUNJgeTcwDnDMpTALHodnwG1JdRO/dILhDyfwqBotMx99F6XTJWDTvcRCMhdY9QDPew6Pn44Wy7k9xUy/6k0viT1/8WwGGJCyRhITMFbiyaTntVcr7mZ9uDaMjqU0V9imMP23ZlwY51LNQWqDJCg5Gt0iYTwOv6M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4338.namprd10.prod.outlook.com (2603:10b6:a03:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 02:10:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 02:10:11 +0000
Message-ID: <49e0218a-4b57-49a0-995b-abe287bc3d84@oracle.com>
Date: Wed, 30 Oct 2024 10:10:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/287: make the test work when compression is enabled
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <9991dab5ca241c17f531f49dab5dbaa6e9146c45.1730220754.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9991dab5ca241c17f531f49dab5dbaa6e9146c45.1730220754.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a83970-46b7-4e58-3171-08dcf887fbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejN4ZHZTdjJzVWFwMEVFMjJ5cVlkSEh2Y2RiSFV5eThvOWdqcXlCYnh2VVB0?=
 =?utf-8?B?TzQzTnpyNTBzUHE4SG9tNE9kTFJTTWN6eUtySHZDekRkeitQTVZ0d1FKb2tP?=
 =?utf-8?B?VUFxNHVrV2l3N1kyQmk1OU5qTXphVmpnQ3ZaVXlxYVJ3bDNhc0FiMFpacmxq?=
 =?utf-8?B?R21WaWthc0k0UnB1Y2VubmVtNDdpZVBqek9tenlzVldKNzJHUktrYXlkaC9P?=
 =?utf-8?B?dUZMZDBjUDQxOFlma1lmQTlGV3RqTmcycmlyaHB4dEdOYVN4clJleWNibk5V?=
 =?utf-8?B?ejZrcVlVbElmYVh2WVFqU0RnMlpsalpoakNSTTBJeFNVKzAyRmVhZzI0Vjl0?=
 =?utf-8?B?eDdyaVNuem9qL2ZabVlsVkYrc1hKVWZUQlh5SEhRSFhnMUI2dWNNN3ZPbzRy?=
 =?utf-8?B?T01JckZvQjBNemczcDYzWEM2QmJUMUpWdHZTV0tDQzZuU0lvTVBsVnJhZ0pR?=
 =?utf-8?B?cUk0Mlg1SzhYelFSNDVkWnNzM0hrTHBsRW1aQ2k4UXZOSW1nWUp1YkFEWTE1?=
 =?utf-8?B?MkRBNnFORG9SeWxtTk95QzRTL0hRZHdhR25rMUxrU01RZmNuaEpmaW12U1g2?=
 =?utf-8?B?cXhaUldlYm5qMVkvOWJHTEloZ2JUT2FFZm93TUtadkw2Y0p4dzc3eUdVNnAr?=
 =?utf-8?B?eitUY2Rwc2dYbTNFbit4b3hpT0ljT2tUZnh4ZWc3eFR1OGN0aGlNeXNCRXhC?=
 =?utf-8?B?VndxNkdiKzVOSmx6V29LaVpMUjdTalBZcElPbnRURE5TeXRaTGFRUGJkUVJ5?=
 =?utf-8?B?ajVnajYxaFJxc2I3N2g4M3hNaEVaTXpRdkFyTWN4YUxqYlk2K3p2cWRWTGkw?=
 =?utf-8?B?b0R2RTUwUWE5enFZMkNVeCt0dkxBQkdmcHlRdmNHbEpyejk3QVl3UVFzRnRy?=
 =?utf-8?B?L29nV29FZThXZ3VKZlR5enE2UXc3SndFQlYzU1phQjN1ejU2M01LSXFVWUly?=
 =?utf-8?B?TkUreUJxT0tuNG5wM2hPYUpXdi9GSlIwVlRyVGlJZXRTT1lYSStVblNhamdX?=
 =?utf-8?B?VzU5N1B4c1lkcjdtSDZxUitQVXF3TkNpNnNrQUp4em9sMUFsMWxEcXRLYVpq?=
 =?utf-8?B?N0pJdkJ2MzdDVU8wQ3dvU1ZITXZpNDAzNWR5UW9tV3hzTFphU0hKcXFaWldP?=
 =?utf-8?B?dDV0SmNpL2Fnc2xoWXJvS1FBMXBQbksxVzk3MnAzbytKR3hsMjg2QlE1Rkt0?=
 =?utf-8?B?ZHRwUG5sc3FObDR6MHF2NUxTOXJTSnVPU01RUTd4cURabnFTcmhaZzM1bVM2?=
 =?utf-8?B?Tm5EekVNUWg3RmVPekZaMXJKQzk4Nm1lNExCSkRvY1hnZ3VCc3drSWVTNDBK?=
 =?utf-8?B?Vll4NFl1M1dwenVQRWhtWnU5ZE5wTXNFK2Ztb2lEdk9VdlRyeDZDVXpKSmx3?=
 =?utf-8?B?WEF0SC9SZE5YYnhmTHRjWUZNTjhKM1ZwY3dFWTM1Z1cvcUFVWkpKV3dZQTFY?=
 =?utf-8?B?QWV5TVFjNWF5WXRpdER4OWhNbklzdGlwS0hwRkhyTDhrQ1F3d09lcXJXZk9v?=
 =?utf-8?B?OFVuTUMzQisvVDZBNk9MU09IeU92R0VRVTVySUNmeFhQTk96WU1wK2dUOXRl?=
 =?utf-8?B?dzdwV2tkY1Y5VUg2UVFraFJYOG9BTkQzMm5hVmNvVzhSWlA2Z2RueDZ0NSs2?=
 =?utf-8?B?RFhtOUJvVmZrRXoxRGZ0ZkRIcmJPYTYyb002TjJHSUpuMXdndjIvcUZkUmtp?=
 =?utf-8?B?em1FSU1la2FIMVQ5dmpZYkRQOEZrdU9uNWlrSko0aEx1YXUzK3AxWitCd2ow?=
 =?utf-8?Q?F+ri6dzdG3zXX8y1zQo8jKw4QQwP93F+oRKYIl9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkJzUDAwdy9Ib3pzRGRXb21OLy83ZThlRlA1cnRpWjBGQ0VuUHFxKzJmNkd5?=
 =?utf-8?B?YkRwSGtmYzJrZ08wdW9HVVBRVzJMei9WaFYrc2ZaOUxkdGRWZlBSODZKN1ht?=
 =?utf-8?B?ZERSbnJMREdsbFFSZWdHcGdzYXFzb2swV0lOREg3eldVeXE2ekVaK2Y2NGNa?=
 =?utf-8?B?ZkM2cW9kS0kvK25oenF0OXlWaDM4cmw2M1dabDhYMjErSVZVTEp6ZkgrenV0?=
 =?utf-8?B?anRnaWFFTzY2bllBS1R3RzF1a2NEaVBYd1R3TThBOG1UUzBSbHlZeDN2VEpv?=
 =?utf-8?B?b3gzTGJSMEZ6MlZIS04raHJ3akloVWYvdWtPWkUwWE85dEl0cTdmUnREQndP?=
 =?utf-8?B?TmthbjZJVHc5Mml1TzJ3ZmNlMXZlTll4ckNHR0VQVDJRdU1FZUxDMHJ6dnJR?=
 =?utf-8?B?SzNmZ0YyMjdLKzY5cWNUS0xEQlNBUENncU5FWmE1ektTbTN6V2NodlFjemVu?=
 =?utf-8?B?UDdtY1NPSmhiZnk2K0JLN2llK1JGVmRWM2MwdlpqOWlCZlNRKy8wcGxTVXBa?=
 =?utf-8?B?MDRzVVdOU0xybVNJZFFOcFZXaDB0cXZRQTkxaGh2UFVnWHBXUG1sNG9JMWRF?=
 =?utf-8?B?QzVhNm92Z2pyZHJSSVBIZTlaZE5ubjRMQlA3V3RkRG5YOXlGeXQvU3kxbVNm?=
 =?utf-8?B?ME5PRG1wdXJhMFdFbk5ycmhqSkl5elZUWkUyNXhSWityTnJKMXF3K0wyaWd4?=
 =?utf-8?B?RWhKb1BDcnF6eklWU3FJcis5Mm8vSFp4eWRic1VBRE9WaWgyelBERjlTekJD?=
 =?utf-8?B?TE04VXd4SEl0VE8xMVdMRVZoZlFKczdWNXlodnBIYThCcGt1dWIxRGRjbFkx?=
 =?utf-8?B?Y2VWS0ZkMDRKSWpBSS83eXNjTSt5NUhSK1dzSFQ0eEZKaTQwVkdsbFNLOUNu?=
 =?utf-8?B?bjFBVm5GcDhLVGcvYkx6dVB4akZObnlTNmUwQ3FVSEN3cUxBU09HdDdaNFdw?=
 =?utf-8?B?ZzNxSnZkdGptTVhRdFlEUkt4aXlmWXljU0U3UlNGWFk3K0V1RGRwOFhjZHZ6?=
 =?utf-8?B?Yi9zRzFxemFLaTBZWDZFeTZ1UXhQNGNXVmZDYjhZY3YrR0J2M1ZhZU43RHE4?=
 =?utf-8?B?S0pZRkdQS0UwR1dKci9mVUVnV2x2MTEzQ09SSnJJRG1jT0F3a0F5SmtVSnFE?=
 =?utf-8?B?QmhRelJHVDJvdVMrczF0RTl0Sm5BOWhDdWxKV0hqZTBkamJkRlRUQUZ2L2Ji?=
 =?utf-8?B?ZER3Q1FDYzZ3ay81RkhJaWxid1lHSTJyNm1mRll3SXY3WjQ2YVUzVHJ1Z3U5?=
 =?utf-8?B?S25ja0VXdXI0amZUaEFQV1JGblF6cHhQVkRtR1BXR01tQjk3cDY3eEJ0UmlH?=
 =?utf-8?B?dDJZWXEwbEw2MEhvWkJqWi9xaU8zV3lOaFhncSs3bEJMdS92R2dZeEZMbEVt?=
 =?utf-8?B?TldFNUpuTGNJalNGYjlsTmdBMjNMUVZrZFRmbjZmeTNtb2wzdzgxTHpJOW1L?=
 =?utf-8?B?SFIvd3ArdStrdnVHeWYxSFBiUGZPYXZ0K2Jpa0JXYjdhWGMzR3dBdm16eUlH?=
 =?utf-8?B?bGQyR0dGTGUvdnluV2M4b01hcFJNT1BqQnU0MGN0MUxRSm93TVNFeFpaeDdE?=
 =?utf-8?B?NFFVUHUzZ0dkL2NDNWxFWVdIbERmYWtJUm9HRUtmZTQ2Wlc2aDlvSS9mc2hN?=
 =?utf-8?B?T3F2cEpUWUxCelZYd2lIT3BFZGZ3c2ZWYzk0cDlUYzBvOUhxc2NTZU5YT2NT?=
 =?utf-8?B?ZzhGTUpPRTM1UnRWaHJ3dVRnSUplRk4zbW1Ha1FMZGNWVUZUL2o3bjRqeklE?=
 =?utf-8?B?THMyTHpwVk5VZlpLUHFJdktJeTcxTFpUcEFlODhyWkZHV3YxenY3T2hScVJm?=
 =?utf-8?B?OThZamJ1MDQyNWx3enN5MXN5eDBhVnRmUnBMZTZuVzNoVk5CVnI0bEJoSE0r?=
 =?utf-8?B?WHE4ckFKWDZFZTMxYlNTcDBKZUdWVzhKemx1TVdkSzlyTTJiYzRyMWhMYWtz?=
 =?utf-8?B?R2xOd0ExOXViZTRrdTJoRmx4bnE4aW5ScFdpQktPVjBuK2hRVU1PVGk5WDRm?=
 =?utf-8?B?QXYzSDRPNUVzRVJ3K01GVURyWXpFbXZWazRSQzBKREdDZHpTUzZVTTN5ZEF3?=
 =?utf-8?B?Z01ZV0JHU3FoV2FNdEd5QlpLUGF2bVpHOEh6M0JRbTJOVnQ1M1cxTVZjUkRI?=
 =?utf-8?Q?rahpzCuqgO5WRkJm3nXlsQkRg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cl3Vnu7PWWBCKjLhnwjip5Ic0gJXwBa1WjC0NwB98jcDU0wf/KGr/pT5w/94ON87Q702x9WML7HfkzB4e4AbCF3HOu6o9ercTU8m2vxgfnvKvDOkL+6AI83cd/wq7fwQk4WafHfqJmD7cjvwYmODCz7aakB+agQwyxqWEPqEzovcq2M6nvTXEoZ1YbRJEMbpjZTrdx9NNzU5+gTp+sO+sAnRCde7vK2Z2U8HJp6VM3cOkDD6Ush/ymizVtlmbck0Q1b6bsKJqxMU7ae6/BLVLoOv0xiY14oXk5/osG5ZW1zIQXfKyUmcIIC68lDQMIC/lP0Y3SHaxuI+NOvbJuP9BfC4P778XZQtdeb4+vC87GG0YU6cZbnhMiX6vee+fdbq00BHe2RSLFn3N2Kx9wz3h3jGyQgFtyWsUdwSeDQVa1tz47aqtnoNrdtpxv8rTJ5GqIhMWwH+x1YiGxp8bqeXUZJ3wQm6CIyFqDHkHYRwGv25Y/k8BA6b8xXfops+itEF6ENCxtRApfpAii2F0nK5l52O/t220WN+ZeaYgnWcQjzxrH+yTF10w9iUuRMTBV+GmxvzwLBSw4rH6kIGFo4gUwyaqi5WGVagksnkNVkQpWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a83970-46b7-4e58-3171-08dcf887fbc3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 02:10:11.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hL1mM12Wln/8BkIEllv8bYf/T2b09UiBn7JzPnlYaeme+pyhsa5LtNThDqSDdbH0Xh4aKN6lv6xaSNESWQE02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_20,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300016
X-Proofpoint-GUID: g041GIZ__sYgBsquVVo2HP6_zLPdMWgj
X-Proofpoint-ORIG-GUID: g041GIZ__sYgBsquVVo2HP6_zLPdMWgj

On 30/10/24 01:21, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running btrfs/287 with compression enabled (mount options), the test
> fails because it expects to find 4M extents, however compression limits
> the maximum size of extents to 128K, breaking the tests' expectations.
> 
> Example:
> 
>    $ MOUNT_OPTIONS="-o compress" ./check btrfs/287
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.12.0-rc4-btrfs-next-177+ #1 SMP PREEMPT_DYNAMIC Thu Oct 24 17:14:37 WEST 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- -o compress /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/287 2s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad)
>        --- tests/btrfs/287.out	2024-10-19 18:21:30.451644840 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad	2024-10-29 16:31:20.926612583 +0000
>        @@ -25,22 +25,14 @@
>         resolve first extent with ignore offset option:
>         inode 257 offset 16777216 root 5
>         inode 257 offset 8388608 root 5
>        -inode 257 offset 2097152 root 5
>         resolve first extent +1M offset:
>        -inode 257 offset 17825792 root 5
>        -inode 257 offset 9437184 root 5
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see the entire diff)
> 
>    HINT: You _MAY_ be missing kernel fix:
>          0cad8f14d70c btrfs: fix backref walking not returning all inode refs
> 
>    Ran: btrfs/287
>    Failures: btrfs/287
>    Failed 1 of 1 tests
> 
> Fix this by creating the two 4M extents with fallocate, so that the test
> works regardless of compression being enabled or not.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   tests/btrfs/287     | 10 +++++-----
>   tests/btrfs/287.out |  4 ----
>   2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/btrfs/287 b/tests/btrfs/287
> index e88f4e0a..a51b31ed 100755
> --- a/tests/btrfs/287
> +++ b/tests/btrfs/287
> @@ -7,13 +7,14 @@
>   # Test btrfs' logical to inode ioctls (v1 and v2).
>   #
>   . ./common/preamble
> -_begin_fstest auto quick snapshot clone punch logical_resolve
> +_begin_fstest auto quick snapshot clone prealloc punch logical_resolve
>   
>   . ./common/filter.btrfs
>   . ./common/reflink
>   
>   _require_btrfs_scratch_logical_resolve_v2
>   _require_scratch_reflink
> +_require_xfs_io_command "falloc"
>   _require_xfs_io_command "fpunch"
>   
>   # This is a test case to test the logical to ino ioctl in general but it also
> @@ -42,10 +43,9 @@ _scratch_mount
>   #
>   # 1) One 4M extent covering the file range [0, 4M)
>   # 2) Another 4M extent covering the file range [4M, 8M)
> -$XFS_IO_PROG -f -c "pwrite -S 0xab -b 4M 0 4M" \
> -	     -c "fsync" \
> -	     -c "pwrite -S 0xcd -b 4M 4M 8M" \
> -	     -c "fsync" $SCRATCH_MNT/foo | _filter_xfs_io
> +$XFS_IO_PROG -f -c "falloc 0 4M" \
> +                -c "falloc 4M 4M" \
> +                $SCRATCH_MNT/foo
>   
>   echo "resolve first extent:"
>   first_extent_bytenr=$(_btrfs_get_file_extent_item_bytenr "$SCRATCH_MNT/foo" 0)
> diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
> index 4814594f..48541f7e 100644
> --- a/tests/btrfs/287.out
> +++ b/tests/btrfs/287.out
> @@ -1,8 +1,4 @@
>   QA output created by 287
> -wrote 4194304/4194304 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 8388608/8388608 bytes at offset 4194304
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   resolve first extent:
>   inode 257 offset 0 root 5
>   resolve second extent:



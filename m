Return-Path: <linux-btrfs+bounces-14127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2452ABCE71
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 07:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753ED7A2955
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 05:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE38425A626;
	Tue, 20 May 2025 05:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Kxx4gs9F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012033.outbound.protection.outlook.com [52.101.126.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60098191F66;
	Tue, 20 May 2025 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718050; cv=fail; b=vF84QZheO6q8Ze1sBbvo6M8at5ehFArFTIqikk5prHZGlj0O2gMOl8gf8ehOAMwOaE/DpahcebJDJSZKRpd2/MVGKxLt6lsHB23WvoqslciPPLGIqt1jRdGDydBDNHbq19KVY/iS691lfZZRutVLLLwlTZg9PRtRrbvhbU8Snkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718050; c=relaxed/simple;
	bh=oNK/Rk44xX5I5HlL5LQGc+58DUZpaEZwSIGH8+9zCq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VpY6cXefhPnImWtrI2AoAONQJv4ARLhlNFmYRjTKtUIaWSdE513JTvtFyixqYfpB2GGrQDbK28YnIG9VSXHNdEQS9egui4M6D2nWH+2qGu2/+3+pIB7GUX9Apz4A4RHlcwlO0cZ7bQe4Dqw65RTEGTi9thV3fpoPv7boEbci5Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Kxx4gs9F; arc=fail smtp.client-ip=52.101.126.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BM+31FytaN//uoMx3VRIT3Zhtx+mf9XWTP80mhCKqP8GZ/+qN6O5d3JOlxfkHHKsa/SnBF41a/wyC77nmatfrWlfmd1nRNJM1u5lARQqK2IGwt9LqMgSik2umCHlegVjNby6lt3fBo489Je1iSAOrdtUD8kf7Sy60IKVa+A8U1LTl6QamOLVr7NtEX6gxdNM7UfJoSClcXYA9de2ujw/XJn/vKTY35JT1cl3LpIxukqqHap8q38WIvvBPudoS7hk9mSOw+4Si4B0bSQXB+1Pl+MaZDL1uJ2PFfS6yswdv6ZoKeZASYBEGAmPZE0agtjLVq+HEAncJwoW6ZYM5ZMj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNK/Rk44xX5I5HlL5LQGc+58DUZpaEZwSIGH8+9zCq4=;
 b=KqcgNp5PtMLSXMW4rADGV3XzpUBOAg5Po0VUgLmiTaIPZJO8UqlyFuwnDV+5v12pBWSBsrwZ4Y3u+VbWCnLOY/mvS9DBb7D6mX7IekwHABPiRMf/7P2jdMQVpyQtwJhO46QDgvZYeWeAAKYuXdT5ShPVpQGPgVAKvEXz8DzokStBVxjwCTG8QoM3zZtRMX/24+o2MH5ns6WJeg1sDDKp4TaGJydBf6cRAMKSftuo/kF8b0+yDWsRGqjjBv1nx3XJqA5KDYYxqJJTdBrtfTjAn69oK3zcAByvp1vUj4LHLTOz0N1xQIMT91tFzpRfZZOeTfaPeNfG+OS9tDwTL/Hljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNK/Rk44xX5I5HlL5LQGc+58DUZpaEZwSIGH8+9zCq4=;
 b=Kxx4gs9FVIDxZ6NaVWy5XjXyoUkePkYoNRj9rmcYIZz05x8+IJZOhQAVkO6/aNSMUTIpvmXVr7B+V025OqWHXhGwhpI4+ZNRZxCZg5lf+Esq1gNMLXPb/DjTGrjbaMTvqU7t7mUPD9Kc2zx3l6G1rJmXpFHjFBWm19hEagJuYw6a8bKyGv0xsuLu546fLgNDC2Mjl4yNr+uuizt4s91C6o0az/zsGJAEP9n4d1BevOhw63Nt/evRMGGcQGkpzJUEY/uREvIo/S/n9Ex+GBC0/UitjUh5yUa0zPqnIMIlUE+eaNDIeaWLJKUslYXIYDPRVkIye+pmv8m+oP63R2ms2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6488.apcprd06.prod.outlook.com (2603:1096:101:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 05:14:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:14:05 +0000
Message-ID: <098cfd6e-83c7-4b7f-aeff-7199b751bdb7@vivo.com>
Date: Tue, 20 May 2025 13:14:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] btrfs: update btrfs_insert_inode_defrag to to use
 rb helper
To: dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, panchuang@vivo.com
References: <20250422081504.1998809-1-frank.li@vivo.com>
 <20250422112137.GA3659@suse.cz>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250422112137.GA3659@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 6877fa7d-beec-4f4f-9600-08dd975d2419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blNxRm9zOG9oWndBMEdhWUdabTRBNCtjYk0wUUpMb2FvdFNoOStzWDFsK1dM?=
 =?utf-8?B?YWxrWDhrSjQrSHVVelRDZWl2N0d6Y0dxQ1ZJd25uWFk3TDFPMkZONlJFdGxD?=
 =?utf-8?B?TExUSllVeVMzWkwvU29Bck9VbEVLaE5zMExGb1MwS3Ezd0VGYjVnbi8xMk8v?=
 =?utf-8?B?K0JuOXB0VXhxQldBd3pvY1RyQ2hSZVVseGxSOGNKaGlFWEVzdWh1M3VjRkdV?=
 =?utf-8?B?cHFRdk45cTE4SnkzU3JiUTQ5YkNndlJBazNLOW9IeVJ5b0VoZFlTT2FIYUxw?=
 =?utf-8?B?RkgyeHdCblBINXRRWUx1aFlkMmZYUmkwNEQwSVQrelhVR21yc01JQWhNZkJz?=
 =?utf-8?B?L0ZxOEp5NnJnNWVlYVFKcDY0S052YjJESGtTeEIzNHpNWVR6Vk0rWFg5M3BE?=
 =?utf-8?B?anNsRjJJaGFDdEtFWE1ERnVrWDZPL2t0eGl5OWZiOHBBVFVwZGdFQ0VrYmFn?=
 =?utf-8?B?WHRUTEtGUVdCZDh4aUZvU0NjcUJvWmVDNnFGM2Y5a3IwMVNDZ1lwbTF5ZS9X?=
 =?utf-8?B?QWgvaVRCMTFPL3Y0SXU3S1FkbFZBNm5xQUJIemlLMDl1OGxjN2tCSWF2WEVW?=
 =?utf-8?B?eDNqaXoxVmVVQ2JvTEQwTUNLdEFrZXZITjJmaERBTlVsZ0F3dWsvWmdwdTIz?=
 =?utf-8?B?aTNPTUprZVNUbzM3eVVCNmVZOSttclF2U0N3N1ZLZ2FJR0w1cnN4VlFlbVRW?=
 =?utf-8?B?WjZxUGJSdDdNYzM0cll3cU5lcEpJdVpwc244RzF5S0wwUEI3cHlqa3RmdGhK?=
 =?utf-8?B?enpWRy9RMHFqYjdFTzMzWnB0WUpFY1FDZjlqNGNNMEdsTFNlOUZpMkE3cFQ1?=
 =?utf-8?B?SGR2bmdHVmw0WFpKeEo2Qi8xOHU0cjYzelZxeU5KNkpxSWxEaEhwQ280VE1Q?=
 =?utf-8?B?WmJhNHpxTGdqTWl1dlRjdnFkL0lReHFzMHhmS1dJRE9nTHB0enlRa0ZVZGNK?=
 =?utf-8?B?dC9Zb2J3ZnZhb25hS0FtWE1QZFlHZ0dYUndtL3ZzeTR6UUFsZElscVhlclNn?=
 =?utf-8?B?VkpXaERhbTlZTjJPRWs0dk5HTmJSY0xCc1MrbDhBMmdGd08yRlVkTnpYNnJx?=
 =?utf-8?B?YnUwOHhxQVpYWTFsNis5UklLUXIvNExqY0NpYnl5L2dsZi9aeCtLY210NEhK?=
 =?utf-8?B?a1hNWDRzM1RSbzRLZTlSa2tYbXk0dmZwQnNyWElNMGQ5czk1cE9tN2tmdWRQ?=
 =?utf-8?B?ZmJIdmc3TGZsMHUvTjNmK1ZQTWNjdnpzbEYxUnVVNEpKbzZwZHlvRzV3QmNY?=
 =?utf-8?B?VUl0aHI1eXBYNWJNOENqODN5M0RDU3NNcVRQZDZKbnJpRUF0Y1UyUTZtcFV1?=
 =?utf-8?B?YnRyRXdtU3JIRytObHUydGpZZTMxeWJTWEZybkNVdWtlSXA0OGo2Z1prYy9U?=
 =?utf-8?B?czUrRE9waksrTHNBUnZBV3lCRzFpdWNOQ0xVRmQ2UjZ3ajY1L0ZuSnp2Lytk?=
 =?utf-8?B?VUhNcnNSSTRUTUoxNDZCVFRzTGV4aHJQNXp1STZVemtPTUt6b1V3bGVxa29o?=
 =?utf-8?B?d3RkeFJNVFMveWZIb1ZaRlhLWU5TYVU3K0plRFNMT1luUDRZd3ZCTzNMaENz?=
 =?utf-8?B?YzNFbkVaZFQxZW5XdmFUYUpaZjVlOUlxblNnK1pYcGVoWXRydG1BL2kvUEdK?=
 =?utf-8?B?Tkp0V2k1ZjVwSkJtcGZDWFozOWZwNVc1bm1DN1lRUXNDNTF4emR2YUQ4aUdm?=
 =?utf-8?B?Sm82LzZocG1rLzE5OW5yQVZjT1UxSEk5NmFOVExtd2IzZFNiTWJjYUlIMHB4?=
 =?utf-8?B?bWxSZHFpMy8wUWZQenpxeVhIdU1ieENmQVorcnFuZjNibCtoNThremdQNmxn?=
 =?utf-8?B?aXBURFhEdU1nQ0t6QVpCUktEdkdqR0RvRnk2KzJRVE1GRnFDQlFSdDROWHNv?=
 =?utf-8?B?WkxLRExsYVptbThsMHc4Y0I4Z3poU0RsM3dxQzFxMWZMVW1FcFdhaFdtOUFX?=
 =?utf-8?Q?lXSyfGPe0Ik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFZKbWhGK1RyNFhYN0VORUtFbmtCY2Z3VlNUYWRzb2sxVmJQVDB0eUh2OG8r?=
 =?utf-8?B?d1JFNjFURS91bjByaWIrL1pacUFBdE50RmpmRW9GcmdQbkhVTzZyeTFRK1Bs?=
 =?utf-8?B?QVZqWS9pWCtscE5vRFQ5V05XUWZkbkd5L0pONysyMFJZL1lrbGRDVXlRN3ZF?=
 =?utf-8?B?OUY3K1V6SGZWRExmeXpYc2toZk1Xeng5ZVVmcG1hUWZCNmpTTXRSVU50TXBO?=
 =?utf-8?B?S2hrSlNsMTFySGVYMmVqRVY4Q2szNmt0UUh5eTEvSFlkWTh3REZIR0JhSGpt?=
 =?utf-8?B?aVdYWk1DcllmSE5BQzF3Y01Tc1g1blJ2eGMvUWZpZ1R1akJHbFg4cGZRdGt6?=
 =?utf-8?B?VG9SVTVPRGtzYjZPczhLLzlKNnczMStCa2xJWjdzMGFNa1lSREpNR1dSeEJq?=
 =?utf-8?B?VTMvS3ZMWHcyTHBsTmdncENPdFlabGlFMFROWHpyUERtYjVtc3VVTGhEc0Jh?=
 =?utf-8?B?SUJ6UkloTW5HdkVIZmF0U1k2ZTNWRFFvMEtFNlR1YkpwYVNNb0s5N3FuR2tO?=
 =?utf-8?B?aWM2ZGFuTE5KcmNEMTFxdG0xOGk4QzJ2YnFDQnFadHR6NFlYSlRhUkIxejd1?=
 =?utf-8?B?VlhoS2M4OW9GTWpWWk0rTlhEeGlUL0dMRnJQLzNrY0JSYm1RTFNxZ3IwcEpO?=
 =?utf-8?B?U2dha3Jnck4wR0Q2NE50MUxXV1gvVDRmbElWQWF6YWthVGJ1YTI3b0JKdFV5?=
 =?utf-8?B?NWUzdFY4a1dnRGJ4YUNvZkpPRHVjejFHaEtLcFZlZTMvQTVzMkVHTHhVdUNY?=
 =?utf-8?B?b2FuYThiRGlybnhSVFZKK0wrdmhhS1pQUUpTS2NnNU5zRnhRSWxwNC9Cbmly?=
 =?utf-8?B?ZUlySGFiZkw3QUZTZWhuMnV6UkUxQlRrWVBBL25ITXZSSWV0OHU3UkFIOFRa?=
 =?utf-8?B?UjRjWUQyTDRGR0RZZWJVbHdJbURjYVZEcGQxNWhtTUhFOE1zUFZyckNiZzVj?=
 =?utf-8?B?NmFlcjVjQXdiMFVKaXpyUll3Rk5qbFhRd1g0TTV6R09jb094Wk9Sdk9qdDFy?=
 =?utf-8?B?bENFdmJUQlhaZlM1Z0t3dGdNd0tpSmprSzkzQVpPRGV0cjNGN2V6eGRiaEdI?=
 =?utf-8?B?L2FTNno0cmd5QXl2T3pqUEk4NUwzb2FkNk5yMFdYcGZsaWF6Tk00T0cxdWJP?=
 =?utf-8?B?bnpnTGphNzBqR1BKQTh5WHZEeHo2MDBnSm9lNnM0NmUvaUkwNTRZMGFJaTgz?=
 =?utf-8?B?cDdnNFcvbGcyV1VQUi9ENDZxaEtDZ1JwRzFBQ3pwb1IvWWdHRDVSWTkzSm9w?=
 =?utf-8?B?Ky9uZy81K0R4OHY2UTJZd1I2T3V5UXlINVBZOVdIZFF4S0dMbEkwbS91bU54?=
 =?utf-8?B?akROeUZrRGR6YkhOKzIzcFZMcDRSVjVPT0I5d2I2VHo3RENLWWwzNUFONUFh?=
 =?utf-8?B?NloxbEZNdzRJQ21qLzdQZS9zNFhneXFoYitoczdud2dTRVZ0MzNOTUpXY0Jo?=
 =?utf-8?B?dW5EZEZ3MXJ6aFlMRXdyL2swNCtFbEJRalVoUWhVUVdobU5KU2FGRytveXdR?=
 =?utf-8?B?MVl0bGpZNjdYUmVkZFBuN0EyU2VhQ2dKeGRUZ0k1bEFjMTRCMFA5NXFFc1V6?=
 =?utf-8?B?akJndDNvMTNycU82aXAwQ0dCMjRNc0MyRi90dzQ5Rzk2L0wyM05UcTFpczFp?=
 =?utf-8?B?THRjNVFTSk9CUUw4Ykt3eWpNOEJMMDhPWUorTGVFVitSYkE3WDBnbHFOd1dm?=
 =?utf-8?B?bExMbmRQYlEyekV5ejVRb2RzNnV0KzVZMGsxRWNUYW1xOHE4aTRIOWJ6MXlR?=
 =?utf-8?B?Q001YWtnekFsVWN6NTRRRFFMTGkvbSt5ZVp6S3NrU2YzTUtCbm16RWc0SnA3?=
 =?utf-8?B?K0lmbVlMN0d4S3U1b29vQ1lJWGJndmk2Z3lCSk5RMkZ1bGdGZ2thSzFEb05V?=
 =?utf-8?B?SmUrWFl2Q0s4WkhJV0pvbnZuQ2ptNWFNVFRqTWR6aFZnTFF6UmJUWjZhQ3BO?=
 =?utf-8?B?VG83QVV4Wk9mZU5rZFM4bEkyZlhyVlYrMlJNbTQrVnpQdjVJbXJGRW9yUEZ0?=
 =?utf-8?B?a2FUZ09Ka2hUY1NBZUVWai8vVVhOZTJ5S0pTYnNTUVNhM1E3ME8rbDNJM0Yx?=
 =?utf-8?B?RWY4dHJMQlNnaFRJUWcyU3NkWXdPNzEwNEpxRGRqL3ZicmZlUnRvY2pLc05D?=
 =?utf-8?Q?uaaOhpVVNN7GUnM61/SjxtVBC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6877fa7d-beec-4f4f-9600-08dd975d2419
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:14:05.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEFuAIIVInIdmBb69KiNRerFKhe7E0Rw9hoSKJKkRgQiuV52VLWlmfp6AB//p7vMz9gpaWZoXDVysNW07DJgEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6488

Hi David，


The new patchset has been send. Could you please consider taking a look？

https://lore.kernel.org/all/20250516030333.3758-1-panchuang@vivo.com/

Thx，
Yangtao


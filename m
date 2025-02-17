Return-Path: <linux-btrfs+bounces-11508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2388A37F9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 11:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE393AA858
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3263E217641;
	Mon, 17 Feb 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="FVCmEIyR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19010011.outbound.protection.outlook.com [52.103.64.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F01216E1C
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787309; cv=fail; b=FW9GSRlOibTYphiF4CboAf40XzV7l2lu3I6vy30mpyLrir7pyHkp18j9q5TCjBJU3mhRMM2tA6rStam709eaDyfg/OsHR9aRbXw/JxchPG4MgOKYCtE+L9oCv/MAf2KWytHf/Osszu1FK8rrGci1rjuI7myilEnpiH4ImjEEIeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787309; c=relaxed/simple;
	bh=wRY4zjm009O6+UDsnTowxEAElDpFtDUNoPYaI0TjIPk=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=tsQKrj30ks77F4Q98C+EfB6FLZv8lAPfKMmdz3bG4UcxiDONoISenBYncCNP3fBNY/zrvNAlALFtVSzVP/1MVsUYUTnf6ZC9MpKhVkh8K3YMiqgOxOA6JTYsJgvzOfW630a+KUq2YCjEp9XZp5H7VG9GEa0v/XHoqEdb0JBdKRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=FVCmEIyR; arc=fail smtp.client-ip=52.103.64.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeu233rtuTsErKmcYLD1bb7iAerQwZUa9RRWaEc4nbRs0INn0JNMCTEqjgSYtluyWfKipRqEu2jpU3iD/FR2IF9815iVC7ZbwFn4queGsKbcMrhqlYDQVmr+R7OM81QmL8lOK5Y2nZvObTdFvhyB9/egyYcIO7NgY25Grq5k1kolpLOowhT2BJm7SmyD2/VN6UAt/+EFkPQbivnDLlpSxnY8R+LaCVTTOFdOosFP4QqcosU1nOSuKJOCETTcKd3+J6DrQA1VBKKxRe+wd5ZDx20LwPy7pU6yU85+R4qdT/ZWFBbr9EAf6rhtxwO1vmmh24wB6o2JmHZUWD/CVv9ntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnCUrCoZ3q+Jdf9dl74fJrrrB9YjpaCRF9qs5m///LE=;
 b=y4Cpw6oNCouP89ZKnPcGCjkdUaB1/qzSgnUYutIybiBCWk2ZhYd6rha5BU0LhPJ2fBGv4N+MNfV7YROYHRd2AHpHV4hLRnuRVJVmvkePq9+dF8MmSG0k8ldnp+Oty8V9HlhnpyVJ9SWOQ3VrEjGKEZg1zjW30S9WVD+6zAmE6dGpFNYgamLmVtVt34gtJBNg7s5nMFdJVi0CMBo4v8fAGk4xehPqerDEDU2Jtga+nbGA8ydxWci6QakYN2UdiYIloC7RDwLiMUeu9z3be52RN/Qy+rypIrzi5PojC1BPOnyMmOqUYD6qoeCuBBwFIwWVyeUvQOi3mzTIXPn/7ooBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnCUrCoZ3q+Jdf9dl74fJrrrB9YjpaCRF9qs5m///LE=;
 b=FVCmEIyRaG4SNGOV7OPgsEcqUfUHMhACChQA198DunllfF9xgqpgxX2iapdIXxiTtVsLq2te5tR66Qu+oLqOKqW8xdvkXZ+khVqRhcy3PJxLAU5HwzELTbz55ihdzNSkHHSzJW9a/+w2xdQgLGZ8BmW35fKiqneBFIjQzwLF8qcczgiPWm3IDw2C76L2/aAG4J090PT3bfmnTFBHl/iZqygjio9hlRa6KEA92okG+UdUErxpUDT8bDDqulgjawtaoc+1mUqaiMHAWO259OKNQF14MqpvKK8eE1zkrnEMvrEQnXxQQpsNS41Gi5TLpeAENtzcdR4djRx6cw17DG4FpA==
Received: from SI2PR04MB5427.apcprd04.prod.outlook.com (2603:1096:4:16c::10)
 by TYZPR04MB6134.apcprd04.prod.outlook.com (2603:1096:400:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Mon, 17 Feb
 2025 10:15:04 +0000
Received: from SI2PR04MB5427.apcprd04.prod.outlook.com
 ([fe80::8c1d:10bc:29f7:134]) by SI2PR04MB5427.apcprd04.prod.outlook.com
 ([fe80::8c1d:10bc:29f7:134%6]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 10:15:03 +0000
Message-ID:
 <SI2PR04MB5427A718B9E5C8B329636667FAFB2@SI2PR04MB5427.apcprd04.prod.outlook.com>
Date: Mon, 17 Feb 2025 20:14:58 +1000
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-AU
From: Noj Unk <noj.unk@hotmail.com>
Subject: can't delete file can't repair backpointer mismatch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0098.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::10) To SI2PR04MB5427.apcprd04.prod.outlook.com
 (2603:1096:4:16c::10)
X-Microsoft-Original-Message-ID:
 <312598fa-a0d6-4490-b359-d64aaf6642a3@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR04MB5427:EE_|TYZPR04MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d4be92-0a42-4f53-6c9a-08dd4f3bf0f8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7072599006|19110799003|8060799006|13031999003|461199028|5072599009|6090799003|15080799006|41001999003|12091999003|19111999003|440099028|3412199025|3430499032;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlBJdXlhMm0xcHh3cWlDdG9kdjNQd0V5eURmaVJiaG1VbGtJaGtxMU1LSDJt?=
 =?utf-8?B?MkJvdGRiQjQwTUwxRGJJUit5U1lXUHpWMCttNUF2anlrbE9VekxUYU5DSGZD?=
 =?utf-8?B?UTJldkFIZDRvZlJVQXlYTUdLOUpYeEtCb0ZMY0YyaEx6cWduZi9ZaGlJenRD?=
 =?utf-8?B?UHZSMTM2eFpoRXhhdHpHYW1sNGpuZjc3MllsS2p1NFZlZ2VXckhuMmNURitL?=
 =?utf-8?B?NHJ3NkJlMyttWGNLU1hkb0tlSE0waURUWDNpNlNiOTM5ZHlFUndTSGRwTStL?=
 =?utf-8?B?R0xVeEpveUQ0Zjk1T1BER0pLbHh6TGhhcnR0Ti9VUnplTUVSTmlUdXBhNUl1?=
 =?utf-8?B?QmpmZVJJdzBIS1AwYmFQRWY0YytxVW9LYTZrMVp1Rm1KZWU4NHh4UERVbzFp?=
 =?utf-8?B?eUJkRjRVRWp0U1ViTHJwVjNROHRJMzJBcVpnRUxtenhraFVWblFXdUovSzZt?=
 =?utf-8?B?ckphTkJJRjIyeHlxT3B0Z0h6VUovSjZEWGdwYmhVcWg4elZGaUFHenhBSlFw?=
 =?utf-8?B?Qkc5azAvbUw1WVY0QjY4dEJScmV4QWlsbllpL0RPajJLSGZ0SXpBNjRVVWd0?=
 =?utf-8?B?eFEzZ211TnluSkdVOTJlU2hjMzV1cm1oYVhkWm9NcktFdHVRaWhuTG5VMEFX?=
 =?utf-8?B?TG1tTTE3SXlIMkduOWV3UVhFcnlWY2R6OG5nRjdlSS9FMmZuNmswbzdyTkJG?=
 =?utf-8?B?clpaVVJQTStpV21EbjI5RmQ5WjErN1NTRlF6Y1dRUFNxZGt6OTU3UUFuNTBB?=
 =?utf-8?B?bzRGWmp1bGgxc1NrRFpsakJVT0RBQTZCREMwN055eW00NlNHdGVYamtHenp6?=
 =?utf-8?B?R0Zsd2I1RGVaVXZPcE41dVVuYUJXSEl2Z2xsdlk3aU1VNlN3aTFqeWN6azNm?=
 =?utf-8?B?bE1hMCtFUGpWWXRqdXViUkdUdG5HZDRyWFdCeUxaMU5veUFxc2FMbTZIb0h4?=
 =?utf-8?B?QU5FNHNHRmxWODF0bmpCTG9MS1JEN0ppOVZNbjZTeFkvNC9QcGozOHZ1a1Jv?=
 =?utf-8?B?N1JWTVg1OHVhczVMVkd6eW5RbVBUMWxQU1lwdWprYmdGc0dSQ3luUVpvTkN6?=
 =?utf-8?B?a0hIazRrSFBCdENOMlZKcDFYMVJHdCtQY2dFWlNST0VMMzR2YkJZdEJvLzdp?=
 =?utf-8?B?ZE1zOXVkWFc4VFg0dWFCNFVBUStvdnBlN2krR2FBREhVMS9OR0hqSWkwM21G?=
 =?utf-8?B?YkNuN1ZFdHFWT2lwdVBHbSsxc29WMllWTW5mYUlYZC9acllHclZhMDZVeEVh?=
 =?utf-8?B?MEplSWZMZXQ4RlR3ZUUyN3lNMFVlbTRnMzU2ZElXNWpIRDVqU0llVXBXdDgr?=
 =?utf-8?B?MUZSSk5rUjRwdTdqTFUxUFh6T2toVU53TklFa2l4eVBORCtQWXFGOWdUYWZ5?=
 =?utf-8?B?RTRNNUlKVExoZ0lZbm1MaThxVEpSbWs5ZmNtbUVIWjczZ0ZnanpNejJVeVlm?=
 =?utf-8?B?WitrWlN1dDdWK1pqdEd0dEMrU3FzaWk4cFIzYjdPZ042SlZhWGVLRzFLOTNX?=
 =?utf-8?B?NEdmcWxGOGVidzJjeTJPOU00NnpvVGtyS3kya2NnMmw5aWVZaURiMXE2M1ND?=
 =?utf-8?B?Y0dJaTZxMktUSktrRHdlSFk1aDVyMTgvUXVmNWx2QUJMS29tUlBUV2RxcjYv?=
 =?utf-8?Q?XFhaA+JdIuMyjtnwuowpP9rEO5jKD+yKwhDmkYG0FPyA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTZLU0xSQ0RUZGpvUmV6U1lpZWhXRW8yUFRTWmNNWDFPZFFEL3B3YTdyZm02?=
 =?utf-8?B?b1JDZ3FmRUsrMldoRFA3bEJOMVY5S2JNVTVhcHBHVDVZTklpVWlFTUw0RDBk?=
 =?utf-8?B?dGYzZXFWM0czUkpjK0V2WUludHFvZjNRMVpyZUFwM0FoYjdsVkpsT0VRZElm?=
 =?utf-8?B?K1IvK1JvdkJMT3VZUUtBNThFNlNLQk1LdlYzMldoc1ZtTmMzTWZoREsycnNY?=
 =?utf-8?B?SjVPT3MzWTB2SU1SZVRNeU1ha0x6eUZJNTFvbUVUdDRZbTFHSkFDTk5TKzNO?=
 =?utf-8?B?cHptNnd0Zjc0S0tvUkYwd2x6TmM0cDhwUktDbnJGMFlrc0gwN0dpeU4xaUE4?=
 =?utf-8?B?K1FZSWQzYWNPZ2JqbDFISmlaellsUGJoV0J2Q28xM2RMRmN6bG9lcW9QQk1Z?=
 =?utf-8?B?N0ZleEtTdi9WS29DRUVrTFRnelVFR1psWkR0WUgzTUxvaHB0MTFnWmhLeTc3?=
 =?utf-8?B?dUFmdDhPNGZkdW82T25FalFhbHRIU0s4dVlmalB0VE5kMXRLY3VuZnF2K3Bq?=
 =?utf-8?B?MUt6WDhvYXJFQWRGZnd0ekdHTDZOWENJcWJwekxvNzhiMEJUSFRBQ1JEM2d1?=
 =?utf-8?B?clpudXZpQ3dCR0hiRXVhcTB6YzlFYVNhZ05NdmdtbXlIVEFhK3RLYmg5RGxh?=
 =?utf-8?B?bGswbmFNVTAxZVV5cWFwUVI2Y1oraWlwSUtrV3dCUVY5bEFUK0RhdXNLcUpx?=
 =?utf-8?B?bkp0NEJ1NmxuZVhNMmM0VVNLVEc3c2pEbG1CY3krckYxY3IwTkJHelBKQXox?=
 =?utf-8?B?VXhxK0NwODhQRlRLczZqcUNudXdnOGpVeUVTSG5JVEVITnZ1MzJSUVh6UGRw?=
 =?utf-8?B?QWhhaEVWZ05ubktpYmt0ZjlrZU5wdk52MHg3NXFSd2hEK0lubjFXOVhWZ1d0?=
 =?utf-8?B?UytxTXJFQWJlejRUMGVESy91Z2lmc1VzZGNnLzl1OXM1dk1FYkl5dzFVMy84?=
 =?utf-8?B?MGovQ2lzNVpWRWJRTmZqdWMwNFgwYkR4YzZUWDdyVVlDMmU4ejMvUW1DV2tS?=
 =?utf-8?B?cXBEayt3ZmxvcVJJbSsrVWxzaStuWkNKbDMxWm4rcXRmMXlwdkUyMUZGdm9H?=
 =?utf-8?B?VjB5WkN0STk3U1FlMjNjOFhwbXY3TmRoOXpocWkveTVwWmw1UUVaUjlGNGxy?=
 =?utf-8?B?bTgzd1YrZVhLN3dOei9uVU9XUVhVTzFZQW9qcHBIS1VRME5HY0R6eDFSeUpX?=
 =?utf-8?B?cE1ITHYzY2FOdVkrQ05XazFhMG9Jcm1Cd2lqbEFuc3dSNGZ5OWQ0QkQ4L3A5?=
 =?utf-8?B?Wk9CR2xjUXJBWmRTYkRtQjd3VG1mTk5PUisycFU4SVBERzNFL1RFc1dJTG1n?=
 =?utf-8?B?am1OemUxMzVnbkVTcnJxRldSRU9iM0d1ZmRBeW01WjZVN3NCdzFRcmVPTkZZ?=
 =?utf-8?B?R05HREhOdlpDQWx3dDZ1RGNQWURBeW1vNzRyZHl3b0cvcXJRTkZTQ3JLL1Q2?=
 =?utf-8?B?cFZKV1BQUXBnMmlzd1pEb1F2QzZmYWszc3lRQ3NZVzNEbllRclRGeEZBbkY3?=
 =?utf-8?B?dUlIR2RCcFBFVEZvTTdaVnJSK2FCZ0hkSW9JcGhJalBlbHF2TERyZHlBcEU4?=
 =?utf-8?B?bnVmYjBDd1ZiS1dhM1hNczdaZkFzTVhETWFVcXBpV0tmSzJpWmhab3hYYUpE?=
 =?utf-8?Q?jJqMVmrUbkQqEz90Y0MCak5aZkNuh8XNkEerJdIAuF/Q=3D?=
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-4bae0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d4be92-0a42-4f53-6c9a-08dd4f3bf0f8
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5427.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 10:15:03.4718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6134

I can't delete a redundant file on a dedicated subvolume.
I just want to get rid of it but nothing works.

I have check --repaired and it fails
backpointer mismatch on [4611686114528817152 7913472]
failed to repair damaged filesystem, aborting

If I try to remove the file, it goes to ro fs which is a problem as this 
is the boot/root fs

This is a boot disk so I need all the partitions intact

So what's next?




Linux pmhost 6.8.12-8-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-8 
(2025-01-24T12:32Z) x86_64 GNU/Linux
btrfs-progs v6.12
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED 
CRYPTO=builtin
Label: none  uuid: 5b4a836b-b294-403f-b8ca-e9b4ae74f9b0
         Total devices 2 FS bytes used 707.40GiB
         devid    1 size 1.82TiB used 772.03GiB path /dev/nvme2n1p3
         devid    2 size 1.82TiB used 772.03GiB path /dev/nvme1n1p3

btrfs fi df /
Data, RAID1: total=769.00GiB, used=706.26GiB
System, RAID1: total=32.00MiB, used=128.00KiB
Metadata, RAID1: total=3.00GiB, used=1.14GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

dmesg | grep -i btrfs
[    2.463481] Btrfs loaded, zoned=yes, fsverity=yes
[    2.743677] BTRFS: device fsid 5b4a836b-b294-403f-b8ca-e9b4ae74f9b0 
devid 2 transid 918882 /dev/nvme1n1p3 scanned by btrfs (364)
[    2.743836] BTRFS: device fsid 5b4a836b-b294-403f-b8ca-e9b4ae74f9b0 
devid 1 transid 918882 /dev/nvme2n1p3 scanned by btrfs (364)
[    2.967362] BTRFS info (device nvme2n1p3): first mount of filesystem 
5b4a836b-b294-403f-b8ca-e9b4ae74f9b0
[    2.967373] BTRFS info (device nvme2n1p3): using crc32c 
(crc32c-intel) checksum algorithm
[    2.967378] BTRFS info (device nvme2n1p3): using free-space-tree
[    3.292211] BTRFS info (device nvme2n1p3: state M): use lzo 
compression, level 0


btrfs check /dev/nvme2n1p3
Opening filesystem to check...
Checking filesystem on /dev/nvme2n1p3
UUID: 5b4a836b-b294-403f-b8ca-e9b4ae74f9b0
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
ref mismatch on [4611686114528817152 7913472] extent item 0, found 1
data extent[4611686114528817152, 7913472] referencer count mismatch 
(root 257 owner 260 offset 6476423168) wanted 0 have 1
backpointer mismatch on [4611686114528817152 7913472]
ref mismatch on [4611686303539806208 16384] extent item 0, found 1
data extent[4611686303539806208, 16384] referencer count mismatch (root 
257 owner 260 offset 7891369984) wanted 0 have 1
backpointer mismatch on [4611686303539806208 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[4/8] checking free space tree
there is no free space entry for 285112418304-285112434688
cache appears valid but isn't 284605546496
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 189159010304 bytes used, error(s) found
total csum bytes: 25894732
total tree bytes: 589955072
total fs tree bytes: 290979840
total extent tree bytes: 257638400
btree space waste bytes: 125718761
file data blocks allocated: 965966151680
  referenced 173047226368

btrfs check --repair /dev/nvme2n1p3
enabling repair mode
WARNING:

         Do not use --repair unless you are advised to do so by a developer
         or an experienced user, and then only after having accepted that no
         fsck can successfully repair all types of filesystem 
corruption. E.g.
         some software or hardware bugs can fatally damage a volume.
         The operation will start in 10 seconds.
         Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/nvme2n1p3
UUID: 5b4a836b-b294-403f-b8ca-e9b4ae74f9b0
[1/8] checking log skipped (none written)
[2/8] checking root items
Fixed 0 roots.
[3/8] checking extents
ref mismatch on [4611686114528817152 7913472] extent item 0, found 1
data extent[4611686114528817152, 7913472] referencer count mismatch 
(root 257 owner 260 offset 6476423168) wanted 0 have 1
backpointer mismatch on [4611686114528817152 7913472]
failed to repair damaged filesystem, aborting


btrfs ins log -o $((0x1660245000)) /
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted
inode 260 subvol var/lib/pve/local-btrfs/images/101/broken/vm-101-disk-0 
could not be accessed: not mounted



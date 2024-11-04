Return-Path: <linux-btrfs+bounces-9318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055FB9BAD14
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 08:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282461C208FC
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 07:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFF519882C;
	Mon,  4 Nov 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p4ZFA+nK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qH07JZNT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE3923AB;
	Mon,  4 Nov 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705121; cv=fail; b=UGeJOMgbmU483vz4zp6GoaMVVwAhBqY53zMjRfAWRKp+0IrN2dWxPJpmgcsImK3yta5u/h4+BjuGebLvm/P6Dl9XXs79vP1kk3a4EjzgCLmXicNZ0bnxqvI5/fcDt94KFGGjBh5jXoWfbK4D9P7rJG2uZDLqh+ophUkZSbvEuDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705121; c=relaxed/simple;
	bh=xsUf4ExCXXpmWlnPWJkNDGwhlJ7fz+o+RJLe393i5Y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RD1nbiA6E3BF2ZHASbLE3ElP4g9z0xtejeCPLUdj07oZPqHOEe1pYxjz25EFmBfpENyXwjCeJvCc03vEwz04lTUcZZiPP1BKLA6OtfE3ZYX0BA4/ItQCh3NexOF9U5kykDqAakUTI7+skQduMk1zHRsZ1MW+KzAqF4IN7lQttSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p4ZFA+nK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qH07JZNT; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730705119; x=1762241119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xsUf4ExCXXpmWlnPWJkNDGwhlJ7fz+o+RJLe393i5Y4=;
  b=p4ZFA+nKaTJRcJmuqelgqwo4x/DKMafXn5X4G1BytKU/mvuG05N7K5dP
   krTBTlB270Hs3UEUNv4xXRjAtz0a4ZxKK4K5u41hYAR9et4IHGOObYx+d
   ZtzFJO9xZ6ziYEqup/IjvY5PteZTgb0nT2NyRvAaaBassVDGh5XvSEXbA
   bUbYsLztQs+i3ID4znQ7JlFMg0iDwsc3k1GElr02Wfn+YeZ6Z5sVRpwfx
   zSPXtHWdrM2N62NJE9zpHGflH3wlXRrIQX/Qa5g+KtgZb8rfC/vIMY7fZ
   WHFvsIjqQQDx7BgWTpEmI9dABsAnbVWHU0IF/CKB5IVQD1ggD3HWpBUwl
   g==;
X-CSE-ConnectionGUID: TMz+rzmEQvu5OkQVV2R2aw==
X-CSE-MsgGUID: RG0n9x8DRcKn3u/oF5El+g==
X-IronPort-AV: E=Sophos;i="6.11,256,1725292800"; 
   d="scan'208";a="30537323"
Received: from mail-northcentralusazlp17012055.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.55])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2024 15:24:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYbURPhzrtCSS5HDOuDV6gibdUcDJcZEVm/An5mEAXbkuTEt0Ac3L3qFSdPbLwtd4OVPu0kSjo90ksN5fVEpZFB3iGCC8o1RBWE7Po61/zVZzvaajOg8B4PfmzmvdzZLGHorXNvBsfmP2dqYAZh5hMA4EkhFQBoR1NH9KfgAUFIPjSIqzDnN9xbEQYMK90PmzKZ8DQB9mGgsRo7VEIQiEt6mF5jeEQ1Pyy7kONU22NpBL1UM3zzgMWNDRWR/tiF0f6KtlmeCaqe+Sd2r/bS7gpruyPM8jNLFNUFjIoNVoOn+9wmtMroJmp6EKv4+vhPVqKLW1w+OvxAxrwhfTvoVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsUf4ExCXXpmWlnPWJkNDGwhlJ7fz+o+RJLe393i5Y4=;
 b=WINZWe0W3HlRf+DK+EXz7aEZZFVVsuZ4vc+h7Y5jtiD+fVB/kyq61tnbOMS+h9s1GxejNt25YqfXnh4Rw+KTVFzgJtrbGMtqblLs7Ykr+43GK8L2RDlpxg7XASZTLc65FwV4m/DDDfD60/1h/I/ua5udgSfQrs/QBpPEQQeA3Zy/BAehB4h19daU2akgBpn2RlTCFp3O+WKDK9VzxFpkkZlZkeivJCAwxMACXjUmnJ7txH8HTqA7sTqC6/pK8qUN5j9p+KDnqzxfKNYrytEikVQQqke5FjxAJIVgJ28/PpUPtgtNhvAlMO5cEFG9Vw6aekQcRcFH12iQS1NHS+du7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsUf4ExCXXpmWlnPWJkNDGwhlJ7fz+o+RJLe393i5Y4=;
 b=qH07JZNToCZDaJaN9d9TPtQ7KA4+ri6XhBeKAkyiXCgt4g9QQ7bKK/lQj7+a2oqeESsSdjVXiKcqK+R/0rrD+aVWcrMXxjmykZFZZ4j84wRfQq3hK+WjYoSbD4R0J4xHaVyBLLnRlNiF0hWMMU/AfmAKgDFe/pZjjQiPdOZNkS0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8245.namprd04.prod.outlook.com (2603:10b6:a03:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 07:24:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 07:24:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: John Garry <john.g.garry@oracle.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] btrfs: handle bio_split() error
Thread-Topic: [PATCH v2] btrfs: handle bio_split() error
Thread-Index: AQHbK6OHwiy2s0hxYk+l/b0rJGWH/7KinZ+AgAQgJwA=
Date: Mon, 4 Nov 2024 07:24:05 +0000
Message-ID: <726be3e6-5b1c-4a98-9b1d-247dc86195ac@wdc.com>
References: <20241031144458.11497-1-jth@kernel.org>
 <fd8a6edb-7775-4e15-9124-3be3c11adec0@oracle.com>
In-Reply-To: <fd8a6edb-7775-4e15-9124-3be3c11adec0@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8245:EE_
x-ms-office365-filtering-correlation-id: 5c886c47-8136-4b59-2fa2-08dcfca1a9fe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXpWZmllV1FSVmljaFF0TEZvYVlnSnBvM0FlV2gxdVY2UjBINlNQcnY4Q0Yy?=
 =?utf-8?B?UnhYYnVFSFcra1laNjY1M1NPN2NJWXMwRGc1YmI3Wml4TURRa255UzRZRytS?=
 =?utf-8?B?R2RvNHprTGFnN3paekpRYmc5MUJDZjFNcEY1SVVIc1VJdG5MdGwvVUVoQXh2?=
 =?utf-8?B?Z2QyOURwY1NpdEluVWdHdmpXeWRXSlRRU3NMQjU0c2VvcWNQSDNrUmluNzZ3?=
 =?utf-8?B?aFYrZmZQTENtN0JFWDFja2tSM0FiK0s4UzBDcDRjaFkyb2pJY29YVGM2UUVB?=
 =?utf-8?B?WWFNQytZMWZqUnZadmY5SDhlMWI3RU9EUDBEYUpsNUFlR1pQV1RjNG52Zk9L?=
 =?utf-8?B?Q1ZlQ2VvWURSTXp3QVZZcElDZE9PcU1TdWUvZDF5SEVKMFJ1QnZSV29DNHlB?=
 =?utf-8?B?bkZEem9GeGJnUzE3TUorRnFadW9razJyOEc4REJRK0JUSlU4eG1RWDFpWHNU?=
 =?utf-8?B?VnFqQzR0S3hIc01HWEU2azNkLy9ITUpmL2VwTUlucDZWSUJraWZWYzVmWjRl?=
 =?utf-8?B?VWZxc3J1UGhUVHZiOWd1TFQrZkNDQ3kycmxuaGZtc2E0VUpXUkJ0N1FpS3BJ?=
 =?utf-8?B?cDR5eTJyTFJiU0h3eXNJZEdaaHl1WHU4bnd1UklwNTR0TXcrRWFYYzlmVkFV?=
 =?utf-8?B?TGEvaS9lUW41Tlk0SjF5ZzZ1L0h2NUZRZGE1U3NCZVFpSDdmSm5BWjZsWkxT?=
 =?utf-8?B?VGtGZzFTNE41MlJRSjl5YTFsemk0VUd6ekFyOXdBZ2dRQTJERnEvYmxuMmkr?=
 =?utf-8?B?by8wV0hIQkU3UkxYMHJTa0JBVVFtZy80RWQ3dStCUEFWaTdJYm1YeDZqcyti?=
 =?utf-8?B?aEthRkluZGpuK1dkL3ljcVN6WTcybWVoOHR6MExkY29ueXBiOE5YZ2o5Qm5o?=
 =?utf-8?B?c3lrZUJWSCt3ZTVJTEtpRXl5eHZLeUZMRUpjZHVuSkt6d3RDUHBJNndGSWNq?=
 =?utf-8?B?RUN2ZGJsUG1UODdWTVphWXhsM3ozaGpnZUloTERDeERVUGZJdGV0YVVpbVgw?=
 =?utf-8?B?Nm5OcFhvWExuNU53RGk5S0JYTVA1aXZ5cjcwRlNBM2U4K2tDcnZsSytybHhm?=
 =?utf-8?B?ZlBWcUl4Y0s5YXd1bG5WdVNHcEF2MXBJWlRqaVRpMWJMYkpMeXluUFE1ZU1k?=
 =?utf-8?B?WDgyZEdvUGFUQ1dITHNyc3dIWlp3Y25MNndDeDFkd0Qvc1l2SGRwUEUzYktv?=
 =?utf-8?B?SkdodmxZWTE2b0NyWjRXRG5nUEpaaVEyangyd25KWklDM3NLVTUxQnREenBV?=
 =?utf-8?B?ekZRMXh4clR4Z1R5YndMdmdVdlM0ZE5JNXgxeUNxSjFaVmIzcUZHdDdSRXcv?=
 =?utf-8?B?YzBORjhrNXozZkkwVEEyMzlBbVZxQkszUGsrb2ZNcnY3YmZnQ2JvZHJ3akJx?=
 =?utf-8?B?Q0lDbCtGdEludi9lUkhXTnc5ZEVhSmJwYTNUOGlsakNMenlFcU9zaWhrTFFN?=
 =?utf-8?B?Wi9zM0hyNXdvR3l2MGhBSm9PZU1HWnJmVmFCcytia01YekJLM3JEZVlSa1hR?=
 =?utf-8?B?K05CM2NWQnZaaVN1c1Qyc2d1eXc2SC9MRW9mdjdoUGN6ZEVlWndzZ09JbklB?=
 =?utf-8?B?ZkJEQkZiYjlwYTBqQlBveEtNM09mSWpuNWNlV3l3ZStJNllVWXJNOVdPd0RQ?=
 =?utf-8?B?YkY5UFJzMERmN2ZCcHQ0Z3UwYWkrb0haUkR3TEI5ZHdrT200NDN0SENxNUhT?=
 =?utf-8?B?MlhXc0pUbndhcno4RTFIM3FRcHpmUm9oWCtSeHloZWpiRTBvV0hRSkNrOXJE?=
 =?utf-8?B?dnQ4UlNiZXN4S2ZSZnMraXRZcFlmL1BhakFzSGp1em12SEUwcWRQbk5hV0Zi?=
 =?utf-8?Q?XN+1Ggo9QYVMBmr1l+be2fJynj6hR8umRL39s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0RUcVRDNWVwRGpFN0UwbEVZTWdadmtXc1QySnAwM2pPRjVvaUJKaDlodGZL?=
 =?utf-8?B?UXMyODlaaTVtT3pJSHpGVXhqYkc2T3BMbWh2aSs4VExpWjdRenNhbkhHeXQx?=
 =?utf-8?B?TWJBanN4bFZhdDJvNlIvYkxLcC9DM1RLU0pTWWRtY0xTdXdMZVpiWkdZTWVI?=
 =?utf-8?B?aGNadlpvRkdsYkZMR1ptT0hZT0tSa2JRbzFDL2hrcHB6Q1Z5U1UzODVCYjhx?=
 =?utf-8?B?NkhDMHVvMjVlclhQOENaV2tsSkh3SWVONFRIbXFRTTlydEFIblZPQVpUc2hQ?=
 =?utf-8?B?UUlaNTA0cHdaZzU4RHVHbmNiQ3FYSjQ2aC9nU1QrdUJmbXdqV2tGQWxWUDFI?=
 =?utf-8?B?M3NNYnlkTVp1NzdPY0kxTVBaN3RrbmRFNVlmMlY2KzhKeHhkRjJiT1duZlRI?=
 =?utf-8?B?a29jaDZHQk8waklNdjMzTEhjb0xaVXhLa2JiY2ZRbVhpVDA2c0tscXZzRVNq?=
 =?utf-8?B?OHNiM1JuNE9iNlJ1MWRsbXVJaGtkd1NsV28wWnY3R0h4ci9hNzhKQUlObWYz?=
 =?utf-8?B?YWZhQzZlaVNsbWtqNi9lODBnclpTRVh2USs0VXZSdmpRbmNPdlFZcGZIQWxB?=
 =?utf-8?B?cFFBRTlwVjZ3RmpNN3Q1bG5mWEZLcFJZTUR0c0xZL3kwME1lejd6ZUhOZENJ?=
 =?utf-8?B?OVNiN1hCVjl0d3NGRDRNVGRnRk8xZ2JuNk9tSUYwV01TOEZZenEvRDY5ZnJB?=
 =?utf-8?B?ZGlId29OUVVCUjU0aFZscDExOHFpWmRNcnAySU9aTDQrdHA2MjNhc1VWWE8w?=
 =?utf-8?B?ZzkxeFNjbkRpMkU1allaT3BlUVdhL0E1elRTaWErQ2R1YVZNTThXWGJ6b01P?=
 =?utf-8?B?aGo0RWZOZWtZMjM4NmtGdURUQ2tTMWtnb1E4U3ZSUDN1R1JraGFqanp0NnhU?=
 =?utf-8?B?bHp1YUMxMGJSdHdtaUF3MHhROUxoWXo4MmhPVXVxd0VTU0lqbFQzQW15R3Jk?=
 =?utf-8?B?WkNZanZScktGMURwNGM5ZVBqajFYK3lLRGJxU3IySlN3TTlHamt1VFNSTFE1?=
 =?utf-8?B?WmgvNW9DTkJuSEtCLy8xb0dhY0l4UU51RVVhb1lJbVplcnNTVkJMMDZaQnlR?=
 =?utf-8?B?ZXdIWHkvUUFOK2ZXY0RUZGhydWxRRitWRXlQWUxVcWlrUStrQnNMQ1Urb1lm?=
 =?utf-8?B?aGRGbVowNlp4d2dRbzhaS0VqRUN2ck1JWWlwandDcVJrbWFTWWUzdFQ5TjJX?=
 =?utf-8?B?TG9aeDBhK28yNXhUZVJ3TTkvUFExQlExQndJS0s4YWtSeFlvY2p3VUVsbWtj?=
 =?utf-8?B?Z1dZdThqa3UxL3VWZlo1Vk8yRlRmQjJWODFaRUk5UVhlbHhkUk00UWtaeUpG?=
 =?utf-8?B?K1BqMEVVK1VUckpiM2hEekJxRWZiamZIcEorbGZxYWphVTh6d3laREpBbndN?=
 =?utf-8?B?WkxkSnVoWk1mR2lJaEJ1TGNQSDdnakp6dGFhVmRrcWtJMDlYWjZ2YmhEQW1v?=
 =?utf-8?B?TC9lcVExcVFneDQ2MGppSEdpcXVYTmZYSU4wOEtoUzJNaGdlVW90c0hZVzNo?=
 =?utf-8?B?NFlkeDhnaUM5clhkZ2pIT0lYeE91VkxxVkEwczc2eGNBWGRRN0VvZGMzdkpZ?=
 =?utf-8?B?R1lGMjhNeThZazBlbFlXTnRqV0MyZTRXOVdYR3JPZXFBWEZtN0E0UzNMMVlG?=
 =?utf-8?B?S2lPZXVvejRubUREcklMdFFFZEFMd0hnMnZVc3kwMzMrUFpNd0NycjBhNGc0?=
 =?utf-8?B?OWhoUXJva21hY09tOFhXZ0h0OFZQcnhTb0w5MEtPUkN2K1hzUzdvci9hTmda?=
 =?utf-8?B?eFdiQk9TZWpTN0Y5Y1NKamNoVHB6YjFTK3NrajY3Rm1ZQ0V4UnNoc0RTcHEv?=
 =?utf-8?B?bTJieHFheDVuNS9XVHMrQmZXYnlHY3BRNXJTK3RHcmlNQXR1c25xZEQxUU1O?=
 =?utf-8?B?TUpNRHRqVDB0MDZmRjM0TUpqMWtDWVltSHVmNEtqenR0VlpSMlNOZlZURTBa?=
 =?utf-8?B?MnFPYWVGSmpNTXdnMyt1NFRIS1hMcDYvWkwwbU9SUkk0di9MV0NoY1RDUmds?=
 =?utf-8?B?U1U5VXVrY0JrTmVuQVNtYTlmMVNkQ2lwWGYra0owMHp5U25XeWkyaUQ4ZlE0?=
 =?utf-8?B?KzdpY3grQ0RuT2g0bHM2K0hoT2xoMi92U0tYUDN0NDZySWRwS1FxOFViUFda?=
 =?utf-8?B?MmErdmhWbDk2UUlOc1hNMm9iZExldGRTQ3FOUGRZenhLaGowYnFqRWY0bkw4?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CA0D9CADC2C48428154500F495C7734@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s1AtlibxVik8KUINajduCt3xCm5S6+QX1vDwNOqM01HJ4/PZpN1sv+b8jMyCKAKkoAYmZXfLAvUbseHRyWWAhXDng+GiR74yYwoWkoSq4+Uv17hXOdw6zq7jvuux+YJZeIhT0iDxoxSaGH5nNLKpjuTMOQlyJooAwmmCn7m/JseCsIZPQczBG6jdjBZ2Kc6QSFcxRq4FAEBn8VwnOvymxnkujiim3RcyL5nPgJFRRMB/+qQQEMn+MLm9KxXM4+bzKpJd8h76dKDhPkR6PCl3LKsh3K4QU97gQ5QxGhiO/i2wRkvVkj+2XXnKFdwdbkzwyq6yDX2lFxlGPcRi5PeTteb/liqSKgACl9BJPQOI2PlepTHqmjTJcgifqw1HiMugEjLdv/Z2FU3FCDyyFrVbQM+h2rU5aL2TjpZRCtFT/ZKdqdlX5WLPOVLHQ2aofCMaNfRRZN5MszmhBTexXIrPhNwx9eX02Ix1Q0gR8bHe3CbR887sry2PTjCJx7g+uKOxf11duB2FCrpov85d7twDcyyR5bjsOk3iDwfCXcLRBoKBsMZOeYEKLh2EMLObVHv2r5Gs8JJ6bo9QtQPVAGDDQBs0C5AwNeZyJy9iHiDjOD2nqKDv91fNrRDKZGXyoWLh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c886c47-8136-4b59-2fa2-08dcfca1a9fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 07:24:05.1342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bu5xVATJrIpgnz45s6e6DUWHM3Ae9NViXpSjgyURjsggIkYTwWNugA/rOQR2SPZADHmBW2CWc+zHnK1RsUsr2fglLC8w+UGXEM8xFSiSKHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8245

T24gMDEuMTEuMjQgMTc6MjQsIEpvaG4gR2Fycnkgd3JvdGU6DQo+PiAgICANCj4+ICAgIAlpZiAo
bWFwX2xlbmd0aCA8IGxlbmd0aCkgew0KPj4gICAgCQliYmlvID0gYnRyZnNfc3BsaXRfYmlvKGZz
X2luZm8sIGJiaW8sIG1hcF9sZW5ndGgpOw0KPj4gKwkJaWYgKElTX0VSUihiYmlvKSkgew0KPj4g
KwkJCXJldCA9IGVycm5vX3RvX2Jsa19zdGF0dXMoUFRSX0VSUihiYmlvKSk7DQo+IA0KPiBidHJm
c19zcGxpdF9iaW8oKSBkb2VzIHNwbGl0dGluZywgYnV0IGVycm9yIG1lYW5zICJnb3RvIGZhaWwi
LiBIb3dldmVyDQo+IG90aGVyIGZhaWx1cmUgcG9pbnRzICJnb3RvIGZhaWxfc3BsaXQiLiBJIGZp
bmQgdGhhdCBsYWJlbCBuYW1pbmcgb2RkLg0KPiANCj4gRnVydGhlcm1vcmUsIGF0ICJmYWlsIiwg
d2UgY2FsbCBidHJmc19iaW9fZW5kX2lvKCkgYW5kIHRoYXQgZnVuY3Rpb24NCj4gZGVyZWZlcmVu
Y2VzIGJiaW8gKHdoaWNoIGlzIC1FSU5WQUwgb3Igc29tZXRoaW5nIGxpa2UgdGhhdCkNCg0KT0ss
IG15IHN0dXBpZGl0eSBkb2luZyBzb21ldGhpbmcgdGhhdCBzaG91bGQgYmUgYXMgc2ltcGxlIGFz
IHRoaXMgcGF0Y2ggDQppcyBnZXR0aW5nIGVtYmFycmFzc2luZy4NCg0KSSdsbCBzZW5kIGEgdjMg
c29vbi4NCg==


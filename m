Return-Path: <linux-btrfs+bounces-10310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C969EE22F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 10:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E629188904C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3868120E31F;
	Thu, 12 Dec 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B+AAWPGY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bwAqJvJ/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4B186E20;
	Thu, 12 Dec 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994128; cv=fail; b=RUmCcESEAzUT8zgvCh2OaiiKtlkkTWOOPr7HankSQo8HXHBvbd47p5kt2w5gSAIv71996oMDCmuY5BzDg5iseL6r5qUy9sulmV48qJ/cQB5IGbeGAW8spode3+LeIZuEiQ/uLw74BypaQDRn4unOAFVYevB7amQ8kBqRLwKxwU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994128; c=relaxed/simple;
	bh=+nZr3/YQ2A+ZGRWRrP3ywm8q/9CoMeQ3kBhv6n8FgsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LC1zwTse4gVxHDVWYTxUATVn1qhIKdGfHOk92AbXcj+sSQAfSP3SwjrYciMn8NjeuEzeiTblgNkPsjc7cKF/LvDHnaQ36G1Qy+gsxhhjVsbns6uHj0uLHxSzfGOPV7Tb+uSUKS3IkJydpZW6Hnp1XSHdX7WyL2ULw3klF4kUvqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=B+AAWPGY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bwAqJvJ/; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733994126; x=1765530126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+nZr3/YQ2A+ZGRWRrP3ywm8q/9CoMeQ3kBhv6n8FgsM=;
  b=B+AAWPGY/bH11+FBAOEkOsAXFijIMw7VyyjcEZxavR33pC0ik/In2yYy
   3fsEgHuSvJOEVv101G9pNTiIo6rBd6H44eapumfYbEZq2hZUvvpTEmWzc
   T9d7F1m4NUP/Gd27RVEcFbNwgPz2FsWr6inw2ypzRdxC8ekGsMCbBprsc
   aqGRbGjFuO5+5vipPDDObM+a2jdaXzhQ8FXSwlCyZM7FBfD2sOhIyTwee
   p64msIub4KQ295xpRrgBCO+FLbdnZ0m10eX5VGNIzlmV/FquWVS9cM2WV
   bUbz8z5LEuUFpT4X9Jo3nMChEObeVm2DOJAORDOwKERrSqJ/uCjhu4xmI
   Q==;
X-CSE-ConnectionGUID: CinLVOICScqhtqy48ls8tw==
X-CSE-MsgGUID: fT5ZHEgKRxOHRa5scgdT3Q==
X-IronPort-AV: E=Sophos;i="6.12,228,1728921600"; 
   d="scan'208";a="34705665"
Received: from mail-centralusazlp17010005.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.5])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2024 17:02:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpJjecb2JhxB1VpyPy6Du96hCgbxKuib69wpDxqo/7bdKhUmyd+jztPwOnAj3LlgQzqRGXy7RxQHGTCdg7gVTSOfPRLBbjXjETkxv9ju2+uLZgAgwaGJKxTBxbNl3ujcGJK4KE7EE92jIe3YuJQ8YgwM23Wnin5nEp4TlyNQM75/LHtsFVr6BKa9G0UWq8jkimJpChLIw5XvhtwPj/YZNxme7zeWhWnPA6DAPjDXGTUOBu5vIunCJnFjmuyp+CJj8uGcDGxwHHb5uj8vHtShmEMLECavUPDrj/S0f55pYsNkntuifx6RKeQD+1PzMmZK9RoEYctmd3ljH9bZ1YjNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nZr3/YQ2A+ZGRWRrP3ywm8q/9CoMeQ3kBhv6n8FgsM=;
 b=Yxh2UgZ9dVOQdQULMc8pf/n8ExmWQ6a943YScCr9FiYrXJObvpwBB7d8PF9jtpe2Vrea5JHDLXzFsrI03zN3eGlarH5oY0kRzDHZaXcuVejHcOtERBSOtGdd6pi8Zjt8IED11wOJNLQC0snU8q4O5Xyg2A+gj13d8vnMvolzDbje4LmcpzMzx8azqwpKHYMhmE/S/qWAJtHZ2JLeVLjRuEBlYLpSZRfepD/+uTdIWLqm4gG8ZA6ZCV+WfaJRGteNyHnAq84C2FVwHOh2DLamEwWXFWBmvrsLLuxssQD61Nqd4ZwKKO0eJDcOTSz5TcE2zHbgmnpSB7vLxpF4IDc56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nZr3/YQ2A+ZGRWRrP3ywm8q/9CoMeQ3kBhv6n8FgsM=;
 b=bwAqJvJ/E7z8TU2EaDTf+nrPmLFRsCu7FHXjJdoYJ+8Z91pUX9E+LLqb2J3h67jDv8D/zBsnjWsteHHwqUOwnDZK4Gpu9LY2msSLNhBabg7vREVocYPpRrGzQeQvIeZsIWZY7pfPdRIUe9xuO6yo8icbkj7B6p9KXGTOxFIX3qs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7784.namprd04.prod.outlook.com (2603:10b6:8:38::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 09:02:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 09:02:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Omar
 Sandoval <osandov@fb.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
Thread-Topic: [PATCH] btrfs: fix a race in encoded read
Thread-Index: AQHbTGsKZcn7mGCkaEKERxWN6qbNxrLiPuOAgAAO24CAAAJwAA==
Date: Thu, 12 Dec 2024 09:02:02 +0000
Message-ID: <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com>
References: <20241212075303.2538880-1-neelx@suse.com>
 <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
In-Reply-To:
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7784:EE_
x-ms-office365-filtering-correlation-id: 28f3f845-1f23-456a-b0a3-08dd1a8ba51f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0dBWnJwd0FsRHg4aXFWOWRuTzFQZmhhTTNHd1BHL1RJdTBNNWFOTDg3d0gz?=
 =?utf-8?B?d0pRQTY5M0FsSnozNGUxd0dkTVlQTFl6SkFHUkUxUXVSY3N6cHFkR2g0KzF4?=
 =?utf-8?B?d2tRWkRqREt6STVpMG9hbG1qMmNUbG5DcitGT1RIVFBrYlVjUjBSSDlraVdt?=
 =?utf-8?B?bHB0SDF5SVI3d09GeWZWQ2dWaGc3aGJZSXpSekxKL0FpRjkycmJyZHRNeCtm?=
 =?utf-8?B?bGZIYmEvbGtUd1ZYQVY0ZUcvM21CQW13SWtXdlJUZmZjSkMyVmdxWkJ3Z3Ar?=
 =?utf-8?B?YU84bHdFZE5pWmtpUngvU205ZFhMRDg4V3A3Ulg4V2p0R0NqS2Y5ZFFoTXg1?=
 =?utf-8?B?b0lQKzVZT3BIODJiKzByRm9xbEFDWTdpMGNaTE5TTW1yUEprR0g0bDRBcllP?=
 =?utf-8?B?TW10dHVpQ1o4cGRYVkZ5cnVuT3RZSUFxcGdSQmFUM3p1Y2FaNWc2N2NmZkY3?=
 =?utf-8?B?WXVRUVNoTHc0MFV1ZUZmMkp3NnVmNUFZUy9Fc2RhNjMwZjl2MDRXS0ppc2My?=
 =?utf-8?B?bktJM3Nuc09TTkJQREdtWWNNWlVPUXVJNzdvQU5oTEVPcDFQYnF3QThPcTFp?=
 =?utf-8?B?alVwNjVWbzljdnF1cGxxSXB6bWJtNlFyQkxacUxLdTJYRGlaNG1QSFNMeEN1?=
 =?utf-8?B?L3lNc2g4Mkk2bER1ZnlBOFFRVjg5dDBxUkdvc2taY2t0a3NCbDRucmVZWE9H?=
 =?utf-8?B?NWQ3WkZ2aVpQSDlCU0ZBRGxpV2ZLaXRGUzJIVW1JTG4wUlIzWmQ3cTF5ODIw?=
 =?utf-8?B?T1dvVHZoZmh1ZkFkbE5OQlE4S2oxdnZOd2dKTGQ2emxvclUwQ2dDY2d0UXJl?=
 =?utf-8?B?dG1pRllvYUI0czF4cXh2eE1mRUoyOXQvWXF6QklWa2RHUStaL0ZYNlRVNVNY?=
 =?utf-8?B?L1Y5Rjd3NXhkSWxyYUloUGRvdUZlYUJDcWZkRWlGYWdPcHM3VEpBdlJKYjk0?=
 =?utf-8?B?ZXhKVlJQa0VhTVNyRS95cTh2am9lODFDZ0tTU3hZdHdqUjVZdDdxZE02TzRi?=
 =?utf-8?B?R1FNbkExSjhRRU9jZHNIQzZNZ1pTb3RUWG1TamtEbW9ZWDVxMExwZ0xaOUpn?=
 =?utf-8?B?VTF1LzlCL3hIWTdQTzBsQ1BYYndpZ21nWEl3RFBxSTlyMzZGaFlMMHhZV3lB?=
 =?utf-8?B?Vm5GYVRnSXFwU3ZzazZzbU1YTEpMd3RCUEw2VnE4a1VhZUI4Q0FML0FIQ2Mx?=
 =?utf-8?B?dGJIYXNOSDROZGh0NkVmTXN5dFNQenNKc0l4ajJyTkRycXI2UzFSNFV0bGtn?=
 =?utf-8?B?WVo1SXQ3YnpWQ1RoTWRWV0FRV0FST21zUWVHTlMrN0huQm9sd3VwVjZMdERo?=
 =?utf-8?B?ZTFZSnpJbFZPeU8wUU5OMGFYQ0VTZzNhK05ZWkJ1V3E1eGtQWXMrSVFkU0RC?=
 =?utf-8?B?SmJHSWNkakNheVcyeXovcExWQWVsNFY0VmRtUEFOUjA0YUE4Z250UXo4bGJM?=
 =?utf-8?B?VUlzbmRWM3dMamtiUUN2UTFRMjhkRFRuUkZmRFU0dGxsTmIrZVloKzc2NjRD?=
 =?utf-8?B?ZHdOakFPTjNjSm0xLzIvTW9QNGdjV0dsN05vWjJPRHpiNUlyRU5YQjFlSkVX?=
 =?utf-8?B?N1lseXVvYjk0Uk1ORzBLZk9QNm5LMGRZL0dPZ1Vsd2d6UHlnbmMwczRpWWZ0?=
 =?utf-8?B?aWFaTHNENjRyVDVCQTlzQithbGpxU3p6dVRmMHc3L05adWpZZ0xsOFA3ak1J?=
 =?utf-8?B?SGRxc2dhcHNLazJiaVc0Vm5CWEkxekU5T3dRemhhaTEzSTljK24zZkIxTkdh?=
 =?utf-8?B?Uys5MVJOZU13VUV5QkRaa3Y1bWx0YVE1S3ZBaVRMUFU2bUszN2xaVDBUa3c5?=
 =?utf-8?B?V202QzQ3V1hxQU0wWWRSWFE5OGFPVXI1ckliQTk2UWpWcUZrcWlZYzhUckV0?=
 =?utf-8?B?VVljWXR5L0ZtQ2pmZE9YOGo4eDFmemw2ZWt5empuSTIxcHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1lyZHFxdXpPVGdIMERNMERSYzdjM3RFOWQ5SzZZcyt2V0tuL3hJdXZkamNh?=
 =?utf-8?B?MllVaVJrd3Q5cVRjWUtabU50cmhRb1BhYW1hODliYzQ1V0liWGI5MmZFWmRG?=
 =?utf-8?B?YkgvTjUxLzlqbEVLSTMvNWNmQ0dDOFBNNHA3NXNaOVp3MGhJRnJkVElTUzZO?=
 =?utf-8?B?Z010WndmanVQcHRjV3hhdFdHOEliNk1sTmhNbzBTbzcyMW5WQmRRS1cxcFRW?=
 =?utf-8?B?TnpLREJRdlp5Rk1nVkFzNm42K2cwWDBMb2EvMkVJWGNRZzM5Q2NoU1RZaG9a?=
 =?utf-8?B?TjJuRU5Jb1RLNWJjUWxpT0lBSW80ZFAvelNXS3pVdEpLNmU4VkJ2bDZYZk5l?=
 =?utf-8?B?YVMwOXJBOGNudTl0WTlaOGR3QUk0NEV3S2FwWjc1ZXdvWld0cFhKWlV1ZmJm?=
 =?utf-8?B?NnU0UkIxSjIrVkMyQ0xIM1RlOWR6K1o1VUFhWGQwTGwybHdlc2srdWR3TjY1?=
 =?utf-8?B?WWhkMU8vN2dlQVJLaVQ5R1RJZTNLbTB3QW4xNVU5bStUT1VnRXNaQnE4RTlB?=
 =?utf-8?B?c0dlbzlRZktMMktlSkozVk4xSGQ3d3RTREZSdFhhcytoVUFMaDcrYVhncGFQ?=
 =?utf-8?B?Q2cwY1k5blNXTExwem5yaVZuWmxBb1p4Z01aVGdueGp0WVpSSXd4cWRDZ2NE?=
 =?utf-8?B?c1RrM2Njai9hb3ZYcG1Ma3RKNlEyZzZFOXAyUDFsb00zWTRiTWdXS2g2a0pZ?=
 =?utf-8?B?dUJDbG1ZZ04wUVkvSEppVVVnSGo5U2ZUbVdjOHB0YjdrT3p5VThET0MyNGs3?=
 =?utf-8?B?eEZodzREUWg0Z0J3bkR5amRTNC9ObEtneWNxY3JpaFI1NE4zcnBuQy81enF0?=
 =?utf-8?B?bmpxTnE0di9GU3N2bHBwdCtseEZ6REx6RXJKRVlUMmtZdUk4YnhTN0NhZ2xn?=
 =?utf-8?B?WlRtOHlORXBQTzExaEVaYW00anhhUThjZlVCcTQ4K2t2empPVDdvOGNybG1n?=
 =?utf-8?B?aWhsamgvSzJLaHlmTHM0N0VmSFNLRjkrTkpvVit3UFdiMFE4Z3AxdkFCQ0ls?=
 =?utf-8?B?dGVlZEVXLzVHUjhpZUJBSkxyYU4yUEVoY2pkZnQ2My9hZzNCNmNXaTZmL2dN?=
 =?utf-8?B?dVQ1Nkl0WE9WcDFsZVZQb1NKQU1DUkdYR2ZJSjBEcnQyeUJwVktnNlJ4VzZH?=
 =?utf-8?B?eFQ0L3p2QUF0ZFlDVzFjekNEbURpTHJhaWN0NEFaV21wMGhxRVpKWDNqZlln?=
 =?utf-8?B?eTM4ekVVSHRXSTZFUk9NYVZ0anhwQk5WNHh0eG1VaUlhSnVhWi91SE1FRDQ1?=
 =?utf-8?B?Z2hMUWRJbTIwcXhXWU9OTUlrVE9kbWdSeDVsdS9hdmVOaFJ5djljeks1UXhR?=
 =?utf-8?B?TlozYUdQWUo1d2tzMDIvQ1E5SUFORnlhTzA0ZXV3TEZEaE5PSVYvcEt6R3dv?=
 =?utf-8?B?Wk82TWExNS9aZnlWN29aR2E4NVVPY1VNRlp1ZkdWSDlLSkJTTllVRkxvNVJV?=
 =?utf-8?B?bGRKeWZsN25WWTdQRFA0b3BYN2tjdWJUd0lSU2U1dEgrVlVpUGR6LzVsWTQv?=
 =?utf-8?B?QWIvVUlJOVROSXg1Q0xZSUlvaEl4MnVnYlZYOE15Rk9zYUFQNFB0MmxwS0tE?=
 =?utf-8?B?SXUzQzVrSk9qTXk0L3FkR3g5VWhhZFB6SCtNUlNUS0JNVW5mUFJwNDdLekox?=
 =?utf-8?B?cFI3dUt3OHBsb1NjZTRPbzR5eFZiQXJ2TVNVM0JqVnlUcHU4ZGRnakxkbkl3?=
 =?utf-8?B?QWR5anZpN2pYYVpLbnlkMEVZRE5aWFJoRnF0Vk1rdkN0a3ZDZjN3N05NNGwr?=
 =?utf-8?B?bnBpYWFtbUc1eTJ0WGdGb2ZVVVl4TklGejMvNUxKNEg5Ujc2bnJsa0xPVkl5?=
 =?utf-8?B?TWpXNHVkUUhob2tUUm9mU1laNnZ4cy80bnRYT3hOTTVBaVhkd29KS3o5Uita?=
 =?utf-8?B?dHJ2M2F2elVFQnRmWklQWUs3TXR0a2JjbjAxOFpLZ09rd1JEOE9uMEozNkd4?=
 =?utf-8?B?RkU5RE13NDk0QUdGNDRkQ3E2VVhmNU5wcG1hN2FKRlhGcFVMYjFzTG1uRURE?=
 =?utf-8?B?WXV4K2t3VDBuVDBleXpna0lxRkZTWjJFRTF3L0tmcHFUR3NWTk9oTTFsRkFC?=
 =?utf-8?B?NTAwNlR0SHFjRC9MMW9MVWNSYnZTR0JlUHRjbTV5RFU5T0NPNnE5L2djRnd5?=
 =?utf-8?B?T0RKRDZEOThPcldFRFhxNUVoZ1haWU4rUHluMWZ4cVNFSXZzamRqVFVPakMr?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D054E219CC75D4EA0254FE7AE200BF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AB6V+5uOO+OWQ9hJ8n2xmZxfEZcM5Te/9J1INUKJRvPfuTMUh6uPu2bZ2O4LzWp6W8Pq0hWQk03c4R2EHO0kIk+2Os7xkz49/25BDPuE/yb2XHmr8P9yS4upW9L9lX7ng4TLF0VQfrlUGuZX0F6alH9mg4KHogqVnmP73Jt1s4IwCEXFIevV5v5akQ7Mwv03W2pGfc3K67xm7CwCGkoP8/e33bMSVJ3Qp0phFBkPQ/v2aMmBBSSlBpDWFrNVMjo68nNIE+9W2Pc8UbCcZS9a/I5CubKTrpVd/pAv8TJeNYFmjczjxQfW1GhEBMMez9veIVWtCVSE0GQ8U4uJqCgwVKAznVjh8bcqtp9QzQKgbNHc8cK3Cwtljg4Z24IxrJ1B3imWh9GkgvEdi+1zHvGjsKg5hcFbU5i0XNN8nIQl3jaDwDVZ+vtRZeA1Gwf+9CswdKD+AW0cXPe+7+p0KaJDB3HzuQSZAmwJupVPZaeNgz+iR3LixrQEz2UHbK0m1w8mK5YRukLJ9WtJZDsfBc7Hwm7pIj4ndP0lzqJp4pzeCTpgPfAnxuf/W0TIVoCZ5E6RYSeyV0+EsNlwaAyBJWjAGE3YGyYEXb1md4Nfa5xc9x6JW04wexOW30MosfIoCs2T
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f3f845-1f23-456a-b0a3-08dd1a8ba51f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 09:02:02.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BZNgQZebLORkhMhDvjtRZKlHxtWrdqB1ixvb9/zZtYn6WJRGyrcEpwe5j4cMwvHBqO5deYPfgT/hjHIZjXR3iSZxWEn9tUF5/Mf7c3Sxvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7784

T24gMTIuMTIuMjQgMDk6NTMsIERhbmllbCBWYWNlayB3cm90ZToNCj4gT24gVGh1LCBEZWMgMTIs
IDIwMjQgYXQgOTozNeKAr0FNIEpvaGFubmVzIFRodW1zaGlybg0KPiA8Sm9oYW5uZXMuVGh1bXNo
aXJuQHdkYy5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIDEyLjEyLjI0IDA5OjA5LCBEYW5pZWwgVmFj
ZWsgd3JvdGU6DQo+Pj4gSGkgSm9oYW5uZXMsDQo+Pj4NCj4+PiBPbiBUaHUsIERlYyAxMiwgMjAy
NCBhdCA5OjAw4oCvQU0gSm9oYW5uZXMgVGh1bXNoaXJuDQo+Pj4gPEpvaGFubmVzLlRodW1zaGly
bkB3ZGMuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gT24gMTIuMTIuMjQgMDg6NTQsIERhbmllbCBW
YWNlayB3cm90ZToNCj4+Pj4+IFdoaWxlIHRlc3RpbmcgdGhlIGVuY29kZWQgcmVhZCBmZWF0dXJl
IHRoZSBmb2xsb3dpbmcgY3Jhc2ggd2FzIG9ic2VydmVkDQo+Pj4+PiBhbmQgaXQgY2FuIGJlIHJl
bGlhYmx5IHJlcHJvZHVjZWQ6DQo+Pj4+Pg0KPj4+Pg0KPj4+Pg0KPj4+PiBIaSBEYW5pZWwsDQo+
Pj4+DQo+Pj4+IFRoaXMgc3VzcGljaW91c2x5IGxvb2tzIGxpa2UgJzA1YjM2YjA0ZDc0YSAoImJ0
cmZzOiBmaXggdXNlLWFmdGVyLWZyZWUNCj4+Pj4gaW4gYnRyZnNfZW5jb2RlZF9yZWFkX2VuZGlv
KCkiKScuIERvIHlvdSBoYXZlIHRoaXMgcGF0Y2ggYXBwbGllZCB0byB5b3VyDQo+Pj4+IGtlcm5l
bD8gSUlSQyBpdCB3ZW50IHVwc3RyZWFtIHdpdGggNi4xMy1yYzIuDQo+Pj4NCj4+PiBZZXMsIEkg
ZG8uIFRoaXMgb25lIGlzIG9uIHRvcCBvZiBpdC4gVGhlIGNyYXNoIGhhcHBlbnMgd2l0aA0KPj4+
IGAwNWIzNmIwNGQ3NGFgIGFwcGxpZWQuIEFsbCB0aGUgY3Jhc2hlcyB3ZXJlIHJlcHJvZHVjZWQg
d2l0aA0KPj4+IGBmZWZmZGU2ODRhYzJgLg0KPj4+DQo+Pj4gSG9uZXN0bHksIGAwNWIzNmIwNGQ3
NGFgIGxvb2tzIGEgYml0IHN1c3BpY2lvdXMgdG8gbWUgYXMgaXQgcmVhbGx5DQo+Pj4gZG9lcyBu
b3QgbG9vayB0byBkZWFsIGNvcnJlY3RseSB3aXRoIHRoZSBpc3N1ZSB0byBtZS4gSSB3YXMgYSBi
aXQNCj4+PiBzdXJwcmlzZWQvcHV6emxlZC4NCj4+DQo+PiBDYW4geW91IGVsYWJvcmF0ZSB3aHk/
DQo+IA0KPiBBcyBpdCBvbmx5IHRvdWNoZXMgb25lIG9mIHRob3NlIGZvdXIgYXRvbWljX2RlY18u
Li4gbGluZXMuIEluIHRoZW9yeQ0KPiB0aGUgaXNzdWUgY2FuIGhhcHBlbiBhbHNvIG9uIHRoZSB0
d28gYXN5bmMgcGxhY2VzLCBJSVVDLiBJdCdzIG9ubHkgYQ0KPiBtYXR0ZXIgb2YgcmFjZSBwcm9i
YWJpbGl0eS4NCj4gDQo+Pj4gQW55d2F5cywgSSBjb3VsZCByZXByb2R1Y2UgdGhlIGNyYXNoIGlu
IGEgbWF0dGVyIG9mIGhhbGYgYW4gaG91ci4gV2l0aA0KPj4+IHRoaXMgZml4IHRoZSB0b3J0dXJl
IGlzIHN1cnZpdmluZyBmb3IgMjIgaG91cnMgYXRtLg0KPj4NCj4+IERvIHlvdSBhbHNvIGhhdmUg
JzNmZjg2NzgyOGU5MyAoImJ0cmZzOiBzaW1wbGlmeSB3YWl0aW5nIGZvciBlbmNvZGVkDQo+PiBy
ZWFkIGVuZGlvcyIpJz8gTG9va2luZyBhdCB0aGUgZGlmZiBpdCBkb2Vzbid0IHNlZW1zIHNvLg0K
PiANCj4gSSBjYW5ub3QgZmluZCB0aGF0IG9uZS4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8gV2hp
Y2ggcmVwbyBhcmUgeW91IHVzaW5nPw0KDQpUaGUgZm9yLW5leHQgYnJhbmNoIGZvciBidHJmcyBb
MV0sIHdoaWNoIGlzIHdoYXQgcHBsIGRldmVsb3BpbmcgYWdhaW5zdCANCmJ0cmZzIHNob3VsZCB1
c2UuIENhbiB5b3UgcGxlYXNlIHJlLXRlc3Qgd2l0aCBpdCBhbmQgaWYgbmVlZGVkIHJlLWJhc2Ug
DQp5b3VyIHBhdGNoIG9uIHRvcCBvZiBpdD8NCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9idHJm
cy9saW51eCBmb3ItbmV4dA0KDQpUaGFua3MsDQoJSm9oYW5uZXMNCg==


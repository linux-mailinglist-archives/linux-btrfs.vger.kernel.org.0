Return-Path: <linux-btrfs+bounces-14125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9454ABC7FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 21:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A591B62958
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813B211710;
	Mon, 19 May 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="anFmxlOG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="adkkdqkM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98231DA21
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747683897; cv=fail; b=glV8dHW66xlQdP2Ww2Z0Lj/HsY0O8LY63iirs8S6085dO/DDYy7WBC1i2Hkg6y4Zo29U9f2t5imkrC7sGPEQWNpitE5VtXRRMP35hENfXOhL8Mox867/NH9pjQLm711KuIJjNzEj/mqjxZd8CtEEzIieg0P4nyoBYVMp+UC1RdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747683897; c=relaxed/simple;
	bh=FZi7tpj7pPVI7YpR8Be7b0xhE1erB9zpG7gl8NkEhUY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DekceDxpk7eRZDBnvHyQeUySdQLYJ8fRtgRAV4vWUKt//6m5Q9rBagF4WmggQFU01YVy5Fu1qRt4jwNewy+wUv+5jI8eV8BcwL8AkbiBGzbzWNrvIQUWD7wfskH6Doay1sRJ5zeUQ6fZaq3CLpjMHnY4Xwq/kNFETGP3M01rCR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=anFmxlOG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=adkkdqkM; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747683896; x=1779219896;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=FZi7tpj7pPVI7YpR8Be7b0xhE1erB9zpG7gl8NkEhUY=;
  b=anFmxlOG5DZnfpVrvQlZari1nEov7y9E/nA1KoefXp3JqyFtOkTDa+oO
   gUVbQ2CqIPhC2LDGcEKzk0H4wImLXvgKKxkNqx6sa1GUexr7HFJbAQ35i
   0ZvmJX0IbYvf/mizlKAsn7+2SL9qSQZ9TRJN7ZQYeUV5CU6KRC5fX76lQ
   Y7HpxfpQeM0ekpLWOJCYtHESxfPUXCaZZm0SnIft6Pb3CSVgBVlM2K4u/
   08G7x4HhU/35EgvMdw9W9XkyoG44bKzdoIswYjy9xX/dIFBT0qhBKqNnV
   23h2/+2ns7lkeJPp8FpkP9cW0Hw1YEzwDyXWG3lPuhWB6Xw0/hg6/+H5n
   A==;
X-CSE-ConnectionGUID: JuB4svJYQWmPtqd/6lfdmg==
X-CSE-MsgGUID: 0BakVNY3RqiL9+TI1se4DA==
X-IronPort-AV: E=Sophos;i="6.15,301,1739808000"; 
   d="scan'208";a="83332950"
Received: from mail-westcentralusazlp17011029.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.29])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2025 03:44:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQNW03rFlotVdoWT9/cGXxwpUbcUL7C68pox3QKtSrkH2AFXDfFoG3Eqa1NxXv3gaT/hcJnc9aavK0zp1M7AvvwpjQqIVN926QFikBQJqjefTb6dBtzgNXju/xSiZeM42GC+Z7E7Ey3gNcdDpZUt5/VdIpsq3kunAoClaNVxkR9/z+osZ7ge2U+ZMB4vaItv62Tm0HVCsNwl71ve3MkOf0r4HupiJ0hzge2UGfE8pU1O62V4oSl1nqODpuK2jb5ZvKttlbYVIBbRbvpwAJxw7ng6Xd1PsJHMYwZM0IDPwz9gOSnYYIH0L2/C0IUlWAuZjn4RaP8r2VL/g4mi5tVH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZi7tpj7pPVI7YpR8Be7b0xhE1erB9zpG7gl8NkEhUY=;
 b=m7t+DaXtGh5cIbHn6dH2w7Zbood2SPQxfzhBgn6cVnrDHTPJAGZVP+9Y4Phv41EnixL+i3zcXT369uYrG6Xk75WDh3IFYFFFMSOesjwtnrP5E+CpVB4OxicgCjKfDSquP3KQsLklmPFAFz8pZS2JlmDX5bfLm0VJR2R/r68QMIq80USRXLLe2d/LN6mjZKKI70TNQJ4yLk0W5Dk1+3wE/YlyDLR6wX1mvYwaKgUwdj1TnzrGdYZCVKYSk60obLEYuAh1NwX4pQJWiBavn4BKfSsfddpsTuu8Jp88uxjSWUchsHwlCfvOsBeGJXA8JfIQhGpaHRjN1AMnwAtiXSd4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZi7tpj7pPVI7YpR8Be7b0xhE1erB9zpG7gl8NkEhUY=;
 b=adkkdqkMAi0KgUKMFHmL6ZD87qN+TFj7YznlVKEJ9c6gwG49z4Z1Xa+PP5gHSjEMVpo6Y9M1LCM2rg2QhOgroWhAsi0fzRjXJvUDmqEkiTew4fBsC8ydi/1L8E6t14bHU5xSNjUIykBTWOe9zV/7Gro7kZbReF0Ke3n5jNnqULc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6842.namprd04.prod.outlook.com (2603:10b6:5:243::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 19:44:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 19:44:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: don't drop a reference if
 btrfs_check_write_meta_pointer fails
Thread-Topic: [PATCH] btrfs: don't drop a reference if
 btrfs_check_write_meta_pointer fails
Thread-Index: AQHbyOkisRUdaGM2N0yLTd7tQPWgErPaWyOA
Date: Mon, 19 May 2025 19:44:49 +0000
Message-ID: <1e9ceb2f-643b-4fab-901c-4442175c9460@wdc.com>
References:
 <b964b92f482453cbd122743995ff23aa7158b2cb.1747677774.git.josef@toxicpanda.com>
In-Reply-To:
 <b964b92f482453cbd122743995ff23aa7158b2cb.1747677774.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6842:EE_
x-ms-office365-filtering-correlation-id: e1b996f5-daf2-44b0-2020-08dd970d9e11
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3FjUXNRZE5kdVpTL20rbTNSbHFNUWJrMDZVdHViVHV2UFVoWkp5RlREdy9X?=
 =?utf-8?B?Z3NUTmJoNTFVWWN5WDJEMFQ4bnIrRGFCNnVxaHFOMGs1b2hOSjJYQ3FYbTRP?=
 =?utf-8?B?T0RUcU9UWFo4dElUL3Q3MjM2Uk1Eek1IOEFKYjh3VUczZ3ZkR2Q1U29LT0R2?=
 =?utf-8?B?eDhDNjFwN1BDVldIbXhCV3JldlZlOXZEd0R4a2UzMDhnM05RTFRZamJLK2d4?=
 =?utf-8?B?M0VSY2xNNHpNVTgvMEdkbE9VTEhrSjQzTll6N1lBS0VHQmhqYnRkTDJBM1lO?=
 =?utf-8?B?eElURTI3aDJnZUU5cUZEcTlxaEQzRjdtcHZkbVg3TnBzcU0wdDgrV0dabVZK?=
 =?utf-8?B?UFBZRjRTc3hzWG5ncHdwajVKYUF2a1RYaHdLYXF4ck1RNEVUN3BZMHJJdVhp?=
 =?utf-8?B?K0cvdGJqb0tsTnZkeThOeUR5UjQ5QXBIbG9DNlI5bS90U0Q0M2RJUnhvOCtV?=
 =?utf-8?B?MGhjTTRPc0QzTytwcEl6VllkQ2lRZDRFeW84QmIza3VqVFBpQkRzU2tjTi9t?=
 =?utf-8?B?VWZjK1MwZkNSR0JDUnRPZURJcktCcys2K0dvTVl5MUlQVTQ1bjNXNUc0aTEz?=
 =?utf-8?B?ZzdYazVJNmd4YXhsN1JpeFBLdDhvTDVHUGxUMlNNQTI2SjBWY0ZIMjBrc3FV?=
 =?utf-8?B?bFBpUy9HWGIra2pjUVFyN3d2MGNGMkZaUFVpTlB4ZndLdGhranhiNUc1VnpU?=
 =?utf-8?B?ZXpTRWJNYzBiRExtaWdOYjR2UEZybkdVdWdUblgxK2hyN1B4VVk4R2lZdDZJ?=
 =?utf-8?B?S0RLYnF0ZXkyRTJ1a3gxbEFmcHFsN1RBOS9GR1VqWEh3NTBNak53UzZDOC93?=
 =?utf-8?B?NEEyT3A0ZW9kUENaM0QxNWJnbUJhTnY1SktOVDRQRzczbUN2dTNDNFJZMUZy?=
 =?utf-8?B?ZU9nUmdaU2hCeWtMR1ErMGNvS3d4SEhkak1zNkdtRFdYdXdGQWs4ekpwUXdO?=
 =?utf-8?B?dCtVUC9FUm5YQnBEYzR4OUdsdEpTekJyd1IzRFc5Wk95emlHMHAwT1BKSG4x?=
 =?utf-8?B?aXZ1a29GaVkrSXVEZDVhckxxM1hydXpHMVJ0ck9lUzExZ0dwMitaTHdDQ3Ew?=
 =?utf-8?B?T2ROY1dGdGN2aG5ZMnZkWkNUOGRubWZyWjZhUnBib0o5ZTBTZnVHVW4xRWEy?=
 =?utf-8?B?Q2NuaGF4eVBSemRDVmxKOU5mUW8zSHdIdGNwNnJyRWVMd1Urbm9Hc1kzUjNw?=
 =?utf-8?B?K3Q2ZFdtYkhjV0F0SXJ2eStTYUlreTNJM0NwQlR0WDJwckZQVVMvSWJaSDdZ?=
 =?utf-8?B?dFcwcDlCNkdYOW5UQ0ZzbUYrUXBFeEwzTHN1eDc1MUlodWdEalUvYjdWMVRa?=
 =?utf-8?B?emQzZG5RNW9JRHRVZkxrc2cyeDFJYzJyTHd2TmZ5MVE1dlB6RStNczd0ZjIy?=
 =?utf-8?B?YU8xVGowYXhLZUpuNkxlcFJqZVBCRmgwd1FDTy8ydzFrazdNbURwWkZoQlBS?=
 =?utf-8?B?RysveXpEdjNnZ1pqclJGTFBMaXNvSEgxTDFGVFhENWVrbFpvekdlL21hc0FC?=
 =?utf-8?B?cCtEVVQ4Q1k4cUs4V2FTM09uMFhxZGxmek1nNS96NVIzbjdpMytheVowbWlT?=
 =?utf-8?B?Z2kwdWo0MDBXNEtFUTRHY2VIWnphOTUxK1hMSVJOUVpnRjNFcVFxNDA4alhz?=
 =?utf-8?B?M2xRcUw3Rno5c2JWelN5L1dMTkYybkExMUhOS3B2VUFwV211bWlLWU02VHl5?=
 =?utf-8?B?SDhmV0tIODU5bmFxTnhtaTlWWVA0cEZFRTUrTTBQdTY0TjI3TmNPcENmOG9V?=
 =?utf-8?B?OHVRL3JuRTBMVm1FMU1rZmljaG13YnFzYjBjYzUvQXNkbUM1ZFJvb21xZm00?=
 =?utf-8?B?MUpnZUFNWWl3WGEwLzcrdjJNVVZlaDVoZ3h1UHhSbFk4MjFaZXJvWDFLeEFT?=
 =?utf-8?B?UGpSTUxncHljNlluL2lUL0RTOS8vejhtU283TDRpMEFEbUwwTkw4K0JhaWhm?=
 =?utf-8?B?SFVWdXgzWlA2NXAvcW5qd0lGbS9JK3N6UUQ1YWpNK1ZtbnM1T2pZWmpZbDlS?=
 =?utf-8?B?OC9sYXdSakZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1k0bGNCWW8zcEYyT1ltMUxISzFWdExDMU5pV2liNDlsampBc0M4YXExcUhN?=
 =?utf-8?B?U0llRlY3dXRuakMwczh6RGFyKzA5UFdXOXZNV25VWEM1ak52MDVNQ1I2dTVo?=
 =?utf-8?B?M3h3Z01ESEUwR2FLMEpPbTFMQkRKanpyN2hPS093bXVodzhJZDFPSnFJK3Zx?=
 =?utf-8?B?TEhhTGo2ckdnRjN6L1BqRzRZQVRIUzFBVGFUd3l6OHl2UDZnOGV3Y1RZSjNW?=
 =?utf-8?B?VnFDdU5NQXNteWxrdHo4cmNOb1lJQ2FhdW9WSWNwU240eUI4dVl4dEFCY2NV?=
 =?utf-8?B?OXJWYko2cHB6QXZibk5wVTV4SWs4YllVVmRCbHRxelRITEJVM3RTbVFiK1lI?=
 =?utf-8?B?U0J2N1F3UU5oV09TRlJncXNPODRmYmpWMTNnbVh6ZUY3SE15NDcxQ2tsc1gv?=
 =?utf-8?B?QjFMTkxmUEtVa243dG5rNzNtaDlZR1luV283VTlsUEsvc09JTGo1UnIrWTgx?=
 =?utf-8?B?aEtEcjdPOUJBQmV1Y2xNaGE3QUhWYXdVZDVkbmt1dmRqNDFEa0FCZmZmb2hn?=
 =?utf-8?B?aWYwN2xYNTh5d1VSVzVyb2RTUjhEZCtidmJTSVlzSWV6YUZMZnpWSkZycm5Z?=
 =?utf-8?B?Vk1aRjEydVRKOURVZ2VIdllkK2lBbEFMc3NmSmtjd0RlaHpIeFkzZ1E5bVBZ?=
 =?utf-8?B?Q0pnODRESDAySVpJVVgwZWVNM2xlR0loSFp2WHRaR29JQ1Q4bHpZVUVWRitI?=
 =?utf-8?B?RXFtVUMxN0FaZkZMVUx4OHFEY1VmSXZOZjVUV1VkbXBDclQxVVFiaG8rN2d5?=
 =?utf-8?B?Mm50clRzRzNHNFJldjhZU1dCeENSd0lHSVNQSllaTk9TWWpMd0h4MVMwa3lR?=
 =?utf-8?B?VXBTQUNFM1lzT0tuTnpLZUdQTnExOXo4dHNwK2xKQ3RYb1E5eHJPWTVndnVJ?=
 =?utf-8?B?Q1JlZzZFUEE3WTIxUHVqY0pFVlczckdDSSt3NE93NWFLWmxzK2JrUDIrSTBE?=
 =?utf-8?B?NXo5TCtqbUszVklvRWdDejRjUUdCMENQVXVMZzdmeWk0UEtwcEU5cGlFL1Yz?=
 =?utf-8?B?Ky92TFhSejk1S3craUVpNkJRT01QNk5lS2RXSHlRUDgzOWQ2WjZKS3FTR2Fj?=
 =?utf-8?B?Tlg1UllEcjJ3UEpXbEl2TERac0dNNkdFcFJhYU5heERaQ1k0dkpKUGpoQWdu?=
 =?utf-8?B?M3NoYmdBdS9xQUdkaHpjVmVpaW5CUTd2OVBOTXJCNnRJUnVSandkZnB5TWN0?=
 =?utf-8?B?VlJ3YW1GVS94VFJ3NWwyeW1JY3lyU2cxZ2xCWVQ2U2h5VXI4clkvK1YwcDRF?=
 =?utf-8?B?ZVpEdE40cVAzVy9jMWY2Z0c3SWFzMFpmUVNMUHpxdmNCamRpS3BDZ21HSGRO?=
 =?utf-8?B?V0hHS2l2RC9DQU1KU3NLMnRqTmR4WGJveXNNNENDS3RQSUxGYlp2V3FGbjJM?=
 =?utf-8?B?ZHN4OEZKWUNEanowdFRUTnlobWdwZ2xGMTljRThGZW5CTVVKekFqY0hnR3Nx?=
 =?utf-8?B?Zk1SOUdIcExhUmx4eTZ1MU5JR2ViOVpSblpJQWphZDNzRDlXNHJhNFZGays5?=
 =?utf-8?B?dkx0a1RMbVFLY3lDdEIzZ05PQ1NYblluRFFDVE9NU0s1QTh6Vm9NR0x6dFBC?=
 =?utf-8?B?bXBhc2c3MVNnUTBtcDlieWIzZldueXJxaFpZUWNoQXF0aVJ1VHA5V2Fad1Jt?=
 =?utf-8?B?bXNSK3YzQ0RjMHk1R0J3TVBvaVVXSDhMVC9xTmhzSnRpczZnWEdPL2R4VDBs?=
 =?utf-8?B?b0dENDBQMllHcWYzbklEK3JseHcvR0JnZ1RUNFM4SkRtaHpCQU0wb1h2dE9K?=
 =?utf-8?B?ZFVEWkdoWG9Fb3paclgvSVhSaHBCMTFlUi8zYTQyeUdUQmVDNzJZMkYwNmZM?=
 =?utf-8?B?VjVTRFpFRC9xTGRDWXkzY1BtRzR4d2RCK1V1RlRQVTBCM1M2anAxd1NwNXF3?=
 =?utf-8?B?Q1JLZVRlSTIxSVN3Z1BIMnMvUEpHNDNzdEVXbmdRNVNaWHJ0cUhtVUkyaUg1?=
 =?utf-8?B?QXJRYlQwbnY4S0gvRHNqZCtJVlAwQ2JuVW9SRHB0eUFWT1BTOFBXMkdpVnlG?=
 =?utf-8?B?eks4bmFQQW8rRVBjeGJqR0M0Z1FVK251NWdWS1ZZdm1EaktaTm1Bb0hQcHhy?=
 =?utf-8?B?bnlBOUV6Y2QzQnUwNzlmam5ENS9KNCtMbWJ6VFBVcmZuZWkwcDBYNFBSWDFQ?=
 =?utf-8?B?K2ZDbnp5ZnhCTXVRRkV5aDZjazJ1WFF6Q2xKS1RiUHhIaWpRV05yKy8ycUtx?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC1883A591E5674BB9AAF491FF5FDC3A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZRXB+Tnxe8TV3t9HT5ovZRcjdKq1bsKLHTduKWAx/FLU96kHR/ufBLtkxh5/5AOknJM58ITVQegQhmWb72VuMVzC3BiGg6cmVH8Xpi7x8bttx4lkHVM2RHxR24+HTqSTPWjxQjoa9XuZStYfcQm1S74zolP05mqV0/Ya+k5v65XIC6e/6BmOl/TqzqtDdEXX+b/jywExz5vGbl4xtyxn21Bm11gwTRxUeSXCMSZfYOJJgsxTsaeNEDzEvWZH499nbq4JtFYuz9P36b+kRXvbE/Ims/Fqs3lQZvRLVxG1ifbxq6GdjECWb/ay5e59PjCLuwCH5MDTAR/0+58osJE0ht1xKjkqn+Cl9RJzAPCWn6LdLNWjH2C8XnjA0igz84OylKmm2bAjNwguc4s/RCCu+BE7OBYjuMAP0XwVRtn3dciZcDLSDU8x82bm6D0haSWbFEauDcaXJrqLUnRlisM5JbVy3MfvngVV4B42laj4Gc58IbMKaQSaxlk7DruXTX+N8rs9/U6btAMrlJkWP0YzKkaRnkpJRmyv8IoKsGlP3WOmGxYkRqjk9+KtyTWk4EobHiS8HrUp6OMS8ejkBeHJW/fM5tJzMfThT18bVJS+hWhz7Wei8HnCtpif7HkKv8yy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b996f5-daf2-44b0-2020-08dd970d9e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 19:44:49.8538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmJRxliYRSuZLOJBiQDBUoyKM74MHIJ37jG8dVFSF3XVsUx8DribIlgQM1E582lLMo1L7ABRNuTTCvW7vbmEskpvEbS3nVEwhgbZkCDkEj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6842

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQpUZXN0ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdk
Yy5jb20+DQo=


Return-Path: <linux-btrfs+bounces-4347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA778A82B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D1F2879CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0A913D24A;
	Wed, 17 Apr 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OYqvxvk6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Q3BE7t6D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B113CFB7
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355306; cv=fail; b=HrspcPBqpV6Gl+jbZfrKCs8kXp96w+J5+vFvfcUc0DgLrdjgMkgeEQf76TIy+RRo6zlf3o5horTnSRVRgisM0hStNtRfa2tN9mnexsFoLUZqLcmnF88WjU75FuISK3XGpVo5448oJ05NvDb7kZSNgzcPUALq5OhM61FdqGFm3fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355306; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLrUBmFUWeMlMOPw1ObbcACc+8u8s3o/VRiuE48a4SK33veLtjmqbZSvG+2/25Bxbs/NPybHpREJMtYyd3oJcv8n1zuyPuohwpGFQcOmmkit1Cv5y0EC9HR81wD+DyH4bPlNiadsDgIiO+VpJY8jl7PbVKaelP2ymFf/JfeEoDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OYqvxvk6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Q3BE7t6D; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713355301; x=1744891301;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=OYqvxvk67Qme5qHBNGyjQ3Ke7lG2EqDsRnMfGAm7s/VxSgp0wja5tpIC
   JE29d3Q/gaO60H/tv31H93yHykFyBf1V0FuEVmeHESRbn3n/2P+/JfINS
   KNGE7Y+KK1QR9dZHtdgnqMvvJLRH/SS3J2+f73de/hIUx6iPfdUHo++bB
   ozUORm1NDreyZ83Slb7+J6wTMA0igfKLsImSGzxHdn/RsdGmJ37pbYYsG
   frFV5zbBhygwScV3daBCHWJNFpZqfk8iijB47McykKOk3ug4BgGUj7AGi
   5M7Unkri6AUhz2hRfxn2Y+eFf4E4WNRBLtrsoa8ZxVUduY/WW7SMGMMy/
   w==;
X-CSE-ConnectionGUID: VTLM7ubkTimbsDTVRYt8Tw==
X-CSE-MsgGUID: 1dPXFz20R6ClDCTZwnAQCg==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14216918"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 20:01:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5RQZRrDTqhStSuzg/RVHyYTlNLIWne7hs/Kyu5T6gxaDa8JrkdwCr6qnVrYRiD1pK2Uc7Ix6ifEvHzpsNc9jfqr+ss8qm/XMaBuhYRd2S4hj4L62ZVeth7IjazFLxDarh8WhlnvIQsgpm/V0tgM6djDhSZyYDfSDtqC4zXDVkWQj8/tVYFNFAvSBH3kbMsWuMeZkg4pwPfwGoRB+lWXB3PyidriyBVthEvC9Tm5hl9Tp4oK1CDooSrWe4w1Wv/OJhMMlGBznx4uwv1SSGOlyECjLlyR1d2lNWwsyvPCrv+a3vCE3XySEncUgqfX0dv486foj+uvyhR0OsNpl//AAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=WuCujMGmwfEni4IyQqcxOmKUM8gaHrcW9fm4G7Q87kOOvfDKfuZQBzAKu71LknwBQTXH2ljraqipLtxMoAppD0JNpHGxMx2yy0C0EmbJhmvttkW88AkMooWltfZcG2FqXHzFNIQlB3nW7C1cEjNpFL4v16HNfiWTR++t9PgS2KLsR9A2tRDYbp/zFuu2f806nBxHPDk3p9bqIalVKi8e7TI/KGuXI3RiuNJnXv3lzl+O/LLNlcobkRADsBSL3eqfYCapEKANfteg0/GicEo4OdVELDG7Cm0tIRhaxOlBQGBh/rECqIxYvCoqrt1fFe77EqHhcZ9B1aGBfyLFQZbTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=Q3BE7t6DAsJ+6mgTFZ5hd6SdC8tO1LUFbbRMkIQchv8173NEQQ1FQ56Gfef80gQ6I5ZNHIKUsNH5vdxo5goBX+x+XmMmco9bW2f0qd4dMQlHTJAIWYO4+Wfv7A4j3wNMDcW/3W7zYkPd+7BU3JQSszSis0sqxuRaEZl9H/7MjhA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6488.namprd04.prod.outlook.com (2603:10b6:a03:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Wed, 17 Apr
 2024 12:01:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 12:01:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: change root->root_key.objectid to btrfs_root_id()
Thread-Topic: [PATCH] btrfs: change root->root_key.objectid to btrfs_root_id()
Thread-Index: AQHaj3KBDQkBQizOiUaZODLVMiDGYbFsXxYA
Date: Wed, 17 Apr 2024 12:01:34 +0000
Message-ID: <cc000956-ce0a-40d3-b596-481d95e01d5a@wdc.com>
References:
 <08243e0283d6f10f9f289b0963f385cf271bc796.1713212438.git.josef@toxicpanda.com>
In-Reply-To:
 <08243e0283d6f10f9f289b0963f385cf271bc796.1713212438.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6488:EE_
x-ms-office365-filtering-correlation-id: daa1bdb2-0692-4d7d-1a8c-08dc5ed620e8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 05L7vQLTxqGjBelLopP+xmb89keKR3mEaO/AfoHGFUv8pFmKnNAQW2hahlzTvbhEfWo4cbcCWMoKrDnQINcm8EYwzpjRk8D1EM69JYE4HTnE+abPqEw9LtaYL6GyIuvKoB5fl/J+XP2bfMZ2f95vLD5CikUap8iQuHiVquUtaFt6IK+402O8kRM3A2BWIZqgIcruMohtZyOJL89/3V0WHdFTbIPo6nc1BLtJDaU/TxoLRb2oOgk1JaF1jRnZfVfmkQpkuk4cNXoYZrumn1vAB801P7SLy5eJ5VSuRzWcCa4SzB/1hzg7WxSQQqF89Sve1sV7If3+2IiKKLZr1z9SLz+pC236vtb95fgHRpz2L/tzj70RDzFo8AsI+qETXUn8fNFC+FKjnbr0lDqOX+jbVwfosGJbrPsXYlpG4dQr7mCIFK6jcAtoLs0bq5bKtqsCZJMT4FsF63x/lT61mRCyGCD1pe6+HfRTnFAyGRAcXV6eCzRueEuOgbnK5MIcpXfIaDYFPCnZevp6wbWTTc980L2ZkBQwhRXYwpeHkKsYRZLnUZHDKpWbgt9CPu2MEPLivZa0RQ78OTQA1HIYGtAc4FYV1xbyBzWnxFjpkfN95+7/nlPrMDS9bMtFXC9P9+hpjQBI3EomXZLXFg8VoVtM5MCQAVMOi4g/Pyq5WS2a2BAGhCCLcYYY+iqySiADWa+Cx2dqiSUkDeAMxUg7sEmiWb9ZHgbbE61pXCqDz/ukBOA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnIxZ2RyRFdBa2kzRW9RZzRIRVlxRHk2cDdYUmFnK1ErT01odFNuV01vU2pB?=
 =?utf-8?B?akZvdGRETEtHdkx2ZTdRTHd5Qnk1NGc5Nk1RMjhxaFJCYnU0SFNjOEpBeVZk?=
 =?utf-8?B?cWw0SUMwaURpd3hXVlVtaTZJb1MzZ1dQeDlFR2pYdncza1ZFWXVwdjVqcFc3?=
 =?utf-8?B?RHhocVRkTlFSMnZrWGVtcWc2NEVETXVmYjRJUnRReHlxUzNZTU0zVlRNcGVt?=
 =?utf-8?B?UHJrZmowTWFFWHhVTjIxTHRscnZVRWJtWm9UaHRNYjFqSmNHeGpXZnFNQ0hh?=
 =?utf-8?B?NHVVelpLNC96eDFCc3J2Szk2d29KM1AwV1VIajRqeTZqK2tvdFJxS3lzaGxw?=
 =?utf-8?B?ZkNDZUtXWHFtMEplWDdGYkJhaC9yNCtmcTNxRnJPUWFWOVJZS25DUEtkcWpO?=
 =?utf-8?B?T3Y1RUJra29aeEx4NUNKcFhRczgxTTI0SmE2ZjRZcjB4ZERWcjYwT09RbVdr?=
 =?utf-8?B?MXZLMVBycnFUZkpHL3dhOWUzK0ZvNlVRQllTNVVZbTdhVmp0WHh2bUVHcjFr?=
 =?utf-8?B?WXd5L2MxYXRmZUFCTi92bDNLWnV3U09zOW5vRTg0WlQrUjkzZ1piNEdiOEhs?=
 =?utf-8?B?WUp1NlhxeXg0WW1QSkNGcnNUbzN4WklHUFBVaGc1bDJyWERMUFRnYmNwWkt0?=
 =?utf-8?B?RVhUZnh1aUNVR0Q0eEd5MUxtTFNvOUtmWmlrTEUrV3hmaXVGTVRLY1k3MHlt?=
 =?utf-8?B?YzR2UzNzS3YxNk14Z1hzcFQvdytEazJtaERlaERlVjdrZnpVbGwyM0s5SlZr?=
 =?utf-8?B?YjJENkZNYUdXYXJQaUQzUXB4eXVja1FmbXVMK0c4a1Fxc0dyZ2dQbzBESHV3?=
 =?utf-8?B?ZThSZmZSZDFyQ1BlbkM2TzRqZFM2OUIrQ29MTVNXbkR4bCtNbkx0aXpUN052?=
 =?utf-8?B?a1JEcGVxNXNKSkFTcWFZNHNscGs4SzF3YXYzUXhYd1NSd3hEaEZGNEMySCsw?=
 =?utf-8?B?ZVd2a05sRnM1dXgyVHc5TUF4a3dsZERBR3NuL3RNTXhiZmg4VWJLeVNPWktW?=
 =?utf-8?B?N3M2Nm1nd1NzQ0JMeWVTUVpDellvM0NpaGhLVStXMHd0MVVFeHdwdnkyMkV3?=
 =?utf-8?B?V09vNE03Z3FWQjJQMTRrcUdzSVB0aWxGdlYzbWZSMzhtVXltS1BzaU4vWk1Q?=
 =?utf-8?B?a3oyOWlvbWpnTXpVOUg2UTR3YjkvT3k1SVRXYWVhdzJXNWNJekpqK0phbFRM?=
 =?utf-8?B?cFpDdlZnQzVLNGVsVkFxeGhpVXIwMktOeDlMK3FSNnVLcEY2RTNQb3ZuSmMy?=
 =?utf-8?B?R3I2QVdQT2JQOEM4Q0tJdHVxUlM4WEVMSmtaRDE2bDg0NFBob0J2UFJrS0cw?=
 =?utf-8?B?MkJOZXFTeVZWWEE0aU9HckE4Yk1RZE43VnM0WFpjc1FyVDVCa1VJSnBFRVBY?=
 =?utf-8?B?VDZRK0hpd1NxaHJxaWkza3hoQWNyQ3c2a1dRdVpXRkY2aEM0M3B4ZmVjL291?=
 =?utf-8?B?VW1rdGNudStEc1g4Z2NOTTc5OUNOZVZ3b3UrQW1mUUlFRVJtUDk3d0tiMU5U?=
 =?utf-8?B?TFpyTzJDemswQUNkaHdiWHpiU2c5TVFSRXhQbHlUZnNoYjdtZk9ZNWZkUjdE?=
 =?utf-8?B?QVJiNkN1aVR3ZHIxeE1mOFk1V1VjWVdlQzgvVUdWajNoaVZaT1YxTUxENVoy?=
 =?utf-8?B?ZXRNTUpzbktaK0trMlVlQUVwM3RTOENMV0trL0ZhZzhLS3pOU1k4MCtpWW5w?=
 =?utf-8?B?RDJpK1dvV1ViRGRjck5WTWYvai9sLzNOSXgwcUw2LzNKVlZYVjFxenZqYnVk?=
 =?utf-8?B?TTg3cWsrY2plVFBoVjJZb2dsZVd2bWNVc21iRm1hVTAzWCs0WVZlL2ZGVjNs?=
 =?utf-8?B?YkJwMTVpSENoK0RoRm5BQ2xmT201WWV2L29qNkJRZ3JaS0dHbHdWMWoxdWVt?=
 =?utf-8?B?a3dBdEV6WGVLTDBUZVYvdERSUlRhdlJsb3dwM3htT1NOMFU4b2ppbFgvcS9S?=
 =?utf-8?B?SjJrbnptRWFGTEFOTWlUR3BUcGhCaEFQUmxSOGs2NXNOU2JJN0ZMYzllK3kr?=
 =?utf-8?B?cmczMFBKUnJDaUpMMzZpOThuMzlBTml5em5RZ0tyR0VacG5zRklFVDd2WGw3?=
 =?utf-8?B?cTF1bGY3Yll6aEVCYk9mZlBkOEZXdE80NW94NzR1TkdUa1pJZFN0aS80U0pB?=
 =?utf-8?B?YW8wb1o3MUhJd09kUU54N2JlaG5nQ3VkTnVLblUyeVNLSlpOZ2VQcVV6SEFi?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCE7A6300B441247B590CADC0C37CE9D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8MoUh5Nx5Nwb46Jvoj42ST437sm+0lirbMXdNXL43AwS86DZ/6iPFZtIDyMmbbfa1Vt6VPoi9XuAxBEtJ3r1+dwOmjqm6oIapjbgD9Zx+HbsY6O4hOQ7oy6eu1jxy5YeZQwGDfr4pqKd9hTL+yI4tFAOP0eXBsi/3MI6fOHSH/qbnuSJcMw5PWXWFlxLlBF5XtZNZ3+OrafwGg4uEW8vNKzQOBcDxDFtTpQkGYiW0Ql19Rfnc3RZFs0I/4P7sdSsHb8HDPY00R92kouL3s5BXCbkTlejhymeyJzNpKU+sK7wkJ5g5Fcy87VEA/8tmBQWZrBg61pY/JZVIhVgrPaaisOBci0sXMTnwpDIV1eNmO8qCSEij6NFelSzA/a3A1K7KoUQFfDwAxbI+jQ7XRna/M26k2YFLfpE0gCDcLSGUk0CILlc9XqarZJ9M+uBhJ8cSiMTWNEzJNNguQApslTavNBmrXGfAh2TfuMmpzFesIZJhz4u4iZbl+PmGGZc4cG+3QqpXq8XGWUZcz+CC8QCZkFauN/T/V37bTaDvjNTWktfeSpMuZsJmDG4on1GKTToupCFLP8X+MdFUFqpQjDJCc79NcxOV2yzLitumQ7ZM7L5zjWXRbQYggfE5ErVIH15
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa1bdb2-0692-4d7d-1a8c-08dc5ed620e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 12:01:34.7496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jea+KDsqSx9/rpPBeFpAd90uONxhPk895/pSoGXLvJOcqYDgzmZNhBCgJUlJIu/QFuEkKpziYAlWJClFSavd+W/6I1Wz4I67cGqP7oFrqzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6488

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=


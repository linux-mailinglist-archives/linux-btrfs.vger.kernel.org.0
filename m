Return-Path: <linux-btrfs+bounces-7189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84981951B64
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4C9281DCA
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8801B1420;
	Wed, 14 Aug 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MTg63/AJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xAWgwvDi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332D41AE867;
	Wed, 14 Aug 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640894; cv=fail; b=m/Us3miBp8Y/kyBZqUCJAPl2ze2ZYbgoAEtsmSBkqUlJQnikTtOVSzGq0LcWQAHJQcHdvDIOO5OPxLo0UrbmiUfqlYvpZIBb6Fj3PY5nqF+99C+JjMr9cJLiq+8YBpnTjFMP6n9VAoOu97Nnu/UQDLwJ+dRc9nrLFQ8iaLO1Ve8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640894; c=relaxed/simple;
	bh=cEQwsPsKdbzaarPtjGMglqEox5LrQP8U4M9COsS1vC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qzs1OqW5E6Jmn4dAG0zxRmZ/xlz2cMWzwlXXFDMiGXwiQ/DOsFPgPMl94cagp/2DTxNANN4RNLmik+EQwuoLDTwbY6mntM6fcuxFBHE/SRMDTXqaskXs3DboT6k3bikkmORjAo6LzH9Tk+X/xZ1sOiFL8NI727LXfXkQn7Glltk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MTg63/AJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xAWgwvDi; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723640892; x=1755176892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cEQwsPsKdbzaarPtjGMglqEox5LrQP8U4M9COsS1vC8=;
  b=MTg63/AJufRzBuDmvtY6wlpOiPI7HoNR1CGrSmWFz19nBTjVbRuwyHLm
   gOcqR+922nQi2p5ZYbB3fomLGFzqYdWBJu17wlX+WOzks+KvR0cMzDNWV
   5tcHyD0l8r8mV/jgmDfUhU6VRxD11WAGGDIJfTNfFqw+axUc+SWPHZTM3
   jdz0PVi9xUoUUjwPvYzkIEtgNaF68NofJak8iZIJLKNKcYze4zDEZHB0M
   tBUWE1dEM9ZjwOMMfeLyDb63Bq/rU7NoRRnX4yd0uDuT/b7k99DF8ftQy
   u/KJ+CICD2P0MM1cV9rFBOG7V71wV47vNzmZ53w1XQpl6MxDTS9MsVxg/
   g==;
X-CSE-ConnectionGUID: v/TcjuoCRmO6kw+bzM+8FQ==
X-CSE-MsgGUID: s72X2jYoQvGR+W8Cl9+hWQ==
X-IronPort-AV: E=Sophos;i="6.10,145,1719849600"; 
   d="scan'208";a="24241734"
Received: from mail-bn7nam10lp2041.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.41])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 21:08:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/hzlnsXWpEMOFWcgY5nAV1CiCW3xXfkBKRgkWpMUMzGUVB48m7EPdtX1rVTOkj4IQ/83iSniMndHkGdhT5g7AyVxCcv3fBGfc3e1iKy5w4AF1JuthdSmidlrYazavEdeSTu6NTWq9AbeYh3kZfPWO0GNc8lNHsmRhDk/vURoDDdixDFXwbm5yG8txwIBMV1hS71ylUFn/vIytAn5vzRytkgBlqwBsPZZRETgC19GOfOfTkjObM2O6KDZh+lTOOedSobFW3RJtOai3puZWRsb9a8fk3LJVTv39rhg8QpbKl7wyuou/drqQaUiQ04dXL+iq+KICRfsFPf5dCj1cpE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEQwsPsKdbzaarPtjGMglqEox5LrQP8U4M9COsS1vC8=;
 b=sf1DGbIjRHrnwkwmRYwbg5SbTT4GLDPfWFOtNXxinbAwfwocTMvYJEmSc7Etk04bgd9DCrgpbL4Gqa7Bpv9NAxeb9nBElug5RuMmByiZn1VPYwAX4Es1AxqUTPa6dHZSgV3G/nnpD+E+fofI7TPd05oAJmNi6VTOXmiRX1C+itiKuZVdJ2OctcMDkJjjDs3n6O99qPzsnCjhOba6O9LtAUxr7VmZv9z8/M3qa4lxzy7lAeOWa/8klGYQhqtiSMbudyRdWgG/F4N6wf9odQ/yZ9P7DniGyzcNiBNLakUJosh9Higo/fjkYZaw47967IUVQTalPAyb/qdA3FNty8pHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEQwsPsKdbzaarPtjGMglqEox5LrQP8U4M9COsS1vC8=;
 b=xAWgwvDi/LQUEGvQtfU0JTwvFVdpcg0XCk2eIJp9vHDTxEUZk8j5w8rujKOIesiLIKu9WTmLfyn7DXYhXfSqwTM7YRSu9YppqSoTIea6xUEvtUgkdpvjfAa3xUQHQdimGkxLFe80zP7mYySpK6L+RBCJeN/ras/PeNXWlW0UHEg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7250.namprd04.prod.outlook.com (2603:10b6:303:65::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 13:08:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 13:08:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: relax dev_replace rwsem usage on scrub with rst
Thread-Topic: [PATCH] btrfs: relax dev_replace rwsem usage on scrub with rst
Thread-Index: AQHa7kfrHnST/6cpJ0yQOSc010shd7ImuXEA
Date: Wed, 14 Aug 2024 13:08:06 +0000
Message-ID: <3a9f47b1-c8c7-49c6-b3ca-5ad5b68cbd8f@wdc.com>
References: <20240814-dev_replace_rwsem-new-v1-1-c42120994ce6@kernel.org>
In-Reply-To: <20240814-dev_replace_rwsem-new-v1-1-c42120994ce6@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7250:EE_
x-ms-office365-filtering-correlation-id: d6d6409d-d847-46e9-2ca3-08dcbc622352
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnhEd2t5aDhiTDUyMzFuclVpZ01ieGZMS2EvazQ5eVJndzlneWI2UjBLeE5a?=
 =?utf-8?B?RmJBaDc3TGdRaU9neTZvT1FLRkY2cU84Z2tMOWJWMFIxZU95d2JJRVMrU3dI?=
 =?utf-8?B?RjBTZkI5RjlvdW9VZmhpdE9XVWR3UXFSOE54RTFHbldiVW5xdCtXT0ZzT3do?=
 =?utf-8?B?T3AzMnhGV3ZWRmZrM3lUMlRTaThMYzBHUmtIdThsUk1rQjhFSGRzNWdpeU03?=
 =?utf-8?B?b3VzMEdTK1lJYWplZTJuUEZvSWl1TTZFWVFMdDk4UjZDTVU5WHZiZ2tRMWFp?=
 =?utf-8?B?TnlSb1NTMzV0YWVBZ2VmaGkrdjhjVkJNWC8yUGZlNGZnekxSL1ZCQXFRZ2R0?=
 =?utf-8?B?UU4zajA4MllCS21XaWpabEsrU0RwTnJIVnFBSlhqV05jd0ZPRVRYOTdYbnRu?=
 =?utf-8?B?SmhkNXVtcUNGdUZIRkp1ZXRVUG1VeXdFaDE4bUNFVkhkTDkzUGw0OUk2OW5S?=
 =?utf-8?B?TEhydFhNZ0t4RTV3dUduWjlGajFhNlhmbUJzNVZOUWlCVDljeG5IMi82L2Ja?=
 =?utf-8?B?bUc2RUs3KzFXN0pmaWZtWXJLSUNzVWpPYmJScVY4ZkJoTGREVDdqd0xxT1RL?=
 =?utf-8?B?Yno2akVOWThsUXBIT2VSVFlFcm1BQUlIM1N3S3AzUDNEL2Myd3phQWU0U2w0?=
 =?utf-8?B?VXBPQS9KRHp0ekUrVVJLOVk3dkdjWUw3SUdxMXdCSjNhUHhnMWs3Q25GcWhO?=
 =?utf-8?B?OUVWWm93YWVTMUNnMVVaVWJtVDRDd0xnWnhrdm1rWFp1ZjgxQ3V0cWNmKzF6?=
 =?utf-8?B?MitETEp1UmJMa2RPZW9raFpJenZWYzZqVVhKVWlxTlgrUDFLUXJ1U3dndm5q?=
 =?utf-8?B?ZWdZMWdjeURrWlV2RmpIcEpzaEZIQTdrWUZzblJ0TFh0TXEycGFzQzduZ01z?=
 =?utf-8?B?OWp4L0pHaWNEMHM5WE9Ea2ZiNzA5TTZhVjFIdVFBTjZVZ1p1L3h2L0Z3ejNk?=
 =?utf-8?B?N21jZnlvQVM3bGJGcjd0aEVpdzFnV0FnYlVnNnJuUmk3bk96KzNHa3VQNHRr?=
 =?utf-8?B?MjhIeFJBZ3IzUjBseStVZGF5T0JUcVFlKzY4OWZIbmtoR1kyMEpHWkxRK2Rx?=
 =?utf-8?B?VU9MeUtQdjF1c2k2bngzdnBBdUVQdHpKN2YwUWNNNGd2THdubUVlVGpFd2FP?=
 =?utf-8?B?OG44b3BONlMyK1orcCtPZUFvQnUreW5hYnJLWjE3YSt4SHcyS2RWQ2pWMHRl?=
 =?utf-8?B?Zzc3RW1BdzZmaXN5emFLVUZUZjFQdlo5VjQxQ2FRWWlWQ2xXbjB5TExsUHAy?=
 =?utf-8?B?Z1NlNnlJTE1QQkZ3bGZEdUwwcmxsY0F1aTlnVTZEQXdjQUUwTXZKSFhFSE01?=
 =?utf-8?B?UjZLNE50NTZydzJxeC9oWVQxQjBmc1loSFU0S0hFdWlYcDFHQ1U4UG9lL0l4?=
 =?utf-8?B?UmhxN3RiWFBBWUtRYlY5Y083UXRadHE2T1JyVUYxNzl1cWYrakhVMDlwZG9p?=
 =?utf-8?B?TU1qYzdlbzVtbFRnUEFHeVh1SFRaVXFrekFWR0dGbEgxcVR6N0tabG1CTG8r?=
 =?utf-8?B?VU9lbEY5U1MwbktKdmtTVkFBQXFqa1FZaEcxRkVWaTZwK0R6eExmNTlpMXRZ?=
 =?utf-8?B?TE55STBVSCt0OW9YeENFaC8wVytUSys4S25hRXltQUdVM2Y0UU1lQ1l3N3Ey?=
 =?utf-8?B?QmJ4SExJUHRpcnNreFhsTUYyU001UkFzY2VqNWllek9sZk5scDhxL2hNaHhm?=
 =?utf-8?B?NzFWOEtmT3RrMlFYWWZNL3NjaytwMUhIQTZnNEVZSENaeExKa2FIVHlRQXlu?=
 =?utf-8?B?Sm10UnJFOGtDSVBJcDkxWWcvaGJDU1NRRldHeWZBbUxlOXNXckltSzVSeHhU?=
 =?utf-8?B?Z3dDSk5xVHVtNEF4cTB6NG5qOGpKaGY2TlIrSUhubnNUMy9UQ21UOHVGRXdh?=
 =?utf-8?B?TlpMSlI4cGpUamVpUTYxd2xjU1U2SlRQK1dpQU9ISys2NXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUVxaWRkM2FBcFhjNlc3OHdEaWdveENtckUvME9jYWpHRGg5aWxNVEhJMXpY?=
 =?utf-8?B?S2h6ZDVNNGxlMmo0MWFPUUV6TFkycWNZWkhUdjV3WCt1bnMwRGlxTXJxdWdQ?=
 =?utf-8?B?TXozOS92c0F2dHVMbE5UbUhTeTlMWVJyWFE0OHVIODM3K2cvTmVkN003ZGwz?=
 =?utf-8?B?S1UvdU5OQWZOT056cHlTcVRBeFB3dFREVUY1bysybEFRNlpmTnZaa0ZYYzE5?=
 =?utf-8?B?Z0R1Y2VQUE1xVVZtOU0rUitlK0lkY0lOR1JyVGltNEFqOUViNUgzdmQ0emxY?=
 =?utf-8?B?R2R0QlJtZFA2WUx5b0dWZmFQVU5UWHZ1Vm5URGs4S0I2dVJrQ09JeGp1L3RN?=
 =?utf-8?B?UWFEZkF6K3YwaGErRWh4ZVdUdys3SE5USUkwa0wxN3lrbUdRekR4V05LOFhR?=
 =?utf-8?B?azRUUk9VS25TU2R2cFRnRXVJUStGUzlWd2lvQVJGYTZXbjZuMFRIZ1RnRmk1?=
 =?utf-8?B?V1V2SmVMZElVak44SnJyTzNtLzBNaGVCTWFPbUh0U0pTbTlwcVZ6TXNUUEJn?=
 =?utf-8?B?OU0wd040bUxFV0hFeFhGbTRUSTdWUmhsODYzMncwaDlCYi93cWt0UTZYZllP?=
 =?utf-8?B?REtDM3VqczA0amJLT29BdmovV3IrOUV1cmtvUm1YYUhPaXJMUVpYNWpNdzhG?=
 =?utf-8?B?NndzYmtpbGRtekRSOEhXNnpKWkVheXVhRjBDd2dSemtMcVQ5Z0NaRUljT0Rs?=
 =?utf-8?B?eEZFWkRxQlBMc21venQ3c3o2ODV0VnpzNkxXb1I4enAvd2g2azhPRnVNTTRm?=
 =?utf-8?B?cDdYSG96aTBBeWRCenJvYmdoL0NieXZaNE50TWRyS24rdVhYK2QvY0F5VCs2?=
 =?utf-8?B?cjRaWHgxamljNzBYTnpYNWhtbU9GNVlCdWlOOHI3SnZNRDV6RXRRUWFYQmE2?=
 =?utf-8?B?WG1uNlU1UHpkcGhVT2MwQTN5U0l6cnBBSTRwT0I4S1Zvb3g4MjVxU210bmU0?=
 =?utf-8?B?dEg4N2VwTlc5Z1I2V0E2WWxGN1Jsd2NXOE1GK3F0VFdsS1FCWU1zNnU1SnY0?=
 =?utf-8?B?QWNSaktOdEFXUEl6M3FLSGVwSkZjWTVtUS9kNktJL3JxRGFaVUtuSjV3aVU4?=
 =?utf-8?B?TjhBVHArZ1ZsUW5LWTdDUHVGenJyZ055NFZOWW12dUd4UEV3RzdZaG5hQ3lY?=
 =?utf-8?B?SDk4V1g1aVNEbTEyU0V5eThidFhTMUdndS9NOVU1bUo5QTBwbHc2L1RPWGky?=
 =?utf-8?B?Tm8xWDFHQkVlbUpESE9oME9xVnExNmFySEVuNS9qamlRa2hjZkRzVnd3enRY?=
 =?utf-8?B?QXl5RWM3WXc4RU5vU3VNeHo2MHY2cHhkOTB2bUxkejgvUi9mbndiem95Zm1Z?=
 =?utf-8?B?bXRKWWdFRGxsVXhWSW55VU5XZDhTZFhnSkd3akg2bjlDT0w5SW9HOWtPR3o3?=
 =?utf-8?B?SUwxNllVWFNURmltcDNmM0I1cjc2c29LaDFWV2ErSUVPaEh3WjNjd1JvUXU0?=
 =?utf-8?B?OFc1U2ZGTEt0SUdKRWI5V2RhcTVoUnZYbWN3cWoxZjBXbEtkV2MwSUJ5RCt3?=
 =?utf-8?B?aUhVcGVERkRqcGpyeHRYREYvVE1LeTVVN29KaE01L29MWmRaVGR6YTlyUys4?=
 =?utf-8?B?NjlydGNWa3gxR3dqT2Vya01xSytUdDkxWnAwdk5SODZqQVpxUjR6Y1V5QUgx?=
 =?utf-8?B?a29qZ041MlBheUJBby9ScEpqVDlPaThQdGladkNnUTV3VjdJNkZSL3czM1Zp?=
 =?utf-8?B?OTZrTlpuSjNVSjRSOEdCeTEyZVE2czFHSnk5NGF6azkxTDZmWnlGRFlTVW9Q?=
 =?utf-8?B?emhEWUh2U0VSek52cWpGZDlQbHlKR1JvTU4wV2ZtU2s2QXB0S3Fka3NXdldE?=
 =?utf-8?B?VkswekZXbXpybzF2MG9Td0tvL0REdlNLZHlZbjBVTkY2SGdmM2JsMStpYWE2?=
 =?utf-8?B?OURqNHZQeU5nUW5FdVVGLytqd0pwZEtDYWVNTmVDZERGQlNBaEtmVVhJcEVT?=
 =?utf-8?B?d0xBcFpDTHVmbG5MR2wrM1lxQVBKR0VqbHNobjRJYmRESTYrZ2ZpNmdrVnR1?=
 =?utf-8?B?Yk9BMU1EUitMNGNvQW40Y093WGZVZXZhdnpnbm9pa2tDNnpaNW90OUZXZk5x?=
 =?utf-8?B?VUJ5eDVQNlhSZXpCYWxOWEZ1bzB6WGRmYXhWb0hGY0pPV0VGd2l0TloxSTRj?=
 =?utf-8?B?NlFjRzRGY29aM3ZvaXRxRzlOQ2hDNFY4c2ttUHFFZlZERFVZb1pIZC9abkth?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC0AEE2AC80942458DABAA5171097C8E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JoGhTtZ0IXvZNdtWZt9areKRXb9v+z2nvg1jG9HYWUEKOrXyQbViOdOU627lD3RGMNJs5TBrqv4y0ff9xam6SmunucKjQZ7Qf7k5+aWeUMJw96xrM4PBwoBfvLcLWtjICtUBDtd1BKcSLq+niQp6Rkd59Yda8zlWmXiFCqgEvOq7gDgGBgaaQI4+V41SjEthrViDP9aWq9t6Crpvxt98T6gDSrh7+Eut2CidgZ4jnMKKxdq/CIbmFzHBATo5FNvFJF539VuDkytGuTOHj951JuCQZM+Gvw4K13sH7EUR6SPTrIZfApihvQ5sFQ7ZC6WuuUlfmwkNxK/I0JWaZScwsjBSAVzyy0TlvPObn9W2zfWbaY7kwiKVng+kPegfPdGV2b8tsQbCQvpCrpYteR1N+bY/0wq8fWHMHZguz7dcGpK4vKuCp4wIeL2ursgTgUdPkIrFPBRTQQdD1byHdASv7bA5BJ/qfYdZClCHpFVNoKv829NQNBt6Guy3woqmq5TWCEtgR98z7cn6nwlB/AG13ZXHXEQ8tt9eJajsEtL3996wq+sxD+F7QlhZEqRRz7owLGtbxLlmPl6heO6nzTvlBl1ihIy87vxZ0qp0j4CodUjGPj+T58ZahFJKhlhq2inb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d6409d-d847-46e9-2ca3-08dcbc622352
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 13:08:06.5155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bT2vJicZo7pdsa5dWM5nlYvjUh6Jy1zP2gqv49mVAptjcq+AopDpobochJWI8Gwzi7JiQ16D7Dn3tF1kyiGX7BDqhtsm1IVpYLYOlpdnLoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7250

T24gMTQuMDguMjQgMTQ6NDYsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gKwkJaWYgKHJz
dCAmJiBkZXZfcmVwbGFjZV9pc19vbmdvaW5nKQ0KPiArCQkJdXBfcmVhZCgmZGV2X3JlcGxhY2Ut
PnJ3c2VtKTsNCj4gICAJCWZvciAoaW50IGkgPSAwOyBpIDwgaW9fZ2VvbS5udW1fc3RyaXBlczsg
aSsrKSB7DQo+ICAgCQkJcmV0ID0gc2V0X2lvX3N0cmlwZShmc19pbmZvLCBsb2dpY2FsLCBsZW5n
dGgsDQo+ICAgCQkJCQkgICAgJmJpb2MtPnN0cmlwZXNbaV0sIG1hcCwgJmlvX2dlb20pOw0KPiAr
DQo+ICAgCQkJaWYgKHJldCA8IDApDQo+ICAgCQkJCWJyZWFrOw0KPiAgIAkJCWlvX2dlb20uc3Ry
aXBlX2luZGV4Kys7DQo+ICAgCQl9DQoNClRoYXQgc3RyYXkgbmV3bGluZSB3YXMgYWRkZWQgYnkg
YWNjaWRlbnQsIEknbGwgcmVtb3ZlIGl0IGlmIHRoZXJlJ3MgYSANCm5lZWQgZm9yIGEgdjIgb3Ig
d2hlbiBhcHBseWluZy4NCg==


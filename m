Return-Path: <linux-btrfs+bounces-10221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E429EC59F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 08:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0364169226
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83B81C3040;
	Wed, 11 Dec 2024 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sq8W125K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bp/vgFYN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE382451E2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902358; cv=fail; b=hfeXSi3o663G3sox3YKn+sU7lkAcURMQibKYU2Pq9klwXQujIov3xzvQ0SnqeGLzVe5GURVLeFshmsquj1lvHbpwZyvv7+By7AVa6VDCBJWI+u0UVsw1/KUNzWZrp0jIYs8k6y6xY7d4MGiHOZOU6EdyNXRrwl7BKGUqiuD9mTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902358; c=relaxed/simple;
	bh=pYTmljSAl/Wnp/+cYlbNesPj3xgwXbD0FUIX/aGffvQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QMirlM4Dz1LseoSqemJ88NNMTAb1HTJqXcStl3u62UHzom6cyDhfnJURCQy8Jl8ul+4mHMt+aWbMvXKS8we+JwlSDFvTbUCA8bOxYLLGxlzvG4v1UvzFEzTYQzyXrl9pMYFRX5i+XQN2GmL+YJr+gHN2ZfeJoWyi6Bj6MjJhEAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Sq8W125K; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bp/vgFYN; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733902357; x=1765438357;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=pYTmljSAl/Wnp/+cYlbNesPj3xgwXbD0FUIX/aGffvQ=;
  b=Sq8W125KLXqOHtYxfv9nbYUR/+T5sCJ+fftFgdQR7RwOH6KheJbGsQq9
   qy2ofZTMYlVniaAj35hSNh401ThsOWLVI7Mzlw/pK0Q5Swcu7fuPVn8jX
   VLxSr6e0pDYb0kHA0z4/ZwNLkwYuWH114D8WhMs6HZgEgGaHLA6ohDDLR
   2QqR8QwWACms7grFrzh/o9X8beO/fpTIgvM/3o6nzdVGJ8Y8OcYr6sCCw
   1QJF6QxsyTEOg0XaHeqsBFFSpJN6+2UIz546ieM2KBXL5ipZlI7EUUvpw
   tF5rNFs2RxPsL4BxfFSDgP3Sh+UQrmSJ9LNfJ6IvcSM9/K1QWeNCZRf1o
   Q==;
X-CSE-ConnectionGUID: uX/8cWcpSduKkS5om5/YdQ==
X-CSE-MsgGUID: prNDciGHQoufP4raDBgi2Q==
X-IronPort-AV: E=Sophos;i="6.12,224,1728921600"; 
   d="scan'208";a="33594693"
Received: from mail-westusazlp17012038.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.38])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2024 15:32:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgIxrk1F86uaK/KnUoDvVUCRkZiclu2nnwvij+BU84ta0DQLS/shn1R0pFRntKDQXaAkwWrl4iUNo0hyUuDy9mGrO/ObrUWpwiATZKIDw3r2BWFWnYHgTgiiBup/nheLYZgC1FAU4eSE5qjht92L5FE9076xNTP6HKdh8+8N1QoZCTckp5+XDSWA6t4LcD0UmSB8SLeZwvn0myhTVFp8pyovyU+F30ONkTuShYYrMc1XOvgnVb013I+YJ48LbzccZv+mdSmRaogpyuIkAcgTXfYxTaAxvtx77aTEr//gyyD2SC5+GtaiFAq1PuJt7osvC7YUAG+Cjtxh9s2NFudStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYTmljSAl/Wnp/+cYlbNesPj3xgwXbD0FUIX/aGffvQ=;
 b=FKAEx68K0++rkacNT6ZwfJapZSSULU++bo5ixtzI+NH1uWdMUUj9KzR9Oz7Onpi9ROGtnf6S/Mtp7HSt4oAopnuJ22oTBOXNp5v7vyGCRf+eLejxQLBWKNuw9XWbeSWRslz7wGPVw33ldVIhjHCOWQcNZMMweeedUdgepOcYrXV+8ksvJwXf+l+UJ95iNZkzqThlG2HmQyPeWokJeLxVqw1nZV7Vh6WaSc+A+kVPupURRmVif0vqezWcCWdkyN0/VAquaEPhpS6whdLRSW8CUTf/TpT2NDYRNczDpws0uc2FVN66VDOp4Vo1K23Oqzsuxsqwde/yi/hsoN+Z3xruBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYTmljSAl/Wnp/+cYlbNesPj3xgwXbD0FUIX/aGffvQ=;
 b=bp/vgFYNomm1ryY62c6SolyNNjTsW95zgh47/eRAOWKDvPSiKhaaueDQKQw+6FKB8O6x+VGvyJApLR1xzweXWF5iI2F0nuSjreBNJlQomZxt5xAOODeN/RWMvU0fbkk4TjUspsM4XIDUNYtUQrKWoWXzJIGJqXmpOTSnqxwsf0I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8931.namprd04.prod.outlook.com (2603:10b6:806:381::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 07:32:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 07:32:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Yuwei Han <hrx@bupt.moe>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [BUG?] extremely poor performance on zoned after bulk write
Thread-Topic: [BUG?] extremely poor performance on zoned after bulk write
Thread-Index: AQHbS1lvf0WPIxBoFUy+HzIj1SNGzbLgpvyA
Date: Wed, 11 Dec 2024 07:32:33 +0000
Message-ID: <1ec34cb5-70f7-4cfe-ac34-3d7d0eda4dad@wdc.com>
References: <A7749CD52DC078B3+add53c37-c637-4676-ae77-90df2e3a0348@bupt.moe>
In-Reply-To: <A7749CD52DC078B3+add53c37-c637-4676-ae77-90df2e3a0348@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8931:EE_
x-ms-office365-filtering-correlation-id: 4cf28e66-0293-4612-8132-08dd19b5fa62
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WW9WVzErcElKMWFFQ3hkVTZFL3QySzdRRDFpRmluWEd0TExMTjZCMDJRbnRR?=
 =?utf-8?B?THFYTURObGJyR0t1VXRTaGJYVzN4QzVIOGlPK2tDcVRXMVNLMzgrNEFtbjVy?=
 =?utf-8?B?ajV4cnprcU1UVmV0VEhpdWJaYmlFMnJPZzdyMWFOK1gvRlFUVGgvVWlMdmht?=
 =?utf-8?B?dCtrVzVYbmM3dlVyaW1hWitVRUdwRUtQUzZDZi9FUFZ3NXBDYlA2bkk2S0Vz?=
 =?utf-8?B?dUZXUFkvT0xHekdpU0x6cUgrdnlwUE9tM0xmZkVubFRYcWpRc1ZJallCMUJx?=
 =?utf-8?B?ODd6Z3hmR1RnaHJ0eksvMzExZEl1U0NtYVlweVZjdW82bUdRRThuajVIOC9h?=
 =?utf-8?B?TEVHS1R6TlVTMUdMeFp3Wk10TlpNem9ocGk1NlVWYjZhR05ibUFiYUNIVURm?=
 =?utf-8?B?YXU3MTNaWjFLSXJWVGlIZElobHh1NGU2OFRQZ3AxbHV4b1JJaTBYUVdDUUZW?=
 =?utf-8?B?YmZOWVdzWEEyRmtNQ0FldzgxUTBwTlNxTFJndDg1TUN4TUpXMFFsR2MveDIw?=
 =?utf-8?B?b2V4R3ZRanl3dFNZVGg3ckJmVWJKVlFEN3REYksrS1RBQW5Gc0xPTDNuQVBt?=
 =?utf-8?B?bzA4VU1pRUxXRktOV0xGdjdtUWNTeEt4Y3N6Um1TSjFKNUNCODRxSlc1ZnZW?=
 =?utf-8?B?anNZa0lqWmpWWlNlQXF1ZncrVXU2d2pEMW9ic3BiN1VsTm1wMXlFRGcxK015?=
 =?utf-8?B?Q2h5UWFCWHVLbWIwV2J5c0VkRVM2QnMxYUhsaXN3YXFCc3ZseVR2aG40VHAw?=
 =?utf-8?B?aTNEdkJETE8yajlOY04zcmdPNDM0VXc5MWI1bm9SOUhiZHltTGJIK3hET2RM?=
 =?utf-8?B?eUFybWxuem9VVDRuOGpUQ3locVRJaEVnTHpNZWI1SkhQVEdGQytwTzBYV0Z2?=
 =?utf-8?B?QWxQR01nMXJoSWhoeDBMRWNKMWhRRi9FMVQydlVzRXRYWkJFbThsQWdVODd5?=
 =?utf-8?B?TE42TUd2SDRrUUJoL0NTMk1YMk5jS1R5R2xzNlZSVklmTmkrMC8wMXdyZGo0?=
 =?utf-8?B?VkR1VzZjMUoyZ3VYbklFUUVVOEsybkhNNHVFQUNSL3p1U2tkLzZxVlB2bjQ5?=
 =?utf-8?B?NDFrMVEvbUppVVBzbVBacGZjemxad1o0VGtOOVZvZmJCSm5UdjNub2NYREJF?=
 =?utf-8?B?c2MwTFdRRk9aZU9wdnRObWFObnN3S2tlbXY0Wit2VVE1Yng3VjhMRjJqRStR?=
 =?utf-8?B?UDI1MWtXejVZUmhlOHkwVjNjMFJEMjBQbm40cHQ0Y1dDeitzc3BZWmVMZUtO?=
 =?utf-8?B?YmMwU1AxRmJ0UEw2UHp0VnMvYTF0N0Y2MWpzNFYxZUhzdDVUM3BmN3d3Yzgy?=
 =?utf-8?B?ZWJjZXJRbEZuRkpaalljakpFZ3RPQ0NHNWl6c0RIS0tOVk5kMUZBYXZNQ3Iw?=
 =?utf-8?B?eUZnTWZxWnpJTWcrVzZsRTVFUlJLZ1JaTmdCR3BzVmJ4SEdqYXZFVC9nUUxk?=
 =?utf-8?B?a0RBenVXeGU0T0hWOWYrQyt3VCtaRng4REdvQkpEZmRaY1AvWHBYcWtrTnZ5?=
 =?utf-8?B?WkVvOXlSdUFKZlBEVTdpUW9RRTE5MGZIYVJjWHRmS2EwVmswUHQ4RVRBVkFh?=
 =?utf-8?B?ajVUMk1NbGFjMDZ0eUpJd2xvTUpMYzlKZm1LcGQvb0x3MktObklLZ1ZkR3lz?=
 =?utf-8?B?dThTOThXbE02ZGJzeDBOTi9icmpTbi9UQXV3V1R1c01rdXNrMXpMUXlzMkhN?=
 =?utf-8?B?czk2b2s0b2pLM0JiaWFoUUpBSnhtMGFJajZvNlNIdHBxMi93YjR6bkw5QUVZ?=
 =?utf-8?B?M2lxWGx1WmlJUjhzTTBZSEpHU3B1OXl5NDZOWHo1bEZwYmFZVTZqZm5XWEd1?=
 =?utf-8?B?NzhIS3N3VUpRWG5qRFlKdW1aakVtVG45ZHE5Q1Fob0lEQmVrMUtSbzVoUENh?=
 =?utf-8?B?RW1TYmY3d25ZYTVVZ2pQMzBlaXdCWTZwei9rZWRRWEhORHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3ZURUV4RDQyRUhKdnd5V3ltTVl6VDBGYXo4OWlqcDJDVit0RThGNWdSa1pF?=
 =?utf-8?B?eERaa01naEZPOE9lNmp0Q3hxUTFnZ0dwSXNnMlE3VVgreTdwYStxRXMwQkRT?=
 =?utf-8?B?SVNxR2YwR2lvaHB2RmJQSTZxSFdsWThpQjNkUGNianFBcGZWclhzQUU2WStw?=
 =?utf-8?B?R1VOR1FkV2RaOUlSZnRiZDZtVzNTV01iZGpVSUZCSzBGODNyaTg1elIvSDEw?=
 =?utf-8?B?TzhzMVJyS0pPcWFoT3NNc0FjWVlhaGU2eXJGL3FjSlAyRE1EeFFQVHdSQ0E2?=
 =?utf-8?B?VjE2TXg5RXM3bE55ckkxMnF4WlV3Tk1sSDBydnJkZDVJREdqSlVqMEFWZmVD?=
 =?utf-8?B?TlpFRkxPN3VjZ05LOFhyUWU5ZUFOTWZDRXJoTm9QbytMa3lwaXNjeitOTXFt?=
 =?utf-8?B?bmhwNkdOZTRhTEJvVjRINEhoQmhvekZaN0tSa25rQkl5T1JjTW44QVlNVlk4?=
 =?utf-8?B?ZUZQMHNrdXBqK1crd21DTGl3ak94SG8yQkU1bncwMkVrak1MN1NpUHIydXZ5?=
 =?utf-8?B?WU1JUDdjWjRkYUlralQxT01uZENzQW9UUzBQWmZNT3pkYm5sQnpuREJ3TFM4?=
 =?utf-8?B?RzNnY1RTZEcrWGwzRFppcnliUW9DTnd1aFNBNHVZNHozeVRSTE1wQjdIWjA5?=
 =?utf-8?B?Tk5oL0xtOWtPS3luZXlsSWZvL011ck51cXdmTUlOV28zbGp4cmd4RkZJTW9L?=
 =?utf-8?B?b2xhS1pUM1RBTlNqQ0h1aHVsS0wvcUZJdUNKeDIyZks4Y3RyS05Tc1ZzRFZQ?=
 =?utf-8?B?SU5RSjUwRml2OHZZY0wwL1NpUStTSkRzM3hubmNCWGRhTXZxNGJ4aUpRc1FC?=
 =?utf-8?B?RDJxT0RsRFFqVFREL0FsNE9yMHZ0MjcyNEpXZGp1amhtZE1ZdndNU3pOZEZn?=
 =?utf-8?B?b3FZUlVrTW5GZ1BwYVZ1WGVld2JtZkFwb0FTOUFBVUNFakRDL01ZdFkzWUJi?=
 =?utf-8?B?WWdiUkdvN1FYSy9waldydUlKazJxbllwR3V0eXZ4dEJzVUIzOVdsTERzQUdG?=
 =?utf-8?B?TnFIanJTQ0paMlFBOWpkS2xzTys4SXYxV2JqRVVKcktYM1pmRnV3RHBsNEQv?=
 =?utf-8?B?ODRQOVlKYUNVRWlEMkd0ZEk0aFVOS2RjUG82V3ZsVmhEVERFTTR1dW10WG5H?=
 =?utf-8?B?Q0JYWEpPRDlkWEVRcHBHcUVLNmR1OVNzTkVvM2hPYWJYVzczUWcyQUtUWUl3?=
 =?utf-8?B?Vk5KUk5NVDdTcjBqTzZZUFM0enFoYSsxSEU2eXRhWUJLL0oxdFgzU0N6V2RU?=
 =?utf-8?B?Q0pwYkZLcEhJTlpVT0dXY1N4N3ZML0d5bFczV2hZT1J1SEF6WjhMRXRxZWlK?=
 =?utf-8?B?UmttYVcrcEpvMkFDQTVHTytXWTZ6MzVpTlF5QXpWcklyUnMyV0ZDSXVwSE1s?=
 =?utf-8?B?YmpJcTFIVE11UTJ2U05LSWJyK1lialdObmJ2ZVpyTll2dStKUGJDMTVpZjc1?=
 =?utf-8?B?YmVPbitXd2ZrMXgwMnFEUCtTbDcrM3pxekVzTHlITzUvdFR6QVM1dUs1TlJr?=
 =?utf-8?B?VjVvWVA0bS9UY3k4TUdwYzZjZDRXVmRRcG1uN09GVlVJTElHc2JvRkI1TUpq?=
 =?utf-8?B?Z2U3SFYwaXIzbnR1WWhhYkhvUjFuc2swbjFrc1cyMGhkQVIvYWovU2VwSG54?=
 =?utf-8?B?akpBeDN2OEhCVW5WNGNRMU8ycU5laDRVU3c1YmhlVTJhVWJSTnUzdjRjMHFM?=
 =?utf-8?B?MHp3ZlNZTnN3bGQycUlRditQWWsvVk1xS0tGaFNhZ0tCWDIxSzMxNGN3VXgx?=
 =?utf-8?B?NGQ0a2FzV3AvVUNjUzRzVEMvcjNCa2VJRWVwL0FNS204cW1sYjFNTURjOEtR?=
 =?utf-8?B?Q2pWeTFHQUhHWGZ1NFBkRFdlZm5pZ20rMzdFNXFBMXJEV3pQZXJ3UUR6dWFn?=
 =?utf-8?B?SytBN0hZaHJTK0xKZ0tqZFNxUVMyN1JsQVh2RjhrQU9lRWRkL1BmeEdmaEVR?=
 =?utf-8?B?Wnk5Q2hrV2ptc3liV2wxY0d4Y0syOHN1UFN5ZzlGbENnSSt1dkM3bmlrNkxv?=
 =?utf-8?B?c3NydGM0UGhKQ2M1YVE1S2ZnbXBTSTNFZTlxWXY5bVZHeUowSDJSNHpIWDFW?=
 =?utf-8?B?c21IYmc1TmJZMnBka3JFb3VSdFBlY2pUSXhEVzBtYTJCbkhEcWV6RG1ocE1E?=
 =?utf-8?B?dHA3QjNrdDFEUlJkR1pvQjlqdXBJSlNjaXdlcktUd1BzTkpodWNicDRUZDR1?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17253A54CF3E124FAAA9C30262451D7C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qCW5WbtnnZcGIt/vHwkNFLUTK9dk1fZN5eB+Wg/OrGA/Li1tuO7EgI62SGHJIwNwR8Xfsls8BhAga9EB18anGY6b2EgGQkuUXUqXv2zHf2taFn/wUnbthhew9QaZQwyJw3q29/oRbn4Nn1avWIrhBx/8ek2InUaxMK+DRp6A/ERoShQHdVUO/L3N3Q9JUwhvtb3S2WH8Md3urAEIrxsbJGO/7MaxMlQJbv3AZ1kHS1DGnjijnyLMPfeJ758+KKYF3PCk23pJw1HLzRyEyxz9sYOpYt1puTpM9xeyKlbUXku/Ehbxew6oNIwhXDE8X7ql3yL+aCHpDXg4G9EfxCYS6tpTE6BsNUzDbOZq5yInw9DFjd91f3LuI9nC/QsJLoS2jBKeH+FRmVmRF9b8tKQbBhqtulMdQ7TQcK/vNZSs4YCkoC2k5szGc5AObw0KTL0vBOZaZTJoCPLJGo1GxgdxkjTAJLwxcN8sQCYRZtIcDhDpqZDSeTjLVcu65K1zII/E7e0D/A3EAJ8in0PBWwcdrp/SRPUjeLKy0eD6Oj7xZAW8PUz3VW8gDPpoGAmAm/smQzLnvU5t+WgFM+phzQbHBt4ZBZx32s+8RgLBcsuCPg9iKF9WuFZ2U6S37UbBZa73
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf28e66-0293-4612-8132-08dd19b5fa62
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 07:32:33.6809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8naCwUnZYgw/jrcmXuK8FEmksAWL648Ad8T4XA07rOoW14P6omObwpVHg5EK6Jv/atXuXLpvUDBGKFuDjJwW3ENogv8jL+XECAOj8HPbjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8931

T24gMTEuMTIuMjQgMDA6MTUsIFl1d2VpIEhhbiB3cm90ZToNCj4gSGksDQo+IEkgaGF2ZSBhIHpv
bmVkIGJ0cmZzIG9uIEhNLVNNUiBkcml2ZXMuIEkgaGF2ZSBjb3BpZWQgYSBidWxrIG9mIGZpbGVz
IA0KPiAoYXJvdW5kIDNUaUIpIHRvIGl0IGFuZCBzdGFydGVkIHJlY2hlY2sgKHFiaXR0b3JyZW50
KSBvbiB0aGVtIHdoaWNoIA0KPiBpbnRyb2R1Y2VkIGh1Z2UgcmVhZCBvcGVyYXRpb24uIFdoZW4g
aXQgd2FzIHJlYWRpbmcsIEkgZm91bmQgdGhhdCANCj4gbWV0YWRhdGEgb3BlcmF0aW9ucyAobGlr
ZSBscyxjaG93bikgYXJlIGV4dHJlbWVseSBzbG93IGJ1dCBjYW4gYmUgZmluaXNoZWQuDQo+IGRt
ZXNnIHNob3dzIHRoaXM6DQo+IA0KPiBbLi4uXQ0KPiBbNjE0MzY3LjEyMzI4M10gQlRSRlMgaW5m
byAoZGV2aWNlIHNkYSk6IHJlY2xhaW1pbmcgY2h1bmsgMzEzNzUwMDQ1MzI3MzYgDQo+IHdpdGgg
MSUgdXNlZCA5OCUgdW51c2FibGUNCj4gWzYxNDM2Ny4xMzE5ODldIEJUUkZTIGluZm8gKGRldmlj
ZSBzZGEpOiByZWxvY2F0aW5nIGJsb2NrIGdyb3VwIA0KPiAzMTM3NTAwNDUzMjczNiBmbGFncyBt
ZXRhZGF0YXxkdXANCj4gWzYxNDM5My4wOTkwOTZdIEJUUkZTIGluZm8gKGRldmljZSBzZGEpOiBm
b3VuZCAyODEgZXh0ZW50cywgc3RhZ2U6IG1vdmUgDQo+IGRhdGEgZXh0ZW50cw0KPiBbNjE0Mzk0
LjcwMjE5Ml0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYSk6IHJlY2xhaW1pbmcgY2h1bmsgMzEzNzQ3
MzYwOTcyODAgDQo+IHdpdGggMTIlIHVzZWQgODclIHVudXNhYmxlDQo+IFs2MTQzOTQuNzEwOTYy
XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogcmVsb2NhdGluZyBibG9jayBncm91cCANCj4gMzEz
NzQ3MzYwOTcyODAgZmxhZ3MgbWV0YWRhdGF8ZHVwDQo+IFs2MTQ0NTcuNzgzMDEwXSBCVFJGUyBp
bmZvIChkZXZpY2Ugc2RhKTogZm91bmQgMjEwNCBleHRlbnRzLCBzdGFnZTogbW92ZSANCj4gZGF0
YSBleHRlbnRzDQo+IFs2MTQ0NzUuMzE5NTE2XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogcmVj
bGFpbWluZyBjaHVuayAyNjU4ODgwMDM1MjI1NiANCj4gd2l0aCAyMyUgdXNlZCA3NiUgdW51c2Fi
bGUNCj4gWzYxNDQ3NS4zMjgyODhdIEJUUkZTIGluZm8gKGRldmljZSBzZGEpOiByZWxvY2F0aW5n
IGJsb2NrIGdyb3VwIA0KPiAyNjU4ODgwMDM1MjI1NiBmbGFncyBtZXRhZGF0YXxkdXANCj4gWzYx
NDU4Mi41MzgwNzRdIEJUUkZTIGluZm8gKGRldmljZSBzZGEpOiBmb3VuZCAzOTEwIGV4dGVudHMs
IHN0YWdlOiBtb3ZlIA0KPiBkYXRhIGV4dGVudHMNCj4gWzYxNDU5Mi42NDYyNjVdIEJUUkZTIGlu
Zm8gKGRldmljZSBzZGEpOiByZWNsYWltaW5nIGNodW5rIDMxMzcyNTg4NjEzNjMyIA0KPiB3aXRo
IDIwJSB1c2VkIDc5JSB1bnVzYWJsZQ0KPiBbNjE0NTkyLjY1NTA0NV0gQlRSRlMgaW5mbyAoZGV2
aWNlIHNkYSk6IHJlbG9jYXRpbmcgYmxvY2sgZ3JvdXAgDQo+IDMxMzcyNTg4NjEzNjMyIGZsYWdz
IG1ldGFkYXRhfGR1cA0KPiBbNjE0OTIyLjA2ODU1NF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYSk6
IGZvdW5kIDMzMTUgZXh0ZW50cywgc3RhZ2U6IG1vdmUgDQo+IGRhdGEgZXh0ZW50cw0KPiBbNjE0
OTcyLjA2NDczMV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYSk6IHJlY2xhaW1pbmcgY2h1bmsgMzEz
NzY4ODM1ODA5MjggDQo+IHdpdGggMiUgdXNlZCA5NyUgdW51c2FibGUNCj4gWzYxNDk3Mi4wNzM0
MThdIEJUUkZTIGluZm8gKGRldmljZSBzZGEpOiByZWxvY2F0aW5nIGJsb2NrIGdyb3VwIA0KPiAz
MTM3Njg4MzU4MDkyOCBmbGFncyBtZXRhZGF0YXxkdXANCj4gWzYxNTAwMC45NjU3OTldIEJUUkZT
IGluZm8gKGRldmljZSBzZGEpOiBmb3VuZCAzNjYgZXh0ZW50cywgc3RhZ2U6IG1vdmUgDQo+IGRh
dGEgZXh0ZW50cw0KPiBbNjE1MDAxLjkzMTg3NF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYSk6IHJl
Y2xhaW1pbmcgY2h1bmsgMzEzNzc5NTczMjI3NTIgDQo+IHdpdGggMjElIHVzZWQgNzglIHVudXNh
YmxlDQo+IFs2MTUwMDEuOTQwNjgyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogcmVsb2NhdGlu
ZyBibG9jayBncm91cCANCj4gMzEzNzc5NTczMjI3NTIgZmxhZ3MgbWV0YWRhdGF8ZHVwDQo+IFs2
MTUzMTguOTExMjE1XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogZm91bmQgMzQ3OSBleHRlbnRz
LCBzdGFnZTogbW92ZSANCj4gZGF0YSBleHRlbnRzDQo+IFsuLi5dDQoNClRoaXMgaXMgdGhlIHJl
Y2xhaW0vZ2FyYmFnZS1jb2xsZWN0aW9uIGZvciBtZXRhZGF0YSBydW5uaW5nLiBZb3UncmUgDQpn
ZXR0aW5nIHRoZXJlIGFzIHlvdSdyZSBsb3cgb24gc3BhY2UgLi4uDQoNCj4gYW5kIGxvdHMgb2Yg
dGhpcy4gYnV0IGl0IHNlZW1zIGFsd2F5cyBkb2luZyB0aGlzLg0KPiBidHJmcyBmaSB1c2FnZSAv
ZGF0YTE6DQo+IHZlcmFsbDoNCj4gIMKgwqDCoCBEZXZpY2Ugc2l6ZTrCoMKgwqDCoMKgwqDCoMKg
wqAgMTIuNzNUaUINCj4gIMKgwqDCoCBEZXZpY2UgYWxsb2NhdGVkOsKgwqDCoMKgwqDCoMKgwqDC
oCAxMS4wNVRpQg0KPiAgwqDCoMKgIERldmljZSB1bmFsbG9jYXRlZDrCoMKgwqDCoMKgwqDCoMKg
wqDCoCAxLjY5VGlCDQo+ICDCoMKgwqAgRGV2aWNlIG1pc3Npbmc6wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDAuMDBCDQo+ICDCoMKgwqAgRGV2aWNlIHNsYWNrOsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAwLjAwQg0KPiAgwqDCoMKgIERldmljZSB6b25lIHVudXNhYmxlOsKgwqDCoMKgIDEwOS45
N0dpQg0KDQphbmQgfjExMEdCIGNhbiBiZSBlYXNpbHkgcmVjbGFpbWVkLCBzbyB0aGUgZnMgaXMg
ZG9pbmcgZXhhY3RseSB0aGlzLiBCdXQgDQpvbiB6b25lZCBidHJmcyBhbGwgbWV0YWRhdGEgb3Bl
cmF0aW9ucyBhcmUgc2VyaWFsaXplZCBvbiB0aGUgDQpidHJmc196b25lZF9tZXRhX2lvX2xvY2ss
IHNvIGxzIGFuZCBmcmllbmRzIGFyZSBzbG93ZWQgZG93biwgYmVjYXVzZSBHQyANCmlzIHJ1bm5p
bmcuDQoNCj4gIMKgwqDCoCBEZXZpY2Ugem9uZSBzaXplOsKgwqDCoMKgwqDCoMKgwqAgMjU2LjAw
TWlCDQo+ICDCoMKgwqAgVXNlZDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxMC45MlRpQg0K
PiAgwqDCoMKgIEZyZWUgKGVzdGltYXRlZCk6wqDCoMKgwqDCoMKgwqDCoMKgwqAgMS43OFRpQsKg
wqDCoCAobWluOiA5NTcuNjRHaUIpDQo+ICDCoMKgwqAgRnJlZSAoc3RhdGZzLCBkZik6wqDCoMKg
wqDCoMKgwqDCoMKgwqAgMS43OFRpQg0KPiAgwqDCoMKgIERhdGEgcmF0aW86wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxLjAwDQo+ICDCoMKgwqAgTWV0YWRhdGEgcmF0aW86wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMi4wMA0KPiAgwqDCoMKgIEdsb2JhbCByZXNlcnZlOsKg
wqDCoMKgwqDCoMKgwqAgNTEyLjAwTWlCwqDCoMKgICh1c2VkOiA4MC4wMEtpQikNCj4gIMKgwqDC
oCBNdWx0aXBsZSBwcm9maWxlczrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbm8NCj4g
DQo+IERhdGEsc2luZ2xlOiBTaXplOjExLjAwVGlCLCBVc2VkOjEwLjkxVGlCICg5OS4xNiUpDQo+
ICDCoMKgIC9kZXYvc2RhwqDCoMKgwqDCoCAxMS4wMFRpQg0KPiANCj4gTWV0YWRhdGEsRFVQOiBT
aXplOjIxLjc1R2lCLCBVc2VkOjUuNThHaUIgKDI1LjY1JSkNCj4gIMKgwqAgL2Rldi9zZGHCoMKg
wqDCoMKgIDQzLjUwR2lCDQo+IA0KPiBTeXN0ZW0sRFVQOiBTaXplOjI1Ni4wME1pQiwgVXNlZDo0
LjY3TWlCICgxLjgyJSkNCj4gIMKgwqAgL2Rldi9zZGHCoMKgwqDCoCA1MTIuMDBNaUINCj4gDQo+
IFVuYWxsb2NhdGVkOg0KPiAgwqDCoCAvZGV2L3NkYcKgwqDCoMKgwqDCoCAxLjY5VGlCDQo+IA0K
PiBVc2VkIG1ldGFkYXRhIGlzIGFsc28gYXJvdW5kIDI1JSBub3QgaW5jcmVhc2luZy4NCj4gDQo+
IGtlcm5lbCB2ZXJzaW9uIHN0cmluZzogTGludXggYW9zYzNhNiA2LjExLjEwLWFvc2MtbWFpbiAj
MSBTTVAgDQo+IFBSRUVNUFRfRFlOQU1JQyBTdW4gRGVjwqAgMSAxMToyNjozMiBVVEMgMjAyNCBs
b29uZ2FyY2g2NCBHTlUvTGludXgNCj4gDQoNCg==


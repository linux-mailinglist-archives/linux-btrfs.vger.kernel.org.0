Return-Path: <linux-btrfs+bounces-11081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CD2A1DAA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 17:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEEA167C35
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30615B54A;
	Mon, 27 Jan 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hmgu.onmicrosoft.com header.i=@hmgu.onmicrosoft.com header.b="Gq+/meEZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013065.outbound.protection.outlook.com [52.101.67.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00BB157465
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995510; cv=fail; b=rpsvRGQgw4kHbcDiqABEb3T7qfeEyy3UzQsHR/2AeZSIDTVwey0Y98rzETKM+BMy10ZTggxTyfZEXtZfxmr86G68AZIp1bpWSh6IzqJ5+rXRqFX0quBf9K2a8lfK0ov01jyQEe2KavlrBQsFO9yD73pdZ6RHUfv5BWAeZOnz6fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995510; c=relaxed/simple;
	bh=uB13m3zzwjJAkpqksyEXH/YFd6y4Ja0E7slf/qLY38E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XHBZ3SXCiVdN6PfWLDGXZeXqekFHdGmmfBNtTKQ15saYwkraq2QheTZVK+roLaoOCB/XoNGa2ZdtnEjq61yoRIwbQkXraRh6bt7pu26r52itY2eLpSdwiG9cIR7XTLFiTwA0cBJOE26S2FwyzBSMX3M5tJTVnftbc1U7wQowJMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=helmholtz-muenchen.de; spf=pass smtp.mailfrom=helmholtz-muenchen.de; dkim=pass (1024-bit key) header.d=hmgu.onmicrosoft.com header.i=@hmgu.onmicrosoft.com header.b=Gq+/meEZ; arc=fail smtp.client-ip=52.101.67.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=helmholtz-muenchen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helmholtz-muenchen.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSPJ/gzxdjBUjTqhr1uoewRQE9Uyh4mnRcDmb4Af1xn3hGD9QVpqcfWbEMP1mJairP4gB8ATfZC1dHBgcIhT2mmFhWgeRcsNibVjCVdWF4u/WZquc8D8rsHMHg1Z0N3R94JmopXRl3axxQsXpebrFYoPV1frWGUOym+DtCRI/lshHIo/vRz9XzNhupKI8hZ267Fc5fwZK27aIb5opk4wyeYNpQa3o6zu7cS/9505zmjr5Bv71680F10LVDCERsWwHgNfra9rrOv/2MOpz5dm/AFGQVeikdgHRtPVfQHiYO6BcqljnWOnAzQfvlG2PLi29Q0Xv4DoqcArQDQSUH0WzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB13m3zzwjJAkpqksyEXH/YFd6y4Ja0E7slf/qLY38E=;
 b=PqyU+ULd1ZqmhrAvuMY5ypM+MJt3kQJ5yQnZQco42qpgF9YEu5XjELpzQKGLs2+u7QcO0Yx2tw1Dnd2/HN9W+MHhbo3ELvmyABUV43qkyF/jNU5IKalupqJsZcfGmYL50mS3z6uAmP3rKBC9VJrE/TG8K1Mv785POI4DrxcceCrps6Mqy/tI3mH6+1rALtPcYyZGxBEgU9bYldbNU77DEViScp+JoZtH1HZwW6iCsJmEdcTUvTMr3XmUQxhxjX0feP2moG96HtOXby/f5vlaV9A3/sBWxuhVh1lQr41bpM7RjBHcDAaYj1xAQiUwM2p2IjsgsUxx52fMuJ3z7wy9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB13m3zzwjJAkpqksyEXH/YFd6y4Ja0E7slf/qLY38E=;
 b=Gq+/meEZ3FhEbklcBqoKj5Tg98/FmdpzXNOfrFKSD3JaJ0+IbuzcqqKafNeO6AdgIfFKcPxxMZWfUFhNZSbOqVp4MpjW434FIbzrMqGCHPRegdYExBTBRsMOv28b6D3WbOaZdGadDFGNWTaS8taO90qGgooQFRW46Qg/MgRaWRM=
Received: from PAXPR04MB8558.eurprd04.prod.outlook.com (2603:10a6:102:215::23)
 by VI1PR04MB7133.eurprd04.prod.outlook.com (2603:10a6:800:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 16:31:40 +0000
Received: from PAXPR04MB8558.eurprd04.prod.outlook.com
 ([fe80::e6b6:720e:ab74:eae9]) by PAXPR04MB8558.eurprd04.prod.outlook.com
 ([fe80::e6b6:720e:ab74:eae9%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 16:31:40 +0000
From: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To: Andrei Borzenkov <arvidjaar@gmail.com>
CC: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: RE: some questions to quota and qgroup
Thread-Topic: some questions to quota and qgroup
Thread-Index: AdtwxV+1Dlv013hJQdCgXbh3rHjfagAA5BMAAABm0UA=
Date: Mon, 27 Jan 2025 16:31:40 +0000
Message-ID:
 <PAXPR04MB85580704BF588D930B3F7DE6D6EC2@PAXPR04MB8558.eurprd04.prod.outlook.com>
References:
 <PAXPR04MB855864623B37A9E3F25267EED6EC2@PAXPR04MB8558.eurprd04.prod.outlook.com>
 <CAA91j0WwVt3u9stCj6sNSRkFM=HDtNoN+6DNBukUBU2WqFqVwA@mail.gmail.com>
In-Reply-To:
 <CAA91j0WwVt3u9stCj6sNSRkFM=HDtNoN+6DNBukUBU2WqFqVwA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8558:EE_|VI1PR04MB7133:EE_
x-ms-office365-filtering-correlation-id: 32d4f43a-bf97-46ed-1ab4-08dd3ef01409
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UEpFbGNLeWQyNW5ERGphUTduRHlSRTFVaGpHRUZ0eWJqN1Nyelp4RTJoakxV?=
 =?utf-8?B?dHNHUkh1THNXcnZod0JtbTJWNlhNTTUydE9BMEpRTVREWHg2SmZDajBEVGtP?=
 =?utf-8?B?TURTUEIrN0F0VWRhMElheEZWSkd2bkttdy9aYlErZDgrSmRsUjBDaWZmTVRI?=
 =?utf-8?B?YTlGK2Q0dlZmKys2MEZvaHA2aWduTmdYdDA5L2VhbkUxZ2g4V0RQK2NscFVy?=
 =?utf-8?B?ekI1WXJvbUtLV1pIa1U1ZHF0VHZDOWVQdFB3L3dYbEIwRUh4aWQ0eU9yZk5F?=
 =?utf-8?B?QVpzQkNwd1BQdWt6L0ZpeXZEVlpacGJ3c1djN2wrNUlrZXZzalRyclFKa25V?=
 =?utf-8?B?eG1ublVJK1F0M1Zyc3dTRDRndjBmTmRGQytreVV6ZzlKSVlmNkc4MERtbFZo?=
 =?utf-8?B?NHJrbkNPZllpZVFBY21HaFJjRzBOZG5ueXlxd1lxRDRZQnczZDdSNnI4L0gy?=
 =?utf-8?B?bzVkcHlrdEJCemc2NENCNmVEVGNiZTZXczZlUlorV1p0eHg3WFBuVnV2dEhG?=
 =?utf-8?B?ZTBuQTZmcFBnUWtOMHRrb1U1MXFSQ0hGU0RWK1BwQ29TUWFnVjc0VnpYZVFh?=
 =?utf-8?B?NEw1OVorMysvS3dMN2tUcVpQV2RzWTRobkE3K3lqTHlKbUtKS2VBQUNvWDNa?=
 =?utf-8?B?OTNVNCthcjNpU0JKUmU5eExsS2hIUXlZZVlKN3JLS1hONGNhRUZUZHc3ZGcz?=
 =?utf-8?B?SjF5cUVZWVF5WnVlU0dpV2hQMWIrTnFJaXFqOXFwZ1JvTVhTRVF1amtKTWlx?=
 =?utf-8?B?MEU0NHhyT2ppM2dXV09HdndvUXFHaFN2M0lLY2tzRzFtRklhbzU2SzRBdVJl?=
 =?utf-8?B?TjIwME5vb01PajZtMVdCU25weU93V1N0c1lLSHFDa0N3K3NPMjI1cEpWMDl5?=
 =?utf-8?B?Z2NvRjhRWlBYZUFkQ2piVHF5T0E1bFhFRzlieVlhUnpBc0ZiUG82QlRPRDJz?=
 =?utf-8?B?bElJU1NyNXlyd1hkYnpwS01ydmFtN0VuVzBSbCsvbEJ6ZWhzRkNxeVd2bkVj?=
 =?utf-8?B?YW5ETUZIVXpNRkowallIckhyZmRiZ01EeXlLbXFESUdobUtjb3gva3M2OUcx?=
 =?utf-8?B?Nm1FczllTFAwVW9ad1lnTlVDZHlQL0FLbk1lRnhoSWhZVXhTQS9QZ09FYWkz?=
 =?utf-8?B?aWhXMlhuNVNpV0VCV0lzZ3FEbGRGU3BkNU54eE1IRWYzNWhsWXBLWi9tUmZw?=
 =?utf-8?B?UHNNM1VQNVI5aEZZeTg0azBoY01McnlNZ05rZFNiREJHeTFXYXBpanRud3FB?=
 =?utf-8?B?Vm11MjJQeEVGUGRtbWxnZWRTK0R2M1BZS3VvVXZ0ZUxEQU5wZFJWMUhSYzVG?=
 =?utf-8?B?VmRyZkduTEswcHUxV2JoZXBJN2VBREVUMUhsUndRZkc5aGtlczVBK0lzUE8r?=
 =?utf-8?B?S2VCSVBFMERMTXhvNGRXWmdyRjg1bWR4emlxKzMwMGZ5MGpHS3Frb1FDM2py?=
 =?utf-8?B?bGlTdG01TU5pMEIzSkc4Y2p5WG1FVDd6SHpZa0ZUMVVkMitjeFZsVGtDL2Nu?=
 =?utf-8?B?RHlQNE1CRWRJUEFuSllkWVFSazN3bldEdFNYRGJXcWNaY3FmY2tObDFCMWph?=
 =?utf-8?B?dXNHb084Zlp0ME93eVZDYXM4Sk9RSVduRGUvQmFIcVBReW5GSTdyZWlZbkUy?=
 =?utf-8?B?UUtia3JUaUVDMUdHRDE1NGVGbzZCeVc1Z1hoVTNVQkRYRzFmYjVQSlBHRFBN?=
 =?utf-8?B?ZlI3OTNpU2lZNXR0d3Ricyt2MXAvOUtONG5KeDUwN3B1MHA4R2YvQnRWSyta?=
 =?utf-8?B?SEVFdUtUendqVmtTVTBxay83SWRXTkRZSEpVVHpDdkROM0tZZGtYc3FySi96?=
 =?utf-8?B?U3d4KzQ4N3ZqUWxrTmovYk1tb2R0VStjWFBGTnZRWUl4VjVwMVdxR0wzUE5I?=
 =?utf-8?B?ckJjTXVCZnEwRU1NdUFNd2VhRGlOSXZpbWFaU1JJWUNQQTF0WXNLVFRhREkv?=
 =?utf-8?Q?W/2jtxuWHytv9GhG2s2KoUHimLXXGypV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8558.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0c1QWFaVlc1L0JVV1FDY01CZnp4UmppaFZTd0d4SytTNFlrL3owVDluWHU2?=
 =?utf-8?B?OERHUnIrOFlKOGxnUlpjUXNTbnRIWDJKbUdXdWlFL1ZpNEVLZURJbjZSM3hz?=
 =?utf-8?B?aWNkRUdVa09MRGJKTVlvRWM2OENuMit0T0FWTXpVSlZPVkJFbXFjeDl4cm1j?=
 =?utf-8?B?VE9tcGg2bjdKSzBZczE5b3NqYUYxLzVQZDN1bzM3UzBjNFRCUURPMU9aRjNL?=
 =?utf-8?B?NGhJN3JXMUxIeEFoRmpoN2NXWkpVQkU0TFdPdDYweU1BTkphL0dyZmQyMExV?=
 =?utf-8?B?enNJOWl2UHBlRHJ6ZHhQc1JvUmJyNTMyWGhHRDRlUTJ2QVJ5cElXZFk4bDEv?=
 =?utf-8?B?TXdPRGFXQ1NSUTg3Mk13aVlCZkhDUnlaUWcwV0FjYXJGUjNiTUFveUI1MWRu?=
 =?utf-8?B?Y21GY0d4UEdrdFdUeWlKcFYrcDFyemRyTjNvWkhtQ3JhVXBuMGY0d21xWkRP?=
 =?utf-8?B?dGVZN1JLSWNGUXRoMnQ1d2pGWENKNWhlTndNZE9pbDNKdHJheW5NTGRieFNi?=
 =?utf-8?B?aStmcWFLN3duU2hpeWUxMTJ0ZlFRb0d1VndNZDZiVVE4emJqMmtLTkd5ZHZ1?=
 =?utf-8?B?WmpHOTVwbU9oVmZrTkptcllLanh4bmp0VCtYV1JNOW9iUExoeUNSVldKdWFp?=
 =?utf-8?B?ajJaSUNjajhTbGxHN1NFRU4vTVdQYWdsck1yMWpDSTUyNWdQM2dKM3ZqZGNh?=
 =?utf-8?B?RmFEbmtpWU5DVUJpMVgzMFlBU1FVQlpmak1JUWhaUjNoT0FQN0tTZ0Y2aU9U?=
 =?utf-8?B?VXI2NTdIMnNiQzN0TTEvb2FqaHQwYVZBakxybzhjUVo4eU9ENnBOWlprVHpp?=
 =?utf-8?B?TlZmVEUrK0lVaGtnaTlpS0ZKR0V5QXlrTEpsZlY4M3BCVWI5WXZXZCtFNjdK?=
 =?utf-8?B?S3R6Y05MaGZwRUtqZ2owYmlSNVVJdjVIQ3ZLNWNUZkp0MEtDS3Q2VkZMQWdL?=
 =?utf-8?B?dXROWWJxdEU1Y21vMWJUOU9MaHNLL282WDVteTZ4UUdNS0hzelVVNE1jT2cv?=
 =?utf-8?B?bmdCU1JGM2o4b2haVkE4d3E4OEtKZGtTNFlpaUxrZlQ5ZnpZVGNqaVROd2l0?=
 =?utf-8?B?dStsVnZlNTBHUmdHT2FxcG1uV2RjRDV0TUErR1lpNTFycFJhMER6RjdOMTZW?=
 =?utf-8?B?cGZqZGVldFgraXRyMXB2VlVrcThvVFZ6T2d3cncxNENSR3ZEbmUvcVdZbkRY?=
 =?utf-8?B?NzhzSmhHWDhjL1E2RFNIeER1azNUQjNuV3pzZEEva1drN1VMMTFkRnVheU4y?=
 =?utf-8?B?M1ZZRlhCZ2p6WTliSzkxWlZoc1k4TXdjZDJyaXVyRzdjU2hVSisrK2ZUWlpm?=
 =?utf-8?B?WDVMSzdGaDdpbnJSaXp5S3hjWUFVcnVYZ043VU1ZWWtjazA1TlN3UExHbS9j?=
 =?utf-8?B?MGlpSjNLekU3RzcrbWE4RS9QSzhvdkloYnZMakI1b3E5L1hnSHpwekRYMXFQ?=
 =?utf-8?B?TThYeTZpcmdmd25OOGxHbndRb0plZGZFOGlQRm1LbGhZdTd2S0dWQkpHNzk0?=
 =?utf-8?B?SFc4dDVzMzRhZUYrT2NxUW03cmVHbEI3RFAxNGM2NCtXaDgzSkhiTDl4U1NC?=
 =?utf-8?B?aXFCSkdXRGVGSkxScEhpMnBrRHNaQXBFRFNMYzBWWUgxb2FOQklEZWRlbzV6?=
 =?utf-8?B?c1VXcFBQdGNQZ1VsaGFKaGpkdTVmWkpjbWNLcmttVktWWUV1Vlo5Wi9KY1lL?=
 =?utf-8?B?U0hMcDlET216Y2tzb25KeVRGa082ODFxK2hIS2FqK2doRUt2Sjg0TmNVWkty?=
 =?utf-8?B?dEpKa2duVm15ZGhnMWFLTnp5enUybHF4SzRnbGpGQTYxazlnamVxaFRBZG9q?=
 =?utf-8?B?SXhoTHROeWNMR2praEMzbE5QSjFWQlZoZ1dxaHhSNHhiZmx5YTJQTXA4UGNX?=
 =?utf-8?B?ZUdMdkEzV25hMi8wNGhQd0VCZ3U5QzVLcDJuS0c4QW9wS2Y0Z0pMUmZnOUNn?=
 =?utf-8?B?NnI3YmwvcGlsS2tnSkRZcGhxU3hpRmo0bGNxUUc3Z3JkUnV1UmZ3MWFycm1S?=
 =?utf-8?B?eWZscmdyM2xDdUxCWFRUZWcxVlEvdXJGNjQ3MTJJZlZ3aG1rOXBCR0ZaQ1NY?=
 =?utf-8?B?ZUl6RElxYlZzbHpmVzNnbUNZOGdZdW9STUNiZEw0V2hTTVMzdWhzNVVCUDFT?=
 =?utf-8?B?bEVKdGdJWjdjb05vWVM2NWpSenN4TzRIN3VsVEFTQ3pmamdZTjNpWlByL3pz?=
 =?utf-8?B?MHpYUW5JU0xmbnZYUHVmMzhZQXRiZEhvRS9EaC9qdHNEOHJnVDVvRDQva3Bz?=
 =?utf-8?B?ZU93WTRvb21hTXdvKzc1VDR3M2tBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8558.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d4f43a-bf97-46ed-1ab4-08dd3ef01409
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 16:31:40.5056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BB4lXdJ0OezJ6zsjZxXBJO2SBikYaRXRD9mozm1jOAZ5naMcTK82y6DVhx/JrP/5yM7fBDPUmjetsbCPadBeaIxzSHiPsBeeipypNvzllMwXALFKQdPV2joC9l23+Btq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7133

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBBbmRyZWkgQm9yemVua292IDxh
cnZpZGphYXJAZ21haWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgSmFudWFyeSAyNywgMjAyNSAzOjM3
IFBNDQo+VG86IEJlcm5kIExlbnRlcyA8YmVybmQubGVudGVzQGhlbG1ob2x0ei1tdWVuY2hlbi5k
ZT4NCj5DYzogQnRyZnMgQlRSRlMgPGxpbnV4LWJ0cmZzQHZnZXIua2VybmVsLm9yZz4NCj5TdWJq
ZWN0OiBSZTogc29tZSBxdWVzdGlvbnMgdG8gcXVvdGEgYW5kIHFncm91cA0KDQoNCj5hKSB0aGlz
IGNhbiBiZSBkaXNhYmxlZA0KWWVzIEkga25vdy4NCg0KPmIpIHNuYXBwZXIgb25seSBuZWVkcyBx
dW90YSB0byBwZXJmb3JtIHNwYWNlLWJhc2VkIHNuYXBzaG90cyBjbGVhbnVwDQpidXQgc3BhY2Ut
YmFzZWQgY2xlYW51cCBvZiBzbmFwc2hvdHMgaXMgYSBnb29kIGlkZWEsIGlzbid0IGl0Pw0KRXNw
ZWNpYWxseSB3aGVuIHlvdSB1c2Ugc25hcHBlciBhbmQgaGF2ZSBhIGxvdCBvZiBzbmFwc2hvdHMu
DQoNCj4+IEknbSB1c2luZyBVYnVudHUgMjIuMDQgd2l0aCBrZXJuZWwgNi44LjAtNTEtZ2VuZXJp
YyBhbmQgc25hcHBlciAwLjkuMC0xLg0KPj4gUmVhZGluZyB0aGUgbWFuIHBhZ2Ugb2YgcXVvdGEg
SSBzdHVtYmxlZCBhY3Jvc3M6DQo+PiAiUEVSRk9STUFOQ0UgSU1QTElDQVRJT05TDQo+PiAgICAg
ICAgV2hlbiBxdW90YXMgYXJlIGFjdGl2YXRlZCwgdGhleSBhZmZlY3QgYWxsIGV4dGVudCBwcm9j
ZXNzaW5nLCB3aGljaCB0YWtlcyBhDQo+PiBwZXJmb3JtYW5jZSBoaXQuIEFjdGl2YXRpb24gb2Yg
cWdyb3VwcyBpcyBub3QgcmVjb21tZW5kZWQgdW5sZXNzIHRoZSB1c2VyDQo+PiBpbnRlbmRzIHRv
IGFjdHVhbGx5DQo+PiAgICAgICAgdXNlIHRoZW0uDQo+PiAgU1RBQklMSVRZIFNUQVRVUw0KPj4g
ICAgICAgIFRoZSBxZ3JvdXAgaW1wbGVtZW50YXRpb24gaGFzIHR1cm5lZCBvdXQgdG8gYmUgcXVp
dGUgZGlmZmljdWx0IGFzIGl0IGFmZmVjdHMNCj4+IHRoZSBjb3JlIG9mIHRoZSBmaWxlc3lzdGVt
IG9wZXJhdGlvbi4gUWdyb3VwIHVzZXJzIGhhdmUgaGl0IHZhcmlvdXMgY29ybmVyIGNhc2VzDQo+
Pm92ZXIgdGltZSwNCj4+ICAgICAgICBzdWNoIGFzIGluY29ycmVjdCBhY2NvdW50aW5nIG9yIHN5
c3RlbSBpbnN0YWJpbGl0eS4gVGhlIHNpdHVhdGlvbiBpcyBncmFkdWFsbHkNCj4+IGltcHJvdmlu
ZyBhbmQgaXNzdWVzIGZvdW5kIGFuZCBmaXhlZC4iDQo+Pg0KPj4gSG93IGlzIHRoZSBjdXJyZW50
IHN0YXR1cz8NCj4+IFRoZSBob3N0IHdpbGwgYmUgdXNlZCBmb3IgY29tcHV0aW5nIHNjaWVudGlm
aWMgZGF0YS4NCj4+IEhvdyBiaWcgaXMgdGhlIHBlcmZvcm1hbmNlIGhpdD8NCj4+IEhvdyBzdGFi
bGUgYXJlIHFncm91cHM/DQoNCndoYXQncyBhYm91dCB0aGF0ID8NCg0KQmVybmQNCkhlbG1ob2x0
eiBaZW50cnVtIE3DvG5jaGVuIOKAkyBEZXV0c2NoZXMgRm9yc2NodW5nc3plbnRydW0gZsO8ciBH
ZXN1bmRoZWl0IHVuZCBVbXdlbHQgKEdtYkgpDQpJbmdvbHN0w6RkdGVyIExhbmRzdHJhw59lIDEs
IEQtODU3NjQgTmV1aGVyYmVyZywgaHR0cHM6Ly93d3cuaGVsbWhvbHR6LW11bmljaC5kZQ0KR2Vz
Y2jDpGZ0c2bDvGhydW5nOiBQcm9mLiBEci4gbWVkLiBEci4gaC5jLiBNYXR0aGlhcyBILiBUc2No
w7ZwLCBEci4gTWljaGFlbCBGcmllc2VyIHwgQXVmc2ljaHRzcmF0c3ZvcnNpdHplbmRlOiBNaW5E
aXLigJlpbiBQcm9mLiBEci4gVmVyb25pa2Egdm9uIE1lc3NsaW5nDQpSZWdpc3RlcmdlcmljaHQ6
IEFtdHNnZXJpY2h0IE3DvG5jaGVuIEhSQiA2NDY2IHwgVVN0LUlkTnIuIERFIDEyOTUyMTY3MQ0K


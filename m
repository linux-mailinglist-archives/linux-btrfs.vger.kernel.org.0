Return-Path: <linux-btrfs+bounces-12378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E39A67456
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 13:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBB7189CAF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 12:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20E20C48D;
	Tue, 18 Mar 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HJ0UZZC6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bPI0xaTJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E19208966;
	Tue, 18 Mar 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302329; cv=fail; b=pgzx5xhBakiMOeZOSbJFILqYqcHTAGx1EZXUktwH/jF70j3mc5Uhae3atjbE3utsjELYoiCtixE4G4TaQCnwcLzt00jBtVJtUwIQbOoUbGWqGnZ0MwxqwTfxiPknfXA/uRMVkH4EniV3XlLDlMHetcRkH1kpVU4bNFTI+z0X9Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302329; c=relaxed/simple;
	bh=eElisD+HjhbW6yet1HX52zQDAG0NswWPqsCoiDN6tao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U67OMuWHu39H4XzOl+vAQIbdZwyXH6bMDpNTEtZihqie2eAZa0QMMgcD1Hu3U/XamXmrkgXREtn7K32pdWUbOMpaBSsfH1IPT7ZBYSsTvKP93tcP0N1xQP9Ub7y3zeaQZP3fDTVL5tUx37Xj1VhsM7pA43oM3GX27H2LcnB9Yvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HJ0UZZC6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bPI0xaTJ; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742302327; x=1773838327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eElisD+HjhbW6yet1HX52zQDAG0NswWPqsCoiDN6tao=;
  b=HJ0UZZC69ER60hwxYsYmtmgiI82qG70hZmkefkd9oRpbW9FgpGconXv2
   4+e5YwYawdrL8DEjEaM3mh19rgmv0rhaKDx+SbhdBpBh2UrSKm6s4bvXV
   EjEFEpWDcYLBRfHVi9EgYmODKozup+04SdGx8fQUtZb9ANT+2RyW7ZT32
   uoXr+6bwPiX01DAok17ZStRrALqCtrI+nORdqvvPk3+fT6rNhHPhdrqxF
   iuhH9BrF3ShAoQP2mevHVZePAT+yIo2L69rVzTH30otwFxA3f3dlYkSKI
   5/jsDKqj+MamOqvt6GctZQek20vUu30tVeDPJ8yQXjAKWNyQaZGGuU9A7
   Q==;
X-CSE-ConnectionGUID: bNGQ8syqRpCtwetSBxsruA==
X-CSE-MsgGUID: gRlLBJcuSTGG1ya0H7zlPw==
X-IronPort-AV: E=Sophos;i="6.14,256,1736784000"; 
   d="scan'208";a="55247221"
Received: from mail-westcentralusazlp17012037.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.37])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2025 20:52:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwGxIXmDtHTUitXFHodQs5imabm0qPAeJ/GH2tzTRu5o97cX1jCAA7KSQKkfYnw7u23yeCNuUdQCaGf+lht/FEuKjEEPWF99SRXJIHw5D7m+zlHz+co1UoZBYZc+U6w7wgk8VuOBFO5UXA3iabBE0nk7fNNnfFdlNu88Mi4NlS+WeWcp+pb8Y50/Zg5NH61Yylu3PQtLe/D2hjNjJFEkb2xN4irZNTeFIJP6z0pslvcKfasnbsL3fNjXpPSIJa6mhQrf3JCQYcA6oq/zU+iCdFfGgYIlYMMDAZD6R6vuH7x7+F7cVfEHHv5I+SznuUQ2XKjV0xOG1shTym/9WwljZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eElisD+HjhbW6yet1HX52zQDAG0NswWPqsCoiDN6tao=;
 b=m+6X/Zq+Jdn/oNhEAGA1xEma8Lpuvq6dcLH9L4693lJy7NgZQAsmYriIgjz7yMeAozpVmXZdCrkw0oAHkYfDdWYuyB6W5PK3ZL8P8PRsszFK6zn/9Zy13VvocsrNKlWbujOAJV2ie3aDb9SIkIk6yvwb2lo0MbCcLFQiEVChu8mLpEraZOTF8kJ6f+xmEjVI6qOdMI3utnhOgwl0fWya27LaLA9a1/+5w97JMtFVG7sMLfjMgcfhWlQW2eyaepGG4dQfXD6m0brnxwopKQ/Jv0yWKJPo4G9b0yBpz6fU9iAhlxO1e3K0ggkHt+nnbwkTNQ2KCaBwcHgEwW0FrcUDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eElisD+HjhbW6yet1HX52zQDAG0NswWPqsCoiDN6tao=;
 b=bPI0xaTJwL+0RQsFr2kdSqp3dXB36Z9oKbNzKyV3ItabhnVHOIJrH11MaX0hLxnG7ksBPOihnN1M5gejzY/doHh880R07HriQhbxayYuHS/91ZM17zZJdjMxs4OQezN9Bn63shRtoznUoHagkPDlecSt8dIZmuZgpvYNjzMGje8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6814.namprd04.prod.outlook.com (2603:10b6:208:1e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:52:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:52:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, Zorro Lang <zlang@redhat.com>, Anand
 Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@suse.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
Thread-Topic: [PATCH v2] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
Thread-Index: AQHbmAQ2YXGQk6xPW0yhcPZ+BglXA7N42Q0A
Date: Tue, 18 Mar 2025 12:52:02 +0000
Message-ID: <535c8a6a-ca47-4560-8a56-99af06295b4e@wdc.com>
References:
 <d5ae8704427e156eb6dca0b720847e48665a6340.1742302069.git.jth@kernel.org>
In-Reply-To:
 <d5ae8704427e156eb6dca0b720847e48665a6340.1742302069.git.jth@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6814:EE_
x-ms-office365-filtering-correlation-id: 4787eb63-8bb6-487d-3af0-08dd661badfe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U01Xd3lTaDI0VFFTVko1dytTaGNjUnZYdng4R3R6UFBGVlJ1anVzL3hKbE9T?=
 =?utf-8?B?WFZJeXNCR0h5U2lvNmdBSGxzNVQ2UE1yeDdYNVdHbkpWYmwzLzJaVXl1dTJM?=
 =?utf-8?B?UmJRWkpNOWtxcTVlOU02eUhaWXhlV0ora24vN1dGbWplZTVDaVF6S1pTNEJP?=
 =?utf-8?B?TXpoRERHeVk4L1E2a2cxR2NHZGQ1M3hyOXRuenF4alZQWlFJWEZsd04xN3Rt?=
 =?utf-8?B?M1UwUjhOZ3Q5MksrajJlVSs4WUdEUjlFMTdkbnlvUXpianY5SDI5MFdVSDBE?=
 =?utf-8?B?ZW12UEZsUldFdzNaZjlPdWgzWlpnMWsxNk9TUkpicGtuM3FQbE8xUU1sQkJo?=
 =?utf-8?B?QUV4OG1xcVFLK0VxaFQvODB3RnVuTThXYjlKVWgwcVNKMjZIMUFvVEtXWkJB?=
 =?utf-8?B?OHNSOWhJVy9NazFvS1ZtT1BzTlI5c1Q3MEdGUTdLNEhpSFd4ajBQUU9KUXlL?=
 =?utf-8?B?RDJyMmVSNTZESmZCcEN1b3FLUzE5ZUFIZ25sQ2NHcUdrUk5CNlkxckgvdUtK?=
 =?utf-8?B?VXVMeGNKblhobHNPbHUvZGxvRFo3eUJ4YkF2cjY0aHNmU04ySmo4K0FrbUpK?=
 =?utf-8?B?RHJrMUg5bGwrWFo0SG1zSlZXY1d1ZzRIU0FDMmMwYTg2Q25WWHdWNmVlVlFq?=
 =?utf-8?B?UFpRczdOdGgzSWJFV1lYTStnSHJxUkdHQ1BYVko4TDhydzB0b0srRnJEUXhx?=
 =?utf-8?B?eEZ4UG00b2pLaGp1REVDME8xTWJWb2JxSGE2L2VaL0pyMmp3MEZmRHR4Z0JY?=
 =?utf-8?B?bVlkOWgyN3hDM1BXNWIvc3ZpOUkvMHduRjkxV3dQb3ZhanZsQVN3bEw1VUdl?=
 =?utf-8?B?eG5POFJuaDFXYzErb0svem13Mk5YSGx1ZWNVaWhGTm9CY0M0QzF2ME1OQkZ5?=
 =?utf-8?B?Zjg1N2s0NGNiT0Q4OHBqZkMybTJlek5VMHBjUWsyUG5kcWRwRG0vWXh6NVUv?=
 =?utf-8?B?RHkySmg4THBPUEtBQTlGb0NUeDd4TW5QUHkvL3N1VXNLMURTeTF3bGxNYUFV?=
 =?utf-8?B?VGREWFZ5VkxpbXlwdWpxYVgzbTNCcTZlcGxuTWpkZHA2WTZBTXEvL2RqMXpn?=
 =?utf-8?B?dVdLMEU0R0oyNVp6UlpUY1ZKSG1Ma0YvRk95bzgvTGhhSTBhckR5Wkp0dURi?=
 =?utf-8?B?Yy8rcTdIczhIdVFIM2dzMGZLdTI1UU9nYUk2VjZPT0h4dHZkRVRURjluQ21i?=
 =?utf-8?B?Y1d4c3h0dEJhQXNuK2R2ZWNHQVNsTzlIUWlmVmltUm8rTjhmMjhQMXZreXBo?=
 =?utf-8?B?ZmFZTmsyQkUzZ2dYU0R5cUJwaFZFMXFnOXQyaitTbzNwRlpydU00WGxMcWxP?=
 =?utf-8?B?aCtNZ09ZamIyMVo3TWt6V2VNUVAvdFkrN00vWUJrbDhzUkRwL2pnS0NQcUs0?=
 =?utf-8?B?eXRLRFpVUkwyWGhMSVl4V0ZnU2NRZGtQdXpnYTNIb3ltcXg3a2MvN1JydGZR?=
 =?utf-8?B?MFFEdGdXQ0xKcGExSHQ0STJqdW1kRkJEek9WNDlSVHdUNWUwRlR4cDZ1RXU2?=
 =?utf-8?B?bnFMZUVSYTZNNTU2N2hPRkxQMUI2TWlYMndtUnFaUmxCNW82QitBcEFNaXVs?=
 =?utf-8?B?ZzRLQlNmbTY3cXIyLzZza3N4d3FyeDdHY2dseUtSRTZRSVczY1BhQTJHeDRv?=
 =?utf-8?B?RzNUWGp5Qnk5M0dpNk1GYThQU1h4UStFUXpjdysvaFNQZlAzRk1MQ0ZxeVkw?=
 =?utf-8?B?YWRSSWpDYnlUSzdyS3Q1Z0JWZElKQktFWXArSmJyOStRaERnTlpqQVNCSDh3?=
 =?utf-8?B?US9ib1RzdTRHNHVldVF4N3dwMjFmQnp6YWhZTW1lWW1tTXFzZTNmUHNLeFZS?=
 =?utf-8?B?c0ZUdHFmVlJmTGlaanJHTU5SMk8rclBzbGFKS1pxV0pvTVh5S1F2VzEySmlJ?=
 =?utf-8?B?UzljSTY2Wll0Z2FoRXRzSWJaMnVpQm9qTCswRGFYNituZUhySUhNMmEvYkJi?=
 =?utf-8?Q?FL52iZ6SutWFBScBwOOLd5vYRLesyo9i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHl0aXkyUDdLRkljeUFnUlgzTW9QMUVJZGhST0tYY1RBVWhWTDNzWGMvSHdo?=
 =?utf-8?B?QWowTmIvc1hoMW9uLzJMYnlUdkNvSmVuUzRqQ2lZSDQ4M1d4V0hjaWVpOHQ0?=
 =?utf-8?B?bTJEUGQ4M0xnaW1xYXB3OFdsTVhJV05yaGVRR3o4N1BnUkdvQWlOY1ZxcmRr?=
 =?utf-8?B?a2g2QnZuT1M1VUxuRE83a1ZSUnQrUW50bHR4SlU4bU56SFU1SU96VVJoOGhm?=
 =?utf-8?B?TXBFeTBod2lHMHFkUmpFaDhHOFFOdERGdGMvZFBHM0VUYm1sbWYrZG5tRWRw?=
 =?utf-8?B?VkYxdVRPSm5LZWRTVjZ6SVkwVlV1b1BIWXhhZ1VMTExmRXZGa1ljclJDZXpp?=
 =?utf-8?B?QlVlWFMwd2ZNUFJaaHlLMTA4UC9JcXVSWjFka0NJNmZOU1Q2ZWpXQ05JWE5k?=
 =?utf-8?B?a3AweFdzTXBHNnVIN21LUU1VYm1GVjlFVHNNbFZUS20vZDZzcFVjeTVJcjVm?=
 =?utf-8?B?UFBUVmsycVllcXJheTFNaTVZR0huSmk5ZS9ZREgxMXZXZ0FHM3BKZ3d6V1dl?=
 =?utf-8?B?VnNjeHl0dmJFMXBLdDJiTUdYcVlsaGV0N2xHNFp3bzBlcGpEamlOektLcVpQ?=
 =?utf-8?B?Nk8yUEZZRjRMS2F0dXlLWnpud0VTRXNlNXR6ekpQdFl4T1ExS3dveTl0T0lz?=
 =?utf-8?B?eVpKU005L0xGcFBqdWZqSEYxdnJHaFRmUXR0L1AveWRHcldmSEk4Wm5jQmJq?=
 =?utf-8?B?aktobEhVcmttYU1KZFRRdkxWNlkzdDBrQzE2cXQrMGY0N3dEcmlPNTRoL2lt?=
 =?utf-8?B?ZE1wbTBFSGM5bGdDR2JrN3EwNUd3NlE5dERUS01FbXNIVzdYMU8xMTlLalFk?=
 =?utf-8?B?Q1VHcnFRMEZjYnlRMFAwQVFSckk2ODJrQklJUTRJdzh4TlVzVGl2T21vdjJw?=
 =?utf-8?B?c1dIa3d1RWwxVjBNRDZHamJ2UVBYeVlraURyZ28wOTMwdzBxMHA0SzRRaU5Q?=
 =?utf-8?B?MDVhTDA0eGdmYVg3ZVRoL0gxaEtRK2tScEJiNC9xN2NES3ZGcXZLWXBsNWdU?=
 =?utf-8?B?MTRLODRuanNpME5vU21mQk94N1N6cW5ROGhjTFF0QyszQTh6TndEOVJvcjdY?=
 =?utf-8?B?YlNLMEIxM3lEZ05pYStiakZDNWM1eWpXUDhyZTlBZE5uRnRHV1puYW12Q2lz?=
 =?utf-8?B?bU9pcVJwMlpGWGF2YUNnR3RCQklBNklCSTRRZTJrUXpFaFgzQ1FQcTFqdVQx?=
 =?utf-8?B?VGZjQUJRamdOUmNqNnRncUVyaDVWeHExMDFJVzZORVZ6ZzJzMnNkWHcxeXpY?=
 =?utf-8?B?NTJjc2F5YlNrMmxlL0ViVjZ4K3lLSkJUdUNidUVTbHRoNEI0bmVQNlgxWFpZ?=
 =?utf-8?B?R250M2o5LzlDeVcrMDZXMGFsWmZpTXVqRC9qOElIUWVyMHNIL0FkcDRvMmd2?=
 =?utf-8?B?alczSkQwdWdDQjlUWVRjUE95S1J0eGduZ1V5T1BxZllnMlVVMDNvVFZoenNZ?=
 =?utf-8?B?bUdSUFhLdHhyNXBoZ0Q1VUNUMjhjaUt4cHdaZVRld0V5SnlQVFhCeXBGR21x?=
 =?utf-8?B?MktmZ1NTQ0l0RnFYMnZ5TDRXVG9EVFpqd0Q0ZG5XQ05teEpybzNwN2JtWURk?=
 =?utf-8?B?RlNJQkxVd3NYQnpHYldBeVltOStWdlEvNHV5UmkvZmh1MEtaMG1xWXlZVVd1?=
 =?utf-8?B?SXI2OXBaN0E4YXJuMkl0Mk82cmRXMEl3bGUxRlNLT3VqMmZUWkZWcTJTWEFj?=
 =?utf-8?B?dGdvck82RGtRVE5Ua3Bua3RiM3QxTXY5cWNDSHgwb1RFeDdFYmlyTGdJbytp?=
 =?utf-8?B?WTcxNFYwTjlsWVJNaFpRUDZPc3RMNHBlL0NEdGVpVW5JdEdMclB3cVAycXND?=
 =?utf-8?B?aitsQmVob0VSTWw2K0J2ZllKSkNKMmhidnYzcFV3MGE4bWgrS0FKdEhheHJU?=
 =?utf-8?B?bXhSdEhvL1VLbHcwYUhsTTNwaDl5VHJFTTNXaXFyRXRoMlZ0TW9ncDFnWXg5?=
 =?utf-8?B?elhkVTNnYnl3ZkNwb1JadlRPNlo1MGxDalZxZy96WVpLVHF4S0dxd2MvdUE5?=
 =?utf-8?B?RUZqRnlPSVlzZDM5K0tKVlBIMkdGejdyS21QVWlsbUh2U2orLzloRXhRWUJj?=
 =?utf-8?B?MEZzOWxzV05EN0ZGUmR2ekMwYWtFWW4xM0JtNWl0TUs1RzZvWDhhMVZLTXIr?=
 =?utf-8?B?bHVxN2hNbGV4VHduQU9DYkhZT0JpbURlU1ZMbkxheWcrY2RZOEV3UE1oZ1FS?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EA7AB4A9A91064EBD80608142DE25A0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+wIzDy2SDpXbTsqJ4W3S+LDTVmGTt1fOBIj9PQbReOjLvADm7F2az6R79YXy6mKzZeOpXwBVfz2hzV1CQ7QGPNOAed4DEl/mAe8hhcoChsfCueZDuujaCN4FpoODoMCo3De2/8OE5f5l7ASR5o9B0XNFx8knAHCZdzQwf3wBBuWB6K+k0zxO0uq4EeZFqp5CmjSKRnU/aFEqAjQdH4u9diGpifk8uMLGaLc+SobtGRvVm17X3amBSPepQiC5eh+osoNpEJi0yc4EvYPVPN/HuSVpP2J2hZGTgXoeWLgvqGPvYlUC4FiIJHWIS+g5SOBcow6KewIzmOWoINnt2T1kqrRBETra9dVDiGj4uXLUNyzkhoIeuuxfo+BpqUeUfBDC04svTzr0PdUGZTMHr2nj1RawWypwrwyZX74haD381Ti0XBR1giDETcqEEUDjhyH5Whf/zfnUM7Q/47a8VfNHIYVLrkHABMVy0zcO/P0IIoUvkpG7NFwBgNpdg7TvsGKw+a6b6O0wS07mXuVY3WPmJX2rlsC5u3sv/9FdNYe482zeatFmF7td4XNw+updYHexqs+a+cmqDXU2aOiY8YSTR79OYbapH+1JWbzrFPfq9PoA0lEy1eTN2LHC3VMTXPNE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4787eb63-8bb6-487d-3af0-08dd661badfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:52:02.5568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FP2YFnAX0Aj32OZOKcu84BWAziboauhx0FcPlHdOwrLghGTqqVPSezqQQqzZn5WeotpAfEUtzCncDEv03bSNQuUlmVQa8Kg5DcxKDQk+Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6814

T24gMTguMDMuMjUgMTM6NDksIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gRnJvbTogSm9o
YW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gDQo+IFJlY2Vu
dGx5IHdlIGhhZCBhIGJ1ZyByZXBvcnQgYWJvdXQgYSBrZXJuZWwgY3Jhc2ggdGhhdCBoYXBwZW5l
ZCB3aGVuIHRoZQ0KPiB1c2VyIHdhcyBjb252ZXJ0aW5nIGEgZmlsZXN5c3RlbSB0byB1c2UgUkFJ
RDEgZm9yIG1ldGFkYXRhLCBidXQgZm9yIHNvbWUNCj4gcmVhc29uIHRoZSBkZXZpY2UncyB3cml0
ZSBwb2ludGVycyBnb3Qgb3V0IG9mIHN5bmMuDQo+IA0KPiBUZXN0IHRoaXMgc2NlbmFyaW8gYnkg
bWFudWFsbHkgaW5qZWN0aW5nIGRlLXN5bmNocm9uaXplZCB3cml0ZSBwb2ludGVyDQo+IHBvc2l0
aW9ucyBhbmQgdGhlbiBydW5uaW5nIGNvbnZlcnNpb24gdG8gYSBtZXRhZGF0YSBSQUlEMSBmaWxl
c3lzdGVtLg0KPiANCj4gSW4gdGhlIHRlc3RjYXNlIGFsc28gcmVwYWlyIHRoZSBicm9rZW4gZmls
ZXN5c3RlbSBhbmQgY2hlY2sgaWYgYm90aCBzeXN0ZW0NCj4gYW5kIG1ldGFkYXRhIGJsb2NrIGdy
b3VwcyBhcmUgYmFjayB0byB0aGUgZGVmYXVsdCAnRFVQJyBwcm9maWxlDQo+IGFmdGVyd2FyZHMu
DQo+IA0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1idHJmcy9DQUJfYjRz
QmhEZTN0c2N6PWR1VnloYzloTkUrZ3U9QjhDcmdMTzE1MnVNeWFuUjhCRUFAbWFpbC5nbWFpbC5j
b20vDQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNo
aXJuQHdkYy5jb20+DQo+IA0KPiAtLS0NCj4gQ2hhbmdlcyB0byB2MToNCj4gLSBBZGQgdGVzdCBk
ZXNjcmlwdGlvbg0KPiAtIERvbid0IHJlZGlyZWN0IHN0ZGVyciB0byAkc2VxcmVzLmZ1bGwNCj4g
LSBVc2UgeGZzX2lvIGluc3RlYWQgb2YgZGQNCj4gLSBVc2UgJFNDUkFUQ0hfTU5UIGluc3RlYWQg
b2YgaGFyZGNvZGVkIG1vdW50IHBhdGgNCj4gLSBDaGVjayB0aGF0IDFzdCBiYWxhbmNlIGNvbW1h
bmQgYWN0dWFsbHkgZmFpbHMgYXMgaXQncyBzdXBwb3NlZCB0bw0KPiAtLS0NCj4gICB0ZXN0cy9i
dHJmcy8zMjkgICAgIHwgNjEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICAgdGVzdHMvYnRyZnMvMzI5Lm91dCB8ICA3ICsrKysrKw0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9i
dHJmcy8zMjkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvYnRyZnMvMzI5Lm91dA0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2J0cmZzLzMyOSBiL3Rlc3RzL2J0cmZzLzMyOQ0KPiBuZXcg
ZmlsZSBtb2RlIDEwMDc1NQ0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjBjYzc1YmM4MTU2ZA0KPiAt
LS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL2J0cmZzLzMyOQ0KPiBAQCAtMCwwICsxLDYxIEBA
DQo+ICsjISAvYmluL2Jhc2gNCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gKyMgQ29weXJpZ2h0IChjKSAyMDI1IFdlc3Rlcm4gRGlnaXRhbCBDb3Jwb3JhdGlvbi4gIEFs
bCBSaWdodHMgUmVzZXJ2ZWQuDQo+ICsjDQo+ICsjIEZTIFFBIFRlc3QgMzI5DQo+ICsjDQo+ICsj
IFJlZ3Jlc3Npb24gdGVzdCBmb3IgYSBrZXJuZWwgY3Jhc2ggd2hlbiBjb252ZXJ0aW5nIGEgem9u
ZWQgQlRSRlMgZnJvbQ0KPiArIyBtZXRhZGF0YSBEVVAgdG8gUkFJRDEgYW5kIG9uZSBvZiB0aGUg
ZGV2aWNlcyBoYXMgYSBub24gMCB3cml0ZSBwb2ludGVyDQo+ICsjIHBvc2l0aW9uIGluIHRoZSB0
YXJnZXQgem9uZS4NCj4gKyMNCj4gKy4gLi9jb21tb24vcHJlYW1ibGUNCj4gK19iZWdpbl9mc3Rl
c3Qgem9uZSBxdWljayB2b2x1bWUNCj4gKw0KPiArLiAuL2NvbW1vbi9maWx0ZXINCj4gKw0KPiAr
X2ZpeGVkX2J5X2tlcm5lbF9jb21taXQgWFhYWFhYWFhYWFhYIFwNCj4gKwkiYnRyZnM6IHpvbmVk
OiByZXR1cm4gRUlPIG9uIFJBSUQxIGJsb2NrIGdyb3VwIHdyaXRlIHBvaW50ZXIgbWlzbWF0Y2gi
DQo+ICsNCj4gK19yZXF1aXJlX3NjcmF0Y2hfZGV2X3Bvb2wgMg0KPiArZGVjbGFyZSAtYSBkZXZz
PSIoICRTQ1JBVENIX0RFVl9QT09MICkiDQo+ICtfcmVxdWlyZV96b25lZF9kZXZpY2UgJHtkZXZz
WzBdfQ0KPiArX3JlcXVpcmVfem9uZWRfZGV2aWNlICR7ZGV2c1sxXX0NCj4gK19yZXF1aXJlX2Nv
bW1hbmQgIiRCTEtaT05FX1BST0ciIGJsa3pvbmUNCj4gKw0KPiArX3NjcmF0Y2hfbWtmcyA+PiAk
c2VxcmVzLmZ1bGwgMj4mMSB8fCBfZmFpbCAibWtmcyBmYWlsZWQiDQo+ICtfc2NyYXRjaF9tb3Vu
dA0KPiArDQo+ICsjIFdyaXRlIHNvbWUgZGF0YSB0byB0aGUgRlMgdG8gZGlydHkgaXQNCj4gKyRY
RlNfSU9fUFJPRyAtZmMgInB3cml0ZSAwIDEyOE0iICRTQ1JBVENIX01OVC90ZXN0IHwgX2ZpbHRl
cl94ZnNfaW8NCj4gKw0KPiArIyBBZGQgZGV2aWNlIHR3byB0byB0aGUgRlMNCj4gKyRCVFJGU19V
VElMX1BST0cgZGV2aWNlIGFkZCAke2RldnNbMV19ICRTQ1JBVENIX01OVCA+PiAkc2VxcmVzLmZ1
bGwNCj4gKw0KPiArIyBNb3ZlIHdyaXRlIHBvaW50ZXJzIG9mIGFsbCBlbXB0eSB6b25lcyBieSA0
ayB0byBzaW11bGF0ZSB3cml0ZSBwb2ludGVyDQo+ICsjIG1pc21hdGNoLg0KPiArem9uZXM9JCgk
QkxLWk9ORV9QUk9HIHJlcG9ydCAke2RldnNbMV19IHwgJEFXS19QUk9HICcvZW0vIHsgcHJpbnQg
JDIgfScgfFwNCj4gKwlzZWQgJ3MvLC8vJykNCj4gK2ZvciB6b25lIGluICR6b25lczsNCj4gK2Rv
DQo+ICsJIyBXZSBoYXZlIHRvIGlnbm9yZSB0aGUgb3V0cHV0IGhlcmUsIGFzIGEpIHdlIGRvbid0
IGtub3cgdGhlIG51bWJlciBvZg0KPiArCSMgem9uZXMgdGhhdCBoYXZlIGRpcnRpZWQgYW5kIGIp
IGlmIHdlIHJ1biBvdmVyIHRoZSBtYXhpbWFsIG51bWJlciBvZg0KPiArCSMgYWN0aXZlIHpvbmVz
LCB4ZnNfaW8gd2lsbCBvdXRwdXQgZXJyb3JzLCBib3RoIHdlIGRvbid0IGNhcmUuDQo+ICsJJFhG
U19JT19QUk9HIC1mZGMgInB3cml0ZSAkKCgkem9uZSA8PCA5KSkgNDA5NiIgJHtkZXZzWzFdfSA+
IC9kZXYvbnVsbCAyPiYxDQo+ICtkb25lDQo+ICsNCj4gKyMgZXhwZWN0ZWQgdG8gZmFpbA0KPiAr
JEJUUkZTX1VUSUxfUFJPRyBiYWxhbmNlIHN0YXJ0IC1tY29udmVydD1yYWlkMSAkU0NSQVRDSF9N
TlQgPj4gJHNlcXJlcy5mdWxsDQo+ICsNCj4gK19zY3JhdGNoX3VubW91bnQNCj4gKw0KPiArJE1P
VU5UX1BST0cgLXQgYnRyZnMgLW9kZWdyYWRlZCAke2RldnNbMF19ICRTQ1JBVENIX01OVA0KPiAr
DQo+ICskQlRSRlNfVVRJTF9QUk9HIGRldmljZSByZW1vdmUgLS1mb3JjZSBtaXNzaW5nICRTQ1JB
VENIX01OVCA+PiAkc2VxcmVzLmZ1bGwNCj4gKyRCVFJGU19VVElMX1BST0cgYmFsYW5jZSBzdGFy
dCAtLWZ1bGwtYmFsYW5jZSAkU0NSQVRDSF9NTlQgPj4gJHNlcXJlcy5mdWxsDQo+ICsNCj4gKyMg
Q2hlY2sgdGhhdCBib3RoIFN5c3RlbSBhbmQgTWV0YWRhdGEgYXJlIGJhY2sgdG8gdGhlIERVUCBw
cm9maWxlDQo+ICskQlRSRlNfVVRJTF9QUk9HIGZpbGVzeXN0ZW0gZGYgJFNDUkFUQ0hfTU5UIHxc
DQo+ICsJZ3JlcCAtbyAtZSAiU3lzdGVtLCBEVVAiIC1lICJNZXRhZGF0YSwgRFVQIg0KPiArDQo+
ICtzdGF0dXM9MA0KPiArZXhpdA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvYnRyZnMvMzI5Lm91dCBi
L3Rlc3RzL2J0cmZzLzMyOS5vdXQNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAw
MDAwMDAwMDAwLi5iNTJiN2Q5MGQyNTMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy9i
dHJmcy8zMjkub3V0DQo+IEBAIC0wLDAgKzEsNyBAQA0KPiArUUEgb3V0cHV0IGNyZWF0ZWQgYnkg
MzI5DQo+ICt3cm90ZSAxMzQyMTc3MjgvMTM0MjE3NzI4IGJ5dGVzIGF0IG9mZnNldCAwDQo+ICtY
WFggQnl0ZXMsIFggb3BzOyBYWDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMp
DQo+ICtFUlJPUjogZXJyb3IgZHVyaW5nIGJhbGFuY2luZyAnL21udC9zY3JhdGNoJzogSW5wdXQv
b3V0cHV0IGVycm9yDQoNCg0KQXJncywgdGhhdCBuZWVkcyB0byBiZSBmaWx0ZXJlZCBhcyB3ZWxs
LiBTYXcgaXQgdG9vIGxhdGUgc29ycnkuDQoNCj4gK1RoZXJlIG1heSBiZSBtb3JlIGluZm8gaW4g
c3lzbG9nIC0gdHJ5IGRtZXNnIHwgdGFpbA0KPiArU3lzdGVtLCBEVVANCj4gK01ldGFkYXRhLCBE
VVANCg0K


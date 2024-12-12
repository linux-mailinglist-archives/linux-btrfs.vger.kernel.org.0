Return-Path: <linux-btrfs+bounces-10307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D34E9EE0C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 09:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B7016215A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFCA13D531;
	Thu, 12 Dec 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kK6cWv5J";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NuAk3tpK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735020B1FF;
	Thu, 12 Dec 2024 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990422; cv=fail; b=mLtqi33g1cOyenL3lg8Iq0na6neC4R0FDyOAS2+3FJBniJeFH8EaI77VeHPZqd6nW3o5d0cuoQ/3qezgymyZMv0GTY7fBY18I63l6tylUMdlwaNfEimx/3U1B+lCpSVfMW6PH/tSS8ZOX1fFwjVHA9Pdcp5Ggag4J0ptOKM7P+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990422; c=relaxed/simple;
	bh=MdiWW46lFVfSKvtbPIqrYxIKH6E8TXXS47D5+9a2jJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r3py34yA4idCdzaudDC7sTE+Mzi8VuYitnbWi2Qa5qjs1WUMz8BWckJQ290BZLfGiDvGlYfUcYNKDOi6EmsWJN3HpA0PSa2SaIxu4iGD8+WsoNOlquOXay4DTw2XHJe6pEpB7SizrSO+qN23EdSD08nEqX7O7DmaF+s/96eAhiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kK6cWv5J; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NuAk3tpK; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733990420; x=1765526420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MdiWW46lFVfSKvtbPIqrYxIKH6E8TXXS47D5+9a2jJ4=;
  b=kK6cWv5Jd+aZ4r7M7v9fewjNTjG7elPoBiQakdwQVH2dKasioGt1LDjH
   +8C7RrTek5pXS3jBpRuXgU0eOCjlbZ4u4m91fnMjWXu/armglnbWBepQd
   P11iaGjDacbptd2n6cPKsYqH+y6etWhUIF/GkZmU7geqI9CyN7yJ03xjj
   jLJHyPbO7ZU9dhllKpKKcjZ06Fu/IjC7b053Rhjeu7EbiATshw0UhEYqF
   QOvc/yv9KZI+J2Up6mS64ADeeH975B79lN3CoeMpFCeqIzkhW22L6vK1J
   AJbxBHuMaojeNQAiopBF600V74RkVslDAvR+joo25CPvgzQX7jgpS6Lc7
   w==;
X-CSE-ConnectionGUID: O63sRms5RHm+h8E0+yV6pg==
X-CSE-MsgGUID: SpUe9x1dRNalNd8oeEp08A==
X-IronPort-AV: E=Sophos;i="6.12,227,1728921600"; 
   d="scan'208";a="34787339"
Received: from mail-centralusazlp17011031.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.31])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2024 16:00:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3MZuzvG1MhBzg+qht3MuPBcT/a9rRoIszlbe9Z/PZPxjLP4Sg1BhQ1DuOaGqvSjvenNfdEnsMpxDG5XGwQaz9F5NMQlHJ3FwGHPxz8rtACYe4Ei1gbnW1Oso1M6r1adMlX2c6U1XJ+3vJoqzadzCOjEjIZmXRtHAJJ7iwFvmVScU4gh4uVysS7lhdgrBU6b4kVPzOt5ph85b2WIUvMoYOSj+Yr7dpQI3qRpDZqE5C18rpkkdhaRQJLzUNbQ9F8O8aYw1qjr6nOMqhIzYAcCSZcgBkMU9IrvsxRQBtVLK60ZsRfMuQem2BhXVIDqy7YwHo8OaXIG8CxieF1lEFXtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdiWW46lFVfSKvtbPIqrYxIKH6E8TXXS47D5+9a2jJ4=;
 b=DFoYHLZSWbdhxYy/IJyoywrLk4nHNTb+akNTWT7fRgMgJ/5w29tSsjsH9vMIWZbJYKyxUI5xI8VOop8ooZUNoQIQWvY3ZUOhb5KxpUYFplNOcs9gpZknY1xF2YwWX+S3kPWEkOKbL8FWLVsAI65HjKqFXHfGa/wpGIKh+SEOy+fbkTfyRt6tI/JJal6Q/lk0xrM99LghEfaEly5VLny+oRBK0n+x4Y91NirpIN+JZmwnjTViYDIL+0wg6XQf7Yq3vss1x7LPtBYZhs7otU6kI0TsXFk9bGKDRSTVoU3rMWAekwmIJRqhSgY02la0v4i1T/+7Ctd1tzHh+WFrTiehkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdiWW46lFVfSKvtbPIqrYxIKH6E8TXXS47D5+9a2jJ4=;
 b=NuAk3tpKbUe7AdQTkCUrJPl5AnEBJNgy6MLpsulsZP3h4Z6LtYA8ZrxuhXHWFr7nna207hBQtQHecShOweOmhsbTHOUDDhNyEHXd9NPw1JJWdxqDieLNIyDWdAydV8mbemLPs0QGLtKbLuhvwDfiER/89HHcFjPNYAK6mBsh1Rw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7790.namprd04.prod.outlook.com (2603:10b6:a03:303::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 08:00:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 08:00:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Omar Sandoval <osandov@fb.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
Thread-Topic: [PATCH] btrfs: fix a race in encoded read
Thread-Index: AQHbTGsKZcn7mGCkaEKERxWN6qbNxrLiPuOA
Date: Thu, 12 Dec 2024 08:00:10 +0000
Message-ID: <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
References: <20241212075303.2538880-1-neelx@suse.com>
In-Reply-To: <20241212075303.2538880-1-neelx@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7790:EE_
x-ms-office365-filtering-correlation-id: 6d38eb50-92f8-43c7-b0f2-08dd1a83007e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFFWU04xc2xkb0hHOEx0cTVXaExhRDB4RHppcnFsaUo4ekJPeU10TDRCVjNW?=
 =?utf-8?B?cFE0R212ZDBiNkowQzVMQTJiYkY5UFBqVFNEREdha2liY2E2VEhiZzlKckQw?=
 =?utf-8?B?aDg3TWNhUFl0R2hEbzR3L1NzbGRxSnQyc2RPNHk2QmtNalhaQVd4aHIxWlJR?=
 =?utf-8?B?ajRsQnIwV3d2TG0zZWhxNzd2dHQ0VjUwYXhRa29IZy9tcTI4a3dzV3NyVHo3?=
 =?utf-8?B?dERQRWZuNENtQ3AyR1YyTEkzcWpZT1BROG9Wb00vL2NwdklOZjRKOWE1MEt6?=
 =?utf-8?B?eEsxdUp0L3BqdjViVkVIbXpsb21tL2lVbUNVUzljVitHbjl6djhIcThIMVJp?=
 =?utf-8?B?cTZPTGpodzRMZ1NNdTh6YVRzZmVYWHRPdzZaZlY2emRyV0NZN05EZzh2bmVZ?=
 =?utf-8?B?ajFqUFNmalZzZldHb2FrOGNhdzR0Z1B6S1R2VmFVQ2dsSmFub1dJS0FrUjJa?=
 =?utf-8?B?N3ROMlYyNUdCYjVvaWhiY1FOaElBVGVJQ0NjenFkZjRhOXhxVTMwRE5rYTc5?=
 =?utf-8?B?U1VGa0d0VE5nTUtEcGFJTnI1Q2tTMUFkb2VFeURmL3FaUlRKY3JHYlpFbU51?=
 =?utf-8?B?ZjB1Q1ErdE9yOGYxQ2ZjTUErdjlUdWNab01pbm9aa2szU3JoMGFDUVBydzhX?=
 =?utf-8?B?VXEycjBEc2ladkR3MFlDVmFvVVZlWURnM21mVitQN0hmY2d3QnEwRUE1a0FK?=
 =?utf-8?B?UWVKM1hmSFZ5MjN5MmxqbVJKenl5REY3ZlkwdkdXT0oxeVREYlE2SmVJdHpM?=
 =?utf-8?B?dEpPS0JPb2JrdmxLREdGV29IMWI5U2daM2d4bGJkVndERUlTZWtBeUF5VDBM?=
 =?utf-8?B?OVVaSzA0MlNNNEJKWUd5Q3lEYTZpdEJLYXdEZlFKQnVtTVRCYU1idkJrWjdv?=
 =?utf-8?B?MFFZNkpnaUNLT1ZpZHk3NTRXUFdqcHBMRVBGTnJpMysralRFYzF5bUFJQW53?=
 =?utf-8?B?MHRuMUgvK2V0cVdBaXl4d0kyenMrOTFtZDFkU3g2SVZOYy9oUU9nRmdiS29m?=
 =?utf-8?B?Rk8wZlloanVJYU1EY2p4elZLUjR4NHZkRDFTcjhxNkxWRitzUWVRamFyWjBm?=
 =?utf-8?B?aXk0dEc2YTJSS2wyenN3SG05VnhBek4rcUc4MzdkQno1UlJFQzRvQWpXOVVj?=
 =?utf-8?B?SjNOeFd1MklPUXlQWE9ScWQvTmRJRjdHN2c3aHpSKzd0dVFjck1zSWhyUnhW?=
 =?utf-8?B?YytEbHVCbUk4ZTFpMHkydXdOVkh4RDVta3F1MExkVi9SeGlFWExGMFB5V3Ir?=
 =?utf-8?B?K1Q1dUJ0Q0tDUmtFL1FQek1SVzd3QTJMamk1QmE4U3JvY3BMSWVTSFZaQ3ZZ?=
 =?utf-8?B?Tjl0V2EvV0c1eHNxdkJqYXoxK3hRVjVPQjYyL2VnL0xTNVZ3TnVsMVVHREdw?=
 =?utf-8?B?bU0wRnJWQ2ZKR2lqME9OTGZhVW1salYvTVdHYVhsWUlOUnBhZkFqTEx3eEtT?=
 =?utf-8?B?enN1eklITkJlYk1Tb25wWnhDbGg5RTlPOUZVeWVvNVRyQ1FUY1FyU0puMDhz?=
 =?utf-8?B?UlliMXhTUUwwZTRBdmkyS1Y4NjF6aUZJTUJzc2t3cVNQdHV3RENnVUpGMzRE?=
 =?utf-8?B?YWZrWXNHWkdnWVR0RXJ0WWZVWXFOUWtLb3Q4NTNjV0lSS3V0WmhwZmlYSzVK?=
 =?utf-8?B?VnlIOWFnNEkyMHV1eUlPN2pXdUFIRzdlTFRieU42eERGTzBmaHlEUGp4NmRX?=
 =?utf-8?B?MTgvc0hleUxUb1Q5Yk5JVlkxZU50dUZhK00vVi9mOUxkSFFLcU91Ymx6aUNG?=
 =?utf-8?B?QVNidTJZQnNWRkRTd2FaQXZKV05QK0k1QUJPWk04Uks4UWpTNVdCY2NYVEFW?=
 =?utf-8?B?Nm04Y0lzOWRIWFVuSlo1bC9MTUJKck05RUw3bE1rc1IvZ3JSdFdhSTN1a0Jx?=
 =?utf-8?B?R3d1MmMrdHNjdllpRE0vdDJoVkpXMlFsbnNFWG00eWdEWmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzU0K3pzRUVmaStRTjN6ZGhZTUFuWjlUZVk0UExuWDdHWWVrY0NCVXZmL0Jj?=
 =?utf-8?B?cDVoR3dPdXFva2l4bjNmTEphckRiRHJQUWxYT0F2blV0ZVB1clBkY0RqWjFz?=
 =?utf-8?B?d1lxbGlIeWt2VWJJZjJybk96YTVuQVN4WE80UVJOTCtVQmZGOWhXbGdnVTlZ?=
 =?utf-8?B?ZDhXWEVidkdzbFhJWElvRGJkaDdWVWxESituQW54ZTJ4QXJDMjVwcnNyS29u?=
 =?utf-8?B?MS9QOWJUNXQ1RERGNytXRlRtOFg2NjVQUmhPS29Fa1ZzVTM2UWpWZXNRQjEr?=
 =?utf-8?B?V1oySmFaWGV6Vmxjditaa21laExjeWJhdExJTUcrdGZ3b1d5UWJISVJLTkNP?=
 =?utf-8?B?L0EvRWM5d25BNVM4YWtmYmRiOUx2UXA3KzhWeEhaZ1V4ZXRoMEhxd0ZudWwy?=
 =?utf-8?B?NEd1cFZlMDB3Y2tYN0pvUUNzMjQ0aW5HOFQzWXVMYlhGa25uczJOTGVTbXlL?=
 =?utf-8?B?WldkazNIU2IwcVdlcVpCMXNmaVd2SUpGQjVLTmVTVUwwczJqVmt0cEkra3V0?=
 =?utf-8?B?Y1pmbWVKYmVSbnhJbzliSzI2RDFMRHBNSEhaQXRpa3k0MGlLUDFjcHh2WWF0?=
 =?utf-8?B?d3BsdWQ0aDRlaUhhc21HQ1YwNWU3TFNEaHRhMHNwK2ZRZmNZQ3pzSnh1aDhO?=
 =?utf-8?B?bFJOcnpPYXpZZ3RJTjYxbmN2OEtuUi9XYzY1QjZsZWF5cjVGdmI1T0hMa2Z2?=
 =?utf-8?B?ZGFuVlkyV1FGWTVnbFlSV1h3MzFaT3BSd2FZQ2pueGNWVFBTUmZhZWN6czd2?=
 =?utf-8?B?a0RXd3JuVnB1Qzlub1pSVjhLMXV1QXF2eHUwNG1ZVUkvRDl2dVZOUzQvZGNJ?=
 =?utf-8?B?eFZWMHdNUklDZG9oVUYvSERpMkxFMU45N1JNdHNUY2U3K3l6eG9DVmtFUFhX?=
 =?utf-8?B?NEdHeWFXKzlKOXByZmpYRTNPM0xmMG5oeC9XTVB6OFJPZGNHSXdaK3oxVk1N?=
 =?utf-8?B?TjJJeGFFNU1CTW1VTzFjdHRRNURzbERtd2I2cUVDRE9UNWNhcHJIU3d2QnRI?=
 =?utf-8?B?VzU2V3FZRWZNK3NqZWxJOHRTR3lPQTl5M3duOSs4T1lYWjlqTjNNNnhwUEs3?=
 =?utf-8?B?OHNuSmZBVHNiM3htdzZmRVJoOFBPRVFxWWlLQ3VIMVJ0OFlEOUczVll4Rmly?=
 =?utf-8?B?WGVha1IxY3ZiOTdTRUFRdTlVbks5Q3NXQkphdWtxRTdjSDUycGUrRFdDZjdm?=
 =?utf-8?B?U1dJMDh6Z0U4VVBTNHAxb29WQVAzaldvWWlOSGxNbXhNdU4vL2tHazloVzUv?=
 =?utf-8?B?ZUlPY29mQXl1MFJ5d0E5Um9vT09mWXJ1NFBBRkR6N2Z0WG9yZ04rUEtOTXQx?=
 =?utf-8?B?enhucml4SlozZVhBUkNscVN5NFVqOEtYakxOVi9sdEt6QmEvNVBoaStjOFkv?=
 =?utf-8?B?ZEJKbk1UREtZRmoxaG9waUp5dVVvNXIxYUdLMkc2Y2tiZmNCQVZYdVduQlBZ?=
 =?utf-8?B?akZsRGd3dGJ0MjFrb1pDU1N0eVp1UXE1bjExVjZYNGJsNlRtQ2ZaaTNhV3VW?=
 =?utf-8?B?U3pXbkd2b0pQT1RxVkl5cTdIQ2dXU3VSY2ZoRzYzNW1PNGFXTVJGR1NDWFAx?=
 =?utf-8?B?dUJpbmd6OWlJVTNMTi9TUWJmNXdRSzF4aFdNQk1KVjkrbVhOTFFoZlBzWXBL?=
 =?utf-8?B?Q1lZOFVVK2VZQU1xZDEvbnkzVVZQS1Fyc1dWdExNMVhnVllGaU9PMitrL3c0?=
 =?utf-8?B?MzduN3NQdXVrUzJiWk1QcFQ1Nyt4RHBjbDdIemlzMEVJRlNGS1YrVkZqNHlu?=
 =?utf-8?B?THE3TUlZZXlHM3llNm1jUTJnZU9YRk1Lb0l1UEIxS3MvcVNZd2NTdFd0azdH?=
 =?utf-8?B?dVhBa2RYL2grYWF0Qk1xU0lCRGorNlZIMjN5bFR0czl2YVhpZGZaczZMTDdo?=
 =?utf-8?B?RVk0a1BrcUM4Mk1xdHRqb29mQ0k3NG03L0hsWWIzS0ZvczNCQWNPMWZzUk53?=
 =?utf-8?B?Q1RTRHpHdlA4UnhUdDUwQWxjeVR3Y2tPUXZTbGJ3VkVXUmw4dnJ2bXY4RWRx?=
 =?utf-8?B?LzdPSnQ4c1g0ZUFKNUVzcUZPTlJ1K0Y0Nkl3WHhVU0FHSkVDZWxKSlNJT3d3?=
 =?utf-8?B?aDF2VGs3N3ZKdTdoLy9MMHJTd1lFeUVncnlyMW50bGROYzl2Rkc0TjdFdmpW?=
 =?utf-8?B?UkJsenVoUXFiR05UODBrd25IRldEejJSODRwa1JrL1ZoN2kwd2RVUnpBV1Qr?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4CD5673013FD04B9FA55DF515112363@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iJtzM7ONlz0yo0LMzTTWQ01fEkARzT8XK/tv1mJd2CU3x7yJmk5O9FtFdcFWMiAgYukr1IvDtH2XEuLY7Iw5sqqIqaw5TuXQPKn65ctzDprbAQHkl6hZw6DR+0KYQljxuhUugxdd+k7GrtSLJEaTmNw+gdMR0meS+dvlF3DHY8Y9bDPBR6FVbsOf3DFWgjzRt/3DfsYahAZ9HH06FihNoAWPBBHAPH+7skcxoyTkUvPVCUJIt/B+qFqZK44/xnwWUYa08NcF+1RWwDp4pnCuv6hM/kgjeegA3ycoxbF14IWnC76tRVpY58e89OLwtzkkgEEYvRaiKaNQGxhfxXX68O91XIHjIfCASR6w6D7VKaJvW0zn/N5yb7Lsy6W8bdpNH0tvaYjTbuAIJVgXO55IldtnmCDrSvBFmwgojHpKSkqmCLHSdHgedvvxeUoubdc5j6gfAA+VzY44kyJJ1njHptPUgjKDIxOf71qCOx1/J5UbHqjveuGhb+RJfsLZtwyfOcGIMXpKYzklpPQT3gtg7Is3IWYBjSKfsE59fMKqoDJeWxbYyWVmZNOW8hEjD79+Bv5vcZSuPzLh1WXHj++nWmcHMIKaYIoWa3PQceeAx6kwyhz2iTHjF1za+F4ZoZup
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d38eb50-92f8-43c7-b0f2-08dd1a83007e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 08:00:10.7454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjIXrAKqOwXXe8RDXkw3TnqEqOd8NfC8ovdVGVVj8zv28dfclThXvT23NkmOQmw7RpO4PjCtF+cK7Z8HZUbT+0PBDouTYXB4xF/yxcG+5H4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7790

T24gMTIuMTIuMjQgMDg6NTQsIERhbmllbCBWYWNlayB3cm90ZToNCj4gV2hpbGUgdGVzdGluZyB0
aGUgZW5jb2RlZCByZWFkIGZlYXR1cmUgdGhlIGZvbGxvd2luZyBjcmFzaCB3YXMgb2JzZXJ2ZWQN
Cj4gYW5kIGl0IGNhbiBiZSByZWxpYWJseSByZXByb2R1Y2VkOg0KPiANCg0KDQpIaSBEYW5pZWws
DQoNClRoaXMgc3VzcGljaW91c2x5IGxvb2tzIGxpa2UgJzA1YjM2YjA0ZDc0YSAoImJ0cmZzOiBm
aXggdXNlLWFmdGVyLWZyZWUgDQppbiBidHJmc19lbmNvZGVkX3JlYWRfZW5kaW8oKSIpJy4gRG8g
eW91IGhhdmUgdGhpcyBwYXRjaCBhcHBsaWVkIHRvIHlvdXIgDQprZXJuZWw/IElJUkMgaXQgd2Vu
dCB1cHN0cmVhbSB3aXRoIDYuMTMtcmMyLg0KDQpCeXRlLA0KCUpvaGFubmVzDQoNCj4gWyAyOTE2
LjQ0MTczMV0gT29wczogZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0LCBwcm9iYWJseSBmb3Igbm9u
LWNhbm9uaWNhbCBhZGRyZXNzIDB4YTNmNjRlMDZkNWVlZTJjNzogMDAwMCBbIzFdIFBSRUVNUFRf
UlQgU01QIE5PUFRJDQo+IFsgMjkxNi40NDE3MzZdIENQVTogNSBVSUQ6IDAgUElEOiA1OTIgQ29t
bToga3dvcmtlci91Mzg6NCBLZHVtcDogbG9hZGVkIE5vdCB0YWludGVkIDYuMTMuMC1yYzErICM0
DQo+IFsgMjkxNi40NDE3MzldIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSAr
IElDSDksIDIwMDkpLCBCSU9TIDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIgMDQvMDEvMjAxNA0KPiBb
IDI5MTYuNDQxNzQwXSBXb3JrcXVldWU6IGJ0cmZzLWVuZGlvIGJ0cmZzX2VuZF9iaW9fd29yayBb
YnRyZnNdDQo+IFsgMjkxNi40NDE3NzddIFJJUDogMDAxMDpfX3dha2VfdXBfY29tbW9uKzB4Mjkv
MHhhMA0KPiBbIDI5MTYuNDQxODA4XSBSU1A6IDAwMTg6ZmZmZmFhZWMwMTI4ZmQ4MCBFRkxBR1M6
IDAwMDEwMjE2DQo+IFsgMjkxNi40NDE4MTBdIFJBWDogMDAwMDAwMDAwMDAwMDAwMSBSQlg6IGZm
ZmY5NWE2NDI5Y2YwMjAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgMjkxNi40NDE4MTFdIFJE
WDogYTNmNjRlMDZkNWVlZTJjNyBSU0k6IDAwMDAwMDAwMDAwMDAwMDMgUkRJOiBmZmZmOTVhNjQy
OWNmMDAwDQo+ICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eXl4NCj4gICAgICAg
ICAgICAgICAgICAgICAgVGhpcyBjb21lcyBmcm9tIGBwcml2LT53YWl0LmhlYWQubmV4dGANCj4g
DQo+IFsgMjkxNi40NDE4MjNdIENhbGwgVHJhY2U6DQo+IFsgMjkxNi40NDE4MzNdICA8VEFTSz4N
Cj4gWyAyOTE2LjQ0MTg4MV0gID8gX193YWtlX3VwX2NvbW1vbisweDI5LzB4YTANCj4gWyAyOTE2
LjQ0MTg4M10gIF9fd2FrZV91cF9jb21tb25fbG9jaysweDM3LzB4NjANCj4gWyAyOTE2LjQ0MTg4
N10gIGJ0cmZzX2VuY29kZWRfcmVhZF9lbmRpbysweDczLzB4OTAgW2J0cmZzXSAgPDw8IFVBRiBv
ZiBgcHJpdmAgb2JqZWN0LA0KPiBbIDI5MTYuNDQxOTIxXSAgYnRyZnNfY2hlY2tfcmVhZF9iaW8r
MHgzMjEvMHg1MDAgW2J0cmZzXSAgICAgICAgZGV0YWlscyBiZWxvdy4NCj4gWyAyOTE2LjQ0MTk0
N10gIHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzKzB4YzEvMHg0MTANCj4gWyAyOTE2LjQ0MTk2MF0g
IHdvcmtlcl90aHJlYWQrMHgxMDUvMHgyNDANCj4gDQo+IGNyYXNoPiBidHJmc19lbmNvZGVkX3Jl
YWRfcHJpdmF0ZS53YWl0LmhlYWQgZmZmZjk1YTY0MjljZjAwMAkjIGBwcml2YCBmcm9tIFJESSBe
Xg0KPiAgICB3YWl0LmhlYWQgPSB7DQo+ICAgICAgbmV4dCA9IDB4YTNmNjRlMDZkNWVlZTJjNywJ
IyBDb3JydXB0ZWQgYXMgdGhlIG9iamVjdCB3YXMgYWxyZWFkeSBmcmVlZC9yZXVzZWQuDQo+ICAg
ICAgcHJldiA9IDB4ZmZmZjk1YTY0MjljZjAyMAkjIFN0YWxlIGRhdGEgc3RpbGwgcG9pbnQgdG8g
aXRzZWxmIChgJnByaXYtPndhaXQuaGVhZGANCj4gICAgfQkJCQkgIGFsc28gaW4gUkJYIF5eKSBp
ZS4gdGhlIGxpc3Qgd2FzIGZyZWUuDQo+IA0KPiBQb3NzaWJseSwgdGhpcyBpcyBlYXNpZXIgKG9y
IGV2ZW4gb25seT8pIHJlcHJvZHVjaWJsZSBvbiBwcmVlbXB0aWJsZSBrZXJuZWwuDQo+IEl0IGp1
c3QgaGFwcGVuZWQgdG8gYnVpbGQgYW4gUlQga2VybmVsIGZvciBhZGRpdGlvbmFsIHRlc3Rpbmcg
Y292ZXJhZ2UuDQo+IEVuYWJsaW5nIHNsYWIgZGVidWcgZ2l2ZXMgdXMgZnVydGhlciByZWxhdGVk
IGRldGFpbHMsIG1vc3RseSBjb25maXJtaW5nDQo+IHdoYXQncyBleHBlY3RlZDoNCj4gDQo+IFsx
MToyMzowN10gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gWzExOjIzOjA3XSBCVUcga21hbGxvYy02
NCAoTm90IHRhaW50ZWQpOiBQb2lzb24gb3ZlcndyaXR0ZW4NCj4gWzExOjIzOjA3XSAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiANCj4gWzExOjIzOjA3XSAweGZmZmY4ZmM3YzViNmI1NDItMHhmZmZm
OGZjN2M1YjZiNTQzIEBvZmZzZXQ9NTQ0Mi4gRmlyc3QgYnl0ZSAweDQgaW5zdGVhZCBvZiAweDZi
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICAgICBUaGF0IG1ha2VzIHR3
byBieXRlcyBpbnRvIHRoZSBgcHJpdi0+d2FpdC5sb2NrYA0KPiANCj4gWzExOjIzOjA3XSBGSVgg
a21hbGxvYy02NDogUmVzdG9yaW5nIFBvaXNvbiAweGZmZmY4ZmM3YzViNmI1NDItMHhmZmZmOGZj
N2M1YjZiNTQzPTB4NmINCj4gWzExOjIzOjA3XSBBbGxvY2F0ZWQgaW4gYnRyZnNfZW5jb2RlZF9y
ZWFkX3JlZ3VsYXJfZmlsbF9wYWdlcysweDVlLzB4MjYwIFtidHJmc10gYWdlPTQgY3B1PTAgcGlk
PTE4Mjk1DQo+IFsxMToyMzowN10gIF9fa21hbGxvY19jYWNoZV9ub3Byb2YrMHg4MS8weDJhMA0K
PiBbMTE6MjM6MDddICBidHJmc19lbmNvZGVkX3JlYWRfcmVndWxhcl9maWxsX3BhZ2VzKzB4NWUv
MHgyNjAgW2J0cmZzXQ0KPiBbMTE6MjM6MDddICBidHJmc19lbmNvZGVkX3JlYWRfcmVndWxhcisw
eGVlLzB4MjAwIFtidHJmc10NCj4gWzExOjIzOjA3XSAgYnRyZnNfaW9jdGxfZW5jb2RlZF9yZWFk
KzB4NDc3LzB4NjAwIFtidHJmc10NCj4gWzExOjIzOjA3XSAgYnRyZnNfaW9jdGwrMHhlZmUvMHgy
YTAwIFtidHJmc10NCj4gWzExOjIzOjA3XSAgX194NjRfc3lzX2lvY3RsKzB4YTMvMHhjMA0KPiBb
MTE6MjM6MDddICBkb19zeXNjYWxsXzY0KzB4NzQvMHgxODANCj4gWzExOjIzOjA3XSAgZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzYvMHg3ZQ0KPiANCj4gICAgOTEyMSAgCXVuc2ln
bmVkIGxvbmcgaSA9IDA7DQo+ICAgIDkxMjIgIAlzdHJ1Y3QgYnRyZnNfYmlvICpiYmlvOw0KPiAg
ICA5MTIzICAJaW50IHJldDsNCj4gICAgOTEyNA0KPiAqIDkxMjUgIAlwcml2ID0ga21hbGxvYyhz
aXplb2Yoc3RydWN0IGJ0cmZzX2VuY29kZWRfcmVhZF9wcml2YXRlKSwgR0ZQX05PRlMpOw0KPiAg
ICA5MTI2ICAJaWYgKCFwcml2KQ0KPiAgICA5MTI3ICAJCXJldHVybiAtRU5PTUVNOw0KPiAgICA5
MTI4DQo+ICAgIDkxMjkgIAlpbml0X3dhaXRxdWV1ZV9oZWFkKCZwcml2LT53YWl0KTsNCj4gDQo+
IFsxMToyMzowN10gRnJlZWQgaW4gYnRyZnNfZW5jb2RlZF9yZWFkX3JlZ3VsYXJfZmlsbF9wYWdl
cysweDFmOS8weDI2MCBbYnRyZnNdIGFnZT00IGNwdT0wIHBpZD0xODI5NQ0KPiBbMTE6MjM6MDdd
ICBidHJmc19lbmNvZGVkX3JlYWRfcmVndWxhcl9maWxsX3BhZ2VzKzB4MWY5LzB4MjYwIFtidHJm
c10NCj4gWzExOjIzOjA3XSAgYnRyZnNfZW5jb2RlZF9yZWFkX3JlZ3VsYXIrMHhlZS8weDIwMCBb
YnRyZnNdDQo+IFsxMToyMzowN10gIGJ0cmZzX2lvY3RsX2VuY29kZWRfcmVhZCsweDQ3Ny8weDYw
MCBbYnRyZnNdDQo+IFsxMToyMzowN10gIGJ0cmZzX2lvY3RsKzB4ZWZlLzB4MmEwMCBbYnRyZnNd
DQo+IFsxMToyMzowN10gIF9feDY0X3N5c19pb2N0bCsweGEzLzB4YzANCj4gWzExOjIzOjA3XSAg
ZG9fc3lzY2FsbF82NCsweDc0LzB4MTgwDQo+IFsxMToyMzowN10gIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4gDQo+ICAgIDkxNzEgIAkJaWYgKGF0b21pY19kZWNf
cmV0dXJuKCZwcml2LT5wZW5kaW5nKSAhPSAwKQ0KPiAgICA5MTcyICAJCQlpb193YWl0X2V2ZW50
KHByaXYtPndhaXQsICFhdG9taWNfcmVhZCgmcHJpdi0+cGVuZGluZykpOw0KPiAgICA5MTczICAJ
CS8qIFNlZSBidHJmc19lbmNvZGVkX3JlYWRfZW5kaW8oKSBmb3Igb3JkZXJpbmcuICovDQo+ICAg
IDkxNzQgIAkJcmV0ID0gYmxrX3N0YXR1c190b19lcnJubyhSRUFEX09OQ0UocHJpdi0+c3RhdHVz
KSk7DQo+ICogOTE3NSAgCQlrZnJlZShwcml2KTsNCj4gICAgOTE3NiAgCQlyZXR1cm4gcmV0Ow0K
PiAgICA5MTc3ICAJfQ0KPiAgICA5MTc4ICB9DQo+IA0KPiBgcHJpdmAgd2FzIGZyZWVkIGhlcmUg
YnV0IHRoZW4gYWZ0ZXIgdGhhdCBpdCB3YXMgZnVydGhlciB1c2VkLiBUaGUgcmVwb3J0DQo+IGlz
IGNvbW1pbmcgc29vbiBhZnRlciwgc2VlIGJlbG93LiBOb3RlIHRoYXQgdGhlIHJlcG9ydCBpcyBh
IGZldyBzZWNvbmRzDQo+IGRlbGF5ZWQgYnkgdGhlIFJDVSBzdGFsbCB0aW1lb3V0LiAoSXQgaXMg
dGhlIHNhbWUgZXhhbXBsZSBhcyB3aXRoIHRoZQ0KPiBHUEYgY3Jhc2ggYWJvdmUsIGp1c3QgdGhh
dCBvbmUgd2FzIHJlcG9ydGVkIHJpZ2h0IGF3YXkgd2l0aG91dCBhbnkgZGVsYXkpLg0KPiANCj4g
RHVlIHRvIHRoZSBwb2lzb24gdGhpcyB0aW1lIGluc3RlYWQgb2YgdGhlIEdQRiBleGNlcHRpb24g
YXMgb2JzZXJ2ZWQgYWJvdmUNCj4gdGhlIFVBRiBjYXVzZWQgYSBDUFUgaGFyZCBsb2NrdXAgKHJl
cG9ydGVkIGJ5IHRoZSBSQ1Ugc3RhbGwgY2hlY2sgYXMgdGhpcw0KPiB3YXMgYSBWTSk6DQo+IA0K
PiBbMTE6MjM6MjhdIHJjdTogSU5GTzogcmN1X3ByZWVtcHQgZGV0ZWN0ZWQgc3RhbGxzIG9uIENQ
VXMvdGFza3M6DQo+IFsxMToyMzoyOF0gcmN1OiAgICAgICAgIDAtLi4uITogKDEgR1BzIGJlaGlu
ZCkgaWRsZT00OGI0LzEvMHg0MDAwMDAwMDAwMDAwMDAwIHNvZnRpcnE9MC8wIGZxcz01IHJjdWM9
NTI1NCBqaWZmaWVzKHN0YXJ2ZWQpDQo+IFsxMToyMzoyOF0gcmN1OiAgICAgICAgIChkZXRlY3Rl
ZCBieSAxLCB0PTUyNTIgamlmZmllcywgZz0xNjMxMjQxLCBxPTI1MDA1NCBuY3B1cz04KQ0KPiBb
MTE6MjM6MjhdIFNlbmRpbmcgTk1JIGZyb20gQ1BVIDEgdG8gQ1BVcyAwOg0KPiBbMTE6MjM6Mjhd
IE5NSSBiYWNrdHJhY2UgZm9yIGNwdSAwDQo+IFsxMToyMzoyOF0gQ1BVOiAwIFVJRDogMCBQSUQ6
IDIxNDQ1IENvbW06IGt3b3JrZXIvdTMzOjMgS2R1bXA6IGxvYWRlZCBUYWludGVkOiBHICAgIEIg
ICAgICAgICAgICAgIDYuMTMuMC1yYzErICM0DQo+IFsxMToyMzoyOF0gVGFpbnRlZDogW0JdPUJB
RF9QQUdFDQo+IFsxMToyMzoyOF0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1
ICsgSUNIOSwgMjAwOSksIEJJT1MgMS4xNi4zLWRlYmlhbi0xLjE2LjMtMiAwNC8wMS8yMDE0DQo+
IFsxMToyMzoyOF0gV29ya3F1ZXVlOiBidHJmcy1lbmRpbyBidHJmc19lbmRfYmlvX3dvcmsgW2J0
cmZzXQ0KPiBbMTE6MjM6MjhdIFJJUDogMDAxMDpuYXRpdmVfaGFsdCsweGEvMHgxMA0KPiBbMTE6
MjM6MjhdIFJTUDogMDAxODpmZmZmYjQyZWMyNzdiYzQ4IEVGTEFHUzogMDAwMDAwNDYNCj4gWzEx
OjIzOjI4XSBDYWxsIFRyYWNlOg0KPiBbMTE6MjM6MjhdICA8VEFTSz4NCj4gWzExOjIzOjI4XSAg
a3ZtX3dhaXQrMHg1My8weDYwDQo+IFsxMToyMzoyOF0gIF9fcHZfcXVldWVkX3NwaW5fbG9ja19z
bG93cGF0aCsweDJlYS8weDM1MA0KPiBbMTE6MjM6MjhdICBfcmF3X3NwaW5fbG9ja19pcnErMHgy
Yi8weDQwDQo+IFsxMToyMzoyOF0gIHJ0bG9ja19zbG93bG9ja19sb2NrZWQrMHgxZjMvMHhjZTAN
Cj4gWzExOjIzOjI4XSAgcnRfc3Bpbl9sb2NrKzB4N2IvMHhiMA0KPiBbMTE6MjM6MjhdICBfX3dh
a2VfdXBfY29tbW9uX2xvY2srMHgyMy8weDYwDQo+IFsxMToyMzoyOF0gIGJ0cmZzX2VuY29kZWRf
cmVhZF9lbmRpbysweDczLzB4OTAgW2J0cmZzXSAgPDw8IFVBRiBvZiBgcHJpdmAgb2JqZWN0Lg0K
PiBbMTE6MjM6MjhdICBidHJmc19jaGVja19yZWFkX2JpbysweDMyMS8weDUwMCBbYnRyZnNdDQo+
IFsxMToyMzoyOF0gIHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzKzB4YzEvMHg0MTANCj4gWzExOjIz
OjI4XSAgd29ya2VyX3RocmVhZCsweDEwNS8weDI0MA0KPiANCj4gICAgOTEwNSAgCQlpZiAocHJp
di0+dXJpbmdfY3R4KSB7DQo+ICAgIDkxMDYgIAkJCWludCBlcnIgPSBibGtfc3RhdHVzX3RvX2Vy
cm5vKFJFQURfT05DRShwcml2LT5zdGF0dXMpKTsNCj4gICAgOTEwNyAgCQkJYnRyZnNfdXJpbmdf
cmVhZF9leHRlbnRfZW5kaW8ocHJpdi0+dXJpbmdfY3R4LCBlcnIpOw0KPiAgICA5MTA4ICAJCQlr
ZnJlZShwcml2KTsNCj4gICAgOTEwOSAgCQl9IGVsc2Ugew0KPiAqIDkxMTAgIAkJCXdha2VfdXAo
JnByaXYtPndhaXQpOwk8PDwgU28gd2Uga25vdyBVQUYvR1BGIGhhcHBlbnMgaGVyZS4NCj4gICAg
OTExMSAgCQl9DQo+ICAgIDkxMTIgIAl9DQo+ICAgIDkxMTMgIAliaW9fcHV0KCZiYmlvLT5iaW8p
Ow0KPiANCj4gTm93LCB0aGUgd2FpdCBxdWV1ZSBoZXJlIGRvZXMgbm90IHJlYWxseSBndWFyYW50
ZWUgYSBwcm9wZXINCj4gc3luY2hyb25pemF0aW9uIGJldHdlZW4gYGJ0cmZzX2VuY29kZWRfcmVh
ZF9yZWd1bGFyX2ZpbGxfcGFnZXMoKWANCj4gYW5kIGBidHJmc19lbmNvZGVkX3JlYWRfZW5kaW8o
KWAgd2hpY2ggZXZlbnR1YWxseSByZXN1bHRzIGluIHZhcmlvdXMNCj4gdXNlLWFmZXItZnJlZSBl
ZmZlY3RzIGxpa2UgZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0IG9yIENQVSBoYXJkIGxvY2t1cC4N
Cj4gDQo+IFVzaW5nIHBsYWluIHdhaXQgcXVldWUgd2l0aG91dCBhZGRpdGlvbmFsIGluc3RydW1l
bnRhdGlvbiBvbiB0b3Agb2YgdGhlDQo+IGBwZW5kaW5nYCBjb3VudGVyIGlzIHNpbXBseSBpbnN1
ZmZpY2llbnQgaW4gdGhpcyBjb250ZXh0LiBUaGUgcmVhc29uIHdhaXQNCj4gcXVldWUgZmFpbHMg
aGVyZSBpcyBiZWNhdXNlIHRoZSBsaWZlc3BhbiBvZiB0aGF0IHN0cnVjdHVyZSBpcyBvbmx5IHdp
dGhpbg0KPiB0aGUgYGJ0cmZzX2VuY29kZWRfcmVhZF9yZWd1bGFyX2ZpbGxfcGFnZXMoKWAgZnVu
Y3Rpb24uIEluIHN1Y2ggYSBjYXNlDQo+IHBsYWluIHdhaXQgcXVldWUgY2Fubm90IGJlIHVzZWQg
dG8gc3luY2hyb25pemUgZm9yIGl0J3Mgb3duIGRlc3RydWN0aW9uLg0KPiANCj4gRml4IHRoaXMg
YnkgY29ycmVjdGx5IHVzaW5nIGNvbXBsZXRpb24gaW5zdGVhZC4NCj4gDQo+IEFsc28sIHdoaWxl
IHRoZSBsaWZlc3BhbiBvZiB0aGUgc3RydWN0dXJlcyBpbiBzeW5jIGNhc2UgaXMgc3RyaWN0bHkN
Cj4gbGltaXRlZCB3aXRoaW4gdGhlIGAuLi5fZmlsbF9wYWdlcygpYCBmdW5jdGlvbiwgdGhlcmUg
aXMgbm8gbmVlZCB0bw0KPiBhbGxvY2F0ZSBmcm9tIHNsYWIuIFN0YWNrIGNhbiBiZSBzYWZlbHkg
dXNlZCBpbnN0ZWFkLg0KPiANCj4gRml4ZXM6IDE4ODFmYmE4OWJkNSAoImJ0cmZzOiBhZGQgQlRS
RlNfSU9DX0VOQ09ERURfUkVBRCBpb2N0bCIpDQo+IENDOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ICMgNS4xOCsNCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFZhY2VrIDxuZWVseEBzdXNlLmNvbT4N
Cj4gLS0tDQo+ICAgZnMvYnRyZnMvaW5vZGUuYyB8IDYyICsrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRp
b25zKCspLCAyOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9pbm9k
ZS5jIGIvZnMvYnRyZnMvaW5vZGUuYw0KPiBpbmRleCBmYTY0OGFiNmZlODA2Li42MWUwZmQ1YzZh
MTVmIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9pbm9kZS5jDQo+ICsrKyBiL2ZzL2J0cmZzL2lu
b2RlLmMNCj4gQEAgLTkwNzgsNyArOTA3OCw3IEBAIHN0YXRpYyBzc2l6ZV90IGJ0cmZzX2VuY29k
ZWRfcmVhZF9pbmxpbmUoDQo+ICAgfQ0KPiAgIA0KPiAgIHN0cnVjdCBidHJmc19lbmNvZGVkX3Jl
YWRfcHJpdmF0ZSB7DQo+IC0Jd2FpdF9xdWV1ZV9oZWFkX3Qgd2FpdDsNCj4gKwlzdHJ1Y3QgY29t
cGxldGlvbiAqc3luY19yZWFkOw0KPiAgIAl2b2lkICp1cmluZ19jdHg7DQo+ICAgCWF0b21pY190
IHBlbmRpbmc7DQo+ICAgCWJsa19zdGF0dXNfdCBzdGF0dXM7DQo+IEBAIC05MDkwLDIzICs5MDkw
LDIyIEBAIHN0YXRpYyB2b2lkIGJ0cmZzX2VuY29kZWRfcmVhZF9lbmRpbyhzdHJ1Y3QgYnRyZnNf
YmlvICpiYmlvKQ0KPiAgIA0KPiAgIAlpZiAoYmJpby0+YmlvLmJpX3N0YXR1cykgew0KPiAgIAkJ
LyoNCj4gLQkJICogVGhlIG1lbW9yeSBiYXJyaWVyIGltcGxpZWQgYnkgdGhlIGF0b21pY19kZWNf
cmV0dXJuKCkgaGVyZQ0KPiAtCQkgKiBwYWlycyB3aXRoIHRoZSBtZW1vcnkgYmFycmllciBpbXBs
aWVkIGJ5IHRoZQ0KPiAtCQkgKiBhdG9taWNfZGVjX3JldHVybigpIG9yIGlvX3dhaXRfZXZlbnQo
KSBpbg0KPiAtCQkgKiBidHJmc19lbmNvZGVkX3JlYWRfcmVndWxhcl9maWxsX3BhZ2VzKCkgdG8g
ZW5zdXJlIHRoYXQgdGhpcw0KPiAtCQkgKiB3cml0ZSBpcyBvYnNlcnZlZCBiZWZvcmUgdGhlIGxv
YWQgb2Ygc3RhdHVzIGluDQo+IC0JCSAqIGJ0cmZzX2VuY29kZWRfcmVhZF9yZWd1bGFyX2ZpbGxf
cGFnZXMoKS4NCj4gKwkJICogVGhlIG1lbW9yeSBiYXJyaWVyIGltcGxpZWQgYnkgdGhlDQo+ICsJ
CSAqIGF0b21pY19kZWNfYW5kX3Rlc3QoKSBoZXJlIHBhaXJzIHdpdGggdGhlIG1lbW9yeQ0KPiAr
CQkgKiBiYXJyaWVyIGltcGxpZWQgYnkgdGhlIGF0b21pY19kZWNfYW5kX3Rlc3QoKSBpbg0KPiAr
CQkgKiBidHJmc19lbmNvZGVkX3JlYWRfcmVndWxhcl9maWxsX3BhZ2VzKCkgdG8gZW5zdXJlDQo+
ICsJCSAqIHRoYXQgdGhpcyB3cml0ZSBpcyBvYnNlcnZlZCBiZWZvcmUgdGhlIGxvYWQgb2YNCj4g
KwkJICogc3RhdHVzIGluIGJ0cmZzX2VuY29kZWRfcmVhZF9yZWd1bGFyX2ZpbGxfcGFnZXMoKS4N
Cj4gICAJCSAqLw0KPiAgIAkJV1JJVEVfT05DRShwcml2LT5zdGF0dXMsIGJiaW8tPmJpby5iaV9z
dGF0dXMpOw0KPiAgIAl9DQo+ICAgCWlmIChhdG9taWNfZGVjX2FuZF90ZXN0KCZwcml2LT5wZW5k
aW5nKSkgew0KPiAtCQlpbnQgZXJyID0gYmxrX3N0YXR1c190b19lcnJubyhSRUFEX09OQ0UocHJp
di0+c3RhdHVzKSk7DQo+IC0NCj4gICAJCWlmIChwcml2LT51cmluZ19jdHgpIHsNCj4gKwkJCWlu
dCBlcnIgPSBibGtfc3RhdHVzX3RvX2Vycm5vKFJFQURfT05DRShwcml2LT5zdGF0dXMpKTsNCj4g
ICAJCQlidHJmc191cmluZ19yZWFkX2V4dGVudF9lbmRpbyhwcml2LT51cmluZ19jdHgsIGVycik7
DQo+ICAgCQkJa2ZyZWUocHJpdik7DQo+ICAgCQl9IGVsc2Ugew0KPiAtCQkJd2FrZV91cCgmcHJp
di0+d2FpdCk7DQo+ICsJCQljb21wbGV0ZShwcml2LT5zeW5jX3JlYWQpOw0KPiAgIAkJfQ0KPiAg
IAl9DQo+ICAgCWJpb19wdXQoJmJiaW8tPmJpbyk7DQo+IEBAIC05MTE3LDE2ICs5MTE2LDIxIEBA
IGludCBidHJmc19lbmNvZGVkX3JlYWRfcmVndWxhcl9maWxsX3BhZ2VzKHN0cnVjdCBidHJmc19p
bm9kZSAqaW5vZGUsDQo+ICAgCQkJCQkgIHN0cnVjdCBwYWdlICoqcGFnZXMsIHZvaWQgKnVyaW5n
X2N0eCkNCj4gICB7DQo+ICAgCXN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gaW5vZGUt
PnJvb3QtPmZzX2luZm87DQo+IC0Jc3RydWN0IGJ0cmZzX2VuY29kZWRfcmVhZF9wcml2YXRlICpw
cml2Ow0KPiArCXN0cnVjdCBjb21wbGV0aW9uIHN5bmNfcmVhZDsNCj4gKwlzdHJ1Y3QgYnRyZnNf
ZW5jb2RlZF9yZWFkX3ByaXZhdGUgc3luY19wcml2LCAqcHJpdjsNCj4gICAJdW5zaWduZWQgbG9u
ZyBpID0gMDsNCj4gICAJc3RydWN0IGJ0cmZzX2JpbyAqYmJpbzsNCj4gLQlpbnQgcmV0Ow0KPiAg
IA0KPiAtCXByaXYgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgYnRyZnNfZW5jb2RlZF9yZWFkX3By
aXZhdGUpLCBHRlBfTk9GUyk7DQo+IC0JaWYgKCFwcml2KQ0KPiAtCQlyZXR1cm4gLUVOT01FTTsN
Cj4gKwlpZiAodXJpbmdfY3R4KSB7DQo+ICsJCXByaXYgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3Qg
YnRyZnNfZW5jb2RlZF9yZWFkX3ByaXZhdGUpLCBHRlBfTk9GUyk7DQo+ICsJCWlmICghcHJpdikN
Cj4gKwkJCXJldHVybiAtRU5PTUVNOw0KPiArCX0gZWxzZSB7DQo+ICsJCXByaXYgPSAmc3luY19w
cml2Ow0KPiArCQlpbml0X2NvbXBsZXRpb24oJnN5bmNfcmVhZCk7DQo+ICsJCXByaXYtPnN5bmNf
cmVhZCA9ICZzeW5jX3JlYWQ7DQo+ICsJfQ0KPiAgIA0KPiAtCWluaXRfd2FpdHF1ZXVlX2hlYWQo
JnByaXYtPndhaXQpOw0KPiAgIAlhdG9taWNfc2V0KCZwcml2LT5wZW5kaW5nLCAxKTsNCj4gICAJ
cHJpdi0+c3RhdHVzID0gMDsNCj4gICAJcHJpdi0+dXJpbmdfY3R4ID0gdXJpbmdfY3R4Ow0KPiBA
QCAtOTE1OCwyMyArOTE2MiwyMyBAQCBpbnQgYnRyZnNfZW5jb2RlZF9yZWFkX3JlZ3VsYXJfZmls
bF9wYWdlcyhzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLA0KPiAgIAlhdG9taWNfaW5jKCZwcml2
LT5wZW5kaW5nKTsNCj4gICAJYnRyZnNfc3VibWl0X2JiaW8oYmJpbywgMCk7DQo+ICAgDQo+IC0J
aWYgKHVyaW5nX2N0eCkgew0KPiAtCQlpZiAoYXRvbWljX2RlY19yZXR1cm4oJnByaXYtPnBlbmRp
bmcpID09IDApIHsNCj4gLQkJCXJldCA9IGJsa19zdGF0dXNfdG9fZXJybm8oUkVBRF9PTkNFKHBy
aXYtPnN0YXR1cykpOw0KPiAtCQkJYnRyZnNfdXJpbmdfcmVhZF9leHRlbnRfZW5kaW8odXJpbmdf
Y3R4LCByZXQpOw0KPiArCWlmIChhdG9taWNfZGVjX2FuZF90ZXN0KCZwcml2LT5wZW5kaW5nKSkg
ew0KPiArCQlpZiAodXJpbmdfY3R4KSB7DQo+ICsJCQlpbnQgZXJyID0gYmxrX3N0YXR1c190b19l
cnJubyhSRUFEX09OQ0UocHJpdi0+c3RhdHVzKSk7DQo+ICsJCQlidHJmc191cmluZ19yZWFkX2V4
dGVudF9lbmRpbyh1cmluZ19jdHgsIGVycik7DQo+ICAgCQkJa2ZyZWUocHJpdik7DQo+IC0JCQly
ZXR1cm4gcmV0Ow0KPiArCQkJcmV0dXJuIGVycjsNCj4gKwkJfSBlbHNlIHsNCj4gKwkJCWNvbXBs
ZXRlKCZzeW5jX3JlYWQpOw0KPiAgIAkJfQ0KPiArCX0NCj4gICANCj4gKwlpZiAodXJpbmdfY3R4
KQ0KPiAgIAkJcmV0dXJuIC1FSU9DQlFVRVVFRDsNCj4gLQl9IGVsc2Ugew0KPiAtCQlpZiAoYXRv
bWljX2RlY19yZXR1cm4oJnByaXYtPnBlbmRpbmcpICE9IDApDQo+IC0JCQlpb193YWl0X2V2ZW50
KHByaXYtPndhaXQsICFhdG9taWNfcmVhZCgmcHJpdi0+cGVuZGluZykpOw0KPiAtCQkvKiBTZWUg
YnRyZnNfZW5jb2RlZF9yZWFkX2VuZGlvKCkgZm9yIG9yZGVyaW5nLiAqLw0KPiAtCQlyZXQgPSBi
bGtfc3RhdHVzX3RvX2Vycm5vKFJFQURfT05DRShwcml2LT5zdGF0dXMpKTsNCj4gLQkJa2ZyZWUo
cHJpdik7DQo+IC0JCXJldHVybiByZXQ7DQo+IC0JfQ0KPiArDQo+ICsJd2FpdF9mb3JfY29tcGxl
dGlvbl9pbygmc3luY19yZWFkKTsNCj4gKwkvKiBTZWUgYnRyZnNfZW5jb2RlZF9yZWFkX2VuZGlv
KCkgZm9yIG9yZGVyaW5nLiAqLw0KPiArCXJldHVybiBibGtfc3RhdHVzX3RvX2Vycm5vKFJFQURf
T05DRShwcml2LT5zdGF0dXMpKTsNCj4gICB9DQo+ICAgDQo+ICAgc3NpemVfdCBidHJmc19lbmNv
ZGVkX3JlYWRfcmVndWxhcihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqaXRl
ciwNCg0K


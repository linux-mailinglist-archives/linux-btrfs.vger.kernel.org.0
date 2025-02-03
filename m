Return-Path: <linux-btrfs+bounces-11242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4CA25B29
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 14:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863451883340
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274D205AA8;
	Mon,  3 Feb 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JwTXlzWT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CAhYvPYe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F21E87B;
	Mon,  3 Feb 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590049; cv=fail; b=qnm/5LjruPF94gr/acVde8quUSw12Jh6kFpDNBzMVUZi+igizmFCf80tmTXeEVLXScOtzEChbVQFqkE8k45lcHO4EJfK0w28ZXv/Hn1yY1Lb7N5jpwvvxiwziQP0Mxu8K2OmMWC321Nr+i8RvOYRfErMoEVNhjodGaImQxYZqTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590049; c=relaxed/simple;
	bh=VL5+AWN1meu+uERmt8U1Dnj5vu9y3d+8dUWUkjsEfec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fxeuMPoGNJjNc6Jo9daVIKfZJhhA8VC4NbrkZd3Ng+4p0xCOErNG9SNyqp5xYAhgmpdwh3oCAjApA6ddxMZugZhax6qR11TIF+77ETa9QRUojU76ElK57ypKs36adNEnJFYwu/0IelHSREXPB4ihcV0hIJhn4I8RyBT55jR3vuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JwTXlzWT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CAhYvPYe; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738590047; x=1770126047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VL5+AWN1meu+uERmt8U1Dnj5vu9y3d+8dUWUkjsEfec=;
  b=JwTXlzWT2FtrlVzHoJnMuHfTdhCnyaz3Bj4/uY7hm7WFP+XdOiEWOkTH
   Em/R7Tc3UyDw88A7X9ahnXX+NaTlDX/hYP/v5XNUcrjMJ6UDESRhxrjHh
   /8eLEAxd6zvK3gXRCq8K2ctmryuFyFoIZeb+dHOEyXNOBZpgXpRTquyIB
   8FmAvsULLaGWAh42s8lg6zAZCrywGw7Z3nQzlSI6XXyri40vwY2IUE0lt
   8jJ0b6NoniCu5OGACGjnPKHWaNBGoixLJeYo1kHB0qhg7VPU39Aba09JS
   e7jeQCuNL8HllRpxFFL/zu/298MKPzS7tFN7/qb71jEKK+nHZAXqDsm94
   A==;
X-CSE-ConnectionGUID: o0yh55fQRZGQnaFMtngt8g==
X-CSE-MsgGUID: Hu+e45MQR1+L8J0ZNIx0ag==
X-IronPort-AV: E=Sophos;i="6.13,255,1732550400"; 
   d="scan'208";a="36844991"
Received: from mail-southcentralusazlp17011028.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.28])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2025 21:40:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3HLwR0yfv7w8biRpPCWNYw7hUEUIlQ/8OZdqzP1A+X+zeFycLgFH4gMY0IftNEtY7vrXbBdvJBBI/wnTkwp7dJ8PJqfoYmJCPGeUKY77b+pg89DfpqS2Svn33h99TmqC6pqcaBgbQTD9a7glcAdIH3zVd+WKDy8wXU19GZjb6R4N0+ayDZ2ANhskxwxVjNAz7pggqP7BLlhZ9WMinYfYhL/Ua7s+llIbjdV/ZqwELx23DOl7NSTJOeB6VQ1OJPuBrmaCRCtSzey0JA92Fiu5sZN3E+EEVmx3duVD5TJ47PKazuWkPwq61Zm+OyIH1J0DKPmrnMCoGm3fup/MKn06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL5+AWN1meu+uERmt8U1Dnj5vu9y3d+8dUWUkjsEfec=;
 b=R59nHybAKlvr+zCyZOBJiPBpW73it8QfDWDnitLBJTBOBrZagOSv6B+vY3qwweXJMnTc2TQ4kadzKjFK68btz4dfBYDDUKbj9dTS7ZJnvvXbJWhKhnIR6pcZyKE/G/pk/ehLkQprycdn8+TScwmlZpG5EbgUtAXPrfpgzcxHU/TPUnLdHAwlD9A2nZHJaa4+huJfFSI1fLiCna7alhbFQxBLsV/WUcjuizZ30yJ0JorFEqbUEqrgWuZM4fMlTmnS61b8tmeKQ9pobdissd6qRF5oQjLLibosUAKCIrgPxouT08thFF6YcLYCeSTbd7bzn0FVj4GTkJ/Xfa4TwMK/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL5+AWN1meu+uERmt8U1Dnj5vu9y3d+8dUWUkjsEfec=;
 b=CAhYvPYevb/vFdIbA9Z8CNEoZ0IwQcdYVkkCTRAgdSNJtsjAkx/9gu7C505eF6ouyJNESzA883JQ9A965Kkg8APz+9V8FSmO5f5HC1FUaZD2CuFc0ar8oHjsVF3EnkrJubyTnKONkpQjcdFt/AnAnYCE4jc6kzQsqIkpG0DyQBo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7862.namprd04.prod.outlook.com (2603:10b6:8:37::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Mon, 3 Feb
 2025 13:40:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 13:40:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "dsterba@suse.com" <dsterba@suse.com>, "clm@fb.com"
	<clm@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org"
	<kbusch@kernel.org>, hch <hch@lst.de>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC 0/3] Btrfs checksum offload
Thread-Topic: [RFC 0/3] Btrfs checksum offload
Thread-Index: AQHbclgBeWHKAo6I/kGqcNmmsyoZKLMt1wkAgALXZYCAAALFgIAE6FcAgAAEL4A=
Date: Mon, 3 Feb 2025 13:40:37 +0000
Message-ID: <f2ccdba4-86df-49ae-a465-1f8003fc1fb3@wdc.com>
References:
 <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
 <299a886d-c065-4b75-b0be-625710f7348c@wdc.com>
 <572e0418-de26-47ec-b536-b63291acff52@samsung.com>
 <73ba28f4-0588-4ca8-b64f-2a6dd593606b@wdc.com>
 <8e548c8f-7a05-4e82-aed7-6044a0d247c9@samsung.com>
In-Reply-To: <8e548c8f-7a05-4e82-aed7-6044a0d247c9@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7862:EE_
x-ms-office365-filtering-correlation-id: 9c0a94e9-8c14-4632-1078-08dd445857c6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UE83ZTNYd3Q0bTA2WDV6S0tsa3Fpa1U5Slg0RWRoZlJWdzRXK2ZITGdWSHhn?=
 =?utf-8?B?YmNGd3ZPRjZLbzNEK0NsSjJ0YVhoVHBrM3pEeFpSZDlvN3NGL1hYeWFxR2xD?=
 =?utf-8?B?aUtWclF1UVZ2N3dsR2pBVEsxUklFOEZ3dGFyTk1ESGk1bjVDdzk5Y0xvblB0?=
 =?utf-8?B?c2U1eEVUaEhtc21vbGZVS0tYdi9XOXhQelBRWmU0YzRWZEFMQjFxaGJqS2VR?=
 =?utf-8?B?VmVUMlJXMEtLd1F3WkNTLzROQXB4SmtqbGFCaHVvR2ZNang4cGtWSk9CSkJO?=
 =?utf-8?B?SUE4Sm1OdXhWdWNQTVVkZHowcitYUUlhczJEb3R2dG5yY1hmc0QwU1BsTTBa?=
 =?utf-8?B?RGJGVTcvTXA3N3VVWlo5MkVhZUZaKzNmbWZxOXdkQ09yOW40dnoyMFpXRkNR?=
 =?utf-8?B?NGtTVkZGNEptWGx1TXZyM2ZybXB2a0c0dTdldVUrVDRpY09YSnMrdUdKNkFv?=
 =?utf-8?B?eHMycU5qNEl5UG4yWlBZWm1mSCs2bVNoN1kyTUNQWTh1N2t5T1AxQTNlZVdM?=
 =?utf-8?B?RjVBVzBpZTVOWktIaEM0amlYRDk2TzRBdzdNd0xsRlRuQ080WVQ4Z04rRHg2?=
 =?utf-8?B?SjNleW5xQm9GaEpsamZQZ09YUk02azVVUWszaWtzRjREc3YxdjA5bktSM1JM?=
 =?utf-8?B?MUZId1QzcDYvMFBteDVCKzE2V0pJRGlueCtBbUtia21pamJBQ0wvZVYzRVFY?=
 =?utf-8?B?dFIyWnZ2Q0FpWHV0VGRmMC9VVUx6Zk5RUUpheXRVUzdqNTlJczYxa09ZRTFX?=
 =?utf-8?B?Z1Mrb01Jbmx4MU0zSGp2RWdiODdtNWlsS1ROeVRwR1hZbXh2NVppOEM1WlhE?=
 =?utf-8?B?YW5TVldyMStoTEZzdXpHS1FYTlVUeDg5YzdzYU9MUWNUaFJZQ014VFAvNG5m?=
 =?utf-8?B?QnE0VCtrL0VFZHl5MjNNSkltQkNqZld5QmJaTlg4QXMwcGRtaURkQkthckta?=
 =?utf-8?B?K2x3b3Z6M2c4cWlnTWFvc1VNUnlIOHRDOS9ibUpuOUQ0akluTVpzQmx4U2Q3?=
 =?utf-8?B?ZVllakNLRGI5bEcweFB1YURWeDFXVjZRY2FEZnBhREdBaGlMR3ZLRlJCUm84?=
 =?utf-8?B?czhody90b21xSlU5V29zTmhPUXN3OVh4U2dxMW1ZS2p5QWFHSk1VTXU0KzE4?=
 =?utf-8?B?bEgvaDQ4cXdtOEJYbjgydEpwMmVGbDJtem91b0FIbGlWR0k3QmdQS2RNTGFF?=
 =?utf-8?B?c1hMTjFaY2p4V012RnFySzNDaVZSNkZMOTV6dEN0WjJqMlFKV082OGRnNEww?=
 =?utf-8?B?OFhseE9KMGFxNWdCd0ZBRDJkRTRNcnlWdWpGSzcvSi9Cb2prdEtKZDMvVzhX?=
 =?utf-8?B?bXFuVEptYk03OThkaW1JZVdhN2lqQko5cVhwRldIY3BFa2ErUktWV2VnTWI0?=
 =?utf-8?B?dytmd0FxU3lmUTNIUlBEQmhGWllzTUZYdVdLZCtab1ZXa1RYVUtsbkV4YUY4?=
 =?utf-8?B?OVQwWHEwUjZ0djFpV29FbStkSHJoOHZPajNaUXdTYUxnZm1jR0ZzUFFTc042?=
 =?utf-8?B?cUdWTG9Vd1FUdkV0Z3hWNUNYUWpTR09LdHI5Q1pNS2RKeDc5OGpWdW1POUtx?=
 =?utf-8?B?VVg5UW4rWFd1M083ajQwQWNzZDhYYkhoczdYUitIVVQwR0ZFbHYyZksyKzFu?=
 =?utf-8?B?Um9qTk9ZcUt3Q1ErUEFJVUwzdjV4ZU9MbFo4OEk5Ly9PamlzbHNkY0ZCSTBx?=
 =?utf-8?B?UTBOR0I0ejRzQkUrcmRnZmk5SVBOcEoyMFNvOEZhRUdGMmRMOVBURzIwZi9s?=
 =?utf-8?B?YnNhM25vV1IremhkdjZvajFwbENNNWVpU1NvZ2NwT0FVakFzd1dGK0NxZFhv?=
 =?utf-8?B?d05kdko0bXdCL0k2MUNKRFhZQTdTY1RJQTlTTVVSM2JhbE56bjl6d3V5Nmwx?=
 =?utf-8?B?UllpMmQ0VEN2elJmNXIrUHp0U1kyb0xmL05IK3VmQU0xNTZoY3ZhVVR1MHBC?=
 =?utf-8?Q?S6Q7f/tUj3S+9tYlaMKDEB0+ExDYPBKu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWhpQVRIa2Q0L25QSE9nOVJUekIxYUNCVXJ4R0Q5UDhtQWhxbi8yQUFacHIz?=
 =?utf-8?B?SzN1S2laOWljSm9CMzJlczdJOW9EeFo2UlJIT3ArcFdGZUE3M0VvbUxkMnVU?=
 =?utf-8?B?VUc2aHo3YTZOUGcwZkQ1bzUvL2pGbUtTVnF1TC9JTm1SSndmM1l3ekV4dkFs?=
 =?utf-8?B?TlZhZWpjVndkNnhWb3pQcmdTMlJIWFJYVVNXY2J1Tnd4RUczMC9hbFdYcXlU?=
 =?utf-8?B?bk5NRURqaDRpYmpzQVY3VzA0VEJiclVPYTdnZDgrQ1c0Q24zQy9valJrS0FF?=
 =?utf-8?B?WCtpVEdueDIvTU5JSzUvZ0xDOHZTa0tvbW15RDJxRlpHdEE1VlRxSlJZRkEy?=
 =?utf-8?B?ZHRKalZ1dmwzcFFaWDRaT1Q1VGQxeGtlMlBMbXZlNjZRVm53UWtnb3Blb3Fy?=
 =?utf-8?B?WlkrY3NLSFZNcDVwbnRNaE5hQndCemlnMHJGTW51TFpheE9VNjc4SUIyRThD?=
 =?utf-8?B?ZGl0d3l5QXJtK3BXUitDV1B0MmduMGV5dndicUVjMFZhK0RZT2lza2xLMVAy?=
 =?utf-8?B?VytNaG9ra2xPZzVzMFozVjZjVE5pUGpCc3A0L1B6TXJlRitkVUM0Yy9tenBG?=
 =?utf-8?B?WFRxRWdXbUxiUzlHTWtjQzVKN0hJTGpZRHpjUENIdGtCaDlzVER6K3ZseTFJ?=
 =?utf-8?B?TmxTazVjRWxKR2NhK1JPR3hLcmZqb3ZoS0k0TmNLeWdYTkp0ZUszdmZMUWU4?=
 =?utf-8?B?dGVheUVwdzRCb2l2NHErQmVYN1ViTWFiUFpJcTZLVEtMOE5iMGQ2eDFoYkc5?=
 =?utf-8?B?c3pFR1NvZTFZNVhmNG0vTERodVNPWDMremM1cmR5cjNaQmtPMldsNmpGbFBS?=
 =?utf-8?B?SHg3bmlibzVSMmRmcmxTcm1pem9lVW9RRlVzTWI3M0tJanN1Vy9EV3d0cC9a?=
 =?utf-8?B?WDcwUWp0Y01wV2o4dFpEenowaGdCQzNMNlM3NW5HWHBXQnhTTEhQWno2RVVh?=
 =?utf-8?B?elBRNWlrYTZRVGdLZEZSTXVRekVkeGFNTzVCSWhadW5zeGRtc1FXSXh6RXp4?=
 =?utf-8?B?SkprSHQ0YlhlVjdVNGJINWxrU1ptZmNJOFFjVkxlUFRxQWtFUjh0czRTaXls?=
 =?utf-8?B?dmZVUmVIbmtwcHNKejI2WHBlaVlOdFkrajZ2cDJDUXlBQXNVMUtyd0dzalVo?=
 =?utf-8?B?L0FlYVJWVjFhK0c5NTZJYThmSUJtTW1BT1R0T1FIendkR2k3YWVhMFVwSEl3?=
 =?utf-8?B?RzV4dGFZbUg5T2U2cVJCbUxxT3ZsNjE0VHJuQ0pJTThLamxrWm8wN1BzNWJn?=
 =?utf-8?B?Yzdlckd4UU42blFQUEl3ZDBOM0lXWHFSN3Y1TFd4bllMaXpLTDhXVHR6aEUy?=
 =?utf-8?B?ZkFURUNvYXVVWEVLOE5sTEswVUxNN3lmbWp4ZGVnZjBDYU9rUm03N1J5dWE1?=
 =?utf-8?B?TkFQM1pCVzZQQUswdWY1YXZhMVJSMlpmWndTMVViMmsvY1hnZGQzMWZlNU9k?=
 =?utf-8?B?UDg5RkNPRHZSV0pITEt1ZEc1UmFNUkllQldBSmZwMUozNzQxa2MxbTRzU0sz?=
 =?utf-8?B?Sks2cm82b1BiVGlaVkllc2JZbWlqS1prOFE1QUwyWnlBVHRmcElrUkFLWEZP?=
 =?utf-8?B?UFNUVkVvK0tiOCtsdHlReFVnT3d3bGRhTkdFb0lVdFdwZGMzTjlCL2ZxVVdT?=
 =?utf-8?B?cTZYSjRCeHhETUNJNTdCaGM3bVl0Z2wvdUNES0tvRFdsYWx3akxkOUhDcjBv?=
 =?utf-8?B?KzFON1psdGNBR0xiWmNsaUQwWVB4b0hsZmRSVDlTQW1kdWJZTjdjbG1nbGJp?=
 =?utf-8?B?WnluSS9yNVc3U0NEb0FNTmJSMUx4NXpuUm5ZN3FGQnZxZ1hxZXUxWkhYaXBy?=
 =?utf-8?B?TUY4cHNBdzFFU2pDVHpmOFM0VXpLZnNLcXliajhXYURiQ3BqQUlnVE1jSlhW?=
 =?utf-8?B?dlpEaitMVUNvQUNDeEVycFZXa0VsNXUvNklCbWJrbTFSODd0bDdsRUdoV2dl?=
 =?utf-8?B?RnU1WGE4eTB4eVBjajhDR21raWlwaEFDOUdYdXJtK2N2RmtZU0FnS3ZvdWZk?=
 =?utf-8?B?SXlwdXkzd05YQmZsY0VVNXBCeCt1N0hWTEFwODNLRXF1cWw5ZjRRMXMwMmZq?=
 =?utf-8?B?WkJrNEJsRmg1Z1R4dEl5MnN3ZFdoc3JuelQvY1J4L0VCWU01dThMcjR1MXMx?=
 =?utf-8?B?VVJydnB1VU8wZlJXTmtwM0dKYjk1WDQ1N3JZZnRiNVRVTWZkY1Q3ZXl3L1E4?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91126C281292EF4AAFF4601EB4E96952@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q9KfByeY6meiiVNm0ZTsqR/+/ZkNuDeqFlg2WDLz4xhZq8ipi7VsftrZ8MHyof5vTb2bvKarkrLZoS9z8nXIEMKu75UkZQBjVyztZtvekEAPFOYOLQ5UakO0mWIEhSBNoPVISmlUV/1KxDTlJ3bPyPS7gpqoQE5n5pE31FbOUvHz2tuLAEuOjRo6nahJ0UjRonQ4T+ItxtsefDCzeimVdTXQpuzelQnVrsDrrOweEvV7x2CKSYnqCy8LA22e6AK0jhdsgdRVymQGdp3DiAJzGmMN+nsI1ExX8+t4/Mcv65f9qkr+9Q2MoGDexCH3fKnkqQwvMbaV2aBpJPsHPUIA4sQCHGEhRn4squuwLs/nlLSYMCV5zIKP/tIRQWnT+qccfVcYm4PtmxcF4VZ2hcWf2cXzt/FHgQ0XxiOjiBFj79iyWSldbZvnk7BbbuVf6pLAbHFHg+uKgcwTK1/zHCno3hwv/zXPx+QY//6rJ5pU9jPE+uDclV3d9/xGEYtOktb9j0DvgO4BPdeHui9Vn+siybOCFATgXlBK16UGoEeFOG5lLzDsW+gq9lBADAaiJ20xgKJScJ8FzTPbfqGbG2T5P8WF3c0DVPwr6UlPa3MKLz6TPbrlAyW63Gfk2mKtqkNw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0a94e9-8c14-4632-1078-08dd445857c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 13:40:37.6431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kq+cscJidPsYdHhKug8a2IoCHFeA+/pUH5dEyE8AWsko1ST7lOz6F2AqD4o2tq2gO2A6jZZUF0IYtgZjs60jEnBu8KCPSEE5O159NL4kR0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7862

T24gMDMuMDIuMjUgMTQ6MjUsIEthbmNoYW4gSm9zaGkgd3JvdGU6DQo+IE9uIDEvMzEvMjAyNSAz
OjU5IFBNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+Pj4gSSB0ZXN0ZWQgdGhlIHNlcmll
cyBmb3IgcmVhZCwgYnV0IG9ubHkgdGhlIHN1Y2Nlc3MgY2FzZXMuIEluIHRoaXMgY2FzZQ0KPj4+
IGNoZWNrc3VtIGdlbmVyYXRpb24vdmVyaWZpY2F0aW9uIGhhcHBlbnMgb25seSB3aXRoaW4gdGhl
IGRldmljZS4gSXQgd2FzDQo+Pj4gc2xpZ2h0bHkgdHJpY2t5IHRvIGluamVjdCBhbiBlcnJvciBh
bmQgSSBza2lwcGVkIHRoYXQuDQo+Pj4NCj4+PiBTaW5jZSBzZXBhcmF0ZSBjaGVja3N1bSBJL09z
IGFyZSBvbWl0dGVkLCB0aGlzIGlzIGFib3V0IGhhbmRsaW5nIHRoZQ0KPj4+IGVycm9yIGNvbmRp
dGlvbiBpbiBkYXRhIHJlYWQgSS9PIHBhdGggaXRzZWxmLiBJIGhhdmUgbm90IHlldCBjaGVja2Vk
IGlmDQo+Pj4gcmVwYWlyIGNvZGUgdHJpZ2dlcnMgd2hlbiBCdHJmcyBpcyB3b3JraW5nIHdpdGgg
ZXhpc3RpbmcgJ25vZGF0YXN1bScNCj4+PiBtb3VudCBvcHRpb24uIEJ1dCBJIGdldCB5b3VyIHBv
aW50IHRoYXQgdGhpcyBuZWVkcyB0byBiZSBoYW5kbGVkLg0KPj4+DQo+PiBTbyB0aGlzIGFzIG9m
IG5vdyBkaXNhYmxlcyBvbmUgb2YgdGhlIG1vc3QgdXNlZnVsIGZlYXR1cmVzIG9mIHRoZSBGUywN
Cj4+IHJlcGFpcmluZyBiYWQgZGF0YS4gVGhlIHdob2xlICJzdG9yeSIgZm9yIHRoZSBSQUlEIGNv
ZGUgaW4gdGhlIEZTIGlzDQo+PiBidWlsZCBhcm91bmQgdGhpcyBhc3N1bXB0aW9uLCB0aGF0IHdl
IGNhbiByZXBhaXIgYmFkIGRhdGEsIHVubGlrZSBzYXkgTUQNCj4+IFJBSUQuDQo+IA0KPiBEb2Vz
IHJlcGFpcmluZy1iYWQtZGF0YSB3b3JrIHdoZW4gQnRyZnMgaXMgbW91bnRlZCB3aXRoIE5PREFU
QVNVTT8NCj4gSWYgbm90LCBzaG91bGQgbm90IHRoZSBwcm9wb3NlZCBvcHRpb24gYmUgc2VlbiBh
cyBhbiB1cGdyYWRlIG92ZXIgdGhhdD8NCj4gDQo+IFlvdSBtaWdodCBiZSBrbm93aW5nLCBidXQg
SSBkbyBub3Qga25vdyBob3cgZG9lcyBCdHJmcyBjdXJyZW50bHkgZGVjaWRlDQo+IHRvIGFwcGx5
IE5PREFUU1VNISBXaXRoIHRoZXNlIHBhdGNoZXMgaXQgYmVjb21lcyBwb3NzaWJsZSB0byBrbm93
IGlmDQo+IGNoZWNrc3VtLW9mZmxvYWQgaXMgc3VwcG9ydGVkIGJ5IHRoZSB1bmRlcmx5aW5nIGhh
cmR3YXJlLiBBbmQgdGhhdCBtYWtlcw0KPiBpdCBwb3NzaWJsZSB0byBhcHBseSBOT0RBVEFTVU0g
aW4gYW4gaW5mb3JtZWQgbWFubmVyLg0KDQpOT0RBVEFTVU0gaXMgc29tZXRoaW5nIEkgcGVyc29u
YWxseSB3b3VsZCBvbmx5IGV2ZXIgdHVuIG9uIG9uIFZNIGltYWdlcywgDQpzbyB3ZSBkb24ndCBo
YXZlIHRoZSBzdGFibGUgcGFnZSB2cyBjaGVja3N1bXMgZip1cCAoc2VlIFF1J3MgYW5zd2Vycyku
DQoNCj4gSSBoYXZlIG5vdCByZWR1Y2VkIGFueXRoaW5nLCBidXQgYWRkZWQgYW4gb3B0LWluIGZv
ciBkZXBsb3ltZW50cyB0aGF0DQo+IG1heSBoYXZlIGEgZGlmZmVyZW50IGRlZmluaXRpb24gb2Yg
d2hhdCBpcyB1c2VmdWwuIE5vdCBhbGwgcGxhbmV0cyBhcmUNCj4gTWFycy4gVGhlIGNvc3Qgb2Yg
Y2hlY2tzdW0gdHJlZSB3aWxsIGJlIGRpZmZlcmVudCAoc2F5IG9uIFFMQyB2cyBTTEMpLg0KPiAN
Cg0KQnV0IE5PREFUQVNVTSBpc24ndCBzb21ldGhpbmcgdGhhdCBpcyBhY3RpdmVseSByZWNvbW1l
bmRlZCB1bmxlc3MgeW91IA0Ka25vdyB3aGF0IHlvdSdyZSBkb2luZy4gSSB0aG91Z2h0IG9mIHlv
dXIgcGF0Y2hlcyBhcyBhbiBvZmZsb2FkIG9mIHRoZSANCmNoZWNrc3VtIHRyZWUgdG8gdGhlIFQx
MC1QSSBleHRlbmRlZCBzZWN0b3IgZm9ybWF0LCB3aGljaCBJIHBlcnNvbmFsbHkgDQpsaWtlLiBB
bmQgaXQncyBub3QgdGhhdCBoYXJkIHRvIGRvIHRoYXQuDQoNCklmIGl0J3MgYWJvdXQgZ2V0dGlu
ZyBwZW9wbGUgdG8gdXNlIE5PREFUQVNVTSBJJ20gcmVhbGx5IHN0YXJ0aW5nIHRvIA0KZGlzbGlr
ZSB0aGUgcGF0Y2hzZXQuIEFsc28gTk9EQVRBU1VNIGltcGxpZXMgZGVhY3RpdmF0ZWQgY29tcHJl
c3Npb24uDQoNClNvIHRoaXMgdG8gbWUgdGhlbiBzb3VuZHMgbGlrZSBhIGdvb2QgdXNlIGNhc2Ug
Zm9yIDEgb3IgMiBzcGVjaWZpYyANCnNjZW5hcmlvcyBidXQgbm90IHJlYWxseSBhbGwgdG9vIGhl
bHBmdWwgZm9yIHRoZSBicm9hZGVyIHBpY3R1cmUsIHdoaWNoIA0KaXQgY291bGQndmUgYmVlbi4N
Cg==


Return-Path: <linux-btrfs+bounces-17554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A5BC5FD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 18:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3394250C8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2E2EBB87;
	Wed,  8 Oct 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N3mfJi6O";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j1QEK+3M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4C2BCF7F;
	Wed,  8 Oct 2025 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939591; cv=fail; b=Lkbw7d/W3aS1P3CczvuZ/4Fikv0Cy2ZPGlRvVRB7lbQOeBIDBMqcRSAWGpTf+GCqvxWH7JeQrCoGQhRYvRVpBB+s2i6RVQmubgYh7DirWO1QbdLWDWrPUnSNLOEmUxbbxMPv5y77Sb/7iiptDoUb+fq0d3cPYijVwFj+8lGu2NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939591; c=relaxed/simple;
	bh=QGM2gmkulwTduPfAmfJJ+9cybL6yKVE3ppdPLcWqTYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u4EB1wJl2YDV7WjQvOJK2wwmNuTpVvxV/rwxk5UxkrAdxvb3mdVDZ7oEbWPbD1MAzr4LPCy6TwjOIb72aEmsEIbyb71RatFcYu6JfzpPAnj8IWnsvjsCq2Dal0Mh7SbcBSGKZyJGZgnqE1PrgdzLqvlm8curH9fRC2S/B7knmNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=N3mfJi6O; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=j1QEK+3M; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759939588; x=1791475588;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QGM2gmkulwTduPfAmfJJ+9cybL6yKVE3ppdPLcWqTYE=;
  b=N3mfJi6O3I2Ed4FsSideMhw5hD6uiS5q7FVCLsvT9RHwDlffMSrS80xQ
   V4xlu8QII+bGAGi9cEVcWJJSprt2UpOeVZosLkU2qgumBKqZ3fKo/SPHu
   GfojmWQZqIAUcsBSaNuN9aq0CvQ4vjoj6qV7Nz+833XzdnZpQsRiMR6qT
   vqzQ13iwDLv8mi8hhmCIqtAbAHgj2LG637LNr1gAtBXS5qc+6yNnImD8h
   rlpAEnO+WZ5jO4JDYv80fD41Tmd0csgaJ4Gn1BXDmM4VEJvuCN8LH16Qi
   uEmsHbdwzswhF1kMdC21xEdylgBC14r8aV3j5pC3eFZ7CJGYbivJkEils
   A==;
X-CSE-ConnectionGUID: 4donOWd4RYKgWmJ6flYxWg==
X-CSE-MsgGUID: VzqON+ixTP27AIyeW1exbw==
X-IronPort-AV: E=Sophos;i="6.19,213,1754928000"; 
   d="scan'208";a="132846574"
Received: from mail-centralusazon11010064.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.64])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2025 00:06:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOrB4+6iBV3z8MZzi6ydAKCZ9LD4VMWTW0j2rPP/LiU9y7kVtadcSqTv41EysqsXz/+YE7Ys7b3TRwD3KlWcpTIS+APwxbwKTh4h9NMYhJThUUpSk+6JFvE626cc3/1GX3Lvfw9L8DqJmc2IrPtv4utc1xItz+gqzS0C7ozDv6iN6kVyzvoA+6CAtDSzsTuKoMCYeYSgnb/K9CuBAcXdra+Okws6v6ihhCaLSMR73+Ae8JzP//HHq7mHQxF9/ctlpSrmLlQbNlx8l0PfPN1ZIMeV+0Ipu5M3f1XsdCYg0zaC6bfT5qnI7yisXrTSYzKzqE9N3fkRGff+Dg85vKIaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGM2gmkulwTduPfAmfJJ+9cybL6yKVE3ppdPLcWqTYE=;
 b=ux82gb8EdAVaeA11OGNrK2E4hS4C5NNnL9gfJGVTgJ/8eKaw3ONcZ9ege3UZzwcfWp7su2q38Ta/3hA+pRmRdjqx/IFdJcfVwCwO1VEYM6c+pr2nHpIBXFv/XwKa/3jgGtBwzkdeYBJkead6RL5jbLbwo8g2vhe0OuNeOPY1ty4YFjvX2Ho9u9IIdxRP4KL4i2/o+/Mi/ZORuqdUir8abQqznoohwogp4J1U7ye9/3+x0bfa9LAWThyvsft6EXX8BZnvg4ju+DKsE/AppGEQ7PKdeSDyYphSsiT/DaMFE0+43/BOAEXIiAXSjol0VkS8lwESRrU7Q7weiGDiHcvLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGM2gmkulwTduPfAmfJJ+9cybL6yKVE3ppdPLcWqTYE=;
 b=j1QEK+3MpUho8qMx7pBGPvpokMzxrM+/KlFU5GftD5ZmRC9+ejWvv2VXIP8seRwKjF+FcgahtQRyBe9n7T5Nbqf7BkdvpXo7kOYxlioJg+EkqvJU3Ra0wKj8I5M237Cn4KzYA2cjP3G/ZjY+e5fzeids+emmsXjJ+eqRlH6CIMI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW6PR04MB8799.namprd04.prod.outlook.com (2603:10b6:303:23c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 16:06:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 16:06:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>, Naohiro
 Aota <Naohiro.Aota@wdc.com>, "boris@bur.io" <boris@bur.io>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] btrfs: fix memory leaks when rejecting a non SINGLE
 data profile without an RST
Thread-Topic: [PATCH v3] btrfs: fix memory leaks when rejecting a non SINGLE
 data profile without an RST
Thread-Index: AQHcOE3VvpwM2HPf1kGLxyfHaVK4r7S4alaA
Date: Wed, 8 Oct 2025 16:06:15 +0000
Message-ID: <22ac2987-9077-4927-aa01-447d4cf593e7@wdc.com>
References: <20251008121859.440161-1-mssola@mssola.com>
In-Reply-To: <20251008121859.440161-1-mssola@mssola.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW6PR04MB8799:EE_
x-ms-office365-filtering-correlation-id: d912554e-f24f-4277-463b-08de06849c35
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEErRURaajR2cXQzcVdtQ0tuS1JwVFlSYmhHZ1RPZjE1NXN4M2U0TXR0RktO?=
 =?utf-8?B?YTRIRjRXN0xyS1RhQkpFZEZtQytrOW81T2pUcFNURmNuUzFCalhLTUFnMzZh?=
 =?utf-8?B?RVpoWmJNTDY5dmx0YjdFZklxMHk5eWJmcDV2ZWFCMDE5dDFSVVZvTVZqR1JM?=
 =?utf-8?B?WVBzRGtYTmltWUFrWWFOcW1ya2kyakNsNXIzMXpUTkE2Qll3OWdrYnU1S0xY?=
 =?utf-8?B?dmpEMVFpY2w5NnBmR2d5SkxiYWxFYUJaS0ZPdDJsdElPZ3QyQ3dROHR6a0RR?=
 =?utf-8?B?QTZ2TVFmUkJ5T2dsQTM4cnhpS2NucE55Zi9ieTRRTjV3V2RBUEdlb2hKS1cw?=
 =?utf-8?B?U0tUVjhBZ0RORWRKNXVuUmRsMkpoWWhnQ2o2MmNoTkdNOGswb1hUTDhLV20v?=
 =?utf-8?B?MXd4K0xFQjZyUks1YnBOK2owVS9sM3d4K1NwK0VpT096UW81QS9RamowZ3li?=
 =?utf-8?B?b21YVXh5Y1FUK0xoQ1U3alE5L3MzcWU1ZTkrRHAzbFJqSXMxV0tsVHVuejhI?=
 =?utf-8?B?clhNNFAxUHlQQXJRUWFzL0M1L2VocG9MWFJ5OGdPTUllckxBc080cmlUc0pT?=
 =?utf-8?B?VDlTWnZxczN4b0pQRUZqcng2M0tJcVoyZXI4SitvdEhPNlFBN1VZa01NOUVO?=
 =?utf-8?B?U2ZWV00xUk9CcmlyODZaYzUxK2xjYmRtektrVnVJY3ZvQ0VVemlFQm5lWUt2?=
 =?utf-8?B?cWZ0WGhhQS9qOHVCbmNnNUQrWCtoK1pYSW80Z3NTUGk0ZUUzNGFoMkNWSDdP?=
 =?utf-8?B?TjhVSUFrR2sxZjAyaVR0Y3Q4cTQ3RDlmYi9PVE53VnRSYkFJazl4R2c1ZXUw?=
 =?utf-8?B?YXZNQ1lQNkVRQjlVeHNDbVA2UzJMYnQybXRjczlaNlBnTk1BQnBSZUVtSEgx?=
 =?utf-8?B?ZWtwWlBzb01PNThRbkdUblh0dE5Vd2drdWJkNmNtUkoyVWoxNFlsa0NwZHZp?=
 =?utf-8?B?bmRsakFJNlAwNW5tWkhydjJrSFJIZUpDZEhrTjNETzFCSmUvQ3phOTNUMDAv?=
 =?utf-8?B?K2Z3M3lhbURwNHR2RjlCVnAvcVB2UHBKTThMNlNOaFFkOTBsU0xiUWpPWk54?=
 =?utf-8?B?YnFBVWViK2JMWjcrVkk5RDRRMTNRY1dZVzdKSVRpdWNFUm5nVEQ2b0s3M1lI?=
 =?utf-8?B?QTBCUDMrdzZEL2YvTEJJQlFHK2VMWmkrTFdmQjFKbGUxaEJISUpGMUlMRnV4?=
 =?utf-8?B?UWQ5UHZ1VS8waVdOZTh0YmIvdVA3OTRXTTU1bnRjRThoY09UekdQVjZyQm5E?=
 =?utf-8?B?azlqTGZuYjEzN0JUMzBQK0tBT3cwRkRRRUYyanp6TWJLd285RzIrK0dlZkRV?=
 =?utf-8?B?QlY1SDRZVkZCVU9xYnFXVDM0d1Z5OXAreEF6emx4c0VGSWlieTBpOHUyNHQv?=
 =?utf-8?B?SFZXYk93RU43UFpCRmloTXBxM0RkcnB0TS9XTm9QemZWc09MQ28yTTkwbUFj?=
 =?utf-8?B?dEJzdExTbWNxTWIxcDJSN2VzbmpRditEcGVIRlNIUlFPK1Y4UjBWM002UXE5?=
 =?utf-8?B?VThMQzU1eEMyaStwMGpWeFdoMnRHVXhhQW5qdTRFUVZhL1AyRjQ1QUJwb1pR?=
 =?utf-8?B?K25xZnMvTHRnNlF4VUV5VGJFdnFJSjV1Q0tqSlRDbkNjbUJ4dWtFNGVnUTF4?=
 =?utf-8?B?THpXWHR1MitXWWlXemE1THZQTVMrWVJvS3d1SnY2MW12M3g1ODY4cUE5YXZi?=
 =?utf-8?B?SGxjZ0dxclVPeGtlZ3ZBMGx1VW5SK1pyRHZnREJ4cENkNzBQKy83V2NkWlkx?=
 =?utf-8?B?d0N5WmE2QkZHdVNVcWRiWDIvNjhtZFJFL2t3dm4xOHRiSE1NZnFwYlhIVWp1?=
 =?utf-8?B?UWhDV3pFb0xnTkpXZGpHY3BURzRNMk5sMzRJU3pGbGZNaGFoVldLNmFDeGRR?=
 =?utf-8?B?MGtod1ZjSlJ0YkI3QkRHQWR4Q2RGdXkvd2o1MTc4c210czcyVStFMG5QejBj?=
 =?utf-8?B?MUJFWm45OG4vYlhINlBSZkVDY0k4LzcrS2Y5d1ZBd212dEY2NGpKUi9HaG5R?=
 =?utf-8?B?aVRnaW9wSm4rVzk5ZVF2Q2tWbnZNTzFMU3VGdjk3M1FwSWlWeWpBU001cDdB?=
 =?utf-8?Q?gS39T9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0FWR2orODg0S3VXZW5XcTZQTUdrSi9SaXFyL3l3ZWYzZUNYMlY2eFVudW5v?=
 =?utf-8?B?emd5OFBDTTVNUk5UaDVHaVlBWVBlaHI5RHBNcEx1TW1ucDFwMFFtaW5RMTNo?=
 =?utf-8?B?eVdkbUhhb0NWWHN4Q3RFU3F6ZEZJd2dCSXZZVTREV25uN0hOODFQWWh5bE0z?=
 =?utf-8?B?dDdoSjlnL2FqNDJKZGEza1A5c0dJWCt4VDJZMUVjYTZlOCtidFcyeHlTdWVp?=
 =?utf-8?B?aGluU2kxNXVPTlZTOWI0Uk8zMEJlL0FQSVFibFZiL2ZUaS9MSWVWd2ZsNXRZ?=
 =?utf-8?B?cGlYSVFnSURvTXkxSGVqaEtRdUhEeDRjNEQweExvN1ZucWppd2RLWjUrdG50?=
 =?utf-8?B?c2VDdFVZTGpIajFKTXM0U2hTR3FaWUh4Vm84T3hCc3BpMzRLVnJEcVNMSTFu?=
 =?utf-8?B?eVF5cHJPZEQ3L0hiZXlINGpGOXAydUNYMjZEajRvdjQxQXB5TzFUZU83NmVS?=
 =?utf-8?B?NkdjNUd4RVhWODdINW0zLytBZk9MRTNyVjlSUW5vMUEyKy9qczNwR01MemI5?=
 =?utf-8?B?ZXo0U1pKY2hxWHFybDlxOWdHYURjL3dJM1hGTjhzb0dLLzY2ak5TVm81L0Nn?=
 =?utf-8?B?d0NWQ2dOZ0FFUjcrdWw3V21hZ1NkZGNucXc4S1M3bjJuQjFERzl1RmpGSlNv?=
 =?utf-8?B?LzNkMi9Cb203V21yRzBKbk1QTkloSVlPbmozWGZyOHJxTG5CKzd2cEhUM2RX?=
 =?utf-8?B?ZS9jMk5LVFQ3KzM1TUljM0trUnNUaEl4OHF5ZkUvYzVMYkVFa2NHbDlJV2Fi?=
 =?utf-8?B?eGxGNkk5eUp5Q2M2dUtJdWVQM1hjaWFVZFhqZnprVmpEV3JHbmVRWk5vYjgz?=
 =?utf-8?B?NXpySEx5TGplK3V4dEV4MGtLNGpTUVcydFVzUmhrT1dlblJITkl3ZW9uc0My?=
 =?utf-8?B?SmdRWVV4WjYzSks3cDEwSmxHaDRUNUJGL25YbnZ5amZrdTFpS2FhZi9DL0FU?=
 =?utf-8?B?WlRwcEZxUzNDTmhja29MUG85RUpwN1k5QUV6Q08yMEZuVFdkNmxZMFczZlN3?=
 =?utf-8?B?YjBCcTA3Qkh4bGk2dHo5K0hFVUV1YnZzWEFJUCtNZ2EzZzNnaWdSL3FMWmE1?=
 =?utf-8?B?cEd2enRzTXdLbGVSUXZvMktrbmUrM3drbFVFRGRLaEs2NWlOZ25CZE1ZODZI?=
 =?utf-8?B?ZHk4RVZHZWFEc3ZxVWZCdGl4TlhPVU14aEYrS05NWE1pc285aVVuVmZ5cjh1?=
 =?utf-8?B?d2JEMmplWDNqaklWdmRMdnRaZ0FOVVVVMlA2MVh3YXV6dDZEUWxsUVlLRm1n?=
 =?utf-8?B?RzEzMFZvWHhMbFRIcHArM2Jxa0JoeXUxVU5TeTFtR2ZkZE9vODNkVGFLR0pP?=
 =?utf-8?B?cnVRSzZXNWp6bGZBZWwvbnFoOTk2M0xBQTVuNEtTL3BibmJjbmxqMmNRck03?=
 =?utf-8?B?OFlnY3pWR2NjTG5YRlp5Rklxc2JPbW5PMWlKZWczRk9KV1hYSTlqYmk4akdz?=
 =?utf-8?B?a0NVTGxPRlFVb1lSR01hU1FoWXNNUGRnRHh4WFBlUXU1ajlLSlYxWlhTWWg1?=
 =?utf-8?B?aTQzaCtVUGppRnQrTE1uelhYWFNWcnJ0SCtwelI3bVRhNitUcmVKRVNyZ3Bq?=
 =?utf-8?B?bVBUUTNEZFBuQysxOGszMDBUajlVcXNiQ0dRS0lZbXBkU1N2L2NpeTlFT2t5?=
 =?utf-8?B?bmhTMTlQZzNXdG42c01aUmlsQTJsWjZqUWdXNUJSc3g4MVNRLzA0WWpJVkhl?=
 =?utf-8?B?UHRLWUFzalc4VzVuN3k4NnRwTTJFMlNLTXpIZmlPL20ycm1wRkV3RzVRbkE5?=
 =?utf-8?B?Zjd4QXdvN3JURldMN2d5UTUzQVFZdHNnOWZCaDhUS2FzdG40dGQ2dHNGTVlP?=
 =?utf-8?B?NXBpNjRDOHp2dkVaRitDNEUyOGZhNytZWk9BS0RjdW10Y1hPQ0tuUWdmb2hp?=
 =?utf-8?B?ZGQ5bzF3VHNHekdSSUpvWVhKS2ltcWgydnBiZnM0Vis3WTdxV0dmd1Yxbk5h?=
 =?utf-8?B?N09OL3ZrdVZQY3dGTllXRGhyK1ZZaklGKytGTVNmdDBYM2crNzN5MGloTDB1?=
 =?utf-8?B?eGVrMTRqVm1UcDl1WUl6blhiY3lZT0NacWVzMHk0d3AxRUhobDhBRTlQWndS?=
 =?utf-8?B?Vk5CcG5nUU5ZT3FHcE5nWFQxZG5TckNXS2xhSGZPOHFmWEJZdmtuU2craHBh?=
 =?utf-8?B?OUtsS1lFMnN5dFNvR0hFUkdmZXhPcloxZHFUbW5FRGhibi9pOFcyWXJiTWNs?=
 =?utf-8?B?cys4dzg1a0hTZFJHQlBvQ1ZJNWxkQ2k0dzJtR1VyR2ZBaE5PbkVnRHkyNVBr?=
 =?utf-8?B?dC96bHZaZ2crME1oM0xSaUw4ZkNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACD259D5E27615498A94E0704A9868B7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yotPXDsGoxcFFKstzVIN0j03a2farb6lIbRx3KMON2EPzJxVxi/jrzKXsBGR11UDDcYpqUwR0l+JWIR9+YMgLk32aRJVMYnEulcEHNn6hMiTpSF2+ShF4Jh9BlWjmmN+tEQVUPHCWZZPnP8Ngi+y1/R5I7rR4GAt8xFwSKvDOUEH2kTdsZOtOo5pWBpAiwtJL6ReSkwQkiF8uzytxqcUTkOvYNE+J1Qi1IZq7w/VQ9yybAXGtvmQ9yb/eoWPER2BXCWGuZk7ClaETHj4d7rblXnnv/qGZ0kOwOebvCuN8jcRTeak/Bwzzf5Wk8DCo858kMw9X8eL96pz74OXXYqfA2U164rNoPHMpSK02eydZtwZDqsIJnQOguK+Fw61sfeTL8/ztGZ8t5ME4WsrZYJglDIJsLbuhyioTa1rhty2Zr5GqEr3T7kQF9yylKLbvFBEz7q7QFvG3ouVeVjthEgRqqlcOs6ZaJqVpd1u68sUSS0GGlhjD+VDn+PC4W7Nn7vDRVUm2MZMWCmVtYtv6XIQwGkjRieGKVvX7Sfjuz1bKKfsYUS5J9xv1Of74mOjlZxcyeA7/K5Li0Jckgt58fUcNau1DNYxTzc0NJutS0bFkBnbZBjqeOBzFDfYP5P64Wvj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d912554e-f24f-4277-463b-08de06849c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 16:06:15.8899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyeFAOzQcd4c88xxTtjz/mh8EmhoBAr3+O4PavAkpGKhy8Ex0zW2SQBuLvDU807vpjxlnvtAzR2dgumQKXgS8Zg2b7GxFHJQD1b5wqnjJJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8799

T24gMTAvOC8yNSAyOjE5IFBNLCBNaXF1ZWwgU2FiYXTDqSBTb2zDoCB3cm90ZToNCj4gQXQgdGhl
IGVuZCBvZiBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX3pvbmVfaW5mbygpIHRoZSBmaXJzdCB0aGlu
ZyB3ZSBkbw0KPiBpcyB0byBlbnN1cmUgdGhhdCBpZiB0aGUgbWFwcGluZyB0eXBlIGlzIG5vdCBh
IFNJTkdMRSBvbmUgYW5kIHRoZXJlIGlzDQo+IG5vIFJBSUQgc3RyaXBlIHRyZWUsIHRoZW4gd2Ug
cmV0dXJuIGVhcmx5IHdpdGggYW4gZXJyb3IuDQo+DQo+IERvaW5nIHRoYXQsIHRob3VnaCwgcHJl
dmVudHMgdGhlIGNvZGUgZnJvbSBydW5uaW5nIHRoZSBsYXN0IGNhbGxzIGZyb20NCj4gdGhpcyBm
dW5jdGlvbiB3aGljaCBhcmUgYWJvdXQgZnJlZWluZyBtZW1vcnkgYWxsb2NhdGVkIGR1cmluZyBp
dHMNCj4gcnVuLiBIZW5jZSwgaW4gdGhpcyBjYXNlLCBpbnN0ZWFkIG9mIHJldHVybmluZyBlYXJs
eSwgd2Ugc2V0IHRoZSByZXQNCj4gdmFsdWUgYW5kIGZhbGwgdGhyb3VnaCB0aGUgcmVzdCBvZiB0
aGUgY2xlYW51cCBjb2RlLg0KPg0KPiBGaXhlczogNTkwNjMzM2NjNGFmICgiYnRyZnM6IHpvbmVk
OiBkb24ndCBza2lwIGJsb2NrIGdyb3VwIHByb2ZpbGUgY2hlY2tzIG9uIGNvbnZlbnRpb25hbCB6
b25lcyIpDQo+IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgU2FiYXTDqSBTb2zDoCA8bXNz
b2xhQG1zc29sYS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAgICAtIFJlbW92ZSBj
b21tZW50IHdoaWNoIHdhcyBkZWVtZWQgdW5uZWNlc3NhcnkuDQo+DQo+IENoYW5nZXMgaW4gdjI6
DQo+ICAgIC0gQ2hhbmdlICdnb3RvJyB0byBqdXN0IGFzc2lnbmluZyB0aGUgJ3JldCcgdmFyaWFi
bGUgYW5kIGZhbGxpbmcgdGhyb3VnaC4NCj4NCj4gICBmcy9idHJmcy96b25lZC5jIHwgMiArLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZnMvYnRyZnMvem9uZWQuYyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4gaW5kZXgg
ZTMzNDFhODRmNGFiLi44MzgxNDlmYTYwY2UgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3pvbmVk
LmMNCj4gKysrIGIvZnMvYnRyZnMvem9uZWQuYw0KPiBAQCAtMTc1Myw3ICsxNzUzLDcgQEAgaW50
IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfem9uZV9pbmZvKHN0cnVjdCBidHJmc19ibG9ja19ncm91
cCAqY2FjaGUsIGJvb2wgbmV3KQ0KPiAgIAkgICAgIWZzX2luZm8tPnN0cmlwZV9yb290KSB7DQo+
ICAgCQlidHJmc19lcnIoZnNfaW5mbywgInpvbmVkOiBkYXRhICVzIG5lZWRzIHJhaWQtc3RyaXBl
LXRyZWUiLA0KPiAgIAkJCSAgYnRyZnNfYmdfdHlwZV90b19yYWlkX25hbWUobWFwLT50eXBlKSk7
DQo+IC0JCXJldHVybiAtRUlOVkFMOw0KPiArCQlyZXQgPSAtRUlOVkFMOw0KPiAgIAl9DQo+DQo+
ICAgCWlmICh1bmxpa2VseShjYWNoZS0+YWxsb2Nfb2Zmc2V0ID4gY2FjaGUtPnpvbmVfY2FwYWNp
dHkpKSB7DQo+IC0tDQo+IDIuNTEuMA0KPg0KPg0KQXBwbGllZCwgdGhhbmtzLg0KDQo=


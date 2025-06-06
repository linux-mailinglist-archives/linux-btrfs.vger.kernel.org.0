Return-Path: <linux-btrfs+bounces-14529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D8AD034E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 15:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F077A9C0A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95156288CA8;
	Fri,  6 Jun 2025 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="InXBSCDF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63D2874F9
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216957; cv=fail; b=Z3eFVOmqg484PnfW0JENVt52pZKhTJvF6u0L/oQ3uX80PlGPfen1CGqeUQJLirU6G2medCbAbVTEUtncDIeSgB+3lE3Pf7/jVzbLL9MstsLcWbUbmKAh0xpASjJ+OCKQf3dHHRBaG4asLn9SK/4AZ67YkpPh5cC60NBATG57o8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216957; c=relaxed/simple;
	bh=CnGhSuGxCq6WTKFRIV1X+UGFGa6xIXfHyHRtXk+Bu8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=tPCC5XA8/MX2/2MoYcpV4y3BZMZKd1SkO3mPlIyZJFUOY+PTJlr7IXCxEH3zwRVoeh79WI6wqApMQPew/gYHf3J89TjPO8UgQsq7Q1OAT1P8eytX8bbpHrBYoKM5nifrzFgwBsybBNg9tqvYIlG7fXzmdJv5gNQuN4YTnkgwOqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=InXBSCDF; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 5569hmNd006414
	for <linux-btrfs@vger.kernel.org>; Fri, 6 Jun 2025 06:35:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=9NSanapB6dV2xNy5PA+ltcAVx6xwu49DPXwkiKN40yM=; b=
	InXBSCDF+pQBN5A1wsI+D1OvlfW6TFbtbyzXIsrwwIGwyOgNvDPVcHQiSjQzWe91
	BraXr6OGFgahxM8z52aRUvaHJzEMwHapAGbo2b7J9Wb1pCrQqwCFE42jVDVyMzFl
	BvsEx4fBhUcYOO+tNCL6XjWj51Z41k9FNpNYuyfau6RUnZUK1yBpiLe4xm8Wg0qQ
	MPlqXYh3rMkw/gl8MlFkFGY+cjD/8aK5yc3F3wd3YRPGIW2H6kDyBQH605PLMQVY
	IPCb621y/Mr6uFAO3xRsv69qadhDvKvRUmsuoGErBiy5U66NKzu6srjHj8VIvm5E
	hm4k34X1HyBdy+/9yeYSIA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	by m0089730.ppops.net (PPS) with ESMTPS id 473v76t04p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Jun 2025 06:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELu8N7970JgnlYzJxv64JXEWGAnkPelTci+tfSKaZ3eGaLPRqQzLFi4Ma77YdSkLNWDMJ5nfIDrdSoUV5Jmqa+Q3Pt9Uqt2OZtKvh0ByfvkfJ18skf/Q0UsisIFZrrP9Kv3YUX/W0zt0xXyC3HOpv3spDIPhaApVOOIgv353O9odZ5+vJKa+MCa6/dhID88p9rqV28ilJzz9q4AxQ18qAgB7G0rOeRPecfXd4riBOS7Vkjjz48cUho697INLlxz6j3Wd9VuXZz4jLbFjToAjs3HaVu/8VXeQCHZIf8sAfx7Y4EB1G5ruSGEvW7RsNEJZ1MIA5E+cfu+BRvGFCHBw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+ziwAPpveAhJ4u8FMIzFD06A8L/wx2A4BVU+7/LaAo=;
 b=Z+0qmDSChT3oDFL6/gnisXstV7G2kzasOsAGRyqZDU2fQRXVCV+vU9nEr11XKr7nKRztRCJNI8pRVi8TmJssJpYpA3tS5h3uuSPSeqvwGuW4Lwhz7RBXUIbMr9AAnVOrydg309GP3zx1NNC/nFl295v5vzNZoCbnlUSbPxMCQu87UdFtW/Su/z83rNYJAaikOK+mw2Cm5aSoBFMgrDI6gmQpm8Y2eQn4XSqHPpNaPcGSbUBwN8FGO7VZ86fkUSfBSgivFMPLOCnVE+uImwuGhXmMBHrcQfvHYJDInKbvAbEXQAG/+r/OKJThIKpFmgPBshh989acG9b+9DKeSLXAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SA1PR15MB5233.namprd15.prod.outlook.com (2603:10b6:806:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 6 Jun
 2025 13:35:51 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 13:35:51 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Jonah Sabean <jonah@jse.io>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/12] btrfs: remap tree
Thread-Topic: [PATCH 00/12] btrfs: remap tree
Thread-Index: AQHb1jY9ptj9DkqFPkuHGxeXOfmKP7P0xXQAgAFd9AA=
Date: Fri, 6 Jun 2025 13:35:51 +0000
Message-ID: <e35b2329-370b-4844-a464-d0a29573874a@meta.com>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <CAFMvigdEQVj-uJqfCVqYXf8a51xY48gsYg+tvFNFrC3gPyF-gA@mail.gmail.com>
In-Reply-To:
 <CAFMvigdEQVj-uJqfCVqYXf8a51xY48gsYg+tvFNFrC3gPyF-gA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SA1PR15MB5233:EE_
x-ms-office365-filtering-correlation-id: f0371aba-2592-4a79-5e4e-08dda4ff0dda
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RzJHaDI3SitWbnNCQVNqVFdBdmFZdDJvTk9yUHpGY05aZUZvbEhzaURadXhK?=
 =?utf-8?B?TFA2WWozRklNRWNHd3FQTGRNRmE0YjFteURsajVXRUdaQXVucjd1V2tKQ21R?=
 =?utf-8?B?RCttMEtBWGs0cDZyb21tSlVETURnZFhiZkpwL29VTnJnMnYxME4xNUdZQUpv?=
 =?utf-8?B?WDBMejQ3WjBnbWMvcVJwc2I1U0p3ZGhwaWRJOFUrUTVHZm5GTmtlQlR5S2JF?=
 =?utf-8?B?SStrdUZaVUxHTkFnWmZZci9jWmhLa0RWQ2RmMXIxdmVjRTZMSTJaT3JQWnRS?=
 =?utf-8?B?S3RLb3pMc2YrZUF4YXBjcUxsNjVQK05kd1prcVo1UHVlekFobHVmN2QrWWpL?=
 =?utf-8?B?VXZVSCtPNGFBWS93eUZZcHZqRXVrWTJoOUdGOU9KRVIyU2s3MkZERE9DRTJL?=
 =?utf-8?B?UEdGanpndHowekI1M2VmcTNITmhRSDhsNzYzMFpJUnhWbFppNEtQR21sSFZ6?=
 =?utf-8?B?R3FKNXhHVXF3d0cwd056TUc5ZHVYOFFyd3AyMzNTdyt4SW52c1RlQ2VsaE5p?=
 =?utf-8?B?TTNkNnE1cXoxdEIvVWoxaWR5K3JlRityMWVydGdleEFFekR0aVc3dm5lNnlG?=
 =?utf-8?B?aVlpSlRQbG9NWkl2U1NBeFlBVFQ5VnZ2SlR6QmNOWExWZHRQMm5hbnFaczVK?=
 =?utf-8?B?aERJNjNGeHd1WVJRMllSa1Z4a2NjdWwzWVN1S0xYVUR2QWhhZC90ZCsvYmw4?=
 =?utf-8?B?Yi9LMTh1SlNGMzR1bTBMNHphSXJzcE5sRnBsSzRsa1VLaGJoa0tHTVNLdXpi?=
 =?utf-8?B?NzJoZUNPamdkYUp3TzhyTzlyckdGL2drZG1qUjJBa05SV0FCc3FnTmw3NUZm?=
 =?utf-8?B?aXp5bXkrRFVXODVtNWpWR3RBc3lUMjh3UkJ3WnBZZWxCam50MGFaWWFTeVdk?=
 =?utf-8?B?ME9wallnZjJ2TFlKbXZJTWZiWmZwSEI5dk9TRVhSdTZnQlRheXJ3U3FzVDZ4?=
 =?utf-8?B?MFlkYlFTcHFjd1dRVUdCS3hKZmJOYlNRSmhVOFdxaTFjVXJZWGFwZDc1TG5X?=
 =?utf-8?B?dkE5eGpyVVBFT0kzM25HemVxMzJQdFIxVWV5RTh3RVUvZFY3MGs2TnhPWUEy?=
 =?utf-8?B?RC9qZHVwNnhaRU5POC9OSjIrcWdSMVZkRTFxeGJQOXVtQS9wMUkza2d5aXJP?=
 =?utf-8?B?emluNFJ4NUc4RDg2Tlg1ek9TeDg5VjlXcFd5YlJWdURhTmFROXFmRXp5Y3hk?=
 =?utf-8?B?TXRiVzFLcmZwdEwyeTl0cjZDNnV0MGVqTHk0ZXkvUWFNMWViVGIyak1XbDdU?=
 =?utf-8?B?N1ZtbUpCdEcxNUZOTnUwRzBZK0xoV0IwVEFIbW1sVlJHYm1HcXlBTGdPYUl3?=
 =?utf-8?B?NjdudlB3NXpGWUxadXhockpVNEY0dE1OaUMwdWFQWnlpMG1LNnMvaGlmY2Zz?=
 =?utf-8?B?ZGpnTlpML2hsazJwcGNoUTFvRDBtSXNBNm1vV3BBNU9id0ozZWRWM2pMR1NE?=
 =?utf-8?B?cld5NjZTejVBNVZPYzhadnVVN3hSdHlUckxkenF5WHYvVkR1Nk9hOFVmUCt4?=
 =?utf-8?B?aTBxdE9YNURLeFBScEdUYUFLbEVIdCs5dFBQVUtQY0xQR3JxaHUrTTRaeUFZ?=
 =?utf-8?B?WG82R2t2Z3JJbW9oSGtYV0xjZmtQblg3NU5ROWhPeVpRZFpJM3JSamFmbjZW?=
 =?utf-8?B?dzJCUFpMVjZNVGJXcC81TzFMVWlBQjd4Rk52RmY3MVRJWHNFTCtWNHFBeFVJ?=
 =?utf-8?B?UWlWamhnWjhMay9zbEFGYzFvdFZVR25qdEdoT3AxY1FEVTVMSWt0U3RlL3ox?=
 =?utf-8?B?MWJvUmZLb3I1VXdlWitPcmhacWVMMDhOT2FOZ3ZvU3ZadllSWmZ4RlJSSzRG?=
 =?utf-8?B?K3UwZHZkMWE4bG0zTmE0OVJrbWlWM0RyeFFWdUg2Tmp2OThKL0hpRWtnb0dW?=
 =?utf-8?B?Vk9zZmY5YVQ0Tld1eU9rL0NLN0V3ZXNJOGVzWmxrR3U3bWJVKzlNUUJtUmlj?=
 =?utf-8?Q?Hkivx1xyNE5yalFindjI2oTbIOzI6464?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUhMTHFSZTdVRVlKaCs2czZnZ0paalZxeDlhU3BlUkFVOWQ0Zm5BM2pzWUh6?=
 =?utf-8?B?V0FRT29NUzZDN2hjbXRiY2dSR2k5blNoRGJqbGc4ZVA2WUFnVlNYdUNKclpp?=
 =?utf-8?B?aHZRWHQ3aTV4TDlYSi9WRGxSV3NDaG1wT1BDK3pvMUIrK1JETFpxWVdHWXo2?=
 =?utf-8?B?ZjRNSVZxUGtrdnJhcUtEeWltQkpZaGs2QzhUZXdLUERId1gycWNFU0dORE9E?=
 =?utf-8?B?VlJjS3Z2SDlncFc0SDBaVGVDci9PaGgvQ3JZRTVwV2JIY2dVa0VBUHNidGJ1?=
 =?utf-8?B?QVFoaHBFcDBUckZtY1ZSSVBlUWg3bHR0REhucXB5ZGhkVHNiclhUeUZRbTRB?=
 =?utf-8?B?TEh5cyttc3JXRkdWVm85ODdPeTBrZFhOVnlsRGE0b25rU2Y5SUFxQ1BOTFFt?=
 =?utf-8?B?bUdjWkpFcTNOeVBPT1dJRmdNL3JjR1h6ank1eTM5YUdzWkJBOFVYZWp0Nmpu?=
 =?utf-8?B?bklTcDZZQmdjMkJuNHROekpvYTNPY0EyaitTVXVteCtZUEFnejBXNDl0WEMz?=
 =?utf-8?B?U3I4dEhzV2tHaEkzYUhpaWdCZnUrWGZnOVI0WVNYVVdGUzh0c3diSEJUTkF3?=
 =?utf-8?B?aXZRaFRqR05Da1V4NFNGOHYxUzYwK0ZiRXFwczJyeUtPZzFpdFZlNUkyd0xS?=
 =?utf-8?B?TkFHaUpQT245ZkhwQklWd01Ec1FBMjhJcW1jTTVBbUU1UWZ6K3VaK0VDajhr?=
 =?utf-8?B?QWpXVkdENWRoTW1wTFZPOS9zelhta0FDc2diK0cvWEw1UHJ2MVFHMjdKOWxV?=
 =?utf-8?B?dWdCbkp0YkVCUVgxeEdzRzNBdjlzbmhodDNsM2lEdGVGbWlQalYzbFBpZWRp?=
 =?utf-8?B?dWlEdXFJc0VRZG1GQWdiZTNubDJTM3k2T2lpbU81NWJwUnBGNkc0T3hNR3BL?=
 =?utf-8?B?amZXcnJieFBCME5QY1JOd29BdGwxR0xncms3ZUZzVGg1dm1mSFI5NnZ6VkJT?=
 =?utf-8?B?Z3ZnaUhlYkpRaWdScnVVaDNtZk9CUlhQRkRqWDNlZElKWG1yTHFEQkJaVjdI?=
 =?utf-8?B?b2wwZnhLU2hXWFJKRHk4WCtabklSM2VZalV3bXRrdGQyV3lEYm9PREp3MmRv?=
 =?utf-8?B?QjJCQkJsdW1VVTR1Mmp1SHdkQm9sbHh3SE1qK3U4K2g3Nm8xdmVsNEpHUEdn?=
 =?utf-8?B?WW5WbS93SGpCUXNTUFdDYlRYdERKSUtNcUZFR0ZSdFVQSTVqVVFWMVJFbEpR?=
 =?utf-8?B?RnRqcmtLUHR1REZ5cndqd2xOR2Y4K25nYm9NUVN2ZkxuNTd1dTg3dGpBRzBZ?=
 =?utf-8?B?N01CR2RUZGRNSVRnR2RwR0tYZU5qZnlrN25paFZ2cFc5UGtZYktIMmhsaERV?=
 =?utf-8?B?emxDMGFNeUZLU09oaFYyNDVIdG11NCtKTjduSUNDQnVaNXBqZTZ0RlFDMHJO?=
 =?utf-8?B?Tk04WUJBMU9Ec0ZXMC8wMHFBR3V1cTZ5VFlHYUdRc0l4YnhmR0VLakY2SGx1?=
 =?utf-8?B?SGVuRUM4ZkNDbjh2ZjY1ZFNwSCtkenV1RVMwZlhBaENmQ3A3MUJDTDFqN0F4?=
 =?utf-8?B?S09FWnAwQVd4RG1IaEZiVjlXcWIwWVFxeEMwV1dwSXVlYWVhMzVsWnkrZG1U?=
 =?utf-8?B?WjV0elBPdmxSQ3ZlR1ZqVUR5bHVaS01KZFRsOVJVUzFRdkxUVWxzNytUakxX?=
 =?utf-8?B?R2ZMYTVSV0FSRHlSTWxuOFZwaUZxbUNqa0JYRkJSL3ppY2pPSmMyeUY0M3RS?=
 =?utf-8?B?M1ZQbk1EdHFQNTBsR3l6SVNFdFM2ZUovSGVvY3JldENIbzNDc3BUdXJGemlU?=
 =?utf-8?B?OGJEc0kxSC9udGZjamdPM05aQngxUUQ0U3VYTHI2bUtrRDJDY2ZtbmVOZjQx?=
 =?utf-8?B?N0phSS8rdEdMM29RY29pbDJ6cU00djBLOUlqY2lxTWVnVCtyWU5HdjFCa29v?=
 =?utf-8?B?WjFhdWx4bGNvOGFYK0dZT2dBVE9WeEdOUDFtNXlTcEw1Mk1WSUhUUEEwY2Ew?=
 =?utf-8?B?dHZFYmVTZE4vR3k2Nk5peGRSMzl3NTBwekpJU3Q2bXg4VjFNNjU5WWxjZEx0?=
 =?utf-8?B?NkE3WWo3UDYwSzRmUFFLcjRyWjNFVnlCN2lNc0EzUThqN3A4L2VqTmFoMjRW?=
 =?utf-8?B?Qno3RzV5TUpGV215ZHRQMTcxNXV0UHlZUmdnWWt1alNiYWFkazBySlY4WkJ6?=
 =?utf-8?Q?sCuI=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0371aba-2592-4a79-5e4e-08dda4ff0dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 13:35:51.2174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QaCIymcKBSlDxbHWYsGMtLPBAMj/983pYBUknULuFBB/nnlIWpT2bVlvjp6qhcZq3/oIrAGrrTXH+0nJaNjeHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5233
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <D145C378488F2C4A92711F7EA36F6F6F@namprd15.prod.outlook.com>
X-Authority-Analysis: v=2.4 cv=BOOzrEQG c=1 sm=1 tr=0 ts=6842eeba cx=c_pps a=3w+TbvVJ0pkczneH0cxqQw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=fGO4tVQLAAAA:8 a=07d9gI8wAAAA:8 a=NEAV23lmAAAA:8 a=FOH2dFAWAAAA:8 a=eQTJS2EBhQidsKW95-AA:9 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-ORIG-GUID: 9nM-10N9mY17PwCGxx6N9pBY7FhENXdC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEyMyBTYWx0ZWRfXyD5RDw8bs3LK kqUDlpISF2bIUIakyiDtuIYVGx1tIstKL8TcuV/dJ1KDWf7k+Weq3XLslP0hA09hvgDACvlKb5w IZdrgw5/ReJ07gwn+/oCN5/mRUTiGwiiIpN+NEbhTRrsaX8aAmw8LLHE8Fz8m86rVDu608C7jrF
 l5iIQZuxiPdKek0muh4233EBK0gEXwONcfF4sTZd3i90e3a1VhzHDRZ8Gpq6Xc55eKvz2yZCJnd qr7QrO4mqYgxRgGIVaSDDBCii40x2w/FpA/XldODwA7YJL8JfZf0lLj3DZ/lNLw/Z+6w5EuBCMo EpscHukYRHt/ksznMEFU7GqZ92sNfenHVBxyS53B0hZYekNJOdm2+0uc84Ju2YuJYK5uvQtZ7Un
 wZctHa5ZZvGTR/pBSbEP55mU2HP0tVxh4SpstjGceE/3oTO1gySvgTbwGYP0CyCgGVdv78x8
X-Proofpoint-GUID: 9nM-10N9mY17PwCGxx6N9pBY7FhENXdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_04,2025-06-05_01,2025-03-28_01

On 5/6/25 17:43, Jonah Sabean wrote:
> >=20
> On Thu, Jun 5, 2025 at 1:25=E2=80=AFPM Mark Harmstone <maharmstone@fb.com=
> wrote:
>>
>> This patch series adds a disk format change gated behind
>> CONFIG_BTRFS_EXPERIMENTAL to add a "remap tree", which acts as a layer of
>> indirection when doing I/O. When doing relocation, rather than fixing up=
 every
>> tree, we instead record the old and new addresses in the remap tree. Thi=
s should
>> hopefully make things more reliable and flexible, as well as enabling so=
me
>> future changes we'd like to make, such as larger data extents and reduci=
ng
>> write amplification by removing cow-only metadata items.
>>
>> The remap tree lives in a new REMAP chunk type. This is because bootstra=
pping
>> means that it can't be remapped itself, and has to be relocated by COWin=
g it as
>> at present. It can't go in the SYSTEM chunk as we are then limited by th=
e chunk
>> item needing to fit in the superblock.
>>
>> For more on the design and rationale, please see my RFC sent last month[=
1], as
>> well as Josef Bacik's original design document[2]. The main change from =
Josef's
>> design is that I've added remap backrefs, as we need to be able to move a
>> chunk's existing remaps before remapping it.
>>
>> You will also need my patches to btrfs-progs[3] to make
>> `mkfs.btrfs -O remap-tree` work, as well as allowing `btrfs check` to re=
cognize
>> the new format.
>>
>> Changes since the RFC:
>>
>> * I've reduce the REMAP chunk size from the normal 1GB to 32MB, to match=
 the
>>    SYSTEM chunk. For a filesystem with 4KB sectors and 16KB node size, t=
he worst
>>    case is that one leaf covers ~1MB of data, and the best case ~250GB. =
For a
>>    chunk, that implies a worst case of ~2GB and a best case of ~500TB.
>>    This isn't a disk-format change, so we can always adjust it if it pro=
ves too
>>    big or small in practice. mkfs creates 8MB chunks, as it does for eve=
rything.
>=20
> One thing I'd like to see fixed is the fragmentation of dev_extents on
> stripped profiles when you have less than 1G left of space, as btrfs
> will allocate these smaller chunks across a stripped array (ie raid0,
> 10, 5 or 6), otherwise being able to support larger extents can be
> made moot because you can end up with chunks being less as small as
> 1MiB. Depending on if you add/remove devices often and balance often
> you can end up with a lot of chunks across all disks that can be made
> smaller, so one hacky way I've got around this is to align partitions
> and force the system chunk to 1G with this patch:
> https://urldefense.com/v3/__https://pastebin.com/4PWbgEXV__;!!Bt8RZUm9aw!=
5woVoadd383IuqBtW6VYdNfYTRc1ugI44XocnoPkA0gEjtp58o3ubI7wW3X5fzx58qYL9cxWUDY$
>=20
> Ideally, I'd like this problem solved, but it seems to me this will
> just add yet another small chunk in the mix that makes alignment
> harder in this case. Really makes striping a curse on btrfs.

This is a different problem to what my patches are trying to solve, but=20
yes, I can understand why that would be an issue. Sometimes you'd prefer=20
the FS to ENOSPC rather than fragmenting your files.

I know one of the btrfs developers has been looking into making the=20
allocator more intelligent, so I'll make sure he's aware of this.

>>
>> * You can't make new allocations from remapped block groups, so I've cha=
nged
>>    it so there's no free-space entries for these (thanks to Boris Burkov=
 for the
>>    suggestion).
>>
>> * The remap tree doesn't have metadata items in the extent tree (thanks =
to Josef
>>    for the suggestion). This was to work around some corruption that del=
ayed refs
>>    were causing, but it also fits it with our future plans of removing a=
ll
>>    metadata items for COW-only trees, reducing write amplification.
>>    A knock-on effect of this is that I've had to disable balancing of th=
e remap
>>    chunk itself. This is because we can no longer walk the extent tree, =
and will
>>    have to walk the remap tree instead. When we remove the COW-only meta=
data
>>    items, we will also have to do this for the chunk and root trees, as
>>    bootstrapping means they can't be remapped.
>>
>> * btrfs_translate_remap() uses search_commit_root when doing metadata lo=
okups,
>>    to avoid nested locking issues. This also seems to be a lot quicker (=
btrfs/187
>>    went from ~20mins to ~90secs).
>>
>> * Unused remapped block groups should now get cleaned up more aggressive=
ly
>>
>> * Other miscellaneous cleanups and fixes
>>
>> Known issues:
>>
>> * Relocation still needs to be implemented for the remap tree itself (se=
e above)
>>
>> * Some test failures: btrfs/156, btrfs/170, btrfs/226, btrfs/250
>>
>> * nodatacow extents aren't safe, as they can race with the relocation th=
read.
>>    We either need to follow the btrfs_inc_nocow_writers() approach, whic=
h COWs
>>    the extent, or change it so that it blocks here.
>>
>> * When initially marking a block group as remapped, we are walking the f=
ree-
>>    space tree and creating the identity remaps all in one transaction. F=
or the
>>    worst-case scenario, i.e. a 1GB block group with every other sector a=
llocated
>>    (131,072 extents), this can result in transaction times of more than =
10 mins.
>>    This needs to be changed to allow this to happen over multiple transa=
ctions.
>>
>> * All this is disabled for zoned devices for the time being, as I've not=
 been
>>    able to test it. I'm planning to make it compatible with zoned at a l=
ater
>>    date.
>>
>> Thanks
>>
>> [1] https://urldefense.com/v3/__https://lwn.net/Articles/1021452/__;!!Bt=
8RZUm9aw!5woVoadd383IuqBtW6VYdNfYTRc1ugI44XocnoPkA0gEjtp58o3ubI7wW3X5fzx58q=
YL4uvDpII$
>> [2] https://github.com/btrfs/btrfs-todo/issues/54
>> [3] https://github.com/maharmstone/btrfs-progs/tree/remap-tree
>>
>> Mark Harmstone (12):
>>    btrfs: add definitions and constants for remap-tree
>>    btrfs: add REMAP chunk type
>>    btrfs: allow remapped chunks to have zero stripes
>>    btrfs: remove remapped block groups from the free-space tree
>>    btrfs: don't add metadata items for the remap tree to the extent tree
>>    btrfs: add extended version of struct block_group_item
>>    btrfs: allow mounting filesystems with remap-tree incompat flag
>>    btrfs: redirect I/O for remapped block groups
>>    btrfs: handle deletions from remapped block group
>>    btrfs: handle setting up relocation of block group with remap-tree
>>    btrfs: move existing remaps before relocating block group
>>    btrfs: replace identity maps with actual remaps when doing relocations
>>
>>   fs/btrfs/Kconfig                |    2 +
>>   fs/btrfs/accessors.h            |   29 +
>>   fs/btrfs/block-group.c          |  202 +++-
>>   fs/btrfs/block-group.h          |   15 +-
>>   fs/btrfs/block-rsv.c            |    8 +
>>   fs/btrfs/block-rsv.h            |    1 +
>>   fs/btrfs/discard.c              |   11 +-
>>   fs/btrfs/disk-io.c              |   91 +-
>>   fs/btrfs/extent-tree.c          |  152 ++-
>>   fs/btrfs/free-space-tree.c      |    4 +-
>>   fs/btrfs/free-space-tree.h      |    5 +-
>>   fs/btrfs/fs.h                   |    7 +-
>>   fs/btrfs/relocation.c           | 1897 ++++++++++++++++++++++++++++++-
>>   fs/btrfs/relocation.h           |    8 +-
>>   fs/btrfs/space-info.c           |   22 +-
>>   fs/btrfs/sysfs.c                |    4 +
>>   fs/btrfs/transaction.c          |    7 +
>>   fs/btrfs/tree-checker.c         |   37 +-
>>   fs/btrfs/volumes.c              |  115 +-
>>   fs/btrfs/volumes.h              |   17 +-
>>   include/uapi/linux/btrfs.h      |    1 +
>>   include/uapi/linux/btrfs_tree.h |   29 +-
>>   22 files changed, 2444 insertions(+), 220 deletions(-)
>>
>> --
>> 2.49.0
>>
>>



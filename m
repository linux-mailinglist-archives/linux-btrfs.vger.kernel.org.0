Return-Path: <linux-btrfs+bounces-14589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02ADAD3B27
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CA23A593C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8DE146D65;
	Tue, 10 Jun 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eBfeAamJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810B1CBA02
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565909; cv=fail; b=VY2J1ipj8UneVx18M9P0SFt1+PxMKHhXF/HpFTkytj+jKhY0FeSoKUpYgnYTf3FReEYwbLZZ9Q80N0HFYOvXuo1EPtHydGCrUwp5oHzaN4cKpFPuK66SnHNE3Of6jgYYyUX+ac8iys8zmmfWHAXDeD+52hH82baeQb5LqybS6EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565909; c=relaxed/simple;
	bh=hQ2oszZWAXXUS8lf3idbLwIxwCcN6EpvrRbIuCYNAJ4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nFuf4C6Rg3LzO5/+PkvxceNbTqfr/4aKSb11WLF0OnPwypU4TQTcYh67SV/5CbQRsqwPkP5/3QJb1AojrpQAfUQtwjLgG0+/dAJhkmfDcOa0f64KW5VqEgQtH/PFz/VDEPC7QeF11PJW00F3lCjfyKJ7meInpS3oRZHkUl5UPgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eBfeAamJ; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADSYlW015329
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 07:31:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=hQ2oszZWAXXUS8lf3idbLwIxwCcN6EpvrRbIuCYNAJ4=; b=
	eBfeAamJinSG/cvksB2W6OUgt8GwLEHlMdd+vIIPKDeR25Y2CIvxMDkPdzBnm6rL
	YWZ+Ng5izUJlj6/60HDU/4w51CpR6xUIN+7ZWjN5N0jh/lXDtqWFK37IIKLqaJko
	K05mXGF5G5SG3RnhYFZUCQUXb7k3q8Ek4UWqvj9M+XKcYkRJkLkfmgfdFs/xJEN2
	NWx4eMfS2iww+u/ombzV2zbrkeKAkHCF0UwvSYkdZ7i6BhTPLHCM/1OG1f5KSPia
	TmosLdJoElIM1XYNcEv4SEyi+9j0vMY09fnQyG/opO6dzswWUdxkepSSrM0p5PcS
	uRt/zALq/gyrP7g8fYd6JA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 476fj6jphx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 07:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYBtWH6BcbFNQOqQPA0fy5/uOIZGliVuUe4Hc6EdZxyH10aRKFrkEWUKqB/+2A+6FiMl72DRH58cmOHp+IZIGqFfKEnjhpzaQRPL+bA14g3PU3sDLUHI11zGYJmcQEcuMp0eQZGx+FVRLce6/FAMKEmrbv2xHGT5+bZscCuKXbgrdH1WhTLxl3Dj7U1r+miR+gu0D1BjhgMCjrbkPeIxVWnE0f5g8CMRDjB9QThnftS+bqwNGzVg+fjEIa7QadeqQRwemga6UbfMy9Dw5NdSzzfCw3isSvZV76oky4EyhbMQVOgPoNba9WbonZzOgsNaAHzpIJofocwcvJfJkuLeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ2oszZWAXXUS8lf3idbLwIxwCcN6EpvrRbIuCYNAJ4=;
 b=X3XFpOoPWdd5L/BW+Qa+kIRK3gmR5qeHNBr6oipsTULpbBlwXJuz11+q46rTWXdAzS+S4n17LF1ABbtkEL/PRRu2jDnpOKF+sE3oUcViDFSNq+vZq2j1B8iIz7DsIdHFFp76VQVBbMYBohNclaZIA79XkqM7SUXZ5aYeUFEaO6VWR+s0q9bjlC7VBMDoOTcYe1HSjWcXJQ9XVZXSC9GA/wGCri6ALJCK0R/UB7mqyePkPLSD9zUrt0UbdhBD3X6cdq6otl+LJDRnz4ecQYDgjK2aZJSb0TVPrPFRNsnJ3JeeeEGHYS0e3wgWRhrq/8kVU328Srt1HFdfc7qSiYSe3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SJ0PR15MB4696.namprd15.prod.outlook.com (2603:10b6:a03:37d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 14:31:45 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 14:31:45 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/12] btrfs: remap tree
Thread-Topic: [PATCH 00/12] btrfs: remap tree
Thread-Index: AQHb1jY9ptj9DkqFPkuHGxeXOfmKP7P8fFoA
Date: Tue, 10 Jun 2025 14:31:45 +0000
Message-ID: <dc9e87c5-03c2-47f0-b727-43c9e1d5c086@meta.com>
References: <20250605162345.2561026-1-maharmstone@fb.com>
In-Reply-To: <20250605162345.2561026-1-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SJ0PR15MB4696:EE_
x-ms-office365-filtering-correlation-id: 4a9f644b-0d1b-4504-f576-08dda82b869d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2ViZFpYZCtwRThGRERqS1FyclhjOVV0WGRjc2NQbFR6M2s2YlorT2tESVE4?=
 =?utf-8?B?cnpYZXJhNDRyVWRjWkwycDR6QXZnS29UOEo1bThCL05CQ2xvSXBJbSswWVpH?=
 =?utf-8?B?L0gyVnNGMXozNytpV2d2VW91N3NTN2Rzd21ia01VNE82bXFtQXFRMzZRZ2dD?=
 =?utf-8?B?TWV4WDZxaUR2NWdnOW9zaTBDZWF4RFd6MnR4U2V0WnFLRGtuVlNYRllxSFEv?=
 =?utf-8?B?V1E5cjJ2dGxGYThEc2piQndaUXRBdi91TGJqOHVqQml6eWdxVlhxN3A2NVN0?=
 =?utf-8?B?S05ZaXoxckR6YXFVdTBGSHdCd1J1eE1NRVo0SXhpSHZyNTJJT09ZcmgrMEww?=
 =?utf-8?B?bm90eWNSVGtwTXFra0E3Wkg4YjBGaDZXOFhDeHFQcFNOSUJVdmE5ZkJwODBr?=
 =?utf-8?B?bFdTSjhFTkh2TGI1cnNFbVp1ekJZRHhxZWdaQkZDTWhsenN2N2RFMjhIY1ds?=
 =?utf-8?B?SGg0VW5ydHJ2S2tLTjJXVW1MdE1tVzc2YWVmTndHcGZCQTRiSkdqRWlzdDZR?=
 =?utf-8?B?SGZCVkRZMEdIR3BOWGYwSUcrdkgwZFErNDhvVzkwaEdlNmpCM2Yvd3dNSkh3?=
 =?utf-8?B?QlVPSDB4dTQrRU1WYVJUQ2grb1pnbW9HclVyaFQzbERLSGIwb0QvRUwwZVd2?=
 =?utf-8?B?aEgwbUpCYm9mamkxQ1VlN3Y2amN4L2k3U3FBQW9neGtkTFRPL3VlRkgraGFj?=
 =?utf-8?B?YkRnMStyYTFXM0o1RzROaGRLMDVTLys3QkJOZjE3aDgwQlpRK3VxNWxJaklV?=
 =?utf-8?B?Rzd6bFd3STV6Mm4zbVFzaE9Qbi8rcFFMYU5TSHhoMGxUOHdIVWFZdVRsMC9x?=
 =?utf-8?B?NmYrcGt2UFovR0N4aGFYVkY0Q2R0S1ZIb3dMM2l1dDJzMjRsQ2NIOWxEZkZT?=
 =?utf-8?B?VHdIK21LVXRIWlFpQjZuN3B6cTROdUFFaTdva2VLeXFyMU1MWkV0MDdjbVls?=
 =?utf-8?B?UlI3T0ZyY2IxQmZJZ00xSWtvZWhwUWI3NnVIZFAzYlZIcFNudU80cndFZE5o?=
 =?utf-8?B?Qno2Rk5maXU0c1pxL0YzSGpqODRRWVdYVllWVHdIbXArcTd6ZlErZGxwUWhu?=
 =?utf-8?B?d1EzcDVDLy8venVHLzUvZ1VIQmwxMWx0TVMvUHhXUUNIMXVkckxVejBwcm44?=
 =?utf-8?B?WmQ2bXU0bGN3cGw5UDl0REdlblRadGZnOHd0QktIOTZQQnZKQTY5TzRFT3Nq?=
 =?utf-8?B?cExWSXVvYUxQakM5cUVlN2RvcTJ0aWtuMERDak9nR2lMMm1xaEpNQWk1a2ZQ?=
 =?utf-8?B?WDFWU2lYZURDeFdlL1Y3ZUJ3Lzcrem9PM2VsdURqNDNncVQwS1FXcEZsZXgr?=
 =?utf-8?B?azhHRFd4eUdMR2V2RHYzU1lIdkNtT3Z1TTJwZVh1VE9rcHhuazF6YmRGQmNL?=
 =?utf-8?B?T1p2dWJNYTBoK1J4N3FBK1lJaWUyTEZmNVVxNEppRGJrUHJmellwTGZ2bEdX?=
 =?utf-8?B?WWdKU1ZwTVBFUDFJNFBFbUJKMERqeEo0Zk5mSERFVVQvN1lZcXV0eXU4M0pq?=
 =?utf-8?B?ckhYdTVkb1RyY3pXbXB3RnV1cDhUTnZyTXdKb3JJQnlFL3cyUVZKejFQUUJY?=
 =?utf-8?B?WW1ldTUrOVRpczJYSHdjeDM3c3FhSk1iNFhNK0FQWlNBNFM1b3hYRUVQSzR6?=
 =?utf-8?B?ME9CQ0pPeWtqeUp2d2lLcjRaMUxGL2REWGF1cW5QNEQ3QWZBalRtMEZGWDFw?=
 =?utf-8?B?WnpnQUdrY3RxeUJabWk4eUVVYzUwYjM3Ni9VV2R5aGRnaEtHOWN1TlNFdFlB?=
 =?utf-8?B?d3BKTVNkWUxZaTFxUkd4cjNYV0lKUzN2YnYvTDh5WDFUQ3ZhVE5maElDUkhx?=
 =?utf-8?B?dUVmdHc2Slp0TGkrZHh6aXQxS3pPeElDL3VaZUh0NmN4ekgzUFgzdWowWjZR?=
 =?utf-8?B?QVdiZmJ4UHRVZGlrMkNLVW1uc1J5cjh1MnUvWXlvV2V6MGlYQW4xdGVyeTF3?=
 =?utf-8?B?UGpHYUdXbXRsQTNZcHJMTlg0T0V0SjJ1YllmcGhXaEZwU09yVFY2S24zandL?=
 =?utf-8?B?dDhuM2JFN3NRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmJrWktyVTFwTy9aYlQrRjdvM05SRmhNdmkydjhjK2FnK1QzV0F3M3d3Tzl1?=
 =?utf-8?B?ZUFiQmFDSXFoMU1xWmtlYkxjVEtaMHZFNTBpYWFkVXY4MFNVU1h2Ylh2aXVK?=
 =?utf-8?B?aXhTaVFjdEVTRk9tT1VLaC9hbDg1bkM0ZVVlRkk4SG5saUxpcWQ3cGMzejRq?=
 =?utf-8?B?SGozS252SzhzdFdWUEdUbnFiT2ZldEpEVkNhdmJsVzgxMUx4RHJmK3BvYm4z?=
 =?utf-8?B?Y2ZLV1hSRElXdUNYMjhBeDY3M296eVpMdHZ2bG54K1h5Y2RkTnBjVDVsT1Vm?=
 =?utf-8?B?VjN5M2taTHdWRVVsdEdaMEhLd3lkOHlLZnRGVVFCUkR5ekRCdEkwVWs0bExo?=
 =?utf-8?B?Q20zTHRKQW1CemliQnZEb3ErUXFTVVgrb0tkSnVLN0hlK3oxcUhKYWdaSHEy?=
 =?utf-8?B?aEJmUU50QVhtbUhXNDBGdGpyMzJpVkVoSG5wc1FRa284Q1FQNEgvSW00anZn?=
 =?utf-8?B?S3Vqc09PakYvYjljcGFGMHJIS1R2TUpsenpPN3lFV0JSRmJ3SnlnQXkzQm44?=
 =?utf-8?B?T2wwaW1KaUlxbkQ1WVF3a0FhNVRUTVBadUxkSDY4QlJ4NlY1RXRaaUNTam1S?=
 =?utf-8?B?cnc2aXJybmI3R0lzdWR2RGQ1TXZhMHVYcS9ZNHBJU0tucVRncHFEYmdzWlg3?=
 =?utf-8?B?bTl3eG0yeFdGVUdXZzNKVndWNVc5OTRyRjBUMzlGamRWSVFrbVVYaHk2WjRK?=
 =?utf-8?B?eUp5MnhGT3BoZm4xMURXZGwrb2w1T2xRVnN0MHNMVHFlWXpZN2hpdjZKV2hB?=
 =?utf-8?B?MFpZVGJIMzlrenVZQityaWdWRFVURVNIUnpIRktyTG5kUVJjNWhzZjBXL2tz?=
 =?utf-8?B?d3YrVVVjYmhKSmVTSFFBVFdYdVE3WlU2WTZoR25LY2UrSjVtOS9FOVJISURp?=
 =?utf-8?B?eXIyM2tXclUzaENmL29HdHRlcjVsVWF6bmpEanlIeG1KblgwNEFISGpnNHhG?=
 =?utf-8?B?Yzl3VG55QUd1R2NSczVjRHA1bnpQTkpEMldGTk03bEh6Y2JoZjZ6VlhGTFdh?=
 =?utf-8?B?YkxrbjM2NWt5bzYvTDR0cHU1dmxKMmhrTGtNOVdmQnQ0TXltZ08vQjF5YjZi?=
 =?utf-8?B?aTY4anhGOXRQS0luWXM5elFrdUNzU0JZVFpLbEF6YXRUc1piQnBqdVFzRnVx?=
 =?utf-8?B?bzBzdU1yRkxsQ3NQRno3UENsTlhUNnZpdi9OUnhrRVZZTnM2TDFxSkphcExz?=
 =?utf-8?B?aVk3YTlOOU9RbFVaOGdGc1B0TnhDU0FRYVBHZXZ6WHY0U3NYSENoRWsvWnNX?=
 =?utf-8?B?NlRQL3ZXQk45Y2N0blRocHBCSjRQQnljMGxTU0llemUyMTZOQnJMOGlpdGE0?=
 =?utf-8?B?WTFJMUJDTys0clp1WTErVGhXNGxrN1dNaTVQYTNjUG1IK1J1MjRndEdJRFhn?=
 =?utf-8?B?TEtBb3JYa0g4aXN1a3licmVobjlBdFRTVmhaUUUyaVZkZmFKYTNCY1hWbkVF?=
 =?utf-8?B?VlZXSjhHTkRoTnk4WUhwL1daUldsbUpWWGZEZWNXekNIUjRqSWNOak1sWjcz?=
 =?utf-8?B?cHArTDZ5WUNTRzdqZDlacTJCUmJsRW4zRm1rb3FTSUx4V1NIUTl0bW1WRDd4?=
 =?utf-8?B?UmtIbE9HU0ZVcHBML3B4dHBsR3htN1RncUR2T0tSODRnYm96NWFZQjlqZGJ6?=
 =?utf-8?B?SEdGTndQbzhIZ3Z3OW5VcHB4bDFxb0RRZjJJMUVmeXlPdmRiQlNaS3JmTnM5?=
 =?utf-8?B?OW1ORldPc3piR3BhMUN1bzQzYXE0TlU3aTJyZFRzZGQ1WjU4VTVpTmN3NSt4?=
 =?utf-8?B?akNzTFVUODdabllrK3JWMXloQS9PMzhBU0Z1ZG4vZHJ5Nk1jWjRYMnBQa0F3?=
 =?utf-8?B?ZlJyeWo1MWpzOWZER3JvMDNKZkVqelNUakpYVHhBZDlyU0k2S1RjTFdhTW5z?=
 =?utf-8?B?YmJweWU2cERtc0d3SWZzVUEvRFpYTWdXQ0Fzc2ZoTUVuKy96ZVJGWW1IcnpX?=
 =?utf-8?B?K1ROTSt5VWpsUXpyVDlvbHM4R214TkVxa2hEVnkyVGFhRGtNZHlmVTdPUHJH?=
 =?utf-8?B?ampIeERnR1dQeVBjNDk4bVRiNWlpSVNlbk9VQnlmMTg3ancxeUVwS2tlWWIx?=
 =?utf-8?B?TVcrejN4eFZqTE1vOVJqWHNJSXdjaGFwZzV2TW1EUkhUQVlwZ2FQMmp5Mzhj?=
 =?utf-8?Q?lQjI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83C5E444F832C8458BC3BBD0DA1E6CCD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9f644b-0d1b-4504-f576-08dda82b869d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 14:31:45.1903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Df+0ykLC53bSub+GbwuRufnMsfVrmeVI8Jzso9iQJ7Q+jE5VikO/L6CDltMSo6i5oIeeNfpxLB+d6X2675AKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4696
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExNSBTYWx0ZWRfX8oJa/Z7dVDqm +ukkA1c6sEGk4MF6z3KXQxg0hdIOSR48Gx0zEbavmcu6d1/hHp2jv1U7w0a6H6o3QEGx/fxbluZ kSIZdHpFZMhdt7wXpbkxnYbMNApftrJS2G4K5R8LTv0ZyLEG4kp9VqSDX5BcrPPJ27cf65CzBZH
 dfJpX7SxnkdfqHg/ix6kGH8lsI8iWqgYcvi5ZRneQudY0jdiasizNNo7MdfqKCbOscO61jpoJj3 7JED9JZNsXDdfzxOL4j1U6NgqGnIDoF8Hs0XoFz30lp0RhSlvdLoX6HYFvGKSnxya182bmNJqJk 7sYTxINl8E1wvCsGvKXiYyTa2lh3gk3aRn3qZI/pm0FKg8fMAmyPxq09B5CSCZShvNW7YQms89x
 ukGVGNWbdLUQm6bc5uqFQUiit6q8ZQ7rdXJUasHW/KWqdFroL+Cy+H7stzDGuRN7QZOoyfcP
X-Proofpoint-ORIG-GUID: 5QUsi2nZT9Rpq_yK5zEwYr0PyINQvCnN
X-Proofpoint-GUID: 5QUsi2nZT9Rpq_yK5zEwYr0PyINQvCnN
X-Authority-Analysis: v=2.4 cv=TpjmhCXh c=1 sm=1 tr=0 ts=684841d3 cx=c_pps a=d3Zdq4q2+BwSKBEBY0tlvg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=ZcyWNXxhMd9Q1DZErb8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01

T24gNS82LzI1IDE3OjIzLCBNYXJrIEhhcm1zdG9uZSB3cm90ZToNCj4gKiBTb21lIHRlc3QgZmFp
bHVyZXM6IGJ0cmZzLzE1NiwgYnRyZnMvMTcwLCBidHJmcy8yMjYsIGJ0cmZzLzI1MA0KDQpUaGVz
ZSBhbGwgdHVybmVkIG91dCB0byBiZSBzcHVyaW91cy4NCg0KYnRyZnMvMjI2IGlzIGJyb2tlbiBm
b3IgbWUgb24gdGhlIGJ0cmZzL2Zvci1uZXh0IGJyYW5jaCB0aGF0IEkgYmFzZWQgDQp0aGVzZSBv
biAoMjU0YWUyNjA2YjI1OGE2M2I1MDYzYmVkMDNiYjRjZjg3YTY4ODUwMikNCg0KYnRyZnMvMTU2
LCBidHJmcy8xNzAsIGFuZCBidHJmcy8yNTAgYWxsIGludm9sdmUgY3JlYXRpbmcgc21hbGwgDQpm
aWxlc3lzdGVtcywgd2hpY2ggYXJlIHRoZW4gRU5PU1BDaW5nIGJlY2F1c2Ugb2YgdGhlIGV4dHJh
IFJFTUFQIGNodW5rLg0K


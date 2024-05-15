Return-Path: <linux-btrfs+bounces-5019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92CC8C6C19
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F228283066
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F9E158DD2;
	Wed, 15 May 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FrOW/Iol";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XBx9Fk+9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F6158DB7;
	Wed, 15 May 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797325; cv=fail; b=YqFkGryGEdJ3O8QFQ9NNgMwgQkHGAig+Vl/nnaDb/78tj96c4yXjrBqb4I3z+eWdrimogEc7CsRWSmYJ0y5RVsrHTP1WA49xvfvhboC2OUGaJnpA4mSchjGzRohlk8iMlghHS17eBHRLYlYCZY7f41w5kzMCe1Cd+N+hn/n4QUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797325; c=relaxed/simple;
	bh=qT25LTQx6DNT6QAWjkcPO8Zj3kU2I6PikcdSDY5rLaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uwTSYtM12DSJEzEf+XLhaVL3+HwyYpyT1ANEPwLOGNn8wB2lWBhLF+YtqI0vqwfOrJRl6lbWA0Dycn6yP8nT0ArwfWu3+HWZ5qlq75W6Epeqr+Ke5Z2PIRDjZBwC0zWMfuH3LSQXbW7sAHjAhLnj/tB+BvUHkKCn/+0A9UcyEOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FrOW/Iol; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XBx9Fk+9; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715797323; x=1747333323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qT25LTQx6DNT6QAWjkcPO8Zj3kU2I6PikcdSDY5rLaI=;
  b=FrOW/IolzTlIIDrtl7HnNaqVv/QmCosrJ7kPTx0h1Z2B+37WX9KHYGHO
   fLK0vSNRTEggGhxQR0e4UU6DhtIiheGqfCf+LjdPpukYJ3ybUM/zWy2/h
   8AOk6stnG8+l3bzs6aMmUQPrmP46PgMEPgUQkEsKhILtKvuY/1B9Em+bO
   XplHLjCsyRylcw48AikTALDTSJC/J3wcT00k+wmqqLAFQp8LpoTK7X2qa
   fDUVssN5UEZfBRyNYfRvCOmjBS1EfIy/l3P6grRF+pyJ6xIDrAbeZ0e/4
   jlysyt7bgzFWU78XReGGMmqdja5VPi3FCR1X1t9njeXceLzvzFzoN0nWs
   Q==;
X-CSE-ConnectionGUID: +p6fi+aXRS6TGzl1bg/tng==
X-CSE-MsgGUID: Gl4J9z2ITJ2h6w88zc16fw==
X-IronPort-AV: E=Sophos;i="6.08,162,1712592000"; 
   d="scan'208";a="16662199"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2024 02:22:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgBqgf85m+BImdlRzUrn94NKvsSC7XvT1kUPSnAaW+pVPOJXsNxYvqsFzo6gb2DBnmyMjwS6HiYxboB7UlsMD4j7RVCo+50AHndEUMWCI161PQbKjupYdUXLQZaHzWUHtUo64kXyATITjLk20859fO4LTXN1QGUHPXgB9q7GqvmlPPlE4YN6EMBj4NzTsRHpUIljw/2ypWtQCnlVZwWrRaPcbZiSnTqcKu2xb2XQJmFdy4VPUblsFOam0Qfjxss8JslCotpwz0QaIcnnqMYZCM8krhZkLBQoD43wcgp7B4Sj90DETPgMPqkdo/8NXR1X9BTlpc0WJxCJ8b6B73nryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT25LTQx6DNT6QAWjkcPO8Zj3kU2I6PikcdSDY5rLaI=;
 b=Qurek7Bxx0bSNt05o4Yi92B/wGBLxBGApZe6kySO6fr2+9zhoTRlhYIHYEXI4je0tjAk43q+DZKveFIkWgkGexugk+7L/y08Jk1UmTg3b4Lqt6U1sbJxhFWDMGBLNuqGVY9YEdFB2cFVTxrmOUN+nYN3b2m53ZGME/RvpqlYEAN3sq0YQa4wuKpLFQ27vWJhb36EFy7ltjgm3C+WVNyQ+r/iOfjJK/UfhnUsxAjW8BwgGJsuCoPz5aaQZSpiXRnAO2U05z6oNRyx4o6DQlOqDVWOmcoLewxl6HvTssCLUi3nOLKRZtMf4E+R6Vy47l+keVc5zqceadJXmGCojrZxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT25LTQx6DNT6QAWjkcPO8Zj3kU2I6PikcdSDY5rLaI=;
 b=XBx9Fk+9ku1kNTmNfn6fuBQttD0fLV6W5LR5gn787e0WxqhYPdAOFdcYIvi94ZKYMz7cZVCG8ycnylY5DdEDXH2i702nT8/IYsjtR+wZWIklqVw4nEUTEgZ7s1PJQvLrfghTZ0eUd+nhc2K1uGS6Kferl7Jg1zxqN3x4Oz614y4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7037.namprd04.prod.outlook.com (2603:10b6:208:1eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Wed, 15 May
 2024 18:21:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 18:21:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: reserve new relocation zone after successful
 relocation
Thread-Topic: [PATCH 2/2] btrfs: reserve new relocation zone after successful
 relocation
Thread-Index: AQHapkOaS4kFGUPoO0GvhGGM/lQaJbGYlzIAgAAF0YA=
Date: Wed, 15 May 2024 18:21:58 +0000
Message-ID: <fcd82dba-4a6d-40c6-b960-096a4f7690c2@wdc.com>
References: <20240514-zoned-gc-v1-0-109f1a6c7447@kernel.org>
 <20240514-zoned-gc-v1-2-109f1a6c7447@kernel.org>
 <ntbfehck4zi2vns3773bo7f5mlxclka36fwfphkzdnbz3k37nc@ojamkclv2w4n>
In-Reply-To: <ntbfehck4zi2vns3773bo7f5mlxclka36fwfphkzdnbz3k37nc@ojamkclv2w4n>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB7037:EE_
x-ms-office365-filtering-correlation-id: 54b28750-7103-4ba4-0200-08dc750be85e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkszZVA1OUlPT0sxN25BRWlZUVNGNHJsYTJoc2lxekZYYU1Hc1hGdWI4cjFP?=
 =?utf-8?B?eXUrSE05cEdrNURlN3BOQzk0bkJHTGNncVEycXRXZ2hQejQ3VitLMVltWXE0?=
 =?utf-8?B?NE5YMVF2QzZuYXJyWWZ2bDVjOVd0NjNrbFcrVHgyejM5YzNQQnJKSS8vZkoz?=
 =?utf-8?B?Ti90dlBnZDdsSmlKR1ZGTVhab1pwS3Y1NHNJVzJScWpmZEJKUG1OSm9ma3ht?=
 =?utf-8?B?RXJoUmZQYTkvMkJad3VYeVpBQ1hUYWk2Wkl4NUlrM1NlUllnQ3hpUjY0VjQv?=
 =?utf-8?B?dk41U1VkWERLblZuT0pLSURvelg0N0JQUjFnZlUzdmlNbTJCZWh5enRBQ2pX?=
 =?utf-8?B?ckVLcFZhbW5YS1JjV2NjcjUwWFpKcHJUeVlhc0ZvREtRckplTWFZV0xvZy9s?=
 =?utf-8?B?U2VUSGpIVFdMWnpoUHQrT3dudFlrK0JnWGd5MC90NDhxbzM1Zmc0c0F6aVRm?=
 =?utf-8?B?QU9iVDljRWFUTW5CZjF5RlJ6WXoxRzc5QXY2bi9nWlhIWGhINkFWdExWVUhn?=
 =?utf-8?B?TGhhbGt1UnJOMi9PUklac09kYVRQQnBSZ3JPck1GWDZYRVJDa0xqSndreGhV?=
 =?utf-8?B?RXRudmZjVGhkaGdnMjFnTHdlVjdLN3MxdDdKSElKZm1GMGd1S2xEUWU3bWNT?=
 =?utf-8?B?RGpHYS9Kd29HMkxvaGFlZldUUktYOHZmSStVNkRmSkF4dkZvTnI0MWN5TGpY?=
 =?utf-8?B?czNuYUx1VERvc1FJSEx3WVR6QVQ4SERLUm1tcGhmNkhQMVVkZ0VqeGJid1BW?=
 =?utf-8?B?R0pPclZVQjc5TEFrV2pOZGxjSzZMNG1Zd0xNQVBJZUhwazk1NWRXMTVUN2tn?=
 =?utf-8?B?aGhncEJYMloweVlXSk1xdlRDUFpKTXhucWIrRUJ4dW1QbGVLUVlEU2ZRQ2Qx?=
 =?utf-8?B?Zjg2YjRrLzlrcGpVY0VYMzhMUk1FVmkzdkJtaG9IaVdNSzY3RGJTTy9SOExi?=
 =?utf-8?B?ZzZGYUYxWTNkYXdqNDk0TlVNdEtMdWhqNWh4NUIxczQ3UG1KN2F0dkdHNE5J?=
 =?utf-8?B?dEZjZGtpR0dkS0xTOEY4cnc4WW9yMHpRMlRBNUY3c0RTay9XMWdGMTBvMWtk?=
 =?utf-8?B?eXVTZm1lUkwwT0FtVjNwZk9ZTW5TcWZVOFQzVFlmWjJPSWRPU1hmVDhCa1Jw?=
 =?utf-8?B?QnZIRUtKN01kZlg0QzJHUGxQazE3Q0NRb003UzZJK3oveDI4YzBDNmFVWVNo?=
 =?utf-8?B?U1dTKzcyd0pXV1VIdllBc1N2YTlxbTcyTWM3ZWpyaE40cG4ydEpGRm5wYWhk?=
 =?utf-8?B?NVZKMDQ0TzVqVlNkQS9ob3krRStjM0dUSm52aFgvTUlhd2UxdDBFVkFLbDhi?=
 =?utf-8?B?eS9rSHk1WFhhSERIVUZ1MXhIcmFjdjZ4d3ZUeHRFcmtuL3I4RDdlZklOK1JE?=
 =?utf-8?B?SkVmWmFlMlJwdWo5Zm5ZelA4azVEcFc1Qms1elRIZnk3QUtNbEpIc3FFTHZL?=
 =?utf-8?B?Tlhmc1BManVVbGVBTlNIKytJTTB2NGlUcjh5SndXc3hNMkpKWUhyMzZITHlQ?=
 =?utf-8?B?NWtxRkpxUXI2eU9sbEVWVGdUSUZjSmFoWTVlUDA4dGtSblB4Z2QxY1hlTWMx?=
 =?utf-8?B?ZXl3VUR6b2JuVzQwVnU1WUZEOGJxekV6eWN2QStHWVNFOVF1YlJ3SzRSNURu?=
 =?utf-8?B?bEdFRmRUdDlKSjVzbFBOZVpVdzYxN3VZUFIzM2ZwNWpPYThOblZaaEpZWXFS?=
 =?utf-8?B?aFBUdE9KVXJoTVpGRFZhaU1rbGhjU0dEN2Nta1crYUlVSVEwYkxKRWFvWVJq?=
 =?utf-8?B?Y01UM0E3elpkRnpuMjlidFJHRGo4b3dCZWJxQURBYkYrWlBaVHdhRnVNQTQ5?=
 =?utf-8?B?S3g1VWFnaVVqODFGNy96Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zmo3Yy9Nd2ZFTnpUek5vdFM2clJ4UnNyQWZFZWtjTHpMY1NtWnhHdDMwSDFS?=
 =?utf-8?B?cThudVJrcFJBNkx0NGM5ZmM2NFR6ZGdJbkQ2SWlpODUvU2xGendtdEJZYnlW?=
 =?utf-8?B?ZUVxM0dZSzdOUEVkVGVwY1Z2WmgzOGJnc3pYWVV5RlgvZ3FUZ2p5aEtCRUVC?=
 =?utf-8?B?T0Z4S1hZWnNxQUxPY2krSWQxQkpkZFhLSTY1L0tCZWhHT0JURGptZmR5V2Nl?=
 =?utf-8?B?b2Iva3dJdHhQSGNJRGZkTDhnbWtvZnQ0OEtDRm90bVdveDNUVFZNZ1gvQ1Fj?=
 =?utf-8?B?ZlNQL0pBbzlLRjFwRHVBd2gvOEVkOGlGSXFmTVIxVGxydStTbnVtd2VOYWVP?=
 =?utf-8?B?andseGVJTTdXY3k1a3JzY2YyWnZrMlJKVzV3b242SUVaV3dDK05MN1JUSEZX?=
 =?utf-8?B?WGIzWmh3Ny9rR0RnbkxweVk5b3FEb0FOSHJ6Qy9nMGx6S2k1OHd1RHJWMm5p?=
 =?utf-8?B?WUtweVlyTG1Kc3lmRFRxWFdFK3JmQVNNbUhIanBsWEllSkg1d0xGTGxvVE83?=
 =?utf-8?B?eTNKYlB5RHFWZkJEbVExT1RtN2Q0YW91emRXQ0hPVW10czRWdjRmeXFGbDd5?=
 =?utf-8?B?ZFk3UVJlYzNJeXZmTVlNYWhKOW5UaVNXYUFsVGQ5Tmh4OG1WZ3BFMlZMUEFF?=
 =?utf-8?B?TDY0bXFjRmxTbm5SNWh1bVg1YzZXQnRZbERudVJhbERmOElHWDJDVFIwRlNG?=
 =?utf-8?B?ekxrRnNoZnVuVGdkS0FiV3dCbFdjOG0wQ2RNb0g2UEs0L2hDZExwK2Z1RUhn?=
 =?utf-8?B?UWtSUnl2aHN0Rk1aZTdlMGFYTVM5TmFrWmViVlBoZ01VWTRrRnU5V2lNVGRQ?=
 =?utf-8?B?bEFGVDFhcEVVTG1rN252UFVyS21LYnN4ZC9GeWJ6R1lnTkhDd2NqdW83RXE1?=
 =?utf-8?B?YTVGT3d1L2c2VmQvSFNDTzVZNXQ2K0FSdHBEbS9tcFNNeE5kQXhKSEdqWDVX?=
 =?utf-8?B?TFpMV25BUkJJSkZaRGlRWTZ4bVpveWMyb3BxYkNYRnYzS21zWnk2Qk51bkRJ?=
 =?utf-8?B?NEt5TFNiWE9WdVVjV1pMRU9WeTdMaHFBNG1yVmVna250K250WVh3K0R0c0tZ?=
 =?utf-8?B?NDZCSnpJVERTbEVuS0RXZUFtR1QybDNZNm5MWGtJU3Q3Um9TWFVTK2tBa1Vw?=
 =?utf-8?B?VnhoQm1uVHduWTNoNkFIY0JuQ1RtZGRsdDhUVTg2NitxRmUzOGJib0RIMDNr?=
 =?utf-8?B?MjNVRDhpS3dWMXBxNmd5Zk10NEQ4SWI2WUdSSitMQTA3MGp6Wm1hNkpaT3dB?=
 =?utf-8?B?NGRvbnQ1QUhnN0FnRHZ1MVh6U1ZpMzdWa3hkOENCWHh6bUJjTDM0bHhnd1p5?=
 =?utf-8?B?NytZSmVYYTZvL1RDcGxRTjBicFFGcHBGYnNCVWlEUFhtd1JMU2p6b0NIWStl?=
 =?utf-8?B?d1JpWlZSOGZtOHlHUjlOQmdpZmtsQ1N0Y0h2SEkvWUVmc05Ka3dqMkJ5NWhT?=
 =?utf-8?B?VkxZK0xwa282NWpqMzB4Y24xRWtZcWt3eHR2eEtKdzdCeHRNalJWTTFicmEz?=
 =?utf-8?B?UXk1SlRhTWpuR0lGcHZkR2hJam56ak1CMnhoNXREb1dMallLMXUydGx5MEE5?=
 =?utf-8?B?NzFkeTE5NWdISzN0S0J1WTIvYVZseGtZZWk0cGJ6eENWajBHcFZPUkxnd0pD?=
 =?utf-8?B?N21qNmdjcmc2MUh0bFBleWVkUUVzL2RnMjRIQWRlZ0VPK2FKd0pXeGErRXRK?=
 =?utf-8?B?Zy9HRHFLWExkSHdmQVhqMEQrN0hsSzdVN0x4eGpraEpuNVd0dDFsVmZlVWps?=
 =?utf-8?B?enBYQUhYZ29Ub1g4c1N4a043U0Z6TGNwWlNrcnZXMWFxek1qczV5RmM4K2p6?=
 =?utf-8?B?WDR3bXl3NitGOXNkYzkvakt0YkNrOGhiUVB4R1RkQlVXME5IVmZpODQzUStp?=
 =?utf-8?B?djJVOU5XaG9aWVNsRUZvQTR3MEs2NGNCeHZoVjNxSzdpWmFacThrUmNLRzBj?=
 =?utf-8?B?bFFLRldPaVlOdVZvL1pTYmpXRkVHaUhlMTNxNGpMRVhVRCt5ZUp4ZFAwOUZM?=
 =?utf-8?B?eC8rU2dvUmRLUW9Icmt3YXNLbkRXbkdIRU9NQWZOQUxaMXlxclIyM0ozZ21E?=
 =?utf-8?B?YnBWaWxIRXhkQ0FjcURJd0g2MCtEbW1XSFRCOXJsQWpIUW5wcFhDSWxHNHdq?=
 =?utf-8?B?amRXOUpCR0trTWNTYzZDTnpSblREUHovSjRkRXB6TmFMVW1WT2h0Wkw3bVB6?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AD723213984E5498EA5B3887C6906C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NL2w+XF5U3T/40WJ8TkxPRU3IvFaGzbOSYo4JowEIB5UpPx+crDU8KsNE7/1OFIDiqnNZ0sn9aE5snhFYrWVxG6C/TtwGIZvlSYjcl/Va6wxhGvT8JD0z70ErC/YRMseXUDmLo+3r90iw08f4P+/3EZQBysXzW546iojkIpKJZxTwNo235nOfGtCIPHpAf71BdLgCxT6/SSL/vxh6SlRDE8pZA9PPmn5V3cH99ooGgTed0cyoHbu907/60hDmmKutwB0PkHZUfMowoVYy9j5gKImQZcy3/jOmckVtkW1eV4WZjImwAD0+f8P1KG1njApjyaBTn2AmRmob1Rv2CqiqaU0P7NQ3w6xhWifuZsSGZl8pXAFMgqCKmcWpq+6D24fpRwSuZCg/zu3LgPayQ2PBd3tQhJoV48jKFBpwCsDGCtnlzqpWnD9gag3J2rv3ZSM0OY62edCrS4abSz9djqKuGMFtdq/EaGQ++L5KGxAQQD6gFwTszIUlFU1VBcM61RHyYmBdvOKjrwTkGeWTJGOwOuhIlbVw24iReLCTRQ/qFJ/71jOSzUsTOz3P0iCNXwg15s/BMfdTvXiZWrARpWXjM1ww8NbslDkZJIbV9IWqvDVLsql09TGfWWWqeLT9sB8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b28750-7103-4ba4-0200-08dc750be85e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 18:21:58.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RpqHLzQD+s1m3X7gg3M7t/yCjGmsmbMctnmXhsXblhJcln5opE/MxzuOx4ebygePDEOUBVoPbJgVXzjVA+ZUgcvJVgGXf32lgDMst1gVSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7037

T24gMTUuMDUuMjQgMTI6MDEsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4+ICsNCj4+ICsJLyogV2Ug
a25vdyB3ZSBoYXZlIGp1c3QgZnJlZWQgc3BhY2UsIHNldCBpdCBhcyBoaW50IGZvciB0aGUgbmV4
dCByZWxvY2F0aW9uICovDQo+PiArCWJ0cmZzX3Jlc2VydmVfcmVsb2NhdGlvbl96b25lKGZzX2lu
Zm8pOw0KPiANCj4gV2l0aCAiaWYgKCFlcnIpIj8gV2UgZGVmaW5pdGVseSBiYWlsIG91dCBmYXN0
IGluIGFuIGVycm9yIGNhc2UuDQo+IA0KDQpSaWdodCwgSSdsbCBmaXggaXQgaW4gdGhlIG5leHQg
dmVyc2lvbi4NCg0K


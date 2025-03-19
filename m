Return-Path: <linux-btrfs+bounces-12424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C413A691F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 15:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283D51B82C76
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC061CAA75;
	Wed, 19 Mar 2025 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X1ugxvg5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ATxuSrSb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA41C5D78
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394373; cv=fail; b=ZkuPTYI5zQd4Ek8n6Qo/k8mPlkmBlRJn9LKZ34PvPbDOwdUYhGXSfacd61fFI8E8L+hWDH7JoN+fAh6sZlN1JgHTvpvevfObwDfFqIOSmSQrZHGEzQlQzuEvbDOTrwU6jDbSCi7Pu6NuZ0YDASVkcpeu+hcLEPlqCVx0qo6xpmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394373; c=relaxed/simple;
	bh=LrMj3tORVX1zsms1nU0P1OBvanAxJlbhx2eUyHD/YdI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RJQhmP332XF+vp7d6nXbDw1+3GE/2fm3Zgn9RXmj1Vg/RpRg/VwTZpzCq97CNrtoRqBsaaXK+pv1yJpVVDnLcLJHCiC+jI3oTfYC8wVcCL9Z6U+GlWMyqjd+kABNkNsYn1LZ1R1yEyGv6TCtpzSvTk6SlOUq5oEeaGhRvQm4ulE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X1ugxvg5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ATxuSrSb; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742394372; x=1773930372;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=LrMj3tORVX1zsms1nU0P1OBvanAxJlbhx2eUyHD/YdI=;
  b=X1ugxvg5aZHv9PRERK9LLh8vMogewhbf4eXxdAQc3+lLuUNcWJSuHblJ
   V1Xyu3ZLHPmUQwpcEEJb/CJTOUZ2Whj7GhiVbVw+fX4rYqs/Zg9CKIJCn
   dB9ixwlUto/ZrHQ7dtutIpcKGcB4f/929BSAH7R2ijloODgPlpN/jlFhD
   ZDu9yaoFTTo2AKS6wvGL5auJuiRweIhsacLYop8E/InhNkl7AhuGR0Wn2
   qLL8xfl9BNbI8G0FWpD6jE4FWDopKX6eDXw1WGVoFmVWLFjAta59MPm/2
   8p9HifOsH7a+ACzxf0DyTfhhZFgUr9lDjx2FesTSzeFM0x8sSZrzqjBDa
   Q==;
X-CSE-ConnectionGUID: 4yI/6m3BQ+qpQ88lk+h6HQ==
X-CSE-MsgGUID: BFS+SIE7Rlu7eu4K3b08ug==
X-IronPort-AV: E=Sophos;i="6.14,259,1736784000"; 
   d="scan'208";a="53493662"
Received: from mail-bn7nam10lp2044.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.44])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 22:26:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb9xVRTSRK0nIPF49/A7XZqqJJE0fwdh+fJPQnfHaO/pK6JVys7uehk7egYhzechkcJbcYoY4vdqTJW6YNBLztz13wuR+aKWOR7lrZP4iAGWwHDvQQAsRlpjK+X02GD/fGhirbVJ7HjyJziMqw8aFTlhESqXW3y9SANQsCESwfj4Qs5Onz64zYq2EWWs7TkqdeFOer6ye/vVFOTMHDFNiorwvJPNIa4fJEs2w9ZXaPViQmwtDX1L0e/2Hffn85PRQivIP/CcsT6n+9Pk5YXzNhCPyt1tg0utVrMO2vnXnZSokS+o7+sMuRQ3BuLpD6uqTMRaE883A4E1Rkbob1F4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrMj3tORVX1zsms1nU0P1OBvanAxJlbhx2eUyHD/YdI=;
 b=a+RMG1eBLz8wQeCe8nxNQ30e3ZNCT7XW8BWo4wKMtJszYwA8Qpc0kj4QRPFZnoU7TmTc5lkr3isJkyU5Y2O7lacYw/fR7oKO6RSHm9+ojoniSV/pIYjsW7E5oNswEHI8+HyRRkW/pSZkkV7yKPfkombKMBdEtnB2xLpBzxrA32h52wv4dpGAgfGVqRhNWVV8XSZFYhqjbz2YO5AK5I3es4dsASi8oijvyw8wR+yXj42dCeT8LnXv1VGyO3qBrdyx6vVavl22QCjmVfFT4l1oPoE0esQjRCiZ99zKTpoL4gI5W/iG+6riCLQl1kST05T9oOaIkCXEFMCWhtzNOuiMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrMj3tORVX1zsms1nU0P1OBvanAxJlbhx2eUyHD/YdI=;
 b=ATxuSrSb8EvYgbjmfomN1YXZlaCF0/ZCRPxEypQOj3UJmXf3KOOA1S3uERXRTTLa1H3WPxKxF3PWUGaidmsL02DwfY04mJFbFQeco8KsZmGpA06tgpUXTtyoJ0wT0mg0g3r9xFqfwDYez9FOonrDAhTBJhsKED1EY3Bzv5VJqfY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH7PR04MB9527.namprd04.prod.outlook.com (2603:10b6:610:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:26:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:26:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <maharmstone@fb.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove call to btrfs_delete_unused_bgs() in
 close_ctree()
Thread-Topic: [PATCH] btrfs: remove call to btrfs_delete_unused_bgs() in
 close_ctree()
Thread-Index: AQHbmB59MPKes5QK4Eaf6PIrV+yclrN6hXCA
Date: Wed, 19 Mar 2025 14:26:02 +0000
Message-ID: <e2c0e2be-9965-464d-8df2-73eacc95cc4e@wdc.com>
References: <20250318155659.160150-1-maharmstone@fb.com>
In-Reply-To: <20250318155659.160150-1-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH7PR04MB9527:EE_
x-ms-office365-filtering-correlation-id: 30c5b629-a8eb-4c55-7cea-08dd66f1f9f8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RnBSTGFGRkJZNi9QQmNoc2ZVRHNpc0xISzlieDFkVVNPQkpjRDFJNjkrTEs2?=
 =?utf-8?B?d0tkOENoTldwU3RtZ1RyblBMY1BPZXV2akxrQnhVMTRHMzFIQnlpOFc0NjZK?=
 =?utf-8?B?eFVINytrTGwwNlI1QTQzQk9vb2FodnhzVTNESGs3TFEzVDF1aDN4K25iT2ls?=
 =?utf-8?B?RmNXU3E5akpOTVJmN2I0RzhPU2R5cHlJVDc5UHdINjVDazZpV3Y3aUVNL1dh?=
 =?utf-8?B?TzBRRTZaMjM3Y0hhaDdxVFRVYVkxYXh5SkF1bWhaRnJtTml1OTY1M2dyRzBz?=
 =?utf-8?B?ZlNzT1VrZnAzRllhN21uZGlobnBhL21tWGZIaWhhTGprZTNBM2RHRlhPU05j?=
 =?utf-8?B?aUFaTS9oSlN6WGt2Yld4OVRlc0pKeHJJWnYrOFY4NWE5dnVRTjlnbXpFRHpq?=
 =?utf-8?B?MzhpS1J4SElVdGFOd1A5VDlMOXpmZXRxUm5EbHhDdUpLdWlCYU14Rk52dzhU?=
 =?utf-8?B?TnFhUXAwNzlFbWMwNUJXMUxlMG5KcDg4dUZKMk9INXRPWmd1ZXVqcWxFdWJG?=
 =?utf-8?B?OG1LU05JYkhFZXlXWTcvRUhQemZtSHh6eE5BcTVocTBVWG1sNUpLZ3FvdGFL?=
 =?utf-8?B?UFl1YmJFUWNDVTFkaG9BSXpLUlZSSWxVRlVhcTZsbWxyUUFBSUhJT1NFaFJO?=
 =?utf-8?B?MzB0QmJXMDNQalM2SFNLc3J0bldYUllSZVFIa2cwUWhIODAwMTJvZEVwcjRC?=
 =?utf-8?B?bE9YbVdnbW51eW5EcnJYTm1zaEV5Z0ZPa1J6Q3ZkWW5XVDExTldVeEFZOE8y?=
 =?utf-8?B?Ync0ZlpqRzYxa0tDbkZXbEZtS0FhSjBSb1BZd28yVlZmRzNMRUdPNzQ1VnZh?=
 =?utf-8?B?eUFNeDJEREJSOVN4SmFrait5c09GdVpzbkNwNkplamdrQVROMjI5MTVkc3du?=
 =?utf-8?B?L3czQVdlSnAvNm1GL1FFN2ZoNGxKV1BGT3l1ZEtNYkdvZm9HOTl3QVdDejlG?=
 =?utf-8?B?U0pXVnRVYkI0bzlIRmhKMnFIYnRFVk5JMnlBUjgvZ0tJRUdodlMvVWVqM0Nh?=
 =?utf-8?B?UlR0ZFhKcnMwcDZaSUZGcWxTSHFwWjZLTG5WTmx2cFNEQUs0bGcvRFJxdG9n?=
 =?utf-8?B?ZHYyNzJCYWRWekcxWWlCWEpjaUVEa3RZOVBrUjZRQ1NLUW95NE8wbjNZR3V6?=
 =?utf-8?B?Zy95MWErcklPQ2tnR3huWUJPYlNpdlV0b2xIWlB3TitsREM4cS94UVdRZmw2?=
 =?utf-8?B?M1poVVgzc2xZZ0dPS3kyUnpYVjQ3S3o2VDhZdE15QnBwUWlpckswNnRYM294?=
 =?utf-8?B?WWdnOU9IVHFYQ3J6dFRMVXpoRmxaK0FKU3ZaandrbmhXK1NvQ3A5Tm9WZUJv?=
 =?utf-8?B?MUtRT0hoSmNIam9JTWxSM2tranFlU3lnN1djSjkrdmFsb2l4UWtMS1FTdjJM?=
 =?utf-8?B?c0E1bUFlL0ROdWFzSnR2ajhRWWdRVzkvYkFYZ3lmUGlRSDFpQ3Y2SjZRTlNP?=
 =?utf-8?B?eUtFS2ZhcnBGRnpwYzFsNnNXY09iYkJaZHFvcmhLVW9zOEQyRHAycEtqSnVZ?=
 =?utf-8?B?U1BxWllsN0d5UmpTb214UTVFQVo3Z0dycTNyTllIRjdsQmVtTlJyMUVGWHJK?=
 =?utf-8?B?SFRONmJGRFJBUDhRYXd2Z3diVUlOY21RRzlibnR5N2JCTU9YTVlZeUdTSXhF?=
 =?utf-8?B?UnNzc0RVa1dVRERoWlQrQnozVHk0NWRnSitjT1lYcDNPbDhUaWt6WENTM0lC?=
 =?utf-8?B?bkNFSHM2MndTTGd2OU82K1pTUmUvY21PMTJueVBKaFE1VDBwdGpnS3V5OTRu?=
 =?utf-8?B?S3RiTGhvQ2QwNmNTblFZeks4dm8xOTM5V090cTUxdlYrNFMrbWdGU3VTSGxK?=
 =?utf-8?B?bytiVjNWT2MwMmZOY2dNMnoxMWNEcUhIRzV6L0Vpek54TjdXNk82RDEzUDVj?=
 =?utf-8?B?N3U1bVN3bit6OUJDT3BMaUFzN0x6Y2tpd2tOTUwzaHk0aG5kbytaQ04zWVpT?=
 =?utf-8?Q?uDmcfTzCyE7KXkw5brsUJ/M7NHp4Y3yC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXFFRlkrT0tBbGhRVElsdlQzN1ExdHhabzFFWjdaUDJtNlo2Z0hoMnZoQ1Bo?=
 =?utf-8?B?M0RMRGFHdGk2UVcwZEtjMjJpMksrWVJGRzMxZC91bDdYYXd5SnBaeitaRU9M?=
 =?utf-8?B?UGwxMEJuOGx1S0wzQjRPLzd5TXBwbS9Wa2Q4aEdWN29YQ3RRYjRFdUtSVnNx?=
 =?utf-8?B?QmlYT1FsZ25QWE1jU001eEN0RHdwUVBnZUVjU29JcVVpVTFuMkp3RmZOaEN0?=
 =?utf-8?B?cGw0OUlUODNleHQ3Smh2bXMzZ0w2WjZqYXpVVloxZVhDYUlDZFhiNSs5T2NY?=
 =?utf-8?B?SVpvTUhRZ0FwZDZwOGhlTWJ2Y2hEazBSVDNpSjkydlUxcXFhc0E2c0FlM0FK?=
 =?utf-8?B?aUpFTFk5T0FLc0dPM0xtaXpFYzc4Tm94MmhUVFFMdkplTEVOZXJmYUhlMjJL?=
 =?utf-8?B?QTF5cFRtNkZaRS90c2hjbDBBZ0cxNitrMUhQU0xGZjJMLzdjT1NucjJIUG93?=
 =?utf-8?B?UzdnbGhPNW1ZR0llMTUzTW15a3AvbzQ5Yms2L3l6NWI4RGsrZXhTNm81RnVp?=
 =?utf-8?B?NHM0QW1TTXQ3RnJibDhBcjJZODR1aEI5Z1dUak5yRjJPQzFiT1FpSlM1QTdL?=
 =?utf-8?B?Y0pHeW9PUUdtQk82cVF0NHp6ZFNodVhpZXUyOG1lb3dTTWN1Vm9weU9VSlQr?=
 =?utf-8?B?YWozL2pTNEkvRGZyd2V5VG52TVU4WnQ5cnFwYmNUbFpNUmdrUHV1Nld0NUpp?=
 =?utf-8?B?em5oOU9RTkhGcUZ1LzVRRlR5aG8vaTMzUW5jT0VzRW5oeTF5YnQ4L08xZnAv?=
 =?utf-8?B?V2xFUTdvZzF5R2REZWJkOEo4MXFROXU5eno3NDdzYzZ6c1MrejBVaXV4Y1hX?=
 =?utf-8?B?R2xBVTJCdSs2UGJBN3M4S3RYYW1EZDBhUkN0MWtlRldYVlliM3BDdVZPYWN1?=
 =?utf-8?B?S0NmdGhDNEpiUWZKRDNqeGJUSi80YVBRbEhxRFFNaXB3RzZvdzBpWHRFeXJz?=
 =?utf-8?B?TUVTN2FCY3F3V01TYVhBNElBMTRsSUFvYVdZby80Z2hHKzY3SGM3YnlFVEhF?=
 =?utf-8?B?SVZRdTlERzR6ZXBKWE1EN0YrUTdCM1N5Y09iMWxqc2hpbml3SmlpU3g4OVR4?=
 =?utf-8?B?NE91bnFLQlBwTnc4U0V4SXQrRHVOQk9oSXZ1ajhzRTZ3QXlBc3ZqV3JVc01M?=
 =?utf-8?B?YmZLNitPS21zaW8xTUxKN0hydnB4NHdLSDJHOCtiTXJuc3ZvQXRsRElOTzhs?=
 =?utf-8?B?bkFlN1J1MnJ6cnpvakNWeHFsUHFHN3pTd2dZUk0wVk1taElPeC9GVnBMRWc0?=
 =?utf-8?B?dTl1V2ZSczZ2WkU4L0prZTNZbmJ3T1dXR0VXQnJQSUtsQjhyNkxVUElucTdY?=
 =?utf-8?B?VzNJLzF4cWpYUkR0T0RBSFdEQnliWUlmRzMrazc5U3VsYjZncjFVSkdBQ3F1?=
 =?utf-8?B?dkJ6YmNBWmRhZGplck1aQS9IZVRab1pPSVVSaGV1VklzUEwvek8vaGsyUlow?=
 =?utf-8?B?T0lmcmxBbFRTaEFLcktNcGpOVVNYck9RbHRZNW9nRm5WR0ZXRG9TV2krSW5x?=
 =?utf-8?B?dmh1SnRlMXFkWWRsZSt3ZDFSSS9lUSswbVAraTVxTlNpMVhjRlk1UlRWR1hl?=
 =?utf-8?B?ZTc0b055VVcvYnJiYUc5L25MaEdINkQ2eUdib3RjQm5MTi9vNVJoY0Q3VXhB?=
 =?utf-8?B?N1o0K0ZlMEVWZGlvL0N3andhQWpxdGl5SGhSOSt2dnlLbzY3STNvOGx3cDZU?=
 =?utf-8?B?YWM4SWE4czVDclIzWkFtK2ViUmdSN1JFY2E4ZWpUSlljbzNaVHdwY29ZaGZY?=
 =?utf-8?B?a01hemNnUkZDdjErOWM0L0JiNExZK0tTV05PRHRDVk9QRmE3cU5zS0hrTENN?=
 =?utf-8?B?RmZzdm5XYnU5czl3RDZlR2h2cVBtZWRGTjFpSm5WVVk2QlllL2p6MDdUeFdL?=
 =?utf-8?B?VW5kV0d4ZmJtTllDc1hwNFlhdFdtNi83T1dycUxlRzBxMU91clBYdENOa201?=
 =?utf-8?B?VmNGTGxOcTZYYk9tZUhCcHFSOEtJRzRCNmN1bzd5Zis2S1dYTDdlV3A2RkRX?=
 =?utf-8?B?UElyVk9MWVp0eXVPd3lQQStWVjFObjI0UmVPUEhGN0FqUkJrRHdmREJpT1FX?=
 =?utf-8?B?d3lQZ1RGWklNYUZqQlZ1WmlUdENCZEVnOVp3UERSOEtMOXRzYkJTNjE5bWhT?=
 =?utf-8?B?ejNqYmY0cDhYZnF3Z2tJa1I1YjFLYllobmdqOHowRUlRMXQxRlA3cmpiVkdl?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29405D05C08D8244980D19FC42169AD7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3/tLfmmi+EYOORuLMwbcH6pV+P7jiiP8baf8QkrcBRenRObDuiyN10KTfs9t5IrmQBWJ0teAuKQYZcxLlSLXyOQq6ccO28E/uSpgSF0CqWrJ9w0mPRnjWzp23z/JewSwLFJo08DZW/rWRYgSTo1ed0zM3I0NsrihyEATnklpNXWnFYDHy6s6KkqW7BOOVxX0TrgWDkqOIDYQDL1YhacAXpb9XiSmyhEj5BhIB7U91BSWQ0STICkRe/kdF4U+/+1l7v9JLAAA51PD1heqWcHj/JAkFyxgquVIMJjMawCP/JtE2y5NuoS8HJNXs85a4l0cXPmaFDTn0oV/QkD/XH4BoVVQOvgJlaa+yeqitxMUBMqv6KNHlXjdJIV3hzxpBFq8UyMpOLrNl6t/5tQo+qC0PBg/2wDOAoVN0Oz3DhB1YLXX7i1xd5r/0SPY3C30RwsI4e36Kn16KXoOXFeHddLcjJ2ZATlJhdXyC4V2JFOl9j451ze9Yh+rtdMgu4N7AhP3P3Qf78pvwGt68RzqrgesqPJr/V/+JggoMmyOY1R/eVc6dFYKgckYnst7P5w7vxUf8PaHqQVer3tp3P7noFotysfhH/CbTNH1tqDKiB3rk6JBQoWJg9ilyVHyw1Z6+WRU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c5b629-a8eb-4c55-7cea-08dd66f1f9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 14:26:02.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8FyPw8sl38P42vivNQCszh7k9zVQH6k6d2skx0hl8/8ZlUWSd+RSErAEVpe2vbVIYBBX4sg6K93eZZejN/Az5/MwFaEhh4ZvGQmnK9XZ1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9527

T24gMTguMDMuMjUgMTY6NTcsIE1hcmsgSGFybXN0b25lIHdyb3RlOg0KPiBidHJmc19kZWxldGVf
dW51c2VkX2JncygpIHJldHVybnMgZWFybHkgaWYgdGhlIGZpbGVzeXN0ZW0gaXMgY2xvc2luZywg
c28gdGhlDQo+IGNhbGwgaW4gY2xvc2VfY3RyZWUoKSB3aWxsIGFsd2F5cyBkbyBub3RoaW5nLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTWFyayBIYXJtc3RvbmUgPG1haGFybXN0b25lQGZiLmNvbT4N
Cg0KTG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVz
LnRodW1zaGlybkB3ZGMuY29tPg0K


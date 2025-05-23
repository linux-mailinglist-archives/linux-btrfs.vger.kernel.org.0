Return-Path: <linux-btrfs+bounces-14189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAC4AC236F
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 15:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DCA544490
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 13:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FA11487E1;
	Fri, 23 May 2025 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CtBEzvqT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FF130E58
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005567; cv=fail; b=TOB/3kV340gwfsSUmlDnq2RCJ6RsAQF70AyY6wwSJZOyszatW2ZUuorJKtuNJykmofk/lcaSWFKvTKBifbciurqs6WEvB3vVTjnggFvjd+o3HEDHiV6kEn5/0eoAPPnbu/3PBkdHIvOeg0sFRePlGO3kNMn9rR3+TmUzIkF/BDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005567; c=relaxed/simple;
	bh=/ZeK4+PHMhsUfqrmxu1o/24MBhGIDb6HHrNiadyDti4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BXVpwk3Cy+AAJKHOS3iEKaiSA2SV39Z1IckZzlh+RDWaK9nkTYIvCjQAt8DI4hIQHD3jGx2mfDWMXesWDewtqW+uoMHON8i5oq0wluEPmlPDq6yhOLtpO7BaUVlrbPSggVrnSTP+8CL8WXVAmn43zEuEwEFBykasYj56wAoj5+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CtBEzvqT; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N2xtU3007141
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 06:06:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=nsNqjjwJhR8q6e68bXdUpCYOogNRkjgB2YVB/2Y0smY=; b=
	CtBEzvqT1/tYPLA7weywaXHjlGlnjxe0pt0Dx78baWOGuEx5UKJXDhR1z/XTAYSg
	McCP/x/NL1W/BJfuajjpDAeDdcoNmWtneDbVQSsjkF3/+guE2wVO8KG1xvPWjTHC
	0K0QM8Xp/ULREdvmRIY/XTsJJCpcONbhbHs31mmiccGGoQpLBgHJuBSQaRaVMBX8
	rFqNLtHVRtyNgCEcpqfLsRQorEuTehI4q9THXoJsOs08W365HYtbCPzhh9XfyiF6
	DImvQZrht26Jt1tiy3khMfEuj9tcDyBimQqyBzAshQZLqJr9DJF/FASnxQuv4fYT
	wUZX+lGR4OFB0eQRRRbVVg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46tgputvd9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 06:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxgDW3JpJ1+Fshhdv2FXqQf79HeHHt2P983IoFWQtIoCfRDpD7dQhWsYcuLjvg2+ZsSY3FnGbDH2DZozThllMJfWCM+QSYakF1KTXRMXOkMn31N3jPR4uunTk+c5f/7A1waW5+fAFQxHO8tHZ+HvJEIu6glcNzhFKDJv6zVR0lZbJ1xnDLS0BcYqp0daZ/Iie2GlCWl5aP21S7T5leg6zY2RydizSfMbD1gqnlOkubLcVY+mrjy2X492+iVzeikK1S/vtt1GZfp9iZ337UCFtIVlqGkEL9o+W43pYNO6b134UT55Rx9pDbQoVSuH/8TIHitio080lsLkfIu1Z+VY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhURLaOjl0pEpd20pRFeyGwmRMKtMkugUYFpfhU5Nlk=;
 b=EnhyhV9DyVXChXb3WG9EHzVl2TC0vN9FlT9wGw6jNyb5LjcBB+b/IXJ4F03av98WanmP1nz+logAG++N3yDMyN1gACH6rI8ZSu48VOpxBKTmrCCzhsfdA0IiUgOYuJASKhNH8R/coHgq3sy+/U0GZ4vt3SpUHtQ1un4gPryRm3YkZOmmbUqT44a/3OkuqIcSAJ4f+MAmLgqGyZ8IgAoD6zH2ehsUMIV4kMC/26DU5BeeRufOfrJMUqOs1J+DGRgXXo0gUI6ps17q3CJJAo0GpeIOr2K+KzgALUGRa84rpBinpVEt73wEXWqL6EQpsPhTNMrKGpDYw3oTt28v6PHsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SJ0PR15MB4203.namprd15.prod.outlook.com (2603:10b6:a03:2e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 23 May
 2025 13:06:02 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8769.022; Fri, 23 May 2025
 13:06:02 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 01/10] btrfs: add definitions and constants for
 remap-tree
Thread-Topic: [RFC PATCH 01/10] btrfs: add definitions and constants for
 remap-tree
Thread-Index: AQHbxbeQVAOB00nJqkCyXP38nyghRrPdEJCAgAMq3AA=
Date: Fri, 23 May 2025 13:06:01 +0000
Message-ID: <1196209e-7fd7-48a7-868c-af1656ecb7db@meta.com>
References: <20250515163641.3449017-1-maharmstone@fb.com>
 <20250515163641.3449017-2-maharmstone@fb.com>
 <33145376-05e7-427a-a20e-6933ff0b949d@wdc.com>
In-Reply-To: <33145376-05e7-427a-a20e-6933ff0b949d@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SJ0PR15MB4203:EE_
x-ms-office365-filtering-correlation-id: 78efe713-0841-4b7d-36bf-08dd99fa9197
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzIzTVNWWE1xZFpRbXJyQytaenNUTzkyM0hLbkM5MzNxUmdUM1hoYkxid0xB?=
 =?utf-8?B?UFRoZVJCWm4xeEsyTm9EZ0dJckhWRFUwbGxTbG82ckhsZU9kaURBaTdpTnN1?=
 =?utf-8?B?NXNuTWdBMEtldjhVUitFVXhJcncyc056WXFScm5mQXZMN2EzWnVxMUdjQnVa?=
 =?utf-8?B?NlZpay8xN0I1NndWMm9ZVWRIOWpFN245a3lDbzFwZjU0Wk03R0dpaTE1N0h2?=
 =?utf-8?B?WFhwMGd5S0dvUk4xc0VEQWlTaVRrUXNtQkJHZzg0YUtFYk5nbkVsQTdYQVdL?=
 =?utf-8?B?WHZiemJ6WDBya1ZjR0U3cGZlbkxWVWYxTzExaFdPWHM0cE1VYmZaa0ZvRmJT?=
 =?utf-8?B?YnJVM21sM2JOanFjSmJBQll6NXRwQzhPK21yTWhnQmU3bU1abXhFZlF1WnBt?=
 =?utf-8?B?VjFLZHlYRU9POGwzak1DMWJCL1o4UDVWUUsxUk4wV0RnbGh3cUdtMms4bFZO?=
 =?utf-8?B?ejN1eFpLTFlzR25pTW5DRURFbkU5VWRQSG1mSWVocVR6bFlIQVNtV0E4UGYz?=
 =?utf-8?B?Q3JFOURNQXBFYVJOY3NETUhsdWpDRU5FNTVXT2RIbUNlR3dYbmhYVWFSL0My?=
 =?utf-8?B?SW1tcGRYUkRRbm1mS1VzMVNzMkRUOEJIYnpxcVZ6SXdGQVZpR2NVSDh6ZnRH?=
 =?utf-8?B?ajVaS1dXaFhPSk00WUorUDRLRkR4dGVlV0NDYXhiMDNQSUZUbkxiaHRCdnhV?=
 =?utf-8?B?ZDVjbytDdHBXYWtrWE8zRHNXWFBWSzZnUjdTSndmbFM1Y0tvcVVOeHpEZzZB?=
 =?utf-8?B?aFpLWER5d3ptSlNyRjFudkZPblZDTUFINmRXeXNsKzNyTVRaVGVoOW5PaHQw?=
 =?utf-8?B?M3RLYks4b1JJQWFOdHdMZlpVcG16aVJidkRTcDRGeGlWbDI2UHFiejV1eDlw?=
 =?utf-8?B?TjVSaG9zZXowckZRUU1CVWo2ZnZJMUI3S1hFaldPaGtMOU9CRXR2cWRNVWZ4?=
 =?utf-8?B?d0tiL0JBK1Y4MFBSQ3JGRHdDK2ptY1lTcVBQRktXYUY0dmtZLytER25BK0JC?=
 =?utf-8?B?QzVOUkxZZjVocTZIekNYY1VEci9yWWRiMTBVMXpqbGdYSGM0U3p5V1kxSC84?=
 =?utf-8?B?ZVJXSXVDQVBYbkc0aXJUSWlUK21pUEEyTGpleVdkc3lWcmF2dURnYXl2VTZV?=
 =?utf-8?B?Q0hEZ3hGRXRnZ2t2VDZsWHFxUWxYQ1psZXFLY0RiOEJPUDM4VmxydEFRYXhu?=
 =?utf-8?B?R1hscXdaZy8xMjBpM3VXTUkvN1BUQXlpaUpIQUwxYmVDbXoxYllRSG1OaG9S?=
 =?utf-8?B?UVlLdFRVbU1aOWdwODhlR1pnbE5ja0YwczRBekRPWTBiK05CY0lqRzlxU083?=
 =?utf-8?B?bXBOWk14Y2V2Qm5VNHdTUC9QNzUya0dINWl2Sm9ZZHlocjVuMUxWd2hZbFpG?=
 =?utf-8?B?UHBtaWJqcHpZVFVDNENpSnd3NUJGTUE1Z0k0ZWkvSVJ2YXpNQUJjVVVLM0Mz?=
 =?utf-8?B?L0hLbmI4emkxdVpGRzFLaWNkY0l2ZnA5blpnbjJrek1keGFrcjNOb0tHN0hh?=
 =?utf-8?B?Y1h0YzdJenFST0pJZGJmbGtpOXJ4clNtYWl3REMvRkVpc3NKSVZYdE9BRlQr?=
 =?utf-8?B?OUlKemgwN25tMklqMU5nbi84NVo3QWZVK2Y3bkk4MWsyL3NteW0xRmNVbjRj?=
 =?utf-8?B?S2VIK25vdG42VHFablF1eGtMdC9xMjNxUkpDaWk2YmtYaTVyNU1nVnhnR3lZ?=
 =?utf-8?B?dCtLaUNIa2dJWXJSQmgzMFloU1BmMm9BUkFITjk3c294MWlZQnc2Tkg2VDE0?=
 =?utf-8?B?NmNGbEE1WlNUdXFkZzR2K2x0eksxWGc2T2habTlIeEdGaEN4VEZQNTVSZDBN?=
 =?utf-8?B?VFZjY0RhanZYaUljMUJmbGZEL3FkRVM2RFlxaWJJZjVxMHNoNzQrYzVCU1Mz?=
 =?utf-8?B?WjFUaGRHNlRSTlhHeVh5bFM3WVV0bU5pQnEzR0ZHZWVkWk1BcDBVTXhkZzJn?=
 =?utf-8?B?d0JHZldFOHdBZmhOa2tJUGl4cUVsTVhWSVA4TkhtV2NaUVd5cDdpUWlnWmhL?=
 =?utf-8?B?L0ZYUmErVEVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bThyWHN6bUlRUzJWd1FoMWRaZUxkQUxUTzB4OTV6cDRqUGVVRzhXN2lKRnlU?=
 =?utf-8?B?WTFKQWtUcG9odk5nZUhQVXUvbmVoVXFZQlBUakxmcTVzZmFJUHZUQjVvZmpr?=
 =?utf-8?B?azREQUxHN0pvTlFBSWRnM2J1aURjWmt1V2cvYXNMcnZ2ZzVGMTI4RHpHT1Za?=
 =?utf-8?B?RjJXT1ZWRS9PdStNV3kvWnc0eGhiOVhJSVdYUlQvd3gvTWQ4aGdaL0thVUtI?=
 =?utf-8?B?RjBPSVQ0RktjRUZIb3VTcC9FM29keldhcVVCdUZoZkJFMEVKZE40WVM1MzFh?=
 =?utf-8?B?ODFSdU5vV1k1WCtCQ0tick5YdW8rdTIzdTFCZk9tRFRIc1VTaC8xRXFxTWxM?=
 =?utf-8?B?bUQ1SmVpMDNGUDhxZ1prN0tPc1ZYTkl2eGRPNFpSWWVTUm96WWNRZ0w4L0Jk?=
 =?utf-8?B?KytnTHFVL2V3cU0yMWRHV1JtcS9lZURYOEY2dlhVOUMxQ1Z6OUZOZnp1ckxP?=
 =?utf-8?B?TnF0Tmk1RVhzRkZ4VXpZSGFOV3VNTmZYNHJISlliRnl6Q0ZYbHBBL0M1QUNu?=
 =?utf-8?B?U2tEWTNRQUZhejFHeW5sSWpubjMxVG5pTmtNc1lHdGlKL2ZqUU0wMVkrZmg2?=
 =?utf-8?B?WHJSMS91Q3BZbkxBUS9MT2NXMWo5b0NiaENBMmJYWEM4TXNpVzJQTXZ6Ujc3?=
 =?utf-8?B?WnhXRlhHb0ZhNjFhTVNPeFdncUpxbVhGNWRCdml1RUZqMm5nd05wK3lkY0xo?=
 =?utf-8?B?dWpVYWFhck9mU25iQzd2UTcwMnNlbCtWdTZEd1UxVXdqMDhUM0RhL0RFTVZn?=
 =?utf-8?B?R0ZUSTFqM0N2dS9GWFYxeHgwWG1LQ1M0U0Z3ZzJNbW91VDNRbWFBZ005cEF5?=
 =?utf-8?B?RFcvMk1BY2NJak9rVFUxL3NPbmZBbE9WRnRycVg4MmpiVUJkMUdPU011NnJt?=
 =?utf-8?B?Z0dKTWx5NnhhRnZHenNuWlJ1b2ZwMHVZa21pQU15NnJUa2JETmNtM1d1NjBU?=
 =?utf-8?B?TzFEb2pwLzRUS0RxSkVtTlhZdEdFTGoxNGxpMEhJTVRzQ1hlOGZrUW9xUUpr?=
 =?utf-8?B?Nm0rNnN0RktiQ2MvODdWZTRqSlpFTFNkSDBuejY5UzdLRy96Y2RuNXltWGk1?=
 =?utf-8?B?MG5yd0tLMHcvWmt4TFBrSG9GS1VnVDBaeVNjWTNQRFFsc3hHaUIyY2dPWGR6?=
 =?utf-8?B?STJVYnB1eWxpbzMzbk92Ym01M1BITUFxTml0emh4YzdwOXcrbTAzNWNib2x4?=
 =?utf-8?B?KzQ2RHBoWnhuODFEdDk1ZmVoL3Fka2dRRkxPbERjTThKSElWTFlzU28yZDdl?=
 =?utf-8?B?UzR6K0d4UVI0VUtOYS83Rm1mY3lxNklxeCtxMVg3d2ZSWlFRRU1WUU5qVFVn?=
 =?utf-8?B?NmRMeXovSmlhcStNeWV5OG0vM1RFeDhMMkpFOXR6bVFDNTVlbFBXQUM1OG5l?=
 =?utf-8?B?TDBDVHVvY3p5MWwzYzhKdkhCUk43Tkt2Ym5scDc0S2ZTckJ3cjU2NFp4T2J5?=
 =?utf-8?B?ZDQ0V0FlSFNTanJrdWdEdmdrUHQvVjhkNkJDd3YvbnJMcmNTaERDUm44My95?=
 =?utf-8?B?UmJKblJ2SzJleEV0Rzl3VE51WnpyNThjSzVMZVNZZVJKYXc3b3hDcm9wM1VC?=
 =?utf-8?B?YW9NZjJvMkE0b0Rkc2dMUmw1dmdzVTNtZXZGZkNVMG9MNHp1SzhaRlBNOXNJ?=
 =?utf-8?B?ZHdlT3lDeFc1RzBzbm5MM2kyQjVnOGhZc3VqOXd3VVhVRjNkWHFPZUl4cnlF?=
 =?utf-8?B?RW9UZ1BHNUNIRFlieERtYXFMRVNZUWltY2VGdnRTNWg4aTN1eWN5aThBSXd4?=
 =?utf-8?B?Z0ZKR3BtQWVlYk1qQTV2a0JSS05nTzdhellkM01mVkRFaUVEaGxaRTlad1ZP?=
 =?utf-8?B?amY4R1BRU0lQeHhaVFk5clhxNzREeDJ2QnMxWWlJZHdlNm52WWtpRHhZanoy?=
 =?utf-8?B?d0xkbHZzU2hQN29wMmx2MWJZWGhISjdDQTdXQVpXa2dhMmpnaWw2VHQyMm5W?=
 =?utf-8?B?dGZ5cEdsUk84R2d4QThQS2hxTU5lLzZtVFhWNzlad3dpRThkZXNrRlBOR2JJ?=
 =?utf-8?B?YTM1b0ozQ3BwOVJ0Y2tKL3c5Sm03OHJ2czd2U2hWMVpwTDQvRDNDbmRZdXA2?=
 =?utf-8?B?Nm9DTFYzcHdIbTJ2QWs3OSt4Z3UzVjNWc3d1VExEeGFQSGdvcG1PS2c2Zmh5?=
 =?utf-8?Q?cItY=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78efe713-0841-4b7d-36bf-08dd99fa9197
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 13:06:01.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJY5tFfy5Inft4YImpbUT5W+Q6+JFsPJYBOGo5QCR8Xx9F3iT3SDctL/bUystXs1igFcaSqv8ojjRRQsDXkFYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4203
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <1AB56D97642EEC4CA91AAB2C62DA025F@namprd15.prod.outlook.com>
X-Proofpoint-GUID: 5l4GQfLujFZleHio0pIyJiGZCct1XPef
X-Proofpoint-ORIG-GUID: 5l4GQfLujFZleHio0pIyJiGZCct1XPef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDExNiBTYWx0ZWRfX34kAxL4PP1bA WedoaoUQgntVhF5wVJeW1WlBPAm5zsZipV8RmI0NO/LyWVRQg6veaS7/qGcN60KE7AyOvfmtW7s VMfo7EoLrC+ZL/6sT59kU9042eLByN0dlOwDgTNzkecvx5rhLuWu9+X8YFseLH7v5tZ12VRCJky
 2MvsX/aw6yU7RKMEIa8mNHk8vjVJ1qYTvvwHE5xBgW2D3RxWa0U8UbGOktcF8K18UX9XX3XZxcW oEKcCyO4JX97tHTjNCS7sbqsd5OCVPFi55cj813e2QbVClfAqY0qnyOhCLw3XaJh0qk0IFsn8TV 218WlXvvVer8+nBF1tFgsc6CIaDNLhNuxp/nTlUxjZKj85+wpZkNzch+X8Yq438wu0KhA0t/AEN
 xPVa2uA7RT5fmINNynMywEm5vC9iRZF5C0mZ9pwDittEZFMbaukAOMr/8EZf4QgAdAFXFpLW
X-Authority-Analysis: v=2.4 cv=V+p90fni c=1 sm=1 tr=0 ts=683072bc cx=c_pps a=KB7kLzfingIg7eHt7PrfOA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=8HPtDOabApscvwGFRksA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01

On 21/5/25 13:43, Johannes Thumshirn wrote:
> >=20
> On 15.05.25 18:38, Mark Harmstone wrote:
>> @@ -282,6 +285,10 @@
>>   =20
>>    #define BTRFS_RAID_STRIPE_KEY	230
>=20
> Just a small heads up, I'd need 231 for BTRFS_RAID_STRIPE_PARITY_KEY
> and maybe a 232 as well, so there's still space just to let you know.
>=20
>>   =20
>> +#define BTRFS_IDENTITY_REMAP_KEY 	234
>> +#define BTRFS_REMAP_KEY		 	235
>> +#define BTRFS_REMAP_BACKREF_KEY	 	236
>=20

No worries, thanks Johannes


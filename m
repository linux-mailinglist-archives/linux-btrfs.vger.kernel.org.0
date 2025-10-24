Return-Path: <linux-btrfs+bounces-18244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6999EC04B15
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 09:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAA81AA0B58
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B592C11EC;
	Fri, 24 Oct 2025 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dtiEbUMr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QfuWruRw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23E2D7381
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290356; cv=fail; b=Ak4vdXB0sA6olwOYsJ8Coqv2jOtBD8JLsaT+7c8FfDpEpCrodfwhfNn4CHM6SzqtcEYngClckM3/bU66WD9py+2H8cqWDM4bfLpH0qD/FfF8vuDOZI1EJxiqe43GS87zn5D8YEwahaCKBJJUymL3IvT57Lq3ZyFSnN+NnZNBZjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290356; c=relaxed/simple;
	bh=5HAwXPd80f/6J+lSFNXJ7qy60qsA15w/x/ycGxC5ozQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vF89zFFVUCzU5EMrP6Up2pUvoQIC83+LvpYa0SfjKvv9IZs+mkS36fMfX5aVrAZ+jm1SVO+3+FJi6yiypE3tBNb668+nOsu28mApPIzRnN42saqepaO2JvOnSbOSCLOSoiBXksJrlJlawto0yrP99L66/PvvPOMrBNHe4UCQJ2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dtiEbUMr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QfuWruRw; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761290354; x=1792826354;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5HAwXPd80f/6J+lSFNXJ7qy60qsA15w/x/ycGxC5ozQ=;
  b=dtiEbUMrR/d8jGppxYydsGwabEUIIKCLVp43dch2586NyCyO6NsQZa9a
   DB3mi8FvM76jCfRgO1UUGH6T6Jb7kB0OecWGmbPbI2n+1cMOvnTxvkcVk
   jP3y+kjyf8EoK8HTl8KKzSAUi2sGg04asfwqXC0pm3cTWi+vS7ErN3VeU
   BEoCB33oLkAOSWWyqaZT6H7k1+LsgClszmw5/r7ItyojaWOmFihV/mmXe
   pvRRcpash4CZoSwOp4ucOQDsPOQh9lqSgk6hwhVRdi1P2dMPMWvFA9bCv
   mBd1Akcm6KPbJNPmrBJ8yibDjaFGFwAvnhSA4FHBofXSH8/oq0zkSVxeT
   g==;
X-CSE-ConnectionGUID: eCzL3zrrQV2uURiYrFfM3A==
X-CSE-MsgGUID: B6iJXDUPQoWPV6nGDddg6Q==
X-IronPort-AV: E=Sophos;i="6.19,251,1754928000"; 
   d="scan'208";a="133833738"
Received: from mail-westusazon11010048.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.48])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2025 15:19:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIpD3jiPhdZqXgQpXOcojcCDuSIuG9IsRb83BQxFF7C/rNegB2grsjsy/HCnB5oLIjdN6R+HIB3c0SylbDlXSh3clhywIQsKUUBHiDpS9Ms5qsBVuTPvobxReZZnrS7aQ7GKZIAUPRUqQVtEdII1ZbzZmoSwg4jAy5uIcXkY0C/qQ9LWtwXnN35l0NHnA+g+V3cpt5TzKo8UJ+BPxwaD3MfCYNSAD6BwSQUeN0u4yUMIexNkA6t5wE68qOn3hodTr9W3gLgA20Zm8fRBCVGrTcRJJfSDR2PySXlY5FP56dCzDJ6ydLcE71xN9h4+lEv66cbdW3nWusLD0NFMWf7FeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HAwXPd80f/6J+lSFNXJ7qy60qsA15w/x/ycGxC5ozQ=;
 b=IHkOkW0vfdwN06LjHxs7fwL2VIEfZfmJwz1q9On3bUj25VnTahZtXzxIaf7fqdvw/qrBRoZKBDNKyxOG4So1C2rNjJgRYKzlZ3NkBcZU2rc+4IpM8bYvuIurAV1zo7YFUKNPogmxS5mYiQ9B4zE+5bwqpTibaswiQ6PE1PBv8PtBfER/jd426b3fCI3Flwsh9u+/04pJRE8a+9TMlLxnLYFO0V1JTSW24kaamdPdN5OAObHWSPP2Ll6UClnx4jfeolpp2QtojNr98n36LgKqGapBCrM/3IyYTTPHoJnaGVmn5C4U42icKNAIfDFRtrGHqRbMPdN408q6uEgNKvlTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HAwXPd80f/6J+lSFNXJ7qy60qsA15w/x/ycGxC5ozQ=;
 b=QfuWruRw2M23x/kOQFJo+1/3TgIT1aq6id9exEs6vbD4c0Zky+Jzz4WNEbo5nYCNrCvA0MPFX859atxLuqtoQkuSaiV4gOlhp40rKqJqGA5CNYiHSpjRYbpBb3gsl+qctHlV1J99uVcYQOLVCS7r6JgTfayaw08O6CR+3DhWjZs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8205.namprd04.prod.outlook.com (2603:10b6:408:15c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:19:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:19:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 18/28] btrfs: reduce block group critical section in
 do_trimming()
Thread-Topic: [PATCH 18/28] btrfs: reduce block group critical section in
 do_trimming()
Thread-Index: AQHcRDZIWMMQFU/i2EaUJjI1hmaycrTQ5IoA
Date: Fri, 24 Oct 2025 07:19:06 +0000
Message-ID: <94881d3f-64de-4ca6-be15-38b6dddb3119@wdc.com>
References: <cover.1761234580.git.fdmanana@suse.com>
 <1a4d2fa8f7da7b88e3b6b3aeabdcee25245b51ea.1761234581.git.fdmanana@suse.com>
In-Reply-To:
 <1a4d2fa8f7da7b88e3b6b3aeabdcee25245b51ea.1761234581.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8205:EE_
x-ms-office365-filtering-correlation-id: ea960077-d421-431c-a5e9-08de12cd9e34
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0dBQ21rTmdGUG91bWswNkhwTGRhWlhxbUZsbElWdzdvSzRYa2N5UENZQ0xD?=
 =?utf-8?B?dENUVHFRMnJUd25sRk9uTFNjcHlUMzlqeTBiWEpsb0diNE5WUlM2UnlOaFhr?=
 =?utf-8?B?cWZPV2c5ejlVRnkyQXF2MHpaLzhWc3hlZ0VrNzB2WU1XWWJQNzRSM1Q3bDVj?=
 =?utf-8?B?WEg3OUxNaGcyMy9ud0VtZXJaTFJOcmovMnZDL3Nia2dqb3RkaE5VSDExbW1S?=
 =?utf-8?B?UFNVcjlkQ01idlZpTTNBMVNqK0lHK3Z0RmZyQXF5MnAvRG5ITitKZ3ZQZXFu?=
 =?utf-8?B?N2FobW5INGtnY0NOMklGM1hvWW9JaDZJbHhDNnkxbWVKbmVVWGM0K0RiM3hW?=
 =?utf-8?B?MEdDWG5ucmdTblVHc1NuYTdkZ1VtcHB5ODdveFg4YStCeEtlamNYVU5EWTFE?=
 =?utf-8?B?ZjBpVEducnl6OVl6TlpIRmNCRE5OSjJFRldkRjVodUphSlVJQXY2K3ExUUxM?=
 =?utf-8?B?OEl1Z1R4SDdNRFVzTHVDanlLbWdXbWFwZGh2K3A5MGQxWGwyMG85ZkVqSFVV?=
 =?utf-8?B?cnFXeDduc1pHTFhPTjM2WkZHNDhYUjg0VFhsY3pocWgxVkF4OGcxR25hUEdC?=
 =?utf-8?B?L1Bzc3dudG5vdE85U2FDZ2VRVHM4d1hBeEgzZDhzMDNsalhzdHNSRG03aGIw?=
 =?utf-8?B?WW1kMVlJWGhieHRpZDNHdHVjclpLbWc4YzZIUG9MVno3TlVHU3l3S0Y2SzFV?=
 =?utf-8?B?dTBvRHdaaTJKaDBxdmdXa1dERTFOV1RZTjFLY081cEdjdG9BN2E2SXEzSExQ?=
 =?utf-8?B?djlrZ1ZEdVdwcHpiQzNTNHdLNVJSWjRtNlk0ek5RS1g1MzE5YllTNmcrYnFK?=
 =?utf-8?B?WmFLU3BxbnlOL3UxV3JUU3BTQysxMW9mQWZsdDBoQVlFNlNveXNncFhwcWg0?=
 =?utf-8?B?ZEFhOStpYVdhMnRrTDZDbzNlMXlEVFI3ZTF0SFNwNngxWEpYazExcTBjU2M3?=
 =?utf-8?B?RDNKa1BQbXhvU1pEVC9QWkgxbm5hMGx1bVZKb3JueUtqdXErVHVKYXh4UE5Y?=
 =?utf-8?B?N0NIejEvWm4vWkpoUTY5QUpXMFZoOTZFbkdaUkRQY3BuZ0wxSFk5T2E0SFRH?=
 =?utf-8?B?UkE0N3dZY25YNEI0akhLZ1JWaTJYYUNqNG5qdWpnS0paOEdSWWw2cU4ySjRC?=
 =?utf-8?B?ME9SWFBQWnRKRUZSSlJlcFNoY3RyUkVoZkZYM2duWmdnd21NRytFTE1IQjN2?=
 =?utf-8?B?YnIxR0Nhd1Z1b0VoVUR6L1dRS00wRXhIR2lmQytRbDZKSDFwRlZvTzBLbTF3?=
 =?utf-8?B?ZWIwWUl2d2xGWkx3T0dhUGd2RTR6QTcvRUdYSDZ2L3pUOGJTb2NqcVZjY1VT?=
 =?utf-8?B?b2diOXNhaHFSSHVWeVF6b0VsVEYxSEFacitZT1IrYmZJWWllcWc5QXB5cERH?=
 =?utf-8?B?SWRpckppdEN6a3lac1Nqd2dNTkZ0QzI2Z3o2Q2hKV1k1OFZhWm5aVkRWckpi?=
 =?utf-8?B?VStaclk3MmJURW0wUEdWZVpLT3JEUWgzSU16K2tHa0RySzlBbjVWMHBpbHNq?=
 =?utf-8?B?MGxGSTFYNnR2RGRCVDh2Z2wrQTdCRzRlK3d5elB2NmF1QUI2c0VrUGxGbFB3?=
 =?utf-8?B?WjlWa0FSS1lJUThxWG5KdmxGcUk5RzRpQUZPd1FHak9VQmJQZEhzMFd4YlQy?=
 =?utf-8?B?S1JERTlHVndWSEN0Vi90TkhZNXpwOG1xUjU0QU91T0d0Z1ZaSEVERFlSaUlR?=
 =?utf-8?B?OWlsU2d2b2NRL1hLRjNZL3JaQ2ZiSEZtcjZNcVBSWmozT0wxaS9SakpoY0Er?=
 =?utf-8?B?UUJwYjNBNnZEUzhBZGxUaDlaYnFkY1VPeVp5Y1dvSTdxZUE4MFVMVGxkQ1Vz?=
 =?utf-8?B?N3ZGVHhmdmtKZXRETDdsUEdRckxZMVFZNWlZUVJ6dDRiQzJPMTMwQjA2dk1p?=
 =?utf-8?B?TFBNZ2FiSk81V20wd2lHOHpGZjRPM1R1bjdQbWNIYU54RVhmZnNGS3BnRXd3?=
 =?utf-8?B?Vkl2RTlDQUpIUnpPOXo0MmpKMUZTcGprL2VHMGZsekR4NmJTbndrNEpVdmhX?=
 =?utf-8?B?empZL1k0QUNKcjRRenVvQ0NSaTBhT3BIU1kzSGlYZUp5b2t5ZSszRDBubnNQ?=
 =?utf-8?Q?EIPXRC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3FOMGJOd2oxNmQrRXJ6dWtqUmJqZmpJaDF2aG9wTFlITzh4WkdDYlpKWGY5?=
 =?utf-8?B?eHBIUThRWjJja3BYSnJ0ZDczWFRsZE5VWFc4U1Jnc2NXMlYrMXZEbjFKb2tR?=
 =?utf-8?B?dUphdUpEbzArLy9QSUswNCtmdDJWYlh0U3Qxd3h2QzJMUHEyNWU5aHVDcGxv?=
 =?utf-8?B?Q2p3ZE1SemVtOUxVTSswSGhJMC9sQTJXbGVXWDJqeDRIOFdKdlhPQ2ZQMFJ6?=
 =?utf-8?B?VFhyTmZib0RvanJaazJzMlhPZzJ2ekVqV21keURJVStzRDNPbWIydEV0MjdH?=
 =?utf-8?B?cXZBanZlcElOb2VSKzhuMjNCNmxVT3Q2YkhzUlkxMFpZKysvakVFM3dra1ov?=
 =?utf-8?B?cDFpajl6czQ0WnZQZlpuMjlKTVBSWnpaU1l0YVlURVdtQ3R3Sisybkk0ckVN?=
 =?utf-8?B?MjRzNHVNWHp2RzZWU1JUR3FLNlpCUDkvY3RmQ0tGYUU0M3REMjlHbDk1dGhB?=
 =?utf-8?B?Tk5QaUU4YUJER1RiTDc0b3BOYytDRkZVMkFvOGMyRW1iZEtGN1E0NVZRTTI1?=
 =?utf-8?B?YThzU0JiZTJSRGdLSXV2SFVCWDdJekljQ2d1cmJHcWN1NzVwQmhraHV5R3Uv?=
 =?utf-8?B?ZE1NY2FPcTFIOWorSE5YMWVPeW5RTC9oeENMMStsRU1iOUQzak9jSU5xRWxn?=
 =?utf-8?B?bmgwYWlHd2NWUGZGV1BCeHhxUzd6V0lrZUF0WDBlN2lBbFl3L1hKankrVlBu?=
 =?utf-8?B?a3F3QWZqWVlTZUsrL1E3ZnZZT09SeEhudjBCalRkSXBqa3NiMTMwalhuSCtO?=
 =?utf-8?B?NDdscW1qamRxWStTYXFRNkhTNlpYL25ybkhsc0tPb2V0d1VYY3JrQTE5R3RS?=
 =?utf-8?B?SURKbUIxb3RrWmh0R2NGbW8xT2ZHZ0IzNFU3dTBaNFRBbnJwV1pXa2VmTWZv?=
 =?utf-8?B?Z0pieHZqQWtyTnVaQjEzdVlWNU1ZeGcrN2NNYlJrRHNkNkg3VnZTejhFYWxD?=
 =?utf-8?B?ZDNpYUtEcFRPM2w1L2RRR0lxQi9Mb0ovUzlHdTlDNGpmY21WTVczU0hjanZR?=
 =?utf-8?B?c1dmZFNzSHd6QWZEczNabXp0NkxFTE1LenhGbEpsdUFMNytFcTkrR2pnOUwy?=
 =?utf-8?B?amhydlRDUDN1MjZCZVFyUkFybmFWZDRVKytiZ3pPd295Y29RUERFbmkzcVR1?=
 =?utf-8?B?eEN2TERxRkRXMDNhSTVuMDNHTUVhc3B2UloxWkhYS2JmbXB4OE8wcjk4MVdY?=
 =?utf-8?B?c0JsK2JFK3R4cDRBQ0hYaGprQ3hLODg4d0F4N2VibTRyRmh1QXBlLzlKQk1r?=
 =?utf-8?B?Y2xBRW5iTFNkNzRqN1JheHl2aXA4S3l5cUxXeTdPa0JEbVdJand0c3dRek50?=
 =?utf-8?B?L0F2eHRoOWFYZ0tvUWxXU1JQVGR5NVFwTnM1dUorTFNsUjdrWDRKdEpZV0pl?=
 =?utf-8?B?Q0owcmZaWWN6QnZmSDNiTCs0UTFVeUZoWkJiWnR1RUtndkZkc3EzVkxYa3hs?=
 =?utf-8?B?OGJ2Skt6ZFVqN3NGc0xCSjhiQW1adG81Q0RoQnhucnNremVBeE5adWgrRE01?=
 =?utf-8?B?OWp0Mk5sWTE0NmVHMUpOUkNyOVg0TVQ2MjF0U0k3c056dndBcCt6RFN6R21L?=
 =?utf-8?B?S1gwL0VweEt0K0FmTVFtMEMvamphWHVuNExEOTNPdWZYV1M5MDJUTU9Kckxy?=
 =?utf-8?B?WUhNSkdwQmxZWHdPUDVQK2FNRVJqNTNpSllQVktTTVJYL3R4SEZTeVNHSFdp?=
 =?utf-8?B?cGgxU1VGZndkbjl5MUNhejNwUUFjU21mS2h3b1NlUGNsbGdGdmx5cGRTREI3?=
 =?utf-8?B?TDM3eVI2TGxxWG1NSjNxS0hJSks3ZGREcmQ4VXFxNVUranNyRjZNdFhNZkEw?=
 =?utf-8?B?dUhBbnJvaGpESVNRb2IvY25Tb1JGRytGdERiQW53S1huUGFkRWRoZitQbFFl?=
 =?utf-8?B?UTUwYjF2d2F5OXBNT1l5YVN4NkwzVWVidHgvNGVJOVlQZkZLNlZuR1V3MFdI?=
 =?utf-8?B?N21RUVV6aUFTUGo4MWZRNE5xVk9NeE1pbzR6OWdpTjE4UzJjMklNNi9uZEhy?=
 =?utf-8?B?N3YrYnM2ZTVOSzdwQktQZHkwZHdaNEhNZDNXL3lLL294UXNIZWJ6MG9YRUpz?=
 =?utf-8?B?Y3dZYU9mbk1WN2o2Mm9MOEFobElVQS9QUFZ2U3RMNUQxY2xDVk91RFgwamhQ?=
 =?utf-8?B?OFFCdGVpUlZta0YrWXhqcTE5STZ1bEt6aFpvMjNHOThmVWtSZ0d0cXpaMmpY?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F5DFC608A10C24E8527C7B64FC9DF67@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AKdqeKXD9dqCgYJXlzrtzauBYfj5eeTSIXrngFHHbPgyPxIFVNmxS9EOP57naP1xuib3kQiUhhHaKREA+odGalB/2POujAwdhI2ERyEIcpuCBF35HjVeYXLQHwsKCP6OZ2svsqH4oDRu3F0d1W66wQzLS3EDgDgVxq0q1VdlAEO1U1rmEmEDQl3R0WJueQXvtjC48AJtR5o19xSnrH4HrwJFEO6XLrH72lVTwH4F2YyC3f085UKnUThlm8waaGq4dns8v6/5VwxfUHbk9OmHxenJ+wWCDRbymkAT27GhHEpiRXrcFBDGvJu7Wpt4iUV/EUD1u00BY9uuCk1b4iMIJz1c9SrtN8rC17jUujcWFI7vJmQIx4RuwrWalJe5636c5W+x3XjLEdKmCvXpYBA7GYxJ/ElP06vbBDJDyZiQH0daQLDNEi7xrwMMpMX95nz84j90paqTnc5twOeAcpGXQMzTPsUJpJfDaDb/eUMVjQP+f3zXz00I0EDmxzXFjFduVoJmGjCWYKyPmL7ydaUuFMumEITZu+Hz2mXFqSz4Z+YoRp+x4q1SA7tWAtfmjYq3WFUGBocxzNnx+ysxnLjj4rj/d50+lUoDaOyEAs53R/9SoAY29dRSbJdGa0D0VRQR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea960077-d421-431c-a5e9-08de12cd9e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 07:19:06.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8bIlUB3NDPGMn8FOGmH6YO4y9rc3ANQ9rdvzKTt7iIdpm1LE3sHFozVsXC2TcGvf4+RpnHx8b2j2WBRW2CSLWYt+5Zy4IVJkvPbhz/eGv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8205

T24gMTAvMjMvMjUgNjowMSBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gICAJc3Bp
bl9sb2NrKCZzcGFjZV9pbmZvLT5sb2NrKTsNCj4gICAJc3Bpbl9sb2NrKCZibG9ja19ncm91cC0+
bG9jayk7DQo+IC0JaWYgKCFibG9ja19ncm91cC0+cm8pIHsNCj4gKwliZ19ybyA9IGJsb2NrX2dy
b3VwLT5ybzsNCj4gKwlpZiAoIWJnX3JvKSB7DQo+ICAgCQlibG9ja19ncm91cC0+cmVzZXJ2ZWQg
Kz0gcmVzZXJ2ZWRfYnl0ZXM7DQo+ICsJCXNwaW5fdW5sb2NrKCZibG9ja19ncm91cC0+bG9jayk7
DQo+ICAgCQlzcGFjZV9pbmZvLT5ieXRlc19yZXNlcnZlZCArPSByZXNlcnZlZF9ieXRlczsNCj4g
LQkJdXBkYXRlID0gMTsNCj4gKwl9IGVsc2Ugew0KPiArCQlzcGluX3VubG9jaygmYmxvY2tfZ3Jv
dXAtPmxvY2spOw0KPiAgIAl9DQo+IC0Jc3Bpbl91bmxvY2soJmJsb2NrX2dyb3VwLT5sb2NrKTsN
Cj4gICAJc3Bpbl91bmxvY2soJnNwYWNlX2luZm8tPmxvY2spOw0KDQpIbW0gbWF5YmUgc29tZXRo
aW5nIGxpa2U6DQoNCnNwaW5fbG9jaygmYmxvY2tfZ3JvdXAtPmxvY2spOw0KDQpiZ19ybyA9IGJs
b2NrX2dyb3VwLT5ybzsNCg0KaWYgKCFiZ19ybykNCg0KIMKgIMKgIGJsb2NrX2dyb3VwLT5yZXNl
cnZlZCArPSByZXNlcnZlZF9ieXRlczsNCg0Kc3Bpbl91bmxvY2soJmJsb2NrX2dyb3VwLT5sb2Nr
KTsNCg0Kc3Bpbl9sb2NrKCZzcGFjZV9pbmZvLT5sb2NrKTsNCg0Kc3BhY2VfaW5mby0+Ynl0ZXNf
cmVzZXJ2ZWQgKz0gcmVzZXJ2ZWRfYnl0ZXM7DQoNCnVwZGF0ZSA9IDE7DQpzcGluX3VubG9jaygm
c3BhY2VfaW5mby0+bG9jayk7DQoNClRoaXMgd2lsbCBub3Qgb25seSBnZXQgcmlkIG9mIHRoZSBl
bHNlIHBhdGggYnV0IGFsc28gdGhlIG5lc3RlZCBsb2NraW5nDQoNCg==


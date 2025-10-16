Return-Path: <linux-btrfs+bounces-17908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57968BE5CFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 01:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0A119A730E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 23:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEC12E6137;
	Thu, 16 Oct 2025 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oynzKw/B";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SV/1sX9I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB0334690;
	Thu, 16 Oct 2025 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760658543; cv=fail; b=SGoTH+A2B944dWPzI6/9e7zXLIj/ZTV631mS33jBzciobWb/cexh2yc4k0pIC5z6+ItvbxtHHs9cClvySVATUvK2pj0yQ8n01P2+WEXHXJ/FBMv37hpMOJqNGd7CZ9luhEXHNFbKcP1uZP4D/AGbFLIT9BXau9/bOmdBSG5dzos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760658543; c=relaxed/simple;
	bh=dZDIfNXgtLnrL0F/ghhDe8cJtZ2OuIaEPy/rakt2aoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mh/tf9foP2d/JVHnscrp3dsxypMC+7aAKmyMPqW121YmsgfmYJWQuT1CjBz1xzFiQYGjkWxk9xCr7GaqfmAsMeNvWRu1CGYwcAI8HPSuegM3+eAtnRKPjAlfVaLmgUTsyfDaGTwExdKlWXgrOI29vuaQ1zsL3zTdBTlmQIC0maI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oynzKw/B; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SV/1sX9I; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760658541; x=1792194541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dZDIfNXgtLnrL0F/ghhDe8cJtZ2OuIaEPy/rakt2aoU=;
  b=oynzKw/BiytU6ohmdeKeg6/Y2TiQPmwQ3hk9GMw/Cahj6fHSh3/T+AFA
   cj8B3KtS+fRSPKT+Yu9Pl523Wd80v569PcJ6cPzWG1kdenFCTnv8KOsr5
   xhwyXkd4O5FWBXquOEZboiRh2qsjJ6WrIIbDAmTtxH35UAG8FOr1PmZqp
   NoCj1ofMwyRLKuxRJAV+lZu9XY88EOnMxYEG65Po69caiSqUgRB/eO5/d
   8e2nCDJ3om+d9FoBsO/mbBuCi63MHr7wbFMlmUNEWe4AAG6WYCitNfSql
   pX03qyPD7FdEXso59mEyPqox/4i/sILMvWrfvzMC3EXUst45+3dRGMbg3
   Q==;
X-CSE-ConnectionGUID: b36/CDG4Rzarb6VTxElA/Q==
X-CSE-MsgGUID: 6Pwh+W8sSSGFbnzepbobMg==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="133051668"
Received: from mail-northcentralusazon11013037.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.37])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2025 07:48:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBuYeFEtJqRSyojNaxAvfR+1zFXnPS5oFYfIh4J3nk4V2Eof17o5nby48/Iy7KazdcSUCyMtzoaGqBq2P6fMGGYIghsDlheYaKvTpsfPxzM0N4lGuh5eQ8Mlx6nMUdKdXFE34MIS41jbUeLeHxuunPkfapKkscef0VCgeaf+fBk4ul496an9CmjAZrSBqkavokXPM3Et0nUAKiK3J0T6NuKU2nuaXNzoHxkU9gx5jWdhu4fYuqJG+BNvuzaRBIBBPvtq9kh6/cxc/q80fIf/WMliTSKNE8TqhDvSAgRAtNCDw/vt6UgE+vUxydlfzyYvkaNmynCl3UP4lpcr5Brk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZDIfNXgtLnrL0F/ghhDe8cJtZ2OuIaEPy/rakt2aoU=;
 b=U2L/4P3mHCxj6QAbl7qXOI/3jKHKbcRfAI2p6FpOweDCjs/0OCdDlKzX3ltVp1h6sjw75TmjhP1Y/wL1FLirhBc/C3DH17ylpPKWwZdOfTXKR5zkJQ0bNtdblmxsTJq4+7O2e2eUtRSm+OZNAjAxBs688aMlEsHea8iTgkHscgCqJ6QAC53sJIRV4VI1S92KzUl+cpev5Q/3CrrIvmLydMeom8UTun39XnXqEk1Xl9cmdQk8Vt7fj+0xmldzjuEpRO5xmASHSnrFWYYcSnrsb6ntE0hpkmZsD8AS9JlxabGwMjlN5BZQ4a9aOz/qAxx17jw08xtfHpA/AfelpBLsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZDIfNXgtLnrL0F/ghhDe8cJtZ2OuIaEPy/rakt2aoU=;
 b=SV/1sX9I0fyVFNgIT5naTwP2R1XhFL0J//tz2kPh2Se5xwKxJIjmb/maryXPonI23AHdI8uSGsFc615fAMDJK58atFu42mpHcd9q/B2nrMH1SID503S1nVFg2ebtlLlLBvlaEdYwh0U9gClu9q1DXd+p7qjgDwdTiY/9OKjsEaE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MW4PR04MB7251.namprd04.prod.outlook.com (2603:10b6:303:7e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 23:48:52 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 23:48:52 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Zorro Lang
	<zlang@redhat.com>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino
	<cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Topic: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Index: AQHcPrB9YV9xj9grgEyf9Bhc0IvTSrTFcR2A
Date: Thu, 16 Oct 2025 23:48:51 +0000
Message-ID: <DDK5C0G3L3M6.XR9L7FSPLRCG@wdc.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
In-Reply-To: <20251016152032.654284-4-johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MW4PR04MB7251:EE_
x-ms-office365-filtering-correlation-id: 0cc99170-46a1-4925-45af-08de0d0e8f6b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWNQUnI2aTBHZmRrYWxnbXgwemNzSlVpZmpLMjJaaXRIMU9FQ1cycW9DZnVO?=
 =?utf-8?B?M0ZoVjZhQlBqWUdBbXpNekw3V3hHMFZuc014Q3YwdEVLOWRWVTFnQTIzNnBz?=
 =?utf-8?B?c21IZ0p2RG1TTjFDaDVMblZsVnQzWjJxK3B1UlFxZkt0ajN2bzFydlNOdG9s?=
 =?utf-8?B?MEgraitENElBQkdGQ2h2b2VsY1duRzJKdWtqQkdnWFhvcHRueDZ1Rk1iSUtx?=
 =?utf-8?B?RHpqMStzZFo3WHFCSHh2OEFSV09HVXFWS2I3QndUcU1OeHcyZlZrbmcwdHE3?=
 =?utf-8?B?SFVVSXRjZGZDckpWZlk1dTNTT1dxcFpiODJxVCs5NGJZYm9SbVFxeCtXQ3lW?=
 =?utf-8?B?QjZzZDU4cEMwaVpJMWNYSWhicFRiYUs4TjE1dTdTOUNUb1JzY3hKc2NMWElr?=
 =?utf-8?B?Tm5EaXdRazFkYVBwNTBXdG1GN2xvUW1XZm02MjlQZlkvQ2k0OHJ0MWRHZUg1?=
 =?utf-8?B?QkxnUmZWQ295azk2WnZZYUFvQ3RlYXpuNTVUZVhqMzlab1NuYVVXRzVmY3Rk?=
 =?utf-8?B?cW5UeGl2VGs3M0xKWGZrM2RJZFlOQzVqVDZwRGMzSEEwYjc5akx4UEZnU2l5?=
 =?utf-8?B?a2lSaXRIck0xcjkrdVJGbFBVdyswSGMwcm5ac1A2dGF6NEZhamlmOUdxQzFn?=
 =?utf-8?B?SWdGSjNWQVM5RkFwSWRXYUhobDdYRktZTWdSNEsvNGp3VDhGY09jM0t2Q1J2?=
 =?utf-8?B?dnRQK1hBdGtVZDJZWVpUOWlWY3pUNW51aHZMT0dDOVAvSWQ1UExFOGdpcmVL?=
 =?utf-8?B?U0JvbDZIOEpiWnc0ZEorb1dzRGN5bElmTC9ucnRMRnpHQ2QzYVYyU3JoWW9n?=
 =?utf-8?B?NWxnZ2UzSkZBakplSXVnUzFFRlJxSjlNRGs0KzczRVBZaFNqTUlnb3hKM1Ny?=
 =?utf-8?B?TGJHVS90MmJhZkxhS0ZJbHVkbTRHd1NuK2YzZFEvQkJEK1pvb1B5bnBnZjBp?=
 =?utf-8?B?SFkxbmF6MmZUZDZKQmFVRWZ6Q21QTVRGbUxsL1RCaWo0TEovSkJPWGJVZkpV?=
 =?utf-8?B?bGJXa2IyRG1pRG5FTENJd1hjRzYyUUQrZ0RNajIrcFFuR2NBR3dDK3ZRR1Y5?=
 =?utf-8?B?Y2JNYTlyYkJ4YWxMWDYrWWNENHF6ZlV3bVl5ZmpLTldlajliVWRHekxDZjZG?=
 =?utf-8?B?ZkFKL0hCOC8yckJBdWUxei9ieDdvQk1Jay9uN2RKaDlXRktFNlozOXplU0g0?=
 =?utf-8?B?eTIvNkdNTjhubVJoMC9CaEdMSWJ0R1B5YVYvaHFoREhUVzU3cjlyVFE0OThH?=
 =?utf-8?B?UzhkdGZGVXFybm1VNDl3bkt5MncxU3Q4R3hTVFg1OWJvWjJ1L092ZTFEbEhP?=
 =?utf-8?B?d3FYODE0ckRiZzdiMWhDbDhGZGFUSkUyeFpRbWtiNERGcWhCWEVjS0ZDKzR5?=
 =?utf-8?B?cTZlbjVPZFEvSGQxV1pPaEtOd3NYaWxPcnRyNEVyT1dGRUdsSzRoVFY2Qjhu?=
 =?utf-8?B?MjN6cDEvdnJ4QXBTKzhVWnBETlg3TWRUWDh2bnVWK3hHVUNQYnRlWGQ1RVRv?=
 =?utf-8?B?ditkU1M1SUdmNnd0dzJuUzJ1eGVWOTVyTUxUWkpVaU1scy8zeDdTT0paWEQ1?=
 =?utf-8?B?M2FTR3hrbWx3MElUcVF4d2E3M1pDTHIyNzgwdWtVOGw5NStmeHlqdnkzVTlR?=
 =?utf-8?B?c3NDbzByM2VKSmtmNnlIU1BRaUx6OVR3TVpncmtLR2ZwNWdjWk4wUzZTeDlm?=
 =?utf-8?B?VmRIcVhGTjhrTFBqWG5kcm5SVGluanFaYktXUlIwdWZPdEdmc2o3SUNvR29s?=
 =?utf-8?B?MVBZZnBjazEwaXowNlgwVFlmR2RoTDQ5cDFZVFlMTG5PNUpSZlNJbE9rZWJh?=
 =?utf-8?B?WXMvdDZSU3BLdVZaWC9MdnBzU0h2RGF6Tm9nYTNtS0pWWjl0ZVl2Z0xNS1A0?=
 =?utf-8?B?VmlVUnNSUjdHRnc2MUloY0dFL3hqZUJPUXc3R3FhLzRReHRxSVMzdUV5R2Ra?=
 =?utf-8?B?ZURseUp6Uk1kaTV4QktWNzJUVklheVdBQjJXaWsrVXQ3R3doYkgzSk5BOG5D?=
 =?utf-8?B?dWpCWXZPNzRiUDRCblhnaGlyNTZrelNsR0N2MDY5T0cvcjRkd3cvRlBmOGcx?=
 =?utf-8?Q?0BUUl/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFFpSCtESDFaVTFNaXZhRmIzelQ4UzB2a3FYelRSdFdhY1dxcE12Y2hHUUV4?=
 =?utf-8?B?QzVQSmxyYVVZYkVJWnd3MlVxdFFTc0FoRU5mbTJ0NldGMWp4ZlNDQ2phNnlj?=
 =?utf-8?B?QTFJY08xMVVPZGFIakxjTzlRNXFYalJaZkRVazNaOHZsa2xCVmFSb29Ja2J4?=
 =?utf-8?B?VWpVaVFJTVA5dks3a285WnFvQ3k1N2p5ZFJweElWMkNzcHRSZ2R1YmNhaDV6?=
 =?utf-8?B?VEZ1bUFWWWM1SGx3QWFZRURHN1VXaUttT2tXbzBvTnljQ25wSVA4emN2dUpr?=
 =?utf-8?B?Mm5pRjdLUkdqREZ4NFVlN0lSdlVCako2Tit3ZEcrczlpUGdFc3lvZHNCTUlZ?=
 =?utf-8?B?bUcyMjhTWjVSZzBIallGTmptZVVPVWVZVDNjM3ZYT1Jac1BsN29tbDl0YzB4?=
 =?utf-8?B?ZVAzVmhWZHZLNWo4a1FETWw5TFR3c2h5cmNhQ1ljUlNYLzBzZFo5cXZORW8w?=
 =?utf-8?B?RG5ZR0RoRERmdm5EYXlQWFA4V0dicnhkbHZuZ09ORHZPTURlT2d3NmlzbzVM?=
 =?utf-8?B?YlIzSmVmcXBjUldCQzdzQ0tqMnFEK0VNWnZYSzBDSUg3M1lpbFRkblZ4R1o0?=
 =?utf-8?B?MUdMRVIzWUp1ekpuZllCdWp6MHUwelRsL25kNytKeUh4dGFodE9oVFp4bTBU?=
 =?utf-8?B?NHdXazBmU25vNW1ZUy8xdjd2NWFzVUhvcWZLelVrOFJsR3hvUU0rclhUeHE5?=
 =?utf-8?B?dEl6ajNzNXdkQjd5L0o3OFFUVlh6SmxzS1NXbG95TzZXdHg4T2g2UWt4SWlQ?=
 =?utf-8?B?SHNTWDBMS2MxYjB4QlRzc0JVV2d3WXczcDlCSDZTYVVLYTk1RGpVd3lreVdv?=
 =?utf-8?B?NjNJV3RSTWpUZ3NETzlIbkxXeTJuZ2Y5d3Q5U2NlSFV1R2pkL3c3aGZsdDZ1?=
 =?utf-8?B?WnJrYWVhS2R4TDlDUmhLOHQvYi9YWnN4YUliQzZjT2NtQzJCRkx3dy9wVWZ0?=
 =?utf-8?B?RzZDUjJldVI0S2RiL2VGejJ1Q0t5eGtnUkgrQXVSZmxVLzlpT3N5Y3lIZ1V5?=
 =?utf-8?B?Q1laMEdUVUd6N0ZzWm5ZVVBSMiszdWNORWVZVXB2M0VTK0pXakErYmZzL0lV?=
 =?utf-8?B?enZKd3ZSL2czamJNTlRWOEFzeDUrYXJvSWRRVnpQTHBUTWg3RUxpZzVoNk1F?=
 =?utf-8?B?dDJEVmY2T2xheUtrZkluTkpPMTFVU0ozaGoyYTZ0TXoycVFmYmJmVWdqYXdC?=
 =?utf-8?B?UkRjNUw0a2RlSTFJQ0xOMWZxUC9QZ3cwZk9pMUYxS2pMSjBTZStZdXpZeWpC?=
 =?utf-8?B?QnZRVklxd1pMNW04SFdHMldDbWJUaE5NYk01ekNhSXNNdm5wOXAzalZaNEt5?=
 =?utf-8?B?ZFJ0N1ZYVWZQRTJTYzhXYWVqa3ZGclk1ZUJueGNRMms1SUtLbmIwK3lnV3FM?=
 =?utf-8?B?RTcwQlFXWnhGTDNhem41dURLaUxuTW1EMTZPZ2xhSEVSazZJaE01OWl5YWZM?=
 =?utf-8?B?WW5UbDZ3MHU0NldCZi9VZnFnVGpNMm45YVZ3Z0FUTzRIMUZONHhzR3NqYXJm?=
 =?utf-8?B?S29WbVladXQ4SWd2UEdMeG5zdXZhdFlrVVlYa29WNG5RODR0QUgzSFVUTzd2?=
 =?utf-8?B?RUxaS2JSWEJ5YzB2Ui9QaFdOYytaeXdkS3dsNmtFVUU2bFVxTEo3cXF6T1Jy?=
 =?utf-8?B?Zld2TmxLdEovOFViL2VubzQ1eUQySVVjS3FCS2JkREVmYk5RN1pZcVgyeDhx?=
 =?utf-8?B?YkhTbXhlb3hTY0Q5MWN3c1pYVTFkQXZDWWZ0T3JMUVptQi9SczkrQWRNYWFu?=
 =?utf-8?B?ejZEenRDejJwM25iakJuSXUxWFEwdUN0YXdPVFNrR2RXVmRTcDVUM0Q5V1JL?=
 =?utf-8?B?TDNnSmFLem1SNmdiTmZCV0QrbXJCWTJ5NVkxRWM1cG9WR0ZGaDl3bURBZHZU?=
 =?utf-8?B?WnRDYjg2N3hGTExvZXpZbDg1d20zbWJxdGZLWWJZODFnUVpXdEFGRThIVC82?=
 =?utf-8?B?K3R2UjJuNG9ibWx0WG9rMi93SWprWDdxV2kvQWRnOVZXbVViUm8vd0xab2hp?=
 =?utf-8?B?a2dIRm9SaDdlcFdBUmFNdXNZVEpTcW9INHQ2RUJFdzZhL29xMnVXaXlsZXI4?=
 =?utf-8?B?ZEZzaUFSWWxIc21NQWR6Qkx6am4zcUZjTEgvQVhPT0RoeEM0YmZjeUdmdTVU?=
 =?utf-8?B?UllDdjhwK0w5VVo5WUhta0hmZnpJYS9wYitjbWxoQ0NjZXdvemxTcUlnNzhM?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <420358D194BB544CB4132C18AE9C0F3B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ooCucOk0a/V/Ve/eM4DnQP/G3Gf/YlaNITpkDHptKhxG27+QuXQyuUxJoIEZdKd/jHdonmE75OUZtOEXJ+i7Lw+0/PB+cTh3zUmlc3hOxcmzYePgbfUA/zevgY0mlpLKqlCPE5BeSYOcCGVzQfDiFU+W6C7mdpwkOZY4bti+rRgwKU18b8e4hdB9v5tgkM5vxq79hOVT+3qLsRWmSI19BAnwpU4JNwpcJ8FO0aLSv+dPKztDmrRXs1jDn27a+ueVd8nq6hOeIAGqKPGBvOR6I1zdP2lxGGuhj5KJTCtJODaz7eDnBa1Dp0X8ceshH94UUSYnbhRRPRlTR1+ZHyO1WPRE3TENpd4P1bdbz3RRwAbV5XXssLW5K3mAv47fvp5c8QcIGLZ7sN+G7kOH8C+l7FPMzGWgc459Z1fMCCYH3uPmBAhQrWuALPTuzVmZWPMASZBAga9+rR1CYwB7QbzSGhsmpbe9sUOO3BFz1PP8WsIMGQqCWnJEjRYdAJKz0DGyufWc0UA67PEPCuH7sHTyEWJRAFzsBdJkBiCTlXCEg9H3s9SpH3xOgVlIetFNm7dUIApf9t4bzEKD7Drxn4Z0785sxsJZlddK5pKaQXE26qwjHeU3gAye82Ktv3KYSF+L
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc99170-46a1-4925-45af-08de0d0e8f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 23:48:52.0049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygWLuShKTRVjLu/FBajde5TBnZw4orc7li4e8iUWkJVA9K53klifdLR2ECMe9dg6ZRUzC/n5dTdrd0L9UPJKLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7251

T24gRnJpIE9jdCAxNywgMjAyNSBhdCAxMjoyMCBBTSBKU1QsIEpvaGFubmVzIFRodW1zaGlybiB3
cm90ZToNCj4gQWRkIGEgYmFzaWMgc21va2UgdGVzdCBmb3IgZmlsZXN5c3RlbXMgdGhhdCBzdXBw
b3J0IHJ1bm5pbmcgb24gem9uZWQNCj4gYmxvY2sgZGV2aWNlcy4NCj4NCj4gSXQgY3JlYXRlcyBh
IHpsb29wIGRldmljZSB3aXRoIDIgY29udmVudGlvbmFsIGFuZCA2MiBzZXF1ZW50aWFsIHpvbmVz
LA0KPiBtb3VudHMgaXQgYW5kIHRoZW4gcnVucyBmc3ggb24gaXQuDQo+DQo+IEN1cnJlbnRseSB0
aGlzIHRlc3RzIHN1cHBvcnRzIEJUUkZTLCBGMkZTIGFuZCBYRlMuDQo+DQo+IFJldmlld2VkLWJ5
OiBDYXJsb3MgTWFpb2xpbm8gPGNtYWlvbGlub0ByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQpMb29r
cyBnb29kLA0KDQpSZXZpZXdlZC1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNv
bT4=


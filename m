Return-Path: <linux-btrfs+bounces-19456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F09C9BA48
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A0D44E34C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302F315D47;
	Tue,  2 Dec 2025 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G9IsoN2g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ELVpduev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B232BE020
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682992; cv=fail; b=I3Kcqnhj6Xl1PnDW+Drtk3JPr/aOKrSEEpMmKFwUNjJLlsHA/P28eOLLlGIvJlNiXxAuRVTbIrN2S2H3vI6TiIK9FzJcUPHSjyKuh6myGNXJgOgQwBSOV0AkjlKoCCz1xzFrn5UfvkrwMauN50FYgjNqUjKR8NGWBeLGpXcldQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682992; c=relaxed/simple;
	bh=5ceB5wEE4xgWy/8P8fi9eqcEeNWjbHUO0AvBsd2tYkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y51SUTl7VBJfo5dIicVp12+QC2y5vDSTZXf+8pT1Rk8/e3MVoj61dhL4TTL9qvReUoNrpsRFAJUt8vwHdBah8m3pcK9Q5Ci2Mvhgcf1wc41NbnT5TSihVH8R3FTZPpOwwC+qSEz7EW6Gn/hJ0CGC9CPdYFhAIIWHl5gkqgvUl8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G9IsoN2g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ELVpduev; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764682990; x=1796218990;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5ceB5wEE4xgWy/8P8fi9eqcEeNWjbHUO0AvBsd2tYkE=;
  b=G9IsoN2gjX+QKWObt0nojZUDlw871AnGHBUKow+ufOkbKIwZouSU+Kk+
   R85QnqxOLPkvJ5FIEkwEZWBBza/r50OI8eMpCcVD3GYjmsYKggQZsfDZa
   cUdQhtyVjKKQZSQTnYdd41iweaWiOeY8qkp5kSKUdtpXANIi3SAIZvMYg
   vF1Ouvp8ktF8ttdgST4ahTuMkFCTBnZ6g8Ye4les2vyY2BODayZeyo5/g
   yZocHgiSfnHadiUiVBqLCaikOhAb1QvgJUjvnZdjdem85yvmWXi9KTJDU
   z7BYc0fdlmrJpZ/TqanIOQmoo82eZbIP4NrN/gji9F3rza9F6hbKxiZf3
   w==;
X-CSE-ConnectionGUID: kk6MIm0CTZ2w09FizLp/cg==
X-CSE-MsgGUID: VT550ir5T4aaOoMcv5GU/w==
X-IronPort-AV: E=Sophos;i="6.20,243,1758556800"; 
   d="scan'208";a="136243387"
Received: from mail-eastusazon11011046.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.46])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2025 21:43:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/vhgeZdmGP21lrQkOnTDqlCL9MwNZHoSI/i4Akx/OJtR0VNQTYft4y+qIk/4jXtVM4BTVVPPnC/BC6srQ4/7ukP4Aq2b3B4sbAZtrOoFt+cyHY9qvGGxEXPGFIbs5bJZ4UbdAaDxORTZDgprJnyTr7AYBqWOp45l94pA9uaUEnwgoyFL4FvsVRnOOxdMhGEpkZ3meluxPt5jT5Z2SOHATO8wQBoDh6QtRJFRAs5mU6sbRZG4sHd6YLxf1HgouKFAplAO0t6gCY6Y71wSRN3/ALRQeyMc9GbI10e4Vx2Legt+YIk6alT0YxMGmgf1zRQDOJ34jbRlQMgc6GUjfbYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ceB5wEE4xgWy/8P8fi9eqcEeNWjbHUO0AvBsd2tYkE=;
 b=lkqgWcrLwUwcIkZb65l480LXMX23EJwnzZK8/0xnPFbh4azObnVmNOJkmaTRjPDKJaCgnjuAwY9/w7aQ5o2uM6YzVPOQ6JvDcUVR5gxFCWS1kHHxKVlywRG6cC9ebE0kLYSAMOKSlK1OEOeLwFOhMCkvrR/CD8t5l1dSeRPCkZ9WBm3MB0YDGLO2hC9DiZJir2D4Vu06IdyFy8rXMvqY2NmolrNGnAXq3YqKZEcQMI/w8Ptot3lU6ewuT/Ero8pdEZAZ2eoCFGisFX5pZ/2Cb+CS0UFJ7mD6sjOEdKAgeXJVQa4zWf+wAtelMI93alIrYP46PhIE8xBpZtB94fY8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ceB5wEE4xgWy/8P8fi9eqcEeNWjbHUO0AvBsd2tYkE=;
 b=ELVpduev0iH4hq4+hdgWH+NBCHRblP9uXh9w3ho+eDrAxAWhm8yPqsT3K0n7VMSKULeeuyjuhM125Q8er51dWgnN3cMGSW/U2Lt0gyPfhzH5Ra9F+vcNL3FtWZdkan9kFG61KwdbtxpMa6vIx4Pq9+PIaIqOhIJ+ld3DCRSysOE=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB6671.namprd04.prod.outlook.com (2603:10b6:208:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 13:43:07 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 13:43:07 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: don't zone append to conventional zone
Thread-Topic: [PATCH] btrfs: zoned: don't zone append to conventional zone
Thread-Index: AQHcY3TCGzy69Bges0G3xAhmmRQFUrUOWIaAgAADvQA=
Date: Tue, 2 Dec 2025 13:43:07 +0000
Message-ID: <f746ae11-f29d-4b6f-b2c2-1fcd63713c24@wdc.com>
References: <20251202101631.155235-1-johannes.thumshirn@wdc.com>
 <20251202132943.GA25391@lst.de>
In-Reply-To: <20251202132943.GA25391@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB6671:EE_
x-ms-office365-filtering-correlation-id: 8980eeba-8844-44bc-c020-08de31a8b997
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjMrRHdBelFuTGhwNVR1dkVQZ3ZWK1kycFJKblRvdWdoSm9QZVhYWkhoOWhJ?=
 =?utf-8?B?SlM2eEJoUnJjanBqNFhSWGtQcVIvZ2V6eDlPQXBNdzQwV0t2UFpxQm1tbHM2?=
 =?utf-8?B?VUlwdm1qS1M2a0kxQVJpdmJPM0NBL0NKeTBXUnpHUGtrVitSS293ZVUrT1Z1?=
 =?utf-8?B?R3pnbFdHNDNFZVhBNUZCTUNLYlBkaGxIb1p0c09LSzlkdGxabThwVWQzRjNR?=
 =?utf-8?B?bDZBVWo1Y1E3MFMzQnNvRW0wZFFrRW1MbzR4RSsyZWcyQkxoTDhYOERPWmR1?=
 =?utf-8?B?aGZFTEozM0k4NFdFNTlGYkpXeG1CNitVWTRBS0owaUhDeXlDRTVrYXBjOFky?=
 =?utf-8?B?blB2Z1NUK2kzRyt6TEJuSjl1YWZ2UVBwdWltcnU3bHFlNkprVi9hdzlWRjdz?=
 =?utf-8?B?VC9VZTBmMWkrWGdzYlo2ajI3VXdDUk5DMHNWazR2OUwzUEJjdzRnOFhGcHpI?=
 =?utf-8?B?L3hMVmx2ZlhJbGl2NWYzWVd1MmZYWjgzVS9QT2Faem41NWxKaXN3dC9jcVJs?=
 =?utf-8?B?aGQ1YXFhRkw2MjhBT1d4TEFjNEU2eEtVMjlEUEtMdFlIRzl6M0hhdmk5VE8z?=
 =?utf-8?B?Y0tCaHNXNHNnYVZzNDFjRDk1SU9FNTYrYTBXY3dNWXZ0UGlXZHdudU1YNFhM?=
 =?utf-8?B?cHh4QnU0WTFPc294U3dQcDBObnVqYUQxWjhHd1RDV01kVjVMejd6STcrTlpN?=
 =?utf-8?B?OTc1UHRZSldmN01lTUZ5dUUxMUVXOXM5ckdYOTVuWVBlL2FUeGYrek9pM0FK?=
 =?utf-8?B?cWlHQ25aRjRNUHVWdnRKcERjUjYxMkp1b2d4ejFrSjlINVU3VGU2cjZzU0ZR?=
 =?utf-8?B?UWhRVmR4QXZHMmlLVnlMN2lIYVY5ZElpbnZpL2h5aTQ3b3lHZCttUEt0cnBZ?=
 =?utf-8?B?NmpCNUQ0dm1CL3VCK2dMTTd1b01LeGV5Wm90S3ZQYk11cGUwdHVwZ1VlNGRW?=
 =?utf-8?B?cnBEWTNxOWlBQkVIUW4va2k1R0hPUEsydVBvU1NoVUM5RGhKWFI3cUtJUXVv?=
 =?utf-8?B?aGpadGR6d1ZEL3gvejVDVVpseEM4dXIxcEFFSXFHQ09kaklFMWNuY2NodXQ0?=
 =?utf-8?B?ZU9zQmhvK2RaelBYVkhmbnN6YVRhVExxZXFYZ1l2clNjcE9PSXVxdnNRVjRU?=
 =?utf-8?B?VmJNUEpiZWlYS21BMVlzMXpGclpGT1dOMHFDL2FIdCtOTTBxRkFTUXJzczln?=
 =?utf-8?B?TG1Lb1pPRG5scTd4QStSdEU3dnJjbnpzbnloWEpaYnpZVncvL1grZXRIalN3?=
 =?utf-8?B?R2MycXB1d0VhbzQ2ZDJwUTJYaG1maWNubEowaHd4QnVyNklEUkdVbEhadGFF?=
 =?utf-8?B?UHc3OUlCZ0cydEdjT01OUjZmZyswMmNvb2VUN1JkVmJ2aXF5SkRjVkdKUGFL?=
 =?utf-8?B?S1Q4dDgvNWpjTWQwUTlEU2J5ZUZzWDUxdy9iamd6VXd2SzU4UzVQbzlBRCtu?=
 =?utf-8?B?ZVZ1WXNVZGh4VFBlME1MYjNkdWhaTVgxSlRoTHBjMkJ0cU9KNGU0dmY4ZEpV?=
 =?utf-8?B?dG5xZnQvRUJXS2NHaDNOLytCVDFNdTZmK3RvYTArVnhkaFpCWWFtOXN3S3lC?=
 =?utf-8?B?Q05lanVGWWpCSTRKbDd5OU9YNHUzTElWVVJtTDc4SVliK0ZSVVFCeXFpSVkw?=
 =?utf-8?B?WjdEcU1jSHU0dWNQQ3Bqc1o4TkFJTCtOQWZNczZRbWVlZ0xURmNIKzg4UWw1?=
 =?utf-8?B?bVY4VmFRb3FBMWh2cU4zd3hrelJHMDVPc0Y2VGptOGZ6MVo1L3M1ZzRzMm5r?=
 =?utf-8?B?bmRqTytwcnVEcmNMd2VqNE5yT3FrT3ZPYVc5cXhiblNUT1o0dzJMZjEvZkl2?=
 =?utf-8?B?NUZ1RzRDZ0Q2U2oyUjZKYjBpa01oMVJDa29xZnVsSXhNYXNDakxFN1BWWjY2?=
 =?utf-8?B?MkxFRlo3NHlEU3RMckczY043TnpGMEtwaXR2STBYeTkwQ0Q2U0VXUUhWbEtX?=
 =?utf-8?B?bW5ETmtJNGhISFRoWDNoeUdkTXRSMUtTYjU4dWJPNU1Ma1Q1b2lraTBzNmZN?=
 =?utf-8?B?REZDaVY0QzMrVGV5TEhsYTVHSnRKYkxNbVJiQmxUMXVzcDQzVlJnRUFCZW1X?=
 =?utf-8?Q?atf3o7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emNCOGVGczFhbTlLdFljOXdrSnduRVZHMlpDU25WZEsweHFST2VveVJ1OWRm?=
 =?utf-8?B?amM4R3hmU1JkVm1FVU1uRVFOK1BYd0VsbWZhT2pjalE3YTdqS1dZNEpONWo2?=
 =?utf-8?B?N08xSkMzMXhYUzZ6WHZxZFoxL0VtaG1tOUd3RDhFT1BCaUVVbFZCK0d0NzFX?=
 =?utf-8?B?S25lL1NBNjIxTC8ybUFVcklZMXRnazNZS0t1MDgrVXJaTGs0MStCd0xGUFRY?=
 =?utf-8?B?QU9zNXBRRFBJeTVSQ2xHaDVKUVBDQ1NtcjBjbjVLMFM1ejZaMmNQU3dOdXo3?=
 =?utf-8?B?dTNWdk1yQkYzNGJ1RFFoREc2R2gvRTVrWll1U3FjNHNlVDk4ZFZTaTJGM3h1?=
 =?utf-8?B?ZGl3UVJzZjZaQjE2dDJnWk5XWjZXQUR2L0o5THd3OWVNSURhYXRiY0lvZTFz?=
 =?utf-8?B?MVllK0Rnb1RBNDE5cVpiR2F6OFpDeVVsL2Q1bXR4OEx0Syt5RkEwVFNJclpm?=
 =?utf-8?B?T3g5bVBWRlQ3M3RSQnNPdjJYdEJKcEo1UDlwUWE2VmI2cVhwTEx2LzNKdlkv?=
 =?utf-8?B?QTBqSk93dy9QaGx4Y0ZkbkxLTHBWMFRBZFoyNnN3Z0l6UGE3UU9kM1FaRWF0?=
 =?utf-8?B?MHdRRDVQc3Y0M0w2MWFyc3hMWHEyYU5oVzBkWHJSYU56TDV4NFlabWkzQlpS?=
 =?utf-8?B?eEJEd1BWVUJkQ05qTmZSUG9WTWlIVXp3SGVMcEZjUVFXTUNEeHBXcHFGTEdl?=
 =?utf-8?B?bDErSU93Qnh0UlNZSG5Wd2hieEI1SUZqOGdmVWFYWDhOTjBYbElGbkpFSVFM?=
 =?utf-8?B?cmRMREkwRzVJenlxaDlRY1hlZjdZdzlCZUtiOG5aaDZjSFE5ZEc2TkthVGE5?=
 =?utf-8?B?ZEE1VGlDaUx0cVVIQnVpN2xmS0dpaGkxcmtWYm9oc1ZJakU0NE9YK3BmTDRa?=
 =?utf-8?B?Q1BrZEEzQnVNaTE1SWhhUXB4WEV6dGxQckE1cjNzd1dKdFJnbzZySTJkUkRP?=
 =?utf-8?B?MEZISVBOTllPNFpmNHBpUHYrb0NKR3ZHUkUzNExSOFlwdW92TmVXQzJ3RXl6?=
 =?utf-8?B?T3R2MjdxSjFHN05qNWFaK1FqWE5obSs1bUtxV3JtdGcyM0wweE5TS3pGS1F2?=
 =?utf-8?B?bERNTWRoS01LbE92SU1OUzBvc2c1OVpKTXRZb2NVVUhNMkFNNEVPZ1pyQkQ5?=
 =?utf-8?B?cWdjbzVHbjlKR2xJcXZWM3RFaVJ0Uy8yRndXRkQ5dmlEeHNJOFJrMlB0N2VL?=
 =?utf-8?B?c0tUNUkzSzFNY0ZFVzhQQVVGc293bllBZzhPMUdtem5tMzZiU3A0dVZ6UEY5?=
 =?utf-8?B?Tk1Nd3R3TFNnR3VWdSsrWTdYMTA3TEJNbFVzcWdNTXgwSlRFSzF5K3JvWHpN?=
 =?utf-8?B?ZWpyQWEwSXBlS1Nuc05CRVdQRDJYbHZRYk5qZ21LQkxteXZKb3lWNGlpem94?=
 =?utf-8?B?d0haSUc1dXNSODNuYW5XekI4RDhySUNVM0xRcGhCOUYrMVluSGhadUNjOUxj?=
 =?utf-8?B?THNOcWRha0J1YkZiU0IvMXA1WHlOT2JHK3dGSmZGdkhKY2JsK1R0S3JpRzZv?=
 =?utf-8?B?SVladDRrSko0VlhzSDF2bm1DZjh6UkFSekFOTEVITjdqUzU4RlNObVc5Ymt5?=
 =?utf-8?B?b0ZlNDJzNXlDZUtFU2JZenpGdVdtbnBpZjlJVm55ck85Y0hFaUVUNDV0OWdv?=
 =?utf-8?B?ZDhNTVFLb1RjM3JzZmp4WXdaQ2hQeUxkUFA3VlFXVGJRVVVNUER5bmIyMVdQ?=
 =?utf-8?B?blg4S3ZjUWR1aEJoTnE4T0pobm4zN0FlS2duZDlITk1KRUVUbXJ5RWRmQTFn?=
 =?utf-8?B?MHRYRVpZZzI0d01kZTg5WFoydkMwZFlhNEFYWXVDaGRqNlFrZGs3aTNqNUZV?=
 =?utf-8?B?Sitld2F2M3I4eEdjd0J1SURjQkUreGlCKytXVkkzK1pGVmRFaTlLZVhnRVph?=
 =?utf-8?B?Q1BaUm1DYlkzbTZmN2lsQlZjb01GK2FTcDRrSC9XblQyVmptdWQ4bDhJTENT?=
 =?utf-8?B?azNNY3RqclNLWlRjSVBQTW1GeTErQUFVc0w3MCtCS3VocTBDb2VWb3g5ckYv?=
 =?utf-8?B?Q1N0RGErZzRieDhwYXoxdEwvUms0WklUMkVTb3YxY0psWUQySjRWS1ZmaGx3?=
 =?utf-8?B?Y05YRDNOUEtOOWJxb3R5YzQzbFFxUjRYWTNBdEp6amlWU2N5a3E4dGdtNG5a?=
 =?utf-8?B?ZjFkZFBnOThmeEtEL04wMTdwQmkyOFNFcTVSVHpib0N1RXViVVYwYm5Rb01T?=
 =?utf-8?B?cS9EdU5zMDk0TVJYNzhLNEdET1k3bmorOFRIeDV2K0dkbXFoWjRKckMySE45?=
 =?utf-8?B?UTFoL2VpZG4zOEFGa2pNdFZTUktRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E11E59C59C9CC448446E9BCE1A3FF65@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vre56KqrZHHl5bF5dq4DqEpSaP0gYH2JGPs4Go9DJm9kLGdSuLR/1nlV5HU4y1mo4XMp7pxOBs06mOseBjYJ4XcMaRVcMei+UNsxSrsinyNkADqQ95Ft2p7kDixFFWuUI3uLVAeAMgnDC1pleozyB/qPUBWvEEM1XvfOofxjFlLEHlE90UeHXrtcI4DM8gcfhsQkeHQERUY8Y4uK0vvEav2LRwNTYHNcfX5u+8mAmMHXIP9lxlPDaULYuKKKmk1HcJ38E9j7oAr4TM3TO4PcDniO3VEz0w07vEdyAi1Svp+vAO0ZyXSRFdY8u1o7EqD2S6x7RCGCvXGE9xJplSVnIRPGodCJ09wZJaUHMbCXSr5/A8M8f+88zrxWMF3M/X8hOBf4C0uIHlx4yf5YYPfkvXI1P10/8TmLBmxOTM3DdKDA3jRK+9uOt5/3XLGLOHj8vL/YC563x3+wa4blXvfSl50SFujzmkmVgmNtg77Sdcg14HtTg25gxNUPGLojYuskkWPRxfGDNX1I6zedPHNvwqbQ4R+hstnQFFah5GZ2IZfgeEWtcIhwa9IyvS3DBC1tY/lomvYsGGUxJV+pMWURcVKZsu5Cu9DVvQUDFyVuzk4yiq375p0FKbvfmo2vGzIV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8980eeba-8844-44bc-c020-08de31a8b997
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 13:43:07.0623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Isbxs2kaJ8IvuypiEWSd4T1GwJtVlnN1z4qh8rYKboJVgwTYud/3CrK56gADSnypL+IMbrEB01S29zG8a2XdlWUMYqdOuYUzPXOroA+kJj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6671

T24gMTIvMi8yNSAyOjI5IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVHVlLCBE
ZWMgMDIsIDIwMjUgYXQgMTE6MTY6MzFBTSArMDEwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3Rl
Og0KPj4gSW4gY2FzZSBvZiBhIHpvbmVkIFJBSUQsIGl0IGNhbiBoYXBwZW4gdGhhdCBhIGRhdGEg
d3JpdGUgaXMgdGFyZ2V0aW5nIGENCj4+IHNlcXVlbnRpYWwgd3JpdGUgcmVxdWlyZWQgem9uZSBh
bmQgYSBjb252ZW50aW9uYWwgem9uZS4gSW4gdGhpcyBjYXNlIHRoZQ0KPj4gYmlvIHdpbGwgYmUg
bWFya2VkIGFzIFJFUV9PUF9aT05FX0FQUEVORCBidXQgZm9yIHRoZSBjb252ZW50aW9uYWwgem9u
ZSwNCj4+IHRoaXMgbmVlZHMgdG8gYmUgUkVRX09QX1dSSVRFLg0KPj4NCj4+IFRoaXMgaXMgYSBw
YXJ0aWFsIHJldmVydCBvZiBjb21taXQgZDVlNDM3N2Q1MDUxICgiYnRyZnM6IHNwbGl0IHpvbmUg
YXBwZW5kDQo+PiBiaW9zIGluIGJ0cmZzX3N1Ym1pdF9iaW8iKSB3aGljaCB3YXMgaW50cm9kdWNl
ZCBiZWZvcmUgem9uZWQgUkFJRC4NCj4gSG1tLCBob3cgZG9lcyB0aGUgQkxPQ0tfR1JPVVBfRkxB
R19TRVFVRU5USUFMX1pPTkUgZmxhZyB1c2VkIGJ5DQo+IGJ0cmZzX3VzZV96b25lX2FwcGVuZCBh
Y3R1YWxseSB3b3JrIGZvciB0aGUgcmFpZCBjb2RlPw0KDQoNCklmIG9uZSBvZiB0aGUgem9uZXMg
YmFja2luZyB0aGUgYmxvY2stZ3JvdXAgaXMgc2VxdWVudGlhbCB0aGUgZmxhZyBpcyANCnNldCwg
c2VlIGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfem9uZV9pbmZvKCkuDQoNCj4gRWl0aGVyIHdheSwg
dGhpcyBpcyBhIGJpdCB1Z2x5IGFzIHdlIG5vdyBzcGVjaWFsIGNhc2Ugem9uZSBhcHBlbmQgaW4N
Cj4gbXVsdGlwbGUgcGxhY2VzLiAgQ2FuIHdlIGp1c3QgcGFzcyB0aGUgdXNlX2FwcGVuZCBmbGFn
IGRvd24gdG8NCj4gYnRyZnNfc3VibWl0X2Rldl9iaW8gYW5kIG9ubHkgc2V0IFJFUV9PUF9aT05F
X0FQUEVORCB0aGVyZSB0byBrZWVwIGl0DQo+IGFsbCB0aWR5Pw0KTGV0IG1lIGhhdmUgYSBsb29r
IGhvdyB3ZSBjYW4gbWFrZSB0aGF0IG5vbi11Z2x5LiBPciBqdXN0IHVzZSANCmJ0cmZzX2Rldl9p
c19zZXF1ZW50aWFsKCkgaW4gYnRyZnNfc3VibWl0X2Rldl9iaW8oKSwgd2hpY2ggaXMgcHJvYmFi
bHkgDQpuaWNlciBhcyBpdCBkb2Vzbid0IG5lZWQgYSByYnRyZWUgbG9va3VwIGZvciB0aGUgYmxv
Y2stZ3JvdXAuDQo=


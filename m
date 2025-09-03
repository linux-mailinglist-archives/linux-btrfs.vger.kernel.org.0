Return-Path: <linux-btrfs+bounces-16609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3641B41708
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 09:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709811655B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 07:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDF2DE70D;
	Wed,  3 Sep 2025 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jka8T2E6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F1SXNsHE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01579CD
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Sep 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885349; cv=fail; b=HlZegoMQmZgaGDdPDY4YLxxFfhcutydIzS7cX0doeLaaWGKrcAajnCUkQ2Phe9KbK9ecuwFLIN2tnA0r7OzIyojwRE86chx7QT8vHIfUwWGRYOjTpjIH78hKiOfr9l+SBlGWg0UJ4HALbjVUuCWXH5sO5ULiz0viGY8jsIQYIPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885349; c=relaxed/simple;
	bh=qL7NuddvT2DXKAy4H1qnP8a49mzctDYnJMNzqeGjmck=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=etm5cQfd1S33LM5cn3gHK6ki6OYqVquPeewQ6dQbY0n9jABa4ha3QbwBOJ529tbVQ/1OOAFlZ2wxOhnUmryJsOw9DmuqTIDWXGEJij37JV7pICY5FBWZKMLTE25joZ4LRsJl0EQDy4TnvAwIyM96g56uEq2wPigq2EXYIxJZ/68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jka8T2E6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=F1SXNsHE; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756885347; x=1788421347;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=qL7NuddvT2DXKAy4H1qnP8a49mzctDYnJMNzqeGjmck=;
  b=jka8T2E6eq4DH7cKVBIa2a6H3t9OkMSbgluMzur6aMJfk5FQw+v2XLkk
   f5ajQrr/2ICx07K6NmB2o5rnf16cdVrGNWTiMY9tx+/noYJTnotKyhFsw
   iZ+4Q6HSWafCFJk9EJSGcyGHX7JFAv9oHcw9lY/0nUyCHwSBzAa5Nh3vm
   2gZdknyrMhSdYAZzLCFzxhdQdllXtLGGf53eM0uRrYsNzq2nAX3YIqiDm
   YFqtVTzcJPpSP/yIVGhNZ02cHHJFaSbtBwRfvaVVrrnlWLxqxtFGQy0uw
   fnhejSdI6Z/6DhZzwyG8+FCwn0HZOpqpyzEmgVEtQ7mKtDFITAqy7zokA
   Q==;
X-CSE-ConnectionGUID: uuSR2imERhO7wsX1ftsIAQ==
X-CSE-MsgGUID: fla+bitgTfit8Lv5PUrgKA==
X-IronPort-AV: E=Sophos;i="6.18,233,1751212800"; 
   d="scan'208";a="106627666"
Received: from mail-bn8nam04on2071.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([40.107.100.71])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2025 15:42:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oe5g2LwVEgivEU45wAxJo4+R5PJI4MSb+49Ct3MtbnrqqY8QlGOHxcl2dXecgDf+CWjzGaQjTTOUWcmyXAu4tS+wPhCOW4RKiyQYQru6qI0z6zU+fXWqa9qDzTFFwhe7riBbt7MiMZGxpCdsyyQq1Gqohx1TCSw761sYUiysRSu5oPPleH+5mDvKGdyXvbBLw1uonv2nlue3CnMRN79NftD44SLh8pC3AXYJIFVuYeo8jYQOt+flquFZLmLgL2IEaTMsaUjOTh1MR7vBxV3MNBc0XjbNDnk/NYAUZRNiQNlCXppnL+nWDFTbKh37STEL9loDRk3Zo51D+/8YLHrA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL7NuddvT2DXKAy4H1qnP8a49mzctDYnJMNzqeGjmck=;
 b=RmRlbEqkVoXxRRHh4AQvy6VMaNVuY+b++xWtqI7ztC7NxsgfHJcEegbyVR4/bkJoCwrE88B8bKcAyn0XkFOSNGPBS5vMR+xyg8QTWrd0GfGGVFKM7CcYfg7x1FrMmMsVBEZwakgO9p6d/VgxKNV3i9tuC0aXJ3CLgQ+nlPjUXGgzPxQL4t/W9MXvaNHXMEnBNay8T9bp2NzlmS+cnDYSupWRDJsu9zhz0h5Fy942b98YM+ImiJxnlIQ3ujI2QfBDyR7jE01HnST1OUMODtqtfW9CrleNJtXqLVmrnNWaXqxpP2W1L3PC9BGRZoN/TLSjlCb/TOpKJs9O7ZR8WccgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL7NuddvT2DXKAy4H1qnP8a49mzctDYnJMNzqeGjmck=;
 b=F1SXNsHEUf8s4mn1m3baKJG0cu3E4EiDiaetdvI66sO7vwBCcv4rhlx/BfbsaNaCS5cHQOAtE4CUrDc9zM7lWzZa9+Jo3zrG3C8Sr2TpaTKlhJlSJ+fHtj4313xmdFbq4/2QdBsC7Yd+yOEdAT1nJYJ5eFTT9dbCihDpaQqs5tI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by LV8PR04MB9176.namprd04.prod.outlook.com (2603:10b6:408:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 07:42:18 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 07:42:18 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: WenRuo Qu <wqu@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs-progs: tests: add {,cond_}wait_for_nullbdevs
Thread-Topic: [PATCH 2/3] btrfs-progs: tests: add {,cond_}wait_for_nullbdevs
Thread-Index: AQHcG8JMzRbPPvRfR0CUo87PswNtmLR/nNqAgAF35gA=
Date: Wed, 3 Sep 2025 07:42:17 +0000
Message-ID: <DCIZUQZGZZP2.3FTX5QSTUTI69@wdc.com>
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
 <20250902042920.4039355-3-naohiro.aota@wdc.com>
 <99046aa7-0737-4131-8790-2112d33a384f@suse.com>
In-Reply-To: <99046aa7-0737-4131-8790-2112d33a384f@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|LV8PR04MB9176:EE_
x-ms-office365-filtering-correlation-id: a0d3cb58-55b5-4e28-a10a-08ddeabd6884
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWFXZkV4K0FSS2hqcDEyRWZxS2NSY3dGTHlyQjZjWjNIcHFsTFVHeDBnT3hl?=
 =?utf-8?B?aDU1ZEx5YTl5UUFLNDBhZFhaN2Jyb0R5WnQ5cU9ZNWMwdWhHUEVXWjVxU3Jw?=
 =?utf-8?B?cFN4bjdFc3FaZHZQT0wwUEh3aVJFaFBnaEV2KzY3TWxTVFI1WWQxbk5CRFpo?=
 =?utf-8?B?ckZkdGRBSlJJK3U1d0c2bERyZ3k5YUpYWUJYcmtSNVg5S0EyeWJpNWxlZWoy?=
 =?utf-8?B?aEtaRUo4UUFDSDFPNlhxZHJGV0ZwMHA4OC9MNjVhdkZsWlAzazAyTTNNTDkv?=
 =?utf-8?B?d1l3cVZ5VFBpbDc5VVA1UVFKc1g1SGtNVFVncVlSUUEyNERKQXc2TlNtVGZU?=
 =?utf-8?B?cmVZRWk1dGFQb2hLd0V6RGh4ekluWUU0RjZUakVuaFVvdlYzTDl4NHJ2dEdS?=
 =?utf-8?B?TGdHL1VlV200YzBxeXpVWnVJRWFRUlVVUnJtRUR1emZpZm96ZG9MTXFyNm5G?=
 =?utf-8?B?enQ3SlB4Z0VFWWgxK3NHcHVPZE1HUjVSbjlEYUxNa0lRU2k3cnBnK1J0RDFM?=
 =?utf-8?B?S0dGejY0eGZKS001dnlVYmxDMGN3NmhNZ25jS2NTd1ZTRVJHN1MzaXZHWk5K?=
 =?utf-8?B?citRWVh3M0x3UHZiSzFUKzkrY1N3MkE2dWtSQjhpZnpURDFZRjJsZzA4Zmll?=
 =?utf-8?B?N3FsaU1YS2g3cHhrM3BOSUtMK3VOVldrVlMrckxrVVdVZ3FGV2ZtNmJxNWd4?=
 =?utf-8?B?WEh2TmJEaWx2KytabHp5YjhpV1F2VzdWYUh3b0RlY2kyRlpSNGMrcUttQlZ1?=
 =?utf-8?B?NGp1Z1R5QU8vMjRqcERJeWZYajRxb0FMUjdqYmNlRWF6M0xZWmNZYXZldkVw?=
 =?utf-8?B?bWgySEhCMmF5K3RIeVR4TERxVktyZldvRy9WMVRrV2NxYkFsMTFMcldjNTVP?=
 =?utf-8?B?QWdzRWRwQk84SkgyWEc2TXBrdE12L2xDVmhERTQ2aWxndVJINmdVWWc5TGk4?=
 =?utf-8?B?NU9vRGFFM3E1Q2VhUW9uUFQxMERacVJrN1UzeERCaUxCbjVtNVhXQ2Nsa2dO?=
 =?utf-8?B?YTBLQnNLVGxaVmNRQlk1NHM4R1NacitTdzgyeDkvUmk3SUxFeTJWdGVJMUsx?=
 =?utf-8?B?alFlT2Q1bk52MmhNTEwwSDBRbzBESWNPSENvL0lkdmovRXlwZVhHZlN4MTdL?=
 =?utf-8?B?eUdlbDJCcktXVmdCV015QVVtay9JSFJtTzFyMUM1UkNDVDA3SGJLenB6NExD?=
 =?utf-8?B?REhZR0FWYjhYZHBKS0lmMUUrc29JdzJabUVwc1dtS0x5VXlNdFMrVWI0a1o0?=
 =?utf-8?B?M0Irdjh0bExhNjhwNzFQOVFQUG9FWHRIOFZhTE9EVlp0ZXVjOHhxMWU4RFBM?=
 =?utf-8?B?SVdJalZlQXdGRjRPRmhkRHlvb1V3U1JiZVZYRnRaR3ZtYkc3ZEpCU203LzNr?=
 =?utf-8?B?ZDByZ1RMSG05RzhqTDVteDdiVnpnVEpXTlpIUDRNeHQ4Y2ZTMS9zL0gxVGlm?=
 =?utf-8?B?L2g5clpTblVMRCs0emVKeUp1Tm8vVmVvVUEvWmtTVVd5Zi9iai9QOTlvdnlY?=
 =?utf-8?B?RTdZMUZvNk41Vk9uZm5SMU1wVXBPMFhPRXJ6S3p6OWRqcCsraFpkY0NrRElj?=
 =?utf-8?B?Nzg3SlNXOEVuMGQzNmdxM3RKSFJwcEFRcU5ORW9SK1B3dzBIMUh4RjlUZ3J5?=
 =?utf-8?B?MTYweEdMRnIxcGNQUUZBckw4SytHbCsvTXFCSnliU1N1Y0V2d3VwRk83QmhN?=
 =?utf-8?B?MlVMYldUSUZqa09wZXBhRkRxZHkwNFNOajVzaUtzQWhCNjhTMHlSRXlnN3pN?=
 =?utf-8?B?QnhEMXM1ZGdtVXFSNlIvRnh5a2U3UC9VUGRaZzA5Ukt3b0plV1JTNUo1WmJx?=
 =?utf-8?B?MUd5UHYrZm1JcDB2dXVCVWh1S295T2tzWVo2bEdENWpqYmFJOW5HdmFidWNN?=
 =?utf-8?B?MUVGZ1huQlZEWTIvaW9QSnR5OEZCbkwvSzdIQytzQ1N4OEJwWlM3RXpESDVq?=
 =?utf-8?B?V3p4TWlhNVV5ZzU3enNESWNPNysvblVIWE1XOUlpSWFPaHE1UXBnUjZVa09n?=
 =?utf-8?B?VVRwSFJiZkVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVlYeW00WkJEU0szTGR4V2lGR05QbEo3K0d6OGFlQ2ExdFlENFJGY3U2T1dk?=
 =?utf-8?B?MHBkeFpEUGt6UnBvVGI3WC9JZm1BOXBDNGl1N3BvTzJKMTAweEplQm42dTRi?=
 =?utf-8?B?N2lXVFJ0OTlPVms0UFprbzJCaGwvWGorSmxINTN0VzVkSUI1Ym16UFA5SFpz?=
 =?utf-8?B?UEwwdDJCcWZnSkZXUkwrUml1cEt6dFRERDVVWG9CK0w3bjdaSnJCSUhRWUV5?=
 =?utf-8?B?NnR0RDlXdHpMeUdiSVFUSWJuMkJSZmhGbnRVRlBKc2R6Q0tiSGxVRVI5STE4?=
 =?utf-8?B?eXp0bjhjNStjN0MrUFRRT1BRaFFsM1YwUTNOZ2tzc2V3TDlJbXNOZVUwWXRq?=
 =?utf-8?B?RldFVkhTNjBvWjVGZ09lTG9MNWZ4VmRsM0dENlpkK2wwTjB5Q21HdysvUUhN?=
 =?utf-8?B?WDBMc2tJVmoxTGRsdHJaMmtCTDRNVVlwYzJaSzh2UktGNFBZVFc4ZlpjcmMy?=
 =?utf-8?B?c09Qc05JbFRsYWQxTEdSZHRaVUs5eFd1UlJUUWNqWWhZZkNoY2o1VWNWVEda?=
 =?utf-8?B?anh3Q09zemhQcVFYMTFXb0VJQ01maXcxN0JLS2pmaG9JV3pMY3VMaHh1eUV1?=
 =?utf-8?B?R0dreXBDOVdlcUxyR09BTzdWMDJzQjJrQVhPWVlWVTBoSVkxYVh1UWk3cDN2?=
 =?utf-8?B?NURkMTZacFBTYlVPRVpxRnNsR3FYVmhDSTZwZ01VNE5oN05LMjZNczFYSUxi?=
 =?utf-8?B?YVRpU3Rvc2RYUkdiR1Y1MWJYenVrSkZGVkFqNG1aem5iMmdxSXVCeExrTFNN?=
 =?utf-8?B?cnhROUU4eEFNaUdrZ0FtWTgrcTBNOHQrdGFJRnd6UkRyMmVSMjJ0bDJNN3hn?=
 =?utf-8?B?UFdnZC8rbmxpTjBzVGxkdm4wWjF2RUgranZpM2dHcENyZWNnckYxajdaSmd4?=
 =?utf-8?B?dGtZSVVEck53bTg1TDVTekhJT2k5WUw1ZlhtRlpKUmFXdVZidWdsR3JCbHNk?=
 =?utf-8?B?NHI3UkhNbEsyalRqYXg0U2lQbUk5cnVzV2Q1bGhRY1FiKzNYU0JVRWszTjFH?=
 =?utf-8?B?RHlZRi9ITGhHb3RmUjgxL2dCTU1ZZml3ZkQyMElvd1EvbjZVOE9nUFZaY2tS?=
 =?utf-8?B?UVdLUW5idHZFWmFLa0gxdmtyZVMxMDIwMkx0RExabTE1SFBWaElpZWdFY3ln?=
 =?utf-8?B?dFdIZEh3anZVc21TTVp0K2t1MFUyZkRIV043WW5ldGFhQUVQREp5TEQycEMz?=
 =?utf-8?B?U3dNSkhjbzJlbDNtUWFQeGd4blIvMlpFMWR6VURJbEE3VGhDa0hVSTY2YmVQ?=
 =?utf-8?B?N2Z6blRNNkJta25rZkVEMGJwZ3lxakVzSlpveUlrdVhlT0NpSklrZ2IyNDkx?=
 =?utf-8?B?aVBpT05BQWdXcWV6U3lJQVJoSWRReUNSZ3orMzR1MnNrMWcrdklFQWw0TVNr?=
 =?utf-8?B?bWdJVXQ4Q1I2bVZuN0NobEk0ankvWXA3Ry8rNmZCWWplenk0aVZIU1dKWU1B?=
 =?utf-8?B?eFdEc01mTzFsRjhMS2phMXJFY0tJaWM3RFRxL25MRW43a1hSdnM2MXBJUTFl?=
 =?utf-8?B?S1dONiszbFdHcmZvOHdjUGlyNkVaeERWbkpuMnZvVit2ckZuQWQ1VjJLYXA4?=
 =?utf-8?B?YU1DdDg0V0RicFJTZkZnbEg1SEU5TnV2M010cU54RklDemdaVmU3YTlVQkxo?=
 =?utf-8?B?bVUrYjZGYTEwd1huSlBLbnpBMFBPR1lKY0labXdFMTV5Zkp4Y0hNV3FVKzRP?=
 =?utf-8?B?NHIzRVpHVHdFM0hSUUlJMWtiRGNVbXZuYUR1OUZ6YlJQWmlrQVV2SDNnU1Nm?=
 =?utf-8?B?dmdmazhZNHRNMTFzdHhwVjdJOWZ3KzRjTUhqVHgwRmx4L2d2RVVNTGFkRmQ3?=
 =?utf-8?B?eHYwMkFjS1U5VGtEa2RWR21HcEVRa0toK2h4enRMbDdFOTgwTlBEejFhTXI2?=
 =?utf-8?B?dFNEbEova0ltUHA3cE5IZ25SVFR1Q21iR2VIYTE1TGhKdkJwNDJ0T3ViQlBx?=
 =?utf-8?B?N29yT2ppVnNVSDhWYmlkSVZlR3JQN3JFM1UyYnlMcnpIYUYrVlJad08zdTJC?=
 =?utf-8?B?TVQyZ0tWSGNnaGJzQUNMdWhFQWNEK1Fsc0xuTjJ1MnArYjJYTG01U0J0TVFE?=
 =?utf-8?B?STdGd1M4SlFUUDEyQ2p5UERZcExrSHM3YTJvazhrdEZTV0c2ZkVCcHRWbWlz?=
 =?utf-8?B?bG96U2I4S0tlNVlMbWlkNmFqbVZIamVGRVJ5bE9xaldpa0hZTHZCNEZhUVlM?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95C548C967D5154689292591054DDC33@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LbNTFR25FsWM3lJr1AXGd797ZB7EBAad2rwEqa5xkz07MAH4jBboZN6j9QL97BlXsGFSHuafkxnHhO+evcuzy5+MeDLWAnq3bGScwOrqe1F7xxEyimxJpGwLR95RIUifnlnw7byMN8TXOoBogIiKgEMXl9wlOB68zTawTZrtWaVA6zCBLgMq4G5BfZiR+K9I2BC3ZEHNhgGrYsuY/wwt/fdkuKB6pjE2iXSI5YHXTyf8JCQbDWd2pXIME23I6zDUMJZ6HMxY7uzqUByQlYCDwjHjRBbqQBNpEYoauJH3zlHbdSxd+vhG6CEVDYDgExUHF3fGhEnP3Bij1ycEYmwjPmmT7d0LzmcM6VUAG8TLy+1RCqoXy0RqTIGRkoysoBNnB5OfcHJm+iGkFkLSVCZksQ1fUQXcWZlTdmQ42YoB0ysWtIpWbZMQQlW5PtL7lh2DvrL0jKSBkt2ISi20mmhhJ52SgZir7Kz50BezEpoKg+kcp3xx8TPIN55fT+DgKE5MxGskbBUw/jDtJ4mEcdeTxz+JBibyLNKRMNNkgNKTNmE7l00IZXLeHIF1OTefmjOWiI7Uyn/pnM+nbTjiR/zjfxLlXaInGNPOteKY3aEFiHjDNCiLX2mF1/mkIQj/Wkcz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d3cb58-55b5-4e28-a10a-08ddeabd6884
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 07:42:17.9099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+4fA6d/SkYMd43lq4Q2hJC4PnAFpjx0v9g3lZQ+eAoiNcktY7eObhhjEkvePDrPn5t0f/BSqn3ZCjropnGjyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9176

T24gVHVlIFNlcCAyLCAyMDI1IGF0IDY6MTUgUE0gSlNULCBRdSBXZW5ydW8gd3JvdGU6DQo+DQo+
DQo+IOWcqCAyMDI1LzkvMiAxMzo1OSwgTmFvaGlybyBBb3RhIOWGmemBkzoNCj4+IEl0IGlzIGEg
bnVsbGIgdmVyc2lvbiBvZiB7LGNvbmRffXdhaXRfZm9yX2xvb3BkZXZzLiBJdCB3YWl0cyBmb3Ig
YWxsIHRoZQ0KPj4gbnVsbGIgZGV2aWNlcyBhcmUgcmVhZHkgdG8gdXNlLg0KPj4gDQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPj4gLS0tDQo+
PiAgIHRlc3RzL2NvbW1vbiB8IDE0ICsrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9jb21tb24gYi90
ZXN0cy9jb21tb24NCj4+IGluZGV4IDJjOTBhY2I5MGNmYy4uMWRmMzdjMzkwYmY2IDEwMDY0NA0K
Pj4gLS0tIGEvdGVzdHMvY29tbW9uDQo+PiArKysgYi90ZXN0cy9jb21tb24NCj4+IEBAIC05ODQs
NiArOTg0LDIwIEBAIGNsZWFudXBfbnVsbGJkZXZzKCkNCj4+ICAgCQluYW1lPSQoYmFzZW5hbWUg
IiRkZXYiKQ0KPj4gICAJCXJ1bl9jaGVjayAkU1VET19IRUxQRVIgIiRudWxsYiIgcm0gIiRuYW1l
Ig0KPj4gICAJZG9uZQ0KPj4gKwl1bnNldCBudWxsYl9kZXZzDQo+PiArfQ0KPj4gKw0KPj4gK3dh
aXRfZm9yX251bGxiZGV2cygpDQo+PiArew0KPj4gKwlmb3IgZGV2IGluICR7bnVsbGJfZGV2c1tA
XX07IGRvDQo+PiArCQlydW5fbWF5ZmFpbCAkU1VET19IRUxQRVIgIiRUT1AvYnRyZnMiIGRldmlj
ZSByZWFkeSAiJGRldiINCj4+ICsJZG9uZQ0KPj4gK30NCj4+ICsNCj4+ICtjb25kX3dhaXRfZm9y
X251bGxiZGV2cygpIHsNCj4+ICsJaWYgWyAtbiAiJHtudWxsYl9kZXZzWzFdfSIgXTsgdGhlbg0K
Pj4gKwkJd2FpdF9mb3JfbnVsbGJkZXZzDQo+PiArCWZpDQo+DQo+IEkgZ3Vlc3Mgd2UgZG9uJ3Qg
bmVlZCBjb25kX3dhaXRfZm9yX251bW1iZGV2cygpPw0KPg0KPiBBcyBpZiBudWxsYl9kZXZzIGFy
cmF5IGlzIG5vdCBkZWZpbmVkL2VtcHR5LCB0aGUgZm9yIGxvb3AgaW5zaWRlIA0KPiB3YWl0X2Zv
cl9udWxsYmRldnMoKSB3aWxsIGRvIG5vdGhpbmcgYW55d2F5Lg0KDQpBaCwgeWVzLCB0aGF0J3Mg
Y29ycmVjdC4gSSBmb2xsb3dlZCBjb25kX3dhaXRfZm9yX2xvb3BkZXZzIGhlcmUuIE1heWJlLA0K
d2Ugc2hvdWxkIGRyb3Agd2FpdF9mb3JfbG9vcGRldnMgYW5kIGNvbnZlcnQgdGhlIGNhbGxlcnMg
YXMgd2VsLg0KDQo+DQo+IFRoYW5rcywNCj4gUXUNCj4NCj4+ICAgfQ0KPj4gICANCj4+ICAgaW5p
dF9lbnYoKQ0K


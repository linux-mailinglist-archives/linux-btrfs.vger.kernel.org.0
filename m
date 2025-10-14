Return-Path: <linux-btrfs+bounces-17766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E61CDBD7CFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 09:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C83394EB48E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F380305E38;
	Tue, 14 Oct 2025 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qt9ZK4jw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UWDYuqki"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610423CE
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760425729; cv=fail; b=BQHQTvMf4xszhgUmLr9utFQT48PQ35ctlfGedOO5ZREl1Dfyw8FXSCshxFjrCAtehV30TjCrZDeLALOtmfr6/+IqUhr8MwyjMsisA90SuNDG2VJGpv5nZLIHIfaB3Qz/wHR0d2z3U7xUVb1n1OwzyFtDPxWhVVy0cMoodoJN1NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760425729; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ut//nCJktFes6iErLhSlzQHxRfmmW8dG8JZpvHvocWH2pdVCctY0I1UKKje9Aa2u2zkFCVXDvt9yqE+8u9pDaTEMS3QNc27ud8OCmlDDneYstJ7mMHLsoQA7e7h4d5izeaRULSSsfGX0wPKIdOhXoFFfO8EdKITLsITDtHXZE8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qt9ZK4jw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UWDYuqki; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760425727; x=1791961727;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=qt9ZK4jw/IDom9zvILcIX/XdwSPQTltKGGAcJdR+WiqOtm+E/JK3WcX9
   BOeEJlkMaXw09iaqxID9YctSmJaNn3IS6d3tru0W86EFzv1sLuo2cyQ9B
   aniw2d3K3GCOj/7NUM9Gf+Ph5DmiUN+BlXWOedICpdNGYZmVs4EwR1m5S
   79GzQnbFjeR9AbNZIJEN27L+Ho3xQBRy6I9UrtnSS6AqewvtPdijNMRua
   fUQkmaFMD8MblhuXpld5xeYxtXpIHDm/mZ6eg4dCuP9G4ZU1iWZfR+BCb
   JT5vfRXXUNHNVgMEC6CtIsAX93YN1m1/zVOE7uGcHQrSTZLMVhmalk4Zc
   g==;
X-CSE-ConnectionGUID: y7ev/cd7TxOkvqskSyLBmg==
X-CSE-MsgGUID: kIeChpK/RESxHG74M+qBsg==
X-IronPort-AV: E=Sophos;i="6.19,227,1754928000"; 
   d="scan'208";a="133173101"
Received: from mail-eastusazon11011015.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 15:08:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiwwFrf61RMJbPUGai9eIMuxCbwtbkfwIij3LkzKEm1j9xiWSgnHuzPULySNQFKyVA1iNvtrK/3xp0MOPzQOnnRyDriolFUoRM14M/wii3KHSa2VGOvmm5vV4jtxgdN9JHj2OlrZIb1f9vjF0MMChnawMukE+RM1vaVSnEHOGa3ZAO5zaGvqqI25Chl/JDEZLNRJRPYmJRIXdTv9qwc+LVvxntlhgDo3XW6iD+L8hSvUWn+BHxKYfo7JIcgdHMHN5084gFzdLPQNnUDqTFb0eRoUE/CJbdpbuIzKEaur73qrOJM56lBl7huTKNpeNtX2+ed7GiCfDhZmGsb9nx+EKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=IfLIQEPvlgZrHLg6Fa2Wc13CJX4wUDpn2UCMUWVYuLgLeo1mfPDyP2MwsG2STKGlY/il6xcyrRbTIKe03CpfYIno5h50QSyWo6OtzwI8Us4gvfM0kINSpGqcE/PN3Z9/bWUdcOm1CmL8ot6zZl4iskhbJeszpO/+ZTc9IciYh42eSKQRX8Rkx+iX5H8BPcOBsxPUs/khCZR4w3T1wcm9bw/EI0nutByyRK5LMXQnjAJLvvifaZI6lFnYZ88zvS2c28bHhAh3Lodd/8WrO3JjrylIibSLOfFV1FQFyDxjzBQZvMj1b+mSaSrE2cMA4oi6GQBV5+orn9zkV/BXq9cpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=UWDYuqkiKf0Sxo1X2P7SkRQfo65k/rbUgySe81ECrLYPpq+ajbv6Kl4f77ehzcAVYPQIDzejvRqO0hMbgIoNtaMSjMz62Z/clKel8fnqCgW1RmdVT9SAnqURQP8Z3HYRsbd5mbsSn4XPoHPm7D3Z2b3cMynmWO22yRKxNyPtMx8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH8PR04MB8687.namprd04.prod.outlook.com (2603:10b6:510:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 07:08:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 07:08:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/16] btrfs: remove fs_info argument from space_info
 functions
Thread-Topic: [PATCH 00/16] btrfs: remove fs_info argument from space_info
 functions
Thread-Index: AQHcPGgrt0JqyHjKb06KlciPS3lOtLTBOeiA
Date: Tue, 14 Oct 2025 07:08:37 +0000
Message-ID: <2daa7908-43cd-4275-bf23-a05c2007e541@wdc.com>
References: <cover.1760376569.git.fdmanana@suse.com>
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH8PR04MB8687:EE_
x-ms-office365-filtering-correlation-id: ccf6a5a2-d505-4ef7-9eeb-08de0af07f25
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUQ5aW5RY0xlTU13ZEVKaFV3eW95OXVmNys4d2RFVE44ZmJ1MlJJTTB4VE1K?=
 =?utf-8?B?bmIzOUhJRWVWTWdIdXBuZ1RMV3Q2b25HaXI1MFRPZWZpTVVnV3JMeWlQYWMv?=
 =?utf-8?B?L00yVDM0TU1ZbkRQUityUVF1WnBtMG94WSszWDN0ZWVyVW1QWlBqMHhMNjRP?=
 =?utf-8?B?UzYzK3hGWHd4bllMejN4YzVxZ1M3UVRQYllzd1dIZjlvcmlrU2lXYzdIb3pv?=
 =?utf-8?B?K3VONGZmVnVvaFNuZXN1Z3lMQ3hLM3pxQ1JsYzZZN3l1TUlyU2xZZnRSeFlM?=
 =?utf-8?B?WFduclBaaWk4WGNneFNlZ2V6NDdrTkh6TzNvSDVYMVdiOFo5SDNQSXRadXln?=
 =?utf-8?B?UE53OXpObVhkSlJWWXJZQlV3cTB2VVhLQlIraUovVXZqQVRpdEVmeWEzQlla?=
 =?utf-8?B?ZHV3cnNFWnlibXFFQ1JzM3poTlJ4aHNwTVd5NERhcUNPWVlyRW5UL1NPVEZL?=
 =?utf-8?B?QVNxMnJKbnA2WXhObnBxTmFXeGlQTUhlR0l2dWdzZVpqeFRMWkY4NDkwc0xx?=
 =?utf-8?B?dmZGVVEyWE1MMmJ1ZFhERTBNZ0dXM1k0cVV3clR0RTRwYWJnQjVpNHFhS0F0?=
 =?utf-8?B?TXNTRXM5SU1ETlM1N2ptMzE1R2Qxc1Y4MjZvcDRCWTR3RVdDcXpTeWxXbDJE?=
 =?utf-8?B?WmxZSzZpcFhRa2lDRkU5NEtEN1ozV0Rza2hHcWNmUWdnbXNXZ3ZZUnREaWJO?=
 =?utf-8?B?VzU0U3pLc0taL3NKNnpuY2J0SzNpbjhOMkZEdzFTcStObkZ0eWRjbkFsTWkw?=
 =?utf-8?B?VmV4KzBReHdIT0t2RWFvUGtINmFXd3VjYWg2aVpBUWZZUU40UUJCWDYxMVo0?=
 =?utf-8?B?eC9wYTN1ZW9WWXV4ZnB4ZmJzdjN0amVZTGhoVGUwMlV4MzRpSFgrNkdvMm5x?=
 =?utf-8?B?NSt2amFrYzJjN3BVNkZVYWdpV1lzSS9JUVBpL1E4UlJVZFIxSUhNdzZxOFMz?=
 =?utf-8?B?MmFyVVQ5d1FSekJEclhiVTVWTnUxNlh4NHIxVmp5amVKZTJSWFhWSUN5ekdS?=
 =?utf-8?B?NE51OFBtNm9aTXdXUmhIa1pyVjR0clo3TktneWhzbnBQQ0c1Ums1L21XWnRR?=
 =?utf-8?B?K3VWN2JqVmFzM2c2a0xnamJZR2JvV3NubFlTY250RXVSd3VvN2ZremZ5N0FL?=
 =?utf-8?B?NDEzcXgwYmNMenhlNFVBNmQyU2g2dVVTNUtlSmdoMkJhTkJ1NGVJYWVFTjF4?=
 =?utf-8?B?SVF0eldScEVKUWNIbW5ENXV2ZlQrU2o5TzRpdjZGOGJzMzRmS0E3S0VkWHFT?=
 =?utf-8?B?TGN2VWx5WURkQzlBVHY1dmFJZzVYK0cxL082SHRIenpDdExaRnUzTGJMU3BT?=
 =?utf-8?B?NVc5T3kvaHpQNDdCanpmakIxTTZONnJPY0JLOUV4UXN3L0tlL0JHZUVwaEt6?=
 =?utf-8?B?ak5jZnFFcGdPaktYclZiUmJXeTZyeHp3dlRHcFdvMG5rVlNzbis4RzVzQ1py?=
 =?utf-8?B?MEVUMDRBMlNpV1dtb0hoTlRvQW1UNDNEVkZVdFNCM0NzaHBHMzAwUVFjRkF3?=
 =?utf-8?B?MTRlMWEvblVSRXVOYWdaQ3BvSU5LcXIxMk1JWjdKRlZaN0dKd05lT1IxSHFI?=
 =?utf-8?B?N20yK0xkcWZQazJmenI3K05FTHZPTEpSUlRTOFFUYTdhenRuZ1Q2akRBbGxj?=
 =?utf-8?B?cWNmWmJna1VlM1duU3FVMFpFbmtIb282a3lXNWJ0NWtqOXRzclNBMm5PQ1p6?=
 =?utf-8?B?eDlycXorSjdNUXVsRmpGUnJIQm85QXhSZlN5dU8yS1FLd0VoV1EvZ0gwejBv?=
 =?utf-8?B?SWp1UEYvLzFQWWxkQ2FpTUFqV3pVenI0aWZJYWNremgrazg4WmNVRnNYeTIw?=
 =?utf-8?B?eWNLenRUUkEyQjZLRUJ4cnFWejFOc0FxRTc4QmFmbENSZUZ5Q1RGc3gvTlFX?=
 =?utf-8?B?UHNWekgvSmxNY01tc3ZlRVlUeHBoT2lkWHFyeXJxNkgzdlhIVlNSaVRuZkxj?=
 =?utf-8?B?TGhaMDJwbCs4ZkxMWGVVSk9jRUw0SVVqeUZZRW5QZUVtRnpWQjNORzVxVUdl?=
 =?utf-8?B?eHRpS0RCWlVob05rWElwc3FiOG11dndkSFR5Q3FyNDdFSVB0Q0JLSVF2bWNx?=
 =?utf-8?Q?zBWezA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anlYOXJpaGxrWXBrWXZML3BkaWM1dEMrbzBmWTY4NGxtTmpkbFZMVnR4L2xK?=
 =?utf-8?B?TTdKN0VTN1pvRkppdjVoUW0yUTVlTGdlbSsvK1UvWmV0S2VrZWxRQ1ZqVWdF?=
 =?utf-8?B?Rk9oUnR6aFdnY3doTVIwbzRpMW96eFBXUWlRR0hUOWYwdWgwMFdnUXQ2OGJx?=
 =?utf-8?B?SlVUUHZXYW5iQUNUUEVPNmZVK2g0ZWRNSzRjZEZPZWlCRkVnY0RWQXdMWWQ5?=
 =?utf-8?B?T3VHdDdlSzc5VDl5QzdicVAvdVZXV2g5RHJiSEUzS3pHaWc2V1NjeTFUYVhD?=
 =?utf-8?B?U2RScUdOQVN2VGRxaFVYNWNXbTFUTGJTVjZhUk5VV0FXcktxeHRSVjJzRUpY?=
 =?utf-8?B?dzBqeGZBeThZaWJ3L2VFaFF1cVNZYXU2ZVJYaWJCQ1IxT0RpWDFWZHZnelJp?=
 =?utf-8?B?S0pzQjU2MUd1Slg4Rlo2WDVQZkd5eGZTKzcySkk2Sk5BYXlNRENpWmsvNm9F?=
 =?utf-8?B?a2srSjRaVlhSc0ZFVTNPSnh6ZEU2TzZKMWNyRkdJSHk4cU1Belg3VUVIb1Fk?=
 =?utf-8?B?dkszNDRGN3lUY0NxWlhIUU5TTTZkMzI5U0ZnTHJqbm9EcWRiSS9NeEFld3Qy?=
 =?utf-8?B?SWZ0Vm95M1IweC8ycm5MeFVhcWNKYlczYXducEhEN0hibWRvd0x4UnFRVWlW?=
 =?utf-8?B?RFpqNEkyRTNVeUhia1piL2IxT2ZRY2pxaUtBK0xBcFh0b2FJMkZYTzMrc1NJ?=
 =?utf-8?B?S0RiUzV0THJHb1pWb3l4QTRZY0FCNkRxMHR1SDd3TlE3MXZyU2szVVZodVR2?=
 =?utf-8?B?Sk5nc0t5YmJVZlZjTWcxMEl0cWxLa1RZZUdVNUZnVUFQbWhwR3htTCthZjBD?=
 =?utf-8?B?dGxoc2JwOEZiK25pcHV5QXdGaW9tR3NjVnRWNXF3RXY2Nnh6c1U3elhsYkN0?=
 =?utf-8?B?bTlYeEloNTdOUkNMbk5Mdm9WcEM5dzN5ZWJSSDJING9nampDZUk3NWwzVGpW?=
 =?utf-8?B?U0gwdmp0OGVDL0FUdWxNWWVPeW5DR2YwWlJwVlhaQ1pWNGxUSDBNYndSWE13?=
 =?utf-8?B?TGF2Y0lWUkozSkJVaW5oc1NGY1hIMXM2cVlqcnRDV0xKMTE3Z3JrZmFJV1h6?=
 =?utf-8?B?UHdGays1RnV3RkROUGVpdUxBYlhSNlVuY1h6YmQyaEh2bGxsOUpVa0kycVlF?=
 =?utf-8?B?MHJiUE84ek1ZSU9DOWIrNnBVOXFkZDJtZk9tb0J6K0tiWFFkT1pjRGthQTY2?=
 =?utf-8?B?M2dhRW52QllhQmFCT0R6eW1QcjJ2WnpURUtFRWlTcU01eEVDaDB3L1pkYnNJ?=
 =?utf-8?B?REp3clUyYWQ2NlFqU25BVHd1cUtscENLUzE3M25ZZGVCN3RCL1NWQ0RKRE15?=
 =?utf-8?B?ZlVGMk83bThPVTJoKzZ5c3RsNUxwTmMvdG1XQUJCaTdoODZkVzlmVUl1ZzVa?=
 =?utf-8?B?OHE3TUhyOWUvOGRFQUp1Q09YWjhBMFJaMnpCUi9DVjdZVmtpVVdncG9qdHlh?=
 =?utf-8?B?TVIyVGVlR1h6SXpEbEZVNThuVVlUUXVBeG5DS1RzOERmek16aXcwcWZSNHhi?=
 =?utf-8?B?TXRaWXJ5RzBsSnpKMVpJYWlVMFV2cWQ1dVlHQWZvSThmQkpMcnBpOVAxVjQr?=
 =?utf-8?B?cWxJWG9JSVUvdVVKRDRQTnEyOEQraktBK1AxZllUWW96QzBWblJXZnM3QkhH?=
 =?utf-8?B?Ylgwa2JSclhDMVhQd1p4NTVadWczRnZnOXlkZ0dieUxIQ09vRXB4NnFLY3Uv?=
 =?utf-8?B?UEpZbDFZYW03eTJUbXBEL2FobVdQbElHUEhYaGdGVHdBaDh1SmVCQmFUcXhL?=
 =?utf-8?B?dmNwRjgrR0QwOTNmWVk0ZkVKOVF4UG5XcDdaeFQ4NlFyRmdua21HbGc1MkE1?=
 =?utf-8?B?VTRFMFpQbW4xcUlxajNrR0tjSXZPQklic25ZNmZzdTRaUGtHUWhuTUxwbW1j?=
 =?utf-8?B?T3VwMkhqK1htUDI2Wk50SjBwZEQxZSt6REEzK0VncFhieGJNSjNRTnJsbWhV?=
 =?utf-8?B?Q09xWmpQL1ZlQmYzVlBpUWpLSHpTemN0WTd0SGUzaFgzNngwMlRnK1MvZGxz?=
 =?utf-8?B?ZFcwM3VaaVBYTGpxalVhaS80V3dzV1NnSzVtOGZ6THhCYnREVjJTNFhGajdn?=
 =?utf-8?B?eTBuckhWWjBlUjllWjNzakZic1J6WU5SdTNDcko1cVpqK09YdFljMUpDakZW?=
 =?utf-8?B?cG8rUVliYnRuanV5dDlBMy9kME5ab3FoWWo1anpCbVFOeW45R0xPTTc0Y1No?=
 =?utf-8?B?Z1VwYjR2Yml1YWU0a2xLUjdHNGgwMmxsVnRrbFZwQWZzdzhycTlGUm9GbXJM?=
 =?utf-8?B?MVBuUEQ1bWpEMFN6NjRKUmI5SVZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB5E3C20DD46C14D89F2FCC27CDBD2DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RukLq6cuusiyZLmOd1QqhiASloEKb62zGBi7SdkbdGhBAER8NDz4bJrbCtHwMRusqgwmnMRmCLQk4ywZbWx62hzVAv87tlmrP/p9mKnYTA3YW6CSLYWfKMkMCMDHQFcCA/SePOo9m9q50NCz3Aqq9OLvnXY2TMJ7eaOnoDkZYpuxohQ87X+n3e6MLuY/NwzMKr5tcyuZcyGp1uzm01/eCMt03YPhdibyUdFx6mntfGLtF2rwRpHMi4ktFjK/ceUiLvNlv2QVvd3uqog6PrBcSD3HESWIMldD5co3dkD+2ewbDS52motX2Xu+0VxgcMTerFLDab/FCDuZORJsH2NLlUT3+5h3p8mqFSomvLrLKuicBp+uFSEC8haiFMnEpSMOmjXwdXWUUhgYS49e88hl/xfcRf6STxOQKJtpjdvlMNK5hhsC7f4oi4WhyRWgQxkWqYIMKQOnmR+Irt4a4OQX0I01X9IJQnduJZhypJQKECbJasaZXWhIndA866dZzV62Io9kQ7O5K3AICyqcT7zjCnCP8CbcYB5tUlKY3Znd/X9taDXgScaKSQ8u58dm9LZF95P2Vu/ss0i4TiuIXUKnty/8qyIk3QytjDfKjrdoZHQNE7wMIkQpwjx1RwKE36H5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf6a5a2-d505-4ef7-9eeb-08de0af07f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 07:08:37.4325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPjmyfk4fSdGO5UvzYcA4+9KncvbZNUQ75QYkYM3kpstPYq+UM9AzakSampKv7X44EU1pVm0oFPhkwJdMoJ9lH2BosyXLngj1c9Bn/3c99Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8687

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


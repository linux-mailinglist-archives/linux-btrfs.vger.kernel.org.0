Return-Path: <linux-btrfs+bounces-4346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B22C8A8215
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B98B25331
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD613C9AD;
	Wed, 17 Apr 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YUm91UWl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IjaOnNP6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9DE13342F
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353341; cv=fail; b=dgj4Ew8mRZC7rZPqI2D96fdLQq7HdPfEd23vH8M0s36wIxLphajiXFJwkCLvNnS0ICbbT2nsm8+7fs/Me7B2l15P2tNjB+TbKyhzMz87KS9LVYaYn7c7witclnbpLg2Jebupn+LMQfT6EHSb8Gnl19yaZa/KLfksSFG5SsAdodI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353341; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GLIVjuy0UYKapEnDqk3Xe6hKIQ0cbuvqp8idES4DlpmK1gP5fX7z5vWOamP9HeltlLNBqHpcAHMbWTWFoii23naoTR0gpxq9iJev+QQVlxnk3ZRAWHGLJR0gcFvlqyFvOKUAQ0ZUF5iROZUcvZzv4d4B+goV8ZScv4uC5MZMLNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YUm91UWl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IjaOnNP6; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713353340; x=1744889340;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=YUm91UWlulKzQ4meU7KbWFyVui9xkiWVH1w3H1/8RnX9llKREfZX3oAH
   jEXH2iWlImQSe2keBP7qwDobufPHy9zJ4lQn9K+s6zDiCWzv3I2V76b5w
   TMTJtFNropZaWe3r/BOpwHjtggHiYNrQ9DkYarorxfw6tmBtNfNabu7si
   B3TfiLHcfAcBGkFzsIOtLIPkR1ALwlLqmL0qEVwzBZHdAoWOjAltzbqA/
   DmAo84RjaXq3M/wGvezA4i3HpheskuVYEKwFtAJrHEvoh9Wt6KdcGWtyp
   RqOjwuI+LCuHxJRtJozKq7qDlIji/UWYGULExxNsvh9O/8Q0qD8+tt3wS
   w==;
X-CSE-ConnectionGUID: 9HdDcYWJRw60qTjSbSFGFA==
X-CSE-MsgGUID: h3/4V3m4Tg2aqXilvfSpRA==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14916892"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:28:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUeuJjmvZl0QJ6Vev236OvUOws+ZFOAK3t1cJLC3NJ+5JA+qsZaNB/aK30HVIQ4elFO7XUT+iBUlhosA6MKqPLLKpMMhb7y9Vn9u58xCBmCcEtr2VBasUQUgiF07AMqQn3ob3NGsPqguw8JDCRNjl0qXUIKH0xOTEiXtflCYVjASr28QwSW/LztSZ7+YB/QFsz9c5G31UT5c2FZOg19Lo4j+tA2AEraPkPVhk9jWjgy0G9jCOmZcMIh+GP7DqdbgoGA0z9ZMwJAWKrDwXIa26Y932MmMBOZMA4c0t+QqCSG0AUB3F6oa/P1CFVe9o7QERxMB3nQ0dBghrYWNHB6ZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=hKyFZ+s2AkbWLN3BVylhOuZfztdPy1nHIJu/B6SOUFb9ikMJ/g+AWawO4DzcprcdMRvDrfySMojCf8dkZ82VtUQVh6KKMx/b86X+at2S5YJPl65aus055s5PkWLPijLhZp+IubRLZNcG3mk3f4tKsHm665WvQRo3wri+CC+brnFuHZPBZyK9iu/c7ocXU/ubBKnPUV0AaCGfHoINkGP5U7kxubBzWHnN3hlZmQH0mPDJZKLmo6cOl9qbAZC8II7khWjgtY9TwEFKk66L2MAFgnJLP9VbVFhPyKSOxQ4m3npmbZvMVMSLpW98L/3+KDQIAj95dCWiWhRtFyLbOdEjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=IjaOnNP6lLpRBLZ3qdxUeluj4BkwJPDQ6xHLsZ6DsdWLCWXHZK7IeVjiU1cijec0pS0akbBMxqMoF1IuaX/XEFfxXF8A7jOJn4X5tgtUMDY51uxk+bqD52Ydn/nN8+MHMTnbn2HoM2/Sq892coG7hA5hiEw7lTec217GqWWJxE0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO1PR04MB8249.namprd04.prod.outlook.com (2603:10b6:303:160::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:28:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:28:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] btrfs: be better releasing extent maps at
 try_release_extent_mapping()
Thread-Topic: [PATCH 4/5] btrfs: be better releasing extent maps at
 try_release_extent_mapping()
Thread-Index: AQHakLcwGEWk6ZDquUy8VH6QKnRQg7FsU28A
Date: Wed, 17 Apr 2024 11:28:57 +0000
Message-ID: <e45e03a8-5a03-4a7a-8f2e-bdf653469115@wdc.com>
References: <cover.1713302470.git.fdmanana@suse.com>
 <225a3fc5fdbe804cf40dabe27f0d8a9f07f9a1d3.1713302470.git.fdmanana@suse.com>
In-Reply-To:
 <225a3fc5fdbe804cf40dabe27f0d8a9f07f9a1d3.1713302470.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO1PR04MB8249:EE_
x-ms-office365-filtering-correlation-id: 60e4d1c7-477a-47a3-d67b-08dc5ed1920d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CHdWuTGuUuwiXvs7q89SZpIqYUd3HBIZ2cIfRCjLtzFSRDhe4ps9aoguO5USM9f28mDTm7NTtb6JxF+bA5ETxaSqFUgoYZ0ymQPNA1d982WiTU8gFbYOjOMd8dGlUAcw1KVU3/Kpwp+m0vFXngL7PdEHRgbbiI7PxJHy9Uw2pEt1WbQz8t9GBT994ercuXSg8jBM0PzColaXicH5BUNrdTfcHI42qGrmqszWkbvwHxga1Dpx4Yfh0nCXtpyTKqksagk+MauT5QVunNjkkL2pYjQNw63kN1ROjZPJasyF1I6ovqU5W2iJ+EjlO+XgKhbBfiPcoa9A0c4BiP2BZCiNw0zW905OFWNVH+Z/VqGIoyYK14bWvygBBRg3yuX1VrY96hskmrim5g18Nb+ouIiw8SMXitS+rDWjLeTG3KXkjx0cjpIRw1LqrMeH4H6extzGcVwGcyVOvls8EkutTtaKUVD4SWvmxTpqdvKLqqeCL2hBdExVkQFX/tLAZc4Am3D5/BXDc6hpq6+C57FqWJxxzlLiZ0FSIfVUhsoAg4Wb3SXIFEXL0gXdyz0JSKlygBX/pZF8F7s89v/gusNwaV8amau8AvcTofOLVF2e6d+zpv9bzbVPxSOKNLVgZXwPPUcytmH0PFdHAvu+tL3Dk51B/elOfLpS63VgR3i32U3s543dJaDHxqVbIAx9wGHXdRZBswt9RiIBwCS5IzOA4UM3XFNCP+n0M5SoqChD+nAEM6Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2k0ZWlhYS9BZnZlZk1UY0dyMUx2Q1FtcVN6WFhpUDk3VksyaERmWHloOEYv?=
 =?utf-8?B?cmp4TWhKcjlONTZuejBpQVFUN3VQMk9NcEN4RXZPT1d6Ry9MOENWaXlVbkMv?=
 =?utf-8?B?cHMvZjRpT1UrdkQya3MzN0E0elY1cDVsT29Jb096VXI0K1FJWHFwY2RCNnpC?=
 =?utf-8?B?d1I4eVlUWitUZ0JuRyt6a004NmtKTDlmTGFHdlU1SEZsSmJpbDlQbi9OUk5z?=
 =?utf-8?B?UFgyN0dMT0hzN3JIU2tCRWdwVkdyL2dWVEFIUnAveG0rdDlnVFZLNUs0L0o4?=
 =?utf-8?B?U0ZMMnNCMlZZMU9RQ2xLVWRpMk5OM1F1QmJDamlJbFZPa1V6K1VOR3pFdkFq?=
 =?utf-8?B?LzZyQUcxL0h3SzJvWWFGb0xVTUdINlI4ZVE3WWJIdVJzRjFaZjZsR0prZzZF?=
 =?utf-8?B?K1JXdU1GRzJkRnNIRkpPaU1UdHJ6dmdId1VhTngzSi9EaHNqYmZyemdjdERa?=
 =?utf-8?B?RXFKcmpvZEZjRThHd3ljaXYyYTFFMlp0cGtZRkw0T3QzNU03ZUNhVWY2ZWwx?=
 =?utf-8?B?MXgvSFJDR0Z1QnR6WnJHMU5udW5QREh2MExTUE56SDdGei8wd3J6QkFPVjFu?=
 =?utf-8?B?bVMyN2h1YUo3VFNzOU5VV1ZydjhwamRGV2NiTndMZm9aN3pZOFJQdlB5disr?=
 =?utf-8?B?LzBJVmtPeW1Ba3pjU295ZmY2UlhaSVFkS0t4VHI3bzAvK2V2MjZEMTQzdmNO?=
 =?utf-8?B?NVZXNGFwcUZYdkR5L2VHbVhRak5zVEhOTC9WMUtVNzVndDFSeFlkaEhIcmlv?=
 =?utf-8?B?YWE3dW9SeVUyL3VhY2kzYTBOOE9tYkJrUjhkZ1pTaHVLd0ZuZUN0VldldVVR?=
 =?utf-8?B?OEtUc2JXMWxtQy9Dem9YRWN1ZXNiT0RyVzZIMWZtUmt4K0tNZng1blR3Vmxr?=
 =?utf-8?B?TUhnSEpIU21XLzVNRFF1QXphNnRhWkRyVEh6c0FvZHdGL1JJZXM4cVRyY3cx?=
 =?utf-8?B?WUZGeU5XNitNanU1UXFFMTE2Y21ZWkZDUnJ3ZzJCMnF3Z1ZhRGh1ZVNpRW05?=
 =?utf-8?B?N1QyYjJBeUt3SW1KK0dWQVVYMlVtN3p4SWVDbHZtUzI2ZER1WUhLYTExVlMw?=
 =?utf-8?B?TFBnaGYvbUhvRGNVaUh2RzJtTHRmWEU1MUJhdTNlRHh3SlFVNitLS1NmNUhq?=
 =?utf-8?B?TENZWFF0TTVHUHJ0eUlTd3Q4VUVGTlQwUHl4SFlBRGV2L282S0xRbnI0a2V0?=
 =?utf-8?B?dXE1dEluTm1TQWh4Y1hHZTFEd2NpUWxPRUZNd3RGaTRwdVhHT1NqTUYwb1RN?=
 =?utf-8?B?d3JpVVRTNitTLzRCaHV0eWVmU0N1N1J0cjlXcHZUZHBJSzJkdmNVaUYzVU82?=
 =?utf-8?B?b0NvUXkvVnlRNWdrMk5uSnE3dlhvcTZLYS9VakVqT1hzaCtoZ3BrbXhNaUlK?=
 =?utf-8?B?K0VVZUcxMnd0MnEzUjhuaVR2RDdvbGJaQUdmcndFSk1XclRlb2U4OXMvMGJN?=
 =?utf-8?B?NkJCSks2S3ZlVUh4NGZ4NzAxV2ZoTDc4NjVxSWlEZWE4djhmbGRRNSt3Y05U?=
 =?utf-8?B?azAweC9HR2RHM1YyR2NaQWJLQ0hZNXk5YVBrditXdkpuSW9SRStieml5bkFI?=
 =?utf-8?B?K08rNVBESGNteVBqVTBkeitNaWY3WEhpalVZVzdWNlQ5Q0djckVEMm80SUph?=
 =?utf-8?B?T3NINFV2TTZiWkJKTUxzOElhQXpRQi9SS3BEL3VPenZrVWZuLzJPeW95ZXEw?=
 =?utf-8?B?ZFg2ZW14b2xyZ05CQURQcmV3ajNxMTJpRkJOQnVRZVpNT1gvNFRBMWM4UUlG?=
 =?utf-8?B?SkVISkhKQkcrdTFOMXR5cnQ4b1BEUWtHRmdOa1dSZ0ZLbklyVjhGYjhJbUwz?=
 =?utf-8?B?ZHhVRGtzT2ZFTGVoYmpQaWM1d3VNajcwa21HcWV6MXhJZS9kZDJWUDFYNlBx?=
 =?utf-8?B?TEdHa0RtQ2xhWEkwM3JnTDJ2VEpoM2s1enVLYU1DcVgwN3hWSTRXekY1NGZN?=
 =?utf-8?B?dmd4cUdscTlnc3lHR3lEOGlFYWRsWFU5T0tjNExhYS9Sc1lmU005dFFuWDhP?=
 =?utf-8?B?Um95ZTAyeUxjWXJENDN3WEs3Q0xqampKYlNxQmMwazRlL1d1RUlKVkNLZVhV?=
 =?utf-8?B?Z2w3WFcwejdwemthQ3Rmay9IbEF0Y2tTcllRNXJOWitNK3V3clhEanAreGVy?=
 =?utf-8?B?ZWZya2tVSHpwVUY4ZnVGLzV6REdVOGtGbFRYT3V1MnpEOXB2SHpqa2hKejU4?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29EDF42672880E40B666C627E202645B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3neXqMep+SI/whL34bsvPOtDXN+CAtSD4muefyC6Ruvb0KvwGC4Dt2PREfappdEJ9r4vllWRPs5rgOGR4ze9T6Yb3D6O3hage/OWXnpDxMjGURmuL/Qo/ikSOAhMfuTschaKwBBkl1HFmzBW17BElryfaV8/t5wjzrSgPHaRiN5RXpPQgPfIY/mUCPwxSBhD+S31X+ROKhjor5xT9DgB6o6g6b9Cqn1RigZx146x4YqO/3Kc90WjSyxVO4OfJOxcsg4rQtUQS4uTssaeoxAkFMhV2Rs75FUzmEZwVjO6J29yudTspojpxvDNWjzPPlr8wCc37rQTCgmPJCCC7omLpUOYv9qM4vhML2osKt3a4ThLbTBbXbWEmXCEuXSIcURnpiWd0DXcmWjCkTaRhJ1u1e4WpPB5OoYuO4BKjTmBXTxKiZWwt/UHYtzsYBvZu1jor9PsHNbG0Wuy2WJY3Tl/5R0UY/hA1AxsgKnzHa3c1o2Q6yYKKz0jYDLX6qzDKQyj4dnmKB9Fv0cuwwmR/pteGz96nHJAESML6rHdHf1huZ+LzfTS35Is35Vk58nJ/QT9W3Mi6Z8s7cm5e/7YxhF30A+Jv7G9CFQ2I8aD8nzrGcBZ263GUYPy7KDazjkQOPU5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e4d1c7-477a-47a3-d67b-08dc5ed1920d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:28:57.0793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwnf79lMpY7VgMeCv5Op3/+mcdrw8twAoNTlBffY7ibZSXADtYJCPbnntv7cSsblzHPXyGIPyQ0pJYsS8h7V/OTU0MIblxBvPeCQlArevJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8249

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=


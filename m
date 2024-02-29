Return-Path: <linux-btrfs+bounces-2911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E470D86C7A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BCA1C22EFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E807AE48;
	Thu, 29 Feb 2024 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RHx0KrXw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MmBmQlu4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362D60EDC;
	Thu, 29 Feb 2024 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204584; cv=fail; b=gMJi1bYLm4hXzQCsaNqU/w1E8cx0sFmQFepO9o+A9S/aK7DMzbTjz+0G9otXRfqjLG1llGMfLXuuMWgkU4mmTBwv0dcGsmI41SdOJkFu56ZFISMQYtzBtGHkC2vBiNDWcSc5PaUWMz2u3zi4qtlWHd+DCf113IG15QXC9XRIqso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204584; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eiqf+YgEMtQMfgim+h++yq0Z3/Czs7o/ZGXXmE3OKhBX43aBIRUxBqb4t5uJmR0G9rysx/heESCL0u5BAcW6LCpRBg+pHKN4fg+fyndhuLFTUKHrK0ptti1rBJ7g75j8geGanP4peHIw3En6MofgkquE/8j5EB586tOFg3PNHTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RHx0KrXw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MmBmQlu4; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709204582; x=1740740582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=RHx0KrXwfeOCrWY68tG2bPS4MGLaU7JE0ukY7bNS7bzjxI1G0/46ZCkI
   BXnSb6A51ccE6gSxgUTuO9Og3wCCgCpgdKTHqiD1ZMopT80NG4HyRd85a
   awllyhkhnEFD14956LVUD3Z1dsOvwQogQfUTP3JkjpkqnDO0OXfEXud+G
   lPwoFz6u4aV96ZbmVHFoxr03vvc3pBUycZXjKWZjgcc2h3taQZ0jOK89k
   eaxDFIZACy3HJ32WhtzKM/5GsQERlQjyvWZEAsg7t5kLATbGCzVsnU8WX
   by2Ygi5XCIRBt73SVNw0Fi6o/k1zpkQThA01n4REAs8YDYGLA6TCkFpK1
   A==;
X-CSE-ConnectionGUID: E/6aJEDfTW2QWu3Um3kwhQ==
X-CSE-MsgGUID: fvNzpRR6RUCz5KP5bk7YQA==
X-IronPort-AV: E=Sophos;i="6.06,194,1705334400"; 
   d="scan'208";a="10342026"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 29 Feb 2024 19:02:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdjyp9kprJzs9moe6Sye3S5AagiGHRAT59B57pQYqaKCjn1WX8qGHvjxdshtaa9ViWxhKhkf+2npHF86NotUexMolglP6axxbkKLZ/aE0YOImTMzjOQ/T0nwjAXf/qQqWkmwPiAW1Ji6KiY9HA6HPgZbUiCf0NjMDXt2MwLd3F2436q0Zm4bGV4EjL/czBqMYp6LAU9pAuPc/THwoPaMn4t3vPGsSRU/agAlmoZbuqsxYcwiHx9v8HVqwL3Nr6HcglflWbL85qyzTTp9REj8jCE/78vNRS1008h4zzi0c6KbVGQJ0/MmMM+dFLBNY2fhgU8A+ehIjC+4IYbWJucJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=c9Wq0mGP5+5+VRx2cC6oPCyuHLRvTs3CEtdZD67YcGekBsBE+Xff+5o47xWgPV/cVCSyw+B8rhVFEP+fe0QNpn5InFqmoN9o8L1GNYXUV+YVANQLl8RzmWTdKMct1oGquERK8ac2ZAvP8i8x6qyzEiO3k+IVEYbQpTQd13g3oF04z0rDqT6mKoqVuVtW0HebtBQGzmXP44GSkgcU2HC5DBcisr+p2l/gipDwatYaxndR6F+VvdBuIHgdTXO22VX5j279SXLCUB9UVnW/k2+Mm6gacb1MuzTc5veCXmFlM2kyV47Nb4V53kgTJt7B5CODOPGPOav5hw+9wjN8Oc6hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=MmBmQlu4oKg0+8XKf2FgjQ98aAZqiXoqQexbdDbcLP8YqcFczAh1nVcQHcQp7XNAOzM48alF68U4NETSAU83bFlpWtgu89zFpbxtCuYLUMzqh8iKdNgGZfafmoSIp2WMEtC4YO6ygA2yB4VQ1HbfulIp6dAMU52i05+DfIOCqxg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8262.namprd04.prod.outlook.com (2603:10b6:510:102::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.35; Thu, 29 Feb
 2024 11:02:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%6]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 11:02:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "lilijuan@iscas.ac.cn" <lilijuan@iscas.ac.cn>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] btrfs: mark btrfs_put_caching_control static
Thread-Topic: [PATCH] btrfs: mark btrfs_put_caching_control static
Thread-Index: AQHaaurGm563bcIk7kqk3nTBF4es7rEhJ9uA
Date: Thu, 29 Feb 2024 11:02:55 +0000
Message-ID: <24846754-7680-4743-ab9a-8b85d34bb661@wdc.com>
References: <20240229083007.679804-1-lilijuan@iscas.ac.cn>
In-Reply-To: <20240229083007.679804-1-lilijuan@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8262:EE_
x-ms-office365-filtering-correlation-id: 09c5a602-9332-4799-7d38-08dc3915fb91
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pWzcIk1PrDdE1Xxy45B24dmgTuO3P89m/Jx3rCylVVNJRN5ayGq7DAxQ0zgMXgmPHbzewycwPQcrz8MbwixjtKP877WGep18jMA0361BbdMgn/kjQ97veAUEF2fjdJov5yrE3g4/DjO9sY0VB5nkuYH7iVkzKfmRn1x3Ewlc8qfLQltXlKkXKTwD5FDNK5GVU2U5hyye3Yc1E/tGJR9o78VdM8Ck3y+adpIX1qrnj+zVRYExb67fpQIabRKHcjBByHyX7HhrF4beFB8CioWn0RGqIsQSkZZjyo8EFRvNlPk49DDzci3/Ot4DUD2FduUAPVa8ICdQklYGz2l3qBIFXEbBunK7TiRT3mu5G6pnY+BV/PLWTaVmrGbyCJWqZs74p+1x2pAhdyrG8m+eOrYmuXxO5LnH8lWb6WsGoF8MdIu+h8K9cw/MAK6J2pL13woGHNn7NAGd8Ez4XUpHRF5pWYzzy24z29WKaLMXxyD+wMXSYVGy2jRafAPGWJJ9CpwRrAt6ln+Y0KXIObitHbjuLg3DmVIhR9AmtO0Bo4cSZlq+baCFJomEm1PVjqrya9VjT6/40/U4l9qZbEevbBeT44ymya4v6jIpEgdNhrL+2YYrIlEhsG8Yef8JFArHWDXSrxvnISe1n7wctM08igYoaa0tL0KXSLOTXtnUMLut3jBL9IcjiOkWDNcjS4uvPu6znOsKPxQl2kZgn4Z5J1fUYuoxK2V/HmUOQ3s8AkC7jyI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUptWVBIOW8yeTNtYVJ4NFE2Wld0YkxhNlFQdkNNZmlCV0VzdUJpWDh5am1I?=
 =?utf-8?B?MXBadDhBWXpzbTJsU1ZlSWdWaG5hSDNFekpqVHpBd3Z2QWFMOU01Z2NHVXNi?=
 =?utf-8?B?Sk1EMlFhYVUxemlZR1IwcW41NlVwODhqMW55SFBRRGMvN3JDUHEwNVppSGJP?=
 =?utf-8?B?M2hPNWUwckVqUWxGVkxSMzBCWEJuamZvTXBrQ1JzenNRdXdvM1o0eXVBRVBL?=
 =?utf-8?B?RFVmcnViQWVEdkxaMUR1czBpaGdQcmN0Si9WUUlWRkRRbmlTUjgwUGtZOGF2?=
 =?utf-8?B?WWRpUGJaNlNqampVNHNFNjRuMERPNEE0T3IyVjh3QUJTQ1l4d0d2K3I1b3I5?=
 =?utf-8?B?ZXJjWFAwMk9BcnJ2QUtNOGNJMWlUR0JYN0RIc0RYREFrYlE3bGRaN0ZmbWR5?=
 =?utf-8?B?MjdtYkFiNU9FU2FQa1VpYVJwaVNhZzg2cWk3NzErNk5QK0VpRVVSQ20wbnc2?=
 =?utf-8?B?dUtxUURTRWpsOUtjWVhKa3V5OG9Id2x5YWpyRStKOHBtQUpJOTN2Q0lqVzZN?=
 =?utf-8?B?WFJhWllhY2VXblF2WmdSc1hhOHJWUGRsNlIvS1B0TVB3eW80WUc5YkpVZFpy?=
 =?utf-8?B?MzNTQ3Z5R3B1VXJnMjdMRjhubGdFWnkwWldkRXFJKzNoekhNNFJFVnlIcFN1?=
 =?utf-8?B?cmZybHpCcldPMzVYTkJwWlFNVDNlejhNVGgyRXpQUktPcjh0dTI1V3hpUnky?=
 =?utf-8?B?ZWhZbUM1RTZVOUFYSGkvMVh6cStlb0srUUVtTnp4SkdSYVZFcGdFaVRNZXlI?=
 =?utf-8?B?am53NUpZZUx1cGJTVHlHSW1hdFRCMkFFWHBWMk9iRnZHVVQxOUtpTEs3Y1F5?=
 =?utf-8?B?SHR5ZGxOQUExODM0ZnZTZFo5bEVvWmE4MG8xUGttYVZISHZoczMzNFZ5WU44?=
 =?utf-8?B?R0FWZlZ6WTJBWElBZEN5cTk2QWtJaWFTK0pqVE1xWVp1RUNuRUpLSElOUHVI?=
 =?utf-8?B?bDV4WWZvYUJGK0R2Uy9iWVgrdlg3SEJ0eXZCZlMzK0lQWDhsOURUam1vczRp?=
 =?utf-8?B?RGFzUWxwNWV3UFI3dElxdVkrbW1qWlVsMmY0TlYzYWpNNkNPMEI0R3Q2dUN1?=
 =?utf-8?B?cFJsSnN6SEFBWE5FOGtkUmMxMlBjMzF2dmk1Q2gyUHp2MC9TRzhEYnQ3NFpC?=
 =?utf-8?B?VE4rWTM3RzNrdFAxbVBwc1Z1L3luejF5Y3M1T0Z6UmFPVGtNOUFDQVJFMlYw?=
 =?utf-8?B?bk5LbHFvOTZyZFRlV3VXUXEwb2lUL0pSRHNyVzFTSGdmazh6SzF2VFYyRHhz?=
 =?utf-8?B?TjZ1Q3ZmODIvU04ydndQbCtzUU5FeGRSVUltYkJSS1oyOGdYOGpzSDExTDQ4?=
 =?utf-8?B?bGU5ZXJ6bXY0RGFLSFg1eTY1YkNBQXhNemZqRElBM25LRTZ6OUNZMWgrSXJO?=
 =?utf-8?B?ZVZ3UUs4U0ZhSmVlQk85cExhWTZRdGVwSnhEOWNudEJQSzJIcXB6dllYblpk?=
 =?utf-8?B?LyszQ1dINEVoNzVJcDdkWHU4WlJlWlIrM3dHU3N6RGU5Rm56ZGpOS3NGemdV?=
 =?utf-8?B?WkdTVDU2R2lhQ2JFYlhHWlozZkdPdmJCZGNQcGYvMWo0Z3MzSUJDV3ZWdFJv?=
 =?utf-8?B?azViODluUCtJVzVXRk0yYUlzQXlsK2I1YTlTbk5jQkduVGJiL01oQW5DV292?=
 =?utf-8?B?TUh5RGNCUy9JRTNBSWNMb2x0dlFhZ2dtZG5kQUc3ZXdTblZBK0dqNkNNYUVZ?=
 =?utf-8?B?ZkNQOGg1bXFjRFNCaFUvcjEzZVBVY3VwQzRISVVGc1hMS1gvYWFtWVpkUUlL?=
 =?utf-8?B?R1RQcFNjNmFIbDBFZEllNjRaTXF4MVVDRWN2STZRdkQ2bVk5clZUZkxPMGdB?=
 =?utf-8?B?VTIvc2QydUl4NGg0SFdyemFCSE5zajlrN1JpWUFwUHIzVHRvZ1pWZDNSMzRK?=
 =?utf-8?B?eThTTitmaWpOTXlOMHppMmZBWE1TYlN2WnJGWWNPMC84Smc3SWp2ZC93enlv?=
 =?utf-8?B?WE9RWDdsc2x2Q1RIMW94SjV3UElLT0xmWENKN1B5djNWMTdWRDBaTTZqeXdq?=
 =?utf-8?B?Qk1tTGtKWHdFSjhPaEVyL2dRNWF0aWxqMnF5YjJwMDRsZXVrMlh6aEJrQjZP?=
 =?utf-8?B?QlZ4VGhTWGxVcGdrUzNuR0NxK29ZWVdEaWRXaHJuVHArNmtQODc5RzlZZWxW?=
 =?utf-8?B?MkVITjd1YU5oOHVVdCtualRRUmVBbXRldUVKUFJWazVrTXQrODBNekN2KzVN?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C0CA415D3E07147A86F6419919E107B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2gLGK925rsJhGW6Pu8UXmK3706khoqXq79M+6EK3dl0mvueXUAKSxBCo2Cf9MEN039ZfyFP6Qf3Bd07QgZkLyEZbja4FtPz3ZWzPGDa98nbbIQKCHkvpRpuj3dRSlUUNHWFEbFPxrejdng5aqCBZPZpc3md82FQuHsIO5qkHoiQdkWuPxOqe13sxlut8HhR540Tg4rAk9MyrxIZdo2gfEj7zwb+RSknICtVTiKgmQVBcodk4N/B02vA3hfmKCzYDdIEGX7uO2PLebykeHkitasuMI5rFZokMXKMR2os1d8DUhEuv8RVcDTmYEzaQ3fY5OxpVXBVkrfD0czTkDY7nhKkZ3v46PlVk9lfrKa6lGYalBwSH3eYxb1YkPiT+V6i64foR7S0kApfPGA9wsxqqwCxiJJKvcXlqUZRXYDd8R1p76rXor7ek8ZuvwOHQihW+oq7+4z9jqimuhCVdz0Jo1UGvZlhyse4gfgs/CCCNhnXw1X5q9vZRsdUa5b+jrfO9zgKCbIRHql7j7HmFO6Rt5d9ADpyFC8q+1DKU0EIfIOpmUHUIFb50Qpt+vze7OorElyK92pv4ctGt9kvBLgCxSBVfyt26uKbyCl8b4qrXmtg+iI98Oa9OAwxjYk2Uen9z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c5a602-9332-4799-7d38-08dc3915fb91
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 11:02:55.7122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXf7+siHy4GhYs0lhtYA6l8GCNvEnA942vMcKxlf6i8ytGTc8j2RUfQKiFW7EDeRQioHIuYyu51ANo7q3VMiwhTG7t5CkjxS1K5oTItMzVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8262

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=


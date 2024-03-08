Return-Path: <linux-btrfs+bounces-3096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662E876368
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 12:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20895B21D6B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946256466;
	Fri,  8 Mar 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AXMz7ncq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uRZf3jbC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132295644E
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897834; cv=fail; b=rbt78+IHflYzIyNTWAp2xnrOqN2Axmt+BgoVMVppN7K216zFECoCqzFlrXC+DBZA9Q6kozlqvdNcMo2GuDHXw3dQmhq3RJxwq0QezYs2ja03c2PxZ6bKwfPrpXeVgZDKpLC4Z1K2sB6V00Z+ra+mJocp1Y6se65lPCacvwaxko4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897834; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f047Q/JFT3lCgnFraY4NkD/eGD+TvOZA1vjDQHwIUH835hfvP3p+BilZDnUEaWWDEIdiiKuY96KCPTcDHkeKfsZMHiaCvO5qlFYOFYEjYOWUZYytzJurRKqS7Nn4njdFquDXMManWYmXQ7DQGb+iAc+/DmL/KxU4Ba6/nMStEOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AXMz7ncq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uRZf3jbC; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709897833; x=1741433833;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=AXMz7ncqJmLNUVg/JlGaKCy+MJPG93SlkVYXXUPe9RW6DkLWQSHVDL1b
   RQWKS8UYku5eKxMR+YxagRppxXWIzWvV3q8awkufXYRZn/s50pkr6Sm73
   dSpLuZQowi3vsZcTBNG5c/U8HdvN6bM8H7BFhEF5KG3uy7BfO9ntjBGxv
   VSB3Mmufv8X4yJUhZTV16OWeKvCRsULgz4rwzfcDDmsqehyKFHjm/aoFb
   8DzzJw6OQuJuGbgyhBvuKryb2GfPQmyNJq863tv75ik2cGiqVU8I4oHpB
   z6d0Y92qH/j/wMpOVeCTrcSrfAjoO2znlIDzMBwVIf0jyIT2VTI3uLpks
   A==;
X-CSE-ConnectionGUID: h12FvY7YSnOtokAYErNgCQ==
X-CSE-MsgGUID: MZqJBM/4SI21ZVRrzWGtow==
X-IronPort-AV: E=Sophos;i="6.07,109,1708358400"; 
   d="scan'208";a="11123174"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2024 19:37:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5B3EOMctpjGApHy+u/jArxstFBMhKZKOAKs9cH3VtJly4KeEDOeF58WwKGKc3WWMUbg4y6fQHAOdZi0Kecq7aq1ZiY4JETj2VDhQ4WeguBSXw2qstI+YHeyMvQNdqziyXycuOtlZpVp2FCKSyvglDH9jq8MoJ7iT521dQ/vgGJtz55GBeUyuMnjhhOWqRzLjgCswXrgLuMWk4VG1Mg94eKli8PB1sOCTuacJSi6uLbJPIkiabXlLboQ+A1z7JjijpOB6Brh2uAfInPQKP3n01DzFKVd1tlJFeHjs7UUhbjVsg1N6pQ3tDyP29y3vO6Er/jxDnlvzbqiJRwDDOnZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=HqBYwSgxt5+qRyeXqPpx5stZW+HYDF2RfIG9gKfQDHeSXUzVbhMKSQe/VCoe1fdrx2ykIsp76IMfZG6abEmmqbsnpGAer9SuEPVxED04Lq7wCMeFeXJsJILEki4g4B3R0gjdEQDt3QDgNoAI7QyzZkFAXudszVShtGbzB9mdVD8rjetj1jKFWnEhh/FYPgnlyyQWJqFgCm4cy4DY9oa5i6CVwS8pdPNhJNkwoq4sYwmR3UQR386ycURCYee0ImL0st+ttihjWh5bCP5q9EFGgdTaCnqmwVtjwAaIEKaTAqsOZsKOcQeNNUlDyn5ZB8hl3ohsli7zgruMzfWw0yUvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=uRZf3jbCXB8IFGD+WvdOf6rpJrCYTRDAppF17JFlNEoteeZdRV9P4jMG9rupEvBfeuF+aJDhgiHbFj+P1GWVIzYjUlbQ/+z/i86uXizYmoQ9BaepKaiTeFM8lfINZeVrwqU+6ZTjb/4wG4wuid1V7zOdx9tCSaliUjqvWq9qLT8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6636.namprd04.prod.outlook.com (2603:10b6:5:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:37:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 11:37:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "michel.palleau@gmail.com"
	<michel.palleau@gmail.com>
Subject: Re: [PATCH 1/2] btrfs: extract the stripe length calculation into a
 helper
Thread-Topic: [PATCH 1/2] btrfs: extract the stripe length calculation into a
 helper
Thread-Index: AQHacRAeWRb4unWQbEGdqAYQmhuYjrEtt8iA
Date: Fri, 8 Mar 2024 11:37:09 +0000
Message-ID: <996c1182-c629-4f73-a3cb-89ed846843de@wdc.com>
References: <cover.1709867186.git.wqu@suse.com>
 <a811f9535fe4fcac68f1a349dd89e600cc15b691.1709867186.git.wqu@suse.com>
In-Reply-To:
 <a811f9535fe4fcac68f1a349dd89e600cc15b691.1709867186.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6636:EE_
x-ms-office365-filtering-correlation-id: eed3127e-8d6a-4fb8-2a01-08dc3f641721
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yDNsBb1AEuPJaG8WO7nnxq9ryGJbBCKCEEDTyfFZPgdLdi5BFbNy5a6CfqgpytLKWQgK0mL6tf5owpJ0NWQOl9isixo+/UDy/DDk7aDq61n8gqWWCJ0x15aHRwK2GDDWiAF/fjWutVnN8y483BFyTbbr3xjKLutcttwOlOc+GnY4m+GsWkhl0aPKMxOQ6ibyZaio4uYZM//uG4WAFZmPfJe5u+QgoDyHSvlBgLHqY476pBaBwLDF5+xQbQQfAAy8azl9Be/dxJl8riBc7ASO5bscd7CLRPg0AAL2pBcXC0HCD3TqmUwUbhnDdoE00TWzWc+IxVJVguOcbHtieeigGtq6hd0QkGBHzyX0CukvbtFj2imYXA+cfVaHyaTUVYjJFZgX9hQlYzolDP4QjTWfVSBpZj+d53nuLqUlIhXprbqGxgpxYBbe/nUtT8u1Pj2+kXNgCtt5XQFjzRUt1csJzE6tBHAwTajLi5mfAERPNLo7XHEJckS33InCeLvnj9WOBowwLXulyFYAH7fXh+srk5Tte+ApQQT176nxclfa0nG7YHXw3pzMMDoigU+cE41AfOP2SDEx8GT7b23X8sitWhGMEjZlUwivc5uQsdryZ0vXmnI2WqVqTtXI+WLyDNBAwO9dZIthxqeYhzuFUknWeTBSJfQDkDWGC48Ib/BXohjbIujSAB7qGQZn+QRDtqk1c7TAdadTLCW6v/UsLI/oF4i/lV8JmmW3Hz7ls0CBTmc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0wwVW5UbzZ5TVpNY01lWVN4SXU4Mnc5RVJYTVJqN1JPTFI2d3NmTDlhRlVh?=
 =?utf-8?B?VkU0MUs2M2tBUkVGZjB2WUI5UHdkOXJFeXFqTjQ2OHl2RXRleFE2NGRFeTBi?=
 =?utf-8?B?SWxPTk1EYjNqL2UxMXBEVEhSYWFHL09nYTRGZGMwYUNEcFJNZzFBekhzZFZI?=
 =?utf-8?B?MzQyUUUvVDNvZ1Q4TExDaHovZll0QXhXY01aRnEwb0dZMnQ2N0VRTUIzTTM3?=
 =?utf-8?B?VkZqZE9mYnYrb1h4Z1ZZbjgxMzBxdW5ueXo2UEtyWGtoSHpHeHFlSVF2c2Ev?=
 =?utf-8?B?alZoaFdBRkxyRnpTNmdhWUJnaTRNZkcyWEd2Z01DRG1Ca3h3RXUyb3BMQ2hi?=
 =?utf-8?B?U1gzVElQNEk1U21qNXVHVWJsaExWeHBtZ0RINEExUTR1MnZLSC9LeDJPNmNM?=
 =?utf-8?B?UGlyR1c1U1BHa3VHcERqNFNJVWdLVVFtUTBhYUlFR1hjQU4zaThDSWVpd3g1?=
 =?utf-8?B?M1BVZXdwMlEzWW5qS1J3MDhtdXB5VGlSM0RhN242bkVJeU1JM2VHWXhoSFl2?=
 =?utf-8?B?RmZjTG9ZQkdDaUZQUG1OZHQ3L1RtK09MUmtLSHh6SlRteWM5RTA3dlNlKzRZ?=
 =?utf-8?B?MG5waHdHN2ZLTTNWcDVMRkFQbzVyMGlZNDZ0cWJCTjVHajQ3Zm10Um5RbGVt?=
 =?utf-8?B?Umt1S1dhbDEwMC85bVoydTBFSGwzTmQ0d1RlUUw3SkpTNVlHdHQrcTBteVhC?=
 =?utf-8?B?NFE2L2hsVTF1OWhqYVJzb0kwWElJZDZ3c3Yya2lrUVFjYkVZZlIrUHo1VnN1?=
 =?utf-8?B?Q2lrcWM3RTBwczlRU0VSemNiczNwa3VudEdhR3IvSG5wYjVFZXlKa2F0bi80?=
 =?utf-8?B?bndnZ1g5V1p4bXNpV2xyb1MyVlliRDkzdTc4YkFjdWZSVWlhS1ByTThPWkxr?=
 =?utf-8?B?c0FZMmFZZzlaeUtTQ2c1dmp1dG0yTGtlVkw4N2xNLzY1TzByd2NiZU81aVgy?=
 =?utf-8?B?RVVIb3k3ZFFLbjFrNFh5T0c4bmc2SmUrQlFkdFFUN1NHTjR0LzkybWVkMUo1?=
 =?utf-8?B?QzBVaitlMUlqUmY1U05OREhGdGZpQW9QS0lhQXdXd3lSM0pKOVpsR3R5T0lP?=
 =?utf-8?B?TnNNdkRvRTlSSFZ0bER5VTNSSVp0OHdJTkllWjgvRUZBekJyNjJveUJlQ3gw?=
 =?utf-8?B?dXhESG1IWTlSU0d4VUhhTDMvNWQrakU0aEhPUXA2Z3BlV0xoWDVOL0Yrb3NY?=
 =?utf-8?B?TEUvNmkydjVNWHlHRFlnQjB3OEJHdVltVVljMHlzM0lNc2Q3YjZDK28zQVRz?=
 =?utf-8?B?cWJNeUdIQnVxQ052cWNEQWxWNTgwWFpKK3hnQVVuTk9XNVNYbDB6RkRCQm9K?=
 =?utf-8?B?QzdBNVBPRUNKMXpqVVJuL01CanJLTjk3bkJVcWJRRmMwMmpHTmp5UVpEVEdo?=
 =?utf-8?B?R3hDYXJ5UzVVM0luRW5UWVV4Vlc1S1M1Qlo2dHF0QmZhd29laTdMamlPQ2xW?=
 =?utf-8?B?cm9QdXFvaDRuNUxneUFzOWkvS0lyeHRETkVGNUlIVGVyaURaSE9wVVdDcHZZ?=
 =?utf-8?B?eitwYTlLU2dmYy9WeGdSTHN1a2NYVkV1L3dVY1pyWVhyMHNGQUR1TXRrSk9U?=
 =?utf-8?B?bnpNK0VTSTRoUnVKc25hWWJDODVhazM5QU5SUFp6WHNpRGxWTUFBbnFJTGMy?=
 =?utf-8?B?N0o2MjdnQlRpSWh5WjJiWHhCanhBeUM3dHdnSkJ6SDU2bjIyb1RmRWRyVW9X?=
 =?utf-8?B?amM5UjJJeHd6bjU1RWtESy9CMSttZ2xHNlNENmpGbDgwVHpRempqdkc0ekE0?=
 =?utf-8?B?cnR6QXAweUx5S3pVd1N1QVFwSjFZMStJb2RWdlJZNTZhMVpwSC8vSXVaRjVt?=
 =?utf-8?B?MG9hc1REd0lLYmYyS3F4ZlZGNmFodWUyZSs0WWZrMHB2QThDaW50L2xQWjdx?=
 =?utf-8?B?WVNiUGhEM3lMTFdwTFJQczdhZmxPRUFhN1IvU3d0dU4xSTlETEFEa1JMaFlH?=
 =?utf-8?B?d29mL2UrbFdkbDBMTG1IeDNlNjRlYVdiYzIxL0tYbUtzVFZycUJtNTNFdkt1?=
 =?utf-8?B?UW1RMWprbEVkM1F3Q2k3VUhwVGVrZlkzeEFpQmUwNENQeWVwcitEM1pnNXZ4?=
 =?utf-8?B?Qk4vQXJPS0FZSGxoS2Vhc3VXcHk5d0NOVEduR3JpRmREdkREQlRzNlpQUmpo?=
 =?utf-8?B?VHozYlJEb1k5RkhTdm5iTlRjekF1RTErODZxSlpOVHEwTnJBdnQ2SFRxT3Ey?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA177D5E38831D42885DCA85E40E5B97@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t+Ms2bBmRDNWlEGGhgPdvhv6Eye95QNmNoZq5lzEYytDbzrwLWmlj+CCM4+7+iutrJ+Ot/CH6KCucfahDlTTiUXcSYHuSZfKce66DDCTJnoyevurIfOvYXZMvdSrTTDMa4Dnh5OjmxsL48o9GWf8yD8MgSFS6MeQRG+TSH082IDl2fyvSc3uLWbhZJswnl28yfipEG0oRWt2AJkgNkdtQEsiiu+FY61HNiKxJV3bZeVvW+V2yqc9XGCU2B6JUK2pynKXvQroVZt5ct0oy/16h8WetEw3p+pHydj/4Og7X3w8pIYJE47aXzzqqaF8aTFoHEjl9Bz5ABcyC1oVggHIQS7c/naLcaq0HXDuCkjTtoccqWHxB6AlWYpNs1TzvNPwlqOwpQBomdbeEZvXdZE+97c9iKsk5zklBsJRFqb9o+yWNdZ63T+FbUNtmuYWNlJhKL5xiFBzqwRCScraCA0e74zdNSfPx8dzwH74c69Y1yRQorPAjIUerx6dlRvPNn4CLPFtVnLq9z5SfprqHy6IoKKzTYAEjMpWjLsYuYqbBzZEuG2b8Uoh5A2H407wqeD8v70lay+jS40f0esT2oxiyVuFJwT7qC4UWIAouPAMlVk/jASUnWMQnDGFhT161mML
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed3127e-8d6a-4fb8-2a01-08dc3f641721
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 11:37:09.6588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPQMsYw9N8lZHbTZHzPvBtztbOHNgFTGWqjqSMTCvn0OYnXcV9c++BpIqTKek7YW8jSxu1nW0pb2U+ECp7rD7tpCLwUNhT8zmG3WvkmzVjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6636

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


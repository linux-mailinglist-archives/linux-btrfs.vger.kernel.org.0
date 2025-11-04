Return-Path: <linux-btrfs+bounces-18642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0950C2FB1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 08:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF34F6B7D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 07:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9F30CDBF;
	Tue,  4 Nov 2025 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mHuQVuva";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Af5xu1Dk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644C30BB8C;
	Tue,  4 Nov 2025 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241879; cv=fail; b=IEaVazZcz8rMwq9p4cVclT8oI8uXoLxjDOS9DxdhGXZILl9UNU6xAZiCqQd6qgejFz+2coUHji8Al/ARTPbr5hTl2de+5/Whp/Fz1uylQU5aryg9/aMQERdpi9WwJNfstE5Z4nf/csqMcTRkYXGByrLJpOvt9lIq5D0uwfFTdgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241879; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t2mmIOa7DDL4tSL86CeQVBFWRZwt1pHrPi+Gdl7wAg6akEHDL988PhiBPgj6LonmBAHF4nWrG1RT36OPM0PY63qCSHzDdwwxjsfHsZQzfHfdp2VoKWGJZFJpGJKeMb6+E/GvirZ/PLHyQmpdddONG+RyjB3XhRpVR0B+REClwt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mHuQVuva; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Af5xu1Dk; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762241878; x=1793777878;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=mHuQVuvavFqx59ENTep4fTCXAFM/7nSt49xhsHTVDaC5ATFaqp/0TAbE
   lXE7Qv9dg+jnTco8Yh9BzZnIkovHQnbve/cXzMbLT3FnvsUY2ta9VG51D
   EzZQoMMTDdvrpru9HWzWx1CslvBAEu5NBGplFAWmPMIb8uyxNIQ1WeiQO
   tFBh4a7OFiRaG1tMXV8rRulIn2jp1KPwYiXm5ZLYVWWl5CFP9pndDXKqj
   ASBknDQh1dK7YFc15bSeJ8s8i76S2sOm9ggEUFfkL2tT+T9oRUdBLaemr
   /ksymsEiWAQvFKDadWYvU9DEd7S44ylPORSomcy2gzVJkx5NMzUze/SWi
   A==;
X-CSE-ConnectionGUID: OJOuIX64Tia7R0hM5qeD0w==
X-CSE-MsgGUID: 7Ki3HXXQTLWdOGMwPk7mEg==
X-IronPort-AV: E=Sophos;i="6.19,278,1754928000"; 
   d="scan'208";a="131442993"
Received: from mail-centralusazon11011040.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.40])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2025 15:37:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ9iSwWTFnPaXaPsk2gxWOVWLc/S2pn+NUMiYNztJdzZ1VL8TXfPlXo9M/XY1O1a5TP5OKyc8yKRYDI3tQ+cX2n4u1XQrZLK9glyUwDtoDlTfX/lkeYcVLA8B91h0PrjFrsi37fsq2OpuNowhRWCKv0Anr9wl4amt+PMjwca5Dv00nQe9EESjB+Rb9ybxVMKKdDCJkmUdwOlgePe/9mTSMaXwjfye6x6nW9W3+/vQwszJaNkqPpFX1ajzkYD3BaeX90jBAVPgjgTyfOL5oZNkjFus/sJf35fYJp2gZrtkw2Kd5Ll1dIToQmo8ORX+KdC14vn5S4TSqlQnEoKZjQEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=dNXzBaGHKsBXleSmZ1xWCkYb/ASszQzzirWoJx+AFr+PvBSv+lbv2Ue5Igus/DtdlMVHQ4wC581sQzbol6YljPXwDtgIU1PIWvmpR9KYRD4p7xu4D1hM9HB0qBMJzdl4zFBwMO1cpOqK5nToLx4/Asm/JZsvKv3JgguZeG0bd8BEW1NuQcZrjf7FYYenXkBgJg2uczEGgpO4Nfd7HHkLTqILuib9t9ZJwykErhp0MtJi3CxZnr0UKMdUDildoqw0LMJL4tee3IYK2GT5dAOovaWujYt/BDkqbNfnQZHVOq00hMcxqhPvENOPwfb0O8EX/MQvEK7BAK9pBi/drHC3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=Af5xu1Dklz7Go10y36MRgN7M4eytjiG+DzQsBSqPO8iowx35PRcybIW1YaH/Ic8Qnzfimx9vf6Yovn+T5t8hkjYGrZi2uoJ6lO+Y3TvkIn4eutiFR353za/UAf1lLtq/3117z695H42qk3iABOSpetRljD2wlaAaPLMiPYAOdNA=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BL0PR04MB6499.namprd04.prod.outlook.com (2603:10b6:208:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 07:37:54 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 07:37:54 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, hch <hch@lst.de>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, Mike Snitzer <snitzer@kernel.org>, Mikulas
 Patocka <mpatocka@redhat.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v3 13/15] block: add zone write plug condition to debugfs
 zone_wplugs
Thread-Topic: [PATCH v3 13/15] block: add zone write plug condition to debugfs
 zone_wplugs
Thread-Index: AQHcTSwxzsvimJJJFkCedXvbDc2b7rTiIYOA
Date: Tue, 4 Nov 2025 07:37:54 +0000
Message-ID: <4985eb0a-a947-4346-9489-9e8c620cc70d@wdc.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-14-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-14-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BL0PR04MB6499:EE_
x-ms-office365-filtering-correlation-id: d00d0259-8e18-4f7f-cf6a-08de1b7510f7
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?SWNhc00zMHRHaFVORkV0T2txMVlmelM5VStEVEMrMXZaNVY0V0pLSW5VWlpq?=
 =?utf-8?B?bzBRNUNOajBuc2R3U3BQQ1Q5UW5MN0VzSWhBaW1GdksweEZaSzB0bmxNYllX?=
 =?utf-8?B?bE55eTRRSVpwRHBIVlhvYkQxdXlJM2piNnh1b2dsb2JLakZPVVRtcS9kL3Uw?=
 =?utf-8?B?ZFd0enQ2cjBtT0xnQXFHd1ArNjVjNERScytucDBBY01XcjZBN25ETXViZ0dm?=
 =?utf-8?B?S2xhYVd1eFdIRmlsZEVxZjVJTG5VU2FiZS90cjlKS3VRbWN2ZnR0bno2NUha?=
 =?utf-8?B?eUFxckRISFpoZ1Bjb1VvQVVKcTFqU1FrUTB2b2VjWXBXQWVRZEN1cTlYVkFS?=
 =?utf-8?B?eUgvZkhVRGI5VE9iUWNjSDI1V0MvNHdqeTFaQnlsckxsS3MyUkxCTHM0M2lz?=
 =?utf-8?B?S3NPeC93TmtvMzlHVjJTRkZpWGkySDd0VURMV3VxNnVYSTRzRVI2REpvMUZw?=
 =?utf-8?B?QzJQclhMMG05dklVMnF3bURPRGh5QmhITGUvdUdQL2hJdVpIa3V5QjBRU0Jw?=
 =?utf-8?B?T1pSRFFrYnMzWEJqeDhtYUVSa2pYejY3c05iNDB4dWRiM0VrcjExVHgwM2NG?=
 =?utf-8?B?eUNieEtMRGRlV0lXaVRnMURZNDdEYXdZdUVkUWhZUUV5WWtrVkx2ZHZDSEdS?=
 =?utf-8?B?bVF0M1JEc2V1a2ZQK004RGFvbWk5bk1xaUtTaVM4cmE2Ykw2QVB5KzgxYS80?=
 =?utf-8?B?SWY4L3ZTZ2ROVndiNFZvYW5sY2FtU3BFUjhkQ1ZzUXhFQys4eWVBaHdpQ3BS?=
 =?utf-8?B?eWVTTXJyZHVKSEE3TWxXY0IvenFieGNTWkd6TGtIY08wcHFHQXgxYjdrV0tu?=
 =?utf-8?B?ZDFNckRSc3ZtelJEYWN5dW1KbWpITGFic0NodG9LL2ZtR0hKQkFPL2J1WU9J?=
 =?utf-8?B?SXRLVUQ5ZS9DdzhzblhxMUNZZDgxUUtJSWhWSmliS0hqL0pUSUFJUit0SkJz?=
 =?utf-8?B?eHlhSTNJb1J6cXRRK3JLdDdGSEEvcW9JTk8wZHJEbGtIUzR1Y2ZxVVVIaEtn?=
 =?utf-8?B?dnFKdTZLQnhvM242UEpoTHkzaUkrSE9TNU9zRldsNnFBVFdDZHRyVXRBZ1dn?=
 =?utf-8?B?ZE0wTWNUbUFjcUgxMDV6ai9NcDBwbDQ3TlBlTzRyMHVZb0kxREMvNDVUWlhR?=
 =?utf-8?B?Sko4TFc5M3l3MkFXQTJYc2xWUnEzemxQZkVEbTdXMENCU0ZuYXNNVVdmbGNG?=
 =?utf-8?B?K0pJVG84QWZnRTQza1l5WnJFY2I0UE1qWkQrdUFRYzFnTHhEV2cwUWNQSU41?=
 =?utf-8?B?NEZ3a1V1QnFPOGNLNXlHWm1mZzFRVGJlYytGcW5Mcm9ZVmt3ZjY4Nm9KaFFC?=
 =?utf-8?B?RlpoQVc0dnJJaHNJMDVOZDFiOWF3ekFIRk8rUnAxLzJpcXgzamYzenRLdFlU?=
 =?utf-8?B?OUdlaXVzaDduV21DSlpNeTg0SGplWWZTVm1wQk5QS2RiNU5FT0dDMjRBRTJN?=
 =?utf-8?B?VWpDVE43MkV4WHk3NzhaZ0d0eWhHS09ickJoQ1RnZm1oeU5sVDNjbjAwZ2VP?=
 =?utf-8?B?VWJ1dFRUOXRVbk1SN2lsL2loYWVJaXFCMEYzcXBWQTl6Qm9URW1ySlRBbkp6?=
 =?utf-8?B?emdIbHBWZ0pselhxQnhuT243YUR3Wjg2V1RncGZ5a1BxUGRPMTVPeGRzbWJp?=
 =?utf-8?B?eUs2UHY0Y2FSTklWMkx5VGQ5cEM2SFJjeG5DbXZ3Wm4xSnRwb2sxN1k1K0tV?=
 =?utf-8?B?R05iSGVURFVjRGZ0VnROQXYxUXFDd0d4ZDlKVzhENDRGbHFYYWg4VnZVOTdP?=
 =?utf-8?B?dTdBTmdDMlI5djd6dlA2NXVwK0t3V1g2YVp4ZGdNRGRXcmhkOUpNM09YdlZ3?=
 =?utf-8?B?SnE4QmYybmVPNjJtL0hqOWREOEY5YXhXekJBZzVSUy96NC8xa0h0Y28zWlJl?=
 =?utf-8?B?RS9xVWp0WWdZamlRMDFQaE51K0VDbnh0S3FNR0hKRVo1b243V2RSWXNKTXlk?=
 =?utf-8?B?eERYOCtIc2U5S0xYaDA5S2VUZ2FzbjVNbnJndDlYUW1NNW9UZmloTW5ZcGNs?=
 =?utf-8?B?aWpOSStiS2s2a1pqSnJ2Wk04WWNIYk1LWDFEcGw0OGtWRHhGQ3drMmJXejZj?=
 =?utf-8?B?N0JGWEJJdU8vUlh6VEpGa1pvdEV4eUw0cVY3UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3ZXVDhtOE5SdGtQd0JyTFpOTzhUNll4S1hmRjVRNW1LQ3BlbjRoUzZCQzh5?=
 =?utf-8?B?bEk5Z3h4VnZoUldGNGw2S2IybVJyb2VZM0hpeHJxWFREN1RrdnBNOUpqajhJ?=
 =?utf-8?B?MXdSMklNU2hsdy9BR1gzTFJNaEtTZVlyZzJvQ1BZNTE1Z3lKdnVVZ1dkMzZP?=
 =?utf-8?B?MjFYTDJXTFprbHY2NTRNMTV4OUtsL0xpRUlnN1pJYWh2M0UvLy9kNXlyY3ZJ?=
 =?utf-8?B?K3JFcVA0Q3BpemNZOTJCa3ZwZnlxbnVjTkpkb0gwQ1VtVnBkM1hjZnhWVDlz?=
 =?utf-8?B?RVlUUFcxcTl0dFVJTnhCRUpZVFlPOFdFRXNnczlmTVNXOVFuK3RLODFPYm9Y?=
 =?utf-8?B?WHB0QzRaSkFVNXdiTnJHSG5LYWtidEdzNmFEYmlpWVRKMWhxSEpRTjFPb3B5?=
 =?utf-8?B?allHKzU1eFZGOXk1WVhhT2NiQVhVSjM2aW52YmdSM3ArLzNzeGw3bTBKejN0?=
 =?utf-8?B?R2xVUGlXaGlraFlteVA0RzJDSGZxOXMxSzBjNVFKSElqdTB4MDNQdFhWc1Vq?=
 =?utf-8?B?VVh5MFBTanZjUm80OUNDeWRsaDZWdnZ2S3UzWTdkNG14Q0FhazFKQ1Z4dThV?=
 =?utf-8?B?R2dCb1JJUjZCSzQ4cTNnaS9NWGZCMW1DS0orTFJUVHQxK1Q3NDcyTHBBeVVv?=
 =?utf-8?B?VmVSRGVyY1ROYWg1OUNFN0hLclRLWFhDSmFTUkZJc1oxOUFEN1VmcFVuRUxS?=
 =?utf-8?B?Qit4enJnQzVla2dubm5zVDg2THRLQ0hGamdCSUd2TG1TdTA5WlhZOHVHYnFT?=
 =?utf-8?B?U1F6QU9kWFEwTnpXNUo4MXZQOXI1M0VvRzFmL0t3OTNRZ1FOK0NHbHJkaG8y?=
 =?utf-8?B?QldKSDc5VmhMeThxSVZYVEx3QTdRTi9sZ3JJb01QajhWZ29RSkIyQ2tmMDdh?=
 =?utf-8?B?T0VTaDJWYlFlUXJyOU1YRklJRjFhMWd4N0l1NTZaWE9YMTRkTGV3TkhRcTVt?=
 =?utf-8?B?RVFjVE91SzdPQXNzQ2IvbnJXLzUxRjhlRmtDeTJCeXI0V1VzNjc3K25YOW05?=
 =?utf-8?B?NmhMamg5MVljUE1zdlBZZ1NnWE12VndXUmlDZzUyUzNkV0tzSDVzSzU3dGtE?=
 =?utf-8?B?WUF6clBkS2hmYVBsZk44cUhoMUxQQW81dS9ycGN3TVQzUEUzUUJSY1pZM081?=
 =?utf-8?B?Vy9nMHpTQ0tHSnpMdXhrREJtK2JFaHUydnllSVBLZERUY1ROcy9KVVQ0c2l1?=
 =?utf-8?B?ak5kREN5R21FYlF5aXU0OEVGNFE3OGpCUEFQbTY0S3BqbnI5c1Y1dFV0djBO?=
 =?utf-8?B?dFZZcmN0RWZEZXNpQmNrbytsNlRQWDVtajRlSWlVWVdVZjJOK1ZDRXlnS3pM?=
 =?utf-8?B?Qy9nYnY5VHovS3BzSG14WExFcEJwU3IvL3huVHljUGNIbHQ4L1FuQVlaa25Q?=
 =?utf-8?B?bmN1ZlZRL2tERXRhV3FWcHBMcUl2aHRrOUVMWlNZNytZTEVUVlJnNUkvNXFa?=
 =?utf-8?B?UGorQzdVYWEzampRTXMxdXhBSUNkYkU3TzgzZ28yQ0JiNjlNd0ViQXd2cFN5?=
 =?utf-8?B?WWZFK0Z1TytvLytJdlNka25qWmVjWnNEa2RiSWxJcElqaEdabjl0dVdGdkdG?=
 =?utf-8?B?eGJsY2FEWUx4WmgzQkFuVVFrSzJod1VEcUtLVXpDaGtYSWRrTkIrTDlxZmdN?=
 =?utf-8?B?WGkwVnNaaGJOSWFjSGFRQy9CLzZCOGpXSUs4cHRVUndBaDlaNDR6L2I5N3JF?=
 =?utf-8?B?UzRycExlL053SVNDSkRFQzB0RmtBMk1ubk1oV2FNWnViYmtvTC9UMjhTNUE5?=
 =?utf-8?B?V0I4T21LSVlWU2ZINElhNXRPaU1RZ2U4OW50b3FSRGRsNDNMTHlMWHM3M0I5?=
 =?utf-8?B?K3U5dWp2RlhxMnkwcnRtWVU1NEZnNW40NFd3Y3hrSlEwV3p6UGZSUW1aK2hv?=
 =?utf-8?B?YnRxUXJaTldzaWM5NnFGNlNhUndVWENtbVQzZUhkSTNpdjE2UnlkNG0yVkFw?=
 =?utf-8?B?TmtzR2o0aUsvSERtcThsWTBFVmlqRVJUbnVMRUp2ZTArT1k5WXdvK2ZXSXRz?=
 =?utf-8?B?YmluWkFlbXB3THd6b3NXdHVueVBlSmNUVmdqOUppekhRZnJYemZwVGxQMUZ3?=
 =?utf-8?B?cUVPUWJhQ3F2S05wUkhKcmYyS1dZODUzaEJBcm1iWmI2TGpDdTQxd2dMdWdF?=
 =?utf-8?B?OTdUS2FyZGxLazRDeW5MeldyeWtTUFJMM0pUdXh0R0plakRiQldweDcxNlh5?=
 =?utf-8?Q?hkDytenBElH4lrZK0xsYW6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EA7D2D2F7E57440BAA6FBBF4F6F5624@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FvQDkFAjn1b6oeEnitCZFSsasmmReNx/Z8zeIUZWiFtuv/9NTfnlKHK/sHo0ONcsNmth0Gya3L8oKxmpMVeMqQ1LJ7eZedUrPgwjFn78Sr6EcXtH0m/CV/ukasUgLGKdcFg2j/TElt3DDIXeZYqIaZeUPRIu6GS/LCr9GnY99BPEeGBpIzoG6n7oO/PBshTlRquWeoH5dvIJWS5+nJTZf2FoFV2ihSOMoh8MbexBC7ve+KZT1i/0lvj3sfWA9HUvlkwTGJK4Vcb6HFA87z/3uJtETeB4fjiBRsfrPomkl67wiD8S+9NnUiAT9nTCuQXkFquAMQRBG2H6aGGmUveeD0QS0RoByk60wye07nq4atcYjrFSntMJFltWWIZWlVYkVxGNmYRvqKNaIccJKRsyAExNYcg8odFOsy3Y205q9X3ByW31Dg3AXN7wq+JPOdzGezphxkjWZ9I5RFEMDJN1wsKJc6QQ2/0bapiC++5Inv7SsAVGEdFyLIFrQu7PAbk2ukjSx0tMvKPmqJGcRylaimKN0rOR2J40YCgtvymcgfar5/LdlezsBIQMwbFqjpCVZEMg95HrED+jxnzRP9YZfyn08IKuomzMSPtI1awANAPd2y1DYswrRYJtA5W+QyB/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00d0259-8e18-4f7f-cf6a-08de1b7510f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 07:37:54.2424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kzQCOHiieixbMcwWlcBjpRkd+ju0xW4pRaKk/kaNd0VMb8fuqeex849o8pHStgfY/TlhmWNtmxws5AwLBoZu1fugUi+ftBImdPE92EhMyMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6499

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


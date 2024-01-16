Return-Path: <linux-btrfs+bounces-1465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8800382EAFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 09:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F32E1B22D4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6042D125B8;
	Tue, 16 Jan 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pOtl1o6E";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vZRCJQsV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E5125AF;
	Tue, 16 Jan 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705394428; x=1736930428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oJ66G+dSKlo3xL/mltynUOzmk7VfSO4EBEOvP9fsb20=;
  b=pOtl1o6EMoACpjtcOB0LAEmdyM4/Spk9AWHPzz1QUWlPU+VQLxf1nNW8
   HYCEAkhnwX7PP40ZpHIWOk7WeOwV4Ax3qe8VUz36o9aowSG+AMETVu3Xa
   Z8AabTrUmcya6qZZw81XdiMIlaI2aXXvMDUt3Nn3n3BcnRXA4l4AauYSR
   okeW7c0H57110uoHupZsfzxFSpBebt/wpcGZ1pcImstzuzhAaaESii4Dd
   UgJs3vKrAycx3RtLT4MVekNiKtNSWRBDz1lEWnMWV0ws4W67tKQERz7EU
   e4jV/8MlofncPDVHNQoftL03wrX3ydTSCCOpwfeIs+PXV7Wxs4LMKh6Ei
   Q==;
X-CSE-ConnectionGUID: sFIW8s+cTGmL0rX/YAYw7g==
X-CSE-MsgGUID: EhYTF3nMSRq2CSws4+lCxw==
X-IronPort-AV: E=Sophos;i="6.04,198,1695657600"; 
   d="scan'208";a="7198405"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2024 16:40:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhoecU2Men4JH8N261zlG2weaDkbXr88mZ4Z2XR9aLQmX4wNxPZLzQ0FgQmY613TTcU/SqPVeJczkaurNWawG5kfhReDEPMqCG5Rn9acAqaDIoif82n/R11gaFlh7f1xJYdr3NI8UZhDBm9L3530nC+vGP7xC9/7GdRCCoXowDNLU3FAlBvwNMx00Bwdnn+uxRNGai7SCvQHtbMqj5ver9f9c87S0dGvqiVLpNX6T9qt55fVm6a0iDTJieG0aDzcEL+GyGR1zzH1tPJFylXLvlx91t8W6vffbf5pdMu6Bkq7zdwhro05dhqJJcKxhDue7j6l//5XlMpTALv+lewgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ66G+dSKlo3xL/mltynUOzmk7VfSO4EBEOvP9fsb20=;
 b=E2rz+hkdsOzt5cTBLhhakmbddSrZCVVGqsV+VQesae/9Z0aLKvjspLh9bbe6hr+LmVijdqMI5FU47ZuOMPbelYX0ZjA/zVefoWc6HfQi7I6dSS4jmM7dqDovayknJa3Iq6d13+zRMqfAjONTQs59WGy37bv/clzxV3SLpV0nTt67hf3aUPCK/HevxzR4AKSdhHBeRnXudztEmIM4lW8LQAxueFOJsOINQjBU3jbClmV996JPwxJiNnRCjKWBlTSdzqQibFnWDugLH68nqkJ5GC7MVxYpBmjjrdeBTLrFV6XfZbFICL4022/njgxEWz1OVYTuy78DK1+pXiSl7pQJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ66G+dSKlo3xL/mltynUOzmk7VfSO4EBEOvP9fsb20=;
 b=vZRCJQsV/1JPf5srcsugwTuilQH4Kq2FFEh4TLcdYjkk3S4SKJfMK37bNJB0MYckV8Ikl4+0TcIwWsptn0VV5x5E7FTXBbUTOdBVEuw01PaRIDHNWdFeegOBkr7F8q0slG/O0cO2A/FfWe4m+b53NyfZRFkijavFTO5RjP0HKjI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7903.namprd04.prod.outlook.com (2603:10b6:a03:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 08:40:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 08:40:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com"
	<syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com>
Subject: Re: [PATCH] btrfs: don't warn if discard range is not aligned to
 sector
Thread-Topic: [PATCH] btrfs: don't warn if discard range is not aligned to
 sector
Thread-Index: AQHaR+qZUc8uIcbK20ytEbccMAyloLDcH3SA
Date: Tue, 16 Jan 2024 08:40:23 +0000
Message-ID: <71c8f951-e033-4e1c-9048-13e3d857f519@wdc.com>
References: <20240115193859.1521-1-dsterba@suse.com>
In-Reply-To: <20240115193859.1521-1-dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7903:EE_
x-ms-office365-filtering-correlation-id: f0baaacd-81a6-4b5d-2230-08dc166ec819
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ycH8SH3D3tq+XQeMSdP8bHWrDGKBqiM6//r7k33tWcTks3l3j2Bon8mnN05oYdeiozLf1WXh3FCuuuZ2dnqpmoEEM0tbMzuZg5AvX5Tvh/Ow351habSvEsZCrsOn4yqRTy4w9qCrN9Ryos2Aznv0uVpeamkvYXMVXoTzELgebMP0SjCZ+G/FWkZvxc3cNAIU7MCF2skhnSfvjaNKQSx3QUrsFV3niq1zbbj2Bxmd50Cg82x1JTd7Ue2CJmigZPmdC/sfzdFNv/QMfnbvSfGVt5Xi1L/qyDRL9+Z/aGKePKlqU13EHvpJhgyEYlZP4TPnAEahVGyxiKSCMBKPCiAjVx3n1AYN2nqtkuHTOPeeaGElRC0fNSpacpRzgJAauypNwP9Ie9NrQsp+mkzoDn1M6blksszxs9KY4HlG1Qiek1LO//L7gQ38W9pwk867HRmiMQe5ZXi5FETcxOULvFXDHc9zaJz+ulPyvPd6dMVcbBgbJVDjWyIJrK3DPiFYVPkH57EOS3ty+qMeUhPxJ1AdEt8YBHuGf1nrwfjdfgZNJnqc56sd6jatu6Rvp1VxYkO8qEIvTQz0gljdm9m+w5YeFAmDTEljEZiyT6aTGrH7rVGXpMqMdOoU+FdiMWB69WZ3SmxgJoLrfy+T8jNLr8hVcF6o5Q8/kNTZguuvmxeQknQLTFvgJixVGYdo95P0PQCDW8YkFsLnuRnvY2vvJ4erBVw4uj7KQQwaQ0wneQiUaGs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(31686004)(83380400001)(31696002)(86362001)(36756003)(38070700009)(82960400001)(4326008)(5660300002)(8676002)(66946007)(8936002)(6512007)(122000001)(53546011)(71200400001)(2616005)(38100700002)(316002)(76116006)(64756008)(54906003)(66476007)(91956017)(66446008)(66556008)(110136005)(41300700001)(6506007)(6486002)(2906002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXNJRjhUS3hCeXdVNHRjSzJ0YWsrc3ordjYxWU5XZjh3UGdod1lkVW12MVJJ?=
 =?utf-8?B?YkcwUGN6c0RUQVluZ3RmRzhyeU9aaDZBUzh1SVV4TnJHdklUYit5OXUzQkN4?=
 =?utf-8?B?Z3pvdm1EOGUwaFJrRHJpQVRUYXEyREFobE5lQ2plblpsQVlNTXdrdW9LZ3Bo?=
 =?utf-8?B?dERsTERSNVp5d0ZpOTZsSnhST2xvQWlPMlJjaksyd2FEbVBPamNJN0YxTnJn?=
 =?utf-8?B?bkNocDIxNytxeDhpYUI0NmZVdEljcDVWS3ZaYVZTMzVGRSsyWTBKbWNnUUR2?=
 =?utf-8?B?dUF6bE9CZWZaZUhCWExaS05NSXRwaStQOThRUVlMTlp2OFdaK29XVDlPSkp0?=
 =?utf-8?B?Uk02a2RoUzJpcklNdmFXTzJWZXl4cFpDZEhjQWFoQ0Y4anVOanF5a1Q4TjZ5?=
 =?utf-8?B?dkNEL2JvcUtpL3dUbElwRGhmWDJXYUZKeHYwLzJzMy9vdFRsUzR6ZXRRcURu?=
 =?utf-8?B?enFEekplSXdtdDV3WXpra0ZiRHRwamd3N1cvYnlLd2w4V3BmaFdFNk9OZ2pK?=
 =?utf-8?B?aldnTUVLek5rb05KOE1sbDBNTzU1YXgza1ZqZkRxZWxZNU1oSGRGeGFNZ25s?=
 =?utf-8?B?aTh3UU1XeldWSnZxTWhaRmxRKzZQNzBURjUyR1RmRmU4ZDBDTlhLUVI3WnJV?=
 =?utf-8?B?QUsxcVZERGlXeHRNdmJCNVJKYVR5NXRJUWlQRE5pU3M1QWVkZFN5ZngrZVUw?=
 =?utf-8?B?emxWM3VVbDZtbWJvVEVLRlVNc2h3bGRqTlFnb294VW5zMzBFWXlIL2xuQ1lx?=
 =?utf-8?B?aUFFdTh3VkJUMGxOMjh6bUNDT2lDS1N5b1RGaW1sMm55SnZpbUxLZElmUURh?=
 =?utf-8?B?RXJmeGgvdm9BdVUzNEM0YklJNG1wZlVRM0w2SGtPdUFabEpHcWZYSWRVTXdk?=
 =?utf-8?B?VWduNWszMW56am85VEtVNXRnQjJ1V3lkQkJyUHdUbklJMnM5b2lrUUREWXRw?=
 =?utf-8?B?ampKUzNoSjFISjFSL3piSXRJZFVqa2NDUG1zQUFHSnR1TXkxRTNVYWlIZUFD?=
 =?utf-8?B?S2xoeEx1QUlkMnBvU09Jc25nVVlOSVJDUEpQTlMrdFBWS0NiNHU1dG01MW9Y?=
 =?utf-8?B?bXFWaHFKZER3UWVnclBhZmlSVkE3L0dNTjN0OWZXaCtwRTUySk11cy96RWtK?=
 =?utf-8?B?eEN4bGlISElwbnNqa2xSUmlzaUw1V0tqbVc4SGhRQjBpeVZYcDRVc2xVK1or?=
 =?utf-8?B?QlhyOXk3Mk51b1BJRG1VYmt4RE5sQXJ2OEIvVzFKVFNVNkVOK1pRbmxZb2lF?=
 =?utf-8?B?cFBmQmNxY092c052YmFPOUtSaXR3SUVGUDF4RVVzQ1VGS2pkbkI5OHA4Qjdk?=
 =?utf-8?B?YjAxc25TU2Z5azgwNUhFWWtyUnFybVRYQ1pqVk9DVWowYjE2dGRZVG9XTzRI?=
 =?utf-8?B?WXpPZG9GalM3QXh4Z1MwZXQ0UHU2bVlXVy9VWUZjNlh2VkVGUU0zVmQwLzJ5?=
 =?utf-8?B?eWF3NTk2WE1rOXFXN2ozSDUwN2lEMWwzZUwyZllhZWg4YURnbnFRaE5qOUll?=
 =?utf-8?B?RDNUR3ZNV1pqK09aNWsrSWVDZVRMbTBjaGZ4dXRtVUNndmRHckRaOTZCYjlY?=
 =?utf-8?B?bGp2K3dGWHNMNUVDUHgzSG4yYVdiYXFvRnVrdkROUFhPMGlHMGt4VVZxcERp?=
 =?utf-8?B?dE16aURZSkNQRi9JZnVVdDdyN1dUREkvblM1SXFlWXBIdVhjRXhRanNXMVdH?=
 =?utf-8?B?WWVyZ2VuQmczMy83STJwTFdVbnN1ZTlXeHNvTWRRZXRkNUFvMjZXRVU3ejBF?=
 =?utf-8?B?YnRrNjBoQ0NFUUJITDdMUGNmWUdSSHA5N3R4SlpkK043U01rTTFXaGxqTGoz?=
 =?utf-8?B?bURtWHZQTUQ4MVg2cHVnZnRadElDN3NRa1NoWEl2S0lyZzV0Q1oydkNSY2My?=
 =?utf-8?B?ZU53dWtRUHRUU1hIYVZuQzFaOUpnNTVwR1ZEQ1hmSlNlYTJISUNkWU02QnhS?=
 =?utf-8?B?OGRZNkQ3aGlVcW5yUlA4WGZLOHZQa0dJdUlZRkN0bTNMUnRUbzZobVk4ZlVY?=
 =?utf-8?B?L0FQMUxJb1ZBeTc2aGkzZnZIbnJPbXhyTGlZeStSQksrd240cGlSNnVRS0w2?=
 =?utf-8?B?MUF6VSt3RWF3NndTM2cwbyt5RmRmRXpzMGdqUWlNYjJ1RnM1Yk9lTEJhOW9S?=
 =?utf-8?B?QkkrSnBLdTFtZnJzVG9uMm5icFBPM3V1TDNBTVBHVkRWWklyL3c3TnN6Vng1?=
 =?utf-8?B?V0FxK3BIM0tsbHVMOWpLTzRMQ1dvaFlmOGhHK3gzTkpqMlNYaWdZeEtWeFVS?=
 =?utf-8?B?ZWIrVHdIWDFzamcwQ1hocTNCMWlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74C010B9C2A73144AD99B0A7E49B6D8D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QZ1wruevFqHkVsAEda2Ac6d35QlR33JF71of5IRMA1/b1kdXo9bkuXi1QAJ+88U5XvRYEVf6khA4t6a8ydA8CYotd21461RbFv56W5YIepWFcHLIfh7TCft5KZMIAFWmXyFRXMSwZk+Z5kwFrPrViaOcih82aVomCe+gWESeSX5UcBiAq7fN8qkxdDcIjvhM1BT4J/wiJvI4NUf+p5xmHsNNbz0iiyqD0hL9S7/YIXNaEQxK8dBO6O/DgSm4wstnzB7OegDieJYWbOqGY4WPe2c148PwlpkVmtwsronxjvCjAoy1bAjyz/ckB7ggSiK9Z823HVBllLa0LG4qSX6heT/bWPvxziUMl4kzTAX5Yaiw5HjxafePgvTHy2vq/IIW33LJY2hp+Dcv3r1PW3ighX1asvqAc9CTC3kBtWC1DYuzztxr8135vLt0L3UkoJ6/SXuM+9oNSNLK8jWxpPnBkEchxBxIE7O/DVNmIe/cuPRI1FqoHmdr0YCUDiEvXGxfzGLprMnYMqnjfZfsNO+/hYhTrLhDMDeezH6NQqmu4+uWJK9QAB42i9EnE5eYAmOvm5K0IvbHWnL+xQuFOPF3d4ARzpkcfp6cbZC45XDUx3cnuwYwxyhlUtVxk/MFE4jf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0baaacd-81a6-4b5d-2230-08dc166ec819
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 08:40:23.9016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGl5odq6Mo0FOqPBWqqOksmLJM1OroDzwf5eyOuJDwJGvG4WrGNy7qLK07JwKUyqtC+D0Mn8sJa8IdSJ4I3dYKgoAdfCFGlhKh2GJmTNq58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7903

T24gMTUuMDEuMjQgMjA6MzksIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gVGhlcmUncyBhIHdhcm5p
bmcgaW4gYnRyZnNfaXNzdWVfZGlzY2FyZCgpIHdoZW4gdGhlIHJhbmdlIGlzIG5vdCBhbGlnbmVk
DQo+IHRvIDUxMiBieXRlcywgb3JpZ2luYWxseSBhZGRlZCBpbiA0ZDg5ZDM3N2JiYjAgKCJidHJm
czoNCj4gYnRyZnNfaXNzdWVfZGlzY2FyZCBlbnN1cmUgb2Zmc2V0L2xlbmd0aCBhcmUgYWxpZ25l
ZCB0byBzZWN0b3INCj4gYm91bmRhcmllcyIpLiBXZSBjYW4ndCBkbyBzdWItc2VjdG9yIHdyaXRl
cyBhbnl3YXkgc28gdGhlIGFkanVzdG1lbnQgaXMNCj4gdGhlIG9ubHkgdGhpbmcgdGhhdCB3ZSBj
YW4gZG8gYW5kIHRoZSB3YXJuaW5nIGlzIHVubmVjZXNzYXJ5Lg0KPiANCj4gQ0M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcgIyA0LjE5Kw0KPiBSZXBvcnRlZC1ieTogc3l6Ym90KzRhNGYxZWJhMTRl
YjVjMzQxN2QxQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gU2lnbmVkLW9mZi1ieTogRGF2
aWQgU3RlcmJhIDxkc3RlcmJhQHN1c2UuY29tPg0KPiAtLS0NCj4gICBmcy9idHJmcy9leHRlbnQt
dHJlZS5jIHwgMyArKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZXh0ZW50LXRyZWUuYyBiL2Zz
L2J0cmZzL2V4dGVudC10cmVlLmMNCj4gaW5kZXggNmQ2ODAwMzEyMTFhLi44ZThjYzExMTEyNzcg
MTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2V4dGVudC10cmVlLmMNCj4gKysrIGIvZnMvYnRyZnMv
ZXh0ZW50LXRyZWUuYw0KPiBAQCAtMTI2MCw3ICsxMjYwLDggQEAgc3RhdGljIGludCBidHJmc19p
c3N1ZV9kaXNjYXJkKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIHU2NCBzdGFydCwgdTY0IGxl
biwNCj4gICAJdTY0IGJ5dGVzX2xlZnQsIGVuZDsNCj4gICAJdTY0IGFsaWduZWRfc3RhcnQgPSBB
TElHTihzdGFydCwgMSA8PCBTRUNUT1JfU0hJRlQpOw0KPiAgIA0KPiAtCWlmIChXQVJOX09OKHN0
YXJ0ICE9IGFsaWduZWRfc3RhcnQpKSB7DQo+ICsJLyogQWRqdXN0IHRoZSByYW5nZSB0byBiZSBh
bGlnbmVkIHRvIDUxMkIgc2VjdG9ycyBpZiBuZWNlc3NhcnkuICovDQo+ICsJaWYgKHN0YXJ0ICE9
IGFsaWduZWRfc3RhcnQpIHsNCj4gICAJCWxlbiAtPSBhbGlnbmVkX3N0YXJ0IC0gc3RhcnQ7DQo+
ICAgCQlsZW4gPSByb3VuZF9kb3duKGxlbiwgMSA8PCBTRUNUT1JfU0hJRlQpOw0KPiAgIAkJc3Rh
cnQgPSBhbGlnbmVkX3N0YXJ0Ow0KDQpNYXliZSBsZWF2ZSBhDQpidHJmc193YXJuKGZzX2luZm8s
ICJhZGp1c3RpbmcgZGlzY2FyZCByYW5nZSB0byA1MTJiIGJvdW5kYXJ5Iik7DQppbiB0aGVyZT8N
Cg0KT3IgaXMgaW5mbyBhIG1vcmUgYXBwcm9wcmlhdGUgbGV2ZWw/DQo=


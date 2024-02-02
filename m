Return-Path: <linux-btrfs+bounces-2068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83368846FD3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 13:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F99C1C242BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3B813EFE5;
	Fri,  2 Feb 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EP/kWOUG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S+Q31nhC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF913D51C
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875819; cv=fail; b=K+NfbgUc1kx0XzWtIpKcL0K4YeBToFcFJw2roYhgsOkNZKv9ImWa2oR/RZYJBzlPSg5Rr8fLyEyYBxJ3ynM8RjExhfitkmsWFIE77m+MDpHeiPqybmALR7qkaS59yqumiR1f5ANqDYxKSjPCYX8Xaue1jgt87vNcGcHRyB7m96A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875819; c=relaxed/simple;
	bh=DkzLXhiCbbW/Vd1FHhEbX5OuMGdsjtan+on9z9GMNuM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=izDzwHOU5m8gVo5r1gRpVqMLWG4OE/5b6F65/6rL0ELJU4IqDPlRYOF3l7UN5csVHhQ7Xu73njpRapTHe8UoAin8bRkOt6hlGmY0FF7FvLcRnDr9BwM0qKQMwJaGKy7Fd/B1I4zU8G7eK+NqapK1HioxF7dpTjm7RRKgOLYYhFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EP/kWOUG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=S+Q31nhC; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706875817; x=1738411817;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=DkzLXhiCbbW/Vd1FHhEbX5OuMGdsjtan+on9z9GMNuM=;
  b=EP/kWOUG28kS9niX8GZbj7MUHkpFeKvzRfWAkUGEbyjIUtAOflwcdSRU
   9Qke1tleaFZJqUsUhDWIS2qAQaSMeYxk0OfIMRrYQ20WegL4LneJOAPd7
   oXybSVFKN+pkm2uvMBbrIn4isMGdQ3OlBC5tviZw/DAziv6uiBjQGBNKn
   cwZGh04rPeNiDQVVpOJT766nilT09DGwYqgAeX7eZ6ZzcT2h3csSnJqfh
   pWcUikJJdjXWxVVVPy2ftRiLAzxMJDjhudWMB0oDZQ6HX1Hqzm22lDOGm
   +VKJKQSZvCIoWkC0Oh5GecWp1fO+zN+Lubi4D4BodDT/ww+kkcuLFXcOE
   g==;
X-CSE-ConnectionGUID: YCarVFuwSJiehs8EfEnuJg==
X-CSE-MsgGUID: f9WafEeFQfeOmexVF2JL4Q==
X-IronPort-AV: E=Sophos;i="6.05,238,1701100800"; 
   d="scan'208";a="8036212"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2024 20:10:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUxYs9kz58fUe3Bdz8irnhqmTi6KKcRHzsDppG+ht/RSFyXXGuj2Qan2KbKJ6lhg03utSXjYhGaeg4CdcyqAoy7XGnoiIFBMNixd5XtbOL4S6LhZi9T6dUx6Rk6EIUNB/U0dPPNWDN0u0+ENeUEstQZKhDbXB1RjaPJaZB/7/1NzNszLfUFKBgPn1BiX7tgWFnL1PQL8BKF9juGj46xBBi1/mzfCwjFxz2qQDQF3eYJHs2woMVOT58FxmbllPWEwomra1IdmSO1WXtri4OBXTMzjYPZGlF/ierqqjjLWyeo4uutmBwZW7n4WJNQBtVraPSlVmmZqOaYIe3Bu/nER/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkzLXhiCbbW/Vd1FHhEbX5OuMGdsjtan+on9z9GMNuM=;
 b=QXKyzW47s1ElzIqvXO+t8b1wtlEPyk21gx5PXYsD5IE5OiPhVCGIJV8X0Ee6hLz0LZqkVKCj2eBC9VZTW6QtXLqFP43yi+OAgBdkDyOCWqfDEvibp0f+p+mXBDPRtz5gfQHMsVKysAH7hbogfMGZaG42xZ7kgsMEPeZGDF4rEVcEWnR9kXE/pJPZneu/aeNoiPnyOwkJ9CrFrakMJFz45ZXZs6Yy1iImOobifL8U1YOwS4GYJkIlWh5f1RTkZZPNRxiihHJDlsf26xhAGyE6NzQ0WVvhRM0kcr4P5KFvTwHk/3vy94A08/qPQhDrWRU0kIdL0Q1/sBJwT+JDB/nChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkzLXhiCbbW/Vd1FHhEbX5OuMGdsjtan+on9z9GMNuM=;
 b=S+Q31nhCa35yTdXntSGHVd7IjBQfb4YDoobVa7DR07yYHfHshzeBc6Sn/e3T0xl5trf3dOtSMLJI49Sv8uX1cLC64FKT03zuIn46EbyPrypQLXKscn/7tNOPkKLoTaYZ1YaVTqfOa4oOxMEKzm71nZPCYpeYCFvtW5s5JLWGD64=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7543.namprd04.prod.outlook.com (2603:10b6:510:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 12:10:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 12:10:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] Struct to fs_info helpers
Thread-Topic: [PATCH 0/5 v2] Struct to fs_info helpers
Thread-Index: AQHaVTmUHFMjcI2WYECAexgosg4GcrD29xKA
Date: Fri, 2 Feb 2024 12:10:08 +0000
Message-ID: <1db54d4c-6b69-4178-a58b-e97fa232c941@wdc.com>
References: <cover.1706810422.git.dsterba@suse.com>
In-Reply-To: <cover.1706810422.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7543:EE_
x-ms-office365-filtering-correlation-id: 2db17893-2771-4e8d-ed34-08dc23e7e61f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0rwhPzlZYcxkK6paM3klvztYXvkYWDxpFA9VK8wo6+zidYOtKzAO6+N1km6smKM51REGRIJXCGSJZVZP7aIWKYU5+7geAEj8gpF0KqFtTKj1TBcbURW+iuAoSLk7skpTkOkz+Wbk/72qTjWeewxoW4Lezgu4LjJrxrJG+k4ooBMuh586KNavYAaAzmbgEDhsgNaCG9F5oFHJd/fGooGFz3JepKuGxyNQqT0yG5Om17VX3f1y0o2b7unDyEPFd6Qxf9E36H1uvno+4+t+YKEfnJYrG2JiSkhVDyc1Hh6HD14+m8qNa1KhqOE8Qo0+7gvRyCGCxlm0Z3Ir1h+qk3+Im6zc5cLa0Zxz1i5n4B13FuZMpFFsq6iW0KEDDAJps6XS0r8kKnYJM5Q/Jb8TLR8k3R7+Ea155e3AtjIX0LqzT9eG+BTU2EamwdvXgpkA8wpAJlf0fCbz15MKRvX0u5FHQN0EPmQyn3WBUvV+pGMYApbZxsv79/eklc9ertLqmAcGxFDmrG/lNrmjFLdd+gwsN0YE4b33uG67xwq4KQUnCrJBi5ZoQsZ33wCVN6LalK3xI7zdk1ZU+iCYdOHuE3z+DRNHIAwJtg0hCofPjEKxG05myuzg7EbaQ8Zi0o0yKk7C9brIExNgFumA0RZnAwAVJYx/HR1FEpi8lfejBgSEciUMLjMW3wmKnhffZo7OPmuu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(6512007)(2616005)(122000001)(38100700002)(8936002)(5660300002)(66476007)(8676002)(66556008)(71200400001)(478600001)(64756008)(6486002)(110136005)(53546011)(2906002)(6506007)(316002)(66446008)(91956017)(66946007)(76116006)(38070700009)(41300700001)(82960400001)(86362001)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVZtWXlnQy90NVI4Q3JnbFo5RjlOTmdCTXFVMHhaOWl1U01qc0NpeUw1VDRp?=
 =?utf-8?B?bksrM3ZjcXNuY0J4MU03RTk5UVk1Y2l3K2dkSEkxdjdSd00vNnVvMEhzMjdS?=
 =?utf-8?B?ZDUvMXRpMWZ3VnpjQStOb0pWQlJlOXFHZ2hRR1VlbUo2NTkwcFV3UGZJb0ZS?=
 =?utf-8?B?WUFSZUR2RitPRE9pRGpjeEV4ams3K09QazNkdzF1cVFvRm5hR3ZqRkVkRTA5?=
 =?utf-8?B?NkI4NGxDNVZKeUxHSGtFMnhKODZKN01ydm5xRHpnclFDbHQ5NWJuQUQvMVRr?=
 =?utf-8?B?SjhoRjdnUVUzS05iYlYwK0UyZ1hxQ0pIMHFEMXA3MEZvcXczZWltQ1BnZUlY?=
 =?utf-8?B?Z3R0TGh6RjhVc1VTNHRmU0J3R3dwVGk4OFJoN2YxemhPaUhPT0RRekZKUzFL?=
 =?utf-8?B?YW9BVSt2WTlaeEJmQVYvdHIwUmdWOGVTNXNDVmpacWFKeWVFejVjYk0xa2k5?=
 =?utf-8?B?OWZvelZvZ3ZVT0ovZDB2d1ZMSjZKVnFXSUN1S1YzMys4d3MzK2txbzlodExR?=
 =?utf-8?B?S0FDczdoK3JYTHVuOXNIdElLL1Y2MTkrMWxuQWhvL282MDJCRGRmZU5HQXFJ?=
 =?utf-8?B?eE4zbG1PamdCVFJMMTlSYmV2OWxNZDJFdW44RWhPR09QUGkyQm9xN2cvNFhK?=
 =?utf-8?B?WExVd0JGQkMwam8zS0RRaU05c0Rpdkl1OWJkVTNTbHk2Vksxam45YzFHUnJq?=
 =?utf-8?B?d1hYRlBFejFBUGtPWHMvOXZPa05FWm14Rkw5WjhsK2ZubCs0VkhRQ0ErbExJ?=
 =?utf-8?B?LzVBSndnVTdFeWFmcEtjNWFTWGU4R0p5RWNWYTZSR0pPaHpkdUFZTFdQWldV?=
 =?utf-8?B?U3VBYmdwaFBIaXBKSDdRZXpWTWZKNElVd3U5TWFnc0J2Ukc2akdlakdPWnRi?=
 =?utf-8?B?aTVobUtqVnNYVlE0OGlmc01FbHNuQ3NzbGVWZjU3REVTWmVNaGQ1S29mdnpE?=
 =?utf-8?B?UU45YXcxOFU3RjVDandDejk4VUd5ei9CUFNid1J2WGxQaEkwTGF2VnhRTkF3?=
 =?utf-8?B?c3kxU01PZGxzQmNCSHMwemM0aWRSYVFkWTlKS1U1NWNEaDljdkxCUjJ1NWJI?=
 =?utf-8?B?ZCtXS1A5cWJoUWdKMSt1dnBSK2Z2RVR3VlhFU256RnJ2Mnd5YklXMXNVU1d5?=
 =?utf-8?B?eUFvMjRkcXpBU0t3TGltK1BtTmpSNmIwQkJYakFORzZYZFREd0p1NUsyQWdL?=
 =?utf-8?B?Ry9MN2w5Yzh4VXF1NnlXMVpZdWV6Z3U0R2ZGZWdsS2htekxRSDIxWVk4aHhS?=
 =?utf-8?B?TVR2c3NpVjFHSDUrWUNZaUE0Tm9kRWY4NTRMUW9vYTc5TUM0WVhTY2xKWHBx?=
 =?utf-8?B?aUdlNXZmT1hKS096RE1UTzcxRFRpWUhKbHpHOWlpc0ZIVFRIcENyYisxOVU2?=
 =?utf-8?B?dEFNN0d3NTYyMExJRG8zL1FjTU5qQVl0QktQOTQxajdMc09UTzkzL0w2ZHNz?=
 =?utf-8?B?SXhycjV4eGRPN2didjc2dlMveUFWRGFZRXo0NFd2UXp0UlRldDE5VTNxelhJ?=
 =?utf-8?B?N0V0cHI3RUZlMWtzc2pyWUcvNVdROU1VdVVEVTQ1U205Tkd5N0lhV29SUy9G?=
 =?utf-8?B?S2lOQm05NWlVL0grMHQ5Z2NOL3g5eHVodDJFQVN6OEhNNTRNSWI5RTVudW9u?=
 =?utf-8?B?eStoL2ZQWk9lWk0yODlFNUVxZldzUkxKKzdOVSswOGRvcDdHZE00Mm9VRHhC?=
 =?utf-8?B?L0ZBZEhiLzV5NitYU25OdXppSHNKQTdoTzVSR0hmL2JvRHV0Mkc4SU1iLzFh?=
 =?utf-8?B?UzQ5Q2dqNVVoSmdrZThpYjNFYU8yV1RuWUI2ME5jQUU0L1dtai9NeDZ1QTJB?=
 =?utf-8?B?Mm9aMi9wSWpFWjJJRFpmbFJDS0pkVk9MbnFBNlNxZ0hHRzk3WHptWGd5U0Vi?=
 =?utf-8?B?Q2RaU3c2ZmorMTJjWEszR1lNaldXTHBiaC9zREd4ZkhXMnNCUmZ3MFBabnRh?=
 =?utf-8?B?RnAxV1lRT3hJL0ZLZDhXMnJOWEtCb3JoalV0WDdUbkJaNDdQbHJBVWwvUmJx?=
 =?utf-8?B?d3pHQmlOMWplSVBPUVVmVi8zM2ltaWhPQktsaFE0MHZCZTUxamI5SGhNbjVL?=
 =?utf-8?B?aVgrcmN3b2EzMFZyZzZBQVVvWmF5SmlTRjM5UE1mK3VWNnMwcnV3SVRCbWts?=
 =?utf-8?B?TmZ1Qmo4MlQ4OHBUWndGZlZsTFJmeERkaGprMjVkMUxtZjNWWGZQUjVJRmZZ?=
 =?utf-8?B?bFcwT0pzd0ErWndyODExZUlCK05rQ3ZaanRWQ2JpYUsrbE5jb3ZXWno1ME90?=
 =?utf-8?B?TGtpaERvTlZUanNmY1d4MFdDYXF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5755C5B271093E4287590C8354E0E569@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dws8bL+YxwVkNQPkQUmsGJoORAd96oqCR3V5COdqBYCcQEK0YQ9GxpitF9mul0BlL6RFA2GVz4fCJ55Eh/ZW+LGZgPQIkvxrPW4YuTx/w98Up9rPI0l7ghOkRTRgJxFkodoMJLJCBL8HwLLa3QeUuL/5db6EgwNa9mXbGjPg3bynUMLwAVXh0UPIkBH08gQce1LiJoOD/y/9sEa3Ut63rGICwiFk9yGns+xltsUriQqSGJ58Hkh2G6/TQTg6AXbLkKv1zbneyo4JVUPJzWncqpHJYOKk8oGongQJyjECrwLzNAgCiOAB5kl24lguT2eWvEU17P/1pljEEaxhudypRvzK5+i7QLSNJbvxEz9TA74bzct6pZ5A6Jo/wPEP7944Tk43RFq22Wy0FW2VTrHFT4MJUYLj7rZXIUwDE0Rkg0nG0VBSeRlBc8DeBX/bT4Nh5TDT0/TlSFB4kckxHO6VytLy43HmdMafAnpyFy74jT/YvnBB1Afe6mGgCLU+Aa4I8yhsqoHvwalq/FrhuYNIvwTXXKQVgvoAhlSrdUU/3yM1hG8hX9HGO3ZjYhc6734Ck/Z06QglLrZL1c8dBR1u4tvap3iGelDKqGx5JYmqjM6su3JsHsqYWOWyCWtq/3wp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db17893-2771-4e8d-ed34-08dc23e7e61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 12:10:08.4452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpxJxinVGtc/NyeaQSoIIpxpa1BnpRf38QZ70b450Fe1R2HWvN1xijF5T3D8JUfekIEl8Z4gp39hkEfUuPRY0Y79ks0xV6jynvOwWoyPTh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7543

T24gMDEuMDIuMjQgMTk6MDcsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gdjI6DQo+IA0KPiAtIG1v
dmUgaGVscGVyIGRlZmluaXRpb25zIHRvIGZzLmgNCj4gLSBhZGQgX0dlbmVyaWMgdG8gdGhlIG1h
Y3JvcyBmb3IgdHlwZSBjaGVja2luZw0KPiAtIHJldXNlIGhlbHBlcnMgdG8gc29tZSBjb2RlIGR1
cGxpY2F0aW9uDQo+IA0KPiBBZGQgY29udmVuaWVuY2UgaGVscGVycyBmb3IgZ2V0dGluZyBhIGZz
X2luZm8gZnJvbSBwYWdlLCBiaW8sIGlub2RlIGV0Yy4NCj4gVGhlcmUncyBvbmUgcHJlcCBwYXRj
aCB3aGVyZSB0ZXN0cyB1c2UgYSBub3JtYWwgaGVscGVyIHRoYXQgZXhwZWN0cw0KPiB2YWxpZCBp
bm9kZS0+cm9vdC0+ZnNfaW5mby4NCj4gDQo+IERhdmlkIFN0ZXJiYSAoNSk6DQo+ICAgIGJ0cmZz
OiB0ZXN0czogYWxsb2NhdGUgZHVtbXkgZnNfaW5mbyBhbmQgcm9vdCBpbiB0ZXN0X2ZpbmRfZGVs
YWxsb2MoKQ0KPiAgICBidHJmczogYWRkIGhlbHBlcnMgdG8gZ2V0IGlub2RlIGZyb20gcGFnZS9m
b2xpbyBwb2ludGVycw0KPiAgICBidHJmczogYWRkIGhlbHBlcnMgdG8gZ2V0IGZzX2luZm8gZnJv
bSBwYWdlL2ZvbGlvIHBvaW50ZXJzDQo+ICAgIGJ0cmZzOiBhZGQgaGVscGVyIHRvIGdldCBmc19p
bmZvIGZyb20gc3RydWN0IGlub2RlIHBvaW50ZXINCj4gICAgYnRyZnM6IGhvaXN0IGZzX2luZm8g
b3V0IG9mIGxvb3BzIGluIGVuZF9iYmlvX2RhdGFfd3JpdGUgYW5kDQo+ICAgICAgZW5kX2JiaW9f
ZGF0YV9yZWFkDQo+IA0KPiAgIGZzL2J0cmZzL2NvbXByZXNzaW9uLmMgICAgICAgICAgIHwgIDgg
KysrLS0tDQo+ICAgZnMvYnRyZnMvZGVmcmFnLmMgICAgICAgICAgICAgICAgfCAgNCArLS0NCj4g
ICBmcy9idHJmcy9kaXNrLWlvLmMgICAgICAgICAgICAgICB8IDExICsrKystLS0tDQo+ICAgZnMv
YnRyZnMvZXhwb3J0LmMgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIGZzL2J0cmZzL2V4dGVu
dF9pby5jICAgICAgICAgICAgIHwgNDUgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0N
Cj4gICBmcy9idHJmcy9maWxlLmMgICAgICAgICAgICAgICAgICB8IDE0ICsrKysrLS0tLS0NCj4g
ICBmcy9idHJmcy9mcmVlLXNwYWNlLWNhY2hlLmMgICAgICB8ICAyICstDQo+ICAgZnMvYnRyZnMv
ZnMuaCAgICAgICAgICAgICAgICAgICAgfCAxMSArKysrKysrKw0KPiAgIGZzL2J0cmZzL2lub2Rl
LmMgICAgICAgICAgICAgICAgIHwgNDIgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4g
ICBmcy9idHJmcy9pb2N0bC5jICAgICAgICAgICAgICAgICB8IDQwICsrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0NCj4gICBmcy9idHJmcy9sem8uYyAgICAgICAgICAgICAgICAgICB8ICA0ICst
LQ0KPiAgIGZzL2J0cmZzL3Byb3BzLmMgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBmcy9i
dHJmcy9yZWZsaW5rLmMgICAgICAgICAgICAgICB8ICA2ICsrLS0tDQo+ICAgZnMvYnRyZnMvcmVs
b2NhdGlvbi5jICAgICAgICAgICAgfCAgMiArLQ0KPiAgIGZzL2J0cmZzL3Rlc3RzL2V4dGVudC1p
by10ZXN0cy5jIHwgMjggKysrKysrKysrKysrKysrKystLS0NCj4gICAxNSBmaWxlcyBjaGFuZ2Vk
LCAxMjYgaW5zZXJ0aW9ucygrKSwgOTUgZGVsZXRpb25zKC0pDQo+IA0KDQpGb3IgdGhlIHNlcmll
cywNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3
ZGMuY29tPg0K


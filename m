Return-Path: <linux-btrfs+bounces-1960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50815843C58
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 11:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437F31C296A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2737D41E;
	Wed, 31 Jan 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bOFc1S0m";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ju0/nXqy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F977647;
	Wed, 31 Jan 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696447; cv=fail; b=H0mPl8+rguzUn+kokUWUm8uHiCJOZDyEjA9XsZix6QSpQpgcZdPUVd/c6HLiUQzXrjthswsWk2UUDmNtGRHY8oL+KX4E7Xzi35YK6Fgo2gZg/svo3tmPkrern1vc82yOv8KjySTrp055+oqta/Mk7xOus1mV2c/F3k05KaKkmYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696447; c=relaxed/simple;
	bh=o1vVk2kcAwfh3FW1VK5gY6w6La/EK5if1oCLnXk3tTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ppZuSlkjKHhpvUy2tMMm8TM5d4lpG5gjhin2zIr+O29vsqSgbsbgcFda8CYME2lGV4vjQBAR61ahQ5lF9OqiGDj5hL09kn00iNLIebhITK49OPu/oqOPGSfIKvgAkTsSlFr41k71kmvM9bIoYUMsetMSaNtZqMudtYD/m5Vx78s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bOFc1S0m; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ju0/nXqy; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706696445; x=1738232445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o1vVk2kcAwfh3FW1VK5gY6w6La/EK5if1oCLnXk3tTY=;
  b=bOFc1S0ma4CN6oG1mnEPVyGXVKZ1mJ9pyei566jjzAE9yFGf0IkrAgBw
   hvpi6pYe0DQ8IHb06oEA79U9tV0pB7cQ5U6Zw3lCOwSrvS3J0rGbLfXuz
   ZhtqtvENJgckeSU0Bv8EFI4nlqFePjXlhnq/Z5G8Jmh575teDCgc5TbLx
   lZZ/mMq7hSBCBZF3iZX+rVcEQnDDUGj1VlfRHCd3tboiFoWG/E+vxIetf
   zqvccyQJgbVyaFTAZKyy8Kg2cOv4nohWXiBn/wA7JkY7lpbR/kGNFsbmV
   NxTFD8v50ly9GIYNawhzMHgTKavOt83BMqQx5921SvlTOtwEA8uYxQ+Z+
   g==;
X-CSE-ConnectionGUID: MvDxfU1qQ6Sgu8yuB/Ov/Q==
X-CSE-MsgGUID: 7R91zKiARLSGePHmVWpYLg==
X-IronPort-AV: E=Sophos;i="6.05,231,1701100800"; 
   d="scan'208";a="8220111"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2024 18:20:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOIhqyMF96Invmyql9PlT3oQ/k1PGedZRUDYWICdTdTSIm2DynUGnMER+8WuboYqNbJRW4sENenIF/CHDBQmy85299mD1G7rlerFJSmBUTk29zCE09/3lemqwDqdlNd0bwoIYD2w89Ej9yKMuvxJTRqQ1hLyXk5qDuz63QRlTWRad+KumctZuuC7Ab425XuxS/lmFLzl8JL9CD6tvNOHF6SFeostfxKRNjJhTTmB3qAV2/yro++5xL2LYF9NP7Q14BKTQee4jM2AH11eOfoFO0BbWomVV0SUYIoF7waeli/BbnkRYZfBwYWsQdUZfkiylOa1zFleE1bztWa+MJFYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1vVk2kcAwfh3FW1VK5gY6w6La/EK5if1oCLnXk3tTY=;
 b=T4zELSZ2GnlELQWI4P9sJuDn5MAMt4q/ulSR4XnuUODrF05x+bBh/h0IcLvD/xImijHnH5wKkj1M01GXbXQRSNyi6xk7RV25/zcGLCkGjB/GDOQmWpKNJ9enLEkkw+2i+BRTPcnuPsut0n6+lxRwoT9vlioztbfYsQNlKdUmqtLewVfB7ZdmUfvizcdxZ13QmpRW42FRAT4SVzOtZVixqix/Nm+JV8XatoYLNEfphoZ4vICnYdLlw4ATZTyAE5bwShiesLjhf6FOIU93qReP550TI9XkAr+gk2LYz7vbi4WL0F9MHDXv+POSrEje/0pk6ilsUXU2udqAqANkzH3M0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1vVk2kcAwfh3FW1VK5gY6w6La/EK5if1oCLnXk3tTY=;
 b=Ju0/nXqyArvARrDAGEJ/XkWEOeIV+ZGA0U5Pq4LLKQCIqMJdQWuiiPqdOXwhjZ4C1RUpmXzkzs4DJvzoGqtip/8Hbk6+FAoPIurCnDRwMNvM3eNqOoT9DR0O15ERpwR0XqXx8F68JJJ4qIPMFYlM0kgW/SDs9j344dKRpagMsmw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6466.namprd04.prod.outlook.com (2603:10b6:408:d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 10:20:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%6]) with mapi id 15.20.7228.036; Wed, 31 Jan 2024
 10:20:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Kunwu Chan <chentao@kylinos.cn>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Simplify the allocation of slab caches in
 btrfs_delayed_inode_init
Thread-Topic: [PATCH] btrfs: Simplify the allocation of slab caches in
 btrfs_delayed_inode_init
Thread-Index: AQHaVA2HUJnRXC5410SlvDt0zce1/7DztiUA
Date: Wed, 31 Jan 2024 10:20:35 +0000
Message-ID: <a31f7d10-3c07-44e3-ac28-f5d05507af50@wdc.com>
References: <20240131061924.130083-1-chentao@kylinos.cn>
In-Reply-To: <20240131061924.130083-1-chentao@kylinos.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6466:EE_
x-ms-office365-filtering-correlation-id: bd1b59c2-7411-46d1-0b56-08dc22464371
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mxj01wVxo5TVrZZ5yBmU7v7Z7iOdcfVADK5U9dmPioDez0pWY3HBo8tCQ4dpEzeY+A3oDmdyb0Et+wgbSK8Tauztm2xLbOAo3V4ULa13IHW9cvEyU4Vc4pbF+ApLMfCneghzyBcyyHAQP8cFud/4vT3LwxVu/dhxSbCSi4qjign2wtywiKbD1rUnVUnCUkkNhGNr0m5EHnRDlo7yRoKMwnXUIya5sQ8c8Hz2NQuKBLToQzXplKEY4TJoCSvUXfeadQXiKUjAhuWlDrbWv34h92zOK1Z0bVnmuffZdoKyoTsEH+U9TqspRL42Sgqr3fI3cL8EYhfWsROVhEwrNfsJM8RgifaBZRxG2QAjCERpFPnTGL2vCrsx4GV58rMjpz88RCzOFHhLPtwIdfF1bLuX0VKdm9Erjz81sJtdoWW+jgJNSsamEwts9L0ElYJ19JT+YnYtX+bNryBHlAaWM7eC68uOnQJ2gLayjWwwbfHbAWkivIaJ7HgKewaCWsLqPXAiZPSZoTAtFe7SkRf9yYfcdYPtZTxcsiFy2H0Pc3pnyH9aWsgdvxPnwmxEE85aIjgeA2W95yIgJYsswgy/KWlcCenmaQtVUh7OLWFQSEtYeCbG7WapLuHxl6g1OruDyxsrqc/j6JOALu3cqlLitgcWxLZwBKtTnFwIolZpLib7hZQNr2VVEof/y10JMVy3YzrT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(83380400001)(6512007)(26005)(2616005)(38100700002)(122000001)(4326008)(5660300002)(8676002)(8936002)(478600001)(2906002)(6486002)(6506007)(53546011)(71200400001)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(110136005)(316002)(91956017)(66946007)(38070700009)(86362001)(31696002)(82960400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEozRG5CL1FxV2xZcHc3RWc0QThNeU5sWENUSzNoMmFIWkQzd0NXZjlxa2JX?=
 =?utf-8?B?aThLQVU5N2Z3TXZZS1lXUC95bkxlUW1wYjdlZnhwTkl5Nm5nc0U4MzlsYTdF?=
 =?utf-8?B?UXVlQ0RIMEpnQWpXVWxHZGVvUS9lUWFpb1JBZXVRL3V2L3pvUEZxNGFpZGJ3?=
 =?utf-8?B?NGJuRXRxUFdkM2o0ajliZUtKeWdvR2pudFVCcTNQTWNmaDJoVFFwV3JVMWhm?=
 =?utf-8?B?K09FWmplUjR6QmhiYlBQdFFqWWJpSlVqcHNTMzh2bGdqNzAxQWVkZTZYQnkr?=
 =?utf-8?B?RGU5MHRrd1oxQzhpQUFERFJ0L3l1MnlFNTFDOUdXemNGSGp5all5c1BZY3NS?=
 =?utf-8?B?NFY5bVRReFdsU1FnOHU5YVROanJiY0F5WUhrMGpGbzYrOWVDZTkyTzFpWFJC?=
 =?utf-8?B?MmhrL0JvM3hWUVAyUWpnamVJZTZHWStWQ243ZFFPTWo1eHlkcEhLSmhWR3di?=
 =?utf-8?B?WDVaei9FWVJjaSt1eWhTL0lLNGwzOXViN3RxdXhiUll1cG8xMW9KOVZGeUdC?=
 =?utf-8?B?eVBGS0Y0UytSdWtYTHY3Sk8yVnBvV2xoaEMzc1lmcmJnZS9Fa0p3czhWdWd0?=
 =?utf-8?B?bFFtMFpxR3JPYUw3K2VkSnZJZHFjcjAzSE92U2JmVnBxNGN5dnFNMytlNFZp?=
 =?utf-8?B?ak4xcC80Tm9hemYzbm1WR1Q1MnJBKy9YSThBRUZ0MmFjUFZMTjkyeXM5VmR2?=
 =?utf-8?B?cFp4aWlOd09TWmloNjFzbWJjUVBjNUtZakJYdTNoWjhaSExPM3lXbWoxZWRu?=
 =?utf-8?B?V1lGek1QWVc2N3RWa09aQzB4QWhwVXlzeU9kMU9PTnVkUVdiUStkT1VHVHRP?=
 =?utf-8?B?alVVL3pNVkhUeC9zKzVnam9PMFRjS2hhQU9lQnJhWU9tUm00dS9MT0ZtNTJl?=
 =?utf-8?B?eENuTllET0hjb3pUWXc2Wm1NaWRZc2pZSUVhUWVBeGRCbjFJRFpKYU02K05K?=
 =?utf-8?B?Umx4emVJYXU2MXVzQ1pweHd1L3RUL3J6R09nUXpTaW15a3BtSVMwU0lGQmpu?=
 =?utf-8?B?RjZoUnBuVlNKMzJrU0hHK3JTYm1wVnFtZlZiMXg4V0ozZ1BuVmpVZnp6N20x?=
 =?utf-8?B?TWExUDhvWXhqWVowajQzamNSM3VjUjUwQ1JGaWdBd0krMFdxcDMzMGNoaWti?=
 =?utf-8?B?clpYVjNEdGZvU2pHTWQwODZGTWdPOE9Sb1ljMlZEWnlJOFFtVVN1VlN6SjFS?=
 =?utf-8?B?Uyt1MWZOK1c4a25hODA0dWNNUldDaTFFSDRVQXhJNm1mK1V4b0RUcTJ6T3Fw?=
 =?utf-8?B?eUZxZk0yQm5iLzNxdnI5T29iZkdFOHNITVg0Wi9hQTZZdEVnOE9JTzh2alBP?=
 =?utf-8?B?TzhRSmRRVlNvM3lQaWJiaVZGRVlqM0xnNFJ0Y3NyWHp4RFNBL2NVS25PODdp?=
 =?utf-8?B?dzlqUEVwRit1a1A4NGVqWVVRM3dPeWZ2d0VnckY2bHdTSC9qYXRqaUQwZ21U?=
 =?utf-8?B?a3ZCVDQxRXZiNzZFWXpIcDFZT213UWwxckFlQ3p6TjhXK0pKZzEzUERGVHZ0?=
 =?utf-8?B?bFA4bFJhQUNWcENEdTEwQkhyQmNJVE9WYWNKdE1veFl5NmgwOVR3eGtIUVZI?=
 =?utf-8?B?UnlaNjNYbEJWV040MnNKb1p1eWtDUkg0bk56Ynhrb3dIeUFBS2kvR2MxUXIv?=
 =?utf-8?B?Y09NWnJDdDAxOVk5eStQNEdTdW5VcWxSTzRvU3dIK0NHQUVDWEJnMjJZTkE5?=
 =?utf-8?B?UUVqL0c2YUU1VzFnUFd4ZG9uOWlQZC8vOTV4Y25NQ0FyQ2tmdjdUV1FNZXFE?=
 =?utf-8?B?QW5xRWpmQytBazFOVmVrTmlSa2preTYwZGdrckQrOW5HN0pjUVk1ekFSWnEw?=
 =?utf-8?B?RXV2WVROME03K3RPYkIxN0hoQlRoZmxLdytYSWdsVTczK3NMV3R3bHlBN1cy?=
 =?utf-8?B?cVYyNkhqWGdFWmovT2oyWEVFR1FCckU0eGEzaFhRZGlsVVFMUkZrdmNTNyta?=
 =?utf-8?B?OE1kcm44Z1NQZFlmYW9KNzZzcUladFEvci9jQlozUUNKZDNIMENKeFoxRGto?=
 =?utf-8?B?dzYrTGt2OXl1blArUEF4T2h0alF6VUtUU0J5Ym9Oa29yL09RWDRzTUlINmFN?=
 =?utf-8?B?NWNOSXRObEgrUndSbnh4OEFVVlh1dElqWU9CWGxRdHlsQmZNVExoWDZ2ZTRP?=
 =?utf-8?B?V2crWS9UMDU5QjBsT3hnc2sxT0F4OVBKcmdlckUzUS92SHcyQkdSV21wOGpS?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFED1F9D9200524B878E63A1F05B560C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k+Z8vbMxQcngkvZtdMQzVDaH27Js0i2xK9v25ASrDJv354h6/IvuwvKwsZxG3kg7wAUhhHnYz8R12UiuQCvV6022cZSnD+k7B0xht/rOT21OcpD1sApJyvlEpou/dQ8VvBMvZpZ9iSrmFb0DiFrDGr9/k+rbRyUFbApAnVajPt/Q6on14eaG+boX5/4BafiujF0Zqvi+AS3tLOY4yyHWI16pEWEuHNh1745AZ1+frIMcv2XDhJIlMFpoU3Xz1b3BxEx80Rkh1V93c2JCj/J3Da+GwinjMF+JVc0LltEbrdWMFifSXHyppJfYj761rM+muOtxo1eX2D8EihTJO5nunuZ/XcJdToFQIuhWeD35YGpRpA/PY9uSipPwq3M9B+Pw0JxJFEu0dlOLF+GxHtWjKheVZc/osXF253K3phpZHg/l+Nj4Xr4ZBCr7WSvDxc5OabFQD1nDsXHQgrXWwdCvbMYzWTxLM0JJo8kUm7nVxJZxP3YWG/TDTUCaF561E0JxtdeWPKE+hPd8oUq2qcupoPcTXHKD5tcSCFPP6sJnhxst5xleawv3gPJsUPvusz4LVAC135ak1ufdhitAk7O+ekcTPtNZK03Pzw7XQHYwrmoHS6jIuTdeJDfqMupZXmJ/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1b59c2-7411-46d1-0b56-08dc22464371
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 10:20:35.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zWX/iwSqo643O9GaJU0cUHTz3avnT6kL6NaWs9QFQQz5nCNQe6Hsz9km9zBXeu5UB8F0UJl1A2wA8U+nh7wVpF886wKDD0luGGUI66FZWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6466

T24gMzEuMDEuMjQgMDc6MjAsIEt1bnd1IENoYW4gd3JvdGU6DQo+IGNvbW1pdCAwYTMxYmQ1ZjJi
YmIgKCJLTUVNX0NBQ0hFKCk6IHNpbXBsaWZ5IHNsYWIgY2FjaGUgY3JlYXRpb24iKQ0KPiBpbnRy
b2R1Y2VzIGEgbmV3IG1hY3JvLg0KPiBVc2UgdGhlIG5ldyBLTUVNX0NBQ0hFKCkgbWFjcm8gaW5z
dGVhZCBvZiBkaXJlY3Qga21lbV9jYWNoZV9jcmVhdGUNCg0KVGhhdCBjb21taXQgaXMgMTcgeWVh
cnMgb2xkLiBXaHkgc2hvdWxkIHdlIHN3aXRjaCB0byBpdCBfbm93Xz8gSSANCndvdWxkbid0IGNh
bGwgaXQgYSBuZXcgbWFjcm8uDQoNCkRvbid0IGdldCBtZSB3cm9uZywgSSBkb24ndCBvcHBvc2Ug
dGhlIHBhdGNoLCBidXQgSSdkIHByZWZlciBhIGJldHRlciANCmV4cGxhbmF0aW9uIHdoeSBub3cg
YW5kIG5vdCAxNyB5ZWFycyBhZ28gd2hlbiB0aGUgbWFjcm8gZ290IGludHJvZHVjZWQuDQoNCj4g
dG8gc2ltcGxpZnkgdGhlIGNyZWF0aW9uIG9mIFNMQUIgY2FjaGVzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogS3Vud3UgQ2hhbiA8Y2hlbnRhb0BreWxpbm9zLmNuPg0KPiAtLS0NCj4gICBmcy9idHJm
cy9kZWxheWVkLWlub2RlLmMgfCA2ICstLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9kZWxh
eWVkLWlub2RlLmMgYi9mcy9idHJmcy9kZWxheWVkLWlub2RlLmMNCj4gaW5kZXggMDgxMDI4ODNm
NTYwLi44Yzc0OGM2Y2RmNmQgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2RlbGF5ZWQtaW5vZGUu
Yw0KPiArKysgYi9mcy9idHJmcy9kZWxheWVkLWlub2RlLmMNCj4gQEAgLTI4LDExICsyOCw3IEBA
IHN0YXRpYyBzdHJ1Y3Qga21lbV9jYWNoZSAqZGVsYXllZF9ub2RlX2NhY2hlOw0KPiAgIA0KPiAg
IGludCBfX2luaXQgYnRyZnNfZGVsYXllZF9pbm9kZV9pbml0KHZvaWQpDQo+ICAgew0KPiAtCWRl
bGF5ZWRfbm9kZV9jYWNoZSA9IGttZW1fY2FjaGVfY3JlYXRlKCJidHJmc19kZWxheWVkX25vZGUi
LA0KPiAtCQkJCQlzaXplb2Yoc3RydWN0IGJ0cmZzX2RlbGF5ZWRfbm9kZSksDQo+IC0JCQkJCTAs
DQo+IC0JCQkJCVNMQUJfTUVNX1NQUkVBRCwNCj4gLQkJCQkJTlVMTCk7DQo+ICsJZGVsYXllZF9u
b2RlX2NhY2hlID0gS01FTV9DQUNIRShidHJmc19kZWxheWVkX25vZGUsIFNMQUJfTUVNX1NQUkVB
RCk7DQo+ICAgCWlmICghZGVsYXllZF9ub2RlX2NhY2hlKQ0KPiAgIAkJcmV0dXJuIC1FTk9NRU07
DQo+ICAgCXJldHVybiAwOw0KDQo=


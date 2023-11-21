Return-Path: <linux-btrfs+bounces-223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8387F27CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 09:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24480B21A5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D92C1DA22;
	Tue, 21 Nov 2023 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GbEVLGOt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="umnPBjpa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89201AC
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 00:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700556343; x=1732092343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=GbEVLGOtsg9s6szU0MsmTsmVts/NwrMilipwKmD4Xlami27vmkYdEsml
   yJeZtUoziD3SLJuYxdjV0QDZ+vdFkWRu5CmbjE44zkUUFpf3krhWCFeDR
   bvYPAhKu0+8qXdsswUIvYHTtljeAw8vTXrR1qriw3fSnN95x631uWEeiN
   lwI6ozGdY7uX0fzIWgdDGJwnCqHc+j12dzUb9Htb9Dv8bXMfXKOKQ0XCo
   xixlu2ZiDXBErGCGBsbFV1YT/3og4CzsHg69lKR84p4armVQ2zqWZNLKa
   NlZ9btIJTBZ0LDfUJnC/626b0wQFM5hXu05X4cgV/i5g6QAdyWideSnV+
   Q==;
X-CSE-ConnectionGUID: qD1hAacXR7KRMo9yyhb9ag==
X-CSE-MsgGUID: 9t8Um+0RSO+VRbzzCOIwpw==
X-IronPort-AV: E=Sophos;i="6.04,215,1695657600"; 
   d="scan'208";a="2908885"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2023 16:45:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crKr6SFeMcHOWV/z/be1hs8GitzNsMjarc5afgeUUBNspZlrEdJnLChKq8NkCJz8Zk7UbSCD7YUyRbYkXJiAyQUGxrISsWpuRvyVKU1aF6lJQbhpEgLNQIbNghwZE5hGGoDO65TkLTAwnY9qTjG8knFzjVF10AjIPsAlWm9ZBIAZcpMALzdCcPPlHXME7t0yTJeQITO1GGcSmQIkh8A/9H5N/+XRv+YaAtxhXjqV18bKNziItqR+pfLFOWrBieg1OzBVvsYGdck9ByT8oocAyd+P9EG/WpOcKiEgWHxitFwNiRAbphty5T/HNziEAezyJ7RyLHuyDk+oFylpQPVzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=e5iDK5kSod1XPd+mYsnv79Km4SRwmoC45vBZQCTj8/k7Mk4vJSemZiJ77OdEZsdej4PdENU2s2cOl14gQvLhJRKOeCbgWpb5mjQeK45IrPfw2ruZVT4WV6wTZjDzokoRyieQBVr1Bl3P1V9GhVX79/hLltcGbZ0HtEqHmr5RAdSSjBjH22YETRAcGnIjLuXa8XAeerDzHgPydxud+w4b68XMXJ1KLHqB0ovN81viqRws1LD0pWTPPcB7ES+jQ9v/SccCEzWoBfWGnt4NaEKY7OB897cNrUJ/PhVy6U3XnmPYOcu/LGq8JuR23xAd1VPYDRuihnej7KaT2P3fUMMS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=umnPBjpaxqpDEVJAf8Zqr8i2tg8/IADZe5GJCFF5ablOZPQx0APHrqo66NNkfWM+dr94ZxLqS7AFhb+W9bPs80VEQcMoKzZ+964GDfEyqb+Lyk+aMdBxKPsc45B86PCOoAty0He1JqEsgvvpDjCqp1LowCxxgxuwaiil+ElTwjg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7397.namprd04.prod.outlook.com (2603:10b6:510:1d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 08:45:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ec9e:a2db:eb04:2cf9]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ec9e:a2db:eb04:2cf9%4]) with mapi id 15.20.7002.026; Tue, 21 Nov 2023
 08:45:38 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>
Subject: Re: [PATCH 0/5] Remove some unused struct members
Thread-Topic: [PATCH 0/5] Remove some unused struct members
Thread-Index: AQHaHB4XAYm+UD4L0keoPw+f4bgEvrCEdfaA
Date: Tue, 21 Nov 2023 08:45:38 +0000
Message-ID: <ce97fefe-1b9f-4c35-8035-c9bd76c04ff7@wdc.com>
References: <cover.1700531088.git.dsterba@suse.com>
In-Reply-To: <cover.1700531088.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7397:EE_
x-ms-office365-filtering-correlation-id: 812fc31d-542b-4d91-b10d-08dbea6e3c77
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6GMvPvNHmrwBRdOzjPqFgrmKZcxDyLYgz0tEgaVjMu3G2nAfGBcK48SegXwkBHDxhBXHLB+YQHwKWuj9tDb1RU2C2GHuyQBBpPHwyPfYbqU6ck8W3/3CowF3MViekhqb1l2bTdhJMBkgN1hxwld5rmRb9y07I8O/FVh+veADg8mF/B4zE0VNobbHzYkV/2QMew8Jt8nq/zSxeIymTIlCTlGVbMV1ha1WZhucgphHNPIiTOxLhe7hftnikwrDBAntSrSJN72oixr7dR35GdM2n1U6pStlRWeQDrD9/yBxNW+iYOdxxUdIMJWFcSOjGbytToXgoI2VcTgCviJaah+B4Jl30QSPU1jDKziOCiyIyFD4PI02U9JR01U2rWKPy/H676fOorAyqfLXp1RvayzJ75+IEkw7qhSddx8HW3C6zXEtJogFbUTQk0spigoi03wtOq+G78XvGFPpxhKriFoWcopyri9RfoN35gqPXraaAFv2WiVuNvm1QEznfxJTxr8X4HVPDO8s80bxjvslqS7rRJsK/l1z6Cif+EueQ3t53NuKi1blyZ5JkaDpMM4Jx2G0doFdeybQhKfNQ8kRGHXHYdQVbNtvzE5hK28PyHQD/BGoUGnLRC3SET4v5OlX0GO9jn01qkVGIwa8QlQtwC0wMMNenKb0tK5Uv4EcsmBQlrVvUYfZ9rQmVMTBi4lEH6BI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(38100700002)(31696002)(8936002)(4326008)(8676002)(2616005)(6512007)(4270600006)(6506007)(122000001)(82960400001)(478600001)(316002)(6486002)(71200400001)(110136005)(91956017)(66476007)(76116006)(66556008)(64756008)(66446008)(66946007)(2906002)(558084003)(19618925003)(36756003)(38070700009)(41300700001)(86362001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXpCOXN2bnkzVnJkM0FyVkZ6eEJCWjdRV2RjUVdjTW1GTmZNald5ZThKWnEw?=
 =?utf-8?B?Sjc2RkRYRVNUdk80VmtMenVLNytzNmxCZHlmWlpjR3VpaU9mTG9jUzlvYlRI?=
 =?utf-8?B?RHFSTVlNOGQzbnhISzREUWMzRUhqUlhBc1lsT0wrNWs3ZHFBcS9scHdnYmNZ?=
 =?utf-8?B?Y0FMdk56RzBCK0Y5RkpBTVVIM0VUSTNPV0JBUFZ0ZkpTQVlVYXM1bmlwb2I5?=
 =?utf-8?B?NjhtcmtsNUM5SWgyRkZFZ2dYdlZMbFkxbUx5Q1VCYk5OUHZCOVc1Y1hwMXY2?=
 =?utf-8?B?V3RlbEt0bzhUbnFzNWJqei9jcDJETlVzQVVpcU9LWWx4ZlFiK1l3Wkk0VHM2?=
 =?utf-8?B?TkpZY1E4eGtzT0NIK3llbEJtczRVM1F5SXlSS2pKeFA1bzhuYjFvZnpVZE1v?=
 =?utf-8?B?NEFtSUV0SVN4d1ZyNTI5S0twc1dla0R4N3FsSWhpMFp0YXl6b1BGcTFDNkdq?=
 =?utf-8?B?QzFGK0ZRTFVSZjlRQzIrdFZ3R2p4dDJBOW9Xc1dnN1c4eC9qTWtKTWRObmV0?=
 =?utf-8?B?SnZPcXpUTVBtd3VnNkc2amFGSUM3Unpaa3NEWm1Qd2VHMk1rL09OYzVxMXB5?=
 =?utf-8?B?Sm9nODh2VlFaemtxUk1TeFlzV3JQSkFjWnhTcWtuMkQwYjFhOXZscmNsVHlr?=
 =?utf-8?B?emZpNmZmQU1sQ1htMTBMeHVXa0VjcDB2L0RLQjd4WVFESjV1bzkvVmlPbTN3?=
 =?utf-8?B?NGlHZGtLblpiUTVYMFNmYjQvSDZOSC8zemJsM0oyY29DQkJ2Y0FpYXFYWllU?=
 =?utf-8?B?eFdBalBqTVgwZmVKYVdHUGhCYklEaWp5cmpkWlh2MFByVHJTb09oamZXTjhE?=
 =?utf-8?B?d2pYZ0szaWoxdlUvekhwam9ycW9QOHBobkhYKzRvTkhDSE4zdDJ3d1BYVktu?=
 =?utf-8?B?c2VYVzRMRUxqd3pyUk5XdkZyRHhpOVhtUk9RQlh0K2NJbFh5eVlqZ0xYY3cv?=
 =?utf-8?B?N1l5SDBxRWdoSXBpM1N0QTJ6VmxEYlVoNXlnRzRTR3lzeW1xWUVMS2hHVFBx?=
 =?utf-8?B?dmtETlpjblpGUDArdTJDRzBPMjdnUzFFcEorVUMvZG1ITWdzSXhpdDh2NjNQ?=
 =?utf-8?B?T1BvQWJOQ2MxaDdOWEdoeFNBQzF0eFhzUDZTVDhUUGNxMVRmL2F6ZmJzeUZX?=
 =?utf-8?B?OTRCemtkc0dwME5HMDkxRGFyVmdVdzJxODVPWkZpc0R1RWFjM1ZVcmx3Rndv?=
 =?utf-8?B?YzhqRXNVdUFKYkFQUk5MbEJUazNlR2tZYmxxM2YrdGJOM0RjS2d6anVlUWlr?=
 =?utf-8?B?eTdMd0JMdDJoU01NY201OHp3eVBwVFZaRWlodnRrNFZKSldUWldZL0JjTSto?=
 =?utf-8?B?aFNmR3VMb0xPY1I5M0NwTkpmVWxWRmtrZVBYWFhIbXBZb1R1ZEkzY1ptN1VD?=
 =?utf-8?B?V084K2M2REFNS2MwaGEzNHNSeGczaFF6NjROQXVYNWRvcFhuY0VyMEpib3Rl?=
 =?utf-8?B?NmRhTUJqdG1xeVdiRlJHbUlJODZlYUtvaGZ0VkNEdlNuR21yL3FzWTByQWJw?=
 =?utf-8?B?UnJKVE9VTUVEZnU2SXV1R2xHemtiQ2ZqbStyekhqK3RORUt4bDNaRFZTNE1I?=
 =?utf-8?B?T2dJSEFlVmdsY0t6dm94MEd6VGd3R08rOVJDWXdwMWJMQTJ6Rlh6bkJFYXBt?=
 =?utf-8?B?dzRxcnpYY2x6djJFRjlTQmNwb08wUXp1ZitJYk16SjgrOGVJbGNULzB3NUdL?=
 =?utf-8?B?eXFldTFFNlQ1MkxaYmszVmNvcnBBN3dRb0s2N0t2aXVpbXYwR2RIcFRYbWNj?=
 =?utf-8?B?cmRneXlyY1NqWCtpc01rZXViM2NaVFhPY2VPR21rcHlUUkNXSHl2NXNDQlJK?=
 =?utf-8?B?S2RkSXVJT1B0eitqVy9XR2w4Lzc0T2k5VnlFUVMyK21ueGJSVS9UVktLT2hX?=
 =?utf-8?B?T3lEMkRiZUFiYjJVOElFOFhIK1JmRXB6YWFuWU5aKzRMa2RPMmF2RjBPRjU1?=
 =?utf-8?B?QWF6eWliV1JyU2xzOVpuKzM2NCtNcWxOUWFwdkZtR212WnpEUTgzc0pIbVlm?=
 =?utf-8?B?L1JVNzF4K1NFcUk2SlVjclF2TGZNMHByK3RJakZQc0lOeG5MaXJkeFYyeEd4?=
 =?utf-8?B?WHVvZlBIcDdaeEl5YnhJNE43YnEwZmVPRithWjNTQTEzYTF4SU5wU2NRSzJU?=
 =?utf-8?B?VU4rcUVsK1RubEhSQ0JNOHdwWEZQYW1NY2YxcHNOYWRhNVB4dXE5Q1BFazdH?=
 =?utf-8?B?b2xpL3FZOWhtazBqQUlrSWRqbXZVeWpyL2txaTF6czIveVkyc3ZVSWJUYndM?=
 =?utf-8?B?OUcvTU5iRUpQQ2VFcWJENjcyNXVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B735741A4657104D8BF609233F5A46FD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IClsMZfSBJaWJurYOoYK7eRiOrvJAK0q+X4E/NAEk5v1017Zz+i4Nc6uqUn2twczcJic9mG2hBLOht/+nSRA3MWFEr99DCDJ908alhMv88f2+2xU8yZB+CyXUoslTYeN41/zXuU9FQsi7MT0YFiyXaaCPvwm88cwtJByhN+2TlUkJrke6g7ojaQCXFeXKHU1Wxe6JQTtVf3wc69KWG/yWsW1eegYD0qK9cDDBuK2gNLkYkSfSScP4kjGIPXSwmqNkMbLBOwKkvveks4lbgcdwinojPThfjXeMZYkXlwcpwGmNsN4G0omarC18t0jlmGIVGLXiPu9Gui5jmfNApDeDMJIhPRrEmm3EGqin+XzTPkQeJwl2U2MWxQ02Bp2ExEhA6/YtcsyaZfi1QmHI2cwNGI8arcbHdd6gVNrQG0z217NoXfwcp3U719aCLQLV+jzlFdz49zGuTvpGuk8RK2PhodM1ls8ZvO2/YIV3T5yktPj0lv1EnH0JM/k7OUwpJEx/nN643Oaev9zfr+21LGXIiCIb/XSzVZmw65Vm/VMQRMNBV3CnlTbg371pDVWD5nBcp5rHODqmMhsa6bU27NvAT1fBAcfwkNFHlMhqHTJtdNik9TB+cHHSL077QaPmmeVeH9ZP1wxNjfv5JxFV8UOobQEPIkHaCAxf7rwwHuxXKvX/ad4NiNw42p5qqLMdeSWLyqbASIM5O1Gl88859Wdpae2/wT+pL2TiDmsmGEoAEse6gPrYA0D/Hv2mu+9bYb6F71ZwLj6vCDu0zKQBpJXzXnriB7RjHRNZpOiXW0kDjwSJgFRBRYwu+kADrl1H7moA3uqLr4m3IRmAwp7LbwSYA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812fc31d-542b-4d91-b10d-08dbea6e3c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 08:45:38.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slBzCG5pOzOVO9f1WkaRFQ/FdckuH8XYV08fHqwy9GMukzpCvdYy5mLus9FX4trWh8fJcI/MXQAYUgDWTuqQTOME5vX/2a0Uj302NMzLJw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7397

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


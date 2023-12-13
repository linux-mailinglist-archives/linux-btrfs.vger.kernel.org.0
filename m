Return-Path: <linux-btrfs+bounces-905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBE2810CEC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 10:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FF3281559
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C2A1EB51;
	Wed, 13 Dec 2023 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C9MU21JS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eRnXQM/2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A07E8;
	Wed, 13 Dec 2023 01:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702458246; x=1733994246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=myDRrFpvTIMO9MMLh9TlgmhJwP/0HJQc4ONE3G0B6FY=;
  b=C9MU21JSUK9Wq47YXaNNEi+4AF7vVlwy49Aw331gi/xAe1Pj6H5TwXkx
   X3vNcOjCqfHtyhyoRu8lPlHAUEtlYOrovGimUs8SL8L8vQHpc+2NcDpiC
   NPnTXBJjUnAvve3nuq4YC5uYiDnJe4JYaehZl6SQNKeq4EQPBa6Qa2xwl
   VVVQWNuKrumQRUfRxbd7wMfctB09R4sfZSOqHU2i3ZdJD2bD0U77kuPNK
   uvsZE1gu2TVDOw/e6SBswj45ojMBvHj8LTIXV20Ycc+7jaae14TOyKy/L
   1D6wqGl3jB7Zq+enL5IEXwcrruloxzrVhO80Pgad+zixygRSFTzsR7j8k
   w==;
X-CSE-ConnectionGUID: 6N7qJXxTQAq3HYPoT1ggkw==
X-CSE-MsgGUID: fIf0BWRJTuOPp8u8RZ1+2A==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4880552"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 17:04:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVAplhobXM07U8+FcN+W4rmnzL8GW/cRjt1Dz/c4LrJxHdG/bSD6a76S43yazjk7m9l2nCDsGXTiLWqjcU74ixDNhkYXkP6aUkhoCRYXuZItGC8RbnECx/zGuaW6bMbMYUGXFo9AujvwiG/hIBuTkktQLt5+rRRnvDMP5vKrQaai/MqiRD6BBOvatigiPYcaHav3eZ9yUn0yQ2F46veWeIhdHKlM4Oaiv/jWUlxlI4S0ru6x2hVnfVRTlYBpeJgY03ySu53SB5i84thEWJEu/aN9TeCLCMGf7byzaLK1PfCk2RGsJzYoqwVZBRxE3oiyEqSXveLNfZG9i8rDseFWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myDRrFpvTIMO9MMLh9TlgmhJwP/0HJQc4ONE3G0B6FY=;
 b=JK7usdIHeb8h8FpwHmdya8NRUbqMYfnA45HdiswIORTyKF+MVLaRPPA3S8C13JwJEXtXfEiIUoRzb6amniCataKWepUbbXHlnrGUnSkFTxTqtQogeRBbUaScbVmXkEjgU3GbUcKgzeQzeArfjySVM1quXUsJiG+QDpgq50PNE6jekSU547tiWxZWCslgBoWMvMQ4p64oEO8YxygDozKLBSbYCm8iZ2t/ISA3Govw278OpApb7O0Qizhf/l5AEYlq+1jUgmhiB8oOWERYJv4n/cG+Z7O5Da5GRXG47uBz1zFciz/sLBZJeM3OPQrvYoq5hNSJ7g/6fvWrivUnnnQ+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myDRrFpvTIMO9MMLh9TlgmhJwP/0HJQc4ONE3G0B6FY=;
 b=eRnXQM/26/8viXPU7S3QDDBve8hmc95fiB0e8RQ8323HIuYAHeTG9lXQAyuAOcXjOW+0pqicmulZho1hYOIlo9N5iIqIuAl0w65hwg0kok5UgubuFvmaYAzTxBXnY3o1w9OAO+DtHsoKKV/EXNBQZRmjMB/R1I1jDqOj3zfdlzI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7270.namprd04.prod.outlook.com (2603:10b6:510:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:04:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:04:03 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/13] btrfs: factor out block mapping for RAID5/6
Thread-Topic: [PATCH 08/13] btrfs: factor out block mapping for RAID5/6
Thread-Index: AQHaLPgcL4LtnCWMtEqTZXD9xrKVeLCm6aKAgAADEIA=
Date: Wed, 13 Dec 2023 09:04:03 +0000
Message-ID: <842e3804-1fb6-4d37-85e9-8df3c2658716@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-8-b2d954d9a55b@wdc.com>
 <ZXlw8Ux/HJBSKl1M@infradead.org>
In-Reply-To: <ZXlw8Ux/HJBSKl1M@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7270:EE_
x-ms-office365-filtering-correlation-id: 3d6a9311-21b8-440e-d76d-08dbfbba7473
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dKYdwb6YS5spGL0TK8o4ay7MVFi/BfmFHV6Ii/uPAwYZWvcvp/qXzx5Iq6RpcZ1pxOAfJeDLPAD7uScfMam4PMH2tlaVvgvp/i8eIBfNT48Lx0vEz5ITaMmouiXvMtGLdx8qD4+uAES2UDcUY8pzOQeJ5jUkIdkPowKMvQDEavfT0ZE749CKnc4JxkGkUuQYF8VEkyjAqlYC46z74yC1HEIdSKznMBhUyRvqzDWmtiEgLrOt9jAc6hE7hKBPn4OdQlX8S3+OQ8wrFfA+1Emaq1SV1TkLLaQmF1SxziA9ZJcfW5jf7Ib36XgQXBs01Qe4vVp70AJKcCdIF7Y+j85AoFHuvDtKNWCF4D6eL9UCjHz4QeSD2tM0VMz7QhKlEvouB7umI7wXZFPMOaxmv++Hrh3bliH8TCqU132I/JDVTxd9HzB/7sPQTGC5tejeZeNnKb2GY+wm7to1jbWzdw6/I2L9W47naUkuXm7MlZH5PJToNGZvT4Wl8ZMJ9S38tUz1y6TL/lsB0MC6M/xK6yUnrBh7+LBJ8Y+7A+LqndnWeVWfKNeWnh9yrzbIqdcC5lKFTLHY9hd9zVLZ+5j1E0AhjXYPnGjIjs80lCN1E7I8nsO3oygnjmxaEsVHnYAX5bLI66bnJ9EXwW+rW3zSYbKhTLH3FAEPeWfcMppB43IqDaMQKczyZ5kLZqjuS6a8miyJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(2616005)(83380400001)(38070700009)(86362001)(31696002)(82960400001)(36756003)(38100700002)(4326008)(5660300002)(6512007)(6506007)(53546011)(122000001)(71200400001)(316002)(6916009)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(54906003)(91956017)(64756008)(41300700001)(8936002)(8676002)(6486002)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHdEb1cwZ08yV1BObHpZZXZ1Z3dIbDh6akxjNjJyTG5XOWx6TGFTOHFjYlBt?=
 =?utf-8?B?ckhpci92YXBhYVZQZ2lHQlpIaDRlRmt6UFA2UGJ5RGxTdHlIYXpGcllEelNF?=
 =?utf-8?B?MEZGTWx6ZmtRVGZQakVVVno0dDJhVmxjeXNRQUg1b1RDQTM4emRQb1dUdzIz?=
 =?utf-8?B?TDd6MHFpR21rUHlQaDZVT2hwZS9DTkZ3UXVabUhLcVhqWVU2QXlsQVZZUHVC?=
 =?utf-8?B?cno0UXUzbXdBaG9mNExPUms3ZFdIQXpOUWNFelNuUzNVTVZWb3NpTzRrOTBl?=
 =?utf-8?B?THJLanRQUms5VnVxSDR6YjJlU1Y2T2RubVdaSFZHVmdycHI4QTcwVGxWZ2t0?=
 =?utf-8?B?QXBHaEw2R1NsVk5ZR0JYU2lENDgrSDh4RFp3aWdPajk3S05BcmZmanU0QlU2?=
 =?utf-8?B?RUdnR0lCMExpdEQybFlvN3IyaThWK1pVOFpvRTFZem8wcFRjeE12Qm1IOWNE?=
 =?utf-8?B?NXBYZkdtREM2RWE3dFZ3cVY0dDM2SVdGL2REUUEzekNYblR4N2lhR1U1WlhD?=
 =?utf-8?B?RldwWERNYVdiREF3cHZCNG9FbmRJbGJGRXI3WmRvejNEQlYwbDljVURtUnpR?=
 =?utf-8?B?ZDhBb3pQdDVmaUhUd2psb0d6S1ZOUDUrRHZlTkVuSjhoOVVTRitUcEEyRXY2?=
 =?utf-8?B?ZE1uaWo0RlFpdjBPbjI1YVpMQUJFTnlvMEZydUgyVGlJcHhRRk1FdDY1a0tD?=
 =?utf-8?B?aXNsSkJNMnlhUnBSZWJSS0o4cmowYUdFYzByTlE3MkxqODVzVFg1NjZLanRB?=
 =?utf-8?B?YkUzT2cwVmswYVJHMnZQY3I3V2JZREV0VW5JNlVwYk9HcXpVd2N5OUFPa3NC?=
 =?utf-8?B?Njh5bWNwUWxnMkhVTUJ5UjVHbFpraHc5Q2dQYytJSkpRVDNMMTRWTWZuY1FK?=
 =?utf-8?B?Smd2ckw0cGxBK2lSdnQxdlFuNS8rb1ZPY1FiMGxGc3AraUJkaW1URTZESFdG?=
 =?utf-8?B?T0Rua2lycG9RRytQY2h4Ykc1TjVXR0RRQWdtNmg3TW51ejMzaTZhSGUwa3Zt?=
 =?utf-8?B?Szd3OXV5djlZN2JJakxuSUxZMTE3dityUDVvaS9BZ0lqSXM2V3BiUTM0WFcw?=
 =?utf-8?B?VHJCTHZ3MVd4Y0U0czN2Z0ZSNmpobytLaHdrMkF2eXVhcG9XRitKMGF1RUxh?=
 =?utf-8?B?V0s3eUZnNUpJVTBjQkdvcis2ZVF1MUtZTGFUcGEwYXZYMXZtYnp1ZnJRL0dH?=
 =?utf-8?B?V1ZXUlRoRXlLakUxbEsxKzVQTThUUHppbXpQUzNTWG1uTWRMYlNpclVpSG43?=
 =?utf-8?B?b0haZERWN1VhVUd5Y01OR1ArSVlQV3NyUUVoWFV2T3pUK2FIQzZSUFBUdXI1?=
 =?utf-8?B?VHBCbXhLdmFSUU5nZ0s1MHY3d1pjcFFHMndWS2JTQ3VJZFpxTjVzVC9TdFNx?=
 =?utf-8?B?WXpPM2d1dUF4WE9UR3hPVWFhUU80TXpxcEc4Zk5rbUZEYWU2a3JsNE9vQ0kv?=
 =?utf-8?B?QXViVTJGd2kraVhxQkhRV3IvSGF2ekR1bkZidlRoWEJqMDZKSW1hYVlSTEdp?=
 =?utf-8?B?WWZDSlpvM0JOVGhpSWFWZlkydm16TE0rWnNrOHdwWDRjMGJ5YTE2SGpTQ2JP?=
 =?utf-8?B?KzdPeGlTcUcwMXIyUUJ6Z2N2Vm5mQVpheVRiU2xHekl4TDdxZWludmI2SjRl?=
 =?utf-8?B?OEljRDhzdFFqV3J3akQrOVB5OE1BSnF0QzdPVXQ3Q3RPVkpUMzB6L2d2Z05H?=
 =?utf-8?B?cXc2Z3BJS2hxTnlpdkg1SzhwYmQ4YlhkWXEzMWFmanpZUXpsRmRtUXozc21I?=
 =?utf-8?B?eWVPWGNtUUprcHY0MEtzY0NTNmozVU1KL3Awc2pvQk9NK1FScHMwV2lDMjVX?=
 =?utf-8?B?ZjQwSStYaTQ2dG5URUhmOFZ4RkVmMVZVK3FZeG1FZ0pZdzFNSTljWmVmRmhQ?=
 =?utf-8?B?TXhBcnNram0wODBoU2M5WGhXanEvZnJITUk0M3Zvc3ZxRVEyanRYRDJ2dldI?=
 =?utf-8?B?NVRIdEpHUTVSckltQWhLTnRPTEFRN055b3Z4eUxPcTB6MDA1cUNLNmo2RXhB?=
 =?utf-8?B?VEFaNmdDZ3d3RHlJSWZGTUU1WFdWc3lRbTlkbnhCSldqRG9MU0Vkc1NBOTJ3?=
 =?utf-8?B?ME9Cb3BRU0VXWDlPNnh4NFZORlROY3J6aGQ5c0NIVHpXQWZXNjVnbnZYd04r?=
 =?utf-8?B?SXRSazNxOEtBUnhIaDNPbk45VHpRVWRVWlFuNWJoZ0NXczFwcEhsTDgxKzVp?=
 =?utf-8?B?dUl0ZlBBQW1KQ0p6ajNpckg2aGUweFhGbUtuV1BVcU5NTVd2UVh0Q0k1QkRN?=
 =?utf-8?B?dVNrQXZGVnZwWmowVnZCMXg3c0dRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E0782648ECBD44FAE3EBACCD1B11FBF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cvS975R5TvzVT1T/dmEto0jj78GO43mPMm6ZZkLQ9NgFrNmrFx6jrJhzWCxVfkOOf7vJDCXe1qSj8j1WWqAoD8BTkzThZknIGLmhY5uz6QCxVmB7RfFidAZMRfGos4/o16/G3XlXftWKXRUjbiY1PX5fyt/pm4xxv/BiRWx/Xd64KWi+BeujNT7n5KoakXGBPEvwU0Fa43FW0pdNa0GC7q1VjPUonYJ0LyQirCDbIJqDd75zJnC5bIpTAYovVz78+eLvkYUbo78oVY+kzLUirKy9naSXpZKtiUrjm8pKFlwiEh+Y9Fi+LaVyXqkt6jyM8xHCze5BdI6CEXiGfq9UPRNz9wX/WiJmBscOScG1DXWIBac0fuy6yrrXCWsC4eGPZ+wVTrZAzL3LLGJ3dpTfygQ+z1X4SOgxv/smBnwtzCx/v8hegOHEGamwTVo00kTykl/Fddb03JkeeIuXPisaMHRmlfa9mioPQ2Fq7LjKQ6Mp3xrb0+ZImRLP1xcIi1B2S8ddt8A3BmKRsY8PKMYrlb9WYerkNwR3Bjon55a3Xm9IVLo7+VFWVD4kGVS1qP13rWu82FDZ/wrQa/ULHO2aSjyp4yCWHX3f1QB1uU6kuc2C+6X8BNFZbGpIQIV533WG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6a9311-21b8-440e-d76d-08dbfbba7473
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 09:04:03.8941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIhQ/2XM77tUkN5y6GJszvhDlJNb7f8GFCPUag+d+GIU2ZtI2q2aFPbEan2LeyrjO9tJyglwwypd5lmtCdH6Xt8VX/6+5xxW+SQmbcUjkkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7270

T24gMTMuMTIuMjMgMDk6NTMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gK3N0YXRpYyB2
b2lkIG1hcF9ibG9ja3NfZm9yX3JhaWQ1NihzdHJ1Y3QgYnRyZnNfY2h1bmtfbWFwICptYXAsDQo+
PiArCQkJCSAgZW51bSBidHJmc19tYXBfb3Agb3AsDQo+PiArCQkJCSAgc3RydWN0IGJ0cmZzX2lv
X2dlb21ldHJ5ICppb19nZW9tLA0KPj4gKwkJCQkgIHU2NCBsb2dpY2FsLCB1NjQgKmxlbmd0aCkN
Cj4+ICt7DQo+PiArCWludCBkYXRhX3N0cmlwZXMgPSBucl9kYXRhX3N0cmlwZXMobWFwKTsNCj4+
ICsNCj4+ICsJaWYgKG9wICE9IEJUUkZTX01BUF9SRUFEIHx8IGlvX2dlb20tPm1pcnJvcl9udW0g
PiAxKSB7DQo+IA0KPiBBbnkgcmVhc29uIHRvIG5vdCBoYXZlIHNlcGFyYXRlIHJlYWQvd3JpdGUg
aGVscGVycyBoZXJlIGdpdmVuIHRoYXQNCj4gdGhleSBkb24ndCByZWFsbHkgc2hhcmUgYW55dGhp
bmc/DQo+IA0KDQpOb3BlLCBjYW4gZG8gc3VyZS4NCg0K


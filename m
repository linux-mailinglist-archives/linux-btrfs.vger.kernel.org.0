Return-Path: <linux-btrfs+bounces-908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C8F810D43
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 10:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E5E1C209E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0A200D9;
	Wed, 13 Dec 2023 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="imamM+Fu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tGD6uAxm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AE0B7;
	Wed, 13 Dec 2023 01:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702459417; x=1733995417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Se71UFrht0hKIjsxSWL1Vp5JMIQ70GCiGhDRXGGyMHU=;
  b=imamM+FukjSukEtm5rOcF7JoDt6Dt5X82D28VHd39u8ycR7C7s205IJB
   x7vUr92WXmUPLt0z1DEvOEu4bfLcvh79jBWEfuoD8VQVS2HUiYZHn1DBa
   ZfjCJtWsZuuU+GUgWo8MXmXJh3WarM0/l+sFouP6oiwfberf3v9XF6U6r
   5XakLaHvANU3fnM9AAS72FR1wdvqosd233fLseeKNDveq9/3Ocp8Cn3j6
   snqOQQ+om9XISNJvwXmo/zd0G8mq7KEsiJEAamncWVAwjUgGCv2gQXN9L
   ONDocm5/HmiXGt1eRhOyN5Qq7v3yXZFjD0QrG0EK4RMySJUrrkvcYamGv
   w==;
X-CSE-ConnectionGUID: Ckohh19JT/uivDMZ6dfIoQ==
X-CSE-MsgGUID: jI0prsmVSCOHNBnLUPOxgw==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4882001"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 17:23:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2rYmBUHmEfOdI/zkjYdB6QNV8kWxXKHRkpWQuOVxdFtTadLa3t2voJNcTvEKG+len+WzWGGQDRKhvqpNhuLvxWMqvBUIguo614iBsrPoE9qvA/qHpaz9qzstnb5UqvehPqWqked0xSXa1XicCQbEPZ91mpbQvVLqi0F7IPCVSV8o4tvxkoMsc/1V270nOegmwoELvaoE5VMVhPASJdh1GMlKqH5UqQqDtoegIltQN7wvWeZk0K0tnoKBwHbcYyjaH1fDHgP3uMzwLNzKISYopN31npZ8/qttV8/qS39wz9aEZ7YiJE1vXQiPSz151sUS7HsrxIw8Acd6sbWHpNiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se71UFrht0hKIjsxSWL1Vp5JMIQ70GCiGhDRXGGyMHU=;
 b=FT0YAACvpAGsYVu688mvq90HoNXQmnRioU1+ols+AubxE0b+GSL9uCycG/zzKr/wm+QHs6z98hbDL3MPyB2CL5e3PqVMykU5SVx7IzBrZzKXU/z1XdwmjtzPYImbsLkvZgJjtdZxOy8bJwRO5/AKP/bfnO1zEe2dsCZdQoiUs0OAylLl3s/IpBVcujRHNr+wjyQrvsAqUkEW5CKDJCQAInIVidZNNR/okvqfwKXJhf13C2xGn/zI2xWUJr3rMMFhlv4zw1lEYlYthzXzdxH11GYnx2EROmisijXDEXAZH1oq9Nno8lo4ZVaZvOujg8XARZgRXnhn8eZqr74vWDtu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se71UFrht0hKIjsxSWL1Vp5JMIQ70GCiGhDRXGGyMHU=;
 b=tGD6uAxmM4qv6vDBnNRRNOZakalbMj0MVIw74XV58WqPKw2H1b0nxABKXx2zkV6sEVYuMyMxDVbQ3q27ScwYGygyN9/g/YjfqZlP3fVthG9igFuV47OK5//zEHcfk8zgHXxghAG147wP0xuMv8JlVKTXSBN4Y7MBPdeFDb8JFLQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN7PR04MB8693.namprd04.prod.outlook.com (2603:10b6:806:2de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:23:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:23:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/13] btrfs: open code set_io_stripe for RAID56
Thread-Topic: [PATCH 11/13] btrfs: open code set_io_stripe for RAID56
Thread-Index: AQHaLPgdK+jg9mbUFESmBC+cO90CU7Cm6y8AgAADHYCAAAITAIAAAYQA
Date: Wed, 13 Dec 2023 09:23:34 +0000
Message-ID: <da47c962-4754-4bb7-addb-cc802c5df4d3@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-11-b2d954d9a55b@wdc.com>
 <ZXlyPqtXO+j90vJb@infradead.org>
 <f1cc59fa-9260-4a42-b346-17862d0f8385@wdc.com>
 <ZXl2mL90/2WtZgL4@infradead.org>
In-Reply-To: <ZXl2mL90/2WtZgL4@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN7PR04MB8693:EE_
x-ms-office365-filtering-correlation-id: 2ab09588-d524-4b29-46e9-08dbfbbd2e6a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XLrN5i7ULSDXE/NjdZJQQQk6KzACXVmuPjXgTZrSFGGJkDnLMuujfCU2BD8OgpO0TrE2OeYEb9jt4Fpcqm4Gzq7keS9LwouMbQ8y2RRaGTgu+JKAn8SbX8zUzHb44F0fNOwIo5TUS1TdE4Z+ECbiWQMGNSKUY6DCV+wulHgEvgjurGGnpI0cCeVTfp4LYPKo/tQ9EYFDLlfdRP3fRuPUd/IlX+R7LgD9zGXSPazrc8p6Xsrau3Up3P3xYBejM871yF/UGJvXKG1G+PVIymkTW76YrTzaR7hgSaO2mscFEZFX8i7Md/t8hbrvauiYqerJq3gNr6U8RjimXrbo6abvTkAgQ++6s3pRDsOJYTJvXWQL20FGFaeH7Ph4rKAFtt83D9yA0Jm31HXWkwLxAnl3/U7VgPKqlfylhQpaEMJP/4z9dMxjt1fK+VFJ/r5HmyZ5IlFBGNPSHsbECEwBN1B17ORph2/5JMjCMDYr+9Kx/JH1AlNEfdDY1w+qTgqrJAQM9WsgHTPsIUv9C3GJeyb1gajSX77cMeCybKoGBntTpvPLmob5qAfiXF/D87xxwb7GyaMozr3tiNwj41C9MgXLMpBWdV1cxFYnRsimgGLpwFjVCkOD1hMuCPu+ixdfYHHAvCxSJvBfNCgP8+1lRKqfYMZv/HCKzASpsJWkWSEJoEs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8676002)(8936002)(2906002)(31686004)(4326008)(4744005)(6916009)(316002)(5660300002)(66476007)(76116006)(66556008)(66946007)(64756008)(66446008)(54906003)(91956017)(6486002)(478600001)(966005)(38070700009)(26005)(6512007)(36756003)(6506007)(53546011)(41300700001)(71200400001)(2616005)(82960400001)(86362001)(122000001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzRsRFBnZmg1RStZM2RhYk5CQ0hONTg2TXMwbXF1VjZwVzZTMndpYm1HZ2FR?=
 =?utf-8?B?cHhkUDBRMUpXKzJ1azd5MmVyVlJYUTFCNk41L0ZxY3ZQcXJyR205MXk0OC9C?=
 =?utf-8?B?WlRMMlJ4Sk5jMUVaMDNoTWN2dkRETnRlT0tUYjdJVjExZW9hVnNOYldlV0tR?=
 =?utf-8?B?eldwR3hpV0E3SEtXOFJZa0xodFFzcEpuK1JjUzVrSExYYmFxbVRLK1JYZ0F6?=
 =?utf-8?B?TVdKWEp6My8zUWlOR2pkNGl5alBnYzBNaW1OYS84T0JZOXltS3VBZ2ZLTzhy?=
 =?utf-8?B?ZGZwNkRjSXVFdW5meEswelpGUnlMRE1TUG13ZWdmazVFRzBuaXBPNFlYemNU?=
 =?utf-8?B?SGFwWUJhOVUwWkJLbVM1RGk4Q2s5MUFPOWNMYWhqOUdSa3Bia3hqZ3JZVnVU?=
 =?utf-8?B?Z29oL0Z4cmFGZmE3VWtwcDdNZ0J1dTFZVjkxN1VEVVQ1S1ZlN1pvQ2p0OU5F?=
 =?utf-8?B?ZHZ6QTVLZnJlcXk1ek9XTVJuNWZ0clVmMnJoK29TZ0ZIYTZGOWpsZEd6b3hv?=
 =?utf-8?B?aG5TV2pGV2xwY2pzUmp3NFV5Ym1lN2pTWjhiQkdKVjUrL3FCMW1ycmE1Qzlp?=
 =?utf-8?B?alBYVVVWQlJCZHJHWE52aWtQVDJ6Z1hCMHpYY01mbm85WGJJSCsxUW1KdEhG?=
 =?utf-8?B?Q08vd29XS3dMS0xObXpIcXlSd1BLSlkxWGNFZUVkWkRTandGQnRlSlhhUmRs?=
 =?utf-8?B?Ry8yaWU3T1J1OS94RDJGVzlteFdUSTVHZ2lmUitxU3hsWjFNT2FkbUZ2bllL?=
 =?utf-8?B?enBQdzNEb0gwMmdTNk4rK0twRFliRzdVWEgrSjhScEhqbkVRM0l5QmhXd3Az?=
 =?utf-8?B?Nklhc3B1UWJ4ODJhbnltcFNEVnhpWUVkMHlmcXg5ZEl3enQwWnhLZ2xYd1R6?=
 =?utf-8?B?cm9maDVFOWFVa0xwVDYyQ3ZCdktQUWdiYXlVVnNXTFJUTVp3VllZcEo5Y2pE?=
 =?utf-8?B?MDRsN1RSbXQwMUJHdnl0OG1RRFlZVnFtWXRVYnFpZGR6R1RCcUxOZzgxNXBV?=
 =?utf-8?B?RUhYUzZpVmNKVzlXVUIzNkhaS1owUWNxZ1p1RHMzVTFVSVJmOXlDVGI1NDBE?=
 =?utf-8?B?VlMzeHc1QVNwL3ZmazBLTDRzdS93YWViVmR1ajlKdGRINllMZ2xKN21TYmxC?=
 =?utf-8?B?Q2ZmdmllcTRTcVNvTVZJM3g2RGluZ1V4b2ZFZ3BjWnczYWxPbitJRXJ3bS96?=
 =?utf-8?B?WStwYTkyL2tFN1RZeHY5bmVHMlFDeCtOTWxIYlhlZ0grUXhIM3ZqUmtnQlB1?=
 =?utf-8?B?SEp6dElNUHYwMTdxTDJCN0hTakNnTlN4UW55RGRtZGM2a2NpZEljZFpocmhB?=
 =?utf-8?B?WFQ0dWdkdlNyUGJwQXlna0tZSm5KenlNdTFwUFFxZXJ4M0V5VzJiMVVlQzNy?=
 =?utf-8?B?dkZseGxueUxORGpoWThDc29jMllPZSt3T2NvQ1lHZTlqc0RrTjJqdy9ZRERI?=
 =?utf-8?B?enJvSldRR0JoVGtHYnJvZ1BNOHNDZ256c0U0SUxBTVBoNlFFUVIxTkRHRktS?=
 =?utf-8?B?WTZPaXlER1NLaGF1dEdFbFhmK3Y4VkxIaE5iZ2IxekZ5bVpSNmlDaEEzZ3pL?=
 =?utf-8?B?Z1podWNjNXg0N0IwcVJzaThmODhCZUJlL2RpcnFYeEVPK01yK3BGa1BsQVJ4?=
 =?utf-8?B?UGsxY00zUlJwVWM2U1ArcTBvT3AreFBETmtUQmZ1T2dXaDRnVFhZVjJZNXJ4?=
 =?utf-8?B?d01ROTJXYlBCVk1aNDFhOTdRSTRiTEVDbXV0R1RHUGpjUjlWbDB4TFRHRk1W?=
 =?utf-8?B?R2JXRG1iMWVUL3JqOFh4QlJhbERPRDcrNFFycWhBTWpqZjZoNEVqUFRrdG9y?=
 =?utf-8?B?dGE0QTU0YnM2N3hvTXZjbDR0YjJ0b0I3aTUwUlpXTTRkSFJhT2xueHJ4b3Rp?=
 =?utf-8?B?SVAvWGdmeDRxdmFhVkVqWmdva3BqcC95OEwyYjZrSnVvNFJCd2NFNjFyN2p5?=
 =?utf-8?B?OHZaVkwrNFJuVmQ0SnhvejVIc2JQMFVRQkpaTUtWTVEyYlNtWmh6Qm8yNUdn?=
 =?utf-8?B?REhaMWpkTmZOYjMwbmh4bTd2T2dGaTdvdDFUREo5NS9GVGpUR1Zzb0VLanVz?=
 =?utf-8?B?ZDJsbk9EczBUVnJGL0hMR2pjdjdNLzRJTlNPbVBsQkR1WmdFNEh3YWo5anpG?=
 =?utf-8?B?b1cxY0lZVG8rdXZSMllaanA3QkJ5VEZXL2FmMXZTR280WUw2SUZxYnRadlNL?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C2E65AE08B1A348B0AEBB19199DA5D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pwo3edIbOIl3DnK9Sf84VJz9ywa6EwF9AwucCexNSq7Lq8HR5xXUovKl8l4T35yteRvgpMAm/boC1CHOBC5eDxdOmul2Myn0CiaC/kH0Ff9aDw4ZNi53g7aIZM8m5fcz0rHqFGsvgo9VdMtbj7lvYRAcwXOH7A2M6kv0bTUh7wLAGP1OCLd57l10LnbxVgvcgQo08kvBTjjz96Co23iLbJI9dEBx0emhCx33GAXjE+1b8zkKC55E2UYrBpMRqov9exN80O7X8J5epcUL8lQyyHByV95E5P/+E8qpKF7g36fEoxeFRF/xM42XDFhYOq2PREe02iEuy71M/000sIEeMXf6R5T+Eih1WMlJtAatLoEIqYpV/dfS1rPnnrqrEpPi1KietWwxWdLyEEb+QuJgvOj0tAeVu4WRYGB2n7KtESAtbBjS6cHeEqKhuevUoOmvewh6bM53XulfQQuJ67OJ02Fw7EvRISB5YvZ6ZO7EqkTGIcP9LGpqfIjj4eCFB8gjWG9Vhl56U7l3pqNg1tG7drNwup4pTdMjChEKAMEuwOK6L6cUJqruB3VlEzfRn7nDLmpzRZcXQzziZrFUOzbxYD45qyRznPhr3ZwKU/V5rUpDzovlEbHc/TTGDRIrRalZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab09588-d524-4b29-46e9-08dbfbbd2e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 09:23:34.9144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PExG2NKk4ecOQVjK3q0buOYHKwiUqnTxYNlf1A9ybKN83EqCQ1/c7H52EfpF/r5rVLY5/yjxJCw864XSdB1/92cDDV5ziIlKCUA2rKAxJUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8693

T24gMTMuMTIuMjMgMTA6MTcsIGhjaEBpbmZyYWRlYWQub3JnIHdyb3RlOg0KPiBPbiBXZWQsIERl
YyAxMywgMjAyMyBhdCAwOTowOTo0N0FNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+Pj4gSSB0aGluayByYWlkIHN0cmlwZSB0cmVlIGhhbmRsaW5nIGFsc28gcmVhbGx5IHNob3Vs
ZCBtb3ZlIG91dCBvZg0KPj4+IHNldF9pb19zdHJpcGUuICBCZWxvdyBpcyB0aGUgbGF0ZXN0IEkg
aGF2ZSwgYWx0aG91Z2ggaXQgcHJvYmFibHkgd29uJ3QNCj4+PiBhcHBseSB0byB5b3VyIHRyZWU6
DQo+Pj4NCj4+DQo+PiBUaGF0IHdvdWxkIHdvcmsgYXMgd2VsbCBhbmQgcmVwbGFjZSBwYXRjaCAx
IHRoZW4uIExldCBtZSB0aGluayBhYm91dCBpdC4NCj4gDQo+IEkgYWN0dWFsbHkgcmVhbGx5IGxp
a2Ugc3BsaXR0aW5nIHRoYXQgY2hlY2sgaW50byBhIGhlbHBlciBmb3INCj4gZG9jdW1lbnRhdGlv
biBwdXJwb3Nlcy4gIEJ0dywgdGhpcyBteSBmdWxsIHRyZWUgdGhhdCB0aGUgcGF0Y2ggaXMgZnJv
bQ0KPiBpbiBjYXNlIGl0IGlzIHVzZWZ1bDoNCj4gDQo+IGh0dHA6Ly9naXQuaW5mcmFkZWFkLm9y
Zy91c2Vycy9oY2gvbWlzYy5naXQvc2hvcnRsb2cvcmVmcy9oZWFkcy9yYWlkLXN0cmlwZS10cmVl
LWNsZWFudXBzDQo+IA0KDQpDb29sIHRoYW5rcywgSSdsbCBoYXZlIGEgbG9vayA6KQ0K


Return-Path: <linux-btrfs+bounces-697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0EB8068EC
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 08:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85059282384
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 07:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D1018635;
	Wed,  6 Dec 2023 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r0n7PWOG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ULcZJegL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0B1D68;
	Tue,  5 Dec 2023 23:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701848892; x=1733384892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dZA+AEqS6FA2jyh4+JaJqsWtulYyuJVLfc8fmJIuO4Y=;
  b=r0n7PWOGbzjebUh+HMHxL4Sn1enXbBCrVyPOicJ5V5RcE2yfijaoodxm
   Y9D5FRKC1S2Jkj4xgbp6oeV9umT8w/gTbrrD+n/1RYxekg5OCYZxYDi0i
   Omn4Leu8sZDw6hGGDHzX00x8LyrQSG0LerGCrzrBEUp2GtLMHvmeFFnDC
   iYewIKB3+zUjZkgFyFL5zHwOBqpVpVPqTqCzTkZKiV6LLAs+KspgvdTmZ
   8v8eQAWONOKFBiHU/dKlNUgzMXTfax0IY0S0P7RiAQNvlkTwodx06o1D1
   zGuZzC9PQlStj7p6ExNX0bbWhaIFw0yZWjEaLeRRYQbugJnBiNFjQDrK5
   A==;
X-CSE-ConnectionGUID: LIhaDd+MQAGAfcT0rLH20w==
X-CSE-MsgGUID: czj7BLoaQ7ST15j7Na5kCA==
X-IronPort-AV: E=Sophos;i="6.04,254,1695657600"; 
   d="scan'208";a="4288344"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 15:48:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7HHaHZHvhMHlBa6BkBuA857Eqn81dPWeWOk6z+814NMnBqQt7MYcL/0g+PxEx8Ek4qsmqhipa+J2ajqqokBz6B2eCxyrfWoG494YcxOzRhYmPZTyzHs/5hTD4Mn6f8B0D6VhwpssLv3B+2UUl2kvI7dUW3qU3FKRto2HbejIgDXNX6yKh3M9jibicwl1UDjLARjdGG3q075FI38Qe5lfMtM3ioOI55lCb8Gtc0EVdfZMt/hTvCirR3wmzQv2WgCr30SOYi3FO/akKpXQSLB6PM5sduTzkmI+0o6UQAJk/HTcXuLxGCQIco//+U4sEdZm9ihq/oyqnr+p1oxqk97MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZA+AEqS6FA2jyh4+JaJqsWtulYyuJVLfc8fmJIuO4Y=;
 b=dqr/t0zp7zcCBrbZJ0KtaYBiQdT2tzRsTMnKKAQn0Eb+I329LO2xoHTUxezmXS58LYx7Tq+ENGC04I6lbej7vLTExqsFQToGegd1C3rOsL050ggj5bgqCKTMlpALrf5nlDnVYAI+Brym305bbajC+hQs21lh0OWz0A5ZrBCmsL07R0QPrHmxFEXW+uW4Eby9KqG58krdcIKdOHXcGzhsH2Oo+nDdkNALcByLpN1FlAQsh8LkTENicahOXzJRM0/mQwu6EYxXH/xhtM5B4rxPs8YrhwG9Agp0oPwxy0nvTTX9CzfmOB6naW0zj298LbK1el+VDJAZY1j3pLeVflspsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZA+AEqS6FA2jyh4+JaJqsWtulYyuJVLfc8fmJIuO4Y=;
 b=ULcZJegLy07V3OGaoU9nNGZ5IvZnabDy2PnzMCyq8mfowMggCnMoQuenW13+iYpu1hImHfTsk5Pfjv168CWhDLCCnoATxrdn5M5BmiypKTpsJbLqRTO1Gwx+CMQr+oNU9SjO0bdZcC6yosnU+F4bXBX41WiMjkLuuLzAfwjhgq0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 07:48:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 07:48:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>, Filipe
 Manana <fdmanana@suse.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] fstests: add tests for btrfs' raid-stripe-tree
 feature
Thread-Topic: [PATCH v3 0/7] fstests: add tests for btrfs' raid-stripe-tree
 feature
Thread-Index: AQHaJ6MRoqbLzfdj9EK7iflv0hf7jrCbGTIAgADIogA=
Date: Wed, 6 Dec 2023 07:48:09 +0000
Message-ID: <6c8af644-8a73-46b4-81fa-932da87b54be@wdc.com>
References: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
 <CAL3q7H56L7+m6-SX6oqoaDu89u-QNVR-0F=G3bSt+g4S-uSBPg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H56L7+m6-SX6oqoaDu89u-QNVR-0F=G3bSt+g4S-uSBPg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8755:EE_
x-ms-office365-filtering-correlation-id: e5612025-606e-4ce4-8b1c-08dbf62fb0cb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sGDBTSEFLAZW7o5xfCYrDV6VeY1p+AYuCszo7vOmBT1qVd5d+N5eVru0VhYzQVV1n9xVcQh916rjHiO7ZXSVHzOqe69wKRJaym8tNZy9feXt5I6aYFEfb4GVMdII2nqcuj7r6f7FMkdn5REfntmsMWQtLuqzjZJ9+LQpv9XzDU9URvTj17l2NgkyzOKsFVNzox7i1NzIIod7dUYxnxYkqrWPuet6QyFaifcYcSy95kgGCHWmlvGckIf2W5/CrUyJw6Sn4lPpu7OgU2ve/Kl710ram0ikO/VJxXJ9kqayeR5PKVXasY5FtIGLspmVu+2pwiNYJUD3NE7N9w0TggUIQSexobbPmrgElmjnBMY2k17ODlazbPKW0605VlDciXef9Q9sl0wLnI+bojsgRGq/3kj4a4kOctZxy8bgNGGfar0fpZ6BCrfs+PtB6I4jF7/ndxiHgr0acBd2P84FyoMO8jNznO4isbRF+NaSq83U/Q7Qp6Bq/XiqW3BRx1kV4nBcwimTDHW6fHC1HTDBWjUMgXAdZ1TkX2EuGnIsfJZkCPNbe79cMMA5sh8QhZQxr6WYKsHaI/mTrJXTnYpOBPP+KoQUOGEVqbfpru1RhIQ4TyaNeeOz827hAyqp6vCjiG49AGt1oic1D+i5hAEw2cYnrXacWaQc5BrpPvnCnJThULNuHtXzzETtLuXQAllCQtxg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(38070700009)(31686004)(478600001)(6512007)(6506007)(2616005)(53546011)(8936002)(6486002)(64756008)(66446008)(66476007)(66556008)(54906003)(4326008)(66946007)(8676002)(76116006)(91956017)(71200400001)(83380400001)(316002)(38100700002)(36756003)(82960400001)(2906002)(5660300002)(86362001)(31696002)(41300700001)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDhKYkpzYlJlZ0FHc3NsT1NGK1ZvWmRhVU0wU1Z6N2FFblVhR21DSlJ6bEdK?=
 =?utf-8?B?dElZeGZCQ3MvUTRaSmdveGcrOVEwWDdxQUlXTWhHaVhhejNRL25oeFhZYnBq?=
 =?utf-8?B?azBKckpKTzNBUUxFYndXYzE3MVdsWmJVQjIzV2l2Z1dXRkZna0F0Y3A2a0dk?=
 =?utf-8?B?dXcwcjdkU0JTejZEa2ZCQTFtSGU1UVZlOUNndWNHQWJYOWtlWkQ5TmZvaE1F?=
 =?utf-8?B?ZmUwZEkxdzR0UmpSanEyOTZwOFRDWGhGblhzK3hrUTdTWko1YjE0ckFHOVNY?=
 =?utf-8?B?bUYva3BnclNvNmhwOWxMbUxKU3ZrNnNMOHVRRDVMVTAvOTVWTVpSbG1sMlgr?=
 =?utf-8?B?WUlqZGZ6L3RrK3crbHA3b1AxRjZuUUorRzcyWjZBbEJELy9wYi9ucERXNXZU?=
 =?utf-8?B?SlNkTUdDMjlmQmRQUXMwODZpKy8yUzZDUUhJVTRQVVNuR01CZUVOSnY3VkFu?=
 =?utf-8?B?RkVkQjBvS2hrUEE0YlF3eTk4K28wNnJWVWZkNGFWVXRLc0lteXkzYVNaZEo5?=
 =?utf-8?B?aC9JK2hJZFB4ZE83aWo3MVBzZ1NYaTZNczdyYUVUbnhITVZpT1o5dmZ4ODg2?=
 =?utf-8?B?MUtTU0xOVWxzUTBLbDBHWjBZR1NtS1hlakFieUQzWnMxUXpFZ3lDdENremRU?=
 =?utf-8?B?RHAyQkE1WEV5U2JXR0lDQ1JOZWVYKzBqenNuUmEyT3JqYjRsMkVHVEg3dHJq?=
 =?utf-8?B?cTdBR2lJZ3NJRzEwREVEOUZSM09iUG9odlVMc04xTm9rWXZZWnNESDd2MmZz?=
 =?utf-8?B?OFAveGxpVUxuUUR3clNwc25yRnlBQVBYY1BVL0dHeW9pVlVvZnlJc0RFcTl0?=
 =?utf-8?B?V3FhblAyMElPaGFDMy9NbEprMC9EYXdTYXZGRkFiUm9HUTR2cVFBeTd2b0xH?=
 =?utf-8?B?U1p2Q0hMVjNYU0ovNnkrM3ZQUVVSa0xxK2l2TVJKNmVQbG1UamUyL05Qcjc3?=
 =?utf-8?B?K3kvOGxuajlMS0pubXUrbXZRcVVmM0R6Z3dPaFRCblhGV01yVG5QSnFiTnBp?=
 =?utf-8?B?cTRhaGxLN002Z3hDOWh4Y1A4NGlWRnFwR1FPa1BrQU5tSm83MWdnUTVYRHdX?=
 =?utf-8?B?YjBxalNTc2M1cUtFUStKaVZ5aXNwTTlaWHhiNnUrbXJxUG14eUFvaFMxMXpF?=
 =?utf-8?B?blUwYWg1NWRpRTZnZjUycXlQSzYrRFJ5VGNrVGRMT2RQSHdLRUdzS3JiYm42?=
 =?utf-8?B?NGNqVmQwTlVlWklJc21xMkNmQnBpQ2FuVGR1VFFyNC9YTmdoemloTVlvSWNs?=
 =?utf-8?B?eHFIclFaSjJaamsxUjZkOFVaNEpmUFNldVBnNWU0aC9rOUIwWVUvRU83TE1W?=
 =?utf-8?B?dEt2UEdhOXJwZmRCaU1sbnMrN1QyZ2t2VGJQck5yZFhGMHhmRUwzS2Q3RjhO?=
 =?utf-8?B?STNoUXZoUTRXY1RsVDJrR2dhaFFsQkVsMXpnVVNwWHFQUkF3eXp5TFpQbGty?=
 =?utf-8?B?RDJoTE83MDFEd28ycjZ2SlArU2N4V2VIb3N3ajYreng5RGtpMGVlbHB0L1lp?=
 =?utf-8?B?NWxtdXU5Vm9zalM5QjRVcFZWWnErR0pjOXBHUjBvUnpDM1ZTMzl5REk2NUFv?=
 =?utf-8?B?UTU0bU1jN091RUVrUllscmZjRkh4YnQ5OXY1ZGpNNCszd3ZvUHlvNnV2czNv?=
 =?utf-8?B?Y2huQUhYcnR2b1FJODRKZjVJQmtnMVlpZGx6dldVUzU3SjgvWDROd3lhejB1?=
 =?utf-8?B?dlhnLzkzelorUVdrcm9CVEU3T1pDYnFRc2lOR3k4azZVQjd2aEV1YXl0cC9q?=
 =?utf-8?B?TCtaMFFBNUt4ZVkxQ2VQdWxtVVFoV25OUk5qM1lkRUc0OUNXTkRoYllrUWQx?=
 =?utf-8?B?UlBTKzNNQ1BTaXh6VHRVWWJGQjFzRk1tS1RtTzMyc3g0dUwzTWdHUUVEQjRW?=
 =?utf-8?B?cmdhNVBxbHIrdFVjSlNYdmNzYmpvUHgwN3lZS1M1eG9FbFY1elhRTzd1dktJ?=
 =?utf-8?B?S1JaM0F0UDUvK08xMTZUNGVsbHZRdlltZnBGWXFjY0RObnRtMURPUFVKeDVC?=
 =?utf-8?B?eTd2TVJ3WVVLUWRONUJlYzQwakJGMm1oUmM5MEZQWFc1Sm5ibjhNMHVQMWox?=
 =?utf-8?B?YjVEMGR0dXVPNy9ON3NrbEtkYmRMbXR4NzdXZDF2TTBHUFBHamFnZlZINXFi?=
 =?utf-8?B?NG1Tc0tTMGYvYm44a1VuNXRsTkkwOGdpbXBJckVoYVdCQ1RiTklWUWJSbE1N?=
 =?utf-8?B?TkVDKzhVb2x2NGJicE1qeEJhZG1HMVBGZjJrN0tiMVo4czFwdTB2V3crL0Jq?=
 =?utf-8?B?VlBQSXRLOTFuYXBBb2JuaFE2SFdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1903CC2FC8EE7747ADBF9C1DD035DDA6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8vXEKN9pstTdaTD37sZ6N6iC7FP4UfihRBLFU0z6ENk8srwxoUrNdXFuR4cPT81G5xHnSFkVhaBOyv/taRCIw+SwKU3UKgfxqPKScIp1DB3qjWwNGY0/o6ZL4dhI2VOYBN3PXcihuN2s5OaFwnDObQS1tmtoBUPG1mX6IZosSroaRAfqqtxhhfosTaAzIZYwMKzSrScuWSgudjxuowhOn9MEbChomKc+5TTJsowgBEt4HkGY8/3RRPGz7eI6iv905fui27hi1dQ3rgf0ueJhmLI840WMs+nSud+ez3lYjNudW6kiD13NzELBz7o5H/6SY6+wjfhRiMZYeBRkcsmhkO+HGrXRPDN4PS1Rf0excbrxgW3GCx4sIlEfUDqJnGdPaVEaQD2S6rvccNoB49Z6wi5gHemEqcrRjCoGR3HUmnYM77Yr6qBLls18DS7AUROfZikwciTqU+NPWAzqwMRqUOuzGzttZCaWVYzYhs6J2g9/RYabiSn6j9DbAq/wNn91IalIUP2HlCtHioFxsV3C2XulXdWx/8JikHvlgWfWeZX0Bi90sXpn91dbOkNJD6nnc4qE9tYJh09zOibw45tZnCU1UA7l6T/SlJ86JaiZurPkQ0XdbWtR0SlkUBXu1qfPrtPiNjIov+0Dxwew8jMeCHPAzIs6EOauPaR9roK9bjcCFXfWHIAC+bnNA4zY6Scc63TK9seXIuEOBADKVAOsRzbytFfEZ9vUD+HD08GQiqWvlEjsZL7affTFKkO9qh+JR/1MG9P8xk2MRvvSgdkHbb46KC9jwr9DPt1DbohmyDw9qJU3KzkPxrIkTf3I3c3LqXkR/kmxwEbR3u5262F5ljh8M4oRSHYtP/WUXdwZ9Bkx14qwDW282qIrSFRnIzuoJSa58ujGyUf9cgkYwu47ug==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5612025-606e-4ce4-8b1c-08dbf62fb0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 07:48:09.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fx/S1un8ovi5XbZky7NpdMcx7Ho6iNtRyffxNw/8Sl6Sn8KzdJL1X+A8G+jumNK/eKiAAIQ6jqCpKwlhPaOmwSVoyicOeu1Vp+FQUvVYVUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8755

T24gMDUuMTIuMjMgMjA6NTAsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IA0KPiBKdXN0IG9uZSBt
b3JlIHRoaW5nLCBhbmQgc29ycnkgSSBkaWRuJ3Qgbm90aWNlIGJlZm9yZS4gQWxsIHRoZSB0ZXN0
cyBmYWlsDQo+IHdoZW4gcnVubmluZyB3aXRoIGNvbXByZXNzaW9uIGVuYWJsZWQsIGZvciBleGFt
cGxlOg0KDQpXZWxsIHllYWggdGhpcyBpcyBraW5kIG9mIG9idmlvdXMgd2h5IGl0IGhhcHBlbnMg
KG5vdyB0aGF0IEkgc2VlIGl0KS4gDQpJJ2xsIHNraXAgdGhlIHRlc3RzIGluIGNhc2Ugb2YgZW5h
YmxlZCBjb21wcmVzc2lvbi4NCg0KPiBBbHNvLCB0aGV5IGFsbCBmYWlsIHdoZW4gdGhlIGZyZWUg
c3BhY2UgdHJlZSBpcyBkaXNhYmxlZCwgbGlrZSB0aGlzOg0KPiANCj4gcm9vdCAxOTo0NTozMCAv
aG9tZS9mZG1hbmFuYS9naXQvaHViL3hmc3Rlc3RzID4gTUtGU19PUFRJT05TPSItTw0KPiBeZnJl
ZS1zcGFjZS10cmVlIiAuL2NoZWNrIGJ0cmZzLzMwNA0KPiBGU1RZUCAgICAgICAgIC0tIGJ0cmZz
DQo+IFBMQVRGT1JNICAgICAgLS0gTGludXgveDg2XzY0IGRlYmlhbjAgNi43LjAtcmMzLWJ0cmZz
LW5leHQtMTQzKyAjMSBTTVANCj4gUFJFRU1QVF9EWU5BTUlDIE1vbiBEZWMgIDQgMTE6MDE6Mzcg
V0VUIDIwMjMNCj4gTUtGU19PUFRJT05TICAtLSAtTyBeZnJlZS1zcGFjZS10cmVlIC9kZXYvc2Ri
DQo+IE1PVU5UX09QVElPTlMgLS0gL2Rldi9zZGIgL2hvbWUvZmRtYW5hbmEvYnRyZnMtdGVzdHMv
c2NyYXRjaF8xDQo+IA0KPiBidHJmcy8zMDQgMXMgLi4uIC0gb3V0cHV0IG1pc21hdGNoIChzZWUN
Cj4gL2hvbWUvZmRtYW5hbmEvZ2l0L2h1Yi94ZnN0ZXN0cy9yZXN1bHRzLy9idHJmcy8zMDQub3V0
LmJhZCkNCj4gICAgICAtLS0gdGVzdHMvYnRyZnMvMzA0Lm91dCAyMDIzLTEyLTA1IDE5OjM0OjAx
LjA0MDQxMTc0NiArMDAwMA0KPiAgICAgICsrKyAvaG9tZS9mZG1hbmFuYS9naXQvaHViL3hmc3Rl
c3RzL3Jlc3VsdHMvL2J0cmZzLzMwNC5vdXQuYmFkDQo+IDIwMjMtMTItMDUgMTk6NDU6MzYuMjQy
NjIxNDE5ICswMDAwDQo+ICAgICAgQEAgLTE1LDYgKzE1LDE1NiBAQA0KPiAgICAgICAgaXRlbSAw
IGtleSAoWFhYWFhYIFJBSURfU1RSSVBFIDQwOTYpIGl0ZW1vZmYgWFhYWFggaXRlbXNpemUgMjQN
Cj4gICAgICAgIGVuY29kaW5nOiBSQUlEMA0KPiAgICAgICAgc3RyaXBlIDAgZGV2aWQgMSBwaHlz
aWNhbCBYWFhYWFhYWFgNCj4gICAgICArIGl0ZW0gMSBrZXkgKFhYWFhYWCBSQUlEX1NUUklQRSA2
NTUzNikgaXRlbW9mZiBYWFhYWCBpdGVtc2l6ZSAyNA0KPiAgICAgICsgZW5jb2Rpbmc6IFJBSUQw
DQo+ICAgICAgKyBzdHJpcGUgMCBkZXZpZCAxIHBoeXNpY2FsIFhYWFhYWFhYWA0KPiAgICAgICsg
aXRlbSAyIGtleSAoWFhYWFhYIFJBSURfU1RSSVBFIDY1NTM2KSBpdGVtb2ZmIFhYWFhYIGl0ZW1z
aXplIDI0DQo+ICAgICAgLi4uDQo+ICAgICAgKFJ1biAnZGlmZiAtdSAvaG9tZS9mZG1hbmFuYS9n
aXQvaHViL3hmc3Rlc3RzL3Rlc3RzL2J0cmZzLzMwNC5vdXQNCj4gL2hvbWUvZmRtYW5hbmEvZ2l0
L2h1Yi94ZnN0ZXN0cy9yZXN1bHRzLy9idHJmcy8zMDQub3V0LmJhZCcgIHRvIHNlZQ0KPiB0aGUg
ZW50aXJlIGRpZmYpDQo+IFJhbjogYnRyZnMvMzA0DQo+IEZhaWx1cmVzOiBidHJmcy8zMDQNCj4g
RmFpbGVkIDEgb2YgMSB0ZXN0cw0KDQpPSyBJJ2xsIGludmVzdGlnYXRlIHdoeSB0aGlzIGhhcHBl
bnMuDQoNCj4gDQo+IEFuZCB3aXRoIG5vZGF0YWNvdywgb25seSBvbmUgb2YgdGhlbSBmYWlsczoN
Cj4gDQo+IHJvb3QgMTk6NDY6MTYgL2hvbWUvZmRtYW5hbmEvZ2l0L2h1Yi94ZnN0ZXN0cyA+IE1P
VU5UX09QVElPTlM9Ii1vDQo+IG5vZGF0YWNvdyIgLi9jaGVjayBidHJmcy8zMDQgYnRyZnMvMzA1
IGJ0cmZzLzMwNiBidHJmcy8zMDcgYnRyZnMvMzA4DQo+IEZTVFlQICAgICAgICAgLS0gYnRyZnMN
Cj4gUExBVEZPUk0gICAgICAtLSBMaW51eC94ODZfNjQgZGViaWFuMCA2LjcuMC1yYzMtYnRyZnMt
bmV4dC0xNDMrICMxIFNNUA0KPiBQUkVFTVBUX0RZTkFNSUMgTW9uIERlYyAgNCAxMTowMTozNyBX
RVQgMjAyMw0KPiBNS0ZTX09QVElPTlMgIC0tIC9kZXYvc2RiDQo+IE1PVU5UX09QVElPTlMgLS0g
LW8gbm9kYXRhY293IC9kZXYvc2RiIC9ob21lL2ZkbWFuYW5hL2J0cmZzLXRlc3RzL3NjcmF0Y2hf
MQ0KPiANCj4gYnRyZnMvMzA0IDFzIC4uLiAgMXMNCj4gYnRyZnMvMzA1IDFzIC4uLiAgMXMNCj4g
YnRyZnMvMzA2IDFzIC4uLiAgMXMNCj4gYnRyZnMvMzA3IDFzIC4uLiAgMXMNCj4gYnRyZnMvMzA4
IDBzIC4uLiAtIG91dHB1dCBtaXNtYXRjaCAoc2VlDQo+IC9ob21lL2ZkbWFuYW5hL2dpdC9odWIv
eGZzdGVzdHMvcmVzdWx0cy8vYnRyZnMvMzA4Lm91dC5iYWQpDQo+ICAgICAgLS0tIHRlc3RzL2J0
cmZzLzMwOC5vdXQgMjAyMy0xMi0wNSAxOTozNzozOC4zNzkzNTUwODkgKzAwMDANCj4gICAgICAr
KysgL2hvbWUvZmRtYW5hbmEvZ2l0L2h1Yi94ZnN0ZXN0cy9yZXN1bHRzLy9idHJmcy8zMDgub3V0
LmJhZA0KPiAyMDIzLTEyLTA1IDE5OjQ2OjMzLjcxNjQ1NzU0MCArMDAwMA0KPiAgICAgIEBAIC0y
OCw5ICsyOCw2IEBADQo+ICAgICAgICBpdGVtIDMga2V5IChYWFhYWFggUkFJRF9TVFJJUEUgMzI3
NjgpIGl0ZW1vZmYgWFhYWFggaXRlbXNpemUgMjQNCj4gICAgICAgIGVuY29kaW5nOiBSQUlEMA0K
PiAgICAgICAgc3RyaXBlIDAgZGV2aWQgMSBwaHlzaWNhbCBYWFhYWFhYWFgNCj4gICAgICAtIGl0
ZW0gNCBrZXkgKFhYWFhYWCBSQUlEX1NUUklQRSA4MTkyKSBpdGVtb2ZmIFhYWFhYIGl0ZW1zaXpl
IDI0DQo+ICAgICAgLSBlbmNvZGluZzogUkFJRDANCj4gICAgICAtIHN0cmlwZSAwIGRldmlkIDEg
cGh5c2ljYWwgWFhYWFhYWFhYDQo+ICAgICAgIHRvdGFsIGJ5dGVzIFhYWFhYWFhYDQo+ICAgICAg
Li4uDQo+ICAgICAgKFJ1biAnZGlmZiAtdSAvaG9tZS9mZG1hbmFuYS9naXQvaHViL3hmc3Rlc3Rz
L3Rlc3RzL2J0cmZzLzMwOC5vdXQNCj4gL2hvbWUvZmRtYW5hbmEvZ2l0L2h1Yi94ZnN0ZXN0cy9y
ZXN1bHRzLy9idHJmcy8zMDgub3V0LmJhZCcgIHRvIHNlZQ0KPiB0aGUgZW50aXJlIGRpZmYpDQo+
IFJhbjogYnRyZnMvMzA0IGJ0cmZzLzMwNSBidHJmcy8zMDYgYnRyZnMvMzA3IGJ0cmZzLzMwOA0K
PiBGYWlsdXJlczogYnRyZnMvMzA4DQo+IEZhaWxlZCAxIG9mIDUgdGVzdHMNCj4gDQo+IEZvciB0
aGUgY29tcHJlc3Npb24sIHdlIGNhbiBqdXN0IGFkZCBhICJfcmVxdWlyZV9ub19jb21wcmVzcyIu
DQo+IFdlIHNob3VsZCBhbHNvIHNraXAgdGhlbSB3aGVuIGZyZWUgc3BhY2UgdHJlZSBpcyBub3Qg
ZW5hYmxlZCBvcg0KPiBub2RhdGFjb3cgaXMgZW5hYmxlZCBmb3IgMzA4IChkb24ndCByZWNhbGwg
aWYgd2UgYWxyZWFkeSBoYXZlIGhlbHBlcnMNCj4gZm9yIHRoYXQpLg0KPiANCj4gT3RoZXIgdGhh
biB0aGF0LCBldmVyeXRoaW5nIGxvb2tzIGdvb2QgdG8gbWUuDQoNCkknbSBhY3R1YWxseSB0aGlu
a2luZyBvZiBtYWtpbmcgUlNUIGFuZCBub2RhdGFjb3cgbXV0dWFsbHkgZXhjbHVzaXZlLCBhcyAN
Cm5vZGF0YWNvdyByZS1pbnRyb2R1Y2VzIGEgcmlzayBmb3IgYSBSQUlEIHdyaXRlIGhvbGUuDQoN
Cg==


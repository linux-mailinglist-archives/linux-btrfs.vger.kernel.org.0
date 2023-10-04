Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EDD7B7F85
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 14:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbjJDMoF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 08:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjJDMoE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 08:44:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFECA1;
        Wed,  4 Oct 2023 05:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696423441; x=1727959441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HMdRosEUYmf/lAjKHdfUTzgkE/lK8pJDKflnPdBwtiM=;
  b=i3KBYNc7w+57pi8vMcyuXg228gr4OnfQLSIbui1Eh/47s1hK8klNn9Qu
   qTXxRXRvuvarlxvUOr9pm3saLGHooQeGYrt93rLY7y1MY20Wj/8scYPwV
   yS/jXX0inRTJyHxqvkSblOLprFMH9s0gZk7p1Hv3uBfHa3vYoFCJW/mjR
   EJjNu0EweEw55Fe1HWegF358nuq3WXQ49VoO5LsausMj+bGr5taz162n1
   vc+M78Ctps5UB59WN0Ju+I6+KB5mexMJDOUxvylHG4sIbLET5AIf97Zaz
   CEZx8YFqxU15QbLIrWuL4a9JNs+avDYwZw3+OMlmVeaw/m7hJKVlrVtDG
   Q==;
X-CSE-ConnectionGUID: zks1ns3dQYay+bPaQgn5eQ==
X-CSE-MsgGUID: ZMsNYwYcSVCsEi7sHV72sw==
X-IronPort-AV: E=Sophos;i="6.03,200,1694707200"; 
   d="scan'208";a="243823053"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 20:44:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOjkrYPmM4OnltU1u3KCRgl3VqTfQZmUY428E9fJgxuI3c1Em9rbH5yVoCfQD/ooWPkuEsEdCQOPYl904crokzBaqHlgFsCGZUiLkxyXXtz0XVRV8AttiGQ0NUcOuePOOg/+/OsOcrva3PCfGTHsprj7jxuKIQuqPOOZCtEOtmi4m5c4ADwO8TYe3rcWAjgr6Xv/AOrhvmjWkgBCKBcfoaE8JRqKekjyIWU/xSSHBdVnUHu4JKg9pA9HWGVQWwAWuOgh7stQzLdQ0zmMJZDEgVqPWudcYzysiv9t9Ll2tyRtDVPJUhlAkpKqKUo1XAXjCA3KTkNTFmHVUTkQ3kvFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMdRosEUYmf/lAjKHdfUTzgkE/lK8pJDKflnPdBwtiM=;
 b=U8ZSTep9C/jhBItn9uZMZSd8g6FSJM0cu8crZuX1MvaTk+aPQgXyMISPv3aBtAWfLvQnWieynrkkjCXFfjalT2ApyvoEE2H9i4KnD/NFs/1fOmxcLW2vW7+bn5rzS80X1GheF6829W+T4uvXwWrYWiZaqRqwNhmB0CFgFf364ZlHWvPIlHK7NbqhTD7UYpDFTAGLff9ymiHTvIVIdImaUOYhCDtssRaJeQNWy1pwdbH365JbjGYv58Wq/o0Lm7PPd9T9/3qByB4/7L4niFNrQB3TMYs1lQmYQtYYpqiVXyMBfce3DQdghAoywf61UHlLZcBciu4s//ln8007cZ8wew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMdRosEUYmf/lAjKHdfUTzgkE/lK8pJDKflnPdBwtiM=;
 b=lZMBuxZwDpfyQRYKtp5lcMqj1bCrLq252JwXYjyyTNine367+xzLSfrejD/9lU/Zs/nKfswq4Nu/tkXtW8Wd+UYTasnCMEJhgXGx3dcWMUmXhFh1Og6c67N9i6LAouFwhp2dAxmYgpqK7icc/2pR/yOcjMTS1ZCHi3ujuWYWBsI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8508.namprd04.prod.outlook.com (2603:10b6:510:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.39; Wed, 4 Oct
 2023 12:43:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6863.019; Wed, 4 Oct 2023
 12:43:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] btrfs: remove stride length check on read
Thread-Topic: [PATCH v3 2/4] btrfs: remove stride length check on read
Thread-Index: AQHZ9phJjnJr9a/+GU+prnyPM7sjM7A5k7CA
Date:   Wed, 4 Oct 2023 12:43:57 +0000
Message-ID: <160aa2ca-7a6f-4c5f-aaf8-197afef8f863@wdc.com>
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
 <20231004-rst-updates-v3-2-7729c4474ade@wdc.com>
In-Reply-To: <20231004-rst-updates-v3-2-7729c4474ade@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8508:EE_
x-ms-office365-filtering-correlation-id: 8e91573b-d374-4d3c-4e93-08dbc4d793cd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nacnr5BeDJZWKy4Ym4cElEYOZex1ZGvGeai7Rory/sg+oFkteLRT0iIfTfhXyn49MVYP0kc4YWPtHXmGpB9TQfZJVTcXVrGyIs5SKlW1oeROZk97FdDJMg7scZ34tvNsMfDy9OpIOtsW3xA+q6F0HNhGa9FN8KxygrOgYITggARArOSMQlNcLhO6zspikZ8A62A8NTfjxDyZCzcL9PXXsVQ/kbVgu98RO108EFqAR1VPL+ufcNb41r/mlGqxosrJnN4YA73nl8HdUdieXgRP3uQ50yXGGdMq8BDDDArgULk8R5A6Q/XNAsAEvmb19B8rmnfeoa1zx3iheVochSZUf4TsyKcn4fK3GJCKdhGDouX7Enlw8mLFCHdwz08MWOxIAVWJ30fDz7K5XmQqM1QpOo6Lq9fSKIgmGvrIsNZARnPwczyrPEGCtttRCRlL7B40YSh6NuJtpz/VAbXO2tq18i5wrpN75YGMDpHsWxzE80gOZD2N5bdn7TIDpcFZay+mUbTEo/vpQRUN5VunheeJeaZ/bs05Vws3JHu4ZJdAEigmweFZu+V/k2V+SSGak8yRG0WkfdjXHjdEYz1nHoxQLgGyiOvhJr3Qm/pA8qwui5HHRajzHZSyoVhdvRQBDLRxxA1HUh8IbYKxerRh51ncSgQNlE4pyULsRB0MDkiHB2IoSToakHUg1AlyjQxzkqPF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(478600001)(6486002)(6506007)(71200400001)(38100700002)(558084003)(86362001)(122000001)(38070700005)(82960400001)(31696002)(2906002)(316002)(5660300002)(8936002)(2616005)(26005)(66946007)(6512007)(41300700001)(54906003)(8676002)(36756003)(76116006)(66556008)(4326008)(110136005)(64756008)(66446008)(91956017)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHM5enBNY1hYdUJkNmJveG52bExNeHhDK281SHRvMXAzRHJuMUN1Vi8xSk03?=
 =?utf-8?B?THdFODJFTUY0R3c5QmV2RHUreC9JbFpZYjZBL1ZoM2ZwMVFabW9VbVdZWEM0?=
 =?utf-8?B?Q2FwYkZ3cnNxOXIxWnVsQ0hSRW1mU1NQUk9OSWRqZXVKdnYxaFFvVmZSdGhl?=
 =?utf-8?B?aUhsQnlpZjlPUFhoL0Jhdkx4MlNlWkxmTURldXB2bHBrMnNxTUV6b3NMQ28y?=
 =?utf-8?B?ak85MWVuZkFCNTlYajJ1TGMvUUdZS1h4d1dSaVNBZnlIT0pOQTlFblVVUXZ0?=
 =?utf-8?B?aXZGRTZSTXJqS2p2cjczeEdybXBRVHFmaW53cGhSTTJLRDZYcEtBM2IwRUd5?=
 =?utf-8?B?cWl4UnJNMEVxZmxwMUNKc201K3FmaHlQSEt1cHdPSjZKN2ZOaDZwejk2dkUr?=
 =?utf-8?B?VFg2NjRoakcxZXJkWVZLb243cUlSQkVSbm10b2tMQ25OY3ZNa1IzTHpCOTN0?=
 =?utf-8?B?WWxQaUQrdnF5QWp4L1RKTzJrRGlHTVpZVmRtTTV5WVZycEF2ekxzd0JocWU0?=
 =?utf-8?B?RVhHcjNDUUhZS0VROHJYNlVNWHNZZnltVDVuMTdCUGhGcEU5c2F3R1lMRWVl?=
 =?utf-8?B?RkR4RzJGcmpDVjhha0w5Vko5TmhrZEpmV1EweUloSmxZMGlURTRMeDFUOE93?=
 =?utf-8?B?bHBnTnZZU25nSkxWMkhZYzVuSlNnVjBmbmFuWnBJMUtMV3BkZWRHdWsya2tN?=
 =?utf-8?B?VzRsazFqbmU0aTkwY0Jsa3FRMG1wbjNqTlJ5OVJiNURkbHhRcUtoRGgyb3Uw?=
 =?utf-8?B?VDZhVkNCa1B1eVdVeDZXSVVsVTVtV3hZZUxyZ1IvdTR4TERmQmVjVlZRc1Rq?=
 =?utf-8?B?dFFMbEpVZEllRHpCeXB6K1hPaW8vRUlOVTNLdHdxU2V4MkVZS1oveE5MS3ZW?=
 =?utf-8?B?bTZSWXl2OHNpL2Z5Y0xVRHlEclZVcmY5R2MwMFVNSnZzU2dyOTdrWDdJZnBk?=
 =?utf-8?B?Ymg2YnRSRjdtR1ZIaHhIUk44bmhEYzVOMHJDT29QU2srMUhCTkRkdVR0WVJ6?=
 =?utf-8?B?NEltUlRmZTRZU0Y5dFdDSVlFZlZRVnk5d0I3c1d0cG04d0creUFadWtiNjNr?=
 =?utf-8?B?TU1QOXVPbUtZWmNCc0MrVmRwdFFOcUNFS2NFUW81YnVRR3pmNU54SlhqeFdO?=
 =?utf-8?B?ZFBZczE0ZGpNM3F0cjBvcWp0Nk9kWXBram5iZ2RkMUxJaEtOdmRlU2JDVUFz?=
 =?utf-8?B?WURWL0lwZm5LOTAzOS9uYkxiSU9maFVZemlIYlZKWUUzWU1OUUpWSHVWZUtK?=
 =?utf-8?B?ekxLbkpHNWt1QnZNcHdML2pRalhYVGdQWE1qRng5QytGeXNTNmxuYlI2Z0RO?=
 =?utf-8?B?cmJET3IvQzFDNGFYVE9IS2pEWGI4ZjV6dktTQmlFa0U4d2VuV212aUVpaE05?=
 =?utf-8?B?bnJjQnZRZ3FoR1A1QlZqRWNkejRPRno3VGpGR2pOVGFWR011eE1oRU9Ua3p6?=
 =?utf-8?B?YjhJc0JxWU5uemQxdDUwNFNWa1R6STRaVXVDbXBqblZhOEJCczArWC80MERp?=
 =?utf-8?B?dGR6aHZKVTBweFJzNDlVNTFjQTQ5Y0lWajh5anFhc0g3SlczaUxQZGNSMkFZ?=
 =?utf-8?B?NGJ0eGI2YWQvTDJKNnFUK2xzck1UbmxSN2xnT0hFQWNOUEwzWTJ0d3FEdE9X?=
 =?utf-8?B?OVlsc2IwSzBVNGxiTmFiKzRJRUJtMnJocWxoZy9KYTd6T242dUF0SVNINjZq?=
 =?utf-8?B?Ny81RmFsWDFFV0c5QStKYy9GL0c5b29rUXVaOUZHeFBEU1J3cnkzby9xWWNG?=
 =?utf-8?B?MzlEUjZsUWxua2I3YVdCcUVMYUJjc282Qm5VSVhKRVBIY25GdVJQcCswMS9D?=
 =?utf-8?B?M2RydXNWcHZZWWsvQThhVU9XZGtJSmNnV0tHVjJ6SnpnWFVoSUNXQWMrWUk4?=
 =?utf-8?B?NXUwUS9nYXNEVTFYVGdQcmRYMWt3SFlDYmZhTWFSaGk1Rktma2hDMVgvcTZv?=
 =?utf-8?B?NHhHd295V1VzSFRXVHBpclVLQ09mNXZuK0Z1eXFmQ2g4UjE4ODBwc2hJa2lM?=
 =?utf-8?B?eWJ3OGdTOGpmN1ZXV1JYNHE3VVM1SDFkTUx1ZUFkdmI4djJwWGdNSTF0djBG?=
 =?utf-8?B?QWpXTi9hczVYWnBjdDVUblBScWVlZFdqRWpweXJhOHRFSnAwVVhVUys3TUtY?=
 =?utf-8?B?TXB4aDZKMGlkVXRSdXljakI2cnFPYzlEdERXcEhaWnRBN1lEaW9FeTlsWDBQ?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5812D72B8F14E64AA25760F2D62ABA64@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xyq1GrAvawgwUqEDEBNfLyBjgXRbasD/QdOSXZ7Nms72K/y5coR6gVsB3GIv8/Ya0ogNcE/a8rKxcMxy5aLJOo7a5xyd2V2NHhLTgbc5MhPkW2Vm3J5F5Cjt7NxRyONb/nTGltJeAO8y4kqZ/Qw6ON1xRDayQDYIAVi2XicIwK0ZFkvavF1CRFOLBgYMyB1U4YtJF2xgL1M5vQ1v8XvM2LHG/H3g7EJrnUyfQh78XMTIhbWGzxA7sBHyiMvEBwmlTcNm2Syu49fl8uHNEW3p58E/+yXOVCVeLag1DVKSjzUpjLBiJo595x1fZClMD06WXzYZn7BsDOgo5fXA8qDscjgoUja1jAwBX+JLnmb0fUYDNhKNJrda8GCOeJBo66Qz8zRHKQbTErX/EMPuRteJB4NOyQilof6ya8fexjOtqIKdkTuuKnKBcOmmYTLCp9Otsn0+WT/bYYm7FyoIU3B7WCwMC5uM7RukbyIV0mBRH/wOjz6kMselerd0NBHiIQIvXf7PZEEKgAdT0r7dtnRIlR4LhTdNs1J2HnY/BptcXcShlIEW2uWlkF2e9OjnvpTs2lCoMk0Kv2zuGU1lRo101GgWsdUatCuRRNt45C+lGpIUUJaz2IwyECI+AVlxO8h2yy4/AEGUZ8TWlpOzvgRafPZqrnPOeMcvUIsUkefnGGqXPKfapNIaHAHm41dKqHtnwKkp9R4ufD2B1xp5Eo6mS2RJpZC7UNYHx/nvtDXExsXAyn/zjqukbLWgJCehc1OjtIiaVvd61FkkliunldFWy5iblbtSbKLVKXyC2Mzdys2qUJXjkzuckNxJhSShTT/d9bv5DV7cskfRtoE/37f4szAm6uaeOX+fO7uSbpVshLeJVmNFtlksDLQ8JNc6dd1Y2H0Xenxqsi6rNLxzP77Vig==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e91573b-d374-4d3c-4e93-08dbc4d793cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 12:43:57.9484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxIv3RebxQGRefxsE+acSV6Yb4mgGUPatulG/hxc855kL4kXMxUsG+G/si/os9LVoxOOaQzpy9Is1mgmTYNfTmYuGc/iHGJWrUnmrZGIRRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rml4ZXM6IDJkNjA2ZTI2NDY3NiAoImJ0cmZzOiBsb29rdXAgcGh5c2ljYWwgYWRkcmVzcyBmcm9t
IHN0cmlwZSBleHRlbnQiKQ0K

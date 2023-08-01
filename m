Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16EF76B4A7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 14:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjHAMX1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 08:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjHAMXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 08:23:25 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584621FC6
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 05:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690892601; x=1722428601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=pLiT+2coh+CmrUY3+H/Ubz9/wfumWAMwEKtGGPADZhRuvI+vSnSP8zr/
   yosdBUVClQYuhyxENe+8MSuihT4T4iKfFH4DF20vg7ilUu3Beh/fF5JTu
   Kxo6ZKOTWqiE4ncxIBLoXeqWGTn6E1Afx1wUmHPFsqhNvvWWHJ/eJehhg
   KVo+Mh912BEcYMkfuZFMxVYxEUQNdWUzs6YalxxUAvcErAGDfn3UENKc7
   YhFc9PBKNb3k+2hJ+HEMHA82AHyUp8e6KGDkqrwsUHUOlua21tYaBmaZL
   ouav6jeOPay7y/d17plwzH5tsfbKi2Q1+bwnQlm+3ji/BY62qhVOnHVan
   g==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="240138057"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 20:23:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvU5kwQ+Fkav900rYApJmaeRJhQ5x9PyS0VmfOQXGmtAixnRh27iJvVzLmRjJjAVFhwKp9cn0/nEMmAdCYCadbSHcffoltBpGNMZ45tDrho5hBQSj0FyiAm4tdcH64vm/07iyv/PYotmhgQMdrMpFr/QzaTmuLj/spcT+Qktdx/Ch6sa4gGHavwClNfIIbzLSbFFYitrAEqwBFdWAk8UYvOSQNi8lI0LQ8+ktnTyfnahjyq51kDIOB3sJp2aIEk88E0DBo3rZUJFDq6KvB5H4Vgd2NakTqz0vuBu9bVvxgeaiw2zueMZvMdC83oVqENM3ZkMV7TaygDvprGomJ/kBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=NW1U14D+3zYmpJ4D7oOfQzEqmmJmG4cF0EQo4l2tH+yWPYEyy/iAZXfT/pIYj2s4M3Jl98G/CJvNovRR1yvvXv5CPgd6EyG19VnrxOSGLZ3oLxLoG42eXYOVXncIbwZXZNZA/l6YDRZbKlI7EbmobNVXEiyyIFTxsD4FAgPZ2CEYRdvtYRcyRaADn9ZlX/zJ5PHJmi4DqiNWcH5q24qtfes0H5bRSaaZAbVyVitGMRvmS/bRwYFJb6wAZ60QI36/3FsEx0e29g5GyHqIWZFbAj+AkN49S1jwq45I8RpEpjRtWMeCbj97ezOvQh97g3PeuIVUrAxmNpZX8cOFh4zSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=goQkOf9Bm9sfjWcJ10PyTI3qsKkgql7legyN7jJH4HQCpawEA6jiO/lcTVNOkYYyli+pQ5J8Zr3/wi2N1AhlfRqztEIaJDksr0VdFNuRSJPVvhh8N85EEm7dVYREloWOVvd+mrkpepEVPzUZY6/b7AsD/iQCEL6KeAk/ql9z68k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8593.namprd04.prod.outlook.com (2603:10b6:806:2f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 1 Aug
 2023 12:23:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 12:23:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2 06/10] btrfs: zoned: reserve zones for an active
 metadata/system block group
Thread-Topic: [PATCH v2 06/10] btrfs: zoned: reserve zones for an active
 metadata/system block group
Thread-Index: AQHZw9NbzP/cKBy/YkOmxR7HN7EGWq/VXj+A
Date:   Tue, 1 Aug 2023 12:23:18 +0000
Message-ID: <d7bf0488-b2fd-f197-d595-6684fd2774ce@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <790055decdb2cfa7dfaa3a47dd43b0a1f9129814.1690823282.git.naohiro.aota@wdc.com>
In-Reply-To: <790055decdb2cfa7dfaa3a47dd43b0a1f9129814.1690823282.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8593:EE_
x-ms-office365-filtering-correlation-id: 675e5816-faff-4346-77d3-08db928a1691
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYcGIwWHawnwVcxp02XQFVCXUXmVSLxokFNiev0OQ4m/LyN5nHW37F4ep5nR7TpIRwSU/KDwywQqUfqMOMHFjVLeARAZQkDNs7y4fMCm1RlvVyTXHqoPXyc0CDQDLaBEWFDaxV4PcwGAkIE6nbWPssS+JmxpLrj6+D7s3Bg8VpFFX8eIe0E4f94aMoRAGGxby1BZLjEExL29e+0rExUm0+wRmmhc8ycSpuWcHqHJqxsHHQeAfSiRs4C9JXpJkSrGqjz8PB+ey2CIKBeUz1rskrRsCd0lgUZEwiklSEx7HwI6H0zeg8cs52QMgj3sQzaTeKfd0qCCt4M3pKGUcn0zXhU4KzmRKXivlRjfRl4SsmppezlyDW8I3IJ4WSRU+mrH2J5VRdXLJPJiWOpbWJJLowTKpyyCAffxl69Z9AONNwekHx5TTXyRCUQWixEUVBHtdVPFnozxqCoUiENsA1tMvfXT0gfT2h5LT/jawxzXRg+hl47m9izC1UKpCz+oM/CqlJmOOWHQ2VBWBNJ0BFjKEvOql3qkIO4mVN8LpYaOGdCICLMNeyGV4w5D4ohsm8saVQ7cu6bq9YjsJF7fzaiEqKrchVoAnxQRzTGOATjoJIJROjuxJuDmQaIa7NhDSYx4qpQ/tZRzUgl755NXuSgFIX8VtPGfAZfU7Qynt/Y1AfVF9+2io8anvchgpUBoG6JS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(6486002)(6506007)(2616005)(26005)(4270600006)(41300700001)(186003)(110136005)(316002)(122000001)(82960400001)(71200400001)(86362001)(478600001)(54906003)(31696002)(558084003)(66556008)(4326008)(64756008)(91956017)(38070700005)(76116006)(19618925003)(8936002)(66446008)(36756003)(8676002)(66946007)(5660300002)(2906002)(38100700002)(66476007)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW43dlZ5WXNpby9nUFg4blBvcUtsdjREdmlOemdBcWhVRm1EbXhrV3BEUkZJ?=
 =?utf-8?B?RTI0b2xvZHJaQ0JjdFkyZDNlL3MvWnpxV2lVK1drSkkrNkYwNE5XRENqS0Fu?=
 =?utf-8?B?bVJ4UlFjTzdoc01nU0lWTjBQT05WdGk4dFVYT1RuTkxxUFgyc21ydTNMZnlN?=
 =?utf-8?B?YnFPOEFpa0psVFJmM0c4UHByT0NJYjV1dnZEMGNqQ0ZNYWJwRVlMdVg1c1FW?=
 =?utf-8?B?TnA0a1ZuelRGOXFpU0dxaDVieW9WbjdEc0RVZkh3RDhuZ1BqV3M5ZHNOeEZV?=
 =?utf-8?B?RDZlQ0tPZWxEL1dEQlFXMFZFd0VNQ2xqMWZpeU9FSDE2VVQ5Rmp2c3p0NTZr?=
 =?utf-8?B?ZDE0ZkJ4bUZXcDh5ZDdVa0Y4MUFUNWNIbHJkZERiUlIvdTRaQ0oyVW5BZWxx?=
 =?utf-8?B?anZsbkVqaURFVUFyTzB5RndrTjJxUk9RM2o0bjFKVXd4aWRkeHRuOUUwajd5?=
 =?utf-8?B?M2x2VFZKbW9aMnYwSHlnVWcxc3MvWk9YZ05PeWQ5Ry94di9SeERlNjc2NjR4?=
 =?utf-8?B?emlQcVYwNWFjaDUyREx2SHNkY3NkcVJrTURiby91V2lCQmhDelZZMVNFalF3?=
 =?utf-8?B?cjNSeWtsUDQ1MElnU3A1WEtzK3NZYW4zSWdQZWJMYjdjYXBBSG1xUTZwbWN6?=
 =?utf-8?B?WUdtZDNxK0J6VE14NVQ5eUlIZk91WWV4SjJvUVM5N1dFQjBnd0l3V1duTllm?=
 =?utf-8?B?L3V6REFjaGVUZGpRbC9pTUJCWVZGOHNLYmY2N0tDeWpMOFpDdXA2NHhWWVBl?=
 =?utf-8?B?a2I4M1BpR1o3Y0FlUEZVVmZxWlErREVRTU1GNlowSGpRT2NLN3V5TUNYdExx?=
 =?utf-8?B?b1BiTkk2bHhFK1IzZXpCSE9EeWYzazJTeVBhZzFxVlVKMjRnNVNJM284M3ZQ?=
 =?utf-8?B?RVpMVTJjbEt6N1pabld6ZFh0UiswbmtDVUNUSzZsNGMwQWVjQTBZbGp3dGlj?=
 =?utf-8?B?ODZGWW5OaldKSVJ6UTJ6SGhua3FET0RQR3FuUFJ4dlRYVUtZU2dkNVlpcEVa?=
 =?utf-8?B?dDZaUW13cndEZXNUUWVuUE5rSVY3blkxRG5xVVRBQUFzZExadmdGSTg0T0dj?=
 =?utf-8?B?U3FqOHAvZHY2clNYU0JLa09PcGswTXdFK1E5SEFwTEsvQ0hzTE50d091ZzNZ?=
 =?utf-8?B?Z2NEQmswcnd3RVdIbXJsNElVYzVTOXJ0M2NMU2RSNkcxTGRWemJHRGhKUDJz?=
 =?utf-8?B?VXMrTHVJdElqUWRQc25vNTdIQWNoN1RGLzJrTzN5RExFNS80c3diR2VEeVJI?=
 =?utf-8?B?ZGZGaUJKcjBiRTdwaXhEQ0tHQWVFSGFRUFRQQTZnMGhwa3JiQmdRNERmWkJ3?=
 =?utf-8?B?Um1oZnl1b2hxRWxnR2l5MjlVZjdPc0ZGZVRMQ293QjNWSzJXMDRNVWRVSG95?=
 =?utf-8?B?MUNHSXI0aXA4dzVpVlN0SXRUOFZRUEJWVWhrdkkxUXpBTWhiMFFwWVRHRkZs?=
 =?utf-8?B?ZTl6K1BEVFpKSjZIK09aMmVLcjNqbkpEdlpTRWQ1eFZTRFBBMXVIS2FhQVAw?=
 =?utf-8?B?aU54OHd2TmM4RDBRVWduN21hS0V3b1ZlZHZ2cWF3RDVaYzMydm10bWlIOGhj?=
 =?utf-8?B?T29zaG8wUmNvbXhkS1hnVkFuN1c4Rm4rUjU1YXYrYWxzVS9HN3FISjdBMWh4?=
 =?utf-8?B?LytuSXJXZXdqWHV5R0FHNVo3MVZCR0JGanZQR2psd05PQVBWZGJwOXZyai8x?=
 =?utf-8?B?QURLcFY5R1B3MmxreE8rakNQUHZhSEdialVSbWFKRFdsVHFZTE9TaktvUkhj?=
 =?utf-8?B?YXRxOUpORm04UVQ5WTZVQ1JuM2h4bU5UWmZzMjV6MlZCaFBQMmRCSU9CTldq?=
 =?utf-8?B?LyswVXR5eW52Qk5kK1hoN2kwUGNyZEdjL2E5YUhpTnhRWVJjT2FsQ3VMZFN2?=
 =?utf-8?B?NENwRlZhYVJQT0daM2poSnlFaE5BT2JBaGVDSEtHdE5LQ3Z0ekh0aEQzUUI0?=
 =?utf-8?B?Tnd5ZEtVRllkQStiMVVqZGhXMW5HanFVQm9HVTl3c0pSR0hON3JpQXNpTHJB?=
 =?utf-8?B?dHRLSjliWXdKZE9tTEh4Nm83aTM5WGRYdzFhVWpyc3ZhNWRGMWI5REtyUzRy?=
 =?utf-8?B?UG1UaE1Ra1NCMzBIV3UyZWZicS9OdklzRUJlOFZUT3E2amM2SDJVVzhZSm0v?=
 =?utf-8?B?eEZOaHlNTWtIYU5BeXY5Z3RXVDk1d0tpNURIbTduQzBSRWJHMEpYUVhhNmNl?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DDF4B3B7364D84CA88B4D84501250A7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mn7dVGXwgv1si8l2+tv3whJJlVl+/hAyJhp4uKWuhWTAZ+K2Pf17Twy7gc85y8or9hJB0zRGAgOPp1Noq4saQKYe+DW05LTNOZEMn6saqund8enDLXY/2AUgIz7JgT4fpmQAfp5l4trSge6Ux6pHIdD/QVsVoVK9VD7JHhv8bixZ2/ugMRQ1/nFsHuzuIxRNNTSWiQHxYXMT6SJgZQDWwPb5vYiuH8eHqS05MKj/oBU8iD/N/ratvNa6KlncIRLmx00U7MGVDMW97D4Q2I0qfGqS1X5KFLs0w9FnDGfZfcFNfgy1+ey72DeyzqCadiW14jseNhYjQcZ8+30qsIPG9VxxM1cISPiA8oRkVp9wr7mCPLyrgVKPTpj/vCCwNIGRgoww3dxpdM9dLftjRPBYXsbii9lMOW+4Gs676K03H3wt+aDngwbCRYejJjZVM4jJJEjQcicnH363+2kfDwtkUnFuBnlJexPkG4H0T0eE5NOh/eqjPJFoS8V601vw931jg6QDdTbOLXlKDvx9GBf+IQVjv9iOm6TsNjC4bbKEgeTta4aSgIYuaeeqJrlEcTTA/ko6IOp4uTbZ6CqZubIDtaW7lkevX7yatYU+gC5AmstH+oAvNOJbnKt3BrD0+HnyjW9p5tn9crGvwSxjagZ78HpPcojaLkRUoK72fYnK5rrI7GMdxdonZ6ly5aTTYMgDM29hJOxa1IBV356UCA225Hl+A9n5KpjYLgEflnAdH46VUujPSS/oqmaLLmbUsQKNigIYvEunvqx3qPRAvOqBhfCwDvoQFrr3M5UMmnqkjdvHdzp1/qyR1ZSjwQm9+uMZs2WDOx7KwyOrPassZ0uwMt0FErbtSuUcqd/SN0bPYyLCJa5XbQI1b1OD/J1dtXcO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675e5816-faff-4346-77d3-08db928a1691
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 12:23:18.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJZhpLYH93FkIn+rdy8YvhzYbcr+JGewCrnKCBMUjcuV7NPjOtoiwn9zjElHH9jwvBOJirD3XO+btZ+ZFiaPa6uFM3d3rpHtCATzXDUR4fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8593
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99FF76B5A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 15:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjHANVH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjHANVG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 09:21:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE161718
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690896065; x=1722432065;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=UM2bSJVNwVhyh8HFWeUuEdimtHQFJ0pLoZcT3EQy3BqVRngDD1geilF8
   8HoTG55KX0GqI0arV79XGgfmu5w6/KFk3NfcJyncGf/lPl+cz7Rjrz7MZ
   UTcXEKVDuwXN//X5JrcGZYWDCpOypdkKPi5H2PY/JEfYE+x0jnh0G4J07
   xWv8dIjg3LalrObogOeHd4g/6JVPH+MW+O+ndrmYDm1pVpzkaboCiJCFU
   6xwUQZs4gAE9SDGmGjcyoP7S4W2N68yZE27IPLwhcLcRLtvfJwuBFYJFB
   1KJGgGjf3JgQ05lePwROitnTNQyqqmEIREqmEc0kBVB9wCHaezEuzSpV1
   g==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="244380963"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 21:21:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nilyRXX/0FJPbX3YG2Kj/eVW8BBwChajXrS9xQwdp8VbleBq6iB49PMAQFbw9vLeA/oDAyTYw/gAPMLrigKPXnSafhCakoXtINqt2DvMNdIv38IFWtBqIeBNGGlqZy/BrQBb7LkqnC18AVaPdh521oPo9pNy0ABdt7lofjOArKgv5MSYa1/U+et8RLYLgLYRL7NLzpZ4n8R9b7p6m1hIBjw4oGKntS4dLvSD4Fahu5pFKAwgZPAwphiQuav8PduRrQE1uR+YiJS1Y0koBpMY96+/bn0UHVEDhXiBLoANsJ6Np88RMr7JzHuFVTSLBViXAHl77CVWtIaMcuUvX5LaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nlkHk/ZKTKbzR+WWri1OfjzybJXsQ9ON9hxnRJg15ckKsQprqBtfEsC3GHDCZAFNwuGU3Nl0QwKk7lVXi2L3PTNKxDuSAa5U3cQSsfn7HJVkV4EhVfi44plVgu38CzOv6y6vy9/cBDHlMT6/L4bxjIth815XwxiMNlvXyKDBXkugxV+3opC9JSN+eQwJ36AYV94GyTkkJtzQkgyGbKIA48328uICk1jcZDjxOminGqxw5BT9U7uHwB+8765UHh41sPO4nwSY28jrRHo9l4mMCq7kEIG0LQvpHyA5ZscuzAIeHhiA5zgXiOERP3MyXGuTACULrFEKxsPerNJRgMb3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=LO7IQq2JjSMo2u/yzTGfTZ/5XDv8goMWsJPqZPPeBYfxA/KkaHbfiQHK1kL/oJ5p/2bWstvO4KwPFpnr8kxPVb31qd1lFmkBJChfoJCEdRcp6+U6FeYJ+X0uXw0Jo0u2KLZVpcQkeTdo3rxcdfUmm7LBfRfdVzd23j4cvrR6rJM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7276.namprd04.prod.outlook.com (2603:10b6:806:d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 13:21:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:21:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/7] btrfs: fix fsid in btrfs_validate_super
Thread-Topic: [PATCH 3/7] btrfs: fix fsid in btrfs_validate_super
Thread-Index: AQHZw6CwYL7lib0lykefTChtJD6Tia/VbsUA
Date:   Tue, 1 Aug 2023 13:21:00 +0000
Message-ID: <648affa3-b116-99bc-b952-6fae5d0846e1@wdc.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
 <19310b1aee2625da1a90f59c03a8b78fbe21e8f3.1690792823.git.anand.jain@oracle.com>
In-Reply-To: <19310b1aee2625da1a90f59c03a8b78fbe21e8f3.1690792823.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7276:EE_
x-ms-office365-filtering-correlation-id: f7c6a07e-28a1-4142-133d-08db92922622
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PxFXy0BwBNBb2cfroO3+yBZP9XxSIZdzISUCZE+v6SNkv3DX0SUuAI32N3JA/vifnyp0uKse3/hZeb8qg+lZpB6/pSb0XAlpDNjKA2ofPew5yYS2zBQpUhjfVLGAAuD31tKOzcaXOKRCFIiTUro8UxiyJHNxOkNj832e70NpOaqpykRLvlsTX1IxvB8xa/YpCudeTUh/Io7w2aFVImrSeu5OJ4m69aC77TpW2/Dq39SLcl080iYWAQr00YPs+S6d6jUG++L/rnYcfJ3nj3hfsLuw82+K0gmr7sANO2lF+S8CWIh1MQPWXVA1qd4INun0k7JI9aJmvPRUk3f2GsRVO+9Vz2V4rrzWpwakbS1X2yatQ6sIM09psAgT+/td24nsQZZKopeEqTrEkNgqdSyxM3ak1rFzQ4p5zArZjPUtgyzNgPY3toJ9dcq5lpO6dLzPvmE+Vtfol+C4+AX/75TZXkDHoc/gTo3HYECHj4GyJKeZF+fp14LGJ9hNZNUZMf2R8QNGjttor/EnhfgFvuI5dfOTd3lyIFipG3u6UA0+yl/0TYhx4jPfDHpePxb0bUCH45j24hUhqA/FFh0gxuRZjCKVlm2AGggNcx8DODfLDdQOcDcG825y1Swa7UYCDWPhmfnxXPAEQB7xTK9BtL6ySzk9p0rfs953KiY8YfAB0+9R5an/Fha1dyDJerF7bygj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(2616005)(38070700005)(4270600006)(36756003)(26005)(71200400001)(31696002)(110136005)(6506007)(6486002)(6512007)(31686004)(478600001)(558084003)(86362001)(82960400001)(38100700002)(186003)(122000001)(64756008)(66476007)(91956017)(41300700001)(8676002)(8936002)(316002)(19618925003)(5660300002)(2906002)(76116006)(66446008)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGtmTmhsSTB3emgzd3FMU2xJVWZ2dThmdjh5YTRSc2Qyd3FqVzhma2wrMFJL?=
 =?utf-8?B?VWRnUGZFQUNuTnZaUW5GNTdOMzljUEg3SzI5RHZYTGxITGMzUlVJbDNxYmNt?=
 =?utf-8?B?dExFaUszRUdGSFJXNzJ5SlhxT1FNMml0WU1ZTURjRDF6RjQ5ckg1bEZkV0hv?=
 =?utf-8?B?c1gxZ2tlV1NuVlR3TjhTZjFKZG1TR0JCVmpsVjE3NjlzTG1DelRjMDdXbVZk?=
 =?utf-8?B?MWJaMFI0OG5ZSUlYblU0NnB1US9abGtGbmlWMElmT3p2UzJzMlkzY1RDcVhr?=
 =?utf-8?B?dzQxWTU5VmNvV1FxQmZzcHZDWDg3aGFaUjdZMkxUNWVDam16VUtqdFFpN3U3?=
 =?utf-8?B?TUdtVnFPanhUT0pFQlZXajA3T3dROTVvRnhZUWlpd2xCTXkwVmZqeXRpZzN5?=
 =?utf-8?B?eDJyS2lPMmdlSmxwaDVTdDJSdEhvejkzY3FHY0puSTIxRkI1WmVNV0x4aVN5?=
 =?utf-8?B?ay9zbTYvdUJLOWFqdVQzZXpvL3lPUGtHM1dJQVZuVmJrTGVaWUFSdlpoK3d3?=
 =?utf-8?B?NFdFNXpvbHdSdk5za1FjWVFFQzhzZXRpNHVyQUZSTXpuNjJsdEJhZUdOZzZt?=
 =?utf-8?B?Ui81RkFDL0lSbXlyRHc3dDBnRHhvSGthZXZEb1VuWW9RcWNKQlU3ZmJYYVVz?=
 =?utf-8?B?dXhicTFyYmZ2bEhLL2NsWlA1Rm53QlByMHJKVWF6VC93TjU2blVxL2h4MEFt?=
 =?utf-8?B?RWozbkdIcDBBU2VTNWpwUlhza1pIcm00NWZBV0YvdU0yN0NqZTBYVWVrVjd0?=
 =?utf-8?B?KzB5M0NGQmY5WmNHWjUrZVBvWTZ6cmdKaTQzS0t4QzFvQlJHaUI2cUd6VnJY?=
 =?utf-8?B?QzRlOWwxMXh5OWpQcGI3SWRlSWVTYjY5dXRCQ3lPRzJIYmFFMDA2eElBWjFz?=
 =?utf-8?B?bnBNb3Ezd2s2LytsYkwweVRrU0pnTGdMd3RVSWlnbmVhRHk2NzRJMytzb3Zj?=
 =?utf-8?B?aEtQZi8zaExzWGs3SzJCTmhZNmh0MC9ObGVVV3FBVGY4TDgzL0JoL3Q5eE5X?=
 =?utf-8?B?SFQ5UkgzQk9kaHhkclYwb0ZSM2ZOY25oalNPQ0t5bXBrTzFmTnlSUTZ1SDBt?=
 =?utf-8?B?T29SYjdJdXZJaTNXdkVaSkt4MEdFV3N5eGZTYzV4L1o5SmJMdDRlSUhNMjFG?=
 =?utf-8?B?cUZWMlVRQU9TajV5SDQ3RVdHWEVaaFZPaHhQcThjdGVYWGQrcTYvbG9CeE9H?=
 =?utf-8?B?QzNEelI1cnBXdU13NE1rQmpNeEJRaTd4QVFSZlBjaVJ6MWNQOXVaMVVsZG9F?=
 =?utf-8?B?ay8yMllPM2pvTkhOeno5SU5HZjMxbUdZKzc5eVJTaDhJMUprV1NqK0U1dHJy?=
 =?utf-8?B?OGl2bWJJYWRubDBiK09uTmZFYVBLTXNneVF4dnVGT1BvY0lUa0NuVmZUUzR3?=
 =?utf-8?B?aC9VKzVpeTN6TDY5ZWo0VDlkK0w0S254Nk4zUkNxTUs1bzdyZ0JzWHpkV3RG?=
 =?utf-8?B?eCtMQlFiL3Qrc2RzdUVTUFlzcXNVZW1nZGdyckdJejhDYmdtOUJjWjk2Qnp4?=
 =?utf-8?B?WUlENi8wT1NuVU9HREhUQTBRNjRlLzAwdHFLSnBXRlZQcVV1NFBNZU82emcx?=
 =?utf-8?B?SUcxTnpwYzRJTkVYT1Z1c3RJUHA2eU56ZDM3RTRLQkZPR3k4WkZLam1ZZ2Fp?=
 =?utf-8?B?QWNMaGtaNXl0bUtCcGY5QlhYTW1QVGZ4REk3ZjJxNlBhRWdmY3VKcFJ3Yndn?=
 =?utf-8?B?WHExUklxOEp4eEhkbHJSTkl4enNHcUtlWkI1M3ozU0Nwb0VtMFI0TkhPMEJY?=
 =?utf-8?B?T1lWSXNBSG1zdEtPUVlDTVNoMVhlM056WXRkcGZhYjA0QkxYbzMwZVNkQTVz?=
 =?utf-8?B?Nm1pZW1TRDZzUFkzdTlrL1NHZzZkelUyZk1MMTZQTFRCcmtvc2xtVDEvS3kr?=
 =?utf-8?B?OTF5YkZsdmx5L1RlUXJtM2UvT21uUWUwakg4UlY0QzJJTnhVdnQ2M3ppSDlY?=
 =?utf-8?B?Q2xaWlk5Rm1mTmxQQ1NBWTNtUHlrdzEyczVGQlhBRUQ3K1dWbVd3K3MwTVh2?=
 =?utf-8?B?ZDk3S0twWVczZGtzRENtUzZlSlpXbXlhMHpCM0FmcVo3ZVpzMFJsQXEzbHc5?=
 =?utf-8?B?TkVjRlVvcGFqUndtTzhBTE5YcW1wWWdNaG9iUGo2eVExdDNZNjRxK3FFelZY?=
 =?utf-8?B?bm1zSGRGQ2dOMVc3RExjMjc1bFJvN3hkc2VkbGJkYUNjcm9sM29DaU04SkIv?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A912F92193E4A340B4B6681CB535A76A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6hi2nSsB1Gm8o9TCGtOkqzHrfHjJ6fr9UNLI5E3ItBMO+W0ZIpy9gVPTpY60vIYiE1hSEZFXxWBwIMfWYp+C9lNeP4mrsne94CbrHWlkBywqZJXH5BN0UVy8xhl4coxR2BJWbPEqfNK/5WrRHw3rGsUtLoSRKJfEXbhoTDP2nM/aUwYZOwoPLhpXBlsQ7Wa+r23G5PkZuXhqvA5W/e8yk/WyrNOrRQbsgtp+DOHEFhHTDYd1cl/1MkiQFFAPCC7prbKp+vf078NZIrt+k4LuRsr97lzX7jmfWKm9Rt81IXhOPdJilnMxbNIDONl8cu3lxCrF7/MfoCXLpz4UqUKYydPjiSykCG5ua9O61zd028tfv3qBWRiaHtXtNIh54GmzAGW/s8zCp/c+WEVTTatIEu49eRvVXNQQNajT/n11cUEtdXeYCXyIQ/pjPjNrtFYK6ZzNqOwby1C29DtJy/j2Y68J9clLj5trO9nE3GOreehgcLGILN0H5CS2CEDeXH85HRoFQPEcwqmA1eJugCkL0EECPuCJfXFCzGMXIuU/GohAUCNqUkeQGpFAWQ4tWh0LldMVAoWtEfwbc/92kyWorupJxg/pXqZ3jGlXZ/Dut22uVfC6a4n6zIDzf6Ckc0BThDtmb/BcHPFTd8luGWq05Rl2mP5CapCY0hUX4oirWdh0WM0XLXNFDrVKTeBduVtsYBv7AtKLntqdorJG1QM9kiRmuOpis/Qn0K4r1/kqIaXCrYbtWBUvW39kxjjlPSCur5I1ytP3w1Ik4QxI3yDoQDX+p1jPpdAm8sfde8ulgBxLrAjLtns6C2faaV7zHiaR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c6a07e-28a1-4142-133d-08db92922622
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 13:21:00.5353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4At9rhVx/KaA/QwXZONikL28+0B+qEU8C2D3BzyyTREbJpm43eeuEhThdg+ZrXhggDkEbQULxS1PxNhCH2EMGhHDieSPZleov7uikmpCiPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7276
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

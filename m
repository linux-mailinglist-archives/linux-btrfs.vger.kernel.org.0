Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4571F69C7FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 10:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBTJwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 04:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBTJwv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 04:52:51 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5AB2118
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 01:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676886770; x=1708422770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=QsoXHi4gNR/Ne7AwEg7HIy8jXiWaIcPiyT6i4rAk/4wtKgKHoHW5Pg+x
   C9v4DAgw1XjyAPVqArB7ybExgs7TRcyff2dSwmaULmqpqri5g3t5k0+yq
   3aT98Qbd52Za/Z+rn91GvKDxGl6RC9Nj6c7CLJGiFkjbs82n5KV9TJTmJ
   6RRLFq048rkRsYZfkVfJkZxNS5EOGVIPgavuViwcJ6Fsh+iq72u+fiZ+a
   BWM7AnyTi+BcqwToHHVe5wVvjjtrFnGXXvZd/taV1g2mm2oxMthX4is51
   9ebuQV03ZUkdFkNgece1uyTJCnpFviPkyo5JIJs/V/SnVkpn1M6Zezga2
   A==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="335691777"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 17:52:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zut9tk+su8WZKDfykDAy+kQVYwBU0Go9CwRGTRvxmr2z7vMubIwFFp+0jxOLszl0MAQZRvq/3vq8b0mrqK04NBQ1nHChmutX2yifxTAXUYCMVOPKXfUIhoAhK38+1epX/CLr0g0cOc7waFB0JCqIgM9mDQuILvFL5FgAFFuHbttWq0rAJUiu+bQsBoD5f3enXcv15ZD/j/mA57KN4r3zzZjHkmwWgsaey9hhnwnB2tUuCxwk4pPOw7ZC/Ea+Mxd3DwNoz4OIRMSfMbtCQci7HRcY/HkGSEjzOeKudjpNkzv23nUrbIj1MEeioVtXjWtCqbYFRk7ClM45mwvbPlfiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=E4bYFqvcZ5S5r1dt+Y379Pjb0tjyrESp/u8PP5rxb9I+XfVyMWpl1yuOcXSfaNfmZs9xmiBAMGVxrkcHXEXU037kbkFX/fAgkefLtualrYPQ0+Lzeqt5QalWjm/akjyqKu4w5N4VTW0KDNSnWN6ONfrMgzZ9nN1lGlk0+bP3hDT63BxAZj1DFAwhXGRcCTi6O22ThHkx+irS7U8nnZKvlwJp3Hm2T3tqgjMCRJBycQvYoCvH+Hu5eh+7YF1mtLB0tRFuoajfdZXWaPZcKkgjAs3ja6QobfxfRsXzXbue5O8K6/tFLXVMMOUe0Y5oCHxsKKJN9EMCukpTCbPeQudV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=k5t+2yi7k89h5k8jhQG8h/bznSZadYWU7QlthEA10mMQhoMQx09kCOr8AzhyIszxb9DWqrmDILD9koYfJYqmWrhyD2SVw++TgFhm6fgcxA5zrmZ1Y6UtMGziv6ay1z+3eFJvxbNnxqMhDP7s4WverjDfGTJ+w5SGWiEcNhO6xP8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4275.namprd04.prod.outlook.com (2603:10b6:406:fd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 09:52:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 09:52:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/12] btrfs: store the bio opf in struct btrfs_bio_ctrl
Thread-Topic: [PATCH 03/12] btrfs: store the bio opf in struct btrfs_bio_ctrl
Thread-Index: AQHZQiSwXYoKG8E96EqMpl0Uz9bRO67XneCA
Date:   Mon, 20 Feb 2023 09:52:45 +0000
Message-ID: <d5a26f5b-ed17-fa67-0119-53d63e807b00@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-4-hch@lst.de>
In-Reply-To: <20230216163437.2370948-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4275:EE_
x-ms-office365-filtering-correlation-id: 0acef0f8-aa26-4dac-6acd-08db132837d2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hw7flzRHe+1HRh0j2hLCTn+awmCo/WAzWSBS10mkQNiPuMJwazftK8yukEfbp/0F6QLP/wNGJgocFMU2hNKPXPeZAl6ZbfeC3H6dkRyqCzYUuQ5Lj4DlUGBSEZZVOqOkvLaVrHVkuuS87/fhJ5t4aGTu8SDEhz3zWC+tIJXCGOWHLCy8MX0A8Zx4J3u0uuO92An1cwPvPjeDKuie0qo4G141kifBiOAzmyzxYHdF+0bQr/pfliFTBGNVJelnJixNlmD7j5zKCvJ/I/P5gt31+LonWxkR5hsK3TQOsOxs2UeuGND3kYD0jWv6ju1n3VhBQgsf9fXZ2+BTHjgSHxL9QZVN9Xr1qqZy3fMGC5FDHYGFYhipwotOs73axLtP1zX7PYtzAjFed7wM7aYUBh5o+TJGLGcpXTfnaMf42RGUOmvy2ssv+rSTGS5/jH4nysgzFf+2dxhNYLExsZya90by1GmMKfPCdKkVrMnMLdgs98eDDRMo6XoIuUCuG/9vTT1i4EzX7o2gB3ya9nc09XMjK44iIYlFyD1hNOdyKAT+FMQi6LiRwrQ6tTQADywHRzexf7YmYJOS1V6bsfI/1cJZxVmtAQe7wMXMTA2c0cuw7PlCmTY/4RlPM/vBwlxgGUCofBD6QAiFT66yi0/KKfdi5uN2o1Gg16slibd8Xz9mUBgITnXj+fQBFCnayGNNdNPyvGm+XzLA9Ztgp6Lp6FbtWGokoLVtEaTH9PJhutV8A5s5QD14HvJrGY586if9OBR447ruItTDqbBOM+jjcBtFOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199018)(6486002)(122000001)(31696002)(31686004)(86362001)(316002)(71200400001)(110136005)(8676002)(76116006)(66446008)(91956017)(66556008)(66476007)(66946007)(64756008)(6506007)(6512007)(4326008)(186003)(478600001)(82960400001)(41300700001)(38070700005)(8936002)(4270600006)(5660300002)(38100700002)(19618925003)(2616005)(2906002)(558084003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTRwQ3BwOTl1S1pHajBieXJYaEVZL1VXRTdFaTVOb21KcDZybUQvZlg0Y0Rs?=
 =?utf-8?B?U3VmeDN1ZmFQUEc4Z3VDWlhSOTNJMDM4NmlKTmgxVUR3SkdDRi9VUS9zR1ZF?=
 =?utf-8?B?UWZkS1BPN2haRzFua0ZTZlg3KzN4QTNoaDlrVWk1TWcyaDQvVUhwNDQ0djcv?=
 =?utf-8?B?ajZEOW1iOWRWeml5QzNoODRCcUZyRVF1dldNWU14bkJkZy9FK0RXOEVGOFZZ?=
 =?utf-8?B?NVhhMUdqWlIzOWNhbDRucVNuTE9JenphSVFuUTJqMUlCTlVoUnZRVnIyTFVU?=
 =?utf-8?B?SVlCRjJCdTJtYnE0M1RCRGhKYTBRS1N3aEJzK2oyd2Y1cmNJSUZWa1M2Y0Jx?=
 =?utf-8?B?ZzJQQVY0eUJmKzFoTE9SOUltTGxDUXIrUXBpQW5xQTQyUG81b0wrMjc1cElk?=
 =?utf-8?B?RTNWeE1PSEVGUFRRUWpBcXN4RVI0T3hDamxyY2V5UGFqS2t5OHJOdXhqTDFH?=
 =?utf-8?B?VmZCQmpOZVhBdkdhV2lneFQ3d2pSbWJGdm9BK2t4bytJbzJHU1RUcnlLWmwz?=
 =?utf-8?B?d0dGRVJDSzRrUDg5YVJNZ0dUSHZoTVhiRGxLK0pHYUpLcUI0YXVRSjVkcWRW?=
 =?utf-8?B?ZHl5NVhmTVZuRHJoY3NSY1dHK3dLL2pySDNwaCtZZFJhdlIrakcwdWNqa09r?=
 =?utf-8?B?K2dFbkxyUTE5NDAvWjNnMXJ1UWgxU0Q1L1Y2L1lqbm5TWnpQMmhhSzViTFRi?=
 =?utf-8?B?S2pjdDU2UE15K3ZpdFBkdHFzdEVURGsvWGJGQVBHdXRWM0ZqZ3cwVGh6Vkh3?=
 =?utf-8?B?aDcybGdWaXdGeEZpN0hPc05rSy9QdEtZTHBSL0p2dHRpMDByN2FaMFQzVVBh?=
 =?utf-8?B?UzhnOXplZXo0NDYyNHphRTE5M1hYa2dBbzFqUVJWYlg2THoxU3RHbkRCRU5R?=
 =?utf-8?B?aHM2N3kxcXpPUGlRTzlVOWpaUUF4QTZ1Q1Q0eG9KZWJQRmRScG9mRCtYTURD?=
 =?utf-8?B?eU1Hc1hDZzAyZUZSRDNXYkdJVXlwUEw3T2hoUEgza0N4VWNlck9iOTB4dS9L?=
 =?utf-8?B?djJIUElabjRyQllqVUZKZ2cybTFmNnV3ZXpQbG9lNTFBNFB4VnlDUGVHLy9r?=
 =?utf-8?B?UG5xNzFhMlVPMHBSK01ZbnR3VG5QSnlYVk1yMFY3eHQ4b2ZpQkhQMGFmc0M2?=
 =?utf-8?B?bGtaNGs0bFBxN2NCOFE1NkNQTWJxWHcyWWtaL0dnK3JFdWQ1Z2tJTEpHTTQ2?=
 =?utf-8?B?V2ZNRWVFSFpyaGFmK2dnTWE5V05rYVFxa0I0V0V0T3VDaGJROUpzNGdya2lk?=
 =?utf-8?B?blg0aVVPUGt4VnZCNldVVXR3RjlYOXBmK3paN2R5QzFJaENvZGlwdnpPT1M4?=
 =?utf-8?B?L1d1cWR4Q1NxTWRRS0k2QU9JcDJzVm9uQXBJZmVoa0dnb0ZPUFduQVhxc21a?=
 =?utf-8?B?cnJydzRFQ2FDRFRHTzd3eFg1UWtXd25nK0EvRm5IRW55ekM4UlVVLzlWNWhT?=
 =?utf-8?B?RndOd1c1M3l3MjVRWmowL3hlYUdpalNLNTBGWUxwQXViUnVPdEhQR3cvTkZY?=
 =?utf-8?B?MzJJZThYV0FhSkdPUUVva1B5VVVvV3piVnV5dDhYUm8ybllzdW41cE1DK1ZP?=
 =?utf-8?B?MkVNQ09FV25LSkxkak9MaGV3ZzQ1cG9neVBiZjZ0K2IrajZLMjZhQnUzZ0cv?=
 =?utf-8?B?OHJtRFh5ZldOSmtKVEVpTURXY1ptQ1JWZUdidGhuaFZ3aEpDekNoMm91SkJJ?=
 =?utf-8?B?dmhBOCtZWFcvS292aGloZlFPNXVrbzlNNXNuSk4rbjhFUmVZbDVtU2tFRi9E?=
 =?utf-8?B?Q0hoZHRmZmZwTXNmY3RtZENMNEM4TWNUQ0NQRFZ6QlUwM0c0dnpYM2R0OEpR?=
 =?utf-8?B?L24xZHRwT1N2bE1ZM3ZFckpsbGllYUJVdlY2bDhteUFnY2VyNHFjdlVUcG4y?=
 =?utf-8?B?ajYxVUwzaEtxSVF6WXZZSjFpOTVuWEYwQjJpaFp3dWdLQlhEOWQ2QzJZMFFW?=
 =?utf-8?B?Z2N0NWlyT28yYStWbEtseWVmYVZuOVduQnNmbHJIdS9HcS9jN3pVYTRVRGMy?=
 =?utf-8?B?TFBKZEUrOFIvZ1NFTzV6T2tpSnpkRHZJMEppMzBsNHVGcG9QR1dqNVZHbUdC?=
 =?utf-8?B?b3V6VjV0bDBUZW01Zk5qeVh5SHl2UW1oMWo1M29ITWZzbXkxK0l1MnE4MzFP?=
 =?utf-8?B?RWJJVXdubDZLVVY4U1FEaVB1S3hpaXJVeFR1OWIrK0Nmb1ZuRXZlbWpiS2Nq?=
 =?utf-8?B?TUtDYXAramFDZi96ZGxiQlhteSsyc1M3T2wvUTlBZjZIb203dGpGamIrUlht?=
 =?utf-8?Q?OqwRdD8KWLNx3p3zINBOyl2UzFVEXftqvfJxp4MA54=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E5311C617DF0842992B3FF5A630ECD1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Yx5HgCyiEYJZKDDW3FwSMZh1GdphKg/2iyK+cHHlhs1UPnKZW2tHjVWv4iSU4bANAaZyKXkVBMdMMYwyngdT1YmJu6ViIdm3zMijHkPqRwQbbem9OLkXj6XzXwxfZESbo+PooJqMoiAClWiTcHSv7k8USr3n3oaneOuFyHuPzHpve2Ijn/Wbpz3fDa2icfdrPBZY0tgqfy5+V8aW0R/eHwjTCFTEe9Y+fnx+yd6oQSEInc/JuEOyeMvohP758N0KCAsC2/KxmoJLGA/oGFXZKt3ogZ5T4TfhKfw7RZsFXspSTBBvc5WDXTNEk36cC0JvdrpEIHHAZGu/Mjpm7DLJhAGVPDbMMRCI7LM5PGEzCyohUjn5f3JbjEms+tSxMIPjg4LY2oeN/OhSIvw6a3oa+dcuwuNL5xwNeFdDZPKHQgCxTu96jrwYrvXYdQnjKMSKC4cDhOw4g7HrnCZ/xYXAPj1sRFo53/ZoIP7k2MgI03v5GirYossul+CdPCr1b6xPhqkHvEjVuuog5tOkhZwd+BdsLs3INQQRp/6e1ZIVCJHjOdVgQW9aHjbmSzl/3FhzCI2IL8zS1GUIc8rnMhrEN/EPA6IUV0Zh9EVwtssE41c3DqJ5mU7U3FVQeTpLYIkusn9e4Q6bJpQZ2qdRZfd8EmenBNFIdNbiBE+xXgfdDDx2kTrHfZGcNgPl2rcfgPpxe3RPFpX3unWyYlMJzsl5T3dZMGRXGKqlZZdAsNBjELgUjzMM2NtnH7HKd8Xkz9BLS9LV+Wi6pGE2DFhgTvl9yQei20g/39C6uW8mV4jsQXh0zxvHGVWooAYhAwrDnyjZWNtZ+rKwyykqKFBOY5hVXMAAowOL5kAx/hnv/vf02iYU4WUTi3mswkzUxjR3QO8l
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acef0f8-aa26-4dac-6acd-08db132837d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 09:52:45.9056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DV8P9lgRIU13Gu0OnYbY43mFdKxqrIeHMRDaNDU2JxFJV9yNx3mzVkErc09MqqEzrYg92dCxVVswFEgX3yoRHG0Yz0v5SwSqpHEqLUKQvP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4275
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

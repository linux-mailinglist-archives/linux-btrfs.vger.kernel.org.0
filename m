Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416976A8413
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 15:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCBOXF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 09:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCBOXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 09:23:03 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDEB12BE7
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 06:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677766983; x=1709302983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=H6eZNMzmgFJ4sMbPJZ25cqjdYwc6m7An/qSNNGZ05kclAMe30koUsPwU
   Xo7kCx9z8SebqsbnfcWMJ3i1S2aYDcN11u7uQHa1wNSgE1kiKMDKTrK9e
   10DTaVXVBa5XbnoeNw5sWyToIFvy63NpXrpyufxakBBdVYKEjlYeolezl
   30fIyPvp5o9LEBVLgdfGgDV2f1t0RW/Y8SSE6flYiFSacn853OR1/KK9w
   avKwd8+JRTidti4Z+awNyGg6/pSABxHfwrKbcNen14y61thZ050YgCYM3
   mG7LBGRmsoDv2pNU4u61q8qCvHwDDO84Pf1hKMtttghClrOeeEKPmEksS
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="336612664"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 22:23:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4xWCPcFa3t+S1J4h+l8haSbDCYY2j/vS6WyXg3yd+HuDmkGyka4XKKg66D4OZ9rZCMDMHsV+XVrxXJNA8j+zclV0pS7v1qBlX2vBTAoL/6y2Ke1sFtUD0adGexStKri40gnVG2YfVP9TGyOwzMWNX+hchFLRo2/D1jPbHTwWOTusFvm0zPpUaGCdjZklejj74HzLzad0STqeUViaR9f1+MbVSl9OQBBUrSmg3UGwmtav/9xbnQbkCukEXLeUV2KbgKeUnXRHMCYTe7HOZcrHLTEV04rXXIJHmF0Iog+Mgv+cOuiV/18qpE7C+9RXzvKXccETmQd0S10rKElCN9+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=k1bv8inU2AuOyccftktx4AzyUvNE0dgTt1HLsJ05ZzLOXZNmzvKhJZToZkmI5E5AbuorQZkTrpmYNyx1prCADNC0fM2/DUhR6slqfHOYqYpZ+YXpMThJzAa9e0IRYRRbkXTRwBJ/1dQKQXAypikY8kUt1XPMtG66jwMkcFRTn+5XfNSwFpXF3DwiWPHtJRTbJUY2vMo453POkDMJ96sdFsYZEBtBLWAHCEo4XhrG8aHI3DxEwjT5rLzXo/Vs3uG1hfDGpfzDw/9dKcPAtjTTms3/xNs6pBFRAlRyW42qX4GA62NpnkMwQFF8cbY4955j88MWnlv5+R34ylgCrPu/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=rKSeAzfNyXZdbgN1wyCD/CjWvIanrk56As/3mfhbi/B5bWI4f6o5S03gsUzndX4u8l0L14Zm3cmJduCGzmwLtGBkqya5x8IvPNM+Tv5tUYZpCAXcsUrA/R808rl+Y5UrY2+Q55Xtngk8V3IRJ2bHkZjrgpd7lz2tWNT92wwcQOI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 14:22:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 14:22:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/10] btrfs: return a btrfs_bio from btrfs_bio_alloc
Thread-Topic: [PATCH 09/10] btrfs: return a btrfs_bio from btrfs_bio_alloc
Thread-Index: AQHZTEPA3I3H7q7zAUyPY+Jjaqet5K7njHEA
Date:   Thu, 2 Mar 2023 14:22:58 +0000
Message-ID: <87b5bee2-5f5a-6a5d-b829-2287808c618a@wdc.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-10-hch@lst.de>
In-Reply-To: <20230301134244.1378533-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7812:EE_
x-ms-office365-filtering-correlation-id: 1ec07699-c5fc-4e9e-adbb-08db1b299fa0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EePRQyDpkNJapnEp2c+gJ4ChAhKYxjLEgExPSCJx20rOjyqdxgerJSAydYWSKXGN32y9r2sScAX3qefdf9bsJEeXiG4tQT+ar8sHvnYTKIy0aWU/8d/l/G68t544It7Al5BKVi0TLTRDqPv7XLxhqnE8I4k7+PNZRbYTnXZ2bY+uh6TEVppAGmg0D/Xzufrc7MG5+zddmTUISMNhJ1ijc+qw0BDPh+YXLM+SyevUB+7QPGDVKqU3KGqQqG4hRoy3YfX/2Iek0jVEeK/HitqCh9itMCdq4zSXm7OGc7FiHwTsjHBImx13Xwq775SED0CjJQq4mYONoVQ0b3iIgRw+G9D32oweq1iqqsVUdaHYgMPUDIpNEC84PlktWyKM7ogoJaFp1C2FEtaT6NIBBYWYrNVgx3eEnbd6PdLTpKu/pob740/omyYFgR1jPmeVlrGG47vr4uQqXwqNDINAHAavlUc/TsSz8EdvRhjUiWiX2V6LhLA8Ta6r+Aab4paEhg3qroaienNzsChM68/LrOSM+3KBR6ViY4qUJAODthkkKpFZjH5+C0bQmiMh5k2LTMawsl9Kve4lgfZJ7i8O8F6mM3ksbPjPUJHlaunYs34vPZRnfR2kVyeIY1ctc2nwCRcXJffZBsj5kB7AAvyH+F+znVjh0HFR7eFh657yQoURR4t5gVzWFMkjvACUxzHqFVQzNs+b1m60gGwpUeHbglHQs7GZgk7hqIizhuNxN1ViTCjAf8dJdVNoC2GLLkNkdIBdCKJpaN0TcP7bn5bq7u660g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199018)(36756003)(6512007)(6486002)(19618925003)(2616005)(186003)(4270600006)(110136005)(316002)(91956017)(4326008)(41300700001)(66446008)(66476007)(66556008)(76116006)(64756008)(66946007)(6506007)(8676002)(2906002)(5660300002)(478600001)(82960400001)(8936002)(38100700002)(122000001)(86362001)(31696002)(558084003)(71200400001)(38070700005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUJTMFRwUEYxWjZGUytkZEtEaGM1R04wOTgxcmRYV3VDbjNwTXJqQkZYU2FX?=
 =?utf-8?B?d3JheTZDczQrdWV5cTJwTkJpbWFPTU9Zay9HOW0ydEg2RXNPbzlmTk5CTHR1?=
 =?utf-8?B?Qm5DR2J5TWRMa3JiZUwvanducGY2K010RjRld0hoU1grZFkwdlNEOGJVMWFF?=
 =?utf-8?B?VUxudHQrZThkT3V5ajJWclJyMzBkM2NlMEdoclZ2Uk1DNkV5OE1BK2JTeEJk?=
 =?utf-8?B?YVpLU0JsdHgxbFdrNGFDQnhSWjk3R2dkVy9ld2VPamZaWmE2YjlKQ1pSaEZt?=
 =?utf-8?B?bDBIUVhPaG9XTHBrNUxBL0toeUw5RXJ0cFd0UzhRaWxSSEdQak04SmVoZGkz?=
 =?utf-8?B?WldXRUxoUlBGcEVpdDRmY3pOM0VvQ1dORGJaV0lmRUJ1RjZHZmdyWlVFM0RT?=
 =?utf-8?B?ZGhWYUxDWDNwWWtjelF2dVVWQzJiOGs2WTV5QnZsakpDc1k1MGo4Nk1VM2Qr?=
 =?utf-8?B?cnpkaXNkb2p1OU8rY08vZWxna3lZKy8zQlgyUzkyYlJBU0F3WEs5cERnOE12?=
 =?utf-8?B?NUlWeE9kQ0JhWHk5dWNJbHp0eTU1bmlCZUJWaHdOcHkvaWlJWUh1R1FvbWJD?=
 =?utf-8?B?blc4UmZCZ2k4V21vNlJEL0xxUEFlSGhGZWYyb3gvclRZZC93VndnTUVNTS92?=
 =?utf-8?B?WjZZT045bzNucHV1aGRKd3NDQndsVDM0YjFnQkcxUk5ySzRhZVVYWXJsZVpv?=
 =?utf-8?B?NHJQQVR6RGI5REthRGN1cDRDc013QWkyZHh2ckxUZjZxY1RPMzM4a2RmYnpi?=
 =?utf-8?B?M2VtbW9xSlBUVkU2NXVyMUw3WThHcHg3OGlaaHVuUEo4cG5wYUQ4UnNyL1pa?=
 =?utf-8?B?a04vRHk4c3hvclE3TEVXZ3lOMndXOEs3YjhPZHBmUlRvOUFFWXU5WWZBS0R1?=
 =?utf-8?B?VlB2OHRReUt1b0RKYWpjamgrMlYxNEF1UHJsTHN3dXVMbnNBOUZwTi9MbWc0?=
 =?utf-8?B?WkZ6aTF6NjcybkJ1dkNySUp2NkcwRzkrYUZlbktYaWs4Mkg3b09tcDg2RUM5?=
 =?utf-8?B?ZUdYbGVrM2RHeG5VMmlHWFAxeVpydVB4anNHVERaS0VmeGM1V0txaW9IUG9K?=
 =?utf-8?B?VGhzZzgxNDB3QjNyU28zYUJBcTVwRGZodU9ldlZkY2xmZ1Z0QUt5VkFDUW10?=
 =?utf-8?B?Z0VnWkppbElXNXpJVHBFUS84cG9PenFRcjJsU0l1TlozcDVNaXNBOThYSkFy?=
 =?utf-8?B?Nkx0a29JenVjcWNsTkNIbHdRM2xEYnB6QmcyaUpkd09scVlidmNzektXbENM?=
 =?utf-8?B?VzZheUVtZGdJdVA5Ujlad3lVaUw5WDdUWXVRdHY2cWRMd3pqM2djV25sUVg0?=
 =?utf-8?B?MWtidU03ejNxT3NOaW9EcXB0UFZQblZXYlRBa3RWSkdueXNMcGpKUjFtbWJN?=
 =?utf-8?B?ZHhYZzJnUUM0ckFDWlFabFpVdWhHSTNGTDNPY2h2OXVmSHVJcDlVSGVoRlZx?=
 =?utf-8?B?VVZhaHBxcmdJUDZFc0JmL3NCZkMwdnA4N0FkYmQwUjBKaW5HMEZqTXpPcUJC?=
 =?utf-8?B?Q29yb0tZVHZnMTlmeTZBYzBjVGw0TTh5WUlxaEV4bHkwbVRVcy83L2Fwcysy?=
 =?utf-8?B?UEdseHlkS0NwOHVUbWFGOVplNkZMNHVNV0ZyUUpzVkdIR3ZWeGt0THVqNlJz?=
 =?utf-8?B?MEtOV2NYb0dqbVNXb1c3U0xKcmxjc3NudENuZ2haZGxhWkR4TTJsWVh4dStv?=
 =?utf-8?B?eVRTcnl5emtqNmdHMHc0cHpxQW9vMlJwRXhnd0hVVjhKKytSazdlQUw1Tkor?=
 =?utf-8?B?anhKK00xRVE4MW5YMGRTQWFGSlpXS1dWQjF6b0hOalFYYnNYdkZIaGk5dzBQ?=
 =?utf-8?B?d2k5K2JkSnM4VzhIdTVsZlNCeEVoRVVsNnpPaVA0RGJabGZpT1RHSW03WEIw?=
 =?utf-8?B?Z3VCKy9RdXRNc0I1YWl0NHJEMFVrRmZIVVJvUVMyVWY5Y2pRMlFGRUwrTE9p?=
 =?utf-8?B?bFFDdjViWGlqK1BPeXJnY25wa2hhWng5VFNLc0REYWhabDFPNEhxcDZ5RVpY?=
 =?utf-8?B?YVQvN3BjKytKRkVDeGNMSkhSYjZ1MzBkL0V3OUlPMEhWcjF1aG9RbnphYnJI?=
 =?utf-8?B?Y3dGYU9LdmlOckRWSHVraERzcEE0RXlEWU9pQWk4NmVTOXVpcWNoZFcwODlE?=
 =?utf-8?B?aVpSQ2l4amkzTERuRjBWNklPTHcrNHlCRlJjaklUdHVSSHM5Vys0UVVRSld5?=
 =?utf-8?B?VWxLYkRrR2s5Ujk4dkNBMEZRZjdiVmxhYVV5NysveHBJcE8yWkZuZUxDR1Fo?=
 =?utf-8?B?N1huS2p4cXp5ZmpWWEE1RGErVnd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F31C3E929810C469C1010641F212D5D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TMucTf7qgXuwbommxRnuDccSTdPrpQJHULqYA+jboxhiuUJ7B3r6ZUqEkJwqieyjCc3KMd/53n/OB4jtjzKhqGWVSnQSSHo670FylNhilsyYqMCq4AxvBUwBlOi3qF1KuXoYuheuaYjwPkwGacT6/tWSsLzyK+93AlQsj2c+Z9JrwPj6htQJTn9LmTipIUqwA2h0IoWtFUvRTugQcBKK0XZJ+MkqDpqXfEMNYN51tyGXC0LSUDbwmyAYYCf86dd54UTYZ3OBKv8PjNWf3hUyi346vfkL+oc8HLGji/yDFZrjcFnhmxn8NGtYjckNY2snrzb2CBTSpsZPA1r5x5iuBqt4anp6+tzxpteqzPijJtSAsTL8t7zfAaDNbOvU+fp7djnSqcffsxtwRAlW82fH2tVLToNyZOfwuahhB/XmaUyRf2iwXZTSmDXLNOcPh+ZY8PLKglDeggu545Pkp0vVzbPleObzXsHg9Vs0IMeXlNn/y0NwgeD0oSKETSeMyepXaE3Oo9M5cHHz5YqYBYWi7GJDqe6lnMG6A8b4PlWlOqKGc5CbabDC0KkAKtqMvxV8wCWi5afN4h7cjVqOGspPudLvBD3RBhr0Y4J5wLxovi/pjVI9ihvayJ6gCjgv8VailQ3NnHJkMugmxTLH+GVKQ9tDSAl658n2cWZyqaCSxUlbdIwEFw7sVIm/VXuqXses0bTRLqFu/4jyrvEHJJhnqNJJCN4/j90NPmjfPX3NbvTNo+LktSjb9c7VQfx/Fx8S55bHVM6TvcCN6SQwHPJnDtdJKkT6CclXCabM1y08/JK+IrwY6825zsJbT2EYbt+IkyXvngoWR5+bqSG0QAJ8rlSYjLWvp2xC+vGCj7NREdvuK/maZC2R73acqeP2jrOV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec07699-c5fc-4e9e-adbb-08db1b299fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 14:22:58.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzryLFwy4zCrNk0TslkHjbAI9ffeFtgbXnt1eJfQ35hsNQsxAwX/TbOQW2lXYCAsYRvdJEF9D1N9U6jxTZ7L2bKPgMOsR6GRXSAbzmQdmgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7812
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

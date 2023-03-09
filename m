Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29A16B2670
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 15:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjCIOMv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 09:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjCIOMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 09:12:22 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAEA67708
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678371057; x=1709907057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CVW3rNPmRWWBp1tutM6p44VfGFF9LMlQYFRcS2CxmJ0=;
  b=ncDF74kGc5NB/n9tlzjuCvurMs1POA4s4WaGqRXjmO1hDhrpUCNN5CcP
   3r9Dp33lyBf6TCxX3ma4Jbf9QdHUv6XDQ8iwOGVvM7ZDdajj5HKnldYR2
   DVrOM5zLAYFFz7jq/yDWrSQJV4HF/zl8JaHAPRgIeoKetzeS4ROjJ4f6J
   4FpD5dsniWebLJOZAYSDRbtz+gu41a0DgGaroyJ+C7TDModavLX9Yy8n+
   rRjXrFVcvu3BtCUWJPbUY1p7rXUmK1HFGI9MQ7O++MwR/U94LOIWHqhT6
   3xyBLzvefDqpYu3A+wlqeyoJCnqb/mCVhoHskpwxs/dIwFs+yhLOn4pYS
   g==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="225233066"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 22:10:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj1FNIuPgPv0/UrsVoi1PRZkzJheWmZmcVEc8nyeLrck/AI7Abh0y2PZWdg1x6Fk032NloRfwxsioKGDbELhd0T9ATMiKGA40fH3J9+dAyuGXGFgDovMQzRfFoKHKd6nKVWo8IuGGu/2qDpWQQSdxFLVTGxZssFIF6pcPwgRPywwCAKe3ZkV/rZMU5IvleqMLNFK/DfBtxN7lOJbXeG719rgrwOLmGnccfOrFN4xMUN+xPepPb4Ije/ibWllWQ25eO3RdvPh5051gYun0/f6GMWfdTx4CErQBZQp1Hs0iM5PK7U/olwNM5utIs+9dMN1+Z6fctAApwv+hbZPMthIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVW3rNPmRWWBp1tutM6p44VfGFF9LMlQYFRcS2CxmJ0=;
 b=eXhuDkYNVjYz3acsG855JsEdEkY9Z5hAbd/zipzt9csKMYWtLtFjvmLI/LxgEJnhhtjINZMpMVuc9qDAo59C83DEpMptMCUTphZixLroMpyAmZ9WRPOx+N9xVQKmndVtXExGnDsqcgHFZaxWs8QTV6aUHtWZ0KpW8ZQhoLzdVKwYr8VP75tJyehj5KOMTL9P4+tQwCeIM4q5u6EpmBCW2h/bOcSWJKINz8wvSZbDzZTbzlXPqA23bLHmTudq90A7azHB8FwRJqnc/Z6sU0P1YsL2xgYX9TYkFvXN8bgkuOjbjw/Eo05ZyttCIxDU5SnLUnb9UKZ291dykMgioFL4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVW3rNPmRWWBp1tutM6p44VfGFF9LMlQYFRcS2CxmJ0=;
 b=g9l88STuI12YzjfFwJad83OpaKthr1OEqczLvBdDfM0cUWdDZ+SBzcs16r8jfxeMpLk/zW/v1s7SN+MgNUYyK3iErB5WqdREb8eB0WyuGOa0LKvGiMV7duGujCwSHGVxHCRpp1Kv6mn42igxWFdhjvotzApZr2Ke9ZFxHVqH5Oc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0919.namprd04.prod.outlook.com (2603:10b6:910:5b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 14:10:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 14:10:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 13/20] btrfs: simplify the extent_buffer write end_io
 handler
Thread-Topic: [PATCH 13/20] btrfs: simplify the extent_buffer write end_io
 handler
Thread-Index: AQHZUmam+IefLSYrNUuvPrQtwXtUp67yfRkA
Date:   Thu, 9 Mar 2023 14:10:51 +0000
Message-ID: <7b12d1ea-79dd-211c-9eca-84ff453e20e5@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-14-hch@lst.de>
In-Reply-To: <20230309090526.332550-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB0919:EE_
x-ms-office365-filtering-correlation-id: de36017a-4cda-4908-3313-08db20a816f4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tXZXrd5m+sHOUV0mEXs0xf7FDswABcKjzO4v9JRDTTD7V76Lqt1FT6h+zlT7k1lnKO1bY4q9QLm6WMuZ3sj94HUuf7Mo+cQ3ZuymTpgEGEaa2ukAKe8TQsaZHCvymmDDnFUMK/UqHTwcA2VGjMYstM6nSlpbC8eKm3fap388CCcjTd/LfcjamWH2KVaSxmKvSlA6HhW8EtXVTtqAelm16oj9q5gdr10hHvAmqsX6tjwhj10K5jM5ZEftb/9mgrSWmsZ8sINQRNWEcmxRumrpSSg60/jI+PLa29j5/KgS8rFtqieT+dBl0DjqmCgTjyON34nqbRIMQe8XHJn/XF7/MucYLZqabVyV20HRS1dLJFfl7L5/kckvRp2mt3Nf2+NepiOf5Z7Fqo5Ztr5eLYfxudooGFH9WxJRTH5XGwyKR69ul+OFBetTcS2Rvoz8+7wOoNVAjS/vBY/35omaOhmcA6ZO6kfgQbO9y8EVh9WDiNUK7C7WJXwuwTY/6GWYBswVchGswnv6sIFbTG2U4vuk8jg1QYUe3oUnzRhNx2z2t1iWupH0lX40fqf19nI3ZhOu7dVJwIEL7uKp6wHUlqhGhvxnH0Bzc0fOCN8Gm5Zbsj2I1Os6KkolGpLhy12t3E0CrTDDV1eRDdOcPYk1hbfVrwcM/UyqffVpY9MWlGGGeAlkbC8zMvRhInBs7ppD9hm25108Jzoj7dNHXShnp9NdiR0/r3Aat1sheUutRL4whbpFW0TVywrRuzMvxqpWUp3zQwTjKosnJm5CdcHBljOe9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199018)(6486002)(6512007)(53546011)(38070700005)(71200400001)(26005)(186003)(6506007)(41300700001)(66946007)(66556008)(66476007)(66446008)(76116006)(4326008)(8676002)(64756008)(4744005)(5660300002)(8936002)(91956017)(86362001)(2906002)(31696002)(36756003)(316002)(478600001)(110136005)(38100700002)(122000001)(31686004)(82960400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVVGaDVEUlVYMzVDYnhCRHJQY3A2eDBjbXJGOGdSSGtNSm5mQXFZaGdkV3NZ?=
 =?utf-8?B?QjZIV0srUWZ4ZEtuc3hpYjM2MUpzc3J1Y1o0ZTZHdWFaZEhCandyVWg3SUps?=
 =?utf-8?B?YndCQmFlTTQ0MnloT1h4Q0ZHSFUwcFZXOGFLbi9LZ1JyUVg1VUtuUGRuSTlo?=
 =?utf-8?B?S0U1ZGQ2bFZ1aFU0OWErOStYU3NuS05acWVFVWk4ZUUwaXJLaEdGSXFDQkVh?=
 =?utf-8?B?MkhGaW5XS2ZIeHAya096WmZ5OG8wMnFSMkxFd2VUUTJmVE1XU0FzTDBqMmZ6?=
 =?utf-8?B?UEJaNUJwSUlVdEFZcHVGT3RVd0VpVURZOElGOTRRZThvb29GdWp0RjFFRjhm?=
 =?utf-8?B?SS9PZ1RiMUdEcEtxemJYa3QrNFdNV2I4M3NVRGc4OWkyV254ejhzMlN6dFp5?=
 =?utf-8?B?VkNUUXBnMnNzUDM5RFRPNFFwMHFtNEV4eHJxcGdKYlFQTU51ZkNsMHphYk1Q?=
 =?utf-8?B?Nmhub0dqTUdHZWxpUDRsQzF0eVdMNDRJU0E4eDVjRWs1Y0hEL1ZZR2QzSTYx?=
 =?utf-8?B?ZkFHRll4VHRITkxDS0JPdGJWY0tWZmdHMks0Ny9CUWowdkVadTZWZldmM2JO?=
 =?utf-8?B?cVlEc3Q0SEJoQWc5SVhnTXk4OE81QUZmQVpLVHNlLzNkMHFvYThQKzJabVph?=
 =?utf-8?B?QjdkcFRNQXFnT3k1ZFFpeXQxWlZxdDVvb2lUUCtNYjVxc3IyYW1Rdk1ySzYy?=
 =?utf-8?B?QXZLWEVoRWkvR3pCRHAyWUo0UDJEcitFdHZuTmE1ZWJVblFJSnlwcFo2THlQ?=
 =?utf-8?B?QjdRdjJUQm5RVlNNS29HMEo0WlY1V1haS09SMDNyV2NuM2R0bUxocG00L0px?=
 =?utf-8?B?M0ZpTzU3ckR1MENvc3A4dWRqM0t0Z3hLSVplQVZ4SGM3TzAxVEpLUlpLSWk4?=
 =?utf-8?B?TG55Y0ZKYnJqQTI1YXZ1TlF3b2N4OXAvWlNoemsxMTNZNWc5ZjA4dGNXcjVj?=
 =?utf-8?B?emxsMlZ1VnhrcGdkUWhleHpmOURzckxmT2gvRUpVVVpFb1IzcW5HTTdneEsx?=
 =?utf-8?B?ZnduVHdSMGlGbTR3dHVmUnhKSmZkYnZrWUk3TXhuamRqSW9wWVU1dVhHUm1j?=
 =?utf-8?B?ZHJRaU5GYTZPeFZmcnRFcUpxelZNMVdkeklrVWJWL0RiQkh0RVV0RzJCTmRQ?=
 =?utf-8?B?Nm5UbEhtVXdWQytBODhjYmdMRnpoZEtPMlNRZGdWcnZaRG4wM3VWaFUwaG92?=
 =?utf-8?B?S3pBUDJzbFVBenhoS1o5YytKeHFNQkZod0VXaGlJYXc0aEUrT2t2RnVpZFov?=
 =?utf-8?B?Ukl2MlRXZll0Qm1ESkorUUhNNkpibU9oeVoxU2lZUm5JSjhKT05rRUM1QlpQ?=
 =?utf-8?B?aWVlZXZkTlZOR0I2K3JaS1pNcTNpQ2x0VEhHZ2pNOXdVRWpIMDVBTGU0azUw?=
 =?utf-8?B?SFBNWkQ1ay85aGlTb0V1ejVkOU9Ta1ZidWU1eU9paVJFdzFsdEhiU3E2Slda?=
 =?utf-8?B?K0tTQ2wycTA1YmdYc3VUVXc3YWltR1FnU21LR1h5ODRsTlI1Z3Q4UE1xYk50?=
 =?utf-8?B?aXJLUGxFVFh5ZSs2UldLdHZGMzZwbTZiYmdCTzhWOHZPQkM4bTUzbTh6YWhw?=
 =?utf-8?B?cTQvU0tkaFF5cU82eHBrNXZZSXBRWkxVMC9uL1FrYjZjYnRpMGZtY051WE5n?=
 =?utf-8?B?MTFuWjg4VW9RRGtCTVRlSjMvWjNZSE55Wk52d1crZHhGN2sxVnBTNDB0S09O?=
 =?utf-8?B?NzFkYVAwNjVhQ2JKQ25SYndlK0FjOXduTVBIV3laQzZLbnUyTjlmc1dFSkp4?=
 =?utf-8?B?cHlRcFZuUU9kWmxEQzJrbEo2ZGVBUE1hdFhjdUNHNG9ES0JTdGZ4bXN3ME5z?=
 =?utf-8?B?bzkwVzJEYXMvcUZ0THFMbVpJcDIrYnJFcUdycC9sS1ZKSGY1VnhKTXFMbmpI?=
 =?utf-8?B?WjF6THM5MnBmUDV4dW9HTDdQTTBHd1p3NXpqQUNrMGEvSXlhVHNlQ1h1TGZ4?=
 =?utf-8?B?SFhhTTh5clFaazh5dEYxMHJZTnczaWtGZHpMZ2JHU2l5cXZoUkpINHZqdVJZ?=
 =?utf-8?B?SGRWazFyTk12UjZFbVJyTy9aVjVLdVFzTFV3cEdaRHZNNHg3eUM0dHBxUVdB?=
 =?utf-8?B?VXpCYURhRzZMK1NUdnJjOEZHbzN4aXJhRTU0c01CK3RxTWNzSk1PR0pQZVFh?=
 =?utf-8?B?UzlkWWlEYmlNVEltMzl3ZEJiR2VIdlI0dTVKUWdzajFaZXBMVlFnYkdYRjFS?=
 =?utf-8?Q?54fu59EJ2XZjv3mZq8HuFHs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F71A6B1D502C5340918B86871965C681@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: klXrfxWxjr0KaPPlAEsrZVt39bt0qNuVUc+9LdpmJ4R4STNutvw+52RZltJiVxYcLg0FdJnsiXQdkly9Al3oJAzfFC/aWzL+z+nJH3V0Ets7GqkYNbhw0gFJ45QcUm5fjWYgDpukKfabojOUhQ46hYN+s+UHrl5EOQR/CjiLHxrJTRn7hVcz/vYvF33216Lt17yVLGiFvaDC5/VQwov1PKBYhTS4qlRqt2+4UIfsOzuKIYITjaSZoZDDGgrlqaQ33u6xNvSI94qzT+YvhLF48GDSfXaRoAfREw3pl3Mnu7NXlBg20k9BQ/YGftrCBTa2F9jku+3eU6sU4UfYTcTNwFzb3YWHkiSTwJ88eUsht9mo5NkLRbi5Kq+vsTKX63BeGJM4KLsCnCy4LHZuk9qMufWf6hrufeSXGnuHZYNrvQ/lnV6qzuH1xdxy3BCPqS0mpTAhBlV5ENzKtOrf772QoDfNt7OYh/caQpv+0aYEfYsN7ZnKRMEp7MNN2VNK5cbNWyaWRneqTGmU1GxqZUqEgnsJMf0hhEOueJCmWDc0bDmRQfTB3osRZ8/I9WxDszckvoOCY8nOKdiU1WYy+nNqpInE6ye5v1jdC2lcuUn7h9JrAOw0pUyPy5DQ9S3t2084hsG+cNxsnboKoasbCuuyg5LyprTjHM4asZT4EVQKg2QccftuK9luz+w8t3RnR6mVk1piXnjlOZpxIs4J34tzE2KVMMx3hNSFqM+qt4Lh5UMYBqNEl6Uk6L9CG28dEXvKwuqzUZLqy2ioPp8iLmjauQPI4VBMYinlI0kd/KxiCjF+F56MqesiWur8bPFq8aUak7Qh3U1s+lMQNBJdP3ScPEY+AMX/9MuEsI5CROfZTEM4U34urjxRDjoE53ZvXtT6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de36017a-4cda-4908-3313-08db20a816f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 14:10:51.4285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+/GfS32mc+dNjuAiHDFwXuvHZmYL8dN3m3+L/mAtWrPYDInP2Om4pe4JEBzgWyo5MJDmsL2rjzPp7YZBc9fAjpecALiZEse46zpIkihZtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0919
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDMuMjMgMTA6MDgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiArCQkJYnRyZnNf
c3VicGFnZV9jbGVhcl93cml0ZWJhY2soZnNfaW5mbywgcGFnZSwgZWItPnN0YXJ0LA0KPiArCQkJ
CQkJICAgICAgZWItPmxlbik7DQo+ICsJCWVsc2UNCj4gKwkJCWVuZF9wYWdlX3dyaXRlYmFjayhw
YWdlKTsNCj4gIA0KPiAtCQllbmRfZXh0ZW50X2J1ZmZlcl93cml0ZWJhY2soZWIpOw0KPiAgCX0N
Cj4gKwllbmRfZXh0ZW50X2J1ZmZlcl93cml0ZWJhY2soZWIpOw0KPiAgDQo+IC0JYmlvX3B1dChi
aW8pOw0KPiArCWJpb19wdXQoJmJiaW8tPmJpbyk7DQo+ICB9DQo+ICANCg0KDQpDYW4gd2UgbWVy
Z2UgZW5kX2V4dGVudF9idWZmZXJfd3JpdGViYWNrKCkgaGVyZT8gSXQncyBhIDMgbGluZSBmdW5j
dGlvbg0KdGhhdCBnZXQncyBvbmx5IGNhbGxlZCBvbmNlIGFmdGVyIHRoaXMgY2hhbmdlLg0K

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E56FBBF3
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjEIAWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEIAWn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:22:43 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC9B49C2
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683591762; x=1715127762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nNVkMC8TjzNi77ceMLGVa1Q9ixPwfH8Z2l+auyw9e28=;
  b=LZVNuTmIZ5TRrkbUb8vRCSt8SNKT7racowf+TfoJ3l4V/IBx+3FKbG4v
   HeCRFsnNQg1OvlVjXQ75b9eKw7/7TVRjTvAdWTBXugUZkVuIsWODEgzLe
   YGQoG97KyRAWSxHxfwS7z2wnX51XgNu3+rZm9+lrKa+SW0cXSaJj+1YtZ
   tqz1fZw/6NdroYqGFB+QYdcqCRFKXYSHAkw05Rvr5Rnu2szkHWpoH2QVH
   k8OBMBsamNvoK500oDknUCka6ymQVL+Nbtq4BHZv8XidOJr9RBLiTkQNh
   7AlSSP+f2LS+RjiN/xcbBQhqcMjatOtkUS8Fraj4u45v1utgFIHWhAugL
   A==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="342233929"
Received: from mail-dm6nam04lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 08:22:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KABtwaRD37BtO7leE7ctDkUZ4QFaTrV5Z6aUEOUc5RvSZgHHNBI8wo0HvHcz0k+Grjl6PrMrhnZ2ise3cFcHActU3i6NiJ1pVLeoeUO7bhLbgl7XPFJ8+4xIa3x0O7T1r2XpUZ7WtbUhfP5lQd42Znm/Qh6eoPnUCrLJvdEEMPTTRLTpLBvOmx8QRAtHZtkxmIfvCmKVsRJKIba3g5378hORem2lZFBHo7NV5e1NDaLN1B/JzZY0/UqCeCzf7HT7vpA07VCIc1wcrgos6Fw8sFPEmC4RrgsEPUwlZgYUJMdBs4kJZcyxRZqVhtdzPHguYELekXBPSlrqANWIBkVwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNVkMC8TjzNi77ceMLGVa1Q9ixPwfH8Z2l+auyw9e28=;
 b=Q8WqMMJ4M2oUmgd7NyX48U1Bx3+4EKghsd+HYpZnjYWNhRSj/InVMw02ps8XFAD+2TZWj8IokGWvW1mv71DuP6Xg1ak72DB9gRWdIUSUf6ffMiyIlBNdTHi31EARAw/jgAn74vyCk6rSlSISM9Oszewar5Pa1QM5qq92vH9qAQlesKJfmlJw0MMJTcQqNlF+U80Fj7asSPCvYHliVpTRO/kK8cAtBKOT8+ro9AO0XkJ+XH+XKSxnoFG2cjvPNs5cBEb6k5fYe4jkCrfXIQ3TJ9pJhEmWdtelimPb9AhQv9qi6Drozns4IWNlIaN8qEgRP3HiaIDFbOZfnkHTBfIeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNVkMC8TjzNi77ceMLGVa1Q9ixPwfH8Z2l+auyw9e28=;
 b=nxVmnERR6fus1RFZmdW54eQb1ENWTWN7qwHbO11vECjNZwPFMCyeQ5MfQfV6trpZXNnIuN503uQOyHSqFNFe2+xiM0PZsdUS1bSlpRV9++4H0VnRJL64KsxbKPdL8/XM0vnU3EdUgKasUVC45Q0UkAkK1w1pEAYgrbRkw1GqtFc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7477.namprd04.prod.outlook.com (2603:10b6:510:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:22:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:22:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 17/21] btrfs: add a btrfs_finish_ordered_extent helper
Thread-Topic: [PATCH 17/21] btrfs: add a btrfs_finish_ordered_extent helper
Thread-Index: AQHZgceIifkPzbqs+U+VkpucTf3H+a9RFSqA
Date:   Tue, 9 May 2023 00:22:39 +0000
Message-ID: <c850eb49-2e63-ed20-c987-4ff5a406f851@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-18-hch@lst.de>
In-Reply-To: <20230508160843.133013-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7477:EE_
x-ms-office365-filtering-correlation-id: 4f2922b1-6a8a-47da-13ac-08db50237fb3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNkWVn/lrvdB24o81W27YlsjNaG2BdqWoGXOVQJnY0Fv6guqNQgwg79B0phYVJvx2WFTozJiueG+BUZGa1zr7sogv4PVp4Q70Hq1ys94Wr8FRDNYYraUg3r+sfnZbYiKpG9mJTID8ST2yVV6EiAWaNW+tB209BNUyp9s+0rXvBBregCLcI07cfmMcOYtVLaVHZgh+mwmruTtiwgGO88sj1YRWfOBdk55JSFgLiOcjdCwYCYJLu90zHxZISlnDPulnpzLp8iGS4MH+CYVG3bgGt1orNR5QawK+U2zdnlpAboSDhmgjtjny7tXKXiNrAXgT7rpD0k4DsY8KcVIP0g9HTcdBBS1TVfd2OeicS6i2+ij8bS7SQsLKkich+PmXYOgwAdZr+dx6RWtcBaXyx7HOBlSgeAlS3YAsOlIuQay1isPtFTPMfmsfcX86Ji+yMrTZwM4yHePdkMxuIT93QSidV7a1gnq6QaqGIUM2wAbxMI0hZYadTQ8qbrlVNl+ql5fF5Z7G2eDch9fxXfRyCPi0MpimWWjcV6i+5kdmCW31lMpurdm5Be6bI/27ZnSlvsJRhiQGBOweHOgccv5fLyj+lW112pRbdceoeHIOvn024gVnikbng6GsRS0sfQttqv4MXBJYiqS6NZ9wIgygMnSmgb31TwOHFfUWzcPoCXByiu6szuE/NmIy8rGqJ6aOafL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(31686004)(66556008)(66476007)(64756008)(478600001)(76116006)(4326008)(110136005)(6486002)(66946007)(91956017)(316002)(66446008)(86362001)(36756003)(31696002)(83380400001)(53546011)(26005)(6512007)(6506007)(2616005)(8936002)(41300700001)(2906002)(5660300002)(8676002)(82960400001)(38070700005)(186003)(38100700002)(122000001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1JSaDZZcmIrWkMyZGg3ZHJsVnF1UkNocnFITndBakR2Z3dVdyswMFZHeksz?=
 =?utf-8?B?M1B2V2tZeDVPUmVObXVhZENzTDVkcG5YUENlT1ZTdjFaTTV5RkVUb1ZlR3FY?=
 =?utf-8?B?eFl2QmtsQmY1bFZEQ0FFcmt5dnlSSXJSc3pBc2xiK1JhVi92TkkrMlNPWkF6?=
 =?utf-8?B?aTlrWVZpbVhuYVFjcTZaY3paSjZzTk9TMkxQS29nZVlnbTBYa1VXS0Y4blZX?=
 =?utf-8?B?YTBWSDhFU20yaWxQMTNlWXJ1Ylp1U2lRaWN5ditpdXp4ZXZQNk9JS2QxVkNY?=
 =?utf-8?B?SHI5SlVwY0JkdVpabTQwTXljVHNVcTU2WjlMUHNsVlNyc0VKaENnN2lZRTB0?=
 =?utf-8?B?RjBuUmtmRmd1TjM1aTE0V2xLQk5FbDE0Z0JyMy96WGRjRlFMbktiWUFhK1Ro?=
 =?utf-8?B?dnJwKzFmVGhuWXNoWENnMlYwQlVFRlRoWHI0WG1aTUN2UGNocmYrOVR0SjlD?=
 =?utf-8?B?ajQ0cThTYU1qenZpQ0VJam1HNU1TMnNWOGtpSEVYRHM1WFYvL2pZaXpHWmd1?=
 =?utf-8?B?TlkrL3JzUHlXUmxwQTFVQi8yM1M2d3VkNGcxTGJPbFpvdXFvMDhUTkxDMmVP?=
 =?utf-8?B?ZWYxdjB3Rmkrb2ZzZndEK3h6RHBQc3BVMnFqbEZQaStGVXVpMlMxR1N0SjBs?=
 =?utf-8?B?bEFaV1NDalFRNlU3V0RkK0MrZk95dkNsUDBsNHhtbWJRbmRBMWpXTXBkRk13?=
 =?utf-8?B?LzN4Nndmay93eVhjSmtVMXV6aFMxOGJnMmJ1S2dQRS9OUkFPclVZVHQzTjV3?=
 =?utf-8?B?S0RncTBQRlJEa3JYQjZacTVRUEVlVkpYcWkxQlR5WmN6V0o3ZnZ3U0RmS1g5?=
 =?utf-8?B?MlhyUjluWDFPMW03anBFQ0d0Uy9XUEV6bU1xSXV2MkVpU2ZSZWI1TjVhckZC?=
 =?utf-8?B?cE1oR2RSdVZXaEpTQVpZT0IxVkd4TndpMVdGbXpRK2ZzMGZBK3FMVzVseS81?=
 =?utf-8?B?c0xwRHhUekZpNldTY1JlZ2FxSnR6clNGV1ZjYjhJcHJhR1ZsQkh2RjBnV2dO?=
 =?utf-8?B?S0t1N05KOGpUN3JPSll2QXdLdWpveU9MMXgySDUzMFM3Zk1lN0R0ODUzSmd0?=
 =?utf-8?B?SGhNbXh6a0I3TFBzdTV3NEpWalpsNTFmWEc3Y2FvVk1KcGNnM08zN2tXKzdQ?=
 =?utf-8?B?N0hlRXIrN0F0SUZSZHpGN1cxaDdvVjh0UUU5VFN4SmFlYVJOekxVdXJQTW5H?=
 =?utf-8?B?ZE84WitZcnl4UHM2bURZVFY1SjdjY0VZbVpQamZIOEpoZTJ4ZVFkT0ZjZ2FG?=
 =?utf-8?B?Vlg3R0psK1Q0bFplcDhSUHlNam0wWXNZSGZtWDd1dlRLZXVBYjNLbFR0c1lv?=
 =?utf-8?B?d044dlNBbWgwU1RHdFZjUUs3QWJKSjNvRTRGdGM1WU9aTytaTkUwUlIxVXI3?=
 =?utf-8?B?MGlFcFJuN3NQVzI2SzlXV2tvN1pqRU9PZVQ4bzFSNFRlbm85UXlLWDVCeHFs?=
 =?utf-8?B?Tk4zVUpBSm1OUUIzVWNiN0QzcjF4eW9sTkJrMzJ3bURINzVlUDN1SHdldjg3?=
 =?utf-8?B?Y2lSMGlIRUMwemo1MmNKQ1dnZER6RS9TYVFKaDVlUjdqTTBzQ3Vyb2lEQXk0?=
 =?utf-8?B?OEVuaHJoWko3QmM0Rk5wNjI3L0sxZzZGS2YrRlVTem1YUHVWTGh3d05rVmY1?=
 =?utf-8?B?VExOa3VScFEzVDdOWnFQOURGU2prSS96R2JEOVpBWUMwbWpaNXZLUkJtZkFP?=
 =?utf-8?B?NE5TbnVYWUdHTTNRenBwRGdSRi9NaFUvNnArZU9URzlJNFJxcDhEcVJGVGtV?=
 =?utf-8?B?Y2ZOS3U5amJKcXpGV1FBaVJXY2pzYzZOTStmR1krdG9nVzNwQU83bFVJaHVH?=
 =?utf-8?B?MlRDSGRMQndQcU5DVTdPSDFXWU9WUnNxcWpvakoxSGZsOWpWSXgvU3lYZUZp?=
 =?utf-8?B?cExiTEhWYnN6N2VkTmExelBONFdnUEVOdDEwRWFRaUJkUkJ0MElTNWw1Q1lj?=
 =?utf-8?B?TThOS2V0Y0RHcEZLdTZlT25hcUpxOFhtdFI3ZWJwTUhNd0NJZ3hQU3ZrSUZw?=
 =?utf-8?B?aTd5VUV4VmQveCszZkdJejdJcWNJbXN2NS8xYVd5TlNVR3FIemJoMi8yV0VL?=
 =?utf-8?B?SzZMa1dwSk51cFJ1ZkhhWkxKcy9rYytidUZUV1piaWtHTWdLUEk4NmpoR01U?=
 =?utf-8?B?MzZtSXpJVFFFOXdGeHVRY3MvdTkzTGNCa0ZaTGV1amFZdjlzRTdVR1ZCS0FK?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA049AC96C29EF49A73753D9DE67B5A7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7que+n1Uj2tQLqz/DPXJra1/V8lh/zIRHa8tNn72YqDrfEC7IT6vcM81KewdG44ztMZXjbw8QJXkPGzwN7bJb5nkPYk+GdTSfZTE8DyWsA6OZseof+G3qM1OFliojUXrwp2Ng1g3Xq8KUiYMydQueBfQTonunuTjypMXcGBjy/jPhJrPRum0F2EbzeK7kYR6BqbiKJzbNdU7r0FffvPD1hNNXqpUb8HO1Q7w3dANv1q0RQM5zUW8iZbINRI/VLYalGoc1IZpJb6g+HqsMAN5URkqYGzK4geurrfKBZkNjFm5tf66NoaxepN+cNs3Hb7u2Aoo6RLacUgRuCDOKizYs/EaADGO21Gk93jwyQJbfNvm6Pe2fu1YcTk5AfUOlXRqpNcuYEhK1Lbt3UxahP8uGzZLbOnC3j3GX0Kh1X7jAs4ZJdiIcb9PGQpW+PiaflSuDMVTL/o1fdLnEr0eTiUkTqKrj5noZQe3k1Jn7TvlTXnEZjBTbzBSm1qGfCxG+dw9jC7QgbyVYWzacEkpKbiClr/S6xFDIhUYstZDg7oa+WYAz5EWHgH0f3DDkQ6y5xrIJ0xu4n5H9lATJEScbDc8KnVybrD67LnRuUDIWYmYwc12WWxV9wqbrTE2onBawrUq99qHg9KXmLPkI2ZoZDE1Z8il9sc3s+2Msnanyu71NNmYkpaZCGTSmqtN/6Xx4eapreNQxcIt/W0PKWTnNSEMsnh5GEb7fSWrZPjMvJTxthyhdfXx4kpRBjpewzzWkjaudH8agVUmkgr9JMUGifJDyPYqZP8RTogrOnJSjzmkZmWIeHrsYwULFySeDYgWzV/pvuU0Jpkc46yqV5MdOfBXqc2KZY0ASwPgJz6BkaIs9WwE5FHSnm4JapMaCTWbRLl+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2922b1-6a8a-47da-13ac-08db50237fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:22:39.9293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZ3ARJA11/bk+Ic4QyXOJyKtwx1wsQm/p2OvEbPsAl7YenFP1V8ciJ4eMmY6kUWTllGSoibbzVSqc1FMS3AXI8ibu8NsFqBLkGJgWiqwJ2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7477
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDguMDUuMjMgMTg6MDksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvYnRyZnMuaCBiL2luY2x1ZGUvdHJhY2UvZXZlbnRzL2J0
cmZzLmgNCj4gaW5kZXggOGVhOWNlYTliZmViNGQuLmMwZjMwOGVmNmY3Njk5IDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL3RyYWNlL2V2ZW50cy9idHJmcy5oDQo+ICsrKyBiL2luY2x1ZGUvdHJhY2Uv
ZXZlbnRzL2J0cmZzLmgNCj4gQEAgLTY2MSw2ICs2NjEsMzUgQEAgREVGSU5FX0VWRU5UKGJ0cmZz
X19vcmRlcmVkX2V4dGVudCwgYnRyZnNfb3JkZXJlZF9leHRlbnRfbWFya19maW5pc2hlZCwNCj4g
IAkgICAgIFRQX0FSR1MoaW5vZGUsIG9yZGVyZWQpDQo+ICApOw0KPiAgDQo+ICtUUkFDRV9FVkVO
VChidHJmc19maW5pc2hfb3JkZXJlZF9leHRlbnQsDQo+ICsNCj4gKwlUUF9QUk9UTyhjb25zdCBz
dHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLCB1NjQgc3RhcnQsIHU2NCBsZW4sDQo+ICsJCSBpbnQg
dXB0b2RhdGUpLA0KPiArDQo+ICsJVFBfQVJHUyhpbm9kZSwgc3RhcnQsIGxlbiwgdXB0b2RhdGUp
LA0KPiArDQo+ICsJVFBfU1RSVUNUX19lbnRyeV9idHJmcygNCj4gKwkJX19maWVsZCgJdTY0LAkg
aW5vCQkpDQo+ICsJCV9fZmllbGQoCXU2NCwJIHN0YXJ0CQkpDQo+ICsJCV9fZmllbGQoCXU2NCwJ
IGxlbgkJKQ0KPiArCQlfX2ZpZWxkKAlpbnQsCSB1cHRvZGF0ZQkpDQo+ICsJCV9fZmllbGQoCXU2
NCwJIHJvb3Rfb2JqZWN0aWQJKQ0KPiArCSksDQo+ICsNCj4gKwlUUF9mYXN0X2Fzc2lnbl9idHJm
cyhpbm9kZS0+cm9vdC0+ZnNfaW5mbywNCj4gKwkJX19lbnRyeS0+aW5vCT0gYnRyZnNfaW5vKGlu
b2RlKTsNCj4gKwkJX19lbnRyeS0+c3RhcnQJPSBzdGFydDsNCj4gKwkJX19lbnRyeS0+bGVuCT0g
bGVuOw0KPiArCQlfX2VudHJ5LT51cHRvZGF0ZSA9IHVwdG9kYXRlOw0KPiArCQlfX2VudHJ5LT5y
b290X29iamVjdGlkID0gaW5vZGUtPnJvb3QtPnJvb3Rfa2V5Lm9iamVjdGlkOw0KPiArCSksDQo+
ICsNCj4gKwlUUF9wcmludGtfYnRyZnMoInJvb3Q9JWxsdSglcykgaW5vPSVsbHUgc3RhcnQ9JWxs
dSBsZW49JWxsdSB1cHRvZGF0ZT0lZCIsDQo+ICsJCSAgc2hvd19yb290X3R5cGUoX19lbnRyeS0+
cm9vdF9vYmplY3RpZCksDQo+ICsJCSAgX19lbnRyeS0+aW5vLCBfX2VudHJ5LT5zdGFydCwNCj4g
KwkJICBfX2VudHJ5LT5sZW4sIF9fZW50cnktPnVwdG9kYXRlKQ0KPiArKTsNCg0KV2h5IGNhbid0
IHdlIHVzZSB0aGUgYnRyZnNfX29yZGVyZWRfZXh0ZW50IGV2ZW50IGNsYXNzIGhlcmU/DQoNCg==

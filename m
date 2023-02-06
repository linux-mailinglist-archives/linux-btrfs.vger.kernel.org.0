Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933BE68B754
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 09:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBFI2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 03:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBFI2F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 03:28:05 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67CA83D9
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 00:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675672084; x=1707208084;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=H3c1wXYxSoc4qcagn7Metwlo1GxZQpWTP/EXAYGi+iM=;
  b=oan2EELMCkzT9BhfHv+7Mr1GgRT+y+XtKiTz+0m3ef3eSWyXokWrYy70
   TSLJqOCHr1j5syq/h+R/EtMq2kyI6XYZPNW+uifH6PwUSfxc4usTyI99u
   mB+pltkHVtI3/7uQc4xwUWrmpAytwrNX888zzAXKbmzGWBQtBPMTCf2Vp
   0Wfm/6wGAtVFYajcGPYq4t/6XbS0U+TtTyymfZ3rrgwRT1ZMSzZ6yBK4g
   UZax3BmaydijJ9JPC0z5gqEFQd12lqF+fbDuUdndUEMsk03gkZC+Hm3wu
   c/GXpy9j3PZhs3EzL2rqG/DS01ouDyyDSzJYY6nqZIFXPHFpnnoHoQXMH
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669046400"; 
   d="scan'208";a="227570425"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2023 16:28:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNI7pq8/j5TJ1lWy4SoiTxqjk756hGhySaPCrr1wP+x8OJZe40EC59v2yHjixSAYMR50Sg0HczA+g91mF0miI2CgiBmFlsGA3cCFqx1owmmfJfJmQHxgLsEntGlgn8a451jQeIFRiesKNCm+MZmp9nPOqn6zLhjjFZ3kaCh9kGob+kyIQufKbGlN3VB8PsPPC4XIw7XvTeKdTkW+2+gkrRwizsgqO+/BfHqTd/hKRU2gcZ6nWlT0mET7kCFmIaltdID4KMlc4KWmhyvBC1JlpzrD8Q/94MY5+YO3G5Od0NTYzTZgvloqCS3UPnD1I7qWfyL8k6kVcT8bO/+w+bfY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3c1wXYxSoc4qcagn7Metwlo1GxZQpWTP/EXAYGi+iM=;
 b=MwUcV5J03C3nRgzgnnY08zwgksRg8jaOHLDZNYw2lq6diJVKNry99RNFDkkBleZL+XWaUOUbp42qcT9rIhQvOMV31xLxg+k0v4MuSXtG8bwKyxnpP26rwV5VSyvTJmfDPSymiruVWBIMjHbomoR91yVM9W6C3Ty6rr9l447Lx5v7wG4tGmruwvc8f/Xq1Ha6oodTlcp4a6Ad1zHpunL4h9EVuj7QGs2ADQSah1HQ8RdCS7kUVgzmmJ6MWXpudmlDe+vTv9vnpn/bRQqlj0TGvxVd3eGzQDwZhePfEQRmigbsF3oH2Q3jvR87vfw295oRkmrpFfDjaWhxXILxmsfKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3c1wXYxSoc4qcagn7Metwlo1GxZQpWTP/EXAYGi+iM=;
 b=PiXVZ9UDLTXHYPM7HLFiWsGlxLtbKTncqCOa+NByWLxzusd/Sb3HEdM4HVlTrtNjvVmrNuvd2fFST7RbWVVL7alj5/cHOxRyXEJpFralbnnS8UDkZsb6pheJvPwqhhN2QNa5ZLLKUEUgCE8VD8SKTdFQUw6jMHOiA/fxpqKm/gM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7631.namprd04.prod.outlook.com (2603:10b6:a03:326::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:28:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 08:28:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: remove map_lookup->stripe_len
Thread-Topic: [PATCH 1/2] btrfs: remove map_lookup->stripe_len
Thread-Index: AQHZOT9r6K57sQLhwUek5dODckeiSa7Bl1qA
Date:   Mon, 6 Feb 2023 08:28:02 +0000
Message-ID: <a08c7ae8-b31a-55aa-fbd4-9db441c0c416@wdc.com>
References: <cover.1675586554.git.wqu@suse.com>
 <0da7fb8df029231aa8f65dc1d0b377e9a91f91f5.1675586554.git.wqu@suse.com>
In-Reply-To: <0da7fb8df029231aa8f65dc1d0b377e9a91f91f5.1675586554.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7631:EE_
x-ms-office365-filtering-correlation-id: e4a98140-5c67-43db-9ff6-08db081c0ff3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FT91h08vxf9uTzOVr3tAGWDsYbFg2id6+QeCUd+O9FBslkrzsGfQ79bPw+OBGSAN0VZFD+hkEKSGFuSI48CgpkRiLWuTDfzA8PKoV+yJ7yWyD6UpRs9per4vvjgpwk8jBy+bw5QStyegNkpxDRA5QcfsMhNTJKSGNyDRyMH7JnFa9k3O195rPsAv1fgHz4JzO8HgNgVOE08bz8SjuZehE0JzInqv3u09bCn8aRnfbDdYIto4vZVdZK/3Lzk/M824nKy4lNNs7+H2NYKPJKInwtXJZWzdD0bBXOmiQB+jGOHk5uThZ9KPZZgHjWoOpx9aIPF3nA6DueEZjk/FmlqELLCY8d8AxJ7X7idJABamIXHyRQ0gEgrNPsLuYHmYEDmFPbZw8E23R7cwYX2engJe9xMPDSAgxYjKz1FCsHQOV0z4NZ0NxEfGCSwW7JTXP3yQZtD7a1SsZ4F+2DwF8PQ3knMIoH4fJAAGVAr4YFwtJaQ3QD7dyIq6biHJmhK1QYPme/N9/BbSwJ0CC4QxkW7cW0xaYicPkQlFzp229h2e02lZ2B84UVMcPQsp4ng7DFMzePDhglWQ3zT9sC8MRkltU12Wxf73O1AY3aPHWD7YhW5nnolMPZRSkExcMDDeTFFDqH5ZXbWDy1U2vS9W7tod/fow0XJMpzsYx6xGBxWrPgVqOhxLuzRW22eMUSudRt6Q6dDy+L88uiMtInYP97D36s6L7LQAapYUwh67agx8JZETDghIVljqQ06CwxODR34vt/D0jh6AEEKyCbbfZdw2rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199018)(36756003)(8676002)(71200400001)(110136005)(316002)(6506007)(53546011)(478600001)(76116006)(4744005)(5660300002)(66446008)(66556008)(2906002)(66476007)(64756008)(41300700001)(8936002)(91956017)(66946007)(6486002)(82960400001)(31696002)(38070700005)(122000001)(38100700002)(86362001)(186003)(6512007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1JrK2VYdlNGOVluZHMvUVMrTE9PYkg2VEF4TEFDaHJXdzd6Z2RKV3JHUWc2?=
 =?utf-8?B?WnFQaG5mWlRGZW11enBIRmw1S2hvNFlHTjJIRDZyVW4vRkNTWUpCWUF2TDJV?=
 =?utf-8?B?WmtDbjM4WW90dkJGSEl5aTNSNkFrMjE3VitzTlE4MEhLcnk1WDdNdDFPTWx4?=
 =?utf-8?B?THdZSG4yaDM0d3BONG1oM0w3QzJ0QjNmZnZ3TWVEQUxISk9yTDh5TjRyQWVQ?=
 =?utf-8?B?RzNpT0VoYXliYUUyb0xhcjd0a09neVdHSXVKZ29oMWhJNENvZ3RwUTBUZ1Ur?=
 =?utf-8?B?QlFHbHJyMnpXRjNnS2dXMUNYV2VIUldxbmtCZitXenM2andrY2xhcVFnUlVN?=
 =?utf-8?B?dEhkcWhFNkZiTUdmTTBKTGw0bmtvUGVhSExNZ1Z2WVJ3WUUxL1dCYm1UVzhp?=
 =?utf-8?B?N2dMWHRlR0xjK25Nb2doeFkvSHpETlA2SjhIdWpicXF6cDEyeG81OHZHaDFK?=
 =?utf-8?B?NVpwZzBUdVU3QTR0U0s1SFE1THE3VnRFWXh6eXlkdzQycUc3cWJ2NHZJYk05?=
 =?utf-8?B?dTVBTWF5eTJ5VmZKbDU5c2RTWkFCQnJmUTJzUElXK3F3ZmI0VlVBWTZvSUZj?=
 =?utf-8?B?ekhaV2taNnBUM0tVNDhFOFhQK3JvaWFMajRYdEtvY00zdGRMV3AzbmVhZkdE?=
 =?utf-8?B?WUpxa2xLSTY1YlBJRkZya2djbGJvL2NCa1Yza1pqOFJaNzFvWnQ3M1lET2E2?=
 =?utf-8?B?MFpVTGZuSWpyMkRKV2ErU0FuYW5CYmJNSmZIaTRvTWpub0Vqc3pjTmJLcjVp?=
 =?utf-8?B?ZDlsdE5PaS9aRWNSN2xRR0ZEOVNveGRCbWJzVldXY09oMVlid0ExWmdXOFZm?=
 =?utf-8?B?ZjVVKzg1OHZTeUZmbTVaSHV5a2duNHczUnRncVZkOGw3UndOK1pwUmc1bHkw?=
 =?utf-8?B?QmQ2Mmp5V0VRdzhNZ3Nua0dFRFY5UzBGVlc1TVhkaWR3LytjcHRJeEdKM2cx?=
 =?utf-8?B?cnZ1V3BPR2lOSWFwZG5Yb3NaOHNuWDJ0M1RtVDcxeGxQOHFzSFM5RTE3RkxY?=
 =?utf-8?B?WkNSY0hWVDdINGdOcUoyRUo3Y3lJTWNsWGxUSDFDdXZzeEJidmlVeWNMZHFj?=
 =?utf-8?B?N3lVK0l2dlowNUFnYnVFdDJTa2pSOUZTTUNXQmZkcnhrNkNFT21Ca2had2w5?=
 =?utf-8?B?SWN6dDJraUdna3RGZFJzamRpNXVwR3Z4R1FoMkQ1bzI0eFBaeUJZR25XbWVD?=
 =?utf-8?B?QUFTVmVNaXpJcTI1OVhkMFA3b1R3cUpDYlBtSFQzanRWQTRWV01YRDdMTytF?=
 =?utf-8?B?U3pZY2RjcDlJbjFFNzlFN3AzVFlGTDZ6MElkdTNOL0JnMGNLaUExV3BoMGtE?=
 =?utf-8?B?d1MwUHNNV0ZvMFdTaEhEOTAwVENYK2NWNFBpeUo1aENWRWkxbzBlcW93YkhW?=
 =?utf-8?B?WjljMGpLN3owVmRWRXM4UDN2K2VRL0o1WDdyWm9RS09GS3ljTTlBbVMydFlZ?=
 =?utf-8?B?WDM2ekt3TEo4bEVMSWhvQ0NrSUZmVFp1bEgzcUtSNkovem1kdW5iQldUdUY3?=
 =?utf-8?B?dTdJYzU2K01vUzdZZG1EWlM1VGpoRTRjQW9lRmllMFNZU1UvaGg5UVo4Zmhl?=
 =?utf-8?B?cjZWV0QwQmZQa2JTYW9DQ09nR1ZYdm9McXB2NnNwbmJnNlF2Zk1VKytPNjNp?=
 =?utf-8?B?MGkxTlZ1Syt1KzNVN3BtVzdZTm4xSmdiS1ZpSW1weHArUHRhU1Y4cGNteTlx?=
 =?utf-8?B?d0pYWVc1dkJJVGRJbVRiVzJKdytHM1lDS292eGVGS0dySDUrQnMrNFZkQkcy?=
 =?utf-8?B?d2d2eXdnVVg3REFybi82dDZGK0ZRUm5kazJ1ZWdHNU16K1lCY0dDM1FUY3pZ?=
 =?utf-8?B?WHd3Rzh5eHZySEFmQTJyTnFqNDBtN2srNlUyTVZWT0N0Sm1sZEt5MXJSSW5Y?=
 =?utf-8?B?cWZFclRJaU1vbm5lV3BxMUlFZUhReTVXcXpDQkMxV2trcVJXdFhkUEZNTGlN?=
 =?utf-8?B?ZFZjOG40RitQYUlRZkZvc2UvQlRWc1YvelFhQ3NDV2hBd2h3TFVDRnBVUC82?=
 =?utf-8?B?SW5jSmE0OWR4dFR6WkpvQTB6YkpNMXZwWDVDbFFTQitHOWZCNlNIYnBpbjNY?=
 =?utf-8?B?eDM0aUlJTk5tc1hUd0h6M3FBcWYwbXB3eFcrTXVST1g2cUhIaG1ZWTJxR3RK?=
 =?utf-8?B?MWdDZi9XMnh0bkJVdkpmUVFuRittQUFNenhtS3NLUTI2blJvWXZxdFZ6UFZ3?=
 =?utf-8?B?VHhFSVJPRS80aTNWdDA4OCt5NkVURFJaMUFlRzhNdU84ODFsckxiaVlEdS9m?=
 =?utf-8?Q?jAHVzL0z3YJRVGfyP7L4o5RTuGOlQYcMgTyifXTwmM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ABBC9B68A9864439F897A4ACE156B63@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PyPgw7xbaDMWUpYKsOMa6Srdg3YRvCbI1nzKkQ2M35X34bFlmk30jorGhQ28ivmWs/nIAkn1FMcxE6ZP5Tn/TXHuZi9GYkSMnieJehL/omPG3slO3tLmXutefvC4Nmpl/P75xreXrOzZI4j8b9NGis6ZrI0fTRhcTRIdeVab02JJbnjqzLnrYVBmTW/WqSIVPIV1acjLCGSPuMYvvRXLgc3631xUB7FAPkRHH3QK/wOt1JdsBZyc8TnYV8YWGiL6fVTfmIZ8acwOHpGVvxhf9MM4w+ZUKDx02Q2rLNP1/h4ytKV1aZC16g8kxbZk7u/UOcA/on5sG4zAXmmwFs6H5TuKp38gc12zUw/kWWNQ1JKoPmbpZxWNJ8XnENmLaZ7UeQzj9JpE4ye8fK6/B8BTyzE8V4ByZETRHh11bNMhn+hdMRF6SwpkvUpMDpRo1EE39CrReWAsThh/FwDqftrImLeGor/7xJtXcPBxq/KXBILsSd+M6RbVthgewdl6FtSECZK6HGKxGFz0FDhewudiZLD0QhIdEFPg7Agl4SPf9iFP78dV/dAszd6h2xZJ2U/thKd/EzvNwiv+SwSvLs4NcjyJ9grp0GSItVQjJfhRey+2KJoh8Oj46RCnKvT0Z+N+K/knscGpwjs15jW9tJQCbsijQ2yTKedN24tYFADNfRqxUMJ+TkenQALU5KEF2j0TZTcsJl/KMdca2tx2424lsBuao8R3FspNsZcSySUwgCB7zZGYrkyQkjNSQ+Vq4elh4EhAU5dhQB68Gkod9UhpJV2+8Vd5+JzFDCRBs+hvIys=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a98140-5c67-43db-9ff6-08db081c0ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 08:28:02.2476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJZdcAK+SpodUVsqQjontOUDNhhpUwXXJXgaea13zxlCNrMxMP8ZS2LuFPJeWJuZbHFy7mKP+bT7b92De17+xs7QkHkdytn2roTVtc8jfEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7631
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDUuMDIuMjMgMDk6NTQsIFF1IFdlbnJ1byB3cm90ZToNCj4gQ3VycmVudGx5IGJ0cmZzIGRv
ZXNuJ3Qgc3VwcG9ydCBzdHJpcGUgbGVuZ3RocyBvdGhlciB0aGFuIDY0S2lCLg0KPiBUaGlzIGlz
IGFscmVhZHkgaW4gdGhlIHRyZWUtY2hlY2tlci4NCg0KRG8gd2UgYWN0dWFsbHkgZXZlciB3YW50
IHRvIGRvIHZhcmlhYmxlIGxlbmd0aCBzdHJpcGVzPyBJJ20ganVzdCBhc2tpbmcNCmZvciBlLmcu
IHBhcml0eSBSQUlELg0KDQpbLi4uXQ0KDQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy92b2x1bWVz
LmggYi9mcy9idHJmcy92b2x1bWVzLmgNCj4gaW5kZXggNmI3YTA1ZjZjZjgyLi43ZDBkOWYyNTg2
NGMgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3ZvbHVtZXMuaA0KPiArKysgYi9mcy9idHJmcy92
b2x1bWVzLmgNCj4gQEAgLTE5LDYgKzE5LDEwIEBAIGV4dGVybiBzdHJ1Y3QgbXV0ZXggdXVpZF9t
dXRleDsNCj4gIA0KPiAgI2RlZmluZSBCVFJGU19TVFJJUEVfTEVOCVNaXzY0Sw0KPiAgDQo+ICsj
ZGVmaW5lIEJUUkZTX1NUUklQRV9MRU5fU0hJRlQJKDE2KQ0KDQpNYXliZToNCiNkZWZpbmUgQlRS
RlNfU1RSSVBFX0xFTl9TSElGVCAoY29uc3RfaWxvZzIoQlRSRlNfU1RSSVBFX0xFTikpDQoNCkJ1
dCBldmVuIHdpdGhvdXQ6DQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==

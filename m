Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B0755DB22
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiF0JCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 05:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiF0JC2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 05:02:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60125.outbound.protection.outlook.com [40.107.6.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF962C5
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 02:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwnE1b/ud5N1Axr9doypkHnYQZZZyPBaMOxrMudf2WrRtO9c3kNoEoW8jaV5rAQP5pcqu3KeJMxxSkRXOWji++VfzRFXBuC746arSh8gAjflVitae9DZ043z5QBoQMFLumdabndEkxcORGLb26nLlrWoavTg4Yi/5MhgQQtQm/ZcKGpjW0/JYEOVTrN1vK3uRio39H3TDOHXKIBk5pQ8LeqkAfy8x9x8aI2Stx5TZnRXqzprJcBZ/O+krnRKoLyI1UOX/ZJj+gxYCKEROTVa3FGyqZ/v6q8y0P8P9LiTMn7v5DZDnbKWQ7x+j4o3EGC/2c/6DswjqqzAS90KAZu75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yd0o0um/haYbkP9NoSY3s86XR9r+8FGU6bZ+PW/X6yk=;
 b=br9wqry8L9lVexMhPTWNTbbqNqM4mD1e4NAhXfhe+1p0gLcWbOklZfWFEXuMRiyvqq+OghPjmqKjey6WfBkpKV53tI5dW1SzZfO57kkyXZMn1+6M7FWTgkZoamoZa0DlfRmTvgPJzfcgwhhkZlPRD3gz/JJlN48mZThR5rpFTv26OGWpBQTpuWWYU4EkuvTrIcmlXsvryp3sZprq908WX/+8rOMGEEpGs4DQAZdTskEZWfw21XfiHMKoePWMqkglsQFDDu85GgBg/XrcNH5hp9q/9wF+oCA7o6MYu7mAubPjb8YqcbYZ8pilxmQQzW7sTLMWpMnNiFEdVLHtUTq56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bcom.cz; dmarc=pass action=none header.from=bcom.cz; dkim=pass
 header.d=bcom.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcom.cz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd0o0um/haYbkP9NoSY3s86XR9r+8FGU6bZ+PW/X6yk=;
 b=B/1VUBQCUM92AS3qM89zmrsp2ds1un5/scVOu9+6yv+5LUN+EUi0pd7w5oxJAiGXI8MSJC0N00q+f6pDhVbU5VV9W+mPXmQ3gOqR4qTuPZoAreTc+Vi9zdBaVawFXEtgGu0Ge2XqYlUzeaw+Bol8rrAuZLvUnp7+GDI7dVIe5Po=
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23)
 by AM0PR03MB4532.eurprd03.prod.outlook.com (2603:10a6:208:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 09:02:11 +0000
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924]) by PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 09:02:11 +0000
From:   =?utf-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Question about metadata size
Thread-Topic: Question about metadata size
Thread-Index: AQHYigSW65wbq0NzSkyBZZP+sZI85A==
Date:   Mon, 27 Jun 2022 09:02:11 +0000
Message-ID: <8415b7126cba5045d4b9d6510da302241fcfaaf0.camel@bcom.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bcom.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42345246-59b5-48f8-fa09-08da581bb905
x-ms-traffictypediagnostic: AM0PR03MB4532:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mcFnu4q0iSxYurCHuvXqUO18B6NnVLN2NnJY7fsHSt62QUzqUDwHyAqu4mNJAawREWWivt7kRl2sxIGbmmbAdOSX/T11ZwfUr7RieNHlugU9ht8rKNsze6BV9AVv0EfhWVDZ4pOpGnXTKRUZqBfiFgKqKv6LPjAmkgw/iBiHO6zvKvF3VFaihZbHMB44zCKhj3RMhLWiI9SDvKqjozHFU2NNBebLE1VUCjPVRdbdSR3F7aKMle1YvspTi5jdHPNVM5q6pHdx8DS8T75aOO53QizZz0bXYlqXZqOAo/KZOM+7leqoyI10PtrdzfQZCIeGFROmfopTVEa0sK/iNcWLa0J16LYudXTZuHv3t1Jvn/l25VBx4NVf5h5Ii/yrZW7TmGbL6FeSoBEvwjse2MLRTpJKTVJCsBX+FcBSEje95J2P1LSw5HmNwMwhbKXWf8qWJdZq5D6z70U4GOPvbyQl2PMpXx2FB9Kiesq9BG8r4D7js295CsTVWV9IkHYWvlWL4qczUB/nKfSRz3SxdZPlRoYNhkNh2/oh+GrrSKQz9qju/jyvyPp8qQUlkHSlekzVROg1aiL5sOZ243R5ufryr80ge/0nbwhuZhRQPlEy9KTxhAtslM7FcGbaveYMaZhT98YhmGm73VtS72Ejs6HrJ6sC2DjZoC0sXP9bqJG2kwimpgu+g9N/IOez0HY1sggWajkaZxWfcwXyashF+k5eA4y/1Zzg8Cw1IaHwspQZxYkR8MJBW9pcN66asNv9ggVp1Vd7xJYbc6Ak0SByw2138x10xP4JwG/Z+x60Omnyz2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(39850400004)(136003)(316002)(66476007)(38100700002)(8676002)(91956017)(6506007)(66556008)(38070700005)(85182001)(86362001)(6512007)(122000001)(41300700001)(3480700007)(6486002)(186003)(8936002)(2616005)(83380400001)(478600001)(6916009)(71200400001)(2906002)(36756003)(5660300002)(66446008)(66946007)(76116006)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkJhL0U3SWFaVVB3d2Q5RTZReDY2dXBZTVBNUllGTnBvMFY2NW9oOCtjd3RD?=
 =?utf-8?B?M1F6VGd2WlYzRDdVaGdXUlIzV1dxWHNJd1F5elpxQnByclNqRTdOVTM5eHNj?=
 =?utf-8?B?dGsxa2NQUVZkTXpnblBXZEp2U2xab0d6bVF1M3doamFLeEhGRUFKZ1NJbHl4?=
 =?utf-8?B?OXZrMlpzWnhaZU9Valp4V0VFSGdzbUJ4Znphc3NQbmw4R2FoSVM1a0lMS0Y0?=
 =?utf-8?B?dGwrVHZFb3lIQTYzN2xoakRoMHU1ZkU5ZUVOU0ZUVCtqaThudFdYaEIycGZx?=
 =?utf-8?B?Y3ZSdmRZbG83VkdycDJsWHpORzcxVTkrOEZNTlpwdGdMZkRzRlJqTEVCWEZq?=
 =?utf-8?B?dUswa3dqTVNLb3RnVmoxemkySW01VHlRVzFmdml4WlZmSU9tejhmcisydUlV?=
 =?utf-8?B?M1BZcGluM0Z0S01rZ3ZCSDhpdlVwVlFpQ1NBcmVSamxtNUdjRnU4MVJjMnMz?=
 =?utf-8?B?UFBTc002emJtWmVobk45VXhpZkU1OGs2OFFtajFLTWhORUJaR3FpdE8vWmhV?=
 =?utf-8?B?em1kZml5eFdJUkYzSFZDK2xjdHpvTmVmK3ZGOGRKaTJ4cis1d1htRjN5Rnlv?=
 =?utf-8?B?Y2JVME1leWFGb1lJellWVm15SkMzUjVCdEhhYitJOGJ6Qk12TlFuU0FCSHN0?=
 =?utf-8?B?SlJEYWszdk5jdktJeWtjL2tDZnkzdm5MbUUvY3VLUmJ3WXc5Y2h1VVUvTWFZ?=
 =?utf-8?B?eG1BM1lYUXhqamw5S0p3aUNielVwNGNLVEJNamhabllIZktNY25SRWZLTnBH?=
 =?utf-8?B?N3MvdmJ1aEF4a0hVVmpOT0lmN2hFdWZZMjZFNnNKMDdBR2FWUDNwZGN2NGM2?=
 =?utf-8?B?OFJHMnoyMTVRdTgyQTFxaXljcWJ6V3hKSWNheWtpU3gvY2pYSlp2TGZ5dDdv?=
 =?utf-8?B?WmJNTjhpVWl6bm54S1ZzeHRyUWV0V1NyL2xnUjMxUDZVdS9NR2QvWnhwY01T?=
 =?utf-8?B?eG8yU1A2YkRxK05EUXdUejFWcjVjQ2NBZU5ORU1jYnJSRkpIVlBCSncwS2N5?=
 =?utf-8?B?a0o2VmEvVFpjdjlLMnNWVU9WdWJEZUN0ZUR0RENRb3FLd2tWdkxNUDFzQis2?=
 =?utf-8?B?ZityWDgvR0Z0azN5dmtLaG1hUTJkN0tHMHdqR0hEbUdRTkZVY2Q3VFZXaXcv?=
 =?utf-8?B?bEFTaW5zQjUwZWwvNjEyakt1L3Q4d3FsZERCNFVZbnRTVlpaVXZmK3lLcjdq?=
 =?utf-8?B?WmxWaGlrYjRic2I0ZDV4RzhqWm1XVW1hVTdadkdwMnM0MHRVS29RVTRmNFU3?=
 =?utf-8?B?cjdDM3lvcUtDazRoOHJNdTB0N1lQMjlCcHFtUmVkWTZPN1Vkc0RDdTdocmE5?=
 =?utf-8?B?d2QxVEdpUGZvTTUxSUt0eGgyc0ordFUyMDY1VUxTRjFhemVteUpQdWJiYnVy?=
 =?utf-8?B?MTl5by9pS0psNlRneGtPZ3RJbmttenB2ZEsvbHgxcmhBS1RoUEdKaWRWOXll?=
 =?utf-8?B?STI0UkVyRjNMcWRrNzZYWC9OQjBWUDhBZ0F0MmY4bVVSc2Rla3hmY3AxTFhJ?=
 =?utf-8?B?Z1BXdUNKUEtHSGo5ckg2RGp1TC9QM1lSbGxTU0ZNK2FlelpXdXJmUHlRUkxv?=
 =?utf-8?B?ejhwc3pYYjlrWVUrTlNLek1XWkJ1TWlpSDVwY2NiRXFObHU0Z3Y5MldHMHUw?=
 =?utf-8?B?WEZ0SmlzUFBKKzMxa3JCVlBsd0hXeDR5ZFdseGU3THRrZ05TVXpOS0J4aklN?=
 =?utf-8?B?dXNyYXdjdFRCUFZ6NStzekxkempsS2x5RS9Wcnc1UU9oSVhOQTlzbE9UR3li?=
 =?utf-8?B?SmNHdGJIU1laSHRmeGhHditocW9QeloybVdoR3A0VFpFZFNkWHNnTDhVU1Jz?=
 =?utf-8?B?SnF4OW04UU5CZXVNYmErbElJU1Bjb210bkg3NXVUSFVuL3UzMjB2bUJka0h4?=
 =?utf-8?B?TlVnNllYTjJnQUJYd1lMQzVTTmFkSWRLcFF2YS8xUlBwWHFNWCt2ZVU5aGtq?=
 =?utf-8?B?bXdjZU1lMlhoQXhTa1lxbytvekgxekVhUlJxRzRoK3l6TEs3dTg4TVVYbWlw?=
 =?utf-8?B?NGxvb2t5TDRNSnVNd21mQjcwWm54UDU4ZkRUZjBRZkE5UTFINzJjZ0dyY3E4?=
 =?utf-8?B?blY2cktYYkQ3c0NXN3dzSDJLZlkvaWhQaTVaeXUyWDVFYytuelVETW5wZmdH?=
 =?utf-8?B?cjkwNDUzbUFSRUJOZlM5djVhQ2oyeE1FTnRaNksyZExROXJWR0tueXV1VVll?=
 =?utf-8?Q?wlmOFJCQ7Ce49HVDA0lo3J6Bpxc+vNArT5j+6VNO4gfD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0634C30FAEFE84AA9CB8B3005EF2271@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bcom.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42345246-59b5-48f8-fa09-08da581bb905
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 09:02:11.7415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86024d20-efe6-4f7c-a3f3-90e802ed8ce7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aw9YRh+NUIztXKBQ7ZH5WfMrYpEvpXXnB6q/cJ+EmHb6NNbAdxB6epiMvydLxAXwlIIbADmKTRmcYbjrOk+YVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB4532
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGksDQp3ZSBoYXZlIGZpbGVzeXN0ZW0gbGlrZSB0aGlzDQoNCk92ZXJhbGw6DQogICAgRGV2aWNl
IHNpemU6ICAgICAgICAgICAgICAgICAgMzAuMDBUaUINCiAgICBEZXZpY2UgYWxsb2NhdGVkOiAg
ICAgICAgICAgICAyNC45M1RpQg0KICAgIERldmljZSB1bmFsbG9jYXRlZDogICAgICAgICAgICA1
LjA3VGlCDQogICAgRGV2aWNlIG1pc3Npbmc6ICAgICAgICAgICAgICAgICAgMC4wMEINCiAgICBV
c2VkOiAgICAgICAgICAgICAgICAgICAgICAgICAyNC45MlRpQg0KICAgIEZyZWUgKGVzdGltYXRl
ZCk6ICAgICAgICAgICAgICA1LjA3VGlCICAgICAgKG1pbjogMi41NFRpQikNCiAgICBEYXRhIHJh
dGlvOiAgICAgICAgICAgICAgICAgICAgICAgMS4wMA0KICAgIE1ldGFkYXRhIHJhdGlvOiAgICAg
ICAgICAgICAgICAgICAxLjAwDQogICAgR2xvYmFsIHJlc2VydmU6ICAgICAgICAgICAgICA1MTIu
MDBNaUIgICAgICAodXNlZDogMC4wMEIpDQoNCkRhdGEsc2luZ2xlOiBTaXplOjI0Ljg1VGlCLCBV
c2VkOjI0Ljg0VGlCICg5OS45OCUpDQogICAvZGV2L3NkYyAgICAgICAyNC44NVRpQg0KDQpNZXRh
ZGF0YSxzaW5nbGU6IFNpemU6ODguMDBHaUIsIFVzZWQ6ODEuNTRHaUIgKDkyLjY1JSkNCiAgIC9k
ZXYvc2RjICAgICAgIDg4LjAwR2lCDQoNClN5c3RlbSxEVVA6IFNpemU6MzIuMDBNaUIsIFVzZWQ6
My4yNU1pQiAoMTAuMTYlKQ0KICAgL2Rldi9zZGMgICAgICAgNjQuMDBNaUINCg0KVW5hbGxvY2F0
ZWQ6DQogICAvZGV2L3NkYyAgICAgICAgNS4wN1RpQg0KDQoNCklzIGl0IG5vcm1hbCB0byBoYXZl
IHNvIG11Y2ggbWV0YWRhdGE/IFdlIGhhdmUgb25seSAxMTkgZmlsZXMgd2l0aCBzaXplDQpvZiAy
MDQ4IGJ5dGVzIG9yIGxlc3MuDQpUaGVyZSBpcyA4ODUgZmlsZXMgaW4gdG90YWwgYW5kIDE3IGRp
cmVjdG9yaWVzLCB3ZSBkb24ndCB1c2Ugc25hcHNob3RzLg0KDQpNb3N0IG9mIHRoZSBmaWxlcyBh
cmUgbXVsdGkgZ2lnYWJ5dGUsIHNvbWUgb2YgdGhlbSBoYXZlIGFyb3VuZCAzVEIgLQ0KYWxsIGFy
ZSBzbmFwc2hvdHMgZnJvbSB2bXdhcmUgc3RvcmVkIHVzaW5nIG5ha2l2by4NCg0KV29ya2luZyB3
aXRoIGZpbGVzeXN0ZW0gLSBtb3N0bHkgZGVsZXRpbmcgZmlsZXMgc2VlbXMgdG8gYmUgdmVyeSBz
bG93IC0NCml0IHRvb2sgc2V2ZXJhbCBob3VycyB0byBkZWxldGUgc25hcHNob3Qgb2Ygb25lIG1h
Y2hpbmUsIHdoaWNoDQpjb25zaXN0ZWQgb2YgZm91ciBvciBmaXZlIG9mIHRob3NlIDNUQiBmaWxl
cy4NCg0KV2UgcnVuIGJlZXNkIG9uIHRob3NlIGRhdGEsIGJ1dCBpIHRoaW5rLCB0aGVyZSB3YXMg
dGhpcyBtdWNoIG1ldGFkYXRhDQpldmVuIGJlZm9yZSB3ZSBzdGFydGVkIHRvIGRvIHNvLg0KDQpX
aXRoIHJlZ2FyZHMsDQpMaWJvcg0K

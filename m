Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCEC79D33E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjILOHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 10:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjILOHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 10:07:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D49410D0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694527664; x=1726063664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ck48iYuBW3dUIW7AWyThpcXnYyjBBqgjW4gdTNFl9j0=;
  b=Yd4X0sfs8mSiMXR4Nt+hYspMi3bFzS5pJ6pNpYm+uP07VA6Z15WzK7s+
   pC/Ll3bG29WtsYnP8pNLWoEbUwQ94hUdO3rIakHv1FdZucOcEWyFpmL/R
   diWlyt9R3vrPcb/HV9kXNCaEOx4kLg8k7xmRTUE64qvyOD37YS5GCSw6z
   CMCiRrCdLAqpJpkuG8/DW6it8dcCNUyStuLuyWyLJ7xTZTkoogaEtiu/5
   Kk5ZfrAKuyz4YDe/CMuYKst4hfgGTXuvbbllmY8lGSw2opKpN4/L+AeXo
   mwfultc/NEzpcFT7kMjyQkGVbMewpIgrasEqXELg12OtOhfsFf2z/J7r0
   A==;
X-CSE-ConnectionGUID: iERdxJvQTZKbB5Oce4WrLg==
X-CSE-MsgGUID: ZPl+9XOwTnOXdZbutsGx+g==
X-IronPort-AV: E=Sophos;i="6.02,139,1688400000"; 
   d="scan'208";a="241977764"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2023 22:07:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/TVxzbhcDd5/DfSlvLm0McWZFho6PVWYEVSGp96H5BB74ZX1625XRDs0Nw1m2Sq5pb7O8rQr3dY6NVfoag3Ftk06D5EkSWOcbP/KD99ujoyHUxWby+lX9Gd9hhGf4HOX5hTE7e5HV9ObtPbQSdldhKDmvWA6dvFH2DmM9AXOiN5eMVZDG4RGZ7LsaVZSHShKkdQJau+o3a1uGoVF7DIKFjmKfuL7R0Hnzo9PrbMnG/S+SQvEbNmuJkglu66k/nMlQChQz9hwyqCV3kR3US5vHBTvQU7TFkHzzoEqqv5VbyyCLq1O8mOPZ3NTwchg5e7QTwnrA5/8oeFWeZTDV2ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck48iYuBW3dUIW7AWyThpcXnYyjBBqgjW4gdTNFl9j0=;
 b=BGeuD9rlV8IdQriTDWiNl6wa/gOYgVr10FOJnP3PF/W0eV7/4R+hTLy5IFzuLrf6aEpF/5qtwFJoKfPxKm6zds1xvOse8Oxokd0e1Kmxrqhfjfiab8T0xdHEkBcha8X/4zTtvgBPXTfac7pqvWJVukI/XRUrvHwYpDRZTinFWMnHQTpcsG4yDDdnWKZOkQzyDuaGpV0AC/g70bqxPLkVALInJ8E8XNpp3PKNNNNibt+r1cveIJ239EkdC1JVHNJhb/GW3xT0JM9xj9us5ORWkvVf/QH9z61umGAy3BISu2mfkw5O5ap0+YLpmN4edoU/NrOjDlsLghRvHVpRpziqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ck48iYuBW3dUIW7AWyThpcXnYyjBBqgjW4gdTNFl9j0=;
 b=zAZLyUiDfREa59GRfGUYedWmBEa9nifPvrABC/YxY5ZFRSFAQacSv52dl63czqwJpHzn83iB6Z1kBQEsdZbQzNymsGc6nY9inDwfSs3utUqHc9T0MOlmBMgAdeZOfSDp7CDVYpLxmKY0CtJGS4nL7I79EUz0m+bsyDB8WLJcVFY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6517.namprd04.prod.outlook.com (2603:10b6:a03:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.11; Tue, 12 Sep
 2023 14:07:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.015; Tue, 12 Sep 2023
 14:07:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: split btrfs_load_block_group_zone_info
Thread-Topic: split btrfs_load_block_group_zone_info
Thread-Index: AQHZl4rkvK1UtQ/wYEiuzH10oHx7U6/C7kcAgFTnnYA=
Date:   Tue, 12 Sep 2023 14:07:40 +0000
Message-ID: <bb0d98e5-49f3-43df-824b-3600b920fa7a@wdc.com>
References: <20230605085108.580976-1-hch@lst.de>
 <20230720133252.GA14895@lst.de>
In-Reply-To: <20230720133252.GA14895@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6517:EE_
x-ms-office365-filtering-correlation-id: 1a50a6cf-5513-4e92-b65f-08dbb399a042
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yycsFX68y9mqEBKKjWQJiNYEG/sK93Xa0pca6Ddspk30a3udP4TV25c4ZFJtSPlP0JVHWqIFiW4upd5Wn4WqfnfWecMDHp/1WriA4+GVgxMNU7XqbNRySr68Y6/EiBTxEao7mn8BDRFljJNr/HlH+3p9NEmozcNBDbkPkA0JIBM4rM/dAkqjlvze7H4L+vZVnrxke5eOvmkqT7Soh6iUUWbiQvvVP0gX88yulOBlYT3MRQ+PT9943dUy/LfZAsus5p0euXxFSrSSCeXcO1W+jC8V+SJVeBU23jNa9wNPvyWxGj3Tx8UNqkS+4KC179iQsOdmgq+9scDTWAiQ/VXvdPj+4R/RR8aR0yzaDlP+SSitWb9U/AAey4stCzBmKqW+Ragt7/RZi/1ifiElrYKM4TQstARsYAat5LMdpq2tuIFl6SsKTioJtR9pEHjk+t7Ab4OsFbsl/lWe65yN0ZGJyHXtNg9nrMSgCEYczKcVlLfbIg4HWdBce3iQGOinXB6Dn0+v4J0hUdCkWuebWIoi6AXBUgnBujM1XES+WHGKjj1qw/MU8KTzD62eJtk5WZqqN7JQg038w8dqWpp5KzOGzQLtjcKcI5iXvW2IB6hrxDfMO7JYtOQYWvfivX0CoGFUxSz0z+XIWr1FMf/nKvMgrzKhfDmb+RcDzeJ/FMnORRbqL5DocKE+FI4RrlBlkg9P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(186009)(451199024)(1800799009)(41300700001)(316002)(26005)(31686004)(8936002)(66556008)(110136005)(2906002)(76116006)(66446008)(8676002)(4326008)(4744005)(54906003)(66476007)(64756008)(91956017)(66946007)(5660300002)(478600001)(53546011)(7116003)(6486002)(6506007)(6512007)(36756003)(2616005)(71200400001)(38100700002)(83380400001)(86362001)(38070700005)(31696002)(82960400001)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDREUlJkaDZlRERkNlNEVnRJTEI1RjBaVjJIU25aREI2ZUlOVm1NdDcrVmZl?=
 =?utf-8?B?em9naXVUR2hadFQ2TDB3N05ORXBOUDNNOGdRR21Ea3lDSEQrbzBMWFRHYUxX?=
 =?utf-8?B?enNEdldRUERydXI4SllkYWhYQzY0dU1kcjgzbVNnbFNQQXIzMXFVa1ZQWTgw?=
 =?utf-8?B?NTJ3eUFIWHNsbllBSkdwUXJncmxQYnNjZ3RvUE5Xa2hxSzVVUlRFQ295NGNN?=
 =?utf-8?B?RFRUQmVQUCtrSmV2NEJ6OS9uY0M4MVpDZHZlckRteUZwc3VURXpjcFFSa1NC?=
 =?utf-8?B?Z2FkRVM3NXRUVDFldUMyS3BieFIza2hXYjdKWVJOc1k3ZUo4WXJRd1IxWCs2?=
 =?utf-8?B?RUYwUDNxZnlMREZmRFYvRnc3ekZyTFFyWTl6SEY1eFRxZ2cxbFRpVFFubiti?=
 =?utf-8?B?aWwvdlF2TmU5L0FGWUttVTV5bFJUamZrYzA4RVRLTHhrSkhtTDJIOW5zWWJV?=
 =?utf-8?B?cVFKSnkybC9ZSjJBRkhoV2ZWNzFYbGtucGM1dmZlTWpKSnlvZDluN2trVzZp?=
 =?utf-8?B?QUtvZnV1K1RrQnJPclJZRjBNVkc4cFdRMC91ZFk5WllyNWpoSVFTcXBmU1NF?=
 =?utf-8?B?MUJYTE9nY3FlSVBqYlo0L044TW10WjVySnZOQnp6OUNndVRSY0x6MU1QVGF3?=
 =?utf-8?B?S0t2Vy9aQUl4cVpLMm5Id3NkYk4ycW1ZUlVsN3FYakFSRTYwMjBpbzFyOG1F?=
 =?utf-8?B?TjZ4QWdqZGFVeFdNRXNKdVBHM1dCRWJMemR2LzBZTjM2Q2d5N3c1N0w5VlZh?=
 =?utf-8?B?MUc4UWxUWkdZUWppaXVEdGdLSy9hZUUxREg3Mm1ueTdFeVFmMUN6bElKY2pO?=
 =?utf-8?B?ODN5MnFxOXZsSmJVZzR0dlU4RlRDZzFzRXB2bmpNaVhibWZRTWU3eGY5VGcy?=
 =?utf-8?B?bnN1YkoxUmphNUxPVTl0RVd3WU1Tc2p1QUgyTEdhR0x4Q3VwOXNBc1ZOK0R2?=
 =?utf-8?B?TzNhYkVzTXlpWDJWQWtsenoxeVN0bGFyOGt4WWdLRXV2a2hKTEVCZ2g0Y3RX?=
 =?utf-8?B?MlR3ekJJUm44YkgyQWF6dkp6aEJaVnhmTDluRkZGdEtMWFl0UnM3ZjhObzFF?=
 =?utf-8?B?TlJPaGNRcFp2U3RxYkJYckdVYUthZ0JYdndaQlZUd1hjR2plMVlSS0JVeDVD?=
 =?utf-8?B?MmxucnBla2dHdjMwS3FPSXRIdXlQUlAxRFhFWVp5aVN5ejRiV2E0elJYSGhx?=
 =?utf-8?B?NzUrdEZyMXhFZnUrek5CU0liN2prOEVmN2FzNjdVZnVZaDAxRkdvRGplM1pG?=
 =?utf-8?B?VFhkMU91azJJT1duR2hYd0RTbWhFaHdRazJOVzJiYlNWTU5uaUY0a0xObkVK?=
 =?utf-8?B?cFYydDdWeEpwWUZpU1B6NjNNNUxZTW9VVHF1bE9jUGtCNENYUFl2Um5CTVpm?=
 =?utf-8?B?RmJQZy9xWkFBemdBU2F5QmpsVWdBVnlVSlZOMVVxaGJwWU5hU0FaZS9Xamlj?=
 =?utf-8?B?aGc3aVVzRFBuclUzZEhxUXdxTXNEYzlIdFRIWVdLYSt0c09ZNDB2M3pqbDZ3?=
 =?utf-8?B?UDByWW5BV0FSK3A2TmRqQzNqZWlnM1NzcWpqbkh4V2hMd1hvNnhZRjlwb0I2?=
 =?utf-8?B?SHFPNDh4U0U3VkNHZ0ZCMTJxVU5JNFg2VnZJaCtXdytscUh5T0thYWoxSzBJ?=
 =?utf-8?B?UGJ1MmZlN2FFNkJKSG45YXprNnFUaVNUdUlQVGprRUM3V1V0aVVva3czckdZ?=
 =?utf-8?B?TjJVczdMVWNobDJhcTJxT1V0WHBBNlpjd0R4SXh3QS9OOHNTbTJIMlYySGsv?=
 =?utf-8?B?Yi8zOHVVZzJ3Y2pZUW01N1pVVEN1bGk2V3JWMUNEOHZ3ZVFjS1RZSjd5eEtV?=
 =?utf-8?B?bnlqMU5CUjhKd2RCMlU2T0hsL2NraVI4SXN1TEN5MDQwRGZBL24xUDVZbi96?=
 =?utf-8?B?L0VFZ0xtOXo5VTJBVDQrbUxZTG0rcWVLSHdLMU1XSDI5TWNTMUd2NFFnN3lG?=
 =?utf-8?B?SG5kOVpuN2toeWd6YTBpQ1g5bHgxckZpcWFYN3ZqTDFkUjRyVExFdHRqR2hh?=
 =?utf-8?B?T0Jwdk1yek5NTXc0WElzby9EZ3R4bjV2NU1BUXlSSm9odFJDaG9VVUE1TTJR?=
 =?utf-8?B?TS9aVGtyMHdTTHZoREFXeFFuSDBkdmI4UkhQeWx5R3NFZXlocEZyaEI1VE9t?=
 =?utf-8?B?Y3dkVEpVZGZySXpWTmdWaFcvZjRiNTRkVFZ6WVVheGdZQTF2WnVmV0ZUa2dv?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1D706619A55BD4B808AC91FC4DBAC2A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zmN73ckXnC8nj41NmU+8SPV+pD7ac8nZyIjJj21XBcSCXu1rPzY3sAM0oPMqkZmphHxwY+rx1OH8h8/jG0JoUwtc0EIeQCLb2QV6A1ZOc9aF1x41xRXGUxpUVTDRzFGwDlH8k5iEWmhr0GCHPNwWOuY+W84XEORX4SOPv12meXQbuNnQubmpOe1RIDC8pk7BnhmcIbFs09UiVeBnVjGhCb+INtS4KU3f88+QYeliDiQP/o+3VTlxGgHVBgC/nCqyqa1IzTSrVlG0xMRfmwga0b7dmmqsishebsQmWWygikAbpxTAY76Z/NTAQNanjDRuHQ3V/GRyv71sLLOjO4kVSAtK5BczCDWeJ7FSS7f0oWD4Mreu8Syy2bBdLoq639MtBsE5StPiAmM/2oswV9B7WN0dWXO/Md/KEIQRNnEVXYvZ+kHWdYl7QI10qY0YWut6P3vLEKDOw/EBhaY+XRs+xbyku5R5lfY30B4eyDZWRg675rx+uxjuvvVCsj2DtHr4QeaQ6M99Sh4jRVxWTmcAfq6s2rgyQ+EQI8phPxicS4jed1jJBXsQcZ4yQv746sX8McmXNNQWcBawPMcUksw+9cFrapoDvJwGxCUEl+asaaPytrqSWQiUFu6y9MXvdTUgrJLcUN6g5aGHJLrPGy4vvTJ+WaRMQPHcDOJUGtOa6ZZkHAdJLBrgdwxaC4cfRe1L9QYJwWHeQQQYw4Jfw95orh0z4aS2Q+d4IaSMnsrdVS+XrFIOBQUoy+wQRr8j+n+2W50ZTQoF3glPO8kqiDtw/wfGsF9PTWUwJYPU8PHACf21YYZr8mh2uVAH2yNfBWAKv130yylXtbRoCxrYjBgtQtBHHn8RauvTQDkE+Zrtq9cK4vqNxgIp5fduGXmufXvc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a50a6cf-5513-4e92-b65f-08dbb399a042
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 14:07:40.3145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpNqxUgfNL3qwPsz/qVLVcZvQXeQzyfeJmJohSakMsbff6OxDM86xHrNzHOkcXbPqHQku2wpDTfPWf7G2EZRQC7ThdAYYb0Az/cfMDSY9xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6517
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjAuMDcuMjMgMTU6MzMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBEYXZlLA0K
PiANCj4gY2FuIHlvdSB0YWtlIGEgbG9vayBhdCB0aGlzIHNlcmllcz8gIEl0J3MgYmVlbiBvdXQg
Zm9yIGFsbW9zdCA3DQo+IHdlZWtzIGFuZCBjb2xsZWN0ZWQgYSBmZXcgcmV2aWV3LiBUaGUgcGF0
Y2hlcyBzdGlsbCBhcHBseSBmaW5lIHRvIHRoZQ0KPiBsYXRlc3QgbWlzYy1uZXh0IGJyYW5jaC4N
Cj4gDQoNClRoZSBzZXJpZXMgc3RpbGwgYXBwbGllcyBqdXN0IGZpbmUgKGp1c3QgdmVyaWZpZWQg
d2l0aCAnYjQgc2hhemFtJykgYW5kIA0KYnVpbGRzIG5pY2VseS4NCg0KQ2FuIHdlIHBsZWFzZSBn
ZXQgdGhpcyBtZXJnZWQ/IFRoYXQnbGwgdW5jbHV0dGVyIA0KYnRyZnNfbG9hZF9ibG9ja19ncm91
cF96b25lX2luZm8gYSBsb3QuDQoNClRoYW5rcywNCglKb2hhbm5lcw0KDQoNCg==

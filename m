Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D2A60F0A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiJ0GzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 02:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiJ0GzK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 02:55:10 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9166134985
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666853709; x=1698389709;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=OJh+KjT+bxXu04Oz0xRbw16lNG0jlhkYp8d4lbWCAOksGnmHgNaGi0JP
   Px4Z6gER1Ww1c3GzYeJh2LR1lFfgwftsgwVxfg8P2NMK15hUrlTiwb6U2
   8yb5KtYSEvqzHg1PReTMMTjXY4MGiqF4ylGsRJ6CgzZ2Ulbwuew1avczL
   An4fAgIGlZ7RJDNnEse0YjerDNJiJZxCb2ebQRHEpr5VlNY3lvsLMHnhr
   yrPgp6HIVQ+FFEnE6iMCzp8gqrBvtu88RKjfPCbdV9M4+YluvMZglFf+T
   l0iEX6JkQICmTxsRtDPl22r17XLgIUcQtLuZe/XNbzLeudx3sQXKUyP03
   w==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="319177748"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 14:55:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN0AAr17nodbcp0xoJG0atIi6McLkyglK+ykNeCBFO9245rXz3lc+CVhQgLSBNAvfs6s5s1uOREQneJqKe9MsAO/e2QWR0fNhh5R7jJ9jgLrr1NQxzWYSWOakslqyw49zejP2qt3aAGq/phqqiqJE1jXpQK4onPEqWmbb/XzFptzEl0Iyl4fRtkpuoqvfEMJRGcK8trYfUxMlghqAu/Fuk7+3tIJ6ShqontoNYa3zXqQEeKRwUO3P2q9BexSl5VhjKZGy28LbpshyZz2qqpoPcFv7gx1yPsVqvGEVEpNZrqsoG7ojiIXGs+M6PVUbQpF8Y67kHaL5DbLhh4dWEiPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OiXbKLTE6XTzHNfATQkKjcwGjiqEbQ5q3sA216k59wp/+w6PZLyPWq5FFgBFPyht5GdysdjlWwbvWxyjnRxCQnrF3HCPJ053PM7dPg6ULp3DaKVl5o/G3ev8VPArHCz7dyshCSTlnbGAoUys3RvGSGH6AKFKKdcYHyovTsuefx1r6vuzbxPPfnWywyc88ShD2W6kTAyC1X0XZtwgIlctOa8AOu/ph19xzI0nBDdphOatLfGCIvoV7cDC5+EFumkNJNQxlGcRRozxqwzeHVyoduGig4c2Au+Pf0hUt1JLgmzhKLQhcGmZfAuKf25DOEG9gt5jQjtYIFeDTpBnrMYlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=0OLZytxRiOfNmrDXUAADHTAstiLXEI3dYkFWA4f+Gg9CjW9m0lMBheo4hycafg6KI6vd9PQHEEf0kZY2CLFnv/+JkuL+MNGcZFENeBno4utYqaQ4YIMATffK08Jo210sOKaf43ARO7fdq61ul44jeh22Kj2HkBl0DSJ1p8IJjhg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4667.namprd04.prod.outlook.com (2603:10b6:5:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 06:55:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 06:55:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 07/26] btrfs: rename tree-defrag.c to defrag.c
Thread-Topic: [PATCH 07/26] btrfs: rename tree-defrag.c to defrag.c
Thread-Index: AQHY6W7Svl+98ZfBmkWgDWLy3TWNSK4hzzaA
Date:   Thu, 27 Oct 2022 06:55:04 +0000
Message-ID: <031db451-f61d-2a1c-f61d-69e5e24aef5e@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <87936f273e3c81d3b51d2f82506838c1f14cdcd7.1666811038.git.josef@toxicpanda.com>
In-Reply-To: <87936f273e3c81d3b51d2f82506838c1f14cdcd7.1666811038.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB4667:EE_
x-ms-office365-filtering-correlation-id: a99ce599-19da-4905-73c0-08dab7e82d4b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6vaqxVRwUiBS+W6Diqk/4eZdTiEF/yTDtxq+MVpoeF8LkJ0A8p2qk7tanV9CZ3UpNGxXuEQFACscp6S/6KOdzY0jgvVzGbru9eNd/9tm77YL1uIb1OXIjLGiZsFt79wxdrB5VDWFHDmR6HMsyydxrmIgfIMmMPyGW0vUcArGNZdlEschWfvBJRA413KhuN2SG8/76iBC3h/nNdWUy3WH2515cszZX3HDabNcmGSPq3TR5KUAXxFdprDzEr8REs03K8a52UXPCXQuxl07JCpOeqqivu1Te1GeDAsvwb78w8S7/s7uRHrcCxRHRg08Qzl369kV7XQNeQl3NwUSySBJVaNaOZ8W2jmd0ayD7+zjtVCco1mtYKOMFVpDrFLCR6q10q0Y6IZqVOUqy8f0pRkIn93hexzEzfGyzrebUkv0iYeg61c1c/bS4fJjhdwHOxATuvsvUiewMtvdZ+lLSNn4UprVCG6F7hDE4MpSzeOpACSqX7GYbo8LbpH8r7cW43K9xh4eBgWl59L50x3zwT+Ulo1fCMewxXivoSTGJBs8nAKaW2V2TbwRF45hdJ+ZVWcQr4unnKRUhKBegE/FWSPRklewCGUt1XsBeNh44cOw4CM/m/keNWL63ptG70jQSrdezpYRaG8pSgAfJ8MBHbN+R6Z6TWH8FJqZKzrg980vIxMO5tVD/eRFN5KMHK0WBVGb6RRCTUzE9kiFf9gicckInrXg0mcOU+H3Lm+X/VpRUIDOT7PhDfrz5MMppnpEME7YobYN+2punGkNf26MEYbma+15KUHe3xvjnlLar34GMFaZTbLwNIqTyNAsqhgC1+U+ySvgSp3qfVeBaEdDa2sP0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(36756003)(122000001)(82960400001)(86362001)(66446008)(558084003)(64756008)(41300700001)(478600001)(6486002)(38070700005)(186003)(19618925003)(2616005)(2906002)(31686004)(38100700002)(66946007)(66556008)(91956017)(26005)(316002)(8936002)(8676002)(4270600006)(71200400001)(31696002)(6506007)(5660300002)(76116006)(66476007)(6512007)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWZnWTArMVd1bERIS0d4b2E0S0w5NzkzdTRleUF6T05sTS9GbWJhOUJEVmxk?=
 =?utf-8?B?YkNCSnlpVHFLdGRkYU5OV29Vd2p2b0RLR0pDWll3azVEa3ZWK3cwMHRrOFBM?=
 =?utf-8?B?b0ltQmNXS056WjRiVmUxYVBlTEYzeVNLai9GTnB6czRUWG5XTk9HYmRGWGgw?=
 =?utf-8?B?dDBxbkpqNC93WFVQVXhCMUg0TlFzY0huZk9SeWtyekQwRVYzYmt5eUV3Njd0?=
 =?utf-8?B?WGFQejlnRCs2T01kS2NlNkVkTlprSHJEM25IWDVMaHdORHl2ZUlHYkxhZUJv?=
 =?utf-8?B?NWN2RTZ6ZUNhSlUrazNBalV6aXNLSmlhNDExemxlSjFwQy9xeEJZaGZoQzFZ?=
 =?utf-8?B?Qzc0eXdlc1YyYmxFM3JsTmhSSW5YaXR4eGs2ZitQRjNQYUYzUU5ZTElVMzZm?=
 =?utf-8?B?a2lqRGJJejBhWnhIUEFDdklZblljSk1GODRNQVp2dFRnU2Q4RVV4b29zUVo5?=
 =?utf-8?B?TUJTUTJrWTdaN0ZTZ1hmZ0xJZHVxSWFqNVpXdUFYTitMNXoxQW5QbE5jdmtH?=
 =?utf-8?B?SlJRK1o5dTNhVUZvYmpiSks5Z3pmcmhBWUpsV01pcXFaNnIxVlh2U0xCVHVa?=
 =?utf-8?B?SG9Qd0lOVWZFclN6dVVNUFI2Wm5UaFJyK1JIY2JlYk9CNkxLQWxxbFMzS2kw?=
 =?utf-8?B?djM5VDZGc0tOM2tkYzlZVDBISTBpaTRGRTR4bEdRdWI5OWhMQTNqdDVFVmMw?=
 =?utf-8?B?aTlkNWlaU0lyV0RQQ3NVRXFJcGZHb2VKVDhQZFM0VFdMdThyOFNtNk11dHBa?=
 =?utf-8?B?TTR0cjJic21EY3V6QW52THhNV211dWx2QTc2VjF0Umx5bytOaVhzWWZJckdw?=
 =?utf-8?B?RTIyekEzUUVYbDI4ZTBzVmhNVHBQcmFvWHA4RWR6dkVGQ1BwSDFreDNsVUJU?=
 =?utf-8?B?SGI1N1pOUENxMFkxcmU1TXpJaE0rS3Y4Wm9MZGxRTkRCL0JrUExvSVB0VFg1?=
 =?utf-8?B?TWJ6YzlON3JvcVRoVnAxeXBZR3hSRDNhZ3laZmsrWXMyVlZTMWJac1RiMk1u?=
 =?utf-8?B?ZlhLbkVwaDhVa2FnOE90MW56TVlvVWVRZ1Q5SnlhL1lTVERPSktGQnZZNzZT?=
 =?utf-8?B?cW1zeXJVaHh1YXZ0UnRBa3NIaEVhdm1xWHd6VXQ1YTZTTEEybU12NEpNcHc1?=
 =?utf-8?B?NUM0OUpqeFNaNFllcjd4cmY4ZW5pU0x1ejZnTzN4Q1dpRmhxcy9BQzU2Qjd2?=
 =?utf-8?B?cnhpRkxaUW42VW9nNzVZRS94NGF2Q1FjYnpKSldNOEluSUVVWHh2aXk4VkRk?=
 =?utf-8?B?c0NVdzRBVEx5REgwU2Z0Y2JtT0NiSGFGTUtsN2x3K3MrbkNjTTBHeW1HRlV5?=
 =?utf-8?B?eldodGlmNmtBNzMzL1U0Ui9PRXlhZFFOLzIrL2RQK3F6UWk5R1VKejhsVmJF?=
 =?utf-8?B?U3NGTzJmd0hBckI2cEhtRmJaK3pDR1o2N3d6cDFobDZaODRDeEFVSmZoU3JC?=
 =?utf-8?B?UmJyWUlEc3lIQlBodGYwODRQYkJXMUlnY0U3TTQrUy9acUVRalU2bnpZYjBK?=
 =?utf-8?B?N2JxKzdUV1VIVjRtalVoMkZ5WGR4S1VBZDdGREtuZDNIdWd2VHNQT2lPbkFw?=
 =?utf-8?B?QVFMaE1QcXV2dmU3QTdtVzZPaWw3Z25Ub2haZlRoWWQrZ1krNFFrZ0liMVhr?=
 =?utf-8?B?ZmRYZ2FzZkp3eUJLK1ZiNUlkRHdUZ2hKSnFldGlZem9UcVZUdmJmR0poVUpJ?=
 =?utf-8?B?cUpwRmxsZ3ZnelNVb2RCUkZlcEh0VGlqSjNPbVB2bDUyb3o3VXZ5VlByTktQ?=
 =?utf-8?B?UGxLUU14V3hPblFYUHhwN245bk1vdDlndndwSVEvVzU1eElCaEQ0NjQ0Y0di?=
 =?utf-8?B?QVNWYStqaGdtZ3pZb3JnL0xuMDlIa3hiTmh2eHd6c1UrdGxCRUNmWDViQmtB?=
 =?utf-8?B?MUJaaXNOendvUFpXNFVwWUhqRlhRd0gwZzdRbG1TWlluU2dlU2xIM3pJTmdl?=
 =?utf-8?B?Ny92cDNRcFkycStRWnhYMUx0RnRaZnpzS2tBKytCNWFVL1doUVF3Tk40MkpK?=
 =?utf-8?B?d1NyM2JNUTJmNVo3bjFXQzF5TTNIa0lWS3ZEN3g4Y0wxRFRjbnQ1K2gra0Ri?=
 =?utf-8?B?VlRFNU53d3Q0ZWxpc1lMMEs5dkRFblZvcDJTdW9wVGFsWFJ0UU4yUXk2disx?=
 =?utf-8?B?R2RoU01od3RDdzlaVWZOU2NZd214d1piZEVjdHp2VXlNR3dibnRwckNRbWxN?=
 =?utf-8?Q?G3Meh1tQMTNA4Q+hEqWCprw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFDD7D4E4D5758438917BCEE4B8C0524@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99ce599-19da-4905-73c0-08dab7e82d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 06:55:04.5936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTXRt1nVpTQ9G5tidDfGAr3DsnbKlefEWenNbjKfiJCy1IaRsa1p/d10TyMWvOWNOGHZXyCM5c/uZ1YXkpeusOhwWBtXcfUV0CU6kBj3oQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4667
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5D568EBE4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 10:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBHJmh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 04:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBHJmf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 04:42:35 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81540CA
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 01:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675849353; x=1707385353;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=MlZ9BvaUJBpAzxW+G9S/BBclCxBnqno6hMiGIDtdxStIW0XDroML2c5N
   cx2PaSXTsSUCyc3ViuWAkuF6KbEXlfc+eHl240TQV4Mf4y2iFDr9pbJg+
   W50h35IN/SNyP5117ze0NkTOTlPt94iTrEcwuH5NQ+Xy8Ys0B3XTP2gLq
   Ztq22qO+ClSOkBRKpYJOv6I8MYsdojlTwBqcFVM5C4n6qD59nxRJlaXHL
   awREACnZoWPu1xHk5UmKN/5faNUHwcJghUz1CdTWu60zCZ6laFdvVI2Ae
   lDdY2WbuESzwtAfRBecNwRpOhx2FdZGNMdLPqXRnIKkLRNz0Gfrk+BkIT
   w==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="227767693"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 17:42:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNz7Of1S+S1/PLXeyPTP0vVjASVW9M0XBOw6mb61uRPmTtEkE6m3jP6tCSXxsbRCZdQCiec2HpQrrMCV1K5JqeazPXa1bO4v3rhV0S777MDj76P24y4n1F/YAp2NrNaTUD9cje2AzvEENn3KoQSfs2nf5kLqNnmxo39sw9nc1AsyYs11QWCC/Vc9FkUoz28oFSmV7JJCl+iSzDscXMkL3iQHfbp6x9AQQzvC/aJJy2vaWRL8JBcwMTapytctFHEKSb+Ou4/pxp/9llznoD2r28d7eswu0BNbslLQNQJiHD5mRryy0q13hFxe8o1nruxxLswcTCskcS/SLglF6AYDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=g5jVRleoh34JCgV/fVJmOjpnsq7jBWPqNwg4M5B+zMGPIZpufRQ7Ouot9TfX5ND1is8xEfIJnDal3gTOJAbe5SLq5OZRRy8XkezYuubnhg10qfnissq/51UmrG1GWkJI67Iv46EDxp73Oiw/T2r32MKJu4iMzw9fMHgXGiwGYIm290DA3foxO7zgoSEQjebXo+KiAnJQ6TsOaZYoo6VKxU8lyR28YTQXfHgFsaVx8eOd6fbUo3AypXqYdqjJr1thyY4BAbPF3QcXy2wQgeTmTNKB+V9PTVZeKvhnSp9/dmJK+e0NjVV4JXirSkREZj3g4aOb6zUzAXyypv2TJ0f6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=u+ro7iRM7m+5E8LAoNfBZ5U1Wef6DQ6MdLU5zVGiQyKmiqDM2y0SVC05pCrv2XohryEID/mmYsjZyQKNVBHLFJu/tvOKPP5udRVK5011xo/pjpOIgzQK5rlJ6rXGg9uw9JWEVk2GGGbFU1SZYWOTs6A4MFqDq/KZIJki8LPg2N8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5885.namprd04.prod.outlook.com (2603:10b6:208:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 09:42:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 09:42:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 5/7] btrfs: drop root refs properly when orphan cleanup
 fails
Thread-Topic: [PATCH 5/7] btrfs: drop root refs properly when orphan cleanup
 fails
Thread-Index: AQHZOxV06OJZGLhJmEKKMBNNFYpJRa7EzScA
Date:   Wed, 8 Feb 2023 09:42:31 +0000
Message-ID: <7e4dd36b-1184-b4eb-a546-d5d3843b09f8@wdc.com>
References: <cover.1675787102.git.josef@toxicpanda.com>
 <b9dd48e9449bc86abe3d05d3edde41636dd61106.1675787102.git.josef@toxicpanda.com>
In-Reply-To: <b9dd48e9449bc86abe3d05d3edde41636dd61106.1675787102.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5885:EE_
x-ms-office365-filtering-correlation-id: b327d707-0edd-4009-375b-08db09b8cc8b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhFJeLI42sIMVfNBNbd/qCb5Dlo+2SbejtkHc7wwvTfLvgUbfNg3NwYsf2nhCqHrNaojqZC7gpXgKptp3RWfdAWIR+0m+ukIlSTpBloQ93d8CamGJgkmOTM8PQej7+92S5CLqNuIqnyeKuHmJ3wow3qulZajp4e8TC01C+xiXh3JifrBaJSiDmsudnMnny7Jej+PGdspdIAZU9u83OyHY/GlTgCqV/vAGr+GF9UfnnKcl3ycJeDpKBAmxdgi6z9WAu+Q3/rK4YUHZ8iXIrq0sp4UNIPbhnYl1bU29l8U+cgUF4EjVhebUYOkr1tA5jGhmRO8q34lqjt6+c5tNF9HUl4k8q1WdHGnx79vGx3n+L5l20z6sU4YPxcVjl3WXGWsZoXAvmgp1+HhZ8gx9faP/1rknAY8A35MMDZREOjjNl1VFXo2ks24fZP0PDt08YIKzlZGvkGjDdoaFMHnqH9+TwIbjRoi6ZKMJ5hvYh5A+qvduiaqkUzh9L4jDsHC275jByNqGsnC1MYifyYT4qCVfYt9Fqb1wQ9PU+lD2rm7N/XnSCS13xm9yeUXh9R/iXoZg6JILhg3U7cOhTRZiw/d/SJVtpCfx6uSJrlOHeO1HUxVKy8VsW5lhcBKyIkrzl8RslxD2xuaSp0udKfAg0a38r2b9tOjNLOXYZyj8o2VUGiq4VwgnRFk66OARz6aXzk6E+7VIx7WggBjF3i5b7j6iPrIGrTrl0GX94Ay/F44W8SADhmgUl/CnlgQMLCBdh/aagqCkISYvhSQ069h3uaepQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199018)(19618925003)(41300700001)(36756003)(2906002)(71200400001)(122000001)(38100700002)(38070700005)(6486002)(478600001)(2616005)(26005)(6506007)(8676002)(186003)(66946007)(4270600006)(66556008)(66476007)(66446008)(6512007)(64756008)(316002)(76116006)(91956017)(558084003)(86362001)(31696002)(110136005)(82960400001)(5660300002)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0tMdzVtLzFwbDM4SXE0RU5qNkYycmxOUFM3QkxMNDdTMFJudDhzNlplclNS?=
 =?utf-8?B?K2NMREZuMTkxOFBkOTcrV21XMlFDVFFGTVpjYWExUVlCeVZ3YnBBMHRRMmhj?=
 =?utf-8?B?RXUvbE4yQjN1Sm9HQWJwTnA2VVJnMk9NRW5hYW5SVDJaSUR3TFhkRzM1MjNj?=
 =?utf-8?B?empFN3RvL2paNmpwQTd0M2ZmYTVMMnBmRy9CdkRWL0RSUVZ5Q2lrcnRBWFk0?=
 =?utf-8?B?dkRhUzlEb1dVbjFGZWh3bUJkNlhZTEdFWDRRMFFmNS83Wjh0eGZ6UkVBcnVE?=
 =?utf-8?B?dlA1Wnd4OUE3UWpRQUp2cUE3Qmh6UGljMFV0WXQreFZUdVBpcHd3S2JWZ2gr?=
 =?utf-8?B?NEhaWmplVXNWb1BDOURGRVMyUTJBZzBwTE11bG5CTVBxVDVPRHJ2aTdKS09r?=
 =?utf-8?B?alUxOWxiVTBpdm1mSDAvbFFSOUY3eXlNSzZsVDY4R0NjOVlERDlFRGN5WlVU?=
 =?utf-8?B?dUR1ZHRvd0hjOHVUMHkzVGZjeEswUFl0amRRVWFFcFAvMHBBTjVFZWlXMFBP?=
 =?utf-8?B?djBDMWdub0FwZFZaalBZL0V1ZXJQWjZyVUU1bXU1UVJnK3Y2SERnN0xwNTla?=
 =?utf-8?B?YUdDZU56SUZ6OVJIelArUExPRnpHWTBTaFJrVnVRVGlSaENIdjEwNDBPdEhS?=
 =?utf-8?B?Z1FzcTQ4MTV0bko3bU00OUYvVHcxTEpoejR2alhRWExndnpKT1JxT09rN0ti?=
 =?utf-8?B?SGoxM3greXdOL3hQTUdTT2EzeXVjWHczMm5IQzlWVERwekJ0WDhJUW1pRWdG?=
 =?utf-8?B?dDlzSCt1Z2syc2toRFI2WTJaeEU3SGtCbEl1bWREMlBPbS9IV3JGNThYejNP?=
 =?utf-8?B?UHdQclRkV2xyeGlxY0lKcVFmWHpRZVhmRTRzMkJ0WEZTcEJ6OXV6cHo0QjlO?=
 =?utf-8?B?blYxWVlMcXJGdW13cWJ6RytYZkN6NjNZKzJ1NFcxMU1YM0F2d201REc3dEl6?=
 =?utf-8?B?YjZiT09OOEhTSXFmNjQwNUNFVXpkUFZMcjNKeVRMWVN1N3JXTzdOOUVQR2dp?=
 =?utf-8?B?VTdOZ0RoM213czNwRHN3c2RJZ25MUnE3cXdrWjZpK3Bxc0M0TVoyQTZYTnFD?=
 =?utf-8?B?VFI1TStBVUlXTWhmWFVyTUZwRzlvVEZmdzdyME4vdHR3OTVHc1AvU2ZWVjJY?=
 =?utf-8?B?T20rMENsM0NDWmJsN0pQakZrazk2anF2Q2x0L3p2aHZnS3I3cDZzRGFQNUds?=
 =?utf-8?B?SXRldkVuREhUK1F6YS9uaDFkV0hQVG9zL1pLWWh3aGw5Vk55TlNEcS9sRkV3?=
 =?utf-8?B?alN4RHQrRWFxbUNRSHE5amZtZk1wVkFwSXBpQUdwb24yQkdWUXFGYk9VNnpw?=
 =?utf-8?B?WDR3ZDhSUjZ6a1Z5NHBQUmYxckxlSmNrejlEZWhWTmpycnc3WTdmUHN1bDBm?=
 =?utf-8?B?djhCMmNvNWZFUmNscDExeFhNdGI1c2NNL2pZWm43ZE5KeXg2cW1hQnUweU44?=
 =?utf-8?B?bE5hTE1WaVdZSXdicW11M2RHS0VOZ0V0TWJlbExkTWNsYWtWQXZlZkRWMC9t?=
 =?utf-8?B?YlMzQjdQcktwSWtMbDlieUJwajdyUnhBNXU1OW0yTnhxM2Q1a0NwKzdCSEl0?=
 =?utf-8?B?cW0vT2VsbUI3U1Yxb0JKbzRNNDd5aHhHcHZlRitpQlozZGJxeXA3d1pObStC?=
 =?utf-8?B?RG9yZWJPc1dhN3A5bU4yVjFiVU96OFpBTUdLQlFPelhPc093QVEzQnNzRkd1?=
 =?utf-8?B?bG84MjRhaU9PWmJSdXo4cUZXR05XTlV2cy9nNDNCaEVJdGtkOEhhb2Z3Q2RJ?=
 =?utf-8?B?VUZReTN3TTVBcjQrRkJ6RDYrS0lkZDVtMGVENlJTVXZQSm9TbThQcy9CckhP?=
 =?utf-8?B?cjRNSkJhRjVOTDJjY3JDRU5CYzVBbkNHczVQN2VuU2FjeTM4bDVtRFk2L3F6?=
 =?utf-8?B?SGkwaUFqYk9pZCs5QmhxY2NBTGRxbFQ0MTFkbTF0ZExLdjI0ODd3RnpLVTl6?=
 =?utf-8?B?ZlNpQVZRL1FRUW5Wc3BxUjQzSk1uYzlFTFc5SkxnanJUUUM5L0VrQzVWbGNp?=
 =?utf-8?B?bVRHeU9pdktFUFM3Y01MTlJCcmw4ZWlQbW5RM1REOTAzeVd0bHBoSGQvNU9L?=
 =?utf-8?B?NU5Ccnc0WDZRbG1FaWpsQkdkdnJEMFArNzZXZEViWlRsaUlBbTQ1NjcxdE1M?=
 =?utf-8?B?ZGFXcUJ2WVErenpPL2p1MXprSEVnUmZNRjc3czBXbTFYNFpRb3FjR0VRQjFX?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17F157D4FCE4074E80A680AB2912BA00@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EVFCcz0i5YwiR2h69TdAWB/o4IdlxoQdv0Ocu6Bxksq2G38J8XuUSgiR/Vro3ArtzDJzAl7fE13g0CEFP6/V2Hj51L8dLjo4R63O9BHz9cZp4ZOpKIrPJn3sd4Sy/O4mekr9JuS8oxZS7Vhm3fTThW/D7zFnVCoHX16QYcKU+U0fuGWOfJh6ocXxQmHFUwd9h6rzArKswowJ3+VYa+Sjs6ImvUJgBNFjuBtgut67WNB7MuAFPE7xLUowEghHhgytKYy0D+KyJF4nsV/qJo7adciqGsL5CcrR7/xUjRl1cl3uoL3ILHDLf0x7c7EHBtoCh9Omsv3waUn4KtzT5n1Tw1D5AhF/QPkym+XeCvBizG1sgPDG8JXOynovUu3vyJIYwZPjNPkMmMM3ccGDZIJXEaXAlfqN5AWIjamdvOldozS5PTwpHi/aVhnB0RYLfPBebNkIuz2j5EyowCxmbV3FUFQ/1VTxtxcPl/dU9iIe1RxVKUteGio0FXsRkYsQ+2HnJCEWpciOYNfj/xMC8PaCWhDtmA91726ISasps3xnJWxJt/NaxcsFOd2H3slG5Gj+jwb1OB6JyNW54vwklTC+OrWWPA6fljXuGRYdKZ6Bw9AtFGX44UfBc/VC6O0xqQvHuj7wiWbieL8NIbvP8GWB1djnzHRn7hRoZ3NWfDSfcdVljsLk/kgM0vrfMbsjSxAtbEqGVSHDvWCYeAB+izvvLSuvahEPqXEUYSH9LyFcSkUCnFIq0sgD5jZAOCHmQzpkaQNQgL/5hm0exjKwybyjVQi1vZbfuwOFxLOnn//WO062SW0EsnKV7tvVNtGeFI36973W4SRHeIMKYbjmgyv70A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b327d707-0edd-4009-375b-08db09b8cc8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 09:42:31.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvvAx2hwvCiIP96wTNpAYed7HD/Io+39dc+rI7z3tdRgz1FeW0wT9+TortGjQRPKjguf7qJ4SgjbZ86UPIFVor+c83rZRUazVm4ly34ASuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5885
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

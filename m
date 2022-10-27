Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0301360F4BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiJ0KS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiJ0KS4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:18:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320FDCEBA
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666865934; x=1698401934;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=bSn6tG4aQgG93LsWUPJ8QJrUksztkL3C+hDqgEXmzjBoTGJjxa5C4vYg
   8sgT/jZg5p6GcffCkCIueDLkCvvraLlP8d0eK4yK4fDUtxvyscv4ul7vg
   xjN+6prulBNBBi5FMNNEroqkp+3GRc1kjj772rmYQQIdNtxIEOKj8Z20w
   ArCV2e+jvjFCeNFZUxi3R1mka3i+Z+drDadZyt6cYpgjJxIuo3pshPNo+
   ZWPeip4WIZY+Reu8vmar85B1QIMiMBEmOHkAiIeLxV3EcoBRbspfdk+Sp
   yEsnFtdKEsuZRCLSEI/KKJ537x+mB42NF361CxH1Qr9zPPclUe0r2QgLy
   w==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="215224426"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:18:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJuzJyGdmyk3nziYyu+7w9BlL4Vg+ukn44kQyDzU6ajR1iupDVs7hsoy/CvjnhxHSIHxkT4mBLHewqNjGZwE3wqtqhnuP0jZAsYQd27XUlLzZHxXH6C69mZX5Q6idBc7b35JQtdnla5tn5/Zj9Udqwc5InMarK4YdLeRkJehtNQP457k3E87WGeZDp1c8Hx4FtW6fmJbt1FUtIZjV0+ftTkqHvQUEMlzkB0fOlHFVlO5lWIXL/gAFcwSiYm6qHx95lUTynD6VN90/pkELfS1uMn3adnMX0/tBcsBILprkcZHN/xaMYOEW89APcOedJIhh7sAqdtqUFqLlfBrlKfVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ROISl+CeNagRdwWvYFGeAJ1EtrslaXMBl2ekCiE3of0+rlDTTABLJ+UPC2ouRKBQmCcWuJkauDIoUc5q7nR5M4qPLbm714gdC5Q2i6YoRbsdPVcxfGx21ODbEAlGHoaGqI57p2p1DHF8sB8zQoOuCvScdnLPVlASPM2RTqrgKY1kGXdQ4MEKN3tzDJ1SwYbCr5EuY/nyxRU+f2pSN9gciPufQI4Kyuao/5SPFSEWvZRFq1xXt4GfeVj9lg/Mk4IeZwSfWWMqeMJ2iFK+EQPa16awGH7pVKwc4hZvSKOzueTwk74KZBRXhwZ5+lshfTllS0AqmeeHAcbAGJvDLov62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RLfCz4c5fOqXqXQYj194wWIlwoS8r+6KTqCoMFJ2sp6hQ51obk4hLNLvgZDTAPlnMWwfllFpeLV2yScd/lz3tXwGRL/TwcgfgIxBtBuzCzkO59P2UHDSpwjALnjkma9DhnS0tWR8hgX90l7ou79xWEiJPRzBezuHQMwLrtzCVvI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7993.namprd04.prod.outlook.com (2603:10b6:208:344::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:18:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:18:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 20/26] btrfs: move scrub prototypes into scrub.h
Thread-Topic: [PATCH 20/26] btrfs: move scrub prototypes into scrub.h
Thread-Index: AQHY6W7oPbuPOdMWi0SjaH84xkjwLa4iCCaA
Date:   Thu, 27 Oct 2022 10:18:51 +0000
Message-ID: <bad26591-218b-2e51-54d7-cc28df0c5c1f@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <8a09d9153dcdcddf52e3145cc9463354246e8663.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <8a09d9153dcdcddf52e3145cc9463354246e8663.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7993:EE_
x-ms-office365-filtering-correlation-id: bedfdefd-c98d-4863-8fed-08dab804a541
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFnPVW4eL8Z2xYDoNEH4+eagP8ahQ95Y4DZfjOaJeTrlCpZG1ju88CeAQj4w5rnH3QEzApTyYD2mm83zp3gpce7w75f0hXp2CRdIlqCI2JdeZyikxQEZ1eOVzLRUPSMp/Qlbyb4/BiNNt7rjIRYOqOE0RJqVJ4nJa+rmFXPeDcMX3KdHzRYy6RpQtQhTZytbhARfKjlDXt2uxRPeBi4Cja4J7QtI7kVD2i7W7qIBdYRi+sbBBWPfZCgNe7gfaplXvNuZIiFqsD9ejMlWEOE3W/ci0TPuKHgcAUL0NCvQWYuqblZOo/lLVsQwR++6RgOs/TDKBBgwfYmV76ma/1r6zhqzy4skKqHFKtisGHzDGc2Zb3IgFUI8Vhh4nkaUKYBOAVxz4lU3MsptHU7CipOk4TxfO2O78wGDymrh4923GiB9Jn4ET2opXKuBpN/d0P4YbnTITh+AfBNsxGhhiiiCUlKgyk/iy3KW0a8Zh4AtM9BFv/1Hl02e8yLuitzj1HgUsUqXIY7MzrctXQwzXQVJVvEfa2I4SpoETiNmrPURCSCOxaLKxYbMSlk8EhFIcBTBSz0GyK4GLxi9nC5mp3Y9JlAODd/GGumVFCBOTHPTCzMKYtvwh9LvJ7vU4+BRUVUSHKz3mr0496HHTOxXLrVdsw1rPC8HPHujutkOA4+v+1TMjns44AngQqbstL7GLR4OUKyHczC110rrSt1cFmMPYU/z5xF4XXw5BvdT6Y7KaFPl4LH6l8338hrkN1++hR7KFuQfLhUjukzw3KH7lCintkPB0tOYdXkzm7nldOYFDKitOtpZnDLdl20ABzop7BnuWQRmAJGI14E8yRTQGlXPUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(2906002)(4270600006)(19618925003)(6512007)(26005)(186003)(71200400001)(36756003)(6486002)(2616005)(478600001)(82960400001)(6506007)(110136005)(41300700001)(38070700005)(86362001)(8936002)(316002)(31696002)(66476007)(66556008)(64756008)(91956017)(66946007)(8676002)(66446008)(558084003)(76116006)(31686004)(122000001)(38100700002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWM2bGVsU2owMS9zQjNHbjdlRS8xM0hxVGsySWpFKzViTFpYdWFBbjNjTFhx?=
 =?utf-8?B?MjNPWi9EM090eThDTkhyaXVCcndOYzRzQmN4bXhGYXRHdWlJV3dxejNQOG9N?=
 =?utf-8?B?RHgrVTBOYnpBcy9SSzRhRUQ1WktnbFZOQlJMSWFWbGZxZkNELzB2ZS9Od2lP?=
 =?utf-8?B?R0xCb0ZYRFR2anF1eE1UQXp2OVFoMWNPNEtidFJsb2Nvc25rV0dEMGIzSVQ0?=
 =?utf-8?B?L0psNGRXNWJETFVEa0JnRUVUaFY1eTBWN2paWHBFTWoxTlRiUHJybGtsdjZ2?=
 =?utf-8?B?STRHbFFRNSs0MEEyellCL3FMMkFQeEJDdTVnK0VTTFF6UXowbGpvMTlCMEtC?=
 =?utf-8?B?MWFXLzN5L2dzTWNmU2hOb2JHdzRPcTM5RXhqUDQvVmUyVzc2QU9HRGpKV3FZ?=
 =?utf-8?B?NjluU0M3dzBSdWdGY1hrM1lkeVMraWJjbS9pY3crYzk0Sy91d2RHYjZhVDRv?=
 =?utf-8?B?Mld0MzFMWmh0RzRjb3ZuQ3NaV0ZiKzhZcHN4TTVKVjd1VHJ4Zm9lYmI4akhT?=
 =?utf-8?B?dk5BZW0xb1FhN2pzbUNwaDdSL25rWTZHbTVTeHoxeExSeGRPRDBrU1JMQVVC?=
 =?utf-8?B?NWRlQ29QSExzRU5INGNjV0RLc1pUSUZiWDBQUFkrVnk1Ynlad0pHYk5LOC9C?=
 =?utf-8?B?SC9zdHhsM1pvUUh2YnZoc2xabFZ4K0ZBSWVHMEJtaWFvL2N1REhUUCtOYSt6?=
 =?utf-8?B?QjZRUVlzNVUxZk9WaGRnY3UzQno3V3VUZ0NIa3ZuMXRkRkdQU3FhOFRibkp5?=
 =?utf-8?B?RzQ1U2p4YlFHZ1VMZWZTekF2RHgyRUpuZy9jMzdScVpsK1ljbzBkV3piTVdB?=
 =?utf-8?B?cDlQd3VjRk9tbFZHbHlvUTNnY0VGcFpxUldMYUIvSkV5UmZiMmxDR1UvMnZL?=
 =?utf-8?B?MG12dEg5TGJSTXFHR3VvS2ZTMnQvOG5xcWg2bWptQUxQN0t0QXRJVlZ6aTA1?=
 =?utf-8?B?cndwNjV5Znk3aVQ4cDNMQlN0WkFvLzBCZktaZUxhcG1sbm91bFNzemEzZWw2?=
 =?utf-8?B?SUlWNDZyOTV4alV0eU1ySGFtbkM0NkVWWGZBWng3MzJ4U2FGalQ1MG5KdVZp?=
 =?utf-8?B?V2hvZ0UvTDZ5K2pzczFNTmlEcU9qVVFtQUt6c09jbTBPWTBaK0JqMHZKOThG?=
 =?utf-8?B?VDhKRmE4Um1hcXVqZTVBdTVhdHJzejI0UmtWZ0ZzelRvbmJURU9mQXZnMGs4?=
 =?utf-8?B?UTAxWFU1MVJXMXZadXhaT2c4WDlpeUdkTmtWQUhTZVdaVHkyTE9uOS9NQjg1?=
 =?utf-8?B?NW1QTC9nRkdsV3l5TEEya000RjYzMTRmSDZDTmc1UzRYM0hyRVZ6T3NQTmh0?=
 =?utf-8?B?UFp3NGxnMmR6SWgyRVg4emFzR0w5YW9KMHloVVRiMzluZnJ2VTNBL0RMR1c2?=
 =?utf-8?B?RGsyUkRQbWh5REN4UFNock1PeWJoY094aGRINEVBcGEzNGxucStvdWFlZW5H?=
 =?utf-8?B?NG11UDhRQnN5bmxmRHZReXl5V1U5QW9uaFJJdFNzQ2g5Sy9aWE5YUVpHVW1T?=
 =?utf-8?B?TlhiL2t4VDgyTTlqYjVkS1BhRCtyb3BpbGF4OEc2enF1S3ZITU9uRndwOVRC?=
 =?utf-8?B?YlVMbnlzOS9TSWxzdzhwUnZ1ZE4zblRFNWlzbnpwZ3hpa1RaZWRMUVBSekZH?=
 =?utf-8?B?M2JESUpydkhWbGZ1Z1pUUythNU1oeWJZTm5HejFVTWJkTkJTeXJrL3U1WXpW?=
 =?utf-8?B?SkRMMzdTOCtoSmhITm5jZVR2bnNYQkJ5Y0N3SWVCcXgySkhzcjBhUS9HY0Q5?=
 =?utf-8?B?UDh4bndpdFZpaXRsYUNDZGU4dVgybW83SERHUHFoNDgvdHhGWnZLK0JncEVT?=
 =?utf-8?B?NmNycjlhZEkyNStWRlI4VmdCK0dMTXF1SHowQjJZZW13RXp0L2RuZnZSRGs2?=
 =?utf-8?B?TisycFVBWUZzb05jVXh3UnJQYjNiS0xHM3lPZkZLOWhrNVM2ekRGbUhNRUl5?=
 =?utf-8?B?V3BYK09FSTFnaHJkcEJ3Y3NsRHRSdVZ1NjhqOGpkYk9aeFUxY2p6T0dhdUF2?=
 =?utf-8?B?d1AzTnlVZ21sQnJHQ1J4Wkk0ZStGV3pwdjl5dmxXNm1vbFNMMjQ4RVBBYUpr?=
 =?utf-8?B?VzFFdkZtN0VkaVc2NU5XK2NJVWVSaktwV20yMzVKT3NxeWVVb0s3ZUdKbGFW?=
 =?utf-8?B?U1V6dDlodkhaVi9KemkzRnQ1K2tPSG9ieEwvUngrNWRFVjd3TTBON1liQm42?=
 =?utf-8?Q?xr8zsjZz3WbOOAZpNj+N48w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD53D9A3E6B46949BABCD45F28925F8E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedfdefd-c98d-4863-8fed-08dab804a541
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:18:51.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: si7qNHJqDtvS3tHMpaRd2K4x9DFaLi5Da0lICINVyMCnOrZVC3T119/D98/xPRldcNNZ0qJXQcZkQk8mlXBy0BPQoTis5kWS62SL63ehPRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7993
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

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44BB60F08A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 08:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiJ0GpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiJ0GpM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 02:45:12 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143041C417
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 23:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666853111; x=1698389111;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=AM3fza+E/kxrRYYH+ncFxR+L8IxGHOdBAFUdWJ8mGCqfnF959/l7oWsb
   tV3qLJ2p25Sl1ezxogYWSncp/wgLJe/buWF2496Jly42dRxHvjs5Rj/GM
   gcmHklHhAw6k9d1W7SqdcFirWr3dZiu+qnkYSdXaHWpdoECEcCXESzmTI
   F2LhhrKJOgHSUb7Ib/Q3q5ApaxPjLQjAtRfI+TDcDW9A+dm9uPEVwUMzQ
   tSp8tIMfVOeAjxqDj//URHaLGrSLShBXm17lfezTl6+w8PIxRac7dfWmf
   SMalyskMkcmRrmGEvwu9cR9RmNozHxIULOYPHkKRg0/BkdFW9fNbQRBTd
   A==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="326957299"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 14:45:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMtafYtAbIM3FDUJMSc4vw7kD4JM12TcUgBO8YhYNck5B1oaKDoEslGI6FVpsbUeoMpRhEuCRPYBT8GKgN+fRpbPjmXE+8fXxOJtnsIFpYiVEcu70bRgqYE26l8oEtUP/L6b46vQ4f0Fa01XyXOJPYZGdHHdx53vRIpDQCZJpEZGG5ECesgGG63am2ANl1oUFwZYBwTJmymW6n1ECt/BSRtJRsotjMk5I6E/XKARKz6spDIri1sMhJIEfgi1H/jW/lO97IFQOtGtwdMzHKIPI5WL5DSYwrI52BY5QvYkUo6Hfh0hg4oZUGVT5hXdxopx8xHNxrYQrPQpp52Wzoio3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=GNqwMRS0Smo/qIQJinpihB2DeKE+YwZiSyy0RVGcPXnrMN0Xtayaba0OnFtTCei4U+W31RkG0R9HzPEwXMaP4L9cGqJJ/WZ8tYP3dCetuCafB/qJGQir17DyAMydCMLqjM+rm0yzrswI/N1RAKoRRQWHGP4pRyjB3AOgzX6Aw3TBYPa/Rjm7zxzlR79aESnrsOAWdCP6LLXF0ZLJRdjCSPf/Lp0aKmR9N7/9P8lt73BnOG+z0fOf3LBir9hiu1Ufe5cVqvC6N+vx2fEde38qHTxApDLGTsFPoUFI3Z7e53OkUDUeoXUMQDdQ3pcN7EeSqSZgG3vUq3E/LSaV6xPCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=T6PF1+6NxhaWWrsWlSaIvUkXebYycdiTGCQ5b8rW7UJF5raeHoWMmrCV0ja5N04qH8ycv1TQs4sy7wOAbWsVbw52a8t6EkcX3P9kB8u72BealVaUxSPBe50aDlWL55LJRno/04Bn6WN1gG+WJZ0u7c8zPHHVTEXnyo1/JwrbQiY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4034.namprd04.prod.outlook.com (2603:10b6:406:c2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 06:45:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 06:45:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 03/26] btrfs: add dependencies to fs.h and block-rsv.h
Thread-Topic: [PATCH 03/26] btrfs: add dependencies to fs.h and block-rsv.h
Thread-Index: AQHY6W7MglgMbaChKkOLdrw/ITf2+64hzG4A
Date:   Thu, 27 Oct 2022 06:45:07 +0000
Message-ID: <8ccc9f64-ca91-f170-ef5a-3e874108982d@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <167b0257aa04e4142750597be754696259d0205a.1666811038.git.josef@toxicpanda.com>
In-Reply-To: <167b0257aa04e4142750597be754696259d0205a.1666811038.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4034:EE_
x-ms-office365-filtering-correlation-id: 11d77cda-0b38-4496-0787-08dab7e6c99e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5bt10oZyCoqK69kiNcx4Vh6ZYDSH6eMMHX//Qx/oTQCwJRdDfz7Hy6VDOkW1M2NJGHJyXIY1bUZCCFdmCZbQDrNJ0J3Atxq3uQcfTpbvl/g8xlPYFIf7y2BqcGOk+qrSC+J6rQcDLlv9VaMr6iXjeTD2b9z4/F3V3UZRr9tU3m94H5jWU13uCXe8ruq4DU9x441g/Zvb91tFDWUXBKWTvEq3Ib+MfmU/NBJaBNfwWazD9RayE6Zh9hnup97NIYA5xKGjPrUH9gplW7yQSrdpVjVMVNuMiwP58uWIq70msfdL2pA2UXMpoQSIXuF66BYG7nkrvWAPfWJc+wDFyWCIrC1elffxBF3pFTEE0YqxoAFnRSpplJpLP5ebWPq4hksAnxU+MvZO+oVY90EzV1pj0+2S7xWd7HVkZAc6YDksOiBueutnaNiDlEY7jBr2BE7MlrkntvdYCz2ENUITyyk/XBBRkNNUSZf8YJPPIWBYRp1MdAZHeVWlze4swBkueSt0M8FfWrSYAfQT6+nlqs5Doe4379gZ2QE5ljdpRBtOnIOcZzi4NlupM8B5R0LZ9GDhSDCaTYqwdaZAAu5p/r03n2gG/1oj7T3yQd6KBKXiIaOOWz1byIDTQ7F/L5dXs3+nX2rdFm3zDh7fRVzlPdJAp9/OefT9aViHArb/S9qbxTmUp3yElZ8TvHFnwxhzfmAR9qOCewOvECuyV6rkDR1W4vhrr4R/yApysrCKuJELSrM9y19YRhs/MC0/TA9FvCpuimi+i6AqnOWmNbh1mqhtiDkReFfAwy00oZaSJJlEiLOZ0dEKiURRYrn6tLOF3Df9xqGD2aubtn9Osf0QsKm5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(31686004)(26005)(38070700005)(6512007)(186003)(66556008)(41300700001)(64756008)(66946007)(66446008)(91956017)(66476007)(8936002)(76116006)(19618925003)(6506007)(2616005)(122000001)(38100700002)(4270600006)(71200400001)(82960400001)(5660300002)(2906002)(36756003)(478600001)(6486002)(31696002)(558084003)(8676002)(110136005)(86362001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2txQzdBdjhWRjE0T0s1a3NzNlNoQ0lmUEZKSWpOZHlzM1oyc04yd0wxbktp?=
 =?utf-8?B?Ty9ONGVVWlNqblh5RzJIdTNtUjBiSDNFRC9lV29RNzJNajFxMzI5SDJWbVhs?=
 =?utf-8?B?NlJFTkpSaFRESjJiNFU1VVVzcTRsMFhvN0ZJNWs5dGpiZ0s4SmJrQ0RXSUxh?=
 =?utf-8?B?VDZ3THl1bU9vK0RISUZ0L1NvbUUxRXhYTmN6TE1BaFloYzBmRzRQMjlDdkZK?=
 =?utf-8?B?RUFzZWpYdC9COVkyT0J4UlJuTTNYajE1MTFTcFNlclUvNHF5bE9pd1JhNW1y?=
 =?utf-8?B?YlZxaFhVVWt5QzB3V1FpTzBSRURudnlONHlPUExac1FUSU81NVNpWjMzNDZP?=
 =?utf-8?B?RlU5VU84MUZwRWl2VVFLLzZQeHpnZHQ4ek1nWDBrdldvTGFodVZ1R1JJME1E?=
 =?utf-8?B?bzFuSXdackU3M3JJWGJUNG5VeFd4S1dqcGsvbm9iTjNSTWZSOTBEbnh1MFQy?=
 =?utf-8?B?aTl4TjZJMDhCck9ZYis2VFdBTmllNHZQNDFvOTNqRDRRV1VNemxXR1I2VFU2?=
 =?utf-8?B?ZzAvZFpkUVRlaCtqM0JPTUhMeVFuK0UxazBXMHZlcW1xVzcvSmU3cnZKVVp5?=
 =?utf-8?B?RUxHeUFiajRhOW9jb1V5VUNHQThyZFVrWGpGRjZOYURPMWRLVFZCd1JYajdD?=
 =?utf-8?B?bnFBbnNnOVhJZkcyVitUaVVBYzBmQ256TWVGUFl2SVZuSE1BMnJRZ2ZKVC9t?=
 =?utf-8?B?SXlGQ01FVlhLdzVvdnEzTWpmWnZxVzdWb3NPc1l4MlBlVjNEZUhNS3NzTWta?=
 =?utf-8?B?VFJZSmxqem1IOCtCdVBPOGN1UnpOSldIdVR6ekwvaGtMM3BseFBSTE9wcWk5?=
 =?utf-8?B?N1FsdGtYVmUxb05ZWk1mZTk3TmtMVGZzbTZMcVI1MytZSStqTU50WTQydTV6?=
 =?utf-8?B?bC9XS2JIMXU0TEg2MWZZbnRmd3RvektmQlNxWGNVc1pLeUdVT2hTd2srVUcw?=
 =?utf-8?B?L3lpWUltK1hDeUhYQVFEZWtRMmx5K3RxWG15OWgzWnVUdjBscnJXaXo0L0dJ?=
 =?utf-8?B?alZZSGp5Ni9wUGcva2dTT3pMS3RtU0h4dWhQK1hneUl0elgzRWsxKy94R2d3?=
 =?utf-8?B?dUQxQnRCMUw4QmEyb3llb1NCN2xkbURKc2l0bzA5SGhKcVlUUGlhUHBEUWp4?=
 =?utf-8?B?QVY0YWllRWhiWkNNeVNOUFBtKzc5WHM5ZVAxOUl3K25ObFBQL0g2R0kwT0xX?=
 =?utf-8?B?aVpTTXJnTGtKYm16TjI1WUEwVlUrM1lUclNkKzFsbUpxWHBWMWsrbWp3ZUha?=
 =?utf-8?B?aGczeDF2QkdWS0tIV3lqSkZKMzB0aEdCNVl1bkdlanVzMzhDR2FyaHZuMkNW?=
 =?utf-8?B?SWRoRWc2UFphZVBTdzdkeXJtM0pqZmo2NWxFZ3R5TEcrNVplV0w1bCtsTFJi?=
 =?utf-8?B?NXNhVVpaeW83Y29jbDV0YmFFWWVyaDlraDhiT1VyQkRKd2xlRlVSekFaQU1V?=
 =?utf-8?B?eWtHYnA4bXcyc2E4TmxaU2NweDIvSC9CWXFTV0RINWI2V3dtZzRNek8reUJG?=
 =?utf-8?B?d2tqZTdIcEtkRGRIT3huUW9WWmVBeS8vSzMvenVkNFZsSmVzZnd2VkRXZEpQ?=
 =?utf-8?B?T1NCNFJtMTVDWW5sbGQ4UGwzaWpDQ25ZM0tEak1sNW9JWEI0aHJ1blI2ZW5s?=
 =?utf-8?B?YzR4djR2TXl5ZWxQMGZWYkgwWkdNN25TZWZTUGQ2ZFdrelZRQTVxK1Vacm1h?=
 =?utf-8?B?WmxyenU2TTB4VzBQbkYzcE53b1R0RWhhdWdnUHFlSkl0bDNnT1o5OWZZYUg4?=
 =?utf-8?B?ZkhMeDlPcWxxMjJtN0grT0tPM0c3U05zSW4wOWVGbnBXZnZTSHJITlpFSDRz?=
 =?utf-8?B?bVdxZDZpMUVIMU8vVHRQKzdtM2VKN1IwdkhaTWJ6aWtPejJkcldMNUdLai9R?=
 =?utf-8?B?SnNkV3YzbitWU1dGeXZIVHBhWWQvYUNSSWJzT2txM01GbjVvZjJVblQ4WWdS?=
 =?utf-8?B?VWtlOXZoQWFNRjhWQlVxL0JhMFBydkVwa0ZmUndRZnVQdDVteGhrcVNlcjY0?=
 =?utf-8?B?NzRBU3dtK2V2d1kwWGdKYmk4bEZaNm5YckhTbk41NkRtamt3TVNaWEpwOVYy?=
 =?utf-8?B?NU1uVjJtRUptNFlWVXhxWXRhOElSdnpHRkR4KzNpbTlpNXhrbnRUNkpnb0RJ?=
 =?utf-8?B?ZUFnMStGemdoMFowT0hUeWpPWU00MHZOanlmSmYrQlFXUmtHc0p4NXBrYTFy?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <412E071318F17E4F92B2C875E002B1E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d77cda-0b38-4496-0787-08dab7e6c99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 06:45:07.8815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L94InzUa7c3B6krDjmqMepXh1NZUvm2R8K8EZLu4zQsAiSKETtWeQdymWuHpQiWyKz5zu2E39npmNvCuQ6TEalVtmQ2Kqb4dVGe5bfEE254=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4034
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

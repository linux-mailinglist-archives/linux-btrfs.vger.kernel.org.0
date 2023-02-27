Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548346A46E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjB0QVL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 11:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjB0QVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 11:21:10 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07B22196C
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 08:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677514868; x=1709050868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/lLOPryoP4VJNNQWWoMQq/t3z3x3wAv2ucWpkfXS4/w=;
  b=FNwhvxdvZM46f77Uv1idCwfYyiKEgisIbaSrwiN/UQZJgTv3UkYGV7B+
   1vmO957k11mZO/v8mP7FZL/L+bAxqI85mPOKTmO3NV5/W8RdGQAJa1AB1
   9e/7FyBXyoa67/IHC/b99fLx9QdcX4MwWSSldOqlWmzasM4PDxz+7uIAJ
   z2FwriZ/2TQdaisiTTrDGgREEtjZDi2JWq1c3BAPqz6SSsBpzyQ7GLrPM
   gF7AeNCWwZDb/aUyTxJOeIvwrIDzf3rP38LSeoZPGVkhGy1QBG3SOokan
   veuhg80mdWpFbtzaisDzPUZQcUavBvz7+C04OZbXBpYJIpIxlVMgzJEcs
   g==;
X-IronPort-AV: E=Sophos;i="5.98,219,1673884800"; 
   d="scan'208";a="222623603"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 00:21:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMG6OSzCDI0v4/k85hkVwUk3VvaNDs2Wn7OFkCm2XySSkB+hmUCgzHyqtuCUXxjKbYQOVewuZz1hlgsLucbAvlRhe45RxtHMt5FQ+2UMOXGtq1ikWadRAnz3XjcRrkYtqM8w/mW7IuaWAY/hBpQbjbXYLwP0srmK+0NffJ1Ss+2yalQP5A8fZE1JwRgI6i4XThF1hX1MbizXS12kJ/uugc/Zujf+jjVa4N9N+YNBgwVlnKyXjvFO9rgbdSHYgiTJ5+L+IcmVJ8xP7hg/6tm/YsjgHjj3wKTP7p4NCvQpchvrAnaITeaBZLEJI1tIhbHbsm45P9LklDSNuk+bKLJqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lLOPryoP4VJNNQWWoMQq/t3z3x3wAv2ucWpkfXS4/w=;
 b=F3LkorEsbAOOaaKCY2abEEa9UkFCFZWU+B0EpO2sK3wpcyjJP8yPBe9qWrx+kpkPnjt/G8rIVUWiDnc4nypwUqtHK4upXF+MT2BcW1kMki8oM6Qn3uGDOdOPd9BUnYGRkOi4nUkGiIWDUJT99xZMlNX2w1zydDrvERj2h1MjWuu4zR2e+T2TbNvvRhIlpPRhLVkVYXSghfQ5QTa7/87UqBqOIp3o1lUp6Uz9oAeoKQ1N1xF6WKvr8WMaLfy6xK2faLwpKKYiJ4RKbGNZ7hMQ5OQgEJ2JvjRTO9o47ItIi+VmAU9pP6G5tp4G3QTkcBnWz9vf6XY3WQR4s6BLZoTNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lLOPryoP4VJNNQWWoMQq/t3z3x3wAv2ucWpkfXS4/w=;
 b=kvRxJ4XTyiwn1RMaqKtl0OOAxm1T8e5Pc6sWbpzxbQbEu1/Cailfhy9B47Qtl1zShBICqhBz5sP1eqg4tC5u6lHvnl551g4WdqC/YmbRkT0ZmP4gon5c9jqpEZOOcTW8oClejoV76102vBZhRTRHp96OVYQPrnPZpTH1H8YEYo4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB1066.namprd04.prod.outlook.com (2603:10b6:4:46::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 27 Feb
 2023 16:20:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Mon, 27 Feb 2023
 16:20:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/12] btrfs: move the compress_type check out of
 btrfs_bio_add_page
Thread-Topic: [PATCH 06/12] btrfs: move the compress_type check out of
 btrfs_bio_add_page
Thread-Index: AQHZSr6bjTSKtJTDQUqt4wx+EC/yEK7i+W+A
Date:   Mon, 27 Feb 2023 16:20:54 +0000
Message-ID: <4253c978-d19e-5032-913a-dafda476eded@wdc.com>
References: <20230227151704.1224688-1-hch@lst.de>
 <20230227151704.1224688-7-hch@lst.de>
In-Reply-To: <20230227151704.1224688-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR04MB1066:EE_
x-ms-office365-filtering-correlation-id: e6def186-bf83-400e-2b24-08db18de99ca
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aoDytT9v4YQ8L0dW0nxz7GyX2AMSct3rO590WFBhwlbFXu1qp3DDV3DlJMEb7J6VH1nbk8b5mdtgJIvG8QPyf2g9vtFCpohnf0n8JMf4JOKqtI69kN5alBAfFxq/oifTtqTTYGBdod81spPxOwCMW64+yQALSR4MTcQyOTOjjAsTYgY9PEmEUW6CddZ+CT0zSU7OouylThsvvjG2vdJeM3MqaGZb+TCZbGGz3h8AV+yI6HNf2HrlELkMhYufnkvQ1gDRQyTDT0QvsdG4TeYhM/CQqMroUDsyaUdsuS0w5TeP9R7BcEJ2ZdekfR0RC0MuzRAvVPdDFy2zP5HyU3N/ePaQc/JCKjprjGhvGLKnQNHz3ylCHyFUqrXYkTYXuK/Ke4B8gGO0G7BVHHmp3l42Tfmy3l2Fvye2Rb/EgW4UeCiuohb5Qnv7/fiehRy6OdcCvum4VAFNXtSin9cnPfJFHLs2HSpuUy1SyrKO4uuE+M+25G9uQuur09IOjXs8TzxiQNncvtNv+cAyLei4LgkdpxAcX+9TYOwa0wmUN+GEPSTxDlBdRo/E+jKmW8lQ0ngO42yxuaJtva17bKVnytvu7lEeBwvM/0RY5+4JxQh/G47b2IxABdTUBFUYwEI5HKTzKDI3GoLffXe2OMNAIAQQmpPd5+9h6tC/i/aBjwBRM70B12d+fggmJxj//pyQE0V6wNWRwKtiSS9wsStXnuJ3QraxJalv7Nya7uakuei3mj+sQu6IfL0lzcAcZkHHdGnUDHF3R9rQpTb2hspRksb0xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199018)(71200400001)(66946007)(6512007)(6486002)(186003)(41300700001)(2616005)(91956017)(66446008)(66556008)(83380400001)(66476007)(64756008)(316002)(8676002)(5660300002)(8936002)(6506007)(31696002)(110136005)(53546011)(38070700005)(478600001)(76116006)(4326008)(36756003)(2906002)(31686004)(82960400001)(38100700002)(4744005)(86362001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDVRZzNLY0NQY2pFRDNMOW81QTdFSGJkekNGdElmUm01em9JOUh4R1NEWTdm?=
 =?utf-8?B?QjdkV2NyM2FTL0wybEpGc1pKZUhSYlk2WTB3amFOSWdHUUdoT09CNXZrbFQ2?=
 =?utf-8?B?WXV0VFkvdmtMNHJSWFB4WDJVc3R6Q2V3bVYvcTlNWkRBYy94R3A5TXdzeDlz?=
 =?utf-8?B?T21mYmFlQ0U0cmZEb0pWUFZWdmI2WW13dWtSUVFXQTdXdlFCMlB2SytZRGJs?=
 =?utf-8?B?NGdTSFBKRzcrc09mMFdFbUZhUGd1MWgxWEVSZDNybEVUelp6djVEcE1ZSVYz?=
 =?utf-8?B?aXNpYWs5QUJkR0ZIQkl0ZUdUckpleGZ0MW5qL2FQaTBLbmc0YTZkenhvUEw1?=
 =?utf-8?B?eCtsNll3UnVjNnVkN1RLMi9JWUJYYVl6elV6eHRackphZ2hhSmhLeC9WclV5?=
 =?utf-8?B?Q1JwZytZTEkyNWFSVGF2MHAxYWhUMWJ3Y0czZUs4eWRMdGdaczljTFFBKzZo?=
 =?utf-8?B?di9YUmJMNHlMYkdtbnNxYU9vZEFRNTV4d1pSejhXYThOVzRaYmRnSzAyRWY5?=
 =?utf-8?B?T25CSUtKMmJyTDBHWjNDOEJRZys1ckxFTzZKQ2RKMjRNeTh5OUgyTVZOVEd5?=
 =?utf-8?B?WFJxNkhzRzdnb2xnSjJCZ1NnV0ZualZRbmtRa1JTVzU3Y3FVQURMaXE3ZmJ5?=
 =?utf-8?B?M3JaNDZac2xtbE03MTA3RS9LZTRDVGZ5UHA4L0lTY3p2bThGYVU4WVhOOWp1?=
 =?utf-8?B?b3FpQmhjVG5XS05GbzcxaC9DK01MWXkyTWlYb3orMU9SdHFlWnB0ZnlmNDU2?=
 =?utf-8?B?K2o5YmlRYTNMcVNZWGJQYjFISTJqb21CdFlCL2pvM0IyTUo4c3RIMzA4S1Vj?=
 =?utf-8?B?ZHh6Z1dmckJ6Q0dBNlhYcDZRMTEzaEg3UWM2bVUweDRNVzhXWmhZckNGTGUz?=
 =?utf-8?B?d1I1dk1idDVGMWQ3YncvN2VkeUNKYk9hdmRqN09oR2diSUUxMnVZN0cxaDJp?=
 =?utf-8?B?aGp5S0tkY1VPTnZsYnF1N0VTK0lGKzgrN0N4SHkySFd4ek9QRlVGV2Zuc3Np?=
 =?utf-8?B?WEFyc0VRL3BScDFWZlJxTjl3RXV1U3pleGtmeHVadjlMclNiNkpWRDBFVnhK?=
 =?utf-8?B?L0ZVR21wNkcyQVlQeFBWREN2WENOa0hubGlhbWRtTG9qWkdIcXRWY2lndkF0?=
 =?utf-8?B?RWMxaTU5M0FoWjVMYis3SFB5Qkpzck1sWXV5dkhzMmR4VCtHRzZTVk51WDE2?=
 =?utf-8?B?Z09zbkNVcUhGdXl6WFZDWmRzYkZWZ1ZGOUZISEJ2VndMYXR3b2VUNXM0Rzdo?=
 =?utf-8?B?V0IrbU9sWTB2ejBQWU5JejBrczFwR2Nja1docno1Tk1oMWx0TlZ1NXUyVEJD?=
 =?utf-8?B?b1NGSkNXdjhHMXhTVVJqMXl6TTFwMW9sTHV4MjdyemtlcUVxYmZSZXlQM25v?=
 =?utf-8?B?UEh5akpoNUdlanFaTjhDMXYxOWNOVEN1enpmZ3hGYkw3ZXpVWXgyYU5Ra1ZH?=
 =?utf-8?B?NSs4aDIzYStxelJ5T21uVGMyVFhLZE1veUVhUXJlblY1aldCT1RsUjZ2SzFx?=
 =?utf-8?B?NjhVV1NwZG13QVNTNk5LancvcUhzcGc3VFA3QmwxeUJzUHZyblc1RHBCdDJW?=
 =?utf-8?B?YkpSM2I4NjMyVWRHNHNNeUU4bkoxa1lCRUlnTTd2TEhMdk8rSWsydzJCU1dS?=
 =?utf-8?B?Q2l6VC91OUJBSTZkYjZDUGxUTEdHRjMxWjFRdjBqNUNocmlaTzE4TUszV3JJ?=
 =?utf-8?B?SFo2NzIvR2FxMnVIdTlBeFlYYk1uaS8rSXhiWS9GZkNKVzdpelpCZXE0NjZY?=
 =?utf-8?B?MTRnWHFDNHpHaVhXZEdtTmlnalNobXROUzVha1Z5VVAzZjdoVEQ1cHhjV2xY?=
 =?utf-8?B?b3Fra1RkNXJWYTc4SDI3dkhFMVNQZjBwZDlGMzFmVDlGckxxVENJaTJRSk1k?=
 =?utf-8?B?bzkzQWJHL0JOZDhUaTNlaEhoYjEwUFRKRmlwN0dSZmlWWFV4MHF5TWVJRElz?=
 =?utf-8?B?TE9yUDJOdTVJeTF0MWt1eFBVYVlPSjd5cXlteDJvdVNQcE1NK2pRMjJSSWE0?=
 =?utf-8?B?S01nWDRKUDJ1NXo3bmIzbFZwTjhiUDJOcjdSa0xrYkxEVHZtRU5EZ1VXRjNq?=
 =?utf-8?B?emVOTU1ybTNJQ2lMcTk5VXBhTXFISkE3RzhrV1dLYmJBandBL1FJQzl4U1RP?=
 =?utf-8?B?amR2aWxtTGtpNzFoZnJoelVNbmpzWTdGUlpJZytlbHQwcHJlbU5Ic0YwOFFy?=
 =?utf-8?B?Q3ZjQmFhaTI1aGd0NURxdVVLcis5NXVKRHBqN3B1K082S0w2Yk9NN3V0cXpk?=
 =?utf-8?Q?Ql4ce2ztzu35QiQg6i43duKxjV1Bw2xNwPT1j+0hh4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EF45C07BA14464F982E2C7F7AC8AFE9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N5HDpExw0vpthZm4pZv4pDPunXDA8f5k9Ks8KTX9agW/1dq8QXsXiw7mI9sVfnbAtEl1zAPtdHD8MlJ5pF8M6yzs47W5yP792ESxWHMXIwiZs1B9KUAI20joMfNx6pn3I/nOokROmNXap6sRV5NlkGMzcIt/gq2OKhHd+fl8NuHSklfQ8d/saPVZJTPWvmeaZ92ubK5IeEg06bbHDWUqt/ispxb6EU1XIAKVRAkPwN4fuJ0dVNudkf+1WvJxVlBM3hvWksW5CucuatoTmsv7woWZdrXnqudBsM9OAj/1fIhCnm7wYmahclFzE81pAxqg7bjm9Gl73Obe0ZJVCgwQv6MbLqI/cdx3+D2J8cuG6hQ0zrvpqVTD82eWW+0cfzlOKqC2UMA8qDPPPN87mRPSzjMiiy5com2Pl+BmG/7m4+4DI1j9EjPVr6tKns5boFsgdfIsDMlk6eIt8l4rZVcFkrSBM1Ccs+WSoACh1p58ZlcEw9DxSkU8xsetR27QunuEUyWEYCJ3CxWgQTaSHedGtyiLnW/3SahQ/JGJYLewC0hghA7TJS+/pdFzhLxRoTA5YPOFer7gci/qS9njdK+58qd41FHSU4dI9fCrchk4CB5rXHvjH71WF4U3NtaKUNk2AITQLmw953oHWMjh9Xvngwx9+4uTfxS7sQdtnY9Eo42nVQ+h23SZ5h263nfqR4yCNtULd0zX0BAjv0Ux3jyLPlGYPg/ni/ToIxHeG/UmyzikAuh/WwAZW3z9nEa9GybjXX/oEsFftKbaGDdxrjUPlOJviVFGowIfX8wWFWurWthV2eM3PTphZ63Qt1uNLREmLbyOHRC33qHJ1bDL8Uun7L15EOUnU1Ud0e2zvdP/UMMEy6A7bl2msRN0Wy9xSiLO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6def186-bf83-400e-2b24-08db18de99ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 16:20:54.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdyC2jA7ScuVUuieRZiBljrCn5o35SjSimisEpw/hg5QoCRjpV+dCwKSJsPjd50utmxkTq03rA49taigw9RRH9CLRIXQsa/nBBnfKmnaURg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1066
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjcuMDIuMjMgMTY6MTcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiArCQlpZiAoYmlv
X2N0cmwtPmNvbXByZXNzX3R5cGUgIT0gdGhpc19iaW9fZmxhZykNCj4gKwkJCXN1Ym1pdF9vbmVf
YmlvKGJpb19jdHJsKTsNCj4gKw0KPiAgCQlpZiAoZm9yY2VfYmlvX3N1Ym1pdCkNCj4gIAkJCXN1
Ym1pdF9vbmVfYmlvKGJpb19jdHJsKTsNCg0KDQpTb3JyeSBmb3Igbm90IGhhdmluZyBub3RpY2Vk
IHRoaXMgZWFybGllci4gQnV0IHRoaXMgbG9va3Mgb2RkIFRCSC4NCg0KCQlpZiAoYmlvX2N0cmwt
PmNvbXByZXNzX3R5cGUgIT0gdGhpc19iaW9fZmxhZyB8fA0KCQkgICAgZm9yY2VfYmlvX3N1Ym1p
dCkNCgkJCXN1Ym1pdF9vbmVfYmlvKGJpb19jdHJsKTsNCg0KbG9va3MgYmV0dGVyIElNSE8uIE9y
IGFzIGl0IGNoYW5nZXMgYSBiaXQgaW4gOC8xMiBtYXliZToNCg0KCQlpZiAoYmlvX2N0cmwtPmNv
bXByZXNzX3R5cGUgIT0gdGhpc19iaW9fZmxhZykNCgkJCWZvcmNlX2Jpb19zdWJtaXQgPSB0cnVl
Ow0KDQoJCWlmIChmb3JjZV9iaW9fc3VibWl0KQ0KICAJCQlzdWJtaXRfb25lX2JpbyhiaW9fY3Ry
bCk7DQoNCg0K

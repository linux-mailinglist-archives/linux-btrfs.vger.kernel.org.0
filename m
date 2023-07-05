Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0644974806D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjGEJG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 05:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjGEJG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 05:06:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1EF10FB
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 02:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688548015; x=1720084015;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=LoW/W4kHuvS9o29qLQnXygnJtjlmey9YXQH1HDAQjx0=;
  b=pR9bNDT+TR+teAN7TIGk7R2A1bnD+RBHpne2BvxH1LmSbpSiNi4bK/lA
   Sdqpv2ryog9NcEgqseHRdjL6+cPiC8lZVy53BrScPA34YWk6NmLR64r2q
   GGJsO/dUnPIsMTBvaEhj8fOIpiJzOha2YKbXEt6RCGxHXu8wG1QDrzCbv
   3wuX1jRLDruA0XgyuxONsT6ZtC40U/Eqps6sCOvawhf0lz9qCZwU5yPYF
   Gxxa/OnCPrJRfQD+tUJeTrDUCsZH+OdCCTWxSK7i4LHuGZeQH79YQ5eIU
   NS6rTr8iX6euBK3x7Q/IebduBK1xZS/2bNRCHzpkXQ6ra5HUx/gYaoky8
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684771200"; 
   d="scan'208";a="342313193"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2023 17:06:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjKSVtuknQthKa2QcCLxOQk7+dHNn1rdsmVRClQmwGOFqvq8bv6DKtYxnIwitcZtu56C66fWphE15cfkt2fLhv8bYdXjB7fwvRNczfdaZsgJUF9REROsaqXpDxq4H4nZL0vAmhrJOJvMf+DzCe7OgAb5c3s/HPL7du5C4CvGgIbGCJNU/Ridh3KkWkYnf+fGc0LwM+Sn8LcB5YVaWTALX2m2k0dwcpt39S3v/zeqHy/+41iJdnvqUjzVlfMBSD19ZLKXrjOXVUsaCyM1sRjfnoGdpfRFYw1hMVpTkAwPoey5CH5345kg0XpFTOe9AQdWucBIEqwruSRRMxhEK7b2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoW/W4kHuvS9o29qLQnXygnJtjlmey9YXQH1HDAQjx0=;
 b=gxDccRT4Jj3cw15+DDuLDO63qzkoyApi9CaX4jIAYrBCv9zhhnH8kzlfaaSZ+J8nLcMsM6j/8LduM8J8p08+D1xu4wcc6KgoylM12+8v/1sSe0hRa0QKyk9DbP+yqsfUA2ikMCOLc+mX0Wl/2U8X7q7EjroCa/m3qgfPcOUXtbx1285bWqmfzWyRXI56dM29vbo8eAsmHYpWRZVaNaRPUfylfn7kek4XI4NK0HokMTLWxMAMSNYchtikhc4nbbIoMz/b2lxAGtL3+gunkSmwuwiTNhJmsdH1UXUjiydmj6Xnnd0MdyRPU3ojl8Bu8bdiGrVdw27zCGm+7H8dU00Msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoW/W4kHuvS9o29qLQnXygnJtjlmey9YXQH1HDAQjx0=;
 b=kUW/kNG3/q7BVjTLOS8bugjgKtSswHytG6oI+bDJvNwXENOjQGP8T3PodRTA/scaQZMJkkG8hBu7zWJ3uVVnem6YEXdNpNz0Meby6ZVQTTTlPvF5zrY7idlurZag6dKRGDvALGYjQceg/171fWAWLSvMVK572a/YWKH1JkIz5ZE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB9012.namprd04.prod.outlook.com (2603:10b6:a03:563::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:06:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::fc3f:4892:d2f7:bbbb]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::fc3f:4892:d2f7:bbbb%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:06:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: don't read beyond write pointer for scrub
Thread-Topic: [PATCH] btrfs: zoned: don't read beyond write pointer for scrub
Thread-Index: AQHZraRBpvICTBNaLkeIplXc4oA8cK+n8YCAgAA+uoCAAHOJAIACOkOAgAADR4CAAAN9AA==
Date:   Wed, 5 Jul 2023 09:06:52 +0000
Message-ID: <6b751aff-f94f-02a2-3a80-7506670c5c1a@wdc.com>
References: <51dc3cd7d8e7d77fb95277f35030165d8e12c8bd.1688384570.git.johannes.thumshirn@wdc.com>
 <1449f988-b5f6-3a21-eea0-44298ed7dd42@gmx.com>
 <96a5d8e6-8905-231a-b55a-876919c60694@wdc.com>
 <1513dfe3-8d58-a511-5279-c6bf1ecd0e0e@gmx.com>
 <76b099ac-ea2d-2237-fd06-72418c1f2492@wdc.com>
 <a7433314-802a-f713-2519-1baf627ad153@suse.com>
In-Reply-To: <a7433314-802a-f713-2519-1baf627ad153@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB9012:EE_
x-ms-office365-filtering-correlation-id: b9aa21fe-1521-4ff0-1e20-08db7d372c62
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jDZ9G0Eh0JVAX20Iffh909+5akE13IomholA9Fiso0g6v2RshejEQL0fmKcxQkF2wHyxZmFzdyVQs1f56e4GNss4nXJCOQUtT7YBtLvaWaZC8MHKix+R74+ivMfp729SohLy+0hhsIZG97ghBueQSWGXj9gnYO690D5YxJL0zBLwfZ+rrWph6k+lTRWgRLNdBn7QiHxP5yxilV4A4vHyllyiwy0jA7HfegCJKwucGoO1RNJO12wFMjoKejrcn5ANnSNUJaHksY/XMNsM5dTvQKSGxY1AvXXQi8lfiBi2CDm1gWUNFG/ADKmwhOyRqI4kmerRtYPDFW/oBObuUOZ2FhOBh3G9Jhx1cP4WIno/75uIwQb/BV+GJE5aUREqNWCv+0IKjqRCZXa68vGw57CzcndUSO0qXZnU+wjanL+eBFpN2ROvKY6kXHluMQezVfR+2PZAEr+Y/NhrS9PgPXBHVRmX4RfTJTph6TQq/2fWRpYJcJg6/9POn2xcH7YTJXyhjYs1tQbPD3t8K9c8nrMvpWBAjebDz4+mjHqycFwaXDzY6T1+AAwK8xfESN6bNieVoHxJrOfXcm3KeZP4Jot9MIfd6ouFgca9k0gLdUiK6MViuZ7I/iI0qyuIlQyTLXRrGPoK8xUpWyaMqHNonIfjZ3FzZwamwfzM1zCxAPKeXFjJFx6P8a3sfHH3vjxZrP8Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199021)(26005)(31686004)(66556008)(76116006)(66946007)(36756003)(64756008)(66476007)(66446008)(316002)(478600001)(8676002)(91956017)(8936002)(5660300002)(2906002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38070700005)(31696002)(38100700002)(186003)(6506007)(122000001)(82960400001)(53546011)(2616005)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3RMT01zNnJPQTg0UHBrc3hUVkZsT3BFSW14cDRUQXgwRld2ZmR1bVZnaW93?=
 =?utf-8?B?T0hwUkMwRW8vYTA5aEZJRmdVRlVDZVV2NG1la3N5UnQwUWJyRXBVV1pCUjVx?=
 =?utf-8?B?em9pUHRvUDkrRjlTRUN6K001R0pjREx0d1BCa1pJT2NGajQxdWFLNjU3Ukl2?=
 =?utf-8?B?OGl3Ymdhc1dzTWZFRTFjbGxyc0p5bUxCaTNobk04eEtUdHpLMW9IektOZUMv?=
 =?utf-8?B?YlA2bDVxMkNZdnIwMmpzTWJKamNOUDNCZjlNR09mSWZ1c1R1QVBIZHJvRDFx?=
 =?utf-8?B?dXVuSTkzUTRNWmdLNWRBQ294UG1ueHZ1UW5QR1VJaXJYbTBtUEQwSXNBNXVj?=
 =?utf-8?B?d29ET3dBUzNWRTRybm42WGZNQXBHR2NDNkxkc3NrMVozc0ZDYzllR0pudy9Z?=
 =?utf-8?B?MlgzOGYwL1FKQnpOVHJoYi8waWZuc3VKQ3dMc3VYU1JONUZaOHJsckJFZEFU?=
 =?utf-8?B?ckN4TGpSZFJ4Yzg0U0tUZk1SbWliem43aGQzR2x3SEJDZFB6V1VoY1BSejJE?=
 =?utf-8?B?czM3bmFLazBMWDgrRjRQVndRY1NtdXBjU2dGRk9vdUtoWFNPb2pDd2xjSTF2?=
 =?utf-8?B?c3Y0SDI2Q0tBT0twbEg0WVhLdEdXaFlRaWpGRWNya2VLQjMzekNwdlVSaXdu?=
 =?utf-8?B?MnlQOFJhVG1YWlBtRiswdjZ3WFRpQThvRkt3d1F1SDB0ZXdDRk9STjRPOE1L?=
 =?utf-8?B?QUozUlUwdUVjU2ZJOUI0bFdrM3FPOFlhOHhHQ2s3bDZKZEVqTklCbXNQaHlG?=
 =?utf-8?B?T1lkdDlEcmVkamE5RFZnRjdsZXBLTStRTExaVWpSRTJKQm56MFhVaVFBU2JK?=
 =?utf-8?B?aTA5U2liY3N6N1hheVBmZndNM1FwZUdkeElsWTlqcmxPWlhQTGRIQStXUXBs?=
 =?utf-8?B?K1RkWGVjN0dmWjRVcU5zWHRIb3J5R2Y1TWxRTmo0aHNZMUpaVkpaUWFHdEx2?=
 =?utf-8?B?K1dzTVMzU2lBOTl6aERtSERsbEFQQWFJMmNYU2IzSTRQV3lLZElHOVhudFcy?=
 =?utf-8?B?Ui8wTWhYR0xuVVZwc3dQV2REbFovL3M2bVJweUpwaG9yRS8yYTNjY0Evc1FY?=
 =?utf-8?B?V0pSazNmSjZlS0NQUGoyTFJEb0UvWHBwc2w3WDJjVGVnSDQrWU5TR29tSDh0?=
 =?utf-8?B?b29VVjN6Tk95V202REZwd0xDcHc3cHh6RndrdWZxNkZxMVJIajc1dlBoNyt4?=
 =?utf-8?B?SE1xZFRGUVo2ZEpMZk1zZEpRVUpiaWVFVVNUNStnMnNqeDlRdEZpUW96Z2lU?=
 =?utf-8?B?RDN0Z0lpVXRtcldlcm9SZVNKRmxFOFF2RWFDTmZDamdIQjJ4eVpVS1hBWWxy?=
 =?utf-8?B?aktabSsweUNjVlBYMkFLdlA1elloSFFpS3ZtZnFlYmRydEUrY3FFY2NEYUN2?=
 =?utf-8?B?MSsvOWJ6ejdhVVJ2ZmJWd0RaY1laSHdMU1JrYjZXUUlaSjJQbHV3Z0NraVlN?=
 =?utf-8?B?UXdwRjU1YXdvdzRwRWk4djVTWURpZHZ5bGd4Y09ublNUbHk3L0lsUnZVREZr?=
 =?utf-8?B?MlpJTDZPb1NDNlpjYXJ1SkJPRVhKTzFMb2pGUUhROThoMmdnVS81UDVpajBH?=
 =?utf-8?B?UE05SjVmM0R2NmcrdnYwMTZNSk5NeXFPOWt3R2puN3p2L1hGNnpEUmxUNjRz?=
 =?utf-8?B?ek1VRm5jWloyR04zanlROUViNWFqQzFWN3FSdUpEN25pRlBOQXFkaVRaRFpK?=
 =?utf-8?B?VE5aU29YSUMzcHNOb0NFOC9YbkwvSVVKVzVrQ0RPUFJNK3NOK29jZU4wYnhv?=
 =?utf-8?B?Mk5FRHhHM3RsZHJTRnJ1aEtVYVVGZUxZckRJN3BId1VVT0lSQmtFUGxOSjNa?=
 =?utf-8?B?TjdDMS9valJIUEd6ZzhjSjZIbjJhaDZZNURmbkdsbC9ydlU0UXVsRzF6OTRE?=
 =?utf-8?B?dXdveEVhVUord2hGM0REZ3NzSkliWEY3ZnpTZXNrb20zc01HTkFCSysrQldw?=
 =?utf-8?B?RXFtT0xLV0YwOWlWYytHb1FGZlI3Nk5ZOWVMRzF0ZTNXYVY5Y215NTgxKzlS?=
 =?utf-8?B?Rk1ZMDZXeWRrWDloU3dhNXY1RHFXeHdPRHp3b3Vic0p3N08yRXM4d3I5Ymcz?=
 =?utf-8?B?RVRnZitnNFBjekFYRGovd1RPSVNDdkNhR3M5VkRSTWJYK3Z1SXpLOGRPRjBz?=
 =?utf-8?B?NkE4OU9SQXlPSkxyMkJFNWkvUEl6WWtlQUVPTnZGNG8wcU50dmdqc3ZsZXpG?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B3F155A4F391648A2D3F2DB9CA6A067@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sCSaxWETPZMX5pZVrSZvl5khyPu5YaS7rQ/v3g6opC0XWQrOjJ6AWpjQ/dokfq6yUrSZHEDnKXBxBU6wAvfqPFxGq6hQh6y/YolYMMsfeYPrRW5M39JKsQJwBtFzTnz1Hh6XzVtNVKpckaNmaebw5YMUZM3EP2Xc2QZXWqJwMimGGJHk7y2XiFN8NhlkY2P0k8GuSMgcMz+k6fzbuBFBmK9uu+sdw/9XTseDQ+3Zf3hnfCPSzh0bzjnd1TcF+yvSpuigDgihPaZH/OdgoZLTLa78pC2lJETS0oIWonkPTWzc9Wj2nC3lX/pWs78/7BUt6PE9Qnu0DMEGJbRUDS0Oc95PBU6BN4P7WJpKprPyFIkLPwW2qc4FMRo6DoISxMR9+bx6Q+ckffaIsqTz2gSDvvIZyH9YA0+C7eZWz32zvOn6MSnUoRmr4vgMsmX3XfHesshkEupxjokypAtiokBQee5d7/e5JAnIzh+aBKLksF0SZe4RWf8Gm+2aCwqlKPZDnKaGHAwxFBVPFkd4KYzDskM/YSZjzZxbkySUoO72hGeoPScTEMWJfZDLgjkGuXpzhYCURkDr7hczNQIdFMewo91WHVEYSKRd092CVRd+FKWzyktfnFxgjtrZeO1xxooHDcEFCITBRxG9Tl2kCXm9hkC+rjZ5CSPHu1hz9wb49Nnkq911k+mluDLmzB0fCKKZmz19bM7ilg7TkBUupij3yO2ANl3v2K20UDQ2Liu4cDYU5k1jygb8PcIZfGm+Twj+VJ6p7E9Dos1fSuK6j4xZMS2joG29wvi5gp3MHw1ZFpYbL5blutupj80oXyNPSSsn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9aa21fe-1521-4ff0-1e20-08db7d372c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 09:06:52.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WziOUHQJsnLjsj/unYyYeAMx9MaR1iKhZGlEU8k7pDl+YzKWgaCNWD8OqXabuGV22baP8awvVVnJ50aAnEAQP5vLwA5Pa9g6bkBkDK17hOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB9012
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDUuMDcuMjMgMTA6NTQsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIzLzcv
NSAxNjo0MiwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24gMDQuMDcuMjMgMDA6NDEs
IFF1IFdlbnJ1byB3cm90ZToNCj4gWy4uLl0NCj4+Pg0KPj4+IEkgY2FuIGNyYWZ0IGFuIFJGQyBm
b3IgdGhlIHVzZSBjYXNlIHNvb24uDQo+Pg0KPj4gRGlkIHlvdSBlbnZpc2lvbiBzdGguIGxpa2Ug
dGhpcyAodW50ZXN0ZWQgYW5kIG5lZWRzIGNsZWFudXAgb2YgQVNTRVJUIGFuZA0KPj4gYnRyZnNf
Y2h1bmtfbWFwKCkgY2FsbCBidXQgSSB0aGluayB5b3UgZ2V0IHRoZSBwb2ludCk6DQo+IA0KPiBZ
ZXMsIHRoYXQncyBleGFjdGx5IHRoZSBpZGVhLg0KPiANCj4gSnVzdCBzb21lIGhpZGRlbiB0cmFw
cyBpbiBteSBoZWFkOg0KPiANCj4gWy4uLl0NCj4+ICtzdGF0aWMgdm9pZCBzY3J1Yl9zdWJtaXRf
ZXh0ZW50X3NlY3Rvcl9yZWFkKHN0cnVjdCBzY3J1Yl9jdHggKnNjdHgsDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzY3J1Yl9zdHJpcGUgKnN0
cmlwZSkNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0g
c3RyaXBlLT5iZy0+ZnNfaW5mbzsNCj4+ICsgICAgICAgc3RydWN0IGJ0cmZzX2JpbyAqYmJpbyA9
IE5VTEw7DQo+PiArICAgICAgIGludCBtaXJyb3IgPSBzdHJpcGUtPm1pcnJvcl9udW07DQo+PiAr
ICAgICAgIGludCBpOw0KPj4gKw0KPiBVbmxpa2UgdGhlIGluaXRpYWwgcmVhZCB3aGljaCBzaG91
bGQgb25seSBoYXZlIG9uZSBiaW8gZmx5aW5nLCB0aGlzIHRpbWUgDQo+IHdlIGNhbiBoYXZlIGEg
cmFjZSB3aGVyZSB0aGUgZmlyc3QgYmlvIHdlIHN1Ym1pdHRlZCBmaW5pc2hlZCBiZWZvcmUgd2Ug
DQo+IGV2ZW4gc3VibWl0IHRoZSBuZXh0IGJpby4NCj4gDQo+IFRoaXMgY2FuIGxlYWQgdG8gdGhl
IGRlbGF5ZWQgd29yayB0byBiZSBxdWV1ZWQgaW1tYXR1cmVseSAoYW5kIGV2ZW4gDQo+IHF1ZXVl
ZCBtdWx0aXBsZSB0aW1lcykuDQo+IA0KPiBTbyBoZXJlIHdlIHNob3VsZCBpbmNyZWFzZSB0aGUg
YXRvbWljIGJlZm9yZSB3ZSBlbnRlciB0aGUgbG9vcCwgdG8gDQo+IGVuc3VyZSBhbnkgYmlvIGVu
ZGVkIGJlZm9yZSB3ZSBleGl0IHRoZSBsb29wIHdvbid0IHF1ZXVlIHRoZSB3b3JrLg0KPiANCj4+
ICsgICAgICAgZm9yX2VhY2hfc2V0X2JpdChpLCAmc3RyaXBlLT5leHRlbnRfc2VjdG9yX2JpdG1h
cCwgc3RyaXBlLT5ucl9zZWN0b3JzKSB7DQo+PiArICAgICAgICAgICAgICAgc3RydWN0IHBhZ2Ug
KnBhZ2U7DQo+PiArICAgICAgICAgICAgICAgaW50IHBnb2ZmOw0KPj4gKw0KPj4gKyAgICAgICAg
ICAgICAgIHBhZ2UgPSBzY3J1Yl9zdHJpcGVfZ2V0X3BhZ2Uoc3RyaXBlLCBpKTsNCj4+ICsgICAg
ICAgICAgICAgICBwZ29mZiA9IHNjcnViX3N0cmlwZV9nZXRfcGFnZV9vZmZzZXQoc3RyaXBlLCBp
KTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICAvKiBUaGUgY3VycmVudCBzZWN0b3IgY2Fubm90
IGJlIG1lcmdlZCwgc3VibWl0IHRoZSBiaW8uICovDQo+PiArICAgICAgICAgICAgICAgaWYgKGJi
aW8gJiYNCj4+ICsgICAgICAgICAgICAgICAgICAgKChpID4gMCAmJiAhdGVzdF9iaXQoaSAtIDEs
ICZzdHJpcGUtPmV4dGVudF9zZWN0b3JfYml0bWFwKSkgfHwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgIGJiaW8tPmJpby5iaV9pdGVyLmJpX3NpemUgPj0gQlRSRlNfU1RSSVBFX0xFTikpIHsNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgIEFTU0VSVChiYmlvLT5iaW8uYmlfaXRlci5iaV9zaXpl
KTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGF0b21pY19pbmMoJnN0cmlwZS0+cGVuZGlu
Z19pbyk7ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnRyZnNfc3VibWl0X2JpbyhiYmlvLCBt
aXJyb3IpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgYmJpbyA9IE5VTEw7DQo+PiArICAg
ICAgICAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgIGlmICghYmJpbykgew0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgYmJpbyA9IGJ0cmZzX2Jpb19hbGxvYyhzdHJpcGUtPm5y
X3NlY3RvcnMsIFJFUV9PUF9SRUFELA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBmc19pbmZvLCBzY3J1Yl9yZWFkX2VuZGlvLCBzdHJpcGUpOw0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgYmJpby0+YmlvLmJpX2l0ZXIuYmlfc2VjdG9yID0gKHN0cmlwZS0+bG9naWNhbCAr
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChpIDw8IGZzX2luZm8tPnNlY3Rv
cnNpemVfYml0cykpID4+IFNFQ1RPUl9TSElGVDsNCj4+ICsgICAgICAgICAgICAgICB9DQo+PiAr
DQo+PiArICAgICAgICAgICAgICAgX19iaW9fYWRkX3BhZ2UoJmJiaW8tPmJpbywgcGFnZSwgZnNf
aW5mby0+c2VjdG9yc2l6ZSwgcGdvZmYpOw0KPj4gKyAgICAgICB9DQo+PiArICAgICAgIGlmIChi
YmlvKSB7DQo+PiArICAgICAgICAgICAgICAgQVNTRVJUKGJiaW8tPmJpby5iaV9pdGVyLmJpX3Np
emUpOw0KPj4gKyAgICAgICAgICAgICAgIGF0b21pY19pbmMoJnN0cmlwZS0+cGVuZGluZ19pbyk7
DQo+PiArICAgICAgICAgICAgICAgYnRyZnNfc3VibWl0X2JpbyhiYmlvLCBtaXJyb3IpOw0KPj4g
KyAgICAgICB9DQo+IA0KPiBBbmQgYWZ0ZXIgd2UgaGF2ZSBzdWJtaXR0ZWQgdGhlIGxhc3QgYmJp
bywgd2Ugc2hvdWxkIGRlY3JlYXNlIHRoZSANCj4gcGVuZGluZ19pbyBhbmQgY2hlY2sgaWYgd2Ug
bmVlZCB0byBxdWV1ZSB0aGUgd29yazoNCj4gDQo+IAlpZiAoYXRvbWljX2RlY19hbmRfdGVzdCgm
c3RyaXBlLT5wZW5kaW5nX2lvKSkgew0KPiAJCUlOSVRfV09SSygpOw0KPiAJCXF1ZXVlX3dvcmso
KTsNCj4gCX0NCj4gDQoNCk9LIGxldCBtZSBpbmNvcnBvcmF0ZSB0aGF0IGFuZCBydW4gYnRyZnMv
MDYwLg0KDQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgdm9pZCBzY3J1Yl9zdWJtaXRfaW5pdGlh
bF9yZWFkKHN0cnVjdCBzY3J1Yl9jdHggKnNjdHgsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2NydWJfc3RyaXBlICpzdHJpcGUpDQo+PiAgIHsNCj4+
IEBAIC0xNjA0LDYgKzE2NDYsMjEgQEAgc3RhdGljIHZvaWQgc2NydWJfc3VibWl0X2luaXRpYWxf
cmVhZChzdHJ1Y3Qgc2NydWJfY3R4ICpzY3R4LA0KPj4gICAgICAgICAgQVNTRVJUKHN0cmlwZS0+
bWlycm9yX251bSA+IDApOw0KPj4gICAgICAgICAgQVNTRVJUKHRlc3RfYml0KFNDUlVCX1NUUklQ
RV9GTEFHX0lOSVRJQUxJWkVELCAmc3RyaXBlLT5zdGF0ZSkpOw0KPj4gICANCj4+ICsgICAgICAg
LyogRklYTUU6IGNhY2hlIG1hcC0+dHlwZSBpbiBzdHJpcGUgKi8NCj4+ICsgICAgICAgaWYgKGZz
X2luZm8tPnN0cmlwZV9yb290KSB7DQo+PiArICAgICAgICAgICAgICAgc3RydWN0IGV4dGVudF9t
YXAgKmVtOw0KPj4gKyAgICAgICAgICAgICAgIHU2NCBtYXBfdHlwZTsNCj4+ICsNCj4+ICsgICAg
ICAgICAgICAgICBlbSA9IGJ0cmZzX2dldF9jaHVua19tYXAoZnNfaW5mbywgc3RyaXBlLT5sb2dp
Y2FsLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCVFJGU19T
VFJJUEVfTEVOKTsNCj4+ICsgICAgICAgICAgICAgICBBU1NFUlQoZW0pOw0KPj4gKyAgICAgICAg
ICAgICAgIG1hcF90eXBlID0gZW0tPm1hcF9sb29rdXAtPnR5cGU7DQo+IA0KPiBJSVJDIHdlIGhh
dmUgc3RyaXBlLT5iZyB0byBncmFiIHRoZSB0eXBlLg0KDQpJbmRlZWQgd2UgZG8sIHRoYXQnbGwg
ZWFzZSB1cCB0aGUgc3R1ZmYgYSBsb3QuDQoNCg==

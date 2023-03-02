Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623C16A81BB
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 12:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCBL6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 06:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCBL6f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 06:58:35 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659BCD
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 03:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677758298; x=1709294298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zr2pKqMfVlivK00Y6laC8smB6IHam4FL3U9oOi4MKYA=;
  b=GqLSUMB/iWm+ygjsLu2eKVbsiaemGsdBsA/RrS0mBtrYo7GV5mdUrEwr
   N+BeVXdYQRGVfL1u8p3d/W6Kvehsn4uXn38QTu97rkD7qJbeOX7pqLnSJ
   y1Z64Rjep3BFHkppPoWRgLraGwN3XPTsqgsMRYgG4bePgIw/TA9Or6/UQ
   UCVSw48jQ5ewNw8HKKQcu1tlWMcLMGQV91zL1rtiOaNG79DZpyru9Nhpv
   +4GlSLnd9o9F4KmtzOlCuhv+EVU1WigknUc/lSj5a80ICnTq93aj5n7xe
   DqO2jiQIb5oR7kWECZ4/pp4F2NIuF0oWVHHwcKKJFNdnl7YgRfIBNkyVU
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="229588554"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 19:58:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k08xCPuAKWezb4X4k9YztLCBg2MUhpTaGvYtA+CW0NOUGTfCYxRLt1R+GFyQqQulS0r8V+N1RiLCxnlBdWQTO7v7URHx0LUyB8cO/cs3KXj0rZaOOtG402Xb06/pX6he962ICumn7k5NtU5X93ROU2JkD5SGxzk6Q8hBXGBPUc/fUzhFxUVRgbhi3u4yzQKPMtgOE2vEGQydIifSBrrv2YjjAd+LP196qFl7Tii9aJdP2M1jLDQax++oY1SdC8WwTkbpJnT+5ThmVsfo/gS1AAYBArDttVeiIJoxojGOc5v5L00x0lAWJFWRU9Z9otE3TYj6JI6Phib3KxZYBmBxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr2pKqMfVlivK00Y6laC8smB6IHam4FL3U9oOi4MKYA=;
 b=VNWQvRJHEizW8qUoHN6fRB1i90V6rL9piaePATSiknziY8UngtRzvguFtxoSzp5PPZF29RUl7UJ+yCNGqvLpX/u9h+SZjePR/Oi7DLaD4gUt5U2QZ+cLMDlDhyRXMgc0ELmPETUWBzNowNFX5gmG4ZyR46XJuYx1grFK9zlBfz53Zbhuo6IJwBoC1jvQ0WvvCpGS7t/N1HBVMjx/VosJx5wBekkUHIYkdnsp8I6K+StBzbd5ITi0f0+Q2i3Bw8+bjV6ftwXn2z7+I0D9caCRS2XI1XayYhRXdnXkkKD1zSlfzaz9hDj5sLwcZzXfR8T+27EFlaK4SHuK4MDnygpSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr2pKqMfVlivK00Y6laC8smB6IHam4FL3U9oOi4MKYA=;
 b=HcZBRm2n/XgXSUrqXgYHl1CvWLXss6gHWgffM7CDCK70tCtsir/R1pM007Y8cwlivm1qqqtU/OVYkp6Me2NAswfJX7a+xT7LBqv1RnRksJzNajbq2UbFJHmKKlidqzo3xayKGOC/JJCrmXFgksfXT8RtEd7OWFgOfho9+w9y7FA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6758.namprd04.prod.outlook.com (2603:10b6:610:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 11:58:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 11:58:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZTOvFIu+8wyTHXEOnol2yZkL+G67nUggAgAAHeYCAAAWhAIAAA46A
Date:   Thu, 2 Mar 2023 11:58:13 +0000
Message-ID: <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
In-Reply-To: <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6758:EE_
x-ms-office365-filtering-correlation-id: 4b1d10f7-af0e-4eb2-e21a-08db1b1566fe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NVhKFwz+ITIwTFG+QOgh1sjM+xqt6uuo0KxoZejiFVzC5kXdr7Gf8lBFgBW/FuogFYD3I3oswvoHJxmiXHxHPAEuwZgu8Cl+bj5tU5YIe3u9ckTFtAiTBgrDNmhIvXOC7OrbXWsIG6O5CiGuB0JNoIu3PPbXJ01PijlAp1j7L6+0X3MC+HGokSmQfH5mqot8hWgng1e8wJP92oIQ6r28WDD17OCRgH7nXDOA0DEb9FKmdtICr1YXgthyKZqhi4kmSdGGYFXXqXqQBaINiXuGyM60PAZYYTdGX+QaN4vujCRxR7SivDxhwwt1ICUtAx/n28fitVoPHBM5uUzNLiIrhPP8LK0/tcwYIjSsudijOSUB8edwP+emZzcXfxf6VG8jFlBN0E13wTM1d8cl6Ajpea6zcxirYM7VQMgqwH3eawEgKA4ltrV6lQcna0gWeWySnwQiv/n/O9V2cSdB3ZaOfjXhhhJo3+qCFaglzFIaXCisvsV9SKFpcS3HMgxO+4g2ijh6qZZCYqvT2Jc6I92I5simQxxvke8HFbFoF6gxBCyGwDVqK73P/EDJy+oukr0J2csGPpGq0vaVJu1aR8jr196L+7vijbvr9TUDa5qK/C1kq+W8FVZ6uJzuC8HSvek8d0TCmRw1mvZbATcJSEcUkeASGdwtucpYDD2KrdrVhHaWaWJXjSUfFVaUIa0hxF6XHPrNXjQSpirpsgKn+DW66kylLjbQ/S/fIionrUKZL8u+8N9GVSVzbAcPouBHF5P+Cc8otJv24Tz9BZ5xEcjew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199018)(91956017)(66556008)(66946007)(76116006)(2906002)(316002)(8676002)(8936002)(36756003)(66446008)(64756008)(66476007)(4326008)(41300700001)(83380400001)(186003)(2616005)(6512007)(6506007)(53546011)(71200400001)(38070700005)(110136005)(31696002)(54906003)(478600001)(86362001)(82960400001)(38100700002)(6486002)(122000001)(5660300002)(4744005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHhwOGVaRnA0bnNHNm1OMnA1RmNlRFhocTBSU05RMVJiYXdSeGZDeFlNbnYr?=
 =?utf-8?B?cFdOZFQvU3VLZ3NHUVluc2VWcUJjcldidXk4NTNBV1JRQnJsQzRIM1daV1hH?=
 =?utf-8?B?bWg2ZlRZazRSYjUxWG5yOVA4NjlQWGpCS2ZIcDdUd3ZaTGJoYzRZd2JWUUpT?=
 =?utf-8?B?NW1xc083SHlKSllSblB5aWY0bnQycWMrOVhsM3NUOXExSlZ0dkljejJ4ZWhk?=
 =?utf-8?B?N3h4RXIyNm5CNU9TT3BSV2hHb0xvTVNnTG0yb1k4MDVKR1RnRHFCQWZaTTY3?=
 =?utf-8?B?YkxPaHV0Z0Ria1ZJZGUrbzYrQ2F6TkJTS0J2OVc3Y0toN2NTUDRMSHpEbUp4?=
 =?utf-8?B?Y3ZQMDF0eEJmalltc2pFeVYvTWswaDREc3hzMnlOZG9YeHBEQU1YZWx4VXdp?=
 =?utf-8?B?d25mc0RLd2ZxcEpMN1Bxd1YxZWhTd2RBeVBZaHBza2VDRjN3eXJGYnl2dWtE?=
 =?utf-8?B?emM0QkZsakhYSDA1cit4RGMybmtjZG93b1YzdWxWNDNrUnMraTFaNHM0eHdv?=
 =?utf-8?B?QWdXbGdQVURmQmVZT2h3WTA1V1czdHlQb01vZGFmeW9hZ2xleW9vZnZBQ2k1?=
 =?utf-8?B?UHY3ejc4RXBRNmNka3VvN1pUclZXbnBNcCt6d0VkMUxTQW4xT3FIQW90Z1lY?=
 =?utf-8?B?RVBVM0dZUm1SdkJINE9nVHh5UjN4WHdXRDNpQWgrbTNWWE8rTi96N0d5NUtJ?=
 =?utf-8?B?K0xGTHJIdGUwWHB6Q2FtT3R6S1ZyMVQybHl3SmJza0VGZTNsNUNFc0xWbGlS?=
 =?utf-8?B?OGUyNVp1TjlLUkdSYzQ5aCswblVGMWlEUUQzWmFKNVh2WnRHYk0zbG9ucDNu?=
 =?utf-8?B?bEhaVWY5eHYwZmppM0VST3drdEJaZnI5WUNaUWRzNEpIZlZjT0M1ZHBFeitW?=
 =?utf-8?B?UHhaRDJaR0hKUi9JM1pBU0kzOHVTTXg3enZrVTgwUDRiWnRERUcrNTg5V04w?=
 =?utf-8?B?b2lMKzIwT25lZ05lWUdhMEdTOTVlTXZnN3cyWkp4Vi9xaGZmcEtXMUxVQmpp?=
 =?utf-8?B?MmVmcnNvQnduenZZL0hrcktVMWxTdnFqY1U3eFMwM0RwdUFLdFVqOStHcUt0?=
 =?utf-8?B?MWhUT2VDUWxXaGN6MVphR0xEdHArMHJvQjRUY1V2RnZpcDV0KzZISzdNRFhR?=
 =?utf-8?B?cHJlSkU1VU16Sm1TVVlvTks0eVIzeFpidmpMNHVSWUpXWHk3eFFTamNnMXdG?=
 =?utf-8?B?UUY5UW10NzM4aURxVmhlcHNCWHduaTlsZWdyK3lSNFRVK0o2Zk0yZ0dGWi9H?=
 =?utf-8?B?eWNVS1hOQXF0OTVydW5rSjJqazBaOE9zN2xKT1ZiMlZyUkYrYkYxUjFoajFO?=
 =?utf-8?B?bjVkbkxhTHA1L0RhSnhpYUs5QUdsRXNmdVo1RU9jNzBJL3dPNkpxOG4wVVVK?=
 =?utf-8?B?cTRUWXQwRmpiM1I5Q0d2MW0vd2F3WGRHRXEvVDVLVHNWeEpEK3pzWUQ3L1Mz?=
 =?utf-8?B?QS9FYlJia2IxTU85WEQ5UHI1MFhMTnFwVCtpQ05oSHgvQzVBMDBhODUxdE9u?=
 =?utf-8?B?RUEzSzMvU2Y5Y3F6cUNvY2RycXRFYmJyRDJHS1ZwaStkUk5hYjVUVkZaa3dm?=
 =?utf-8?B?YWZIMEQ1VHNRMlE4bEw0R3N0cGdKSzIxdE9tQjEvbUs5V2JDRm1ZcFdabXM2?=
 =?utf-8?B?dm9JbEFQVXAyRVhndUdlRHpKaGlBVHJET0VZTEdtUGtsTysrL0FJSUdhRXJk?=
 =?utf-8?B?K3VJTWNzeG8wZDVpNjhXNG5zSk82djhIMW1ZMzdRbUQ0NFFvNGZka1BkWVla?=
 =?utf-8?B?cm5JSlo5SVhaZ3JLVnhGbkE4dGRDa3R2Z3gzZVN4dWhuTHlrcjB0ZkFDaW9W?=
 =?utf-8?B?b2hQRGJLL0YrWUVtZG96MExmZStOUE9GakdVdUl5WC93VDVlM2IyWGV5cHVN?=
 =?utf-8?B?MnQ0TXFOL3pyNWVRMFhvSjlPQlJzYzgxVG1NRTNneGw2L2pLVkpCUnBaTzB2?=
 =?utf-8?B?OEtrOFpGV2JmYkJOelJ5RVNsbFg5YVBYRVJuVUVBa25FTzVGZEk5blZlaDNk?=
 =?utf-8?B?dDc4YlJTaXpPWXdWV25SazlxOWRMTWNCdmRrK1FROU1YZFJtcVpteFFGeXYv?=
 =?utf-8?B?K0o2VGtlUU1nMS9YL1NWeUFSMVBjc1V4ZzZ6LzhzUzRSZGhrTXdIbExEYXBX?=
 =?utf-8?B?Ti9NZ2N1cHZSVkt1SmFwcThWakxUc0NXTGk4U2Y4KzlwWER4aWMrWEtvejhx?=
 =?utf-8?B?OERKQ3FSejFyWHZ1RzlWa0dOYzFOZlA0ZkZRUXJWRk1XZmdXM0xEci9HRDBp?=
 =?utf-8?B?UW5mYUxzYS9sMEFrV2VCNVU1aC9RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C16F5E420E35E4D83CD8EB88CD2F95A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wQKyCLRWulglzAkgmwACt8P1CQPIOPovICYcP7WnyJrv2iaIwBqs820rXX1ZImXRNwxblOobvbIIDVSkrE+E+20dqLQg0GY2YyZ591N6SOKaZmWSrdTOc68gfJG4wJseS/Skm8T2nq24weAaw3MK7cUWt2TFcQHsohgxuypVdGA38tAj5ytidwtLtgjD5aKmpR191Lz0URwMClVKPK7ms5y22hH1uM8av+XufyxlhSlFQby9HMxN8MkUicw25BEJY6tPBwvHX0QSzTSkmVIZPUl09UYzzvP6Bjb3HLiZf4S6HuPsQO7v3ITSIg3tSJd6m8UzJWZ0RYDuFZta50vdNvBTg5n0F9TzatjTKYaPGyjTa6yMOYLCsgisV2K2fk6nj0lTQw45hXNe6aSLcby/9Wk0/pGDovysp/yY6SObl8L5V6izs88qlBCVnNPyYv1PxUSOoj5CznVm7JHxFOJ91/2IRtODR7H9xXCZp1fbWn1IeVoYErf2d5f0kcojOdhkdk9e9gwb5pgrVwnfkdX3uvD0Om6AYf+Ab6sq3CY8HmGMDGW9MYmSnDQtObAzb3RicWFVd6ejHtB8pSeS08tHNUWY5k5tWVkixjxSqFsrxJIGoy5XsI+QNs8zjXwTgv6FF9VUIehzSu/yl2G+C6e1z82gC/DQnMJBGyfa4krW7eY1JqoAU3Mhla+iViv6npL5/qCAK2jFQdQbS/D7QbGPg+/su95Iyi4FnJowXmGR6bN0EtIzmBv1Lho7T+usm0Zty34QT5YaP27K52Tit7LSPvtwIiR6MH7ttPoEfoQGmJbbMl8z7EyR/h4Gaf7BkbCW+TIAOgalG+Y+kcXJZ0mWVw9JEe0D2Dk9Ssiz4DHv2TEjn126ywRmcdMdtAUAaJKB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1d10f7-af0e-4eb2-e21a-08db1b1566fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 11:58:13.8662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lh6nyDitXkLgFkUuvGKcFb6+BCEngX8Ou2lF4JEbdyGcawMTwaPqYr2DGI0HrQyuRDs+v8DfHe5THW+0sA8XgsEDEc6Qni3A0jPgmmWKh7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6758
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDIuMDMuMjMgMTI6NDUsIFF1IFdlbnJ1byB3cm90ZToNCj4+DQo+PiBIb3cgYWJvdXQgYWRk
aW5nIGEgY29tcGxldGlvbiwgb3Igc29tZXRoaW5nIGxpa2UgYSBhdG9taWNfdA0KPj4gb3JkZXJl
ZF9zdHJpcGVzX3BlbmRpbmcgZm9yIHRoZSBSU1QgdXBkYXRlcyBhbmQgaGF2ZQ0KPj4gZmluaXNo
X29yZGVyZWRfaW8oKSB3YWl0aW5nIGZvciBpdD8NCj4gDQo+IFRoYXQncyBhbHNvIGEgZmVhc2li
bGUgc29sdXRpb24uDQo+IA0KPiBBbHRob3VnaCBJJ20gYSBsaXR0bGUgY29uY2VybmVkIGFib3V0
IHRoZSBmYWN0IHRoYXQgdGhlIFJTVCBkZWxheWVkIHdvcmsgDQo+IGlzIGFsc28gZ29pbmcgaW50
byBmc19pbmZvLT5lbmRpb193b3JrZXJzLCB3aGljaCBpcyBhbHNvIHVzZWQgYnkgDQo+IGZpbmlz
aF9vcmRlcmVkX2ZuKCkuDQo+IA0KPiBUaHVzIGl0IGNhbiBjYXVzZSBkZWFkbG9jayBpZiB0aGUg
d29ya3F1ZXVlIGhhcyBvbmUgbWF4X2FjdGl2ZSwgYW5kIHRoZSANCj4gcnVubmluZyBvbmUgaXMg
ZmluaXNoX29yZGVyZWRfZm4oKSwgd2hpY2ggdGhlbiBjYW4gYmUgd2FpdGluZyBmb3IgdGhlIA0K
PiBSU1Qgd29yay4NCj4gDQo+IEJ1dCB0aGUgUlNUIHdvcmsgY2FuIG9ubHkgYmUgZXhlY3V0ZWQg
aWYgdGhlIGVuZGlvX3dvcmtlcnMgaGFzIGZpbmlzaGVkIA0KPiBpdHMgY3VycmVudCB3b3JrLCB0
aHVzIGxlYWRpbmcgdG8gYSBkZWFkbG9jay4NCg0KSG93IGFib3V0IGFkZGluZyBhIG5ldyB3b3Jr
cXVldWUgZm9yIFJTVCB1cGRhdGVzPyBUaGF0IHNob3VsZCBtaXRpZ2F0ZQ0KdGhlIGRlYWRsb2Nr
Lg0KDQo=

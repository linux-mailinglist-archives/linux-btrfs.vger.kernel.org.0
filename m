Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9B6BD6C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 18:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCPRMd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 13:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCPRMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 13:12:31 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15227DF704
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678986739; x=1710522739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=oZwD/5l0oQCTq9ud2iZCSr2Xp3CwDzLpryq3qSC+cB0Ny69l4prVOGEI
   vQNlS65eTOvQC0pkOK3x+Tqa0MyKUcpHEaVxxGk+GcLz9T83wannwNdB+
   zZmi0z6y3PzQ0NQjWfD4fUTRzwjrKuok7bVsgDg0i/8RIo5m23xhmiaDH
   G124wAyd1wEh38hq7+5Xvbwe8xqLGG54AEbrO89Kp/GaRzqp3Rqvw7tHk
   4WyOy3w0VaHQE7zVDH4kmQHm7jRmisPTuhtgqvhN2y/FcU4zVv2wNGzLT
   ePljlFsevC43MAj+JTUg53tRQdqo0Amwdlt+309EP/u0Z7cQIuy8TtnhV
   w==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673884800"; 
   d="scan'208";a="225591640"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 01:12:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4dK1NZhrOGb5nTPVxSNuGJa5PlvwXkwnkN8gq4Iztn1c9w4lWfBrc3AJZkGZnb+85XROv2tBEXcaCtBBM776SP3R3wiYqPziE1a7dYFu0apb3dst15NaxMZ80RDAq+UIC5ki5IGIrfxAaN7HzF88RpT1lbVoC61sfiVPRcFHD8YG4pur7GiHEIHwFMSKXMtO9AimyhgYLLQjXTsrGkKEeJRcnT/rT1kovR9gngnXSXLT4n+Eoy5/MhpTAwQiK4okyZeWseGXbiwOh7Kb14q0d2wj67JmsXqOqpCjrnczVu3jU0DGuirk8wp9M4YQEpWVpRS3DpiZFNMEp6LrJEvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=a9HYiKO980uT8RBNNxTGEDmkBgxPMoyl/RqqbfZIZP1mtag4P16cx6aYKMBcUkTOYLEEhwSa2FdMrz96ADderuPMzcrEpjHGWDeWMeNvSiODBHvxkLikq4te61m6hrjDSxCAggKIADiyadYXtxc81eqsnAI1jGuboEiPhuibR59hiNGLpoNgPHXNC1qULkVdUwQzGizZ2xVY/JxRqSQwuKS6WnQOmEaxmcfGP3wgYMQ5eH7R30/e+PGQPhOBZ/DJjios8Z7I+BlYclIXPX0+iF5ffQ0AeV+EGbFLI3CKPA58hy+8VxE+BMGty4TwpWai1uBdRr5Xvpy8feVIOl0P4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=iqW0yO8tm9GGvszttnc/uK0Q9e8aBHYfNCJFB7jy0mqxDXFU1ifHXaEwYBNUEbAg86Ei4pKaDr/x63F7Vqo3o6F6GcqTmruT42jHMxTG3vDjsLawk4lDXEau9/JopeCpnfXmyvd9hWikj4bCM83AFRrwcbtWkFzVR2ebInAiIS4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 17:12:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 17:12:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/10] btrfs: refactor btrfs_end_io_wq
Thread-Topic: [PATCH 02/10] btrfs: refactor btrfs_end_io_wq
Thread-Index: AQHZVpZb3CnWIpBBpkSP2Im92hwYnK79p7yA
Date:   Thu, 16 Mar 2023 17:12:16 +0000
Message-ID: <42170c4a-f48d-9a16-c079-f2612de10b52@wdc.com>
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-3-hch@lst.de>
In-Reply-To: <20230314165910.373347-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8549:EE_
x-ms-office365-filtering-correlation-id: 81f36b9a-0521-42a8-39d4-08db264197cf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxGwRhV2oSaIoe5D7BREMVkach8ZjC8ho9PhNDgYeEIr2Oo7CLz52VQbkYCjTCuuf4sl+l2ptx+8TD2YSRaCCWIL78FndbrnokEjcBFxQtMyPtzlSstY34xkOs9LPVNo7ZPcLrSt/nSsxYeSlUtKtuKcwqR6Fno1OZZi3fMQIx5vFIvN+e2y7pZ1ovAZdMCXVZc5KdplnNY2izV/poi+ueW9DRwDBus1zsWHlVCvtPPBD2j4hzWFqbww545j3RdaGW1nplIuh8oJtQRahU47A1SqvmjqmLGW4NJJ8jppILvj5q+ZEtFLff56hZnq6nu7tsSVPcgDADKbt9itXo+ZUphlrL2naFYC7ZdvdkTeRolHkVuSuT78gdE0TnNZIPsMX3LEvoQNvNpkMQxOUXgVCrJ+Q5OujfY0ImymOyB7r67xNG9ubX9oYVa/HGOxPvMdPSVkxbZToMoKQlEmLJPi5G315OPBZu9yCsH2ui20GaNRFs5vMpGtPPwGJkRPdoPolTbH0bxUrZqAP6l5tGV8+dUlGlpioCmpvv6q3gnAMK/pW/rc9kZ//WFCWKaz+ZVdMZtORJBnR9BT9wJJr+1XQzxXFJTKHeNX1LbHjAv6cXg07HoMGxdR2xFaE3PDF64BEEzTEs6q1uRnMjhPZdnzrfBVcWy8MyuMsZSieAbwR2bRL546xKOiZ6FtdIVg5RcSHQvJSMUjXM7lbLiTiNCEAwudFvwXcdABuURYXCNSBduWAbwMx3apO86xBUxg9VksbrxZR1ETaQlghUPmia8f4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199018)(6512007)(6486002)(2616005)(478600001)(71200400001)(4270600006)(6506007)(186003)(558084003)(38100700002)(36756003)(82960400001)(122000001)(38070700005)(31696002)(86362001)(8936002)(41300700001)(5660300002)(316002)(91956017)(66556008)(64756008)(66476007)(8676002)(76116006)(4326008)(66946007)(54906003)(110136005)(66446008)(2906002)(19618925003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1NYd3FyakxEa0NJVkR2MHR6ZzhZR2ZPR1N2ZHZpRVYwOXpBa0FEaUpxaU41?=
 =?utf-8?B?d1pFQWxaTDRkU3VyNEZaK1djelc1enNzb1hSMm5WWElxVWl0bFF1QXV3Z3pk?=
 =?utf-8?B?dDl2ajNnR1kwTVd1S1BTdm13cEtxZUs4R09EanpzNVNYcTNTdWM3VzI3MHdv?=
 =?utf-8?B?WGNHcDR0R2RJa0hubEJ0ME5hYmNKdy92enhiTEc1M0VtUWFMdkVWWUxhUDM5?=
 =?utf-8?B?dVFtR1lJWEk5d3hKVXJyb3FWNTZxWVR1NGt1QXhEZ2hheFQzNVNoUWFkVDI2?=
 =?utf-8?B?UVZlZHBKZXBTYlNpc0NjVFNBdmEwNWIwK0RVYndzeUczaUd0M2JjSHN2eWV6?=
 =?utf-8?B?WFFGa3U1ZFRFM1EvZ0hDeS9OZm5heGNIR1dPSDBEYlBNNFozMHpIZzgzOFkv?=
 =?utf-8?B?Ky92RlFpNjNvemRRNzZaSzBZUFVMY0ZBczBCczI4cE9iL29SVmdHS3l0NE5i?=
 =?utf-8?B?QTQ4VE1FZVpZUlBKLzA3ditXVXlURUxRR3ZPb0JwUEl3UlVkeDB6dmYxQ0k1?=
 =?utf-8?B?WGxLa3hrZVpUd2I2MUw2bjMrbFJQVDBoNmYvN0MrQU9udG16UVhJcy9hNUd4?=
 =?utf-8?B?NTdNY2JHUmpzb25FdHNlVWxhTXNKT0dxUGJBbHVLYjNGM0pPbEtPRXNWaUZv?=
 =?utf-8?B?WGtnSmd6dXF5dEFBUW1rb05OSk9VamtveXlZNzNBd005bFA0OGI3L0J4VUxx?=
 =?utf-8?B?cWJWdlB5Y0pyd3VHVXVOUjdNQW1LSS9JaldvdEFaUGtyM2NVcXNYWUJLWDV0?=
 =?utf-8?B?dHdxQ25UR21TbGk5ZWcxZG5pY1ZXb2o1eHAyYXFxYXRLenJnRUxYQ3BCRFZL?=
 =?utf-8?B?d2x3TFJBUCtXR0lkU0pVVXo1ZmFnZ2QydDd3MVBPSnVsckpKalkvL1h2SlQ1?=
 =?utf-8?B?dnJyRVU3Rit2MUtYQzB2L05LMmdUaXAzcjVBN3NFSEFFd09CelBPcExFcTA1?=
 =?utf-8?B?QzZBTFZEL3BSYWxKRVVFVXplaW9XMVphS01lNjF6SEZwazBxU00zNDc1QmVt?=
 =?utf-8?B?Y0x1UkVmR2g3VmdVQzNYSW8rMGVlWS8wT0ZVZmtOVWdTaElGdnBCcUhxTWhy?=
 =?utf-8?B?SXRpd1g5YWV6cmJ3V2xNcHErRmZScCs5VkRBNkNYWWZVVWt6bWNTRWZSMHRX?=
 =?utf-8?B?U0xyUnVVYmEwWE52YSs4RXNCS0JTbTQ4Vmtla3Uzd2RER2c5OWRBbStZVVJx?=
 =?utf-8?B?cGRCS1I0WjB1YlRYc0FIUFpzdHJxUmFNaHJQWmdZZDdaM3NtRnZTaklZQW1i?=
 =?utf-8?B?bGhJaGZ0aDg2eVM0T3ViWENjbTlsR0pMVXhLRjU2bWQ2Kyt0NE5TdnBNWlBz?=
 =?utf-8?B?U0taQWhaeEV1eUJtRmx0VDJES3ZGaEdrQ2VmWWpIQ01tVWIxSEd0UlBNWGtT?=
 =?utf-8?B?Y1BUWk83UlNTRFFpS0tiK2V0eERVTlFaSWVBUE9wc3lxWnRmSXdLMVIxd1g4?=
 =?utf-8?B?eWpGRVpvdWp5KzAvYmVtM3FqTUZVRWk5Z0cwREk0VHQ2S05pUkJSblJHMnpT?=
 =?utf-8?B?UG1rdnhJRGF2MW9hcXNXRTJNMjhuT1NsYnRXRTFiSDVGN1lrNS83ZWMzWVhT?=
 =?utf-8?B?VnRERVVsMDcwaWVaTEpmZFpzSFRSaGVRVU9KaGlPNW5ocm05alk1STY0b05k?=
 =?utf-8?B?TC9Mc0JMNndONVluWnlndmExL3BMRjMxQWdrMkc1UVV1UnVYa3pUVyt0VFRt?=
 =?utf-8?B?aEN6ZjhEOGJGbzFzcXVqNkVDbU5UT1V1WVhjNFFOMTZDSkN3SDU1Z3hUV053?=
 =?utf-8?B?TW9TbzdXazVOMUFXR0N1OWthRzd3a0w2YWhVNzVRSzZYOGtHUEJwN3hOVXh4?=
 =?utf-8?B?Vlo2SzFwd0VhSGFBbzRKU1ZudXY0Wnk5WkJLVWlrSTJsdUFwdi9YVFBSN0dO?=
 =?utf-8?B?aXEwSWVWeTZCWjlDTG9EVTcyRWF5MjljK0N1a01KMmNMOWpRN3YzcFVQbDZG?=
 =?utf-8?B?ZFlNaExLa0I2N2EwbzBDczN6ZmdpdTlhVUJmSEh2MjRmM2tHZEovbkh0eEph?=
 =?utf-8?B?WXkyZWsxemoyVTRxbGpPTnNmYVZSZHRDcExPaG5hVzRYZ2x5Q0ZJTmg4dkJo?=
 =?utf-8?B?cmtudEZOVzBNSXRQanUxVGN2a0FORVJvL0ZCYmM2YTNiQU1BeUpRaThRdC9v?=
 =?utf-8?B?eHNTcktpd3d4U2ZJcmt1SytYVEJKa0pua1BGNGtJeTNQeS90aVA5TFVYNmlL?=
 =?utf-8?B?VVM2aHlzd0hNR05VR3VIMUlsTWwzU1dQamFjRndnZ0s0N3ZNTVNXOGx1b1R5?=
 =?utf-8?Q?jLEFXbz+7k0taXe+CHO0/Oyo5fd/IfqMomcyIFM8a4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE04C4BBB7134E4BB48742A12D9A9C60@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 88gZ0qg4oDYMViPc0pnIYgZsaIpeetRuaOcWq2Hcixc+37zWc7c8t/QlzcYzgnXvb6h0/XtjunyPz24UUrmx1S6XGW4BLmv47N1EXbVCS94vu6rL5C2AZ/mH0DbLm/QaAtWh6r8ascgEnrW7JQQriig6vsyqtcGuIHlwfUMnfpbAUzYUszc1LMG9rfX2yJDfYIYQqM1hg4wWYY2xUfWQ2gKpqCSAglNNi9wefXgAP9BIHtKlup3VAYDPE55qfY0AmCBPDKWIM8fzGHoqZwFYCzmWu3PB2g8dM/K/0SE09uZMtyaVsWeoIWEBqC7EUdUR4iG/3snmbDgGjZ77LXl4PFrWxt2QDwY0jA8xtXGg+SsU/1qTcs1NpcI5Rb+axOKTGeWFLREc7IfFRC2Tu6XpAt0mJKUHcZZqsXx1cbddw9K/Osgum2t+cDwB1+RQ7hU7orBGIs1bZc4MKTH+iG0Oify+nbQI1kECwkZImcLu+na+kLukeEFkm70FVxDEXMzqZKpnAP+oh8E2Us4B/ttB5MxE1qKGQvN75d0QrfChIOFang9J6DoXgJi8vAb64zm5t7eYul3XpUuZ7+u6oQ/6xzaPq999Od5nv2tj7pGke2oKpi6Q+0mdzLtPkqZB5SkAdVd0BVKmBuMwZw26oU4EJBOw1dbm/aJPDBAuAx0xxyV1sMM2U2I665EJN4xNLwzKLztBrBZ/l/aXoRLDQF70Wzegh4jx6NU7BmJuFue+Z17mEX3uK7jAy1T6KLUywW3nSDiIR/iR9fBJ4og1BRZRP7RE8l1NHyR5zBJeCw6iMMNIVF+ZmsnaeYIZ8I4hjnpqT+0UXSEdm4LaYwNye/8xprpr+XtpQZTxKf0eH4K7B8N9apOYmer43Kt/CDM4nvf0rLg0A4XsnyBsoFiZyWJroyMYS1nBPJz8uAqHv/NUMJU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f36b9a-0521-42a8-39d4-08db264197cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 17:12:16.4258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgJWDTo9HD56XZGjkZGo5sP1fezumnXsnI8f3S6bfbirjaVUBpsNWRxowyWQdsyr1EwADp7PWn8VOjxv3u7eqAGEMPOxMLe8D6i0vjU4+Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8549
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58A79C6A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 08:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjILGKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 02:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjILGKo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 02:10:44 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470773583;
        Mon, 11 Sep 2023 23:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694498994; x=1726034994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u9+Sdtgn2uGepPkFs8CwsmHxMpzo5WLxz2P1d1ogqVM=;
  b=A7XU0qBOKCR3r+fm4Y36hFJRLpk9N9wzc1NmmzuvDYjItoaGZ3LvUdH8
   447WNVdZrfCUeP3Y6i8CjQaINwkznzltIMn6d4fv5swyg54gbl3u/IGL9
   RE9PuecA9xX1NUnPYHlYmUdERu0DmVi7RBESwqNkyqEis9e6fXupFDTab
   5AAZU1M+tCEp4v2CX2MlEB+uzDwXjDoGLbTQa9nrDaTYOK7rIzuKMgjs1
   yOhV2CaiJV2DYmd2GtQS3lXC8OjvQHqtVJj3sM70HqVhPE3nnGuiHUdiR
   aqFuacAacB9qN+z9PezNO5uygxmhCABuMLBlqRMwqDB1NrSkmJRNpuPrQ
   g==;
X-CSE-ConnectionGUID: I8uaVd9GRCSABGJbs1H7Mw==
X-CSE-MsgGUID: oXYI3g7eQiWY1WL1g+Z5lA==
X-IronPort-AV: E=Sophos;i="6.02,245,1688400000"; 
   d="scan'208";a="355790375"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2023 14:09:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D901ot5FeXbbgHBfMQpVVgWdfz+xGHNq8gJNjJJznd/9JJVNZdUgNT9Re2AS6aRgnB9Off/aTQZZ5QxEpUUDxuZL2WPL0qEvwHRsRAwbTwKoUkwStElOsqqY6DWGOX2BkkYCZ4+1XXwDq+vAuf/LqXKHbHlUEEhrfbvm3SsryfyPsULVBm0uA9RZyVsLgOw+QF6ti9nuVhhxQdecLsnPIalqb5bpxBp8UKnxToJVVNOvuUrBC19j2CI7KFAh+sIt0HaEg8e2RV6p84rXp8NukRhdd882rwLdQbBiG+xpvRmo0EerxSRb3Gyhx3nkRhD3hNzIA80FeboF4kTfXYFLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9+Sdtgn2uGepPkFs8CwsmHxMpzo5WLxz2P1d1ogqVM=;
 b=RUElgwYs+0ES4spycri0NypEoQx450Z++qKmCXTOnnPSlFj9nm27DAbkDZY4iXaTwQvQc+RFh/rAoBIUzJeEw17BCZxFgPEf3Tlk5WJD70TpwOUCTuZYky8jDdIU4xzXfuo7OyheiR+ErZoX/41xKjSu4LHfOTSuQYW9UdGxrbLZF/LsbEAzy3bOK92AxNwdYLqKXBDSCEslEWW7PZTMOY37VgJM3im7fCf+l74PdrO+C8JQYyt45MYOU2h/yfkytIgx8wHETbN9UpyrZHLLeazrobLJUSZmSmTYVgJpKXO6IBHRW7H88svW5vsHocZg/QIHt9O1pzHjTdnLKvWBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9+Sdtgn2uGepPkFs8CwsmHxMpzo5WLxz2P1d1ogqVM=;
 b=Rp+smFSKqQd2enysEPTAaHa1tJv0Pt9hviGEk1ep9aZEaRI87JF8q76Tk54HKH3SSQOJHd02tgUQ/7G6v+aJ4UG/euz8pJwBssSjhtT/zl7i9lxSK1BmIuwKwgRtiILOBPcXcD0uNgxpL19CQrHhvUK2KwH7dKRHMhZ/OMAWI6I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7456.namprd04.prod.outlook.com (2603:10b6:a03:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.15; Tue, 12 Sep
 2023 06:09:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.015; Tue, 12 Sep 2023
 06:09:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
Thread-Topic: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
Thread-Index: AQHZ5K7VvXFOkD3Ns0eOcpvmKIx9uLAWHIOAgACZmoA=
Date:   Tue, 12 Sep 2023 06:09:52 +0000
Message-ID: <6d3b0ffa-2c12-495d-8b77-2eb8afc83e93@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-1-647676fa852c@wdc.com>
 <9cae9239-2a07-6477-da53-275944e8ce25@kernel.org>
In-Reply-To: <9cae9239-2a07-6477-da53-275944e8ce25@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7456:EE_
x-ms-office365-filtering-correlation-id: 50517e59-7f27-47af-5a49-08dbb356e0bf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yl4vJucMuE/+ZXH4oly0qNXMc3uppRlZeIRA43BAPo32MQgOzEJPX9ld1eOVyomH0wzX2bMdi8lsVlHu6JPY1HWCEO2mfT8ex4sf1PYYKpxVcomFYfkGVjaKcLtpxU7ROIr/rckKEIW4x8DhTAmtkK8HzjU9mOhQ/Px/+zTbhbf8ZG4ztp+kTcAICA+MU8OJ2pruHGv+x6Qkt8dtw3jr2jHiJcKphSqbW67koO7v6eQTyTHwKWXvXIi1i9fO3jycNe4p9ORFg4lnxJS0bkCd0X2XmtxrTsQTBtmhq//fxMPkLR0sblSfZCJ985IDGAgEZvSZyIGUDUPXb8THzBZvBsPuOqXHjxhALZIRwxPItIth3XPnX1qZJ6bd2yCSkzI1N0w8bPlMdKYMwKOHA/YWtRMDlXdO0Ua627mGDrkgzsX/Uh0K2esjiWzUst8gy8GG+1kV8JeJ53hZb6e/bvn4SupkhBAr4ihj9RY95NYpnQpFBLvaw9nG3XW8WR8UHlLYaDxle8ZDwvssc8r7MHJehC4KYF2nvsLPZsx8X178BGmlst2AvRDetByL9kiV0j370VqVbq4MlScxkvvBB3mf0JSJ2NNnD2e6m+H87itdLQexjtjd4ZTTWIek7yYdRx0hYSKiW4ng7M1knOLHeir3uMgMXX5OOV2nQRXXNBRttMTn/rurH3DqmlxjDAHj7yA5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(186009)(451199024)(1800799009)(6486002)(82960400001)(478600001)(122000001)(71200400001)(53546011)(2616005)(6512007)(6506007)(38070700005)(38100700002)(110136005)(66446008)(64756008)(66556008)(66946007)(66476007)(91956017)(76116006)(54906003)(31686004)(316002)(4326008)(41300700001)(4744005)(31696002)(2906002)(36756003)(86362001)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWxMMXoxN3RQYkQ2bXpvSG16K244bE9VMUV6YXc5cTJLdU5IZVJhWUpoWW1L?=
 =?utf-8?B?VzU0eWc5Ry9xWGJPaXhFMlRXSWJUdm41ZDhPZ2pHYTVhdUp1VGNKQ2JVK0Mx?=
 =?utf-8?B?eXZuT29HNU1WTXRkekFwTElOS0c2cTh3Uk9TUDB6MXRJVVZkSUVhRVNDMHBU?=
 =?utf-8?B?YjFPdDFtaUJUY3QyQzlZeTQ2NytWVDhMMlVkTE8xR2FNaXBwNU94NE4rMnlU?=
 =?utf-8?B?czdUN1J0UitvRXd1Tnh4Z2dVSktWaUxXMXZ4NXhVQlcyaWdxbXFEZlI4WkZy?=
 =?utf-8?B?MHd3N1pkNExWUGtGTThyZDBrUHViMnYvSi91YzZzLzM0S0g0MmdLRm91eXB3?=
 =?utf-8?B?eURkMkhmM0RKRTZlOXdBOVE3UkY0SmRHSTdXZEZHNExqdk1qRXdELzF6dlM4?=
 =?utf-8?B?cGswWGJMeU5KK3p4dVdSREQ4SkVWMC9pWm9nVXgvc0RGZzFYNVFNaDNCVG9y?=
 =?utf-8?B?M3dHTk5uTzBqajFva3BMVWJ6RDYvV000WUJOTEdNOTdEcWtIT1dIV0tkZWwx?=
 =?utf-8?B?MXBzQVdTWGJFRVZlN2ZOMU9aMlM5SStnYm5uRWUwZzJkcTRFVTErNXdlUHBa?=
 =?utf-8?B?WXJ5TWwxM3phZFJFTkQ2UDNJRGRRbWMwbWZsOWVYQXQ2Z3htWjROdUw2Kzgx?=
 =?utf-8?B?RFJjZ2xtTTd5VVY2OWJjVDZpSUNvckJNOENRZWxHMkxjSU10QWliZWUwelk4?=
 =?utf-8?B?VzlUbWQ1TzlXUTZSd3VOWTZGbWhRNnFEYXFvSFppK0dyS0NZSUJxQTRHZzdE?=
 =?utf-8?B?WUZZRXJaVG9rRHFJV2hDaTdPVnNrME42L1ZIK3ZZMnhqWWpmb3kzRXZVeE1t?=
 =?utf-8?B?b1hTOUk1TmkyUUVNSmh4SmtZSmtHWjJRQzUwRmVrRVpVRENpVkxNbGxxc1NN?=
 =?utf-8?B?L0dJUzJEQkNDTDNJUjV4Nmk1ZTZhNU1IaGNIejZDcU5XYU44SFVQWXh2L1hO?=
 =?utf-8?B?T1dTeEJLU0VIRncwRXBsMExyMjRrMXd2bis5NUwxNkFxZDZ4OVgzK1FBeDRQ?=
 =?utf-8?B?cTI5L0srakVqV3EvQVF0VFNsd2RWL1hUWnN1SVBYSjFhcTZEZGVxRVRndTcz?=
 =?utf-8?B?cTJQdE5kQUt6MDlGd09wTytLQ1d2RkdRSDFGU3VhWUxaN3RlbDIzcS8vT25D?=
 =?utf-8?B?Q1N5a0ltOGl6K0RzcE1GeWNBZEoxS2ZHTU95akdBdEZ2cG1jdkxhUGlnYTkz?=
 =?utf-8?B?eFFQc2JZTndBakRzM25oQ2Y1aldmSVdvSkN2aVRPSWNxcjQyZDhsR0pDdjlo?=
 =?utf-8?B?SjJoY1NDWko4KzRldElmNWNHMEUyRU1BMC9XV0V6Zjg0Z3h6M3NZcUdhcklU?=
 =?utf-8?B?b2JLR3hNQUhNZGN1dTJUUVFXdkc0aW10NU1YdFNLYzQwdnBKSnpUblUyN3R2?=
 =?utf-8?B?VkJxc012STU3Z0R4UkxIaDV0Yjc2NFl6VXBXbjQyQXUxUjB4cDh2cEQwZGFX?=
 =?utf-8?B?N0UwSm5hdWYwZkZZeHNydVZWNlBKdkZaU0trdHVadk1JYWVwc3FsblJaUGtI?=
 =?utf-8?B?ZlQyd2NlbFdIWmVISG96K2RNWEZUd2UrbDRXYmtrcUZKMnQ3ZlNSMlMrL2Y1?=
 =?utf-8?B?VGNoa3VhNDU2UE1VZ2lOZWx0VG1vajY1a2FJQ2EzeWZVVmt4bnBCSzg5ZFl0?=
 =?utf-8?B?YSt6NFB3YTl1RDlrWVNFcEVoNlBOcGpyRjU0VlRXQlEwc2xCRzZ0TVErd2h3?=
 =?utf-8?B?Um5GT3VXWGZnZGxsSXh3WFhibUY1d041cjlQTWNNTWk4a2xsUG02d1hPMDM0?=
 =?utf-8?B?a09UbWJNMk0wUC9HWVgyZTVFK1g2bjRoYklhQXVBbWtVUjNBZHgwRTBBa3JD?=
 =?utf-8?B?R1ByQ3lCRmN2YnBKb3NGUkhOOUdDdzZSTm9JVm5sMkt2d0RCMkkxKy9adktR?=
 =?utf-8?B?aUVLZWpGUENOWGtrL0hqbHIvUndBQm9GandPYkFSMlE3WjNhcTR0eW9iOUVV?=
 =?utf-8?B?d0pKVVFDamlUSjJ0c1ZuOXJGeHBxMEkzTTZjL2JoYWRqa2FkTG0xck9NR1F5?=
 =?utf-8?B?RzBkaHMzTWhYSVJ6Q05xa01RU2Z0aEkwZFVKZmxNMmowNTVtTW5pWDlFQzVL?=
 =?utf-8?B?M1c4YS9QaEFCOEFEckpGMVFMMkpkNVVJbk5BMy9PQlVFbmpzZk40V1Y0VHUz?=
 =?utf-8?B?aDNlbmw2L0Q1aUptcHdhMW51SGJhbldzbHdhdFVFV0E4ZXNUeW9QVU1xMzAv?=
 =?utf-8?B?OTRyZG1uT2grclZScmx4NzFwM2lWZHJOU3RBekhROE11bE1ZNityY1JqRHR2?=
 =?utf-8?B?Zlh0NjNBdGpCTmxjZ0xkbzlid3FnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <220B8BED46388B45B535336A756DE814@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wHhs5/+5H6dv3Q6wizoskQHEvwdePYaM3eP19WBCl4gdIjtEaeuPrSgFDXUQZD7pmZ7IUOVazMf47iLaxfCvuPauU76KY/x1v2WlCQySJOL0MjvQDf2k+/SIaIArqavOQmCvX9oAdx6j0nfs4aACPicCpc6NJkHNEx0yx7IHYL9nIqsrdm7bLBSQZH2UbF7RvYHhTNXGn58tNbBuR40csiBs9AAch+Mf/JYOhMQW8Q1uGIpvWppGXdtiy+umHaMaElNnx63SkeB0L0UnWsXFnY9KD45+QEmhJ2ED1XmavefbTn1MyqRwYX4OAld075myCKCi4sspIgOpoY8mXzQd0p+s1m6nVh57AbrdLHFhbz6U5K1AzAoVdLf0eom4ZzpCIcI9ikwyrgdvCCR7b/Bkmu95bFiSI5staP3QUb+6N7X+Q1nq2vPxPgmHKlZ8bg5serdMRDMw2gy/w2S/QSj+LKKuH6fumr/D2B7wGxvqvnaxrI7vwTL7c8FR8BI7Iu6a1ckeblznbVMhD29kfkaklMJ2zXfbsxXEH0j7jJCJjGqI1/CRbGReJgm0AYvYIGb7pv5UsR0G8RI4xrs81LMgp5KsfCeexpbWsSUIdX0Q//IaiqtPooVgcjpP0TFiVSYQ/bZgf3xqsVZA5qWTbOkbeoACQ3zhSOs5R0+KtEwUuKFPbe1aRf9kCnJrfUU5PVwy60rWrtyaTNuaPKmInjlQ50PXa5v1GYlugvV80HU8fKIgkczGvoHMRRYr9UxEdJ/o0UT1meC7/7alXcn5oV7yE0MKgGbNGO6tabkFcC3PLXzDUZcjpqTIDaLY2dr66KlhZlmIyQeJyGKLAt0DbkdewImPlv2aOexHV978ioNrcN/Waidi+xn/BtiXwBqaXYjOwPWNQ82diKz84yXLV/Q/E92ZeE3ylxf8fT7dZUPYFCU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50517e59-7f27-47af-5a49-08dbb356e0bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 06:09:52.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WaUlDn/+TVe5GAxU9hPVyaHtkh4aa80qKfKCJekP7AbP/Le5DRv0gYRFWW+WqSpegNyjfwCOTKMKb3bhqRxyCw0IfdpMj6p1YKvEPIrJVAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7456
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTEuMDkuMjMgMjM6MDEsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvdWFwaS9saW51eC9idHJmc190cmVlLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYnRy
ZnNfdHJlZS5oDQo+PiBpbmRleCBmYzNjMzIxODZkN2UuLjNmYjc1OGNlM2FjMCAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9idHJmc190cmVlLmgNCj4+ICsrKyBiL2luY2x1ZGUv
dWFwaS9saW51eC9idHJmc190cmVlLmgNCj4+IEBAIC00LDkgKzQsOCBAQA0KPj4gICANCj4+ICAg
I2luY2x1ZGUgPGxpbnV4L2J0cmZzLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0K
Pj4gLSNpZmRlZiBfX0tFUk5FTF9fDQo+PiAgICNpbmNsdWRlIDxsaW51eC9zdGRkZWYuaD4NCj4+
IC0jZWxzZQ0KPj4gKyNpZm5kZWYgX19LRVJORUxfXw0KPj4gICAjaW5jbHVkZSA8c3RkZGVmLmg+
DQo+PiAgICNlbmRpZg0KPiANCj4gVGhpcyBjaGFuZ2Ugc2VlbXMgdW5yZWxhdGVkIHRvIHRoZSBS
QUlEIHN0cmlwZSB0cmVlLiBTaG91bGQgdGhpcyBiZSBhIHBhdGNoIG9uDQo+IGl0cyBvd24gPw0K
DQpOb3BlIGl0IGlzbid0LiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSB1c2VyIG9mIF9fREVDTEFS
RV9GTEVYX0FSUkFZKCkgDQphbmQgd2l0aG91dCB0aGUgbW92ZWQgaWZkZWYgdXNlcnNwYWNlIGNh
bid0IGZpbmQgdGhlIGRlZmluaXRpb24gb2YgaXQuDQoNCg==

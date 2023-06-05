Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9907222E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 12:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjFEKFl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjFEKFj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 06:05:39 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404DAB0
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685959538; x=1717495538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=T8sKOs+BsjMVlKYhr7JJEgwxENG9oN8Y4sly4U9tJ43O23dKukUTQJd2
   WwrpfVkw77l4lK5cUQy1E6NYZZGWEKlAhPcn9u80isdkC/eC100Dg+q6p
   QCje+AFgrMfYWPUGDtS3EL7xQJjKuawMrMAXxNOR7edyEUBz9lkEkT3YI
   JdeuXOR45G2tBkZZW3si06HBbv8QnSbRLm2t+Sf3OVHkd/93s9/iqK+2D
   xw/RogBVDJAjxfAXasl4+ugT1Q9fIb6asccsphsaLZnDqmvT2oRQchk63
   7dGLAiSpQieco5AxZEX35eFDC1IECvCfjMcVIjqyeF4+QDxE6d8X3vGjQ
   A==;
X-IronPort-AV: E=Sophos;i="6.00,217,1681142400"; 
   d="scan'208";a="232524776"
Received: from mail-bn8nam04lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2023 18:05:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5syqntUY/udsg/XXGygYS932w+5SbmblXVKqke1oayoGXwNAxfJFEqGYzaZY7tluamw+/+Z+g2o+ShdxW69dWAW2iDpC5d0yPfGXjlnAnBr4dlqF5JxKnx4YF7lAWNjcNNUE96VfDaH9esqT0mgJtm9xpLfjIuSpqdybCCv2iJEBeHuyH6JgwZtJzSP7JleTitIonxwUdZD6DLnoiugOpkkzGv0sfgY5SvCuRD1kMmoPN6IA4XQRThudQCtzF4QX1BDXdJF7ddijUPlaPe7/Bhe5Yp4EU6Kt4Ywt70fxlOsY0vg+FPY1qx32qIL69mqVlclQ4EMJH8LAzKgnm7F0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=B4MTQ+eB92phK3WU2BZPIN/oll9K60sopxCdz+C1T2yzG5SgNhDfwIafFwSvtt9zc8xqAVqRZnqfaszFYVkA2fsaAMFUc1i6PLzqNLaMh2I0dku2Dg7KI+4H3ipOq9n37IIkioptJanS4VaWNBDC4tUoDg0yzc46PVjrlods6A9DEcJ6H/l7lM6uRpM74Qx7ImyTQxSc2FrSSuPQDw62x890/yyEtv1ItjQVIYhT9n9RIDb25miWbJV5r/M/cP/bWqq8jIwgY4HmRcbKE9VUVq2qM1DLeR4IQ9ZwNHb+Y+0qxwRjZzU4xGSSGfRMoSt/8OBF/mwqTtx0CIYe1/07SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=vgxIc4pPTl3+ya7eecFOemdcVvEP+MrcRGDYlpcLwk6cUH4r1SD45giYMhmOKmPmEIUV0F80OWQMWwI15FTnRzwHBOmDOjxdJ4qlX70aFJzGWZNTLYHj5ckmPDN+/v18Sk3FQ34gUdXP+dnRut++v4PLUnWs7w/cOuxKva/rezk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8894.namprd04.prod.outlook.com (2603:10b6:a03:53b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:05:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:05:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: fix nodatasum I/O for zone devices
Thread-Topic: fix nodatasum I/O for zone devices
Thread-Index: AQHZl4oaqJ8X8OZ0i0qgFiR5iK21Ka97+3OA
Date:   Mon, 5 Jun 2023 10:05:33 +0000
Message-ID: <54500a19-058f-5d7e-5e78-cadbc627b446@wdc.com>
References: <20230605084519.580346-1-hch@lst.de>
In-Reply-To: <20230605084519.580346-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8894:EE_
x-ms-office365-filtering-correlation-id: 832c7ddb-c9eb-4ed4-c149-08db65ac66ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0GyFznIRUTDRFp9YBFOSs+ZIxzE9wWSVxStXo2nOYYMyPONKCuXr3DXhlt3x+eQABGOfIIxQwG7oNnuu8NteBMAaunH0Gm3RVVAK7D9RMBqOLs+bFt/VP/7gUHsEGuXFQO/jKCgaFLmsJ/ftzFgw2bcahpR2Ct40lW9Ewv5T7TFRrKKGmFhH9wuSldXYqod8T+IfkeQvYOuPHl2aUJcOvC2Lul1B42qhvgudLhr0EWpRgvebkdpt5tNyNqAiP6Wv4np5GrxYaS2dkygIhIDAVa3EDgCQ3ngJ8meoMKZpCbilhpSsZkoKNR1J0KOLMrtp8TIo5H0sGXsYbfnZpPr+6xEBUfdssoE8DQjO7jf7JyZzGT7NkJJf1BPKolSQJoyKdgFm8zNkD7S/tV/5/XQgcpXC2nbHm7nri2+NnXWovYkB+A8SjfVXN+WW0T1ql5nxre4/pauqxPsnWUatGyKRAhzCnrgYX6/V0ZE6HHzLXZG7eB832ZwoimST8Cr1M1bj5nvkcjUvUpidOIef130M/0tBtLochiojFuf8Fi77bssdGCjrivpsq+crzncbCXZEFa3sDMZyC+ZIpl7ycYQkcUZzBMZO/Eg0NVukkJ7DQOtwgcP5f5QYlfxOJrovddmIA7ttD2mgwrNhIRE0wOSjkNhM0PMVjIaSyQVktsVdbjziYgaTwq6cAx1zSnm1HBa7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(110136005)(71200400001)(478600001)(8936002)(8676002)(5660300002)(36756003)(19618925003)(38070700005)(2906002)(558084003)(31696002)(86362001)(4326008)(122000001)(91956017)(64756008)(66446008)(66476007)(66556008)(316002)(66946007)(76116006)(82960400001)(38100700002)(41300700001)(2616005)(4270600006)(6512007)(6506007)(186003)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S29uNmQ5N2VpWG5GRnJvczRuR2RvRU9GV2hZRVV1R04yd0paS2EzV25ablBW?=
 =?utf-8?B?VEt1V1FCd3BnRTZ2ZWQxWWkrVlFDalpMaGRwWTRNeENwMGFrdnNkaVdGcVlr?=
 =?utf-8?B?ZThkYi93T1BBS2NIcDcyVHhJUkR3d3FRYTRpMWpiZGRUSWFzK2swMlZlbXRP?=
 =?utf-8?B?VDVIMktSbHVvSEJrV1hmVGY5Snk0TE9ZQ2c0TnBTUlVNbElxTWhQQVRwT25N?=
 =?utf-8?B?dVFEejNkNitMbmthVWFya1VMRkloeUpIbEJIM2RoOFdISHkyUHRKYUJMb3pD?=
 =?utf-8?B?V0VjTmpNNWhkYjRYTG8vUGRLek05TVN2YVdVN0FyMVE2Q0JYb3MycDdSdGMx?=
 =?utf-8?B?SnBiUmJ4U3AydURLN2pHUG04cTZodWVJRlhFYzF3dnBrZDVNK2EwOUFnUGwv?=
 =?utf-8?B?UXdQaUVGM1d6am1HV3Q1SDAvMEJWcktmUXlFd2Q1SElVNzRFK0xtMEJoYVBp?=
 =?utf-8?B?WkNyS1pvL3ErOFBVaHpsME9QTmN2YXhKM0VaRi9zUUlqWmxleXc4TThLcElq?=
 =?utf-8?B?OHRySWVmbC9yYlYydGpqRVAyRlpEdVFUamNQOEErakJlVlhlK1NQWkpVRlRm?=
 =?utf-8?B?SWFhM2duVVVmb0doQW82MmEwbHdSME91dG81UHFhUTlSbVgwaXd4TW0yRzJH?=
 =?utf-8?B?ZjQ4OThibTBIZEJCcDlWU3Mxa2dKbTEyeFpvbnBQQmFZNEd1alFFSitxWGhE?=
 =?utf-8?B?M2M3dkxRUnllTW4xbzViTm41dUVkTE1JRS8vSHJ6bUNBSzUzeVFzSkMyVDNR?=
 =?utf-8?B?SStxNDdvaCt3Y1dOMDYxMnlyNitOSUJNRWltekNFa0U2V01UTDJmaVYxcU9x?=
 =?utf-8?B?YkdFeUdRQ3A1YmhLOStFemhaZlFOTWdSTEpsRzBLRDdkRjhzYitpWTRpWWdn?=
 =?utf-8?B?S3RiZU5LUTdHZ2NtYlJRU252Z1d0RUV1c0w1ZjNxNmdvd1Jid2NKV3NaS2dC?=
 =?utf-8?B?VTBIMTV6cVlNVTd3N3RYKzNMZGI5Um13bVJReVd6ckxRN0ZiTGZhUC83VWMz?=
 =?utf-8?B?WFhqeks4UFl2N095L1l3RjBBb1FPUEJkTGNLamMydDh4UXQrczQ3ZHVkTEF4?=
 =?utf-8?B?WGR2cVN4NXVxbUd1TDBEMWdEQkl5NDZHRnZpbUZkNGlXbFhYTitYeFMyU21U?=
 =?utf-8?B?YldNTklOanA5d095b0R5UXFpaHBaZnFQUk1jNDh1U3lJMWhGVkdsYVN0NGxi?=
 =?utf-8?B?M3hGdG9UOTJlSm1mVlFIbVpzNCt3VW5sSkVwVVEvQldLT1V2OWJtbkVQUVZB?=
 =?utf-8?B?YkNwa0tra3RndzZVT0ZQclFCc1R3KzREMzJXV1ZEcGZmeHlQOGhQQ3Y0V3FZ?=
 =?utf-8?B?MnVZUkcyclFmbFlpUldBYmhGaXVMK3hLMUR4VGI2TlliaFpWaFhLNXMxNk1n?=
 =?utf-8?B?anc0aDRKK0NyUGdjcXFFazlsN3IyQ2QrUi9CWG4ydU56czZxYjNwZUJXRGRZ?=
 =?utf-8?B?c0tMT0ZlQTJ6QmREbnVvb0ZCV21QeTkwVUFqYy8yVWRScUdVejMxa2hCb3Vq?=
 =?utf-8?B?ZDdaOXNkazBsYXF1aGtVVE0xbmRUNE02Z3BwdG95cUlBMVd4ZXQzQ09sSGRw?=
 =?utf-8?B?QnRpMXVpOC9vKzFkZ3c1MjI5d2xNQ08vbnczTTVCaHcxUXh2NWMrNWNNVmkz?=
 =?utf-8?B?bUVHZmFnajNVclF4N1FQalVuU1QxYnBUcHRkSlB3QmNncllvMU5zWitvYVZK?=
 =?utf-8?B?dDhBRmJkdjdGM0lFN0NwTmFZY3F2V24rUUsxUzYyTmZRT0s3NzVabVBqVmdH?=
 =?utf-8?B?aUZMQTI5aGRiWGdvWkRWaFVPY2VTYUhjNG5JUllRUyt0ck1lMGY0WXZ2WXpN?=
 =?utf-8?B?am9YbWNVSTdjT0x1SEtZVVlWQzdkTTNFSWo1emhsdm5RY1hDazRCbS9VZ3hR?=
 =?utf-8?B?RDJuTXFtMzByMlgzQklpZzZSZkpJazdJZjFzOUlnMGtnVGM1Mk1jYUdmR0Jx?=
 =?utf-8?B?N1RCWmZBcHdrVzUzRTZ4d21WWkxiRW44SkJsbEZXc0VyMGNOTWordFdyVFV5?=
 =?utf-8?B?QW80dGhsQW12S1lITUp0eDArWWZ2UFpFNTZzUHU4T0dIY3dkclp4S2M2UWli?=
 =?utf-8?B?Si9maml4V2Y3UmZzYy9vRUE0ZkhwM0doTjNpbjJxelZnMGhQc2phNWg1M2pM?=
 =?utf-8?B?MU1SL0lTS0hvV1YwZEV6c3BhV2FxUnU1SFpHYU95cHBHWjZXeXUya3JueVpV?=
 =?utf-8?B?aExwUDFSYzBlOHZudmdnUDdySjI3U08vdnplNCtHQis2Mm8yQU5ZdWpuWDFp?=
 =?utf-8?B?cGJ1ZHVTcTNaZFVoNnVYVWxCbG93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <839D7686FB798246ABDFC3EC1E8721ED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZlpwBiAvmW0SehMzQF3LCZMXzRbzh+KiB0Ve67LXm4pVIjttidkfFFqxhbYQhn6+D3LqlDgCQ6dyKeZQfwxojkOtTfFOdK9jdV6BPJYF2FHpuMB15epll/U5AaV6oUr8exrs7mpEssEvZaWXm/2EM0WgschZwQ+3+IU/5QMlwUkrFpCNruVVZeYX7aOt56vU7AV+KnIHf6Y8pf4bwU9Fdjp35E6VLz8E5mbnN+i5IKB/HBGjEeBXSD4k9tZGKuxgNG5DWz2rzBSSpveDyK7BEUGrIcq7LueUbX3S6RF8QapjJi+fp0EzFTqPZLH+/w7Zq6Bnqs4va7rlpzF/5tsBuR7XRCgoDbddsao+tWkeRL3H26tlD2obWspO0fxEno2080HVsBFVnw3qL/oubQTkAoE016dIkF0STPsw9RLNHA7o4TY6Xy/6MJRdZsTOkVpzBYV7sW7hHdzi2ElC4jk9XCO3OSSF65+iYYiNt6+3QGMCtXUR9lWp9c3AaKSLjtPALDIqEwNVpdOYNAhd//pIYt/l0+1F1lICBOsLTUKABSv9yL3vBO1llsNQvTQhOj2x7O7Pn5SwWBaLSMCExCyYsZH7AV/Gp7yJbnwJDu19RBJ4krAr6gp89tbm68/IhxxoSp2VzbkRn5P7gpVW4E+zeEjC9Q1TLALvewlMAwioJf8SJ4K1oqNXMrmxLHURvJyxSwPYqsl1SIoUc4wDHkzswkyClxacliowF402pFRuwfBwu0Un5AucLCfH7cBpJR/BpKwuKRLv+6JlkOaH/QLgvzsyiVpeRINCjCY7VzVTVBR5qE12YdGlPP39EiuaVp8rnyoKT80BGlriYpKCMRv/X22pxHrCF1AAc7aHsaRjJu2wW2KUfbOYbfoGLMsOGI2R
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832c7ddb-c9eb-4ed4-c149-08db65ac66ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 10:05:33.9540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vYSX3PSFSvQUnTjAD1IicIwN3JNDSoyJNWK0RquUn53HVRE408t0kNTV/ZqLG9AcaRynYKvoqZxHSU86MKXD+RjRDC1pzu3SkaExBBDg8TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8894
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

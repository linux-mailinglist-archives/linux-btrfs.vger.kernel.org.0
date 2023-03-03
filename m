Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7E6A9548
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 11:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjCCKca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 05:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCCKc2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 05:32:28 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F561F93B
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 02:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677839546; x=1709375546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=upFBRoqHOtJvooG1dzXfHR26SHVYEMY7XQqFjoNAUlQ=;
  b=ZTqKvPZBRS4ePzyz6i7nwPpfWLhG9P3VqMkh1MUlN9D/cwriulWbXHN2
   X89/ZStKbYSiq3twHjWVFBepDrSOm2w5aQhW5rOKTg5QnNlRzqSCrsfhS
   8PKXlayxHZSx208a6jIrJKJ6+mIAbPUPHXsQe6Y69ivckb4JUectATn0c
   BS0LnK3m5os4TfathPm1802/Gu3Vyrr9xjVQa2uMx6OFWiNnP1muInOu/
   /mOdWQLGZS6A/X2h2yqzpuq7juYhXkOukQPKl1wWOKSTAqP4M0llFnsUA
   AqYcI/uIK6Sz2Sh42bqmK9mI5sMmpJEL97l8XvCt1rLmPxWa3G6Oafgap
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673884800"; 
   d="scan'208";a="224720748"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2023 18:32:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRh8Ug9NVwvIhGwwRXvd4Rpy4LJNmsUeRmrdiF2BQIcz2SGCwEG2lJJSleQFnpaoRuZbYlXbx7Cgrtksbe4SwcKTTYmRdPQ/39rICkXdx0lg0L5v+6zqGW6t9/cVkYCRKVkBajvcN9yvw/SZkGeRLwjrfAbArC3Cqx3kgsxQJmjwJMJpjwtMzrU/ZWo3J8CHnwslpYDdW1hkxMbqTI3YxaM3/+MyNADsmtPM/L7eVFxra288rdkycChazR710exnNXXpwpMlMAXrgZgSYnsCD6SefDXDCZGNgjKYxo5skpEfH51Wgq2V72Jx6sDMva6NhN7ZEMDgQiD2Lzs6lwQQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upFBRoqHOtJvooG1dzXfHR26SHVYEMY7XQqFjoNAUlQ=;
 b=h+1gfeAlxuB+7X/WavE4jR9IDZBsexomowki7FyhoCPETq7EllYudS7V5xwCCSSK1GLv98YnRCNAAROBrIG2m/yVz+J2R0Ht9I2U12vGtoiJgiIeIRok2r3/aVtyAs05wFARQ/c7ZAVVv92lwnNCPjIfdl8Cx3okdWkWM4mL8nvZGM0D+Sb6HYhuDsGK2KT6HRw4a1eWGwlpoffHocDOH1ZrRXpPScc+n8b9mlGJWx2Xvff3gY0TVULhFV2zE38qk1f0BKgACad0bbHSqQu1oC6J+TnJzU4YaXS0FFm/xcz+nBRSZwQPtr43dPxLH1JSA6NRKxdDIaEnkhgd4H40kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upFBRoqHOtJvooG1dzXfHR26SHVYEMY7XQqFjoNAUlQ=;
 b=TF/JAqhA//W6adUsGVj4Io9L64bhZhDPBhdgUGQpYC8mdgz86SisLgvgimFdGZ+QlqC8PkO2m14XUVV5z+cZDZG6mMLkKMuyqlbggx0iSx+n0QG6IowJ8zmYBzulQ25k+9d9ly2VCWcnqi33R4DnfUMpjGP+45fbcG/bQEx5qQs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5180.namprd04.prod.outlook.com (2603:10b6:5:108::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 10:32:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 10:32:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 00/13] btrfs: introduce RAID stripe tree
Thread-Topic: [PATCH v7 00/13] btrfs: introduce RAID stripe tree
Thread-Index: AQHZTOvBogZFAJ6dz0S12mIgPqmHVK7oy4EAgAARhwA=
Date:   Fri, 3 Mar 2023 10:32:23 +0000
Message-ID: <526d8406-31c9-b4c7-06d7-f4df7cd56cec@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <f1ad5ce5-4976-0243-3434-522d71687139@oracle.com>
In-Reply-To: <f1ad5ce5-4976-0243-3434-522d71687139@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5180:EE_
x-ms-office365-filtering-correlation-id: f393d5cd-f6a7-4620-4d88-08db1bd2938a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfqRCnGeZEVD+I3ZFGaTL29IzW+Gu5rl8la312t7XDCn9CKAhRq7aBzE6Vk5V7tH3iRpSmiTea1vlQ3NVZ0ySPp1uyYgZYk2B+tPYItiqtyw9/6x5wJWn18yFdcJWoXLjYh6KiSjOeuldfMGI50IizqPBMN89GqAOw29T/suKc6PLU1dBTj8nW2pVE0PS2QB4qUBxJp75xazt4kxoOFO1yapD6qKXvy9NkG2ovK/HG1HVpiUes/qgdUOScGSHCSmLiesxJwJAWMhBpNxiGNUfm4f5qXtMBEuV/vDdSBBPunXQ/8CODPzVAyZIya/AOMaEsexPlKjJ3R8uMQse/Femvl57N/zxzw7briMszzxG/H07oSmOlIz/rDZbWuAXtdJwMAxVXdsik/RsD+LN4nvJ7aQ4JJd1xqTC+ydbdCyBQ2O0zSEN1zjAX9NFhCZekL0cB0S91s2Sp8BuhZAaMt6vei5aPGmR7yR32ghRXZR+ndVaUmdWTd0u4+EPjvKZGVtouzNB3H/hev0eCDe1/GsMzTNq1J9zdPlyXIAJAIZ/ak8vL0caUoxX4YWmxvWkkrFrNPRyF/6B5JmxyCpHmfh3Z9Q/gLy1/vREZixFXA7hR5+GUfY7Oc7q+Mo17uC1xGZHTJ4nKfTvRDNSrKpSyt/Q8iVW5iQwX1Q+3c4J8EmkVuSm6GaQdv0HXbBAwHsL6gm4pp2oYbP3pPlb0xlhBF1e26fuvUysgxtVHnCg7JnT9VzY6b2paQpqHJm7lRKCXUx+OqTR0F38vVkFUX+zmcpgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199018)(558084003)(86362001)(31696002)(6512007)(76116006)(36756003)(8676002)(66556008)(4326008)(53546011)(64756008)(66946007)(186003)(66476007)(8936002)(41300700001)(2616005)(66446008)(54906003)(316002)(110136005)(71200400001)(38070700005)(478600001)(122000001)(5660300002)(6506007)(26005)(38100700002)(82960400001)(91956017)(2906002)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEI1N3NGTjFvb3NNcHUxYnVxTVp3TXIzQy9POG9OKzlwYVF4cDZJMFFuUURK?=
 =?utf-8?B?ZUIwckNVM0NwcGZPdGI0dWJOTmM1K2lEaHpZT3AwajdYN1lGenVMbmVKT054?=
 =?utf-8?B?aUxkT015REZPQ05RSlhkaFNhWmVHTkJqT24xOERzUHdSU3dFYUVDNlhRakdW?=
 =?utf-8?B?Nzl5RGlGWGVrd3JmbUNxYW5nQk9CcUg0SGhjeWd2SENOM2JNN1d0VXc3Zmcv?=
 =?utf-8?B?UVZsZ2kySktlQURFL0dGeVpQbnBObWcvTmJVOWVnOCsyTHJMRXZDODlucWtk?=
 =?utf-8?B?ZFZGUmJZRGpRZmZOeUs0a2ZkUndJZ3RYNlhCdkhodkg5ci9LUmJXd0grRHl5?=
 =?utf-8?B?d1ZTaGkrTkI0bVJtK21Pby9HRDRxMTZMakF6eVcvMUd6NVE5SEpQOGJUN0N4?=
 =?utf-8?B?bVNad0x0L0Q2RGpPVlphNU9uZmhDQnVocTI2OCtBNnRYWWFrVDBGOEZqWFgv?=
 =?utf-8?B?YWQwNlZqTlFsMjJraGxvYnRXRDNQdUxmeUFVV0xBZm1MaEpVaHcrUGlaaFFY?=
 =?utf-8?B?aWdETnNBWVozajVwenZIOEl3eERVQ0hCT3ZNRXZKRElncnpuM2UvWWhybHdT?=
 =?utf-8?B?bjVCdk1qWXJRUXJIWW5QT2V0TkZEVElsUk9qMUdTaC9oN1c5Q2tEdkx5NkFa?=
 =?utf-8?B?RTVUb3ZvZERtYUE5aXlMWDVJSWZWbDEzbTVIbDI2Wm1RRlJRTm9FZDRKOHZ2?=
 =?utf-8?B?SkRCclVGNkhmVkcxNHdPSzFZSEZER2Y5aWpyb1orOE9vZTVsT29YV1hHR3M0?=
 =?utf-8?B?VFBEeDBrS2xvZWFsU2kzdkZSdWdpQ1d4M0kweXhNUzJzeVh2WEJrN2VmOVN1?=
 =?utf-8?B?SlFHbXRBdXY5OFdocEJpcHlrU1dITGdYZHBvaUdpTU03bDZQQUhsNUhkVFBB?=
 =?utf-8?B?cHY1aG1NaFp5UHlpaC95NElhRjVJaHpmcDh4c1V1WjlINUp4OWs2cWZUeEhG?=
 =?utf-8?B?SmN2SnVoZUswWDJpR093RGNkZytMMFNVcVVaenhFUmRUTE1LWjZDd2ZLVklN?=
 =?utf-8?B?OTdRV1RPN1BPQ3plb0pHR0ROdldDbmRDTFBBY29LNS9SVUtHVzdBY3IzaGt3?=
 =?utf-8?B?SkE2VVRyREw3cnJsdi8yY0RqM3MvMzdsWWhjZFB1NElqSTdoWTZnZlh0NUQ2?=
 =?utf-8?B?OExJckZ0cUV5L0FjY0FHdGRuSHljYXN2S0FnVk9EcDFjblNlK2VnajZNN254?=
 =?utf-8?B?YmhSU1FZTUVGK2lQNnlWQVdFUHBVRStla040YkdsbjRQQi9NQ0UrQ210b1hC?=
 =?utf-8?B?RXZscGRXanoxeDRPM0FZRDhJREd4ZXdDRGVyMHM5dWtYeDl5NGxZSnJDUnhG?=
 =?utf-8?B?RkNKYnhXOUhIa3dmcWFoMklwUGQ1S0Fmbm01NS9MQjREYURwODdhc3RoamFz?=
 =?utf-8?B?eXdLWkZacHJCVGhwbVdGUmErWVZvQVpuMCtjRVh6K2ZsTHZhbC9YN0pqYnRa?=
 =?utf-8?B?ZkdoY0JBa05rZUN1cEFMQ3g5RGlKSFArYlpFbmdFamRUYnlxZUFFMzNObUV3?=
 =?utf-8?B?dUU1SklXQ0RpRGtkaXdyNFlGZGh3KzQ1aE1aam43UzIxQ3hHQnBLYm15Zkhs?=
 =?utf-8?B?dlFTNFVMRjBVYm93UHZRQkk0MFFBWXZNK1JtT0w5WEt3MFZOdTQ3MnZzYTlD?=
 =?utf-8?B?UnpWV2xuZWJXVit1VnNpb1ZWYTZxeXhMcHRWbGNMMll0TUFqalpGaWZIYjEr?=
 =?utf-8?B?VWhVTnpMQnFvclhmcG51MWhqZnFYYXJTb2FCOFZuYUxNLzh5SzJZNlh1UFlV?=
 =?utf-8?B?ODlSblZwQzdxQVFsTnZWUDRZVWk4QlZxYUJuNU9jVVpSS00xaDUyZTBRUUl0?=
 =?utf-8?B?bUt3S3NISzNubmRoa1JrMzdCbDVaRHFIdmdjU3FWMFJCYXhVdzN2V1Q1NXFE?=
 =?utf-8?B?SVozLzVTOVhLTHJvd3M2ZVNQT1BxWDdkUmJRTFE2aUpRVDkrN3BVVjhnYzhS?=
 =?utf-8?B?alpKb1RVNVJsQlVyVFRHOFdNeDNqSVdSc1Bjd0lhNU4rUitYOFJvbWMyWlJ4?=
 =?utf-8?B?R1VkUTJpenZKUUhXSmdEQmRJUGFBczR3czhOcVN2N0hCZEV0azJobmt3bURu?=
 =?utf-8?B?M2dzNWRyYmMvY3ZZRmZjTkFEOEo4clhEaU9NUWhBUjVyUGQ4ZUxzanAxczd1?=
 =?utf-8?B?eDZyY0dTM3lZdXdVYTg1dlNJaWxKTmxCZVR0UnVNbHFVMEc2bUhYM1dQcGhC?=
 =?utf-8?Q?50ZOpckdXtQSeDnUUj9Si7M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A53FA5724EFBC4469715B3B01AAE49D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dfzMO7asyo9cdrCN5k4vMA/LioPjQsVO9FDmuuA8oIwssctOcjoEn0DQGO9g2OvE9NwS4Dvozpmb8zzI24tCfIt2Bo1C57U8XVDyEXMPJ6jk4F1Ou3TFZgfCRnIkXZf4AtLFdwBGePXDKeLEAc8kQKzA40H086MmvflN+jJxmAUzEHI2iRMNU3ti2hmcX48JR7TVS7JvX3ptX6UjSNKnuAghn0XcS2a5FwWLd0SsU5KpsaC/+dvqMXYRlIr41fN9pNWyMBlJwi3V4pnF5t7x03l9HVVEl//cf5iKK3gP3vNQ3cAxFJ4JTjYJL8T772MKkinRbYmfAsH/pKd34w417gHAFLGOzC6InU3otpyFNY9gguy+wgWZ15+refMGMHB9DySUpBJE/lcNLpfe+BkFuBzKshGXXuS2jmT+nrYh/I0tO4OJHA4Aeye6vsVAM8O9+DGip9BP+PP0GHKTBt5XJZLfCUOS9+mgdIKlIaJ030LM5+8M87lGl5tqekmj3cGXozTY51Dnb4pDVhSoLO0TP/kaTn/YNOw97Ma43fRcBxSFggUKKFi5XiqhFQGUmJ2bRunfp+3EaDlL521qWNsKlG8znqAeYaHNHNq22U1ApHgc6l6kz6kEfCv5hxSf+MJ7+gT1JDPgQrq5lTOykJbbmIUlXqr+vOP1yafAtWW4AisTAEZOI+q72HV9kN2sbiU77TDOSYuJC3a0ZQNeBdRbBdylCSakac3IVfsqJwUA+SgvbHO02pop6F/B2+DqZIJgRdNcguMXG1C+Ms5HQtlXMdv+aBn/FZubW4xC1cSGrHMjCapCGd7Bd9Y2fZmBVQzz6h1/If7WN+DCUypEsibbU4daZqoWFuvW+Yl3ot3iusFwBnX4uiQU1ZndRqzGNAUJJ1h9kDFM+OAnKhix+vMJgg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f393d5cd-f6a7-4620-4d88-08db1bd2938a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 10:32:23.5297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtzahNIhb/RK4q6hE3HMydICrxKkLlQLFY2Twd4G7kjV2Itb9QKs0CnfdiMiQOnDI/d6DKf5xGis1SOtUyGkgZHHrp1eb9nFVJVbFIKYAKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDMuMDMuMjMgMTA6MzAsIEFuYW5kIEphaW4gd3JvdGU6DQo+IA0KPiBJcyB0aGVyZSBhIHBs
YW4gdG8gcmViYXNlIHRoaXMgc2VyaWVzIHRvIHRoZSBsYXRlc3QgbWlzYy1uZXh0IGJyYW5jaD8N
Cj4gVW5mb3J0dW5hdGVseSwgYXBwbHlpbmcgdGhpcyBwYXRjaCBmYWlscyBhdCBtdWx0aXBsZSBw
YXRjaGVzLg0KPiANCg0KV2lsbCBkby4gSSBtZXNzZWQgdXAgbXkgbGF0ZXN0IHJlYmFzZSBhbnl3
YXlzIHNvIHRoYW5rcyBmb3Igbm90aWNpbmcgaXQuDQoNCg==

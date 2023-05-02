Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F0B6F43EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 14:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjEBMeY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 08:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjEBMeX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 08:34:23 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7ED2735
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683030861; x=1714566861;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=BGQjVm0aQRgKWXiRqNoXf96++2g+whTAFoLtUMDgbF4=;
  b=FkzEtoGf9guU1ZXSYP8sotxG2VUwUpa/fgZW23SixtvI6Sg7QeBfaDwm
   VkwIsqvWmhWroCBY5ZZzfe8vxoDce/UQjSGSkTQges+RI3nW2Zml3zmGr
   OpBQoXPkWhT9rwdlHGFQyXz6bsPhr7n8ojty8LuMG3usqooWAbNGCnXg/
   JcxtlBIp2IIf43ncftbvL5z+GbHvOhcA4cJoB7ANma20EFEGxXISPR91N
   pSJ2dwMmERM8MFtn8Pc3xnyedmDKeIFP23DcFXdSj1w9cfaEsBVmwQ7xU
   y1o6bFPHioh3X0ktO4L42/MGtDNwGB+I0pe+0maFOC+RnblqsrWrdIyeb
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="341755537"
Received: from mail-mw2nam04lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 20:34:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaJXesWACVGIYGK/pazQ+s3ICnTpcFzoLhARmstPrZgmux8ijGUl08PNin5kvqfLdFHHfJ6J+UHA/BAWcsrk3N85SrtWKtm2oCfhUFYglH/WTLTrneso8qJ2v4K3C9t6azgokCH9uFwsYIu98K1v5wK2sIs8OPrq8IOuoEliswmdQgVShXbg0K57PPYRhMIheG/VDdoggu7gDYXBDeSNSxd9ztbypMw1Uzghklj1yedvQ2mVKK9pEWusy63o5o99FaLvX2YAoI/34Kc7NijkQprNUQHnFAXQ3XegQ6//0Vu7tEPxhmeIeB0sQoi0QFw4fbqaooX+jBDu2YSECldcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGQjVm0aQRgKWXiRqNoXf96++2g+whTAFoLtUMDgbF4=;
 b=nleDc2YmFXIYYTLodnvUh8mh0n7dgt9nPLfz/3+FkgpRqzh+ii2u0sDCSrgMILYxDkznTxjgQzIMvQnY8grF0YIKHlAvCdE+i8bkAIzYP7TGs3bxN0kPDJYbB6OuAfsQmEnHaRU3DKfyP4ci48WaPA9Nn1E7VHLViEYyWfpF4LyPVNlf8Spqpz1k2A16yWrMiNgRURflP09UQ9dLtvo6U3eDYeJCzapyP/c5dhCUtOptTjczObPukBen7oUAStWMC+lj8Of6ZDpQSXG/uoPICW3MuOgt9J9aB8cLFQpM105LvegO/4L0tnLM9uwiopFwhXxC+rizpDyDHcOgJ4SfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGQjVm0aQRgKWXiRqNoXf96++2g+whTAFoLtUMDgbF4=;
 b=vpas5D98uh59bzOreXEfuQj4vKn9Q5a5WicCvVBe0VysJhF1/xsU3Sq/fv3btCHiAjByTyI9SKuqJCKEykghld8lVFxMwLl11Dwzx4GCLt0tdtLCVh/QF5WlJNyhjhBusgnfd6ZNM3efq30fGjmH3Wr7giCjHZI4CT5lXGG5Uv4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6298.namprd04.prod.outlook.com (2603:10b6:5:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Tue, 2 May
 2023 12:34:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 12:34:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 11/12] btrfs: add a btrfs_csum_type_size helper
Thread-Topic: [PATCH 11/12] btrfs: add a btrfs_csum_type_size helper
Thread-Index: AQHZetZP5k0Hy5jBCkGN8km4eMWTNa9G7yWA
Date:   Tue, 2 May 2023 12:34:18 +0000
Message-ID: <e097e8c4-472f-8a23-57dd-1aef9fd5cfab@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <2627fbc83e4c07215bf831d6625b193d6491a750.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <2627fbc83e4c07215bf831d6625b193d6491a750.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6298:EE_
x-ms-office365-filtering-correlation-id: 5bcce0b9-7938-4bed-51dd-08db4b098c59
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bu+6omXWNBfeANonJ2TXYVii1en0tK+wAUpySxOpTOrsNVwU4RqqQQ0bwZ4SgiAOrcDar1clqYJ0PTWrihIA5j8BBPVlk0Fj0Wk8UT7GkcYnwrkH/avxmspvQfmhlXgZNA8qQalQsH8hSloVHY3nY7RoG2iKVA6rXLEPQYWJqG8CiAtM2emVouUHSDbAOoHp1kM16hnUukt3DY+PM3z5Xt4GH7LLUlSFlbRGGS4kBatIqBP+A6OmgYKp96nSHB8RGTxS3EZuJIhGHc5zCLWhEMFbvotxAos75o6Ah2zPij7hQjGUEJGFbgLB5FvsTKBvHqNLwnk8vHvG8zR7eyNiaS0/4JW6qCPg6vcTsyiWYYFMO8IH2vvZsKzs6uVkke1maX6hm39o8R1avm9k/vURTT0ldSvDGCFqdbEMj3tOp+9LB+ZX8VWN7+uEz5FXZc4sMLgP+qVAJDOFKv6IOwBDNPD5YAI7OxVq70CmNENwyQz0VQnilZdPTsdMqSivIpjKHmlQCkbKSRC+qK11fmBrn9g4qd0tKdvWTwNdJLmw5qy9gVqYaR5QL7fycf7dn8StdPEYkaahfYbFg13+qM2zMo2s/hYviUUVz3Uw2qE004IBQc+ravzpwkxuKDVZpJ/mTuKten9oles6EmUSggbj1gSgle7mTp67+BdVwK+xky8kID68B8FvrgHFNei5yv7u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(478600001)(186003)(36756003)(6512007)(2616005)(53546011)(31686004)(71200400001)(6486002)(316002)(110136005)(6506007)(83380400001)(91956017)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(8936002)(41300700001)(2906002)(5660300002)(8676002)(122000001)(82960400001)(38100700002)(86362001)(31696002)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjFPcTNBWDZQcHExYnBWYzJVREVuWUNJQXJtaVUrNmFSazZucnNmQzMrVXM2?=
 =?utf-8?B?ZyswSTA3bWhsbVF3M2lDVFZCd0hSei9KY1pNSGE5V29sM2RiZFlhRllOd08z?=
 =?utf-8?B?NVI3WE9sbDh2ZENJS2hMRDB4akFtNzhVNlpLZmxycmJ5Z1ZqMGZHYk9JRjdF?=
 =?utf-8?B?emtkMHpsc1pPSzZiSmIyc1ZtM1R3SDBGRDk3TjNWOTRkVzg3Y0RubnFvOHRm?=
 =?utf-8?B?eGROdE1OL1J5MDZoMjJkRGt6SE1ZdGY0aTFlZ2k4OG5LUmRKRjlRdkVXUzBy?=
 =?utf-8?B?aEJ2UVRRVk1mVzkzZ0htOUlnbUMzanAzUFczaXZtWUsyRDZRRjlsWjJra3Fk?=
 =?utf-8?B?Ryt4NFlSbE82dzZtYzBKcnljUHVGQ1VZVldPNFFKNEdPdUdISWE0bndlZUUy?=
 =?utf-8?B?Ym1sS1Y0Vk9RS1FqNVcwSHQ3dGJtN1pHZFFtaVZjN0dETlBJZ0pHMzg4aUJa?=
 =?utf-8?B?RlJzcFNxMkk3a1hETUxRS2FnTVZvUmZOSFlSYmM4bkFXWHA5WnNMT3dmVTJF?=
 =?utf-8?B?YnNsdWVTRXk2ekg3NGNMK2hSUUhhU0JwS0ljN1l6SDdhQVhIaVVXaTkrTjRX?=
 =?utf-8?B?Q3kyc0QwenlxeVRVV2JSVEpqQzRhbWJMbzdWRzZjT2xCeVJiYVVLbmQ0MXRK?=
 =?utf-8?B?bzJCcCttR2o2VEVYcmowd29aU2ZqcjJvRjl2T0dSZUYrMXpkckc1RGRPK0Jl?=
 =?utf-8?B?dEJ1KzYwU25JdmIxY1FVNHRxb1dEYksxVG9rdFBHWHFBNkR2c0x3T3JEaTRh?=
 =?utf-8?B?WTRWYTFiN0tKUTM1SUtjcUZGNlRqMUtsQjJwYU00MFV0aFZKQkFlRi8yaXZp?=
 =?utf-8?B?VVZjamg2aFJ6b1Zwa3poRGFGeFR6TWU2TGpKMTdydTlTUnZLMWVuVmQ1dkxV?=
 =?utf-8?B?WEJSeVZmY2hBbE5YYTVYd2w5T2tveXY0RjVEVUNOKzBqaU5CTDg0TkpwNVBn?=
 =?utf-8?B?Q3pjNHNpYkR5RTlGamJSeHhkTy94T1RiejltRkNtUkE1cmEvenFnOFZvYnN3?=
 =?utf-8?B?QkwvSWJBczFLWVkrNGlkZ2pxRXM4QU80OGxmamFaWDFHd0ZEOEtCWktSY2Jl?=
 =?utf-8?B?YWd1Sm1KN0dNQTUrVkRhZDV2NUNoU2R1VEowd2gvUTJuT0Ntb3oyUW9GRVZE?=
 =?utf-8?B?amIxdElyOHBKMkQ0akxXNkFkWVIwdUJieHRRYWdwTXMvamJvKzZqaExzM0M3?=
 =?utf-8?B?SnB0TmtDSnlWRFhSRU14ZlRiWmtWZjJReUlZcmMralBsWXFUclJUcXd4bW5x?=
 =?utf-8?B?cktXUXd0Wkp6RHg0YmkzanZSc2t5UjMrSWlZejNvbTB5VXlSWXVVSFpqaW1a?=
 =?utf-8?B?MFk1dkhnbXVXaWo0elNaL2szalVrVDM1emVNTkFzNERGMHVZMnJyUldZWUlp?=
 =?utf-8?B?NGZVQzVNSWo4amQ1RE5OWUV2WURMMDlWSWhsK3FvaEw2S3U3Vmt4bTQ1c05S?=
 =?utf-8?B?M1ppM2pnL3dJNm94RWJWLzlDUnNXVlZFdXZkQ0d6Nm1QQzQzNzVhRWRINVNm?=
 =?utf-8?B?WmhNcVRVai9XLzUrQllGdUJRemdGZFJiM3NNZzk1c2dCanpBWndPZVNrVmtF?=
 =?utf-8?B?d3hzK1JlQVZaOUlmaHY0L0M5dlN6WlVzeXY4MEpWUUx5OUZHSHNzMEFhWC95?=
 =?utf-8?B?SnpxMzByd1owaWhxVm1rb0pmMXZzTDJWdHo4ZHJKKzJ1S1p5T3FBNXRHNHRX?=
 =?utf-8?B?dTBNWER5OFNhblpYYUtBVjJwNlBRZmtOdkoxWDVxRWNycUNNU3l0ZE0yd1Vk?=
 =?utf-8?B?YlFtb0F3NkZBSzg2UFFLWVYyKzBza0VmWXZzOU1weGtRRTVOUHZEQTYxU3h3?=
 =?utf-8?B?YkRNVW4zZUplWWNzMndmend1M3VnY2p0VEVKdERZOUc0NnY5TEI3ekNXZkRl?=
 =?utf-8?B?N3psS2gxbTdxbXZJY3RsQWF6QlN2VE1Td0tqOHVBVExyVXZsWEdyeVBNZi9V?=
 =?utf-8?B?TUN6Y0toV29ReXVXanFHRkl2ZWdYeWlhN2djdlpsQU5QSmc1OWxUd2lHUWVp?=
 =?utf-8?B?NTJua2l5NitzemRQSHhtM04zK3E1Z05TVVpwOWNxRGtLUzFzeVFTd1ZHTTJj?=
 =?utf-8?B?SitqSEIzdkYzVlE1NkNhc2xiYVVkb05pQmlqN0poQ3ZHR2ZMNE9ucnh1a1JS?=
 =?utf-8?B?NysxcXRYVEc1YzBxemVFMlVVcGNKUnNETHNQb3lCazZpQnAxSXYxQkJzNGE1?=
 =?utf-8?B?ejRUbjhVbXRsMHdTaDBjUmJ2NWdCcVZuM294SFN5QU43a0pFVVRES0pzeVFh?=
 =?utf-8?Q?1/PqxIkTgW13BVxJ6Uq1Ens8CwH5YpocvQvjFgJGDs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3DCCEB465AE99458D03AF3FD9509D0D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dKr8FeJzIPs5QRJi6zYjIThyQWE35BYYhCqs3YvvxogEf2dSvOmMVbrV7CTuCOtR+Uu5bGx8n0qdy6GpNTkEAbwoN2zlIQG72tmLyp3vyuhifETr8E6ORSvbocsI/+StrARstZTNHUmsWdVq3bF9YbHSzh4VOy+YNzLAQBx+fGwd8AuHbAtCGcuJe/Ge+2dn76OZ4KvuFTLrNVtcR5mi3tyuS2vZ3QVMsr37KVUbHsFVExFlluuJe5PDgb7qAfe9DOp4uUjmClwKASMjop+M9t8T2Cu8N134Pi66h+moHOgF2YEhKOW2hS0UGvistGm+Nlq0mlQvqHZjFft93k2ohSFXprRkK+4FzgMOo2W8k87BlRCvgCyciZa3kZ/gTOHcA5ZgqJIFQ1w9fXAH4u6pGyuMW5qloLx6YZZnDCuJDx0XjYnEWPrAoWfkNqM8kQ/rE0wPek9om+o432jI1LsPKrqvBMrKkDefOoMaEGLzDkAgcIFkB+RcDnpA4izWDLYL7/Zab4HnwBxyKy3tyq8WByazJGRliR0VoEhaedMjceSaOMLdphVQy2PjyFgxNJrUEXPxJlBSwHmfU2OSTPZS0FMZXxnKKz2vzJkPa2M8rsEw06vFRu/A/c/VzO7AHkHzrOeEia4vvRvjpx9bICtk/2B4Jbs34aw1l2NKdN1n3P2SMsPseT9wYRv1OQ9f4ycwkZNPEqSKamaBf3gxbAZ9fPMXXHPR2ahwDRDd+VtIOCro9yQXZAqFYAnreHSfk+NkBkiYKn63e9VN7O7vAGytZJn/uw5pRuBmQ1mAXFTf3sVXf1Z5SyGeHE1Cvjj3Mq62NcQY+yNYj/aRdTAGQXqguw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcce0b9-7938-4bed-51dd-08db4b098c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 12:34:18.3890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1lNH11RPMKVMjDnZJcDFe6+zqD2Xd6bl19dvb530KpFVq7XtErXf/Lw90IatpBIxOJlmPLDf2CSqeINn0SpDn9kIJyJt4yvxTts5JMtNsgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6298
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjkuMDQuMjMgMjI6MDgsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBUaGlzIGlzIG5lZWRlZCBp
biBidHJmcy1wcm9ncyBmb3IgdGhlIHRvb2xzIHRoYXQgY29udmVydCB0aGUgY2hlY2tzdW0NCj4g
dHlwZXMgZm9yIGZpbGUgc3lzdGVtcyBhbmQgYSBmZXcgb3RoZXIgdGhpbmdzLiAgV2UgZG9uJ3Qg
aGF2ZSBpdCBpbiB0aGUNCj4ga2VybmVsIGFzIHdlIGp1c3Qgd2FudCB0byBnZXQgdGhlIHNpemUg
Zm9yIHRoZSBzdXBlciBibG9ja3MgdHlwZS4NCj4gSG93ZXZlciBJIGRvbid0IHdhbnQgdG8gaGF2
ZSB0byBtYW51YWxseSBhZGQgdGhpcyBldmVyeSB0aW1lIHdlIHN5bmMNCj4gY3RyZWUuYyBpbnRv
IGJ0cmZzLXByb2dzLCBzbyBhZGQgdGhlIGhlbHBlciBpbiB0aGUga2VybmVsIHdpdGggYSBub3Rl
IHNvDQo+IGl0IGRvZXNuJ3QgZ2V0IHJlbW92ZWQgYnkgYSBsYXRlciBjbGVhbnVwLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFuZGEuY29tPg0KPiAtLS0N
Cj4gIGZzL2J0cmZzL2N0cmVlLmMgfCA4ICsrKysrKystDQo+ICBmcy9idHJmcy9jdHJlZS5oIHwg
MSArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2N0cmVlLmMgYi9mcy9idHJmcy9jdHJlZS5jDQo+
IGluZGV4IDcwNzFmOTBjMjNlMy4uYzk1YzYyYmFlZjNlIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJm
cy9jdHJlZS5jDQo+ICsrKyBiL2ZzL2J0cmZzL2N0cmVlLmMNCj4gQEAgLTE1MCwxMyArMTUwLDE5
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjb3B5X2xlYWZfaXRlbXMoY29uc3Qgc3RydWN0IGV4dGVu
dF9idWZmZXIgKmRzdCwNCj4gIAkJCSAgICAgIG5yX2l0ZW1zICogc2l6ZW9mKHN0cnVjdCBidHJm
c19pdGVtKSk7DQo+ICB9DQo+ICANCj4gKy8qIFRoaXMgZXhpc3RzIGZvciBidHJmcy1wcm9ncyB1
c2FnZXMuICovDQo+ICt1MTYgYnRyZnNfY3N1bV90eXBlX3NpemUodTE2IHR5cGUpDQo+ICt7DQo+
ICsJcmV0dXJuIGJ0cmZzX2NzdW1zW3R5cGVdLnNpemU7DQo+ICt9DQo+ICsNCj4gIGludCBidHJm
c19zdXBlcl9jc3VtX3NpemUoY29uc3Qgc3RydWN0IGJ0cmZzX3N1cGVyX2Jsb2NrICpzKQ0KPiAg
ew0KPiAgCXUxNiB0ID0gYnRyZnNfc3VwZXJfY3N1bV90eXBlKHMpOw0KPiAgCS8qDQo+ICAJICog
Y3N1bSB0eXBlIGlzIHZhbGlkYXRlZCBhdCBtb3VudCB0aW1lDQo+ICAJICovDQo+IC0JcmV0dXJu
IGJ0cmZzX2NzdW1zW3RdLnNpemU7DQo+ICsJcmV0dXJuIGJ0cmZzX2NzdW1fdHlwZV9zaXplKHQp
Ow0KPiAgfQ0KPiAgDQo+ICBjb25zdCBjaGFyICpidHJmc19zdXBlcl9jc3VtX25hbWUodTE2IGNz
dW1fdHlwZSkNCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2N0cmVlLmggYi9mcy9idHJmcy9jdHJl
ZS5oDQo+IGluZGV4IDRjMTk4NmNkNWJlZC4uMjIxZTIzMDc4N2UzIDEwMDY0NA0KPiAtLS0gYS9m
cy9idHJmcy9jdHJlZS5oDQo+ICsrKyBiL2ZzL2J0cmZzL2N0cmVlLmgNCj4gQEAgLTcwMiw2ICs3
MDIsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgYnRyZnNfaXNfZGF0YV9yZWxvY19yb290KGNvbnN0
IHN0cnVjdCBidHJmc19yb290ICpyb290KQ0KPiAgCXJldHVybiByb290LT5yb290X2tleS5vYmpl
Y3RpZCA9PSBCVFJGU19EQVRBX1JFTE9DX1RSRUVfT0JKRUNUSUQ7DQo+ICB9DQo+ICANCj4gK3Ux
NiBidHJmc19jc3VtX3R5cGVfc2l6ZSh1MTYgdHlwZSk7DQo+ICBpbnQgYnRyZnNfc3VwZXJfY3N1
bV9zaXplKGNvbnN0IHN0cnVjdCBidHJmc19zdXBlcl9ibG9jayAqcyk7DQo+ICBjb25zdCBjaGFy
ICpidHJmc19zdXBlcl9jc3VtX25hbWUodTE2IGNzdW1fdHlwZSk7DQo+ICBjb25zdCBjaGFyICpi
dHJmc19zdXBlcl9jc3VtX2RyaXZlcih1MTYgY3N1bV90eXBlKTsNCg0KDQpTYW1lIGNvbW1lbnQg
aGVyZSwgY2FuIHdlIGRvIGFuIEVYUE9SVF9GT1JfUFJPR1MgcGxlYXNlLg0K

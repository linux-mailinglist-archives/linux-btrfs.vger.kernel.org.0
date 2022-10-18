Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CEB602C4F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJRNDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJRNDb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:03:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2985C4D87
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666098210; x=1697634210;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=fa5VuVy/vDVfyN7nHfYLtVsqUgigAoa1QeLLMlHLfUNHJ+KFLByqpZQp
   HXwV7Gul77oZDETRUfDpWkTBu/pW8KfMkunY/TPbDsavqDAjPFnaZgoSr
   xK0pmiBSUzvH+TPbESVWcMOq2yA0W4n7jIlU2VPW6QlB44MwuUh5X1WlS
   YztKbVyrNYPR+qyI+ULe5kCIlC1XoZFbWCHsBnJXa3BffwceKOe8fhn5Q
   O+YuTyydU0P+qnHYWayZyqlT+PP9RZS/tmg0iB+BnVctbpzkYQ5BkRMXL
   XTwE6o9aIAaxXizvshXOxWuhwv6gGpHNbmqQJALcR4s+8JcgVM3tkaUZo
   A==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="318443191"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 21:03:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhlb2IWEjQKAfN8OQGcCeEUhh/X/Q0FcqVz8W5lSzSWvQvZPPzUh6mleZZ2cDcQXwYykehkvk1veMAHKnpcp5Y0f2kNrjO382bHjn3dsf6UOkUu2FNa0Qo8zU5ND4dFsSlzDVEtKNgsUlPCc9ifHFUpxQfAZ5qq37ZbxBaNAkzfaNOGHoC8y30SIRFyrnkF1MIKYyV+bOTRJYQeOhtW9fIvnGgmWdRRvbFnVN7tE/NMVHSwhdu0D84xgCsn/hZKRgGcZnA5ung2j9Y2d+gwyU8wnUUCrrQzzWRbgm/ty9+FujGm+IOOMaTOcqzDFyGFuBwtUdDhsAB48dd7iP+iCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=KeZsg9jHz17HShLGl2gI3Cc/0WypQzS131Ffw1Ll2tFkQLedwmGrOFtr9NuSr8VMOdF8291rraAnQMq5ZoWY825qr6HUG21isT1NSW/3l7wHrsujYoKZLA60hH0P2PS3M9w8qW/RPNM679FRVH2wolOSmsPUQ7TQYuNdtT7V/PCid0Fihr96DfOsw9qHFuK1EopP1YxenxniwPMydkyWi2Yp+ENNu50kLuLYlPXs4t3n+YSaZYiU9/3RUVsVJtBihDqJdm/1wYhbvPUQpMEzxH1uXSmrp9bYvnJZksOsOwyLJEAD7tkOMbJh1vbskSar+zKJ6ETlw16R2LgBCZFz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Zc6pLPb743m4xQtr240Sm0Lo0WgWxrCFB6glfSzGHOABh8TRpekMateKrL+C5pHanbJVXR6GcXuzgjsX2j/xktl8jQaxacJnj1hmU3Ejfpie7QKaLj8qgjSxRgBj4gb9Y50x4kEMdRFFhIr2fj0TBeEny69TmvltmGi/6QF/qrU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6300.namprd04.prod.outlook.com (2603:10b6:5:1e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 13:03:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 13:03:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 09/16] btrfs: move fs_info->flags enum to fs.h
Thread-Topic: [PATCH v2 09/16] btrfs: move fs_info->flags enum to fs.h
Thread-Index: AQHY4lwPBsURMb05l0WBSH6WNko6v64UH0wA
Date:   Tue, 18 Oct 2022 13:03:26 +0000
Message-ID: <c1a82fd2-c32e-18e6-292f-84bffd7640cc@wdc.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
 <e0d28f8bbdf3c48870ca483fadd9d38562a4712c.1666033501.git.josef@toxicpanda.com>
In-Reply-To: <e0d28f8bbdf3c48870ca483fadd9d38562a4712c.1666033501.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6300:EE_
x-ms-office365-filtering-correlation-id: 36aeca35-9d2e-4654-9e3b-08dab1092585
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X0/HUQLHbCtM0+DaxkcbCWV5u2QIeHEYFWtLIDUzqvGhgmMV315nct+vYXmp7yXrR9VQ3IZvw/MIm+Aqk6YW0m9DUFVn7NjbQua7FrZZD5k9Vj8Ooznc3FvbRwMNWSCpi1oaxmpA1IunaszG7jli010L574LPISSkOU7zDt0roJiLbs633/OdvrzBnjK8bvidWDTXb+5ua/W4N63ZZr55YxDuHJFTFQzXZiVGZXJ3AJNmKCnjU9O+TMokJX9NvHEI5b/NqHbI/Y4zJ4YkWLIZ9/bXj+Q4PFhAbE7qsFoXDhQPzHofJkb9HOaLm8v0dvWPVSRHqUKgskvo/HVbyKMZEMvZsghfRTz5kibKWPX5+n9zMBpgkePvGKnaRAf+59tDnSw/L8mePDRm2IdihKKoUhpKxWmoHhpZNb3mOcnS3QR9dtES7w6twg827BP8C/DhkW724+J/XTxPwjKwN3wzudHpNAZeKrJ4eyH5+NX79rZ3bjdyKThJaPSS0Cxb+Xdh/Z2cAFb0UrhbR7mzBcX0vTiuvJK6i6PoWxZ10e0YR3owJ76AgVsnuJ5UbLapOlfsvsoV/hqOnrvp/vCK2+eDw1a4BPacZLZjzVP2woTEq3v7NGyvQp5nKL1EAnDvov5JztjRhaeaW+yfsb4q7Bu19ZJ39Pjg3SO5dYP3RbplFgvcoI1iUg4dOngMHP1YeOlYR1MnSwCTSsl2C/lpoHadrikE66jvMXcAAoiBfi5/Alxwssqm8MBGLVlBtij5TkTA1kiWvKAZGSJVTG6H8xn/zn+pzxKUjG1oZK6RI0meADcZMpzRJTzOkIwQk6TneduMR6/bUoM7U3YXX93vTZsvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(31696002)(316002)(110136005)(8936002)(4270600006)(6512007)(558084003)(2906002)(5660300002)(2616005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(19618925003)(86362001)(8676002)(122000001)(38070700005)(41300700001)(91956017)(186003)(26005)(36756003)(6506007)(82960400001)(31686004)(71200400001)(38100700002)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk1pUzFWQXdhYnNxQ0pMNjFVZTV4NUZSSUZjMlA2OVM3KytMSnB4YjJ6YjBp?=
 =?utf-8?B?ejRaZTYrSkQrQ0psbTlmakxXY2tTSWhuUHp2a1B5QzVadlRoaHFMWDZWMnFV?=
 =?utf-8?B?Y3VhSk5vRFlGMkQyckJLMUFJdWZFZDAzcmM1TUZpSXN5dCtKMjBrZXM5SFFs?=
 =?utf-8?B?UXJNNEI1QlJCMDlydnd6YnIzY1NVRzdML2Y5Z2N1eTlwVHNpUm00V1RjZlgz?=
 =?utf-8?B?WUZiMGtyQXV5Zlo3TlJ1N1J6Q0l3SS9HNTZzQnhybkp2aTh6VFYwMVJyMDZI?=
 =?utf-8?B?c05iZG5RQTAweGVjTEJWVVBJTGNxdUxZZzV3bUZzQTNES2hCOWxGZUJSK1lR?=
 =?utf-8?B?N0czU3dsbHpiMXFRYkJjT292NDFZMjBsQlI0VmhYVmcva2Fkek8xV0I1bUNi?=
 =?utf-8?B?bi8zY2M4WGR6aFVTS0xub1RGKzV4L1ZHNHorVGJ1SkN0OGlMa0xWWUJMTUZW?=
 =?utf-8?B?RitFZlVybzVRVDZLdVdFWEdKVEx4alpvSjZHaFArQ1ZPaDhIenFNMzBWSTB0?=
 =?utf-8?B?Z1MvRlVNZ2t1NlIxQ0RId1R5RVRYSm1kbkxSZ3ZuLzE5SUZGa2k4dDBkdEhy?=
 =?utf-8?B?MnNpZlJLczFWSDVWTVk4Unk3c0g1UFdDbDRveE4xeDZMak1GNEZZaUExL05S?=
 =?utf-8?B?NTNGVkk4elcrRFVndkFObEhLNDJ4VktvK1A3NTBhajhXdCt2YzhSUkEvL0tZ?=
 =?utf-8?B?T3FuQUNSUFZZMHpITXRrNXl5WTJNcnYvaDdjZ3FrYTVzSDRRTUFxTkVub3hy?=
 =?utf-8?B?enQ1V0tYM0xBeVRaNlJ5N2JxNnBkZzBZRUZaVnNUQzdxMVRDYnd6ZTk1c1ZZ?=
 =?utf-8?B?a0UvTkRyUVFOd2ZGUFpqZlVZUDIyYzZjRm0wYXFLRjFsSzNteTZBV2FQN0Nh?=
 =?utf-8?B?Y2hLQ25NRkt5NVNaa2dZazJMQitHNlY4cTRNK004b2xUZUIwZmlQeWdLblFu?=
 =?utf-8?B?V0lNcGg3S0dtL2JHSU9STjMvSmtsdlRKbTF3UlNwaFUxZFdjUE5GY2lWQTY0?=
 =?utf-8?B?MVc3b1VCaTVKd1ozNkQ1WkhJRDlDaU5hZlpYOHVodnJSRVlLSitUc3ZNNXZG?=
 =?utf-8?B?b21vZ2dpSzZZN01aNHVNY04zNnJYck9zNFpDcXhCZmxhMTlBd00zbXVKS0xt?=
 =?utf-8?B?KzNDSHZaWG9PdEl3ODF2QWdlSFVaVW5MOW5ub0xEamMyV0U2ZHM3cjRuNklH?=
 =?utf-8?B?Q0RYMytRM3pOajFzVnRuVEJQdlNqNTBmZDdUTFVjODNXRHNkdTNOS2xGYzZq?=
 =?utf-8?B?N0lkNXQxZzdNMXA3N1U0b2dhZE15bUNxQzN5dTE2TXhGU3RNY2lsa3ZuQWVL?=
 =?utf-8?B?b0tJOE8yZ2haVndYaGtMM3JjS0IrRXRCQzFxT0dSWFhpbi9EdUZxSll2YUFt?=
 =?utf-8?B?Q240NE1YV3ZjVXNHNG91VzZSNmVlNEI5d2hoeGg3ZENqREZxOHFOYkRHODBX?=
 =?utf-8?B?dHpVRCtwTjNHSUJsTE5xL09rbGtEZDcwVXRVWkhneXVRRDQ3VWNPcjMwbEdh?=
 =?utf-8?B?NmxXaUxXdnA3RVNveUwwWE5HakUwUFdJSHE0TzJCWU1nN2hucVRhaGVUZEV0?=
 =?utf-8?B?aVJ5RzJwbkN3ZmFTRy9hWW9TanEzbFk5RTFLNlJJZ3ZkTFZDQzZ2cFVySjNY?=
 =?utf-8?B?a0F3N09CYkhyWXJaSE5EUDFRRktnZ1VjTGw1OWI3Wmk2L2tHNG1DekYwTGlW?=
 =?utf-8?B?bjArYk55SkFkT2ZwbGdXejRNRFJML3l5UGhjYmZzaVlORzNrS25aRmtlWUlo?=
 =?utf-8?B?NVRhcnBySzBwRXNZYkUySzltRHdVcEFMcldjbUVLWlBrRTNWSVBSeWJEQ2xq?=
 =?utf-8?B?NUF3d1RLQ0MzNlFqZHNHaTZobUEzdzVvWVRmdUlJRzRHRjNlL1A4QlprTjBP?=
 =?utf-8?B?QUhrOHZCN2ppOVoxeWhidXdHU2JJWkkzQ01HM2VLc2JYdTZuL056NWRBMnB6?=
 =?utf-8?B?bzJqTTdJMUtLR3VLcisyeWhWamM2Tk81a1pBeVkvSkN3aXhTVjN6RktYV0Zj?=
 =?utf-8?B?amFoWUlsQ1BDTlkvejV5T2FTNHY0OXNmSjVSNlNyNkwrMldicWc1b2ZCcHpk?=
 =?utf-8?B?ejJEK3lYYktENUxrdWx0U1RwYkk5Ri80TlgxUERqTmRFcUZVajFmSVg2T0hp?=
 =?utf-8?B?YnNzTkJnMlp5V0haSTE3L3BPUWRvajRZUnlrRW1MUy9IdVpPWmZ2dFNEdXlO?=
 =?utf-8?Q?SqRNlUWipf3m3LcQy3cIerY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0D593ED824A0B44B9CE3AC8BD135E3C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aeca35-9d2e-4654-9e3b-08dab1092585
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:03:26.8213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EaCwvjPCfeuBxloUD0Xo2UVxXe/kZfYQ8XIZTPnSdZqCeguduNLD88rYinLYku9UuG1ikz39ccLxfUf2+FyCl/ofoLij2OMCnaM95HnD/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6300
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

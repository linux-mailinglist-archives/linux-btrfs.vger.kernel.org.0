Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E9C602C9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJRNNS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJRNNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:13:14 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E1BC821F
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666098783; x=1697634783;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=GseovGCJXub7v/1CUlwle3P9sHrpD4c0Fo9g7Jyx8EYotNT9Dy6cXIlA
   7BD9XzYqhLhQQ7SXFRpq23ASbHBre+GOvJHjkJF6KDUK/K9zvHg6SDkK0
   3EKmd3iFaejsWMEWa/sENFEOEhT0GF17WH2RYrUiJKXqfBFZvcuzA6UnC
   AHS/0gh2bDSE90uviOJ4JgOH1k3HlTxxx8TUO5UCOuVs3xjkPlnQycYMA
   9Zs6LlGCYUDJKlQX+4vTeVulZzwicTCj3SWYQ8IDNrRrrsaUwgZ8Q6txt
   kkCbIaYzJbrxbZFCriCLNE+X45JA8ZmD16fX1uOgQx5kvFF90N+M4+npP
   w==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="318443891"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 21:12:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4NLd4hNqjxmE9+YMrklgfvkSkvlZ5UJZu41hxCS1fz86EBRKBnQKNWxD635TExGSjLoEwKUJlEQ5UYp37SvpBJ74Ockg5q2cvilyxufDudJRrEv0uKJZKjt/ZPpkRrLT1TtGGuicyA4xaJSmbu0pFkm3/hgQD7Canf/htsKis3q3TuROma6rxRGcp+o0PWXBB6ENqWUNxuszdmtNNxje9DStHZ0/6KHXvPTRM3wyM5OnvVXC7oOFx9ddvrF60Ri3/mzFOu7swyUAJIZeb4XQglNXxVLt1AZt6AX1uwa/ZvzHo8Wf1WXlrD9A9uVPZMUNICmiYApYcWEPviO5DkW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ekpgLjmLNShGYRAuYs93nPBjGEVJXRXQBUFWEWvk4Eva4aqBY1ECcAnXVS43pxlxMyEdU0oB+tuoO73MS03aH0HX04bvC5XvfrfsSsHKkNz5/EqgXkvWibObCKr4u4FfQI2dr6dAujyef2xIgqg8O+RJpSFvhsWIj+1wRz4Z5peTtjJ4MuyzfWZ2lLymNI15Wb+X/ah9ZUg1HDU8FGbyIkdLhahac0Mfx3mLA/vWw0YnK3ZtEmMyY8QegKtifLQB70xfccKv+f+qJ4eXejZEhdYS+UgILKQlkHjF13EeGCz/pLk+mnDWPdEwvmowdIpHtl9Bs9Wbdgt6mWOqeQUK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fPSjxx8p8q8Xol1T+MZPLC8RYk64uSJiEzXfoP2pOTsaNSmdVntFvv1crs2jS8NrYiR+KQEJhNdTgE75raL6phL8xQPA5xLv0HILI8sF40cMGCBgh/laQKFMyMCjd0YkQa4d58/r9/Pw+XRKcl8UVysI5+K1IJYsGZ0o0zlis6Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6226.namprd04.prod.outlook.com (2603:10b6:408:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 13:12:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 13:12:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 13/16] btrfs: rename struct-funcs.c -> accessors.c
Thread-Topic: [PATCH v2 13/16] btrfs: rename struct-funcs.c -> accessors.c
Thread-Index: AQHY4lwSP/Uc9ApAeEaxT9xLHMZy9K4UIeMA
Date:   Tue, 18 Oct 2022 13:12:42 +0000
Message-ID: <ac3437c4-1eda-f80c-421d-d8aee7ed3352@wdc.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
 <aa4f89bf455622914df09a10f2264179c46a7c26.1666033501.git.josef@toxicpanda.com>
In-Reply-To: <aa4f89bf455622914df09a10f2264179c46a7c26.1666033501.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6226:EE_
x-ms-office365-filtering-correlation-id: 97f71e8f-d9db-4ae9-367d-08dab10a7103
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rps25rlREtZieDicxmhd20dgwiJCukTt0JAYxvk3WFLHn62LRhQcNXoGMLMDGF0VP2Es9CjSShYE2+tWuFOQZqYQJ2DRMOvppHTqpzdmSdwJCmGj8O/BF9rBypsz/Zh+srVShaTF5xqstzIx4iVlprtQvOV6kTks6P+jGKZ/yIexdlQeXVqRu7QMAz3u3SWxysdqMqF1ZoPZ8vEAOCXYlw6QJjlaNV1JcaIMMBO3HCXrK999ItWUXXNh4+YltmMJXjCP1t+8ke+NIfLJxS/gsLpRe45sgETHTmSarHiUJVVBNZbWUmJtQgiTFtD8EZqyJAVATd0TXrYiR4HGV9TPp9GGq3hmWuebT1jBfqDqWpJUsZ6F7TrTWPTbdLgxuBp6WR4mcQzxBPXunL9ukzrXQfGdEmTFrsAAXvNRlRHtS0erT8GmTbGod3IuK1E6Q27lgOOZG68ZDJDc01O5MIa7kR//z821fIST7Ix2sEFvo7JrJ+6yO2CUaPR+n/k4WFScz33omecVJnB9hWqvQidq6QRHDfCjYXLBnow3z8h9Vf+iU7Lm0ii8sIQfjInURiFZOSkbUpYopVN9EPiIUALTwqV9zKNIw5zaX9B36llwjZujmEuC1y+2gT5WKIegtiTsUY9psM2RGHeynd9ASep6+JmxX9kIi3+ODA8uQgbOMjvRUk8FwdsG3+qY14iz7gCW2vlgk1tNcpBfNylymJ2xf62R6KjhAEPZBT2E4L8KcQB32CV1Ir/HMT2pMLjaxxKFtXVoa/yP7zasgBlioDzaTE3ZvbZkHGBNuYR/LVLv9jY/BVIAJrTu/g41RehnXopGrME5/KMu3XGbV+MpaAxKzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(558084003)(36756003)(38070700005)(86362001)(31696002)(82960400001)(122000001)(38100700002)(8676002)(66476007)(64756008)(110136005)(66946007)(66446008)(66556008)(76116006)(316002)(91956017)(8936002)(19618925003)(2906002)(41300700001)(5660300002)(2616005)(71200400001)(186003)(6506007)(6486002)(478600001)(4270600006)(26005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0JBOVZvNVpvd1c5RXYrQVhNRWZGRjRXZTl6ZStZaHVqNHh1TU96eXRTTVlr?=
 =?utf-8?B?Vlh5ZEYyWHlDY0pwNjF3NkxpVGswMEFPNXdnaXNpSXFvOHdMM0hJZGxHKzRx?=
 =?utf-8?B?UFpSbmRpZGlHNS9JMENQTnRMMVk3V3hqS1krdWRLV1ZYc3EyV2d0MEJjZ3NR?=
 =?utf-8?B?alhhWUNCaU1hZGhXZVBJZFVJblNGa1Q0T09GcHN5Q0R5VktBSW5sRk1DZE1t?=
 =?utf-8?B?RzJkc3IzZCt3a3RteW0zZDdqaDVlRXZCUUt2Vnc3TGxwcFkzOEVyUkxUYkY5?=
 =?utf-8?B?SlptdTZGZHpKN0VFUmFLSzJJc0ZCU0JUbjJIV3NFZXRoNVN6cnNRUVVrVXkv?=
 =?utf-8?B?SUU4NHJYS2xTenV5NGhEaG9FOG41cHRJa1l3clA2bkI3aVZ0dnhWZU1aZEpN?=
 =?utf-8?B?SVZJbnhtVk12dnZpZGRqaXVCNzY5b2kyY2o3a3dOZmxodm0xZVdVaHEyOGRQ?=
 =?utf-8?B?R28rUm9UTm5YM1oxcFpoOHF0c0hHWXIvVFkrYzAvdU85SUdUL0Ryc0hLbGI1?=
 =?utf-8?B?SDRJOEFxRzRXNlQzeXhTQ1RCdDNwaXZhOWxsdlJHNVZKQi9uRWd2S3EwR2VQ?=
 =?utf-8?B?c29yRU8rby84SGVWaTMrSDlaNzlheXhzbW10VGgzM3pRcXZXZks4QXBLZEpX?=
 =?utf-8?B?M3NrendrNUNJUEJEZ3ZKN1dRYjdHSUFVQWpla0V2b2dvRnZMS3VWWjlwTnd3?=
 =?utf-8?B?aGVOZnpsU1NVanZmc2F2UFMyOGpvdGhpVTlYSTRSVFVncnlaUTJQLzMxUGM3?=
 =?utf-8?B?emJ4OWtvd3diTks0MXdSWnVLN0tWMmxQZzJGWngxS0RTUnN6NTVxVkJvQ2lG?=
 =?utf-8?B?TEVwL3VqUTk0TXRkWnRFOXJwcFlTRWdUd0NkTHd3TFRhZzNJeFBsZC9uZkc1?=
 =?utf-8?B?MFQzRUpYZi84bm4yTk5ac29BbnZtUWVTSVFMajR4dmxaL003L1RTaGRzZDBO?=
 =?utf-8?B?Z1lhb1JCejYwVm15elY1ZEJsSkl0VkpXQ0RrMlFtc0k1NFFzOE5Nc3lINHJN?=
 =?utf-8?B?QStsQVFqRTAzWm5sY3lGM0N6S041Z3lLcGxxS2QybWxpellvb2xjd1ZjK3dZ?=
 =?utf-8?B?eHViaUZxQ05aZTJ1d09PNDljbVpSQkV5UmpGY3VOOXRVQ3Uxc2NnQ1NwbmUw?=
 =?utf-8?B?a2ZZQlc5L0JlTFNWNmJoOWlOUk1LZ1pQRmJ3cGJiK1M5eDhvT3dkeXRoM0Y2?=
 =?utf-8?B?MERTUEpMWnJjandsdHo0dml3L2NHNTJ6dzRsUEhzVXYrMitEdVlhQnU2ODRj?=
 =?utf-8?B?dFNwNnhzU1FXRjlXV0tINVJOL1Blem9NWm8vbVJCdTNocmd2R2lBcFJmZTRY?=
 =?utf-8?B?bkJmZUJHUURIQzgyWmViWVNzUW9rZXhFSVdORnVvTHRYRjFiUVE0bFh0Rkc2?=
 =?utf-8?B?UmJJQS9PTUppcXBHNnRCcDMzSS92aG45MDA0bTg4eFhJbThlWTFoVVBoWWht?=
 =?utf-8?B?SmFHMVMzQm1Bb2FiT0RNUzJ3RmpmcmFKYlo4MURrM2ZFNk9GKzlDakVhZHV4?=
 =?utf-8?B?NlpzUjgva21zbDc5VEp2RG84MW9kNGd0Zk5Xd0J1ckUvSVpiamVJc0ZvZ2hM?=
 =?utf-8?B?cmtwdGV3QThmK0pMUmhNZjluM2pwUDlWSnE0QUZtQXNHNHJYeDJoRlpIdHhQ?=
 =?utf-8?B?SHgrMkVabUtJdnhORlNicG5yY3JaSTBZaWxCdzM2U3YzcHphWUFScEtnbnpZ?=
 =?utf-8?B?ZGdISDJXTjVnV3lHUnEvUm4xMzlvcEhwUjY3REpVcWc4N2d2OXQ1VmZWM0gw?=
 =?utf-8?B?N2VOUW1zWSttS1RkcjNJeVJsNGVJT3U5bytoTkpFQnQzbDdyVXo2aTZ5QWpT?=
 =?utf-8?B?VmVINGNsOXlKQkdEQWlsRzNQZkxvZmNOd2pjZmJiejU3WlQvN1JUZjUvMTB0?=
 =?utf-8?B?eVZFc1VwSVBjUytOOStKSnlUdzFISDd3SXdRd0wzUi9hYVM5OTdLL24vaXk4?=
 =?utf-8?B?cWplRGZEbUFjMHhLYXduWE9zUEcrRVppaEtHUEJoUllpSlFYaENOVGNKeHRq?=
 =?utf-8?B?UTZLMUQzZGduVnd6dk9YWkNFNTVoeWRTTjFnUWhzSWl2di94Ym1YRTdtTWh2?=
 =?utf-8?B?ZGV2eDQ5dVd0TGtHY2VSOHJ1Q2N3WjJrem13eWZYelRDYTV5ZmlSMU5EZmtw?=
 =?utf-8?B?UHJoMlhIU0RtRFdrU3E3TUVUeFR0ZU9ac05uUEhFWnNwQzBiU3RKckxOTFdW?=
 =?utf-8?Q?emWF3Si8MPN+Cgoht2QGF10=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6C002CA77BC5140B4E4136AB733449C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f71e8f-d9db-4ae9-367d-08dab10a7103
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:12:42.9546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRKPyoC5XhG0Nz864NZcOpH/iOslC9vfHGmOH+67O67v/kkAgbhNkOMNhJULBcMr4MFbZA9H53IcuioxLa30UAoIZt4gmg5HvGGtae0FSqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6226
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

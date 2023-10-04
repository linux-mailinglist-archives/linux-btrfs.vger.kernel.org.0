Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC97B7F82
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbjJDMn1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 08:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbjJDMn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 08:43:27 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC07A9;
        Wed,  4 Oct 2023 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696423403; x=1727959403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xdwabZJBv8d9C5aFZNjIysS6JXZ4Pbp30vQHUKNRyOU=;
  b=r799vapSnLDeD/zksBlWZi0u8x85n8UZojepIFNBPL3YjKUcsh6heUwc
   YI48eyF3wgU2817jph5WeFKmAomvjcl0Aa8cIZ8+ZMLtJq1yugecdmc2T
   epUyE3qO5VWFZxbQ2abbB7guqp/ueddF4lDgNoltDmsM+PVJ+sWXTdwv5
   fzNC9zAsxjg45WNaPpw3b6mAemwgFVsUB7rk9Gtqa8u/na2b9bH4j8D9f
   vIJ/Z084z3eXss8yRgAuPmr78kcM42oNVTwMHRu/IzjwDeLOq0ADo9Gf2
   G/Fipfzpb0AX0SUoxGfqa7vPYGqZSwVzksXcjnBt0ecP5sm6IrqhhtxnG
   w==;
X-CSE-ConnectionGUID: 90for8kFSEGs5OOfCajCbA==
X-CSE-MsgGUID: H1QPveDzRZ2TwGLVVWI7zg==
X-IronPort-AV: E=Sophos;i="6.03,200,1694707200"; 
   d="scan'208";a="245977451"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 20:43:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX3dt2ME7dfnWKGBaSssZcKmPWznZmAdHDFsG0hkwPOR8w+yE2XdVBhUuuGbWxZOXm5C+FLkBNr3Z8xdFeszdTIX66/iMfyHxD82okgEcYWYrrDkTt2ry9jK1jtuXWUvB2gi3UO2sRlMtq6B0ha72b8SpsmF+zT76HW8bKuDXF/i7GddRd0P+Td1YoYfpfilDlM8t82adoMSyNI3F4fcmfqk5BTSJ9YjwIc0ZbeZk2Yhcrf5BsJ/OJet5UbgxPdeqsXabKror6xUK6bibZzXbVKp1T1T6qUKmfL7ltBWzwdeT44MLgdiSaEoSbkXF034DjD5TNPFqwx1qyEivksHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdwabZJBv8d9C5aFZNjIysS6JXZ4Pbp30vQHUKNRyOU=;
 b=g98G0LRtpjk1awP7PfYpzsS5KhAVUsmtYUU4pKNKKP5/FnxJbrd6oTXxvT/XgfwAEUEotjH068qXKdMdyCZByPQZHpZoJ49X4K8F28Pk2H8mb78HRdI5RTf6oAdbLIg01s0XG3x+3RkOWgKx/Egw3u7H1TNjK9kUMvl+WguTGRLPQvod5913k1wtT77EIjB9EmtCnm2UVOLCY53Xi079FLJdfGfd3KOcA2WiLkh7o4FJm9m8UiIPFFWZ4dLCCQl2NVYgO7HYnIfE1cvtXDeQYRYhpXibCCIxH2eGecm8XL0THEz0J89neEUcEs+g1XmBykWC2K6666D5F0kvL2oMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdwabZJBv8d9C5aFZNjIysS6JXZ4Pbp30vQHUKNRyOU=;
 b=izhfpV5AD31C7diseWRZEQhGeCRjr2bZiJ0fLsSYMo5onVKA2uc7VvKr0vOgEyD35fwnbb7lzBBlYI3Pt4RoByKyweh5fcJDUf/VOYX9TOoKDr9TVdjMvD0FUXMeIYFN8pTQ8kwcRvPjUWVOVsx4vOuK85vexpCuEncfBBmfoFc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7486.namprd04.prod.outlook.com (2603:10b6:a03:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25; Wed, 4 Oct
 2023 12:43:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6863.019; Wed, 4 Oct 2023
 12:43:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] btrfs: change RST write
Thread-Topic: [PATCH v3 1/4] btrfs: change RST write
Thread-Index: AQHZ9phIgZpxG/DCr0ud/gO3Uy0nErA5k4OA
Date:   Wed, 4 Oct 2023 12:43:19 +0000
Message-ID: <4204b717-58a4-462c-aeff-02a733a80170@wdc.com>
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
 <20231004-rst-updates-v3-1-7729c4474ade@wdc.com>
In-Reply-To: <20231004-rst-updates-v3-1-7729c4474ade@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7486:EE_
x-ms-office365-filtering-correlation-id: ff2bfddc-67cc-43e9-2790-08dbc4d77cf2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZwRDDUn2jOlBV/L6zWHvmUVoFKm3oz267Gme0hs7uQ2duPWSDk9KVzhu5hH4IdCilDojbJGblSVzTosvARLtbgG1S1iehHoO4vvZ58nK602SHkHAicjLWQ7kQ64Dxhn+lZBtdcf8BncVnI7F5SjYLYVdHK9FYWpUEuNFuFq2oPR6wtN8gLb8/OJlqvoXlcWHSLC/83FoCcyz+qQx8BJa2+TASKisx/IrjtBM54JZ0lku/yCwWRZti+Oo67CJZXIman0jqFRjQ+5rmymh15z+Z2zhx5wAEEadngKz3wvcm6vVish3rBkV90+xhTvpIzaxn5cBQn6+sz38hpJ4apjVP3tnN+bj5gl2ZrfqlrdwH6i2PCZa4YFNATdHpgaH/3L8ZBony2LRxlEfp20DuQBHi2gcjtHwlvqYdMUpJJ8rXn1/ZhdYK7LuMTw3nTTW23KY1BlAnAR24ECNyfpOQysHeYW89FnpMrgSrltr5UuPdk2AxmYhJSpAqoc/WqWHIR9hcF9MSrT4dso235Cl2b2NtiVW043iarKMuSUZv6uY4HtshHKDV1g1PGK7s6As9LuDqDX17EnXPJsvuQlrJib9lCzf0yIBxMGq0q+N5OplTWQXPSMS1TagNeMPcI30A7gCPtTcj90H3zBounE1GNOIkiKzQ0GWI1eiqYDZvqNe6WEiFhPhcXtkV6J94iz9E5X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(6486002)(478600001)(26005)(71200400001)(2616005)(66476007)(2906002)(66446008)(316002)(91956017)(110136005)(54906003)(64756008)(4326008)(66946007)(76116006)(41300700001)(8676002)(66556008)(8936002)(5660300002)(558084003)(36756003)(38070700005)(38100700002)(31696002)(82960400001)(122000001)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1BMa0NVbS95TFFZVUI2VjRXTjhhdDlVRzliTFV4VUZnRlBNdlVxbjdLc2hz?=
 =?utf-8?B?LzdZc3dJY1pBTVR5TU9jWE8rTm42eVFEK2RGKzY2VWJGd0FtSFFTcCtpYUhD?=
 =?utf-8?B?a1RHWW90U1M5ZnZnbFVaNVBCbkUyZUIwY2JyZ0lFK2s1ei9uMjlHeGdlWWRp?=
 =?utf-8?B?cnZxNjlzdjlRZHZCeXhZMk1HaGlnck1nbGpMZDZjY0Y0OVhrRTQvNkh1V0dk?=
 =?utf-8?B?N3NNM2J5eXdQVVRBUXZmRjVTZXBsWDVQTi9qOUQ4cVd4RVZlc2ZHcEc4bENS?=
 =?utf-8?B?WnZCdDUvS2QwVlRqd2s5K244WkJCdjBDdlRaakpZenFaajlITmtuQWhXb3dX?=
 =?utf-8?B?aGpCNnZCaVppeFIzU3NhM3ZLNFFTM0ZWZVpkYm5wL1g0NnhCbktkVDdCRGpq?=
 =?utf-8?B?SFZRejA4eVFiNFczQi9teUJBYyt0emVqbkJ2YW1DYndHMXhZcURUOXU1TkZO?=
 =?utf-8?B?cExqaHRyR28xbVhkSzlsUkJJWktXeFIzV3RqY2V0YnRpR1MwTExmSk00MlZQ?=
 =?utf-8?B?dllSRG9tcVRtZE4rMXJNdkZlYzBVajBiNVU5M0krTi9vdzlRT0VwREttQWlr?=
 =?utf-8?B?ckRXdFVrSk5NaCtBRVl0QS8ydzBhZWh5ZjNid3dweG40VEl4K2llRldoaUU0?=
 =?utf-8?B?VDJ6Q3RJZGo1YUVxK3o3RjBoQ2JGU1JBdUhQcWNFMjJHcWNoZG51RXhHb0Ju?=
 =?utf-8?B?TGgxSkhLSUVQUmdxeUFjV21yYk4yNUxkNDYwN3Z0YUJGbjJVWE5Cb254aWZC?=
 =?utf-8?B?U0E0UURUNHhyTld2clZQQnBsSWl1amRUQnhtUjd4THIrOTFGQVNJSmlERXZV?=
 =?utf-8?B?aUorNC8rZ25VQVAyTkFUWlMzYzlJNkJUSGx6NUExbElDVXhFcitYbUxZcVlC?=
 =?utf-8?B?SFczUzRZUHorRlJTUUZOb21xUXJ5VVVJTzFMb3RwWlZMbGxobHZKRVRocUpn?=
 =?utf-8?B?T2d2MlhweW1zdHpCaHpvbHBzNmJOSXJZUEhGUmRwRytjM1BORGhhTjJRT1Js?=
 =?utf-8?B?RDZQZFhUWEVHQlNEb3dubE9NSW12bkF2K1d0UTNKaWs3L3dCQlVTN2pQbXEx?=
 =?utf-8?B?b1BxZVpTRkxVY29Bd1ZmM3k2MmNzTjNySTdHZmF0OWd3QWRZQVhlcUlDekZi?=
 =?utf-8?B?SGRxaDZBaFRvakJ2czJDM0dsbXd1SU15aFR4SDRzQUZpcGNTVTdidHQvRzdT?=
 =?utf-8?B?d0ViNmoxTlFkajVRbHhMcXJrMjVNbisvZ0dKQ3dCS1BrejdGZmxFVDFuOEJP?=
 =?utf-8?B?ZnIzWnRoMjE5dzZTSitwOTJEMXczZHJVZWRYcFV3OFVFbzNrVEp3WDR1STZu?=
 =?utf-8?B?VE9IaFFUdzl0Z0paVU5qZkVtSlhtUS9yeVZwRkpUdlBKUkhaekV2VFNUOTdP?=
 =?utf-8?B?YWVUUkwwaWNmTE5tVW56cytUYjNGZWZLQmlmUCtuUnpMcitlVllKeFRmcnZI?=
 =?utf-8?B?RnFBUHFmYW9EM0c3N0ZCb1NaNFIwMFRqMW1FTkZXbHhIVEtMeGZ5UzBBYjZL?=
 =?utf-8?B?WGVOYSsybktHQTdHL0RGckpXOCthRXk0M1c4dVM0dTZaOVU0R3FPN2ZSQktB?=
 =?utf-8?B?YUpMZEUzWnRhbUprQW1aMWdka2F2LzIrUlcrM3A3RGdQak12L044VWtoNTV6?=
 =?utf-8?B?MUhSZEM1T01DUXU5bmFYRnR6bVlCZU5FOWdFcHh0Ky9ZUGRsUUZVbXFEY3JJ?=
 =?utf-8?B?MmJFa2lIQnVSOXZxMi9VbjNnaDAvZVl3c0U2WUxrbTBtOHB6cDl3aFJBMUd6?=
 =?utf-8?B?VEJwQnJrMDNuWjZoWFVhakN3dlhiMFB0TGpyRjZ6UVZWVmQ0TnJib3dhS1RU?=
 =?utf-8?B?djZ2NDBRNERvUmRXYnUrZUcrUE1vK3NFL1pFSk9idjlyamJTaU5FR284QnYv?=
 =?utf-8?B?dFhLd0NGWkVlbWt2aSs5SW1IQllFR1JaOGZRM0dqa204b1VRVmlGRnpteU90?=
 =?utf-8?B?RHVkU3ozbU9vY2ZJT0ExZEtZNUQ4ZnJXMmRCc2NqNmc0N3dTM3VLUGpkSmRl?=
 =?utf-8?B?SDFYcWZhNE1vTUdPM0t1ZFJhZTU0ajF0UkU1V29ZMlBNTUdDTngwRVJldmRa?=
 =?utf-8?B?K3lKaXJiNlJMU3EwR2JqVUJ6My9ZSDJNb01OMGZYZUZzbFFwOXlwcGF0Y0NC?=
 =?utf-8?B?TTUxd1IrQW1pamdBK3dsMFM0ZU9ob1ZSR3pWNVZXWlk4amFpdndlczZtdXZ0?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <461F6BCDF93C2C4DADA65A016BBEA846@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 72DxvzeAY/omhL5jW1OYoyy6VX7Jvb3ulG3XtzevPQaMrX3AXtPQlXlTCoAePzEQsAZEsEV6L4tKzCGXMD5nu1hqMqyvnnADGJ6rYn9NNJJEKI8ZOxiaVRTTu11nj+H3ca4zoEwa6O+RMNKKQewjqaIziEcQ2TjAokPaAUs+NaLEI7L/KSQQhnczvgcEe9pQwlGprKiMeY6HcjdDY6A3THn587vN2bPdRl0/LE6KwmoTdktbO1G18pQv/C/IsKkF+Jtw1TYO76HKOHbjGTzmjJahflXwUI2SF5v26m6nH9uBLTtYozfPRNlnIN7fvdaFJU9yRCSi1yghTiacEfjIRP3Y/NXFlAyziVXvJD3jU7HDJX9GjbIh1u+axo7cNAM5jq8zEXkc9mD7iyVxkRWIzGk/dh8PZ0SdrNkLBd6RP+e/0JB4w4AY5kbkT7606hzvTE9+KrVKpRE7E5fMVaNhKdsfz+9ef+FwZic8I020TWRjJUnP7bU3LjvYZooEzkLcvbthGPHmSvXxW7Q/qSNrptz6kUanfEwb7HocsPSp1/w8TQvW23iaEU7Z6jywum5V9KQs61AO1kyhEaaTvNJwDc3WBiifJyP4JsPlqVlfsUuxky8uh9cTbVtcAExE5DUVLEj2LwbngXcGk7AbE/v2sLWHtDGbxFH5hcfwellvnzeaO5eNJzJT5JrCrtWTcQb22EpFFJZbAYMWfHS+OaRZpGjo2QJGOU15TkdZc9Z01Rq59qkOGYesHSb+aLHi5XbuehWNPzCvKedQVyThUeeoojXw2ojy47WyCKBvOlzy4cf4CoFlgl0IMD4kdtTpkrY9wSS7GHzTLMneswysomKCHknBjCJ18865YAPxcZuKSWzdC/4sHTZzZwHknZCYmWYjWjWk6ROW7QjXHMENPW/Hxg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2bfddc-67cc-43e9-2790-08dbc4d77cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 12:43:19.5754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vApWzzkHiBo4We0QivJeHktZE641jSQ42C2ahgH0XDl6zoTY/1u6ieUpmn29AC2XIo5bsQ7upzjuIcenNwMmfHTY+upzV1briBfSmbbXA2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rml4ZXM6IDMzZjdhMjUzNDZlMyAoImJ0cmZzOiBhZGQgc3VwcG9ydCBmb3IgaW5zZXJ0aW5nIHJh
aWQgc3RyaXBlIGV4dGVudHMiKQ0K

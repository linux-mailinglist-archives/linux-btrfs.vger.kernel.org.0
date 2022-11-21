Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BA9631A88
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 08:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKUHpi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 02:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKUHpg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 02:45:36 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F225E6
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 23:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669016735; x=1700552735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=U52xl4T36Abc4Eo5/tB7xbcMBYXZyNwMA2k7NTgld/G6fKKnyxWu3/p9
   uWlfBjjNv6yyrS6noMTZAkS40iz6JwFR9En3l3ZoRKKy8PjMFAmwzf+Zl
   yN8fga7kNJW94/f0QknsOQZGqXp2oe73g0f23IhOY6MHuV09TNaFy272f
   xxUXKBexU8hP19OBb8GPeF4iaSi9C148cSbJP1zYIdMNL8iD/jW1joelC
   QMM6FXUhZce0q/llj82Z5T9FneakhEHgrdpFSdnq4USgXGuwuLxqSGsUy
   AYs9O/gLSsMM3XrzR/3gOLZ1+X/R5ojAtJNSbCuAs4GBwF/9dLJfRBrcE
   A==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="321117708"
Received: from mail-dm3nam02lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 15:45:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHfuqJ3rWpjXSeQWujPAxEFLvCf8VxXiLZt9mXfeul1GQtsMnfoX/Nx2W98aRO+HPjeHlDyejkhuhsp7eLyf8WEEaf9gAHFV8QYIZXxwIYoDnFdYhwONsRIHZJA3AOSXosSN39Qur2KPEIW5Xb/OJwQWEASt5GZroYm+qFN93Wtivg66zxO2JcvPnz4cdDp36Iu0fZwbCNUziHjvXdKp4N7vzlVctWq3VUW7KvQqfJ/3loQDbpEOx91Uy5pxnotyZrG3MAWnBs1dJwr8EMmfmlb7Co7j0m9sosZTt78w/3GnzFX6Qe/c9BrUd1f4RiEaJQTNltqRZjk6h78VzxwsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=hf3U1Ww3sYl1tUGOe8VzjvAXso8s78w4i0AzvHNxjmAnERdMI3wmzqoj5NQgs+COyCeD4Uf49WHef3LiOYyWYWeTor19H3CcIAYRTvgPzwVMOPBFlc3L5EewVzeJIrqESoXUsMGN3wNlmczIIkDa/65rV4S5vadawL+30FcyORQYr8ho4GXb5dZvmgcwQKM2StVJI3qQ6o0hexmEVLa607s3M+/bC2Qk3YfK2CVkCa2wZ8jqmCQg1l6dc6mU+SALeIQokI2dtFh2fzjid6pKhB/HgGPVqYAI+a/z4yARn2PxYj5KewQt3iqEXVBE0YZL3ruqowjfVsNnNeGWsFPzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Si9gGRbxCKq7Ji9YSJtuigu3fK/toSJqbrhHWniEm9cXMenFoqIapu3fbu8rJWyy21hYYfU2avF2tMC4LO9niWqf4tt2Qat/1xwBXloogL2WktPyAQpcqmc+zegaaYRYIBJfBQThuBAPUZRYq/z268j2ATV63iQgoBpspoMdnbE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4116.namprd04.prod.outlook.com (2603:10b6:406:fc::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 21 Nov
 2022 07:45:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 07:45:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use kvcalloc in btrfs_get_dev_zone_info
Thread-Topic: [PATCH] btrfs: use kvcalloc in btrfs_get_dev_zone_info
Thread-Index: AQHY/N2uTF225K36lke4td8l+cP7rK5JALqA
Date:   Mon, 21 Nov 2022 07:45:31 +0000
Message-ID: <65b983a5-8d88-b029-6b81-16a085763809@wdc.com>
References: <20221120124303.17918-1-hch@lst.de>
In-Reply-To: <20221120124303.17918-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4116:EE_
x-ms-office365-filtering-correlation-id: 7c9164c9-3dba-4513-2d0c-08dacb945de2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aKkv2hFPVqWXBXEHdpexnjNIzNKZaUJccg+5eHEms1akqnS5bF7veqUTcIqfL2/p5dytlfvXm543WCJ3wsPOMRLJMV6KPcFEkk1jYE0/6UWsZKrOheARrgeXGTLTssgQeU3E1ZGvQS0yDWQ87M5YIUumH5LwHAQ7m6rdihZFC96UuOcGczlBvfjhn6k+/NEnKj+svM7UsEiUsFP3VawStltoV8/Lj+pmfkkxTo7lNjZ0p8wYhGZcWjj54uvU3i7j8lXMHvAOJpxPNN3W+525u2mtRfNRdCjJZHjiDrDgezGouDBTe2k4qnpTVEckVXJDN/qgGjsV5LAoqK4Q1tpdfmeZP9JKwhhoNDwCrGIjd+QXeXt5/Zr+MxvNS7YWiOWHhkobpGJdEnjlIrE3mJDu9ikYKiDkDW8vU6j2I4CI5cJsNMglMZ0Qs5ZeiTwAeVsL30fMmvR0YuG23fBAeBwLuB0lwvHV+JyPDkW44Rod+1G3qC4e11koNzcPUxyodhbJ1EOfjiKHHKXInZTA4a/ZdCR6y8jIw5CXD/NrSzD3ilUBIruxAvAI4lYu6lQc+6X0IPsn0m4B3RmZNsN1DCckQSyMSw4hCEZKvR9yhIvpMhFHF5+uYZummrfL7IO7PGkBteX6DE7C3+/OcW5D1LehBoqVxHmHDZfRgOPc2ybi04fJ/zcuvMbgWbw0vMldtQm5MODWzqo9oCGipxnYjAd5LNB2VlFILDiaFwDAu0CN56ca9OqPzbmkofpDHGghxkBHjwBVvXnsuGXMZJGGmn/1bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(8676002)(8936002)(19618925003)(2906002)(4326008)(2616005)(41300700001)(186003)(558084003)(122000001)(86362001)(5660300002)(38100700002)(36756003)(31696002)(82960400001)(38070700005)(66946007)(6506007)(31686004)(71200400001)(6512007)(66476007)(110136005)(76116006)(64756008)(4270600006)(6486002)(66556008)(478600001)(66446008)(91956017)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SThzOE9yei8vZyszYXJhNzZsd3I4eHllOUNPSlVmWFdMRmd5VFRrSUJNSlZp?=
 =?utf-8?B?eGdQSm42STc5TmdXWHh0NzE1aElTWFdBR3FyTDVMSG1Scno5WXlwVUpmUDFu?=
 =?utf-8?B?a2RWS01kRTNGMVhmOVltbnpNcWhoT3pRekQ0OE5ZRUFXcEx3bTloYWNNWmhj?=
 =?utf-8?B?dW5zcGdqZytGSS9yZEdGbHUwWVRlM3NNR3I5d2laL05FOUk4ajRKaysrM3Nw?=
 =?utf-8?B?RWt4bUUxVHNUaUZUTVlGMlVYVCs0czZuRnF4bWdDRGRnT2t3L0ZTOUlyRDRX?=
 =?utf-8?B?MHRYVTc3dndjb0RBNzd6MVdTSldjTlpGdC9jVnJROEMxNW82cExOVVN4ODdF?=
 =?utf-8?B?SmdxVVJRMGJSL2JFNTdVK3duTSsxRisrTGJCQW5GeXR6dDBycWxCUEVYTEpM?=
 =?utf-8?B?R1RqMTlFeEZPSSt0Z2lZa0hmc3ZXS3lJNzNVNFprWjF0SnA4QlplWFBPb3dV?=
 =?utf-8?B?cFlIRXIwR3ltQksvS1RNYTdydTZoZEVnV3JwaXZSVUVoOWJ5amZWSFpidUQr?=
 =?utf-8?B?QmRNaVRNeVA1S2x6aDhrNjRyU0ttaWsxbGVSbGlyYytuTU9PbjBEeVdPajY3?=
 =?utf-8?B?NEdNVmlHNHJKQ2JKaWU1YTlsOXZzYm9JSFRVYWxYenpUd0xBbFN6SFJ5QzNB?=
 =?utf-8?B?UFN2MThNT05FOVc2NklQY0RHUVU1bk84WkpWSGJyTlJaQjV2MUViaHl5TDc3?=
 =?utf-8?B?bTFRd3NmV3M5ZE1rVDB4ZGdtSVBReHhpRmgxMVpHVGIrSFQ4dHhMUGY3Y3JH?=
 =?utf-8?B?Mnh2TDNxc2VxckRyQnVmRjVsUUl3MzFtL1pOMlhlb0lpSUdFRXlGaS95dzBp?=
 =?utf-8?B?L0hTTXZ0ZFowZkFaMlFHUXozSmFJOG82akJoNkhLZTQxN3dYQVZlekxaWW0y?=
 =?utf-8?B?dVVmazVkQi9OaUhzVG1IUXRqU2VNY09nTnNXWHBrYjNlTFJJbWw5a0J0RGI5?=
 =?utf-8?B?MTdTb2FSWFFsWDREK08yeEpqRTBMWFpqNHEvaXdDZEFkV2dqaGpJUW9WVmNU?=
 =?utf-8?B?QTIwdllZNWpOclgxUm1XRitmbEZVZkVibUtzT0N5Q1A0a2p1ZUozemhwVWtW?=
 =?utf-8?B?dEJrNlQ3NmlxNWRpVHJpY0FiOHYrRVU1UnB0eFA2ZXpGZWpjREJTZ25LT2lV?=
 =?utf-8?B?WVhZK3d2c0pYemw5WVl1a00yZGc2a2d1R3QwZjVHbnRQUXhKR0JpNEJxTzBX?=
 =?utf-8?B?SVQ3NXRKVXlHc3NVY2JNQiswLzN6SzRJbWtMc041c1g3OVdFUnVjRW5INUta?=
 =?utf-8?B?a1pldG40QUdDVWdtVDBNNDI0b2VNNzI5VUpBcWVpZWdLei9aT3pRTFhVZjZh?=
 =?utf-8?B?dGtLNzlEVE5WbVpKa001TGhVMUNXVFJ5Q3NVa0tmWGFvano5Z2QwS0pmNjJv?=
 =?utf-8?B?aHBXc25zQzZ0RVVMQklxN1BvWWg5bklkWEV3eWxGZ0M2d2F5dE9tcFVaeXBJ?=
 =?utf-8?B?c1N2WXlqSVN4dCsvUTNVRjAyYlo1bGV3Y0xKb3d5amgvMFRHbHFWS1dtTXJh?=
 =?utf-8?B?OGcxTXdIemtzSlRBNFRhcDdySTVqc3IyVWJ5TWd6YTR0MUVQM0lnL01pQ0ZJ?=
 =?utf-8?B?RDdZbTNma0Fka2k0amg3WnE2R0VWQk5xdFk1Q2ZqSWhuV1M5SDdhTjdaTjFF?=
 =?utf-8?B?S2dJSmRweGtRSkFSbVUzbTVFaEdtV1l6ajE2OWUvL1VUM0UyNlE1VGhWNk03?=
 =?utf-8?B?RzdzMkRHSXh3WGhJVzBQSXp1VlZKVDR4SWhRUkhzTnlKMEVxSTBGZk5iVGsy?=
 =?utf-8?B?M1lHQlRhZ3FNTGNTZVlaVWxiTE16T2lZRm9ZM0pIb04ySXdKd0xudHlaaHRE?=
 =?utf-8?B?YUNaVDF0N1VSY200VlZYdFJQL0w5My9pUnNYcWlJdEJCdDZSQllIT0wwOS96?=
 =?utf-8?B?ZXVDR1d3WmNMaVlDMFZ5eW5YbEc4aGpYdThDZjkwRWpXUU1JenRSZkJwaG9Y?=
 =?utf-8?B?RURoWndSdlRaSlljTmlxazJ6d2lZdURwdHc0WUwrQWM5a1pEbzU2OW5qeEdK?=
 =?utf-8?B?NHR6cGhzaVVCb0ZpK2pBS0w4Rk96U1NqMy9USE5ERUFTZSszaHpKbWVER2hj?=
 =?utf-8?B?TFVNNXNKNW5MSXdmM2s4TVJqbmgzUnNWbWpOanhJZHlwV0V0V2h2MEYwVVlM?=
 =?utf-8?B?RTg3R2Zyb3JIN21IaVJ2U2tvSzdlQW1LVzVCUFJrMGNMdXlwdWsxRjdiMkJK?=
 =?utf-8?B?VFRDQVBlLzBVTjVyaEtaMDFUOFhUdXp2eTg4ZXRjcVdYMm9RNWFLZUs0c2k2?=
 =?utf-8?Q?uOrQXa/bUTbvW2Uo7kef/EP/uJHjt/iFG98VxeTMZM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4649913DC329B5499954556FE6EF4071@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QDjg1KZAG8ZM3flokIPj+rldc9qXufcz2e6toE4ImCaK5uTDDSx/qGO4XbMdGccsLFHBsbhnWZcsFV10c/UlcjlXCiFiLU/mmZJ5s+9+YrWeKq5LTQ2SCeMOlfO3Vv+8umsuBRdCg9OOIae84W9QsLfnXfh8q+FNAuXVo3noQXHe9LpgSpyC31S+XJAT7RbKDkp3pyGzDmUsA7stcWv7etjx+ykyqbop+bai80jfxGUO29xbsW+10UonnB3ByOpGjKWLyWwUL2Ud72XURSuw8TJMfUesY1ighgxQr8VdanaePxp4i5RdXV1EGO0GqitHbwNpvmYrNxDCy18d5cpC919hvk8KtoTlVPR00gq3xZ6ToyMwUeVCFsdPoCDiDMbLeY3DN8pnnclIcPF8bt8CHipZlZIxCyWQrcd8egyGzETsrIc0l2/N6+H4Z29y4VrjTW7ywJHBObx5ezbPfVIVjQkNKQZkQ0eNySkujYzRINQ7n0suXQrCM5Z9MekgcTe7HxXWSPgDngXR3AccXwE+i5VR9fCSHezpmSzoG1Ffa/zgGYzPudFAvK2kaGU5QCgkzb0m5f3cyc6/KQ76/5WtrQV17N+KEABu3+R2iACwDwv5XpfEn3oSmk3w1V65sBvBAiPs0j81hslSh6Rq87RINKRH7q4vSiJgkdAI49xJgpRQCM41WYLhD0jEhNdXuAopH/aaiSW56JthKpdYUFC9Pc7dWhdPnvPXO7NLwuf18oJsznbVWrV5OXYLvx0YXqq4VEvnhFzNiPWiisK2Uz6BBKFFbBggRcezl7p7z+Gy9Eg72cr05vZ/GUAwmZL0uWBrfbZdskXi/l+Jhc+9CvHNIgskImDpb+FEHOElIFTXblDtBpEMt1aqwM1epB5L7wnT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9164c9-3dba-4513-2d0c-08dacb945de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 07:45:31.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MT24wRVhUN4UelVJpebhKVBTqumUSyYu0mHb9TmG4sr2tmKoWquyV0ukiYB1EW76uXwCXJ/Hm5i15EJzJHLC5Wmi1Xl+qTYMQBjfQPEa014=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4116
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

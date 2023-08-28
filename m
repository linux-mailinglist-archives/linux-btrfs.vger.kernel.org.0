Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA878AE39
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjH1K6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 06:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjH1K5H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 06:57:07 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC30C5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 03:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693220222; x=1724756222;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=cOCeuz3NLrtpP/GiE3iCqWmuDe7AcgMDAd6yZGAMB1dO5e4YeIs6R96B
   4baERJR/whrIBH8x8iwvdOALKYqHgfQx1GpC+PjAhX1Blm3sO4E/me3EV
   /j8997XErso9CYaSCCSfZv1XqohK7VxoIkdhrl0qavXDXdkWZxP0bYBW+
   Ek6bs9hAcHPNKAA/bA7vOsuZJVi1I4M2DM8sDJCEeqPHfvjrsYg7zJRYj
   maLReExtdOCn2ZHSrQwXdYOGj6nKOULf6kwauAFkDJuX1nqL1JL2MlU0Y
   fSIWeRJX7ANq30F2Fe+xw2PPFp1Rw2IOc5muFJT4/MB0Dqy92iqc19qlN
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688400000"; 
   d="scan'208";a="347561267"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 18:57:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdByDIdg/G1wKtRLIEa970LK++vo6wOU/rEn0sZYvQwL51s7LDlcyFOrFKAhNKuq17ujEC7yY6QPdFnpZxegTWj0rjN0U9DdX2cn0aFM1Gew3HEcILT+Ohiwglt42lLU73DoEiYb5NDBHlWsx+45DeW+lTZseyJ8kpuapF0m+bjK9Lvr93o2b3cTwDt4cbyF1Tj04ylcvhFmslbAYjYUGVmyGQgL1bAXTAFS7VepW62sDTDsvjiERcW0Dfuk8/lKDhWlXXtUoYCPntU3ZZ1W3VRcjxRmH13fOJVqUqPdx03knnVskKnYsZemIju0V2Fid/4yRf5R0ady9TiKc/BXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=H+L01EvK2UCGzsWJQsFI1D7S/mqwd4fACwmXVPja9+q6xfYuva252Ab1O9ffRwwd+mvNjoR/KH+fPaHwmMk31KCS0OzuRRuRcbBb7dgNRQdX4m4V2SGsZyoIbO42hzgWMOAyQeoWEMlGISy9QiOcl6pZu7OdajAripJGaeCGNyFsPYl0uKn27pGsL+rBqOriooO/LzRIoqu9d1ZkcfE4uKscP1Xi/yC+w+fbUOV0xJIFm0zTBVCxkbvc0zrwsVOIKz+YZI17ZZasVPlCTg+uS1C3zs84i+HLg91JP4CI4S50xdfzWkbIn2RfmeJpukdP0gvbQxW1XogIJX8TTDTC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bdi6nORo1S9YWJAm0DPEF65LCdIDEw4jRolJy5wtSNZqzrcsU1SpsArUCuMn4aStnRRakfumMzVpmE7oIVmdaqMFT59GCQJwDnDOymhx6w0s3sgQtkbskGwizrWhAQmgWcoyVfJ1q29MdjV7G6s90BTzIM0w2fMl4Arctpj+A1w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6649.namprd04.prod.outlook.com (2603:10b6:5:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17; Mon, 28 Aug
 2023 10:56:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 10:56:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 01/11] btrfs: move btrfs_crc32c_final into
 free-space-cache.c
Thread-Topic: [PATCH 01/11] btrfs: move btrfs_crc32c_final into
 free-space-cache.c
Thread-Index: AQHZ1cj5onnXoKVktE6Ka/YlxQzkt6//kSgA
Date:   Mon, 28 Aug 2023 10:56:59 +0000
Message-ID: <33fc6092-c303-49a2-83ef-04002ee93a0f@wdc.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
 <c86c72428b7356d2a983d6943818bd9c1c40e1fb.1692798556.git.josef@toxicpanda.com>
In-Reply-To: <c86c72428b7356d2a983d6943818bd9c1c40e1fb.1692798556.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6649:EE_
x-ms-office365-filtering-correlation-id: d81b2369-c87f-4a0f-86d7-08dba7b580d9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lOOSnb2UPCw1vb7Trn0znt3M8bq6PwDpq8K4UoeUFl1yDvSX7IPfnKM/xey/0S3l5l7DdxQ1l0jmmcAJ3pBGD34CMTwTwHsJQlAJKCREERplCKPcdVC+EU+EeuegBx4dvzVOVqaruqVjINUwLCIfA1m2TzjjsdMhj/+Euo79pnnQLug3I2FEhGVFc7Vk8/07kt5Nab/1Es1znDBi3BzWsHzpVQCUMoGrGS5Lnh0Oks7ZkQcNuQ1SDIaRlZ+YNDP9XyBORG9/qDHVUOq+Ahl3xIvYyFYAmJf3/MRF4owfK8SztlqmIEtFFxkUFIhWvWvH6Sztd/u6lii7ShhJ4FG0JNsuIff5jUtgLRA7lpoJTrkL/kU6ayK4qLbFvmZuFWp//V14mtbhForkNd6Gy3qvDPLMiTcUqEXC4L7fKPK4ACrXGrKXbN8QjvP/N7ZQ6MYRnNwQkus56MXGhnsl9yurFXlv9Q4xJ/gNYAvGAiThMloG0nqQPVpxIuRNaAcxXcoS5kEJUDVpTdvadk/YiCGmZ1F2wIMCToOlgvGtX/p15JiP57UY9zlm8vFHtSuFda99hxJw8d2pgZTnNngACLdvkabF4DLO7yJGcRttzEJmS9RDtj9s0v+bGiW1Jou+vHEBfjQkjBg6oUheotqULs3+OTs2j6NYy+1npI0SvH2ECvmVvi/RlHw9ee38MBy3EqvM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(71200400001)(6506007)(6486002)(86362001)(19618925003)(31696002)(26005)(36756003)(2616005)(4270600006)(6512007)(558084003)(38070700005)(316002)(5660300002)(110136005)(76116006)(91956017)(66946007)(66556008)(38100700002)(64756008)(66446008)(66476007)(41300700001)(31686004)(2906002)(122000001)(82960400001)(478600001)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnRuSEQ0d3JyazJzNUFtdG5xa1pZRTZBak5Ybmx4Vi9lb1MyMCtGVEpVaTJZ?=
 =?utf-8?B?bjNPSHJ6bTBsWStSU2tPL0JJTmQzNlNXSU9Ta2ZuWnJzeG5pSUY5WVAwSjRM?=
 =?utf-8?B?dXg1Zm1ES05aZ3l1dXRVTDFmUXpVUE01K21saWF0elJOR2dyV3pYQXdkWkpI?=
 =?utf-8?B?OGZ4UytOK1FvcUZ5RjVyRi84Nm52dXJONEFaS2ZrMEFJbGFDSzNGdzNlVG5j?=
 =?utf-8?B?cjN4d2p1dVY1MStRQTd0V0tRYVo3bU52bVM3TXEzNDJjaVFtcE9QTFFCMmJY?=
 =?utf-8?B?dmtvTU96eDk4SXorbDF5MlgxS1V4bXI2YWwxbzM0dFRoMnpIZjRuNWRYV0xU?=
 =?utf-8?B?QnBtTVo4M2gxb3hMWUl4aVdlYTNINlBZS3FxeUUrWkhsSjJ6WFFDcTZLc0Y5?=
 =?utf-8?B?ZmJJUXlFV0RVWDJLdHhKL290R1dVRTdkOTdVejc5b2JxM3RoT0hxY1hrNHFJ?=
 =?utf-8?B?M3FBemlOa2JQZmtNK1l6UGJDYTRsZ0R1c042Q0s5MFdGc1RzbUorcllCNnZZ?=
 =?utf-8?B?NVRnLytNQmZ4YVo1ZENzMk5DVkFRUUpYUHJjbjhwaWdpM0pqb2k5a1VVMjBR?=
 =?utf-8?B?MXJxcTdBdkUrL0tKdGMwK3FXek55eUJEUDIvS05oSk8zUHd0ZWtSOXozWHlR?=
 =?utf-8?B?NEMwYVZrNDJWcHpIVC96ZC9BSm1rSnlDMGJyRm5BWVc3c2tqeFB1MUJzRFBk?=
 =?utf-8?B?VWJmdHJOSnQ0NVNNMG5wSlg3YjhEZStJSGFmV0F6N0JFTnJtdWNqZTVKQkk0?=
 =?utf-8?B?TlVjV2dhZklrR0MwRFNWZ1ltcG4wNFdjcHhqLzM5b0tiZTc5dzVvZnJIcmNn?=
 =?utf-8?B?THRMYkRLQkczWVg2MGtNMDBRMTY4MnlYbm9UcWxJYWZRWnlOalorVTQyd1l1?=
 =?utf-8?B?czlFQ2tERkJ2WGdKbXFvdi9JZVBob1JVbERiOEJsQWRlZGNOdHNuckxRVHc0?=
 =?utf-8?B?c1EwVGJGNE9IaWpVVk8za1BROEVQc2JGanRDbFEvSWoxTTNEUURldGlaWm90?=
 =?utf-8?B?cHFVY1J6eXVlRUFZL2J6VVJ5QTU2ZytiMTZJWUZRdXFHYUdIeHU2QnI5ZkVk?=
 =?utf-8?B?QzBEdTl2aGRVNER0eXE4cmVNbmRSbGlib2RsTHZ2MThQakx4c3pUT2VkaEha?=
 =?utf-8?B?OHFYVmY1TGczbS9OT3QvR2xJaExjOGc0VUg0ZnBxR2ZwOHEwQWwySzBleGM3?=
 =?utf-8?B?czlKYy9vRW5weTBkWkorbmVCSjlRc01PS2dsZTVlVGhLZEpiaHVnRzZZazlL?=
 =?utf-8?B?bmtBVEJMVWgvOGczbnZzSVpwc0tvWklkekpxMlZuYnhuM0dXeDJXRWRaSjlZ?=
 =?utf-8?B?MXZ5WXFqeGZ1NFc2czFrQjMvUEtlSTY1UDBsa0VwMWhKME1DMStETHJGM0JT?=
 =?utf-8?B?eHVWVVFzNVMyYllIRlF1YkpmL0pldy9HUG1ORGR0SEdHcnNvUGNkOVZIMUFT?=
 =?utf-8?B?dVhZaTZ1bkJieTZ4bXpJMmg4RjhCQUZGeWxEVWFxMkMvMVg1d2o0K3BOYTJn?=
 =?utf-8?B?eXp0VXpqWTZOcFpIOHhqMk1raytnckZuNDMvUHB1bFk1a1plTGVyQkxpMnNU?=
 =?utf-8?B?YTFLUE1hci9ITmNYOUp4VGU5UG9uU3lSUTVpcVk2OFAzTkY4bkcvWndqMnpi?=
 =?utf-8?B?K1F3QllTQytEUmlVQTI1WmljUlk5NXVWcXo0Sjl0dHBBOFBmTVVMdzhOK3lw?=
 =?utf-8?B?ZmNRU2pyN2FTUVJ5SzVBRnBHYXpWcGlHdEZzVGdUb1J6cFhFamlybU0vWk5m?=
 =?utf-8?B?Ti9Sb0lkTkVZQnF5SU4vTFpyYjBzN3FhalJML0NNU2VOUTRVNGEwZ093Zksz?=
 =?utf-8?B?WlNNbWZ0NXFmMDdZMjVmZ0JVamNweTU5a0ZyVkFYVG8xT3IyNW1ld0Q5Zith?=
 =?utf-8?B?dHBpYU1tS0pFK3E5cG5majlFQ09xSW9SWlRVaTdDQVBraE5zbzVud3d6RWVN?=
 =?utf-8?B?Y2Ivb3lGNml2TDZYTGkvaEpKSjdhWktERlZrN0N5ektaYzViUmV0K29oSWhI?=
 =?utf-8?B?UWU0b1RzcEZvcGUvZEMzRlRRTzV6dU1OM00xdkZXcHZBTHhJTW96ZzI2UFIr?=
 =?utf-8?B?M2VCSWJzWmVVUzlMbHg4S3lzdEZQUFEycTdiU1pOUXIzcmUxSU1HRnlaZXQ0?=
 =?utf-8?B?WG9QQW41dXl5Zm1EcWNYU2RRZFYwdGJ3VnZXRlVMODRZTW5TbUl2TEhmQjdm?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDB69F4E893B28459750667DD2514EB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pS8uD0y5IEElHrMhCuFgkPaw4crr21EoFZ/p/kw0kC27dm2OVMd9bSUNNYXp3Q304U4tsfUuGBp7kWn1JThglpUcCNMgscrHr8iDJqNTHugugDnIeQANuqnJ9cyx7/NwxcWhxeZwT2SXdck+IC4LoF4MqmSqo4Q2Lr8Twu7fo4gie75v3kiBN0/RuH4jVFDX0dCmB7OELE/ZzSZ5ihOJG5Cnod8C1ZlEYk//M2EKLbIfSVcMq7iZlFnN+vpMoKdvmvzSj2kzFGWDyVX2fktYQawCQeAwHapNfzjJaaQP0N6myn+E9Ga+PMI+KXzE7zq6RPxaTgUWVD1Q9mC8T7CxxPI/xuEKRVpMLYgMmGyqlk4agkS2kQECU434TjlQPUNF55DT5P84/KbvyKDZCbiKaFnOAoCTSkspICVEdcgWCHyfTIdm6mvJLP/mTm3iPYb9fPG0YOnIYBxRFp9cfsivxUUHPgebegsW46WteFJury95vd3KGNY00T3Ns8MsgqhVgAdf3JvOjR8s7b0oeiJoR6NuO8ygPfz1glxGPCnd15NPNcEwG1XdkBhJHxAz0lWB06gwgC1qA1Ql3DzLgD5/aNUgaNS2SO2PZj0LUQ8kHXtu98OKG2WMgZRIgtVSwPlk80IaiJpD1bmaGNmNHoE13ovVQKQltZkKgOJpOZDfAO+y/606EChmQqApModyE2MbS/I1AZYAE0qH3rn5ZdouY2VpecJMXS2XfU3XABmj9p0T7z2a2+uISDEWmoQWjO36R+VikvgtFkJcPkwQq+xTnCNZL9xTu/TagtdCRbCNtrEAdS5n+q3CX1Dc40qHlzy7VKe6RH4gAcsIwBzTZq/naA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81b2369-c87f-4a0f-86d7-08dba7b580d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 10:56:59.5435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8HICQrTfcoegnQ326V2Np9k6hYL8s5fNji0Lg8enM6kui66p9cOyDvt143kKXRM/GDhyQSTCNzWpxChipHXllJMsuLd48RByjz+StpJqnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6649
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

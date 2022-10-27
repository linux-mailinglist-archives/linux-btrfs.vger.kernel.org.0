Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEC60F0A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 08:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiJ0Gyi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 02:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiJ0Gyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 02:54:35 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66CF73
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666853668; x=1698389668;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Y9KwRM6IyDXO5JtwsIdVar8SNB01AKx3LHh2qySJKO0ki2lpYYq/Wp50
   Wu4AOVAAZnJlardAOSKhu9ipOFXm6zqvU0C/K6ydqYOti95lwvEVfjtFh
   FR3Mu2VxD7QiR2yDxOtc+CbxeiD6zrK9CqTrDoUNbXhEaKQeX/GuIMyso
   4cpOwmnzKvKJTv9f/Y7clJ+pl8ZWD2LLIvPWzs8ic/6CZQ002WtBOlzF4
   nWoVHtLpHE4O6APHLqJo2R6s5hXaw/vfk9zOFgiQ8ifxuabv9kmBL63Q7
   ErhskEzAdQvy/qr3Wso/VRtmGdDlPfGezCaST0tREMJNCCo4D98tN/ul9
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="326957898"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 14:54:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+RjhCzOusCIUaOuMiTKOZusJw08HUw9KdjcvuIK/OPXQlwDZAdTaDzmhlc+D4eqvKlr7sUj6FONV9Gk1pSPrWB7S1YhUl4IbjBWZKvAQG1UdBIYpftzHDt+CjwICLjlfz7s1xx9QF68nRBE295qojh69Xw4JDx0LZ3J+HJoz6bTVEIGSmgadmDMyRCNT93hjg6PKQJ5poedMZNhyNxqXO+EOdb0TWtMVb4738dsE6qCeijR9e1S6Wv5dV0z7iVWoMCJNU9TAI1CIZW4YDG5JMtH/lvDUAGFA/BNN7y10G4Wa/C0wsgFR6+LybfOPFkc3i/H2OIz8kXZGlwx9cBE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Lr50X/0kOk80EfmI5PJRJpIdaXaJvwpt2+2LgLz6FHp1TPpEa5ob113ZJ0hDPfj8nVeFmtjCdXFemvrKSxYNIeSZE7z0ZoJgk8QOeavfe/CboM3bq7ERGKS5F/Hlh/evdCu5bj5u7lq8cTWB7PvRtRmmce9f7VckFcggYBaVG0zxfTlxQ1sTKJyKkM4mme882z0N1CSBrqiaC5aYd2xaw2EZ8cWPJ9j3gcmgt27Kk6iGlIpt4ovAokc4sqptAyeBgKKDGjCcVxKrhN0WYbmEEQYb5HsbhLvMAyXNz3KNTmWqtWRFYn7zFbjudzBRhRIMkCkRS2To87WqCl2a2SbrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=rELC1rbbgTlE/ZzAG2NcCHG3a142oD5REjkZwMekPLUrzF8bewH2wGDVYO66uqjjAH4z+HhiVMlmNbatOOl6IGcoPcXj5Gbll9+s+61b/nz6Q0bK92I4a1YBtf4dvkOaeI/B/M0309+GvD0Hd5sB+tK5c9vn7xklcQnsBMaft6E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4667.namprd04.prod.outlook.com (2603:10b6:5:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 06:54:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 06:54:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 06/26] btrfs: move inode prototypes to btrfs_inode.h
Thread-Topic: [PATCH 06/26] btrfs: move inode prototypes to btrfs_inode.h
Thread-Index: AQHY6W7PWho8SdvVrUCmo10lbMIq6q4hzwGA
Date:   Thu, 27 Oct 2022 06:54:20 +0000
Message-ID: <2e262391-1ee1-d38d-8ef7-95706cffa3bc@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <7b658188a43153b53922a640c4c996fc552d93ba.1666811038.git.josef@toxicpanda.com>
In-Reply-To: <7b658188a43153b53922a640c4c996fc552d93ba.1666811038.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB4667:EE_
x-ms-office365-filtering-correlation-id: 5b2d0200-6f8c-4844-6910-08dab7e812ce
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y2u55htlZU/DpTdHsKiEcnF6tXBOuCB7xrOyg1V7d//exAD+79JzWKcSgi+e/3U/fH1jVEPrXA1+tKo69Mfom7gRo5oXIyyTGzruEtmYEL4BXR9vFPqsBjyPeoS9P1o+2jK+XICqvE0izxkEyt9vv0OuzQdLpCq6dzstRD0YmUM5FntwGw7mPVVqRPqarhhjzKuq/RzmB/shKMVjHTYb5ilPFKTiVySiwf6eqQV44vSgAAcMmPRWrm1K21qpUYzjDd1Mc9Rxa2rwygkzWoiDQco05aRArix77IHoxR7OHwirkQBND5sS1tfk1G1M2duAGdba8etCYlhVa0dUtJpB9gZ4c70dPfRIPmK/oaritmUFTzvrVAqBA1x8sU1Q0XlhnUTqtb2g4dnTCVVMKFLDIspjYuHR6MAWMWuifXtEmtrTLXAOIEGDWFJx/9YKz50hqH50XWpGsohj4V/sveMpduP4/4XQDMe9jwL0hU65aYZmXqWrx2NgTDFGj7uFwrP29DL5kcncY9mPBjzbORtNcQyF2Zu9a+KmbHm4lz0DXSkMGO7pJMo3MNvLtFC569uDK/ENTlKMO2sE6mT1R3oetM37aRPb9cbziXGa3rkFzOx/2pIXzYXDFjzPPd+bBF4kg5acTcCM73EZVLuKEJoVXsOj25qLZ0bEZcPSjrt/JkrfJY7swC6+M1IMvHK4EBoz4xi4iiRAjXEhpR6yGbq0jDX1frnUI/YeRw1ScFCaMyOEBZzJ2gIwmQWOPLnWuURHfYioQ4O2DGEtP+DR+BL3U0I7N7t2Aykl4M1TjJWG26wVnmjhrz/wVNWRG6fRQoATeYgH/Dm0urevgNfJxj2tvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(36756003)(122000001)(82960400001)(86362001)(66446008)(558084003)(64756008)(41300700001)(478600001)(6486002)(38070700005)(186003)(19618925003)(2616005)(2906002)(31686004)(38100700002)(66946007)(66556008)(91956017)(26005)(316002)(8936002)(8676002)(4270600006)(71200400001)(31696002)(6506007)(5660300002)(76116006)(66476007)(6512007)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THhiOExONkVqc0pMMUs1L0VXZEJBZVh6eWFZQU5rcktISjhkbnorbTRlUkk0?=
 =?utf-8?B?RjBiR1dYeXBBVDRVNTZuZUppTmZzMThiNDYwVkZRQ083bFgyR2ZDbSt5NU1B?=
 =?utf-8?B?TVhJemgyYnZqT1R3T2tSRms5YkJYbXN5bEhnaTA5bTdWemJxN2Nwem5mMFBw?=
 =?utf-8?B?aDh4dE1oTmNRaldkdUVGemVTSTVTdzJLOGhoeG1YckNPbzRpaGZYK2Z3cER2?=
 =?utf-8?B?RXd2SEJSSzJmZ0hTWDlxZE9CbFVTR2RibU1URzZwcEhpUDYvRjF4MVV6QUJV?=
 =?utf-8?B?Rm9HTVFWWVVveHNtMWlqWlZWbURGOXpJTGt4WEZsTEEzOXpLNzg0dUJqTjR6?=
 =?utf-8?B?V0NNd21NZWphV1I2Q3JoYzdBeURvR2hFT1BQdGRTYnFXTG13SHpiaGdLR3VG?=
 =?utf-8?B?RFlCdWJ4YjlRVjUwVE1nNVVLV1BlL0IyZFNINGlrZmovK2ZjOHAwOVNHclhT?=
 =?utf-8?B?b3gvYTBoTk56Vy90d3NLTzlBNlU1VHBkekNjT09oWjhxMURGUVhCY0hKKzYw?=
 =?utf-8?B?TWtvWG9tWGJzOGRhamxWLzZoUEkxT3J2OVR5WjN4OWo4NWZXbm5ldjEwRkVL?=
 =?utf-8?B?Wk5BWWNBdThPbFZoUjBuNHFRRXkvdTFMSUc0eUo4SWgrWHkyZTJrQWYvU0R0?=
 =?utf-8?B?aCsvdVF3cnBBNFQvWDIzblY5MXA5cC95QkFqeEI3VW8va3ZRMWpPdTRoTVM5?=
 =?utf-8?B?bzk2Z0xGcDlxV3BjeHFKejcxeklHS0d4ZmVlalpEem1RQmJhUlp1TEQ3c2RZ?=
 =?utf-8?B?K1J2OW1QelpvL2V3TzFuTXdjazZZZEFmSFJPcnRnTERZbUVDcWQ5UWlMS09D?=
 =?utf-8?B?RExZT1JmL0k5eTIrbXBKQVB2UTZwY2tOb0haeXRNUDFpTytHbCtaVnlwMXZT?=
 =?utf-8?B?QlFZTW1JbEFURi9SVitncGVrZVhEWVpDTFVvdzhTSUQvRW0zZWQvTjhFNVVU?=
 =?utf-8?B?dnQzWFVRTmNvc3hHUDljNE9SSTR2eGNDc0VsTnFtR2lRcG1CR3N5ckl1bGxj?=
 =?utf-8?B?Z0FQd3FoM3l1MlR2dEJmQ3Q2NXU0L1BvampFbFdPVVdGZEVaQytRYkhjUG9B?=
 =?utf-8?B?N0diVHdwTlBUYi83cDJJbWdKTWNNVGE0REExV1J4S0d0SWx6OVMwbTdNaTRo?=
 =?utf-8?B?MS9HcEFXaEVlQ09XckE4WjhIQ3NhMm9PVDlCNTdyaExmbERpSnRmMkt6ZnlV?=
 =?utf-8?B?bytJNnVhaVI1U29qSFlwK1k4Rk84L045blNOV2Ixd0UrTVVDakpDN29SZGdV?=
 =?utf-8?B?K3huWUxJRnZ0YWxYK0xOYUVDV1VRZ0duWkhqYWRjNUREM1NsZ1FTNUhnVThk?=
 =?utf-8?B?KzJXeDJIRVI0SExLNFBDWmlGM2JyMk5ncWhiWUpYdERTZVpHYnQ3MXowRjl3?=
 =?utf-8?B?aWpVekpaaFowQUtyeWU1K21qYXBkeVYrSWlrQWpDenZrd3gyaEcwR0NHZWVI?=
 =?utf-8?B?RzRBTS94Nk90YlZRTnkrMTJvRW43bHFVZkpOR2dzamtWenVzV0k3dmtKY25x?=
 =?utf-8?B?UmlXQlJUMzhSRnB6M3hRbWxmdGp1MVV6VGkxZW55KzRmbEFzbkp2YUpYTW13?=
 =?utf-8?B?bTZGRUVqczJDTmN2b2dWblBSUXlNMks2ZG5VWVhmNGl2aFlqZ3dEM1d6SExp?=
 =?utf-8?B?VFdXejMxbmJjblZhSHMyTzdlYjRpOWc2dExOSmh6dWd2ekdvdlZmWkxkK20x?=
 =?utf-8?B?a1JBd0NjR2lIY3pQa1BSNzg2b1FBMkJUTUVyVEdsd3ZwaUxucnlQcVEwbTJw?=
 =?utf-8?B?TWdhdUNrdE1paXM5dWNoVWJVbE12eDRua3J4a0hZbldDRHVUdU45N2U4Q1Bw?=
 =?utf-8?B?WGdCck0yNHY5eDgxU1dJTTVCdmVjSUdZZnJOMXRKeXJhZHhqWmJhcUdoTEl3?=
 =?utf-8?B?RVNnZGQ0anRtWmtacjdaSVBXc3RpdGo3SEFmZDVkaE5aa0lmdW00bDc3Wk00?=
 =?utf-8?B?NHNvaHRkblN5MDZqS2NsSzVRWXQwWHNmQmFUblFiek9LMHRtL0J4eGM2TEIz?=
 =?utf-8?B?THc5TXF2aFl6TVk0ZjR0WHZkVkovRWxxRmZKaXFnZWFhalgwSE5kRktsRHI3?=
 =?utf-8?B?OS9MckxBTURXTjJseEY1aXc5TjJBNEh4QUpDcWFsTTZyTEFsZXNuUGpFeGJN?=
 =?utf-8?B?ZTRzbHg5NGVlekcwQTlGdjZ1aDhkKzZyM0V4SlBnd2piMEJDSnBpWE9iZ05U?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD5A9F0E8249564389063DB7AC8C8A35@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2d0200-6f8c-4844-6910-08dab7e812ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 06:54:20.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGutWcbLSmK/V9HZ7fTs4LP6DvVg5xaLT0gNOesNzf6RUu9CLBJaihHeTTVvwExIltMUtwSCWEKSw1AEWG8jpUATIT+CkOgvVVL2fz3jtx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4667
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

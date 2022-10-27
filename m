Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5382560F4BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiJ0KS2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiJ0KSZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:18:25 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BD5F6838
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666865903; x=1698401903;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=B1yse/ZSybdzxu9Mgr8lfiMCqDC75fY/HTlqpENqacgopmmaT3oPY0cf
   j3/3iHG7vkbe0qZDMwBdZz+CnHTJOZR61IIkJYonH0BShZq2Kwq0E6Hgm
   lo4xN+nbQYh0Z5P5yMvSdNt9l6ciEr6bjen+3SvKx9TGu2TsaARgFqapa
   3bbyuVC6E78uOm3fFGc4KmMWiA/+LGY9CQGCE+BOzcOHH5m0tGje9lK6n
   J4ijCawHle2ocrv+q38XZlrlF7IOlS92poeOAS7BpNzgY+D6RB0Tne3+i
   e/6W/2H0V1XjyrpxsU3CSMDehVTGGyPgaeDwBoHcUBDXXf+XO7nMcXRD/
   w==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="326971808"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:18:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7qEtd0XdzXnHK4DROA4p0ZTE1oGeUwlFXZB2x4WXbelZG0I3jGZWrGO9SnX1uuka2n19lHF8ytxL71YndlEenr1N156N4kM7iY8yV6V5luy5A7pWcYDJTcRGi5PqNWtR6y407+EpR2uJs9ZKUXtUqX8k4lsEMx4vhGeWEcHH89FY0SGPR0oXgOdLG1e2X04HH7X/DkrKuyVcXVUt4wygJuAmhlFSwh4lrBYhHgza1GfygE/MeC5WHQr1gGSUKzg7T9K5mHrmX9ynO9qpqN3BqblZ58yJpP6usLQmtDWpKBsuz6hVnhny52N1G6nKXKjK1dIIK88aOI60pbWxjshVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=J7LtAYtt6+ekNZqSSmWjVH2767AMCgWJFdkwEGH2esPn/i5/xcvBhcBlnQMC3BA0WtxxtgZm5VF2kfIHnkk0L229GJHqfrFwRd/B5XKoHjGMrMhgfaMZdN6L/IHFw0FZqBdCbu3SLSBbi8Sq8aGkXz6HZZ8JDvWnPgKdmJcaG2k1UaP5gnJX9rOYSIloSBWV4t1f2I0CaW4tibT4v0RV3V2fLaUT6XAE+C+cnYdew9/BghXTSucyfgoUENjvSQRlOgT6mlBgL4eCZ4+FBk/CztynSTVI9MAJBW6IoX9idamUHMU79Vm0hu0gqLnvipr/b9U2ZKvbddBLEw40HCtprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=iHLBNGhJdJ5rIjKsc29MyBonCAwZ1wSrceJ0Ccs0jFcq9mDKZXDQ1Kkvroz6sU2U3R+6LS2EPTbgOrzUnzKiyMiAKfsv0SyhaXrJaa+FN4CcfD+0T3SG0KutDEFn4X01NdTGkEeuEn7+BnLrVCOfGS8MuijtUjRAfw5WWGqy674=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7993.namprd04.prod.outlook.com (2603:10b6:208:344::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:18:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:18:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 19/26] btrfs: move relocation prototypes into relocation.h
Thread-Topic: [PATCH 19/26] btrfs: move relocation prototypes into
 relocation.h
Thread-Index: AQHY6W7m3SXUsXeqeU6yY9yFBN8oWa4iCACA
Date:   Thu, 27 Oct 2022 10:18:20 +0000
Message-ID: <17fce9cf-5713-1d5c-00a3-a4b9e38daa31@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <9fad37625a4062c100ecfc78fe27bfac1aa1515e.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <9fad37625a4062c100ecfc78fe27bfac1aa1515e.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7993:EE_
x-ms-office365-filtering-correlation-id: 450affbc-6fe8-4674-a4ed-08dab804926f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GfP1TdzF5Vk7apUkTDm4v2fTX8BMf8RsNBG4ENM/toPAzk79p5mjEYTyMSALIHXMcY9KbfyVUvlOShO/qxcCP73ilBcsXFOwdE4efsqWMJFxEpReAff96e341juuefgTQNBwq6XnkxgvUwzllFdC3fsnAyDrs8r1KUKyYP0fTADjASLjkiIqVe+AzMzyhGw+b781EggeaFmVTp94UdLjyaWK2wPJ2hzna9stJhe5gYri6Efa4BAkR5Hm4TFpmeD+HCyi4qgdlohpQjmu8RKhzATiU6umFtWSzk2vmWf8//XSd001Q6ZggZpfye5T9lj8Uenj3PWtvUxCHIlT2FZTmD1i2tkhvCOflVyCpjY0BLSDxe66vfR6iRpZH4YMLPIkWZbRlwwIli6FeE6Z8gVzjEWWXXkbamz0cwMSOKL2RKJgHcZJYFxnW09IkRS+8kpFvc3CEK6pBORqYhd31izQsTXFDWPZ/3MbLBUY0h5lmT9JUgLzI705QBgmIsKZTNRy8L9EjESdWmsiHVtEY3UIRkS7u6yzXi0zmIJE/bIo39OLgfx7xqBIWtGH7wXTF2sF5SgqjMjL0F4UCKqE+nF/fo277hRfBZHPecjJu9xQxUb/ziw/RZZMLBog6OlWS8n94vJbZ252m4rH88gvFP75t0IdOJTGQOzI7/uk6tnhxuwMudX1JXrLgiWxdtwuXn1ijSneTaT00sp1HxayfFlusEl6VcRrOd4KSpuwR1vAHLIka9mKhUUgv5h0/WOVpGu4iBIbWEoG8KRgWqpbIQWr8K+ytv9lf37XbtfoT+7cN/PKbzw2zO331iHQgy8RoVVZFlykBHKZhilUVPOFKtRew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(2906002)(4270600006)(19618925003)(6512007)(26005)(186003)(71200400001)(36756003)(6486002)(2616005)(478600001)(82960400001)(6506007)(110136005)(41300700001)(38070700005)(86362001)(8936002)(316002)(31696002)(66476007)(66556008)(64756008)(91956017)(66946007)(8676002)(66446008)(558084003)(76116006)(31686004)(122000001)(38100700002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWk4a1Z1am9odmZRODhKR1NJWFNVb3lsU09PMWRXN0lmbXc5S2twTEk5UGlS?=
 =?utf-8?B?VGtUbzJyZXI4djloeGdoUmpHd2hSV2REa2hoTk1OSWcxNFVUcHRuNjdNYmY1?=
 =?utf-8?B?VVhUdWw0YWk3SGNYa3JycnUrYzNaUkF4Wi9jUlFRZC8vRm5ZOGpBekdOemFu?=
 =?utf-8?B?MTE4d0F2Mk1BTVhKeVBpMXBXbXdya2FiRFR3TXU1OXNnRFF0a0dmQ3FKNnFa?=
 =?utf-8?B?SWYzZTNUdnJnaVEzMlFUK2hTRDVBRFhienl3Q04wQmY5cjJGWEcwck93UDFs?=
 =?utf-8?B?d3NzdDhiV0VnNUxoV2tqVWllL2IyWEVFellsVVRkYjkyYmZSMFZZZFFTd3ZO?=
 =?utf-8?B?ODl3TVBwK1hYUFBsS2hVUWdlQ0lGdEkyN2hWMER2RnVxa1pMZTRQdklsLy9v?=
 =?utf-8?B?VVlCalExeGMrbHNHMDM5WnQyZmlHalpoaFJJOGZTWW1qUUdKT0dnYVBmRHZa?=
 =?utf-8?B?VTF3OWJkQmthVXEwQUtoL1JMVXZRUWpIRlNYMmIzTjIrOTdTQzZoT0xlOFh5?=
 =?utf-8?B?K2Nlbi90YjBzQ3ltckhLdzQ5N3d3OFg4VHBvRWRHT1g0SFZIaWRXUk1GQnFU?=
 =?utf-8?B?ZlVJck1rN3NBNTQxTms0dzh2SE1sYUFwYXl2dXZpQmgyR3FORWxWMHZHMk4y?=
 =?utf-8?B?MW5KR3dsbHhYY0Q2MEdKWitLVWVFN0lXejlXWFhnNi9hbmQxVWQ3aDlIU0xy?=
 =?utf-8?B?aDdHMVFrVko0U2ZSRGxML2JGYkdOclBBTzNzcXJUMDV3V0drY1phZjlqaTBo?=
 =?utf-8?B?elQ2ditpZ2Y1SWVoN1VCL09nZmtxREF4bzhsTXZJMmlIMWhYNnFTZjI0MXpl?=
 =?utf-8?B?Rk0xTE1SbkljQWtkWU5jYjB6bE0vMm1Dd1lNdy9wU3JZQTZHcURWSUtoOWpi?=
 =?utf-8?B?N3RJdFBNWm43L21hcW1kV3c2MmlVaDkwczAvV2xsaGVpUG1pSGU1SXZrOC9W?=
 =?utf-8?B?WFBQVmtORUU2NUsyK1RmdmNzNEtobU43UlVmMW9WNENHRndhNERIMzk4NkhN?=
 =?utf-8?B?VUNaNVI4aFpJU2tWNE1aa0tTVkFkNVMwZHJZdHB1Wkh3WmdWZ1g3UGphQmFC?=
 =?utf-8?B?Wi9rUnFad2NqU0ZIY1d3VWdac2YxZVAwT20vZkNYSWpHVmJrajNGZUo0N1Fy?=
 =?utf-8?B?eGtSM3MwTWVBUnp2UXdtZE85L2pzTnZCK2ZZV1JQMlB5THpCdVNSdThpQXYv?=
 =?utf-8?B?Lzl3Wkt6YkdqZUhMZDRXTUlyUzVsK2hUSzlsd1pWWW0vOGdxOXpPSDZYWXJ2?=
 =?utf-8?B?bktGRnZLaENTN2M1anRadjNSM2x6bTVkcG1nNWUwOUxNdFVRMXV1S3FucS85?=
 =?utf-8?B?MmxJNExvTStCKzFNMXA4VGlGS0tVQVRPa25EV21kVE5mZDdOMGpna2dwallu?=
 =?utf-8?B?SGdIbHRFVXVkbllvV1dDVFV0Uzd5ZmFzTVVxTjRzTGg4SEg0Z0VESmxwUWpV?=
 =?utf-8?B?OVJZU0lha29jY2o2R2lwYmpMQnpDc2JaR1Z1aUk2MVlocVZEcDZwbktub3RN?=
 =?utf-8?B?WXVTUkVWZDJaRHRURFcrYW9kUnp1RjhYVmdIYWpsd0VsbjRERlFZbTduRGM1?=
 =?utf-8?B?TStxZXVjR1dFaG83ODZtMjk0ZC9jVm5kTUI2NkxpaE9qN00zQ1BLNmFQUTdm?=
 =?utf-8?B?amo0TURyWGF2MWhhMjVpbHdEem9KOW5ndVkxbGtwRWxwZlZsK3RvNGFSNDIx?=
 =?utf-8?B?dVZBVjdjdXFSbm9seS8zenZpeFhiSVlUaWVvZlRVZzhTTnRscmFYclh1aEJI?=
 =?utf-8?B?cWpIV2ExMjN1RHFYcTJha3lKbjhwQ2FUV3hnNngrYVZpT3VSblM4V3pmb0pO?=
 =?utf-8?B?QUsvRzY0OWhNS3FtUmN0TG9ZRDBMUW9yNWdxZ2pubEFTVFp2S3ovQ3BDZHBC?=
 =?utf-8?B?UWJabHpqVkpQcXA0bTRrb3N2RDZYb2FkTDBoM093cHJwVldJSExUMmNyOXU0?=
 =?utf-8?B?d1NNY1JKWHFrZmw0V0trME1kcWVNRTN4ZGttaHF3M3ZDMG1Rbm82Zi9ZMzJQ?=
 =?utf-8?B?Y3ArU2hKa0pNa2hxRThNWjMwVE1RYVUyZ0VvMUNER2x2dmFQUENBYVExKytm?=
 =?utf-8?B?YTlBSnB5TG1BeHZabjU5MG9FWjcwelB1MFFuWkpKb2R3c1hGL1VqSFBRajZv?=
 =?utf-8?B?eld6eVRidGIvQWw4aFlsOFNSV2ZFU01sem84SWN1R3NSeStoL0gwbHQ1RnVl?=
 =?utf-8?Q?Ll6vxuHq0WJaFkOfLdEOP+w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D831892536CFB49A3FEAC8E7A9A18DD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450affbc-6fe8-4674-a4ed-08dab804926f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:18:20.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdLr35Z3ea1JYXpDbuj+AfhpBdsno/2RJde1YLe806ExjrJ/Ra0WhJMmF1Z3r5HbKVl6DADsPHHw65oqI02fLc8ElF+oUZMb6hVCRlMgpzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7993
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

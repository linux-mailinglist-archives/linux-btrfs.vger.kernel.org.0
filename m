Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08975B9C86
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIOOFK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIOOFI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:05:08 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CF62AA5
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663250707; x=1694786707;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=paa2z0AUvMJAoU5ZTvqob3ZpXcEDOYybGt3o100hJyx+0/fjVJT2XXWr
   cVNLOZ7kEAQU2ysLV7ZUIVRB7cTDgx7hZJ/1FAvEyfvBl8lzGoatUoF47
   bFz2rchk5i+M1sw2CIrOmtr2BhCiRklcvj7vZN58g80EIlSvD30MowAXt
   gHDa/MADqRYoFUy4wuXGzWHCY19vEX9o7eKhTepTBZcPw72oAkf8NGSpI
   Hw1R4OhMfjs6SLpTI1gyyxfPVg9mNYkIPsueZig05iudJIeTLPM9wBI5C
   UEXKr8yJn3DuWLoOVvhfiErHY0zLWxgNIyr8GJ39/s1azBRlC0F/lfhGW
   w==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="315723651"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:05:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIZ5w1ccmfa0iE/4zhW8uJVrWUTZTlQHUy9ES9ouB/kBgOtdAQS03oOhbZPmTw4NNZ2fhLVDjCxHnnSH/A0Xfi/CR8mhZ9dOPO6SegiYbzInZJYDQ0OP1zpdSQ8TywZjWWo3M2832dU3nlnpXNYTyUhgg1D7yA2Qbyf8VBzmtFu1dZpfhA1IidPX2NqJe+LNSxlA7qSn78e7mjiCM2pHOsNpiS91OWwzPFq434u1UejH1ZzLtj7F80iH4HISWnowC0BxbBzw5uRwa8fyF0R1ctrTAB/4qBBZn51zHwClGfZk1Na3qu2Bqs6jQwL115IwsuL/RW/MMa4OT2lv8vbqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GUoDIPtuPwRaIbdFv96zgHubh2hHFphJntSbBO4a+JThxvG0vOucvIozv/jdu0VzZWreXn7s1eouD0VsOdA6zU/4Wng9eei8SQTvhpIyEMOZ2OW3TuPhCERYPHuAUytScWDl5DLatcnMaXngW7vXtCeh83i6TL56p+qBKQBTF2sLrhWv7XaW5d4esZtCvSoA+/cI3XKNshbd/ALCCCQVqwbG6kMHEQWfN/jsSpK7wnm7M+KW42Pi4b3TiOVvmcSiWVeH7UWOHplvh3fcoBVtkMBl212zgHopnVbfqFSjb0sivkLo7zFP+33Xx6J8Wu/U9/0bxWVWWt4FVexADgdjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mSGpC6bzEdCiRoXFFaOdjxF6dYVcrEyTWvore4ocwkFNe90J9PepkrfHND9RgSQH8iitKP/sxK/J7yy4GNpZLAF6rWkPIzJGqyNzoQOKzBeEjUa6FRnlp6hrqheXxLSqejSEGyBG2+2GstzlWF7wLABPlNhAjYALC7J1UDq4sFE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4016.namprd04.prod.outlook.com (2603:10b6:805:44::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:05:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:05:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 09/10] btrfs: make the zoned helpers take
 btrfs_zoned_device_info
Thread-Topic: [PATCH 09/10] btrfs: make the zoned helpers take
 btrfs_zoned_device_info
Thread-Index: AQHYyI7fRH1J9W/Ym0a8MS6LoSqL9w==
Date:   Thu, 15 Sep 2022 14:05:02 +0000
Message-ID: <PH0PR04MB741606D8FF4DADC01D17FB649B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <8ac50c0d42b9930f7e8305eabab314fe7f3845cc.1663196746.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB4016:EE_
x-ms-office365-filtering-correlation-id: 64166ae5-f8f1-4865-483f-08da972348f8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 44w7lPyIrt9EVUmKHclO3JfUVXB3YHYGKrlfgutb6p1CkMOuL3WYwMct1CLmw/neNygqA4RhxnUwQZ0mVHhFjJkrnrqbxcL7rkKmEizkmXcoVfPJ8A0b8nJ4x87DRTArRUD4QM4hTdOZr9lqxXzK1nzjMDKQjFR7B0ksLWzGMsC21/9Mw8EVj3dBDezNapngsfMpbWL91s8XWToQWg/HmbvkJoFBtY51OqYWQiYF30W3Yqk+lz2MPwMMZl8+DlqFfeiLi0l7vUZUk8q9/BONwU4beO+K+RERG5YL0lkER2kLy2QLKtZR4P9ogIElPcnPrG7iSs+XIU1StFLTl5ehB2huEeybb+4ChkjI8qMBvXuAJyMlLPapblQKMWm8yTy5+40Cx2ZjkmE4NxNwPSVrCgohN/ByrmE1iFFxzpNPuU/skzJjPru7aFUqsxcfo32pV5W6GuVQPGqrAvafOa34YHCYcibJJFcx+7OZ08bewnpLsAtA4/I+dWjUn/DAXdKMpcy55SKI8HhbWitABK9ulRy5UCCV0pb7L6w7b/bCSUOqfpXch7B5gQecuGKUt7rRp2CT+qsIPRm2g7+iS6apF9kVZJvR96PQ4GcuJ6P8x9Lv8E+yQwbwiuPfAOKeHJeo0mawfA/2b2iAWYquRDTEqDKpn2QwtedGfEys5Wclbhc8pqcXqSLMgN1pahO5OXsMJQqFaTKMmreEVZxsM1tjbYmGgc1mOOq+orVMu2uin0sCRIW2tWo8OqLMrMuNlQPsyPuqC0eKIbrDYdh63vxcwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(9686003)(71200400001)(6506007)(7696005)(41300700001)(38100700002)(110136005)(122000001)(8676002)(66446008)(66476007)(38070700005)(76116006)(64756008)(66946007)(66556008)(52536014)(86362001)(91956017)(558084003)(33656002)(82960400001)(186003)(4270600006)(478600001)(55016003)(316002)(8936002)(5660300002)(19618925003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ex7s4qe+GV4ibQxE1839HTS0dNDJxRoFpuUum3inUTSyOaeRq/WMKvkYLBSG?=
 =?us-ascii?Q?AMXUmbk7SOleUu0o+1OZQ/BamhnA/PnbcOZqR47y2Fm1dCal6lO133C2wkfQ?=
 =?us-ascii?Q?0E6awGfOs1r4caIZSoaKxaExrw/mVZuJUwIXsRab/jWC4v38WtkYClZVvT04?=
 =?us-ascii?Q?QLyV9kiOr+WMWxdQBcOsgSRnnrBqpJY73IE4dBLMhHohFG+jVPHiLipSEnVR?=
 =?us-ascii?Q?iaL4T5KV67wjeixqTPQ4qcjMatak+ufoW68VoPmSRUVwBrCx5bGAtFkbdPft?=
 =?us-ascii?Q?BB6QZoXh32CZHAq8QDge1pnB3GKJtlKdyR0HGfU6hGit00GCdNzajoqfeRfr?=
 =?us-ascii?Q?cYg7eMa1UwB7tRTSxzd+f4CZrrjmMUjVa/a0nQoJNtS8Uix7i8WocXN4QvCL?=
 =?us-ascii?Q?PUxxHTUnaN6dMd3EzJGq1z/7bKzoc3b+cSKzPOzB/5OW8nhDSaFUqPSJR2ML?=
 =?us-ascii?Q?Q55kqt+dpX4PMqLDjFW28DXiy7MgrtyCz5hqwAvWmazzM7vPKnV5gLKtxRst?=
 =?us-ascii?Q?16qJP13VMlblhfKrzdKxtVKHR5DB42lggbWPK5+uvnsceIuje+OcEC2ybpW0?=
 =?us-ascii?Q?uVXCgTYBSPP7XLRcxtA6Dl/+Jjva3xnHEvunn8aY3Jyi63t6Pa8b06im3ZPd?=
 =?us-ascii?Q?FUSxyuDaat6kCNUN7gPogYt2VrJoWbnvIbMRQvKW+NBAfycYUPzuOq6pEyaO?=
 =?us-ascii?Q?rlYo23aG48p9F++eo19wBYgdmq6OqoUa74V8lGs/VTL1MhrTXkqLNXbq3yAm?=
 =?us-ascii?Q?62D0oaRqiXKEqPgYGVwtJoxvQ1ghpmTsNGRPgTuHc0Ib3Vr0wClUsMCbBxoA?=
 =?us-ascii?Q?240DwHnMQKFj6h24uvuAvfBx+Cn785UfIh5yF3B9BHMYD7DH87E0j/DPKfKu?=
 =?us-ascii?Q?4T0U7Q/E1Cp2TWB2b3hpOM4pJXwlIHpgQKcD1rtdOBXL+CiwL784bzu0b0iy?=
 =?us-ascii?Q?2jfaOf+HQyKomTJobTD+de9aqiO4SORhWR/CdtDfNb4m1sa2SGGUiHBbc+FP?=
 =?us-ascii?Q?PZ5FTMnlDoBfLSg7Zn65PXYkZnNdJ0DBAOFPxtHPgxjVpMMeJ+zc2xvyT9RL?=
 =?us-ascii?Q?dzEX38FT8lP990NVxcwzm9x07D0iBH9WLG7D9BQQgV756k9hIhFKnCqVFMNa?=
 =?us-ascii?Q?N+iNmHg8pzbxqxoTD1hRFgDABp2T+xqeXSKHtwL00LQQXYiaQP98o9lImgJw?=
 =?us-ascii?Q?5txPnfQRWQ2cLsVFQRCINVEKPkPMGPcK/tDHw9FZWrzkflGmbRp8rrPujIYV?=
 =?us-ascii?Q?gvjCK0TP36LP4H4r37ySwtNBCddcA0IWLXBfrod1CWZcvoDIymZ/ZuTmynnr?=
 =?us-ascii?Q?1ggXGJRDQj4kegqgt7Vm5ZTPVfofDeVWmkg+sVNmNKkUPVmKVkZF1xPaY4et?=
 =?us-ascii?Q?2aGe5YEvxmAHSofeIrbbgttA1zGo0QfMxVewlCX6l9/1LN+U1482EHrQi90n?=
 =?us-ascii?Q?HASzbSluQQOkLFFadbT7fNwSzaHWgUL4Cy3baURzBg+Bp3sBSd+5At0SA8yb?=
 =?us-ascii?Q?Fj2irio8J1XvYEAuY65hioTEOslUZxJPBI8to2ll3SzJoovdZxeX/eheFvJQ?=
 =?us-ascii?Q?fB9X+bGRBxoOFHHpNe6fOLqJ3QCboiNL9Qu9di6K6gNnv+N1eOIJjuYk6GZ8?=
 =?us-ascii?Q?HdcEYZPpCap5jCVeZRxFgFrFjMenkFSS2F9lI3/vjDJgS8XOrxYuhMBUMky3?=
 =?us-ascii?Q?KBYO4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64166ae5-f8f1-4865-483f-08da972348f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:05:02.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6pIj4c/O0/239RrSP5vn1tk32vDUbkmt8UUqNuda2YtPbTR6R6BRiGY8TAMPpCzW01+Og1JHH9d3HkrIJ5YwwbMDJONQt4+TjgL1OQaMF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4016
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

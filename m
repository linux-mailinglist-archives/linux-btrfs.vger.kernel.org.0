Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD30776C448
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 06:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjHBEuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 00:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjHBEui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 00:50:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED237213F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 21:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690951836; x=1722487836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C1eCL8BsPIUzq8LDAtSqiQPDml0/iI9hmEOhESH2IBo=;
  b=VAQrDQlX32u8Tc4gcQXDzz2sumYjx2ypXHjXULuw4m1jL94Ff5BGjqfi
   JQwKUAuljaMTVqw7/a3MfoyUUBF13u+dNPXqKxXZWyxvjwYCejOvgwmx5
   nzekWgix7jhDrVX/XeoXgAFRcunVxFpJFlGpNyxfhfcKEzDW3npjxZaVQ
   KWG64N5ZkqTrF8QVfuZLJ/a3ZLr1AwiGW8Qowr9WLjXynaySK7w44zdAb
   GlzhIHUjflJtZM1OPmNJ2xJ67MInPBplugSeAJ02UrCrr2KQrJlyK/aX6
   J6xrMJn/w5brjd5dI3rAZhIQf2Am3HG/2eHDXizOQG49qlGfNuNsAgOqF
   g==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684771200"; 
   d="scan'208";a="239721480"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2023 12:50:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPCf/55aaPZws1mwmcFzeK+Z/2jqSf93qxBxzjhYUwYBSj+p9PK29X94tNRL9mLgJal+ls6fWw9CiCmVu0U52dVu5iaDP5ocQBGNUg29mWzj+yNG4M31oyM/xLms5fNmtOfu6dCASD6s0s9Qe6vtM7j8Qzrcz0B+ALaZm4aEPFut7QWiMz955fTLKjG9sIudNOLw0PD6FLldGz9pzb+bu14BKjZ6rZ7gfl0e2iOaTIYgQikrUIUx+T/yTuLLAZ2weEm3HuxS1Kjpoxb1IZwNNnX5xsALY9PvLDC9xgiTQLDe8489VczYeQYEbDUHzZovdJIpad6m0b/5Jgy3HVaqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1eCL8BsPIUzq8LDAtSqiQPDml0/iI9hmEOhESH2IBo=;
 b=XjdzMQmKdHKxMdfQiL5C6jQlqL/41bY2qcrq93ALSM9vEXcQKGa3GAQcRpil+0LY7NxzTbW6Kh/XpD5QN5E7KTG8m0I/neCprIo8ZWvhspwMi3I5I75vdDN827gu0yvTNQPv/yT08VzWriEFOQDVj/tOxJ7jJOFeL8GXBkAgc6NKoxZF1oL1NYzgF+1oKvMoYKLHGAxZzcE7kCTVgDZCLQsbwNrF0t5deDxFUwyzLitLWw6hT2Xvfz6c+2UpGCb5b2T7hxoNthl8/ODiVTWEYYQCf3QqJnBA1REHyCwDcWnkHyYcc9spFkKqJdVOhhHKLwopkIewhL5A131aDhySTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1eCL8BsPIUzq8LDAtSqiQPDml0/iI9hmEOhESH2IBo=;
 b=QfWLnC5iaW0xTHU7gnTtx7YmWmzGWZpE0DuzrShfjQqL1iz76z7LxxiZeCf/SKr9di/14pAyGKsCKpGEEgNrU/GzMj7CdAHepi9P6ee8ESYQ3KE8QOmcvkVTP6Hdan+X4RgyZ193mjVUAl0SJgtBjpHMe0DEqLLSKO20tc74g8U=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA2PR04MB7530.namprd04.prod.outlook.com (2603:10b6:806:14b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 04:50:32 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::3899:f57:20a9:c783]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::3899:f57:20a9:c783%3]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 04:50:31 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2 06/10] btrfs: zoned: reserve zones for an active
 metadata/system block group
Thread-Topic: [PATCH v2 06/10] btrfs: zoned: reserve zones for an active
 metadata/system block group
Thread-Index: AQHZw9LunlhFFxDTYUavs4hQIiL++6/WchMA
Date:   Wed, 2 Aug 2023 04:50:30 +0000
Message-ID: <xpb5wdmxx5wops26ihulo73oluc64dt4zpxqc7cirp2wvxl3qy@hv7lsvma5hxf>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <790055decdb2cfa7dfaa3a47dd43b0a1f9129814.1690823282.git.naohiro.aota@wdc.com>
In-Reply-To: <790055decdb2cfa7dfaa3a47dd43b0a1f9129814.1690823282.git.naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA2PR04MB7530:EE_
x-ms-office365-filtering-correlation-id: fbc0bd29-0ecc-42c0-f77c-08db9313ffe8
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aBrgmgYF51d5n+xJelD1oDYlRe1PGh7HnJrN59MfZD9o6JSHvUV3mYQ2YnpjaGO8xcoI6QgLApe2tTUH8iALelsHi+L4Kk9Qw47HlmLj/AIhlkFmfGoc6HMxd3iPQ5o9Qbkoi7RdmurXGWlIYmzaO00lP5KNLjoS6KZjb6+LoR+Y1OX+VPPlwCW5XtSQwcTxKvFeeHW691++TaSS6BKMmRuEK2J5AlcEQ40xc/Lz0j2CWDUK+YsupVokVMDtpBXfUcrUxR6jw+DBG3e6JcpITor3pfnWbM2UEQ2ecZveMfpZaFyW3YFAekp3pKUMWB3CfA1p4LrJLZCXSAggpqAdDqFUziuQCPEraSmQQffHJ58oiiv2Tio9JkKK5124Ih9xkY5v5ffdSyiisdZg1YjYEYDoJcYCKmaN/ffx4RiIsS0JnoxndeAC/xX9vHOTsWn3b8APWYFlPUAJeENZxRjSguVWHQtbSUGrC8HaYDN6S0m0F0hdGwpjOcigWayaItbppZ+YYwkkw15lF77ylt6M84L6RNDeqx1eP/NfMqCdflc86QQ63VRmiiyvm88nyzzff68nrI8ratC9DHP2XVLkSUpX4hRECiRDs7x5oIBgtLVjN+n2sdig6ebzB/R86+jB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(186003)(6512007)(9686003)(316002)(86362001)(478600001)(122000001)(54906003)(38100700002)(76116006)(71200400001)(66946007)(66556008)(66476007)(91956017)(66446008)(64756008)(6486002)(33716001)(6916009)(4326008)(82960400001)(6506007)(41300700001)(26005)(8676002)(5660300002)(8936002)(2906002)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EH4M6nnMp89ScTsAH3XLxIzLrG1c0HLiCVQXnIvt8UIeoLn9vYqkCYDEOEci?=
 =?us-ascii?Q?3C6ituIT2pYVPeblxrT9OmNq2EwdBZlYlbZP6j36oPhUOOHWlR+2Kq1rlhlL?=
 =?us-ascii?Q?2mG1fqaIS94PMhgdQ19MtXcVZE0JQVDKOMWZU/P8aogoBP85NkL2xI1myyQB?=
 =?us-ascii?Q?aF9AWbSlT8WBtnL5g16sUnvM5pFrRohpWq4OczbeYt9yLfFi89rcDN8+F+pm?=
 =?us-ascii?Q?vEntAGDUD41L7K8UL8gfl+FjxFx1sFmaWMsxhF68m4BYQFUzWdfKM+3YcBqP?=
 =?us-ascii?Q?oRW9EaiHKSKzJHJO8pcO6GmSfcwe89hX6fv+IVgS8SKdsq0dJq4B7iwZIjN8?=
 =?us-ascii?Q?CBA2AlRaxShDinCuCDRolOdzNznlYzhRZP1V//0SDk34IAj/9yDjBdMhxULU?=
 =?us-ascii?Q?bcUWC1YG5t6CMS4g4nG6UUrbNzJADKhjUuzImxAgKj37+bgBcNXmXOQit2/1?=
 =?us-ascii?Q?K4BehJfsyK3rrUDugpjJSRFfr2uUi+pTKEaLH+bfzSKDyoz8QlVpjH4aBxlj?=
 =?us-ascii?Q?3rUBOEx+brTtus2lK++IDzbaTOGEoc3bQp16bM3hXaCrDRIVidWxI+sXEwt5?=
 =?us-ascii?Q?2er9wym8IxgbZ8hFTRH7gxW2Gu99PboPlGD20jm+NGt7hVtdiJYtIyxptFc/?=
 =?us-ascii?Q?BI35YRlFp8dCw9cOWJt1fKDwf3O4SGnooiKjnqg1gP5PBG5k7M/7kkd5onvY?=
 =?us-ascii?Q?fKUGDlNWP38WzAIYy6dyYbTp8BKwxEGT/GFG+x5atBYIFQCM4X8to/TvtpJR?=
 =?us-ascii?Q?0P8UDzRXNoY5MbZQ4lGslWjUnbTTE4BXqxamc6NYm9ADJWBXUGipNTpfCA3V?=
 =?us-ascii?Q?J0Pos70FB7LhkzqFgKGm8BJNg8OIhFKKprDa6p8sn7eIEArwGDWN+gpEtpE7?=
 =?us-ascii?Q?oPY5tC7TwEqef6F/trKB0daYIps6uJN7Q0PqiyxLaIYtlhmkPP7DLgV1UsIM?=
 =?us-ascii?Q?ZLtHcoqqzQnzgngNOxCOBzQV1IRPZB9mXldtY7XQf2j/jmI1AsBs8XmejCs3?=
 =?us-ascii?Q?w41eBwf5wg9jmHPl19CK9xaUEXecQ+vk4lUxagX4kM+3huQz4schpyV58ZuF?=
 =?us-ascii?Q?BtQ6cbe+ZDTnjqQN0lW+ivOe7UNbfBfCHNAsV62LCmwqhpRxNMsGe5TFOXA/?=
 =?us-ascii?Q?a8Oo5XSzq9/Nr8ijIDB4G+X2tmLWg5RmZvaGq9KDrKz1ZeOqaIgPIaw5UFjU?=
 =?us-ascii?Q?eCZfdHExZ4IdlYoDoFh6dKjnnlA2UUG6+cPrjDTAIyRFuf3HnFJGVGfKtgnF?=
 =?us-ascii?Q?Ob9GWw1U2SWRI0IPfwLDp+NV0au69dLI8tQ3/MWSVlIVC3EkqeBdpf4eQGx+?=
 =?us-ascii?Q?DcoZFSHkAakidLZRlGYOBn1dewXYAIIj5u4Yda4OTw/htA8QGYAwOLnHkxSa?=
 =?us-ascii?Q?oicPVNOw+jNGUo0UOgRmsiXhSmZ2Vh6P43H2jenO0P9vROqLZg1JGTuDK8fi?=
 =?us-ascii?Q?WNbduJm52oO4tKISRhiod0Kcn+txQGNJ+Yb5ZcBS75F9PWvtDiqN90k6PmEW?=
 =?us-ascii?Q?diRgRQgRPRimoV/RlTOaTQj1AUgiUsOQjkKJemwY2GGTe40nyBP+34y4oE5j?=
 =?us-ascii?Q?yh7VaOpTPB5CgWhyFkM9LSufbaXXWMPjptG75pLIi13EfRTSJgYQGk8nVwNn?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D6645BA02EB714EA395282996D75355@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Yl/Cd29BbXqVSA4Vw74MJdtnsKEwALnqdJTuIewFfhbyse6ftc2zNzlmuPKuda2ID76e9bhxl0W4Oa25ZSnXfqqwWS1SksdHLv7D+ha+hbyL7WhRBQ1fmqJ6eojVKQ4pzimNVnz/Nqh0E4RDNPDrchCV6BBup5EBw3omUcKtsSwk31ZpSL/mux2R+BnrTPwHYbk4o9ikMUGYIYdApQkBtbDLW8surIV458DoYnYSD3YHt12kZwVAcgPcyB+Gw3wrz4jl0Wgm5ms3JXD+e92Z6A+cxgUS1eJEMMZF85kHxS7oqro7xqsHib00/5Yux4APrebv+gU/a8N2zXDu+XZFIeDV+Ahrkyvb+gnNLGUI2E3X8ulouFMSpggtjepQxpoz5/KX7ie53WTdvr16Bbcuv81ZVA3iC0YsQW8CiXZ521qo7Oj1QupwP5MABI3v/o/wOQQxeJi9ACfk1uVs27OOGV6DRRRMp8aWY3erWCZrb6+4r8P6A2Gm3DjspoISz3w1546sdY14Pp1WK8rK9ZCovYfRLIDXjmnk2ALAaZgosx7OfegU8MLYh1ZtkT+nZhZ2xGaQsdyRE3JAM63fPc4q0l0FLuJ7eQkzZOm9Nbo8RPNj0oGc23VYnF1dr3/JmGEhccU7VkZCrguqFXPaF7wighKQkc6kG+DBbq+4K+Wupn6Q3efeGBa8sqdPHu0hWfU9htQRnyRdt4mY0Fm/6+ePKPeQd6ACqXAwPhvA96qpNrf1liznpN8R9JixsczRozCLxQFDXN7rZFQkbLqqxCLzkSOUDUWGRHB9soD1oYrKS7l5lhQCW6RdGpbX+kmzxHBZCBd/SLVwNmZrwL/1rFU6PxM+lsIQWyQU6X3iGYI+NNIAC4Qtg/kPL/41M5qFUvry
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc0bd29-0ecc-42c0-f77c-08db9313ffe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 04:50:31.0019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WavaF+fdqJ0u8QTyqsDnpxg7p9MXYEvYl6/w0o1OR3drl+5Zt5Ppl2W4j+waNoLDeCatetnMTAQ4Haqb8awVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7530
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 02:17:15AM +0900, Naohiro Aota wrote:
> Ensure a metadata and system block group can be activated on write time, =
by
> leaving a certain number of active zones when trying to activate a data
> block group.
>=20
> When both metadata and system profiles are set to SINGLE, we need to
> reserve two zones. When both are DUP, we need to reserve four zones.
>=20
> In the case only one of them is DUP, we should reserve three zones.
> However, handling the case requires at least two bits to track if we have
> seen DUP profile for metadata and system, which is cumbersome. So, just
> reserve four zones in that case for now.
>=20
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

I noticed this over-reserves the zones. Even when there are already
metadata and system block group allocated, it still leaves 2 (or 4 in
DUP) zones to be claimed by a data block group.

The reservation count must be increased when we free a metadata block group
and increased when we allocate one.

Or, in fact, we only need to reserve the zones when pivoting the block
group. With the zoned_meta_io_lock, metadata and system block group won't
pivot at the same time. So, adding a bit BTRFS_*_ZONED_PIVOT_META_BG would
be enough.

Anyway, I'll rework this patch.=

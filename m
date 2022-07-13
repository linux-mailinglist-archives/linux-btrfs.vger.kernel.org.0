Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617885733A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 11:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiGMJ6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiGMJ6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 05:58:20 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C6FA1C8
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657706298; x=1689242298;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=b01Op4wWYOqzFqapMyd+2ohXKGzvtHu+jPOfY62WLIE=;
  b=HL4LLUca/h1+hRg3nsNvFgKaRWVJENwMJ+BazXJHCUFd21byBTqXHl0i
   PpXZFEzUubHEvpJtww2BM+Xanbz6KUNAal0gS4cFM29zoJGl8epr5qn01
   hnj5ASFVQixRMAVqIOvMdn46zoqfD+ldwKmgHotVLYFKukKm52z6tYknc
   2YGmi+2lL937EDaRtyqeADAz5WGOO+eI7aRgf0WfGykdMVI8X+SV7oDH+
   5JR6QKdqv+XrVRSDl9hcOuy5KmzKnUCAqXjTpfcUhNToxCmYQTT5T9C/I
   /Gsj5epoaJuh7m1NrgC7j3PpL9gjtO0ep2k4TtqRt0a9Kca5uujEABjMZ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="317725773"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 17:58:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKRrX/vToLCZtHQXriXBOsE6EhNE9losUGRXWHptPaG8DUIGYVhoUoGROaUU5+ru0jconKW7CnRTvlHfKVNVvBVfWhrPfPwdbxFrgaDLyjyBmrH5JS8Q9CcwDGPoHm9xJ+Ft52qEsP0aX3Y+3TAq8EYmTjrKH0xBHucLzetJFS7OE8En12dCbLpoBDoC+0VJoz2wEVpr6JFhQwOmUgwjGWll5EJqijGfU6kWqLGhQYJk9kHZ5C+NidKFM8JxWHWykJFGTuX3YE79BpRhXkfUl/kuVeZt87SLL0cvQ2sRLMf58bpIIoV7Qjak7DR1rgNXLBqYbE/bictEvZpwZQht0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy859OUiNWTahDp0ZJ9dNSjFHPX+CSeTkeqD6/Jex0w=;
 b=Fy38dTfb7oWSZmxRIUgL0aguQij/5s4c5J5R2nWjKsdddQ70te+3YCPnIwH4PI31uAcUwyYSLP0tcjz/vCnZ6UBB6brxLEHD6I3GnZPT1WIMq1jzVAlHQXemJPxUVavT94RFAdIMh4+7kqvWCwCXzg2HB3zQ86ic3w2oEWdJlQTwkzDkIaSo79IIKM6l8xu+8FzxJxXuUm07SHq+DgCWcBmLIiF7n1z3+n/xxFhIWA8mCs6Ct0gt5VfM1YQ/dwN4TLx8eS46Yr8p1B6+2u0Hlpc1bM/HctGVjdFTTn3t9qE5kS9qpewNyMkAypR4ilJXB/lRYeo/G3gzLQdjFBFKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy859OUiNWTahDp0ZJ9dNSjFHPX+CSeTkeqD6/Jex0w=;
 b=j7O3agxF3ib+q7Jf76Q+EbWaInQ8074QyrPrpWvzgoMPkfoXH9Tip1Vfb2tytMP5MfgekqBEaQ1ObDP0PJ+MFf+hoLkFeQWtPIoQxZbvdSQkdynw3INKUqgDHuenMYGgYn3yGmnsY8GrD9dDdca1q969sTAdqUz6DoVCM1Spx4s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB3879.namprd04.prod.outlook.com (2603:10b6:a02:ad::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 09:58:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 09:58:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/11] btrfs: make the btrfs_io_context allocation in
 __btrfs_map_block optional
Thread-Topic: [PATCH 10/11] btrfs: make the btrfs_io_context allocation in
 __btrfs_map_block optional
Thread-Index: AQHYln/P8MTTgTjlBU6XXi/vjmwSzA==
Date:   Wed, 13 Jul 2022 09:58:15 +0000
Message-ID: <PH0PR04MB741647058825EF24A1E89CAA9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f01861d9-591c-4848-d6a6-08da64b634a3
x-ms-traffictypediagnostic: BYAPR04MB3879:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QwvrQXs3PAyG8H0mesDMaeqKxCZrtf3VZseKB1yOpOwWh8yhn2oiEenm30YxaBbeMhqt5ZQnLunFOXtVKEHFGK9g6rnTQYdndBvzrQyH4hoypHqqFHS6OR+HdgBRQf9++BFjxDZKgpllpfC70HlRKrTbx+vh98bu96M6PZWLw1ylMVuyrCB3aPyd4wxBMQFM/2++VQse8ppmakHSUrG9K6VnTgTzWcCiCGTb6j5bj3UINONSS6U4w3cZ17ih0HLrUx+aNB4Glz4roNi4THLK+7HaaamzTYzULlaMqjuHl3l/H3XT3cTWKrl44QSkyGBA+UXbINN/6la6okbEvcnln8Jgu0V21ULqSlgpEsFe8wu7dZGA0u7lTxOY+KwArryBIHtBta0CS/AVk60r2f/pndSttufEX4JNHBeIo97mLBExZqUgDcoWtL+JEP53L7FPaq+ceII3rJ5r9XId2Cbu4te6WL/EuRuzMBL/gbZOQpus8Ci21IJy6vAZcxnC/H2eWxs1Rg8P0WxvoAtDY4hvPPKFxmWQ/S0Hy48YSBbFiuM9dLc8j4t0C76oWyWX/HOtRUIZUo6V0RMi4zWx/PTxTpmU52aCHGRAIxiTIDqRiFwALJx/U5+2FJcl8mk7CfXr8+JrlAoBkedEHtNVnLy2Kk87DR0XCn7CjmQpwc0jXUjnU1vIliL2J+aGojxWMHwLMk8N8x0ks6TWAszlSbnGbtBvNDSWHY5e3A9Su+/xP+xs0R5kxFRKrgWLHK2AsTbBj3/J4QOLvqSxEBVeXXdxED2FPC+ssjBWAFGLZoAq4SCIx5Vd3SjsVPIFy2hI9pTf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(33656002)(41300700001)(86362001)(54906003)(55016003)(26005)(6506007)(7696005)(110136005)(122000001)(5660300002)(9686003)(2906002)(8936002)(52536014)(8676002)(186003)(38100700002)(66446008)(66476007)(91956017)(38070700005)(66556008)(82960400001)(76116006)(53546011)(478600001)(4326008)(64756008)(83380400001)(71200400001)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ONlUTk66b7DFXLS9RtYVqu86E79wDmzDIVRlb1ZhxD7NIP76+RC58cnmwWaq?=
 =?us-ascii?Q?LmmZMZLfrmqfieSf+WzYT9SQzrvr9kw/CYO+823MOPpWrHz/N97Vg6Sf8N7z?=
 =?us-ascii?Q?yIJstmaXeAsGVpAbyomZ1yAKaKwso3/mq9b7+BVKoUBjJGxfBcmMfwWwGKK4?=
 =?us-ascii?Q?7x5GBpvlJ1CK/kg1wHfw/HXbmQw4FAOAdI2R3BqpZ4fm8LwhYVG6iIYKzkyl?=
 =?us-ascii?Q?DD+w5+UV7FE2IVbsoxgEehSlY7p8avXOvfMHOXbc+0YPeGLSRs83039IfpQK?=
 =?us-ascii?Q?wio98G0ns35q4NpOmtnwTir6vCs6E6Snczwrmq03kcIvlnyAlQu9huP991rj?=
 =?us-ascii?Q?xYhzMsOihda1o3PKBgFRZFSTCRkuB8hIPTScMAZBiGtjTYn/ep8vPrnfeCDg?=
 =?us-ascii?Q?ElsNXxZCRMEcXONScVqh53EwNShYyXHPAnAaxr5YJwnr5NUtg6ztLeFq9eIZ?=
 =?us-ascii?Q?XD4dulRSPGrG1QTPD2D54EwwzyGYLHJmgIODzrZnQ2NiUcgonb/OdajT+RlW?=
 =?us-ascii?Q?z+CJGK13zXqnEcjp1QRUpQEs1Dw6KEzVyXyAjLrzj9AdZrOqEJpXxnnDhXHU?=
 =?us-ascii?Q?zKTTsgmFhffVbAtu4Lvj5QjUJitg7KLoUC3PWbV3OKBEi2hbZiyRJiLkxGEj?=
 =?us-ascii?Q?RL73XPH488AvK6SkNWDbKvkf4Rt8tku8rXY6aXXgjgx5erHKAvURvUX9AQmJ?=
 =?us-ascii?Q?W0FP7e0TC3WtKf9YV/7JoibOB+KRE7SREGUrZq/a6488ZLoTuMZYU7AIkHy+?=
 =?us-ascii?Q?Yx4uMMF4Jth1GSg5jRwjCgJQ7jLS0FPPH+60cF/eJWUiAcM/BjS4FA0IbrGc?=
 =?us-ascii?Q?DFj9lrL0i0hxL105+ZRhSU8Ycy/Dl9okJIf3m8g1FPHJLa/ciQGxM/zDuK+n?=
 =?us-ascii?Q?OkbqKsDBKlD3u8+BKxi4cJomE/PqRQ0fCoMBS0c6eOJpVjlJfU2CFZwUIMrZ?=
 =?us-ascii?Q?6zSWRBMwDyqVppcHkysMeoEEAlDFZv2eBZlvr7lcsq92NjnnaKKVoa0uEN+w?=
 =?us-ascii?Q?2Os0NzYT6RU/UPjONKWfGXA03aoGTb0QKQUn4kZrV1RwNW8gBaHZK7Dl5+2l?=
 =?us-ascii?Q?CFsUJkJmce4zLYzAE9WyJJ+vJHKKyiGAF5Dxw6qu6HGqxSNvGU5dwDB49LW2?=
 =?us-ascii?Q?SaXu8n15bbSSu6EUeSmkToRjXZAFrcyUP/wokbJBBoGw0waeIAqbLqXw/D8/?=
 =?us-ascii?Q?z5GFrulsePWHQSNo7ipcpq+/yLD3HEwlj70wIsOtFDjbYVxSC8w6LJ2yozeN?=
 =?us-ascii?Q?PoihklP4rszwY6VQZl/zpq+q/xMUMTLztAZBEs9Z4iL2VcE2e+ylw73Dst5u?=
 =?us-ascii?Q?011i85F6SF/0A70uiekDudVwe44zHgd4C2q76cm1fg34DjH/pdJZRJDbWMwt?=
 =?us-ascii?Q?qeKlkEj/oZniBHFQ+rwCl4S0Sp7xCrlf6LSu8j/vEl53fJAmsRfJilazD0l1?=
 =?us-ascii?Q?b5YQAOR1FdeSRDvHsPmtkI6po3zmt16kqZFOmDo7OyvtoO4o4ec6e+TEX9i2?=
 =?us-ascii?Q?Xu7CbSZJXZfxfpHB5UvLAsJL6uZZA1lSHudpdTMRn1qs5nU4rJsL/aVPs4uy?=
 =?us-ascii?Q?IyTsupM5JDeVH4AoILyfBn7bZIo+Ooam52N7xT+zLv2/Hmj+jJXbe3GImPSL?=
 =?us-ascii?Q?W/wb1YqP86/LhV/UXIZHBoo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01861d9-591c-4848-d6a6-08da64b634a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 09:58:15.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSa+fMC4Yo7AuPK4TXGOFvsjrwrHYPTZNxCoklYSzn+qKIo/A+uem4fnl1V+nk1L47Cm0cOG7RsPiDNBrgkmcOVt5YmPKrkp8mGmEHQza5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3879
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.07.22 08:14, Christoph Hellwig wrote:=0A=
> +	/*=0A=
> +	 * If this I/O maps to a single device, try to return the device and=0A=
> +	 * physical block information on the stack instead of allocating an=0A=
> +	 * I/O context structure.=0A=
> +	 */=0A=
> +	if (smap && num_alloc_stripes =3D=3D 1 &&=0A=
> +	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&=
=0A=
> +	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||=0A=
> +	     !dev_replace->tgtdev)) {=0A=
> +		if (unlikely(patch_the_first_stripe_for_dev_replace)) {=0A=
> +			smap->dev =3D dev_replace->tgtdev;=0A=
> +			smap->physical =3D physical_to_patch_in_first_stripe;=0A=
> +			*mirror_num_p =3D map->num_stripes + 1;=0A=
> +		} else {=0A=
> +			set_stripe(smap, map, stripe_index, stripe_offset,=0A=
> +				   stripe_nr);=0A=
> +			*mirror_num_p =3D mirror_num;=0A=
> +		}=0A=
> +		*bioc_ret =3D NULL;=0A=
> +		ret =3D 0;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
=0A=
=0A=
Could be my changes on top, but in order to get RAID0 with a raid-stripe-tr=
ee=0A=
working I needed the following change:=0A=
=0A=
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c=0A=
index a7886e421153..344d2cf941a7 100644=0A=
--- a/fs/btrfs/volumes.c=0A=
+++ b/fs/btrfs/volumes.c=0A=
@@ -6506,7 +6506,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs=
_info,=0A=
         * physical block information on the stack instead of allocating an=
=0A=
         * I/O context structure.=0A=
         */=0A=
-       if (smap && num_alloc_stripes =3D=3D 1 &&=0A=
+       if (smap && num_alloc_stripes =3D=3D 1 && !(map->type & BTRFS_BLOCK=
_GROUP_STRIPE_MASK) &&=0A=
            !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1=
) &&=0A=
            (!need_full_stripe(op) || !dev_replace_is_ongoing ||=0A=
             !dev_replace->tgtdev)) {=0A=
=0A=

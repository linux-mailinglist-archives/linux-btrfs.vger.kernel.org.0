Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C15569051
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiGFRIH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 13:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGFRIG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 13:08:06 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A0D2A714
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657127282; x=1688663282;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Xho7yPD/FjzoxeNyO///fj+Ae9TXkPQ/LcqAOQiYHKXnPXYwfQcSYiDv
   K5vxCQjeAwCnXqXagckyHs01PnaCmolVCXJVeiBVWo+Oq3aXadI2UCDcc
   pF9IpXKye60Y22jgu8jo9U1EEMNCDA8jve+eUAYSqY5323Unld2d5DVWs
   C65ad1xOiJEzaxulNY8tDLpnN0ozPEfnHT+oTGOF/e/ypqiyj7Cu3xVCd
   AMX9FD/C2Jj5Yuo9Jd9pRX/ETKprrMR+lxaU4IPZHpTeaxrNrpqktfc/m
   ve6RNVupTpVlQnJekUqHFKC/9y1L7tvgy/opBduyBBz2f/VV0oRj+6acl
   A==;
X-IronPort-AV: E=Sophos;i="5.92,250,1650902400"; 
   d="scan'208";a="203657760"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 01:08:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdnMiJoRWi2LKXtOBsBX0MALV8CoI9r5dqizGajKphSpowesVSHShQcwAnJghmO2gv0Ro0X0KW/NVa030FES23ys9nGBgcAE90A/hBOLb1RfKYXMxfVekLSF3YPxFCZXtr9dwwl5ypjtKt2+QfxZhAEZC0T2E1heRMIXOUu/4bO/K+oDrs9D7jXqWETo73zxkrlNQIs9YErHDSdxDBJWR0adDo0zhPLfTDs/vZJoxywJ3PEn1pPuXTMdlqJFwCX63hH7Q7fgpVnbA6DpnOSaQ8q9qodHrI3h0BpI9/LUW60HJwOeisifuJpilbPqs+aLBWhJ05rP7bEDj1h38Ec8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LJglVtcdtsLyWxC6Eabwcv85hOeh+L0CdFe6Ea0nLEKpHNp+ra2eEA9TOHpNi7LC9n1/gl/LppYoUnRzFoX+R72li6SHeprja9W6WmXiS2LVkFHrlMPxheEjv9BLbscBgnlB7oWT6MWenpUYzlutncF17hUcz5w/iM07xmd1DUA+IoKlBe9+nrJ6bRRwXduJ9uV2K3sDJTyLoTNVjqPx4CZVLMUgRsVLwUiTka9VutyavLOIYpBqnKotdUKN7rsR/8fvTFA66wYEpUoisCJUNmAGv7P4aZDxGy5N+jt3L06zGvq7yXDfyExSearM54J8p0vYFbL2E2121kzm4mRFFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=moX8B+WMsuyzRyBkkkkQnW7ooVnCH+gc/Y4cSwoW+IvM+bWGTbyjWA9LtuOdavGe3DEQ72V5d6I3qgx4pWYa0rUwvQqibheSHtHPpoWXk40ghNyI8mioU6ZHMvb1nCu8dT7CsYQb6Yyb2111lRgpq9cj4c+xw+gwFIX6thl8G0Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB5124.namprd04.prod.outlook.com (2603:10b6:208:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 17:07:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 17:07:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 7/7] btrfs: stop allocation a btrfs_io_context for simple
 I/O
Thread-Topic: [PATCH 7/7] btrfs: stop allocation a btrfs_io_context for simple
 I/O
Thread-Index: AQHYj4JNsp3Oc949LUGyqzNlT6ftYw==
Date:   Wed, 6 Jul 2022 17:07:58 +0000
Message-ID: <PH0PR04MB741694A5FB225DCF4D90D5F09B809@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220704084406.106929-1-hch@lst.de>
 <20220704084406.106929-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f94b081-0e78-4705-285b-08da5f72137e
x-ms-traffictypediagnostic: BL0PR04MB5124:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdhgxbI65vRakS9fBdnRCl2E6H9GxSyKvsspOSFtgkni0pzet++PTM58UaRlZqFWSRjBnXuslG0zW0L0iTD7Uvif9eYR3BmTnvPMX1wMyVIJ+PtpeTGT2N3kPEvQAGsjj33z9i+OtTjqRr0XF6aPaDR4kepUD1Ty9q0boOD/tIGn9Jab38HAYd+tjFoeMei60IbqFnBa/HbekX0P0NUPAjb2bklM1VgQk7XAdjbiod321+GXYUn7VdkJUAETjiGN+DDppn4dQw/i6a5ach8ODQw9c/3vhQGyArRYcorvYsolKLz0WY2cwtXibUQV5Ydr+3aJkJ++U0Q7a2ZM6+vMTh6a3HxQYLw5iHBCzHfoVhP74eRUGHEqjP+J1DOXU5drmw2HDLLa2oz56LAplOC6pBkHd/kIJZtkqyLKKUZn9ZsArpfxH9dOXQvWh+7Ck9ynq6MTLDKMPcRu2Y/G3NnXW3W5nKEe0enMmbiqMd7Ebh40KSYjkwm0YffpqNPa0c+gKj6zMg2bGhgh7Z8I8FAtZ+UqXopq4bG66lwOgRtgsi5YflyULeD/cmamCYSdnDQmZ7Vq1zmRftLYYoXJER1HCarpeVXx7erFtYDLgE/AirXpoBIqueWSXGg5boGENGGQGzIh7YYE1gmlw37mVdwPhsvFlo4InUTVsUOXCnMVIZx4zjzLLi33zdN3Seu+DAOAvj7F/SHDDPvhcWbkYkNoJ0ec5eSgf9+D9+Wh8eDeGxL/URW54PZLnNyIfe2/bpL++CyURc5SnAhoNm1bhjzebCzaufKK1zK69Hw6wQUwHCyBlzrFLPBvbjODFgW3sBCg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(38070700005)(82960400001)(316002)(8936002)(5660300002)(122000001)(86362001)(66946007)(66446008)(55016003)(66556008)(64756008)(66476007)(91956017)(8676002)(76116006)(4326008)(9686003)(52536014)(4270600006)(186003)(38100700002)(478600001)(71200400001)(6506007)(41300700001)(110136005)(7696005)(2906002)(33656002)(558084003)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cVOLAHkcBzPX6Y+hXofoUqrgz96EUiW+zWtjTrVOF4bIdeKA+aL8VVSB64f0?=
 =?us-ascii?Q?wDFUe3DeGxULcLYtm2ukF+1krk1nJP8fSReR6azt9HXgB0ew+uVdGLleF4pE?=
 =?us-ascii?Q?jTMtzv8tQgVfO8rRqdiexqVS6+uOVywU/ZBzImZu1x8d+YbeZBBVRbmLQY1w?=
 =?us-ascii?Q?J07zSkw/DC+uLVmVsgpt8xR1ny4ZvpUNxsfP7ok9Gf54Qsl96Mgsytqf9yG2?=
 =?us-ascii?Q?O9XZyCqlvcc8qYcJt26fb1orSyzAeIPJP2tg2ZS51Ipo5GP9ubt1p6apmVCJ?=
 =?us-ascii?Q?egHcFdApgSXuntOLr1XXtVB2DMcQq1VWzYlSp4Vl4U3xtp8mrYBmoC7HG/wC?=
 =?us-ascii?Q?nju2X3v9iFaCSiM21IbdOIdhj9kAAVRrCaLc2qWS1+H7q+j6ff+wcXKQfGaj?=
 =?us-ascii?Q?xOiKK2JYU0pVKtQfzf9KxasIY9NeBbkcEd0EYBNDnzHI8fJ2m5bCdWJdUvhK?=
 =?us-ascii?Q?qjP0oL5fFgSPYsZu0SrPUyLYaXTi/QGI09fPZ80EX7JsCCnHKWOGLaW3I7Wq?=
 =?us-ascii?Q?lj89EA8f9h2qVM5qIKGO1pDfto/OMG//tqRBOuLaCu3RRCtpkY5vN7SoqunI?=
 =?us-ascii?Q?T7zeJiTlEAA4Ybs/Vrfw2N6EDLnh/d4YpH5lvLyVtveYmD6TSRLSl6XCeYRc?=
 =?us-ascii?Q?kK5YiH/s98CLFziSQU5SIjQJv7k8pwV/ctX9bseLrdH87QRqkLD2YoQ/bmCy?=
 =?us-ascii?Q?BXv4yb1ApMhryrWxjqZyaiUplezN5vGZxY9+JafcU9zS8tK6RZgnN+c67Lrg?=
 =?us-ascii?Q?lkKQme58cpHy41g0Z5j2ZKgRmu0S+sUs35X0I3mUK4To53hnVMCmfQswW0sI?=
 =?us-ascii?Q?xBmL7w4W95BMcm3sw4NrILj5pWcG8P7B/r8KTl4nzdkNqyoIRv4GIf69IIcH?=
 =?us-ascii?Q?r4XTAa9lCH2bq8C/Uncshry3I79/56dox0zsbWFIILulw0XzPTGXiuFB42Wg?=
 =?us-ascii?Q?xKihbrs8fKhd8OMR/KtAVWhRr0bAsI2NFsasJPeuAqevczlKAZXAkEsZpVTq?=
 =?us-ascii?Q?Y3Izj/xHFgLz5fztQOWPk0Mlru+TVJVLWPlIzK+bpiVpfxaSrl+yyrkUkCU9?=
 =?us-ascii?Q?1RQzVM8BZHtaa1NLjrYTdfSBN7b0rAmU4bSZ8pAz/kd/sti7KImt5HSVyMx4?=
 =?us-ascii?Q?uPufZh69teU8FPQxwPa2LSr/hHCJnCSMfkUAyNdpJE9hPbxtWneKS26LYa06?=
 =?us-ascii?Q?JGahOAZT/QP7HdSX/blYmb7J1qX1hWleKb+LOp3iqMaZvpCjgE2RStE0bee3?=
 =?us-ascii?Q?3Eb5J6ARoumyq+tVGMpbrGNj9yQYMAupOIkUyafWYoVNEiJh533Dn7nV+f5x?=
 =?us-ascii?Q?2h431yyKTxYYkuF+kKdr5escQVg/K0jfbCwODei+NSKtxR1bwSrVvF0L3Llf?=
 =?us-ascii?Q?QQtaZ4Q0jA+zQnqA9LqnRS40pC7PEayRVLYntE2MG4MBtn7ZzGdX/oXBucG8?=
 =?us-ascii?Q?Dz6G+FfgP+taq2bk/GqDjtYJFtKdIDHC0h1hnBK08ZWPTbHwHB+Btqpfhhd2?=
 =?us-ascii?Q?CR7KyveshUdKF76Kf2JOgP12BEFF8ZisDNz3KAUWeNpS7zrA57CN/F0RX7qx?=
 =?us-ascii?Q?IuixMqPDSLp6G1DYCdeKamHRigLpQBCJ7oEIIj3kHBOBE6QLd+J7gnylcPW1?=
 =?us-ascii?Q?nQjEanhmg5PQi5oSHdk0+Q8zEpfKu9UyP0tU0cS5Ax2haRf7d/NM9AtAtlDW?=
 =?us-ascii?Q?w4V1+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f94b081-0e78-4705-285b-08da5f72137e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 17:07:58.3667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHYlQ0ntANMeKl+mGkEc0pKc6axPbVOVE8g7hdVrOvvNn0Fp4u7uqU4hexV1Triv+cnlkCYbHQJdCDuW9/ZMKElVFzjMUPTV2WeVquOPpfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5124
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB36574B59
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 13:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbiGNLAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 07:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbiGNLAX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 07:00:23 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D0558C7
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657796422; x=1689332422;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=j43Meji8KCDiwq065f0CgI4DHPSE+1cX5/pZGb7i3SEyo0TGiTaJ4ffO
   RDI1PsCeinP5sQ7+uu0/SEb/nAht0XSSTLQeT+O7VyXzKXGPYoxYfKpVg
   HBODn9qol2CD2oHpLRHy0O23IGZIW7aeYZGbnJx6egALv9TLX34xqDbAU
   ieI8XWh68JJCHWjVxxKnTxoLwFWfk8jqgnEiqiAxLri9nx7Jy7TaY2FNZ
   yK1Ij0w3i4iC7dD99+d1OK7cC91Zkg3cXBYy9/npsdtyZ+rVdgHFWKmCN
   qpk7rd84DOvfmFnLUUfMJgDVdaGgHyt6YahZGx8JCf6Pe8Uhg8jwjjp0k
   g==;
X-IronPort-AV: E=Sophos;i="5.92,271,1650902400"; 
   d="scan'208";a="310045585"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 19:00:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS4eRZKojHGgbP6onpx6Eulu6TSRswj+XU6ME3Z+p0nG+ngkWmg8SYOHZUUc2yDojNEwNB7kH+SEhXzXF+Nmh3Y6q6/v/fz3XNWpdu9D/0AXhmo0t/uH5aSAjtd0PYkoqGKK5TUS2ukdMklzdWsBIbI+LebbK+ARvreoPTZTJITKY/fT4SIlW87SS3Lnv5QNS0sLz5RLlT3Lb5fddL9UKhFu3OmgP1lE/+XaWKc+9abooQGF5fDxXvE7p99tJSFuPT+rIiPQW8Ocg53WXXfP/m3DxTpmnGwNDSI24eiE9TwwgJbjFOCGqzHpix70U4HlPkxcQRpzUPsICO8urlSYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=MWKPedbx+PXXO8UPY4mIlJZ+xlsUuOq4uakWojs3M72PfCfDrUK1Hlwit7fR0GWciqOfrJjXs6WPdVmWd/6R5lj2YJ9BW87tpxujiI9856jrIxAAGlXf2w9lbPnqP/qlLcI/VhpyF92bBD91CZBGAp8ZSvGj88T654m44U7BUI9r+n9ynEzAe6l2dkV7ajSnTnNYXdKF8dZPGLX5gUkQHpG/pDJPm+yLpm/fuWoQF9xHBfFNz5tFCO+zfpwbFcG1rrXUWXu3oqmcnDftdxmC+dTJClnGhXqUhK7i3m2tofc/om/TOPGR08LDVS4jF3kGpIviM9CZVkm7us8fLEIPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FNrmfrWko1IhNcjwfUBCKZJucF0LcPV8JCgWu0DZEtmIW9iWUJQNwo7LXCv+UP+qVn3PP2dDzIJym4VBMju4rP+T69gqvYKiXEynLTUatJhjlO+bTlsdWRC7N28DJ/rDYxzE2BsMH4vaT4fIVNoEj+zlqZLhzLEh+D0jpF2BSoA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7300.namprd04.prod.outlook.com (2603:10b6:303:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 11:00:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 11:00:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: simplify error handling in btrfs_lookup_dentry
Thread-Topic: [PATCH v2] btrfs: simplify error handling in btrfs_lookup_dentry
Thread-Index: AQHYl28+p3pzp81CeUqhe4RFf/ng4A==
Date:   Thu, 14 Jul 2022 11:00:20 +0000
Message-ID: <PH0PR04MB741655AA4840D0936591E6B79B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220714104810.2733591-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f78cf10c-05a6-43b3-bee2-08da65880b07
x-ms-traffictypediagnostic: MW4PR04MB7300:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNBcl8xCcPVSLo5moaKe10rQiI9qDzqOh6zoMyrewtuVAzkRzUTYtVBI/35hZIkA2QcngTGLySZWjHxXgpj1XWaVRI65J6E24udPrVhEt5b4ilCg6qi7AhKSOGT9/sx6Fs0RyFzXm/Z47OwX8K8cpgpY/HhYu+n5Q6roP+tWUXoM9AUXWArot/R0TIjrOEwEJwIlLwP7ogpJJYLbmfd76/qoPw0rTh4GXOklI23gDnLahZNldT7HwX+rCY0vGvV6giQGuVRnQSoRlSJAzaQUdfM5miKO63S/T/7Zqkx9gJl2H+Nxhn4R8pR8GS1hMtUFwt61ZTEXqKnAg7p8X2KDOrIUYD59VVm3ZefI9hrr5Chk7DJmfjTkBOCMDEkrUeYh6Yacot4V40mBL5tTxXHkg+g+un9or4peDrgPElVzB/6rqaIKp9Bhiwen4uzD8NC3lV5Obh55UlDtOG5kVCbDSd9rOlQbnj4+BObvvT41kDGAdcb/Tq8ZCaf2n8lRv0Oc++ZGWyWXatJFFzLLl1FyvyTOx33NqO8QE2rDcwWBvVfoNavwJ/CZWDY38acE+so49N08p2G4ZY/7KZhh1BFff9TD5m6HUstQL8lwt01+IpF8tJRsHQR6K7TM55iZ7/7M6KIRKGNnEeKT/b2xDvoJNeYymCf1090uVIx9f1JC25aJL5o4oC8HY4S0Ke3rDgXo5R1nvlwk0U3WvBeR7sJJAbMwNlHH1SI9f5yWmsJJPY8gfwwkoGpcbM3L/Z7ErugYZ3p2r2J9uAvaTJlKD70ky4c5DA6GPpUFbhltu2oqRBnnP5UdpYw9dWn2UAyX0nQs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(19618925003)(2906002)(186003)(55016003)(5660300002)(86362001)(478600001)(64756008)(33656002)(82960400001)(76116006)(66476007)(52536014)(38070700005)(7696005)(66946007)(558084003)(66556008)(41300700001)(9686003)(71200400001)(4270600006)(6506007)(122000001)(8936002)(316002)(91956017)(110136005)(38100700002)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?axdmQpf2qpNr5mG34OIxyk5+hYJXld84KiHbAyHh3MB/cYjH/mdR9Flphdop?=
 =?us-ascii?Q?xSG1L5rSYRApC78nXBnXSUdMoveRE4PKc1ICOSw3msEdW6RDMj3m/5Uu0ssM?=
 =?us-ascii?Q?7OunJhYIjCSCLjKhEs0R2Wm1BbHbxnm3OIT5rJ0QGvZMrFmQDDvG16oqqD52?=
 =?us-ascii?Q?SdGnOA53SMbcqG7p0hGD8YX4Yddkj+lJ/F8ue4bW0uWPbBNZ7PlcIQxNEVtj?=
 =?us-ascii?Q?rNzZBJbf6Sb0Sf5Vs2xkR88p/5sx/znWeBeP8s4ROH0/WgsZ4RtkvYdyETPW?=
 =?us-ascii?Q?f0nV2v8XhyGE1CGXhKPjOv64aiSfTo7JYyJ/l0lJQJYGB2Lx+AIMjhKcViI0?=
 =?us-ascii?Q?mbArERq8vVuHuzz38BFbZ13IgvHHagu54/oWyHKIt0L3mzjOTnngLwDDI5dR?=
 =?us-ascii?Q?dTXT64+cqYOl6KBsLbWAwsk42XizNowBdIQPeG2Y1WQlTjEwAHuIqbqlw49A?=
 =?us-ascii?Q?YXCvWjfuxQRiExM0PZjGDqJghIFlugpWSgalHKt6ZW1tPV7HTPtnk9EQH/S+?=
 =?us-ascii?Q?BcndTyJNAvVwlU2HWerZXIWGLLsaM1zdrs/OJK5Jg2nIqcILWa+yq2XZOTrM?=
 =?us-ascii?Q?8pPpX5i+Z3QNMN75bhzioonVmoYPfkkWnAKVzVt6MoClhu53AuE5YzPDk7/R?=
 =?us-ascii?Q?/H5ZPbJkKKaIKPj2mzJmsqDRDrUEpVPpKIPT5redTpigQ0bMjtUf7vQLWlxx?=
 =?us-ascii?Q?IvfE7IpSz9K/mTPYOdrbr846O2QxlJbaMUExqxuy4etql3tU4r3rgP2vn+cu?=
 =?us-ascii?Q?d1qT304DVNwY0ZufxCnTFiitkFkuf0xWuA71I1kWCdNoYMH4BTnp3cXn03rx?=
 =?us-ascii?Q?Q/SWCRlQxgIRfinVsczegWsqtoQYw1YyUHf5/YQsQdOw+7dTmH3GMabiQwVM?=
 =?us-ascii?Q?704nAQsJ7+FdkCZanc/3QIN21gUE+xzcEVhgH1orI1pucDe7B1TEVom4a/Xk?=
 =?us-ascii?Q?F/wuBMxin/ZUv+s7nBwqprG39+gQk65C3qbB2lNVF6QJTLHhhsqBRODkfY9b?=
 =?us-ascii?Q?cQQh2q38S5yF8XKk0n10/tymzupSCvZoHUD8eVGgZWIbOz07/vtGA7xUTQxB?=
 =?us-ascii?Q?gLUYzLIeUcFkGTg2Satad7PtaRAsM2WW74gTwnVbNtCiY61L8hJRm2jz0tGK?=
 =?us-ascii?Q?9oms4DtTXkqA3fLusnMqpSDcehIxdCmINeavYcGNQvqo/xZhWKeXvlBo2EkC?=
 =?us-ascii?Q?U9yXnOLy79ABWtdglH2MpH+uu5B7jphCR8RoznFCDcQbjwyiUvcyLpLwTnYh?=
 =?us-ascii?Q?gAusMqSbFwKUOoFfHGOrjhszrAbQunq9LwcNeqoqfLrC2zb5iOICP9GIj/Kh?=
 =?us-ascii?Q?uAv+tkqQIU/AVsr3zJWQ907s57lcTdEArzq1cSxXeLCcWU+icXUIeyrJxw1N?=
 =?us-ascii?Q?pTqua/T+xVZSxzaxKMhZl4W1ujfeDFLTzCkzN7uLRuKC6eV8q/vd3R+ltAdU?=
 =?us-ascii?Q?dHTrOURAgugj+Ci322BU+3nh9q335rgajqMIMT7eJDGbp47QxOcG4oVkrMiu?=
 =?us-ascii?Q?948+BCNc8JOJ51dX/BxCk1zRnRd2lMuYXlJSk9eHAZt3oEQaxsoUD/Z1oKi8?=
 =?us-ascii?Q?8z4938u90b/jyyapmrNwHFlYtGrqlfy8zlwzyQqhI8THSf/h5eKFuOhZhAJY?=
 =?us-ascii?Q?lKNzhsLrSMwrMnYerYggMlUHUGNGNy0zbMQ/EoewmeIx4Hkj/4BgdQbTDXNk?=
 =?us-ascii?Q?MCFMGDhg1fORBUXrbk63+HmcJ1Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78cf10c-05a6-43b3-bee2-08da65880b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 11:00:20.0892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yE8x0Pr5fZXGdynFdDXQHQ6h6HuqC+CjqiioR6XXyK0cARmIbML8Aj/8LxowcY36qH8n/ibDnjonY4+l/4BGiFeHX+NgMN8gmB5+9Ghqhxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7300
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

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE1C73D900
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 09:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjFZH7Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 03:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjFZH7X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 03:59:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA34D83;
        Mon, 26 Jun 2023 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687766362; x=1719302362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YBWIgJ78iaABn+KR7a0z1M+8p1fhIQxK+LT8hH0eutw=;
  b=H3vQ4SbD+flKF2h+o8UAiy1I3oEc1hpH2NWv3v4XC34Udz/8NtJCOT1l
   2rE4E2znQ+IbS0/2peiGKxtQCTdrwR4EssluPNj//6YXlzCw7f4ARVynE
   +E7tfRaALuL+Qj3VYjCLJUrTdAvcyxGu6+MOSLF8NtH8T8gaqAQPUK0+h
   UjjyFShymAVHp2yKUYIjPD8F9eaJYW/pFLG4VD+K0GhXl1V8EtIYDSwYu
   bCb0v4ixfhCjvvXXg2O1Z+uD/8foa4PNV+KQOt/nRWKgcBt+YSntzNJjZ
   D7fxlsoUoq6/N1R4V5kEZJmorRs3zudxFAdDumYviMT0+6L24TWHT/05/
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684771200"; 
   d="scan'208";a="236853222"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2023 15:59:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4Qvqcbkkj5QyIq/6OnRuzI3/fjpQGHj5YUUlrLe06RQ29MlMUAw6YAFe/zPPNJ8YnkTqUXuFUaMd+J9cwM7aAdtW6jID0bhgyMsV4mPrezY1QJByfU/NKyDHEEPpq6k3MJ/lgwPkk2mG9aPJIqiN2Wvss4tTCKi0S6gMcW0w5/vL3RKJrxvnf0K1vWLBxgE+O6fFyBujfmIvQMpGfliBQbAShaoBFhrhLTwy/JcGW3J5XhYIZW63Rr4K0nUny3S4nz0dRGqvKIEIaH7/30TgXcmdmrAXQH+ojykdEgo3YLuiSCyKTX++ztIYhHh38GBamCtFIsD7CgxnEkaXy8ObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzbBl546rkaCH9E+SREHNwP+8/xiZVDOVraH8t039Nw=;
 b=RwKUv8L746ptDRfoIS1xQsDIiCltl7XpwTVMRoEe+6z3lToqadaZ6ABvos9R27CTx+bhqq8UR5YSCtDR2gUMB8j6K5ZcXkDCnKySmWuO8T5jMB5fAPuqHurOuMOp0UUMFSQGWtM0MVYSete9c+Rl5tua4xmOx1eYKqHBMcU5YI+vMqbrJD7Zkmc9j1RSJD8kTFW8cXCW7iFxxBTdPUcImx/xQclpAUxYnENBPYcW4F0dh8THeMkN/XiEbKpMq30YFr1JUr17L+2KrMb8wxQxNqdSmdJmLXhYzJeuwrdSk613Q5CL2UFru3v2mt0dIsAz3OGWbF9YhPT3jwSkz0hdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzbBl546rkaCH9E+SREHNwP+8/xiZVDOVraH8t039Nw=;
 b=Pk+k8I9h+6ZFiEW/mZoi8wSuBbwwaerSw6Fe68MMMi7HXHAU3AbNlDJkqlIZN4mjTzLTAFyK+8aj0YeCJWBrTD3svhpZH5ccV/gx5Ra047ueybEDSWCVN8Ydd+yX2/cNqMBcuLDKOJqxCBsa+f3gqHR+FH4SI9TNO93cYW2UyKA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY1PR04MB8653.namprd04.prod.outlook.com (2603:10b6:a03:525::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 26 Jun
 2023 07:59:18 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 07:59:17 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
CC:     Chris Mason <clm@fb.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/26] btrfs: zoned: use array_size
Thread-Topic: [PATCH 12/26] btrfs: zoned: use array_size
Thread-Index: AQHZphizIhRB2GmehkeoJCxF7dG1za+cvAMA
Date:   Mon, 26 Jun 2023 07:59:16 +0000
Message-ID: <7aufdhkqug3bvwlgl727k3ga2mnu3lcgyj3enkl3kjub235q75@rjfmkktmpsi2>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-13-Julia.Lawall@inria.fr>
In-Reply-To: <20230623211457.102544-13-Julia.Lawall@inria.fr>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BY1PR04MB8653:EE_
x-ms-office365-filtering-correlation-id: 21ac846f-0918-4e70-4a05-08db761b3d73
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iPLyaFuTQ1Yf8N87rvXwqRolQRlUFx06G91G5slGxvsoJSm/vHIkR89ji8wMQA+32RKegLYKIova/yKXdCRDjJGLojh1d5ZhEZWmkOd64IyCLyVk3CvOQiYJ0ZfaHR23vjm1ulWr0bkFQuRl/XtWykbzT/Exh2yedNo/sgdjMJDzMcC+8/zFX8ziH6JLbkPbGQqmkMQxrqF5ZECjBIX+aPOyomxnjGylchT3b66dh4QpeOvA2dcJW1xaZf95cwS3tkgZgnhlHhbDr4fo+b+l78DMbDOgmc23hkZ3fJGJdzr8LEeNC59CPba9TkBx/NOr8gyFBhS8f2eFiXdUePiMscHQEUF1qpV7bB2myQCQbaZaKNUZu/0VOU/0kMX2I47d+sdvaqTfj+JSVCUmAFt8IOSuGoEtBqC/HqIS4lguGSCefygnJwBdpE4FV9sishOloKLp/9zTLoH33O47vj9RQl5mbKm/KJcSv+MXSQtvgAdGd9yzmUsLo/28AyM+wmhNbN1PJNE9Tr8YUFjm/GBLLR9sXY2+JzPtXpAaMdZ/JYq4lXEAk5UJaVybMbgi9t1oV6Js95Gbn0YUJhEv9llM/okgEE6L3c1X/fSYxwpDwEnLEf0WApbFmeHAxns8yk5J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(478600001)(6486002)(71200400001)(91956017)(54906003)(76116006)(9686003)(6512007)(6506007)(26005)(186003)(66946007)(4744005)(2906002)(33716001)(41300700001)(316002)(4326008)(66446008)(66476007)(66556008)(6916009)(5660300002)(8676002)(64756008)(8936002)(122000001)(82960400001)(38100700002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BDe7/ibnyW+UG8ejJIrriPAgZBfR16iv+z9vqhQ4DTvt64lFq76JBW2+YSVw?=
 =?us-ascii?Q?LA3G37QI6Q4VTEi/WNvaDUzf61leJs8mefs8x0k7hF9OfO3+YkISlKhUlk9k?=
 =?us-ascii?Q?HHeX5u/hLBBkQb5qym22K7DoNHeGQXurjs7xNq2kqZGelw2ITr3MmIxWnCd+?=
 =?us-ascii?Q?A7sBkB+IDxqpNU+uFH772NqMvUcoo2FVUg7nTgdQM9hWLknWfv4sng/GMhSs?=
 =?us-ascii?Q?vCe9t/axzNKAid7zP7RlrEs5DXnC/zrB+oZpp68WqYGTTkjaHTDc/851phi0?=
 =?us-ascii?Q?N5tAI7wvw+aAKIGpnZbV7MR3ZSe0u83peB+xp6xhubvaS3QC4+s+y382BQqL?=
 =?us-ascii?Q?tPBbfAgqa7FdpMTQQH9Iw3PL2UDIEWt4+q81OIp4PQRyJlHyRdgTcJus/YV4?=
 =?us-ascii?Q?04GBIiEvk2HEK7bTcxiJNMBNOzS/ZDOr72rcJpdYk1xWrWYxDJ8VZR2NN4Pa?=
 =?us-ascii?Q?s2Lk5/vRQdh5bM4SarZDDoKqM/FMBe+g3TAyrU7Dw1jiwNFtZL8XIXV+iJSL?=
 =?us-ascii?Q?XLo1nJpWZDAePUYrzI1TvGdlWrzrZyIByfttEzCMtnnrySJWU6hD0MGLWp7Y?=
 =?us-ascii?Q?yhtN5UDOV7n9CQ79v851tH6n2H7Ha9Dkygr7x1yMZeRbEsK/tPhqPTk/iCTU?=
 =?us-ascii?Q?w4U116g0DQ5rUZlOE7ldg9cqkGlKT96eaMaELt61fk0bnixeSDWmVxBIO2x+?=
 =?us-ascii?Q?mDMqcdbKOnMOWJdriqlBs/huTPJ8JbSP7F5AVOqyHawVfno0ezeQlV76aace?=
 =?us-ascii?Q?VmBDRIWR44zWRlMF3Pmo2YVffraWUjJj5/oBJeJXbUJNEoMx3EJP6c0zGVE+?=
 =?us-ascii?Q?8WdLiqVv+z0bFiDiZlDC/5JsHmhLzkByPQ9BfFtB7NE72hygk9tMEzAY5/ow?=
 =?us-ascii?Q?6T1NzZprNPo53kqNMY4pVm9vE7NWOkfgv4pBu35jqpvOxQd1G7jDgoFrPrTf?=
 =?us-ascii?Q?WG96ZzZ+5Vm0Q0oETKc4rcgQegmLUoNnMJJO3m0K8vIEQC6Ph5eCWKRFIbAW?=
 =?us-ascii?Q?44HwfN1eat1iY0Ghf+XcKJpZ2Omrb690AZ/N5Id8HE1FQd3d7Lq14aFy1ftp?=
 =?us-ascii?Q?pe8bbhTbwveWaYuN/w2jXXRPIZnDPFyK0ypjByf7zgjChGqWczrVHy17y+M/?=
 =?us-ascii?Q?Zpkc/Mcood1OFwgIL09rwqFYMwDjCQ5FKae/R7UyQ/ktCHHJYUPBPywJHDvD?=
 =?us-ascii?Q?VdiBnBiOAN52rzHeOxvi2B89jd1Siza6LfEjlNiJf8J3i2jbnVYhpTC9B42y?=
 =?us-ascii?Q?ViWGCir9qqjddCt6HJaMQ3IJIfUJ6AJrblyZa2bghB60zshSIHh2iAGGtmAX?=
 =?us-ascii?Q?0lIpk9JqNl7TiapPReAzhKq1K5J4N7RQjpnQmzUqr5OGuXnn5rrdv4CMP2cE?=
 =?us-ascii?Q?VxbXzmsLAdBoixOozY9z0eN0KbJIuAJGIC6mx7/mfcusjyp/jA5HmrtxUOJ4?=
 =?us-ascii?Q?CgitJ9PGhIBsniainSZGo6N8wOT5lYBv/Gu/YLxI09ZVSgr1wf9Zo465vvwI?=
 =?us-ascii?Q?KE1PPfSYvxP3w1S0u3g837EHulmT0xdBFszHQ4u8nNWZ1Z9S5zw/KGUCrTOO?=
 =?us-ascii?Q?3KG0flRsQX8f9wrYyUFQJ0Z5ZoqiPLYre0oxitHayhD92R8vX2TNruc8IkQz?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <422ADA48925B7544A9611B225B7B9424@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: coMbvYZKhd+OxeJfR9+ag8niNopGsclEhVCodgJgyfbwuG3QZxuqPUKZclk/tg+MUqAxcUMTUMFBSfK5CQ4Lvt0eRvHymJL9dKsYpS042i0loDMs+rTt+zbp9E5QmKPBFoqwozQnOp/kQoL3FwMbTBg+Zxfio7NQWEmiwohTO8j0Kl723mMmZ+NJjEgH7bemmxfLNklzMrLq49pMC1qEpqAHtBD3PtfYBm7c2smGD30ekRkBObws+h/4Kd9UULzIIoXRV5hzEkRc/SVDec6vTIufbOv0sYmZunEScR7eytg5eSmc3CTZu1nb9JSkQMR3lAh9JIBwK6j4gYYc/cAr5wt2wnYvpJyz//2lLfy8TSSSzm5gh5Y6srXuc9lNSAgNyE0SP5+TqO8TYu5J5Lz3f4PWqa4eSeiHXhv5eLu4V6AFxvuTTCU13AK+SSH6h+SL5P4RhMW00yG0Eq67f/8fNiz5QkHrwglJKEk6XJgkHyCsijGqKUqaB1BcUfjfu/er+DqaD3aFh4kFHGKJD3Av5XRHcL+nK/Ns+3Mgk3NtUyphOW/frONVFYF7GdxOpK/SnR4lJmdjGjitoLd6/6/3ucDS+VmqM/mV5yUtSCo7zs22s/psVgzY+W/pCgLmD7xmz8iJ2K7Hh9GfX0fYB3SEqevhxdBfKN+85Cy3Sm8e6l3DIJNk+spJxk8vXHgtlFHV3idmBEGzX9Dw46lZb7l6mB7Q0QmSDpuTTgpPM27R2cUZeIa9jg2J17U6J2xyST+chx9cd9dQ3ebYY4klxJpj2CXd+a++P5I1gORpARhobxMJQzhBhW+TF3svJH0I8Tdq1R8UQX6kt/7wmDwcRSTD766Isz4kKnkdjtQOGpfXl69ofm3iud1tlbnsjaWhvNJSOahrJq6io+vrFEWp2iIrX2D6g/QOf2mP80X/RIgIYZY=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ac846f-0918-4e70-4a05-08db761b3d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 07:59:17.0118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y40bxuOdv2RhSRIuGcZ5VuxuyDY4BoRFZKmuw1GZngtKfej3E/45BV5wKrkROdfxrEDSGT7TdLCdsjoUvIeTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8653
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 23, 2023 at 11:14:43PM +0200, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
>=20
> The changes were done using the following Coccinelle semantic patch:
>=20
> // <smpl>
> @@
>     size_t e1,e2;
>     expression COUNT;
>     identifier alloc =3D {vmalloc,vzalloc,kvmalloc,kvzalloc};
> @@
>=20
> (
>       alloc(
> -           (e1) * (e2)
> +           array_size(e1, e2)
>       ,...)
> |
>       alloc(
> -           (e1) * (COUNT)
> +           array_size(COUNT, e1)
>       ,...)
> )
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Looks good.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

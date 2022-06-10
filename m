Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CC3546328
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346772AbiFJKHP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 06:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbiFJKHO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 06:07:14 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9AB7164
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 03:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654855631; x=1686391631;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sxya8K52Q4xaEPKDQ5tegteUkagOUiFFapUvdoAcTUk=;
  b=KqoN/+DqXU8ai4o5Ny2wbBgXuHIg17RH3/DMlSz7nLq1Iq31pnFKFj1g
   NuTnezioSuNY9YsLyDTDZhuqifFUSCZ5ORj/8Dk22AVvN10jwHJEZlGgq
   SYmyWxOF98w8JptJaz0BR2jXS8JhHI1lGygGfgsWoVTTW8vVR1un5GORN
   BWWdNjGj0r5GXHgJlbMmthCSbOK3loeH/eOYF6If0xrxKksFSHl/PDY9o
   Ax1s72ac/wnpYZwupKfPrJQRQfJCv3HFMqwymj8v+CwhhPiem0MQo+Nv3
   yt0cUTp99L26GHrd8aXrkMz0dVNWnuKsKdpnmRCe8plj/M8MAf2/7rePS
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647273600"; 
   d="scan'208";a="202792854"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2022 18:07:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKsh2mmKdmX/TXBFQY9DlgF9n0wLM8bWCxs7d+ZHPXgnxrWKQFEsHeaHTDBzUHk/dKXsXbPtyVF2wNQhl/PL29utY2cKLG3k7j4kb8Eq1UhIrlITtZLActYoPmQ2Jxat5ZNqmgfFW7IYvsqgXUlWCW8VlkPQypy0ye9n3bqqKYdJZuItu3gSQghx3UwXpHgbJ0grlIheXjRW4O787XT08HShZmnlIWj9lPzRNNjBeNtxm16/EpcVYUUN2fMHZ7PxDi1nH5Z+8DM7kMLqLKtU3/ezbfqEThk7NpL47BXDuos9X9aNajMKoJTxDmvD8Fm4ew3FY2Fc5OqqTsBy8wFbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osSenwR15OjINrdBy5Fle7ViDO2ZHwNqDadQR6AP6OU=;
 b=RJkVn4+FcZ5TR0u/wdp4xAueshJN8RtIHRYAb9MH4nHYL0SgmkOEcgScs76Ms4wT5/59OpHYLDFTczaUa7uhfyzPhXGsqhjD+PoxZxK1yziD96H0avraxdmSEyGYn5husJAGl+IabZkS+WUWLKyklAlsB6IhObwOzLWEA/Ittb4xlG4npblyxY7WAkA+F8MXkC/GBAQjn8oalGXP2qfKBDOZXf2zoHUJ7N8MSNJcQjOtglj2TdM+mhGWXNBt6W5p5MSPFqQE11xr+QV85N0jk5/6YZg0MTeucVhYSS4i3AGvGkgr18EzTe3/DNkL+uFQU4OObYMNmRQC81SY5CVAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osSenwR15OjINrdBy5Fle7ViDO2ZHwNqDadQR6AP6OU=;
 b=zgbyArmrs1nf1ijV4dL+//O/HOC+m5IOJk7hD/JOzPaEYZkdmApoFPvlnv3dtonmbbLRd9TM4OwgSnewICIpccHKtLJ4+NAG6TEbKpwBLV2JyeYD5vRdUh7DD1l2jQpxH8bOQzridpEua3nmxZ2i63BPEa+gRyuKXK/4QMTjlvU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB1095.namprd04.prod.outlook.com (2603:10b6:910:51::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Fri, 10 Jun
 2022 10:07:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 10:07:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add tracepoints for ordered extents
Thread-Topic: [PATCH] btrfs: add tracepoints for ordered extents
Thread-Index: AQHYfB3rWxKsETCNf0GExxwEPlz+qw==
Date:   Fri, 10 Jun 2022 10:07:09 +0000
Message-ID: <PH0PR04MB7416CC44514F9954E39207249BA69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <6bd882fd0562b8b18600629f7d0504f98c560dcf.1654792073.git.johannes.thumshirn@wdc.com>
 <2d623799-53ca-7c20-0433-c455683c5e83@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95481379-fbcb-4e90-b216-08da4ac8fafc
x-ms-traffictypediagnostic: CY4PR04MB1095:EE_
x-microsoft-antispam-prvs: <CY4PR04MB10956D65C69E7B6DB0B683619BA69@CY4PR04MB1095.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ftCJTCUky4IXlFsHALgpaKzpeNihxnARpJXqVBFKQ25BqA9HdsAjfZdvdTZI+hPVlYCXMtbIIlqG6TmJZuVSksviAjoATvA2v/nguqn+9cGE7Fa2MjT8FEcsOeg86GpoZQGZe81sG7e/T8u58jPhJF9jJ03zvxdbqg5QtYl3OdypjZ0U/nZrD32FU6fpY18K84sqaZYzNVfvY6PnAZSFKDsct3zqutGeUrOZYl2/1tUoMOCjNzikdAohA9n7Ln6G+T7N2Nv+ythcnaLwGClzix5DJespRmtp/cURrGoY/lF1mqrsr83we8jB8od+x72anZcIb2g3Okuk1Xk8atRGMxpKmuVEHpMFRGnTbys5r83LWOta1uQ3XP4h7Q1BqE1WrwPuxy9j4SjJgXkh9d7XY6Z7QqkwpON8wDpWnozLxMg0uxbQy8Db8CAVbDXskPlWvWFRrCJl3T/URbYijxqAnC+3J3YFFuhLCSHL+qRzx74RRZqjRhKflDXV0gEe2H9I5gweAbDJBC7PGSK2lxMp+WSOAhMuYi2q06ZDDgsnwfhMyKlXJOr8naHX9sBiITLdTC5ogOdalUGdsXDm4ldrgqmAL+mO+ho6MCRq4JjnHZ85ld065KJgKpyQFUxoCBrGDakSZ7xppAOXxrifcgaaTNvV0fImD4SJe+IoZuCHuIyYc2K2V6Vbi2JP3/Aeu+T+wsR1zetIV9RGxjVuDcUCrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(38070700005)(38100700002)(52536014)(83380400001)(82960400001)(33656002)(122000001)(71200400001)(66946007)(66446008)(5660300002)(91956017)(76116006)(64756008)(66476007)(86362001)(7696005)(4744005)(4326008)(2906002)(186003)(110136005)(55016003)(316002)(9686003)(53546011)(8676002)(66556008)(508600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mDUqxx/xJWk94GXDDXkYdPxWXu9TarmMPm6MGBSakuipQPjJ+VbkkqNllnqM?=
 =?us-ascii?Q?TluqwObk29ti0/EH+Mhr2y930zIMHtBZYjqJAV55gcDnM+oXzxcMizG4ejSb?=
 =?us-ascii?Q?dBkVV3m9R5m7XoJHEgWY2UOxWj1U8nyN24m9fZxDG6Ta2MGZotUyR3Sbt1gD?=
 =?us-ascii?Q?aNQTi+TposVm5ZoezumHp5z7CbSZURaWJiVnQHnlcSt2BaaE7N/OZKXafKFQ?=
 =?us-ascii?Q?nJPafTwxsyRc3eosTODkhFRrFQmWUPPJSCs8/x1J07r5OaLJCcRLnSvU7TIE?=
 =?us-ascii?Q?Dc7YeB+/Z2Q5P67P/5qtM4W+rzs+w/uDbAwvy7f/NRthk0NzvFjZEJzOI0bn?=
 =?us-ascii?Q?VpFtDP7cMO1U9EwuxZJFN8ty/t5/NeMUrhEaHleNC9tdy7TYNEdWN35ybnzu?=
 =?us-ascii?Q?oxg3THtkmYH0Mw74oSq8T2wJwMas/vQ1ajxlolqcHXdqyZc5soyd9aOZISao?=
 =?us-ascii?Q?w3s8PM1pLVsb6Cr6MNjeX+qt9oMMsH9+cyP2WvYy3TboLYluZPUfcKYw6FgB?=
 =?us-ascii?Q?EkRnPWb3nEkCSObN4z6ajqIfKibbh24R3ju9zPoEu3asImIQFmbIRQdDP6pu?=
 =?us-ascii?Q?D8UeAdosBnQu4fFu9ZIZDa6OKA/o1D0S/lt0Z/NNRY6g6dzVEewdXxjBYPR8?=
 =?us-ascii?Q?j75ILgiqEgH0ozvYNVOjCZaZrKOeRK2apH8vyStruwIrWaq5U9hG+OVIqBNk?=
 =?us-ascii?Q?ajIc57IBpqWHf1cU9biF88uolBFjXfSRj+hdNwpxK8qPQPvCh9IMhLyDW9OK?=
 =?us-ascii?Q?l7bSdE4tt9i/c6P5Gh/LGRTXQ0cnRmTJEjk47RTF34dSvO6bIb7clZ98fDrx?=
 =?us-ascii?Q?VszkSY5get2/1WhTyoLHVhOVt1BoammKig3ebkJB1nRDgOF012S++DCz1TJr?=
 =?us-ascii?Q?+JArFmwlICIvh5vuWZxI4OWKbsjPMnUn9F4hyPNaw+8DecDLZFctleA+R6wa?=
 =?us-ascii?Q?H8StDk4YwKg+5upL+dLkmuMkjqFaw5nMyAZdAAH6UPRclQouT8iTmUIuKozq?=
 =?us-ascii?Q?caauL8Z+ZEGIE3bgiWPWnkzTKauucP0BIiqIpoBEnxxVFw9WJ0dvHuA1G6E/?=
 =?us-ascii?Q?DCSrwmXbaMnlZ9w6aD8CoYQN2NhhQfdNWrb2RaWk7IWqbfdDqueo3P4peFzO?=
 =?us-ascii?Q?49ACunM9HHPrmPXGbf+zkX1qgyZlYatmH7rJ9hFxH71neCY3qToTw4cR50uE?=
 =?us-ascii?Q?GZkvKIUaPR+z3c0jXttCHI4bHDHO3J/ccwpKIR36RF92pniRwq81bYs627i+?=
 =?us-ascii?Q?BRMHXD/EzOSLIAHngeMVDvJJgtK1yBEMsRcesbr/A+5/v16chrdZVaA68KjT?=
 =?us-ascii?Q?BlUmzc4P+S3c33CPipR1Ml7tZJyAI/hQ/LPybVrgehsdFAMzgag4nOQ8nNN4?=
 =?us-ascii?Q?yMiWLsahyEcJydaIPEEnZxHYYgatNBqRZAGHgAWIqoi1rO+Fa7x2P3EUdEyZ?=
 =?us-ascii?Q?BVAlPRcb1eJSJonQ6R5MNIojORmsSR9n2VrZmtYTTE+4m+Rp/80/nZsigCCD?=
 =?us-ascii?Q?VKQISsho9nhBMIciNcZfjxLaro48OExfYzW/otNIbtDWV1aswm57qH2WQ36W?=
 =?us-ascii?Q?oSTnxYEhgd3xVI2BWatHfkS501ysiYblR+vV72ZWUxv25GGrdgicwo5qhfNY?=
 =?us-ascii?Q?W6QK1cXS5o1+8T3GhQL2PGcZkgDXbnpeb0px1w5F2Ayvv1W0Jm+TAbjfuv3Z?=
 =?us-ascii?Q?Z7Q4JTZToj5dVdaCK38ZdIyjZsU0FrKfdrJCAZlVPqMQV9LV+rN81PtkzVh8?=
 =?us-ascii?Q?NhGHx/w5guHRFjJjh2hFxqEAl1m4zPOJn5Tn5z9c2iqm+zNRkpKQxSL2pYdb?=
x-ms-exchange-antispam-messagedata-1: sBCxstL4ZRkvIpVlnUdKMyC0ShRgk8KyX0HI3NHDUwkniCyd7knZ56D/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95481379-fbcb-4e90-b216-08da4ac8fafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 10:07:09.0488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rsbZtuRTd8P2RWvkG6Dr2XjqCTTB/B63ZMu6Ju29d8gV8oL82N6ezKMBjY8nbz65AE00SI8/3Q/7h8se2+ILjSpIOjc0YKN1wMRxiU8/0xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1095
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10.06.22 11:17, Qu Wenruo wrote:=0A=
>> +	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);=0A=
> =0A=
> I guess this doesn't have all the info for this split event?=0A=
> Like pre/post values?=0A=
> =0A=
> Although we will call clone_ordered_extent() which will call=0A=
> btrfs_add_ordered_extent() and trigger the event for add.=0A=
> =0A=
> It still doesn't really show the pre/post values directly.=0A=
> =0A=
=0A=
Yup, unfortunately you need to do the math on your own.=0A=
=0A=
> Is there better way to just add extra members for the existing trace=0A=
> event class?=0A=
> If not, I guess that's all what we can do right now...=0A=
> =0A=
=0A=
Not that I know of, hence why I had to do it this way.=0A=

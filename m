Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C3747A556
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Dec 2021 08:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhLTHVH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 02:21:07 -0500
Received: from mail-me3aus01on2066.outbound.protection.outlook.com ([40.107.108.66]:41951
        "EHLO AUS01-ME3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234251AbhLTHVG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 02:21:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZzJLEffjpMhAnG8j4FM8733vohXyrpWsIeL3wD7vtI+DyfqCW6xMDb9yKtkhDQTVeM63QveCBsX3e2s1n8WtPpCHHgKn2JaEQHCmvzQ8vnl1Q+ajirCkO0tGHwATPEkXNJm8Er3GXoywbhBLZQin3s0204Nk27DyTYX9jTC5bPLWumN9XODAygwRnTsn4XvljSoUZzCqIZvBy6RXBx1cKdS4BiPeK5x/vQHQOh3AWQGoW8GZ+hyGQhEj47JLmuojWdUsR7qb46VuR5AWSHC5Gfi2ElDI0BnwEGFSzP67rQIH4P0vD4MEwhIOn2zfevcU5xRmNVOTHi59SoSXTDmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCKRyEgH3dtLzDbdlUfKnBe3hEgy/xW2VksHI0O+x7s=;
 b=d2SMCHlZhpEoQpQYpIK+HguKpD7K7x5U6xIUQyoNnsqORrDL7UUFh5pvWZiW0YY0bAEMhg45zvLvS9wv4o29lfeI5pwwbtHRk3pQc5J+jFe7n20YYswOpiawx/eydXgerRNR2ihQfbdwNaIhpLCB6AKIr8DwGheKel9n94htrtrfXZ1sZcdYj/YbO2VHE2pkw3QHOVnQ6/wkC/ms6vtHstSZrPKv+moXip5ne0pHfU/1yVAM+MKpIgxXsfjQlWVh8Fm0+Wks2cupnytztszPYP7+H+d/UedKEL2DEjmPsN0uBfFuVYS23qPT2bAI8jva4xo6wlV7iVfpFfF+PtxjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCKRyEgH3dtLzDbdlUfKnBe3hEgy/xW2VksHI0O+x7s=;
 b=rNCcGvGDlk3VZOtNpNxEjiPOcvYd0/rqX7eKLEzyShT1FQka70OP6R4xZBpq/mFUxnZ0glWzKwkLmwuoWdC7BmBHe9+wzrTAuLGdsjvstcVW5/TRB2LMwFg7EWr+MvJAck863PuXd6nNrO3WmJ5LOPUluPVI7KwTUVn81BwjOW8=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SYXPR01MB0656.ausprd01.prod.outlook.com (2603:10c6:0:e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.15; Mon, 20 Dec 2021 07:21:02 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c%6]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 07:21:02 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Unexpected behaviour(s) when moving a filesystem
Thread-Topic: Unexpected behaviour(s) when moving a filesystem
Thread-Index: Adf1ceX7GW+PKTnDT+6go3Dwaa8qOA==
Date:   Mon, 20 Dec 2021 07:21:02 +0000
Message-ID: <SYXPR01MB191829975D48C8CE863888A19E7B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4286c09-5c1e-4dd0-fc92-08d9c3894781
x-ms-traffictypediagnostic: SYXPR01MB0656:EE_
x-microsoft-antispam-prvs: <SYXPR01MB06566CC7EC48EDF3D6BF8EAE9E7B9@SYXPR01MB0656.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBgwnj2MVIko8cpLu9PyeQzGFrZ2UNN5YFLQ+U+a9UFR6A6AkIJsXh7MY8ORDtGmMHsspmnbbK/i3/gH9xaMiUQElE02aJJEgHnmNv9vp5kFSPgi31uGZuLvffkYn/d4WykRkImRThKD9FIOTFkZQPGBfHak+ydzqLuC7ZHZjcY8Waf5zH9E5pva5zmPTQUETmFTN308GHj3bght/M12r7rUzvQOaWIBXPDQ11v9CSp6kYwvfvHMsfTL5twAbmFhTAncFuRZGiXa34/zdb9SR2YrKnIeZ9d8+sm7u43iOao3ArTtjGN9JX8dM0aZTkCWG5WlL8BXQzxI0uROovRDkKJmIEVRPJygmBR3Isvz8keCZtPe397UTgDcBgohjV0JrhXjzTfm0Py3LOSZ0YYZOou6QOBn6wTEIH459Hx7wGg/+dDI+1JUM+zakYqGHh8IaiK9RPGV4r5XErK+GxE+FnJvPb9YrZsg5gZ7ZxY2JyXDEDolmGqPgSQgQ4D8xg5SEftPaxUBSF4n2h05ooY7+P+1OqDw8tbMV1kXOYakDNfQ6QDURaxu6Am+UXKYPBSGC23EvgOVpAWnzcPPzUvys85znwtz8jYnxsX3qjYFKfenyixp5H+HOv3ynuAsuGsIVYUFRnedJ6LAYEP7JQTJhz7PHb2xhQfx02LpMyALeE/Ah2xdJpXMMH9JXK4ftA46sXWEML8SRHo4jxbQfjeyxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(39830400003)(346002)(136003)(38100700002)(2906002)(55016003)(8936002)(122000001)(86362001)(9686003)(186003)(8676002)(52536014)(508600001)(7696005)(66946007)(66556008)(64756008)(38070700005)(76116006)(66476007)(26005)(66446008)(316002)(33656002)(6506007)(71200400001)(83380400001)(6916009)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b5wmK+rfUKN//yfqvReyORyEqYMdTfdHmHbO6wGvkhrVLkS7blhRbEPIXfJU?=
 =?us-ascii?Q?MjK324Ll04ohXU0C0+fCOf5WbvygeSS07bPH9zMX26qH9A9ZrdnGDHFc+ScX?=
 =?us-ascii?Q?vkQIwraBafGnWFrNIbQ4UWw/DnHBJYdQv19rqPv/B6MaCjC4AN6uymxywCrt?=
 =?us-ascii?Q?fNsgfujDKD9o8fAVl9pRyWP78zDgm79kpqA9RWw6dKQQXJbBJfGGwtaoxUm0?=
 =?us-ascii?Q?qYW4Ti70/dr7GFjB2efPOGq72X4klAGZYKsc2ECQCLO3NTEg7HKBD+6fP7bW?=
 =?us-ascii?Q?IEe8TqaXnagDvnLXF64DavEeYzPyR7hrHqyctFCd34dZTJGjGl8ZEWdfuR4F?=
 =?us-ascii?Q?jJuy+jKs/3kFbfuKrdUVIjzI2I0A0po2utkV7AOg4QAhouUrl0TD6xNzMq3k?=
 =?us-ascii?Q?hlFXD8ZophsJIHvtnSfVAMJfHHSDDvcnPOC1IuK0zTjLF2SicJ+lVAk8f5ya?=
 =?us-ascii?Q?vkwXaeSodRr4tpqN+cMl8wEwLC7WkYqaGLWVs2fRoC+GZl4GDyn6GedJonqx?=
 =?us-ascii?Q?yFdmd97+Hu0sTRBEucfm6MU39aLdRTZ0K7NHwCd9uuQwq1o5whhb23wbvI9J?=
 =?us-ascii?Q?owgtltzXrKD6zgGq2oua0e1XFs2CjRMhLGVux1ZS/CQtWp6ZGIz+CMwXmi8E?=
 =?us-ascii?Q?6hdibK/+TkQvGNDfC7z8t6ZbgYu2wq3gzXMlb9/JgafMbF/q0dFT6d8s7o9C?=
 =?us-ascii?Q?ePgenMDBCkwpF9vboXzg/6YDWDU5RaUqUxBCGNos7iJRMOwjtO7bnfvuNI6h?=
 =?us-ascii?Q?BeI6aea/G/O5cCIRZz27scfdivrmAzOyf25W7XPTpFLJvL4A0SXNi2jBVWpF?=
 =?us-ascii?Q?hvioHGJ/vt6F/TiXHC5Kf+h0Xflh1lufbGpTRqONpJ9jU8+kv7wn7cdS5MEB?=
 =?us-ascii?Q?MUaqIjLYRgzZScbK6QbYB4dUgkQlG/ozLGj3N7iLfZRNxHvDRzxkrg8OFduH?=
 =?us-ascii?Q?f3iIVxIFYYYpjmJo00CQSdoOoVVfy2vWborkbv6bwNm3zwP/UHdNTLTFfXZ+?=
 =?us-ascii?Q?MQRI5orGnWVERVXJIueLvOBysioa39a1aYt6PSmAamqtLzzhIdPgKvvQgK3T?=
 =?us-ascii?Q?MNaWhncvJL3b1hdVSFRuKWaB1/mtinlQ+P3SSrI29C80mSNx9WlzTlApanSu?=
 =?us-ascii?Q?2EVlg1Z5n3vWusxvweOiMU3fCyelcJVtCCcDQfgqVSu3Ip3O/VksRVuPnJeY?=
 =?us-ascii?Q?IVMv7qS9m/IIo2rRQ+BIePHA/LjZbXi2IsBkxFbkYVjBfsPAHtBmo+Zz5gll?=
 =?us-ascii?Q?slSpSPmEolPoHN38vQq0MC8Jb+1ZxdEhgwG+yPZS7Cc/VjL64LjiO04QKeDQ?=
 =?us-ascii?Q?kDbcnAmXx4CTnOMYl5rr61vTZtSVbJ98FT1P04q3Sf1slDMKafnJFUyfxcuJ?=
 =?us-ascii?Q?ADY7CPabAaDBhpKsWDEqELRJFd4jCM8Xc4ZQMucQwJkgFWaRkk69+3jrmi/u?=
 =?us-ascii?Q?JTIYSm2TTdHIb23PYsI7sZOc2GmuX1FRIY6BJM0j6s80DWCp9dxc96Cvtc7H?=
 =?us-ascii?Q?qXKAhz+z97GDviRy90N4ZYD/0cdChnQqiKA10ElXW4SWvbb7HUny0zf2eexD?=
 =?us-ascii?Q?M1y9xt/KqHyy+ZATnot1HdCcthYd3WuJPdhTHHia0nZZoFAB0G6EDQLFa6iP?=
 =?us-ascii?Q?UA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4286c09-5c1e-4dd0-fc92-08d9c3894781
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 07:21:02.5554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nUe912KaD1CtUUSZcvA0YFY+zALyizVXkO4MHdClGoum/V3klcLAbMyvJYolr6NiTVbtBuXEBj7lLRL4pkWYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB0656
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a RAID1 filesystem which I am trying to resize (only one raid copy o=
n a particular disk). Original size is 180G, on the same sized partition. T=
o do this online my plan was to move it to a temp disk, repartition the ori=
ginal, then move it back.=20

Label: 'Root'  uuid: 58d27dbd-7c1e-4ef7-8d43-e93df1537b08
        Total devices 2 FS bytes used 29.86GiB
        devid   17 size 40.00GiB used 34.03GiB path /dev/sda1
        devid   19 size 180.00GiB used 34.03GiB path /dev/sdc1

1st problem:
The temp disk has 40G available, so I tried to resize to fit that. Even tho=
ugh only 31G was used, my first "btrfs fi res 17:40G /" resulted in a RO re=
mount due to out of space. I doubt that is supposed to happen right?
After a reboot I did "btrfs bal start -dusage=3D40 /" followed by resize wh=
ich worked the second time (without deleting anything).

2nd problem:
server ~ # fdisk -l /dev/sdh

Device         Start       End  Sectors Size Type
/dev/sdh1       2048  94373887 94371840  45G Linux filesystem
/dev/sdh2   94373888 115345407 20971520  10G Linux filesystem
/dev/sdh3  115345408 199231487 83886080  40G Linux filesystem

server ~ # btrfs rep start /dev/sda1 /dev/sdh1 /
ERROR: target device smaller than source device (required 195292208640 byte=
s)

I've now resized the devid to 40G which I'm quite sure will fit on a 45G pa=
rtition right? I think the source size check should be against the filesyst=
em size, not the partition size. I'm sure I've done this before without res=
izing the partition, or is my memory wrong? Too bad if it's just a raw disk=
 which can't be resized.

Anyway, I'll just use the much slower add/del method to get the job done. T=
hought the devs might like to know about these slight issues.


Thanks,
Paul.

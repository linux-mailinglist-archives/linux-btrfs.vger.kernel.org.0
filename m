Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30CA4C8A0F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 11:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiCAK4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 05:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiCAK4d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 05:56:33 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0BD8B6D0
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 02:55:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGFYwGNn5pdlsBrwstfkrTpkVOfQMLKH7Twdo79ZRzNIE3W5iSSJUKwixQ/ElEtcZwKTDO93by2diKJH2LK/nK/XfqtyCO4KMfwTORQEC1/exJ/JOGnLld9mcFpYqSdc6a+WJjmV117NJW57MosurZ6HEeV3/UWLyWi/sNWrHxkxxCF76P4sRM+JLbJ0HHsIjNPfK+vb7MUlgNkF8RDSaSw95MrnbQ+t1GTEf49iX1lVYd5GpaVM2vNyKBY6WDvm/oTPxIKarjzH9qeTTM71l28tg0wgNVT4Q/k7nbwUb7epJvW6pVanGMiICFNq6X7KhgGUMCbXCM9baf9cIK6qBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se5So+Qwbph7CHjIWf4ALkDr9tZ0kva6odhgdxSTaPI=;
 b=OSsg/5xQIBW/g/4xi8s5rYw36ewG6+IjFIk9hqCzttov09Gd1yVcFQYvpCdkKyxKn7zUwwbxFlEnB5yKadkbU+t6jin9noVv/Tpsmm6Ge+bFInFCAZEtDYYCK7Pq/CQ9qJ7EU/eQuOKV94NuZmpkkisJaf+/kNRmmGduq8fgMOAQwP5toHNTfH5M9ITRbz8onOj3ULfTxFfLaTsYbh+PvXwlk7X2JYcepdm9qPWzl52rZozvFOsnHJVfcHPRZxBsgHuyXQFz0JANHdVL6OzjzcZsoONR8l31IyYzTvhLBYuKybN+mqOHrx0zAwrxhcpapOoN1L68Q5q3wqBmtDJ+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=profihost.ag; dmarc=pass action=none header.from=profihost.ag;
 dkim=pass header.d=profihost.ag; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bmdo.onmicrosoft.com;
 s=selector2-bmdo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se5So+Qwbph7CHjIWf4ALkDr9tZ0kva6odhgdxSTaPI=;
 b=bpjcmyNRprywdq9ewPkkBYVZrd8UgTPEPlxBLSE/7FHvwYyTCvA/2SycwMNXHYL7FZrUGOHoVM/z0hB1jH27WiB4ibBZg74sOgde9Q4q437DABfbrMbWn4DP3lMVOiv6VRwXjvwYNxJuYnGHMfW+bwSoXC8Jiu3WqXfZqDSVzAI=
Received: from AM0PR08MB3265.eurprd08.prod.outlook.com (2603:10a6:208:56::32)
 by AM4PR0802MB2242.eurprd08.prod.outlook.com (2603:10a6:200:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 10:55:50 +0000
Received: from AM0PR08MB3265.eurprd08.prod.outlook.com
 ([fe80::ed98:1a5c:2ede:8155]) by AM0PR08MB3265.eurprd08.prod.outlook.com
 ([fe80::ed98:1a5c:2ede:8155%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 10:55:50 +0000
From:   Carsten Grommel <c.grommel@profihost.ag>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: AW: How to (attempt to) repair these btrfs errors
Thread-Topic: How to (attempt to) repair these btrfs errors
Thread-Index: AQHYLNKzWsbDNPNvmUqwF5z6etdMhKyqXA4H
Date:   Tue, 1 Mar 2022 10:55:50 +0000
Message-ID: <AM0PR08MB3265280A4F4EF8151DA289F58E029@AM0PR08MB3265.eurprd08.prod.outlook.com>
References: <AM0PR08MB326504D6D0D7D3077A13C7DE8E019@AM0PR08MB3265.eurprd08.prod.outlook.com>
In-Reply-To: <AM0PR08MB326504D6D0D7D3077A13C7DE8E019@AM0PR08MB3265.eurprd08.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 4ae4ba08-06d3-d714-851e-ea8e130db558
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=profihost.ag;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb36cd8c-fed8-471a-238f-08d9fb720c82
x-ms-traffictypediagnostic: AM4PR0802MB2242:EE_
x-microsoft-antispam-prvs: <AM4PR0802MB224257288467A2F2C2A4BA208E029@AM4PR0802MB2242.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 57GRxkqPE8Z7J5vAUBkD1jRY0T8hCQE5HbK8OeK0AcuOKJk5CzIIUn4rruP16Kiogi9AQk5mnyFdDGVRBSfVSZBrMukamldFBYyYB9GWlvIcw21GM3LNa8W1vyHS9c0tfvx+PLrNVerHIJpUDl2F7Q6YoCxB+quEFZqma05bvLI9F5Gj4CKXTI8nyEjKO2ph6wXUwns2xWh3J8Zny8IzUlGPXA+wYIjM/8trTeofNi9BwugCXInLKwOF7tc8OLStMZH2unszkmcuM+/UekdK5oSfdfgGUe8GbdbwX29dwcn5Vgj6w9QvrntvYhogSxmGPLbHZ2T4EzZlndP6kL1BwuQtvhqLVNGoQA8NS+fnQXIiguhs6LDHgZNWu3FKd/ZYlp3+Joi0koNgcZgx5NrHNNn9wMoURPUOpsHkMPvY989WjGVwRJJCKKQff5zUmFIKlPkLNc/HwFx3wkP0xArCeBURgOyn1kz99+Z+sv9nJFJdyE0fPuSXpFKCYy4NE489egq2sijmWgnpDtGInZ5P7Nsiyx3tsN879Xd0KEQXBybo1FLqpDAaQlb1HNe/bdZ0U7YdfG9eM2BOAv1oin/lPVIC1LCQ20S/AFExW+5iu386pFtzBMMW0Rr38C/3X3yWUMfahOiBL7RWnpEFNQTy4So49MzmuJWI/RSgS8EmJ+8tWCEJDEi30DhYEzJp907x8XX2hYyO+Y7FQtTKx6vs+1FM90EjRw+eY1YO5nMh0A+pey5rosTcsdftz6nbQTYQiC5jXL7e2gk+ikOeT2u3SRv9bSuN8v+3AtpnaISIHIfQ+RLKOcW2Ccc1QZZ4hIzDL02fTD5WBhmG0nuaw1Qv7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3265.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(186003)(122000001)(508600001)(38100700002)(52536014)(8936002)(5660300002)(83380400001)(966005)(9686003)(86362001)(7696005)(6506007)(33656002)(76116006)(91956017)(66476007)(64756008)(66446008)(71200400001)(8676002)(66556008)(55016003)(316002)(2906002)(66946007)(38070700005)(10126625002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?vfdKnEsxcODkidrs4l4LdrnX7KxQDg/CbA47Hf9N1wt9a/fYK0R9FoQW?=
 =?Windows-1252?Q?SPDN2fziL7Uxu1zZcvJmdE7RtP8xlDsJs+oEQAzRtUwr8pcGXRrP2VZM?=
 =?Windows-1252?Q?Q5vKO42Q2+r5CL1cX17WNyfbSmbxoSr098gk8wugtbz+gYTbsgOZVdUa?=
 =?Windows-1252?Q?bVC52cF+V5uZoilNoiuA+QY1V/C0AlsNcicRP+TlBvFgreObMp13+kqy?=
 =?Windows-1252?Q?eQfynrVadapUCOQGC8WjPcsQYX2XxOFWf3TH2dLaqDR4JU5WJTC2Tkyk?=
 =?Windows-1252?Q?WZrk03UI1r6UEA2wFjd2OMPzR2chrXT1ofeQfZeMF63xjHS4SOdDFq80?=
 =?Windows-1252?Q?NAQ1js7pSIUUjeQr9BHfx4UCz+EK9BU4STqvbsnRDmPwsCPlezmsLBfs?=
 =?Windows-1252?Q?K0cjLW8M6PPsOoB2EUlM4g8JYhh4pmNwQlHs6t1kjbt8vS0eRxfaadre?=
 =?Windows-1252?Q?NN4DCQqsIDtFs4OLNVKMGiLRDeVmQ6DxEHGpV7cT1BZ9njwzQ2yEyV+s?=
 =?Windows-1252?Q?HLZtRbSC5mIXZKyO+Lf0UK4uNwEyO7ycFNO7d6wpoSFlFiEjWnZNjBdT?=
 =?Windows-1252?Q?Bx2MITjFtLV/LypQPGjr4Y/nGe43kjcE49IKW1wpsKvXRGpunZtADpE1?=
 =?Windows-1252?Q?kW5+J5+V5+bsCSC59B4QFA+k8Haw+zYF/OT1xVxGZ9knwQvJfLTE8827?=
 =?Windows-1252?Q?3lmlG0pGV3bo16212UzonEcZ9IWkq2YcYmxPNfsonwrE/wEcPXdYS5jb?=
 =?Windows-1252?Q?VJS9pD1wa9hxVnorX8bdMZnQOWitwI7KOGoY89e48DSzrmUDu6aC9nxl?=
 =?Windows-1252?Q?+TlzFyR3KVf68pDPL+m3NkgwSk5CF+mnxF1RaWxIi6TY0E1nuMkPLAmJ?=
 =?Windows-1252?Q?LeagdBfoCYP2VhPLfQeOWZKyjK4Jhsdx+FxU5QNCDYg8jKbVMh8zRMaw?=
 =?Windows-1252?Q?WrBuwsI1aSZBugp7PCI0AcIQxq6DrAtCsDsYKo+JqOS4qMzD8mUb5e1S?=
 =?Windows-1252?Q?ITBW4qjgrpcdtHsS0uUM6JGKctNNLQ56OiLsL1Vzfk8CXF01HAy22tgI?=
 =?Windows-1252?Q?5du5MFekzA46T/wBrxHeckRb2Ur3sBN3M2c91dQajCuzHSdQtkzFTXtw?=
 =?Windows-1252?Q?yNUmkH3OlLYBAEYaUXgJAVxfwSg+r6DHOrM+AqWVDwtPm3PgHvLLDjvL?=
 =?Windows-1252?Q?y9FhFnKlHAj8BElcUVopStm0qB+w6XZSljxVaBdp/MGQcRNzG+TbTEK1?=
 =?Windows-1252?Q?Kmb/GP1mA+iIIpUmTTanAR4s/+a2CnT8BWXF/oNVLa+MNHm6o0oYqWt3?=
 =?Windows-1252?Q?HkqlYig6sBUGyOafQOQzTg0+TmcvLGzGRBggNfKPOVpDK0hvfiWSnuYx?=
 =?Windows-1252?Q?DA5fdWPa5PfsWuS3F+oVTmfVxPDGaVtvqtFQZ+SB3rGv3WAgzTY6mBYm?=
 =?Windows-1252?Q?Gf8Z7+8pmGVopiwwjgfL4MkUhuc98v/dZZn1lVBWtxDGYCs4NIb59GOa?=
 =?Windows-1252?Q?EBwBC4sZVq7Yj/4Men+mGES1KIaKU6BCUTk+LeEFvHpklvXf5VES5hMD?=
 =?Windows-1252?Q?+emPPkyxzgrfQ0smYyL35KOCkjJ1MluQQVfuJTz5cRl3iseh01fWIfWA?=
 =?Windows-1252?Q?7O76mB2dcs3aMgNj6cK+kcUA6rxmBx3/bqPVK/wgkVxj1O70lr3Kz+Ak?=
 =?Windows-1252?Q?2RbXKrh6yPe+ra7+bcHfSIlMuCWVHhg+p9fow8d1bG8H7f67MJagKTHt?=
 =?Windows-1252?Q?NF6dWQfaaxaRjBOIpLBoFCM44WKmjGYoIwGMmC9ASUUBT9GHk/LyGgGx?=
 =?Windows-1252?Q?BCn7QQ=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: profihost.ag
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3265.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb36cd8c-fed8-471a-238f-08d9fb720c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 10:55:50.3553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b3201e87-5c43-439a-8fa3-eab13a770d4a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2C7T8EI7yXlQdi8v07SL/04em/jsqWJsuimLbVIRPABRehhitUP+LVA+JrFhTHIC9GbL31V+oWibsWumx106MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2242
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Follow-up pastebin with the most recent errors in dmesg:

https://pastebin.com/4yJJdQPJ

________________________________________
Von: Carsten Grommel
Gesendet: Montag, 28. Februar 2022 19:41
An: linux-btrfs@vger.kernel.org
Betreff: How to (attempt to) repair these btrfs errors

Hi,

short buildup: btrfs filesystem used for storing ceph rbd backups within su=
bvolumes got corrupted.
Underlying 3 RAID 6es, btrfs is mounted on Top as RAID 0 over these Raids f=
or performance ( we have to store massive Data)

Linux cloud8-1550 5.10.93+2-ph #1 SMP Fri Jan 21 07:52:51 UTC 2022 x86_64 G=
NU/Linux

But it was Kernel 5.4.121 before

btrfs --version
btrfs-progs v4.20.1

btrfs fi show
Label: none  uuid: b634a011-28fa-41d7-8d6e-3f68ccb131d0
                Total devices 3 FS bytes used 56.74TiB
                devid    1 size 25.46TiB used 22.70TiB path /dev/sda1
                devid    2 size 25.46TiB used 22.69TiB path /dev/sdb1
                devid    3 size 25.46TiB used 22.70TiB path /dev/sdd1

btrfs fi df /vmbackup/
Data, RAID0: total=3D66.62TiB, used=3D56.45TiB
System, RAID1: total=3D8.00MiB, used=3D4.36MiB
Metadata, RAID1: total=3D750.00GiB, used=3D294.90GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

Attached the dmesg.log, a few dmesg messages following regarding the differ=
ent errors (some informations redacted):

[Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 errs: =
wr 0, rd 0, flush 0, corrupt 69074516, gen 184286

[Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 errs: =
wr 0, rd 0, flush 0, corrupt 69074517, gen 184286

[Mon Feb 28 18:54:23 2022] BTRFS error (device sda1): unable to fixup (regu=
lar) error at logical 776693776384 on dev /dev/sdd1

[Mon Feb 28 18:54:25 2022] scrub_handle_errored_block: 21812 callbacks supp=
ressed

[Mon Feb 28 18:54:31 2022] BTRFS warning (device sda1): checksum error at l=
ogical 777752285184 on dev /dev/sdd1, physical 259607957504, root 108747, i=
node 257, offset 59804737536, length 4096, links 1 (path: cephstorX_vm-XXX-=
disk-X-base.img_1645337735)

I am able to mount the filesystem in read-write mode but accessing specific=
 blocks seems to crash btrfs to remount into read-only
I am currently running a scrub over the filesystem.

The system got rebooted and the fs got remounted 2-3 times. I made the expe=
rience that usually btrfs would and could fix these kinds of errors after a=
 remount, not this time though.

Before I ran =93btrfs check =96repair=94 I would like some advice at how to=
 tackle theses errors.


Kind regards
Carsten Grommel


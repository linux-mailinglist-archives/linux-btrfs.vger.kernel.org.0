Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6394CF25B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 08:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiCGHEa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 02:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiCGHEa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 02:04:30 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130077.outbound.protection.outlook.com [40.107.13.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1605939B
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 23:03:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE56dox6ZQSm1LgNQUAl1JQ2K65EKcdW7LFB/DC6K2Sgo4xG0C6NcxvTvWWlFnpkMezZoj4/9lb7WwPSwURtVTkg7S5uW63kD71GMdWr9i9mw+6qq5P0LJdNeyyMO909IxHXZpXFUzqID9MmJVNe4Nr0m5mcs+ffjp4V2fE6mlmLnHyfE70Ey3l/RxLq8gxSy9o1NmBRZ/tc06zsgpd20rVFZ7HcfIWBCx5MIDCSi4JbQNX33xAkd/juy/945i99v077Abg30RCykvlsK0F+KgVKYTX+trepdIvoH9jvD6J4gt9AoSfNLHtwYfS+sivI8Sin+WSJMxsYbZNpDTmASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51+QoUts75CJqfQ/kvrvQxkGGVOCbJtsaCd3Iq7TggY=;
 b=Kf+GvJVRxkp8RzDvyXq8Xszzt2MiOWzrmgE03C2EpI0fbkWmIAywECyvXnBLfpIKFhLkGCBPUyWIA2E6CFw6V2zHlIKH+IngRSCAm/G4CHB8C+4P0aKaFkZhwzn79PefboaSJxAftCLcGTgrHsHA/pZ30kc5mkvzhzdVQSu5WRKDeuGvukE+r8SBq/PSgDzHF/45OEXVXG/PivhO4sGDUYSjatA+GeDCrESpW3PKqAAXLLVWC6pGskbGqgXNuJiMYOVU91Mxr1gSGpldc5EoZO7UVpO08YLVfpERtsKIUgcfV9v+UdE0wRYWVg5fdYXnPCvPFMjZzOAOoLR10YD4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=profihost.ag; dmarc=pass action=none header.from=profihost.ag;
 dkim=pass header.d=profihost.ag; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bmdo.onmicrosoft.com;
 s=selector2-bmdo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51+QoUts75CJqfQ/kvrvQxkGGVOCbJtsaCd3Iq7TggY=;
 b=UfZgLBqQHJZZ8JSF9GLsTiOAFbQyI+M7XvZb7+ZVBV5nHP7Uh1THUXoCIV0s+SYFSk03YFp/hKXXRhQ25g1g8Rm8oMtyASBy7ITyvGouctFKnJ8D2U5DJHI3qy+jyDvO/hCpUjQzI4MJ0YXmf7vXbJQ6Q6r8yAi1ntcPzojZA+o=
Received: from AM0PR08MB3265.eurprd08.prod.outlook.com (2603:10a6:208:56::32)
 by AS8PR08MB6613.eurprd08.prod.outlook.com (2603:10a6:20b:339::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 07:03:31 +0000
Received: from AM0PR08MB3265.eurprd08.prod.outlook.com
 ([fe80::ed98:1a5c:2ede:8155]) by AM0PR08MB3265.eurprd08.prod.outlook.com
 ([fe80::ed98:1a5c:2ede:8155%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 07:03:30 +0000
From:   Carsten Grommel <c.grommel@profihost.ag>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: AW: How to (attempt to) repair these btrfs errors
Thread-Topic: How to (attempt to) repair these btrfs errors
Thread-Index: AQHYLNKzWsbDNPNvmUqwF5z6etdMhKyqXA4HgAc/oACAAeyr8A==
Date:   Mon, 7 Mar 2022 07:03:30 +0000
Message-ID: <AM0PR08MB3265F930C35B1AFBA7E981B18E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
References: <AM0PR08MB326504D6D0D7D3077A13C7DE8E019@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <AM0PR08MB3265280A4F4EF8151DA289F58E029@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <YiQQOFQO7G4NZTKS@hungrycats.org>
In-Reply-To: <YiQQOFQO7G4NZTKS@hungrycats.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: af353127-9c20-fe5c-1bce-bb88f9d7c449
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=profihost.ag;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fb48f45-51f4-435d-61c4-08da00089633
x-ms-traffictypediagnostic: AS8PR08MB6613:EE_
x-microsoft-antispam-prvs: <AS8PR08MB66139191F6053826880AD18A8E089@AS8PR08MB6613.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4pyM4+zBCMcOVcFzT3zHUH0jVCn1uY153t53k8H50hRrhZmZbDL9wrpk0YmPMhkWGFUIW4sEhcXFOYnHWzGgnGNwwfjwHYoKoQF/GKFAr/p18RUbRIo4F3/IE7suObf41QPHgEjXvExxMgqfojdKvoeJevQDR5jSVdFoBfEgAQQ46Ns62UYiD+t+ilDuyqLhGVeB7YXxMyTyDUXwHLapCdxqPojPGXSjZ1XqjnnZ2/qo7yIWOXx6COuJnqPsvyMWEQJEo8fEUGwEym9zRgq8DLY2Cpvo8qHdlI4618DuJtoI4A/9Rf9tpMewoDwyGcfCDDH03XlNyw+JP9cE+hhnW0btDGvFi1EVBTa8e8yogLqZ0LMIOS4ohX9dg2YN7Z65wYg8W2rRQfzPmlUC31ynv1DRoajhTQ7bx1SBeigApfkavDgYZOb/wB6K7y92oiS88C1SC5ggxS2IZKhGkdyd2OtALLLXsQVd5dIggdqVuoOE86mW2270kCpsevoOpww3kyqez5aLrtuwfAw1m2W09pWQWtDn9lr60sBWbXTuFGctZkKWDovb9D+yssD9lQUII45iF+SNc8q55AlhS4cn9GLiBE6L8GBmAk/TBtnQrajfiMLYtH7cInyoAbcxR1HN1r7rZOMQ5KAxGrPVhDXIcUfDvTItlYdHbqXKndizvFg5DZIXMcFJ1Hd6jU3ati5XVFpCdSOKlnBH4IuZDySRTYbMhFoqIyWUhGThdjnbcS/Bg7yH0hR90eniNdhwrntJGI/0fBUAh61Zb97QpmBQTPntINiX/b/nNQqDE2JpLNzPr1oQPBxmhfoYcBz01goZaPn1IFaVcvrbW2AlBPHtGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3265.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(86362001)(8936002)(2906002)(55016003)(91956017)(5660300002)(4326008)(8676002)(76116006)(66946007)(64756008)(66476007)(66556008)(66446008)(66574015)(122000001)(83380400001)(6916009)(38070700005)(33656002)(316002)(966005)(71200400001)(9686003)(7696005)(6506007)(508600001)(26005)(38100700002)(186003)(10126625002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?m1Qk0REm/sUhdRDT4KerfOo6nDLZ0OfcW5yPdjW/eszam3Gu8wCc1sjm?=
 =?Windows-1252?Q?izSxKVZYuD9osQoXJ3Y37JP/MoJSEwq4my0vQqJGQLjlDx65V1aISMcs?=
 =?Windows-1252?Q?PeAazr2vhuWZPrpGdkDQqxR976DxhBwxt44p91fJE2isqQPdOD0MMsc2?=
 =?Windows-1252?Q?iQ5AQaPU4TCGNQiGtYdlHKceJNr6a/mn7319iGrZlCD58U9xyIaEf93i?=
 =?Windows-1252?Q?DdkCsL91yuFDNadE7I9S0RslDomwvCoYAFJuUfQ1SN9zk/m9pO4oXoio?=
 =?Windows-1252?Q?GPlW+FY0yEYXZ18OpIi+HmXJZqOA1WIsmShy6o5j7Q3svIBpSuJfjHqG?=
 =?Windows-1252?Q?kHBrsnItIS/oVdwf1bNGS/kY48OevZbl3VHPqySvCPDrra3w9PN1p0G0?=
 =?Windows-1252?Q?gDYSO5paxQesUe8IO6Bjn2TkuTQzeYHEOVOgSMACuapX7pdy2yWrBv7L?=
 =?Windows-1252?Q?KZYNjfCsCfuE2EX9lvzFgF3jUf45kFLhJ2GbyRAoAdxPwY9FSe8bbg1Q?=
 =?Windows-1252?Q?PVco9l3KcBO5uWTXO1u2ohS2Ad9vi0saY1TSD7fHmIwlydid909Cs/uH?=
 =?Windows-1252?Q?kB10SMz9W4IymCdi27JA6NU9G8wHdou94MtLhWbu8kKfZE03nYKOuudL?=
 =?Windows-1252?Q?7bUkSrtfgkU8AqckwCl7k0F7u9J6L7c0UMHgdyNwiB1hvQecd7E8Lqse?=
 =?Windows-1252?Q?jVtpUtsztfwj9PFffNKI4DHW7y4E41BYTj+kUCp5rJtsBRbq9udNs/W8?=
 =?Windows-1252?Q?9lUm/6rCNQs2D7GuRW/FzfWuNPOvtwc1peq93qO/ZseRcCz/QjhaHNVv?=
 =?Windows-1252?Q?veYVkpXEsk7Xt85EHRDbT6b3X8ZqlGlWIuypmFx5tXha6AVF5i105OLc?=
 =?Windows-1252?Q?KfqICKhIC2nz2eu3MFJO7kQqBrWW9ATWnmjDN+Wpl++LhxZ2AIPROJeH?=
 =?Windows-1252?Q?qvI0Ssf/GdQU+VZkGrhN+Myc1+GdPq4vTvTKUwjEpj1nKbyWltpkq1dd?=
 =?Windows-1252?Q?L3Xf0PbtqHrTybkMnHwgkeS927b0Ip2sPXEfZaqysFIR9j+gvpDfca91?=
 =?Windows-1252?Q?Xi6mmIUZ61HBRV7ofyrUogYoP3ypgCBzwQjKoAvd8Qzh1p1TZHD0XYUE?=
 =?Windows-1252?Q?ffEOUrrlsZoumzoBWxyjack+ShSJY+lL2KMnbVbS/RoDd7UanxM2qzRf?=
 =?Windows-1252?Q?IU4UGq1+cjhUaOax3YUDRiuMeZJQkDonndyGZ0Z1Dsz5kTUH6YXWXg14?=
 =?Windows-1252?Q?rqsG2xUf4NPtWwSyWROZAQgW4w3Pusd10qUiliF4QKDAFcf80tu0VhYg?=
 =?Windows-1252?Q?GahLjNloD9hJS4PJ3bijlsxaFFXPrcA/Lm9J/A49R2YDuuf+lZYrjR/2?=
 =?Windows-1252?Q?s84kC4Pn+snxC9k1IZFg7EaZ9pRbv0twzNHVz8VsoitzagfOfTi6i1y9?=
 =?Windows-1252?Q?B1fpmNy2Gft/T/Goe/R2FLJg5KLNJY/jWHRQ0OJoGa5yfh2B+Alu3BmH?=
 =?Windows-1252?Q?joOhEgQmzvVDrtwssj8iCPGmpfF1IvomLMQzUOVHHOLCZelQLfGU3L91?=
 =?Windows-1252?Q?2oCblQ4GpWF6f2ow4sbRICbP6zIeeuyYguCTvoN7FZeoyyPzjgz4wFlY?=
 =?Windows-1252?Q?JkRFZJja1SDzbMmfd/KDIF5fYHwLQrv1J+6qWncpWvHSb4Graw5vm4qo?=
 =?Windows-1252?Q?cAetMhigIW7OluQaDAEMpbWc7Itxy/qz4qIOy9I15bjCw7DogECuXA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: profihost.ag
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3265.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb48f45-51f4-435d-61c4-08da00089633
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 07:03:30.5253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b3201e87-5c43-439a-8fa3-eab13a770d4a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWuT8pA/NYwbi8ZKpj7thJFzqmwieGjixJb160keZOtZFt5R9tv0XbAdWfbL5nS58DJx0EK30gmV5eFX2mkMJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6613
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for the answer. We are using space_cache v2:=0A=
=0A=
/dev/sdc1 on /vmbackup type btrfs (rw,noatime,nobarrier,compress-force=3Dzl=
ib:3,ssd_spread,noacl,space_cache=3Dv2,skip_balance,subvolid=3D5,subvol=3D/=
,x-systemd.mount-timeout=3D4h)=0A=
=0A=
>Data is raid0, so data repair is not possible.  Delete all the files=0A=
>that contain corrupt data.=0A=
=0A=
I tried but as soon as I access the broken blocks btrfs fails into readonly=
 so I am kind of in a deadlock there.=0A=
=0A=
>I don't see any errors in these logs that would indicate a metadata issue,=
=0A=
>but huge numbers of messages are suppressed.  Perhaps a log closer=0A=
>to the moment when the filesystem goes read-only will be more useful.=0A=
=0A=
>I would expect that if there are no problems on sda1 or sdb1 then it=0A=
>should be possible to repair the metadata errors on sdd1 by scrubbing=0A=
that device.=0A=
=0A=
I ran a number of scrubs now, at some point it always fails and btrfs remou=
nts into readonly. =0A=
I did not yet try to scrub specifically on sdd though, gonna try that. =0A=
=0A=
Should it remount again i will provide the most recent dmesg's right before=
 it crashes. =0A=
=0A=
________________________________________=0A=
Von: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>=0A=
Gesendet: Sonntag, 6. M=E4rz 2022 02:36=0A=
An: Carsten Grommel=0A=
Cc: linux-btrfs@vger.kernel.org=0A=
Betreff: Re: How to (attempt to) repair these btrfs errors=0A=
=0A=
On Tue, Mar 01, 2022 at 10:55:50AM +0000, Carsten Grommel wrote:=0A=
> Follow-up pastebin with the most recent errors in dmesg:=0A=
>=0A=
> https://pastebin.com/4yJJdQPJ=0A=
=0A=
This seems to have expired.=0A=
=0A=
> ________________________________________=0A=
> Von: Carsten Grommel=0A=
> Gesendet: Montag, 28. Februar 2022 19:41=0A=
> An: linux-btrfs@vger.kernel.org=0A=
> Betreff: How to (attempt to) repair these btrfs errors=0A=
>=0A=
> Hi,=0A=
>=0A=
> short buildup: btrfs filesystem used for storing ceph rbd backups within =
subvolumes got corrupted.=0A=
> Underlying 3 RAID 6es, btrfs is mounted on Top as RAID 0 over these Raids=
 for performance ( we have to store massive Data)=0A=
>=0A=
> Linux cloud8-1550 5.10.93+2-ph #1 SMP Fri Jan 21 07:52:51 UTC 2022 x86_64=
 GNU/Linux=0A=
>=0A=
> But it was Kernel 5.4.121 before=0A=
>=0A=
> btrfs --version=0A=
> btrfs-progs v4.20.1=0A=
>=0A=
> btrfs fi show=0A=
> Label: none  uuid: b634a011-28fa-41d7-8d6e-3f68ccb131d0=0A=
>                 Total devices 3 FS bytes used 56.74TiB=0A=
>                 devid    1 size 25.46TiB used 22.70TiB path /dev/sda1=0A=
>                 devid    2 size 25.46TiB used 22.69TiB path /dev/sdb1=0A=
>                 devid    3 size 25.46TiB used 22.70TiB path /dev/sdd1=0A=
>=0A=
> btrfs fi df /vmbackup/=0A=
> Data, RAID0: total=3D66.62TiB, used=3D56.45TiB=0A=
> System, RAID1: total=3D8.00MiB, used=3D4.36MiB=0A=
> Metadata, RAID1: total=3D750.00GiB, used=3D294.90GiB=0A=
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B=0A=
>=0A=
> Attached the dmesg.log, a few dmesg messages following regarding the diff=
erent errors (some informations redacted):=0A=
>=0A=
> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 errs=
: wr 0, rd 0, flush 0, corrupt 69074516, gen 184286=0A=
>=0A=
> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 errs=
: wr 0, rd 0, flush 0, corrupt 69074517, gen 184286=0A=
>=0A=
> [Mon Feb 28 18:54:23 2022] BTRFS error (device sda1): unable to fixup (re=
gular) error at logical 776693776384 on dev /dev/sdd1=0A=
>=0A=
> [Mon Feb 28 18:54:25 2022] scrub_handle_errored_block: 21812 callbacks su=
ppressed=0A=
>=0A=
> [Mon Feb 28 18:54:31 2022] BTRFS warning (device sda1): checksum error at=
 logical 777752285184 on dev /dev/sdd1, physical 259607957504, root 108747,=
 inode 257, offset 59804737536, length 4096, links 1 (path: cephstorX_vm-XX=
X-disk-X-base.img_1645337735)=0A=
>=0A=
> I am able to mount the filesystem in read-write mode but accessing specif=
ic blocks seems to crash btrfs to remount into read-only=0A=
> I am currently running a scrub over the filesystem.=0A=
>=0A=
> The system got rebooted and the fs got remounted 2-3 times. I made the ex=
perience that usually btrfs would and could fix these kinds of errors after=
 a remount, not this time though.=0A=
>=0A=
> Before I ran =93btrfs check =96repair=94 I would like some advice at how =
to tackle theses errors.=0A=
=0A=
The corruption and generation event counts indicate sdd1 (or one of its=0A=
component devices) was offline for a long time or suffered corruption=0A=
on a large scale.=0A=
=0A=
Data is raid0, so data repair is not possible.  Delete all the files=0A=
that contain corrupt data.=0A=
=0A=
If you are using space_cache=3Dv1, now is a good time to upgrade to=0A=
space_cache=3Dv2.  v1 space cache is stored in the data profile, and it has=
=0A=
likely been corrupted.  btrfs will usually detect and repair corruption=0A=
in space_cache=3Dv1, but there is no need to take any such risk here=0A=
when you can easily use v2 instead (or at least clear the v1 cache).=0A=
=0A=
I don't see any errors in these logs that would indicate a metadata issue,=
=0A=
but huge numbers of messages are suppressed.  Perhaps a log closer=0A=
to the moment when the filesystem goes read-only will be more useful.=0A=
=0A=
I would expect that if there are no problems on sda1 or sdb1 then it=0A=
should be possible to repair the metadata errors on sdd1 by scrubbing=0A=
that device.=0A=
=0A=
> Kind regards=0A=
> Carsten Grommel=0A=
>=0A=

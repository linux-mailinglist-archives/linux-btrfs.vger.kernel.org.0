Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED9B4CE437
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 11:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiCEKgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 05:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCEKgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 05:36:49 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2079.outbound.protection.outlook.com [40.92.99.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3485214F9C
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 02:35:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKHruHXcyeqe6BrkC4jVKDQysWIsqwj3xI9moUlRTjoMYN3gUmrS+QiJ495sGBDyLre864WdPQ4VwsveZDMLxHK7cbv/fHXDE6tO7i6P/CdOEY0z3h8GB0f4U4KyphrvczEtUdyNZXobmcJCwVzmRIaUrLLHTePyg05/Rcpk77QWlzg9dlg6YHveQBxIxI2hSNULRCL8o3fB+fQHKZHZXfXhVCMK/sGfHvELgjeDCrOALlXXdjjrXiS9XNtdK08YcpOZZOoOwiNPprKnZwpb+OxmNy/stTEN4Vqbw8l9lMWoBbXPqPWoVT6TQN8hWjWB7hrYfYK9/qsq+lhLf5sarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+dkYjdpGWLbi/UXqMcV2HTeHcPEFa61ZgtMOy19wZc=;
 b=jYlARBR6x8E9P1tFSXYZ+oLns910+YzMyZeyZFajqFeUSUvcRzIPBib64UqVrwOlvzkNL/TLc8kPkDGNVutXAbNpxwPdECWIoNInWlNTStXGuzi9evyPsmxTY218KZYEf8PSwunOcbPkGyWyf+HLUfe4TZ5twYp6ipJt84IIApOJ/6KlQuBShc6ZuSrSbkCuEIyU7TgGJDQ/TI9yEhaQA7eJUn/yEA/dzi+ClXxNIUx1QYwhCUl/toHS9YTQ4amT2LBzLJv6JBbyKBXC1uLPkEjEaysyEESKlNCSN+E1+s7nVdIFY0Oabb502CmzfLquh/jCJZkxoxCrDVa1KK+Eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+dkYjdpGWLbi/UXqMcV2HTeHcPEFa61ZgtMOy19wZc=;
 b=bYUgjGILsiOErB/ouaoLhHCC4PKdcMML8N3sn1mV5wKPW2nQYv3x8gs9Rk9tzy160FdMXConT+n3zD7JUdDxXDY86L6BfKsZyupuxuAD1JVrocNP2nW6AKwVU0uRfBVGv3PmIuY8WaQk3mto0dSLf5q+EhRo5znXBzZYDkGYfKvJzOLBOngxNdK/OdSjr382j0SN6zSb/2fkQHXnHcM8ev7r/d8wFlslnkoJJb9moCoPWEehxsdvl/3sTLXhMWkZvaFiJ43/12E/YOnxdX0CyVjcHieufKlp6jbq+t6gDTJYZmu4u0nsFphdqk1Yt8cu0rpatPbzdGsbCEPhdTXZ1w==
Received: from TYAPR01MB6060.jpnprd01.prod.outlook.com (2603:1096:402:34::8)
 by TYAPR01MB3263.jpnprd01.prod.outlook.com (2603:1096:404:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sat, 5 Mar
 2022 10:35:57 +0000
Received: from TYAPR01MB6060.jpnprd01.prod.outlook.com
 ([fe80::397f:84f5:f1e8:3388]) by TYAPR01MB6060.jpnprd01.prod.outlook.com
 ([fe80::397f:84f5:f1e8:3388%7]) with mapi id 15.20.5038.019; Sat, 5 Mar 2022
 10:35:57 +0000
From:   matriz windowsboy111 <wboy111@outlook.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Help on free space cache issue
Thread-Topic: Help on free space cache issue
Thread-Index: AQHYMGT7X2eIeUnOQE6TtEbaPteJn6ywk5mAgAADzuw=
Date:   Sat, 5 Mar 2022 10:35:57 +0000
Message-ID: <TYAPR01MB60603D900251F5CCC974761DEE069@TYAPR01MB6060.jpnprd01.prod.outlook.com>
References: <TYAPR01MB6060F10E43889BABC65A3E7FEE069@TYAPR01MB6060.jpnprd01.prod.outlook.com>
 <c76ec07b-4e4b-180c-612f-5a9cceb3f30d@gmx.com>
In-Reply-To: <c76ec07b-4e4b-180c-612f-5a9cceb3f30d@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 60b4555c-1875-450d-a9e6-05278ffc7eff
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [bJ/9G/rWJyGPphHuGxDh/9fsPyRLUiad]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 678d1c33-6435-452d-a727-08d9fe93ef09
x-ms-traffictypediagnostic: TYAPR01MB3263:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oLyAJgHHTIS0b/Sv78ddPLAcqnLjEF367dF4lrzzcuyv+W1ktiYQ/eNhPs2RoLaWq5hxjMbraZriAoQpFu6fokLSYrNe7QK3TvKm3JrCQdQ/NdieOnjYKDIvuBzLLFzlW0eWsY4uw7IBHysODGDQx3jhzbwinJ1uwxJYQaqBg/1asDOq7oH3IGfoZxBfYgDjimdWhKcf9KaJ+1GacA6IHYDkKQXkTVpfcT3q+dxeRx8yOvUtB2ibuIyqhCqH10zwzE/QLe4fbdUd2fpuQmKc9nLr6i+3y292NWF61F9x09U5jXo5TJNfKol3NaxawOzzyHn8kfZdeJ0v3kFCvC+2by0XsEm70Wk17IlFVEs/tekQfqy5szh2oagdo4C3SuWoqSziZcaystsnr/r3A+41E1Y3/MxcfrhYkf4K+nORQCzHjx7MLoJwagk+39KuxgsWlhZBfOQSGZ3Ei1e4nabQ2gogqpLqztXrjk9bal6UiWqKQHJ7CZw8QvRV9Vn+KLepurH/9Z/imPBdBXIyK65w/QRvhS7EkZP+z2YrVrOpcN8myPkAisCwMKc8E/iFrz4VFH1YLXl1NOD6l5Q8LTtrgw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: eQv3YRaMgmaoyCk7wv+bmtO1w9S7bnSVtvCGS8qpgd9G0/g+iEeWDltcbA4YOfY8ub2yLrhD7cq7UR0RD3wEN4cZ89fYEfP5W8zZu8L1kdRILczfDEab1f+KGpKyMhuXWFwEo2vM3nGnQU5DpLMzzeL71fIeGlnKiQYUaZ2hC3gqFVLCBdj6QasW7Cwk2vGrFbxzZgiXr1JSksR0vIeKrgmppYbu/H6r+ZCIzeWqtjQV4R4W84r4bv9jB9E7LBv7XyXhYGWvX84R+xx298YxB9dpnp+KF8fb+U0m/8RuRmBRLHhH2pzZw/J6eAX2cqFtr7Vpg+v4D8oqPoSggXfBM9Z2T9sxx/yoi1CnCc4d+mV2tGf5ZqxLry5LLzJA3y4TnfuUlw7uSKfWn5mbW2Zn6p4V5ROI7i6+XrVU82e7Ki2+MxbFXk55d35l6NUNNyn1qGI3hNnEfnwHQtB6z0A5VU6rnwY9S3zFfo0XmuNmRGjMCKfVcmGtJi7F7AI6ZE8VE2uMdUrzg02GZWx09jZFwDQ3ERPe4dMzmm/47TMu89W7sB8NHt9QeGN7F4Fe89ygXbdWPhpkQ0UI7PGGNrOdXHDCZ2GMVWzynwQC3c5NkB99OxMnbV6ARa3IQtcAlcvJ0Ukp8zBIYe4hSdBOyZxcOWo2clMrvO4uVLhBQ//TYVVjsbvx7fvBFManqQeE+9xRI5BuvIji8oDDOxXlaSA6FeL+bSHQg2/3/CVMNi7vsrFbWWxBasLeVI8RNOFd941FQ+uItyjvYy/JNCFcHel3vBVwNGV/F6bQOdCKsXFwMHoTKhBapzMOm97b4hCMbrKtSqQ4Wz+A3N3jMr4jkVdISJqgdDEkpiS4LFvcsYpsKdlwTwlq7Tt22y8ABGAiqx6vzljfsrS6z3mgpKjwq5/n14a199cs4s2cn03pSLyOB4KVYEc3wMyxFqI49k8Unykz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6060.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 678d1c33-6435-452d-a727-08d9fe93ef09
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2022 10:35:57.2890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3263
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I ran the check once more, and it is indeed left with the orphan inode prob=
lem you have mentioned. I appreciate your help.=0A=
=0A=
Thanks,=0A=
wboy=0A=
=0A=
________________________________________=0A=
From: Qu Wenruo <quwenruo.btrfs@gmx.com>=0A=
Sent: Saturday, March 5, 2022 6:17 PM=0A=
To: matriz windowsboy111; linux-btrfs@vger.kernel.org=0A=
Subject: Re: Help on free space cache issue=0A=
=0A=
=0A=
=0A=
On 2022/3/5 16:02, matriz windowsboy111 wrote:=0A=
> # uname -a=0A=
> Linux hostname_here 5.16.12-zen1-1-zen #1 ZEN SMP PREEMPT Wed, 02 Mar 202=
2 12:22:53 +0000 x86_64 GNU/Linux=0A=
> # btrfs --version=0A=
> btrfs-progs v5.16.2=0A=
> # btrfs fi show=0A=
> Label: none  uuid: 794b6ad2-78a3-4814-9ed2-e605ad66d2cc=0A=
>          Total devices 2 FS bytes used 56.03GiB=0A=
>          devid    1 size 105.08GiB used 105.01GiB path /dev/sdb3=0A=
>          devid    2 size 8.00GiB used 7.00GiB path /dev/sdb2=0A=
>=0A=
> Label: 'DATA'  uuid: 496b5da8-b16b-4241-88b3-9140272585bf=0A=
>          Total devices 1 FS bytes used 333.60GiB=0A=
>          devid    1 size 931.51GiB used 604.02GiB path /dev/sda2=0A=
>=0A=
> # mount /dev/sda2 DATA -o ro=0A=
> # btrfs fi df DATA=0A=
> Data, single: total=3D592.00GiB, used=3D333.00GiB=0A=
> System, DUP: total=3D8.00MiB, used=3D96.00KiB=0A=
> Metadata, DUP: total=3D6.00GiB, used=3D618.05MiB=0A=
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B=0A=
>=0A=
> ---=0A=
> Basically I found this at first:=0A=
>=0A=
> # ls -alh=0A=
> ls: cannot access '3F32BF73FBCEFC1F243A53C9C5643F7B17C8436D': No such fil=
e or directory=0A=
> total 0=0A=
> drwxrwxrwx 1 root root 80 May 29  2021 .=0A=
> drwx------ 1 root root 14 May 29  2021 ..=0A=
> -????????? ? ?    ?     ?            ? 3F32BF73FBCEFC1F243A53C9C5643F7B17=
C8436D=0A=
>=0A=
> This file basically... doesn't exist. `rm -rf` doesn't work, while `touch=
` says "file exists" and then creates a copy:=0A=
>=0A=
> # touch 3F32BF73FBCEFC1F243A53C9C5643F7B17C8436D -a=0A=
> touch: cannot touch '3F32BF73FBCEFC1F243A53C9C5643F7B17C8436D': File exis=
ts=0A=
> # ls -alh=0A=
> ls: cannot access '3F32BF73FBCEFC1F243A53C9C5643F7B17C8436D': No such fil=
e or directory=0A=
> ls: cannot access '3F32BF73FBCEFC1F243A53C9C5643F7B17C8436D': No such fil=
e or directory=0A=
> total 0=0A=
> drwxrwxrwx 1 root root 80 May 29  2021 .=0A=
> drwx------ 1 root root 14 May 29  2021 ..=0A=
> -????????? ? ?    ?     ?            ? 3F32BF73FBCEFC1F243A53C9C5643F7B17=
C8436D=0A=
> -????????? ? ?    ?     ?            ? 3F32BF73FBCEFC1F243A53C9C5643F7B17=
C8436D=0A=
>=0A=
> I decided to ran a repair (before_repair.png) (after_repair.png) and I am=
 kind of regretting what I did.=0A=
> Anyway, I appreciate any help provided.=0A=
=0A=
In fact repair did a lot of (pretty good) work to fix your problems.=0A=
=0A=
The initial problems are all fixed, only free space cache (can be easily=0A=
rebuilt) and one inode has missing orphan item.=0A=
=0A=
You can easily remove the v1 cache by:=0A=
=0A=
  # btrfs check --clear-space-cache v1 /dev/sda2=0A=
=0A=
For the orphan inode problem, IIRC it will be addressed in later releases.=
=0A=
For now, it won't cause any problem, except wasting some space (that=0A=
inode won't be release, thus only taking space, but can not be accessed)=0A=
=0A=
Thanks,=0A=
Qu=0A=

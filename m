Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE512B02B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 11:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgKLK1e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 05:27:34 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19002 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgKLK1e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 05:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605176853; x=1636712853;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=E1QTLJicF4BnAPibOAxxsE1ASzJe9+WYpPY4LQjZ1Ho=;
  b=CQ34YOHXvTs3ZOfSQ7w6QexYgm/utscz7q2Tt7CbrxeV39DcKsKABzfD
   KDcznF4uRcFCwqhKd6aMf9ieDMxznGGdVYLfwCsIuv0GyVBhI3e/Rz220
   XyP26+3aXzlU5yNuOplG2VMmYjZMLhmCV0vzHh8Lezt6som96r2pfCuxD
   CxmP1D/UewjBdMwiZ0MGEBbu3JSiIAIW+iWZ1+6PYcqRF8hg1cq7HMSPm
   iG2seQ4QU2wIN8yrTINL/dXfmYHS5BsSmx/eBfA3cBAvWQsyysPB1/5CF
   pP5aZhwdDyiEnfIW7ouZ7nJTCkgOHk7uGSzQHaX9KSJ2Xrzlz/pDjQcml
   A==;
IronPort-SDR: JdmLFnyuQw42IG7WPvs7a5tra1UFgZsZD9HoTeZ/J4djFHSH53I/rX2DG6JfT/B3hMtOYT5pc/
 A0og5iw2VxWMlkk0zBZ1ASQohMeZVVUX5WXrD6uviGc9nqelQSQWFHFGQBGFJzDQZn7cdAfHEj
 dDBPutfAK8OxtSTIjf9m4RHV+tyjAFkfwWziH2O2s0owokDeLtJKb0dPV3Q0Q2szyojd0zjo1b
 VnIT/ZT6jL2kCvFfGWOC7nNF9JEdhQ4cAswvea64Dq7MUXZGSKToHkz+GWZUJjZ/N95XfhT338
 bKo=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; 
   d="scan'208";a="152569986"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 18:27:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH9B3yCbqzLT614QMltmS64t0h8LSbYZmXrkjKqeEtTrHTXewIgHgJfBRU7+801gxTB6Gp9fxUHAtw/L9p68FDHCAnZygavxRhFdArcVLL4unwKKyWsHtomhivcfzaOEqLSmvg5yl6MpvKRwhJWR97bUfUqlKquzmCy3/ZVv1GesEfmIJobvjfnCpBVgGywde9qqoGLI23JwIp+IoAINTUzr30BMmtpubUbFdbh7kC2wzbja9uFXR/m1gFNioQeVuyOwDkRH22kCfYoryyjpdOcVeokngONd4aqrq7MpmmPuKG0sKkCp0wR3r0rKmOUApMOm8MoZkE1WVIKRwj+Iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJUcnl0DbpTwkWkDfvb4XPNAlpS5DfuF00wZW1YjQV0=;
 b=FkzYNZ+dejFfZkv62LIDD2hNwV9NTo3i2wOAKGpg4ATtBFV1Pb2rENK+lbKXa8lJzN9g8yCtgjYNTskLU5UbEtrBC8jBjWRC7Hn9Hr5IuH3OlVOe2Nd2iuQ6Vg9U/LDcZDToQ+wxPnQ5FKcD9JNgztgX5VFChCMw3VUPy1g/agAo1+WvWW0rIsrxvjaQtovx8EqtuUw62TB+hpQ8eHaTotXiQ+ZBpoNpaS4AYQPXMOu7JnXXIOPz95ogzCqOnOXwf+UvWCfPni3xJJwedexawkXfLG/aL4JDUXCTv/eK96IM3NXNRth3neFcYxvtaAE0RSpjqRN2c4AHgjmse7ZF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJUcnl0DbpTwkWkDfvb4XPNAlpS5DfuF00wZW1YjQV0=;
 b=V75n7A9d4M5QRKsfPZkBtoDDSpZQK617FWA9S4VISpUXlHiYfRpL80OidiHHAFVsrVOhV/tfmL5gYSZIj4uLYfxiagfJtMsgXxYp5y6ixKRoYevQ/+V1ObgnfJk8yqLZsKQUpsrxXuTSbqxe/Yp8P2abQKHJBti00jOtsCAaAhY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5248.namprd04.prod.outlook.com
 (2603:10b6:805:fc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Thu, 12 Nov
 2020 10:27:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 10:27:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: hold device_list_mutex while accessing a
 btrfs_device's members
Thread-Topic: [PATCH] btrfs: hold device_list_mutex while accessing a
 btrfs_device's members
Thread-Index: AQHWuEK2+yAEqm4DMEeMh9rJtDxbRA==
Date:   Thu, 12 Nov 2020 10:27:30 +0000
Message-ID: <SN4PR0401MB35981F6DA8C79E1DA86B105B9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <3a6553bc8e7b4ea56f1ed0f1a3160fc1f7209df6.1605109916.git.johannes.thumshirn@wdc.com>
 <29aebf1e-4684-4003-44b4-c5e8846b69eb@oracle.com>
 <SN4PR0401MB359852C46EE68127C7959CD29BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <d389866a-4d25-6d8a-aaa8-3403bc7b7c0c@oracle.com>
 <SN4PR0401MB35988CCA4F7CB9E929D22FD19BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <82a9e569-31c7-6f80-3c1d-b02d52d406e1@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:3d02:4ac1:70fb:2ebb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb7caf75-1a8f-4e4a-771f-08d886f58f73
x-ms-traffictypediagnostic: SN6PR04MB5248:
x-microsoft-antispam-prvs: <SN6PR04MB52487A5EC40E6414D169BC5E9BE70@SN6PR04MB5248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdtkgbKXvLRuX+MDNQY7jmgayOeHk458b2hqGkNTj/l77MrkOVShkfsNgKav9UtVdoJ2MH42HjDsPAdaUtYa2DHUIE2XhHexnRC7+sYXqRlEzXoNkdZli8KuGhjFcZXu3H1l9491UjhZdNPWFmJ3OMpdBUtPxzisgJ/7FIR5qY0d2uibb8r7ohPNItVE0+lxQfdu1TVO/EIgpC+8R6tvhacRaW1VdRShzieDDk085OJ7U5bbz0UOp+SGP2fxiGkUyYBOY7PQfYuPrh45coA0VOyxP2mcn2iQvsBoBDHHQJ+xITMO7xaTx6SfJrYLFr0vBYsn2ryvOSZ2e1MqfQzosQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(66476007)(478600001)(76116006)(2906002)(64756008)(66946007)(9686003)(8936002)(110136005)(83380400001)(4326008)(86362001)(7696005)(186003)(55016002)(8676002)(71200400001)(5660300002)(316002)(33656002)(91956017)(66556008)(6506007)(53546011)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NatUYrgLOyZoE1QPbUA0JIc5S1UjzV1dmpJLTSdIY2VzyD76Apzm1sF1RZgg/fn7FQf23r+MWyWt9QUste6w8XWTAN4YN88pEHMMH/Jyd5pW86bRum1t5GlEs93bUbWB4keVZovUsLM2nEaolWt7TV/wZkT+WA/82hlB8Yzgz+Kg39pJ/DOILdi0AfP6TXANqUR9QP1OMvhUA9GiuFCjhh1c03fcC0avyO49U5gSsrgvjETjrhcDurB0YWxhhWoCqeSKQ10i0YsbMq+UdWsuBofJrjsPSHpC5pxmzefzMouYtA+ApI3UG3YcRuBfY8BuMmjcKHPSJh0FQVA88B9NRFPGLTcbj9+VgUOIPcdSSRS7+Qy6D0JzxXxqRhQY91A7mQqyMXq5/vWvr/I4GqnQsVf3J4QArn3Jzxbazyym2J6xaw+wcUHuGGcBQ7OEcbfPGm4Gx2wJKc3J+NiSc57gXsfZg0qk3zkKocpG0b9uOn8U+sGWhjXfo9yUl6BRCevoBEKzsRQb+oL/LxzXZ4xDRfVxAz8uJZeXL2ZaiTuynumTWusGOdaApxvYvrC95enXu83qNPgsUv3ykNz1egit2bOoI3MZkGctzW1NhEzw3BHnPbKvsOTkqz+jUZnTU6MNNXMptb6PLfNJkNzEWdgcILTq6YQp3hBM/H4ALJKEo1y7rONaWWDzVWkvNG6JJoUtJEqbJ/fV0Y5XqIyoOJc8Sg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7caf75-1a8f-4e4a-771f-08d886f58f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 10:27:30.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znaEbeehGyvijQpMjvFyv9arg3Djstbgjo/mIxKB7aK13DuV+8xrD9moxX1cPp80B/TtAzl8GD/pdDZIuFS3QzMLMiwzUukAEqqm9KQHQwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5248
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/2020 10:58, Nikolay Borisov wrote:=0A=
> Because the btrfs_* helpers also provide the fsid of the system for=0A=
> which an event happened and this becomes relevant when you have a=0A=
> multi-btrfs system.=0A=
=0A=
But you won't get the fsid with NO_FS_INFO either:=0A=
 =0A=
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c=0A=
index a906315efd19..5bd8a889fed0 100644=0A=
--- a/fs/btrfs/super.c=0A=
+++ b/fs/btrfs/super.c=0A=
@@ -216,9 +216,17 @@ void __cold btrfs_printk(const struct btrfs_fs_info *f=
s_info, const char *fmt, .=0A=
 	vaf.fmt =3D fmt;=0A=
 	vaf.va =3D &args;=0A=
 =0A=
-	if (__ratelimit(ratelimit))=0A=
-		printk("%sBTRFS %s (device %s): %pV\n", lvl, type,=0A=
-			fs_info ? fs_info->sb->s_id : "<unknown>", &vaf);=0A=
+	if (__ratelimit(ratelimit)) {=0A=
+		if (fs_info =3D=3D NULL)=0A=
+			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,=0A=
+				"<unknown>", &vaf);=0A=
+		else if (fs_info =3D=3D NO_FS_INFO)=0A=
+			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,=0A=
+				"...", &vaf);=0A=
+		else=0A=
+			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,=0A=
+				fs_info->sb->s_id, &vaf);=0A=
+	}=0A=
 =0A=
=0A=
The equivalent to this in the context of device_list_add() would then be:=
=0A=
pr_warn("BTRFS warning (device ...): duplicate device %s devid %llu generat=
ion %llu scanned by %s (%d)",=0A=
	path, devid, found_transid, current->comm, =0A=
	task_pid_nr(current));=0A=
=0A=

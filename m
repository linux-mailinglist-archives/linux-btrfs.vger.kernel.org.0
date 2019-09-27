Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF20DC0010
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 09:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfI0Hbd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 03:31:33 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:40932 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbfI0Hbc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 03:31:32 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Fri, 27 Sep 2019 07:30:35 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 27 Sep 2019 07:28:26 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 27 Sep 2019 07:28:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHMhQVrnHFyJ4WI7GxkbjneRLGDPSGObTdcPuge8mu7G4Q0a7P078DTbyr61vwRCroKzUprFLgYjSgiD6SPe+K5Syf83mIey/Dx13J6ZlDyokp0v2mAFgZiJ99zZn3a2AfhDHf+bssEIf+y315lKxFxajSQd5MudmiskJrwtWR9dsdcGlAlSW1Cs0+MD7eeexpygpHz3mxxJ8q5V1kAg7HFweovdJmYVsEP11txRMlvzvmJaBnPepx50LzBtB6i/qMxC0GTkV58hwW5bARhYwaX6NgzULbXXPnUT5IBLLC+KwoHKwiHEtLgpH66lotgsGbW4aZQHBQQPIWVg89fycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKNBFwrPMKjPjMsgw7/caM4+LLLVmMnIUBua8s+dPxk=;
 b=UQyOnwsXVDjPZqeFFQa84srY1zs21KbtTB6MeGMlyGAh848HQd7FyWgk5oAMe8jF1/rlbauG/2Y/FjnBeFmX/o3booYNaNJwh6Ztv0LCPc0+RchWd3UWZvHIZuGHQGEwHxPZp967ufjqUgAfcVhSdJjOXPSI8Vo1oAukZ3PoreK6tzsNUdSg/RpBGonuxQW0i80vIMc6CmMQLSkK1Pymu0Ho1QZ87dqABeDqq2izvdfori2VPvl3k2RGTDVORHIaYd2BaSuk6FJ+EXNciGtIEmk7NN8vDyk4ds8iKEFOrzqXUZJbTDUPToBa0E6ZaRdpwGUVtLtjjJ+otmw6Xix9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3089.namprd18.prod.outlook.com (10.255.137.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 27 Sep 2019 07:28:23 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc%5]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 07:28:23 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2.1] btrfs: Detect unbalanced tree with empty leaf before
 crashing btree operations
Thread-Topic: [PATCH v2.1] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
Thread-Index: AQHVdQUkvfWG39Im8kWLMx+Y7BGRCQ==
Date:   Fri, 27 Sep 2019 07:28:23 +0000
Message-ID: <dbd46651-de06-ed81-29b2-ea547b77269e@suse.com>
References: <20190822021415.9425-1-wqu@suse.com>
In-Reply-To: <20190822021415.9425-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:404:10a::13) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77e76a93-6ed7-4ca1-dbe7-08d7431c471b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(49563074)(7193020);SRVR:BY5PR18MB3089;
x-ms-traffictypediagnostic: BY5PR18MB3089:
x-microsoft-antispam-prvs: <BY5PR18MB3089EAF8FB39E5191491E3BFD6810@BY5PR18MB3089.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(54534003)(199004)(189003)(6306002)(26005)(5660300002)(8936002)(25786009)(3846002)(2616005)(11346002)(81156014)(66616009)(6116002)(66476007)(476003)(446003)(81166006)(71200400001)(66556008)(305945005)(71190400001)(486006)(64756008)(66946007)(386003)(6486002)(6506007)(229853002)(7736002)(66446008)(6246003)(36756003)(14454004)(52116002)(2906002)(2351001)(99286004)(86362001)(99936001)(14444005)(966005)(316002)(6512007)(31696002)(6436002)(8676002)(2501003)(6916009)(45080400002)(256004)(31686004)(76176011)(5640700003)(102836004)(66066001)(186003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3089;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tn/uZw7ab96hCKHS3UV06sZU9l1RkpMlPXq8dUSoBCIa9MR8aW01lvum7G3lDfUH5bRR/ipZthtkAzZBBgp5nJvLCMahZbiGasEU/MCXgm3mqGUFvUzuyS/6Ul/ZQ1OBuHACsP1xOIeWfJLW2Q2KYwLLv+lIDKxTyp3P0A82YjX2ayTZdwQNfZb54jeUQAV+Xn5BXx/Z7LvZXevS4R8tDKpKBctivW3yR8nwy8Vb9HVzkfArtTJ6E9EmtmTrCvN0R7Kxn4CX5ZbTCE/1yHHH19lrZ2uG/7ucz5NpaVXXtEeAyTAFaXEWDP/+Pc5EQ4PpZbk26vyH8dCf7CnW5PnyWKJSJl4n6WNWwZ4TJsxSZuaThyjj7YG4j2tVHb7SHp82dvSmZZUYqR170VK9FtPIkG3JYGDhcyHvVp3j5sSUAjw=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="dsjgiodf2wlLiIAkUyu7f9gvaj30gU9P4"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e76a93-6ed7-4ca1-dbe7-08d7431c471b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 07:28:23.4873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPWhesaUnN6Ka5f8OV0sanXz08ZUaoJ99WfqqfbjDFAtHUFms1XksU3trDEkrE/B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3089
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--dsjgiodf2wlLiIAkUyu7f9gvaj30gU9P4
Content-Type: multipart/mixed; boundary="GIlcQeE6iE0V4HZBTdT4oAwDeiXnzuWls"

--GIlcQeE6iE0V4HZBTdT4oAwDeiXnzuWls
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/22 =E4=B8=8A=E5=8D=8810:14, Qu Wenruo wrote:
> [BUG]
> With crafted image, btrfs will panic at btree operations:
>   kernel BUG at fs/btrfs/ctree.c:3894!
>   invalid opcode: 0000 [#1] SMP PTI
>   CPU: 0 PID: 1138 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
>   RIP: 0010:__push_leaf_left+0x6b6/0x6e0
>   Code: 00 00 48 98 48 8d 04 80 48 8d 74 80 65 e8 42 5a 04 00 48 8b bd =
78 ff ff ff 8b bf 90 d0 00 00 89 7d 98 83 ef 65 e9 06 ff ff ff <0f> 0b 0f=
 0b 48 8b 85 78 ff ff ff 8b 90 90 d0 00 00 e9 eb fe ff ff
>   RSP: 0018:ffffc0bd4128b990 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ffffa0a4ab8f0e38 RCX: 0000000000000000
>   RDX: ffffa0a280000000 RSI: 0000000000000000 RDI: ffffa0a4b3814000
>   RBP: ffffc0bd4128ba38 R08: 0000000000001000 R09: ffffc0bd4128b948
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000240
>   R13: ffffa0a4b556fb60 R14: ffffa0a4ab8f0af0 R15: ffffa0a4ab8f0af0
>   FS: 0000000000000000(0000) GS:ffffa0a4b7a00000(0000) knlGS:0000000000=
000000
>   CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f2461c80020 CR3: 000000022b32a006 CR4: 00000000000206f0
>   Call Trace:
>   ? _cond_resched+0x1a/0x50
>   push_leaf_left+0x179/0x190
>   btrfs_del_items+0x316/0x470
>   btrfs_del_csums+0x215/0x3a0
>   __btrfs_free_extent.isra.72+0x5a7/0xbe0
>   __btrfs_run_delayed_refs+0x539/0x1120
>   btrfs_run_delayed_refs+0xdb/0x1b0
>   btrfs_commit_transaction+0x52/0x950
>   ? start_transaction+0x94/0x450
>   transaction_kthread+0x163/0x190
>   kthread+0x105/0x140
>   ? btrfs_cleanup_transaction+0x560/0x560
>   ? kthread_destroy_worker+0x50/0x50
>   ret_from_fork+0x35/0x40
>   Modules linked in:
>   ---[ end trace c2425e6e89b5558f ]---
>=20
> [CAUSE]
> The offending csum tree looks like this:
> checksum tree key (CSUM_TREE ROOT_ITEM 0)
> node 29741056 level 1 items 14 free 107 generation 19 owner CSUM_TREE
>         ...
>         key (EXTENT_CSUM EXTENT_CSUM 85975040) block 29630464 gen 17
>         key (EXTENT_CSUM EXTENT_CSUM 89911296) block 29642752 gen 17 <<=
<
>         key (EXTENT_CSUM EXTENT_CSUM 92274688) block 29646848 gen 17
>         ...
>=20
> leaf 29630464 items 6 free space 1 generation 17 owner CSUM_TREE
>         item 0 key (EXTENT_CSUM EXTENT_CSUM 85975040) itemoff 3987 item=
size 8
>                 range start 85975040 end 85983232 length 8192
>         ...
> leaf 29642752 items 0 free space 3995 generation 17 owner 0
>                     ^ empty leaf            invalid owner ^
>=20
> leaf 29646848 items 1 free space 602 generation 17 owner CSUM_TREE
>         item 0 key (EXTENT_CSUM EXTENT_CSUM 92274688) itemoff 627 items=
ize 3368
>                 range start 92274688 end 95723520 length 3448832
>=20
> So we have a corrupted csum tree where one tree leaf is completely
> empty, causing unbalanced btree, thus leading to unexpected btree
> balance error.
>=20
> [FIX]
> For this particular case, we handle it in two directions to catch it:
> - Check if the tree block is empty through btrfs_verify_level_key()
>   So that invalid tree blocks won't be read out through
>   btrfs_search_slot() and its variants.
>=20
> - Check 0 tree owner in tree checker
>   NO tree is using 0 as its tree owner, detect it and reject at tree
>   block read time.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D202821
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Updated with patchset
>   "[PATCH v2 0/5] btrfs: Enhanced runtime defence against fuzzed images=
"
> v2.1:
> - Move the nritems check after generation check.
>   As we have reports of random false alert for new tree blocks of a
>   running transaction.

Hi David,

I see you have pushed the patch to mainline.

However I still remember you have hit several false alerts even with
this version.
Did you still see such false alerts anymore?

Thanks,
Qu


--GIlcQeE6iE0V4HZBTdT4oAwDeiXnzuWls--

--dsjgiodf2wlLiIAkUyu7f9gvaj30gU9P4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2NuhAACgkQwj2R86El
/qh4QAf+JOr7yOphoZlclRzFsSa2I9OfIwZMVj7EHbiXyC/RjJyecoBjPj+uuiRr
awMBkKnwess+Y9GnD5u3K4HQ9M1TeXBLjHGo0Rzy5tl0H0za6bbwaHLnAZL8SIxs
EtXOwAM7YgWYBpM0Zk7GCDu+6eJwFm/pfKt2wNutI5Ql7tjcpjqfVwfIjyazzExS
Io7wF1zqTk8QcIVWX364nau+xH/jO7YoLYM/xZOBSmV0cBI4sGEyNpZ8yjpUtlSW
/m67UbzGtVPdVWKcYB1So8qHuCn6am1CCDjXP2dvkWMKUnkjMr9Am/FxRKAV4g2D
GB+m9cJyTNk35KQmuxh6q5n3bKljCA==
=Bg64
-----END PGP SIGNATURE-----

--dsjgiodf2wlLiIAkUyu7f9gvaj30gU9P4--

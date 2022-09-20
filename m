Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB395BE53C
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiITMI2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 08:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiITMIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 08:08:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5C4696C0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663675701; x=1695211701;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AvWtfe1FmPNRtIiJbEsODdQFetkIfYOBONMLgBr8LNo=;
  b=FY1ln06KboeLndbxXQYk4w/EBWAHOVKt5Nycvf432JR1TaJvvyUy/Rk/
   vZxDRl2uHbvGqefnkMVrKmOPg6egpshZiXjPsmm7PRU92bzA+1aQ6HoMz
   w4yYewMh/0j8Z63DTlKKQvyKkGTAwbKL6fsOvAE0jVXwn4fZNvQR81JtZ
   o9gObsFRAKG/AIjCP59nx7hlXXP1I4gnMjumWOUyJbO2e07aM9lVTcNif
   1XVii4ojZN41XmWoMGtlRx4u6Lr1bRQ+GOy0mpsBX4rmkbf1F4YSmfNpd
   cQowgS4Wc0m2aDuzG7pQRv2PYhlxb3G0wKsKWNBDAM0j3eOAmIrR1oe5I
   g==;
X-IronPort-AV: E=Sophos;i="5.93,330,1654531200"; 
   d="scan'208";a="212243855"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2022 20:08:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AquZfx37+wgBJ0VamPaCWk2rtETgcRw6YDYgUs0TDYLOzQORF3Tu+Nd3QcExlyVxPQGSkG5b4R1mxkhvEqXGZCkRsRgp0p3Rqt8DTyLia2jAqhCSQZJ73LJXK5IV83i0SwqwHXNmkGRPwdboShcymfd/cEPjc/WgdOoEcMdBD/hHKoHW6tNPHcJjgWlk9z65QAdPYJSx+URgVPiTKA/9JC/zn9kEdm9UfU03eYWXfGKqCUepYffWj54HkRe+s9FZkhPaScr8m73QEl2pEsb1heX6moT7qGtanp1TlxQasNwPIXaHHQ2em563ZgBN0foAjrsKCM3XCzfjz5yeX+944g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfNm8KCGHf7qEhYuRAOLlQScPwDXf6roBUN11MR/v04=;
 b=NVGMDNOvnSd6S+cHUsu8DmUbLEx8TftnMbbf16zsciaOXS9ZOqpMQjb8ydqJqVDyl2oqeTIz1dsYMAEQqJv4tk4baaFMTYe+3xxb11DjXMXyNblQiUF1stIJbPu0GBZjiV7LDSvC6lZ8zhlkI7Skl7KCscMU/7qW31pauqiZ7j7s+0tKZtCvn3sd9Gl5w1HHzRKxH4+rmoEywatBPrAEVFSe6QRSC3iwM1/BQkplzjqjOerqWtYrb5ltB4iPu8HouyJdOHugHn4QwITCjCDYvlMJBxfnv8m7l1Q5/ht8aw5jMfBkH1q3w7fBFN/KdVZGIXsVutqG99tKF3CpOQzCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfNm8KCGHf7qEhYuRAOLlQScPwDXf6roBUN11MR/v04=;
 b=SttxBGg8t4GNRl5cJia0LULxxzRZwyG6tQ8mBDsaAfE54GPTLJt+S2t89J7VX1qV7toHkkXYN7lX3y+gImvS7979FdBJ4IOsXNFV8bAShGuNFKvcldlP98CFvRbMDqPOTU5+ECaoCPj42XMmB/o1583nYAEkwd/NnIYUGWmHs7k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6683.namprd04.prod.outlook.com (2603:10b6:5:248::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 12:08:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 12:08:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        syzbot <syzbot+fba8e2116a12609b6c59@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] btrfs: Call btrfs_set_header_generation() before
 btrfs_clean_tree_block()
Thread-Topic: [PATCH] btrfs: Call btrfs_set_header_generation() before
 btrfs_clean_tree_block()
Thread-Index: AQHYzOcNWBN/0xUBOEG3Ef2FsFJ5MQ==
Date:   Tue, 20 Sep 2022 12:08:17 +0000
Message-ID: <PH0PR04MB74161B62751B7D8EDB3965719B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <000000000000a4618905d1361d3e@google.com>
 <062d63c8-39bf-62d8-4562-625184e97b6c@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6683:EE_
x-ms-office365-filtering-correlation-id: 371f3eda-f6d4-402e-b502-08da9b00cd89
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjU2Q6GrCzcTe0PyTCEyVatcf3pCiFO0V36YSCJU0IYq8iNX1hiEpIMW5Uy0nGqhlyipW3Fo4aE6wDfjAXkHCwRAGQP8sbHZdwywpgKOOtrsdHjGNELhWa9/z89sgRYSTmrFQmAmYPB9x+Isi26KGF3NYI3K4lKJZYdjiMZFV++0rm/wB4poXKEm+by0jNyec0yilnR5aBACmFF9o8h19LMg/XVjuYAj8kiqdI9QJVZ6msoJV50nqW/7NgEHW7kV0TAwNLMwypgEm/othZAZ6mZT/LCbZ70qTbRu+xRxsQordI2fd3PbElSAXYI6uV3QcLxveZoxtc/tkYF/qEbcSd7K6xAAa9PK9alL3QwqiTR8F/K80gT+ymSwTA0g0WZKkToN1QS0OI1NoiulA4iGGST59Eh1z4FFJFgst72cpliKQ+53ydonDizNvuf3qvWmo6veeDuu52MwwqOcLmUxIhsmlLHHDFe7dlGHCetlVPaRQs9By0GXuYP0yOs4sbYSMfCldK1A3fGi3H6NbXNEN9MR/R28RHwrgiqDmn3V/pLwdP4dFFjgM/QPEjS/S7+lFtx3RFihs0AyPqDsHErisU0XVvOowhbJAk/+yN9Ml6uujSRoTyO0P/C5LVaywptGqOWeTgOGRlueMiqHsWxpAZeLSXT6pw4VsyvpbnQAl76iVZcjOI9ZOHhlMG+OQXx9+lmfzny4Jc0oKRKqpnWzPN3EGXEjde9S+mEkbYxsj3tikKPZposHSwHs1n2VrmoB6kXXk5VVIohLEC5OwGVIfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(66476007)(66556008)(55016003)(4326008)(91956017)(122000001)(76116006)(8676002)(66946007)(66446008)(316002)(64756008)(54906003)(110136005)(5660300002)(33656002)(2906002)(86362001)(38070700005)(52536014)(8936002)(82960400001)(186003)(9686003)(83380400001)(478600001)(71200400001)(38100700002)(6506007)(7696005)(53546011)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JyFqYJejlAHRHrDpHW+/1KeXsHI2HFBq3nODke9KIOGIXwuaXWJJZXFnmhUB?=
 =?us-ascii?Q?tblpvzq/sGsR4DfbiP1NvdTWOIPvAp3HWdiY+KKtH+/W/0piOmVJTgxWk5eK?=
 =?us-ascii?Q?OlKTYtbhrUrfGiLS2beCqSiZz0Dajt/0ngP7300JuiAKeGP3kD7qqXyAgH+W?=
 =?us-ascii?Q?OR7od8hh0RBB4R8JFm6Qc+9rm51D9XCmlfDf0Fw4sQ4bF5eJoxse6iBRGGNA?=
 =?us-ascii?Q?LT1d5IH0vo+JMkj7im57s5hzGrV4c1Yjqxh2wCaqggQM6E599Cet3ld8Epfh?=
 =?us-ascii?Q?u4FA5DC3KPVqyVfkb5rDFL8TqXYp6G+DqUSaN7derKVLJisnDCnOjVYAZ42U?=
 =?us-ascii?Q?JDQaM9WjnTWiKkqy/qVfii3COdYqWvdcyKnGmPGo2stJztCSefFcrYOSaMzd?=
 =?us-ascii?Q?o8f0fYdisNj5diAlF/7VbW32GOLdw8wWkCIy1sNw+fzqd5RiVURgjtqtXaBL?=
 =?us-ascii?Q?sgKl13ygI/mvfoJQC8yqbXgs3CU/8mo57ujes0vtytBfVTzOg3v48uBsEfB1?=
 =?us-ascii?Q?s1ysKbLoIT4Us8OH+v2c9D2Gz+SLpS9yOZwocSDCtsFh3aZz21uxx1/Otski?=
 =?us-ascii?Q?8ZsiAg6R8zHyNPRTmcB6KQX9kCVasHQypdGZ+CMcvdkNF1ndc8/ugHoPklLW?=
 =?us-ascii?Q?ebfZoHcAl9bQwn7Q91L4SYFgNdsKCSL74uYZc2mGgQqAVXWQWltKX+zoWF+W?=
 =?us-ascii?Q?ql/qhp5iPW8iCHdAMq3DALOLydAtKJR1lv2kVgLs+IbRtn1X3X37H0Y9djGm?=
 =?us-ascii?Q?jfIF2jUPwOzFs1sKHuTtVK3zYAXmk4tPTSwNisLva5yvg/EXlVf2eXyPYOwo?=
 =?us-ascii?Q?Cj6Xh/8tipeP+p0b8EhPO34V+/bQg6poYcR9ZDHGeV8KSL1ewxe+7XqP+9kK?=
 =?us-ascii?Q?b7LNr3yy8f91Z3Efto1zO+8S/GuR27CLc0TIfdnsKNUKTIIvQQWOVaaaSS8l?=
 =?us-ascii?Q?lPtnNfqK1TKjPxgwqWTdIzaHHtk7CqA4SKrMRfc3r9XCwIsEE8gX06V8uY0X?=
 =?us-ascii?Q?evvfegkyWN3M5lygLC5FlFwI1Ec313fPKrBHXgftQDBZxucD3+ZSF3DqQiZj?=
 =?us-ascii?Q?nIR7fMCPWZBjCyKco5iFXmredje41/AbO9NqxM5ki0sII5key+6Wa8yu5yC8?=
 =?us-ascii?Q?ykG06vf62E/CtIkqhFmY+dH9rZlCR9wDV5X+ZWf5EQwvEoKPnwDVuSnJVzaH?=
 =?us-ascii?Q?wSxX2XqzgBL+1i81clGJ4dG1jGWrSHEMVJoE1gduPvWh2EHpeO4P3VyOIOaO?=
 =?us-ascii?Q?iYGr3jzTPMaga6hz96/wJM4NZmGjxa3fH2OuRBjD+lFDXf2i6eagiFGQb7Ap?=
 =?us-ascii?Q?0O8Es5mCrMnES4L+x5a1jGzRxNMap7nX6KZc5GtQIbnMB/TUMwGWL4BK/hMW?=
 =?us-ascii?Q?xeLNogixXW9herpzAe2gDrSPeA3b563QQ4kvMa/1dqegeaV6vZlTaCt0wGFb?=
 =?us-ascii?Q?Kx0neoWthLZwriW2GfH80CVT2WUSsQIKkysUnA0DnLmw2c6vUYO71eeGrpk+?=
 =?us-ascii?Q?59TBVjK+ZAx+JOoKhdSLCy6bdePik6OBVJOIk0uXVW33TDboreKDTaesCNXs?=
 =?us-ascii?Q?+TZA7JL2siON2lOtaPo/jfPHkyEiweKtLyU5Lh8cwekeNgnTxrUrJPk1X8Vf?=
 =?us-ascii?Q?AA/GJx9qYZX13YusOHK6IeMIoH5mYR8eb3w30CZUEmFviDl2A+TxdDF+aEXc?=
 =?us-ascii?Q?7mZqLfay19mJXqVDVepetMP3WEQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371f3eda-f6d4-402e-b502-08da9b00cd89
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 12:08:17.6380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pb4O8W8vbTCQAl7QTGXeazfb0PXL28x/uQP7CjVvNi3lw7AidIqb+zd+aebTiC3zmPMLVToENTbaNJ7PjYQZv2M4ChYuXLRc+/h52A9uHIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6683
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20.09.22 13:49, Tetsuo Handa wrote:=0A=
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c=0A=
> index 6914cd8024ba..9c7bf0ef6a5f 100644=0A=
> --- a/fs/btrfs/extent-tree.c=0A=
> +++ b/fs/btrfs/extent-tree.c=0A=
> @@ -4895,6 +4895,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,=0A=
>  	 */=0A=
>  	btrfs_set_buffer_lockdep_class(lockdep_owner, buf, level);=0A=
>  =0A=
> +	btrfs_set_header_generation(buf, trans->transid);=0A=
=0A=
Here you're setting the header generation into the extent buffer=0A=
=0A=
>  	__btrfs_tree_lock(buf, nest);=0A=
>  	btrfs_clean_tree_block(buf);=0A=
>  	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);=0A=
> @@ -4905,7 +4906,6 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,=0A=
>  	memzero_extent_buffer(buf, 0, sizeof(struct btrfs_header));=0A=
=0A=
And here the extent buffer's part containing the header gets =0A=
memzeroed resulting in header generation 0.=0A=
=0A=
Fo rthis to poroperly work you'd need to bring the memzero_extent_buffer()=
=0A=
call before setting the header generation or re-set the generation after=0A=
clearing.=0A=
=0A=
=0A=
>  	btrfs_set_header_level(buf, level);=0A=
>  	btrfs_set_header_bytenr(buf, buf->start);=0A=
> -	btrfs_set_header_generation(buf, trans->transid);=0A=
>  	btrfs_set_header_backref_rev(buf, BTRFS_MIXED_BACKREF_REV);=0A=
>  	btrfs_set_header_owner(buf, owner);=0A=
>  	write_extent_buffer_fsid(buf, fs_info->fs_devices->metadata_uuid);=0A=
=0A=

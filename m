Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D77A56C3C7
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 01:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiGHXHB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239346AbiGHXHA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:07:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FB33C147
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 16:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657321619; x=1688857619;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mGpr6OnB4dbr8U6rrvPhP5PjX4ST92ixGenGqRSY8vE=;
  b=kzgos8NIAy+3RbvCxislSA7s8oi+fo+EEX8Tc2K5BqQR7Ey3vgtzcTd0
   mS9VuXnVtlA11+ARSWiDg/gYGYiKVgB80bapyBrVdHnA4oCx9IsCQKHT9
   5w+U6j4wsLoWmfAk46q0LdkT4Yy0XU35535JCBcaSD+zK2E6nGdhu50lV
   nAWwYYY4SMR/ku3W6X8nj6i4Etl6O7WaJW9f9XaZ48+he5nF80OUpTIlu
   pqCCfG6KdklxXkkzWDneHH4TsW02139bhJhKqqSohQ9IcETGe9Bu2I74t
   GMmZBcerR3j5OxNJkwNYdr+gkb1Yh0BR+Z11jgXWVZ+CpNfZOGG+VN52k
   A==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="205927559"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:06:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmQ35od5T8FcRWBEAvjKg00rU6JZs1KnmpDFoKFSQYLBBG+Uc7o6HWBbbAuwUqZTPHu0ZcLU/ZIaoGqMphbWg2pZ872GpxN8p5aFjeF/YxpYl52yR1FuFy8XShEgvQqna3ajS7gPY1M6h6t+b10q01ziAwhvxgo9XXU/W9PtEqN6b6DM8jXdvWvodSsd+JlvjdTW79WHQeu5tVvrAQpAI6kM7O5jQXeGwNcdBxFpIO8loQLgKiIbAQyyoLCaK4+FCjSUzF/TTy9TmqbYyYhOknWMYLP/cFLeb1lKtHl/3tVbtUBwD8F86vqKXWhBNwBeoAybioT+kcMagQamtaE62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI9vtw9jAbaBV4RqiTh/koTOdLH4aeaEl7XquoaWaTE=;
 b=U6/clgynbV61YcWeEUrdpPcojgNPiT0d4ztSwq9uuud27n1qgJk15MXAZvRzD5tNpQZJ+4Ya8i4iVq+OD/ObjtFKLmwbjB+wZLr3dbPTjXdt+EJswGM692G+0mY6zJG9QPdVlgbLyxod6QxADeGft6upiHTwQHWVBtcPTXWjn8gZsuninGn3YAAL3DZXR0NL7w/ZNO57Jp7AAJa/cnC2kIt5cSAMGYmL0B+kfXdOdqpqGuCNtG1Kiqw3sOoGNlDvRpENQt93+ZxRRLq9mdhOP66FvhIvBZIDYiJub3F8zLPFhmanQAxdx8tn3xnsPJvcCnbhI7dwUCwIPSMnUY6OWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI9vtw9jAbaBV4RqiTh/koTOdLH4aeaEl7XquoaWaTE=;
 b=Vrh/Bo9d1nmvzaDTWrJYVh7hL/+v2Ii71yibVzmNA5Kth8SBxa4PIOq6DmEpFyNqxCFk6Dz8vmwzOLztBAKRfY6F6WFLRsMN4G1lItHf03wJEDv30nOFsVR+bQL4irgBFUbPqAUBObcMIdTnkkAo/piSQmtfXB5KA14YaXQy9zU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA1PR04MB8254.namprd04.prod.outlook.com (2603:10b6:806:1e5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 23:06:55 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e%6]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 23:06:55 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/13] btrfs: zoned: fix active zone tracking issues
Thread-Topic: [PATCH 00/13] btrfs: zoned: fix active zone tracking issues
Thread-Index: AQHYj2LAt5otKqrbKUOe65aN7CX5I610ypiAgABVdgA=
Date:   Fri, 8 Jul 2022 23:06:55 +0000
Message-ID: <20220708230654.fczpdykmvgy35ndr@naota-xeon>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <20220708180101.GX15169@twin.jikos.cz>
In-Reply-To: <20220708180101.GX15169@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8090456e-e47a-4d19-0020-08da61368d4c
x-ms-traffictypediagnostic: SA1PR04MB8254:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wCzSERwYEEzXyQF13PNxoTpti8doCl0HMdpt9iYtiejv9GioOEY0XrXnM872AqI8liBKEvv92DlBcuDmII+di56KjshTU/m1J6UopR1orr9gCvVRxIdrdDvcI/a9AdvTVQvvMmv6xGZu+nvV95bjKnaYD1imQC+1a113ZWMmGzvCSk3r/gkQAE6IRD3/zweJhlqc77+IZM/GcBUyFMYq1apz8fL5zsxc5OIdeK7Bz9pTq4Mc4hDHDuJhJi8jO7wJXJLXLuoZ0vSnlwqlRiaCyTDX6Y4NF022kFcJ0SBahepChZrNj3djqj0K4XicnVzH+DOnmy2x+GZdtSKb1PVamSuXHXOkOKTaGukgCWXgQfws6dtKIPaipV9FiCLSyQQfLR1ZHRgEQo9IrvDWbCEjfiNlMGV78volkoAx5Y0ApA5S56cFYWaZoS+RuQLCNpbhqGF77KBMTRElV+MnGP8RiVUdIqrRgXU6KXI+TmmXrQP3pd5/R8ZPxY1IT/G9gz8P5Hi9KyIAkp2PzQGWdToTEgNLdUaX7mTeUtfHlpZfRkhdFNzSwgK8263K7IeEZHF5bNtVHnHfyb+oyh1j4fuo1PnRf/SmB4PNFRTLO1OA7XPYHDAExtyXOhxicbj7j8wJSp/6l+EyDtAjyzcpPqrZ0O9vJ+26jQSfgXD/ttjOBPNDckTP8jOp+kOPMvNLVigj3rfAQYRk6OvXnBls4RQLWavaBJ8nIruplHeN7c41CP2ekVBLb8V5ZYiY1hA61oOS/H0GrtbURAdnMk6TjrCPzIZNuF/8bZbxSZ1X9tfiBD/p+CMdtH8Md6/7CgAySkz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(39860400002)(346002)(396003)(136003)(366004)(6512007)(2906002)(9686003)(8676002)(1076003)(6506007)(5660300002)(66556008)(86362001)(33716001)(66446008)(66946007)(91956017)(66476007)(64756008)(8936002)(6486002)(26005)(76116006)(41300700001)(186003)(316002)(478600001)(38070700005)(83380400001)(122000001)(82960400001)(71200400001)(45080400002)(110136005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YdaTahkWxpab0UurEJKV/9qILYvtAmDo1Zi2xo6DmfVupEwOcDa5di9zi02K?=
 =?us-ascii?Q?6kHFLaeYr1hGAjoSzTLmbpiTiBaNWlG51PxtBPXBRfuujYmpoi57M7yGNs1t?=
 =?us-ascii?Q?a6l7e0XzN+alYlHo10mhMlmOVlnSx1IZwokigtOQ823gA82m/Y4A+T7KK08+?=
 =?us-ascii?Q?gu2hHL/i9jKUb7jtQkaJXnC5kB1KjOrhr7r2QxM40njAurkc4gL0rR6WYZGF?=
 =?us-ascii?Q?PduZxksd1M5PQmd68umpeiIwHiLcNsD0FGgdGQPXHOG8y7+fbCTmHHYF278o?=
 =?us-ascii?Q?uiCJILb61W0fJrR9Kx+iszgONM9/L5FLSlnqmeeQcjAxWgIP5QFADnU0avT2?=
 =?us-ascii?Q?ELmzEeoTGGCQWcY7ajUMeN8usFGBbpXGNPLaBw7JdIRhwEs428jDsoimkKa1?=
 =?us-ascii?Q?iM1ys2+bIdqS7vvxiTN2oeBA0F0uQe6+a/ZNGKyia+IvLBZTf8p2jQ2Bm/D7?=
 =?us-ascii?Q?iXBrvyoxqzSBUiiiVWOJKTUVG0TECMxjgXd0sDhNcDGE+XYbLJIZRpoGLtzL?=
 =?us-ascii?Q?LR10Zab8tNYAIvhlk4HQPEYTkdDKi7YoCV8vf+YOrt007O/TPmqba212pEwF?=
 =?us-ascii?Q?miN4/gZQXBwLmtMMXlNm+HOxru0jC3JcXEGeBYIUvKziqUl6svYI9P2xEVVr?=
 =?us-ascii?Q?zOU3cnU3BQJ6Y5lJNf7YInibbao1CoeUgfabxEc+DBh+RP4T5SC10TsM4pGd?=
 =?us-ascii?Q?izkMt5z4O5RU7/M9Oy1pc7MrRh7/pBEWxL7v5zvPafiDPY1rCu5VxEyfd0jp?=
 =?us-ascii?Q?78PiceRW2/RcJyXoMamN3mDiEYyLlGgE4ZnBfnqvNZRN4a/VToF54lwK0aIu?=
 =?us-ascii?Q?KPpS4VewpZJXsy4741Dc0CUJNXyrF+lBFeGyxjpuQhmVG6FPOvOFv+MCG1GM?=
 =?us-ascii?Q?YF1c2qXoG2dz1sCa5rK7pLXSR4nA/Jut0xxGjLcPhE/BqbKZdATw1lF9w7NR?=
 =?us-ascii?Q?sL4TVxXaf2E5uA+X9jiljKlct2ibdCGEKiv7HlmS7yJzjIrcpKxBwlLA5hvi?=
 =?us-ascii?Q?YnpGdhZj4Rf2hi+i+/C+o5c4+Ss/CMrMCEuKTild/dYhvtzHqfIekwQQCOQr?=
 =?us-ascii?Q?GgzJL79wwlfpzpYhS6D4h232nV+tSb0FkWzdufmrBgG53/jn0doARxLtZOU1?=
 =?us-ascii?Q?8ZKENGcFpa0iibHAZ+DwFtsF4KqObaBkMGddeoV/wjDqsXE7pLD8EQ2x/kOt?=
 =?us-ascii?Q?Rmof8Ukrwu+cKVqEkeWIF4ZsoYayCr8jS2IDGmXd2Hq7rAbTPyDVf+gS7V1S?=
 =?us-ascii?Q?bNGTKaBo5oHZZINaPK/x4FlYxWkEUPNstiw9xsqYybxXtEzHKBDVk2nSOyRY?=
 =?us-ascii?Q?tx6vsM86fj1HH2uoYGva8nesTmKYYaJm7fF+Vr5vNWBEOMy7i7wYzgINvv/y?=
 =?us-ascii?Q?5ESZs0sIorHsoO4vyNi5lv270ds1//QiyYAckmIYabxuGLsWcVsxSva9Ua3A?=
 =?us-ascii?Q?/NfA+atAw09GnefHltRhwO41pCa7Un3ecqIbU+yLwsvKbvxDqUFAnyccH18d?=
 =?us-ascii?Q?hl0IO8RZhwC8xzDRWhjW2OqbD1ds8Yi8L86SW8GCj2UumHaK2qXlYhTvaAGg?=
 =?us-ascii?Q?XWGS9pNBzyaEA9nWS7dtX43ox1wc+29zvcV7snWFfKM1bW2b+16WTxuU1Bzc?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFCE6AD8CF93C34AA88C4B73BBCD00B6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8090456e-e47a-4d19-0020-08da61368d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 23:06:55.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRZYHZyh1ZyIyV+Uz4InyycEG4rq8wkyvSuGz8UL2KGICBCdbz8BPZdouSOAzI2onBKk20fn7OPDf5Z9CE4n4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8254
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 08, 2022 at 08:01:01PM +0200, David Sterba wrote:
> On Mon, Jul 04, 2022 at 01:58:04PM +0900, Naohiro Aota wrote:
> > This series addresses mainly two issues on zoned btrfs' active zone
> > tracking and one issue which is a dependency of the main issue.
> >=20
> > * Background
> [...]
>=20
> Thanks for the writeup, this seems to be fixing a serious problem, also
> guessing by the length of the series. Some of the patches are marked for
> stable 5.12 or 5.16 but I think this would need to be backported
> manually and to 5.18 as the other versions have been EOLed.
>=20
> As most of the changes are in zoned code I can add the whole series to
> misc-next rather sooner than later because the code freeze is near.

Thank you.

> I did a quick test and it crashes in the self tests so I can't add the
> branch to for-next.
>=20
> [   13.324894] Btrfs loaded, crc32c=3Dcrc32c-generic, debug=3Don, assert=
=3Don, integrity-checker=3Don, ref-verify=3Don, zoned=3Dyes, fsverity=3Dyes
> [   13.326507] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
> [   13.327303] BTRFS: selftest: running btrfs free space cache tests
> [   13.328133] BTRFS: selftest: running extent only tests
> [   13.328935] BTRFS: selftest: running bitmap only tests
> [   13.329770] BTRFS: selftest: running bitmap and extent tests
> [   13.330647] BTRFS: selftest: running space stealing from bitmap to ext=
ent tests
> [   13.331990] BTRFS: selftest: running bytes index tests
> [   13.332915] BTRFS: selftest: running extent buffer operation tests
> [   13.333924] BTRFS: selftest: running btrfs_split_item tests
> [   13.334922] BTRFS: selftest: running extent I/O tests
> [   13.335733] BTRFS: selftest: running find delalloc tests
> [   13.525595] BUG: unable to handle page fault for address: 000000000000=
2360
> [   13.526677] #PF: supervisor read access in kernel mode
> [   13.527480] #PF: error_code(0x0000) - not-present page
> [   13.528381] PGD 0 P4D 0=20
> [   13.528909] Oops: 0000 [#1] PREEMPT SMP
> [   13.529604] CPU: 0 PID: 642 Comm: modprobe Not tainted 5.19.0-rc5-defa=
ult+ #1809
> [   13.530742] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [   13.532475] RIP: 0010:find_lock_delalloc_range+0x41/0x2a0 [btrfs]
> [   13.535137] RSP: 0018:ffffb750c05ebcd8 EFLAGS: 00010296
> [   13.535467] RAX: 0000000000000000 RBX: ffff96b1fe0f3440 RCX: 000000000=
0000fff
> [   13.535880] RDX: ffffb750c05ebd60 RSI: ffff96b1fe0f3440 RDI: ffff96b18=
38b8f00
> [   13.536534] RBP: ffff96b1838b8f00 R08: 0000000000000000 R09: 000000000=
0000001
> [   13.537141] R10: 0000000000000000 R11: 0000000000000001 R12: 000000000=
0001000
> [   13.537548] R13: ffff96b1838b8ab8 R14: 0000000000000fff R15: ffffb750c=
05ebd58
> [   13.537956] FS:  00007eff49b43740(0000) GS:ffff96b1fd600000(0000) knlG=
S:0000000000000000
> [   13.538467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.538808] CR2: 0000000000002360 CR3: 0000000003f1c000 CR4: 000000000=
00006b0
> [   13.539213] Call Trace:
> [   13.539407]  <TASK>
> [   13.539584]  test_find_delalloc+0x19b/0x695 [btrfs]
> [   13.539978]  btrfs_test_extent_io+0x1e/0x39 [btrfs]
> [   13.540710]  btrfs_run_sanity_tests.cold+0x33/0xcd [btrfs]
> [   13.541686]  init_btrfs_fs+0xcc/0x12b [btrfs]
> [   13.542328]  ? 0xffffffffc060a000
> [   13.542868]  do_one_initcall+0x65/0x330
> [   13.543348]  ? rcu_read_lock_sched_held+0x3b/0x70
> [   13.543980]  ? trace_kmalloc+0x33/0xe0
> [   13.544394]  ? kmem_cache_alloc_trace+0x188/0x270
> [   13.544805]  do_init_module+0x4a/0x1f0
> [   13.545076]  __do_sys_finit_module+0x9e/0xf0
> [   13.545373]  do_syscall_64+0x3c/0x80
> [   13.545618]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   13.545961] RIP: 0033:0x7eff49c6da8d
> [   13.547264] RSP: 002b:00007ffcb6e6bbc8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
> [   13.547724] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007eff4=
9c6da8d
> [   13.548184] RDX: 0000000000000000 RSI: 000055a8143faab2 RDI: 000000000=
000000d
> [   13.549012] RBP: 000055a81441d460 R08: 0000000000000000 R09: 000000000=
0000000
> [   13.549550] R10: 000000000000000d R11: 0000000000000246 R12: 000055a81=
43faab2
> [   13.549958] R13: 000055a814423530 R14: 0000000000000000 R15: 000055a81=
4424ab8
> [   13.550363]  </TASK>
> [   13.550541] Modules linked in: btrfs(+) blake2b_generic libcrc32c xor =
lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress xxhash l=
oop
> [   13.551275] CR2: 0000000000002360
> [   13.551525] ---[ end trace 0000000000000000 ]---
> [   13.551819] RIP: 0010:find_lock_delalloc_range+0x41/0x2a0 [btrfs]
> [   13.555923] RSP: 0018:ffffb750c05ebcd8 EFLAGS: 00010296
> [   13.557052] RAX: 0000000000000000 RBX: ffff96b1fe0f3440 RCX: 000000000=
0000fff
> [   13.558614] RDX: ffffb750c05ebd60 RSI: ffff96b1fe0f3440 RDI: ffff96b18=
38b8f00
> [   13.559857] RBP: ffff96b1838b8f00 R08: 0000000000000000 R09: 000000000=
0000001
> [   13.561280] R10: 0000000000000000 R11: 0000000000000001 R12: 000000000=
0001000
> [   13.562619] R13: ffff96b1838b8ab8 R14: 0000000000000fff R15: ffffb750c=
05ebd58
> [   13.563522] FS:  00007eff49b43740(0000) GS:ffff96b1fd600000(0000) knlG=
S:0000000000000000
> [   13.564612] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.565356] CR2: 0000000000002360 CR3: 0000000003f1c000 CR4: 000000000=
00006b0

Yes. This is also pointed out by Johannes. I'm going to send v2 with this f=
ixed.=

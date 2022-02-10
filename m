Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156CD4B1137
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 16:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbiBJPFp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 10:05:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243402AbiBJPFm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 10:05:42 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 07:05:43 PST
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA93DB1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 07:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644505543; x=1676041543;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=29pj2FiAR6uhUpLu0ocjnzG6JYqJRvOJS0q4gyEUBg4=;
  b=mwhZXVcQsiiaVbrRmPhkNRUNlWq0ZV1O/Xbz7Rv80bRS7USG/qX/RKL+
   WLiR4o717b2mOCRSsC0JWH17QXTQT8qp03N/UlOqUyja9/9SJm1SZA37O
   bJXfPjpkeDMevcY9QOxYUNb5k0rXvj8mxFzuI7yTiqTghxaeYkTQwm9Yn
   D06MCreoy1b37zdEwcJS5PWChVvxAJKrG/6MLCeRqBUFjrHFaxQBq6FjG
   bXShUWePr8lhStEGwlydFJ4flvC7TuLtgdj29Uku6+jEmcmBx40FFeNWF
   5Gs3ZP/RmMNxJIKl17JgNeB9or4+s8rJPEchQwQ7zWJOjB+61YKYGOgok
   w==;
X-IronPort-AV: E=Sophos;i="5.88,359,1635177600"; 
   d="scan'208";a="296707675"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 23:04:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDGaYHfUZXNxcYhHrVhcBVSY2+Urooqc7Ofr0cvmYusr6H94JO8gwjIweJmc8mRZbGAzk//hZLC+Uda4DtbEklbhPhQtG1Gtr03lK9vilNvdysk6xu94YKvqxzj0HtDTBmfL2WNzFvvR0orME3ygo3XaxADl7+0+jInZn/zbz/Qz6VNVMvHI/xpi2crRURzFOnsy2zkaUdDieMV2FFUceIwPScm9W+Q09Prn3YD10swPNB/mVtIekuhH9g5WgKV/FaT4JLz7tNZU4vxzm02sig727J5D/QPqZIDbCAdJfou6cpj1XkWUvYhDULrfPk2d/Ue4pXMqFiocGqZOpYJLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M60HSDH1Ax1e0os2Z/AVM0kNT6BZcFSJ8C8ctpwr0GE=;
 b=De4lX1zaRPlhlUj3VhCI+uy+5ao71480etE/lY2D8GaiHf76X08au0/R77VY/mnfunrxA8ZQfUrGDZ3fAhrhttn6FsOTaUN1QU4/iM/6Dx9rHz1H+8VlbZCsm54qncJizNvm+ya81UHCjWFDmXeXBQBCvr7gKbdnq9DBti6K7pfjQRK6F2+byE2ceh1dqfeDIiv/+ZjpW+s68xWAXHlG37dek9Ql2Fgx0ehxNjdGz2FODOZ1NqFDGOYTHhczoHEWc6fMaYuAia2NpxqovBT5qZcf1c6O+FC+Uy3Vlng6ZOA9wG1TyhVTI4rxUNOGttzmfXDzmT7EaOdkO5CjWCWH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M60HSDH1Ax1e0os2Z/AVM0kNT6BZcFSJ8C8ctpwr0GE=;
 b=GpkwHUHhSC4UaxZ687FKy3P2f2VQxoiDspiTAapPXCZ3S+519XVlqGhH7tAAXLGwLB70B2av7sD7pX2e1v4CrUkg8zvrByRY/2pmTNakPdFkueWPeGSKMF57DF3j5BCmevxUSdN0WEyoK2q2p7LYhKTsCMp6Gow68k9SnRO3sII=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4399.namprd04.prod.outlook.com (2603:10b6:805:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Thu, 10 Feb
 2022 15:04:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 15:04:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: introduce a minimal zone size and reject
 mount
Thread-Topic: [PATCH] btrfs: zoned: introduce a minimal zone size and reject
 mount
Thread-Index: AQHYHoS9wuTpQL11r0e2OLqP8hOETg==
Date:   Thu, 10 Feb 2022 15:04:38 +0000
Message-ID: <PH0PR04MB7416939A286AA364E5A91CD19B2F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <3824ae6295104af815c8357525eaa896e836eb1c.1644500637.git.johannes.thumshirn@wdc.com>
 <20220210143258.GP12643@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b82c7b3-37fa-4e84-5732-08d9eca6a857
x-ms-traffictypediagnostic: SN6PR04MB4399:EE_
x-microsoft-antispam-prvs: <SN6PR04MB4399BBC0A4AC86A0E46105099B2F9@SN6PR04MB4399.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q1zeOOgvumj53VjoPt6DbAKeq35BOgzhYGrieZJbZw7p6MO4wZTKLt8epW71jXj/r+GrZnRsLFNnQELzu7Dy0YP5R+LXKgUct4NNi0REjHY/3hyQZ+ZK+fjDtQTMne6wtqnysKHj4FTTsuxQBLufYgN2gBfjo0dHYgwws1x/BB6h8X3mqGFwxVjfiis2c5RL5XGo7kY2M4y67cQjiOK2gn6sadQxeWseOBTEYoYaK+8LRKe8iVWSWDChsxIjnPSCQWEHVKyPn6zQ5rBAtw5nd/cttG5vn8wQcSYy/4OspnpPunrw02tksEojmtRS+/VyHTFKJU0Jl/nNVPJgn+2ReY/74VSTkuAGkVhKtTc7IW42tPOuOCIU6rYgsrPIu+n7jx77J+S0D513455sh9FbfLcWfkEVwbgYUzjc+UT6jXsTiIr59nms4V8o8MZzfwCFwQRWOUeAUJVdf27l2bk/MzeydtJrqD7DDoQcsR5ilvKWEzjogfodySTc5mERWERdBxxxEK/1UgH334gtGTx2a/xJ0c7+4PPF8Px3Dl6/0StjdUeJ9W6tR0SACFUn9zMthtRSqmSStKrwLCdm6/9tOFPO/P2Wht7LlWlmX7GObZglxin33WsYc0Jt10x7GmcEzJJTl1JfOYRoqDHTxI6FNyLvz2DmT50TK3CUFb0/4nnC2VhsUnZHmTHQQx/zHexYTpZUJfXr2Q3tRMFm3Yhczw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(316002)(54906003)(6916009)(71200400001)(186003)(508600001)(83380400001)(9686003)(7696005)(6506007)(53546011)(52536014)(66556008)(8936002)(38100700002)(122000001)(4326008)(82960400001)(38070700005)(76116006)(91956017)(33656002)(55016003)(66476007)(66946007)(5660300002)(2906002)(64756008)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gDpcYIQUOp/FcYS61kQo4FusTvC1ClFmCB073qSfWQ+1XRXgxbSc81/tYh?=
 =?iso-8859-1?Q?6GpuLJNkqbDvccVCOlRk0sq/fATT6jpfhuNUHW/Z8iKXD4uh7NtDKbIBMr?=
 =?iso-8859-1?Q?Yjuqmrdvx4OT/s2sq6JCRYShYhqso0OptfY9lk7Pjrsh4AxHBCjAJHFacP?=
 =?iso-8859-1?Q?1AF4tjn0lrg4xAUw7Su75N5IFgnLZ21bRw8eQ0UsuQG8coEvZXNPv9tQrj?=
 =?iso-8859-1?Q?aazmMZQBwyLkcLRQRRGKu/Ie3HUn3EV9Wd+VKX+xJyXBgJ/pTUe++hkapy?=
 =?iso-8859-1?Q?ZJQ1VQzkwFVfl6lNxk6w3dvh0o+Wv/DeXV4E728QLpLl9lgMvAro4Zn/1B?=
 =?iso-8859-1?Q?+mh+IW+OiCF0DBrt7wjwfmaEfh5YZYKNuSUTSQAvkgzopN38ZKxSJWMS6D?=
 =?iso-8859-1?Q?PadOO5Mxx90CLYlEwJt5CAtFnEEjYQ9Szzb/xfphujBR+iqUxrU3d5YU4i?=
 =?iso-8859-1?Q?XzaVbbSL4KaAqvZx5VbN3pIU32nEVfqkmzFNzn2SlDp8pLQDzmlXfWlMic?=
 =?iso-8859-1?Q?B1Qlxof2bmFd/TQ4zaN8XnX4FI5L3CKXW/Jj4mqZfUE62dmqqYXIFRKuG9?=
 =?iso-8859-1?Q?IElv0UDbeTpeM9BUA9okPDzhPcXi+68ZW6mrCAtR0x3fwDlkNbQbqeZQkP?=
 =?iso-8859-1?Q?+b53w+DgZ1CAA27pjUX8GL5cyARQ5t7cPXdoAj6N/UJxioswalQbygY8XM?=
 =?iso-8859-1?Q?2caNZejuGhyVsHP0wkuGhWCWO7Kejd6//EFH87m87b7ixl7Avu6L+Kgcaa?=
 =?iso-8859-1?Q?gxuD59J5RaWS2MJ65fnjxsW2g9KUeDlfTvHGdXsr2H7nhUiav9VpOocZ3h?=
 =?iso-8859-1?Q?xr4wA4naQfqmLwnVktWocCjdflGu6QFjQxCkYCuvQOI+YJsUwlGxSvBEPJ?=
 =?iso-8859-1?Q?CHwQvUMjEei31SryuiABPcI7EipFkZglZjA41bgroQQMM64JDI/FI7eN0j?=
 =?iso-8859-1?Q?uDaHipmEuT1ylw5SkOYDXTEdcnflCADujhrlcGB3B1zCrtHz82FHkzPdw7?=
 =?iso-8859-1?Q?Y1d94pMHmBUki3pbxQrPTzwanQOYo99n+6n7xxW/lAhDOqOcGkMval+fcG?=
 =?iso-8859-1?Q?T7t/td95UkuMGLiF8ohTRyOiGw8xeJdhojqBuv9FGyJHUZfPx30bWeDT32?=
 =?iso-8859-1?Q?uVtcKJkRFTbw69x9Fpym/J+WFv4avWwHxrcSFQzAr9Fj9LzIGGTP8FEU7m?=
 =?iso-8859-1?Q?FAN9cTIDYQNxYnX8i5qDrfCzrM+07gJWCRaH1BfboJpTZ10CURzZiFZUld?=
 =?iso-8859-1?Q?Gb/8SKiZR9de2Mg5iQcMEjOIWDKxFjppqjZqmpl5hz8XRFgvAi5FSQg44Y?=
 =?iso-8859-1?Q?Im0SnmRgoKWB415MRg7k4dTbAlQ+/X9yujWpb+TAW9+WQOQilW53M/MNjh?=
 =?iso-8859-1?Q?bHYMsNxzQ/BLTmC1Wq6tN67cCoHjnp/FDjC0Fnf/BaQb8MojcySxcGnjCq?=
 =?iso-8859-1?Q?lF3W1b4oJ/Rlt+K7x++LGecm5orzDwL7hdDMJAEbvojDKDCDYDD54zoOPQ?=
 =?iso-8859-1?Q?cGDf8uy0dc39dx1DSWDN2eUOOekEBfonGzxEDkwzO5UTmPlAABhQ6uUUJY?=
 =?iso-8859-1?Q?4cDe7bwXc4RUat/vPLLnez451Uc5FDHN4u+y8brnsFqTiYnlXrdbE1Ggb/?=
 =?iso-8859-1?Q?laMctuyXV9ai7ozmlclpicomsTqbG0NjVNCu7Kv5ErVAfvgcyowXHJc4kw?=
 =?iso-8859-1?Q?v39XfQEmrrhgijN8RYHREOZLQNMZRSJJLhs7PCv3YwP7PvAlId3lWpM+f0?=
 =?iso-8859-1?Q?iMf/jQvTLLHt2Y4Gc+pfPz+xp6HNihShdahPsuLsfvYLixixoL3dbWI6vE?=
 =?iso-8859-1?Q?wgGBOrabx+1YhUHcde3y7kwWPMZJRt8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b82c7b3-37fa-4e84-5732-08d9eca6a857
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 15:04:38.0926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlFOWSObleq+ghpErLBGM4c8kBZKMTyKar0MEyS3flwUWYUs6eTmDLDs55VSEQxhWOW2PEpeOtH981C/rbVZgXJ5e33fCnb3gZikEHv3rhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4399
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/02/2022 15:36, David Sterba wrote:=0A=
> On Thu, Feb 10, 2022 at 05:47:05AM -0800, Johannes Thumshirn wrote:=0A=
>> When creating a filesystem on a zoned block device with a zone size of=
=0A=
>> 32MB or 16MB successive mounting of this filesystem fails with the=0A=
>> following error message:=0A=
>>  host:/ # mount /dev/nullb0 /mnt/=0A=
>>   BTRFS info (device nullb0): flagging fs with big metadata feature=0A=
>>   BTRFS info (device nullb0): using free space tree=0A=
>>   BTRFS info (device nullb0): has skinny extents=0A=
>>   BTRFS info (device nullb0): host-managed zoned block device /dev/nullb=
0, 400 zones of 33554432 bytes=0A=
>>   BTRFS info (device nullb0): zoned mode enabled with zone size 33554432=
=0A=
>>   BTRFS error (device nullb0): zoned: block group 67108864 must not cont=
ain super block=0A=
>>   BTRFS error (device nullb0): failed to read block groups: -117=0A=
>>   BTRFS error (device nullb0): open_ctree failed=0A=
>>  mount: /mnt: wrong fs type, bad option, bad superblock on /dev/nullb0, =
missing codepage or helper program, or other error.=0A=
>>=0A=
>> This happens because mkfs.btrfs places the system block-group exactly at=
=0A=
>> the location where regular btrfs would have it's 1st super block mirror.=
=0A=
>> In case of a 16MiB filesystem, mkfs.btrfs will place the 1st metadata=0A=
>> block-group at this location.=0A=
>>=0A=
>> As the smallest zone size on the market today is 64MiB and we're expecti=
ng=0A=
>> zone sizes to be more in the 256MiB - 4GiB region, refuse to mount a=0A=
>> filesystem with a zone size of 32MiB or smaller.=0A=
> =0A=
> Nooooo, I've been using 4MiB zones for testing, it's an excellent setup=
=0A=
> to trigger all sorts of bugs. The 64MiB zone size is problematic for the=
=0A=
> reason you say but I think it's an outlier, so maybe add it as an=0A=
> exception.=0A=
> =0A=
=0A=
Yeah 32M (and probably 16M but that needs more zoned special casing) can be=
=0A=
fixed with mkfs and then with 8M zones all sorts of strange problems start =
to=0A=
occur.=0A=
=0A=
I do have a patch for 32M, but I didn't want to go down the rabbit hole for=
=0A=
only simulated hardware.=0A=

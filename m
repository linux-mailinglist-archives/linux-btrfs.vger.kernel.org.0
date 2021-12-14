Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB4A474328
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhLNNEe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 08:04:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36462 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhLNNEd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 08:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639487073; x=1671023073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uDepjVTOX32VuUaMaN+SK1/R6D/w5zSiD8lMsWVRd30=;
  b=Eqxo5Vg4o9gzeamLtVj5FnuJaWIKdBtgYaSFQCnaFAVpZD0RLIHR6Tjs
   7wr4Bq08lusxZGnqBb6bmelyIrOFJOzA+WcaJOWodNejN+C9dLBrH4V9F
   wMEb1S8CnN+kHh+Ffxl7EfE05PYnO4yhtOztvZTs5PypiIYwZkDvKId6l
   vB9zbDmP5e7DJXCufZ3ol7blwHNrtQnTeUZ49bOK2eg9ZWF79sUA4w5pP
   GCwtfb5RvguVvlbqp4emE5/ateinAtjuYr/F9QEJsi1btcMweJS6qeDs3
   cs9DFx1S4h+5JPBwlZbwiZEgyOkQuSq+AHV6XAcAJxiTPK4p23xZ4VpYu
   g==;
X-IronPort-AV: E=Sophos;i="5.88,205,1635177600"; 
   d="scan'208";a="187191933"
Received: from mail-sn1anam02lp2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.49])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2021 21:04:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPQ313i6IR//YCdKttzS9duxTMqXXwTh9M92B2Js5fuW1l5PQc+CLcqtFn59GPkJgoRjqjiH9nWtJVRU4J1tDMHyWF1HJQ83s2+a/UlicIFkUCPwlTWCVy6mYwgi6ZCiz7KYxItL3sKsW4FVnzTM1gquyaNM+NGdakS5ngBAD9EMkQ09eiUj7Q66VQLJ4t75xlhw+Z4TX4yu1WW3ScxQADw4lpDGsuUQ0rjZ+iotP1XTKCoV8Mu7UMb9dIjPROaEj/V6gKC2c2B3YTixpqadlWyXZGigzAAMXCJibPPGAkzC+TcUQvO4JRbx/eV1jPC7ES8E8dRp2ZPCqVyd1bJDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qk2r/gpKqad7UFmJlL3gcHs4aW+59mMyoXuZjPp4Ns=;
 b=PYxVrFC6EybXG2JL4ZUWXrFof3HQP2PswlVqikgkoeIGqoKf0QDtTRdjE9eFw9eFZfMEI58dqwqshe01YgH5IZ6MfIg6mI0WfKGIANGjy4TZy4eYAKXpyyS3OLdmYAqjRAeEPQmEQgMD7DKL44Jjagr1HfM7RgfFr+PogwNbhsBy4Xr1zKhd0iOXZrrq6EUSsZTlXwESDKiRdQO5X02Y0QIEXCN4ZcemsZ1rWSaEr0Ej2Zyd5BlUQKhow9FmnsGmxljuKlvgmqWu6ediHuHImBtdxZmkcrEojJ7DRCgNDI/w+UTW8rH8ZYZ7/Z9OX5Hyxnjt+u056kQs6GYWI6m7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qk2r/gpKqad7UFmJlL3gcHs4aW+59mMyoXuZjPp4Ns=;
 b=XUOqPRMU9eOKx+t0yeK2EdErifoSWOBG9ujIdxgPBRQypPQJkIBWPgwl5NEaJNkztQkEdG86S8UjN+VBjm4WFqoAzw0KNylG6sFhh1t+AmrN+uTNo9ZagNuK1wvhJTz/XRnDtTc33DBe0tAmJsa9lDnyyZ+qb6osu6Jtfr3jBE4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7839.namprd04.prod.outlook.com (2603:10b6:a03:37f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 13:04:31 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7067:b7ba:4fdf:d3af]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7067:b7ba:4fdf:d3af%5]) with mapi id 15.20.4801.014; Tue, 14 Dec 2021
 13:04:31 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Topic: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Index: AQHX79OicLLdJYq/w0OUjXttGMYXaKwwl5SAgAFfBwA=
Date:   Tue, 14 Dec 2021 13:04:30 +0000
Message-ID: <20211214130430.nu6zya573ohrdarq@naota-xeon>
References: <20211213034338.949507-1-naohiro.aota@wdc.com>
 <Ybdv53DkPk7+XdYn@localhost.localdomain>
In-Reply-To: <Ybdv53DkPk7+XdYn@localhost.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f06bd1a-a939-419f-4656-08d9bf02448e
x-ms-traffictypediagnostic: SJ0PR04MB7839:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB7839A772A53F5CB20540982F8C759@SJ0PR04MB7839.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QiH64R4c21QuzrJx7/i6p1XZg7ns9VizBqJ3SIl3xB0FugSo0oPIX7ScqophKJji/8pyBG1lCUimm8AJln1FX2bkIZwqocY3yEjqjy0MZo81Mlp6e/5jsW//lmPR/TimSAmOVAj4uIjD5SouZcUil+Uy/Hh28S8xX0hkQ3Xl2e4aOdzA6uOksjSxDC7jT2jn5X3jd2kALlxamhNMVuYvQ0SHLlf6hiOr8NnEIphGIeq1mloKYSGUKgq1Z1xIME2FlvwafjSLBNJt0uObOs0WnVroMhTH0TaBZhaX9mE1znh1qGiWUbqJNNbxq9PjKe/A9R7f9f/mDzXzBKCPRzc/urlLvFSxYw3XHLPu5WUEf8TnFDQoD9PtU1lFNonzHd7FiXVtxO9p0eZ16mm+egIGqgkk6KZ8kGAaTAG3wDGMVKZB/ZJDoPyyj3YnkiX1hUFFHb2PByfiPAdkMM2rkQho3EHP7PPJKpaM12eCFuSiWj+uAGMQpb+IObEUi/35fLljXQTDr0t6hEf6dOYL+/ftsyciJWBzlN774DDtmAiiokaaO315b+zrYbtSQwF0uS3EwnkxXmt14/1S/UDUOBJopFwdNo8pMqvWU/pqd8mfD2T1yMmkOhTHuaUC3NCLSK3mV64pNGNdV/VMmWdve6q4bwfObwe7R4ef6MMY3LvL3UtN/OqX6WYYYN6ycA42d4HkpiaKyjSEcLyvF/fDgeqSZlxds16Yi5csFUtJ/xEUto4Ae+cZnbyJtg6TOV5X35LhNKhJpOmsAcvx3KblLA9bRwu7wZYReBvUZcS0y385AXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(86362001)(316002)(6506007)(6916009)(33716001)(38100700002)(8676002)(5660300002)(76116006)(71200400001)(1076003)(6512007)(66476007)(91956017)(122000001)(66556008)(6486002)(83380400001)(966005)(26005)(8936002)(54906003)(64756008)(508600001)(186003)(9686003)(4326008)(82960400001)(38070700005)(66446008)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gewFhJA6MmWCAUHNb2i9+I30skCPk67xCIsC2xg8w5Pi4Z9y290LiOoNSFKp?=
 =?us-ascii?Q?jKTYiTnWGGYtL9kEJiql3BEMzkPfPgdkGz2PCE0BoUu+j193ch1fiHmr0uwB?=
 =?us-ascii?Q?KyPTuQJ/CJm0lGnhgj9l7ZDP7taXgxA7LF82pozezewfn/GG8ihOPD+chsWx?=
 =?us-ascii?Q?2mZcuMjzrSTeCSakypHdvs2q4wu+s7bDa+/dub8tl4uGqYXHOedxFbFbswYB?=
 =?us-ascii?Q?BpMQDHhAy0z7dPD3QHrCYhiydWc3E2A8eKfrBy3KCH2zzgTfqrnZuzuO8r1Q?=
 =?us-ascii?Q?0fQo3SG2HsEYU6e8YZ8pF7rOqPq+JzAltnw6ybGGwMg1Mt7lYQyjd5ivX/IC?=
 =?us-ascii?Q?dblkY6RZiYPvjaaNEKPmiuILMOhqm1JUxY0mggV9lYlg+t2O+k8rzACbqH1d?=
 =?us-ascii?Q?3YDZwDichKoCFTlYLMyuIkhb4FquaTkair8fiYV8M2uYpgkn+mLh32pd3hVd?=
 =?us-ascii?Q?aKGaeUo5dmOyQm0p5BNIqlxOQoT91ng2mCcjFEPu9DRR0Weh8QQPm2ja6OX/?=
 =?us-ascii?Q?tfCf7mJIo/QgDg1+j1rbzVsLiZjGf2tYnRasAVt1N/JTpKb4QVXRnQ3EBH8m?=
 =?us-ascii?Q?rV9oNkjwWMSW1Cvoc5VFwC8W5BKzICbqv/vvjqBhDmaWXo5VnoyNz5d71Rzn?=
 =?us-ascii?Q?TSNdrMjAaGcqf3ICQnL6MOou8U/KH8D31Muh+/JTmT+q3d+701+mcvtiIVXE?=
 =?us-ascii?Q?3I1e6Lp6ZK3s9RKczJP474jm4nI2odERV07zQ/jpPSntPBD+ITagYN4Dzo8r?=
 =?us-ascii?Q?YoO9m1mhSwGegLN+z29Wit5zTiEGU0xE5vht96D05aeoMaSbvuFlMcQHaEHb?=
 =?us-ascii?Q?oY334wZhL61IU4M9OotaCQ7mODI+MYHnKl20tgxBRdqi4sC3aiZkLYOgKTro?=
 =?us-ascii?Q?4eMpIUP7R9482UgtN4kc7ZzscVI0I/EOKLKIOUq66XH3pLJoxYId1yG8lqJb?=
 =?us-ascii?Q?vnG92C0ziJaHrhcHRf2lvu8O9DqOTNiOHHXgfQ7d9hxKlF0iyaRXbWiLpGm+?=
 =?us-ascii?Q?hrLeuv1B5lsmZC45bRbQGt/TDd5y30kqealmzZyzo6eOh1ohpmlr0vW5lyby?=
 =?us-ascii?Q?OWsVvEFc7ndfVX++vGkCuEPjvH6YegpE8KmJ/mXfh0d0HWce65+hRQaNKScG?=
 =?us-ascii?Q?7/4e+i3MW9Q/Q0INjg8hqvQcsxQPZuM5S98TrWte1YB9Dun48EGg0vJV1qAV?=
 =?us-ascii?Q?QBzsw78OK0lhrcTMG1s2c39uEYlF/zHj5sik1ApuCtAV1jAPZJOT806yhlle?=
 =?us-ascii?Q?3u/ZAQYcAl7OZ3ZH8Vr1fCE2Y3G/Olf2/seteQA+MDUmzJS2cWbmoccVQ9/h?=
 =?us-ascii?Q?xMO4AP5U3xC/e4ckk8V++8I7Gyu/+B5uyGt3Oz92znM6HukU1Gn+GGqu8Y4J?=
 =?us-ascii?Q?S1touArIeh5VqmLMLAyLOCtmFhrXqVQv80jTOBmYo+h32gOpiCLBeSg6cTiI?=
 =?us-ascii?Q?PPXo79UKHt6OGSRMCsoi2nz6EeNwfcD5FzmYVzU2v+h1YuYHmmzM0xRMNm7q?=
 =?us-ascii?Q?aduKwLSzpLqw0D4PwsGuFJDiHLH81NI/uCfeBkSSDyWnrBRqkrg7KzXPis2h?=
 =?us-ascii?Q?KUoz06Mn0odx3Sb2MSfxmUE7GlABd4CB7EMrBdIbInbBd255TY5I3cfDFvDT?=
 =?us-ascii?Q?n3FudHEgnKcxjLvi4TSR2EY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <492D4E5667DE854DB000E6BB332DED6D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f06bd1a-a939-419f-4656-08d9bf02448e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 13:04:30.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJrxpKpn58zR/EfbL3pz2kOGrS+OeWWjS2TX1Tqn5Ri/cudhsBz6wK5/MPSEF8PW4sKYmJRshs5fdZjB/dGR6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7839
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 13, 2021 at 11:08:07AM -0500, Josef Bacik wrote:
> On Mon, Dec 13, 2021 at 12:43:38PM +0900, Naohiro Aota wrote:
> > There is a hung_task report regarding page lock on zoned btrfs like bel=
ow.
> >=20
> > https://github.com/naota/linux/issues/59
> >=20
> > [  726.328648] INFO: task rocksdb:high0:11085 blocked for more than 241=
 seconds.
> > [  726.329839]       Not tainted 5.16.0-rc1+ #1
> > [  726.330484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
> > [  726.331603] task:rocksdb:high0   state:D stack:    0 pid:11085 ppid:=
 11082 flags:0x00000000
> > [  726.331608] Call Trace:
> > [  726.331611]  <TASK>
> > [  726.331614]  __schedule+0x2e5/0x9d0
> > [  726.331622]  schedule+0x58/0xd0
> > [  726.331626]  io_schedule+0x3f/0x70
> > [  726.331629]  __folio_lock+0x125/0x200
> > [  726.331634]  ? find_get_entries+0x1bc/0x240
> > [  726.331638]  ? filemap_invalidate_unlock_two+0x40/0x40
> > [  726.331642]  truncate_inode_pages_range+0x5b2/0x770
> > [  726.331649]  truncate_inode_pages_final+0x44/0x50
> > [  726.331653]  btrfs_evict_inode+0x67/0x480
> > [  726.331658]  evict+0xd0/0x180
> > [  726.331661]  iput+0x13f/0x200
> > [  726.331664]  do_unlinkat+0x1c0/0x2b0
> > [  726.331668]  __x64_sys_unlink+0x23/0x30
> > [  726.331670]  do_syscall_64+0x3b/0xc0
> > [  726.331674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  726.331677] RIP: 0033:0x7fb9490a171b
> > [  726.331681] RSP: 002b:00007fb943ffac68 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000057
> > [  726.331684] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb=
9490a171b
> > [  726.331686] RDX: 00007fb943ffb040 RSI: 000055a6bbe6ec20 RDI: 00007fb=
94400d300
> > [  726.331687] RBP: 00007fb943ffad00 R08: 0000000000000000 R09: 0000000=
000000000
> > [  726.331688] R10: 0000000000000031 R11: 0000000000000246 R12: 00007fb=
943ffb000
> > [  726.331690] R13: 00007fb943ffb040 R14: 0000000000000000 R15: 00007fb=
943ffd260
> > [  726.331693]  </TASK>
> >=20
> > While we debug the issue, we found running fstests generic/551 on 5GB
> > non-zoned null_blk device in the emulated zoned mode also had a
> > similar hung issue.
> >=20
> > The hang occurs when cow_file_range() fails in the middle of
> > allocation. cow_file_range() called from do_allocation_zoned() can
> > split the give region ([start, end]) for allocation depending on
> > current block group usages. When btrfs can allocate bytes for one part
> > of the split regions but fails for the other region (e.g. because of
> > -ENOSPC), we return the error leaving the pages in the succeeded region=
s
> > locked. Technically, this occurs only when @unlock =3D=3D 0. Otherwise,=
 we
> > unlock the pages in an allocated region after creating an ordered
> > extent.
> >=20
> > Theoretically, the same issue can happen on
> > submit_uncompressed_range(). However, I could not make it happen even
> > if I modified the code to go always through
> > submit_uncompressed_range().
> >=20
> > Considering the callers of cow_file_range(unlock=3D0) won't write out
> > the pages, we can unlock the pages on error exit from
> > cow_file_range(). So, we can ensure all the pages except @locked_page
> > are unlocked on error case.
> >=20
> > In summary, cow_file_range now behaves like this:
> >=20
> > - page_started =3D=3D 1 (return value)
> >   - All the pages are unlocked. IO is started.
> > - unlock =3D=3D 0
> >   - All the pages except @locked_page are unlocked in any case
> > - unlock =3D=3D 1
> >   - On success, all the pages are locked for writing out them
> >   - On failure, all the pages except @locked_page are unlocked

Sorry, I screwed up unlock =3D=3D 0 vs unlock =3D=3D 1 as Filipe is already
pointed out.

> > Fixes: 42c011000963 ("btrfs: zoned: introduce dedicated data write path=
 for zoned filesystems")
> > CC: stable@vger.kernel.org # 5.12+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> > Theoretically, this can fix a potential issue in
> > submit_uncompressed_range(). However, I set the stable target only
> > related to zoned code, because I cannot make compress writes fail on
> > regular btrfs.
> > ---
>=20
> I spent a good deal of time going through this code, and it needs some cl=
eaning
> up that can be done separately from this patch.  However this patch isn't=
 quite
> right either.
>=20
> For the unlock =3D=3D 1 case we'll just leave the ordered extent sitting =
around,
> never submitting it for IO.  So eventually we'll come around and do
> btrfs_wait_ordered_extent() and hang.

Isn't the ordered extent handled by btrfs_cleanup_ordered_extents() in
btrfs_run_delalloc_range() (both for unlock =3D=3D 0 or 1)? Or, you mean
this should be also handled in cow_file_range()?

On the submit_uncompressed_range() case (unlock =3D=3D 0), we don't call
btrfs_cleanup_ordered_extents() so this part can be problem.

> We need the extent_clear_unlock_delalloc() with START_WRITEBACK and
> END_WRITEBACK so the ordered extent cleanup for the one we created gets r=
un, we
> just need to not do the PAGE_UNLOCK for that range.

I see. So, we need START_WRITEBACK and END_WRITEBACK both on unlock =3D=3D
0 and unlock =3D=3D 1.

> Also you are doing CLEAR_META_RESV here, which isn't correct because that=
'll be
> handled at ordered extent cleanup time.  I'm sort of surprised you didn't=
 get
> leak errors with this fix.

Ah, I missed this point. Maybe because it only happens on a specific
condition (e.g, with a faulty ENOSPC for zoned code).

> There's like 3 different error conditions we want to handle here, all wit=
h
> subtly different error handling.
>=20
> 1. We didn't do anything, we can just clean everything up.  We can just d=
o
>=20
>         clear_bits =3D EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_=
NEW | =20
>                 EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
>         page_ops =3D PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEB=
ACK;  =20
>         extent_clear_unlock_delalloc(inode, start, end, locked_page,
>                                      clear_bits | EXTENT_CLEAR_DATA_RESV,=
                                 =20
>                                      page_ops);
>=20
>   This is because we need to clear the META and DATA reservations, and we=
 need
>   to unlock all pages (except lock_page) and be done.
>=20
> 2. start =3D=3D orig_start, but we couldn't create our ordered_extent.  T=
he above
>    needs to be called on [start, start+ins.offset-1] without DATA_RESV be=
cause
>    that was handled by the btrfs_reserve_extent().  Then we need to do th=
e above
>    for [start+ins.offset, end] if they aren't equal.
>=20
> 3. Finally your case, start !=3D orig_start, and btrfs_reserve_extent() f=
ailed.
>    In both the unlock =3D=3D 1 and unlock =3D=3D 0 case we have to make s=
ure that we get
>    START_WRITEBACK | END_WRITEBACK for the [orig_start, start - 1] range,
>    without DATA_RESV or META_RESV as that'll be handled by the ordered ex=
tent
>    cleanup.  Then we need to do the above with the range [start, end].
>=20
> I'd like to see the error handling cleaned up, but at the very least your=
 fix is
> incomplete.  If you tackle the cleanup that can be separate.  Thanks,
>=20
> Josef

Thank you for clarifying the cases. I'll try to clean it up.=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97866777A39
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 16:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjHJONL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHJONK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 10:13:10 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359B1B4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691676789; x=1723212789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HwxuEoCVoCmUM8uUqskJolvsk/23k5xyowpqy+XFMv4=;
  b=WMYcoatngRS2aUJs6dJr1h7AYt7EelSXxrNuCTLiOYon+nFhzSM3XCuT
   st5vR4Vd0GTBntp1K/K/3+NVY+SwM0C3STLJqZZznqHll6IgA9673wvy9
   TmO2NEnGMz7C+wafd1gdU1NUJGJXW24YV64s/558WXidJtPgGwT8Sg6/7
   xyEKe9XwO9g810tQME/su0gJcU/ikh+UL/dKX+C/C/MKi8W2az41NXBiA
   mW6/xPoQRSqqJFKymC5DOJvdEfdM0VGi84w+3PoxaLAncxVzAKNSTWmRq
   EktfcPynao6DBlRaaiHwyiKP7sgLs+utDgNF9GzdRDrPVFO/Lrywp95y8
   g==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="240546611"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2023 22:13:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2HnI7I5ZnED3suCbG4GKUPxmVQNyWrvNplI8scFDydOR6hcLlZHprxStVE+dqrm+7TZUJh9bpD8sFLuSbVZk/NxPrt2TCUWUxwA0bNH8xcH/q5Yulc1IqnpWWQT4BRhNPvt8c43O08Uc9mMa7T2vT0LNM4jWhjHAc0Xc6KVDAXeAmW0E54JGaeWoowU9DxSaCebatyNAnW65Lo1yD5e6QX3Qa2Wwbw2gmc8auc0P/jUqoKoqt+OlAFD+zL5rycnR49gBKi39UI2z1swWJ009Yp47YUt9w+ocDf4Y1X+tUBbVqIak7a/VcuFxIEI3p0DHjoTSkxwonWRGgfduN8emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1XOCKiAfe5wKd0pfXd7lVWIsA/m6cMoWo9fOtaGHxQ=;
 b=C9Hswtkz2isWlWHXfdfxC5kXXQnoENMpKpIBjWqRxk8+GMLHwNHJqNHqnTd3cAVTzL3vLC0mnWOyyXmmiEOrtPA2XrjpbA/QSmNB8Qkjl0Qb7zsFSyoT+IG+KQ6jU6VB7n503X9/8g6BK1YBiWl1ufnIbSXSqDuRrp94Ni7wY8viytojWAtVcutVvpo7GBmlTCaNtsuZep0IjR5EPVLu7TQgJLYz+Nn9FD3yOJE3CCuTR5YhwsdOo5VMaTlgcU03aOOz01sqBAItNlDBQZpcsQiRdn6Dq7YH4pt4XRL0ZqOLLM+yainfCsZ0Y81QSwVh7Nvkcm/dni9oLaZDPjvZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1XOCKiAfe5wKd0pfXd7lVWIsA/m6cMoWo9fOtaGHxQ=;
 b=u4vjjxY+ZSJNlOWukuc9QQl5utKAq+l4KG0ed0rAzFjv6JqDGAYGsChb8VCcwsPLyC6Nz/V0EPbth5karuhpsydxr6utqOAd0d/JzocN6auRAJ9yD2Q5vVt79rdhY6v0k9UOh2wLK6sTSeGq5h2y8KTCls8BLEoVzCpAB0PCw7s=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7518.namprd04.prod.outlook.com (2603:10b6:a03:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 14:13:06 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:13:06 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v3 00/10] btrfs: zoned: write-time activation of metadata
 block group
Thread-Topic: [PATCH v3 00/10] btrfs: zoned: write-time activation of metadata
 block group
Thread-Index: AQHZyUoEGx7rPXcD/U+xC2mqEdFRKK/jgnSAgAAUhgA=
Date:   Thu, 10 Aug 2023 14:13:06 +0000
Message-ID: <z7gfmcysel4wgibe3t6m2352lirib5gtmtvtqpfrzce3mr43fq@ak3yulccgfm5>
References: <cover.1691424260.git.naohiro.aota@wdc.com>
 <20230810125937.GA2621164@perftesting>
In-Reply-To: <20230810125937.GA2621164@perftesting>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7518:EE_
x-ms-office365-filtering-correlation-id: 2b6889ad-2084-4b91-a68a-08db99abeaeb
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JeQgK6Nascck4tiarBzn3PbJy32yLQSVYnB3Ig0A7/j4VA2NzIHJzQenR6PF8+hjmUlop9OCcu7gIpBdz5Sh6/fmdwPzAfKLsR7PRAuRXUi9UpuXssXNlT6nUv6WASKE3t6F1gM6FNl8eOQlqsKRXqdNgmk/wD+tYVPW+32T4BMQJiqGyC2L90N8p672ukFYlxlOfv+mnL+x8NO9aZ8bysNLQnFJVmAGJ+KrO/Q0/lNkgz8LCVJkeTT0IdhR/ugv459sBl1Ko0KDkNYH43LEYh51+cJKkTz/MABvUSPUUiTgUtPbUZjDA95txsxZJVfoUodbY8xPH8K5uZ3qQW8iRnze5WUpvB01jfqEQ/rSrvDJFGzIyqol0Wm8qiYFMyrbn5sJ5pFSrLDq41qAA1lzQ8dOpRE6O/3BvYcdEqD3/KCl4WV+rUb3jvo13gO9W2uAlqsmOB+GmDkZZ7wg4xoHYapFbUPEE5vwe9gcr+Tl/YuuohwYznKKcZsIhCvrCBS82rzhVOT2gXMpCubnwNL/XNr6f3YVbus9sJrMGjsw9tc0p0lhBF3EIpGS1/1ue28bD2o7gZRNA02iB3mCPEn/4R9ZiMoBAwWqup2Sn0Jv7jc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(186006)(1800799006)(71200400001)(478600001)(66556008)(6506007)(54906003)(64756008)(76116006)(91956017)(66946007)(6916009)(26005)(66476007)(6486002)(66446008)(6512007)(4326008)(33716001)(9686003)(2906002)(41300700001)(316002)(5660300002)(8676002)(122000001)(38100700002)(8936002)(82960400001)(38070700005)(86362001)(83380400001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LSWx0pfr2ift0G9AjpXbrhtmN9fQlrkL/8q3LPi3OC6LdygNl41z6NJnQaio?=
 =?us-ascii?Q?VmoxZzaDF5aFdUW4zyB9B46FOVdy8e8xCdaoutUN/i1/XCWMlXIOO5+b3sNU?=
 =?us-ascii?Q?mIP1djGM4157Pn/Y5iIQnPkIPLyypizoyTdgJRyh50tmYxlhZ5BRUmILUriD?=
 =?us-ascii?Q?8n7Au3yXqTsRZADzn57m8Jo9CA7FmZY/lHR9NdkPHkCU5pg8IJBE5khWFIhn?=
 =?us-ascii?Q?2jXmJUG0r7dshdNiyEMNaiy6T335uMBjmxYMqWM7e8VFEPZsrj0Tkdd2n7Ke?=
 =?us-ascii?Q?Vscs6z3vFhZADJpw8gbAhnW80FyAQW5DU9yyFPHVVX09qseoJKXL6Ay5B/Lp?=
 =?us-ascii?Q?Obx3Qs1Kz+hbqAqqgXQ/wff6sHhLzbXOiR0SS9bZRfVCfDasnATvZrzcr/rr?=
 =?us-ascii?Q?QIFD6ST7jJhJQD/KQBN1ubjuxT/KdFHSnCdrFDySGPbczWDsgu3+X2p4KCHe?=
 =?us-ascii?Q?2IFJ7zmM90k8FoZVtV7IvUZHmxiZW2tYQxsRuXQsMWljRZE/BXyVLLTfSWPb?=
 =?us-ascii?Q?/d8Lw0g+tbFNgcxJTLFHfUrt/zSyg0Ijtb+JKQ3G+H4a3qIKSlDJIkPAaGU/?=
 =?us-ascii?Q?8L5MWC08hCei7e1G9lu4jE34X10hnuEFlSgR2b5dusnVZPT+EfLfzp4H4y2l?=
 =?us-ascii?Q?9+NHEXSgJHhL+5HY0MNv+tSnbBr25NXRgGe6tLbJ5zStsVtaschJlqcDWVVt?=
 =?us-ascii?Q?dH5u61mO3h7U7r16S5rWUkX0kSLIwFs+a0REAm800+umIhgSAEC0JQzgynDw?=
 =?us-ascii?Q?pZp52gnkNLPPUj7AcIVDei2Fpq4AFYousqdayNNwRqIXMo62Vd4Ju/UkFJM6?=
 =?us-ascii?Q?UDG/7IMBs26cOFUl/oIoN2tjrwNFQFGBUqhpgK/wU5AFnD3xQKiCJtaB6xlv?=
 =?us-ascii?Q?lxZbXLIJQ8OJrJ6FS1NZZ4BzGqfCtYVwSuHFGoJhN+uFx5F46eehF9gjMNs0?=
 =?us-ascii?Q?5ehQUo6N/fLcCLbdm9DG2Ar6AUQOPlahYCu7tKAqS0Xy0QcSXokxbyNm5vA0?=
 =?us-ascii?Q?DTGmGKrDxY71uC60jpsvfNFUdj1sq+KbXvqHm1bhNby/iMAO8dIoY+Rivwlz?=
 =?us-ascii?Q?z2KO0NTDv7VOQsKIQuslxjhYq75nRciFFoAYdPuFkl6Jn6rd+7NU+XIVLyJx?=
 =?us-ascii?Q?BxjKyMt/dyAvVy9ghn238PcAQQdrGGHdtmwGqqdd4iwyUGI8vk9AmjmyxHEm?=
 =?us-ascii?Q?xASzdbXhKVf8IG8L8qhX2pecdYRo0ZOlPwSfCtsg/VUgROFR+4p74zfozo+J?=
 =?us-ascii?Q?L09jwNbHsh4nXC/CIifOHjPZfumRLY5M4bsYiy+Eu4goNqBIWca+wUv31Ud3?=
 =?us-ascii?Q?nd+IsXSoel7IqbKtKp6VrLTf19c6Ai7QNj1ylhAT0QPpW+0MPD4os0egFxWA?=
 =?us-ascii?Q?XwYLalqe4VbcVl5u9Wysz4KpNnFDm1fDox0W3sbOC1JR30rqc/vE2aOAyue1?=
 =?us-ascii?Q?Acz/TQEfA9QWnZQpwHuYs8+lD3FHcdpBX3yOAv62iaJVN77MSttObusy2i1g?=
 =?us-ascii?Q?fqz6pvS9vC4/mDOSC5wq7fZHry4vz0aQzzt0vsS1UMR9QIU51uLvpp6/RqMu?=
 =?us-ascii?Q?7H4hQaCvckek5pTx+Lg45NlX2CHsAxcqH1Gck1z1yybLdrA/3Z8zKfFRapQt?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80C9D21245EB374CAD5743B9D9BFB037@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yNP1tfBzCLqnRS1ZF50PY4ViuQAIX44/A4Jn2acleg/2NJbaznqiCHxUOxnx4pa1uw9ERIjmeHmAYb3KaFsGbK2Mqxj3LBMEZk60wjmx2AMCxcwLq3cbNDldTIRKnv3XoGNpkRPg4zeawXvJgXRdcXJt/WmIs+ldOXzJix0lYJGcLsHswW1HJR5zjdWdZAYHT+QxyEmArEgYdOtKrAgxjhQmUY/ubrZnwyL/Fkol8tnPlBvnElZ9qgYYFKP2xkuYVSEwbtuYpplUuffjUySF6weBxbLZndm4s/BJceGtWu6HwNHZfWF3KNwp9KEnScYQjdltAMTRYvpiTTEYnb+MFPiLRyWfnTcmdbhKfL0gtD24tf1Y/EEbO75EKv/5g+RK0m2yB+8xSwgRFB6nKWsRRCwphbesRDz8lW3fU+7wB+jwkhMpfS8oWa7XjgCfv8xGYIatews2mXByTzTDNcrDIYKSvkOH6bUjhmf43mAHYoQah+upyY1nlsqNmYqZnCXolVqiFgfHmGNxBem2wDgUVA0ZB9dB7U8X8SJT1DEE0XH5BXIbwM1X8Aj4eU3gMAmVHPorTbDpkwS1IIYPsk8G+JgpFLW4+pSZ+NDiPNn6kHUMM6c/AwGaqWhz5ZD1Q92mganAPrIpKr60v9cbyBm+lsLtv075CEqcZ21hi45m/MqbzTJpBr2/kePi2MJwJE3I/0ZCahBuWGPRpAAMwXPROA77EA2+x7MIhiAmZojyudKovSQdsSjbqbBqDQszgu6G7l/vNHYwQSQIkhdYoQZXHoCmZdNwtMpSDJ8MGcc6BYwuSL5ksUPtBJ0902pvbqCB+m2QiHLNnc9BjkeywTOSuAT7AAaRRZMd+T5isXR0I5DoHoh/QOgj2L5UafFzVqGz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6889ad-2084-4b91-a68a-08db99abeaeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 14:13:06.2441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCjTrsgZOMpBu/vwdNd2fdruTuSFheu9x2b3cXXcpjq+Q4KlrQhkFrx6yY9M8j1KbWPRRoLIJb/JJzw5HMt8Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7518
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 10, 2023 at 08:59:37AM -0400, Josef Bacik wrote:
> On Tue, Aug 08, 2023 at 01:12:30AM +0900, Naohiro Aota wrote:
> > In the current implementation, block groups are activated at
> > reservation time to ensure that all reserved bytes can be written to
> > an active metadata block group. However, this approach has proven to
> > be less efficient, as it activates block groups more frequently than
> > necessary, putting pressure on the active zone resource and leading to
> > potential issues such as early ENOSPC or hung_task.
> >=20
> > Another drawback of the current method is that it hampers metadata
> > over-commit, and necessitates additional flush operations and block
> > group allocations, resulting in decreased overall performance.
> >=20
> > Actually, we don't need so many active metadata block groups because
> > there is only one sequential metadata write stream.
> >=20
> > So, this series introduces a write-time activation of metadata and
> > system block group. This involves reserving at least one active block
> > group specifically for a metadata and system block group. When the
> > write goes into a new block group, it should have allocated all the
> > regions in the current active block group. So, we can wait for IOs to
> > fill the space, and then switch to a new block group.
> >=20
> > Switching to the write-time activation solves the above issue and will
> > lead to better performance.
> >=20
> > * Performance
> >=20
> > There is a significant difference with a workload (buffered write witho=
ut
> > sync) because we re-enable metadata over-commit.
> >=20
> > before the patch:  741.00 MB/sec
> > after the patch:  1430.27 MB/sec (+ 93%)
> >=20
> > * Organization
> >=20
> > Patches 1-5 are preparation patches involves meta_write_pointer check.
> >=20
> > Patches 6 and 7 are the main part of this series, implementing the
> > write-time activation.
> >=20
> > Patches 8-10 addresses code for reserve time activation: counting fresh
> > block group as zone_unusable, activating a block group on allocation,
> > and disabling metadata over-commit.
> >=20
>=20
> Hey Naohiro,
>=20
> This enabled me to turn on the zoned vm for the GitHub CI, we're only fai=
ling 7
> tests now, so great job!

Thanks! The github CI setup is really interesting. I tried to figure out
how it setup the zoned devices. Are they QEmu emulated ZNS devices?

> However all the !zoned vms panic immediately
>=20
> https://paste.centos.org/view/54d11384
>=20
> Can you fix that up?  Also you can submit a PR against the 'ci' branch of=
 our
> linux repo in the btrfs GitHub project to run through the CI yourself to =
make
> sure you didn't mess anything up.  Thanks,

I sent a candidate fix as a PR. I hope it works well.

>=20
> Josef=

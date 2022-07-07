Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFD556A1D9
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 14:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiGGMUa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiGGMU3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 08:20:29 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94425C5A
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657196428; x=1688732428;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BNhaZBinztTeyiJzn037R6Qy1yRd7rDGGBWcWGFyAEc=;
  b=SjjKi8VzozxK9KpKuGfQxK4tYHmXDr7XjGkpAx39gH/8kr6DMN+c5XzJ
   f2RVVYAH6kmTlPZDjhtdV6brt3N4b+hmN4CN8V1g6VpnY3R6ACgFL26qi
   +T5ww3gbCVpzWDCJLL1jWaJgTbXCXQ+btek9ZZ7YD6G1SCuh9vsYqkA0k
   epdKW06Wh5kN9YNxxVwoF4dZg72Goah3IVkOWT2RbH5XsFPQ0XIgm+MUY
   /KaaTm1a4DxrkV+VfPF42L6yww74kQSD7F1VQOkHnBFjw3glOYFFjWQ1b
   gAoGlK81gxclUptA4rnCkARvriYwVHeiRsJ9se23bwGBgO+wIrmzcjM2G
   w==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650902400"; 
   d="scan'208";a="309405721"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 20:20:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4NN+yvqZBvh79g/96ZBS8Se6h6jv4M/hwjN5El8mOSsaniYjm0bHV//DaokL68Lg5lWiioXokpxtZprrPViGvfPiyTESBAV3WdKMXGxeIlZnqZa1KVKOGfyQ8rkPXUb/RRHkD2Y2ndSDyYul/rr+x04R9DHwd0LREDNfn0PmIE9pfqwz//30NW2CkVhxTJzDPoB7o1e5+6Clg6mHQVZZrmyns9+nLyqAybIpSSZXDGmstMx7DrUSH+7W/UHWBioxsg0iq6hwwM5FN3tdvbhieelYfPP0YI2vaCgTHE4RfyGYktCPA7y+VA7JX3ai8f1h/74iYJoToJBLA+hwZh9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ivcq/aWtrR6S3vlkIA0Q5TM27gyzrLoxMGxv0s7bXTk=;
 b=eEdWECCfXmunIn7OMRmg5O5P19VNfFX998vbk4l3N5TPQI6xN5w5KM9JkrlMvlzLj24Z2rvIxMPB48fnF+UAuTiG6w05YcGNMtl5WlMifpYrRJaBj37RShvutAbhzFDRMShyPXKdXV9uEkiiw5Zo7xD9FNE1nipjiWwoDSZs6XyYqcuNHd636if+P8agzuCBn8PTq+wjo7FVbKjHEbh6/sM0shRbcDj1rVfhqIxDK1v+bgXNlcV7zcyVuFSRxgW1wv/7vaXtQP4ri24hBazCVfNJWI2mZDp6I4Rs5eZ2Glqq3zpXsIaLiB0T2q5KkQXEugFhTe1r27YvKnN18mh6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ivcq/aWtrR6S3vlkIA0Q5TM27gyzrLoxMGxv0s7bXTk=;
 b=dYmS+VdUEwzUZ+qmettUw+ATOMySoXp4obR/wJvo0WvKN0WIGYEIB4U5NDKr22DT+6VgWK1dXuWs3cg2XzRweFT9784fbMGBpKBshCCh7h0riyU/zRTMJc9j4c0WlNtKRt+9P0YOYVcNYwDzhYlBZDqnYAlqSp2NMA7C8+iwRKU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6597.namprd04.prod.outlook.com (2603:10b6:a03:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:20:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 12:20:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs I/O completion cleanup and single device I/O optimizations
Thread-Topic: btrfs I/O completion cleanup and single device I/O optimizations
Thread-Index: AQHYj4JCR+/hYx6LmUG+7l+1CKj92Q==
Date:   Thu, 7 Jul 2022 12:20:23 +0000
Message-ID: <PH0PR04MB74163F80415D45EFB323AE869B839@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220704084406.106929-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c3eeb86-b07f-4590-04eb-08da6013114c
x-ms-traffictypediagnostic: BY5PR04MB6597:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wcQz8zXLolF/A0hHiVWPrDtp+i0jYUM9bS2M6L2nfmf3eLQ1znnw3kBi39MUW8DFsoEsPZZFQrz+bOR7lNSfdwIXGmdSvaPSsx8xmc++hWpizPr3Ds0nEZeCqnqGVWsiYQe05UpV86heVImcY2caSsFpmlgoeO2DMD9TE2FJqgkFGasBvMa5B6fbuCNqfSZgxhYwuoZ7smsCCRVc2gVp0WcatXpaECN6xULDl+2qniV7FIl7P452QIcr2zCLFGqJ7p7tNzncs46QQUvRHzsFd6zWebNVE/XaoID41U/J2c6Aj40R43coE+KkUzGr4zo8umiAYp+TXidvf4Vd0dRHXpPSuubP/PNwgWlhulVS47Gn8PH8s7hRAmUsDTEmN5Bktiz4wYxjmduozOb7dg3kK+dLGrTyQrQIqCf5ciS/xlRvM+nMVixPRL1JAwELlJY+CYKseLYiVUXtkJvWvqC4b/BW5wg8x183pJIj2DOMRa5m5vRhj2Nlj0KxOAS2CMON7C9dw8z8VgRttbMJzDwV5sKt5cVC01SuO3imVof5bpTTdCZ4Zys4hHtJS4RTnqFq2ucgae03qXE3EcEF72SpdVhF2oh7cgCrHG6BPvPPJeEggKlh9Z8ZVdsisHcW3exBM1B2g5taFytZH+51/yYzQldPksm7ONwvNna2Yq/Qn7u94krU/HENcxU8sR6x7YTeDvgWXOcUDAoR15Pa4SuabKp8c7doavKkKQZJ+V3VIWQFq00vsZ6wrWx2/WDDbn4Re4wpfQlIRhkOylotU3hiqEKyVg1Ca8Ll4llKYyMnL1ADwvGNCtCkwNzHd17dS4Tned3Rk5Tt3plc95pdbyw/BJwsHqQSePN6IHMo4ML9Fdg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(186003)(38070700005)(38100700002)(110136005)(316002)(76116006)(91956017)(71200400001)(8676002)(4326008)(83380400001)(64756008)(66946007)(66556008)(66476007)(66446008)(478600001)(86362001)(53546011)(9686003)(8936002)(6506007)(7696005)(5660300002)(33656002)(52536014)(966005)(82960400001)(122000001)(55016003)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sx/eUeEvNsrYF2WR3cBL9UZ6aU1KKudRxRmo8U0/BKTYBzwvqd35x0mX3i1q?=
 =?us-ascii?Q?9L+iAjDXshTJgdjSUjLTmAlfGTGwAxS24ZHwYL+SHyZeenJ2wn0vgO6gPkum?=
 =?us-ascii?Q?yhoAxg7Bwn7jjDxnNlUl7lUN3xL3jKzvJX9Bsjm/vM75Du90gjuIOGnZIWBG?=
 =?us-ascii?Q?S99g/rZOs86ePOxqaEr3PxH2/xD3pK1kp6XqRD+BQLJI16N/vzCpfVA6/1YW?=
 =?us-ascii?Q?o7yHQmEv+XeJmA9gJJfDjFYU0FUeLnOYSe7UWprCDb+aPGa+GLL8sMvWbTkW?=
 =?us-ascii?Q?t2kFC9MF3mOC7VNhqEsvcy16nryc10vrSFbs/4JxnCxfRl+Nu3hO1Z613+Ta?=
 =?us-ascii?Q?6qBHh87+1vDO1QAVzFOiII7VZVpj94bAr5HOW5CXfSolHNUcZPrSfsiu5kHa?=
 =?us-ascii?Q?MAaH8kFt5Ox78/mzBnhwbDvWVGdM6cxgrgJKptcluXkpzbiDtRy+oKMzteV7?=
 =?us-ascii?Q?PM+Vq2ihMuoSB4RcewbQM9QH2LeLVfNk/0FGicOVWXP3eA6YyVLPFzptHbT+?=
 =?us-ascii?Q?N9kMPQ5w41ARshqTJRcmqxnsGaSYPFRfEvj7q6UiH/MP824Be7b5nk00ty8T?=
 =?us-ascii?Q?OUBgaL+Mvnep30ZfjKBu+2+9iOF5vbCunqUMmg4a26r1/6ifi9XucG47evfN?=
 =?us-ascii?Q?DzLc5D2zKReDwN2uslz9++HC9kPXxLJWmeBFjs4a9ymCIU1NP3H+x0NsG/37?=
 =?us-ascii?Q?+/c1ZmRCEsCIIUS7/gFSWvubZJm52DyY5IkvqKnYtUbu7X3qEGFZDutazIqU?=
 =?us-ascii?Q?ua1Yqf217A88FoN+84FnAPb5t/UNepmije9SJ0e8ppFZjCdS6W5PUf5LNKwo?=
 =?us-ascii?Q?Ly6+91SRPY/tJgqZSHJqJCput5FhdME40AtlFGzWYhjX3+s6zFq0fltG3w2A?=
 =?us-ascii?Q?H8k5+g8GzGJCOs5dVAls6KudOE0ZCbd/S42nED9Z5BwWb8mc2yrFDy1xaor6?=
 =?us-ascii?Q?TnHGjPs4ntwvbntV+gaZifk8wCxiwviNrJW4xdFM16fXI8gFN3uljIUbW2vm?=
 =?us-ascii?Q?Uuh0AOVe+Dfe3WL2kSn2cnKWRb6mH5SlGZUKmhCr8orTldzqg+8GjfvfTy/V?=
 =?us-ascii?Q?gzA2sON9RMlXtnEnC9GiiFHKURsY+GvR3etKtoi6i4Fngaj+4OnragD/Ly9O?=
 =?us-ascii?Q?BWolzUdk3u5ZGy35mSDYuvtrVbq1gFvlvnrPkfzsvpbugjyYLb00JVT9FTJ8?=
 =?us-ascii?Q?sfgqAPrK7z+KXMh7FpHfzEdxHJaPkeAigXSxDipH0jGua8orU7BNU7jqca1s?=
 =?us-ascii?Q?FPy9I5LqQjnPCIwOxgh1m3OQlGagxrtSV9pTaPvY+648V9vnz4vKpVisO9+0?=
 =?us-ascii?Q?pqxjlRrN3tK+TaFO6fMJVE2pS8yeJG9yOVXhFtQzAFgQOAzQnmgnb1WO6Lt1?=
 =?us-ascii?Q?gsR0HuHO/97XQ7b1FJPowSwgmoaoizy4vacvo/RmLN4yUZ8ggubYL0M6JEwv?=
 =?us-ascii?Q?XVEu12WUdFMzHbThgkYwG/Ni1XUbS5zjaah0Dq4lFtqFishkI07gub5cfKUL?=
 =?us-ascii?Q?nviPUbUAZtPe09sP8g4Q+oZaKYqin9KIBYqttSkDrNR9epP3Fl7eXHz1WkVF?=
 =?us-ascii?Q?+IrstohNPMFfFdV/9Ho9+uvG6pA0uBQ5rGaDx7VauF/L9lbj779lzOFrtPb7?=
 =?us-ascii?Q?scqqApCiidWHOPcFPGUJc3PfQrBQyLvnxfKyKofM2+N3cu5AfNaSQpdirEje?=
 =?us-ascii?Q?t+SCUw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3eeb86-b07f-4590-04eb-08da6013114c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 12:20:23.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiwShPIX0CeZB89QEd9Vja8h90BR8V5D30qBg62f0MIQPGHVG9A6sNfIlJZjE0r9ZH4dDM00zBto9w6bEZKcpIflhwY5NilCeq7Cxbfp4X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6597
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04.07.22 10:44, Christoph Hellwig wrote:=0A=
> Hi all,=0A=
> =0A=
> this series cleans up the btrfs_bio API, most prominently by splitting=0A=
> the end_io handler for the highlevel bio from the low-level bio=0A=
> bi_end_io, which are really confusingly coupled in the current code.=0A=
> Once that is done it then optimizes the bio submission to not allocate=0A=
> a btrfs_io_context for I/Os tht just go to a single device.=0A=
> =0A=
> This series sits on top of the "fix read repair on compressed extents v2"=
=0A=
> series submitted.  To make everyones life easier a git tree is also=0A=
> available:=0A=
> =0A=
>     git://git.infradead.org/users/hch/misc.git btrfs-bio-api-cleanup=0A=
> =0A=
> Gitweb:=0A=
> =0A=
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs=
-bio-api-cleanup=0A=
> =0A=
> Diffstat:=0A=
>  compression.c    |   50 +++-----=0A=
>  disk-io.c        |   16 +-=0A=
>  extent-io-tree.h |    4 =0A=
>  extent_io.c      |  117 +++----------------=0A=
>  extent_io.h      |    3 =0A=
>  inode.c          |   57 ++++-----=0A=
>  raid56.c         |   45 +------=0A=
>  raid56.h         |    4 =0A=
>  scrub.c          |    7 -=0A=
>  super.c          |    6 -=0A=
>  volumes.c        |  330 ++++++++++++++++++++++++++++++++++++++----------=
-------=0A=
>  volumes.h        |   19 ++-=0A=
>  12 files changed, 343 insertions(+), 315 deletions(-)=0A=
> =0A=
=0A=
For the whole series:=0A=
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
(fstests on zoned as well as a base branch for my RST work)=0A=

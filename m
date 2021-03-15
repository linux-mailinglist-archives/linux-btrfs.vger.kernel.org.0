Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1F33ACDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 08:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhCOHzV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 03:55:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51444 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhCOHzN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 03:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615794915; x=1647330915;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3pLftOWZYZ/fBNUjavBkPYKZcTZCCP/INaH02tbqjFY=;
  b=jqVCN7OqFCJLtTLgoLJDCXu+TNuKGI44+CmCJFqKGPPr5MoDjWHMMjwj
   k8M8RxE7J5dYZWQbPyMx1kMJpNVkMIWpUvjDXq+yYhYhd5B68N0MNG12t
   g7h+ZKXx1QNsK54S4WjzX2wEEz5ElkjaM7kvUioQEuT+LVunZ4gGt+dUQ
   N7SLhyyXBUVShDm0BXP1DkgMEZQZqHweYijNM+5tB87dPx26tOkwkRiOT
   AFLUYDiOY2A99web+Kx4gu3KT3nnZGKZjcr5H1s49VBxREmQT2AZq0zGV
   GbQfdMMourMIKmVtY4qrE6t24/1BKZQuwWt0GkvUj7zKuCMXdjhjKNerg
   Q==;
IronPort-SDR: KslfwkqPV9EDxAIsVQX5xnfDqbBgHjGScrMaaUBiw1SsFYlzSNWBF0oFeRWdjgWeW0mKjg2EUo
 knoPvLBMfA3Hsl1KFIoabgPPZO4KRRQe5n2PclXmP3FKGp8JCKRVkgn9AFbgmk6eb1ej10D1Oq
 jJM+IWWa4npkFky5oqMZ3zU2KQZwdbLCHV55N2xvWKs557IOOzkssn/PccUhF7+pc2E71qCe4H
 rDxO7LPwlWO+XBTNp9et/BbbWamvYKCBMdNRqAZRXdEFcfA6Jj4qfLrxOlZCb7WRKX9HtFAvor
 Gs0=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="266525922"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 15:55:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk9cWwQwcCb16A6+ABAGXfXvfdBEHtyYZtBbDfkFKUw77rVYagVu/ukwExXixHkh5L1YfeF0iA5BNrV/jXqkqnrVbx0hrJRBBgqGnM5/bI44KrhwnfSH05A1tsM1BdpFGpa+eBAKJ5ziH4wlbOQzXQKBHe/vLD1Ey5QoX++KEdgMQqxqMH5bM7cCr6P+Ej/E4DSqCHpWZUB1yhcP/sUQyk3cEw0DgUAtNaYdSDQrRuTnY5TNXZwlWhCruEvHQPWR0WpcnTl2JCHSJ6jVjK8l3K6OmhSQvFN8gViRgFa+ObfNhYu/cfq7pBDqcZff3WqUR88h5vBdmflKelwK2Zn3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jk9Yv7xFbWUzqSCBsHeoE9ZPaDrYmgUD6uMHXy946U=;
 b=Dhqcfj1/vkRP7kaGyW+A80UgbQTDe8NUf2vJFJoUR0bKIsxqDUQmiggsg5AfHIiWhZ33NYSD0Hkybkg9LfqGPRyexp08rg8x2eN5XDgdwZihXLNmf/FL//RNrpy6JumkMDetcNs8qYhoYGJCf7GGE1KOIQpyvrTDklMLujp7vaUQxTLMl1LEYSiPHiNdhDjg/wbPhAV04Y8JCzovkiYPjzg1gj23hP9Br6BaAR19oakL3iOQeX1QrmKT5UCccu7+NfIbMzO97t3C3XEb3yh+9T778gTgfkDXvhgXUD5K5obVzjCEXqkjksQV1IIiu/yBZGaSomr4oMjvgGJp7APZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jk9Yv7xFbWUzqSCBsHeoE9ZPaDrYmgUD6uMHXy946U=;
 b=mELBnfQs7mAenHP7MPV+mQEENxGmSTnlUfeGIbmE1wKTardkIGW2thd8VC2TJbJaIJnsZoOPEyEl1XIZ4d2sfCrVkW0zePDaGTU+NBHH+wyPILmI7PpmJc8sypFafG21+u/KRyqrG+PUAnZugnC6Yfm9f7RtVhJc2k4xnUr+kP4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7463.namprd04.prod.outlook.com (2603:10b6:510:15::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 07:55:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 07:55:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: fix wild pointer access during metadata read
 failure for subpage
Thread-Topic: [PATCH 1/2] btrfs: fix wild pointer access during metadata read
 failure for subpage
Thread-Index: AQHXGV22BZjeaMc1wUCUvWo0YnJERw==
Date:   Mon, 15 Mar 2021 07:55:11 +0000
Message-ID: <PH0PR04MB741641D5C56FD335C864FD0B9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210315053915.62420-1-wqu@suse.com>
 <20210315053915.62420-2-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:6d29:9a36:82c2:4644]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a4b091d-9325-40b5-a5e6-08d8e787a934
x-ms-traffictypediagnostic: PH0PR04MB7463:
x-microsoft-antispam-prvs: <PH0PR04MB7463ED6129117B97C5E016A09B6C9@PH0PR04MB7463.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0zr1XOq3OICIbshGx6Te67WBafe1dxYLuKfd0pu7UaXQrOluex7LGNB7Cf8InZAF/R0UMHuFvq5OYOw7iv/K+ySlZvfXfiYrNf5s3oxXiPtIhGR8SYhfLr31NVW2WpYTziZ0Bb2Bd9Ht70DONX/8jSusRTsnC7oSnjcc8DJLwiNiCxFRpUTW9nBHKjw3BSt3XKveKBaZKwmYpryz2neJykGBFT58EKG09nkOjNKEQttkD0eoG6bbcFJso6dz99XtnaiZSmM95+Arhqnk4D2rpkRTByJqVuRb+4CJFUdWSj1DKDf/4/nS5R89U7It7OttLMTMb1Xoi1XEhW1Uk0opWCpnoPXUxbszSeyTAzRLUKtgvXg4sdRPiWJu7xaL34F9+gNING5731dqM1PDTZmxC7CJEj9yeu4HDeuF4U/Z5aIbiMLIkXVt34ipBu+ydlR6J/j+DpNBB19mzYY0Tpk0VamKUSnaLmEOhWpNfpMRFDYam9I4wIBmfwRWue5bmi/NMoJnZ7L+AlFPKnTlAzimhxpBtbiYxhO++LyWIYb8+IcHPhn3wb3uFvi4nU90RGKDL7lgp2409pUwjO3o6zUHkc/BW3WBOfCn3t3kWYyRji1Bojda/3WYzWXgvRa07nGg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(110136005)(478600001)(53546011)(8936002)(71200400001)(9686003)(316002)(966005)(2906002)(7696005)(186003)(4744005)(55016002)(6506007)(5660300002)(8676002)(66446008)(83380400001)(66476007)(86362001)(76116006)(52536014)(33656002)(66946007)(91956017)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zrvlWQNY3XZgXktrdhfd3vi+o62r+xcM9PuboEaYBRnmi9iTq/CDUW9QEIux?=
 =?us-ascii?Q?OwGMWdrPqicqdU+T+0DZZ5psq4zv/qpmNkUaFlLnLns/eOl3VSi5FUsesYV8?=
 =?us-ascii?Q?6vOeuKOPFg/ndHwxjzLVmNyKHcrYDR16kUUt/m1ZIPqSNo2waVzRc3W6P5H9?=
 =?us-ascii?Q?AuSnD69SK1n/kqB+xVFw4IttgvOYla4YY05Omuzwl53FKYlKSx5bsG3UiklD?=
 =?us-ascii?Q?svGj0j8V+xmePdEgh6zVOysmkuN5sVgDmB0vGWuCW3B91h+MQdEghmm7DEQE?=
 =?us-ascii?Q?Qh38piAhki+BCA/0PJOynL67+pmi0bp9zzX6UbZL4f9rhaVinOR/P1Eii2V/?=
 =?us-ascii?Q?CEbnOhYvxjm964KoQL/HFOnmeofotyAC4V7vhshwbCOuGtTY8U/Ppfo71DMc?=
 =?us-ascii?Q?q8rhTnMDgEuY6fyKrUo2/PeU9asGV72sL1nhp3dQp7IxUckLqUzgUpCKEJbg?=
 =?us-ascii?Q?M7VS0YZCMnL5lEPYltJy491N1MeHTcajkKYJIuxdDTkWTN8rSZYC/yvlVf/l?=
 =?us-ascii?Q?3gmSU/bJGZZQ5Bt1aL57ZN+VV4tmuWCtwq3vSwB6R6wjo8tleb18KepOtVT7?=
 =?us-ascii?Q?flxF0+6f2CbrAKilIL7zUIOSRIyf24BYGiWOsZOq7NyCkULGV8X386Grd7Js?=
 =?us-ascii?Q?Ta55Droe1FPz4hEoWeFkaQ4ptK0tEkhKfYKCkh7SGKh0Nr0hDINIShuudyUF?=
 =?us-ascii?Q?GaMAU8pG3Lo9dB0FYVbwqal4V+4cWMt8kXdLbf9pf0pkDed2ECLQlJ6iIaZW?=
 =?us-ascii?Q?OExwwrcmiXubIFY34EW9L48cEfTHIarStBuAQHU4ExJN2IMVnj+RoYAa6bNs?=
 =?us-ascii?Q?pzQju1urAeSH2/8cIFVE5eV2umfZWchqQIM27/eshEtgzuW8eFkwpWYk26t5?=
 =?us-ascii?Q?cTOrordeV2iI95GVt7K78Qq3ve++cgS8vuTVdq2uXqZ8idwWcKVCqwoSPwig?=
 =?us-ascii?Q?vJUcKkQZ1MtmYr0rNml5vp/rgtEe3yBvQ5ZDn3QM1NlIKtyw8N2+yfHrf/mI?=
 =?us-ascii?Q?ohEoQpHSAg7ydSDYGFDiGh6pCxTvTzuWs32pLrL6Qq+H0wRCHMusLcOroNkL?=
 =?us-ascii?Q?9yGQYdEMCTyJsNVpfp1TvJZxTq+m2V/EAGVaQZ7sL9+LLogc+wfVqFGM40HC?=
 =?us-ascii?Q?06kYuI3Xl7BBDszfA2RAWSynpcr2/HM9w2uD1HbvCN5Sp0NjDBCPNrx4Ejzl?=
 =?us-ascii?Q?wSnlAfhgiCH09KYaiZumeC8VjGZ6LmIW4WDc+Gkx/20PqXF6q6oWIr4o1m4/?=
 =?us-ascii?Q?f6dDIabYvyfHjjtEIo0gptk5vYB/vbjo63ypqY+uTkuG9LcpE2FVZC56U1WU?=
 =?us-ascii?Q?/U7wVJoIQ/XiAbCJwZ1EPtgV419u4XzXRSIfCQ/snAhxExHw7ZSvI5+P5Kkn?=
 =?us-ascii?Q?RTXY+7C4aTb9LO1CyvQ7aYDc3fOpFjJw+rBm8tzGwDrayWP3yg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4b091d-9325-40b5-a5e6-08d8e787a934
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 07:55:11.6464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LBv6FRoAo6iieicVy582S1txIcm20GeBV5Hcc4ZedXUXCEXxMJxSH7ZVJoxtzJ3zF8t+OkzWMC8yHZJyziKff7zbmymNnEcwxUEBSyalGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7463
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/03/2021 06:40, Qu Wenruo wrote:=0A=
> The difference against find_extent_buffer_nospinlock() is:=0A=
> - Also handles regular sectorsize =3D=3D PAGE_SIZE case=0A=
> - No extent buffer refs increase/decrease=0A=
>   As extent buffer under IO must has non-zero refs.=0A=
=0A=
Can these be merged into a single function? The sectorsie =3D=3D PAGE_SIZE =
case=0A=
won't do anything for find_extent_buffer_nospinlock() and the =0A=
atomic_inc_not_zero(&eb->refs) can be hidden behind a 'if (write)' check.=
=0A=
=0A=
Note, I was looking at this version:=0A=
https://www.spinics.net/lists/linux-btrfs/msg111188.html=0A=
=0A=

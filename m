Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9197021D1FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgGMInI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 04:43:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54208 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMInH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 04:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594629786; x=1626165786;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AojycePWtIwa2u+0U9D7u6u/BxgF3KnTxnqrGhSUM5A=;
  b=ZHaGp2OqRGe3jg1UjGazUkeIxft64q6CvT74BP6xEkt+b/QeepZEmcMk
   Qk+yRUHQirAZetrZtjPp8gxm2S07gfZCORa4LnSSDHJF2VQl8fGifBQ/0
   By3f5aolvsmTX6Q3WEw7YAZxcPT+z2IJ8a0POrrNclLjDfgJAsCyPbK+n
   0H20SvAvdegpab4L19bD4CwjpGcZlq1VocRkbkLAg3zm475/l39a9lZRJ
   zEGyUItGZbawukEEACDNzAnqTqdNpuKFvBGoJ39ltnsqp4bvvnVpnaQcU
   HNKDkhJ+xM7mA9hjb52+IKE3rMERgKHve/QzSyqlW90HxAlDeWWxxghD0
   g==;
IronPort-SDR: +P/vEBU/AJ9DfIlkC0SJEsCBKEamxwRZOpj/4ChNKiYetDojj1iUFPEUJYNDrXrQl5luQs5cP/
 PMQH/AKRmJwbVm6wji1Pib7dhHwNPzwgxIylumAyPdvrS15ddo7z4qCX8RfsyeKCPOgdv3zOaM
 E1jY4GoIyZkD0lWwzwt5AUrfHX9J66FZgQSfhMe7DMlhqJt12nxShK9PqPc89rkqvVj9EJ3KSi
 JLitYRs2tT3FPnTR9vVhIEloKL56bkBGuw/UUtbaeyyOxh4jK0e2DL22cq7zBhaQcSIax/Y0bZ
 6as=
X-IronPort-AV: E=Sophos;i="5.75,346,1589212800"; 
   d="scan'208";a="251558248"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2020 16:43:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBKx8ya0ncsjNyVTkehQRgnpLRz3VNIr1gaa0q0t8nPfqdiwxJxgxil8i3ztAVezwlTMTKE2xwjRT0w1npUsO1OR5Av8DObct0iLhKcl/SWlOfjVf/LrJwvAWMtF/fTyijBGCpFb3rLtWpaj6p3LFkf9qTXGKq05RHrnDmf7jhPXytcS3HemXTaR7rRZxqwGEEkkuxr2yqT2Acz96mq38TSRLvKKRdtVO/osiDkboszsBCUG9dfyGFOpXZbZg9+NocveSrSSURFnlpM+CWg5bTBhi6PncEyyHBL2rxP6FARF31mRKwTRGx7/yppHK9dncdqmFCFeQ3R1uC+t56vY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AojycePWtIwa2u+0U9D7u6u/BxgF3KnTxnqrGhSUM5A=;
 b=Dlz/iXQC36HTH0eWgUwYnsrp70OzhzhJKvLwGG/EFvTYLtybFAd9+UUtEDRDIR3/TOTsvOeFA1Ui6Fzh8lIia0ecXzO+ZwyHiV/8ItVcSxpf6+pRMOYDcV77K+TRn+ClCEdmQI1yKdFKo1m3lgZE1RhqZnz4SiFUidXkEd87kTsFLf+06vO5RjmTacOe+EpaNiHc3/6qpcWY4mvdsosYXhvXcB63Ud5wMNutq4h9R7vcOWlXNS8em57MeEcPm/U3/+QwDUMvf5UEp7Pp0+JEKtFN1NbHGIxA5IBQRwTFAg6hWC6a5aXbOY3F6cWO56KCcwQivjKEI1BPG7wUPJ5PVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AojycePWtIwa2u+0U9D7u6u/BxgF3KnTxnqrGhSUM5A=;
 b=nouYic8w06WFVJ0WisJJPuzZDeAAGurVPDuBVLZL/sOwt9L9ElSx9Bjv//e0xQ5hcH9gciBlPRrFmApq2FAegIAyWkSUAxmLSBA8I7IYX27d6I1FKfqOyNIzp9OigLqgvI+PaFFK1CCvbM0mC1WZRyssRuELb4qfzHDGsnWhS7g=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2237.namprd04.prod.outlook.com
 (2603:10b6:804:f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 08:43:04 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3174.024; Mon, 13 Jul 2020
 08:43:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] btrfs: Ignore output of "btrfs quota rescan"
Thread-Topic: [PATCH] btrfs: Ignore output of "btrfs quota rescan"
Thread-Index: AQHWVuvLKsEKGA/55E+KIpQixhyGLA==
Date:   Mon, 13 Jul 2020 08:43:03 +0000
Message-ID: <SN4PR0401MB35988C45E7E1BCDCCAF9A07D9B600@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200710185519.10322-1-marcos@mpdesouza.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mpdesouza.com; dkim=none (message not signed)
 header.d=none;mpdesouza.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:3d54:75d5:bb74:f595]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2da16efd-8d70-40eb-49a8-08d82708c1f8
x-ms-traffictypediagnostic: SN2PR04MB2237:
x-microsoft-antispam-prvs: <SN2PR04MB22376F4AAE910C6766D2FF8E9B600@SN2PR04MB2237.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+6H861EfEX0zivR5tjaeNDxQbbK/i4Efrc9Ws9BpcJxsN3j3vMZw7wNsyIggpUiFOp8pdhElTf3XtoxlH+i7khbNlhrR0UCu1VI2WjQwCyVhFftZ9w6YZGx1bE5EiaH+6Xjc479Szvu674CKwV/y7dsMsK5+rYO1Cch+KKBEW0IiT0co+XiDrv3MruWUj1m2sbsJaBGnqIKN4SOGIq4Gf2IwDvp2lY+dEOGA99aMAV2P2Mg3/Mc9p7/NWOe5xJUcN7rOOsfEY5rlEziD0DSTrhg3eHOcJhnA+6Ia5BbTD1h/mhxdLimnfHYX2jHWS9j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(2906002)(478600001)(4326008)(9686003)(55016002)(86362001)(110136005)(8676002)(6506007)(64756008)(66476007)(66556008)(83380400001)(66446008)(66946007)(33656002)(8936002)(53546011)(52536014)(186003)(316002)(15650500001)(7696005)(71200400001)(76116006)(4744005)(91956017)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ubXZUstM0ZNX6r9QaoAaHnLwZ8oaGVBPXsuNnWgW7IUdNeS92aPxNtLOZMbc5iJQCYMNBJXlzyx/nRXKoOSaON/GcOaH/6/k2U9GqFJ7e5OsH8c1AWXWl2kNHwQlrstfTOqwG/k8I359QBljguGZQTvbKbhhZxrsTRfUQOdeP8ZbN5fdIpxEfY7Mbi1pz9tJ2LzgMLgFdnYzz5YvAAnfaGmEgvFfiBNL2Cr4+fuRBqIAUkSLzPYI+NSLnWQh6GrjnXOXMeWlv5h4lZuY0PozLmV1fGkg1rRfGC/b6vPyg8FfVOesXjMZZYxgqSD1XyT1wr/V1TJQ7aNvD3qCzFMdWK0fvsvfJpgq+EjxgeNdstZWAfwMCzBq05JdKH6NE6J2f10JGnB1PE4+Q3pffD3rT4iuyCD5xCc8o3Rl1XeiQ/1c3rkdCfLkzYEQu1v+t0DScMWIN4b+qvRunYoXfAvJW2ScS+EFnmBNrEHHB55fUdomrriwVP6NUB4v/WMgrV6u2QK382tItzaaCu3FfoZ/eCxciY88HtKEZPPdtxjBESzf4DhPFXHrHs5xHV/xCDI2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da16efd-8d70-40eb-49a8-08d82708c1f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 08:43:03.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywcQ6fNU2POYjTPU+lix5ganC9GeZ1AZVii0Q+gp/KBTHCQzmQj8Regv6iUcCbNLicAt6Tziys/0HQTtMVmgy9HfpC7wNL3U1Pwf60CsqoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2237
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/07/2020 20:56, Marcos Paulo de Souza wrote:=0A=
> From: Marcos Paulo de Souza <mpdesouza@suse.com>=0A=
> =0A=
> Some recent test already ignore this output, while older ones do not.=0A=
> It can sometimes make tests fail because "quota rescan" can show the=0A=
> message "quota rescan started". Ignoring the output of the command=0A=
> solves this problem.=0A=
> =0A=
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>=0A=
> ---=0A=
=0A=
[...]=0A=
> -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT=0A=
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null=0A=
=0A=
I think it's better to filter the "quota rescan started" output instead of=
=0A=
redirecting all output to /dev/null. This way you'll get the real errors =
=0A=
from 'btrfs quota rescan'.=0A=

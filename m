Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0C2C57E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 16:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbgKZPKK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 10:10:10 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53455 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbgKZPKK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 10:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606403606; x=1637939606;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=mJup9/9QrbJtblifYaI4UT6GBn+Kk9Q1a+MTGHgkgXJoWi/0/4T0yvX1
   NifPuOo2VKrbYGC5vAwVkTtvoSwc8PMOYFsscAfQMaCVW1GjJNwVjZmLn
   H5AqSDdkEMWeIl+kcUKBzQJpGgrvuK2z0sfTNZyVgt485PMC2GxPIuZHH
   oWPRrKLfO0gTvUn9iZbjMRPYkrybSxVUH5/1zxT+Gu6B8YsPRhL5MwQqs
   JAxfbx+XovILE+ieQ383kpXFzcmpRt3V785LXAzawzpyu0JdLR4JUhGLX
   FQtUY8RqoKOLp+9oWkD78DsHTOWzMdW/Znm64Mqynt4opiSscSXGSttqg
   w==;
IronPort-SDR: iCIxrkH5bYOzz8SWn6qJ9GOjGfXNRN39YKgawFW10OunAs23eOhJnBcGRhdH9uld+s/PArTUB2
 Z7efPfUFKsFK4aiODSy3pi1vbIe85hh6iAPSbmHarRvX108BntJih+CKSAXHqVCj2238Pym9rw
 QSbePVpv4QCegEoJnq4unch1HFDQAhr1PZ7wvdhVcG5pmNrxxZab5tqa9GOoMKT6keXsmz1CjV
 Is4u+EqDQzEA1eH7Bmgb7eXokynbvn+/Ry6+CwJ2xxOSLsh8ZRVkHLGw7914P/oak3niZUiBfO
 WUM=
X-IronPort-AV: E=Sophos;i="5.78,372,1599494400"; 
   d="scan'208";a="257205146"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 23:13:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeqyMHrbrZQefCJlsKMjExZ/xqTyFlgZchzmX5AsMHaRktDlA5CR4ymnaBKfTrrf2HzuyglSmOI1+PkLeeZu50FM2dqRqxzQstLzBnDTauHlkjZFD09/DZZYP+8Dz3ow2aa/P1qgRooFMog/vw/KnWBinqeq7V0IUl+y3APnUxWUGzYdYdTM1jq2JjrWDtDr3ueuolFz7aS9PWlxLaY110heyKNNeKhmwQo+ojILweF1Z6mkRdSVlLC8idjD89UpFPfzanxlxw+z5F1b+Wz0D/imyhM3vuT1jalqI24bRUHPjzlsHOnZqwgnM5p2dumJ/riwiEWd4aciGAqgSAY5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=JsDKvKTsRK6g4A0j/wityvwgom4EloTAf7HTDNDWJ4jlIOWz00rdpUtXQtpr6hdWmwwsBh9eYB3Vv39wZo68vxmDZEBgkHOwavhRCpJVB5xf0CQz4bgrS8MewN1TZF0P6j3dty3T2uZRGm5rYYKVF1/EsjwGPgYhJibgRiwe7CYqgg2mci4T/XbKrtj9miBvxWtHBXgsJVrNiauavi/IaE2S0/ana/18JtuXcNNX+kQFwO1jxW+2YmU/O/jOpcbI+RZCKL7A9IJwceOeatnMjZFamfYihYDaeFc5p/jPDt2a0NoSkttsSAKkrni3KMA6qmOxUsL2rQ4R4GNTYvg+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=p+7TuFe43XygdDL5SHWzQjYRrH4+oWKZkmYGxx+54htce+I3xgCKXmV1eLxYWZxmIWzMhzpcKA2xG1cn0mI4+Pfp0/RQ7N8s/1vlInv+9MqJ+DMvmAwbkV5JnCTyWgmweSlQiTfk7Vr3Jvavbebsyqi6YjwsulpxAK3X1BIifQM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4464.namprd04.prod.outlook.com
 (2603:10b6:805:b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Thu, 26 Nov
 2020 15:10:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Thu, 26 Nov 2020
 15:10:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: drop casts of bio bi_sector
Thread-Topic: [PATCH] btrfs: drop casts of bio bi_sector
Thread-Index: AQHWxAJ5B8NVOvzl/UyQCb4SWyUKLw==
Date:   Thu, 26 Nov 2020 15:10:06 +0000
Message-ID: <SN4PR0401MB35983A84C48DA1EA209220BB9BF90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201126144127.19493-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 166892be-20d5-4553-43e3-08d8921d5b91
x-ms-traffictypediagnostic: SN6PR04MB4464:
x-microsoft-antispam-prvs: <SN6PR04MB446421D475F9B856A2C8DC8A9BF90@SN6PR04MB4464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hd5mVFArzMyj4/4rIH2uO15fgT7feQG++y0oD2rhuo6k7UkxqOxRimCiyMgYnfmqwTLhK7SsC1zy7N7l0Wkf6/Adm7IEzzzkML5IcVxaEGIi1oVUK59hFQ2nevVbDKEA7EbQPk3oXK+KCCQOtCwiyqpxBz6beb3l9BAil87LWC08Ly6RFUt68FgZY6hiLhv4c0YxiDoABz+FeYKxNNJ8ZA4UlDbBHLiVSdwmOP1NT/T+r83zY5VpjhuAW6pCv155dh8kvoO6hUUacGM6gyhH89woUhzG0qujrugB18YLIDDv725WsqDMm1vlS4UKD6ug7JkluJdWXqnZy43pFXnc9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(76116006)(66556008)(66946007)(66446008)(55016002)(66476007)(7696005)(52536014)(91956017)(478600001)(64756008)(4270600006)(5660300002)(2906002)(9686003)(8936002)(71200400001)(33656002)(19618925003)(110136005)(558084003)(6506007)(316002)(86362001)(186003)(8676002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r2ieKH5nFBeIT5e7ZQyLlQ26p7SCgUSVtjELQw0xuQB9+JTjss6gbwiYJzCW?=
 =?us-ascii?Q?D8E1/h56kF74fEUUGCay0uPZqAd9Am+otm+laEmfrlJ9MUGj418BgyuqhYg9?=
 =?us-ascii?Q?3b2h2qTsTCaJb8GC+n8xVc5UpXLi4xX0f0FM018O0HwvFkgYsZ234syuNo29?=
 =?us-ascii?Q?F7OBFV9xZMeKqghTbTTD8z9/SRXRmGwJZjTeU9V5pssx82EH6wxzCQSSmurZ?=
 =?us-ascii?Q?ioAyLA51rvUzM44R46ROCimD1s4qFxdeiz7uabzPxD/pxePPdvC8JNzoBVRW?=
 =?us-ascii?Q?QKd0vvmfJT49/GfGQOvnb7b63fRkA/+UDOfiRXbNu1pvuxAqYBlLaq7MYDQO?=
 =?us-ascii?Q?mNNJ3LY6ZTcYyEPDbG1ifIoS4sLkFocebHwJG40YuYSggNT0aO3zQseNpClZ?=
 =?us-ascii?Q?4MMEMV+YmiS7qmrwkiUq/GwNyxiDxOZiImzYSO+ATASprfJPdIwRGv78zhJO?=
 =?us-ascii?Q?jNcf0Nsxe8XywWtsxWCh6OkxdHqIkM50nyVIw3kTM+IB3vl74cn7P1D3IBRF?=
 =?us-ascii?Q?JXBQPOIAfcpNiolVhhH6AYGDNux3dJhflmSrRQaZ9wLb2MssQscS2wQk0VOp?=
 =?us-ascii?Q?GclCJEJVWjPcJBWXFUZiyrNoNHKkM918QRiIZ0SBZXWRXszyfECJMkbgr8z8?=
 =?us-ascii?Q?zZIDdaK7RJQ3AKkS3/OaeM2CkTukrrWh+ui7LEkP3bJV5afZ66l+MfUn2ON/?=
 =?us-ascii?Q?wA/cweZ+7pGYElTxbuX6LKoV5max/F2AwYPWNpPQn+UccWvmASD5XFGyE4Eb?=
 =?us-ascii?Q?0RDXGVBNkCh3w7aUCfWvcYObeaF5SQqP2vyaKCGPUXH4j8PeIyehWMcjfrWd?=
 =?us-ascii?Q?zbFgzrtEV7BpoRTwnp8FbhXGXY8YB9wGPBw/7JlGgj0WdBsvn6DoRcRqiRy6?=
 =?us-ascii?Q?YfbwmWrrl1Tuhjc4IkEluM9foi89mfFp0Bf9xt/0fUckrE511Ne5PtPituaG?=
 =?us-ascii?Q?bRn8IACxxQgvVTPS2laKpR0ObcZ9kabLSNMtrxirgRF+j4ACA5mXdXqfwFp8?=
 =?us-ascii?Q?/8vV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166892be-20d5-4553-43e3-08d8921d5b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 15:10:06.0359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ch3xR5JbOq7WqdFz4UrV3GdLXUhTtlT5QxJiXLzxOnkZEce/z77VkacjRzEosXgoOnSH5d4CreVckpHd1mw5DZ3ebC3MQIemYQLDWmEkvfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4464
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

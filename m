Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596512CD197
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgLCIpT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:45:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17403 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgLCIpT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 03:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606985119; x=1638521119;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=X0pZF1s02Q/eUy53XH6H9iHza07gOi3AgRVoAYIEGMotI8vuBfc5/Grn
   +pXpdsElsUhd7WZk4EVVpM8tNxA1SdOtemgY2zpp8YUmoO7UtIG6qEYOY
   wgwzj4l4gR/MK3TE34gctPH8rVLqYhV4rjdjfOp6HmeBo+JILIuQ/zIBY
   A/2m0eszvTV8tPscD1ZqkgQnyr83iUj32lUbIMQIZ8tVf6OszVEuqdp7V
   fc8AEaeyiN/uOHdlGsTjxC9Lun25Sxwrc5v7IFCAbT9ejtE3drR/kXEkJ
   cWOt5O32jxD1A7un9kRaFAkkGHt9xA0sjBKMgNlhPRdXVUdudaH55TjL0
   Q==;
IronPort-SDR: IPQsosstQvndtfOYmP2WDND5jgYD4WVITGZwSDDB31NwgnneaDTHwCy6CxF9SoKS71CDB8mcf2
 jCzDz70qt9Z3rdqZSwao9XOS3m+1NIFxvYK4KUQVZ6h31YozS5xuxuzDOxpz8YQ6Hq1XRBklqz
 z8OZCJ5Bo56KeUnkHMPIkjJTAAt7LLAbJgcPSBe0/iT4yDBWQKoEQOegYRdoTLpSFnKT1/FGAw
 9ULNIpTrHNdZE5URyND6ze8Mnr8auK9kosAFXLou6Dw/nyhgQu01mbCNkLacdfxKbdkePZJStF
 wPk=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="155443755"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 16:44:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpagVEpkkIpQSx8jqP9/49uGu4BZMeSpE/33S4eFh4Dfe5mDtTFeGAyMufurHUS5ul6tRtkXqaUJyKscqoNhiTSNAT9fW3q7VortQ4YQtzjVz6PK210fZs8pmgOgPVuAP/YTrMo/1YDMutGwV2SRqLQZqK4CwLYwC5T9UuOLvAgcAjckzqVnkBnEImjkf//8ecs34z95N6uhqff7OTQvy83znLyRvpSl8+WV7g3mIGIULfMAuJE8NAbkWQfZt0SPUiTx6xvzdzbZnuGPask8fBgRe75jP1WQzdi3cTsuce2ToPHBTozxZvMQIr+cHnF670aPObFBxKmUeVZJHJpXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OIKNI2wjSMIfo7yrey7fAR9O7tD5wAet0T5SENxevuDc0RGGEAaoCHjjuGKXK6JiHeAf+94nEQmI5UhD4jpAbplw2rJmQF30mrS4ZZb69PZ2lX3rnULQ2Zj9D49+0Ui6kbwqYpr9N5rZy3IG4TGhvQOMLCrYr5wboJ5EFmyiyDFxxH5i+Eh9iLGiUansvr8QiRkw162TJjF9lmGOIIepJ0tM98zXZncNoJl9iamo+HTyp1Mxa4dGua6sW3hGTAkeuW8BcI8xZVOzs3jE2xWAaRtNeGnJHqMV3LUzBwWouUk6cNO9spmzjJjB3YV2S84DWAEmk9lPYG4wCLREogVCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=rqZSOviAQHGBZVzwGb1IcsC0VXFDivrPHDjnu0oVcpST6PRwBHLu3UM+75Vp2tBDX4xbtUN31R5PYLSPIkx1QsoVP71n2PnDKa3zmf0s5OcmaHPw7JDH9GpgkAalG7yUOWDBIqWn6GxyWIjSc4zIa6F3nTvjIVcHRTj4xEkYBrA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4606.namprd04.prod.outlook.com
 (2603:10b6:805:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Thu, 3 Dec
 2020 08:44:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Thu, 3 Dec 2020
 08:44:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 03/54] btrfs: fix lockdep splat in
 btrfs_recover_relocation
Thread-Topic: [PATCH v3 03/54] btrfs: fix lockdep splat in
 btrfs_recover_relocation
Thread-Index: AQHWyOSdgEtgFi/r30aCPa/7A0GWuA==
Date:   Thu, 3 Dec 2020 08:44:11 +0000
Message-ID: <SN4PR0401MB3598641F8C72AA93B2F3AD699BF20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
 <6d8add2cb8a480cb2d7ea3763ea56c83e2aa3358.1606938211.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:ddc9:a3a2:6218:d6d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b4908d3-515e-4822-175c-08d897679b30
x-ms-traffictypediagnostic: SN6PR04MB4606:
x-microsoft-antispam-prvs: <SN6PR04MB46062AFF9BA76BFFCC91CF889BF20@SN6PR04MB4606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFUP/U3m5EfBT5fw32oyx+1LeUcWqsOoWvVqCbsy/5KP6H9zV2Iwt1Hm115b5pkkxIIZDenJZB4BXqkFQkSw7gAaku1tIAfb/3/qgp2wK2SWzTjYtdq798CIYGqeoYvB2qbaOs5YeQEcePpd5JkGmNxOsqUT4QmnEg8CwsOsTvLLuKUSirGokqgFTEDvjBxAt7CS7cDb+9EPKARP8QgYpKdV/4klaFXlrG9y+uhoYenPdwRlXzKTeTZh27WICiqxGGgBmQns6tserp8BrwHV7k7kPIHnw67jQnp1swX+I50HH5pLXEYe1uW+IavC+dyroA2lZJ5eanIfTxisMNLhSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(7696005)(8936002)(186003)(71200400001)(5660300002)(4270600006)(19618925003)(558084003)(66946007)(66556008)(2906002)(9686003)(8676002)(6506007)(91956017)(55016002)(110136005)(86362001)(33656002)(66476007)(316002)(64756008)(76116006)(478600001)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QZKPS0F7qC+lk+KpnqLN7ozQdnKGYj/BUf4SCj76k3ecDvQ7JnAi8yZOr3OO?=
 =?us-ascii?Q?WeHjSS3vjqHPXPyBa18tBWhl10e9SPFHS0pHNwEhtxN0Poi5IJ4dHsSJdfnn?=
 =?us-ascii?Q?NMgMQxuIP38o9/EWgoFPZD+VzjEuE46kRN7WXS07l4sb19dR18HhlvQoQn8I?=
 =?us-ascii?Q?TN5f09SB9lPJqF3vMZDWqz3JyYJuLf6X8fenX8O+VL0XrDRlKT9PdGa2pous?=
 =?us-ascii?Q?2ribnJSNEBFI/MnbpjyFBjQZOhtVE1Opeu8kRRmWJ1pjn5ggBKbJJuNlT7gl?=
 =?us-ascii?Q?yQ8IKs+Ygr4yHQ+d5p0K04ExLVO938imZ+zDzca3ebUZdKSyOKuD2fxf3mw4?=
 =?us-ascii?Q?LLAb3mj38qHaCUqGiPs+mDshKvCHBWZbIG8NNypGdjoq4JbCJDEuF8oi1m6A?=
 =?us-ascii?Q?cXAK7ONr8RghEEzm/SgZ2/vzmpsnMpw+9TmVGoO6zLOuFdFUMFJpBSMpUBU/?=
 =?us-ascii?Q?3y1xiRIvfOni9lUswb4LfPfyWsumh8gv8S8bBt034Ud1W1zAGrmDKtRdIzpi?=
 =?us-ascii?Q?Oyb9sVs2JEsGgfwCqglRpOGCXUvRRu70ilU0PT+VM/pvCbq0/vQ1qr5aGO23?=
 =?us-ascii?Q?DWmCK/39rVv1cVCSETYDGVrAC4tSo+Qdy35W8E4QyIjCMSPgknrHESyStzks?=
 =?us-ascii?Q?cDVyYuFCxAEoYmxGfNw59iD2vQ/vpqWF7Q1xiaSXXjn6maXh9CrHFDJ4O2ui?=
 =?us-ascii?Q?RQkhn7KsKxwQrEXlYXJ7aw2iZRmEe9hS6JMKYScj2NSmhZ7K6KXIySdMp3nY?=
 =?us-ascii?Q?bFpncp59z7WKMom4NrfUKQTaWraZ7DYKFZ4WUycUuHxwLmesjAhwBjAUCwyp?=
 =?us-ascii?Q?aS7oJFa8E8Zazuju7GKgCzZWPRR66klHqXgcqkEzZGR+sBmOEjR7LxWCoJx5?=
 =?us-ascii?Q?a/WkQnFDR1bCX0Y1y9kbUrLRWmX2Q9oKk5zG8jbP22fn2jnYUr7/wenyBGBE?=
 =?us-ascii?Q?Dq2ZFXNtW1bTlgwAXhjvy+jauyc8Eh7d6MdxaLnWSOdj/w+6btdG8zP5mMHL?=
 =?us-ascii?Q?B83do6Th0SJnGBCok+V74wh1ofQVf+gk0nnHWMxEOSyWovdrKHRpCJl/5n30?=
 =?us-ascii?Q?K5aC+mIk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4908d3-515e-4822-175c-08d897679b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 08:44:11.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KQv1RI7En7eTVCKRH0xCRjwAlRXd/mwipwNBdNRJXplDJt4CEHDK4M5Pxxb9fNtVBqb7Xg5qB5+T5Q8xlCiYDRhGKINmx7r7QSMzyiVW+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4606
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

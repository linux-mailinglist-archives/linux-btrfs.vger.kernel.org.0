Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F139350A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhE0Ros (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 13:44:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36542 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhE0Roq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 13:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622137393; x=1653673393;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nIkdRTIa/GFQeW8v3pTCfFaAU5hitmN2LLo6VykFkJk=;
  b=Hq00N7K+qtXQR3X+EyLnYm1Tb0M4L1HH7sYi+fAsLp+aFH5rqXMNvcjM
   0AoptSUhd94GTIVO8rZVN9Cb7JciLFUDisyCd23+zIkkUp1DX48Es9sMF
   RoR2c92XYsrWwbpKKi4/cYSG1nesFMRThBzdpijqpTKPozymwVtjMcZq0
   qyY2kusdGuUS17ckBdiv5A/ImZxOFidtEqecIGmLd84kvkD4YWJwvNjlO
   dXExu4KNB14g5fTONbh+d2oO6OBZU0VGidq2vPX9V0CHgsabKQnGTnbB/
   DBJqDdZuJjnCsEm84k+hPTZw6XX8LsTJlFSd1PPfw5npYpmqrGIkWnTBh
   g==;
IronPort-SDR: 7yzndZtGIprOtyX1/jw6z6clVrDFeqiKgr390c8NtRvNuRllgQxlxbmDHWvJD7oFyAYkKrDYMO
 QG0lJrwi6mL7/bssP0wMhAsKSID+kJUvltyymd6U/uUIvjIwE6vccE+qRXNGdSsJLIGY1gu9fU
 jcZpAhgBoYBdrcjaffunrBBLQpZVqVc2+eLgSJBsNrQqooIqipEfvn4j6YEDcX+LHMBro8zXf+
 FGjTwhyxGzEmAFdNoODoISWZxEEM30ggs4ptyE91hPO9mlkGSxbMPFH9ID6T59yz2Nsxgsw+FB
 xdM=
X-IronPort-AV: E=Sophos;i="5.83,228,1616428800"; 
   d="scan'208";a="168985607"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2021 01:43:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVsD8luSZa2OJCNwfTsv+vbkLC2vIVXZ5plIDT6jfGfZZxWOZeNtwHSbBehYj0n94IdjANsOYJex4SFExKTbY79aiF9gjxk6uNqpyduYuai0D5mr5DqNbuvNhFHdTZLJymHIch6q7p0zumzc4dP+HFyJem/H3Gc5fG5O8s6fLqJoA9Z2zLS3C0Bo2nnJtIxFSqA9fP42Uf4bRWViR4oWqtK0Do77JeOLDJQIP3DdAbvrV0m+BgufOyx1tzOtSD4inVlk7IjhbJcr2LOAAva0AmPmfTrXh/8p5Mmap48o4ccsRnlmSTc3JTXDiNo8Xb7qUEHQdhnLxfSMaohSqif+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIkdRTIa/GFQeW8v3pTCfFaAU5hitmN2LLo6VykFkJk=;
 b=KxIUlYhZQ7wNSldTgB7UOYO0gnB+wZNUQDMO1WZzkwEMOgzCbOGg0yJCqmgcXG1fe6IWepNwSHOOYPIQ9jGS0cjJVTEMYo3gP2+CD6+sfZPJal/HAJUCq9enHtemM4J2tPfJy9N0SGAUThBgT16pv3CoyhzNhHekL9+8ogCO+7cybbKMdEAzoGO0KCbonJ4GHtBssIwwxWrpFgHG0PrF6DZSvN8pv7C7tpr/ABJjejIHp28zu/kUo57uZAOq7TMtjq2uLU5lO+0dfq+Md/SG9Hjh9pgQbTbWJtlqQ1szDoqJWJa0UEmkdNJcs1Al1jKSVLG6MgyIa0xGbIaBTqY/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIkdRTIa/GFQeW8v3pTCfFaAU5hitmN2LLo6VykFkJk=;
 b=JF831C9DJpItQ6HNsnDAE0b0nULMQXTlYvZpAXPsr98ySLF3lg4WQXpRRVEPZOQloK9ElPPneIlPfZOCZgN9gRkL9DR6Pa8vqT/zMT6YAdIUJULk24587NsmEqSydAgIcAL96zeFZyP2bU5S3fD/YA8dXkl91MgH56CnRlfeTY0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4134.namprd04.prod.outlook.com (2603:10b6:a02:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 27 May
 2021 17:43:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 17:43:10 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>
Subject: Re: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Topic: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Index: AQHXTUCZbkdV5W8mbU+6O2TFfy2HFA==
Date:   Thu, 27 May 2021 17:43:10 +0000
Message-ID: <BYAPR04MB4965B509EDB1A69B29E9BB6686239@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
 <YKeZ5dtxt3gsImsd@casper.infradead.org> <20210524073527.GA24302@lst.de>
 <BYAPR04MB49650508F2C5A4EA3B576D5286249@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210527114347.GA18214@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2ce1c22-0467-4130-12f7-08d92136e4f9
x-ms-traffictypediagnostic: BYAPR04MB4134:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4134934471CAED3E2136862D86239@BYAPR04MB4134.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kT62lp+D1rZ1GkXPgAfgetygM5c+EJK4kkxwqjK4MiaPfCXrZlT7HsFgflU48iqcp8+8/w0WW+g6q4EzPGQlRXgxay2drePQJe0h5FkY23YHWJOmuPWwoF9pw8tW7wllZcB75Ysj1cz0tABVOk+kDB29QVOE3shQLXyGMm6lXymZDFJxtQYZdmE2O7Ycmxz73G85JJCusVpt1vGTj8+wvoVpS3ZqkpnIuSH7QwDA/I5FNqnP8HTI4kaWU0gMYDzTh39VhLrVjD+xrBH27BKPkhU4fYfvw9C8qa7vVrX+YYAAAgP1TlStBWyD5lYbMtzE68cGTg9P4sQF8xCpG4fRk4iOtAa4LblDBmxWDfCdUQBaQqyYhM+GpS73JEbNmkbbeRuRoRUtHGpG8z+yxRLYsm/Rjz574a4R/dwuf87quDTxc0MPlTQS97wMpkwMQFcbfa49oYRMqDdenJZHrgukneV4ZvW+dl/MrWFy0iemMcLicDqKur/heZFO0QMOxRU6P/Z0EMENsmaFIhmFyr3VuVVUp5Svt9OVfw+Jj2Tkr5qqO46745RVCsfZNgpSEuBGkJg1hPcPX7A9+zloOOlHyhu661aRoZahH38itmPYxJs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(316002)(6916009)(86362001)(8936002)(478600001)(76116006)(7416002)(9686003)(66946007)(66476007)(33656002)(71200400001)(64756008)(66556008)(8676002)(66446008)(26005)(7696005)(4744005)(4326008)(52536014)(186003)(5660300002)(55016002)(54906003)(6506007)(122000001)(38100700002)(2906002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?A9j9JbnYnw7et0g0ww3feg1j4Fdfimm6PGSqYs5o2tXoX79cl5Oe836bIUw+?=
 =?us-ascii?Q?iPQGWo85Q7LD6z0VXMP3KH5dcWCauBuwZ1EQRt+DrbnsCMiMe7tr4mUoXE8n?=
 =?us-ascii?Q?fT4dIbMKEWt4kHYe6dNYQvq1AKF7U6bxABW/u3grltGFSlmSgF432iPeP27G?=
 =?us-ascii?Q?qmJNirbM1a/Bsi/P8aq77A+EF3w26aFZVw3ep8Zk7SWgUsDIsbgNjQV9mtl5?=
 =?us-ascii?Q?UgSAfThyM7WwnWpqTu9lietM9gb7al4iOvqx617hDlEMCPQJ2fPi4ueDoSTV?=
 =?us-ascii?Q?irVB6A534RZPcvfqYYlVjTmD25C4dtJFTSfLeHHGN6BrHwEsshBbNbF4sYJo?=
 =?us-ascii?Q?LgVIuFZbpGrv3iIr+Lw6gTjMfrsd94Zvuv3Pbe3ruSHUxMPv9HNK3eLboHRm?=
 =?us-ascii?Q?Sa551BcUDCDlsUP/jOSRlY1LlXqCAVp17r3wzwSrU+dlFYFDLFQwemWdwOVR?=
 =?us-ascii?Q?ikJO9/ZEnewJIaUhfBOL2B4r/ll/7y+IrTtSMue8rViz2ZDtZYOSNYOJT+5O?=
 =?us-ascii?Q?R0VQesnlF7TOLpKI69XyMw8DdawZACm62Wj/BN0TOMKdgx9bxIXsjkBc9EUB?=
 =?us-ascii?Q?jDyzfq5Oq9CMDrb5+Wlv3pkkso5ByJ80pU0eCfXb9tkOp7OkI4VVVwhv8VGz?=
 =?us-ascii?Q?jAptEd7at1UJSH17QGItQvREnLmESUnZT1S3+uZNLk9uuFd6XBj+H7vZSDWG?=
 =?us-ascii?Q?ALfObhAoYvOuIVa4mEKpO84NPUW+UjolZy9L4+pwNlVl67e4T185T1NDRnd9?=
 =?us-ascii?Q?W5nMOwM7m+7N0p1Rj3VCRQcoMHtojVye/Wwe7K+M/47MlvwiFmVSpFuywoUe?=
 =?us-ascii?Q?CaAjXP3wg4gBqKTP76iyFJIO7aRKPw/dKs40sJUrfAJnDLa5zWl7niiNV95P?=
 =?us-ascii?Q?GynoHdPFvuCApUSczTSFy53cmgQKTi++Qh1sEq/0ssbfWorksi1QW2BfDX7a?=
 =?us-ascii?Q?YgFIY1k7P2zrA9Iw93so133eUM5OhsHY9w9HoigIlJLx9Ezx7ItJpVAlZuKL?=
 =?us-ascii?Q?FH6ezfAGOML5ZVLxQaa3gBAEYbsP4JxWbykIZuO608VclWZqTDygX6X+GivA?=
 =?us-ascii?Q?jZGiO7eD2AAICyjo43phYtaC2x/FjOQUZsXeRaJxhYwYYKWVv3GjOHGjB/jR?=
 =?us-ascii?Q?PscmsqVOFDzcwqJ9Ap32FWzuqazb4ZKfPGo7cExSAg9OKVYooeZb0doYZAxU?=
 =?us-ascii?Q?SI3N9sd2LN3EA9c5a9fqjWZtZG2mWVcMxBhWIHzWqs9IHIY+v8hhsvU/MP5B?=
 =?us-ascii?Q?9pwQaT5TXfwMpvDLox0f5G+kNimtaJ1MB5DVjqL+IBWqaaU1R+n+Bme45yY9?=
 =?us-ascii?Q?sZNDVPybwBLZgW6zw5PQkAZrQfs2OWL1Mzkpcxxyh+ohZg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ce1c22-0467-4130-12f7-08d92136e4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 17:43:10.1965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTG9tugbl+p51Y21oPYbRGsuSxPIgeARkIgHevTScf9J+mC4jDVQj65Td36cn6DCPdaBLYpCmpUD56SFLaWN8GbIVK2pdMOtik1IxXi3xOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4134
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/27/21 04:43, Christoph Hellwig wrote:=0A=
> On Wed, May 26, 2021 at 02:55:57AM +0000, Chaitanya Kulkarni wrote:=0A=
>> Is above comment is on this series or on the API present in the folio=0A=
>> patches [1] ?=0A=
> All of the above.=0A=
>=0A=
>> Since if we change the return type to bool for the functions in=0A=
>> question [2] in this series we also need to modify the callers, I'm not =
sure=0A=
>> that is worth it though.=0A=
> Yes, all the caller would need to change as well.=0A=
>=0A=
=0A=
I see, thanks, I'll work on V1 with this approach.=0A=
=0A=
=0A=

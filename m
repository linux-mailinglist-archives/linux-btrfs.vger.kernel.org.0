Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4545A567EE9
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 08:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiGFGsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiGFGsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 02:48:07 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808391CB0C
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 23:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657090086; x=1688626086;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Sds54Ct0pjhStbY6XBMFDTiEcP2cMDbCKJy+xb4v17MQt/66UgGxpE3v
   +vpcMskTfkijFqRcjBEDRVsMB5DcAEyhQc96bJFg6C/SQo3LZRQZDzPHW
   cMEkXOjPm4rhJ3ABtoiRyVsOmRNsI2hURiSaf5xB+19MYy/hmjJuT6216
   eRb9cL+k1mjlyzMkZHtCUsJN7oeIiXXkGnZqGyxVRSZ20hqK2zx+Z+yUn
   1dM4Z+6rRr44r8ZRtHGyDqBCD8vUszyiEiTzocuL6Cqxij1QCiNPg8j5V
   XjtUVkwnKDvUgiRGh+3DuIPFZDVTVBl7wC1EwogEvh8XJHOvKjiAv0L7H
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650902400"; 
   d="scan'208";a="309279830"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 14:48:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HznAeDMCvqMfpNw4nxI9LgNnchph+qFQKGjp0Qrso5tmJ0qnylgnrz8jpWYc2rv5wN+bnFG3duFiAMCdBrbl/NFAFvqQ73Osht1QZEtEgy7gKWzfIEbJE9j7Ht4xUzAo9Vc6/+kAd1oqpw4RiTxY40Si8jSemSs1CUlpwM59pt8p7/SzHPtbmp+UccdKJfvzoRSulC4XZ+UTv+P5TjjGrHMt/CXDTARo9fV7gqlAvRMMFpDDmY6DdHSWSVwFJKIKgk7lnlT3TFM2pvPedgR5SppJS6zetf7BcSllaWGB+msDXvph3ihOa6VzIGJ3EAlFCqGNbCQfXYfoSEMpk1vBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=MqKD2sp8cpOvTOl5y7SPkyxRVZRywLPkGIKyKJzjt+Fx5cwWpjHba8PrGkP1uJn1xH2w65XGI8bl6AQNsiA8E7haHTNg1OAvCN/Jkof3EqrmcoOwQQHIr/dzVNsjKfk/OUrnYTjEkyaCeonpGjE8z5/utRJYM6SUi6i7bJ7WL/CsGQPtUU00hhmeZjWpdE8RCv5wIoIucVWu048pKUdRyQYam0m7cWH5pr3nw9CHcKbKLDcKwMS8KTFvb4TUuxAWiyd8JD1rSlXrez2gR2ef6HppuC5SApPZ6kKbcvq+ERgTJWSRqjzUMzEICWadBcG2o9t22GmatoCoRps6f6Pblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RrH4ZDWWcs1Alr3mrHxFxp2TeUC/hgfVaUAxHD/Ui4fpPUtye2vydk98yPEn/QfWjrCnJHOImzPSzwcldnE9J019YWBW234c91WYSBpp5+RNEiY86U9ke+iuoC6qlxyF97wffeRJ2VoARz8cALpJuMkSywJp/xp1DP0tgAjzuNU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7964.namprd04.prod.outlook.com (2603:10b6:208:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 06:48:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 06:48:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/7] btrfs: don't call bioset_integrity_create for
 btrfs_bioset
Thread-Topic: [PATCH 1/7] btrfs: don't call bioset_integrity_create for
 btrfs_bioset
Thread-Index: AQHYj4JDjnEkumOITUGcnfHahEo1lQ==
Date:   Wed, 6 Jul 2022 06:48:03 +0000
Message-ID: <PH0PR04MB7416727DB4182216784274AD9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220704084406.106929-1-hch@lst.de>
 <20220704084406.106929-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 455e0a49-b5ae-4adc-4e35-08da5f1b79ae
x-ms-traffictypediagnostic: BL3PR04MB7964:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3r5YHTEPMTFpvn3QQMmM2dd1XS9yba19ax5+St5cyQ3WlHh+0luWgGbO1SEr/vvOj7aT+uY2ax4UO5USWvMHi2+khfxOSoYQwqpBVZF0ujwGgk4wToK985UUn6Yryp0jVhrg2hAzwEO4hIRSlSDA+VWXNibY4IP3YhAkthyy7z/Q9lHyc0KGQyqrJt5F0SeIwKIIxWoIvjSh0SeFMwyZ9xcIEZaqfyt/DkC8o6hi522XaaLuf+dwN7lhIK5GsvniW+O4vDsj0GrkWVs8iuKIJDQ3mf0IfuP/Hs3KvlaxPjO0101VXOXUPlr3QMxoaQjMnXXN7gbDsuwXV+mpK+Ahsu8RYpRarkXS4IJB599ZK8ZRzJ3i7U8UjC6cw2hhk+oA077G9pVyR7yZ9ZvP7ZPmqzNZ+mM7iR/eUDGJnsR8FrHDXbyT3LJ5e9DcTNGtlIc0jaTC/+qF6lbxAOqDOdkljJ6GGXkiU1wpHmf6WhmX9mRT4s5kNCgomZgaU42vLMlPnYBxJ64xSZM/i0ryKjyjZpwym+QZPRuDfsCCoxHcoCls832MNfO9YRdvdkhGfDgqMYFao2Gtj4YzlS26bSFEr0lqOI5KwL+bW7Y/CiwR3h/Jc3LtohIDaLvIWDrlm1rPnbjqVbmYhVA/gJ/BpXgdrAxgiudD33iqezWEz7him5GLNcBxKDTzjMJxNDg18rzsf+PvPR3/vlGhU/g32gFo8jXwXpjxMGzqBtSKDEQxwOoC+Kr0OjiUDszEIqZq/M1yPVYQjRmS3Tn/zzgQ8niGkjBzBd1oUFAtsX07nf7BpNofKtUo2zh4DYG9SWVMO+Kr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(186003)(71200400001)(4270600006)(55016003)(91956017)(26005)(19618925003)(6506007)(41300700001)(2906002)(38070700005)(110136005)(316002)(7696005)(122000001)(38100700002)(52536014)(8936002)(558084003)(82960400001)(5660300002)(86362001)(66556008)(33656002)(478600001)(66946007)(4326008)(8676002)(9686003)(64756008)(66446008)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wBoJqxy532ZcR33dzjPFLqNggfvJ3uUiU8SUoA0PvMRJ+/FRkNES7yEzUaK9?=
 =?us-ascii?Q?w04V1E1vvMRkXatz+CoHuDHL5fqKTJQOf+BzwMPnaGcVtxxCShhkq5ubilJC?=
 =?us-ascii?Q?SBVsj9nJ5A17yG/pjfY0lovBfyfTg4d+fhjI/JN/c0FsFSPjf5a2RKoXFk6v?=
 =?us-ascii?Q?2g+jl6tCNQwrGrQwCvFs3YRj3bVJWtIjX46mklbYvhpCLy/Pr0okc79z2gTe?=
 =?us-ascii?Q?W1sw+PaM6GP7M4dVjVj36gY/+EBNPqPKLRtiyTN4/E31mzAorPatBYubQcYr?=
 =?us-ascii?Q?TazDcuJyiINF9F56/mQ0WgBz1jO7VV1HhotjFyPeZafRiE9LPOQEeHtYi1ZC?=
 =?us-ascii?Q?ya7XWNF9ttT/fEI0Cy3iHL3OX1D8qLyzI7eUr5WfqmpTJt6SOs3lXhf/3iNW?=
 =?us-ascii?Q?YFUIrqpLM9S5jJG3GzpTh6rvel5kzrwzvp8pOvv6COBfgwcsncFgOO7rR87i?=
 =?us-ascii?Q?osD1vX6mcfFOJkD5Sf0ibgYX1GIXR/deSjo/IF2GHpL73jG/IoeOVoPtcjUf?=
 =?us-ascii?Q?rpVVpG2zKUXu5HdaHJTL3JcQoi7HKCfCmiBvpZm/UcMnR0ALSXmskCGUWeTY?=
 =?us-ascii?Q?j+4SpXHQHCQNE+Iq1yGpDHPYv94cadNITclLiQtwYwbHHihxOoDbMErXq+SY?=
 =?us-ascii?Q?7TvrQErpO3MQs+Mjm4mo/uSIkiEa5adZaTIvo8IKtKRXKBALx9ZddJ+6zSet?=
 =?us-ascii?Q?YXkzhGOXSh/6rv0nvlIEgFq9Munq7RMq+n9mDuYjqnO4PevxUZNnWSG31VpE?=
 =?us-ascii?Q?P7pT7M+LE4UAu4b0soQ2uGad4IePyjKh6mKcm2FoewVrTEpujFgmXbEtATlF?=
 =?us-ascii?Q?utGOyoReA1MY8rT39uhK6Nx8X6Yt8J7mF/6eBFZMeeM2/MFFYqA103V7UiKB?=
 =?us-ascii?Q?jUWrwRm/AbLb4aPrWXlJc3Klppcl9kKi/oRna8rnU6sybsVV+g0Sfc6+IhPM?=
 =?us-ascii?Q?sOLhLH0T2PCreqa287ZTdC9PKgJ8HFNedaVdUnJgDrQOuFWc5sXsfuMKJaIx?=
 =?us-ascii?Q?YpZ2o9LugbN6q3UUpwts4xH127qCVnrWDmlMlafAN/SJpaSnpwwNHc8sgQIO?=
 =?us-ascii?Q?aKq8RijpMxjBgFXBBZzbQ7e4cJlgmVmGOsetLIe6ABbCETI6FvKoAoTG1bM3?=
 =?us-ascii?Q?/4M26Pq34NBf34TJ1PYXAm3mggSI/s4eXfKCG7pWfel5YrwGI6WNOf09uOeU?=
 =?us-ascii?Q?TWfWcGbbNx2yhc+eDCPAK6icHM3sw0JN7Uxm1QHFlFXGwQ/0TCtgbWbLWSmz?=
 =?us-ascii?Q?KJSLHIpqU6FsTvcZzkRAeaU6fW9dHs9ISwPDPM/nCr28WSX6jvjmISIF2H4H?=
 =?us-ascii?Q?Vo06UXy0fKbSrosC1xHw9q7oaPioqd7OdnNJ6hbx36KZnff/AANTA+E5PHrH?=
 =?us-ascii?Q?x2bu8V1pZpcv2oPRNJfTobp7uMSSPKT4aJxLHW6T8IC47AvQ0tf1j8O5iucM?=
 =?us-ascii?Q?UioMGFliVuhmotnfx1dh6Zm4my36ScU4U8poe2KM0sTDBoTBveBI36aliZnX?=
 =?us-ascii?Q?YNfau+Dm7+1rQU8onYsO54LZ+zc3M6K0AjgOS3yDzeviNAyYg1VM6kuGfDWm?=
 =?us-ascii?Q?st7++zXT3Cz3WUoawFyc429mN6GdqSK3soumDlbaPLdGNqVovzR7V8Sy+LNC?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455e0a49-b5ae-4adc-4e35-08da5f1b79ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 06:48:03.5943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAefvzeJzFMiggnh2sHAtmWfKHetLv6DF8ZGayrXOn63y74CYEUOevF5h2JF3kY7VlAo0lpxcZ8f3H0AmBoWwkbaGARuni31DgizUOEnhQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7964
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

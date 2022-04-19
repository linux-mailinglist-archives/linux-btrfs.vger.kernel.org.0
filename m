Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5402B506A46
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiDSL1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 07:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245241AbiDSL1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 07:27:17 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8E85F98
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650367475; x=1681903475;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KCPiSs8aZ/U8tNTBMfUtv3iDAU/F34TieSyrwnwRcsKYFiTvSopdeWDb
   nmyfZrT0TEBoLVR189s/klC87DZ0E2zcZ/RdxYQ1QE8zvZRx+TF863vHo
   JimekdmKW8izgi6mhvJ4g5yd57Z64mXkqFW6zQU2WkWPJfFWJR60eUxe8
   F0XG6LNRbh/WSOGImJp1WB6l8rziNixCT2I6jhZJfPwHV1sS3MiTaJbdu
   9uL1ReLgDhFe/VSxa7aTzzNQZXxDb29qsHTtIpmjEFMHdDDQ4m4aswCwP
   oJf25C/iuiKIFntP5TLPCETpSEWbIiJ+dkMC2kSP3pgcsaE7yW5Cv62/z
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="198254344"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:24:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS0JzFn8VLZthoAVsEQVpwD3JrraaqmUwiQwrL8RniGb10Sij8CqqsJCT2zGTnLPPN00eeXHuF7IammQsly+0TI3FzAitzVHYqy6j7rVWQG53owG8BxcepTi98ROkOmcxxKzF/Fv5xKTVnRMgd4uplX7y2SAWVemMBLklzaQxQNMJUk+Q6mbeT8hNurBOozdnbXDuEHLZzxOP9u/HAqc9A081O/jIrQ0VKBJ+Yyp1/2ofCc+tbKckv0GxZA/ZZH6KucABaUArDuPWUHsmNz+r8/kSm1D5Z9+3zPcBZGF98CXD+qV4+Iwqbz+1s2n7hHjuD15FS8koi5HizBjz6r9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BIXj1oRg2E1pZaMCOoAQSRLyXr+vGbCQ7evqSoFQfpvuu2rRrE08BL1hIrKvNMfjRcG4v2fdN7yiFit/cI03p5oNTdoX49eWIl4CGB7lQDJqynY5D72ccUkYTmMS1Uh3i5/i9RwjtSdT3WnKN0QEXvHB503HKw92JZf1sESjSMlasF3cYtN5KrB/3PD02F7DARi3kV7dQAyutf+OngcsCdMgDtavMddmSOmZ14kU50YMxJvOgrkv0c74bU/0apxZBgwWYvyGlONhIHXcbuDKL2f+hF2macAcjy8QWNgwLitNh02IUrvrYJPRZ5Pp6c96jjeEWCS1I0VNSTDKSb8HhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dYOWKo9ykKFPp+mTSTIf41BdLd+IRgMipNqmRfXguscvP+v85jzoFo/ZcKrauQLIE/AxnjbboG+zIifH7mfqeV0aNE5P0iowDgGXlrS581czTosicUeSoDxtOxj9ACYFTU7DJjsCxAjlGajMQtHdUtIxZPqbnpamhiBiHfAgImA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4914.namprd04.prod.outlook.com (2603:10b6:208:5f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 11:24:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 11:24:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 2/2] btrfs-progs: fix an error path which can lead to
 empty device list
Thread-Topic: [PATCH v2 2/2] btrfs-progs: fix an error path which can lead to
 empty device list
Thread-Index: AQHYU99P21bdmMvO+k2We/hDRi/m4w==
Date:   Tue, 19 Apr 2022 11:24:33 +0000
Message-ID: <PH0PR04MB7416EC2366803024A21CDDE59BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1650366929.git.wqu@suse.com>
 <090fd4a12800fe3f7a9c2b62630eeed738512a4f.1650366929.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3436c200-1899-4126-889b-08da21f72d95
x-ms-traffictypediagnostic: BL0PR04MB4914:EE_
x-microsoft-antispam-prvs: <BL0PR04MB491478167536626964074E959BF29@BL0PR04MB4914.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VrIBUB1OXetBqP8JKJJ4T//qtU85AIIr/bWvuL4jc2O/xliQlj0zZVrX74CUVlBLmptPyBBF8EipOStSlGxio8u1/eu39Xf7jo7yoybfuzRpLO+YyO1ZzVs5Jxxp3fb4lGiGPG3bKVAl3QyyeCfUSCYaMmaIMAudUL67eRkQQDw3t7LwoR1YQ8x8bbtB9rJSGGxGwaxUyntHrQy6zz0UF3VJzqfaSDXYzjEOAmYGQ4zEHS4/p3tpej03U+r8nGgDGIthOA+hPTuSNzcxIWk6pGo2n58cqSlIADEdPkr45SsvulR8m3+wnPu8BXy9VO12ltop2ljIp4j4eFT8/l3NJ2JqBWo20FBZJOcKmRm4n7GMjFh6/258z/eju7C75s5lRngluaIhJRrHBKRv4H09MZq4YUKIHJm497+x5F7+WAKBVJlaOc/ARp8VVaCnSVZJRMsYY3RClGoPIuVnVUNXc8RegA1aIE1yl16r1xf7SqV2Wl1mg46JVTOvwA0nQlGu3k8ZvNJV0gSpJr4dY5ToDb2TMkFJKCrBmvNO13eeY0/+dSLJmI4hVoARSiu+UiqHofJUIwicwuqflYZDRyDjBo5JpfJKqFCtp1BPga0trVh5ADzUnWTrwB1bnojXxbkzpi65cvrgXTTErvhwgmA3sjuJzu2gTTs4q/EiXmgGM9k8X+1FCKF2Qq0yQYhwNrix39Z0QTtKt2EjGEtdcRx6pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(186003)(38070700005)(122000001)(38100700002)(71200400001)(6506007)(82960400001)(52536014)(316002)(4270600006)(33656002)(7696005)(66476007)(66446008)(91956017)(8676002)(4326008)(8936002)(66556008)(76116006)(64756008)(66946007)(55016003)(86362001)(558084003)(110136005)(5660300002)(508600001)(19618925003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yGsVvUwB4NZtBKjIqmoWxsV3hE8ZpRalCvnRq8wv4lrRpT91Y4R2VoHshPZZ?=
 =?us-ascii?Q?MkM3TPlmIkoOUIaMnh0WvZUlHHVJhDpyM1YOIPMaE35NvsWNjUvxkMg3PkJg?=
 =?us-ascii?Q?rAJjX0LkmO3GZ8TW5zIbbwnpRF19XwMhPTedUNBWPGqRYFNv+qdCYhBbsnLo?=
 =?us-ascii?Q?GMjfarjLHbgsHI1KMxGjKrxjoHMI65sK7LRX4tfz10VG1z3v4YGaRlv7zcIR?=
 =?us-ascii?Q?EdFdbXITquSpMEFNAllzUbX2Z7TzOXns5UIFrnhjie37+Jj6T3TH93+MIo3g?=
 =?us-ascii?Q?wHSM8HPPgQfsknxzQyTX8DgaF3TqxritiTCclpszMEoMTYBNV2hVIksyGDGC?=
 =?us-ascii?Q?bu/qzPj4+Mgm0rwspad3PQan87Dljj/qBvOnVLrnnYvRg0zFlCcO8mEKKX9U?=
 =?us-ascii?Q?vXExgd7H6Lq0QTXvKMaNPWctce74QvFlsA1vq13nxnG7+0pMSqQOBYVu7osX?=
 =?us-ascii?Q?V2vcKvmp/MTiPTHyRiHi5n0ehvAMbs96sdYKfyiu8zfL3curzVLVsIuXrYQn?=
 =?us-ascii?Q?kMcXcBWTbODcI2o/n57RpWg5Z6AyTVANt/IEHsfkYNK9406Yl3wkmWrhe0kS?=
 =?us-ascii?Q?h8s4wWZqhtRDFTaNCGdOG6LxszI5b6yHPoHJGwD5FRq/wD1PlW1bqoWxF1fM?=
 =?us-ascii?Q?gQCZTJi4hkLAfXez3mMsQykup2TZ5lxNupLk8pMQZZjtJwzZikX88//xNPKx?=
 =?us-ascii?Q?cq6F5m3m0+mmbDxQWB4N7uahByNK855scoaTwdQ6yYcwc84TE97WhbfGXPDr?=
 =?us-ascii?Q?FBIa8RC/OPqPRi97TGJ96pnOobVGESnVy27cYgGBmiICtefNLo0PKz6du3OR?=
 =?us-ascii?Q?ks0ancogNmTT6a/r4uVl/KFGVfhcADbRlQzWddmCHWUGYTK+J9jdE+42zg/n?=
 =?us-ascii?Q?XprSml4O9bpNVpkFbcLacpdbQyXa6AAnQmIgRprZ5gTluvAVXim6qBwioghA?=
 =?us-ascii?Q?6ZcnSntYTaI5AiOhGvuZ3wATfMPPjO5LcJyyuXRzY89N3R4m+Q9808g+oww6?=
 =?us-ascii?Q?QE7iWR+jGxg26JhDg6QYUtnRSd1n7+bpiBTUONb2yfvTxCny2EBGKDRBis5j?=
 =?us-ascii?Q?0JRY40KcKSXyhJ2dvvGI18CoIx+dolGh1PPKbjZ+cx+IVxgDkW35e9wGOIxK?=
 =?us-ascii?Q?jzjq5TqfDd+PJ66UrWf9HfZOOa5bDSzRzAHKqBxG2b8qfy6y3QEdWKi6iSGL?=
 =?us-ascii?Q?QABbOjSP3XhWTV+78fs/JOVytexfiOyT3REFhSNGIh1kz89pacEEf4W/8QcO?=
 =?us-ascii?Q?PH6v/cgOk1YIxnPyPVJ4HOIbY4ZNILwFGK9DnBTV6mS0hwlXPuZNyogX4Zko?=
 =?us-ascii?Q?KMM1Bdc++LtmFgcXtqGj84OncNorflOb3xY0htgt1H7kQtG8Big8vwc4JQ/b?=
 =?us-ascii?Q?NpEYDYDNflkIsL/695qg+0NKklAz1htuAU8cnewoKx7fKa8dRGch5DkozXHh?=
 =?us-ascii?Q?57Zm5ulaC68uycmj6imIIgzdg6ulFuny0201qmE4h0BKGV1ptsjEzQkrO0x3?=
 =?us-ascii?Q?5nzwjySs8UMH/quVXwPQgsZEd2RXyS7Po9XBtR1IDUVS8UFHo3ZMyM4FeZn5?=
 =?us-ascii?Q?5G9eqmOijHh6wfEIBQG3Cs7B8UiD6ViMi0+hguj9vCXITCZYMHXMySSfcpbA?=
 =?us-ascii?Q?65nwysjfOCwULovdYMBbz0U7F2IMO4y4Xs3sOzY4rfYyH0psJKt+cFmKO/ux?=
 =?us-ascii?Q?is8XG61+AhSHi2UsUQJML1rBZGqR6wrX+l9+98xaFbyCd90VxaSb6pACZuez?=
 =?us-ascii?Q?1ppNFT1yNBZQJROQI15v4+GLIYKY/SM+j9k4+DZnfgow7lErV8u5HI+3J7Le?=
x-ms-exchange-antispam-messagedata-1: +DopfI62/n2ARV39cpjbJ0JhABBSpEuySJ4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3436c200-1899-4126-889b-08da21f72d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 11:24:33.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8IlZ0wt9CF9RXZ64IhIK1orngNig6B7pqfDjuPYJ7M2dYnmQa5hNCXI1PMjLVwn3UiMnbEKS97yTgRAwtfYs632f60QU08E0nPA5EM5Y37Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4914
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

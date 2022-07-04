Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55063564E70
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 09:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiGDHMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiGDHMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 03:12:07 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26C62F8
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 00:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656918724; x=1688454724;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=jaePniNWrpNvdP4T3yp0PQutSZtHW2J/AMunKH2PP7iufePDS0/EDpQ6
   ZTOAsxGUTxZOVv/0j1TNvjSrpSN/utOeh/TV86xM6ITCvXawtb9fTlrg2
   WmiS2agh3SdFMU9DIpl9tvbemeUs8fdwoUhQT+bm5Bjz7T4+i1UON3duj
   sYw2sRSZY4GUVsGzsrQ4CTvEQN7TzkxNRYC7cvxReGujsEXHmLiA1lXEn
   XIxlJQytgeWLJhJZeuF/4B8XkOMTz1gdxEUiaj4Md3qkvc7fcwmAQZVYe
   O8vVZckV6zOYeZMMu0Hv5zzfn/Nazl+GRmmFZof11RGqbbhPMWcWt+slX
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="316859965"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 15:12:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLmCV6jD0cNVo9OX09cmzwoH9UI6r7uJXlAcHHByl1VUeLx6bTtow926IOvnqTOfpyvwXRy66Y004qpj70obk3B+a7wJNac2tNATElt1AlGFioacAyw2L2RaK7cR7nlPqyPNRoqxeQCVMUp0zIuiPHK139GSlQSBX6XbUt+NY+mnfT4YeMe7sbAknqe/9HCTL9IMv6RC9XLyV00qYxnWChQsDRpTZ8IYMllvSRVamXAq7lUr3lGZzd7U371BJ5hcdipii/jNOhvo+wxPKGpcmlVatvTe937lP6aMB6ec2l2Abfefg8eeOvlUJRmPTIjsnXQyN4fL7Ank5TallYBxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fR4Fxr9rlCAPGDRcOjmwT/sDJkJAD8GpVZmEka5bZ0QqHZUQCSe5kYctCsIiBqT8F7AWdiWKO1IQPM4un0cFlyI+/9jJAvrbj4FgqAgdHQWUSosj5ILuy7v6FylI8Nl4yHOGYzdRA0cSHK0r70aRuazCg/aEnBSb2xnkDAwES446bnrd54IUv/a/PTNIZXJG4r4nvCsIZ+Il8NYDB2PQBXnEJsEYwrCFfeQGlp/ittZDXT9CDMmDwEpypuwP3W7JlAcqgWPppTBxwOm7JeOPBnsAHxKH40fOjgFgeN8ng0L6GvN7U6uxqf9wDuvdb3yBQfNzfL4HsLJEISBBRitS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=E8qor1cVj2S7VO7Hau1rw1ikBqMUBicYn2Wb++JJHXIrs1Ge9p3g4LrZ59SB2U4c1WOATlduhwV2FWXJDAfAqDWU5+/T6rVICsKsJExcT2cAyfWfJdHnX1u2U2QbA+U192zv2Wrji/jAxgS8TFA95FdQxEC3EirQheCUJY4GtS4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4451.namprd04.prod.outlook.com (2603:10b6:208:43::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 07:12:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:12:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/13] btrfs: use fs_info->max_extent_size in
 get_extent_max_capacity()
Thread-Topic: [PATCH 05/13] btrfs: use fs_info->max_extent_size in
 get_extent_max_capacity()
Thread-Index: AQHYj2LHfM7GDp9ydUKVHKWS5CvK+g==
Date:   Mon, 4 Jul 2022 07:12:02 +0000
Message-ID: <PH0PR04MB7416921B29793057BF492EA29BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <81fdc87b1b820d1d1bb54d3d2c24b085590ed506.1656909695.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 951b7c19-49d2-4352-76ce-08da5d8c7e3e
x-ms-traffictypediagnostic: BL0PR04MB4451:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8bSJJNQNa9+y0AUTgLBGtAkQyl7vcHRjP9NdtSKmrl0KVPPw5xbu3QGp7Pxmed7iBqyV9O+5jCety7AahmOg6LeiVgChXL/3QElHZvlNUUgT5kkVWY/D65iBK/igVGrN0x3oGXTB/MdaVqn+FEquC2DnlSiozE9qpmLtG9uS2dQEXcS5jQaR2BlSBQqsLcQUjBQ496BpWQd7bOzojTA+JAx1Dvhv9zJid/oF4qx+5B0ZKpb1IaoT2Wpqsl1KxsSLXMriIkpO75/FDAu9ij6Pz2ExzkfG68yo+1srYnZSyaEhO1qhPhaNiaD1bmAI92kjdrdsjdGHXFwRZioo/0lVrWLWEiI3Du859OrKQtJlnS/d8iybZq6tR8HHqZCn9BUAVGTFnDFhIYU2U9EjYMAXInkOhl4SVZz79VN035Wix5OKpEAqZiN3/D5yQMAEGGWRymRHG6Zt1Ad2L4aJViwYWIL/3aXQqq9pynSOTilhWMk7ews0maHQMsBNRYypDyNv1sn3KcvxWSr1dUoojFGNu+0J0IUGICZmvNuoUBynhbKa163sSLMcxngIrEOAAw2OiK8jZL/jSOtFYcSYyz7152shyhkGxY6CpIBbOPTKb9xEdYOHHqsW3QAr7p0CMraMaCJiBfA6L8kyo0Sl50YBy1KcK+dhCxuy26tBHewYNtadkk/4rp0mQ4X2FNZ7oTmQfBzpMyQxj28eJ1Qg69jkWL4JtJXd43EtV+2FMWlD1EPn4ni5ScRhq1q6G5egqfnfcCcb0vtZ0f7woVKCabaXI8338d1E1KwQdsgH7gb5460Jl7Zl+v46RoxNFOpibol
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(19618925003)(2906002)(38070700005)(122000001)(82960400001)(478600001)(55016003)(5660300002)(558084003)(33656002)(186003)(7696005)(86362001)(76116006)(91956017)(316002)(52536014)(110136005)(8676002)(66476007)(8936002)(66446008)(66946007)(66556008)(64756008)(38100700002)(4270600006)(9686003)(71200400001)(41300700001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D9pjMNb/A+OHIs+35LMRfinWvF6XwwlOpwtW404FBZ1osWWC5UxO5iYo+ePl?=
 =?us-ascii?Q?Jo3frvbcHfvQe7eiDTg57v+QnrJ0uKvd2xUt3bjK616SWcD76Ocu9J6FhWmH?=
 =?us-ascii?Q?GhmAD/2OCRre5WTFH7xT9o6pyOK8Xkjk9y6yD40F7t6DV+NzLTMhUs0mniIx?=
 =?us-ascii?Q?O5JLxsmAJZ7/pNWB2kXN/Hx3FqD4/cnRf4jta10iWvUamo0W8v84APlzYbl3?=
 =?us-ascii?Q?K39dHhpfn7PRhUR5ExkZrgtUMQph1shX7gIdUCv+/O9shXJGs8Jb7ghgl1Fg?=
 =?us-ascii?Q?6gGL57Rs7ooi2UFndzScfiuq2lhEuXl6l/x5k8aZltPIAVTO24HqEN9UFA0d?=
 =?us-ascii?Q?2e/RiKHt0U70ypf59K3Yg18zUy/qBQvW/CnjBzlFus+PDZe81dokOzVoT08R?=
 =?us-ascii?Q?6cev7UUMrmzwIxZhbalwlh+WrkFL15BSnc29IRcAbDUAkBHXqC7X9prNgLcA?=
 =?us-ascii?Q?pzvWUuh3NUbK5TQB0HaU51L61zt6GyH5qbqRk7Wf1Ld4isgLVTF+7e83+Yjs?=
 =?us-ascii?Q?L/8AaisiPdwdx5rF0hkNnDVu3G1wH2g8dh1o5HeK1zxv/GmjKiY10gsopAMN?=
 =?us-ascii?Q?EVzcdgh9E3m+yk8kwHZ2mbU0R17tfdc4Pkejx60nF6C7FSQa2WYTvMT5bR9K?=
 =?us-ascii?Q?YbgKQgGZgkQKcL59B84/WsEgVkMecxPtiAKPYSinREr7lf54zqgI2j0GHZ23?=
 =?us-ascii?Q?gkpe5jSMojE/feT3zi0MtAPB0IiUzf6MjdQO8FN87p33AQg49QISu+ayFlWX?=
 =?us-ascii?Q?kzP10WITCNM2cUEE8ld1XioNagyOmpvkfJgEvwgY1eQIikJIE18S1NuJFnJz?=
 =?us-ascii?Q?i5Az6SY5E2eDLKmcsqy7fQP7dAueN9W0HAyEo7MrkPYOwGNbdIk86wzWtRmU?=
 =?us-ascii?Q?HFhG1nOkF76S4YiwAgVEBaUXk0UC84mkNuGFms2TePBijOUeRgetk3y4h7Gv?=
 =?us-ascii?Q?xe5AHB+io736PNtFaRv1VU/8hFOEOjxcHuzKMROfJ9qUsyt3qN+Vdxr0ifZJ?=
 =?us-ascii?Q?9t2o5Af8+2/jmWoBAwZ5VcAZljyDxhqg7+zCwAJSSTYN0PJhO/9gUeJWJ+77?=
 =?us-ascii?Q?2pmU0NC2ueK2AV3GZ93Xn2p2MEN7ersx+tCLuvRg1oeuyskr4a7iVA9KHjyL?=
 =?us-ascii?Q?a5vxKa6PB8nyW79GefVAEzAymWy21rcB0PZRMOG1hkD+402bRJAC/9KixSCS?=
 =?us-ascii?Q?DK8BiiyUPhVs/yxV/3De8GnzgL0eD8y/c5RFRwJAHVxXtgwoAGodvE47b8lG?=
 =?us-ascii?Q?ZwSSCeVwptJmIJTpOiTpeL3isqaAOArdqEaQYCy3iBzQ1gZ9gizPvBu+m4LH?=
 =?us-ascii?Q?7QuK1YHicfMG7iip8Pu90wJNSH1Jpd5paxmMYHt7wrOiRypllTaiTWJDXMB/?=
 =?us-ascii?Q?BFAS0Na8LZNWvsoAXR9v0XvZQAPbaeCGFOCplYOiJ1SX6fwV56s6nxrgYGYC?=
 =?us-ascii?Q?IDsHHDGZbvJNyqks98y/hjzX4WAVnLGeDp0gJENeWeZQz0KmKXkMre/rVb/G?=
 =?us-ascii?Q?T3p8HzFajmSRzc5NmLJDwHoWfAz0BCEdLdikxW9vJj867G8lip30bX6X7NVO?=
 =?us-ascii?Q?cmDWzlVAKXJa3ntEvV6WBK4n1bkel7m5Ej3BHG3wgkYaLmdPatOjpHGzlFy4?=
 =?us-ascii?Q?12+9Ejm4d/r+V0DEfU+dm+VAagEQ1gqs0X2BLbjEfQiaXJtCxrBrSpd6zuPy?=
 =?us-ascii?Q?SLpF7wBSVrcfGnkwmuHMDu08Mbo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951b7c19-49d2-4352-76ce-08da5d8c7e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 07:12:02.0549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZq5nhPivlPI/C62dBdXmnFpeIyvsbKKsm93KLHDHAT6yCAzfEpPESu1Nay4dNNjK+KwSeKrD9GG9AOYM6g8xE6td7kT9N2EbrU+3Z9sCnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4451
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20174C95E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 02:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGJA6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jul 2023 20:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGJA6A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Jul 2023 20:58:00 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D4B132
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jul 2023 17:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688950675; x=1720486675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OWeJPWHrkpZzOD/Xnym8jfidPigbfbZpDgGj1EMQ40A=;
  b=nXIEG+oRmniM56dJf8MxLohW5aud14ETcSznuScL4awNQnRtfxXjYzEo
   BzOw/br8AJ/s+bITD7EYty0vTsoSM+z/cO/+GN2SVdnAoxP2dDf4SOahk
   SwfEtX/pmMnf4SKaZBj5YHVxTSI2WvI+DGT/RMbKkj05EHWIreSxixGFi
   +m6ZJrHreSKEr85ln4cNugu74ffvSz0Zo5aBSZHOoxpLH9agumWGudEak
   r2DIwo5whBwWp87euZaCqT80+lH9zRzGAo3oZnUrc6IMTjm4DC2Wa5sy4
   l4Lcc5y2MoZ+Iu4cT1bVUM2iU8XsxkKIGrK01IeHW5EHvCMEtOXKzRIuR
   A==;
X-IronPort-AV: E=Sophos;i="6.01,193,1684771200"; 
   d="scan'208";a="237331816"
Received: from mail-dm3nam02lp2048.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.48])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2023 08:57:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMVDvYcN/gmfgQri3YVuw08+iq9zIPPefzgoJsEvtWNBdeRx4JsQIO7oX+CBovBGaUsJDBT6xzG5Dwtax8WKjedUw1lbqGYwErKr0bIQqNkU0DSWrrTJJMcV7yB6g0CmkeXCY0hDiyfFICkK4+wUIyC+9Ymrpz6+X+vli959Ht6hPDKIT/uEcgR7S1qu0cO4demorSOmoJIzntJlTbwjxfmBRlwsXX+t16hYl2mToBbrfZi0WtlBMyqjrrVAmOVTSH/nBBPqqQWK5r22Zy6uwc1XQSYmPBqYHqX+YB4lQ5sygJ0k7ga4eZg/1oUA9BFqE8Z3nREQibO3JImUNA14gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTynoz6IN245PBl8Ejl4TPuN3BtwuaXRjaQyblXE5uI=;
 b=oHgdA4sxAVWCguNj62Ouy87jKHD6bk4ECVjX0kbUt7lF/4fZUlzH9F2iZccaJO0JKq5IcWdDbl1+0Dfcjl/5+OedB2/zXtvzkaTTwTB4DPNw/wtoSwBugSv3gja/781Iok2sJzwrsjt/CZCJl24451LgFte5923bUG0Rhxg69s239XyYlUQzRmmLLiUg/LMNN+tQDmU0PY8yH9FFyqtTgHPhgNEzjx0lB+b1BJjjedu4B1g241WEQ97ATg44L6drYqTVa/MIxl7a0EkRa4zp6YD+/ou8h5Ny5m1XGlV/RXSFTIrukCUQ3cc/cP497m/V+TGdr5rGv16HpTXvQh5I+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTynoz6IN245PBl8Ejl4TPuN3BtwuaXRjaQyblXE5uI=;
 b=FTctWUoZ1ZILasSLvxKip2gB3zDW5zdrYcPz0tz88e5O1fXw3KW5qs8eTcJhH068wCVn14RFc/gO0K8ZCkVQ5Iv1lzw0l7r3Qfwudjt0pWVDDzvSlFPx8+JhDMlTW5nFLZfPrkzpsk7Bq+cWEpvt3fXXCJl/CiX2/dC+Er/WbOU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 00:57:52 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::cab3:8b01:da1d:61e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::cab3:8b01:da1d:61e%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 00:57:52 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 2/2] btrfs-progs: set the proper minimum size for a
 zoned file system
Thread-Topic: [PATCH v2 2/2] btrfs-progs: set the proper minimum size for a
 zoned file system
Thread-Index: AQHZsCIeQWf8ir9TWU2VaOAJGDS0m6+uLr4AgAQEGIA=
Date:   Mon, 10 Jul 2023 00:57:52 +0000
Message-ID: <wbsmajimcou2ow6s4rtzeopwvd5dhku7hcdvm2u3doy6lagvev@3kga7xlvxn5t>
References: <cover.1688658745.git.josef@toxicpanda.com>
 <c1cfe98ea6c2610373d11d4df7c8855e6e98d3dc.1688658745.git.josef@toxicpanda.com>
 <ZKf5IjoGAAdkrz1I@infradead.org>
In-Reply-To: <ZKf5IjoGAAdkrz1I@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB7812:EE_
x-ms-office365-filtering-correlation-id: 5f970f36-a7ab-428b-a3d3-08db80e0b081
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oNy+ja6jOpub5QPnhkYv6IeoWhgKx0acTh6DCCQNoChlr9DUZUHX6qVEDGMD008tzOkOlCf54YxEjmHVi0z3ObvL/adufC21rDeGNJqfnMxkk/DDX4EzAAEEpyBsjeu7CX7aYTXxOiYB+SxSAYbrr35TA+nRWZ4QJ9RdO9NpKEtB/iry5PKTUrb1DaQJySM+lUsZhLAFQeSW8r77GeUG6qCHxEE9gwv01TgjW9XD+ifMUj4rkzmBvbVC3CrPu99AV4QPnky/1mNCrCeUyabDLDGpAgzvjqEwSqutVLIlnoG1gbgtWtWm62H+hoaeAjbW3sNCFyJu3PBKuzdaPzR7InoQaauEI2GG3OPzg8g0UHSiaIersVa1fdA1lsE06UYCeAynw36J/sri0Mks906s7VjIaw3neGWKqntoA6FjufqtB1ZO/jkZ732K0KWcWZORF2gBeA+FdngUANDxcjT34JD4tGSYaeoX8r2jTqIjkD5D7YLPWOrZcRWabOBEQ7lwKXokTXIRCnB3DAH4vZhZN8R0RUK46UkCdzi3mlyJ2eSvzeCkH/fbsjEzb/Ypd2XjgoY+XqmoWqAdFm9WjsERCQYl+77zvuTbTZwrzx4CTITIv3yXKJJtxcWRHof8vela
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(6486002)(478600001)(71200400001)(54906003)(91956017)(83380400001)(86362001)(38070700005)(2906002)(33716001)(76116006)(6506007)(26005)(9686003)(6512007)(186003)(38100700002)(122000001)(82960400001)(66946007)(66476007)(6916009)(66446008)(66556008)(64756008)(4326008)(5660300002)(41300700001)(8676002)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HoEoqHjGspckmyjyLgGmkCnjwCDyGcitrQceuBEqS5u561X0dblbWcejjrxE?=
 =?us-ascii?Q?5wfEIxMjVXAShpKCub7+LGvvy9NIcrrJAc8vLt8qZhK04M8UojAbMvpCRXK5?=
 =?us-ascii?Q?TE0ftSEf4Mfxw4eQtqu4kwoaDoB+v3MtfOQeLpTnSPD5WmmQ+xtS5X7kC3HV?=
 =?us-ascii?Q?8Bwc+RAl1kJIcOdmywe5/YZwT8Lqtcgxp4Se2vpdkvum2N63y20mC0FGh9V+?=
 =?us-ascii?Q?qtDudTtJ1GfYIgX/E0WRdCrP3pgmA1nrXRaqaLND47F33HduJJMvu1GxZYLK?=
 =?us-ascii?Q?DxwoDOjwFZWiD4dlS652SyAMGb3eF3fAojZcGFJDb9EDMVMok+KF7ksjTAQ8?=
 =?us-ascii?Q?T1kec/ZKGRXImBYTWpz/0/DRpAeea43ju1bEoaFnB/EL/KtzRMJpwMiAFF09?=
 =?us-ascii?Q?JW5jTQf8aPsB15z5zfZntEANodgb0IrLaV7wUGydhsihIc4h2AGQa6GY/e2L?=
 =?us-ascii?Q?fQw+qZrPPME+vNTpFYxwx9BgMgreCU2t9Uoxq5ChvsAlSG9RvBFwSeCmRGXn?=
 =?us-ascii?Q?qtstN1bqvoC/oDCme+86VsbDBkdCwAro3ewNTDKGQlUpOVV1+s2z5ZLxQ0wj?=
 =?us-ascii?Q?1Rm81sRgcCwbS4NIByenK6RCikR//6rQ0SI0fIlTa9zKFN6oLxfhhGxnwJBo?=
 =?us-ascii?Q?aubHASG5Daq7SO9ic3NBK/eo0rJtZRPU17QiiPMYr2CRgC6o+5140fqCly5K?=
 =?us-ascii?Q?4db4xluIf8D//tAWKd/e4JgWrv10hSYJWYQL2W6yW8dz9vKSzDbrE4WqZnFJ?=
 =?us-ascii?Q?LIZf98jLBD90Z9QgYFDY9ybLK+Rlt/EXVJdJFz5r0xkTFVun/QTQFFeaa1kw?=
 =?us-ascii?Q?8a+2JZf3ZEFX5QUx6ph6fvtx5v5zCgCUGN0ofYTcPbLgZL9dbN+zftDixigv?=
 =?us-ascii?Q?3PkX9X9Kyhr3GRgJKDcsEUxya0j3xtzIuu9DJcF/t2WeKM/6L5z1OZgy6U+M?=
 =?us-ascii?Q?sxudLsalG2jTMKRl39i3vOKe31Bdjx8nksjyb7eWOxgwpKH60P5NnWXV/JCE?=
 =?us-ascii?Q?8sUK5OCete5ynEM/yD/77o3Hew3EqY3dYAPrdZA4FZYhEKgsvb9Uc+cs+2es?=
 =?us-ascii?Q?y8ok7RcwWlw810Sc1oe2tnDg71rv62/INl1pzm16nIZVPgZH+CQEKhMLHnFD?=
 =?us-ascii?Q?FByWOq14WUXIEfWD7PgldZBV/aZktvN5y5p29c5H3DbtqrlAOu0uQjirh2hQ?=
 =?us-ascii?Q?CGcZtrk7O/8IJtyf8zR0s8pNVmgQHgVR2wZb3SBC0PD+tXyf0qnA4X96T4KY?=
 =?us-ascii?Q?nn8FPkUmruXB7Y+mA/I2E8rrI8GJYEpuNM478y57j58+xCwXHz09BPu5L9LA?=
 =?us-ascii?Q?Jm3V1qo3UK3TBYSPkPa+bY05UkB1ooEC2cPxKr1T9hUmPHJDQK980r+ibcng?=
 =?us-ascii?Q?sgtqBDHFJ7VRlaeMm+Jk+JZIs2ZVYOiooI0XHcAUDOvPtHpceThiPgEgQA0R?=
 =?us-ascii?Q?8jxIQNrM4q1HuZbTUsl1k40Tu5AHLhM95Ydzkh7EIllWeuyaC3jrsX94IOTN?=
 =?us-ascii?Q?nVIKpmkBkN/G0ZZC+9cViUcm/Xp4Gq1im/YjD7KH2h+U3ezyV5EfSAeuTgQ0?=
 =?us-ascii?Q?N4KRnCEFfYDzyUAdiwFGrVqZ5J0PT8xwn8eWPDEdvivMImu7mKQiFaKgELmM?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AA344E827A0C3499CFB6DD0ED468118@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wpwmsdymu70JxZCJ6RGgczPCD4Jq8QDSpO/fESr1hrW8XHVve8ZsU0UMVs/H5zwPElkIFX6c+Y6fso3GF0XN3Au+WIZ0D+IGR9xWWrGfLg/0JoBP4/rxKvmdvzvCiKsmao0z8ryXwcDZXDn2vTuW5InQbydkNLBug1VEj4GLYE7/Ywk3XSOH8JMK1sIfviN5m7RYb5N2Zxwdh4AER4afzHDMn4UUlynEFV7qYZzkfO24tylc/VdRXG8VmGY656docACuWjOTWoawYG4h9WUUiqc/h/npUiJSvGxq3YITCdRpJJ+tJJqP33wzspm0QzM+/v5TUyasdj6cbrfdWfE6mOqf4EXcresHMyZNdOB0gUHUIi6A9TfPJdkPKFYnj1pm+z3XdRMmTwDeKOwJH3eDNrv/sICUMaYmzF35UPg6sufBTxxdk7rerKPhyrOpOmaZoufgd7PyN6WjuvJ9vznfNZbvDMimpFSYupzOeR4rm7qWEZon9jhKX/S3QXJuVOsOtkOUtJBzL1ddOu+Z9iUQllrw1FKckvKHiVWJg+/IMv+eREcxtb32/Z0EJZo5+YUnqy074NvG9/rXlpbl7zo+YUxh2uFfea5/GtcUrMH579AziDIv4a0UBpHMsbQN4tn6yyLRKBaNeuzyKKY0XMIeS/2fNvtJ194yxnY5/nQYJZ+iR+4sGOKgpDnqs5BAEqM4U022QN+WWKo+WPX5+aX2/iLCINVNnAOxfeowx/ybSuJanq19+Og1ZvaHO4kv26OyKph1J1i60VMc+2IswyuRcZ9l8V8QiQQuUxu7E/JFK5Mm2l+LAAqd80vON2lJBnPeaPF8Pe8K05vMNFEP3bY+Qt3pWnxaNzoBdRtIMBStAoSIxu9voUfaZVfLOlWpPsAj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f970f36-a7ab-428b-a3d3-08db80e0b081
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 00:57:52.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEnlk/VQktjzO2laoxO3ooCNcW0h6vEkuquTyoLHKZVWS7XDWQYIU6wiDvDytKo2CArGgZtuhCd/8/MP/4o3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7812
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 07, 2023 at 04:38:10AM -0700, Christoph Hellwig wrote:
> On Thu, Jul 06, 2023 at 11:54:00AM -0400, Josef Bacik wrote:
> > We currently limit the size of the file system to 5 * the zone size,
> > however we actually want to limit it to 7 * the zone size.  Fix up the
> > comment and the math to match our actual minimum zoned file system size=
.
>=20
> Hmm.  IS this actually correct?  Don't we also need at least a second
> metadata and system block group in case the first one fills up and
> metadata needs to go somewhere else to be able to reset the previous
> ones?
>=20
> Sorry, should have noticed that last time around.

It depends on what we consider the "minimal" is. Even with the 5 zones (2
SBs + 1 per BG type), we can start writing to the file-system.

If you need to run a relocation, one more block group for it is needed.

The fsync block group might be optional because if the fsync node
allocation failed, it should fall back to the full sync. It will kill the
performance but still works...

If we say it is the "minimal" that we can infinitely write and delete a
file without ENOSPC, we need one (or two, depending on the metadata
profile) more BGs per META/SYSTEM.=

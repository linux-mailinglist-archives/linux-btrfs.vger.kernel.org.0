Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7000564E6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 09:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiGDHMA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 03:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiGDHLr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 03:11:47 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99CF6444
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656918697; x=1688454697;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bDq39QzEWba0riacEp/URXf6V85uRcgtmRRYceOKFJASTtOg1C1lEAl4
   fHsqlMvT+thS9caKytqDi9rrkHT8PhoCMWP5FnRSBnz3K2IsPw6O62OVw
   FpRGZOaDQ1x9rYRUidwySeIJkDoZ8WVXtM+xaK5c9WXRptiTUs2/RDdSd
   RF4iiogyWb+4UyxM+3Ne0sh/eCrLxxmtkZ0sI8NLQmtJ/9sXE5TY6LzvW
   pMnXtImgZrKh1HqW2BRl8EtdoMCfPVuFp+TmD4sa2ec3tJQhY8IvfXeV4
   4CegLrNYbVM0BAvp5fsMU5y7Du8/mQEPzKvI5Xbnp7Ly1mJKQmAkAY36O
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="209634002"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 15:11:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUbTfxXNUGp5O6FlfaTyHcdhkEkO6mYCuC53LqwHlU2ek+Ev2Zs/Jz3PKtLXgDaLdUZftJcA8/vlZsD5SbzwGMCWOhoA6Me3vF5rMx2k6O/M/n4f38z/WlqmEivYPqMAFKdWcw+jDB2Yi0MTlkcVIRnGUwm/Qhw/x4vfXuYoz3taiNSi8g3Nf8cYfOMM3WSj3uRtru9S2volQQ7eioN7DlK1BvDMAXRRXXDKKql0F4dzzJqYr51P36xYmUCm5jmf4nj31Q/cg2uQst2MLXIpOpe8iPMHqc5r9vhconVGjwBUssAJvK5fprewyxtnBf+aXL40XOHZCXy9+KBKJCiMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WPBYmjjTk7gVcaiQXDK9+UxGa/7hZiDyv8VQZeJA5Qd9Z4jhjFNxTbEBugoSz4vda0RTaVR5Ki/ho1dEph0cCkityrFCjn5yhr7uf6zP94waLsnPxV5Ig7bOHeC3OhGeIcVAVoTKcS4tS5Qn8wrzyUQhIUa386a3CM4n2gVrO/BFdoxcuSo3I3J1UQP3EC9rokEoWUGCa8ubnL2JNooB1LbOVjPEUGWEfPINiKanWDPygXAkmW+jzCNV2H/DYItA3fhjTtBt/IWzahLjv8epvOANu6/pNZNS7KFFbzu57wJ9mucFwV/yVktzwPQZMrw2EbnJlQNj84FETuhmBVEsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=I/mXKFobtWZjlt/P8Fh7yzSIHVRehXNWQLa3gi2jXLBK365Q8fK9NJ/Q07YnInsAmVkjMyofT3+yqprQGQAcVkOn9NiZewq9el2vkMEXrfedi3aW+sPeWSEY50lcS6Id5m7NsIx2L1pOpok3Rg2tuXWHXfwUz/scc5px462ILg4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4451.namprd04.prod.outlook.com (2603:10b6:208:43::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 07:11:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:11:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/13] btrfs: let can_allocate_chunk return int
Thread-Topic: [PATCH 06/13] btrfs: let can_allocate_chunk return int
Thread-Index: AQHYj2LIMcYUNjC+wUOxfm+eJUNLjw==
Date:   Mon, 4 Jul 2022 07:11:37 +0000
Message-ID: <PH0PR04MB74163CC4068F7235B7C932909BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <11f96ae212fb278793c81eedbb7edc01864c8a33.1656909695.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1db9ccf7-9316-4a1b-b0e9-08da5d8c6fa4
x-ms-traffictypediagnostic: BL0PR04MB4451:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /8i4eVuHhDxIBeBqD6TsynBBNrT7e+atRPPuu50PPzZUAC3GVUfiYtpWD0FffWd7VWCYty0HQBubkaCHHxVTgxdmAgCax9umrTNzK1hVLIkwfxmeTager3bsD2+n9mlEqI3HcNwIwpCJVJlpH81sIlAn+6YT2qI5GHNoHcp1mlNLzGrOyEptmSO7YGnD2j1Q48Mef11k6YDNKCMDzStC61ydhG6Vl60eQtfn0CggstU6pQ72czWwZ6wcqdEeaggW6gzL+U2jIS08ngJYW+mMg/ggyU6GsGJvSrm7xjPFEumzN/NfERg4JS1OzDVhEHECMwUZMZnS3v9bJ0bslHEyPgx5Klvxot8kZWIz1pPqgEW057HigcGOv/nEAovQMwpdJpV3246c5ZbgNUzRxJGrbL6m3OfCFgfIeZZLwmrwE/JSjUbaO6j7+MasIk7EQWbu20RDs+7caEiw4yHPZ2N4eAUk9N4SJFPH+TlQTvcGb93FbVb7yilicPWav073UtYYg6fxCcnc3ripX0GT0RJIQ5z6Xomd1IzzPB1NkD/ix7lyAdZ2nlpLR7Ve3ZUPsamaApVH8nbbI9+lisPIzFp3PXScssBEs/paoKWtMVIt6TIoFq3daSJ7Q0aN3qG82jxwem7A0o4IAoBthk1Rlly36et8oLaqTCR43hH6Lch1x3zHSgG9J1HOKWWBrDiu90Jzm17zrY3EK+arTcrbfVaCuwCr/OGhn8Uonmc69TQHFJNUO/9JDuHs9QzSQxaeLcEzN9V2F76j/a2MrjsPwwCtt2kfgws2L+D6QNLljlSWXiZ96sfRy2U0CrSrJITkfeA4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(19618925003)(2906002)(38070700005)(122000001)(82960400001)(478600001)(55016003)(5660300002)(558084003)(33656002)(186003)(7696005)(86362001)(76116006)(91956017)(316002)(52536014)(110136005)(8676002)(66476007)(8936002)(66446008)(66946007)(66556008)(64756008)(38100700002)(4270600006)(9686003)(71200400001)(41300700001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OHNCriIfvU53X9fnlyp/LPw1aEm6Z6PPRW+iSUe4BQTBCPXEr696ztRq5eT+?=
 =?us-ascii?Q?alnUoWSIXl+KN3qoZ/d/JLKPNUHbe3u4eoym1Q5KI3KMEqGIhMAf9MtGiR2M?=
 =?us-ascii?Q?5du2mLNHjJnkPxlTRxGwWM172EkrDFdukDgbZvfmrSczQh4SiTnq97gu3/ZA?=
 =?us-ascii?Q?W5r1p0e79Y5wKMW7O7qo4P1y4/pUhwYCFtowOfEMHOP0spEOMIdSB4jry6T+?=
 =?us-ascii?Q?6Nk0f3S5GHKJL8vRUODlgiu/8AaKZp7/PPUl8t42/PbbA15lGRCpww3asIWx?=
 =?us-ascii?Q?2urw4r3ofeopE1Av8ur6pklkLWZ6WvT692GdLNJAQYf/9eazdTaDEIBhEj6R?=
 =?us-ascii?Q?syuJYo1IDomDze+hc08IXNF5F+FFQX1a0fobilRwlxugTfEgrmXxBgn3oXMU?=
 =?us-ascii?Q?9yT4CLbPGibh4G+jn0Bd3G/lN01xsZrmyEmlZWx2YbyiOnqxavAvXup+S2/V?=
 =?us-ascii?Q?o3en2buzuGC/GREG0Rrojc6daXUptHVVEPvefvB/B1P2DWoUjBoem/Ye3k+5?=
 =?us-ascii?Q?DtQxW9FV1ls0t+YTxxjEkZrL6+kUwBbS3T6Tchul6h/XRZ/u/j38MTtxdKNh?=
 =?us-ascii?Q?v7tl9R8lv60FgeWhuKJUkB4z+nKwVo5T83AFBbHsEWuistZBjjYrhUCythjI?=
 =?us-ascii?Q?Qd2NsfRjFBZp4MVYetlLY43kFhkxj4qGWmQVnRV0jl1PbPs0SrochYlVQdIE?=
 =?us-ascii?Q?GI/fQ0y5vQoEOZUyyRCGEWiucOx8YPxGNkXhto2MBWoDtjUwsO9J07OwSHkj?=
 =?us-ascii?Q?PhCAkam5HKUc+RhbFw6wljbh7aXZzKXsIoMbhqtVM+IsfvE5gIRMoHs8UGEh?=
 =?us-ascii?Q?GcxE3lSBaAq4kM9zPBiviRmKoOTD1E6Umuli8kKkdz3zIAzoCO7fSqRajTV6?=
 =?us-ascii?Q?E5satWUZ8bsgsQpkCgObPiLNh1SU+OEK9ZqzHwRKROlAmKlqyXIhSFSYzr8c?=
 =?us-ascii?Q?r/4/L7zE/3nEoNGt3e0UbQavMxK/sJDMqE0wd8ZNtVJZnl0ESaWKolpip4Oz?=
 =?us-ascii?Q?fKziRZBW5dtLMdqITTeqwzMB6zuhLx5In4/z32Qr8XedYX8P2xVED7YK7UW4?=
 =?us-ascii?Q?ycmkIJ+TuopYblrjfsc+d9l1+fyKDmXTs98fleZID3lMuyjnkn57lDCdlVt3?=
 =?us-ascii?Q?ELKAtAmAIDtWJbm50csXqwyDUk9G9pvvHj8WU7FmipCSZacRMPdICn2CUNRp?=
 =?us-ascii?Q?ebJxtTdjJAJYh0dIaY39u7oGFgIQaFT0uQfaH/CdnHz+WP3C6I4OKLJwuZ7u?=
 =?us-ascii?Q?6Pap9NLrpsKKTBJwEY3Lmq/tj/rXe0LxdoMSvhzRpvIyuXsA8xUWTrLn3TOz?=
 =?us-ascii?Q?Xo1M+YIY4Pr2krqivvO207hvnds6zGprmM3jwoQEl5/r5OedIc2avDkRpUpM?=
 =?us-ascii?Q?72uMv9/kf3SHtXHKRSUyQ7dfVK+OPMfQZCPIp1ulC6h2fx9PxhAZkbcHmUkX?=
 =?us-ascii?Q?Cb04vZtvdRhZVTtGaojEnN0vssqlbF7yFWmX+xVpDIYxrtOzBa6rC+hfWnwa?=
 =?us-ascii?Q?oWmajA3dAULA9+fyYMb0NhMIXWt6Ka2HqK4wTEMxE7JlWF5Bbs/yVWlLUgT1?=
 =?us-ascii?Q?/uvQ2v2EdXbRzqrJdxbElhWGIG2THWsvTUWvnKrRILp0wngoSMf/kQhTpGB7?=
 =?us-ascii?Q?k9/g55Pw6jc1Uo/AYrJD9CB9IRMgzHyPrJW7dUyeWqsPDm7jTTnOVwAzsZBy?=
 =?us-ascii?Q?Bpz2Z8O1EZl2gU66QY8bQrgDbM8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db9ccf7-9316-4a1b-b0e9-08da5d8c6fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 07:11:37.6059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrNXE35JbxGKUEWkbwz+ArCG8PCYqp+xOYzppkSHsdz8a6lPhtlzaiQ4ebQIRuXNfKbMqayu0HSyd1X7hiJG5+F19Q1ZnfU+Kjx1NyOdttY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4451
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

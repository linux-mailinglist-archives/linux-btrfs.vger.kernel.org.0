Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96C9564E9D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 09:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiGDHZR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 03:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiGDHZQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 03:25:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453AC267A
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656919515; x=1688455515;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iYBNW+EQ6WR+uNCXzN2sZioEJDBkYbK8cCqd0lIFYE4=;
  b=fvDLoxRsjOHTTN/tfD4YDHiVRHuje5QjTIWJkvqR08tRw5QTm7ZBi1Jw
   MKaXLxeGFstrfTc3QLJ+njB3bXRkiBboHEU9AAnL+D4cNv40L1X6CzOVm
   dorE8CEpD30e/iqTGRII5wU3lN6Qbuxrs3J3fXp99/l4Lw42V+aN/isNx
   4r453OKKNdklUfQRhUHV5rLNjfdexGMmf5CjhAVG1IAcYX7Xr1DQX2mE9
   SeBzI4jTo+R6dCLtv3+H29eLdNw9BuVc8yejZyabugQLJkH3gI9zcvUZq
   h5H3DY1yBkD+ww04m0wAPO+QV8sagGDr72Q+WhyEKl1TVQVN630N6LL8D
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="209634932"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 15:25:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwupTEar+Tl1hhveSGWvs90SLjKMpn9hAC7uGu1+gcyxrZcAZKEeONHLU245YoNKDa5yhojYWJLx1NBBRO3PN5ZAdzmmUvfDWnT2R2dyt4YQh+sXx6uV6RZgFFSOaKc2ztcEMzB8EC2O7N+8AFSi9oau7A9vn830giT2mQqWUu9Hjk2wO0OcWEy4ymLBpUDo5ADewUof3iSRHUCsezWHfCRhVKr7nrDQZu5yiEjbP0kr/GwHrwjcvPcjCk+t7eNJM1SzfCw2YQUpSqGny/mdfssPo085JmDgQqa9yrXJP0PLWCgGsjA/jT8yMyR1ucSkacRIYI2Sn4LQNO1EJ0DfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgD9AfxfksKhW/ZGueCNdd0+wkF2RzvUBljmU7eB4/c=;
 b=fkpQ9+dEKkMghWC+55yIYfpOAnCZcfd15L/u9MhmLmM3tlx50s5XTAOUXPkJglhNtm0YdLVOKSzr5SfWtL5kePfxndIJ/04rySBpLQaxkppMqvdihRvQtEOMlJ2s6ofbgiGaxRlXwISkQYlQdxAWnuVPr5Yo03gFGD0eLKH6IdZIdFTtvveU/DJvMNZBYAl5WNPAclBc01tvQUAP76BuV/iFbjcNMJegkRKUXDm4k4NKhg/K4TMxrlAEXVhgIpZ65uTbhR6ghYBqIOPfaExfNi2faWWVbEz6M3WPaRsDOctY6OGlwCDAxG5eFfwObXZhk1No8wW/6WOfs9s642EYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgD9AfxfksKhW/ZGueCNdd0+wkF2RzvUBljmU7eB4/c=;
 b=HBeduX9OAGq2sHTcKEtpfJXp/VN5KEfPCk+FfBA2raRtZh9KVH7cEZ14iWULGFOqD+Jz3Nmq6lEmX3i0RDw7iyllj5uVgHXU2f8a7ksSm/V5KsYOLO0tX4k7LQDBA7ivzMO2ZaQ6R9VaUqq34SsvCWyWSdlhXtAdayw7lOmwL40=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6092.namprd04.prod.outlook.com (2603:10b6:5:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 07:25:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:25:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/13] btrfs: zoned: finish least available block group on
 data BG allocation
Thread-Topic: [PATCH 07/13] btrfs: zoned: finish least available block group
 on data BG allocation
Thread-Index: AQHYj2LI6D7IT7kQ0E6jFaHRdT8kuA==
Date:   Mon, 4 Jul 2022 07:25:14 +0000
Message-ID: <PH0PR04MB74167D03DCDC030A680101A79BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <f246521cb4a2720f8f3663679d6331d2b4b13f17.1656909695.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f71c061-cf9a-41af-80fa-08da5d8e5683
x-ms-traffictypediagnostic: DM6PR04MB6092:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrurxFApQPlILcoAha764zG7kkiGIOPvN0nsE2LnR0+lYggjZVfMSPMPs6uItEJtZf7+MdatIwXppaTsM4OF+dxFp9qibXRODub1L4Hwq5xOjtOmjNi6ReQFjU6qvWsTnlRXLYttCAY1dtaCHxdeFeWO9jHVlXBMvj7igHvJpokOAtr0KThOjphs3uzc+WnzxjSfxTiGF8B+jtREv5+k547ZgW5Af99pYYDaah+h3lSlEiViwqeoMn1ZjkVfhiDPLocjU01kF6AQbWnwkQnBb+Dmd3U5k3ezsMjkORZrDDxc/UQcCRiMlADM2xypAE4C/NUf0wTeRsnslItJ4oWbM7uLGKEoSXyoEnlZGntWgaob93x8DX+kJTDSlhswj75y/ureVGsD6XSOQsRKH7C3GnVQD//t1cZhfWVbq27AuPq4lsWso9POuuWmclVCMlGRBAwmcPoOJstxAVs52GMDjxVoUV3DQ0c3Wk2NjvIZYaMvoZ9GdqwLVpTtgIspN71bQJoRYe3vWSVcIw2dMG5KDBeKo68B04Wnpz/7v63K+3w4r94uZaTXt17Ne/5pwISHYFZkEPSEFmLP+/aBBYY4L8IQYECTj9ytMnjNJ32G32lvXX4VmsiZVZP/Ccc99XFuq8GEGQFXjpeYSY4oiBhHM05soAh9831udkeq539CrdmtcjwMML8n/B3rbrqFRGgajprf2NXc7lYW7sInazOeYV4MrxSIeRGlUCpoHXu3fzrM6o5C8vdXlUF5IZ6pTOE6UaQ4KSyhzfIoN5BMLNt2RLpOywe9gfjHhe+0xwsAENFEd4c5ofOAKueADclIV0vR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(82960400001)(86362001)(38100700002)(38070700005)(122000001)(41300700001)(186003)(558084003)(83380400001)(6506007)(478600001)(7696005)(71200400001)(9686003)(53546011)(66476007)(66556008)(64756008)(66446008)(316002)(55016003)(76116006)(33656002)(110136005)(8936002)(91956017)(5660300002)(52536014)(8676002)(2906002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hScBl6UIs6uoeIsx9Gd6av/+SLotLUAwvmh8MiH4rmfFEN6us9xUAn02+7jp?=
 =?us-ascii?Q?9NL7JSJvDxS9EDsmDUd2NiBdMvXS+fvkYYnJRYpBrXM4Wluq+tPvc4r3qMoL?=
 =?us-ascii?Q?eoOGMZKjRg/0EgoXCg7NmF2JHjV/5dG3FsHE7Ne6M8xEes0e2V8Cp65YIx+y?=
 =?us-ascii?Q?ICZBp4XnEZAwO7e+npIMJso4pPG8oO/rNF5qFZHOgBNWRasvGiq2EfOfUe23?=
 =?us-ascii?Q?zCsfHT/zc6aUeWC5fcUtJ5xQjuD2hItQoUOM7WBx057epW28hu0EncTkD0Lo?=
 =?us-ascii?Q?1/CM7CAVOhSsZoY+07mh2Yddow8CLLPqW3cb5ewNSfRBYqNDyOfxXkkf/RaF?=
 =?us-ascii?Q?+V48xUSKWBhvp4N4AdcxsJuwgOhx1qRbXamJSVtf4NKBEklYscTTe2KmW1oZ?=
 =?us-ascii?Q?OFdgQf0ZvuF0eAsRQSOU17pKgn0N/t/L+BgV8BCqxFQh179EzZoxfjTec2PX?=
 =?us-ascii?Q?ffeIMzB5fi/Kv3rcFD24Kq1Fk4uy4mI/bPS+TJ52FicsDSljBNRhm4DufwU7?=
 =?us-ascii?Q?MRQk9a7mAANvUfC5dDgKyKlYN3OxZOOGiQD6b7ax4D2orHCL/90STuz0lcG6?=
 =?us-ascii?Q?ZPKdoTiiboDJXzjQS84KcNb2LMFf4QKWVRAobN13eiSo0k2lOR44QaBMcjWg?=
 =?us-ascii?Q?x2001R4hvWa6vOPdLJGuQBRokb7GE+QyZ2QVfzaBCE6quRNNQHyVPTqkxqza?=
 =?us-ascii?Q?kO2d8VUh/+F+UcpFzCmRjAcGhNqGrOzSy/1ZcdvlZNygXjdy4ERMkFDIweK6?=
 =?us-ascii?Q?Anh+HLZUjEcs/AM4Z20sledrpedAAvlu1kkP0AUuvWPqyu3Sftrpqlra0URF?=
 =?us-ascii?Q?7NUK88mvNOnJwcpPgTyX4NhiAjgetpIESCjtL/zGy7GIYdi48zGEIT/Py/E0?=
 =?us-ascii?Q?LPR3oSNwSddWEbH9PcKqAesLl1xvdyP4DNT9VByKRJMXs8XXPkJNzrQHUQbV?=
 =?us-ascii?Q?5e+jc+MZ6Q+m6foh5dE2sC0t2j63/GjGnZ9dZdAI1VYsup4OYGxCsJ/IL8ac?=
 =?us-ascii?Q?WMmVP1hr2wCt5WsNXQsmHAUrC97QWKdmjM2cjugJZaDp8uY9EiyEFPK5SZCV?=
 =?us-ascii?Q?cRNoV4JLOLOrJF90wC5lGoa8irwGxufzUjenrY8s2uEJvodrCZ6IQmtcu1CN?=
 =?us-ascii?Q?nKsL/gyBP+3TsYMcG9qk79u9moC1XBcIXze3mB6PAoNGm408kgMaso64IBca?=
 =?us-ascii?Q?FkOKc79KdKR1QZWG3w/1eRMNgkHxe5GccCoCNUueLAWkMQy8ASAfwNSmadOk?=
 =?us-ascii?Q?nwHw/WPTD8ubLcTwsTotOUxH4qg2x4goVjzboe4iYKxqJHBT4Adt2lf08/zN?=
 =?us-ascii?Q?qDwwe6tgX0Rg1PIb6rGkbvu7nAcY2SzgyooLMz895TqkMWkuWUi3OmWmVGru?=
 =?us-ascii?Q?dkt0TQt0oKmjlsfgMUwFGImoIi++CSdv0rnwYmIBURAVJ6stkbwVzrSa6/hg?=
 =?us-ascii?Q?4GnVopv0V3oTvO6fpBoFXYg5QOXCqzw4cIbhnX9GLZtGJMDH9/ajyRwo7V4I?=
 =?us-ascii?Q?QPSoQrmm/9t665VzKkkO87UtPK298dkh0n3CFVaLUbCjojwvBH+RbjO/33wW?=
 =?us-ascii?Q?h7hdzT8YvAT7VBXRf/3YcuCB6eG5O9C5BnxArU7gTYUDoqCeEEUt/HL6EmUi?=
 =?us-ascii?Q?wWx5G75e+z5dEeE+kGATlu2nIpwZ67ksLe2eoJfe/l2lVul11eYadr16H9ak?=
 =?us-ascii?Q?o5NqI9kTDidbXtdkYKvWgMh7sIE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f71c061-cf9a-41af-80fa-08da5d8e5683
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 07:25:14.4387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oARlvVhxG/LRdO3fPq6eWfjHefdASDkvvVKpTLRcEJXXYXZKlwRgijRg3Fy5fjMdPsigG4/LaAk0et+Ct95YPxRUrpnVloh6mLWwkLrpFxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6092
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04.07.22 06:59, Naohiro Aota wrote:=0A=
> +=0A=
> +	ret =3D btrfs_zone_finish(min_bg);=0A=
> +	btrfs_put_block_group(min_bg);=0A=
> +=0A=
> +	return ret =3D=3D 0;=0A=
=0A=
Why aren't you propagating the error from btrfs_zone_finish()=0A=
back to the caller?=0A=

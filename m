Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7223023058A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 10:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgG1IiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 04:38:11 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49339 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgG1IiK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 04:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595925490; x=1627461490;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NPZBGB0jzk6fgQknPZk741AcB/BXqacWRnQN1H3vARA=;
  b=TbDmTGH/NxhjXCZoEhkm59TjjzOOBoh4RxPIUhZ2PUjjra+ePOsFF1bV
   0sPFLaCd2+fJ6qKg7jjtCcKwcWiPjnBJbAAkgwIXFz4mDAjcdECwPicAm
   FOMy6RbWXLSNV8cxPQiEqMOFSn8E4bmFaMKHjIe5thTCCwuxqnd4Ja/NH
   vQPKaNKPErxBsLkelhrWFrPuboVHg1DQoQ8MqCHD1hUXOX4VEkX+bdq1F
   decL8HWmiDyaMho4/hkSmn42KEdX9d3NFhSKf5I7Fp0Sh2ckiOdtcWVoY
   g+D7xOlhfHeIA2lTDVoAd6gqiM1XpIWrjDvdqCRtVEzoS9DUE/yxDgIMQ
   g==;
IronPort-SDR: S0beAvwFAu+0pPkMAjMZc4S+T3Cr/O/Kz0yt5LW/5B4QP3IxscirfRJfo+ruKckz8AejpLBJv/
 swUvt+fELVBcVsIIfaMIUEgmepTJGoj3CcTCBPGPaz1xx8sLl5wjiQpqoY4Yeiu4rks3N40e+O
 5i0VxGWNigiHy+qOhURmrjIh08oEagnFlJaO/Wcu61r7LtkyL1Ek9wjctxPxhH+foJhqFhO3qi
 Zv683eZzrPwSXVBYQxYHV6VBjBi3EIpUD8t7HGDWFi2pWecpBQ2zDy6YkEmmFX1+Jdh2L8ZLiG
 aoA=
X-IronPort-AV: E=Sophos;i="5.75,405,1589212800"; 
   d="scan'208";a="252871916"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 16:38:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR5Yb1LlfrfviA8vis5/1HV6stpVWk4GdoDRBKC1BP3ly8QBHMUaL9UxqWigtMeY9LiW1YYz0Io3jNbbJDkIwd6rxlBTCcIBSMW2kMT3u/tfj1hwFYGUsvicKmdyUG4At9tVzYM3auMTenNv/5RZXlyPNsBHVOPilYzEEXU/4TcQyleIB4XweIaHBlpqTZSBcKrSR01/JGiUqREIJyVDJhKhBriKFba7GbGhcx8E5HUpwvXqT+zm+z+qn7o3CwOx3bQ7scjnS/zXdWYSMtii/6aGDjSD9kizi0c0ktd5NdtELrmsS5J4JRzT7u0jJA1bm30FYf+RZyLDTeawD5bEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLQebPy1Y9zxPRAlTJeCDI0RlcPjH7vpie98VpoyknE=;
 b=TJUo16OljCcsJgHoZFTmkNVQgxDMcM2gP+TXA3JpPpCeo4X3/pS5uPNTZQlwMFkdHA9rYK9qWshMUz9oUBi/j2/aejgueEPz8vE4iSxGXRVBYPxDYiTsjqtrh3mBlQ5eaV70EUH+FS4QGHrAv0gAXoQNQT/ekwFZWBh8zNC7NeuqPcmxDBRIXgssvyY7dELgH89AOnioa7Fj8GPl7FG2PM1CUlXE9dxGBxf4fAE7oENavrz3DI+wax0YPJSneXf82H+6BGwSWQp8tkKg7HA3SyX0ey34ub6hYK0IQmdrqsK7E8MRqLRa8bfg9IXXSEuAuYkYA6qHdGsMr7hnjK4KFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLQebPy1Y9zxPRAlTJeCDI0RlcPjH7vpie98VpoyknE=;
 b=hg779tRDzEsyXkTImkCCLLqGQupSQJjDyYi/I/ZMsBl4SLCrdAjefBREMLp8ULh+7ciwqfTswFiuuZFXskXtkiNWRjYX+539ZEyHrd8m4sjgBaP7l//E3XcmzERCuaXaI3+83G2nXqw6GgzrYpU9TpWRqJEldqF9/6ykxkIC5R0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3806.namprd04.prod.outlook.com
 (2603:10b6:805:45::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 08:38:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 08:38:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/4] btrfs-progs: get_fsid_fd() for getting fsid using fd
Thread-Topic: [PATCH 1/4] btrfs-progs: get_fsid_fd() for getting fsid using fd
Thread-Index: AQHWZGJ4KQUlFDDWwUaskY98GK/Ikw==
Date:   Tue, 28 Jul 2020 08:38:08 +0000
Message-ID: <SN4PR0401MB359810C9F028256F5F1C6DAF9B730@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200727220451.30680-1-rgoldwyn@suse.de>
 <20200727220812.2187-1-rgoldwyn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e496caf2-01ab-458d-374c-08d832d18de3
x-ms-traffictypediagnostic: SN6PR04MB3806:
x-microsoft-antispam-prvs: <SN6PR04MB38060A1495E674213ABC21719B730@SN6PR04MB3806.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yw829Q+R7ZQ9265eNPmJnKZHrIrgH96CGrR6GLqlFM7pwsN9kmLcaw/oQrjLb5CVwyQOwddczwuLCNuoGbRwiHdxeYm8sTHSNgfpUTjPWeVy5SUEuKYArD4da4Ln1PmiSmNuROcTOTXetHpt+62cnk8bu2nd6DmywxY6imB73CiC3zh7IAuvPn9VOAYactKq1sw11+SyKTfdqu2XF047b6CV05iI+0/4E8FhozeHZBMvgAMTrn9gm5RfmS7Bjiz5o+t/0EYg1MaptqU18WtC1O7UPA2v6DyPjMQwNWts5dod0vgQWdKrGbSaFkwDlPP9CCKhUCiGh+lZyE9RQBL/dA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(8676002)(53546011)(316002)(186003)(2906002)(9686003)(110136005)(4326008)(33656002)(6506007)(7696005)(26005)(86362001)(478600001)(52536014)(76116006)(66556008)(64756008)(66446008)(66476007)(5660300002)(8936002)(55016002)(558084003)(66946007)(71200400001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nRqhh5J8/GDQENWdliWFYL5F6K7NbYuZmW+hcbw1LWf9NV7ndtdmyJNMTNBIlVGfd5aTCaydxdQEltclJiWaquiXyysMzzdxDtbxOVAz5fysYr3OSDzHpwN49uKaxKBBOetGqd4qCxrkZ2NnKJPT0sKhY5OkXJcPY7m1N5DwlSx0OKJlXrZJWNPVcZvN+hTFk/fiuWJ4htgigWE2fzgt7PAAVzm1XHRf53VQuCNYoNONPvzQm2z/jYwfLfs6CIr3GsEQvWbcx/NYBAfqWAUWi0xDLqF+nJjvjp4yu/t+S6aS2DoMOWyINXsi54BQvXz6xRJagDFSBUQdLz0htq8NTWyJIoBu4RZeOaoqbY6hXcubhlUXk0NTaDUV3vC4QmLyi0p0ku8G32GpCbS9mfRPJL1ttg8SPrWLXBaRPT/D4mFv9haIprFs4gEEdhy/CohcleN6j2snjaFnBoKvTTO02q5LLHv32u7ksC5kvLmh6gXYbr+m2LRo43hedREdvYG0
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e496caf2-01ab-458d-374c-08d832d18de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 08:38:08.1547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbY3g2bsqMVIuZjuR5ZUi8xJxg0PIo1weSvpJTK0qHfdPtBIw8rIrNvoCq38rZaEyjX1UssQ/53b0S5a8iNDh7GWyOF+MxPq+BOO8eMgvLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3806
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2020 00:08, Goldwyn Rodrigues wrote:=0A=
> }=0A=
>  =0A=
> +=0A=
>  static int group_profile_devs_min(u64 flag)=0A=
=0A=
Nit: stray whitespace=0A=

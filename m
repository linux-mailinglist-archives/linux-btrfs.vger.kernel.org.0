Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF3B28CAF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391437AbgJMJ0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 05:26:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57273 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391427AbgJMJ0o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 05:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602581204; x=1634117204;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=FLUAQUMPpwyoQLhxEO/NiSszZZmAQgCewsUr5EIWvlyL1iw6Dm0BsP9C
   1c+nR4JUIC2qBthBl3eTNlHklnpeX+PKNXIFMXrktLjuii7Kn96Jv44uf
   bFW2DUzP5hAFV6cZtxzNcvMXeEgAk61qov89AgtGeaVjRKmw+xPsI4REn
   CwAqNIx3sPfSeoA2tzj0xpbJmmbEC/jrrT9FjnX+k3Ihk3xurF1PlXhFc
   pG+oryddB1g+6RheVF9Alov6Z8f1iapSuOdEEqPJi7pKr8ooJu6RKmnjp
   fhuH7xZXeGvT/9o5HzRyyYFsaRmAkMPNl6hINObu7ttTBcw6ysCOYPyxl
   w==;
IronPort-SDR: eKB0x7gBPZQBsGH7EQIfWTA8gHr0Yd2xp2X4Xm4Gwxz8uBUVsQ8E8bkCBad1wE2LdrFamYvTL4
 r3+i2/fktrf797J8akGYJ61iLy18qj4mOjnGIsHWu8xEFvI07nHz3DV61V/VM4V4lcOyOHPwRE
 H4infqPhr1/vPywaeiifR11Po/p7Elngs+HfLTBKxncNIib64iwXoojP4h9P3wYb357Hj4inb2
 5mqTk3YP0zHNk2prP1vmoH3x0+ajPT2dMna+0YfiyLMti44g4GpJH6WWjDdJimiYGOFiW9y79e
 hEI=
X-IronPort-AV: E=Sophos;i="5.77,369,1596470400"; 
   d="scan'208";a="154131602"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2020 17:26:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBUFeuqB9szrv6ziiius4EnnbKC5rW2O6o64kHF0J3Iqhx7LYOfOqqXvwx4wdnJa20zkeCVgDTBa4DS2nDwpyiTXZad3DnIroLA4YS5E3oDv7jcLD5VD6/+R/gGjUf5GI3S52daFTOF/iPCHK1kDhELIUgXJJJXmzDP+ddxovDi+TxI0OqaT2Zv937PNPGI3agm8w5z3wM1d8VmhXRKSN20LfraEcYbVykq7Z3ffh3IlUSVh13z0Ojqsx5DUiAXl2Gbsr2vaXsTXnIUn/TtCdr8JnMP59j8V51k/MxYszt9o2qPJo9k6xcEIruOyFmad5oNZ8Z+6uwSdTXxJIjUcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=jsdwtnkdZJsLa2w/EQpaRhzO2TEkIZupDLmbNRIxmNQlefUFSIebgyZA7VuH+TqsEfcTPG0zwt4w/Mq0vwmlWnWsYl7q5MUDr0/ZN0l+BeJlrA04/aaYIWBGtkVBXhDxOFwAbZjoqK4zii0oQf85PWL83qPiI1GlglciaCV1XGwkOMnEP632o0rJJ3Qy4kymXYFTQH/bnpOl7qVA51+SKPEv8d+Vngj+nZinHRKGf3XPuwB8ujsBDorkJTkkfTlsYZe+ri6IJk7wZ/qZ4HX2JIl/BkoB4T9JlmG+qssZuFGvo8zOBYE6antirLDz8goigfbeAfHsFVtxg+03rm7hUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=dYTlpH5Ki949R2gEgeDDuehcrxFaAJSp4QfiDoK9xdeVTD2MYYoL0ijQ3vbt7ngjsoFBvoDkzK0UWt4X26lpw575OiMKFberykXAE6gzIZABHLOcUjUTIRaxRxRUW+c2z59g0pwqIophuumWScGkObUsn4eojGO3tK2OIiNLEr4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3519.namprd04.prod.outlook.com (10.167.133.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23; Tue, 13 Oct 2020 09:26:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 09:26:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: assert we are holding the reada_lock when
 releasing a readahead zone
Thread-Topic: [PATCH 3/4] btrfs: assert we are holding the reada_lock when
 releasing a readahead zone
Thread-Index: AQHWoIY3ciNzxOWRGECrI9HL++8YqQ==
Date:   Tue, 13 Oct 2020 09:26:42 +0000
Message-ID: <SN4PR0401MB359871D7B1619F2A55FB7E9A9B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602499587.git.fdmanana@suse.com>
 <6c59a12446b7583172c886bee886d5229f7dccd5.1602499588.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cebcd0d3-e911-43ab-8daa-08d86f5a18e3
x-ms-traffictypediagnostic: SN4PR0401MB3519:
x-microsoft-antispam-prvs: <SN4PR0401MB3519A70688A5AC6856711CA59B040@SN4PR0401MB3519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQEC/PzdycEJyrGSYJLZ5ZgoAJ42UCdh6UovAMMwLAVSDRvpc0xOpBsnoTysWai431zqK10hymsKSBycEVUrfW114Xemx6pIHiLbKJVOuLkzgwhpY3CAmMKcB3EkPUpkEeJGy5iegQKwfDMC+6FJVydO108HaUXN9QUP1nM+Iuut+rjUKuqMjpJ1Y2HbimBK6/tkGf03Fvyp9qKo+cWvNM/gmfm4Hjv8rUX6Q+uk9kcC22/uxHajSntHEnzzG8SzB5OV8AI/zmArmQ1G6yweQJljpTyj3+DigBU3lHWKn/IHErVYQQXDTwWPfi1Mw6PDXvrj8qqL0Ld+ngXt97LoyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(7696005)(4270600006)(5660300002)(558084003)(86362001)(478600001)(2906002)(19618925003)(316002)(186003)(6506007)(9686003)(8676002)(76116006)(71200400001)(66556008)(110136005)(66946007)(66476007)(91956017)(66446008)(64756008)(33656002)(26005)(8936002)(52536014)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /zr51u+DFSykIMLp5GL1WRtvONc0OWKrMowasRE0iO/DSgUTO2bbfua+08AChGH6Jzv/9bRXpcYFhsslRLKyD6sEBH5kcyuuUWym5dcwP5hwIhOxKbbgO0KlTpP++sGRH5GltCE/pis/qKOoxFNCcMi6KYrJGMx626cnC/UbDAGnTBMNmqzQgTyQQhdtUqgKmiCZyF0XFSd2j3HtTR5Y/ZOFJzlj5kOJvb0lzmAYz3GL6gfuNEKUgYy9yc36GRsGDvzeThO7Qh8VzBzDxgcbkAhK8U+ioIhQtBY//5r/q9tamrDgGwGnnckMhlepL1Qq2TPaJ3baO58em6bYVIEfto+4ba0UawmSeENIwQdcahWUf+0ZoTH1ybYKB+CcPH8oNP7OKRafbwjRlOwti3bUFssvxovctpLjTnk0b6WZf0ykM1hTPkf+hy0jIptS2jE/msYL6xZmMxpHjzq/UXHMFV+094gTbAcn06XN54yun6fl6dRzPyAQ02aZ+fO3F5mdPGw2d3r92I67nTSGcmYBswLazqVMpXd0lLdPRVcrJPE63qZntVHrf/YfWPyOsZLrgSCrmd2FuCWz9tlkAxa9TUfenBeD2ZDgrhUPKFJNCahvWboZsd4Cma0pGxjUttwnEpBR0KWr8t5s93Tu/g/sEw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebcd0d3-e911-43ab-8daa-08d86f5a18e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 09:26:42.6941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2oc6MZG1DeLnmtWavlDGZveT3EdX14HQBXhTsPl/NaoXn2xAE/pAyby0jKLPlb+EA5t4YgClAZcyvaKf0vTP0p4KM1NEZe1zrvOY9A6pyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

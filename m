Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91429237C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 10:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgJSISQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 04:18:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54995 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgJSISQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 04:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603095495; x=1634631495;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+BpIEyPRfmyrOA6/E9ebK68b7ZlVFhqWJ1s5onMDm+E=;
  b=EemS2jJXjfcsaLyyvzXOxWQ4T5BPbpy/Xv7WBnj89BGhXY4wAukSQ4Be
   eTOmqR5D6T68+pkOXPoX0GdVEReLsKOrjYPtgR0g+gGFWz4L4NmbRztFE
   kK+T8+syaH04SZu6gMzonarHgUwmqFpqhHvHmuxXy1ssPxoUvx6ohCEeH
   Zw/8VLd3q3eJqh06TPecM7wCyMTwL7cmYNcLk4MOOru5gAxn7Cni8N4+n
   +Em89q4vdb/11WnIX98OEWpjHwDj+0axRlJwfdItu9GhMmOe4ebF1xrRH
   rljVpDl+Hr1hWFneddgl1f3Yo7R1oaMuwSHu6Cj2zOikXu1uTw3f67mL2
   w==;
IronPort-SDR: JSjMuIKigvwRRlo27sBv5ZRC9bJxsA7Hzur28f9KXaxrmg52k1O80kVF+HVSPlli1lO/XeMIBa
 6VYPglYAeLf15oKMG+G/ouNxzNQbVFYV3Pe16gexhRGY3Z2b192J7GpAYOGiOHhIylMKO5hFwJ
 +pf1Vv6FhqWyWZVmHF/nRMHUZEKDff+EpFpqeSrYs/KnqNa7xwzmZo3/Y6CNE0e4MTOac09DxW
 0yR/mQCNgmQULpv3sOlLa+Zsza2j8oJ/QosPTf49yLiaRzlbsdE8vhS5KFe5FQQzykDiNtSL4u
 sIA=
X-IronPort-AV: E=Sophos;i="5.77,394,1596470400"; 
   d="scan'208";a="154735838"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 16:18:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOLf7gqhVH48j5i0Os/PUEsoN1KCUM8pj6UxYrMBDJRpsJRDYBAmSenjaOPTvgMc35OQnNQXEXJ0xpcLDe6GI6LgQ1/Q8UHoqiFBD9GFDXja4ioaHnwo5FN7yIPnsWIDGhcAHy7Us2ReA6zBM44tnXokmHjFWHZG+X8/v6xa9ClpPF26Ze7sCOZZgMeWZ+aFgIwu8B4DCjfUF00YcEBMm3tvsG7oZdWcTTPqi1tYaZcvHuzCjPiWO4L8I2VVr3MyNzO2yed/XCCODL+5MGRSJo8Shyh3Cyu/vXCazs3m6elYdOdRJ5b9JKnghyaYslibWK6ikygo5ZfSNSi+NEjyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BpIEyPRfmyrOA6/E9ebK68b7ZlVFhqWJ1s5onMDm+E=;
 b=GGbFPOku165Ih9WE+kDHnSP8dmVHSHwoU03A5IyQNPu9SKdpjTZj+lPQYUAJg+WxBerWcTlDon+oEQ5Fcgscioo2UoPUHTyDP7eJNjRjKgZ/Z1agwnbSoG1u6ViEOKyCfhqw/KSG1q31S2WqxqOA6/vlIXCWZipkI4zVZjAbYhAyWAnojoHGGAAYuDa91eqLTFpqsRXL3mSZTnOGhtcjwOyzEVdoj4bXuKrxXWXDC7OccO6s50qBeDS51lsFySe49vZk0aeLHAmHQPPMmgjrzfMqQVs5QJi30YbYnzJxcksEY71KfbOjB2MrT5HWid9BbgzkoTwFZyamYvmezZABYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BpIEyPRfmyrOA6/E9ebK68b7ZlVFhqWJ1s5onMDm+E=;
 b=IJXmLdd2tQVzZgyNM3pp/DcSF2pZXVkFVIMm0wZ2drRM/lHJ5U9JNUsR6IcuL8MJUjlxe1RhY7JP4WMhqGWTq2w2Go+Lh9/aasvIL0RXTYzAcabSYghJ/oZBOTXU2YTOy3hAewGZrnTENndedw2uWo25w2yawkVBDNcERg9PxAk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5119.namprd04.prod.outlook.com
 (2603:10b6:805:9f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 08:18:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.024; Mon, 19 Oct 2020
 08:18:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v4 4/8] btrfs: add a helper to print out rescue= options
Thread-Topic: [PATCH v4 4/8] btrfs: add a helper to print out rescue= options
Thread-Index: AQHWo9Enia1jZGz+HE+faw/Gh9aA6g==
Date:   Mon, 19 Oct 2020 08:18:11 +0000
Message-ID: <SN4PR0401MB359807E871A6CC521906A63F9B1E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602862052.git.josef@toxicpanda.com>
 <4d3297668dd9ab26681b5632232fb1f6eb00cb73.1602862052.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a61:53e:3c01:9550:141d:bfe3:44cb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73986cbe-342f-4af5-4305-08d8740784b9
x-ms-traffictypediagnostic: SN6PR04MB5119:
x-microsoft-antispam-prvs: <SN6PR04MB51194714AE3325E3F7F4F62E9B1E0@SN6PR04MB5119.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /b8utgznM/lYaEPpMpPwYC9JiOQc1F6euWeIHp0C7luDKRCUNKhJNZCUKjpToqPmMDYgKN+SVGXHcZJyHOaAh5bD+0pMGFOof/wWJk5ZCemEPv3uH4mbOvBQaLMF/j6u1r77g9wrOszzJpLG+/h3597tfyGbuPY4uNhPUtcRIkq6f4advvo2OEnvVPgbPvfo4pPrwN8Mat2ybgiagT8QWhSrVwZPzLRSj4d7ix/K4Y12cZeUETcvb7fpyJOO4AbQLXOJbWnRyEyzFwFlBE9/CSQCHU0MkdtjWXuztS97o5x1vji2LF8xqpMAtadqhkGxyVIw7kAABELVFfOkE8i/cV/76x71RCaEnr9YftIjktfLdc/NP2LATequ/m3vIEuo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(8936002)(8676002)(6506007)(7696005)(558084003)(71200400001)(110136005)(4270600006)(316002)(64756008)(5660300002)(91956017)(66946007)(76116006)(186003)(66446008)(52536014)(9686003)(33656002)(2906002)(55016002)(86362001)(66476007)(478600001)(66556008)(151823002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CSgCmeJeoXFsUlb79PAroAakkADY/bLmtgcPROJgV0Ds9rdUmBX4IogUcGgzxlScoP2jnZpv3j5g/iwZVka3uAkvjYptEHXmoy2p7BKuVNSkXBTL37+xTF7/XJks20JkyZnTq+U2qRmkVoMUmBGus1yINVP1RPTIwshoQsUy+RUWchaaKP/j5aUCsDclckZU4pNgAR6IFnZGJgHO6zdPNeLNfgBS0W/EDPIh42aA9AifAqRSNSOFnpHxGNT2RbQt+EfDYPbCTVDNlZBJs6AHHV5okhUzW8a0xIZ8Ue3WTywjXHhL+XD/JcNnwioDh3YmZwkTuAAiaxlAKs2Fw8ar4SvGxzMvQ8/mhw0ZViuDhqLFgLglSi5NWfsyQd3L/GVv4HaKB4Y37kRtPTOnZxjp89Mc9KxY7+priX0Px4YFxduWFfh7ieuvlP+hV4hEpGmiH2BV2oQNyxKDNRSL8B479DwyUi7wZ84cxMi6/1GJrOqYOrL7wkQvwvosuqYH6PlfAZiU9H4eUdro+VWZXemGVH+KaOdAdwjtHTbzYlMDafIpaQ0dVMqJ7AhIiW682s0asEaK3q6guQvDX9murcdvehTHuKl510Ea1x4vfuL+QZupgxPKi33frCWvXN2mOWfGqmW1qxx/uXtw1vzGw/I9w1blrkM1sbRrsP63TKDffEpV1qu+i2B2EYmrMuXAsJ41SWPbNylVicrWZ60QPTkgbg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73986cbe-342f-4af5-4305-08d8740784b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 08:18:11.1862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NYelLiG1eTx5u0XENyYBiMTbgvmu24RHVF0ndQrWhh0ZC1jaRXNHt5Jl9l7iRH5o8+914bMfzkjrFcLmAKW09Ch+eK84c4zrxnJumNGN7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5119
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good to me,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2344B2B01F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 10:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgKLJao (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 04:30:44 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41676 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKLJam (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 04:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605174471; x=1636710471;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=RbAp6SrjkEZ1Q5GYGyVgH2AUhkJAcjTKEXIqJGRd7d/Ezq9mfi+per2a
   KmVEsR/8P++LsdLOW8etBqP5qc75woZaV0euHO3lO9ZrfXhDOU6uRS/d4
   Uws/WRyIeTApRED0eFEO/7UsDhvvERtSaHcDS6S0Oj6zqx/6pvCzJ6Eyh
   6g26RhxGe3xdRqTlie9TB7nkJY5hQR4vBbm828RukwKqsB64Msrdln6If
   24O+bluBzyEZvmT7SfhN3lGd/s+yQLwo3u7UUu0mXJ5i9dp5Fw66vlF5v
   0h5tusChUVNIgP4gJ+p6rJjbJeQ7alwJ8/g8aiIya289cpoQ84nfeKvCf
   Q==;
IronPort-SDR: t45OI+SbxiRtqz8OcLWdvxqwYxgXGqnC2fFEb3gouhUtXo1CA7QMMmiQ0UnVv/iG/36INTplg2
 Ne2YvfCMM5oTG6ZPUNHDCHn/U9WMB2CXAn1R8cf9nrX8aYIqyoglbqT/XiFN1+ATijjvr5x4aA
 gEWQYF1OU9d07aqEgMRPcgze5zlxZHwJj0yGAnCosY054yecmYLaFEhTgAVpKEmRNQC5qysNfo
 yU4mz7NbtQ0vwcAVN914qLDmELHHK7whj6cFVCGIgm+a2EmDonyBXwi5QwoqLwRYxsIBi+zAi3
 A+w=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; 
   d="scan'208";a="256037078"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 17:47:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SItQbXpI/dU0fEZfpRCCy9P1xOHhOVXC94saN/lDnaHht5tkDhl9cK+e8MGsF5mhWbSqAQ0IY1FEBRdZKACNwsXLlcN3P5EB3ySOMdgZW6s6j3QMLAUfs0mIm1GL476n/TYqAGsGDQ6iIIFGSMsvTy7vojt0hSYdx18HCB7tR2Xkmx55ELJ6Uhndwy11qnSV2a6wJzhPofgSsUOWLUJwGdlmZhxKoEyXgxNdbCMIhJ7aPYywU/HMkheVAz2RGUNKF890jtRhlzkWW00VbqdGU/XQusu1jvbyFR24Q6ITcFvuDzWUfZqxuO8WTAsYS+7PsjcVM0kqeb7t7NAUgiMVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IcdTXd/k4PSrevt/zQ7c953AoqPJUsf66FPj97jERwqgnBOQtH22FHzh/m4eAz7vgW9E5iR5Ps/8KxQ/kv8/q2KdxjGCH1wNBDBUMAOooWsEIHMgX6tPfr0IlIjQCmvcxqnOYm64/0e5dYZKxlRl9kOEF2MbNabF5zFQAmbeAHlPS4jyAaJ3J330ZWQi7Gr3b+IbuoCmTAKIcpLDJlYW88rGVhJyTsgVOKsDsxanfs46rFOpmxhGtGaxUfqYNvaPJLMR+j39wYHoUYoJFkcpG70Smu+n5eUVxVjQ1Xf+3UX75zNua5rpy/cE+J5s0/48deqQ0uFbsRiZZKFbstalHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Y9uWW9Gd9OWdNdwFNPf1rxmHhWLlpt7CgE4VBL1pWOgI7FM2GCSv24IdONIVgEgdwNbN2lQx9tjWYSAmWJnBFuelBaI8+nY3CGsz6bzCdFNfxPTY/RvEdn6LrOQ/ZkfmIS+qZ4rHlF9d3gy+VSxz9LQQcO+mSNstKLaiCa+dhis=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3965.namprd04.prod.outlook.com
 (2603:10b6:805:44::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 12 Nov
 2020 09:30:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 09:30:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] btrfs: pass bio_offset to check_data_csum()
 directly
Thread-Topic: [PATCH v3 2/2] btrfs: pass bio_offset to check_data_csum()
 directly
Thread-Index: AQHWuNCUd55dehDwEEy9K58sALPrIA==
Date:   Thu, 12 Nov 2020 09:30:40 +0000
Message-ID: <SN4PR0401MB3598AC32A779A0F19238F4809BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201112084758.73617-1-wqu@suse.com>
 <20201112084758.73617-3-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:3d02:4ac1:70fb:2ebb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b603f7f9-0260-4d31-f975-08d886ed9ee6
x-ms-traffictypediagnostic: SN6PR04MB3965:
x-microsoft-antispam-prvs: <SN6PR04MB396555AE4C99DFA953D183659BE70@SN6PR04MB3965.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JXJmYNdyy/K3VeBaWNqTzJgSl/xJ/iVYD4V1f3B7L7bknSq/S7Ki1h4KfOQhCOxo+YvW8HQyz+wYJaIEUug2tAVy61OpPydeQ279p4dOKaraFRV3PBOUsD5rpQTJM+1t4AmCFEjB/WMO7KWal16klM+Vk/dEJhn2o5e/vSGJtDctOXypx/ljcSXy81sfqbr5vOFMouzGXnQQjQ301geIovq4qs23MTnVYXWkJTPCl2rVTvgHRtKfqb6ozhRsJWsnsr7RapQp7K8GVR8jEiYSKUZktCiN5Q85H0qJi02NhMLtdc3Wg6KTktNV1C1+XWw3ftl+9W6dIb/z1wHNIE+fMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(8676002)(9686003)(316002)(8936002)(33656002)(71200400001)(4270600006)(5660300002)(186003)(76116006)(19618925003)(66556008)(110136005)(2906002)(478600001)(6506007)(86362001)(55016002)(7696005)(66946007)(66476007)(66446008)(91956017)(558084003)(64756008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: s6zsJmTQB0CmQ41z8D9e2OtznJDL1QY9dHoZUXkRXDMClRlmpfjUU85ZgaHI8feIXQuvvAJeTR6eYgbTNRk0edZFe5CyC6HnI6WDlqtXzmiuLt26HwnNS2S2EgDpr3VEiDDst0oN89bPLApRfhhPYDc/pgovJw6c6GnTRzTTwQF0QObqLq9a0SXs/UpGCeCtEsi6JP5QafVkEvivX+reOO5mEQ/OIarwtNnVTDhfZipYdCNblZR8MrkAliivYLFCqs9acSg6Rbcd326E87/rGjTJw6MYC1SSy4VWL2eOU0TY0C/zUd0mocmLE3TvPK7Oh9ScjbvtKeAEF50sREdPz6CmSY9NzkxhldAQCL883Ij1ondPlyIgIWn4OYYuznrg7q2p3AK6tJ72sE0Qpydr1czWZ007f5gmyCRRpyEeg9PjVniptP80qVSarywMSnQGtI19QkOxLjQ0aXk8ROv7cTiaPpQwNpW0j+FJLHBftley4b8Gfer2JfQFf5Q4db2qThxMf8jAxEHtn1jsuXiqUgq+e3NdjZpxwiSJq3jo5FBRK31IAQSEPv85m3m8/8hpiitT84WSW3SYaFxpALzSiCFXYav25IShZQRKO00XqLK9t4N0Ab8L4KHmbil0aBCztbYTrTINkBBkYtaQX+PQaDRP3Nx33hr3n/nGz+yTazQNbt0p7Pd2hFd7+jBGeTFzV6KHhWhXWAXAh0f58+k8xQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b603f7f9-0260-4d31-f975-08d886ed9ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 09:30:40.3125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ug+8FHPkDwhI5oDciHoQ+tJV/APQB/sLh8kNljbOgMRYq0nL0hJiqUIMpfuIVrCEt/3jukM2OLVrh7RLPAAtJV4f4rE9+E91PbJ8MQCIMoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3965
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

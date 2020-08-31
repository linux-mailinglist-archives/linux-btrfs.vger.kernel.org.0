Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D7257934
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHaM0y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 08:26:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41185 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgHaM0U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598876779; x=1630412779;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=hqtoCFJEkXPoxjKTY9hT00l4JlGoFlfd7ZQtxRKGL6FtTOc1a4VpBTPd
   ob/g5Do/avE03U2zQBZZh0oW6idMIEpGDtlBiVC//rW/6fviDiLET9EqY
   Jw8H+ZZoLDB/DhvMHXFfpN+iaSG/d9n5rq8hqHlvsiy49+vIgfKyEMBWm
   c11woAkpxSek1Jr9xDs+p2DlchSjxHrOFi4q1fUg6Fwo+CgpycLUimzXL
   gwAgL+xNp0CICPJJ2WqZTpLyxDYwPtO9cYw1cBi5yrEuibASM9SHw5rxq
   qGo7g8lNN3VqdTEfrpzDak/JuRtSq6K45udot/C+Sq2k1iOgm8IhWGnhQ
   w==;
IronPort-SDR: 0KsWr2oYudt90rG0Y2tv0/96xqY6dorVOGdHZxDeseD4SI8m4gWLLDk75Vlx6kbxKEdtTgmqGX
 UXFdc1VrhJckS7ZLa1j7XgFB/YkTGQ+P3EkFoac7fqk5Q4DkudhyCBSae61YxATuyWEM8LjnKg
 U/fhAvdhBvz3Ay+4ZEh9Ti3+KIQYnnZGk1Ttf5GpxHkAL4l0M5kAeNXIP32gWy7C0e9Mau1NlU
 qesB+UIZH7hCi04PEUyBJjq0pmn8JKxIjmrck8K3VEn9wfJKbjsbmKtoxtRnjlQpoc7zHvoaTQ
 Sr4=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="150559377"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 20:26:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKwDWHhC6a2ql7xz5z4fxK2QGTm9c14NCKjJ8YvSsqXLSbNsojGM3NMajxam62NJmSBfXMTAJE/50A9uccxQ7HwYP72JLGgKwF5bym1qH+9CaRxhVNwMQ7CxuxwKrn1e7tO/UDB+VXdgZs8i45fxsb2/Hd5+6uNseOMZBS3ucNZd9aVTtqg1Ae7n0PFali2lwrdy3A8P0hQ02iuzQH4JSh/zhdqQq9kHT1184pdLb/rgvUUedcp1zxpC34Va4uv3+NW5Fu+oO+B3kELZq389KUImPEssFsR4YzkT811i6xViJmQKfYxjhZUQX5CfAAlTNl9T80m/e7Mgp8nsRmzY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=i82BSDGLAEfpTHWRJsH5CCTFoH4WlE8SzJ7/OvTiyLEsEyb0iI07LNrrGj3fr5wraX2XUfoc7apHzIKg+f21PHpmvvgjtyndVLb0+gCuQP7TeMGDJNgzK9zWjlLHg26lWwMxnLrkVdXfEZ7Wms0wY3HAcpEudt1WeJvBbct0FlI9tF4KDUKAv3rtpW3Iv7E6Rwa8sBte880JmRjmNgw5/HXhraFWHfJzZMxdzo1XfwlWfhDz9Sq8zZaGIU7Fa+mib31tFY0Vkxzw+seL4ehtgAGxOdKaqjwkZTFyeTJ1KZQecRdjs+SvjxGMip03e8qkT6umFy0fu9XdLSkY7APaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fddwa2P+12y7xz8eA4oTLwIMwqKwS/f/mRMXrLuLz7IHEa4z7oATIXPTyHBSbux6dQPHZq9eVuMa+a7EbiGvdhLsR8B84ukp/YsEY+J1SF9Mf7omdn0Y02aMBl585asOP2oN3e9Ei2L3IqZXOk+U+0A4vhFIX8jm2SjD5PYDJ/8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2142.namprd04.prod.outlook.com
 (2603:10b6:804:16::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 12:26:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 12:26:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/12] btrfs: Make get_extent_skip_holes take btrfs_inode
Thread-Topic: [PATCH 08/12] btrfs: Make get_extent_skip_holes take btrfs_inode
Thread-Index: AQHWf41vW0ptEWpyk0GDEGnJ4zyvSA==
Date:   Mon, 31 Aug 2020 12:26:18 +0000
Message-ID: <SN4PR0401MB35984190200C258ADCED5AFF9B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-9-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c51:a08a:7ebe:d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7dfc35b-46d1-44e4-bac9-08d84da90fd1
x-ms-traffictypediagnostic: SN2PR04MB2142:
x-microsoft-antispam-prvs: <SN2PR04MB2142BB39B4A6D2ACEFC63DD69B510@SN2PR04MB2142.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMfBB0E+e0Wl5AOCzXdKi6N6uJK68TS7DVkzwSgu5+OopEIiGDPA/GKG/RaVA5o0qbVag1EI5zQvMALlF6pceTHjrF9ijcUyTtAzaoDhcofaBlp+VTLqNYKSCxBmPcH/KEVJDgFdA9b/CodiP1I8/96UgDYqybGVNaE0GkHIUunjy5YkwBQ+GQ6KuNrD9VJdP8R+Bs98iYr6H9i3AVBpnYSvF87unTzs+GxRdNJ6u7I1SQAIvL+beIcBGmyjdEwvhhGljLHhj5U1xg3jGzT/+ue3hDcoFNWHpqaRvzpqZanX1hJOShLAeWls+KetNz3RlHvDrz/mEIbpeP7IB8If1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(76116006)(91956017)(186003)(7696005)(19618925003)(8936002)(8676002)(5660300002)(52536014)(6506007)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(110136005)(55016002)(558084003)(71200400001)(33656002)(478600001)(86362001)(2906002)(4270600006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zAts+ICqmRXb6O3ZFkkdxWANC+/JGnQtKtztc4KysrWDe5pjubvvOdvPYASrr2yFgvBAonMsVAAoO2F7h/RMgaBynUx6ch9xc50sjCXjgREb+Veoy+IBrBxyBSciMrImXxM+oLnMMZw95TkXBixFbXBU4uWuumrAkoMIc2QlwEM0UjSnJ1fYHo1gv6/6x0ISLTwtabzdFXsdJbW4pSoQ1Da2iyydImFTeEJIm/04vr87Xrs2E1nhRO5y/Y2tj2cSvRhCy7l0VOlaMBttbUsDL19TKyzxALo+0KjmAzlazmd0Uxz86m0rVg+5VaH9ZSdjcNLOFC4g6auB9GHZYbSHW8AG6sokTF25W9bgZq6hnkDUX4mMkxLHMwX5FM4xnVMp7OIQkUb7MXoKL9tW9cijviemiJKZ9pZ+3csmRLQZcRW+/5tKi8cxdqKyaMlW2406VjLWbxzgY2aG9x2JLvORZ4f/CAUSjZ8CDL+7OYHWcbl4D0fFi4dcGTx8kF1OfK30yLckv3ILit62O1jaM+IA7Lxa5qpJWtMdKn8DfiMZxtIBrIPcLSfI7tIXp2yuGqwp25CFQoSvszSWIWauHm1WUJaRIZ7rvPlGQMAo+tRYJwlkVbxvuPhLwKeqDGBymD4UxwjrobMzXI+4iU0GcuVulF6I4Lv7v2wW7PGpgTfwq6lpO9lhbhsAjvvS8ik+dctaUMpQ54mtoOXnV7KfQLRTxw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dfc35b-46d1-44e4-bac9-08d84da90fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 12:26:18.1810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfHLUCJ+hqiJtDCU9VbZ/XWZJrB8EZw18MuxHAWd0AmtmHjEQp5DxSDm2ODHBVEFZbYZ9DRUrbgFUezL/yIYon/cv5n32a7kQ7x+xX7XXFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2142
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

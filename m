Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B711257A2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 15:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgHaNOw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 09:14:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35316 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaNOl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 09:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598879681; x=1630415681;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ojhVGAsLudRQgSyB0mbPXahfpbHhm2xdx4mVhyHR3l9pkWjmLHtwOX1S
   RFQ8ZQUFE0V8Sp3dbnqdfZLCTGWxbajV6q8lg2hIbEal6rCv/8XJLEMDP
   7vysojN6/KhfT1uW4MXdy46k/Klct0dFjB+ogvW/u/7NGQZ0KLm54ZaSL
   n90HLIrK9K042qKRKpDtlm/D0uCINsz56wigW7STXRtDxIF0hmaPrXSxK
   rPstUQoM93UlHuf7PgpHvYxyyTrL7CRu82a0Yh359mMqrwoNAZEHl5LDN
   G2CeokHG6vNAi2Iozm/XlaBnEWZNS8d+xMVfVR7CIlysMmDA/rc36clFJ
   A==;
IronPort-SDR: 9RjVsJu7QZMB9AwZJD7a95Bkdgg2II0mOp7MYLJgTwRIjSNOurWHmhYh7MmVWxPA8DsvC3T7eX
 jIyN4GpAf3oYNmqOcWNYI9dNQ8N97PzgAmiMDMdhQ/vyoV+P9dew1PRvy5+UGEIWjxQ27iXwdC
 /6E90sYtPvfQGoGrBYJ1ZleDH+tEWyhQNmawNuYBaVQXm1RC+FEwYznuZYxFm8QIndI1YY9YvF
 iWIYBmuZSIKiz33lG5/sx5qLMi1ZnobqB8pKj3V1oXsKpZiWT42O4k3N75G6gGM0xAnIAhFZae
 n9c=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="146159086"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 21:14:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMlUPNfcvXuMZx3lg0HrgxXzVqrGbiHkC5YcxRB7bmDGZOLaEacFovE9YOb9CyoGm+qBQy6p+ezXr8E6ghubsGToCXgBN/wgqUpVU0aqDds0uKZp35zVSWED3hagrA9zR7N/ax7OBMbJKln24l7O1cbcE5qt5S/IqwyFFvPIOuRq/yckj63UNmegJyySME8NQCfsevIKGuEKd/I358BvKzgh3S/c/R5D/k+VAKUfjrhllBSrFi6DHxMWJGyOsIQYY8aPnl2gQW+6nhRoZgMtN/3MWA0eF1C9W4iV5txCmsD8lZIWMUAgivdxV0JFRbm4+NXQQZa4UmSCHfpdSEcG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UNAbXa0QB3AVuQ5hm0DfERm8MaM8Gg4TY9Zb7HQPNb2HH5A8EzB87NgoFFZBc3Nn0bkHIJ1Ll8dV0QwtJD6snQcHT7qwGLEcfPB3ukw+Hjxie3xAnd8MNjNRIJs7WpUk3hZ+pAgAVpThBfnfdDDSh7qOqN4y43e29H1bSUE+rGyvskD+52hxjbl5OA10EL8xmnHqiV93NmJjWZwt4MSD5CUzP+h/ft0OuNmhwLHLuIiBEPOsje6ohTJGHfLzoEU2qUQ0vuxxGHUtqIddy38BNl1eBGoOJxN3/clTRA7yrI2+V2IfN/6Ja32sfTbXx3pSfkHpDddSB0xjhYGEZN+b2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dq2QOBTSFams+Na7Mr4vj9pYF4EEwWXWvJ0FFc9EUrjOxxT6Bpd/dW/dkVtE79HskKDEfyXTO4Xk/BsI9t+9ctinn/tdWU4vT05LPwd+lK81p9GA+TmJ+cAlpsoxcp/GH9OWeFqpkOeewuNobmxAjI4WWrpLTmlX71/hhfmwD3w=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2143.namprd04.prod.outlook.com
 (2603:10b6:804:e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 13:14:38 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 13:14:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/12] btrfs: Make btrfs_find_ordered_sum take btrfs_inode
Thread-Topic: [PATCH 09/12] btrfs: Make btrfs_find_ordered_sum take
 btrfs_inode
Thread-Index: AQHWf41xc8Ip819Od0KchJedZ9COag==
Date:   Mon, 31 Aug 2020 13:14:38 +0000
Message-ID: <SN4PR0401MB35981D360FD35C862264A84E9B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-10-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c51:a08a:7ebe:d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5c5346a-7336-41be-4d29-08d84dafd070
x-ms-traffictypediagnostic: SN2PR04MB2143:
x-microsoft-antispam-prvs: <SN2PR04MB214380DFB6C994EE885637F79B510@SN2PR04MB2143.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5cJQOfbfOJJ48otI5Hk7trl2w0JIwcd+el3fF5X9YfN4sMYE0BQgMzAudYEuWca87+h63L0btdbxkpSROIhGhqqzIwJzc2/7DMEPnMpPrAe0EiZ8qP7sjuiKdyVhgbfbO08HN3ViL/T8dkbmJCHdlMV+mGk29s+SOx/xkLv4uCSYQ6eT/phvcQk2fnZtOZwaAJgeKUNGUfiGoGIdDkT5uX1+5grj7by1gh+lPMN/1aNa1d6Iue4DGq63MKbE1XnxLFT7WGvdbyLAARGNVNoUog51+1PD5mSskNhB/pYwMyq4oGSp6p+bRQ6PmZryBz1EdHrno4MQ0uI+axtRFA6TvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(52536014)(8936002)(110136005)(55016002)(6506007)(8676002)(71200400001)(5660300002)(316002)(186003)(66946007)(7696005)(2906002)(478600001)(33656002)(76116006)(9686003)(86362001)(558084003)(19618925003)(91956017)(66446008)(4270600006)(66476007)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: H9Q7lCfjQC0q45GMC4uTgfZMExdz5wfRquoxzE+SzMRTW1anDiDXp7LoxRekSGhQlzrpy1ghFT/FbOEcANeme7ERJeVlJvO4HlMryMsgzyLImxlXpsZPct+3Si+KBYzZrS2u+mKp2VipUxoylQpOLHutJbkYAxHtvVugbzOlliB+lV21TfipAh61yH5HfpC6gLoLLkjOA7mWyhpLDzDqo/BKn5JtVvPSYa3YP+WbuV3FPoqblNGGz3cdekE2NZuXZgwxwuCnKESwigT1/zYtAgQaWbAiWCF3RJuUtmtFwjrAJZ5QZQORD1/vcW+aEYHiSg6b4o0j46NOtB8L6lZemmPyKUmuNUx/2aiJzK0jMtCB0uhQsQrxheADIi/Bvmu7QJZNjWkOse0YgzO4vXkPh/HgycSNla6pGje2+1kKGYkGSVbQvQzhgiobzMrKxnvlVs59JGAvnxvU7vrrb82s2gb/7lX58IOcerCbcPnCBp4bmRdEpJqA8IoEhHlkny4v6b1PvGOuypgCizOLNvDzEP/59I6HqQAOhs0HKXpr/x7IsRrdnJqcB2BQbCZl8IMLQGXIPIGPegkPbCDG9De9zu6DwaOZF5JZRwXTmVWc1fcMX/ZgWUdoK60egheC71wNAUZNWeRe1l7gddOgpMWPZujlXtZkFoWSxjT0QV/Yte4dUzNAY9e/bHW/IKa1SQRWo3z+RKKJh5ZYQqgnX1MssA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c5346a-7336-41be-4d29-08d84dafd070
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 13:14:38.3272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /AKiG96Z1t+Vp2XH1Wtx7jErPdu5Vr5MWTXgntRPnbMibO5aOdTbDIjl8tvyGbyr4+UMaf8dX0lwuIYNGGl4TgCs39WVbVXTtM7nYVTQMEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2143
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

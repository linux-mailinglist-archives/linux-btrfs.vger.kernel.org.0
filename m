Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198591ACA6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbgDPPet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 11:34:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44248 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731274AbgDPPeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 11:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587051276; x=1618587276;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/82S3h02SC6HotDfgjcYyyVEkeXFpBSkPbP4MDpsx3A=;
  b=NqNvDdYV/BYITZXLV6aaim4bQe6zwM5qTxCcgf/MBLLXjyjh7EO6TNOA
   kDfgf8rhQEYkBLYKPXY+VKCS5AWPc7T/a0/6UrLsB01v43dBkMH+SIoXI
   ob7QGuWizfEgq8ebX/S/BkPWfLi9Z38jrB4Bs5Lrc/6ne59+RfAVeKZG2
   ryno4WfREV92o3F8NxxmGhlmK2O6NYBch7NEtdA+Bl8q2e1GfRfyk3ZYU
   HWcvgDq4iKh2Pq1nJq8Zl//EM4bssKSg3VFBNnPXXV9In7tGjo5fX54or
   BjwAT4K5XMb5WJYwidS539+fYOJsZ1jdCRWJ43yNnDA6j00UbH1Uva1ps
   A==;
IronPort-SDR: MO1e2p0GWN/dSIkD1D9ek8ir5agKRJgbPhGgU+5Q/WvbvZR5i6psGZXle3/9+DiJKWZyVtro7I
 u4U7O5BjJ7pQC9PhZzyK9Sp6Mufn01y8lXumHUolkKZy8t69peNjEQKCvZVK2U3foOXmCfNc85
 zhNP4GumdOz445GGjDRJzA9Od0yCoy4ENgPGYPhDZKItfNz/lsu2dQT3NGph3N1A7RhxLjNZgP
 4cPj+Qej9WTsVO+yBrL8SzuIFosWEqOg4JGJEUZrJmHDsF/5XTxmtkiRDksn2o9Rjbh5CWV6dy
 u+4=
X-IronPort-AV: E=Sophos;i="5.72,391,1580745600"; 
   d="scan'208";a="136914972"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2020 23:34:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg8pk10OkcPnR3DA3uBMa8ZXr375Z3GHa24QhhLoEmQLS/OiU4jZUd6rLVgnqxQZy0zIMme1up0h9ZMlQ3UcRNanlLqgM28rItkod4+DArxMPQ1YmC24wGkb8hr7n4+7RutGqTZQRti/+/OyY4rJfo/tZFJ6m0YIkpJmSLlakmqKGliUmcvIIr78piH2u42DiBVPclRx185oL4ZAUaa0QvwnvYoC01+qT7g8t9FMZrHUQm2Xy0+z8IfF8e3vhiETOpw1+x/vvdquhPrH2SkvWHXX5tRI2QNc3OpBl+zMS9CnNOaNsxntzgXFzh8ZA8vZPMN9q3946WLPzSNNTGhNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/82S3h02SC6HotDfgjcYyyVEkeXFpBSkPbP4MDpsx3A=;
 b=bRxezJIOnZtJvlNHAwVkdPKhuGbRrICWRTL8BD4nlBqQ9tNUQhrRT3H+bJ6phfR8gK7AsHAlKFv04TcpOhPex0smPeNhju/wJ1pdmXOX1BH7BhAVuNKxzqC4nrktZ3iVHYCTk+hoSv19rsCM+lXYe3QGaiMBUtQP38w1aFEy99mOtgxJlm4X/wr95XYKzDoeAOUxsi1BH8ZfSXoArfykCm/zKlD4e1YTVjxV8MXset1BR/CsOkP1pU40bmdjz9dAr3/B8rzpO22ZBCZiAyvkjNlDP3/P0W4YxsdYzzUrLA3ebxS4AxO90lxokExpUiCRWD11VXwHCdY6vc0lP//NEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/82S3h02SC6HotDfgjcYyyVEkeXFpBSkPbP4MDpsx3A=;
 b=ZDhKcPNV0K/y2koHo42aGc3+G3ey7qr3cIjvATcKaJSKlO0BJKBygtJX1ks/OW4jJnS71VXQE3Lgy2lhddFHvL3mwWqZ4sfJxvpvyHAuAUnPEf5ghnypcB6GCLR3H95MNUiDE94MmJGMEOygVE6/Mku1m14uGbWQs25Vm2kBmgI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3613.namprd04.prod.outlook.com
 (2603:10b6:803:46::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 15:34:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 15:34:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: fix setting last_trans for reloc roots
Thread-Topic: [PATCH] btrfs: fix setting last_trans for reloc roots
Thread-Index: AQHWD062t2QIRpkJZ0CXc0QD/zJaAg==
Date:   Thu, 16 Apr 2020 15:34:30 +0000
Message-ID: <SN4PR0401MB3598C2A93849EB046D06AAC59BD80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200410154248.2646406-1-josef@toxicpanda.com>
 <SN4PR0401MB35985AA68F3ECB8C8AAE9D3F9BD80@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 320a1b45-5931-46c0-a78b-08d7e21ba84c
x-ms-traffictypediagnostic: SN4PR0401MB3613:
x-microsoft-antispam-prvs: <SN4PR0401MB361381191D9A2AA8FF14E21B9BD80@SN4PR0401MB3613.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(52536014)(9686003)(66446008)(7696005)(186003)(478600001)(66556008)(5660300002)(4744005)(6506007)(53546011)(2906002)(316002)(64756008)(55016002)(26005)(86362001)(71200400001)(76116006)(66946007)(8676002)(91956017)(110136005)(66476007)(8936002)(81156014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBLR5X90aLBoLt7x7Rc2USgEdoyytrHffZu7AMYi2bQdG/RtWPey1gdFgnuFcgmBBekpXFry0nXHCEU6rDi8UvQLndeawVb2YcEidNSeZORdBHonrVX55CaeJQLYAoN94F7xi6b7+tcrJQrYU7p65J/UJoNWuF7QsHSDF/2UDecBsRM/9SVw2cg/EDO/OYzLeyCPVoXto6REGdgbZMCy64sKQTwaXCom1R1cCBNumzz/cYfzykIEiSCuiaWLfbbw34TylPJwh34HDdXjhyHUjU/oL1di0ZeoHvo7ojOBlbExOXHc6BH7dWAQoHHjHZoDOVIDs/lN1GyH234lt+dRgFgI0VI5O7Wy6/v7QujRqYaZ9tsDYwTbO3Y4rWNlbkgttQvBQbrh0ccfPTgQ8XermVWoNFwy4qyPY90H885FG0iaoz4i2jU8g7GjwpJMRUbv
x-ms-exchange-antispam-messagedata: svE0rtmQvJXcXRnI7WN2K2ImXlm0Ke1FfRKBcyppIYthX2GbhdlisAhbBh8fCPLO370tcsNPGr0maBVumIovgzKgl4rbB2+WdkYSc1oGeeZHlRO4RTPaM+qAUKfZfLEy5pzk76JWwmNO2rJ1CvoFuQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320a1b45-5931-46c0-a78b-08d7e21ba84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 15:34:30.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bN0UYjU05yV1uikSE5rgGL16e+cvQeGRqHF4D+vOfHSDbKU29cX7kg8S9S2RJu9MdHWwuCH6KUkBCuXYsFp+aWAy1lSMjfU25DGhTcx9/3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3613
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/04/2020 14:38, Johannes Thumshirn wrote:=0A=
> This fixes a kmemleak complaint from btrfs/074, complete re-run of=0A=
> xfstests is pending, but one down again.=0A=
> =0A=
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
=0A=
I'll take that back, I still see a leak of 'cur_trans' allocated in =0A=
join_transaction() for btrfs/074 on a full xfstests run. The same leak =0A=
is reported for btrfs/072 and generic/127.=0A=

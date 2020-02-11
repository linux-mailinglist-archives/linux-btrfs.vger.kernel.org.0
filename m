Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A415989F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 19:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgBKSa2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 13:30:28 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41196 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBKSa2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 13:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581445827; x=1612981827;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=q3dhrWsNqbXI0jtQUuiJri0lnk6ngbRsrZBa9nqEs4U=;
  b=drSncJvgRQLwv7UvFh5Fc11mKNuSsyzkoFEKhR2zrHgvDNmm1AesDDz2
   RcuLy9/LGiVlDpSiUwuBbv0yCABECaf8Q/IQmEzRTD05oUlD3cJ0cnR5y
   ytYaUIxhUNQtkg8HDCNO5hT5c5RVSzt7rnTNfdW1uyd2YHxcqW74OdOPW
   rC+2JrCLpP99tlfmns7ekYQbaX5VVOhI2osMDbpk9PAacppS6PlVjCpqk
   3lZmZvr1NoICiCeQUWc4XMFWqdC55tpOcZxlztCZ+iA9CQYRfOpv7sI14
   OnlQTEKJj0SqPrHxR9xZ5SVSm+nO43YoNwFDQgee4gz9uxaUm1ULldL+D
   A==;
IronPort-SDR: hm1u7sc6byHSItg6ukH90MQ+dgwkneZe+vlhelXxkRsXXBrroLUvc7ca+TtnWK8nKwsSqTbBj+
 /zo7wW/hpHuTDYKtZ1Z2b8G9gLDQ6y9Tt5UWwY5V2VZnZ269hjP2ib1X5nMFczHuTLfoUpQW/V
 fZLRoPjvvR6L3GS/yQXFf5oWGSjdbt2KTFB3VCh/ZgNOwYD7c0xGxHsGfh//9k4CyZV7JU1r8J
 H5meCTYpbVeTcXQeLFVi6ZvOMbSYgrV9TPPQTYlhGDia4AlIjqM3bmdVkXvjqiM9dJhppdx5ZD
 dFI=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="129604599"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 02:30:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdPax3fVK2FO9phCCfS7VxeeEN8hiKP/zzGDNKx7z3H55l+xhCpM6yjRsLHIRECylMP7u+4Buya0zljAs92Z7S/1sIdIiyZV8PEHVhUGTLRw43K7gbJPA7IxL7giHSQZjdprsbVF8zElCQYQVtbWxEMH9/Whq86cpDx6VbfiMhM4stUlBfsmCyi6VqfKC1sB9CNZ9qkX3++TolLnOvmP1u9TNs6HDkUxhckRgenm+LFjktp+Y9ba14mm11Bs29R+D9xmoIlAYBK3/oZWSGQZxA6omE+oPb30G35fdiTSc4qEIcdEOqU16apoLAv5e7VGqMcq3vzXs9OaL/d2FiV8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3dhrWsNqbXI0jtQUuiJri0lnk6ngbRsrZBa9nqEs4U=;
 b=hkWP4bAKZcYZ3g9kTdZdIlKuo+yg/Cf2efFuUiPAWFA/dVTV7OgwdK0nlADGveAC/dxO6HTm9FGfIeoUYFSlMr74VHAUPf14y33q4JU1OHFDd1gga80rnEzdVLpveECWvgUNGTznmdAyzS2xA1+f7l6Ji2BeKxpCT+zICicP+8gfvQbKQQahq66zzSvr+zCoWzNncME+JR28VE33MKFt6AYSBP6W3tPG5afHRAYDKiEEOyWkn+cBuCZUZg1dAWZT9OTn9jU80kvkSCf+kAWzCAdmdkIRI1F3oI5uEo59hnNypEzB5RrfVzhfXFVS3B+O7izCHyZo9ZLxkYSwu8/uLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3dhrWsNqbXI0jtQUuiJri0lnk6ngbRsrZBa9nqEs4U=;
 b=QmKStSW1HZ17cUgBL3a3IWCDUKGqpe0ku/ZXBjSvacu2AvewkXhJvp5iarcFFWKG1PUxL20PZkErNSmFgdYWN6q7+1CGTOQQpL3pvL5j14VatPDf7f+NN6asdrZ9H5yWYMY4NhFfiFmKB3T45UMuA9rCyL0kCNjgZkCu7OEShQw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3533.namprd04.prod.outlook.com (10.167.129.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 18:30:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 18:30:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "wqu@suse.com" <wqu@suse.com>
Subject: Re: [PATCH] btrfs: ioctl: resize: Only how new size if size changed
Thread-Topic: [PATCH] btrfs: ioctl: resize: Only how new size if size changed
Thread-Index: AQHV4PYgafuD5anozkCOW/4FfegRkg==
Date:   Tue, 11 Feb 2020 18:30:25 +0000
Message-ID: <SN4PR0401MB359809950656323F9F4A76709B180@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200211135526.22793-1-marcos@mpdesouza.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ee3ead1-d5b4-4704-37b4-08d7af207692
x-ms-traffictypediagnostic: SN4PR0401MB3533:
x-microsoft-antispam-prvs: <SN4PR0401MB35336119D1390091502D0A0C9B180@SN4PR0401MB3533.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(316002)(110136005)(8936002)(9686003)(478600001)(71200400001)(66476007)(66946007)(64756008)(66446008)(55016002)(66556008)(2906002)(86362001)(76116006)(81156014)(81166006)(91956017)(8676002)(6506007)(52536014)(33656002)(7696005)(558084003)(5660300002)(26005)(4270600006)(19618925003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3533;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: folc0qMk/wDIZxVA/OS2/xm4wMZKCNvnn/Rl4eXYoTdHlDX+8jLktF3oz0gu/2ySC4nJV8QrEdTnsoZp3JNb3Wv6GbwviOChC4QP9XyR8TV97AGrU4YpD6rpOINcz7X9SniwZ1eetKSPaMokulstoy1d6++cR6ErZigKtPUgWwtiSvhiIgP2yeDgEc8yBwtY15riK64EhDwmY2r1GV37tgNUsrd2w1r8qDWptGK7cSL7oCSqLSD7alBISQI1BImzDPrT+nFFTdv8CCH5yFcyDn8EE8HA9G0EdPEBsmytoXV+Qc7rL9D3HPUsRzW5vdavpCl/OZ8Nr/1Lf3k/8XUC7SmJHmpTMfpV8tk+yL9dKHsP3Jj4dp+S9OSaY7Xaq2MGdq4Ky/3OBBflrXtLMw7jB1GSNhTVeyzB5I2KXS4x3fYn56YitoncgUb2t4nV4sGF
x-ms-exchange-antispam-messagedata: heVhJTiMWTO3HJNWQJQ7Q4UfuU3jxUR621NG0CUjL1GHY76JhOK530rhiSVT9sqmgFSg+fQ/QvMu6LeeZMnZ/JL50ZevEgtx32U8ANjpjQz/ycLocHE34ukRenjHxkJdaJ5WVHMVn10caYXQ6+CI4w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee3ead1-d5b4-4704-37b4-08d7af207692
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 18:30:25.8363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REqFL5uSt0GWDJNmp9aplQNweF0nb4VhbAfK+Nr4uhTwwDMuwPDtoxTv+0kfT8uDRRMhJdzABiUtAbQyYhWhvPPZFEpB8Qil73KO878UgWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3533
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshnirn@wdc.com>=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FD6165A65
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 10:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgBTJpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 04:45:41 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10561 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgBTJpl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 04:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582191940; x=1613727940;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ah9bRJHsEasKnDbfZD82sXQVOf2m/znCXMpYGtk7PnS3Rht6Qmpm2jyO
   mp47KPAKGXw85iP//c7mHvBOzF7Cu+jkovFDVZ2CiShL2OXv4dg16BkOU
   QUSAMAfVi2NXo1vS75ycrHVWAAvIwQOlQQumgq79rQ6k7VfqWWuc3qsAW
   BC7HB4g6rSCzI0LnKK9yX9W3xmD7Nt8lNT8zarNBal5HCAwLZFfvIpaQ1
   akwkDLdVIG0Ic5W+/0B0SOTWMgu+K3MpzDf4QL/jodwSNGW4c8Xs7t07i
   mZyHuE4o0lQXwnNVPIt9L0PAOKKzT42L0f4oaJrPaQOoU+rCmw4TkwBYC
   A==;
IronPort-SDR: aQxgHoOr1/HR27ue+YipGXJiiAFXxGBLjfthUgLOBKYWpLIzUnjPTsZKE71TQ/vdUcBS+b9O8T
 gK62Qpwl0Y71Q18KqeGKMi/5Kz24W47VrxgLSqsthOstOjxWi5r8EAagKGQjG9HxpIS8pJbnnL
 iOt9CoGU3F63zoC6aG2qCcmCuQ2iCgIepJmw6fEpsT9EBZ+kER4TOcBw8fqOpnhCzLPL2KRKXJ
 7VS+u3vAPTs5nDR9dj272HElkgPf+Ap1KPR/pkxhA2mzgS0UOIKS7ASgAQvCfLlB8cS367uuWm
 6Zw=
X-IronPort-AV: E=Sophos;i="5.70,463,1574092800"; 
   d="scan'208";a="130255013"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 17:45:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4edoES69OFQr0iNVm8N8F3NUD7hY6S8P/ItRwrHlgjabXFYKPbfRrXcYp90c193guW5DMD4pIFFjHVsq9RCfcMHAqsc2MKZ89wrfzGYV1NGctb6abJ/rwibs/dBHstFjyB+dsli8av/ArzekuS8YNzCPqrUrCs7fUAc3jvDY5DN2JmMHdUvtVZw7qPUU2EiRj+mUmNJUtlMx2BxVSV2lWnNijOy6F3sQAaFmg4H7sji07KelHJnn8oz+cCNefOkciGRWChy8GAwicH44y6/SArjH58qFQY3+qf5sQMFXm7JENbAPTzXHTihlEvJuGyR1rQWf2IavD44ItV3xu1vMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=emn8OEjXng25XMAxI0N/GBrl5wxdnsDOwr5lTjHeg3TqlDxv5pxOv5yN6oh1vNXpiP5rDGSPiB+9g4NWl8MLXNuIG8rcuS+3wtfM6/1enNMwdWUiMC2jH5UpHLqI1g2FsALu0Tlrhq51fetdjbA8fU+Ms0gAWwPWiqgixrXdH4xvFgIqd86gdeGM7OqYKRSMB1WuTFwJWVT2KyDvqpAgXkpCokILdgqsgZILg6tHBoiT+zSPD+WW4IfqGZ/63v7utuUvStwxC6Up4dqJeCwHm6DzNo3Y0yYzaF+IAQEBU1dyQRlwQ50rOOlPoYcTGtSfyyy7LsjkSYooa2S+Te4/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PJqOR+sMixiPnsXSwiW7Z5xRNo2FeIEFc5JZkFkRktoDNWVk3umPidaPkHMwtPsvHCKl7bNVi0Q8Hs3zRXIzuU/qVHmL5My2L1zKsR+dnTFIvA/JTiQNNNLHTfhpGpi8CIsO45wjvV+uO6MlKgMacrrnfOtAP0wEgZlAB+/mI/c=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3712.namprd04.prod.outlook.com (10.167.140.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.34; Thu, 20 Feb 2020 09:45:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 09:45:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: Call btrfs_check_uuid_tree_entry directly in
 btrfs_uuid_tree_iterate
Thread-Topic: [PATCH 1/3] btrfs: Call btrfs_check_uuid_tree_entry directly in
 btrfs_uuid_tree_iterate
Thread-Index: AQHV5muUyYU11YjoLEmhTJTkiGSY0Q==
Date:   Thu, 20 Feb 2020 09:45:24 +0000
Message-ID: <SN4PR0401MB35981D3484130491E844846D9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200218145609.13427-1-nborisov@suse.com>
 <20200218145609.13427-2-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08e5033f-9178-4211-4f53-08d7b5e99c4f
x-ms-traffictypediagnostic: SN4PR0401MB3712:
x-microsoft-antispam-prvs: <SN4PR0401MB37128C1F1839637D7EFCE2969B130@SN4PR0401MB3712.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(110136005)(316002)(7696005)(558084003)(71200400001)(81166006)(86362001)(81156014)(9686003)(8936002)(8676002)(55016002)(478600001)(6506007)(5660300002)(91956017)(76116006)(52536014)(66556008)(64756008)(66446008)(4270600006)(66946007)(26005)(66476007)(2906002)(186003)(33656002)(19618925003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3712;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BD8JlcRGyd2u5FD5+Vx7WfVEXothBT6WXTwHWZAg5Yzuf0UsSn19w/ZLmlE7eZ0OGOjyiobMm8LcffBREYsytLWPcvdeI4qaKOm5Ewr62gd1+yTWsbZrvAcG9zryp/3msX9ca3IVDY1XoocavB/g7JQZPeIGIG0TqNa7jqkHFUyKP/3X0nG8hI9jWGUqB1rq9EUyG9WxCd00v4VEtQ9JR/Zm8S0hl3o3KVfD7n9h9D2PswAbPjesXbBwNY6Y1R2ejW2QEyMa+sx4baYFpv5MdvtXfvyj2FFgWoruGOkSOT0SlhhLNALjws/j/WcJQLVcDpJMoMX06oakYQdP9lpcXWbXd7HOuCIdJGiRN6u0t9B9GbmJFFFU0ddc+JT6PWtQYdpKhDNzKLB0C5PWULId8N2wghiwboP3lzLWClh+16NfWZlGzqRrVPgUgg7Sf1f4
x-ms-exchange-antispam-messagedata: uzZyb5Z03JZ9KCBwfXj45G+6vC8f88lkryBwZCQAwejLk1lMyWFJorve850T2QpxrOf3nvmbmuiv2tyo1Fys+/G4bhAqeaGh/FOWEkonJCnyfL8mXYwhF/1rDNhZeZmFCxVYQKURh2qwFLR8BbESKQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e5033f-9178-4211-4f53-08d7b5e99c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 09:45:24.9456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAjhuoGOg3w7RQkXts7fx92h2qcGT8lYIEGiiSzlbfseMUiXs+sINuWGkK1vBuRFyjfXYgTo6kqsx5xWI39dhSr4XY2X4zepguwmzmtNWFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3712
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

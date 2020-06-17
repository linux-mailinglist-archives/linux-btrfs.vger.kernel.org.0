Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7DF1FC874
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 10:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgFQIVg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 04:21:36 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49941 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFQIVe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 04:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592382114; x=1623918114;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=V+LEi0rLfv8kGxCKdzar+GfJGVqI6YqCKtxFhXjNabyhObawxtIObn1t
   ls9hcXxK+NH0XQCAXfginzz5ud3Hxpq36Zv1KsRr/ygkIKsMtW61RHI6G
   cGBxEqIi8+xC5vAPMcQKy+yngW7Uj5C1fHDV96AbEfSMrmJr/Tb5Ta0W5
   TH0winQbv1ubXFPtzut/UQWWcPf1hOYyO2QOKLSPE0JogILMRB+/Le4by
   kt//QT1r7VQims0brYlinsNPOM2u1H14Kv8tFwteYvk4fLs7ZGCqhlREa
   IXHa2pIxhRSxsFNT5f7WJaoZjmaE4t+OiyZsnc5QTwVT0HY2gnl+jwPoc
   w==;
IronPort-SDR: 2BwFf/agXTUEZblqyVb4zvdzyQBpLRnwkHK2rcYQIPIXtKmvMAKfNw8eKnjLAPlDFQ3sx2Tqxr
 urqlUGuhz1GmLDnRjMPODVRffK4cvJQ+IP36GSzNZKZ+a52DwgGHojF6x+aUub7Q9HNR+yoztk
 e8PY7fGq1PD8cqpllSdjTRtKeTyoEFNMF/n48+YXslZPvaXSvQPpPs3unrWTGGLCZwt2MfpQt6
 VyiLB+Nq/txmzHurWAg4z9CoGa+0+BCX185e09Qg3tZjNNXjiCjiM81n63gFjFw7pp6xsuYVnd
 DOs=
X-IronPort-AV: E=Sophos;i="5.73,522,1583164800"; 
   d="scan'208";a="243156422"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 16:21:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSLGTDORbEwCcexsFPNVU4kMCnJnAA7+2kVl9Gt4qp+ivJQs2ljaugm0ZIT+Q4wOZiSbyYs3QZl/LVjzJuuV5o7hUbpMkNEahPDSCRcw82AjXKPX5xxNpGTl6U9oAKR5j/lk4C9cA+0a2yzMLxnozc8E5f+fJe/gaCc6WD16wQI1WmmRYr7Wr4L8L4rk+iaPWG8Z/CbmUT1BLM7vTY5+EwtLRrO9elpUXWwYYkh95O44I3CbnBfqCBXsDYaNVmmEqAovpp1dSuUVqWLfm7ipZ6Oq40uh1uu9TzQxJKvpdXKPcnkOqI3yQarbWbQOYMmlx1rKuEWN4mzCXHT5XvmM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=RCvQr74cwF1rnJPV7HLnVKPLHcjvjFYUtij5Lf2msCpM0Yt3dckWbiBA2wBbpKQ6MBu9t8eSAFvsz2k7b/s3cSFiHmfj3umRemG+I44kfm+H+ula/JB/hUME9eFXMYwX9BfyNQ19zKO59ruly9AwR1h9GSuAU+JOfIRR6aItxpyJgvfmVbCBfvt5TMab9CX1Nhsw7WyqkLiJxn7WddRfmOOZ77NYOFcjWhBwKdH59sPazZtu45PvDr3m/h9rb6PYbAxuIl/CKGCeBvAH4XGX8oGAZhe0i2gmCVFEx3vI6lnkQHC+bgqnK6AnDCBqyq8fyd81E4Y+1xtt9rncTJScjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=JHwffndtkNnHvaFpRg4Q5Wx6zplyGk8Gqr5JjrVYvvqkS0i3abfavWlhTu75MeAqOm/DZdbX3cqWGVmIdza0Jxqu2mHm/Xn1JaVHdxQtOso1Rk7rzOjnNczwou3w/bGatkAdtxCX0jIFeTl7/THYs9XZpZLcyixUBudGvZ4DUPk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4784.namprd04.prod.outlook.com
 (2603:10b6:805:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Wed, 17 Jun
 2020 08:21:32 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 08:21:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] btrfs: Use fallthrough;
Thread-Topic: [PATCH] btrfs: Use fallthrough;
Thread-Index: AQHWRBMV+2H4mfjp0USP4HPwzKI2Lw==
Date:   Wed, 17 Jun 2020 08:21:31 +0000
Message-ID: <SN4PR0401MB359823D09DD6F57A238EEBE09B9A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200616185429.1648-1-marcos@mpdesouza.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mpdesouza.com; dkim=none (message not signed)
 header.d=none;mpdesouza.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2.247.255.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b59a622-d3ff-4a44-6d9c-08d812977120
x-ms-traffictypediagnostic: SN6PR04MB4784:
x-microsoft-antispam-prvs: <SN6PR04MB47841605C0E019B3E5E6C7E09B9A0@SN6PR04MB4784.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bdrujmeZ60D4djbUTUjYyONxwNVxZjZFRXZvJwywIeDsAiPRqQ660SRcASFiyLNy570yhUNJ3KpiX7tv9/B8H+5VxHVc0APyc4L9+qejQzgTG9PBWqCBCwHxcTIWXJXPv21FJFRKfFp43GZiIDLzbGC0jw5N4DswzQzei4BFS/N47dzIsUhp9kK/kgsUAfG+2lTlw4P75svCgjOGzSC5P2ZLMEuoDPdl8dOpWZhmIlhbByzvE5jhd+LBW/P/p/o7z/jvXMvZQ6np9Z70wYbfW+sHoPXkzTQ6zEWohVJlZQa2U7QSnKl+ItzPOVGVL/TNbOTaGP5rOTa+Fi11vDtupQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:pt;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(6506007)(5660300002)(186003)(55016002)(7696005)(8936002)(4326008)(9686003)(4270600006)(8676002)(19618925003)(110136005)(66946007)(71200400001)(66446008)(64756008)(478600001)(316002)(86362001)(76116006)(33656002)(66476007)(66556008)(52536014)(26005)(91956017)(558084003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: A3MeZEFjwTGQ82yzoEqQuA/yZScXnoJ7T7jfhdiaE7xRN72L9U8tK7ntaSceL150bD++vP2DhAcqq9xuV9Aof/z4mubdTHd9mKx8hLU9aNzz2GMUArjHAhpFRXytlqW9oGiRwIRzaZJPHHNlK6ceFZF1qAr71XoM2ILtvEaj9ONDPoJm+9LgCb3Nue1GRA+YQQ45M7JQM0IsYnSmsrx0B9y0PzjxXRImi7HIcumT5IiVaCdU/5FQROCSJHe2Wo5FT/Cnj18F5ujWVzxaxJUPGbsdi1jDuQsX91qt9Ge8Lp79WYCOQg28gNEnAXKZU/KiYNhGcV6m9vxJg0BJhbzoRlLUihEItT/ai1+XgRw1YeHvITrKo584FfTY0dF+mb2ceBHGr6cPV8uVxDuIiv1VM4h18SjSTH0FC3E8zRLrFoiA6sdnyn7d9IHcgl1V4ml0DkXFDfoOzK4yujXiFvEMebZnt5BXyYTOq7t56uGWjNs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b59a622-d3ff-4a44-6d9c-08d812977120
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 08:21:31.8608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2R6jLKA1fYZa45h3Cl9uD43CFIKViGugzIX3oiKOyAx1kl1SDi/TRSYVWVOV+3v3pyU/27zJuGJUnCHSSq/tUtJ3WYE3ikfpagHgrJPSck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4784
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

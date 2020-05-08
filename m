Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C971CB18B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 16:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgEHORi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 10:17:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:42686 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHORh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 10:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588947457; x=1620483457;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=IY4G55gr0w5ADywJ4ElVynIPJ1tjSF3sskm7TVTxz1jAKc7wWv7qt7BI
   ag8+6X35p/UoGEhk8avzHmGzJwx+YBvSjegk+50dzsZUfHLzw9XzZeOq7
   +OOYQJ9RJa1gbSNXcEvLhj/uzyBf1/m6Yqsv1HGPZCiMOlhcndfIR28NY
   aqpE7auj4AhRmQ1BIZQ74yM3dUbm1Z+iG8ZLKS8SxPGG2ZZNMP/UwsAzg
   ZE5WixFwdgR1I1CbZ6o06vSJKccx2w9kOds0eq4ewU8R4Ucit6+CpLweU
   C+TzB0H/fWgL7bDkWRejC5iKRLju5lNNV99y+YUmHhVk4wDSSK/NY73Qm
   A==;
IronPort-SDR: YiKPwrH/k8DzPnzZjFlwLotHkd/O9CoIAtJGVCZ1kJbs9Y6ZCsObEYGNdGdo0GiMalF7azm9dw
 JCzNpuhV/939BSNr0SdMjaxA9MduCg9/OOx8+6f8bSvvix/o43bj371DE6XqCwBBlydiZHP7aF
 gwCINt6FAfJY214aQSVUJoUIw/1+yGZMuuqNk9F6krWqqcr0rHndAoZ5Krmxbs2SRYdJlb5YAG
 RigtdgV8pYLiagFH9n7bvvBcGJaRX1OZ8FK6FytSCh2iC2q+45aTn0wcv/Y1QUvgjhjBAhS2cX
 +Pc=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="141577677"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 22:17:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWQ0J3crxKajzV4u2C4EQybGL3gv7U3sLTL9dh6yxUvZwer1kepx+U5ZnHJHG1XXOCcJIzsnyzVR2L4lbiRG5YZvsrDN3lnmrye9kiG77ghPmjb9tIeZWJt64/qFDxE0CZWLxQ7/3lnqBuXpdADizNpEW17zZguAzlMTu2pxsnMxo3tSuPDqiLQkqHSKbVtyyYEbU/gNER+BLsxvX42FcOk4seK8y98gTuRqzZqSC5c70lrwv82KZuQ9YhrIOIhnDsCnS9W6gnRFNLsMrKeuiqkGz5CSE1y6FbwIIFyUelfMN48s+qKxwQxtfY7dkMmreU6Rwrt+n/lw0bqb5/pyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GVzj1YE7WSSJ2OVlYDKIA/6RnfFY+z7wPqz/3Lp6aXFWQOS5wRpLIKEzranIxqP5bPAIbFf412p7VhInQonNu82fOlzEI2ejjFj0CxZNQ0bTLTvfuEbkFEiaNSnkMFl+XfAmrGtspKxUf+vRAgIZQnZ1gLx7vss3CMvCLb7UfLBDmw9Lbpk4U/22J6Z0eaae18506kWueP58ief4U9SXx0Aax8io7z0l7Qn3MGvf8nZ6Fw50pAqP5v32SQV4IK/KIwPevOqfhCEde5brLE1E6gWv0RI8Hdxvv6E1gTyrCMnUh4hfEKsUlYLc8lxeqwhwbh3THglVUz08w0ZZKSG7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=zPINiCTF4rg9M5ygL7dMtZv85Nn0rBfqRZMdIhMqIL3E9ucptbkRHAwYYCUV3aXmiTmW3h+mTA7aw5CVwA2xL/GRVHFJ3RrMo8owDjJvuhMQ0qQ2UiYlFHKwq0cf9NYIQ1QFYU9d4q8/7rGEvaJDq5AOS/6Eiva/ccZdzzaSThU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3662.namprd04.prod.outlook.com
 (2603:10b6:803:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Fri, 8 May
 2020 14:17:36 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 14:17:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 15/19] btrfs: optimize split page read in btrfs_get_##bits
Thread-Topic: [PATCH 15/19] btrfs: optimize split page read in
 btrfs_get_##bits
Thread-Index: AQHWJK0JSQSrqWv3AEquBjVP5m+txw==
Date:   Fri, 8 May 2020 14:17:34 +0000
Message-ID: <SN4PR0401MB3598C2A33DA1AF164EA968679BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <b051dbd526f4298d8f8eb04cb30556def1ad00d0.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cf69819-ac4b-425a-01f9-08d7f35a8dde
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB366272AC646DD1933E5106FB9BA20@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mC/cwjXIj6vu5sEb0DpQolCvUW9bfDP0Q7wMKMRfFcjRbSnzicNqinDPxRZJ7d5fRwAc4NLzfwA3kahzYnEnK/nohr7+EcBGIkDuYAwfqr99GDirz7M7+E5SNNQmtYcRdzm2FkuBoQ9Uv4uiNENL7wP4oapZLPFbMPWZhrx5WOcSFamIq7yc17oGR98ldmBkB/8DQ+e5bEaBTkWc7iT1F5Ipp7jlAgX24toj3V85MhpXSF9esQLpJ3AIbnAJ+F3vkHnJsQI2smkp8yR6JYDUB/Z+szlmwFP7GdSH0HzS0bJ2nky4GtwwsgdY2dqa/9/Ze3WrfTOmmDi1fWKzxU3N588pR/9G/b12vZQ03sqtnp97j6cMqAA7vb9cJ9OWlr6g5rSJSfJLEgDQnbkf6vA4RXlxfYFNKJxzVvfx65PTNI5F4W2iDb6IQUY2yiS4N3e66yODbO3NBL+xlWcKXg+gqjd2tudR7fwRvXWwDgVK4xFuibq5NsSSMHY2UgAQwomIBcdye3KH2NcLrAefcNUKyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(33430700001)(6506007)(19618925003)(91956017)(52536014)(7696005)(5660300002)(71200400001)(55016002)(76116006)(86362001)(66446008)(64756008)(33656002)(9686003)(8676002)(66946007)(2906002)(8936002)(66476007)(66556008)(316002)(558084003)(110136005)(83310400001)(83320400001)(83290400001)(186003)(83280400001)(26005)(478600001)(4270600006)(83300400001)(33440700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ey4isoFH9W+6FgBicNe2gl9NtVI2ccp6HnXN9rpFjOwaD1AFbv0K07ZmtYUqHsEj2eYxSUoG61/gB9UIPWpYHQ8LSEzP2lH3dNXEDAIE0Sb5BT37UIG37GX84ImPSHQ2/nm7h02ewX4kJmgMQEBlIKyB6etEG91xBiK79sGRDJEpH7PCd585NU/55H/WyABIN3qsNNaskNPbn5Ls98iwDrDqKBWeEAPDV5CIPW4/1np6ZjweYnu7P1QSgl1GjcMRzGLxy+/16RiOC/cqNZQZTZKTxQP/0uAw0Gv4nugSy442BUo33BXNs4oINzsJpZ16UwJWadBr+5rIFmXFFVIczmAw0hN07iddiI+1Y5NkQF6GJjo6RGpDhMnia7POJS7HGm16wEAypz8pjZX/HK9tzqyzVnBiRQgCCwCksxirXnTc8ecN0UwA6fyeRsV/gGAUKIFoXf6DFFL983F91A68POocrK/Ns1hRiGymPCRJ88Dz1gBPIkz//rP3A1JvCqz+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf69819-ac4b-425a-01f9-08d7f35a8dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 14:17:34.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET91T8BBVnR8JnZT0uZt3IN9fT2P7e0ZOQ3ptACpjIwAPNt/3G8vTQdwtr7nnd0xtcdpO9eQsQREAMoAqB7FufMH5WCODqU12yM8qidhzco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

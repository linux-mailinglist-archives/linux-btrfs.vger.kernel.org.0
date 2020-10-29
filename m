Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C638629EEAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgJ2Opy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:45:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33055 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgJ2Opx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603982772; x=1635518772;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=I7sltJsxdEaZtFrw536KmhZ7Tv+I6Ch33EWqfBdCkc4=;
  b=MJEoWnl+3n+m5Fogga8AAyukeKU92Bei8FN+u1ZyQ7Aq2ykL78oTnL+g
   m+YkApyGbiU7QK/afeQ8GO1QuPUK3ITKcqUWUDl6bNPZTzb31bVRc7nFq
   cYB7t9JxM1vxQf6sX8r6HrwPcLm8u1XMSFR8Tufim01fXH6gOt94bHCT8
   JycKa6a4wYgB6a0+fmnDs8iAJhxPL+0SpgmydAWI9To9kvgT0OmwYQYqD
   5viMzE6lN/IjfPDQtQRv3q5hEG5HMr2uZ6RaSLHeApHzl9TNMvOo+AFy/
   pYDX91/GB7qkIzrlabum1IlaxBp+WMx0I6Q9XlEUHcHW0VkyGyzvVum1K
   g==;
IronPort-SDR: +GaNfBsfERRNP8gPEWtVAuFHJV8WEXoTN/kAklDR/chPTB0cbGuUHPOyaRBMOrNFm9op3vcB4U
 66l2WeyRFZbo8pyX/KKsgE7AKEMJtdfjVYPD2O45elabxpQBNSSTapW3V/SiLirz8c07XA25jX
 TRyV9GsYRCW5WeVxwE7PV52kyNmcs1FeywhEVswqzCmQte3IRUbPOdEu0q/pPudTRGO2bYhQp3
 5ZXAGvx7iorUz4Ka3ftqXFpe5sllQ13Gv/OcjIzJW3EGiWF+lpWe+t4uxoY2ga4+DJKnxrjPoY
 H3Q=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; 
   d="scan'208";a="254778161"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:46:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxbss66Uks5pquGbM0YAF1DH3EvFQRwIfALG1GLnWhQtjmXZaNRFGFlDptyEqkTlFuKFUiQWSQHXfAaLB7BgsUOMH5lKDKjSACao+++1GMtKoEUrQD1i/1Y1VNIbla3mprW4YPAFEm9wiokwYA8xdhV4h7w89DwX9uxJCrnRlToDHAdH7URaqBsTp43ThBWwzK96Rs9E/OtyeRFy/WM3JQMkAJQEhXP9/5h7VyPGQJEKX36CIfdd4Eam4ufn3YvaHox1qVJj57xVQc623wSNELv2fBeHZFklgYKtqDUy/BPyRal3sMLY/jM+Jg/dcjuOqcjOsgg0OG9SdCmc7dE57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7sltJsxdEaZtFrw536KmhZ7Tv+I6Ch33EWqfBdCkc4=;
 b=Bj8xMXXDHTbLYNrC/Q0XQmm1vBaUCFbYOuermBT7gQ86QKMMObAInBj1lZgnR1ULQGCEDsznHuZDobwEbT3rrVKFxiQAgMdU5QjziXc7v0p2zjDv9HAKMCYoEHLTiSOw6BSL4pRZEyGQhSKTzPNQZoWqpYsSQiYPMzueiX7twxBbmCRH8IVex6r+Eds/DaxZ7vyE/xIy1lASiVwYlDeoDJAdrJP1Idz0Ij239MGKyABlFhc7CBOjm/vH5fJS/e79PFR7YiNr4T6RLICWlU80mzPLlOcgkKL6wKfWbAC/yfzV7AabmfbH8XYW8X4Uk1oXvZZfvNva6998Seps5yKQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7sltJsxdEaZtFrw536KmhZ7Tv+I6Ch33EWqfBdCkc4=;
 b=wlW+nEY/QEv4UHkuMj4rma5nzrDwCV+sBaF74kUWcZNT6nJkBBtepDOKfqzkbETWhVzxfZoRbuE/s971Yb+v+9JRui3rk7UiIqnttYiQIb6IdcrcdVR/c2YF7LeJ7I8lKGfp9XYeCo+VnABFr4pLnVjZf3OhEHK/WDgVaKxlSDU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 29 Oct
 2020 14:45:51 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 14:45:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/10] btrfs: scrub: remove local copy of csum_size from
 context
Thread-Topic: [PATCH 10/10] btrfs: scrub: remove local copy of csum_size from
 context
Thread-Index: AQHWrf/wESuVFAsVj0qQPYRxNLhoDw==
Date:   Thu, 29 Oct 2020 14:45:50 +0000
Message-ID: <SN4PR0401MB359801870FB4E1381BE436DB9B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1603981452.git.dsterba@suse.com>
 <7a311427bcb433f5ae9f84f4e07d3653e1518b1f.1603981453.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49fa1099-538b-4768-8be2-08d87c1954cb
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB3677947E91F76C4699AAB8679B140@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+3AObUMvwgCzM+1mfr4RFp3FluE12GrJ2ao44Iet4ll1VWluEn3BXagLgx3vOVixvZkWulOxmpE3pb5B8fB1FTi/3IsB8CmRHJoSkSOvzQIT6QIYhsOQHez40DT+FQ3znVBcFqeF666bfn7usyIIKmkMYsCeDFTZBkKCj+MJdzZylVL5+iuujKNrEiOA9bUWy71BgXOzKRCVU+uWOiDerMBKwXcVW+AR65W7fInF4X7Ly8rLkwOvODn3QSZSj1Dl4luSqyHzMDtbcM4uqa9XVIiIa75GKo3XUx+VpY8nhSGg9AkzDLcX8Q3optl+bX4KSniSN5uXGUXE2c7I8yeOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(26005)(8676002)(33656002)(66556008)(52536014)(55016002)(53546011)(186003)(6506007)(9686003)(558084003)(8936002)(76116006)(478600001)(316002)(66446008)(91956017)(64756008)(110136005)(7696005)(66946007)(71200400001)(66476007)(86362001)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CIt9ao1J5+tv8xUfGOZ69Bbv3xWiu/t/R522zGxlcozUIxX9rjjZAGBk0lGsQ41ICMu/CaWS9LZ/LUAuDtqkE/X7dBjcGYp/B8JHB5Dd+PZmQu/+0AtPR59iiXtTWQbBpDGpe/S6ymW+9X7+ZZxaORgP+Qmzl6Wiza5CWHw1F9f2WS508T+cZJ86Xv81NyW5ngZ3fhJVetrR/FnkVyTjnvh8icNt+I6Bj8Bo5ukEmyDGaDEjrQUYOIfsp+TKkbDYIBTcO2CDMHIw4iHlIRVF4BbNj5kSDHqlDqGshiUHfzekgZyPW/57VSLLi3cfn3Q/WA5uSYfhgcZ+GWKCaFt8eq4zD12rFkN4t3L0x1ik9qkQs6KlgTb2tOv1N2Wo2BNNnbwzTnpfVOr2yZyxCDSbv5h+wnsqDJAAwimRR5bMYOUiNUWHY8nyaLfUtomB0o78L1MVPrlzLZvhoohk4oLCmT1cuYHE2ILBLjZmRvJzJHysewpkAp4BxZXz+lxqNEhUsvWJ8190iCQpvXVp/lb7ilDW7KAdx/FTJ+TxcRA4FKDqAtq+3YWZLCHrks5Z+9CgIkkCc8QYHSrmoKZFmGUYf1IkWRyrTbdK8X6q8/dlG6hWrl/2Ix4ggPGnu5JoGUlJjhVrCxYchcfSaB2O/6mUvg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fa1099-538b-4768-8be2-08d87c1954cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 14:45:50.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5spowk3DmEb9s/2po1Pnaek8JLSTl7RvQ1oH2wNwzo7RRAqe52tv8rhwrnYW8O+6hPXNahcPqB8pH7n+pqZWSd4M1ZBbF5ERFxF3rv/Ygs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/10/2020 15:29, David Sterba wrote:=0A=
> The context structure unnecessarily stores copy of the checksum size,=0A=
> that can be now easily obtained from fs_info.=0A=
=0A=
Same question here, I think this can go into 8/10=0A=

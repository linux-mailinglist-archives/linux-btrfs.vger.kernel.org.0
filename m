Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A612B7B46
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 11:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgKRK0d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 05:26:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4400 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgKRK0b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 05:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605696244; x=1637232244;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=icYTXb8frBPUuph2I6Cn1JGGorAmF+UoXM3uO/qEO3s=;
  b=GwdNdaULIBIdd82fF1Ccj4HgrJm5sQ8C/H6Bcd+aHxFhcGVgghMoqSNv
   Ms3FFLrjwofh1mT5H6HFw3X5liDY+ag1Of8NDqkiY+ZeuULd4BOGnhTp5
   UDR2CMG68vbxX/dUU7td/JzbI5PUv3CxF1NMjkVfZ+1pTx7DFYTNabeMR
   /D9iiLJ9Xx8VQj6KXkputAlFgXPXgqVVuphqvDe3o3IsQ7NoEIT4BKLvE
   vE2lPBBw+1me/KZtPqnscPnHVveVPET+jV4UF/O48LkIkB3SOU5nasV7R
   Cbb3eRKFXEzNYDfoxS8aB4hLNpZnj8oaaIluSKK7xdDJ9T694CZl8xPAv
   A==;
IronPort-SDR: yUsJZOl8Y0iHMDyrZ68OT7hS9d8u0d5GPgLGxIITGXKwDQl+m1mrilgUWHaX26FcjvVJcHL/Ty
 R2vYSr10KFyP0XTvAjMHbdLZs1F5XAIGCbuzRn2ybzQWv/DTCsUVN6Wb4qrx++J9BE6bUZ5u3k
 uTR1jA+x+/f4kn6Y2rybUZS5Iu5w+1RCQEhJDwz9bsygMOCazprkBBjpIjIghRLEZ74cCmwZYf
 YcbvGCzsnMQeSIUn8Um/A3BQaNtI00mUSfvQYOtg1BZjz1JyOGFjPqp+k4b1ToRxM6176UnCK2
 x98=
X-IronPort-AV: E=Sophos;i="5.77,486,1596470400"; 
   d="scan'208";a="256464983"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2020 18:44:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBzF6V2LS32eo7DweThoPL/2ES5IVoZZ1IM7HgK23nhdj6Yy+nwcVMgp1VJdPjQPoo1+iSFFGiY6msnT7NQQdmmQXwSv8g20+QJTEnokCBG/OuATCGw85sq+lk4rMTwb5lOLldwjQfanQuOjk1AUj2EvATBtXXYT+5qY4THn85VweQJniO+jGnh50lLuW9NmVbTTAVm/ijRJ+7Wax/lkn7R59TjhJtTUXtAhSsBm+Z7ulVyq6pGjaKZ4gH8f9165CfunmBnGbMU3R+j/Zsl1w0DwRDMy+WDwhouu+Jy3gxgeptCKEQ+eQeq9iOx0wb/kADMFgT8H4udNMJXS2ycnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icYTXb8frBPUuph2I6Cn1JGGorAmF+UoXM3uO/qEO3s=;
 b=A71byo71tRN058b1jrzRNB6895GWXWyclr0l3zb/5uM34wwzQpkx7yUAJg2AqmWCY2ScMkpxsq5r4xUjTN9hO7dHtkEuH1Z+jy7OVL1RNoeBIURE2TF1Lz4sqsNfh2Jh/YEuMJWUMuAniZLwqLlDXZlhquDmeEjxr1qpdf8taBYDIVCnnNDXjhuxgYeZ2OtGql0li1TkLcNA/GjWW5EC5E7HrmXO6OEdUW5CMmRTvZdBrSgJlNjlDhX0PeSy3bQNkdXR0XvBR50cykm7Iw0JXIx4rymLrwD4gFy+35Jc8pArSNilPwd9H9YOV7qD9G+Uf26yJi4xqHX5YGdTg+9Tbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icYTXb8frBPUuph2I6Cn1JGGorAmF+UoXM3uO/qEO3s=;
 b=ah2uR3t+OEuAV4fqDJyEuairzoSIJ55sCrgNf5LuOXaP13kmQQXgQs1RSmM01D5Qh79JYbH26lKTcLiXm888Su3LDLzHNG0th50R9SHXvKe8kXRTBbKBvIgB7gMlCjxAbovDP6/maMNlsJyYCw8Ikz7VCWz9HJxGHff7MFzY5m8=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR04MB0602.namprd04.prod.outlook.com (2603:10b6:3:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 10:26:29 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089%7]) with mapi id 15.20.3564.026; Wed, 18 Nov 2020
 10:26:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/14] btrfs: extent_io: introduce a helper to grab an
 existing extent buffer from a page
Thread-Topic: [PATCH 02/14] btrfs: extent_io: introduce a helper to grab an
 existing extent buffer from a page
Thread-Index: AQHWvYiitEHiToTl7k6sZw3Ut3UqXg==
Date:   Wed, 18 Nov 2020 10:26:29 +0000
Message-ID: <DM5PR0401MB359190449622AD194CA77B9C9BE10@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20201118085319.56668-1-wqu@suse.com>
 <20201118085319.56668-3-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1528:b801:c926:e87b:b5da:7b60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e69267db-eff0-47ad-2bf5-08d88bac69ba
x-ms-traffictypediagnostic: DM5PR04MB0602:
x-microsoft-antispam-prvs: <DM5PR04MB06020330C11CB8B6801383219BE10@DM5PR04MB0602.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/9neNrqcyGaH39MxrEJ0Us50A7sFZwxAg8PHdvW+/PEDvT45S8dSxwRThC/Qq8uwH2F/VP/3E3P0R4BSxrHIkDjdiE+c931uUMiiaexYwA2xpDo3VENIgT4QN7tHwtZa9rFve+nzd+1oD6WwMvIAqAP9xGzwayYjrOYLobzNwzx/0Cd8RSNT5pkT0PMOuD7YAxFB0NceuTSLsfUT92/qv0pcna8BNv986pW9OUZwVkuoZxaChOaN9bF28s+bRtjT1iQoPofi2O4mGIByUlorBbxV7Ur1xYzE8jeI7gnkHho9V/i5UIT4yE71beAvKetcGb7J7PI1gHkzAzUx2m6zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(8676002)(558084003)(91956017)(33656002)(55016002)(66446008)(9686003)(19618925003)(478600001)(66476007)(110136005)(52536014)(316002)(66946007)(186003)(64756008)(66556008)(76116006)(8936002)(7696005)(86362001)(2906002)(6506007)(71200400001)(5660300002)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3eyeIb7kziY5yQMN6k3AQRrrdfDHridNpMlKi0GqTEdxIoNFmOY9lwZEb9k8?=
 =?us-ascii?Q?9zssS2O/MyPnUBH18rlgkdYJL4Sx/82SzuZ+9Fw6Rxh436x+ouuuPICwfwiJ?=
 =?us-ascii?Q?OyndjZwTkCtF5q2e/3r0nRrORcmE/a1GvqYa+SvbD86/yoafZzmZVFrUwkYu?=
 =?us-ascii?Q?uDZcHdLclefqQglr/gOYqtpT/+S/3IOTr+wYuf7k/QFyTLBuomAquxwxquTr?=
 =?us-ascii?Q?MH5Srjm1MCc2sXDvd8HIks4WC8zueyRBiSl4yxoGQOlnGpePQ94mH73zhIrR?=
 =?us-ascii?Q?GAWsuecP2mOskt8VWC0ejaoneri3FKk6Jk21NKYEHWuTWqNmBHR3mW2Fb6zj?=
 =?us-ascii?Q?WvJJnWrkaPEpbagw/tHjA8GCo003AaUTkF0q/PMAb79thgQvf4Jf/nihVSmk?=
 =?us-ascii?Q?ET208Vf+WbmqByyNbWB3hhihwdXxwtcsmsF5Uvo4Cay30cEhOQvCH8Iko0Gv?=
 =?us-ascii?Q?34f5UuwZuQIZPhjhpMwpcDly/pp2rU85KhzZSXix/PZcFPQ9356LtC5IWD4i?=
 =?us-ascii?Q?73dKCoRoehjpQKt9sRdlVKxwjL2iD4aCA9WZ8rfikvJEM90nbSJBnNBrBfF3?=
 =?us-ascii?Q?RkuViPPI2Lvh+RnRpdjZZw+w4nGVJgyZwkH4JpoD4uQZFgWbTW6HY9ZOtEVr?=
 =?us-ascii?Q?yF4EELdbkHbv+N/iae3n18AQDbssOeHrCQ7gvxDt3+nSU5Eb2VmoIcBhnNZX?=
 =?us-ascii?Q?PviFsss23x6yO1Wrt/PpJCzaLmAJjkhvCkCMbkWQdELbv5v+Ewydh0GrP8v0?=
 =?us-ascii?Q?jJ8jgENN39Ja+qLHFBELxqIZb+F//2c8TCBJcLgfM+aOGTnz2Nx1VAzvI2wz?=
 =?us-ascii?Q?+hWxXyjkjjgl8hsWwBcvPzE87NWp5flT2tVTcrOczWod7HCo5GelPb7AIGZN?=
 =?us-ascii?Q?x8HRghBzPbyCKXSUNTtUiCxBY0+Z/EoauFWcz5jKHjZGsNbYgQ0cUjOZDOrV?=
 =?us-ascii?Q?XumI4Vwoi9q90O2hQ4zeNw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69267db-eff0-47ad-2bf5-08d88bac69ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 10:26:29.6080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnN64QjD+JMHdMESF0dBmPDVWC5vpw9G30S3uznU24FZII/H/gr84+V6G9GZEIJ4iqtftYgIcTXHcE5cOvj6LHOpU6cRLBlqqoIbyGjLz4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0602
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks ok,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

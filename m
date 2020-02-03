Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36F01504CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 12:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgBCLBe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 06:01:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34650 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgBCLBe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 06:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580727693; x=1612263693;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0E6Ujas/6VEYkHHwfDtVcZ/gWhqdkqVRs51nZQKNWxY=;
  b=cBAIX01hKDshh/2yWj7ChrPH86l2O3KGzLq2Rvl/IP5eHUkcLvnmzyTG
   Iz552SbmlVouCtZYRpQcROzcNwF3kRiWKCLd73b4Z+2JssP9y/3zmlT+W
   hJomhhi3UH/dKLXqU2K9kflp2RN/fSHbHMgH4nIw7FChoHdB7YTaBIEfP
   hsG8mWF+Ph1Akb0OZN2PKHkB1qzFxT0dUSFDgUqBPMPzkU2xqg6ZPtIAP
   VjrQ2pLrqUPwFGL6Zw66+22oWVVK5y4lNJYMm60caKPyMd0kc9tRVKCfv
   PWpuCty44ErRS8VwO+qkmYnwYp4Tz0pOGOiod2nZJSY7kHd3D5JF7MbBR
   A==;
IronPort-SDR: 88mpTYfNN3GrvqMkEH75PMEPSdrSkLbG3DBgt046qZMZYF2DS6HGAPtVs7QyQCgTAp0/hCmm6j
 617f+MaM6lQWsp0t/oK8+3YmiIjhoD91DP3+0ZVv0bvL+XlWXUmuldv3sKo8q8iJuKZgjs0OyO
 YoDBjkVNEC406E3HlRToUZ9DxnlfPwK2Ost6KX+pX7F6Ap7WR0NRjfxqJJ0wDGo/7PENN7qMyC
 EYi69DKeesDTJGcE6LFcfgbtXgteLaglsdD8xf9HxNKf8Nu1jNsg4he1UG7B7dCIGQwQiBOKJe
 NBA=
X-IronPort-AV: E=Sophos;i="5.70,397,1574092800"; 
   d="scan'208";a="128978354"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2020 19:01:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8v1cH8CfeQRW7HzS6TKD0FmNQ9+EL9anb7iUQE2TQO8YXNp0p6hFYTdXq2hHc/1bFdUTy5nxug4Gf476sG5j/p0AM47XsETM32S8K/02LO1yV118XnQjgcjsSX3/sFJnTJ9Zvfz6GIlQc1WLX9oNn4ZW8Ix/0P7NthVAbD9q99B+q9rJxZTwQXrE2tSyEbCpqlExSUIpUb+MLwakiDEvNu5+v72XwMpcyCnwC/aU1NFmav09vttL4Qe2nQ47bs5G5k0lacIKi81y8pm4tNywHpzyHiSrOH79nIIz1U2S74xXgZWmcLRsCYMzPEKPTjpbUc+nIVrWA6+ork8npljJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E6Ujas/6VEYkHHwfDtVcZ/gWhqdkqVRs51nZQKNWxY=;
 b=hQpeDYa35iYWfzWhLPlH5eO3qI3k61R5pRhbG+fb7vHG/vwoIihYVDVaBMMSnHlA0UQ5kFDm5Non1OxG2ZiDlNW0TETSAZFQoryUkNS088cfCVj2g2FY+s9bjxvwQ5Ng3gQfR/6eH1R0/ASdvpHrSpIqHkVrOfnsl+NGT8FmfgSuBkEzHO02vdFfmtOI1o3VkLakOVNJwuD26A8WIgDvOzbtRAytxK8UJCKZMgJl8KHt2NpeNsR2PGFx3F02uojbQZ4fjfCz78a7na6a6XQ3UsZXyLZoWLfdQcupjTCfAxsAt2l+NlpYmT8sUyE7vw0xo/G0f9zii1MyaQs9zHmJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E6Ujas/6VEYkHHwfDtVcZ/gWhqdkqVRs51nZQKNWxY=;
 b=HooqJsGtjraC59+In3NC4ROfiWda9JKlMRuL8CFrTujcMCnKwpjc8cahQdFy5QwT2RHDyovW3o3xqU39Ijl4s/hmkqHy14fXT6bIpzTVLMx8wOnWAOzOuExMslWSu3pvO+ZDba5Kgtk936ZlV1rP3gJoI4IkSLEudtm9GsIIyVM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3568.namprd04.prod.outlook.com (10.167.133.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 11:01:32 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 11:01:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 03/23] btrfs: handle U64_MAX for shrink_delalloc
Thread-Topic: [PATCH 03/23] btrfs: handle U64_MAX for shrink_delalloc
Thread-Index: AQHV2Ibih8Itv/f4b0CQDKnKvqgp/A==
Date:   Mon, 3 Feb 2020 11:01:32 +0000
Message-ID: <SN4PR0401MB3598E6ACE5954C669FDFD3209B000@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-4-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.208.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58332c88-0116-4fb6-9885-08d7a8986db6
x-ms-traffictypediagnostic: SN4PR0401MB3568:
x-microsoft-antispam-prvs: <SN4PR0401MB356889B5595370A0ACFB12AA9B000@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(189003)(199004)(66556008)(66476007)(66946007)(86362001)(71200400001)(4270600006)(76116006)(91956017)(66446008)(64756008)(4326008)(26005)(558084003)(110136005)(316002)(33656002)(5660300002)(478600001)(2906002)(7696005)(81156014)(55016002)(8676002)(8936002)(9686003)(6506007)(52536014)(19618925003)(186003)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3568;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmjZlIv7MtZ6MQn378sPu5N2y4vRFggwlY1JIuIP+SzSQm1y9tCChXIgcozmmhPk9N4eYMHDAH+5qe4WT/Ez8GQBjwUPkXjJBGxd8JW2BhiAAJkgxoBuOm2Cg8ZRLJkeaV+KGx9k1tgfgs3mrPooiKShiXreyz7gGwGY6kg0TlEu41Opm9iwLGlpro7WMu73/p/xLBfNBoStE5gMXPAaRn6dN7rSebf8PXI3JwK2LmiMq80ayAm/u6ZsEWWHomx5ehFYid6AjFS8DL6SPjvFpaVk6yNxo95qVUFaX1C4zAInz+i8uCeAEnCcSKx315ebze7f3UPmm+MCX3xSnW4e2alxYzOSSvOiuXVd95gHgnax+fPrzi5Pjcxsq1Fp5Djgs77NagS5ktMLKTBPjqzPXRqYv3CfiWtrQMG5b3xN8QoWvmJJ4xDEQTac+BX244Xy
x-ms-exchange-antispam-messagedata: kgB2NMc/XW4PccHEzt4mxgLnkHmH24K6xpRr/cbOxn5AfC+qVz3TBRCtXmaXEkFivW/W56oP12kTHRcX5TnxYXuo5uTSfCFHMGw3JWUw+H6egNzVYr9oEz6gWpZ8ai78OFCm4OE0g9EGZUaQkC9fQA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58332c88-0116-4fb6-9885-08d7a8986db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 11:01:32.3953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vR6WyXJXHYshBun/biHkT6GsRAYYQiZbToQ1Q1cDRCex4NhRb06mskSXs1E33Mf3NLCCSz1zU/qXu1wTE9V99cWjoD38ce1NyiSuDT7OeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
=0A=

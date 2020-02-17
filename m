Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EB2160DEE
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 10:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgBQJCX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 04:02:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34013 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgBQJCX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 04:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581930157; x=1613466157;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=P6pF2MZTcRQGY0CQIgdEGRy1s6DrZ5QENqkD76kcFx90q8S7sGHQ0wLM
   FKFgDb1Qqxe5DCISMNoWd8PZEVjAm2KzeiCRkkn1X3+DpeK0Rl+OpPRmo
   F/POpBiQ4H/3fMLGpCeNAy2PdIaZ6IgaG0aGgNTe2UG8ryq3HV2Jj26G/
   AVojUs8B/SUmEQiHciQMyd4tYiZedpaQ6d6IsQAgk/8cLCkwPMHJ3jxaF
   jD1tOK+GMLBriS1in6ryV8r9IZvQtPRfNhHGTcuobSI6iBi7CaZRRh10J
   WRgjsNQn8D8ovmO8c+Wm9MQVvGHoJdZ6sJp26D3RZqnfZVYqIT2e0eR9C
   w==;
IronPort-SDR: VcUaX9sfnqr4jCZ3UWtrQLNjAJxlx7LyVOoOooCdqa+C3hIW7xU+oGi1OnQW7k5Lx03l1znjq6
 qKQfuGVZN7x2be+Q0wH7R97w0FbtcJDOq21XPFuKK29RLY2NPusuWZOZvwVuo8EO2Ohl59LTmi
 YQ3/LqeHR82LKZ1Eq5euKSntFXuhBLuEFmf7YrQstTfGxBvfTyDGTN+hVcJMEzNm7RowdfNPkd
 /mUMTy7CBRGiQNMoKOf8LsXTmxbVz7FSbfJBMdLQbFID+1vU72J//caIa9CO92FpN+jmC5LcTD
 hFQ=
X-IronPort-AV: E=Sophos;i="5.70,451,1574092800"; 
   d="scan'208";a="231851104"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2020 17:02:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1enNOg0mcakjfLi89px6o24rC0jcyMXBhDv/VFaRbQId6L3hp0VV7Hl+0T9EFvfbUB/Axbv2kHHm7KZO0TdoK8V7/p7h+Is8vCGksQ3ZXybzZMOk8ZyiQumDkPLQ2RsTKL8pggCNtrncTcGLsVG0AEBxtcX6f5qeMm2gDpDbTwJNigE6xtFQaEbyRHTsu2DdTG6WJsCkLQ1tmXRsNUT0oTIPqpDi8hcH6LOWTRJnAu47QoL1pfUXsaIxJWtJcL4Ro903swofpZj24yOVllWzUO0JEPqfTykdTSlF1/WcH3oewtbwIhIQlsn3gG16tL3jtxad1sQdViWuygX1s9U5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=X8BA15fdePiE2lkuK4hn1m3EeoKC+JwbqhaKl+7DWyfIDn18FVf0i0I0uX+1zViPdvzmAY1Fygt7CdSQfhMK/jbEs5CpKEvtA2+b33CRBy1y8ye19zLyhVQo7PcoZ9IKuP+StqdufrJ551LRyS0MyZoCn3fKRrOIc59pYH0XFQdSMqBv4f86TFBY1EgjdFmFGC8IawwgXziK6fG3oziz7UnbwyrhzDQhQsMyFjBDWt5d7kAXN6BBoOKSG9IvDS45AY0yF+wH9J7TeQCaxPenfozVomq+wXPd/nciqsIWQG6LKV0UVsiVF2EvX3a0Iikea5zdhxaSNXJV0ee8Tw+KyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jvq36LU0WC40iv0Eoae54fMTr5USignDMnBoTqAQHGQjcp6bAZtJTIQBLv3qG1ngkG0Yx64KJ3TYeQ5wu6wExxusUjdcHFVGvrGbd1HV+YpdTfiDrAn7oG4jOmWLheOCxJhqmeLvzJCYDK3K7CYbVXoMv8y/hQ/MW7zZbuRrWF0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3646.namprd04.prod.outlook.com (10.167.141.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Mon, 17 Feb 2020 09:02:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2729.032; Mon, 17 Feb 2020
 09:02:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] btrfs: relocation: Introduce error injection
 points for cancelling balance
Thread-Topic: [PATCH v3 1/3] btrfs: relocation: Introduce error injection
 points for cancelling balance
Thread-Index: AQHV5VnhFpNI4ojxuUWSyjirTBRttQ==
Date:   Mon, 17 Feb 2020 09:02:21 +0000
Message-ID: <SN4PR0401MB3598F00A8148689834DE312B9B160@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200217061654.65567-1-wqu@suse.com>
 <20200217061654.65567-2-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 080a1cf8-6f0c-46f9-3832-08d7b388195b
x-ms-traffictypediagnostic: SN4PR0401MB3646:
x-microsoft-antispam-prvs: <SN4PR0401MB36461AAD6ED3F46A0410A4009B160@SN4PR0401MB3646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(64756008)(66556008)(66476007)(52536014)(316002)(186003)(86362001)(66446008)(19618925003)(2906002)(66946007)(4270600006)(33656002)(558084003)(81156014)(55016002)(5660300002)(8676002)(478600001)(6506007)(81166006)(91956017)(76116006)(71200400001)(7696005)(9686003)(26005)(8936002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3646;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GRq7hY1+r8HA4ZXbkfra4R7rudottqxzn07mkiVA5EUKX61AROckm8pxD9+vuuHIbWowfug/vM9igzsdkJtHJ3uvC3d0J1w08WRPFgkZP0L/iog588uxfrHM+BAsn0OPNjOY5vDOtrpXlTgu7WUeQrIdhwnaB19miduKji1vELrj/dx99J76CifWhV+rBSUmTjNY0GQFyIWOMDNAQ1A5EAph7fb/ulgH7c9pXJJCY57GNPJ8mbkBV28PRCAKguyo8DjtK2pGL0BxUuNl4tR0QCY3O1kRRWAvLq4TNFcNgP4gjqCZTNoICj1KfQMoc651NzcVmzNuuwrZqp12a14607xn4ZL8HG/78rO+6AZr5lVKczZR+IJRWdKHseO4+mjaimlq3NEE5x0to2MK/9r2wYzcpHFTNQmgPJI4RgmBgbre7Ub+rVa6vyVFhX5IxWm
x-ms-exchange-antispam-messagedata: b8OoQrkE+CeJjqAVZmK+As9EMBvGMATHZvmL1TkT+pFRxQbB4Kz9xFIcpRNz+qqgsu5jgAMctB1sKRurPE8FMbtrxh/v0VFxKd8152twDuh1u302LPRJWB+naico8iO64gGdzHzhnHuwvZouIJ/Psw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080a1cf8-6f0c-46f9-3832-08d7b388195b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 09:02:21.6898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0IrAHdsuY7mPg3jpe/1uRvfDgx4aeovo9c4wgn2O8I5PkrCf2mMKiffbCLiJTvkp3PfmonIWK5bWaGptTUEfiueFm/2IFStodx567DjrTjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3646
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

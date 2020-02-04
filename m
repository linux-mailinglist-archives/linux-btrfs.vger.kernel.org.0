Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F865151E63
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgBDQhT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:37:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15329 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgBDQhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580834239; x=1612370239;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Kt1ylOd8fLHzIpk807mab9+GZpIx1Yxgiy2dNi+2pNGmL5BiLUodBr0e
   YbxPKNG/ED4+vlQv+nnY+/9MQ2B8M+Z7EULBtUD1UqDPGkUAgDEPkfuFV
   JW6N8D0HQr7mxfX5QvaD2xJt5bkW/8P6L0JTfXFz2do0Uq4qM5QxmNJ7i
   O/bcI/vCVujT/iCzm0uu8Gq6X7HoMHguvPxfCxyVGnS/p0yTCfRDx5Eeu
   OWStP6I1XOGf3EpZA5c57xSIZPrTBye/gC2X8QncEy1Nslz892f4jDAdc
   tVisT0fXRw6Iwl7UUVnocWUulwPdT2ffMSPZIj0Yaiv0TueCdtdQrC6vh
   g==;
IronPort-SDR: lRoBsMaiyVTi2pZPgkrbpIAUXznmr3+k4Ca6tn61ekAphRhj1KtYvww2YU9cT+44OfQsND2yb3
 bdnLw7NfXbi4jY/GoBEjhrqBkqS3B9qSyDIldvN1mbmkr3UsqldMlmkJsnMUw5Jfjj27o4li0z
 gwE46EcVbwAT1gwRF/ekgE1uJht5aXJw4J/9SRyq2RaB+WHveS7CEpxR2XXzlIpOR9QoGjMlHj
 2aiVyoEBhTFhr7W9BpSDIUU6T1QwTl3Z9FIHhwzr333J/Lrl2D/usauBRh/nE9oK/iNuf2hdKT
 +ZI=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="130538977"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 00:37:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIHacaH96eM4QNPvK6+7ulGWOooxOnwmq1a8sPKZr0fcWXLDMw31qOGV6//A0TWMQjFV8qkpWz6R0INHGQDMSSnOu1wBfcmr85JL4YLlUVXUCqeDfYAUWUS0N012G8pz16dXyUIb4DyRaWfbf3lBzuzTD5uBzKfOGq4mc1BMf8Nsg3DxNpj23Ag6HAjhsCyr5DaaiI5bKyM7D5bsKPUJGoFKEhXOcgSVafNN2sI8CZ1cxrRvHXXVLGEk727IkyZBvabUAM/cCylnsvsqcBSKa4ommqslpVFHoi2GPhYWPxKKtgRqGZlzB1Z0kUpQ4vLGuDtyrBQ/zqnI3C+mXM3pUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ktnUgEZfAGw1DD8a8GwKO7ttkNPm/Gez+WvPr/ZBu61W6/V62UM2pBHTEC0kHmkhIl2MMIqwM+5WjhPaxICS/cLU5u/GmcRsUcaaN5zAHHVwUv+oTI3QjLT6tpGVAXf+FYCEk0WOwETjHgkUniw7PX+WvnvdSr/wRi9ZRdBCv8R/+NTwd3aL9ALrMFoBVM1ek1qXljoFNRyFZYz7OY7BJAAJZ3bbpWKwnrLA8Z+9mzZUCvmhCHAGkbbS8TJCfhiyC3Cs3Ff2qsh105ZiKE2cd43XaRzivuufdzaBxvrWDrMqhVVjvwjJjYC4vtFgAzIuCumzQcDd6lfqt8StN8dbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Sbk6LK4qTO02Cx9OF0KByD60VYNeob7jmbuQk8VsoGWC/4W5PjfB8o2TTtnVXJn/AEc/dRKmAqx7u47qoEXHPBX5DS8QGBcVJlTulXH4gkmgOGDdJPtdNK4wUUZ5Qxu70iZewo+HsdQelOAWiUieflJzkpWOkZ1sEY204DhvCKc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3550.namprd04.prod.outlook.com (10.167.133.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33; Tue, 4 Feb 2020 16:37:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 16:37:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 08/23] btrfs: call btrfs_try_granting_tickets when
 reserving space
Thread-Topic: [PATCH 08/23] btrfs: call btrfs_try_granting_tickets when
 reserving space
Thread-Index: AQHV23cSV5wPVG+meke6xnJuMyZiLw==
Date:   Tue, 4 Feb 2020 16:37:13 +0000
Message-ID: <SN4PR0401MB35989C40F38BE367C0017ACF9B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-9-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ee91309-2234-4632-5be9-08d7a9907de7
x-ms-traffictypediagnostic: SN4PR0401MB3550:
x-microsoft-antispam-prvs: <SN4PR0401MB35506AA94AC2102D04ACE28F9B030@SN4PR0401MB3550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(76116006)(52536014)(8936002)(4326008)(5660300002)(2906002)(91956017)(66946007)(558084003)(86362001)(33656002)(110136005)(478600001)(316002)(81166006)(186003)(81156014)(55016002)(6506007)(9686003)(66446008)(19618925003)(4270600006)(26005)(71200400001)(8676002)(66556008)(66476007)(64756008)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3550;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 302wCRK/guDiTIWhXZShXWxEHxnv5FgYqXrP7laxvxCTiSS3M1VUuR1TGg8Oc+fTLAc8ZrgODaT4DQmQxV4w8EK/z6WXOO0coAcsUChmnc51sM7L4pisFe+EAeCQe8IhLMg6dCNv06fLXRALsI7poPYrQVYnX3g2wi/+yP5weYN2uZAq4FKZdcRjEBQm+RhkeSWSihMA/CNsFcFfhKxVa1LifAeRxA2XVyywQ79p7aA4bsAip3TfNm8663E9fnDuyQl3Le0cNHTK69mwsvn3JfBDd0fzlrgTsCD2SHMi9fThCy4uKRKwrertZNa74hZQq9GSLiDPleVfcZTJE9ZdDJlNm+/0yaqnocf0TOJ8MG9/Bw4wlF1BHgC16zvMZjJAqdjwfpGFg5i5GBYeLzbS5AYEAY6Kqjh/pfpNjIHWOYk/3P7Qp8xbVl8pKEPmT0k1
x-ms-exchange-antispam-messagedata: ib9Qh8vdq59qz3y/BnGPHVOOU/hvBycsRUvQaP1lpSIs5PzR1FNJDU8a+4S4rUiUxGC9lp9mQ2cNB3PlHgfvPqeUVdfEayeKxHWmC/7916pjWSmsyK3NenpR6EygtA4QLa58TPv7OUhGNPxYc7KvHg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee91309-2234-4632-5be9-08d7a9907de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 16:37:13.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUMPC9p1B7soix2K+Scq+4z6IN6FPxeun6K9jAM2ciIXXZIyuFPeFAopzGwDt7sfKsszQOaKPkXjt3SBzFz+Q5tGVQIhyfkmd78tZNZwKrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3550
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

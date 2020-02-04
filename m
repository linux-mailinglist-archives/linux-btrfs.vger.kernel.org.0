Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE4F151E5D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBDQhA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:37:00 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54086 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgBDQg7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580834220; x=1612370220;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Vb/yMAsgaIa+CdVVNOduWSKJvNA7Zp1FJqVodhUad/OMOZANwxh7hL5V
   jsAR9M2ry5efweCna2XeB+CJMSGIYbxc5noMy5Lo02Gerlkb2VgwfaRon
   njfoGuPS7Qo4K7+aH5+7TQaN/75mAHliFH76Fkt8YanUQZVug8nagUINH
   6zKkx6BfZDOBxipggXDSmTevWTWpQ9wSFyPdjHckcK07rx2/MLkA+p2GE
   ZlVLnOaCqsFsynBlZN24d3hbRGOC4CJFVq1UgweZgc3LO3czRvmDE51Mc
   A5VrfiHSg4IrebtSuPQgOggyrTR1KDbRWzxG5CAFvX7xkBp0dSvLJ9crt
   w==;
IronPort-SDR: byCf67RtNU219gfxT4l7+EXWBKaRVAMaFWZiGVLsqOGC1yb8bgryw6Det9liGzjC14V0lTFrnL
 2x8idI0fRV6Z9g7gaqbLxfLAmsAKGGBLlAmVkULQvkB0+PqTEsHi1HYaTcU2K0K7OqjVTOtNd5
 ZrRM440q31BkZuN3mD7nBOk+mMYvI4ylvfxnlpDI2aG8VRs8wkFcyV4J58XPHjeLqKS/VDhCNg
 Om0K/wbJKWzTGdI2tOkYOIfDdEMW1GvucyjaSO3pQ2QGu3tkUb0IiFljFVu+YceyKgAR5h4MeJ
 vVA=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="129623314"
Received: from mail-bn3nam04lp2059.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.59])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 00:36:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaoaaoQ1266IapVlYBR+7X+W21gcpQVerbO8n7kxSKbkZ2+DMMcKCEhGyEtS7a1Tgii6R7xRL9qdHP56tD/2SLWbWPZBYPsD+Y8Nh33mEDTaLozoVli7Q1QSSOpoTCcWwxQPyaSJhCeTo4Lo0F8Nq+aObwR3Be2tXFCSAySAG6/9vYhx438m6kxECh5PvI2kIrxGlkW1mIJLVkY3RabY80ofX+lQeniGErm04s5WLOZZ0hOyhPMUC0GFPNx7yAxhGitXP+Eta3cIfHgvywEeAehXt5HbE6xiSbPDSeySxmERaLJMo+ik0ZSl612jiSqcNEiGJq3a1N5aEOdDrP3NLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QzXLOFzdSbfpCfpbclwtKfy200GG09IXDroRK2tOhSJlZUQB2cc+uDwyXGBmvF1RP2Ce8EE4aBpRG8CKNMC3oY0l6/rpgrhvFqrSN6CqOHqfJxSqgUazT9rxnaZaAb8zMwfRjyt1O6y4Upqjr3fhn0rXjKuMxqOmoNPFOtN8d19ldSD0QG5/kM5DTXc5aCYUdLd3h/99FwzWZqJ9POGuJv2Loap2LS98yNJx6babRl6E/3NOoHuYp3DvTo7D2D8lE2aFxUBWIYpKU1UXWW7tj3um5OPPb9vhK5oNqQviZ1jfUlAIRqnKcU7o0E3J49UAmLEqCG9xFL5Fy6fAMoiGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=X0hyIUTmugTY/qB1vEd/HkiCek90LlH3aaZdxXgPxcGHyTNkpUIeLE+vBHOPfLU0e04Yok6l1b1Y8vkv5u1VwsLazoGuCpA5pTSDKgSX4TH9hbyE13S2alNyJ81dNMXX/mfbtd47pETcRSkP3qOqmMWFXcm1/pIf8ySGIhaZBo8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 16:36:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 16:36:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 01/23] btrfs: change nr to u64 in
 btrfs_start_delalloc_roots
Thread-Topic: [PATCH 01/23] btrfs: change nr to u64 in
 btrfs_start_delalloc_roots
Thread-Index: AQHV23b2TGMFZKzWfE+zEC9CaA7FfA==
Date:   Tue, 4 Feb 2020 16:35:09 +0000
Message-ID: <SN4PR0401MB3598397C2D7565B89714ED4A9B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-2-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7c2eb47-b5a1-432c-6b5e-08d7a9906bca
x-ms-traffictypediagnostic: SN4PR0401MB3598:
x-microsoft-antispam-prvs: <SN4PR0401MB3598D0FA947E5BBFA95B883C9B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(189003)(199004)(71200400001)(6666004)(9686003)(55016002)(19618925003)(2906002)(4326008)(186003)(26005)(86362001)(478600001)(7696005)(558084003)(316002)(4270600006)(110136005)(66446008)(76116006)(81166006)(8936002)(66946007)(81156014)(8676002)(52536014)(91956017)(64756008)(66476007)(66556008)(33656002)(6506007)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3598;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gNNgkTprDKPjQvhaUW2RS3S0XGld+4P0vK4w/hm3PaQeaORtn655uhPKWLY9gltj/1h4XGFiyVoU4LV+K6Phy+55e+nKyGKUqLCuMUXWlkdDpZF1ZUg+dXn9PbqDGZjuE5kBddQllJjjvw3xFDZmQd5OiBKuDH+810a9p1OkQcMWJanm33p5HxgYmz7RZLauMd2gaWl0NnuZNixftCdNP1lqISxXzFJOmO43hdNCtk6E1s86LtizEKhl2z24UMlAogitE6y3ZNOjsiusyAMbK5b+8bSqDBlMlo5xvtIFujsJwakpmuyrQgEoXullalrc7kiMCEu+E1w66Cp/sA/pdtSTy80+2rxCqyCY2KM4dUThuMrhuMGQ/At6/I/NhZVdVNo3f3xBOoAtGBRwD1j88QMBkyQhAjsPXlAbCY8Vx03j5Uw7oU5DreOnwv2eiH9C
x-ms-exchange-antispam-messagedata: ol0laWdm1b1kLGxaNtoOq/KKjKKugySt5RDdJiHUJTT4uH77gF+Il5sUx1Kla5UWyv8xy+1UHdL+lHW5fUIsrU5NONp8fDY7JsOYvw9Xzw8DALENnnu5PEuPq0ezBSqcpvjJI9fT8hd3rn+zsRfTUQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c2eb47-b5a1-432c-6b5e-08d7a9906bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 16:35:09.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQfxQ8zkNIgZ6KEAPH2zYohF5zb7RWkqQLk5RDOpqSqx0gu9JKqzxskAah5H9SwcfvZq1OQPn0eTVJ2w9v0YcBSga6FF9lq3c63s2LBbVWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3598
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

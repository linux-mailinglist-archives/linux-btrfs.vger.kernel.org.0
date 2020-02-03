Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D13150484
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 11:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgBCKqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 05:46:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21679 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgBCKq3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 05:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580726812; x=1612262812;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=N+nF68tGi3R2sQnoBuDl9diw+n568bLTPm6SyNJjEzY+1FuMUMP7FYZw
   bcnQWskRfsXzHIDtfcJKszC4zmVw6cvmxZ4WRuU8wGHF4GsRWOXMGxG5l
   MHQSriBMJOKPIiRS9BePm6mlM75ugzSgBAfV0tC3WXb7AygPyHasFgd4P
   rcFgJCNfYDPHt88ch425EcOGv8Pk71QQpLEalq+K11bL1ty8GzCRz4MhT
   ZFwBxFq3mbLfKBXBwuwPh6mdk5WmQ48XW5VkM7lZwiFRb2qBL8RRMVEXj
   Ag6AnMozbQ7s4s3JKsvt6GSRLi5vyyMW4YRG6IQ08sFpw1qt7g8FX4pGc
   w==;
IronPort-SDR: gfiW4Ghpw+DCTbr+xeFjzUR1ROwPXQEvHYFwIAs90zFJIUfVaTkbrLvydGPweCsXGxirp49cIE
 0zMm5dDoiGh+dZ33t/B9E72NLNUbfaWMPNPgd1B38ITh6GcCF2VMYUCkCFMIpLMG51HfyvAfDK
 R5s0p6bHVGrfNM0O7QUN4zsTC5HIafI7Vf/rAZ4HrV9fXtyjmrqx20PqvZlMEUYQN+WfM/88xn
 vzaxv0yM9cftNHnmI9ok15RWUYq4CSwFtAqo/SJzXYV7XrxxMSt3tiDm8jOK9r+7FOFvTjwmUx
 13I=
X-IronPort-AV: E=Sophos;i="5.70,397,1574092800"; 
   d="scan'208";a="230703350"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2020 18:46:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCaQC/amULcxcVKWr+7P/+5Z/RgMVZyp1G5aDjfXWJVNf3r6VNR1vI5eVR+8yHTGXAOd0RrP4ujHkRQ+nEPNhKZ4vt3K/bv6s+jrOpxxU0Nyn9+rpAS/Af+/tkalYT24RuPKZAuN8imBcD+hxT9CMCAD6XV3fp7KhKkDh2pb+cEGKNsj/Fi/80UMHxEjljCu3TXfEf3n04ZzuQxnnzztr1l0CaSaX153B62BttGd045jChY8p85UoSHF58om4tkftTfxhsaorPR07DgPreJb17VWE+8GGEIvQlUIhTlrK325h0pJ3jZ1ISWP8ag4P/Pvc74tIJ3MZZ63IYZkLMs6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bdi0Df5vGD40S7jJIAnEUaDX0WUc4PaWdpk/odjvssXTWz9HmQEbFAwd3Bptmu/kf3dOjRqiMlHn6dfpxscng/a+a3VtfXxPd924RsW0QsdAihz7kzfWmMmgeE10YPnb8oFAldk4rPpWe0vmZKFHXnbqGyhXjAJGBg5K/xh8opPigL+X76YrCdH+I70Vhmort4bSv0TgNhU9QyHWwpW7ch7S/EtnSzhbAur4OxzaHb8WGhZis4xioKzEpn4xu9fNLAfuUPy+mr+NCNGT2/Q0vcxIyrmRqirZ3YBSjFSDQ5adIH5ypPgHOXGz3PqeNyOZtx1cDlD8eG8bFmrynqVNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qDlYsuFs6DT4UcDbnmPCWwGQ9uX6TTYgp9BUGWynrRfqQjqVN9fLoSPAOCp4EZMe0EYqCVM3pJjW9uHlGtyX6IZypmIxyQ1QSe0LdQnyIsl/7fnRARaHqBi3r9euaUxwRLGTnZwFxh1oxTwtvONejrPvDigLCU7/GK+/ZAOopXk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3646.namprd04.prod.outlook.com (10.167.141.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 10:46:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 10:46:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 02/23] btrfs: remove orig from shrink_delalloc
Thread-Topic: [PATCH 02/23] btrfs: remove orig from shrink_delalloc
Thread-Index: AQHV2IbizR5TA0Vy4Uuvdx4F3WZ7ig==
Date:   Mon, 3 Feb 2020 10:46:27 +0000
Message-ID: <SN4PR0401MB3598CE94EDF8327521A925DC9B000@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-3-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.208.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c89b5e23-859a-49ec-aa21-08d7a8965296
x-ms-traffictypediagnostic: SN4PR0401MB3646:
x-microsoft-antispam-prvs: <SN4PR0401MB36461810EF2C65CBE7D3E2509B000@SN4PR0401MB3646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(186003)(5660300002)(26005)(8936002)(316002)(4270600006)(7696005)(110136005)(66476007)(52536014)(66446008)(66556008)(64756008)(91956017)(33656002)(76116006)(66946007)(6506007)(558084003)(2906002)(19618925003)(71200400001)(478600001)(9686003)(81156014)(86362001)(4326008)(81166006)(8676002)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3646;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/Wy9mfFY/24VJUr6I18jQfGR1Jsbm0fed8s4zCjHGCUxu/v4BY/lyEVVMZnPUUXXRBdxG55MbhwGiPh/lZ41TknJtVL7Lz4wcl6o2tLo61xLQO3zL3UdVa/CxrZ6xwfGJX80TxGiqoYXar4AxhAZLhGl+EwaxfHKbxFBe6W5tm6sQFsNaU+2sYmIIoQ8k8KXXVYOoLTaCG1N2sV09kHTsal9G6t0iFdf0K0+JWgAVzTFZuLadsdj5fSiE/sx4j6amB2SPpQ+g7MSEhnXumLCNDQs2EJV9biprWWt9DfJOxoAk8ttASYgMYMIWvQTicxut7OmbVvWnAyPmZx3MUaphy9ZXlnoYbOA2/6zEH1zCh7EjjSDT8iq8ShIzrCnvpo/eaAtI7vdg+kbESQo1yz0MudaNunWPd+3S5F7AoVxiilJpbEdu5snw7LjvE0eYgo
x-ms-exchange-antispam-messagedata: vZHkF27h4R5WWxaRheFVePkinIgPam1sS98U7oiqbW3umN7nr3sBpdl4MFSvYpD5nxzO3hpsG6WDYgRvHsDj8xwgXhEinOR9fpCC4nq0+PGUdOSv2YFEKvgJL6KV9OqpO8HSpqM0Pp2uXMNVTXhPiQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89b5e23-859a-49ec-aa21-08d7a8965296
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 10:46:27.8781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DttUB3I+hNmZE1S2I5t/atGt5p7qDO5yTe36o0NZ69iSWRDzjijfCzS5kvdUaf1T/oIfX1z6Rk2hgQ1bL1Id/o6lKDukmNIbZbB6GwIf1Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3646
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

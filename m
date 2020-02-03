Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624A0150480
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 11:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBCKpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 05:45:39 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33451 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgBCKpi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 05:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580726738; x=1612262738;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bCJDcTquYolvp9UVQ9aQdLOBgFrwC+xa35lC9GGV3pT0sYsHTFuPFSnw
   H9EWpgMzPBFJo8/m/XGwJ1TnUbgMZXfTPfxlQ5eUrdwdVzj06nGCwlcEj
   QGmZAXXMGUh+fUnQ3QCuxc+rtCTQ04XF8lgJF66JV4Bgyb3LNH3pgZfzm
   F52qWwVjT8y+0kN46J1LJ1HP9yKajuw67YVmAWjF0iqUCO9K8gz11QalJ
   LNGvlC9r4I4+03IYIsCtbZLB0O9QhHneu/JlhNjMDLSE+dJg0mWB9hmP5
   RZpJfCjga5A3/mhczjKlrsk1OwNWkxnLtbhc0fU2XciUeVqqR4CQZgCJY
   A==;
IronPort-SDR: K43FRV3+lvUjTWaTK5GAd6dW40H/XYEkgSBJkkYdr3jjMBz/PIyKLCWFykwryUk90t+NfhFaqu
 gte6G9F3yPkjf8Mi6LQFK1oFsCUHkypVTYaryRbV9Ma0qP7qzj/orGI1tpah0HOHdPz5VMjzbA
 IW1s6XuVTNwPrsBLXWcxFzMsAw5bgriy+xM0M+ug3sSLp1cR/JoApsrZa1YpbvdeiUPB5VLVBK
 2aCwqizW8TLDOkiD4xQb9uaq/fcsBlgK4pgTc2WJ/EGBdbor7TgZFUoc3tDcZOPVLWmffYgskq
 mAk=
X-IronPort-AV: E=Sophos;i="5.70,397,1574092800"; 
   d="scan'208";a="128977762"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2020 18:45:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5di5vEyC8pG5vt4TvSBqfGtjF6EcUtbTwbQkcoFF+W6E2Ga/dzrLDHSJet+oM0lGORrOc6TbgoX9CANrRbH9VaPwAzfUYBNAlLlrbxtaSsIMYSx6+bMWsOU3XsJU/xguEJ8aNdY11vV5qLyDCIfPPxvTbhX3bww5DF9bO7yEspRqUmqBFUpZLou8h/N8bufS1c0sdLGZvZr4oJAJCN6aF7Mc39p+d7KSwsr1Xr5tyuyC7/zNYfqt7DgpBe7von07ProkSnF3mRudx+dq+CIxt557P/1V7paAassh/6g58oiq0cT9MboasIciQoS9jmMJp0m7KsLmWDd+Wrv9Kp6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Qtr3jzVkCKAEvomJSSzRk1z+YiNWk+UzlfjChqvv6MiyP0nsoULJFpIMxgxxmuIyIDQa/bAWdQKih9DrVidP9QQhvX+IAghEKA+PMOO9XlUhnHWpjecAHbbSJj1liebJNMrIvXBIfGZho7scutz3iWEawHDHB/I0C1EeM34RbJj7coAb+Fxy8ZsJLqvWy0gvi3EAeBVOHaOG4WpF+Ju8wL+eu7blZiuAOpk9B3NT6PoC379BY8G6RNbadVvW6Kj/qm73KB/LRBebEhfrNwb9gOuGXEsKEUwS3+cIGMVT6CDeJRyyKIMEVNQnfQXTm7hwXczp+Na+88ZIaDY8DtpK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=x45z/ESU0iJwpcHSkQUaSkhjDLJWA1sI9nxVB8a22+IjbVLt6+HwYQ0o2mpQu6uv9nf85TR67y+9J9E7EL8oL0TSbnVDHuquhtGZdqV1KtuzVW03IqR897uGcLSFhFZF7Rct6j16obfSmV/jyIdNYQhXi/u3OxrEURTR0knibHU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3646.namprd04.prod.outlook.com (10.167.141.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 10:45:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 10:45:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 01/23] btrfs: change nr to u64 in
 btrfs_start_delalloc_roots
Thread-Topic: [PATCH 01/23] btrfs: change nr to u64 in
 btrfs_start_delalloc_roots
Thread-Index: AQHV2Ibg9RG+wIUu+E+aQjQwWlL2Rg==
Date:   Mon, 3 Feb 2020 10:45:36 +0000
Message-ID: <SN4PR0401MB3598DC6FC69ECCFAC970B2F29B000@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-2-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.208.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b33accd-7fbd-477b-a362-08d7a8963433
x-ms-traffictypediagnostic: SN4PR0401MB3646:
x-microsoft-antispam-prvs: <SN4PR0401MB364614FA6DF1EE03EC9EFBDF9B000@SN4PR0401MB3646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(186003)(5660300002)(26005)(8936002)(316002)(4270600006)(7696005)(110136005)(66476007)(52536014)(66446008)(66556008)(64756008)(91956017)(33656002)(76116006)(66946007)(6506007)(558084003)(2906002)(19618925003)(71200400001)(478600001)(9686003)(81156014)(86362001)(81166006)(8676002)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3646;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GzFsL1fK9LzhTPCssACUYxOMO6rNFtj5oIel/WssbqojTgcLLg3lttGi3Mr8N7mLAw6GgHtx/xl6T/jdYDR9n9nVFhnBw+HfZh2quALAe2Nn9FPFOW+xQ8bGveDsjJW5Z8WyqfHQcFPqcs3FG3IvY491IUy3p8N1uLUkq/23TckM0m1/Pmg8pZrXD9ae2iOEiNfFLMKAprHxchGHS1L1ynFTV9rylFRPutNtgTiZPlRbTY/3VlnJ1dzQT0HGEGCC+Uy9gcQ42rF5fdfXQyMQHRb97ANicvi1v/YIQPCcSn2upBCYbdm9iJXnTsZcAJeQ6uqIAeDZnEbe/ITezXgSByr8OPpZYBMXo45dNkYTybnCnysBlYNJ0hGO1bwNTt6wz5NwKNV49T7dKfofn6sIgf5nxqJ1rmRFIwfBt9qaJU4wMHk8SCzUAMHT/HfGCW9Q
x-ms-exchange-antispam-messagedata: w18zebpdV0o5N+FfVmOYSrAVSbLMb+8miZgBUnzlBb2jxkLkZB1+gNaR7tyB3D/4OZBi/EsWjYTexFBcs7k4HMff4HAcUDTL6besPARkwtvOrxwy4DJMhSeknxbhmyk32hWqQsNKiKwEmUNsCSXong==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b33accd-7fbd-477b-a362-08d7a8963433
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 10:45:36.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7D0/6r+bjWoss/+35SGEcJfyAbugAfJ79bFPLCNct9rzOB8vMyt1K2Y4qoyQs0gPQEp/RIBnDOc7rJaKQzXQpJFOkKw58e1ihAxe0TbK50A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3646
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

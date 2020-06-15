Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306721F949F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgFOK37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 06:29:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40391 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgFOK3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 06:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592216990; x=1623752990;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=kakPgVYl/fUnqwgkdQLqZZXHQ2HHkuSlJrEqr0Y1x6vcbqtpuAZXbecz
   TdAGH807W/DdgV5Xyyy/kolbH4SO0omQ5SZSpdAvOcpH5eE74AqQxOeCj
   dMSonHDhmlwPgzQzMY/vlibwGiiZLH2hM37Zqu1bHwq3JSQX6oeJLOPWE
   JiZQLNGGcOY9ExAdlBt0zUazkrjBbPGt1mpdnGXjd2mAlDMiz5bk28vQ0
   2GWQZQ5sB1/PO0s+JzUhe4v6r6siJBq0dwFGs7bKFe5PbRGI1FgB09y5F
   czUKYXgfEViPtMQNwCIKaF2qLdr6sId4n15LIGMg9vBLMJsqq1dPWnSEE
   Q==;
IronPort-SDR: M7Za9eMfIPw01Ez6WYj3xS6zjuW6j04RVhVjY4ZmeS883Gd65Ox6DA7IdRCykq21p5tK0Qyh12
 UY1tIF3o4irX65GI1RsTo5Q0YdzGD/x/zPkyCA/6PXpwXUygtD4eNS8lsk44cafa+U5bFya+h0
 V9mW4nSka0pZR6ShLRHrMd/0Q2Of2oksDHSjezHzZJm1pA0ZcE3RmjeDP1dp2xX1G9Rrbk+EV/
 G8EKiG2egiAZAZ8N8Ec954IFcJR6qKXBDFyGFu3YXTy4kKGBo9h34mvsoNo27XoqgF3So15VGT
 H1g=
X-IronPort-AV: E=Sophos;i="5.73,514,1583164800"; 
   d="scan'208";a="249196396"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2020 18:29:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHxC8xkcD74Bt5xdjvHozCoOG0+np6AFHFd2uGwUwuOPMqqYMVQD6sf0JgPMu5xxkwp/R5rFi+qWC7Q1Ny2cWdEKLd+xYfMr7xq6uSeWc7nao2FPwtmhBMhkEKT7sf8DtO2FaguKFnf5cBSqe2n08Tm0vvLK0Zg/DdaiCXNr2Gb8KNrpkoYsRnkjv0n2RtUsgJl5euPmggfBfvg1eWlPMkcgl2mGLB81tlvPIkxiVyfMSat7gb61dQDoyWk9IKm7Ql9uOkJgVI9TssEd6gpFcwbEiJgFN1GmOazjdwyReJzxbgW5DDBaZ0TM0cDPzTQNTOzmK7M1XUNxzuOmI2Mp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nQ+8CpnsYlir4X+FNjTO5AHyZNjYz1wlPIIDaGmKDCEQyHNCsPiXB3x/SvY6QY1NtEKmAiOg8h3mbiDECz3FeDp46HV6J7jVdzzSgOf64rCr7Nsce11o4+oaDAvyp7Guek9mTw27/CSJ5OPhS/SANctR8yrJWfDR2VF4AwGpoApey7uzLdz51S7szS7mhkN08Ubw17nBSo/HTLM8MNPehq8QkiMSkXyrVe58c1Rggj/+zRUUeISLaJqwC3el5kx4eKZjK2F/CvE3kIQNCE8e+lUcFolqMgrolhIoYqql12e42d1W14+LIH5zMlfG41yo5/d/ST1twYWqJS5iuHijdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CYLA+II/lqpvAIajTTRxGTJ5r3CkMXSteA3vQUYOqHgoFbYP3vuRlQfYJZIt5PXpZm81hGmizkfWRonK26f6JRbvbMOxfkH+B28HUH5xnWm3w5p5ieNuRNF+RRiG3HAIJ4lOO7LifiGnVJ+njvcpKaPNkOliBqJcsw2byaGJjqw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4607.namprd04.prod.outlook.com
 (2603:10b6:805:a9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 10:29:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 10:29:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] Btrfs: remove no longer used log_list member of
 struct btrfs_ordered_extent
Thread-Topic: [PATCH 1/2] Btrfs: remove no longer used log_list member of
 struct btrfs_ordered_extent
Thread-Index: AQHWQvq53VY9qLkx8EuM9kqpOPImSg==
Date:   Mon, 15 Jun 2020 10:29:44 +0000
Message-ID: <SN4PR0401MB359825A762A5B6AB583B87A79B9C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200615093648.287105-1-fdmanana@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92f633dc-2785-4331-0823-08d81117053e
x-ms-traffictypediagnostic: SN6PR04MB4607:
x-microsoft-antispam-prvs: <SN6PR04MB46075E3FAC9F8B5AF6095BD09B9C0@SN6PR04MB4607.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yt6GtH8iSz3bHRz6s17gHN7MtTIORkWod22dyHT0G8VLco7ACXacn2wMs0apfI/r+eBvkGfqTZtoosxT0VfRS6MIWooiWSwd2TvDhDf1BFFWW0RQjlMPsJx0VLELL19KrD8S92VZnVRtCydmTav8m6zJg9jI7N7IojJMy8JhJDJ3wyDB/HN7Ltqbci2zmpVe9wJ2zHOFQ5OclcyQNR+VySf8OQFKi1+j9qAeg5Mh/lVisB57DxApHUBr7aPx4d7qD0P1Wy6v3UaZikCEmK8ZBoyuItNv4rtgfJU0jAq3ufiFmuWGN17O/V4kv+2kCmY2hY2/hvgi/pdxjVCvjDup0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(6506007)(7696005)(19618925003)(4270600006)(316002)(186003)(26005)(8936002)(2906002)(8676002)(52536014)(478600001)(558084003)(9686003)(55016002)(33656002)(86362001)(110136005)(64756008)(66446008)(76116006)(66946007)(66476007)(66556008)(5660300002)(91956017)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cU8rdOnun2KPDRubPUTtKSI0Xv1LrTQNzAG4dJGbtqit5/02vS7m+vRv6JR93lpzWHL60aZIxlAy0EFWUzbqkliHvkLr66x6LVKapGVELBr91SklqaZPiFJlJ5kfpaep3ipGjbbRjsKJh2ahvundm4ibgx1N5B6nUEv2veTgUhZXFeXBT4vhEYzdBGlyfMuCNgVMzuwcjSBhyZ+JTr0mzNNvtmEenAh4W9aYHL/nfKRZW5E/JIUtDucOKcp11icdmc5nKh/urojC2y/w+ZRr4tbvcnIOiPYERXfNx+prUaaD7d9g9+ARuB4S4hJigHvUff+pv6D68qk1jjnojTH6HUFiMveUTMieAW51xlHteb14StwQBx2voMbxAe8SnxAsqSloZC4MdbX7Hh71ChbgCE4a9M840CF7GdSoEtF82qsvKw11Lb4KkzYJSYUweeHwJEi4V7mCzRC+kEfOT7pkIH+vePE6oaCJw2jzg8zE9KGc11oqALU6bvbnyrFIHoi+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f633dc-2785-4331-0823-08d81117053e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 10:29:44.1177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wS0nqa9zhwo3PVFGH3eeG33ja5EYycQ/IRRTWejII2Cj10hwmitLnEsgPJAma9cK/00/9yu3KXND5yI08k5eba1dE99rXX2QvKkAqC3m9kM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4607
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7F515049D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 11:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgBCKxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 05:53:51 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60501 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBCKxv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 05:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580727262; x=1612263262;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Lo33dLQqbndIoSoRNrdMpHFkWVqxTCWxtsnzGmTU3q9H/vDYxtx3j/AS
   hIt2CvwOq1zGZS9RhP2Nz+iaxiqp5Wyq/PtakPZN8PVHGE7yL9aHTlqOM
   olWE9widmxJCukLp6/BbBrnzOW5tPDjoBRECpPYGEE3kk3zv8SnlDfGpv
   xTveRRFCBjmPXIDUF6KWJMNBZ3TdLsQMxAo0riebcNgqPOINATeI0MCdt
   BaQ2nw3l9oJYRI0hVD+7XyJMZollMhTptAki0SYD0Yys3aKzBhQnM9M7l
   cs4xPjTKkhOAXapBxsiv0yIQL/cuq6JWV37UPlGsCHl9aOl0DvAIiVnTy
   Q==;
IronPort-SDR: GxjkA/pJPLqBkNC+St5KBBx3VBbWtjJry71ZieVLKXcm7KtzUzOm0oe7owra+LWv+8xJ9dBKzR
 juZSeMhCARlYMdkceVwmpZBe3L8dKML4YjMpujLfZ0ujqBHPR4qAv4D3EVmxyqQFlMo28U6Aak
 16XBpTWqS1ksdU5GDS7HyOmrTn1yW28eGSfFG5ZCa5XNCBvORRRm9qdIaWMCcWZqYGjgZM8IoX
 886pHYJNMiEueauM/zgIdhz8rLwYOpSehjsPP9HDQu8GzoGMcii9G8ikpYrpAvCMOILk/+BFaY
 Eok=
X-IronPort-AV: E=Sophos;i="5.70,397,1574092800"; 
   d="scan'208";a="230703662"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2020 18:54:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZtv6k5AVxx6NqC06SQDu40+lGyjT1HAFnYrbauGNCP/TxNzAO2ato/6R3SxvlzuYs0rngNfJ9n4ihOAlrnZGN/9W0ANCrg5PfTXh5zPyX8Ae0lYQyseN6+kv1bv2kG6lr0GYljdWJtSaLGYlbyi4gSp71O8cIvsz8AHovlvdCstGp7lt45/HkdMhp1xqYBqLZIe4Cj2/vNn239Y2beZLUhUuPfsy0KClK3MY2AJf1H1/9ARf4A2F9/72dTR5046N4PwNu9zgL02yamnKS3j/ybvH44Abx0BOxD3ZRC7JiO8k33Q4D0Nkco5XG1ohL8NnxzxhKO7gbAeQCEQEltNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mwm7ZlJfZdT+RuSt4QxXKCk/mO2t7dxWZz1iSdExWwKhg4yXTwN2xrET4JAfr2eIFvkNPHdvIcwgsgA4qVVqaG8lxW8wOLWdhMMuiHadGDUqXWQzUVKHg82CMDpj+OeIhXaiRcO5WCZw9OMKV4lt7YnCMs1xpsB2U1xddsptFKCoN/2uiTnW0EPNeOGOY2Aj9+O8Km1MPeZFyktDwMPzgSowahiTaWIUJCMdFDJ/jRm1M0jmqb1aEwoP8T4Rqafy01EWvntWHzEFP89sPYALh24NtQF99796ak+DGPgusIAfPMqwbPWYhx09H0MjIdOKlQ0WopFd/tgn8XbVhF9s4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=X/ovmn55xS2J4MTUtXDUcoRxDPILQ46geCJTdRThD4BtPYwKRIc3yeMqaWQDEGCNGs7lE+iSPa9+MJxE9knOw04TeWqlEOsYZR/RnMSo20GbZ/p5GQlh1s4vhdMazv5zcrhLR9dsAt5FVkln/JMb3y4wjWW1yEEUxBfTrFyTDg4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3568.namprd04.prod.outlook.com (10.167.133.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 10:53:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 10:53:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 04/23] btrfs: make shrink_delalloc take space_info as an
 arg
Thread-Topic: [PATCH 04/23] btrfs: make shrink_delalloc take space_info as an
 arg
Thread-Index: AQHV2IbiYotS9SdRfEyOAhxe0gFaJw==
Date:   Mon, 3 Feb 2020 10:53:47 +0000
Message-ID: <SN4PR0401MB3598441B7949674AD285140F9B000@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-5-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.208.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 540f0ad7-138c-468d-b5a8-08d7a8975897
x-ms-traffictypediagnostic: SN4PR0401MB3568:
x-microsoft-antispam-prvs: <SN4PR0401MB35688187937637C7136C66019B000@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(189003)(199004)(66556008)(66476007)(66946007)(86362001)(71200400001)(4270600006)(76116006)(91956017)(66446008)(64756008)(4326008)(26005)(558084003)(110136005)(316002)(33656002)(5660300002)(478600001)(2906002)(7696005)(81156014)(55016002)(8676002)(8936002)(9686003)(6506007)(52536014)(19618925003)(186003)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3568;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tY45YlGBieeTY/4vSpXC5a59+fmnELcH5FKkFkOIhSL3vk1z1SHfRyAmx3ZA3LQyHAWRR1PPcIa1qBnDxarPtGqRbHTOMDAkkkMNy9ngfHuyRunW4ltbgPs+//9m8Xnej8C9HzC7dfK0IIohQz5jQiwo1HEWa7qpKpeVWhZ1+Z8esyWhrwyjhmNApHYOCwphRAZKNhqYpPzDOWPLfkxgmg/OMPKU7CQnX3kjJkduAkD8Jp+IVaHv1NUca/hW6Fgoed6WrdlBP3AY2pmbpSVCGypNOCpPFB1Fl1HvXhVU4c2HSP76hUnn1chB7F84d+iQ8p+Z49S9LhDMLtnValOjWCFTNWmDnCwy8gCJMG4PiUQtrOqApoQpRPkmrjFRd9LVXYsJOifv7xTj1DNm1LsihtWK6zKFIlB+0E2NknZRVxcZluXkjwt1NQ9P1NzMKaao
x-ms-exchange-antispam-messagedata: bX58/SqpL2k4BnoNElM2a8lEdUcnxHs6Atfpp9n7SOGGLJ7zjQ90+2z3PZfA822W6lJTvr7vxO9REBo5RiGFQC7fB3tkJtXj5MS4ul0nNz8NG69J6eyjYAxE0uiMFIe2WHC/wQSQ/n0qmuqS1yzHJA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540f0ad7-138c-468d-b5a8-08d7a8975897
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 10:53:47.5340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsyNefUamHGE0T9SBIw8BFd5ymNx2HyFNqz1OzHeWzsYu7sIdowR+aJPVYuTdnepKa5pzRSkvzkq/bb/vn2U84/qFhDCRqww6y8r9NDn6FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

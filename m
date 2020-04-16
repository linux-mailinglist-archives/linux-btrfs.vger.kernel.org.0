Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847551ABF2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 13:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632860AbgDPL3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 07:29:17 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63619 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506282AbgDPL26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 07:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587036537; x=1618572537;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oM61iUUYT6LOjssaH/tWciiiPthQVaG0Mbm2KY3zsAk=;
  b=chB3GVQfZNDCzlCXmfDyb3FbuH1CLBxGnOdEngGu/xqtJVDQ0TfcP+Jl
   +TBRmh9WnXY/JcXgifjiLu2MkXrYOo7Rsk1p0LtM0H8mC5H/t7E6Mbypk
   aOOSYzwrOeBn658ufY/PgmX8iZLZJUHn6H1QjD8ayYdZD+4e89iA4FVxh
   5tQYnJSze7Qa77IdAqXx1QOzw6PQyBL7QyDhN/vFtBUrfkPCpcaN1PSpv
   Kv5IUNmfFWUxTYj5SGSoesa39ptd2s0So2MANiY06LpA1qEpQYcicTaJm
   7k6eewjQHYMfQlVlKO3VNsqsIf3FKXEG3iou562Aj8chy6XnPfb8R6Kr+
   g==;
IronPort-SDR: z3WhfbARXdSQuLcZn4Cz5ynhRNrU1yJS/m/j+Q0i1L7Mz+sW4pt1mIG/P8nb9O7s4m/kNH1VAt
 4MvIeGvCQ+f1kljs4+MRiawoVxrMf/pbDS4lcYrUhBx1tJ/kaIFI+hWiB2n7vy5746OTrbbTDu
 5+K8QLF8y2oustMug9jVhxbepoykaDfyzt7guFJVel4GSgpm/zgR+ljtK7igNXPMIG8a03pwaB
 FxkO/IML9NRV827DUKKLlmvxqgw7fiJs9xaYX11HAOfx5VyyaD59PCRRJHiuyzp6RHvySi44Pz
 QMA=
X-IronPort-AV: E=Sophos;i="5.72,390,1580745600"; 
   d="scan'208";a="135472264"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2020 19:28:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEIHLzgsv9Hh3xyrmpPRafzmPivE1pPalFW9ho68ftAlPe6WnGSui1wiaxYu0bMKxJv9K3IGBb+txFg7h15VLmX3N1/zn8mJvlMonMqGR5r1qW+sZtq8phN5UyTBxDBpXPs0xXAx9QOCUcfpdoAW3mXccDiDsMRsAgVHUTotvwfbUydRb9jQD58CPde0efCNXY3hc7Z3zv7dzLUCuecIi/85a1MXE7+j45XrhRm3+U0j72xkV3eassxGTWCFBBqmbzS9atCDEnP27uPoDXCrci2+YWn8x8Rc30mS+c8sokG9gUNH+MvSdGiEmsvajemjtWVm/zXIG07lYcszHgSR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM61iUUYT6LOjssaH/tWciiiPthQVaG0Mbm2KY3zsAk=;
 b=N/aijFREA0bO26IqboARt/YsHUzzc3RwJ8C5q9GFLY6TysZ5t9ku3KfguLqFIYDxYljqVWBGkfQgNiEThr4QOnGedbVfAtd/3iECP7kyuBfmajHnsW98cwANoJKw+9U3P1QFcN2LgDkkWLH7xab95BzvFryTHpagozv8RuBLGoHZoX0r/FJqcQzEO5lHW3LveLNMffJHjXJwpxkJowiZaU+0Gwmyej5RPicTi0rfMuSoIzxPI1OSHwXhKQRaNXnMh7b6lYE8PeM/7EMwyjtXkqo2/xTpWUUrWAyHhQY/KEsvz5Iyt6vhM2ZYyQoK6c5YVRZDgzYbAsU6ptMJUYHN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM61iUUYT6LOjssaH/tWciiiPthQVaG0Mbm2KY3zsAk=;
 b=GjyKu7QL8NJpP+g5V9Yw6UyA288ew9MPjXBACgNYnY0WiBsqkBIWgC34yZjJ5vsVdfae2cvTCUGCFRbaW+TM2qTbnerMgCiUUSomJQrKc8u7EGfQMLEEEeVXKWgwp7nslO/teK7Be4iIa06z91ovaWLKLUSfYeZDNjMqKS6+dAM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 11:28:39 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 11:28:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: Make btrfs_read_disk_super return struct
 btrfs_disk_super
Thread-Topic: [PATCH v2] btrfs: Make btrfs_read_disk_super return struct
 btrfs_disk_super
Thread-Index: AQHWE+HokABaAoRzS0iGDT9E2f1djA==
Date:   Thu, 16 Apr 2020 11:28:39 +0000
Message-ID: <SN4PR0401MB35988847438ADA88EB95E8099BD80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200416112608.8095-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe06a85d-7ec5-4655-150c-08d7e1f94fbe
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-microsoft-antispam-prvs: <SN4PR0401MB36796BB14B2C6C45DBB3411C9BD80@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(8676002)(4744005)(5660300002)(76116006)(8936002)(2906002)(478600001)(71200400001)(55016002)(66556008)(66476007)(66946007)(86362001)(81156014)(9686003)(66446008)(186003)(7696005)(33656002)(110136005)(6506007)(26005)(64756008)(53546011)(316002)(52536014)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: myKNbm8TVLAE/ZxEgQBCIez8WlBderTcJrMuBXqfGuwlUu5cYC/UbWZMScKLbg95lah5zQ52cnh5BMPA45A7aFamQbt3tdh+1KmnO82tSriZPMVDrBQb1Ip+hmEDZNLhEoXvXzYlfP6wLJnVWqTUKgUbTGGLq7KLW/mzkvCfkuzNt/y0jVsjXLoZkHQIa3FFcgtbHR1WleXyC5b7w7k3/UAJcEhgj09YvumTpS88RIJdfXvxJGT3nobA9RoYXctQKA7sgkHfdpvBLVhS8vup3zadh8ZLZ7BCMHeDj9o3F/03V4vLxvLBLlcbKebhIa1LrQfTmPYMxSpSNpKTLKvI5RhK9Hgc4Sg3CT94q3zsjqaagSJ9xrNHp5ya1UvqrbgYmJpfp2NiQl9SUw6AhrsIa5xd+dDYJl2Rs79hWLeC/5FmHwo52/u59Z0TJU7FaLiT
x-ms-exchange-antispam-messagedata: r2M0oELTLj/yGqvCBztXx9NyX8zWpEjQbQfDjEcaAgaddGEi167IGvprWy45Lax6lU5ilh42nTHsA6bFPiBMS4lHwJCEUnGLNEtwPVePj5gF7V7SrUHMCB/UwyB3yZ8SxYKEizDar+Udo1yXYreb1g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe06a85d-7ec5-4655-150c-08d7e1f94fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 11:28:39.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4m9ANvZQA6RTaCsVWRlsXCh6ia3LxtEIMdhbdHxyNft5y2f39Is1oQ/9ogSS3NUF39/8Kv7bg3oUR7AyUO39bZfLNKaHew/RwArCEL9jAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/04/2020 13:26, Nikolay Borisov wrote:=0A=
> Instead of returning both the page and the super block structure, make=0A=
> btrfs_read_disk_super just return a pointer to struct btrfs_disk_super.=
=0A=
> As a result the function signature is simplified.=0A=
=0A=
Uh I was under the impression I had done this when removing the buffer =0A=
heads.=0A=
=0A=
Thanks for cleaning up behind me,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

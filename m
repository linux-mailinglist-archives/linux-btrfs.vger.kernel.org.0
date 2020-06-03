Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0739A1EC9CD
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 08:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgFCGzG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 02:55:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8188 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgFCGzF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 02:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591167305; x=1622703305;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NueFbWYYobwGHyF8jdIdF+wot3VO4C25zPEti0aeqSY=;
  b=K5gae4VpQd1P5AYs2qsjF84tWExnAmbZZu7s5jgtt09JkPq4bp9d6T8R
   CWL3O16ioepIbYdzkjUsgPCdQsaKZ/vHcdkxQdAb85Z8X6GPQRZsROmS0
   CLJ/HbvQ5udkDuMythJVBvB4Cpl37pMGhQeL6sqOpfnlwxbOCJKg+Z9/z
   ZpOkmaV/4wUW2ORuCwH/bfesPYvt7D3nuvhPsC5AF1oKe0hG+pWf1zqw3
   Mz0+u5TJD2kXWmAAydAG6UfJRHG1MhpwdSnNGb8qzM4yvjunhS5v5EQCI
   6Vrf2YRliN6p5+ZxMjsewyAn1jCglTn3bso4M8jQEWB8octncvv7la4dd
   Q==;
IronPort-SDR: ZHGiKoDfAi5QG2JBhh/pLKTZGlbWndshHN+v6cec6RgUcCmM9OE+jzX9D/AU2tgJCHZpD1g/Lu
 TPPtI6HYdBF8H+Erux1uMwRnF/9cWYaEJLa6IIPRVY/7WR2Uux1MSbBxFo26oyc15ux2YodF0H
 +8UcLRr/OO3KzFuq3qRr5QE6pyAdTlLb4rrzZpHc/uMlyNxW+T12JmrqCRK0x0XjmxUzCIZkU6
 xgSDrCQWooFVS1Ey2OOyNsptxtzn1KO07yJdMCqAFzrRiEt52X6mZ+uwak6i8lhBN6TF6dYoHb
 nOo=
X-IronPort-AV: E=Sophos;i="5.73,467,1583164800"; 
   d="scan'208";a="139408367"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2020 14:55:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhykg4A9dpWioHnjoYGOQb1cP+whihhBAFWrqjUH5aX9HmH5VB+YDOoIFXq1hzacVFDsaeWXqFFSFjzDzsIXyhTkosQNpkHZfyCXWmzDW4Wov/4Z9zy2cJO1ET91+vWY7WE9xca2mPrmGtlt5Cd1f8BOn9ZmzOuhB28rsK09Pr9bavYYw51BzDTeovTSjoC4eaL4x0VRBjdIfnVZvfY/YtM6ifRUkRprpg4dmDMVAhyEK21t4SdpYRLqjmtqAagl3yFJNM1xUeH+wpf7a9JfR0JDuNQdKyZW356t1WBgoH0hbWNQ9LH0rzHK104l5rVs/91UIhijXUuTUa5pzjgqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NueFbWYYobwGHyF8jdIdF+wot3VO4C25zPEti0aeqSY=;
 b=JhHmxemTAEJg2RZqZ7HoEEb9jwA3QKsWExPoGpqyGrvMClsvQeKY1PzFwi/dr/JINJQUyoX6Bc5MHjoGX1w8dfrbRep3xPDe3ApQMlJC/K55Saq2grMDQRoF5RxhRxomGfnIRVCI8ywJqS8Ptg1o7w8K8+b9uPdPh6i96hh3+cGwjv/Bpo3KAHbBIoPrJCSxPV87KWrhtn3XjV6BOIXEHVu5iYeRNTNk5LVmKspy5y+1qaAruIqaWQFChekdfJAttaCXjwWCQQo96r+ix3a2/KyemiXzjRLLGqJ3ug7PqtDPzHXKCrnKDfu25HoHcQW2BRE2bRTkruYYK6Ubg1zigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NueFbWYYobwGHyF8jdIdF+wot3VO4C25zPEti0aeqSY=;
 b=J0o0COjtdXkMWzhNE3Sqe4wO5q4huTv2+G1XG0rPBdqu+CG/ujiFcm8H1T1DA2Q9aVAFJhaofcY+3FZxhxxjOjL8weUmH7lcQIxS4ZeaJXTuleKU/oc5N6HImQwv1FFqtxTTr/kZUckAeeC2ADkI7WcO7Tsc5+D8m5EKDHhWMeM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 06:55:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.022; Wed, 3 Jun 2020
 06:55:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/46] Trivial BTRFS_I removal
Thread-Topic: [PATCH v2 00/46] Trivial BTRFS_I removal
Thread-Index: AQHWOWvICOHNeFZs/E2JK3gjHCDp9w==
Date:   Wed, 3 Jun 2020 06:55:01 +0000
Message-ID: <SN4PR0401MB3598AAC952E13F56A87C8D449B880@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [46.244.195.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8066211f-d839-4b4d-92af-08d8078b096e
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB36802C98D83FB64DDB680A959B880@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fqS4p+t7vNJq5632j7soaNC3PEJtySqsh4D1wqNAXyF5XJ8nRr4wqf7aXVNnKFh0vRaoVGOkkA5hrd/KMnyxl0msbI5lPbKhsND5FJXQe8fkWvXeJcGGizqDJ+5B/OXAaUqu/7guC/Ql0hfoLiSTZxZ3fw/k4x8Heb3ScALX+qkXDIb+/trPRj6eD0UJzjfqugQKH6ucjNhOI6fELD5k2BFhiUgUDJqZSBu6wm4hWJcdb6TJrL+y73ShiU0iO2a+CLZOpHdEgUwAJj2bpxc5nH1kOkP4iuiejO8gwFbuoc31sGbZREAe4aMjD0MnMs6sc30AtDrby6scxWWafnWZJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(76116006)(91956017)(66946007)(6506007)(7696005)(478600001)(186003)(52536014)(558084003)(33656002)(8676002)(8936002)(71200400001)(2906002)(316002)(86362001)(66476007)(55016002)(66446008)(66556008)(26005)(64756008)(9686003)(5660300002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: B+lSc9+/evtAj/EJ2S8GSvOHME+gdjBvxi84aCFL4CgrcgIJwcQO9LOhoE2PAjvY2AwhQ3kGxsa5eIsGAiFNWRiinyFZUr4Sz0IosWVuGA16drq6MeDKP5gDZDe5HXGWKTC6ECzEXdg2A/5Byjtk0hBCRWGQRt0+9+G8NlFXUxVd+5c00sbKPHMcUaExWi6xZuquQkm1c0RhOZmNIFc1KmhI/Lv5B/Uk2j7SENFFZQbspRruJjcZ+0jUC7SamKofxjOxz/48orXbkf6Df6UrfTeyXs1xspTDWJd7Myv/cXysrxYxtjwNMNuLV0aE/XHlFRJ6kmFCBbbhj9Sn2N8cL7IeRAzx2CiOX41Ds0wb7sZpKUIzCU5HXrg1/x7fDC6CGKjf3QhpZMjsK7NL9dQndqEDY/kvP5G//8a5uuJ2fRzvqIOf04mzSVczT/mM0W0jXrC28Lr8sqkmheMynMSm2XD4CcmbUJMqETPRWK3FVPIBxnwx5kXT3QThH54Fnkol
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8066211f-d839-4b4d-92af-08d8078b096e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 06:55:01.1456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKu4f1pmpmEKAgDhHL/YVWVxsWMEiE3BZWFp+mfXM+DqKo0ecNxU/bB4F59mVYndOEkuqKn/B3U1Y2BpCPUgZqszHVfv7FgCIDe7QbBrRoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the whole series,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
One tiny nit patch 34/46 could take a newline before the S-o-b=0A=

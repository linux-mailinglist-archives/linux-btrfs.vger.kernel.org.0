Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C627257919
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 14:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgHaMTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 08:19:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30325 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHaMTa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 08:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598876370; x=1630412370;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CcrAEQxk09q1fpcdZsgyNq/41uB784Zp9otRbBzi+nbPuq+zPGTydlB2
   R8iP+OCiWpWym3LgjZUNMafsv5VB3e1xqmM3rgMjuQtukM2K64LrpSE4j
   QahFMPv31SuWk8nDbKV8gHSGh66qZdiXUCOImN3yfim5KGmHtJLl7N1nX
   4PnLcenhio8uoMw2rSUnal3j80mC888OUtRYXZLxIt/FQXsQakmLcSdhu
   5SPFfmUuMGshty8PmhUrWcq8qboNJI0SAG0O04ilLFCMD7FNVha7Ymp1J
   bnsZwNGRQbCjXXZ03YEsNItMcFVk++XGJRYkWqWV5bfhvgiXuDVCBhHm4
   Q==;
IronPort-SDR: ufuewGtL4JJ6mE8HXnGis+hRHqPJY8akNmVD/352xZagViaZOX0p5QfQuTdn8z1j9AAwcthIBh
 QX3DZRnWwVRU7rJxY3/ndiq5zt5rfYqDFnjjPRsg7cMBTOhRO1a9KA0XSmmyn7aFJXHkwtgDuL
 5M9FXxNFjXAC3cBYkeIhH+JxkFJnql3qvBF3osEIkWJnohDv1BfJ7ZDJrtRbRoRxNESpAFH22A
 scgWZ62T2DNNXYkJCDiJ17mmysoJuK932j3PpOlg1nDSf3CKOwX0JY2ZnF2poyCkXKtxIN8zeh
 JcQ=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="147440996"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 20:19:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBs4qi2NRCRrmcACak0Z79cNeBCU+BW5SNrL1b1WF6z1b9z8e4v3nIOo8CEpRCwNTvD4dv7x1HtgSVngmcIXz1eI7o3215gXQpCaP5lpEIIpzl0GEHDZvcw4lLurTIPlXpPKvA4jVcf+A9cqLUWR9uNhK/nDgSQd5VlaD4Au3O7ejl12sQ1hD5LZyAU4yOEcIQJrgwBllsM/shs2GWpYXTMlQ35GqbbXl3dLyWcq2X2bOm7h6R0vsfV3yGWkkBqw5IbHjunlSQ9iHuYyZFCIVugavSRy4xgADDEn/Eqcuxy686OEZGNaipt+esPbRqb+k6EMdK9xhxQ7NbqCLEnWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OIqJeAJqBixma7aGj5RAKzNvTWyaSOuAJQA4LlXkZKg7g8n+UBZEnj5B58uWCfsFFNQ+T89RhXYOw5qWWCXSqpTyaHBi0powoKG7Pa62C+LDBN9PHATX/Sn6sbHC7/NAxhTAgKYzhgtegdJiJXUIib8E29SxnlbOAi/dg+abZ0zikcP3aJgpNfrIQX/bM+w3Y0xcItDobUcC6qfgtnB5GOyQH9kCgxECsj4eL2JBIhTrGVoPTts3eEwlArwrX1BYcNHOtw+jCDp5AqN1LA16VxTKdZAqcxCUDrMT+lmwctpR5uBIMQgoeEk9ppPSf1VGwOtqQ5ywwG6vng8hIdU3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bpCpoogQY+hSNW0w3W64s6eHRmCK3n4p3u0VqC2XIRusVVLoRdi11O8UUqCVv+NaG5mWlyCQ/y/HcEjOPKbdO0nGGUXBoJarjzj2vDnzyt4/IgJMWOyKIi/JoO6QTDBAIIHeShhLHlae6GDaJcAeEqR1X1Diqn+dO/pWVusE+aY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3518.namprd04.prod.outlook.com
 (2603:10b6:803:4f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 31 Aug
 2020 12:19:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 12:19:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/12] btrfs: Make btrfs_dec_test_ordered_pending take
 btrfs_inode
Thread-Topic: [PATCH 04/12] btrfs: Make btrfs_dec_test_ordered_pending take
 btrfs_inode
Thread-Index: AQHWf41y+sCYH7vJpUSRiutHTQX5pQ==
Date:   Mon, 31 Aug 2020 12:19:28 +0000
Message-ID: <SN4PR0401MB3598F1DECD0F01DDF40AAE509B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-5-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c51:a08a:7ebe:d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 114b393a-013f-4c3b-048c-08d84da81b62
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB35188604AE4A8477FF10CD289B510@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IAsl6xwVKIXRTCua68k79HjlVnRftUB5ZdNhhFwHjTqI3pHsL+fWof6drWWK3rajdIjSJ+zSwryJ1AjEZ5cZ0wD1D+Mv1AK/Ngbkuo7v4C56Phw26LRsSJo5F+lXUwR0XYjzSWxBtGKgLiUVmFQfzvhf7Hej0EmyZRl8qclxrEwfR6k8GgfyWp3yN0HmoxvovIkocRobD21uAfw4kFKvr3pdE0ZtNuL1t1073n7OOVe3yIjDrSKRywppHwCZavBlUIbUuQivcS+6PU7nqRyXQwYYSTdu4u0Gtt6wS62JnApMK3xN1tXKhrZcHPrgcVcR4/+GBoeSv7dqclTSJNMpuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(5660300002)(316002)(33656002)(2906002)(55016002)(478600001)(110136005)(71200400001)(52536014)(6506007)(86362001)(19618925003)(7696005)(4270600006)(8676002)(66476007)(558084003)(186003)(8936002)(64756008)(66446008)(66946007)(9686003)(66556008)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: V6X9KynsVKsU9jqBAzGIERXPKJ5bpFjZLTOc5bSnFV9gxxvsnPzhbCBbTpUHz63vB0nTCkHgbFQ0lGVifOb1mZ2OwkPmt6teBaPgAt0yQ94h7EeearCZ/2va0KxoYY1ByZt98nouAJMFNjwbL5o9lYGdtMC3rSFO62XHQ7nM1BKLrutQ/aOWsiOzK9bH33zDetBoLYpMjlJfCVnt4rzz4yenvC4jQ0P/o4xgaQ3LcoKcG57kWF+Dqgo82666dvAKTfNU1gp9t9BFtCOroJuxfQT8JAXSYohQHlf12m4fM8KvkFJceUufd59bxESludyqvPKV4q2OlrKpfIPVOng8jQ/uFI+DlJNFFWOiBlMuZxrQPpUPulceA+2fmDHdGgfixkhaAa/eF76EhlTeDlYmSvhhldBx13S3ychIQLVfPYDRviNvhewFxYjzKhDRgfGBuv73p0yzANEpeRrif1Vt6z2WVC78l0fwCZctLFLnIepB+dGpTH4dCT0ALIC83LVg0L+4wQB4ode5LQbviSiaRn4SoM+SywnnYxD+Dd6SIl5VKZ8kUiE67zx2R0XMpCOOP0ej4ursNefgupjbMGE92ys64UK1smNP4WhipJpFLXjUmgmcfF88PymyEaxLkJs8Rj5xH9wpxPKCMcrKgq06kavlQTq4ADGybiKfz7v4pIL6Uyz9gphRkJZ8X7q9imDD8V8tpkormnoBps956leEmw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114b393a-013f-4c3b-048c-08d84da81b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 12:19:28.1338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgLALKLuV45s4i3anlZLxATqUEirTGX9tfzk+YB67+StwAax1LYsSs3wyBPTEZk4pvMU1PBN4e6bUC43cbGOBxYnOfvrbh/Gj7LExAcXovc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42851D4901
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 11:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEOJDc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 05:03:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58821 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgEOJDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 05:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589533412; x=1621069412;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PGluKrHbbo/t0QA/kJqn/XXAjkVocGIcPPnfWUgNYN8=;
  b=fTAG3rJZVI2me1ojPICYTskWzP6AuW9l1gHh67Yte5vb/l3676fIx0Fr
   GpSgM333OfVrFKvHl2vk5jhb8xS3+65g8cHtY4ghwQAmkdEp4u3KdOACY
   LmysT/MHPmU+Oo28mOtl7eTiL9Q5de0vi+LLNl9NvL5iQ3Z1saWxS5x2H
   5x4wYTbc32qt26aa8jG8velPhcEySGQqTRCeM6+Xv6j9lgMhnxj2Wj3q7
   uMUvDct7Ppxvp0udV65L2aZCZx31bwbOLhadwPS9EkSwOcAh+lms7sQGQ
   fQ1MZATGLMxWJFPO1mTCAfUbGrAFcCOLaHL+OQGF6K8BjsWaWmHXDOA7W
   Q==;
IronPort-SDR: 3u6rIZ1nWBHtEaKB3usG6g/pYl2mzx9wLsm9tX/ffDLHYTJMIPG/MyoU/+gcmA9plLv5nJ6u83
 teux2CrMyrTkVlUsmZFs01jCSjxb00yoOfB6Gbzd+cbylWP1w7RPlhOcxFoY30I9r26g9UuVcq
 cdo/iSr2u9auHwSm1+qTz6RplN7qaqEX03o3HYsKrwPBtQoLEWnsT6HIQGDZM3ioIsnvM6cpGw
 pQWl6odrX704pDgDWJS29pSijb50+Kw88xZeLihefIBZzbt+vGN/2Ae5khFuBe9hVXnYw/OiWU
 MGQ=
X-IronPort-AV: E=Sophos;i="5.73,394,1583164800"; 
   d="scan'208";a="138103900"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2020 17:03:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsNTVjBowCJse4Zohy+uNmiN7sAKbvD6Jn/zss/wrI9RM6ptGuuW79YsnMU1m1N/o7Xy/l25px2HMrR5tBZCQYo7lR8DmGMs+hfhYjTPGNcgPqiYCwlJMANcXis4c9dwzTLCKZz8pWCGFsyGXQxZPZffVj+VyAhqvi0KA47TfpzcyzE1mmijIeEC4c0OyGeA1XP5LYQ4vhabAK1psIGhfD2jHV8RTGlj5KyzQchSkBmNvh511TfvGOe0Z0Nm7+N1pbQgjDDfkNZuNpGVn8aRQu9jYyxamvaZEDQx/otZG5DTidkIBz+ZoOLBja/CJ9hIdZzTmmFuLBjNVMUVwQ6YmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGluKrHbbo/t0QA/kJqn/XXAjkVocGIcPPnfWUgNYN8=;
 b=hsTNDTXC8JegBEEX1Qjde/mjGg+aT2pd7JV/3Q7z3YQiwMF+zJxclyinCh06t6hJ75XJpjtnSFaMKtejBsK14CLUzkPNNnlM58nOk0RaBm97DRJGkRbbAVgIOFdZFyeNHkqisQxj90tSPSQSUjluw57MdTZ+5G8TH7VvD9IUvZ0qI+Ygr5zxOhufaBeXsfW0JhnWrhGeuHVyom979MJKSqaxO7USkOvZ54joGoc4uBOQTIHTNFN2AF1WuKopigsCEbRK3BZRvkFiCMuW7gSKUErRz2XFYsX17tO5k6Mm+MDQpd3p7vvKAHbtumICgswkg73B9oEQehOAOxskzJJuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGluKrHbbo/t0QA/kJqn/XXAjkVocGIcPPnfWUgNYN8=;
 b=HcHJCSFJYHeuq2NvomLEd4vF8hCSfqNnX3xRDlCiv9A+q0K18xE55NXoplfNRhsTAePSocin6p75g6cohyQbDkqxat+UHr6/tuNaN6b2sRBrXLE9driNDUMeAyf1rf9SQoXmSrMeWrwHKWwA1mQua3J2RZZWjB3ZHttW3bGo5vA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3664.namprd04.prod.outlook.com
 (2603:10b6:803:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Fri, 15 May
 2020 09:03:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 09:03:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bo YU <tsu.yubo@gmail.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "sterba@suse.com" <sterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] fs/btrfs: Fix unlocking in btrfs_ref_tree_mod
Thread-Topic: [PATCH -next] fs/btrfs: Fix unlocking in btrfs_ref_tree_mod
Thread-Index: AQHWKl8K6GclIOarbkSiVL0aew+onA==
Date:   Fri, 15 May 2020 09:03:29 +0000
Message-ID: <SN4PR0401MB35985CFC199D20362EBFD8E09BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200515021731.cb5y557wsxf66fo3@debian.debian-2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cd07720-b420-4245-8dc1-08d7f8aed651
x-ms-traffictypediagnostic: SN4PR0401MB3664:
x-microsoft-antispam-prvs: <SN4PR0401MB36642A2C48DE29CCF6DDF60A9BBD0@SN4PR0401MB3664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PW63a04D8fZ4VNDX9CTt0fCTetrzukro4832205WyoCVVCbdOixgyZWnOTLjn7bjdbs6X+uhBlE7tgiSfy5Klujv+GQTfO1Kbj0KACZ9vyioCHU5X2NwUdfa03nRE6a0LXlzLxS7g4gXmQHQsiWY9shIbwUtjwxnmdEB8GOKSoNzoJTf6gnV04TinaaWLFo8ncfBBdxQXi9IgMLZRwcki0DzezU9FHwYN3vAsZ9WG6CHJe+RNZaU/mAT34dHHglNMx2+lDq14/lnDt1S6yBoAOGWkMGPmFsHMx0CYyPKZZDlUPbFy1yskNnhRCsG3GrdPi0zFujpS/xa5Az/Foqi8Nar+RG6SCZNnH97QId1KXIuVFkxvzgAJoSWAx+BPFY4cgSNZ4ncf6zXM0JTloJQnvF7UP5ba1axgIpW3/4OnkZqBlqzPb0GKCTB7/llapqK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(316002)(8936002)(5660300002)(478600001)(66476007)(64756008)(33656002)(66556008)(66946007)(8676002)(2906002)(52536014)(4744005)(4326008)(76116006)(66446008)(9686003)(6506007)(7696005)(53546011)(91956017)(54906003)(26005)(71200400001)(86362001)(186003)(110136005)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4M87CzxJoeYz0gErfQOmqOo5i+ujF05VA+ZPGD/8mX3CgFnlBr6y6xfPQ7YzaGyst3M5BB7LIwa1h0s3er2RSJOW/h9TWEJii/7/th5x4N6K9e6xw5mq11vmL7r4q/XkLXZ5XA2GD5Z3j0b0rIaNSvKv7qTUbbmJqW73mkiM0c2qBGpr7yOyQyQArHFDkfJFUbzG6hPNzcNa+dEIMqvPsJbgsD7Ht5Dr0KeDgtaNkE8Qajv+zHUEkfDiBeU/Ki8vB7UqdFkJlAmPREsy87idy3WK9162NcpvE8mvWWRgfYfHfgM3uuPSOulIjHBW3zUIlCdf3+ywZl16oqcdXYSkZG+rHYqvPoXUZw8gk+mV6OFkqN2/b9tCAC56yLRLQJCs4ttd91TDIeK4loDByUrrBcD5FU6i57QblQukVMnTnMe+B6lS0PL6ffRqzyi2pQRzVhEwxUEQTbDzTIFcmF6gZVPl4g8cpgeKnlgWH35JZPZbFTaEHLN/pMbkeLrAIGbP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd07720-b420-4245-8dc1-08d7f8aed651
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 09:03:29.8911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtFTIhgJKvzQirIKd9aNKaAfJDaqCbtaLPMXjPc1DwOGwRn1n1md50AzrmLmNmHNgAMne8B+ccB7FX0GFGjvVBHzsrORG3GaDn3hiatnjIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3664
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/05/2020 04:17, Bo YU wrote:=0A=
> It adds spin_lock() in add_block_entry() but out path does not unlock=0A=
> it.=0A=
=0A=
Which call path doesn't unlock it? There is an out_unlock label with a =0A=
spin_unlock() right above your insert. So either coverity messed something=
=0A=
up or the call path that needs the unlock has to jump to out_unlock instead=
=0A=
of out.=0A=

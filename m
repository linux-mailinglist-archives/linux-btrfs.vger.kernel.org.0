Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C6B1EB8C5
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgFBJqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 05:46:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20211 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgFBJqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 05:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591091173; x=1622627173;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aZrjXXbgKus4hC4iYUKtffZzy/4ZZ8M7zT47F5ECioo=;
  b=LlhcmOD2PzuhXRyYN0fW8thLsKtDGd0btZNno4TSDwADVY6qmkvcgDEP
   9aBJANHIABy4JJvlOf/SW7cmpgTIyezotnXIr4mPmz4+3WHerahUMkN6f
   6MABo6BVK7QnctrHmzjUAuTi9PHM1lbRLm0mhwZ4NfMQ5spIyMSp+wxhk
   XoiTFD/7J/SvCqMcDqEhPRc9LkhVGipWXijXggjV4l1wMIFpUUouM1ybW
   bhgZFOGw2N/GVxubst1rC1lh9tMIFv/PqneHDVvUlh7wKBM4QcyQngjD7
   /ByIfvm7Phwqzy6WDmY2+PLNrjH1ZtUpz55XNha0GwO3FoRZYzz8MYW52
   A==;
IronPort-SDR: 1tp7umpaFb6zPlHt+KyGmyrXVLfc4i4Cb+gp2qqyp0syzhq19EkPauEKpQSTtBFZula5ZTvW/o
 s2lYjrVM9Y4LDKlJNGHmPjhSUCLvQpF0rvji0MSxy6gke6PrmfqAMrSNiLf7oJPv5MBDryXnmY
 bKsBB8W/hCNeseyzPiv84wbCwzx1mMYSMJVSc2Sr4GxyXbQXxR5V1QPDaRNir5iQiitT+8C4oj
 ySOZUFZdm242g4nRHi+gezczCB0jsD0xruZwZJiWv/y1vB7DSpFM9HEu8+SJyvhBmkuYqDtzyR
 Khk=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="139337484"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 17:46:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/HmNrf5HVwB09sH1mEoMhkWW+is8qwLAVw2sWYzbjNua5fQRYhZHpKavo2EPfntjE7Y5ILdsAvZo3uQWfms13HEqVxKXpn9kTQflSkv8nkEb3fulehpkBvelaO68Td1Ss4vdJzNqHskp2Kg0IKpuDK7H6Y9vB7VjCEZWBRSIeFsz37sIqlOmoVFbTPaI3LioafzNf5adJ86LMJWFxb94wHw/SOQjsSu3w3jvT2rrDjnoArwKKZRAObwWYKTuX8JmTuVp6xe9ULraeCDXqFdBBsy6TDR/cVzySTvWo4+ENJ2LHgQlgdhToueI6Z2c9GJOCf+EOJI5NCabsy/tDA/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZrjXXbgKus4hC4iYUKtffZzy/4ZZ8M7zT47F5ECioo=;
 b=ViHXl82fRO0WsBj/eWQLUF+uS4SWd7R1C2Wy4KNwW3ChC1+UGxKUB8LzapY2n2XBr+wzy/8t0d+vFVL0WYPltaUscMko/lxYa0K0ZCSlfzMMUfd3/MBYPtiC1D4kXFrZ1Ok6ZmlQLEiTNybznkioTSsUzzsYQ+GnHQwMD6h0IRM99hw/+H+oMkF2VPqvI7m25LkzaitzgbBYKfoT5+tDeq2hmxmfIChA4dLk4sYD8XQEE4R7YV4YcxYPHQIecTFZt9koL9hQ2iOngpl73a1GZ1Fd4BPBpH3ZPZ7ldQX5+mAa52lp1W9BxGZytSY/cfYGKgNCOrgRVoJd1jmNOKdaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZrjXXbgKus4hC4iYUKtffZzy/4ZZ8M7zT47F5ECioo=;
 b=AsEc7X1xTB5nq4Fp9xsEsYp3mhCA6dJIs7PcnxEEWsLYEtlGQYiy+JiWNmUZU1OcuKFWQEAsVwBniH/wEkXDJjru8g7pmUGSrKdNyaPe3sT/eothPUhPA8apZLkJzve+3sNvw6AW1Q8YDqOV8sRqRsk33k/HUa4htGJqCQ5QY0c=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3551.namprd04.prod.outlook.com
 (2603:10b6:803:45::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 09:46:10 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 09:46:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/46] Trivial BTRFS_I removal
Thread-Topic: [PATCH 00/46] Trivial BTRFS_I removal
Thread-Index: AQHWOCqelRyR6tk5JEOosaWku1xYiw==
Date:   Tue, 2 Jun 2020 09:46:10 +0000
Message-ID: <SN4PR0401MB3598824C8AE02453F8ABD61A9B8B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 055b0d0c-250f-42f4-b5c8-08d806d9c812
x-ms-traffictypediagnostic: SN4PR0401MB3551:
x-microsoft-antispam-prvs: <SN4PR0401MB35516B4EBE1A6789079072789B8B0@SN4PR0401MB3551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6P+wd7vIx/rFfLC9IGQLayrxODwm2vNKDgt5Kbn+vgPbCB1PsOkXiSlstr+PEx2DqTd4DQQGnol+xpAR2/Ig7iVCFN4WOHs0BBjwfo4hNh6KKCxJJpYr8kmKumQ+jGyq073c2AENqbyZMusjfZKBvmGLTxRlLekGCSIy4RDwu7Jpr2Z5wfXTn9FQ45JwqaLj8ZySwIfmUlEBE9ZC2M6PJ5BsoAG9ejV2ORCL79OWsK9FV/0FafOHXn5au39N0JZQRDAsHl6cNMH4upefTeFYnSl5eEw8cV6rBY9jSswspjo1Wqb5rb1bQpzeZIaw/dwiE3fMvytl/XSvuMfys061w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(8676002)(186003)(86362001)(2906002)(7696005)(52536014)(9686003)(55016002)(110136005)(4270600006)(26005)(316002)(76116006)(91956017)(478600001)(33656002)(66446008)(8936002)(5660300002)(71200400001)(6506007)(558084003)(64756008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1JE21TkF21CMHRuwJtgyZngDFvnaEhIaWPzwfDVe125qQvxBVFLpY2REEh5tNZyBJS0ig7UXmRK0T7RCg/XQeFGa1N4WxLdQ4LUGGwQG5VqE5Udi1TBk9sAANXg8hUUosatc/OrSG01kvfcqYiZblQ2xbXZWyM+pL7pZgvvJbzqJRrorzG+BlHwYgNob+QZfMdAmAedSvJTRSWKcI695lIyF3U/af6nhkjvKy7kKvyRjaPq97Obu+t09LMds+zYiAP7j9X5bQdLGQP8MnYHG+24JMKmkN949wJ/RwCxfpVih0fpn6vnEWk/mCJ0n3hCHAIL5uqhKZgtBh6+o7D37hZBG4SeIRRSiVy0GlpfmxPeRWxId2+XMaRRdxYdadxyPA5ElHiWy5WhS7HTCYv+8XoP/LAgOJZlmPbIj66sfV/ggB8Cj8DcEme02XFuV58LiMN7B7LkIZf8kxM8FrAnrKcOTY1eQ74VQZVkfmY8MPs6jnv4Ss+x1GWFd1IIsgBdm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055b0d0c-250f-42f4-b5c8-08d806d9c812
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 09:46:10.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ip2PqfuGJcs8307caCcIQFdT/R1Y9AFwZoMKU1nijAkeQOG9tQlfx/iKdt0m5D6uZWQk5Yp1wK1/9fHq9Lp/xhwtcA4A/jcPD1P/JlaCj5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3551
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With David's comments worked in=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
for the whole series.=0A=

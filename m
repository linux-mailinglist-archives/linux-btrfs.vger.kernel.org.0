Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4E326A110
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 10:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIOIkk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 04:40:40 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5001 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgIOIkj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 04:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600159263; x=1631695263;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=TudXWoeDhXh6LsYLkAWX3YL4vuh/zeeBnTO/FRH+k6i81Tb2trGJ/kFs
   gckMZ5xWL6g2WzGu8PTo2n88zc3GLYzY+Xx1q1dXEyTe+MshbOvug2aBV
   fDa8wi6VLSdek8QUmR3UnO+YDBNMlS57vvkauMLu3xseQbbq/9f11e9V6
   hWFtElY6HYd3In0JZ8/SGGXy5u4maH1QYoO1wgHDhDQUBsJUwr1QiO2PU
   CxpNxKbiKbgy+sKVuj5eCCrxtAoh4Ly6ToKi6tHJZ4z07+3mHrdLiuamn
   ymVQtpmZo8X6MUamsey8hPhRsb1/weOBBiFBO/9U6tf+XhPxQaDwqplSJ
   A==;
IronPort-SDR: 5JcV6l7hlSSQ+Nzyh/yIJ1Gc4Fz0Lm0s8Cok2BRInoFBVti1linN4sz6bGJiDBYIq0JvT4qOSH
 ugwSkMhVqXape8JAmQFdeplzxtcvnjnXqAABAAFtvrG0733G3uE0l4l8S2E8bpHgqSpQZNy5nP
 QfAgsA4YZMAFg1eolNHoz1yFDQKkJckuaA8UPeSWTRqATXcFbMy++VwevbwhRdozHWMbqhfaIe
 5CTvl6u8C4czWBQA3UKPWyy1WWnGRzaNoTSmZxVWOUf/56pDqCM8kmjPxfiJ+CzwgSSolRN92T
 YLI=
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="250728664"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 16:41:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwbqfLxygBjiAQy//wYUv3abNcLHQmOZZAoWphssJpH1LH/8QaOer9uW1ru6nJwNqQOcnTjvbok5fpewQHtyJMvG6/abXZYkY/5OlZa6ffTc+XBWC8Sh6sTPXolXtIpxTVEQisjVch3DDxZle+rXCNbyHEQWJlQYn+wjb2WairZMNiZTaZriX3Xygu2DH/VNj49hX0hKUcjZRUgRJRPQql9cOo09BWZEHb4M7MZWrYIJPJJ1jU4N58jRvoQHU/lr69oALMY7egGdXuhXvpfZR2zCz0SChWUDiBqr9ZYAlaY4II5dyaIVyNFzbvvPfoicZ4ehHQO90Z/AS+XscYC3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=U76Z7mHAymB75nbNcHS2fPwv4kkw2VbIfWVouFIeiOOXfL91KXTAcT1kFjZmOTjJOb8s6jrA3pJITu3UmwhB1a3tTBoZZhJdRyxPzMtG1ASOCSUWsQGSrxigl71Xt27DmVvPrJ0ZLjKq6nW5EiD8kEmG+R/aZF+StVLSXBFywCQFOcBTJ9UZbgoBJCGHpah8cykBNXdvais90LEYiAc/FemI+p5bDFJHzdALOQqCqd5dwXjC9mMqEJQ8ThkeQ/YW3JQWzZxJ4dsqhOTfv4X/5jirc1zFfGKYWJRdU/02f4BdrlYLMJLbWwao445IdQoeEHshIafQLxe1fYrua8xF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=Nwi5jVfCh+D/hXD5R8r7ixMePkb8qkH5GvpbwWEAMu/XbfkxFyuyH4KCj6KlXof8d9eYlQ6kW7HyVp1x7vnYwhGMh+TMnZcdNU7c/HDgHM0toh4C/+L5maLhidmuTvoG7kkkAhe5FszWiDJxSyAxa7tKdsEbpiIxfxS4o1cgE0E=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB6459.namprd04.prod.outlook.com (2603:10b6:5:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 08:40:37 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 08:40:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 04/19] btrfs: remove the open-code to read disk-key
Thread-Topic: [PATCH v2 04/19] btrfs: remove the open-code to read disk-key
Thread-Index: AQHWiyIVkEZWmxHVQEeIKGSZfmz12w==
Date:   Tue, 15 Sep 2020 08:40:36 +0000
Message-ID: <DM5PR0401MB35912F7132FBA12B55F6657A9B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-5-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c70496d2-6463-4f96-af8f-08d8595304d9
x-ms-traffictypediagnostic: DM6PR04MB6459:
x-microsoft-antispam-prvs: <DM6PR04MB6459C4BECAC652105DC13AA29B200@DM6PR04MB6459.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysJ/9KsveitMBeSCgdgL+jtoqhGnU1uTi0Mi0uxQq39wh8TxLr98w2dWgvIMk2Zdvc05HQSm8cvFASNOW154tpjRBnV2cYD44f1qt8Y7Tjk4LtaU/C4qF9wQn4BjZJIRz36rlahzbI7reqDqL4GLtPtlK3nW3qpNBOvwMyMQfzqkKH3ZrMwSSRXs3dMvVEXLUsonKlS1EGImXxiLcn9Xybw7dFYs/LKBMaTR4Y5SNLCwURXxA7vHagPwIeDvNa0xL9mF7bG+Kj4EvlqmtzMNyntHzYOBLxqIq29opjkVE2X5d0zCgu/kTJqSNfhm82pshkwulFZBIOG4cG2N+5D8Jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(186003)(478600001)(558084003)(8936002)(316002)(110136005)(76116006)(5660300002)(64756008)(91956017)(66446008)(66946007)(66476007)(66556008)(86362001)(9686003)(7696005)(52536014)(55016002)(8676002)(2906002)(4270600006)(19618925003)(71200400001)(6506007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: K7P+1VQM4Psjwlzhvg7ia5R9ACGHalAlMylfnIEeycIk7lk9J9HAyX+5dbguObmvoHibj5cM6FSd4HnQIMXRGXBun+i5WlYABQnvxC7GKdzlLVFQvgOyC5iCr+d2k6/+RLWoQrTx4FJrfElr6jWfkbCocEsakWUemwKrYSN32qaEJy+QiE+dsxrK3BRvaTK2Cj3EAhrI+Kw023qv7UPLMyaBRyqriS07pipfSsuPmGCzxUqszMMiovx4PquY21lhes/Nsu/5Ruwgt4t5pCK3xaCXko9PO0bpixMkUhmx43/zn4g41LB5HF1ITM5lE62ZqnyFiTWoHDpJpYdLCjEJtrW3iNY73C7nk+IokidgvpzzzW/c+LrNnioX7PV0mLp7y7uh5BMzYBPfcINqCc+qUQg/XBwNsu35gaAjoZd3OgVYx9zzoZ05t15+8e7suFkdCvCLJOx/1LAF2nSfBbyj2eM25+OnD7jgBvKW7/MY8oz8L5L3oREjqm58Qsnk8t1/MAtqx4IpUy4epQqcO/dwu7+698FrZnhU0lZ85Y//qSNTidKE3CUPYTbVHf7vwYVXfs5ya/OIuUu1GcpNeT1DrsR3npd30F7UCvgw4qjOUmvTlDuvC5Tdc82vjsYVh0fGFXCLz+JpWH3HJD0MBAt5CsRwG56MPVq4MW9CNcX7BPz0vMJytmNX9xHUdziKlK4GVCwyl4j9A4sxrJ6w/lVpdQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70496d2-6463-4f96-af8f-08d8595304d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:40:36.9578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1CbkvKeGZLSxf2dFGRYHZnQ5T0OcBNn5rog0tS2vwIsGO0TOT6ubtydT1SvvzGsDwmC+ukE1jgbmkptMGWdjIPTFGR7tG+Wd3XunEvbZFQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6459
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

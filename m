Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEB015BC43
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 11:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgBMKAu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 05:00:50 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29674 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgBMKAu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 05:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581588065; x=1613124065;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Z75GaKjiXppWssTRk1EEDmH4P8fLiB4gdd53bQc6HzY=;
  b=n7ccg44K2/tPgiqc3OEmMF8pcUvHmqK6IS5a40XADkMb7jmU5OXShoLh
   nZrxDuZnN7cZHua7793hXHNaPeVmgwE4fS+wnRGeeXgppzG+1BLoPF6Oo
   efL1bvriziHD/qXl8GLNaw5dBVKl1ymSLbhaZF3rmYOakRhyxQyO1o8gc
   SfKT3eZiPaUP8aMCmA4jphmkMxrsbCAeA5NqpwGLxOKNdNuiZIJvdG1OE
   XoiWzuUZw+JTXmavfGC0tkt1qL44r0mvbvwlwBkb7UhL01DdOHAb//s0s
   dTmT0IgVs+4wPW+ry7p8okKnaubyxoCO/SBB/IsXW/AT2NlyU+LvT2BPe
   w==;
IronPort-SDR: KP29npsPcACJbZJerH89XEsnO/g6jyXdsLejAoXBNthclQdumBJCu4d1pf2pKRykcNsXX+JFRa
 YfKUJtGngCJwesl6Nh/SSg+r0u0zRbH1NnP5W6LPnPGEt3JYiSdJ8Bbt/kwUiqVwAltoPx/tX4
 81yLMNY/ofzhgxFS35bndx5HUbmqZwE0xy3swaDxOFCNEvi8QxZnQltmrJBiIfy0EKOwihezLZ
 ycvB78qOwGl3aJb9ydgWc1lzDxmrG+qT8CzIc7I4lVs8I9xZqQ94a+raGv2cDXly+CBJB93Qel
 lIU=
X-IronPort-AV: E=Sophos;i="5.70,436,1574092800"; 
   d="scan'208";a="231564191"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 18:00:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elTYfjRsZ8P8TffZ7LsVeW58m6OSU8CngvffwPA6mea9Sa6tBtfTYp4My42lMjTD0VBasQXPKmS35+iIi/Yg5QnwuW1cf6VCkym6M76zB0WCPW1Z+YEdqg88X+B43MmHs/TztfE/kpdM6Ppzx+fJTLNiW94jnaiyuflWDtmN30oqm2CIiuQzTmZvuQlVy3fCrV641b4yJeifuh2htyast3OfekiTrGHdivpcwx3ImE/jjU6iz2QpaX91GncZ4SQyl3T4JGSrCvlYZFf3IvS+qOrcQM0cUyljHOH7qtvVS5h0Qzx+vv0kHDVLb6lJnGnYT4OhzYgKY06mIBdbGZ0aHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z75GaKjiXppWssTRk1EEDmH4P8fLiB4gdd53bQc6HzY=;
 b=W7FJom/AmAPSy8MNs6PjCP771XvwuANtxRyuSPbFeHS+tth2FBAxy3Z2LVGFJ2mwISP1BcxVGuhIXIkBlDkfdlMbBN/4siqKXiYwv9shIkWAC7c6aneykk63n0RpSWM65HvbmudeNGgOfS26cbZ7oFbc2Ud1hxVT9K9MSgtYf/SZ7XuDcbGiV4azdyx5z+lTkfb1YEMGDhWV0vEue+XfolFVD4wgZUOMbuxe7RaIY7E7DEp+jSzcLEhCPuAnaD/dEBXz9RG/BRz+A5tTu3teb7/0TDLAiSKoceT7mV0i+NDvugQFghkY6ArLedblMOsHshl5GEA6B2PjIeaOtYOQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z75GaKjiXppWssTRk1EEDmH4P8fLiB4gdd53bQc6HzY=;
 b=A3n8FtxD1J4CsmzWdnLnlRIsAFtGe3i+DJf7gxCzgjgJcjUIIdgp1ddewkRTxrziN9M/fyp/GwBNOPxicoWgszH5KT2SZ+lRS7N1y2CN9pvknAWS/xlZ7jpkUvb1vDCycOQOLJMTTTQ8cUYRV9zucP/zgeFqjwD4mjcksBsx3Gc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3662.namprd04.prod.outlook.com (10.167.139.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 10:00:35 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 10:00:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: add a find_contiguous_extent_bit helper and use it
 for safe isize
Thread-Topic: [PATCH] btrfs: add a find_contiguous_extent_bit helper and use
 it for safe isize
Thread-Index: AQHV4dOvMp/SWsRxQUSNWk1nLAKB2w==
Date:   Thu, 13 Feb 2020 10:00:35 +0000
Message-ID: <SN4PR0401MB35984EEE73766E8035D1E49C9B1A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212183831.78293-1-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4604d5c-caa2-4351-9758-08d7b06b922c
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB366229A52F7694BD1E09A1969B1A0@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(8936002)(6506007)(53546011)(55016002)(9686003)(4744005)(7696005)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(2906002)(52536014)(66946007)(86362001)(5660300002)(26005)(110136005)(316002)(478600001)(33656002)(186003)(71200400001)(8676002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3662;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HweiM8eMPWLDmJCH3Fc7HoavAmRIMx0s+vkfCxmBSrd1jW9mZUvMDutAcPgI07gDE+i8ZsEOCE5GSGf/B3+yVLvlmVuj2A+RpsGiFbswnweoToLAl80xri9VFNIAEiiqgZyLHVmLQipJRN7FLfP2s+unMUAUB9YtALPI843y/LFnpMZblfiJFdQvgcfidjqhbMyuVlCVWzdgm0am+JN431AKjdqUKRE4iwd3hnkTzEKBRKCRLGrzFDcCnvQl1EaN3QBkdqSPBoKD+Zb7Ek/t/NLyyUuwcdjEpQAbJyZtG3q1abdOH23gJ4aWYJSkSDuBAxuwWz/6X1ONynmGD3FDw3HTcKig8AoEnfpn+OEH6zAH3MwvwJT5QcFAd0EOWsg3Rjlpd4WlspgupLm5hFL6ghY8LdnxUHJN+nrT1qsx0HFwf/1EwcnrgfzqUHVZt7AC
x-ms-exchange-antispam-messagedata: CN8waQzl6Mve6SMddUrtzgduCUee5yD7TDEWuAOJCdNYuhRUq4qQuhhL1Fbu34PmjGZIfA/lO9rXIgffwOtN4y5GXUCJRW8LATzDdwJZRbkyB5ch7OK88MfwLkjlPZ38QOVsKogf02X4uTFRdzg+eA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4604d5c-caa2-4351-9758-08d7b06b922c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 10:00:35.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jbN9biT7leeP+2LKHXvprIDBR6/KxKJACor+c0D9RIypxIAkfctbzkyJmMQKJhls2OmUsUAEUck1WBsK/AP7SIQZctHuYK1ygISINRJDsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/02/2020 19:38, Josef Bacik wrote:=0A=
[...]=0A=
> +/**=0A=
> + * find_contiguous_extent_bit: find a contiguous area of bits=0A=
> + * @tree - io tree to check=0A=
> + * @start - offset to start the search from=0A=
> + * @start_ret - the first offset we found with the bits set=0A=
> + * @end_ret - the final contiguous range of the bits that were set=0A=
> + *=0A=
=0A=
Nit: The above it missing @bits=0A=
=0A=

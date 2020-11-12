Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9704D2B004D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 08:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgKLHYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 02:24:45 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29437 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLHYo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 02:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605166701; x=1636702701;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jbt/mX5U1FQXJEhp1sJFSe0tJ4W9jWl7Yxs4IMttVNE=;
  b=oMtkBbj9NZHBJerIFJlKWdhoLInBxHAJtRcIJz+xWjdPcLk9b+XE+pwl
   XTj1r5A/15wFq3wQfdP90M71YIPyBm6B9w5wNNhfHti5cEldredAFScuJ
   o+FX5r4BRE9m4YX2wah5621QS2XKVXiRUQMEBhFrEiabGsnaHbnhPzdqT
   Zav8Mt5PDqaFsDMQbuJn3ECqoRdDUyEvzAs7OTAgceze0ev63xRNRdeOU
   /nnvAKPWYc5SGdATFOOAdvb6A1tc1VsW/rQLX9VzZyLstQKBlbK6UxnP/
   eNmz4cQF3cfZDMXH/MQNQZHZGITK1uK7NLiwZCih1apcU2LS6cSHgTtCB
   A==;
IronPort-SDR: CCdtSRKPJiJcNISX4e9mPCKyHdbxmrKjMf0kIRcXI1kYVyifjqSwcm3ojL73WXjFeZWMdc8bap
 N0uzJnISOOAjdn45xuv5WCdD5OcDeHwGg5yszDfjOEm05RPyyDQPsrMkqvSfPu2hyObbdp+bwu
 olId29x5alUtfAY2fLHGotMl8H1PDJbjtwshpeR7s7ngkF6aWLFj8Zda9O1+gQHEtbD8rdomVQ
 +6qO+nGYC7/n0PWAYn2LwHaWzKjR9kjGj9wg0KiogUUNvDu6rLqNwHPLLDM4m7O3nnX3uaSXWf
 IZI=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; 
   d="scan'208";a="256027282"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 15:38:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fvb4qhQ94rVw5FLW7RKymxUeeA8IdCB8y5FkI+xBh9irj6YZo+WYjLkGR6QHBw42s8ervPGHRQQW2IYPQMpA1623BLxrRUKY49Xkg7o5Bw82kC6OULElGPP0o1OL1v6ggWuSXR0QvCFHRyhWBfdfUxs+qhURPvAe7mm9i0oss1IGC/XPrPLg6iqN8YWVvXSiWlAQaQGZSnYi0luZ7hsocaY/G2TLRcZrPo7izkeD4C6lslLPbZ3AlW9HGVqyF33aXxK6Yn81vkZYbHie3yobyFSANaqdR8Kuj3sMX/QZdivaAzRGlZUgdBGVqaKMNk8bAXb001MxKextEsqxkiDoZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbt/mX5U1FQXJEhp1sJFSe0tJ4W9jWl7Yxs4IMttVNE=;
 b=bEe5dalufo/MCmhcLgS9WrI6RMSJKhN7e7qcLtelVVBtvblFkhMlA56ignjq94DgXJ728s/gTBUcBVrVXESDlKSF4cZF0Hyx7SS7FrPbbYGMF536PKxKTbyf/ArPimFSHu00cFHTf6V8XwCdwXxRqGGjz2Hm3ClLXMxKq/LbUuvaL447q8lI4XLrAs/NcZWtHcA6tgM9kiC0elbhMYj/DIqKd2GswoBixw34eEL8z0Vt6QdwRkh2sexabjHBdnIkaHIGUzccZxtspbmy9VRKz7PWIaoqVOsyD5/4Ge3mMVIFiHkEvimXIbgr+Ey9mFJay7G0DKByxjUVtSBzkwJgFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbt/mX5U1FQXJEhp1sJFSe0tJ4W9jWl7Yxs4IMttVNE=;
 b=G2R+nfKnE4rEOROEAYnsV7fKEkBiALtUtykYpjdUdBdH8XoaNGTVnDB9rQmRk4MqlWzLc/Mnoh6HsYaF2w6DOpZnGxHbBk3/4iUxDsPdFkKYj6rdSVyNsc2K1GX1IJyEKJTQ274XzyD7oRq+P+F5gjHyBQnfe7OSk6tyJWqBkSM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4608.namprd04.prod.outlook.com
 (2603:10b6:805:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 07:24:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 07:24:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: hold device_list_mutex while accessing a
 btrfs_device's members
Thread-Topic: [PATCH] btrfs: hold device_list_mutex while accessing a
 btrfs_device's members
Thread-Index: AQHWuEK2+yAEqm4DMEeMh9rJtDxbRA==
Date:   Thu, 12 Nov 2020 07:24:41 +0000
Message-ID: <SN4PR0401MB359852C46EE68127C7959CD29BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <3a6553bc8e7b4ea56f1ed0f1a3160fc1f7209df6.1605109916.git.johannes.thumshirn@wdc.com>
 <29aebf1e-4684-4003-44b4-c5e8846b69eb@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:dc5c:505:f80d:76bc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b43811d5-d684-40c0-4fe2-08d886dc05bc
x-ms-traffictypediagnostic: SN6PR04MB4608:
x-microsoft-antispam-prvs: <SN6PR04MB46084B876CA450B9AE579ADB9BE70@SN6PR04MB4608.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ROwIpKeyZLCSo8IWaZvtAFb/fURvTkskRSCw56bLis5+GPowrNAbeFP1aIRyuSK1UAvfK64UMyoch5W6L9rVK4e+iKj1qq1etVYmwhM6nomVRwLR5DzM4LG+885rMDRcp/19wedd1RqW/zzSTOSCk+g9Q0p8Tq2b9im25oEPmp4sLIPpip/8pc5D756LWE6Tz8XV1AU4M1Efg5eTxjXxy4p8fzvXDLfXJwZ8Jz3tDW3sljBiaMOBgqry+2as6TmIOWOhpaOi9e3TO4ytY94DqaVWG7+85ssLswWVayinWzC3OJg9r3BnwN7yPA7G4D2hs2z1APwWAK6jPEdnKV2g1ogSCkOxPCCnJ+vLZfaxlJvxox/5lYSGmCpd9r5Z/HGeT8gq381b1g70qt/0M7tNqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(966005)(66446008)(66556008)(64756008)(55016002)(71200400001)(316002)(66946007)(33656002)(76116006)(91956017)(53546011)(9686003)(4326008)(86362001)(6506007)(478600001)(8676002)(5660300002)(52536014)(66476007)(110136005)(186003)(4744005)(83380400001)(8936002)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0vM4Km1atK2/jIj86SFHkP/1ip+b2pB4dmej2Q7y8vV6Z776s9W/ziGTylzC44MOdfrqd68ehPMyhARY5/riDWix+CD3O0R91pEfwI35nOCpLvA7Kwq42kGMEEK/Eohl4qF79xqz10TBN5MG0CAs6JrmwhkIqOWq9w06lNocKI+zGVVziNnpXUzdI8PVZ7hC5rp18oPlOzyhuMtk6X8igE9zJwtGdVE7DIquTHyQlOXRtjsBbAFR9RkrSjLMyMOZcmTlccJ5Ep57Nlpdq60rFDc4GCCNyvFt+vM4n3WxEqOLT1b1KnEO/MEcRUhMF7iqQuNcSjWO8qX7zXcae/zya22qtJUqmcO2LmE1ARJ2Ph+6P9I/iZizZ6QRXd6oDb1BX1DdEb+JvkU79qm1VGcPJK7SLgqnQgm+rjQPpTTbx9e7N77JJlnpwF14zEjehPNIoZsKjJymXmb4x3dhOh/NyQZu200GETx6h0XzPAkVlXAqP7ckxpv8Rnjx/wDX+mQKkVx18qvv+PF5WT+1abkrIWeEUH2pNvzO/SsINhuOKGLEARQfc8yl5rwLIgosn/HmZuRSRW//dsWvijbKb8OUmL47jOX7YjqFiPrK5axlPB8DWlYyQ+DohPy/YtWiX2BC9S612BhpDpZaSqAcw3wxGFvo+l7IgmU5bMxX/n1rc+e/qsulC1Lt5+hEuuiQEGG8TxT2k1NLzwEhTg3TdzE5lQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43811d5-d684-40c0-4fe2-08d886dc05bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 07:24:41.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60ji5UAPp6lqCjv78pFBH1lJjRtQYrW8jMOJrFTaR7z0E1+a/XOROqGS8Wkvg6KPqjCqq2fFx4ZTvIoMP1h+6VtfPrthPj/6TwnC99g4aMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4608
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/2020 04:09, Anand Jain wrote:=0A=
> On 11/11/20 11:52 pm, Johannes Thumshirn wrote:=0A=
>> A struct btrfs_device's lifetime in device_list_add() is protected by th=
e=0A=
>> device_list_mutex. So don't drop the device_list_mutex when printing a=
=0A=
>> duplicate device warning in device_list_add.=0A=
>>=0A=
> =0A=
> The only other thread which can free the %device is the userland=0A=
> initiated forget command. But both this (scan) and the forget threads=0A=
> are under %uuid_mutex. So %device is protected from freeing.=0A=
> =0A=
> Did we see any bug reproduced due to this?=0A=
> =0A=
> Thanks.=0A=
> =0A=
=0A=
Yes and no, I've stumbled across this while trying to fix this syzbot=0A=
report: https://github.com/btrfs/fstests/issues/29=0A=
=0A=
It doesn't fix it though, but still it looks odd we're dropping the=0A=
mutex and then access the device. Doesn't harm the other way round.=0A=
=0A=
I take it's more of a cosmetic fix than a bug fix.=0A=

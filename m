Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A60925BDD7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgICIus (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 04:50:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53994 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgICIuq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 04:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599123046; x=1630659046;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rB9J8J0s39PIlERHm0baPJM5jvgcPyJXjwcoWCL5opA=;
  b=Mix263G0edVXR1c4Rsqjlh+MFEs+j2FrA+nvyWzoJM30Km6t1sEEFRAN
   dhapdi1A3u2n2mtrMEfZUsewVglVMTkAkQ0xVQqF0h6KFwmkpahN5s06q
   ivg+EDIoPZ24vdUmn6av/18rLWBJAgg3Luyvy6t1DFfbelpkUCHuBVSwY
   WsIhSf42QNcziOKzPanJnojw1vCX10L7jhc8WC47ZZGLBsO/TAlieTeGs
   fTOQPvIjwnm1/OwDZYwka+kx/Fs7b7aX6AwiCpGoZYUBLYfsgABQOVKFz
   9V2dDll2WiakBLwWx0KG7qhUHUvC5xWGApaWZvEsf//Gkgoo+IvyqmwnP
   Q==;
IronPort-SDR: XwGuFD0s27XJfdsOA2mADA4/eyMumg1ArszifMnTWt5FEKaDQUNW1Oyyt2UIJJFFoT7yikjj2t
 JMdU+ex6cgIT7kAcLVI3iH4O0Ns8+0fZZQx6TtOBqrqTum2ziPoWQV16duEGGpge4v/zqATBg7
 +8yooKJPD/5DlFMWmqoimS+a+MTzG853yjrHSdYqycPiwYI6QvN/XDa5SfRM3BbfQ8mx4UPyPN
 l3Jo0NIFkPl+eXMmkpWAX12ZIEdVNOhhuLP9Iq/rYGNAMI1vapIKCTzp/uQfLbgeWmLPXyeC6J
 GaY=
X-IronPort-AV: E=Sophos;i="5.76,386,1592841600"; 
   d="scan'208";a="150828328"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2020 16:50:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA+5vaKgffT01kisJlT2PK3iVrwUZaP4VqDmrF5d86ziJj+m9oxKoTTrtTur4TJrVzXC14gM4tdQfreRAtVhaXGub36GIGGZaF7lwVD5PSfEDapSrlQ4dL2HNI4vt80V4GaL60z4cMiG8j0t6RIShw1UNc5O5szND1AHw8XKPlUbDuD2B3l09zGDJXA4BdfzDRn5QqIvJEqfNEkvAiiWXGo3Jou+P49AKoUWaK55cQIW33mUl3QmPZXqDTzGOq4eJ20k1RKos/RwEt8p2ot17y8VrUh8frY1BaZAxgyTqZOgEKv+6RwL38c2FVt4etSXzTlFQiztiTBJyVlDw5+U+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB9J8J0s39PIlERHm0baPJM5jvgcPyJXjwcoWCL5opA=;
 b=dnP7XRvHr0ZP6qBsj+85PX9wifO92cQMn9rgQqgVNEtv9kXKzBUWCjF46hZjoXOMciOfTic/l62JHA3wgxySLJEkcFY+u4TvAFhGQJVBJ1VnH1cINALkDABHPOkkkk3XuSRaXVY1QgUkigG4Y+7acK9uaeM2tjiHZzoUyUUOBMAxspGm5gHSmi/K/h9aNXEGOOXQLdK2jfNnFLtuICbHCrdsGDKtFsYuv/+yUyXAjzMyySaJ8oBdKFYrvaOMricAWKIvluXA/VeRNIT8IGIyYoe3he0VFPWDIuTbUKm4+QGqaTYC8TIr+73Cx/se0wPIQR/H3I66hhvNZ5nukqYJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB9J8J0s39PIlERHm0baPJM5jvgcPyJXjwcoWCL5opA=;
 b=iFovBOoTYTMu0lKICsa6WZZJVT9ll1KooEsaWDYDd1KVZOMl29l2+RFcVYjBa/wGHmHQNu2YkAhg/8Scu0hqGMkHv8ErxCWL4fhTU2ORqjKIQW+FOSyc8l7ctbvqVboE97toS7VHNG6wtLXMhIN2H6hBp6OBg998EWw7L1HXvsU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Thu, 3 Sep
 2020 08:50:42 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 08:50:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>, Robbie Ko <robbieko@synology.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: About the state of Btrfs RAID 5/6
Thread-Topic: About the state of Btrfs RAID 5/6
Thread-Index: AQHWgTtjpPLWJX7Ul0m6FtDMpVpYhQ==
Date:   Thu, 3 Sep 2020 08:50:41 +0000
Message-ID: <CY4PR04MB375160CD68787A04EBB29ABCE72C0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <CAEg-Je8OsZjWU_ZyLJHrbOJb=_C56MOmJ5w8UUbzz3JNuAi5Ow@mail.gmail.com>
 <b9ceb790-e376-69b8-0648-56c9a026b40c@toxicpanda.com>
 <SN4PR0401MB3598C82C1186CA04215145489B2C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2140:944e:7181:ec31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9f90800-dd7b-4d28-f05f-08d84fe6706a
x-ms-traffictypediagnostic: CY4PR04MB0968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB096804C8F48DDA46D907A424E72C0@CY4PR04MB0968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qtdlFgixtwjh76/zQMr54/uT2bDqMLrFzIrN3yGkW8Ue+IKUOtMTSW5gpYX7BTI4Y78ircFguDZHXAnW+H4ujQ+GGvL0KK3JnYTeG1icuYqVP3xoVGESp4eah+ZMvKplKgA67BxONVLCiqOBHriNrz79pMBIuLfKE0/ZOXzUsPfq2bgGrVdwmvgvJbs6AACxXIi+nVl+Tblp/DUsvo6B8RuMDRK+HN2xHscImXV89LCWnuip7XfzY0Jjc200m4ATxCEUhnWTGlWurZZ6pWrmrJjqvquPFZrRSmallmhkWzizH81KCVa1QV8+Dow5w7oUmLLyLZH09GmOKqIBEh3RA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(4744005)(5660300002)(8936002)(8676002)(6506007)(53546011)(86362001)(186003)(71200400001)(478600001)(55016002)(9686003)(316002)(54906003)(110136005)(2906002)(4326008)(33656002)(83380400001)(66476007)(52536014)(66446008)(64756008)(66946007)(91956017)(76116006)(66556008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LE60WKWawnXUO5HBpSu9/Oy99GhhQSQ6Cwq9Z+Ys/uT8EhkUwBqt1iufY/ZUhGWVGN9LH+YGFTCTTPvVS6AjN2GBVMH6puiue/OMu/7IJeqhSUGUCL413bkX47DeKLpPWHOD1R49kcfUm8rntPdPrZPxvwcNoe0MSWbaekHakNqwBchRDmUEl3oKtBntSSbYZzK6kQIrS1lKrg+tm7acbeJG1RnPx26o97Gn3wIiBdKpp4Izuh+2J83OMT06toTQNfQjgvRuIvkpAHOs/jr5/9dDfIWkei+/M+f+evn1kgSnOSTwpceoLfje+tnYp9M1dZu1m+HTQ4znK44vMvjvSZ1ClDu1igRtUzxhBuDD1h5mqlY3oZxgDyBUZSCXF8CVAWqDaO6YyPvGAsl6/SGIv+2ebF3N8JFP12LOKrIScvJjCSWeeK+hDJ0p9rzUdsXIpg+qZVXwHEyVm4yJiyp+zWdr6vV6o1ennO8vATZFA6uz+wdCcX0vgNYEKzNdPSmqkdub1T8AYD+DuMALymwuS00bw2dBCqgTITZVUDBh42W5XSIUAzidHpBZE+V2ZwWHkLkJA8AG5g9NItDQ2gMwWj8Tg2gXg7L6H4MthvMf+FbUxtBJzO5YAqmu3A+n+/6T9Dh4h0zqv0RplvM5jssz7qnUzDs2wiZGJ4rIyic/i6UlgTZIl8u3OJ4DTIkJake1qNc6VN9mA/SyiiqWME5iCA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f90800-dd7b-4d28-f05f-08d84fe6706a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 08:50:41.8499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXqC2p0CyX4ioca2YtBOR4FWU92FApSTJggR1hAe93bIr9dqq4R4CzGqOtnusWHcO3/454wsr4vcIUidKyqbVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020/09/03 16:34, Johannes Thumshirn wrote:=0A=
> On 02/09/2020 19:37, Josef Bacik wrote:=0A=
>> I know Johannes is working on something magical, =0A=
>> but IDK what it is or how far out it is.=0A=
> =0A=
> That something is still slide-ware. I hopefully get back =0A=
> to really working on it soonish.=0A=
> =0A=
> So please don't expect patches within the next say 12 months.=0A=
=0A=
Come on... You can do better than that :)=0A=
=0A=
Joke aside, once we are past the zoned block device support (new version co=
ming=0A=
this week), we will accelerate that work.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

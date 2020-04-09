Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7451A3132
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 10:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDIIuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 04:50:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8793 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgDIIuc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Apr 2020 04:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586422232; x=1617958232;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aJDIV6w8hyPo5XuJC/XGj5X1h2FIBkcG8jbYNnIbmlg=;
  b=a6VIyxw/EF2pxuH28aAJMS9mU9mO1YIlOLl2IQgFb9ehcp/rA8p6omux
   uhJeMw65PSIlP7akcy1AxM+0ZwrkUXGjqbdADDEIEslt6Z3pxquPjjSel
   XUDIPIXqgya86kf185+gw8eFj2q4vgG+dNj35TTVX8yTRag+R2NI3fqmI
   S2uJQbR5RHsJixb1xcTXiBlcE1WWMlIqZuiPfsRBuvJYXkAVdbQLy1S4i
   imgw/VLpplDLdmAWEJJ2tdpRyfWTH6BOkx1RAmv/zMDfu3xnLEy6OJ1i/
   wmBSUkax4+sBTYA1EcLU6wul+fbOBqISitdg869BHCe0ly+vxiWcDx/Jt
   g==;
IronPort-SDR: hDOUwJd5XGmkfNDJiycczULKqwt8OR+jW8VoDqNokJCVyzJEfYdhu54Y1Ke/HVAUCGC2yZ5Dr8
 ZrUqseKxyDIHQqkWFo4RUvjXKMLCNmoo4thwIZYmC1QGFm896s9wUS748x67Y7C5rqd9bd8/nf
 vkb8tpVmbbQoqVvyiM1iTju2knvSBcQYg2H7NXPkcynGu15gzv5tIpq+MIjtHWzeZbZOl+ZACP
 quSC5iH1fAmgk9diY2A09ClZdefxuC93LGPPraWRb5pRdQQ7UJrnAMSNg27jcTt8OCrwNTzy3Q
 uRA=
X-IronPort-AV: E=Sophos;i="5.72,362,1580745600"; 
   d="scan'208";a="134947531"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 16:50:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEUPiaWRsRe71gPVtma8iNr7sJUkzTHucqMEjgV8DjFvQThczNRXf9MS9y4cCShKCgH8nbBq35DHunUMSJm3beHuiQOYTWsC5vyx4JXR+XzhInSSck6zXYIAyONGS60o+s77uwdQa8NjMeTe+H6gEAMtPIoAK5BA6YzHnQj1uG1v2McHApfiaNSk+2LD1SveT0RlBK8s1vimLEdGeTNNtNLi1/zDlHE6HTVCVYw56Ninyk2/2z0VjYVKg5hWqLTVoZrz0gA/KsRMhWcAHYO2hWKnrsK7Qhsb5WqZCYN57K+0qWAGdO0Z200z9bGljSkLo5tQlAZtonKqCiExILdMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPmnc5s5st7mGUhypVGnHqpMRPr9ytbbNfkVQ+1L91E=;
 b=Mv4y5HOEZQ5A2hnedsXQrUvir+FhBlObaTOHO/gBmI2k1/BWoM+Hq1NlWZP2IWsOXdCzWM0B2hF4aVUBSOcWj01GViMYjv4qwbGv35AiJbKGNvh5bqfAVcQbSHF8wzCKqQwOfI+dq/BYqZ1EAUbzzstgvRI3gOqrBxSn/EgllFaNH+gA8FaJcQAMdrZYsN2VLwHKbqCeOCVrCevm7RGia0WGoruchI2AiyNKWEAVLoi6GYr7rk+bo1fVYKIo7cd8UAATsUf8GQ6tNJBs9KWyQz4jnrlGRXfCSY2LWum0NQ/8fW6AOYd2tb1hSkt6RXPNs+HkH+RAdGlYmHHMvetzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPmnc5s5st7mGUhypVGnHqpMRPr9ytbbNfkVQ+1L91E=;
 b=zWRJLmvsJbUcvgP0a7RcfKQeIp6CIkO1J/qGKQgr2YcVdmhHX6ysONMinWg8dGSv1fw5AggBCvIKcoQHtJDkWul4mHr3BoTW3sr+fTP6D2k5G10jyLUGIsGbbBIlkWGhNd33GiJHI2CDmU2C1hNMNZWAQ9au2ZqvwLPZ2aYLXPg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3550.namprd04.prod.outlook.com
 (2603:10b6:803:46::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.22; Thu, 9 Apr
 2020 08:50:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 08:50:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Murphy <lists@colorremedies.com>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: authenticated file systems using HMAC(SHA256)
Thread-Topic: authenticated file systems using HMAC(SHA256)
Thread-Index: AQHWDQbERVNaVh/cw0i4WbDgZROyhA==
Date:   Thu, 9 Apr 2020 08:50:29 +0000
Message-ID: <SN4PR0401MB3598FDECC128D251AB7B73459BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
 <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAJCQCtRtxqy7eMPg+eWoz36MMNBM48-mec8h182p4HmQqX-48Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d16b18b7-d953-4ec9-4fd1-08d7dc630e9f
x-ms-traffictypediagnostic: SN4PR0401MB3550:
x-microsoft-antispam-prvs: <SN4PR0401MB3550D760E21998CAD673268C9BC10@SN4PR0401MB3550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(186003)(2906002)(54906003)(53546011)(6506007)(6916009)(86362001)(55016002)(81166007)(4326008)(7696005)(33656002)(478600001)(91956017)(66946007)(26005)(9686003)(64756008)(5660300002)(66446008)(66556008)(966005)(81156014)(8936002)(8676002)(66476007)(76116006)(316002)(52536014)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tedP9FE5qyZ0K77JMfhItujSodHd5IM5P6eyrfg/tEr0Fz5lhhFw3hhtx35RGpghzqc4QqCiiXYg6n/XkIPWpswhLDblPxXbLEfigFWNcUCRw5V3Z+TrqX7HCTQuzXHIHpn7au3uzjAczCDg5SqRDaD6kDyavjht/KoKZ+vaG+r22P82U3b9maWXUB3mdeiTqgPDJX0GSA8eTR2JS63jYEDHOdu60XG+tyWzLb/ztv5e1ozk7UXN+j4L3pFdTCYrAwwvjzsCspDyJ21Kl91tkeBYqpXH6sws4zpnv0yWhfLRkw+4MXYE2CpkqPBL4Bhl9bzcvCpja6NbGfDPKgD649bjwnl97nX4fyAH/32LVCnlGe7CjV0qtNhJ97V+s+AV4xvCFKRtPOrlBkuPyYeyQXcX9Z3ro5XWFa1ZdrBPZkdBYYRIQj+gIU0E0n6UeZTJ3LtOtiX7hby8LtG49Lc/6jujkRl3ToyWu8ACVdd7AReeHkgndPurKBFfP0HVwjYB1SdANC3D1EGDWJBwjAqC3Q==
x-ms-exchange-antispam-messagedata: KEoz+ltSI+RDAOSnOLK5wqLUAdyb8igxEGbbkJ5dX4CGI3K1RNnItvg1gpZdw2gZuONNANj/f+Ox/FUHEzCYUjb1lCYvQGE0DGDtOEqlK65O0Cxi8rbHUPCd70CHbWxGA2nKN1wZUUfiy6PxOQMC1w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16b18b7-d953-4ec9-4fd1-08d7dc630e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 08:50:29.9810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yX7jPSpNBPIU0Y+fxse7An1Y/Z2vxyiomu4cqIp1xv4w+AF34+ZqNRnMp7gMznHNPiN77Fm76kdxX4UAVQUW6d2TluJEhcj7pT43Ie1F2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3550
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/04/2020 02:18, Chris Murphy wrote:=0A=
> On Wed, Apr 8, 2020 at 5:17 AM Johannes Thumshirn=0A=
> <Johannes.Thumshirn@wdc.com> wrote:=0A=
>>=0A=
>> On 07/04/2020 20:02, Chris Murphy wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> What's the status of this work?=0A=
>>> https://lore.kernel.org/linux-btrfs/20191015121405.19066-1-jthumshirn@s=
use.de/=0A=
>>=0A=
>> It's done but no-one was interested in it and as I haven't received any=
=0A=
>> answers from Dave if he's going to merge it, I did not bring it to=0A=
>> attention again. After all it was for a specific use-case SUSE has/had=
=0A=
>> and I left the company.=0A=
> =0A=
> I'm thinking of a way to verify that a non-encrypted generic=0A=
> boot+startup data hasn't been tampered with. That is, a generic,=0A=
> possibly read-only boot, can be authenticated on the fly. Basically,=0A=
> it's fs-verity for Btrfs, correct?=0A=
> =0A=
=0A=
Correct, example deployments would be embedded devices, or container =0A=
images. I've written a paper [1] for the 2019 SUSE Labs Conference =0A=
describing some of the scenarios, if you're interested.=0A=
=0A=
> Other use cases?=0A=
> =0A=
> =0A=
>> If there is still interest in this work I can re-base my branches [1][2]=
=0A=
>> and add blake2b as well, this /should/ be trivially done.=0A=
>>=0A=
>> [1]=0A=
>> https://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git/log/?h=3Db=
trfs-integrity=0A=
>> [2] https://github.com/morbidrsa/btrfs-progs/tree/mkfs-hmac=0A=
> =0A=
> I think 'btrfs check' also needs to be fed the hmac in order to verify=0A=
> checksums and also rewrite out a new csum or extent tree and do=0A=
> repairs?=0A=
=0A=
Check yes, I'm not so much with you with repairs. If a hmac of a block =0A=
is corrupt, something altered the on-disk data, somehow. Either it's a =0A=
bad block on disk or an attack. You can't be sure the data is still trusted=
.=0A=
=0A=
> =0A=
>> I just don't want to spend time on it again when it's not going to be=0A=
>> merged in the end (for what ever reason).=0A=
> =0A=
> Sure. Seems reasonable.=0A=
> =0A=
=0A=
Let me see if I can carve out some time for this end of next week to =0A=
re-base what I had.=0A=
=0A=
Maybe having someone in the community being interested in this work can =0A=
accelerate it's upstream acceptance.=0A=
=0A=
[1] https://github.com/morbidrsa/btrfs-integrity-paper=0A=
=0A=
Byte,=0A=
	Johannes=0A=

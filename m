Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E81E4431
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388687AbgE0Npv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 09:45:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47626 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388684AbgE0Npt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 09:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590587149; x=1622123149;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M6S6idchQy8uAv1XnrFDLcaAW5weExEq4BVQOKnBSmA=;
  b=HGmTrfX+ynLkFKIUs7NgpcF3p76nXVZlugfPyT8XHk6hgc9/JDPmsroA
   miWpDuD63MT60VggUW8YarDBYHUdB4r8rpoP2szBcYKWODgf1S5W45zvN
   kGEbaZb/QQQYoV7k/LXmWq5O4BOZ+qJafigRdAq2onsKjWOjNTw/NV8XX
   BMGoSncluBugTWFmcu4nh4yjP720jrxKVw2OVF1PX1trZsPqGI+m6LzoC
   0XdGBhWW/9fDxrwYsAx5T7NOtFZiD+vfF5Oiy1hnaQPCa3v//zd56bopt
   qeYtlIXpENMbJc5fQxwsBeadazwVz48gvMfUvNQekW76DL3hid8EJG+yo
   A==;
IronPort-SDR: jn/xpOyHulqHfr5LczDeI2WAV7q9gmTQw9f3E67xMVibvCv/PM1pNoowbbH7L5KyJ7Nu2MANJ1
 bvEI/gOf7hH//2v9ccEIBFa1SSVar3fgXvaMBmfZ6ohDwnRZEzwts/pAZQRYr8hwv06PXn9XXm
 c9JieP+hBFM6oJ6ONeYZhfqX5SzMYCHEmdVKQR5S2hoPVBn8r5RPOV/bS8WA8DHmdj9t1BbWXh
 +l8MFPVK+XNo8REx3uAe2GujywfHjVSmcMhdk8ZRRvsmrsqgJgsMRutteMB5+IxCsuSt4jV76X
 6Yw=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; 
   d="scan'208";a="138943965"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 21:45:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+t0cCS2bH27XQsQRAUA8cau1CV/gBIlkCG2MQzS0Rq6MNRNiSjsIXKG6zGwD48oQjadFf2qKllgJbR7Pwr/L7HgsCcioSnNJTp0+K9iOFXZ9BAKgiqUi6CzOAAVz/r5pVkQsy9QZ70S1m1ZqywrolVoCYo+jFuIfS21lAkwJk85ALq407MJs1eYjZ8GgcPUKJ5uyezI6tqmq/4KdBvAwWeKTwrTLwrXBoqcaN8vqDus/XEI61Pr+DKz/xcB+8UsTddTu4qoKpOqY0SW/rWXBUyKprR/8CDj3AGRWmDUpyojPrDKvu4r3xcFHfKGbFJTJLc8Z0p0I/CLtyz8BbWwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6S6idchQy8uAv1XnrFDLcaAW5weExEq4BVQOKnBSmA=;
 b=JzOlNyamrs9ePNde6p1QQL2q7ozZumUIHlH15I4kc59dvzk2SD0yeNE2EvAbcQAJ0LZZKafoXGBLlphr/v8xZMF+Y/No2y3rPCvUx7HWIvizQtHr9mhQOl+AyLZ4nGxAIWGj+fqGJwdM9Nm1FzbzKWK7SVMzVUmIob66qNCezIpg2tYUyDO85XChisyRNWxLudcyzthkSP81OG8m8l7PTzGksqz6YNl1ttXIyLEojhqpsB4lLZa/PydrLVTA7PJ9KZeHjPHmE0bQXg5HsZTzfHpfYwy0/aPqBpfLnm7/ILkKrt74Ki6pJPcS40NMpqEKOk5wPATN3WqL23UPlKfDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6S6idchQy8uAv1XnrFDLcaAW5weExEq4BVQOKnBSmA=;
 b=cjAA0yc3JCBJmjVrVTBTqPa8bh7HQWQKTrO84ueLFdc8BFovk0TWqHZpiqOcqYj9UUB64SZ8wC8ywoWxRWEqUEin7m8mGDIcRs3jwzO8Cf/Z6mARuPqvAHFkO22pOcN6qRclnx2rWsbN3mae9m9Q6PhdC2jY5bnhNpqzT7CUjVk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3616.namprd04.prod.outlook.com
 (2603:10b6:803:49::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 13:45:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 13:45:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 1/3] btrfs: remove pointless out label in
 find_first_block_group
Thread-Topic: [PATCH v2 1/3] btrfs: remove pointless out label in
 find_first_block_group
Thread-Index: AQHWM/6TAIGqa7p0KUSzKoQWtzzv4g==
Date:   Wed, 27 May 2020 13:45:47 +0000
Message-ID: <SN4PR0401MB3598E23D6533D813874F4E3C9BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
 <20200527081227.3408-2-johannes.thumshirn@wdc.com>
 <20200527130627.GC18421@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c86de84-444d-4e22-c98d-08d80244429f
x-ms-traffictypediagnostic: SN4PR0401MB3616:
x-microsoft-antispam-prvs: <SN4PR0401MB3616037CF5A807D6413168549BB10@SN4PR0401MB3616.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFb8/1OKSdws1GKXv7JLoh1a6iBORLKid0MYTNXdzyCa6PzDUOy192mHD8LXScJLTzYhWpNvy7wLilbTDexhqpJGtP8OUbvJhFP4hg4Ag8okX+Ej7ZC5cOFq/8+wi70g4U6Fd07blkkq1OiP7hki6CPstgRtnUD/BbzOKPjbak8x8VKMVKQmDFblZ2WNG8JjkBFwTFflJ9biaPFkWWQnlFhAANPOs6/iCoS9fgGYnBSVKpjY2z57XNZ5CldKk0TClayvXltxfmcMbGluNIK1EXSyB26Pz2X9fRIEsG7U9av+Zx26YW/HERaWRRDq+dWIKhRtprAijhDDMiylETXT3Kl44iZmW6+MuHDTiroL0tAGdKBcLy8XJJ3pO3iJVNHk8cg0xdYAd3REId0sTIGuwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(2906002)(8936002)(478600001)(966005)(66446008)(7696005)(33656002)(53546011)(66946007)(55016002)(91956017)(76116006)(6506007)(86362001)(66476007)(64756008)(66556008)(316002)(52536014)(4744005)(4326008)(54906003)(9686003)(26005)(186003)(8676002)(6916009)(71200400001)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: T1QZLtva54jnu39gXreEjLYeoatGyJt72LXAvWqyhMOgT0tlUsmRjgZ7smcGoiFVtIWw8e3PrjBKD07QXl/2blIgtwUoMezBunkIWZU1jHaGBuCJ9et2mpZ53gCyW4k/S0pPzQOh/D/8IhHyOYvys+nCPKlB332B9O0zHHfuXR64x0hdrAg8MXJ5WpnsQ94unXClSNRQQ3AGF58Bnv7sEHRRPqWAjQxs38GEITAr1EvI1efJHOCXLjTpBEWYnHPMnPsIx0FfRyIOsfJw+o/iftDbsOJ9pfhoQDHT+K+cZ9iN9587OJVRL7VPGs0mLoHlQAF7jEYqwXEoxHbrTjQzH4/wnjN2VbUDone4AND+5I3Thla+If7Q0Qkjnv2KiLwN0CRYDDxBhCdjsm/xoWlAUH4h4TRMLuKpC3wLWtc+CnQCiwCKxUlkn0E7DFV4DwLkDIS+DB4BYn3Py2MpkTeEVnET8FSoS2gZUQahRIUcy7bFbETut6U/VMUsV3bPeFoK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c86de84-444d-4e22-c98d-08d80244429f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 13:45:47.0225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbIwetvunTnQTw5A+LbcbthbgLG75A7VuAxn0fc/szZ6E2XIIO3tTqZCs788eDiAaNUU4ck6esXZuwotRZh5eJCjhjmIwV12/8mQcUqtXBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3616
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/05/2020 15:07, David Sterba wrote:=0A=
> On Wed, May 27, 2020 at 05:12:25PM +0900, Johannes Thumshirn wrote:=0A=
>> The 'out' label in find_first_block_group() does not do anything in term=
s=0A=
>> of cleanup.=0A=
>>=0A=
>> It is better to directly return 'ret' instead of jumping to out to not=
=0A=
>> confuse readers. Additionally there is no need to initialize ret with 0.=
=0A=
> =0A=
> https://www.kernel.org/doc/html/latest/process/coding-style.html#centrali=
zed-exiting-of-functions=0A=
> =0A=
=0A=
To cite the Link you posted:=0A=
=0A=
"The goto statement comes in handy when a function exits from multiple =0A=
locations and some common work such as cleanup has to be done. If there =0A=
is no cleanup needed then just return directly."=0A=

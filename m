Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8ED1EB862
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 11:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgFBJXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 05:23:24 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:55381 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgFBJXX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 05:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591089814; x=1622625814;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ag5Qnajs1xaJ8V5xtQWxVhXeIzsS7mo+09knXq4at1Q=;
  b=iMz+sjmz5EjZAMeQh2z8D9VjB/UgYntG9gYEE1MtMvyKV+nlgFZI83B1
   TWrqccNRsBv2yRdS9QwdrAUMfCANjNHEgc7wV2ynpgGy/xmqoldg/WuKj
   2ebHlvC703/p7uccCoz2Qn5b4Z9a4V30YG/jnfXdm8e7CPxjv7ZhJvItH
   EA/O7G2E96XkDQ3DNsNEOb/sE17OZaVQbCmoe5OuNO/kJyucx4EO4hqoc
   4KDDRfkUP3ogv8o9Ay858p1MxKUpre+nIFc6olwn5n1I9BZHSimsrXykA
   etsB0xhs7B8//rzHDbBt2J2GRI4Z4HLrIg4n9LiiPsx+UNpThdhKWba6E
   Q==;
IronPort-SDR: ThNJnIUBYV27XvptAkFDXvRPgdrFLAF2OErz5wLFCtBgtFKenAFZlX2Xop+bx8SrXJprgvQQov
 Gm6iUwVFO6x/j8rFVkUtn8KHGY7QLBx1RinSUj6Mu+InmOxErunfBiIxagIid4c/fhNekm0Wuc
 vPInR8jIj7k5aylrFT4ZUKzAMPLHR6zWrFTIuqfGzORvX28miX2GjB5sDzHyTFtF5TiPdkXmEr
 ZhQ8+XrDtGRAyK4m6aVUpEUe10mGH5bIs+QPm/k1HHWkKtGtBrl3Awe2UsfEtd11iVNrpDAt67
 S4Y=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="241870042"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 17:23:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMJEjVU1Qh+3lmM26WOHpiH11xlBgHpJceBMgtnuzI/fnJOKjrEsFmC4b+9yoo+cZieXVSq1dXnE3B+LVaC+bsF2juSmP39iLn090w6s8/628VIXfX1Ky9O3gCix7XBt7lBKQ8FjqBNyz5a8mu2xjbg/3ePYtnCK4T7fVavszRTTLiyqR6UgPfDXuUjyGKLQEnX/5AArCLSVnIKygoxP0ppuw7dWpliJUFqsBN4XWEG6ChS592v61DroqOm7pRsm9d5VoKSZNqEX7m4v2SbUIzbpYSHsqapFo/1IMQafH+WT7r9THY4zw+jW2MDF7AEFj6rP/vS0t4tCzXUStcavQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag5Qnajs1xaJ8V5xtQWxVhXeIzsS7mo+09knXq4at1Q=;
 b=Xg4wX3ua42/JJfPKiV4S0x8hXw1dDzuG3K8TJbmrBd5xqXMVdYF+iPFSq4t0D8bhfI7Cg6nBk/Uu9sYb/mZYylg/9+JG7oTpfxl8nsrvBt5uskOoBfJ0BAocdpcybOR9rJKYX1bFXSbo9Ll3CPWFvdP/CoVMDbl1jOJ1rqdK1tEtxoRRxLH1uLcCkkJ3afx3wvabfkTIGbwOFAU4UyOL0yoF5jdfIxACvgbcSmoMAoJd9DAlg4mrdxqb/+ICvSR5znXv3rw3TDZUgxi+u+SUeRTR7pL7L4M3UF/EJgvQsrmc48LfGpCZKAw+sBjbTZryohUlhQ2Brpic7TqU1YkVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag5Qnajs1xaJ8V5xtQWxVhXeIzsS7mo+09knXq4at1Q=;
 b=OBen+H9hzDotIdns25Q5QR323JxGaH8t4GeJqg8FQGzqZshk8pllMNo7OQxq/ny5dqBRkpLcFSeeDcP+VrBac2zGOTXccrCQpKtlBL48u4so5gr/F01EwhhkyvsGaOF0rTt+Ho8tB8/CvqsSEAAtdvrApc/+0/I1Q8LzjxZq7ok=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 09:23:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 09:23:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 20/46] btrfs: Make fallback_to_cow take btrfs_inode
Thread-Topic: [PATCH 20/46] btrfs: Make fallback_to_cow take btrfs_inode
Thread-Index: AQHWOCq60nBulJAsHECWJMYUKPX1rw==
Date:   Tue, 2 Jun 2020 09:23:20 +0000
Message-ID: <SN4PR0401MB35985F2CAA2D5FD69E7F98B09B8B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200601153744.31891-1-nborisov@suse.com>
 <20200601153744.31891-21-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c65f779-48ef-441a-c6e8-08d806d69791
x-ms-traffictypediagnostic: SN4PR0401MB3598:
x-microsoft-antispam-prvs: <SN4PR0401MB3598C7FF77F2B4025819466D9B8B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mK5qTrjypvBf9Ys8qHg3Dzcvyz1N5TIP89nVg/WMHOWG3bqVdIxzbSw0RizxcmWqcBmC2XYdfPPzQuJatK+oUMS7fhN9tbUkNbuLbNfw5KWWBNolYG4A/GNOGQQ+P5lfCdVxOPD1eWOMritqpriWQO1AjbyZnZb+KkURPYgatfsY36rCSdWKdEYrGimObrNU08phNoruZYfZ0rhNdMcvPtKJFLpN2KWrth4HgwnqoCtQ7OEXNSAvfhOA2HOJlzavibKNMCZ8fgmy3oZe431LJ7fD0Cd3Fl+dbNVE9gBy1iepSihV73508aoiK72H0iyvCKd+UzzePYZtYtrLjRMW6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(86362001)(7696005)(110136005)(8936002)(8676002)(2906002)(316002)(71200400001)(478600001)(64756008)(33656002)(5660300002)(66446008)(66556008)(186003)(52536014)(66476007)(558084003)(66946007)(26005)(76116006)(91956017)(55016002)(53546011)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BGq+8v8ymcH/zcdszZE8WdwkM0BEcJZpYraC3uUfHLG/i6Jdxy9XwnKhPd/3NVS6rbBqk6PuLiJ6LnoLdTNcaL/+dMnppV8Fm4ZNZ7ubyKKyoZ0nV67qc+jU5py/MVt3YS6xHJew6gMk6zVAvUB3ysapWqFjL8BYKnFF5xgMIZ7EWgBC7++6ZGzBjk/D70zqmfX7F3T/xODeaMnSKl9amA0gYFferSoVyLe29+J4iq/EAgVbYG7BXk5kO3lumTeb3fpa4Stw5W6GPaoGCMAJQMfK6uZ7x5CyXGY2o3g/8Okfp00JuMql9BTwjIQLcR1o+UqaID+Y8zpJxcpsj74TOPtYE0g/+j16BIPwticJhD3U/BwkuCH9U08VcRFR/KkEOfoFNLmeWEAdKM2Aj/lv2ul3wZiUstbcc/ztR+MiTuVRccaBZoY7yXAxZQuH8KatkdQHNvSdcle6uotDsqa2TaG9T8taNbLedyoos9Nqsugwbb0oyNospG/S+THBYkBl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c65f779-48ef-441a-c6e8-08d806d69791
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 09:23:20.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cHJJ3q7iQnqPEhau1cJsxZ2iwiAwAsQ92q9mdmNcEX1spt7lewwn9YwkbUXki4rLrDoWM8hffdu2pO5Cldn/N76VhG81lkj9iFFSt8PeEAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3598
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/06/2020 17:38, Nikolay Borisov wrote:=0A=
> It really wants btrfs_inode and is prepration to converting run_delalloc_=
nocow=0A=
a preparation (I think)=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

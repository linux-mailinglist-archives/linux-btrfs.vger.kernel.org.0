Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E3615995F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 20:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgBKTDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 14:03:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20870 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgBKTDy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 14:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581447833; x=1612983833;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gNSQXKYszOENKLUBZXtsagEPUl3JcDFBoaUPOdnfH5Q=;
  b=cBRGOY/IizeP0Zv74xdeCxAEaKxuggY+mh8gKWZBlwncXl+EIbjvKHB+
   hvwoFCJjAk9z2pRvQ5hk9Ntllv6jvF8yDNwutrhZdKmRAXikDN4DrvO1s
   RIJcFaEl2EbUnwlbbSi583DrBygoQi93DjIX5T+a7IbCjDAvma7vcJBcN
   ju4sEq8jcdJ1oYSt4/PqMzLJcwptxYosE0iAq/V2+fpo2taKAkQIKZNy8
   hz/9HkB6pkav+Yot/dgVpxUbbprE26xQvoWuweXmzjrD0HUHZVFj2840V
   p2IMQrRKq8JpxpVsc0uQpc5xZa7etw8ALgwWkdFwIKVoYvOu/NZMjY5h7
   g==;
IronPort-SDR: 8Rg+ipyYMty5boA0SFtfZVQfLL46eBL3JLvH+aC5YpJtFEK4XfIGpfJ8OvT0bjPj5SK120aw3I
 eqhmdN8qcj5QKwZ01daavZapwFVwx4XP0I22JeyGyweH76zSsTgsJ106Oc825rJXsC1UA4iY9a
 2hPowNNhk/9jw1LdfiTy/m5Xdkn2d3M0WIoxVsNGPAJsPCKjHz4jXYCV7HlE7+Brt3cwYMBCMJ
 +oDx2lNCuKo+QD89LjVZNNKM7aUUbcvdneGPbLBnDazE6y7xLIp7XsV5YBZIJ4skI/srk5+yGs
 y7o=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="237624287"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 03:03:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnPexhDQTXhCgVTInPkx8wB0f53yreuIax9eMJwtvPWLdNYNCZUiWzsNWzhqRKlpLdkgtZMB/FAaz1CVz5/xdjvE5x+6w5vWoP6qfLiKSSyAW5fBAtN//Ox1Rnpvy2wWAw0X2F5Aq7PUwsmWowxllUti8MfTVUWSz8hAKjdbF1aj7eYababOx2kXm5trPmmxBRu1heJFt/hhM5LhT1aGOZYgCw2rWdQbX5fN/VgUz4VjCBHI+7ZFoGFtrbMifX3sGpsmFj3pR5Oa7/6YqJfeA4w/JVxPT7gVMFofoVADhsICegOKwu/9ccVpWnupUzDpVrW/8RMTI2mGgggULyM00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfidZj1b0hgsDAVFJn7ABjoDNAbc8AaGYV7JhkYgkK8=;
 b=mSES2RHle8n7nE8k1pGt8wamH6WsGhwkPEWaON9DepDT/tnmk9v6b9VwUfcx6sSx9JFbl7cOcltWG+i302tP0/rMpPYyZkkqpRB5FxqPnVUENjV+qrZcgBiEcwIazwoExWLVpbDCDSA294YQ4HXauDb6lh09ST3oHfjzgmvxrXvISkiAtMnkIwLCabAE3HlyfoBvBwgvY5T/JIAf0SAdBxPVC5xdc4MzykwjTZvCFjfObBPJX107OU9InwGfv1Am8GSlBRzW6EJzvd63B5uSZcRd82s23ouW9jGj53rLZVu4Hni08izPSTuw73afgwatQSHWVzFM7g/L3qwU/Zrk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfidZj1b0hgsDAVFJn7ABjoDNAbc8AaGYV7JhkYgkK8=;
 b=tYF7eZZn+VDTzofCif7Nk9GE+5UrVFasoxxcX1i5DSWyjgeiUbeTu7mbagXwzLnqONSCfc7ZY5WGUsDpYQfSnHuFtoi+cTCocWKPvY4iFORVXljVfUYm9u1nup4eqXOKPnQLXolnI7LDZjvo5kf9VHy9d13J+PfvztJ5fRCfGfc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3568.namprd04.prod.outlook.com (10.167.133.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Tue, 11 Feb 2020 19:03:51 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 19:03:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 3/7] btrfs: use the page-cache for super block reading
Thread-Topic: [PATCH v6 3/7] btrfs: use the page-cache for super block reading
Thread-Index: AQHV4EB7g+IzTdcMTEaEHN6XKv4isg==
Date:   Tue, 11 Feb 2020 19:03:51 +0000
Message-ID: <SN4PR0401MB359858A1EE89A18DFDB0B3B19B180@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
 <20200210183225.10137-4-johannes.thumshirn@wdc.com>
 <20200211185312.GF2902@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0bd6657-960d-4313-31e2-08d7af2521d5
x-ms-traffictypediagnostic: SN4PR0401MB3568:
x-microsoft-antispam-prvs: <SN4PR0401MB3568D192757BBAA3081B744D9B180@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:138;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(66946007)(66476007)(66556008)(76116006)(64756008)(91956017)(54906003)(66446008)(8936002)(81156014)(8676002)(6916009)(81166006)(52536014)(5660300002)(9686003)(316002)(478600001)(4326008)(558084003)(6506007)(53546011)(33656002)(7696005)(186003)(26005)(55016002)(2906002)(71200400001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3568;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4d2/gSgodUXpT6UKxSEro4L/CrSF5Oj1NA+gzqAeCKaj5KVnl5DlH3eLGJxhCwIwomiVWRlnsjIoE/z0kWE6sZT74+Lp8ToIl01Wr3luGo7dlNytf+Hr4/1c4bwyLrs/+h3BpkGw8T7iQKP2ijDKjRWnbK3mNHt7728NVo1cPToBxYELTYRceAn/NII7Ae85ybUnHP9jl8ug5CvTkzIxxtcVb98hvF+TzRTcMXhB+Uf6TVTHcF0mrgP23dXbI+r6qRQmRvSIvd54259mP/Kp7FS4I4/0Y1goiK4LoPrLrVsI+VagoWz/7/L2MRwYcswFwXWIxM49PZPLx7SpoqG1X/m4mHKofiAv9+up5bAp0FVunFRXLISuFpPCtkWkZRWLs2KbTOkrf/i3aZcWoQi9DCkHaGZaatQlsFIe6ccHFX8+nqIoKQPNKaitk/Pq88m2
x-ms-exchange-antispam-messagedata: Icjmucj7kDN8f3EDpaN7Zswn+2XQNMQzr+5RLq8zQ1VAUmn9209NzsJKddlp4V/7OAEzxUI7iyfDat1B1b5CHZlmPdthaKo3t0FbRq9MD14BL9t5fGT9jA0yXem5nZVjE3bdIoUfHLmtoPd3X846nQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bd6657-960d-4313-31e2-08d7af2521d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 19:03:51.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmxBTWZNQHSQGsab/ocLVNuxmmNPzS+ZXSKv3OA4yDah0TauwdzZfu8qXLUXRM0mPUz3OlZVCECalC91H2ld+ONdcp9zGuZUG47RT8esL2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/02/2020 19:53, David Sterba wrote:=0A=
> fs/btrfs/volumes.c: In function =91btrfs_scratch_superblocks=92:=0A=
> fs/btrfs/volumes.c:7338:3: warning: ignoring return value of =91write_one=
_page=92, declared with attribute warn_unused_result [-Wunused-result]=0A=
>   7338 |   write_one_page(page);=0A=
> =0A=
Damn, fixing.=0A=

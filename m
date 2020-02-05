Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E115277C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 09:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgBEISq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 03:18:46 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39502 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgBEISq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 03:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580890725; x=1612426725;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bO0rj+2SQMv7n1ashxVURS6N4AYWTab/HW+KEqxouJY=;
  b=bTokwodK5XbC2/DrShlop334gHCSASPULjlrWbPol1GAXOa/6sOTA/+D
   w+6IhL6S7iom3cXym9ahSR5QIWm+wwhcmb+yIzn5mFkntZGjoU4TGjI47
   4xXQ54NU6D9GWYwV9513GrGq76nne/mJ/hlWSOOtKJAneescg/iH2NDQV
   lxCu7dd8reAOsagkAapEhDab8OLyQ60dc7qopd+pfT0h0rOxqE2QsGOer
   MjZIl88OSb8ndoNJ6auL7tnDbg9frD8FdsPnk/a4srWHKUtMroiMSxpCw
   +od6riTMQWb+W/GjYIc80fkyhKf1bKxV8Lc1aLtFY20WNuwK2wnnO0OYt
   Q==;
IronPort-SDR: bkQ4yI3Aez6GO3mLfsbIysTwE9eTC2yF/NbQWFFElB4TIyP2UV/4lmwEE96ihwP8sgt6VzLcef
 azMuPa8OJHqlG2xo3lPOTFB5USNZWLBr1+W333/rsVGjLXCjtxogn+pbeKVTZ6gIQQLGwPPsyz
 KpqCDFdClzWmezII2Xp7uon2vKJC6F350LuYbuoWp/oVGWxSe3E/fLtcgBQ52dXl8cgWT/S3C8
 Lbuk2/W4AiyVE9R9XOdAcvQn7zpfw37xv80qk5WUhv6hg8BFRkbnTnQkn/d086BOgGuqYZbV1Q
 r6E=
X-IronPort-AV: E=Sophos;i="5.70,405,1574092800"; 
   d="scan'208";a="129134213"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 16:18:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg/nIoJdH+udp+43lQ8vl8GMPktkpZPWUCc8mL8AGZ6h4Lsim5Ma0Nqt06UYDh7myu/6zwmQaiukex9lOcnKFG61bHv5szMzF/ksrtbo7BFjUI63jzqH9LTTxn4+tttrFADv3AgKDFw1jkxwWaU2uL6eeeM780MtyfbG9hkpi7kPLyK0V4VtNuMKH3wapDG3p4n+h7o7PUkr2VmGoivtQTQ2XN+3PakwlUcjgarDLR1z1vtluElvIqwZAl+MtNUIeBmy0jPYyAnR5VuiwWT8QxTMdfUc6Ntz2cRZBxreQH7UrdpS7L/KwdfZGDp3jevrvrhNxqME04RwM9rEh3e2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO0rj+2SQMv7n1ashxVURS6N4AYWTab/HW+KEqxouJY=;
 b=hJiqgaezM9NmGw8NVKkKwHkHuP5Osei8JcEa5ftjZS+qE1vVSny8GLM1j8MkEy6S/Gnc0jMP7zTYUH/ZE/v/hywZigoEpqXcL/m7Lne9LsgDCoHnLxwNNH3n2zLEJLM0ztyjK8MmYgU3cbo3qlpKDK4V58yKA+lL5PTGUWCs1iJCknnZeHInXZHuzxiZNGTe2yVsuNu07Nd/1VipmizxaWcyLGO7kWUjVj5CJb+yFgmYmAXDQnfLsRfbvy2SF4u+m/eDfXVC0t6MGQn7KySJmFmrnMETwnvPdmlz74jbyz+omf3RuKvbg/Rugo8K3CtUjsTAbNI8L5XNihi0OrMxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO0rj+2SQMv7n1ashxVURS6N4AYWTab/HW+KEqxouJY=;
 b=ZtHaHNhY6BQ+KQPQOxkaibG0jilPkjpUhUEbw1i5Edsf2C+ABLPhhzpZI0/CsisSrscdc14q4JIuqq1NqPW/I79q2Hs9EkGjjt7HvRnZ5QBX7CrXRY5NskrZREp7KI5lfQ7G3c4znPnD6odyD4+V26IPkAzcGCL/c8ZSxcUi65I=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3632.namprd04.prod.outlook.com (10.167.133.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Wed, 5 Feb 2020 08:18:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 08:18:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 20/23] btrfs: run delayed iputs before committing the
 transaction for data
Thread-Topic: [PATCH 20/23] btrfs: run delayed iputs before committing the
 transaction for data
Thread-Index: AQHV23cLq8MbukApiEyMzvuoeRf6JA==
Date:   Wed, 5 Feb 2020 08:18:42 +0000
Message-ID: <SN4PR0401MB3598DCBD28952E5DC21437399B020@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-21-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a57901c8-af5f-443c-1747-08d7aa140363
x-ms-traffictypediagnostic: SN4PR0401MB3632:
x-microsoft-antispam-prvs: <SN4PR0401MB3632E4E4E3CF6FEBB6DB24E79B020@SN4PR0401MB3632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(2906002)(7696005)(26005)(71200400001)(66446008)(52536014)(9686003)(478600001)(91956017)(76116006)(55016002)(186003)(64756008)(66556008)(66476007)(66946007)(5660300002)(53546011)(86362001)(81166006)(8676002)(81156014)(8936002)(6506007)(4326008)(110136005)(558084003)(316002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3632;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKGGc+7k1RCmPCycoL5LqJ9PurH+d78bodbjDKWWi7Gxnyb+wtcUUzFxJdQTLSilcOubCRrB6EMLTbikbICYWrFXvVKdK1GGoD7LGUlgZdgdrGG1ZzFoQTm/kB0bzGlj31Nw4tdX9z0WeKQvcD+n2+r2qYjryqeR/SifKQiDxHidmg+eoaERPIbPKKRVxDyhy4OZ7vkRrkhRrkA7606aEzK5Kv2DbG7FEZ5gTaOz389Iv2V9zj3zZwVECfn0nKY38Yd/dyWxFSNnET0FjrPYDQkqQ+RHmgf6Dlc5aiMIdfogBR1bKD+EVDVjd9Pz6Y76vqIkBv/dGave/bp0zhfVq7uhTwmW4NW+J/6a0wK39ZaAOabgVsjc486rXow/4B8DLkzD7mLbOgHfPusPGUm//632Qvv+oa+saACOXMdmi7jKhLacgIycp6o08/tOUUJg
x-ms-exchange-antispam-messagedata: KUMcYlNByDRMFrNp9RKyLA1TlJbrNPFNPrBM5vvqXHkBQA1BLz+ASdWXL7NHeFbr1tkLlilc3JcUUre3esjnWoQXTn1fLRrre5ZXLYhHDOJww1tWm45H1nOScKO7jGJkjaTOnglEY442vqFJvusq8g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57901c8-af5f-443c-1747-08d7aa140363
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 08:18:42.7978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +qougfbDSP+XxerKKFDP51BuGkcEOdxAsnezw5oUlM6CF3Qz/mWeXInjG/OVlAWU5/xvv1NhgWc4MfTY+toTfYMocd1Qm3ylohZrCmMqSrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3632
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/02/2020 17:20, Josef Bacik wrote:=0A=
> Before we were waiting on iputs after we committed the transaction=0A=
=0A=
Code wise it's OK but the sentence above doesn't make much sense to me, =0A=
feels like it's missing a verb.=0A=

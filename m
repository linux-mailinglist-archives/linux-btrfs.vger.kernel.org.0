Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C591B7129
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Apr 2020 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXJqb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Apr 2020 05:46:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4625 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDXJqb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Apr 2020 05:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587721593; x=1619257593;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/7QTLNYMjcrjM23zruiAOAddYl3znjS1dHavYNZyWPI=;
  b=b3U9kfFXPDlq8wALLhHPETOhcDtLuWK7xglNdZYx5YFUgrpMRNVUf0o1
   Bmpb30NafDwEanbDzhQeeDaoUKUpR26U+Xogf1MK/BxJ+Zs35u1YSbLsN
   x0S/cPBOUUnaEJ+QG1XDDziy9o7h8jfseDH/pLn5ZIwHdqmuBjgTdMCuX
   H6JJ2e9ee0fMA0Oy7tbzx9SnvXpMMrnzn+sAATIGM2hxB005GByUTcWm+
   DZ7tEe84TtjQrSNhaUhlO1hSwo/XUPSn+k+vJovN4ynkWdvXaZ4JXFHVM
   wFrIBH1uhK4/HpQ41dh9+4o+/jzuuI/67r55LURSiO7k1gYrWSA6q4WO6
   A==;
IronPort-SDR: xJXiPIg43EooX11AyUbQlARBAOfBoF9eSGd3V19YoAVWVqBBEUHR2InzCoMbRiSUuXyaCAgkRE
 GczCFC/HjtuF8kxl5cqFENDAx8JjPERm1v8LKBBTYljDrltnz7GTpOZEhl5/3LvjPT5RqY04J/
 xvrBLI2zlWr+sjXi3fbqos5jhgtduv9Nr9pYjw+9A8+uovKnnS7j9WsJ5Gzu30PKoufoJjIgn+
 srNTjJqgc2NoRzw5Kg096VWJbAYDabMyfXyuYFVHweJPkRXX4n1Caut6nH+szEz7N+8LUXrdDa
 HO0=
X-IronPort-AV: E=Sophos;i="5.73,311,1583164800"; 
   d="scan'208";a="238560546"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2020 17:46:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFXdGIxHcfBVspARRXWL45KgH1HOJeucCQYwWEUzc3Qwx2/dbHHK/OYZ+bz8wXy392UklDcaSlE1ZKmunZ2bPASVL1krS7/Vme3YHOSzCRidn5KJdiKZhNE4d5F4DKpdn2B3QpoiFWPJ8zawB5bFFs6TZmqsEA6KT9akln2ZjYWdNRmhRicbplKVPTPiIG9RWVw9TBWCbRqYA6TTp82JIJVs3NMsaDrmPHlKK/epoKfwR9oNEOoTG9lV7IldTZH2+1+KZ86U9XMJigGw3GN+v/nT2sMi8ZOQ87EncP5lcneztSY/hsEvnrPGbuyq069xE+CZt7izLoIINkR2Cb9YGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7QTLNYMjcrjM23zruiAOAddYl3znjS1dHavYNZyWPI=;
 b=aBbUO6SNTSycAbPBVbfvXp9xE00WmxyTclJIMfhB45eRNCV4SXkW1H3/iT3I18kuFvAMnM1o3+6j/dztX2ne3uhuo0vuZ6kBOK1PPbSUZ7mxtPi+P2DXqf728cvONNhaYCbmee/0n+pfHJ1rJcx5qlL38HWh4hNSP9RY1lBChsh3YN/myiaWuBLQQzoNmZD1jRl0/focOL1KmHhMpk6BtE2oh199BI9oTNfkUln/edgKpObH2o35TS6LDvlJBp+qHm22mN87RGgihRxqKlkIvIODUDAflGuFfDylU/irUusxuu3hOU2wR6KF97YGMkqXMhLk/b6FZSdQr4DUIqQBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7QTLNYMjcrjM23zruiAOAddYl3znjS1dHavYNZyWPI=;
 b=ucttUlVmksaB4FSGvK11PkwT2gVZEcmGSvBGhE0pVwAZlZ3lnv1qOwU5vHpMjAMgnG+i5WUbWgCTa445+G74Hay52x69KUXRrW1p8l1T/MO8dXkOos4Xlze3dDTgCcg371noxARY1+pAc/3TOoBsTqGQ09N0IiEkX8kHzjhFZR4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 09:46:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.036; Fri, 24 Apr 2020
 09:46:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>
Subject: Re: authenticated file systems using HMAC(SHA256)
Thread-Topic: authenticated file systems using HMAC(SHA256)
Thread-Index: AQHWDQbERVNaVh/cw0i4WbDgZROyhA==
Date:   Fri, 24 Apr 2020 09:46:28 +0000
Message-ID: <SN4PR0401MB35983186789556125B384B249BD00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
 <20200416142405.GM5920@twin.jikos.cz>
 <2de48aa4-979d-dc05-8c58-1aa1661c6332@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fa0eaa2-1018-45b2-fec7-08d7e8345c9b
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-microsoft-antispam-prvs: <SN4PR0401MB35203EFFAE0E8DDB339D8A949BD00@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(6506007)(53546011)(52536014)(86362001)(478600001)(8676002)(26005)(64756008)(66556008)(8936002)(66446008)(81156014)(7696005)(33656002)(316002)(2906002)(55016002)(110136005)(76116006)(91956017)(186003)(9686003)(71200400001)(4744005)(5660300002)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YbnZkfsDblY5CjcaoykgjrPLZ6hvSdC1Z1whrdcEiau1tFBmHsKBLHkBQ8izzrOVK2s1o5wgAhF2yAQikcMk3ZDCaTEtL+oOy46420yCr0nPQpD01fcfb42eJ4O86XWheHIsPkjMsGYR5TTNgIMAzUSR1idd9AZpgj0j9ORiclPOtTF/YUN8NhkjZZYtAGrJ9vkEjJQx+eXd9lH2cpBm3lCNGTSihaFA8uLPUdB1/L0l04qnWRKqnVzn2ygK9/nGUDNfZ4mf5ccQ72m7ftixbElUZR2ZVuwFvVtYPv7tgnewU/XS8x2IFZcSSvwJiLBah7ESv3n5H2yL4mdbvjMwzGg5eFh57Ur4PV6Krqag7buCCE+ed1krlIwo3xiq9DNM7XSMswCE+NFRdiFauaJ+iZP79GCgOLlWrqS39+n6nOkXtmoqnDYLUpwEr5gbE5+E
x-ms-exchange-antispam-messagedata: BRnk+ubU/jXkPe3UIcwm8vmY6ihOhtp1+nwXYMFXZYindSNts3kLTyryPvN3IamTyhpQB14H00cqwjhDYuzfF2UH936catJKupDsSFMwwAEV0EN3Rb4wm6nYg3l3fZm6A7odGny9w9rBuw0FjDxKWQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa0eaa2-1018-45b2-fec7-08d7e8345c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 09:46:28.3115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRz850nx85DrrEbDTv2XQBU8VyCi6odhgzyEz/B9IoPLfDymTYMum8Ajjao/zMIuIf/WAH1yA+ifz+N0tQNBwLi3JqOglq+utTYar9nSuQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/04/2020 11:37, Nikolay Borisov wrote:=0A=
> =0A=
> =0A=
> On 16.04.20 =C7. 17:24 =DE., David Sterba wrote:=0A=
>> naming of the new checksums (hmac-sha256 or hmac-blake2 should be ok)> -=
 key specification via mount option=0A=
> =0A=
> But the key shouldn't really be visible in /proc/mounts since it's=0A=
> readable by ordinary users, god knows how many more pseudo files there=0A=
> are which can provide the same situation. If the specification of the=0A=
> key is a reference to a loaded key then yes but otherwise I think that's=
=0A=
> a security risk, unless it's possible to hide passed options from=0A=
> /proc/mounts i.e pass it but make it internal to the filesystem ?=0A=
=0A=
No the key won't ever be passed to the mount command, only the key id:=0A=
=0A=
keyctl add logon btrfs:foo 0123456 @u=0A=
mount -t btrfs -o auth_key=3Dbtrfs:foo /dev/disk /mnt/point=0A=
=0A=
So /proc/mounts would only show the key id anyways.=0A=
=0A=
I think this is fine.=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342D9207328
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403925AbgFXMSf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 08:18:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36842 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403917AbgFXMSe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 08:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593001114; x=1624537114;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SBafhR8KKWOiK1r5aJMATmpMjPbA4/9rzYII3GBmFzU=;
  b=hc1Mzvg+QvF1e8X5vtNF3/GWBU3ENAxBmekSQfHkRWESXY/8jTru9DIQ
   vKW+B5pgvy+EJtM3+f9deg/2HtWlD9KJ8N7S7gmudf1HPRFbbCUD6tu+P
   PPmr35z2Qw6cxqfi8LrA9hcH1m8EO7fKeVuJbHQhUlmFaGhXQvxw18c8w
   WNm9wsRK2SwLjYjDPMSS9OAvn7cRUR0i32aV5+DNeuokjf4rcZR9mxLJc
   S205KSXoZ4uj9hyxIrpqrm3W2MtknabSteRUXwYAoYpMwrRVDecfj9fsA
   YqPbqe3ljWw4stSlSLjL5E9wTs804qUt2KyKMYKD4nATxOiz4/IkkuEKI
   A==;
IronPort-SDR: 5X7TkG/YPzZp3t/j3RxQAfefU3zlJCaMi0V7Z3f0wcrrdUgU9RVqmDKm1ZlG5LGMnjYTZMmpGq
 7LYxg+63GJH8rA7uNhq5gaKD0d7z+exsOL8m6cfBEBkkMQ63Gq4qssNtvca4fVzmWfKoJ94RD7
 8bbIuU/wE7r37CmRD69oqk0gnX+GeeZM38Vx6DyAEOGDVbO0N7OA8IosMHRk71VyS+YAf9r4Ib
 Nh4W5NGmDbgtU756dHKDSyrk1gY83I3Mn4cUoh2ApWDZvfKC9tvKSVV7kMqp2Ck0CLavbGC+kw
 Qgc=
X-IronPort-AV: E=Sophos;i="5.75,275,1589212800"; 
   d="scan'208";a="250007243"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 20:18:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efLqwPwYv4VXDJIH8DF+YPYU1j5XCg9djl3LjyRB2N/wJ+2Q6H/7n5szTvNePyIZMJcGHCt5fO1ezalgXnNj2SmCXlHnjzFDAsvhoXNH9uQorfduko6hHOQt2QGyguQhXOcGDiBJuDrX4xeJc/lZ9r1ino7Cbf0L5ZnM2Bk3UykdQJYZfV5GwB00XlHWFmbNXAc3L4MsBBEjxAtxMaeRYkfZN6hFnx+ApylLd4BMtU1W/BBZq3n8hZ+qcbo/oSPzpARJPZnEYlRKiKaD8zu37igxfoaNjSI4SO2f9aDK7wlV0jVcpI00QjFhz88KXiONzr/EHqCerV8VQ4NtcvXUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryIMMBgTE2KN9/gdD4Cqt9RsH5phEooL0KuDwqOgXK8=;
 b=FDAUS3EjOwsd9q0WtmYmMTtvCeVwmJTUBVGsDA5cyozMPQqvffGuWafuTt8eIqZexnLIXbYI+vAVNJAOukTYv3C05mBJ7pSVh56yzVduex7XZBilOw8yrvtzj7BD4hVU56HxaG7DZoYhwDYYrrKVGcndUcGMpxNfuOMFVLLEzYikYRyEtpdkGycJ2XXZWkcVhDgBmdPTPDso1drnRqQdHkErc4sCvnUhIYZ8eAHpcsTBD+P8FFxJLe9UIqKwuw6R4mr2JRUp3P2XvuI08CB7ML3rYhno+2h6FV/ae74DmDnhIQUdE+h+Y643z3whYyLpbZ6BZIxPhCf9HJVBdply/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryIMMBgTE2KN9/gdD4Cqt9RsH5phEooL0KuDwqOgXK8=;
 b=myJGRP8zR8lnBD4gDmYVLxK5zHVSMdxsMZw2megDehrUI6jAPvtH/k5DRAur+QyYOvBUanoEayBQ4VXiT8PG0ns4ApEJodRYYd+cjAA4ogL6eZ+X9Xwusdf6wR3zSoFa7kKzwbE60i1fTdi8YlatPZtSudFUewY/2i3mODiQ30c=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4318.namprd04.prod.outlook.com
 (2603:10b6:805:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 12:18:32 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 12:18:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Hans van Kranenburg <hans@knorrie.org>,
        David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Topic: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Index: AQHWShFCK43KMhBSekKBmLU/7X0PZA==
Date:   Wed, 24 Jun 2020 12:18:32 +0000
Message-ID: <SN4PR0401MB359802EE9AE81A9316407D6E9B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
 <b1342f5a-5412-69fd-dc64-81f227535c51@knorrie.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: knorrie.org; dkim=none (message not signed)
 header.d=none;knorrie.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:7422:e91d:655d:8b17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7237d8f-d5f6-435c-0fc7-08d81838b63e
x-ms-traffictypediagnostic: SN6PR04MB4318:
x-microsoft-antispam-prvs: <SN6PR04MB4318637DDCF090C6CA2200A79B950@SN6PR04MB4318.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChgqZAHf/+24BMAdYWvbHXNiULSy8u0jzRwx3R3D/PQxW1IxWr7svzVRo4/HPKEbWrSo8vo/yoby5IQKowjDDLFCcRMZYJSXc4Q2ylfJieHisrVzt5L2v/7caGvlGJriGaOIW0ah1iJkGoQSOe8obnzwS2M5k/6L/MXmQgzzn+KuUUhLyVRprIk3ooHCU4esuWagmvYxFOU8gFhkwXUq2OBp6xgpedb/X1xJ4Kdyd3gz3K150fG/BYYA+tKJlejvSisWczQ9LKGp5PAQBBkTqxpJ23XgGVwGT0QMxGPaXNUIrAdCAx5/PczERzvaYeZ0o09JVQ1shsCxZZNiDusuhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(186003)(52536014)(76116006)(86362001)(66446008)(64756008)(55016002)(9686003)(66556008)(66946007)(91956017)(66476007)(4744005)(5660300002)(71200400001)(7696005)(33656002)(478600001)(53546011)(4326008)(6506007)(8936002)(2906002)(8676002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JDHlNdnMZ/lrtAgmBOg18oT5kPo/Oj4rPMkt5XxnoreSI+tNNVMLKbL5iZsUY7hgDZrLfPw1YyAH0x5RPnviitIEd8iTiDvE3mChWH9L6v87vYiFohg0GY3imLH9iH1d/FtSofNoiQ3jSK4CNUzuIGFFqAixohvzFS7UonHeNAjlY5fn/k7gutBceJiTzXUWY/FLFt4Pgg4vTIOu+zDoUwraBbmBJ3e1mvJvQNlV0tpYqG9kT9r9cjmjVzU1CEPpiFIY6OsplBTqYkKN9CPmbBZyLIUyiAZEqd0Pq2ubcodiF6zxq0T/2eTLBRqceiDi8RRXOyttLkQ4EkyStzQ2PvrPIqupWCB0gjHVzwv618aiuvD1+oQeAVGK9MYzOSis5dQ4zXd/GsBrCc4UFk02zKLwSWwrE5fHcE59WyIWOnkg9t6Y7wNfZS9xhfECWN35oveEQjNKhOSA9/jrKjIP5kmo9m30/pgWrmgASDGJczeV0YeTRilmfwsqNycGUqqi2DQat44z8nALtGJDmPKNXyBkNH7moMoHkar8WOzbxKIGOSpEKPkkM9Q08VkQb7q4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7237d8f-d5f6-435c-0fc7-08d81838b63e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 12:18:32.6581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHa0AnzbWJrlN0Du3MhQ4H8IckGJhAnm4O4jmQrsk977ggCTGGspZzPLlcwlIHzjlk2Ci+QzXTezM+mosjPt4gHrFJzxjew4vqVBiXDSoYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4318
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/06/2020 14:16, Hans van Kranenburg wrote:=0A=
>> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h=0A=
>> index e6b6cb0f8bc6..161d9100c2a6 100644=0A=
>> --- a/include/uapi/linux/btrfs.h=0A=
>> +++ b/include/uapi/linux/btrfs.h=0A=
>> @@ -250,10 +250,21 @@ struct btrfs_ioctl_fs_info_args {=0A=
>>  	__u32 nodesize;				/* out */=0A=
>>  	__u32 sectorsize;			/* out */=0A=
>>  	__u32 clone_alignment;			/* out */=0A=
>> +	__u32 flags;				/* out */=0A=
>> +	__u16 csum_type;=0A=
> The /* out */ is missing in this line, if you want to keep it consistent.=
=0A=
> =0A=
=0A=
Whoopsie, thanks for spotting.=0A=

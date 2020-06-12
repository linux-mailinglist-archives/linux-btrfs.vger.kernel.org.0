Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF111F74C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 09:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFLHpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 03:45:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26792 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgFLHo7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 03:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591947899; x=1623483899;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pNKElhbYF3ALdXCQ7MMTmlXsW3Kh7yQ/xpfjRKc+qfI=;
  b=lZyFQ2hPy6SblO6ZpLWr4JzGFTl6ZMU2j7A5LOnER270Ax4jMKS7lezV
   R3Zl6sj0X5PcQibov/T9HTXi/VFNA1Gk5OXP33mfPJioR4JYGmtiTx7AW
   LBoEOVzdY0sisqA/A1DUZ/zfeFBWWASd8+pe34q2/Fj7P3b8MjtGgv4Dv
   twF1L+1H0cpJedKBrEpsmxAJ/yVkkMKpMc1y94fiHCwOB9fZVDDTBuv7s
   /LwDuiw7N3HDYOwZirYaF8KaO6RdeP/XZx6xFK2MKZMBOn8zeXJk7SUkY
   hjXHQpM4LFbSVRSaVHUCRqD5YuiSXUBEAVUOgnaaOjjgYSQBwwHaZ5Qlv
   w==;
IronPort-SDR: RZLlTt1pr9sXM/G2UTCYRdrAnkmJLGB8gVwB1GfEVdbRYUJCQxB09y4UjmyywLoppSM5fb99IV
 42Hp3lB0fRuq+f5lwdCyHTdA4tv2GXAMORGJDHRFLbhJ2jISakEho/Ba7k6jIUbisJ5IIRbyE4
 3nZ2mXCvZWVNcTXVEm1XJLugsH0T1F0avM6ycFtQNPdBXXHTiH8YD7jajNjL/x0ZPp5NlX+bfJ
 /gqtgmgOoeflbjvObjC6gUkQdKP5Ui+ERc+AFcu+H4ja7MKXZWaLHRrB+kXG7jUDtImcjGBMQi
 RtM=
X-IronPort-AV: E=Sophos;i="5.73,502,1583164800"; 
   d="scan'208";a="140090717"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 15:44:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6VUbKxXPLlmTCi9gfW1taA7kswvL8p0OYV6Nc1Tx2oGXCAOyD4K44M2XjbngoSl3v2bgau/aHUVMziuSTmVmeh90BMoqZLf9AJEXFWS7Dvk+9qaFiO44C0RPdAEoIy2thlAvdB2e0UiEGOxU6f36ltAl24qGveTaryE4yEAyFfMLD1NTKF/65GioP44RLXzRVxSin4G1R4/B/rR2MDeuxfP4c7mGxCJOzwOmKe51akeYDbHeKAcIz/H7sz+vf/1guEwQM0/kvK0M8OZxqRhlnPThzP3DOeLnN3p7/idABmd9TUEBblLISng768RB3gOW4b0pAVhGPJN1LlOGUbTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ8Lom/huVjMDHLE15Af6IjMYbbtQ6o7Wxw3YgHgpag=;
 b=Tvx4kiUlFDvFj4V8GpFhGIeteiMJ6s3h8zuP0Ofq32ZsWxa0I1IyURVnC4eSf5MIgaBGJRrsS5vZjYgkMHMLg+hs86imJ76+ClFf52TgTdu3IwqmjkXIbw9EIgOvtvIDdGBU/jSqxFV2sg5lKm37lthM81/8d7xZsEZOll0XzVirV6r4pfjVcVKkSTEC6V7Qxst3M0HZeFneVVdLSD+xklUMiBZ8U0dwSTh13TyHpqs5q0TJgu2QTvaRLlpYQ7Ny5MLDP7U18/FUuAWGq1x/bKn+1ps31mj74xQjAU8U0czt+K+Rcx/wtcuCwZw/K7XhHWO6K6QAoy8ChLfnBZDvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ8Lom/huVjMDHLE15Af6IjMYbbtQ6o7Wxw3YgHgpag=;
 b=eD6hFdUmZFwhXLqE0buenKhgno0Olm6d6f5GxbvNXjtR7BxliI9ps/c/46oogrZ6QZFi++7ZOB4U6VZbgOYzyXcp3BINfCAcvxblHawUi9Qwk6Sd6GJs5p2tYuUGf8YknR21MTEbcm6z8pMA4Kd3RxeRSm0jDOaWF0bTKa0+zHc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5119.namprd04.prod.outlook.com
 (2603:10b6:805:9f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Fri, 12 Jun
 2020 07:44:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.023; Fri, 12 Jun 2020
 07:44:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/15] btrfs-progs: introduce raid profile table for chunk
 allocation
Thread-Topic: [PATCH 06/15] btrfs-progs: introduce raid profile table for
 chunk allocation
Thread-Index: AQHWPyNP+5SHx+W9fUSzm9UdSBU+vA==
Date:   Fri, 12 Jun 2020 07:44:56 +0000
Message-ID: <SN4PR0401MB35981F79484BF3122973E0A59B810@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
 <20200610123258.12382-7-johannes.thumshirn@wdc.com>
 <20200611133959.GN27795@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef4685fe-5b17-474e-65f4-08d80ea48089
x-ms-traffictypediagnostic: SN6PR04MB5119:
x-microsoft-antispam-prvs: <SN6PR04MB5119693C6C9BDF6F99D917139B810@SN6PR04MB5119.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZVuxbwgSegm4Ps7rZiKBQXnY2KaceXWOzoEogQqX9bw+EDQXcBLwcJgo5jXvmDC/HXLY/QMJIMKpDZpayITDg9xbtdighiSXajj0TKhWrD+Tg2v786PbXCGkUu3/cW1upMXb0M6IunkabNp8+Z9lUbv9Vk2dYv5+juKaHh2nwfA9TnxwajfG94D1mcFteMJi0l1iho+1ugHA/smBmT7m1sq+bXTsAOpJ5kO/X2VCjYBhAArXqb0q4JrWkEK03Xuf8jGH5rubaoXOxn2CQHrc0BHwMKRY4dNNAi68iu085VLL9wkKw1XHiy88pfO3xnvRNZuDcMdew2jB3sJGKx+1Gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(66556008)(6916009)(71200400001)(64756008)(55016002)(91956017)(478600001)(66476007)(8936002)(66446008)(66946007)(76116006)(33656002)(26005)(86362001)(4326008)(2906002)(6506007)(5660300002)(7696005)(52536014)(53546011)(186003)(9686003)(316002)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XsClVq35TyRj4m0yKZdwHzKzq+KKSJJZBAZBYiWGPOmvTgzU5tQZHBugdtz4YCgbhQv6kc2U8TYuSkZHCYJj30G8HWLK2fPspCFd9IVf4BARlpBWsCyYIez6pzjQiJTbFKOnDh5lOTPgT8kV9M5aptMHdsWKNJbrHePRBmLLg1aDKSnQAeFUHS4J9u8KwBL972qahD4RqIh7jsJa3eDqVbmkgy0y6Gi9qEsi6LGTA66Q0h1yz1EJWf+nbK79PehOmvYf/UFRHGOnuUmip6vLvNgWmkxruaVS7K3CM/Nax7F/8F8IqZrIZVmDVO++31yvQYQOco1X970NlXm9SuN50t8ntQF3AtX+2LIeG4848rvwF9TNHckvIZ5Gsw4sr/47hNJHJfh/gv9a2tmXLLcc1X4tKuJr1ivcHKR24wDBsmcrZXFf0YfugfQjnwCjU0BbjY3bN6OBjKTqpfH/nZ9QGJ59AMxgkrOktLk/xXkafeNFaAaOxzU1tDfvNNHRP7pf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4685fe-5b17-474e-65f4-08d80ea48089
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 07:44:56.5839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWYn0TvW0ilBc2jh/wZYFfLHzFJ/QZyQrGTsru/nua6lQ/iulrNpeQXFfZ4VLJ/kBEGnL9+7LhJRspeeFTJeAwoEa9zWNtkq1fgYPs1scFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5119
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/06/2020 15:40, David Sterba wrote:=0A=
> On Wed, Jun 10, 2020 at 09:32:49PM +0900, Johannes Thumshirn wrote:=0A=
>> Introduce a table holding the paramenters for chunk allocation per RAID=
=0A=
>> profile.=0A=
>>=0A=
>> Also convert all assignments of hardcoded numbers to table lookups in th=
is=0A=
>> process. Further changes will reduce code duplication even more.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  volumes.c | 95 +++++++++++++++++++++++++++++++++++++++++++++----------=
=0A=
>>  1 file changed, 79 insertions(+), 16 deletions(-)=0A=
>>=0A=
>> diff --git a/volumes.c b/volumes.c=0A=
>> index 04bc3d19a025..fc14283db2bb 100644=0A=
>> --- a/volumes.c=0A=
>> +++ b/volumes.c=0A=
>> @@ -1005,6 +1005,68 @@ error:=0A=
>>  				- 2 * sizeof(struct btrfs_chunk))	\=0A=
>>  				/ sizeof(struct btrfs_stripe) + 1)=0A=
>>  =0A=
>> +static const struct btrfs_raid_profile {=0A=
>> +	int	num_stripes;=0A=
>> +	int	max_stripes;=0A=
>> +	int	min_stripes;=0A=
>> +	int	sub_stripes;=0A=
>> +} btrfs_raid_profile_table[BTRFS_NR_RAID_TYPES] =3D {=0A=
>> +	[BTRFS_RAID_RAID10] =3D {=0A=
>> +		.num_stripes =3D 0,=0A=
>> +		.max_stripes =3D 0,=0A=
>> +		.min_stripes =3D 4,=0A=
>> +		.sub_stripes =3D 2,=0A=
>> +	},=0A=
> ...=0A=
> =0A=
> This duplicates btrfs_raid_array values, the member variable names don't=
=0A=
> match so this makes it hard to compare. I wouldn't mind to create this=0A=
> table as an intermediate step to clean up the code but in the end we=0A=
> really don't want to keep btrfs_raid_profile, in the same file even.=0A=
> =0A=
=0A=
Yes I got confused in the middle and opted for this intermediate step. =0A=
I hope I can reduce it even more and have it slowly converged to the =0A=
kernel's implementation.=0A=

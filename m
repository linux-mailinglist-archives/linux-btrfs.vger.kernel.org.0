Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474923980E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 08:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhFBGHd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Jun 2021 02:07:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44627 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhFBGHb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Jun 2021 02:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622613961; x=1654149961;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sA6fFfZLGmtRO23nracsKHAG7o8UXh8EfZDhITVWVKw=;
  b=YOlxT0qHhP08tdLObeVojuorlcexAOHMoPDhlicE8gEa+BxgEws9kHDc
   vEWfgHrKf/41COTu7x+3NM3fuhfLxV4idreO/jU/M2x+T/08nzbxQSi1/
   kz1xVcLqTcC2HL4YDBOGCyBDPthxPbkkSTsFlxWYo8ApCrYQOMl60R+Xr
   Rl7fGEAAkjaS9l2xQ6UAs2sX5phrYnaxP/5T7XX/RNn3POJh9zUXmHRYn
   zaoGynPh6hPJIQMiEHQigvo8wdNsRyufkKHDXBbOkg1PuJv68KDUM9yRc
   E5dM7VEF541wUFt+3ImYVXlIDIUgU9/c0lYxeHFndloNbVqMEsVOrvjCw
   A==;
IronPort-SDR: eIop4G8EYLKmseCoZxIvTWWUlAqwsHdZ1i/UrLyRrIBf3XoKQrOUuMeW08YBVZ9/Gd4v27avAg
 GqaM0R8B+ha7Xak4DtSeEZbU4nMk7j8U9D349Db6UGeUU4kZTP6ea/r5ExiDUxa1WG+PX+LPGZ
 mVqoAgbPtmprD5i363n1h4XY3p/dg4Uangw+QTh0sv7iLWfmkxFQPFZX0AqX0wnZF5/K6V4nNi
 LsrJURS+Oz9rwO8Gpth4HiU3O3nT0ubIsAG8oqgK5xVBKp5xAE8REF/38uxgVH8BMRGydyKaBe
 eTY=
X-IronPort-AV: E=Sophos;i="5.83,241,1616428800"; 
   d="scan'208";a="274255043"
Received: from mail-sn1anam02lp2048.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.48])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 14:05:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxy6vfkRiCGu3ivxnpTekJ8rtAmN3+sDk5Q1LoUEj4DOH/UJGlmjYYlTuuR/bg7kZNL4uYYKMw2G1tdP4nMm5PK9fc4ZwUDI7EVaUi2KFj71+uSOPCmFluYCRiIVxZ0R4nQJVOKEehzpgfBJK8o4Yen1TZCT3DurkBfK8eoMFaX2IkQcOqr7tv8h3KnJCgfByzgk5f1ZF4P6zP/inHQESl+HCNDowepn5eRnrqMR9Eraea9N45EnpzlRN3u2cczD4fl0BeJOhyLFTRCu3xndcvroiFZjdZ3v05BZ3lE3S4e/W+N48towaQWLKM3DOxPujPGc2H6d1EfznyiZrDXc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsfxXcZhOeZiiEcvPGoGHCciFho8riwoBl0xbB3jn14=;
 b=eIaSL08yBrjBowQugj4h9vv/nKZ978kZ9pQVP9lLkLMJ2uNlBqe4+ix7rcFej4YSRJAmPLaLdI0J8Ex1K59CAvGrr7b3Sg1grvOgrBVLOpG66BP/frzxaWe644p9eDD8OGrkKgvefJYnhXwRBH5fbt3ju6dXULzvXr8iehWB+2aSUIMybX3wLr4GQJNZNUVv2frPQQG0MdvPCd9kgkta8Dfh20mohfQqhGlcZ5aKHYdu4jCQwCbVrrl2y4Ch7aTCf9z5a64DTkeLWqMSZZSApG5RQ14y39ktZRSzzKGUbTYg4HUqFEOm2uZnVWo62UN9NGKvxLr5G5LB4L0avfOWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsfxXcZhOeZiiEcvPGoGHCciFho8riwoBl0xbB3jn14=;
 b=wKOuML0zAwi4+x9okBixi+U7abt4sy8dXuys2rvUpa5fsRNIZyJo3MYOlE5pxGd5ZFF+0TCnbaJMuNSF+XAo7ZBep7AmVqgc+cjdqE4heYDOW4l+TX064PMuQFAWYYS2Kb1wUSVoFi1tQl060gOh1123Y1M+IMd0i/WM85oiuN8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7718.namprd04.prod.outlook.com (2603:10b6:510:56::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 06:05:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 06:05:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: limit ordered extent to zoned append
 size
Thread-Topic: [PATCH 2/2] btrfs: zoned: limit ordered extent to zoned append
 size
Thread-Index: AQHXVuZd/Q0WjWSGzE+6rMeHLS3qpQ==
Date:   Wed, 2 Jun 2021 06:05:45 +0000
Message-ID: <PH0PR04MB7416169F15A06D565C175A899B3D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1622552385.git.johannes.thumshirn@wdc.com>
 <da3a097233a87541120dbb2a9624841c7a9e3962.1622552385.git.johannes.thumshirn@wdc.com>
 <20210601161747.GH31483@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:416b:4dc9:f9aa:4596]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39307f5f-1186-412f-07c5-08d9258c7659
x-ms-traffictypediagnostic: PH0PR04MB7718:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB771837688E230788B9A095EA9B3D9@PH0PR04MB7718.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qc2CV261+BvBiq6wDUu5Jp5IW+DzpXg2dE+kRUiViTaNAq6ZmAhfvmBjqfiHHqBtqNvn4towX47kIj3xATfvjB0n1/hDnUj6cCLcgRnilPt+uYg2qkrvV5kbqEXXmYW1fkcHfuMcs1foWpSqLODwvlDcuYSVBXmHU7JTN+ywgOlCpeH5Cjxs5hvEC2hGftySPEWHZtxAs2BuRM0dbwiZYNeUZq+OVWApu+qfI28ibVfmIa+bTLzMiKnOjh70gWQ7VtK5LVVjOU/mEzUWdicGMPH8Xu3Yr3lUpB/039G54EcnybYlctzAnkcOuXNsmsRqdBHMQ0rRAcr0b/7PH/BTspZi5EH4Ks4b+uQLw3cB5HJuDxZoRSULftvKhmzRucRMKESvkSBE65uzINrCPPPSGhkT6jWfhqM9QKBmdQc86aC8RBY9yJRDfx1g3x6GZcDvEQwXvP24sIpIk8Lcg1Pns7NL/4xmts3EvvkQ+hsgDb1APdnNMFe8+MBgOZcmZk0pz2C1nM+1FEXui65VdPMKgbYlMFB3KldiYgLqOrbf4g9d1ZHOgb6uOyUJLV5dYyia01XWtXV3iAZCzgWqFHkifChrtIR2q5DJJibP/GMD1qY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(66946007)(76116006)(91956017)(64756008)(66446008)(55016002)(186003)(478600001)(66476007)(66556008)(9686003)(52536014)(4326008)(6506007)(2906002)(86362001)(122000001)(83380400001)(71200400001)(7696005)(54906003)(8676002)(4744005)(38100700002)(33656002)(53546011)(6916009)(316002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UOgw8VELrSor6CqUQffRBFoPNqp5DVU6k5UHFs1G6S7IyuknYqIQo7v0C/7T?=
 =?us-ascii?Q?3uXww0Bo0Gpsz1bDe+hx7rfENLUANg3JD9TPSEEI6EyH+6EHqsWqkAp0kqay?=
 =?us-ascii?Q?UvUu+nuXmtM2DOWHXn52EasjcaqWan2lGfLISn3xs5b+XlFZnHP6FeopVJMI?=
 =?us-ascii?Q?rAweLUK9P4u7D1maA1Q87zMVVYh1+/H+qiUWPxvVrOmDUzYMEGbBn1tc6g+f?=
 =?us-ascii?Q?fycGzl9FSGQucxqNRlS2afs1kgDzmMy9WkB+0Hh1p/akd7cf/C+BmRzHoXJs?=
 =?us-ascii?Q?xV14EIHHj3ciFAzlBUSINwdGnvea1k76oPzd1dNhXPbpfsP5MR0gxPK6e0Dx?=
 =?us-ascii?Q?IuEeLa2kuxknry0sFRCZbJUE6OyaoEGTMKHcginEjJCZUidxrREueSyu0zwO?=
 =?us-ascii?Q?0+l72hYNLHqVeeQGewAYIXIHsRKGIGymXM4Ev402CR42geMxD+u4gjH5d/5h?=
 =?us-ascii?Q?Et1td3qQEY3ERhM1IKuKZLoqDTcYAGym5RLdaf+j6XTzbxKkCgRgQxa09xj1?=
 =?us-ascii?Q?lnWSIreXx5jbwkkxqH/q8HY0j46Upkg/ftJ3ZHbIC1s+nbee+hexeOAiTvm1?=
 =?us-ascii?Q?g8Dhvk+tdG+Dy8ep2doGM0t7Jox2GLB63GSUccfruqLR/SFDzGiBrAvsLBQq?=
 =?us-ascii?Q?oGtyzGxCR5oCxPjxMNOHDUDSP6Hyu+vjf287320Nj19ZNWP9XN/wLX+mYeWc?=
 =?us-ascii?Q?1jw9dxqxusLxTcjhefp5IT8BLc2Z5fOJC1ISizjZLir+pCYRKOy/PBwwJI1T?=
 =?us-ascii?Q?vniz7zQxK85dESb/LPLPDz3mqXczF3yyKJX1O0N2L6imsa5P2WFyit/M25W0?=
 =?us-ascii?Q?wHxAjgplpk0SvuTGF+fa9i73WCn30YDIwikyvW9FjlRhRRPwfMCmVy61pXJ/?=
 =?us-ascii?Q?Q5763RxkWWco4S2D6H38DqzUWci0Bm7Icd3+WMV6ge4SFNkMja6sebQi0e+4?=
 =?us-ascii?Q?2Lafinlc7dJvE/Rk29d210XVCHGYuuUy17hI8mdtadhOH/mlbx8FHcvh5V28?=
 =?us-ascii?Q?n7vA7kdh6TjAo3RMjPNqbgk1u/mw3JDMju7CheDcR7lMSwPCZ8uJw4UZhnE0?=
 =?us-ascii?Q?mPInnxHWKFOoF5XeMzBDQzvCm4so2ddB56UTo5K7+2Nhl055o//2HhMsa7yI?=
 =?us-ascii?Q?d1A5MytAUWA1nJLjjYM5IkZChNAJag2uZzI6HnDiySGukShLFk1pih+2eHbH?=
 =?us-ascii?Q?SNJ5JnCV0eeEtpMBd0Gg8iUpXQwvfR+6yPsgNm5Ko5jh8Op5TdokmGt99Lwx?=
 =?us-ascii?Q?Ocdd6mqGUg/zsnSDC+CHkBTzXirmfNzA6hPdPTjTr4AeAqnPwD+118s4dU+w?=
 =?us-ascii?Q?D4+mTWmbcFMCkGx2hgYUZDJoIIv3sPiDsyhWNxk4AT8+oXp85rxLAAJUbJZJ?=
 =?us-ascii?Q?1CZoFWeOv+yu4f33G1+I6rDLbF0s71Z8scd0AVdW3Pp3jUV8cA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39307f5f-1186-412f-07c5-08d9258c7659
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 06:05:45.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8xM+tWLICSTPL+Yo4zi2XUfUEewanJghB0FSSQ2TDxIGaysuzNdyZzf/OJMothBsG/bEG8GObibbQaS8kkAFUxmoOlgkHooEZfaMKBxzng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7718
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/06/2021 18:20, David Sterba wrote:=0A=
>> ---=0A=
>>  fs/btrfs/ctree.h | 5 ++++-=0A=
>>  1 file changed, 4 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
>> index 5d0398528a7a..6fbafaaebda0 100644=0A=
>> --- a/fs/btrfs/ctree.h=0A=
>> +++ b/fs/btrfs/ctree.h=0A=
>> @@ -1373,7 +1373,10 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const stru=
ct btrfs_fs_info *info)=0A=
>>  =0A=
>>  static inline u64 btrfs_get_max_extent_size(struct btrfs_fs_info *fs_in=
fo)=0A=
>>  {=0A=
>> -	return BTRFS_MAX_EXTENT_SIZE;=0A=
>> +	if (!fs_info || !fs_info->max_zone_append_size)=0A=
>> +		return BTRFS_MAX_EXTENT_SIZE;=0A=
>> +	return min_t(u64, BTRFS_MAX_EXTENT_SIZE,=0A=
>> +		     ALIGN_DOWN(fs_info->max_zone_append_size, PAGE_SIZE));=0A=
> =0A=
> Should this be set only once in btrfs_check_zoned_mode ?=0A=
=0A=
Do you mean adding a fs_info->max_extent_size member or =0A=
fs_info->max_zone_append_size =3D min(BTRFS_MAX_EXTENT_SIZE, queue_max_appe=
nd_size())?=0A=
=0A=
I'd opt for #1 =0A=

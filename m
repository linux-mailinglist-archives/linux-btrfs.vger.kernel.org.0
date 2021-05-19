Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904C6389353
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 18:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355164AbhESQMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 12:12:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23770 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355147AbhESQMo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 12:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621440684; x=1652976684;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IGqKmX5QiS7n16hQGUsMJfQiCaDfMihvhntN33tsdC4=;
  b=C8sl+beyPowNgbphDKmwp3T8lteTo7pHr0NGvq3ZpvsOZKDQ2+I+QpGB
   e9VGA3J03q8vv2JZFKS1o/Nvi+0evdsKblPR2SAM5y04TNKi9uPkZ8+uD
   qroJxqNpLVApPkSa3/OJjAsEgJAtZL4mfPbAFgdP6bSPTVz8hU5+KA66P
   xKQNjh31WT0cz3nm53ukkDGGElH1FldsMxAFPWFuX9m7J0FcTXt1N1IAA
   D1Q8V8pYOMRNwpGBvpmolcIP1DQitWe54/np0fgaBxRmFK9wlp/DTcf1t
   SkAQyvAYOW8AQySQiBAcqVXlpofp4tjLrwjs+kNORfPK+fs5KJzMmJgZy
   Q==;
IronPort-SDR: qPieHd1Givt4RZAddGbmEJ4Q3E2aZZIbadL10dIzqzN54O0PViXHM/tnjvuMR3XaRKES+t3D++
 juh0zETcPIVWJn0r00KV8gdUJS4dEoG4MsoeaW2yj623lVFbD9HqVE0ZL+w96M5ayfiBRpTUtV
 hNcWjLk5IBpE+RIvBJDCZhKp3pdtc1wbuiN2B+dD1fzmZ4J/KlMWH0V4KyQhxwER3ROyi9RHW6
 vLHcm28Tnh2L1+oGN4qQ9sQtTVIqZ7KLgUjw5qojcKMgZyM5N1qBEWqz8smY3/JY6cOaEShjLx
 OJ4=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168722057"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 00:11:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuWoZYciDJrWLEM8XjuJCf+pUJPSbRk2byh7/Pcs9cH0C10m2fWHGax5r7Cmd9D0tJbRqSnivPNmK/SLzeSC9XNrKKpHyqVzzbNVntYrcg0taSWFsrgeVzDfuSyx7oU51D2xz9AjiE2d1ftLQQDi/Sgdfa9hzhMLb3MN6swY/Id6apWkH9b68ECbhUPzrmTIcoXmqnvspJzr81EUW5dG54onK3vVq68TBT6abxvWlE0dQOq2rE4N8cftwrhmhcScZleuSb38HumjLe31oSAA83LrsKnAZ6vIzDcY2hwqhf76cgZhHoaWmO5gdBBHv88Mx1G1WYMjbUxnPtqrMhRnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2+sP0TySNk5iuRFe/Ux8nvDOTRklpzH4P2maMPKxqc=;
 b=JLOdWpa3eFQxpJMQMo7tMEJoiriWy6ib0nSpKIcsJPq0/D2dYJpHLEykVZfpx1ssbNqUCNsJpOYJjtRISx/1bLV0a5cB6P3owzPMpbRsVG6j7j1KhLFiLQuyIE0RqKgOCqq7Mopn8eC64BK8oTKwkf1c6WX4wrt9SJXROzONhWmPm4U53T+CILSekXo8lDxIVgPkaRz6cPmns4UfK0MAEHkA+VhiUsgxjGzAxoaTkIyklHgkP1vaZXMJfpPbw20LeYgyyBWjF9Ft0MZrfo8VNYm51xlMiYofLx0uJGYcXNk8ruhj9ZLjkvu7pz9VTqZiJBSdnWIlO7emHGPwQlMwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2+sP0TySNk5iuRFe/Ux8nvDOTRklpzH4P2maMPKxqc=;
 b=GTb5BSFv7krlQ2ux8SHlVWl+Sme2R3iD2sah1nY9hHHwr84B8hBmt1pt8JUEO4luPBkaaA9d6CDGo6n9M7Q0U2f6aieRzLR2Vhef9pmxMC6xRdlUXMlibUIrbacgVSE8aZwYQb1o+sTNhB5tPgRbi44JZSNG9DmDVIdUefVZuhA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7493.namprd04.prod.outlook.com (2603:10b6:510:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 16:11:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 16:11:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2] btrfs: do not infinite loop in data reclaim if we
 aborted
Thread-Topic: [PATCH v2] btrfs: do not infinite loop in data reclaim if we
 aborted
Thread-Index: AQHXTMX95t9nPxhSE0KdrpseOrIMqA==
Date:   Wed, 19 May 2021 16:11:23 +0000
Message-ID: <PH0PR04MB7416920AA5234C219180EC959B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <33a744a9768b0a46b8993c1fc39bacebb43579a9.1621438991.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:95b:718f:422f:1ec2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19044ebe-5585-4713-15a6-08d91ae0bf42
x-ms-traffictypediagnostic: PH0PR04MB7493:
x-microsoft-antispam-prvs: <PH0PR04MB7493AC246DC865679C6BED309B2B9@PH0PR04MB7493.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQ49wNOgBU8Pq0OGwvWRvlOryJlAkYMVPFBiIoHFzjJuhm798fgLCqpTWiMul6rx6m/pJJ2WlCcPcc97+81J11LjkQQx8k+oVCQFElGLwXH/goOouICpiaIaWHEo6V4ShOZ3WApduC47p5jETLLyKTBrJROzhWxbT376XwXIobYtzYyo7RGq1Yqc/QJjq63Ea+xdapR6ux6qnL5jQeLVpurxBg6Dkbd5RRv9lbAjHDFkHRVjWZllgMFRkC4QLteTgAxZfHfxzkJNGv73iu1ljRbyeRfIxqfAw5Ueps12StTjtNG2lgcdZXP/DvrdpTYJG/h2XctXO19rWP2X+oklDGgZeNghRvEj54h43RC+5hk08u1eLWdmB6WfL1/TtZ/DBRNrOO8o331gM5TsfxILOniJ63i29yTeH1qH36BrYy0QMSSVVFSZ91dJ619Qil2ITX2+xJmcsWJxtVte3YmFZAkpK8NJ2TWtbcJI6cxaf1py0LvO9DLgv9hJoMEc3gi+vTVigYDwESPGpgcjGMP/EDacRO7ofKOsw21tp7jE/xpSXQEQ3zZrnDQiQbeWT8Dm2nmL4B2sXuKP0FNyhEP937kqoBhW2Ds+zUdBuAWJgSw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(71200400001)(83380400001)(66446008)(7696005)(33656002)(66946007)(66556008)(64756008)(110136005)(66476007)(76116006)(91956017)(38100700002)(8936002)(316002)(55016002)(9686003)(2906002)(53546011)(86362001)(6506007)(122000001)(52536014)(8676002)(5660300002)(478600001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FzSFEq7J93UydOCEYA8S9cVaalozXSJP+fymIPtGDoxAxqWCOoK+DBvv08Zc?=
 =?us-ascii?Q?OHAVd6NanWkhl14YwmYzhz0t0SA1/D4EPpaHm5Zp2i90azIq2LSioD5cl8kP?=
 =?us-ascii?Q?I2hZUs0jagK9VvPGbe2/8ckBeRAbQkiv+6C2Jdyjo+YOga5gnFq1Xe/qRn4q?=
 =?us-ascii?Q?as5btV8WNrLmFnLlkHK1X51L7t+NmZ5tZS/HEfceDNiBIW2/B+vYo3p8V9mk?=
 =?us-ascii?Q?UNEH+bGkUoe4SsQ6H0ID2h+VLiMOBJgHq0KusGC08KcZshiEiPitCPbm1iEG?=
 =?us-ascii?Q?2n8I/msP/5hX/atoDPF0Sycz/DixZAmI7x81seRgykE9TFQmW0Jvjow1UB0t?=
 =?us-ascii?Q?53wEVD6FCuxwAoQjto7ToSUs/iq97v1X0Sg8I/n6SKHZtf5rAlyJjGyFzdCh?=
 =?us-ascii?Q?oJPiTfRUuJCEE6Sxt47h5l9Z6r4ZSMQeo3lJSLNsjXOu5z07OZz3Z6jp/ObQ?=
 =?us-ascii?Q?DzJugM6Kj+YlW8pAftxAySYVMOZSgkcgljcLj+ugtdIuztlWBPHmEskBHqme?=
 =?us-ascii?Q?uXTrg7d9gSGctLpzYHTFA5QXsHtAkEPKuR5Yq2iHmXfgkfc5Va92AhcNDRck?=
 =?us-ascii?Q?VUkO3rK762sCs6b1enZbkoXKaEYx4edQW2/RkmTFmQM4vzKbroocil3C75oN?=
 =?us-ascii?Q?5GLDf4vLsA1haWdO6yTCw/47b1yBmJ7ldtHq4KaPkxjvZ27lBHvJHb/o907X?=
 =?us-ascii?Q?XLLbemswVzAonjXGL6NMMyuUMTPca7d/AMY+6OfiSJ23YRZEXtno3o4mQlXz?=
 =?us-ascii?Q?JRv7YVzWnGPIFgxlQgdALEW6uiyiw/aozB5FllYcdmxy1GFBG3U0TS7kvBWO?=
 =?us-ascii?Q?f+AmQykSseEQ+Qyrmk7cJ7L8Jqd+InaEuo8gmitJBSRSigDhsd7jF09sBQem?=
 =?us-ascii?Q?J2uBEr6qKv3KMPLmchmWhdr1htiDEnk+el6HCc2Qztr50hTg2J5ojnH4xJdf?=
 =?us-ascii?Q?QglFpjekJXiESxlgMszWlOm0+vsuS7ELPpE/pnAu8uRdwwwGBi5/uNTNFlJO?=
 =?us-ascii?Q?EIBRE1zyk6Ga3KLSQDfltbvQaGyKV8QvGaEqbTgngwEwQzL4689FrMPGT/M0?=
 =?us-ascii?Q?9WpWqIHNbZcXm3zACe9EDh/9Y262gujV+F0mKB9KBehJzy1Nn80j2hFEM4gX?=
 =?us-ascii?Q?3YA4cY2PZQPbYQclE4Zh+yzVdTknmsn6gUjM/g/dcrYcBX2RdUQh96ZRMZMr?=
 =?us-ascii?Q?KgTAyHeDO49ptWPV0lRyfuGuE2oa6p9RLxGW70cBqtTAGQlFbI/mnXoWzMUX?=
 =?us-ascii?Q?+RvtoisRVfiMET3xsPNlU2QbrICxq/Dn760lEZDnuEUkhLcozq9pHBvK7Gx6?=
 =?us-ascii?Q?YuxraCwWp/mlHWuILztDsWa7Z8/yPEUTw+VecrGRfC0BV/HVXwvxUJYTvPvR?=
 =?us-ascii?Q?11FFFLzqUwC5t6q98HjDqyH80j513hsMI+h292byakX6RoZRvA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19044ebe-5585-4713-15a6-08d91ae0bf42
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 16:11:23.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/6E8ssLqQi8dE8pBPPEnl+3z94k1bmvpEuspagEebtXa+QgrScUGx56GWGSo4PLdvX22JKji2Ibd86f+ZIJlY2JfLx8vfUhuunGgXaB4+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7493
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2021 17:45, Josef Bacik wrote:=0A=
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c=0A=
> index 42d0fa2092d4..0d36d684d552 100644=0A=
> --- a/fs/btrfs/space-info.c=0A=
> +++ b/fs/btrfs/space-info.c=0A=
> @@ -941,6 +941,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_in=
fo *fs_info,=0A=
>  	struct reserve_ticket *ticket;=0A=
>  	u64 tickets_id =3D space_info->tickets_id;=0A=
>  	u64 first_ticket_bytes =3D 0;=0A=
> +	bool aborted =3D test_bit(BTRFS_FS_STATE_TRANS_ABORTED,=0A=
> +				&fs_info->fs_state);=0A=
=0A=
can't this be const bool aborted =3D ...?=0A=
=0A=
=0A=
> @@ -1253,6 +1259,15 @@ static void btrfs_async_reclaim_data_space(struct =
work_struct *work)>  			spin_unlock(&space_info->lock);=0A=
>  			return;=0A=
>  		}=0A=
=0A=
Although this pattern is only twice in btrfs_async_reclaim_data_space()=0A=
=0A=
	const bool aborted =3D test_bit(BTRFS_FS_STATE_TRANS_ABORTED,=0A=
				      &fs_info->fs_state);=0A=
=0A=
here as well?=0A=
=0A=
> +=0A=
> +		/* Something happened, fail everything and bail. */=0A=
> +		if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED,=0A=
> +			     &fs_info->fs_state)) {=0A=
> +			maybe_fail_all_tickets(fs_info, space_info);=0A=
> +			space_info->flush =3D 0;=0A=
> +			spin_unlock(&space_info->lock);=0A=
> +			return;=0A=
> +		}=0A=
=0A=
maybe_fail_all_tickets()=0A=
space_info->flush =3D 0=0A=
spin_unlock()=0A=
return=0A=
=0A=
is introduced twice in btrfs_async_reclaim_data_space, can you add a =0A=
goto label to consolidate?=0A=
=0A=
>  		last_tickets_id =3D space_info->tickets_id;=0A=
>  		spin_unlock(&space_info->lock);=0A=
>  	}=0A=
> @@ -1283,6 +1298,16 @@ static void btrfs_async_reclaim_data_space(struct =
work_struct *work)=0A=
>  			} else {=0A=
>  				flush_state =3D 0;=0A=
>  			}=0A=
> +=0A=
> +			/* Something happened, fail everything and bail. */=0A=
> +			if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED,=0A=
> +				     &fs_info->fs_state)) {=0A=
> +				maybe_fail_all_tickets(fs_info, space_info);=0A=
> +				space_info->flush =3D 0;=0A=
> +				spin_unlock(&space_info->lock);=0A=
> +				return;=0A=
> +			}=0A=
> +=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC414785BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 08:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhLQHv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 02:51:29 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11266 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLQHv2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 02:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639727487; x=1671263487;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+OOMwD9uRrFCr5y/fGx3dEeVZJHXAeAHsyvmPcOUCZo=;
  b=O8oq+8LM2JD1rtuHtNbEovrkbGqb/JwMM2seguF+h0D9w0ULE6GNTbQ4
   lPaNljD+oT0sWEim1qGWSXVGQ5gdIjvdFuEJScEk08PXgbDt3pUgBevWV
   OUpLWU0vN1DHJ2AK2tgNA1UZJs0VYMvJaRZjjg4djdfbrCH5Pj7t1Hoef
   mIhgOYAGLB+JNzIyufeCGNp0cA7udXzOPl0hCCb5ntyHKS5ft2+tWvCKW
   u3VYvMfTXVINsNRoyHmEHf15ZMXXWRmaRYbFumL5ekaN0wGYQYG61X639
   2d6fVjeZeKa8Qmm+KqE3qV4iAHF6fNCMhgLXK277m4opB3PIlP/GujGA4
   A==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635177600"; 
   d="scan'208";a="193286892"
Received: from mail-sn1anam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 15:51:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQKdaZyMSmabApyWuAJdbaCpBIzt8zD7AVgLYZKEpDmu4ILvEgPf/de+jkgq1Mjc63Mh4t0znQjvyM+BRSWL+LFDLElfHfqMe1AUQ2ewXJn2UyYLfpBcPueLinWmz+7o6825yfpyM/a9GEC7o566q/uLzoFM++xZLxdQ3JQNKmH8E4ZSEoY+hG6TUdOwHzOazyEBw8fdAONxuHRtzTmgepMsc4kyFkI1ucthPX3nMMZ9J4KRQrxteRXnug8hc1fJW6n4fEOGJjzWZt4fVI+5WerwVCOwXpLSPa9HynG5kj8zt3Qw6UDf7wNK5J3kD2kbA7CYKmIj2QgBsL4GuMt9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLgA0XqMLNDqUUipyPw8HY5r5Alo3S4wKh1YPU6vln8=;
 b=SXdNmZzoU+Me5GpTOxv2zzFzAb+onIiyWettXHI1ef4jL6+ZrkU5hTB9DI5iiRNXc+itDUW80sJC905HFqfrgoTCD3cHUWx+JKQcpUxwd9HLjAIh1VtFEC/EoKXILzzzCt+b7Z+PTTyvSw08qtdpGgnj6Y+4AVC35j7ZNH8g94fnHm05MP6A1mDpPffzrzxGLYx1I8j/M/Hv6j2HK3pZ9+FXFB6+G3DRq6zziF4uXba8jy5fFsq+1V611mpw2JHFgdYxgb5WPKaqKb3g3ObY1b81IeSg2lt25yiULSSZ5FAmKrje3zkNiuab6rxf4QhUAo0+Ee59jP6I19NtqgsMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLgA0XqMLNDqUUipyPw8HY5r5Alo3S4wKh1YPU6vln8=;
 b=XLi6aX/snY7FGU0av2W8aq/IeMqVVwPrwChdvnQwuZ2BKorgwTwam3PzSLyKnRwGXNRnxH2U8l3nijQMCfvgSxAWKNf/x6XMsBYtEpvLp9ncDyyYYulXVx+GJ3IvUq2sKwXtpndAgldC8AJ24djcF9mjWpZCBmr4uBilc8WROks=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7478.namprd04.prod.outlook.com (2603:10b6:510:4e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 17 Dec
 2021 07:51:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 07:51:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Jingyun He <jingyun.ho@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: unable to use all spaces
Thread-Topic: unable to use all spaces
Thread-Index: AQHX8cCfADTzoO7gRkOQsXIvZjxgsA==
Date:   Fri, 17 Dec 2021 07:51:27 +0000
Message-ID: <PH0PR04MB741678D21AA0328B07AD69689B789@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
 <20211215155059.GB28560@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43bc6989-576f-4f14-d943-08d9c13207ca
x-ms-traffictypediagnostic: PH0PR04MB7478:EE_
x-microsoft-antispam-prvs: <PH0PR04MB747841ADB9F5346FBD948BB79B789@PH0PR04MB7478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hNX7Re7/PV7aaF1i6jqLzRRWyGl+GO+5BD5E6ScvQXNPknv8lqd/1BslGPLOmr57OhV6bD25omBqLr4SQ4uZcRlK97eWAI3JreyBfrHzeAH2dJCM8vtjQOXlJwUobXh1vV0N6NQaKt2fsaYoaLuy/BoR+yiXLUUQrYhWsSoqIhILyly/vvZXmdAfJHpSr5bE4avNeHT77VRuDjdychrv/1MHjHfXhNwSx3TpS+GmgV+yfVnQ873heQupCrUDHBA9+QYBfe0HJq3K/WNS91rJLcY/aREiogqRZ/pC1J39uIzurQ4nIMb1D6rAnTCBOHZ+/+abBiEsDLZuug+Swj5bFDC/v+ASaijNC0FaV1Yxwh+uKOTDdl5DP2ueOEXFuMAj571ZLpmdp7SsilAv2LbXo9cEaQrCK1SUAnvrT1sN212nGAM53aoieBzwTjNFZTLL3zF5PQvGsOx0DeKb/P8JtD5jv0fmlNAdGUEVQ5Nsugqo3fwhrKfUI48klbd1KVXCjmyPujBiLSkrBDMPI189khhHPEf1Yy/uco6Qoy/9DygiQ3ighlI5ldMIQz6vjZpc01NVRGJwGlIM5oixLNG9uTcFL0AJHyAe5tD0qmn7T7RRSfAJLfpPTBEjA1LSM6PLwLvdIRWr+mbiNAgyYRRW8oeFMrL77XmGtyGcJakrTk/inlnNr9rvvGznZWenyC6S1KeV4p49L3QfAA2Y3KQtdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(4326008)(53546011)(5660300002)(83380400001)(6506007)(122000001)(8936002)(2906002)(110136005)(186003)(38070700005)(316002)(4744005)(91956017)(66446008)(71200400001)(76116006)(66476007)(86362001)(9686003)(64756008)(66946007)(66556008)(33656002)(38100700002)(52536014)(8676002)(55016003)(508600001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nj9i3kAsn0QK3oad9I3CjJOaCPtDcLbAIu0HHXCLxzcRhiUSeb6VixfT+pw0?=
 =?us-ascii?Q?VU5lwQ1JN9lux2ZTCPzZgR3xuP8b8p8MWnkgVyMBbeg9F3426AwmCRZy67JN?=
 =?us-ascii?Q?6eRaw4MaqctyJEr61C/fnIIoakf8PCUfvXD6x94Iq3eaPPjOhK5G/IeSWNvG?=
 =?us-ascii?Q?a9uKR58iIWFGwNaSe1kfkg20BuxSP036PS7bmLThcqbfFbw9ThyP2mh8wS8W?=
 =?us-ascii?Q?Q7AbL/mHt0raJMvwBA0EfF0WPKmk9VK1rtp2W+86Pk530bx1cuvQh7NG/EmG?=
 =?us-ascii?Q?2DLoLF4UIdnisavTlYlM4A1m4uI6cfcTHcZxAFAr1MvpXBUYT6ORqJYerYrM?=
 =?us-ascii?Q?P6jDS4/XYF5BjiUL7uo0MjKqPwNx/dWpwck3kq8sYZieyr/URnYo8nDUN+K1?=
 =?us-ascii?Q?gyOUR3RXx73yNF5bQMfLRjpGiByNUhAMmBwSOLc4SLk/YyEVN1p9vY9VyC7A?=
 =?us-ascii?Q?8RW5AGBJZ612PURccBeSmw5GddoQG2J8BDV73aINmBhLtFgaPtjCVQ9GasvV?=
 =?us-ascii?Q?t1Ufb4+SaI7S1+Dvi11XjB++vAgFf4b32P6JLG5Avj/3IDTBcitvZAqezdat?=
 =?us-ascii?Q?SEVMGrmxV6yjksbWTaUNjmhaNdWgDo3Nzt2zZsip5DIMEMZRehTCmUpu/Uor?=
 =?us-ascii?Q?Kx/McgaHxLj71RtiZoJAZmcyeNgQYfI4e63UtT9yXYg1vIG7eIyd15TNxogb?=
 =?us-ascii?Q?kakqRiAv1sSvtUtIkfsB90LyxFGsIxW8nOkS9XPHVU/drue7tWTfI9++6KPh?=
 =?us-ascii?Q?fog+wz/vDPqeq9GurIUSH82ZtXOeNPD2xwPxdq+51jnhAv8wJOQDD4WO8jau?=
 =?us-ascii?Q?Bj75Mv+yBskceAQ3HVaUh3rHS4zcTgEaUYEdRJqW/1QKYrR+A5bsNT2pmsr5?=
 =?us-ascii?Q?t0FCYFTfwAicfLu6OJf0a+kM1OOKkHRQFhcSiOhT2JV/h0dNstcuXUO6KwiM?=
 =?us-ascii?Q?GWlMSqV/zyvUMIZE6fG/W7g4cODywnT4TTXL+cgCVdFJOHSJC+HdT1OiRAy+?=
 =?us-ascii?Q?ApVFxS4GGjT5SUpunwE5tpe2FVCeb7HHAOFoBmg122FAJRaypI02f8pOWkvy?=
 =?us-ascii?Q?4ieiV02IQSbqWVx36ct2wgZA8P4e3mIESpic8ySCc08Q8MgdCGGjahyTqGgz?=
 =?us-ascii?Q?v2udavf+r7+GNRTzRMFHx8JWgDI7KxuPXWwUkoYKwkaNYFMSkJ8D+GZWiG1u?=
 =?us-ascii?Q?NJ2Mvd0z2uM8wu6039caTjs1E/P/cQSj6bRBdVEi+1MflYivrM8BPAZNM01U?=
 =?us-ascii?Q?Txw9oi0gPWmK9kaMPsCzpwFgKxnPzRUOz8Md+uyoNxIWIC6gHrgHzhqcagO5?=
 =?us-ascii?Q?GgSNPKUgIir5Yx8t8IHpfETDKKyof+Oqnvw/LZEPcbHVdm1fxDJqZFGYSUib?=
 =?us-ascii?Q?eekpEGNFFENPzNzkFbcN3eAuYuenAcBek1py9BjLri9FGyDUkrEuG6jzWCR8?=
 =?us-ascii?Q?l6tDskvAn0vI1Zjl58np1pNv6+gkk/Nz1OpYoVEsb+RxvlW68M1v6Zo+sKu2?=
 =?us-ascii?Q?PgYnPcwRaicl7VjGd8DET2H9vzOC75BvEV5s8WX3BvVHE1ahhdBDizWrkJoy?=
 =?us-ascii?Q?7yyDlGzGQJBiiALk/8mYXb77kHhcBiIUz1J98nqayCaO6pieWp9Zw93vklyB?=
 =?us-ascii?Q?zd/ld2W70rsVDqIWdVUV/gr6KHHFGDuDv+3NmJRj9mC5YDV/nIfrdbW2r7RU?=
 =?us-ascii?Q?KRE9qrowoLWb0rUr7mrJLgZcmK6XnUbvpQthfeH+5eqTyW1pEUoZHDRZYxVX?=
 =?us-ascii?Q?HkR6QFCIZiUPVQQNHd/s9HlcEPClLNo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bc6989-576f-4f14-d943-08d9c13207ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 07:51:27.1511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lT9qx8gHoZfnMj+9P4JcQqNsQrR/C2aasHI6NQxIoB5UA/bAy9VKe0oDacIUgWO5d/7V0loSUo7D7EBQiDJf1PoemEpcJ92kGQ/VPvPSVqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7478
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/12/2021 16:51, David Sterba wrote:=0A=
> On Wed, Dec 15, 2021 at 10:31:13PM +0800, Jingyun He wrote:=0A=
>> Hello,=0A=
>> I have a 14TB WDC HM-SMR disk formatted with BTRFS,=0A=
>> It looks like I'm unable to fill the disk full.=0A=
>> E.g. btrfs fi usage /disk1/=0A=
>> Free (estimated): 128.95GiB (min: 128.95GiB)=0A=
>>=0A=
>> It still has 100+GB available=0A=
>> But I'm unable to put more files.=0A=
> =0A=
> We'd need more information to diagnose that, eg. output of 'btrfs fi df'=
=0A=
> to see if eg. the metadata space is not exhausted or if the remaining=0A=
> 128G account for the unusable space in the zones (this is also in the=0A=
> 'fi df' output).=0A=
=0A=
Can you also share the output of 'blkzone report /dev/sdX'? =0A=
=0A=
=0A=
Thanks a lot,=0A=
	Johannes=0A=

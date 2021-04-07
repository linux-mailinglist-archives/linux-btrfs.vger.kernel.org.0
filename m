Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2624E356B39
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhDGLbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 07:31:14 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31551 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhDGLbN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 07:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617795064; x=1649331064;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hfPKRJdeCO38K9GC/vuflGIjrL6MpAxOlbhFDtQQWww=;
  b=j0FmrRW126TJGJiIGnnllXHGw4TZeU7O9mMdHy97ekEZk/bCKkbx1FmN
   5AqtzxwNZJDFVVnjMgoHZYGkPT4uaYwKha0fmTGf6/lPC7RXVHEqqHZFV
   VQA6gPek1nWR3jwaeDkErBaJ+CXrNcPL6SnXucxCwtufRQRDgghITtFSs
   /Su2bmwRI+HOUHD9Bc+CBbiAQr90A1Ilybw/5kgjcQfrOklrv/qJGgtzh
   37kDYEamadEVPiv8XNJ6V+vb1kLyUmSJ/6UWDv9pwKEBK/NeUUnE+AvGu
   8hSbNfgVCOF/Z9H9i2H5pyySvK0hw3Jw6W9cCv4boy0ulMNuI6lhn6zNC
   A==;
IronPort-SDR: zxpDnNAh9C23hyb+P3v/6BLR+zClWLXEfXNT/8hQX/e8f0ZFgX/ZufRhnmD6TPIFh4r1HCMIj+
 moMq+UGCKBLk3u/OXNRyedCmixW8t+g+LKsoX6h9IfWUFl6Ig+37IWEvcaEFzw9Zrw7M/OSr/e
 gEOtSjEYYVDjMnefqpl76pgZsHcYrLgDYa1i/I1lw5bIoRlGzLt9gj3XJrkpeTD4v9xPb0BCSn
 w3BtGlRhty7AT0uuxbPv4LVIKugLiAHN5qRzC90l9s8kSXqOkBx6o3dkTkYiHGSyLpt4REFVrQ
 vLw=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="164997423"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 19:30:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJHNPYaJ7nuCf8H5I2j0TLCAhMOeX/ef5Ec7D7F611LEeBlslREqDzNDKIJcVWxmkdq4fE6KxgmieNXHLbAENJ6SV7TR10xIHRkO7lJj+zhxlXa5cpi+IogIeCE1uRWUogvKyKe8UODaEtCUysPn5lg864sNmK3vaa2dxAUJoAadvGhv/Vqm6KiCrfu0VuULe0DFEVOQnIddaMZviFd3EN6NixieDYZrQ8/bLafAkBoDE83Mp27KFyVQYSaYDtr+bE4sgfTth06tUdYzsG2M8ao6Kc1+W+sjxO40mkLwAVcFYF+kBuenlIOWgs5KOvwd77KzKbbmUlbPiHeCs9n3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Pxvg51vKEneOYjsXv+6W8MM9yo/swyKODbHZA53pdw=;
 b=aDfWptc6hxqdopl3Rmpl6V1L/nQrY3GpuFW7ymyE9B/DEZRtDrb8mPiU+bgqWvwcmGO1DuxWdGKDd2DLA1GLI1d7OF+gxvxvXX33XP1xF+Lr70UHvKN2n8TbGG9SmqG5Uf0QtR3QHWRuM9zICbFv6VsuQCvAzCwAWA3yQjwifMPuXR7DgTV/Q9FyB1JWYBmF0nvIqJn+kmnrD9YdSelYYnS4/uJ2SjQ/NK1B3kTt95DClP1FSSNyX6epaFelq3eGrPVgVWH7HxprFOM6TvRczZpO3ax/2HFV+2QgM5A5aEH94MwGoSnULA3M/1OVH//rc4P15kJYOagh1GzChcuGKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Pxvg51vKEneOYjsXv+6W8MM9yo/swyKODbHZA53pdw=;
 b=Gpr+e8HxZSH5taelX4sUb8NCezvpVnwIFfGVp0ZW291B+TDtrz/hN6bGGn4N+bf1M+jPznpX7KM+3kwsVjFRv67HNe+yP3WR5ebdUEP4bi5QIQgqOC/JC1R5ZkdmAGhrM0uA5Qe3ShHiyZjjpDvTocxlPn1T7Zu5UhscUXsGU/w=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SN6PR04MB4240.namprd04.prod.outlook.com (2603:10b6:805:3c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 11:30:24 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630%6]) with mapi id 15.20.4020.018; Wed, 7 Apr 2021
 11:30:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
Thread-Topic: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
Thread-Index: AQHXHK2AfFCIp/xNUkKXsYwy3dEAHQ==
Date:   Wed, 7 Apr 2021 11:30:24 +0000
Message-ID: <SA0PR04MB74185E6E0B8C0C1D0A7987389B759@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
 <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
 <6611a836-72be-eada-1f2d-33454ce5fa04@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a846b9cb-661e-4b55-e616-08d8f9b88923
x-ms-traffictypediagnostic: SN6PR04MB4240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB42402D2A7F9BD8061A04EAD89B759@SN6PR04MB4240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2M/6ywOtGJ5zcJ5A7CSEIMoP991XF9EWgxcgTP3z/Ryk8jVMpaSVrQ8/gc+jUjWow7bJK1JAj3timWjgulKA27UwYxFcfKCvBBm9HOAWhE8UaVc361Q7CNIcZnDikyzunv8gsEuqYJrFYLFkZwpXSlRFHIjozPjJotA9arNlbdrFbi8ByE7SZhccDu/B264jFLVirSApdIYVtOYanUD3hcx9hP6wbsDMkjqzYd4GyiTVw4pS+VPhgTGYmVvIgAZ6BUUvknHicRPBAMyjkEi75fCjIkGe6Ywebfmja8iC9xTJ6DHdvRWPSm6j/5KD0UPGXxJplD6YFt7tYh6hVg8VuYe4EbWR05QRELyITz8gVbXcgVZ2rJ4J2yO2ubGOYHuZramjlGG3kcRWUVik+4bAREeCrTexc6DjgjgNgdY2RcdXALH4NOReHFu5kGaTiDBNoWynDP5F49HZsQhi3TdADbAt5/A4a1hAwEeC51u1v7Z0FXsebWSaqskhEk5TOocAo0mlMjnKomZJ/JiVsz3ikFJVpY0iY12UB/+DP/jK4u9wWuviEsvvSJV5ovAsN/EuaECrE/p00owaPTPiOGID1nSGuRZtpdhU30AKO6g2VprMi/ojwfjDcRn+URdQEMGWLqBpwfuYd5ClA9YPLh2ADYOQEsUpHUNtuSwdBut6d4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(186003)(7696005)(4744005)(38100700001)(110136005)(53546011)(6506007)(54906003)(478600001)(26005)(2906002)(9686003)(316002)(55016002)(66946007)(8936002)(91956017)(76116006)(8676002)(33656002)(86362001)(4326008)(52536014)(66446008)(64756008)(83380400001)(66476007)(66556008)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3J8u0jaeQ2dY+GS+o2CD36P0R6UVUp8UijE5nTu1lWrfUpxjNTUP7ksOfR2o?=
 =?us-ascii?Q?0Cd0QWyWH4qHZECsExv39QwuwF6ZKRKK5H/bqGwolImLjRpOcES/Y9so2XnW?=
 =?us-ascii?Q?iYaMFUvdBk2AbX5iyTrH/mYnXElHB5D+QOmNDIaJAm62nRYOBuT4VOC18thZ?=
 =?us-ascii?Q?olrxizDJJB3rASicGxM9gD+zT/phT5CrMYwPW/hTyHSPUvj4haXxC+6ujnGD?=
 =?us-ascii?Q?AHMCqLb93P3BgiAAENEL97cYaFI+NsE4F5CwqS2xpCaCECXTS9fxcEAhmSe5?=
 =?us-ascii?Q?P1H8CZDEUWyK0x3iGc9TYC9B5kch410MaeRjw616ebH3ivU8yEeghUVn/twi?=
 =?us-ascii?Q?WfHQiVYouPnkgnNVa638P0+Leq4M8gC+UeLmnXHYICIrLVWnyuyt1jFFT+yw?=
 =?us-ascii?Q?kwSJR6zYqxZnQXqd2t+ARN2CNd5txYWaw39UYKmVgK5wAjj/E43HnkhXFlwu?=
 =?us-ascii?Q?rH3zJ+flt+u73gCLm/XRsQ92/WaQNZ6b7AOU7xxc8l6/QP1CVo4+QGFnfbY1?=
 =?us-ascii?Q?tVLORMlXGniLjjWFW2JD6cxYqhD2Y1m3390LnsrI+W0iJL1mfCbyXm3xlS9a?=
 =?us-ascii?Q?2Ai4oB2Cjj68hkrRg5tXmSDRoitC59mgyZ30UkhukXZIqrxEiXmxKmTcLyxh?=
 =?us-ascii?Q?b2pQc4I5MqfWF5KI44LMSfLTYlSooqF1YOljdjZD5BiU463Ws/cOiPYenkf6?=
 =?us-ascii?Q?AVxtR1Opl/g/iM5mCFi/Dy9NhKH5RD6klm9ATznItKac+6f7gyWCUylOiEhl?=
 =?us-ascii?Q?c0co5r/lrTBz0JO4Yg7faDWncreed6JCEpK3HjjGZ9CPPMHWNQUfCwiPeRke?=
 =?us-ascii?Q?oWMkvYDck5D6bfsNwtmHb1TKyI1AWwX/2Kvyh9V7qUNaaddc9bHHhwcEgf1z?=
 =?us-ascii?Q?83QOxH5E8RxtxCbLUqTjtEp00mY06kC1htcj8VNbo/7NUJAk5GS2eVpiBEpk?=
 =?us-ascii?Q?6DpSTcFsbIHH12cth5EM/MxkqiCJ76WOC1cPZfZMRSqaS62rjiHVPf/sTjfg?=
 =?us-ascii?Q?XqKgYTLgEsVNQ6El8PonvokI17aYJ0+PAzY9/g+/laMHl3JalT3DX++0NLOF?=
 =?us-ascii?Q?6fmLurZZPYktM2XLftFKJfnaROxnNeqnZ0lpOxFTwdcNTvPQFEtKcWOsnv5O?=
 =?us-ascii?Q?TwHtwfiMlTewUrZyzPOqalehCqjX6pg0gEqzcS8okjtab63eojk+Nvg8/u4h?=
 =?us-ascii?Q?vNdI7EkpIL1kVExP3xo2j3SpObx1CCJUwkDocE6Sp2Q2qLFUQZtUwTy8fTAm?=
 =?us-ascii?Q?uQNZk2bR6dZ/ldl9p9+wXIG2DOO1olNIxhCdVQNDAtMlXtjXbIu9HE8vWOhD?=
 =?us-ascii?Q?DrAoJJJeK0rMdW4106vrHJTB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a846b9cb-661e-4b55-e616-08d8f9b88923
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 11:30:24.2288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Phq/JLiVbgs7ZQTWXQl501Qno82w1XiNwFgvSjmJE/MC41cOW6HqmeZmY3LAKjZQbQgntzSF1zyWjT0VnwDV/zmPO6AAqv0RfYqZmlfdS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4240
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/03/2021 18:59, Josef Bacik wrote:=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index f9250f14fc1e..d4fccf113df1 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -1815,6 +1815,13 @@ static int cleaner_kthread(void *arg)=0A=
>>   		 * unused block groups.=0A=
>>   		 */=0A=
>>   		btrfs_delete_unused_bgs(fs_info);=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * Reclaim block groups in the reclaim_bgs list after we deleted=0A=
>> +		 * all unused block_groups. This possibly gives us some more free=0A=
>> +		 * space.=0A=
>> +		 */=0A=
>> +		btrfs_reclaim_bgs(fs_info);=0A=
> Reclaim can be a super long process, and we use the cleaner to keep up wi=
th =0A=
> other things, like delayed iputs and deleted snapshots.  I'd rather offlo=
ad this =0A=
> to it's own worker thread so that the cleaner doesn't get bogged down in =
the =0A=
> relocation work.=0A=
> =0A=
=0A=
As I finally have time to get back to this, kthread or workqueue? What does=
 make=0A=
more sense here?=0A=

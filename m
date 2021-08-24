Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89173F6298
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 18:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhHXQUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 12:20:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38464 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhHXQUH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 12:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629821961; x=1661357961;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YCFewVim+JzT7wVcrHyKijKazasvHrjFuxug5pt/9Ps=;
  b=BRW/XDroTn0efI1hKuZW88Of0c1li3e5LsinXDp/xp3RrW8G5ZG15sOF
   bzwLR8nYzETPWQlto/TWX+FkQA8ygWUJR6NTh+Hx8D/vVLqafy5f/XKPD
   oRqCN3B47IOucezwRqO+l7f+HWwPOW70sfwdz4uDY8gCdkKYKWxlm+JCo
   yKj76+irDg2/83BXjpLhAQIqywyC3DCZVd5nSnHYQq+SiDgBvUSbuagSU
   C/DmMeMgqHnqIj2+JWlg9N3/WQo8jktx8F7H3WyETQbZL1pMVRRR01alz
   /Gwrzg+TFpkulFbmhGDK7aNyqqABWokSkyrM/cY89TFbJA+W/Tp1a7HH4
   g==;
X-IronPort-AV: E=Sophos;i="5.84,347,1620662400"; 
   d="scan'208";a="183026467"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2021 00:04:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv1TPY/TA5BOJtbM247ri7/EEgXPY/xTHyhNMEA8lP8122BQuDzY6m8bgSnoNCzacA6TBXVZ2W2B/F9tPBc7iVj2FGjme5hCKgOhKAsNM6Kg1WJFNYwvy7RBEUK55pguEf1UH8TekcZ5n6YM0BVNQwqcGgNqYHjyhvxUanvg/RcSTuaA2yc+K1tqDXhOegVVUwHJBnhnW2RImw3SlmMv2XdCpaJB+g7FP43vbGh8w4pb0LxAiutOFPp/+cP9ZC7RRY03aTIubbdY8mINo1bfb9tBgVSROAFwxgZpwrMSmZ/ClK/t+Mk3se0vwQbWXZzWfMWx618B0BdFkbi3x3lLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nm4rXtPy2xMldu+YSnZKpmUWruF2SbxZUFDgtB1VU0=;
 b=c8kEIHE43NTEf8wjz94MiTRSRApABreiGd37gBdD549uaq9otqjPAZKQJ8hI0M9taFRvOiJzIw4QJjRFUVfjrfbS5biQtm35q7shumqrY+nbx34fpmqPAuiiWY6jEcFxAGz/v/AKQQ/SIYfo/H4ImA6F2BniwBXWKm9hJC+pA8d8eOPsfZwyjfmETTNSyvzaCNP0INZdct0ep/v4jNqDBYRZ56UqIF2zcYPjjFhiIRr/v10raTfDBrBZXXYwxmMzmdRHHAHmCcemRHchWUBreQQJ8G46PCDcUPqWn5ENPyPo6HaFDVMJrWPIqFGwVI9BNK/i6tSEhkaSmCiKhRXI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nm4rXtPy2xMldu+YSnZKpmUWruF2SbxZUFDgtB1VU0=;
 b=P3gFKkn7x2RveP5YLYwgShBV3oYS+wesV4f7y41BoR7JDJPNw2IPZp1G+28Ve5TKOcgyJUAtzSV6SJGzZWxaJBcY2nZmjfDt9EwT15xuyKI4JLn3AYAQBLElc+cpOmGA7/NZ27Erf6ES6zEbNPDwea4/gxmqFTdzzAnkOuy4LP4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7478.namprd04.prod.outlook.com (2603:10b6:510:4e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Tue, 24 Aug
 2021 16:04:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%6]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 16:04:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 03/17] btrfs: zoned: calculate free space from zone
 capacity
Thread-Topic: [PATCH v2 03/17] btrfs: zoned: calculate free space from zone
 capacity
Thread-Index: AQHXlPWOOZMNOgSR6Eu5+ym0uuf7zA==
Date:   Tue, 24 Aug 2021 16:04:22 +0000
Message-ID: <PH0PR04MB741621545AB2266A1772CF789BC59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
 <03bf2db22301fcc6706d489dab1dc3ed6ac54a8e.1629349224.git.naohiro.aota@wdc.com>
 <PH0PR04MB7416F7E5FAB3EECCBC58777D9BC59@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210824152706.GA3379@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d833c3a-1a55-475b-13f0-08d96718d68a
x-ms-traffictypediagnostic: PH0PR04MB7478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7478446A3570EF43E795C7B59BC59@PH0PR04MB7478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9kFZvfwRZivP5NTnmPAnubwXj9AUyQ/Bt5HcttxCWtJ/JYtIQVBnRM7hVqGyAiO3TQr/5ApOZLLSXu2WsV+eYaYDcOpfybP1BNFrpVzgxTLtu6dH8Ruohqvq8awcy5bhb6StYQ6/rkvtpgHu5Lwz/CJ+JwTVq7Pgoyv8pKMuFoEoX+y3cH6kResZANlwepmd9WeVyNcs8hOlDGzVxoFNkVkefXTwP1nzKiFQlh4vQWhkzREs1lHnuPrCpapXrc1Qdv37p7rfcDS6KNBagcB5+71Iq56e+0OBTrrmp8qMjWq3pRlngSaOBwm1TZfbAvY+00agxKD9ezNt8gSze2ElycVqqsHI97QIx3e9y8me5N9micMFmQsjgPGI4xkv7dbS7SjuP6cmUgdFWivPX+Gg/qpkNK9p8MlWk73pr7HFrfgZ9bZiOT3aqs5l5lBYdsvWidoo+x2iFuOfTSGxs3+MDalvqTigqH+nj9rQYnV0RW1PVgeDb7Czlos5nNFd3Z8YIN2NTXb5CsYMYTJ6HbmkO0w+SVJfQoxExhbJ7Qi4DdwkxSygoHDWyObV+5bUDeQpZXY0k/GeX743NiLTHyfVL/wZeTcrW3AcG5JqMvIAF5IXmIt2d7GzJN0yXkT31M+jEXJk5M2d58kqgDU3wZTsfMnx5cjhFDf9E220GDr5hN72oWNdNd1/dIThJBzm3O4HsJ9eU21siJ8oBniKm5HgwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(64756008)(5660300002)(66556008)(66446008)(9686003)(53546011)(6506007)(76116006)(66476007)(66946007)(4744005)(6916009)(52536014)(316002)(122000001)(91956017)(86362001)(54906003)(8676002)(7696005)(71200400001)(2906002)(38070700005)(38100700002)(55016002)(33656002)(478600001)(83380400001)(8936002)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U8mZOiAeyb9e64CEKsZBVgLkC2GEkjuWGO81+dahl0QopEOqDxasYj5Lo2h5?=
 =?us-ascii?Q?uv4oFDRWYGXXHglffoONkpSRZ4k9XW5la0twqUCE43oXR9viln8N8/bobx1Q?=
 =?us-ascii?Q?BDqa5do/H8BJT7EP/N0ISFLiUHXC0OAY+VEiskzEF1SWBkJQ8cGuK8O1jC03?=
 =?us-ascii?Q?ais/0NZNPrArVdoBWP7zTyi79Th/3nBRKcv40UaV6pqZLzC1OiIotCmjtsQ8?=
 =?us-ascii?Q?zjRoJCImET0RnVDY5l64fkrP8OIs+7Rr5zYP1f3bzrrU0dcfqXuozlfpRvbD?=
 =?us-ascii?Q?YddayxColti0g1RBfgCzUk3LSTrasclaaB3ZZhbN/aSU5+TjsMUS6GckD7E4?=
 =?us-ascii?Q?JHO+htBFvFZ6wNbV+lbgjukbg5/2rnLErpBHjcGLJXoQ3sI2JxhjsKTAq0gq?=
 =?us-ascii?Q?rYG9LKfZXogYUskDrrJpLb+ea851c0or3L8PnZWFO30dnHery6Qc9wVOVrzK?=
 =?us-ascii?Q?wy1nGM9qa42vHsEttGa0/UbphhaKKpkg6ktnYvyNLbcuXm5t3AHkQdiKDFdz?=
 =?us-ascii?Q?VoaVC963sX80vMDes5aUklfGMH/xba/llq4ltyFYZr6rkrIVsYmcwQXhaguX?=
 =?us-ascii?Q?jpB8Tq3pM3Nx5l25GfeUnFLhzDHRTKwUujJbR5RlxN/dfHeObiRIDDdbfE/W?=
 =?us-ascii?Q?h+WdjI6ZOyiWm8fKItIB03YEzdRwGZVZCTQxkOa8W7rZNpnEMBTbrnWzyfiQ?=
 =?us-ascii?Q?XC5H5dlqrUn1QWRf8QbZOOFsct1b8Nzv89fiRr2kv4WBCvz3OsyR960lIo3X?=
 =?us-ascii?Q?5ET5x6NDC8OtpnS5thBt20ytdg+axfVstC5R7LgkuhT1p0Z1y40eB6OxW+Nt?=
 =?us-ascii?Q?DlrzsZjp6vIq7Xwt0IBSQmR5yEGiQXROmlN3l60RwmtcIDR/LGJiF04IpGcA?=
 =?us-ascii?Q?7rLIqXxKSEDHsekhuYyHXnQI18KCd2sNw/BczMxHGPCmUdFdd6/xcNHYH9v3?=
 =?us-ascii?Q?/SM1zYme6CKdf1utmUjkJlz4JAAw9EzRHWvuB6o2Yq9VA6CGy0+GWrAG18Q2?=
 =?us-ascii?Q?cvW1ck0EiONeQQSTSaNKCthoRKvZMxzq/Rt6Da0ndEE/z1aQr7RZMqqDOlX6?=
 =?us-ascii?Q?77NsZGqRv0r39rY8DBB2XyAVhpg/4Qofs01RJTzNYFxcNIUTmR73+hil3TP+?=
 =?us-ascii?Q?pVZQSVAlSAzUoHn6CC6RZkOfUSjkgyjsi+by2lDNwNsfSjuVSYRHfrISeCZN?=
 =?us-ascii?Q?DMvtMrIzCMlo6cnjkUUyG6gZEYfgt6kky3j8gJa7j8bX3SvJdvgU2Zx09353?=
 =?us-ascii?Q?VWd3eOQOdlcPYm82DxpoEGtKn6JKaQ7247281l5neyE8zKMM7oRSLyv5G7ZS?=
 =?us-ascii?Q?fDCZWlv290ExurUxzTYUP/8ioYwV1ShFzqq/OO6uYp+2lcwHXEyz9NNny/fD?=
 =?us-ascii?Q?mOc6vQs8sZS7ZbVRB1TioJW8fHbyZk871Enwc5ejLeOXJLu9+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d833c3a-1a55-475b-13f0-08d96718d68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 16:04:22.3764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSqL2nzpG0YDReTQvgeUXC8EZBb40rknDsWeo/PKZ1pKC2mexzoJ4yl8Zqe5HlhE1lb7vUZ56wlSAUWiWH2eK89oh05yJctt6MNuD+BSjwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7478
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/08/2021 17:30, David Sterba wrote:=0A=
> On Tue, Aug 24, 2021 at 07:59:38AM +0000, Johannes Thumshirn wrote:=0A=
>> On 19/08/2021 14:27, Naohiro Aota wrote:=0A=
>>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c=
=0A=
>>> index da0eee7c9e5f..bb2536c745cd 100644=0A=
>>> --- a/fs/btrfs/free-space-cache.c=0A=
>>> +++ b/fs/btrfs/free-space-cache.c=0A=
>>> @@ -2539,10 +2539,15 @@ static int __btrfs_add_free_space_zoned(struct =
btrfs_block_group *block_group,=0A=
>>>  	u64 offset =3D bytenr - block_group->start;=0A=
>>>  	u64 to_free, to_unusable;=0A=
>>>  	const int bg_reclaim_threshold =3D READ_ONCE(fs_info->bg_reclaim_thre=
shold);=0A=
>>> +	bool initial =3D (size =3D=3D block_group->length);=0A=
>>> +=0A=
>>=0A=
>> Nit: Unneeded parenthesis=0A=
> =0A=
> No it's actually preferred this way for clarity.=0A=
> =0A=
=0A=
Oh good to know.=0A=
/me goes fixing another patch=0A=

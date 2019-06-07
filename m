Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDEA382B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 04:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFGC3s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 22:29:48 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9119 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfFGC3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jun 2019 22:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559874587; x=1591410587;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mgMYqa8y3cb+R+HAGNGYPCC16cjCu7G8DFmbtBJXmMk=;
  b=ITch/dz8J3ETv9KnAyb5qru9nrpuXt23H2pF2G8gpuUllwsd2G02lRst
   0UURsH7NT/nW8qbxauSysLNXxSvq5ER4TsHOzH4p6OWqn667qAEk4mIoU
   7PHGZSWYDSQjLKpQlw+1ya2BTkyYh4hoNtBcQTW32l3WUkl4BH3PU38J/
   z+x+bHMdqJdaoOt2SHCCLyZX6Q0T4iSHndRzC74crOCBQKpkhJAF9yvMG
   nf4wcCxvxxuSK507fCPqMhAZ/Oc7OPxqcF5NhW8muEpYVYHO5u2WV7ZEU
   BTB0cn86vcSwhUDHKxnE+Eo84PY8VRMiTYgB5ZqgtDK7+gnkfSLqZH/l5
   w==;
X-IronPort-AV: E=Sophos;i="5.63,561,1557158400"; 
   d="scan'208";a="216304889"
Received: from mail-dm3nam05lp2050.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.50])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 10:29:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di4NnnabGgD0dVtwB7gfgFaEGX91OaVh8gcm6KrvkOA=;
 b=k/ygqLUnJTua+2xHUuSPvtD+QOmufyhjh5ItGsBWg7PBjU95mGHyXW9z3EYN73KfyANyW4zL8rwAi/IJmmLOQMZD+oXwrDir20GtSM0R0/62Vns8mr/IiWsca2hR4yihjbhQ8VqAMUmFMUZ86xvpY0FIA7oqyP/46UNKvOTndc4=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB5455.namprd04.prod.outlook.com (20.177.254.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 02:29:44 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::903a:ddca:14af:4b90]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::903a:ddca:14af:4b90%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 02:29:44 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: start readahead also in seed devices
Thread-Topic: [PATCH] btrfs: start readahead also in seed devices
Thread-Index: AQHVHD0hPsfu2MgGfUmVDlYk8mSTxg==
Date:   Fri, 7 Jun 2019 02:29:44 +0000
Message-ID: <SN6PR04MB5231516319EF5C82576838418C100@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190606075444.15481-1-naohiro.aota@wdc.com>
 <CAL3q7H6ZD=SCcj_dOB6b+8xPTXpq5dTv58Mb4C4qPn1Cx9XOtA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e027b8d-042a-4518-c583-08d6eaf000b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5455;
x-ms-traffictypediagnostic: SN6PR04MB5455:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB545530F12DD2FEC77C2E59F38C100@SN6PR04MB5455.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(346002)(136003)(189003)(199004)(14454004)(6436002)(2351001)(76116006)(66556008)(73956011)(229853002)(66446008)(33656002)(8676002)(9686003)(81156014)(305945005)(3846002)(66066001)(6116002)(1361003)(6916009)(6506007)(54906003)(7736002)(5640700003)(5660300002)(68736007)(76176011)(74316002)(7696005)(8936002)(99286004)(53546011)(478600001)(1730700003)(55016002)(102836004)(25786009)(81166006)(71190400001)(26005)(64756008)(66946007)(186003)(66476007)(72206003)(86362001)(4326008)(2906002)(91956017)(6246003)(14444005)(256004)(53936002)(486006)(446003)(1411001)(476003)(71200400001)(52536014)(316002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5455;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cKWTztcEyT25dJEL+NV3u69PQX8SMyzCCit+wvwOYn9n+RBXJqNloYX7+YV98ExnKPZaDvc78H7TMqzwWcl75wvqTlPso2/NpXpZ4TBqNBVxww7B/0H5BHRRQcaai/oEGxs3ak9P5kQjdSZv4MbEwxzhDhpePvjHFXTE4mzOifRluJMML+XMEgSbUJuH1hBvySI0DgPwyUgDnl5h3fnF7FB9CMStDsXskryjhReAz3jVWPLuzwV7H8fq7vU2+UxW55Ykl7m7PYt9zK1erNeTnAZKwxopeXP/3qe3sK0lfu159dYgI8QH/FG3k8wkXz0XfvpLqpTITFIoDtrUB9/sY3msfeUJbt4ql5Yx3IXiWwOv8wRtIWWmPkqHa1pas3Xsh0NENB5Q8NmLySD71Jk8BFG0tQrlqsvkFIAjwXDpouk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e027b8d-042a-4518-c583-08d6eaf000b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 02:29:44.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5455
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/06/06 20:14, Filipe Manana wrote:=0A=
> On Thu, Jun 6, 2019 at 8:56 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:=
=0A=
>>=0A=
>> Currently, btrfs does not consult seed devices to start readahead. As a=
=0A=
>> result, if readahead zone is added to the seed devices, btrfs_reada_wait=
()=0A=
>> indefinitely wait for the reada_ctl to finish.=0A=
>>=0A=
>> You can reproduce the hung by modifying btrfs/163 to have larger initial=
=0A=
>> file size (e.g. xfs_io pwrite 4M instead of current 256K).=0A=
> =0A=
> Are you planning on submitting a patch for the test case as well, so=0A=
> that it writes at least 4Mb?=0A=
> Would be useful to have.=0A=
=0A=
I will send that patch soon.=0A=
=0A=
Thanks,=0A=
=0A=
> =0A=
>>=0A=
>> Fixes: 7414a03fbf9e ("btrfs: initial readahead code and prototypes")=0A=
>> Cc: stable@vger.kernel.org # 3.2+: ce7791ffee1e: Btrfs: fix race between=
 readahead and device replace/removal=0A=
>> Cc: stable@vger.kernel.org # 3.2+=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> =0A=
> Reviewed-by: Filipe Manana <fdmanana@suse.com>=0A=
> =0A=
> Looks good, thanks.=0A=
> =0A=
>> ---=0A=
>>   fs/btrfs/reada.c | 5 +++++=0A=
>>   1 file changed, 5 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c=0A=
>> index 10d9589001a9..bb5bd49573b4 100644=0A=
>> --- a/fs/btrfs/reada.c=0A=
>> +++ b/fs/btrfs/reada.c=0A=
>> @@ -747,6 +747,7 @@ static void __reada_start_machine(struct btrfs_fs_in=
fo *fs_info)=0A=
>>          u64 total =3D 0;=0A=
>>          int i;=0A=
>>=0A=
>> +again:=0A=
>>          do {=0A=
>>                  enqueued =3D 0;=0A=
>>                  mutex_lock(&fs_devices->device_list_mutex);=0A=
>> @@ -758,6 +759,10 @@ static void __reada_start_machine(struct btrfs_fs_i=
nfo *fs_info)=0A=
>>                  mutex_unlock(&fs_devices->device_list_mutex);=0A=
>>                  total +=3D enqueued;=0A=
>>          } while (enqueued && total < 10000);=0A=
>> +       if (fs_devices->seed) {=0A=
>> +               fs_devices =3D fs_devices->seed;=0A=
>> +               goto again;=0A=
>> +       }=0A=
>>=0A=
>>          if (enqueued =3D=3D 0)=0A=
>>                  return;=0A=
>> --=0A=
>> 2.21.0=0A=
>>=0A=
> =0A=
> =0A=
=0A=

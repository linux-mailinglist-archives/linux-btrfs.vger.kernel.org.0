Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF73619C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 08:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhDPGOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 02:14:44 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:38491 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229706AbhDPGOo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 02:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1618553659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UpWSnTypRx4dm64bw+qx9TwmoIwXgL40zOOcx5yS/QE=;
        b=aEmT6lyUsSBsU8hcVvfm6fhDFgUxnN3kuWVgwpPr3iFvapdq0lMCdAmmx7Hfz3GsYh6xhd
        7EOspNZOtL/3CkuYpWa/WYZrzLZuN3+fGYyXmLj8HNE0TGibV8bzo8VthwtXOHBNXSrUuZ
        ymYyVaUjNRS0y1Ijcsn+QlCtqdGmj6g=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-fJ8xSD6FNbiwnl-b6QRTyA-1; Fri, 16 Apr 2021 08:14:18 +0200
X-MC-Unique: fJ8xSD6FNbiwnl-b6QRTyA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW0hYMJpsZav0zvflugo6nb5/sjXBGFAxKDo3QsqlPxRWC3WTikABaJIzTyta/5NupLTZ+pPUIz4khpamJMTNKefCx5NYyfeoe0XU4omR9cTGkDE/DJpnaw+V6RfSxtPov4Y3RU9ktfhbzMjh4JqiLDL+po0TRxd7yrf30LoyzkpYJRuN48JAQ6uEPW4HkFxorVGq8eZaSd9fQ2iotLM2QF3drRZFf6Fb3S0BiXDT3u5KPvAxQq6ADCGHzZbtjDN4xz815e7S7fzZKVyd/SWIUqTOYBX2FrUlLbF+pVlG+FuCw2tybmbkOZF5nDzIarF60C9pHOnlzNzgv1zyTYAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR/f+SXWF5zlmwuTD2QBCey90YGC/3XzToTXZMPhPvw=;
 b=OFSHbqisKxO/ba08PMOvQM2Vtnl76npjGbDmlonVYawuhFck0tqRhdaKP0uOlFXBicS1IVUVc6Uo1O1tnqUUMU8gwDSGMPFOYF5Yk+POx2mDYrjcrqHeyd0rbKuEO5dJenXeFiWh4oPzXcJr2LvahsXIZzKMoL9wsyD5b0gih/M16VEBkbc+EGEhdODij2BQ6ICpnJwxSOzVzeGejHilXZusqn0XIGNnfmkao0Ft7DYWnOLr5lrPDmpHxKL7Su0aqISq1KIN2qg6Ct9EpEfWVCt1BCjD5HYTdVd2tcCCsXEIip5DvhvYTf20P7yGOWow8qDYpOF607WsZGL5zyEywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4902.eurprd04.prod.outlook.com (2603:10a6:20b:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 06:14:16 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%7]) with mapi id 15.20.4020.022; Fri, 16 Apr 2021
 06:14:15 +0000
To:     riteshh <riteshh@linux.ibm.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210402083323.u6o3laynn4qcxlq2@riteshh-domain>
 <f1acd25b-c0b6-31b4-f40b-32b44ba9ce4c@gmx.com>
 <20210402084652.b7a4mj2mntxu2xi5@riteshh-domain>
 <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
 <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
 <20210415034444.3fg5j337ee6rvdps@riteshh-domain>
 <20210415145207.y4n3km5a2pawdeb4@riteshh-domain>
 <8bdb27e4-af63-653c-98e5-e6ffa4eee667@gmx.com>
 <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
 <c06a013e-0f7d-21f5-0bd1-9c6c22024fd8@gmx.com>
 <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
Date:   Fri, 16 Apr 2021 14:14:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:a03:39f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Fri, 16 Apr 2021 06:14:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f81003f7-950b-40ce-f323-08d9009edca9
X-MS-TrafficTypeDiagnostic: AM6PR04MB4902:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4902BC74C7E63534764DE241D64C9@AM6PR04MB4902.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwxBKRIUeUSevGdZPWtZ97+qgVWxK7E9WNm+vUC6vFg8t2Kt42O7hFaLspgtNWhDnRc19NsS1J6pWO94PzBeZXeAmg9bmyFyJdj/N3XJtmgMCjEkqxLo82Y5Wy5rS/8QslsWUUSVGzhIdpzjw3+YDdSed7Wohr3IQVXVe+0Kuw99gLfXypri30VgS5HzInmJwTLvikSA/BAaFg0Y/yJNHzS8gNIY/jRURE64eKEleLbi3GRa5bPeWCUaNDxo85LI+J7JST1zuJQaX119XHosVXrkqQu1Y0dzCYqERvQryUAtXSXlxCggqI5ddMmVpMFWGleLM4TybNNXsA0qDmDCVOBYNIzo6RlAF1hJfh7YOzHS+4OIrrtf2TKhZYbcVkphE8+suFDhHHsVVLWnS7OWDlNgOqVqaH7ojBx+SyBiDZZcTX4fxTNm7Eo4RHFHAS2kQN0uiegsMhDxpyo+nTaaCKsL6Tyc3cNwlMZhdnsHzTLXaWD+8KGTNNGxQ2P16t2eYgb/LnDjAdtNR0dBigjDXyYQtB1xjkuxBgvfq3A4eTTApOx38RPNlBLzTMkG8yl94J30pxLq/p90g6QMYY82vSreMwZgBzsMReLXYQuRMR1cXPm9eN5neMwc9fRECsj+tVfVEGwq4jmLuNW/S/uSMojxyTwrpSrw7eUNB82TlZpTMUsThbnxtiA47LPq15mdh1raPWZoAmG1ono+8NwUcDx4bpSKFnBnA0KRLbKe371Upb87tTyShseOF84MYRAn2ROvdX6sLMi/VEFVRljyQTYxxT2JX5TnUCy6BioN35/cKDjNe96vh1ifofJihUxf/z7+/JHfHg6oCJepUv1rEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39860400002)(38350700002)(186003)(8936002)(6706004)(38100700002)(6486002)(31696002)(31686004)(36756003)(16526019)(966005)(110136005)(4326008)(83380400001)(66476007)(66946007)(478600001)(6666004)(30864003)(66556008)(2616005)(16576012)(26005)(8676002)(52116002)(86362001)(316002)(2906002)(5660300002)(54906003)(956004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wnLFznCXcEky2bka/u2w4WkHtfJzno2x6XDf8T/Mm4zFXC/kb4/SYMjE43t9?=
 =?us-ascii?Q?dTF4+f1pVQv/Vbj7wuadriuUE1ckPGza3TaZfRayYN/73uKqsa5XgPQYp9+7?=
 =?us-ascii?Q?TS5ivO4zhiyO9xqjkCinJOmSno7e3WVNit0tP5hm4DNXV4ndeJIJFSAW/wV7?=
 =?us-ascii?Q?x+uxzwKPbJPkJhZmLirkdjy6CLc5VKS2SruXTGmwZAU4E32CuzWQ9ypIC0OP?=
 =?us-ascii?Q?mk6tT8mD8YJB/YV3Xgfx/nnWL3huisD34Ipxm59i+iGBnO2R0DOdhKI9Grax?=
 =?us-ascii?Q?KWQT53dH/b0mukGh/iFcItMayFcDjuoNR3OvGjJUwUerEPfftfn6ArLFyv3S?=
 =?us-ascii?Q?qU/QMisk81tDIiCBXD0FBAFSujFNb+pQWj1TFiQa51kAYsjjDur6JXnLUCWk?=
 =?us-ascii?Q?LLREjPlAQkYSXj2ppAQZIYiDISx2WmenbmsnnZISF/z265BWJgLcQv0RpFf2?=
 =?us-ascii?Q?8ND+n/ro2i0J2jUTXG05wJGeEmow5oaUJD3n5CveZufB4nEf/9Ewg7wgLivC?=
 =?us-ascii?Q?oQElw4eSKBuvVjyFao28TCK1tKm64K6VlCq2u02cmuGMkCwBbz/5gW/C9z9/?=
 =?us-ascii?Q?RLeL1UOo6Q+P6lLaLiNXz9PTkFTDEdY/h9NSIlMkpu6vNfV+/qR9TEL8hRZd?=
 =?us-ascii?Q?M6SGNzEUXqvfwh8IEvh/QsBQya4Bsa3dqJdUwo6Wb3Nisi0L+ou0w80o4C/5?=
 =?us-ascii?Q?bKuPgh96wrEF7/XoHIYafQZXHnBkWVBDsNQPYkFs10LBmcQ0eY5ee/WMeuED?=
 =?us-ascii?Q?xvl+mQXhXZJGuuYa0rxz6Pgb4qsxxpaQ3HBkwa7sWGfeGHER0IDcf7iHbFbX?=
 =?us-ascii?Q?x75IJSFdZLdG1AKZEV9zE2RWArYpD+YuMJnncVKDBz22KwU50Ud3rHZb/lCQ?=
 =?us-ascii?Q?Zzg7Y6qYcDpFadj9PKOLIvIAE9O5kMsPQtVgbeiRNuRnIVbXN82QfySf2l/k?=
 =?us-ascii?Q?5VGS9lKbgK6u5cZVWJhSa+At4FOGlkkbv4qYugtkWtDPSIC1yqAZP5HQ5tun?=
 =?us-ascii?Q?2hm6jFulzx8fO5WGLBlcS1Y5DUn/1/Fs+ocVfQN/MphQu5NCGWWpyMVtI3b2?=
 =?us-ascii?Q?bX1wiz06LTN6XgmFnlRKoEdG4JwerHS4cHab8HdRIIVTaphg3LBWkGvncJO0?=
 =?us-ascii?Q?AsbeFkN+4UCUboImBKzRioR9SidVus4fQjXEJPh/Ih0dM5GpYkevFsT5iKjn?=
 =?us-ascii?Q?0sqJLV6om78ptuuRMXyGZ2UF5AvX9cCkC4HvxPWusKdEMWKk/g4ssJLTqE7m?=
 =?us-ascii?Q?YQ/T9kWtw54FkNji+oH8YdqFW51+f6KKQJOuwWwp/jtQNpBt6uAynV5n5j6x?=
 =?us-ascii?Q?zdrpik/lvSjITgqXe5+FvObW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81003f7-950b-40ce-f323-08d9009edca9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 06:14:15.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqt4wgKznJJTP9Z4DSTAwUm9pFJpPkS/+dXNEhv+wixefR+3h8qL5Y11+lroWi1G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4902
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/16 =E4=B8=8B=E5=8D=881:50, riteshh wrote:
> On 21/04/16 09:34AM, Qu Wenruo wrote:
>>
>>
>> On 2021/4/16 =E4=B8=8A=E5=8D=887:34, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/4/16 =E4=B8=8A=E5=8D=887:19, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/4/15 =E4=B8=8B=E5=8D=8810:52, riteshh wrote:
>>>>> On 21/04/15 09:14AM, riteshh wrote:
>>>>>> On 21/04/12 07:33PM, Qu Wenruo wrote:
>>>>>>> Good news, you can fetch the subpage branch for better test results=
.
>>>>>>>
>>>>>>> Now the branch should pass all generic tests, except defrag and kno=
wn
>>>>>>> failures.
>>>>>>> And no more random crash during the tests.
>>>>>>
>>>>>> Thanks, let me test it on PPC64 box.
>>>>>
>>>>> I do see some failures remaining with the patch series.
>>>>> However the one which is blocking my testing is the tests/generic/095
>>>>> I see kernel BUG hitting with below signature.
>>>>
>>>> That's pretty different from my tests.
>>>>
>>>> As I haven't seen such BUG_ON() for a while.
>>>>
>>>>
>>>>>
>>>>> Please let me know if this a known failure?
>>>>>
>>>>> <xfstests config>
>>>>> #:~/work-tools/xfstests$ sudo ./check -g auto
>>>>> SECTION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- btrfs_4k
>>>>> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- btrfs
>>>>> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/ppc64le qemu 5.12.0-r=
c7-02316-g3490dae50c0 #73
>>>>> SMP Thu Apr 15 07:29:23 CDT 2021
>>>>> MKFS_OPTIONS=C2=A0 -- -f -s 4096 -n 4096 /dev/loop3
>>>>
>>>> I see you're using -n 4096, not the default -n 16K, let me see if I ca=
n
>>>> reproduce that.
>>>>
>>>> But from the backtrace, it doesn't look like the case,
>>>> as it happens for data path, which means it's only related to sectorsi=
ze.
>>>>
>>>>> MOUNT_OPTIONS -- /dev/loop3 /mnt1/scratch
>>>>>
>>>>>
>>>>> <kernel logs>
>>>>> [ 6057.560580] BTRFS warning (device loop3): read-write for sector
>>>>> size 4096 with page size 65536 is experimental
>>>>> [ 6057.861383] run fstests generic/095 at 2021-04-15 14:12:10
>>>>> [ 6058.345127] BTRFS info (device loop2): disk space caching is enabl=
ed
>>>>> [ 6058.348910] BTRFS info (device loop2): has skinny extents
>>>>> [ 6058.351930] BTRFS warning (device loop2): read-write for sector
>>>>> size 4096 with page size 65536 is experimental
>>>>> [ 6059.896382] BTRFS: device fsid 43ec9cdf-c124-4460-ad93-933bfd5ddbb=
d
>>>>> devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (739641)
>>>>> [ 6060.225107] BTRFS info (device loop3): disk space caching is enabl=
ed
>>>>> [ 6060.226213] BTRFS info (device loop3): has skinny extents
>>>>> [ 6060.227084] BTRFS warning (device loop3): read-write for sector
>>>>> size 4096 with page size 65536 is experimental
>>>>> [ 6060.234537] BTRFS info (device loop3): checking UUID tree
>>>>> [ 6061.375902] assertion failed: PagePrivate(page) && page->private,
>>>>> in fs/btrfs/subpage.c:171
>>>>> [ 6061.378296] ------------[ cut here ]------------
>>>>> [ 6061.379422] kernel BUG at fs/btrfs/ctree.h:3403!
>>>>> cpu 0x5: Vector: 700 (Program Check) at [c0000000260d7490]
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 pc: c000000000a9370c: assertfail.constprop.=
11+0x34/0x48
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 lr: c000000000a93708: assertfail.constprop.=
11+0x30/0x48
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 sp: c0000000260d7730
>>>>>  =C2=A0=C2=A0=C2=A0 msr: 800000000282b033
>>>>>  =C2=A0=C2=A0 current =3D 0xc0000000260c0080
>>>>>  =C2=A0=C2=A0 paca=C2=A0=C2=A0=C2=A0 =3D 0xc00000003fff8a00=C2=A0=C2=
=A0 irqmask: 0x03=C2=A0=C2=A0 irq_happened: 0x01
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 pid=C2=A0=C2=A0 =3D 739712, comm =3D fio
>>>>> kernel BUG at fs/btrfs/ctree.h:3403!
>>>>> Linux version 5.12.0-rc7-02316-g3490dae50c0 (riteshh@xxxx) (gcc
>>>>> (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu)
>>>>> 2.30) #73 SMP Thu Apr 15 07:29:23 CDT 2021
>>>>> enter ? for help
>>>>> [c0000000260d7790] c000000000a90280
>>>>> btrfs_subpage_assert.isra.9+0x70/0x110
>>>>> [c0000000260d77b0] c000000000a91064
>>>>> btrfs_subpage_set_uptodate+0x54/0x110
>>>>> [c0000000260d7800] c0000000009c6d0c btrfs_dirty_pages+0x1bc/0x2c0
>>>>
>>>> This is very strange.
>>>> As in btrfs_dirty_pages(), the pages passed in are already prepared by
>>>> prepare_pages(), which means all of them should have Private set.
>>>>
>>>> Can you reproduce the bug reliable?
>=20
> Yes. almost reliably on my PPC box.
>=20
>>>
>>> OK, I got it reproduced.
>>>
>>> It's not a reliable BUG_ON(), but can be reproduced.
>>> The test get skipped for all my boards as it requires fio tool, thus I
>>> didn't get it triggered for all previous runs.
>>>
>>> I'll take a look into the case.
>>
>> This exposed an interesting race window in btrfs_buffered_write():
>>          Writer                    |             fadvice
>> ----------------------------------+-------------------------------
>> btrfs_buffered_write()            |
>> |- prepare_pages()                |
>> |  |- Now all pages involved get  |
>> |     Private set                 |
>> |                                 | btrfs_release_page()
>> |                                 | |- Clear page Private
>> |- lock_extent()                  |
>> |  |- This would prevent          |
>> |     btrfs_release_page() to     |
>> |     clear the page Private      |
>> |
>> |- btrfs_dirty_page()
>>     |- Will trigger the BUG_ON()
>=20
>=20
> Sorry about the silly query. But help me understand how is above race pos=
sible?
> Won't prepare_pages() will lock all the pages first. The same requirement
> of locked page should be with btrfs_releasepage() too no?

releasepage() call can easily got a page locked and release it.

For call sites like btrfs_invalidatepage(), the page is already locked.

btrfs_releasepage() will not to try to release the page if the extent is=20
locked (any extent range inside the page has EXTENT_LOCK bit).

>=20
> I see only two paths which could result into btrfs_releasepage()
> 1. one via try_to_release_pages -> releasepage()

This is the race one, called from fadvice() to release pages.

> 2. writeback path calling btrfs_writepage or btrfs_writepages
> 	which may result into calling of btrfs_invalidatepage()

Not this one.

>=20
> Although I am not sure which one this is racing with.
>=20
>>
>> This only happens for subpage, because subpage introduces new ASSERT()
>> to do extra check.
>>
>> If we want to speak strictly, regular sector size should also report
>> this problem.
>> But regular sector size case doesn't really care about page Private, as
>> it just set page->private to a constant value, unlike subpage case which
>> stores important value.
>>
>> The fix will just re-set page Private and needed structures in
>> btrfs_dirty_page(), under extent locked so no btrfs_releasepage() is
>> able to release it anymore.
>=20
> With above fix I see a different issue with below signature.
>=20
> [  130.272410] BTRFS warning (device loop2): read-write for sector size 4=
096 with page size 65536 is experimental
> [  130.387470] run fstests generic/095 at 2021-04-16 05:04:09
> [  132.042532] BTRFS: device fsid 642daee0-165a-4271-b6f3-728f215c5348 de=
vid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (5226)
> [  132.146892] BTRFS info (device loop3): disk space caching is enabled
> [  132.147831] BTRFS info (device loop3): has skinny extents
> [  132.148491] BTRFS warning (device loop3): read-write for sector size 4=
096 with page size 65536 is experimental
> [  132.158228] BTRFS info (device loop3): checking UUID tree
> [  133.931695] BUG: spinlock bad magic on CPU#4, swapper/4/0
> [  133.932874] BUG: Unable to handle kernel data access on write at 0x6b6=
b6b6b6b6b725b

That looks like some poisoned memory.

I have run 128 runs of generic/095 locally on my Arm board during the=20
fix, unable to reproduce the crash anymore.

And this call site is even harder to get race, as in endio context, the=20
page still has PageWriteback until the last bio finished in the page.

This means btrfs_releasepage() will not even try to release the page,=20
while btrfs_invalidatepage() will wait the page to finish its writeback=20
before doing anything.

So this is very strange to me.

Any reproducibility on your side? Or something specific to Power is=20
related to this case? (IIRC some page flag operation is not atomic,=20
maybe that is related?)

Thanks,
Qu
> [  133.934432] Faulting instruction address: 0xc000000000283654
> cpu 0x4: Vector: 380 (Data SLB Access) at [c000000007937160]
>      pc: c000000000283654: spin_dump+0x70/0xbc
>      lr: c000000000283638: spin_dump+0x54/0xbc
>      sp: c000000007937400
>     msr: 8000000000001033
>     dar: 6b6b6b6b6b6b725b
>    current =3D 0xc000000007913300
>    paca    =3D 0xc00000003fff9c00   irqmask: 0x03   irq_happened: 0x05
>      pid   =3D 0, comm =3D swapper/4
> Linux version 5.12.0-rc7-02317-g61d9ec0f765 (riteshh@ltctulc6a-p1) (gcc (=
Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.30) =
#74 SMP Thu Apr 15 23:52:56 CDT 2021
> enter ? for help
> [c000000007937470] c000000000283078 do_raw_spin_unlock+0x88/0x230
> [c0000000079374a0] c0000000012b1e14 _raw_spin_unlock_irqrestore+0x44/0x90
> [c0000000079374d0] c000000000a918dc btrfs_subpage_clear_writeback+0xac/0x=
e0
> [c000000007937530] c0000000009e0458 end_bio_extent_writepage+0x158/0x270
> [c0000000079375f0] c000000000b6fd14 bio_endio+0x254/0x270
> [c000000007937630] c0000000009fc0f0 btrfs_end_bio+0x1a0/0x200
> [c000000007937670] c000000000b6fd14 bio_endio+0x254/0x270
> [c0000000079376b0] c000000000b781fc blk_update_request+0x46c/0x670
> [c000000007937760] c000000000b8b394 blk_mq_end_request+0x34/0x1d0
> [c0000000079377a0] c000000000d82d1c lo_complete_rq+0x11c/0x140
> [c0000000079377d0] c000000000b880a4 blk_complete_reqs+0x84/0xb0
> [c000000007937800] c0000000012b2ca4 __do_softirq+0x334/0x680
> [c000000007937910] c0000000001dd878 irq_exit+0x148/0x1d0
> [c000000007937940] c000000000016f4c do_IRQ+0x20c/0x240
> [c0000000079379d0] c000000000009240 hardware_interrupt_common_virt+0x1b0/=
0x1c0
>=20
>=20
>=20
>=20
>>
>> The fix is already added to the github branch.
>> Now it has the fix as the HEAD.
>>
>> I hope this won't damage your confidence on the patchset.
>>
>> Thanks for the report!
>> Qu
>>
>>>
>>> Thanks for the report,
>>> Qu
>>>>
>>>> BTW, are using running the latest branch, with this commit at top?
>=20
> Yes. Below branch.
> https://github.com/adam900710/linux/commits/subpage
>=20
> -ritesh
>=20
>>>>
>>>> commit 3490dae50c01cec04364e5288f43ae9ac9eca2c9
>>>> Author: Qu Wenruo <wqu@suse.com>
>>>> Date:=C2=A0=C2=A0 Mon Feb 22 14:19:38 2021 +0800
>>>>
>>>>  =C2=A0=C2=A0=C2=A0 btrfs: allow read-write for 4K sectorsize on 64K p=
age sizesystems
>>>>
>>>> As I was updating the patchset until the last minute.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> [c0000000260d7880] c0000000009c7298 btrfs_buffered_write+0x488/0x7f0
>>>>> [c0000000260d79d0] c0000000009cbeb4 btrfs_file_write_iter+0x314/0x520
>>>>> [c0000000260d7a50] c00000000055fd84 do_iter_readv_writev+0x1b4/0x260
>>>>> [c0000000260d7ac0] c00000000056114c do_iter_write+0xdc/0x2c0
>>>>> [c0000000260d7b10] c0000000005c2d2c iter_file_splice_write+0x2ec/0x51=
0
>>>>> [c0000000260d7c30] c0000000005c1ba0 do_splice_from+0x50/0x70
>>>>> [c0000000260d7c50] c0000000005c37e8 do_splice+0x5a8/0x910
>>>>> [c0000000260d7cd0] c0000000005c3ce0 sys_splice+0x190/0x300
>>>>> [c0000000260d7d60] c000000000039ba4 system_call_exception+0x384/0x3d0
>>>>> [c0000000260d7e10] c00000000000d45c system_call_common+0xec/0x278
>>>>> --- Exception: c00 (System Call) at 00007ffff72ef170
>>>>>
>>>>>
>>>>> -ritesh
>>>>>
>=20


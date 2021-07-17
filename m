Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D063CC26C
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhGQKPS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jul 2021 06:15:18 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:55883 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232942AbhGQKPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jul 2021 06:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626516740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bo0rBo6fmeOEHHajZCWufbzYCg6vyA0bWNPcmiYJKig=;
        b=LCrlZojCllMaSPOYSrRBbxT15TpP7QHwyTtmiCxllbXNB1f/kdFSDiQTOILHT4wwmBu5ZY
        XzS+hM93VKOwTqRmnYAkMA6cRArupPSTuTLlFILe3MDbPs7DOUmcIJt8eECEf6cJaLIvIe
        +YB1pxrj6nFD6ZTWhFLMQpApfIpD4x8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-hnLaJyOEO6i_w_RP7G11VQ-1; Sat, 17 Jul 2021 12:12:18 +0200
X-MC-Unique: hnLaJyOEO6i_w_RP7G11VQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/ogVgJTOkUmj8ZUlS9aKLipi5ua0E1ZVIpUtome1+jR8OALlJ/jLqu3NXfJtJID60BWW7YZVJnvhLE9SHiMb23KhK7GXvJ5mp699xvhxY4IlD4yxem9Q5vBSfIaANdXyRWmrmyO7t22DZF1n4Gh2ybkAtRjBObPE65MPxBFSybKH/YRsT5RQ7YwkXxHig6uf+vkJ/g4wzRT+Gb5SIdo+zl5hwBGLjPvGNvq74FKjZVhGRXXAIKFrmBII9tPYOQoGTg7vj10NsLidgVz8PUPF3S19GpFZS988lcdv8o2qxZU5Wx1CnbQ/3VK6ESUU2Y2Wj+p6Fs/bHiE9qeS/hWWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1H4J76IC/NUhIv6L/nwnCpDWU5vSpjFw3azai7Hews=;
 b=kji/syhcuzx+dCe6Z3ytkY8v6ekfPDPCelAEyBQ35Mz3OPrZpUwyaja6kf3YGLqC97+U9zamHpzsvPguoKcjOXzMJ7iFfAdGLIql30NQHUFW2Zky0U8qBci7peuQhoH2Eh8CGi6JDTDqmChduBDt/XMngHcCrRB15XZaGl1/YvnQU434o24+DlbY5IA3CNHCUZYmk21NsbkdwSLl5GLvwsnPILKF6nUzCAMvlAH1UFDXsnu0KriCawVPwWA0YpOStkz/QCXXkGM9VQZvpxxKRfAFsPhLimzoXxwYDFyfRJG+PCw1TM5vwLJBL1BkOAtspVXDEoocPRAQiAH+Zf6SQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3560.eurprd04.prod.outlook.com (2603:10a6:209:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Sat, 17 Jul
 2021 10:12:17 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4331.029; Sat, 17 Jul 2021
 10:12:17 +0000
To:     pepperpoint@mb.ardentcoding.com, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     linux-btrfs@vger.kernel.org
References: <162648632340.7.1932907459648384384.10178178@mb.ardentcoding.com>
 <162650555086.7.16811903270475408953.10183708@simplelogin.co>
 <162650826457.7.1050455337652772013.10184548@mb.ardentcoding.com>
 <162650966150.7.11743767259405124657.10185986@simplelogin.co>
 <162651226617.7.3584131829663375587.10186721@mb.ardentcoding.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Read time tree block corruption detected
Message-ID: <5ae95eb0-938f-dc17-1779-ebe716fcc832@suse.com>
Date:   Sat, 17 Jul 2021 18:12:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <162651226617.7.3584131829663375587.10186721@mb.ardentcoding.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::20) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR20CA0007.namprd20.prod.outlook.com (2603:10b6:a03:1f4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 10:12:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 280129e0-2f2c-4c7e-08e9-08d9490b5b1e
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3560:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB356073A3FDB1E715BE5CCCF1D6109@AM6PR0402MB3560.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXp9oJ5i5oKKj1IPpk2c62lLtklFoWfu4fqigrD5cWLISikrjrBEZJ1eg1KP5bZjigsef0U2ZJ5BlFXNRVGeV6dN3ulDKXYkFmcMm4c+8IO9Fgw9hPXKsDbxSyxWMut4BZz/k8Nt/LeNia2UmvN4v366jthKPINTIXBIJOgTF7B6dcqEJLGmXUy98+M7sJa2U4W0jrqu2MinHPdCtlXZFJTH19QLyO2ZJYCrF3hYcAvUt+wUAKhZ+zQJOV0rco1a+FGu2dQyc7KNHv7ybBDXD9n+Y2EZdHraNVVb6m8NFbuva7LGRFgynIFyFad/RTtIOj07eigPdwpB6DDS6KL2WPyEmmv1t7l3AlnKUJPTU1nlxLfvvSpwrblAg05HUT2HYH1ZEL4j87IAHkmDxhLqC3zYI0CsCqP6vR8erB/xQLeaLME2nrOBsCKT0UNWtB+g9Q5shJjumCvjy+i/VVWWPFCKj0SYELtNAJqULEfhrXqzX+ocU0KR1MrWuuE9YUMa4k3K5Sn7QNPA/Eq31OUBDEGwgwp7RqFGhdHw4R83HH8QmX/+FTxNU/pApC7NQXx/41UlxELSgixRaPjL8GXRBJ5egEjEO+itCttW3gQyJYr4aAgkemteDrZkI4Yz6fp/8aZHCv9ODccKjIAZBDEp+nTlNtXa5/EEl0lYv4vbitzEoLXUj80RMlwu+gdlU2Mn9VwMleuHuN3D9Y4QB2B/91DMWETnuem/nzFE4P2kAqfK8thaWThNZSAN9T6F2Jy0HEk00aNQ0SnEFcc9HjIl3D1zcyKsMfcOwch+6b+ErUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(396003)(136003)(346002)(376002)(31686004)(83380400001)(8676002)(316002)(6916009)(36756003)(38100700002)(16576012)(8936002)(66556008)(66476007)(86362001)(6706004)(4326008)(66946007)(2616005)(956004)(186003)(2906002)(5660300002)(26005)(478600001)(31696002)(6486002)(6666004)(518174003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kAxgjTL4qfxl6lRCfUHOovbrC5eJuOfTRYNDW9xlJfnMwACCDzkEVrw7Gabi?=
 =?us-ascii?Q?zkugBo/LMumL39oNO9YQDnwZFwAPlJ5cOUiDU118tKxWwTUB8anX3ucn1S3A?=
 =?us-ascii?Q?+xd+4yy3tOdLwP080hUb8DLsnh4PANtv7jGXfIucSJDOr1kCMRAJr6WZDOLw?=
 =?us-ascii?Q?8EvvuQPluk7/UgB4nxBQhtSq4baLa/U++yxcErzxvZv28HdboNhfdTuaALGB?=
 =?us-ascii?Q?f19DU7cAsozc1MWgE1RrU57PY9vQEPGN5tIjdljL0Uz2dijPe8R0dVmj6tea?=
 =?us-ascii?Q?PPEwBwF+Jm+54/z8uxaLbUmq+i2m0J/IHigQbMZgt7UkoHkvGb/MWX7ptU0W?=
 =?us-ascii?Q?TkjK3tT6caZReqqMgQego5Es6vX28Yx+O/tPBzbWc+V85b0J3BFypxHMD/aX?=
 =?us-ascii?Q?xyNqb2Jugy9diqjrT/rN1ZziZqCaV/idG4b54wbT8YOYZqwrGXsT4auXuPcM?=
 =?us-ascii?Q?Z44F/n6xuVH2Su1vi73vABmgK4eAh4uEx4Z9CbNFjbS/HqpjEYYb1zKpbzjA?=
 =?us-ascii?Q?WIpFTYB9nHugIrbiHIrITZ+j2ZPfM6LIGSP6sRkLLDMLzrFvOtI2X2pLtz7w?=
 =?us-ascii?Q?ROGDqIicfPwph8ciG/HOMdY6ZHsKWMZnqnap0mqqC2w1FGAfw9PLsO9nZhN+?=
 =?us-ascii?Q?4NIjq0Ef4lVlo/eOGv5EN8WLVo98Rat5OqCAUePJMAXPyD8nLb4fsWm3w0dc?=
 =?us-ascii?Q?TJ6dv6W+GKDJzsI7sBLVLfw4G/TX8lGzxVA70vR6SrLoV6OjhnXJcsj86yPd?=
 =?us-ascii?Q?rzxFZj1+/KBE18yTrXwSLYjBm/yvsu29zIS7gpPr2iwvLC91fQtIniNdjj1Q?=
 =?us-ascii?Q?lG4n5fRqMebCnoFU4zfSxLhhz9Y+aLrKlXupzA+lU+g8BSB7T9oO8l80l2/w?=
 =?us-ascii?Q?Oq4MjL0dNp1SzZhyc+xcB7ou4JAzfvoCEXBcUCgYQL0c1cgCtnSxVsgDUlZv?=
 =?us-ascii?Q?o1j57FSXOERC5qBpwOLkTHTraTuRKu9pfUTio26+IWJSGo2y3prXzuN3CQLd?=
 =?us-ascii?Q?XYS+IluRLNa0+fxMKmFYZZEf9mW1bkeBsOPaT++cCqwFvX9HoiHb0b/sYSgY?=
 =?us-ascii?Q?SHkK1C/SdLRUI9/HTdadJelGNhP5OznmbiGghzzwmEwaIUPOrqMOtXjPn/X3?=
 =?us-ascii?Q?fGxzr1jkIIRPvy0BYb7jeJLTfPh1rvkvMapFPBxH0xyE3WJ9NF6B+VdSy3Np?=
 =?us-ascii?Q?Tvoor/a6LUqq6tHx1RFBBVS/rOsm60obMvt96VPEbqEAvlX7ryCZOfuU/MCS?=
 =?us-ascii?Q?Wl5g0aXH+TlNnt8vaxGh98Qd5vRyk6GV2UtxtnF/bF0fzlzw2+U8Is/URZmK?=
 =?us-ascii?Q?EUPzzcN6DZIZCPFTqSUeHEHy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280129e0-2f2c-4c7e-08e9-08d9490b5b1e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 10:12:17.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jxe//H0fCl+lwPkWkMQ2tQzDl0GuN4hlsoAcxKX62xWEooLJMdr0Am5vn06W0EM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3560
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/17 =E4=B8=8B=E5=8D=884:57, pepperpoint@mb.ardentcoding.com wrote:
> Hi Qu,
>=20
> I don't know how the directory was created but last month, I used btrfs d=
evice add and btrfs device remove to move the filesystem from one partition=
 to another. It failed because of the same error and was advised to use btr=
fs replace instead. I don't know if the error also happened before I move t=
he file system as I don't have any previous logs.

It definitely happens before you moving the fs.

As regular dev replacing/add/move only relocates the metadata, but not=20
touching the fs trees.

>=20
> Here is the result when I search for the inodes you mentioned if it helps=
:
> # find /run/media/root -inum 260 -exec ls -ldi {} \;
> 260 -rw-r--r-- 1 root root 36864 Jun 25 06:22 /run/media/root/@vcache/liv=
e/snapshot/app-info/cache/en_US.cache
> 260 drwx------ 1 mongodb mongodb 136 Sep 12  2020 /run/media/root/@vlmong=
odb/live/snapshot/diagnostic.data
> 260 -rw-rw---- 1 mysql mysql 50331648 Sep 13  2015 /run/media/root/@vlmys=
ql/live/snapshot/ib_logfile0
> 260 -rw-r----- 1 root lp 8641 Mar  5  2014 /run/media/root/@vspool/live/s=
napshot/cups/d00001-001
> 260 dr-xr-xr-x 1 root root 0 Sep 13  2013 /run/media/root/@/live/snapshot=
/sys
> 260 dr-xr-xr-x 1 root root 0 Sep 13  2013 /run/media/root/@/4/snapshot/sy=
s

Since btrfs can have the same inode number inside different subvolumes,=20
you may want to limit the search inside subvolume 363.

"-mount" option of find can do that, you only need to locate subvolume=20
363 by "btrfs subv list".


But from these output I guess above two "sys" directory are more possible.

Is there any directory named "blaklight" inside those directory?

>=20
> # find /run/media/root -inum 286 -exec ls -ldi {} \;
> 286 -rw-r--r-- 1 root root 96 Aug 16  2015 /run/media/root/@vcache/live/s=
napshot/fontconfig/4b172ca7f111e3cffadc3636415fead9-le64.cache-4
> 286 -rw-rw---- 1 mysql mysql 4096 Sep 15  2013 /run/media/root/@vlmysql/l=
ive/snapshot/mysql/columns_priv.MYI
> 286 -rw-r-----+ 1 root systemd-journal 16777216 Jul  4 01:14 /run/media/r=
oot/@vlog/live/snapshot/journal/5098dd7845ae46d3ba1826c68a809a7c/user-1000@=
fbd9f65d0ea349f6b996716280e6c4dd-00000000002314c5-0005c5cb84a3a438.journal

This is interesting, it means the inode 286 is not accessible.

It can be some orphan inode, but would you dump subvolume 363 then try=20
to locate the inode 286?
One example command would be:

# btrfs ins dump-tree -t 363 <dev> | grep -A 5 "(286 "

Thanks,
Qu


>=20
> Directories with pattern /root/@<dir>/live/snapshot/ are subvolumes and d=
irectories with pattern /root/@<dir>/<num>/snapshot/ are snapshots of live.
>=20
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
>=20
> On Saturday, July 17th, 2021 at 4:14 PM, Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>=20
>> On 2021/7/17 =E4=B8=8B=E5=8D=883:51, pepperpoint@mb.ardentcoding.com wro=
te:
>>
>>> Hi Qu,
>>>
>>> Please see below for the dump.
>>>
>>> btrfs-progs v5.12.1
>>>
>>> leaf 174113599488 items 18 free space 2008 generation 1330906 owner 363
>>>
>>> leaf 174113599488 flags 0x1(WRITTEN) backref revision 1
>>>
>>> fs uuid a7d327c4-8594-4116-a6f8-8aa2a4162063
>>>
>>> chunk uuid f885f49e-14a0-4c80-9c12-c2302b9a0229
>>>
>>> item 0 key (5471 INODE_ITEM 0) itemoff 3835 itemsize 160
>>>
>>> generation 2063 transid 27726 size 40 nbytes 40
>>>
>>> block group 0 mode 100600 links 1 uid 0 gid 100 rdev 0
>>>
>>> sequence 1501 flags 0x0(none)
>>>
>>> atime 1386484844.468769570 (2013-12-08 14:40:44)
>>>
>>> ctime 1386484844.468769570 (2013-12-08 14:40:44)
>>>
>>> mtime 1386484844.468769570 (2013-12-08 14:40:44)
>>>
>>> otime 0.0 (1970-01-01 08:00:00)
>>>
>>> item 1 key (5471 INODE_REF 4399) itemoff 3824 itemsize 11
>>>
>>> index 12 namelen 1 name: 8
>>>
>>> item 2 key (5471 EXTENT_DATA 0) itemoff 3763 itemsize 61
>>>
>>> generation 27726 type 0 (inline)
>>>
>>> inline extent data size 40 ram_bytes 40 compression 0 (none)
>>>
>>> item 3 key (5645 INODE_ITEM 0) itemoff 3603 itemsize 160
>>>
>>> generation 2542 transid 61261 size 40 nbytes 40
>>>
>>> block group 0 mode 100600 links 1 uid 0 gid 100 rdev 0
>>>
>>> sequence 24769 flags 0x0(none)
>>>
>>> atime 1394335806.351857522 (2014-03-09 11:30:06)
>>>
>>> ctime 1394335827.344389955 (2014-03-09 11:30:27)
>>>
>>> mtime 1394335827.344389955 (2014-03-09 11:30:27)
>>>
>>> otime 0.0 (1970-01-01 08:00:00)
>>>
>>> item 4 key (5645 INODE_REF 4399) itemoff 3592 itemsize 11
>>>
>>> index 13 namelen 1 name: 7
>>>
>>> item 5 key (5645 EXTENT_DATA 0) itemoff 3531 itemsize 61
>>>
>>> generation 61261 type 0 (inline)
>>>
>>> inline extent data size 40 ram_bytes 40 compression 0 (none)
>>>
>>> item 6 key (7222 INODE_ITEM 0) itemoff 3371 itemsize 160
>>>
>>> generation 5754 transid 5767 size 307 nbytes 307
>>>
>>> block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>>>
>>> sequence 7 flags 0x0(none)
>>>
>>> atime 1379834835.428558020 (2013-09-22 15:27:15)
>>>
>>> ctime 1379834835.428558020 (2013-09-22 15:27:15)
>>>
>>> mtime 1379834835.428558020 (2013-09-22 15:27:15)
>>>
>>> otime 0.0 (1970-01-01 08:00:00)
>>>
>>> item 7 key (7222 INODE_REF 287) itemoff 3344 itemsize 27
>>>
>>> index 6 namelen 17 name: dhcpcd-eth0.lease
>>>
>>> item 8 key (7222 EXTENT_DATA 0) itemoff 3016 itemsize 328
>>>
>>> generation 5767 type 0 (inline)
>>>
>>> inline extent data size 307 ram_bytes 307 compression 0 (none)
>>>
>>> item 9 key (7415 INODE_ITEM 0) itemoff 2856 itemsize 160
>>>
>>> generation 5904 transid 1330906 size 180 nbytes 0
>>>
>>> block group 0 mode 40755 links 2 uid 0 gid 0 rdev 0
>>>
>>> sequence 177 flags 0x0(none)
>>>
>>> atime 1483277713.141980592 (2017-01-01 21:35:13)
>>>
>>> ctime 1563162901.234656246 (2019-07-15 11:55:01)
>>>
>>> mtime 1406534032.158605559 (2014-07-28 15:53:52)
>>>
>>> otime 0.0 (1970-01-01 08:00:00)
>>
>> This inode is indeed a directory.
>>
>> But it has two hard links, which is definitely something unexpected.
>>
>> Under Linux we shouldn't have any hardlink for directory, as it would
>>
>> easily lead to loops.
>>
>>> item 10 key (7415 INODE_REF 260) itemoff 2837 itemsize 19
>>>
>>> index 28 namelen 9 name: backlight
>>
>> Its parent inode is 260 in the same root, with the name backlight.
>>
>>> item 11 key (7415 INODE_REF 286) itemoff 2818 itemsize 19
>>>
>>> index 3 namelen 9 name: backlight
>>
>> Another hardlink in inode 286, which is definitely a regular thing.
>>
>> Btrfs-progs lacks the ability to detect such problem, we need to enhance
>>
>> it first.
>>
>> But do you have any idea how this directory get created?
>>
>> It looks like the content of sysfs.
>>
>> Thanks,
>>
>> Qu
>>
>>> item 12 key (7415 DIR_ITEM 3128336373) itemoff 2746 itemsize 72
>>>
>>> location key (120417 INODE_ITEM 0) type FILE
>>>
>>> transid 117279 data_len 0 name_len 42
>>>
>>> name: pci-0000:00:02.0:backlight:intel_backlight
>>>
>>> item 13 key (7415 DIR_ITEM 3218198317) itemoff 2705 itemsize 41
>>>
>>> location key (7487 INODE_ITEM 0) type FILE
>>>
>>> transid 5992 data_len 0 name_len 11
>>>
>>> name: acpi_video0
>>>
>>> item 14 key (7415 DIR_ITEM 3582254411) itemoff 2638 itemsize 67
>>>
>>> location key (55325 INODE_ITEM 0) type FILE
>>>
>>> transid 63351 data_len 0 name_len 37
>>>
>>> name: platform-VPC2004:00:backlight:ideapad
>>>
>>> item 15 key (7415 DIR_INDEX 2) itemoff 2597 itemsize 41
>>>
>>> location key (7487 INODE_ITEM 0) type FILE
>>>
>>> transid 5992 data_len 0 name_len 11
>>>
>>> name: acpi_video0
>>>
>>> item 16 key (7415 DIR_INDEX 4) itemoff 2530 itemsize 67
>>>
>>> location key (55325 INODE_ITEM 0) type FILE
>>>
>>> transid 63351 data_len 0 name_len 37
>>>
>>> name: platform-VPC2004:00:backlight:ideapad
>>>
>>> item 17 key (7415 DIR_INDEX 5) itemoff 2458 itemsize 72
>>>
>>> location key (120417 INODE_ITEM 0) type FILE
>>>
>>> transid 117279 data_len 0 name_len 42
>>>
>>> name: pci-0000:00:02.0:backlight:intel_backlight
>>>
>>> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
>>>
>>> On Saturday, July 17th, 2021 at 3:05 PM, Qu Wenruo quwenruo.btrfs@gmx.c=
om wrote:
>>>
>>>> On 2021/7/17 =E4=B8=8A=E5=8D=889:45, pepperpoint@mb.ardentcoding.com w=
rote:
>>>>
>>>>> Hello,
>>>>>
>>>>> I see this message on dmesg:
>>>>>
>>>>> [ 2452.256756] BTRFS critical (device dm-0): corrupt leaf: root=3D363=
 block=3D174113599488 slot=3D9 ino=3D7415, invalid nlink: has 2 expect no m=
ore than 1 for dir
>>>>>
>>>>> [ 2452.256776] BTRFS error (device dm-0): block=3D174113599488 read t=
ime tree block corruption detected
>>>>
>>>> Please provide the following dump:
>>>>
>>>> btrfs ins dump-tree -b 174113599488 /dev/dm-0
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>> Thanks,
>>>>
>>>> Qu
>>>>
>>>>> When I run btrfs scrub and btrfs check, no error was detected.
>>>>>
>>>>> I am running Linux 5.12.15-arch1-1 and btrfs-progs v5.12.1
>>>>>
>>>>> How should I fix this error?
>=20


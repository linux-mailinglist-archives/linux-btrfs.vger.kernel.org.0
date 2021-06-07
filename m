Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40B639E857
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 22:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFGUZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 16:25:15 -0400
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:40449
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230454AbhFGUZO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Jun 2021 16:25:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/GRX7IT/R7RNbx3qZ3/WSZOLvFCRqowJ/u68v1VGlpZpIW3ZKzRpGIgsUbgxmj/bsVfdTw1Rl0goxmaF79gQ/zbj53rzALVAX5cSCoZK0/l86UvtaLUwLo8bv3W9zh+PNl/a0nonxLD7zuQo7xbFMtZcrhyqVm+ELz1Gz9FeAFP9hg3xf4g6zMC6wpKMUEL38GPrD+mqZcjPLCtmhMNStWilhXzedifOYMvrAAsZYH8/RHnb1P02cvcoT5aEy8yj8uHaH+QudqLcJ9xiwpIAVGSgW/g/S+mZMcQBl5YiReLic4aGVIOnYzZLvCj0Uq/CiXHXCyttP3+ZG7l8WG77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyOCjIEaSE+ZtOOu0nkWZ3tZWI008JNjFtf/K55sEQg=;
 b=F0wBm+3c3Yr7thYqmhQ2G7Tk8bqsWSVvGPn62/xezAjMylGbh5ZVd4HIYtdKredjDftP4V8TfmSEw4vmVh9xwW9uBKkNMO1HZaR4Bfmjdc+Wh3o4UQHNjZIteBOTM0ySw6Qig7rCpKvibGVtg5fPSeTbD0wDLcZFWov/n1mw7Xl0mVXv2DkjT8J33vaUp9Th91Qx6/Y37aoHbQ06EeT/Pql5bFcuQHIlgO/ztf7aWDFco7N7cHHTaR3yRS09cT0LMfMAr+Bthrxf+8YiBc1XWlXdp5igpob9YY1lcapztg887uPfr1If3koksujFh7WPyrGkn+OD6VGDKCDFl4kQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyOCjIEaSE+ZtOOu0nkWZ3tZWI008JNjFtf/K55sEQg=;
 b=j8LiX+oRMQ4yFrqJImvlVyWPjFrzj2MAe0JmKqDHp05BC8BQ9MnY8S7XekxNdLkc6kLXpocdcEnDMqfOkZ/M1gbt2+FOzpIMEOUBrfKnaNdgrbh7YcY4LLChsYv74m73jbD4nuUhLxtnrfJSBqNOubktQljxfpVMS5qiaqLd1Qo=
Received: from CY4PR08MB3413.namprd08.prod.outlook.com (2603:10b6:910:77::14)
 by CY4PR08MB3622.namprd08.prod.outlook.com (2603:10b6:910:78::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.30; Mon, 7 Jun
 2021 20:23:20 +0000
Received: from CY4PR08MB3413.namprd08.prod.outlook.com
 ([fe80::34ba:96b:3214:fc6e]) by CY4PR08MB3413.namprd08.prod.outlook.com
 ([fe80::34ba:96b:3214:fc6e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 20:23:20 +0000
From:   "Karaliou, Aliaksei" <akaraliou@panasas.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "Sinnamohideen, Shafeeq" <shafeeqs@panasas.com>
Subject: Btrfs: Issues with remove-intensive workload
Thread-Topic: Btrfs: Issues with remove-intensive workload
Thread-Index: AQHXW9ofi69ecqUEx0Kev9PXYCN01A==
Date:   Mon, 7 Jun 2021 20:23:20 +0000
Message-ID: <CY4PR08MB3413C14165930B3080FA6D3EAD389@CY4PR08MB3413.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
x-originating-ip: [185.203.155.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e026fc34-63ec-4a1b-ed19-08d929f217ae
x-ms-traffictypediagnostic: CY4PR08MB3622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR08MB3622912CD670EC1FE4B0A459AD389@CY4PR08MB3622.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3X+/xnQ6q3q4OrmZbClwnDwCJp1dpZ+30cXUS/3otX02k1eZE+nuJyvbwWPzzdlMor16TSjQsPDNsmMNVo4c+7CTkZ6LtGxWKOZxe8JJqo6R360VkIH5FsdxREwyfg9zbHduWCJ4/QuVJdWFi4wxIatb7N6FoOosu24KX8E2t1UFYbNJVo9QqL8vbWUgfT1u0TLGj9WG5+iqozu6SnQ0OkM+g3WzMy2eSJhEqrS3sd7BSuwavt7UjHQCIYLpATUibRolAGZwtVw32BqUkRlTqqe1z4OB3rn8psjXPfvBeathbAYdQL/VKwzVVvud0S1iofb9thkpgKV+yojrz5JnT2Wt5gznmStSBimWF0wXH+rAUC9foj/9hD36v2ve5J0vyZBBeQRS9fD60qDz9pY8ncamZnn7FBSWK//4r2CYKeSC5n0jBLlHsPlRW7Mp+Xggo3vP6iBctNhAU2HgBy5RxoPYncW5D9XM7BWgeq1CBkDxUC5zz3mU9gSxpmJwOfmWVf+6JPm9I/O91uFdEb0t7rORzd5f3Hf4XSiasEz9aVh3UlrB3mHChsuNkHVHcZxI1IeMrDIbGGm0bmqcl8E8jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR08MB3413.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(396003)(366004)(376002)(346002)(478600001)(86362001)(6506007)(38100700002)(2906002)(7696005)(71200400001)(9686003)(6916009)(122000001)(5660300002)(8936002)(186003)(8676002)(4326008)(55016002)(91956017)(33656002)(316002)(52536014)(107886003)(26005)(66476007)(66556008)(66446008)(83380400001)(66946007)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?vB1K3J3Gc49IDJFZfs4zwzoWeHhohNuRi0tzqS/iK9i2uEamqwsVRjIRrt?=
 =?iso-8859-1?Q?rHixyaNLlV9EjcMAA8u6HjkKFq/7ASzgZewpdg93X/6gH7HhCWE7Sn955s?=
 =?iso-8859-1?Q?nh9G7ycje7NU2iXJLtW4BaUQdUemnbY/Kfm1tRQH94mAn0NPZS9vTZwoNd?=
 =?iso-8859-1?Q?ogg12eXOfkFz5f9WnJZKQ8XjanrcZYeFY9IgN4Q8p2UBdKebXaaGCBN/lN?=
 =?iso-8859-1?Q?P/HDDl8G93wvEt+YsQb1qR+G0isXvw4pj7gK+/fyVaBDUhQsJ/AXblVRWn?=
 =?iso-8859-1?Q?WvM1XsYaWxNMmuDZc0NcgGkUgZFnMUmtGce3CL/MDEeOW5dIxG4swDTXfz?=
 =?iso-8859-1?Q?rLuA3BNPl952jHZI7dE4t1AICTcmmsWhGukwAsXnEy5QaMtn1MO5Y5A9lk?=
 =?iso-8859-1?Q?FHM6DJol85OG+l6MIp1S1MeRRzgnTjc0oMwu6Eeda/suOPLO+2xZeQOAfa?=
 =?iso-8859-1?Q?v7CwcaCDVWnQ8xmaM8k0WVf1pHyiKGSNI6P11OThp9D6xClHP9F5MqseJ0?=
 =?iso-8859-1?Q?X79cbOPclwX+vAwineXpuJhP6JUwAp59puCRXh9T3tow0quzAk+Obigau+?=
 =?iso-8859-1?Q?97sZN2+q/76Nnji5sfjv6BNuUZuZw37To9xpXQqe/ZFZequOP7AU/FBI5L?=
 =?iso-8859-1?Q?aC17Coo6Fa5kxEKDl6KlIVtdryxX5ZRVJM/3MTmUiV9NGL4UMDSg358+x8?=
 =?iso-8859-1?Q?gNhx++83hed0Gvl3GR4EqUxl2C9RX/PcZWef/6h7abSqXf+cqGW3UfP1DD?=
 =?iso-8859-1?Q?sZXDNkS129i0nGfdLhPnn8gWSpTaS+abRHLetGdvRg/9eC1QTYye17zGIP?=
 =?iso-8859-1?Q?1KeuHlLEjEagUNwXHarO4WGB+IBjJHhdjil9IenNY26nRyWoSJ4BRx+A10?=
 =?iso-8859-1?Q?YgKIFrYR+NluEwSk3eIf7d75JDqS7fX33m/AH67WmJ3qdRB0a0Lt9NsPxg?=
 =?iso-8859-1?Q?ZajMvU8/MT/8nMhIgyMgFav4QMXeHFn6D4IIjE/Err6/xeZioVjtHSsqBg?=
 =?iso-8859-1?Q?eCnLXBJiZR2rTfk/UqatqPGlhFLBnpX4DsaihprYz14RUdMlObP7lRHT1X?=
 =?iso-8859-1?Q?RraZgNjkuivT85yvYUybBoQFObiH8ZES9TET2aUsp28nVADXyySodC9xQO?=
 =?iso-8859-1?Q?6PjpCc0prw3Q2hfQqA2n99s5I9AP9HE15raCWh/DKMOCm1HtuQ5Cnr1xtF?=
 =?iso-8859-1?Q?Bw3d5C/CHCfcB5HLRikuu5IP56FZasCXrPF1N4dFk2+g7u4b46R4Sc6/iE?=
 =?iso-8859-1?Q?jnGgmUzDsf0T3WDmFpLxvEcFRTyaPD8iwvzsQXT4k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR08MB3413.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e026fc34-63ec-4a1b-ed19-08d929f217ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 20:23:20.3341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPuhb09Bzz+7jnz4lofmG09yi4u8K8VMXb6e4UsAhyULhbW52CWgoa8c9iuf1k/fSNDHUOVF4WKFnyX/vxydoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR08MB3622
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,=0A=
=0A=
We have an issue with certain workloads and are looking for a hint regardin=
g what=0A=
to do in our case. Maybe there are ways of improving this in BTRFS module,=
=0A=
or there is a way for us to avoid certain behaviors.=0A=
=0A=
Issue:=0A=
Occasionally, we have a pretty intensive delete-only workload with=0A=
tens to hundreds of gigabytes of data being removed during a rather short p=
eriod=0A=
of time as the filesystem allows. It's not 'rm -rf' of a tree but removes=
=0A=
in different locations of directory hierarchy tree by individual requests.=
=0A=
Also, in order to maintain consistency after possible power off/crash event=
s=0A=
we fsync these directories with a few background threads relatively frequen=
tly=0A=
(period of sync is about 5 seconds).=0A=
=0A=
After a few minutes under such load, those background fsyncs are getting st=
uck=0A=
for varying amounts of time. It might be 30 seconds, usually 200-600, but=
=0A=
we've once seen over 13K seconds. Remove operations continue, but since=0A=
fsyncs are required operations and we don't allow directories to be=0A=
unsynced 'forever', we eventually block foreground operations in applicatio=
n.=0A=
After that we don't produce more removes and the transaction has a better=
=0A=
chance to finish 'quickly'.=0A=
=0A=
Hardware: 6 HDDs merged into MDRAID 0 with 8M stripe.=0A=
Mount options: relatime,space_cache=3Dv2.=0A=
=0A=
For testing we used files around 100-250M. They had different number of=0A=
extents. Half of them had usually less than 4, but on average around 200-25=
0.=0A=
Files might be located in snapshots as well (so they have usually unmodifie=
d=0A=
copies in other BTRFS subvolumes). There are several foreground threads=0A=
which may perform some usual activity (search/modify database, etc.) then=
=0A=
remove a file from a tree. This seems similar to having an number of=0A=
scripts each picks up a random file from random directory, remove it,=0A=
then sleep fraction of a second, and then repeat.=0A=
=0A=
Before getting stuck or transaction commit begin, we deleted at a rate of=
=0A=
300-400 files/s. After an hour, this degraded to an average of just=0A=
18 file/s.=0A=
=0A=
It seems that creating sparse files with similar average number of extents=
=0A=
shows same behavior.=0A=
=0A=
Tests were conducted on OpenSUSE Leap:=0A=
 * 15.0 (kernel-default-4.12.14-lp150.11.4 but btrfs is modified -=0A=
   several patches from 15.1 applied)=0A=
 * 15.2 (kernel-default-5.3.18-lp152.19.2)=0A=
 * 15.0 with kernel updated to kernel-default-5.12.6-1.1.gfe25271=0A=
=0A=
Analysis with trace points added using 'perf' showed a few scenarios:=0A=
A) Several fsync() calls are blocked on 'btrfs_run_delayed_refs(trans, 0)' =
in=0A=
   btrfs_commit_transaction.=0A=
   This issue seems to be fixed by=0A=
     '[PATCH v5 2/8] btrfs: only let one thread pre-flush delayed refs in c=
ommit'=0A=
   which was already applied to kernel-default-5.12.6-1.1.gfe25271 where mo=
st of tests=0A=
   were conducted.=0A=
=0A=
B) When our background thread calls fsync() on a directory, its inode alrea=
dy has=0A=
   BTRFS_INODE_NEEDS_FULL_SYNC flag set, unfortunately it was rare case and=
 we=0A=
   didn't trace where it came from.=0A=
   In this case we perform a real-world transaction commit and are doing fu=
ll=0A=
   amount of delayed-refs job instead of btrfs-transaction kthread.=0A=
=0A=
C) btrfs-transaction kthread wakes up and works on committing current trans=
action.=0A=
   While it is on 'btrfs_run_delayed_refs(trans, 0)' stage everything doesn=
't=0A=
   seem to be so bad, but we are adding more delayed refs to be processed=
=0A=
   and this count is usually much more than initial triggering count that t=
his call=0A=
   to btrfs_run_delayed_refs is going to take care of.=0A=
   Then when we change transaction state to TRANS_STATE_COMMIT_START=0A=
   fsync() threads are just stuck at wait_for_commit for a whole time.=0A=
=0A=
I think there might be other scenarios when we move away from pure-delete=
=0A=
workload, but I think these are enough.=0A=
=0A=
More or less happy scenario here is when btrfs-transaction kthread is in ch=
arge=0A=
of commit (it's sleep interval doesn't really makes difference - 30 or 5 se=
conds).=0A=
But when one of our background fsync threads or foreground threads are in c=
harge=0A=
that's a potential disaster because all delayed-refs job is going to block=
=0A=
this thread, especially foreground one.=0A=
=0A=
As I understand, this type of workload is rather extreme and=0A=
current BTRFS design doesn't allow to for a way to split delayed-refs handl=
ing=0A=
across several transactions to allow more granular commits.=0A=
=0A=
Also, an open question for us is how snapshot delete is different in this c=
ase?=0A=
Will we and when would we get stuck on fsync for snapshot deletion? Would i=
t be=0A=
as long?=0A=
=0A=
I assume that snapshot delete is a bit more efficient operation since=0A=
directories don't need to be updated and fsync'ed. Is this correct?=0A=
I once conducted a test of removing several huge files manually vs removing=
=0A=
them as a subvolume. It seem faster to delete as a subvolume.=0A=
=0A=
I expected some throttling in BTRFS when deleting files with many extents,=
=0A=
but I don't see such behavior (and of course there might be delete of some =
50G file=0A=
eventually, which is VM image and super-sparse - it will have zillion exten=
ts=0A=
and throttling applied only to this delete will not help).=0A=
Maybe there is something that might be improved within BTRFS internals?=0A=
=0A=
We must delete files, but we potentially may delay this operation by just=
=0A=
moving them to a 'trashbin' directory, then deleting slowly.=0A=
But even in this case we would need to have extra information so we can thr=
ottle this=0A=
well enough so that the next fsync will not take minutes (less than 30 seco=
nds would be ideal).=0A=
To my understanding, there is no such feedback mechanism that we can use.=
=0A=
The only indicator for us is file size and number of extents that we may ob=
tain via FIEMAP.=0A=
=0A=
An additional complication are snapshots that might be taken when we still =
have a bunch=0A=
of files sitting in this 'trashbin' directory waiting for our background de=
letion - at least=0A=
from metadata side that means increased amount of work with each snapshot c=
reated.=0A=
=0A=
As an option we considered usage of reflink ioctl to first move portions=0A=
of file (depending extents count) to some huge file located in different=0A=
volume (on the same device of course), then delete it if that makes=0A=
internal operations faster, but that definitely adds cost of reflink.=0A=
=0A=
Any advice or comments on this issue and my thoughts on mitigations=0A=
would be much appreciated.=0A=
=0A=
Best regards,=0A=
  Aliaksei=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4973CAF26
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 00:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhGOWd5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 18:33:57 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:43032 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232160AbhGOWd5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 18:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626388262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKLMHXdyACPX33pRMK1vyPh3VAiJro4jWK4T7gBasJ8=;
        b=fYZ4yndpQOn/NPByNHe4GtNUKAjbq2iGRWU4JR5UDTuPenpVhtbYlcm/UvbMnYFbYcqp/0
        aOj8jBHl8w1XiUV4eCvOjUVJq9PX3I45MpgHkb2izEFeZzuRL+SIcS89WDYvGgLOul8CZR
        eZiZ8AXf3HfnIzGt+yf0wG0hu+TnPeY=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-R0yoHep7MWKjXVlWZ25eSA-1; Fri, 16 Jul 2021 00:31:01 +0200
X-MC-Unique: R0yoHep7MWKjXVlWZ25eSA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSpTEW1mmih0vnGeQu2VVT9AYov8AkNBu/C2FGSZ8hevOKQaj0HlW2umMJzD2YuOk938XH4VfQFQE8pkEvqnD2yJst2Ofr2XpSmzaB749AFygFGp4tuH2ZS520axcUUzxohyA0TJoR5HZ/KMZNUwTVgwDmundKhaor2Y1uxHCxey9FNlRSfxl+tRwbTIBQuXSPuqtsiNCsm2wuqrF97WYkb6fvykxYsfFtFQDer4JXA7A24jX0KfGs9thWrO1zIixxZU6CMol9t+zY5fC18zavb/1RHvPVt/t3iBq28A8lk/+TYJiwXpgU5ibfiAQ4GDmYM/r0y2pUtR94v6PPbBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRHukHERVA6rEhhYy90FqUdBULpYA0cq7qOFfV7gfK4=;
 b=TT+MwENMP0StEKeImvbM069/pEvHmOcttuvJoyLywC52q6Gqr9vWiquUxh/FfKieOADZkLomEhy3754bKEaaFGAw1oi2x5zOKb0sHjzB6dUr4FwRPplDFFK2hC70FpgJPHHZKiFn3nNUMm8PGMvQGcwPu/PxZ1IbUd8GqCq4KB5MZkSm8gRaC7fzu0oj6fe96CjmGZ5GN0n+RfoMMJOfVWDtN+6mVusJ05ajhckGK0L5AY0+ui0tZX59kuOUJw43KcSR2GNqNTNpoLgKUNAvgzDzzmpCtzMHklCpWPAxClwdz3y015Be1uhVZM/MiG5k3bQK6GAiKXuDzXUCcRi+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4277.eurprd04.prod.outlook.com (2603:10a6:209:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 15 Jul
 2021 22:30:59 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 22:30:59 +0000
To:     Dave T <davestechshop@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com>
 <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com>
 <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
Message-ID: <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com>
Date:   Fri, 16 Jul 2021 06:30:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH0PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:510:5::8) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by PH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:510:5::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 22:30:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce159b1-f694-4fc0-fa11-08d947e03880
X-MS-TrafficTypeDiagnostic: AM6PR04MB4277:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4277164B4CD20B6D3F7C9B1AD6129@AM6PR04MB4277.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTYRqAVHNNg8bVvCWwKVgwRcVR0HenwhQL+vqTyoaKPk39ejJjOdh82ZJPd3MVvHC5UAdFOUNwVmtxYTPm/m9JjmS3IexRVQHnqj7gi3g0WGsxc7Og0CXElVTzBdoDQJwzMvJnkiFfAPNmgH2iadYakTJ6Zjghph89PKan6wjJe41jdXWurEe7ooaR2eMgTA9rwCNvfMxUCmOGbPJljxRVTkb2R5sRuesK41UK5N4q981gZVT3PoAEOMXKINdSJs1JHVRFDnehVkGpgRbWw8tLSIXITOK/3JXhV5nv0H7CrV73vMw8tQd+VQrvbavDa7alAdNzuumT4rgEcmwDlxPrs7l9P9LQ4LcEiemOTVeRzWrAwKU0F0AS+gF4GqPgxRJrHdUyF9xQlza3MbuBz5QPZ91bedsBJpD1/GUW2wBSMEfwElBthxPQg1z+HC+rCQuKloKGiqk3P8d9/hrpAnxJ3uc1LdG8vFR79KPEr68H35EZQlTsvHi0Z7irF4DxxH9mz7ZSj9IPsC+52MkVGqMycgj/5ZoDr4Nizo8x/2JWGZqeeD8b2H5JFmEu7NSuEtbFRdAcezU7kwtbjdua6xVBYItj058fyVV0NMmDIxEXEJ0ingrVBBBBwNrYac/2e+tOzHOtNRR1lArOSHh7Ide9ueZ7LFFa1e0zKVErK/yPyUyXgJHyypURIalqn48Zp40iL+ut8mMA+z/HE/d2n4cMbr7T09oq3dVyn5ZkRXqrpxrsYfIyIa4qvWsxQGtTeGtWqXbdipLLCyyeFD+nP9W7oFRLgoiko0V4anjyFsJh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(36756003)(956004)(26005)(6666004)(86362001)(31686004)(8676002)(2906002)(6486002)(16576012)(2616005)(316002)(31696002)(186003)(8936002)(66946007)(6706004)(66476007)(66556008)(478600001)(38100700002)(83380400001)(110136005)(486264002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UJYJed8Q0pZpCO/FcQfeBlmuGoawgXh5ZXR0HDi9D81PkYH2KGhbs764yqUy?=
 =?us-ascii?Q?+aKX+hZlIds3DBQfUHJDvAHSZGoe2U0yt4URJFYOLL6FiQRRqG/U7o9v0X6x?=
 =?us-ascii?Q?wqbdpbysb442KeYKECXARcS0bq0jZ3UONfWVuWQZ0I9v9K0McXLZU781urw/?=
 =?us-ascii?Q?EBeo4VNLDg/7ITlhaJQ4kNXKmEUrwjNir6KvLkPdVwDFLINU+rtRQOoP4sNd?=
 =?us-ascii?Q?EIk7yRl5gpWkUGDpQ/tXzfRz0pB40X4pZCrOvdAROGD1DaKdlAWS8e8UnvlO?=
 =?us-ascii?Q?7lkwmTHFkpjqfroUjUoP+m3o2J5/2r3Gi7w/ODuwRcQK3YPaq1gdAIQl9DQM?=
 =?us-ascii?Q?Y7d+Sqilg3o5rs0CGYB+5C4+2KOZNeFJalb/YAa8/WJzXxA9CuLXjtcxAdf8?=
 =?us-ascii?Q?WxiH/Bhh0+xVD9dJSmi/y1qRqCkg2LhLkLFbuhWjBHdV/jyUsjIFWxy27c+t?=
 =?us-ascii?Q?BOC8nGmfWkb1KWkuVkIc4YvjZ2c2WtaYVwAJ2xIbOe8TQlzSMdLz6rxpfV+z?=
 =?us-ascii?Q?cwTMJc68DhJ1EqXwhs/eFPt6+WlGLManAjBNgjg1DCcSIIegUrFxq85cb9Cp?=
 =?us-ascii?Q?uSqMjr8Pit0E19uwNRLA0X3VaPORoIvwNu7gWW0OsiDesZNgvrheQwNQ6tEq?=
 =?us-ascii?Q?PWk9hB8UrYjoU5Feaee+9r3jXQ40FYzgN79LKv9tSewFLfSGrIUa3HQxYARF?=
 =?us-ascii?Q?HwW+BOBOmPITHeKeit3zH9EAAWfEkMo8az1+zU6VPhRTqsiS9etUKoESAkjM?=
 =?us-ascii?Q?0HpizptEVJhYpH8G6DfV9q+rE3ipqkGXx14yiLKDIKHj3vWOBBV1c4OiQPra?=
 =?us-ascii?Q?uFYW+ED+O8gCi681ULZjGHI45xv40pobWmLk+whb9w6+kJgjUSbFTH+NmbtC?=
 =?us-ascii?Q?QLOnJXYLQ3j7hfCg18VdRcIGg52UtP0tVWlEcxFaeaFJdb6Eo2LYWA471oE4?=
 =?us-ascii?Q?VrL34Rf17J5S/kkDdz3PcYLsc1X4TCbW/PlQU8djCvRL3LQ2i1lq0qaPDAif?=
 =?us-ascii?Q?dfc8SyK/5O2dzwRPnGt4nCnd8zfb/mNnRjY2IOO6iiZTUFXN1qlnFupMSNvs?=
 =?us-ascii?Q?S1QB7pzuan4HF7D+1XAKfdMszwm9mQCcBpSmuirDExCbuscs24QUO45Eq8ee?=
 =?us-ascii?Q?S12c658Ds3k8f21yxhs9d1TOP66zigDgul6b3KlXZV1wSl4ys0fY4rf6B+7j?=
 =?us-ascii?Q?CYDqIC1auqaP0ZntZ0A1DHvdYXoZfNtLSvMUklOYwo/K1PMslXwOagCa7xdh?=
 =?us-ascii?Q?6/ZGz3H4FceLIuL8xqFeTw8Yr59uHMvusfM7zrWlB1IdXcd7MnZuEBwm6TXn?=
 =?us-ascii?Q?Wh/cfrDha5C6RKMrSSa5s+iL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce159b1-f694-4fc0-fa11-08d947e03880
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 22:30:59.7103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehDkfmd03vwi1TfF3J+1iHMJ/niYSBHgy3rPTVn4MR7reFrNHoomqPd7iU4agYMl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4277
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/16 =E4=B8=8A=E5=8D=886:19, Dave T wrote:
>>>>> You may want to run "btrfs check --mode=3Dlowmem" to get a more human
>>>>> readable report.
>>>>>    From that we can get a full view of the problem and give better ad=
vice.
>>>>
>>>> Thank you. I will try to do that after I finish fully setting up the n=
ew SSD.
>>>>
>>> Looking forward to the output.
>=20
> kernel version 5.12.15-arch1-1 (linux@archlinux)
>=20
> # btrfs scrub start -B /
> scrub done for ff2b04eb-088c-4fb0-9ad4-84780d23f821
> Scrub started:    Thu Jul 15 11:44:47 2021
> Status:           finished
> Duration:         0:15:53
> Total to scrub:   310.04GiB
> Rate:             327.54MiB/s
> Error summary:    no errors found
>=20
> # btrfs check --mode=3Dlowmem /dev/mapper/xyz
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/extluks
> UUID: ff2b04eb-088c-4fb0-9ad4-84780d23f821
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> ERROR: root 329 EXTENT_DATA[262 536576] compressed extent must have
> csum, but only 0 bytes have, expect 65536
> ERROR: root 329 EXTENT_DATA[262 536576] is compressed, but inode flag
> doesn't allow it
> ERROR: root 329 EXTENT_DATA[7070 0] compressed extent must have csum,
> but only 0 bytes have, expect 4096
> ERROR: root 329 EXTENT_DATA[7070 0] is compressed, but inode flag
> doesn't allow it
> ERROR: root 329 EXTENT_DATA[7242 0] compressed extent must have csum,
> but only 0 bytes have, expect 28672
> ERROR: root 329 EXTENT_DATA[7242 0] is compressed, but inode flag
> doesn't allow it
> ERROR: root 329 EXTENT_DATA[7246 0] compressed extent must have csum,
> but only 0 bytes have, expect 16384
> ERROR: root 329 EXTENT_DATA[7246 0] is compressed, but inode flag
> doesn't allow it
> ERROR: root 329 EXTENT_DATA[7252 0] compressed extent must have csum,
> but only 0 bytes have, expect 32768
> ERROR: root 329 EXTENT_DATA[7252 0] is compressed, but inode flag
> doesn't allow it
> ERROR: root 329 EXTENT_DATA[7401 0] compressed extent must have csum,
> but only 0 bytes have, expect 12288
> ERROR: root 329 EXTENT_DATA[7401 0] is compressed, but inode flag
> doesn't allow it

OK, lowmem mode indeed did a much better job.

This is a very strange bug.

This means:

- The compressed extent doesn't have csum
   Which shouldn't be possible for recent kernels.

- The compressed extent exists for inode which has NODATASUM flag
   Not possible again for recent kernels.

But IIRC there are old kernels allowing such compression + nodatasum.

I guess that's the reason why you got EIO when reading it.

When we failed to find csum, we just put 0x00 as csum, and then when you=20
read the data, it's definitely going to cause csum mismatch and nothing=20
get read out.

This can be worked around by recent "rescue=3Didatacsums" mount option.

But to me, this really looks like some old fs, with some inodes created=20
by older kernels.

>=20
> and hundreds more errors of this same type... (I guess you don't want
> to see every error line.)
>=20
> ERROR: root 334 EXTENT_DATA[184874 0] compressed extent must have
> csum, but only 0 bytes have, expect 16384
> ERROR: root 334 EXTENT_DATA[184874 0] is compressed, but inode flag
> doesn't allow it
> ERROR: errors found in fs roots
> found 327307210752 bytes used, error(s) found
> total csum bytes: 282325056
> total tree bytes: 5130452992
> total fs tree bytes: 4535648256
> total extent tree bytes: 249790464
> btree space waste bytes: 848096029
> file data blocks allocated: 588119937024
>   referenced 568343642112
>=20
> I'm interested in your thoughts about what might have caused this, and
> how I should repair / fix it. Are any of these options appropriate?
>=20
> -  btrfs rescue chunk-recover /dev/mapper/xyz

Definite no.

Any rescue command should only be used when some developer suggested.

>=20
> -  btrfs check --repair --init-extent-tree /dev/mapper/zyz

No again, this is even more dangerous.

>=20
> - btrfs check --repair --init-csum-tree /dev/mapper/xyz

This may solve the read error, but we will still report the NODATACSUM=20
problem for the compressed extent.

Have you tried to remove the NODATASUM option for those involved inodes?

If it's possible to remove NODATASUM for those inodes, then=20
--init-csum-tree should be able to solve the problem.

Thanks,
Qu

>=20
> Thank you.
>=20


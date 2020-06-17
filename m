Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9711FD3AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFQRnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 13:43:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59662 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbgFQRnq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 13:43:46 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HHdpC3005438;
        Wed, 17 Jun 2020 10:43:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=NijA+FooqFU4uPRPp6uXCJIAndSg3dbG13YEzIV9wNc=;
 b=pmX5a/j4SImR8TWwS9+2oSaJEIRaUm8lco9gN5zUmaGY7G803Cp+XSssiNC5UACORymX
 bhy5sZ/0L0q9boc2s0ClcIr63AhfERDRdx16o7nDWb3o0tCHe9HNrFNQhW0pevxacoPU
 280Tx6cTmQ0tHX1FpDBicuAYnzNwvaEsx80= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q656ecug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Jun 2020 10:43:39 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 10:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms5O2OMiUzGR61cUnQGv1gwPH/xLpmNx2ulH2s+GS1HFrkpGBtVzXJv+QDvV5A/x3QrsICs+IS9HwzpzdWqz9I9ImKM7hzcj3SComx1KsqMCLg4ki0RkZx2OA7Nycwd96pYumQ0PIAolKqnN/b9J51FuPk3kBD5CesKFxsdHiHgQItUDLrw8JxBlkQqupI8PTeGQBfWP1ikcz24YKcjroy6CljcV25iQ8gBGOP8NrwEqR3If6WkHm0VMv5KcUoLJtkYc7rGG04FoheY7Yzboxs25Vyf/00mL1s20tziV58fc/tn4rhhVQ5HC8O4LLFE5od7Zi9t4n6t2qApppjQsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NijA+FooqFU4uPRPp6uXCJIAndSg3dbG13YEzIV9wNc=;
 b=XfMSYjJOMWHpuD6gRlzMj1x3QgPZkS3bWt36LTvVlqR1mfcy/y5coQ+lMT0eUdO6Ig/tfSsZjqc7PiHLXffzSZ+omU3PBQHTO8J8d+t/oGsWCD2np08u3brFlf9056WTbFGGi5kklLGnEARLnw/tOuLp8FHQWAMquAp1yzkjaUb8VbmW8+f3u5o0K+l3RRmxlCrkGwA9WppKYveSdL3B1inQaditJV2I8K0SWMRY9lPyPMoH+5zlBKrb8VXP8WtDcq1kRPMH7kMgGoqQucqy+zEM4gSjE2wuF2xF3yHSFySNnfWf2gJhRj5+cnxNMU3cVbQHFJujwG9UrJUV3Qa6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NijA+FooqFU4uPRPp6uXCJIAndSg3dbG13YEzIV9wNc=;
 b=Iph5eY386OzAfjaOJA1dmjoRDVYYUWW+IPcFi5nXsrpM+7pqJUP3GS4wDj5vcuexEkTM6IE0BrZvF/LiKnArv8YTbgvhBP1HZlWv4XqZFkE7FGv0tWmbyIaCaJPDgWdjw+soZfQwm7plPodHFVpILhb/rTEEjHn007juHc0GkPo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from CH2PR15MB3608.namprd15.prod.outlook.com (2603:10b6:610:12::11)
 by CH2PR15MB3544.namprd15.prod.outlook.com (2603:10b6:610:5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 17 Jun
 2020 17:43:36 +0000
Received: from CH2PR15MB3608.namprd15.prod.outlook.com
 ([fe80::5800:a4ef:d5b3:4dd1]) by CH2PR15MB3608.namprd15.prod.outlook.com
 ([fe80::5800:a4ef:d5b3:4dd1%5]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 17:43:36 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Filipe Manana <fdmanana@gmail.com>
CC:     Boris Burkov <boris@bur.io>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH btrfs/for-next] btrfs: fix fatal extent_buffer readahead
 vs releasepage race
Date:   Wed, 17 Jun 2020 13:43:33 -0400
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <ADB20899-1E88-4546-BEB5-4F2165386184@fb.com>
In-Reply-To: <CAL3q7H47P6E9zn3Zk9C2LX8-1g2QNiCGgbcRMDQDk+JBCoOhzg@mail.gmail.com>
References: <20200617162746.3780660-1-boris@bur.io>
 <CAL3q7H47P6E9zn3Zk9C2LX8-1g2QNiCGgbcRMDQDk+JBCoOhzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:256::26) To CH2PR15MB3608.namprd15.prod.outlook.com
 (2603:10b6:610:12::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.127.60] (2620:10d:c091:480::1:83d) by BL1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:208:256::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.10 via Frontend Transport; Wed, 17 Jun 2020 17:43:35 +0000
X-Mailer: MailMate (1.13.1r5671)
X-Originating-IP: [2620:10d:c091:480::1:83d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f03356cf-bebf-423f-f179-08d812e5f61a
X-MS-TrafficTypeDiagnostic: CH2PR15MB3544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR15MB3544AB7BB220818CD3A193DDD39A0@CH2PR15MB3544.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnvOaE8BtCzIVJi/OodyHHI5ZNqUP7EaekvWCtsgfUYM3kgOlzlJvxI7bXAQvjaUSZuWJP2Ro16VOW9uuk4odVDdUqe8cNGy85Q4sjIQxxNL8pcAgKHqRgpjwFyCeThFx624YSI/DGBGkXrm/NSX6LuZ++OeSNYkhDkLKoKfUbo8ZswCE9Ag7IfkteWaaqnK27FiinVbsa+FJ7o6GB3lBk8FA/8bft7mR/CvXfiqbZ88Fk/l64q3LXIxSYfSI18OZ4Wf65UmDDbA6XWPgHpMilqTc8r2gcEkGhFbhvX9Kz0zfweeb9w+rx65h/GL53WBn280vnXq6dpcBnD2R1yQAaIG2edS0lAyxfRuKNFBMUmnOH1v4GHObgSidJWltEmsRmJtFnhJX75d1GyiQOGQxL2CXbKudnt2201318hSpyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3608.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(8936002)(33656002)(2906002)(66556008)(5660300002)(66476007)(66946007)(36756003)(316002)(4326008)(2616005)(956004)(478600001)(6916009)(8676002)(52116002)(53546011)(86362001)(83380400001)(6486002)(186003)(16526019)(54906003)(78286006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lNj3+miYLJIGcYhKrNFl0wmwAcSQNpLjIo7Kf/AiotArYJBCzbVUsIob3P8FCVQpYn26rkSeVL33f4C5IrRjggOw4h84Ge4HZXhCCdVCXmPmAcBbNfDEJ1wwzTHhipY2Q9zxEyiSIC4vFrJ55FSg9/Nlb3MHHCX70CNt+xg6b6+14l7QleI5ejm74U+iOb5S1qorrPLS1wtmNojBEao8nTYjWt3z//ZvuYeVL/Z64Y6XTF+BYOoqvvlCqoHHcJQiUjrpuVpeaeJgFV9TfOiSpyeQCoaMXLtfNbxkerUxAiWTUjU0FzqP9hkuJW6U/49pYDPZ3ag2XUq5r3/UNMarIQgvIWBNQi5dWGHZSGjkXB7EQl0IMqXlxkWo2x1diBn2xTxstZYQkGfaV/ZmYPF/S1cHBOd2Zs2cRWhultHAHkY0L55vuyKzLc0wJhG67CCpJbaJgUqDKWcjvpjuqolW5BZaW8rQPR9sPyb9bFKAfhZqs3l52RFzyIdXv61p8/a8LN5A9KFZ0CnyceuFOuFVJg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f03356cf-bebf-423f-f179-08d812e5f61a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 17:43:36.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GfsFi9yRna0lwDBOhWZ5jn2dsjgIIQ9udChXzp5VqiZN5wN75Byy/bIFKhtw4OO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3544
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_07:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=997 clxscore=1011 cotscore=-2147483648 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170141
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17 Jun 2020, at 13:20, Filipe Manana wrote:

> On Wed, Jun 17, 2020 at 5:32 PM Boris Burkov <boris@bur.io> wrote:
>
>> ---
>>  fs/btrfs/extent_io.c | 45 
>> ++++++++++++++++++++++++++++----------------
>>  1 file changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index c59e07360083..f6758ebbb6a2 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3927,6 +3927,11 @@ static noinline_for_stack int 
>> write_one_eb(struct extent_buffer *eb,
>>         clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
>>         num_pages = num_extent_pages(eb);
>>         atomic_set(&eb->io_pages, num_pages);
>> +       /*
>> +        * It is possible for releasepage to clear the TREE_REF bit 
>> before we
>> +        * set io_pages. See check_buffer_tree_ref for a more 
>> detailed comment.
>> +        */
>> +       check_buffer_tree_ref(eb);
>
> This is a whole different case from the one described in the
> changelog, as this is in the write path.
> Why do we need this one?

This was Josef’s idea, but I really like the symmetry.  You set 
io_pages, you do the tree_ref dance.  Everyone fiddling with the write 
back bit right now correctly clears writeback after doing the atomic_dec 
on io_pages, but the race is tiny and prone to getting exposed again by 
shifting code around.  Tree ref checks around io_pages are the most 
reliable way to prevent this bug from coming back again later.

-chris

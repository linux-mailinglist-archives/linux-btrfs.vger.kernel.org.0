Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77736251A09
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHYNqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 09:46:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgHYNqT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 09:46:19 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PDiNXn026764;
        Tue, 25 Aug 2020 06:46:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ld+IvAJ6IJtzoH83WAgmW9UCArKM11g6IL7g9M2E9gU=;
 b=agLcLYSw2X1wa2i17XxAFYsGfQHDQ2jMPs9fWev/qU3brexnt5ijqW1cp8Hb7Uu3cK0p
 MOutcmjgtpDUl2KL22Y1ko/kXmsg488mGlU/bkNO/eQIrOtUvgvXP3rIsXZqo1zT/BWY
 +X3f/DOqY1PtlsKB9n3RghxExqQmFw86LuI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 333kmn2ujh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Aug 2020 06:46:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 25 Aug 2020 06:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPlX36kNoaNG//M0vmj4eRDl68UnIfBqun4QybsdpgPJ3YHhX+I61h/vkorl0CTZLZ9fOJrtGZ0PL2MoH46mrjY9CwX3yhk3lTgtCVJpMZKjHdFUkAgezMnc8ZDwGwnan3CbYsUjMQiRwqEi5QoWgIa3GLkRS4xQQdPPTjynJjDS69eXh2mrOohAi48yC2bQ/pYlEidc19RQmDddQzOZITPXInbtfIqVX1cVnv+D00hUpNy87uHH07HFJoUulS3OJHoT/A3JNf16XMBJ7/dp7ZvTkX3Quhn547rl2G1svuX4dHPN/o0VHHMqXlRwXwVNQ1XSju/MErYuFfoUpsSbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld+IvAJ6IJtzoH83WAgmW9UCArKM11g6IL7g9M2E9gU=;
 b=eptz4bxqYTdzymk+6jdI32g2F6gZS5y/+C9JW1PJvG7SVdS3ouYgSSHnCs1d6HHq9+beo9Xr8s5AMjjI+PIbNWB+Tb2XtvzcBip1z8DYU1HNxW2OrXCio+NplzwImW3GkXveb5h3aOU5yukbtUj1rf+GKEIBhy7gcF8chfsl+vQ4HeYik0ch84y5dfEPv2ZL3epAtRncCA+7RXObq/5UcMBbaxMSZfG6hLnQAK4jUUa0GgEsUxOqSuQn7GJkKZeGBjMFM9Fa4LmuY7/5fRTSH6eDWgfGilnTCp3nS3op5pPtzlDfY9Vo1a5FJ+DSQaRStvSRmgvf9sRiIH+NJUf6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld+IvAJ6IJtzoH83WAgmW9UCArKM11g6IL7g9M2E9gU=;
 b=XU5C91GJ6ZunCI8NsAJ5xKrRxaXjahkRibSEcYMK320fg0CWDfjDpW75mtgaoNmy23kTLMZnpi/L23pj7bc09ZNIyT5gYv36qUoy8xnCvjX4i2yrgZa0Th7Zo7TeY/8ddOtgPrebPaWL+Av/eX+K7+s2qkF4M2t4xpiNbK5N63U=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3582.namprd15.prod.outlook.com (2603:10b6:208:1b5::23)
 by BL0PR1501MB2036.namprd15.prod.outlook.com (2603:10b6:207:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 13:46:05 +0000
Received: from MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6]) by MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6%6]) with mapi id 15.20.3305.031; Tue, 25 Aug 2020
 13:46:05 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Nikolay Borisov <nborisov@suse.com>
CC:     Adam Borowski <kilobyte@angband.pl>, <linux-btrfs@vger.kernel.org>
Subject: Re: Link count for directories
Date:   Tue, 25 Aug 2020 09:46:02 -0400
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <A61FAA28-DE0C-42BD-8074-756765C5557E@fb.com>
In-Reply-To: <5062163c-47ff-f811-7b37-e74e1ef47265@suse.com>
References: <trinity-57be0daf-2aa0-4480-a962-7a62e302cfde-1598031619031@3c-app-gmx-bap35>
 <e592fd12-1662-49f3-75bd-94609e660517@suse.com>
 <trinity-963db523-ba60-48b5-997f-59b55ee6b92b-1598305830919@3c-app-gmx-bap63>
 <20200824222306.GA26736@angband.pl>
 <5062163c-47ff-f811-7b37-e74e1ef47265@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::34) To MN2PR15MB3582.namprd15.prod.outlook.com
 (2603:10b6:208:1b5::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:208:1b4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 13:46:04 +0000
X-Mailer: MailMate (1.13.1r5671)
X-Originating-IP: [2604:6000:ab01:b6f0:824:4d11:3f3f:89cd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de428dcd-8671-4924-296c-08d848fd365b
X-MS-TrafficTypeDiagnostic: BL0PR1501MB2036:
X-Microsoft-Antispam-PRVS: <BL0PR1501MB2036E0725706C2E5305C2995D3570@BL0PR1501MB2036.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGIOaw7HJMIG4Hu4m/yRBSdxo2ex+uQD05l9Fvc8mGA56MepK8KL0YQTD9I0GMGaks02PK8PRQRe7LqCvjgyD66HMJB3OLNfXHcPwlgzFmdhvXCQS+WWiNZMa10GlI9UvZnJm4gCreWYimwlOCTz8zvjNFlTcbmWCSiAEvzUhMhU1duTDR8nlvmgnVBEVWzrN2xhHlwJoD2P0dFNr++c3UILIATvQ4OpkHFfUBkPJOeAT4tnwYLvuzuNUWIQh4uH1BHM6T54AVDj4EemIXl4f9cTNM0O3Ui7zAo85vIYVDmD3Qlx1rLG6VItFFk4pcg5Yj5wsaliSIwxSXB8l8a/bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3582.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(366004)(376002)(66946007)(6486002)(2616005)(2906002)(86362001)(53546011)(6916009)(956004)(3480700007)(8676002)(16576012)(186003)(8936002)(52116002)(316002)(33656002)(4326008)(66556008)(478600001)(66476007)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TkC96MFIcoJQ51IBs3XJQ1dmkgIMlmrpx0ja3NOkH5dRec924LFHFPJlkjojhYr2BlHCF9szdIf1ez2iud5JScz5oFrBtAHZiSw/2UdpwAo21giUjATgesLDRI+WBogYx4d5mgynfwRJD6otQeUk934FchuJpgpwRcJFh0un5aAkRDAAU5leT25Tbmc0I2qbv6c/dAL3yF4Kx1O/womN15Vtj3Ic+tkZn1jEVy/y2c8+B5DV3q2WTh+JCxh+ZRev6YZENWx/OYkUu4nPBro4NlNqZfendcZ/AEUzH/ovNzql10CNtWVE4pLkCXWzeguigW7HhfcLR9pDBkHV+a8fqcW/J5Lo1yccGyn/5ejA3obXRQmg/v0rOBh4WMjyCuAS9dYpeeDQptD/D2k4aH3LdkWyE1RUQONUBPP+AlgRFL2DA/PpvSBI7nNwu4AKPgf6C5OH4zvgMzP2BahR6gxKtjWZpSv8YWqNYmCkjaqTkXZDmvanGXQc0sgmmSpiC26Lifcd13+RxT4aRNlJcBCUdm/AQH2cEVucowK8O9W9uF8GQJLGPQphFDCwtQXslPEvz164VVrR8qFSBM/acOX7ZZvhQvLBvFckjBwQkKQY7WZ7jxPee1O/tm8ZFUxysoDw8WTX4E8BuPNFGbR5Fiv0IKYc+EJqmPnkyAtAwOrGdNo7nfMKITJEFGMge63zUYQealzclNOez5PWxwgiho1tuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: de428dcd-8671-4924-296c-08d848fd365b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3582.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 13:46:05.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6k6BfbQmkf83VIxzemD9XQl7xtLpG9nQVebygI0W/cIZD9V8W2KyGv0hRFPERMUc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2036
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_04:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=356 phishscore=0 clxscore=1011 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250104
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25 Aug 2020, at 8:37, Nikolay Borisov wrote:

> On 25.08.20 г. 1:23 ч., Adam Borowski wrote:
>> On Mon, Aug 24, 2020 at 11:50:30PM +0200, Steve Keller wrote:
>>> Nikolay Borisov <nborisov@suse.com> wrote:
>>>> I have implemented it so it's not that big of a deal. However turns 
>>>> out
>>>> it has pretty steep requirements for backport because so far btrfs
>>>> always kept the link count of dirs to 1.
>>
>>>> So how effective is such an optimisation to the software using it ?
>>>
>>> It's not only optimization like in find(1).  As an old and long-time 
>>> Unix
>>> user I'd also like that traditional behavior.  It just feels more 
>>> correct
>>> since if you do mkdir ./a ./b ./c ./d, you will actually see the 4 
>>> links
>>> to the current dir if you do ls -ai a b c d and the two links from . 
>>> itself
>>> and from ..
>>
>> It's just an implementation detail of sysvfs, and a case of
>> bug-compatibility.  The link count of a directory is always 1 as 
>> btrfs,
>> ext4, xfs, etc -- none of them support directory hardlinks, unlike 
>> sysvfs.
>
> Wrong, ext4 and xfs do  maintain the count.

Correct, at least until they hit 65536.  It’s some weird special case 
handling for an optimization I didn’t see applications really using, 
so I just with with a fixed link count of one.  Find certainly paid 
attention, but from an optimization point of view, dtype in directory 
entries is dramatically more helpful.

I’d want to see big wins from applications before adding this into 
btrfs.

-chris

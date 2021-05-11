Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4FB379BD6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 03:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhEKBIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 21:08:47 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:41754 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229980AbhEKBIq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 21:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620695260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SNynS9gezeld+ZFFgTRwM/R7x29vwlv+dNtw0DLwYlM=;
        b=LzrqWZ41jv8v2M52GmDro9x36wGMynnTJg5gPDZZosVIt/qX1jwS/qkspaW2i7xMTfDbSl
        FHxwTQMXjwGNx5odC3U2AKFuDmNU6RM+BGAfu0PlxVb+O7vcBzT9MgRLXJsq9sGg16+AxW
        sZZzy8RZNGCQTrm20r64UOLSFOaEfwk=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2051.outbound.protection.outlook.com [104.47.2.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-36-vfGLF4LgPAyXrpyK0J38Yg-1; Tue, 11 May 2021 03:07:39 +0200
X-MC-Unique: vfGLF4LgPAyXrpyK0J38Yg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7XIHoQWpXmsPIzJgYnsIfVwxGdtjmgCRIkak/S25NY89pcC4KfI34OhD+aKFIjXAO/mCGTOQy5oDLvv4tomNbQxYdfmvz+DVomDB10HchWcB83nz2nYVNWvhq7nx6VuDsWSlPjU24PL0svwArn59uj7vgob2AbqH3RhA3hp0tNSn8g0NhhfoICAG+d05h6t1ZAP+fHsj/ZApPCgf/8IvLr961cbA+HRSBKy3vAxWehJl6Oa0f3m9+BnyNLRl6uxEk4OcRouMkGBKE3p4TeU/IteVt8mXE0Uw3QOvY/Wqar5WQ46sZtBm8SrMv0PnagxTxX5480GYtd2mYNT9hlD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl6BF3rdZGTa1uyhSdOn7ocZ7xIrFtyN0m6QFRDp6hs=;
 b=iJzr8COdT25wL51iI+mx4FSYHlkq71PbQiJnyn5XTgR+Yyzx0f9Aa3CA8OG/3KqUJkdOCYImFgIRKLlogNlDsHx3WFkDm2dfl0MXigve5cgI3L3SsXB0t6HjHgH0L1Vuyt7p/ymKpmMo5StMJwCxZStNd/ydn0Un5FQQ2d7rNjiwFmPcMHCh+kYDUUE7WFmYwx7rhxDnNTyBuUlLIMkL3hJl/FAHGrBwStwNrt02J1NeGtw7EQstcl3HXOrQGU42nnADEZw7KUi5+a9CJ4TgcD6x6xi41qJxYxAQRyHq//QNih+2XUayUmt4td5S1vxro5XpB7DkLSLbZKXfGlRDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0402MB2898.eurprd04.prod.outlook.com (2603:10a6:203:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 01:07:36 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 01:07:35 +0000
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210503020856.93333-1-wqu@suse.com>
 <20210510204141.GE7604@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 0/4] btrfs: make read time repair to be only submitted
 for each corrupted sector
Message-ID: <67f8a098-3e54-da13-129c-7dce08e1d310@suse.com>
Date:   Tue, 11 May 2021 09:07:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210510204141.GE7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0191.namprd05.prod.outlook.com (2603:10b6:a03:330::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.20 via Frontend Transport; Tue, 11 May 2021 01:07:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16ef890f-00d8-4581-4e82-08d9141929ad
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2898:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2898B6AD506E8D5D0D709F26D6539@AM5PR0402MB2898.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4GgBT0YjmJHiiunOkEBF7ItScBi10KYzv55C7Gwa2uXlUbtAOl5OzrbIAOcl8JScg1HwaFGkjxCfL0cSdAER60x5m3OBgQiVLRXVTQOHZPaDj94GrWDF36pCkYUR7T5Rwu83sYSISEU0HeiAHZLBr8ZZyC03QVequuDY6EpFk3Lkx++Kh3BzmN0KMzud7qjbRp50u++pvE9PfArMivzlk4/Gy7tC7hklVWVUswgcqfcd8akcJqbAfQZaiuGVGv4cpSyQYSXH111rm1fT49+FzfnjPsDqn+yVbX1xLzS05P9aVfOLzo03nRri1GFfIGS8KU+wqRfr7ybYUo1EepHETSO30lPB9pws29E6u8Wabe7QWhPgtQHUu5gpFvrZuqF+PMnJeulMgyxLSDzMxDF17/fmP9CdXDjl+ohmgJyLOUqXYi51X1rOpPyHgKvWVxy06r2IIeX85QdAlFVcS9+12jsa45xrsEFRpKUfnKH+OIt+2Bfw5CDhjlq44Sfjf+GLqlL2S72DCRmuxc1rUNL5+tB8TEfiVdaxcnWaQr+1VBCfEOjMbr8TEZBQCKYkYuIPL33CciVv3jOuT8d4M7IfMUk7mEAvV/2hrCFKlPebUhJoToVqAXiIoNNahA6kzs28zyeqTJZML7di5tPvk4dByGIxgYrGWxw3KP9bjD0tt7H0oLvbCjX+KfKf2CWp9J5ogtdTMpZMFvFub5kFwfjEc2yyg20v6cxWJqJyIkzPweRc5ZXIUVWhdHll6QCs/VO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(376002)(39850400004)(136003)(31686004)(66946007)(26005)(16526019)(186003)(66556008)(6486002)(6706004)(16576012)(316002)(2616005)(956004)(83380400001)(31696002)(6666004)(38100700002)(66476007)(2906002)(38350700002)(52116002)(86362001)(478600001)(8936002)(5660300002)(8676002)(36756003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?18MWPEv4jBYA1e2cPT0JqlVufpaZKemUqWazarXCo/hVQcLu0D0XefEScU29?=
 =?us-ascii?Q?SWGnNCNKX6AQRoxWov1Dxu6cSj4Glj7acXGhKa1tuOA1mlPAAMk3qdRcmP3q?=
 =?us-ascii?Q?duLUgMRhik27IumS3+ktMRQHFM5fvJA7VuO6HltPLLhnRWu+98lxmOsaaA1e?=
 =?us-ascii?Q?Kx1qSCHsUkHfukIqcITmDMz0vknqjOV2Z5J9j4dn59GmH4QSr2A5e45Y7hmG?=
 =?us-ascii?Q?FQJ3M260EYuzHYrq8ePnmiQz+yV+1tRUYUmild4v0g54fZoZ0BhXPsuSBLCj?=
 =?us-ascii?Q?4dUudmUrM9rGL6sQ6t2dSW5aD1V5CPdZKZQokss4XQyPvt9SXz3WhTz1bghu?=
 =?us-ascii?Q?PGeDEZKQGCQVyg5SpK72BFRfsz+GxMhncH6C+UdCCqcD8IXoGPIbxNp6lZGJ?=
 =?us-ascii?Q?cOt84iP8uhP/CfPq+itwBqckGd26QlYQsBIonkfb51NPMcXMMJOh/7T8Ufh8?=
 =?us-ascii?Q?qC2tzLeUeDX15vnihjDGU2fQ/QB+tELsVwIwd2BkKREcO2qk1Z2h9QmErLa7?=
 =?us-ascii?Q?q2SroRPE9dd8h6q4hJ47TrRAsigLs58AQdM14WCUHL437g+voBfR1FlCfoSa?=
 =?us-ascii?Q?Ep0BpcjYFfBzjKua1MgQgXKKL74teFTz3VqImFHh8koRPhev3le70Tl7G8Em?=
 =?us-ascii?Q?HI1pjhgOUvfrqKFJu8bLTjBryZxVaJT5OzjoFyXz/WCIf2k1a0waTJn+o6BT?=
 =?us-ascii?Q?tA3Ae9FnyMFOPGmzh1+RMkChHD0sz9vSpj0iobL0KTbdTqdz6oi2Ip7aGET9?=
 =?us-ascii?Q?v2us5CK1BOtw15zeekrVZ0tMFp14hvncW1FSDdqavcxtTI2Qf3JH4YidyHIQ?=
 =?us-ascii?Q?RdI0id1Yvq5hD40QC5MsaERTif1CSq5ZD17xptOmyRqxIicKbAnoSygv4jFK?=
 =?us-ascii?Q?qZdd/VhT6YeqWvBgnTeDM8XBNU4gL4zqcHvrCHZJUhwCxdz1XbjOfqHr81ie?=
 =?us-ascii?Q?/rA7R+9ftbPpswVj4YFjJlb9amiMT86uTT1rtsEu61jMmbZbQfKiePU87Ifu?=
 =?us-ascii?Q?MWd60UiQfzijWHTH8Hjney+QJfTG6beTAagss9AAwAOGSaygWakyHWijCaQY?=
 =?us-ascii?Q?EKR1JKO1IBNx0H+NuzhxwV0e9X7oEiCu/AZQsccqW2Ixo0EfmHDE1PjwxiJi?=
 =?us-ascii?Q?e7S5YfuMfvvJQV4EhQgEyBSjMZJvQhQ1X1PfdGl/RiDBTlCc57yYwcl+U8Wu?=
 =?us-ascii?Q?9kNdBJXoBW5jrKXBqeVHeujcTxmpj9csy71/TZcGE6igMZUTieOHL3mLDedf?=
 =?us-ascii?Q?crwkB2aXQY+GPimDvQcXeYOTyrGLNi0c4fk/mOzttV7S72yM0tF1Q10snzYa?=
 =?us-ascii?Q?vOHAIwO6AdhVBcMVXQ9CRndP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ef890f-00d8-4581-4e82-08d9141929ad
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 01:07:35.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5U+nhNzlehtNz6v4BankKgYgiEZkqfXnZgHhVrX0i5PgIfevMgA6TVvRz/4SAz0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2898
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/11 =E4=B8=8A=E5=8D=884:41, David Sterba wrote:
> On Mon, May 03, 2021 at 10:08:52AM +0800, Qu Wenruo wrote:
>> Btrfs read time repair has to handle two different cases when a corrupti=
on
>> or read failure is hit:
>> - The failed bio contains only one sector
>>    Then it only need to find a good copy
>>
>> - The failed bio contains several sectors
>>    Then it needs to find which sectors really need to be repaired
>>
>> But this different behaviors are not really needed, as we can teach btrf=
s
>> to only submit read repair for each corrupted sector.
>> By this, we only need to handle the one-sector corruption case.
>>
>> This not only makes the code smaller and simpler, but also benefits subp=
age,
>> allow subpage case to use the same infrastructure.
>>
>> For current subpage code, we hacked the read repair code to make full
>> bvec read repair, which has less granularity compared to regular sector
>> size.
>>
>> The code is still based on subpage branch, but can be forward ported to
>> non-subpage code basis with minor conflicts.
>>
>> Changelog:
>> v2:
>> - Split the original patch
>>    Now we have two preparation patches, then the core change.
>>    And finally a cleanup.
>>
>> - Fix the uninitialize @error_bitmap when the bio read fails.
>>
>> v3:
>> - Fix the return value type mismatch in repair_one_sector()
>>    An error happens in v2 patch split, which can lead to hang when
>>    we can't repair the error.
>=20
> Patchset added to for-next. The cleanups and simplifications look good
> to me, thanks.
>=20
I'm afraid there is a bug in the patchset.

If we had a data read for 16 sectors in one page, one sector is bad and=20
can't be repaired, we will under flow subage::readers number.

The cause is there are two call sites calling end_page_read().

One in btrfs_submit_read_repair(), one in end_bio_extent_readpage().
The former one is just calling end_page_read() for the good copy, while=20
the latter one is calling end_page_read() for the full range.

The direct fix is to make btrfs_submit_read_repair() to handle both=20
cases, and skip the call in end_bio_extent_readpage().

So I need to update the patchset to include a proper fix for it.

But on the other hand, I'm also wondering should we use=20
btrfs_subpage::readers as an atomic.
For a more idiot proof way, we can also go 16bit map for reader/writer=20
accounting, by that even we call end_page_read() twice for the same=20
range, it won't cause anything.

Any advice on btrfs_subpage::readers implementation?
Should it be really idiot (me) proof, or just current atomic way to=20
catch more idiots like me?

Thanks,
Qu


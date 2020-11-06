Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A652A9785
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 15:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKFOTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 09:19:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43806 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726939AbgKFOTp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 09:19:45 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A6EHql8004739;
        Fri, 6 Nov 2020 06:19:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 mime-version; s=facebook; bh=UAylOrWD5KY9Xh+lQo0AHKz/n1CXMq6vtBb88v/L8GI=;
 b=YWzTD5JnAt44EuPCH1g+ElTxLrRL6nrmjKGwNDNlO7yJVCp17fLpjwovrypVRXFb0uuM
 i1meQuNlJQPhhrdsUNpOh0O8fUGtz/Ol8T7SKVP7LLCTNI39xp1ivhG0ooVtWXykERYQ
 0db9dALmx6DrmUw7DPuFszMIvRD7luzc1j0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34m5r19uw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 06 Nov 2020 06:19:38 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 06:19:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKKaa6zfWmPNamiD5KBlVaYbni37tte21QW9yXE6+BFzHWXItvzzYDWoxDci+UEMdU2tDsI7KCve4IbdCToVZSoxY1vMgo9C255kz3LJZftaiD+yDK0LkVqzse0QmIv6Kin0LC8uKj/oqkzMFho6zQ0j2PlKS+iduxjwfJ3ICI/FwutCLjFOIyRagjI92q2gsDQLlC9ETApYVFe5DSMTz5IsemWVlo8GmUGHkbJtXjVLOr57rbsAKqk7WFkCPAQ6QGpjIyJuFpXgPLgReF/HyaGzFtVJzjLlmiaii08cKSxvDPH7S+wGgqHP+3cnqRk2WNFQiSkIxkH4SfY71jz2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAylOrWD5KY9Xh+lQo0AHKz/n1CXMq6vtBb88v/L8GI=;
 b=CKkLpX5i4v7O7Uhb+BAW4zFzNHIiee61yMVuxMGshdPp77UoLzNt+N2x7wzxE8cOFzRu1lpkMJ3XyvUBLqbplHvud5WJIPS2GhWuuWlD+Vi+XzUZeZNzcI3qWKvUcIvtuFNPTjSHjS1wNkRbxJFmjp+NWv+c+6pFYZwjOYxjwrMlq3cUbnvODK31U5djN6Dm/S4PtEKcZdx1TyZ7evYnC85Wpp5WdLWeJRMAu7f7Yv8DLYe8qO0Qp6ZO+2TQlrsFmWH9np3DpLfJZWibzHXPN86ot+oX1A/uJUDSOf0D3VJsuwjK68yz6zY40PnFini2sYoV9a50q5SakHkDYaGapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAylOrWD5KY9Xh+lQo0AHKz/n1CXMq6vtBb88v/L8GI=;
 b=YXz6hZ9d9M1Rjk9n1yhEHH4XwGUAhNdG4cGxA3UyQ4lwOfY0QDeiruYvqbgOcj9e+0cpH3S+VcKwatGWng1yrYkFVZAWUezdkk3XAigTgoR3e2tpTS6eH3L1Xy3idnapnMyruTbB54wzKdVJFDt74z6l+NC5cz7mZsLiRrkfspM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14)
 by SN6PR15MB2237.namprd15.prod.outlook.com (2603:10b6:805:24::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 14:19:34 +0000
Received: from SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::988:2e42:b8ca:d347]) by SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::988:2e42:b8ca:d347%9]) with mapi id 15.20.3541.021; Fri, 6 Nov 2020
 14:19:34 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
CC:     <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] fixes for btrfs async discards
Date:   Fri, 06 Nov 2020 09:19:30 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <0616EE84-E624-444B-AF63-7944BF484066@fb.com>
In-Reply-To: <215f6406-fbe2-9eb6-2ac2-7f28b2666789@gmail.com>
References: <cover.1604444952.git.asml.silence@gmail.com>
 <20201105222305.GN6756@twin.jikos.cz>
 <215f6406-fbe2-9eb6-2ac2-7f28b2666789@gmail.com>
Content-Type: text/plain; format=flowed
X-Originating-IP: [172.101.208.204]
X-ClientProxiedBy: CH2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:610:59::25) To SA0PR15MB3839.namprd15.prod.outlook.com
 (2603:10b6:806:83::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.129] (172.101.208.204) by CH2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:59::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Fri, 6 Nov 2020 14:19:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a830fbc-91e4-47a3-96d8-08d8825efc41
X-MS-TrafficTypeDiagnostic: SN6PR15MB2237:
X-Microsoft-Antispam-PRVS: <SN6PR15MB22370D3AF59D5E6946A9D4A2D3ED0@SN6PR15MB2237.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZlJkUoJ6jF0vnVmF2ngGTBFAWTHjpZly/MmV+LRb6B1QP02xjCZZDuoJO1qxwI2GEuVXYQlxoYBz0YOX+KtCRC5trOIyKbe1S2Xps3fvsAvrIvPMa84uh7Inkb/FGe2KVIA532AGIRhRlB2xbslNU03tTJmpLxsZ4svoISRZeCQ4Il4yHUTqB0tgNRN3bpo9jzyX8gLWZ9nJaYy4wdASxLBrfY9xhkIzWKsts1MDgT3EpervBXvpNAtLhYLQcRng122fCBLlXp1X1Ko6NBN7pEuttAeMXO7rPWDYjSeQ+Rx+ZoGzIBX9UINrEB3eFxxC0sonpcs/W42dJPeyrPXkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3839.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(366004)(39860400002)(33656002)(2906002)(316002)(16576012)(4326008)(8936002)(83380400001)(66556008)(36756003)(2616005)(6916009)(53546011)(956004)(478600001)(26005)(86362001)(54906003)(66946007)(5660300002)(186003)(52116002)(16526019)(8676002)(6486002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FWVxcmgYjMreIRxKygtfwQvug+J8IABVwDCrYiHAt6XGtFEV5CIcryIO4QusdR2PF9P9LD1bkRj9vD6T7QVds83n9ZbAwCYqMNa+qtW87ZDMJAOLRLcSURbMwxFTPVP0ihI3KzCBmx9BLTb9vo2rz+GNe17Gj6l2HPh3jl/0rdT6rneKuD2yE98/pvo0oZLVEGcWVo5RZ3jnFhzukzlnpNC4LjuSvIz4iRxtJbcnBlSxCpjl4drfQgUDwei8WWurPPc71S+qRB765QzlnJqudI1je9uuH+eflky9UlFs3iPqSgD3Re7KQiOhchH1mGmXOOqm+3GEgz1wylRg4/7A3HPtTpHc9Htsup2/23lLdJXv5PvQkskxuBoF4dp8M1IBXFORby5TuG4GZwyuzGangtPVaCRtDT01KpyCvy6dUpyxYJdv/yTWt8p2rvInRKXiCfRHUklz8K19+v3bNX9eBvzPbXou9ZIyTwu5ubmSIiKX8g6vYdeMeRrBHKZWHKzgl5p7iDDF+aWt7L2JI41ccYpR4Bm86oDXv9L1LHOPO4uPhnZexrhcu2XpiimXQOcOsTuYWuJmtNMd1OrV9r9J9vHwQn/Fs+OsYcDAWiVmY7tStD+Kbw/3abDHYvSqPo8elJ2BmTnpHBo5/FaNywl71Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a830fbc-91e4-47a3-96d8-08d8825efc41
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3839.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 14:19:34.5171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdS8foxBbgiHKuH4VJTkhsSbJQ4lEmF5kN/8mA4yLgCR44DuIQT9h2TcvH2qRQip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2237
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_04:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=641 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6 Nov 2020, at 8:20, Pavel Begunkov wrote:

> On 05/11/2020 22:23, David Sterba wrote:
>> On Wed, Nov 04, 2020 at 09:45:50AM +0000, Pavel Begunkov wrote:
>>> Several fixes for async discards. The first patch might increase 
>>> discard
>>> rate, drastically in some cases. That may be a suprise for those
>>> assuming that hitting iops_limit is rare and rarther outliers. 
>>> Though,
>>> it still stays in allowed range, so should be fine.
>>
>> I think this highly depends on the workload, if you really need to 
>> issue
>> the discards fast because of the rate of the change in the regular 
>> data.
>> That was the point of the async discard and the knobs, the defaults
>> should be ok for most users and allow adjusting for specific loads.
>
> Chris mentioned that _there are_ problems with faster drives though.
> The problem is that this iops_limit knot just clamps the chosen delay.
> Ultimately, I want to find later a better delay function than
>
> delay = CONSTANT_INTERVAL_MS / nr_extents.
>
> But that will take some thinking.

Yeah, we have drives where latencies increase as the drive fills up.  
Async discard moves the knee on utilization percentage before the 
latencies increase, but without patches like these, we do still have 
garbage collection related stalls.  We still need to measure if the GC 
related stalls turn into discard-saturation stalls, but at least now we 
can try.

-chris

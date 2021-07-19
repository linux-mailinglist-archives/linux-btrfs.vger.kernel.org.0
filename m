Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189FE3CD14E
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 11:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhGSJQ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 05:16:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5418 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231928AbhGSJQ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 05:16:57 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16J9plmj023905;
        Mon, 19 Jul 2021 09:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kvGSxdXCHSgAbCL0cQPAYGrXnTX6fJCe/66Zyik8v2w=;
 b=sZHCx5bYPQS6BnnRHb7qF4j5cMI5NvfYrtXR/fUs31mYH+2EGi+7TGBRbjcbHoK0dEUe
 hezhRK80FxKA0P3QY2XFm1NmzGeftjFdsvN0mjLymdA1k5Es+fOK6tKAx6BiEcAG4BXZ
 5w/rvJX4o4qtPG1Gh7vw857nL7t3wLzrK/bv70ly9LuwDQGMK/yfg/BDfleQ68NLFKJf
 H9St1eWf6UC5x9Y08cYJnpzpY9gduZwLAgEUiGwOoe/IEoU5ZaEFMKiEkKf8X/CzxJNk
 kzzgzNVeRI5+RCjZm04h/doCSiuOi1J1HV2OPM+hB27N3m3ukaoMjGke6FIX/KajtV4n sw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kvGSxdXCHSgAbCL0cQPAYGrXnTX6fJCe/66Zyik8v2w=;
 b=zNNQhznYyxPpsYDnWDFwmdWjOVz9C2d2r1wypgjXqFOvq8WrBsXbj/mVW/H2JOFQ3oCK
 2BDJMdUXDfsR4y9r3qtUsRE6pxJTZCuVMwoV7yxDjgC92O8jfGI2eC1L6SPOOQ1BQd7G
 0LA3Wpuvu0BGVAWfRzUoVuypAkRBHEkB81QZrc6gxCI++Pu2IU4LSRKgxFkcRI9w5TOx
 +piceg07O1nPHM5uTZ6m+MWwq7Ys/gzqvcmfzLUZ1d78irQz/ZDf/VbiJuZBbd5RE3cq
 kg2cCxllP2Ve0/IvBFctyX3jSojgJgxyYE9r0mE7MEm6+/r29mBwrmfzYAjPw1QS9yGk Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39up032p6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 09:57:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16J9uBMt041271;
        Mon, 19 Jul 2021 09:57:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 39v8yscmab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 09:57:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7Q4Vw0hyxmM7kNBFAv2Q5w9K6qFunKsjdbZy+gN3wDjZDJ4JacZlFMoAkEI6HSNj9ls30m4o9U2VJHQF8RRhxhwRmRvjllTIY52y2znduyWAtAU0mizK6FXY1R88LBeA+l6XkgRoBRp55/rdGMNqTTsQYQ3G3OXnSHgLxKHiUs5GtrKOyvJsqCv9oNNoVGL6q1KJCQdaCIvoLiPrhqLs1+ACw3TLYG8t1umxc6TMdUnpzyahgDzsCYEUD3xl7Xx95mATl2py8GUiSOCwsbZ65jUL5oRVgYcqHR75lfEb86gRzR+zLbF6mHVPXRUtJN1uX31t3FFCUPFGtqhYRBJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvGSxdXCHSgAbCL0cQPAYGrXnTX6fJCe/66Zyik8v2w=;
 b=evCKNqqFCMFaKEg3PkIxghSFB5axJ4L0RWFUvrYTgA3AsqNAFGJxG4mAvuOVPqoU7uNNzWR7DQVuqyTdJH/AH2F7wpqZG00mvA+GExGzCysZK+CyCGo/WcSWVCcMuhrhoIltaoHCcG7EB1Ksl9r3+HiFZvtBtIJZ/7tEteYmG/kdNv/n7TxJBiX5iwuOMXBVJgNaOTtmDb6ANZivNE6Ftqv9hAaj1RiTPJWNeCNcjL5tXuXQw1+mVqOoUghToHOCeyq27SJbosuwW3RwJbwPNiCgnsntD9AbxxQSnIj9ttWDJzPqtm5lAoylolTav5/e+HrQ//7pLuXe35FLMgpHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvGSxdXCHSgAbCL0cQPAYGrXnTX6fJCe/66Zyik8v2w=;
 b=yPfDN0So7hQJ4/th/r1BBoIOR2cE33G1NvrFhLCCd83aKX3gRvSzi/PfLm3IHJdg90etU5AUw/0zRosg68wgVXlTuibliSUdtgTQLNYdb5r9cSvUupFOKqfcrZUJxigcgowG/QgX1jD3AoGG1wH7x5dFtW2kO8aOlL1V2BPsfuc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2931.namprd10.prod.outlook.com (2603:10b6:208:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 09:57:30 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 09:57:30 +0000
Subject: Re: [PATCH 2/2] btrfs-progs: fsck-test: add test case where one dir
 has two links
To:     Qu Wenruo <wqu@suse.com>
References: <20210718125449.311815-1-wqu@suse.com>
 <20210718125449.311815-2-wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f32b89d5-a7f1-dfa4-d706-2eb96d98a004@oracle.com>
Date:   Mon, 19 Jul 2021 17:57:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210718125449.311815-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR04CA0189.apcprd04.prod.outlook.com (2603:1096:4:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 09:57:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee25f720-42d2-4dcf-a4b8-08d94a9b9f0b
X-MS-TrafficTypeDiagnostic: BL0PR10MB2931:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2931DB51C10F123CC1320A3BE5E19@BL0PR10MB2931.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEzs6BoSKL8GxgJ+1k75KlG6ZSOHHGvYqH9rGx5OWGU3JbboIpci0FUIXZTqsGc+zm/EgugB/403Edx3aKsK822TAf57HF24k+BHy4s+zdptgb7I7oHVWtk33O8clcBwOnUT1gYI8HcCdly4TKz1WK5592kVlKpPi94KB16e/gy9QKlo7Pxtz7XSbUyJ8GAe2qYEa2xZcsJCxbezcZ7STgRYZSLZ0ijmxfXHp1bjdE2N3BxykvtwctsThZ+m6A2MyXIkonq/ldr1SQtPQwFE9b/P82kJc+J9PQpcJXZn4E6uHP5/QcnYv9cg8jRm6krFlctL0l4H0zp+4i/CZHLxvnFi1CAiJnmPKKKK902tBHEtbEUeG9+exjQ8mCMzEmuRW4SavgOFGL8nCqeO5PJHYtlsUf6yp2Ms5Bd426KEvfOeSgiLm3Aa2qb2eVkpj8uiII5KHiJsx/VTxRZjStYa49mrCWIl3cANkEhZXHzdayeIh1zBCD6D1gaWO+bpa0H1LF2XTagwVknJC8g8le2U7jwdoCJezgKBdgN4uYeizq9Ht6RVzIoX5xiRKtiyfXSYr1KYQBQjPDpNTxGlkc9TfqeNj7mFKVV5vW8pfAQHTAriZ7X5guRn0egH7biKoImYhWI70qKOYqC2RrSyuXyctMUQ0jEYYomY5LPLue0FYERDfEljhNqiRNSB5xBF0+yA+TPyqr+B4L5HGp+Xq0tPhFMy/WjcEtwR7+dvyZMOxGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39860400002)(376002)(136003)(86362001)(83380400001)(31696002)(66556008)(66946007)(31686004)(36756003)(478600001)(8936002)(8676002)(44832011)(6486002)(16576012)(2616005)(956004)(316002)(66476007)(53546011)(2906002)(38100700002)(6666004)(4326008)(5660300002)(6916009)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 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
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee25f720-42d2-4dcf-a4b8-08d94a9b9f0b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 09:57:30.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yDoaiD+GC85B5nPANZ3QNt0mITdjZny6kkl91SCvx7VDTn2ANUG52OM0TCymr+rnEr/eBrfrHKd11dnS0WXSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2931
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107190056
X-Proofpoint-GUID: eY-Fv81jHxM5Vw5XClQLea3B_MlkZXTa
X-Proofpoint-ORIG-GUID: eY-Fv81jHxM5Vw5XClQLea3B_MlkZXTa
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/07/2021 20:54, Qu Wenruo wrote:
> Make sure btrfs check can detect such problem.
> 
> Right now we have no way to fix it yet.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>


Test case runs fine. Do you use any tool to create the crafted image?

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   .../049-dir-hard-link/default.img.xz          | Bin 0 -> 1712 bytes
>   tests/fsck-tests/049-dir-hard-link/test.sh    |  19 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
>   create mode 100644 tests/fsck-tests/049-dir-hard-link/default.img.xz
>   create mode 100755 tests/fsck-tests/049-dir-hard-link/test.sh
> 
> diff --git a/tests/fsck-tests/049-dir-hard-link/default.img.xz b/tests/fsck-tests/049-dir-hard-link/default.img.xz
> new file mode 100644
> index 0000000000000000000000000000000000000000..fd9971acae78975f5263da022feea39e34b45139
> GIT binary patch
> literal 1712
> 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
> G1X)_MbXXt&
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/fsck-tests/049-dir-hard-link/test.sh b/tests/fsck-tests/049-dir-hard-link/test.sh
> new file mode 100755
> index 000000000000..992ad638bd47
> --- /dev/null
> +++ b/tests/fsck-tests/049-dir-hard-link/test.sh
> @@ -0,0 +1,19 @@
> +#!/bin/bash
> +#
> +# Verify that check can detect overlapped dir with 2 links
> +#
> +# There is a report that btrfs-check doesn't report dir with 2 links as
> +# error, and only get caught by tree-checker.
> +#
> +# Make sure btrfs check can at least detect such error
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq btrfs
> +
> +check_image() {
> +	run_mustfail "dir with 2 links not detected" \
> +		"$TOP/btrfs" check "$1"
> +}
> +
> +check_all_images
> 


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF68439B919
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 14:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFDMhs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 08:37:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDMhr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 08:37:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154CXxGs182075;
        Fri, 4 Jun 2021 12:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PGUag1RrfL+y2KbQ8d+6Y2FjWeRtIZ2a0SohVRoR/W4=;
 b=vfBppnW4SqjpLj/OC6me9AYW46Tqa/L/TLYJ0/2UpK023pUtERCe+wT/Kx8a9xOt7JP9
 lVv8DCt2Hyz2ZQm5RZh2RjSvHD9aBzcSexlx1Dt8lLgzMG8IDsmKq9GH2wPYMXiI9WMN
 wrwNiPPzVaSVC73Q5LfTGl7uojusGg3QObzfuFyg3oxnI3zhTiiX97MHnBN11aORoNfp
 yelNx9P3DBN5R+JpMIIwR+yxcnp87TMlbFOHSoGdrUAAZdIjMBnjKQQvfXXfuY8q2xq+
 0g5Wt0W4ICnav11aluXUpgfiW9dLPYFKUYRUin5rtdzjJAzFOf1sYpm2Irdbc5OugOVn jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 38ue8pnu4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 12:35:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154CUiiY071931;
        Fri, 4 Jun 2021 12:35:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3030.oracle.com with ESMTP id 38ubnfpe7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 12:35:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3jv/GBlwCqoLYNd3KFrFElPtl47Thg9OnNaboJN080THwE4VEqtnuN78XgsWoPNHG9Ap1KLXO54p6sOtYJKCDeE19C7/I+taawt1/fIsvDYqdBvhGrFyTYo1ied9E6PwM0/a1bg7C1Z6RU54rjfS2vrKUQrLnZLItcYVjxNYF/oqY1PTB1V8TJmXlGbiazWpni5X3Tj+8ptre49E015xo81mJJiIWPmi4VencVTDfPwArHAy3WYtY6uX9CGu6wH0d4LFoO67dWh6cCkQjVW9HtnmHes7uw6E2cSg9Nr7DVA7EQQiVdPAqx8ZuSZdW+3g+DfSszTquQmN9fuEagvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGUag1RrfL+y2KbQ8d+6Y2FjWeRtIZ2a0SohVRoR/W4=;
 b=TaVHQ3tsB7i4VNzh+ZM5qqEAPHmUB7Jid9bba2OfnfWPcQ78+wPRFOXtOHhBqv6uLCfITGTltqH0jyfpbHXPr3RQBE2Fa2cGt91OTen3D6j5HTUlc8n3euik4He+pLRTn7Bpn4G38gQjCZVUeAAS01ERu334f+xZ4/jYkBYn/uXoY+lkQr32qzqfRJQauEBCUjeRVxd7ZsQys+qh0VVR4sUasrQ4Wd7IQ9NYxVt+RJMFu+XRC0CssnCT8Pl6Km3p8Bu8YcN0ao1r+TVWdUUIPWanaJHvOtd/pwuIMXNmVKRq4uylQqZr1Nd4yoS3HH5uBAf4yzcIXPPBnQ7ondWLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGUag1RrfL+y2KbQ8d+6Y2FjWeRtIZ2a0SohVRoR/W4=;
 b=ZjE4nQXiIUYI1H2QjapUYzsyUjSsvUeBkpU+gj6kIut3hmc27TPn3schyUlrl5QcmKMgNH0+yMI/lVT/nykSbUXtB6eNkl9i2EgWRQvaTRXYgwDEDCN7x15gwQUeXEy6Bc14/BjtFjA+6D0bAe8zm9q2SiNVKEWvy9jlSoFgUsM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 12:35:54 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 12:35:54 +0000
Subject: Re: [PATCH 1/4] btrfs: sink wait_for_unblock parameter to async
 commit
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1622733245.git.dsterba@suse.com>
 <c3c791a112de00b3d915184da8cce7b634570b2a.1622733245.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b74f45ea-7f5a-04ec-fc41-257fe20e4ca0@oracle.com>
Date:   Fri, 4 Jun 2021 20:35:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <c3c791a112de00b3d915184da8cce7b634570b2a.1622733245.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR02CA0087.apcprd02.prod.outlook.com (2603:1096:4:90::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 12:35:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a40d1dcf-4853-4d36-c824-08d927554ba8
X-MS-TrafficTypeDiagnostic: BLAPR10MB5025:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5025FEDD78BBAE16348E9BDCE53B9@BLAPR10MB5025.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgHQbQKClEx58L10nx0zuEJ4UkdTcIa+k/nut+ea8mL0N9dWxLAXJaGCbZZWiPfZnbNNtjn5RwZULZanrYQYifM+NK0BYiTfD0dkNfzWCDrkgl3HI6+yUVjVWa1/wYtykszvot3oH0uACC2mUnJS6e6gVvXFF0TcG5nrKiYCAx3XuF7wYWhzVIvasNI7JDi4klCb0B9Pnvku8BFnXkE2W2uECFS2x9MU3bXXQOnS93X5kQAYKxRU/cOFX5kj/K+kSVA2CHhL2+mGdYnKWWN6EVllTO2PWV6EzZJmL30HDejLtFY67kUvkBafql1Z6smJWT/U6tf8z3q9+YGSE1lL92QkojpHleTS051HazxidWV8vWsWh/OZUQCb9kDmOdWxvCaNsOEjEWOE1ggI6ASTUMpBqc4TN0+spg/mNd+rXYcy5U0SH1jegDTowhZtlzDBvzl1atykeGllvA0VHj0PEvVVtBDHw2ybA8kGUg4JT2PPcXtyFlEolfssWbaPFj+gv8HEzAF1nOJSotjXVAnCpK+LbtzjUM8lDEwKah5X8FC3EE+1PMYooUbpOXsnD0rsdVUD1ArxYpNAGbNH7gbucXvmgDviDiSnhW0JJd9uq+JkKk3EKqblkeyfxL5+X63rLvs6z/QAxxRmQRTnpVe0YSfqphmjs1EtYOWpwNw6E/J/33vESmoAv6bA/MaFSjoU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39860400002)(376002)(26005)(83380400001)(16576012)(316002)(44832011)(38100700002)(86362001)(6666004)(53546011)(66476007)(186003)(16526019)(66556008)(956004)(5660300002)(2616005)(31686004)(31696002)(66946007)(8936002)(6486002)(8676002)(2906002)(36756003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZHJFMEUxdHVNckxwU0Y4bGR2NFpHSS91b3dEUFJIdTJ2ZHBWMUlBaXRWTGRF?=
 =?utf-8?B?aHRaeFYwYUpFcWoxYzZUR3B6WWhlR2tzN0RCZzFUMXRoMzRKOXJuRlhRZnV3?=
 =?utf-8?B?Qm5lTU5GVFVEVFFiMEU4YmpxWFBiV0JSVW1ENFVHMmw5aXFaVElXL2VZSjEv?=
 =?utf-8?B?R21uNHFoM3RhTytkVytSMEZBS08xU1M4ODk4OUxZTDNGd1NFQytyY0k3NUF5?=
 =?utf-8?B?bXZrcmJ2Zys1N3BmOCtmS090NjFHMko5alpUTlFYOVNVK29oYlN2MEJadWs1?=
 =?utf-8?B?NUFYSDZuMXpGMWxoN3ZmR21PQks4Z2hzSnhQdU81aDByQktZVUQyVnVmY1lR?=
 =?utf-8?B?cURaanRCdWhiS29sclYxOTNENGN5ODEyK0ZiRGxJK0hRaTVFSnNBQy9ObGN0?=
 =?utf-8?B?enB0ZVlad2R3bjhFZmx2TTVVc3VQLzZHWnA3aDVQTllSSFZVU0xNT2ZrZ1h2?=
 =?utf-8?B?WDcyRzFFc2Z0RnVmNmlpTGlpTHlwZ2hiWGZiMjUwQzQ3T3pUMWY0a1BGakty?=
 =?utf-8?B?TUVteTN0NzBnNENGQmR5TzhrY0E4ZWxxM1JDWms3YmNIU0FPV1pTVThzNkpx?=
 =?utf-8?B?QVJ0TUNxWlA2YUpmN2Q2bTVMS3VZV2VUMnZPT3dKTVdRU1ZoZGdFRS9UU0pM?=
 =?utf-8?B?NzI4dnVObVU2RHZJOGMwRSsvb2thR1h3M0d2TUs5Q0RkUzVNYk1mTkNiQ2lD?=
 =?utf-8?B?WmlpS0ZjemNTQkIwMnIycDZaS2kraU1QaElTanFoUi9OeUR1NlRmVzFDZWIz?=
 =?utf-8?B?WjczOTJnZytyOTJyR2o3dGlUM2RhMllTbHBwa1YzSWhOWFlyNDFGaUVlTytj?=
 =?utf-8?B?UllZSng3WWo1cXNYK2VTaWJYelJkOVIrTHVGSWIxN0VXNVdUblpGL2NNRnNs?=
 =?utf-8?B?K2FxU1hNRDgxYTBEY2t0ckdSOU5zZHVqcEJwWm5CSFdNOG8zaWFzN2xwUk4x?=
 =?utf-8?B?eFF6T3NLc1R1NG9tVXRtNXEyQnU3M29BUUlXSlFYT3MreUVSM3FHL1ptbXhp?=
 =?utf-8?B?MmpFOG1OMXdiWml4TXVoVEdmOW14ME5iUXdtUjNXSjVmQmxhTnQxcnJCK1Jz?=
 =?utf-8?B?VU1pdVBJRHFPeDRRdDNvd2JwRFFSUzEwZ0FNZkJ4WmRqOEpJbTZTUUZKSTBM?=
 =?utf-8?B?ZzhDbDdWaWU4SFdydEd4TVFxVWovYUpQc1cwTTB3ejBVTTZ6RE9jYkMrWFRC?=
 =?utf-8?B?TjI5QktsOHh1VzRuUm0rY3RnMzg2YTdUNGlBS2xoK2FFYmlabXp5V2NGSXVS?=
 =?utf-8?B?VzRSRzJLV2EyTFFOQ3h0MVI4b1pvUXRhN21tRy9PWDNUV3lnU1czVWVqaXQr?=
 =?utf-8?B?MklnbGpzZGpzL0ZrVGc0KzNheEhKS1Z2WU9MQlZFQldScXltWG1RNmJTWUd0?=
 =?utf-8?B?ODl0QXd0SXpiT0xyanNsWmtPalBIMFdMWE1oaEhUeDVMdGdXb3hWaThYOHlx?=
 =?utf-8?B?RHAyeWNnVVlJbGRGY3pXbU01cW1PUlhyZjV4dHVHVjNtL3ArTHQ5bis2Mnlu?=
 =?utf-8?B?eGZLTlFZNFBtTnVuQjF3TGQwelhrU0wyMExWUUpjM004L2xvT2tKaGRQMzZH?=
 =?utf-8?B?bGZFMmloeFRMV1IyUWhnRmFuMkVTbE9xejhCZGNtRnJnTytkUUhNN0ZObURu?=
 =?utf-8?B?bDdoWHM4Wm5FQ20zYitxUzBiVGR3OWNYckhBc0g2RnAwS3ZyaHJHREREakJS?=
 =?utf-8?B?dExBb1JaRE1Kai9teWRXU1M3YWQzeURCbEpTbnF5YWZnVUJCSi8rR0c5dlU2?=
 =?utf-8?Q?J8qygL4Ki13j4a3D5dcogGKvnSofv4DGeqanKIr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40d1dcf-4853-4d36-c824-08d927554ba8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 12:35:54.7459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFL6lmrcdFH1qaC6Se81HBj7I71a2+p0qsLD8K5OhaIqZlCctLE2IvTosADcMmusfI5hC0AUnJlzyBV7hUBCxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040098
X-Proofpoint-GUID: 3x4IeK6R236zpGUhADzzKq-GfOx0QkGk
X-Proofpoint-ORIG-GUID: 3x4IeK6R236zpGUhADzzKq-GfOx0QkGk
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040099
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/6/21 11:20 pm, David Sterba wrote:
> There's only one caller left btrfs_ioctl_start_sync that passes 0, so we
> can remove the switch in btrfs_commit_transaction_async.
> 
> A cleanup 9babda9f33fd ("btrfs: Remove async_transid from
> btrfs_mksubvol/create_subvol/create_snapshot") removed calls that passed
> 1, so this is a followup.
> 
> As this removes last call of wait_current_trans_commit_start_and_unblock,
> remove the function as well.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/ioctl.c       |  2 +-
>   fs/btrfs/transaction.c | 24 ++----------------------
>   fs/btrfs/transaction.h |  3 +--
>   3 files changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 2bdaf2018197..f83eb4a225cc 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3643,7 +3643,7 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
>   		goto out;
>   	}
>   	transid = trans->transid;
> -	ret = btrfs_commit_transaction_async(trans, 0);
> +	ret = btrfs_commit_transaction_async(trans);
>   	if (ret) {
>   		btrfs_end_transaction(trans);
>   		return ret;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 22951621363f..30347e660027 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1882,19 +1882,6 @@ static void wait_current_trans_commit_start(struct btrfs_fs_info *fs_info,
>   		   TRANS_ABORTED(trans));
>   }
>   
> -/*
> - * wait for the current transaction to start and then become unblocked.
> - * caller holds ref.
> - */
> -static void wait_current_trans_commit_start_and_unblock(
> -					struct btrfs_fs_info *fs_info,
> -					struct btrfs_transaction *trans)
> -{
> -	wait_event(fs_info->transaction_wait,
> -		   trans->state >= TRANS_STATE_UNBLOCKED ||
> -		   TRANS_ABORTED(trans));
> -}
> -
>   /*
>    * commit transactions asynchronously. once btrfs_commit_transaction_async
>    * returns, any subsequent transaction will not be allowed to join.
> @@ -1922,8 +1909,7 @@ static void do_async_commit(struct work_struct *work)
>   	kfree(ac);
>   }
>   
> -int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
> -				   int wait_for_unblock)
> +int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
>   {
>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>   	struct btrfs_async_commit *ac;
> @@ -1955,13 +1941,7 @@ int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
>   		__sb_writers_release(fs_info->sb, SB_FREEZE_FS);
>   
>   	schedule_work(&ac->work);
> -
> -	/* wait for transaction to start and unblock */
> -	if (wait_for_unblock)
> -		wait_current_trans_commit_start_and_unblock(fs_info, cur_trans);
> -	else
> -		wait_current_trans_commit_start(fs_info, cur_trans);
> -
> +	wait_current_trans_commit_start(fs_info, cur_trans);
>   	if (current->journal_info == trans)
>   		current->journal_info = NULL;
>   
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index c49e2266b28b..0702e8d9b30e 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -226,8 +226,7 @@ void btrfs_add_dead_root(struct btrfs_root *root);
>   int btrfs_defrag_root(struct btrfs_root *root);
>   int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
>   int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
> -int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
> -				   int wait_for_unblock);
> +int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
>   int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans);
>   bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans);
>   void btrfs_throttle(struct btrfs_fs_info *fs_info);
> 


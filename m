Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7490F382774
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhEQItX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 04:49:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46566 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhEQItW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 04:49:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14H8j4Vn012823;
        Mon, 17 May 2021 08:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=B/FbHxeqQ1Y6hrQfSVdpaqUQenRDxsGaDzdtQ2iLdMc=;
 b=amIyzrR1sfHaMBH3L+cR02+EAfwxnTiWUVYTzQ7wTDrV+faIIYTbL6NShTs4AkiApMm3
 gHqkcwMBwWs2ohJ99sLlvU7KPEl4e9cZY63Aj+6a2Ey5pgpAuxvjMJzyl2ccUQoGutkT
 T6qNfIlQgzfCD/TW32OHxZgHvHAnoc8BTLVl9J+mNAqbMxhypaVbAxbbwNf7X0H0foXI
 flXs4GVGzaBro5KGvgjVLbtaROBlTwx3svJg4JkrYaRstwDdjySKGyM/PR/Fj/mY7W8l
 w2MIzmhkOVzcR33V8C0DL+GKmpFVJubLaBp0qz/2+VliHQaaWHGnzRG738Ir6NiLL2nu QA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38j5qr2hc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 08:48:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14H8kJox001055;
        Mon, 17 May 2021 08:48:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3020.oracle.com with ESMTP id 38kb36nrk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 08:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q63dgmq1m8QxpCm82HWrM3K9gaw1tubSu9JWbDe5gDmPyvqXzkjzFCNP2EPu+KwZxW9iG+S6iWJCB4ykSSZGIWuL7/ijgiKpup6pNR4TeY4HttpNnMfG0tlQmzBWjJDtWKZtuAC9Mty0kfYfqmpn744Kw6rkouu2FdwyDLQShiWjujnZXeczfWJiowM4peqAxNowqQFGtJFTdZ6FosPTIT5pTuaNncR0mMhCpZfVBYZo7DjBin4Uv/WsyMOjJm3WrvrqYuVhaRq9xyyizJxVZ1zIqMQWRQ4CCtM2yNs2+Uq40cmiLPBjTBn+1Z1h1Aswt2uWB0R2y9qlvzj4MgVerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/FbHxeqQ1Y6hrQfSVdpaqUQenRDxsGaDzdtQ2iLdMc=;
 b=E0AyJIsRkcj1cLiP0fUzE43WsEOiwqziifqAiWY4+v/8AMZhklLZWvJD9VIcBxSTd/wULm1atxQ5pxaNMKE4IehBMOd1/NLja2inawRV3kO3Ma9Wvj/YrF1sNB38f+qzF5fqyUYv6M7nqQ0WMg+DsoFcOG+8vUs8+tj2l5jzvvIzQr9NGs/lYddWVly6qU7fj7efhR2nOkHRNIGNfuQ2PtXeLkQU6Jhc1NiieJ+lRl7lkqe9bYrBeCGfbIRQLOw3EJ+45WqJnT6e0jd2XzPM3rrEwRFuCja2QToUO4/Yge0brZR9cw9shpKeNXOBj0k8nOdLfzrCIYDrnXhlQyNunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/FbHxeqQ1Y6hrQfSVdpaqUQenRDxsGaDzdtQ2iLdMc=;
 b=jXz1YI6H7x4uINVBmbigLJQ/U7PCsHhS3zOcsgyROvbNhLLpJ/E0O1imx9leszqKr+0SftlPG5ESc7Y+AxVBknQCS7AoM7RI35wzVwqsnY3swFtvpAC+6ePVdnbmzDVuwuGKkIOeK8jl9/FrW4I//cdsv7uUSgStzCAlnoUF1cw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3966.namprd10.prod.outlook.com (2603:10b6:208:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 08:48:00 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 08:48:00 +0000
Subject: Re: [PATCH v2] btrfs-progs: fix inspect-internal --help incomplete
 sentence
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <d9905452906eea5e8ac5b569e92df3c48861d734.1616136002.git.anand.jain@oracle.com>
 <0e95dbad99f21a00f5a3b7704196e5bde47bc8db.1616137734.git.anand.jain@oracle.com>
Message-ID: <4123ff39-962a-c5e7-d0f0-9f85e513fe20@oracle.com>
Date:   Mon, 17 May 2021 16:47:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <0e95dbad99f21a00f5a3b7704196e5bde47bc8db.1616137734.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:19d9:791a:8f5b:af4f]
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:19d9:791a:8f5b:af4f] (2406:3003:2006:2288:19d9:791a:8f5b:af4f) by SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.7 via Frontend Transport; Mon, 17 May 2021 08:47:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a9f0ace-5c1c-4a4e-7dfb-08d9191079c0
X-MS-TrafficTypeDiagnostic: MN2PR10MB3966:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3966A996FA9A62420DB9BB61E52D9@MN2PR10MB3966.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMiy73Zjlcqt1xJRhM0k/yR5cDulZug19h39EJVKrh6TuiLXOsfOSG4HpVwcSxvhFmTRrkOUN0djE1+Cgg+k82dI1icokqL93TUx9jLTKty36rmHGswGDzAW8F/m+Ow5ZGxpC2sSovDZ0mxxEvX4QmvnynySKxnAMRGNfUdR99LkkjlXHkUp15XmAZJRsnUl3CjLVSGoSz2JqrfQk9dC1DOuq7TN1P911tNfsROsUkUETGkCvWpRu/3KUpmegS4KKuYT1kG352/w4Z63Ktq765iyaiMYeND57kSMKluynrhzAYvaCtKXuJc/DFxG0qLw0730059eiZr8p+OGrj6CRsn8v8WH6Zo4Jvxaugr+UQ5RDI7CWkbX4nWMS3HETs1JRQf/sk5QkwFfIxXndWyGvoU58nEtBWG8mVPYV3hsWn9b63kPHw9TY3/qt/h+3AhFFJQT+99KW7ukkpoNwbV8ojgSIV5F4qyWtU/1Jik3oeQpXjI1Gc37Dm+s/yM7KaGMOxlggmqh0OOM1a64AHzgdD77lPt4kKMGtq3dovFenwHInAmKYG/n4V0Ub49gODjXqG+4Al5J7tnTiVs4UiN4wP6SLWSv3/vRijME9ZctVX2O+ugDbRry6Q/UWCApCN88q8UnHCaUQNHt7WKEl0HjEXulHN4aSLghgM0B1kN5yPIjlpEumPhyxXIYEXOgd1BX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(366004)(136003)(31686004)(86362001)(83380400001)(4326008)(31696002)(38100700002)(8676002)(8936002)(44832011)(6666004)(478600001)(2616005)(6916009)(66556008)(66476007)(66946007)(2906002)(6486002)(316002)(16526019)(53546011)(186003)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N2U5L09pb2pHWEJCL0lqZ3NDNWoxMDlNY2gzMjRnOHViSmpNcnIxMkZIM05O?=
 =?utf-8?B?YUxmODk2NVh3QkhDR3JMK0RwcEY5QWMwSXRnQmdWWjAwMklHcmZWNTBqU2tT?=
 =?utf-8?B?WHBxUFZUZTgvSGlDVUp1WHNnbnRsY05hcmR0QmZVbkV0bU05WUlKK1FmWGVz?=
 =?utf-8?B?L2NUTGppRDZmRVplcXkzcjMyNzFVVkxBK3VYSlVKWW9zUUlCUC96dUU0ZnBs?=
 =?utf-8?B?RVBpS1hWcDlRKzFhYnh0cjdyanArZ2c1cUJSRTdKRHhvQm9naE1HM2Q2TlJN?=
 =?utf-8?B?ZFF5TmE1Ymo0Z0ZqMlAyRWlxRTZQSWVteEMxd2RaWmpGdGdUcTRUMG9zeE9I?=
 =?utf-8?B?eTFWc3QzRGNFVUlzVUkyUUFyalYwLzBaNkV5ZjFkSTN3WWlxQnB6WEFKSlIr?=
 =?utf-8?B?eXM4cFFHYWpKYUUxQUV4WDBlMWlDMnBkbmRoWktIYUlQb29jZ3NhcEJSVzRX?=
 =?utf-8?B?MWxLUTVZb3ZPeUwwOGFPOVhxT0lXMHZrWnRYc3dVbEVWbk5uUURGUHhwM3RC?=
 =?utf-8?B?ODRQQkt1eWV0Y3crREoyaHhQSWFNWmtLb1g0aHZTbEdGUHdVN2xYMGdwakFh?=
 =?utf-8?B?NHVKNzZEUXk3WHRqRkt5bGIxQkNUQWNEOWs5VlVFZUVJNDhXK1BHMnJxZWFt?=
 =?utf-8?B?a0Q0U3B1VzBKOFFnbG5BaW9BdmRvK1RLZnVqanFBMmk0UGtvc1pXT3k1NGFI?=
 =?utf-8?B?NVNVemM4WU5kUFhENU11NHZyMTNUN3V5RVFuS1hWamZUQmc4OUo2b1Btd2pH?=
 =?utf-8?B?aU80WkMvdkQ3YWI4bGxmY0U2RmFOdkd4WTlkZW1ST1g0cnpEY0UzZnJleFBL?=
 =?utf-8?B?cmpvQzhuZ0tpSUtvTnJvb3FiUUJjMGc0YWlqalh2R1l1WEpSQ25nQnV1TDFI?=
 =?utf-8?B?Y1dJVmwvSE9IMUo1bWhKWnZQZXF0VVY4WXRxMm1Zdkl1S2p1Zkxwdlc0Titk?=
 =?utf-8?B?ZXlqcVpJYTJRM0xJaXhPbGJQdE5Ob0JWZHNRRmhiemVzR2dLSEIvTWEydWFM?=
 =?utf-8?B?ZE95WlNRckZpVFg5WEF2NElOc0dRWnZPWGlIU3YzZGJqK0RiYjRjL0Uxdkhr?=
 =?utf-8?B?amZzb2tmeXY2ZTM1RTAxYWJBb0VndUFNOUVnVWJ0SDFlV3F6ekdNZjJMYmhl?=
 =?utf-8?B?aWE5WDUybUxzRlRYN1VtWFAraG9peVIrc3o1TElUc2ZSbEt5NXc3dmlYUWps?=
 =?utf-8?B?bHhMU2tYMThmWVVPWHhmMGxJdGxRdmNpbGJwZm90Q293bEtSWUp6MWl5SW52?=
 =?utf-8?B?aGxndUJ5K2lYTTVoK1RmUnNLa01CbGxxemFab3VYWC9iWGM3dlZYZkt5WUYw?=
 =?utf-8?B?YTV2L3dqYUZMRFhQZmdyZ1ZMc1ZhTytMZ2xvcVlZOFpINHJJeHZvZUJVNTB4?=
 =?utf-8?B?TW5oL1YwUWNpelE2aG9SQ2lmQUlLWWo2ZXgvMFJuR2xYcHQ1eS9FOGRtbHUx?=
 =?utf-8?B?Z2NCRnNnS3dXcHZENkZsbVBxNWh5NDNDOW5TaWRwQmhmUU14KzduMTNXSXFG?=
 =?utf-8?B?dmpYR09majluZElYNUE0RURuMGdOVERvZGhnblVPcVF4c0lJWHRMc3c2Z0tk?=
 =?utf-8?B?OENXY1JnV0grb3p5Y2g4Y0pvT2dIV3ZmaWVOZjFPYlhlWkNhNURUN091Y1pa?=
 =?utf-8?B?RmFOU1Z5UGVyK0NZckJCR2MxM2FNaHEyb3hMcFBpRUFIV2VJUFJjT1RDU2Uv?=
 =?utf-8?B?SkNYY2ZSZ3hndnAvK2hvSmdqbnkzSEZ1eVp1UXpyZEMvMEpDK2JiOE96L2l3?=
 =?utf-8?B?YWFxRjhIdzZ1cnV5Mmg2Z2Q1SnRLd0twMVlNQ010WVN3aGJoYjlidnNNR2Fq?=
 =?utf-8?B?Nm9jc0JzaGdoNzdZd3p6TEVKSGxpTXp3QzRXTU1VYSt0RC9Sbms3RG5EYmkr?=
 =?utf-8?Q?kAuKky0RBNCHK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9f0ace-5c1c-4a4e-7dfb-08d9191079c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 08:48:00.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC/Z/QY6YwTLXAZ0UPPizByElSku1osRwEFzkaxmgFJFFiFGwQvFM559gQsI/D/6A/7dSjkJmwbwSGdJX0VxXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3966
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9986 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170063
X-Proofpoint-GUID: 1oWfYjgOU_Nhu_A6ctlwiM4MyhJ55Fki
X-Proofpoint-ORIG-GUID: 1oWfYjgOU_Nhu_A6ctlwiM4MyhJ55Fki
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9986 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170063
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


  Gentle ping. Can you pls consider this patch for the next release?

Thanks, Anand

On 19/03/2021 15:10, Anand Jain wrote:
> btrfs inspect-internal --help show some incomplete sentenses. As shown
> below,
> 
>    btrfs inspect-internal --help
>    <snip>
>        btrfs inspect-internal min-dev-size [options] <path>
>            Get the minimum size the device can be shrunk to. The
>        btrfs inspect-internal dump-tree [options] <device> [<device> ..]
>    <snip>
> 
> This patch just fixes it.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Drop the idea to fix the period at the end of the single line help
>      statements. Because the fix wasn't sufficient, there are more, and
>      it can be done separately.
> 
>   cmds/inspect.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cmds/inspect.c b/cmds/inspect.c
> index 15f19c8a3027..4e3e6382637a 100644
> --- a/cmds/inspect.c
> +++ b/cmds/inspect.c
> @@ -389,9 +389,9 @@ static DEFINE_SIMPLE_COMMAND(inspect_rootid, "rootid");
>   
>   static const char* const cmd_inspect_min_dev_size_usage[] = {
>   	"btrfs inspect-internal min-dev-size [options] <path>",
> -	"Get the minimum size the device can be shrunk to. The",
> -	"device id 1 is used by default.",
> +	"Get the minimum size the device can be shrunk to",
>   	"",
> +	"The device id 1 is used by default.",
>   	"--id DEVID   specify the device id to query",
>   	NULL
>   };
> 


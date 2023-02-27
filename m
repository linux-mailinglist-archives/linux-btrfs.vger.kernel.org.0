Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983646A3B31
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 07:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjB0GOs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 01:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjB0GOn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 01:14:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBC9CA3A
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Feb 2023 22:14:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31QNLISk007756;
        Mon, 27 Feb 2023 06:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EFDQQyLNLlcqummfBxgbUnGXozwj4Nk7jVbK+yQDogM=;
 b=GCc+yNlLaxL9RnmozGklr0fEx1tY4V4QLrGwU37dWpH0eX0+XhBIDcCuMnOLkjHWMVVF
 53b+7de6iFcyfymKbnLvFmKXdIooF9uPpkzGQEhzrAoKfsbLQiMY35oQC3JjlrtzVdK2
 pD47gtX2QQWER67ZV81EyU6L90uZovTzFiF44fyFKGhhdb7kykgzrV08FRKF/Sj2Xu5T
 o/3IN+BlILAP7/Wl/YGdaUPEWGHNDdCXwgMdCRGKeBXECWz7zMMYZF+4/s39oKqn3uqA
 5RunQgkceppCyFhlK7MPHmeTWin0MMxq0PCo8Z6lj0TGuLCMO/DPXo7xLbtswW0a8VVF 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9aabt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 06:14:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31R3eKd7032926;
        Mon, 27 Feb 2023 06:14:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s4upy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 06:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS0jMh1Ko685eyika1SHXkzSu3ELfwOGDxg0i7XhRHX8ss7igA7+Cc2LOmcPZkAbqWE2pWnHoDZ4U29gJ8n6MtEPAjdSce6nFookZFDoQm5XMmU3LFdGXeiB0WgRbSpEQwOfAVAHDtSi1wr2Ny9g23R38XEgKE6KE7ejA3L+yymJpde8Y1TuNJAUT7uuM7sSDj7JQWPm/6FoGqG98RF/aB5Qo5u5kQfZGCjd2nIjbhZZgHFKG60GPLxVuzJEqmlqad/AetvPuVkiQ5rFzuDhaz+nhHqryrk/kGPZE6FTz7Cs79wKWzhcNuU9olNB/3b7IS0ZyHNiNTr1fvz1TM66/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFDQQyLNLlcqummfBxgbUnGXozwj4Nk7jVbK+yQDogM=;
 b=CFNe59RU5XA2YSlgi2OaXfaTQUyEEzZxBrzKvS9OHMWSl/lk3lHjDCx0vUBb1fkCM6lKUJmNiO4+YVV22alRkjruMS+IZDeO23Oqq3i6eP6DVwXJyv9ABoglbiHvC/g9ZYdYf7JyWLGwyvqV0NjNMb9RzaAbey/Cq0CA5h67mJ6LEhMH86R9sboVKfYXlTHQ5fJKFfyQxHDTTKGb2zUnZJfEqBbCx/c2Yl2uBhVsxy7PQ2YqyD7xZ4Yc8vy3/cziaFuPiR85EJ6fx6X330XTnKnXnn9F8I56gqsdUWursf3192A1IWJAOyzxPiE3pML8t1MmDFpkzSyJFivEujVw+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFDQQyLNLlcqummfBxgbUnGXozwj4Nk7jVbK+yQDogM=;
 b=WDazf8UEuQks3upRVjuAJsCcz2bW0Bh22hTHD55yccN5wzxRSCNPbeP61wuUYhu31dgfCdG4TBC06bW0pFJv+REdlfCX/outat5utXFAo6PCXU6SyK4OkcRUXqDFHDalp7yTEqE++7Aih8SfJ4DRvvFWFNaWXM3G6N3TibBH9EY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN4PR10MB5655.namprd10.prod.outlook.com (2603:10b6:806:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.14; Mon, 27 Feb
 2023 06:14:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.014; Mon, 27 Feb 2023
 06:14:28 +0000
Message-ID: <6de919ad-6576-c96d-35f1-cdf09c19dfdc@oracle.com>
Date:   Mon, 27 Feb 2023 14:14:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: fix the mount crash caused by confusing return
 value
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <2de92bdcebd36e4119467797dedae8a9d97a9df3.1677314616.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>
In-Reply-To: <2de92bdcebd36e4119467797dedae8a9d97a9df3.1677314616.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN4PR10MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e23875-a5f4-4d6b-a5cd-08db1889e1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0/S0PzlyEzOn7m4y7ph+mvKf2cKwqpSkSzJwP1VA9RnIzcTDCmlN+ptqdCUwSsOWWKXm4Pt/e21U7uikH8gVDllfKFmo3tvDcnbTsuzw1YJTutYGrbpNzpUwjdWxooWcA9lWEJTCm6OHNsIE+X6tOxd4SNl0UzR6sus/Q4Op8RJJI3Iou5X7hNNt3vZnPoOvm7bOQLHh7nCJAskDrKCD1Xnihe9SfHf1hpK5couQ8Bw9ERiQb+yJTsaEncZz/tybxH7s5nwYVHlwX6G43zV5AnXS/tUrDzcGll4F6OIx4cXAuczNtSoUNDfM358IgMaK1HaPRmE2ct0htujhT0Mjr+iLZ5OrzVQe2gOSELgkTp/BG2qCyGEsh+Ud2aLny/LP3FQOkx7Ua0wy9Y1IfIk/tOgNWLODCnenrOWfOWSfwD1LTjHupTDsVtFcwf0Gf55aUjpIMsfVV/bIscnQ3MAwvO0Mp5nrfLIZ9J8ZR1h5REMxipY180HvbN/VyNiq80v7ayDBVSBtD/J49JwrYUMsB3BmPmyyA13JOh99XL8OV5tqr3kzbzQHImOx3+YIypH2Fas1o2SjKfLelPE0+ydOKbUXjjDozh414egymnHSvsCwW+uicUfVxJHRjCYWoLQmYGgpRd7WumtLFpjG218/plwucUPL7ZE2Fq/i1Eo87GFi0/qVnzkcxlg4rrcWxI+oFiPViXn74MQQSm48RpRBk5AOgyKwqAkjEZA+VZbDEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199018)(31686004)(83380400001)(8676002)(6666004)(36756003)(31696002)(38100700002)(8936002)(86362001)(5660300002)(478600001)(2616005)(186003)(26005)(6512007)(6506007)(6486002)(53546011)(66476007)(66946007)(4326008)(2906002)(66556008)(44832011)(41300700001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1YwSmFoaFNOU2J1dTFQcUwrY1AzQzNBYmFTa3NMYVA1UllTVENPK1Y2RkRC?=
 =?utf-8?B?UFFXY2FpdTM1a2tXOGZUb2s0UGM0cm5hb3VSMElPSi9oRk84cWhLcWVCckRi?=
 =?utf-8?B?NFNERVdjY1hXcjRva2swYzN3bUVZN0FESnc4MzV5K25MWG92RUZyYVppVEZw?=
 =?utf-8?B?dUpVV2EzUkQ1LzVJUlJJOTgvYWY1ZmdEMXNkY2RlK3JZT3NyTzFWQTJTWm1J?=
 =?utf-8?B?SlBPQ2hieG1WdTRkVUJLNFBiQ1VyZWRubE44RjQyQU1hYU5oeDNmWlkySytr?=
 =?utf-8?B?dHV2S24vSCtpNHgzeTFSZ3lMWE1NWHNWamM4WStQbTduUlg5Ky9XM0hubE8x?=
 =?utf-8?B?WXU4SFRkMGNrLzJCczViZTNnUFhwQXVtRG5BNFhnZ1pLYUcvQkFublFjaFI4?=
 =?utf-8?B?VCtiaG45Y3Q2V3lzeTFTRmZnQ0NYQk56aHAxcjgrZm5DQklROURlNnRMVW1h?=
 =?utf-8?B?Z2M0N09kT3JTQWZ3ZnVCdWdJT1QvL29hSzJxMXVVbnArMitCZDdpT0JRWmlM?=
 =?utf-8?B?MDdSSXEvaDVtNElvajNzZmxBQ2dwWmRrUEJtYkh5NlZ4Mm9BQi8xQytXU0My?=
 =?utf-8?B?WVd4RU9sUDFLL2pmcy8zeXkyb2QrclVtS3AwbzVpRVBoSExFSHlvMnlJOWV1?=
 =?utf-8?B?dFNzSEl3L29hQm53Yy9oM2tvNGZuNmp2cEEySjVmZzgva0hmc2ZNMjRQd2p2?=
 =?utf-8?B?cE9VZzdhTWJMSWFSNFczRDRwaXh5MlhxdW5VVUNuTU1WL09yUzNzaGRCUTFT?=
 =?utf-8?B?WXFDUmFLRmFWKzIxWEtBOFNGRklrSHloVklwTjJlcVNwc0RudFBOUUtsZVZl?=
 =?utf-8?B?NWd5d1IvWTRLejgwVXNjMUJRbVp4UVFSRWd2b1V5aVdTcnRGWklsVTlqOTVt?=
 =?utf-8?B?bmtTRFI2bHFSbTN0aUhOU3JsN1hJcWdoRWd5MjRDdmk4MnFiaGlIc3p1S1l0?=
 =?utf-8?B?SDFEenUrbUw3WWc1bmY2WkpMZ1E4WXNnblVvMmFyYlJVejFnZFNTM2NLWFNL?=
 =?utf-8?B?RDlrazV0WG8ycW5xeXFxcUJZMXNqMGNCZmxtRkdLaFdLWHpSQW50MlVRczU3?=
 =?utf-8?B?K0xEellkTG9HOU1McFJPbExHMld3YnVHQlkxdFYyU0FmVEZhakptZ250dFla?=
 =?utf-8?B?a2lnSEJTbU5wSjFtdDNrUDcyOTYvdEtMUkMwZnh2QXVkcDdQWTdFMG9JdTkz?=
 =?utf-8?B?VXJUUG1qRzhsMXJTdTdNRkhDZ1FFT0NTY2pkQlo5SmlJYWtxaURtTkpWUDUw?=
 =?utf-8?B?Umd6VjZuRHljZHZLRUh2TzJIMHBHdDN1U2kyWUVEUmIrNVBvR3ZkcTZSQVJn?=
 =?utf-8?B?cTFXV0ljT0Y5Wm5kSkRoVGZ4eWVtb1VScXJaNytHNFVSbllYQzd6KzZBMm9T?=
 =?utf-8?B?YUhJeGY5RVJMZmdDa1ZwWnV4YUd3ZzRsOTY4NFV2WmJTZjhuWlMzRTBnVS9x?=
 =?utf-8?B?czNwdjNLL3VLU2h3VlRPYkI5OS9WYXlKcVRxbmdjSUlZL2tMZUZwR2gydFk1?=
 =?utf-8?B?eWhtMXNJK2ZJWEFhdkoyMng5L2p2bUtFK242Y1d1MEZVN1BVUzdIeTNIOW5w?=
 =?utf-8?B?YU9ZMnlVK25WVzFtdk9rd2I3alk4UG1ybEQvYXJxckhEbUYvK0MzMGNtMXc2?=
 =?utf-8?B?dE5rNlRtWjBVUWtWdS8vVStYWXNKUGNSb1hucm91V3RsUEdDck91VlpXb1BS?=
 =?utf-8?B?VkkrQTRSeTZiYVF3MkNPcEpDTDZyKzg0SklSRURLK3ZSNzhXQy9KQ1pBdkoz?=
 =?utf-8?B?RXljL3lZakFkRnNzTW1FOUVmdGtqK2ZVZkFVemtoRi8ydFozTDJ4Wm0yVVh0?=
 =?utf-8?B?QXFHMk1tT1ZNOWUzNktDK1pMaEUwMmh5eWg2MGVmZXl4aXdwa3RVb3E5eGVO?=
 =?utf-8?B?OCt6TzR2OXZLQnIvaWNkZ3owWGY2NFF5bjRzQno3K3M0MEV3eEtsUVBlcUdw?=
 =?utf-8?B?SDVHTnl6dWQ3ZVliTUg1c1ZWVEd2bEl1dkg0bG9OSVorN1d3aFdVRVU3c25W?=
 =?utf-8?B?cnVtUnhjd2RxS2VxcUcyTVdUS0w0UEpWZytNbWMyT3FBL01MWXFpWDdBemx1?=
 =?utf-8?B?YWxIWXlKRmN3OUZjMjFVRWs5SFJTL2kzbG5VbnJNWDZyODRMUkFhelM5ME9J?=
 =?utf-8?Q?s3mJNdpZJCgsux+MTLbupYQxa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hy9+GoVUbKCrSTS7ENeOkUPU5A/InrAtonjMyriwI20GvEsWtYUve8HVd3DndubuUyOVmK6CgYocRnMoB4LFUZiMNAXQ+RIl/2wtx1uz8Qdf3wkBxSSRzmxD9ewMN64C0BTF0ynrXDBW+/UQml4LHeDnzohN7N0lLTYdKRhPLKMpi59PBnS9U8waP2jcYJkHvi9jTfzkeYNgpUW2C21DX9LTRPku7epQj0e+nT+nUeAdd/7+gevI6SFhzf5HAZOhRLFc7Ayi3eLTH6hp5Wy7uPqbeMKgkbekJpbEWlkmhs+BbltOODNb2NQJwogmH+32B/H9eHHHA/+r1Q6uY+hl3Owvn7HwfrciUlLyDv7y/Ckt3Fz8Jkovh75MizfE9EPMm4+2SvmYdurCOlW/plLrPl/yFGfEh5udoXk0iKyfgkks1ZyGcWobXw1PLzJW7CcIdyG5cNLyauacQGfAJg+lyjI/2eYCFpiaJXvuGGPkpLcCMPZNRgeLFWZL04hcjK6HMw4C4dyt/ZjmhG9q2G1JqBQSFL65nz5VMwOJoa5PGj6gXlUUn+fNgk+OY+3dL911PJFaAhhY9l22DfalHwxeoxP/o6nkAzgpwRPwgwXyXxswjHChPG6zkAhMvAHptAPPyhoQch9ioZWXTYeU8xo4ERVZuY8jicsHOq0AtRUU6mpY037sekfzmSoHBqivHNuC/vXSHKyUnJiqPx6SR/Ct6c00eSMJXOblKEL24GH+QecK2FLm1QhyNVdTrm+36y+PCtyi5nzhHUyb25+vSVYzbNJupb1dX6FnozrsYM7wK9oumtYfx0Gv/SMltTfOjfj3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e23875-a5f4-4d6b-a5cd-08db1889e1df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 06:14:28.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DunJu9ijFPjo7dGJ4T6Xp3jSYH3W4g+iKFjJTm/16h/k8gMOg+SVXCzltX5fHB0LYS9m18bXNDHf/F/1vba+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270048
X-Proofpoint-GUID: DzY05fDjR2YhXGbQ6ZkgZAUBKkE-EkwV
X-Proofpoint-ORIG-GUID: DzY05fDjR2YhXGbQ6ZkgZAUBKkE-EkwV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/25/23 16:44, Qu Wenruo wrote:
> [BUG]
> Btrfs mount can lead to crash if the fs has critical trees corrupted:
> 
>   # mkfs.btrfs  -f /dev/test/scratch1
>   # btrfs-map-logical -l 30588928 /dev/test/scratch1 # The bytenr is tree root
>   mirror 1 logical 30588928 physical 38977536 device /dev/test/scratch1
>   mirror 2 logical 30588928 physical 307412992 device /dev/test/scratch1
>   # xfs_io -f -c "pwrite 38977536 4" -c "pwrite 307412992 4" /dev/test/scratch1
>   # mount /dev/test/scratch1 /mnt/btrfs
> 
> And the above mount would crash with the following dmesg:
> 
>   BTRFS warning (device dm-4): checksum verify failed on logical 30588928 mirror 1 wanted 0xcdcdcdcd found 0x6ca45898 level 0
>   BTRFS warning (device dm-4): checksum verify failed on logical 30588928 mirror 2 wanted 0xcdcdcdcd found 0x6ca45898 level 0
>   BTRFS warning (device dm-4): couldn't read tree root
>   ==================================================================
>   BUG: KASAN: null-ptr-deref in btrfs_iget+0x74/0x160 [btrfs]
>   Read of size 8 at addr 00000000000001f7 by task mount/4040
> 
> [CAUSE]
> In open_ctree(), we have two variables to indicates errors: @ret and
> @err.
> 
> Unfortunately such confusion leads to the above crash, as in the error
> handling of load_super_root(), we just goto fail_tree_roots label, but
> at the end of error handling, we return @err instead of @ret.
> 
> Thus even we failed to load tree root, we still return 0 for
> open_ctree(), thus later btrfs_iget() would fail.


  There are many child functions in open_ctree() that rely on the default
  value of @err, which is -EINVAL, to return an error instead of ret.

  The decoupling of @ret and the actual error returned by open_ctree()
  is intentional. IMO.

  However, the bug is that btrfs_init_btree_inode() return value is
  assigned to @err instead of @ret.

  ret = btrfs_init_btree_inode(sb);

  And the regression is caused by the following commit:

  commit 097421116e288dd3f5baaf1dd7e86035db60336f
   btrfs: move all btree inode initialization into btrfs_init_btree_inode

  This commit is still in misc-next. We can fold a fix as below:


diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 48368d4bc331..0e0c30fe6df6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3360,9 +3360,11 @@ int __cold open_ctree(struct super_block *sb, 
struct btrfs_fs_devices *fs_device
                 goto fail;
         }

-       err = btrfs_init_btree_inode(sb);
-       if (err)
+       ret = btrfs_init_btree_inode(sb);
+       if (ret) {
+               err = ret;
                 goto fail;
+       }

         invalidate_bdev(fs_devices->latest_dev->bdev);



Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06978179959
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbgCDTxr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 14:53:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36516 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728926AbgCDTxr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 14:53:47 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 024Jrbge006282;
        Wed, 4 Mar 2020 11:53:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rZzSv7rq3d7vtUCG+70cWV7mvz6lb+IRNlgSairhGWs=;
 b=ErGuGDej8HdqDfLDuq7uAPGJfXvbUDSvaSNpiSAQ0MpVzbONXULf1ahTxX5z/USwyEpV
 pLzxM1RWDMncE+q7Y622qjmZAAyhyXjJPWw2CJN3fWnNP0TOD8jxTdWTsa47FxbMsffb
 7UE1KB7pWBLCSEKlnCDOujqIlP6tIKbq1hE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2yhwxxpc85-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Mar 2020 11:53:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 11:53:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiG1IWCoFzO/aMhuJY/P2euUPEjogQv8Ubf9OoZqUglAhyZLZES75wJuyZshLNoCeMTyE01ylIrplTtAJ74kSi/J/K7hW6XgLFJFKefwj9jt5rZkushxYoqz+5RX1LfqP1QHMpNa46641d2APu4vAybKZ2OrBBKjaVk6bL7OEisjzoJe/C1uRU/srOuixYXrJH7PfEqCw5pwLrySjv3jonpu6rxU51tIxVvWNfyZuXFEXwPUh109Nd5916xfW0Sruqw0FCho4msWwTWKl385RWAC4uqrSNnioE2t2d3npQEX8DCc9jLuEN70l4sEjOP+eSiyY9MsPvmC1ua3TcQmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZzSv7rq3d7vtUCG+70cWV7mvz6lb+IRNlgSairhGWs=;
 b=LQNQg8orv7Wqwc9cSU3ZVVgYDa+7n725k5LBAbAwh2IWbQqSjAUxQ9XeOuYs+m88uXmJOapSQUOU+mT+E8raFko19nr1LVpgTD7rDnPPZTsITMtUAtEu2MDK71SgpSQ4Fbt6mif7GWYuegM5dQ4cR2mEA9Y/2wV7kT0C/fAfMiRQ98Rk9DulXXfsuROOHXWpUUbFc129N0VtmL9METRXZtHYCjCkP2RRpPl4bVi858yDoXSecOx1UO1NPn1haJQRc1yZx5/C2qmAfGOH4rNgjZ7jyo4pG4M96SIjWTIj7cOAfn/gJDXAKVTV6ytxN67+HfW8zFrZoO3y44W1hjoZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZzSv7rq3d7vtUCG+70cWV7mvz6lb+IRNlgSairhGWs=;
 b=N06Lx5oNGAI/VYQN4GseciDO1FDxIU0L/I2lAXoNZKgjrnUjTJynR+sLxydrzPS7vpomye97SRNUtvho6ufNGf2oppqrRoc7g0TtvFY6Dk2MeJdadKc5xFdJj5Uv2j62g44oNj45aZhVHuKHdHdvDp6++8SrokDc+1Pz7kariY4=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (2603:10b6:805:22::25)
 by SN6PR15MB2285.namprd15.prod.outlook.com (2603:10b6:805:19::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Wed, 4 Mar
 2020 19:53:24 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::1d55:c224:e49f:ebc1]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::1d55:c224:e49f:ebc1%3]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 19:53:24 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Roman Gushchin <guro@fb.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] btrfs: implement migratepage callback
Date:   Wed, 04 Mar 2020 14:53:21 -0500
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <EE31DE08-36D3-4A5F-910D-9264FF973C30@fb.com>
In-Reply-To: <20200304195002.3854765-1-guro@fb.com>
References: <20200304195002.3854765-1-guro@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0007.prod.exchangelabs.com (2603:10b6:208:10c::20)
 To SN6PR15MB2446.namprd15.prod.outlook.com (2603:10b6:805:22::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.121.8] (2620:10d:c091:480::1:568) by MN2PR01CA0007.prod.exchangelabs.com (2603:10b6:208:10c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 19:53:23 +0000
X-Mailer: MailMate (1.13.1r5671)
X-Originating-IP: [2620:10d:c091:480::1:568]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35c45c6c-f5ce-460d-0c93-08d7c075b2dd
X-MS-TrafficTypeDiagnostic: SN6PR15MB2285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB228526CAD8D6039198391EC5D3E50@SN6PR15MB2285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(2616005)(86362001)(6862004)(186003)(16526019)(33656002)(52116002)(478600001)(6636002)(66476007)(66556008)(53546011)(316002)(36756003)(81166006)(81156014)(8936002)(37006003)(4326008)(6486002)(5660300002)(66946007)(2906002)(8676002)(4744005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2285;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3+BTP36zQLc+MYSmsRHq/fJnSstGmBatbKWTx8GygieYDSTK9EyTsrPgaqtEqFNYBrvpTaMcWVeaEHG6qXUtZln31fcjke3T362lp7huECuSkN85VoU2MFchfUtLMKBDumLzljJ5QZdmjE3K3h7XWXMsHgLnWeIf8UOo4gT8mYbwp7U1Aj6JO9hFxunAIMWGWMr70CLfxFTl3ZtWptyypTLI6mdct/ZoesPdPnYm11y5pHCjh3oxiyGDignvbkqpUVzzFR8RjdQ55SdN1+CjDJuaVeaAvjwAW9xaINkhcRq8J/VnRbZKRS9ZNvB547rfRW+w13mYO1Ji8NU+exIuWk0ydObOG4v9qHpleP3p/LYDXYCY1+FXDK3eyJ8RpG9Rs4sLu4MQyARMHWkwh+H53X8CbJQ5yEQ6T4/3T428XXYPTCDF6KuIaBPM71Y7oDE
X-MS-Exchange-AntiSpam-MessageData: C4DDa7/ZmF3NKduWcOQiG0NZ/0NBoCTxz80BtVP5Y6XuHkbIZacTtzYPQyce9HMxSYu4uXPGYWeA5AZUYrLDXTdTWYTtxRrFG+28m+Bg+BOpZKAB7A9xTzXUwcn+n9HxnvUjZFsrzCWqn3pQcYMYJ8Wu/LnWdyyoXGmUkueY73HfxUUv5fAIqrbvf+HpiUBj
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c45c6c-f5ce-460d-0c93-08d7c075b2dd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 19:53:24.2261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoWinSlp/k+5iKYrCR4QhujheLNjVftcIItYn/V/9IDhONjQ/5YYzbJqK6aJwtQX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2285
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_08:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=481 impostorscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040130
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4 Mar 2020, at 14:50, Roman Gushchin wrote:

> Currently btrfs doesn't provide a migratepage callback. It means that
> fallback_migrate_page()	is used to migrate btrfs pages.
>
> fallback_migrate_page() cannot move dirty pages, instead it tries to
> flush them (in sync mode) or just fails (in async mode).
>
> In the sync mode pages which are scheduled to be processed by
> btrfs_writepage_fixup_worker() can't be effectively flushed by the
> migration code, because there is no established way to wait for the
> completion of the delayed work.
>
> It all leads to page migration failures.
>
> To fix it the patch implements a btrs-specific migratepage callback,
> which is similar to iomap_migrate_page() used by some other fs, except
> it does take care of the PagePrivate2 flag which is used for data
> ordering purposes.

Since the default migratepage didn’t copy PagePrivate2, didn’t you 
find it was also causing pages to get funneled into the fixup worker 
flow?

-chris

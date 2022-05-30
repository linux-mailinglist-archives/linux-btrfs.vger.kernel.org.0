Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9028453731F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 02:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiE3Anp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 20:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiE3Ano (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 20:43:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FB41E3C7;
        Sun, 29 May 2022 17:43:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24TLql2m019990;
        Mon, 30 May 2022 00:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/cIX+vo/r9+QO0UIQQYD0tGKE/BDMDplkKbBkh7nyM4=;
 b=hvvhFNJ9iHayJ2Oo+wi9Zcx1CSimPgSJR20fsaEnhTVB/D3R7z9rBjGW4pq6NscfFygE
 BHcALDaOJruqyvdFPhyIU5/4R5xK0m9kpVQxnkk/7r0mRusJqMlgkVvLnHy7Lp89vxi0
 VxDCThJi/00ZPNCipAWTbYQVogIdwQrPHpV8jXE0jDfsM56/VYVX977a57FyxTIspXjW
 h8HBvGZDbiEi1TFo9xD3p1xzzWNE+ChCKL3yIyusgEMwJPFdtD1NM4O737MkpZRr8ROl
 aepvcgNG03fqQS9UcL+lc+mzMR2S3VQEBslgxqJQfQF55WJxhPq1zGmai5LPVE6P8ox/ eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xhsa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:43:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U0fLL4036886;
        Mon, 30 May 2022 00:43:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8jvqw5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:43:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAKAgJQAFr0l0YlJHHAukUMDWgKsnT79FmGTDBYBeSqhPeaLAd/i8AadggWxUL0QoAc46JDKtKR5xFV+ccHUhl+U3TORbvH4fmN9ly6cZ6fwL6CNmSIMNmQW2Ba6YkNpjKvGPCiOscUbUk6Xn/eTHg3kGKb0KBPN88TsXHICo2Di9kdk0o3XXlVRpTCcgD7ZArXAkXEuXRQufMhD/CRh1GEUiRgIMJzZUK/aXnu+CCK13eRG+MnBqP+ePW/b86sY9xBazLmjNAWZ477Ej1nCDJPEcbbBNKxSHKDE5TXjNkO+C5/OXFfEHiu+zal40zADdXni8c2/OJ/uW41vY0UnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cIX+vo/r9+QO0UIQQYD0tGKE/BDMDplkKbBkh7nyM4=;
 b=Gk8tg5H1xh9U4cmgPbhcnXaNbxKUVC26OPtUvE8cALmOOEdY+Epr59vha3HRbxFm/7sVtuKp8HEgMRZR7v7dNY98+tS4HtQmflWIj7RvKyx+mUvTiRNyffshBeax3XhUxxOyHgTwdKaDJjUdz9Fk///5j7W8Gb4ZaJV5CmfHoVm7UXvp1I5W9t+Ba1nQpOKuSTnUgeWMgM/90YcSP4zQNJHGBSa4LnkeYNy2MltXurYuyKN+L+Ko9sJngSi7kctpo3mEIYRiEoN656oScBjC8pXTXcXbn/qaN299q+H4d9xxiqeTvcfG9bmNowcn4WYWDahEMLFfDxk+c5yXvcSZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cIX+vo/r9+QO0UIQQYD0tGKE/BDMDplkKbBkh7nyM4=;
 b=PWU+WQ5TV3atH6TapqieSGFxF6EApTrmnaeEbS7AYCnx8u9+J9O41DXWMER8O4gOEg26xdfi9J4vK8cnrauCdyNbID4yq1cPWqd02UI4t2od8lP3H/lmvQrXb6D4HXYrEOJFnI3w2Q++lAv6TG2ycNeNyH46fQ9inHiZsN0fwng=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY4PR10MB1399.namprd10.prod.outlook.com (2603:10b6:903:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Mon, 30 May
 2022 00:43:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f%3]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 00:43:35 +0000
Message-ID: <4acdb3ad-fa87-db92-5c11-770dc25e97ea@oracle.com>
Date:   Mon, 30 May 2022 06:13:25 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 05/10] btrfs/143: use common read repair helpers
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-6-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220527081915.2024853-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d97629d-0e05-4f3c-65f3-08da41d56daa
X-MS-TrafficTypeDiagnostic: CY4PR10MB1399:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB139929E6F3508A961700011BE5DD9@CY4PR10MB1399.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHZkBVfte+hjiOF/yQldih/Q3JyBS2H4OGTd1RHInJ3axaSeB7LtOmqIlCqccodmx9T70eapyLfnQfpIOGx9LwMqhPPC3k9W2ikjGZgBM/jrMUzFOa1H45NdEIvo0nmG2nyL3wUtIIMjYM3g0YXJhlx9M/u+55bozoxsd266Tn1AcAu58Rz/hBlhPJD2i6t4TyXMduOmXaEAAzCWtjJE8i3mRg2di/6A3qHUFkTufjLJROs4dbEvI7IlUZ2fntVeosYDDvdKYRfodRSv3KETgE6f0a+bP0AsukcyptzYAUz2yVQlIHUyys708QAQCnr7Im9H6aQx8Uf6yYaQf3zuWf8BCR5gQWJm7G+cdTVuvFz3M6BEWq95I8FaBLv/lBnSGS7mcdZbSSszlGclHxZnjGcDR4SBrxi9+dQ3qlyrM2S2P6tiuLkLm9q8Wmb0CKpeX8FLOJvIF2lTwhWlNTiaZ2d5fM0064lloZaZxRR1axVAeWUs2gzP0D6YhF4FXZ1fxJtawx8Ma+VB3TFa10Ugc3mp+6UOCj1p1FnfgkOIXg49BfXG+S4WHlW5tDgC0KXRQevkx98c5A/9vG3EmKNuQ0PJtnC+MPrgYjH9xACPdPD0Mtxh+UhFJddJ6CCY7Nix5iYs2MzOTwtBxfA96opnjZYDZ7JyfBCc/z0tOiPvVHEIf/RXKvD3k+bbkV6ORPSei1l6asXzcoxRaUzK9bzIXEgRBjjRIKUfEgQv6JeftmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(316002)(31696002)(66476007)(66556008)(83380400001)(38100700002)(8676002)(66946007)(4326008)(2616005)(6486002)(44832011)(53546011)(508600001)(186003)(86362001)(8936002)(5660300002)(6512007)(2906002)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmllRHlDZVBueGpUN2syakxRbEpTM0g5bWxFMHVmRW45R1VuYWRDWnVxbkZw?=
 =?utf-8?B?QUdMalFOOU1kMHZwZVo2eFJZMFUyTW9qNlY2cG9BS3pNTkZWZEVVckFIZng1?=
 =?utf-8?B?TU5mRExGQzJOQ052QUNMdFpXWkovNXRCNTY1bDJhQytvaWdqaWhsUHp4bVhu?=
 =?utf-8?B?b2VmUnlGNVdNTHpDRktPbXA3S0MzNjNVMkY3WTVsdFNBU1lwZkl4M2IzQ09U?=
 =?utf-8?B?U2wwaTgwSlRDVWpnMDhtY0NQV2padDlmTEJmWHQxaGZRdXQrUVFqTzFFTmJX?=
 =?utf-8?B?OG01OHFKck5wdjRhQkxZTVY4NTZZOG1YVjRqcWMzblFnMDlXTjRZbmF5NStI?=
 =?utf-8?B?M1kxa2UrN2YxUFlkbHJMVW1GL2VVUUNCaVJIdXI0QTF1VFRnME1hNEdTR0pY?=
 =?utf-8?B?VFFDY0d0MWtHRGlDdXprSU53SFJCbTFOMWxqdjJHYjlKcDN4QllmOVdNYzdD?=
 =?utf-8?B?cWtiZmJMVnE2QzJPbkt1aTBFT3ZOa0ViTFVEajdjRlhZQmhmTkwzZG5NZS9r?=
 =?utf-8?B?TThKd2RuOWM1YlZEdkp0OXc3Y3NyVW5SYWw1OU12aEhPVDduUTRGZzhKUFhs?=
 =?utf-8?B?TkJpcmV6cU4wWXhJSk5wK2FxWUJYQllGYXJTUUwvUm1XaVRUck1WTjBZRjJ5?=
 =?utf-8?B?R1lPcmxCdkU3eWtPSkczSWNiYm1tTEZaYmo2SDdHZjN2WVRmaS96TytsTzVL?=
 =?utf-8?B?UjlUUVc5NjJXMjhZeVJPbUZTWXdBS2lmL0VFanRKSS9HMFNGUXRvVTZhM3hh?=
 =?utf-8?B?VEtuUWFqdklJVjdZWkxFWFRTV3ZxUnR2VVR1aHhKUWJsbnF4WFpQYWo2azBh?=
 =?utf-8?B?aWo5b28vZXNrY0RLNVpUOFdNV1dqVmdxaU1xV05SZUMyTXFVQ3VGUExMak9p?=
 =?utf-8?B?WXFOaHk0RWhKUFRFaVY3Q3Vpd25SWS9BTHM4aXVxRk9melJEcDZhdmZpWGJG?=
 =?utf-8?B?QjZMbHFBUDNEd3NLY1l5K3ZBQXBPR3JSeHFCN0tOUUEwRGlEdjJHelBHTFpJ?=
 =?utf-8?B?V3JsM3ZSTUg2aDVpWjJWNEtDeWUvaXVQNllYdkZmUnIxWHhQVUwwZUlHTXNR?=
 =?utf-8?B?dlV5MHFIUDY0aGl6cmdIak1EM1Rab254aXp0cVU1WWd0clM2N1l4V250emcw?=
 =?utf-8?B?NE9LK1hMSllCVlRNRnhOVHIzcEUyWjgxRk5BL0FxeGE4Z2svemNNcFJzOGJH?=
 =?utf-8?B?N3NEZHZ6RkxibUpHQ1hvbzVjVWdad25qQUQ4cmNic0NPS0cxcTROTzJIT3Zq?=
 =?utf-8?B?N2N0Y2hnOExrS1BhUEMrdVA5a29TQWo0Q0h6Y0xtbFpSQXVlWnpybllNWnA0?=
 =?utf-8?B?TVRid1N2cGFpY1I3MTA3YnN2cVhMM1BOd09yZGt6dk9ETXVpVUdXZGZVb1JY?=
 =?utf-8?B?VDVYRXRlcXRUZUlwUXQ2YTAvZ1FuZUdhUXNIdldXMnRUUExHV3FxM2psQnlq?=
 =?utf-8?B?U1dEWHBoYVZTdlZYOVlqNzJlSnRLS1FpUnhYU2wxR3MzMlF5VWtDMzJvOVkz?=
 =?utf-8?B?Q2hlZkZLMFY1V3R0SUk2V2wrZ3p4MElTczM4TVlGZENmSDBKTnpHdlVWQ1kr?=
 =?utf-8?B?WlZkbGJXbmp5RnRKOG9MTUcxNjBvdFpQL0lkMnRXWlFMaHBQOEZseExoRWxC?=
 =?utf-8?B?OWQyZ21xSmNEQmJRMnB4a2lZTzFUZ3pyYWoySHNvRjJUaWVXb1I0QUY4UzBG?=
 =?utf-8?B?REcyREFVTGtheTI4Rzk1cC9hWC9oWVVNdUEvM056Vjl3bExIell0UzU5THdI?=
 =?utf-8?B?UStRY3NIemk3d1krUVhqcjRJSkFjYXZBS2VoajNtb0pBRUlFYVFqYzIwWEJD?=
 =?utf-8?B?cTVKSExtc2sxT2Q2UHllZFEzLzUyNzZLeEluN3FXMHZ0R05yb3lZMCtJbVdH?=
 =?utf-8?B?Z1NBREc1TG90dkxaN3Z1bFFEd3p5RUFEcFlrZGdFZG5JMDQ2SzM4ZWVmc0JJ?=
 =?utf-8?B?bGZvN1NtQ3pYMGdQa0R0TTdaajlOSEpjbzRMNDV4d0t6NmtzUnN1NWhEdXh2?=
 =?utf-8?B?NUgyWURiUmUvZ24xWkVDdjcvVmRabzNsaXV1L1U0aDQvOEtGbCszc0ZIVVky?=
 =?utf-8?B?QUp4N2EzUjdoL08vNEFWSDBseWVzdEZSdnJzLzNwQjJ6NTFLTTllSzlVN0F4?=
 =?utf-8?B?MjRIWm9kZFdGNno5cWs3ME5yU0NoZC9nWlFsdnQ1T05JM2ZkYTlKSTJodDJz?=
 =?utf-8?B?VG14MGN1Mk9zby9IOGErVjZ1QTlYNm1Icmc4dnNBckNmS3lnTEx3M2dyK3dO?=
 =?utf-8?B?SGdhdk9MUnRaN0RvZlJCT29Vd3ZaYnBWMkRFekk3TUk1d3pveWttc1B3VmhZ?=
 =?utf-8?B?L1NUaXlkUEVac3duKzVTdmNHODRtSE9HWWlLSk1oODY3bThpdkV0Q2pyZnJ0?=
 =?utf-8?Q?QXmlK6ofwRJCkmiCtHunl/klpexMfmJWVphOEOrDhlMCN?=
X-MS-Exchange-AntiSpam-MessageData-1: +ay8HE7Bd0Sd7qaSPjfKEzsY1QDvpUvutU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d97629d-0e05-4f3c-65f3-08da41d56daa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 00:43:35.3827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qw5R7bLmuG+FaDKFV3Udoy70dPAP8PiXeVj19UauNhwTIGiqbQPeIidcTnUQgAe+5JGNXI2ulduKs9P98aGVpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1399
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_07:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300003
X-Proofpoint-GUID: I4vKcI0Ha8bMLeLaePWyUpkDRn95zRg6
X-Proofpoint-ORIG-GUID: I4vKcI0Ha8bMLeLaePWyUpkDRn95zRg6
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



On 5/27/22 13:49, Christoph Hellwig wrote:
> Use the common helpers to find the btrfs logical address and to read from
> a specific mirror.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/143 | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 71db861d..b6ff2a42 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -34,7 +34,6 @@ _require_scratch_dev_pool 2
>   _require_dm_target dust
>   
>   _require_btrfs_command inspect-internal dump-tree
> -_require_command "$FILEFRAG_PROG" filefrag
>   
>   _scratch_dev_pool_get 2
>   # step 1, create a raid1 btrfs which contains one 128k file.
> @@ -53,8 +52,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   # step 2, corrupt the first 64k of stripe #1
>   echo "step 2......corrupt file extent" >>$seqres.full
>   
> -${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> -logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
> +logical_in_btrfs=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>   echo "Logical offset is $logical_in_btrfs" >>$seqres.full
>   _scratch_unmount
>   
> @@ -74,10 +72,8 @@ echo "step 3......repair the bad copy" >>$seqres.full
>   
>   $DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
>   $DMSETUP_PROG message dust-test 0 enable
> -while [[ -z $( (( BASHPID % 2 == stripe )) &&
> -	       exec $XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar") ]]; do
> -	:
> -done
> +
> +_btrfs_buffered_read_on_mirror $stripe 2 "$SCRATCH_MNT/foobar" 0 128K
>   
>   _cleanup_dust
>   


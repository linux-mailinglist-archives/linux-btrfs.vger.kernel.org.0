Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95210567AA8
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 01:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiGEXXa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 19:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiGEXWu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 19:22:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05961A3A7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 16:22:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265KwjGl001719;
        Tue, 5 Jul 2022 23:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yF/oB3Qu0kSAyBDfv7JpCoMWUhQDXy1mrXIA16P84yg=;
 b=Og/lw3XHXgxmzIz+LhFkWLNVm1G5IjBNTSmlX3okPxL1yZHy1ablRZT0ZIiLO3RJCUnf
 KFxgGj7dNRNKwVJTfs+/CEn1yiM6zS16YxHiXDirScGW3drTHsan9N3djFBR/hdz5CtI
 N4XxYDNLAtbYioIeK64+/qCMY9iQX5gW6NaLg3N+iBNTAFJPeqFwiZ8rWun3o7OSZtVD
 LgfSecmTBTzMBRUyTqacFTBhN7Yyj+X/brNyj/tFyBSO82yHRJBcftlPd1GFKW79Y3A6
 jK4Wno1lEkygbtSmAkKO4NMFZ0hRz27qEEYjQkH0sxA7rC5muqfP4NGnFBX1NTnFe4x3 PA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby0ejs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 23:22:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265NLceX037454;
        Tue, 5 Jul 2022 23:22:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud7ky7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 23:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq1SINCkgqsLd5WXYAo/T0gNZfLjiTSs5dp8lPqQ4jSXh3co66kruMrcELFAR6vemkPEifAOg0W00fYB09DpnWSCqE+ziueXGgvM9imVxiPb85ssgH2XJ3bT7Q+W0KtR01KIigkPyQFrwC5yHN2oUu4XyKZRrL72iNEfOAQyYl4ElhBStHpC4G/oMCLnTQ1D26NCItl54jWbnfBk3SxANsFj4UYmqRjgZCV3CrGYfp+aaiSoyeFhCT12JeG54zsIWWEBIOBwUYVcu5B4NQrIjRQnv70raYYTjNBvT7PWwMQ2q/eDejKMS6g1Js+loZHBfbBt32WYxwv3VYKICwkNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF/oB3Qu0kSAyBDfv7JpCoMWUhQDXy1mrXIA16P84yg=;
 b=e0ee4Mkn+peoIFh94bkFpzEQp4GSxdLKP4pd8xKfDkHUtgvxr+4ZY6IgaRYiEqpc7yRtTQmojSOeUXrQSKjEaI6KYKYU9dZYGJQJdFPVOT4GgMdmam6/8W9TCmJeOElx+0I/4gMyy5/3ZaPKs/+TkZpr5V7NB5G1JVV4EoLlQfHqRLSicd47Nt6HOwZcwU0DR26GMRPrHpgDYk2Zed6UqfOhklUoKPoeeS5UgNSMWC5gIzz80YwQaBu6FzvGPN5pCDynSwvuP8jarLhwrpznMAQo/Y+Q1LThC2/H5L+joryQScMDLaYRWshkwkd3PKP+GpmL/80qgJmpBWojvU79xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF/oB3Qu0kSAyBDfv7JpCoMWUhQDXy1mrXIA16P84yg=;
 b=z2cXZZclCprVPgIyC1m18XGdQRunSR3WaBN2xXFsjOmwMAOz5pX0kisP8Htx3pcvc+nQ4PVhV0YZT92+6zHjUCfrbBRBBiZVHlIGUYQaJtyFFc5+BWahfWidLP+PdYifw1qhxgh3aqCCP4G19KhjOg987KnNtPVtqiVPSHS+6Lw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN6PR10MB1491.namprd10.prod.outlook.com (2603:10b6:404:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 23:22:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::957a:9b8f:bb27:2173]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::957a:9b8f:bb27:2173%9]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 23:22:42 +0000
Message-ID: <9fa28e6e-0605-5d38-3b80-157b5033ea2f@oracle.com>
Date:   Wed, 6 Jul 2022 07:22:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2][RESEND] btrfs: allow single disk devices to mount with
 older generations
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Daan De Meyer <daandemeyer@fb.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <75f38ba99fde2f94066fb4578914241c0e2a8f9d.1636408300.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <75f38ba99fde2f94066fb4578914241c0e2a8f9d.1636408300.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76d4bb15-aac8-4fad-1f3b-08da5edd4297
X-MS-TrafficTypeDiagnostic: BN6PR10MB1491:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8dvZu4VvPgXAlYl20fcRrWL5YEAjsDUwgKMNsAQd4Vw2TuUnzSHFEEyhmw2fwDd147T1vdHf0kkCJhCGfucXXrCAPJkZSh44Iq5rQiXsYyY3HimEX7wky5F9E0k6y48Sp+SCH/t9IJtMPNAdTxnlikzblXtE37ZcQQ2y2VS7Tl6p4AHkf93nOaJrtPRMHTfoaXX/04ii1GA3IyfgYWSjYs4jwXZwwjTJ6nddU9+g6PMF1XbSyfspoEztxiPWC7YNlq2shP4AOD9BHO1LD209yGYrkJAVo+TrFt5kUAbnsaSC5wruo8Sqbsqf8QolE/Tq+NUxmBLIIWZ9j230AT1R+TFx2R+IQuPidyCZQz3HGsMQYhhu93ywiA71AvNLiLmHE1DfeVpjeOA0IK2WuZkWuCGEtJJ9l5PjKsUkHTnnOrG39eTZDqFU0oikuXHWZM1b73mUEsJlfDL9TYHltOg4GZVX1zOC08xotIbfpoUof4vxHJB6o2AnLFsJRe+q0IULHORuXP9ttdSahqJX3P00uRbo5gewtvBcsBtDVE3o9myHiu5U5BXsY5cQDswLEIn6s16S2yx2+03oLtIyQ3VTs/HHXnZeBK1YG1cAzpSJnbhHsaz9H4ZGN4YYFQ+oArKF8+SC1PQ9bABUu0T6e7rEV1Eh8Or2ulcp2fNsU9ICnm6UiIPvv3ghxuZfcBFirSNJaawOePOKZ/nbaKGXlqM6keSY7FH2CsijM/5uLhVMtNj+Uv9QGTzmEND3HV3ly/LYNQ6+7hjJ+KTDVsufiGoHjexWmUqgeAIbt5TW5vBR5H6uA4jlvY50XgqWNkGzm0kNuxDajtqRvFtXnfp/6zAiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(53546011)(6506007)(8936002)(478600001)(5660300002)(2906002)(41300700001)(6666004)(8676002)(4326008)(66476007)(66556008)(38100700002)(66946007)(44832011)(36756003)(186003)(6486002)(6916009)(31686004)(26005)(6512007)(31696002)(86362001)(2616005)(83380400001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1uMnltUkZPOXgyL3IveEpvQUwvQVpIL2hxdUUwTHFMa0NHbStWSkkrdDFt?=
 =?utf-8?B?emtjWjI3dCtrR0lzdGdHRGFheTJmSzRKL1lzck1DZ2o1aXVFeWhtSmNULzJr?=
 =?utf-8?B?VjVkL0hvMmM1VXc5a3dabDg1aWUyQUp2WVJoSDhPT2ZUTnp3enVCREMrQ0kr?=
 =?utf-8?B?WDhwOU01TFRwSko0d2dSbnphR29ONkdxVXJrdmV0cUE0YjNyOFBvWDNhQXk5?=
 =?utf-8?B?SEdYUWdXZDkwb1FPS3ZlVzN3WlY2cTJrR3ZUM3VrRzl3M2NtNkZXM2g3T1hw?=
 =?utf-8?B?R1MxVHMrZnVJT3JHSDBDT1RwV2ZBd3JFTzJFMFBkaWdaRzlMQ1hTNEhrTEV4?=
 =?utf-8?B?amNuZ2Z5cThXUXU2WEdVRTI5anM1QUN4TnYzd0JCZjRRVE1rQlZ5TXdneHlK?=
 =?utf-8?B?MlVnb2xRZ3dSWW9XeENrQkZDY1QxL2hNVGFtSFREOSs3cjJNY25sUHZKa0tQ?=
 =?utf-8?B?S25haTV2MkpscERiU1d4eDN2Z3ZSWENGVGFrQk5GeWxwQ0xjcnlLclptVHBF?=
 =?utf-8?B?cW82aFQ5VGliM2FmVDR2NVpaZDBMRFJpeWd5bnlZckErL3dpa3VvbFBlbm4z?=
 =?utf-8?B?RlZhcHphblQ4OTBGejZQQjVTNlVXR1BBaE9IdEtUYmxqU3VGcit6Mlh3UjdB?=
 =?utf-8?B?RTlGQlJRTW5ySHVPeVZ6VUs2Qmhwemx0NFRuUExib0RNNmxtTkJlZ3RaYTVW?=
 =?utf-8?B?bWxWK0VqRDZsUGd4dGc3SEgrWWpETGxPVk5QdDF1TzBJMHpDcU8yQk1uZ1c2?=
 =?utf-8?B?NG43UEJqT0h4d1MzdGt0NndSdmdocGpmM3VTV0FGTW1Hc3BscW8xWEZHdWpq?=
 =?utf-8?B?dGhxRXVybUpqSndFczMvTHJYb2tDMVFIT2dhY2VvaUQ5WTduVkZ4enRQYitR?=
 =?utf-8?B?RnlqVjM1a1BrK1dwTE9IcitYMDlId3pRZVE2MXhjcWd4REFwbSt6T3V5NUQ3?=
 =?utf-8?B?R3ZXTDZTRW9PVlpEQ0VpTG5maEhpMERDVlBPZFcxSXR3M3NtZG90b0dsQUti?=
 =?utf-8?B?WUt3TTBrdG1JZWg1cUxqL2RMcTYva2ZacmpkczBFMFAvV0NmMEsrRjh6bjk3?=
 =?utf-8?B?bWFZNUppVGtSSkVSUmhRM084enVqT2psNHN5Und0aFpJT2poWU5GOWVvdDRk?=
 =?utf-8?B?QmpHdFVIUnVqcGJnTktEaVZ3RXNpV1JEUzFoS1k5NlBmZitab0YrYmUzbnNr?=
 =?utf-8?B?cDhZN2xkRHFPM2VTRlNlaEhQMVhqT0w1bWJyeWtnd2QrMHZHWExFK2JZZHZ4?=
 =?utf-8?B?TU9xYUx0MklwZFREbU54NUVORytRUU5iVzVkbld1TE1vWnV3eUxsRmloTmhT?=
 =?utf-8?B?V3FwbTNQOUpndjdJUWNyQkxlTHY1UGp3bkJZbmFocVRlUytTczdNcHZxWW9r?=
 =?utf-8?B?THNCWDJpZmxlTmgrOGNMT2V3cjJDZXdNSlM4M2J2SlBpc3J2R2JPV3ZjOG9j?=
 =?utf-8?B?T1Q4UzZqdHQzSXhTTEN6RWlNNHVMUGV3OFhBcUp3eUJtVkI2VExqd1hmZy8v?=
 =?utf-8?B?cFVjeDhEckZOVDIvUit5Z2xJNU56d25jLzViUlg1eHc0ejZ3R3k4KzJMU2F2?=
 =?utf-8?B?YnBQMGZyajdXVHVsWFlpSWhSUFl5RzlKL3JhcjJycG5oZk1RSU9hY04wci9T?=
 =?utf-8?B?ZFY4QUE1TzVGNGNkNlA0SkJtd1hpSCs1MVNJSGN1NDZMTFlUclhtZERLYXFT?=
 =?utf-8?B?am96YUFVUW1rdGE0emVIU2d0cE5EZ2hhZVRmSlBOQXdHQ1BReEV2Y25oUENl?=
 =?utf-8?B?K1M5aE5ORUsrYTIxM1NVWHoxakdjUW1FSzNRRkRRRkRFOUhmT0xhZ1FqdVAx?=
 =?utf-8?B?WDkvaUprQmpoYml3YnB0aGVxVnFuemh6eWdKalNPanlYbTVha0pTdm9rQ0ZC?=
 =?utf-8?B?ZXhSM2t0VGdaRXdBUHk3UUdEZ3REZGZRRzdKVitpQktibGZKQ3I3VFByaTdH?=
 =?utf-8?B?NXJZUUQvc3FtUm1aaFpVZjRPd0NKak1iWUhaVXc5ZEtxK0ZxUU9ubks0UWc2?=
 =?utf-8?B?VzhXVlVBdGxQdkkxTUQ2R2M1SnFta3BaOXVjbC9yOVkwditiVHlueW5VN2kv?=
 =?utf-8?B?L1lrbE1kaUQ5M25IM09iYjd3MS9tTDRjNjdIZ2l2bGd3Q1F1V2gxcFNFVXZz?=
 =?utf-8?Q?uc0I8Uvos4pMaGyLWAYXfNZF5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d4bb15-aac8-4fad-1f3b-08da5edd4297
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 23:22:42.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCCZ3gFLRumwCIhaf9s0zAWRzMu2+6C3ne4Au2OR/Us8gt2N49kvyBYt3hvN0UnEU8WB46s0XtkAq8H+2tv/Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1491
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_19:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207050100
X-Proofpoint-ORIG-GUID: aJYZlmUcHfBKa9EB7l6zMb_BwjYByS1K
X-Proofpoint-GUID: aJYZlmUcHfBKa9EB7l6zMb_BwjYByS1K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Josef,

   Maybe this patch got lost. Could you please resend this patch again?

- Anand

On 09/11/2021 05:52, Josef Bacik wrote:
> We have this check to make sure we don't accidentally add older devices
> that may have disappeared and re-appeared with an older generation from
> being added to an fs_devices.  This makes sense, we don't want stale
> disks in our file system.  However for single disks this doesn't really
> make sense.  I've seen this in testing, but I was provided a reproducer
> from a project that builds btrfs images on loopback devices.  The
> loopback device gets cached with the new generation, and then if it is
> re-used to generate a new file system we'll fail to mount it because the
> new fs is "older" than what we have in cache.
> 
> Fix this by simply ignoring this check if we're a single disk file
> system, as we're not going to cause problems for the fs by allowing the
> disk to be mounted with an older generation than what is in our cache.
> 
> I've also added a error message for this case, as it was kind of
> annoying to find originally.
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Reported-by: Daan De Meyer <daandemeyer@fb.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 68bb3709834a..9dfdc7680c41 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -777,6 +777,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   	struct rcu_string *name;
>   	u64 found_transid = btrfs_super_generation(disk_super);
>   	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
> +	bool multi_disk = btrfs_super_num_devices(disk_super) > 1;
>   	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
>   		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>   	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
> @@ -909,7 +910,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		 * tracking a problem where systems fail mount by subvolume id
>   		 * when we reject replacement on a mounted FS.
>   		 */
> -		if (!fs_devices->opened && found_transid < device->generation) {
> +		if (multi_disk && !fs_devices->opened &&
> +		    found_transid < device->generation) {
>   			/*
>   			 * That is if the FS is _not_ mounted and if you
>   			 * are here, that means there is more than one
> @@ -917,6 +919,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   			 * with larger generation number or the last-in if
>   			 * generation are equal.
>   			 */
> +			btrfs_warn_in_rcu(device->fs_info,
> +		  "old device %s not being added for fsid:devid for %pU:%llu",
> +					  rcu_str_deref(device->name),
> +					  disk_super->fsid, devid);
>   			mutex_unlock(&fs_devices->device_list_mutex);
>   			return ERR_PTR(-EEXIST);
>   		}


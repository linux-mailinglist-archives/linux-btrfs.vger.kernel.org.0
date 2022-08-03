Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119E458886A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiHCIBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 04:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHCIBi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 04:01:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B604A818
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 01:01:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2737hxbw000811;
        Wed, 3 Aug 2022 08:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BJLrYfOxtpuiWoVCClBGyZjiLYr3ieD8WZE0x+cgQ5s=;
 b=N+2+HIwXWnumXrGJ5Z0V/3O8AvkGngX64FZgrpWndIMHyhYPy0qAWBEHNGnQFYlToDJy
 xoYMMfP1Xch4xn9d/YRxxLaHLW9s1R7wFtWrdegvx/X2Kam1R0oySNjHzyBINfarbLDC
 FIuWa8uEVuWpK3u01ABvpxVn18f7F2JjyhxfgFem8ijyz6z8/cJD6YJWYrxx8pkovpxZ
 vZNoYwa6xquqzJCERJCRW1vxMqQ1ThzTOpfaqQHJNQ9aSNgcHPYV5abglmJK40ASA9q4
 UyqpOOWiV9UNlhyE4xDK/7WoupWjW6Vaf44fiNknoLGRUGQZ1Cki35V8cGzpsSdRFf18 +w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9rwtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 08:01:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2736k0jI007361;
        Wed, 3 Aug 2022 08:01:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32u971-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 08:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COOpZh1ba8aFSDX96rBAg4WsC3z8/BkpD0O7h59mdXUnZSl173M9/b51rGp2iLiw/lYFgseYM2lEcTOtG7IhPkJyUeeU4oFE6oFLVi+ZRMPaRuW1jvr65FuRfHKrEcDSPOKN4PIorSEp5dXHmL7F8qv13SXRRv1mov4mPa/KVoCFXoDDc5ul815wd8t/N+QFXusBZYwsvZu+0WnrA4eLGnVNXWP6AawEpBZB1zUqCXCZRcJ72xUg2sYSJcVgmo3GR7VMWl78CA21UQVLXb7iSvn4OOvqVDjl2Z8RzO4kf9PTPh0cdDTNIMo9E/z4OMqSuuUMkhM075gwdzUcwztuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJLrYfOxtpuiWoVCClBGyZjiLYr3ieD8WZE0x+cgQ5s=;
 b=ZJFh/Eev5keCZDiqLH4x1nJwZSkNpJN2IUE8Xcpb4XvEW9sVMviYcySheJz9/czGgYn35jWO+flq+t9O1wUlyHk3VSgNa9YGAYbYiUlOqxfxcrx9GPOC/0Xr3K9ID2LUl3VF/rm/c+w/mRCma+sZEfNf4a+Mbu8etiJmZRoOajXsr9/DvirZCgiLbo/YFYJsJMP/VCwF1ZlZBtD6dLOkD6UemK59i4edCA+0ssti5R2nxnVkDNc96wD+l/VQPtdM0G8yrajTeVpVqlVV/eFHp8UywN1PIdneaQsJLYFqYfCShGMB7JKVxpZKddCn7a546THfitiWgK5Kv3Oe/mODxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJLrYfOxtpuiWoVCClBGyZjiLYr3ieD8WZE0x+cgQ5s=;
 b=uDL7aECZWYutSa+AcAtAxQWHsrXWJnKX5ArFPCvBtjCB/UgFoGG8gjx6Ru3QC6q9dl6tw+z/C8HL/YRiCcaRvdNuJSclEwciE3mrr51FGhXQz3navQAveOTs+9tQW2P+8ErCOHgvIGin8IJ7KDO9suuT1dPYv8ss/DKvKsztiPw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN6PR1001MB2115.namprd10.prod.outlook.com (2603:10b6:405:2e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.13; Wed, 3 Aug
 2022 08:01:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 08:01:30 +0000
Message-ID: <1e1a6e01-da6c-a82f-1606-6e548451884c@oracle.com>
Date:   Wed, 3 Aug 2022 16:01:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs: sysfs: use sysfs_streq for string matching
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220802134628.3464-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220802134628.3464-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75b5fb9e-f32a-4f53-b782-08da75265f7f
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2115:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8K0+bcYlKSe9bWOTdZRKWgrwNgz6+GKoeEa/A2fgSiUbHWCMCT3GQzOF+x/b5NOmpBCLUvdsHTybVgKvayspcqt80LNtGEOkCfxd0uzI9wsOsT0/gW9V0GkAWa1nxy/1QSABoBgve10KvljT9HjBbE2xvYsxKEDhkSpCxdTe2lr15bkIAUYWVD+3C6SLW4+x1hr8YD8mQm9aOmLR4KgoveUHj4WgRng2qbT/1MEnSSB9JLOzHsYyT1Mejz+8Am3Ho64F+qgCEyG1+4Ci/s6z5hl+k2KBHVaggrF4Dr9KVsUL5C3DZGP8L/jhEQz6o7z6JylE7HeMbLP6Z5Rs0PrbIza/7+jr0dcppO6dRZAN4W5Ma4Y2nyNE7lUTlre+2cjqWAUDC0B7wbApvAV95HPsZXGkJwI7KsFWeFZycgVISIHtAiom6N6K9TfgUSUaohS6loghq+9upJsPoLX+L11CwDeBmLDAQf78Oy+hivcigCAsaX0xs0lJO74t61mGUjXOmiLygUiSIASYB3SEPGS0nSil6kDZKoSCbf94fP7VPo2/JFAYOLuVJrRVIuP8JTBkBmr6/CDQh/2XahsmXRsVgnZpZ6wRVi47VL9wlhaajtBOMZTWD5/2RJJ1KmjIEFJsb/7Z4yBOAQ/Hn7rwjI8jMRQLdiu4uI4RNGpuT0NgRXZpFHSjFJ9dDaEA52iw6ZJ5vwvJLHjojI00gJO2EC5Jh1LWTX5YcvOhe1t8zOph9wHKXn96yDwVR6nUXgLdiRVafLa2ie+j/mbFxdZ5RSq2O+qkVcSNC0m+wjx+scCPBWwYicpM8OZMbEEhpB2A5LRg0oHDsJFWESbf5N04J1FJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(376002)(346002)(366004)(36756003)(83380400001)(31696002)(5660300002)(8936002)(86362001)(8676002)(2906002)(2616005)(186003)(316002)(31686004)(38100700002)(44832011)(66946007)(6666004)(6506007)(478600001)(66556008)(66476007)(41300700001)(6512007)(26005)(6486002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tzc2aFZjcnJ6ZllPeXNTaDhwNFVoOWFqUE5wbnI2a2V6UGU5cDBWejV2TXdM?=
 =?utf-8?B?U091YXovd1JhYm96M0R6dmJOT2lmdVFkQVdFWjBUcG54cUlUV2ZiZnFuTHk1?=
 =?utf-8?B?YXR3MmRnRnJjUmFDcGhxTFZnVDZMdnhpbFlhR2pUKzVPVS9NUWFkS1h5Rm9t?=
 =?utf-8?B?WCs2Szg5a2pwZEIzUnNtTDN3MHA3S2Jycml3eEszY0VmQWZiTnFwMThSVnZy?=
 =?utf-8?B?Ui9xZzFzNkhZN3l5Ri84dlhmUjc3eEJvd3E4MGt4VncrZ3p5cStWdDV6U2x4?=
 =?utf-8?B?eUJxOGJ1alNaTFo5WnkrTDZsc1pFU0lDOElXL290YjdnNittSWU0ZGhsaWN2?=
 =?utf-8?B?YWRKcWNhMDMrdng4ei9LbFExY2ZwQThpNXFtRWN6TTRuZ1NEVWR6bGlteGZC?=
 =?utf-8?B?QlFkUWlLSGY2ZlhxMy9yZWhZY1JwQlhzOG5YWkJlTmxJVXlIb2xFVzlsSjVk?=
 =?utf-8?B?ZUN0UXJUK2NUNDlqSXJVNW9DMkJPNUtvdm5CZjBpbm5TdjB6anhDZUsyMWRF?=
 =?utf-8?B?Nis0ME83SmF6YUlLemJVczFSdHdTclhQT05ucTFmSHZKdmV0SndST0dxTklz?=
 =?utf-8?B?SVVycWptbkh3RFZTSHRYc3R5TmpkUkVvWlBVYkVCdjJrRU12UkZGWkpRKzNi?=
 =?utf-8?B?MEsyMklNOVR3N3I3aEhNbjVaajd4MlVETUQrWW5KMmpkUWtpS2NTQWVkdVFO?=
 =?utf-8?B?K01PcmNPUVhNUHJ0Rk5UdGlUWk1LenhScnh3TGs0NUF1WEVvRHdOWUVwVUdv?=
 =?utf-8?B?bnUzK1dGazFNWjlEMGRGRFhXcjlmU0lzMit1OVJmVmhRc2VPTGZvUmJ1dXpo?=
 =?utf-8?B?NmZMNzZ4Q2VNVWxJM0ZJWSt1NTArU3JNdEFMT3pzd0N2NndGMEVBUUhRaVk2?=
 =?utf-8?B?aVVEbGxrbDhPbFBTNGZzUTBpY2VXa3V2U0dMZGdURnU4ZHdjM3FMK1VseGNa?=
 =?utf-8?B?aDk2bDZvTFhSYzhWUnE2MnJ3TFB1dVhMQWliaSsvemNRd3ducCtMeU1zbFpH?=
 =?utf-8?B?MlEwTXBjbzdRL0QxcEl6eUZrOVNOUTlsM1JuS0dEeENETXM3Y2ROYnpEQnBJ?=
 =?utf-8?B?VE8wUzhOR0toY05MQkhGOTJGNHdJZzdjZmxNMFdiOUxkWXA0K28xYkdEajJU?=
 =?utf-8?B?RGQ4dEQrcFJBZkdRNjZNemh1TUpmdElpNTRKYnV2WFJ5ZWc1RjduWFp0UFNl?=
 =?utf-8?B?bHlLN1FGbXJRdXNNWXRudEhXcHYra3dSZTd3TzJzV05EOWM2d3BjZXpudzJL?=
 =?utf-8?B?SGVsOGVEWFcwWUlsRVp3czN3cTl4clo0WXEybW1nNFJyNWNJSXc4d2JJS1o4?=
 =?utf-8?B?K1VBcmorUDNtTGcyblljelMzcUF5bVBwcTZYdzMzUFZyWW5PT2JHclBabTV0?=
 =?utf-8?B?ZkZ5Z1Z0bytZZWtTWUZsRG55TTRIeGQ2Z2sxczMwTHRKay94WmpqbzhIaGg1?=
 =?utf-8?B?L084TDFpb2sxQ1F3RmhBZWc0MHBZclBUNDRsV1QzdldqeU5yVE91S2pzNE11?=
 =?utf-8?B?My9ZSWp1YmEraXNMb3dnRHRlTVRlWFJ3NTc5eVRML3AvNFI2Vk5wc0pjc0Nz?=
 =?utf-8?B?YnAwaHdiUzBNM0htaVNjMTRkVGtwcGFQcGprK1RHSW9OdWJ0Q3VyUmhEck9a?=
 =?utf-8?B?MytjNVRUeUgyOHY4NHk0VVBhOE5oMXdtMFh0YVhuRWQ3dGxmSzhyYUxuOWZa?=
 =?utf-8?B?REFCU0FqK1NpQTk3NE9iNi9LbDRrY0I2RWI0eHV4dng0UGZGd2ZYU3JFdDFn?=
 =?utf-8?B?UWh2anN3T3JGNjgwU3pJem9PSUJ6RGRMMTQrZURCaXUwYWpsZ0o3OEJNTVNv?=
 =?utf-8?B?bVF3NG1SUEhRYTlyVi9uS0dMZnYwa1ZidnFTT2Y5RjdFaTJWYmdSakdCMW5I?=
 =?utf-8?B?UW1mNVVMR3o4QzVCSWVWSU9hdWI1NGhkY2djdEJ0MDhFZkw0aVVrN2xkQ09I?=
 =?utf-8?B?aktBNkJrL3NLanVwOC83cmxubnU2WEp4QjNrdU1mVjZwUmhrSnY2ckVucFBs?=
 =?utf-8?B?SmVNTVcvR25od1FPTFQyT3ArT1pLRENQTG9LeGg4N0tIZExLVVRnSm1wVHVn?=
 =?utf-8?B?bmxza1BORktad1ludno1YlMvWktzdHM1UStjWXBUZzdYVFJBSHhCVG9mWVQ2?=
 =?utf-8?Q?20EeuKs7ULZoWYsw/6JHNYeg+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b5fb9e-f32a-4f53-b782-08da75265f7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 08:01:30.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHdD1mFfyLHwmUgRj/9FZM6d1u/lCohGs063DQkt+IGFo/Tzus0ZKpZ0YX2ByR93o8Q81obkRY66I1rEa5IO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030036
X-Proofpoint-ORIG-GUID: OU7riXFr3WuMIsEj9HJp3q5yBlqqhcDb
X-Proofpoint-GUID: OU7riXFr3WuMIsEj9HJp3q5yBlqqhcDb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

  We have user API breakage. Are you ok with that?

  Before:
   $ echo " pid" > ./read_policy

  After:
   $ echo " pid" > ./read_policy
     -bash: echo: write error: Invalid argument
   $ echo "pid " > ./read_policy
     -bash: echo: write error: Invalid argument

-Anand


On 02/08/2022 21:46, David Sterba wrote:
> We have own string matching helper that duplicates what sysfs_streq
> does, with a slight difference that it skips initial whitespace. So far
> this is used for the drive allocation policy. The initial whitespace
> of written sysfs values should be rather discouraged and we should use a
> standard helper.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/sysfs.c | 21 +--------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 32714ef8e22b..84a992681801 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1150,25 +1150,6 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
>   }
>   BTRFS_ATTR(, generation, btrfs_generation_show);
>   
> -/*
> - * Look for an exact string @string in @buffer with possible leading or
> - * trailing whitespace
> - */
> -static bool strmatch(const char *buffer, const char *string)
> -{
> -	const size_t len = strlen(string);
> -
> -	/* Skip leading whitespace */
> -	buffer = skip_spaces(buffer);
> -
> -	/* Match entire string, check if the rest is whitespace or empty */
> -	if (strncmp(string, buffer, len) == 0 &&
> -	    strlen(skip_spaces(buffer + len)) == 0)
> -		return true;
> -
> -	return false;
> -}
> -
>   static const char * const btrfs_read_policy_name[] = { "pid" };
>   
>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
> @@ -1202,7 +1183,7 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>   	int i;
>   
>   	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
> -		if (strmatch(buf, btrfs_read_policy_name[i])) {
> +		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
>   			if (i != fs_devices->read_policy) {
>   				fs_devices->read_policy = i;
>   				btrfs_info(fs_devices->fs_info,


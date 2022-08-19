Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77AF59A994
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 01:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiHSXhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 19:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSXhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 19:37:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3629F8A1E5
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 16:37:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JLwslU003574;
        Fri, 19 Aug 2022 23:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : cc : references : to : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QAET3BpwbVIkkBq00vU3h5zX6eL92gmmZUllD76NWlU=;
 b=uWczFFem+vBd+o9Hwkoj4FT6tB0IGFxKA6yC/tjp2zJlR0KImwpQUfo7lWG2rsnpvaOR
 zecJfezEsDs6iuw4nOrfdMzfTvG/kJi0xaGQ4YsHqdyi4yhqU741w4VGuWUyHtFjCw9o
 ODr6xTMbeYTLk8IWxISycoDkKd0aeK+q/9dzC0wMcyg97uPwsd9APThnBZ6S7ORjVBAK
 UHVDpr6UOdv0+X9Fkke7t2UwgYrngWjgaOp4MXa9FmjhUKXiZKEupb/mCfP6VjS4AZMo
 CVVYN+yW+nxrqGrZxlebXGN+7Kdl2T4B/KRY1YPw/xohmJ5oi+4NKtLuak4RTGQdHMkn CQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2jayr5en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 23:37:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JJcA9C026898;
        Fri, 19 Aug 2022 23:37:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c6fq1nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 23:37:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YurvCvf7ei8lN80VCtHzZQlaEtEy4vzksgbWwe756KtDhfd4f5Yui2OQ6KB1VJ3w08IUiazaBohUyPPaVKS0diVqRan2m3KRqUwZS8z7YMjHhoI2jjNZTc600TefsqJF/pMkfTNe6CdwRFPMQroN0eRzeT38bnh/leQZ8T0gl7Ad8rWA8z3+LMiG9ZGogyD8KRHj+S0RxBDNDdmynYBmcrj2rQedZnIYOzDJ901cCPILeIitCJaUCCr+ZuELJ6bqYmYEoSVZhm225p4CyIkqJ8N6zfRmY613kiJZlqZCd8bm9MfFgoDZtq4Wh+Zx9vDTNRSkq/P2DeZI47C7p6v/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAET3BpwbVIkkBq00vU3h5zX6eL92gmmZUllD76NWlU=;
 b=VJMalg5f6hHarHECa8kizIbEbguwwnTReAG6ReScLz0RDdWplrKHMg39x86ea0iwudv386XyQ0l8h/R8jtJXGmMXUugkecHzALigiVvhUDyEcdHbDNTFhDJc1iZf1YJLvRywQd2ZArfSBCk/TbrQb8Q5F210RaK37683aE9hC69dZlmyJCvecwdzmAd8ETeab+vh1lw6HswlKTLrdz9U2wwMUL9LFCHvsy5VLzSMLfNZsRTlKiNGPCjIURWeu5PVkhuUeN4E1bCBjczuHqyPsqULmVcuV7SE+GV4l+GXLWl2lnf7Id8LJ7QSDUYcLTQnJuA/lRi9GGqZ223p1L4Lvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAET3BpwbVIkkBq00vU3h5zX6eL92gmmZUllD76NWlU=;
 b=L9LPHYZ9Bf4bMVIPWViUcubNsnsbqDJ8j9+7GZJBQHTLUYdM6hwdorYt7JVYm9lyGihICvYCWNl5I4aeuNzdW/o1AoKtZyokjt3d9+4I0+Z2rZGiYqRYF3cu/DyobUz8tCdKmC4FTim4FqVGBgjOeV8pziJUy9JPFcqcHEwQwH8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB3100.namprd10.prod.outlook.com (2603:10b6:5:1a7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 19 Aug
 2022 23:37:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 23:37:41 +0000
Message-ID: <5fc0a3d8-d9e4-8b06-0544-c7e4a90d775b@oracle.com>
Date:   Sat, 20 Aug 2022 07:37:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 08/11] btrfs: split submit_stripe_bio
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-9-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 879c9ae9-6789-48ef-17df-08da823bcef2
X-MS-TrafficTypeDiagnostic: DM6PR10MB3100:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAdRL2FagrDo681OI9BYpQxa1931Ye5Xmu+enCt8F7LOm9XN3Wn5QFhTBdJMR277UqUu/wLTC0cbVwVNyJdrxfPBui4gpTJKMagZYIFbOyNK6GPmKNBnOsm6GC+QfT/3KbxcPKbylEd9mnInaxYwQ9Z3W4gpnPteXBLct/pg0MpMWGEjpo34GvX0MXltPVcLkfydlljjpqG0jI1Esq1DK9L8P+SBLbtfQbtYIBCOu2Xh/6F44nF83ach2r1B2AfjSF/pSP0V+55N8OVYgPZBk6MzjNkhGPB9Aavv1gOQg2QQgOyHVIR+cqASIyxS8PIo761M2OdaifazSnNiq2ycxPhIet8QDgQwld9zWfz39Qig/+8fTPmm2R2bDyCtCjS04jvd4cPmIktZYiXVG/RShDMtfMAWjBCCMXroKOJz+tapuV13O8GHLz33zQksFa9Ok8zyoEXofYO2kJYk8KA4X1L5g806onTT8JuvC+W9tC4MQK1Umo9ecK4VK7FZDiN8mrDSlnb0bfMYHP1fRHtMy4Ett6oq6StbG27W/YmuDUiZwhO0wTTj8ApRu68tKZAWs9Bcvo373KerZs7esl871lXcc4KMrRW5+obdt1YBDjPPLf9WwLHje6k1tk6hAFUZh8dk0KETqqwBXLeNH+GoYgtGii3GSwCyRZgsy3CdNY7AVN/9sZeWz3it1q0l0YIDKvuCj7ZnRvmvdbkyEKjOTHy8A4qKoLDT5M7+NieR0sYHvOjQzuR5Oj5+z6Ymp/3NnHoefaCGOlvwfplRwR9ZsZ+S+lQZuRWxDaEbteATP5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(39860400002)(366004)(346002)(4744005)(4326008)(8936002)(5660300002)(44832011)(6916009)(54906003)(66556008)(66946007)(8676002)(53546011)(316002)(6506007)(6512007)(86362001)(6666004)(26005)(66476007)(31696002)(36756003)(38100700002)(186003)(2906002)(478600001)(2616005)(31686004)(41300700001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXRNQTlLUHYzTkdjTHV2L3A2ZitlSVI2ZWFuemQzelRxMkx6b0xFMTlUZS9B?=
 =?utf-8?B?dHBVSzBXR1BpOUs0REtXaEdhdDlhem5hZjhBTDVvVUMvdk1iNVlsMGk2MXF4?=
 =?utf-8?B?Z2tNL3EwdmNZb1VQOUM0T1A2Q0xtY0dDK25ZSU5BK29QUVhNYUwzbGthalFJ?=
 =?utf-8?B?R2J3T2JGRkgvTUxwamRBcm5sdXVEcDlnR2dLdXg1YmtsTEpVNkpzV0xYZm8v?=
 =?utf-8?B?NFd6cktxQ25yVkF0VnEwekNwSEQ5anVIRURlbklURitNMjVZcDJMYlM4WjNv?=
 =?utf-8?B?QnQ2V3YyWWdtU0NEd3RaTTNNMEpGRjZ0VXBEdjN0UVR2aHpqTFFuaUhhKytJ?=
 =?utf-8?B?NUpoQW15QzY3WU1nQXQ0cDhjZWg0c0E1VHhyUnNmaWJBcEg1SWpVOStjN1lG?=
 =?utf-8?B?ZEZkYzE4SXBQTjVsMU8ySjRwTDYzVzRZZ3hNc2RzZ1UwemdUcGJhQ1dMSVpH?=
 =?utf-8?B?RXJYUUlkNGtBVjB2QlRKOTlubjVRcmYrT3VpRnFzNlFObDVLOHdaNU1hNGhH?=
 =?utf-8?B?UzEyWjBhWG9KN3RWeUJiWkQ3Z3VhQnRzUVJjTlZNU241aGFTV1lSd24yTmlk?=
 =?utf-8?B?d1RHV2VHa2JCZ2ZoNTFycEZLbHk2RGlMdGtQbW1Da2hYanltZWNkZit3eU1z?=
 =?utf-8?B?dkE3bjI3b0o4NEhmOHFQeVpaaFNSQVFUblM0ZE45VlpwQzI1dkF3V2ZoWEhr?=
 =?utf-8?B?V1FaL01IUHNoSjhTdWNRVTFZODl4MXpvREtKREJobVRiMTg0SzZIQ0ZBalZw?=
 =?utf-8?B?emFvaHV0NTZYeHR3WWxuUkpPbG1EY0xseFFyZFdVQ25sRUYyQi9rb0ZSN1Bx?=
 =?utf-8?B?MXpmTkxOTDlVQTQ1c1pTSk1GUzkvZGEwYmtXK1dOdEg5cExZRkN2VzZaUEk3?=
 =?utf-8?B?SG1iQTFYT3puaUEyazh6cG1GZFVYS2xBbTlkM09vN2g4R0tDSVc1Tjk3OHpX?=
 =?utf-8?B?RGdEOUE1VkpsaEZLbVB2Q0ExakIzQU5sY0NjUkY3MXJkajhXQi9lNWVsWm9r?=
 =?utf-8?B?dWRIdkx6ZVBab2FDc1VMckxKZjVuWFVkNmlmUEN6WHd2eUkvM3RIVmx5SURt?=
 =?utf-8?B?aVpoQjBBUEZXSFU3MVlwbzlYQjRDSzZmczRMMlAxWnBOUGlidm1MZ3hZVG9E?=
 =?utf-8?B?b2l2VUJkelNET2pnUS9vK3Z4RGcwdHI0K0g1cUVEREpMTjMxNnd4RUkva0VQ?=
 =?utf-8?B?OGdQZW05Y2s0Q2pVL3dmamxWa2FvYkRNR0JGTDlQdHlrTFhYTUE2R2VIZkYw?=
 =?utf-8?B?QlZkZHFBQzlxK1d5TFRUcmhnK05NNTdjc2Zjdzd3WnN0cndnV25oeVVFNXdT?=
 =?utf-8?B?c3U4bFF3UjNDWTFPMGtuY1dZaDJacVZKL0xTZ1Z1QXNPWGR6Wm1vTEc5UzJn?=
 =?utf-8?B?ZDYweFkwN0NYNEl4ZUFJVUpVbkp4TUZOSXdwOExrMDJMbDVQQzMxcHhHN2Vu?=
 =?utf-8?B?Z0d4VmZaZXRsa1dMOHltN0VtN2t0WDFmMWJQWkdzUmJ4M20rUy9heHYrYmlR?=
 =?utf-8?B?KzdqdEpFRnpPcXFOcU80Qm5pZktEaXpkdmxVRDZkaEVlYTNpcmczc0ZpK3Uy?=
 =?utf-8?B?U3krTi9BR2NXOWt2eGplbWpKVGRTMFU0a1RzODRrK0M0c01KODIyV3ZINkdQ?=
 =?utf-8?B?V1JPU2dGMnVYMXBoY0NEQU15aHhJamt1QzFHcXhDRFdSdGNGVHRJZ1hnYTFQ?=
 =?utf-8?B?eTRpdGhPSEU2blR2ckYxdDRTOEtBYWpiU1IzWjEvblJ4U2dTRkVoU0pOcWtv?=
 =?utf-8?B?QXIxTndNWkszYnNBbmk2RHordzZ0WS90a1BKTHBmVmx1c01jUTQ2RmJzVDYr?=
 =?utf-8?B?TDBZZjBwek1rN1JpSGVhYmMrYk5lUmFkb3NoN1FqZHd4a3VWdjl2bnBxYWR0?=
 =?utf-8?B?eFdybXl1VHhjUXRCQlk0eUd3S2N2alB6WkNLaEFGRDVFTG9JdG8vbHJMVnNq?=
 =?utf-8?B?RG5tc2MxcDlidHc3WXYrcHU4WjVwcEp6TUE5WktrRk01eU91NkxpYXpUTHBW?=
 =?utf-8?B?Qzk3SGZIckJBSjRISXVzK3hybVp2VE5HdXNRdWtyZWlZQXlxQWVMaDF3aFNH?=
 =?utf-8?B?RmRsdE4zTC9RRXRoUDA5a2pTc1lGdzh1bVV5b244eGpJejg2aTE2dGljUFBi?=
 =?utf-8?Q?eZoo1oOHlgqBgc6P1Wgc8WebV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879c9ae9-6789-48ef-17df-08da823bcef2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 23:37:41.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVRekrHroctbPhsipPCwtd6ek7GO3tMH8kbiDA0uNulnUd9OGSr+/pKMaZlvB96xCdFIR/jrUv7Ne++uWDPSpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_13,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190088
X-Proofpoint-GUID: pXof9eVDiGBlHiAC1guXYmmdg7G2mkyP
X-Proofpoint-ORIG-GUID: pXof9eVDiGBlHiAC1guXYmmdg7G2mkyP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/6/22 16:03, Christoph Hellwig wrote:
> Split out a low-level btrfs_submit_dev_bio helper that just submits
> the bio without any cloning decisions or setting up the end I/O handler
> for future reuse by a different caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> +static void submit_stripe_bio(struct btrfs_io_context *bioc,
> +			      struct bio *orig_bio, int dev_nr, bool clone)
> +{
> +	struct bio *bio;
> +
> +	/* Reuse the bio embedded into the btrfs_bio for the last mirror */
> +	if (!clone) {

Nit: Why not as in the original, as below?

	if (clone) {
		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
		<snip>
  	} else {
		<snip>
	}


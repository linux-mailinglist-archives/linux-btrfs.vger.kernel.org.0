Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC76539A8D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 02:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348849AbiFAAzM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 20:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiFAAzL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 20:55:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C974DCD
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 17:55:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VNxORg018543;
        Wed, 1 Jun 2022 00:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BiIvGchoSsDnFUMVB4i37pzcZhRgS5HjpIsX5evLFpw=;
 b=09+fT11Vh7g1sp5+eYI0T1Hz/r3+rYO/zzgM4c5kpp5UWVCJ72yx8ZmqtUuJK2logqSI
 FyufBFQcqIFnY9hfQuM+YgFOmVPZbePPEcewlayoHN1m1YzBRhuONmL3TsgGhDEosG1S
 nVHEID2xQ1dB55sOLIWV18he0muFa4DxXGlNE+haoDXfHStOIarmIg5n9mPPwFgemEvK
 4rrIyCJt5VozOJQopab6lhj66TO7xFzdQr6dfeoibon9SnFhuLGk1f1wzE24e2WHxN2o
 S8WZFCNfRY00cUwrluRAHf2dY6IZBF+UKhrrxRiiWH9JtP3Cc+xIj/iqb4FbDEXr+nK9 eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc7kpba8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 00:55:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2510ptn0005523;
        Wed, 1 Jun 2022 00:55:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8ht6qgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 00:55:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBs0LaxW8LW2RCNVqm1eXRXNNlKXT6PBUZAJpeXsYNUyXGTi6Gka0WXEy4e1oglR/GE/loSPE3gar5URZ18rooiTMsrwNWyS66W+NunusLdx4Ysz+vBVo2KHBED0W5CC395buFZkBu6XLhpDsW8d0f5BJH2wGLJJ678okAfTTUxfPQZJC25XtNgoVma5heTl8qADew1pTJGJhT8pRTvVANFX0utmpdGfPLkbGyEKeYmwkB/6JC7ofvFU+K4eAIMbSjX0e6DLCLudklrzInLsyH032eScQmmc6wOrCZbXwv0v5L6RkD1Pf0PeHODf1/QvUnldheijGsL6mWszBifwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiIvGchoSsDnFUMVB4i37pzcZhRgS5HjpIsX5evLFpw=;
 b=h6MAK0YNDquirJDhCfxOytnXpQLd6q+930yv9Cwqajp8BshB8oXzIAS4jK2/+diIzrQUPrBftImDkThvhbwt8wHOdu7ww/tPoG8iBcCLWQwZaxbjsJV+wL3ifSJa5mFYTErQXzyQ2Gylg8DPcUgqOLxEONQ+LXCjI5YTIurq/oqPqDKyCtUr2oeJnF/Ygfc+yiVTSKcYEavZ1+e7ueDN9pZvQX1mZUJWeZsVtLumhY98f2jXAV3gJPm24k/oaNZvs55/JCxbDsh6beN1pImxQR2CsMbHDxwDn40ZmEXHQG0Agi6jzq9uq9PuMJGkKYsdqg/RulexvqRVKIppiT4ZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiIvGchoSsDnFUMVB4i37pzcZhRgS5HjpIsX5evLFpw=;
 b=q2dlj6Ak1MtId0ixngFART0Xjjr4LvthEJoQ6Z/SMxNA/6IMHaaUmskgZMkZbhIEJy8H0pSB8uAsiVJI9YkCN3EckiJKHVK4gkNbIsz8RzQua1lyjMdtj0/7FjhanfaihFF9aYPCLsaqrCaQu5bon1r/CEF+jcEUKZss1zUencs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5282.namprd10.prod.outlook.com (2603:10b6:208:30e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 00:55:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf%3]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 00:55:03 +0000
Message-ID: <770f348e-71f5-710b-df19-a74b674ca943@oracle.com>
Date:   Wed, 1 Jun 2022 06:24:54 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 03/12] btrfs: balance btree dirty pages and delayed items
 after clone and dedupe
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1654009356.git.fdmanana@suse.com>
 <85eaa822185641693e99a9291175c0a733694937.1654009356.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <85eaa822185641693e99a9291175c0a733694937.1654009356.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ba93250-62d9-46be-1930-08da43695cbe
X-MS-TrafficTypeDiagnostic: BLAPR10MB5282:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB52826121BA3E4223A927BAFDE5DF9@BLAPR10MB5282.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAv3T9YPj0p6tKT1g/rWQPD3NO/jCCh4MCZMJWFI4E9HOh7b7JZOM29QwZAbPw/3ynP1iw9s8IWxskh9zgzPeG4lICChHycb1MfxNSxHj8ZmWjgZ11gxCnCoMiJ9BzJKMBENLEavAOmy4RNLF5mcIHzB4krqRX9v4yqfACQsbxuS+6Uh5Tx3xBRqzINpks9gTHo1qXfbEYbhwJ8wBm/Kk5p+18hGYYxG3Wd7Hekmmi/ssJ1kXXTDBUlGdvJwJJ5BLuO+zqiFY0enN4DwiSmJDmDuOMgAfZ6cGr3BqriO84M3LDGZluwqbhwvF/dsuoP3vqIHEXdKTOaJl+hf3IlM3+6ozlzGwUm6585SIB1rQ/pNYc0uOzXKEkhOLStg3r01giefU4DpRWkmYkTwcOAdBo1vNaqnDFr9I2Ii1NvrYyxc6mPJn8pupg7lEDNsrw5bMWNKHvxEWBl/u6LBKdn4IJcSl7TN8p2CMwp/hjc7GJW9Y/6KnXN4kkoYMmZBZ01cwKP8Szt9sZAL8PlrLHM61mJCofwN6m9g+2w6XMArDs6A9l6l1814XWgDVcrZvnu+PpUfqrsHJo+gBFNaq0h5KPv1iKvzLpOaO40cIa8BmEMCxB2MFktFJUh7johVhzlQCnalBBLUT4v9So6GGumNeQtLGJcRrxR0/EMXrP0ftvsb/edJ7ggW0pfleBPPK5PhKVoX7a+8pl9iXzgc8xLz7Yv39ZomSE1+zmX5lAhVU3y5UiiKmFkwbM+h/v3/3RL5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(508600001)(5660300002)(8936002)(6486002)(83380400001)(6512007)(186003)(2616005)(2906002)(53546011)(6506007)(31696002)(86362001)(8676002)(38100700002)(31686004)(66476007)(66946007)(316002)(66556008)(36756003)(6666004)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjhXVDJaZSsxMHFHYTlCQkJ3MGhkb3NkWFVycG5naUJLdzh4QmhYNTZncThl?=
 =?utf-8?B?djVuVXRoVDgraUkxeGlrTlQzVXh0dWxIMzVBM3FlbjNib0tuT2lJUDEyc0xa?=
 =?utf-8?B?ZTJRNXpKa0ZCbHZaMFB2TkpMcjFpd3kzYlIrbUtqdnFrS3dnSElKOFpscDZS?=
 =?utf-8?B?Y1JlTmltSmJkUFNaMUxNak1TWlI3d3E0TC9MNXFHdUQzSnRGcGU4dDFja2Jy?=
 =?utf-8?B?ZlFVSDRDWWlTVUdoR21qZENlTzM2cUxsd1ExcmpXazgzMjR1VHlwc1VXQllt?=
 =?utf-8?B?MnFEWjlPZG9yWk5ySHdkR2s0TEpsRXhWYm1CVm42OHdoOERjdS9yQjE4TW5l?=
 =?utf-8?B?T0o0YzVESHhBOVE5dFppcHlCZFdpQ2hrT1RIdjNONE9pcUZBZFJTL1ZHMjdk?=
 =?utf-8?B?ZnMwRlN3TU9yeTFEc0FTbmtBSFVCQTgvSW9iWUsxNUkwMDBST1F2RjZGWmNo?=
 =?utf-8?B?SUM0MnJSWXVKNGs5aDRCbzBQb29XVTlBM3pYeFd3T21haXJWckpJQjl5R3N5?=
 =?utf-8?B?VWN6RG1EKytQT1dEYmNneDh6b1ZCaitUdWVrUWR3U2ZqcUZ5M2NrSHVGSTRY?=
 =?utf-8?B?cDl6dHlZZzlLUVo4L1dJR0pNYzZXcFJRaElod2cvY1VNMWZqOW0wZUl2MnlO?=
 =?utf-8?B?Sm13SGNKYnpUVis3UVJzSTRlajlwYmd4eHRCbzdSRXRTQTFnNXIyTXJDVHI3?=
 =?utf-8?B?YjdtRHV6RWJYbXpDbVcrTWVLRDdqb3VVTGZGUFZ1Z2lvZDVlTzJpS0RscmxK?=
 =?utf-8?B?ZDl2cy9uSVcrZDg1SWhsNi9tT2Y2YnZPSFlJTGtFN0RrUkVaV2Jha1JOY211?=
 =?utf-8?B?b2NPaFdrakVjOTJiYUpmbk00UkROV1kyM3ZBSEF2WVFZMkNwZXBPR28ybHpO?=
 =?utf-8?B?VllEZkV5ZVBzaHFyN2xSVVFVaHBzdWk3NmtBWjVFUHg0U3B6THdxSXVyUkFJ?=
 =?utf-8?B?M08rZGFVR05wV2h6Y05rSC9BaUNEV2xNT0J3UGJvK2RhNDgwMkZIa2lGRXly?=
 =?utf-8?B?aUQzQ3Y1UW9tbFdTRTIwWHpLdFk5VGtNaDJIbzdaYTZabHp6UGNpUzQvYzFq?=
 =?utf-8?B?aUZXMEdEN2RFMHNyTkpFZ0FwKzhnN1dGdjE0Q3Q5RW5oUFhPUmpWejEwOXNX?=
 =?utf-8?B?Wk84aEZMRGlOVGovcklud1lzWjhoWW1qNndYSndrbFgrejBiRTdXcEVkbUNz?=
 =?utf-8?B?djdwL2FkdldjMDA5U1ovNVdBZ3hqcjA5cDEzVU1aOHA2OEFha3dXZHhXM1A1?=
 =?utf-8?B?bGtJT3RLMURSOW9ZbVY3TVhVVW00d1pWRGxBczZST3JEV1laSWVJUEZRbU8x?=
 =?utf-8?B?aVBmaWgwbTcyTWhkQjFZWXRUNUVvZDBVZ3NzVHgvdXRSVHUvSDY0YjZ1Y3B6?=
 =?utf-8?B?bjAxSnpYVmpOQnl6YjhwK0ZYcjVDZTBJM1RVTk5aamx5aDF5UHhPenZ2Ym1E?=
 =?utf-8?B?cGg4ZzNWcjloSlB5NVYyZVJsVlFtVWV5eThGeWZlMkpKRGhsWTZnanZpcktX?=
 =?utf-8?B?MEpwdnYwYkRUcVVUeVFjVHFFNll6V2MrMklXTnNlTXpsc09TZXl0S0pydXZ1?=
 =?utf-8?B?ZktwKzlsOVl3QXZ3K1ZrRlRLTlFEYzZxdU9jR2VCN0pjNFU3Sm9OMlZlSXBZ?=
 =?utf-8?B?TlFjdmsyUXNGTGY2alhRRE9rd2VCbU92enA2WjJuNUlPdFdvZmpGSVJBNXlu?=
 =?utf-8?B?OCtENFRsMTZJNWZvVGVJOVVrSWNoa2Q4ZmhUT0ZRS0pmOW1FcERVNkRXUm9B?=
 =?utf-8?B?RUVhSXNmQVQ2TERnUlE1bVlCQWtZdlhock4wM2ZHV0I0OCtpSU1ZaEZ0N3Jq?=
 =?utf-8?B?bEhaTlRCQ2FneEVsbytpN1ZxSlVZajQ2Y1NkSEU0Rm9ld2E3Rzc4REMrRy9D?=
 =?utf-8?B?cDJBMDRyV0txRUE4SUZFa2IvRVgwbnVYL3dRbzJkMjV0QXY0MlJOUHZuQ08x?=
 =?utf-8?B?TnhmQmZTVDJBY1lTMkp6ekdUVkhlYUduRUJWSTRNZ0dOOUpmM2hDUnpVQ3ZU?=
 =?utf-8?B?VzEvRzZadWdza0UxYzZaVzdqMnBER01Ia1RLVWRyRlRwdGU1OVZwT25JM2xP?=
 =?utf-8?B?U2ZLTzFnaVRYWGNqdzR6dWpqejB4T0crRFNlSEZ3R0ViT3paaXd1bzdLUXpF?=
 =?utf-8?B?N1J0a2pTdS9jd1JrU2pSNGcrMnNjalF5cFBDZGpOR3lCTGVtT0pQZGVSWXVY?=
 =?utf-8?B?QTRvdW5LTEIvbjFtdlVDcHZLYXBqbm1lZU90azhyRWw5NTBVMFZ5a0FEa0d0?=
 =?utf-8?B?NE9FM0VZdW8yWnVFT2gwLzFYZGROdHVSQ3FROXdpaHc3NmFLZTZWMWExL3hr?=
 =?utf-8?B?VCs2TU8zLzMzUWk3enJXSE9Zek01R0d0OG9uSm82enBWM1VLa2lMTVljOXlR?=
 =?utf-8?Q?FfNEyb7+O1DsUOYeuiMfp/RiugTORcoToWQiiyd/SNO67?=
X-MS-Exchange-AntiSpam-MessageData-1: S/a6zNXj2UpQQwI2SGVyLpGztAXsrDGQAP0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba93250-62d9-46be-1930-08da43695cbe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 00:55:03.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnRjKv/4ZybxVIqrYtPfKS/YpylsjKGNbAUf1nxsMY5EsMyQacbrM9w3kcGfKp4Vq7AGXzZUNiuSYOc4PCpz9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5282
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010002
X-Proofpoint-GUID: jdm-_M9aZtgyX6ERnbl-zyu2FVZuJvPK
X-Proofpoint-ORIG-GUID: jdm-_M9aZtgyX6ERnbl-zyu2FVZuJvPK
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/31/22 20:36, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When reflinking extents (clone and deduplication), we need to touch the
> the btree of the destination inode's subvolume, as well as potentially
> create a delayed inode for the destination inode (if it was not created
> before). However we are neither balancing the btree dirty pages nor the
> delayed items after such operations, so if we have a task that is doing
> a long series of clone or deduplication operations, it can result in
> accumulation of too many btree dirty pages and delayed items.
> 
> So just call btrfs_btree_balance_dirty() after clone and deduplication,
> just like we do for every other system call that results on modifying a
> btree and adding delayed items.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

LGTM
Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/reflink.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index c39f8b3a5a4a..c0f1456be998 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -5,6 +5,7 @@
>   #include "compression.h"
>   #include "ctree.h"
>   #include "delalloc-space.h"
> +#include "disk-io.h"
>   #include "reflink.h"
>   #include "transaction.h"
>   #include "subpage.h"
> @@ -650,7 +651,8 @@ static void btrfs_double_mmap_unlock(struct inode *inode1, struct inode *inode2)
>   static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
>   				   struct inode *dst, u64 dst_loff)
>   {
> -	const u64 bs = BTRFS_I(src)->root->fs_info->sb->s_blocksize;
> +	struct btrfs_fs_info *fs_info = BTRFS_I(src)->root->fs_info;
> +	const u64 bs = fs_info->sb->s_blocksize;
>   	int ret;
>   
>   	/*
> @@ -661,6 +663,8 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
>   	ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
>   	btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
>   
> +	btrfs_btree_balance_dirty(fs_info);
> +
>   	return ret;
>   }
>   
> @@ -770,6 +774,8 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>   				round_down(destoff, PAGE_SIZE),
>   				round_up(destoff + len, PAGE_SIZE) - 1);
>   
> +	btrfs_btree_balance_dirty(fs_info);
> +
>   	return ret;
>   }
>   


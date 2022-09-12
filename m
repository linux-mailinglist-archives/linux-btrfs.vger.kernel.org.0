Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334845B5AEE
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 15:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiILNNX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 09:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiILNNT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 09:13:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10012A972
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:13:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CD3GoV013338;
        Mon, 12 Sep 2022 13:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/7wm84uyAe9nb9idOX3FvFQcOBx3ec+GwHDUKdY1kww=;
 b=GBvpl0lMM0Rw3GnyELIteQdFgpXnvHAL6tiYqc2ebv0lfohIPRPto62b2l2G6XFWy52V
 wzVdEhK6EybC76fL20f/5GncyYMyGcSn0zGImbH7wjRA8wlMm2u53/rL8/1BLUXLBUTp
 wuKlpFFfFKCR0SxsulVsB+AOMQz7cwmwEtQB71s46mnuOKTpAGaldSeEjX3ZFn4fYayy
 63uXfbwVNP+a38zGcQTCQDgUxR/lNNAdX7QujE0lYub/H7v5rM8uTRaGwh6uxyLBSHAW
 SPi20B9eQgNcfDfv8Q/6RP1nMJxl8sa0GzrDUus+7joVeZzPwo+PIK1gPteJxO1pE6BS FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgh0c3evf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 13:13:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28CCEgeN010223;
        Mon, 12 Sep 2022 13:13:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh18tbyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 13:13:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cddDqDbLDaJJLLDdxJQvGFBgoFJ+AKmRWlnfELYnkZPOoWUf4DdV53Y8sBUjeUC3uCpFQ8DV3gM+Pk778W8u7wEcvo1lJmBVSwbAvv4IN01L8MOzc+pJaGH5WSQJBMUBK2IU4JXNM1FfULvLcgjsqAyemB5+7QkYTNih/8bHjacblK3AB0xgUcXnOLtayhbt8IseRGbowYMHn/u2sxvBe+5PF+J+5LvBn1lp5pvAGnmns02ibWXhrG/XrSS2aWnlB7XllAhiMRhpOv1m7rVk8oor8Tbo5l+eXI0pllaUZ1LYa07XfthsgWFi2QZmrayWUm6luYmstd+pF7J+oLg3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7wm84uyAe9nb9idOX3FvFQcOBx3ec+GwHDUKdY1kww=;
 b=I25wgT853/OEA71N1w9ENwyg3l1SrE8D4IaFCXSogx2YLT71PPoCnWMgL8mdqBL6A+RpFBQJQZWglavrxkNFC9z6wz5vrUiV0SyP7YJucUyb4L4OicnG+1kEm6a27ozYjmYMI98AK2YTnzC9PHh3aWAnO10UY68XaWWqS78C13F/nVHnxm8c4YBbgikBzNw31HcUiJvtvxe36q+KIxCwX5hsrvn0jNEMZdeCJXtu9IPHGDJGmSR2kfih0HX935vzRLQIVswHFw/bvSceORGa8VFI0uIDo5bz+5kJ6E4pzIR03wRKQUJSSB52q0glB4SU0wa2Fuf7gJGLakb+A7lqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7wm84uyAe9nb9idOX3FvFQcOBx3ec+GwHDUKdY1kww=;
 b=u6OEPmVivmWVsKl9HnDRfR0hKEyQghkWiNJWJ7+vgmXBFLYMZmcSNNXLky+ad7bVtlPKPZ+cyW0OIG0IyNTAVjBSy3uqN+imIw7wrOf+qNYWzhhd7p6PM5/gj7xO/+QjKVt6tEPJAzEl6BhiTPARiWINGFtLYSi/W02SsJolN7k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6712.namprd10.prod.outlook.com (2603:10b6:208:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 13:13:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:13:02 +0000
Message-ID: <b657d749-4ed6-076b-725b-9c6c7dcc1050@oracle.com>
Date:   Mon, 12 Sep 2022 21:12:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] btrfs: move end_io_func argument to btrfs_bio_ctrl
 structure
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1662963954.git.wqu@suse.com>
 <6addc5a6053cabb5c898cead3b0bf41634c8dd4f.1662963954.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6addc5a6053cabb5c898cead3b0bf41634c8dd4f.1662963954.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 208745ec-3241-40e1-cf49-08da94c08592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrFANEbAV1KVhzCA0nD3muItYE6jnTfAdPr7/ZcmjyflrhFogvU8Tv/97pKSM+zVb0rkJhZeZKSB9kaBL7/Va+PJDU4gFMjYeD7BQW1zjGllOsPP/dnmPWMFwFD02G/iho536ymvBGjRWXknSP9OqEjzYC3mmHfkVcpigV2dVsakUApUbLdEC/+Zc6rRbsbVU+5sMJlD6X7wzTC9K3VcuW2G3Y9MYRYGDHW5gH+4879P1VlH61AM4iOGcMX0+JMX+IAqkz+6mQFzrxJZ0y7qfp0YhhO2u8h+XN8whL75XuC8sCoyOdN3jcGgpStbbv+39J6K+C/oA117HTw5Tc5EK9vxuZVFIrAEYApmqdrgxh4niIk6yLpH8266HqAB9QJJ0ijL3KKRdtX1N+6S+tzDxWXCKITN6qmawgEcXpWHYYZaMgXguN9FzRm/QiJMBHQsrhwwJjuy2/kEXIp9+e3zOk+bFPwg6fVZfjFtsCXkWejsiNDKLkDKbEkziENifNXDxgT8uGfnCLwhSBvu798XXqH0BPxb+vzpZZciX+X2Me+XzF6Qv77GU/Ep5RzKmD73BYLBfK+BypH1hDhDpK64N2dgrecN9rkKfDF4Iu0E0PKnvp9Ay6fN0qjKsmk/Qx2wiDZV4FML+EH4puIKr+fO64VpWf0jpTkmpfoTqhtZvg4AMjknwsvqTD7J6QVTnZZXmdecLuth5h7yVCj1OyUU0F1kEJijfwkfJS5/d5Ofl+fVIBrjmnUXIh9cwOu3MooLT2byPG/pDmDbTzupEsdFo3ljJ7SIDleP1vJC0DGLTD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(396003)(366004)(376002)(31686004)(316002)(478600001)(6486002)(36756003)(26005)(6512007)(6506007)(2906002)(186003)(2616005)(53546011)(44832011)(31696002)(86362001)(38100700002)(5660300002)(8676002)(66946007)(66556008)(66476007)(41300700001)(8936002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2hUZTlmRzNpcm5ubGNWaTBZeTY5Z0FpOXlCV0t1YW01TG5zSU44NlpJWi9y?=
 =?utf-8?B?VzNBUlBIUFRMUm5DM2tMaWJKN3JtRjdzUDVISm5LKzArcXhXWlZqd3lFSzA3?=
 =?utf-8?B?aTE1TGRGTzRtaTR1Um90Qloya3RabkRLZ3RXOFdRKzJ4RmJIdDdieDZkcjh6?=
 =?utf-8?B?bktxYWNhTzg3TkVIdXR6SDhQbE5NQjZKOUlyT2N3T3FxQVVNeUpDazQ5aVg2?=
 =?utf-8?B?Zit3cUgxOGd6Slo5andnWlhOVU9SQmQ3WG5BSUpjdGVLOVZBWnRNRGJKSUZo?=
 =?utf-8?B?bUVSeDVEZnRUWURjcDBrbWhjMWtZbFh4eXFsaGxUeGw1OFdZK2tJMTRTTEVP?=
 =?utf-8?B?NGVtcWJzZHJBWVBTSjRWZ0JramVYZFY4dndKNm13S2pSc24xTWFhWFJnSHVK?=
 =?utf-8?B?RHdUZmtncDRlaExLWXJibkxxZXY2bFVubi9sREJTZnhqMGpjcUlUVjgrdjA2?=
 =?utf-8?B?MjZwYTZyY01CaUxuYlBiMEo0R0dzSEppQXJjQ3hvWllsYXlqSGsxY3BzaVRH?=
 =?utf-8?B?N05GVVFzOEkwMkUrZWZMTjFFMlB2cHJsaEdBVDBuQldvM3h3ZURzWFRKY3Zv?=
 =?utf-8?B?cEFML1h2MVR4ZVVHdmxObFhZZVRIZDAyM0JiSFJtdmdsK0ljZEI1VzRvdU03?=
 =?utf-8?B?M1RsOEhTWUl1cXhoTUNWcGEzR2tQNXdrMVZNYkxJMFE3MVNnUC9WdVdJZU5q?=
 =?utf-8?B?aGNRcVZreloyS2hjTlBJL25RWHI2Y2pVRkNRejUvd0VVWWlMeExmU0FObmxp?=
 =?utf-8?B?aUJnajh0bEdreFBPbVkzR3VRUnE1RjJYUnlQdFpWbFUwbFBBZ24rZGE1RWRM?=
 =?utf-8?B?Rlk5aWFtVVZzVFl0VHl2YlhHSXY0eDlHZzFHWkpNQmQ3UEJlNE1VVSs1U09m?=
 =?utf-8?B?VTY3Y016RHFJL1p4bHB6aUliS3RUZ0F5OXNKVEZEeUo5T2hrcUJIUERSS2hC?=
 =?utf-8?B?dmMwbGpYeUZIMEF5aEJYTkkvdi9RdWxmSTFNdndpNEFhT0ZoYll3MjdPK1Zt?=
 =?utf-8?B?c1Nrb0szcTM0VXJTNXRPaHNHVHNJcWVIY082dlExWlJUUXQ2U2Q4SnpJY2tT?=
 =?utf-8?B?T1dBSmJBUDlobXBMZ3F0M00xMUY3QmdpNGZmZUErdjBsWSs0dlM4aVE0aTVR?=
 =?utf-8?B?eHVUdnI5YjhTTGQyK1N4N2dZTi9iSENNUnFoR2RHVHVxQURlV0xyV1ZOQXB0?=
 =?utf-8?B?TzdmdHhJNmZycFBVOEF6S3JOYXA5WkFnNnRUd3J2QUdUMnEyU05tUGYwZDZt?=
 =?utf-8?B?c2d1ZGUwOFpTdzVvUzNYN2pmNGIwamN2WjR3NXVpb2gydzdSa083RVFUMGhn?=
 =?utf-8?B?cXVTQkltOHRHTk5qYTNxSVJEeGxlSnhuMWNOamduelNEend5RlE3NXNzMzg0?=
 =?utf-8?B?MWdiZWhtV2tsc3JiSytnZXBDSnBXR1lnY00zQmZVTzJEdVZnYk1TaTBlWi9Y?=
 =?utf-8?B?YnBwREY1Nnl1Z011cG1ra1hya20yNnh3YTBZb1lJUjBOYUdLQkt2NVErQUtM?=
 =?utf-8?B?eWhKUTdvY1RJVnI3QjhOYktWSTVtUTZRSjJHWUQxSnhuY053TlJ3Y0VyenAy?=
 =?utf-8?B?QklBUVExZVRwZHBKVWlycE5tVTJ6UkNwZElJeUhRM0pHWFBScUhiOEtNQkJO?=
 =?utf-8?B?Q0hLeVI3U2daUFZETGh5d3dwV2hidFVza3lLeWNiMDRaMFdKSjd4azhRa0Vm?=
 =?utf-8?B?NVhRTXhyS0NRMkErQWlJMUs3S3Jpd1FyRnhnY0RUeUJSdkZmNFpRem5Rakhr?=
 =?utf-8?B?WmxocU50QlpNZ1BEUjF5SUptZ2xSQmVkU1pHeXJXVDZPdDkxcEQyaEZ5VjlY?=
 =?utf-8?B?SVIrZmJaRlc3ZXlEejd4V1haZXBxQ1ZHMElJSW93L1RaTnFzWlE1SWRCRTIy?=
 =?utf-8?B?VSt1bjhwSG1nTTJzV0tVT0FiaU9IVEwxVUpIU2VMYkdNdExVMnZuUGcrS1BO?=
 =?utf-8?B?Nmw3ZmtpMjdvYU1vM3huUEwxYnZiTTRGR1lZdTJUTjRMNDl2RmZUUUluY29D?=
 =?utf-8?B?emo2L1NXRDI0WkpxUC9OcTJiMDFXTDNKOUkzcDh5bVFDVkZJOGtlN0plNWdF?=
 =?utf-8?B?cGFremEvUUxUd2k1djlPdzZTRHRFTEZoZG9WZUJ3aWxRNkJKYUw4WFRHK1pm?=
 =?utf-8?Q?K47Bb0rD+58eT/OeMT/zIB/bf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208745ec-3241-40e1-cf49-08da94c08592
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 13:13:02.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9K6fYeTeHV4ld5I5yHEfwcIThneUO4lXHjxD8Y2DmIQ0WlpL7P2wC31yWo6UM/UfbpoA+7Ze663wnzCXLeEPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_08,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209120045
X-Proofpoint-GUID: S_-OPyTwhE3hfuJx_Y-BvoJfkUXZHVQ1
X-Proofpoint-ORIG-GUID: S_-OPyTwhE3hfuJx_Y-BvoJfkUXZHVQ1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/09/2022 14:28, Qu Wenruo wrote:
> For function submit_extent_page() and alloc_new_bio(), we have an
> argument @end_io_func to indicate the end io function.
> 
> But that function never change inside any call site of them, thus no
> need to pass the pointer around everywhere.
> 
> There is a better match for the lifespan of all the call sites, as we
> have btrfs_bio_ctrl structure, thus we can put the endio function
> pointer there, and grab the pointer every time we allocate a new bio.
> 
> Also add extra ASSERT()s to make sure every call site of
> submit_extent_page() and alloc_new_bio() has properly set the pointer
> inside btrfs_bio_ctrl.
> 
> This removes one argument from the already long argument list of
> submit_extent_page().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Nit: submit_extent_page comments has stale reference that need fixing too.

--------------
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cea7d09c2dc1..3e902ed99240 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3347,10 +3347,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
   * @size:	portion of page that we want to write to
   * @pg_offset:	offset of the new bio or to check whether we are adding
   *              a contiguous page to the previous one
- * @bio_ret:	must be valid pointer, newly allocated bio will be stored 
there
   * @end_io_func:     end_io callback for new bio
- * @mirror_num:	     desired mirror to read/write
- * @prev_bio_flags:  flags of previous bio to see if we can merge the 
current one
   * @compress_type:   compress type for current bio
   */
  static int submit_extent_page(blk_opf_t opf,
--------------


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B16BA66C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 06:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCOFA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 01:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCOFAY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 01:00:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B1C5D26D
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 22:00:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F3NuoV015492;
        Wed, 15 Mar 2023 04:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GYHJJSrjkyI50lvKDCiuCQHVDSeMSuqrX1hWSMMcgKM=;
 b=Ps1xPCJ8Tirrbskj6A+1vqIcN6zlR9voW14AbzagfDL+BsgC/TkUTNcE6vNOqhQL3nDa
 DysQLUTxX4KkuzERAWatkhUu/9WK0yf7RSn381mxLLFdeDazMBxAJZX1rQ1GwwQYHuTG
 1vOAw3FEjUW8G6s0Mr/sLCpMaKV8TupN2hfT+5RRec5u1qnfVbx0zG76qla2J8hfNTRs
 hnZy159GEtO1YTzT749vaF/yNYbirXG2sHOZ4bp4z/1OXoG3DJGqedSFJQm+NUvH0kIQ
 RZz0CDwFD4s4haA9EBAqXjBgugpexZQnuZZPHcj9161GYiAVhzvnYfdzpHcyMYink34G ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pb2c1rdxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 04:59:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32F4mVvl025202;
        Wed, 15 Mar 2023 04:59:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pb2w6sbqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 04:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihEYQpyOGBb50FEFUtaBG2U4mxND7gnvXPMdInmkt+mScb4nRrvGO82KFQiqk79mRRGcwUlkJpZYp8GRutskNf4GxxIRM4oNNIfakpEvF9wueDg4Klr5cqiqAVZqkvL6ZzFCuu2/VcIoQZR6H/ZvOr3jxg4nUV0IMtFe2HqQ3uKZ5BsWu85dOOkpDakADs08R6Yg7i7ku1u8G1gkPgijfRGleMEM9ZFYe9A0A24PpsWorNFKzQPfghCTOoxIaQgQ6e/eCQKa9U02u5GTfKx5GdqC1gPuWDw5ySGTQ1PQwXSl/Qq9NcAbzn+5TZMBUrhSniGnPl9y8YmtfOAPjlFYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYHJJSrjkyI50lvKDCiuCQHVDSeMSuqrX1hWSMMcgKM=;
 b=OHd26oOceE+w9GyDWk96t0CG6BCPW9NY7uwjV0ASqqDBIzlTiSnT3UEVjnH+NHvWlhOQ2YKUmCvfmY3+dblQnUnvrVGXMrNUmPtDClKCAd3DAQR6PjeYbGkLZvd4EMQArBK25GGmxLnmBzVu+8fxUXlxvhwgZuOPqsnw2yxsAuRxJ01NOXz/6dxmVzUi0r+/TbuWcWx57+19M8PDzzwghAR3XwdPJ6I0YxGWSh3hIoQaVv+ER9SZ+8PiYiWK82xKybqOUc2cZ8n8T9L/RSSYxaVdh5FPh8qxNXfx5tE4TvxdJy+bTiw6bcPstBbzYQ0WKV/zl2wg7UGzpV4r2rOIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYHJJSrjkyI50lvKDCiuCQHVDSeMSuqrX1hWSMMcgKM=;
 b=w4L3ZlPZMB1y6K57qGV6oKDYqVY6PYDpS5vslN97rGcL1uJDYjKjZ3VnqpX8fXMtkOQOZfOF7spblntQ2VrrzwpcxauUlRqEwhvMUUSbmR/ZnvAgbFh0QJIC95nTf7LORh1FC27X1IVUzThCbiJB8RrsSgSK1o+EFC9Ovl1v26A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6899.namprd10.prod.outlook.com (2603:10b6:208:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 04:59:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6178.024; Wed, 15 Mar 2023
 04:59:44 +0000
Message-ID: <798a0151-8ce0-9199-2a6c-9efcae81b9c6@oracle.com>
Date:   Wed, 15 Mar 2023 12:59:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs-progs: fix btrfs filesystem usage on older kernels
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <88f58821cecf10db0fc419319cd26cb5bf56fa71.1678741088.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <88f58821cecf10db0fc419319cd26cb5bf56fa71.1678741088.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f5ef8d-2fb4-4bae-1550-08db251217f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ML7LZIR0KOSAVHoh0pMD6zn0tTUZ7/cB+aBmiY3qF7Ucl62LXWocS9jGT6LSAT5eb/rBpkLnfI6BW91gUWB5kFyE0dqC6KKH75eB07tZ9/uNaJ25MEVPMSDcstimwas5LGbbsuIckZtCwJJ5IQSM+1w2lzU48xv/w3+oxJimEvjAF9RwmPQhAyb4jCTxmol9BnI65gyvIR0f9CijgyDh7LOPOQjgSXa9+Lu85j86ZVR3nUMJuvmTzusuCkbh/VMiMuMpdsTwmM7It6o7IltoGP5wbG1QHR7BsadAjjtEyvY+CxdpTpONwR7LUvoxEaqUPDEOFiHQDPoewNUXJr7d0NEE2Av0sH9SI7ro0whGw5OQ0Ihp+NSykMOZUHWvuhc4VCvKlTRxAe+AioBpyfxlu4szK7nkOzLNa5Y2LJGwvuPKUHQ8qB/L0E8/VU6xwBsChOyHDmjtqx31rNKCFI4W62zHOIcEZbphF06eCdPczclsjRwSLhS2hBjTKxhTFDJk/TDXi89GaTEOn5scRZdvwCGMON8xLlnIDyp6D73evihBJ4liYqD/vYLRHsVVHvAJENeFgzXrTKtvPrlX1zYvO3biw05iHUef62PsfXGBWJzT6UFEPLGAJbiZR64JjubP8HlUDVzcu23IRxy2Hpm1Dmpmc3Ny8nPbttZvP91irs0V1gmzDXVKoXoLzjJZDw6jpPNTVRJ7yIUKHEUj6O0HYpELwzXcpHyumUSetNfNGX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199018)(31686004)(66899018)(5660300002)(8936002)(2616005)(186003)(53546011)(41300700001)(6506007)(26005)(6512007)(31696002)(86362001)(36756003)(2906002)(44832011)(83380400001)(8676002)(6486002)(478600001)(316002)(66476007)(6666004)(66556008)(66946007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNFNGxRN1JlckpMQS9SdWtxRkk0bTJ6SXJmRlIwazdlTGo3cS9EcWpqb2pm?=
 =?utf-8?B?eVRNSVBORm1zbWVTK05CT3VpTURiWHcxSXQrbTc0czc2WFRzc3gxTVZUd2s2?=
 =?utf-8?B?WmNGbGZ3cUtiaEhFZlBXZlR6UzlpcFdNaUx2WkZxdHdEa0l1NW5hWXlIQnRG?=
 =?utf-8?B?RUx1cUYwbFcvWkxzSHlkL0pPRlNNL2NjcGg0ejlidTd3c21aODgxQlV5ckV1?=
 =?utf-8?B?dng0UDljc1Y1V0lsdjBWRGpNZGMrMUE1Ky84NDRsY2NKQXh0MDVXUldCRGcx?=
 =?utf-8?B?em9mdXVab1VOREUyY1FoS0M4K2VmK1E5dzkydUx4T05EOU5pTUwzMUxhV3Ex?=
 =?utf-8?B?QzBPOWpBaU5jNzBnTFFCOStGTXNCWEpOMVFQelJ4b1NwbkZyZUpiRFROS29p?=
 =?utf-8?B?ZzRxL2dHcnlmYWlRZFdRcW5aMVFUV09LeHdtL2lPK096NFBwUnlYYkYrN3JD?=
 =?utf-8?B?ZG5WdW5XdFRUNjQyMFdBRmw3RlJ3M0dzQ0tTUGlsNzZpa0g1NjREdFRKd3Qr?=
 =?utf-8?B?WTExa1pwRVAwTnZweHFMT2krM1laUnFwaHgvZ0x1aXpxQjllL2Y1cTJ1MnFM?=
 =?utf-8?B?OE9TYXFrRjZHdzlBUEhSZlVjVVJzVlpqcmZ4UmdMblgvQmEwTjNEWWE2NGVu?=
 =?utf-8?B?MXhVNStKNHlPdktFYitjUmFyMjA3Zk8xN0hzS1VmMTlBbWIzRDErQjlDL3Va?=
 =?utf-8?B?UzB1cVF3RCsvNUpzVU1LZ1pNemxnenZINU8vQVZXcDltU1A1ZWpZMVIxSzJB?=
 =?utf-8?B?d0NrTHlZcE51U1JNQzdabTlwZ2tsaVcyaE8rWEJSZlBLS2dPczBCOWZTQ0NW?=
 =?utf-8?B?cFMyL2c2NytOdEUybTZ4dVBTNDV4YnY3VHlWNDdCVHV3eHlwL1orZ0xuc25R?=
 =?utf-8?B?RWpkQk9VYlpWSERlUUhZbkhrUmNGeHVnajdHOVcxSjJGRmxiN0djc3VPbGhq?=
 =?utf-8?B?Tmg4SlhiUlNHYVhQZmp1U2JOMzZzaUR0NTFhdEJRTVo0QnVIUk5MV0pwc0VM?=
 =?utf-8?B?TmZwdzgwVTBqNkIraXJwZFM3V2ZqQ21VWWRGVk1nelVLZU9yaVpTMmcySis1?=
 =?utf-8?B?QUlUZktyV1pUb2g3MGFWMWVEOGRPTzkwVUVwTWdDTjExNFp2eUpCellmdCtK?=
 =?utf-8?B?QXdBbDk1QXpwNUdjY2p2akhmd3hOSVI1T1NPUlZueFFVbW9DaTFFTGM1UFo1?=
 =?utf-8?B?MWoxRnJtblZPbkdCTmRHZ1ZWZXpZRFZpWnZVSGduNDZGTjhHVG9KR2pJcVJo?=
 =?utf-8?B?d1lTeENML2tsYWF4bUdWeGpvK0NRZ3NJcWhLRXZ2TU45U2JrdVozQ2NsU3dM?=
 =?utf-8?B?bW1ET1hTbFdKdHBkaVpxYVoxVzN4SmgwTFBORXNmbVJyUEJadWdhM0FiK21G?=
 =?utf-8?B?TmJjdTJjand2eFVjMlJOS05paE5RVVBnTHhpRnpvYVgvZTk2dUhLQVdnUHJu?=
 =?utf-8?B?R2luM2JkbzdoUVJxcTJqY0pTdUhvSjd0VVVuQURWQTJmQXh5RkF5MFcxbWZE?=
 =?utf-8?B?N2p1cGxSeWpxUHRQdHlCQ29qRlhROTJGdFZvTWF2YThlcHFscW1tM3hMWXFa?=
 =?utf-8?B?U2tIaTVoK0NuMU1JM3VjVjBwb2lrbkI3R1hMRnNPT1lCNEF4V2w0UlVERDF4?=
 =?utf-8?B?RmR2MXFPUW9UV2NwajZETG9rUHRZVGJsc3F3T2ZTVmlWZzI2R0ZXUllKMTE2?=
 =?utf-8?B?NG5EK2syeVZJN2xNcUFGSXhMMWhmRU0wMkY3RlBQR3NNM2hyMTlmQndmRDk5?=
 =?utf-8?B?L2xITHVzVW9zRGJOcWJtMEFmUXkzdnI2ajJLMmFyQkhTd3RQeTNveEhvdzQx?=
 =?utf-8?B?SjZLNkw2TWFMMEV6SHpJV05OWEc5SVIrUW5lUU5vYStRLzd3V3BDMDRWcTBG?=
 =?utf-8?B?WkpHQkt0Ykd4V0JrWUl0VkV4Z2JidSt4eVdKSkEycUc1SWxCTFo2VUpLUHlx?=
 =?utf-8?B?ZDY1akZNSEEyUGhYbFRtcytFOXlld1hDdWJsODlkVEIzUFFOSHlQWmk2R1lO?=
 =?utf-8?B?dzl2U1FQblc2bHpVdXQ2UjV4ZkhyTnYxM2tFbXNSOTdhWVg5S3lHaU9GMTM5?=
 =?utf-8?B?RjhxTi9zQ2RQcXJSNjczZW1CNDF2ZGw0Y2szMkhPRHlpOTN4Y1lvRkxqNDZh?=
 =?utf-8?Q?vkhL9uwngeiUR2Kn34rv89+Sj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6+xJw7NrRkzVWL3EUs1nOQkZbq+73uF0PzcivHwuI0hRYhDZdOaGmJy5MvzEhiAHbcxQnnWbJ/dCI7+C2oca2y93EcRcvRy2hpEKk0NhFBoS+xI6iunhykY7mXzNmFnfwaiULydJylKPyBr+3L37/+l4EcFe7ZJiFWi0sMej4hftkYsSy9f2Wl6BH3YvGZUmnPObTn2xMbdZw423RLm5AVWNmnG1vFePGAcymZi8hcIYcnNWdoirv2eotUqYSkQ6DvkKiEeAKYIwxX+ji9Ba6MIWfrNj4E7ibyNgd51wwhd2J5TRVcILSLFynJcamJvLFwIJKxNZ6kO7hlEZQymfR8JQIGWPUmRfEmh34MkLNCMCiASUcFkKCpgubdiRMey+9IK/WlvjXmGgqlf0O3cJj+JmICh/W8kpdMPJ+xVVczEEVo3l5HlN6rpLHlKGJq7uX+t4OBtk12OW6hIRz/j6Vv0yBtPvNr900aedfZnWt670ByEqZDzhUvvhkVLF3A4RmloS21+/8O5GOStRla8NhU6Hc8M5aoolyzIlJ666CxPyt5eHHmZm+slRmIBW3izhHNshLeUzfEAunUh4qhN8ygXJotAz+BXSatng3uyu8PvUUXPQAfhgRX3dxE8KiDA9jOb/469ZsMlIeVu3mfSGj0tsOBFRa/K8vJs1D+n5UZPhJI6vuIsjXBhItkmAozAlbzvpuTFLs072qJ0ZJ7njABq6Ubi+l2daqnsICGE9Yu7DG3WBHBKOicp1v8MPJxJrGYvvJ6DOTB/E9nIYPS69SVeF+/0ixupoLdozQNPeqiXzCfzT1ifh4Dz+suGlzzy0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f5ef8d-2fb4-4bae-1550-08db251217f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 04:59:44.8421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9G0xeaZr8mjgTKJ/bAprfFMsYxcO0rRzggxKLJS2wuYZDzQzDwiKlsbOfrP1jogiJjg5GDd3W6WeI/4meRhHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_02,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150043
X-Proofpoint-GUID: zrPZmWYJ_t8ynFSjqZ0SfljQ7MSqmUNd
X-Proofpoint-ORIG-GUID: zrPZmWYJ_t8ynFSjqZ0SfljQ7MSqmUNd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/14/23 04:58, Josef Bacik wrote:
> Commit 32c2e57c ("btrfs-progs: read fsid from the sysfs in
> device_is_seed") introduced a regression on older kernels where we don't
> have the fsid exported for devices in sysfs.  Being unable to open this
> file means that we don't get the device fsid and then fail to find any
> devices to show.  Fix this by dealing with an error from opening the
> sysfs file, which this patch we can now pass make test-mkfs on older
> kernels.
> 
> Fixes: 32c2e57c ("btrfs-progs: read fsid from the sysfs in device_is_seed")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thank you for fixing it. My bad.


> ---
>   cmds/filesystem-usage.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 57eec98c..45d4ea39 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -724,9 +724,7 @@ static int device_is_seed(int fd, const char *dev_path, u64 devid, const u8 *mnt
>   		fsid_str[BTRFS_UUID_UNPARSED_SIZE - 1] = 0;
>   		ret = uuid_parse(fsid_str, fsid);

To handle the uuid_parse() failure,...


>   		close(sysfs_fd);
> -	}
> -
> -	if (ret) {
> +	} else {
>   		ret = dev_to_fsid(dev_path, fsid);


>   		if (ret)
>   			return ret;

we need to move the corresponding code (above) outside of the else 
block, as shown below.

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 57eec98c077a..60266ca492a6 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -724,14 +724,13 @@ static int device_is_seed(int fd, const char 
*dev_path, u64 devid, const u8 *mnt
                 fsid_str[BTRFS_UUID_UNPARSED_SIZE - 1] = 0;
                 ret = uuid_parse(fsid_str, fsid);
                 close(sysfs_fd);
-       }
-
-       if (ret) {
+       } else {
                 ret = dev_to_fsid(dev_path, fsid);
-               if (ret)
-                       return ret;
         }

+       if (ret)
+               return ret;
+
         if (memcmp(mnt_fsid, fsid, BTRFS_FSID_SIZE) != 0)
                 return 0;




Thanks, Anand

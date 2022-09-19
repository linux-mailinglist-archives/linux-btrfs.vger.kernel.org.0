Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF85BCC32
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiISMxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiISMxh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:53:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC61E2E6A0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:53:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBx5Lj026370;
        Mon, 19 Sep 2022 12:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ESZNKkeVPTNpk4m/0qKeQOwUJhOGX99LmOF1HY0NFM4=;
 b=LBRoDNsTGwBPG/X9gEo96wk0/45M2iNP5+xZdGegeSk/5kl4yPA3ibTE0+HBVU0tk4O5
 VhbTdZNQ48xGnRxq70riI0eeokYdjgEqDwskVIbAmj2h2SsQseB6IpBFK61NOkYJMH2P
 sqoE4yKVNG48Tg2grd28GbLDO9n6CczUhU3j6BaRmgv3w0QPjHudVbdawLwvm5WrbJPl
 lp03MiTmlsB91WgQFeM3DWnI5XIh+6ES6bnalxC83lF5y9u7VAcFgfXUjKU4g0hLvGwm
 Sjf2reYPSoL1s2dKzRay/XUx0B3TATPHSdZwqz0qKen3xYW/9c5ovdCNI7PeJ0Yz3YAU TQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688bmj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:53:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JB2m9r010896;
        Mon, 19 Sep 2022 12:53:32 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39p4eut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVCeI5oZwsn0jaL1p/emUr33IaPl8bM9aF6jLf+tO/fcA6PrA5bo8rgUcAtHJvhHN4priEYEXnCA6KUpL7cq+r616aE7k/zpq1jyiAF2md2RfXxdVwfhRtlS7KE/IM0E+8vnZfMBLgXZ7+6DRCptDLfaBBdZbPpr9XCs+R+3s0fT2Td9EcigD72eLHmGS02jXG9BVgHDlKkdZsD3JfhZAS/pjW3sE6eQsRkd2R0qJF71GWJMUODAQi4FNp8LEGOcvqIymDowdqEujyfDsN2TxcScerinNZGSsyrUzxjkZA0Hbb8pIaUaTtrmzFcXddeT9W78iEmJHTYiqSy3tGinZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESZNKkeVPTNpk4m/0qKeQOwUJhOGX99LmOF1HY0NFM4=;
 b=Z9uq9ECzE9aM2rmCN3O8ynBeR7ZVApTAFjGO9hHVVkWhkW3PEWh0qSH0jFDSgThjhLNP8YvX+6HoSWV1hyTG5yh8WJI+9hZbuEGXCedvDJAOkayTUcECOu9G6RG5DGNdAPcUAJpy3NEaRUVjECOcAcimuznkLc3pcCDwbkjxRBBdxEsB4H3R56t62DUey6pNdbzQuGlfPAdSyhJ5Ut63WucTZzgRrur+0yNmfKuyNebzuz6hGgnaFjh9jtcQ8k4iVrPYs9IPyYeAbVFoBpRPsFBm/3zwpjaIgBvHXD/ZyyFLq4SNL6YvdXAvpg3Eve8Rhgb5CGD5ARwpy58V5Td3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESZNKkeVPTNpk4m/0qKeQOwUJhOGX99LmOF1HY0NFM4=;
 b=FIe70ftoi4qMHxNBx+8sVVIvw1qsVY4wDpAWDc2ZExkMWM94G6DuXvP1XwYJgkWOnEfNg75ydmJIXHlucq5GUW4q33qs+axvRoWCcfN83Sa14r3rC1yNzXTznRxsBsHXF0zBrzTiCiMwM6f6bmrmPypRdFsI5BGve6PZK39p0yI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5771.namprd10.prod.outlook.com (2603:10b6:510:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Mon, 19 Sep
 2022 12:53:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:53:30 +0000
Message-ID: <e8c39a01-9c1b-65fd-af58-0d831a08b888@oracle.com>
Date:   Mon, 19 Sep 2022 20:53:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 15/16] btrfs: move btrfs_map_token to item-accessors
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <980fa7926d0aa651c42a4ff4e58c0d644d712b7e.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <980fa7926d0aa651c42a4ff4e58c0d644d712b7e.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: ea46f1d1-838c-401b-7857-08da9a3df39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvSgwTbvpavp1p0KGMEvhOYFhHjG+1HeJkC/cFsqwrjiWDODM8DYpGmiz349Ei3/rQ2fqO7jImbkKUj61icZ6es0k1acUFj3+A/HfD87e5ikOf094tAA0tTX64tfPstRGbDFyEUTZ4NhCp8h6zT+748C5ujNKwA2x9h1wBKawXUp9N3FAcTkIMeCaZ1/Hr6l0P2uMe5P8RrULGvzVzobireOhawA9s6jbhF/tOjLC7DRTRFOvAOxZuZatIFImMxbmWgoDXIfvu8AX84opCinQtEzgbteERfKe+nzerbmjh8N1ZdQeI64AawTtyVE2OJVT8wfBAxptWLDEwtdR0jHewCoXtE9LFBvrQYj9N2i44qtUKtlAnTOwdBKfgcvuNr7uhwtLOxoOk52+bF6gE9itXOSfifr6BF3QU6KDnuFg5mTxQf3E/ieqJYxYp522UYe0CvX47zp3y5598D+C+gxknhrXH7t6uJT/xFmFQCCL58BaKvp/E5byvEBwzMkIeL1HKVzJEPhhbFVjXR1hYYYvUChRrtE5O/7tIPlr7kWmueDT9ZhjJWVwK2jaH7jmzMj+NwiHTOiOKz+1GOahvXGTi4qmwWwsuSnYM2d6napW6n0ChitdOLRQqJE6tKMpEtUZvT1NOrkabyz2rrfsBD/BwfUebxGtF78wGCujtcjNdFH0RoaAk4iLYkdEdsI2S2HDloroxcXqEsr2BOWxSoavjRoB3T5MBimHk7gcHel8630JM4cTcA3Zqh/WzjxucF5bozigAKZUxsa/n8yc0LAeROy+l4PmttHH35DKJQPLhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(31686004)(2616005)(6512007)(26005)(6506007)(53546011)(8676002)(2906002)(6486002)(31696002)(44832011)(86362001)(478600001)(36756003)(38100700002)(41300700001)(186003)(66946007)(83380400001)(6666004)(558084003)(8936002)(316002)(66556008)(66476007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGV2WFlWSW43N2V0dEFqR3o0a2pNcThya1BHWUZYeGxzakNrNnNMdnJnNE9k?=
 =?utf-8?B?QjhxcGQyM2tVTnhLWFNYTFljK1FwMTNybjFwZU5qVU5NbjF5dFZ3MWo5dldG?=
 =?utf-8?B?WXhkRHh4QjBOaVRtVWxiYXBYai93WnlMb1RDL1hYRm5tOTdlZGFoOFZvTU1y?=
 =?utf-8?B?T0VKZHlSZHh0Y2ZIMjROdHVGM3Y5NDZRMUxMaVAwaHFISUtSM1YvM3JZUENZ?=
 =?utf-8?B?Q0V4VFI0cEZLbmE2QXJhaG5pZTBXUTBDWUhDSmNYbTJ6L2h4cHVXZGluNDA5?=
 =?utf-8?B?OUUydytxeHQybHN1ZDdrZTBYVlE4VjI0SDFCQzBRVllFRTV6S3ExQ1Ezek9z?=
 =?utf-8?B?Ty9hS1dkdHFDYi9uY2JnUGNLRCtqSVVEK2tRYmhQMFU3NDdYZEw0S2FKeUp3?=
 =?utf-8?B?UjgzMlJOdjQvYlpKM293Z1IrdDV5ZVpja2R1dTlYYW5vOHZrbDM4VXYrcnNB?=
 =?utf-8?B?elovTUQ4dGtjYjExQ1BUYXUzQi94a2pmRHRzVEM4dXNQSEN4eUcrYjQveHRp?=
 =?utf-8?B?Z1NmQUQ5RkRvNW1VZGRwSi9DMUJQdXVScUw4dzhwTmVjamFtSEZEVi9wMU1U?=
 =?utf-8?B?a21ramptRXdJalB1dmpOSlM3eDF5dUcyeTVRNGVZRUoreVg4S3lVYlQ2WVh0?=
 =?utf-8?B?ckhKcjJueFUyT09CcUtaalI1dXBHSmlxaUw4NGI5T0FzcTh1S2RzVXNaZFJj?=
 =?utf-8?B?R21CNVkzS05JNDVrNFZqK0FJU0d0d2VUS284MkYrRlkyczNoa1ZCRUZ0a0dH?=
 =?utf-8?B?eXcrT2lXMTRQZVExV0Y4V3hCYXgrbTl4dXc1N1Z6bm1oSDJCM2tJeDF5Tm9w?=
 =?utf-8?B?aDJCdytqdzlLVExPYnN4T3RKNEVZWnJBam1LakloeEJPR1hkYjRSODdpQ3lu?=
 =?utf-8?B?dGVOdXZrdkJoTXNVT2dQUTNBTjBmeTFmME9EWEQ2VTR6OEZsV0lLcnBWMXJR?=
 =?utf-8?B?ZHhNUWxmeFBmc2F6cHlxNXJ5c1F1cDRZUXgweFZLRHlRNFBySUt2QnFjS2Jw?=
 =?utf-8?B?NHJBVjNReVZFek8rclJvUWVDKzV2cXR5ZmRsV0Jyck8xd0N3OWZJMXE5U1NC?=
 =?utf-8?B?OExrWFRsb3krUTlOaXNESTRWRzZ2dWNMRjJMUXpoVWpja3p4N2J2NG5QNko5?=
 =?utf-8?B?SXUyNi9BaVpuNXErcVd5TCtBWVp6S1pmUGtOUk1sRk4yNkNDNUROMG14em9K?=
 =?utf-8?B?SGxXSldnbHplSDJpV3VQYVZOYzFKUVQ0Z3RpWWtKekFMTnJRV0QvVXRhMUVM?=
 =?utf-8?B?MUNBVHYzSk1pUUhiSTc1Ynk3Q0w3aUxSV3ZKUXFYWkdEWFVmb09Kdzg2NHds?=
 =?utf-8?B?bmRQbDNacmRUblNwUjB4WE1mVTNhaEhJY1lhQXh0WHFZVWY0RTd3RUxqQ0xp?=
 =?utf-8?B?aDM3R1VlZ291ZG5nNEwvem9YVG9hOCs1VXltdGliUzNOalZXVnYydWdRbksr?=
 =?utf-8?B?N0VRSjYrRGRLR3A0YktmSnQ3NndRaUlqM0N1dGhNd2I2eWw1N2R0OG1VUmRv?=
 =?utf-8?B?bnhWMnJZUUxVeUdMS29QR2U1dEVpdUxDeXVUQ1c0d1lJVU5oSmRMNXkzYmFB?=
 =?utf-8?B?OEdBVGVMdElxWEpiTkxIelI0cjJTcXRLa0xDME53MTBxeG9xb2NJbDkyV3Mw?=
 =?utf-8?B?MU1ndm5iY0NHZGc3b0xlMWQyVmlBVWpCWWhkd0lJVERzYllyZHUwRHEwVndO?=
 =?utf-8?B?UHI1OEpqeXBjUy9WYS9xZXgzQlI4MnpZUUs0YU9hVzN6THlzekozVHdyaURh?=
 =?utf-8?B?OVVudlpkVE4rRmpGRzZzQk1MS1VCRFFkVEpXcHprWTlPL2xsRDdGVkdHK1Bx?=
 =?utf-8?B?S1I4NW9EL3pGbnFwRnVoT1RPR2VBWGFrdG44ZlJqanJmTGd5dnNNSUZWU3RM?=
 =?utf-8?B?a0xqWHZzZ0l6T2ozSnQ5dVdZQXJaQmNMdktmMGxOd0UvZW53cXF3UmoxRVpk?=
 =?utf-8?B?SXZlQjBOY2d6ci85M3gwTEZjRUxYTHdpZVRSZnpySFdzK1hrQzk4U04remdv?=
 =?utf-8?B?Q0ZlTU82VnRBRTJUMXR6UjIwZHBUM3pDaDhIVzBnWVZ2WVRYa0c2VXpDZ3VW?=
 =?utf-8?B?dm51SGtRc1FpWXBCQ0QzdkNjWnlxbHhVelM2cHQvcUVSSklybmIzZXJ0YTFu?=
 =?utf-8?B?eHRjamVzWlpZeEVSdzRpTW1GN3pWNzZtWllBMzFaSmNZVjZtY2Z3NjRXbDdI?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea46f1d1-838c-401b-7857-08da9a3df39f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:53:30.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+OxrWUHJ9dfCA/Uvo5e0mXpKlu3wE4BWDKi6yKxAyYU7gPVn4DMTwCd8+C4jGXpTfoF0v6P2fpxy/SFAq/iHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190087
X-Proofpoint-GUID: Ty6sJxZ8q4cOYcMqEDk45sjX0aCJG4MZ
X-Proofpoint-ORIG-GUID: Ty6sJxZ8q4cOYcMqEDk45sjX0aCJG4MZ
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/15/22 01:18, Josef Bacik wrote:
> This is specific to the item-accessor code, move it out of ctree.h into
> item-accessor.h/.c and then update the users to include the new header
> file.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
